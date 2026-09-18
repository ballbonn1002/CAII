package com.cubesofttech.dao;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Projections;
import org.hibernate.transform.AliasToEntityMapResultTransformer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.FileUpload;
import com.cubesofttech.model.PrDetail;
import com.cubesofttech.model.User;

@Repository
public class PrDetailDAOImpl implements PrDetailDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public List<PrDetail> findAll() throws Exception {
		Session session = sessionFactory.getCurrentSession();
		List<PrDetail> prDetail = null;
		try {
			prDetail = session.createCriteria(PrDetail.class).list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return prDetail;
	}
	@Override
	public void save(PrDetail PrDetail) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.save(PrDetail);
		session.flush();
		// session.close();
	}

	@Override
	public PrDetail findById(String prDetailId) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		PrDetail prDetail = null;
		try {
			prDetail = (PrDetail) session.get(PrDetail.class, prDetailId);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return prDetail;
		

	}
	
	@Override
	public Long getMaxId() throws Exception {
	    Session session = this.sessionFactory.getCurrentSession();
	    Long maxId = 0L;
	    try {
	        String sql = "SELECT MAX(CAST(pr_detail_id AS UNSIGNED)) FROM pr_detail";
	        SQLQuery query = session.createSQLQuery(sql);
	        Object result = query.uniqueResult();
	        if (result != null) {
	            maxId = ((Number) result).longValue();
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    }
	    return maxId;
	}
	
	@Override
	public void delete(PrDetail PrDetail) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.delete(PrDetail);
		session.flush();
		// session.close();
	}
	
	@Override
	public void update(PrDetail PrDetail) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.clear();
		session.update(PrDetail);
		session.flush();
		// session.close();
	}
	
	@Override
	public List<Map<String, Object>> findPrDetailByPrId(String prId) throws Exception {

	    List<Map<String, Object>> prDetailList = new ArrayList<>();

	    try {
	        Session session = sessionFactory.getCurrentSession();

	        String sql = "SELECT pr.*, " +
	                "  uc.name_en AS user_create_name, " +
	                "  uu.name_en AS user_update_name " +
	                "FROM pr_detail pr " +
	                "LEFT JOIN user uc ON pr.user_create = uc.id " +
	                "LEFT JOIN user uu ON pr.user_update = uu.id " +
	                "WHERE pr.pr_id = :prId";

	        SQLQuery query = session.createSQLQuery(sql);
	        query.setParameter("prId", prId);
	        query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

	        prDetailList = query.list();

	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    }

	    return prDetailList;
	}
	
	@Override
	public void deleteByPrIdAndPrDetailId(String prDetailId, String prId)  throws Exception {
	    Session session = this.sessionFactory.getCurrentSession();
	    try {
			String hql = "DELETE FROM PrDetail WHERE prDetailId = :prDetailId AND prId = :prId";
			Query query = session.createQuery(hql);
			query.setParameter("prDetailId", prDetailId);
			query.setParameter("prId", prId);
			query.executeUpdate();
			session.flush();
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    }
	}
	
	@Override
	public double getTotalByPrId(String prId) throws Exception {
	    // PR ไม่เก็บราคาสินค้าแล้ว (ตัด column price_total ออกจาก pr_detail) จึงไม่มียอดรวมให้คำนวณ
	    return 0d;
	}
	
	@Override
	public List<Map<String, Object>> findInprogressPrDetailForPrSearch() throws Exception {

		List<Map<String, Object>> list = new ArrayList<>();

		try {
			Session session = sessionFactory.getCurrentSession();

			String sql = "SELECT pd.pr_detail_id, pd.pr_id, pd.product_id, " +
					"  pd.amount_total, pd.unit, pd.description, " +
					"  pd.ref_link, " +
					"  pd.user_create, pd.time_create, " +
					"  p.status AS pr_status, " +
					"  pr_pd.product_name, pr_pd.product_type, " +
					"  uom.unit_name, " +
					"  uc.employee_id AS user_create_emp_id, " +
					"  uc.name_en AS user_create_name, " +
					"  uc.path AS user_create_path " +
					"FROM pr_detail pd " +
					"JOIN pr p ON pd.pr_id = p.pr_id " +
					"LEFT JOIN product pr_pd ON pd.product_id = pr_pd.product_id " +
					"LEFT JOIN unit_of_measure uom ON pd.unit = uom.unit_id " +
					"LEFT JOIN user uc ON pd.user_create = uc.id " +
					"WHERE p.status IN ('7') " +
					"AND pd.status = '0' " +
					"ORDER BY pd.time_create DESC";

			SQLQuery query = session.createSQLQuery(sql);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

			list = query.list();

		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

		return list;
	}

	@Override
	public void markPulled(List<String> prDetailIds) throws Exception {
		if (prDetailIds == null || prDetailIds.isEmpty()) return;
		Session session = sessionFactory.getCurrentSession();
		try {
			String hql = "UPDATE PrDetail SET status = '1' WHERE prDetailId IN (:ids)";
			Query query = session.createQuery(hql);
			query.setParameterList("ids", prDetailIds);
			query.executeUpdate();
			session.flush();
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void revertPulledStatusByPrProduct(String prId, String productId) throws Exception {
		if (prId == null || productId == null) return;
		Session session = sessionFactory.getCurrentSession();
		try {
			String hql = "UPDATE PrDetail SET status = '0' WHERE prId = :prId AND productId = :productId";
			Query query = session.createQuery(hql);
			query.setParameter("prId", prId);
			query.setParameter("productId", productId);
			query.executeUpdate();
			session.flush();
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public Map<String, Integer[]> countPrDetailProgressGroupByPr() throws Exception {
		try {
			Session session = sessionFactory.getCurrentSession();

			String sql = "SELECT pd.pr_id, " +
					"COUNT(*) AS total, " +
					"SUM(CASE WHEN pd.status = '1' THEN 1 ELSE 0 END) AS doneCount " +
					"FROM pr_detail pd " +
					"GROUP BY pd.pr_id";

			SQLQuery query = session.createSQLQuery(sql);
			List<Object[]> rows = query.list();

			Map<String, Integer[]> result = new HashMap<>();
			for (Object[] row : rows) {
				String prId = String.valueOf(row[0]);
				int total = ((Number) row[1]).intValue();
				int done = ((Number) row[2]).intValue();
				// index 0 = done, index 1 = total
				result.put(prId, new Integer[]{ done, total });
			}
			return result;

		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	

}