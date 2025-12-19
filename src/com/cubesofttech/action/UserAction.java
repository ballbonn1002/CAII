package com.cubesofttech.action;

import java.io.File;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.GregorianCalendar;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.cubesofttech.dao.WorkHoursDAO;
import com.cubesofttech.dao.BorrowDAO;
import com.cubesofttech.dao.DepartmentDAO;
import com.cubesofttech.dao.EquipmentDAO;
import com.cubesofttech.dao.FileUploadDAO;
import com.cubesofttech.dao.JobSiteTeamDAO;
import com.cubesofttech.dao.JobsiteDAO;
import com.cubesofttech.dao.LeaveDAO;
import com.cubesofttech.dao.LeaveTypeDAO;
import com.cubesofttech.dao.LeaveUserDAO;
import com.cubesofttech.dao.NewsDAO;
import com.cubesofttech.dao.PositionDAO;
import com.cubesofttech.dao.RoleDAO;
import com.cubesofttech.dao.UserDAO;
import com.cubesofttech.model.Borrow;
import com.cubesofttech.model.Department;
import com.cubesofttech.model.Equipment;
import com.cubesofttech.model.FileUpload;
import com.cubesofttech.model.JobSiteTeam;
import com.cubesofttech.model.LeaveType;
import com.cubesofttech.model.Leaves;
import com.cubesofttech.model.Role;
import com.cubesofttech.model.User;
import com.cubesofttech.util.Convert;
import com.cubesofttech.util.DateUtil;
import com.cubesofttech.util.FileUtil;
import com.cubesofttech.util.MD5;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import java.text.SimpleDateFormat;
import com.opensymphony.xwork2.ActionSupport;

