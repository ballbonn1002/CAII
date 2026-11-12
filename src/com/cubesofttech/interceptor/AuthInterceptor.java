package com.cubesofttech.interceptor;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
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

	/** session attribute เก็บหน้าที่ผู้ใช้ตั้งใจจะเปิดก่อนถูกส่งไป login (LoginAction.loginBack พากลับ) */
	public static final String ATTR_RETURN_TO = "loginReturnTo";
	public static final String ATTR_RETURN_TIME = "loginReturnTime";

	/**
	 * action ที่ยอมให้จำไว้แล้วพากลับหลัง login (เพิ่มชื่อได้ถ้าหน้าอื่นต้องการแบบเดียวกัน)
	 * จำกัดไว้เพราะบางหน้าเป็น AJAX/ลบ/บันทึก ไม่ควรถูกเปิดซ้ำหลัง login
	 */
	private static final Set<String> RETURN_AFTER_LOGIN = new HashSet<String>(Arrays.asList("qr"));

	@Override
	public String intercept(ActionInvocation invocation) throws Exception {
		String actionName = invocation.getProxy().getActionName();

	    if ("line_lineWebhook".equalsIgnoreCase(actionName) || "line_checkAccount".equalsIgnoreCase(actionName) || "line_lineLiffLogin".equalsIgnoreCase(actionName)) {
	        return invocation.invoke();
	    }
	    
		HttpSession session = ServletActionContext.getRequest().getSession(false);
		User onlineUser = (session != null) ? (User) session.getAttribute("onlineUser") : null;

		if (onlineUser == null) {
			log.warn("Blocked unauthenticated access to " + actionName);
			rememberReturnPage(actionName);
			return ActionSupport.LOGIN;
		}

		return invocation.invoke();
	}

	/** จำหน้าที่ถูกบล็อก (เฉพาะ GET ของ action ใน RETURN_AFTER_LOGIN) ไว้ใน session เพื่อพากลับหลัง login */
	private void rememberReturnPage(String actionName) {
		if (!RETURN_AFTER_LOGIN.contains(actionName)) {
			return;
		}
		HttpServletRequest request = ServletActionContext.getRequest();
		if (request == null || !"GET".equalsIgnoreCase(request.getMethod())) {
			return;
		}
		// สร้างเฉพาะ path ที่ระบบรู้จักเอง (ชื่อ action + query string) ไม่รับค่าปลายทางจากผู้ใช้ จึงไม่เปิดช่อง redirect ออกนอกเว็บ
		String path = actionName;
		String query = request.getQueryString();
		if (query != null && !query.isEmpty()) {
			path = path + "?" + query;
		}
		HttpSession session = request.getSession(true);
		session.setAttribute(ATTR_RETURN_TO, path);
		session.setAttribute(ATTR_RETURN_TIME, Long.valueOf(System.currentTimeMillis()));
	}
}
