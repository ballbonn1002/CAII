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
import com.cubesofttech.model.Po;
import com.cubesofttech.model.User;

@Repository
public class PoDAOImpl implements PoDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public List<Po> findAll() throws Exception {
		Session session = sessionFactory.getCurrentSession();
		List<Po> po = null;
		try {
			po = session.createCriteria(Po.class).list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return po;
	}
	@Override
	public void save(Po Po) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.save(Po);
		session.flush();
		// session.close();
	}

	@Override
	public Po findById(String poId) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		Po po = null;
		try {
			po = (Po) session.get(Po.class, poId);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return po;
		

	}
	
	@Override
	public Long getMaxId() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		Long maxId = 0L;
		try {

			Criteria criteria = session.createCriteria(Po.class).setProjection(Projections.max("poId"));
			maxId = (Long) criteria.uniqueResult();

		} catch (Exception e) {
			e.printStackTrace();
			maxId = new Long(0);

		} finally {

		}
		if (maxId != null) {
			return maxId;
		} else {
			return new Long(0);
		}
	}
	
	@Override
	public void delete(Po Po) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.delete(Po);
		session.flush();
		// session.close();
	}
	
	@Override
	public void update(Po Po) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.clear();
		session.update(Po);
		session.flush();
		// session.close();
	}
	
	@Override
	public List<Map<String, Object>> findAllPoWithUser() throws Exception {
		Session session = sessionFactory.getCurrentSession();
		List<Map<String, Object>> poList = null;
		try {
			String sql =
				    "SELECT po.*, " +
				    " uc.name_en AS user_create_name, " +
				    " uu.name_en AS user_update_name, " +
				    " (SELECT COUNT(*) " +
				    " FROM po_detail pd " +
				    " WHERE pd.po_id = po.po_id) AS detail_count " +
				    "FROM po po " +
				    "LEFT JOIN user uc ON po.user_create = uc.id " +
				    "LEFT JOIN user uu ON po.user_update = uu.id " +
				    "ORDER BY po.po_id ASC";

			SQLQuery query = session.createSQLQuery(sql);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			poList = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {

		}

		return poList;
	}
	
	@Override
	public Map<String, Object> findPoById(String poId) throws Exception {
	    try {
	        Session session = sessionFactory.getCurrentSession();

	        String sql = "SELECT po.*, " +
	                "       uc.name_en AS user_create_name, " +
	                "       uu.name_en AS user_update_name " +
	                "FROM po po " +
	                "LEFT JOIN user uc ON po.user_create = uc.id " +
	                "LEFT JOIN user uu ON po.user_update = uu.id " +
	                "WHERE po.po_id = :poId";

	        SQLQuery query = session.createSQLQuery(sql);
	        query.setParameter("poId", poId);
	        query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

	        return (Map<String, Object>) query.uniqueResult();

	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    }
	}
	
	@Override
	public String findMaxPoIdByYear(String prefix) throws Exception {
	    Session session = sessionFactory.getCurrentSession();
	    String maxPoId = null;
	    try {
	        String sql = "SELECT MAX(po_id) FROM po WHERE po_id LIKE :prefix";
	        SQLQuery query = session.createSQLQuery(sql);
	        query.setParameter("prefix", prefix);
	        Object result = query.uniqueResult();
	        if (result != null) {
	            maxPoId = result.toString();
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    }
	    return maxPoId;
	}
	

	

}