package com.cubesofttech.dao;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import com.cubesofttech.model.Equipment;
import com.cubesofttech.model.EquipmentType;

public interface EquipmentDAO {

	/**
	 * status ของ equipment ที่ไม่นับเป็นของคงเหลือ (ยังผูก product_id ไว้ แต่ไม่นับยอด)
	 * อ้างอิงจากตาราง equipment_status:
	 *   S = Sold Out  - ขาย/จำหน่ายออกไปแล้ว
	 *   Z = Disabled  - ปลดระวาง
	 *   L = Lost      - สูญหาย
	 *
	 * ที่ยังนับเป็นของคงเหลือ: A Available, B Borrowed (ยังเป็นทรัพย์สินบริษัท แค่ถูกยืมออกไป),
	 * C Corrupted (ชำรุดแต่ของยังอยู่), W Wait for approve
	 */
	List<String> RETIRED_STATUSES = Arrays.asList("S", "Z", "L");

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

	public Map<String, Object> getUserCreateByEquipmentId(int id);

	/**
	 * เครื่องจริงทั้งหมดที่ผูกกับ catalog item ที่ระบุ (product.product_id)
	 * ใช้กับหน้า Stock Balance ฝั่ง Equipment ซึ่งยอดคงเหลือคือ "จำนวนเครื่อง"
	 * ไม่ได้มาจากตาราง stock
	 *
	 * @param productIds product_id ของตัวแม่และ sub product ทั้งหมดที่ต้องการ
	 *                   (String เพราะ equipment.product_id เป็น varchar(32))
	 * @return list ว่างเมื่อไม่มีข้อมูล (ไม่คืน null)
	 */
	List<Equipment> findByProductIds(List<String> productIds) throws Exception;

}
