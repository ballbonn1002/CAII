package com.cubesofttech.dao;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import com.cubesofttech.model.CatalogEquipment;

public interface CatalogEquipmentDAO {

	List<CatalogEquipment> findAll() throws Exception;
	
	void save(CatalogEquipment CatalogEquipment) throws Exception;
	
	CatalogEquipment findById(Long catalogEquipmentId) throws Exception;

	Long getMaxId() throws Exception;

	void delete(CatalogEquipment CatalogEquipment) throws Exception;

	void update(CatalogEquipment CatalogEquipment) throws Exception;

	

}
