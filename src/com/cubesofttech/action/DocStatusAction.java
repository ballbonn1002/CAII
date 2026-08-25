package com.cubesofttech.action;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.cubesofttech.dao.DocStatusDAO;
import com.cubesofttech.model.DocStatus;
import com.cubesofttech.model.User;
import com.cubesofttech.util.DateUtil;
import com.opensymphony.xwork2.ActionSupport;

public class DocStatusAction extends ActionSupport {

	
    private static final long serialVersionUID = 2280661337420278284L;

    Logger log = Logger.getLogger(getClass());
    HttpServletRequest request = ServletActionContext.getRequest();
    HttpServletResponse response = ServletActionContext.getResponse();

    private User onlineUser = (User) request.getSession().getAttribute("onlineUser");


	@Autowired
	private DocStatusDAO docStatusDAO;

	private DocStatus docStatus;

	public String getDocStatusId() {
		return docStatus != null ? docStatus.getDocStatusId() : null;
	}

	public void setDocStatusId(String docStatusId) {
		if (docStatus == null) {
			docStatus = new DocStatus();
		}
		docStatus.setDocStatusId(docStatusId);
	}

	public DocStatus getDocStatus() {
		return docStatus;
	}

	public void setDocStatus(DocStatus docStatus) {
		this.docStatus = docStatus;
	}

	private static final Comparator<DocStatus> BY_STATUS_CODE = (a, b) -> {
		try {
			return Long.compare(Long.parseLong(a.getStatusCode()), Long.parseLong(b.getStatusCode()));
		} catch (NumberFormatException e) {
			return a.getStatusCode().compareTo(b.getStatusCode());
		}
	};

	public String list() {
		try {
			if (onlineUser == null) {
				return ERROR;
			}

			List<DocStatus> allStatusList = docStatusDAO.findAll();

			Map<String, List<DocStatus>> statusGroupMap = new LinkedHashMap<>();
			for (DocStatus d : allStatusList) {
				statusGroupMap.computeIfAbsent(d.getPage(), k -> new ArrayList<>()).add(d);
			}

			for (List<DocStatus> groupList : statusGroupMap.values()) {
				Collections.sort(groupList, BY_STATUS_CODE);
			}

			request.setAttribute("statusGroupMap", statusGroupMap);

			return SUCCESS;
		} catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			return ERROR;
		}
	}

	public String performEdit() {
		try {
			if (onlineUser == null) {
				return ERROR;
			}
			if (docStatus == null || docStatus.getDocStatusId() == null) {
				return writeJson(false, "docStatusId required");
			}

			DocStatus existing = docStatusDAO.findById(docStatus.getDocStatusId());
			if (existing == null) {
				return writeJson(false, "ไม่พบข้อมูล");
			}

			existing.setStatusName(docStatus.getStatusName());
			existing.setDescription(docStatus.getDescription());
			existing.setColor(docStatus.getColor());
			existing.setUserUpdate(onlineUser.getId());
			existing.setTimeUpdate(DateUtil.getCurrentTime());
			docStatusDAO.update(existing);

			return writeJson(true, "แก้ไขสำเร็จ");
		} catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			return writeJson(false, "เกิดข้อผิดพลาด");
		}
	}

	private String writeJson(boolean success, String message) {
		try {
			response.setContentType("application/json;charset=UTF-8");
			StringBuilder sb = new StringBuilder();
			sb.append("{\"success\":").append(success);
			if (message != null) {
				sb.append(",\"message\":\"").append(message.replace("\\", "\\\\").replace("\"", "\\\"")).append("\"");
			}
			sb.append("}");
			response.getWriter().write(sb.toString());
			response.getWriter().flush();
		} catch (Exception e) {
			log.error("writeJson failed", e);
		}
		return NONE;
	}

}
