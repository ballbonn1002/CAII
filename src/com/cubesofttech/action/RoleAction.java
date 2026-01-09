package com.cubesofttech.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.cubesofttech.dao.AuthorizedObjectDAO;
import com.cubesofttech.dao.AuthorizedObjectGroupDAO;
import com.cubesofttech.dao.RoleAuthorizedObjectDAO;
import com.cubesofttech.dao.RoleDAO;
import com.cubesofttech.dao.UserDAO;
import com.cubesofttech.dao.UserRoleDAO;
import com.cubesofttech.model.AuthorizedGroupView;
import com.cubesofttech.model.AuthorizedObject;
import com.cubesofttech.model.AuthorizedObjectGroup;
import com.cubesofttech.model.Position;
import com.cubesofttech.model.Role;
import com.cubesofttech.model.RoleAuthorizedObject;
import com.cubesofttech.model.User;
import com.cubesofttech.model.UserRole;
import com.cubesofttech.service.RoleService;
import com.cubesofttech.util.DateUtil;
import com.opensymphony.xwork2.ActionSupport;

public class RoleAction extends ActionSupport {

	private static final long serialVersionUID = 2280661337420278284L;

	Logger log = Logger.getLogger(getClass());
	HttpServletRequest request = ServletActionContext.getRequest();
	HttpServletResponse response = ServletActionContext.getResponse();
	public static final String Role = "roleList";

	@Autowired
	private UserDAO userDAO;

	@Autowired
	private RoleAuthorizedObjectDAO roleAuthorizedObjectDAO;

	@Autowired
	private AuthorizedObjectDAO authorizedObjectDAO;

	@Autowired
	private AuthorizedObjectGroupDAO authorizedObjectGroupDAO;
	
	@Autowired
	private UserRoleDAO userRoleDAO;

	@Autowired
	private RoleDAO roleDAO;

	private Role role;

	private AuthorizedObjectGroup authorizedObjectGroup;

	private User user;

	private String roleId;

	private Integer authorizedObjectGroupId;
	
