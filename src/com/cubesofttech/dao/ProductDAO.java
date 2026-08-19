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
    /**
     * ดึง product ตัวแม่ (parent_product_id = '0') พร้อมชื่อ sub product รวมเป็น string
     * และจำนวนเครื่องจริงที่ผูกอยู่ (สำหรับ product_type = '1' Equipment)
     *
     * @param productType '1' Equipment / '2' Consumables / '3' Accessory,
     *                    ส่ง null หรือค่าว่าง = เอาทุก type
     */
    public List<Map<String, Object>> findAllWithSubProducts(String productType) throws Exception;
    List<Map<String, Object>> findCatalogItemsWithSubProducts() throws Exception;
	List<Map<String, Object>> findByItemsType(String itemsType) throws Exception;
	void updateActiveByParentId(Integer parentId, String active, String userUpdateId) throws Exception;
	void updateSubProductActiveByParentId(Integer parentId, String subProductActive, String userUpdateId) throws Exception;
	List<Product> getproductid(Product product) throws Exception;
	List<Object[]> getArrayProduct(Product Product) throws Exception;

    List<Product> findByParentProductIds(List<String> parentProductIds) throws Exception;

    /**
     * นับว่า product (รวม sub product ของมัน) ถูกอ้างถึงจากเอกสาร/ข้อมูลอื่นกี่รายการ
     * ใช้กันไม่ให้ลบ item ที่มีการใช้งานอยู่จนเกิดข้อมูลกำพร้า
     *
     * @param productIds product_id ของตัวแม่ + sub product ทั้งหมด
     * @return map ของ "แหล่งอ้างอิง -> จำนวนรายการ" เฉพาะแหล่งที่เจอ (count > 0)
     */
    Map<String, Long> countReferences(List<Integer> productIds) throws Exception;

    /**
     * ลบ product ตัวแม่พร้อมของที่เป็นลูกของมัน (sub product + unit of measure)
     * ต้องเรียก countReferences() เช็คก่อนเสมอ - เมธอดนี้ไม่ตรวจซ้ำให้
     */
    void deleteWithChildren(Integer productId) throws Exception;
}
