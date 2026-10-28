package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import com.cubesofttech.model.UserRedeem;

public interface UserRedeemDAO {
	public void save(UserRedeem userRedeem) throws Exception;
	public void update(UserRedeem userRedeem) throws Exception;
	public void delete(UserRedeem userRedeem) throws Exception;
	public UserRedeem findById(Integer userRedeemId) throws Exception;
	public Map<String, Object> findWithReceiveSignatureById(Integer userRedeemId) throws Exception;
	public List<Map<String, Object>> findByUserId(String userId) throws Exception;
	public List<Map<String, Object>> findByItemId(Integer itemId) throws Exception;
	public List<Map<String, Object>> findAll() throws Exception;
}
