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

	@Override
	public List<Map<String, Object>> search(String userId, String startDate, String endDate) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> result = null;
		try {
			StringBuilder sql = new StringBuilder();
			sql.append("SELECT la.log_action_id, la.log_data, la.user_create, la.time_create, ");
			sql.append("u.name, u.name_en, u.employee_id, u.path ");
			sql.append("FROM log_action la ");
			sql.append("LEFT JOIN user u ON u.id = la.user_create ");
			sql.append("WHERE 1=1 ");

			if (userId != null && !userId.trim().isEmpty() && !userId.trim().equalsIgnoreCase("All")) {
				sql.append("AND la.user_create = :userId ");
			}
			if (startDate != null && !startDate.trim().isEmpty()) {
				sql.append("AND DATE(la.time_create) >= :startDate ");
			}
			if (endDate != null && !endDate.trim().isEmpty()) {
				sql.append("AND DATE(la.time_create) <= :endDate ");
			}
			sql.append("ORDER BY la.time_create DESC");

			SQLQuery query = session.createSQLQuery(sql.toString());
			if (userId != null && !userId.trim().isEmpty() && !userId.trim().equalsIgnoreCase("All")) {
				query.setParameter("userId", userId);
			}
			if (startDate != null && !startDate.trim().isEmpty()) {
				query.setParameter("startDate", startDate);
			}
			if (endDate != null && !endDate.trim().isEmpty()) {
				query.setParameter("endDate", endDate);
			}
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			result = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}
