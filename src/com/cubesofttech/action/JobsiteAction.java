package com.cubesofttech.action;

import java.util.Comparator;

import java.sql.Timestamp;
import java.time.LocalDate;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.ArrayList;
import java.util.LinkedHashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.cubesofttech.dao.JobsiteDAO;
import com.cubesofttech.dao.UserDAO;
import com.cubesofttech.dao.JobSiteTeamDAO;
import com.cubesofttech.model.JobSiteTeam;
import com.cubesofttech.model.Jobsite;
import com.cubesofttech.model.User;
import com.cubesofttech.service.WorkHoursService;
import com.cubesofttech.util.DateUtil;
import com.opensymphony.xwork2.ActionSupport;

public class JobsiteAction extends ActionSupport {

	private static final Logger log = Logger.getLogger(JobsiteAction.class);

	@Autowired
	private JobsiteDAO jobsiteDAO;

	@Autowired
	private UserDAO userDAO;

	@Autowired
	private JobSiteTeamDAO jobSiteTeamDAO;

	private List<Map<String, Object>> teamList;

	@Autowired
	private WorkHoursService WorkHoursService;

	public List<Map<String, Object>> getTeamList() {
		return teamList;
	}

	public void setTeamList(List<Map<String, Object>> teamList) {
		this.teamList = teamList;
	}

	private String user_id;

	public JobSiteTeamDAO getJobSiteTeamDAO() {
		return jobSiteTeamDAO;
	}

