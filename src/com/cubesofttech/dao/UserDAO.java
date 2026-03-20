package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import com.cubesofttech.model.User;

public interface UserDAO {

	public void save(User user) throws Exception;

	public List<User> findAll() throws Exception;
	
	public User findById(String id) throws Exception;

//	/*
//	 * public static User findByRoleId(String roleId) throws Exception { // TODO
//	 * Auto-generated method stub return null; }
//	 */
	public String resetLastyearQuota();

	public List<Map<String, Object>> findById2(String id) throws Exception;

	public void update(User user) throws Exception;

	public void delete(User user) throws Exception;

	public List<User> findBySelect(String usertoappr) throws Exception;

	public List<Map<String, Object>> allName() throws Exception;

	public List<Map<String, Object>> sequense() throws Exception;

	public List<Map<String, Object>> sequense_userinteam(String manager) throws Exception;

	public List<Map<String, Object>> Query_Userlist() throws Exception;

	public List<Map<String, Object>> findById3(String ur) throws Exception;

	public String userListJSON();

	public List<Map<String, Object>> UserEnable(String enable);
	
	List<Map<String, Object>> findRoleNameById(String id);

	public List<Map<String, Object>> test_birthdaysummary() throws Exception;

	public List<Map<String, Object>> Query_Userlist2() throws Exception;

	public List<Map<String, Object>> getGender(String[] setgender) throws Exception;

	public List<Map<String, Object>> updateGender(String[] setgender) throws Exception;

	public List<Map<String, Object>> findTimeUserWork(String user) throws Exception;
	
	public List<Map<String, Object>> getManagerIdAndManagerNameByUserId(String reqUserId) throws Exception;
	
    List<Map<String, Object>> findUsersByEmail(String email) throws Exception;
    Map<String, Object> findUserById(String id) throws Exception;
    
    String findEmployeeIdByName(String nameEn, String nameTh) throws Exception;

	List<Map<String, Object>> sequense2() throws Exception;

	List<Map<String, Object>> findUserActive() throws Exception;

}
