package com.cubesofttech.dao;

import java.util.List;
import java.util.Set;

import com.cubesofttech.model.AssetLog;

public interface AssetLogDAO {

    void save(AssetLog move) throws Exception;

    /** ประวัติการย้ายของ Asset ชิ้นเดียว เรียงล่าสุดก่อน (ไม่มีคืน list ว่าง) */
    List<AssetLog> findByAssetId(Integer assetId) throws Exception;

    /** ชิ้นนี้เคยย้ายที่แล้วหรือยัง (ใช้กันการลบ) */
    boolean existsByAssetId(Integer assetId) throws Exception;

    /** id ของ Asset ที่เคยย้ายที่แล้ว (ใช้หน้ารายการ) ไม่มีคืน set ว่าง */
    Set<Integer> findMovedAssetIds() throws Exception;
}
