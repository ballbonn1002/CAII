package com.cubesofttech.dao;

import java.time.YearMonth;
import java.util.List;
import java.util.Map;

import com.cubesofttech.model.TokenUsage;

public interface TokenUsageDAO {
	public void save(TokenUsage usageToken) throws Exception;
	public void update(TokenUsage usageToken) throws Exception;
	public void delete(TokenUsage usageToken) throws Exception;
	public TokenUsage findById(Integer usageTokenId) throws Exception;
	public boolean existsMonthlyGift(String id, Integer actionTypeId, int monthValue, int year) throws Exception;
	public boolean existsAccumulatedToken(String userId, YearMonth yearMonth) throws Exception;
	public List<Map<String, Object>> findTokenLedgerByUserId(String userId, int year) throws Exception;
	public Double findMonthlyBalance(String userId, YearMonth previousMonth) throws Exception;
	public Double findYearlyBalance(String userId, Integer year) throws Exception;
	public Double getAccumulatedTokenBalance(String userId) throws Exception;
	public Map<String, Object> findTokenSummaryByUserId(String userId, int year) throws Exception;
	public List<Map<String,Object>> findTokenSummaryForAllUsers(int year) throws Exception;
	public List<String> findAllUserIds () throws Exception;
}
