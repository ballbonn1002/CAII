package com.cubesofttech.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Assets (เดิม Office Supplies / product_type '4') - ของชิ้นใหญ่ เช่น โต๊ะ เก้าอี้ ตู้ เก็บรายชิ้น
 * ทำงานแบบ Equipment แต่ไม่มียืม-คืน ใช้ติดตามว่าแต่ละชิ้นอยู่ที่ไหน (ตารางใหม่ ไม่ใช้ตาราง equipment)
 *  - item_no สร้างอัตโนมัติ AST0001, AST0002, ... (แยกชุดเลขจาก Equipment)
 *  - product_id = รุ่นในเมนู Product (เฉพาะ type '4') ไม่บังคับ / เป็น int ตรงกับ product.product_id
 *  - warehouse_id = ที่อยู่ปัจจุบัน (ตาราง warehouse) เลือกได้ตอนสร้าง หลังจากนั้นเปลี่ยนผ่าน "ย้ายที่" เท่านั้น
 */
@Entity
@Table(name = "asset")
public class Asset implements Serializable {

    private static final long serialVersionUID = 1L;

    /** ตัวขึ้นต้น Item No. ของ Assets */
    public static final String ITEM_NO_PREFIX = "AST";

    /** สถานะ (ใช้ไปก่อนตามที่ทีมตกลง 10 พ.ย. 2026) */
    public static final String STATUS_IN_USE = "U";
    public static final String STATUS_STORED = "S";
    public static final String STATUS_DAMAGED = "D";

    /** รหัสสถานะ -> ชื่อที่แสดง เรียงตามลำดับใน dropdown */
    public static final Map<String, String> STATUS_LABELS;
    /** รหัสสถานะ -> สีป้าย (badge-light-xxx ของ Metronic) */
    public static final Map<String, String> STATUS_COLORS;

    static {
        Map<String, String> labels = new LinkedHashMap<String, String>();
        labels.put(STATUS_IN_USE, "ใช้งานอยู่");
        labels.put(STATUS_STORED, "เก็บไว้");
        labels.put(STATUS_DAMAGED, "ชำรุด");
        STATUS_LABELS = java.util.Collections.unmodifiableMap(labels);

        Map<String, String> colors = new LinkedHashMap<String, String>();
        colors.put(STATUS_IN_USE, "success");
        colors.put(STATUS_STORED, "primary");
        colors.put(STATUS_DAMAGED, "danger");
        STATUS_COLORS = java.util.Collections.unmodifiableMap(colors);
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "asset_id")
    private Integer assetId;

    @Column(name = "item_no", length = 20, nullable = false)
    private String itemNo;

    @Column(name = "name", length = 255, nullable = false)
    private String name;

    @Column(name = "product_id")
    private Integer productId;

    @Column(name = "serial_no", length = 100)
    private String serialNo;

    @Column(name = "warehouse_id")
    private Long warehouseId;

    @Column(name = "status", length = 1, nullable = false)
    private String status;

    @Column(name = "purchase_date")
    private Date purchaseDate;

    @Column(name = "price", precision = 12, scale = 2)
    private BigDecimal price;

    @Column(name = "image", length = 255)
    private String image;

    @Column(name = "note", length = 1000)
    private String note;

    @Column(name = "user_create", length = 32)
    private String userCreate;

    @Column(name = "time_create")
    private Timestamp timeCreate;

    @Column(name = "user_update", length = 32)
    private String userUpdate;

    @Column(name = "time_update")
    private Timestamp timeUpdate;

    public Integer getAssetId() {
        return assetId;
    }

    public void setAssetId(Integer assetId) {
        this.assetId = assetId;
    }

    public String getItemNo() {
        return itemNo;
    }

    public void setItemNo(String itemNo) {
        this.itemNo = itemNo;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public String getSerialNo() {
        return serialNo;
    }

    public void setSerialNo(String serialNo) {
        this.serialNo = serialNo;
    }

    public Long getWarehouseId() {
        return warehouseId;
    }

    public void setWarehouseId(Long warehouseId) {
        this.warehouseId = warehouseId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getPurchaseDate() {
        return purchaseDate;
    }

    public void setPurchaseDate(Date purchaseDate) {
        this.purchaseDate = purchaseDate;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
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

    /** ชื่อสถานะสำหรับแสดงผล (ไม่รู้จักรหัส = แสดงรหัสเดิม) */
    public String getStatusLabel() {
        String label = (status == null) ? null : STATUS_LABELS.get(status);
        return label != null ? label : (status == null ? "-" : status);
    }

    /** สีป้ายสถานะ (ไม่รู้จักรหัส = secondary) */
    public String getStatusColor() {
        String color = (status == null) ? null : STATUS_COLORS.get(status);
        return color != null ? color : "secondary";
    }

    @Override
    public String toString() {
        return "Asset [assetId=" + assetId + ", itemNo=" + itemNo + ", name=" + name + ", productId=" + productId
                + ", warehouseId=" + warehouseId + ", status=" + status + "]";
    }
}
