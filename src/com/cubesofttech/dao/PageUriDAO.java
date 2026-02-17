package com.cubesofttech.dao;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import com.cubesofttech.model.PageUri;

public interface PageUriDAO {

	List<PageUri> findAll() throws Exception;

	void save(PageUri PageUri) throws Exception;

	PageUri findById(String modeId) throws Exception;

	void deleteByModelId(String articleId);

	void update(PageUri PageUri) throws Exception;
	
}
