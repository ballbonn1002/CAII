package com.cubesofttech.service;

import org.springframework.stereotype.Service;

@Service
public class LeaveService {
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
}
