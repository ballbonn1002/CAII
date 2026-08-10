package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import com.cubesofttech.model.GoodReceipt;

public interface GoodReceiptDAO {

    public void save(GoodReceipt goodReceipt) throws Exception;

    public void update(GoodReceipt goodReceipt) throws Exception;

    public void delete(GoodReceipt goodReceipt) throws Exception;

    public GoodReceipt findById(Integer goodReceiptId) throws Exception;

    public List<GoodReceipt> findAll() throws Exception;

    /** ใบรับของทั้งหมดของคลังหนึ่ง เรียงล่าสุดก่อน */
    public List<GoodReceipt> findByWarehouseId(String warehouseId) throws Exception;

    /** ค่า good_receipt_id สูงสุด ใช้ generate id ถัดไป (pattern เดียวกับ DAO อื่นในระบบ) */
    public Integer getMaxId() throws Exception;

    /**
     * ประวัติการรับเข้า (IN) ของสินค้าหลักหนึ่งตัว join หัวใบ (good_receipt) กับรายการ (good_receipt_detail)
     * คืนเป็นราย detail (1 แถว = 1 sub product ในใบรับหนึ่งใบ) เรียงใบล่าสุดก่อน
     * ให้ action นำไป group ตาม good_receipt_id เอง
     *
     * @param parentProductId product_id ของสินค้าหลัก (ตรงกับ good_receipt_detail.parent)
     */
    public List<Map<String, Object>> findInHistoryByParentProductId(String parentProductId) throws Exception;
}
