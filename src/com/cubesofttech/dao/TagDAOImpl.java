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

import com.cubesofttech.model.Tag;

@Repository
public class TagDAOImpl implements TagDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public void save(Tag tag) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.save(tag);
		session.flush();
		// session.close();
	}
	
	@Override
	public List findAll() throws Exception {
	    Session session = sessionFactory.getCurrentSession();
	    List<Tag> tagList = null;
	    try {
	    	tagList = session.createCriteria(Tag.class).list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return tagList;
	}
	
	@Override
	public Tag findById(Integer id) throws Exception {
	    Session session = sessionFactory.getCurrentSession();

	    String sql = "SELECT * FROM tag WHERE tag_id = :id";

	    SQLQuery query = session.createSQLQuery(sql);
	    query.setParameter("id", id);

	    return (Tag) session.createSQLQuery(sql)
	            .addEntity(Tag.class)
	            .setParameter("id", id)
	            .uniqueResult();
	}
	
	@Override
	public Tag findByName(String name) throws Exception {
	    Session session = sessionFactory.getCurrentSession();
	    Tag tag = null;

	    String sql = "SELECT * FROM tag WHERE name = :name";

	    SQLQuery query = session.createSQLQuery(sql);
	    query.setParameter("name", name);
	    
	    return (Tag) session.createSQLQuery(sql)
	            .addEntity(Tag.class)
	            .setParameter("name", name)
	            .uniqueResult();
	    
	}
	
	@Override
	public Integer getMaxId() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		Integer maxId = 0;
		try {

			Criteria criteria = session.createCriteria(Tag.class).setProjection(Projections.max("tagId"));
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
	
//	@Override
//	public Tag findById(Integer id) throws Exception {
//		Session session = sessionFactory.getCurrentSession();
//		Article article = null;
//		try {
//			article = (Tag) session.get(Article.class, id);
//		} catch (Exception e) {
//			e.printStackTrace();
//		} finally {
//			// session.close();
//		}
//		return article;
//		
//
//	}
}
