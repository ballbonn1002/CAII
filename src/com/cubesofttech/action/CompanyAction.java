package com.cubesofttech.action;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.cubesofttech.dao.CompanyAddressDAO;
import com.cubesofttech.dao.CompanyContactDAO;
import com.cubesofttech.dao.CompanyDAO;
import com.cubesofttech.dao.FileUploadDAO;
import com.cubesofttech.model.Company;
import com.cubesofttech.model.CompanyAddress;
import com.cubesofttech.model.CompanyContact;
import com.cubesofttech.model.FileUpload;
import com.cubesofttech.model.User;
import com.cubesofttech.util.DateUtil;
import com.cubesofttech.util.FileUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.opensymphony.xwork2.ActionSupport;

public class CompanyAction extends ActionSupport {

	@Autowired
	private CompanyDAO companyDAO;
	@Autowired
	private CompanyContactDAO contactDAO;
	@Autowired
	private CompanyAddressDAO addressDAO;
	@Autowired
	private FileUploadDAO fileUploadDAO;

	private static final long serialVersionUID = 1L;
	private static final Logger log = Logger.getLogger(CompanyAction.class);

	HttpServletRequest request = ServletActionContext.getRequest();
	HttpServletResponse response = ServletActionContext.getResponse();
	HttpSession session = request.getSession();

	private Long companyId;
	private String companyCode;
	private String nameEN;
	private String nameTH;
	private String taxNumber;
	private String industry;
	private String isActive;

	private File logo;
	private String logoFileName;
	private String logoContentType;
	private String filePath;

	private String payload;
	private File[] contactProfiles;
	private String[] contactProfilesFileName;
	private String[] contactProfileIds;

	public void setContactProfiles(File[] contactProfiles) {
		this.contactProfiles = contactProfiles;
	}

	public void setContactProfilesFileName(String[] contactProfilesFileName) {
		this.contactProfilesFileName = contactProfilesFileName;
	}

	public void setContactProfileIds(String[] contactProfileIds) {
		this.contactProfileIds = contactProfileIds;
	}

	public void setPayload(String payload) {
		this.payload = payload;
	}

