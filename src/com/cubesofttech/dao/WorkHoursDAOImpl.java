package com.cubesofttech.dao;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.AliasToEntityMapResultTransformer;
import org.jfree.util.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.User;
import com.cubesofttech.model.WorkHours;
import com.cubesofttech.util.DateUtil;
import com.cubesofttech.util.StringUtil;

@Repository
public class WorkHoursDAOImpl implements WorkHoursDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public void save(WorkHours WorkHours) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.save(WorkHours);
		session.flush();
		// session.close();
	}

	@Override
	public List<WorkHours> findAll() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<WorkHours> workHoursList = null;
		try {
			workHoursList = session.createCriteria(WorkHours.class).list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return workHoursList;
	}

	@Override
	public void update(WorkHours WorkHours) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.clear();
		session.update(WorkHours);
		session.flush();
		// session.close();
	}

	@Override
	public void delete(WorkHours WorkHours) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.delete(WorkHours);
		session.flush();
		// session.close();
	}

	@Override
	public WorkHours findByWorkHoursId(int workHoursId) throws Exception {
		WorkHours result = null;
		Session session = this.sessionFactory.getCurrentSession();
		Criteria cr = session.createCriteria(WorkHours.class);
		cr.add(Restrictions.eq("workHoursId", workHoursId));
		List results = cr.list();
		if (!results.isEmpty()) {
			result = (WorkHours) results.get(0);
			return result;
		} else {
			return null;
		}

	}

	@Override
	public WorkHours findById(String id) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		WorkHours WorkHours = null;
		try {
			WorkHours = (WorkHours) session.get(WorkHours.class, id);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return WorkHours;
	}

	@Override
	public List<WorkHours> search(String workHoursId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<WorkHours> list = null;
		try {

			Criteria cr = session.createCriteria(WorkHours.class);
			cr.add(Restrictions.eq("workHoursId", workHoursId));

			list = cr.list();

		} catch (Exception e) {
			e.printStackTrace();
			return null;

		} finally {

		}
		return list;
	}

	@Override
	public Integer getMaxId() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<WorkHours> list = null;
		Integer maxId;

		try {

			Criteria criteria = session.createCriteria(WorkHours.class).setProjection(Projections.max("workHoursId"));
			maxId = (Integer) criteria.uniqueResult();

			if (maxId == null) {
				maxId = 0;
			} else {
				return maxId;
			}

		} catch (Exception e) {
			e.printStackTrace();
			return new Integer(0);

		} finally {

		}
		if (maxId != null) {
			return maxId;
		} else {
			return new Integer(0);
		}
	}

	@Override
	public List<Map<String, Object>> checkhistory(String currentUserhistory, String month, String year)
			throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> work_status = null;
		try {

			String sql = "select hour(m.work_hours_time_work) AS myhour, minute(m.work_hours_time_work)"
					+ " AS mymin,work_hours_id,work_hours_type,work_hours_time_work,user_create,time_create,ip_address,description"
					+ " from work_hours m" + " where  work_hours_type = 2 AND user_create =:currentUserhistory "
					+ " AND YEAR(work_hours_time_work)=:year AND MONTH(work_hours_time_work)=:month "
					+ " ORDER BY  work_hours_id ASC ";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("currentUserhistory", currentUserhistory);
			query.setParameter("month", month);
			query.setParameter("year", year);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			work_status = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return work_status;
	}

	@Override
	public List<Map<String, Object>> checklistLL(String id) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> work_status = null;
		try {

			String sql = "select work_hours_id,work_hours_type,work_hours_time_work ,latitude ,longitude ,description ,ip_address ,user_create ,time_create"
					+ " from work_hours m " + "WHERE work_hours_id=:id";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("id", id);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			work_status = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return work_status;
	}

	@Override
	public List<Map<String, Object>> checklist(String currentUserlist, java.sql.Timestamp Datenow,
			java.sql.Timestamp DateBefore, String month, String year) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> work_status = null;
		try {

			String sql = "select hour(m.work_hours_time_work) AS myhour, DATE(work_hours_time_work) AS checkDate, minute(m.work_hours_time_work), description "
					+ " AS mymin,m.work_hours_id,m.work_hours_type,m.work_hours_time_work,"
					+ " date_format(m.work_hours_time_work,'%d-%m-%y')as `date`,time(m.work_hours_time_work)as `time`,"
					+ " m.user_create,m.time_create,m.ip_address,m.description,m.latitude,m.longitude,u.role_id as 'u_rold',u.name as 'u_name',m.work_hours_type as `check_type`"
					+ " from work_hours m " + " inner join `user` u on m.user_create = u.id"
					+ " where user_create = :currentUserlist AND YEAR(work_hours_time_work)=:year AND MONTH(work_hours_time_work)=:month "
					+ " ORDER BY work_hours_id ASC ";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("currentUserlist", currentUserlist);
			query.setParameter("month", month);
			query.setParameter("year", year);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			work_status = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return work_status;
	}

	@Override
	public List<Map<String, Object>> timemonth(String currentUserlist, String month, String year) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> work_status = null;
		try {

			String sql = "select DISTINCT DATE(work_hours_time_work) " + " from work_hours "
					+ " where user_create = :currentUserlist AND YEAR(work_hours_time_work)=:year AND MONTH(work_hours_time_work)=:month ";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("currentUserlist", currentUserlist);
			query.setParameter("month", month);
			query.setParameter("year", year);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			work_status = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return work_status;
	}

	@Override
	public List<Map<String, Object>> checklistcalendar(String currentUserlist, String month, String year)
			throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> work_status = null;
		try {

			String sql = "select DISTINCT DATE(work_hours_time_work) " + " from work_hours "
					+ " where user_create = :currentUserlist AND YEAR(work_hours_time_work)=:year AND MONTH(work_hours_time_work)=:month ";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("currentUserlist", currentUserlist);
			query.setParameter("month", month);
			query.setParameter("year", year);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			work_status = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return work_status;
	}

