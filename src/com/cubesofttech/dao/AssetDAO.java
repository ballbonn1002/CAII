package com.cubesofttech.dao;

import java.util.List;

import com.cubesofttech.model.Asset;

public interface AssetDAO {

    void save(Asset asset) throws Exception;

    void update(Asset asset) throws Exception;

    void delete(Asset asset) throws Exception;

    Asset findById(Integer assetId) throws Exception;

    /** ทั้งหมด เรียงชิ้นที่แก้ไขล่าสุดก่อน */
    List<Asset> findAll() throws Exception;

    /**
     * เลขลำดับสูงสุดของ Item No. ที่ขึ้นต้นด้วย prefix (เช่น AST0012 -> 12) ไม่มีเลยคืน 0
     * ใช้สร้าง Item No. ตัวถัดไป (ตัวที่ส่วนท้ายไม่ใช่ตัวเลขจะถูกข้าม)
     */
    int findMaxItemNoSequence(String prefix) throws Exception;

    /** มี Item No. นี้แล้วหรือยัง (ไม่สนตัวพิมพ์เล็ก/ใหญ่) */
    boolean existsByItemNo(String itemNo) throws Exception;

    /** หา Asset จาก Item No. (ไม่สนตัวพิมพ์เล็ก/ใหญ่) ไม่พบคืน null */
    Asset findByItemNo(String itemNo) throws Exception;

    /** Asset ที่อยู่ในที่เก็บเหล่านี้ (warehouse_id) ใช้หน้าสแกน QR ของที่เก็บ list ว่างคืน list ว่าง */
    List<Asset> findByWarehouseIds(List<Long> warehouseIds) throws Exception;

    /** Asset ที่ผูกกับ Product (รุ่น) เหล่านี้ ใช้หน้าแก้ไข Product list ว่างคืน list ว่าง */
    List<Asset> findByProductIds(List<Integer> productIds) throws Exception;

    /** Asset ที่ยังไม่ผูกกับรุ่นใดเลย (product_id เป็น NULL) ใช้เป็นตัวเลือกใน Link Assets */
    List<Asset> findUnlinked() throws Exception;
}
