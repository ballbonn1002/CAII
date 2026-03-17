package com.cubesofttech.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Projections;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.ExpTravelType;

@Repository
public class ExpTravelTypeDAOImpl implements ExpTravelTypeDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(ExpTravelType travelType) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.save(travelType);
        session.flush();
    }

    @Override
    public List<ExpTravelType> findAll() throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        List<ExpTravelType> list = null;
        try {
            list = session.createCriteria(ExpTravelType.class).list();
        } catch (HibernateException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public ExpTravelType findById(Long expTravelTypeId) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        ExpTravelType obj = null;
        try {
            obj = (ExpTravelType) session.get(ExpTravelType.class, expTravelTypeId);
        } catch (HibernateException e) {
            e.printStackTrace();
        }
        return obj;
    }

    @Override
    public void update(ExpTravelType travelType) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.clear();
        session.update(travelType);
        session.flush();
    }

    @Override
    public void delete(ExpTravelType travelType) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.delete(travelType);
        session.flush();
    }

    @Override
    public Long getMaxId() throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        try {
            Criteria criteria = session.createCriteria(ExpTravelType.class)
                    .setProjection(Projections.max("expTravelTypeId"));
            Long maxId = (Long) criteria.uniqueResult();
            return (maxId == null) ? 0L : maxId;
        } catch (Exception e) {
            e.printStackTrace();
            return 0L;
        }
    }
}