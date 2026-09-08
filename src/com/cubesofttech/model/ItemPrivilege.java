package com.cubesofttech.model;

import java.sql.Timestamp;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "item_privilege")
public class ItemPrivilege {

	// ==========================================
	// ID
	// ==========================================

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "item_id")
	private Integer itemId;

	// ==========================================
	// Item Information
	// ==========================================

	@Column(name = "item_name", length = 32, nullable = false)
	private String itemName;

	@Column(name = "details", length = 1024)
	private String details;

	@Column(name = "token", nullable = false)
	private Double token = 0.0;

	@Column(name = "quantity", nullable = false)
	private Integer quantity = 0;

	// ==========================================
	// Effective Date
	// ==========================================
	
	@Column(name = "added_money")
	private Double addedMoney = null;

	@Column(name = "start_date", nullable = false)
	private Date startDate;

	@Column(name = "end_date", nullable = false)
	private Date endDate;

	// ==========================================
	// Images
	// ==========================================

	@Column(name = "cover_path", length = 500)
	private String coverPath;

	/**
	 * JSON Array
	 *
	 * Example:
	 * ["image1.jpg", "image2.jpg", "image3.jpg"]
	 */
	@Column(name = "img_path")
	private String imgPath;

	// ==========================================
	// Status
	// ==========================================

	@Column(name = "active_flag", length = 1, nullable = false)
	private String activeFlag = "Y";

	@Column(name = "description", length = 1024)
	private String description;

	// ==========================================
	// Audit
	// ==========================================

	@Column(name = "user_create", length = 32)
	private String userCreate;

	@Column(name = "user_update", length = 32)
	private String userUpdate;

	@Column(name = "time_create")
	private Timestamp timeCreate;

	@Column(name = "time_update")
	private Timestamp timeUpdate;

	// ==========================================
	// Getter / Setter
	// ==========================================

	public Integer getItemId() {
		return itemId;
	}

	public void setItemId(Integer itemId) {
		this.itemId = itemId;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getDetails() {
		return details;
	}

	public void setDetails(String details) {
		this.details = details;
	}

	public Double getToken() {
		return token;
	}

	public void setToken(Double token) {
		this.token = token;
	}

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getCoverPath() {
		return coverPath;
	}

	public void setCoverPath(String coverPath) {
		this.coverPath = coverPath;
	}

	public String getImgPath() {
		return imgPath;
	}

	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
	}

	public String getActiveFlag() {
		return activeFlag;
	}

	public void setActiveFlag(String activeFlag) {
		this.activeFlag = activeFlag;
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

	public String getUserUpdate() {
		return userUpdate;
	}

	public void setUserUpdate(String userUpdate) {
		this.userUpdate = userUpdate;
	}

	public Date getTimeCreate() {
		return timeCreate;
	}

	public void setTimeCreate(Timestamp timeCreate) {
		this.timeCreate = timeCreate;
	}

	public Date getTimeUpdate() {
		return timeUpdate;
	}

	public void setTimeUpdate(Timestamp timeUpdate) {
		this.timeUpdate = timeUpdate;
	}
	
	public Double getAddedMoney() {
		return addedMoney;
	}
	
	public void setAddedMoney(Double addedMoney) {
		this.addedMoney = addedMoney;
	}
}