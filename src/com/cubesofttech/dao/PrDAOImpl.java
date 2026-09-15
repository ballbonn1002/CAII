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
import com.cubesofttech.model.Pr;
import com.cubesofttech.model.User;

@Repository
public class PrDAOImpl implements PrDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public List<Pr> findAll() throws Exception {
		Session session = sessionFactory.getCurrentSession();
		List<Pr> pr = null;
		try {
			pr = session.createCriteria(Pr.class).list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return pr;
	}
	@Override
	public void save(Pr Pr) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.save(Pr);
		session.flush();
		// session.close();
	}

	@Override
	public Pr findById(String prId) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		Pr pr = null;
		try {
			pr = (Pr) session.get(Pr.class, prId);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return pr;
		

	}
	
	@Override
	public Long getMaxId() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		Long maxId = 0L;
		try {

			Criteria criteria = session.createCriteria(Pr.class).setProjection(Projections.max("prId"));
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
	public void delete(Pr Pr) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.delete(Pr);
		session.flush();
		// session.close();
	}
	
	@Override
	public void update(Pr Pr) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.clear();
		session.update(Pr);
		session.flush();
		// session.close();
	}
	
	@Override
	public List<Map<String, Object>> findAllPrWithUser() throws Exception {
		Session session = sessionFactory.getCurrentSession();
		List<Map<String, Object>> prList = null;
		try {
			String sql =
				"SELECT pr.*, " +
				" uc.name_en AS user_create_name, " +
				" uu.name_en AS user_update_name, " +
				" ds.status_name AS status_name, " +
				" ds.color AS status_color, " +
				" (SELECT COUNT(*) " +
				" FROM pr_detail pd " +
				" WHERE pd.pr_id = pr.pr_id) AS detail_count, " +
				" (SELECT COUNT(DISTINCT ppar.mr_id) " +
				" FROM pr_detail pd " +
				" LEFT JOIN pr_parent ppar ON ppar.pr_detail_id = pd.pr_detail_id " +
				" WHERE pd.pr_id = pr.pr_id " +
				" AND ppar.mr_id IS NOT NULL AND ppar.mr_id != '') AS mr_ref_count " +
				"FROM pr pr " +
				"LEFT JOIN user uc ON pr.user_create = uc.id " +
				"LEFT JOIN user uu ON pr.user_update = uu.id " +
				"LEFT JOIN doc_status ds ON ds.status_code = pr.status AND ds.page = 'pr' " +
				"ORDER BY pr.time_create DESC";

			SQLQuery query = session.createSQLQuery(sql);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			prList = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {

		}

		return prList;
	}
	
	@Override
	public Map<String, Object> findPrById(String prId) throws Exception {
		try {
			Session session = sessionFactory.getCurrentSession();

			String sql = "SELECT pr.*, " +
					" uc.name_en AS user_create_name, " +
					" uu.name_en AS user_update_name, " +
					" ds.status_name AS status_name " +
					" ds.color AS status_color, " +
					"FROM pr pr " +
					"LEFT JOIN user uc ON pr.user_create = uc.id " +
					"LEFT JOIN user uu ON pr.user_update = uu.id " +
					"LEFT JOIN doc_status ds ON ds.status_code = pr.status AND ds.page = 'pr' " +
					"WHERE pr.pr_id = :prId";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("prId", prId);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

			return (Map<String, Object>) query.uniqueResult();

		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public String findMaxPrIdByYear(String prefix) throws Exception {
	    Session session = sessionFactory.getCurrentSession();
	    String maxPrId = null;
	    try {
	        String sql = "SELECT MAX(pr_id) FROM pr WHERE pr_id LIKE :prefix";
	        SQLQuery query = session.createSQLQuery(sql);
	        query.setParameter("prefix", prefix);
	        Object result = query.uniqueResult();
	        if (result != null) {
	            maxPrId = result.toString();
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    }
	    return maxPrId;
	}
	

	

}