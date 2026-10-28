package com.cubesofttech.dao;

import java.util.List;

import com.cubesofttech.model.TokenMonthlyLog;

public interface TokenMonthlyLogDAO {
	public void save(TokenMonthlyLog log) throws Exception;
	public void update(TokenMonthlyLog log) throws Exception;
	public void delete(TokenMonthlyLog log) throws Exception;
	public List<TokenMonthlyLog> findByYear(int year) throws Exception;
	public TokenMonthlyLog findById(Integer monitorLogId) throws Exception;
	public List<TokenMonthlyLog> findAll() throws Exception;
}
