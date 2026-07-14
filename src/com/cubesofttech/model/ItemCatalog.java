package com.cubesofttech.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import javax.persistence.Table;
 @Entity
@Table(name = "item_catalog")
public class ItemCatalog implements Serializable{
	 
	 private static final long serialVersionUID = 1L;
	 
	@Id
	@Column(name = "item_catalog_id")
	private Long itemCatalogId;
	
	@Column(name = "item_equipment_name")
	private String itemEquipmentName;
	
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

	public Long getItemCatalogId() {
		return itemCatalogId;
	}

	public void setItemCatalogId(Long itemCatalogId) {
		this.itemCatalogId = itemCatalogId;
	}

	public String getItemEquipmentName() {
		return itemEquipmentName;
	}

	public void setItemEquipmentName(String itemEquipmentName) {
		this.itemEquipmentName = itemEquipmentName;
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
		return "ItemCatalog [itemCatalogId=" + itemCatalogId + ", itemEquipmentName=" + itemEquipmentName + ", active="
				+ active + ", userCreate=" + userCreate + ", timeCreate=" + timeCreate + ", userUpdate=" + userUpdate
				+ ", timeUpdate=" + timeUpdate + "]";
	}
	
	
}
