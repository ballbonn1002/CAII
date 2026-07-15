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

import com.cubesofttech.model.CatalogConsumables;
import com.cubesofttech.model.FileUpload;

import com.cubesofttech.model.User;

@Repository
public class CatalogConsumablesDAOImpl implements CatalogConsumablesDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public List<CatalogConsumables> findAll() throws Exception {
		Session session = sessionFactory.getCurrentSession();
		List<CatalogConsumables> catalogConsumables = null;
		try {
			catalogConsumables = session.createCriteria(CatalogConsumables.class).list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return catalogConsumables;
	}
	@Override
	public void save(CatalogConsumables CatalogConsumables) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.save(CatalogConsumables);
		session.flush();
		// session.close();
	}

	@Override
	public CatalogConsumables findById(Long catalogConsumablesId) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		CatalogConsumables catalogConsumables = null;
		try {
			catalogConsumables = (CatalogConsumables) session.get(CatalogConsumables.class, catalogConsumablesId);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return catalogConsumables;
		

	}
	
	@Override
	public Long getMaxId() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		Long maxId = 0L;
		try {

			Criteria criteria = session.createCriteria(CatalogConsumables.class).setProjection(Projections.max("catalogConsumablesId"));
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
	public void delete(CatalogConsumables CatalogConsumables) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.delete(CatalogConsumables);
		session.flush();
		// session.close();
	}
	
	@Override
	public void update(CatalogConsumables CatalogConsumables) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.clear();
		session.update(CatalogConsumables);
		session.flush();
		// session.close();
	}

	

}
