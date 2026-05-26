package com.cubesofttech.model;

import java.io.Serializable;
import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "exp_travel_type")
@NamedQueries({ @NamedQuery(name = "ExpTravelType.findAll", query = "SELECT t FROM ExpTravelType t") })
public class ExpTravelType implements Serializable {

	/** Creates a new instance of ExpTravelType */
	public ExpTravelType() {
	}

	public ExpTravelType(Long expTravelTypeId, String name, String description, String userCreate, String userUpdate,
			Timestamp timeCreate, Timestamp timeUpdate, String active) {
		this.expTravelTypeId = expTravelTypeId;
		this.name = name;
		this.description = description;
		this.userCreate = userCreate;
		this.userUpdate = userUpdate;
		this.timeCreate = timeCreate;
		this.timeUpdate = timeUpdate;
		this.active = active;
	}

	@Id
	@Column(name = "exp_travel_type_id")
	private Long expTravelTypeId;

	@Column(name = "name")
	private String name;

	@Column(name = "description")
	private String description;

	@Column(name = "user_create")
	private String userCreate;

	@Column(name = "user_update")
	private String userUpdate;

	@Column(name = "time_create")
	private Timestamp timeCreate;

	@Column(name = "time_update")
	private Timestamp timeUpdate;

	@Column(name = "active")
	private String active;

	// ===== Getter / Setter =====

	public Long getExpTravelTypeId() {
		return expTravelTypeId;
	}

	public void setExpTravelTypeId(Long expTravelTypeId) {
		this.expTravelTypeId = expTravelTypeId;
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

	public String getUserUpdate() {
		return userUpdate;
	}

	public void setUserUpdate(String userUpdate) {
		this.userUpdate = userUpdate;
	}

	public Timestamp getTimeCreate() {
		return timeCreate;
	}

	public void setTimeCreate(Timestamp timeCreate) {
		this.timeCreate = timeCreate;
	}

	public Timestamp getTimeUpdate() {
		return timeUpdate;
	}

	public void setTimeUpdate(Timestamp timeUpdate) {
		this.timeUpdate = timeUpdate;
	}

	public String getActive() {
		return active;
	}

	public void setActive(String active) {
		this.active = active;
	}

	// ===== toString / equals =====

	@Override
	public String toString() {
		return super.toString() + "expTravelTypeId=[" + expTravelTypeId + "]\n" + "name=[" + name + "]\n"
				+ "description=[" + description + "]\n" + "userCreate=[" + userCreate + "]\n" + "userUpdate=["
				+ userUpdate + "]\n" + "timeCreate=[" + timeCreate + "]\n" + "timeUpdate=[" + timeUpdate + "]\n"
				+ "active=[" + active + "]\n";
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (!(obj instanceof ExpTravelType))
			return false;

		ExpTravelType that = (ExpTravelType) obj;

		if (!(that.getExpTravelTypeId() == null ? this.getExpTravelTypeId() == null
				: that.getExpTravelTypeId().equals(this.getExpTravelTypeId())))
			return false;

		if (!(that.getName() == null ? this.getName() == null : that.getName().equals(this.getName())))
			return false;

		if (!(that.getActive() == null ? this.getActive() == null : that.getActive().equals(this.getActive())))
			return false;

		if (!(that.getDescription() == null ? this.getDescription() == null
				: that.getDescription().equals(this.getDescription())))
			return false;

		if (!(that.getUserCreate() == null ? this.getUserCreate() == null
				: that.getUserCreate().equals(this.getUserCreate())))
			return false;

		if (!(that.getUserUpdate() == null ? this.getUserUpdate() == null
				: that.getUserUpdate().equals(this.getUserUpdate())))
			return false;

		if (!(that.getTimeCreate() == null ? this.getTimeCreate() == null
				: that.getTimeCreate().equals(this.getTimeCreate())))
			return false;

		if (!(that.getTimeUpdate() == null ? this.getTimeUpdate() == null
				: that.getTimeUpdate().equals(this.getTimeUpdate())))
			return false;

		return true;
	}
}
