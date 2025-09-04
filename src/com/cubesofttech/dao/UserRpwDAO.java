package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import com.cubesofttech.model.UserRpw;

public interface UserRpwDAO {
	public UserRpw findById(Integer id) throws Exception;
	
	public UserRpw findByUserId(String user_id) throws Exception;
	
	public UserRpw findByUserKey(String user_key) throws Exception;

	public List<Map<String, Object>> findAll() throws Exception;

	public void save(UserRpw u) throws Exception;

	public void update(UserRpw u) throws Exception;

	public void delete(UserRpw u) throws Exception;

	public List<Map<String, Object>> searchBycolumn(String column, String keyword) throws Exception;
}
