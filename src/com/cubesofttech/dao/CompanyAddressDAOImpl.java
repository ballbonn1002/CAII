package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.transform.AliasToEntityMapResultTransformer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.CompanyAddress;

@Repository
public class CompanyAddressDAOImpl implements CompanyAddressDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public CompanyAddress findById(Long id) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		return (CompanyAddress) session.get(CompanyAddress.class, id);
	}

	@Override
	public List<Map<String, Object>> findAll() throws Exception {
		Session session = sessionFactory.getCurrentSession();

		String sql = "SELECT * FROM company_address";

		SQLQuery query = session.createSQLQuery(sql);
		query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

		return query.list();
	}

	@Override
	public void save(CompanyAddress address) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		session.save(address);
	}

	@Override
	public void update(CompanyAddress address) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		session.update(address);
		session.flush();
	}

	@Override
	public void delete(CompanyAddress address) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		session.delete(address);
		session.flush();

	}

	@Override
	public List<Map<String, Object>> findByCompanyId(Long companyId) throws Exception {
		Session session = sessionFactory.getCurrentSession();

		String sql = "SELECT company_address_id as address_id, company_id, address_name, address , google_map FROM company_address WHERE company_id = :companyId";
		
		SQLQuery query = session.createSQLQuery(sql);
		query.setParameter("companyId", companyId);
		
		query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

		return query.list();
	}

}
