package com.cubesofttech.dao;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.cubesofttech.model.Leaves;
import com.cubesofttech.model.Timesheet;


public interface TimesheetDAO {
    public void save(Timesheet timesheet) throws Exception;
    public List<Map<String, Object>> sequense() throws Exception;
    public List<Timesheet> findAll() throws Exception;
    Integer getMaxId() throws Exception;
    public void update(Timesheet timesheet) throws Exception;
    public void delete(Timesheet timesheet) throws Exception;
    public Timesheet findById(Integer id) throws Exception;
    public List<Timesheet> findTimesheetById(int id) throws Exception;
	public List<Map<String, Object>> findTimeInTimeOutBytimeMonthYear( String user,String startDay,String endDay ) throws Exception;
	public List<Map<String, Object>> findDescription( String user,String startDay,String endDay) throws Exception;
	public List<Map<String, Object>> searchIdTimesheet( String id) throws Exception;
	public List<Map<String, Object>> searchTimesheet( String user,String date) throws Exception;
	public List<Map<String, Object>> searchTimesheetByUserCreate( String userId) throws Exception;
	public List<Map<String, Object>> searchTimesheetByTimeUpdate( String userId) throws Exception;
	public List<Map<String, Object>> timesheetSearch_forCalendar(String userId, String from, String to) throws Exception;
	public List<Timesheet> findAll_calendar() throws Exception;
	//public List<Map<String, Object>> checkholiday() throws Exception ;
	List<Map<String, Object>> findHoliday() throws Exception;
	List<Map<String, Object>> findHoliday2() throws Exception;
	public List<Map<String, Object>> listtimesheet(String userid, java.sql.Timestamp Datenow, java.sql.Timestamp DateBefore  ,String month, String year) throws Exception;
	public List<Map<String, Object>> listtimesheet1(String userid, java.sql.Timestamp Datenow, java.sql.Timestamp DateBefore  ,String month, String year) throws Exception;
	public List<Map<String, Object>> listtimesheet2(String userid, String dateStartSearch, String dateEndSearch) throws Exception;
	public List<Map<String, Object>> timesheetapproved(String timesheetid, String status) throws Exception;
	public Timesheet latestTimesheet(String id);
	public boolean checkExistUserDate(String user, String date);
	public List<Map<String, Object>> listot(String userid, java.sql.Timestamp Datenow, java.sql.Timestamp DateBefore  ,String month, String year) throws Exception;
	public List<Map<String, Object>> listot2(String userid, String dateStartSearch, String dateEndSearch) throws Exception;
	public List<Map<String, Object>> reportProject(String month, String year);
	public List<Map<String, Object>> searchProjectReport(String project,String name,String month,String year);
	public List<Map<String, Object>> projectname() throws Exception;
	public List<Map<String, Object>> finduserWork(String logonUser,String monthnow,String yearnow);
	public List<Map<String, Object>> finduserWorkCheckOut(String logonUser,String monthnow,String yearnow);
	public List<Map<String, Object>> finduserWorkProject(String logonUser,String monthnow,String yearnow);
	public List<Map<String, Object>> approveall(String name,String year,String month);
	public List<Map<String, Object>> findcurrent(String logonUser,String monthnow,String yearnow);
	public List<Map<String, Object>> getdate(String monthnow,String yearnow);
	
	public List<Map<String, Object>> wherename(String name);
	public List<Map<String, Object>> whereproject(String name);
	public List<Map<String, Object>> wherefile();
	public List<Map<String, Object>> whereworkhour(String year,String month,String day,String name);
	public List<Map<String, Object>> wherefunction(String name);
	
	public List<Map<String, Object>> searchbymonth(String userid, String month, String year) throws Exception;

	List<Timesheet> findByProjectId(Integer project_id) throws Exception;
}
   