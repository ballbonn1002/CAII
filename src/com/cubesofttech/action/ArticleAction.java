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

public class ArticleAction extends ActionSupport {

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
	public ArticleDAO articleDAO;
	@Autowired
	public ArticleImageDAO articleImageDAO;
	@Autowired
	public ArticleRelatedDAO articleRelatedDAO;
	@Autowired
	public ArticleTagDAO articleTagDAO;
	@Autowired
	public ArticleTypeDAO articleTypeDAO;
	@Autowired
	public TagDAO tagDAO;
	@Autowired
	public UserDAO userDAO;
	@Autowired
	private FileUploadDAO fileuploadDAO;
	@Autowired
	private PageUriDAO pageUriDAO;

	private Integer articleId;
	private String cover_alt;
	private Integer article_type;
	private String[] article_tag;
	private String[] article_related;
	private String article_title;
	private String user_create;
	private String detail;
	private String article_status;
	private String fileId;
	private String userCreate;
	private String userUpdate;
	private java.sql.Timestamp timePost;
	private java.sql.Timestamp timeCreate;
	private java.sql.Timestamp timeUpdate;

	private String file_remove;
	private File fileUpload;
	private String fileUploadSize;
	private String fileUploadFileName;
	private String publication_date;
	private String publication_time;
	private String submitType;
	
	private String pageUriId;
	private String meta;
	private String pageUriDescription;
	private String pageUriTitle;

	public Integer getArticleId() {
		return articleId;
	}

	public void setArticleId(Integer articleId) {
		this.articleId = articleId;
	}

	public String getCover_alt() {
		return cover_alt;
	}

	public void setCover_alt(String cover_alt) {
		this.cover_alt = cover_alt;
	}

	public Integer getArticle_type() {
		return article_type;
	}

	public void setArticle_type(Integer article_type) {
		this.article_type = article_type;
	}

	public String[] getArticle_tag() {
		return article_tag;
	}

	public void setArticle_tag(String[] article_tag) {
		this.article_tag = article_tag;
	}

	public String[] getArticle_related() {
		return article_related;
	}

	public void setArticle_related(String[] article_related) {
		this.article_related = article_related;
	}

	public String getArticle_title() {
		return article_title;
	}

