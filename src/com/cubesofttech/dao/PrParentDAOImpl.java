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
import com.cubesofttech.model.PrParent;
import com.cubesofttech.model.User;

@Repository
public class PrParentDAOImpl implements PrParentDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public List<PrParent> findAll() throws Exception {
		Session session = sessionFactory.getCurrentSession();
		List<PrParent> PrParent = null;
		try {
			PrParent = session.createCriteria(PrParent.class).list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return PrParent;
	}
	@Override
	public void save(PrParent PrParent) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.save(PrParent);
		session.flush();
		// session.close();
	}

	@Override
	public PrParent findById(Long PrParentId) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		PrParent PrParent = null;
		try {
			PrParent = (PrParent) session.get(PrParent.class, PrParentId);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return PrParent;
		

	}
	
	@Override
	public Long getMaxId() throws Exception {
	    Session session = this.sessionFactory.getCurrentSession();
	    Long maxId = 0L;
	    try {
	        String sql = "SELECT MAX(CAST(pr_parent_id AS UNSIGNED)) FROM pr_parent";
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
	public void delete(PrParent PrParent) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.delete(PrParent);
		session.flush();
		// session.close();
	}
	
	@Override
	public void update(PrParent PrParent) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.clear();
		session.update(PrParent);
		session.flush();
		// session.close();
	}
	
	@Override
	public List<Map<String, Object>> findPrParentByPrDetailId(String prDetailId) throws Exception {

	    List<Map<String, Object>> PrParentList = new ArrayList<>();

	    try {
	        Session session = sessionFactory.getCurrentSession();

	        String sql = "SELECT pr.*, " +
	        		"uc.employee_id AS userEmployeeId, " +
	                "uc.name_en AS user_create_nameEN, " +
	                "uc.name AS user_create_name, " +
	                "uu.name_en AS user_update_name " +
	                "FROM pr_parent pr " +
	                "LEFT JOIN user uc ON pr.user_create = uc.id " +
	                "LEFT JOIN user uu ON pr.user_update = uu.id " +
	                "WHERE pr.pr_detail_id = :prDetailId";

	        SQLQuery query = session.createSQLQuery(sql);
	        query.setParameter("prDetailId", prDetailId);
	        query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

	        PrParentList = query.list();

	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    }

	    return PrParentList;
	}
	
	@Override
	public void deleteByPrDetailId(String prDetailId) throws Exception {
	    Session session = this.sessionFactory.getCurrentSession();
	    try {
	        String hql = "DELETE FROM PrParent WHERE prDetailId = :prDetailId";
	        Query query = session.createQuery(hql);
	        query.setParameter("prDetailId", prDetailId);
	        query.executeUpdate();
	        session.flush();
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    }
	}

	

}