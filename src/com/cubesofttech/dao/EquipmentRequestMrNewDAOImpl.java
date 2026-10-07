package com.cubesofttech.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.transform.AliasToEntityMapResultTransformer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.EquipmentRequestMr;
import com.cubesofttech.model.Po;

@Repository
public class EquipmentRequestMrNewDAOImpl implements EquipmentRequestMrNewDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public List<Map<String, Object>> findMyMrList(String userCreate) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		List<Map<String, Object>> mrList = null;
		try {
			String sql =
				"SELECT mr.*, " +
				" pd.product_no AS product_no, " +
				" pd.product_name AS product_name, " +
				" CASE WHEN pd.parent_product_id IS NULL OR pd.parent_product_id = '0' " +
				" THEN NULL ELSE pm.product_name END AS parent_product_name, " +
				" pm.product_type AS product_type, " +
				" (SELECT u.unit_name FROM unit_of_measure u " +
				"   WHERE u.product_id = pm.product_id " +
				"   ORDER BY u.conversion_rate ASC LIMIT 1) AS unit_name, " +
				" uc.name_en AS user_create_name, " +
				" ds.status_code AS status_code, " +
				" ds.status_name AS status_name, " +
				" ds.color AS status_color " +
				"FROM mr mr " +
				"LEFT JOIN product pd ON pd.product_id = mr.product_id " +
				"LEFT JOIN product pm ON pm.product_id = CASE " +
				"   WHEN pd.parent_product_id IS NULL OR pd.parent_product_id = '0' THEN pd.product_id " +
				"   ELSE pd.parent_product_id END " +
				"LEFT JOIN user uc ON uc.id = mr.user_create " +
				"LEFT JOIN doc_status ds ON ds.status_code = mr.status_id AND ds.page = 'mr' " +
				"WHERE mr.user_create = :userCreate " +
				"ORDER BY mr.time_create DESC";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("userCreate", userCreate);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			mrList = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mrList;
	}

	@Override
	public List<Map<String, Object>> findAllMrList() throws Exception {
		Session session = sessionFactory.getCurrentSession();
		List<Map<String, Object>> mrList = null;
		try {
			String sql =
				"SELECT mr.*, " +
				" pd.product_no AS product_no, " +
				" pd.product_name AS product_name, " +
				" CASE WHEN pd.parent_product_id IS NULL OR pd.parent_product_id = '0' " +
				" THEN NULL ELSE pm.product_name END AS parent_product_name, " +
				" pm.product_type AS product_type, " +
				" (SELECT u.unit_name FROM unit_of_measure u " +
				"   WHERE u.product_id = pm.product_id " +
				"   ORDER BY u.conversion_rate ASC LIMIT 1) AS unit_name, " +
				" uc.name_en AS user_create_name, " +
				" ds.status_code AS status_code, " +
				" ds.status_name AS status_name, " +
				" ds.color AS status_color " +
				"FROM mr mr " +
				"LEFT JOIN product pd ON pd.product_id = mr.product_id " +
				"LEFT JOIN product pm ON pm.product_id = CASE " +
				"   WHEN pd.parent_product_id IS NULL OR pd.parent_product_id = '0' THEN pd.product_id " +
				"   ELSE pd.parent_product_id END " +
				"LEFT JOIN user uc ON uc.id = mr.user_create " +
				"LEFT JOIN doc_status ds ON ds.status_code = mr.status_id AND ds.page = 'mr' " +
				"ORDER BY mr.time_create DESC";

			SQLQuery query = session.createSQLQuery(sql);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			mrList = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mrList;
	}

	@Override
	public List<Map<String, Object>> findMainItems() throws Exception {
		Session session = sessionFactory.getCurrentSession();
		List<Map<String, Object>> list = null;
		try {
			String sql =
				"SELECT p.product_id, p.product_no, p.product_name, p.product_type " +
				"FROM product p " +
				"WHERE p.parent_product_id = '0' AND p.active = '1' " +
				"ORDER BY p.product_name";

			SQLQuery query = session.createSQLQuery(sql);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			list = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Map<String, Object>> findSubItems(String parentProductId) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		List<Map<String, Object>> list = null;
		try {
			String sql =
				"SELECT p.product_id, p.product_no, p.product_name, p.sequence " +
				"FROM product p " +
				"WHERE p.parent_product_id = :parentProductId AND p.sub_product_active = '1' " +
				"ORDER BY p.sequence ASC, p.product_name";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("parentProductId", parentProductId);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			list = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// หน่วยเล็กสุด (conversion_rate น้อยสุด) ของ product
	@Override
	public String findSmallestUnitName(String productId) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		String unitName = null;
		try {
			String sql =
				"SELECT u.unit_name FROM unit_of_measure u " +
				"WHERE u.product_id = :productId " +
				"ORDER BY u.conversion_rate ASC " +
				"LIMIT 1";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("productId", productId);
			Object result = query.uniqueResult();
			if (result != null) {
				unitName = result.toString();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return unitName;
	}

	@Override
	public String findMaxMrIdByPrefix(String prefix) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		String maxMrId = null;
		try {
			String sql = "SELECT MAX(mr_id) FROM mr WHERE mr_id LIKE :prefix";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("prefix", prefix);
			Object result = query.uniqueResult();
			if (result != null) {
				maxMrId = result.toString();
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return maxMrId;
	}

	@Override
	public void save(EquipmentRequestMr mr) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.save(mr);
		session.flush();
	}

	@Override
	public EquipmentRequestMr findMrById(String mrId) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		EquipmentRequestMr mr = null;
		try {
			mr = (EquipmentRequestMr) session.get(EquipmentRequestMr.class, mrId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mr;
	}

	@Override
	public void update(EquipmentRequestMr mr) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.update(mr);
		session.flush();
	}

	@Override
	public Integer deleteById(String mrId, String cancelStatusCode, String userUpdate) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		String sql = "UPDATE mr SET status_id = :statusId, user_update = :userUpdate, time_update = :timeUpdate " +
				"WHERE mr_id = :mrId";
		SQLQuery query = session.createSQLQuery(sql);
		query.setParameter("statusId", cancelStatusCode);
		query.setParameter("userUpdate", userUpdate);
		query.setParameter("timeUpdate", com.cubesofttech.util.DateUtil.getCurrentTime());
		query.setParameter("mrId", mrId);
		int rows = query.executeUpdate();
		session.flush();
		return rows;
	}

	@Override
	public List<Map<String, Object>> findApprovedMrForMrSearch() throws Exception {

		List<Map<String, Object>> list = new ArrayList<>();

		try {
			Session session = sessionFactory.getCurrentSession();

			String sql = "SELECT mr.mr_id, mr.product_id, mr.parent_id, " +
				"  mr.amount AS amount_total, mr.description, mr.url_ref AS ref_link, " +
				"  mr.status_id AS mr_status, " +
				"  mr.request_user, mr.request_date, mr.time_create, " +
				"  COALESCE(mr.time_update, mr.time_create) AS time_sort, " +
				"  pd.product_name, pp.product_name AS parent_product_name, " +
				"  COALESCE(pp.product_type, pd.product_type) AS product_type, " +
				"  ur.employee_id AS user_create_emp_id, " +
				"  ur.name_en AS user_create_name, " +
				"  ur.path AS user_create_path " +
				"FROM mr mr " +
				"LEFT JOIN product pd ON pd.product_id = mr.product_id " +
				"LEFT JOIN product pp ON pp.product_id = mr.parent_id " +
				"LEFT JOIN user ur ON ur.id = mr.request_user " +
				"WHERE mr.status_id = '3' " +
				"AND NOT EXISTS (" +
				"  SELECT 1 FROM pr_parent x " +
				"  JOIN pr_detail xd ON xd.pr_detail_id = x.pr_detail_id " +
				"  JOIN pr xp ON xp.pr_id = xd.pr_id " +
				"  WHERE x.mr_id = mr.mr_id " +
				"  AND xp.status NOT IN ('5','6')" +
				") " +
				"ORDER BY COALESCE(mr.request_date, mr.time_create) DESC";

			SQLQuery query = session.createSQLQuery(sql);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

			list = query.list();

		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

		return list;
	}


}
