
package com.cubesofttech.action;

import java.io.File;
import java.math.BigDecimal;
import java.security.SecureRandom;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
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
import com.cubesofttech.model.RoleAuthorizedObject;
import com.cubesofttech.model.SsoToken;
import com.cubesofttech.model.User;
import com.cubesofttech.model.UserRole;
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
				String imgPath = null;
				if (user.getPath() != null && user.getPath().contains("_")) {
				    try {
				        String originalFileName = new File(user.getPath()).getName();
				        String fileIdStr = originalFileName.substring(0, originalFileName.indexOf("_"));
				        int fileId = Integer.parseInt(fileIdStr);
				        String typeFile = originalFileName.substring(originalFileName.lastIndexOf("."));
				        imgPath = "/upload/user/user_" + fileId + typeFile;

				        String server = request.getServletContext().getRealPath("/");
				        File f = new File(server + imgPath);
				        if (!f.exists()) {
				            imgPath = null;
				        }
				    } catch (Exception e) {
				        imgPath = null;
				    }
				}
				session.setAttribute("userImgPath", imgPath);
				
				session.setAttribute("user", user);
				session.setAttribute("onlineUser", user);
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
	
    public String resetPassword() {
        try {
        	
//        	if (true) {
//        		System.out.println(">>> ENTER resetPassword(), email=" + request.getParameter(EMAIL));
//        		return SUCCESS;
//			}
//        	if (true) {
//                return ERROR;
//			}
        	
        String login = request.getParameter(USERIDOREMAIL);
        if (login == null || (login = login.trim()).isEmpty()) {
            return ERROR;
        }

        // ค้นผู้ใช้จาก email หรือ id (VARCHAR)
        List<Map<String, Object>> rows;
        if (login.contains("@")) {
            rows = userDAO.findUsersByEmail(login);          // คืน id,email (ตาม DAO ที่คุณมี)
        } else {
            Map<String,Object> row = userDAO.findUserById(login); // คืน Map เดียว
            rows = new java.util.ArrayList<>();
            if (row != null) rows.add(row);
        }

        if (rows == null || rows.isEmpty()) {
            return ERROR;
        }

        String userId    = String.valueOf(rows.get(0).get("id"));
        String userEmail = String.valueOf(rows.get(0).get("email"));

            // 1) Generate a new password (must contain at least one A-Z, a-z, 0-9)
            String plainPassword = generateStrongPassword();
    		log.debug("plainPassword = " + plainPassword);

    		// 2) Encode with MD5 and update the user table
            User user = userDAO.findById(userId);
            if (user == null) {
                return ERROR;
            }

            String md5Hash = loginService.generateMD5(plainPassword);
            user.setPassword(md5Hash);
            userDAO.update(user);

            // 3) Send an email with the new password
            String body = "Hello,\n\n" +
                    "Your new password is: " + plainPassword + "\n\n" +
                    "Please login and change it as soon as possible.\n\n" +
                    "Thanks!";
            loginService.sendmail2("no-reply@cubesofttech.com", userEmail, "Password Reset", body);

            return SUCCESS;

        } catch (Exception e) {
            log.debug("Reset password error", e);
            return ERROR;
        }
    }
    
    public String validateUserLogin() {

        // (Optional) debug ดูพารามิเตอร์ที่ถูกส่งมา
        try {
            if (request != null && request.getParameterMap() != null) {
                request.getParameterMap().forEach((k, vArr) ->
                    System.out.println(k + "=" + java.util.Arrays.toString(vArr)));
            }
        } catch (Exception ignore) { /* no-op */ }

        // เคลียร์ค่าผลลัพธ์ก่อน
        this.exists  = false;
        this.message = "No account matched.";
        this.userId  = null;
        this.email   = null;

        // รับค่าจากพารามิเตอร์ที่ bind มาโดย Struts2
        String v = (useridOrEmail == null) ? "" : useridOrEmail.trim();
        if (v.isEmpty()) {
            this.message = "Please enter user id or email.";
            return SUCCESS; // JSON: {exists:false, message:...}
        }

        try {
            if (v.contains("@")) {
                // ผู้ใช้กรอกเป็น Email
                java.util.List<java.util.Map<String, Object>> rows = userDAO.findUsersByEmail(v);
                if (rows != null && !rows.isEmpty()) {
                    java.util.Map<String, Object> row = rows.get(0); // ถ้า email เป็น unique จะมี 0 หรือ 1 แถว
                    Object idObj    = row.get("id");
                    Object emailObj = row.get("email");

                    this.userId  = (idObj    == null) ? null : String.valueOf(idObj);
                    this.email   = (emailObj == null) ? null : String.valueOf(emailObj);
                    this.exists  = true;
                    this.message = "Account found.";
                }
            } else {
                // ผู้ใช้กรอกเป็น User ID (คอลัมน์ id เป็น VARCHAR)
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
            e.printStackTrace(); // แนะนำใช้ logger จริงในโปรดักชัน
            this.exists  = false;
            this.message = "Error during validation.";
        }

        return SUCCESS; // Struts2 JSON plugin จะ serialize fields ผ่าน getters
    }
	
    // ===== Mock เพื่อเดโม แทนด้วย DAO จริงของคุณ =====
    private boolean existsByEmailMock(String email) {
        return "demo@example.com".equalsIgnoreCase(email);
    }
    private boolean existsByUserIdMock(String userId) {
        return "demo".equalsIgnoreCase(userId);
    }
	
//	public String forgetPassword() {
//
//		try {
//			String email = request.getParameter(EMAIL);
//			List<Map<String, Object>> findEmail = userDAO.findByemail(email);
//			
//			Map<String, String> obj = new HashMap<>();
//			if (!findEmail.isEmpty()) {
//				String userEmail = (String) findEmail.get(0).get("email");
//				String userId = (String) findEmail.get(0).get("id");
//				String userKey = (String) loginService.generateMD5(DateUtil.getTimeNow());
//				Timestamp initTime = DateUtil.getCurrentTime();
//				Timestamp expired = new Timestamp(initTime.getTime() + (1000 * 60 * 60 * 24));
//				
//				UserRpw find = userRpwDAO.findByUserId(userId);
//				
//				if(find == null) {
//					UserRpw u = new UserRpw();
//					u.setUserId(userId);
//					u.setUserKey(userKey);
//					u.setExpried(expired);
//					userRpwDAO.save(u); 
//				} else {
//					find.setUserKey(userKey);
//					find.setExpried(expired);
//					userRpwDAO.update(find);;
//				}
//				
//				// Function RandomPassword 6 number
//				/*String ranpassword =loginService.randomPassword(6);
//				
//				User find = userDAO.findById(userId);
//				find.setPassword(loginService.generateMD5(ranpassword));
//				userDAO.update(find);*/
//				
//				loginService.sendmail(userKey, userEmail);
//				request.setAttribute("result", "<div class=\"alert alert-success\" style=\"color:green \"><button class=\"close\" data-close=\"alert\"></button>&#x1F6C8; Please check your e-mail and click on the provided link to reset your password.</div>");
//		
//				/*obj.put("flag", SUCCESS);
//				Gson gson = new GsonBuilder().setDateFormat("dd/MM/yyyy HH:mm:ss").create();
//				String jsonObjStr = gson.toJson(obj);
//				PrintWriter out = response.getWriter();
//				out.print(jsonObjStr);
//				out.flush();
//				out.close();*/
//				return SUCCESS;
//			} else {
//				/*obj.put("flag", ERROR);
//				Gson gson = new GsonBuilder().setDateFormat("dd/MM/yyyy HH:mm:ss").create();
//				String jsonObjStr = gson.toJson(obj);
//				PrintWriter out = response.getWriter();
//				out.print(jsonObjStr);
//				out.flush();
//				out.close();*/
//				request.setAttribute("result", "<div class=\"alert alert-danger\" style=\"color:red \"><button class=\"close\" data-close=\"alert\"></button>&#x1F6C8; Unable to reset password due to an unknown error. Please try again.</div>");
//				return ERROR;
//			}
//
//		} catch (Exception e) {
//			log.debug(e);
//			return ERROR;
//		}
//	}
	
    private String generateStrongPassword() {
        List<Character> pwChars = new ArrayList<>(PASSWORD_LENGTH);

        // บังคับให้มีอย่างน้อย 1 ตัวจากแต่ละกลุ่ม
        pwChars.add(CHAR_UPPER.charAt(secureRandom.nextInt(CHAR_UPPER.length())));
        pwChars.add(CHAR_LOWER.charAt(secureRandom.nextInt(CHAR_LOWER.length())));
        pwChars.add(CHAR_DIGIT.charAt(secureRandom.nextInt(CHAR_DIGIT.length())));

        // เติมที่เหลือจากชุด ALL
        while (pwChars.size() < PASSWORD_LENGTH) {
            pwChars.add(ALL.charAt(secureRandom.nextInt(ALL.length())));
        }

        // สับตำแหน่งเพื่อความสุ่มจริง
        Collections.shuffle(pwChars, secureRandom);

        StringBuilder sb = new StringBuilder(PASSWORD_LENGTH);
        for (char c : pwChars) sb.append(c);
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