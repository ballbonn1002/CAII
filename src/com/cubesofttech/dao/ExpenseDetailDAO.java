package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import com.cubesofttech.model.ExpenseDetail;

public interface ExpenseDetailDAO {

    public void save(ExpenseDetail detail) throws Exception;

    public void update(ExpenseDetail detail) throws Exception;

    public void delete(ExpenseDetail detail) throws Exception;

    public ExpenseDetail findById(Long expenseDetailId) throws Exception;

    public List<ExpenseDetail> findAll() throws Exception;

    public List<ExpenseDetail> findByExpenseId(Long expenseId) throws Exception;

    public void deleteByExpenseId(Long expenseId) throws Exception;

    public Long getMaxId() throws Exception;

    public List<Map<String, Object>> findDetailsByExpenseIds(List<Long> expenseIds) throws Exception;
}