package com.cubesofttech.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.UnitMaster;
import com.cubesofttech.util.DateUtil;

@Repository
public class UnitMasterDAOImpl implements UnitMasterDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    @SuppressWarnings("unchecked")
    public List<String> findAllNames() throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        String sql = "SELECT unit_name FROM unit_master ORDER BY unit_name ASC";

        SQLQuery query = session.createSQLQuery(sql);
        List<String> names = query.list();
        return names != null ? names : new ArrayList<String>();
    }

    @Override
    public UnitMaster findOrCreateByName(String unitName, String userCreate) throws Exception {
        String name = unitName != null ? unitName.trim() : "";
        Session session = this.sessionFactory.getCurrentSession();

        Query query = session.createQuery("from UnitMaster where unitName = :unitName");
        query.setParameter("unitName", name);
        query.setMaxResults(1);
        UnitMaster existing = (UnitMaster) query.uniqueResult();
        if (existing != null) {
            return existing;
        }

        UnitMaster master = new UnitMaster();
        master.setUnitName(name);
        // user_create / time_create เป็น NOT NULL ต้องตั้งเสมอตอนสร้างแถวใหม่
        master.setUserCreate(userCreate);
        master.setTimeCreate(DateUtil.getCurrentTime());
        session.save(master);
        // OpenSessionInViewFilter ตั้ง flush mode = MANUAL ต้อง flush เองไม่งั้นไม่ลง DB
        session.flush();

        return master;
    }
}
