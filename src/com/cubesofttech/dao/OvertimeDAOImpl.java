package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.transform.AliasToEntityMapResultTransformer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.Overtime;

@Repository
public class OvertimeDAOImpl implements OvertimeDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public void save(Overtime overtime) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.save(overtime);
		session.flush();
	}

	@Override
	public void update(Overtime overtime) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.update(overtime);
		session.flush();
	}

	@Override
	public Overtime findById(Integer id) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		Overtime overtime = (Overtime) session.get(Overtime.class, id);
		return overtime;
	}

	@Override
	public List<Map<String, Object>> findAll() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();

		String sql = " SELECT ot.*, s.description AS description, s.color " + " FROM overtime ot "
				+ " LEFT JOIN overtime_status s ON ot.status = s.status " + " ORDER BY ot.ot_id ASC ";

		SQLQuery query = session.createSQLQuery(sql);
		query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

		@SuppressWarnings("unchecked")
		List<Map<String, Object>> list = query.list();
		return list;
	}

	@Override
	public List<Map<String, Object>> findByCriteria(String userId, String status, String dateRange) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();

		String sql = " SELECT ot.*, s.description AS status_name, s.color AS status_color, "
				+ "        appr.employee_id AS approver_employee_id, "
				+ "        CASE WHEN (appr.name_en IS NOT NULL AND appr.name_en != '') "
				+ "             THEN appr.name_en ELSE appr.name END AS approver_name, "
				+ "        ot.approved_at AS approve_time " + " FROM overtime ot "
				+ " LEFT JOIN overtime_status s ON ot.status = s.status "
				+ " LEFT JOIN user appr ON appr.id = ot.appr_user_id " + " WHERE 1=1 ";

		if (userId != null && !userId.isEmpty()) {
			sql += " AND ot.user_id = :userId ";
		}

		if (status != null && !status.isEmpty() && !"all".equals(status)) {
			sql += " AND ot.status = :status ";
		}

		String startDate = "";
		String endDate = "";
		if (dateRange != null && dateRange.contains(" - ")) {
			String[] dates = dateRange.split(" - ");
			startDate = dates[0];
			endDate = dates[1];
			sql += " AND ot.ot_date BETWEEN :startDate AND :endDate ";
		}

		sql += " ORDER BY ot.ot_id ASC";

		SQLQuery query = session.createSQLQuery(sql);

		if (userId != null && !userId.isEmpty()) {
			query.setParameter("userId", userId);
		}
		if (status != null && !status.isEmpty() && !"all".equals(status)) {
			query.setParameter("status", status);
		}
		if (!startDate.isEmpty() && !endDate.isEmpty()) {
			query.setParameter("startDate", startDate);
			query.setParameter("endDate", endDate);
		}

		query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

		@SuppressWarnings("unchecked")
		List<Map<String, Object>> list = query.list();
		return list;
	}

	@Override
	public void delete(Overtime overtime) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.delete(overtime);
		session.flush();
	}

	@Override
	public List<Map<String, Object>> findOvertimeStatusAll() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		String sql = " SELECT * FROM overtime_status ORDER BY status ";

		SQLQuery query = session.createSQLQuery(sql);
		query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

		@SuppressWarnings("unchecked")
		List<Map<String, Object>> list = query.list();
		return list;
	}

	@Override
	public List<Map<String, Object>> getOvertimeByUserId(String userId) throws Exception {
		return findByCriteria(userId, null, null);
	}

}