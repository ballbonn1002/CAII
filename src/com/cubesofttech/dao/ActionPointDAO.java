package com.cubesofttech.dao;

import java.util.List;

import com.cubesofttech.model.ActionPoint;

public interface ActionPointDAO {
	public ActionPoint findById(Integer actionPointId) throws Exception;
	public List<ActionPoint> findByActionTypeId(Integer actionTypeId) throws Exception;
	public List<ActionPoint> findByActionTypeIdAndActiveStatus(Integer actionTypeId, String status) throws Exception;
	public List<ActionPoint> findAll() throws Exception;
	public void update(ActionPoint actionPoint) throws Exception;
	public void delete(ActionPoint actionPoint) throws Exception;
	public void save(ActionPoint actionPoint) throws Exception;
}
