package com.cubesofttech.dao;

import java.util.List;

import com.cubesofttech.model.UserFavorite;

public interface UserFavoriteDAO {
	public void save(UserFavorite userFavorite) throws Exception;
	public void update(UserFavorite userFavorite) throws Exception;
	public void delete(UserFavorite userFavorite) throws Exception;
	public UserFavorite findById(Integer userFavoriteId) throws Exception;
	UserFavorite findByUserIdAndItemId(String userId, Integer itemId) throws Exception;
	public List<UserFavorite> findAll() throws Exception;
}
