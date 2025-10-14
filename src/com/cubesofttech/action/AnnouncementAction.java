package com.cubesofttech.action;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.cubesofttech.dao.AnnouncementDAO;
import com.cubesofttech.model.Announcement;
import com.cubesofttech.model.FileUpload;
import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;

public class AnnouncementAction extends ActionSupport {
	private static final long serialVersionUID = 1L;

	private static final Logger log = Logger.getLogger(AnnouncementAction.class);
	HttpServletRequest request = ServletActionContext.getRequest();
	HttpServletResponse response = ServletActionContext.getResponse();
	String dateFromRequest = request.getParameter("announcement_date");
	
	HttpSession session = request.getSession();
	
	@Autowired
	public AnnouncementDAO announcementDAO;
	
	private List<FileUpload> fileUploadlist;
	
	public List<FileUpload> getFileUploadlist() {
		return fileUploadlist;
	}

	public void setFileUploadlist(List<FileUpload> fileUploadlist) {
		this.fileUploadlist = fileUploadlist;
	}

	public String AnnouncementList() {
	    try {
	    	List<Announcement> announcementList = announcementDAO.findAll();
	    	request.setAttribute("announcementList", announcementList);
	    	//request.setAttribute("announcementList", new Gson().toJson(announcementList));
	        return SUCCESS;
	    } catch (Exception e) {
	        log.error("Error fetching announcement list", e);
	        e.printStackTrace();
	        return ERROR;
	    }
	}
	
	public String readcardannounce() {
		try {
			String id = request.getParameter("id");
			/*
			 * Announcement announce = announcementDAO.findById(announceId); if (announce !=
			 * null) { Integer currentCount = announce.getReadcount() != null ?
			 * announce.getReadcount() : 0; announce.setReadcount(currentCount + 1);
			 * announcementDAO.update(announce); }
			 */
			List<Map<String, Object>> announcement = announcementDAO.readcardannounce(Integer.parseInt(id));
			log.debug("success" + announcement);
			request.setAttribute("announcement", announcement);

			fileUploadlist = announcementDAO.findByPageAndPageId("announcementFiles", String.valueOf(id));
			log.debug("file : " + fileUploadlist);
			request.setAttribute("announcementFiles", fileUploadlist);

			return SUCCESS;
		} catch (Exception e) {
			log.error("Error fetching announcement Page Read", e);
			return ERROR;
		}
	}
}
