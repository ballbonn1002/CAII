package com.cubesofttech.action;

import com.cubesofttech.dao.FileUploadDAO;
import com.cubesofttech.dao.JobsiteDAO;
import com.cubesofttech.dao.UserDAO;
import com.cubesofttech.dao.WorkLogDAO;
import com.cubesofttech.model.FileUpload;
import com.cubesofttech.model.User;

import java.io.File;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;

public class PurchaseOrderAction extends ActionSupport {

    private static final long serialVersionUID = 2280661337420278284L;

    Logger log = Logger.getLogger(getClass());
    HttpServletRequest request = ServletActionContext.getRequest();
    HttpServletResponse response = ServletActionContext.getResponse();

    private User onlineUser = (User) request.getSession().getAttribute("onlineUser");

    @Autowired
    private WorkLogDAO workLogDAO;

    @Autowired
    private JobsiteDAO jobsiteDAO;

    @Autowired
    private UserDAO userDAO;
    
    @Autowired
	private FileUploadDAO fileuploadDAO;

    public String purchase_order_list() {
        try {
            if (onlineUser == null) {
            	return ERROR;
            }

            return SUCCESS;

        } catch (Exception e) {
            e.printStackTrace();
            return ERROR;
        }
    }
    
    public String purchase_order_detail() {
        try {
            if (onlineUser == null) {
            	return ERROR;
            }
            
            String loginUser = onlineUser.getId();
            User u = userDAO.findById(loginUser);
            
            log.debug("Test "+ loginUser);
            log.debug("Test u "+ u);
            
            
            // Signature
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
			request.setAttribute("imgPathSignature", imgPathSignature);
			request.setAttribute("loginUser", u);
			
			Date requestDate = new Date();
			request.setAttribute("requestDateTime", requestDate);
			
            return SUCCESS;

        } catch (Exception e) {
            e.printStackTrace();
            return ERROR;
        }
    }
    
    public String purchase_order_add() {
        try {
            if (onlineUser == null) {
            	return ERROR;
            }
            
            String loginUser = onlineUser.getId();
            User u = userDAO.findById(loginUser);
            
            log.debug("Test "+ loginUser);
            log.debug("Test u "+ u);
            
            
            // Signature
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
			request.setAttribute("imgPathSignature", imgPathSignature);
			request.setAttribute("loginUser", u);
			
			Date requestDate = new Date();
			request.setAttribute("requestDateTime", requestDate);
			
            return SUCCESS;

        } catch (Exception e) {
            e.printStackTrace();
            return ERROR;
        }
    }

    
}