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

import com.cubesofttech.model.PageUri;

@Repository
public class PageUriDAOImpl implements PageUriDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public List<PageUri> findAll() throws Exception {
		Session session = sessionFactory.getCurrentSession();
		List<PageUri> pageUri = null;
		try {
			pageUri = session.createCriteria(PageUri.class)
	                .addOrder(org.hibernate.criterion.Order.desc("timeCreate"))
	                .list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return pageUri;
	}
	
	@Override
	public void save(PageUri PageUri) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.save(PageUri);
		session.flush();
		// session.close();
	}
	
	@Override
	public void update(PageUri PageUri) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.clear();
		session.update(PageUri);
		session.flush();
		// session.close();
	}
	
	@Override
	public void delete(PageUri PageUri) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.delete(PageUri);
		session.flush();
		// session.close();
	}
	
	@Override
	public List<PageUri> findByModelAndModelId(String model, String modelId) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		List<PageUri> pageUri = null;
		try {
	        String sql = "SELECT * FROM page_uri WHERE model = :model AND model_id = :modelId";

	        SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("model", model);
			query.setParameter("modelId", modelId);
			query.addEntity(PageUri.class);
			pageUri = query.list();

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
		return pageUri;
	}
	
	@Override
	public PageUri findById(String page_uri_id) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		PageUri pageUri = null;
		try {
			pageUri = (PageUri) session.get(PageUri.class, page_uri_id);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return pageUri;
	}
	
	@Override
	public PageUri findByModelId(String model, String modelId) throws Exception {
	    Session session = this.sessionFactory.getCurrentSession();
	    PageUri item = null;
	    try {
	        String sql = "SELECT * FROM page_uri WHERE model = :model AND model_id = :modelId LIMIT 1";
	        SQLQuery query = session.createSQLQuery(sql);
	        query.addEntity(PageUri.class);
	        query.setParameter("model", model);
	        query.setParameter("modelId", modelId);

	        item = (PageUri) query.uniqueResult();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return item;
	}
	
	@Override
	public void deleteByModelAndModelId(String model, String articleId) {

		Session session = sessionFactory.getCurrentSession();

		session.createSQLQuery(
			"DELETE FROM page_uri WHERE model = :model AND model_id = :id"
		)
		.setParameter("model", model)
		.setParameter("id", articleId)
		.executeUpdate();
	}

	@Override
	public void deleteByPageUrlIdAndForwardTo(String pageUrlId, String forwardTo) {

		Session session = sessionFactory.getCurrentSession();

		session.createSQLQuery(
			"DELETE FROM page_uri WHERE page_uri_id = :pageUrlId AND forward_to = :forwardTo"
		)
		.setParameter("pageUrlId", pageUrlId)
		.setParameter("forwardTo", forwardTo)
		.executeUpdate();
	}
	
}
