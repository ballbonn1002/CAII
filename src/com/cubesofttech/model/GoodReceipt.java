package com.cubesofttech.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "good_receipt")
public class GoodReceipt implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "good_receipt_id")
    private Integer goodReceiptId;

    @Column(name = "gr_ref")
    private String grRef;

    @Column(name = "receive_date")
    private java.sql.Timestamp receiveDate;

    @Column(name = "recipient_user")
    private String recipientUser;

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

    public GoodReceipt() {
    }

    public Integer getGoodReceiptId() {
        return goodReceiptId;
    }

    public void setGoodReceiptId(Integer goodReceiptId) {
        this.goodReceiptId = goodReceiptId;
    }

    public String getGrRef() {
        return grRef;
    }

    public void setGrRef(String grRef) {
        this.grRef = grRef;
    }

    public java.sql.Timestamp getReceiveDate() {
        return receiveDate;
    }

    public void setReceiveDate(java.sql.Timestamp receiveDate) {
        this.receiveDate = receiveDate;
    }

    public String getRecipientUser() {
        return recipientUser;
    }

    public void setRecipientUser(String recipientUser) {
        this.recipientUser = recipientUser;
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
        return "GoodReceipt [goodReceiptId=" + goodReceiptId + ", grRef=" + grRef + ", receiveDate=" + receiveDate
                + ", recipientUser=" + recipientUser + ", warehouseId=" + warehouseId + ", description=" + description
                + ", userCreate=" + userCreate + ", userUpdate=" + userUpdate
                + ", timeCreate=" + timeCreate + ", timeUpdate=" + timeUpdate + "]";
    }
}
