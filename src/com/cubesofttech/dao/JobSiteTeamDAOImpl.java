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
		JobSiteTeam jobSiteTeam = (JobSiteTeam) criteria.add(Restrictions.eq("id_sitejob", idSiteJob))
				.add(Restrictions.eq("user_id", userId)).uniqueResult();
		return jobSiteTeam;
	}

	@Override
	public List<JobSiteTeam> findAllJobsiteByJobsiteId(String jobsiteId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<JobSiteTeam> jobsiteIdteam = null;
		try {
			String sql = "SELECT j.* " + "FROM job_site_team j " + "WHERE j.id_sitejob = :jobsiteId "
					+ "ORDER BY j.job_site_team_id DESC";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("jobsiteId", jobsiteId);
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
		List<JobSiteTeam> list = criteria.add(Restrictions.eq("user_id", userId)).list();
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

	@Override
	public List<Map<String, Object>> findSiteByUserId(String userId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();

		String sql = "SELECT js.id_sitejob AS id_sitejob, js.name_site AS name_site " + "FROM job_site_team jt "
				+ "JOIN job_site js ON jt.id_sitejob = js.id_sitejob " + "WHERE jt.user_id = :userId "
				+ "ORDER BY js.name_site";

		SQLQuery query = session.createSQLQuery(sql);
		query.addScalar("id_sitejob");
		query.addScalar("name_site");
		query.setParameter("userId", userId);
		query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

		@SuppressWarnings("unchecked")
		List<Map<String, Object>> list = query.list();
		return list;
	}

	@Override
	public List<Map<String, Object>> findTeamByUserId(String userId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();

		String sql = "SELECT DISTINCT " + "   jt.user_id        AS u_id, " + "   u.employee_id     AS employee_id, "
				+ "   u.name_en         AS name_en, " + "   u.name            AS name, "
				+ "   u.work_time_start AS work_time_start, " + "   u.work_time_end   AS work_time_end "
				+ "FROM job_site_team jt_me " + "JOIN job_site_team jt ON jt_me.id_sitejob = jt.id_sitejob "
				+ "JOIN user u ON u.id = jt.user_id " + "WHERE jt_me.user_id = :userId " + "ORDER BY u.employee_id";

		SQLQuery query = session.createSQLQuery(sql);
		query.setParameter("userId", userId);
		query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

		@SuppressWarnings("unchecked")
		List<Map<String, Object>> list = query.list();
		return list;
	}

	@Override
	public List<Map<String, Object>> findByJobsite(Integer id_sitejob) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();

		if (id_sitejob == null) {
			return new java.util.ArrayList<>();
		}

		String sql = "SELECT " + "  jt.job_site_team_id AS job_site_team_id, " + "  jt.id_sitejob       AS id_sitejob, "
				+ "  jt.user_id          AS user_id, " + "  u.employee_id       AS employee_id, "
				+ "  u.name_en           AS name_en, " + "  u.name              AS name, "
				+ "  u.work_time_start   AS work_time_start, " + "  u.work_time_end     AS work_time_end "
				+ "FROM job_site_team jt " + "LEFT JOIN user u ON u.id = jt.user_id "
				+ "WHERE jt.id_sitejob = :id_sitejob " + "  AND u.id IS NOT NULL "
				+ "  AND u.enable = '1' "
				+ "ORDER BY jt.job_site_team_id ASC";

		SQLQuery query = session.createSQLQuery(sql);
		query.setParameter("id_sitejob", id_sitejob.toString());
		query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

		@SuppressWarnings("unchecked")
		List<Map<String, Object>> list = query.list();
		return list;
	}

	@Override
	public List<Map<String, Object>> findSitesAndMembersByUserId(String userId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();

		String sql = "SELECT " + "  js.id_sitejob      AS id_sitejob, " + "  js.name_site       AS name_site, "
				+ "  jt.job_site_team_id AS job_site_team_id, " + "  u.id               AS u_id, "
				+ "  u.employee_id      AS employee_id, " + "  u.name_en          AS name_en, "
				+ "  u.name             AS name, " + "  u.work_time_start  AS work_time_start, "
				+ "  u.work_time_end    AS work_time_end " + "FROM job_site_team jt_me "
				+ "JOIN job_site_team jt ON jt_me.id_sitejob = jt.id_sitejob "
				+ "JOIN job_site js ON js.id_sitejob = jt.id_sitejob " + "JOIN user u ON u.id = jt.user_id "
				+ "WHERE jt_me.user_id = :userId " + "ORDER BY js.name_site, u.employee_id";

		SQLQuery query = session.createSQLQuery(sql);
		query.setParameter("userId", userId);
		query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

		@SuppressWarnings("unchecked")
		List<Map<String, Object>> list = query.list();
		return list;
	}

	@Override
	public List<Map<String, Object>> findSitesMembersWorkByUserAndDate(String loginUserId, String selectedDate)
			throws Exception {
		Session session = this.sessionFactory.getCurrentSession();

		String sql = "SELECT " + "    js.id_sitejob AS id_sitejob, " + "    js.name_site  AS name_site, "
				+ "    u.id          AS u_id, " + "    u.employee_id AS employee_id, "
				+ "    u.name_en     AS name_en, " + "    u.name        AS name, " + "    DATE_FORMAT( "
				+ "        MAX(CASE WHEN wh.work_hours_type = 1 THEN wh.work_hours_time_work END), "
				+ "        '%H:%i' " + "    ) AS check_in, " + "    DATE_FORMAT( "
				+ "        MAX(CASE WHEN wh.work_hours_type = 2 THEN wh.work_hours_time_work END), "
				+ "        '%H:%i' " + "    ) AS check_out " + "FROM job_site_team jt_me " + "JOIN job_site_team jt "
				+ "       ON jt_me.id_sitejob = jt.id_sitejob " + "JOIN job_site js "
				+ "       ON js.id_sitejob = jt.id_sitejob " + "JOIN user u " + "       ON u.id = jt.user_id "
				+ "LEFT JOIN work_hours wh " + "       ON wh.user_create = u.id "
				+ "      AND DATE(wh.work_hours_time_work) = :selectedDate " + "WHERE jt_me.user_id = :loginUserId "
				+ "  AND u.enable = '1' "
				+ "  AND js.is_active = '1' "
				+ "GROUP BY " + "    js.id_sitejob, js.name_site, " + "    u.id, u.employee_id, u.name_en, u.name "
				+ "ORDER BY js.id_sitejob ASC, jt.job_site_team_id ASC";

		SQLQuery query = session.createSQLQuery(sql);
		query.setParameter("loginUserId", loginUserId);
		query.setParameter("selectedDate", selectedDate);
		query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

		@SuppressWarnings("unchecked")
		List<Map<String, Object>> list = query.list();
		return list;
	}

}
