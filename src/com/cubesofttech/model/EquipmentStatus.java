package com.cubesofttech.model;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "equipment_status")
public class EquipmentStatus {
	
	public EquipmentStatus() {}
	
	@Id
	@Column(name = "status")
	private String statusId;
	@Column(name = "description")
	private String description;
	@Column(name = "color")
	private String color;
	@Column(name = "user_create")
	private String userCreate;
	@Column(name = "time_create")
	private java.sql.Timestamp timeCreate;
	@Column(name = "user_update")
	private String userUpdate;
	@Column(name = "time_update")
	private java.sql.Timestamp timeUpdate;
	
	public String getStatusId() {
		return statusId;
	}
	public void setStatusId(String statusId) {
		this.statusId = statusId;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
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
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((color == null) ? 0 : color.hashCode());
		result = prime * result + ((description == null) ? 0 : description.hashCode());
		result = prime * result + ((statusId == null) ? 0 : statusId.hashCode());
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
		EquipmentStatus other = (EquipmentStatus) obj;
		if (color == null) {
			if (other.color != null)
				return false;
		} else if (!color.equals(other.color))
			return false;
		if (description == null) {
			if (other.description != null)
				return false;
		} else if (!description.equals(other.description))
			return false;
		if (statusId == null) {
			if (other.statusId != null)
				return false;
		} else if (!statusId.equals(other.statusId))
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
	@Override
	public String toString() {
		return "EquipmentStatus [statusId=" + statusId + ", description=" + description + ", color=" + color
				+ ", userCreate=" + userCreate + ", timeCreate=" + timeCreate + ", userUpdate=" + userUpdate
				+ ", timeUpdate=" + timeUpdate + "]";
	}
	
	public EquipmentStatus(String statusId, String description, String color, String userCreate, Timestamp timeCreate,
			String userUpdate, Timestamp timeUpdate) {
		super();
		this.statusId = statusId;
		this.description = description;
		this.color = color;
		this.userCreate = userCreate;
		this.timeCreate = timeCreate;
		this.userUpdate = userUpdate;
		this.timeUpdate = timeUpdate;
	}
	
}
