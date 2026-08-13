package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import com.cubesofttech.model.CompanyContact;

public interface CompanyContactDAO {
	public CompanyContact findById(Long id) throws Exception;
	public List<Map<String, Object>> findAll() throws Exception;
	public List<Map<String, Object>> findByCompanyId(Long companyId) throws Exception;
	public void save(CompanyContact contact) throws Exception;
	public void update(CompanyContact contact) throws Exception;
	public void delete(CompanyContact contact) throws Exception;
	List<Map<String, Object>> findByAddressId(Long addressId) throws Exception;
}
