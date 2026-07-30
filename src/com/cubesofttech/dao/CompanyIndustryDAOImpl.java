package com.cubesofttech.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.CompanyIndustry;

@Repository
public class CompanyIndustryDAOImpl implements CompanyIndustryDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public CompanyIndustry findById(Long id) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		CompanyIndustry industry = (CompanyIndustry) session.get(CompanyIndustry.class, id);
		
		return industry;
	}

	@Override
	public List<CompanyIndustry> findAll() throws Exception {
		Session session = sessionFactory.getCurrentSession();
		
		return session.createQuery("FROM CompanyIndustry").list();
	}

	@Override
	public void save(CompanyIndustry industry) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		session.save(industry);
	}

	@Override
	public void update(CompanyIndustry industry) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		session.update(industry);
	}

	@Override
	public void delete(CompanyIndustry industry) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		session.delete(industry);
	}
	
	@Override
	public CompanyIndustry findByName(String industryName) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		String hql = "FROM CompanyIndustry WHERE industryName = :industryName";
		return (CompanyIndustry) session.createQuery(hql)
				.setParameter("industryName", industryName)
				.uniqueResult();
	}

}
