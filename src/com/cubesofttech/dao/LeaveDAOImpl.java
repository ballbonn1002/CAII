package com.cubesofttech.dao;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.AliasToEntityMapResultTransformer;
import org.jfree.util.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.Leaves;
import com.cubesofttech.model.User;
import com.cubesofttech.util.DateUtil;

@Repository
public class LeaveDAOImpl implements LeaveDAO {

	@Autowired
	private SessionFactory sessionFactory;

//	@Override
//	public List<Map<String, Object>> getLeaveMonth(String userId, String selectedYear) throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> searchListLeave = null;
//		try {
//			String sql = "select leave_type_id,start_date,end_date,no_day,leave_status_id,half_day from leaves "
//					+ " where user_id = :userId and YEAR(start_date) = :selectedYear ";
//			SQLQuery query = session.createSQLQuery(sql);
//			query.setParameter("userId", userId);
//			query.setParameter("selectedYear", selectedYear);
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			searchListLeave = query.list();
//
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return searchListLeave;
//	}

//	@Override
//	public List<Map<String, Object>> getDataMonth(String userId, String selectedYear) throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> work_status = null;
//		try {
//			String sql = "select hour(m.work_hours_time_work) as myhour, minute(m.work_hours_time_work) as mymin, description "
//					+ " ,m.work_hours_id,m.work_hours_type,m.user_create,m.time_create,"
//					+ " m.work_hours_time_work,date_format(m.work_hours_time_work,'%d-%m-%y')as `date`,"
//					+ " time(m.work_hours_time_work)as `time`,u.role_id as 'u_rold',u.name as 'u_name',m.work_hours_type as `check_type`"
//					+ " from work_hours m " + " inner join `user` u on m.user_create = u.id"
//					+ " where m.user_create = :userId and YEAR(m.time_create) = :selectedYear "
//					+ " order by work_hours_time_work ASC ";
//			SQLQuery query = session.createSQLQuery(sql);
//			query.setParameter("userId", userId);
//			query.setParameter("selectedYear", selectedYear);
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			work_status = query.list();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return work_status;
//	}

//	@Override
//	public List<Map<String, Object>> getDatacheckinhourtime(String userId, String selectedYear) throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> searchcheckinhourtime = null;
//		try {
//			String sql = "select workinghours " + " from work_hours "
//					+ " where user_create = :userId and YEAR(time_create) = :selectedYear "
//					+ " order by work_hours_time_work ASC ";
//			SQLQuery query = session.createSQLQuery(sql);
//			query.setParameter("userId", userId);
//			query.setParameter("selectedYear", selectedYear);
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			searchcheckinhourtime = query.list();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return searchcheckinhourtime;
//	}

//	@Override
//	public List<Map<String, Object>> HolidayForLeaveReport(String selectedYear) throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> Holidaylist = null;
//		try {
//			String sql = "select * from holiday where YEAR(start_date) = :selectedYear";
//			SQLQuery query = session.createSQLQuery(sql);
//			query.setParameter("selectedYear", selectedYear);
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			System.out.println("SQL Query: " + sql + " - Parameter: selectedYear=" + selectedYear);
//			Holidaylist = query.list();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return Holidaylist;
//	}

	@Override
	public void save(Leaves leaves) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.save(leaves);
		session.flush();
		// session.close();
	}

//	@Override
//	public List<Leaves> findAll() throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Leaves> leaveList = null;
//		try {
//			String sql = " SELECT * FROM leaves ORDER BY leave_id DESC ";
//			SQLQuery query = session.createSQLQuery(sql);
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			leaveList = query.list();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return leaveList;
//	}

