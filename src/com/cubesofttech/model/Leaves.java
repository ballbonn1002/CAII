package com.cubesofttech.model;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "leaves")
@NamedQueries({ @NamedQuery(name = "Leaves.findAll", query = "SELECT t FROM Leaves t") })
public class Leaves implements Serializable {

	/** Creates a new instance of Leaves */
	public Leaves() {
	}

	public Leaves(Integer leaveId, String leaveTypeId, String leaveStatusId, String halfDay, String userId,
			String apprUserId, String description, String reason, String startTime, String endTime,
			java.sql.Timestamp startDate, java.sql.Timestamp endDate, BigDecimal noDay, String leaveFile,
			String userCreate, String userUpdate, java.sql.Timestamp timeCreate, java.sql.Timestamp timeUpdate) {
		this.leaveId = leaveId;
		this.leaveTypeId = leaveTypeId;
		this.leaveStatusId = leaveStatusId;
		this.halfDay = halfDay;
		this.userId = userId;
		this.apprUserId = apprUserId;
		this.description = description;
		this.reason = reason;
		this.startTime = startTime;
		this.endTime = endTime;
		this.startDate = startDate;
		this.endDate = endDate;
		this.leaveFile = leaveFile;
		this.userCreate = userCreate;
		this.userUpdate = userUpdate;
		this.timeCreate = timeCreate;
		this.timeUpdate = timeUpdate;
	}

	@Id

	@Column(name = "leave_id")
	private Integer leaveId;
	@Column(name = "leave_type_id")
	private String leaveTypeId;
	@Column(name = "leave_status_id")
	private String leaveStatusId;
	@Column(name = "half_day")
	private String halfDay;
	@Column(name = "user_id")
	private String userId;
	@Column(name = "appr_user_id")
	private String apprUserId;
	@Column(name = "description")
	private String description;
	@Column(name = "reason")
	private String reason;
	@Column(name = "start_time")
	private String startTime;
	@Column(name = "end_time")
	private String endTime;
	@Column(name = "start_date")
	private java.sql.Timestamp startDate;
	@Column(name = "end_date")
	private java.sql.Timestamp endDate;
	@Column(name = "no_day")
	private BigDecimal noDay;
	@Column(name = "leave_file")
	private String leaveFile;
	@Column(name = "user_create")
	private String userCreate;
	@Column(name = "user_update")
	private String userUpdate;
	@Column(name = "time_create")
	private java.sql.Timestamp timeCreate;
	@Column(name = "time_update")
	private java.sql.Timestamp timeUpdate;
	@Column(name = "no2_day")


	public Integer getLeaveId() {
		return this.leaveId;
	}

	public void setLeaveId(Integer leaveId) {
		this.leaveId = leaveId;
	}

	public String getLeaveTypeId() {
		return this.leaveTypeId;
	}

	public void setLeaveTypeId(String leaveTypeId) {
		this.leaveTypeId = leaveTypeId;
	}

	public String getLeaveStatusId() {
		return this.leaveStatusId;
	}

	public void setLeaveStatusId(String leaveStatusId) {
		this.leaveStatusId = leaveStatusId;
	}

	public String getHalfDay() {
	
		return this.halfDay;
	}

	public void setHalfDay(String halfDay) {
		this.halfDay = halfDay;
	}

