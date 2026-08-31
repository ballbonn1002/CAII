package com.cubesofttech.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.ActionPoint;

@Repository
public class ActionPointDAOImpl implements ActionPointDAO {

	@Autowired
	SessionFactory sessionFactory;

	@Override
	public ActionPoint findById(Integer actionPointId) throws Exception {
		return sessionFactory.getCurrentSession().get(ActionPoint.class, actionPointId);
	}

	@Override
	public List<ActionPoint> findByActionTypeId(Integer actionTypeId) throws Exception {
		return sessionFactory.getCurrentSession().createQuery("from ActionPoint where actionTypeId = :actionTypeId")
				.setParameter("actionTypeId", actionTypeId).list();
	}

	@Override
	public List<ActionPoint> findAll() throws Exception {
		return sessionFactory.getCurrentSession().createQuery("from ActionPoint").list();
	}

	@Override
	public void update(ActionPoint actionPoint) throws Exception {
		sessionFactory.getCurrentSession().update(actionPoint);
		sessionFactory.getCurrentSession().flush();
	}

	@Override
	public void delete(ActionPoint actionPoint) throws Exception {
		sessionFactory.getCurrentSession().delete(actionPoint);
		sessionFactory.getCurrentSession().flush();
	}

	@Override
	public void save(ActionPoint actionPoint) throws Exception {
		sessionFactory.getCurrentSession().save(actionPoint);
		sessionFactory.getCurrentSession().flush();
	}

	@Override
	public List<ActionPoint> findByActionTypeIdAndActiveStatus(Integer actionTypeId, String status) throws Exception {
		return sessionFactory.getCurrentSession()
				.createQuery("from ActionPoint where actionTypeId = :actionTypeId and activeStatus = :status")
				.setParameter("actionTypeId", actionTypeId).setParameter("status", status).list();
	}

}
