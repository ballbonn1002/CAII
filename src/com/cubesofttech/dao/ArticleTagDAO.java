package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import com.cubesofttech.model.Article;
import com.cubesofttech.model.ArticleImage;
import com.cubesofttech.model.ArticleRelated;
import com.cubesofttech.model.ArticleTag;
import com.cubesofttech.model.ArticleType;

public interface ArticleTagDAO {

	List<ArticleTag> findAll() throws Exception;

	List<Integer> findTagIdByArticleId(String articleId) throws Exception;

	void save(ArticleTag ArticleTag) throws Exception;

	void deleteByArticleId(String articleId);

	void update(ArticleTag ArticleTag) throws Exception;

	
}
