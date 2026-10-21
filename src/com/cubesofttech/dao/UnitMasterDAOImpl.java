package com.cubesofttech.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.transform.AliasToEntityMapResultTransformer;
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

    @Override
    public UnitMaster findById(Integer unitMasterId) throws Exception {
        if (unitMasterId == null) {
            return null;
        }
        Session session = this.sessionFactory.getCurrentSession();
        return (UnitMaster) session.get(UnitMaster.class, unitMasterId);
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> findAllWithUsageCount() throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        String sql = "SELECT um.unit_master_id AS unitMasterId, um.unit_name AS unitName, "
                + "(SELECT COUNT(*) FROM unit_of_measure uom WHERE uom.unit_master_id = um.unit_master_id) AS usageCount "
                + "FROM unit_master um "
                + "ORDER BY um.unit_name ASC";

        SQLQuery query = session.createSQLQuery(sql);
        query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
        List<Map<String, Object>> rows = query.list();
        return rows != null ? rows : new ArrayList<Map<String, Object>>();
    }

    @Override
    public void update(UnitMaster unitMaster) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.update(unitMaster);

        // sync ชื่อไปยัง unit_of_measure.unit_name (denormalized copy) ของทุกแถวที่ผูกกับ unit_master นี้
        // ไม่งั้นหน้า Product Edit จะยังโชว์ชื่อเก่าอยู่ทั้งที่ unit_master เปลี่ยนแล้ว
        Query syncQuery = session.createQuery(
                "update UnitOfMeasure set unitName = :unitName where unitMasterId = :unitMasterId");
        syncQuery.setParameter("unitName", unitMaster.getUnitName());
        syncQuery.setParameter("unitMasterId", unitMaster.getUnitMasterId());
        syncQuery.executeUpdate();

        session.flush();
    }

    @Override
    public boolean existsByNameExcludingId(String unitName, Integer excludeId) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createQuery(
                "select count(*) from UnitMaster where unitName = :unitName and unitMasterId != :excludeId");
        query.setParameter("unitName", unitName);
        query.setParameter("excludeId", excludeId);
        Long count = (Long) query.uniqueResult();
        return count != null && count > 0;
    }
}