	public void setIsActive(String isActive) {
		this.isActive = isActive;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public File getLogo() {
		return logo;
	}

	public void setLogo(File logo) {
		this.logo = logo;
	}

	public String getLogoFileName() {
		return logoFileName;
	}

	public void setLogoFileName(String logoFileName) {
		this.logoFileName = logoFileName;
	}

	public String getLogoContentType() {
		return logoContentType;
	}

	public void setLogoContentType(String logoContentType) {
		this.logoContentType = logoContentType;
	}

	public Long getCompanyId() {
		return companyId;
	}

	public void setCompanyId(Long companyId) {
		this.companyId = companyId;
	}

	public String getCompanyCode() {
		return companyCode;
	}

	public void setCompanyCode(String companyCode) {
		this.companyCode = companyCode;
	}

	public String getNameEN() {
		return nameEN;
	}

	public void setNameEN(String nameEN) {
		this.nameEN = nameEN;
	}

	public String getNameTH() {
		return nameTH;
	}

	public void setNameTH(String nameTH) {
		this.nameTH = nameTH;
	}

	public String getTaxNumber() {
		return taxNumber;
	}

	public void setTaxNumber(String taxId) {
		this.taxNumber = taxId;
	}

	public String getIndustry() {
		return industry;
	}

	public void setIndustry(String industry) {
		this.industry = industry;
	}

	private String formatFileSize(long size) {
		String[] units = { "Bytes", "KB", "MB", "GB", "TB" };
		int unitIndex = 0;
		double formattedSize = size;

		while (formattedSize > 900 && unitIndex < units.length - 1) {
			formattedSize /= 1024;
			unitIndex++;
		}

		return String.format("%.2f %s", formattedSize, units[unitIndex]);
	}

	public String list() throws Exception {

		List<Map<String, Object>> companies = companyDAO.findAll();
		List<Map<String, Object>> addresses = addressDAO.findAll();

		try {
			// company_id -> List<Address>
			Map<Long, List<Map<String, Object>>> addressMap = new HashMap<Long, List<Map<String, Object>>>();

			for (Map<String, Object> address : addresses) {
				Long companyId = Long.valueOf((String) address.get("company_id"));

				List<Map<String, Object>> list = addressMap.get(companyId);

				if (list == null) {
					list = new ArrayList<Map<String, Object>>();
					addressMap.put(companyId, list);
				}

				list.add(address);
			}

			List<Map<String, Object>> contacts = contactDAO.findAll();

			Map<Long, List<Map<String, Object>>> contactMap = new HashMap<Long, List<Map<String, Object>>>();

			for (Map<String, Object> contact : contacts) {

				Long companyId = Long.valueOf((String) contact.get("company_id"));

				List<Map<String, Object>> list = contactMap.get(companyId);

				if (list == null) {
					list = new ArrayList<Map<String, Object>>();
					contactMap.put(companyId, list);
				}

				list.add(contact);
			}

			// Merge
			for (Map<String, Object> company : companies) {

				Long companyId = ((Number) company.get("company_id")).longValue();

				List<Map<String, Object>> addressList = addressMap.get(companyId);

				List<Map<String, Object>> contactList = contactMap.get(companyId);

				company.put("address_location",
						addressList != null ? addressList : new ArrayList<Map<String, Object>>());

				company.put("company_contact",
						contactList != null ? contactList : new ArrayList<Map<String, Object>>());
			}

		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
		request.setAttribute("companyList", companies);
		return SUCCESS;
	}

	public String edit() {

		try {

			String companyIdString = request.getParameter("companyId");

			if (companyIdString == null || companyIdString.trim().isEmpty()) {
				return ERROR;
			}

			Long companyId = Long.valueOf(companyIdString);

			Company company = companyDAO.findById(companyId);

			if (company == null) {
				return ERROR;
			}

			FileUpload file = null;

			if (company.getFileId() != null && !company.getFileId().isEmpty()) {
				file = fileUploadDAO.findById(Integer.parseInt(company.getFileId()));
			}

			List<Map<String, Object>> addressList = addressDAO.findByCompanyId(companyId);

			List<Map<String, Object>> contactList = contactDAO.findByCompanyId(companyId);

			request.setAttribute("company", company);
			request.setAttribute("profile", file);
			request.setAttribute("addressList", addressList);
			request.setAttribute("contactList", contactList);

			return SUCCESS;

		} catch (Exception e) {

			log.error("Error loading company", e);

			return ERROR;
		}
	}

	public String add() {
		return SUCCESS;
	}

	public String save() {
		Company company = new Company();
		User onlineUser = (User) request.getSession().getAttribute("onlineUser");

		try {
			company.setCompanyCode(companyCode);
			company.setCompanyEn(nameEN);
			company.setCompanyTh(nameTH);
			company.setTaxNumber(taxNumber);
			company.setIndustry(industry);
			company.setIsActive("1".equals(isActive) ? "1" : "0");
			company.setUserCreate(onlineUser.getId());
			company.setUserUpdate(onlineUser.getId());
			company.setTimeCreate(DateUtil.getCurrentTime());
			company.setTimeUpdate(DateUtil.getCurrentTime());
			companyDAO.save(company);

			if (logo != null) {

				Integer maxId = fileUploadDAO.getMaxId() + 1;

				ServletContext context = request.getServletContext();
				String fileServerPath = context.getRealPath("/");
				System.out.println(fileServerPath);

				String originalFileName = logoFileName;

				FileUtil.upload(logo, fileServerPath + "upload/company/", maxId + "_" + originalFileName);

				int split = originalFileName.lastIndexOf('.');

				String name = originalFileName.substring(0, split);
				String type = originalFileName.substring(split).toLowerCase();

				FileUpload fileUpload = new FileUpload();

				fileUpload.setFileId(maxId.intValue());
				fileUpload.setPath("/upload/company/" + maxId + "_" + originalFileName);
				fileUpload.setSize(formatFileSize(logo.length()));
				fileUpload.setName(name);
				fileUpload.setType(type);

				fileUpload.setUserId(onlineUser.getId());
				fileUpload.setUserCreate(onlineUser.getId());

				fileUpload.setPage("company");
				fileUpload.setPageId(String.valueOf(company.getCompanyId()));

				fileUpload.setTimeCreate(DateUtil.getCurrentTime());

				fileUploadDAO.save(fileUpload);

				company.setFileId(String.valueOf(fileUpload.getFileId()));

				companyDAO.update(company);
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error("Cannot create new company");
			return ERROR;
		}

		return SUCCESS;
	}

	public String delete() {

		if (companyId == null || companyId < 1) {
			return INPUT;
		}

		try {

			Company company = companyDAO.findById(companyId);

			if (company == null) {
				log.warn("Company not found. id=" + companyId);
				return INPUT;
			}

			companyDAO.delete(company);

			return SUCCESS;

		} catch (Exception e) {

			log.error("Failed to delete company. id=" + companyId, e);

			return ERROR;
		}
	}

	public String update() {
		try {

			User onlineUser = (User) request.getSession().getAttribute("onlineUser");

			if (onlineUser == null) {
				response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
				return ERROR;
			}

			ObjectMapper mapper = new ObjectMapper();

			Map<String, Object> payload = mapper.readValue(this.payload, Map.class);
			Map<String, Object> updatedCompany = (Map<String, Object>) payload.get("company");
			String companyId = updatedCompany.get("id").toString();

			// Company Update
			Company company = companyDAO.findById(Long.valueOf(companyId));

			if (company == null) {
				response.setStatus(HttpServletResponse.SC_NOT_FOUND);
				return ERROR;
			}

			company.setCompanyCode((String) updatedCompany.get("code"));
			company.setTaxNumber((String) updatedCompany.get("taxId"));
			company.setCompanyEn((String) updatedCompany.get("nameEN"));
			company.setCompanyTh((String) updatedCompany.get("nameTH"));
			company.setIndustry((String) updatedCompany.get("industry"));
			company.setIsActive((String) updatedCompany.get("isActive"));

			// Handle File Upload Request
			if (logo != null) {

				Integer maxId = fileUploadDAO.getMaxId() + 1;

				ServletContext context = request.getServletContext();
				String fileServerPath = context.getRealPath("/");
				System.out.println(fileServerPath);

				String originalFileName = logoFileName;

				FileUtil.upload(logo, fileServerPath + "upload/company/", maxId + "_" + originalFileName);

				int split = originalFileName.lastIndexOf('.');

				String name = originalFileName.substring(0, split);
				String type = originalFileName.substring(split).toLowerCase();

				FileUpload fileUpload = new FileUpload();

				fileUpload.setFileId(maxId.intValue());
				fileUpload.setPath("/upload/company/" + maxId + "_" + originalFileName);
				fileUpload.setSize(formatFileSize(logo.length()));
				fileUpload.setName(name);
				fileUpload.setType(type);

				fileUpload.setUserId(onlineUser.getId());
				fileUpload.setUserCreate(onlineUser.getId());

				fileUpload.setPage("company");
				fileUpload.setPageId(String.valueOf(company.getCompanyId()));

				fileUpload.setTimeCreate(DateUtil.getCurrentTime());

				fileUploadDAO.save(fileUpload);

				company.setFileId(String.valueOf(fileUpload.getFileId()));

			}

			company.setUserUpdate(onlineUser.getId());
			company.setTimeUpdate(DateUtil.getCurrentTime());
			companyDAO.update(company);

			// address
			Map<String, Object> address = (Map<String, Object>) payload.get("address");

			// contact
			Map<String, Object> contact = (Map<String, Object>) payload.get("contact");
			Map<String, File> profileMap = new HashMap<>();
			Map<String, String> profileNameMap = new HashMap<>();

			if (contactProfiles != null) {
				for (int i = 0; i < contactProfiles.length; i++) {
					profileMap.put(contactProfileIds[i], contactProfiles[i]);
					profileNameMap.put(contactProfileIds[i], contactProfilesFileName[i]);
				}
			}

			processAddressUpdateRequest(companyId, onlineUser, address);
			processContactUpdateRequest(companyId, onlineUser, contact, profileMap, profileNameMap);

			response.setStatus(HttpServletResponse.SC_OK);

			return SUCCESS;

		} catch (Exception e) {

			log.error("Update company failed", e);
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);

			return ERROR;
		}
	}

	public String checkCompanyCode() {

		try {

			String companyCode = request.getParameter("companyCode");
			Long companyId = null;
			String companyIdString = request.getParameter("companyId");

			if (companyIdString != null && !companyIdString.isEmpty()) {
				companyId = Long.valueOf(companyIdString);
			}

			boolean exists = companyDAO.existsCompanyCode(companyCode, companyId);

			response.setContentType("application/json");
			response.getWriter().write("{\"exists\":" + exists + "}");

			return NONE;

		} catch (Exception e) {

			e.printStackTrace();

			return NONE;
		}
	}

	private void processAddressUpdateRequest(String companyId, User onlineUser, Map<String, Object> address)
			throws Exception {

		List<Map<String, Object>> addressCreated = (List<Map<String, Object>>) address.get("created");
		List<Map<String, Object>> addressUpdated = (List<Map<String, Object>>) address.get("updated");
		List<Object> addressDeleted = (List<Object>) address.get("deleted");

		// create
		for (Map<String, Object> item : addressCreated) {

			CompanyAddress addressObj = new CompanyAddress();

			addressObj.setCompanyId(companyId);
			addressObj.setAddressName((String) item.get("address_name"));
			addressObj.setAddress((String) item.get("address"));
			addressObj.setGoogleMap((String) item.get("google_map"));
			addressObj.setUserCreate(onlineUser.getId());
			addressObj.setTimeCreate(DateUtil.getCurrentTime());

			addressDAO.save(addressObj);
		}

		// update
		for (Map<String, Object> item : addressUpdated) {

			Long addressId = Long.valueOf(item.get("address_id").toString());
			CompanyAddress addressObj = addressDAO.findById(addressId);

			if (addressObj == null) {
				continue;
			}

			addressObj.setAddressName((String) item.get("address_name"));
			addressObj.setAddress((String) item.get("address"));
			addressObj.setGoogleMap((String) item.get("google_map"));
			addressObj.setUserUpdate(onlineUser.getId());
			addressObj.setTimeUpdate(DateUtil.getCurrentTime());

			addressDAO.update(addressObj);
		}

		// delete
		for (Object id : addressDeleted) {

			Long addressId = Long.valueOf(id.toString());
			CompanyAddress addressObj = addressDAO.findById(addressId);

			if (addressObj != null) {
				addressDAO.delete(addressObj);
			}
		}

	}

	public void processContactUpdateRequest(String companyId, User onlineUser, Map<String, Object> contact,
			Map<String, File> profileMap, Map<String, String> profileNameMap) throws Exception {
		List<Map<String, Object>> contactCreated = (List<Map<String, Object>>) contact.get("created");
		List<Map<String, Object>> contactUpdated = (List<Map<String, Object>>) contact.get("updated");
		List<Object> contactDeleted = (List<Object>) contact.get("deleted");

		// create
		for (Map<String, Object> item : contactCreated) {

			CompanyContact contactObj = new CompanyContact();
			contactObj.setCompanyId(companyId);
			contactObj.setCompanyAddressId(item.get("address_id").toString());
			contactObj.setTitleNameTh((String) item.get("title_name_th"));
			contactObj.setTitleNameEn((String) item.get("title_name_en"));
			contactObj.setContactNameTh((String) item.get("name_th"));
			contactObj.setContactName((String) item.get("name_en"));
			contactObj.setPosition((String) item.get("position"));
			contactObj.setPhone((String) item.get("phone_number"));
			contactObj.setEmail((String) item.get("email"));
			contactObj.setUserCreate(onlineUser.getId());
			contactObj.setUserUpdate(onlineUser.getId());
			contactObj.setTimeCreate(DateUtil.getCurrentTime());
			contactObj.setTimeUpdate(DateUtil.getCurrentTime());

			contactDAO.save(contactObj);

			String tempId = item.get("contact_id").toString();
			File profileFile = profileMap.get(tempId);

			if (profileFile != null) {
				
				String fileName = profileNameMap.get(tempId);
				String contactId = contactObj.getCompanyContactId().toString();
				String fileId = processFileUpload("upload/contact/", profileFile, fileName, "contact", contactId, onlineUser);
				
				contactObj.setFileId(fileId);
				
				contactDAO.update(contactObj);
			}
		}

		// update
		for (Map<String, Object> item : contactUpdated) {

			Long contactId = Long.valueOf(item.get("contact_id").toString());
			CompanyContact contactObj = contactDAO.findById(contactId);

			if (contactObj == null) {
				continue;
			}

			contactObj.setCompanyAddressId(item.get("address_id").toString());
			contactObj.setTitleNameTh((String) item.get("title_name_th"));
			contactObj.setTitleNameEn((String) item.get("title_name_en"));
			contactObj.setContactNameTh((String) item.get("name_th"));
			contactObj.setContactName((String) item.get("name_en"));
			contactObj.setPosition((String) item.get("position"));
			contactObj.setPhone((String) item.get("phone_number"));
			contactObj.setEmail((String) item.get("email"));
			contactObj.setUserUpdate(onlineUser.getId());
			contactObj.setTimeUpdate(DateUtil.getCurrentTime());
			
			File profileFile = profileMap.get(contactId.toString());

			if (profileFile != null) {
				
				String fileName = profileNameMap.get(contactId.toString());
				String fileId = processFileUpload("upload/contact/", profileFile, fileName, "contact", contactId.toString(), onlineUser);
				
				contactObj.setFileId(fileId);
			}

			contactDAO.update(contactObj);
		}

		// delete
		for (Object id : contactDeleted) {

			Long contactId = Long.valueOf(id.toString());
			CompanyContact contactObj = contactDAO.findById(contactId);

			if (contactObj != null) {
				contactDAO.delete(contactObj);
			}
		}
	}

	private String processFileUpload(String filePath, File file, String fileName, String page, String pageId,
			User onlineUser) throws Exception {

		Integer maxId = fileUploadDAO.getMaxId() + 1;

		ServletContext context = request.getServletContext();
		String fileServerPath = context.getRealPath("/");
		String originalFileName = fileName;

		FileUtil.upload(file, fileServerPath + filePath, maxId + "_" + originalFileName);

		int split = originalFileName.lastIndexOf('.');

		String name = originalFileName.substring(0, split);
		String type = originalFileName.substring(split).toLowerCase();

		FileUpload fileUpload = new FileUpload();

		fileUpload.setFileId(maxId.intValue());
		fileUpload.setPath(filePath + maxId + "_" + originalFileName);
		fileUpload.setSize(formatFileSize(file.length()));
		fileUpload.setName(name);
		fileUpload.setType(type);

		fileUpload.setUserId(onlineUser.getId());
		fileUpload.setUserCreate(onlineUser.getId());

		fileUpload.setPage(page);
		fileUpload.setPageId(pageId);

		fileUpload.setTimeCreate(DateUtil.getCurrentTime());

		fileUploadDAO.save(fileUpload);

		return fileUpload.getFileId().toString();
	}
}
