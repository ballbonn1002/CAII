package com.cubesofttech.model;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name = "usage_summary")
public class TokenUsageSummary {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "usage_summary_id")
    private Integer usageSummaryId;
    
    @Column(name = "user_id")
    private String userId;
    
    @Column(name = "action_type_id")
    private Integer actionTypeId;
    
	@Column(name = "year")
    private String year;
    
    @Column(name = "month")
    private String month;
    
    @Column(name = "token")
    private Double monthlyToken;
    
    @Column(name = "reconcile")
    private Double totalToken;
    
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


    public TokenUsageSummary() {
    }

    public Integer getUsageSummaryId() {
        return usageSummaryId;
    }

    public void setUsageSummaryId(Integer usageSummaryId) {
        this.usageSummaryId = usageSummaryId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }
    
    public Integer getActionTypeId() {
		return actionTypeId;
	}

	public void setActionTypeId(Integer actionTypeId) {
		this.actionTypeId = actionTypeId;
	}

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public String getMonth() {
        return month;
    }

    public void setMonth(String month) {
        this.month = month;
    }

    public Double getMonthlyToken() {
        return monthlyToken;
    }

    public void setMonthlyToken(Double monthlyToken) {
        this.monthlyToken = monthlyToken;
    }

    public Double getTotalToken() {
        return totalToken;
    }

    public void setTotalToken(Double totalToken) {
        this.totalToken = totalToken;
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
    
}