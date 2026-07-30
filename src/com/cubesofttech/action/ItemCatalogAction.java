package com.cubesofttech.action;

import com.cubesofttech.dao.FileUploadDAO;
import com.cubesofttech.dao.CatalogEquipmentDAO;
import com.cubesofttech.dao.JobsiteDAO;
import com.cubesofttech.dao.ProductDAO;
import com.cubesofttech.dao.UserDAO;
import com.cubesofttech.dao.WorkLogDAO;
import com.cubesofttech.model.ArticleType;
import com.cubesofttech.model.FileUpload;
import com.cubesofttech.model.Product;
import com.cubesofttech.model.CatalogEquipment;
import com.cubesofttech.model.User;
import com.cubesofttech.util.DateUtil;

import java.io.File;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

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
    private CatalogEquipmentDAO catalogEquipmentDAO;
    
    @Autowired
	private FileUploadDAO fileuploadDAO;
    
    @Autowired
    private ProductDAO productDAO;
    
    private String catalogEquipmentName;
    private String eqptActive;
    private Long catalogEquipmentId;
    private String subProductActive;
    private String consActive;
    private Integer catalogConsumablesId;
	
	public CatalogEquipmentDAO getCatalogEquipmentDAO() {
		return catalogEquipmentDAO;
	}

	public void setCatalogEquipmentDAO(CatalogEquipmentDAO catalogEquipmentDAO) {
		this.catalogEquipmentDAO = catalogEquipmentDAO;
	}

	public String getCatalogEquipmentName() {
		return catalogEquipmentName;
	}

	public void setCatalogEquipmentName(String catalogEquipmentName) {
		this.catalogEquipmentName = catalogEquipmentName;
	}

	public String getEqptActive() {
		return eqptActive;
	}

	public void setEqptActive(String eqptActive) {
		this.eqptActive = eqptActive;
	}

	public Long getCatalogEquipmentId() {
		return catalogEquipmentId;
	}

	public void setCatalogEquipmentId(Long catalogEquipmentId) {
		this.catalogEquipmentId = catalogEquipmentId;
	}

	public String getSubProductActive() {
		return subProductActive;
	}

	public void setSubProductActive(String subProductActive) {
		this.subProductActive = subProductActive;
	}

	public String getConsActive() {
		return consActive;
	}

	public void setConsActive(String consActive) {
		this.consActive = consActive;
	}

	public Integer getCatalogConsumablesId() {
		return catalogConsumablesId;
	}

	public void setCatalogConsumablesId(Integer catalogConsumablesId) {
		this.catalogConsumablesId = catalogConsumablesId;
	}

	private boolean success;
	private String message;

	public boolean isSuccess() { return success; }
	public String getMessage() { return message; }
	
	public String item_catalog() {
	    try {
	        if (onlineUser == null) {
	            return ERROR;
	        }

	        List<CatalogEquipment> catalogEquipmentList = catalogEquipmentDAO.findAll();
	        
	        List<Map<String, Object>> catalogConsumablesList = productDAO.findCatalogItemsWithSubProducts();
	        
	        for (Map<String, Object> row : catalogConsumablesList) {
	            String sub = (String) row.get("sub_product_names");
	            if (sub != null) {
	                row.put("subProductNames", Arrays.asList(sub.split(",")));
	            }
	        }

	        request.setAttribute("catalogEqptList", catalogEquipmentList);
	        request.setAttribute("catalogConsList", catalogConsumablesList);

	        return SUCCESS;

	    } catch (Exception e) {
	        e.printStackTrace();
	        return ERROR;
	    }
	}
    
    public String catalog_equipment_save() {
        try {
            if (onlineUser == null) {
                return ERROR;
            }

            if (catalogEquipmentName == null || catalogEquipmentName.trim().isEmpty()) {
                return ERROR;
            }

            Long maxId = catalogEquipmentDAO.getMaxId() + 1;
            CatalogEquipment catalogEquipment;

            if (catalogEquipmentId != null) {
            	catalogEquipment = catalogEquipmentDAO.findById(catalogEquipmentId); 
                
                if (catalogEquipment == null) {
                    return ERROR;
                }
            } else {
            	catalogEquipment = new CatalogEquipment();
            	catalogEquipment.setCatalogEquipmentId(maxId);
            	catalogEquipment.setUserCreate(onlineUser.getId());
            	catalogEquipment.setTimeCreate(DateUtil.getCurrentTime());
            }

            catalogEquipment.setItemsType("1");
            catalogEquipment.setCatalogEquipmentName(catalogEquipmentName);
            catalogEquipment.setActive("1".equals(eqptActive) ? "1" : "0");
            catalogEquipment.setUserUpdate(onlineUser.getId());
            catalogEquipment.setTimeUpdate(DateUtil.getCurrentTime());

         
            if (catalogEquipmentId != null) {
            	catalogEquipmentDAO.update(catalogEquipment);
            } else {
            	catalogEquipmentDAO.save(catalogEquipment);  
            }

            return SUCCESS;

        } catch (Exception e) {
            e.printStackTrace();
            return ERROR;
        }
    }
    
    public String catalog_consumables_update() {
        try {
            if (onlineUser == null) {
                return ERROR;
            }
            if (catalogConsumablesId == null) {
                return ERROR;
            }

            Product catalogConsumables = productDAO.findById(catalogConsumablesId);
            if (catalogConsumables == null) {
                return ERROR;
            }

            if (consActive != null) {
                String activeVal = "1".equals(consActive) ? "1" : "0";
                catalogConsumables.setActive(activeVal);
                productDAO.updateActiveByParentId(catalogConsumablesId, activeVal, onlineUser.getId());
            }
            if (subProductActive != null) {
                String subActiveVal = "1".equals(subProductActive) ? "1" : "0";
                catalogConsumables.setSubProductActive(subActiveVal);
                productDAO.updateSubProductActiveByParentId(catalogConsumablesId, subActiveVal, onlineUser.getId());
            }

            catalogConsumables.setUserUpdate(onlineUser.getId());
            catalogConsumables.setTimeUpdate(DateUtil.getCurrentTime());
            productDAO.update(catalogConsumables);
            
            success = true;
            message = "Item saved successfully!";
            return SUCCESS;

        } catch (Exception e) {
            e.printStackTrace();
            return ERROR;
        }
    }
    
    public String catalog_equipment_delete() {
    	try {
    		if (onlineUser == null) {
            	return ERROR;
            }
    		
    		if(catalogEquipmentId != null) {
    			CatalogEquipment itemId = catalogEquipmentDAO.findById(catalogEquipmentId);
    			if(itemId != null) {
    				catalogEquipmentDAO.delete(itemId);
    			}else {
    				return ERROR;
    			}
    		}
    		
    		return SUCCESS;
    	} catch (Exception e) {
    		 e.printStackTrace();
    		return ERROR;
    	}
    }
    
    
    
}