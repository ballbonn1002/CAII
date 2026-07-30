package com.cubesofttech.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import javax.persistence.Table;
 @Entity
@Table(name = "catalog_equipment")
public class CatalogEquipment implements Serializable{
	 
	 private static final long serialVersionUID = 1L;
	 
	@Id
	@Column(name = "catalog_equipment_id")
	private Long catalogEquipmentId;
	
	@Column(name = "equipment_name")
	private String catalogEquipmentName;
	
	@Column(name = "items_type")
	private String itemsType;
	
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

	public Long getCatalogEquipmentId() {
		return catalogEquipmentId;
	}

	public void setCatalogEquipmentId(Long catalogEquipmentId) {
		this.catalogEquipmentId = catalogEquipmentId;
	}

	public String getCatalogEquipmentName() {
		return catalogEquipmentName;
	}

	public void setCatalogEquipmentName(String catalogEquipmentName) {
		this.catalogEquipmentName = catalogEquipmentName;
	}

	public String getItemsType() {
		return itemsType;
	}

	public void setItemsType(String itemsType) {
		this.itemsType = itemsType;
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
		return "CatalogEquipment [catalogEquipmentId=" + catalogEquipmentId + ", catalogEquipmentName="
				+ catalogEquipmentName + ", itemsType=" + itemsType + ", active=" + active + ", userCreate="
				+ userCreate + ", timeCreate=" + timeCreate + ", userUpdate=" + userUpdate + ", timeUpdate="
				+ timeUpdate + "]";
	}
	
}
