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
	

}
