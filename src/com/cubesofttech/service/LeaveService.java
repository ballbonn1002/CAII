package com.cubesofttech.service;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.jfree.util.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cubesofttech.dao.LeaveDAO;
import com.cubesofttech.dao.UserDAO;
import com.cubesofttech.model.User;

@Service
public class LeaveService {
	Logger log = Logger.getLogger(getClass());
	public static final String TYPELEAVE = "leave_type_id";
	public static final String NODAY = "no_day";
	public static final String STATUS = "leave_status_id";
	@Autowired
	private LeaveDAO leaveDAO;
	@Autowired
	private UserDAO userDAO;
	
	public String mapLeaveTypeToStatus(String typeId) {
		if (typeId == null) {
            return "UNKNOWN";
        }
		switch (typeId) {
	        case "1": return "ANNUAL_LEAVE";
	        case "2": return "BUSINESS_LEAVE";
	        case "3": return "SICK_LEAVE";
	        case "4": return "ABSENT";
	        case "5": return "WITHOUT_PAY";
	        case "6": return "ANNUAL_LEAVE_REMAINING";
	        case "7": return "OTHER_LEAVE";
	        case "9": return "OTHERS";
	        default: return "UNKNOWN";
	    }
	}
	
	public Map<String, Object> getSummaryLeaveDashboard(String type, String userId, String userLogin, String status, Timestamp startdate, Timestamp enddate, String leaveType) throws Exception {
		log.info(type+"/"+userId+"/"+userLogin+"/"+status+"/"+startdate+"/"+enddate+"/"+leaveType);
		Map<String, Object> resultData = new HashMap<>();
		List<Map<String, Object>> userleave = new ArrayList<>();
		userleave = leaveDAO.getSummaryLeave(type, userId, userLogin, status, startdate, enddate, leaveType);
		resultData.put("userleave", userleave);
		BigDecimal quota_1 = null;
		BigDecimal quota_2 = null;
		BigDecimal quota_3 = null;
		BigDecimal quota_4 = null;
		if(userId != null && !userId.isEmpty()) {
			User user = userDAO.findById(userId);
			quota_1 = user.getLeaveQuota1();
			quota_2 = user.getLeaveQuota2();
			quota_3 = user.getLeaveQuota3();
			quota_4 = user.getLeaveQuota4();
		}
		resultData.put("quota_1", quota_1);
		resultData.put("quota_2", quota_2);
		resultData.put("quota_3", quota_3);
		resultData.put("quota_4", quota_4);
		
		BigDecimal LeavenumT1 = new BigDecimal(0);
		BigDecimal LeavenumT2 = new BigDecimal(0);
		BigDecimal LeavenumT3 = new BigDecimal(0);
		BigDecimal LeavenumT4 = new BigDecimal(0);
		BigDecimal LeavenumT5 = new BigDecimal(0);
		BigDecimal LeavenumT6 = new BigDecimal(0);
		BigDecimal LeavenumT7 = new BigDecimal(0);
		BigDecimal LeavenumT9 = new BigDecimal(0);
		BigDecimal LeaveWAnumT1 = new BigDecimal(0);
		BigDecimal LeaveWAnumT2 = new BigDecimal(0);
		BigDecimal LeaveWAnumT3 = new BigDecimal(0);
		BigDecimal LeaveWAnumT4 = new BigDecimal(0);
		BigDecimal LeaveWAnumT5 = new BigDecimal(0);
		BigDecimal LeaveWAnumT6 = new BigDecimal(0);
		BigDecimal LeaveWAnumT7 = new BigDecimal(0);
		BigDecimal LeaveWAnumT9 = new BigDecimal(0);
		
		for (int i = 0; i < userleave.size(); i++) {
			//Character typeleave = (Character) userleave.get(i).get(TYPELEAVE);
			String typeleave = String.valueOf(userleave.get(i).get("leave_type_id"));
			BigDecimal num = (BigDecimal) userleave.get(i).get(NODAY);
			//Character statusleave = (Character) userleave.get(i).get(STATUS);
			String statusleave = String.valueOf(userleave.get(i).get("leave_status_id"));
			try {
				switch (statusleave) {
				case "0":
					switch (typeleave) {
					case "1":
						LeaveWAnumT1 = num.add(LeaveWAnumT1);
						break;
					case "2":
						LeaveWAnumT2 = num.add(LeaveWAnumT2);
						break;
					case "3":
						LeaveWAnumT3 = num.add(LeaveWAnumT3);
						break;
					case "4":
						LeaveWAnumT4 = num.add(LeaveWAnumT4);
						break;
					case "5":
						LeaveWAnumT5 = num.add(LeaveWAnumT5);
						break;
					case "6":
						LeaveWAnumT6 = num.add(LeaveWAnumT6);
						break;
					case "7":
						LeaveWAnumT7 = num.add(LeaveWAnumT7);
						break;
					case "9":
						LeaveWAnumT9 = num.add(LeaveWAnumT9);
						break;
					}
					break;
				case "1":
					switch (typeleave) {
					case "1":
						LeavenumT1 = num.add(LeavenumT1);
						break;
					case "2":
						LeavenumT2 = num.add(LeavenumT2);
						break;
					case "3":
						LeavenumT3 = num.add(LeavenumT3);
						break;
					case "4":
						LeavenumT4 = num.add(LeavenumT4);
						break;
					case "5":
						LeavenumT5 = num.add(LeavenumT5);
						break;
					case "6":
						LeavenumT6 = num.add(LeavenumT6);
						break;
					case "7":
						LeavenumT7 = num.add(LeavenumT7);
						break;
					case "9":
						LeavenumT9 = num.add(LeavenumT9);
						break;
					}
					break;
				default:
					break;
				}
			} catch (Exception e) {
				e.printStackTrace(); 
			    log.error("Error in calculating leave summary: ", e);
			}
	    }
		
		resultData.put("LeavenumT1", LeavenumT1);
	    resultData.put("LeaveWAnumT1", LeaveWAnumT1);
	    resultData.put("LeavenumT2", LeavenumT2);
	    resultData.put("LeaveWAnumT2", LeaveWAnumT2);
	    resultData.put("LeavenumT3", LeavenumT3);
	    resultData.put("LeaveWAnumT3", LeaveWAnumT3);
	    resultData.put("LeavenumT4", LeavenumT4);
	    resultData.put("LeaveWAnumT4", LeaveWAnumT4);
	    resultData.put("LeavenumT5", LeavenumT5);
	    resultData.put("LeaveWAnumT5", LeaveWAnumT5);
	    resultData.put("LeavenumT6", LeavenumT6);
	    resultData.put("LeaveWAnumT6", LeaveWAnumT6);
	    resultData.put("LeavenumT7", LeavenumT7);
	    resultData.put("LeaveWAnumT7", LeaveWAnumT7);
	    resultData.put("LeavenumT9", LeavenumT9);
	    resultData.put("LeaveWAnumT9", LeaveWAnumT9);
	    log.info("L1: "+LeavenumT1+"|"+"L2: "+LeavenumT2+"|"+"L3: "+LeavenumT3+"|"+"L4: "+LeavenumT4+"|"+"L5: "+LeavenumT5+"|"+"L6: "+LeavenumT6+"|"+"L7: "+LeavenumT7+"|"+"L9: "+LeavenumT9+"|");
	    log.info("Lwa1: "+LeaveWAnumT1+"|"+"Lwa2: "+LeaveWAnumT2+"|"+"Lwa3: "+LeaveWAnumT3+"|"+"Lwa4: "+LeaveWAnumT4+"|"+"Lwa5: "+LeaveWAnumT5+"|"+"Lwa6: "+LeaveWAnumT6+"|"+"Lwa7: "+LeaveWAnumT7+"|"+"Lwa9: "+LeaveWAnumT9+"|");
		
		return resultData;
	}
}
