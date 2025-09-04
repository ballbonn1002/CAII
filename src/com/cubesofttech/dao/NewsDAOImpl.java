package com.cubesofttech.dao;

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

import com.cubesofttech.model.News;

@Repository
public class NewsDAOImpl implements NewsDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public void save(News News) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.save(News);
		session.flush();
		// session.close();
	}

	@Override
	public List<News> findAll() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<News> newsList = null;
		try {
			newsList = session.createCriteria(News.class).list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return newsList;
	}

	@Override
	public News findById(int newId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		News News = null;
		try {
			News = (News) session.get(News.class, newId);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return News;
	}

	@Override
	public void update(News News) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.clear();
		session.update(News);
		session.flush();
		// session.close();
	}

	@Override
	public void delete(News News) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.delete(News);
		session.flush();
		// session.close();
	}

	@Override
	public Integer getMaxId() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<News> list = null;
		Integer maxId;

		try {

			Criteria criteria = session.createCriteria(News.class).setProjection(Projections.max("newsId"));
			maxId = (Integer) criteria.uniqueResult();

		} catch (Exception e) {
			e.printStackTrace();
			return new Integer(0);

		} finally {

		}
		if (maxId != null) {
			return maxId;
		} else {
			return new Integer(0);
		}
	}

	@Override
	public List<Map<String, Object>> listnews(int moreLimit) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> news_feed = null;
		try {

			String sql = "SELECT  news.file_id,news.news_head,news.news_description,news.user_create,news.time_create,file.path,file.name,file.type,user.path AS userprofile, "
					+ " (SELECT COUNT(news.news_id) FROM news) AS allnews " + " FROM news LEFT JOIN file "
					+ " ON news.file_id = file.file_id " + " LEFT JOIN user " + " ON news.user_create = user.id "
					+ " ORDER BY news_id DESC " + " LIMIT :moreLimit";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("moreLimit", moreLimit);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			news_feed = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return news_feed;
	}

	@Override
	public List<Map<String, Object>> dashboardNews() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> news_feed = null;
		try {

			String sql = "SELECT news.file_id,news.news_head,news.news_description,news.user_create,news.time_create,file.path,file.name,file.type "
					+ "FROM news LEFT JOIN file " + "ON news.file_id = file.file_id " + "ORDER BY news_id DESC "
					+ "LIMIT 1 ";

			SQLQuery query = session.createSQLQuery(sql);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			news_feed = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return news_feed;
	}

	@Override
	public List<Map<String, Object>> mynews(String user) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> news_feed = null;
		try {

			String sql = "SELECT news.news_id,news.file_id,news.news_head,news.news_description,news.user_create,news.time_create,file.path,file.name,file.type "
					+ "FROM news " + "LEFT JOIN file " + "ON news.file_id = file.file_id "
					+ "WHERE news.user_create =:user ";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("user", user);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			news_feed = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return news_feed;
	}

	@Override
	public List<Map<String, Object>> find_filepath(int fileId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> news_feed = null;
		try {

			String sql = "SELECT path FROM file " + "WHERE file_id =:fileId ";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("fileId", fileId);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			news_feed = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return news_feed;
	}

	@Override
	public List<Map<String, Object>> sumtravelPrice(String user) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> news_feed = null;
		try {
//        	
//        	String sql= "SELECT (SUM(total_amount),'#,##') as price,MONTH(time_update) AS mymonth,YEAR(time_update) AS myyear,COUNT(expense_group_id) AS mybill "
//          			 +"FROM expense_group "
//           			 +"WHERE status_id = 'w' "
//                     +"GROUP BY MONTH(time_update) "
//           			 +"ORDER by time_update DESC LIMIT 1";
			String sql = "SELECT SUM(total_amount)as price  " + "FROM expense_group "
					+ "WHERE status_id = 'w' ,user_create = :user";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("user", user);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			news_feed = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return news_feed;
	}

	@Override
	public List<Map<String, Object>> mostcometoWork() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> news_feed = null;
		try {
			String sql = "SELECT COUNT(work_hours_id) " + " FROM work_hours " + " WHERE work_hours_type = '1' ";

			SQLQuery query = session.createSQLQuery(sql);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			news_feed = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return news_feed;
	}

	@Override
	public List<Map<String, Object>> sumItem() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> news_feed = null;
		try {
			String sql = "SELECT (Select COUNT(equipment_id) as allitem FROM equipment WHERE status = 'B') AS borrowitem, "
					+ " (Select COUNT(equipment_id) as allitem FROM equipment WHERE NOT status = 'Z') AS  allitem, "
					+ " (Select COUNT(equipment_id) as allitem FROM equipment WHERE status = 'B')*100 "
					+ " /(Select COUNT(equipment_id) as allitem FROM equipment WHERE NOT status = 'Z') AS persentage ";
			SQLQuery query = session.createSQLQuery(sql);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			news_feed = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return news_feed;
	}

	@Override
	public List<Map<String, Object>> totallyleaves(String user, int thisyear) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> news_feed = null;
		try {

			String sql = " SELECT (user.leave_quota_1) - SUM(leaves.no_day) AS totally, "
					+ " FORMAT(((user.leave_quota_1)-(leaves.no_day)) * 100 / (user.leave_quota_1),'#,##0.00') AS persentage, "
					+ " user.id, " + " YEAR(leaves.time_create) AS yearNow " + " FROM user "
					+ " LEFT JOIN leaves ON user.id = leaves.user_create "
					+ " WHERE leaves.user_create =:user AND YEAR(leaves.time_create) =:thisyear "
					+ " GROUP BY YEAR(leaves.time_create) , leaves.no_day  ";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("user", user);
			query.setParameter("thisyear", thisyear);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			news_feed = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return news_feed;
	}

	@Override
	public List<Map<String, Object>> totaltravel(String user) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> news_feed = null;
		try {

			String sql = "SELECT  COUNT(expense_group_id) AS mybill  FROM expense_group "
					+ " WHERE user_create =:user AND status_id = 'w' ";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("user", user);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			news_feed = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return news_feed;
	}

	@Override
	public List<Map<String, Object>> obtainTravel(String user) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> news_feed = null;
		try {

			String sql = "SELECT SUM(total_amount) AS amount FROM expense_group "
					+ " WHERE user_create =:user AND status_id = 'p' ";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("user", user);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			news_feed = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return news_feed;
	}

	@Override
	public List<Map<String, Object>> sumtravelPrice() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> news_feed = null;
		try {
//	        	
//	        	String sql= "SELECT (SUM(total_amount),'#,##') as price,MONTH(time_update) AS mymonth,YEAR(time_update) AS myyear,COUNT(expense_group_id) AS mybill "
//	          			 +"FROM expense_group "
//	           			 +"WHERE status_id = 'w' "
//	                     +"GROUP BY MONTH(time_update) "
//	           			 +"ORDER by time_update DESC LIMIT 1";
			String sql = "SELECT SUM(total_amount)as price  " + "FROM expense_group " + "WHERE status_id = 'w'";

			SQLQuery query = session.createSQLQuery(sql);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			news_feed = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return news_feed;
	}

	@Override
	public List<Map<String, Object>> searchUserLeave(String user, String monthnow, String yearnow) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> sul = null;

		try {
			String sql1 = "SELECT * FROM leaves WHERE leaves.user_id=:user AND YEAR(start_date)=:year AND MONTH(start_date)=:month AND 	leave_status_id='1'";
			SQLQuery query = session.createSQLQuery(sql1);
			query.setParameter("user", user);
			query.setParameter("year", yearnow);
			query.setParameter("month", monthnow);

			// String sql = "SELECT timesheet.user_create ,
			// project.project_name,timesheet.time_check_in FROM timesheet INNER JOIN
			// project ON timesheet.project_id = project.project_id WHERE
			// timesheet.user_create='rungtrakul.r'";

//			query.setParameter("year", year);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			sul = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return sul;
	}

	@Override
	public List<Map<String, Object>> finduserLate(String logonUser, String monthnow, String yearnow, String atimeaaa)
			throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> userlate = null;
//		System.out.println("DAO "+ atimeaaa);
		try {
			String sql1 = "SELECT * FROM work_hours WHERE  DATE_FORMAT(work_hours_time_work, '%T')>:atimea AND work_hours_type='1' AND user_create =:user AND YEAR(work_hours_time_work)=:year AND MONTH(work_hours_time_work)=:month";
			SQLQuery query = session.createSQLQuery(sql1);
			query.setParameter("atimea", atimeaaa);
			query.setParameter("month", monthnow);
			query.setParameter("year", yearnow);
			query.setParameter("user", logonUser);
//			query.setParameter("user", user);

//			query.setParameter("year", year);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			userlate = query.list();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return userlate;
	}

	
	@Override
	public List<Map<String, Object>> checkin(String logonUsers,String monthnow,String yearnow)
			throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> userlate = null;

		try {
			String sql1 = "SELECT DISTINCT DATE_FORMAT(work_hours_time_work,'%d/%m/%Y') as fulldate ,user_create,DATE_FORMAT(work_hours_time_work,'%r') as timework  FROM `work_hours` WHERE `user_create` =:user AND YEAR(`work_hours_time_work`) =:year AND MONTH(`work_hours_time_work`) =:month AND `work_hours_type` =1";
			SQLQuery query = session.createSQLQuery(sql1);
			query.setParameter("user", logonUsers);

			query.setParameter("month", monthnow);
			query.setParameter("year", yearnow);
		
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			userlate = query.list();
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userlate;
	}
	@Override
	public List<Map<String, Object>> checkout(String logonUsers,String monthnow,String yearnow)
			throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> userlate = null;

		try {
			String sql1 = "SELECT DISTINCT DATE_FORMAT(work_hours_time_work,'%d/%m/%Y') as fulldate ,user_create,DATE_FORMAT(work_hours_time_work,'%r') as timework  FROM `work_hours` WHERE `user_create` =:user AND YEAR(`work_hours_time_work`) =:year AND MONTH(`work_hours_time_work`) =:month AND `work_hours_type` =2";
			SQLQuery query = session.createSQLQuery(sql1);
			
			query.setParameter("user", logonUsers);

			query.setParameter("month", monthnow);
			query.setParameter("year", yearnow);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			userlate = query.list();
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userlate;
	}
	@Override
	public List<Map<String, Object>> leves(String logonUsers,String monthnow,String yearnow)
			throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> userlate = null;

		try {
			String sql1 = "SELECT `user_id` as user_create  , DATE_FORMAT(`start_date`,'%d/%m/%Y') as fulldate ,no_day  FROM leaves WHERE `user_id`=:user AND YEAR(`start_date`) =:year AND MONTH(`start_date`) =:month ";
			SQLQuery query = session.createSQLQuery(sql1);
			query.setParameter("user", logonUsers);

			query.setParameter("month", monthnow);
			query.setParameter("year", yearnow);


			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			userlate = query.list();
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userlate;
	}
	@Override
	public List<Map<String, Object>> timelinesearch(String logonUsers,String monthnow,String yearnow)
			throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> userlate = null;

		try {
			String sql1 = "SELECT DISTINCT`user_create` ,DATE_FORMAT(work_hours_time_work,'%d %M %Y : %r') as fulldate , DATE_FORMAT(`work_hours_time_work`,'%d %b') as shortdate ,DATE_FORMAT(`work_hours_time_work`,'%d/%m/%Y') as date  FROM `work_hours` WHERE `user_create` =:user AND YEAR(`work_hours_time_work`) =:year AND MONTH(`work_hours_time_work`) =:month AND `work_hours_type` = 1";
			SQLQuery query = session.createSQLQuery(sql1);
			

		query.setParameter("user", logonUsers);

			query.setParameter("month", monthnow);
			query.setParameter("year", yearnow);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			userlate = query.list();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userlate;
	}
	@Override
	public List<Map<String, Object>> tilmelinefirstsearch(String logonUsers,String monthnow,String yearnow)
			throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> userlate = null;

		try {
			String sql1 = "SELECT DISTINCT`user_create` ,DATE_FORMAT(work_hours_time_work,'%d %M %Y : %r') as fulldate , DATE_FORMAT(`work_hours_time_work`,'%d %b') as shortdate ,DATE_FORMAT(`work_hours_time_work`,'%d/%m/%Y') as date  FROM `work_hours` WHERE `user_create` =:user AND YEAR(`work_hours_time_work`) =:year AND MONTH(`work_hours_time_work`) =:month AND `work_hours_type` = 1 limit 1";
			SQLQuery query = session.createSQLQuery(sql1);
			

		query.setParameter("user", logonUsers);
			query.setParameter("month", monthnow);
			query.setParameter("year", yearnow);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			userlate = query.list();
	
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userlate;
	}
	@Override
	public List<Map<String, Object>> lastcheck(String user) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> work_status = null;
		try {

			String sql = "SELECT work_hours_type as status, DATE_FORMAT(work_hours_time_work, '%d %b %Y %H:%i') as lastcheck FROM work_hours "
					+ " WHERE user_create =:user ORDER BY work_hours_time_work DESC";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("user", user);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			work_status = query.list();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return work_status;
	}
	@Override
	public List<Map<String, Object>> borrow(String user) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> work_status = null;
		try {

			String sql = "SELECT SUM(borrow_amout) as amount" + " FROM borrow "
					+ " WHERE user_borrowid =:user ";

			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("user", user);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			work_status = query.list();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return work_status;
	}
}
