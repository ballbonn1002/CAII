package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.AliasToEntityMapResultTransformer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.UserRpw;

@Repository
public class UserRpwDAOImpl implements UserRpwDAO {

	@Autowired
	private SessionFactory sessionFactory;
	
	@Override
	public UserRpw findById(Integer id) throws Exception {

		Session session = this.sessionFactory.getCurrentSession();
		UserRpw userrpwid = (UserRpw) session.get(UserRpw.class, id);

		return userrpwid;
	}
	
	@Override
	public UserRpw findByUserId(String user_id) throws Exception {
		UserRpw result = null;
		Session session = this.sessionFactory.getCurrentSession();
		Criteria cr = session.createCriteria(UserRpw.class);
		cr.add(Restrictions.eq("user_id", user_id));
		List results = cr.list();
		if (!results.isEmpty()) {
			result = (UserRpw) results.get(0);
			return result;
		} else {
			return null;
		}
	}

	@Override
	public UserRpw findByUserKey(String user_key) throws Exception {
		UserRpw result = null;
		Session session = this.sessionFactory.getCurrentSession();
		Criteria cr = session.createCriteria(UserRpw.class);
		cr.add(Restrictions.eq("user_key", user_key));
		List results = cr.list();
		if (!results.isEmpty()) {
			result = (UserRpw) results.get(0);
			return result;
		} else {
			return null;
		}
	}
	
	@Override
	public List<Map<String, Object>> findAll() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();

		List<Map<String, Object>> faqJoin = null;
		try {
			String sql = "SELECT * FROM user_rpw";

			// System.out.println("SQL: " + sql);
			SQLQuery query = session.createSQLQuery(sql);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			faqJoin = query.list();
		} catch (Exception e) {
			// Log.debug("Method findAll in [FaqDAOImpl] Error!");
			e.printStackTrace();
		}
		return faqJoin;
	}

	@Override
	public void save(UserRpw u) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.save(u);
		session.flush();
		
	}

	@Override
	public void update(UserRpw userrpw) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.update(userrpw);
		session.flush();
		
	}

	@Override
	public void delete(UserRpw userrpw) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.delete(userrpw);
		session.flush();
		
	}

	@Override
	public List<Map<String, Object>> searchBycolumn(String column, String keyword) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
}
