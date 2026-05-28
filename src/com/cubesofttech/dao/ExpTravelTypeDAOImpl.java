package com.cubesofttech.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Projections;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.ExpTravelType;

@Repository
public class ExpTravelTypeDAOImpl implements ExpTravelTypeDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public void save(ExpTravelType travelType) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.save(travelType);
		session.flush();
	}

	@Override
	public List<ExpTravelType> findAll() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<ExpTravelType> list = null;
		try {
			list = session.createCriteria(ExpTravelType.class).list();
		} catch (HibernateException e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public ExpTravelType findById(Long expTravelTypeId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		ExpTravelType obj = null;
		try {
			obj = (ExpTravelType) session.get(ExpTravelType.class, expTravelTypeId);
		} catch (HibernateException e) {
			e.printStackTrace();
		}
		return obj;
	}

	@Override
	public void update(ExpTravelType travelType) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.clear();
		session.update(travelType);
		session.flush();
	}

	@Override
	public void delete(ExpTravelType travelType) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.delete(travelType);
		session.flush();
	}

	@Override
	public Long getMaxId() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		try {
			Criteria criteria = session.createCriteria(ExpTravelType.class)
					.setProjection(Projections.max("expTravelTypeId"));
			Long maxId = (Long) criteria.uniqueResult();
			return (maxId == null) ? 0L : maxId;
		} catch (Exception e) {
			e.printStackTrace();
			return 0L;
		}
	}

	@Override
	public Map<Long, Integer> getCountUseType() throws Exception {

		Session session = this.sessionFactory.getCurrentSession();

		Map<Long, Integer> result = new HashMap<>();

		try {

			String sql = "SELECT " + "  et.exp_travel_type_id, "
					+ "    COALESCE(ed.cnt, 0) + COALESCE(e.cnt, 0) AS use_count " + "FROM exp_travel_type et " +

					"LEFT JOIN ( " + "    SELECT go_by, COUNT(*) AS cnt " + "    FROM expense_detail "
					+ "    GROUP BY go_by " + ") ed " + "ON et.exp_travel_type_id = ed.go_by " +

					"LEFT JOIN ( " + "    SELECT dt_by, COUNT(*) AS cnt " + "    FROM expense " + "    GROUP BY dt_by "
					+ ") e " + "ON et.exp_travel_type_id = e.dt_by";

			List<Object[]> rows = session.createSQLQuery(sql).list();

			for (Object[] row : rows) {

				Long typeId = ((Number) row[0]).longValue();
				Integer count = ((Number) row[1]).intValue();

				result.put(typeId, count);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public List<ExpTravelType> findAllActive() throws Exception {

		Session session = this.sessionFactory.getCurrentSession();

		List<ExpTravelType> list = null;

		try {

			String sql = "SELECT * FROM exp_travel_type WHERE active = '1'";

			list = session.createSQLQuery(sql).addEntity(ExpTravelType.class).list();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public boolean checkDuplicateName(String typeName) throws Exception {

		Session session = this.sessionFactory.getCurrentSession();

		String sql = "SELECT COUNT(*) " + "FROM exp_travel_type " + "WHERE LOWER(name) = :name";

		Number count = (Number) session.createSQLQuery(sql).setParameter("name", typeName.toLowerCase().trim())
				.uniqueResult();

		return count.intValue() > 0;
	}
}