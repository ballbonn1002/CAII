package com.cubesofttech.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.cubesofttech.dao.WarehouseDAO;
import com.cubesofttech.model.User;
import com.cubesofttech.model.Warehouse;
import com.cubesofttech.util.DateUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.opensymphony.xwork2.ActionSupport;

public class WarehouseAction extends ActionSupport {
	@Autowired
	private WarehouseDAO warehouseDAO;

	private static final long serialVersionUID = 1L;
	HttpServletRequest request = ServletActionContext.getRequest();
	HttpServletResponse response = ServletActionContext.getResponse();
	private static final Logger log = Logger.getLogger(WarehouseAction.class);

	private String warehouseName;
	private String warehouseDescription;
	private Long parentId;
	private Long warehouseId;

	public Long setWarehouseId(Long warehouseId) {
		return this.warehouseId = warehouseId;
	}

	public Long setParentId(Long parentId) {
		return this.parentId = parentId;
	}

	public void setWarehouseName(String warehouseName) {
		this.warehouseName = warehouseName;
	}

	public void setWarehouseDescription(String warehouseDescription) {
		this.warehouseDescription = warehouseDescription;
	}

	public String list() {
		try {
			
			User user = (User) request.getSession().getAttribute("user");

			if (user == null) {
				log.error("User session is null. Session timeout or user not logged in.");

				response.setContentType("application/json;charset=UTF-8");
				response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);

				Map<String, Object> error = new HashMap<>();
				error.put("message", "Session timeout,  Please login again.");

				new ObjectMapper().writeValue(response.getWriter(), error);
				return ERROR;
			}
			
			List<Warehouse> warehouses = warehouseDAO.findAll();
			request.setAttribute("warehouseList", warehouses);
			log.info("Retrieved " + warehouses.size() + " warehouses.");
			return SUCCESS;
		} catch (Exception e) {
			log.error("Error occurred while retrieving warehouses: " + e.getMessage(), e);
			e.printStackTrace();
			return ERROR;
		}
	}

	public String save() throws Exception {
		try {

			User user = (User) request.getSession().getAttribute("user");

			if (user == null) {
				log.error("User session is null. Session timeout or user not logged in.");

				response.setContentType("application/json;charset=UTF-8");
				response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);

				Map<String, Object> error = new HashMap<>();
				error.put("message", "Session timeout,  Please login again.");

				new ObjectMapper().writeValue(response.getWriter(), error);
				return ERROR;
			}

			if (warehouseName == null || warehouseName.isEmpty()) {
				log.error("Warehouse name is null or empty.");

				response.setContentType("application/json;charset=UTF-8");
				response.setStatus(HttpServletResponse.SC_BAD_REQUEST);

				Map<String, Object> error = new HashMap<>();
				error.put("message", "Warehouse name is required.");

				new ObjectMapper().writeValue(response.getWriter(), error);

				return ERROR;
			}

			Warehouse warehouse = new Warehouse();
			warehouse.setWarehouseName(warehouseName);
			warehouse.setDescription(warehouseDescription);
			warehouse.setParent(parentId == null || parentId == 0 ? 0 : parentId);
			warehouse.setUserCreate(user.getId());
			warehouse.setTimeCreate(DateUtil.getCurrentTime());

			warehouseDAO.save(warehouse);

			log.info("Warehouse saved successfully with ID: " + warehouse.getWarehouseId());

			response.setContentType("application/json;charset=UTF-8");
			response.setStatus(HttpServletResponse.SC_CREATED);

			Map<String, Object> result = new HashMap<>();
			result.put("id", warehouse.getWarehouseId());
			result.put("name", warehouse.getWarehouseName());
			result.put("description", warehouse.getDescription());
			result.put("parentId", warehouse.getParent());

			new ObjectMapper().writeValue(response.getWriter(), result);

			return NONE;
		} catch (Exception e) {
			log.error("Error occurred while saving warehouse: " + e.getMessage(), e);

			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			response.setContentType("application/json;charset=UTF-8");

			Map<String, Object> error = new HashMap<>();
			error.put("message", "Internal Server Error");

			new ObjectMapper().writeValue(response.getWriter(), error);

			return NONE;
		}
	}

	public String update() throws Exception {

		try {

			User user = (User) request.getSession().getAttribute("user");
			response.setContentType("application/json;charset=UTF-8");

			if (user == null) {
				log.error("User session is null. Session timeout or user not logged in.");

				response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
				Map<String, Object> error = new HashMap<>();
				error.put("message", "Session timeout, Please login again.");

				new ObjectMapper().writeValue(response.getWriter(), error);
				return ERROR;
			}

			if (warehouseId == null || warehouseId <= 0) {
				log.error("Warehouse id is null or invalid.");

				response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
				Map<String, Object> error = new HashMap<>();
				error.put("message", "Warehouse id is required.");

				new ObjectMapper().writeValue(response.getWriter(), error);
				return ERROR;
			}

			if (warehouseName == null || warehouseName.isEmpty()) {
				log.error("Warehouse name is null or empty.");

				response.setStatus(HttpServletResponse.SC_BAD_REQUEST);

				Map<String, Object> error = new HashMap<>();
				error.put("message", "Warehouse name is required.");

				new ObjectMapper().writeValue(response.getWriter(), error);

				return ERROR;
			}

			Warehouse warehouse = warehouseDAO.findById(warehouseId);

			if (warehouse == null) {
				log.error("Warehouse not found for id: " + warehouseId);
				response.setStatus(HttpServletResponse.SC_NOT_FOUND);

				Map<String, Object> error = new HashMap<>();
				error.put("message", "Warehouse not found.");

				new ObjectMapper().writeValue(response.getWriter(), error);
				return ERROR;
			}

			warehouse.setWarehouseName(warehouseName);
			warehouse.setDescription(warehouseDescription);
			warehouse.setUserUpdate(user.getId());
			warehouse.setTimeUpdate(DateUtil.getCurrentTime());

			warehouseDAO.update(warehouse);

			log.info("Warehouse updated successfully with ID: " + warehouse.getWarehouseId());

			Map<String, Object> result = new HashMap<>();
			result.put("id", warehouse.getWarehouseId());
			result.put("parentId", warehouse.getParent());
			result.put("name", warehouse.getWarehouseName());
			result.put("description", warehouse.getDescription());

			response.setStatus(HttpServletResponse.SC_OK);
			new ObjectMapper().writeValue(response.getWriter(), result);

			return NONE;

		} catch (Exception e) {
			log.error("Error occurred while updating warehouse: " + e.getMessage(), e);

			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			response.setContentType("application/json;charset=UTF-8");

			Map<String, Object> error = new HashMap<>();
			error.put("message", "Internal Server Error");

			new ObjectMapper().writeValue(response.getWriter(), error);

			return NONE;
		}

	}

	public String delete() throws Exception {
		try {
			User user = (User) request.getSession().getAttribute("user");
			response.setContentType("application/json;charset=UTF-8");

			if (user == null) {
				response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
				Map<String, Object> error = new HashMap<>();
				error.put("message", "Session timeout, Please login again.");

				new ObjectMapper().writeValue(response.getWriter(), error);
				return ERROR;
			}

			Long warehouseId = Long.parseLong(request.getParameter("id"));

			if (warehouseId == null || warehouseId <= 0) {
				response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
				Map<String, Object> error = new HashMap<>();
				error.put("message", "Warehouse id is required.");

				new ObjectMapper().writeValue(response.getWriter(), error);
				return ERROR;
			}

			Warehouse warehouse = warehouseDAO.findById(warehouseId);

			if (warehouse == null) {
				response.setStatus(HttpServletResponse.SC_NOT_FOUND);

				Map<String, Object> error = new HashMap<>();
				error.put("message", "Warehouse not found.");

				new ObjectMapper().writeValue(response.getWriter(), error);
				return ERROR;
			}

			List<Warehouse> childWarehouses = warehouseDAO.findByParentId(warehouseId);

			for (Warehouse child : childWarehouses) {
				warehouseDAO.delete(child);
			}

			warehouseDAO.delete(warehouse);

			response.setStatus(HttpServletResponse.SC_OK);
			Map<String, Object> result = new HashMap<>();
			result.put("message", "Warehouse deleted successfully.");
			new ObjectMapper().writeValue(response.getWriter(), result);

			return NONE;

		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			response.setContentType("application/json;charset=UTF-8");

			Map<String, Object> error = new HashMap<>();
			error.put("message", "Internal Server Error");

			new ObjectMapper().writeValue(response.getWriter(), error);

			return NONE;
		}
	}

}
