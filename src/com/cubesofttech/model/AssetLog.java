package com.cubesofttech.model;

import java.io.Serializable;
import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * ประวัติการย้ายที่ของ Asset (1 แถว = ย้าย 1 ชิ้น 1 ครั้ง) - รอบ A2
 *  - from_warehouse_id = ที่เดิม (NULL = ก่อนหน้านั้นยังไม่เคยระบุที่อยู่)
 *  - to_warehouse_id   = ที่ใหม่
 *  - ชิ้นที่มีแถวในตารางนี้แล้ว "ลบไม่ได้" (ให้เปลี่ยนสถานะแทน) เพื่อไม่ให้ประวัติหาย
 */
@Entity
@Table(name = "asset_log")
public class AssetLog implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "log_id")
    private Integer logId;

    @Column(name = "asset_id", nullable = false)
    private Integer assetId;

    @Column(name = "from_warehouse_id")
    private Long fromWarehouseId;

    @Column(name = "to_warehouse_id", nullable = false)
    private Long toWarehouseId;

    @Column(name = "description", length = 500)
    private String description;

    @Column(name = "user_create", length = 32)
    private String userCreate;

    @Column(name = "time_create")
    private Timestamp timeCreate;

    @Column(name = "user_update", length = 32)
    private String userUpdate;

    @Column(name = "time_update")
    private Timestamp timeUpdate;

    public Integer getLogId() {
        return logId;
    }

    public void setLogId(Integer logId) {
        this.logId = logId;
    }

    public Integer getAssetId() {
        return assetId;
    }

    public void setAssetId(Integer assetId) {
        this.assetId = assetId;
    }

    public Long getFromWarehouseId() {
        return fromWarehouseId;
    }

    public void setFromWarehouseId(Long fromWarehouseId) {
        this.fromWarehouseId = fromWarehouseId;
    }

    public Long getToWarehouseId() {
        return toWarehouseId;
    }

    public void setToWarehouseId(Long toWarehouseId) {
        this.toWarehouseId = toWarehouseId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getUserCreate() {
        return userCreate;
    }

    public void setUserCreate(String userCreate) {
        this.userCreate = userCreate;
    }

    public Timestamp getTimeCreate() {
        return timeCreate;
    }

    public void setTimeCreate(Timestamp timeCreate) {
        this.timeCreate = timeCreate;
    }

    public String getUserUpdate() {
        return userUpdate;
    }

    public void setUserUpdate(String userUpdate) {
        this.userUpdate = userUpdate;
    }

    public Timestamp getTimeUpdate() {
        return timeUpdate;
    }

    public void setTimeUpdate(Timestamp timeUpdate) {
        this.timeUpdate = timeUpdate;
    }
}
