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
	public Jobsite() {}
	public Jobsite(
			Integer idSitejob
			, String nameSite
			, java.sql.Timestamp timeCreate
			, java.sql.Timestamp timeUpdate
			, String userCreate
			, String userUpdate
			, String description
			, String isActive
		) {
		this.id_sitejob = idSitejob;
		this.name_site = nameSite;
		this.time_create = timeCreate;
		this.time_update = timeUpdate;
		this.user_create = userCreate;
		this.user_update = userUpdate;
		this.description = description;
		this.is_active = isActive;
	}
	
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

	public void setId_sitejob(Integer idSitejob) {
		this.id_sitejob = idSitejob;
	}

	public String getName_site() {
		return name_site;
	}

	public void setName_site(String nameSite) {
		this.name_site = nameSite;
	}

	public Timestamp getTime_create() {
		return time_create;
	}

	public void setTime_create(Timestamp timeCreate) {
		this.time_create = timeCreate;
	}

	public Timestamp getTime_update() {
		return time_update;
	}

	public void setTime_update(Timestamp timeUpdate) {
		this.time_update = timeUpdate;
	}

	public String getUser_create() {
		return user_create;
	}

	public void setUser_create(String userCreate) {
		this.user_create = userCreate;
	}

	public String getUser_update() {
		return user_update;
	}

	public void setUser_update(String userUpdate) {
		this.user_update = userUpdate;
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

	public void setIs_active(String isActive) {
		this.is_active = isActive;
	}
	
}
