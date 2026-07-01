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
import com.cubesofttech.dao.PositionDAO;
import com.cubesofttech.model.Position;
import com.cubesofttech.model.User;
import com.cubesofttech.util.DateUtil;
import com.opensymphony.xwork2.ActionSupport;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;


public class PositionAction extends ActionSupport {

    private static final Logger log = Logger.getLogger(PositionAction.class);
    private static final long serialVersionUID = 1L;

    @Autowired
    public PositionDAO positionDAO;
    @Autowired
    public DepartmentDAO departmentDAO;

    private final HttpServletRequest request  = ServletActionContext.getRequest();
    private final HttpServletResponse response = ServletActionContext.getResponse();

    private List<Position> positionList;
    private List<Map<String, Object>> departmentList;
    private Position position;
    private String error;
    private String flag;

    public List<Position> getPositionList() { return positionList; }
    public List<Map<String, Object>> getDepartmentList() { return departmentList; }
    public Position getPosition() { return position; }
    public String getError() { return error; }
    public String getFlag() { return flag; }

    /** -------------------- LIST -------------------- */
    public String list() {
        try {
        	User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			if (onlineUser == null) {
				return ERROR;
			}
            positionList = positionDAO.findAll();
            return SUCCESS;
        } catch (Exception e) {
            log.error("[list] error", e);
            return ERROR;
        }
    }

    /** -------------------- ADD -------------------- */
    public String addPosition() {
        try {
        	User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			if (onlineUser == null) {
				return ERROR;
			}
            departmentList = departmentDAO.sequense();
            return SUCCESS;
        } catch (Exception e) {
            log.error("[addPosition] error", e);
            return ERROR;
        }
    }
    
    /** -------------------- SAVE -------------------- */
    public String savePosition() {
        try {
            User ur = (User) request.getSession().getAttribute("onlineUser");
            String logonUser = (ur != null && ur.getId() != null)
                    ? ur.getId()
                    : "system";

            String positionId = trimOrNull(request.getParameter("positionId"));
            if (positionId == null) {
                positionId = trimOrNull(request.getParameter("position_id"));
            }

            String departmentId = trimOrNull(request.getParameter("departmentId"));
            String name = trimOrNull(request.getParameter("name"));
            String description = request.getParameter("description");

            // Required validation
            if (positionId == null) {
            	addFieldError("positionId", "Position ID is required.");
                departmentList = departmentDAO.sequense();
                return INPUT;
            }
            
            if (name == null) {
            	addFieldError("name", "Position Name is required.");
                departmentList = departmentDAO.sequense();
                return INPUT;
            }


            if (departmentId == null) {
            	addFieldError("departmentId", "Please select a department.");
                departmentList = departmentDAO.sequense();
                return INPUT;
            }

            // Position ID validation
            if (!positionId.matches("^[A-Za-z0-9_-]{1,4}$")) {
                addFieldError(
                        "positionId",
                        "Position ID must be 1-4 characters long and can contain only A–Z, a–z, 0–9, _ or -."
                    );
                departmentList = departmentDAO.sequense();
                return INPUT;
            }

            // Duplicate validation
            if (positionDAO.findById(positionId) != null) {
                flag = "1"; // duplicate flag
                addFieldError("positionId", "Position ID is already in use.");
                departmentList = departmentDAO.sequense();
                return INPUT;
            }

            Timestamp ts = new Timestamp(System.currentTimeMillis());

            Position p = new Position();
            p.setPositionId(positionId);
            p.setDepartmentId(departmentId);
            p.setName(name);
            p.setDescription(description != null ? description.trim() : "");
            p.setUserCreate(logonUser);
            p.setUserUpdate(logonUser);
            p.setTimeCreate(ts);
            p.setTimeUpdate(ts);

            positionDAO.save(p);

            String ns = org.apache.struts2.ServletActionContext
                    .getActionMapping()
                    .getNamespace();

            if (ns == null) {
                ns = "";
            }
            if ("/".equals(ns)) {
                ns = "";
            }

            String target = request.getContextPath()
                    + ns
                    + "/editPosition.action?positionId="
                    + URLEncoder.encode(positionId, StandardCharsets.UTF_8.name());

            response.sendRedirect(response.encodeRedirectURL(target));
            return null;

        } catch (Exception e) {
            log.error("[savePosition] error", e);
            return ERROR;
        }
    }

