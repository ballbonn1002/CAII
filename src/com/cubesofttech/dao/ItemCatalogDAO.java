package com.cubesofttech.dao;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import com.cubesofttech.model.ItemCatalog;

public interface ItemCatalogDAO {

	List<ItemCatalog> findAll() throws Exception;
	
	void save(ItemCatalog ItemCatalog) throws Exception;
	
	ItemCatalog findById(Long itemCatalogId) throws Exception;

	Long getMaxId() throws Exception;

	void delete(ItemCatalog ItemCatalog) throws Exception;

	void update(ItemCatalog ItemCatalog) throws Exception;

	

}
