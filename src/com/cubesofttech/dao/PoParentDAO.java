package com.cubesofttech.dao;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import com.cubesofttech.model.PoParent;

public interface PoParentDAO {

	List<PoParent> findAll() throws Exception;
	
	void save(PoParent PoParent) throws Exception;
	
	PoParent findById(Long poParentId) throws Exception;

	Long getMaxId() throws Exception;

	void delete(PoParent PoParent) throws Exception;

	void update(PoParent PoParent) throws Exception;

	List<Map<String, Object>> findPoParentByPoDetailId(String poDetailId) throws Exception;

	void deleteByPoDetailId(String poDetailId) throws Exception;

}