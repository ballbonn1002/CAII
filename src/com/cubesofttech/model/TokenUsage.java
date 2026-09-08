package com.cubesofttech.model;

import java.sql.Timestamp;

import javax.persistence.*;

@Entity
@Table(name = "token_usage")
public class TokenUsage {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "token_usage_id")
    private Integer tokenUsageId;

    @Column(name = "user_id")
    private String userId;

    @Column(name = "action_type_id")
    private Integer actionTypeId;
    
    @Column(name = "action_point_id")
    private Integer actionPointId;

	@Column(name = "value")
    private Double value;

    @Column(name = "reconcile")
    private Double reconcile;

	@Column(name = "re_flag")
    private String reFlag;
    
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

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public Integer getTokenUsageId() {
		return tokenUsageId;
	}

	public void setTokenUsageId(Integer tokenUsageId) {
		this.tokenUsageId = tokenUsageId;
	}

	public Integer getActionTypeId() {
		return actionTypeId;
	}

	public void setActionTypeId(Integer actionTypeId) {
		this.actionTypeId = actionTypeId;
	}

	public Double getValue() {
        return value;
    }

    public void setValue(Double value) {
        this.value = value;
    }

    public Double getReconcile() {
        return reconcile;
    }

    public void setReconcile(Double reconcile) {
        this.reconcile = reconcile;
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
    

    public Integer getActionPointId() {
		return actionPointId;
	}

	public void setActionPointId(Integer actionPointId) {
		this.actionPointId = actionPointId;
	}

    
    public String getReFlag() {
		return reFlag;
	}

	public void setReFlag(String reFlag) {
		this.reFlag = reFlag;
	}
}