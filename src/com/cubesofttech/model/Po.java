package com.cubesofttech.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import javax.persistence.Table;
 @Entity
 @Table(name = "po")
public class Po implements Serializable{
	 
	 private static final long serialVersionUID = 1L;
	 
	 @Id
		@Column(name = "po_id")
		private String poId;
	 
		@Column(name = "ref_no")
		private String refNo;
	 
		@Column(name = "ref_date")
		private java.sql.Timestamp refDate;
	 
		@Column(name = "company_id")
		private Long companyId;
	 
		@Column(name = "company_location")
		private Long companyLocation;
	 
		@Column(name = "contact_id")
		private Long contactId;
	 
		@Column(name = "description")
		private String description;

		@Column(name = "description_vendor")
		private String descriptionVendor;
	 
		@Column(name = "user_create")
		private String userCreate;
	 
		@Column(name = "time_create")
		private java.sql.Timestamp timeCreate;
	 
		@Column(name = "user_update")
		private String userUpdate;
	 
		@Column(name = "time_update")
		private java.sql.Timestamp timeUpdate;
	 
		@Column(name = "sign_user")
		private String signUser;
	 
		@Column(name = "sign_date")
		private java.sql.Timestamp signDate;
	 
		@Column(name = "approve_user")
		private String approveUser;
	 
		@Column(name = "approve_date")
		private java.sql.Timestamp approveDate;
	 
		@Column(name = "po_total")
		private Double poTotal;
	 
		@Column(name = "status")
		private String status;

		@Column(name = "reason")
		private String reason;

		public String getPoId() {
			return poId;
		}

		public void setPoId(String poId) {
			this.poId = poId;
		}

		public String getRefNo() {
			return refNo;
		}

		public void setRefNo(String refNo) {
			this.refNo = refNo;
		}

		public java.sql.Timestamp getRefDate() {
			return refDate;
		}

		public void setRefDate(java.sql.Timestamp refDate) {
			this.refDate = refDate;
		}

		public Long getCompanyId() {
			return companyId;
		}

		public void setCompanyId(Long companyId) {
			this.companyId = companyId;
		}

		public Long getCompanyLocation() {
			return companyLocation;
		}

		public void setCompanyLocation(Long companyLocation) {
			this.companyLocation = companyLocation;
		}

		public Long getContactId() {
			return contactId;
		}

		public void setContactId(Long contactId) {
			this.contactId = contactId;
		}

		public String getDescription() {
			return description;
		}

		public void setDescription(String description) {
			this.description = description;
		}

		public String getDescriptionVendor() {
			return descriptionVendor;
		}

		public void setDescriptionVendor(String descriptionVendor) {
			this.descriptionVendor = descriptionVendor;
		}

		public String getUserCreate() {
			return userCreate;
		}

		public void setUserCreate(String userCreate) {
			this.userCreate = userCreate;
		}

		public java.sql.Timestamp getTimeCreate() {
			return timeCreate;
		}

		public void setTimeCreate(java.sql.Timestamp timeCreate) {
			this.timeCreate = timeCreate;
		}

		public String getUserUpdate() {
			return userUpdate;
		}

		public void setUserUpdate(String userUpdate) {
			this.userUpdate = userUpdate;
		}

		public java.sql.Timestamp getTimeUpdate() {
			return timeUpdate;
		}

		public void setTimeUpdate(java.sql.Timestamp timeUpdate) {
			this.timeUpdate = timeUpdate;
		}

		public String getSignUser() {
			return signUser;
		}

		public void setSignUser(String signUser) {
			this.signUser = signUser;
		}

		public java.sql.Timestamp getSignDate() {
			return signDate;
		}

		public void setSignDate(java.sql.Timestamp signDate) {
			this.signDate = signDate;
		}

		public String getApproveUser() {
			return approveUser;
		}

		public void setApproveUser(String approveUser) {
			this.approveUser = approveUser;
		}

		public java.sql.Timestamp getApproveDate() {
			return approveDate;
		}

		public void setApproveDate(java.sql.Timestamp approveDate) {
			this.approveDate = approveDate;
		}

		public Double getPoTotal() {
			return poTotal;
		}

		public void setPoTotal(Double poTotal) {
			this.poTotal = poTotal;
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

		@Override
		public String toString() {
			return "Po [poId=" + poId + ", refNo=" + refNo + ", refDate=" + refDate + ", companyId=" + companyId
					+ ", companyLocation=" + companyLocation + ", contactId=" + contactId + ", description="
					+ description +", descriptionVendor=" + descriptionVendor + ", userCreate=" + userCreate + ", timeCreate=" + timeCreate + ", userUpdate="
					+ userUpdate + ", timeUpdate=" + timeUpdate + ", signUser=" + signUser + ", signDate=" + signDate
					+ ", approveUser=" + approveUser + ", approveDate=" + approveDate + ", poTotal=" + poTotal
					+ ", status=" + status + ", reason=" + reason + "]";
		}

		
}