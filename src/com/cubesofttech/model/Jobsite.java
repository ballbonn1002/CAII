package com.cubesofttech.model;

import java.io.Serializable;
import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "job_site")
public class Jobsite implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id_sitejob")
	private Integer id_sitejob;
	
	@Column(name = "name_site")
	private String name_site;
	
	@Column(name = "time_create")
	private Timestamp time_create;
	
	@Column(name = "time_update")
	private Timestamp time_update;
	
	@Column(name = "user_create")
	private String user_create;
	
	@Column(name = "user_update")
	private String user_update;
	
	@Column(name = "description")
	private String description;

	@Column(name = "is_active")
	private String is_active;
	
	public Integer getId_sitejob() {
		return id_sitejob;
	}

	public void setId_sitejob(Integer id_sitejob) {
		this.id_sitejob = id_sitejob;
	}

	public String getName_site() {
		return name_site;
	}

	public void setName_site(String name_site) {
		this.name_site = name_site;
	}

	public Timestamp getTime_create() {
		return time_create;
	}

	public void setTime_create(Timestamp time_create) {
		this.time_create = time_create;
	}

	public Timestamp getTime_update() {
		return time_update;
	}

	public void setTime_update(Timestamp time_update) {
		this.time_update = time_update;
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

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getIs_active() {
		return is_active;
	}

	public void setIs_active(String is_active) {
		this.is_active = is_active;
	}
	
}
