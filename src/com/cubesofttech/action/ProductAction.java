package com.cubesofttech.action;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.cubesofttech.dao.ProductDAO;
import com.opensymphony.xwork2.ActionSupport;

public class ProductAction extends ActionSupport {
    private static final Logger log = Logger.getLogger(ProductAction.class);
    private static final long serialVersionUID = 1L;

    private final HttpServletRequest request = ServletActionContext.getRequest();
    private final HttpServletResponse response = ServletActionContext.getResponse();
    
    @Autowired
    private ProductDAO productDAO;

    public String stockConsList() {
        try {
            List<Map<String, Object>> products = productDAO.findAllConsWithSubProducts();
            log.debug(products);
            request.setAttribute("products", products);

            return SUCCESS;
        } catch (Exception e) {
            log.error("stockConsList failed", e);
            return ERROR;
        }
    }
}