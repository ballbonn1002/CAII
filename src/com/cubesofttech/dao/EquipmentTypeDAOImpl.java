package com.cubesofttech.dao;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.EquipmentType;

@Repository
public class EquipmentTypeDAOImpl implements EquipmentTypeDAO {
	
	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public List<EquipmentType> getall() {
		Session session = this.sessionFactory.getCurrentSession();
		List<EquipmentType> listt = null;
		try {
			listt = session.createCriteria(EquipmentType.class).list();
		} catch (HibernateException e) {
			e.printStackTrace();
		}
		return listt;
	}

	@Override
	public EquipmentType findByType(String id) {
		Session session = this.sessionFactory.getCurrentSession();
		EquipmentType result = null;
		try {
			result = session.get(EquipmentType.class, id);
		} catch (HibernateException e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void save(EquipmentType Type) {
		Session session = this.sessionFactory.getCurrentSession();
		session.save(Type);
		session.flush();
	}

	@Override
	public void update(EquipmentType Type) {
		Session session = this.sessionFactory.getCurrentSession();
		session.update(Type);
		session.flush();
	}

	@Override
	public void delete(EquipmentType Type) {
		Session session = this.sessionFactory.getCurrentSession();
		session.delete(Type);
		session.flush();
	}
}