    /** -------------------- EDIT -------------------- */
    public String PositionEdit() {
        try {
        	User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			if (onlineUser == null) {
				return ERROR;
			}
            String positionId = trimOrNull(request.getParameter("position_id"));
            if (positionId == null) positionId = trimOrNull(request.getParameter("positionId"));

            if (positionId == null) {
                addActionError("Missing positionId");
                return ERROR;
            }

            position = positionDAO.findById(positionId);
            if (position == null) {
                addActionError("Position not found: " + positionId);
                return ERROR;
            }

            departmentList = departmentDAO.sequense();
            return SUCCESS;

        } catch (Exception e) {
            log.error("[PositionEdit] error", e);
            return ERROR;
        }
    }

    /** -------------------- UPDATE -------------------- */
    public String updatePosition() {
        try {
            User ur = (User) request.getSession().getAttribute("onlineUser");
            String logonUser = (ur != null && ur.getId() != null) ? ur.getId() : "system";

            String positionId = trimOrNull(request.getParameter("positionId"));
            if (positionId == null) positionId = trimOrNull(request.getParameter("position_id"));
            if (positionId == null) {
                log.warn("[updatePosition] Missing positionId");
                return ERROR;
            }

            Position position = positionDAO.findById(positionId);
            if (position == null) {
                log.warn("[updatePosition] Position not found: " + positionId);
                return ERROR;
            }

            String departmentId = trimOrNull(request.getParameter("departmentId"));
            String name         = trimOrNull(request.getParameter("name"));
            String description  = request.getParameter("description");

            Timestamp ts;
            try {
                String date = trimOrNull(request.getParameter("date"));
                String time = trimOrNull(request.getParameter("time"));
                ts = (date != null && time != null)
                        ? DateUtil.dateToTimestamp(date, time)
                        : new Timestamp(System.currentTimeMillis());
            } catch (Exception dtEx) {
                log.warn("[updatePosition] parse date/time fail, fallback to now", dtEx);
                ts = new Timestamp(System.currentTimeMillis());
            }

            if (departmentId != null) position.setDepartmentId(departmentId);
            if (name != null)         position.setName(name);
            if (description != null)  position.setDescription(description);

            position.setUserUpdate(logonUser);
            position.setTimeUpdate(ts);

            positionDAO.update(position);

            positionList = positionDAO.findAll();
            return SUCCESS;

        } catch (Exception e) {
            log.error("[updatePosition] error", e);
            return ERROR;
        }
    }

    /** -------------------- DELETE -------------------- */
    public String deletePosition() {
        try {
            String positionId = trimOrNull(request.getParameter("position_id"));
            if (positionId == null) positionId = trimOrNull(request.getParameter("positionId"));
            if (positionId == null) {
                addActionError("Missing positionId");
                return ERROR;
            }

            Position position = positionDAO.findById(positionId);
            if (position == null) {
                addActionError("Position not found: " + positionId);
                return ERROR;
            }

            positionDAO.delete(position);

            positionList = positionDAO.findAll();
            return SUCCESS;

        } catch (Exception e) {
            log.error("[deletePosition] error", e);
            return ERROR;
        }
    }

    /** -------------------- UTIL -------------------- */
    private static String trimOrNull(String s) {
        if (s == null) return null;
        String t = s.trim();
        return t.isEmpty() ? null : t;
    }
    
    public String checkDuplicatePositionId() {
        try {
            response.setCharacterEncoding("UTF-8");
            response.setContentType("text/plain; charset=UTF-8");

            String id = request.getParameter("positionId");
            if (id == null || id.trim().isEmpty()) {
                response.getWriter().write("empty");
                return NONE;
            }

            Position pos = positionDAO.findById(id.trim());
            response.getWriter().write(pos != null ? "duplicate" : "ok");

        } catch (Exception e) {
            log.error("[checkDuplicatePositionId] error", e);
            try {
                response.getWriter().write("error");
            } catch (Exception ignored) {}
        }
        return NONE;
    }
}
