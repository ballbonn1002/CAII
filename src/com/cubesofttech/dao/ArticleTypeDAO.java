package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import com.cubesofttech.model.Article;
import com.cubesofttech.model.ArticleImage;
import com.cubesofttech.model.ArticleRelated;
import com.cubesofttech.model.ArticleTag;
import com.cubesofttech.model.ArticleType;

public interface ArticleTypeDAO {

	List<ArticleType> findAll() throws Exception;
	List<Map<String, Object>> findArticleTypeById(Integer articleTypeId);
	void update(ArticleType ArticleType) throws Exception;

	
}
