package com.cubesofttech.action;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.cubesofttech.dao.DepartmentDAO;
import com.cubesofttech.model.Department;
import com.cubesofttech.model.User;
import com.cubesofttech.util.DateUtil;
import com.opensymphony.xwork2.ActionSupport;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

public class DepartmentAction extends ActionSupport {

    private static final Logger log = Logger.getLogger(DepartmentAction.class);
    private static final long serialVersionUID = 1L;

    @Autowired
    public DepartmentDAO departmentDAO;

    HttpServletRequest request = ServletActionContext.getRequest();
    HttpServletResponse response = ServletActionContext.getResponse();

    private List<Department> departmentList;
    private Department department;
    private String error;
    private String flag;

    public List<Department> getDepartmentList() { return departmentList; }
    public Department getDepartment() { return department; }
    public String getError() { return error; }
    public String getFlag() { return flag; }

    /** -------------------- LIST -------------------- */
    public String list() {
        try {
            departmentList = departmentDAO.findAll();
            return SUCCESS;
        } catch (Exception e) {
            log.error("[list] error", e);
            return ERROR;
        }
    }

    /** -------------------- DELETE -------------------- */
    public String deleteDepartment() {
        try {
            String idDepart = trimOrNull(request.getParameter("id"));
            if (idDepart == null) idDepart = trimOrNull(request.getParameter("departmentId"));
            if (idDepart == null) {
                error = "Missing departmentId";
                return INPUT;
            }

            Department depart = departmentDAO.findById(idDepart);
            if (depart == null) {
                error = "Department not found: " + idDepart;
                return INPUT;
            }

            departmentDAO.delete(depart);

            departmentList = departmentDAO.findAll();
            return SUCCESS;
        } catch (Exception e) {
            log.error("[deleteDepartment] error", e);
            return ERROR;
        }
    }

    /** -------------------- UPDATE -------------------- */
    public String updateDepart() {
        try {
            String departmentId = trimOrNull(request.getParameter("departmentId"));
            if (departmentId == null) departmentId = trimOrNull(request.getParameter("id"));
            if (departmentId == null) departmentId = trimOrNull(request.getParameter("ID"));

            if (departmentId == null) {
                error = "Missing departmentId";
                return INPUT;
            }

            Department dept = departmentDAO.findById(departmentId);
            if (dept == null) {
                error = "Department not found: " + departmentId;
                return INPUT;
            }

            department = dept; 
            return SUCCESS;
        } catch (Exception e) {
            log.error("[updateDepart] error", e);
            return ERROR;
        }
    }

    /** -------------------- EDIT -------------------- */
    public String editDepart() {
        try {
            User ur = (User) request.getSession().getAttribute("onlineUser");
            String logonUser = (ur != null && ur.getId() != null) ? ur.getId() : "system";

            String departmentId = trimOrNull(request.getParameter("departmentId"));
            if (departmentId == null) departmentId = trimOrNull(request.getParameter("id"));
            if (departmentId == null) departmentId = trimOrNull(request.getParameter("ID"));

            if (departmentId == null) {
                error = "Missing departmentId (or ID)";
                return INPUT;
            }

            Department depart = departmentDAO.findById(departmentId);
            if (depart == null) {
                error = "Department not found: " + departmentId;
                return INPUT;
            }

            if (hasAnyParam("name")) {
                String name = request.getParameter("name");
                if (name != null && !name.trim().isEmpty()) {
                    depart.setName(name.trim());
                }
            }

            Param descParam = firstPresent("deptdes", "description");
            if (descParam.present) {
                String desc = descParam.value;
                depart.setDescription(desc == null ? "" : desc.trim());
            }

            Param preParam = firstPresent("prefixId", "deptpre");
            if (preParam.present) {
                String pre = preParam.value;
                depart.setPrefixId(pre == null ? "" : pre.trim());
            }

            Timestamp ts = nowOrFrom(request.getParameter("date"), request.getParameter("time"));
            depart.setUserupdate(logonUser);
            depart.setTimeUpdate(ts);

            departmentDAO.update(depart);

            departmentList = departmentDAO.findAll();
            return SUCCESS;

        } catch (Exception e) {
            log.error("[editDepart] error", e);
            return ERROR;
        }
    }

