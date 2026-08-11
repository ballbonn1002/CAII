package com.cubesofttech.dao;

import java.util.List;

import com.cubesofttech.model.GoodReceiptDetail;

public interface GoodReceiptDetailDAO {

    public void save(GoodReceiptDetail goodReceiptDetail) throws Exception;

    public void update(GoodReceiptDetail goodReceiptDetail) throws Exception;

    public void delete(GoodReceiptDetail goodReceiptDetail) throws Exception;

    public GoodReceiptDetail findById(Integer goodReceiptDetailId) throws Exception;

    public List<GoodReceiptDetail> findAll() throws Exception;

    /** รายการสินค้าทั้งหมดของใบรับของหนึ่งใบ */
    public List<GoodReceiptDetail> findByGoodReceiptId(String goodReceiptId) throws Exception;

    /** ประวัติการรับเข้าของ product หนึ่ง */
    public List<GoodReceiptDetail> findByProductId(String productId) throws Exception;

    /** ลบ detail ทั้งหมดของใบรับของ (ใช้ตอนลบหัวใบ หรือบันทึกทับทั้งชุด) */
    public int deleteByGoodReceiptId(String goodReceiptId) throws Exception;

    /** ค่า good_receipt_detail_id สูงสุด ใช้ generate id ถัดไป */
    public Integer getMaxId() throws Exception;
}
