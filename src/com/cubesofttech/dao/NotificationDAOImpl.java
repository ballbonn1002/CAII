package com.cubesofttech.dao;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.AliasToEntityMapResultTransformer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.Notification;
import com.cubesofttech.util.DateUtil;

@Repository
public class NotificationDAOImpl implements NotificationDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public void save(Notification notification) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.save(notification);
		session.flush();
	}

	@Override
	public void update(Notification notification) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.update(notification);
		session.flush();
	}

	@Override
	public Notification findById(int id) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		return (Notification) session.get(Notification.class, id);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String, Object>> findByUserId(String userId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();

		String sql = "SELECT n.id AS id, n.title AS title, n.function_id AS functionId, n.message AS message, "
				+ "n.description AS description, n.is_read AS isRead, n.send_to As sendTo, n.user_id AS userId, n.type_sending AS typeSending, "
				+ "n.user_create AS userCreate, n.user_update AS userUpdate, "
				+ "n.time_create AS timeCreate, n.time_update AS timeUpdate, "
				+ "CASE WHEN n.title = 'Announcement' THEN a.topic ELSE NULL END AS topic, "
				+ "CASE WHEN n.title = 'Announcement' THEN a.detail ELSE NULL END AS detail "
				+ "FROM notification n "
				+ "LEFT JOIN announcement a ON a.announcement_id = n.function_id "
				+ "WHERE n.send_to = :userId "
				+ "ORDER BY n.time_create DESC ";

		SQLQuery query = session.createSQLQuery(sql);
		query.setParameter("userId", userId);
		query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

		return query.list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String, Object>> findLatestByUserId(String userId, int maxResults) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();

		String sql = "SELECT n.id AS id, n.title AS title, n.function_id AS functionId, n.message AS message, "
				+ "n.description AS description, n.is_read AS isRead, n.send_to As sendTo, n.user_id AS userId, n.type_sending AS typeSending, "
				+ "n.user_create AS userCreate, n.user_update AS userUpdate, "
				+ "n.time_create AS timeCreate, n.time_update AS timeUpdate, "
				+ "CASE WHEN n.title = 'Announcement' THEN a.topic ELSE NULL END AS topic, "
				+ "CASE WHEN n.title = 'Announcement' THEN a.detail ELSE NULL END AS detail "
				+ "FROM notification n "
				+ "LEFT JOIN announcement a ON a.announcement_id = n.function_id "
				+ "WHERE n.send_to = :userId "
				+ "ORDER BY n.time_create DESC "
				+ "LIMIT :maxResults";

		SQLQuery query = session.createSQLQuery(sql);
		query.setParameter("userId", userId);
		query.setParameter("maxResults", maxResults);
		query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

		return query.list();
	}

	@Override
	public void markAllRead(String userId, String actorId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		Timestamp now = DateUtil.getCurrentTime();
		Query query = session.createQuery(
				"update Notification set isRead = true, userUpdate = :actorId, timeUpdate = :now "
						+ "where sendTo = :userId and isRead = false");
		query.setParameter("actorId", actorId);
		query.setParameter("now", now);
		query.setParameter("userId", userId);
		query.executeUpdate();
	}

}
