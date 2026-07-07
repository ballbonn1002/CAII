package com.cubesofttech.action;

import java.io.File;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.Period;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
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
import java.util.UUID;
import java.util.stream.Collectors;
import java.util.GregorianCalendar;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.cubesofttech.dao.WorkHoursDAO;
import com.cubesofttech.dao.ArticleDAO;
import com.cubesofttech.dao.ArticleImageDAO;
import com.cubesofttech.dao.ArticleRelatedDAO;
import com.cubesofttech.dao.ArticleTagDAO;
import com.cubesofttech.dao.ArticleTypeDAO;
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
import com.cubesofttech.dao.TagDAO;
import com.cubesofttech.dao.UserDAO;
import com.cubesofttech.model.Article;
import com.cubesofttech.model.ArticleRelated;
import com.cubesofttech.model.ArticleTag;
import com.cubesofttech.model.ArticleType;
import com.cubesofttech.model.Borrow;
import com.cubesofttech.model.Department;
import com.cubesofttech.model.Equipment;
import com.cubesofttech.model.FileUpload;
import com.cubesofttech.model.JobSiteTeam;
import com.cubesofttech.model.LeaveType;
import com.cubesofttech.model.Leaves;
import com.cubesofttech.model.Position;
import com.cubesofttech.model.Role;
import com.cubesofttech.model.Tag;
import com.cubesofttech.model.User;
import com.cubesofttech.system.Constant;
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
	
	@Autowired
	private Constant constant;

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
	private String signature_remove;

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

	public String getSignature_remove() {
		return signature_remove;
	}

	public void setSignature_remove(String signature_remove) {
		this.signature_remove = signature_remove;
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
	private String user_line_id;
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
	private String pathSignature;

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
	
	public String getPathSignature() {
		return pathSignature;
	}

	public void setPathSignature(String pathSignature) {
		this.pathSignature = pathSignature;
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

	public String getUser_line_id() {
		return user_line_id;
	}

	public void setUser_line_id(String user_line_id) {
		this.user_line_id = user_line_id;
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
								if (sb.length() > 0)
									sb.append(", ");
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

				String imgPath = null;
				Object pathObj = map.get("path");
				if (pathObj != null) {
					String path = pathObj.toString();
					try {
						String originalFileName = new File(path).getName();
						if (path.contains("_") && !originalFileName.startsWith("user_")) {
							String fileIdStr = originalFileName.substring(0, originalFileName.indexOf("_"));
							int fileId = Integer.parseInt(fileIdStr);
							String typeFile = originalFileName.substring(originalFileName.lastIndexOf("."));
							imgPath = "/upload/user/user_" + fileId + typeFile;
						} else {
							imgPath = path;
						}
						
						// Verify physical existence but don't strictly nullify if missing, 
						// as the file might be hosted externally or the context path is different.
						String server = request.getServletContext().getRealPath("/");
						File f = new File(server + imgPath);
						if (!f.exists()) {
							// If we want to strictly fallback to initial letters when file is missing:
							imgPath = null;
						}
					} catch (Exception e) {
						imgPath = null;
					}
				}
				map.put("ListUserImgPath", imgPath);

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
				Object posObj = map.get("name_position");
				String positionName = posObj != null ? posObj.toString() : "";
				map.put("position_name", positionName);
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
			String id = request.getParameter("userId");

			List<Map<String, Object>> jobsiteList = jobsiteDAO.findJobsiteUser(id);
			request.setAttribute("test", jobsiteList);
			List<Map<String, Object>> jobSite = jobsiteDAO.getJobSiteByUserId(id);
			request.setAttribute("jobSite", jobSite);
			

			List<Map<String, Object>> departmentList = departmentDAO.findAllList();

			List<Map<String, Object>> positionList = positionDAO.sequense();

			request.setAttribute("positionList", positionList);

			request.setAttribute("departmentList", departmentList);

			List<Role> roleList = roleDAO.findAll();
			request.setAttribute("roleList", roleList);

			request.setAttribute("userList", userDAO.sequense());

			String workPeriod = "-";
			if (selectUser.getStartDate() != null) {
				LocalDate start = selectUser.getStartDate().toLocalDate();
				LocalDate now = LocalDate.now();
				Period p = Period.between(start, now);

				if (start.isAfter(now)) {
					workPeriod = "Waiting to start...";
				} else {

					if (p.getYears() == 0 && p.getMonths() == 0) {
						workPeriod = p.getDays() + "d";
					} else if (p.getYears() == 0) {
						workPeriod = p.getMonths() + "m " + p.getDays() + "d";
					} else {
						workPeriod = p.getYears() + "y " + p.getMonths() + "m";
					}
				}
			}
			request.setAttribute("workPeriod", workPeriod);

			List<Map<String, Object>> leavwait = leaveDAO.listwaitperson(String.valueOf(userId));
			List<Map<String, Object>> leavhis = leaveDAO.listoneperson(String.valueOf(userId));
			int sum_w = leavwait.size();
			int sum_h = leavhis.size();
			request.setAttribute("leaveW", sum_w);
			request.setAttribute("leaveH", sum_h);

			List<Map<String, Object>> borrow = borrowDAO.getBorrowListByUserId(selectUser.getId());

			if (borrow != null && !borrow.isEmpty()) {
				SimpleDateFormat inputDate = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
				inputDate.setCalendar(new GregorianCalendar());

				SimpleDateFormat outputDate = new SimpleDateFormat("dd MMM yyyy", Locale.ENGLISH);
				outputDate.setCalendar(new GregorianCalendar());

				for (Map<String, Object> row : borrow) {
					Object dateStartObj = row.get("time_create");
					if (dateStartObj == null) {
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
			} else {
				request.setAttribute("borrowList", borrow);
			}


			String imgPath = null;
			if (selectUser.getPath() != null) {
				String path = selectUser.getPath();
				try {
					String originalFileName = new File(path).getName();
					if (path.contains("_") && !originalFileName.startsWith("user_")) {
						String fileIdStr = originalFileName.substring(0, originalFileName.indexOf("_"));
						int fileId = Integer.parseInt(fileIdStr);
						String typeFile = originalFileName.substring(originalFileName.lastIndexOf("."));
						imgPath = "/upload/user/user_" + fileId + typeFile;
					} else {
						imgPath = path;
					}
					
					String server = request.getServletContext().getRealPath("/");
					File f = new File(server + imgPath);
					if (!f.exists()) {
						imgPath = null;
					}
				} catch (Exception e) {
					imgPath = null;
				}
			}

			String imgPathSignature = null;
			String signatureFileName = null;
			if (selectUser.getPathSignature() != null && selectUser.getPathSignature().contains("_")) {
				try {
					String originalFileName = new File(selectUser.getPathSignature()).getName();
					String fileIdStr = originalFileName.substring(0, originalFileName.indexOf("_"));
					String typeFile = originalFileName.substring(originalFileName.lastIndexOf("."));

					imgPathSignature = "/upload/user/user_signature_" + fileIdStr + typeFile;

					String server = request.getServletContext().getRealPath("/");
					File f = new File(server + imgPathSignature);
					if (!f.exists()) {
						imgPathSignature = null;
					}

					FileUpload file = fileuploadDAO.findById(Integer.parseInt(fileIdStr));
					if (file != null) {
			            signatureFileName = file.getName()+file.getType();  
			        }
					
				} catch (Exception e) {
					imgPathSignature = null;
				}
			}

			request.setAttribute("selectUser", selectUser);
			request.setAttribute("editUserImgPath", imgPath);
			request.setAttribute("editUserImgPathSignature", imgPathSignature);
			request.setAttribute("editSignatureFileName", signatureFileName);

			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	public String open() {
		try {

			List<Map<String, Object>> departmentList = departmentDAO.findAllList();

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

			if (user == null || user.getId() == null || user.getId().trim().isEmpty()) {
				log.error("User id is null from request");
				return ERROR;
			}

			String UserIdEdit = user.getId().trim();
			User u = userDAO.findById(UserIdEdit);

			String rawSiteJob = (id_sitejob == null) ? "" : id_sitejob.trim();

			String[] siteJobId = rawSiteJob.isEmpty() ? new String[0] : rawSiteJob.split(",");
			List<JobSiteTeam> ListuserId = jobSiteTeamDAO.findAllByUserId(UserIdEdit);

			List<String> selectedSiteIds = new ArrayList<>();

			if (siteJobId != null) {
				for (String s : siteJobId) {
					if (s != null && !s.trim().isEmpty()) {
						selectedSiteIds.add(s.trim());
					}
				}
			}

			// เพิ่มsiteใหม่ที่ยังไม่มีในDB
			for (String siteId : selectedSiteIds) {
				JobSiteTeam existing = jobSiteTeamDAO.findByIdSiteJobAndUserId(siteId, UserIdEdit);

				if (existing == null) {
					JobSiteTeam jobSiteTeam = new JobSiteTeam();
					jobSiteTeam.setUser_id(UserIdEdit);
					jobSiteTeam.setId_sitejob(siteId);
					jobSiteTeamDAO.save(jobSiteTeam);
				}
			}

			// ลบsiteเดิมที่ไม่ได้ถูกเลือก
			for (JobSiteTeam link : ListuserId) {
				if (!selectedSiteIds.contains(link.getId_sitejob())) {
					jobSiteTeamDAO.delete(link);
				}
			}

			if (avatar_remove != null && avatar_remove.equalsIgnoreCase("true")) {
				u.setPath(null);

			} else if (fileUpload != null) {
				int maxId = fileuploadDAO.getMaxId() + 1;
				String fileServerPath = request.getServletContext().getRealPath("/");
				String originalName = fileUploadFileName;
				String fileName = originalName.substring(0, originalName.lastIndexOf("."));
				String typeFile = originalName.substring(originalName.lastIndexOf("."));

				if (fileName.contains(" ")) {
					fileName = fileName.trim().replaceAll(" ", "_");
				}

				String newFileName = maxId + "_" + fileName + typeFile;
				String serverFileName = "user_" + maxId + typeFile;

				long fileSize = fileUpload.length(); // byte
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

				FileUtil.upload(fileUpload, fileServerPath + "upload/user/", serverFileName);

				FileUpload file = new FileUpload();
				file.setFileId(maxId);
				file.setUserId(u.getId());
				file.setName(fileName);
				file.setPage("user");
				file.setPageId(u.getId());
				file.setUserId(logonUser);
				file.setType(typeFile);
				file.setSize(sizeText);
				file.setAltName(null);
				file.setUserCreate(logonUser);
				file.setUserUpdate(logonUser);
				file.setPath("/upload/user/" + newFileName);
				file.setTimeCreate(DateUtil.getCurrentTime());
				file.setTimeUpdate(DateUtil.getCurrentTime());
				fileuploadDAO.save(file);

				u.setPath("/upload/user/" + newFileName);

			}

			u.setName(user.getName().replaceAll("[\\t\\n\\r]+", " ")
		              .replaceAll("\\s{2,}", " ").trim());
			u.setNickName(user.getNickName().replaceAll("[\\t\\n\\r]+", " ")
		              .replaceAll("\\s{2,}", " ").trim());
			u.setUsername(user_username);
			u.setEmail(user_email);
			u.setManagerId(user.getManagerId());
			u.setId_sitejob(user.getId_sitejob());
			u.setAddress(user.getAddress());
			u.setTimeUpdate(DateUtil.getCurrentTime());

			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
			if (this.startDate != null && !this.startDate.isEmpty()) {
				u.setStartDate(new java.sql.Date(sdf.parse(this.startDate).getTime()));
			}
			if (this.birthDate != null && !this.birthDate.isEmpty()) {
				u.setBirthDate(new java.sql.Date(sdf.parse(this.birthDate).getTime()));
			}
			if (this.endDate != null) {
				if (!this.endDate.isEmpty()) {
					u.setEndDate(new java.sql.Date(sdf.parse(this.endDate).getTime()));
				} else {
					u.setEndDate(null);
				}
			}

			u.setSocialSecurity(user.getSocialSecurity() != null ? user.getSocialSecurity() : "0");
			u.setWithHoldAuto(user.getWithHoldAuto() != null ? user.getWithHoldAuto() : "0");

			if (user.getRoleId() != null)
				u.setRoleId(user.getRoleId());
			if (department_id != null)
				u.setDepartmentId(department_id);
			if (position_id != null)
				u.setPositionId(position_id);

			if (page.equals("1")) {
				u.setEmailHost(user.getEmailHost());
			} else if (page.equals("2")) {
				u.setEnable(user.getEnable());
				u.setEmailEnable(user.getEmailEnable());
				u.setEmployeeId(user.getEmployeeId());
				u.setWorkDayStart(user.getWorkDayStart());
				u.setWorkDayEnd(user.getWorkDayEnd());
				u.setWorkTimeStart(user.getWorkTimeStart());
				u.setWorkTimeEnd(user.getWorkTimeEnd());

				u.setWorkType(user.getWorkType());
				u.setOnsiteNum(user.getOnsiteNum());
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
				u.setNameEN(user.getNameEN().replaceAll("[\\t\\n\\r]+", " ")
			              .replaceAll("\\s{2,}", " ").trim());
				u.setNickNameEN(user.getNickNameEN().replaceAll("[\\t\\n\\r]+", " ")
			              .replaceAll("\\s{2,}", " ").trim());
				u.setEmergContact(user.getEmergContact());
				u.setEmergPhone(user.getEmergPhone());
				u.setEmployeeTypeId(user.getEmployeeTypeId());
				u.setEmployeeStatus(user.getEmployeeStatus());
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

			// ถ้าแก้ของตัวเอง(user ที่กำลังlogin)
			HttpSession session = request.getSession();
			User onlineUser = (User) session.getAttribute("onlineUser");
			if (onlineUser != null && onlineUser.getId().equals(u.getId())) {

				onlineUser.setPath(u.getPath());
				onlineUser.setWorkType(u.getWorkType());

				String imgPathForSession = null;
				if (u.getPath() != null && u.getPath().contains("_")) {
					try {
						String fileName = new File(u.getPath()).getName();
						String fileId = fileName.substring(0, fileName.indexOf("_"));
						String type = fileName.substring(fileName.lastIndexOf("."));

						imgPathForSession = "/upload/user/user_" + fileId + type;

						File f = new File(request.getServletContext().getRealPath("/") + imgPathForSession);
						if (!f.exists())
							imgPathForSession = null;

					} catch (Exception e) {
						imgPathForSession = null;
					}
				}

				session.setAttribute("onlineUser", onlineUser);
				session.setAttribute("userImgPath", imgPathForSession);
			}

			userId = user.getId();
			// ดึงค่าที่พิ่ง Save
			User updatedUser = userDAO.findById(userId);
			String newEditPath = null;
			if (updatedUser.getPath() != null && updatedUser.getPath().contains("_")) {
				String fileName = new File(updatedUser.getPath()).getName();
				String fId = fileName.substring(0, fileName.indexOf("_"));
				String fType = fileName.substring(fileName.lastIndexOf("."));
				newEditPath = "/upload/user/user_" + fId + fType;
			}
			request.setAttribute("editUserImgPath", newEditPath);
			request.setAttribute("selectUser", updatedUser);

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

	public String admin_update_password() {
		try {
			String targetUserId = request.getParameter("user_id");
			String newPw = request.getParameter("password");

			if (targetUserId != null)
				targetUserId = targetUserId.trim();
			if (newPw != null)
				newPw = newPw.trim();

			if (targetUserId == null || targetUserId.isEmpty() || newPw == null || newPw.isEmpty()) {
				return ERROR;
			}

			User dbUser = userDAO.findById(targetUserId);

			String hashedNewPassword = MD5.getInstance().hashData(newPw.getBytes());

			dbUser.setPassword(hashedNewPassword);
			userDAO.update(dbUser);

			this.userId = targetUserId;

			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
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
			User ur = (User) request.getSession().getAttribute("onlineUser");
			String logonUser = ur.getId();

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

			if (password.equalsIgnoreCase(user.getPassword())) {
				user.setPassword(password);
			} else {
				user.setPassword(MD5.getInstance().hashData(password.getBytes()));
			}

			user.setTimeCreate(DateUtil.getCurrentTime());
			user.setTimeUpdate(DateUtil.getCurrentTime());

			if (fileUpload != null) {
				int maxId = fileuploadDAO.getMaxId() + 1;
				String fileServerPath = request.getServletContext().getRealPath("/");
				String originalName = fileUploadFileName;
				String fileName = originalName.substring(0, originalName.lastIndexOf("."));
				String typeFile = originalName.substring(originalName.lastIndexOf("."));

				if (fileName.contains(" ")) {
					fileName = fileName.trim().replaceAll(" ", "_");
				}

				String newFileName = maxId + "_" + fileName + typeFile;
				String serverFileName = "user_" + maxId + typeFile;

				long fileSize = fileUpload.length(); // byte
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

				FileUtil.upload(fileUpload, fileServerPath + "upload/user/", serverFileName);

				FileUpload file = new FileUpload();
				file.setFileId(maxId);
				file.setUserId(user.getId());
				file.setName(fileName);
				file.setPage("user");
				file.setPageId(user.getId());
				file.setUserId(logonUser);
				file.setType(typeFile);
				file.setSize(sizeText);
				file.setAltName(null);
				file.setUserCreate(logonUser);
				file.setUserUpdate(logonUser);
				file.setPath("/upload/user/" + newFileName);
				file.setTimeCreate(DateUtil.getCurrentTime());
				file.setTimeUpdate(DateUtil.getCurrentTime());
				fileuploadDAO.save(file);

				user.setPath("/upload/user/" + newFileName);

			}

			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
			if (this.startDate != null && !this.startDate.isEmpty()) {
				user.setStartDate(new java.sql.Date(sdf.parse(this.startDate).getTime()));
			}

			user.setEnable("1");
			user.setName(user.getName().replaceAll("[\\t\\n\\r]+", " ")
		              .replaceAll("\\s{2,}", " ").trim());
			user.setNameEN(user.getNameEN().replaceAll("[\\t\\n\\r]+", " ")
		              .replaceAll("\\s{2,}", " ").trim());
			user.setEmail(email);
			user.setPhonenum(phone);
			user.setNickName(nickname.replaceAll("[\\t\\n\\r]+", " ")
		              .replaceAll("\\s{2,}", " ").trim());
			user.setNickNameEN(nicknameEN.replaceAll("[\\t\\n\\r]+", " ")
		              .replaceAll("\\s{2,}", " ").trim());
			user.setTitleNameTH(titlenameTH);
			user.setTitleNameEN(titlenameEN);
			user.setGender(gender);
			user.setRoleId(role);
			user.setAddress(address);
			user.setDepartmentId(department);
			user.setPositionId(position);
			user.setFlagSearch("1");
			user.setSocialSecurity("0");
			user.setWithHoldAuto("0");
			user.setBankType("");
			user.setCitizenId("");
			user.setPassportId("");

			userDAO.save(user);


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
			u.setGender(user_gender);
			u.setTitleNameTH(user_titleNameTH);
			u.setName(user_name.replaceAll("[\\t\\n\\r]+", " ")
		              .replaceAll("\\s{2,}", " ").trim());
			u.setTitleNameEN(user_titleNameEN);
			u.setNameEN(user_fullNameEN.replaceAll("[\\t\\n\\r]+", " ")
		              .replaceAll("\\s{2,}", " ").trim());
			u.setNickName(user_nickNameTH.replaceAll("[\\t\\n\\r]+", " ")
		              .replaceAll("\\s{2,}", " ").trim());
			u.setNickNameEN(user_nickNameEN.replaceAll("[\\t\\n\\r]+", " ")
		              .replaceAll("\\s{2,}", " ").trim());
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

					log.info("Upload to server SUCCESS");
				}
			} else {
				if (fileUpload != null) {
					int maxId = fileuploadDAO.getMaxId();
					ServletContext context = request.getServletContext();
					String fileServerPath = context.getRealPath("/");
					
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

			u.setFacebookid(facebookid);
			userDAO.update(u);

			userId = user.getId();
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}

	}

	// SearchUser
	public String searchUser() {
		try {
			String userID = request.getParameter("user_id");
			User user = userDAO.findById(userID);
			String json = new com.google.gson.Gson().toJson(user);

			response.setContentType("application/json; charset=UTF-8");
			response.getWriter().write(json);
			return NONE;
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
			
			List<JobSiteTeam> teamLinks = jobSiteTeamDAO.findAllByUserId(id);
	        if (teamLinks != null) {
	            for (JobSiteTeam link : teamLinks) {
	                jobSiteTeamDAO.delete(link);
	            }
	        }

			User user = new User();
			user = userDAO.findById(id);
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
			if (setgender[1].equals("M") || setgender[1].equals("F")) {
				List<Map<String, Object>> user = userDAO.getGender(setgender);
				request.setAttribute("datauser", user);
				log.info(user);
				if (user.isEmpty() == false) {
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

			List<JobSiteTeam> teamLinks = jobSiteTeamDAO.findAllByUserId(userid);

			if (teamLinks != null) {
				for (JobSiteTeam link : teamLinks) {
					jobSiteTeamDAO.delete(link);
				}
			}

			User u = userDAO.findById(userid);
			if (u != null) {
				u.setId_sitejob(null);
				userDAO.update(u);
			}

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
			
			String webLinelogin = constant.getWebLinelogin();
			request.setAttribute("webLinelogin", webLinelogin);

			User u = userDAO.findById(logonUser);

			String imgPath = null;

			if (u.getPath() != null && u.getPath().contains("_")) {
				try {
					String originalFileName = new File(u.getPath()).getName();

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
			
			String imgPathSignature = null;
			String signatureFileName = null;
			if (u.getPathSignature() != null && u.getPathSignature().contains("_")) {
				try {
					String originalFileName = new File(u.getPathSignature()).getName();
					String fileIdStr = originalFileName.substring(0, originalFileName.indexOf("_"));
					String typeFile = originalFileName.substring(originalFileName.lastIndexOf("."));

					imgPathSignature = "/upload/user/user_signature_" + fileIdStr + typeFile;

					String server = request.getServletContext().getRealPath("/");
					File f = new File(server + imgPathSignature);
					if (!f.exists()) {
						imgPathSignature = null;
					}

					FileUpload file = fileuploadDAO.findById(Integer.parseInt(fileIdStr));
					if (file != null) {
			            signatureFileName = file.getName()+file.getType();  
			        }
					
				} catch (Exception e) {
					imgPathSignature = null;
				}
			}

			List<Map<String, Object>> managerList = userDAO.getManagerIdAndManagerNameByUserId(logonUser);
			Map<String, Object> manager = null;

			if (managerList != null && !managerList.isEmpty()) {
				manager = managerList.get(0);
			}
			request.setAttribute("manager", manager);

			List<Map<String, Object>> jobSite = jobsiteDAO.getJobSiteByUserId(logonUser);
			request.setAttribute("jobSite", jobSite);

			String workPeriod = "-";
			if (u.getStartDate() != null) {
				LocalDate start = u.getStartDate().toLocalDate();
				LocalDate now = LocalDate.now();
				Period p = Period.between(start, now);

				if (start.isAfter(now)) {
					workPeriod = "Waiting to start...";
				} else {

					if (p.getYears() == 0 && p.getMonths() == 0) {
						workPeriod = p.getDays() + "d";
					} else if (p.getYears() == 0) {
						workPeriod = p.getMonths() + "m " + p.getDays() + "d";
					} else {
						workPeriod = p.getYears() + "y " + p.getMonths() + "m";
					}
				}
			}

			List<Map<String, Object>> borrow = borrowDAO.getBorrowListByUserId(logonUser);

			if (borrow != null && !borrow.isEmpty()) {
				SimpleDateFormat inputDate = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
				inputDate.setCalendar(new GregorianCalendar());

				SimpleDateFormat outputDate = new SimpleDateFormat("dd MMM yyyy", Locale.ENGLISH);
				outputDate.setCalendar(new GregorianCalendar());

				for (Map<String, Object> row : borrow) {
					Object dateStartObj = row.get("time_create");
					if (dateStartObj == null) {
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
			} else {
				request.setAttribute("borrowList", borrow);
			}

			request.setAttribute("workPeriod", workPeriod);
			request.setAttribute("user", u);
			request.setAttribute("userImgPath", imgPath);
			request.setAttribute("imgPathSignature", imgPathSignature);
			request.setAttribute("signatureFileName", signatureFileName);

			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	public String update_my_profile() {
		try {
			HttpSession session = request.getSession();
			User ur = (User) request.getSession().getAttribute("onlineUser");
			String logonUser = ur.getId();

			User u = userDAO.findById(logonUser);

			if (u != null) {
				if (avatar_remove != null && avatar_remove.equalsIgnoreCase("true")) {
					u.setPath(null);

				} else if (fileUpload != null) {
					int maxId = fileuploadDAO.getMaxId() + 1;
					String fileServerPath = request.getServletContext().getRealPath("/");
					String originalName = fileUploadFileName;
					String fileName = originalName.substring(0, originalName.lastIndexOf("."));
					String typeFile = originalName.substring(originalName.lastIndexOf("."));

					if (fileName.contains(" ")) {
						fileName = fileName.trim().replaceAll(" ", "_");
					}

					String newFileName = maxId + "_" + fileName + typeFile;
					String serverFileName = "user_" + maxId + typeFile;

					long fileSize = fileUpload.length(); // byte
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

					FileUtil.upload(fileUpload, fileServerPath + "upload/user/", serverFileName);

					FileUpload file = new FileUpload();
					file.setFileId(maxId);
					file.setUserId(u.getId());
					file.setName(fileName);
					file.setPage("user");
					file.setPageId(u.getId());
					file.setUserId(logonUser);
					file.setType(typeFile);
					file.setSize(sizeText);
					file.setAltName(null);
					file.setUserCreate(logonUser);
					file.setUserUpdate(logonUser);
					file.setPath("/upload/user/" + newFileName);
					file.setTimeCreate(DateUtil.getCurrentTime());
					file.setTimeUpdate(DateUtil.getCurrentTime());
					fileuploadDAO.save(file);

					u.setPath("/upload/user/" + newFileName);
				}

				u.setTitleNameTH(this.user_titleNameTH);
				u.setName(this.user_name.replaceAll("[\\t\\n\\r]+", " ")
			              .replaceAll("\\s{2,}", " ").trim());
				u.setNickName(this.user_nickName.replaceAll("[\\t\\n\\r]+", " ")
			              .replaceAll("\\s{2,}", " ").trim());
				u.setTitleNameEN(this.user_titleNameEN);
				u.setNameEN(this.user_fullNameEN.replaceAll("[\\t\\n\\r]+", " ")
			              .replaceAll("\\s{2,}", " ").trim());
				u.setNickNameEN(this.user_nickNameEN.replaceAll("[\\t\\n\\r]+", " ")
			              .replaceAll("\\s{2,}", " ").trim());
				u.setGender(this.user_gender);
				u.setCitizenId(this.user_citizenId);
				u.setPassportId(this.user_passportId);
				u.setEmail(this.user_email);
				u.setLine_id(this.user_line_id);
				u.setPhonenum(this.user_phonenum);
				u.setAddress(this.user_address);
				u.setEmergContact(this.user_emergContact);
				u.setEmergPhone(this.user_emergPhone);
				u.setTimeUpdate(DateUtil.getCurrentTime());

				if (this.user_birthDate != null && !this.user_birthDate.isEmpty()) {
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
					java.util.Date bDate = sdf.parse(this.user_birthDate);
					u.setBirthDate(new java.sql.Date(bDate.getTime()));
				}
				userDAO.update(u);

				String imgPathForSession = null;
				if (u.getPath() != null && u.getPath().contains("_")) {
					try {
						String originalFileName = new File(u.getPath()).getName();
						String fileIdStr = originalFileName.substring(0, originalFileName.indexOf("_"));
						String typeFile = originalFileName.substring(originalFileName.lastIndexOf("."));

						imgPathForSession = "/upload/user/user_" + fileIdStr + typeFile;

						String server = request.getServletContext().getRealPath("/");
						File f = new File(server + imgPathForSession);
						if (!f.exists()) {
							imgPathForSession = null;
						}
					} catch (Exception e) {
						imgPathForSession = null;
					}
				}

				session.setAttribute("onlineUser", u);
				session.setAttribute("userImgPath", imgPathForSession);

			}

			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

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

			if (match) {
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
	
	public String update_signature() {
		try {
			HttpSession session = request.getSession();
			User ur = (User) request.getSession().getAttribute("onlineUser");
			String logonUser = ur.getId();

			User u = userDAO.findById(logonUser);
			
			if (u != null) {
				if (signature_remove != null && signature_remove.equalsIgnoreCase("true")) {
					u.setPathSignature(null);

				} else if (fileUpload != null) {
					int maxId = fileuploadDAO.getMaxId() + 1;
					String fileServerPath = request.getServletContext().getRealPath("/");
					String originalName = fileUploadFileName;
					String fileName = originalName.substring(0, originalName.lastIndexOf("."));
					String typeFile = originalName.substring(originalName.lastIndexOf("."));

					if (fileName.contains(" ")) {
						fileName = fileName.trim().replaceAll(" ", "_");
					}

					String newFileName = maxId + "_" + fileName + typeFile;
					String serverFileName = "user_signature_" + maxId + typeFile;

					long fileSize = fileUpload.length(); // byte
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

					FileUtil.upload(fileUpload, fileServerPath + "upload/user/", serverFileName);

					FileUpload file = new FileUpload();
					file.setFileId(maxId);
					file.setUserId(u.getId());
					file.setName(fileName);
					file.setPage("user_signature");
					file.setPageId(u.getId());
					file.setUserId(logonUser);
					file.setType(typeFile);
					file.setSize(sizeText);
					file.setAltName(null);
					file.setUserCreate(logonUser);
					file.setUserUpdate(logonUser);
					file.setPath("/upload/user/" + newFileName);
					file.setTimeCreate(DateUtil.getCurrentTime());
					file.setTimeUpdate(DateUtil.getCurrentTime());
					fileuploadDAO.save(file);

					u.setPathSignature("/upload/user/" + newFileName);
				}
				userDAO.update(u);

			}
			
			String redirectPage = request.getParameter("redirectPage");
	        if ("check_in_out".equals(redirectPage)) {
	            response.sendRedirect("check_in_out");
	            return null;
	        }

			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}
	
	public String signature_perform_delete() {
		try {
			User ur = (User) request.getSession().getAttribute("onlineUser");
			String logonUser = ur.getId();
			User user = userDAO.findById(String.valueOf(logonUser));
			
			if (user== null ) {
			    return ERROR;
			} else {
				String imgPathForSession = null;
				if (user.getPathSignature() != null && user.getPathSignature().contains("_")) {
					try {
						String originalFileName = new File(user.getPathSignature()).getName();
						String fileIdStr = originalFileName.substring(0, originalFileName.indexOf("_"));
			
						if (fileIdStr != null) {
							//delete file
							  FileUpload file = fileuploadDAO.findById(Integer.parseInt(fileIdStr));
							  if (file != null) {
								fileuploadDAO.delete(file);
								user.setPathSignature(null);
								userDAO.update(user);
							}
			
						}
			
					} catch (Exception e) {
						imgPathForSession = null;
					}
				}
				
			}
			
			String redirectPage = request.getParameter("redirectPage");
	        if ("check_in_out".equals(redirectPage)) {
	            response.sendRedirect("check_in_out");
	            return null;
	        }

			
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	public String admin_update_signature() {
		try {
			String targetUserId = this.user_id;
			if (targetUserId == null || targetUserId.trim().isEmpty()) {
				targetUserId = request.getParameter("user_id");
			}

			if (targetUserId == null || targetUserId.trim().isEmpty()) {
				return ERROR;
			}

			User u = userDAO.findById(targetUserId.trim());
			
			if (u != null) {
				if (signature_remove != null && signature_remove.equalsIgnoreCase("true")) {
					u.setPathSignature(null);

				} else if (fileUpload != null) {
					int maxId = fileuploadDAO.getMaxId() + 1;
					String fileServerPath = request.getServletContext().getRealPath("/");
					String originalName = fileUploadFileName;
					String fileName = originalName.substring(0, originalName.lastIndexOf("."));
					String typeFile = originalName.substring(originalName.lastIndexOf("."));

					if (fileName.contains(" ")) {
						fileName = fileName.trim().replaceAll(" ", "_");
					}

					String newFileName = maxId + "_" + fileName + typeFile;
					String serverFileName = "user_signature_" + maxId + typeFile;

					long fileSize = fileUpload.length(); // byte
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

					FileUtil.upload(fileUpload, fileServerPath + "upload/user/", serverFileName);

					FileUpload file = new FileUpload();
					file.setFileId(maxId);
					file.setName(fileName);
					file.setPage("user_signature");
					file.setPageId(u.getId());
					
					User onlineUser = (User) request.getSession().getAttribute("onlineUser");
					String logonUser = onlineUser != null ? onlineUser.getId() : "SYSTEM";
					
					file.setUserId(logonUser);
					file.setType(typeFile);
					file.setSize(sizeText);
					file.setAltName(null);
					file.setUserCreate(logonUser);
					file.setUserUpdate(logonUser);
					file.setPath("/upload/user/" + newFileName);
					file.setTimeCreate(DateUtil.getCurrentTime());
					file.setTimeUpdate(DateUtil.getCurrentTime());
					fileuploadDAO.save(file);

					u.setPathSignature("/upload/user/" + newFileName);
				}
				userDAO.update(u);
			}
			
			this.userId = targetUserId.trim();
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}
	
	public String admin_signature_perform_delete() {
		try {
			String targetUserId = request.getParameter("userId");
			
			if (targetUserId == null || targetUserId.trim().isEmpty()) {
			    return ERROR;
			}
			
			User user = userDAO.findById(targetUserId.trim());
			
			if (user != null) {
				if (user.getPathSignature() != null && user.getPathSignature().contains("_")) {
					try {
						String originalFileName = new File(user.getPathSignature()).getName();
						String fileIdStr = originalFileName.substring(0, originalFileName.indexOf("_"));
			
						if (fileIdStr != null && !fileIdStr.isEmpty()) {
							//delete file
							FileUpload file = fileuploadDAO.findById(Integer.parseInt(fileIdStr));
							if (file != null) {
								fileuploadDAO.delete(file);
								user.setPathSignature(null);
								userDAO.update(user);
							}
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
			
			this.userId = targetUserId.trim();
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}
}