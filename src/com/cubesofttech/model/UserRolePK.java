
package com.cubesofttech.model;

import java.io.Serializable;

import javax.persistence.Column;
/*
 *  User for Multiple Primary Key Table Only
 */
public class UserRolePK  implements Serializable {
    
    /** Creates a new instance of UserRole */
    public UserRolePK(
            String userId	
            , String roleId	
        ) {
        this.userId = userId;	
        this.roleId = roleId;	
    }
    
    public UserRolePK(){
    	
    }
    @Column(name = "user_id")
    private String userId;	
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
        return super.toString() + " " + userId + " " + roleId;
    }
    
	public int hashCode()
	{
		return (int) Math.random();
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
