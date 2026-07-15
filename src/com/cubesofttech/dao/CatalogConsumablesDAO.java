package com.cubesofttech.dao;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import com.cubesofttech.model.CatalogConsumables;

public interface CatalogConsumablesDAO {

	List<CatalogConsumables> findAll() throws Exception;
	
	void save(CatalogConsumables CatalogConsumables) throws Exception;
	
	CatalogConsumables findById(Long catalogConsumablesId) throws Exception;

	Long getMaxId() throws Exception;

	void delete(CatalogConsumables CatalogConsumables) throws Exception;

	void update(CatalogConsumables CatalogConsumables) throws Exception;

	

}
