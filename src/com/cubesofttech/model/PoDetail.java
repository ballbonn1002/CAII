package com.cubesofttech.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import javax.persistence.Table;
 @Entity
@Table(name = "po_detail")
public class PoDetail implements Serializable{
	 
	 private static final long serialVersionUID = 1L;
	 
	 	@Id
		@Column(name = "po_detail_id")
		private String poDetailId;
	 
		@Column(name = "po_id")
		private String poId;
	 
		@Column(name = "product_id")
		private String productId;
	 
		@Column(name = "parent_id")
		private String parentId;
	 
		@Column(name = "amount_total")
		private Double amountTotal;
	 
		@Column(name = "unit")
		private String unit;
	 
		@Column(name = "unit_price")
		private String unitPrice;
	 
		@Column(name = "price_total")
		private Double priceTotal;
	 
		@Column(name = "description")
		private String description;
	 
		@Column(name = "user_create")
		private String userCreate;
	
		@Column(name = "time_create")
		private java.sql.Timestamp timeCreate;
	
		@Column(name = "user_update")
		private String userUpdate;
	
		@Column(name = "time_update")
		private java.sql.Timestamp timeUpdate;

		public String getPoDetailId() {
			return poDetailId;
		}

		public void setPoDetailId(String poDetailId) {
			this.poDetailId = poDetailId;
		}

		public String getPoId() {
			return poId;
		}

		public void setPoId(String poId) {
			this.poId = poId;
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

		public String getUnitPrice() {
			return unitPrice;
		}

		public void setUnitPrice(String unitPrice) {
			this.unitPrice = unitPrice;
		}

		public Double getPriceTotal() {
			return priceTotal;
		}

		public void setPriceTotal(Double priceTotal) {
			this.priceTotal = priceTotal;
		}

		public String getDescription() {
			return description;
		}

		public void setDescription(String description) {
			this.description = description;
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
			return "PoDetail [poDetailId=" + poDetailId + ", poId=" + poId + ", productId="
					+ productId + ", parentId=" + parentId + ", amountTotal=" + amountTotal
					+ ", unit=" + unit + ", unitPrice=" + unitPrice + ", priceTotal=" + priceTotal + ", description="
					+ description + ", userCreate=" + userCreate + ", timeCreate=" + timeCreate + ", userUpdate="
					+ userUpdate + ", timeUpdate=" + timeUpdate + "]";
		}

		
	
}