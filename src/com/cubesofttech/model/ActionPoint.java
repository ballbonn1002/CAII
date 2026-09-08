package com.cubesofttech.model;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "token_action_point")
public class ActionPoint {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "action_point_id")
	private Integer actionPointId;
	
	@Column(name = "action_type_id")
	private Integer actionTypeId;
	
	@Column(name = "action_point_type")
	private String actionPointType;
	
	@Column(name = "action_point_name_th")
	private String actionPointNameTH;
	
	@Column(name = "point")
	private Double point;
	
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
	
	
	public String getActionPointName() {
		return actionPointNameTH;
	}

	public void setActionPointName(String actionPointName) {
		this.actionPointNameTH = actionPointName;
	}

	public String getActionPointType() {
		return actionPointType;
	}

	public void setActionPointType(String actionPointType) {
		this.actionPointType = actionPointType;
	}


	public Integer getActionTypeId() {
		return actionTypeId;
	}

	public void setActionTypeId(Integer actionTypeId) {
		this.actionTypeId = actionTypeId;
	}

	public Double getPoint() {
		return point;
	}

	public void setPoint(Double point) {
		this.point = point;
	}


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

	public Integer getActionPointId() {
		return actionPointId;
	}

}
