package com.cubesofttech.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.LeaveUser;

@Repository
public class LeaveUserDAOImpl implements LeaveUserDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public void save(LeaveUser leaveuser) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.save(leaveuser);
		session.flush();
		// session.close();
	}

	@Override
	public List<LeaveUser> findAll() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<LeaveUser> leaveuserList = null;
		try {
			leaveuserList = session.createCriteria(LeaveUser.class).list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return leaveuserList;
	}

	@Override
	public List<LeaveUser> findByLeaveUserId(String leaveuserId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<LeaveUser> leaveuser = null;
		try {
			leaveuser = (List<LeaveUser>) session.get(LeaveUser.class, leaveuserId);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return leaveuser;
	}

	@Override
	public void update(LeaveUser leaveuser) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.clear();
		session.update(leaveuser);
		session.flush();
		// session.close();
	}

	@Override
	public void delete(LeaveUser leaveuser) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.delete(leaveuser);
		session.flush();
		// session.close();
	}

}
