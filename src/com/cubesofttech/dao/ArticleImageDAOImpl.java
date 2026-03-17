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
import com.cubesofttech.model.FileUpload;

@Repository
public class ArticleImageDAOImpl implements ArticleImageDAO {

	@Autowired
	private SessionFactory sessionFactory;
	
	@Override
	public List<ArticleImage> findAll() throws Exception {
	    Session session = sessionFactory.getCurrentSession();
	    List<ArticleImage> articleImageList = null;
	    try {
	    	articleImageList = session.createCriteria(ArticleImage.class).list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return articleImageList;
	}
	
	@Override
	public void save(ArticleImage ArticleImage) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.save(ArticleImage);
		session.flush();
		// session.close();
	}

	public Integer getMaxId() throws Exception {
	    Session session = this.sessionFactory.getCurrentSession();
	    String sql = "SELECT COALESCE(MAX(atc_img_id),0) FROM article_image";
	    SQLQuery query = session.createSQLQuery(sql);
	    return ((Number) query.uniqueResult()).intValue();
	}
	
	
	@Override
	public void deleteByPath(String path) {

		Session session = sessionFactory.getCurrentSession();

		session.createSQLQuery(
			"DELETE FROM article_image WHERE atc_img_path = :path"
		)
		.setParameter("path", path)
		.executeUpdate();
	}
	
}
