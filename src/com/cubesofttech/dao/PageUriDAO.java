package com.cubesofttech.dao;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import com.cubesofttech.model.PageUri;

public interface PageUriDAO {

	List<PageUri> findAll() throws Exception;

	void save(PageUri PageUri) throws Exception;

	void update(PageUri PageUri) throws Exception;
	
	void delete(PageUri PageUri) throws Exception;

	List<PageUri> findByModelAndModelId(String model, String modelId) throws Exception;

	PageUri findById(String page_uri_id) throws Exception;
	
	public PageUri findByModelId(String model, String modelId) throws Exception;

	void deleteByModelAndModelId(String model, String articleId);

	void deleteByPageUrlIdAndForwardTo(String pageUrlId, String forwardTo);

	PageUri findByForwardTo(String forwardTo) throws Exception;
	
	void changePageUriId(String oldId, String newId) throws Exception;
	
}
