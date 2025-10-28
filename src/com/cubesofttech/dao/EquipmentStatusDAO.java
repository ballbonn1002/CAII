package com.cubesofttech.dao;

import java.util.List;

import com.cubesofttech.model.EquipmentStatus;

public interface EquipmentStatusDAO {

	public List<EquipmentStatus> getall();
	public EquipmentStatus findByStatus(String id);
	public void save(EquipmentStatus eStatus);
	public void update(EquipmentStatus eStatus);
	public void delete(EquipmentStatus eStatus);
}
