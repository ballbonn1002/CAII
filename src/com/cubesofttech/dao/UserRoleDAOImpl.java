package com.cubesofttech.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.UserRole;

@Repository
public class UserRoleDAOImpl implements UserRoleDAO{
    
    @Autowired
    private SessionFactory sessionFactory;
    
 
    @Override
    public void save(UserRole UserRole) throws Exception{
        Session session = this.sessionFactory.getCurrentSession();
        session.save(UserRole);
        session.flush();
        //session.close();
    }

    @Override
    public List<UserRole> findAll() throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        List<UserRole> userRole = null;
        try {
            userRole = session.createCriteria(UserRole.class).list();
        } catch (Exception e) {
            e.printStackTrace();
        }finally{
            //session.close();
        }        
        return userRole;
    }


    @Override
    public void update(UserRole userRole) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.clear();
        session.update(userRole);
        session.flush();
        //session.close();
    }

    @Override
    public void delete(UserRole userRole) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.delete(userRole);
        session.flush();
        //session.close();
    }

	@Override
	public List<UserRole> findByRoleId(String roleId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
        List<UserRole> list = null;
        try {
            
            Criteria cr = session.createCriteria(UserRole.class);
            cr.add(Restrictions.eq("roleId", roleId));
            list = cr.list();
  
        } catch (Exception e) {
        	e.printStackTrace();
        	return null;

        } finally {

        }
        return list;
	}
 
	@Override
	public List<UserRole> findByUserId(String userId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
        List<UserRole> list = null;
        try {
            
            Criteria cr = session.createCriteria(UserRole.class);
            cr.add(Restrictions.eq("userId", userId));
            list = cr.list();
  
        } catch (Exception e) {
        	e.printStackTrace();
        	return null;

        } finally {

        }
        return list;
	}	
	
}
