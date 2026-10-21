package com.cubesofttech.action;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.cubesofttech.dao.UnitMasterDAO;
import com.cubesofttech.model.UnitMaster;
import com.cubesofttech.model.User;
import com.cubesofttech.util.DateUtil;
import com.opensymphony.xwork2.ActionSupport;

public class UnitMasterAction extends ActionSupport {

    private static final Logger log = Logger.getLogger(UnitMasterAction.class);
    private static final long serialVersionUID = 1L;

    private final HttpServletRequest request = ServletActionContext.getRequest();
    private final HttpServletResponse response = ServletActionContext.getResponse();

    @Autowired
    private UnitMasterDAO unitMasterDAO;

    private Integer unitMasterId;
    private String unitName;

    public Integer getUnitMasterId() {
        return unitMasterId;
    }

    public void setUnitMasterId(Integer unitMasterId) {
        this.unitMasterId = unitMasterId;
    }

    public String getUnitName() {
        return unitName;
    }

    public void setUnitName(String unitName) {
        this.unitName = unitName;
    }

    /** หน้า list - โชว์ชื่อหน่วยกลางทั้งหมด + จำนวน unit_of_measure ที่ผูกอยู่ */
    public String list() {
        try {
            if (getOnlineUser() == null) {
                log.warn("list: no online user in session");
                return ERROR;
            }

            List<Map<String, Object>> unitMasters = unitMasterDAO.findAllWithUsageCount();
            if (unitMasters == null) {
                unitMasters = new ArrayList<Map<String, Object>>();
            }
            request.setAttribute("unitMasters", unitMasters);

            return SUCCESS;
        } catch (Exception e) {
            log.error("list failed", e);
            return ERROR;
        }
    }

    /** แก้ไขชื่อหน่วยกลาง (ยิงจาก modal Edit) - sync ไปยัง unit_of_measure ทุกแถวที่ผูกอยู่ด้วย */
    public String update() {
        try {
            User onlineUser = getOnlineUser();
            if (onlineUser == null) {
                log.warn("update: no online user in session");
                return writeJson(false, "กรุณาเข้าสู่ระบบ");
            }
            if (unitMasterId == null || unitName == null || unitName.trim().isEmpty()) {
                log.warn("update: missing required fields, unitMasterId=" + unitMasterId);
                return writeJson(false, "กรุณากรอกชื่อหน่วย");
            }

            String trimmedName = unitName.trim();

            UnitMaster existing = unitMasterDAO.findById(unitMasterId);
            if (existing == null) {
                log.warn("update: unit master not found, unitMasterId=" + unitMasterId);
                return writeJson(false, "ไม่พบข้อมูล");
            }

            if (unitMasterDAO.existsByNameExcludingId(trimmedName, unitMasterId)) {
                return writeJson(false, "ชื่อหน่วยนี้มีอยู่แล้ว");
            }

            existing.setUnitName(trimmedName);
            existing.setUserUpdate(onlineUser.getId());
            existing.setTimeUpdate(DateUtil.getCurrentTime());
            unitMasterDAO.update(existing);

            return writeJson(true, "แก้ไขสำเร็จ");
        } catch (Exception e) {
            log.error("update failed, unitMasterId=" + unitMasterId, e);
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

    private User getOnlineUser() {
        // getSession(false) กัน NPE และกันการสร้าง session ใหม่โดยไม่ตั้งใจ
        if (request == null || request.getSession(false) == null) {
            return null;
        }
        return (User) request.getSession(false).getAttribute("onlineUser");
    }
}
