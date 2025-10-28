package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import com.cubesofttech.model.LeaveType;


public interface LeaveTypeDAO {

	public void save(LeaveType leavetype) throws Exception;

	public List<LeaveType> findAll() throws Exception;

	public List<LeaveType> findByLeaveTypeId(String leave_type_id) throws Exception;

	public List<LeaveType> findByLeaveTypeId2(String leave_type_id) throws Exception;

	public void update(LeaveType leavetype) throws Exception;

	public void delete(LeaveType leavetype) throws Exception;

	public List<LeaveType> findAll2() throws Exception;
	
	public List<Map<String, Object>> findAllList() throws Exception;
	
	public  List<LeaveType> findAll_calendar() throws Exception;

	public List<LeaveType> searchtable(String user) throws Exception;

	public List<Object> searchalluser() throws Exception;

	public LeaveType findById(String leave_type_id) throws Exception;
	
	public List<Map<String, Object>> findById2(String keyword) throws Exception; //SELECT leave_type_id FROM leave_type WHERE leave_type_id = :keyword
	
	public List<Map<String, Object>> findByName(String keyword) throws Exception;

	public String getForDisplayJSON();
	
	public List<Map<String, Object>> idtoname(String keyword) throws Exception;
}