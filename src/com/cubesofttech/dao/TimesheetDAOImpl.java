package com.cubesofttech.dao;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.AliasToEntityMapResultTransformer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.Holiday;
import com.cubesofttech.model.Leaves;
import com.cubesofttech.model.Project;
import com.cubesofttech.model.Timesheet;

@Repository
public class TimesheetDAOImpl implements TimesheetDAO {
	@Autowired
	private SessionFactory sessionFactory;
	private static final Logger log = Logger.getLogger(TimesheetDAOImpl.class);

	@Override
	public void save(Timesheet timesheet) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.save(timesheet);
		session.flush();

	}

	@Override
	public List<Map<String, Object>> sequense() throws Exception {

		return null;
	}

	@Override
	public List<Timesheet> findAll() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Timesheet> timesheet = null;
		try {
			String sql = "SELECT * FROM timesheet";
			SQLQuery query = session.createSQLQuery(sql);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			timesheet = query.list();
		} catch (Exception e) {

		}
		return timesheet;

	}

	@Override
	public void delete(Timesheet timesheet) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.delete(timesheet);
		session.flush();

	}

	/*
	 * @Override public List<Map<String, Object>> checkholiday() throws Exception {
	 * Session session = this.sessionFactory.getCurrentSession(); List<Map<String,
	 * Object>> timesheet_status = null; try { String sql =
	 * "SELECT `start_date`, `end_date` FROM `holiday`";
	 * 
	 * SQLQuery query = session.createSQLQuery(sql); //query.setParameter("id_date",
	 * userID);
	 * query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
	 * timesheet_status = query.list(); }catch (Exception e) { e.printStackTrace();
	 * } return timesheet_status; }
	 */
	@Override
	public List<Map<String, Object>> findHoliday() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> holidaysheet = null;
		try {
			String sql = " SELECT start_date,end_date FROM holiday";
			SQLQuery query = session.createSQLQuery(sql);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			holidaysheet = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}
		return holidaysheet;
	}

	@Override
	public List<Map<String, Object>> findHoliday2() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> holidaysheet = null;
		try {
			String sql = " SELECT start_date,end_date FROM holiday";
			SQLQuery query = session.createSQLQuery(sql);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			holidaysheet = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}
		return holidaysheet;
	}

	@Override
	public List<Map<String, Object>> findTimeInTimeOutBytimeMonthYear(String user, String startDay, String endDay)
			throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> timesheet = null;
		try {
			String sql = "SELECT date(workout.work_hours_time_work) AS date,workin.work_hours_time_work AS workin,workout.work_hours_time_work AS workout FROM work_hours workin "
					+ "LEFT JOIN work_hours workout on  date(workout.work_hours_time_work) = date(workin.work_hours_time_work) "
					+ "Where workin.work_hours_time_work >= :startDay and workin.work_hours_time_work <= :endDay  "
					+ "AND workout.work_hours_time_work >= :startDay and workout.work_hours_time_work <= :endDay "
					+ "and workin.work_hours_type = 1 and workout.work_hours_type = 2 and workin.user_create = :user "
					+ "and workout.user_create = :user";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("user", user);
			query.setParameter("startDay", startDay);
			query.setParameter("endDay", endDay);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			timesheet = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}
		return timesheet;
	}

	@Override
	public List<Map<String, Object>> findDescription(String user, String startDay, String endDay) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> timesheet = null;
		try {
			String sql = " SELECT description,time_check_in,time_check_out,id,status, project_id, function_id  FROM timesheet Where time_check_in >= :startDay and time_check_in <= :endDay and user_create = :user ";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("user", user);
			query.setParameter("startDay", startDay);
			query.setParameter("endDay", endDay);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			timesheet = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}
		return timesheet;
	}

	@Override
	public void update(Timesheet timesheet) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.clear();
		session.update(timesheet);
		session.flush();
	}

	@Override
	public List<Map<String, Object>> searchIdTimesheet(String id) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> timesheet = null;
		try {
			String sql = "SELECT id FROM timesheet  Where id = :id";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("id", id);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			timesheet = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}
		return timesheet;
	}

	@Override
	public List<Map<String, Object>> searchTimesheet(String user, String date) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> timesheet = null;
		try {
			String sql = " SELECT id, user_create,date(time_check_in) as date FROM timesheet Where time_check_in LIKE '%"
					+ date + "%'  and user_create = :user ";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("user", user);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			timesheet = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}
		return timesheet;

	}

	@Override
	public List<Map<String, Object>> timesheetSearch_forCalendar(String userId, String from, String to)
			throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> expSearch = null;
		try {
			if (from == null || to == null) {
				String sql = "SELECT * FROM timesheet WHERE user_create =  :userId ";
				SQLQuery query = session.createSQLQuery(sql);
				query.setParameter("userId", userId);
				query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
				expSearch = query.list();
			} else if (from != null && to != null) {
				String sql = "SELECT * FROM timesheet WHERE user_create =  :userId  AND time_create BETWEEN :from  and :to   ";
				SQLQuery query = session.createSQLQuery(sql);
				query.setParameter("userId", userId);
				query.setParameter("from", from);
				query.setParameter("to", to);
				// query.addEntity(Expense.class);
				query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
				expSearch = query.list();
			}

		} catch (Exception e) {
			e.printStackTrace();
			return null;

		} finally {

		}
		return expSearch;
	}

	@Override
	public Integer getMaxId() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		//List<Timesheet> list = null;
		Integer maxId = 0;

		try {

			Criteria criteria = session.createCriteria(Timesheet.class).setProjection(Projections.max("id"));
			maxId = (Integer) criteria.uniqueResult();

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
	public Timesheet findById(Integer id) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		Timesheet timesheet = (Timesheet) session.get(Timesheet.class, id);
		return timesheet;
	}

	@Override
	public List<Timesheet> findTimesheetById(int id) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();		
		List<Timesheet> modalOTList = null;
		try {
			String sql = "SELECT * FROM timesheet WHERE id = " + id;
			SQLQuery query = session.createSQLQuery(sql);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			modalOTList = query.list();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return modalOTList;
		
	}
	
	@Override
	public List<Map<String, Object>> searchTimesheetByUserCreate(String userId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> expSearch = null;
		try {
			String sql = "SELECT * FROM timesheet WHERE user_create =  :userId";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("userId", userId);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			expSearch = query.list();

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {

		}
		return expSearch;
	}

	@Override
	public List<Map<String, Object>> searchTimesheetByTimeUpdate(String userId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> expSearch = null;
		try {
			String sql = "SELECT * FROM timesheet WHERE user_create =  :userId ";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("userId", userId);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			expSearch = query.list();

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {

		}
		return expSearch;
	}

	public List<Timesheet> findAll_calendar() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Timesheet> timesheetList = null;
		try {
			String sql = " SELECT * FROM timesheet order by id ASC;";
			SQLQuery query = session.createSQLQuery(sql);
			// query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			query.addEntity(Timesheet.class);

			timesheetList = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return timesheetList;
	}

	@Override
	public List<Map<String, Object>> listtimesheet(String userid, java.sql.Timestamp Datenow,
			java.sql.Timestamp DateBefore, String month, String year) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> timesheetlist = null;
		try {
			String sql = "SELECT  timesheet.*,project.project_name, project_function.function_name FROM timesheet LEFT JOIN project ON timesheet.project_id = project.project_id LEFT JOIN project_function ON timesheet.function_id = project_function.function_id WHERE timesheet.user_create =  :userid AND YEAR(timesheet.time_check_in)=:year AND MONTH(timesheet.time_check_in)=:month  ORDER BY timesheet.time_check_in DESC";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("userid", userid);
			query.setParameter("month", month);
			query.setParameter("year", year);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			timesheetlist = query.list();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return timesheetlist;
	}
	
	@Override
	public List<Map<String, Object>> listtimesheet1(String userid, java.sql.Timestamp Datenow,
			java.sql.Timestamp DateBefore, String month, String year) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> timesheetlist = null;
		try {
			String sql = "SELECT timesheet.*, work_hours.workinghours FROM timesheet LEFT JOIN work_hours ON timesheet.time_check_out = work_hours.work_hours_time_work "
					+ "WHERE timesheet.user_create =  :userid AND YEAR(timesheet.time_check_in)=:year AND MONTH(timesheet.time_check_in)=:month "
					+ "ORDER BY timesheet.time_check_in ASC";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("userid", userid);
			query.setParameter("month", month);
			query.setParameter("year", year);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			timesheetlist = query.list();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return timesheetlist;
	}

	@Override
	public List<Map<String, Object>> listtimesheet2(String userid, String dateStartSearch, String dateEndSearch)
			throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> timesheetlist = null;
		try {
			String sql = "SELECT  timesheet.*,project.project_name, project_function.function_name FROM timesheet LEFT JOIN project ON timesheet.project_id = project.project_id LEFT JOIN project_function ON timesheet.function_id = project_function.function_id WHERE timesheet.user_create =  :userid and time_check_in >= :dateStartSearch and time_check_in <= :dateEndSearch ORDER BY timesheet.time_check_in DESC";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("userid", userid);
			query.setParameter("dateStartSearch", dateStartSearch);
			query.setParameter("dateEndSearch", dateEndSearch);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			timesheetlist = query.list();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return timesheetlist;
	}

	@Override
	public List<Map<String, Object>> timesheetapproved(String timesheetid, String status) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> timesheetapprove = null;
		try {
			String sql = "UPDATE timesheet SET status = 'A' WHERE id = 315";

			SQLQuery query = session.createSQLQuery(sql);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			timesheetapprove = query.list();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return timesheetapprove;
	}

	@Override
	public Timesheet latestTimesheet(String id) {
		Session session = this.sessionFactory.getCurrentSession();
		Timesheet timesheet = null;
		try {
			String sql = "SELECT * FROM timesheet where user_create = '" + id + "' ORDER BY id DESC";
			SQLQuery query = session.createSQLQuery(sql);

			// get the single instance from hibernate
			List<Object> tempList = (List<Object>) query.addEntity(Timesheet.class).list();
			if (tempList.size() > 0) {
				timesheet = (Timesheet) tempList.get(0);
			} else {
				timesheet = null;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return timesheet;

	}

	@Override
	public boolean checkExistUserDate(String user, String date) {
		List<Object> timesheet = null;
		timesheet = sessionFactory.getCurrentSession().createSQLQuery(
				"SELECT * FROM timesheet WHERE user_create = '" + user + "' AND time_check_in LIKE '" + date + "%'")
				.list();
		return timesheet != null;
	}

	@Override
	public List<Map<String, Object>> listot(String userid, java.sql.Timestamp Datenow, java.sql.Timestamp DateBefore,
			String month, String year) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> timesheetlist = null;
		try {
			String sql = "SELECT id, OT_time_start, OT_time_end, OT_description, status FROM timesheet WHERE user_create"
					+ " = :userid AND YEAR(OT_time_start)=:year AND MONTH(OT_time_start)=:month AND OT_time_start IS NOT NULL GROUP BY id ORDER BY id DESC";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("userid", userid);
			query.setParameter("month", month);
			query.setParameter("year", year);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			timesheetlist = query.list();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return timesheetlist;
	}

	@Override
	public List<Map<String, Object>> listot2(String userid, String dateStartSearch, String dateEndSearch)
			throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> timesheetlist = null;
		try {
			String sql = "SELECT id, status, OT_time_start, OT_time_end, OT_description FROM timesheet WHERE user_create = :userid AND OT_time_start >= :dateStartSearch and OT_time_start <= :dateEndSearch AND OT_time_start IS NOT NULL GROUP BY id DESC";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("userid", userid);
			query.setParameter("dateStartSearch", dateStartSearch);
			query.setParameter("dateEndSearch", dateEndSearch);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			timesheetlist = query.list();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return timesheetlist;
	}

	@Override
	public List<Map<String, Object>> reportProject(String month, String year) {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> rp = null;
		try {
			String sql = "SELECT timesheet.user_create , project.project_name,timesheet.time_check_in ,timesheet.time_check_out FROM timesheet INNER JOIN project ON timesheet.project_id = project.project_id WHERE YEAR(timesheet.time_check_in)=:year AND MONTH(timesheet.time_check_in)=:month";

			// String sql = "SELECT timesheet.user_create ,
			// project.project_name,timesheet.time_check_in FROM timesheet INNER JOIN
			// project ON timesheet.project_id = project.project_id WHERE
			// timesheet.user_create='rungtrakul.r'";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("month", month);
			query.setParameter("year", year);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			rp = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return rp;
	}

	@Override
	public List<Map<String, Object>> searchProjectReport(String project, String name, String month, String year) {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> rp = null;
		try {

			if (project.equals("All") && !name.equals("All")) {

				System.out.println("me ALL Project");
				String sql = "SELECT timesheet.user_create , project.project_name,timesheet.time_check_in ,timesheet.time_check_out FROM timesheet INNER JOIN project ON timesheet.project_id = project.project_id \r\n"
						+ "WHERE YEAR(timesheet.time_check_in)=:year AND MONTH(timesheet.time_check_in)=:month AND timesheet.user_create=:user1";
				SQLQuery query = session.createSQLQuery(sql);
				query.setParameter("user1", name);
				query.setParameter("month", month);
				query.setParameter("year", year);
				query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
				rp = query.list();
			} else if (name.equals("All") && !project.equals("All")) {
				System.out.println("me ALL Name User");
				String sql = "SELECT timesheet.user_create , project.project_name,timesheet.time_check_in ,timesheet.time_check_out FROM timesheet INNER JOIN project ON timesheet.project_id = project.project_id \r\n"
						+ "WHERE YEAR(timesheet.time_check_in)=:year AND MONTH(timesheet.time_check_in)=:month AND project.project_name =:project";
				SQLQuery query = session.createSQLQuery(sql);
				query.setParameter("project", project);
				query.setParameter("month", month);
				query.setParameter("year", year);
				query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
				rp = query.list();
			} else if (name.equals("All") && project.equals("All")) {
				String sql = "SELECT timesheet.user_create , project.project_name,timesheet.time_check_in ,timesheet.time_check_out FROM timesheet INNER JOIN project ON timesheet.project_id = project.project_id \r\n"
						+ "WHERE YEAR(timesheet.time_check_in)=:year AND MONTH(timesheet.time_check_in)=:month ";
				SQLQuery query = session.createSQLQuery(sql);
				query.setParameter("month", month);
				query.setParameter("year", year);
				query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
				rp = query.list();
			} else {

			}

//			String sql = "SELECT timesheet.user_create , project.project_name,timesheet.time_check_in ,timesheet.time_check_out FROM timesheet INNER JOIN project ON timesheet.project_id = project.project_id \r\n"
//					+ "WHERE timesheet.user_create=:user_id AND YEAR(timesheet.time_check_in)=:year AND MONTH(timesheet.time_check_in)=:month AND project.project_name =:project";
//			SQLQuery query = session.createSQLQuery(sql);
//			query.setParameter("project", project);
//			query.setParameter("user_id", name);
//			query.setParameter("month", month);
//			query.setParameter("year", year);
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			rp = query.list();
//			

			if (project.equals("All")) {
				if (name.equals("All")) {
					System.out.println("me ALL Project Name");

					String sql = "SELECT timesheet.user_create , project.project_name,timesheet.time_check_in ,timesheet.time_check_out FROM timesheet INNER JOIN project ON timesheet.project_id = project.project_id \r\n"
							+ "WHERE YEAR(timesheet.time_check_in)=:year AND MONTH(timesheet.time_check_in)=:month ";
					SQLQuery query = session.createSQLQuery(sql);
					query.setParameter("month", month);
					query.setParameter("year", year);
					query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
					rp = query.list();
				} else {
					System.out.println("me ALL Project");

					System.out.println("me ALL Project");
					String sql = "SELECT timesheet.user_create , project.project_name,timesheet.time_check_in ,timesheet.time_check_out FROM timesheet INNER JOIN project ON timesheet.project_id = project.project_id \r\n"
							+ "WHERE  YEAR(timesheet.time_check_in)=:year AND MONTH(timesheet.time_check_in)=:month AND timesheet.user_create=:user1";
					SQLQuery query = session.createSQLQuery(sql);
					query.setParameter("user1", name);
					query.setParameter("month", month);
					query.setParameter("year", year);
					query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
					rp = query.list();
				}
			} else {
				if (name.equals("All")) {
					System.out.println("me ALL Name");

					String sql = "SELECT timesheet.user_create , project.project_name,timesheet.time_check_in ,timesheet.time_check_out FROM timesheet INNER JOIN project ON timesheet.project_id = project.project_id \r\n"
							+ "WHERE YEAR(timesheet.time_check_in)=:year AND MONTH(timesheet.time_check_in)=:month AND project.project_name =:project";
					SQLQuery query = session.createSQLQuery(sql);
					query.setParameter("project", project);
					query.setParameter("month", month);
					query.setParameter("year", year);
					query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
					rp = query.list();
				} else {

					System.out.println("me 1 Name Project");

					System.out.println("me ALL Project");
					String sql = "SELECT timesheet.user_create , project.project_name,timesheet.time_check_in ,timesheet.time_check_out FROM timesheet INNER JOIN project ON timesheet.project_id = project.project_id \r\n"
							+ "WHERE YEAR(timesheet.time_check_in)=:year AND MONTH(timesheet.time_check_in)=:month AND timesheet.user_create=:user2 AND project.project_name =:project1";
					SQLQuery query = session.createSQLQuery(sql);
					query.setParameter("user2", name);
					query.setParameter("project1", project);
					query.setParameter("month", month);
					query.setParameter("year", year);
					query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
					rp = query.list();
				}
			}

//			SQLQuery query = session.createSQLQuery(sql);
//			query.setParameter("project", project);
//			query.setParameter("user_id", name);
//			query.setParameter("month", month);
//			query.setParameter("year", year);

//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			rp = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return rp;
	}

	@Override
	public List<Map<String, Object>> projectname() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> project = null;
		try {
			String sql = "SELECT project_id, project_name from project";
			SQLQuery query = session.createSQLQuery(sql);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			project = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return project;
	}

	@Override
	public List<Map<String, Object>> finduserWork(String user, String month, String year) {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> userWork = null;
		try {
			String sql = "SELECT * FROM work_hours WHERE YEAR(work_hours_time_work)=:year AND MONTH(work_hours_time_work)=:month AND work_hours_type=1 AND user_create=:user";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("month", month);
			query.setParameter("year", year);
			query.setParameter("user", user);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			userWork = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return userWork;
	}

	@Override
	public List<Map<String, Object>> finduserWorkCheckOut(String user, String month, String year) {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> userWorkCheckOut = null;
		try {
			String sql = "SELECT * FROM work_hours WHERE YEAR(work_hours_time_work)=:year AND MONTH(work_hours_time_work)=:month AND work_hours_type=2 AND user_create=:user";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("month", month);
			query.setParameter("year", year);
			query.setParameter("user", user);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			userWorkCheckOut = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return userWorkCheckOut;
	}

	@Override
	public List<Map<String, Object>> finduserWorkProject(String user, String month, String year) {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> userWorkCheckOut = null;
		try {
			String sql = "SELECT timesheet.team, timesheet.user_create , project.project_name,timesheet.time_check_in ,timesheet.time_check_out FROM timesheet INNER JOIN project ON timesheet.project_id = project.project_id WHERE timesheet.user_create=:user AND YEAR(timesheet.time_check_in)=:year AND MONTH(timesheet.time_check_in)=:month ORDER BY timesheet.time_check_in";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("month", month);
			query.setParameter("year", year);
			query.setParameter("user", user);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			userWorkCheckOut = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return userWorkCheckOut;
	}

	public List<Map<String, Object>> approveall(String name, String year, String month) {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> userWorkCheckOut = null;
		try {
			String sql = "SELECT * FROM timesheet WHERE user_create =:name AND YEAR(time_check_in) =:year AND MONTH(time_check_in) =:month";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("month", month);
			query.setParameter("year", year);
			query.setParameter("name", name);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			userWorkCheckOut = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return userWorkCheckOut;
	}
	
	@Override
	public List<Map<String, Object>> findcurrent(String user, String month, String year) {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> userWork = null;
		try {
			String sql = "SELECT *  FROM `work_hours` WHERE `work_hours_time_work` BETWEEN '"+year+"-"+month+"-01 00:00:00.000000' AND CURDATE()"
					+ " AND work_hours_type=1 AND user_create= '"+user+"'";
					
			SQLQuery query = session.createSQLQuery(sql);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			userWork = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return userWork;
	}
	
	@Override
	public List<Map<String, Object>> getdate(String month, String year) {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> userWork = null;
		try {
			String sql = "SELECT LAST_DAY('"+year+"-"+month+"-01') - curdate() AS currentdata";

					
			SQLQuery query = session.createSQLQuery(sql);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			userWork = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return userWork;
	}
	
	@Override
	public List<Map<String, Object>> wherename(String name) {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> userWork = null;
		try {
			String sql = "SELECT id FROM user WHERE name =:name AND flag_search='1'";

					
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("name", name);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			userWork = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return userWork;
	}
	@Override
	public List<Map<String, Object>> whereproject(String name) {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> userWork = null;
		try {
			String sql = "SELECT project_id FROM project WHERE project_name =:name";

					
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("name", name);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			userWork = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return userWork;
	}
	@Override
	public List<Map<String, Object>> wherefile() {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> userWork = null;
		try {
			String sql = "SELECT * FROM file WHERE type= '.xlsx'";

					
			SQLQuery query = session.createSQLQuery(sql);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			userWork = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return userWork;
	}
	
	@Override
	public List<Map<String, Object>> whereworkhour(String year,String month,String day,String name) {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> userWork = null;
		try {
			String sql = "SELECT * FROM work_hours WHERE YEAR(work_hours_time_work) =:year AND MONTH(work_hours_time_work)=:month AND DAY(work_hours_time_work)=:day AND user_create =:name";
				
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("year", year);
			query.setParameter("month", month);
			query.setParameter("day", day);
			query.setParameter("name", name);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			userWork = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return userWork;
	}
	
	@Override
	public List<Map<String, Object>> wherefunction(String name) {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> userWork = null;
		try {
			String sql = "SELECT function_id FROM project_function WHERE function_name =:name";

					
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("name", name);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			userWork = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return userWork;
	}
	
	@Override
	public List<Map<String, Object>> searchbymonth(String userid, String month, String year) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> searchmonth = null;
		try {
			String sql = "SELECT timesheet.*, work_hours.workinghours "
					+ "FROM timesheet LEFT JOIN work_hours ON timesheet.time_check_out = work_hours.work_hours_time_work "
					+ "WHERE timesheet.user_create =:userid AND YEAR(timesheet.time_check_in)=:year AND MONTH(timesheet.time_check_in)=:month "
					+ "ORDER BY timesheet.time_check_in ASC";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("userid", userid);
			query.setParameter("month", month);
			query.setParameter("year", year);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			searchmonth = query.list();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return searchmonth;
	}
	
	@Override
	public List<Timesheet> findByProjectId(Integer project_id) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Timesheet> timesheet = null;
		try {
			String sql = "SELECT * FROM `timesheet` WHERE project_id = " + project_id;
			SQLQuery query = session.createSQLQuery(sql);
			query.addEntity(Timesheet.class);
			timesheet = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return timesheet;
	}
	
}
