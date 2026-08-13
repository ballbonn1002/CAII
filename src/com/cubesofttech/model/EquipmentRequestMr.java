package com.cubesofttech.model;

import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
//import javax.persistence.JoinColumn;
//import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "mr")
public class EquipmentRequestMr {
	private static final long serialVersionUID = 1L;

//	@ManyToOne
//	@JoinColumn(name = "status_id", referencedColumnName = "doc_status_id", insertable = false, updatable = false)
//	private DocStatus docStatus; 
//
//	// ⚠️ อย่าลืมสร้าง Getter และ Setter ของตัวแปร docStatus ด้วยนะครับ
//	public DocStatus getDocStatus() {
//	    return docStatus;
//	}
//	public void setDocStatus(DocStatus docStatus) {
//	    this.docStatus = docStatus;
//	}
	    @Id
	    @Column(name = "mr_id")
	    private String mrId;

	    @Column(name = "catalog_items_id")
	    private String catalogItemsId;

	    @Column(name = "item_type")
	    private String itemType;

	    @Column(name = "item_sub_id")
	    private String itemSubId;

	    @Column(name = "amount")
	    private Double amount;

	    @Column(name = "status_id")
	    private String statusId;

	    @Column(name = "request_user")
	    private String requestUser;

	    @Column(name = "request_date")
	    private java.sql.Timestamp requestDate;

	    @Column(name = "Approve_user")
	    private String approveUser;

	    @Column(name = "Approve_date")
	    private java.sql.Date approveDate;

	    @Column(name = "receive_user")
	    private String receiveUser;

	    @Column(name = "receive_date")
	    private java.sql.Date receiveDate;

	    @Column(name = "description")
	    private String description;
	    
	    @Column(name = "url_ref")
	    private String urlRef;

	    @Column(name = "user_update")
	    private java.sql.Timestamp userUpdate;

	    @Column(name = "time_create")
	    private String timeCreate;

	    @Column(name = "time_update")
	    private java.sql.Timestamp timeUpdate;
	    
	  public String getMrId() {
		return mrId;
	}
	public void setMrId(String mrId) {
		this.mrId = mrId;
	}
	public String getCatalogItemsId() {
		return catalogItemsId;
	}
	public void setCatalogItemsId(String catalogItemsId) {
		this.catalogItemsId = catalogItemsId;
	}
	public String getItemType() {
		return itemType;
	}
	public void setItemType(String itemType) {
		this.itemType = itemType;
	}
	public String getItemSubId() {
		return itemSubId;
	}
	public void setItemSubId(String itemSubId) {
		this.itemSubId = itemSubId;
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
	public java.sql.Date getApproveDate() {
		return approveDate;
	}
	public void setApproveDate(java.sql.Date approveDate) {
		this.approveDate = approveDate;
	}
	public String getReceiveUser() {
		return receiveUser;
	}
	public void setReceiveUser(String receiveUser) {
		this.receiveUser = receiveUser;
	}
	public java.sql.Date getReceiveDate() {
		return receiveDate;
	}
	public void setReceiveDate(java.sql.Date receiveDate) {
		this.receiveDate = receiveDate;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
		
	public String getUrlRef() {
		return urlRef;
	}
	public void setUrlRef(String urlRef) {
		this.urlRef = urlRef;
	}
	public java.sql.Timestamp getUserUpdate() {
		return userUpdate;
	}
	public void setUserUpdate(java.sql.Timestamp userUpdate) {
		this.userUpdate = userUpdate;
	}
	public String getTimeCreate() {
		return timeCreate;
	}
	public void setTimeCreate(String timeCreate) {
		this.timeCreate = timeCreate;
	}
	public java.sql.Timestamp getTimeUpdate() {
		return timeUpdate;
	}
	public void setTimeUpdate(java.sql.Timestamp timeUpdate) {
		this.timeUpdate = timeUpdate;
	}
	
	@Override
	public String toString() {
	    return "MrItem [mrId=" + mrId 
	        + ", catalogItemsId=" + catalogItemsId 
	        + ", itemTypw=" + itemType 
	        + ", itemSubId=" + itemSubId 
	        + ", amount=" + amount 
	        + ", statusId=" + statusId 
	        + ", requestUser=" + requestUser 
	        + ", requestDate=" + requestDate 
	        + ", approveUser=" + approveUser 
	        + ", approveDate=" + approveDate 
	        + ", receiveUser=" + receiveUser 
	        + ", receiveDate=" + receiveDate 
	        + ", description=" + description 
	        + ", userUpdate=" + userUpdate 
	        + ", timeCreate=" + timeCreate 
	        + ", timeUpdate=" + timeUpdate 
	        + " , urlRef=" + urlRef
	        + "]";
	}

}
