package com.cubesofttech.dao;

import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.SupportDetail;

@Repository
public class SupportDetailDAOImpl implements SupportDetailDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(SupportDetail supportDetail) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.save(supportDetail);
        session.flush();
    }

    @Override
    public void update(SupportDetail supportDetail) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.clear();
        session.update(supportDetail);
        session.flush();
    }

    @Override
    public void delete(SupportDetail supportDetail) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.clear();
        session.delete(supportDetail);
        session.flush();
    }

    @Override
    public SupportDetail findById(Integer supportDetailId) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        SupportDetail supportDetail = null;
        try {
            supportDetail = (SupportDetail) session.get(SupportDetail.class, supportDetailId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return supportDetail;
    }

    @Override
    public List<SupportDetail> findAll() throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        List<SupportDetail> supportDetailList = null;
        try {
            String hql = "SELECT s FROM SupportDetail s ORDER BY s.timeCreate ASC";
            supportDetailList = session.createQuery(hql).list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return supportDetailList;
    }
    @Override
    public List<SupportDetail> findBySupportId(String supportId) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        List<SupportDetail> supportDetailList = null;
        try {
            String hql = "SELECT s FROM SupportDetail s WHERE s.supportId = :supportId ORDER BY s.timeCreate ASC";
            org.hibernate.Query query = session.createQuery(hql);
            query.setParameter("supportId", supportId);
            supportDetailList = query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return supportDetailList;
    }
}
