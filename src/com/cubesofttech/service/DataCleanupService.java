package com.cubesofttech.service;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cubesofttech.dao.LogActionDAO;

@Service
public class DataCleanupService {
	
	private static final Logger log = Logger.getLogger(DataCleanupService.class);
	
	@Autowired
	LogActionDAO logActionDAO;
	
	@Transactional
    @Scheduled(cron = "0 0 2 * * ?")
    public void deleteOldLogs() {
        try {
        	log.info("Initialized DataCleanup LogData...");
			logActionDAO.delete2YearLogs();
			log.info("Success DataCleanup LogData...");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
}
