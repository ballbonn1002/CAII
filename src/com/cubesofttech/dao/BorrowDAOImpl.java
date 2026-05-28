package com.cubesofttech.dao;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.AliasToEntityMapResultTransformer;
import org.hibernate.transform.Transformers;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.Borrow;
import com.cubesofttech.model.Equipment;

@Repository
public class BorrowDAOImpl implements BorrowDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public void save(Borrow borrow) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.save(borrow);
		session.flush();
		// session.close();
	}

	@Override
	public List<Borrow> findAll() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Borrow> borRowList = null;
		try {
			borRowList = session.createCriteria(Borrow.class).list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return borRowList;
	}
	
	@Override
	public List<Borrow> findAll_exceptStatus_A() throws Exception {
	    Session session = this.sessionFactory.getCurrentSession();
	    List<Borrow> borRowList = null;
	    try {
	        Criteria criteria = session.createCriteria(Borrow.class);
	        criteria.add(Restrictions.in("status", Arrays.asList("W", "B","T")));
	        borRowList = criteria.list();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        // session.close();
	    }
	    return borRowList;
	}


	@Override
	public List<Map<String, Object>> findAll_1() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> borRowList = null;
		try {
			String sql = " SELECT * "
					+ "FROM borrow " 
				
					+ "where status = 'B' ";

			SQLQuery query = session.createSQLQuery(sql);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			borRowList = query.list();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return borRowList;
	}

	@Override
	public Borrow findById(int id) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		Borrow borrow = null;
		try {
			borrow = (Borrow) session.get(Borrow.class, id);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return borrow;
	}

	@Override
	public void update(Borrow Borrow) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.clear();
		session.update(Borrow);
		session.flush();
		// session.close();
	}

	@Override
	public void delete(Borrow borrow) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.delete(borrow);
		session.flush();
		// session.close();
	}

	@Override
	public Integer getMaxId() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Borrow> list = null;
		Integer maxId;

		try {

			Criteria criteria = session.createCriteria(Borrow.class).setProjection(Projections.max("borrowId"));
			maxId = (Integer) criteria.uniqueResult();
			
			if(maxId == null){
				maxId = 0;	
			}
			else{
				return maxId;	
			}

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
	public List<Borrow> findByStatusId(String statusid) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Borrow> status = null;
		try {
			status = (List<Borrow>) session.get(Borrow.class, statusid);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return status;
	}

	public List<Map<String, Object>> Borrowinglist() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> list = null;
		try {

			String sql = " SELECT equipment.item_no ,equipment.image ,equipment.ram ,equipment.process ,equipment.status ,equipment.name ,borrow.user_borrowid ,borrow.borrow_id ,equipment.equipment_id,borrow.status AS statusborrow ,borrow.reasona ,equipment.type ,equipment.amount,equipment.serial_no "
					+ "FROM borrow " + "LEFT JOIN equipment ON borrow.equipment_id = equipment.equipment_id "
				
					+ "ORDER BY equipment.item_no ASC ";

			SQLQuery query = session.createSQLQuery(sql);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			list = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<Map<String, Object>> Borrowcheck() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> selectchect = null;
		try {

			String sql = " SELECT borrow.equipment_id AS borrowcheck ,equipment.item_no ,equipment.image ,equipment.ram ,equipment.process ,equipment.status ,equipment.name ,borrow.user_borrowid ,borrow.borrow_id ,equipment.equipment_id ,equipment.battery ,equipment.hdd ,equipment.windows ,equipment.location ,equipment.amount ,equipment.time_create ,equipment.type ,equipment.serial_no ,borrow.status AS statusborrow "
					+ "FROM equipment " + "LEFT JOIN borrow ON equipment.equipment_id = borrow.equipment_id ";

			SQLQuery query = session.createSQLQuery(sql);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			selectchect = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectchect;
	}

	public List<Map<String, Object>> Borrowchecked() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> selectchect = null;
		try {

			String sql = " SELECT borrow.equipment_id AS borrowcheck ,equipment.item_no ,equipment.image ,equipment.ram ,equipment.process ,equipment.status ,equipment.name ,borrow.user_borrowid ,borrow.borrow_id ,equipment.equipment_id ,equipment.battery ,equipment.hdd ,equipment.windows ,equipment.location ,equipment.amount ,equipment.time_create ,equipment.type ,equipment.serial_no ,borrow.status AS statusborrow "
					+ "FROM equipment " + "LEFT JOIN borrow ON equipment.equipment_id = borrow.equipment_id ";

			SQLQuery query = session.createSQLQuery(sql);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			selectchect = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectchect;
	}

	public List<Map<String, Object>> Borrowlistnirobon() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> selectnirobon = null;
		try {

			String sql = " SELECT borrow.equipment_id ,borrow.borrow_id,borrow.status " + "FROM borrow "
					+ "ORDER BY borrow_id ASC ";

			SQLQuery query = session.createSQLQuery(sql);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			selectnirobon = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectnirobon;
	}

	public List<Map<String, Object>> check() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> select = null;
		try {

			String sql = " SELECT * FROM equipment where status = 'A' "
				    + "ORDER BY item_no ASC ";

			SQLQuery query = session.createSQLQuery(sql);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			select = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return select;
	}

	public List<Map<String, Object>> Showdetail() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> Showdetail = null;
		try {

			String sql = " SELECT equipment.equipment_id ,equipment.name ,equipment.amount ,equipment.status ,equipment.item_no ,equipment.serial_no ,equipment.process ,equipment.battery ,equipment.hdd ,equipment.windows ,equipment.ram ,equipment.location ,equipment.amount ,equipment.image ,equipment.time_create,type ,borrow.status AS statusborrow ,equipment.detail ,borrow.borrow_id "
					+ " FROM equipment" + " LEFT JOIN borrow ON equipment.equipment_id = borrow.equipment_id  ";

			SQLQuery query = session.createSQLQuery(sql);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			Showdetail = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return Showdetail;
	}

	@Override
	public Borrow Borrowchecked(String string) {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public List<Map<String, Object>> Borrowlistnirobonxx(int borrowID) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> selectnirobon = null;
		try {

			String sql = "SELECT equipment.item_no "
					+ ",equipment.image "
					+ ",equipment.ram "
					+ ",equipment.process "
					+ ",equipment.status "
					+ ",equipment.name "
					+ ",borrow.user_borrowid "
					+ ",borrow.borrow_id"
					+ ",equipment.equipment_id "
					+ ",borrow.status AS statusborrow "
					+ ",borrow.reasona ,date_format(borrow.date_start, '%d-%m-%Y') as date_start "
					+ ",date_format(borrow.date_end, '%d-%m-%Y') as date_end "
					+ ",equipment.equipment_id AS equipmentid "
					+ ",borrow.location "
					+ ",borrow.contact_addr ,borrow.reason ,borrow.remark ,equipment.type ,equipment.amount " 
					+ " FROM borrow " 					
					+ " LEFT JOIN equipment ON borrow.equipment_id = equipment.equipment_id "
					+ "Where borrow.borrow_id =:borrowID ";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("borrowID", borrowID);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			selectnirobon = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectnirobon;
	}

	@Override
	public int findByIdx(Integer valueOf) throws Exception {
//			Session session = this.sessionFactory.getCurrentSession();
//			int borrow = (Integer) null;
//			try {
//				borrow = (int) session.get(Borrow.class, valueOf);
//			} catch (Exception e) {
//				e.printStackTrace();
//			} finally {
//				// session.close();
//			}
//			return borrow;
		
		return 0;
	}

	@Override
	public List<Borrow> find_History(String equipmentId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Borrow> selectnirobon = null;
		try {

			String sql = "SELECT * "
					+ " FROM borrow " 					
					+ "Where equipment_id =:equipmentId  order by time(borrow.time_create) asc ";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("equipmentId", equipmentId);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			selectnirobon = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectnirobon;
	}

	@Override
	public List<Map<String, Object>> search_borrow(String user) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> list = null;
		try {

			String sql = " SELECT equipment.item_no ,equipment.image ,equipment.ram ,equipment.process ,equipment.status ,equipment.name ,borrow.user_borrowid ,borrow.borrow_id ,equipment.equipment_id,borrow.status AS statusborrow ,borrow.reasona ,equipment.type ,equipment.amount,equipment.serial_no,borrow.date_start,borrow.date_end,borrow.location,borrow.time_create "
					+ "FROM borrow " + "LEFT JOIN equipment ON borrow.equipment_id = equipment.equipment_id "
				    + "Where borrow.user_borrowid = '"+user+"'"
					+ "ORDER BY equipment.item_no ASC ";

			SQLQuery query = session.createSQLQuery(sql);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			list = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Map<String, Object>> findHistoryByUser(String user) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> list = null;
		try {

			String sql = " SELECT equipment.item_no ,equipment.image ,equipment.ram ,equipment.process ,equipment.status ,equipment.name ,borrow.user_borrowid ,borrow.borrow_id ,equipment.equipment_id,borrow.status AS statusborrow ,borrow.reasona ,equipment.type ,equipment.amount,equipment.serial_no,borrow.date_start,borrow.date_end,borrow.location,borrow.time_create "
					+ "FROM borrow " + "LEFT JOIN equipment ON borrow.equipment_id = equipment.equipment_id "
				    + "Where borrow.user_borrowid = '"+user+"'"
					+ "ORDER BY borrow.date_start DESC  ";
			// edit on 28/04/20
			// old is// + "ORDER BY time(borrow.time_create) DESC  ";
			SQLQuery query = session.createSQLQuery(sql);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			list = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	@Override
	public List<Map<String, Object>> findBorrowAll() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> list = null;
		try {

			String sql = " SELECT * " + " FROM equipment ";

			SQLQuery query = session.createSQLQuery(sql);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			list = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public List<Borrow> findBorrowByEquipmentId(String eId){
		Session session = this.sessionFactory.getCurrentSession();
		List<Borrow> list = null;
		try {
			String hql = "from Borrow where equipmentId = :eId"+" ORDER BY date_start DESC";
			//edit on 23/04/20
			// old is //+" ORDER BY date_start DESC";
			Query query = session.createQuery(hql);
			query.setParameter("eId", eId);
			list = query.list();
		} catch (HibernateException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public List<Borrow> findBorrowByEquipmentIdAndStatus(String eId, String bStatus){
		Session session = this.sessionFactory.getCurrentSession();
		List<Borrow> list = null;
		try {
			String hql = "from Borrow where equipmentId = :eId and status = :bStatus";
			Query query = session.createQuery(hql);
			query.setParameter("eId", eId);
			query.setParameter("bStatus", bStatus);
			list = query.list();
		} catch (HibernateException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public List<Borrow> findBorrowByUser(String id){
		Session session = this.sessionFactory.getCurrentSession();
		List<Borrow> list = null;
		try {
			String hql = "from Borrow where userBorrowid = :userBorrowid";
			Query query = session.createQuery(hql);
			query.setParameter("userBorrowid", id);
			list = query.list();
		} catch (HibernateException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public List<Borrow> findBorrowByStatus(String status){
		Session session = this.sessionFactory.getCurrentSession();
		List<Borrow> list = null;
		try {
			String hql = "from Borrow where status = :status";
			Query query = session.createQuery(hql);
			query.setParameter("status", status);
			list = query.list();
		} catch (HibernateException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	 @Override
	  	public List<Map<String, Object>> borrower(String id) throws Exception {
	  		Session session = this.sessionFactory.getCurrentSession();
	  		List<Map<String, Object>> borrower_id = null;
	  		try {
	  			String sql = " SELECT equipment.item_no, equipment.equipment_id, user_borrowid, date_start, date_end FROM equipment LEFT JOIN borrow ON equipment.equipment_id = borrow.equipment_id WHERE equipment.equipment_id = '"+id+"' ORDER BY date_start DESC";
	  			SQLQuery query = session.createSQLQuery(sql);
	  			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
	  			borrower_id = query.list();
	  		} catch (Exception e) {
	  			e.printStackTrace();
	  		}
	  		return borrower_id;
	  	}
	 
	 //getAll 21/4/2020
	 @Override
		public List<Borrow> getAll(){
			Session session = this.sessionFactory.getCurrentSession();
			List<Borrow> list = null;
			try {
				list = session.createCriteria(Borrow.class).list();
			} catch(HibernateException e) {
				e.printStackTrace();
			}
			return list;
		}
	 
	 @Override
	  	public String findlatestborrowbyequipmentid(Integer id) throws Exception {
	  		Session session = this.sessionFactory.getCurrentSession();
	  		String borrow = null;
	  		try {
	  			String sql = "SELECT borrow_id FROM `borrow` where equipment_id = "+id+" ORDER BY `borrow`.`date_start` DESC LIMIT 1";
	  			/*SQLQuery query = session.createSQLQuery(sql);
	  			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);*/
	  			SQLQuery query = session.createSQLQuery(sql);

	  			borrow = query.uniqueResult().toString();
	  			//borrow = query.toString();
	  		} catch (Exception e) {
	  			e.printStackTrace();
	  		}
	  		return borrow;
	  	}

	@Override
	public List<Map<String, Object>> findBorrowWithUserByEquipmentId(String eId) {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> list = new ArrayList<>();
		
		try {
		    String sql = "SELECT b.*, u.employee_id, u.name, u.name_en " +
		                 "FROM borrow b " +
		                 "JOIN user u ON b.user_borrowid = u.id " +
		                 "WHERE b.equipment_id = :eId " +
		                 "ORDER BY b.borrow_id DESC";

		     SQLQuery query = session.createSQLQuery(sql);
		     query.setParameter("eId", eId);
		     List<Object[]> rows = query.list();
		     
		     for (Object[] row : rows) {
		            Map<String, Object> map = new HashMap<>();
		            map.put("borrow_id", row[0]);
		            map.put("borrow_amout", row[1]);
		            map.put("reason", row[2]);
		            map.put("user_borrowid", row[3]);
		            map.put("date_start", row[4]);
		            map.put("date_end", row[5]);
		            map.put("location", row[6]);
		            map.put("contact_addr", row[7]);
		            map.put("status", row[8]);
		            map.put("sum", row[9]);
		            map.put("time_create", row[10]);
		            map.put("user_create", row[11]);
		            map.put("time_update", row[12]);
		            map.put("user_update", row[13]);
		            map.put("equipment_id", row[14]);
		            map.put("remark", row[15]);
		            map.put("reasona", row[16]);
		            map.put("employee_id", row[17]);
		            map.put("name", row[18]);
		            map.put("name_en", row[19]);
		            list.add(map);
		        }
		} catch (HibernateException e) {
		    e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public List<Map<String, Object>> findBorrowWithUserByEquipmentId2(String eId) {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> list = new ArrayList<>();
		
		try {
			String sql = "SELECT " +
				    "b.borrow_id AS borrow_id, " +
				    "b.borrow_amout AS borrow_amout, " +
				    "b.reason AS reason, " +
				    "b.user_borrowid AS user_borrowid, " +
				    "b.date_start AS date_start, " +
				    "b.date_end AS date_end, " +
				    "b.location AS location, " +
				    "b.contact_addr AS contact_addr, " +
				    "b.status AS status, " +
				    "b.sum AS sum, " +
				    "b.time_create AS time_create, " +
				    "b.user_create AS user_create, " +
				    "b.time_update AS time_update, " +
				    "b.user_update AS user_update, " +
				    "b.equipment_id AS equipment_id, " +
				    "b.user_delivery AS user_delivery, " +
				    "b.time_delivery AS time_delivery, " +
				    "b.user_receive AS user_receive, " +
				    "b.time_receive AS time_receive, " +
				    "b.user_return AS user_return, " +
				    "b.time_return AS time_return, " +
				    "b.user_return_receive AS user_return_receive, " +
				    "b.time_return_receive AS time_return_receive, " +
				    "b.remark AS remark, " +
				    "b.reasona AS reasona, " +
				    "u.employee_id AS employee_id, " +
				    "u.name AS name, " +
				    "u.name_en AS name_en " +
				    "FROM borrow b " +
				    "JOIN user u ON b.user_borrowid = u.id " +
				    "WHERE b.equipment_id = :eId " +
				    "ORDER BY b.borrow_id DESC";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("eId", eId);

			query.setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);

			list = query.list();
		} catch (HibernateException e) {
		    e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Map<String, Object>> getBorrowListByUserId(String logonUser) {
		Session session = this.sessionFactory.getCurrentSession();

		List<Map<String, Object>> list = null;
		try {
			String sql = "SELECT b.borrow_id, b.date_start, b.location, b.time_create, b.time_update, b.status, b.user_delivery, b.time_delivery, b.user_receive, b.time_receive, b.user_return, b.time_return, b.user_return_receive, b.time_return_receive, e.equipment_id, e.name, e.item_no, e.type FROM borrow b JOIN equipment e ON b.equipment_id = e.equipment_id WHERE b.user_borrowid = :logonUser";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("logonUser", logonUser);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			list = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
