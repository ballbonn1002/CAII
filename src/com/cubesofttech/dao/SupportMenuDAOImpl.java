package com.cubesofttech.dao;

import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.SupportMenu;

@Repository
public class SupportMenuDAOImpl implements SupportMenuDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(SupportMenu supportMenu) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.save(supportMenu);
        session.flush();
    }

    @Override
    public void update(SupportMenu supportMenu) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.clear();
        session.update(supportMenu);
        session.flush();
    }

    @Override
    public void delete(SupportMenu supportMenu) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.clear();
        session.delete(supportMenu);
        session.flush();
    }

    @Override
    public SupportMenu findById(Integer supportMenuId) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        SupportMenu supportMenu = null;
        try {
            supportMenu = (SupportMenu) session.get(SupportMenu.class, supportMenuId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return supportMenu;
    }

    @Override
    public List<SupportMenu> findAll() throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        List<SupportMenu> supportMenuList = null;
        try {
            String hql = "SELECT s FROM SupportMenu s ORDER BY s.supportMenuId ASC";
            supportMenuList = session.createQuery(hql).list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return supportMenuList;
    }
}
