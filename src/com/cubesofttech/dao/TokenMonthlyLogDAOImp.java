package com.cubesofttech.dao;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Calendar;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.TokenMonthlyLog;

@Repository
public class TokenMonthlyLogDAOImp implements TokenMonthlyLogDAO {
	
	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public void save(TokenMonthlyLog log) throws Exception {
		sessionFactory.getCurrentSession().save(log);
		sessionFactory.getCurrentSession().flush();
	}

	@Override
	public void update(TokenMonthlyLog log) throws Exception {
		sessionFactory.getCurrentSession().update(log);
		sessionFactory.getCurrentSession().flush();
	}

	@Override
	public void delete(TokenMonthlyLog log) throws Exception {
		sessionFactory.getCurrentSession().delete(log);
		sessionFactory.getCurrentSession().flush();
	}

	@Override
	public TokenMonthlyLog findById(Integer monitorLogId) throws Exception {
		return sessionFactory.getCurrentSession().get(TokenMonthlyLog.class, monitorLogId);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<TokenMonthlyLog> findAll() throws Exception {
		return sessionFactory.getCurrentSession().createQuery("from TokenMonthlyLog").list();
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<TokenMonthlyLog> findByYear(int year) throws Exception {
	    Session session = sessionFactory.getCurrentSession();

	    String hql = "FROM TokenMonthlyLog "
	               + "WHERE YEAR(dateTime) = :year "
	               + "ORDER BY dateTime desc";

	    return session.createQuery(hql)
	            .setParameter("year", year)
	            .list();
	}

}
