
package com.cubesofttech.action;

import java.io.File;
import java.math.BigDecimal;
import java.security.SecureRandom;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.cubesofttech.dao.LeaveDAO;
import com.cubesofttech.dao.NewsDAO;
import com.cubesofttech.dao.RoleAuthorizedObjectDAO;
import com.cubesofttech.dao.UserDAO;
import com.cubesofttech.dao.UserRoleDAO;
import com.cubesofttech.dao.UserRpwDAO;
import com.cubesofttech.dao.WorkHoursDAO;
import com.cubesofttech.mail.EmailService;
import com.cubesofttech.model.RoleAuthorizedObject;
import com.cubesofttech.model.SsoToken;
import com.cubesofttech.model.User;
import com.cubesofttech.model.UserRole;
import com.cubesofttech.service.FileAttachmentService;
import com.cubesofttech.service.LogService;
import com.cubesofttech.service.LoginService;
import com.cubesofttech.service.TokenService;
import com.cubesofttech.system.Constant;
import com.cubesofttech.util.DateUtil;
import com.opensymphony.xwork2.ActionSupport;

public class LoginAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	Logger log = Logger.getLogger(getClass());
	HttpServletRequest request = ServletActionContext.getRequest();
	HttpServletResponse response = ServletActionContext.getResponse();

	public static final String NODAY = "no_day";
	public static final String USERIDOREMAIL = "useridOrEmail";
	
    private static final String CHAR_UPPER = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    private static final String CHAR_LOWER = "abcdefghijklmnopqrstuvwxyz";
    private static final String CHAR_DIGIT = "0123456789";
    private static final String ALL = CHAR_UPPER + CHAR_LOWER + CHAR_DIGIT;
    private static final int PASSWORD_LENGTH = 6;
    private final SecureRandom secureRandom = new SecureRandom();
    
	@Autowired
	private WorkHoursDAO workHoursDAO;

	@Autowired
	private LeaveDAO leaveDAO;

	@Autowired
	private NewsDAO newsDAO;

	@Autowired
	private UserDAO userDAO;
	
	@Autowired
	private UserRpwDAO userRpwDAO;

	@Autowired
	private RoleAuthorizedObjectDAO roleAuthorizedObjectDAO;

	@Autowired
	private UserRoleDAO userRoleDAO;

	@Autowired
	private LoginService loginService;

	@Autowired
	private TokenService tokenService;
	
	@Autowired
	private LogService logService;
	
	@Autowired 
	private EmailService emailService;

	@Autowired
	private FileAttachmentService fileAttachmentService;
	
	String username;
	String password;
	
    private String useridOrEmail;
    // output to JSON
    private boolean exists;
    private String message;
    private String userId;
    private String email;

	public String homePage() {
		try {
			log.info("homePage");
			return SUCCESS;
		} catch (Exception e) {
			log.debug(e);
			return ERROR;
		}
	}

	public String resetPasswordSuccess() {
		try {
			log.info("resetPasswordSuccess");
			return SUCCESS;
		} catch (Exception e) {
			log.debug(e);
			return ERROR;
		}
	}
	
	public String login() {
		try {
			String userlogin = request.getParameter("username");
			request.setAttribute("userlogin", userlogin);
			HttpSession session = request.getSession();

			String tokenId = request.getParameter("token");
			User user = null;
			boolean loginSuccess = false;

			// validate token
			if (tokenId != null) {
				SsoToken ssoToken = tokenService.getToken(tokenId); // validate token on db
				if (ssoToken != null && ssoToken.isValid()) {
					// set user from token
					user = userDAO.findById(ssoToken.getUserId());
					loginSuccess = true;
				}
			}

			// validate old logic
			if (!loginSuccess) {
				user = userDAO.findById(username);
				String md5Password = loginService.generateMD5(password);
				List<Map<String, Object>> userActive = userDAO.UserEnable(userlogin);

				if (user != null && md5Password.equals(user.getPassword()) && !userActive.isEmpty()) {
					loginSuccess = true;

					// create new token
					tokenId = tokenService.createToken(user.getId());

					// set token in session and cookie
					session.setAttribute("token", tokenId);
					Cookie tokenCookie = new Cookie("authToken", tokenId);
					tokenCookie.setMaxAge(60 * 15);
					response.addCookie(tokenCookie);
				}
			}

			// login success
			if (loginSuccess && user != null) {
				
				String chkLogin = "sc";
				Cookie cSuccess = new Cookie("cooksc", chkLogin);
				cSuccess.setMaxAge(60 * 15);
				response.addCookie(cSuccess);

				Set<String> userAuthority = new HashSet<>();
				Constant.onlineUserList.add(user.getId());

				List<RoleAuthorizedObject> roleAuthorizedObjectList = roleAuthorizedObjectDAO.findByRoleId(user.getRoleId());
				userAuthority = loginService.addRoleByUserTable(roleAuthorizedObjectList, userAuthority);

				List<UserRole> userRoleList = userRoleDAO.findByUserId(user.getId());
				userAuthority = loginService.addRoleByUserRoleTabel(userRoleList, userAuthority);
				
				//ดึงรูปprofileผู้ใช้
				if (user.getPath() != null) {
				    String imgPath = fileAttachmentService.getFileUrl(user.getPath());
					session.setAttribute("userImgPath", imgPath);
				}
				
				session.setAttribute("user", user);
				session.setAttribute("onlineUser", user);
				// HR ได้ session timeout นานกว่า role อื่น
				LoginService.applySessionTimeout(session, user);
				session.setAttribute("userAuthority", userAuthority);
				
				request.setAttribute("token", tokenId);
				session.setAttribute("token", tokenId);

				User ur = (User) session.getAttribute("onlineUser");
				String logonUser = ur.getId();
				
				

				request.setAttribute("sumtravel", newsDAO.sumtravelPrice());

				request.setAttribute("News", newsDAO.dashboardNews());

				request.setAttribute("Goodem", newsDAO.mostcometoWork());

				request.setAttribute("totalborrowNows", newsDAO.sumItem());

				request.setAttribute("myobtainMoney", newsDAO.obtainTravel(logonUser));
				int yearNow = DateUtil.checkCurrentYear();
				if (yearNow > 2500) {
					yearNow = yearNow - 543;
				}

				request.setAttribute("mytravel", newsDAO.totaltravel(logonUser));

				request.setAttribute("myleaves", newsDAO.totallyleaves(logonUser, yearNow));

				List<Map<String, Object>> work = workHoursDAO.checkIn(logonUser);

				if (!work.isEmpty()) {
					Date oldDate = (Date) work.get(0).get("time_create");
					Date datenows = DateUtil.getCurrentTime();
					long daydiff = DateUtil.periodDiff(datenows, oldDate);
					String type = work.get(0).get("work_hours_type").toString();
					if ("2".equals(type) || (daydiff > 1)) {
						List<Map<String, Object>> work2 = workHoursDAO.checkIn(logonUser);
						if (!work.isEmpty()) {
							String beforeType = String.valueOf(work2.get(0).get("work_hours_type"));
							String beforeStamp = String.valueOf(work2.get(0).get("time_create"));
							request.setAttribute("beforeType", beforeType);
							request.setAttribute("beforeStamp", beforeStamp);
						}
						DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
						Date date = new Date();
						String day = dateFormat.format(date);
						String daycut = day.substring(6, 10);
						int foo = Integer.parseInt(daycut);
						if (foo > 2500) {
							int year = foo - 543;
							String strI = Integer.toString(year);
							String daycut2 = day.substring(0, 6);
							String fulldate = daycut2 + strI.trim();
							String time = DateUtil.getTimeNow();
							request.setAttribute("time", time);
							request.setAttribute("fulldate", fulldate);
						} else {
							String strI = Integer.toString(foo);
							String daycut2 = day.substring(0, 6);
							String fulldate = daycut2 + strI.trim();
							String time = DateUtil.getTimeNow();
							request.setAttribute("time", time);
							request.setAttribute("fulldate", fulldate);
						}
						return INPUT;
					}
				}
				BigDecimal x1 = new BigDecimal(0);
				BigDecimal x2 = new BigDecimal(0);
				BigDecimal x3 = new BigDecimal(0);
				BigDecimal x4;
				BigDecimal x5 = new BigDecimal(0);
				BigDecimal x6 = new BigDecimal(0);
				BigDecimal x7 = new BigDecimal(0);
				List<Map<String, Object>> wanla1 = leaveDAO.findleaveallByType(logonUser, 1);
				List<Map<String, Object>> wanla2 = leaveDAO.findleaveallByType(logonUser, 2);
				List<Map<String, Object>> wanla3 = leaveDAO.findleaveallByType(logonUser, 3);
				List<Map<String, Object>> wanla5 = leaveDAO.findleaveallByType(logonUser, 4);
				List<Map<String, Object>> wanla6 = leaveDAO.findleaveallByType(logonUser, 5);
				List<Map<String, Object>> wanla7 = leaveDAO.findleaveallByType(logonUser, 9);
				int n1 = wanla1.size();
				int n2 = wanla2.size();
				int n3 = wanla3.size();
				int n5 = wanla5.size();
				int n6 = wanla6.size();
				int n9 = wanla7.size();
				for (int i = 0; i < n1; i++) {
					BigDecimal a = (BigDecimal) wanla1.get(i).get(NODAY);

					BigDecimal b = a;

					x1 = b.add(x1);

					request.setAttribute("x1", x1);

				}

				for (int i = 0; i < n2; i++) {
					BigDecimal a = (BigDecimal) wanla2.get(i).get(NODAY);

					BigDecimal b = a;

					x2 = b.add(x2);

					request.setAttribute("x2", x2);

				}

				for (int i = 0; i < n3; i++) {
					BigDecimal a = (BigDecimal) wanla3.get(i).get(NODAY);

					BigDecimal b = a;

					x3 = b.add(x3);

					request.setAttribute("x3", x3);

				}
				for (int i = 0; i < n5; i++) {
					BigDecimal a = (BigDecimal) wanla5.get(i).get(NODAY);

					BigDecimal b = a;

					x5 = b.add(x5);

					request.setAttribute("x5", x5);
				}

				for (int i = 0; i < n6; i++) {
					BigDecimal a = (BigDecimal) wanla6.get(i).get(NODAY);

					BigDecimal b = a;

					x6 = b.add(x6);

					request.setAttribute("x6", x6);

				}
				for (int i = 0; i < n9; i++) {
					BigDecimal a = (BigDecimal) wanla7.get(i).get(NODAY);

					BigDecimal b = a;

					x7 = b.add(x7);

					request.setAttribute("x7", x7);

				}
				x4 = x1.add(x2).add(x3).add(x5).add(x6).add(x7);
				request.setAttribute("x4", x4);
				System.out.println(Constant.onlineUserList);
				try {
					String uriLog = request.getRequestURI();
					String methodLog = request.getMethod();
					String dateLog = LocalDateTime.now().toLocalDate().toString() + '%';
					logService.updateRequestLog(uriLog, methodLog, "SUCCESS", null, dateLog, user.getId());
				} catch (Exception logEx){
					log.debug("Log can't write to DB: " + logEx.getMessage());
				}
				
				return SUCCESS;
			} else {
				Cookie cSuccess = new Cookie("cooksc", null);
				cSuccess.setMaxAge(0);
				response.addCookie(cSuccess);
				return ERROR;
			}

		} catch (Exception e) {
			log.debug(e);
			log.debug(e.getCause());
			return ERROR;
		}
	}
	
	public String forgetPassword() throws Exception {
		try {
			log.debug("demo");
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}
	
	public String requestResetCode() {
	    try {
	        String login = request.getParameter(USERIDOREMAIL);
	        if (login == null || (login = login.trim()).isEmpty()) {
	            return ERROR;
	        }

	        List<Map<String, Object>> rows;
	        if (login.contains("@")) {
	            rows = userDAO.findUsersByEmail(login); 
	        } else {
	            Map<String,Object> row = userDAO.findUserById(login);
	            rows = new java.util.ArrayList<>();
	            if (row != null) rows.add(row);
	        }

	        if (rows == null || rows.isEmpty()) {
	            return ERROR;
	        }

	        String userId = String.valueOf(rows.get(0).get("id"));
	        String userEmail = String.valueOf(rows.get(0).get("email"));

	        User user = userDAO.findById(userId);
	        if (user == null) {
	            return ERROR;
	        }

	        String code = generateCode();
//	        log.debug("OTP Code = " + code);

	        user.setChangepass_code(code); 
	        userDAO.update(user);
	        
	        String body = "Hello,\n\n" +
	                "Your password reset verification code is: " + code + "\n\n" +
	                "Please use this code on the website to reset your password.\n\n" +
	                "Thanks!";
	        
//	        System.out.println(userEmail);
//	        System.out.println(body);
	        
	        emailService.sendMail(userEmail, "no-reply@cubesofttech.com", body);

	        request.setAttribute("userLoginParam", login);

	        return SUCCESS;

	    } catch (Exception e) {
	        log.debug("Request reset code error", e);
	        return ERROR;
	    }
	}
	
	public String resetPassword() {
	    try {
	        String login = request.getParameter("userLoginParam");
	        String inputCode = request.getParameter("inputCode");
	        String newPassword = request.getParameter("newPassword");
	        String confirmPassword = request.getParameter("confirmPassword");

	        request.setAttribute("userLoginParam", login);
	        request.setAttribute("inputCode", inputCode);

	        if (login == null || login.trim().isEmpty() || inputCode == null || newPassword == null || confirmPassword == null) {
	            request.setAttribute("errorMsg", "ข้อมูลไม่ครบถ้วน กรุณาทำรายการใหม่");
	            return INPUT;
	        }

	        if (!newPassword.equals(confirmPassword)) {
	            request.setAttribute("errorMsg", "Password และ Confirm Password ไม่ตรงกัน");
	            return INPUT;
	        }

	        List<Map<String, Object>> rows;
	        if (login.contains("@")) {
	            rows = userDAO.findUsersByEmail(login);
	        } else {
	            Map<String,Object> row = userDAO.findUserById(login);
	            rows = new java.util.ArrayList<>();
	            if (row != null) rows.add(row);
	        }

	        if (rows == null || rows.isEmpty() || rows.get(0).get("id") == null) {
	            request.setAttribute("errorMsg", "ไม่พบข้อมูลผู้ใช้งานในระบบ");
	            return INPUT;
	        }
	        
	        String userId = String.valueOf(rows.get(0).get("id"));
	        User user = userDAO.findById(userId);

	        if (user == null) {
	            request.setAttribute("errorMsg", "ไม่พบข้อมูลผู้ใช้งานในระบบ");
	            return INPUT;
	        }

	        String dbCode = user.getChangepass_code();

	        if (dbCode != null && dbCode.equals(inputCode.trim())) {
	            String md5Hash = loginService.generateMD5(newPassword);
	            user.setPassword(md5Hash);
	            user.setChangepass_code(null);
	            userDAO.update(user);

	            return SUCCESS;
	            
	        } else {
	            request.setAttribute("errorMsg", "Code ไม่ถูกต้อง กรุณาตรวจสอบอีกครั้ง");
	            return INPUT;
	        }

	    } catch (Exception e) {
	        log.debug("Confirm and reset password error", e);
	        request.setAttribute("errorMsg", "เกิดข้อผิดพลาดของระบบ: " + e.getMessage());
	        return INPUT;
	    }
	}
    
    public String validateUserLogin() {

        try {
            if (request != null && request.getParameterMap() != null) {
                request.getParameterMap().forEach((k, vArr) ->
                    System.out.println(k + "=" + java.util.Arrays.toString(vArr)));
            }
        } catch (Exception ignore) {}

        this.exists  = false;
        this.message = "No account matched.";
        this.userId  = null;
        this.email   = null;

        String v = (useridOrEmail == null) ? "" : useridOrEmail.trim();
        if (v.isEmpty()) {
            this.message = "Please enter user id or email.";
            return SUCCESS;
        }

        try {
            if (v.contains("@")) {
                java.util.List<java.util.Map<String, Object>> rows = userDAO.findUsersByEmail(v);
                if (rows != null && !rows.isEmpty()) {
                    java.util.Map<String, Object> row = rows.get(0);
                    Object idObj    = row.get("id");
                    Object emailObj = row.get("email");

                    this.userId  = (idObj    == null) ? null : String.valueOf(idObj);
                    this.email   = (emailObj == null) ? null : String.valueOf(emailObj);
                    this.exists  = true;
                    this.message = "Account found.";
                }
            } else {
                java.util.Map<String, Object> row = userDAO.findUserById(v);
                if (row != null && !row.isEmpty()) {
                    Object idObj    = row.get("id");
                    Object emailObj = row.get("email");

                    this.userId  = (idObj    == null) ? null : String.valueOf(idObj);
                    this.email   = (emailObj == null) ? null : String.valueOf(emailObj);
                    this.exists  = true;
                    this.message = "Account found.";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            this.exists  = false;
            this.message = "Error during validation.";
        }

        return SUCCESS;
    }
	
    private boolean existsByEmailMock(String email) {
        return "demo@example.com".equalsIgnoreCase(email);
    }
    private boolean existsByUserIdMock(String userId) {
        return "demo".equalsIgnoreCase(userId);
    }
	
    private String generateCode() {
        List<Character> codeChars = new ArrayList<>(PASSWORD_LENGTH);

        codeChars.add(CHAR_UPPER.charAt(secureRandom.nextInt(CHAR_UPPER.length())));
        codeChars.add(CHAR_DIGIT.charAt(secureRandom.nextInt(CHAR_DIGIT.length())));

        String allowedChars = CHAR_UPPER + CHAR_DIGIT;

        while (codeChars.size() < PASSWORD_LENGTH) {
            codeChars.add(allowedChars.charAt(secureRandom.nextInt(allowedChars.length())));
        }

        Collections.shuffle(codeChars, secureRandom);

        StringBuilder sb = new StringBuilder(PASSWORD_LENGTH);
        for (char c : codeChars) sb.append(c);
        return sb.toString();
    }
    
	public String signout() {
		try {
			Cookie cUserlogin = new Cookie("cookuser", null);
			Cookie cMd5Password = new Cookie("cookmd5", null);
			Cookie cRemember = new Cookie("cookrem", null);
			Cookie cSuccess = new Cookie("cooksc", null);
			cUserlogin.setMaxAge(0);
			cMd5Password.setMaxAge(0);
			cRemember.setMaxAge(0);
			cSuccess.setMaxAge(0);
			response.addCookie(cUserlogin);
			response.addCookie(cMd5Password);
			response.addCookie(cRemember);
			response.addCookie(cSuccess);
			request.getSession().invalidate();
			System.out.println(Constant.onlineUserList);
			return SUCCESS;
		} catch (Exception e) {
			log.debug(e);
			return ERROR;
		}
	}
	
	public String onlineUser() {
		try {
			String s1 = "";  
			int i = 0 ;
			for (String temp2 : Constant.onlineUserList) {
				if ( i > 0) {
					s1 = s1 + " , ";
				}
				i++;
				s1 = s1+ "'" + temp2 + "'";
			}
			log.info(s1);  
			List<Map<String, Object>> sessionOnlineUser  = userDAO.findRoleNameById(s1);
			request.setAttribute("sessionOnlineUser", sessionOnlineUser);
			log.info(sessionOnlineUser); 
			return SUCCESS;
		} catch (Exception e) {
			log.debug(e);
			return ERROR;
		}
	}
    
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUseridOrEmail() {
		return useridOrEmail;
	}

	public void setUseridOrEmail(String useridOrEmail) {
		this.useridOrEmail = useridOrEmail;
	}

	public boolean isExists() {
		return exists;
	}

	public void setExists(boolean exists) {
		this.exists = exists;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

}