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
@Table(name = "project_function")
public class ProjectFunction implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "function_id")
	private Integer function_id;

	@Column(name = "function_name")
	private String function_name;

	@Column(name = "status")
	private String status;

	@Column(name = "project_id")
	private Integer project_id;

	@Column(name = "user_create")
	private String user_create;

	@Column(name = "time_create")
	private Timestamp time_create;

	@Column(name = "user_update")
	private String user_update;

	@Column(name = "time_update")
	private Timestamp time_update;

	public ProjectFunction(Integer function_id, String function_name, String status, Integer project_id,
			String user_create, Timestamp time_create, String user_update, Timestamp time_update) {
		super();
		this.function_id = function_id;
		this.function_name = function_name;
		this.status = status;
		this.project_id = project_id;
		this.user_create = user_create;
		this.time_create = time_create;
		this.user_update = user_update;
		this.time_update = time_update;
	}

	public ProjectFunction() {
	}

	public Integer getFunction_id() {
		return function_id;
	}

	public void setFunction_id(Integer function_id) {
		this.function_id = function_id;
	}

	public String getFunction_name() {
		return function_name;
	}

	public void setFunction_name(String function_name) {
		this.function_name = function_name;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Integer getProject_id() {
		return project_id;
	}

	public void setProject_id(Integer project_id) {
		this.project_id = project_id;
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

	@Override
	public String toString() {
		return "ProjectFunction [function_id=" + function_id + ", function_name=" + function_name + ", status=" + status
				+ ", project_id=" + project_id + ", user_create=" + user_create + ", time_create=" + time_create
				+ ", user_update=" + user_update + ", time_update=" + time_update + "]";
	}
}