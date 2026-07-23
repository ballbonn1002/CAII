package com.cubesofttech.dao;

import java.util.List;

import com.cubesofttech.model.Warehouse;

public interface WarehouseDAO {
	public void save(Warehouse warehouse) throws Exception;
	public void update(Warehouse warehouse) throws Exception;
	public void delete(Warehouse warehouse) throws Exception;
	public Warehouse findById(Long warehouseId) throws Exception;
	public Warehouse findByName(String warehouseName) throws Exception;
	public List<Warehouse> findAll() throws Exception;
}
