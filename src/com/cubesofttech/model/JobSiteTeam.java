package com.cubesofttech.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "job_site_team")
public class JobSiteTeam implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "job_site_team_id")
	private Integer job_site_team_id;

	@Column(name = "id_sitejob")
	private String id_sitejob;

	@Column(name = "user_id")
	private String user_id;

	public Integer getJob_site_team_id() {
		return job_site_team_id;
	}

	public void setJob_site_team_id(Integer job_site_team_id) {
		this.job_site_team_id = job_site_team_id;
	}

	public String getId_sitejob() {
		return id_sitejob;
	}

	public void setId_sitejob(String id_sitejob) {
		this.id_sitejob = id_sitejob;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

}