	@Autowired
	public RoleService roleService;

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public String getRoleId() {
		return roleId;
	}

	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}

	public String list() {
		try {
			request.setAttribute("roleList", roleDAO.sequense2());
			return SUCCESS;
		} catch (Exception e) {
			log.error(e);
			return ERROR;
		}
	}

	public String openEdit() {
		try {
			User ur = (User) request.getSession().getAttribute("onlineUser");
			String ur2 = ur.getId();
			role = roleDAO.findById(roleId);
			HttpSession session = request.getSession();

			List<Map<String, Object>> u3 = userDAO.findById3(ur2);

			if (u3.get(0).get("role_id").equals(role.getId())) {
				Set<String> userAuthority = new HashSet<>();

				List<RoleAuthorizedObject> roleAuthorizedObjectList = roleAuthorizedObjectDAO
						.findByRoleId(role.getId());
				
				userAuthority = roleService.addRoleByUserTable(roleAuthorizedObjectList, userAuthority);

				List<UserRole> userRoleList = userRoleDAO.findByUserId(role.getId());

				userAuthority = roleService.addRoleByUserRoleTabel(userRoleList, userAuthority);

				session.setAttribute("userAuthority", userAuthority);
			}
			request.setAttribute("role", role);
			
//			request.setAttribute("aoList", authorizedObjectDAO.findAll());
	        List<AuthorizedObjectGroup> authorizedHierarchy = authorizedObjectGroupDAO.getAuthorizedHierarchy();
	        request.setAttribute("aoList", authorizedHierarchy);
	        
			request.setAttribute("raoList", roleAuthorizedObjectDAO.findByRoleId(roleId));
			request.setAttribute("userlist", userRoleDAO.findByRoleId(roleId));

			return SUCCESS;
		} catch (Exception e) {
			log.error(e.getMessage());
			return ERROR;
		}
	}

	public String roleSettingEditingPage() {
		try {
			authorizedObjectGroup = authorizedObjectGroupDAO.findById(authorizedObjectGroupId);
			request.setAttribute("roleSetting", authorizedObjectGroup);
			
			return SUCCESS;
		} catch (Exception e) {
			log.error(e.getMessage());
			return ERROR;
		}
	}
	
	public String openEdit2() {
	    try {
	        request.setAttribute("role", role);
	        
	        List<AuthorizedObjectGroup> authorizedHierarchy = authorizedObjectGroupDAO.getAuthorizedHierarchy();
	        
	        request.setAttribute("aoList", authorizedHierarchy);
	        
	        request.setAttribute("raoList", roleAuthorizedObjectDAO.findByRoleId(roleId));
	        
	        return SUCCESS;
	    } catch (Exception e) {
	        log.error(e);
	        return ERROR;
	    }
	}

	public String roleSettingAddingPage() {
		try {
			return SUCCESS;
		} catch (Exception e) {
			log.error(e);
			return ERROR;
		}
	}
	
	public String listSetting() {
		try {
			request.setAttribute("role", role);
			
			List<AuthorizedObjectGroup> authorizedHierarchy = authorizedObjectGroupDAO.getAuthorizedHierarchy();
			
			request.setAttribute("aoList", authorizedHierarchy);
			
			request.setAttribute("raoList", roleAuthorizedObjectDAO.findByRoleId(roleId));
			
			return SUCCESS;
		} catch (Exception e) {
			log.error(e);
			return ERROR;
		}
	}
	
	public String performEdit() {
		try {
			Role r = roleDAO.findById(role.getId());
			r.setName(role.getName());
			r.setDescription(role.getDescription());
			r.setTimeUpdate(DateUtil.getCurrentTime());
			roleDAO.update(r);

			roleAuthorizedObjectDAO.deleteByRoleId(r.getId());

			String[] authIds = request.getParameterValues("authId");
			if (authIds != null) {
				log.debug(authIds.length);
				for (int i = 0; i < authIds.length; i++) {
					RoleAuthorizedObject ro = new RoleAuthorizedObject();
					ro.setRoleId(r.getId());
					ro.setAuthorizedObjectId(authIds[i]);
					ro.setTimeCreate(DateUtil.getCurrentTime());
					ro.setTimeUpdate(DateUtil.getCurrentTime());
					roleAuthorizedObjectDAO.save(ro);
				}
			} else {
				return SUCCESS;
			}
			return SUCCESS;

		} catch (Exception e) {
			log.error(e);
			return ERROR;
		}
	}

	public String performEditSetting() {
		try {
			AuthorizedObjectGroup r = authorizedObjectGroupDAO.findById(authorizedObjectGroup.getAuthorizedObjectGroupId());
			r.setName(authorizedObjectGroup.getName());
			r.setDescription(authorizedObjectGroup.getDescription());
			r.setTimeUpdate(DateUtil.getCurrentTime());
			authorizedObjectGroupDAO.update(r);
			
			return SUCCESS;
			
		} catch (Exception e) {
			log.error(e);
			return ERROR;
		}
	}
	
	public String performAdd() {
		try {

			role.setTimeCreate(DateUtil.getCurrentTime());
			role.setTimeUpdate(DateUtil.getCurrentTime());
			roleDAO.save(role);
			roleId = role.getId();

			String[] authIds = request.getParameterValues("authId");
			if (authIds != null) {
				for (int i = 0; i < authIds.length; i++) {
					RoleAuthorizedObject ro = new RoleAuthorizedObject();
					ro.setRoleId(role.getId());
					ro.setAuthorizedObjectId(authIds[i]);
					ro.setTimeCreate(DateUtil.getCurrentTime());
					ro.setTimeUpdate(DateUtil.getCurrentTime());
					roleAuthorizedObjectDAO.save(ro);
				}
			} else {
				return SUCCESS;
			}
			return SUCCESS;
		} catch (Exception e) {
			log.error(e);
			return ERROR;
		}
	}

	public String performAddSetting() {
		try {
			
			authorizedObjectGroup.setTimeCreate(DateUtil.getCurrentTime());
			authorizedObjectGroup.setTimeUpdate(DateUtil.getCurrentTime());
			authorizedObjectGroupDAO.save(authorizedObjectGroup);

			return SUCCESS;
		} catch (Exception e) {
			log.error(e);
			return ERROR;
		}
	}
	
	public String deleteRole() {
		try {
			String id = request.getParameter("id");
			Role role = new Role();
			role = roleDAO.findById(id);
			log.debug(role);
			roleDAO.delete(role);
			List<Role> roleList = roleDAO.findAll();
			request.setAttribute(Role, roleList);
			return SUCCESS;
		} catch (Exception e) {

			return ERROR;
		}
	}

	public String deleteRoleSetting() {
		try {
			String id = request.getParameter("id");
			
			AuthorizedObjectGroup authorizedObjectGroup = new AuthorizedObjectGroup();
			authorizedObjectGroup = authorizedObjectGroupDAO.findById(Integer.valueOf(id));
			log.debug(authorizedObjectGroup);
			
			authorizedObjectGroupDAO.delete(authorizedObjectGroup);
			
			List<AuthorizedObjectGroup> authorizedHierarchy = authorizedObjectGroupDAO.getAuthorizedHierarchy();
			request.setAttribute("aoList", authorizedHierarchy);
			
			return SUCCESS;
		} catch (Exception e) {
			
			return ERROR;
		}
	}
	
}