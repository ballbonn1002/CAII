package com.cubesofttech.dao;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import com.cubesofttech.model.Holiday;
public interface HolidayDAO {

	
	public Holiday findById(long id_date) throws Exception;
	public List<Holiday> findAll() throws Exception;
	public List<Holiday> findMonth() throws Exception;
	public List<Holiday> findAllHoliday() throws Exception;
	public void save(Holiday holiday) throws Exception;
	public void update(Holiday holiday) throws Exception;
	public void delete(Holiday holiday) throws Exception;
	public List<Holiday> searchBycolumn(String column,String keyword) throws Exception;
	
	public List<Map<String, Object>> findByDate(java.sql.Date keyword) throws Exception;
	public List<Map<String, Object>> findByDateStr(String keyword) throws Exception;
	public List<Holiday> findByMonth(String keyword) throws Exception; 
	public  List<Holiday> searchtable(String date) throws Exception;
	public List<Object> searchallyear() throws Exception;
	public List<Holiday> protect(Holiday holiday) throws Exception;
	List<Holiday> protect_edit(Holiday holiday) throws Exception;
	public List<Map<String, Object>> findAll1() throws Exception;
	Long getMaxId() throws Exception;

	List<Holiday> findByYear(Integer year) throws Exception;

	public List<Holiday> findAllInMonth() throws Exception;

//	public List<Map<String, Object>> findByDate(java.sql.Date keyword) throws Exception; //ÃƒÂ Ã‚Â¸Ã¢â‚¬Å¾ÃƒÂ Ã‚Â¹Ã¢â‚¬Â°ÃƒÂ Ã‚Â¸Ã¢â€žÂ¢ÃƒÂ Ã‚Â¸Ã‚Â«ÃƒÂ Ã‚Â¸Ã‚Â²ÃƒÂ Ã‚Â¸Ã‚Â§ÃƒÂ Ã‚Â¸Ã‚Â±ÃƒÂ Ã‚Â¸Ã¢â€žÂ¢ÃƒÂ Ã‚Â¸Ã¢â‚¬â€�ÃƒÂ Ã‚Â¸Ã‚ÂµÃƒÂ Ã‚Â¹Ã‹â€ 
//	public List<Map<String, Object>> findByDateStr(String keyword) throws Exception;
//	public List<Holiday> findByMonth(String keyword) throws Exception; //ÃƒÂ Ã‚Â¸Ã¢â‚¬Å¾ÃƒÂ Ã‚Â¹Ã¢â‚¬Â°ÃƒÂ Ã‚Â¸Ã¢â€žÂ¢ÃƒÂ Ã‚Â¸Ã‚Â«ÃƒÂ Ã‚Â¸Ã‚Â²ÃƒÂ Ã‚Â¹Ã¢â€šÂ¬ÃƒÂ Ã‚Â¸Ã¢â‚¬ï¿½ÃƒÂ Ã‚Â¸Ã‚Â·ÃƒÂ Ã‚Â¸Ã‚Â­ÃƒÂ Ã‚Â¸Ã¢â€žÂ¢
//	public  List<Holiday> searchtable(String date) throws Exception;
//	public List<Object> searchallyear() throws Exception;
//	public List<Holiday> protect(Holiday holiday) throws Exception;// ÃƒÂ Ã‚Â¸Ã¢â‚¬ÂºÃƒÂ Ã‚Â¹Ã¢â‚¬Â°ÃƒÂ Ã‚Â¸Ã‚Â­ÃƒÂ Ã‚Â¸Ã¢â‚¬Â¡ÃƒÂ Ã‚Â¸Ã¯Â¿Â½ÃƒÂ Ã‚Â¸Ã‚Â±ÃƒÂ Ã‚Â¸Ã¢â€žÂ¢ ÃƒÂ Ã‚Â¸Ã¯Â¿Â½ÃƒÂ Ã‚Â¸Ã‚Â²ÃƒÂ Ã‚Â¸Ã‚Â£ÃƒÂ Ã‚Â¹Ã¯Â¿Â½ÃƒÂ Ã‚Â¸Ã¢â‚¬â€�ÃƒÂ Ã‚Â¸Ã‚Â£ÃƒÂ Ã‚Â¸Ã¯Â¿Â½ÃƒÂ Ã‚Â¸Ã‚Â§ÃƒÂ Ã‚Â¸Ã‚Â±ÃƒÂ Ã‚Â¸Ã¢â€žÂ¢ÃƒÂ Ã‚Â¸Ã‚Â«ÃƒÂ Ã‚Â¸Ã‚Â¢ÃƒÂ Ã‚Â¸Ã‚Â¸ÃƒÂ Ã‚Â¸Ã¢â‚¬ï¿½
//	List<Holiday> protect_edit(Holiday holiday) throws Exception;
//	List<Holiday> protect_edit1(Holiday holiday) throws Exception;
//	public List<Holiday> findnext_Year(String keyword) throws Exception;
//	public List<Map<String, Object>> findAll1() throws Exception;
//	Long getMaxId() throws Exception;
//	public List<Holiday> getall();
	public String getallOnlyDateJSON();
//	public List<Map<String, Object>>test_holiday(int year);
//	public List<Map<String, Object>>findHolidayMonth(String month,String year) throws Exception;
//	
//	public List<Map<String, Object>> count_hoilday(String start_mouth, String today) throws Exception;
//	public List<Map<String, Object>> countHoildayByDatepicker(Timestamp startdate, Timestamp enddate) throws Exception;
//	public List<Map<String, Object>> listHoildayByDatepicker(Timestamp startdate, Timestamp enddate) throws Exception;
	List<Holiday> findAll2years() throws Exception;
	
}

