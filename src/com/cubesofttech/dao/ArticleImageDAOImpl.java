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


}
