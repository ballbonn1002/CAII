package com.cubesofttech.model;
import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Collection;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "timesheet")
@NamedQueries({
    @NamedQuery(name = "Timesheet.findAll", query = "SELECT t FROM Timesheet t")})
public class Timesheet implements Serializable {
    

	/** Creates a new instance of Timesheet */
    public Timesheet() {
    }
    
    
    public Timesheet(Integer id, String description, Timestamp timeCheckIn, Timestamp timeCheckOut, String status, String reason,
    		String appr_user_id, String userCreate, String userUpdate, Timestamp timeCreate, Timestamp timeUpdate, Timestamp timeAppr,
    		Integer project_id, Integer function_id, String team, String OT_type,Timestamp OT_time_start, Timestamp OT_time_end, String OT_description) {
		super();
		this.id = id;
		this.description = description;
		this.timeCheckIn = timeCheckIn;
		this.timeCheckOut = timeCheckOut;
		this.status = status;
		this.reason = reason;
		this.appr_user_id = appr_user_id;
		this.userCreate = userCreate;
		this.userUpdate = userUpdate;
		this.timeCreate = timeCreate;
		this.timeUpdate = timeUpdate;
		this.timeAppr = timeAppr;
		this.project_id = project_id;
		this.function_id = function_id;
		this.team = team;
		this.OT_type = OT_type;
		this.OT_time_start = OT_time_start;
		this.OT_time_end = OT_time_end;
		this.OT_description = OT_description;
	}


	@Id
    //@GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Integer id;	
	@Column(name = "project")
    private String project;
	@Column(name = "summary")
    private String summary;
    @Column(name = "description")
    private String description;
    @Column(name = "started_date")
    private Date started_date;
    @Column(name = "timespent")
    private String timespent;
    @Column(name = "time_check_in")
    private java.sql.Timestamp timeCheckIn;	
    @Column(name = "time_check_out")
    private java.sql.Timestamp timeCheckOut;	
    @Column(name = "status")
    private String status;	
    @Column(name = "reason")
    private String reason;
    @Column(name = "appr_user_id")
    private String appr_user_id;
	@Column(name = "user_create")
    private String userCreate;	
    @Column(name = "user_update")
    private String userUpdate;	
    @Column(name = "time_create")
    private java.sql.Timestamp timeCreate;	
    @Column(name = "time_update")
    private java.sql.Timestamp timeUpdate;
    @Column(name = "time_appr")
    private java.sql.Timestamp timeAppr;
    @Column(name = "project_id")
    private Integer project_id;
    @Column(name = "function_id")
    private Integer function_id;
    @Column(name = "team")
    private String team;

    public String getOT_description() {
		return OT_description;
	}


	public void setOT_description(String oT_description) {
		OT_description = oT_description;
	}


	public String getProject() {
		return project;
	}
	
	
	public void setProject(String project) {
		this.project = project;
	}
	
	
	public String getSummary() {
		return summary;
	}
	
	
	public void setSummary(String summary) {
		this.summary = summary;
	}
	
	
	public Date getStarted_date() {
		return started_date;
	}
	
	
	public void setStarted_date(Date started_date) {
		this.started_date = started_date;
	}
	
	
	public String getTimespent() {
		return timespent;
	}
	

	public void setTimespent(String timespent) {
		this.timespent = timespent;
	}
	

	public String getOT_type() {
		return OT_type;
	}


	public void setOT_type(String oT_type) {
		OT_type = oT_type;
	}


	public java.sql.Timestamp getOT_time_end() {
		return OT_time_end;
	}


	public void setOT_time_end(java.sql.Timestamp oT_time_end) {
		OT_time_end = oT_time_end;
	}


	public java.sql.Timestamp getOT_time_start() {
		return OT_time_start;
	}


	public void setOT_time_start(java.sql.Timestamp oT_time_start) {
		OT_time_start = oT_time_start;
	}


	@Column(name = "OT_type")
    private String OT_type;	
	@Column(name = "OT_description")
    private String OT_description;	
    @Column(name = "OT_time_end")
    private java.sql.Timestamp OT_time_end;	
    @Column(name = "OT_time_start")
    private java.sql.Timestamp OT_time_start;



	public Integer getId() {
        return this.id;
    }		
    public void setId(Integer id) {
        this.id = id;
    }
    public String getDescription() {
        return this.description;
    }		
    public void setDescription(String description) {
        this.description = description;
    }
    public java.sql.Timestamp getTimeCheckIn() {
        return this.timeCheckIn;
    }		
    public void setTimeCheckIn(java.sql.Timestamp timeCheckIn) {
        this.timeCheckIn = timeCheckIn;
    }
    public java.sql.Timestamp getTimeCheckOut() {
        return this.timeCheckOut;
    }		
    public void setTimeCheckOut(java.sql.Timestamp timeCheckOut) {
        this.timeCheckOut = timeCheckOut;
    }
    public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
    public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getAppr_user_id() {
		return appr_user_id;
	}
	public void setAppr_user_id(String appr_user_id) {
		this.appr_user_id = appr_user_id;
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
    public java.sql.Timestamp getTimeAppr() {
		return timeAppr;
	}
	public void setTimeAppr(java.sql.Timestamp timeAppr) {
		this.timeAppr = timeAppr;
	}
	
	public Integer getProject_id() {
		return project_id;
	}


	public void setProject_id(Integer project_id) {
		this.project_id = project_id;
	}


	public Integer getFunction_id() {
		return function_id;
	}


	public void setFunction_id(Integer function_id) {
		this.function_id = function_id;
	}

	public String getTeam() {
		return team;
	}


	public void setTeam(String team) {
		this.team = team;
	}
	
	@Override
	public String toString() {
		return "Timesheet [id=" + id + ", description=" + description + ", timeCheckIn=" + timeCheckIn
				+ ", timeCheckOut=" + timeCheckOut + ", status=" + status + ", userCreate=" + userCreate
				+ ", userUpdate=" + userUpdate + ", timeCreate=" + timeCreate + ", timeUpdate=" + timeUpdate
				+ ", project_id=" + project_id + ", function_id=" + function_id + "]";
	}
	public boolean equals(Object obj) {
        if (this == obj) {
                return true;
        }
        if (!(obj instanceof Timesheet)) {
                return false;
        }
        Timesheet that = (Timesheet) obj;
        if (!(that.getId() == null ? this.getId() == null
                        : that.getId().equals(this.getId()))) {
                return false;
        }
        if (!(that.getDescription() == null ? this.getDescription() == null
                        : that.getDescription().equals(this.getDescription()))) {
                return false;
        }
        if (!(that.getTimeCheckIn() == null ? this.getTimeCheckIn() == null
                        : that.getTimeCheckIn().equals(this.getTimeCheckIn()))) {
                return false;
        }
        if (!(that.getTimeCheckOut() == null ? this.getTimeCheckOut() == null
                        : that.getTimeCheckOut().equals(this.getTimeCheckOut()))) {
                return false;
        }
        if (!(that.getStatus() == null ? this.getStatus() == null
                		: that.getStatus().equals(this.getStatus()))) {
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
        if (!(that.getProject_id() == null ? this.getProject_id() == null
        				: that.getProject_id().equals(this.getProject_id()))) {
        	return false;
        }
        if (!(that.getFunction_id() == null ? this.getFunction_id() == null
        				: that.getFunction_id().equals(this.getFunction_id()))) {
        	return false;
        }
    return true;
    }

}
