package com.cubesofttech.interceptor;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import com.cubesofttech.model.User;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

public class AuthInterceptor extends AbstractInterceptor {
	private static final long serialVersionUID = 1L;
	private static final Logger log = Logger.getLogger(AuthInterceptor.class);

	@Override
	public String intercept(ActionInvocation invocation) throws Exception {
		HttpSession session = ServletActionContext.getRequest().getSession(false);
		User onlineUser = (session != null) ? (User) session.getAttribute("onlineUser") : null;

		if (onlineUser == null) {
			log.warn("Blocked unauthenticated access to " + invocation.getProxy().getActionName());
			return ActionSupport.LOGIN;
		}

		return invocation.invoke();
	}
}
