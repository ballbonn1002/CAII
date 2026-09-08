package com.cubesofttech.action;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;


import com.cubesofttech.dao.CompanyAddressDAO;
import com.cubesofttech.dao.CompanyContactDAO;
import com.cubesofttech.dao.CompanyDAO;
import com.cubesofttech.model.User;
import com.cubesofttech.service.FileAttachmentService;
import com.cubesofttech.model.CompanyContact;
import com.opensymphony.xwork2.ActionSupport;

import java.io.File;
import javax.servlet.ServletContext;

import com.cubesofttech.dao.FileUploadDAO;
import com.cubesofttech.model.FileUpload;
import com.cubesofttech.util.FileUtil;
import com.cubesofttech.util.DateUtil;



public class CompanyContactAction extends ActionSupport {

	private static final long serialVersionUID = 1L;
	private static final Logger log = Logger.getLogger(CompanyContactAction.class);

	HttpServletRequest request = ServletActionContext.getRequest();
	HttpServletResponse response = ServletActionContext.getResponse();
	HttpSession session = request.getSession();

	@Autowired
	private CompanyContactDAO companyContactDAO;
	
	@Autowired
	private CompanyDAO companyDAO;

	@Autowired
	private CompanyAddressDAO companyAddressDAO;

	private CompanyContact companyContact;
	private Long companyContactId;
	private Long id;
	private CompanyContact contact = new CompanyContact();

	private String activeFlag;
	private boolean toggleSuccess;

	private Long companyId;
	private List<Map<String, Object>> addressList;
	
	@Autowired
	private FileUploadDAO fileUploadDAO;
	
	@Autowired
	private FileAttachmentService fileAttachmentService;

	private File profileImage;
	private String profileImageFileName;
	private String profileImageContentType;
	private String removeProfileImage;

	public String getRemoveProfileImage() { return removeProfileImage; }
	public void setRemoveProfileImage(String removeProfileImage) { this.removeProfileImage = removeProfileImage; }

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
			
			List<Map<String, Object>> companyList = companyDAO.findAll();
			log.debug("CompanyList = "+companyList);

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
	

	public String open_form() {
		try {
			if (id == null) {
				contact = new CompanyContact();
				contact.setIsActive("1");
			} else {
				contact = companyContactDAO.findById(id);
				if (contact == null) {
					addActionError("ไม่พบข้อมูล Contact ที่ต้องการแก้ไข");
					return ERROR;
				}
				
				String fileId = contact.getFileId();
				if (fileId != null && !fileId.isEmpty()) {
				    FileUpload file = fileUploadDAO.findById(Integer.parseInt(fileId));
				    if( file !=null) {
				    	String profileImage = file.getPath();
				    }
				}
				
				log.debug("companylist= "+companyDAO.findAll());
				log.debug("profileImage= "+profileImage);
				
				request.setAttribute("profileImage", profileImage);
				request.setAttribute("companyList", companyDAO.findAll());
			}
			
			return SUCCESS;
		} catch (Exception e) {
		    log.error("Unable to open Company Contact form", e);
		    addActionError("ไม่สามารถเปิดข้อมูล Contact ได้");
		    return ERROR;
		}
	}
		
