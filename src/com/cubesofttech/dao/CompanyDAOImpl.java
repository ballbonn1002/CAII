package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.transform.AliasToEntityMapResultTransformer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.Company;

@Repository
public class CompanyDAOImpl implements CompanyDAO {
	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public Company findById(Long id) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		return (Company) session.get(Company.class, id);
	}

	@Override
	public List<Map<String, Object>> findAll() throws Exception {

		Session session = sessionFactory.getCurrentSession();

		String sql = "SELECT " + "c.company_id, " + "c.company_code, " + "c.company_th, " + "c.company_en, "
				+ "c.phone, " + "c.email, " + "c.website, " + "c.is_active, " + "f.path AS file_path "
				+ "FROM company c " + "LEFT JOIN file f ON c.file_id = f.file_id " + "ORDER BY c.company_id";

		SQLQuery query = session.createSQLQuery(sql);
		query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

		return query.list();
	}

	@Override
	public void save(Company company) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		session.save(company);
	}

	@Override
	public void update(Company company) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		session.update(company);
		session.flush();
	}

	@Override
	public void delete(Company company) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		session.delete(company);
		session.flush();
	}

	@Override
	public boolean existsCompanyCode(String companyCode, Long companyId) {

	    Session session = sessionFactory.getCurrentSession();

	    String sql =
	        "SELECT COUNT(*) " +
	        "FROM company " +
	        "WHERE company_code = :companyCode ";

	    if (companyId != null && companyId > 0L) {
	        sql += "AND company_id <> :companyId ";
	    }

	    Query query = session.createSQLQuery(sql);

	    query.setParameter("companyCode", companyCode);

	    if (companyId != null && companyId > 0L) {
	        query.setParameter("companyId", companyId);
	    }

	    Long count =
	        ((Number) query.uniqueResult()).longValue();

	    return count > 0;
	}

}
