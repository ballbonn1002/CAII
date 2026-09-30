package com.cubesofttech.dao;

import java.time.YearMonth;
import java.util.List;

import com.cubesofttech.model.TokenUsageSummary;

public interface TokenUsageSummaryDAO {
	public void save(TokenUsageSummary tokenUsageSummary);
	public void update(TokenUsageSummary tokenUsageSummary);
	public void delete(TokenUsageSummary tokenUsageSummary);
	public TokenUsageSummary findById(Integer usage_summary_id);
	public List<TokenUsageSummary> findAll();
	public TokenUsageSummary findLatestByUserId(String userId);
	public TokenUsageSummary findByUserIdAndYearMonth(String userId, YearMonth yearMonth);
}