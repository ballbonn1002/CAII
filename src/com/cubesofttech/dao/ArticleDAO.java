package com.cubesofttech.dao;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import com.cubesofttech.model.Article;
import com.cubesofttech.model.ArticleImage;
import com.cubesofttech.model.ArticleRelated;
import com.cubesofttech.model.ArticleTag;
import com.cubesofttech.model.ArticleType;

public interface ArticleDAO {

	List<Article> findAll() throws Exception;

	List<Map<String, Object>> findAllArticlesWithType() throws Exception;

	Article findById(Integer articleId) throws Exception;

	List<Map<String, Object>> findArticlesByDateRange(LocalDateTime startDate, LocalDateTime endDate) throws Exception;

	public void save(Article article) throws Exception;

	Integer getMaxId() throws Exception;

	void delete(Article Article) throws Exception;

	void update(Article Article) throws Exception;
	

	
}
