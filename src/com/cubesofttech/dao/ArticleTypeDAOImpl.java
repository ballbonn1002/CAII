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
public class ArticleTypeDAOImpl implements ArticleTypeDAO {

	@Autowired
	private SessionFactory sessionFactory;
	
	@Override
	public List<ArticleType> findAll() throws Exception {
	    Session session = sessionFactory.getCurrentSession();
	    List<ArticleType> articleTypeList = null;
	    try {
	    	articleTypeList = session.createCriteria(ArticleType.class).list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return articleTypeList;
	}
	
	
	@Override
	public List<Map<String, Object>> findArticleTypeById(Integer typeId) {
	    Session session = sessionFactory.getCurrentSession();
	    String sql = "SELECT * FROM article WHERE article_type_id = :typeId";

	    Query query = session.createSQLQuery(sql)
	        .setParameter("typeId", typeId)
	        .setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

	    return query.list();
	}
	
	@Override
	public void update(ArticleType ArticleType) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.clear();
		session.update(ArticleType);
		session.flush();
		// session.close();
	}
	
}