	public void setJobSiteTeamDAO(JobSiteTeamDAO jobSiteTeamDAO) {
		this.jobSiteTeamDAO = jobSiteTeamDAO;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	private List<Map<String, Object>> jobsiteList;
	private List<User> userList;

	public List<User> getUserList() {
		return userList;
	}

	public void setUserList(List<User> userList) {
		this.userList = userList;
	}

	private Jobsite jobsite;
	private Integer id_sitejob;

	HttpServletRequest request = ServletActionContext.getRequest();

	private String trimOrNull(String s) {
		if (s == null)
			return null;
		s = s.trim();
		return s.isEmpty() ? null : s;
	}

	// ------------------------ LIST ------------------------
	public String list() {
		try {
			jobsiteList = jobsiteDAO.findAllWithTeamAmount();
		} catch (Exception e) {
			log.error("Error in JobsiteAction.list()", e);
			return ERROR;
		}
		return SUCCESS;
	}

	// ------------------------ ADD ------------------------
	public String addJobsite() {
		try {
			jobsite = new Jobsite();
			jobsite.setIs_active("1");
			userList = userDAO.findAll();
			return SUCCESS;
		} catch (Exception e) {
			log.error("Error in JobsiteAction.addJobsite()", e);
			jobsite = new Jobsite();
			jobsite.setIs_active("1");
			return ERROR;
		}
	}

	// ------------------------ EDIT ------------------------
	public String editJobsite() {
		try {
			log.info("=== START editJobsite ===");

			String idParam = trimOrNull(request.getParameter("id_sitejob"));
			if (idParam == null)
				idParam = trimOrNull(request.getParameter("id"));
			if (idParam == null)
				idParam = trimOrNull(request.getParameter("ID"));

			log.info("Params -> id_sitejob: " + request.getParameter("id_sitejob") + ", id: "
					+ request.getParameter("id") + ", ID: " + request.getParameter("ID"));
			log.info("Action Property id_sitejob: " + id_sitejob);

			Integer jobsiteId = null;
			if (idParam != null) {
				try {
					jobsiteId = Integer.parseInt(idParam);
				} catch (NumberFormatException e) {
					log.error("Invalid ID format: " + idParam);
				}
			}

			if (jobsiteId == null && id_sitejob != null) {
				jobsiteId = id_sitejob;
			}

			log.info("Final jobsiteId to find: " + jobsiteId);

			if (jobsiteId != null && jobsiteId > 0) {
				jobsite = jobsiteDAO.findById(jobsiteId);

				if (jobsite == null) {
					log.info("!!! Jobsite NOT FOUND in DB !!!");
					jobsite = new Jobsite();
					jobsite.setIs_active("1");
					addActionError("Jobsite not found with ID: " + jobsiteId);
				} else {
					log.info("Jobsite Found: " + jobsite.getName_site());
				}
			} else {
				log.info("Jobsite ID is null or 0, creating new object.");
				jobsite = new Jobsite();
				jobsite.setIs_active("1");
				addActionError("Invalid jobsite ID");
			}

			userList = userDAO.findAll();
			log.info("User List loaded size: " + (userList != null ? userList.size() : "null"));

			if (jobsiteId != null) {
				teamList = jobSiteTeamDAO.findByJobsite(jobsiteId);
				log.info("Team List loaded size: " + (teamList != null ? teamList.size() : "null"));
			} else {
				log.info("Skipping Team List load (ID is null)");
				teamList = new ArrayList<>();
			}

			try {
				User onlineUser = (User) request.getSession().getAttribute("onlineUser");
				String logonUserId = (onlineUser != null) ? onlineUser.getId() : "";
				request.setAttribute("logonUser", logonUserId);

				StringBuilder teamIdsBuilder = new StringBuilder(",");
				if (teamList != null) {
					for (Object t : teamList) {
						if (t instanceof Map) {
							Object uid = ((Map<?, ?>) t).get("user_id");
							if (uid != null)
								teamIdsBuilder.append(uid.toString()).append(",");
						}
					}
				}
				request.setAttribute("teamUserIds", teamIdsBuilder.toString());

				List<Map<String, Object>> jsonUserList = new ArrayList<>();
				if (userList != null) {
					for (User u : userList) {
						Map<String, Object> map = new HashMap<>();
						map.put("id", u.getId());
						map.put("employeeId", u.getEmployeeId());
						map.put("nameEN", u.getNameEN());
						map.put("nameTH", u.getName());
						jsonUserList.add(map);
					}
				}

				ObjectMapper mapper = new ObjectMapper();
				String cubeUserJson = mapper.writeValueAsString(jsonUserList);
				request.setAttribute("cubeUserJson", cubeUserJson);

				log.info("JSON preparation done.");

			} catch (Exception e) {
				log.error("Error generating JSON for editJobsite", e);
				request.setAttribute("cubeUserJson", "[]");
				request.setAttribute("teamUserIds", "");
			}

			log.info("=== END editJobsite (SUCCESS) ===");
			return SUCCESS;

		} catch (Exception e) {
			log.error("!!! CRITICAL ERROR in editJobsite !!!", e);

			if (jobsite == null) {
				jobsite = new Jobsite();
				jobsite.setIs_active("1");
			}

			addActionError("Error loading jobsite: " + e.getMessage());
			return ERROR;
		}
	}

	// ------------------------ SAVE JOBSITE ------------------------
	public String saveJobsite() {
	    try {
	        User user = (User) request.getSession().getAttribute("onlineUser");
	        if (user == null || user.getId() == null) {
	            return "login";
	        }
	        String userId = user.getId();
	        Timestamp now = DateUtil.getCurrentTime();

	        if (jobsite == null) {
	            addActionError("Jobsite data is required");
	            return ERROR;
	        }

	        if (jobsite.getName_site() != null) {
	            jobsite.setName_site(jobsite.getName_site().trim());
	        }
	        if (jobsite.getDescription() != null) {
	            jobsite.setDescription(jobsite.getDescription().trim());
	        }

	        if (jobsite.getName_site() == null || jobsite.getName_site().isEmpty()) {
	            addActionError("Job Site Name cannot be empty or just spaces.");
	            return ERROR;
	        }

	        String activeParam = request.getParameter("is_active");
	        jobsite.setIs_active("1".equals(activeParam) ? "1" : "0");

	        jobsite.setTime_create(now);
	        jobsite.setUser_create(userId);

	        jobsiteDAO.save(jobsite);

	        addActionMessage("Jobsite created successfully!");

	        return SUCCESS;  

	    } catch (Exception e) {
	        log.error("Error in saveJobsite()", e);
	        addActionError("Error saving jobsite: " + e.getMessage());
	        return ERROR;
	    }
	}

	// ------------------------ DELETE JOB SITE ------------------------
	public String deleteJobsite() {
		try {
			String idParam = trimOrNull(request.getParameter("id_sitejob"));
			if (idParam == null)
				idParam = trimOrNull(request.getParameter("id"));
			if (idParam == null)
				idParam = trimOrNull(request.getParameter("ID"));

			if (idParam == null) {
				addActionError("Missing id_sitejob");
				return ERROR;
			}

			Integer jobsiteId = Integer.parseInt(idParam);

			jobSiteTeamDAO.deleteByIdSiteJob(String.valueOf(jobsiteId));

			Jobsite js = jobsiteDAO.findById(jobsiteId);
			if (js != null) {
				jobsiteDAO.delete(js);
			}

			addActionMessage("Jobsite deleted successfully!");
			return SUCCESS;

		} catch (Exception e) {
			log.error("Error in JobsiteAction.deleteJobsite()", e);
			addActionError("Error deleting jobsite: " + e.getMessage());
			return ERROR;
		}
	}

	// ------------------------ SAVE TEAM (Add Employee) ------------------------
	public String saveJobSiteTeam() {
		try {
			String idSitejobParam = trimOrNull(request.getParameter("id_sitejob"));
			String userIdParam = trimOrNull(request.getParameter("user_id"));

			if (idSitejobParam == null || userIdParam == null) {
				return ERROR;
			}

			JobSiteTeam existed = jobSiteTeamDAO.findByIdSiteJobAndUserId(idSitejobParam, userIdParam);
			if (existed != null) {

				Integer jobId = Integer.parseInt(idSitejobParam);
				jobsite = jobsiteDAO.findById(jobId);
				userList = userDAO.findAll();
				teamList = jobSiteTeamDAO.findByJobsite(jobId);
				return SUCCESS;
			}

			JobSiteTeam team = new JobSiteTeam();
			team.setId_sitejob(idSitejobParam);
			team.setUser_id(userIdParam);
			jobSiteTeamDAO.save(team);

			Integer jobId = Integer.parseInt(idSitejobParam);
			jobsite = jobsiteDAO.findById(jobId);
			userList = userDAO.findAll();
			teamList = jobSiteTeamDAO.findByJobsite(jobId);

			return SUCCESS;

		} catch (Exception e) {
			log.error("Error in JobsiteAction.saveJobSiteTeam()", e);
			addActionError("Error saving job site team: " + e.getMessage());
			return ERROR;
		}
	}

	// ------------------------ DELETE EMPLOYEE ------------------------
	public String deleteJobSiteTeam() {
		try {
			String teamIdParam = trimOrNull(request.getParameter("job_site_team_id"));
			String idSitejobParam = trimOrNull(request.getParameter("id_sitejob"));

			if (teamIdParam == null || idSitejobParam == null) {
				return ERROR;
			}

			Integer teamId = Integer.parseInt(teamIdParam);
			Integer jobId = Integer.parseInt(idSitejobParam);

			JobSiteTeam team = jobSiteTeamDAO.findById(teamId);
			if (team != null) {
				jobSiteTeamDAO.delete(team);
			}

			jobsite = jobsiteDAO.findById(jobId);
			userList = userDAO.findAll();
			teamList = jobSiteTeamDAO.findByJobsite(jobId);

			return SUCCESS;

		} catch (Exception e) {
			log.error("Error in JobsiteAction.deleteJobSiteTeam()", e);
			addActionError("Error deleting job site team: " + e.getMessage());
			return ERROR;
		}
	}

	// ------------------------ UPDATE ------------------------
	public String updateJobsite() {
	    try {
	        User user = (User) request.getSession().getAttribute("onlineUser");
	        if (user == null || user.getId() == null) {
	            return "login";
	        }

	        if (jobsite == null || jobsite.getId_sitejob() == null) {
	            addActionError("Jobsite ID is required");
	            return ERROR;
	        }

	        Jobsite dbJobsite = jobsiteDAO.findById(jobsite.getId_sitejob());

	        if (dbJobsite != null) {
	            String newName = jobsite.getName_site();
	            String newDesc = jobsite.getDescription();
	            
	            if (newName != null) newName = newName.trim();
	            if (newDesc != null) newDesc = newDesc.trim();

	            if (newName == null || newName.isEmpty()) {
	                addActionError("Job Site Name cannot be empty.");
	                return ERROR;
	            }

	            dbJobsite.setName_site(newName);
	            dbJobsite.setDescription(newDesc);

	            String activeParam = request.getParameter("is_active");
	            dbJobsite.setIs_active("1".equals(activeParam) ? "1" : "0");

	            dbJobsite.setTime_update(DateUtil.getCurrentTime());
	            dbJobsite.setUser_update(user.getId());

	            jobsiteDAO.update(dbJobsite);

	            addActionMessage("Jobsite updated successfully!");
	            return SUCCESS;
	        } else {
	            addActionError("Jobsite not found");
	            return ERROR;
	        }

	    } catch (Exception e) {
	        log.error("Error in JobsiteAction.updateJobsite()", e);
	        return ERROR;
	    }
	}

	// ------------------------ UPDATE STATUS ------------------------
	public String updateJobsiteStatus() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();

		response.setContentType("text/plain;charset=UTF-8");

		try {
			String idParam = request.getParameter("id_sitejob");
			String activeParam = request.getParameter("is_active");

			if (idParam != null && activeParam != null) {
				Integer id = Integer.parseInt(idParam);

				Jobsite js = jobsiteDAO.findById(id);

				if (js != null) {
					js.setIs_active(activeParam);

					User user = (User) request.getSession().getAttribute("onlineUser");
					if (user != null) {
						js.setUser_update(user.getId());
					}
					js.setTime_update(DateUtil.getCurrentTime());

					jobsiteDAO.update(js);

					response.getWriter().write("success");
				} else {
					response.getWriter().write("error: jobsite not found");
				}
			} else {
				response.getWriter().write("error: missing parameters");
			}

		} catch (Exception e) {
			log.error("Error in updateJobsiteStatus", e);
			try {
				response.getWriter().write("error: " + e.getMessage());
			} catch (Exception ex) {
			}
		}
		return NONE;
	}

