package com.cubesofttech.dao;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.ExpType;

@Repository
public class ExpTypeDAOImpl implements ExpTypeDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(ExpType expType) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.save(expType);
        session.flush();
    }

    @Override
    public List<ExpType> findAll() throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        List<ExpType> list = null;
        try {
            list = session.createCriteria(ExpType.class).list();
        } catch (HibernateException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public ExpType findById(String expTypeId) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        ExpType obj = null;
        try {
            obj = (ExpType) session.get(ExpType.class, expTypeId);
        } catch (HibernateException e) {
            e.printStackTrace();
        }
        return obj;
    }

    @Override
    public void update(ExpType expType) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.clear();
        session.update(expType);
        session.flush();
    }

    @Override
    public void delete(ExpType expType) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.delete(expType);
        session.flush();
    }
}