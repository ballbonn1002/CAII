package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import com.cubesofttech.model.Jobsite;

public interface JobsiteDAO {
	
	public void save(Jobsite jobsite) throws Exception;
	
	public void update(Jobsite jobsite) throws Exception;

	public void delete(Jobsite jobsite) throws Exception;
	
	public Jobsite findById(Integer id) throws Exception;
}
