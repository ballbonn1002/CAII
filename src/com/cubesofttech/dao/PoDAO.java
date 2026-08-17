package com.cubesofttech.dao;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import com.cubesofttech.model.Po;

public interface PoDAO {

	List<Po> findAll() throws Exception;
	
	void save(Po Po) throws Exception;
	
//	Po findById(Long poId) throws Exception;

	Long getMaxId() throws Exception;

	void delete(Po Po) throws Exception;

	void update(Po Po) throws Exception;

	List<Map<String, Object>> findAllPoWithUser() throws Exception;

	Map<String, Object> findPoById(String poId) throws Exception;

	Po findById(String poId) throws Exception;

	String findMaxPoIdByYear(String prefix) throws Exception;

	

}