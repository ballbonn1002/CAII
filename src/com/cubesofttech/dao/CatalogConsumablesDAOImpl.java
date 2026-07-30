package com.cubesofttech.dao;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
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

import com.cubesofttech.model.CatalogConsumables;
import com.cubesofttech.model.FileUpload;

import com.cubesofttech.model.User;

@Repository
public class CatalogConsumablesDAOImpl implements CatalogConsumablesDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public List<CatalogConsumables> findAll() throws Exception {
		Session session = sessionFactory.getCurrentSession();
		List<CatalogConsumables> catalogConsumables = null;
		try {
			catalogConsumables = session.createCriteria(CatalogConsumables.class).list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return catalogConsumables;
	}
	@Override
	public void save(CatalogConsumables CatalogConsumables) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.save(CatalogConsumables);
		session.flush();
		// session.close();
	}

	@Override
	public CatalogConsumables findById(Long catalogConsumablesId) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		CatalogConsumables catalogConsumables = null;
		try {
			catalogConsumables = (CatalogConsumables) session.get(CatalogConsumables.class, catalogConsumablesId);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return catalogConsumables;
		

	}
	
	@Override
	public Long getMaxId() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		Long maxId = 0L;
		try {

			Criteria criteria = session.createCriteria(CatalogConsumables.class).setProjection(Projections.max("catalogConsumablesId"));
			maxId = (Long) criteria.uniqueResult();

		} catch (Exception e) {
			e.printStackTrace();
			maxId = new Long(0);

		} finally {

		}
		if (maxId != null) {
			return maxId;
		} else {
			return new Long(0);
		}
	}
	
	@Override
	public void delete(CatalogConsumables CatalogConsumables) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.delete(CatalogConsumables);
		session.flush();
		// session.close();
	}
	
	@Override
	public void update(CatalogConsumables CatalogConsumables) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.clear();
		session.update(CatalogConsumables);
		session.flush();
		// session.close();
	}
	
	@Override
	public List<Map<String, Object>> findConsAllWithProduct() throws Exception {
		Session session = sessionFactory.getCurrentSession();
	    List<Map<String, Object>> result = null;
		try {
			String sql = "SELECT cc.catalog_consumables_id, cc.product_id, cc.active, "
					+ "    p.product_name AS catalog_consumables_name, cc.sub_product_active, "
					+ "    GROUP_CONCAT( sp.product_name ORDER BY sp.sequence ASC SEPARATOR ',' ) "
					+ "    AS sub_product_names "
					+ "FROM catalog_consumables cc "
					+ "INNER JOIN product p "
					+ "    ON cc.product_id = p.product_id "
					+ "LEFT JOIN product sp "
					+ "    ON sp.parent_product_id = p.product_id "
					+ "WHERE cc.parent_product_id = 0 "
					+ "GROUP BY "
					+ "    cc.catalog_consumables_id, "
					+ "    cc.product_id, "
					+ "    p.product_name, "
					+ "    cc.active, "
					+ "    cc.sub_product_active "
					+ "ORDER BY p.sequence ASC;";
			
			SQLQuery query = session.createSQLQuery(sql);
	        query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

	        result = query.list();

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return result;
	}
	
	@Override
	public List<Map<String, Object>> findAllWithProductByItemsType(String itemsType) throws Exception {

	    Session session = sessionFactory.getCurrentSession();

	    String sql =
	            "SELECT cc.catalog_consumables_id, " +
	            "       cc.product_id, " +
	            "       cc.active, " +
	            "       cc.sub_product_active, " +
	            "       cc.items_type, " +
	            "       p.product_name AS catalog_consumables_name " +
	            "FROM catalog_consumables cc " +
	            "INNER JOIN product p ON cc.product_id = p.product_id " +
	            "WHERE cc.parent_product_id = 0 " +
	            "AND cc.active = '1' " +
	            "AND cc.items_type = :itemsType " +
	            "ORDER BY p.sequence";

	    SQLQuery query = session.createSQLQuery(sql);
	    query.setParameter("itemsType", itemsType);
	    query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

	    return query.list();
	}
	
}
