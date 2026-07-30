package com.cubesofttech.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import javax.persistence.Table;
 @Entity
@Table(name = "catalog_consumables")
public class CatalogConsumables implements Serializable{
	 
	 private static final long serialVersionUID = 1L;
	 
	@Id
	@Column(name = "catalog_consumables_id")
	private Long catalogConsumablesId;
	
	@Column(name = "product_id")
	private Long productId;
	
	@Column(name = "parent_product_id")
	private String parentProductId;
	
	@Column(name = "items_type")
	private String itemsType;
	
	@Column(name = "sub_product_active")
	private String  subProductActive;
	
	@Column(name = "active")
	private String  active;
	
	@Column(name = "user_create")
	private String userCreate;
	
	@Column(name = "time_create")
	private java.sql.Timestamp timeCreate;
	
	@Column(name = "user_update")
	private String userUpdate;
	
	@Column(name = "time_update")
	private java.sql.Timestamp timeUpdate;

	public Long getCatalogConsumablesId() {
		return catalogConsumablesId;
	}

	public void setCatalogConsumablesId(Long catalogConsumablesId) {
		this.catalogConsumablesId = catalogConsumablesId;
	}

	public Long getProductId() {
		return productId;
	}

	public void setProductId(Long productId) {
		this.productId = productId;
	}

	public String getParentProductId() {
		return parentProductId;
	}

	public void setParentProductId(String parentProductId) {
		this.parentProductId = parentProductId;
	}

	public String getItemsType() {
		return itemsType;
	}

	public void setItemsType(String itemsType) {
		this.itemsType = itemsType;
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

	public java.sql.Timestamp getTimeCreate() {
		return timeCreate;
	}

	public void setTimeCreate(java.sql.Timestamp timeCreate) {
		this.timeCreate = timeCreate;
	}

	public String getUserUpdate() {
		return userUpdate;
	}

	public void setUserUpdate(String userUpdate) {
		this.userUpdate = userUpdate;
	}

	public java.sql.Timestamp getTimeUpdate() {
		return timeUpdate;
	}

	public void setTimeUpdate(java.sql.Timestamp timeUpdate) {
		this.timeUpdate = timeUpdate;
	}

	@Override
	public String toString() {
		return "CatalogConsumables [catalogConsumablesId=" + catalogConsumablesId + ", productId=" + productId
				+ ", parentProductId=" + parentProductId + ", itemsType=" + itemsType + ", subProductActive="
				+ subProductActive + ", active=" + active + ", userCreate=" + userCreate + ", timeCreate=" + timeCreate
				+ ", userUpdate=" + userUpdate + ", timeUpdate=" + timeUpdate + "]";
	}

	
	
	
}
