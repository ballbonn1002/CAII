package com.cubesofttech.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "article_tag")
public class ArticleTag implements Serializable{
	
	public ArticleTag() {
			super();
			// TODO Auto-generated constructor stub
		}
	
	public ArticleTag(String articleId, String tagId) {
			super();
			this.articleId = articleId;
			TagId = tagId;
		}

	@Id
	@Column(name = "article_id ")
	private String articleId;
	
	@Id
	@Column(name = "tag_id")
	private String TagId;

	public String getArticleId() {
		return articleId;
	}

	public void setArticleId(String articleId) {
		this.articleId = articleId;
	}

	public String getTagId() {
		return TagId;
	}

	public void setTagId(String tagId) {
		TagId = tagId;
	}
	
	
}
