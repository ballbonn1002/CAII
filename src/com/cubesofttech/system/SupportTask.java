package com.cubesofttech.system;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.cubesofttech.dao.SupportDAO;

@Component
public class SupportTask {

    private static final Logger log = Logger.getLogger(SupportTask.class);

    @Autowired
    private SupportDAO supportDAO;

    /**
     * ทำงานทุกวัน เวลา 01:00 น.
     * เพื่อเปลี่ยนสถานะรายการที่ Resolved มานานกว่า 5 วัน ให้เป็น Closed
     */
    @Scheduled(cron = "0 0 1 * * ?")
    @Transactional
    public void autoCloseSupport() {
        try {
            log.info("SupportTask: Starting autoCloseSupport...");
            supportDAO.autoCloseResolved();
            log.info("SupportTask: autoCloseSupport completed successfully.");
        } catch (Exception e) {
            log.error("SupportTask Error: " + e.getMessage(), e);
        }
    }
}
