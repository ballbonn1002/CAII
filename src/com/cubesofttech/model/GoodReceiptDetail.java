package com.cubesofttech.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "good_receipt_detail")
public class GoodReceiptDetail implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "good_receipt_detail_id")
    private Integer goodReceiptDetailId;

    @Column(name = "good_receipt_id")
    private String goodReceiptId;

    @Column(name = "po_id")
    private String poId;

    @Column(name = "product_id")
    private String productId;

    /** parent (sub product) */
    @Column(name = "parent")
    private String parent;

    @Column(name = "amount")
    private Double amount;

    @Column(name = "unit")
    private String unit;

    @Column(name = "warehouse_id")
    private String warehouseId;

    @Column(name = "description")
    private String description;

    @Column(name = "user_create")
    private String userCreate;

    @Column(name = "user_update")
    private String userUpdate;

    @Column(name = "time_create")
    private java.sql.Timestamp timeCreate;

    @Column(name = "time_update")
    private java.sql.Timestamp timeUpdate;

    public GoodReceiptDetail() {
    }

    public Integer getGoodReceiptDetailId() {
        return goodReceiptDetailId;
    }

    public void setGoodReceiptDetailId(Integer goodReceiptDetailId) {
        this.goodReceiptDetailId = goodReceiptDetailId;
    }

    public String getGoodReceiptId() {
        return goodReceiptId;
    }

    public void setGoodReceiptId(String goodReceiptId) {
        this.goodReceiptId = goodReceiptId;
    }

    public String getPoId() {
        return poId;
    }

    public void setPoId(String poId) {
        this.poId = poId;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getParent() {
        return parent;
    }

    public void setParent(String parent) {
        this.parent = parent;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public String getWarehouseId() {
        return warehouseId;
    }

    public void setWarehouseId(String warehouseId) {
        this.warehouseId = warehouseId;
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

    @Override
    public String toString() {
        return "GoodReceiptDetail [goodReceiptDetailId=" + goodReceiptDetailId + ", goodReceiptId=" + goodReceiptId
                + ", poId=" + poId + ", productId=" + productId + ", parent=" + parent + ", amount=" + amount
                + ", unit=" + unit + ", warehouseId=" + warehouseId + ", description=" + description
                + ", userCreate=" + userCreate + ", userUpdate=" + userUpdate + ", timeCreate=" + timeCreate
                + ", timeUpdate=" + timeUpdate + "]";
    }
}
