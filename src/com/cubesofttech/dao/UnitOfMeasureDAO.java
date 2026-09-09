package com.cubesofttech.dao;

import java.util.List;

import com.cubesofttech.model.UnitOfMeasure;

public interface UnitOfMeasureDAO {

    public void save(UnitOfMeasure unitOfMeasure) throws Exception;

    public void update(UnitOfMeasure unitOfMeasure) throws Exception;

    public void delete(UnitOfMeasure unitOfMeasure) throws Exception;

    public UnitOfMeasure findById(Integer unitId) throws Exception;

    /** unit ทั้งหมดของ product เรียงตาม sequence (ตัวแรก sequence = '0' คือ unit หลัก) */
    public List<UnitOfMeasure> findByProductId(String productId) throws Exception;

    /** unit หลัก (sequence = '0') ของ product เดียว */
    public UnitOfMeasure findMainUnitByProductId(String productId) throws Exception;

    /** unit หลักของหลาย product ในครั้งเดียว - ใช้กับหน้า list เพื่อกัน N+1 query */
    public List<UnitOfMeasure> findMainUnitsByProductIds(List<String> productIds) throws Exception;

    /** ลบ unit ทั้งหมดของ product (ใช้ตอนลบ product หรือบันทึกทับทั้งชุด) */
    public int deleteByProductId(String productId) throws Exception;

    /**
     * รายชื่อ unit_name ที่ไม่ซ้ำกัน จากทุก product ในระบบ เรียงตามตัวอักษร
     * ใช้เติม dropdown ให้เลือกชื่อหน่วยเดิม กันสร้างชื่อซ้ำกันโดยไม่ตั้งใจ
     * (unit_of_measure ไม่มีตาราง master กลาง - product_id เป็น NOT NULL จึงต้อง distinct ข้าม product ทั้งหมด)
     */
    public List<String> getDistinctUnitNames() throws Exception;
}
