package com.cubesofttech.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cubesofttech.dao.LogActionDAO;
import com.cubesofttech.model.LogAction;
import com.cubesofttech.util.DateUtil;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Service
public class LogService {

	private static Logger log = Logger.getLogger(LogService.class);
	
	@Autowired
	private LogActionDAO logActionDAO;
	
	public void updateRequestLog(String uri, String method, String status, String ex, String date, String logonUser) {
		try {
			List<Map<String, Object>> logActionList = logActionDAO.findByUserAndDate(logonUser, date);
			JsonArray dataNew = new JsonArray();
			JsonObject obj = new JsonObject();
			obj.addProperty("requestURI", uri);
			obj.addProperty("method", method);
			obj.addProperty("status", status);
			obj.addProperty("description", ex);
			obj.addProperty("time", DateUtil.getCurrentTime().toString());
			dataNew.add(obj);
			
			if(logActionList.isEmpty()) {
				LogAction logNew = new LogAction();
				Integer maxId = logActionDAO.getMaxId();
	        	logNew.setLogActionId(maxId + 1);
	        	logNew.setLogData(String.valueOf(dataNew));
	        	logNew.setUser_create(logonUser);
	        	logNew.setUser_update(logonUser);
	        	logNew.setTime_create(DateUtil.getCurrentTime());
	        	logNew.setTime_update(DateUtil.getCurrentTime());
	        	logActionDAO.save(logNew);
			} else {
				JsonParser parser = new JsonParser();
				JsonArray dataUpdate = parser.parse(String.valueOf(logActionList.get(0).get("log_data"))).getAsJsonArray();
				dataUpdate.add(obj);
				LogAction logUpdate = logActionDAO.findById(Integer.parseInt(logActionList.get(0).get("log_action_id").toString()));
				logUpdate.setLogData(String.valueOf(dataUpdate));
				logUpdate.setUser_update(logonUser);
				logUpdate.setTime_update(DateUtil.getCurrentTime());
				logActionDAO.update(logUpdate);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
