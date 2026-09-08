package com.cubesofttech.model;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "token_action_type")
public class ActionType {
	
	@Id
	@Column(name = "action_type_id")
	private Integer actionTypeId;
	
	@Column(name = "action_type_name")
	private String actionTypeName;
	
	@Column(name = "active_status")
	private String activeStatus;
	
	@Column(name = "description")
	private String description;
	
	@Column(name = "user_create")
	private String userCreate;
	
	@Column(name = "user_update")
	private String userUpdate;
	
	@Column(name = "time_create")
	private Timestamp timeCreate;
	
	@Column(name = "time_update")
	private Timestamp timeUpdate;

	public String getActiveStatus() {
		return activeStatus;
	}

	public void setActiveStatus(String activeStatus) {
		this.activeStatus = activeStatus;
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

	public Timestamp getTimeCreate() {
		return timeCreate;
	}

	public void setTimeCreate(Timestamp timeCreate) {
		this.timeCreate = timeCreate;
	}

	public Timestamp getTimeUpdate() {
		return timeUpdate;
	}

	public void setTimeUpdate(Timestamp timeUpdate) {
		this.timeUpdate = timeUpdate;
	}

	public Integer getActionTypeId() {
		return actionTypeId;
	}

	public String getActionTypeName() {
		return actionTypeName;
	}

	public void setActionTypeName(String actionTypeName) {
		this.actionTypeName = actionTypeName;
	}
}
