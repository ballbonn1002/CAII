package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import org.hibernate.SessionFactory;
import org.hibernate.transform.AliasToEntityMapResultTransformer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.TokenMonthlyLogDetail;

@Repository
public class TokenMonthlyLogDAOImpl implements TokenMonthlyLogDetailDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public void save(TokenMonthlyLogDetail detail) throws Exception {
		sessionFactory.getCurrentSession().save(detail);
		sessionFactory.getCurrentSession().flush();
	}

	@Override
	public void update(TokenMonthlyLogDetail detail) throws Exception {
		sessionFactory.getCurrentSession().update(detail);
		sessionFactory.getCurrentSession().flush();
	}

	@Override
	public void delete(TokenMonthlyLogDetail detail) throws Exception {
		sessionFactory.getCurrentSession().delete(detail);
		sessionFactory.getCurrentSession().flush();
	}

	@Override
	public TokenMonthlyLogDetail findById(Integer tokenLogId) throws Exception {
		return sessionFactory.getCurrentSession().get(TokenMonthlyLogDetail.class, tokenLogId);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<TokenMonthlyLogDetail> findAll() throws Exception {
		return sessionFactory.getCurrentSession().createQuery("from TokenMonthlyLogDetail").list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String, Object>> findByMonitorLogId(Integer monitorLogId) throws Exception {

	    String hql = "select "
	            + "d.tokenLogId as tokenLogId, "
	            + "d.monitorLogId as monitorLogId, "
	            + "d.userId as userId, "
	            + "d.dateTime as dateTime, "
	            + "d.value as value, "
	            + "d.status as status, "
	            + "d.description as description, "
	            + "u.employeeId as employeeId, "
	            + "u.name as nameTh, "
	            + "u.nameEN as nameEn, "
	            + "u.path as filePath "
	            + "from TokenMonthlyLogDetail d "
	            + "left join User u on d.userId = u.id "
	            + "where d.monitorLogId = :monitorLogId";
	    

	    return sessionFactory.getCurrentSession()
	            .createQuery(hql)
	            .setParameter("monitorLogId", monitorLogId)
	            .setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE).list();
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<TokenMonthlyLogDetail> findFailedByMonitorLogId(Integer monitorLogId) throws Exception {

	    return sessionFactory.getCurrentSession()
	            .createQuery(
	                "from TokenMonthlyLogDetail " +
	                "where monitorLogId = :monitorLogId " +
	                "and status = :status"
	            )
	            .setParameter("monitorLogId", monitorLogId)
	            .setParameter("status", "failed")
	            .list();
	}

}