//	@Override
//	public List<Map<String, Object>> findAllList() throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> list = null;
//		try {
//			list = session.createCriteria(Leaves.class).add(Restrictions.eq("leaveStatusId", "1")).list();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return list;
//	}

	@Override
	public Leaves findByLeaveId(int leaveId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		Leaves leave = null;
		try {
			leave = (Leaves) session.get(Leaves.class, leaveId);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return leave;
	}

//	@Override
//	public List<Leaves> findLeaveById(int leaveId) throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Leaves> modalLeaveList = null;
//		try {
//			String sql = "SELECT leave_id, leave_type_id, leave_status_id, half_day, user_id, "
//					+ "appr_user_id, description, reason, start_time, end_time, start_date, "
//					+ "end_date, no_day, leave_file, user_create, user_update, time_create, "
//					+ "time_update FROM leaves WHERE leave_id = " + leaveId;
//			SQLQuery query = session.createSQLQuery(sql);
//
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			modalLeaveList = query.list();
//
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return modalLeaveList;
//
//	}

	@Override
	public List<Leaves> findLeaveById2(int leaveId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Leaves> modalLeaveList = null;
		try {
			String sql = "SELECT leaves.leave_id, leaves.leave_type_id, leaves.leave_status_id, leaves.half_day, leaves.user_id, user.employee_id, user.name, leaves.appr_user_id, "
					+ "leaves.description, leaves.reason, leaves.start_time, leaves.end_time, leaves.start_date, leaves.end_date, leaves.no_day, "
					+ "leaves.leave_file, leaves.user_create, leaves.user_update, leaves.time_create, leaves.time_update, file.name AS file_name, file.type, "
					+ "apr.employee_id AS appr_employee_id, apr.name AS appr_name "
					+ "FROM leaves LEFT JOIN file ON leaves.leave_file = file.file_id "
					+ "LEFT JOIN user ON leaves.user_id = user.id LEFT JOIN user apr ON leaves.user_update = apr.id WHERE leave_id = " + leaveId;
			SQLQuery query = session.createSQLQuery(sql);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			modalLeaveList = query.list();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return modalLeaveList;

	}

	@Override
	public List<Leaves> findLeaveByUserId(String userId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Leaves> modalLeaveList = null;
		try {
//			String sql = "SELECT leaves.leave_id, leaves.leave_type_id, leaves.leave_status_id, leaves.half_day, leaves.user_id, user.name, leaves.appr_user_id, "
//					+ "leaves.description, leaves.reason, leaves.start_time, leaves.end_time, leaves.start_date, leaves.end_date, leaves.no_day, "
//					+ "leaves.leave_file, leaves.user_create, leaves.user_update, leaves.time_create, leaves.time_update, file.name AS file_name, file.type "
//					+ "FROM leaves LEFT JOIN file ON leaves.leave_file = file.file_id "
//					+ "LEFT JOIN user ON leaves.user_id = user.id WHERE leave_id = " + leaveId;
			String sql = "SELECT * from leaves where user_id = :userId";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("userId", userId);
			query.addEntity(Leaves.class);
			modalLeaveList = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return modalLeaveList;

	}

	@Override
	public void update(Leaves leaves) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.clear();
		session.update(leaves);
		session.flush();
		// session.close();
	}

//	@Override
//	public void delete(Leaves leaves) throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		session.delete(leaves);
//		session.flush();
//		// session.close();
//	}

//	@Override
//	public List<Leaves> search(String leaveId) throws Exception {
//
//		return null;
//	}

//	@Override
//	public List<Map<String, Object>> findHoliday() throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> holidaysheet = null;
//		try {
//			String sql = " SELECT date_format(start_date,'%d-%m-%Y')as `start_date` ,date_format(end_date,'%d-%m-%Y')as `end_date` FROM holiday";
//			SQLQuery query = session.createSQLQuery(sql);
//
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			holidaysheet = query.list();
//
//		} catch (Exception e) {
//			e.printStackTrace();
//		} finally {
//		}
//		return holidaysheet;
//	}

//	@Override
//	public List<Map<String, Object>> findHoliday3() throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> holidaysheet = null;
//		try {
//			String sql = " SELECT date_format(start_date,'%m-%d-%Y')as `start_date` ,date_format(end_date,'%m-%d-%Y')as `end_date` FROM holiday";
//			SQLQuery query = session.createSQLQuery(sql);
//
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			holidaysheet = query.list();
//
//		} catch (Exception e) {
//			e.printStackTrace();
//		} finally {
//		}
//		return holidaysheet;
//	}

	@Override
	public List<Map<String, Object>> findLeave() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> list = null;
		try {

			/*
			 * SELECT leaves.leave_id, leave_type.leave_type_name, leave_user.user_id FROM
			 * leaves RIGHT JOIN leave_type ON leave_type.leave_type_id=leaves.leave_type_id
			 * RIGHT JOIN leave_user ON leave_user.leave_id=leaves.leave_id GROUP BY
			 * leave_user.leave_id
			 */

			String sql = "SELECT leaves.leave_id, leaves.end_date, leaves.end_time, leaves.leave_type_id, \n"
					+ " leaves.half_day, leaves.no_day, leaves.reason, leaves.user_update, \n"
					+ " leaves.start_date, leaves.time_create, leaves.leave_status_id, leaves.user_id, \n"
					+ " leaves.appr_user_id, leaves.description, leaves.leave_file, \n"
					+ " leave_type.leave_type_name, \n" + " user.id, user.name, user.employee_id , user.name_en \n"
					+ " FROM leaves \n" + " LEFT JOIN leave_type ON leaves.leave_type_id = leave_type.leave_type_id \n"
					+ "  LEFT JOIN user ON user.id = leaves.user_id  \n"
					// + "WHERE leaves.user_id is not null\n"
					+ " GROUP BY leaves.leave_id \n" + " ORDER BY leaves.leave_id DESC \n" + " LIMIT 20 \n";

			SQLQuery query = session.createSQLQuery(sql);
			// query.setParameter("leaveId", leaveId);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			list = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Map<String, Object>> listoneperson(String leaveId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> one = null;
		try {
			String leave_id = "";
			if (leaveId != null) {
				leave_id = "  WHERE user_id =  :leaveId";
			}

			String sql = "SELECT leaves.description,leaves.leave_id, leaves.end_date, leaves.end_time,leaves.leave_type_id, leaves.half_day, \n"
					+ "  leaves.appr_user_id, leaves.no_day, leaves.reason,leaves.start_date, leaves.time_create,user.path,  \n"
					+ "  leaves.leave_status_id, leaves.user_id, leave_type.leave_type_name"
					+ " FROM leaves LEFT JOIN leave_type ON leaves.leave_type_id = leave_type.leave_type_id \n"
					+ " LEFT JOIN user ON leaves.user_id = user.id " + leave_id + "  ORDER BY leaves.leave_id DESC "
					+ " LIMIT 20 \n";

			SQLQuery query = session.createSQLQuery(sql);
			if (leaveId != null) {
				query.setParameter("leaveId", leaveId);
			}
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			one = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return one;
	}

	@Override
	public Integer getMaxId() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Leaves> list = null;
		Integer maxId;

		try {

			Criteria criteria = session.createCriteria(Leaves.class).setProjection(Projections.max("leaveId"));
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

//	@Override
//	public List<Map<String, Object>> findPatiwanla(String userLogin, int type, Timestamp startDate, Timestamp endDate) {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> wannla = null;
//		try {
//
//			String sql = " Select no_day FROM leaves WHERE user_id = :userLogin AND leave_type_id =:type AND start_date BETWEEN :startDate AND :endDate";
//			SQLQuery query = session.createSQLQuery(sql);
//			query.setParameter("userLogin", userLogin);
//			query.setParameter("type", type);
//			query.setParameter("userLogin", userLogin);
//			query.setParameter("startDate", startDate);
//			query.setParameter("endDate", endDate);
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			wannla = query.list();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return wannla;
//
//	}

	@Override
	public List<Map<String, Object>> findleaveallByType(String userLogin, int type) {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> wannla = null;
		try {

			String sql = " Select no_day FROM leaves WHERE user_id = :userLogin AND leave_type_id =:type ";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("userLogin", userLogin);
			query.setParameter("type", type);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			wannla = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return wannla;

	}

//	@Override
//	public List<Map<String, Object>> selectId(String userId) throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> select = null;
//		try {
//			String sql = "SELECT * FROM leaves WHERE leave_id = '" + userId + "'";
//
//			SQLQuery query = session.createSQLQuery(sql);
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			select = query.list();
//		} catch (Exception e) {
//			e.printStackTrace();
//		} finally {
//			// session.close();
//		}
//		return select;
//	}

	@Override
	public List<Map<String, Object>> listwaitperson(String leaveId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> one = null;
		try {
			String leave_id = "";
			if (leaveId != null) {
				leave_id = "WHERE user_id =  :leaveId AND leaves.leave_status_id = 0 ";
			}

			String sql = "SELECT leaves.leave_id, leaves.end_date, leaves.end_time, \n"
					+ " leaves.leave_type_id, leaves.half_day,\n" + " leaves.no_day, leaves.reason, \n"
					+ " leaves.start_date, leaves.time_create, leaves.leave_status_id, \n"
					+ " leaves.user_id, leaves.user_update \n" + " FROM leaves \n" + leave_id
					+ " ORDER BY leaves.leave_id DESC \n" + " LIMIT 20 \n";

			SQLQuery query = session.createSQLQuery(sql);
			if (leaveId != null) {
				query.setParameter("leaveId", leaveId);
			}
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			one = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return one;
	}

//	@Override
//	public List<Map<String, Object>> searchAll() throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> search = null;
//		try {
//
//			String sql = "SELECT  leaves.leave_id,leaves.time_create,leaves.user_id,leaves.start_date,leaves.end_date, "
//					+ " leaves.no_day,leave_type.leave_type_name ,leaves.leave_status_id " + " FROM leaves "
//					+ " LEFT JOIN leave_type ON leave_type.leave_type_id = leaves.leave_type_id"
//					+ " ORDER BY start_date DESC ";
//			SQLQuery query = session.createSQLQuery(sql);
//			// query.setParameter("userId", userId);
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			search = query.list();
//		} catch (
//
//		Exception e) {
//			e.printStackTrace();
//		}
//		return search;
//	}

//	@Override
//	public List<Map<String, Object>> searchAll_user(String user) throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> search = null;
//		try {
//
//			String sql = "SELECT  leaves.leave_id,leaves.time_create,leaves.user_id,leaves.start_date,leaves.end_date, "
//					+ " leaves.no_day,leave_type.leave_type_name ,leaves.leave_status_id " + " FROM leaves "
//					+ " LEFT JOIN leave_type ON leave_type.leave_type_id = leaves.leave_type_id " + " WHERE user_id= '"
//					+ user + "' " + " ORDER BY start_date DESC ";
//			SQLQuery query = session.createSQLQuery(sql);
//			// query.setParameter("userId", user);
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			search = query.list();
//		} catch (
//
//		Exception e) {
//			e.printStackTrace();
//		}
//		return search;
//	}

	// this is override method use for search all leave type and all user
//	@Override
//	public List<Map<String, Object>> searchtable(Timestamp startDate, Timestamp endDate, String userId)
//			throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> search = null;
//		try {
//
//			String sql = "SELECT leaves.description, leaves.leave_id,leaves.time_create,leaves.user_id,leaves.start_date, "
//					+ " leaves.end_date, leaves.no_day ,leaves.leave_status_id,leave_type.leave_type_name, user.path "
//					+ " FROM leaves LEFT JOIN leave_type ON leave_type.leave_type_id = leaves.leave_type_id "
//					+ " LEFT JOIN user ON leaves.user_id = user.id "
//					+ " WHERE leaves.start_date BETWEEN :startDate AND :endDate " + " ORDER BY leaves.start_date DESC ";
//
//			SQLQuery query = session.createSQLQuery(sql);
//			query.setParameter("startDate", startDate);
//			query.setParameter("endDate", endDate);
//			// query.setParameter("userId", userId);
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			search = query.list();
//		} catch (
//
//		Exception e) {
//			e.printStackTrace();
//		}
//		return search;
//	}

	// this is override method use for search all leave type and all user
	public List<Map<String, Object>> searchtableAll(Timestamp startDate, Timestamp endDate) throws Exception {
	    Session session = this.sessionFactory.getCurrentSession();
	    List<Map<String, Object>> search = null;
	    try {
	        StringBuilder sql = new StringBuilder(
	            "SELECT leaves.leave_id, leaves.user_id, user.name, leaves.leave_status_id, leaves.leave_type_id, leave_type.leave_type_name, leaves.half_day, leaves.start_date, "
	            + "leaves.start_time, leaves.end_time, leaves.end_date, leaves.no_day ,user.path, leaves.time_create, leaves.description "
	            + "FROM leaves LEFT JOIN leave_type ON leave_type.leave_type_id = leaves.leave_type_id LEFT JOIN user ON leaves.user_id = user.id "
	            + "WHERE leaves.start_date BETWEEN :startDate AND :endDate ");

	        sql.append("ORDER BY leaves.leave_status_id ASC, leaves.start_date DESC");
//	        sql.append("ORDER BY leaves.start_date DESC, leaves.leave_status_id ASC");

			SQLQuery query = session.createSQLQuery(sql.toString());
			query.setParameter("startDate", startDate);
			query.setParameter("endDate", endDate);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			search = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return search;
	}

	// this is override method use for search leave by type and all user
	public List<Map<String, Object>> searchtable(Timestamp startDate, Timestamp endDate, String userId, String type)
			throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> search = null;
		try {
			String sql = "SELECT leaves.description,leaves.leave_id,leaves.time_create,leaves.user_id,leaves.start_date, "
					+ " leaves.end_date, leaves.no_day ,leaves.leave_status_id,leave_type.leave_type_name , user.path "
					+ " FROM leaves LEFT JOIN leave_type ON leave_type.leave_type_id = leaves.leave_type_id "
					+ " LEFT JOIN user ON leaves.user_id = user.id "
					+ " WHERE leaves.start_date BETWEEN :startDate AND :endDate AND leaves.leave_status_id = :type "
					+ " ORDER BY start_date DESC ";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("startDate", startDate);
			query.setParameter("endDate", endDate);
			query.setParameter("type", type);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			search = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return search;
	}

	// use for search all unapprove by type
	public List<Map<String, Object>> searchtable4(Timestamp startDate, Timestamp endDate, String userId, String type)
			throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> search = null;
		try {

			String sql = "SELECT leaves.description, leaves.leave_id,leaves.time_create,leaves.user_id,leaves.start_date, "
					+ " user.path, leaves.end_date, leaves.no_day ,leaves.leave_status_id,leave_type.leave_type_name,leaves.leave_type_id "
					+ " FROM leaves " + " LEFT JOIN leave_type ON leave_type.leave_type_id = leaves.leave_type_id "
					+ " LEFT JOIN user ON leaves.user_id = user.id "
					+ " WHERE leaves.start_date BETWEEN :startDate AND :endDate AND leaves.leave_type_id = :type AND leaves.leave_status_id='1'"
					+ " ORDER BY start_date DESC ";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("startDate", startDate);
			query.setParameter("endDate", endDate);

			query.setParameter("type", type);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			search = query.list();
		} catch (

		Exception e) {
			e.printStackTrace();
		}
		return search;
	}

	// approvedall
//	@Override
//	public List<Map<String, Object>> searchapprovedall(Timestamp startDate, Timestamp endDate, String userId)
//			throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> search = null;
//		System.out.println(startDate);
//		System.out.println(endDate);
//		try {
//
//			String sql = "SELECT leaves.description, leaves.leave_id,leaves.time_create,leaves.user_id,leaves.start_date, "
//					+ " user.path,leaves.end_date, leaves.no_day ,leaves.leave_status_id,leave_type.leave_type_name,leaves.leave_type_id"
//					+ " FROM leaves " + " LEFT JOIN leave_type ON leave_type.leave_type_id = leaves.leave_type_id "
//					+ " LEFT JOIN user ON leaves.user_id = user.id "
//					+ " WHERE leaves.start_date BETWEEN :startDate AND :endDate AND leaves.leave_status_id='1' ORDER BY start_date DESC ";
//			SQLQuery query = session.createSQLQuery(sql);
//			query.setParameter("startDate", startDate);
//			query.setParameter("endDate", endDate);
//			// query.setParameter("userId", userId);
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			search = query.list();
//		} catch (
//
//		Exception e) {
//			e.printStackTrace();
//		}
//		return search;
//	}

//	@SuppressWarnings("unchecked")
//	@Override
//	public List<Map<String, Object>> searchmyleave(Timestamp startDate, Timestamp endDate, String user)
//			throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> search = null;
//		try {
//
//			String sql = " SELECT * FROM leaves  WHERE user_id = :user AND start_date BETWEEN :startDate AND :endDate "
//					+ " ORDER BY leaves.start_date DESC ";
//
//			SQLQuery query = session.createSQLQuery(sql);
//			query.setParameter("startDate", startDate);
//			query.setParameter("endDate", endDate);
//			query.setParameter("user", user);
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			search = query.list();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return search;
//	}
	// SELECT * FROM leaves WHERE start_date >= '2013-10-07 00:00:00'
	// AND end_date <= '2015-10-07 00:00:00'
	// AND user_id = 'kunchanok.s'

//	@Override
//	public List<Map<String, Object>> approverform(String leaveId) throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> one = null;
//		try {
//			String leave_id = "";
//			if (leaveId != null) {
//				leave_id = "  WHERE leave_id =  :leaveId";
//			}
//
//			String sql = "SELECT MIN(appr_user_id), leaves.leave_id, leaves.end_date, leaves.end_time, \n"
//					+ " leaves.leave_type_id, leaves.half_day, leaves.user_id, leaves.no_day, leaves.reason, \n"
//					+ " leaves.start_date, leaves.time_create, leaves.leave_status_id, leaves.appr_user_id, \n"
//					+ " leave_type.leave_type_name, \n" + " user.id, user.department_id, user.manager_id ,user.employee_id, user.name_en\n"
//					+ " FROM leaves \n" + " LEFT JOIN leave_type ON leaves.leave_type_id = leave_type.leave_type_id \n"
//					+ " LEFT JOIN user ON user.id = leaves.user_id \n" + leave_id + " ORDER BY user.id ASC "
//					+ " LIMIT 20 \n";
//
//			SQLQuery query = session.createSQLQuery(sql);
//			if (leaveId != null) {
//				query.setParameter("leaveId", leaveId);
//			}
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			one = query.list();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return one;
//	}

//	@Override
//	public List<Map<String, Object>> findMyApprover(String manager) throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> list = null;
//		try {
//			String approver = "";
//
//			if (manager != "") {
//				approver = "   WHERE leave_id =  :manager";
//			}
//
//			String sql = "SELECT MIN(appr_user_id), leaves.user_id, leaves.leave_id,\n" + " leaves.appr_user_id  "
//					+ " FROM leaves \n" + approver;
//
//			SQLQuery query = session.createSQLQuery(sql);
//			if (manager != "") {
//				query.setParameter("manager", manager);
//			}
//
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			list = query.list();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return list;
//	}

	// this is override method for search all leave type and specific user
//	@Override
//	public List<Map<String, Object>> searchtable2(Timestamp startDate, Timestamp endDate, String userId)
//			throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> search = null;
//		try {
//			String sql = "SELECT leaves.description, leaves.leave_id,leaves.time_create,leaves.user_id,user.name,leaves.start_date, leaves.end_date,"
//					+ " leaves.start_time, leaves.end_time, leaves.no_day ,leaves.leave_status_id,leave_type.leave_type_name, user.path, leaves.half_day "
//					+ " FROM leaves " + " LEFT JOIN leave_type ON leave_type.leave_type_id = leaves.leave_type_id "
//					+ " LEFT JOIN user ON leaves.user_id = user.id "
//					+ " WHERE user_id = :userId AND leaves.start_date BETWEEN :startDate AND :endDate "
//					+ " ORDER BY leaves.start_date DESC; ";
//
//			SQLQuery query = session.createSQLQuery(sql);
//			query.setParameter("startDate", startDate);
//			query.setParameter("endDate", endDate);
//			query.setParameter("userId", userId);
//
//			// query.setParameter("userId", userId);
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			search = query.list();
//		} catch (
//
//		Exception e) {
//			e.printStackTrace();
//		}
//		return search;
//	}

	//// use for search by leave type and specific user
	public List<Map<String, Object>> searchtable2(Timestamp startDate, Timestamp endDate, String userId, String type)
			throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> search = null;
		try {
			String sql = "SELECT leaves.description, leaves.leave_id,leaves.time_create,leaves.user_id,user.name,leaves.start_date, "
					+ " user.path, leaves.end_date, leaves.no_day ,leaves.leave_status_id,leave_type.leave_type_name, leaves.start_time, leaves.end_time, leaves.half_day "
					+ " FROM leaves LEFT JOIN leave_type ON leave_type.leave_type_id = leaves.leave_type_id "
					+ " LEFT JOIN user ON leaves.user_id = user.id "
					+ " WHERE user_id = :userId AND leaves.start_date BETWEEN :startDate AND :endDate AND leaves.leave_status_id = :type "
					+ " ORDER BY leaves.start_date DESC; ";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("startDate", startDate);
			query.setParameter("endDate", endDate);
			query.setParameter("userId", userId);
			query.setParameter("type", type);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			search = query.list();
		} catch (

		Exception e) {
			e.printStackTrace();
		}
		return search;
	}

	// use for search unapprove by type
	/*
	 * public List<Map<String, Object>> searchtable3(Timestamp startDate, Timestamp
	 * endDate, String userId, String type) throws Exception { Session session =
	 * this.sessionFactory.getCurrentSession(); List<Map<String, Object>> search =
	 * null; try { String sql =
	 * "SELECT leaves.description, leaves.leave_id,leaves.time_create,leaves.user_id,leaves.start_date, "
	 * +
	 * " user.path, leaves.end_date, leaves.no_day ,leaves.leave_status_id,leave_type.leave_type_name,leaves.leave_type_id "
	 * + " FROM leaves " +
	 * " LEFT JOIN leave_type ON leave_type.leave_type_id = leaves.leave_type_id " +
	 * " LEFT JOIN user ON leaves.user_id = user.id " +
	 * " WHERE user_id = :userId AND leaves.start_date BETWEEN :startDate AND :endDate AND leaves.leave_type_id = :type "
	 * + " ORDER BY start_date DESC "; SQLQuery query = session.createSQLQuery(sql);
	 * query.setParameter("startDate", startDate); query.setParameter("endDate",
	 * endDate); query.setParameter("userId", userId); query.setParameter("type",
	 * type);
	 * 
	 * query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
	 * search = query.list(); } catch (
	 * 
	 * Exception e) { e.printStackTrace(); } return search; }
	 */
	@Override
	public List<Map<String, Object>> searchtable3(String userId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> search = null;
		try {
			String sql = "SELECT * FROM leaves WHERE user_id = :userId " + " ORDER BY start_date DESC ";
			SQLQuery query = session.createSQLQuery(sql);

			query.setParameter("userId", userId);
			// query.setParameter("userId", userId);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			search = query.list();
		} catch (

		Exception e) {
			e.printStackTrace();
		}
		return search;
	}

	//
	// approved
//	@Override
//	public List<Map<String, Object>> searchapproved(Timestamp startDate, Timestamp endDate, String userId)
//			throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> search = null;
//		try {
//			String sql = "SELECT leaves.description, leaves.leave_id,leaves.time_create,leaves.user_id,leaves.start_date, "
//					+ " user.path, leaves.end_date, leaves.no_day ,leaves.leave_status_id,leave_type.leave_type_name ,leaves.leave_type_id "
//					+ " FROM leaves " + " LEFT JOIN leave_type ON leave_type.leave_type_id = leaves.leave_type_id "
//					+ " LEFT JOIN user ON leaves.user_id = user.id "
//					+ " WHERE user_id = :userId AND leaves.start_date BETWEEN :startDate AND :endDate "
//					+ " ORDER BY start_date DESC ";
//			SQLQuery query = session.createSQLQuery(sql);
//			query.setParameter("startDate", startDate);
//			query.setParameter("endDate", endDate);
//			query.setParameter("userId", userId);
//
//			// query.setParameter("userId", userId);
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			search = query.list();
//		} catch (
//
//		Exception e) {
//			e.printStackTrace();
//		}
//		return search;
//	}

//	@Override
//	public List<Map<String, Object>> startyear(Timestamp startDate, Timestamp endDate) {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> startyear = null;
//		try {
//			String sql = " Select * FROM leaves ORDER BY start_date DESC ";
//			SQLQuery query = session.createSQLQuery(sql);
//			query.setParameter("startDate", startDate);
//			query.setParameter("endDate", endDate);
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			startyear = query.list();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return startyear;
//
//	}

//	@Override
//	public List<Map<String, Object>> findleaveall(String userLogin) {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> wannla = null;
//		try {
//
//			String sql = " Select no_day,leave_type_id FROM leaves WHERE user_id = :userLogin ";
//			SQLQuery query = session.createSQLQuery(sql);
//			query.setParameter("userLogin", userLogin);
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			wannla = query.list();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return wannla;
//
//	}

//	@Override
//	public List<Map<String, Object>> findleaveByuser(String userLogin) {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> wannla = null;
//		try {
//
//			String sql = " Select * FROM leaves WHERE user_id = :userLogin ";
//			SQLQuery query = session.createSQLQuery(sql);
//			query.setParameter("userLogin", userLogin);
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			wannla = query.list();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return wannla;
//
//	}

//	@Override
//	public List<Map<String, Object>> findLeaveByUserAndYear(String userLogin, String year) {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> leaveDetail = null;
//		try {
//
//			String sql = " SELECT l.user_id, l.description, l.no_day, l.start_time, l.end_time,"
//					+ " date(l.start_date) as start_date, date(l.end_date) as end_date, leave_type.leave_type_name"
//					+ " FROM leaves AS l LEFT JOIN leave_type ON l.leave_type_id = leave_type.leave_type_id"
//					+ " WHERE l.user_id = :userLogin AND l.leave_status_id = 1 AND (l.leave_type_id=1 OR l.leave_type_id=2)"
//					+ " AND l.start_date LIKE :year AND l.end_date LIKE :year";
//			SQLQuery query = session.createSQLQuery(sql);
//			query.setParameter("userLogin", userLogin);
//			query.setParameter("year", year);
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			leaveDetail = query.list();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return leaveDetail;
//
//	}

//	@Override
//	public List<Map<String, Object>> join3table(String role) {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> joinn3 = null;
//		try {
//			String sql = " SELECT  ";
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return null;
//
//	}

//	@Override
//	public List<Map<String, Object>> searchtable3(String userId) throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> search = null;
//		try {
//			String sql = "SELECT * FROM leaves WHERE user_id = :userId " + " ORDER BY start_date DESC ";
//			SQLQuery query = session.createSQLQuery(sql);
//
//			query.setParameter("userId", userId);
//			// query.setParameter("userId", userId);
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			search = query.list();
//		} catch (
//
//		Exception e) {
//			e.printStackTrace();
//		}
//		return search;
//	}

//	@Override
//	public List<Map<String, Object>> top10(int year, String enable) throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> search = null;
//		String mystring = "";
//		String mystring2 = "";
//		if (year != 0 && !enable.equals("0")) {
//			mystring = "and year(leaves.start_date) = '" + year + "'";
//		} else if (year != 0) {
//			mystring = "where year(leaves.start_date) = '" + year + "'";
//		} else {
//			mystring = "";
//		}
//		if (!enable.equals("0")) {
//			mystring2 = "where user.enable = '" + enable + "'";
//		}
//		try {
//			String sql = "SELECT leaves.user_id ,sum(leaves.no_day)as total,user.enable,user.name FROM leaves "
//					+ " left join  user  on user.id = leaves.user_id " + "" + mystring2 + " " + mystring + " "
//					+ " group by leaves.user_id " + " order by total desc limit 10 ; ";
//			SQLQuery query = session.createSQLQuery(sql);
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			search = query.list();
//		} catch (
//
//		Exception e) {
//			e.printStackTrace();
//		}
//		return search;
//	}

	// Leaves Chart Report
//	@Override
//	public List<Map<String, Object>> LeaveAll(int month, int year, String enable, int sortz) throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> search = null;
//		String dateYM = "";
//		String status = "";
//		String Sorttype = "";
//		// search each year without month
//		if (month == 0 && !enable.equals("0")) {
//			dateYM = "and year(leaves.start_date) = '" + year + "' ";
//		} else if (month != 0 && year != 0) {
//			dateYM = "and year(leaves.start_date) = '" + year + "' and month(leaves.start_date) ='" + month + "'";
//		} else if (year == 0) {
//			dateYM = "";
//		} // search sum all year
//
//		if (!enable.equals("0")) {
//			status = "where user.enable = '" + enable + "'";
//		}
//		// leave largest to smallest
//		if (sortz == 1) {
//			Sorttype = "total desc";
//		} else {
//			Sorttype = "total asc";
//		}
//
//		try {
//			String sql = "SELECT leaves.user_id,user.enable,sum(leaves.no_day)as total,leave_type_id,user.name FROM leaves "
//					+ " left join  user  on user.id = leaves.user_id " + "" + status + " " + dateYM + " "
//					+ " group by leaves.user_id " + " ORDER BY " + Sorttype + " ";
//			SQLQuery query = session.createSQLQuery(sql);
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			search = query.list();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return search;
//	}

//	@Override
//	public List<Map<String, Object>> LeaveTypename(String user, int year, int month) throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> search = null;
//		String mystring = "";
//		if (month == 0 && year != 0) {
//			mystring = "and year(leaves.start_date) = '" + year + "'";
//		} else if (year == 0) {
//			mystring = "";
//		} else {
//			mystring = " and year(leaves.start_date) = '" + year + "'and month(leaves.start_date) ='" + month + "'";
//		}
//		try {
//			String sql = "SELECT leaves.leave_type_id ,sum(leaves.no_day) as countL,leave_type.leave_type_name as name FROM leaves "
//					+ " left join  leave_type on leaves.leave_type_id = leave_type.leave_type_id " + "WHERE user_id = '"
//					+ user + "' " + mystring + " " + "group by leaves.leave_type_id ";
//
//			SQLQuery query = session.createSQLQuery(sql);
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			search = query.list();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return search;
//	}

//	@Override
//	public List<Map<String, Object>> searchCountbyUser(String user, int year) throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> search = null;
//		String mystring = "";
//		if (year != 0) {
//			mystring = "and year(leaves.start_date) = '" + year + "'";
//		}
//		try {
//			String sql = "SELECT leaves.leave_type_id ,sum(leaves.no_day) as count, leave_type.leave_type_name as name FROM leaves "
//					+ " left join  leave_type on leaves.leave_type_id = leave_type.leave_type_id where user_id = '"
//					+ user + "' " + mystring + " " + "group by leaves.leave_type_id ";
//			SQLQuery query = session.createSQLQuery(sql);
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			search = query.list();
//		} catch (
//
//		Exception e) {
//			e.printStackTrace();
//		}
//		return search;
//	}

//	@Override
//	public List<Map<String, Object>> searchCountbyMonths(int month, int year, String enable) throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> search = null;
//		String mystring = "";
//		String mystring2 = "";
//		if (year != 0) {
//			mystring = "and year(leaves.start_date) = '" + year + "'";
//		}
//		if (!enable.equals("0")) {
//			mystring2 = "and user.enable = '" + enable + "'";
//		}
//		try {
//			String sql = "SELECT leaves.leave_type_id ,sum(leaves.no_day) as counts,leave_type.leave_type_name as name  FROM leaves  "
//					+ " left join  leave_type on leaves.leave_type_id = leave_type.leave_type_id "
//					+ " left join user on leaves.user_id = user.id " + " where month(leaves.start_date) = '" + month
//					+ "' " + mystring
//					+ " and (leaves.leave_type_id = '1' or leaves.leave_type_id = '3' or leaves.leave_type_id = '5') "
//					+ "  " + mystring2 + " " + " group by leaves.leave_type_id ; ";
//			SQLQuery query = session.createSQLQuery(sql);
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			search = query.list();
//		} catch (
//
//		Exception e) {
//			e.printStackTrace();
//		}
//		return search;
//	}

	public List<Map<String, Object>> ReportsByyear2(int year, String user) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> search = null;
		try {
			String sql = "SELECT COALESCE(sum(no_day),0) as sum FROM leaves "
					+ " left join  leave_type on leaves.leave_type_id = leave_type.leave_type_id  "
					+ " where  year(leaves.start_date)= '" + year + "' and leaves.user_id ='" + user
					+ "'  and month(leaves.start_date) = '1' ";
			for (int i = 2; i <= 12; i++) {
				sql += " UNION ALL " + " SELECT COALESCE(sum(no_day),0) as sum  FROM leaves "
						+ " left join  leave_type on leaves.leave_type_id = leave_type.leave_type_id "
						+ " where  year(leaves.start_date)= '" + year + "' and leaves.user_id ='" + user
						+ "'  and month(leaves.start_date) = '" + i + "' \n ";
			}
			SQLQuery query = session.createSQLQuery(sql);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			search = query.list();
		} catch (

		Exception e) {
			e.printStackTrace();
		}
		return search;
	}

	@Override
	public Double LastYearQuota(String userId, int currentYear) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		Criteria cr = session.createCriteria(Leaves.class);
		Criteria cr2 = session.createCriteria(User.class);

		int year = currentYear - 1;
		String year_s = "01-01-" + year;
		String year_e = "31-12-" + year;
		Timestamp start_date = DateUtil.dateFormat(year_s);
		Timestamp end_date = DateUtil.dateFormat(year_e);
		Double daysleft = 0.000;

		User user = (User) cr2.add(Restrictions.eq("id", userId)).uniqueResult();
		Double quota1 = 0.0, quota2 = 0.0; // 1=holiday leave 2=business leave 3=sick leave
		if (user.getLeaveQuota1() != null) { // if have not value set
			quota1 = user.getLeaveQuota1().doubleValue();
		}
		if (user.getLeaveQuota2() != null) {
			quota2 = user.getLeaveQuota2().doubleValue();
		}
		// else quota=0
		try {
			daysleft = user.getLeaveQuota4().doubleValue();
		} catch (Exception e) {
			daysleft = 0.000;
		}

		List daysoff = cr.add(Restrictions.eq("userId", userId)).add(Restrictions.gt("startDate", start_date))
				.add(Restrictions.lt("endDate", end_date)).list();

//        for (Iterator iterator = daysoff.iterator(); iterator.hasNext();){
//            Leaves leave = (Leaves) iterator.next(); 
//            Double noday = leave.getNoDay().doubleValue();
//            if(leave.getLeaveTypeId().contains("1")
//            		|| leave.getLeaveTypeId().contains("2")) {
//            	daysleft -= noday;
//            }
//         }
		return daysleft;
	}

	@Override
	public Double ThisYearQuota(String userId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		Criteria cr = session.createCriteria(User.class);
		User user = (User) cr.add(Restrictions.eq("id", userId)).uniqueResult();
		Double quota1 = 0.0, quota2 = 0.0;
		if (user.getLeaveQuota1() != null) {
			quota1 = user.getLeaveQuota1().doubleValue();
		}
		if (user.getLeaveQuota2() != null) {
			quota2 = user.getLeaveQuota2().doubleValue();
		}
		Double quota = quota1 + quota2;

		return quota; // calculate quota from database
	}

	@Override
	public List<Map<String, Object>> myLeavesList(String userId, Timestamp startDate, Timestamp endDate) {
//		Session session = this.sessionFactory.getCurrentSession();
//		Criteria cr = session.createCriteria(Leaves.class);
//
//		List list = cr.add(Restrictions.eq("userId", userId)).add(Restrictions.gt("startDate", startDate))
//				.add(Restrictions.lt("endDate", endDate)).addOrder(Order.desc("leaveId")).list();
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> searchbydate = null;
		String sql = "SELECT leaves.*, " + "leave_type.leave_type_name, " + "user.name, " + "file.path AS file_path "
				+ "FROM leaves " + "LEFT JOIN leave_type ON leaves.leave_type_id = leave_type.leave_type_id "
				+ "LEFT JOIN user ON leaves.user_id = user.id " + "LEFT JOIN file ON leaves.leave_file = file.file_id "
				+ "WHERE leaves.user_id = '" + userId + "' " + "AND leaves.start_date >= '" + startDate + "' "
				+ "AND leaves.start_date <= '" + endDate + "' " + "ORDER BY leaves.time_create DESC";
		SQLQuery query = session.createSQLQuery(sql);
		query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
		searchbydate = query.list();
		return searchbydate;
	}

	@Override
	public List<Map<String, Object>> myLeavesList(String userId, Timestamp startDate, Timestamp endDate,
			String status) {
		Session session = this.sessionFactory.getCurrentSession();
		Criteria cr = session.createCriteria(Leaves.class);

		List list = cr.add(Restrictions.eq("userId", userId)).add(Restrictions.eq("leaveStatusId", status))
				.add(Restrictions.gt("startDate", startDate)).add(Restrictions.lt("endDate", endDate))
				.addOrder(Order.desc("leaveId")).list();
		List<Map<String, Object>> searchbydate = null;
		String sql = "SELECT * FROM leaves WHERE user_id ='" + userId + "' AND start_date>='" + startDate
				+ "' AND start_date<='" + endDate + "' AND leave_status_id = '" + status + "'";
		SQLQuery query = session.createSQLQuery(sql);
		query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
		searchbydate = query.list();
		return searchbydate;
	}

	@Override
	public List findLeaveId(String userId, Timestamp startDate, Timestamp endDate, String status) {
		Session session = this.sessionFactory.getCurrentSession();
		List searchbydate = null;
		String sql = "SELECT leave_id FROM leaves WHERE user_id ='" + userId + "' AND start_date>='" + startDate
				+ "' AND start_date<='" + endDate + "' AND leave_status_id = '" + status + "'";
		SQLQuery query = session.createSQLQuery(sql);
		query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
		searchbydate = query.list();
		return searchbydate;
	}

	@Override
	public String sumWaitLeave(String user) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		String result = null;
		try {
			String sql = "SELECT SUM(no_day) as sum FROM leaves WHERE user_id = '" + user
					+ "' AND leave_status_id = 0 ";
			SQLQuery query = session.createSQLQuery(sql);

			result = query.uniqueResult().toString();
		} catch (

		Exception e) {
			e.printStackTrace();
		}
		return result;
	}

//	@Override
//	public List<Map<String, Object>> test_LeavesList(String userId, int year) {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> test_LeavesList = null;
//		try {
//
//			String sql = "SELECT user_id,start_date,end_date,leaves.leave_type_id,leave_type.leave_type_name FROM `leaves` INNER JOIN leave_type ON leaves.leave_type_id=leave_type.leave_type_id WHERE user_id = '"
//					+ userId + "' AND YEAR(start_date) = '" + year
//					+ "' AND leave_status_id = '1' GROUP BY DATE(start_date) ORDER BY (start_date)";
//
//			SQLQuery query = session.createSQLQuery(sql);
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			test_LeavesList = query.list();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return test_LeavesList;
//	}

//	@Override
//	public List<Map<String, Object>> test_LeavesSummary(int year, int type) {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> test_LeavesSummary = null;
//		try {
//			String sql = "SELECT user_id,DAY(start_date)AS Day ,MONTH(start_date)AS Month ,no_day,leave_status_id FROM `leaves` WHERE YEAR(start_date) ='"
//					+ year + "' AND leave_status_id= '" + type + "' ORDER BY start_date ASC";
//
//			SQLQuery query = session.createSQLQuery(sql);
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			test_LeavesSummary = query.list();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return test_LeavesSummary;
//	}

//	@Override
//	public List<Map<String, Object>> leaveselectM(int year) throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> leaveselectM = null;
//		try {
//
//			String sql = "SELECT user_id,DAY(start_date)AS DAY,MONTH(start_date)AS MONTH,DAY(end_date)AS ENDDAY,MONTH(end_date)AS ENDMONTH FROM `leaves` WHERE YEAR(start_date)='"
//					+ year + "' ORDER BY DATE(start_date) ASC";
//
//			SQLQuery query = session.createSQLQuery(sql);
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			leaveselectM = query.list();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return leaveselectM;
//	}

//	@Override
//	public List<Map<String, Object>> searchApproved(Timestamp start_date, Timestamp end_date, String jsonId,
//			String jsonStatus, String jsonType) throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> search = null;
//		String type;
//		String status;
//		String id;
//		if (jsonId.equals("All")) {
//			id = "";
//		} else {
//			id = " user_id = '" + jsonId + "' AND ";
//		}
//		if (jsonType.equals("All")) {
//			type = "";
//		} else {
//			type = " leaves.leave_type_id = '" + jsonType + "' AND ";
//		}
//		if (jsonStatus.equals("3")) {
//			status = "";
//		} else {
//			status = " leaves.leave_status_id = '" + jsonStatus + "' AND ";
//		}
//		try {
//			String sql = "SELECT leaves.description, leaves.leave_id,DATE_FORMAT(leaves.time_create,'%d/%m/%Y %H:%i') AS time_create,leaves.user_id,DATE_FORMAT(leaves.start_date,'%d/%m/%Y') AS start_date, DATE_FORMAT(leaves.end_date,'%d/%m/%Y') AS end_date, leaves.no_day ,leaves.leave_status_id,leave_type.leave_type_name, user.path   FROM leaves LEFT JOIN leave_type ON leave_type.leave_type_id = leaves.leave_type_id LEFT JOIN user ON leaves.user_id = user.id WHERE "
//					+ id + "" + type + "" + status + "leaves.start_date BETWEEN '" + start_date + "' AND '" + end_date
//					+ "' ORDER BY start_date DESC";
//
//			SQLQuery query = session.createSQLQuery(sql);
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			search = query.list();
//		} catch (
//
//		Exception e) {
//			e.printStackTrace();
//		}
//		return search;
//	}

	public List<Map<String, Object>> searchDashboard(String jsonId, String date) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> search = null;
		String id;
		if (jsonId.equals("All")) {
			id = "";
		} else {
			id = jsonId;
		}
		try {
			String sql = "SELECT user_id,(SELECT FORMAT(SUM(no_day),2)AS type6 FROM leaves WHERE user_id='" + id
					+ "' AND leave_status_id='1' AND leave_type_id='1' AND year(start_date)=" + date
					+ ")as type1,(SELECT FORMAT(SUM(no_day),2)AS type6 FROM leaves WHERE user_id='" + id
					+ "' AND leave_status_id='1' AND leave_type_id='3' AND year(start_date)=" + date
					+ ")as type3,(SELECT FORMAT(SUM(no_day),2)AS type6 FROM leaves WHERE user_id='" + id
					+ "' AND leave_status_id='1' AND leave_type_id='6' AND year(start_date)=" + date
					+ ")as type6 FROM leaves WHERE user_id='" + id
					+ "' AND leave_status_id='1' AND (leave_type_id='1' OR leave_type_id='3' OR leave_type_id='6') GROUP BY user_id='"
					+ id + "'";

			SQLQuery query = session.createSQLQuery(sql);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			search = query.list();
		} catch (

		Exception e) {
			e.printStackTrace();
		}
		return search;
	}

	public List<Map<String, Object>> searchDashboardQuota(String jsonId, String date) throws Exception {

		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> search = null;
		String id;
		if (jsonId.equals("All")) {
			id = "";
		} else {
			id = jsonId;
		}
		try {
			String sql = "SELECT id,FORMAT(leave_quota_1,2)AS thisYear,FORMAT(leave_quota_lastyear,2)AS lastYear FROM user WHERE id='"
					+ id + "'";

			SQLQuery query = session.createSQLQuery(sql);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			search = query.list();
		} catch (

		Exception e) {
			e.printStackTrace();
		}
		return search;
	}

	public List<Map<String, Object>> leaveUpdateStatus(String userId, String leave) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> search = null;

		try {
			String sql = "UPDATE leaves SET leave_status_id = '1', appr_user_id= '" + userId + "' WHERE leave_id = '"
					+ leave + "'";
			SQLQuery query = session.createSQLQuery(sql);
			query.executeUpdate();

			String sqlSearch = "SELECT * FROM `leaves` WHERE leave_id = '" + leave + "'";

			SQLQuery querySearch = session.createSQLQuery(sqlSearch);
			querySearch.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			search = querySearch.list();
		} catch (

		Exception e) {
			e.printStackTrace();
		}
		return search;
	}

	@Override
	public List<Map<String, Object>> findUserLeave(String user, Timestamp start_date1, Timestamp end_date1)
			throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> userleave = null;

		try {
			String sql = "SELECT * FROM leaves WHERE user_id=:user AND (leaves.start_date BETWEEN :start_date1 AND :end_date1) order by start_date ";

			SQLQuery query = session.createSQLQuery(sql);

			query.setParameter("user", user);
			query.setParameter("start_date1", start_date1);
			query.setParameter("end_date1", end_date1);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			userleave = query.list();
		} catch (

		Exception e) {
			e.printStackTrace();
		}
		return userleave;
	}

	public List<Map<String, Object>> findUserAllLeave(Timestamp start_date1, Timestamp end_date1) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> userallleave = null;
		try {
			String sql = "SELECT * FROM leaves WHERE leaves.start_date BETWEEN :start_date1 AND :end_date1";
			SQLQuery query = session.createSQLQuery(sql);

			query.setParameter("start_date1", start_date1);
			query.setParameter("end_date1", end_date1);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			userallleave = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userallleave;

	}

