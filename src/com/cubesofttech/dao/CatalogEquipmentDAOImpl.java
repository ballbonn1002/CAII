package com.cubesofttech.dao;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Projections;
import org.hibernate.transform.AliasToEntityMapResultTransformer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.CatalogEquipment;
import com.cubesofttech.model.FileUpload;

import com.cubesofttech.model.User;

@Repository
public class CatalogEquipmentDAOImpl implements CatalogEquipmentDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public List<CatalogEquipment> findAll() throws Exception {
		Session session = sessionFactory.getCurrentSession();
		List<CatalogEquipment> catalogEquipment = null;
		try {
			catalogEquipment = session.createCriteria(CatalogEquipment.class).list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return catalogEquipment;
	}
	@Override
	public void save(CatalogEquipment CatalogEquipment) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.save(CatalogEquipment);
		session.flush();
		// session.close();
	}

	@Override
	public CatalogEquipment findById(Long catalogEquipmentId) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		CatalogEquipment catalogEquipment = null;
		try {
			catalogEquipment = (CatalogEquipment) session.get(CatalogEquipment.class, catalogEquipmentId);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return catalogEquipment;
		

	}
	
	@Override
	public Long getMaxId() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		Long maxId = 0L;
		try {

			Criteria criteria = session.createCriteria(CatalogEquipment.class).setProjection(Projections.max("catalogEquipmentId"));
			maxId = (Long) criteria.uniqueResult();

		} catch (Exception e) {
			e.printStackTrace();
			maxId = new Long(0);

		} finally {

		}
		if (maxId != null) {
			return maxId;
		} else {
			return new Long(0);
		}
	}
	
	@Override
	public void delete(CatalogEquipment CatalogEquipment) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.delete(CatalogEquipment);
		session.flush();
		// session.close();
	}
	
	@Override
	public void update(CatalogEquipment CatalogEquipment) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.clear();
		session.update(CatalogEquipment);
		session.flush();
		// session.close();
	}

	

}
