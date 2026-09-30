package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import com.cubesofttech.model.TokenMonthlyLogDetail;

public interface TokenMonthlyLogDetailDAO {
	public void save(TokenMonthlyLogDetail detail) throws Exception;
	public void update(TokenMonthlyLogDetail detail) throws Exception;
	public void delete(TokenMonthlyLogDetail detail) throws Exception;
	public TokenMonthlyLogDetail findById(Integer tokenLogId) throws Exception;
	public List<TokenMonthlyLogDetail> findAll() throws Exception;
	public List<Map<String, Object>> findByMonitorLogId(Integer monitorLogId) throws Exception;
	public List<TokenMonthlyLogDetail> findFailedByMonitorLogId(Integer monitorLogId) throws Exception;
}
