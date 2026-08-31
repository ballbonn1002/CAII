package com.cubesofttech.dao;

import java.util.List;

import com.cubesofttech.model.ActionType;

public interface ActionTypeDAO {
	public void save(ActionType actionType) throws Exception;
	public void update(ActionType actionType) throws Exception;
	public void delete(ActionType actionType) throws Exception;
	public ActionType findById(Integer actionTypeId) throws Exception;
	public List<ActionType> findAll() throws Exception;
	public List<ActionType> findByActiveStatus (String status) throws Exception;
}
