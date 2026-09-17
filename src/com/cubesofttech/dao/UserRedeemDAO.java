package com.cubesofttech.dao;

import java.util.List;

import com.cubesofttech.model.UserRedeem;

public interface UserRedeemDAO {
	public void save(UserRedeem userRedeem) throws Exception;
	public void update(UserRedeem userRedeem) throws Exception;
	public void delete(UserRedeem userRedeem) throws Exception;
	public UserRedeem findById(Integer userRedeemId) throws Exception;
	public List<UserRedeem> findAll() throws Exception;
}
