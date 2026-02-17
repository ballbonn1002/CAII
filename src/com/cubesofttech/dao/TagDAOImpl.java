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
	
}
