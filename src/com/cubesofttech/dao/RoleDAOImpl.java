package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.AliasToEntityMapResultTransformer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.Role;

@Repository
public class RoleDAOImpl implements RoleDAO{
    
    @Autowired
    private SessionFactory sessionFactory;
    
 
    @Override
    public void save(Role role) throws Exception{
        Session session = this.sessionFactory.getCurrentSession();
        session.save(role);
        session.flush();
        //session.close();
    }

    @Override
    public List<Role> findAll() throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        List<Role> list = null;
        try {
            list = session.createCriteria(Role.class).list();
        } catch (Exception e) {
            e.printStackTrace();
        }finally{
            //session.close();
        }        
        return list;
    }


    @Override
    public void update(Role role) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.clear();
        session.update(role);
        session.flush();
        //session.close();
    }

    @Override
    public void delete(Role role) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.delete(role);
        session.flush();
        //session.close();
    }

	@Override
	public List<Role> findByRoleId(String roleId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
        List<Role> list = null;
        try {
            
            Criteria cr = session.createCriteria(Role.class);
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
    public Role findById(String id) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        Role role = null;
        try {
            role = (Role) session.get(Role.class, id);
        } catch (Exception e) {
            e.printStackTrace();
        }finally{
            //session.close();
        }        
        return role;
    }
    
    @Override
	public List<Map<String, Object>> sequense() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> department_id = null;
		try {
			String sql = " SELECT id, CONCAT(id) "
					+ " FROM role  ORDER BY id ASC ";
			SQLQuery query = session.createSQLQuery(sql);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			department_id = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return department_id;
	}
    
    @Override
	public List<Map<String, Object>> sequense2() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> department_id = null;
		try {
			String sql = " SELECT id, CONCAT(id) ,name ,description "
					+ " FROM role  ORDER BY id ASC ";
			SQLQuery query = session.createSQLQuery(sql);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			department_id = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return department_id;
	}
    

}
