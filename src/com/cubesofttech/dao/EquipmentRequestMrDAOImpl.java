package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.cubesofttech.model.EquipmentRequestMr;
import com.cubesofttech.model.DocStatus;
import com.cubesofttech.model.Expense;
import com.cubesofttech.model.FileUpload;
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
	public void update(EquipmentRequestMr EquipmentRequest) throws Exception {
	    Session session = this.sessionFactory.getCurrentSession();
	    
	    // 🌟 เปลี่ยนจาก update เป็น merge เพื่อลดปัญหา Session ซ้ำซ้อนใน Hibernate
	    session.merge(EquipmentRequest); 
	    
	    session.flush();
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
	public void updateStatus(String mr_id, String status ,String user_create ) throws Exception {
	     Session session = this.sessionFactory.getCurrentSession();
	     
	     // 1. เปลี่ยน '${status}' ให้เป็น :status เพื่อความปลอดภัยและถูกต้องตามหลัก SQL
	     String sql = "UPDATE mr SET status_id = :status WHERE mr_id = :mrId";
	        
	     // 2. ผูกค่า Parameter จากตัวแปร mr_id และ status ที่รับมาจากหัว Method ตัวเอง
	     session.createSQLQuery(sql)
	            .setParameter("status", status)  // ผูกค่า status
	            .setParameter("mrId", mr_id)     // ผูกค่า mr_id (จากตัวแปรที่รับเข้า Method)
	            .executeUpdate(); 
	     
	     String sqlInsert = "INSERT INTO delivered_detail (mr_id, user_create, time_create) VALUES (:mrId, :user_create, NOW())";
	     session.createSQLQuery(sqlInsert)
	            .setParameter("mrId", mr_id)
	            .setParameter("user_create", user_create)
	            .executeUpdate(); // 💡 ใช้ executeUpdate() เหมือนเดิมเพราะเป็นคำสั่ง INSERT
	}
	
	@Override
	public Map<String, Object> loaddataEquipment(String mr_id) throws Exception {
	    Session session = this.sessionFactory.getCurrentSession();
	    Map<String, Object> result = null;
	    try {
	        StringBuilder sql = new StringBuilder();
	        // 1. ระบุคอลัมน์ทั้งหมดที่ต้องการดึง (ตรงนี้สามารถเพิ่มคอลัมน์อื่น ๆ ของตาราง doc_status ได้ตามสบายเลยครับ)
	        sql.append("SELECT mr.*, ");
	        sql.append("ds.status_name AS status_name, ");
	        sql.append("ds.doc_status_id AS doc_status_id, "); // อยากได้ค่าไหนเพิ่มจากตาราง ds สามารถ .append ต่อตรงนี้ได้เลย
	        sql.append("pd.product_name, ");
	        sql.append("pd.sequence, ");
	        sql.append("pd.parent_product_id, ");
	        sql.append("ur.path, ");
	        sql.append("ur.name, ");
	        sql.append("ur.name_en, ");
	        sql.append("ur.employee_id, ");
	        sql.append("ur.department_id, ");
	        sql.append("pd.product_type, ");
	        sql.append("un.unit_name ");
	        sql.append("FROM mr mr ");
	        sql.append("LEFT JOIN doc_status ds ON mr.status_id = ds.doc_status_id ");
	        sql.append("LEFT JOIN product pd ON pd.product_id = mr.catalog_items_id ");
	        sql.append("LEFT JOIN user ur ON ur.id = mr.request_user ");
	        sql.append("LEFT JOIN unit_of_measure un ON un.product_id = pd.product_id  and un.sequence = 0 ");
	        sql.append("WHERE mr.mr_id = :mr_id");

	        // 2. ใช้ SQLQuery และแปลงผลลัพธ์ให้ออกมาเป็น Map ด้วย AliasToEntityMapResultTransformer
	        org.hibernate.SQLQuery query = session.createSQLQuery(sql.toString());
	        query.setResultTransformer(org.hibernate.transform.AliasToEntityMapResultTransformer.INSTANCE);
	        query.setParameter("mr_id", mr_id);

	        // 3. ดึงค่าออกมาเป็นผลลัพธ์แถวเดียว (เนื่องจากค้นหาด้วย ID หลัก)
	        result = (Map<String, Object>) query.uniqueResult();

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    
	    return result;
	}



	
	@Override
	public List<Object[]> getAllEquopmentRequestMr(EquipmentRequestMr equipmentRequestMr) throws Exception {
	     Session session = this.sessionFactory.getCurrentSession();
	     
	     // 1. สร้าง Base SQL
	     StringBuilder sql = new StringBuilder();
	     sql.append("SELECT ")
	        .append("    eq.mr_id, ")
	        .append("    pd.product_name, ")
	        .append("    CASE ")
	        .append("        WHEN eq.item_type = 1 THEN 'Equipment' ")
	        .append("        WHEN eq.item_type = 2 THEN 'Consumables' ")
	        .append("    END as item_type, ")
	        .append("    eq.item_sub_id, ")
	        .append("    eq.amount, ")
	        .append("    eq.status_id, ")
	        .append("    eq.request_user, ")
	        .append("    eq.request_date, ")
	        .append("    eq.Approve_user, ")
	        .append("    eq.Approve_date, ")
	        .append("    eq.receive_user, ")
	        .append("    eq.receive_date, ")
	        .append("    eq.description, ")
	        .append("    eq.user_update, ")
	        .append("    eq.time_create, ")
	        .append("    eq.time_update, ")
	        .append("    ds.status_name ")
	        .append("FROM mr eq ")
	        .append("LEFT JOIN ( ")
	        .append("    SELECT doc_status_id, MIN(status_name) as status_name ")
	        .append("    FROM doc_status ")
	        .append("    GROUP BY doc_status_id ")
	        .append(") ds ON ds.doc_status_id = eq.status_id ")
	        .append("LEFT JOIN catalog_equipment cq ON cq.catalog_equipment_id = eq.catalog_items_id AND eq.item_type = 1 ")
	        .append("LEFT JOIN product pd ON pd.product_id = eq.catalog_items_id and pd.parent_product_id = 0 ")
	        .append("WHERE 1 = CASE ")
	        .append("    WHEN (SELECT ur.role_id FROM user ur WHERE ur.id = :requestUser) = 'admin' and ds.status_name != 'Draft'  and ds.status_name != 'Cancel' THEN 1 ")
	        .append("    WHEN eq.request_user = :requestUser THEN 1 ")
	        .append("    ELSE 0 ")
	        .append("END ");

	     sql.append("ORDER BY eq.mr_id desc");
	    
	     org.hibernate.Query query = session.createSQLQuery(sql.toString());
	     
	     // ผูกค่า Parameter (ส่ง requestUser เข้าไปตัวเดียวตามที่คุณต้องการ)
	     query.setParameter("requestUser", equipmentRequestMr.getRequestUser());
	                                    
	     return (List<Object[]>) query.list();
	}

	
	@Override
	public  List<DocStatus> getDocStatus(DocStatus docStatus) throws Exception {
		 Session session = this.sessionFactory.getCurrentSession();

	     String hql = "FROM DocStatus";
	        
	     List<DocStatus> StatusList = session.createQuery(hql).list();
	                                    
	     return StatusList;
	}

	@Override
	public List<FileUpload> findByPageAndPageId(String page, String pageId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<FileUpload> fileList = null;
		try {
			String sql = "SELECT * FROM file WHERE page = :page AND page_id = :pageId";
			SQLQuery query = session.createSQLQuery(sql);
			query.addEntity(FileUpload.class);
			query.setParameter("page", page);
			query.setParameter("pageId", pageId);

			fileList = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return fileList;
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
