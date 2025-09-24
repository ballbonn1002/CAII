package com.cubesofttech.dao;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.AliasToEntityMapResultTransformer;
import org.jfree.util.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.Holiday;
import com.cubesofttech.util.DateUtil;
import com.google.gson.Gson;
import com.ibm.icu.text.SimpleDateFormat;

@Repository
public class HolidayDAOImpl implements HolidayDAO {

	@Autowired
	private SessionFactory sessionFactory;
	private static final Logger log = Logger.getLogger(HolidayDAOImpl.class);

	@Override
	public Holiday findById(long id_date) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		Holiday holiday = (Holiday) session.get(Holiday.class,id_date);
		return holiday;
	}

	@Override
	public List<Holiday> findAll() throws Exception {
		// TODO Auto-generated method stub
/*		Session session = this.sessionFactory.getCurrentSession();
		Query query = session.createQuery("from Holiday");
		List<Holiday> holiday = (List<Holiday>) query.list();
		return holiday; */
		Session session = this.sessionFactory.getCurrentSession();
		 List<Holiday> HolidayList = null;
		 Timestamp now = DateUtil.getCurrentTime(); // Not Working error getYear() 
		 Calendar cal = Calendar.getInstance(); // Use Calendar .Year
		 int year = cal.get(Calendar.YEAR);
		 
		 
		  try {
		   String sql = "SELECT * FROM holiday WHERE start_date order by start_date ASC; ";
//		   String sql = "SELECT * FROM holiday WHERE start_date LIKE '%"+year+"%' order by start_date ASC; ";
		   SQLQuery query = session.createSQLQuery(sql);
		   query.addEntity(Holiday.class);
		  
		   HolidayList = query.list();
		  } catch (Exception e) {
		   e.printStackTrace();
		  } finally {
		   // session.close();
		  }
		  return HolidayList;
	}
	
	@Override
	public List<Holiday> findByYear(Integer year) throws Exception {
	    Session session = this.sessionFactory.getCurrentSession();
	    List<Holiday> holidayList = null;
	    try {
	        String sql = "SELECT * FROM holiday WHERE YEAR(start_date) = :year ORDER BY start_date ASC";
	        SQLQuery query = session.createSQLQuery(sql);
	        query.addEntity(Holiday.class);
	        query.setParameter("year", year);
	        holidayList = query.list();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return holidayList;
	}
	
	@Override
	public List<Holiday> findAll2years() throws Exception {
		//list holidays last 2 years
	    Session session = this.sessionFactory.getCurrentSession();
	    List<Holiday> holidayList = null;
	    Calendar cal = Calendar.getInstance();
	    int currentYear = cal.get(Calendar.YEAR);
	    int startYear = currentYear - 2;
	    int endYear = currentYear;
	    
	    try {
	        String sql = "SELECT * FROM holiday WHERE YEAR(start_date) BETWEEN :startYear AND :endYear ORDER BY start_date ASC";
	        SQLQuery query = session.createSQLQuery(sql);
	        query.addEntity(Holiday.class);
	        query.setParameter("startYear", startYear);
	        query.setParameter("endYear", endYear);
	        
	        holidayList = query.list();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        // session.close(); 
	    }
	    
	    return holidayList;
	}
	
	@Override
	public List<Holiday> findMonth() throws Exception {
		// TODO Auto-generated method stub
/*		Session session = this.sessionFactory.getCurrentSession();
		Query query = session.createQuery("from Holiday");
		List<Holiday> holiday = (List<Holiday>) query.list();
		return holiday; */
		Session session = this.sessionFactory.getCurrentSession();
		 List<Holiday> HolidayList = null;
		 Timestamp now = DateUtil.getCurrentTime(); // Not Working error getYear() 
		 Calendar cal = Calendar.getInstance(); // Use Calendar .Year
		 int year = cal.get(Calendar.YEAR);
			
		  try {
		   String sql = "SELECT DATE_FORMAT(start_date, '%a, %e') as hday,DATE_FORMAT(start_date, '%c') as month,DATE_FORMAT(start_date, '%Y') as year,head FROM holiday WHERE start_date order by start_date ASC; ";
		   SQLQuery query = session.createSQLQuery(sql);
		   query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
		  
		   HolidayList = query.list();
		  } catch (Exception e) {
		   e.printStackTrace();
		  } finally {
		   // session.close();
		  }
		  return HolidayList;
	}
	
	@Override
	public List<Holiday> findAllHoliday() throws Exception {
		// TODO Auto-generated method stub
/*		Session session = this.sessionFactory.getCurrentSession();
		Query query = session.createQuery("from Holiday");
		List<Holiday> holiday = (List<Holiday>) query.list();
		return holiday; */
		Session session = this.sessionFactory.getCurrentSession();
		 List<Holiday> HolidayList = null;
		 Timestamp now = DateUtil.getCurrentTime(); // Not Working error getYear() 
		 Calendar cal = Calendar.getInstance(); // Use Calendar .Year
		 int year = cal.get(Calendar.YEAR);
		 
			
		  try {
		   String sql = "SELECT * FROM holiday order by start_date ASC; ";
		   SQLQuery query = session.createSQLQuery(sql);
		   query.addEntity(Holiday.class);
		  
		   HolidayList = query.list();
		  } catch (Exception e) {
		   e.printStackTrace();
		  } finally {
		   // session.close();
		  }
		  return HolidayList;
	}

	@Override
	public void save(Holiday holiday) throws Exception {
		// TODO Auto-generated method stub
		Session session = this.sessionFactory.getCurrentSession();
	
		session.save(holiday);
		session.flush();
	}

	@Override
	public void update(Holiday holiday) throws Exception {
		// TODO Auto-generated method stub
		Session session = this.sessionFactory.getCurrentSession();
		session.clear();
		session.update(holiday);
		session.flush();

	}

	@Override
	public void delete(Holiday holiday) throws Exception {
		// TODO Auto-generated method stub
		Session session = this.sessionFactory.getCurrentSession();
		session.delete(holiday);
		session.flush();

	}

	@Override
	public List<Holiday> searchBycolumn(String column, String keyword) throws Exception {
		// TODO Auto-generated method stub
		Session session = this.sessionFactory.getCurrentSession();
		Criteria criteria = session.createCriteria(Holiday.class);
		criteria.add(Restrictions.like(column, "%" + keyword + "%")); 
		return (List<Holiday>) criteria.list();
	}

	@Override
	public List<Map<String, Object>> findByDate(Date keyword) throws Exception {
		// TODO Auto-generated method stub
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> holiday = null;
		try {
			String sql = " SELECT start_date FROM holiday WHERE start_date = :keyword ";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("keyword",keyword);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			holiday = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return holiday;		
	}
	
	@Override
	public List<Map<String, Object>> findByDateStr(String keyword) throws Exception {
		// TODO Auto-generated method stub
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> holiday = null;
		try {
			String sql = " SELECT start_date FROM holiday WHERE start_date = :keyword ";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("keyword",keyword);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			holiday = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return holiday;		
	}
	
	
	@Override
	public List<Map<String, Object>> findAll1() throws Exception{
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> holiday = null;
		try {
			String sql = " SELECT * FROM holiday ";
			SQLQuery query = session.createSQLQuery(sql);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			holiday = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return holiday;
	}
	
	@Override
	public List<Holiday> searchtable(String date) throws Exception {
		
		Session session = this.sessionFactory.getCurrentSession();
		 List<Holiday> HolidayList = null;
		  try {
		   String sql = "SELECT * FROM holiday WHERE start_date LIKE '%"+date+"%' order by start_date ASC; ";
		   SQLQuery query = session.createSQLQuery(sql);
		   query.addEntity(Holiday.class);
		  
		   HolidayList = query.list();
		  } catch (Exception e) {
		   e.printStackTrace();
		  } finally {
		   // session.close();
		  }
		  return HolidayList;

	}

	@Override
	public List<Object> searchallyear() throws Exception { 
		Session session = this.sessionFactory.getCurrentSession();
		 List<Object> holidayList = null;
		  try {
			 
		   String sql = " SELECT  distinct YEAR(start_date) FROM holiday order by YEAR(start_date) desc; ";
		   SQLQuery query = session.createSQLQuery(sql);
		   holidayList = query.list();
		 	
		  } catch (Exception e) {
		   e.printStackTrace();
		  } finally {
		   // session.close();
		  }
		  return holidayList;
	}

	@Override
	public List<Holiday> findByMonth(String keyword) throws Exception { 
		// TODO Auto-generated method stub
		Session session = this.sessionFactory.getCurrentSession();
		List<Holiday> holidayList = null;
		 String date = keyword.substring(3, 10);
		 String datenew = date.substring(3,7) +"-"+ date.substring(0,2);
				
		try {
			String sql = " SELECT * FROM holiday WHERE start_date LIKE '%"+datenew+"%' order by start_date ASC; ";
			SQLQuery query = session.createSQLQuery(sql);
			  query.addEntity(Holiday.class);

       			holidayList = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return holidayList;		
	}

	@Override
	public List<Holiday> protect(Holiday holiday) throws Exception {
	    Session session = this.sessionFactory.getCurrentSession();
	    String sql =
	        "SELECT * FROM holiday " +
	        "WHERE NOT (:endDate < start_date OR :startDate > end_date)";
	    SQLQuery query = session.createSQLQuery(sql);
	    query.addEntity(Holiday.class);
	    query.setParameter("startDate", holiday.getStart_date());
	    query.setParameter("endDate", holiday.getEnd_date());
	    return query.list();
	}

	
	
	
	@Override
	public List<Holiday> protect_edit(Holiday holiday) throws Exception {
	    Session session = this.sessionFactory.getCurrentSession();
	    String sql =
	        "SELECT * FROM holiday " +
	        "WHERE id_date <> :id " +
	        "  AND NOT (:endDate < start_date OR :startDate > end_date)"; // ตรรกะทับช่วงมาตรฐาน

	    SQLQuery query = session.createSQLQuery(sql);
	    query.addEntity(Holiday.class);
	    query.setParameter("id", holiday.getId_date());
	    query.setParameter("startDate", holiday.getStart_date());
	    query.setParameter("endDate", holiday.getEnd_date());

	    return query.list();
	}


	@Override
	public List<Holiday> protect_edit1(Holiday holiday) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Holiday> holidayList = null;			
		try {
			String sql = " SELECT * FROM holiday WHERE start_date <= '"+holiday.getStart_date()+"' and end_date >='"+holiday.getEnd_date()+"' ";
			SQLQuery query = session.createSQLQuery(sql);
			  query.addEntity(Holiday.class);
       			holidayList = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return holidayList;				
	}
	
	
	public List<Holiday> findnext_Year(String keyword) throws Exception {
	
		Session session = this.sessionFactory.getCurrentSession();
		 List<Holiday> HolidayList = null;
					
		  try {
		   String sql = "SELECT * FROM holiday WHERE start_date LIKE '%"+keyword+"%' order by start_date ASC; ";
		   SQLQuery query = session.createSQLQuery(sql);
		   query.addEntity(Holiday.class);
		  
		   HolidayList = query.list();
		  } catch (Exception e) {
		   e.printStackTrace();
		  } finally {
		   // session.close();
		  }
		  return HolidayList;
	}
	
	@Override
	public Long getMaxId() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Holiday> list = null;
		Long maxId;

		try {

			Criteria criteria = session.createCriteria(Holiday.class).setProjection(Projections.max("id_date"));
			maxId = (Long) criteria.uniqueResult();

		} catch (Exception e) {
			e.printStackTrace();
			return new Long(0);

		} finally {

		}
		if (maxId != null) {
			return maxId;
		} else {
			return new Long(0);
		}
	}
	
	@Override
	public List<Holiday> getall() {
		Session session = this.sessionFactory.getCurrentSession();
		List<Holiday> list = null;
		try {
			Criteria cr = session.createCriteria(Holiday.class);
			list = cr.list();
		} catch (HibernateException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public String getallOnlyDateJSON() {
		Session session = this.sessionFactory.getCurrentSession();
		String result = null;
		List<Map<String,String>> list = null;
		try {
			String hql = "select new map(day.start_date as start, day.end_date as end) FROM Holiday day";
			list = session.createQuery(hql).list();
			result = new Gson().toJson(list);
		} catch (HibernateException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@Override
	public List<Map<String, Object>> test_holiday(int year){
	Session session = this.sessionFactory.getCurrentSession();
	List<Map<String, Object>> test_holiday = null;
	try {

	String sql = "SELECT head, start_date,end_date,DAY(start_date)AS daystart ,MONTH(start_date)AS monthstart  ,DAY(end_date)AS dayend ,MONTH(end_date) AS monthend FROM `holiday` WHERE YEAR(start_date)= "+ year +" ORDER BY start_date" ;

	SQLQuery query = session.createSQLQuery(sql);
	query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
	test_holiday = query.list();
	} catch (Exception e) {
	e.printStackTrace();
	}
	return test_holiday;
	}
	
	
	@Override
	public List<Map<String, Object>> findHolidayMonth(String month,String year) {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> holidayList = null;

		try {
			String sql = "SELECT * FROM holiday WHERE YEAR(holiday.start_date)=:year AND MONTH(holiday.start_date)=:month" ;
			
		
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("month", month);
			query.setParameter("year", year);
			
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			holidayList = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return holidayList;
	}

	@Override
	public List<Map<String, Object>> count_hoilday(String start_mouth, String today) {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> count_h = null;
		try {
			String sql = "SELECT start_date, end_date FROM holiday WHERE start_date BETWEEN :start_mouth AND :today";
			
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("start_mouth", start_mouth);
			query.setParameter("today", today);
			
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			count_h = query.list();
		}catch (Exception e) {
			// TODO: handle exception
		}
		return count_h;
	}
	@Override
	public List<Map<String, Object>> countHoildayByDatepicker(Timestamp startdate, Timestamp enddate) {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> count_h = null;
		try {
			String sql = " SELECT SUM(DATEDIFF(end_date, start_date) + 1) AS total_holiday\r\n"
					+ "  FROM holiday\r\n"
					+ "  WHERE start_date >= '"+startdate+"'\r\n"
					+ "    AND end_date <= '"+enddate+"'\r\n";
			
			SQLQuery query = session.createSQLQuery(sql);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			count_h = query.list();
			Log.debug(count_h);
		}catch (Exception e) {
			// TODO: handle exception
		}
		return count_h;
	}
	@Override
	public List<Map<String, Object>> listHoildayByDatepicker(Timestamp startdate, Timestamp enddate) {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> list = null;
		try {
			String sql = " SELECT start_date , end_date\r\n"
					+ "  FROM holiday\r\n"
					+ "  WHERE (start_date BETWEEN '" + startdate + "' AND '" + enddate + "') \r\n"
					+ "  AND (end_date BETWEEN '" + startdate + "' AND '" + enddate + "'); \r\n";
			
			SQLQuery query = session.createSQLQuery(sql);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			list = query.list();
			Log.debug(list);
		}catch (Exception e) {
			// TODO: handle exception
		}
		return list;
	}
}
