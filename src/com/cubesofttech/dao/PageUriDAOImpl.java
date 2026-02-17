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

import com.cubesofttech.model.Article;
import com.cubesofttech.model.ArticleImage;
import com.cubesofttech.model.ArticleRelated;
import com.cubesofttech.model.ArticleTag;
import com.cubesofttech.model.ArticleType;
import com.cubesofttech.model.FileUpload;
import com.cubesofttech.model.PageUri;
import com.cubesofttech.model.User;

@Repository
public class PageUriDAOImpl implements PageUriDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public List<PageUri> findAll() throws Exception {
		Session session = sessionFactory.getCurrentSession();
		List<PageUri> pageUri = null;
		try {
			pageUri = session.createCriteria(PageUri.class).list();
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
	public PageUri findById(String modeId) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		PageUri pageUri = null;
		try {
			pageUri = (PageUri) session.get(PageUri.class, modeId);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return pageUri;
		

	}
	
	@Override
	public void deleteByModelId(String articleId) {

		Session session = sessionFactory.getCurrentSession();

		session.createSQLQuery(
			"DELETE FROM page_uri WHERE model_id = :id"
		)
		.setParameter("id", articleId)
		.executeUpdate();
	}
	
	@Override
	public void update(PageUri PageUri) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.clear();
		session.update(PageUri);
		session.flush();
		// session.close();
	}
	


}
