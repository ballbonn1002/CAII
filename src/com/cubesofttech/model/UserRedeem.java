package com.cubesofttech.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "user_redeem")
public class UserRedeem {

	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_redeem_id")
    private Integer userRedeemId;

    @Column(name = "user_id", nullable = false, length = 32)
    private String userId;

    @Column(name = "item_id", nullable = false)
    private Integer itemId;

    @Column(name = "token", nullable = false)
    private Double token = 0.0;
    
    @Column(name = "cash")
    private Double cash;

    @Column(name = "redeem_status", length = 20)
    private String redeemStatus;
    
    @Column(name = "user_approve", length = 32)
    private String userApprove;
    
    @Column(name = "time_approve")
    private Date timeApprove;
    
    @Column(name = "user_deliver", length = 32)
    private String userDeliver;
    
    @Column(name = "time_deliver")
    private Date timeDeliver;
    
    @Column(name = "user_receive", length = 32)
    private String userReceive;
    
	@Column(name = "time_receive")
    private Date timeReceive;
    
    @Column(name = "status_log")
    private String statusLog;

	@Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @Column(name = "user_create", length = 32)
    private String userCreate;

    @Column(name = "user_update", length = 32)
    private String userUpdate;

    @Column(name = "time_create")
    private Date timeCreate;

    @Column(name = "time_update")
    private Date timeUpdate;

    // =========================
    // Getter / Setter
    // =========================

    public Integer getUserRedeemId() {
        return userRedeemId;
    }

    public void setUserRedeemId(Integer userRedeemId) {
        this.userRedeemId = userRedeemId;
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

    public void setCash(Double cash) {
		this.cash = cash;
	}
    
    public Double getCash() {
    	return this.cash;
    }
    
    public Double getToken() {
        return token;
    }

    public void setToken(Double token) {
        this.token = token;
    }

    public void setToken(double token) {
        this.token = token;
    }

    public String getRedeemStatus() {
        return redeemStatus;
    }

    public void setRedeemStatus(String redeemStatus) {
        this.redeemStatus = redeemStatus;
    }
    
    public String getStatusLog() {
		return statusLog;
	}
    
    public void setStatusLog(String statusLog) {
    	this.statusLog = statusLog;
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
    
    public String getUserApprove() {
		return userApprove;
	}

	public void setUserApprove(String userApprove) {
		this.userApprove = userApprove;
	}

	public Date getTimeApprove() {
		return timeApprove;
	}

	public void setTimeApprove(Date timeApprove) {
		this.timeApprove = timeApprove;
	}

	public String getUserDeliver() {
		return userDeliver;
	}

	public void setUserDeliver(String userDeliver) {
		this.userDeliver = userDeliver;
	}

	public Date getTimeDeliver() {
		return timeDeliver;
	}

	public void setTimeDeliver(Date timeDeliver) {
		this.timeDeliver = timeDeliver;
	}

	public Date getTimeReceive() {
		return timeReceive;
	}

	public void setTimeReceive(Date timeReceive) {
		this.timeReceive = timeReceive;
	}
	
	public String getUserReceive() {
		return userReceive;
	}

	public void setUserReceive(String userId) {
		this.userReceive = userId;
	}
}