package com.cubesofttech.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.AuthorizedObject;

@Repository
public class AuthorizedObjectDAOImpl implements AuthorizedObjectDAO{
    
    @Autowired
    private SessionFactory sessionFactory;
    
 
//    @Override
//    public void save(AuthorizedObject AuthorizedObject) throws Exception{
//        Session session = this.sessionFactory.getCurrentSession();
//        session.save(AuthorizedObject);
//        session.flush();
//        //session.close();
//    }

    @Override
    public List<AuthorizedObject> findAll() throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        List<AuthorizedObject> authorizedObjectList = null;
        try {
            Criteria criteria=session.createCriteria(AuthorizedObject.class);
            criteria.addOrder(Order.asc("authorizedObjectId"));
        	authorizedObjectList = criteria.list();
            
        } catch (Exception e) {
            e.printStackTrace();
        }finally{
            //session.close();
        }        
        return authorizedObjectList;
    }

//    @Override
//    public void update(AuthorizedObject authorizedObject) throws Exception {
//        Session session = this.sessionFactory.getCurrentSession();
//        session.clear();
//        session.update(authorizedObject);
//        session.flush();
//        //session.close();
//    }
//
//    @Override
//    public void delete(AuthorizedObject authorizedObject) throws Exception {
//        Session session = this.sessionFactory.getCurrentSession();
//        session.delete(authorizedObject);
//        session.flush();
//        //session.close();
//    }
//
//    @Override
//    public AuthorizedObject findById(String id) throws Exception {
//        Session session = this.sessionFactory.getCurrentSession();
//        AuthorizedObject ao = null;
//        try {
//        	ao = (AuthorizedObject) session.get(AuthorizedObject.class, id);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }finally{
//            //session.close();
//        }        
//        return ao;
//    }
    
}
