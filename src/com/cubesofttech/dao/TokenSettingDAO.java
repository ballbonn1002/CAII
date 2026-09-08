package com.cubesofttech.dao;

import java.util.List;

import com.cubesofttech.model.TokenSetting;

public interface TokenSettingDAO {
	public void save(TokenSetting setting) throws Exception;
	public void update(TokenSetting setting) throws Exception;
	public void delete(TokenSetting setting) throws Exception;
	public TokenSetting findById(Integer settingId) throws Exception;
	public List<TokenSetting> findAll() throws Exception;
	public TokenSetting findByType(String tokenType) throws Exception;
	public TokenSetting findByTypeAndTypeName(String type, String typeName) throws Exception;
}
