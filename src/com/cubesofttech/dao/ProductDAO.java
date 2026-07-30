package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;
import com.cubesofttech.model.Product;

public interface ProductDAO {
    public void save(Product product) throws Exception;
    public void update(Product product) throws Exception;
    public void delete(Product product) throws Exception;
    public Product findById(Integer id) throws Exception;
    public List<Product> findAll() throws Exception;
    public List<Map<String, Object>> findAllConsWithSubProducts() throws Exception;
    List<Map<String, Object>> findCatalogItemsWithSubProducts() throws Exception;
	List<Map<String, Object>> findByItemsType(String itemsType) throws Exception;
	void updateActiveByParentId(Integer parentId, String active, String userUpdateId) throws Exception;
	void updateSubProductActiveByParentId(Integer parentId, String subProductActive, String userUpdateId) throws Exception;
	
}
