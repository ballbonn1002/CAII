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
@Table(name = "expense_detail")
@NamedQueries({ @NamedQuery(name = "ExpenseDetail.findAll", query = "SELECT d FROM ExpenseDetail d") })
public class ExpenseDetail implements Serializable {

	public ExpenseDetail() {
	}

	public ExpenseDetail(Long expenseDetailId, Long expenseId, Long goBy, BigDecimal total, BigDecimal kilometers,
			String description, String userCreate, String userUpdate, Timestamp timeCreate, Timestamp timeUpdate) {
		this.expenseDetailId = expenseDetailId;
		this.expenseId = expenseId;
		this.goBy = goBy;
		this.total = total;
		this.kilometers = kilometers;
		this.description = description;
		this.userCreate = userCreate;
		this.userUpdate = userUpdate;
		this.timeCreate = timeCreate;
		this.timeUpdate = timeUpdate;
	}

	@Id
	@Column(name = "expense_detail_id")
	private Long expenseDetailId;

	@Column(name = "expense_id")
	private Long expenseId;

	@Column(name = "go_by")
	private Long goBy;

	@Column(name = "total")
	private BigDecimal total;

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

	@Column(name = "kilometers")
	private BigDecimal kilometers;

	public Long getExpenseDetailId() {
		return expenseDetailId;
	}

	public void setExpenseDetailId(Long expenseDetailId) {
		this.expenseDetailId = expenseDetailId;
	}

	public Long getExpenseId() {
		return expenseId;
	}

	public void setExpenseId(Long expenseId) {
		this.expenseId = expenseId;
	}

	public Long getGoBy() {
		return goBy;
	}

	public void setGoBy(Long goBy) {
		this.goBy = goBy;
	}

	public BigDecimal getTotal() {
		return total;
	}

	public void setTotal(BigDecimal total) {
		this.total = total;
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

	public BigDecimal getKilometers() {
		return kilometers;
	}

	public void setKilometers(BigDecimal kilometers) {
		this.kilometers = kilometers;
	}

	@Override
	public String toString() {
		return super.toString() + "expenseDetailId=[" + expenseDetailId + "]\n" + "expenseId=[" + expenseId + "]\n"
				+ "goBy=[" + goBy + "]\n" + "total=[" + total + "]\n" + "description=[" + description + "]\n"
				+ "userCreate=[" + userCreate + "]\n" + "userUpdate=[" + userUpdate + "]\n" + "timeCreate=["
				+ timeCreate + "]\n" + "timeUpdate=[" + timeUpdate + "]\n" + "kilometers=[" + kilometers + "]\n";
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (!(obj instanceof ExpenseDetail))
			return false;

		ExpenseDetail that = (ExpenseDetail) obj;

		if (!(that.getExpenseDetailId() == null ? this.getExpenseDetailId() == null
				: that.getExpenseDetailId().equals(this.getExpenseDetailId())))
			return false;

		if (!(that.getExpenseId() == null ? this.getExpenseId() == null
				: that.getExpenseId().equals(this.getExpenseId())))
			return false;

		if (!(that.getGoBy() == null ? this.getGoBy() == null : that.getGoBy().equals(this.getGoBy())))
			return false;

		if (!(that.getTotal() == null ? this.getTotal() == null : that.getTotal().equals(this.getTotal())))
			return false;

		if (!(that.getDescription() == null ? this.getDescription() == null
				: that.getDescription().equals(this.getDescription())))
			return false;
		if (!(that.getKilometers() == null ? this.getKilometers() == null
				: that.getKilometers().equals(this.getKilometers())))
			return false;

		return true;
	}
}
