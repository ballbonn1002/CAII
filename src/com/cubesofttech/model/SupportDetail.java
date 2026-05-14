package com.cubesofttech.model;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "support_detail")
public class SupportDetail implements Serializable {

    private static final long serialVersionUID = 1L;

    public SupportDetail() {
    }

    public SupportDetail(
            Integer supportDetailId, 
            String supportId, 
            String message, 
            String status, 
            String description, 
            String userCreate, 
            String userUpdate,
            java.sql.Timestamp timeCreate, 
            java.sql.Timestamp timeUpdate) {
        this.supportDetailId = supportDetailId;
        this.supportId = supportId;
        this.message = message;
        this.status = status;
        this.description = description;
        this.userCreate = userCreate;
        this.userUpdate = userUpdate;
        this.timeCreate = timeCreate;
        this.timeUpdate = timeUpdate;
    }

    @Id
    @javax.persistence.GeneratedValue(strategy = javax.persistence.GenerationType.IDENTITY)
    @Column(name = "support_detail_id")
    private Integer supportDetailId;

    @Column(name = "support_id")
    private String supportId;

    @Column(name = "message")
    private String message;

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

    public Integer getSupportDetailId() {
        return supportDetailId;
    }

    public void setSupportDetailId(Integer supportDetailId) {
        this.supportDetailId = supportDetailId;
    }

    public String getSupportId() {
        return supportId;
    }

    public void setSupportId(String supportId) {
        this.supportId = supportId;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
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
