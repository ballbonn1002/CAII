package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.transform.AliasToEntityMapResultTransformer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.LeaveType;
import com.google.gson.Gson;

@Repository
public class LeaveTypeDAOImpl implements LeaveTypeDAO {

	@Autowired
	private SessionFactory sessionFactory;
	private static final Logger log = Logger.getLogger(LeaveTypeDAOImpl.class);

	@Override
	public void save(LeaveType leavetype) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.save(leavetype);
		session.flush();
		// session.close();
	}

	@Override
	public List<LeaveType> findAll() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<LeaveType> leavetypeList = null;
		try {
			leavetypeList = session.createCriteria(LeaveType.class).list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return leavetypeList;
	}

	public List<LeaveType> findAll_calendar() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<LeaveType> leavetypeList = null;
		try {
			String sql = " SELECT * FROM leave_type WHERE leave_type_id ;";
			SQLQuery query = session.createSQLQuery(sql);
			// query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			query.addEntity(LeaveType.class);

			leavetypeList = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return leavetypeList;
	}

	@Override
	public List<LeaveType> findAll2() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<LeaveType> leaveList = null;
		try {
			// String sql = " SELECT * FROM leave_type ";
			String sql = "SELECT * FROM leave_type";
			SQLQuery query = session.createSQLQuery(sql);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			leaveList = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return leaveList;

	}

	@Override
	public List<Map<String, Object>> findAllList() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> leaveList = null;
		try {
			// String sql = " SELECT * FROM leave_type ";
			String sql = "SELECT * FROM leave_type ORDER BY leave_type_id ASC";
			SQLQuery query = session.createSQLQuery(sql);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			leaveList = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return leaveList;

	}

	@Override
	public List<LeaveType> findByLeaveTypeId(String leave_type_id) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<LeaveType> leavetype = null;
		try {
			leavetype = (List<LeaveType>) session.get(LeaveType.class, leave_type_id);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return leavetype;
	}

	@Override
	public void update(LeaveType leavetype) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.clear();
		session.update(leavetype);
		session.flush();
		// session.close();
	}

	@Override
	public void delete(LeaveType leavetype) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.delete(leavetype);
		session.flush();
		// session.close();
	}

	@Override
	public List<LeaveType> searchtable(String user) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<LeaveType> LeaveType = null;
		try {
			String sql = "SELECT * FROM leave_type WHERE user_update LIKE '%" + user + "%' order by user_update ASC; ";

			SQLQuery query = session.createSQLQuery(sql);
			/* query.addEntity(LeaveType.class); */
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			/*
			 * String sql ="SELECT * FROM leave_type";
			 * 
			 * query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			 */
			LeaveType = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}
		return LeaveType;

	}

	@Override
	public List<Object> searchalluser() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Object> leavetypelist = null;
		try {

			String sql = "  SELECT  distinct (user_update) FROM leave_type  order by (user_update) ";

			SQLQuery query = session.createSQLQuery(sql);
			leavetypelist = query.list();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return leavetypelist;
	}

	@Override
	public LeaveType findById(String leave_type_id) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		LeaveType leavetype = (LeaveType) session.get(LeaveType.class, leave_type_id);
		return leavetype;
	}

	@Override
	public List<LeaveType> findByLeaveTypeId2(String leave_type_id) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<LeaveType> leavetype = null;
		try {
			String sql = "SELECT * FROM leave_type WHERE leave_type_id LIKE '%" + leave_type_id
					+ "%' order by leave_type_id ASC; ";
			SQLQuery query = session.createSQLQuery(sql);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			leavetype = query.list();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return leavetype;
	}

//new
	@Override
	public List<Map<String, Object>> findById2(String keyword) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> leaveType = null;
		try {
			String sql = " SELECT leave_type_id FROM leave_type WHERE leave_type_id = :keyword ";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("keyword", keyword);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			leaveType = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return leaveType;

	}

	@Override
	public List<Map<String, Object>> findByName(String keyword) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> leaveType = null;
		try {
			String sql = " SELECT leave_type_name FROM leave_type WHERE leave_type_name = :keyword ";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("keyword", keyword);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			leaveType = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return leaveType;
	}

	@Override
	public String getForDisplayJSON() {
		Session session = this.sessionFactory.getCurrentSession();
		String result = null;
		List<Map<String, String>> list = null;
		try {
			String hql = "select new map(l.leaveTypeId as id, l.leaveTypeName as name) FROM LeaveType l ORDER BY id ASC";
			list = session.createQuery(hql).list();
			result = new Gson().toJson(list);
		} catch (HibernateException e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Map<String, Object>> idtoname(String keyword) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> leaveType = null;
		try {
			String sql = " SELECT * FROM leave_type WHERE leave_type_id = :keyword ";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("keyword", keyword);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			leaveType = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return leaveType;

	}
}
