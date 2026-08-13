package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.transform.AliasToEntityMapResultTransformer;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.cubesofttech.model.CompanyContact;

@Repository
public class CompanyContactDAOImpl implements CompanyContactDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public CompanyContact findById(Long id) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		return (CompanyContact) session.get(CompanyContact.class, id);
	}

	@Override
	public List<Map<String, Object>> findAll() throws Exception {
		Session session = sessionFactory.getCurrentSession();

		String sql =
			    "SELECT " +
			    "cc.*, " +
			    "f.path AS file_path " +
			    "FROM company_contact cc " +
			    "LEFT JOIN file f ON cc.file_id = f.file_id";
		SQLQuery query = session.createSQLQuery(sql);
		query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

		return query.list();
	}


	@Override
	public void save(CompanyContact contact) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		session.save(contact);
		session.flush();
	}

	@Override
	public void update(CompanyContact contact) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		session.update(contact);
		session.flush();
	}

	@Override
	public void delete(CompanyContact contact) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		session.delete(contact);
		session.flush();
	}
	
	@Override
	public List<Map<String, Object>> findByCompanyId(Long companyId) throws Exception {

	    Session session = sessionFactory.getCurrentSession();
	    
	    String sql =
	            "SELECT " +
	            "c.company_contact_id AS contact_id, " +
	            "c.company_id, " +
	            "c.company_address_id AS address_id," +
	            "c.title_name_en, " +
	            "c.contact_name, " +
	            "c.title_name_th," +
	            "c.contact_name_th," +
	            "c.email, " +
	            "c.phone, " +
	            "c.position," + 
	            "f.path AS file_path, " +
	            "ca.address_name " +
	            "FROM company_contact c " +
	            "LEFT JOIN file f " +
	            "ON f.file_id = c.file_id " +
	            "LEFT JOIN company_address ca " +
	            "ON ca.company_address_id = c.company_address_id " +
	            "WHERE c.company_id = :companyId " +
	            "ORDER BY c.company_contact_id";

	    SQLQuery query = session.createSQLQuery(sql);

	    query.setParameter("companyId", companyId);

	    query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

	    return query.list();
	}
	
	@Override
	public List<Map<String, Object>> findByAddressId(Long addressId) throws Exception {

	    Session session = sessionFactory.getCurrentSession();

	    String sql =
	        "SELECT " +
	        "company_contact_id, " +
	        "contact_name, " +
	        "phone, " +
	        "email " +
	        "FROM company_contact " +
	        "WHERE company_address_id = :addressId " +
	        "ORDER BY contact_name";

	    SQLQuery query = session.createSQLQuery(sql);
	    query.setParameter("addressId", addressId);
	    query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

	    return query.list();
	}

}
