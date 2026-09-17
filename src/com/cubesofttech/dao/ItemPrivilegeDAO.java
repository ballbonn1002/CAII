package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import com.cubesofttech.model.ItemPrivilege;

public interface ItemPrivilegeDAO {
	public void save(ItemPrivilege itemPrivilege) throws Exception;
	public void update(ItemPrivilege itemPrivilege) throws Exception;
	public void delete(ItemPrivilege itemPrivilege) throws Exception;
	public ItemPrivilege findById(Integer itemId) throws Exception;
	public List<ItemPrivilege> findAll() throws Exception;
	public List<Map<String, Object>> findAllWithUserFavorite(String userId) throws Exception;
}

