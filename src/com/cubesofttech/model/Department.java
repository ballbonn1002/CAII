package com.cubesofttech.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "department")
@NamedQueries({
    @NamedQuery(name = "Department.findAll", query = "SELECT t FROM Department t")})
public class Department implements Serializable {
    




	/** Creates a new instance of Department */
    public Department() {
    }
    public Department(
            String id	
            , String name	
            , String description	
            , String prefixId
            , String usercreate	
            , String userupdate
            , java.sql.Timestamp timeCreate	
            , java.sql.Timestamp timeUpdate	
        ) {
        this.id = id;	
        this.name = name;	
        this.description = description;	
        this.prefixId = prefixId;
        this.usercreate = usercreate;
        this.userupdate = userupdate;
        this.timeCreate = timeCreate;	
        this.timeUpdate = timeUpdate;	
    }
    
    public String getUsercreate() {
		return usercreate;
	}
	public void setUsercreate(String usercreate) {
		this.usercreate = usercreate;
	}
	public String getUserupdate() {
		return userupdate;
	}
	public void setUserupdate(String userupdate) {
		this.userupdate = userupdate;
	}

	@Id
    @Column(name = "id")
    private String id;	
    @Column(name = "name")
    private String name;	
    @Column(name = "description")
    private String description;	
    @Column(name = "prefix_id")
    private String prefixId;
    @Column(name = "user_create")
    private String usercreate;
    @Column(name = "user_update")
    private String userupdate;	
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
    public String getPrefixId() {
        return this.prefixId;
    }		
    public void setPrefixId(String prefixId) {
        this.prefixId = prefixId;
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
        return super.toString() + "id=[" + id + "]\n" + "name=[" + name + "]\n" + "description=[" + description + "]\n" + "prefixId=[" + prefixId + "]\n" + "timeCreate=[" + timeCreate + "]\n" + "timeUpdate=[" + timeUpdate + "]\n";
    }

    public boolean equals(Object obj) {
        if (this == obj) {
                return true;
        }
        if (!(obj instanceof Department)) {
                return false;
        }
        Department that = (Department) obj;
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
        if (!(that.getPrefixId() == null ? this.getPrefixId() == null
                        : that.getPrefixId().equals(this.getPrefixId()))) {
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
