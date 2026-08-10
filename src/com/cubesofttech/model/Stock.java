package com.cubesofttech.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "stock")
public class Stock implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "stock_id")
    private String stockId;

    @Column(name = "product_id")
    private String productId;

    @Column(name = "action_type")
    private String actionType;

    @Column(name = "action_ref")
    private String actionRef;

    @Column(name = "unit")
    private String unit;

    @Column(name = "amount_unit")
    private Double amountUnit;

    @Column(name = "amount_convert")
    private Double amountConvert;

    @Column(name = "reconcile")
    private Double reconcile;

    @Column(name = "warehouse_id", length = 16)
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

    public Stock() {
    }

    public String getStockId() {
        return stockId;
    }

    public void setStockId(String stockId) {
        this.stockId = stockId;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getActionType() {
        return actionType;
    }

    public void setActionType(String actionType) {
        this.actionType = actionType;
    }

    public String getActionRef() {
        return actionRef;
    }

    public void setActionRef(String actionRef) {
        this.actionRef = actionRef;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public Double getAmountUnit() {
        return amountUnit;
    }

    public void setAmountUnit(Double amountUnit) {
        this.amountUnit = amountUnit;
    }

    public Double getAmountConvert() {
        return amountConvert;
    }

    public void setAmountConvert(Double amountConvert) {
        this.amountConvert = amountConvert;
    }

    public Double getReconcile() {
        return reconcile;
    }

    public void setReconcile(Double reconcile) {
        this.reconcile = reconcile;
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
        return "Stock [stockId=" + stockId + ", productId=" + productId + ", actionType=" + actionType
                + ", actionRef=" + actionRef + ", unit=" + unit + ", amountUnit=" + amountUnit
                + ", amountConvert=" + amountConvert + ", reconcile=" + reconcile + ", warehouseId=" + warehouseId
                + ", description=" + description
                + ", userCreate=" + userCreate + ", userUpdate=" + userUpdate + ", timeCreate=" + timeCreate
                + ", timeUpdate=" + timeUpdate + "]";
    }
}
