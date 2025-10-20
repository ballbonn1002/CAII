package com.cubesofttech.dao;

import java.util.List;

import com.cubesofttech.model.RoleAuthorizedObject;

public interface RoleAuthorizedObjectDAO {

//	public void save(RoleAuthorizedObject roleAuthorizaedObject) throws Exception;
//
//	public List<RoleAuthorizedObject> findAll() throws Exception;

	public List<RoleAuthorizedObject> findByRoleId(String roleId) throws Exception;

//	public void update(RoleAuthorizedObject roleAuthorizaedObject) throws Exception;
//
//	public void delete(RoleAuthorizedObject roleAuthorizaedObject) throws Exception;
//
//	int deleteByRoleId(String roleId) throws Exception;

	public List<RoleAuthorizedObject> findLeaveViewAllByRoleId(String roleId) throws Exception;

//	public RoleAuthorizedObject findByRoleIdAndAuthorizedObjectId(String roleId, String authorizedObjectId) throws Exception;

}
