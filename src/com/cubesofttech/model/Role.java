
package com.cubesofttech.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "role")
@NamedQueries({
    @NamedQuery(name = "Role.findAll", query = "SELECT t FROM Role t")})
public class Role implements Serializable {
    
    /** Creates a new instance of Role */
    public Role() {
    }
    public Role(
            String id	
            , String name	
            , String description	
            , java.sql.Timestamp timeCreate	
            , java.sql.Timestamp timeUpdate	
        ) {
        this.id = id;	
        this.name = name;	
        this.description = description;	
        this.timeCreate = timeCreate;	
        this.timeUpdate = timeUpdate;	
    }
    
    @Id
    @Column(name = "id")
    private String id;	
    @Column(name = "name")
    private String name;	
    @Column(name = "description")
    private String description;	
    @Column(name = "time_create")
    private java.sql.Timestamp timeCreate;	
    @Column(name = "time_update")
    private java.sql.Timestamp timeUpdate;	



    public String getId() {
        return this.id;
    }		
    public void setId(String id) {
        this.id = id;
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
        return super.toString() + "id=[" + id + "]\n" + "name=[" + name + "]\n" + "description=[" + description + "]\n" + "timeCreate=[" + timeCreate + "]\n" + "timeUpdate=[" + timeUpdate + "]\n";
    }

    public boolean equals(Object obj) {
        if (this == obj) {
                return true;
        }
        if (!(obj instanceof Role)) {
                return false;
        }
        Role that = (Role) obj;
        if (!(that.getId() == null ? this.getId() == null
                        : that.getId().equals(this.getId()))) {
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
