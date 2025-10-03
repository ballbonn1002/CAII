package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.AliasToEntityMapResultTransformer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.Jobsite;

@Repository
public class JobsiteDAOImpl implements JobsiteDAO {
	@Autowired
	private SessionFactory sessionFactory;
	
	@Override
	public void save(Jobsite jobsite) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.save(jobsite);
		session.flush();

	}

	@Override
	public void update(Jobsite jobsite) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.update(jobsite);
		session.flush();

	}

	@Override
	public void delete(Jobsite jobsite) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.delete(jobsite);
		session.flush();

	}

	@Override
	public Jobsite findById(Integer id) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		Jobsite jobsite = (Jobsite) session.get(Jobsite.class, id);

		return jobsite;
	}
}
