package com.cubesofttech.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.TokenUsageSummary;

@Repository
public class TokenUsageSummaryDAOImpl implements TokenUsageSummaryDAO {
	
	@Autowired
	SessionFactory sessionFactory;

	@Override
	public void save(TokenUsageSummary tokenUsageSummary) {
		sessionFactory.getCurrentSession().save(tokenUsageSummary);
		sessionFactory.getCurrentSession().flush();
	}

	@Override
	public void update(TokenUsageSummary tokenUsageSummary) {
		sessionFactory.getCurrentSession().update(tokenUsageSummary);
		sessionFactory.getCurrentSession().flush();
	}

	@Override
	public void delete(TokenUsageSummary tokenUsageSummary) {
		sessionFactory.getCurrentSession().delete(tokenUsageSummary);
		sessionFactory.getCurrentSession().flush();
	}

	@Override
	public TokenUsageSummary findById(Integer usage_summary_id) {
		return sessionFactory.getCurrentSession().get(TokenUsageSummary.class, usage_summary_id);
	}

	@Override
	public List<TokenUsageSummary> findAll() {
		return sessionFactory.getCurrentSession().createQuery("from TokenUsageSummary").list();
	}

	@Override
	public TokenUsageSummary findLatestByUserId(String userId) {
		
		String hql = "FROM TokenUsageSummary "
		           + "WHERE userId = :userId "
		           + "ORDER BY timeCreate DESC";

		return (TokenUsageSummary) sessionFactory.getCurrentSession()
		        .createQuery(hql)
		        .setParameter("userId", userId)
		        .setMaxResults(1)
		        .uniqueResult();
	}

}
