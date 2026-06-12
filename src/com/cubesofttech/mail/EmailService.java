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
    public void sendMail(String to,String subject,String body) 
    {
        SimpleMailMessage message = new SimpleMailMessage();
//        message.setFrom("test@cubesofttech.com");
        message.setFrom("chatchai.k@cubesofttech.com");
        message.setTo(to);
        message.setSubject(subject);
        message.setText(body);
        mailSender.send(message);
        
        Log.debug(message);
    }


  
}