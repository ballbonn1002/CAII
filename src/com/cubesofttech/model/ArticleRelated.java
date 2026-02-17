package com.cubesofttech.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "article_related")
public class ArticleRelated implements Serializable{
	
	public ArticleRelated() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ArticleRelated(String articleId, String relatedArticleId) {
		super();
		this.articleId = articleId;
		this.relatedArticleId = relatedArticleId;
	}

	@Id
	@Column(name = "article_id ")
	private String articleId;
	@Id
	@Column(name = "related_article_id")
	private String relatedArticleId;

	public String getArticleId() {
		return articleId;
	}

	public void setArticleId(String articleId) {
		this.articleId = articleId;
	}

	public String getRelatedArticleId() {
		return relatedArticleId;
	}

	public void setRelatedArticleId(String relatedArticleId) {
		this.relatedArticleId = relatedArticleId;
	}

	@Override
	public String toString() {
		return "ArticleRelated [articleId=" + articleId + ", relatedArticleId=" + relatedArticleId + "]";
	}
	
	
	

}
