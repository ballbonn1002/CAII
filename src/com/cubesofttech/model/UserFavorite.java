package com.cubesofttech.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "user_favorite")
public class UserFavorite implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_favorite_id")
    private Integer userFavoriteId;

    @Column(name = "user_id", nullable = false, length = 32)
    private String userId;

    @Column(name = "item_id", nullable = false)
    private Integer itemId;

    @Column(name = "description", length = 1024)
    private String description;

    @Column(name = "user_create", nullable = false, length = 32)
    private String userCreate;

    @Column(name = "user_update", nullable = false, length = 32)
    private String userUpdate;

    @Column(name = "time_create")
    private Date timeCreate;

    @Column(name = "time_update")
    private Date timeUpdate;

    public Integer getUserFavoriteId() {
        return userFavoriteId;
    }

    public void setUserFavoriteId(Integer userFavoriteId) {
        this.userFavoriteId = userFavoriteId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public Integer getItemId() {
        return itemId;
    }

    public void setItemId(Integer itemId) {
        this.itemId = itemId;
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