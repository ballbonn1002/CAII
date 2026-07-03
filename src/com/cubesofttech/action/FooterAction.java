package com.cubesofttech.action;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.cubesofttech.dao.FooterDAO;
import com.cubesofttech.model.Footer;
import com.cubesofttech.model.User;
import com.opensymphony.xwork2.ActionSupport;

public class FooterAction extends ActionSupport {

	private static final long serialVersionUID = 1L;
	public static final String ONLINEUSER = "onlineUser";
	private static final Logger log = Logger.getLogger(FooterAction.class);
	HttpServletRequest request = ServletActionContext.getRequest();
	HttpServletResponse response = ServletActionContext.getResponse();

	@Autowired
	private FooterDAO footerDAO;

	// ใช้ Model Footer แทน
	private List<Footer> sequenceList;
	private String message;

	private String orderedIds;

	public String getOrderedIds() {
		return orderedIds;
	}

	public void setOrderedIds(String orderedIds) {
		this.orderedIds = orderedIds;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String footerList() {
		try {

			User ur = (User) request.getSession().getAttribute("onlineUser");

			if (ur == null) {
				return ERROR;
			}

			List<Map<String, Object>> parentFooterList = footerDAO.findAllParentFooter();

			Map<String, List<Footer>> parentFooterMap = new HashMap<>();

			for (Map<String, Object> parent : parentFooterList) {

				Object footerIdObj = parent.get("footer_id");
				if (footerIdObj != null) {
					String parentIdStr = footerIdObj.toString();

					Long parentIdLong = Long.valueOf(parentIdStr);

					List<Footer> childFooterList = footerDAO.findByParentId(parentIdLong);

					parentFooterMap.put(parentIdStr, childFooterList);
				}
			}

			request.setAttribute("parentFooterList", parentFooterList);
			request.setAttribute("parentFooterMap", parentFooterMap);
			return SUCCESS;

		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	public String footerAdd() {
		try {
			return SUCCESS;

		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	public String footerSave() {
		try {
			User ur = (User) request.getSession().getAttribute("onlineUser");

			if (ur == null) {
				return ERROR;
			}

			String titleNameEN = request.getParameter("titleNameEN");
			String titleNameTH = request.getParameter("titleNameTH");
			String parentIdStr = request.getParameter("parentId");
			String url = request.getParameter("url");
			String statusStr = request.getParameter("status");

			String status = "true".equals(statusStr) ? "1" : "0";

			Timestamp now = Timestamp.valueOf(LocalDateTime.now());

			Long newId = footerDAO.getMaxId() + 1;

			Footer newFooter = new Footer();
			newFooter.setFooter_id(newId);
			newFooter.setFooter_name(titleNameEN);
			newFooter.setFooter_name_th(titleNameTH);
			newFooter.setFooter_url(url);
			newFooter.setParent_footer_id(parentIdStr == null || parentIdStr.isEmpty() ? "0" : parentIdStr);
			newFooter.setStatus(status);
			newFooter.setTimeCreate(now);
			newFooter.setTimeUpdate(now);
			newFooter.setUserCreate(ur.getId());
			newFooter.setUserUpdate(ur.getId());

			footerDAO.save(newFooter);

			return SUCCESS;

		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	public String footerEdit() {
		try {
			User ur = (User) request.getSession().getAttribute("onlineUser");

			if (ur == null) {
				return ERROR;
			}

			String parentIdStr = request.getParameter("parentId");

			Long parentIdLong = Long.valueOf(parentIdStr);

			Footer footer = footerDAO.findById(parentIdLong);

			List<Footer> childFooterList = footerDAO.findByParentId(parentIdLong);

			request.setAttribute("childFooterList", childFooterList);
			request.setAttribute("titleNameEN", footer.getFooter_name());
			request.setAttribute("titleNameTH", footer.getFooter_name_th());
			request.setAttribute("url", footer.getFooter_url());
			request.setAttribute("status", footer.getStatus().equals("1") ? "true" : "false");
			request.setAttribute("parentId", parentIdStr);
			return SUCCESS;

		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	public String footerDelete() {
		try {
			User ur = (User) request.getSession().getAttribute("onlineUser");

			if (ur == null) {
				return ERROR;
			}

			String footerIdStr = request.getParameter("footerId");

			Long fLong = Long.valueOf(footerIdStr);

			Footer footer = footerDAO.findById(fLong);

			footerDAO.delete(footer);

			return SUCCESS;

		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	public String footerUpdate() {
		try {
			User ur = (User) request.getSession().getAttribute("onlineUser");

			if (ur == null) {
				return ERROR;
			}

			String parentIdStr = request.getParameter("parentId");
			String childIdStr = request.getParameter("childId");
			String titleNameEN = request.getParameter("titleNameEN");
			String titleNameTH = request.getParameter("titleNameTH");
			String url = request.getParameter("url");
			String statusStr = request.getParameter("status");

			Footer footer = new Footer();

			if (childIdStr != null && !childIdStr.isEmpty()) {
				Long childIdLong = Long.valueOf(childIdStr);
				footer = footerDAO.findById(childIdLong);
			} else {
				Long parentIdLong = Long.valueOf(parentIdStr);
				footer = footerDAO.findById(parentIdLong);
			}

			Timestamp now = Timestamp.valueOf(LocalDateTime.now());

			String status = "true".equals(statusStr) ? "1" : "0";

			footer.setFooter_name(titleNameEN);
			footer.setFooter_name_th(titleNameTH);
			footer.setFooter_url(url);
			footer.setStatus(status);
			footer.setTimeUpdate(now);
			footer.setUserUpdate(ur.getId());
			footerDAO.update(footer);
			return SUCCESS;

		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	// 2. Method สำหรับอัปเดต (ไม่ต้องใช้ sequenceList แล้ว)
	public String footerUpdateSequence() {
		try {
			log.debug("Received orderedIds: " + orderedIds);

			if (orderedIds != null && !orderedIds.isEmpty()) {
				// หั่น String ด้วยลูกน้ำ จะได้ Array ของ ID ที่เรียงลำดับมาแล้ว
				String[] idArray = orderedIds.split(",");

				int seq = 1; // เริ่ม Sequence ที่ 1

				for (String idStr : idArray) {
					long targetId = Long.parseLong(idStr.trim());

					// ดึงข้อมูลเก่ามาอัปเดตแค่ฟิลด์ Sequence
					Footer existingFooter = footerDAO.findById(targetId);
					if (existingFooter != null) {
						existingFooter.setSequence(seq);
						footerDAO.update(existingFooter);
					}

					seq++; // บวกค่า Sequence ไปเรื่อยๆ สำหรับรอบถัดไป
				}
			}

			message = "Success";
			return SUCCESS;

		} catch (Exception e) {
			e.printStackTrace();
			message = "Error: " + e.getMessage();
			return ERROR;
		}
	}

}