//	@Override
//	public List<Map<String, Object>> reportleavemonth(String months, String years) throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> rplm = null;
//
//		try {
//			String sql = "SELECT  leaves.*,leave_type.leave_type_name ,user.name FROM leaves LEFT JOIN leave_type ON leaves.leave_type_id = leave_type.leave_type_id LEFT JOIN user ON leaves.user_id = user.id WHERE YEAR(leaves.start_date)=:year AND MONTH(leaves.start_date)=:month AND leaves.leave_status_id = '1' ORDER BY user.name ASC";
//
//			SQLQuery query = session.createSQLQuery(sql);
//
//			query.setParameter("month", months);
//			query.setParameter("year", years);
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			rplm = query.list();
//		} catch (
//
//		Exception e) {
//			e.printStackTrace();
//		}
//		return rplm;
//	}

//	@Override
//	public List<Map<String, Object>> searchreportleavemonth1(String months, String years) throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> srplm = null;
//		System.out.println(months);
//		System.out.println(years);
//		try {
//			String sql = "SELECT  leaves.*,leave_type.leave_type_name ,user.name FROM leaves LEFT JOIN leave_type ON leaves.leave_type_id = leave_type.leave_type_id LEFT JOIN user ON leaves.user_id = user.id WHERE YEAR(leaves.start_date)=:year AND MONTH(leaves.start_date)=:month AND leaves.leave_status_id = '1' ORDER BY user.name ASC";
//
//			SQLQuery query = session.createSQLQuery(sql);
//
//			query.setParameter("month", months);
//			query.setParameter("year", years);
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			srplm = query.list();
//		} catch (
//
//		Exception e) {
//			e.printStackTrace();
//		}
//		return srplm;
//	}

