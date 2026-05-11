package com.cubesofttech.action;

import java.io.File;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.Date;
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
import com.cubesofttech.dao.PageUriDAO;
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
import com.cubesofttech.model.PageUri;
import com.cubesofttech.model.Role;
import com.cubesofttech.model.Tag;
import com.cubesofttech.model.User;
import com.cubesofttech.util.Convert;
import com.cubesofttech.util.DateUtil;
import com.cubesofttech.util.FileUtil;
import com.cubesofttech.util.MD5;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import java.text.SimpleDateFormat;
import com.opensymphony.xwork2.ActionSupport;

public class PageUriAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2280661337420278284L;
	private static final Integer Interger = null;
	private static final Logger log = Logger.getLogger(PageUriAction.class);
	HttpServletRequest request = ServletActionContext.getRequest();
	HttpServletResponse response = ServletActionContext.getResponse();
	public static final String User = "userList";
	public static final String ONLINEUSER = "onlineUser";

	private User onlineUser = (User) request.getSession().getAttribute("onlineUser");
	
	@Autowired
	private PageUriDAO pageUriDAO;

	private String oldPageUriId;
	private String pageUriId;
	private String forwardTo;
	private String model;
	private String modelId;
	private String pageUriTitle;
	private String meta;
	private String pageUriDescription;

	public String getOldPageUriId() {
		return oldPageUriId;
	}

	public void setOldPageUriId(String oldPageUriId) {
		this.oldPageUriId = oldPageUriId;
	}

	public String getPageUriId() {
		return pageUriId;
	}

	public void setPageUriId(String pageUriId) {
		this.pageUriId = pageUriId;
	}

	public String getForwardTo() {
		return forwardTo;
	}

	public void setForwardTo(String forwardTo) {
		this.forwardTo = forwardTo;
	}

	public String getModel() {
		return model;
	}

	public void setModel(String model) {
		this.model = model;
	}

	public String getModelId() {
		return modelId;
	}

	public void setModelId(String modelId) {
		this.modelId = modelId;
	}

	public String getPageUriTitle() {
		return pageUriTitle;
	}

	public void setPageUriTitle(String pageUriTitle) {
		this.pageUriTitle = pageUriTitle;
	}

	public String getMeta() {
		return meta;
	}

	public void setMeta(String meta) {
		this.meta = meta;
	}

	public String getPageUriDescription() {
		return pageUriDescription;
	}

	public void setPageUriDescription(String pageUriDescription) {
		this.pageUriDescription = pageUriDescription;
	}

	public String list() {
		try {
			List<PageUri> pageUriList = pageUriDAO.findAll();
			request.setAttribute("pageUriList", pageUriList);
			return SUCCESS;
		} catch (Exception e) {
			log.error(e);
			return ERROR;
		}
	}

	public String add() {
		return SUCCESS;
	}

	public String savePageUri() {
		try {
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			String logonUser = (onlineUser != null) ? onlineUser.getId() : "system";

			PageUri uri = new PageUri();
			uri.setPageUriId(pageUriId);
			uri.setForwardTo(forwardTo);
			uri.setModel(model);
			uri.setModelId(modelId);
			uri.setPageUriTitle(pageUriTitle);
			uri.setMeta(meta);
			uri.setPageUriDescription(pageUriDescription);
			
			uri.setUserCreate(logonUser);
			uri.setUserUpdate(logonUser);
			uri.setTimeCreate(DateUtil.getCurrentTime());
			uri.setTimeUpdate(DateUtil.getCurrentTime());

			pageUriDAO.save(uri);

			return SUCCESS;
		} catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			return ERROR;
		}
	}

	public String editPageUri() {
		try {
			String id = request.getParameter("pageUriId");
			if (id != null && !id.isEmpty()) {
				PageUri uri = pageUriDAO.findById(id);
				request.setAttribute("pageUri", uri);
			}
			return SUCCESS;
		} catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			return ERROR;
		}
	}

	public String updatePageUri() {
		try {
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			String logonUser = (onlineUser != null) ? onlineUser.getId() : "system";

			if (oldPageUriId != null && !oldPageUriId.isEmpty() && !oldPageUriId.equals(pageUriId)) {
				// Prevent saving if the new ID already exists
				PageUri existing = pageUriDAO.findById(pageUriId);
				if (existing != null) {
					request.setAttribute("errorMsg", "Page URL (ID) already exists!");
					return ERROR;
				}
				pageUriDAO.changePageUriId(oldPageUriId, pageUriId);
			}

			PageUri uri = pageUriDAO.findById(pageUriId);
			if (uri != null) {
				uri.setForwardTo(forwardTo);
				uri.setModel(model);
				uri.setModelId(modelId);
				uri.setPageUriTitle(pageUriTitle);
				uri.setMeta(meta);
				uri.setPageUriDescription(pageUriDescription);
				
				uri.setUserUpdate(logonUser);
				uri.setTimeUpdate(DateUtil.getCurrentTime());

				pageUriDAO.update(uri);
			}

			return SUCCESS;
		} catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			return ERROR;
		}
	}

	public String deletePageUri() {
		try {
			String id = request.getParameter("pageUriId");
			if (id != null && !id.isEmpty()) {
				PageUri uri = pageUriDAO.findById(id);
				if (uri != null) {
					pageUriDAO.delete(uri);
				}
			}
			return SUCCESS;
		} catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			return ERROR;
		}
	}
	
	public void checkDuplicateForwardTo() {
		try {
			HttpServletResponse response = ServletActionContext.getResponse();
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			
			String ft = request.getParameter("forwardTo");
			String pid = request.getParameter("pageUriId"); // to allow same forwardTo for the current pageUriId in edit mode
			String oldPid = request.getParameter("oldPageUriId"); 

			boolean isDuplicate = false;
			boolean isDuplicateUrl = false;
			
			if (pid != null && !pid.isEmpty()) {
				PageUri existingId = pageUriDAO.findById(pid);
				if (existingId != null) {
					if (oldPid == null || oldPid.isEmpty() || !existingId.getPageUriId().equals(oldPid)) {
						isDuplicateUrl = true;
					}
				}
			}

			if (ft != null && !ft.isEmpty()) {
				PageUri existing = pageUriDAO.findByForwardTo(ft);
				if (existing != null) {
					// If oldPid is not empty, check against it. Else check against pid.
					String checkId = (oldPid != null && !oldPid.isEmpty()) ? oldPid : pid;
					if (checkId == null || checkId.isEmpty() || !existing.getPageUriId().equals(checkId)) {
						isDuplicate = true;
					}
				}
			}
			
			PrintWriter out = response.getWriter();
			out.print("{\"isDuplicate\": " + isDuplicate + ", \"isDuplicateUrl\": " + isDuplicateUrl + "}");
			out.flush();
		} catch (Exception e) {
			log.error(e);
			e.printStackTrace();
		}
	}
}
