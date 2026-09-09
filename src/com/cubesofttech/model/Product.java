package com.cubesofttech.model;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "product")
public class Product implements Serializable {

    private static final long serialVersionUID = 1L;

    // product_id เป็น AUTO_INCREMENT ใน DB แล้ว (10/08/2026) - ให้ MySQL ออกเลขให้
    // แทนการไล่ max+1 เอง ซึ่งมีโอกาส race condition ถ้ามี 2 request สร้างพร้อมกัน
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "product_id")
    private Integer productId;

    @Column(name = "product_no")
    private String productNo;

    @Column(name = "product_name")
    private String productName;

    @Column(name = "product_type")
    private String productType;

    /**
     * ref อ่อนไปยัง equipment_type.Type (ไม่มี FK constraint จริง ตาม pattern
     * เดิมของ product_id/warehouse_id ในโปรเจกต์นี้) มีค่าเฉพาะ product_type = '1'
     * (Equipment) เป็นค่า default ของ catalog - ยังไม่ผูกกับเครื่องจริงใน equipment
     */
    @Column(name = "equipment_type")
    private String equipmentType;

    @Column(name = "parent_product_id")
    private String parentProductId;

    @Column(name = "sequence")
    private String sequence;

    @Column(name = "description")
    private String description;

    @Column(name = "sub_product_active")
    private String subProductActive;

    @Column(name = "active")
    private String active;

    @Column(name = "user_create")
    private String userCreate;

    @Column(name = "user_update")
    private String userUpdate;

    @Column(name = "time_create")
    private java.sql.Timestamp timeCreate;

    @Column(name = "time_update")
    private java.sql.Timestamp timeUpdate;

    /**
     * ref -> file.file_id (รูปภาพหลักของสินค้า) ตาม pattern เดียวกับ Announcement.file_id
     * ไม่มี FK constraint จริง (ตาราง file ใช้เป็น polymorphic attachment ทั่วระบบ)
     */
    @Column(name = "file_id")
    private String fileId;

    /**
     * map แบบ read-only (insertable/updatable = false) ไปที่ FileUpload ตัวเดียวกับที่ file_id ชี้อยู่
     * ให้ Hibernate join ดึงมาให้อัตโนมัติทุกครั้งที่โหลด product (ใช้ ${product.fileUpload.path} ใน JSP ได้เลย)
     * แก้ค่าจริงผ่าน setFileId() เท่านั้น
     */
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "file_id", referencedColumnName = "file_id", insertable = false, updatable = false)
    private FileUpload fileUpload;

    public Product() {
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public String getProductNo() {
        return productNo;
    }

    public void setProductNo(String productNo) {
        this.productNo = productNo;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductType() {
        return productType;
    }

    public void setProductType(String productType) {
        this.productType = productType;
    }

    public String getEquipmentType() {
        return equipmentType;
    }

    public void setEquipmentType(String equipmentType) {
        this.equipmentType = equipmentType;
    }

    public String getParentProductId() {
        return parentProductId;
    }

    public void setParentProductId(String parentProductId) {
        this.parentProductId = parentProductId;
    }

    public String getSequence() {
        return sequence;
    }

    public void setSequence(String sequence) {
        this.sequence = sequence;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getSubProductActive() {
        return subProductActive;
    }

    public void setSubProductActive(String subProductActive) {
        this.subProductActive = subProductActive;
    }

    public String getActive() {
        return active;
    }

    public void setActive(String active) {
        this.active = active;
    }

    public String getUserCreate() {
        return userCreate;
    }

    public void setUserCreate(String userCreate) {
        this.userCreate = userCreate;
    }

    public String getUserUpdate() {
        return userUpdate;
    }

    public void setUserUpdate(String userUpdate) {
        this.userUpdate = userUpdate;
    }

    public java.sql.Timestamp getTimeCreate() {
        return timeCreate;
    }

    public void setTimeCreate(java.sql.Timestamp timeCreate) {
        this.timeCreate = timeCreate;
    }

    public java.sql.Timestamp getTimeUpdate() {
        return timeUpdate;
    }

    public void setTimeUpdate(java.sql.Timestamp timeUpdate) {
        this.timeUpdate = timeUpdate;
    }

    public String getFileId() {
        return fileId;
    }

    public void setFileId(String fileId) {
        this.fileId = fileId;
    }

    public FileUpload getFileUpload() {
        return fileUpload;
    }

    public void setFileUpload(FileUpload fileUpload) {
        this.fileUpload = fileUpload;
    }

	@Override
	public String toString() {
	    return "Product [product_id=" + productId
	        + ", description=" + description
	        + ", equipment_type=" + equipmentType
	        + ", parent_product_id=" + parentProductId
	        + ", product_name=" + productName
	        + ", product_no=" + productNo
	        + ", product_type=" + productType
	        + ", file_id=" + fileId
	        + ", sequence=" + sequence
	        + ", time_create=" + timeCreate 
	        + ", time_update=" + timeUpdate 
	        + ", user_create=" + userCreate 
	        + ", user_update=" + userUpdate 
	        + "]";
	}
}
