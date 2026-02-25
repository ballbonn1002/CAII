package com.cubesofttech.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
 @Entity
@Table(name = "article")
public class Article implements Serializable{

	/** Creates a new instance of Article */
	public Article() {
		// TODO Auto-generated constructor stub
	}
	
	public Article(Integer articleId,
					String pageId,
					Integer articleTypeId,
					String detail,
					String detail_en,
					String topic,
					String topic_en,
					java.sql.Timestamp timePost,
					String userId,
					String description,
					String status,
					java.sql.Timestamp timeCreate,
					java.sql.Timestamp timeUpdate,
					String userUpdate,
					String fileId,
					String userCreate,
					String title,
					String meta_desc,
					String articleTagId
			) {
		this.articleId = articleId;
		this.pageId = pageId;
		this.articleTypeId = articleTypeId;
		this.detail = detail;
		this.detail_en = detail_en;
		this.topic = topic;
		this.topic_en = topic_en;
		this.timePost = timePost;
		this.userId = userId;
		this.description = description;
		this.status = status;
		this.timeCreate = timeCreate;
		this.timeUpdate = timeUpdate;
		this.userUpdate = userUpdate;
		this.fileId = fileId;
		this.articleTagId = articleTagId;
		this.userCreate = userCreate;
		this.title = title;
		this.meta_desc = meta_desc;
	}
	
	@Id
	@Column(name = "article_id")
	private Integer articleId;
	
	@Column(name = "page_id")
	private String pageId;
	
	@Column(name = "article_type_id")
	private Integer articleTypeId;
	
	@Column(name = "article_tag_id")
	private String articleTagId;
	
	@Column(name = "topic")
	private String topic;
	
	@Column(name = "topic_en")
	private String topic_en;
	
	@Column(name = "user_id")
	private String userId;
	
	@Column(name = "detail")
	private String detail;
	
	@Column(name = "detail_en")
	private String detail_en;
	
	@Column(name = "description")
	private String description;
	
	@Column(name = "status")
	private String status;
	
	@Column(name = "file_id")
	private String fileId;
	
	@Column(name = "title")
	private String title;
	
	@Column(name = "meta_desc")
	private String meta_desc;
	
	@Column(name = "user_create")
	private String userCreate;
	
	@Column(name = "time_create")
	private java.sql.Timestamp timeCreate;
	
	@Column(name = "user_update")
	private String userUpdate;
	
	@Column(name = "time_update")
	private java.sql.Timestamp timeUpdate;
	
	@Column(name = "time_post")
	private java.sql.Timestamp timePost;

	public java.sql.Timestamp getTimePost() {
		return timePost;
	}

	public void setTimePost(java.sql.Timestamp timePost) {
		this.timePost = timePost;
	}

	public Integer getArticleId() {
		return articleId;
	}

	public void setArticleId(Integer articleId) {
		this.articleId = articleId;
	}
	
	public String getPageId() {
		return pageId;
	}

	public void setPageId(String pageId) {
		this.pageId = pageId;
	}

	public Integer getArticleTypeId() {
		return articleTypeId;
	}

	public void setArticleTypeId(Integer articleTypeId) {
		this.articleTypeId = articleTypeId;
	}
	

	public String getArticleTagId() {
		return articleTagId;
	}

	public void setArticleTagId(String articleTagId) {
		this.articleTagId = articleTagId;
	}

	public String getTopic() {
		return topic;
	}

	public void setTopic(String topic) {
		this.topic = topic;
	}

	public String getTopic_en() {
		return topic_en;
	}

	public void setTopic_en(String topic_en) {
		this.topic_en = topic_en;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public String getDetail_en() {
		return detail_en;
	}

	public void setDetail_en(String detail_en) {
		this.detail_en = detail_en;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getFileId() {
		return fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
	}
	
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getMeta_desc() {
		return meta_desc;
	}

	public void setMeta_desc(String meta_desc) {
		this.meta_desc = meta_desc;
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
	
	
	
}
