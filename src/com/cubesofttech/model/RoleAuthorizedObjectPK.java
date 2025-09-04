
package com.cubesofttech.model;

import java.io.Serializable;

import javax.persistence.Column;
/*
 *  User for Multiple Primary Key Table Only
 */
public class RoleAuthorizedObjectPK  implements Serializable {
    
    /** Creates a new instance of RoleAuthorizedObject */
    public RoleAuthorizedObjectPK(
            String roleId	
            , String authorizedObjectId	
        ) {
        this.roleId = roleId;	
        this.authorizedObjectId = authorizedObjectId;	
    }
    
    public RoleAuthorizedObjectPK(){
    	
    }
    
	public int hashCode()
	{
		return authorizedObjectId.length() + roleId.length();
	}
    @Column(name = "role_id")
    private String roleId;	
    @Column(name = "authorized_object_id")
    private String authorizedObjectId;	

    public String getRoleId() {
        return this.roleId;
    }		
    public void setRoleId(String roleId) {
        this.roleId = roleId;
    }
    public String getAuthorizedObjectId() {
        return this.authorizedObjectId;
    }		
    public void setAuthorizedObjectId(String authorizedObjectId) {
        this.authorizedObjectId = authorizedObjectId;
    }

    public String toString() {
        return super.toString() + " " + roleId + " " + authorizedObjectId;
    }

    public boolean equals(Object obj) {
        if (this == obj) {
                return true;
        }
        if (!(obj instanceof RoleAuthorizedObject)) {
                return false;
        }
        RoleAuthorizedObject that = (RoleAuthorizedObject) obj;
        if (!(that.getRoleId() == null ? this.getRoleId() == null
                        : that.getRoleId().equals(this.getRoleId()))) {
                return false;
        }
        if (!(that.getAuthorizedObjectId() == null ? this.getAuthorizedObjectId() == null
                        : that.getAuthorizedObjectId().equals(this.getAuthorizedObjectId()))) {
                return false;
        }
    return true;
    }

}
