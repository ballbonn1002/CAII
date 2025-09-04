package com.cubesofttech.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "user_role")
@IdClass(UserRolePK.class)
@NamedQueries({
    @NamedQuery(name = "UserRole.findAll", query = "SELECT t FROM UserRole t")})
public class UserRole implements Serializable {
    
    /** Creates a new instance of UserRole */
    public UserRole() {
    }
    public UserRole(
            String userId	
            , String roleId	
        ) {
        this.userId = userId;	
        this.roleId = roleId;	
    }
    
    @Id
    @Column(name = "user_id")
    private String userId;	
    @Id
    @Column(name = "role_id")
    private String roleId;	



    public String getUserId() {
        return this.userId;
    }		
    public void setUserId(String userId) {
        this.userId = userId;
    }
    public String getRoleId() {
        return this.roleId;
    }		
    public void setRoleId(String roleId) {
        this.roleId = roleId;
    }


    
    public String toString() {
        return super.toString() + "userId=[" + userId + "]\n" + "roleId=[" + roleId + "]\n";
    }

    public boolean equals(Object obj) {
        if (this == obj) {
                return true;
        }
        if (!(obj instanceof UserRole)) {
                return false;
        }
        UserRole that = (UserRole) obj;
        if (!(that.getUserId() == null ? this.getUserId() == null
                        : that.getUserId().equals(this.getUserId()))) {
                return false;
        }
        if (!(that.getRoleId() == null ? this.getRoleId() == null
                        : that.getRoleId().equals(this.getRoleId()))) {
                return false;
        }
    return true;
    }

}
