package com.cubesofttech.mail;

import java.math.BigDecimal;
import java.sql.Timestamp;

import org.apache.log4j.Logger;
import org.jfree.util.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Service;
 
@Service("emailService")
public class EmailService 
{
    @Autowired
    private JavaMailSender mailSender;
      
	Logger log = Logger.getLogger(getClass());
	
    /**
     * This method will send compose and send the message 
     * */
    public void sendMail(String user,String leaveType,String description,String halfDay,String from,String endDate,BigDecimal noDay) 
    {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom("test@cubesofttech.com");
        message.setTo("ohoh2555@gmail.com");
        message.setSubject("test1111test");
        message.setText("user = "+user+" leaveType = "+leaveType+" description = "+description+" halfDay = "+ halfDay+" from = "+from+" to ="+ endDate+" noDay = "+noDay);
        mailSender.send(message);
        
        Log.debug(message);
    }


  
}