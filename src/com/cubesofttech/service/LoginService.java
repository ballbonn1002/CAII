package com.cubesofttech.service;

import java.security.NoSuchAlgorithmException;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.cubesofttech.dao.RoleAuthorizedObjectDAO;
import com.cubesofttech.model.RoleAuthorizedObject;
import com.cubesofttech.model.User;
import com.cubesofttech.model.UserRole;
import com.cubesofttech.system.Constant;
import com.cubesofttech.util.MD5;

@Service
public class LoginService {

	private static final Logger log = Logger.getLogger(LoginService.class);

	@Autowired
	private RoleAuthorizedObjectDAO roleAuthorizedObjectDAO;
	
	@Autowired
	private JavaMailSender mailSender;

	/**
	 * ตั้งเวลา session timeout ตามสิทธิ์ของ user ที่เพิ่งล็อกอิน
	 * ถ้า role ใน user.role_id มีสิทธิ์ Constant.AUTH_SESSION_TIMEOUT_EXTENDED ในตาราง role_authorized_object
	 * จะได้ Constant.EXTENDED_SESSION_TIMEOUT_MINUTES นาที, ไม่มีสิทธิ์ใช้ค่า default จาก web.xml
	 * ไม่นับตาราง user_role (และไม่ใช้ session "userAuthority" ที่รวม user_role ไว้แล้ว)
	 * เรียกหลัง session.setAttribute("onlineUser", user)
	 *
	 * @param roleAuthorizedObjectList สิทธิ์ของ user.role_id ที่ query ไว้แล้ว (login ปกติส่งมา);
	 *                                 ถ้าเป็น null จะ query เองด้วย user.role_id (เช่นตอน login ผ่าน LINE)
	 * ถ้า query ล้มเหลวจะ log error แล้วใช้ค่า default ไม่ทำให้ login พัง
	 */
	public void applySessionTimeout(HttpSession session, User user,
			List<RoleAuthorizedObject> roleAuthorizedObjectList) {
		if (session == null || user == null) {
			return;
		}
		try {
			List<RoleAuthorizedObject> list = roleAuthorizedObjectList;
			if (list == null) {
				String roleId = user.getRoleId();
				if (roleId == null || roleId.trim().isEmpty()) {
					return;
				}
				list = roleAuthorizedObjectDAO.findByRoleId(roleId);
			}
			if (list == null) {
				return;
			}
			for (RoleAuthorizedObject rao : list) {
				if (rao == null || rao.getAuthorizedObjectId() == null) {
					continue;
				}
				if (Constant.AUTH_SESSION_TIMEOUT_EXTENDED.equals(rao.getAuthorizedObjectId().trim())) {
					// setMaxInactiveInterval รับหน่วยวินาที
					session.setMaxInactiveInterval(Constant.EXTENDED_SESSION_TIMEOUT_MINUTES * 60);
					log.info("set session timeout user=" + user.getId() + " minutes=" + Constant.EXTENDED_SESSION_TIMEOUT_MINUTES);
					return;
				}
			}
		} catch (Exception e) {
			// ใช้ค่า default (30 นาที) ต่อไป ห้ามทำให้ login พัง
			log.error("apply session timeout failed user=" + user.getId(), e);
		}
	}

	public String generateMD5(String password) throws NoSuchAlgorithmException {
		return MD5.getInstance().hashData(password.getBytes());
	}

	public Set<String> addRoleByUserTable(List<RoleAuthorizedObject> roleAuthorizedObjectList,
			Set<String> userAuthority) {
		if (roleAuthorizedObjectList != null) {
			Iterator<RoleAuthorizedObject> it = roleAuthorizedObjectList.iterator();
			while (it.hasNext()) {
				RoleAuthorizedObject rao = it.next();
				userAuthority.add(rao.getAuthorizedObjectId());
			}
		}
		return userAuthority;
	}

	public Set<String> addRoleByUserRoleTabel(List<UserRole> userRoleList, Set<String> userAuthority) throws Exception {
		if (userRoleList != null) {
			List<RoleAuthorizedObject> roleAuthorizedObjectList;
			Iterator<UserRole> it = userRoleList.iterator();
			while (it.hasNext()) {
				UserRole userRole = it.next();
				roleAuthorizedObjectList = roleAuthorizedObjectDAO.findByRoleId(userRole.getRoleId());
				if (roleAuthorizedObjectList != null) {
					Iterator<RoleAuthorizedObject> it2 = roleAuthorizedObjectList.iterator();
					while (it2.hasNext()) {
						RoleAuthorizedObject rao = it2.next();
						userAuthority.add(rao.getAuthorizedObjectId());
					}
				}
			}
		}
		return userAuthority;
	}
	
    public boolean sendmail2(String from, String to, String subject, String body) {
        try {
            // validate parameter
            if (from == null || from.trim().isEmpty()) {
                throw new IllegalArgumentException("Sender email must not be empty");
            }
            if (to == null || to.trim().isEmpty()) {
                throw new IllegalArgumentException("Recipient email must not be empty");
            }
            if (subject == null || subject.trim().isEmpty()) {
                throw new IllegalArgumentException("Subject must not be empty");
            }
            if (body == null || body.trim().isEmpty()) {
                throw new IllegalArgumentException("Body must not be empty");
            }

		 // Create message
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom(from);
            message.setTo(to);
            message.setSubject(subject);
            message.setText(body);

         // Send email
            mailSender.send(message);

            return true; // Send success
        } catch (Exception e) {
            // log error
            System.err.println("Error sending email: " + e.getMessage());
            e.printStackTrace();
            return false; // Send failed
        }
    }

	public void sendmail(String key, String emails){
		
		SimpleMailMessage message = new SimpleMailMessage();
		message.setFrom("no-reply@cubesofttech.com");
		message.setTo(emails);
		message.setSubject("Password Reset");
		message.setText("Hello,\r\n"
				+ " \r\n"
				+ "You recently requested to reset your password. Click on the link below to change your password.\r\n"
				+ " \r\n"
				+ Constant.getWebContext() +"/resetpassword.jsp?token=" + key + "\r\n"
				+ " \r\n"
				+ "If you did not make the request to reset your password or if you are in need of further assistance, please contact our HR Team.\r\n"
				+ " \r\n"
				+ "Thanks!");
		mailSender.send(message);
	}

}
