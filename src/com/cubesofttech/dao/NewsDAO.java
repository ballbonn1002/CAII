package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import com.cubesofttech.model.News;


public interface NewsDAO {
    
    public void save(News news) throws Exception;
    
    public List<News> findAll() throws Exception;
    
    public News findById(int newId) throws Exception;
    
    public void update(News news) throws Exception;
    
    public void delete(News news) throws Exception;
    
    public List<Map<String, Object>> listnews(int moreLimit) throws Exception;
    
    public List<Map<String, Object>> dashboardNews() throws Exception;
    
    public List<Map<String, Object>> mynews(String user) throws Exception;
    
    public List<Map<String, Object>> find_filepath(int fileId) throws Exception;
    

    
    public List<Map<String, Object>> mostcometoWork() throws Exception;
    
    public List<Map<String, Object>> sumItem() throws Exception;
    
    public List<Map<String, Object>> totallyleaves(String user ,int thisyear) throws Exception;
    
    public List<Map<String, Object>> totaltravel(String user) throws Exception;
    
    public List<Map<String, Object>> obtainTravel(String user) throws Exception;
    
    Integer getMaxId() throws Exception;

	List<Map<String, Object>> sumtravelPrice(String user) throws Exception;

	List<Map<String, Object>> sumtravelPrice() throws Exception;
	
	public List<Map<String, Object>> searchUserLeave(String user, String monthnow, String yearnow) throws Exception;
	public List<Map<String, Object>> finduserLate(String logonUser,String monthnow,String yearnow,String atimeaaa) throws Exception;

	public List<Map<String, Object>> checkin(String logonUsers,String monthnow,String yearnow) throws Exception;
	public List<Map<String, Object>> checkout(String logonUsers,String monthnow,String yearnow) throws Exception;
	public List<Map<String, Object>> leves(String logonUsers,String monthnow,String yearnow) throws Exception;
	public List<Map<String, Object>> timelinesearch(String user,String month,String year) throws Exception;
	public List<Map<String, Object>> tilmelinefirstsearch(String user,String month,String year) throws Exception;
	
	public List<Map<String, Object>> lastcheck(String user) throws Exception;
	public List<Map<String, Object>> borrow(String user) throws Exception;
}
