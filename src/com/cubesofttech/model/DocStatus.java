package com.cubesofttech.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "doc_status")
public class DocStatus {
	
	private static final long serialVersionUID = 1L;

	   @Id
	    @Column(name = "doc_status_id")
	    private String docStatusId;

	    @Column(name = "status_code")
	    private String statusCode;

	    @Column(name = "status_name")
	    private String statusName;

	    @Column(name = "`group`")
	    private String group;
	    
	    @Column(name = "decscription") // สะกดตัว r สลับตามตารางเดิมของคุณ
	    private String decscription;

	    @Column(name = "time_create")
	    @Temporal(TemporalType.TIMESTAMP)
	    private java.util.Date timeCreate;

	    @Column(name = "time_update")
	    @Temporal(TemporalType.TIMESTAMP)
	    private java.util.Date timeUpdate;

	    @Column(name = "user_create")
	    private String userCreate;

	    @Column(name = "user_update")
	    private String userUpdate;
	    
		public String getDocStatusId() {
			return docStatusId;
		}
		public void setDocStatusId(String docStatusId) {
			this.docStatusId = docStatusId;
		}
		public String getStatusCode() {
			return statusCode;
		}
		public void setStatusCode(String statusCode) {
			this.statusCode = statusCode;
		}
		public String getStatusName() {
			return statusName;
		}
		public void setStatusName(String statusName) {
			this.statusName = statusName;
		}
		public String getDecscription() {
			return decscription;
		}
		public void setDecscription(String decscription) {
			this.decscription = decscription;
		}
		public String getGroup() {
			return group;
		}
		public void setGroup(String group) {
			this.group = group;
		}
	
		public java.util.Date getTimeCreate() {
			return timeCreate;
		}
		public void setTimeCreate(java.util.Date timeCreate) {
			this.timeCreate = timeCreate;
		}
		public java.util.Date getTimeUpdate() {
			return timeUpdate;
		}
		public void setTimeUpdate(java.util.Date timeUpdate) {
			this.timeUpdate = timeUpdate;
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
	
		@Override
		public String toString() {
		    return "EquipmentRequestMrGetDocStatus [" +
		           "docStatusId=" + docStatusId + 
		           ", statusCode=" + statusCode + 
		           ", statusName=" + statusName + 
		           ", decscription=" + decscription + 
		           ", group=" + group + 
		           ", timeCreate=" + timeCreate + 
		           ", timeUpdate=" + timeUpdate + 
		           ", userCreate=" + userCreate + 
		           ", userUpdate=" + userUpdate + "]";
		}
}
