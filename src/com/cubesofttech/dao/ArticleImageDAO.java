package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import com.cubesofttech.model.Article;
import com.cubesofttech.model.ArticleImage;
import com.cubesofttech.model.ArticleRelated;
import com.cubesofttech.model.ArticleTag;
import com.cubesofttech.model.ArticleType;

public interface ArticleImageDAO {

	List<ArticleImage> findAll() throws Exception;
	void save(ArticleImage ArticleImage) throws Exception;
	public Integer getMaxId() throws Exception;
	void deleteByPath(String path);

	
}
