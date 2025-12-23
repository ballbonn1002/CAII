
package com.cubesofttech.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "authorized_object_group")
@NamedQueries({
    @NamedQuery(name = "AuthorizedObjectGroup.findAll", query = "SELECT t FROM AuthorizedObjectGroup t")})
public class AuthorizedObjectGroup implements Serializable {
    
    public AuthorizedObjectGroup() {
    }
    public AuthorizedObjectGroup(
            Integer authorizedObjectGroupId	
            , String name	
            , String description	
            , String userCreate	
            , String userUpdate	
            , java.sql.Timestamp timeCreate	
            , java.sql.Timestamp timeUpdate	
        ) {
        this.authorizedObjectGroupId = authorizedObjectGroupId;	
        this.name = name;	
        this.description = description;	
        this.userCreate = userCreate;	
        this.userUpdate = userUpdate;	
        this.timeCreate = timeCreate;	
        this.timeUpdate = timeUpdate;	
    }
    
    @Id
    @Column(name = "authorized_object_group_id")
    private Integer authorizedObjectGroupId;	
    @Column(name = "name")
    private String name;	
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
    
    @Transient
    private List<AuthorizedObject> objects = new ArrayList<>();

    public List<AuthorizedObject> getObjects() {
        return objects;
    }

    public void setObjects(List<AuthorizedObject> objects) {
        this.objects = objects;
    }

    public void addObject(AuthorizedObject obj) {
        if (this.objects == null) {
            this.objects = new ArrayList<>();
        }
        this.objects.add(obj);
    }

    public Integer getAuthorizedObjectGroupId() {
        return this.authorizedObjectGroupId;
    }		
    public void setAuthorizedObjectGroupId(Integer authorizedObjectGroupId) {
        this.authorizedObjectGroupId = authorizedObjectGroupId;
    }
    public String getName() {
        return this.name;
    }		
    public void setName(String name) {
        this.name = name;
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
        return super.toString() + "authorizedObjectGroupId=[" + authorizedObjectGroupId + "]\n" + "name=[" + name + "]\n" + "description=[" + description + "]\n" + "userCreate=[" + userCreate + "]\n" + "userUpdate=[" + userUpdate + "]\n" + "timeCreate=[" + timeCreate + "]\n" + "timeUpdate=[" + timeUpdate + "]\n";
    }

    public boolean equals(Object obj) {
        if (this == obj) {
                return true;
        }
        if (!(obj instanceof AuthorizedObjectGroup)) {
                return false;
        }
        AuthorizedObjectGroup that = (AuthorizedObjectGroup) obj;
        if (!(that.getAuthorizedObjectGroupId() == null ? this.getAuthorizedObjectGroupId() == null
                        : that.getAuthorizedObjectGroupId().equals(this.getAuthorizedObjectGroupId()))) {
                return false;
        }
        if (!(that.getName() == null ? this.getName() == null
                        : that.getName().equals(this.getName()))) {
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
