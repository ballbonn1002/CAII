
package com.cubesofttech.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "work_hours")
@NamedQueries({
    @NamedQuery(name = "WorkHours.findAll", query = "SELECT t FROM WorkHours t")})
public class WorkHours implements Serializable {
    
    /** Creates a new instance of WorkHours */
    public WorkHours() {
    }
    public WorkHours(
            Integer workHoursId	
            , String workHoursType	
            , java.sql.Timestamp workHoursTimeWork	
            , String latitude	
            , String longitude	
            , String description	
            , String userAgent	
            , String ipAddress	
            , String userCreate	
            , String userUpdate	
            , java.sql.Timestamp timeCreate	
            , java.sql.Timestamp timeUpdate	
            , Integer workinghours	
        ) {
        this.workHoursId = workHoursId;	
        this.workHoursType = workHoursType;	
        this.workHoursTimeWork = workHoursTimeWork;	
        this.latitude = latitude;	
        this.longitude = longitude;	
        this.description = description;	
        this.userAgent = userAgent;	
        this.ipAddress = ipAddress;	
        this.userCreate = userCreate;	
        this.userUpdate = userUpdate;	
        this.timeCreate = timeCreate;	
        this.timeUpdate = timeUpdate;	
        this.workinghours = workinghours;	
    }
    
    @Id
    @Column(name = "work_hours_id")
    private Integer workHoursId;	
    @Column(name = "work_hours_type")
    private String workHoursType;	
    @Column(name = "work_hours_time_work")
    private java.sql.Timestamp workHoursTimeWork;	
    @Column(name = "latitude")
    private String latitude;	
    @Column(name = "longitude")
    private String longitude;	
    @Column(name = "description")
    private String description;	
    @Column(name = "user_agent")
    private String userAgent;	
    @Column(name = "ip_address")
    private String ipAddress;	
    @Column(name = "user_create")
    private String userCreate;	
    @Column(name = "user_update")
    private String userUpdate;	
    @Column(name = "time_create")
    private java.sql.Timestamp timeCreate;	
    @Column(name = "time_update")
    private java.sql.Timestamp timeUpdate;
    @Column(name = "workinghours")
    public Integer workinghours;



    public Integer getWorkHoursId() {
        return this.workHoursId;
    }		
    public void setWorkHoursId(Integer workHoursId) {
        this.workHoursId = workHoursId;
    }
    public String getWorkHoursType() {
        return this.workHoursType;
    }		
    public void setWorkHoursType(String workHoursType) {
        this.workHoursType = workHoursType;
    }
    public java.sql.Timestamp getWorkHoursTimeWork() {
        return this.workHoursTimeWork;
    }		
    public void setWorkHoursTimeWork(java.sql.Timestamp workHoursTimeWork) {
        this.workHoursTimeWork = workHoursTimeWork;
    }
    public String getLatitude() {
        return this.latitude;
    }		
    public void setLatitude(String latitude) {
        this.latitude = latitude;
    }
    public String getLongitude() {
        return this.longitude;
    }		
    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }
    public String getDescription() {
        return this.description;
    }		
    public void setDescription(String description) {
        this.description = description;
    }
    public String getUserAgent() {
        return this.userAgent;
    }		
    public void setUserAgent(String userAgent) {
        this.userAgent = userAgent;
    }
    public String getIpAddress() {
        return this.ipAddress;
    }		
    public void setIpAddress(String ipAddress) {
        this.ipAddress = ipAddress;
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
    public void setWorkinghours(Integer workinghours) {
        this.workinghours = workinghours;
    }


    
    public String toString() {
        return super.toString() + "workHoursId=[" + workHoursId + "]\n" + "workHoursType=[" + workHoursType + "]\n" + "workHoursTimeWork=[" + workHoursTimeWork + "]\n" + "latitude=[" + latitude + "]\n" + "longitude=[" + longitude + "]\n" + "description=[" + description + "]\n" + "userAgent=[" + userAgent + "]\n" + "ipAddress=[" + ipAddress + "]\n" + "userCreate=[" + userCreate + "]\n" + "userUpdate=[" + userUpdate + "]\n" + "timeCreate=[" + timeCreate + "]\n" + "timeUpdate=[" + timeUpdate + "]\n";
    }

    public boolean equals(Object obj) {
        if (this == obj) {
                return true;
        }
        if (!(obj instanceof WorkHours)) {
                return false;
        }
        WorkHours that = (WorkHours) obj;
        if (!(that.getWorkHoursId() == null ? this.getWorkHoursId() == null
                        : that.getWorkHoursId().equals(this.getWorkHoursId()))) {
                return false;
        }
        if (!(that.getWorkHoursType() == null ? this.getWorkHoursType() == null
                        : that.getWorkHoursType().equals(this.getWorkHoursType()))) {
                return false;
        }
        if (!(that.getWorkHoursTimeWork() == null ? this.getWorkHoursTimeWork() == null
                        : that.getWorkHoursTimeWork().equals(this.getWorkHoursTimeWork()))) {
                return false;
        }
        if (!(that.getLatitude() == null ? this.getLatitude() == null
                        : that.getLatitude().equals(this.getLatitude()))) {
                return false;
        }
        if (!(that.getLongitude() == null ? this.getLongitude() == null
                        : that.getLongitude().equals(this.getLongitude()))) {
                return false;
        }
        if (!(that.getDescription() == null ? this.getDescription() == null
                        : that.getDescription().equals(this.getDescription()))) {
                return false;
        }
        if (!(that.getUserAgent() == null ? this.getUserAgent() == null
                        : that.getUserAgent().equals(this.getUserAgent()))) {
                return false;
        }
        if (!(that.getIpAddress() == null ? this.getIpAddress() == null
                        : that.getIpAddress().equals(this.getIpAddress()))) {
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
        if (!(that.getWorkinghours() == null ? this.getWorkinghours() == null
                : that.getWorkinghours().equals(this.getWorkinghours()))) {
        return false;
}
    return true;
    }
	public Object getWorkinghours() {
		// TODO Auto-generated method stub
		return this.workinghours;
	}

}
