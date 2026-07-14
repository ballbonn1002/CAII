package com.cubesofttech.action;

import com.cubesofttech.dao.FileUploadDAO;
import com.cubesofttech.dao.ItemCatalogDAO;
import com.cubesofttech.dao.JobsiteDAO;
import com.cubesofttech.dao.UserDAO;
import com.cubesofttech.dao.WorkLogDAO;
import com.cubesofttech.model.ArticleType;
import com.cubesofttech.model.FileUpload;
import com.cubesofttech.model.ItemCatalog;
import com.cubesofttech.model.User;
import com.cubesofttech.util.DateUtil;

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

public class ItemCatalogAction extends ActionSupport {

    private static final long serialVersionUID = 2280661337420278284L;

    Logger log = Logger.getLogger(getClass());
    HttpServletRequest request = ServletActionContext.getRequest();
    HttpServletResponse response = ServletActionContext.getResponse();

    private User onlineUser = (User) request.getSession().getAttribute("onlineUser");

    @Autowired
    private UserDAO userDAO;
    
    @Autowired
    private ItemCatalogDAO itemCatalogDAO;
    
    @Autowired
	private FileUploadDAO fileuploadDAO;
    
    private String itemEquipmentName;
    private String active;
    private Long itemCatalogId;

    
    public String getItemEquipmentName() {
		return itemEquipmentName;
	}
	public void setItemEquipmentName(String itemEquipmentName) {
		this.itemEquipmentName = itemEquipmentName;
	}
	public String getActive() {
		return active;
	}
	public void setActive(String active) {
		this.active = active;
	}
	public Long getItemCatalogId() {
        return itemCatalogId;
    }
    public void setItemCatalogId(Long itemCatalogId) {
        this.itemCatalogId = itemCatalogId;
    }
    
    

    public String item_catalog() {
        try {
            if (onlineUser == null) {
            	return ERROR;
            }
            
            List<ItemCatalog> itemCatalogList = itemCatalogDAO.findAll();
//            log.debug(itemCatalogList);
            
            request.setAttribute("itemCatalogList", itemCatalogList);

            return SUCCESS;

        } catch (Exception e) {
            e.printStackTrace();
            return ERROR;
        }
    }
    
    public String item_catalog_save() {
        try {
            if (onlineUser == null) {
                return ERROR;
            }

            if (itemEquipmentName == null || itemEquipmentName.trim().isEmpty()) {
                return ERROR;
            }

            Long maxId = itemCatalogDAO.getMaxId() + 1;
            ItemCatalog itemCatalog;

            if (itemCatalogId != null) {
//                log.debug("Edit itemCatalogId = " + itemCatalogId);
                itemCatalog = itemCatalogDAO.findById(itemCatalogId); 
                
                if (itemCatalog == null) {
                    return ERROR;
                }
            } else {
                itemCatalog = new ItemCatalog();
                itemCatalog.setItemCatalogId(maxId);
                itemCatalog.setUserCreate(onlineUser.getId());
                itemCatalog.setTimeCreate(DateUtil.getCurrentTime());
            }

            
            itemCatalog.setItemEquipmentName(itemEquipmentName);
            itemCatalog.setActive("1".equals(active) ? "1" : "0");
            itemCatalog.setUserUpdate(onlineUser.getId());
            itemCatalog.setTimeUpdate(DateUtil.getCurrentTime());

         
            if (itemCatalogId != null) {
                itemCatalogDAO.update(itemCatalog);
            } else {
                itemCatalogDAO.save(itemCatalog);  
            }

//            log.debug("Item Catalog Saved Successfully");
            return SUCCESS;

        } catch (Exception e) {
            e.printStackTrace();
            return ERROR;
        }
    }
    
    public String item_catalog_update() {
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
    
    
    
}