package com.cubesofttech.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.cubesofttech.model.CatalogEquipment;
import com.cubesofttech.model.EquipmentRequestMr;
import com.cubesofttech.model.DocStatus;
import com.cubesofttech.model.Expense;
import com.cubesofttech.model.Product;
import com.cubesofttech.model.User;

@Repository
public class EquipmentRequestMrDAOImpl  implements EquipmentRequestMrDAO{
	@Autowired
	private SessionFactory sessionFactory;
	
	
	@Override
	public List<EquipmentRequestMr> findAll() throws Exception {
		Session session = sessionFactory.getCurrentSession();
		List<EquipmentRequestMr> equipmentRequestMr = null;
		try {
			equipmentRequestMr = session.createCriteria(EquipmentRequestMr.class).list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return equipmentRequestMr;
	}
	@Override
	public void save(EquipmentRequestMr EquipmentRequest) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.save(EquipmentRequest);
		session.flush();
		// session.close();
	}
	
	@Override
	public void deleteMr(EquipmentRequestMr equipmentRequestMr) throws Exception {
	     Session session = this.sessionFactory.getCurrentSession();
	     
	     // เขียนคำสั่ง SQL สำหรับลบข้อมูล
	     String sql = "UPDATE mr SET status_id = '8' WHERE mr_id = :mrId";
	        
	     // สร้าง Query, ผูกค่า Parameter และสั่ง Execute
	     session.createSQLQuery(sql)
	            .setParameter("mrId", equipmentRequestMr.getMrId()) // สมมติว่า getMrId() คืนค่าไอดีกลับมา
	            .executeUpdate(); // 💡 ต้องใช้ executeUpdate() สำหรับ INSERT, UPDATE, DELETE
	}
	
	@Override
	public List<Expense> loaddataEquipment(Long mr_id) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Expense> list = null;
		try {
			String hql = "from mr  where mr_id = :mr_id";
			org.hibernate.Query q = session.createQuery(hql);
			q.setParameter("mr_id", mr_id);
			list = q.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public List<Object[]> getAllEquopmentRequestMr(EquipmentRequestMr equipmentRequestMr) throws Exception {
	     Session session = this.sessionFactory.getCurrentSession();
	     
	     String sql = "SELECT "
	    	        + "    eq.mr_id, "
	    	        + "    CASE "
	    	        + "        WHEN eq.item_type = 1 THEN cq.equipment_name "
	    	        + "        WHEN eq.item_type = 2 THEN pd.product_name "
	    	        + "    END as product_name, "
	    	        + "    CASE "
	    	        + "        WHEN eq.item_type = 1 THEN 'Equipment' "
	    	        + "        WHEN eq.item_type = 2 THEN 'Consumables' "
	    	        + "    END as item_type, "
	    	        + "    eq.item_sub_id, "
	    	        + "    eq.amount, "
	    	        + "    eq.status_id, "
	    	        + "    eq.request_user, "
	    	        + "    eq.request_date, "
	    	        + "    eq.Approve_user, "
	    	        + "    eq.Approve_date, "
	    	        + "    eq.receive_user, "
	    	        + "    eq.receive_date, "
	    	        + "    eq.description, "
	    	        + "    eq.user_update, "
	    	        + "    eq.time_create, "
	    	        + "    eq.time_update, "
	    	        + "    ds.status_name "
	    	        + "FROM mr eq "
	    	        + "LEFT JOIN ( "
	    	        + "    SELECT doc_status_id, MIN(status_name) as status_name "
	    	        + "    FROM doc_status "
	    	        + "    GROUP BY doc_status_id "
	    	        + ") ds ON ds.doc_status_id = eq.status_id "
	    	        + "LEFT JOIN catalog_equipment cq ON cq.catalog_equipment_id = eq.catalog_items_id AND eq.item_type = 1 "
	    	        + "LEFT JOIN product pd ON pd.product_id = eq.catalog_items_id AND eq.item_type = 2 "
	    	        + "ORDER BY eq.mr_id ASC";
        
	     List<Object[]> mrgetall = (List<Object[]>) session.createSQLQuery(sql).list();
	                                    
	     return mrgetall;
	}

	
	@Override
	public  List<DocStatus> getDocStatus(DocStatus docStatus) throws Exception {
		 Session session = this.sessionFactory.getCurrentSession();

	     String hql = "FROM DocStatus";
	        
	     List<DocStatus> StatusList = session.createQuery(hql).list();
	                                    
	     return StatusList;
	}


	
	@Override
	public String getNextMrId() throws Exception {
	    Session session = this.sessionFactory.getCurrentSession();
	    
	    String currentYear = java.time.LocalDate.now().format(java.time.format.DateTimeFormatter.ofPattern("yyyy"));
	    String prefix = "MR" + currentYear; 
	    
	    String hql = "SELECT MAX(e.mrId) FROM EquipmentRequestMr e WHERE e.mrId LIKE :yearPrefix";
	    String lastNo = (String) session.createQuery(hql)
	                                    .setParameter("yearPrefix", prefix + "%")
	                                    .uniqueResult();
	    
	    int nextRunning = 1; 
	    
	    if (lastNo != null && lastNo.startsWith(prefix)) {
	        String lastRunningStr = lastNo.substring(lastNo.length() - 4);
	        nextRunning = Integer.parseInt(lastRunningStr) + 1;
	    }
	    
	    String finalNo = prefix + String.format("%08d", nextRunning);
	    boolean isDuplicate = true;
	    
	    while (isDuplicate) {
	        // จุดที่ 2: เปลี่ยนตรงนี้ให้เป็น EquipmentRequest e และ e.mrId เช่นเดียวกันครับ
	        String checkHql = "SELECT COUNT(e.mrId) FROM EquipmentRequestMr e WHERE e.mrId = :checkId";
	        Long count = (Long) session.createQuery(checkHql)
	                                    .setParameter("checkId", finalNo)
	                                    .uniqueResult();
	        
	        if (count == 0) {
	            isDuplicate = false; 
	        } else {
	            nextRunning++; 
	            finalNo = prefix + String.format("%08d", nextRunning);
	        }
	    }
	    
	    return finalNo;
	}


}
