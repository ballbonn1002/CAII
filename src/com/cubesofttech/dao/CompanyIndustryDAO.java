package com.cubesofttech.dao;

import java.util.List;
import com.cubesofttech.model.CompanyIndustry;

public interface CompanyIndustryDAO {
	public CompanyIndustry findById(Long id) throws Exception;
	public List<CompanyIndustry> findAll() throws Exception;
	public void save(CompanyIndustry industry) throws Exception;
	public void update(CompanyIndustry industry) throws Exception;
	public void delete(CompanyIndustry industry) throws Exception;
}
