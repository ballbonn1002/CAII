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
@Table(name = "page_uri")
public class PageUri implements Serializable{

	public PageUri() {
		super();
		// TODO Auto-generated constructor stub
	}

	public PageUri(String pageUriId, String forwardTo, String model, String modelId, String pageUriDescription,
			String pageUriTitle, String meta, String userCreate, Timestamp timeCreate, String userUpdate,
			Timestamp timeUpdate) {
		super();
		this.pageUriId = pageUriId;
		this.forwardTo = forwardTo;
		this.model = model;
		this.modelId = modelId;
		this.pageUriDescription = pageUriDescription;
		this.pageUriTitle = pageUriTitle;
		this.meta = meta;
		this.userCreate = userCreate;
		this.timeCreate = timeCreate;
		this.userUpdate = userUpdate;
		this.timeUpdate = timeUpdate;
	}

	@Column(name = "page_uri_id")
	private String pageUriId;
	
	@Column(name = "forward_to")
	private String forwardTo;
	
	@Column(name = "model")
	private String model;
	
	@Id
	@Column(name = "model_id")
	private String modelId;
	
	@Column(name = "description")
	private String pageUriDescription;
	
	@Column(name = "title")
	private String pageUriTitle;
	
	@Column(name = "meta")
	private String meta;
	
	@Column(name = "user_create")
	private String userCreate;
	
	@Column(name = "time_create")
	private java.sql.Timestamp timeCreate;
	
	@Column(name = "user_update")
	private String userUpdate;
	
	@Column(name = "time_update")
	private java.sql.Timestamp timeUpdate;

	public String getPageUriId() {
		return pageUriId;
	}

	public void setPageUriId(String pageUriId) {
		this.pageUriId = pageUriId;
	}

	public String getForwardTo() {
		return forwardTo;
	}

	public void setForwardTo(String forwardTo) {
		this.forwardTo = forwardTo;
	}

	public String getModel() {
		return model;
	}

	public void setModel(String model) {
		this.model = model;
	}

	public String getModelId() {
		return modelId;
	}

	public void setModelId(String modelId) {
		this.modelId = modelId;
	}

	public String getPageUriDescription() {
		return pageUriDescription;
	}

	public void setPageUriDescription(String pageUriDescription) {
		this.pageUriDescription = pageUriDescription;
	}

	public String getPageUriTitle() {
		return pageUriTitle;
	}

	public void setPageUriTitle(String pageUriTitle) {
		this.pageUriTitle = pageUriTitle;
	}

	public String getMeta() {
		return meta;
	}

	public void setMeta(String meta) {
		this.meta = meta;
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
