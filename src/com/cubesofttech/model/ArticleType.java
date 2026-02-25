package com.cubesofttech.model;

import java.io.Serializable;
import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "article_type")
public class ArticleType implements Serializable{
	public ArticleType() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public ArticleType(Integer articleTypeId, String name,  String description, String userCreate,
			Timestamp timeCreate, String userUpdate, Timestamp timeUpdate) {
		super();
		this.articleTypeId = articleTypeId;
		this.name = name;
		this.description = description;
		this.userCreate = userCreate;
		this.timeCreate = timeCreate;
		this.userUpdate = userUpdate;
		this.timeUpdate = timeUpdate;
	}


	@Id
	@Column(name = "article_type_id")
	private Integer articleTypeId;
	
	@Column(name = "name")
	private String name;

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

	public Integer getArticleTypeId() {
		return articleTypeId;
	}

	public void setArticleTypeId(Integer articleTypeId) {
		this.articleTypeId = articleTypeId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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
