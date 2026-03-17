package com.cubesofttech.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "expense_group")
@NamedQueries({ @NamedQuery(name = "ExpenseGroup.findAll", query = "SELECT t FROM ExpenseGroup t") })
public class ExpenseGroup implements Serializable {

	public ExpenseGroup() {
	}

	public ExpenseGroup(Long expenseGroupId, String expTypeId, BigDecimal totalAmount, String statusId, String userId,
			Short paidMonth, Integer paidYear, String requestedBy, Timestamp requestedAt, String receivedBy,
			Timestamp receivedAt, String userCreate, String userUpdate, Timestamp timeCreate, Timestamp timeUpdate) {
		this.expenseGroupId = expenseGroupId;
		this.expTypeId = expTypeId;
		this.totalAmount = totalAmount;
		this.statusId = statusId;
		this.userId = userId;
		this.paidMonth = paidMonth;
		this.paidYear = paidYear;
		this.requestedBy = requestedBy;
		this.requestedAt = requestedAt;
		this.receivedBy = receivedBy;
		this.receivedAt = receivedAt;
		this.userCreate = userCreate;
		this.userUpdate = userUpdate;
		this.timeCreate = timeCreate;
		this.timeUpdate = timeUpdate;
	}

	@Id
	@Column(name = "expense_group_id")
	private Long expenseGroupId;

	@Column(name = "exp_type_id")
	private String expTypeId;

	@Column(name = "total_amount")
	private BigDecimal totalAmount;

	@Column(name = "status_id")
	private String statusId;

	@Column(name = "user_id")
	private String userId;

	@Column(name = "paid_month")
	private Short paidMonth;

	@Column(name = "paid_year")
	private Integer paidYear;

	// ✅ field ใหม่ตาม DB
	@Column(name = "requested_by")
	private String requestedBy;

	@Column(name = "requested_at")
	private Timestamp requestedAt;

	@Column(name = "received_by")
	private String receivedBy;

	@Column(name = "received_at")
	private Timestamp receivedAt;

	@Column(name = "user_create")
	private String userCreate;

	@Column(name = "user_update")
	private String userUpdate;

	@Column(name = "time_create")
	private Timestamp timeCreate;

	@Column(name = "time_update")
	private Timestamp timeUpdate;

	// ===== Getter / Setter =====

	public Long getExpenseGroupId() {
		return expenseGroupId;
	}

	public void setExpenseGroupId(Long expenseGroupId) {
		this.expenseGroupId = expenseGroupId;
	}

	public String getExpTypeId() {
		return expTypeId;
	}

	public void setExpTypeId(String expTypeId) {
		this.expTypeId = expTypeId;
	}

	public BigDecimal getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(BigDecimal totalAmount) {
		this.totalAmount = totalAmount;
	}

	public String getStatusId() {
		return statusId;
	}

	public void setStatusId(String statusId) {
		this.statusId = statusId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public Short getPaidMonth() {
		return paidMonth;
	}

	public void setPaidMonth(Short paidMonth) {
		this.paidMonth = paidMonth;
	}

	public Integer getPaidYear() {
		return paidYear;
	}

	public void setPaidYear(Integer paidYear) {
		this.paidYear = paidYear;
	}

	// ✅ getter/setter ใหม่
	public String getRequestedBy() {
		return requestedBy;
	}

	public void setRequestedBy(String requestedBy) {
		this.requestedBy = requestedBy;
	}

	public Timestamp getRequestedAt() {
		return requestedAt;
	}

	public void setRequestedAt(Timestamp requestedAt) {
		this.requestedAt = requestedAt;
	}

	public String getReceivedBy() {
		return receivedBy;
	}

	public void setReceivedBy(String receivedBy) {
		this.receivedBy = receivedBy;
	}

	public Timestamp getReceivedAt() {
		return receivedAt;
	}

	public void setReceivedAt(Timestamp receivedAt) {
		this.receivedAt = receivedAt;
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

	// ===== toString =====

	@Override
	public String toString() {
		return super.toString() + "expenseGroupId=[" + expenseGroupId + "]\n" + "expTypeId=[" + expTypeId + "]\n"
				+ "totalAmount=[" + totalAmount + "]\n" + "statusId=[" + statusId + "]\n" + "userId=[" + userId + "]\n"
				+ "paidMonth=[" + paidMonth + "]\n" + "paidYear=[" + paidYear + "]\n" + "requestedBy=[" + requestedBy
				+ "]\n" + "requestedAt=[" + requestedAt + "]\n" + "receivedBy=[" + receivedBy + "]\n" + "receivedAt=["
				+ receivedAt + "]\n" + "userCreate=[" + userCreate + "]\n" + "userUpdate=[" + userUpdate + "]\n"
				+ "timeCreate=[" + timeCreate + "]\n" + "timeUpdate=[" + timeUpdate + "]\n";
	}

	// ===== equals =====

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (!(obj instanceof ExpenseGroup))
			return false;
		ExpenseGroup that = (ExpenseGroup) obj;

		if (!(that.getExpenseGroupId() == null ? this.expenseGroupId == null
				: that.getExpenseGroupId().equals(this.expenseGroupId)))
			return false;
		if (!(that.getExpTypeId() == null ? this.expTypeId == null : that.getExpTypeId().equals(this.expTypeId)))
			return false;
		if (!(that.getTotalAmount() == null ? this.totalAmount == null
				: that.getTotalAmount().equals(this.totalAmount)))
			return false;
		if (!(that.getStatusId() == null ? this.statusId == null : that.getStatusId().equals(this.statusId)))
			return false;
		if (!(that.getUserId() == null ? this.userId == null : that.getUserId().equals(this.userId)))
			return false;
		if (!(that.getPaidMonth() == null ? this.paidMonth == null : that.getPaidMonth().equals(this.paidMonth)))
			return false;
		if (!(that.getPaidYear() == null ? this.paidYear == null : that.getPaidYear().equals(this.paidYear)))
			return false;
		if (!(that.getRequestedBy() == null ? this.requestedBy == null
				: that.getRequestedBy().equals(this.requestedBy)))
			return false;
		if (!(that.getRequestedAt() == null ? this.requestedAt == null
				: that.getRequestedAt().equals(this.requestedAt)))
			return false;
		if (!(that.getReceivedBy() == null ? this.receivedBy == null : that.getReceivedBy().equals(this.receivedBy)))
			return false;
		if (!(that.getReceivedAt() == null ? this.receivedAt == null : that.getReceivedAt().equals(this.receivedAt)))
			return false;
		if (!(that.getUserCreate() == null ? this.userCreate == null : that.getUserCreate().equals(this.userCreate)))
			return false;
		if (!(that.getUserUpdate() == null ? this.userUpdate == null : that.getUserUpdate().equals(this.userUpdate)))
			return false;
		if (!(that.getTimeCreate() == null ? this.timeCreate == null : that.getTimeCreate().equals(this.timeCreate)))
			return false;
		if (!(that.getTimeUpdate() == null ? this.timeUpdate == null : that.getTimeUpdate().equals(this.timeUpdate)))
			return false;
		return true;
	}
}