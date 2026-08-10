package com.cubesofttech.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.hibernate.Criteria;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Projections;
import org.hibernate.transform.AliasToEntityMapResultTransformer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.cubesofttech.model.Product;
import com.cubesofttech.util.DateUtil;

@Repository
public class ProductDAOImpl implements ProductDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(Product product) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.save(product);
        session.flush();
    }

    @Override
    public void update(Product product) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.update(product);
        session.flush();
    }

    @Override
    public void delete(Product product) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.delete(product);
        session.flush();
    }

    @Override
    public Product findById(Integer id) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        return (Product) session.get(Product.class, id);
    }

    @Override
    public List<Product> findAll() throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        return session.createQuery("from Product").list();
    }

    @Override
    public List<Map<String, Object>> findAllConsWithSubProducts() throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        List<Map<String, Object>> products = null;
        try {
            StringBuilder sql = new StringBuilder();
            sql.append("SELECT main.product_id AS product_id, main.sequence AS sequence, ");
            sql.append("main.product_name AS product_name, main.product_type AS product_type, ");
            sql.append("GROUP_CONCAT(sub.product_name ORDER BY sub.sequence ASC SEPARATOR ',') AS sub_products ");
            sql.append("FROM product main ");
            sql.append("LEFT JOIN product sub ON main.product_id = sub.parent_product_id ");
            // ข้อมูล unit ไม่ join ที่นี่แล้ว - ดึงผ่าน UnitOfMeasureDAO.findMainUnitsByProductIds()
            // product_type / parent_product_id เป็น varchar ต้องเทียบด้วย string literal
            // ถ้าเทียบกับตัวเลขเปล่า MySQL จะ cast ทั้งคอลัมน์เป็น number ทำให้ใช้ index ไม่ได้
            sql.append("WHERE main.product_type = '2' AND main.parent_product_id = '0' ");
            sql.append("GROUP BY main.product_id, main.sequence, main.product_name, main.product_type ");
            sql.append("ORDER BY main.product_id ASC");
            SQLQuery query = session.createSQLQuery(sql.toString());
            query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
            products = query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return products;
    }
    
	@Override
    public List<Map<String, Object>> findCatalogItemsWithSubProducts() throws Exception {
		Session session = sessionFactory.getCurrentSession();
	    List<Map<String, Object>> result = null;
		try {
			String sql = "SELECT main.product_id AS catalog_consumables_id, "
					+ "       main.product_id AS product_id, "
					+ "       main.active AS active, "
					+ "       main.product_name AS catalog_consumables_name, "
					+ "       main.sub_product_active AS sub_product_active, "
					+ "       GROUP_CONCAT(sub.product_name ORDER BY sub.sequence ASC SEPARATOR ',') AS sub_product_names "
					+ "FROM product main "
					+ "LEFT JOIN product sub ON sub.parent_product_id = main.product_id "
					+ "WHERE main.product_type = 2 AND main.parent_product_id = 0 "
					+ "GROUP BY main.product_id, main.active, main.product_name, main.sub_product_active "
					+ "ORDER BY main.sequence ASC;";
			
			SQLQuery query = session.createSQLQuery(sql);
	        query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

	        result = query.list();

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return result;
	}
	
	@Override
	public List<Map<String, Object>> findByItemsType(String itemsType) throws Exception {
	    Session session = sessionFactory.getCurrentSession();

	    String sql = "SELECT p.product_id AS catalog_consumables_id, p.sequence, p.product_no, p.product_type, p.product_name " +
	                 "FROM product p " +
	                 "WHERE p.parent_product_id = '0' " +
	                 "AND p.product_type = :itemsType " +
	                 "ORDER BY p.sequence";

	    SQLQuery query = session.createSQLQuery(sql);
	    query.setParameter("itemsType", itemsType);
	    query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

	    return query.list();
	}
    
	@Override
	public void updateActiveByParentId(Integer parentId, String active, String userUpdateId) throws Exception {
	    try {
	        Session session = this.sessionFactory.getCurrentSession();
	        String hql = "UPDATE Product SET active = :active, userUpdate = :userUpdateId, timeUpdate = :timeUpdate "
	                   + "WHERE parentProductId = :parentId";
	        
	        org.hibernate.Query query = session.createQuery(hql);
	        query.setParameter("active", active);
	        query.setParameter("userUpdateId", userUpdateId);
	        query.setParameter("timeUpdate", DateUtil.getCurrentTime()); 
	        query.setParameter("parentId", String.valueOf(parentId));
	        
	        query.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    }
	}
	
	@Override
	public void updateSubProductActiveByParentId(Integer parentId, String subProductActive, String userUpdateId) throws Exception {
	    try {
	        Session session = this.sessionFactory.getCurrentSession();
	        String hql = "UPDATE Product SET subProductActive = :subProductActive, userUpdate = :userUpdateId, timeUpdate = :timeUpdate "
	                   + "WHERE parentProductId = :parentId";
	        
	        org.hibernate.Query query = session.createQuery(hql);
	        query.setParameter("subProductActive", subProductActive);
	        query.setParameter("userUpdateId", userUpdateId);
	        query.setParameter("timeUpdate", DateUtil.getCurrentTime()); 
	        query.setParameter("parentId", String.valueOf(parentId)); 
	        
	        query.executeUpdate(); 
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    }
	}
	
	@Override
	public List<Product> getproductid(Product product) throws Exception {
	     Session session = this.sessionFactory.getCurrentSession();
	     
	     String hql = "FROM Product";
	        
	     List<Product> productIdList = session.createQuery(hql).list();
	                                    
	     return productIdList;
	}
		
	
	@Override
	public List<Object[]> getArrayProduct(Product Product) throws Exception {
	     Session session = this.sessionFactory.getCurrentSession();
	     
	     String sql = "SELECT pd.product_id, pd.product_name, pd.parent_product_id, pd.product_type " 
	                + "FROM product pd "
	                + "WHERE pd.parent_product_id = 0";
	        
	     List<Object[]> mrgetall = (List<Object[]>) session.createSQLQuery(sql).list();
	                                    
	     return mrgetall;
	}
    @Override
    public Integer getMaxId() throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        Integer maxId = 0;
        try {
            Criteria criteria = session.createCriteria(Product.class)
                    .setProjection(Projections.max("productId"));
            maxId = (Integer) criteria.uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            maxId = 0;
        }
        return (maxId != null) ? maxId : Integer.valueOf(0);
    }

    @Override
    public List<Product> findByParentProductIds(List<String> parentProductIds) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        if (parentProductIds == null || parentProductIds.isEmpty()) {
            return new ArrayList<>();
        }
        return session.createQuery("from Product where parentProductId in (:ids)")
                .setParameterList("ids", parentProductIds)
                .list();
    }

}
