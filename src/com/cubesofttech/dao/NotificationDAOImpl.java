package com.cubesofttech.dao;

import java.sql.Timestamp;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
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
	public List<Notification> findByUserId(String userId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		Criteria criteria = session.createCriteria(Notification.class)
				.add(Restrictions.eq("userId", userId))
				.addOrder(Order.desc("timeCreate"));
		return criteria.list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Notification> findLatestByUserId(String userId, int maxResults) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		Criteria criteria = session.createCriteria(Notification.class)
				.add(Restrictions.eq("userId", userId))
				.addOrder(Order.desc("timeCreate"))
				.setMaxResults(maxResults);
		return criteria.list();
	}

	@Override
	public void markAllRead(String userId, String actorId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		Timestamp now = DateUtil.getCurrentTime();
		Query query = session.createQuery(
				"update Notification set isRead = true, userUpdate = :actorId, timeUpdate = :now "
						+ "where userId = :userId and isRead = false");
		query.setParameter("actorId", actorId);
		query.setParameter("now", now);
		query.setParameter("userId", userId);
		query.executeUpdate();
	}

}
