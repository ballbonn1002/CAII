package com.cubesofttech.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.AliasToEntityMapResultTransformer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.Article;
import com.cubesofttech.model.JobSiteTeam;
import com.cubesofttech.model.Jobsite;

@Repository
public class JobSiteTeamDAOImpl implements JobSiteTeamDAO {
	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public void save(JobSiteTeam jobSiteTeam) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.save(jobSiteTeam);
		session.flush();

	}

	@Override
	public void delete(JobSiteTeam jobSiteTeam) throws Exception {

		Session session = this.sessionFactory.getCurrentSession();
		session.delete(jobSiteTeam);
		session.flush();

	}

	@Override
	public JobSiteTeam findById(Integer id) throws Exception {

		Session session = this.sessionFactory.getCurrentSession();
		JobSiteTeam jobsite = (JobSiteTeam) session.get(JobSiteTeam.class, id);

		return jobsite;
	}
	
	@Override
	public JobSiteTeam findByIdSiteJobAndUserId(String idSiteJob, String userId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		Criteria criteria = session.createCriteria(JobSiteTeam.class);
		JobSiteTeam jobSiteTeam = (JobSiteTeam) criteria
				.add(Restrictions.eq("id_sitejob", idSiteJob))
				.add(Restrictions.eq("user_id", userId))
				.uniqueResult();
		return jobSiteTeam;
	}

	public List<JobSiteTeam> findAllJobsiteByJobsiteId(String jobsiteId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<JobSiteTeam> jobsiteIdteam = null;
		try {
			String sql = "SELECT j.*, ("
					+ "	CASE"
					+ "    	WHEN j.id_sitejob IN (SELECT jst.id_sitejob FROM job_site_team jst WHERE jst.user_id = :userId) THEN true"
					+ "    	ELSE false"
					+ "    END"
					+ ") is_related "
					+ "FROM job_site_team j "
					+ "ORDER BY j.job_site_team_id DESC";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("JobsiteId", jobsiteId);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			jobsiteIdteam = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return jobsiteIdteam;
	}
	@Override
	public List<JobSiteTeam> findAllByUserId(String userId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		Criteria criteria = session.createCriteria(JobSiteTeam.class);
		@SuppressWarnings("unchecked")
		List<JobSiteTeam> list = criteria
				.add(Restrictions.eq("user_id", userId))
				.list();
		return list;
	}
	
	// ทดสอบ
	@Override
	public void deleteByIdSiteJob(String idSiteJob) throws Exception {
		try {
			Session session = this.sessionFactory.getCurrentSession();
			String sql = "DELETE FROM job_site_team WHERE id_sitejob = :idSiteJob";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("idSiteJob", idSiteJob);
			query.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
}
