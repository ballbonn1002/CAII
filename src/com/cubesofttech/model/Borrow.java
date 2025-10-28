
package com.cubesofttech.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "borrow")
@NamedQueries({
    @NamedQuery(name = "Borrow.findAll", query = "SELECT t FROM Borrow t")})
public class Borrow implements Serializable {
    
    /** Creates a new instance of Borrow */
    public Borrow() {
    }
    public Borrow(
            Integer borrowId	
            , Integer borrowAmout	
            , String reason	
            , String userBorrowid	
            , java.sql.Timestamp dateStart	
            , java.sql.Timestamp dateEnd	
            , String location	
            , String contactAddr	
            , String status	
            , Integer sum	
            , java.sql.Timestamp timeCreate	
            , String userCreate	
            , java.sql.Timestamp timeUpdate	
            , String userUpdate	
            , String equipmentId	
            , String remark	
            , String reasona	
          
        ) {
        this.borrowId = borrowId;	
        this.borrowAmout = borrowAmout;	
        this.reason = reason;	
        this.userBorrowid = userBorrowid;	
        this.dateStart = dateStart;	
        this.dateEnd = dateEnd;	
        this.location = location;	
        this.contactAddr = contactAddr;	
        this.status = status;	
        this.sum = sum;	
        this.timeCreate = timeCreate;	
        this.userCreate = userCreate;	
        this.timeUpdate = timeUpdate;	
        this.userUpdate = userUpdate;	
        this.equipmentId = equipmentId;	
        this.remark = remark;	
        this.reasona = reasona;	
      
    }
    
    @Id
    @Column(name = "borrow_id")
    private Integer borrowId;	
    @Column(name = "borrow_amout")
    private Integer borrowAmout;	
    @Column(name = "reason")
    private String reason;	
    @Column(name = "user_borrowid")
    private String userBorrowid;	
    @Column(name = "date_start")
    private java.sql.Timestamp dateStart;	
    @Column(name = "date_end")
    private java.sql.Timestamp dateEnd;	
    @Column(name = "location")
    private String location;	
    @Column(name = "contact_addr")
    private String contactAddr;	
    @Column(name = "status")
    private String status;	
    @Column(name = "sum")
    private Integer sum;	
    @Column(name = "time_create")
    private java.sql.Timestamp timeCreate;	
    @Column(name = "user_create")
    private String userCreate;	
    @Column(name = "time_update")
    private java.sql.Timestamp timeUpdate;	
    @Column(name = "user_update")
    private String userUpdate;	
    @Column(name = "equipment_id")
    private String equipmentId;	
    @Column(name = "remark")
    private String remark;	
    @Column(name = "reasona")
    private String reasona;	
   



    public Integer getBorrowId() {
        return this.borrowId;
    }		
    public void setBorrowId(Integer borrowId) {
        this.borrowId = borrowId;
    }
    public Integer getBorrowAmout() {
        return this.borrowAmout;
    }		
    public void setBorrowAmout(Integer borrowAmout) {
        this.borrowAmout = borrowAmout;
    }
    public String getReason() {
        return this.reason;
    }		
    public void setReason(String reason) {
        this.reason = reason;
    }
    public String getUserBorrowid() {
        return this.userBorrowid;
    }		
    public void setUserBorrowid(String userBorrowid) {
        this.userBorrowid = userBorrowid;
    }
    public java.sql.Timestamp getDateStart() {
        return this.dateStart;
    }		
    public void setDateStart(java.sql.Timestamp dateStart) {
        this.dateStart = dateStart;
    }
    public java.sql.Timestamp getDateEnd() {
        return this.dateEnd;
    }		
    public void setDateEnd(java.sql.Timestamp dateEnd) {
        this.dateEnd = dateEnd;
    }
    public String getLocation() {
        return this.location;
    }		
    public void setLocation(String location) {
        this.location = location;
    }
    public String getContactAddr() {
        return this.contactAddr;
    }		
    public void setContactAddr(String contactAddr) {
        this.contactAddr = contactAddr;
    }
    public String getStatus() {
        return this.status;
    }		
    public void setStatus(String status) {
        this.status = status;
    }
    public Integer getSum() {
        return this.sum;
    }		
    public void setSum(Integer sum) {
        this.sum = sum;
    }
    public java.sql.Timestamp getTimeCreate() {
        return this.timeCreate;
    }		
    public void setTimeCreate(java.sql.Timestamp timeCreate) {
        this.timeCreate = timeCreate;
    }
    public String getUserCreate() {
        return this.userCreate;
    }		
    public void setUserCreate(String userCreate) {
        this.userCreate = userCreate;
    }
    public java.sql.Timestamp getTimeUpdate() {
        return this.timeUpdate;
    }		
    public void setTimeUpdate(java.sql.Timestamp timeUpdate) {
        this.timeUpdate = timeUpdate;
    }
    public String getUserUpdate() {
        return this.userUpdate;
    }		
    public void setUserUpdate(String userUpdate) {
        this.userUpdate = userUpdate;
    }
    public String getEquipmentId() {
        return this.equipmentId;
    }		
    public void setEquipmentId(String equipmentId) {
        this.equipmentId = equipmentId;
    }
    public String getRemark() {
        return this.remark;
    }		
    public void setRemark(String remark) {
        this.remark = remark;
    }
    public String getReasona() {
        return this.reasona;
    }		
    public void setReasona(String reasona) {
        this.reasona = reasona;
    }
    


    
    public String toString() {
        return super.toString() + "borrowId=[" + borrowId + "]\n" + "borrowAmout=[" + borrowAmout + "]\n" + "reason=[" + reason + "]\n" + "userBorrowid=[" + userBorrowid + "]\n" + "dateStart=[" + dateStart + "]\n" + "dateEnd=[" + dateEnd + "]\n" + "location=[" + location + "]\n" + "contactAddr=[" + contactAddr + "]\n" + "status=[" + status + "]\n" + "sum=[" + sum + "]\n" + "timeCreate=[" + timeCreate + "]\n" + "userCreate=[" + userCreate + "]\n" + "timeUpdate=[" + timeUpdate + "]\n" + "userUpdate=[" + userUpdate + "]\n" + "equipmentId=[" + equipmentId + "]\n" + "remark=[" + remark + "]\n" + "reasona=[" + reasona + "]\n";
    }

