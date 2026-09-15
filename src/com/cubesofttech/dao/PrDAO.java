package com.cubesofttech.dao;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import com.cubesofttech.model.Pr;

public interface PrDAO {

	List<Pr> findAll() throws Exception;
	
	void save(Pr Pr) throws Exception;

	Long getMaxId() throws Exception;

	void delete(Pr Pr) throws Exception;

	void update(Pr Pr) throws Exception;

	List<Map<String, Object>> findAllPrWithUser() throws Exception;

	Map<String, Object> findPrById(String prId) throws Exception;

	Pr findById(String prId) throws Exception;

	String findMaxPrIdByYear(String prefix) throws Exception;

}