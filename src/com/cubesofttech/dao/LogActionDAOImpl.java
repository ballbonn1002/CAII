package com.cubesofttech.dao;

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

import com.cubesofttech.model.LogAction;

@Repository
public class LogActionDAOImpl implements LogActionDAO{

	@Autowired
	private SessionFactory sessionFactory;
	
	@Override
	public void save(LogAction logAction) throws Exception {
		// TODO Auto-generated method stub
		Session session = this.sessionFactory.getCurrentSession();
		session.save(logAction);
		session.flush();
	}

	@Override
	public void update(LogAction logAction) throws Exception {
		// TODO Auto-generated method stub
		Session session = this.sessionFactory.getCurrentSession();
		session.clear();
		session.update(logAction);
		session.flush();
	}

	@Override
	public void delete(LogAction logAction) throws Exception {
		// TODO Auto-generated method stub
		Session session = this.sessionFactory.getCurrentSession();
		session.delete(logAction);
		session.flush();
	}
	
	@Override
	public Integer getMaxId() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		Integer maxId = 0;

		try {

			Criteria criteria = session.createCriteria(LogAction.class).setProjection(Projections.max("logActionId"));
			maxId = (Integer) criteria.uniqueResult();

		} catch (Exception e) {
			e.printStackTrace();
			return new Integer(0);

		} finally {

		}
		if (maxId != null) {
			return maxId;
		} else {
			return new Integer(0);
		}
	}
	
	@Override
	public LogAction findById(Integer logActionId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		LogAction logAction = null;
		try {
			logAction = session.get(LogAction.class, logActionId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return logAction;
	}
	
	@Override
	public List<Map<String, Object>> findByUserAndDate(String user, String date) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> logAction = null;
		try {
			String sql = "SELECT * FROM log_action l WHERE l.user_create = :user AND l.time_create LIKE :date";
			
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("user", user);
		    query.setParameter("date", date);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			logAction = query.list();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	    return logAction;
	}
	
	@Override
	public void delete2YearLogs() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		try {
			String sql = "DELETE FROM log_action WHERE time_create < DATE_SUB(NOW(), INTERVAL 2 YEAR) LIMIT 5000";
			
			session.createSQLQuery(sql).executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
