package com.cubesofttech.dao;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import com.cubesofttech.model.PoDetail;

public interface PoDetailDAO {

	List<PoDetail> findAll() throws Exception;
	
	void save(PoDetail PoDetail) throws Exception;
	
	PoDetail findById(String poDetailId) throws Exception;

	Long getMaxId() throws Exception;

	void delete(PoDetail PoDetail) throws Exception;

	void update(PoDetail PoDetail) throws Exception;

	List<Map<String, Object>> findPoDetailByPoId(String poId) throws Exception;

	void deleteByPoIdAndPoDetailId(String poDetailId, String poId) throws Exception;

	double getTotalByPoId(String poId) throws Exception;

}