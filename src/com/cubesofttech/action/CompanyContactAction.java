package com.cubesofttech.action;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.cubesofttech.dao.CompanyContactDAO;
import com.cubesofttech.model.CompanyContact;
import com.opensymphony.xwork2.ActionSupport;

public class CompanyContactAction extends ActionSupport {

	private static final long serialVersionUID = 1L;
	private static final Logger log = Logger.getLogger(CompanyContactAction.class);

	HttpServletRequest request = ServletActionContext.getRequest();
	HttpServletResponse response = ServletActionContext.getResponse();
	HttpSession session = request.getSession();

	@Autowired
	private CompanyContactDAO companyContactDAO;

	private CompanyContact companyContact;
	private Long companyContactId;

	public String list() {

		try {

			List<Map<String, Object>> contactList = companyContactDAO.findAll();

			request.setAttribute("contactList", contactList);

			return SUCCESS;

		} catch (Exception e) {

			log.error("Error loading company contact list", e);

			return ERROR;
		}
	}

	public String add() {

		try {

			if (companyContact != null) {
				companyContactDAO.save(companyContact);
			}

			return SUCCESS;

		} catch (Exception e) {

			log.error("Error saving company contact", e);

			return ERROR;
		}
	}

	public String edit() {

		try {

			if (companyContactId != null) {

				CompanyContact contact = companyContactDAO.findById(companyContactId);

				request.setAttribute("companyContact", contact);
			}

			return SUCCESS;

		} catch (Exception e) {

			log.error("Error loading company contact", e);

			return ERROR;
		}
	}

	public String update() {

		try {

			if (companyContact != null) {
				companyContactDAO.update(companyContact);
			}

			return SUCCESS;

		} catch (Exception e) {

			log.error("Error updating company contact", e);

			return ERROR;
		}
	}

	public String delete() {

		try {

			if (companyContactId != null) {

				CompanyContact contact = companyContactDAO.findById(companyContactId);

				if (contact != null) {
					companyContactDAO.delete(contact);
				}
			}

			return SUCCESS;

		} catch (Exception e) {

			log.error("Error deleting company contact", e);

			return ERROR;
		}
	}

	public CompanyContact getCompanyContact() {
		return companyContact;
	}

	public void setCompanyContact(CompanyContact companyContact) {
		this.companyContact = companyContact;
	}

	public Long getCompanyContactId() {
		return companyContactId;
	}

	public void setCompanyContactId(Long companyContactId) {
		this.companyContactId = companyContactId;
	}
}