//	@Override
//	public List<Map<String, Object>> reportleaveyeartype1(String years) throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> rplm = null;
//
//		try {
//			String sql = "SELECT SUM(no_day) as sumday, user_id, leave_type_id FROM leaves WHERE leave_type_id = 1 and YEAR(start_date)=:year GROUP BY user_id";
//
//			SQLQuery query = session.createSQLQuery(sql);
//			query.setParameter("year", years);
//
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			rplm = query.list();
//		} catch (
//
//		Exception e) {
//			e.printStackTrace();
//		}
//		return rplm;
//	}

//	@Override
//	public List<Map<String, Object>> reportleaveyeartype2(String years) throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> rplm = null;
//
//		try {
//			String sql = "SELECT SUM(no_day) as sumday, user_id, leave_type_id FROM leaves WHERE leave_type_id = 2 and YEAR(start_date)=:year GROUP BY user_id";
//
//			SQLQuery query = session.createSQLQuery(sql);
//			query.setParameter("year", years);
//
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			rplm = query.list();
//		} catch (
//
//		Exception e) {
//			e.printStackTrace();
//		}
//		return rplm;
//	}

//	@Override
//	public List<Map<String, Object>> reportleaveyeartype3(String years) throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> rplm = null;
//
//		try {
//			String sql = "SELECT SUM(no_day) as sumday, user_id, leave_type_id FROM leaves WHERE leave_type_id = 3 and YEAR(start_date)=:year GROUP BY user_id";
//
//			SQLQuery query = session.createSQLQuery(sql);
//			query.setParameter("year", years);
//
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			rplm = query.list();
//		} catch (
//
//		Exception e) {
//			e.printStackTrace();
//		}
//		return rplm;
//	}

