package com.cubesofttech.dao;

import java.util.List;

import com.cubesofttech.model.UnitMaster;

public interface UnitMasterDAO {

    /** ชื่อหน่วยทั้งหมดในระบบ เรียงตามตัวอักษร - ใช้เติม dropdown Unit Name กันสร้างชื่อซ้ำ */
    public List<String> findAllNames() throws Exception;

    /**
     * หาแถวที่ unit_name ตรงกัน (trim แล้ว) ถ้าไม่เจอให้สร้างใหม่แล้ว return แถวนั้น
     * userCreate ต้องส่งมาด้วยเพราะ unit_master.user_create เป็น NOT NULL (ใช้เฉพาะตอนสร้างแถวใหม่)
     */
    public UnitMaster findOrCreateByName(String unitName, String userCreate) throws Exception;
}
