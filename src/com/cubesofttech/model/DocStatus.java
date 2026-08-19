package com.cubesofttech.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "doc_status")
public class DocStatus implements Serializable {
	
	private static final long serialVersionUID = 1L;

	   @Id
	    @Column(name = "doc_status_id")
	    private String docStatusId;

	    @Column(name = "status_code")
	    private String statusCode;

	    @Column(name = "status_name")
	    private String statusName;

	    @Column(name = "group")
	    private String group;
	    
	    @Column(name = "description")
	    private String description;

	    @Column(name = "time_create")
		private java.sql.Timestamp timeCreate;

	    @Column(name = "time_update")
	    private java.sql.Timestamp timeUpdate;

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

		public String getGroup() {
			return group;
		}

		public void setGroup(String group) {
			this.group = group;
		}

		public String getDescription() {
			return description;
		}

		public void setDescription(String description) {
			this.description = description;
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
			return "DocStatus [docStatusId=" + docStatusId + ", statusCode=" + statusCode + ", statusName=" + statusName
					+ ", group=" + group + ", description=" + description + ", timeCreate=" + timeCreate
					+ ", timeUpdate=" + timeUpdate + ", userCreate=" + userCreate + ", userUpdate=" + userUpdate + "]";
		}
	    
	    
		
}
