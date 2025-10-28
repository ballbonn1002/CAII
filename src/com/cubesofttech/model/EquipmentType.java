package com.cubesofttech.model;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "equipment_type")
public class EquipmentType {
	
	public EquipmentType() {}
	
	@Id
	@Column(name = "Type")
	private String TypeID;
	@Column(name = "description")
	private String description;
	@Column(name = "user_create")
	private String userCreate;
	@Column(name = "time_create")
	private java.sql.Timestamp timeCreate;
	@Column(name = "user_update")
	private String userUpdate;
	@Column(name = "time_update")
	private java.sql.Timestamp timeUpdate;
	
	
	@Override
	public String toString() {
		return "EquipmentType [TypeID=" + TypeID + ", description=" + description + ", userCreate=" + userCreate
				+ ", timeCreate=" + timeCreate + ", userUpdate=" + userUpdate + ", timeUpdate=" + timeUpdate + "]";
	}
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((TypeID == null) ? 0 : TypeID.hashCode());
		result = prime * result + ((description == null) ? 0 : description.hashCode());
		result = prime * result + ((timeCreate == null) ? 0 : timeCreate.hashCode());
		result = prime * result + ((timeUpdate == null) ? 0 : timeUpdate.hashCode());
		result = prime * result + ((userCreate == null) ? 0 : userCreate.hashCode());
		result = prime * result + ((userUpdate == null) ? 0 : userUpdate.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		EquipmentType other = (EquipmentType) obj;
		if (TypeID == null) {
			if (other.TypeID != null)
				return false;
		} else if (!TypeID.equals(other.TypeID))
			return false;
		if (description == null) {
			if (other.description != null)
				return false;
		} else if (!description.equals(other.description))
			return false;
		if (timeCreate == null) {
			if (other.timeCreate != null)
				return false;
		} else if (!timeCreate.equals(other.timeCreate))
			return false;
		if (timeUpdate == null) {
			if (other.timeUpdate != null)
				return false;
		} else if (!timeUpdate.equals(other.timeUpdate))
			return false;
		if (userCreate == null) {
			if (other.userCreate != null)
				return false;
		} else if (!userCreate.equals(other.userCreate))
			return false;
		if (userUpdate == null) {
			if (other.userUpdate != null)
				return false;
		} else if (!userUpdate.equals(other.userUpdate))
			return false;
		return true;
	}

	public EquipmentType(String typeID, String description, String userCreate, Timestamp timeCreate, String userUpdate,
			Timestamp timeUpdate) {
		super();
		TypeID = typeID;
		this.description = description;
		this.userCreate = userCreate;
		this.timeCreate = timeCreate;
		this.userUpdate = userUpdate;
		this.timeUpdate = timeUpdate;
	}

	public String getTypeID() {
		return TypeID;
	}
	public void setTypeID(String typeID) {
		TypeID = typeID;
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
	
	
	
}
