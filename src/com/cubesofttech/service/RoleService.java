package com.cubesofttech.service;

import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cubesofttech.dao.RoleAuthorizedObjectDAO;
import com.cubesofttech.model.RoleAuthorizedObject;
import com.cubesofttech.model.UserRole;

@Service
public class RoleService {

	@Autowired
	private RoleAuthorizedObjectDAO roleAuthorizedObjectDAO;

	public Set<String> addRoleByUserTable(List<RoleAuthorizedObject> roleAuthorizedObjectList,
			Set<String> userAuthority) {
		if (roleAuthorizedObjectList != null) {
			Iterator<RoleAuthorizedObject> it = roleAuthorizedObjectList.iterator();
			while (it.hasNext()) {
				RoleAuthorizedObject rao = it.next();
				userAuthority.add(rao.getAuthorizedObjectId());
			}
		}
		return userAuthority;
	}

	public Set<String> addRoleByUserRoleTabel(List<UserRole> userRoleList, Set<String> userAuthority) throws Exception {
		if (userRoleList != null) {
			List<RoleAuthorizedObject> roleAuthorizedObjectList;
			Iterator<UserRole> it = userRoleList.iterator();
			while (it.hasNext()) {
				UserRole userRole = it.next();
				roleAuthorizedObjectList = roleAuthorizedObjectDAO.findByRoleId(userRole.getRoleId());
				if (roleAuthorizedObjectList != null) {
					Iterator<RoleAuthorizedObject> it2 = roleAuthorizedObjectList.iterator();
					while (it2.hasNext()) {
						RoleAuthorizedObject rao = it2.next();
						userAuthority.add(rao.getAuthorizedObjectId());
					}
				}
			}
		}
		return userAuthority;
	}

}
