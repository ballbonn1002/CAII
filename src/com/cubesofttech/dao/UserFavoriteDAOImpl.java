package com.cubesofttech.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.UserFavorite;

@Repository
public class UserFavoriteDAOImpl implements UserFavoriteDAO {
	
	@Autowired
	SessionFactory sessionFactory;

	@Override
	public void save(UserFavorite userFavorite) throws Exception {
		sessionFactory.getCurrentSession().save(userFavorite);
		sessionFactory.getCurrentSession().flush();
	}

	@Override
	public void update(UserFavorite userFavorite) throws Exception {
		sessionFactory.getCurrentSession().update(userFavorite);
		sessionFactory.getCurrentSession().flush();
	}

	@Override
	public void delete(UserFavorite userFavorite) throws Exception {
		sessionFactory.getCurrentSession().delete(userFavorite);
		sessionFactory.getCurrentSession().flush();
	}

	@Override
	public UserFavorite findById(Integer userFavoriteId) throws Exception {
		return sessionFactory.getCurrentSession().get(UserFavorite.class, userFavoriteId);
	}

	@Override
	public List<UserFavorite> findAll() throws Exception {
		return sessionFactory.getCurrentSession().createQuery("from UserFavorite").list();
	}

	@Override
	public UserFavorite findByUserIdAndItemId(String userId, Integer itemId) throws Exception {

	    String hql = "FROM UserFavorite " +
	                 "WHERE userId = :userId " +
	                 "AND itemId = :itemId";

	    return (UserFavorite) sessionFactory.getCurrentSession()
	            .createQuery(hql)
	            .setParameter("userId", userId)
	            .setParameter("itemId", itemId)
	            .uniqueResult();
	}

}
