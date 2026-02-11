package com.cubesofttech.dao;

import java.util.ArrayList;
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

	@Override
	public List<Map<String, Object>> getNameSiteListByUserId(String userId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();

		List<Map<String, Object>> list = null;
		try {
			String sql = "SELECT js.id_sitejob, js.name_site, js.is_active " + "FROM job_site_team jst "
					+ "INNER JOIN job_site js ON jst.id_sitejob = js.id_sitejob " + "WHERE js.is_active = '1' "
					+ "AND jst.user_id = :userId";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("userId", userId);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			list = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Map<String, Object>> findJobsiteUser(String userId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();

		List<Map<String, Object>> jobuser = null;
		try {
			String sql = "SELECT js.*, (" + "   CASE " + "       WHEN js.id_sitejob IN ("
					+ "           SELECT jst.id_sitejob " + "           FROM job_site js1 "
					+ "           INNER JOIN job_site_team jst ON js1.id_sitejob = jst.id_sitejob "
					+ "           WHERE jst.user_id = :userId" + "       ) THEN true " + "       ELSE false " + "   END"
					+ ") AS is_related " + "FROM job_site js " + "ORDER BY js.id_sitejob ASC";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("userId", userId);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			jobuser = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return jobuser;
	}

	@Override
	public List<Map<String, Object>> findAll() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();

		List<Map<String, Object>> faqJoin = null;
		try {
			String sql = "SELECT * FROM job_site ORDER BY name_site ASC";

			SQLQuery query = session.createSQLQuery(sql);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			faqJoin = query.list();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return faqJoin;
	}

	@Override
	public List<Map<String, Object>> findAll2() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();

		List<Map<String, Object>> faqJoin = null;
		try {
			String sql = "SELECT user.*, job_site.name_site " + "FROM user "
					+ "LEFT JOIN job_site ON user.id_sitejob = job_site.id_sitejob";

			SQLQuery query = session.createSQLQuery(sql);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			faqJoin = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return faqJoin;
	}

	@Override
	public List<Map<String, Object>> findAllWithTeamAmount() throws Exception {

		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> result = null;

		try {
			String sql = "SELECT js.id_sitejob, js.name_site, " + "       js.description, js.is_active, "
					+ "       COUNT(u.id) AS team_amount " + 
					"FROM job_site js " + "LEFT JOIN job_site_team jst ON js.id_sitejob = jst.id_sitejob "
					+ "LEFT JOIN user u ON jst.user_id = u.id " + 
					"GROUP BY js.id_sitejob, js.name_site, " + "         js.description, js.is_active "
					+ "ORDER BY js.id_sitejob";

			SQLQuery query = session.createSQLQuery(sql);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

			result = query.list();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public void deleteTeamByJobsite(String idSitejob) throws Exception {
		// TODO Auto-generated method stub
	}

	@Override
	public List<Map<String, Object>> getJobSiteByUserId(String userId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> jobSite = new ArrayList<>();

		try {
			String sql = "SELECT j.id_sitejob, j.name_site, j.description FROM job_site_team jt JOIN job_site j ON jt.id_sitejob = j.id_sitejob WHERE jt.user_id = :userId";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("userId", userId);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

			jobSite = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return jobSite;
	}

}
