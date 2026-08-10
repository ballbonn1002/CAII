package com.cubesofttech.model;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "product")
public class Product implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "product_id")
    private Integer productId;

    @Column(name = "product_no")
    private String productNo;

    @Column(name = "product_name")
    private String productName;

    @Column(name = "product_type")
    private String productType;

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
	@Override
	public String toString() {
	    return "Product [product_id=" + productId 
	        + ", description=" + description 
	        + ", parent_product_id=" + parentProductId 
	        + ", product_name=" + productName 
	        + ", product_no=" + productNo 
	        + ", product_type=" + productType 
	        + ", sequence=" + sequence 
	        + ", time_create=" + timeCreate 
	        + ", time_update=" + timeUpdate 
	        + ", user_create=" + userCreate 
	        + ", user_update=" + userUpdate 
	        + "]";
	}
}
