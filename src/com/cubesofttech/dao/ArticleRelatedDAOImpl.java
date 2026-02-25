package com.cubesofttech.dao;

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

@Repository
public class ArticleRelatedDAOImpl implements ArticleRelatedDAO {

	@Autowired
	private SessionFactory sessionFactory;
	
	@Override
	public List<ArticleRelated> findAll() throws Exception {
	    Session session = sessionFactory.getCurrentSession();
	    List<ArticleRelated> articleRelatedList = null;
	    try {
	    	articleRelatedList = session.createCriteria(ArticleRelated.class).list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return articleRelatedList;
	}

	@Override
	public void save(ArticleRelated ArticleRelated) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.save(ArticleRelated);
		session.flush();
		// session.close();
	}
	
	@Override
	public List<ArticleRelated> findRelatedIdByArticleId(String articleId) throws Exception {
	    Session session = sessionFactory.getCurrentSession();

	    String sql = "SELECT related_article_id FROM article_related WHERE article_id = :articleId";

	    SQLQuery query = session.createSQLQuery(sql);
	    query.setParameter("articleId", articleId);

	    return query.list();
	}
	
	@Override
	public void deleteByArticleId(String articleId) {

		Session session = sessionFactory.getCurrentSession();

		session.createSQLQuery(
			"DELETE FROM article_related WHERE article_id = :id"
		)
		.setParameter("id", articleId)
		.executeUpdate();
	}
	
	@Override
	public void update(ArticleRelated ArticleRelated) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.clear();
		session.update(ArticleRelated);
		session.flush();
		// session.close();
	}
}
