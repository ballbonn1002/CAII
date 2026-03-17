package com.cubesofttech.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "overtime")
public class Overtime implements Serializable {

	public Overtime() {
	}

	public Overtime(Integer otId, Date otDate, Timestamp startTime, Timestamp endTime, BigDecimal reqHours,
			BigDecimal apprHours, BigDecimal typeOfOt, String description, String descriptionAppr, String status,
			String userId, String apprUserId, Timestamp approvedAt, String userCreate, Timestamp timeCreate,
			String userUpdate, Timestamp timeUpdate) {
		this.ot_id = otId;
		this.ot_date = otDate;
		this.start_time = startTime;
		this.end_time = endTime;
		this.req_hours = reqHours;
		this.appr_hours = apprHours;
		this.type_of_ot = typeOfOt;
		this.description = description;
		this.description_appr = descriptionAppr;
		this.status = status;
		this.user_id = userId;
		this.appr_user_id = apprUserId;
		this.approved_at = approvedAt;
		this.user_create = userCreate;
		this.time_create = timeCreate;
		this.user_update = userUpdate;
		this.time_update = timeUpdate;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ot_id")
	private Integer ot_id;

	@Temporal(TemporalType.DATE)
	@Column(name = "ot_date")
	private Date ot_date;

	@Column(name = "start_time")
	private Timestamp start_time;

	@Column(name = "end_time")
	private Timestamp end_time;

	@Column(name = "req_hours")
	private BigDecimal req_hours;

	@Column(name = "appr_hours")
	private BigDecimal appr_hours;

	@Column(name = "type_of_ot")
	private BigDecimal type_of_ot;

	@Column(name = "description")
	private String description;

	@Column(name = "description_appr")
	private String description_appr;

	@Column(name = "status")
	private String status;

	@Column(name = "user_id")
	private String user_id;

	@Column(name = "appr_user_id")
	private String appr_user_id;

	@Column(name = "approved_at")
	private Timestamp approved_at;

	@Column(name = "user_create")
	private String user_create;

	@Column(name = "time_create")
	private Timestamp time_create;

	@Column(name = "user_update")
	private String user_update;

	@Column(name = "time_update")
	private Timestamp time_update;

	public Integer getOt_id() {
		return ot_id;
	}

	public void setOt_id(Integer otId) {
		this.ot_id = otId;
	}

	public Date getOt_date() {
		return ot_date;
	}

	public void setOt_date(Date otDate) {
		this.ot_date = otDate;
	}

	public Timestamp getStart_time() {
		return start_time;
	}

	public void setStart_time(Timestamp startTime) {
		this.start_time = startTime;
	}

	public Timestamp getEnd_time() {
		return end_time;
	}

	public void setEnd_time(Timestamp endTime) {
		this.end_time = endTime;
	}

	public BigDecimal getReq_hours() {
		return req_hours;
	}

	public void setReq_hours(BigDecimal reqHours) {
		this.req_hours = reqHours;
	}

	public BigDecimal getAppr_hours() {
		return appr_hours;
	}

	public void setAppr_hours(BigDecimal apprHours) {
		this.appr_hours = apprHours;
	}

	public BigDecimal getType_of_ot() {
		return type_of_ot;
	}

	public void setType_of_ot(BigDecimal typeOfOt) {
		this.type_of_ot = typeOfOt;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getDescription_appr() {
		return description_appr;
	}

	public void setDescription_appr(String descriptionAppr) {
		this.description_appr = descriptionAppr;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String userId) {
		this.user_id = userId;
	}

	public String getAppr_user_id() {
		return appr_user_id;
	}

	public void setAppr_user_id(String apprUserId) {
		this.appr_user_id = apprUserId;
	}

	public Timestamp getApproved_at() {
		return approved_at;
	}

	public void setApproved_at(Timestamp approvedAt) {
		this.approved_at = approvedAt;
	}

	public String getUser_create() {
		return user_create;
	}

	public void setUser_create(String userCreate) {
		this.user_create = userCreate;
	}

	public Timestamp getTime_create() {
		return time_create;
	}

	public void setTime_create(Timestamp timeCreate) {
		this.time_create = timeCreate;
	}

	public String getUser_update() {
		return user_update;
	}

	public void setUser_update(String userUpdate) {
		this.user_update = userUpdate;
	}

	public Timestamp getTime_update() {
		return time_update;
	}

	public void setTime_update(Timestamp timeUpdate) {
		this.time_update = timeUpdate;
	}
}