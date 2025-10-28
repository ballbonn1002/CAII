package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import com.cubesofttech.model.Equipment;
import com.cubesofttech.model.EquipmentType;

public interface EquipmentDAO {

	public void save(Equipment equipment) throws Exception;
	
	public List<Map<String, Object>> findAll() throws Exception;

	public Equipment findByEquipmentId(int eId) throws Exception;

	public Equipment findById(String id) throws Exception;

	public void update(Equipment equipment) throws Exception;

	public void delete(Equipment equipment) throws Exception;
	
	public List<Equipment> search(String status) throws Exception;
	
	//public List<Map<String, Object>> searchList(String status) throws Exception;

	Integer getMaxId() throws Exception;

	Equipment findByTypee(int i) throws Exception;
	
	public List<Map<String, Object>> listdetail() throws Exception;

	public List<Map<String, Object>> searchAvai(String status) throws Exception;

	public List<Map<String, Object>> searchList(String status,String name , String type) throws Exception;

	List<Map<String, Object>> findByItemno(String itemNo) throws Exception;
	
	public List<Equipment> findAllBorrow() throws Exception;

	Equipment findByImages(String image) throws Exception;

	public List<Map<String, Object>> approve() throws Exception;  //

	public Equipment findById(int id) throws Exception;			//

	List<Map<String, Object>> statusnirobon() throws Exception;

	public List<Map<String, Object>> searchList(String status) throws Exception;

	public List<Equipment> getAll();

	public List<Equipment> findByStatus(String status);
	
	public List<Equipment> findByTypes(String Type);
	
	

	public Equipment findByItemNo(String itemNo);

	public Equipment getById(int id);

}
