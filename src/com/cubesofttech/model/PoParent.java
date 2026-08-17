package com.cubesofttech.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import javax.persistence.Table;
 @Entity
@Table(name = "po_parent")
public class PoParent implements Serializable{
	 
	 private static final long serialVersionUID = 1L;
	 
	 @Id
	 @Column(name = "po_parent_id")
	 private String poParentId;
	 
	 @Column(name = "po_detail_id")
	 private String poDetailId;
	 
	 @Column(name = "pr_id")
	 private String prId;
	 
	 @Column(name = "product_id")
	 private String productId;
	 
	 @Column(name = "parent_id")
	 private String parentId;
	 
	 @Column(name = "amount")
	 private Double amount;
	 
	 @Column(name = "unit")
	 private String unit;
	 
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

	 public String getPoParentId() {
		 return poParentId;
	 }

	 public void setPoParentId(String poParentId) {
		 this.poParentId = poParentId;
	 }

	 public String getPoDetailId() {
		 return poDetailId;
	 }

	 public void setPoDetailId(String poDetailId) {
		 this.poDetailId = poDetailId;
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

	 public Double getAmount() {
		 return amount;
	 }

	 public void setAmount(Double amount) {
		 this.amount = amount;
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
		return "PoParent [poParentId=" + poParentId + ", poDetailId=" + poDetailId + ", prId=" + prId + ", productId="
				+ productId + ", parentId=" + parentId + ", amount=" + amount + ", unit=" + unit + ", description="
				+ description + ", userCreate=" + userCreate + ", timeCreate=" + timeCreate + ", userUpdate="
				+ userUpdate + ", timeUpdate=" + timeUpdate + "]";
	 }

	
	
}