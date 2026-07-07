package com.cubesofttech.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "footer")
public class Footer implements Serializable {

	private static final long serialVersionUID = 1L;

	public Footer() {
	}

	public Footer(long footer_id, String parent_footer_id, String footer_name, String footer_url, String status,
			Integer sequence, String description, String userCreate, String userUpdate, java.sql.Timestamp timeCreate,
			java.sql.Timestamp timeUpdate, String footer_name_th) {
		// ไปเชื่อมโมเดลก่อน
		this.footer_id = footer_id;
		this.parent_footer_id = parent_footer_id;
		this.footer_name = footer_name;
		this.footer_url = footer_url;
		this.status = status;
		this.sequence = sequence;
		this.description = description;
		this.userCreate = userCreate;
		this.userUpdate = userUpdate;
		this.timeCreate = timeCreate;
		this.timeUpdate = timeUpdate;
		this.footer_name_th = footer_name_th;

	}

	// ในฐานข้อมูลตั้งว่าอะไร
	@Id
	@Column(name = "footer_id")
	private long footer_id;
	@Column(name = "parent_footer_id")
	private String parent_footer_id;
	@Column(name = "footer_name")
	private String footer_name;
	@Column(name = "footer_url")
	private String footer_url;
	@Column(name = "status")
	private String status;
	@Column(name = "sequence")
	private Integer sequence;
	@Column(name = "description")
	private String description;
	@Column(name = "user_create")
	private String userCreate;
	@Column(name = "user_update")
	private String userUpdate;
	@Column(name = "time_create")
	private java.sql.Timestamp timeCreate;
	@Column(name = "time_update")
	private java.sql.Timestamp timeUpdate;
	@Column(name = "footer_name_th")
	private String footer_name_th;

	public long getFooter_id() {
		return footer_id;
	}

	public void setFooter_id(long footer_id) {
		this.footer_id = footer_id;
	}

	public String getParent_footer_id() {
		return parent_footer_id;
	}

	public void setParent_footer_id(String parent_footer_id) {
		this.parent_footer_id = parent_footer_id;
	}

	public String getFooter_name() {
		return footer_name;
	}

	public void setFooter_name(String footer_name) {
		this.footer_name = footer_name;
	}

	public String getFooter_url() {
		return footer_url;
	}

	public void setFooter_url(String footer_url) {
		this.footer_url = footer_url;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Integer getSequence() {
		return sequence;
	}

	public void setSequence(Integer sequence) {
		this.sequence = sequence;
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

	public java.sql.Timestamp getTimeCreate() {
		return timeCreate;
	}

	public void setTimeCreate(java.sql.Timestamp timeCreate) {
		this.timeCreate = timeCreate;
	}

	public java.sql.Timestamp getTimeUpdate() {
		return timeUpdate;
	}

	public void setTimeUpdate(java.sql.Timestamp timeUpdate) {
		this.timeUpdate = timeUpdate;
	}

	public String getFooter_name_th() {
		return footer_name_th;
	}

	public void  setFooter_name_th(String footer_name_th) {
		this.footer_name_th = footer_name_th;
	}

}
