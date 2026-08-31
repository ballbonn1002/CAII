package com.cubesofttech.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.ActionType;

@Repository
public class ActionTypeDAOImpl implements ActionTypeDAO {
	
	@Autowired
	SessionFactory sessionFactory;

	@Override
	public void save(ActionType actionType) throws Exception {
		sessionFactory.getCurrentSession().save(actionType);
	}

	@Override
	public void update(ActionType actionType) throws Exception {
		sessionFactory.getCurrentSession().update(actionType);
	}

	@Override
	public void delete(ActionType actionType) throws Exception {
		sessionFactory.getCurrentSession().delete(actionType);
	}

	@Override
	public ActionType findById(Integer actionTypeId) throws Exception {
		return sessionFactory.getCurrentSession().get(ActionType.class, actionTypeId);
	}

	@Override
	public List<ActionType> findAll() throws Exception {
		return sessionFactory.getCurrentSession().createQuery("from ActionType").list();
	}

	@Override
	public List<ActionType> findByActiveStatus(String status) throws Exception {
		return sessionFactory.getCurrentSession().createQuery("from ActionType where activeStatus = :status")
				.setParameter("status", status).list();
	}

}
