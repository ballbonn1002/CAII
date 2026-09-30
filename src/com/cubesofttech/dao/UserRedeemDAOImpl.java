package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import org.hibernate.SessionFactory;
import org.hibernate.transform.AliasToEntityMapResultTransformer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.UserRedeem;

@Repository
public class UserRedeemDAOImpl implements UserRedeemDAO {
	
	@Autowired
	SessionFactory sessionFactory;

	@Override
	public void save(UserRedeem userRedeem) throws Exception {
		sessionFactory.getCurrentSession().save(userRedeem);
		sessionFactory.getCurrentSession().flush();
	}

	@Override
	public void update(UserRedeem userRedeem) throws Exception {
		sessionFactory.getCurrentSession().update(userRedeem);
		sessionFactory.getCurrentSession().flush();
	}

	@Override
	public void delete(UserRedeem userRedeem) throws Exception {
		sessionFactory.getCurrentSession().delete(userRedeem);
		sessionFactory.getCurrentSession().flush();
	}

	@Override
	public UserRedeem findById(Integer userRedeemId) throws Exception {
		return sessionFactory.getCurrentSession().get(UserRedeem.class, userRedeemId);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public Map<String, Object> findWithReceiveSignatureById(Integer userRedeemId) throws Exception {
		
		String sql =
	            "SELECT " +
	            "    ur.user_redeem_id AS userRedeemId, " +
	            "    ur.user_id AS userId, " +
	            "    ur.item_id AS itemId, " +
	            "    ur.token AS token, " +
	            "    ur.cash AS cash, " +
	            "    ur.redeem_status AS redeemStatus, " +
	            "    ur.status_log AS statusLog, " +
	            "    ur.description AS description, " +
	            "    ur.user_create AS userCreate, " +
	            "    ur.user_update AS userUpdate, " +
	            "    ur.time_create AS timeCreate, " +
	            "    ur.time_update AS timeUpdate, " +
	            "    ur.user_approve AS userApprove, " +
	            "    ur.time_approve AS timeApprove, " +
	            "    ur.user_deliver AS userDeliver, " +
	            "    ur.time_deliver AS timeDeliver, " +
	            "    ur.time_receive AS timeReceive, " +
	            "    ur.user_receive AS userReceive, " +
	            "    u.path_signature AS signaturePath " +
	            "FROM user_redeem ur " +
	            "LEFT JOIN user u ON ur.user_receive = u.id " +
	            "WHERE ur.user_redeem_id = :userRedeemId";
				
		
		return (Map<String, Object>) sessionFactory.getCurrentSession()
				.createSQLQuery(sql)
				.setParameter("userRedeemId", userRedeemId)
				.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE)
				.uniqueResult();
		
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> findAll() throws Exception {

	    String sql =
	            "SELECT " +
	            "    u.id AS userId, " +
	            "    u.employee_id AS employeeId, " +
	            "    u.name AS nameTh, " +
	            "    u.name_en AS nameEn, " +
	            "    u.path as filePath, " + 
	            "    ur.user_redeem_id AS userRedeemId, " +
	            "    ur.item_id AS itemId, " +
	            "	 ip.item_name AS itemName, " +
	            "    ur.token AS token, " +
	            "    ur.cash AS cash, " +
	            "    ur.redeem_status AS redeemStatusCode, " + 
	            "    ds.status_name AS redeemStatus, " +
	            "    ds.color AS statusColor, " +
	            "    ur.description AS description, " +
	            "    ur.user_create AS userCreate, " +
	            "    ur.time_create AS timeCreate " +
	            "FROM user u " +
	            "JOIN user_redeem ur " +
	            "    ON u.id = ur.user_id " +
	            "JOIN item_privilege ip " +
	            "    ON ur.item_id = ip.item_id " +
	            "LEFT JOIN doc_status ds " +
	            "	ON ur.redeem_status = ds.status_code AND ds.page = 'cube token' " +
	            "ORDER BY ur.time_create DESC";

	    return sessionFactory.getCurrentSession()
	            .createSQLQuery(sql)
	            .setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE)
	            .list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String, Object>> findByUserId(String userId) throws Exception {

		 String sql =
		            "SELECT " +
		            "    u.id AS userId, " +
		            "    u.employee_id AS employeeId, " +
		            "    u.name AS nameTh, " +
		            "    u.name_en AS nameEn, " +
		            "    u.path AS filePath, " + 
		            "    ur.user_redeem_id AS userRedeemId, " +
		            "    ur.item_id AS itemId, " +
		            "    ur.redeem_status AS redeemStatusCode, " +
		            "	 ip.item_name AS itemName, " +
		            "    ur.token AS token, " +
		            "    ur.cash AS cash, " +
		            "    ds.status_name AS redeemStatus, " +
		            "    ds.color AS statusColor, " +
		            "    ur.description AS description, " +
		            "    ur.user_create AS userCreate, " +
		            "    ur.time_create AS timeCreate " +
		            "FROM user u " +
		            "JOIN user_redeem ur " +
		            "    ON u.id = ur.user_id " +
		            "JOIN item_privilege ip " +
		            "    ON ur.item_id = ip.item_id " +
		            "LEFT JOIN doc_status ds " +
		            "	ON ur.redeem_status = ds.status_code AND ds.page = 'cube token' " +
		            "WHERE u.id = :userId " +
		            "ORDER BY ur.time_create DESC";

	    return sessionFactory.getCurrentSession()
	            .createSQLQuery(sql)
	            .setParameter("userId", userId)
	            .setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE)
	            .list();
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> findByItemId(Integer itemId) throws Exception {

	    String sql =
	            "SELECT " +
	            "    u.id AS userId, " +
	            "    u.employee_id AS employeeId, " +
	            "    u.name AS nameTh, " +
	            "    u.name_en AS nameEn, " +
	            "    u.path as filePath, " + 
	            "    ur.user_redeem_id AS userRedeemId, " +
	            "    ur.item_id AS itemId, " +
	            "	 ip.item_name AS itemName, " +
	            "    ur.token AS token, " +
	            "    ur.cash AS cash, " +
	            "    ds.status_name AS redeemStatus, " +
	            "    ds.color AS statusColor, " +
	            "    ur.description AS description, " +
	            "    ur.user_create AS userCreate, " +
	            "    ur.time_create AS timeCreate, " +
	            "    ur.user_deliver AS userDeliver, " +
	            "    ur.time_deliver AS timeDeliver " +
	            "FROM user u " +
	            "JOIN user_redeem ur " +
	            "    ON u.id = ur.user_id " +
	            "JOIN item_privilege ip " +
	            "    ON ur.item_id = ip.item_id " +
	            "LEFT JOIN doc_status ds " +
	            "	ON ur.redeem_status = ds.status_code AND ds.page = 'cube token' " +
	            "WHERE ur.item_id = :itemId " +
	            "ORDER BY ur.time_create DESC";

	    return sessionFactory.getCurrentSession()
	            .createSQLQuery(sql)
	            .setParameter("itemId", itemId)
	            .setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE)
	            .list();
	}

}
