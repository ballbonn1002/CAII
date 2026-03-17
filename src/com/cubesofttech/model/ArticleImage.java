package com.cubesofttech.model;

import java.io.Serializable;
import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "article_image")
public class ArticleImage implements Serializable{

	public ArticleImage() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ArticleImage(Integer atcImgId, String atcImgUserId, String atcImgName, String atcImgType, String atcImgSize,
			String atcImgPath, Timestamp atcImgTimeUpload) {
		super();
		this.atcImgId = atcImgId;
		this.atcImgUserId = atcImgUserId;
		this.atcImgName = atcImgName;
		this.atcImgType = atcImgType;
		this.atcImgSize = atcImgSize;
		this.atcImgPath = atcImgPath;
		this.atcImgTimeUpload = atcImgTimeUpload;
	}


	@Id
	@Column(name = "atc_img_id")
	private Integer atcImgId;
	
	@Column(name = "atc_user_id")
	private String atcImgUserId;
	
	@Column(name = "atc_img_name")
	private String atcImgName;
	
	@Column(name = "atc_img_type")
	private String atcImgType;
	
	@Column(name = "atc_img_size")
	private String atcImgSize;
	
	@Column(name = "atc_img_path")
	private String atcImgPath;
	
	@Column(name = "atc_time_upload")
	private java.sql.Timestamp atcImgTimeUpload;

	
	public Integer getAtcImgId() {
		return atcImgId;
	}

	public void setAtcImgId(Integer atcImgId) {
		this.atcImgId = atcImgId;
	}

	public String getAtcImgUserId() {
		return atcImgUserId;
	}

	public void setAtcImgUserId(String atcImgUserId) {
		this.atcImgUserId = atcImgUserId;
	}

	public String getAtcImgName() {
		return atcImgName;
	}

	public void setAtcImgName(String atcImgName) {
		this.atcImgName = atcImgName;
	}

	public String getAtcImgType() {
		return atcImgType;
	}

	public void setAtcImgType(String atcImgType) {
		this.atcImgType = atcImgType;
	}

	public String getAtcImgSize() {
		return atcImgSize;
	}

	public void setAtcImgSize(String atcImgSize) {
		this.atcImgSize = atcImgSize;
	}

	public String getAtcImgPath() {
		return atcImgPath;
	}

	public void setAtcImgPath(String atcImgPath) {
		this.atcImgPath = atcImgPath;
	}

	public java.sql.Timestamp getAtcImgTimeUpload() {
		return atcImgTimeUpload;
	}

	public void setAtcImgTimeUpload(java.sql.Timestamp atcImgTimeUpload) {
		this.atcImgTimeUpload = atcImgTimeUpload;
	}
	
	
}
