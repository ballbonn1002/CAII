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
	Logger log = Logger.getLogger(getClass());
	HttpServletRequest request = ServletActionContext.getRequest();
	HttpServletResponse response = ServletActionContext.getResponse();
	public static final String User = "userList";
	public static final String ONLINEUSER = "onlineUser";

	private User onlineUser = (User) request.getSession().getAttribute("onlineUser");

	
	@Autowired
	private PageUriDAO pageUriDAO;

	private String pageUriId;
	private String forwardTo;
	private String model;
	private String modelId;
	private String meta;
	private String pageUriDescription;
	private String pageUriTitle;
	private String oldPageUriId;

	private Integer articleId;

	public String getPageUriId() {
		return pageUriId;
	}

	public void setPageUriId(String pageUriId) {
		this.pageUriId = pageUriId;
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

	public String getPageUriTitle() {
		return pageUriTitle;
	}

	public void setPageUriTitle(String pageUriTitle) {
		this.pageUriTitle = pageUriTitle;
	}

	public Integer getArticleId() {
		return articleId;
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

	public String getOldPageUriId() {
		return oldPageUriId;
	}

	public void setOldPageUriId(String oldPageUriId) {
		this.oldPageUriId = oldPageUriId;
	}

	public void setModelId(String modelId) {
		this.modelId = modelId;
	}

	public void setArticleId(Integer articleId) {
		this.articleId = articleId;
	}

	public String page_uri_list() {
		try {
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			if (onlineUser== null) {
			    return ERROR;
			}
			
			List<PageUri> pageUriList = pageUriDAO.findAll();
			request.setAttribute("pageUriList", pageUriList);


			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}


	public String page_uri_add() {
		try {
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			if (onlineUser== null) {
			    return ERROR;
			}
			String logonUser = onlineUser.getId();

			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	public String page_uri_edit() {
		try {
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			if (onlineUser== null) {
			    return ERROR;
			}

			PageUri pageUri = pageUriDAO.findByPageUri(pageUriId);

			request.setAttribute("pageUri", pageUri);

			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}

	}
	
	public String page_uri_perform_add() {
		try {
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			if (onlineUser== null) {
			    return ERROR;
			}
			String logonUser = onlineUser.getId();

			// Add page_uri
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
			e.printStackTrace();
			return ERROR;
		}
	}
	
	public String page_uri_perform_update() {
	    try {
	        User onlineUser = (User) request.getSession().getAttribute("onlineUser");
	        if (onlineUser == null) {
	            return ERROR;
	        }

	        String logonUser = onlineUser.getId();

	        PageUri oldUri = pageUriDAO.findByPageUri(oldPageUriId);

	        if (oldUri == null) {
	            return ERROR;
	        }

	        if (oldPageUriId.equals(pageUriId)) {
	            oldUri.setForwardTo(forwardTo);
	            oldUri.setModel(model);
	            oldUri.setModelId(modelId);
	            oldUri.setPageUriTitle(pageUriTitle);
	            oldUri.setMeta(meta);
	            oldUri.setPageUriDescription(pageUriDescription);
	            oldUri.setUserUpdate(logonUser);
	            oldUri.setTimeUpdate(DateUtil.getCurrentTime());

	            pageUriDAO.update(oldUri);

	        } else {
	            PageUri newUri = new PageUri();
	            newUri.setPageUriId(pageUriId);
	            newUri.setForwardTo(forwardTo);
	            newUri.setModel(model);
	            newUri.setModelId(modelId);
	            newUri.setPageUriTitle(pageUriTitle);
	            newUri.setMeta(meta);
	            newUri.setPageUriDescription(pageUriDescription);
	            newUri.setUserCreate(oldUri.getUserCreate());
	            newUri.setTimeCreate(oldUri.getTimeCreate());
	            newUri.setUserUpdate(logonUser);
	            newUri.setTimeUpdate(DateUtil.getCurrentTime());

	            pageUriDAO.deleteByPageUrlIdAndForwardTo(oldPageUriId, oldUri.getForwardTo());
	            pageUriDAO.save(newUri); 
	        }

	        return SUCCESS;

	    } catch (Exception e) {
	        e.printStackTrace();
	        return ERROR;
	    }
	}
	
	public String page_uri_perform_delete() {
		try {
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");

			if (onlineUser== null) {
			    return ERROR;
			}
			
			PageUri uri = pageUriDAO.findByPageUri(pageUriId);
			if (uri != null) {
				//delete pageUrl
				pageUriDAO.deleteByPageUrlIdAndForwardTo(pageUriId, forwardTo);
			}

			return SUCCESS;

		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}
	

}
