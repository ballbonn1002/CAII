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
import com.cubesofttech.model.CompanyAddress;
import com.cubesofttech.model.Company;
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
	
	private String freelancerCompanyNameEn;
	private String freelancerAddress;
	private String freelancerGoogleMap;
	
	private String freelancerCompanyNameTh;
	
	private File companyLogo;
	private String companyLogoFileName;
	private String companyLogoContentType;
	
	private String freelancerRealCompanyId;

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
				String profileImage = null;
				String fileId = contact.getFileId();
				if (fileId != null && !fileId.isEmpty()) {
				    FileUpload file = fileUploadDAO.findById(Integer.parseInt(fileId));
				    if( file !=null) {
				    	 profileImage = file.getPath();
				    }
				}
				request.setAttribute("profileImage", profileImage);

				// Freelancer
	            String contactCompanyId = contact.getCompanyId();
	            String contactCompanyAddressId = contact.getCompanyAddressId();

	            boolean isFreelancerContact = false;

	            if (contactCompanyId != null && !contactCompanyId.trim().isEmpty()) {
	                try {
	                    Company company = companyDAO.findById(Long.parseLong(contactCompanyId.trim()));
	                    isFreelancerContact = (company != null && "FREELANCE".equals(company.getIndustryId()));

	                    if (isFreelancerContact) {
	                        request.setAttribute("freelancerCompanySharedInfo", company);

	                        // โลโก้บริษัท Freelancer 
	                        String companyLogoPath = null;
	                        String companyLogoFileId = company.getFileId();
	                        if (companyLogoFileId != null && !companyLogoFileId.trim().isEmpty()) {
	                            try {
	                                FileUpload logoFile = fileUploadDAO.findById(Integer.parseInt(companyLogoFileId.trim()));
	                                if (logoFile != null) {
	                                    companyLogoPath = logoFile.getPath();
	                                }
	                            } catch (NumberFormatException nfe2) {
	                                
	                            }
	                        }
	                        request.setAttribute("companyLogoPath", companyLogoPath);
	                    }
	                } catch (NumberFormatException nfe) {
	                  
	                }
	            }

	            request.setAttribute("isFreelancerContact", isFreelancerContact);

	          
	            if (isFreelancerContact && contactCompanyAddressId != null && !contactCompanyAddressId.trim().isEmpty()) {
	                try {
	                    CompanyAddress freelancerAddressInfo =
	                            companyAddressDAO.findById(Long.parseLong(contactCompanyAddressId.trim()));
	                    request.setAttribute("freelancerAddressInfo", freelancerAddressInfo);
	                } catch (NumberFormatException nfe) {
	                    // company_address_id ไม่ใช่ตัวเลข ข้ามไป ไม่ต้อง set
	                }
	            }
			}

			List<Map<String, Object>> companyList = companyDAO.findAll();
			request.setAttribute("companyList", companyList);

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

	        Timestamp now = new Timestamp(System.currentTimeMillis());

	        //Freelancer
	        boolean isFreelancerSave = "4".equals(contactCompanyId);
	        Company freelancerCompanyRow = null;

	        if (!isFreelancerSave && contactCompanyId != null && !contactCompanyId.trim().isEmpty()) {
	            try {
	                Company existingCompany = companyDAO.findById(Long.parseLong(contactCompanyId.trim()));
	                if (existingCompany != null && "FREELANCE".equals(existingCompany.getIndustryId())) {
	                    isFreelancerSave = true;
	                    freelancerCompanyRow = existingCompany;
	                }
	            } catch (NumberFormatException nfe) {	       
	            }
	        }

	        if (isFreelancerSave) {

	            

	            boolean isNewCompany = (freelancerCompanyRow == null);
	            if (isNewCompany) {
	                freelancerCompanyRow = new Company();
	                freelancerCompanyRow.setIndustryId("FREELANCE");
	                freelancerCompanyRow.setTaxNumber("00000");
	                freelancerCompanyRow.setIsActive("1");
	                freelancerCompanyRow.setUserCreate(username);
	                freelancerCompanyRow.setTimeCreate(now);
	            } else {
	                freelancerCompanyRow.setUserUpdate(username);
	                freelancerCompanyRow.setTimeUpdate(now);
	            }

	            if (freelancerCompanyNameEn != null && !freelancerCompanyNameEn.trim().isEmpty()) {
	                freelancerCompanyRow.setCompanyEn(freelancerCompanyNameEn);
	            }

	            if (freelancerCompanyNameTh != null && !freelancerCompanyNameTh.trim().isEmpty()) {
	                freelancerCompanyRow.setCompanyTh(freelancerCompanyNameTh);
	            } else if (freelancerCompanyNameEn != null && !freelancerCompanyNameEn.trim().isEmpty()) {
	                freelancerCompanyRow.setCompanyTh(freelancerCompanyNameEn);
	            }

	            try {
	            	if (isNewCompany) {
	            	    freelancerCompanyRow.setCompanyCode("FREELANCE-TEMP-" + System.currentTimeMillis());
	            	    companyDAO.save(freelancerCompanyRow);          

	            	    freelancerCompanyRow.setCompanyCode("FREELANCE-" + freelancerCompanyRow.getCompanyId());
	            	    companyDAO.update(freelancerCompanyRow);        
	            	} else {
	            	    companyDAO.update(freelancerCompanyRow);
	            	}
	            } catch (Exception ex) {
	                log.error("Unable to save Freelancer company row", ex);
	                addActionError("DEBUG company table: " + ex.getMessage());
	            }

	            contactCompanyId = String.valueOf(freelancerCompanyRow.getCompanyId());
	            
	            if (companyLogo != null) {
	                try {
	                    List<FileUpload> savedLogoFiles = fileAttachmentService.attach(
	                        Arrays.asList(companyLogo),
	                        Arrays.asList(companyLogoFileName),
	                        "company", contactCompanyId, username,
	                        request.getServletContext().getRealPath("/")
	                    );
	                    if (savedLogoFiles != null && !savedLogoFiles.isEmpty()) {
	                        freelancerCompanyRow.setFileId(String.valueOf(savedLogoFiles.get(0).getFileId()));
	                        companyDAO.update(freelancerCompanyRow);
	                    }
	                } catch (Exception ex) {
	                    log.error("Unable to save Freelancer company logo", ex);
	                    addActionError("DEBUG company logo: " + ex.getMessage());
	                }
	            }


	            CompanyAddress freelancerAddressRow = null;
	            if (companyAddressId != null && !companyAddressId.trim().isEmpty()) {
	                try {
	                    freelancerAddressRow = companyAddressDAO.findById(Long.parseLong(companyAddressId.trim()));
	                } catch (NumberFormatException nfe) {
	                    freelancerAddressRow = null;
	                }
	            }

	            boolean isNewAddress = (freelancerAddressRow == null);

	            if (isNewAddress) {
	                freelancerAddressRow = new CompanyAddress();
	                freelancerAddressRow.setUserCreate(username);
	                freelancerAddressRow.setTimeCreate(now);
	            } else {
	                freelancerAddressRow.setUserUpdate(username);
	                freelancerAddressRow.setTimeUpdate(now);
	            }

	            freelancerAddressRow.setCompanyId(contactCompanyId);
	           
	            if (freelancerCompanyNameEn != null && !freelancerCompanyNameEn.trim().isEmpty()) {
	                freelancerAddressRow.setAddressName(freelancerCompanyNameEn);
	            }
	           
	            if (freelancerAddress != null && !freelancerAddress.trim().isEmpty()) {
	                freelancerAddressRow.setAddress(freelancerAddress);
	            }
	            if (freelancerGoogleMap != null && !freelancerGoogleMap.trim().isEmpty()) {
	                freelancerAddressRow.setGoogleMap(freelancerGoogleMap);
	            }
	            if (isNewAddress) {
	                companyAddressDAO.save(freelancerAddressRow);
	            } else {
	                companyAddressDAO.update(freelancerAddressRow);
	            }

	            companyAddressId = String.valueOf(freelancerAddressRow.getCompanyAddressId());
	        }
            ////
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

	        if (isNew) {
	            target.setUserCreate(username);
	            target.setTimeCreate(now);
	            companyContactDAO.save(target);
	        } else {
	            target.setUserUpdate(username);
	            target.setTimeUpdate(now);
	            companyContactDAO.update(target);
	        }

	        if (profileImage != null) {
	            List<FileUpload> savedFiles = fileAttachmentService.attach(
	                Arrays.asList(profileImage),
	                Arrays.asList(profileImageFileName),
	                "contact", username, username,
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
	        addActionError("ไม่สามารถบันทึกข้อมูล Contact ได้"+ e.getMessage()) ;
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
	
	public String getFreelancerCompanyNameEn() { 
		return freelancerCompanyNameEn; 
		}
	
	public void setFreelancerCompanyNameEn(String freelancerCompanyNameEn){ 
		this.freelancerCompanyNameEn = freelancerCompanyNameEn; 
		}

	public String getFreelancerAddress() { 
		return freelancerAddress; 
		}
	public void setFreelancerAddress(String freelancerAddress) { 
		this.freelancerAddress = freelancerAddress; 
		}

	public String getFreelancerGoogleMap() { 
		return freelancerGoogleMap; 
		}
	public void setFreelancerGoogleMap(String freelancerGoogleMap) { 
		this.freelancerGoogleMap = freelancerGoogleMap; 
		}
	
	public String getFreelancerCompanyNameTh() { 
		return freelancerCompanyNameTh; 
		}
	public void setFreelancerCompanyNameTh(String freelancerCompanyNameTh) { 
		this.freelancerCompanyNameTh = freelancerCompanyNameTh; 
		}
	
	public String getFreelancerRealCompanyId() { 
		return freelancerRealCompanyId; 
		}
	public void setFreelancerRealCompanyId(String freelancerRealCompanyId) { 
		this.freelancerRealCompanyId = freelancerRealCompanyId; 
		}
	
	public File getCompanyLogo() { 
		return companyLogo; 
		}
	public void setCompanyLogo(File companyLogo) { 
		this.companyLogo = companyLogo; 
		}

	public String getCompanyLogoFileName() { 
		return companyLogoFileName; 
		}
	public void setCompanyLogoFileName(String companyLogoFileName) { 
		this.companyLogoFileName = companyLogoFileName; 
		}

	public String getCompanyLogoContentType() { 
		return companyLogoContentType; 
		}
	public void setCompanyLogoContentType(String companyLogoContentType) { 
		this.companyLogoContentType = companyLogoContentType; 
		}

}