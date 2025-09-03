package com.cubesofttech.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

public class NewsAction extends ActionSupport {

	private static final long serialVersionUID = 2280661337420278284L;
	private static final Integer Interger = null;

	Logger log = Logger.getLogger(getClass());
	HttpServletRequest request = ServletActionContext.getRequest();
	HttpServletResponse response = ServletActionContext.getResponse();

	public String demoDashboard() throws Exception {
		try {
			log.debug("demo");
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
		
		
	}
}
