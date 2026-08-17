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
import com.cubesofttech.model.PoDetail;
import com.cubesofttech.model.User;

@Repository
public class PoDetailDAOImpl implements PoDetailDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public List<PoDetail> findAll() throws Exception {
		Session session = sessionFactory.getCurrentSession();
		List<PoDetail> poDetail = null;
		try {
			poDetail = session.createCriteria(PoDetail.class).list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return poDetail;
	}
	@Override
	public void save(PoDetail PoDetail) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.save(PoDetail);
		session.flush();
		// session.close();
	}

	@Override
	public PoDetail findById(String poDetailId) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		PoDetail poDetail = null;
		try {
			poDetail = (PoDetail) session.get(PoDetail.class, poDetailId);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return poDetail;
		

	}
	
	@Override
	public Long getMaxId() throws Exception {
	    Session session = this.sessionFactory.getCurrentSession();
	    Long maxId = 0L;
	    try {
	        String sql = "SELECT MAX(CAST(po_detail_id AS UNSIGNED)) FROM po_detail";
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
	public void delete(PoDetail PoDetail) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.delete(PoDetail);
		session.flush();
		// session.close();
	}
	
	@Override
	public void update(PoDetail PoDetail) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.clear();
		session.update(PoDetail);
		session.flush();
		// session.close();
	}
	
	@Override
	public List<Map<String, Object>> findPoDetailByPoId(String poId) throws Exception {

	    List<Map<String, Object>> poDetailList = new ArrayList<>();

	    try {
	        Session session = sessionFactory.getCurrentSession();

	        String sql = "SELECT po.*, " +
	                "  uc.name_en AS user_create_name, " +
	                "  uu.name_en AS user_update_name " +
	                "FROM po_detail po " +
	                "LEFT JOIN user uc ON po.user_create = uc.id " +
	                "LEFT JOIN user uu ON po.user_update = uu.id " +
	                "WHERE po.po_id = :poId";

	        SQLQuery query = session.createSQLQuery(sql);
	        query.setParameter("poId", poId);
	        query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

	        poDetailList = query.list();

	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    }

	    return poDetailList;
	}
	
	@Override
	public void deleteByPoIdAndPoDetailId(String poDetailId, String poId)  throws Exception {
	    Session session = this.sessionFactory.getCurrentSession();
	    try {
			String hql = "DELETE FROM PoDetail WHERE poDetailId = :poDetailId AND poId = :poId";
			Query query = session.createQuery(hql);
			query.setParameter("poDetailId", poDetailId);
			query.setParameter("poId", poId);
			query.executeUpdate();
			session.flush();
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    }
	}
	
	@Override
	public double getTotalByPoId(String poId) throws Exception {
	    Session session = this.sessionFactory.getCurrentSession();
	    double total = 0d;
	    try {
	        String sql = "SELECT SUM(price_total) FROM po_detail WHERE po_id = :poId";
	        SQLQuery query = session.createSQLQuery(sql);
	        query.setParameter("poId", poId);
	        Object result = query.uniqueResult();
	        if (result != null) {
	            total = ((Number) result).doubleValue();
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    }
	    return total;
	}
	

}