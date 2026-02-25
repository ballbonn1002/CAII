package com.cubesofttech.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
 @Entity
@Table(name = "tag")
public class Tag implements Serializable{

	
	public Tag() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Tag(Integer tagId, String tag, String tagDescription, String userCreate, Timestamp timeCreate,
			String userUpdate, Timestamp timeUpdate) {
		super();
		this.tagId = tagId;
		this.tagName = tag;
		this.tagDescription = tagDescription;
		this.userCreate = userCreate;
		this.timeCreate = timeCreate;
		this.userUpdate = userUpdate;
		this.timeUpdate = timeUpdate;
	}

	@Id
	@Column(name = "tag_id")
	private Integer tagId;
	
	@Column(name = "name")
	private String tagName;
	
	@Column(name = "description")
	private String tagDescription;
	
	@Column(name = "user_create")
	private String userCreate;
	
	@Column(name = "time_create")
	private java.sql.Timestamp timeCreate;
	
	@Column(name = "user_update")
	private String userUpdate;
	
	@Column(name = "time_update")
	private java.sql.Timestamp timeUpdate;

	public Integer getTagId() {
		return tagId;
	}

	public void setTagId(Integer tagId) {
		this.tagId = tagId;
	}


	public String getTagName() {
		return tagName;
	}

	public void setTagName(String tagName) {
		this.tagName = tagName;
	}

	public String getTagDescription() {
		return tagDescription;
	}

	public void setTagDescription(String tagDescription) {
		this.tagDescription = tagDescription;
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
