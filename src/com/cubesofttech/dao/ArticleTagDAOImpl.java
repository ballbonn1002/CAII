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
public class ArticleTagDAOImpl implements ArticleTagDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public List<ArticleTag> findAll() throws Exception {
	    Session session = sessionFactory.getCurrentSession();
	    List<ArticleTag> articleTagList = null;
	    try {
	    	articleTagList = session.createCriteria(ArticleTag.class).list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return articleTagList;
	}
	
	@Override
	public void save(ArticleTag ArticleTag) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.save(ArticleTag);
		session.flush();
		// session.close();
	}
	
	@Override
	public List<ArticleTag> findTagIdByArticleId(String articleId) throws Exception {
	    Session session = sessionFactory.getCurrentSession();

	    String sql = "SELECT tag_id FROM article_tag WHERE article_id = :articleId";

	    SQLQuery query = session.createSQLQuery(sql);
	    query.setParameter("articleId", articleId);

	    return query.list();
	}
	
	@Override
	public void deleteByArticleId(String articleId) {

		Session session = sessionFactory.getCurrentSession();

		session.createSQLQuery(
			"DELETE FROM article_tag WHERE article_id = :id"
		)
		.setParameter("id", articleId)
		.executeUpdate();
	}

	@Override
	public void update(ArticleTag ArticleTag) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.clear();
		session.update(ArticleTag);
		session.flush();
		// session.close();
	}
}
