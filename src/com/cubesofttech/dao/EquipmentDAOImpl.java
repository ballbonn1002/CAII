package com.cubesofttech.dao;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Projections;
import org.hibernate.transform.AliasToEntityMapResultTransformer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.Equipment;
import com.cubesofttech.model.EquipmentStatus;
import com.cubesofttech.model.EquipmentType;

@Repository
public class EquipmentDAOImpl implements EquipmentDAO {

	@Autowired
	private SessionFactory sessionFactory;
	private Object equipmentId;

	@Override
	public void save(Equipment equipment) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.save(equipment);
		session.flush();
		// session.close();
	}

	/*
	 * @Override public List<Equipment> findAll() throws Exception { Session
	 * session = this.sessionFactory.getCurrentSession(); List<Equipment>
	 * equipmentList = null; try { equipmentList =
	 * session.createCriteria(Equipment.class).list(); } catch (Exception e) {
	 * e.printStackTrace(); }finally{ //session.close(); } return equipmentList;
	 * }
	 */
	@Override
	public List<Map<String, Object>> findAll() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> Equipment = null;
		try {
			Equipment = session.createCriteria(Equipment.class).list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return Equipment;

	}

	@Override
	public List<Map<String, Object>> statusnirobon() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> statusniro = null;
		try {

			String sql = " SELECT borrow.equipment_id AS borrowcheck ,equipment.item_no ,equipment.image ,equipment.ram ,equipment.process ,equipment.status ,equipment.name ,borrow.user_borrowid ,borrow.borrow_id ,equipment.equipment_id ,equipment.battery ,equipment.hdd ,equipment.windows ,equipment.location ,equipment.amount ,equipment.time_create ,equipment.type ,equipment.serial_no ,borrow.status AS statusborrow "
					+ "FROM equipment "
					+ "LEFT JOIN borrow ON equipment.equipment_id = borrow.equipment_id ORDER BY borrow.borrow_id ASC ";

			SQLQuery query = session.createSQLQuery(sql);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			statusniro = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return statusniro;
	}

	@Override
	public Equipment findByTypee(int i) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void update(Equipment equipment) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.clear();
		session.update(equipment);
		session.flush();
		// session.close();
	}

	@Override
	public void delete(Equipment equipment) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.delete(equipment);
		session.flush();
		// session.close();
	}

	@Override
	public List<Map<String, Object>> findByItemno(String itemNo) throws Exception {
		// TODO Auto-generated method stub
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> itemno = null;
		try {
			String sql = "SELECT * FROM equipment WHERE equipment_id = equipment_id ";

			SQLQuery query = session.createSQLQuery(sql);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			itemno = query.list();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return itemno;

	}

	@Override
	public Integer getMaxId() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Equipment> list = null;
		Integer maxId;

		try {

			Criteria criteria = session.createCriteria(Equipment.class).setProjection(Projections.max("equipmentId"));
			maxId = (Integer) criteria.uniqueResult();

		} catch (Exception e) {
			e.printStackTrace();
			return new Integer(0);

		} finally {

		}
		if (maxId != null) {
			return maxId;
		} else{
			return new Integer(0);
		}
	}

	@Override
	public List<Map<String, Object>> listdetail() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> detail = null;
		try {
			String sql = "SELECT equipment.equipment_id,equipment.item_no ,equipment.status ,equipment.name ,equipment.serial_no,detail "
					+ "FROM equipment " + "ORDER BY equipment.item_no ASC";
			SQLQuery query = session.createSQLQuery(sql);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			detail = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return detail;
	}

	@Override
	public List<Equipment> search(String status) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	/*
	 * @Override public List<Map<String, Object>> searchList(String status)
	 * throws Exception { // TODO Auto-generated method stub return null; }
	 */
	@Override
	public List<Map<String, Object>> searchList(String status,String name , String type) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> search = null;
		try {
			String sql = "";
			SQLQuery query;
			String status_condition = "";
			if(!status.equals("All")){
			 status_condition = "and status = '"+status+"'";
			}
			if (name != null) {
				sql = "SELECT * FROM equipment where (name LIKE '%"+name+"%'  or serial_no LIKE  '%"+name+"%'  or item_no LIKE  '%"+name+"%') and type = '"+type+"' "+status_condition+"  ORDER BY item_no ASC ";
					
			} 
			if(status == "All"){
				sql = "SELECT * FROM equipment where not status = 'D' and  type = '"+type+"'  ORDER BY item_no ASC ";
			
			}
			query = session.createSQLQuery(sql);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			search = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return search;
	}
	@Override
	public List<Map<String, Object>> searchList(String status) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> search = null;
		try {
			String sql = "";
			SQLQuery query;
			if (status.equals("All") || status.equals("")) {
				sql = "SELECT * FROM equipment where NOT status = 'D' ORDER BY item_no ASC ";
				query = session.createSQLQuery(sql);
			} else {
				sql = "SELECT * FROM equipment " + " WHERE `status` = :s ORDER BY item_no ASC ";
				query = session.createSQLQuery(sql);
				query.setParameter("s", status);
			}

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			search = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return search;
	}

	@Override
	public List<Map<String, Object>> searchAvai(String status) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> search = null;
		try {
			String statusText = null;
			if (status != null) {

				statusText = "WHERE status = :status ";
				// String sql = " SELECT status FROM equipment WHERE status =
				// 'A'; ";
			}

			String sql = " SELECT status FROM equipment ORDER BY item_no ASC ";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("statusText", statusText);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			search = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return search;
	}

	@Override
	public Equipment findByEquipmentId(int eId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		Equipment Equipment = null;
		try {
			Equipment = (Equipment) session.get(Equipment.class, eId);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return Equipment;

	}

	/*
	 * @Override public List<Map<String, Object>> searchList() throws Exception
	 * { // TODO Auto-generated method stub return null; }
	 */

	/*
	 * @Override public List<Equipment> search(String status) throws Exception {
	 * Session session = this.sessionFactory.getCurrentSession();
	 * List<Equipment> list = null; try {
	 * 
	 * Criteria cr = session.createCriteria(Equipment.class);
	 * cr.add(Restrictions.eq("status", status));
	 * 
	 * list = cr.list();
	 * 
	 * } catch (Exception e) { e.printStackTrace(); return null;
	 * 
	 * } finally {
	 * 
	 * } return list; }
	 */

	/*
	 * @Override public List<Equipment> findByequipmentId(String equipmentId)
	 * throws Exception { Session session =
	 * this.sessionFactory.getCurrentSession(); List<Equipment> list = null; try
	 * {
	 * 
	 * Criteria cr = session.createCriteria(Equipment.class);
	 * cr.add(Restrictions.eq("equipmentId", equipmentId)); list = cr.list();
	 * 
	 * } catch (Exception e) { e.printStackTrace(); return null;
	 * 
	 * } finally {
	 * 
	 * } return list; }
	 */

	@Override
	public List<Equipment> findAllBorrow() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Equipment> Equipment = null;
		try {
			Equipment = session.createCriteria(Equipment.class).list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return Equipment;

	}

	@Override
	public Equipment findByImages(String image) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		Equipment Equipment = null;
		try {
			Equipment = (Equipment) session.get(Equipment.class, image);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return Equipment;

	}

	public List<Map<String, Object>> approve() throws Exception { //
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> approveborrow = null;
		try {
			/*String sql = " SELECT borrow.equipment_id ,equipment.item_no ,equipment.name , borrow.borrow_id, borrow.reason, borrow.reasona,borrow.user_borrowid ,borrow.date_start ,borrow.date_end ,equipment.equipment_id AS equipmentid ,borrow.status ,equipment.status AS statuseq "
					+ "FROM equipment " + "LEFT JOIN borrow ON equipment.equipment_id = borrow.equipment_id ORDER BY borrow.borrow_id ASC ";*/
			String sql = "SELECT borrow.equipment_id ,equipment.item_no ,equipment.name ,borrow.borrow_id ,borrow.reason ,borrow.reasona ,borrow.user_borrowid ,date_format(borrow.date_start, '%d-%m-%Y') as date_start ,date_format(borrow.date_end, '%d-%m-%Y') as date_end ,equipment.equipment_id AS equipmentid ,borrow.status ,equipment.status AS statuseq "
                    + "FROM equipment " + "LEFT JOIN borrow ON equipment.equipment_id = borrow.equipment_id ORDER BY borrow.borrow_id ASC ";
			SQLQuery query = session.createSQLQuery(sql);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			approveborrow = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return approveborrow;
	}

	@Override
	public Equipment findById(String id) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		Equipment equipment = null;
		try {
			equipment = (Equipment) session.get(Equipment.class, id);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return equipment;
	}

	@Override
	public Equipment findById(int id) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		Equipment equipment = null;
		try {
			equipment = (Equipment) session.get(Equipment.class, id);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return equipment;
	}
	
	@Override
	public List<Equipment> getAll(){
		Session session = this.sessionFactory.getCurrentSession();
		List<Equipment> list = null;
		try {
			list = session.createCriteria(Equipment.class).list();
		} catch(HibernateException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public List<Equipment> findByStatus(String status){
		Session session = this.sessionFactory.getCurrentSession();
		List<Equipment> list = null;
		try {
			String hql = "from Equipment where status = :status";
			Query query = session.createQuery(hql);
			query.setParameter("status", status);
			list = query.list();
		} catch (HibernateException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public Equipment findByItemNo(String itemNo){
		Session session = this.sessionFactory.getCurrentSession();
		Equipment result = null;
		try {
			String hql = "from Equipment where itemNo = :itemNo";
			Query query = session.createQuery(hql);
			query.setParameter("itemNo", itemNo);
			result = (Equipment) query.uniqueResult();
		} catch (HibernateException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@Override
	public Equipment getById(int id){
		Session session = this.sessionFactory.getCurrentSession();
		Equipment result = null;
		try {
			String hql = "from Equipment where equipmentId = :equipmentId"; 
			Query query = session.createQuery(hql);
			query.setParameter("equipmentId", id);
			result = (Equipment) query.uniqueResult();
		} catch (HibernateException e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Equipment> findByTypes(String Type){
		Session session = this.sessionFactory.getCurrentSession();
		List<Equipment> list = null;
		try {
			String hql = "from Equipment where type = :type";
			Query query = session.createQuery(hql);
			query.setParameter("type", Type);
			list = query.list();
		} catch (HibernateException e) {
			e.printStackTrace();
		}
		return list;
	}
	
}