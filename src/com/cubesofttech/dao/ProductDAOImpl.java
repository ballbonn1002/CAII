package com.cubesofttech.dao;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
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
    public List<Map<String, Object>> findAllWithSubProducts(String productType) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        List<Map<String, Object>> products = null;
        try {
            boolean filterByType = (productType != null && !productType.trim().isEmpty());

            StringBuilder sql = new StringBuilder();
            sql.append("SELECT main.product_id AS product_id, main.sequence AS sequence, ");
            sql.append("main.product_no AS product_no, ");
            sql.append("main.product_name AS product_name, main.product_type AS product_type, ");
            // active -> Catalog MR, sub_product_active -> Select Subproduct (หน้า list)
            sql.append("main.active AS active, main.sub_product_active AS sub_product_active, ");
            // ยอดคงเหลือฝั่ง Equipment = จำนวนเครื่องจริงที่ผูกอยู่ ไม่ได้มาจากตาราง stock
            sql.append("COALESCE(eqc.qty, 0) AS equipment_qty, ");
            sql.append("GROUP_CONCAT(sub.product_name ORDER BY sub.sequence ASC SEPARATOR ',') AS sub_products ");
            sql.append("FROM product main ");
            sql.append("LEFT JOIN product sub ON main.product_id = sub.parent_product_id ");
            // นับเครื่องด้วย subquery แยก - ถ้า join equipment ตรงๆ จะคูณกับแถวที่ join sub
            // อยู่แล้ว ทำให้ยอดบานตามจำนวน sub product
            sql.append("LEFT JOIN ( ");
            sql.append("    SELECT eq.product_id AS product_id, COUNT(*) AS qty ");
            sql.append("    FROM equipment eq ");
            //           product_id เป็น varchar ค่าว่างจึงไม่ใช่ NULL ต้องกันแยกอีกชั้น
            sql.append("    WHERE eq.product_id IS NOT NULL AND TRIM(eq.product_id) <> '' ");
            //           status NULL ต้องนับด้วย - NULL NOT IN (...) ได้ NULL ซึ่งถูกตัดทิ้ง
            sql.append("      AND (eq.status IS NULL OR eq.status NOT IN (:retiredStatuses)) ");
            sql.append("    GROUP BY eq.product_id ");
            sql.append(") eqc ");
            // equipment.product_id เป็น varchar(32) ส่วน product.product_id เป็น int
            // CAST ฝั่ง varchar เป็นตัวเลข ไม่ CAST ฝั่ง int เป็น string เพราะจะลาก
            // เรื่อง collation (utf8_general_ci vs utf8mb4_unicode_ci) เข้ามาโดยไม่จำเป็น
            sql.append("  ON CAST(eqc.product_id AS UNSIGNED) = main.product_id ");
            // ข้อมูล unit ไม่ join ที่นี่แล้ว - ดึงผ่าน UnitOfMeasureDAO.findMainUnitsByProductIds()
            // product_type / parent_product_id เป็น varchar ต้องเทียบด้วย string literal
            // ถ้าเทียบกับตัวเลขเปล่า MySQL จะ cast ทั้งคอลัมน์เป็น number ทำให้ใช้ index ไม่ได้
            sql.append("WHERE main.parent_product_id = '0' ");
            if (filterByType) {
                sql.append("AND main.product_type = :productType ");
            }
            sql.append("GROUP BY main.product_id, main.sequence, main.product_no, main.product_name, ");
            sql.append("main.product_type, main.active, main.sub_product_active, eqc.qty ");
            sql.append("ORDER BY main.product_id ASC");

            SQLQuery query = session.createSQLQuery(sql.toString());
            query.setParameterList("retiredStatuses", EquipmentDAO.RETIRED_STATUSES);
            if (filterByType) {
                query.setParameter("productType", productType.trim());
            }
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

	    String sql = "SELECT p.product_id, p.sequence, p.product_no, p.product_type, p.product_name " +
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
	     
	     String sql = "SELECT pd.product_id, pd.product_name, pd.parent_product_id, pd.product_type, um.unit_name, um.unit_id " 
	                + "FROM product pd "
	                + "left join unit_of_measure um on um.product_id = pd.product_id and um.sequence = 0 "
	                + "WHERE pd.parent_product_id = 0";
	        
	     List<Object[]> mrgetall = (List<Object[]>) session.createSQLQuery(sql).list();
	                                    
	     return mrgetall;
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

    @Override
    public Map<String, Long> countReferences(List<Integer> productIds) throws Exception {
        Map<String, Long> refs = new LinkedHashMap<String, Long>();
        if (productIds == null || productIds.isEmpty()) {
            return refs;
        }

        Session session = this.sessionFactory.getCurrentSession();

        // ids เป็น String ด้วยเพราะตารางปลายทางเก็บ product_id เป็น varchar กันหมด
        // (stock.product_id varchar(16), good_receipt_detail varchar(32), equipment varchar(32))
        List<String> idsAsText = new ArrayList<String>();
        for (Integer id : productIds) {
            if (id != null) {
                idsAsText.add(String.valueOf(id));
            }
        }
        if (idsAsText.isEmpty()) {
            return refs;
        }

        // mr.catalog_items_id ชี้ product ก็ต่อเมื่อ item_type ไม่ใช่ '1'
        // (item_type = '1' ชี้ไป catalog_equipment ซึ่งเป็นคนละ id space กับ product.product_id
        //  ดู EquipmentRequestMrDAOImpl: LEFT JOIN catalog_equipment ... AND eq.item_type = 1
        //                                LEFT JOIN product ... AND eq.item_type = 2
        //  TODO: ถ้าวันไหน MR ของ Equipment ถูกย้ายมาอ้าง product.product_id โดยตรง
        //        (แทน catalog_equipment) ต้องทบทวนเงื่อนไขนี้ใหม่)
        // ส่วน item_sub_id ชี้ product_id ของ sub product เสมอ ไม่ต้องกรอง item_type
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT 'MR - Material Request' AS source, COUNT(*) AS n FROM mr ");
        sql.append(" WHERE (catalog_items_id IN (:idsAsText) AND item_type <> '1') ");
        sql.append("    OR item_sub_id IN (:idsAsText) ");
        sql.append("UNION ALL ");
        sql.append("SELECT 'Stock movement', COUNT(*) FROM stock WHERE product_id IN (:idsAsText) ");
        sql.append("UNION ALL ");
        sql.append("SELECT 'Good Receipt', COUNT(*) FROM good_receipt_detail ");
        sql.append(" WHERE product_id IN (:idsAsText) OR parent IN (:idsAsText) ");
        sql.append("UNION ALL ");
        sql.append("SELECT 'เครื่องที่ผูกอยู่ (equipment)', COUNT(*) FROM equipment ");
        sql.append(" WHERE product_id IN (:idsAsText) ");

        SQLQuery query = session.createSQLQuery(sql.toString());
        query.setParameterList("idsAsText", idsAsText);

        List<Object[]> rows = query.list();
        if (rows != null) {
            for (Object[] row : rows) {
                if (row == null || row.length < 2 || row[1] == null) {
                    continue;
                }
                long count = ((Number) row[1]).longValue();
                if (count > 0) {
                    refs.put(String.valueOf(row[0]), Long.valueOf(count));
                }
            }
        }
        return refs;
    }

    @Override
    public void deleteWithChildren(Integer productId) throws Exception {
        if (productId == null) {
            return;
        }
        Session session = this.sessionFactory.getCurrentSession();
        String idAsText = String.valueOf(productId);

        // ลบลูกก่อนตัวแม่: unit_of_measure ของทั้งแม่และลูก -> sub product -> ตัวแม่
        // unit_of_measure ไม่มี entity ที่ map ไว้ในโปรเจกต์ จึงลบด้วย native SQL
        // (subquery เลือกจากตาราง product ไม่ใช่ unit_of_measure จึงไม่ชน
        //  ข้อจำกัดของ MySQL เรื่อง select จากตารางเดียวกับที่กำลัง delete)
        session.createSQLQuery(
                "DELETE FROM unit_of_measure WHERE product_id = :idAsText "
              + "   OR product_id IN (SELECT CAST(product_id AS CHAR) FROM product "
              + "                     WHERE parent_product_id = :idAsText)")
               .setParameter("idAsText", idAsText)
               .executeUpdate();

        session.createQuery("delete from Product where parentProductId = :idAsText")
               .setParameter("idAsText", idAsText)
               .executeUpdate();

        session.createQuery("delete from Product where productId = :productId")
               .setParameter("productId", productId)
               .executeUpdate();

        session.flush();
    }

    @Override
    public boolean existsByProductNo(String productNo, Integer excludeProductId) throws Exception {
        if (productNo == null || productNo.trim().isEmpty()) {
            return false;
        }
        Session session = this.sessionFactory.getCurrentSession();
        StringBuilder hql = new StringBuilder(
                "select count(*) from Product where lower(trim(productNo)) = :productNo");
        if (excludeProductId != null) {
            hql.append(" and productId != :excludeProductId");
        }
        org.hibernate.Query query = session.createQuery(hql.toString());
        query.setParameter("productNo", productNo.trim().toLowerCase());
        if (excludeProductId != null) {
            query.setParameter("excludeProductId", excludeProductId);
        }
        Long count = (Long) query.uniqueResult();
        return count != null && count > 0;
    }

    @Override
    public Map<Integer, Integer> countEquipmentByParentAndSubProducts(Integer parentId) throws Exception {
        Map<Integer, Integer> counts = new LinkedHashMap<Integer, Integer>();
        if (parentId == null) {
            return counts;
        }
        Session session = this.sessionFactory.getCurrentSession();

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT p.product_id AS product_id, COALESCE(ec.qty, 0) AS qty ");
        sql.append("FROM product p ");
        // นับเครื่องด้วย subquery แยกก่อน ค่อย join - กันยอดคูณตามจำนวนแถวที่ join (ดู skill product-module)
        sql.append("LEFT JOIN ( ");
        sql.append("    SELECT eq.product_id AS product_id, COUNT(*) AS qty ");
        sql.append("    FROM equipment eq ");
        //           product_id เป็น varchar ค่าว่างจึงไม่ใช่ NULL ต้องกันแยกอีกชั้น
        sql.append("    WHERE eq.product_id IS NOT NULL AND TRIM(eq.product_id) <> '' ");
        //           status NULL ต้องนับด้วย - NULL NOT IN (...) ได้ NULL ซึ่งถูกตัดทิ้ง
        sql.append("      AND (eq.status IS NULL OR eq.status NOT IN (:retiredStatuses)) ");
        sql.append("    GROUP BY eq.product_id ");
        sql.append(") ec ");
        // equipment.product_id เป็น varchar(32) ส่วน product.product_id เป็น int - CAST ฝั่ง varchar เท่านั้น
        sql.append("  ON CAST(ec.product_id AS UNSIGNED) = p.product_id ");
        sql.append("WHERE p.product_id = :parentId OR p.parent_product_id = :parentIdText");

        SQLQuery query = session.createSQLQuery(sql.toString());
        query.setParameterList("retiredStatuses", EquipmentDAO.RETIRED_STATUSES);
        query.setParameter("parentId", parentId);
        query.setParameter("parentIdText", String.valueOf(parentId));
        query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

        List<Map<String, Object>> rows = query.list();
        if (rows != null) {
            for (Map<String, Object> row : rows) {
                Object idObj = row.get("product_id");
                Object qtyObj = row.get("qty");
                if (idObj == null) {
                    continue;
                }
                counts.put(Integer.valueOf(((Number) idObj).intValue()),
                        Integer.valueOf(qtyObj == null ? 0 : ((Number) qtyObj).intValue()));
            }
        }
        return counts;
    }

}