    /** -------------------- ADD -------------------- */
    public String addDepart() {
        try {
            return SUCCESS;
        } catch (Exception e) {
            log.error("[addDepart] error", e);
            return ERROR;
        }
    }

    /** -------------------- SAVE -------------------- */
    public String saveDepart() {
        try {
            User ur = (User) request.getSession().getAttribute("onlineUser");
            String logonUser = (ur != null && ur.getId() != null) ? ur.getId() : "system";

            String departmentId = trimOrNull(request.getParameter("departmentId"));
            if (departmentId == null) departmentId = trimOrNull(request.getParameter("ID"));
            String name = trimOrNull(request.getParameter("name"));

            if (departmentId == null || name == null) {
                error = "departmentId (or ID) and name are required.";
                return INPUT;
            }

            Timestamp ts = nowOrFrom(request.getParameter("date"), request.getParameter("time"));

            Department departmentCheck = departmentDAO.findById(departmentId);
            if (departmentCheck != null) {
                flag = "1"; 
                return INPUT;
            }

            Department depart = new Department();
            depart.setId(departmentId);
            depart.setName(name);

            Param descParam = firstPresent("deptdes", "description");
            if (descParam.present) {
                String desc = descParam.value;
                depart.setDescription(desc == null ? "" : desc.trim());
            }
            Param preParam = firstPresent("deptpre", "prefixId");
            if (preParam.present) {
                String pre = preParam.value;
                depart.setPrefixId(pre == null ? "" : pre.trim());
            }

            depart.setTimeCreate(ts);
            depart.setUsercreate(logonUser);

            departmentDAO.save(depart);

            String target = request.getContextPath()
                    + "/editDepartment.action?departmentId="
                    + URLEncoder.encode(departmentId, StandardCharsets.UTF_8.name());
            response.sendRedirect(target);
            return null;

        } catch (Exception e) {
            log.error("[saveDepart] error", e);
            return ERROR;
        }
    }

    /** -------------------- UTIL -------------------- */
    private static String trimOrNull(String s) {
        if (s == null) return null;
        String t = s.trim();
        return t.isEmpty() ? null : t;
    }

    private boolean hasParam(String name) {
        Map<String, String[]> map = request.getParameterMap();
        return map != null && map.containsKey(name);
    }

    private Param firstPresent(String... names) {
        for (String n : names) {
            if (hasParam(n)) {
                return new Param(request.getParameter(n), true);
            }
        }
        return new Param(null, false);
    }

    private boolean hasAnyParam(String... names) {
        for (String n : names) {
            if (hasParam(n)) return true;
        }
        return false;
    }

    private Timestamp nowOrFrom(String date, String time) {
        try {
            if (date != null && time != null) {
                return DateUtil.dateToTimestamp(date, time);
            }
        } catch (Exception e) {
            log.warn("[nowOrFrom] parse date/time fail, fallback to now", e);
        }
        return new Timestamp(System.currentTimeMillis());
    }

    private static class Param {
        final String value;
        final boolean present;
        Param(String value, boolean present) {
            this.value = value;
            this.present = present;
        }
    }
    
    public String checkDuplicateDepartmentId() {
        try {
            response.setCharacterEncoding("UTF-8");
            response.setContentType("text/plain; charset=UTF-8");

            String id = request.getParameter("departmentId");
            if (id == null || id.trim().isEmpty()) {
                response.getWriter().write("empty");
                return NONE;
            }

            Department dept = departmentDAO.findById(id.trim());
            response.getWriter().write(dept != null ? "duplicate" : "ok");

        } catch (Exception e) {
            log.error("[checkDuplicateDepartmentId] error", e);
            try {
                response.getWriter().write("error");
            } catch (Exception ignored) {}
        }
        return NONE;
    }
}
