
package com.cubesofttech.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "leave_user")
@NamedQueries({
    @NamedQuery(name = "LeaveUser.findAll", query = "SELECT t FROM LeaveUser t")})
public class LeaveUser implements Serializable {
    
    /** Creates a new instance of LeaveUser */
    public LeaveUser() {
    }
    public LeaveUser(
            Integer leaveId	
            , String userId	
        ) {
        this.leaveId = leaveId;	
        this.userId = userId;	
    }
    
    @Id
    @Column(name = "leave_id")
    private Integer leaveId;	
    @Id
    @Column(name = "user_id")
    private String userId;	



    public Integer getLeaveId() {
        return this.leaveId;
    }		
    public void setLeaveId(Integer leaveId) {
        this.leaveId = leaveId;
    }
    public String getUserId() {
        return this.userId;
    }		
    public void setUserId(String userId) {
        this.userId = userId;
    }


    
    public String toString() {
        return super.toString() + "leaveId=[" + leaveId + "]\n" + "userId=[" + userId + "]\n";
    }

    public boolean equals(Object obj) {
        if (this == obj) {
                return true;
        }
        if (!(obj instanceof LeaveUser)) {
                return false;
        }
        LeaveUser that = (LeaveUser) obj;
        if (!(that.getLeaveId() == null ? this.getLeaveId() == null
                        : that.getLeaveId().equals(this.getLeaveId()))) {
                return false;
        }
        if (!(that.getUserId() == null ? this.getUserId() == null
                        : that.getUserId().equals(this.getUserId()))) {
                return false;
        }
    return true;
    }

}
