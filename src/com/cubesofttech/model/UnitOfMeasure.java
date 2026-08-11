package com.cubesofttech.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "unit_of_measure")
public class UnitOfMeasure implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "unit_id")
    private Integer unitId;

    @Column(name = "product_id")
    private String productId;

    /** ตัวแรกให้เป็น 0 และให้เป็น unit หลัก */
    @Column(name = "sequence")
    private String sequence;

    @Column(name = "unit_name")
    private String unitName;

    @Column(name = "conversion_rate")
    private Integer conversionRate;

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

    public UnitOfMeasure() {
    }

    public Integer getUnitId() {
        return unitId;
    }

    public void setUnitId(Integer unitId) {
        this.unitId = unitId;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getSequence() {
        return sequence;
    }

    public void setSequence(String sequence) {
        this.sequence = sequence;
    }

    public String getUnitName() {
        return unitName;
    }

    public void setUnitName(String unitName) {
        this.unitName = unitName;
    }

    public Integer getConversionRate() {
        return conversionRate;
    }

    public void setConversionRate(Integer conversionRate) {
        this.conversionRate = conversionRate;
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
        return "UnitOfMeasure [unitId=" + unitId + ", productId=" + productId + ", sequence=" + sequence
                + ", unitName=" + unitName + ", conversionRate=" + conversionRate + ", description=" + description
                + ", userCreate=" + userCreate + ", userUpdate=" + userUpdate + ", timeCreate=" + timeCreate
                + ", timeUpdate=" + timeUpdate + "]";
    }
}
