package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import com.cubesofttech.model.UnitMaster;

public interface UnitMasterDAO {

    /** ชื่อหน่วยทั้งหมดในระบบ เรียงตามตัวอักษร - ใช้เติม dropdown Unit Name กันสร้างชื่อซ้ำ */
    public List<String> findAllNames() throws Exception;

    /**
     * หาแถวที่ unit_name ตรงกัน (trim แล้ว) ถ้าไม่เจอให้สร้างใหม่แล้ว return แถวนั้น
     * userCreate ต้องส่งมาด้วยเพราะ unit_master.user_create เป็น NOT NULL (ใช้เฉพาะตอนสร้างแถวใหม่)
     */
    public UnitMaster findOrCreateByName(String unitName, String userCreate) throws Exception;

    public UnitMaster findById(Integer unitMasterId) throws Exception;

    /**
     * unit_master ทุกแถวเรียงตามชื่อ พร้อมจำนวน unit_of_measure ที่ผูกอยู่ (usageCount)
     * ใช้แสดงหน้า list ให้เห็นผลกระทบก่อนแก้ชื่อ - key: unitMasterId, unitName, usageCount
     */
    public List<Map<String, Object>> findAllWithUsageCount() throws Exception;

    /**
     * แก้ไขชื่อ + sync ชื่อไปยัง unit_of_measure.unit_name (denormalized copy) ของทุกแถวที่ผูกกับ
     * unit_master นี้ด้วย ไม่งั้นชื่อที่โชว์ในหน้า Product Edit จะไม่ตรงกับ unit_master อีกต่อไป
     */
    public void update(UnitMaster unitMaster) throws Exception;

    /** เช็คชื่อซ้ำก่อนบันทึก (ไม่นับแถวตัวเอง) - unit_name มี UNIQUE KEY อยู่แล้วในระดับ DB */
    public boolean existsByNameExcludingId(String unitName, Integer excludeId) throws Exception;
}
