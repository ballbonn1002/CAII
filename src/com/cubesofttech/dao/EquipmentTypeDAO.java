package com.cubesofttech.dao;

import java.util.List;

import com.cubesofttech.model.EquipmentType;

public interface EquipmentTypeDAO {

	public List<EquipmentType> getall();
	public EquipmentType findByType(String id);
	public void save(EquipmentType Type);
	public void update(EquipmentType Type);
	public void delete(EquipmentType Type);
}
