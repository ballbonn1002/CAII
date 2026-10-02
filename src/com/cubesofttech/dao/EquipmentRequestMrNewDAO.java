package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import com.cubesofttech.model.EquipmentRequestMr;

public interface EquipmentRequestMrNewDAO {

	List<Map<String, Object>> findMyMrList(String userCreate) throws Exception;

	List<Map<String, Object>> findAllMrList() throws Exception;

	List<Map<String, Object>> findMainItems() throws Exception;

	List<Map<String, Object>> findSubItems(String parentProductId) throws Exception;

	String findSmallestUnitName(String productId) throws Exception;

	String findMaxMrIdByPrefix(String prefix) throws Exception;

	void save(EquipmentRequestMr mr) throws Exception;

	EquipmentRequestMr findMrById(String mrId) throws Exception;

	void update(EquipmentRequestMr mr) throws Exception;

	Integer deleteById(String mrId, String cancelStatusCode, String userUpdate) throws Exception;

	List<Map<String, Object>> findApprovedMrForMrSearch() throws Exception;

}
