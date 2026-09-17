package com.cubesofttech.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.UserRedeem;

@Repository
public class UserRedeemDAOImpl implements UserRedeemDAO {
	
	@Autowired
	SessionFactory sessionFactory;

	@Override
	public void save(UserRedeem userRedeem) throws Exception {
		sessionFactory.getCurrentSession().save(userRedeem);
		sessionFactory.getCurrentSession().flush();
	}

	@Override
	public void update(UserRedeem userRedeem) throws Exception {
		sessionFactory.getCurrentSession().update(userRedeem);
		sessionFactory.getCurrentSession().flush();
	}

	@Override
	public void delete(UserRedeem userRedeem) throws Exception {
		sessionFactory.getCurrentSession().delete(userRedeem);
		sessionFactory.getCurrentSession().flush();
	}

	@Override
	public UserRedeem findById(Integer userRedeemId) throws Exception {
		return sessionFactory.getCurrentSession().get(UserRedeem.class, userRedeemId);
	}

	@Override
	public List<UserRedeem> findAll() throws Exception {
		return sessionFactory.getCurrentSession().createQuery("from UserRedeem").list();
	}

}