	public String myJobsite() {

		try {
			HttpServletRequest request = ServletActionContext.getRequest();

			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			if (onlineUser == null || onlineUser.getId() == null) {
				return "login";
			}

			String userId = onlineUser.getId();

			User u = userDAO.findById(userId);
			if (u == null) {
				return "login";
			}

			String selectedDate = request.getParameter("date");
			if (selectedDate == null || selectedDate.trim().isEmpty()) {
				selectedDate = new SimpleDateFormat("yyyy-MM-dd", Locale.US).format(new Date());
			}

			LocalDate workDate = LocalDate.parse(selectedDate);

			List<Map<String, Object>> rows = jobSiteTeamDAO.findSitesMembersWorkByUserAndDate(userId, selectedDate);

			Map<String, Map<String, Object>> siteMap = new LinkedHashMap<>();
			Map<String, List<Map<String, Object>>> teamBySite = new LinkedHashMap<>();

			for (Map<String, Object> r : rows) {

				String siteId = String.valueOf(r.get("id_sitejob"));

				// Grouping by Site
				if (!siteMap.containsKey(siteId)) {
					Map<String, Object> siteItem = new HashMap<>();
					siteItem.put("id_sitejob", r.get("id_sitejob"));
					siteItem.put("name_site", r.get("name_site"));
					siteMap.put(siteId, siteItem);

					teamBySite.put(siteId, new ArrayList<>());
				}

				Map<String, Object> member = new HashMap<>();
				member.put("employee_id", r.get("employee_id"));
				member.put("name", r.get("name"));
				member.put("name_en", r.get("name_en"));
				member.put("u_id", r.get("u_id"));

				String memberUserId = String.valueOf(r.get("u_id"));

				Map<String, Object> statusMap = WorkHoursService.calculateDailyStatus(memberUserId, workDate);

				member.put("status", statusMap.get("status"));
				member.put("check_in", statusMap.get("check_in"));
				member.put("check_out", statusMap.get("check_out"));
				member.put("leave_desc", statusMap.get("leave_desc"));
				member.put("check_in_type", statusMap.get("check_in_type"));
				member.put("check_out_type", statusMap.get("check_out_type"));

				teamBySite.get(siteId).add(member);
			}

			request.setAttribute("userData", u);
			request.setAttribute("selectedDate", selectedDate);
			request.setAttribute("siteList", new ArrayList<>(siteMap.values()));
			request.setAttribute("teamBySite", teamBySite);

			return SUCCESS;

		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	// Getters and Setters
	public JobsiteDAO getJobsiteDAO() {
		return jobsiteDAO;
	}

	public void setJobsiteDAO(JobsiteDAO jobsiteDAO) {
		this.jobsiteDAO = jobsiteDAO;
	}

	public List<Map<String, Object>> getJobsiteList() {
		return jobsiteList;
	}

	public void setJobsiteList(List<Map<String, Object>> jobsiteList) {
		this.jobsiteList = jobsiteList;
	}

	public Jobsite getJobsite() {
		return jobsite;
	}

	public void setJobsite(Jobsite jobsite) {
		this.jobsite = jobsite;
	}

	public Integer getId_sitejob() {
		return id_sitejob;
	}

	public void setId_sitejob(Integer id_sitejob) {
		this.id_sitejob = id_sitejob;
	}

	public UserDAO getUserDAO() {
		return userDAO;
	}

	public void setUserDAO(UserDAO userDAO) {
		this.userDAO = userDAO;
	}
}