	public void setArticle_title(String article_title) {
		this.article_title = article_title;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public String getArticle_status() {
		return article_status;
	}

	public void setArticle_status(String article_status) {
		this.article_status = article_status;
	}

	public String getFileId() {
		return fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	public String getFile_remove() {
		return file_remove;
	}

	public void setFile_remove(String file_remove) {
		this.file_remove = file_remove;
	}
	
	
	public String getPublication_date() {
		return publication_date;
	}

	public void setPublication_date(String publication_date) {
		this.publication_date = publication_date;
	}

	public String getPublication_time() {
		return publication_time;
	}

	public void setPublication_time(String publication_time) {
		this.publication_time = publication_time;
	}

	
	public FileUploadDAO getFileuploadDAO() {
		return fileuploadDAO;
	}

	public void setFileuploadDAO(FileUploadDAO fileuploadDAO) {
		this.fileuploadDAO = fileuploadDAO;
	}

	public String getUser_create() {
		return user_create;
	}

	public void setUser_create(String user_create) {
		this.user_create = user_create;
	}

	public String getUserCreate() {
		return userCreate;
	}

	public void setUserCreate(String userCreate) {
		this.userCreate = userCreate;
	}

	public String getUserUpdate() {
		return userUpdate;
	}

	public void setUserUpdate(String userUpdate) {
		this.userUpdate = userUpdate;
	}

	public java.sql.Timestamp getTimePost() {
		return timePost;
	}

	public void setTimePost(java.sql.Timestamp timePost) {
		this.timePost = timePost;
	}

	public java.sql.Timestamp getTimeCreate() {
		return timeCreate;
	}

	public void setTimeCreate(java.sql.Timestamp timeCreate) {
		this.timeCreate = timeCreate;
	}

	public java.sql.Timestamp getTimeUpdate() {
		return timeUpdate;
	}

	public void setTimeUpdate(java.sql.Timestamp timeUpdate) {
		this.timeUpdate = timeUpdate;
	}

	public File getFileUpload() {
		return fileUpload;
	}

	public void setFileUpload(File fileUpload) {
		this.fileUpload = fileUpload;
	}

	public String getFileUploadSize() {
		return fileUploadSize;
	}

	public void setFileUploadSize(String fileUploadSize) {
		this.fileUploadSize = fileUploadSize;
	}

	public String getFileUploadFileName() {
		return fileUploadFileName;
	}

	public void setFileUploadFileName(String fileUploadFileName) {
		this.fileUploadFileName = fileUploadFileName;
	}

	public String getSubmitType() {
		return submitType;
	}

	public void setSubmitType(String submitType) {
		this.submitType = submitType;
	}

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

	public String article_feed() {
		try {
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			if (onlineUser== null) {
			    return ERROR;
			}
			String startStr = request.getParameter("startDate");
			String endStr = request.getParameter("endDate");

			LocalDateTime start;
			LocalDateTime end;

			if (startStr != null && endStr != null) {

				start = LocalDate.parse(startStr).atStartOfDay();

				end = LocalDate.parse(endStr).atTime(23, 59, 59);

			} else {
				//default ทั้งปี
				start = LocalDate.now().withDayOfYear(1).atStartOfDay();

				end = LocalDate.now().with(TemporalAdjusters.lastDayOfYear()).atTime(23, 59, 59);
			}
			List<Map<String, Object>> articleList = articleDAO.findArticlesByDateRange(start, end);

			List<ArticleType> articleTypeList = articleTypeDAO.findAll();

			request.setAttribute("articleList", articleList);
			request.setAttribute("articleTypeList", articleTypeList);
			request.setAttribute("startDate", start.toLocalDate());
			request.setAttribute("endDate", end.toLocalDate());
			request.setAttribute("now", new Date());

			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	public String article_add() {
		try {
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			if (onlineUser== null) {
			    return ERROR;
			}
			String logonUser = onlineUser.getId();
			
			List<Tag> tagList = tagDAO.findAll();
			List<ArticleType> articleTypeList = articleTypeDAO.findAll();
			List<Article> articleList = articleDAO.findAll();
			User user= userDAO.findById(logonUser);
//			log.debug("loginnnn = "+ user);

			request.setAttribute("tagList", tagList);
			request.setAttribute("articleTypeList", articleTypeList);
			request.setAttribute("articleList", articleList);
			request.setAttribute("user", user);

			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	public String article_perform_add() {
		try {
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			if (onlineUser== null) {
			    return ERROR;
			}
			String logonUser = onlineUser.getId();
			String fileIdStr = null;
			
			// Upload file
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
				String serverFileName = "article_" + maxId + typeFile;

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
				file.setUserId(logonUser);
				file.setName(fileName);
				file.setPage("article");
				file.setPageId(null);
				file.setType(typeFile);
				file.setSize(sizeText);
				file.setAltName(null);
				file.setUserCreate(logonUser);
				file.setUserUpdate(logonUser);
				file.setAltName(cover_alt);
				file.setPath("/upload/user/" + newFileName);
				file.setTimeCreate(DateUtil.getCurrentTime());
				file.setTimeUpdate(DateUtil.getCurrentTime());
				fileuploadDAO.save(file);

				fileIdStr = String.valueOf(maxId);
			}
			
			// Save article
			int articleMaxId = articleDAO.getMaxId()+1;
			Article article = new Article();
			article.setArticleId(articleMaxId);
			article.setTopic(article_title);
			article.setDetail(detail);
			article.setStatus(article_status);
			article.setFileId(fileIdStr);
			article.setArticleTypeId(article_type);
			article.setUserId(logonUser);
			article.setUserCreate(logonUser);
			article.setUserUpdate(logonUser);
			article.setTimeCreate(DateUtil.getCurrentTime());
			article.setTimeUpdate(DateUtil.getCurrentTime());

		    String dateStr = publication_date.trim();
		    String timeStr = publication_time.trim();
			DateTimeFormatter dateFormatter =
			        DateTimeFormatter.ofPattern("yyyy-MM-dd");

			LocalDate date = LocalDate.parse(dateStr, dateFormatter);
			LocalTime time = LocalTime.parse(timeStr);

			LocalDateTime dateTime = LocalDateTime.of(date, time);

			article.setTimePost(Timestamp.valueOf(dateTime));
			articleDAO.save(article);
			this.articleId = article.getArticleId();

			// Save article_tag
			if (article_tag != null) {
			    for (String tagId : article_tag) {

			        ArticleTag at = new ArticleTag();
			        at.setArticleId(String.valueOf(article.getArticleId()));
			        at.setTagId(tagId);

			        articleTagDAO.save(at);
			    }
			}

			// Save article_related
			if (article_related != null) {
			    for (String rid : article_related) {

			        ArticleRelated ar = new ArticleRelated();
			        ar.setArticleId(String.valueOf(article.getArticleId()));
			        ar.setRelatedArticleId(rid);

			        articleRelatedDAO.save(ar);
			    }
			}
			
			// Save page_uri
			PageUri uri = new PageUri();
			String articleIdStr = String.valueOf(article.getArticleId());
			String forward;
			String pageUriId;
			if (article_type == 1) {
			    forward = "/news_detail?articleId=" + articleIdStr;
			    pageUriId = "/news/"+ articleIdStr;
			}else if (article_type == 2) {
			    forward = "/blog_detail?articleId=" + articleIdStr;
			    pageUriId = "/blog/"+ articleIdStr;
			} else {
			    forward = "/news_detail?articleId=" + articleIdStr;
			    pageUriId = "/news/"+ articleIdStr;
			}
			
			uri.setPageUriId(pageUriId);
			uri.setForwardTo(forward);
			uri.setModel("article");
			uri.setModelId(articleIdStr);
			
			uri.setPageUriDescription(null);
			uri.setMeta(null);
			uri.setUserCreate(logonUser);
			uri.setUserUpdate(logonUser);
			uri.setTimeCreate(DateUtil.getCurrentTime());
			uri.setTimeUpdate(DateUtil.getCurrentTime());
			
			pageUriDAO.save(uri);
//			log.debug("submitType = "+submitType);
			
			if ("preview".equals(submitType)) {
			    return "preview";
			 }

			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}
	
	public String article_preview() {
		try {
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			if (articleId == null || onlineUser== null) {
			    return ERROR;
			}
			
			Article article = articleDAO.findById(articleId);
			List<Tag> tagList = tagDAO.findAll();
			List<ArticleType> articleTypeList = articleTypeDAO.findAll();
			List<Integer> tagIds = articleTagDAO.findTagIdByArticleId(String.valueOf(articleId));
			List<ArticleRelated> selectedRelatedId = articleRelatedDAO.findRelatedIdByArticleId(String.valueOf(articleId));
			List<User> userList = userDAO.findAll();
			List<Article> articleList = articleDAO.findAll();

//			log.debug("tagIds = "+ tagIds);
			
			List<Tag> selectedTagName = new ArrayList<>();
			if (tagIds != null) {
			    for (Integer id : tagIds) {
			        Tag tag = tagDAO.findById(id);
			        if (tag != null) {
			            selectedTagName.add(tag);
//			            log.debug("tagName = "+ selectedTagName);
			        }
			        
			        
			    }
			}
			
			Integer typeArticle = article.getArticleTypeId();
			
			LocalDateTime time_post = article.getTimePost().toLocalDateTime();
			Date publicDate = Timestamp.valueOf(time_post);
			String publicTime = time_post.toLocalTime().toString();
			
			PageUri pageUri = pageUriDAO.findByModelAndModelId("article", String.valueOf(articleId));

			
			String imgPath = null;
			String imgAlt = null;
			if (article.getFileId() != null) {
			    FileUpload file = fileuploadDAO.findById(Integer.parseInt(article.getFileId()));
			    if (file != null) {
			        String type = file.getType();
			        imgPath = "/upload/user/article_" + file.getFileId()+ type;
			        imgAlt = file.getAltName();
			    }
			}
			request.setAttribute("article", article);
			request.setAttribute("tagList", tagList);
			request.setAttribute("articleTypeList", articleTypeList);
			request.setAttribute("selectedTagName", selectedTagName);
			request.setAttribute("selectedRelatedId", selectedRelatedId);
			request.setAttribute("articleList", articleList);
//			request.setAttribute("userCreate", userCreate);
			request.setAttribute("userList", userList);

			request.setAttribute("publicDate", publicDate);
			request.setAttribute("publicTime", publicTime);
			
			request.setAttribute("fileImgPath", imgPath);
			request.setAttribute("fileImgAlt", imgAlt);
			
			request.setAttribute("typeArticle", typeArticle);
			request.setAttribute("pageUri", pageUri);
//			log.debug("title pageUri" + pageUri);
			
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}

	}

	public String article_edit() {
		try {
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			if (onlineUser== null) {
			    return ERROR;
			}
			Article article = articleDAO.findById(articleId);
			List<Tag> tagList = tagDAO.findAll();
			List<ArticleType> articleTypeList = articleTypeDAO.findAll();
			List<Integer> selectedTagId = articleTagDAO.findTagIdByArticleId(String.valueOf(articleId));
			List<ArticleRelated> selectedRelatedId = articleRelatedDAO.findRelatedIdByArticleId(String.valueOf(articleId));
//			List<User> userList = userDAO.findAll();
			List<Article> articleList = articleDAO.findAll();
			
			User userCreate = userDAO.findById(article.getUserCreate());
//			log.debug("userCreate ="+ userCreate);
			Integer typeArticle = article.getArticleTypeId();
//			log.debug("typeArticle = "+typeArticle);
			LocalDateTime time_post = article.getTimePost().toLocalDateTime();
			String publicDate = time_post.toLocalDate().toString();
			String publicTime = time_post.toLocalTime().toString();

//			log.debug("time_post "+ time_post);
//			log.debug("publicDate "+ publicDate);
//			log.debug("publicTime "+ publicTime);
			PageUri pageUri = pageUriDAO.findByModelAndModelId("article", String.valueOf(articleId));
//			log.debug("forwardTo = " + pageUri.getForwardTo());
//			log.debug("model = " + pageUri.getModel());
//			log.debug("modelId = " + pageUri.getModelId());
//			log.debug("pageUriId = " + pageUri.getPageUriId());
//			log.debug("meta = " + pageUri.getMeta());
//			log.debug("description = " + pageUri.getPageUriDescription());
			
			String imgPath = null;
			String imgAlt = null;
			if (article.getFileId() != null) {
			    FileUpload file = fileuploadDAO.findById(Integer.parseInt(article.getFileId()));
			    if (file != null) {
			        String type = file.getType();
			        imgPath = "/upload/user/article_" + file.getFileId()+ type;
			        imgAlt = file.getAltName();
			    }
			}
//			log.debug("imgPath ===="+imgPath);
			request.setAttribute("article", article);
			request.setAttribute("tagList", tagList);
			request.setAttribute("articleTypeList", articleTypeList);
			request.setAttribute("selectedTagId", selectedTagId);
			request.setAttribute("selectedRelatedId", selectedRelatedId);
			request.setAttribute("articleList", articleList);
			request.setAttribute("userCreate", userCreate);
//			request.setAttribute("userList", userList);

			request.setAttribute("publicDate", publicDate);
			request.setAttribute("publicTime", publicTime);
			
			request.setAttribute("fileImgPath", imgPath);
			request.setAttribute("fileImgAlt", imgAlt);
			
			request.setAttribute("typeArticle", typeArticle);
			request.setAttribute("pageUri", pageUri);

			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}

	}
	
	public String article_perform_update() {
		try {
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			if (onlineUser== null) {
			    return ERROR;
			}
			String logonUser = onlineUser.getId();
			String fileIdStr = null;
//			log.debug("articleId = " + articleId);
			Article article = articleDAO.findById(articleId);
			// Update article
			article.setTopic(article_title);
			article.setDetail(detail);
			article.setStatus(article_status);
//			article.setFileId(fileIdStr);
			article.setArticleTypeId(article_type);
//			article.setUserId(logonUser);
//			article.setUserCreate(logonUser);
			article.setUserUpdate(logonUser);
//			article.setTimeCreate(DateUtil.getCurrentTime());
			article.setTimeUpdate(DateUtil.getCurrentTime());

			String dateStr = publication_date.trim();
			String timeStr = publication_time.trim();
			DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

			LocalDate date = LocalDate.parse(dateStr, dateFormatter);
			LocalTime time = LocalTime.parse(timeStr);

			LocalDateTime dateTime = LocalDateTime.of(date, time);

			article.setTimePost(Timestamp.valueOf(dateTime));
			
			
			// Upload file
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
				String serverFileName = "article_" + maxId + typeFile;

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
				file.setUserId(logonUser);
				file.setName(fileName);
				file.setPage("article");
				file.setPageId(null);
				file.setType(typeFile);
				file.setSize(sizeText);
				file.setAltName(null);
				file.setUserCreate(logonUser);
				file.setUserUpdate(logonUser);
				file.setAltName(cover_alt);
				file.setPath("/upload/user/" + newFileName);
				file.setTimeCreate(DateUtil.getCurrentTime());
				file.setTimeUpdate(DateUtil.getCurrentTime());
				fileuploadDAO.save(file);

				fileIdStr = String.valueOf(maxId);
				
				article.setFileId(fileIdStr);
				
			}
			articleDAO.update(article);
			this.articleId = article.getArticleId();

			// Update article_tag
			if (article_tag != null) {
			    articleTagDAO.deleteByArticleId(String.valueOf(articleId));

			    for (String tagId : article_tag) {
			        ArticleTag at = new ArticleTag();
			        at.setArticleId(String.valueOf(articleId));
			        at.setTagId(tagId);
			        articleTagDAO.save(at);
			    }
			}

			// Update article_related
			if (article_related != null) {
			    articleRelatedDAO.deleteByArticleId(String.valueOf(articleId));

			    for (String rid : article_related) {
			        ArticleRelated ar = new ArticleRelated();
			        ar.setArticleId(String.valueOf(articleId));
			        ar.setRelatedArticleId(rid);
			        articleRelatedDAO.save(ar);
			    }
			}
			
			// Update page_uri
			PageUri uri = pageUriDAO.findByModelAndModelId("article", String.valueOf(articleId));
			if (uri != null) {
				String articleIdStr = String.valueOf(articleId);
			    String forward;
			    String newPageUriId;

			    if (article_type == 1) {
			        forward = "/news_detail?articleId=" + articleIdStr;
			        newPageUriId = "/news/" + articleIdStr;

			    } else if (article_type == 2) {
			        forward = "/blog_detail?articleId=" + articleIdStr;
			        newPageUriId = "/blog/" + articleIdStr;

			    } else {
			        forward = "/news_detail?articleId=" + articleIdStr;
			        newPageUriId = "/news/" + articleIdStr;
			    }

			    uri.setForwardTo(forward);
			    uri.setPageUriId(newPageUriId);
			    
				uri.setPageUriTitle(pageUriTitle);
			    uri.setPageUriId(pageUriId);
			    uri.setPageUriDescription(pageUriDescription);
			    uri.setMeta(meta);
			    uri.setUserUpdate(logonUser);
			    uri.setTimeUpdate(DateUtil.getCurrentTime());

			    pageUriDAO.update(uri);
			}
			
			if ("preview".equals(submitType)) {
				return "preview";
			}
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}
	
	public String article_perform_delete() {
		try {
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			Article article = articleDAO.findById(articleId);
			if (onlineUser== null || article == null) {
			    return ERROR;
			}

			if (article != null) {
				//delete article_tag
				String id = String.valueOf(articleId);

				articleTagDAO.deleteByArticleId(id);
				articleRelatedDAO.deleteByArticleId(id);
				pageUriDAO.deleteByModelAndModelId("article",id);
				//delete file
				if (article.getFileId() != null) {
					Integer fileId = Integer.parseInt(article.getFileId());
				    FileUpload file = fileuploadDAO.findById(fileId);
					if (file != null) {
						fileuploadDAO.delete(file);
					}
				}

				//delete article
				articleDAO.delete(article);
			}

			return SUCCESS;

		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}
	

}
