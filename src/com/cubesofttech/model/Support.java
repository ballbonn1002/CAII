package com.cubesofttech.model;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "support")
public class Support implements Serializable {

    private static final long serialVersionUID = 1L;

    public Support() {
    }

    public Support(
            Integer supportId, 
            String userId, 
            java.sql.Date issueDate, 
            String categorized,
            String supportMenuId, 
            String status, 
            String description, 
            String userCreate, 
            String userUpdate,
            java.sql.Timestamp timeCreate, 
            java.sql.Timestamp timeUpdate) {
        this.supportId = supportId;
        this.userId = userId;
        this.issueDate = issueDate;
        this.categorized = categorized;
        this.supportMenuId = supportMenuId;
        this.status = status;
        this.description = description;
        this.userCreate = userCreate;
        this.userUpdate = userUpdate;
        this.timeCreate = timeCreate;
        this.timeUpdate = timeUpdate;
    }

    @Id
    @javax.persistence.GeneratedValue(strategy = javax.persistence.GenerationType.IDENTITY)
    @Column(name = "support_id")
    private Integer supportId;

    @Column(name = "user_id")
    private String userId;

    @Column(name = "issue_date")
    private java.sql.Date issueDate;

    @Column(name = "categorized")
    private String categorized;

    @Column(name = "support_menu_id")
    private String supportMenuId;

    @Column(name = "status")
    private String status;

    @Column(name = "description")
    private String description;

    @Column(name = "user_create")
    private String userCreate;

    @Column(name = "user_update")
    private String userUpdate;

    @Column(name = "time_create", insertable = true, updatable = false)
    private java.sql.Timestamp timeCreate;

    @Column(name = "time_update", insertable = true, updatable = true)
    private java.sql.Timestamp timeUpdate;

    public Integer getSupportId() {
        return supportId;
    }

    public void setSupportId(Integer supportId) {
        this.supportId = supportId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public java.sql.Date getIssueDate() {
        return issueDate;
    }

    public void setIssueDate(java.sql.Date issueDate) {
        this.issueDate = issueDate;
    }

    public String getCategorized() {
        return categorized;
    }

    public void setCategorized(String categorized) {
        this.categorized = categorized;
    }

    public String getSupportMenuId() {
        return supportMenuId;
    }

    public void setSupportMenuId(String supportMenuId) {
        this.supportMenuId = supportMenuId;
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

    public java.sql.Timestamp getTimeCreate() {
        return timeCreate;
    }

    public void setTimeCreate(java.sql.Timestamp timeCreate) {
        this.timeCreate = timeCreate;
    }

    public java.sql.Timestamp getTimeUpdate() {
        return timeUpdate;
    }

    public void setTimeUpdate(java.sql.Timestamp timeUpdate) {
        this.timeUpdate = timeUpdate;
    }
}