//	@Override
//	public List<Map<String, Object>> reportleaveyeartype5(String years) throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> rplm = null;
//
//		try {
//			String sql = "SELECT SUM(no_day) as sumday, user_id, leave_type_id FROM leaves WHERE leave_type_id = 5 and YEAR(start_date)=:year GROUP BY user_id";
//
//			SQLQuery query = session.createSQLQuery(sql);
//			query.setParameter("year", years);
//
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			rplm = query.list();
//		} catch (
//
//		Exception e) {
//			e.printStackTrace();
//		}
//		return rplm;
//	}

//	@Override
//	public List<Map<String, Object>> reportleaveyeartype6(String years) throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> rplm = null;
//
//		try {
//			String sql = "SELECT SUM(no_day) as sumday, user_id, leave_type_id FROM leaves WHERE leave_type_id = 6 and YEAR(start_date)=:year GROUP BY user_id";
//
//			SQLQuery query = session.createSQLQuery(sql);
//			query.setParameter("year", years);
//
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			rplm = query.list();
//		} catch (
//
//		Exception e) {
//			e.printStackTrace();
//		}
//		return rplm;
//	}

	public List<Map<String, Object>> reportallleave(String years) {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> userallreport = null;

		try {
			String sql = "SELECT user_id FROM leaves WHERE YEAR(start_date)=:year GROUP BY user_id ";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("year", years);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			userallreport = query.list();
		} catch (HibernateException e) {
			e.printStackTrace();
		}
		return userallreport;
	}

	public List<Map<String, Object>> leavejson() {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> userallreport = null;

		try {
			String sql = "SELECT * FROM leaves WHERE YEAR(start_date)='2021'";
			SQLQuery query = session.createSQLQuery(sql);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			userallreport = query.list();
		} catch (HibernateException e) {
			e.printStackTrace();
		}
		return userallreport;
	}

	public List<Map<String, Object>> searchtable3(Timestamp startDate, Timestamp endDate, String type)
			throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> search = null;
		try {
			String sql = "SELECT leaves.leave_id, leaves.user_id, user.name, leaves.leave_status_id, leave_type.leave_type_name, leaves.start_date, "
					+ "leaves.end_date, leaves.no_day, leaves.half_day, leaves.start_time, leaves.end_time, user.path, leaves.description, leaves.time_create, "
					+ "leaves.time_update FROM leaves LEFT JOIN leave_type ON leave_type.leave_type_id = leaves.leave_type_id "
					+ "LEFT JOIN user ON leaves.user_id = user.id WHERE leaves.start_date BETWEEN :startDate AND :endDate AND leaves.leave_status_id = :type "
					+ "ORDER BY leaves.start_date DESC; ";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("startDate", startDate);
			query.setParameter("endDate", endDate);
			query.setParameter("type", type);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			search = query.list();
		} catch (

		Exception e) {
			e.printStackTrace();
		}
		return search;
	}

	@Override
	public List<Map<String, Object>> findLeaveInTeamByManager(Timestamp startDate, Timestamp endDate, String manager) throws Exception {
	    Session session = this.sessionFactory.getCurrentSession();
	    List<Map<String, Object>> leavelist = null;
	    try {
	        StringBuilder sql = new StringBuilder(
	            "SELECT leaves.leave_id, leaves.user_id, user.name, leaves.leave_status_id, leaves.leave_type_id, leave_type.leave_type_name, "
	            + "leaves.half_day, leaves.start_date, leaves.start_time, leaves.end_time, leaves.end_date, leaves.no_day, "
	            + "leaves.appr_user_id, user.path, leaves.time_create, leaves.description "
	            + "FROM leaves LEFT JOIN leave_type ON leave_type.leave_type_id = leaves.leave_type_id "
	            + "LEFT JOIN user ON leaves.user_id = user.id "
	            + "WHERE leaves.start_date BETWEEN :startDate AND :endDate "
	            + "AND (user.manager_id = :manager OR leaves.appr_user_id = :manager) "
	        );

	        sql.append("ORDER BY leaves.leave_status_id ASC, leaves.start_date DESC");
//	        sql.append("ORDER BY leaves.start_date DESC, leaves.leave_status_id ASC");

			SQLQuery query = session.createSQLQuery(sql.toString());
			query.setParameter("startDate", startDate);
			query.setParameter("endDate", endDate);
			query.setParameter("manager", manager);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

			leavelist = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return leavelist;
	}

	@Override
	public List<Map<String, Object>> findLeaveInTeamByManagerAndType(Timestamp startDate, Timestamp endDate,
			String manager, String status, String leaveType) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> leavelist = null;
		try {
			StringBuilder sql = new StringBuilder(
					"SELECT leaves.leave_id, leaves.user_id, user.name, leaves.leave_status_id, leaves.leave_type_id, leave_type.leave_type_name, leaves.half_day, "
					+ "leaves.start_date, leaves.start_time, leaves.end_time, leaves.end_date, leaves.no_day , file.path, leaves.time_create, "
					+ "leaves.description FROM leaves LEFT JOIN leave_type ON leave_type.leave_type_id = leaves.leave_type_id "
					+ "LEFT JOIN user ON leaves.user_id = user.id LEFT JOIN file ON leaves.leave_file = file.file_id "
					+ "WHERE leaves.start_date BETWEEN :startDate AND :endDate ");
			if(manager != null && !manager.isEmpty()) {
				sql.append("AND leaves.appr_user_id = :manager ");
			}
			if (status != null && !status.isEmpty() && !status.equals("4")) {
				sql.append("AND leaves.leave_status_id = :status ");
			}
			if (leaveType != null && !leaveType.isEmpty() && !leaveType.equals("allType")) {
				sql.append("AND leaves.leave_type_id = :leaveType ");
			}
			sql.append("ORDER BY leaves.leave_status_id ASC, leaves.start_date DESC; ");
//			sql.append("ORDER BY leaves.start_date DESC, leaves.leave_status_id ASC; ");
			
			SQLQuery query = session.createSQLQuery(sql.toString());
			query.setParameter("startDate", startDate);
			query.setParameter("endDate", endDate);

			if (manager != null && !manager.isEmpty()) {
				query.setParameter("manager", manager);
			}
			if (status != null && !status.isEmpty() && !status.equals("4")) {
				query.setParameter("status", status);
			}
			if (leaveType != null && !leaveType.isEmpty() && !leaveType.equals("allType")) {
				query.setParameter("leaveType", leaveType);
			}
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			leavelist = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return leavelist;
	}

	@Override
	public List<Map<String, Object>> findUserAllLeaveInTeam(Timestamp start_date1, Timestamp end_date1, String manager)
			throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> userAllLeave = null;
		try {
			String sql = "SELECT * FROM leaves WHERE leaves.start_date BETWEEN :start_date1 AND :end_date1 AND leaves.appr_user_id = :manager ORDER BY leaves.time_create DESC ";
			SQLQuery query = session.createSQLQuery(sql);

			query.setParameter("start_date1", start_date1);
			query.setParameter("end_date1", end_date1);
			query.setParameter("manager", manager);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			userAllLeave = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userAllLeave;
	}

//	@Override
//	public List<Map<String, Object>> listUserByDatepicker(Timestamp startdate, Timestamp enddate) throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> list_user = null;
//		String sql = null;
//
//		try {
//			sql = "SELECT "
//					+ "id AS user_id, employee_id AS employee_id, name AS employee_name , start_date AS startdate , end_date AS enddate "
//					+ "FROM user "
//					+ "WHERE enable = 1 OR (end_date > '"+ startdate +"') "
//					+ "GROUP BY id " 
//					+ "ORDER BY start_date,id;";
//			SQLQuery query = session.createSQLQuery(sql);
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			list_user = query.list();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return list_user;
//	}

//	@Override
//	public List<Map<String, Object>> listLateDate(Timestamp startdate, Timestamp enddate) throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> listday_late = null;
//		String sql = null;
//		try {
//			sql =   "SELECT\r\n"
//					+ "    u.id AS user_id,\r\n"
//					+ "    work_date,\r\n"
//					+ "	   TIME_FORMAT(TIME(earliest_time), '%H:%i:%s') AS earliest_time,\r\n"
//					+ "    TIME_FORMAT(TIME(latest_time), '%H:%i:%s') AS latest_time \r\n"
//					+ "FROM user u\r\n"
//					+ "LEFT JOIN (\r\n"
//					+ "    SELECT\r\n"
//					+ "        user_create,\r\n"
//					+ "        DATE(work_hours_time_work) AS work_date,\r\n"
//					//+ "		 TIME(ADDTIME(MIN(CASE WHEN work_hours_type = 1 THEN work_hours_time_work END), '07:00:00')) AS earliest_time,\r\n"
//					//+ "        TIME(ADDTIME(MAX(CASE WHEN work_hours_type = 2 THEN work_hours_time_work END), '07:00:00')) AS latest_time\r\n"
//				    + "        MIN(CASE WHEN work_hours_type = 1 THEN work_hours_time_work END) AS earliest_time,\r\n"
//				    + "        MAX(CASE WHEN work_hours_type = 2 THEN work_hours_time_work END) AS latest_time\r\n"
//					+ "    FROM work_hours\r\n"
//					+ "    WHERE work_hours_time_work BETWEEN '"+ startdate +"' AND '"+ enddate +"'\r\n"
//					+ "    GROUP BY user_create, work_date\r\n"
//					+ ") wh ON u.id = wh.user_create\r\n"
//					+ "WHERE (u.enable = 1 OR (u.end_date > '"+ startdate +"'))\r\n"
//					+ "AND ((TIME_FORMAT(wh.earliest_time, '%H:%i:%s') BETWEEN STR_TO_DATE(CONCAT(u.work_time_start, ':01'), '%H:%i:%s') AND DATE_SUB(STR_TO_DATE(CONCAT(u.work_time_end, ':01'), '%H:%i:%s'), INTERVAL 2 SECOND)) OR\r\n"
//					+ "    (TIME_FORMAT(wh.latest_time, '%H:%i:%s') BETWEEN STR_TO_DATE(CONCAT(u.work_time_start, ':01'), '%H:%i:%s') AND DATE_SUB(STR_TO_DATE(CONCAT(u.work_time_end, ':01'), '%H:%i:%s'), INTERVAL 2 SECOND)))\r\n"
//					+ "AND DAYOFWEEK(work_date) BETWEEN 2 AND 6 \r\n"
//					+ "ORDER BY u.start_date, u.id;";
//			SQLQuery query = session.createSQLQuery(sql);
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			listday_late = query.list();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return listday_late;
//	}

//	@Override
//	public List<Map<String, Object>> listLeaveDate(Timestamp startdate, Timestamp enddate) throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> listday_leave = null;
//		String sql = null;
//		try {
//			sql =   "SELECT\r\n"
//					+ "	   u.id,\r\n"
//					+ "	   l.leave_type_id AS type,\r\n"
//					+ "    DATE(l.start_date) AS date,\r\n"
//					+ "    DATE(l.end_date) AS enddate,\r\n"
//					+ "    l.half_day,\r\n"
//					+ "    ROUND(l.no_day, 3) AS no_day,\r\n"
//					+ "    TIME_FORMAT(TIME(u.work_time_start), '%H:%i:%s') AS work_time_start,\r\n"
//					+ "    TIME_FORMAT(TIME(u.work_time_end), '%H:%i:%s') AS work_time_end,\r\n"
//					+ "    TIME_FORMAT(TIME(start_time), '%H:%i:%s') AS start_time,\r\n"
//					+ "    TIME_FORMAT(TIME(end_time), '%H:%i:%s') AS end_time "
//					+ "    FROM user u\r\n"
//					+ "    LEFT JOIN leaves l ON  u.id = l.user_id AND ((l.start_date BETWEEN '"+ startdate +"' AND '"+ enddate +"') "
//					+ "	   OR (l.end_date BETWEEN '"+ startdate +"' AND '"+ enddate +"')  \r\n"
//					+ "	   OR (l.start_date <= '"+ startdate +"' AND l.end_date >= '"+ enddate +"'))  \r\n"
//					+ "    WHERE (u.enable = 1 OR (u.end_date > '"+ startdate +"')) \r\n"
//					+ "	   AND leave_status_id = 1\r\n"
//					+ "	   AND leave_type_id != 9\r\n"
//					+ "	   ORDER BY u.start_date,u.id;";
//			SQLQuery query = session.createSQLQuery(sql);
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			listday_leave = query.list();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return listday_leave;
//	}

//	@Override
//	public List<Map<String, Object>> listAbsentDate(Timestamp startdate, Timestamp enddate) throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> listday_absent = null;
//		String sql = null;
//		try {
//			sql = "SELECT u.id AS user_id, DATE(wh.work_hours_time_work) AS date\r\n , u.start_date AS startdate , u.end_date AS enddate "
//					+ "FROM user u\r\n"
//					+ "LEFT JOIN work_hours wh ON u.id = wh.user_create AND (work_hours_time_work BETWEEN '"+ startdate +"' AND '"+ enddate +"')\r\n"
//					+ "WHERE u.enable = 1 OR (u.end_date > '"+ startdate +"')\r\n"
//					+ "GROUP BY user_id, date\r\n"
//					+ "HAVING COUNT(DISTINCT wh.work_hours_type) = 2;";
//			SQLQuery query = session.createSQLQuery(sql);
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			listday_absent = query.list();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return listday_absent;
//	}

//	@Override
//	public List<Map<String, Object>> listForgotCheckdate(Timestamp startdate, Timestamp enddate) throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> sumdatelist = null;
//		String sql = null;
//
//		try {
//			sql = "SELECT u.id AS user_id, DATE(wh.work_hours_time_work) AS date\r\n , u.start_date AS startdate , u.end_date AS enddate "
//					+ "FROM user u\r\n"
//					+ "LEFT JOIN work_hours wh ON u.id = wh.user_create AND (work_hours_time_work BETWEEN '"+ startdate +"' AND '"+ enddate +"')\r\n"
//					+ "WHERE u.enable = 1 OR (u.end_date > '"+ startdate +"')\r\n"
//					+ "GROUP BY user_id, date\r\n"
//					+ "HAVING COUNT(DISTINCT wh.work_hours_type) = 1;";
//			SQLQuery query = session.createSQLQuery(sql);
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			sumdatelist = query.list();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return sumdatelist;
//	}

//	@Override
//	public List<Map<String, Object>> getDataMonth2(String userId, String selectedYear, String selectedMonth) throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> work_status = null;
//		try {
//			String sql = "SELECT hour(m.work_hours_time_work) as myhour, minute(m.work_hours_time_work) as mymin, description ,m.work_hours_id "
//					+ " ,m.work_hours_type,m.user_create,m.time_create, m.work_hours_time_work,date_format(m.work_hours_time_work,'%d-%m-%y')as `date`, "
//					+ " time(m.work_hours_time_work)as `time`,u.role_id as 'u_rold',u.name as 'u_name',m.work_hours_type as `check_type` "
//					+ " from work_hours m inner join `user` u on m.user_create = u.id where m.user_create =:userId "
//					+ " and YEAR(m.time_create) =:selectedYear AND MONTH(m.time_create) =:selectedMonth order by work_hours_time_work ASC;";
//			SQLQuery query = session.createSQLQuery(sql);
//			query.setParameter("userId", userId);
//			query.setParameter("selectedYear", selectedYear);
//			query.setParameter("selectedMonth", selectedMonth);
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			work_status = query.list();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return work_status;
//	}

//	@Override
//	public List<Map<String, Object>> getLeaveInMonth(String userId, String selectedYear, String selectedMonth) throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> leavelist = null;
//		try {
//			String sql = "select leaves.*, file.path from leaves LEFT JOIN file ON leaves.leave_file = file.file_id where leaves.user_id =:userId "
//					+ " and YEAR(leaves.start_date) =:selectedYear AND MONTH(leaves.start_date) =:selectedMonth ";
//			SQLQuery query = session.createSQLQuery(sql);
//			query.setParameter("userId", userId);
//			query.setParameter("selectedYear", selectedYear);
//			query.setParameter("selectedMonth", selectedMonth);
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			leavelist = query.list();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return leavelist;
//	}

//	@Override
//	public List<Map<String, Object>> getDataWorkingTimeInMonth(String userId, String selectedYear, String selectedMonth)
//			throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<Map<String, Object>> workingTime = null;
//		try {
//			String sql = "SELECT workinghours FROM work_hours "
//					+ "WHERE user_create =:userId and YEAR(time_create) =:selectedYear AND MONTH(time_create) =:selectedMonth "
//					+ "order by work_hours_time_work ASC;";
//			SQLQuery query = session.createSQLQuery(sql);
//			query.setParameter("userId", userId);
//			query.setParameter("selectedYear", selectedYear);
//			query.setParameter("selectedMonth", selectedMonth);
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			workingTime = query.list();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return workingTime;
//	}

	public List<Map<String, Object>> getLeaveListByDateAndIdSiteJob(String dateStart, String dateEnd, String idSiteJob)
			throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> list = null;
		try {
			String sql = "SELECT\n" + "	distinct lv.leave_id,\n" + "	lv.user_id AS id,\n" + "	u.employee_id,\n"
					+ "	u.name,\n" + " 	CASE\n"
					+ " 	    WHEN u.employee_id is not null && u.employee_id != '' && u.name_en is not null && u.name_en != ''\n"
					+ " 	    	&& u.name is not null && u.name != ''\n"
					+ " 	    	THEN concat(u.employee_id, ' - ', u.name_en, ' - ', u.name)\n"
					+ " 	    WHEN u.employee_id is not null && u.employee_id != ''\n"
					+ " 	    	&& ( u.name_en is null || u.name_en = '' )\n"
					+ " 	    	&& ( u.name is null || u.name = '' )\n" + " 	    	THEN u.employee_id\n"
					+ " 	    WHEN u.employee_id is not null && u.employee_id != ''\n"
					+ " 	    	&& u.name_en is not null && u.name_en != ''\n"
					+ " 	    	&& ( u.name is null || u.name = '' )\n"
					+ " 	    	THEN concat(u.employee_id, ' - ', u.name_en)\n"
					+ " 	    WHEN u.employee_id is not null && u.employee_id != ''\n"
					+ " 	    	&& ( u.name_en is null || u.name_en = '' )\n"
					+ " 	    	&& u.name is not null && u.name != ''\n"
					+ " 	    	THEN concat(u.employee_id, ' - ', u.name)\n"
					+ " 	    WHEN ( u.employee_id is null || u.employee_id = '' )\n"
					+ " 	    	&& u.name_en is not null && u.name_en != ''\n"
					+ " 	    	&& ( u.name is null || u.name = '' )\n" + " 	    	THEN u.name_en\n"
					+ " 	    WHEN ( u.employee_id is null || u.employee_id = '' )\n"
					+ " 	    	&& u.name_en is not null && u.name_en != ''\n"
					+ " 	    	&& u.name is not null && u.name != ''\n"
					+ " 	    	THEN concat(u.name_en, ' - ', u.name)\n"
					+ " 	    WHEN ( u.employee_id is null || u.employee_id = '' )\n"
					+ " 	    	&& ( u.name_en is null || u.name_en = '' )\n"
					+ " 	    	&& u.name is not null && u.name != ''\n" + " 	    	THEN u.name\n"
					+ " 	    ELSE u.id\n" + " 	END AS name_display,\n" + "	lv.leave_type_id,\n"
					+ "	lt.leave_type_name\n" + "FROM leaves lv\n"
					+ "INNER JOIN leave_type lt ON lv.leave_type_id = lt.leave_type_id\n"
					+ "INNER JOIN job_site_team jst ON lv.user_id = jst.user_id\n"
					+ "INNER JOIN user u ON lv.user_id = u.id\n" + "WHERE lv.start_date >= :dateStart\n"
					+ "AND lv.start_date < :dateEnd\n" + "AND lv.user_id in (\n"
					+ "	select jst.user_id from job_site_team jst where jst.id_sitejob = :idSiteJob\n" + ")";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("dateStart", dateStart);
			query.setParameter("dateEnd", dateEnd);
			query.setParameter("idSiteJob", idSiteJob);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			list = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Map<String, Object>> findUserLeaveByTypeAndStatus(Timestamp startDate, Timestamp endDate, String userId,
			String status, String type) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> leavelist = null;
		try {
			StringBuilder sql = new StringBuilder(
					"SELECT leaves.leave_id, leaves.user_id, user.name, leaves.leave_status_id, leave_type.leave_type_id, leave_type.leave_type_name, leaves.half_day, leaves.no_day, "
							+ "leaves.start_date, leaves.end_date, leaves.start_time, leaves.end_time, leaves.description, leaves.time_create, file.path "
							+ "FROM leaves LEFT JOIN leave_type ON leave_type.leave_type_id = leaves.leave_type_id "
							+ "LEFT JOIN user ON leaves.user_id = user.id "
							+ "LEFT JOIN file ON leaves.leave_file = file.file_id " + "WHERE leaves.user_id = :userId "
							+ "AND (leaves.start_date <= :endDate AND leaves.end_date >= :startDate) ");

			if (status != null && !status.isEmpty() && !status.equals("4")) {
				sql.append("AND leaves.leave_status_id = :status ");
			}

			if (type != null && !type.isEmpty() && !type.equals("allType")) {
				sql.append("AND leaves.leave_type_id = :leaveType ");
			}

			sql.append("ORDER BY leaves.leave_status_id ASC, leaves.start_date DESC ");

			SQLQuery query = session.createSQLQuery(sql.toString());
			query.setParameter("startDate", startDate);
			query.setParameter("endDate", endDate);
			query.setParameter("userId", userId);

			if (status != null && !status.isEmpty() && !status.equals("4")) {
				query.setParameter("status", status);
			}

			if (type != null && !type.isEmpty() && !type.equals("allType")) {
				query.setParameter("leaveType", type);
			}
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			leavelist = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return leavelist;
	}
	
	@Override
	public List<Map<String, Object>> findLeaveByUserAndDate(String userId, String date) throws Exception {

	    Session session = this.sessionFactory.getCurrentSession();
	    List<Map<String, Object>> result = null;

	    try {

	        String sql = "SELECT l.leave_id, l.leave_type_id, lt.leave_type_name, l.half_day, l.start_date, l.end_date, l.description, l.leave_status_id " +
	                     "FROM leaves l " +
	                     "LEFT JOIN leave_type lt ON l.leave_type_id = lt.leave_type_id " +
	                     "WHERE l.user_id = :userId " +
	                     "AND DATE(:date) BETWEEN DATE(l.start_date) AND DATE(l.end_date) " +
	                     "AND l.leave_status_id IN ('0','1') "+
	                     "ORDER BY l.time_create DESC " +
	                     "LIMIT 1";;

	        SQLQuery query = session.createSQLQuery(sql);

	        query.setParameter("userId", userId);
	        query.setParameter("date", date);

	        query.setResultTransformer(org.hibernate.transform.Transformers.ALIAS_TO_ENTITY_MAP);

	        result = query.list();

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return result;
	}

	@Override
	public List<Map<String, Object>> getSummaryLeave(String type, String userId, String manager, String status, Timestamp startDate,
			Timestamp endDate, String leaveType) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> summaryLeave = null;
		try {
			StringBuilder sql = new StringBuilder("SELECT leaves.leave_id, leaves.user_id, user.name, leaves.leave_status_id, leaves.leave_type_id, leave_type.leave_type_name, leaves.half_day, "
					+ "leaves.start_date, leaves.start_time, leaves.end_time, leaves.end_date, leaves.no_day , file.path, leaves.time_create, "
					+ "leaves.description FROM leaves LEFT JOIN leave_type ON leave_type.leave_type_id = leaves.leave_type_id "
					+ "LEFT JOIN user ON leaves.user_id = user.id LEFT JOIN file ON leaves.leave_file = file.file_id "
					+ "WHERE leaves.start_date BETWEEN :startDate AND :endDate ");
			if(userId != null && !userId.isEmpty()) {
				sql.append("AND leaves.user_id = :userId ");
			}
			if(manager != null && !manager.isEmpty() && "All2".equals(type)) {
				sql.append("AND leaves.appr_user_id = :manager ");
			}
			if (status != null && !status.isEmpty() && !status.equals("4")) {
				sql.append("AND leaves.leave_status_id = :status ");
			}
			if (leaveType != null && !leaveType.isEmpty() && !leaveType.equals("allType")) {
				sql.append("AND leaves.leave_type_id = :leaveType ");
			}
			sql.append("ORDER BY leaves.leave_status_id ASC, leaves.start_date DESC; ");
			SQLQuery query = session.createSQLQuery(sql.toString());
			query.setParameter("startDate", startDate);
			query.setParameter("endDate", endDate);
			if (userId != null && !userId.isEmpty()) {
				query.setParameter("userId", userId);
			}
			if (manager != null && !manager.isEmpty() && "All2".equals(type)) {
				query.setParameter("manager", manager);
			}
			if (status != null && !status.isEmpty() && !status.equals("4")) {
				query.setParameter("status", status);
			}
			if (leaveType != null && !leaveType.isEmpty() && !leaveType.equals("allType")) {
				query.setParameter("leaveType", leaveType);
			}
			System.out.println(query);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			summaryLeave = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return summaryLeave;
	}
	
}
