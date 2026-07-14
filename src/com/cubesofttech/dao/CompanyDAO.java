package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import com.cubesofttech.model.Company;

public interface CompanyDAO {
	public Company findById(Long id) throws Exception;
	public List<Map<String, Object>> findAll() throws Exception;
	public void save(Company company) throws Exception;
	public void update(Company company) throws Exception;
	public void delete(Company company) throws Exception;
	public boolean existsCompanyCode(String companyCode, Long companyId) throws Exception;
}
