package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import com.cubesofttech.model.ExpenseGroup;

public interface ExpenseGroupDAO {

	public void save(ExpenseGroup expenseGroup) throws Exception;

	public List<ExpenseGroup> findAll() throws Exception;

	public ExpenseGroup findById(Long expenseGroupId) throws Exception;

	public void update(ExpenseGroup expenseGroup) throws Exception;

	public void delete(ExpenseGroup expenseGroup) throws Exception;

	public Long getMaxId() throws Exception;

	public int updateStatus(Long expenseGroupId, String fromStatus, String toStatus, String userUpdate)
			throws Exception;

	public Map<String, Object> findGroupHeaderForModal(Long expenseGroupId) throws Exception;

	public ExpenseGroup findByUserMonthYearAndStatus(String userId, String expTypeId, Short month, Integer year,
			String statusId) throws Exception;

	public int countMyGroupsByStatus(String status, String userId, java.sql.Date dateFrom, java.sql.Date dateTo)
			throws Exception;

	public List<Map<String, Object>> findMyGroupsByStatus(String status, String userId, java.sql.Date dateFrom,
			java.sql.Date dateTo, int offset, int pageSize) throws Exception;
}