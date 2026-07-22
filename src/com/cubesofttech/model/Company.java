package com.cubesofttech.model;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "company")
public class Company {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "company_id")
	private Long companyId;

	@Column(name = "file_id")
	private String fileId;
	
	@Column(name = "industry_id")
	private String industryId;

	@Column(name = "company_code")
	private String companyCode;

	@Column(name = "tax_number")
	private String taxNumber;

	@Column(name = "company_en")
	private String companyEn;

	@Column(name = "company_th")
	private String companyTh;

	@Column(name = "is_active")
	private String isActive;

	@Column(name = "user_create")
	private String userCreate;

	@Column(name = "user_update")
	private String userUpdate;

	@Column(name = "time_create")
	private Timestamp timeCreate;

	@Column(name = "time_update")
	private Timestamp timeUpdate;

	public Company() {
	}

	public Long getCompanyId() {
		return companyId;
	}

	public void setCompanyId(Long companyId) {
		this.companyId = companyId;
	}

	public String getFileId() {
		return fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	public String getCompanyCode() {
		return companyCode;
	}

	public void setCompanyCode(String companyCode) {
		this.companyCode = companyCode;
	}

	public String getTaxNumber() {
		return taxNumber;
	}

	public void setTaxNumber(String taxNumber) {
		this.taxNumber = taxNumber;
	}

	public String getCompanyEn() {
		return companyEn;
	}

	public void setCompanyEn(String companyEn) {
		this.companyEn = companyEn;
	}

	public String getCompanyTh() {
		return companyTh;
	}

	public void setCompanyTh(String companyTh) {
		this.companyTh = companyTh;
	}

	public String getIndustryId() {
		return industryId;
	}

	public void setIndustryId(String industry) {
		this.industryId = industry;
	}

	public String getIsActive() {
		return isActive;
	}

	public void setIsActive(String isActive) {
		this.isActive = isActive;
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

	public Timestamp getTimeCreate() {
		return timeCreate;
	}

	public void setTimeCreate(Timestamp timeCreate) {
		this.timeCreate = timeCreate;
	}

	public Timestamp getTimeUpdate() {
		return timeUpdate;
	}

	public void setTimeUpdate(Timestamp timeUpdate) {
		this.timeUpdate = timeUpdate;
	}
}