	public String getUserId() {
		return this.userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getApprUserId() {
		return this.apprUserId;
	}

	public void setApprUserId(String apprUserId) {
		this.apprUserId = apprUserId;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getReason() {
		return this.reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getStartTime() {
		return this.startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return this.endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public java.sql.Timestamp getStartDate() {
		return this.startDate;
	}

	public void setStartDate(java.sql.Timestamp startDate) {
		this.startDate = startDate;
	}

	public java.sql.Timestamp getEndDate() {
		return this.endDate;
	}

	public void setEndDate(java.sql.Timestamp endDate) {
		this.endDate = endDate;
	}

	public BigDecimal getNoDay() {
		return this.noDay;
	}

	public void setNoDay(BigDecimal noDay) {
		this.noDay = noDay;
	}

	public String getLeaveFile() {
		return this.leaveFile;
	}

	public void setLeaveFile(String leaveFile) {
		this.leaveFile = leaveFile;
	}

	public String getUserCreate() {
		return this.userCreate;
	}

	public void setUserCreate(String userCreate) {
		this.userCreate = userCreate;
	}

	public String getUserUpdate() {
		return this.userUpdate;
	}

	public void setUserUpdate(String userUpdate) {
		this.userUpdate = userUpdate;
	}

	public java.sql.Timestamp getTimeCreate() {
		return this.timeCreate;
	}

	public void setTimeCreate(java.sql.Timestamp timeCreate) {
		this.timeCreate = timeCreate;
	}

	public java.sql.Timestamp getTimeUpdate() {
		return this.timeUpdate;
	}

	public void setTimeUpdate(java.sql.Timestamp timeUpdate) {
		this.timeUpdate = timeUpdate;
	}

	public String toString() {
		return super.toString() + "leaveId=[" + leaveId + "]\n" + "leaveTypeId=[" + leaveTypeId + "]\n"
				+ "leaveStatusId=[" + leaveStatusId + "]\n" + "halfDay=[" + halfDay + "]\n" + "userId=[" + userId
				+ "]\n" + "apprUserId=[" + apprUserId + "]\n" + "description=[" + description + "]\n" + "reason=["
				+ reason + "]\n" + "startTime=[" + startTime + "]\n" + "endTime=[" + endTime + "]\n" + "startDate=["
				+ startDate + "]\n" + "endDate=[" + endDate + "]\n" + "noDay=[" + noDay + "]\n" + "leaveFile=["
				+ leaveFile + "]\n" + "userCreate=[" + userCreate + "]\n" + "userUpdate=[" + userUpdate + "]\n"
				+ "timeCreate=[" + timeCreate + "]\n" + "timeUpdate=[" + timeUpdate + "] \n";
	}

	public boolean equals(Object obj) {
		if (this == obj) {
			return true;
		}
		if (!(obj instanceof Leaves)) {
			return false;
		}
		Leaves that = (Leaves) obj;
		if (!(that.getLeaveId() == null ? this.getLeaveId() == null : that.getLeaveId().equals(this.getLeaveId()))) {
			return false;
		}
		if (!(that.getLeaveTypeId() == null ? this.getLeaveTypeId() == null
				: that.getLeaveTypeId().equals(this.getLeaveTypeId()))) {
			return false;
		}
		if (!(that.getLeaveStatusId() == null ? this.getLeaveStatusId() == null
				: that.getLeaveStatusId().equals(this.getLeaveStatusId()))) {
			return false;
		}
		if (!(that.getHalfDay() == null ? this.getHalfDay() == null : that.getHalfDay().equals(this.getHalfDay()))) {
			return false;
		}
		if (!(that.getUserId() == null ? this.getUserId() == null : that.getUserId().equals(this.getUserId()))) {
			return false;
		}
		if (!(that.getApprUserId() == null ? this.getApprUserId() == null
				: that.getApprUserId().equals(this.getApprUserId()))) {
			return false;
		}
		if (!(that.getDescription() == null ? this.getDescription() == null
				: that.getDescription().equals(this.getDescription()))) {
			return false;
		}
		if (!(that.getReason() == null ? this.getReason() == null : that.getReason().equals(this.getReason()))) {
			return false;
		}
		if (!(that.getStartTime() == null ? this.getStartTime() == null
				: that.getStartTime().equals(this.getStartTime()))) {
			return false;
		}
		if (!(that.getEndTime() == null ? this.getEndTime() == null : that.getEndTime().equals(this.getEndTime()))) {
			return false;
		}
		if (!(that.getStartDate() == null ? this.getStartDate() == null
				: that.getStartDate().equals(this.getStartDate()))) {
			return false;
		}
		if (!(that.getEndDate() == null ? this.getEndDate() == null : that.getEndDate().equals(this.getEndDate()))) {
			return false;
		}
		if (!(that.getNoDay() == null ? this.getNoDay() == null : that.getNoDay().equals(this.getNoDay()))) {
			return false;
		}
		if (!(that.getLeaveFile() == null ? this.getLeaveFile() == null
				: that.getLeaveFile().equals(this.getLeaveFile()))) {
			return false;
		}
		if (!(that.getUserCreate() == null ? this.getUserCreate() == null
				: that.getUserCreate().equals(this.getUserCreate()))) {
			return false;
		}
		if (!(that.getUserUpdate() == null ? this.getUserUpdate() == null
				: that.getUserUpdate().equals(this.getUserUpdate()))) {
			return false;
		}
		if (!(that.getTimeCreate() == null ? this.getTimeCreate() == null
				: that.getTimeCreate().equals(this.getTimeCreate()))) {
			return false;
		}
		if (!(that.getTimeUpdate() == null ? this.getTimeUpdate() == null
				: that.getTimeUpdate().equals(this.getTimeUpdate()))) {
			return false;
		}
		return true;
	}

}
