package com.cubesofttech.model;

import java.io.Serializable;
import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "holiday")
public class Holiday implements Serializable {

	@Id
	//@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id_date")
	private Long id_date;

	@Column(name = "start_date")
	private java.sql.Date start_date;
	@Column(name = "end_date")
	private java.sql.Date end_date;

	@Column(name = "head", length = 200)
	public String head;
	@Column(name = "description", length = 2000)
	public String description;
	
	@Column(name = "user_create", length = 150)
	public String user_create;
	@Column(name = "user_update", length = 150)
	public String user_update;
	
	@Column(name = "time_create", length = 150)
	public java.sql.Timestamp time_create;
	@Column(name = "time_update", length = 150)
	public java.sql.Timestamp time_update;

	public Holiday() {
		super();
	}
	
	public Holiday(Date start_date, Date end_date, String head, String description, String user_create, String user_update, java.sql.Timestamp time_create, java.sql.Timestamp time_update) {
		super();
		this.start_date = start_date;
		this.end_date = end_date;
		this.head = head;
		this.description = description;
		this.user_create = user_create;
		this.user_update = user_update;
		this.time_create = time_create;
		this.time_update = time_update;
	}
	
	public java.sql.Date getStart_date() {
		return start_date;
	}
	public void setStart_date(java.sql.Date start_date) {
		this.start_date = start_date;
	}

	public Long getId_date() {
		return id_date;
	}
	public void setId_date(Long id_date) {
		this.id_date = id_date;
	}
	public java.sql.Date getEnd_date() {
		return end_date;
	}
	public void setEnd_date(java.sql.Date end_date) {
		this.end_date = end_date;
	}
	public String getHead() {
		return head;
	}
	public void setHead(String head) {
		this.head = head;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
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
