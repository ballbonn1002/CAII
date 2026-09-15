package com.cubesofttech.dao;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import com.cubesofttech.model.PrParent;

public interface PrParentDAO {

	List<PrParent> findAll() throws Exception;
	
	void save(PrParent PrParent) throws Exception;
	
	PrParent findById(Long prParentId) throws Exception;

	Long getMaxId() throws Exception;

	void delete(PrParent PrParent) throws Exception;

	void update(PrParent PrParent) throws Exception;

	List<Map<String, Object>> findPrParentByPrDetailId(String prDetailId) throws Exception;

	void deleteByPrDetailId(String prDetailId) throws Exception;

}