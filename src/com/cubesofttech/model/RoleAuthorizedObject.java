
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
@Table(name = "role_authorized_object")
@IdClass(RoleAuthorizedObjectPK.class)
@NamedQueries({
    @NamedQuery(name = "RoleAuthorizedObject.findAll", query = "SELECT t FROM RoleAuthorizedObject t")})
public class RoleAuthorizedObject implements Serializable {
    
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;



	/** Creates a new instance of RoleAuthorizedObject */
    public RoleAuthorizedObject() {
    }
    public RoleAuthorizedObject(
            String roleId	
            , String authorizedObjectId	
            , java.sql.Timestamp timeCreate	
            , java.sql.Timestamp timeUpdate	
        ) {
        this.roleId = roleId;	
        this.authorizedObjectId = authorizedObjectId;	
        this.timeCreate = timeCreate;	
        this.timeUpdate = timeUpdate;	
    }
    
    @Id
    @Column(name = "role_id")
    private String roleId;	
    @Id
    @Column(name = "authorized_object_id")
    private String authorizedObjectId;	
    @Column(name = "time_create")
    private java.sql.Timestamp timeCreate;	
    @Column(name = "time_update")
    private java.sql.Timestamp timeUpdate;	



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
        return super.toString() + "roleId=[" + roleId + "]\n" + "authorizedObjectId=[" + authorizedObjectId + "]\n" + "timeCreate=[" + timeCreate + "]\n" + "timeUpdate=[" + timeUpdate + "]\n";
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
