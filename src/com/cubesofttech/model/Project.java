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
@Table(name = "project")
public class Project implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "project_id")
	private Integer project_id;

	@Column(name = "project_name")
	private String project_name;

	@Column(name = "description")
	private String description;
	
	@Column(name = "status")
	private String status_project;

	@Column(name = "user_create")
	private String user_create;

	@Column(name = "time_create")
	private Timestamp time_create;

	@Column(name = "user_update")
	private String user_update;

	@Column(name = "time_update")
	private Timestamp time_update;
	

	public Project(Integer project_id, String project_name, String description, String status_project, String user_create,
			Timestamp time_create, String user_update, Timestamp time_update) {
		super();
		this.project_id = project_id;
		this.project_name = project_name;
		this.description = description;
		this.status_project = status_project;
		this.user_create = user_create;
		this.time_create = time_create;
		this.user_update = user_update;
		this.time_update = time_update;
	}

	public Project() {
		// TODO Auto-generated constructor stub
	}

	public Integer getProject_id() {
		return project_id;
	}

	public void setProject_id(Integer project_id) {
		this.project_id = project_id;
	}

	public String getProject_name() {
		return project_name;
	}

	public void setProject_name(String project_name) {
		this.project_name = project_name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getStatus_project() {
		return status_project;
	}

	public void setStatus_project(String status_project) {
		this.status_project = status_project;
	}

	public String getUser_create() {
		return user_create;
	}

	public void setUser_create(String user_create) {
		this.user_create = user_create;
	}

	public Timestamp getTime_create() {
		return time_create;
	}

	public void setTime_create(Timestamp time_create) {
		this.time_create = time_create;
	}

	public String getUser_update() {
		return user_update;
	}

	public void setUser_update(String user_update) {
		this.user_update = user_update;
	}

	public Timestamp getTime_update() {
		return time_update;
	}

	public void setTime_update(Timestamp time_update) {
		this.time_update = time_update;
	}

}
