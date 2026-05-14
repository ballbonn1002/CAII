package com.cubesofttech.dao;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Projections;
import org.hibernate.transform.AliasToEntityMapResultTransformer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.Expense;
import com.cubesofttech.util.DateUtil;

@Repository
public class ExpenseDAOImpl implements ExpenseDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public void save(Expense expense) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.save(expense);
		session.flush();
	}

	@Override
	public List<Expense> findAll() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Expense> list = null;
		try {
			list = session.createCriteria(Expense.class).list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Expense findById(Long expenseId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		Expense expense = null;
		try {
			expense = (Expense) session.get(Expense.class, expenseId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return expense;
	}

	@Override
	public void update(Expense expense) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.clear();
		session.update(expense);
		session.flush();
	}

	@Override
	public void delete(Expense expense) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.delete(expense);
		session.flush();
	}

	@Override
	public Long getMaxId() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		Long maxId = 0L;
		try {
			Criteria criteria = session.createCriteria(Expense.class).setProjection(Projections.max("expenseId"));
			Object r = criteria.uniqueResult();
			if (r != null)
				maxId = (Long) r;
		} catch (Exception e) {
			e.printStackTrace();
			return 0L;
		}
		return maxId == null ? 0L : maxId;
	}

	@Override
	public List<Expense> findByGroupId(Long expenseGroupId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Expense> list = null;
		try {
			String hql = "from Expense where expense_group_id = :gid order by date(dt_start), expense_id";
			org.hibernate.Query q = session.createQuery(hql);
			q.setParameter("gid", expenseGroupId);
			list = q.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Expense> findByUserId(String userId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Expense> list = null;
		try {
			String hql = "from Expense where userId = :uid order by expenseId desc";
			org.hibernate.Query q = session.createQuery(hql);
			q.setParameter("uid", userId);
			list = q.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Expense> findByExpTypeId(String expTypeId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Expense> list = null;
		try {
			String hql = "from Expense where expTypeId = :tid order by expenseId desc";
			org.hibernate.Query q = session.createQuery(hql);
			q.setParameter("tid", expTypeId);
			list = q.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// ===================== LIST ตาม Status + pagination =====================
	@Override
	public List<Map<String, Object>> findMyTravelListByStatus(String statusId, String userId, java.sql.Date dateFrom,
			java.sql.Date dateTo, int offset, int limit) throws Exception {

		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> list = null;

		try {
			String sql = " SELECT " + "   e.expense_id         AS expense_id, "
					+ "   e.expense_group_id   AS expense_group_id, " + "   e.amount             AS amount, "
					+ "   e.dt_start           AS dt_start, " + "   eg.status_id         AS status_id, "
					+ "   u.employee_id        AS employee_id, " + "   u.name               AS user_name, "
					+ "   u.name_en            AS user_name_en, " + "   tt.name              AS travel_type_name "
					+ " FROM expense e " + " LEFT JOIN expense_group eg ON eg.expense_group_id = e.expense_group_id "
					+ " LEFT JOIN user u ON u.id = eg.user_id "
					+ " LEFT JOIN exp_travel_type tt ON tt.exp_travel_type_id = e.dt_by "
					+ " WHERE eg.status_id = :sid " + "   AND (:uid IS NULL OR eg.user_id = :uid) "
					+ "   AND (:dfrom IS NULL OR DATE(e.dt_start) >= :dfrom) "
					+ "   AND (:dto IS NULL OR DATE(e.dt_start) <= :dto) "
					+ " ORDER BY eg.time_create DESC, e.expense_id DESC " + " LIMIT :limit OFFSET :offset ";

			SQLQuery q = session.createSQLQuery(sql);
			q.setParameter("sid", statusId);
			q.setParameter("uid", userId);
			q.setParameter("dfrom", dateFrom);
			q.setParameter("dto", dateTo);
			q.setParameter("limit", limit);
			q.setParameter("offset", offset);

			q.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			list = q.list();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public int countMyTravelListByStatus(String statusId, String userId, java.sql.Date dateFrom, java.sql.Date dateTo)
			throws Exception {

		Session session = this.sessionFactory.getCurrentSession();
		int total = 0;

		try {
			String sql = " SELECT COUNT(*) " + " FROM expense e "
					+ " JOIN expense_group eg ON eg.expense_group_id = e.expense_group_id "
					+ " WHERE eg.status_id = :sid " + "   AND (:uid IS NULL OR eg.user_id = :uid) "
					+ "   AND (:dfrom IS NULL OR DATE(e.dt_start) >= :dfrom) "
					+ "   AND (:dto IS NULL OR DATE(e.dt_start) <= :dto) ";

			SQLQuery q = session.createSQLQuery(sql);
			q.setParameter("sid", statusId);
			q.setParameter("uid", userId);
			q.setParameter("dfrom", dateFrom);
			q.setParameter("dto", dateTo);

			Number n = (Number) q.uniqueResult();
			total = (n != null ? n.intValue() : 0);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return total;
	}

	@Override
	public Map<String, Integer> countMyTravelListAllStatus(String userId, java.sql.Date dateFrom, java.sql.Date dateTo)
			throws Exception {

		Session session = this.sessionFactory.getCurrentSession();
		Map<String, Integer> result = new HashMap<>();

		try {

			String sql = "SELECT eg.status_id, COUNT(*) as total_count" + " From expense_group eg "
					+ " WHERE (:uid IS NULL OR eg.user_id = :uid) "
					+ " AND (:dfrom IS NULL OR DATE(eg.time_create) >= :dfrom) "
					+ " AND (:dto IS NULL OR DATE(eg.time_create) <= :dto) " + " GROUP BY eg.status_id ";

			SQLQuery q = session.createSQLQuery(sql);

			if (!"all".equals(userId)) {
				q.setParameter("uid", userId);
			} else {
				q.setParameter("uid", null);
			}

			q.setParameter("dfrom", dateFrom);
			q.setParameter("dto", dateTo);

			// ดึงผลลัพธ์เป็น List ของ Object[] (Index 0 = status_id, Index 1 = count)
			List<Object[]> list = q.list();

			for (Object[] row : list) {
				String status = (String) row[0];
				Number count = (Number) row[1];
				result.put(status, count != null ? count.intValue() : 0);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	// ===================== Draft: expense ที่ expense_group_id = 0
	// =====================

	/**
	 * นับ expense Draft ของ user Draft = expense_group_id = 0 (ยังไม่ submit เข้า
	 * group) เฉพาะ exp_type_id = 'T'
	 */
	@Override
	public int countMyTravelDraftNoGroup(String userId, java.sql.Date dateFrom, java.sql.Date dateTo) throws Exception {

		Session session = this.sessionFactory.getCurrentSession();
		int total = 0;

		try {
			String sql = " SELECT COUNT(*) " + " FROM expense e " + " WHERE e.exp_type_id = 'T' "
					+ "   AND e.expense_group_id = 0 " + " AND e.user_id = :uid "
					+ "   AND (:dfrom IS NULL OR DATE(e.dt_start) >= :dfrom) "
					+ "   AND (:dto   IS NULL OR DATE(e.dt_start) <= :dto) ";

			SQLQuery q = session.createSQLQuery(sql);
			q.setParameter("uid", userId);
			q.setParameter("dfrom", dateFrom);
			q.setParameter("dto", dateTo);

			Number n = (Number) q.uniqueResult();
			total = (n != null ? n.intValue() : 0);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return total;
	}

	/**
	 * ดึงรายการ expense Draft ของ user Draft = expense_group_id = 0 (ยังไม่ submit
	 * เข้า group) เฉพาะ exp_type_id = 'T' พร้อม pagination
	 */
	@Override
	public List<Map<String, Object>> findMyTravelDraftNoGroup(String userId, java.sql.Date dateFrom,
			java.sql.Date dateTo, int offset, int limit) throws Exception {

		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> list = null;

		try {
			String sql = " SELECT " + "   e.expense_id     AS expense_id, " + "   e.amount         AS amount, "
					+ "   e.dt_start       AS dt_start, " + "   e.dt_end         AS dt_end, "
					+ "   e.user_id        AS user_id, " + "   e.from_location  AS from_location, "
					+ "   e.to_location    AS to_location, " + "   e.description    AS description, "
					+ "   e.time_create    AS time_create, " + "   u.employee_id    AS employee_id, "
					+ "   u.name           AS user_name, " + "   u.name_en        AS user_name_en, "
					+ "   tt.name          AS travel_type_name " + " FROM expense e "
					+ " LEFT JOIN user u             ON u.id                  = e.user_id "
					+ " LEFT JOIN exp_travel_type tt ON tt.exp_travel_type_id = e.dt_by "
					+ " WHERE e.exp_type_id      = 'T' " + "   AND e.expense_group_id = 0 "
					+ "   AND e.user_id          = :uid " + "   AND (:dfrom IS NULL OR DATE(e.dt_start) >= :dfrom) "
					+ "   AND (:dto   IS NULL OR DATE(e.dt_start) <= :dto) "
					+ " ORDER BY e.time_create DESC, e.expense_id DESC " + " LIMIT :limit OFFSET :offset ";

			SQLQuery q = session.createSQLQuery(sql);
			q.setParameter("uid", userId);
			q.setParameter("dfrom", dateFrom);
			q.setParameter("dto", dateTo);
			q.setParameter("limit", limit);
			q.setParameter("offset", offset);

			q.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			list = q.list();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	// ===================== Submit (เดิม: รับ groupIds) =====================
	@Override
	public int updateGroupStatusToWaiting(List<Long> groupIds, String userUpdate) throws Exception {
		if (groupIds == null || groupIds.isEmpty())
			return 0;

		Session session = this.sessionFactory.getCurrentSession();
		int updated = 0;

		try {
			Timestamp now = DateUtil.getCurrentTime();

			String sql = " UPDATE expense_group " + " SET status_id = 'W', user_update = :uu, time_update = :tu "
					+ " WHERE expense_group_id IN (:ids) " + "   AND status_id = 'P' ";

			SQLQuery q = session.createSQLQuery(sql);
			q.setParameter("uu", userUpdate);
			q.setParameter("tu", now);
			q.setParameterList("ids", groupIds);

			updated = q.executeUpdate();
			session.flush();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return updated;
	}

	// ===================== Submit ใหม่: รับ expenseIds =====================
	@Override
	public int updateGroupStatusToWaitingByExpenseIds(List<Long> expenseIds, String userUpdate) throws Exception {
		if (expenseIds == null || expenseIds.isEmpty())
			return 0;

		Session session = this.sessionFactory.getCurrentSession();
		int updated = 0;

		try {
			Timestamp now = DateUtil.getCurrentTime();

			String sql = " UPDATE expense_group eg "
					+ " SET eg.status_id = 'W', eg.user_update = :uu, eg.time_update = :tu "
					+ " WHERE eg.status_id = 'P' " + "   AND eg.expense_group_id IN ( "
					+ "       SELECT DISTINCT e.expense_group_id " + "       FROM expense e "
					+ "       WHERE e.expense_id IN (:expIds) " + "   ) ";

			SQLQuery q = session.createSQLQuery(sql);
			q.setParameter("uu", userUpdate);
			q.setParameter("tu", now);
			q.setParameterList("expIds", expenseIds);

			updated = q.executeUpdate();
			session.flush();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return updated;
	}

	// ===================== Modal data (by group) =====================
	@Override
	@SuppressWarnings("unchecked")
	public Map<String, Object> getTravelModalData(Long expenseGroupId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		Map<String, Object> result = new HashMap<>();

		try {
			String sqlGroup = " SELECT "
					+ "   eg.expense_group_id, eg.exp_type_id, eg.total_amount, eg.status_id, eg.user_id, eg.time_create, eg.time_update, "
					+ "   u.employee_id, u.name AS user_name, u.name_en AS user_name_en, "
					+ "   t.name AS exp_type_name " + " FROM expense_group eg "
					+ " LEFT JOIN user u ON eg.user_id = u.id "
					+ " LEFT JOIN exp_type t ON eg.exp_type_id = t.exp_type_id " + " WHERE eg.expense_group_id = :gid "
					+ " LIMIT 1 ";

			SQLQuery q1 = session.createSQLQuery(sqlGroup);
			q1.setParameter("gid", expenseGroupId);
			q1.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			Map<String, Object> group = (Map<String, Object>) q1.uniqueResult();

			String sqlItems = " SELECT " + "   e.expense_id, e.dt_start, e.dt_end, e.dt_by, "
					+ "   tt.name AS travel_type_name, " + "   e.from_location, e.to_location, e.amount, e.description "
					+ " FROM expense e " + " LEFT JOIN exp_travel_type tt ON tt.exp_travel_type_id = e.dt_by "
					+ " WHERE e.expense_group_id = :gid " + " ORDER BY e.expense_id ASC ";

			SQLQuery q2 = session.createSQLQuery(sqlItems);
			q2.setParameter("gid", expenseGroupId);
			q2.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

			List<Map<String, Object>> items = q2.list();

			result.put("group", group);
			result.put("items", items);

		} catch (HibernateException e) {
			e.printStackTrace();
			result.put("group", null);
			result.put("items", java.util.Collections.emptyList());
		}

		return result;
	}

	// ===================== Modal ใหม่: by expense_id =====================
	@Override
	@SuppressWarnings("unchecked")
	public Map<String, Object> getTravelExpenseModalData(Long expenseId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		Map<String, Object> result = new HashMap<>();

		try {
			String sqlExpense = " SELECT "
					+ "   e.expense_id, e.expense_group_id, e.amount, e.dt_start, e.dt_end, e.dt_by, "
					+ "   e.from_location, e.to_location, e.description, " + "   tt.name AS travel_type_name, "
					+ "   eg.status_id AS status_id, eg.time_create AS group_time_create, "
					+ "   u.employee_id AS employee_id, u.name AS user_name, u.name_en AS user_name_en "
					+ " FROM expense e " + " LEFT JOIN expense_group eg ON eg.expense_group_id = e.expense_group_id "
					+ " LEFT JOIN user u ON u.id = eg.user_id "
					+ " LEFT JOIN exp_travel_type tt ON tt.exp_travel_type_id = e.dt_by "
					+ " WHERE e.expense_id = :eid " + " LIMIT 1 ";

			SQLQuery q1 = session.createSQLQuery(sqlExpense);
			q1.setParameter("eid", expenseId);
			q1.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

			Map<String, Object> expense = (Map<String, Object>) q1.uniqueResult();

			if (expense == null) {
				result.put("expense", null);
				result.put("group", null);
				return result;
			}

			String sqlGroup = " SELECT "
					+ "   eg.expense_group_id, eg.exp_type_id, eg.total_amount, eg.status_id, eg.user_id, eg.time_create, eg.time_update, "
					+ "   u.employee_id, u.name AS user_name, u.name_en AS user_name_en, "
					+ "   t.name AS exp_type_name " + " FROM expense_group eg "
					+ " LEFT JOIN user u ON eg.user_id = u.id "
					+ " LEFT JOIN exp_type t ON eg.exp_type_id = t.exp_type_id " + " WHERE eg.expense_group_id = :gid "
					+ " LIMIT 1 ";

			SQLQuery q2 = session.createSQLQuery(sqlGroup);
			q2.setParameter("gid", expense.get("expense_group_id"));
			q2.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

			Map<String, Object> group = (Map<String, Object>) q2.uniqueResult();

			result.put("expense", expense);
			result.put("group", group);

		} catch (Exception e) {
			e.printStackTrace();
			result.put("expense", null);
			result.put("group", null);
		}

		return result;
	}

	@Override
	public List<Map<String, Object>> findSubmitPreviewByExpenseIds(List<Long> expenseIds) throws Exception {
		if (expenseIds == null || expenseIds.isEmpty())
			return new ArrayList<>();

		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> list = null;

		try {
			String sql = " SELECT " + "   e.expense_id        AS expense_id, "
					+ "   e.expense_group_id  AS expense_group_id, " + "   e.dt_start          AS dt_start, "
					+ "   e.dt_end            AS dt_end, " + "   e.from_location     AS from_location, "
					+ "   e.to_location       AS to_location, " + "   e.description       AS description, "
					+ "   e.amount            AS amount, " + "   eg.status_id        AS status_id, "
					+ "   eg.time_create      AS time_create, " + "   eg.user_id          AS user_id, "
					+ "   u.employee_id       AS employee_id, " + "   u.name              AS user_name, "
					+ "   u.name_en           AS user_name_en, " + "   u.department        AS department, "
					+ "   u.signature         AS signature " + " FROM expense e "
					+ " LEFT JOIN expense_group eg ON eg.expense_group_id = e.expense_group_id "
					+ " LEFT JOIN user u ON u.id = eg.user_id " + " WHERE e.expense_id IN (:ids) "
					+ " ORDER BY e.expense_id ASC ";

			SQLQuery q = session.createSQLQuery(sql);
			q.setParameterList("ids", expenseIds);
			q.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			list = q.list();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
}
