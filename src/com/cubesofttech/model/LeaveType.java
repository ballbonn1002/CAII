package com.cubesofttech.model;
import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
@Entity
@Table(name = "leave_type")
@NamedQueries({
@NamedQuery(name = "LeaveType.findAll", query = "SELECT t FROM LeaveType t")})
public class LeaveType implements Serializable {
    
    /** Creates a new instance of LeaveType */
    public LeaveType() {
    }
    public LeaveType(
            String leaveTypeId	
            , String leaveTypeName	
            , String description	
            , String userCreate	
            , String userUpdate	
            , java.sql.Timestamp timeCreate	
            , java.sql.Timestamp timeUpdate	
        ) {
        this.leaveTypeId = leaveTypeId;	
        this.leaveTypeName = leaveTypeName;	
        this.description = description;	
        this.userCreate = userCreate;	
        this.userUpdate = userUpdate;	
        this.timeCreate = timeCreate;	
        this.timeUpdate = timeUpdate;	
    }
    
    @Id
    @Column(name = "leave_type_id")
    private String leaveTypeId;	
    @Column(name = "leave_type_name")
    private String leaveTypeName;	
    @Column(name = "description")
    private String description;	
    @Column(name = "user_create")
    private String userCreate;	
    @Column(name = "user_update")
    private String userUpdate;	
    @Column(name = "time_create")
    private java.sql.Timestamp timeCreate;	
    @Column(name = "time_update")
    private java.sql.Timestamp timeUpdate;	



    public String getLeaveTypeId() {
        return this.leaveTypeId;
    }		
    public void setLeaveTypeId(String leaveTypeId) {
        this.leaveTypeId = leaveTypeId;
    }
    public String getLeaveTypeName() {
        return this.leaveTypeName;
    }		
    public void setLeaveTypeName(String leaveTypeName) {
        this.leaveTypeName = leaveTypeName;
    }
    public String getDescription() {
        return this.description;
    }		
    public void setDescription(String description) {
        this.description = description;
    }
    public String getUserCreate() {
        return this.userCreate;
    }		
    public void setUserCreate(String userCreate) {
        this.userCreate = userCreate;
    }
    public String getUserUpdate() {
        return this.userUpdate;
    }		
    public void setUserUpdate(String userUpdate) {
        this.userUpdate = userUpdate;
    }
    public java.sql.Timestamp getTimeCreate() {
        return this.timeCreate;
    }		
    public void setTimeCreate(java.sql.Timestamp timeCreate) {
        this.timeCreate = timeCreate;
    }
    public java.sql.Timestamp getTimeUpdate() {
        return this.timeUpdate;
    }		
    public void setTimeUpdate(java.sql.Timestamp timeUpdate) {
        this.timeUpdate = timeUpdate;
    }


    
    public String toString() {
        return super.toString() + "leaveTypeId=[" + leaveTypeId + "]\n" + "leaveTypeName=[" + leaveTypeName + "]\n" + "description=[" + description + "]\n" + "userCreate=[" + userCreate + "]\n" + "userUpdate=[" + userUpdate + "]\n" + "timeCreate=[" + timeCreate + "]\n" + "timeUpdate=[" + timeUpdate + "]\n";
    }

    public boolean equals(Object obj) {
        if (this == obj) {
                return true;
        }
        if (!(obj instanceof LeaveType)) {
                return false;
        }
        LeaveType that = (LeaveType) obj;
        if (!(that.getLeaveTypeId() == null ? this.getLeaveTypeId() == null
                        : that.getLeaveTypeId().equals(this.getLeaveTypeId()))) {
                return false;
        }
        if (!(that.getLeaveTypeName() == null ? this.getLeaveTypeName() == null
                        : that.getLeaveTypeName().equals(this.getLeaveTypeName()))) {
                return false;
        }
        if (!(that.getDescription() == null ? this.getDescription() == null
                        : that.getDescription().equals(this.getDescription()))) {
                return false;
        }
        if (!(that.getUserCreate() == null ? this.getUserCreate() == null
                        : that.getUserCreate().equals(this.getUserCreate()))) {
                return false;
        }
        if (!(that.getUserUpdate() == null ? this.getUserUpdate() == null
                        : that.getUserUpdate().equals(this.getUserUpdate()))) {
                return false;
        }
        if (!(that.getTimeCreate() == null ? this.getTimeCreate() == null
                        : that.getTimeCreate().equals(this.getTimeCreate()))) {
                return false;
        }
        if (!(that.getTimeUpdate() == null ? this.getTimeUpdate() == null
                        : that.getTimeUpdate().equals(this.getTimeUpdate()))) {
                return false;
        }
    return true;
    }

}
