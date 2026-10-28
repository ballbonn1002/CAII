package com.cubesofttech.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "token_monthly_log_detail")
public class TokenMonthlyLogDetail {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "token_log_id")
    private Integer tokenLogId;

    @Column(name = "monitor_log_id", nullable = false)
    private Integer monitorLogId;

    @Column(name = "user_id", nullable = false, length = 32)
    private String userId;

    @Column(name = "date_time")
    private Date dateTime;

    @Column(name = "value")
    private Double value;

    @Column(name = "status", length = 32)
    private String status;

    @Column(name = "description", length = 1024)
    private String description;

    @Column(name = "user_create", length = 32)
    private String userCreate;

    @Column(name = "user_update", length = 32)
    private String userUpdate;

    @Column(name = "time_create")
    private Date timeCreate;

    @Column(name = "time_update")
    private Date timeUpdate;

    public Integer getTokenLogId() {
        return tokenLogId;
    }

    public void setTokenLogId(Integer tokenLogId) {
        this.tokenLogId = tokenLogId;
    }

    public Integer getMonitorLogId() {
        return monitorLogId;
    }

    public void setMonitorLogId(Integer monitorLogId) {
        this.monitorLogId = monitorLogId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public Date getDateTime() {
        return dateTime;
    }

    public void setDateTime(Date dateTime) {
        this.dateTime = dateTime;
    }

    public Double getValue() {
        return value;
    }

    public void setValue(Double value) {
        this.value = value;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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

    public Date getTimeCreate() {
        return timeCreate;
    }

    public void setTimeCreate(Date timeCreate) {
        this.timeCreate = timeCreate;
    }

    public Date getTimeUpdate() {
        return timeUpdate;
    }

    public void setTimeUpdate(Date timeUpdate) {
        this.timeUpdate = timeUpdate;
    }
}