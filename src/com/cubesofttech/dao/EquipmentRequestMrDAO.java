package com.cubesofttech.dao;

import java.util.List;
import com.cubesofttech.model.EquipmentRequestMr;
import com.cubesofttech.model.DocStatus;
import com.cubesofttech.model.Expense;

public interface EquipmentRequestMrDAO {
	List<Object[]> getAllEquopmentRequestMr(EquipmentRequestMr equipmentRequestMr) throws Exception;
	List<EquipmentRequestMr> findAll() throws Exception;
	void save(EquipmentRequestMr equipmentRequest) throws Exception;
	void deleteMr(EquipmentRequestMr equipmentRequest) throws Exception;
	String  getNextMrId() throws Exception;
	 List<DocStatus> getDocStatus(DocStatus docStatus) throws Exception;
	 List<Expense> loaddataEquipment(Long mr_id) throws Exception;
}