    public boolean equals(Object obj) {
        if (this == obj) {
                return true;
        }
        if (!(obj instanceof Borrow)) {
                return false;
        }
        Borrow that = (Borrow) obj;
        if (!(that.getBorrowId() == null ? this.getBorrowId() == null
                        : that.getBorrowId().equals(this.getBorrowId()))) {
                return false;
        }
        if (!(that.getBorrowAmout() == null ? this.getBorrowAmout() == null
                        : that.getBorrowAmout().equals(this.getBorrowAmout()))) {
                return false;
        }
        if (!(that.getReason() == null ? this.getReason() == null
                        : that.getReason().equals(this.getReason()))) {
                return false;
        }
        if (!(that.getUserBorrowid() == null ? this.getUserBorrowid() == null
                        : that.getUserBorrowid().equals(this.getUserBorrowid()))) {
                return false;
        }
        if (!(that.getDateStart() == null ? this.getDateStart() == null
                        : that.getDateStart().equals(this.getDateStart()))) {
                return false;
        }
        if (!(that.getDateEnd() == null ? this.getDateEnd() == null
                        : that.getDateEnd().equals(this.getDateEnd()))) {
                return false;
        }
        if (!(that.getLocation() == null ? this.getLocation() == null
                        : that.getLocation().equals(this.getLocation()))) {
                return false;
        }
        if (!(that.getContactAddr() == null ? this.getContactAddr() == null
                        : that.getContactAddr().equals(this.getContactAddr()))) {
                return false;
        }
        if (!(that.getStatus() == null ? this.getStatus() == null
                        : that.getStatus().equals(this.getStatus()))) {
                return false;
        }
        if (!(that.getSum() == null ? this.getSum() == null
                        : that.getSum().equals(this.getSum()))) {
                return false;
        }
        if (!(that.getTimeCreate() == null ? this.getTimeCreate() == null
                        : that.getTimeCreate().equals(this.getTimeCreate()))) {
                return false;
        }
        if (!(that.getUserCreate() == null ? this.getUserCreate() == null
                        : that.getUserCreate().equals(this.getUserCreate()))) {
                return false;
        }
        if (!(that.getTimeUpdate() == null ? this.getTimeUpdate() == null
                        : that.getTimeUpdate().equals(this.getTimeUpdate()))) {
                return false;
        }
        if (!(that.getUserUpdate() == null ? this.getUserUpdate() == null
                        : that.getUserUpdate().equals(this.getUserUpdate()))) {
                return false;
        }
        if (!(that.getEquipmentId() == null ? this.getEquipmentId() == null
                        : that.getEquipmentId().equals(this.getEquipmentId()))) {
                return false;
        }
        if (!(that.getRemark() == null ? this.getRemark() == null
                        : that.getRemark().equals(this.getRemark()))) {
                return false;
        }
        if (!(that.getReasona() == null ? this.getReasona() == null
                        : that.getReasona().equals(this.getReasona()))) {
                return false;
        }
       
    return true;
    }

}
