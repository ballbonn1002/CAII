package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import com.cubesofttech.model.LeaveUser;

public interface LeaveUserDAO {

	public void save(LeaveUser leaveuser) throws Exception;

	public List<LeaveUser> findAll() throws Exception;

	public List<LeaveUser> findByLeaveUserId(String leaveuserId) throws Exception;

	public void update(LeaveUser leaveuser) throws Exception;

	public void delete(LeaveUser leaveuser) throws Exception;

	

}