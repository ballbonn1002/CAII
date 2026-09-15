package com.cubesofttech.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import javax.persistence.Table;
 @Entity
@Table(name = "pr_detail")
public class PrDetail implements Serializable{
	 
	 private static final long serialVersionUID = 1L;
	 
	 	@Id
		@Column(name = "pr_detail_id")
		private String prDetailId;
	 
		@Column(name = "pr_id")
		private String prId;
	 
		@Column(name = "product_id")
		private String productId;
	 
		@Column(name = "parent_id")
		private String parentId;
	 
		@Column(name = "amount_total")
		private Double amountTotal;
	 
		@Column(name = "unit")
		private String unit;

		@Column(name = "description")
		private String description;

		@Column(name = "ref_link")
		private String refLink;

		@Column(name = "status")
		private String status;

		@Column(name = "user_create")
		private String userCreate;
	
		@Column(name = "time_create")
		private java.sql.Timestamp timeCreate;
	
		@Column(name = "user_update")
		private String userUpdate;
	
		@Column(name = "time_update")
		private java.sql.Timestamp timeUpdate;

		public String getPrDetailId() {
			return prDetailId;
		}

		public void setPrDetailId(String prDetailId) {
			this.prDetailId = prDetailId;
		}

		public String getPrId() {
			return prId;
		}

		public void setPrId(String prId) {
			this.prId = prId;
		}

		public String getProductId() {
			return productId;
		}

		public void setProductId(String productId) {
			this.productId = productId;
		}

		public String getParentId() {
			return parentId;
		}

		public void setParentId(String parentId) {
			this.parentId = parentId;
		}

		public Double getAmountTotal() {
			return amountTotal;
		}

		public void setAmountTotal(Double amountTotal) {
			this.amountTotal = amountTotal;
		}

		public String getUnit() {
			return unit;
		}

		public void setUnit(String unit) {
			this.unit = unit;
		}

		public String getDescription() {
			return description;
		}

		public void setDescription(String description) {
			this.description = description;
		}

		public String getRefLink() {
			return refLink;
		}

		public void setRefLink(String refLink) {
			this.refLink = refLink;
		}

		public String getStatus() {
			return status;
		}

		public void setStatus(String status) {
			this.status = status;
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
			return "PrDetail [prDetailId=" + prDetailId + ", prId=" + prId + ", productId="
					+ productId + ", parentId=" + parentId + ", amountTotal=" + amountTotal
					+ ", unit=" + unit + ", description="
					+ description + ", refLink=" + refLink + ", status=" + status + ", userCreate=" + userCreate + ", timeCreate=" + timeCreate + ", userUpdate="
					+ userUpdate + ", timeUpdate=" + timeUpdate + "]";
		}

		
	
}