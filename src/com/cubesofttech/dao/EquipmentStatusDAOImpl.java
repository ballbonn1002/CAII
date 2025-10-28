package com.cubesofttech.dao;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.EquipmentStatus;

@Repository
public class EquipmentStatusDAOImpl implements EquipmentStatusDAO {
	
	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public List<EquipmentStatus> getall() {
		Session session = this.sessionFactory.getCurrentSession();
		List<EquipmentStatus> list = null;
		try {
			list = session.createCriteria(EquipmentStatus.class).list();
		} catch (HibernateException e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public EquipmentStatus findByStatus(String id) {
		Session session = this.sessionFactory.getCurrentSession();
		EquipmentStatus result = null;
		try {
			result = session.get(EquipmentStatus.class, id);
		} catch (HibernateException e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void save(EquipmentStatus eStatus) {
		Session session = this.sessionFactory.getCurrentSession();
		session.save(eStatus);
		session.flush();
	}

	@Override
	public void update(EquipmentStatus eStatus) {
		Session session = this.sessionFactory.getCurrentSession();
		session.update(eStatus);
		session.flush();
	}

	@Override
	public void delete(EquipmentStatus eStatus) {
		Session session = this.sessionFactory.getCurrentSession();
		session.delete(eStatus);
		session.flush();
	}
}
