package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import com.cubesofttech.model.LogAction;

public interface LogActionDAO {

	public void save(LogAction logAction) throws Exception;
	
	public void update(LogAction logAction) throws Exception;
	
	public void delete(LogAction logAction) throws Exception;
	
	public Integer getMaxId() throws Exception;
	
	public LogAction findById(Integer log_action_id) throws Exception;
	
	public List<Map<String, Object>> findByUserAndDate(String user, String date) throws Exception;
	
	public void delete2YearLogs() throws Exception;

	/**
	 * ค้นหา action log ตาม userId (null = ทุก user) และช่วงวันที่ startDate/endDate (yyyy-MM-dd)
	 */
	public List<Map<String, Object>> search(String userId, String startDate, String endDate) throws Exception;
	
}
