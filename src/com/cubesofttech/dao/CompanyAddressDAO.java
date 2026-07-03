package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import com.cubesofttech.model.CompanyAddress;

public interface CompanyAddressDAO {
	public CompanyAddress findById(Long id) throws Exception;
	public List<Map<String, Object>> findByCompanyId(Long companyId) throws Exception;
	public List<Map<String, Object>> findAll() throws Exception;
	public void save(CompanyAddress address) throws Exception;
	public void update(CompanyAddress address) throws Exception;
	public void delete(CompanyAddress address) throws Exception;
}
