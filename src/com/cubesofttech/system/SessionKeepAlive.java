package com.cubesofttech.system;

import org.apache.log4j.Logger;

import com.opensymphony.xwork2.ActionSupport;

/**
 * ใช้ให้หน้าเว็บยิงมาเป็นระยะ เพื่อให้ session ฝั่ง server เริ่มนับเวลาใหม่
 * (ผ่าน authStack: ถ้า session หมดอายุแล้วจะถูกส่งไปหน้า login แทน)
 */
public class SessionKeepAlive extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static final Logger log = Logger.getLogger(SessionKeepAlive.class);

	private String status;

	public String ping() {
		status = "ok";
		log.debug("session keep-alive");
		return SUCCESS;
	}

	public String getStatus() {
		return status;
	}
}
