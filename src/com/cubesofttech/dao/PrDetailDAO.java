package com.cubesofttech.dao;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import com.cubesofttech.model.PrDetail;

public interface PrDetailDAO {

	List<PrDetail> findAll() throws Exception;
	
	void save(PrDetail PrDetail) throws Exception;
	
	PrDetail findById(String prDetailId) throws Exception;

	Long getMaxId() throws Exception;

	void delete(PrDetail PrDetail) throws Exception;

	void update(PrDetail PrDetail) throws Exception;

	List<Map<String, Object>> findPrDetailByPrId(String prId) throws Exception;

	void deleteByPrIdAndPrDetailId(String prDetailId, String prId) throws Exception;

	double getTotalByPrId(String prId) throws Exception;

	List<Map<String, Object>> findInprogressPrDetailForPrSearch() throws Exception;

	void markPulled(List<String> prDetailIds) throws Exception;

	void revertPulledStatusByPrProduct(String prId, String productId) throws Exception;

	Map<String, Integer[]> countPrDetailProgressGroupByPr() throws Exception;

}