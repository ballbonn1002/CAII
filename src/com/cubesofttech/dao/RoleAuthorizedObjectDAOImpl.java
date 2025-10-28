package com.cubesofttech.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.AliasToEntityMapResultTransformer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.Role;
import com.cubesofttech.model.RoleAuthorizedObject;
import com.cubesofttech.model.RoleAuthorizedObjectPK;

@Repository
public class RoleAuthorizedObjectDAOImpl implements RoleAuthorizedObjectDAO{
    
    @Autowired
    private SessionFactory sessionFactory;
    
 
//    @Override
//    public void save(RoleAuthorizedObject RoleAuthorizedObject) throws Exception{
//        Session session = this.sessionFactory.getCurrentSession();
//        session.save(RoleAuthorizedObject);
//        session.flush();
//        //session.close();
//    }

//    @Override
//    public List<RoleAuthorizedObject> findAll() throws Exception {
//        Session session = this.sessionFactory.getCurrentSession();
//        List<RoleAuthorizedObject> roleAuthorizedObject = null;
//        try {
//            roleAuthorizedObject = session.createCriteria(RoleAuthorizedObject.class).list();
//        } catch (Exception e) {
//            e.printStackTrace();
//        }finally{
//            //session.close();
//        }        
//        return roleAuthorizedObject;
//    }


//    @Override
//    public void update(RoleAuthorizedObject roleAuthorizedObject) throws Exception {
//        Session session = this.sessionFactory.getCurrentSession();
//        session.clear();
//        session.update(roleAuthorizedObject);
//        session.flush();
//        //session.close();
//    }

//    @Override
//    public void delete(RoleAuthorizedObject roleAuthorizedObject) throws Exception {
//        Session session = this.sessionFactory.getCurrentSession();
//        session.delete(roleAuthorizedObject);
//        session.flush();
//        //session.close();
//    }

	@Override
	public List<RoleAuthorizedObject> findByRoleId(String roleId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
        List<RoleAuthorizedObject> list = null;
        try {
            
            Criteria cr = session.createCriteria(RoleAuthorizedObject.class);
            cr.add(Restrictions.eq("roleId", roleId));
            list = cr.list();
  
        } catch (Exception e) {
        	e.printStackTrace();
        	return null;

        } finally {

        }
        return list;
	}
	
//    @Override
//    public int deleteByRoleId(String roleId) throws Exception {
//    	Session session = this.sessionFactory.getCurrentSession();
//    	int updated = 0;
//        List<Role> list = null;
//        try {
//        	Query deleteQuery = session.createSQLQuery(
//        		    "delete from role_authorized_object "
//        		    + "where role_id = ? ");
//        		deleteQuery.setString(0, roleId);
//        		updated = deleteQuery.executeUpdate();
//        } catch (Exception e) {
//        	e.printStackTrace();
//
//        } finally {
//
//        }
//		return updated;
//    }

	@Override
	public List<RoleAuthorizedObject> findLeaveViewAllByRoleId(String roleId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
        List<RoleAuthorizedObject> role_authorized = null;
        try {
            String sql = "SELECT * FROM `role_authorized_object` WHERE role_id = :roleId AND authorized_object_id = 'leave.viewall' ";
            SQLQuery query = session.createSQLQuery(sql);
            query.setParameter("roleId", roleId);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			role_authorized = query.list();
  
        } catch (Exception e) {
        	e.printStackTrace();
        	return null;

        } finally {

        }
        return role_authorized;
	}   

//	@Override
//	public RoleAuthorizedObject findByRoleIdAndAuthorizedObjectId(String roleId, String authorizedObjectId) throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		Criteria criteria = session.createCriteria(RoleAuthorizedObject.class);
//		RoleAuthorizedObject roleAuthorizedObject = (RoleAuthorizedObject) criteria
//				.add(Restrictions.eq("id.roleId", roleId))
//				.add(Restrictions.eq("id.authorizedObjectId", authorizedObjectId))
//				.uniqueResult();
//		return roleAuthorizedObject;
//	}
    
}
