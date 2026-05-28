package com.cubesofttech.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "job")
public class Job implements Serializable{
   private static final long serialVersionUID = 1L;
   @Id
   
   @Column(name = "job_id")
   private Integer jobId;
   @Column(name = "name")
   private String name;
   @Column(name = "description")
   private String description;
   @Column(name = "position")
   private String position;
   @Column(name = "start_date")
   private Date startDate;
   @Column(name = "salary_min")
   private Integer salaryMin; 
   @Column(name = "salary_max")
   private Integer salaryMax; 
   @Column(name = "end_date")
   private Date endDate;
   @Column(name = "user_create")
   private String userCreate;
   @Column(name = "user_update")
   private String userUpdate;
   @Column(name = "time_create")
   private java.sql.Timestamp timeCreate;
   @Column(name = "time_update")
   private java.sql.Timestamp timeUpdate;

   public Integer getJobId() {
       return jobId;
   }

   public void setJobId(Integer jobId) {
       this.jobId = jobId;
   }

   public String getName() {
       return name;
   }

   public void setName(String name) {
       this.name = name;
   }

   public String getDescription() {
       return description;
   }

   public void setDescription(String description) {
       this.description = description;
   }

   public String getPosition() {
       return position;
   }

   public void setPosition(String position) {
       this.position = position;
   }

   public Date getStartDate() {
       return startDate;
   }

   public void setStartDate(Date startDate) {
       this.startDate = startDate;
   }

   public Integer getSalaryMin() {
       return salaryMin;
   }

   public void setSalaryMin(Integer salaryMin) {
       this.salaryMin = salaryMin;
   }

   public Integer getSalaryMax() {
       return salaryMax;
   }

   public void setSalaryMax(Integer salaryMax) {
       this.salaryMax = salaryMax;
   }

   public Date getEndDate() {
       return endDate;
   }

   public void setEndDate(Date endDate) {
       this.endDate = endDate;
   }

   public String getUserCreate() {
       return userCreate;
   }

   public void setUserCreate(String userCreate) {
       this.userCreate = userCreate;
   }

   public String getUserUpdate() {
       return userUpdate;
   }

   public void setUserUpdate(String userUpdate) {
       this.userUpdate = userUpdate;
   }

   public java.sql.Timestamp getTimeCreate() {
       return timeCreate;
   }

   public void setTimeCreate(java.sql.Timestamp timeCreate) {
       this.timeCreate = timeCreate;
   }

   public java.sql.Timestamp getTimeUpdate() {
       return timeUpdate;
   }

   public void setTimeUpdate(java.sql.Timestamp timeUpdate) {
       this.timeUpdate = timeUpdate;
   }
}