//	test 20/03
	@Override
	public List<Map<String, Object>> checkStatus(String currentUserlist, String month, String year) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> checkstatus = null;
		try {

			String sql = "SELECT user.work_time_start, id FROM user ";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("currentUserlist", currentUserlist);
			query.setParameter("month", month);
			query.setParameter("year", year);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			checkstatus = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return checkstatus;
	}

	@Override
	public List<Map<String, Object>> checklistcalendars(String datecheckin, String currentUserlist, String month,
			String year) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> work_status = null;
		try {

			String sql = "select work_hours_time_work AS mytimecheckout " + " from work_hours "
					+ " where DATE(work_hours_time_work)=:datecheckin AND user_create = :currentUserlist AND YEAR(work_hours_time_work)=:year AND MONTH(work_hours_time_work)=:month AND work_hours_type=2 ";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("datecheckin", datecheckin);
			query.setParameter("currentUserlist", currentUserlist);
			query.setParameter("month", month);
			query.setParameter("year", year);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			work_status = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return work_status;
	}

	@Override
	public List<Map<String, Object>> idcheckinsearchcheckout(String datecheckin, String currentUserlist,
			java.sql.Timestamp Datenow, java.sql.Timestamp DateBefore, String month, String year) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> work_status = null;
		try {

			String sql = "select work_hours_id " + " from work_hours "
					+ " where DATE(work_hours_time_work)=:datecheckin AND user_create = :currentUserlist AND YEAR(work_hours_time_work)=:year AND MONTH(work_hours_time_work)=:month AND work_hours_type=2 "
					+ " ORDER BY work_hours_id DESC " + " LIMIT 1 ";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("datecheckin", datecheckin);
			query.setParameter("currentUserlist", currentUserlist);
			query.setParameter("month", month);
			query.setParameter("year", year);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			work_status = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return work_status;
	}

	@Override
	public List<Map<String, Object>> checkincalendars(String datecheckin, String currentUserlist, String month,
			String year) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> work_status = null;
		try {

			String sql = "select work_hours_time_work AS mycheckin " + " from work_hours "
					+ " where DATE(work_hours_time_work)=:datecheckin AND user_create = :currentUserlist "
					+ "AND YEAR(work_hours_time_work)=:year AND MONTH(work_hours_time_work)=:month AND work_hours_type=1 "
					+ " ORDER BY work_hours_id DESC " + " LIMIT 1 ";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("datecheckin", datecheckin);
			query.setParameter("currentUserlist", currentUserlist);
			query.setParameter("month", month);
			query.setParameter("year", year);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			work_status = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return work_status;
	}

	@Override
	public List<Map<String, Object>> idcheckoutcalendars(String idcheckin, String currentUserlist) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> work_status = null;
		try {

			String sql = "select work_hours_id " + " from work_hours "
					+ " where work_hours_id > :idcheckin  AND user_create = :currentUserlist AND work_hours_type=2 "
					+ " ORDER BY work_hours_id ASC " + " LIMIT 1 ";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("idcheckin", idcheckin);
			query.setParameter("currentUserlist", currentUserlist);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			work_status = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return work_status;
	}

	@Override
	public List<Map<String, Object>> timecheckoutfromid(String idcheckoutsearchtime) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> work_status = null;
		try {

			String sql = "select work_hours_time_work " + " from work_hours "
					+ " where work_hours_id =:idcheckoutsearchtime ";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("idcheckoutsearchtime", idcheckoutsearchtime);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			work_status = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return work_status;
	}

	@Override
	public List<Map<String, Object>> lastcheckin(String user) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> work_status = null;
		try {
			/*
			String sql = "SELECT MAX(work_hours_time_work) as work_hours_time_work" + " FROM work_hours "
					+ " WHERE user_create =:user " + " AND  work_hours_type = 1 ";
			*/
			String sql = "SELECT work_hours_time_work, work_type FROM work_hours WHERE user_create =:user "
					+ " AND work_hours_type = 1 ORDER BY work_hours_id DESC LIMIT 1";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("user", user);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			work_status = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return work_status;
	}

	@Override
	public List<Map<String, Object>> lastcheckin2(String user) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> work_status = null;
		try {
			String sql = "SELECT date_format(work_hours_time_work, '%d-%m-%Y') as work_hours_time_work FROM work_hours WHERE user_create =:user "
					+ " AND work_hours_type = 1 ORDER BY work_hours_id DESC LIMIT 2";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("user", user);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			work_status = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return work_status;
	}
	
	@Override
	public List<Map<String, Object>> lastcheckout(String user) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> work_status = null;
		try {
			/*
			String sql = "SELECT MAX(work_hours_time_work) as work_hours_time_work" + " FROM work_hours "
					+ " WHERE user_create =:user " + " AND  work_hours_type =  2";
			*/
			String sql = "SELECT work_hours_time_work, work_type FROM work_hours WHERE user_create =:user "
					+ " AND work_hours_type = 2 ORDER BY work_hours_id DESC LIMIT 1";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("user", user);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			work_status = query.list();
			Log.info("helloooooooooo");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return work_status;
	}
	
	@Override
	public List<Map<String, Object>> lastcheck(String user) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> work_status = null;
		try {

			String sql = "SELECT MAX(work_hours_time_work) as work_hours_time_work, work_hours_type "
					+ " FROM work_hours WHERE user_create =:user ";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("user", user);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			work_status = query.list();
			Log.info("helloooooooooo");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return work_status;
	}

	@Override
	public List<Map<String, Object>> checklistcalendarstime(String datecheckin, String currentUserlist, String month,
			String year) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> work_status = null;
		try {

			String sql = "select workinghours AS mytimecheckout " + " from work_hours "
					+ " where DATE(work_hours_time_work)=:datecheckin AND user_create = :currentUserlist AND YEAR(work_hours_time_work)=:year AND MONTH(work_hours_time_work)=:month AND work_hours_type=2 "
					+ " ORDER BY work_hours_id DESC " + " LIMIT 1 ";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("datecheckin", datecheckin);
			query.setParameter("currentUserlist", currentUserlist);
			query.setParameter("month", month);
			query.setParameter("year", year);
			/*
			 * query.setParameter("Datenow", Datenow); query.setParameter("DateBefore",
			 * DateBefore);
			 */
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			work_status = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return work_status;
	}

	@Override
	public List<Map<String, Object>> checklistapprove(String currentUserlist, java.sql.Timestamp Datenow,
			java.sql.Timestamp DateBefore, String month, String year) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> work_status = null;
		try {

			String sql = "select hour(m.work_hours_time_work) AS myhour, DATE(work_hours_time_work) AS checkDate, minute(m.work_hours_time_work) "
					+ " AS mymin,work_hours_id,work_hours_type,work_hours_time_work,user_create,time_create,ip_address,description "
					+ " from work_hours m "
					+ " where user_create = :currentUserlist AND YEAR(work_hours_time_work)=:year AND MONTH(work_hours_time_work)=:month "
					+ " AND work_hours_type = 1 " + " ORDER BY work_hours_id ASC ";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("currentUserlist", currentUserlist);
			query.setParameter("month", month);
			query.setParameter("year", year);
			/*
			 * query.setParameter("Datenow", Datenow); query.setParameter("DateBefore",
			 * DateBefore);
			 */
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			work_status = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return work_status;
	}

	@Override
	public List<Map<String, Object>> checklistapprovecheckout(String currentUserlist, java.sql.Timestamp Datenow,
			java.sql.Timestamp DateBefore, String month, String year) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> work_status = null;
		try {

			String sql = "select hour(m.work_hours_time_work) AS myhour, DATE(work_hours_time_work) AS checkDate, minute(m.work_hours_time_work) "
					+ " AS mymin,work_hours_id,work_hours_type,work_hours_time_work,user_create,time_create,ip_address,description "
					+ " from work_hours m "
					+ " where user_create = :currentUserlist AND YEAR(work_hours_time_work)=:year AND MONTH(work_hours_time_work)=:month "
					+ " AND work_hours_type = 2 " + " ORDER BY work_hours_id ASC ";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("currentUserlist", currentUserlist);
			query.setParameter("month", month);
			query.setParameter("year", year);
			/*
			 * query.setParameter("Datenow", Datenow); query.setParameter("DateBefore",
			 * DateBefore);
			 */
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			work_status = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return work_status;
	}

	@Override
	public List<Map<String, Object>> checklistapprovestatus(String currentUserlist, java.sql.Timestamp Datenow,
			java.sql.Timestamp DateBefore, String month, String year) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> work_status = null;
		try {

			String sql = "select hour(m.work_hours_time_work) AS myhour, DATE(work_hours_time_work) AS checkDate, minute(m.work_hours_time_work) "
					+ " AS mymin,work_hours_id,work_hours_type,work_hours_time_work,user_create,time_create,ip_address,description "
					+ " from work_hours m "
					+ " where user_create = :currentUserlist AND YEAR(work_hours_time_work)=:year AND MONTH(work_hours_time_work)=:month "
					+ " AND work_hours_type = 1 " + " ORDER BY work_hours_id ASC ";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("currentUserlist", currentUserlist);
			query.setParameter("month", month);
			query.setParameter("year", year);
			/*
			 * query.setParameter("Datenow", Datenow); query.setParameter("DateBefore",
			 * DateBefore);
			 */
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			work_status = query.list();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return work_status;
	}

	@Override
	public List<Map<String, Object>> checklistapprovestatusall(String currentUserlist, java.sql.Timestamp Datenow,
			java.sql.Timestamp DateBefore, String month, String year) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> work_status = null;
		try {

			String sql = "select hour(m.work_hours_time_work) AS myhour, DATE(work_hours_time_work) AS checkDate, minute(m.work_hours_time_work) "
					+ " AS mymin,work_hours_id,work_hours_type,work_hours_time_work,user_create,time_create,ip_address,description "
					+ " from work_hours m "
					+ " where user_create = :currentUserlist AND YEAR(work_hours_time_work)=:year AND MONTH(work_hours_time_work)=:month "
					+ " ORDER BY work_hours_id ASC ";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("currentUserlist", currentUserlist);
			query.setParameter("month", month);
			query.setParameter("year", year);
			/*
			 * query.setParameter("Datenow", Datenow); query.setParameter("DateBefore",
			 * DateBefore);
			 */
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			work_status = query.list();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return work_status;
	}

	@Override
	public List<Map<String, Object>> checklistapprovestatusall1(String currentUserlist, java.sql.Timestamp Datenow,
			java.sql.Timestamp DateBefore, String month, String year) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> work_status = null;
		try {

			String sql = "select workinghours " + " from work_hours "
					+ " where user_create = :currentUserlist AND YEAR(work_hours_time_work)=:year AND MONTH(work_hours_time_work)=:month "
					+ " ORDER BY work_hours_id ASC ";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("currentUserlist", currentUserlist);
			query.setParameter("month", month);
			query.setParameter("year", year);
			/*
			 * query.setParameter("Datenow", Datenow); query.setParameter("DateBefore",
			 * DateBefore);
			 */
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			work_status = query.list();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return work_status;
	}

	@Override
	public List<Map<String, Object>> timecheckout(String currentUserlist, java.sql.Timestamp Datenow,
			java.sql.Timestamp DateBefore, String month, String year) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> timecheckout = null;
		try {

			String sql = "select work_hours_time_work " + " from work_hours "
					+ " where user_create = :currentUserlist AND YEAR(work_hours_time_work)=:year AND MONTH(work_hours_time_work)=:month "
					+ " AND work_hours_type = 2 " + " ORDER BY work_hours_id ASC ";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("currentUserlist", currentUserlist);
			query.setParameter("month", month);
			query.setParameter("year", year);
			/*
			 * query.setParameter("Datenow", Datenow); query.setParameter("DateBefore",
			 * DateBefore);
			 */
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			timecheckout = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return timecheckout;
	}

	/* edit search check list */
	@Override
	public List<Map<String, Object>> searchList(String Username, java.sql.Timestamp Datestart,
			java.sql.Timestamp Dateend) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> work_status = null;
		try {
			String sql = "select hour(m.work_hours_time_work) AS myhour, minute(m.work_hours_time_work) AS mymin, description "
					+ " ,m.work_hours_id,m.work_hours_type,m.user_create,m.time_create,m.ip_address,m.latitude,"
					+ " m.longitude,m.work_hours_time_work,date_format(m.work_hours_time_work,'%d-%m-%y')as `date`,"
					+ " time(m.work_hours_time_work)as `time`,u.role_id as 'u_rold',u.name as 'u_name',m.work_hours_type as `check_type`"
					+ " FROM work_hours m " + " inner join `user` u on m.user_create = u.id"
					+ " WHERE user_create = :Username AND work_hours_time_work BETWEEN :Datestart AND :Dateend "
					+ " ORDER BY work_hours_id ASC ";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("Username", Username);
			query.setParameter("Datestart", Datestart);
			query.setParameter("Dateend", Dateend);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			work_status = query.list();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return work_status;
	}

	@Override
	public List<Map<String, Object>> worksearchapprove(String Username, java.sql.Timestamp Datestart,
			java.sql.Timestamp Dateend) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> work_status = null;
		try {

			String sql = "select hour(m.work_hours_time_work) AS myhour, minute(m.work_hours_time_work) "
					+ " AS mymin,work_hours_id,work_hours_type,work_hours_time_work,user_create,time_create,ip_address,description "
					+ " from work_hours m "
					+ " WHERE user_create = :Username AND work_hours_time_work BETWEEN :Datestart AND :Dateend "
					+ " AND work_hours_type = 2 " + " ORDER BY work_hours_id ASC";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("Username", Username);
			query.setParameter("Datestart", Datestart);
			query.setParameter("Dateend", Dateend);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			work_status = query.list();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return work_status;
	}

	@Override
	public List<Map<String, Object>> worksearchapproveall(String Username, java.sql.Timestamp Datestart,
			java.sql.Timestamp Dateend) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> work_status = null;
		try {

			String sql = "select hour(m.work_hours_time_work) AS myhour, minute(m.work_hours_time_work) "
					+ " AS mymin,work_hours_id,work_hours_type,work_hours_time_work,user_create,time_create,ip_address,description "
					+ " from work_hours m "
					+ " WHERE user_create = :Username AND work_hours_time_work BETWEEN :Datestart AND :Dateend "
					+ " ORDER BY work_hours_id ASC";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("Username", Username);
			query.setParameter("Datestart", Datestart);
			query.setParameter("Dateend", Dateend);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			work_status = query.list();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return work_status;
	}

	public List<Map<String, Object>> searchHis(String Username, java.sql.Timestamp Datestart,
			java.sql.Timestamp Dateend) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> work_status = null;
		try {

			String sql = "select hour(m.work_hours_time_work) AS myhour, minute(m.work_hours_time_work) "
					+ " AS mymin,work_hours_id,work_hours_type,work_hours_time_work,user_create,time_create,ip_address,description "
					+ " from work_hours m "
					+ " WHERE user_create = :Username AND work_hours_time_work BETWEEN :Datestart AND :Dateend "
					+ " AND work_hours_type = 2 " + " ORDER BY  work_hours_id ASC ";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("Username", Username);
			query.setParameter("Datestart", Datestart);
			query.setParameter("Dateend", Dateend);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			work_status = query.list();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return work_status;
	}

	public List<Map<String, Object>> checkIn(String Username) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> work_status = null;
		try {
			String Username_value = "";
			if (Username != "") {
				Username_value = " WHERE user_create = :Username ";
			}
			String sql = "SELECT work_hours_type,time_create FROM work_hours " + Username_value
					+ " ORDER BY work_hours_id DESC " + " LIMIT 1 ";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("Username", Username);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			work_status = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return work_status;
	}

	@Override
	public List<Map<String, Object>> checkinhourtime(String currentUserlist, java.sql.Timestamp Datenow,
			java.sql.Timestamp DateBefore) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> checkinhourtime = null;
		try {

			String sql = "select hour(m.work_hours_time_work) AS myinhourtime " + " from work_hours m "
					+ " where user_create = :currentUserlist "
					+ " AND work_hours_time_work BETWEEN :DateBefore AND :Datenow AND work_hours_type =1 "
					+ " ORDER BY work_hours_id ASC ";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("currentUserlist", currentUserlist);
			query.setParameter("Datenow", Datenow);
			query.setParameter("DateBefore", DateBefore);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			checkinhourtime = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return checkinhourtime;
	}

	@Override
	public List<Map<String, Object>> checkouthourtime(String currentUserlist, java.sql.Timestamp Datenow,
			java.sql.Timestamp DateBefore) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> checkouthourtime = null;
		try {

			String sql = "select hour(m.work_hours_time_work) AS myouthourtime " + " from work_hours m "
					+ " where user_create = :currentUserlist "
					+ " AND work_hours_time_work BETWEEN :DateBefore AND :Datenow AND work_hours_type =2 "
					+ " ORDER BY work_hours_id ASC ";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("currentUserlist", currentUserlist);
			query.setParameter("Datenow", Datenow);
			query.setParameter("DateBefore", DateBefore);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			checkouthourtime = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return checkouthourtime;
	}

	@Override
	public List<Map<String, Object>> checkinmintime(String currentUserlist, java.sql.Timestamp Datenow,
			java.sql.Timestamp DateBefore) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> checkinmintime = null;
		try {

			String sql = "select minute(m.work_hours_time_work) AS checkinmintime " + " from work_hours m "
					+ " where user_create = :currentUserlist "
					+ " AND work_hours_time_work BETWEEN :DateBefore AND :Datenow AND work_hours_type =1 "
					+ " ORDER BY work_hours_id ASC ";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("currentUserlist", currentUserlist);
			query.setParameter("Datenow", Datenow);
			query.setParameter("DateBefore", DateBefore);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			checkinmintime = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return checkinmintime;
	}

	@Override
	public List<Map<String, Object>> checkoutmintime(String currentUserlist, java.sql.Timestamp Datenow,
			java.sql.Timestamp DateBefore) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> checkoutmintime = null;
		try {

			String sql = "select minute(m.work_hours_time_work) AS checkoutmintime " + " from work_hours m "
					+ " where user_create = :currentUserlist "
					+ " AND work_hours_time_work BETWEEN :DateBefore AND :Datenow AND work_hours_type =2 "
					+ " ORDER BY work_hours_id ASC ";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("currentUserlist", currentUserlist);
			query.setParameter("Datenow", Datenow);
			query.setParameter("DateBefore", DateBefore);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			checkoutmintime = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return checkoutmintime;
	}

	@Override
	public List<Map<String, Object>> searchcheckinhourtime(String Username, java.sql.Timestamp Datestart,
			java.sql.Timestamp Dateend) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> searchcheckinhourtime = null;
		try {

			String sql = "select workinghours " + " from work_hours "
					+ " WHERE user_create = :Username AND work_hours_time_work BETWEEN :Datestart AND :Dateend "
					+ " ORDER BY work_hours_id ASC";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("Username", Username);
			query.setParameter("Datestart", Datestart);
			query.setParameter("Dateend", Dateend);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			searchcheckinhourtime = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return searchcheckinhourtime;
	}

	@Override
	public List<Map<String, Object>> searchcheckinhourtimeapprove(String Username, java.sql.Timestamp Datestart,
			java.sql.Timestamp Dateend) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> searchcheckinhourtime = null;
		try {

			String sql = "select workinghours " + " from work_hours "
					+ " WHERE user_create = :Username AND work_hours_time_work BETWEEN :Datestart AND :Dateend "
					+ " AND work_hours_type = 2 " + " ORDER BY work_hours_id ASC";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("Username", Username);
			query.setParameter("Datestart", Datestart);
			query.setParameter("Dateend", Dateend);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			searchcheckinhourtime = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return searchcheckinhourtime;
	}

	@Override
	public List<Map<String, Object>> checktimehours(String currentUserlist, String date, String month, String year)
			throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> checktimehours = null;
		try {

			String sql = " select hour(work_hours_time_work) "
					+ " FROM work_hours WHERE user_create =:currentUserlist AND DAY(work_hours_time_work)=:date AND YEAR(work_hours_time_work)=:year "
					+ " AND MONTH(work_hours_time_work)=:month AND work_hours_type=1 ORDER BY work_hours_id DESC LIMIT 1";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("currentUserlist", currentUserlist);
			query.setParameter("date", date);
			query.setParameter("month", month);
			query.setParameter("year", year);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			checktimehours = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return checktimehours;
	}

	@Override
	public List<Map<String, Object>> check_in(String currentUserlist) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> check_in = null;
		try {

			String sql = " select DAY(work_hours_time_work) " + " FROM work_hours WHERE user_create =:currentUserlist "
					+ " AND work_hours_type=1 ORDER BY work_hours_id DESC LIMIT 1 ";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("currentUserlist", currentUserlist);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			check_in = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return check_in;
	}

	@Override
	public List<Map<String, Object>> checktimemin(String currentUserlist, String date, String month, String year)
			throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> checktimemin = null;
		try {

			String sql = "select minute(m.work_hours_time_work) AS myinhourtime " + " from work_hours m "
					+ " where user_create = :currentUserlist "
					+ " AND work_hours_type =1 AND DAY(work_hours_time_work)=:date AND YEAR(work_hours_time_work)=:year  "
					+ " AND MONTH(work_hours_time_work)=:month ORDER BY work_hours_id DESC " + " LIMIT 1";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("currentUserlist", currentUserlist);
			query.setParameter("date", date);
			query.setParameter("month", month);
			query.setParameter("year", year);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			checktimemin = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return checktimemin;
	}

	@Override
	public List<Map<String, Object>> usertype1(String currentUserlist) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> usertype1 = null;
		try {

			String sql = "select TIME(work_hours_time_work) " + " from work_hours "
					+ " where user_create = :currentUserlist AND work_hours_type =1 " + " ORDER BY work_hours_id DESC "
					+ " LIMIT 1";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("currentUserlist", currentUserlist);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			usertype1 = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return usertype1;
	}

	@Override
	public List<Map<String, Object>> checkdate(String currentUserlist) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> checkdate = null;
		try {

			String sql = "select DATE(work_hours_time_work) " + " from work_hours m "
					+ " where user_create = :currentUserlist " + " AND work_hours_type =1 "
					+ " ORDER BY work_hours_id DESC " + " LIMIT 1";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("currentUserlist", currentUserlist);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			checkdate = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return checkdate;
	}

	@Override
	public List<Map<String, Object>> checktime(String currentUserlist, String month, String year) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> checktime = null;
		try {

			String sql = "select workinghours " + " from work_hours "
					+ " where user_create = :currentUserlist AND YEAR(work_hours_time_work)=:year AND MONTH(work_hours_time_work)=:month "
					+ " ORDER BY work_hours_id ASC ";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("currentUserlist", currentUserlist);
			query.setParameter("month", month);
			query.setParameter("year", year);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			checktime = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return checktime;
	}

	@Override
	public List<Map<String, Object>> checktimecalendar(String currentUserlist, String month, String year)
			throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> checktime = null;
		try {

			String sql = "select workinghours " + " from work_hours "
					+ " where user_create = :currentUserlist AND YEAR(work_hours_time_work)=:year AND MONTH(work_hours_time_work)=:month AND work_hours_type =2 "
					+ " ORDER BY work_hours_id ASC ";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("currentUserlist", currentUserlist);
			query.setParameter("month", month);
			query.setParameter("year", year);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			checktime = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return checktime;
	}

	@Override
	public List<Map<String, Object>> checktimeapprove(String currentUserlist, String month, String year)
			throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> checktime = null;
		try {

			String sql = "select workinghours " + " from work_hours "
					+ " where user_create = :currentUserlist AND YEAR(work_hours_time_work)=:year AND MONTH(work_hours_time_work)=:month "
					+ " AND work_hours_type = 2 " + " ORDER BY work_hours_id ASC ";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("currentUserlist", currentUserlist);
			query.setParameter("month", month);
			query.setParameter("year", year);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			checktime = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return checktime;
	}

	@Override
	public List<Map<String, Object>> timecheckin(String currentUserlist) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> timecheckin = null;
		try {

			String sql = "select TIME(work_hours_time_work) " + " from work_hours "
					+ " where user_create = :currentUserlist " + " AND work_hours_type =1 "
					+ " ORDER BY work_hours_id DESC " + " LIMIT 1";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("currentUserlist", currentUserlist);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			timecheckin = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return timecheckin;
	}

	@Override
	public List<Map<String, Object>> datecheckin(String currentUserlist) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> datechechin = null;
		try {

			String sql = "select DATE(work_hours_time_work) " + " from work_hours "
					+ " where user_create = :currentUserlist " + " AND work_hours_type =1 "
					+ " ORDER BY work_hours_id DESC " + " LIMIT 1";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("currentUserlist", currentUserlist);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			datechechin = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return datechechin;
	}

	@Override
	public List<Map<String, Object>> startmonth(String currentUserlist, String month, String year) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> startmonth = null;
		try {

			String sql = "select DATE(work_hours_time_work) AS datestart " + " from work_hours m "
					+ " where user_create = :currentUserlist AND YEAR(work_hours_time_work)=:year AND MONTH(work_hours_time_work)=:month "
					+ " ORDER BY work_hours_id ASC " + " LIMIT 1";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("currentUserlist", currentUserlist);
			query.setParameter("month", month);
			query.setParameter("year", year);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			startmonth = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return startmonth;
	}

	@Override
	public List<Map<String, Object>> searchListall(java.sql.Timestamp Datestart, java.sql.Timestamp Dateend)
			throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> searchListall = null;
		try {
			String sql = "select hour(m.work_hours_time_work) AS myhour, minute(m.work_hours_time_work) AS mymin, description "
					+ " ,m.work_hours_id,m.work_hours_type,m.user_create,m.time_create,m.ip_address,m.latitude,"
					+ " m.longitude,m.work_hours_time_work,date_format(m.work_hours_time_work,'%d-%m-%y')as `date`,"
					+ " time(m.work_hours_time_work)as `time`,u.role_id as 'u_rold',u.name as 'u_name',m.work_hours_type as `check_type`"
					+ " FROM work_hours m " + " inner join `user` u on m.user_create = u.id"
					+ " WHERE work_hours_time_work BETWEEN :Datestart AND :Dateend " + " ORDER BY work_hours_id ASC ";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("Datestart", Datestart);
			query.setParameter("Dateend", Dateend);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			searchListall = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return searchListall;
	}

	@Override
	public List<Map<String, Object>> workallTime() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> searchListall = null;
		try {
			String sql = "SELECT id,work_time_start FROM user";

			SQLQuery query = session.createSQLQuery(sql);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			searchListall = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return searchListall;
	}

	@Override
	public List<Map<String, Object>> searchListallapprove(java.sql.Timestamp Datestart, java.sql.Timestamp Dateend)
			throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> searchListall = null;
		try {
			String sql = "select hour(m.work_hours_time_work) AS myhour, minute(m.work_hours_time_work) AS mymin "
					+ " ,m.work_hours_id,m.work_hours_type,m.work_hours_time_work,m.user_create,m.time_create,m.ip_address,description "
					+ " FROM work_hours m " + " WHERE work_hours_time_work BETWEEN :Datestart AND :Dateend "
					+ " AND work_hours_type = 2 " + " ORDER BY work_hours_id ASC ";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("Datestart", Datestart);
			query.setParameter("Dateend", Dateend);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			searchListall = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return searchListall;
	}

	@Override
	public List<Map<String, Object>> searchListallapprovecheckin(java.sql.Timestamp Datestart,
			java.sql.Timestamp Dateend) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> searchListallcheckin = null;
		try {
			String sql = "select hour(m.work_hours_time_work) AS myhour, minute(m.work_hours_time_work) AS mymin "
					+ " ,m.work_hours_id,m.work_hours_type,m.work_hours_time_work,m.user_create,m.time_create,m.ip_address,description "
					+ " FROM work_hours m " + " WHERE work_hours_time_work BETWEEN :Datestart AND :Dateend "
					+ " AND work_hours_type = 1 " + " ORDER BY work_hours_id ASC ";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("Datestart", Datestart);
			query.setParameter("Dateend", Dateend);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			searchListallcheckin = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return searchListallcheckin;
	}

	@Override
	public List<Map<String, Object>> searchListallapprovecheckinuser(String currentUserlist,
			java.sql.Timestamp Datestart, java.sql.Timestamp Dateend) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> searchListallcheckin = null;
		try {
			String sql = "select hour(m.work_hours_time_work) AS myhour, minute(m.work_hours_time_work) AS mymin "
					+ " ,m.work_hours_id,m.work_hours_type,m.work_hours_time_work,m.user_create,m.time_create,m.ip_address,description "
					+ " FROM work_hours m "
					+ " WHERE work_hours_time_work BETWEEN :Datestart AND :Dateend AND user_create = :currentUserlist "
					+ " AND work_hours_type = 1 " + " ORDER BY work_hours_id ASC ";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("currentUserlist", currentUserlist);
			query.setParameter("Datestart", Datestart);
			query.setParameter("Dateend", Dateend);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			searchListallcheckin = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return searchListallcheckin;
	}

	@Override
	public List<Map<String, Object>> searchListalltime(java.sql.Timestamp Datestart, java.sql.Timestamp Dateend)
			throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> searchListalltime = null;
		try {
			String sql = "select workinghours " + " FROM work_hours m "
					+ " WHERE work_hours_time_work BETWEEN :Datestart AND :Dateend " + " ORDER BY work_hours_id ASC ";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("Datestart", Datestart);
			query.setParameter("Dateend", Dateend);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			searchListalltime = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return searchListalltime;
	}

	@Override
	public List<Map<String, Object>> searchListalltimeapprove(java.sql.Timestamp Datestart, java.sql.Timestamp Dateend)
			throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> searchListalltime = null;
		try {
			String sql = "select workinghours " + " FROM work_hours m "
					+ " WHERE work_hours_time_work BETWEEN :Datestart AND :Dateend " + " AND work_hours_type = 2 "
					+ " ORDER BY work_hours_id ASC ";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("Datestart", Datestart);
			query.setParameter("Dateend", Dateend);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			searchListalltime = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return searchListalltime;
	}

	public List<Map<String, Object>> searchHisall(java.sql.Timestamp Datestart, java.sql.Timestamp Dateend)
			throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> searchHisall = null;
		try {

			String sql = "select hour(m.work_hours_time_work) AS myhour, minute(m.work_hours_time_work) "
					+ " AS mymin,work_hours_id,work_hours_type,work_hours_time_work,user_create,time_create,ip_address,description "
					+ " from work_hours m " + " WHERE work_hours_time_work BETWEEN :Datestart AND :Dateend "
					+ " AND work_hours_type = 2 " + " ORDER BY  work_hours_id ASC ";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("Datestart", Datestart);
			query.setParameter("Dateend", Dateend);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			searchHisall = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return searchHisall;
	}

	@Override
	public List<Map<String, Object>> checkin(String usercheck, String y, String m, String d) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> checkintime = null;
		try {
			String sql = "SELECT work_hours_id " + " FROM work_hours "
					+ " WHERE YEAR(work_hours_time_work)=:y AND work_hours_type=1 "
					+ " AND MONTH(work_hours_time_work)=:m AND DAY(work_hours_time_work)=:d AND user_create=:usercheck "
					+ " ORDER BY work_hours_id DESC " + " LIMIT 1	";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("usercheck", usercheck);
			query.setParameter("y", y);
			query.setParameter("m", m);
			query.setParameter("d", d);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			checkintime = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return checkintime;
	}

	@Override
	public List<Map<String, Object>> idtoday(String usercheck, String y, String m, String d) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> idtoday = null;
		try {
			String sql = "SELECT work_hours_id " + " FROM work_hours "
					+ " WHERE YEAR(work_hours_time_work)=:y AND work_hours_type=2 "
					+ " AND MONTH(work_hours_time_work)=:m AND DAY(work_hours_time_work)=:d AND user_create=:usercheck "
					+ " ORDER BY work_hours_id ASC " + " LIMIT 1 ";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("usercheck", usercheck);
			query.setParameter("y", y);
			query.setParameter("m", m);
			query.setParameter("d", d);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			idtoday = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return idtoday;
	}

	@Override
	public List<Map<String, Object>> hourtimeidtodaycheckin(String usercheck, String id) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> idtodaycheckin = null;
		try {

			String sql = " SELECT hour(work_hours_time_work) FROM work_hours "
					+ " WHERE work_hours_id < :id AND work_hours_type=1 AND user_create=:usercheck  "
					+ " ORDER By work_hours_id DESC LIMIT 1 ";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("usercheck", usercheck);
			query.setParameter("id", id);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			idtodaycheckin = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return idtodaycheckin;
	}

	@Override
	public List<Map<String, Object>> mintimeidtodaycheckin(String usercheck, String id) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> idtodaycheckin = null;
		try {

			String sql = " SELECT minute(work_hours_time_work) FROM work_hours "
					+ " WHERE work_hours_id < :id AND work_hours_type=1 AND user_create=:usercheck  "
					+ " ORDER By work_hours_type DESC LIMIT 1 ";
			/*
			 * String sql = "SELECT work_hours_id " + " FROM work_hours " +
			 * " WHERE work_hours_id < id AND work_hours_type=1 ORDER BY work_hours_id DESC "
			 * + " LIMIT 1 ";
			 */
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("usercheck", usercheck);
			query.setParameter("id", id);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			idtodaycheckin = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return idtodaycheckin;
	}

	@Override
	public List<Map<String, Object>> fullidtimecheckout(String usercheck, String y, String m, String d)
			throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> fullidtimecheckout = null;
		try {
			String sql = "SELECT work_hours_id " + " FROM work_hours "
					+ " WHERE YEAR(work_hours_time_work)=:y AND work_hours_type=2 "
					+ " AND MONTH(work_hours_time_work)=:m AND DAY(work_hours_time_work)=:d AND user_create=:usercheck ";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("usercheck", usercheck);
			query.setParameter("y", y);
			query.setParameter("m", m);
			query.setParameter("d", d);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			fullidtimecheckout = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return fullidtimecheckout;
	}

	@Override
	public List<Map<String, Object>> searchidcheckintomorrow(String usercheck, String idcheckintoday) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> searchidcheckintomorrow = null;
		try {
			String sql = "SELECT work_hours_id " + " FROM work_hours " + " WHERE work_hours_type=2 "
					+ " AND work_hours_id >:idcheckintoday AND user_create=:usercheck " + " ORDER BY work_hours_id ASC "
					+ " LIMIT 1 ";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("usercheck", usercheck);
			query.setParameter("idcheckintoday", idcheckintoday);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			searchidcheckintomorrow = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return searchidcheckintomorrow;
	}

	@Override
	public List<Map<String, Object>> searchtimehourcheckintomorrow(String usercheck, String idcheckintoday)
			throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> searchidcheckintomorrow = null;
		try {
			String sql = "SELECT hour(work_hours_time_work) " + " FROM work_hours " + " WHERE work_hours_type=2 "
					+ " AND work_hours_id >:idcheckintoday AND user_create=:usercheck " + " ORDER BY work_hours_id ASC "
					+ " LIMIT 1 ";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("usercheck", usercheck);
			query.setParameter("idcheckintoday", idcheckintoday);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			searchidcheckintomorrow = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return searchidcheckintomorrow;
	}

	@Override
	public List<Map<String, Object>> searchtimemincheckintomorrow(String usercheck, String idcheckintoday)
			throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> searchidcheckintomorrow = null;
		try {
			String sql = "SELECT minute(work_hours_time_work) " + " FROM work_hours " + " WHERE work_hours_type=2 "
					+ " AND work_hours_id >:idcheckintoday AND user_create=:usercheck " + " ORDER BY work_hours_id ASC "
					+ " LIMIT 1 ";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("usercheck", usercheck);
			query.setParameter("idcheckintoday", idcheckintoday);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			searchidcheckintomorrow = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return searchidcheckintomorrow;
	}

	@Override
	public List<Map<String, Object>> timeidcheckouthour(String id) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> timeidcheckout = null;
		try {
			String sql = "SELECT hour(work_hours_time_work) AS myhour " + " FROM work_hours "
					+ " WHERE work_hours_id=:id ";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("id", id);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			timeidcheckout = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return timeidcheckout;
	}

	@Override
	public List<Map<String, Object>> timeidcheckoutmin(String id) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> timeidcheckout = null;
		try {
			String sql = "SELECT minute(work_hours_time_work) AS minute " + " FROM work_hours "
					+ " WHERE work_hours_id=:id ";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("id", id);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			timeidcheckout = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return timeidcheckout;
	}

	@Override
	public List<Map<String, Object>> checkin1(String usercheck) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> checkintime1 = null;
		try {
			String sql = "SELECT work_hours_id " + " FROM work_hours "
					+ " WHERE user_create=:usercheck AND work_hours_type=1 " + " ORDER BY work_hours_id DESC "
					+ " LIMIT 1	";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("usercheck", usercheck);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			checkintime1 = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return checkintime1;
	}

	@Override
	public List<Map<String, Object>> timecheckin1(String id) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> timecheckin1 = null;
		try {
			String sql = " SELECT hour(work_hours_time_work) " + " FROM work_hours " + " WHERE work_hours_id=:id ";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("id", id);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			timecheckin1 = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return timecheckin1;
	}

	@Override
	public List<Map<String, Object>> timecheckin2(String id) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> timecheckin2 = null;
		try {
			String sql = " SELECT minute(work_hours_time_work) " + " FROM work_hours " + " WHERE work_hours_id=:id ";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("id", id);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			timecheckin2 = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return timecheckin2;
	}

	@Override
	public WorkHours findById(int id) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		WorkHours workHours = null;
		try {
			workHours = (WorkHours) session.get(WorkHours.class, id);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return workHours;
	}

	// OAT

	public List<Map<String, Object>> graph_workhours(String user, String year) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> work_status = null;
		try {

			String sql = " SELECT work_hours_time_work  FROM work_hours  WHERE work_hours_type= 1 and user_create=:user "
					+ "and date(work_hours_time_work) LIKE '%" + year + "%' "
					// "and date(work_hours_time_work) >=:year and date(work_hours_time_work)
					// <=:year ";
					+ "order by date(work_hours_time_work) asc";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("user", user);
			// query.setParameter("year", year);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			work_status = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return work_status;
	}

	public List<Map<String, Object>> graph_workhours_out(String user, String year) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> work_status = null;
		try {

			String sql = " SELECT work_hours_time_work,workinghours  FROM work_hours  WHERE work_hours_type= 2 and user_create=:user "
					+ "and date(work_hours_time_work) LIKE '%" + year + "%' "
					+ "order by date(work_hours_time_work) asc";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("user", user);
			// query.setParameter("year", year);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			work_status = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return work_status;
	}

	public List<String> graph_workhours_avg_in(String year) throws Exception {
		// TODO Auto-generated method stub
		Session session = this.sessionFactory.getCurrentSession();
		List<String> work_status = null;
		try {

			String sql = " SELECT  TIME_FORMAT(SEC_TO_TIME(AVG(TIME_TO_SEC(work_hours_time_work))),'%Hh %im')  FROM work_hours  WHERE work_hours_type= 1 "
					+ "and date(work_hours_time_work) LIKE '%" + year + "%' ";

			SQLQuery query = session.createSQLQuery(sql);

			// query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			work_status = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return work_status;

	}

	public String graph_workhours_out_avg(String year) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		String work_status = null;
		try {
			String sql = " SELECT TIME_FORMAT(SEC_TO_TIME(AVG(TIME_TO_SEC(work_hours_time_work))),'%H:%i:%s')  FROM work_hours  WHERE work_hours_type= 2 "
					+ "and date(work_hours_time_work) LIKE '%" + year + "%' ";
			SQLQuery query = session.createSQLQuery(sql);

			work_status = query.uniqueResult().toString();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return work_status;

	}

	public String graph_workhours_in_avg(String year) throws Exception { // à¹€à¸˜à¸ƒà¸¢Â à¹€à¸˜à¸‚à¹€à¸˜ï¿½à¹€à¸™ï¿½à¹�à¸Ÿà¸�à¹€à¸˜ï¿½à¹€à¸˜à¸ƒà¸¢Â à¹€à¸˜à¸‚à¹€à¸˜ï¿½à¹€à¸™ï¿½à¹‚ï¿½à¸Œà¹€à¸˜ï¿½à¹€à¸˜à¸ƒà¸¢Â à¹€à¸˜à¸‚à¹€à¸˜ï¿½à¹€à¸˜à¸‚à¹€à¸˜â€¦à¹€à¸˜à¸ƒà¸¢Â à¹€à¸˜à¸‚à¹€à¸˜ï¿½à¹€à¸˜à¸‚à¹€à¸˜â€¢à¹€à¸˜à¸ƒà¸¢Â à¹€à¸˜à¸‚à¹€à¸˜ï¿½à¹€à¸˜à¸‹à¹�à¸Ÿà¸�à¹€à¸˜à¸ƒà¸¢Â à¹€à¸˜à¸‚à¹€à¸˜ï¿½à¹€à¸˜à¸‚à¹€à¸˜ï¿½à¹€à¸˜à¸ƒà¸¢Â à¹€à¸˜à¸‚à¹€à¸˜ï¿½à¹€à¸™ï¿½à¹‚ï¿½à¸Œà¹�à¸Ÿà¸�à¹€à¸˜à¸ƒà¸¢Â à¹€à¸˜à¸‚à¹€à¸˜ï¿½à¹€à¸˜à¸‚à¹€à¸˜ï¿½à¹€à¸˜à¸ƒà¸¢Â à¹€à¸˜à¸‚à¹€à¸˜ï¿½à¹€à¸™ï¿½à¹‚ï¿½à¸Œà¹€à¸˜ï¿½à¹€à¸˜à¸ƒà¸¢Â à¹€à¸˜à¸‚à¹€à¸˜ï¿½à¹€à¸™ï¿½à¹‚ï¿½à¸Œà¹‚â‚¬ï¿½à¹€à¸˜à¸ƒà¸¢Â à¹€à¸˜à¸‚à¹€à¸˜ï¿½à¹€à¸˜à¸‚à¹€à¸˜ï¿½à¹€à¸˜à¸ƒà¸¢Â à¹€à¸˜à¸‚à¹€à¸˜ï¿½à¹€à¸™ï¿½à¹€à¸˜ï¿½à¹€à¸˜ï¿½à¹€à¸˜à¸ƒà¸¢Â à¹€à¸˜à¸‚à¹€à¸˜ï¿½à¹€à¸˜à¸‚à¹€à¸˜ï¿½à¹€à¸˜à¸ƒà¸¢Â à¹€à¸˜à¸‚à¹€à¸˜ï¿½à¹€à¸˜à¸‚à¹€à¸˜â€˜à¹€à¸˜à¸ƒà¸¢Â à¹€à¸˜à¸‚à¹€à¸˜ï¿½à¹€à¸™ï¿½à¹�à¸Ÿà¸�à¹€à¸˜ï¿½
		Session session = this.sessionFactory.getCurrentSession();
		String work_status = null;
		try {
			String sql = " SELECT TIME_FORMAT(SEC_TO_TIME(AVG(TIME_TO_SEC(work_hours_time_work))),'%H:%i:%s')  FROM work_hours  WHERE work_hours_type= 1 "
					+ "and date(work_hours_time_work) LIKE '%" + year + "%' ";
			SQLQuery query = session.createSQLQuery(sql);

			work_status = query.uniqueResult().toString();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return work_status;
	}

	// 18-01-2019
	@Override
	public List<Map<String, Object>> checkInMapAll(java.sql.Timestamp Datestart, java.sql.Timestamp Dateend)
			throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> searchListall = null;
		try {
			String sql = "SELECT w.work_hours_id as `id`, " + " u.name as `name`, " + "u.role_id as `role`, "
					+ "w.latitude as `lat`, " + "w.longitude as `lng`, " + "w.work_hours_type as `check_type`, "
					+ "date_format(w.work_hours_time_work, '%d-%m-%Y') as `date`, "
					+ "time(w.work_hours_time_work) as `time` " + "from work_hours w "
					+ "inner join `user` u on w.user_create = u.id "
					+ "where w.work_hours_time_work between :Datestart AND :Dateend " + "ORDER by w.work_hours_id ASC ";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("Datestart", Datestart);
			query.setParameter("Dateend", Dateend);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			searchListall = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return searchListall;
	}

	@Override
	public List<Map<String, Object>> checkInMap(String name, java.sql.Timestamp Datestart, java.sql.Timestamp Dateend)
			throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> searchListall = null;
		try {
			String sql = "SELECT w.work_hours_id as `id`, " + " u.name as `name`, " + "u.role_id as `role`, "
					+ "w.latitude as `lat`, " + "w.longitude as `lng`, " + "w.work_hours_type as `check_type`, "
					+ "date_format(w.work_hours_time_work, '%d-%m-%Y') as `date`, "
					+ "time(w.work_hours_time_work) as `time` " + "from work_hours w "
					+ "inner join `user` u on w.user_create = u.id "
					+ "where :Name = w.user_create and w.work_hours_time_work between :Datestart AND :Dateend "
					+ "ORDER by w.work_hours_id ASC ";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("Name", name);
			query.setParameter("Datestart", Datestart);
			query.setParameter("Dateend", Dateend);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			searchListall = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return searchListall;
	}

	public List<Map<String, Object>> checkStatusCheckIn(String month, String year, String limit) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> statuscheckin = null;
		try {
			String sql = "SELECT `work_hours_id`,HOUR(`work_hours_time_work`) as hour_time_work, "
					+ "MINUTE(`work_hours_time_work`) as minute_time_work,`user_create`,`name`,COUNT(`user_create`) as count, "
					+ "HOUR(`work_time_start`) as hour_time_start,MINUTE(`work_time_start`) as minute_time_start "
					+ "FROM work_hours LEFT JOIN user on `user_create`= `id` WHERE `work_hours_type` = 1 "
					+ "AND MONTH(`work_hours_time_work`) = " + month + " AND YEAR(`work_hours_time_work`) = " + year
					+ " " + "AND (HOUR(`work_hours_time_work`) < HOUR(`work_time_start`) OR "
					+ "MINUTE(`work_hours_time_work`) < MINUTE(`work_time_start`)) GROUP BY `user_create` ORDER BY count DESC LIMIT "
					+ limit + "";
			SQLQuery query = session.createSQLQuery(sql);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			statuscheckin = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return statuscheckin;
	}

	public List<Map<String, Object>> checkStatusLate(String month, String year, String limit) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> statuscheckin = null;
		try {
			String sql = "SELECT `work_hours_id`,`work_hours_time_work` as hour_time_work,MINUTE(`work_hours_time_work`) as minute_time_work,"
					+ "`user_create`,`name`,COUNT(`user_create`) as count, HOUR(`work_time_start`) as hour_time_start,"
					+ "MINUTE(`work_time_start`) as minute_time_start FROM work_hours LEFT JOIN user on `user_create`= `id` "
					+ "WHERE `work_hours_type` = 1 AND MONTH(`work_hours_time_work`) = " + month
					+ " AND YEAR(`work_hours_time_work`) = " + year + " "
					+ "AND (HOUR(`work_hours_time_work`) > HOUR(`work_time_start`) OR (HOUR(`work_hours_time_work`) = HOUR(`work_time_start`) "
					+ "AND MINUTE(`work_hours_time_work`) > MINUTE(`work_time_start`)))GROUP BY `user_create` ORDER BY count DESC LIMIT "
					+ limit + "";
			SQLQuery query = session.createSQLQuery(sql);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			statuscheckin = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return statuscheckin;
	}

	@Override
	public List<Map<String, Object>> check_work(String currentUserlist, String type) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> check_work = null;
		try {
			String myStr = null;
			if (type != null) {
				myStr = "AND work_hours_type =" + type;
			}
			String sql = " SELECT * FROM `work_hours` " + " WHERE user_create ='" + currentUserlist
					+ "' AND DATE(work_hours_time_work) = CURRENT_DATE " + myStr
					+ " ORDER BY `work_hours_time_work` DESC ";

			SQLQuery query = session.createSQLQuery(sql);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			check_work = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return check_work;
	}

	@Override
	public List<Map<String, Object>> todayLogin(String date) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> data = null;
		try {
			String sql = "SELECT user_create, MAX(work_hours_id) AS work_hours_id, work_hours_type, DATE_FORMAT(time_create,'%d/%m/%Y %H:%i') AS time_create FROM work_hours WHERE DATE(time_create) = '"
					+ date + "' GROUP BY user_create DESC";
			SQLQuery query = session.createSQLQuery(sql);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			data = query.list();
		} catch (

		Exception e) {
			e.printStackTrace();
		}
		return data;
	}

	@Override
	public List<Map<String, Object>> getTodayCheckInById(String id) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> workHours = null;
		try {
			// checkIn case
			String sql = "SELECT * FROM work_hours WHERE user_create = :userId "
					+ "AND work_hours_time_work BETWEEN :dateStart AND :dateEnd "
					+ "AND work_hours_type = 1 order by time_create desc";

			// Get today date for check that user login or not?
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd-MM-yyyy");
			LocalDateTime now = LocalDateTime.now();

			String TodayDate = dtf.format(now); // ex. 14-12-2020

			Timestamp dateStart = DateUtil.myDateStart(TodayDate + " 00:00:00");
			Timestamp dateEnd = DateUtil.myDateStart(TodayDate + " 23:59:59");
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("userId", id);
			query.setParameter("dateStart", dateStart);
			query.setParameter("dateEnd", dateEnd);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			workHours = query.list();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return workHours;
	}

	@Override
	public List<Map<String, Object>> getTodayCheckOutById(String id) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> workHours = null;
		try {
			// checkIn case
			String sql = "SELECT * FROM work_hours WHERE user_create = :userId "
					+ "AND work_hours_time_work BETWEEN :dateStart AND :dateEnd " + "AND work_hours_type = 2";

			// Get today date for check that user login or not?
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd-MM-yyyy");
			LocalDateTime now = LocalDateTime.now();

			String TodayDate = dtf.format(now); // ex. 14-12-2020

			Timestamp dateStart = DateUtil.myDateStart(TodayDate + " 00:00:01");
			Timestamp dateEnd = DateUtil.myDateStart(TodayDate + " 23:59:59");
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("userId", id);
			query.setParameter("dateStart", dateStart);
			query.setParameter("dateEnd", dateEnd);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			workHours = query.list();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return workHours;
	}
	
	@Override
	public List<Map<String, Object>> getTimeByDate(String date, String user, String type) {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> times = null;
		try {
			String sql = "SELECT work_hours_id, work_hours_type, work_hours_time_work FROM work_hours WHERE "
					+ "work_hours_time_work LIKE '" + date + "%' AND " + "user_create = '" + user
					+ "' AND work_hours_type = '" + type + "' " + "ORDER BY work_hours_id DESC LIMIT 1;";
			SQLQuery query = session.createSQLQuery(sql);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			times = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return times;
	}

	@Override
	public List<Map<String, Object>> Work_Hoursesheet(String currentUserlist, java.sql.Timestamp Datenow,
			java.sql.Timestamp DateBefore, String year, String month) throws Exception {

		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> work_status = null;
		try {

			String sql = "SELECT COUNT(work_hours_type) as 'timework', user_create , SUM(workinghours)/60 as workinghours ,  AVG(workinghours)/60 as workinghours1 FROM work_hours"
					+ " where user_create=:user_id AND YEAR(work_hours_time_work)=:year AND work_hours_type = 2  GROUP BY user_create LIMIT 15";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("user_id", currentUserlist);

			query.setParameter("year", year);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			work_status = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return work_status;

	}

	@Override

	public List<Map<String, Object>> Work_Hoursesheettimesearch(String name, String year, String month)
			throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> work_status = null;
		try {

			String sql = "SELECT COUNT(work_hours_type) as 'timework', user_create , SUM(workinghours)/60 as workinghours ,   (SUM(workinghours)/60)/ COUNT(work_hours_type)  as workinghours1 FROM work_hours"
					+ " where user_create=:user_id AND YEAR(work_hours_time_work)=:year AND MONTH(work_hours_time_work)=:month AND work_hours_type = 2  GROUP BY user_create LIMIT 15 Order by user_create";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("user_id", name);
			query.setParameter("month", month);
			query.setParameter("year", year);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			System.out.print(name);
			System.out.print(year);
			work_status = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return work_status;

	}

	@Override
	public List<Map<String, Object>> Work_Hoursesheettimesearch2(String name, String year) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> work_status = null;
		try {

			String sql = "SELECT COUNT(work_hours_type) as 'timework', user_create , SUM(workinghours)/60 as workinghours ,   (SUM(workinghours)/60)/ COUNT(work_hours_type)  as workinghours1 FROM work_hours"
					+ " where user_create=:user_id AND YEAR(work_hours_time_work)=:year AND work_hours_type = 2  GROUP BY user_create LIMIT 15";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("user_id", name);
			query.setParameter("year", year);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			System.out.print(name);
			System.out.print(year);
			work_status = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return work_status;

	}

	@Override
	public List<Map<String, Object>> Work_Hoursesheettimesearchall(String year, String month) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> work_status = null;
		try {

			String sql = "SELECT COUNT(work_hours_type) as 'timework', user_create , SUM(workinghours)/60 as workinghours ,  (SUM(workinghours)/60)/ COUNT(work_hours_type) as workinghours1 FROM work_hours"
					+ " where YEAR(work_hours_time_work)=:year AND MONTH(work_hours_time_work)=:month AND work_hours_type = 2  GROUP BY user_create Order by user_create  ";

			SQLQuery query = session.createSQLQuery(sql);

			query.setParameter("month", month);
			query.setParameter("year", year);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			System.out.print(year);
			work_status = query.list();
		} catch (

		Exception e) {
			e.printStackTrace();
		}
		return work_status;

	}

	@Override
	public List<Map<String, Object>> Work_Hoursesheettimesearchall2(String year) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> work_status = null;
		try {

			String sql = "SELECT COUNT(work_hours_type) as 'timework', user_create , SUM(workinghours)/60 as workinghours ,  (SUM(workinghours)/60)/ COUNT(work_hours_type) as workinghours1 FROM work_hours"
					+ " where YEAR(work_hours_time_work)=:year AND work_hours_type = 2  GROUP BY user_create   ";

			SQLQuery query = session.createSQLQuery(sql);

			query.setParameter("year", year);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			work_status = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return work_status;

	}

	@Override
	public List<Map<String, Object>> Userwork(String username, String month, String year) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> work_status = null;
		try {

			String sql = "SELECT    DISTINCT DATE_FORMAT(work_hours_time_work,\"%d %m %Y\") as work_hours_time_work ,`workinghours`,work_hours_type, user_create  FROM work_hours \r\n"
					+ "where user_create =:username AND YEAR(work_hours_time_work)=:year AND MONTH(work_hours_time_work)=:month AND work_hours_type = 1 Order by user_create";

			SQLQuery query = session.createSQLQuery(sql);

			query.setParameter("username", username);
			query.setParameter("month", month);
			query.setParameter("year", year);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

			work_status = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return work_status;

	}

	@Override
	public List<Map<String, Object>> UserworkOUT(String username, String month, String year) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> work_status = null;
		try {

			String sql = "SELECT    DISTINCT DATE_FORMAT(work_hours_time_work,\"%d %m %Y\") as work_hours_time_work ,`workinghours`,work_hours_type, user_create  FROM work_hours \r\n"
					+ "where user_create =:username AND YEAR(work_hours_time_work)=:year AND MONTH(work_hours_time_work)=:month AND work_hours_type = 2 Order by user_create";

			SQLQuery query = session.createSQLQuery(sql);

			query.setParameter("username", username);
			query.setParameter("month", month);
			query.setParameter("year", year);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

			work_status = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return work_status;

	}

	@Override
	public List<Map<String, Object>> Work_Hoursesheettimesearchall(String year) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Map<String, Object>> UserworkAllMonth(String username, String year) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> work_status = null;
		try {

			String sql = "SELECT    DISTINCT DATE_FORMAT(work_hours_time_work,\"%d %m %Y\") as work_hours_time_work ,`workinghours`,work_hours_type, user_create  FROM work_hours \r\n"
					+ "where user_create =:username AND YEAR(work_hours_time_work)=:year AND work_hours_type = 1 Order by user_create";

			SQLQuery query = session.createSQLQuery(sql);

			query.setParameter("username", username);
			query.setParameter("year", year);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

			work_status = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return work_status;

	}

	@Override
	public List<Map<String, Object>> UserworkAllMonthOUT(String username, String year) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> work_status = null;
		try {

			String sql = "SELECT    DISTINCT DATE_FORMAT(work_hours_time_work,\"%d %m %Y\") as work_hours_time_work ,`workinghours`,work_hours_type, user_create  FROM work_hours \r\n"
					+ "where user_create =:username AND YEAR(work_hours_time_work)=:year AND work_hours_type = 2 Order by user_create";

			SQLQuery query = session.createSQLQuery(sql);

			query.setParameter("username", username);
		
			query.setParameter("year", year);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

			work_status = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return work_status;

	}
	
	@Override
	public List<Map<String, Object>> UserworkYear(String username,String year) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> work_status = null;
		try {

			String sql = "SELECT    DISTINCT DATE_FORMAT(work_hours_time_work,\"%d %m %Y\") as work_hours_time_work ,`workinghours`,work_hours_type, user_create  FROM work_hours \r\n"
					+ "where user_create =:username AND YEAR(work_hours_time_work)=:year  AND work_hours_type = 1 Order by user_create";

			SQLQuery query = session.createSQLQuery(sql);

			query.setParameter("username", username);
			query.setParameter("year", year);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

			work_status = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return work_status;

	}

	@Override
	public List<Map<String, Object>> UserworkOUTYear(String username,  String year) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> work_status = null;
		try {

			String sql = "SELECT    DISTINCT DATE_FORMAT(work_hours_time_work,\"%d %m %Y\") as work_hours_time_work ,`workinghours`,work_hours_type, user_create  FROM work_hours \r\n"
					+ "where user_create =:username AND YEAR(work_hours_time_work)=:year AND work_hours_type = 2 Order by user_create";

			SQLQuery query = session.createSQLQuery(sql);

			query.setParameter("username", username);
			query.setParameter("year", year);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

			work_status = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return work_status;

	}
	
	@Override
	public List<Map<String, Object>> lastusercheckin() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> work_status = null;
		try {

			String sql = "SELECT work_hours.*,user.id ,user.name FROM work_hours LEFT JOIN user ON work_hours.user_create = user.id  WHERE work_hours.work_hours_type = '1' ORDER BY work_hours.work_hours_id DESC LIMIT 0,1";

			SQLQuery query = session.createSQLQuery(sql);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

			work_status = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return work_status;

	}
	
	@Override
	public List<Map<String, Object>> lastusercheckout() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> work_status = null;
		try {

			String sql = "SELECT work_hours.*,user.id ,user.name FROM work_hours LEFT JOIN user ON work_hours.user_create = user.id  WHERE work_hours.work_hours_type = '2' ORDER BY work_hours.work_hours_id DESC LIMIT 0,1";

			SQLQuery query = session.createSQLQuery(sql);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

			work_status = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return work_status;

	}

@Override
public List<Map<String, Object>> checkholiday(String date) throws Exception {
	Session session = this.sessionFactory.getCurrentSession();
	List<Map<String, Object>> work_status = null;
	try {

		String sql = "SELECT `start_date` FROM `holiday` where start_date like '"+date+"%'";
		SQLQuery query = session.createSQLQuery(sql);

		query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
	work_status = query.list();
} catch (Exception e) {
	e.printStackTrace();
}
return work_status;

}@Override
public List<Map<String, Object>> checkleave(String date) throws Exception {
	Session session = this.sessionFactory.getCurrentSession();
	List<Map<String, Object>> work_status = null;
	try {

		String sql = "SELECT `start_date` FROM `leaves` WHERE start_date LIKE '"+date+"%'";
		SQLQuery query = session.createSQLQuery(sql);

		query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
	work_status = query.list();
} catch (Exception e) {
	e.printStackTrace();
}
return work_status;
}
	
@Override
public List<Map<String , Object>> Duplicate_Workhour_list(String id,String year)throws Exception {
	List<Map<String, Object>> Duplicate_list = null;
	Session session = this.sessionFactory.getCurrentSession();
	
	try {
		String sql ="SELECT work_hours_id,work_hours_type,work_hours_time_work,user_create,DATE_FORMAT(work_hours_time_work, \"%d/%m/%Y\") as workday"
				+ ",COUNT(DATE_FORMAT(work_hours_time_work, \"%d/%m/%Y\")) as check_in_out_count FROM `work_hours` "
				+ "WHERE work_hours_time_work LIKE '"+year+"-%' AND user_create = '"+id+"' GROUP BY workday ORDER by work_hours_id ASC";
		SQLQuery query = session.createSQLQuery(sql);
		System.out.println(sql);
		query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
		Duplicate_list = query.list();
	}catch(Exception e) {
		e.printStackTrace();
	}
	
	
	return Duplicate_list;
}
@Override
public List<Map<String , Object>> Duplicate_Workhour(String daylist,String id,String year)throws Exception{
	List<Map<String, Object>> Duplicate_list = null;
	Session session = this.sessionFactory.getCurrentSession();
	try {
		String sql ="SELECT work_hours_id,work_hours_type,work_hours_time_work,user_create,description,"
				+ "DATE_FORMAT(work_hours_time_work, \"%d/%m/%Y\") as workday FROM `work_hours` "
				+ "WHERE work_hours_time_work LIKE '"+year+"-%' AND user_create = '"+id+"' "
				+ "AND DATE_FORMAT(work_hours_time_work, \"%d/%m/%Y\") IN ("+daylist+") "
				+ "ORDER by work_hours_id ASC";
		
		SQLQuery query = session.createSQLQuery(sql);
		System.out.println(sql);
		query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
		Duplicate_list = query.list();
	}catch(Exception e) {
		e.printStackTrace();
	}
	return Duplicate_list;
	
}

@Override
public List<Map<String, Object>> descheckin(String currentUserlist, java.sql.Timestamp Datenow,
		java.sql.Timestamp DateBefore, String month, String year) throws Exception {
	Session session = this.sessionFactory.getCurrentSession();
	List<Map<String, Object>> descheckin = null;
	try {
		String sql = "SELECT work_hours_time_work, work_hours_type, description "
				+ "FROM work_hours "
				+ "WHERE user_create =:currentUserlist AND YEAR(work_hours_time_work)=:year AND MONTH(work_hours_time_work)=:month "
				+ "ORDER BY work_hours_time_work ASC";
		
		SQLQuery query = session.createSQLQuery(sql);
		query.setParameter("currentUserlist", currentUserlist);
		query.setParameter("month", month);
		query.setParameter("year", year);
		query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
		descheckin = query.list();
	} catch (Exception e) {
		e.printStackTrace();
	}
	return descheckin;
}

@Override
public List<Map<String, Object>> Count_checkList(String user,String start_mouth, String today) {
	Session session = this.sessionFactory.getCurrentSession();
	List<Map<String, Object>> count_checklist = null;
	try {
		String sql = "SELECT COUNT(*) AS count_workday FROM work_hours WHERE user_create = :user AND DATE(work_hours_time_work) BETWEEN :start_mouth AND :today  AND work_hours_type = \"1\"";
		
		SQLQuery query = session.createSQLQuery(sql);
		query.setParameter("user", user);
		query.setParameter("start_mouth", start_mouth);
		query.setParameter("today", today);
		query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
		count_checklist = query.list();
	}catch (Exception e) {
		e.printStackTrace();
	}
	return count_checklist;
}

@Override
public List<Map<String, Object>> getCheckInList(String dateStart,String dateEnd, String workHoursType, String idSiteJob) {
	Session session = this.sessionFactory.getCurrentSession();
	List<Map<String, Object>> count_checklist = null;
	try {
		String sql = "SELECT\n" +
				"	wh.work_hours_id,\n" +
				"	u.id,\n" +
				"	u.employee_id,\n" +
				"	u.name,\n" +
				" 	CASE\n" +
				" 	    WHEN u.employee_id is not null && u.employee_id != '' THEN concat(u.employee_id, ' - ', u.name_en, ' - ', u.name)\n" +
				" 	    ELSE concat(u.name_en, ' - ', u.name)\n" +
				" 	END AS name_display,\n" +
				"	TIME_FORMAT(wh.work_hours_time_work, '%H:%i') as check_in\n" +
				"FROM  work_hours wh\n" +
				"inner join user u on wh.user_create = u.id\n" +
				"where wh.work_hours_time_work >= :dateStart\n" +
				"and wh.work_hours_time_work < :dateEnd\n" +
				"and wh.work_hours_type = :workHoursType\n" +
				"and u.id in (SELECT jst.user_id FROM job_site_team jst where jst.id_sitejob = :idSiteJob)\n" +
				"order by u.employee_id";
		
		SQLQuery query = session.createSQLQuery(sql);
		query.setParameter("dateStart", dateStart);
		query.setParameter("dateEnd", dateEnd);
		query.setParameter("workHoursType", workHoursType);
		query.setParameter("idSiteJob", idSiteJob);
		query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
		count_checklist = query.list();
	}catch (Exception e) {
		e.printStackTrace();
	}
	return count_checklist;
}

@Override
public List<Map<String, Object>> getWorkHourByUserIdAndWorkHoursTypeAndDate(String userId, String workHoursType, String dateFrom, String dateTo) {
	Session session = this.sessionFactory.getCurrentSession();
	List<Map<String, Object>> ret = null;
	try {
		String sql = "SELECT\n" +
				"	wh.work_hours_id,\n" +
				"	u.id as user_id,\n" +
				"	u.employee_id,\n" +
				"	u.name,\n" +
				"	u.name_en,\n" +
				"	wh.work_hours_type,\n" +
				"	wh.work_hours_time_work,\n" +
				"	HOUR(wh.work_hours_time_work) as work_hours_time_work_hour,\n" +
				"	MINUTE(wh.work_hours_time_work) as work_hours_time_work_min,\n" +
				"	wh.description,\n" +
				"	u.work_time_start,\n" +
				"	HOUR(u.work_time_start) as work_time_start_hour,\n" +
				"	MINUTE(u.work_time_start) as work_time_start_min,\n" +
				"	u.work_time_end,\n" +
				"	HOUR(u.work_time_end) as work_time_end_hour,\n" +
				"	MINUTE(u.work_time_end) as work_time_end_min,\n" +
				"	TIME_FORMAT(wh.work_hours_time_work, '%H:%i') as work_hours_time_work_display\n" +
				"FROM\n" +
				"	work_hours wh\n" +
				"INNER JOIN user u ON wh.user_create = u.id\n" +
				"WHERE 1 = 1\n" +
				"	AND wh.user_create = :userId\n" +
				"	AND wh.work_hours_type = :workHoursType\n" +
				"	AND wh.work_hours_time_work >= TIMESTAMP(:dateFrom)\n";
		
				if (StringUtil.isEmpty(dateTo)) {
					sql += "	AND wh.work_hours_time_work < TIMESTAMP(TIMESTAMPADD(DAY, 1, :dateFrom))\n";
				}else {
					sql += "	AND wh.work_hours_time_work < TIMESTAMP(:dateTo)\n";
				}
				
				if (workHoursType.equalsIgnoreCase("1")) {
					sql += "ORDER BY work_hours_time_work ASC\n";
				}else {
					sql += "ORDER BY work_hours_time_work DESC\n";
				}

				sql += "LIMIT 1;";
		
		SQLQuery query = session.createSQLQuery(sql);
		query.setParameter("userId", userId);
		query.setParameter("workHoursType", workHoursType);
		query.setParameter("dateFrom", dateFrom);
		query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
		ret = query.list();
	}catch (Exception e) {
		e.printStackTrace();
	}
	return ret;
}

//@Override
public List<Map<String, Object>> getWorkHourTimeWorkByUserIdAndWorkHoursTypeAndDate(String userId, String workHoursType, String dateFrom, String dateTo) {
	Session session = this.sessionFactory.getCurrentSession();
	List<Map<String, Object>> ret = null;
	try {
		String sql = "SELECT\n" +
				"	wh.user_create,\n" +
				"	TIME_FORMAT(wh.work_hours_time_work, '%H:%i') as work_hours_time_work_display\n" +
				"FROM\n" +
				"	work_hours wh\n" +
				"WHERE 1 = 1\n" +
				"	AND wh.user_create = :userId\n" +
				"	AND wh.work_hours_type = :workHoursType\n" +
				"	AND wh.work_hours_time_work >= TIMESTAMP(:dateFrom)\n";
		
				if (StringUtil.isEmpty(dateTo)) {
					sql += "	AND wh.work_hours_time_work < TIMESTAMP(TIMESTAMPADD(DAY, 1, :dateFrom))\n";
				}else {
					sql += "	AND wh.work_hours_time_work < TIMESTAMP(:dateTo)\n";
				}
				
				if (workHoursType.equalsIgnoreCase("1")) {
					sql += "wh.ORDER BY work_hours_time_work ASC\n";
				}else {
					sql += "wh.ORDER BY work_hours_time_work DESC\n";
				}

				sql += "LIMIT 1;";
		
		SQLQuery query = session.createSQLQuery(sql);
		query.setParameter("userId", userId);
		query.setParameter("workHoursType", workHoursType);
		query.setParameter("dateFrom", dateFrom);
		query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
		ret = query.list();
	}catch (Exception e) {
		e.printStackTrace();
	}
	return ret;
}

public List<WorkHours> findByUserYear(String userId, String year) throws Exception {
	Session session = this.sessionFactory.getCurrentSession();
	List  list = null;
	try {

		String sql = "select * "
				+ " from work_hours " + " WHERE user_create='"+userId+"' and YEAR(work_hours_time_work) = "+year+" order by work_hours_time_work asc, work_hours_type asc ";

		SQLQuery query = session.createSQLQuery(sql);
		
		//query.setParameter("userId", userId);
		//query.setParameter("year", year);
		
		query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
		list = query.list();
	} catch (Exception e) {
		e.printStackTrace();
	}
	return list;
}

public Map<LocalDate, Map<String, Object>> getCheckinsForYear(String userId, int year1, int year2) throws Exception {
	Session session = this.sessionFactory.getCurrentSession();
	Map<LocalDate, Map<String, Object>> checkinMap = new HashMap<>();
	try {
		String sql = "SELECT work_hours_time_work AS mycheckin, description, work_type " + "FROM work_hours "
				+ "WHERE user_create = :userId " + "AND YEAR(work_hours_time_work) BETWEEN :year1 AND :year2 "
				+ "AND work_hours_type = 1 " + // 1 = checkin
				"ORDER BY work_hours_id DESC";

		SQLQuery query = session.createSQLQuery(sql);
		query.setParameter("userId", userId);
		query.setParameter("year1", year1);
		query.setParameter("year2", year2);
		query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

		List<Map<String, Object>> results = query.list();
		for (Map<String, Object> row : results) {
			Timestamp ts = (Timestamp) row.get("mycheckin");
			Object description = row.get("description");
			Object worktype = row.get("work_type");

			if (ts != null) {
				Map<String, Object> data = new HashMap<>();
				data.put("checkinTs", ts);
				data.put("descriptionIn", description);
				data.put("workTypeIn", worktype);

				checkinMap.put(ts.toLocalDateTime().toLocalDate(), data);
			}
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
	return checkinMap;
}

public Map<LocalDate, Map<String, Object>> getCheckoutsForYear(String userId, int year1, int year2) throws Exception {
	Session session = this.sessionFactory.getCurrentSession();
	Map<LocalDate, Map<String, Object>> checkoutMap = new HashMap<>();
	try {
		String sql = "SELECT work_hours_time_work, workinghours, description, work_type " + "FROM work_hours "
				+ "WHERE user_create = :userId " + "AND YEAR(work_hours_time_work) BETWEEN :year1 AND :year2 "
				+ "AND work_hours_type = 2 " + "ORDER BY work_hours_id DESC";

		SQLQuery query = session.createSQLQuery(sql);
		query.setParameter("userId", userId);
		query.setParameter("year1", year1);
		query.setParameter("year2", year2);
		query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

		List<Map<String, Object>> results = query.list();
		for (Map<String, Object> row : results) {
			Timestamp checkoutTs = (Timestamp) row.get("work_hours_time_work");
			Object workingHours = row.get("workinghours");
			Object descriptions = row.get("description");
			Object worktype = row.get("work_type");

			if (checkoutTs != null) {
				Map<String, Object> data = new HashMap<>();
				data.put("checkoutTs", checkoutTs);
				data.put("workinghours", workingHours);
				data.put("descriptionOut", descriptions);
				data.put("workTypeOut", worktype);

				checkoutMap.put(checkoutTs.toLocalDateTime().toLocalDate(), data);
			}
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
	return checkoutMap;
}




}