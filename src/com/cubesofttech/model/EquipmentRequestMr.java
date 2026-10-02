package com.cubesofttech.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import javax.persistence.Table;
 @Entity
 @Table(name = "mr")
public class EquipmentRequestMr implements Serializable{
	 
	 private static final long serialVersionUID = 1L;
	 
	 	@Id
		@Column(name = "mr_id")
		private String mrId;
	 
		@Column(name = "product_id")
		private String producId;
	 
		@Column(name = "parent_id")
		private String parentId;
		
		@Column(name = "amount")
		private Double amount;
	 
		@Column(name = "status_id")
		private String statusId;
	 
		@Column(name = "request_user")
		private String requestUser;
		
		@Column(name = "request_date")
		private java.sql.Timestamp requestDate;
		
		@Column(name = "approve_user")
		private String approveUser;
		
		@Column(name = "approve_date")
		private java.sql.Timestamp approveDate;
		
		@Column(name = "receive_user")
		private String receiveUser;
		
		@Column(name = "receive_date")
		private java.sql.Timestamp receiveDate;
	 
		@Column(name = "description")
		private String description;
		
		@Column(name = "reason")
		private String reason;
		
		@Column(name = "url_ref")
		private String urlRef;
		
		@Column(name = "user_create")
		private String userCreate;
	 
		@Column(name = "time_create")
		private java.sql.Timestamp timeCreate;
	 
		@Column(name = "user_update")
		private String userUpdate;
	 
		@Column(name = "time_update")
		private java.sql.Timestamp timeUpdate;

		public String getMrId() {
			return mrId;
		}

		public void setMrId(String mrId) {
			this.mrId = mrId;
		}

		public String getProducId() {
			return producId;
		}

		public void setProducId(String producId) {
			this.producId = producId;
		}

		public String getParentId() {
			return parentId;
		}

		public void setParentId(String parentId) {
			this.parentId = parentId;
		}

		public Double getAmount() {
			return amount;
		}

		public void setAmount(Double amount) {
			this.amount = amount;
		}

		public String getStatusId() {
			return statusId;
		}

		public void setStatusId(String statusId) {
			this.statusId = statusId;
		}

		public String getRequestUser() {
			return requestUser;
		}

		public void setRequestUser(String requestUser) {
			this.requestUser = requestUser;
		}

		public java.sql.Timestamp getRequestDate() {
			return requestDate;
		}

		public void setRequestDate(java.sql.Timestamp requestDate) {
			this.requestDate = requestDate;
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

		public String getReceiveUser() {
			return receiveUser;
		}

		public void setReceiveUser(String receiveUser) {
			this.receiveUser = receiveUser;
		}

		public java.sql.Timestamp getReceiveDate() {
			return receiveDate;
		}

		public void setReceiveDate(java.sql.Timestamp receiveDate) {
			this.receiveDate = receiveDate;
		}

		public String getDescription() {
			return description;
		}

		public void setDescription(String description) {
			this.description = description;
		}

		public String getReason() {
			return reason;
		}

		public void setReason(String reason) {
			this.reason = reason;
		}

		public String getUrlRef() {
			return urlRef;
		}

		public void setUrlRef(String urlRef) {
			this.urlRef = urlRef;
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

		@Override
		public String toString() {
			return "EquipmentRequestMr [mrId=" + mrId + ", producId=" + producId + ", parentId=" + parentId
					+ ", amount=" + amount + ", statusId=" + statusId + ", requestUser=" + requestUser
					+ ", requestDate=" + requestDate + ", approveUser=" + approveUser + ", approveDate=" + approveDate
					+ ", receiveUser=" + receiveUser + ", receiveDate=" + receiveDate + ", description=" + description
					+ ", reason=" + reason + ", urlRef=" + urlRef + ", userCreate=" + userCreate + ", timeCreate="
					+ timeCreate + ", userUpdate=" + userUpdate + ", timeUpdate=" + timeUpdate + "]";
		}
		
}