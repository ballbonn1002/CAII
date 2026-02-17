package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import com.cubesofttech.model.Article;
import com.cubesofttech.model.ArticleImage;
import com.cubesofttech.model.ArticleRelated;
import com.cubesofttech.model.ArticleTag;
import com.cubesofttech.model.ArticleType;

public interface ArticleRelatedDAO {

	List<ArticleRelated> findAll() throws Exception;

	List<ArticleRelated> findRelatedIdByArticleId(String articleId) throws Exception;

	void save(ArticleRelated ArticleRelated) throws Exception;

	void deleteByArticleId(String articleId);

	void update(ArticleRelated ArticleRelated) throws Exception;

	
}
