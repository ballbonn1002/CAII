package com.cubesofttech.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "log_action")
public class LogAction implements Serializable {

	@Id
	@Column(name="log_action_id")
	private Integer logActionId;
	
	@Column(name="log_data")
	private String logData;
	
	@Column(name="user_create")
	private String user_create;
	
	@Column(name="user_update")
	private String user_update;
	
	@Column(name="time_create")
	private java.sql.Timestamp time_create;
	
	@Column(name="time_update")
	private java.sql.Timestamp time_update;

	
	public Integer getLogActionId() {
		return logActionId;
	}

	public void setLogActionId(Integer logActionId) {
		this.logActionId = logActionId;
	}

	public String getLogData() {
		return logData;
	}

	public void setLogData(String logData) {
		this.logData = logData;
	}

	public String getUser_create() {
		return user_create;
	}

	public void setUser_create(String user_create) {
		this.user_create = user_create;
	}

	public String getUser_update() {
		return user_update;
	}

	public void setUser_update(String user_update) {
		this.user_update = user_update;
	}

	public java.sql.Timestamp getTime_create() {
		return time_create;
	}

	public void setTime_create(java.sql.Timestamp time_create) {
		this.time_create = time_create;
	}

	public java.sql.Timestamp getTime_update() {
		return time_update;
	}

	public void setTime_update(java.sql.Timestamp time_update) {
		this.time_update = time_update;
	}
	
}
