package com.cubesofttech.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.cubesofttech.model.Warehouse;

public class WarehouseDAOImpl implements WarehouseDAO {
	
	@Autowired
	SessionFactory sessionFactory;

	@Override
	public void save(Warehouse warehouse) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		session.save(warehouse);
	}

	@Override
	public void update(Warehouse warehouse) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		session.update(warehouse);
	}

	@Override
	public void delete(Warehouse warehouse) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		session.delete(warehouse);
	}

	@Override
	public Warehouse findById(Long warehouseId) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		return session.get(Warehouse.class, warehouseId);
	}

	@Override
	public Warehouse findByName(String warehouseName) throws Exception {

	    Session session = sessionFactory.getCurrentSession();
	    return (Warehouse) session.createQuery(
	            "FROM Warehouse WHERE warehouseName = :warehouseName")
	            .setParameter("warehouseName", warehouseName)
	            .uniqueResult();
	}

	@Override
	public List<Warehouse> findAll() throws Exception {
		List<Warehouse> warehouses = sessionFactory.getCurrentSession().createQuery("FROM Warehouse").list();
		return warehouses;
	}

}
