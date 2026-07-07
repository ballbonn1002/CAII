package com.cubesofttech.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.cubesofttech.system.Constant;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

@Service
public class LineMessagingService {

	private static Logger log = Logger.getLogger(LineMessagingService.class);
	
    private final String CHANNEL_ACCESS_TOKEN = Constant.getLineChannel_access_token();
    private final String REPLY_API_URL = "https://api.line.me/v2/bot/message/reply";

    public void replyTextMessage(String replyToken, String textToSend) {
        RestTemplate restTemplate = new RestTemplate();

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("Authorization", "Bearer " + CHANNEL_ACCESS_TOKEN);

        Map<String, Object> body = new HashMap<>();
        body.put("replyToken", replyToken);

        // Create Message in List (LINE supports a maximum replyTextMessage for 5 text)
        List<Map<String, String>> messages = new ArrayList<>();
        Map<String, String> message = new HashMap<>();
        message.put("type", "text");
        message.put("text", textToSend);
        messages.add(message);
        
        body.put("messages", messages);

        HttpEntity<Map<String, Object>> requestEntity = new HttpEntity<>(body, headers);

        try {
            ResponseEntity<String> response = restTemplate.postForEntity(REPLY_API_URL, requestEntity, String.class);
            log.debug("ReplyTextMessage Status: " + response.getStatusCode());
        } catch (Exception e) {
            System.err.println("ReplyTextMessage Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}