package com.cubesofttech.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "announcement")
public class Announcement implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id
	
	@Column(name = "announcement_id")
	private Integer announcementId;
	@Column(name = "topic")
	private String topic;
	@Column(name = "file_id")
	private String file_id;
	@Column(name = "detail")
	private String detail;
	@Column(name = "status")
	private String status;
	@Column(name = "announcement_date")
	private Date announcement_date;
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
	@Column(name = "readcount")
	private Integer readcount;
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "file_id", referencedColumnName = "file_id", insertable = false, updatable = false)
    private FileUpload fileUpload;
	
	public FileUpload getFileUpload() {
		return fileUpload;
	}
	public void setFileUpload(FileUpload fileUpload) {
		this.fileUpload = fileUpload;
	}
	public Integer getAnnouncementId() {
		return announcementId;
	}
	public void setAnnouncementId(Integer announcementId) {
		this.announcementId = announcementId;
	}
	public String getTopic() {
		return topic;
	}
	public void setTopic(String topic) {
		this.topic = topic;
	}
	public String getFile_id() {
		return file_id;
	}
	public void setFile_id(String file_id) {
		this.file_id = file_id;
	}
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Date getannouncement_date() {
		return announcement_date;
	}
	public void setannouncement_date(Date announcement_date) {
		this.announcement_date = announcement_date;
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
	public Integer getReadcount() {
		return readcount;
	}
	public void setReadcount(Integer readcount) {
		this.readcount = readcount;
	}
}