	public String save() {

	    try {
	    	User onlineUser = (User) session.getAttribute("onlineUser");
	    	String username = onlineUser.getId();
	        
	        Long companyContactId = contact.getCompanyContactId();
	        boolean isNew = (companyContactId == null);
	      
	        String contactCompanyId    = contact.getCompanyId();
	        String companyAddressId    = contact.getCompanyAddressId();	      
	        String titleNameTh         = contact.getTitleNameTh();
	        String contactNameTh       = contact.getContactNameTh();
	        String titleNameEn         = contact.getTitleNameEn();
	        String contactNameEn       = contact.getContactName();
	        String position            = contact.getPosition();
	        String phone               = contact.getPhone();
	        String email               = contact.getEmail();
	        String isActiveParam       = contact.getIsActive();
	        String removeImageParam    = this.removeProfileImage;

	        
	        CompanyContact target = isNew ? new CompanyContact() : companyContactDAO.findById(companyContactId);
	        if (target == null) {
	            addActionError("ไม่พบข้อมูล Contact ที่ต้องการแก้ไข");
	            return ERROR;
	        }

	        target.setCompanyId(contactCompanyId);
	        target.setCompanyAddressId(companyAddressId);
	        target.setTitleNameTh(titleNameTh);
	        target.setContactNameTh(contactNameTh);
	        target.setTitleNameEn(titleNameEn);
	        target.setContactName(contactNameEn);
	        target.setPosition(position);
	        target.setPhone(phone);
	        target.setEmail(email);
	        target.setIsActive("1".equals(isActiveParam) ? "1" : "0");

	        if ("Y".equals(removeImageParam)) {
	            target.setFileId(null);
	        }

	        Timestamp now = new Timestamp(System.currentTimeMillis());

	        if (isNew) {
	            target.setUserCreate(username);
	            target.setTimeCreate(now);
	            companyContactDAO.save(target);
	        } else {
	            target.setUserUpdate(username);
	            target.setTimeUpdate(now);   
	            companyContactDAO.update(target);
	        }

//	        if (profileImage != null) {
//	            String fileId = processFileUpload(
//	                    "/upload/contact/", profileImage, profileImageFileName,
//	                    "contact", target.getCompanyContactId().toString(), username);
//	            target.setFileId(fileId);
//	            companyContactDAO.update(target);
//	        }
	        
	        if (profileImage  != null) {
				List<FileUpload> savedFiles = fileAttachmentService.attach(
					Arrays.asList(profileImage),
					Arrays.asList(profileImageFileName),
					"contact",
					username,
					username,
					request.getServletContext().getRealPath("/")
				);

				if (savedFiles != null && !savedFiles.isEmpty()) {
					target.setFileId(String.valueOf(savedFiles.get(0).getFileId()));
		            companyContactDAO.update(target);
				}
			}


	        this.contact = target;

	        return SUCCESS;

	    } catch (Exception e) {
	        log.error("Error saving company contact", e);
	        addActionError("ไม่สามารถบันทึกข้อมูล Contact ได้");
	        return ERROR;
	    }
	}

	public String toggleActive() {

	    try {

	        if (id == null) {
	            throw new IllegalArgumentException("ไม่พบรหัส Contact");
	        }

	        CompanyContact existing = companyContactDAO.findById(id);

	        if (existing == null) {
	            throw new IllegalArgumentException("ไม่พบข้อมูล Contact ที่ต้องการอัปเดต");
	        }

	        
	       
	        boolean wantActive = "1".equals(activeFlag);
	        existing.setIsActive(wantActive ? "1" : "0");

	        // ใครเป็นคนกดแก้ไขล่าสุด
	        User onlineUser = (User) session.getAttribute("onlineUser");
	        String username = onlineUser.getId();

	        existing.setUserUpdate(username);
	        existing.setTimeUpdate(new Timestamp(System.currentTimeMillis()));

	        companyContactDAO.update(existing);

	        toggleSuccess = true;
	        return SUCCESS;

	    } catch (Exception e) {

	        log.error("Unable to update Company Contact active status", e);
	        addActionError("ไม่สามารถอัปเดตสถานะ Contact ได้");
	        toggleSuccess = false;
	        return SUCCESS;
	    }
	}

	public String listAddressByCompany() {

	    try {

	        if (companyId != null) {
	            addressList = companyAddressDAO.findByCompanyId(companyId);
	        } else {
	            addressList = new ArrayList<Map<String, Object>>();
	        }

	        return SUCCESS;

	    } catch (Exception e) {

	        log.error("Error loading address list for companyId=" + companyId, e);
	        addressList = new ArrayList<Map<String, Object>>();

	        return SUCCESS;
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

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public CompanyContact getContact() {
		return contact;
	}

	public void setContact(CompanyContact contact) {
		this.contact = contact;
	}

	public void setActiveFlag(String activeFlag) {
	    this.activeFlag = activeFlag;
	}

	public String getActiveFlag() {
	    return activeFlag;
	}

	public boolean isToggleSuccess() {
	    return toggleSuccess;
	}

	public void setToggleSuccess(boolean toggleSuccess) {
		this.toggleSuccess = toggleSuccess;
	}

	public Long getCompanyId() {
		return companyId;
	}

	public void setCompanyId(Long companyId) {
		this.companyId = companyId;
	}

	public List<Map<String, Object>> getAddressList() {
		return addressList;
	}
	
	public File getProfileImage() { 
		return profileImage; 
		}
	public void setProfileImage(File profileImage) { 
		this.profileImage = profileImage; 
		}

	public String getProfileImageFileName() { 
		return profileImageFileName; 
		}
	public void setProfileImageFileName(String profileImageFileName) { 
		this.profileImageFileName = profileImageFileName; 
		}

	public String getProfileImageContentType() { 
		return profileImageContentType; 
		}
	public void setProfileImageContentType(String profileImageContentType) { 
		this.profileImageContentType = profileImageContentType; 
		}

}