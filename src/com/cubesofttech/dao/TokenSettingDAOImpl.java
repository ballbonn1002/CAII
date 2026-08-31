package com.cubesofttech.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.TokenSetting;

@Repository
public class TokenSettingDAOImpl implements TokenSettingDAO {
	
	@Autowired
	SessionFactory sessionFactory;

	@Override
	public void save(TokenSetting setting) throws Exception {
		sessionFactory.getCurrentSession().save(setting);
		sessionFactory.getCurrentSession().flush();
	}

	@Override
	public void update(TokenSetting setting) throws Exception {
		sessionFactory.getCurrentSession().update(setting);
		sessionFactory.getCurrentSession().flush();
	}

	@Override
	public void delete(TokenSetting setting) throws Exception {
		sessionFactory.getCurrentSession().delete(setting);
		sessionFactory.getCurrentSession().flush();
	}

	@Override
	public TokenSetting findById(Integer settingId) throws Exception {
		return sessionFactory.getCurrentSession().get(TokenSetting.class, settingId);
	}

	@Override
	public List<TokenSetting> findAll() throws Exception {
		return sessionFactory.getCurrentSession().createQuery("from TokenSetting").list();
	}

	@Override
	public TokenSetting findByType(String type) throws Exception {
		return (TokenSetting) sessionFactory.getCurrentSession().createQuery("from TokenSetting where type = :type")
				.setParameter("type", type).uniqueResult();
	}

	@Override
	public TokenSetting findByTypeAndTypeName(String type, String typeName) {

	    String hql =
	            "FROM TokenSetting " +
	            "WHERE type = :type " +
	            "AND typeName = :typeName";

	    return (TokenSetting) sessionFactory
	            .getCurrentSession()
	            .createQuery(hql)
	            .setParameter("type", type)
	            .setParameter("typeName", typeName)
	            .uniqueResult();
	}

}
