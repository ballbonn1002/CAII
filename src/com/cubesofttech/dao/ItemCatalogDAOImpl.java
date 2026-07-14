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

import com.cubesofttech.model.FileUpload;
import com.cubesofttech.model.ItemCatalog;
import com.cubesofttech.model.User;

@Repository
public class ItemCatalogDAOImpl implements ItemCatalogDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public List<ItemCatalog> findAll() throws Exception {
		Session session = sessionFactory.getCurrentSession();
		List<ItemCatalog> itemCatalog = null;
		try {
			itemCatalog = session.createCriteria(ItemCatalog.class).list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return itemCatalog;
	}
	@Override
	public void save(ItemCatalog ItemCatalog) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.save(ItemCatalog);
		session.flush();
		// session.close();
	}

	@Override
	public ItemCatalog findById(Long itemCatalogId) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		ItemCatalog itemCatalog = null;
		try {
			itemCatalog = (ItemCatalog) session.get(ItemCatalog.class, itemCatalogId);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return itemCatalog;
		

	}
	
	@Override
	public Long getMaxId() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		Long maxId = 0L;
		try {

			Criteria criteria = session.createCriteria(ItemCatalog.class).setProjection(Projections.max("itemCatalogId"));
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
	public void delete(ItemCatalog ItemCatalog) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.delete(ItemCatalog);
		session.flush();
		// session.close();
	}
	
	@Override
	public void update(ItemCatalog ItemCatalog) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.clear();
		session.update(ItemCatalog);
		session.flush();
		// session.close();
	}

	

}
