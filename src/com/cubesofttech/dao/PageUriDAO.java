package com.cubesofttech.dao;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import com.cubesofttech.model.PageUri;

public interface PageUriDAO {

	List<PageUri> findAll() throws Exception;

	void save(PageUri PageUri) throws Exception;

	void update(PageUri PageUri) throws Exception;

	PageUri findByModelAndModelId(String model, String modelId) throws Exception;

	PageUri findBymodelId(String modelId) throws Exception;

	void deleteByModelAndModelId(String model, String articleId);

	PageUri findByPageUri(String pageUriId) throws Exception;

	void deleteByPageUrlIdAndForwardTo(String pageUrlId, String forwardTo);

	
	
}
