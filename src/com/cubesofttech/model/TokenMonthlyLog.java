package com.cubesofttech.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "token_monthly_log")
public class TokenMonthlyLog {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "monitor_log_id")
    private Integer monitorLogId;

    @Column(name = "date_time", nullable = false)
    private Date dateTime;

    @Column(name = "success_case", nullable = false)
    private Integer successCase = 0;

    @Column(name = "fail_case", nullable = false)
    private Integer failCase = 0;

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

    public Integer getMonitorLogId() {
        return monitorLogId;
    }

    public void setMonitorLogId(Integer monitorLogId) {
        this.monitorLogId = monitorLogId;
    }

    public Date getDateTime() {
        return dateTime;
    }

    public void setDateTime(Date dateTime) {
        this.dateTime = dateTime;
    }

    public Integer getSuccessCase() {
        return successCase;
    }

    public void setSuccessCase(Integer successCase) {
        this.successCase = successCase;
    }

    public Integer getFailCase() {
        return failCase;
    }

    public void setFailCase(Integer failCase) {
        this.failCase = failCase;
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