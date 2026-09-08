package com.cubesofttech.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.ItemPrivilege;

@Repository
public class ItemPrivilegeDAOImpl implements ItemPrivilegeDAO {
	

	@Autowired
	SessionFactory sessionFactory;
	
	@Override
	public void save(ItemPrivilege itemPrivilege) throws Exception {
		sessionFactory.getCurrentSession().save(itemPrivilege);
		sessionFactory.getCurrentSession().flush();
	}

	@Override
	public void update(ItemPrivilege itemPrivilege) throws Exception {
		sessionFactory.getCurrentSession().update(itemPrivilege);
		sessionFactory.getCurrentSession().flush();
	}

	@Override
	public void delete(ItemPrivilege itemPrivilege) throws Exception {
		sessionFactory.getCurrentSession().delete(itemPrivilege);
		sessionFactory.getCurrentSession().flush();
	}

	@Override
	public ItemPrivilege findById(Integer itemId) throws Exception {
		return sessionFactory.getCurrentSession().get(ItemPrivilege.class, itemId);
	}

	@Override
	public List<ItemPrivilege> findAll() throws Exception {
		return sessionFactory.getCurrentSession().createQuery("from ItemPrivilege").list();
	}

}