public class UserAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2280661337420278284L;
	private static final Integer Interger = null;
	Logger log = Logger.getLogger(getClass());
	HttpServletRequest request = ServletActionContext.getRequest();
	HttpServletResponse response = ServletActionContext.getResponse();
	public static final String User = "userList";
	public static final String ONLINEUSER = "onlineUser";

	@Autowired
	private NewsDAO newsDAO;

	@Autowired
	private EquipmentDAO equipmentDAO;

	@Autowired
	private LeaveTypeDAO leavetypeDAO;

	@Autowired
	private LeaveUserDAO leaveuserDAO;

	@Autowired
	private JobsiteDAO jobsiteDAO;

	@Autowired
	private JobSiteTeamDAO jobSiteTeamDAO;
	
	@Autowired
	private WorkHoursDAO workHoursDAO;

	private User onlineUser = (User) request.getSession().getAttribute("onlineUser");

	private String confirmpassword;

	public String getConfirmpassword() {
		return confirmpassword;
	}

	public void setConfirmpassword(String confirmpassword) {
		this.confirmpassword = confirmpassword;
	}

	@Autowired
	private FileUploadDAO fileuploadDAO;

	@Autowired
	private BorrowDAO borrowDAO;

	private String endDate;

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	@Autowired
	private UserDAO userDAO;

	@Autowired
	private DepartmentDAO departmentDAO;

	@Autowired
	private RoleDAO roleDAO;

	@Autowired
	private LeaveDAO leaveDAO;

	@Autowired
	private PositionDAO positionDAO;

	private String position_id;

	public String getPosition_id() {
		return position_id;
	}

	public void setPosition_id(String position_id) {
		this.position_id = position_id;
	}

	private String department_id;

	public String getDepartment_id() {
		return department_id;
	}

	public void setDepartment_id(String department_id) {
		this.department_id = department_id;
	}

	public String password;

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	private User user;

	private String id_sitejob;
	
	
	 private String work_type;
	 private String avatar_remove;
	 
	 public String getWorkType() {
		    return work_type;
		}

		public void setWorkType(String work_type) {
		    this.work_type = work_type;
		}
		
	 private String onsite_num;
	 
	 public String getOnsiteNum() {
		    return onsite_num;
		}

	public void setOnsiteNum(String onsite_num) {
		    this.onsite_num = onsite_num;
	}
		
	public String getAvatar_remove() {
		return avatar_remove;
	}

	public void setAvatar_remove(String avatar_remove) {
		this.avatar_remove = avatar_remove;
	}

	public String getId_sitejob() {
		return id_sitejob;
	}

	public void setId_sitejob(String id_sitejob) {
		this.id_sitejob = id_sitejob;
	}

	private String page;

	public String getPage() {
		return page;
	}

	public void setPage(String page) {
		this.page = page;
	}

	private String userId;

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	private String birthDate;

	public String getBirthDate() {
		return birthDate;
	}

	public void setBirthDate(String birthDate) {
		this.birthDate = birthDate;
	}

	private String user_id;

	private String startDate;

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	private String user_email;
	private String user_name;
	private String user_nickName;
	private String user_address;
	private String user_username;
	private String user_titleNameTH;
	private String user_titleNameEN;
	private String user_fullNameEN;
	private String user_nickNameTH;
	private String user_nickNameEN;
	private String user_citizenId;
	private String user_passportId;
	private String user_birthDate;
	private String user_emergContact;
	private String user_emergPhone;
	
	public String getUser_phonenum() {
		return user_phonenum;
	}

	public String getUser_username() {
		return user_username;
	}

	public void setUser_username(String user_username) {
		this.user_username = user_username;
	}

	public void setUser_phonenum(String user_phonenum) {
		this.user_phonenum = user_phonenum;
	}

	public String getUser_gender() {
		return user_gender;
	}

	public void setUser_gender(String user_gender) {
		this.user_gender = user_gender;
	}

	public String getUser_titleNameTH() {
		return user_titleNameTH;
	}

	public void setUser_titleNameTH(String user_titleNameTH) {
		this.user_titleNameTH = user_titleNameTH;
	}

	public String getUser_titleNameEN() {
		return user_titleNameEN;
	}

	public void setUser_titleNameEN(String user_titleNameEN) {
		this.user_titleNameEN = user_titleNameEN;
	}

	public String getUser_fullNameEN() {
		return user_fullNameEN;
	}

	public void setUser_fullNameEN(String user_fullNameEN) {
		this.user_fullNameEN = user_fullNameEN;
	}

	public String getUser_nickNameTH() {
		return user_nickNameTH;
	}

	public void setUser_nickNameTH(String user_nickNameTH) {
		this.user_nickNameTH = user_nickNameTH;
	}

	public String getUser_nickNameEN() {
		return user_nickNameEN;
	}

	public void setUser_nickNameEN(String user_nickNameEN) {
		this.user_nickNameEN = user_nickNameEN;
	}

	public String getUser_citizenId() {
		return user_citizenId;
	}

	public void setUser_citizenId(String user_citizenId) {
		this.user_citizenId = user_citizenId;
	}

	public String getUser_passportId() {
		return user_passportId;
	}

	public void setUser_passportId(String user_passportId) {
		this.user_passportId = user_passportId;
	}
	

	public String getUser_birthDate() {
		return user_birthDate;
	}

	public void setUser_birthDate(String user_birthDate) {
		this.user_birthDate = user_birthDate;
	}

	public String getUser_emergContact() {
		return user_emergContact;
	}

	public void setUser_emergContact(String user_emergContact) {
		this.user_emergContact = user_emergContact;
	}

	public String getUser_emergPhone() {
		return user_emergPhone;
	}

	public void setUser_emergPhone(String user_emergPhone) {
		this.user_emergPhone = user_emergPhone;
	}

	private File fileUpload;
	private String fileUploadSize;
	private String fileUploadFileName;
	private String mypic;
	private String user_phonenum;
	private String user_gender;
	private String work_start_time;

	public String getWork_start_time() {
		return work_start_time;
	}

	public void setWork_start_time(String work_start_time) {
		this.work_start_time = work_start_time;
	}

	public String getMypic() {
		return mypic;
	}

	public void setMypic(String mypic) {
		this.mypic = mypic;
	}

	public String getFileUploadFileName() {
		return fileUploadFileName;
	}

	public void setFileUploadFileName(String fileUploadFileName) {
		this.fileUploadFileName = fileUploadFileName;
	}

	public String getFileUploadSize() {
		return fileUploadSize;
	}

	public void setFileUploadSize(String fileUploadSize) {
		this.fileUploadSize = fileUploadSize;
	}

	public File getFileUpload() {
		return fileUpload;
	}

	public void setFileUpload(File fileUpload) {
		this.fileUpload = fileUpload;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getUser_email() {
		return user_email;
	}

	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getUser_nickName() {
		return user_nickName;
	}

	public void setUser_nickName(String user_nickName) {
		this.user_nickName = user_nickName;
	}

	public String getUser_address() {
		return user_address;
	}

	public void setUser_address(String user_address) {
		this.user_address = user_address;
	}

	private List<User> cubesoftUsers;

	public List<User> getCubesoftUsers() {
		return cubesoftUsers;
	}

	public void setCubesoftUsers(List<User> cubesoftUsers) {
		this.cubesoftUsers = cubesoftUsers;
	}

	public String list() {
		try {
	        List<Map<String, Object>> cubesoftUsers = userDAO.Query_Userlist();
	    
	        for (Map<String, Object> map : cubesoftUsers) {
	            String userId = (String) map.get("id");


	            List<Map<String, Object>> siteList = jobsiteDAO.getNameSiteListByUserId(userId);
	            if (siteList == null) {
	                siteList = new ArrayList<>();
	            }
	            map.put("job_site", siteList);

	            try {
	                List<Map<String, Object>> rawSites = jobsiteDAO.findJobsiteUser(userId); 

	                List<Map<String, Object>> relatedSites = new ArrayList<>();
	                if (rawSites != null) {
	                    for (Map<String, Object> js : rawSites) {
	                        Object rel = js.get("is_related");
	                        if ("1".equals(String.valueOf(rel))) {
	                            relatedSites.add(js);
	                        }
	                    }
	                }

	                map.put("job_site_all", relatedSites);

	                if (!relatedSites.isEmpty()) {
	                    StringBuilder sb = new StringBuilder();
	                    for (Map<String, Object> js : relatedSites) {
	                        Object nameObj = js.get("name_site");
	                        if (nameObj != null) {
	                            if (sb.length() > 0) sb.append(", ");
	                            sb.append(nameObj.toString());
	                        }
	                    }
	                    map.put("job_site_all_names", sb.toString());
	                } else {
	                    map.put("job_site_all_names", "");
	                }

	            } catch (Exception ex) {
	                map.put("job_site_all", new ArrayList<Map<String, Object>>());
	                map.put("job_site_all_names", "");
	            }
	            
	            if (map.get("end_date") == null) {
	                Object resign = map.get("resign_date");
	                if (resign != null) {
	                    map.put("end_date", resign);
	                }
	            }

	            // map work_type / onsite_num
	            Object wtObj = map.get("work_type");
	            String wt = wtObj != null ? wtObj.toString() : null;

	            String work_type = null;
	            if ("1".equals(wt)) {
	                work_type = "On-site";
	            } else if ("2".equals(wt)) {
	                work_type = "Hybrid";
	            } else if ("3".equals(wt)) {
	                work_type = "WFH";
	            }
	            map.put("work_type", work_type);

	            Object osObj = map.get("onsite_num"); 
	            String os = osObj != null ? osObj.toString() : null;

	            String onsite_num = null;
	            if ("1".equals(os)) {
	                onsite_num = "0.5-1 day";
	            } else if ("2".equals(os)) {
	                onsite_num = "2-3 day";
	            } else if ("3".equals(os)) {
	                onsite_num = "4-5 day";
	            }
	            map.put("onsite_num", onsite_num);
	        }
			
			

			/*
			 * String cubesoftUsersJson = new Gson().toJson(cubesoftUsers);
			 * request.setAttribute("cubesoftUsersJson", cubesoftUsersJson);
			 */
			request.setAttribute("cubesoftUser", cubesoftUsers);
			String cubesoftUsersJson = new com.google.gson.Gson().toJson(cubesoftUsers);
			request.setAttribute("usersJson", cubesoftUsersJson);
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	public String resetLastyearQuota() {
		userDAO.resetLastyearQuota();
		return SUCCESS;
	}

	public String listUpdate() {
		try {
			List<Map<String, Object>> cubesoftUsers = userDAO.Query_Userlist();
			request.setAttribute("cubesoftUsers", cubesoftUsers);
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	public String updateUserStatus() {
		try {

			// String enable = request.getParameter("enable");
			String userid = request.getParameter("userid");
			User u = userDAO.findById(userid);
			// toggle
			String status = "enable";
			if ("1".equals(u.getEnable())) {
				u.setEnable("0");
				status = "disable";
			} else {
				u.setEnable("1");
				status = "enable";
			}

			userDAO.update(u);

			Gson gson = new GsonBuilder().create();
			String responseJSON = gson.toJson(u);
			log.debug(responseJSON);

			request.setAttribute("json", responseJSON);

			String JSON = "json";

			return JSON;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	public String updateUserStatustest() {
		try {

			// String enable = request.getParameter("enable");
			String userid = request.getParameter("userid");
			User u = userDAO.findById(userid);
			// toggle
			String status = "enable";
			if ("1".equals(u.getEnable())) {
				u.setEnable("0");
				status = "disable";
			} else {

			}

			userDAO.update(u);

			Gson gson = new GsonBuilder().create();
			String responseJSON = gson.toJson(u);
			log.debug(responseJSON);

			request.setAttribute("json", responseJSON);

			String JSON = "json";

			return JSON;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	public String openEdit() {
		try {
			User selectUser = userDAO.findById(userId);
			
//			JobSiteTeam user = JobSiteTeamDAO.findAllByUserId(userId);
			String id = request.getParameter("userId");
			log.debug(id);
			List<Map<String, Object>> jobsiteList = jobsiteDAO.findJobsiteUser(id);
			request.setAttribute("test", jobsiteList);
			/*
			 * List<Map<String, Object>> jobuser = jobsiteDAO.findJobsiteUser(UserIdEdit);
			 * request.setAttribute("test2", jobuser);
			 */

			List<Map<String, Object>> departmentList = departmentDAO.sequense();

			List<Map<String, Object>> positionList = positionDAO.sequense();

			request.setAttribute("positionList", positionList);

			request.setAttribute("departmentList", departmentList);

			List<Role> roleList = roleDAO.findAll();
			request.setAttribute("roleList", roleList);

			request.setAttribute("userList", userDAO.sequense());

			request.setAttribute("selectUser", selectUser);

			List<Map<String, Object>> leavwait = leaveDAO.listwaitperson(String.valueOf(userId));
			List<Map<String, Object>> leavhis = leaveDAO.listoneperson(String.valueOf(userId));
			int sum_w = leavwait.size();
			int sum_h = leavhis.size();
			request.setAttribute("leaveW", sum_w);
			request.setAttribute("leaveH", sum_h);

			request.setAttribute("borrow_history", borrowDAO.findHistoryByUser(selectUser.getId()));

			List<Borrow> borrows = borrowDAO.findBorrowByUser(selectUser.getId());
			
			log.info("borrows=" + borrows);
			


			List<Equipment> equipments = new ArrayList<Equipment>();
			for (int i = 0; i < borrows.size(); i++) {
				String equipment_id = borrows.get(i).getEquipmentId();
				Equipment equipments2 = equipmentDAO.getById(Integer.parseInt(equipment_id));
				log.info("equipments2=" + equipments2);
				equipments.add(equipments2);
				log.info("equipments=" + equipments);
			}

			request.setAttribute("borrows", new Gson().toJson(borrows));
			request.setAttribute("equipments", new Gson().toJson(equipments));
			log.debug(selectUser.getPaymentRemark());

			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	public String open() {
		try {
			
			List<Map<String, Object>> departmentList = departmentDAO.sequense();
			request.setAttribute("departmentList", departmentList);

			List<Map<String, Object>> positionList = positionDAO.sequense();
			request.setAttribute("positionList", positionList);

			List<Role> roleList = roleDAO.findAll();
			request.setAttribute("roleList", roleList);

			request.setAttribute("userList", userDAO.sequense());

			List<Map<String, Object>> leavwait = leaveDAO.listwaitperson(String.valueOf(userId));
			List<Map<String, Object>> leavhis = leaveDAO.listoneperson(String.valueOf(userId));
			int sum_w = leavwait.size();
			int sum_h = leavhis.size();
			request.setAttribute("leaveW", sum_w);
			request.setAttribute("leaveH", sum_h);

			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	public String performEdit() {
		try {
			User ur = (User) request.getSession().getAttribute("onlineUser");
			String logonUser = ur.getId();
			log.info(logonUser);

			User u = userDAO.findById(user.getId());
			log.debug(id_sitejob);
			/* String[] siteJobId = id_sitejob.split(","); */
			String rawSiteJob = (id_sitejob == null) ? "" : id_sitejob.trim();

			String[] siteJobId = rawSiteJob.isEmpty() ? new String[0] : rawSiteJob.split(",");

			log.debug("siteJobId array = " + Arrays.toString(siteJobId));
			
			String UserIdEdit = user.getId();
			log.debug("effectiveUserId = " + UserIdEdit);
			List<JobSiteTeam> ListuserId = jobSiteTeamDAO.findAllByUserId(UserIdEdit);
			log.debug("ListuserId size = " + (ListuserId == null ? "null" : ListuserId.size()));

			//Clean Data and Change String To List
			List<String> selectedSiteIds = new ArrayList<>();
			if (siteJobId != null) {
				for (String s : siteJobId) {
					if (s != null && !s.trim().isEmpty()) {
						selectedSiteIds.add(s.trim());
					}
				}
			}
			log.debug("Selected siteJobId set = " + selectedSiteIds);

			// Add newly selected links that don't exist yet
			if (!selectedSiteIds.isEmpty()) {
				for (String siteId : selectedSiteIds) {
					JobSiteTeam Add_jobuser = jobSiteTeamDAO.findByIdSiteJobAndUserId(siteId, UserIdEdit);
					if (Add_jobuser == null) {
						JobSiteTeam Jobuser = new JobSiteTeam();
						Jobuser.setUser_id(UserIdEdit);
						Jobuser.setId_sitejob(siteId);
						jobSiteTeamDAO.save(Jobuser);
						log.debug("Added siteJobId=" + siteId);
					} else {
						log.debug("Already exists siteJobId=" + siteId);
					}
				}
			}else {

			    JobSiteTeam emptyLink = new JobSiteTeam();
			    emptyLink.setUser_id(UserIdEdit);
			    emptyLink.setId_sitejob("");
			    jobSiteTeamDAO.save(emptyLink);
			    log.debug("Added empty siteJobId for user=" + UserIdEdit);
			}

			// Delete links that exist in DB but were not selected

			for (JobSiteTeam link : ListuserId) {
				boolean stillSelected = selectedSiteIds.contains(link.getId_sitejob());
				if (!stillSelected) {
					jobSiteTeamDAO.delete(link);
					log.debug("Deleted siteJobId=" + link.getId_sitejob());
				}
			}

			if (fileUpload != null) {
				int maxId = fileuploadDAO.getMaxId() + 1;
				ServletContext context = request.getServletContext();
				String fileServerPath = context.getRealPath("/");

				FileUtil.upload(fileUpload, fileServerPath + "upload/user/", maxId + "_" + fileUploadFileName);

				int split = fileUploadFileName.indexOf(".");
				String name = fileUploadFileName.substring(0, split);
				String type = fileUploadFileName.substring(split);

				FileUpload fileupload = new FileUpload();
				fileupload.setFileId(maxId);
				fileupload.setUserId(logonUser);
				fileupload.setUserCreate(logonUser);
				fileupload.setName(name);
				fileupload.setType(type);
				fileupload.setSize(fileUploadSize);
				fileupload.setPath("/upload/user/" + maxId + "_" + fileUploadFileName);
				fileupload.setTimeCreate(DateUtil.getCurrentTime());

				fileuploadDAO.save(fileupload);

				u.setPath("/upload/user/" + maxId + "_" + fileUploadFileName);
			}

			u.setName(user.getName());
			u.setNickName(user.getNickName());
			u.setUsername(user_username);
			u.setEmail(user_email);
			u.setManagerId(user.getManagerId());
			u.setId_sitejob(user.getId_sitejob());
			log.debug(u.getId_sitejob());
			u.setAddress(user.getAddress());
			u.setTimeUpdate(DateUtil.getCurrentTime());

			if (startDate != null && !startDate.equals("")) {
				u.setStartDate(Convert.parseDate(startDate));
			}
			if (birthDate != null && !birthDate.equals("")) {
				u.setBirthDate(Convert.parseDate(birthDate));
			}
			if (endDate != null && !endDate.equals("")) {
				u.setEndDate(Convert.parseDate(endDate));
			}

			/*JSP didn't send password if want to send password can uncomment this!!
			 * if (password.equalsIgnoreCase(u.getPassword())) { u.setPassword(password); }
			 * else { u.setPassword(MD5.getInstance().hashData(password.getBytes())); }
			 */
			
			if (password.equalsIgnoreCase(u.getPassword())) { u.setPassword(password); }
			else { u.setPassword(MD5.getInstance().hashData(password.getBytes())); }

			u.setSocialSecurity(user.getSocialSecurity() != null ? user.getSocialSecurity() : "0");
			u.setWithHoldAuto(user.getWithHoldAuto() != null ? user.getWithHoldAuto() : "0");

			if (user.getRoleId() != null)
				u.setRoleId(user.getRoleId());
			if (department_id != null)
				u.setDepartmentId(department_id);
			if (position_id != null)
				u.setPositionId(position_id);

			if (page.equals("1")) {
				log.debug("user edit");
				u.setEmailHost(user.getEmailHost());
			} else if (page.equals("2")) {
				log.debug("admin edit");
				u.setEnable(user.getEnable());
				u.setEmailEnable(user.getEmailEnable());
				u.setEmployeeId(user.getEmployeeId());
				u.setWorkDayStart(user.getWorkDayStart());
				u.setWorkDayEnd(user.getWorkDayEnd());
				u.setWorkTimeStart(user.getWorkTimeStart());
				u.setWorkTimeEnd(user.getWorkTimeEnd());
				
				u.setWorkType(user.getWorkType());
				u.setOnsiteNum(user.getOnsiteNum());
				log.debug("Work Type: " + u.getWorkType());
				log.debug("Onsite_num: "+ u.getOnsiteNum());
				
				u.setEduInstitute1(user.getEduInstitute1());
				u.setEduInstitute2(user.getEduInstitute2());
				u.setEduInstitute3(user.getEduInstitute3());
				u.setEduInstitute4(user.getEduInstitute4());
				u.setEduDurStart1(user.getEduDurStart1());
				u.setEduDurStart2(user.getEduDurStart2());
				u.setEduDurStart3(user.getEduDurStart3());
				u.setEduDurStart4(user.getEduDurStart4());
				u.setEduDurEnd1(user.getEduDurEnd1());
				u.setEduDurEnd2(user.getEduDurEnd2());
				u.setEduDurEnd3(user.getEduDurEnd3());
				u.setEduDurEnd4(user.getEduDurEnd4());
				u.setEduDegree1(user.getEduDegree1());
				u.setEduDegree2(user.getEduDegree2());
				u.setEduDegree3(user.getEduDegree3());
				u.setEduDegree4(user.getEduDegree4());
				u.setLeaveQuota1(user.getLeaveQuota1());
				u.setLeaveQuota3(user.getLeaveQuota3());
				u.setLeaveQuota4(user.getLeaveQuota4());
				u.setPhonenum(user.getPhonenum());
				u.setGender(user.getGender());
				u.setTitleNameTH(user.getTitleNameTH());
				u.setTitleNameEN(user.getTitleNameEN());
				u.setNameEN(user.getNameEN());
				u.setNickNameEN(user.getNickNameEN());
				u.setEmergContact(user.getEmergContact());
				u.setEmergPhone(user.getEmergPhone());
				u.setEmployeeTypeId(user.getEmployeeTypeId());
				u.setWithHold(user.getWithHold());
				u.setPaymentRemark(user.getPaymentRemark());
				u.setTaxDec(user.getTaxDec());
				u.setTransferType(user.getTransferType());
				u.setBank(user.getBank());
				u.setBankType(user.getBankType());
				u.setBankNum(user.getBankNum());
				u.setBankBranch(user.getBankBranch());
				u.setCitizenId(user.getCitizenId());
				u.setPassportId(user.getPassportId());
				u.setIncDa(user.getIncDa());
				u.setIncNb(user.getIncNb());
			}

			userDAO.update(u);

			userId = user.getId();
			request.setAttribute("selectUser", userDAO.findById(userId));
			request.setAttribute("departmentList", departmentDAO.sequense());
			request.setAttribute("positionList", positionDAO.sequense());
			request.setAttribute("roleList", roleDAO.findAll());
			request.setAttribute("userList", userDAO.sequense());
			
			
			List<Map<String, Object>> jobsiteList = jobsiteDAO.findJobsiteUser(getUserId());
			request.setAttribute("test", jobsiteList);
			
			List<Map<String, Object>> leavwait = leaveDAO.listwaitperson(String.valueOf(userId));
			List<Map<String, Object>> leavhis = leaveDAO.listoneperson(String.valueOf(userId));
			request.setAttribute("leaveW", leavwait.size());
			request.setAttribute("leaveH", leavhis.size());

			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			log.debug(e);
			return ERROR;
		}
	}

	public String changepass() {
		try {
			String oldpass_i = request.getParameter("oldpass_i");
			String oldpass_input = MD5.getInstance().hashData(oldpass_i.getBytes());
			String oldpass = request.getParameter("oldpass");
			String newpass = request.getParameter("newpass");
			String newpass_insert = MD5.getInstance().hashData(newpass.getBytes());
			if (oldpass_input.equals(oldpass)) {
				User u = userDAO.findById(user.getId());
				u.setPassword(newpass_insert);
				u.setPasswordUpdate(DateUtil.getCurrentTime());
				userDAO.update(u);
				userId = user.getId();
				return SUCCESS;
			}

			userId = user.getId();
			return ERROR;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	public String performAdd() {
		try {
			System.out.println("perform add");
			List<Map<String, Object>> departmentList = departmentDAO.sequense();
			request.setAttribute("departmentList", departmentList);
			List<Map<String, Object>> positionList = positionDAO.sequense();
			request.setAttribute("positionList", positionList);
			List<Role> roleList = roleDAO.findAll();
			request.setAttribute("roleList", roleList);

			String email = user.getEmail();
	        String phone = user.getPhonenum();
	        String nickname = user.getNickName();
	        String nicknameEN = user.getNickNameEN();
	        String titlenameTH = user.getTitleNameTH();
	        String titlenameEN = user.getTitleNameEN();
	        String gender = user.getGender();
	        String role = user.getRoleId();
	        String address = user.getAddress();
	        String department = user.getDepartmentId();
	        String position = user.getPositionId();
	        
	        if (password.equalsIgnoreCase(user.getPassword())) { user.setPassword(password); }
			else { user.setPassword(MD5.getInstance().hashData(password.getBytes())); }
	        
//			String email = request.getParameter("user.email");
//			String emailpas = request.getParameter("user.emailPassword");
//			String emailpass = MD5.getInstance().hashData(emailpas.getBytes());
//			String phone = request.getParameter("user.phone_num");
//			String nickname = request.getParameter("user.nickName");
//			String nicknameEN = request.getParameter("user.nickNameEN");
//			String titlenameTH = request.getParameter("user.titleNameTH");
//			String titlenameEN = request.getParameter("user.titleNameEN");
//			String emailhost = request.getParameter("user.emailHost");
//			String gender = request.getParameter("user.gender");
//			String role = request.getParameter("user.roleId");
//			String address = request.getParameter("user.address");
//			String department = request.getParameter("user.departmentId");
//			String position = request.getParameter("user.positionId");
//			String leaveQuota4 = request.getParameter("user.leaveQuota4");
//			BigDecimal lastYearQuota = new BigDecimal(leaveQuota4);

			user.setTimeCreate(DateUtil.getCurrentTime());
			user.setTimeUpdate(DateUtil.getCurrentTime());
			String bd = this.birthDate; 
	        if (bd != null && !bd.equals("")) {
	            Date birthDate = Convert.parseDate(bd);
	            user.setBirthDate(birthDate);
	        }
	        String sd = this.startDate; 
	        if (sd != null && !sd.equals("")) {
	            Date startDate = Convert.parseDate(sd);
	            user.setStartDate(startDate);
	        }
			user.setEnable("1");
			user.setName(user.getName().trim());
			user.setNameEN(user.getNameEN().trim());
			user.setEmail(email);
//			user.setEmailPassword(emailpass);
			user.setPhonenum(phone);
			user.setNickName(nickname);
			user.setNickNameEN(nicknameEN);
			user.setTitleNameTH(titlenameTH);
			user.setTitleNameEN(titlenameEN);
//			user.setEmailHost(emailhost);
			user.setGender(gender);
			user.setRoleId(role);
			user.setAddress(address);
			user.setDepartmentId(department);
			user.setPositionId(position);
			user.setFlagSearch("1");
//			user.setLeaveQuota4(lastYearQuota);
//			user.setWorkTimeStart("9:00");
//			user.setWorkTimeEnd("18:00");
			user.setSocialSecurity("0");
			user.setWithHoldAuto("0");
			user.setBankType("");
			user.setCitizenId("");
			user.setPassportId("");

			userDAO.save(user);
			
			
			
			if (fileUpload != null) {
	            int maxId = fileuploadDAO.getMaxId() + 1;
	            ServletContext context = request.getServletContext();
	            String fileServerPath = context.getRealPath("/");
	            String newFileName = maxId + "_" + fileUploadFileName;

	            // Upload
	            FileUtil.upload(fileUpload, fileServerPath + "upload/user/", newFileName);

	            // Save File Log
	            FileUpload fileupload = new FileUpload();
	            fileupload.setFileId(maxId);
	            fileupload.setUserId(user.getId());
	            fileupload.setUserCreate(user.getId());
	            
	            // à¹�à¸¢à¸�à¸Šà¸·à¹ˆà¸­à¸�à¸±à¸šà¸™à¸²à¸¡à¸ªà¸�à¸¸à¸¥à¹„à¸Ÿà¸¥à¹Œ
	            String name = fileUploadFileName;
	            String type = "";
	            int split = fileUploadFileName.lastIndexOf(".");
	            if(split >= 0) {
	                 name = fileUploadFileName.substring(0, split);
	                 type = fileUploadFileName.substring(split);
	            }
	            fileupload.setName(name);
	            fileupload.setType(type);
	            fileupload.setSize(fileUploadSize);
	            fileupload.setPath("/upload/user/" + newFileName);
	            fileupload.setTimeCreate(DateUtil.getCurrentTime());
	            fileuploadDAO.save(fileupload);

	            // Update User Path
	            user.setPath("/upload/user/" + newFileName);
	            userDAO.update(user);
	        }
			
			userId = user.getId();

			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();

			request.setAttribute("flag", "1");
			return ERROR;
		}
	}

	public String Edit_myprofile() {
		try {
			User ur = (User) request.getSession().getAttribute("onlineUser");
			String logonUser = ur.getId();
			log.info(logonUser);

			User u = userDAO.findById(user_id);
			log.debug(user_id + " aaa");

			u.setGender(user_gender);
			u.setTitleNameTH(user_titleNameTH);
			u.setName(user_name);/* fullnameTH */
			u.setTitleNameEN(user_titleNameEN);
			u.setNameEN(user_fullNameEN);
			u.setNickName(user_nickNameTH);
			u.setNickNameEN(user_nickNameEN);
			u.setCitizenId(user_citizenId);
			u.setPassportId(user_passportId);
			u.setAddress(user_address);
			u.setPhonenum(user_phonenum);
			u.setEmail(user_email);
			u.setEmergContact(user_emergContact);
			u.setEmergPhone(user_emergPhone);

			String bd = birthDate;
			if (bd != null && !bd.equals("")) {
				Date birthDate = Convert.parseDate(bd);
				u.setBirthDate(birthDate);
			}
			userDAO.update(u);

			FileUpload fileupload = new FileUpload();
			String picture = mypic;
			if ("".equals(picture)) {
				if (fileUpload != null) {
					int maxId = fileuploadDAO.getMaxId() + 1;
					ServletContext context = request.getServletContext();
					String fileServerPath = context.getRealPath("/");
					// long size = fileUpload.getUsableSpace();
					fileupload.setSize(fileUploadSize);
					String fileName = fileUploadFileName;
					fileupload.setPath("/upload/user/" + maxId + "_" + fileName);
					FileUtil.upload(fileUpload, fileServerPath + "upload/user/", maxId + "_" + fileName);

					int l = fileUploadFileName.length();
					int split = fileUploadFileName.indexOf(".");
					String name = fileUploadFileName.substring(0, split);
					String type = (String) fileUploadFileName.subSequence(split, l);

					fileupload.setFileId(maxId);
					fileupload.setUserId(logonUser);
					fileupload.setUserCreate(logonUser);
					fileupload.setName(name);
					fileupload.setType(type);
					fileupload.setTimeCreate(DateUtil.getCurrentTime());
					fileuploadDAO.save(fileupload);

					u.setPath("/upload/user/" + maxId + "_" + fileName);
					userDAO.update(u);
				}
			} else {
				if (fileUpload != null) {
					int maxId = fileuploadDAO.getMaxId();
					ServletContext context = request.getServletContext();
					String fileServerPath = context.getRealPath("/");
					// long size = fileUpload.getUsableSpace();
					fileupload.setSize(fileUploadSize);
					String fileName = fileUploadFileName;
					fileupload.setPath("/upload/user/" + maxId + "_" + fileName);
					FileUtil.upload(fileUpload, fileServerPath + "upload/user/", maxId + "_" + fileName);

					int l = fileUploadFileName.length();
					int split = fileUploadFileName.indexOf(".");
					String name = fileUploadFileName.substring(0, split);
					String type = (String) fileUploadFileName.subSequence(split, l);

					fileupload.setFileId(maxId);
					fileupload.setUserId(logonUser);
					fileupload.setUserCreate(logonUser);
					fileupload.setName(name);
					fileupload.setType(type);
					fileupload.setTimeCreate(DateUtil.getCurrentTime());
					fileuploadDAO.update(fileupload);

					u.setPath("/upload/user/" + maxId + "_" + fileName);
					userDAO.update(u);
				}
			}

			request.setAttribute("logonUser", logonUser);
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	public static final String WORKTIMESTRAT = "work_time_start";
	public static final String WORKTIMEEND = "work_time_end";

	public String open_myprofile() {
		try {

			User ur = (User) request.getSession().getAttribute("onlineUser");
			String logonUser = ur.getId();
			request.setAttribute("logonUser", logonUser);

			userId = ur.getId();
			user = userDAO.findById(userId);

			List<Department> departmentList = departmentDAO.findAll();

			request.setAttribute("user", user);
			request.setAttribute("userList", userDAO.findAll());
			request.setAttribute("departmentList", departmentList);
			request.setAttribute("roleList", roleDAO.findAll());
			request.setAttribute("borrowList", borrowDAO.findBorrowByUser(userId));

			int yearNow = DateUtil.checkCurrentYear();
			if (yearNow > 2500) {
				yearNow = yearNow - 543;
			}

			List<Map<String, Object>> myleaves = newsDAO.totallyleaves(logonUser, yearNow);
			request.setAttribute("myleaves", myleaves);

			List<Map<String, Object>> myobtainMoney = newsDAO.obtainTravel(logonUser);
			request.setAttribute("myobtainMoney", myobtainMoney);

			List<Map<String, Object>> mytravel = newsDAO.totaltravel(logonUser);
			request.setAttribute("mytravel", mytravel);

			List<Borrow> borrows = borrowDAO.findBorrowByUser(onlineUser.getId());

			log.info("borrows=" + borrows);

			List<Equipment> equipments = new ArrayList<Equipment>();
			for (int i = 0; i < borrows.size(); i++) {
				String equipment_id = borrows.get(i).getEquipmentId();
				Equipment equipments2 = equipmentDAO.getById(Integer.parseInt(equipment_id));
				log.info("equipments2=" + equipments2);
				equipments.add(equipments2);
				log.info("equipments=" + equipments);
			}
			request.setAttribute("equipments", equipments);

			List<Map<String, Object>> TimeUserWork = userDAO.findTimeUserWork(logonUser);
			String TimeStratWork = (String) TimeUserWork.get(0).get(WORKTIMESTRAT);
			String TimeEndWork = (String) TimeUserWork.get(0).get(WORKTIMEEND);

			String tF = "0", tL = ":00", timeS = null, timeE = null;

			if (TimeStratWork.equals("0:00") || TimeStratWork.equals("00:00")) {
				request.setAttribute("TimeStratWork", "*");

			} else if (TimeStratWork.length() == 4 || TimeStratWork.equals("8:00") || TimeStratWork.equals("9:00")
					|| TimeStratWork.equals("8:30")) {

				timeS = tF + TimeStratWork;
				request.setAttribute("TimeStratWork", timeS);
			} else if (TimeStratWork.length() == 5 || TimeStratWork.equals("08:00") || TimeStratWork.equals("09:00")
					|| TimeStratWork.equals("08:30")) {
				timeS = tF + TimeStratWork;
				request.setAttribute("TimeStratWork", timeS);
			}

//			String tF = "0", tE = "0", timeS = null, timeE = null;
//			// 0:00 08:00 09:00 9:00 8:00
//			if (TimeStratWork.equals("8:00")) {
//				timeS = tF + TimeStratWork;
//				request.setAttribute("TimeStratWork", timeS);
//			} else if (TimeStratWork.equals("08:00")) {
//				timeS = TimeStratWork;
//				request.setAttribute("TimeStratWork", timeS);
//			} else if (TimeStratWork.equals("9:00")) {
//				timeS = tF + TimeStratWork;
//				request.setAttribute("TimeStratWork", timeS);
//			} else if (TimeStratWork.equals("09:00")) {
//				timeS = TimeStratWork;
//				request.setAttribute("TimeStratWork", timeS);
//			} else if (TimeStratWork.equals("8:30")) {
//				timeS = tF + TimeStratWork;
//				request.setAttribute("TimeStratWork", timeS);
//			} else if (TimeStratWork.equals("08:30")) {
//				timeS = TimeStratWork;
//				request.setAttribute("TimeStratWork", timeS);
//			} else {
//
//				request.setAttribute("TimeStratWork", "*");
//			}
//
			if (TimeEndWork.equals("0:00") || TimeEndWork.equals("00:00")) {
				request.setAttribute("TimeEndWork", "*");
			} else {
				request.setAttribute("TimeEndWork", TimeEndWork);
			}

			myleave();
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	public void user_notifi() {

		try {
			String b = request.getParameter("user.id");
			Map<String, String> obj = new HashMap<>();
			List<Map<String, Object>> user = userDAO.findById2(b);
			String s = user.toString();
			if (s.equals("[]")) {
				String x = "0";
				obj.put("flag", x);
			} else {
				String a = "1";
				obj.put("flag", a);
			}
			Gson gson = new GsonBuilder().setDateFormat("dd/MM/yyyy HH:mm:ss").create();
			String jsonObjStr = gson.toJson(obj);
			PrintWriter out = response.getWriter();
			out.print(jsonObjStr);
			out.flush();
			out.close();
			// Gson gson = new GsonBuilder().setDateFormat("dd/MM/yyyy
			// HH:mm:ss").create();
			// String jsonObjStr = gson.toJson(mapObj);
		}

		catch (Exception e) {
			e.printStackTrace();

		}

	}

	public String keepfacebook() throws Exception {
		try {
			String userid = request.getParameter("userid");
			String facebookid = request.getParameter("id");
			User u = userDAO.findById(userid);
			// log.debug(userid + " aa");
			// log.debug(facebookid + "st");

			u.setFacebookid(facebookid);
			userDAO.update(u);

			userId = user.getId();
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}

	}
	
	//SearchUser
	public String searchUser() {
	    try {
	        String userID = request.getParameter("user_id");
	        User user = userDAO.findById(userID);
	        String json = new com.google.gson.Gson().toJson(user);

	        response.setContentType("application/json; charset=UTF-8");
	        response.getWriter().write(json);
	        return NONE;   // Ã Â¸Ë†Ã Â¸Å¡Ã Â¸â€”Ã Â¸ÂµÃ Â¹Ë†Ã Â¸â„¢Ã Â¸ÂµÃ Â¹Ë† Ã Â¹â€žÃ Â¸Â¡Ã Â¹Ë† forward
	    } catch (Exception e) {
	        response.setStatus(500);
	        response.setContentType("application/json; charset=UTF-8");
	        return NONE;
	    }
	}


	public String setFlagsearch() {
		try {
			String id = request.getParameter("id");
			user = userDAO.findById(id);
			log.debug(user);
			user.setFlagSearch("0");
			userDAO.update(user);
			return SUCCESS;
		} catch (Exception e) {
			return ERROR;
		}
	}

	public String deleteUser() {
		try {
			String id = request.getParameter("id");
			this.userId = id;
			
			List<Map<String, Object>> history = workHoursDAO.checkIn(id);
			if (history != null && !history.isEmpty()) {
				ServletActionContext.getResponse().setStatus(400);	            
				List<User> userList = userDAO.findAll();
	            request.setAttribute(User, userList);
	            
	            return ERROR;
	        }
			
			User user = new User();
			user = userDAO.findById(id);
			log.debug(user);
			userDAO.delete(user);
			List<User> userList = userDAO.findAll();
			request.setAttribute(User, userList);
			return SUCCESS;
		} catch (Exception e) {
			return ERROR;
		}
	}

	public String myleave() {
		try {
			User ur = new User();
			String userLogin = null;
			String type = request.getParameter("type");
			if (type == null) {
				ur = (User) request.getSession().getAttribute("onlineUser");
				userLogin = ur.getId();
			} else {
				userLogin = request.getParameter("name1");
			}

			String listbyuser = request.getParameter("Id");

			DateTimeFormatter date1 = DateTimeFormatter.ofPattern("01-01-yyyy");
			LocalDate localDate = LocalDate.now();
			String s = "00:00:00.0";

			String start = request.getParameter("startdate");
			String end = request.getParameter("enddate");
			Timestamp start_date;
			Timestamp end_date;
			if (start == null && end == null) {
				start_date = DateUtil.dateToTimestamp(date1.format(localDate), s);
				end_date = DateUtil.changetoEndYear(date1.format(localDate));
			} else {
				start_date = DateUtil.dateFormatEdit(start);
				end_date = DateUtil.dateFormatEdit(end);
			}

			Date enddate = new Date(end_date.getTime());
			request.setAttribute("enddate", enddate);

			if (userLogin != listbyuser) {
				listbyuser = userLogin;
			}

			List<LeaveType> type_leave = leavetypeDAO.findAll_calendar();
			for (int i = 0; i < type_leave.size(); i++) {
				LeaveType leave = type_leave.get(i);
				request.setAttribute("type_" + leave.getLeaveTypeId(), leave.getLeaveTypeName());
			}
			List leavelist = leaveDAO.myLeavesList(userLogin, start_date, end_date);
			String status = "1";
			List leaveListDashboard = leaveDAO.myLeavesList(userLogin, start_date, end_date, status);

			request.setAttribute("leavelist", leavelist);

			Double leave_1 = 0.000, leave_2 = 0.000, leave_3 = 0.000, leave_5 = 0.000, leave_6 = 0.000;

			for (Iterator iterator = leavelist.iterator(); iterator.hasNext();) {
				Leaves leave = (Leaves) iterator.next();
			}

			for (Iterator iterator = leaveListDashboard.iterator(); iterator.hasNext();) {
				Leaves leaveDashboard = (Leaves) iterator.next();
				Double noday = leaveDashboard.getNoDay().doubleValue();
				if (leaveDashboard.getLeaveTypeId().contains("1")) {
					leave_1 = leave_1 + noday;
				}
				if (leaveDashboard.getLeaveTypeId().contains("2")) {
					leave_2 = leave_2 + noday;
				}
				if (leaveDashboard.getLeaveTypeId().contains("3")) {
					leave_3 = leave_3 + noday;
				}
				if (leaveDashboard.getLeaveTypeId().contains("5")) {
					leave_5 = leave_5 + noday;
				}
				if (leaveDashboard.getLeaveTypeId().contains("6")) {
					leave_6 = leave_6 + noday;
				}
			}

			request.setAttribute("leave_1", leave_1);
			request.setAttribute("leave_2", leave_2);
			request.setAttribute("leave_3", leave_3);
			request.setAttribute("leave_5", leave_5);
			request.setAttribute("leave_6", leave_6);

			DateTimeFormatter year2 = DateTimeFormatter.ofPattern("yyyy");
			Date day = new Date(System.currentTimeMillis());
			int year = Integer.parseInt(day.toString().substring(0, 4));
			Double quotaLastYear = leaveDAO.LastYearQuota(userLogin, year);
			Double quotaThisYear = leaveDAO.ThisYearQuota(userLogin);
			request.setAttribute("quotaThisYear", quotaThisYear);
			request.setAttribute("quotaLastYear", quotaLastYear);
			request.setAttribute("leave_6l", quotaLastYear - leave_6);

			Timestamp tend = Timestamp.valueOf(year + "-04-01 00:00:00"); // time end is april month
			Timestamp tnow = new Timestamp(day.getTime());

			request.setAttribute("tnow", tnow);
			request.setAttribute("tend", tend);

			String leave_7 = leaveDAO.sumWaitLeave(userLogin);
			request.setAttribute("leave_7", leave_7);

			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	public String BirthdaySummary() {
		try {

			List<Map<String, Object>> bd = userDAO.test_birthdaysummary();
			request.setAttribute("bd", bd);
			log.info("bd=" + bd);

			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	public String list2() {
		try {
			List<Map<String, Object>> cubesoftUsers = userDAO.Query_Userlist2();
			request.setAttribute("cubesoftUsers", cubesoftUsers);
			// request.setAttribute("userList", userDAO.findAll());
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	public String updateGender() {

		try {
			String gender = request.getParameter("gender");
			String[] setgender = gender.split("/");
			boolean result = false;
			/* System.out.println("setgender : " + setgender[1]); */
			if (setgender[1].equals("M") || setgender[1].equals("F")) {
				List<Map<String, Object>> user = userDAO.getGender(setgender);
				request.setAttribute("datauser", user);
				log.info(user);
				if (user.isEmpty() == false) {
					/* System.out.println(user.isEmpty()); */
					List<Map<String, Object>> xxx = userDAO.updateGender(setgender);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}

		return null;
	}

	public String jobsite_list() {
		try {
			List<Map<String, Object>> jslist = jobsiteDAO.findAll();
			request.setAttribute("jobsitelist", jslist);

			List<Map<String, Object>> cubesoftUsers = jobsiteDAO.findAll2();
			request.setAttribute("cubesoftUsers", cubesoftUsers);
			// request.setAttribute("userList", userDAO.findAll());
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	public String addjobsite() {
		try {
			String userlist = request.getParameter("userid");
			String namesite = request.getParameter("namesite");
			System.out.println(userlist);
			System.out.println(namesite);
			System.out.println("------------------");

			String[] userarrey = userlist.split(",");

			int namesite2 = Integer.parseInt(namesite);
			for (int i = 0; i < userarrey.length; i++) {
				String usersite = (userarrey[i]);

				User u = userDAO.findById(usersite);
				u.setId_sitejob(namesite2);
				userDAO.update(u);
			}

			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	public String deletejobsite() {
		try {
			String userid = request.getParameter("id");
			User u = userDAO.findById(userid);
			u.setId_sitejob(null);
			userDAO.update(u);
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}
	

	public String my_profile() {
		try {
			User ur = (User) request.getSession().getAttribute("onlineUser");
			String logonUser = ur.getId();

			User u = userDAO.findById(logonUser);

			List<Map<String, Object>> managerList = userDAO.getManagerByUserId(logonUser);
			Map<String, Object> manager = null;

			if (managerList != null && !managerList.isEmpty()) {
				manager = managerList.get(0);
			}
			request.setAttribute("manager", manager);

			List<Map<String,Object>> jobSite = jobsiteDAO.getJobSiteByUserId(logonUser);
			request.setAttribute("jobSite", jobSite);

			String workPeriod = "-";

	        if (u.getStartDate() != null) {
	        	GregorianCalendar start = new GregorianCalendar(Locale.US);
	        	start.setTime(u.getStartDate());

	        	GregorianCalendar now = new GregorianCalendar(Locale.US);

	            long diffMillis = now.getTimeInMillis() - start.getTimeInMillis();
	            long oneDayMillis = 1000L * 60 * 60 * 24;

	            boolean isToday = diffMillis < oneDayMillis;

	            if (isToday) {
	                workPeriod = "Starting";
	            } else {
	                int years = now.get(Calendar.YEAR) - start.get(Calendar.YEAR);
	                int months = now.get(Calendar.MONTH) - start.get(Calendar.MONTH);

	                if (months < 0) {
	                    years--;
	                    months += 12;
	                }

	                Calendar temp = (Calendar) start.clone();
	                temp.add(Calendar.YEAR, years);
	                temp.add(Calendar.MONTH, months);

	                long remainMillis = now.getTimeInMillis() - temp.getTimeInMillis();
	                long days = remainMillis / oneDayMillis;

	                if (years == 0 && months == 0) {
	                    workPeriod = days + "d";
	                } else if (years == 0) {
	                    workPeriod = months + "m " + days + "d";
	                } else {
	                    workPeriod = years + "y " + months + "m";
	                }
	            }
	        }
	        
			LocalDate start = u.getStartDate().toLocalDate();
			LocalDate now = LocalDate.now();

			Period p = Period.between(start, now);

			if (p.getYears() == 0 && p.getMonths() == 0) {
			    workPeriod = p.getDays() + "d";
			} else if (p.getYears() == 0) {
			    workPeriod = p.getMonths() + "m " + p.getDays() + "d";
			} else {
			    workPeriod = p.getYears() + "y " + p.getMonths() + "m";
			}

			
	        List<Map<String,Object>> borrow = borrowDAO.getBorrowListByUserId(logonUser);
			
			if (borrow != null && !borrow.isEmpty()) {
				SimpleDateFormat inputDate =
				        new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
				inputDate.setCalendar(new GregorianCalendar());

				SimpleDateFormat outputDate =
				        new SimpleDateFormat("dd MMM yyyy", Locale.ENGLISH);
				outputDate.setCalendar(new GregorianCalendar());

				
				for(Map<String, Object> row: borrow) {
					Object dateStartObj = row.get("time_create");
					if(dateStartObj == null) {
						continue;
					}
					 String dt = dateStartObj.toString();         
					 String[] parts = dt.split(" ");
					 
					 String datePart = parts[0]; 
					 String timePart = parts[1].split("\\.")[0];
					 
					 java.util.Date date = inputDate.parse(datePart);

					 row.put("formatted_date", outputDate.format(date));
					 row.put("formatted_time", timePart);
				}
				
				request.setAttribute("borrowList", borrow);
			}else {
				request.setAttribute("borrowList", borrow);
			}

	       request.setAttribute("workPeriod", workPeriod);
			request.setAttribute("user", u);

			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}
	
	public String update_my_profile() {
	    try {
	        User ur = (User) request.getSession().getAttribute("onlineUser");
	        String logonUser = ur.getId();

			User u = userDAO.findById(logonUser);

	        if (u != null) {
	        	if(avatar_remove != null && avatar_remove.equalsIgnoreCase("true")) {
	        		u.setPath(null);
	        		
	        	}else if (fileUpload != null) {
	                int maxId = fileuploadDAO.getMaxId() + 1;
	                String fileServerPath = request.getServletContext().getRealPath("/");
	                String newFileName = maxId + "_" + fileUploadFileName;
	                String originalName = fileUploadFileName;
	                String fileName = originalName.substring(0,originalName.lastIndexOf("."));
					String typeFile = originalName.substring(originalName.lastIndexOf("."));
					
					long fileSize = fileUpload.length(); //byte
	                double sizeKB = fileSize / 1024.0;
	                double sizeMB = fileSize / (1024.0 * 1024.0);
	                String sizeText;
	                if (fileSize < 1024) {
	                    sizeText = fileSize + " B";
	                } else if (fileSize < 1024 * 1024) {
	                    sizeText = String.format("%.2f KB", sizeKB);
	                } else {
	                    sizeText = String.format("%.2f MB", sizeMB);
	                }

	                FileUtil.upload(fileUpload, fileServerPath + "upload/user/", newFileName);

	                FileUpload file = new FileUpload();
	                file.setFileId(maxId);
	                file.setUserId(u.getId());
	                file.setName(fileName);
					file.setPage("user");
					file.setPageId(null);
					file.setUserId(logonUser);
					file.setType(typeFile);
					file.setSize(sizeText);
					file.setAltName(null);
					file.setUserCreate(logonUser);
					file.setPath("/upload/user/" + newFileName);
					file.setTimeCreate(DateUtil.getCurrentTime());
	                fileuploadDAO.save(file);

	                u.setPath("/upload/user/" + newFileName);
	            }

	            u.setName(this.user_name);
	            u.setNickName(this.user_nickName);
	            u.setNameEN(this.user_fullNameEN);
	            u.setNickNameEN(this.user_nickNameEN);
	            u.setGender(this.user_gender);
	            u.setCitizenId(this.user_citizenId); 
	            u.setPassportId(this.user_passportId);
	            u.setEmail(this.user_email);
	            u.setPhonenum(this.user_phonenum);
	            u.setAddress(this.user_address);
	            u.setEmergContact(this.user_emergContact);
	            u.setEmergPhone(this.user_emergPhone);
	            u.setTimeUpdate(DateUtil.getCurrentTime());

	            if (this.user_birthDate != null && !this.user_birthDate.isEmpty()) {
	                SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy", Locale.ENGLISH);
	                java.util.Date bDate = sdf.parse(this.user_birthDate);
	                u.setBirthDate(new java.sql.Date(bDate.getTime()));
	            }

	            userDAO.update(u); 
	        }
	        
	        return SUCCESS;

	    } catch (Exception e) {
	        e.printStackTrace();
	        return ERROR;
	    }
	}
	
//	public String update_my_profile() {
//		try {
//			User ur = (User) request.getSession().getAttribute("onlineUser");
//			String logonUser = ur.getId();
//			User u = userDAO.findById(logonUser);
//			if(fileUpload != null) {
//				String originalName = fileUploadFileName;
//				String fileName = originalName.substring(0,originalName.lastIndexOf("."));
//				String typeFile = originalName.substring(originalName.lastIndexOf("."));
//				long fileSize = fileUpload.length();
//				
//				FileUpload file = new FileUpload();
//				file.setPage("myProfile");
//				file.setPageId(null);
//				file.setUserId(logonUser);
//				file.setName(fileName);
//				file.setType(typeFile);
//				file.setSize(String.valueOf(fileSize));
//				file.setAltName(null);
//				file.setUserCreate(logonUser);
//				file.setUserUpdate(logonUser);
//				file.setTimeCreate(DateUtil.getCurrentTime());
//				
//			//	long fileId = fileuploadDAO.save(file);
//				
//			}
//
//
//			String user_titleNameTH = request.getParameter("user_titleNameTH");
//			String user_name = request.getParameter("user_name");
//			String user_nickName = request.getParameter("user_nickName");
//			String user_titleNameEN = request.getParameter("user_titleNameEN");
//			String user_nameEN = request.getParameter("user_nameEN");
//			String user_nickNameEN = request.getParameter("user_nickNameEN");
//			String user_gender = request.getParameter("user_gender");
//			String user_citizenId = request.getParameter("user_citizenId");
//			String user_passportId = request.getParameter("user_passportId");
//			String user_email = request.getParameter("user_email");
//			String user_phonenum = request.getParameter("user_phonenum");
//			String user_address = request.getParameter("user_address");
//			String user_emergContact = request.getParameter("user_emergContact");
//			String user_emergPhone = request.getParameter("user_emergPhone");
//			
//
////			User u = new User();
//			u.setId(logonUser);
//			u.setTitleNameTH(user_titleNameTH);
//			u.setName(user_name);
//			u.setNickName(user_nickName);
//			u.setTitleNameEN(user_titleNameEN);
//			u.setNameEN(user_nameEN);
//			u.setNickNameEN(user_nickNameEN);
//			u.setGender(user_gender);
//			u.setCitizenId(user_citizenId);
//			u.setPassportId(user_passportId != null && !user_passportId.isEmpty() ? user_passportId : "-");
//			u.setEmail(user_email);
//			u.setPhonenum(user_phonenum);
//			u.setAddress(user_address != null && !user_address.isEmpty() ? user_address : null);
//			u.setEmergContact(user_emergContact != null && !user_emergContact.isEmpty() ? user_emergContact : null);
//			u.setEmergPhone(user_emergPhone != null && !user_emergPhone.isEmpty() ? user_emergPhone : null);
//			u.setTimeUpdate(DateUtil.getCurrentTime());
//
//			
//			String birthDateStr = request.getParameter("user_birthDate");
//			if (birthDateStr != null && !birthDateStr.trim().isEmpty()) {
//				SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy", Locale.ENGLISH);
//				java.util.Date utilDate = sdf.parse(birthDateStr); // แปลง string เป็น java.util.Date
//				java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime()); // แปลงเป็น java.sql.Date
//				u.setBirthDate(sqlDate);
//			} else {
//				u.setBirthDate(null);
//			}
//			userDAO.update_my_profile(u);
//
//			return SUCCESS;
//		} catch (Exception e) {
//			e.printStackTrace();
//			return ERROR;
//		}
//	}
	
	public String validate_current_password() {
	    try {
	        User onlineUser = (User) request.getSession().getAttribute("onlineUser");
	        String currentPw = request.getParameter("currentPw");

	        Map<String, Object> result = new HashMap<>();
	        boolean isValid = false;

	        if (onlineUser != null && currentPw != null && !currentPw.isEmpty()) {
	            User u = userDAO.findById(onlineUser.getId());
	            String inputHash = MD5.getInstance().hashData(currentPw.getBytes());
	            isValid = inputHash.equals(u.getPassword());
//	            System.out.println("--------------- " );
//	            System.out.println("Input Hash: " + inputHash);
//		        System.out.println("DB Hash   : " + u.getPassword());
//		        System.out.println("Is valid  : " + isValid);
	        }
	       

	        result.put("valid", isValid);

	        response.setContentType("application/json; charset=UTF-8");
	        response.getWriter().write(new Gson().toJson(result));

	        return NONE;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return NONE;
	    }
	}
	
	public String update_password() {
		try {
			User ur = (User) request.getSession().getAttribute("onlineUser");
			String logonUser = ur.getId();
			
			String currentPw = request.getParameter("currentPw");
	        String newPw = request.getParameter("newPw");
			
	        User dbUser = userDAO.findById(logonUser);
	        
	        String hashedCurrentPw = MD5.getInstance().hashData(currentPw.getBytes()); 
	        boolean match = hashedCurrentPw.equals(dbUser.getPassword());
	        
	        if(match) {
	        	String hashedNewPassword = MD5.getInstance().hashData(newPw.getBytes());
	        	dbUser.setPassword(hashedNewPassword);
	            userDAO.update(dbUser);
	        	
	        }
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}
	
	
}