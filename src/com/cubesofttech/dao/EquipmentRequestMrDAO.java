package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import com.cubesofttech.model.EquipmentRequestMr;
import com.cubesofttech.model.DocStatus;
import com.cubesofttech.model.Expense;
import com.cubesofttech.model.FileUpload;

public interface EquipmentRequestMrDAO {
	List<Object[]> getAllEquopmentRequestMr(EquipmentRequestMr equipmentRequestMr) throws Exception;
	List<EquipmentRequestMr> findAll() throws Exception;
	void save(EquipmentRequestMr equipmentRequest) throws Exception;
	void update(EquipmentRequestMr EquipmentRequest) throws Exception;
	void deleteMr(EquipmentRequestMr equipmentRequest) throws Exception;
    void updateStatus(String mr_id, String status,String user_create) throws Exception;
	String  getNextMrId() throws Exception;
	 List<DocStatus> getDocStatus(DocStatus docStatus) throws Exception;
	 public Map<String, Object> loaddataEquipment(String mr_id) throws Exception;
	 List<FileUpload> findByPageAndPageId(String page, String pageId) throws Exception;
}
