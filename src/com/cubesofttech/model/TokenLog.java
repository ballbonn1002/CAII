package com.cubesofttech.model;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name = "token_log")
public class TokenLog {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "token_log_id")
	private Integer tokenLogId;
	
	@Column(name = "user_id")
	private String userId;
	
	@Column(name = "activity_log")
	private String activityLog;
	
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

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getActivityLog() {
		return activityLog;
	}

	public void setActivityLog(String activityLog) {
		this.activityLog = activityLog;
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

	public Integer getTokenLogId() {
		return tokenLogId;
	}
	
	
}
