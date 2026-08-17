package com.cubesofttech.dao;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Projections;
import org.hibernate.transform.AliasToEntityMapResultTransformer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.FileUpload;
import com.cubesofttech.model.PoParent;
import com.cubesofttech.model.User;

@Repository
public class PoParentDAOImpl implements PoParentDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public List<PoParent> findAll() throws Exception {
		Session session = sessionFactory.getCurrentSession();
		List<PoParent> poParent = null;
		try {
			poParent = session.createCriteria(PoParent.class).list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return poParent;
	}
	@Override
	public void save(PoParent PoParent) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.save(PoParent);
		session.flush();
		// session.close();
	}

	@Override
	public PoParent findById(Long poParentId) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		PoParent poParent = null;
		try {
			poParent = (PoParent) session.get(PoParent.class, poParentId);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return poParent;
		

	}
	
	@Override
	public Long getMaxId() throws Exception {
	    Session session = this.sessionFactory.getCurrentSession();
	    Long maxId = 0L;
	    try {
	        String sql = "SELECT MAX(CAST(po_parent_id AS UNSIGNED)) FROM po_parent";
	        SQLQuery query = session.createSQLQuery(sql);
	        Object result = query.uniqueResult();
	        if (result != null) {
	            maxId = ((Number) result).longValue();
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    }
	    return maxId;
	}
	
	@Override
	public void delete(PoParent PoParent) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.delete(PoParent);
		session.flush();
		// session.close();
	}
	
	@Override
	public void update(PoParent PoParent) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.clear();
		session.update(PoParent);
		session.flush();
		// session.close();
	}
	
	@Override
	public List<Map<String, Object>> findPoParentByPoDetailId(String poDetailId) throws Exception {

	    List<Map<String, Object>> poParentList = new ArrayList<>();

	    try {
	        Session session = sessionFactory.getCurrentSession();

	        String sql = "SELECT po.*, " +
	        		"uc.employee_id AS userEmployeeId, " +
	                "uc.name_en AS user_create_nameEN, " +
	                "uc.name AS user_create_name, " +
	                "uu.name_en AS user_update_name " +
	                "FROM po_parent po " +
	                "LEFT JOIN user uc ON po.user_create = uc.id " +
	                "LEFT JOIN user uu ON po.user_update = uu.id " +
	                "WHERE po.po_detail_id = :poDetailId";

	        SQLQuery query = session.createSQLQuery(sql);
	        query.setParameter("poDetailId", poDetailId);
	        query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

	        poParentList = query.list();

	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    }

	    return poParentList;
	}
	
	@Override
	public void deleteByPoDetailId(String poDetailId) throws Exception {
	    Session session = this.sessionFactory.getCurrentSession();
	    try {
	        String hql = "DELETE FROM PoParent WHERE poDetailId = :poDetailId";
	        Query query = session.createQuery(hql);
	        query.setParameter("poDetailId", poDetailId);
	        query.executeUpdate();
	        session.flush();
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    }
	}

	

}