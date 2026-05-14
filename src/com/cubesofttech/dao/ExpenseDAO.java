package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import com.cubesofttech.model.Expense;

public interface ExpenseDAO {

	public void save(Expense expense) throws Exception;

	public List<Expense> findAll() throws Exception;

	public Expense findById(Long expenseId) throws Exception;

	public void update(Expense expense) throws Exception;

	public void delete(Expense expense) throws Exception;

	public Long getMaxId() throws Exception;

	public List<Expense> findByGroupId(Long expenseGroupId) throws Exception;

	public List<Expense> findByUserId(String userId) throws Exception;

	public List<Expense> findByExpTypeId(String expTypeId) throws Exception;

	public List<Map<String, Object>> findMyTravelListByStatus(String statusId, String userId, java.sql.Date dateFrom,
			java.sql.Date dateTo, int offset, int limit) throws Exception;

	public int countMyTravelListByStatus(String statusId, String userId, java.sql.Date dateFrom, java.sql.Date dateTo)
			throws Exception;

	public int updateGroupStatusToWaiting(List<Long> groupIds, String userUpdate) throws Exception;

	public int updateGroupStatusToWaitingByExpenseIds(List<Long> expenseIds, String userUpdate) throws Exception;

	public Map<String, Object> getTravelModalData(Long expenseGroupId) throws Exception;

	public Map<String, Object> getTravelExpenseModalData(Long expenseId) throws Exception;

	public List<Map<String, Object>> findSubmitPreviewByExpenseIds(List<Long> expenseIds) throws Exception;

	public int countMyTravelDraftNoGroup(String userId, java.sql.Date dateFrom, java.sql.Date dateTo) throws Exception;
	
	public Map<String, Integer> countMyTravelListAllStatus(String userId, java.sql.Date dateFrom, java.sql.Date dateTo)
			throws Exception;

	public List<Map<String, Object>> findMyTravelDraftNoGroup(String userId, java.sql.Date dateFrom,
			java.sql.Date dateTo, int offset, int limit) throws Exception;
}