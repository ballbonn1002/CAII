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
import com.cubesofttech.model.User;

@Repository
public class ArticleDAOImpl implements ArticleDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public List<Article> findAll() throws Exception {
		Session session = sessionFactory.getCurrentSession();
		List<Article> article = null;
		try {
			article = session.createCriteria(Article.class).list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return article;
	}
	@Override
	public void save(Article Article) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.save(Article);
		session.flush();
		// session.close();
	}

	@Override
	public List<Map<String, Object>> findAllArticlesWithType() throws Exception {
		Session session = sessionFactory.getCurrentSession();
		List<Map<String, Object>> articleList = null;
		try {
			String sql = "Select a.*, " + "at.article_type_id  AS type_id,\n" + "at.name             AS type_name,\n"
					+ "at.description      AS type_description "
					+ "FROM article a JOIN article_type at ON a.article_type_id = at.article_type_id ORDER BY a.time_create DESC;";

			SQLQuery query = session.createSQLQuery(sql);
//			query.setParameter("articleTypeId", articleTypeId);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			articleList = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {

		}

		return articleList;
	}
	
	@Override
	public List<Map<String, Object>> findArticlesByDateRange(
	        LocalDateTime startDate,
	        LocalDateTime endDate) throws Exception {

	    Session session = sessionFactory.getCurrentSession();
	    List<Map<String, Object>> articleList = null;

	    String sql =
	        "SELECT a.*, " +
	        "at.article_type_id AS type_id, " +
	        "at.name AS type_name, " +
	        "at.description AS type_description " +
	        "FROM article a " +
	        "JOIN article_type at ON a.article_type_id = at.article_type_id " +
	        "WHERE a.time_post BETWEEN :startDate AND :endDate " +
	        "ORDER BY a.time_create DESC";

	    SQLQuery query = session.createSQLQuery(sql);
	    query.setParameter("startDate", Timestamp.valueOf(startDate));
	    query.setParameter("endDate", Timestamp.valueOf(endDate));

	    query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

	    articleList = query.list();

	    return articleList;
	}

	@Override
	public Article findById(Integer articleId) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		Article article = null;
		try {
			article = (Article) session.get(Article.class, articleId);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return article;
		

	}
	
	@Override
	public Integer getMaxId() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		Integer maxId = 0;
		try {

			Criteria criteria = session.createCriteria(Article.class).setProjection(Projections.max("articleId"));
			maxId = (Integer) criteria.uniqueResult();

		} catch (Exception e) {
			e.printStackTrace();
			maxId = new Integer(0);

		} finally {

		}
		if (maxId != null) {
			return maxId;
		} else {
			return new Integer(0);
		}
	}
	
	@Override
	public void delete(Article Article) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.delete(Article);
		session.flush();
		// session.close();
	}
	
	@Override
	public void update(Article Article) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.clear();
		session.update(Article);
		session.flush();
		// session.close();
	}

	

}
