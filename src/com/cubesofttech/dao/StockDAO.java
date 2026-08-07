package com.cubesofttech.dao;

import java.util.List;

import com.cubesofttech.model.Stock;

public interface StockDAO {

    public void save(Stock stock) throws Exception;

    public void update(Stock stock) throws Exception;

    public void delete(Stock stock) throws Exception;

    public Stock findById(String stockId) throws Exception;

    public List<Stock> findAll() throws Exception;

    /** ความเคลื่อนไหวสต็อกทั้งหมดของ product เรียงล่าสุดก่อน */
    public List<Stock> findByProductId(String productId) throws Exception;

    /** ความเคลื่อนไหวที่อ้างอิงเอกสารเดียวกัน (action_ref) */
    public List<Stock> findByActionRef(String actionRef) throws Exception;

    /** ยอดคงเหลือล่าสุดของ product (แถว reconcile ล่าสุดตาม time_create) */
    public Stock findLatestByProductId(String productId) throws Exception;

    /** ผลรวม amount_convert ของ product (ยอดสุทธิจากความเคลื่อนไหวทั้งหมด) */
    public Double sumConvertByProductId(String productId) throws Exception;
}
