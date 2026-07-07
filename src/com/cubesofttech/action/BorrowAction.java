package com.cubesofttech.action;

import java.io.File;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.cubesofttech.dao.BorrowDAO;
import com.cubesofttech.dao.EquipmentDAO;
import com.cubesofttech.dao.EquipmentStatusDAO;
import com.cubesofttech.dao.FileUploadDAO;
import com.cubesofttech.dao.HolidayDAO;
import com.cubesofttech.dao.LeaveDAO;
import com.cubesofttech.dao.LeaveTypeDAO;
import com.cubesofttech.dao.UserDAO;
import com.cubesofttech.model.Borrow;
import com.cubesofttech.model.Equipment;
import com.cubesofttech.model.EquipmentStatus;
import com.cubesofttech.model.FileUpload;
import com.cubesofttech.model.LeaveType;
import com.cubesofttech.model.Leaves;
import com.cubesofttech.model.User;
import com.cubesofttech.service.BorrowService;
import com.cubesofttech.util.DateUtil;
import com.cubesofttech.util.FileUtil;
import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;

public class BorrowAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2280661337420278284L;
	Logger log = Logger.getLogger(getClass());
	HttpServletRequest request = ServletActionContext.getRequest();
	HttpServletResponse response = ServletActionContext.getResponse();

	@Autowired
	private UserDAO userDAO;

	@Autowired
	private LeaveDAO leaveDAO;

	@Autowired
	private HolidayDAO holidayDAO;

	@Autowired
	private LeaveTypeDAO leavetypeDAO;

	@Autowired
	private FileUploadDAO fileuploadDAO;

	@Autowired
	private BorrowDAO borrowDAO;

	@Autowired
	private EquipmentDAO equipmentDAO;
	
	@Autowired
	private EquipmentStatusDAO equipmentStatusDAO;

	@Autowired
	private BorrowService borrowService;

	private User user;

	private Borrow borrow;

	private Equipment equiupment;

	private File fileUpload;

	private int fileId;

	private int eqid;

	private String itemNo;

	private String equipmentId;

	private String borrowId;

	private String type;

	private String image;

	private String userCreate;

	private String userUpdate;

	private String timeUpdate;

	private String userId;

	private String detail;

	private String fileUploadFileName;

	private String userUploadId;

	private String userUploadCreate;

	private String fileUploadSize;

	private String serialno;

	private String name;

	private String process;

	private String battery;

	private String hdd;

	private String window;

	private String ram;

	private String location;

	private String amount;

	private String timeCreate;

	private String status;

	public int getEqid() {
		return eqid;
	}

	public void setEqid(int eqid) {
		this.eqid = eqid;
	}

	public String getItemNo() {
		return itemNo;
	}

	public void setItemNo(String itemNo) {
		this.itemNo = itemNo;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getTimeUpdate() {
		return timeUpdate;
	}

	public void setTimeUpdate(String timeUpdate) {
		this.timeUpdate = timeUpdate;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getSerialno() {
		return serialno;
	}

	public void setSerialno(String serialno) {
		this.serialno = serialno;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getProcess() {
		return process;
	}

	public void setProcess(String process) {
		this.process = process;
	}

	public String getBattery() {
		return battery;
	}

	public void setBattery(String battery) {
		this.battery = battery;
	}

	public String getFileUploadSize() {
		return fileUploadSize;
	}

	public void setFileUploadSize(String fileUploadSize) {
		this.fileUploadSize = fileUploadSize;
	}

	public String getHdd() {
		return hdd;
	}

	public void setHdd(String hdd) {
		this.hdd = hdd;
	}

	public String getWindow() {
		return window;
	}

	public void setWindow(String window) {
		this.window = window;
	}

	public String getRam() {
		return ram;
	}

	public void setRam(String ram) {
		this.ram = ram;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getTimeCreate() {
		return timeCreate;
	}

	public void setTimeCreate(String timeCreate) {
		this.timeCreate = timeCreate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Equipment getEquiupment() {
		return equiupment;
	}

	public void setEquiupment(Equipment equiupment) {
		this.equiupment = equiupment;
	}

	public String getUserCreate() {
		return userCreate;
	}

	public void setUserCreate(String userCreate) {
		this.userCreate = userCreate;
	}

	public String getUserUpdate() {
		return userUpdate;
	}

	public void setUserUpdate(String userUpdate) {
		this.userUpdate = userUpdate;
	}

	public void setEquipmentId(String equipmentId) {
		this.equipmentId = equipmentId;
	}

	public int getFileId() {
		return fileId;
	}

	public void setFileId(int fileId) {
		this.fileId = fileId;
	}

	public String getUserUploadCreate() {
		return userUploadCreate;
	}

	public void setUserUploadCreate(String userUploadCreate) {
		this.userUploadCreate = userUploadCreate;
	}

	public String getUserUploadId() {
		return userUploadId;
	}

	public void setUserUploadId(String userUploadId) {
		this.userUploadId = userUploadId;
	}

	public String getFileUploadFileName() {
		return fileUploadFileName;
	}

	public void setFileUploadFileName(String fileUploadFileName) {
		this.fileUploadFileName = fileUploadFileName;
	}

	public File getFileUpload() {
		return fileUpload;
	}

	public void setFileUpload(File fileUpload) {
		this.fileUpload = fileUpload;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public Borrow getBorrow() {
		return borrow;
	}

	public void setBorrow(Borrow borrow) {
		this.borrow = borrow;
	}

	public String getBorrowId() {
		return borrowId;
	}

	public void setBorrowId(String borrowId) {
		this.borrowId = borrowId;
	}

	public String getEquipmentId() {
		return equipmentId;
	}

	public static final String APPROVEBORROW = "approveborrow";
	public static final String ONLINEUSER = "onlineUser";
	public static final String STATUSFLAG = "status";
	public static final String USERID = "userId";

	public String approve() {
		try {
			request.setAttribute(APPROVEBORROW, equipmentDAO.approve());
			request.setAttribute("borrowList", borrowDAO.findAll());
			return SUCCESS;
		} catch (Exception e) {
			log.error(e);
			return ERROR;
		}
	}

	public String info() {
		try {
			Integer eqId = equipmentDAO.getMaxId();
			int newMax = eqId + 1;
			String itemId = borrowService.manageStringItemId(newMax);
			String newItemNo = "ITEM" + itemId.trim();
			request.setAttribute("newItemNo", newItemNo);
			return SUCCESS;
		} catch (Exception e) {
			log.error(e);
			return ERROR;
		}
	}

	public String list() {
		try {
			User ur = (User) request.getSession().getAttribute(ONLINEUSER);
			String roleId = ur.getRoleId();

			String status = request.getParameter("s");
			String name = request.getParameter("name_search");
			String type = request.getParameter("type");
			List<Map<String, Object>> xxx;
			if (status == null) {
				status = "";
			}
			if (name != null) {

				xxx = equipmentDAO.searchList(status, name, type);

			} else {

				xxx = equipmentDAO.searchList(status);
			}

			request.setAttribute("borrow_history", borrowDAO.findAll_1());

			request.setAttribute("xxx", xxx);
			request.setAttribute(STATUSFLAG, status);
			request.setAttribute("status_type", type);
			request.setAttribute("role", roleId);
			request.setAttribute("name_search", name);

			return SUCCESS;
		} catch (Exception e) {
			log.error(e);
			return ERROR;
		}
	}

	public String searchList() {
		try {
			String borrowStatus = request.getParameter("s");
			request.setAttribute("xxx", equipmentDAO.searchList(borrowStatus));
			request.setAttribute(STATUSFLAG, borrowStatus);
			return SUCCESS;
		} catch (Exception e) {
			log.error(e);
			return ERROR;
		}
	}

	public String openEdit() {
		try {
			String equipid = request.getParameter("product");
			int eqId = Integer.parseInt(equipid);
			User ur = (User) request.getSession().getAttribute(ONLINEUSER);
			request.setAttribute("eqid", equipmentDAO.findByEquipmentId(eqId));
			request.setAttribute("x", eqId);
			request.setAttribute("role", ur.getRoleId());

			request.setAttribute("borrow_history", borrowDAO.find_History(equipid));

			return SUCCESS;
		} catch (Exception e) {
			log.error(e);
			return ERROR;
		}
	}

	public String deleteEquipment() {
		try {
			User ur = (User) request.getSession().getAttribute(ONLINEUSER);
			String roleId = ur.getRoleId();
			String eqId = request.getParameter("equipment_id");
			Equipment equipment = equipmentDAO.findById(Integer.valueOf(eqId));
			equipment.setEquipmentId(Integer.valueOf(eqId));
			equipment.setStatus("Z");
			equipment.setUserUpdate(roleId);
			equipmentDAO.update(equipment);
			request.setAttribute("xxx", equipmentDAO.listdetail());
			return SUCCESS;
		} catch (Exception e) {
			log.error(e);
			return ERROR;
		}
	}

	public String updateBorrowApprovedReason() {
		try {

			String borrowId = request.getParameter("borrow_id");
			String reason = request.getParameter("reason");
			Borrow borrow = borrowDAO.findById(Integer.parseInt(borrowId));
			if (borrow != null) {
				borrow.setReasona(reason);
				borrowDAO.update(borrow);
				this.borrow = borrow;
			}
			return SUCCESS;
		} catch (Exception e) {
			log.error(e);
			return ERROR;
		}
	}

	public String product() {
		try {
			User ur = (User) request.getSession().getAttribute(ONLINEUSER);
			String userLogin = ur.getId();
			String roleId = ur.getRoleId();
			int maxId = fileuploadDAO.getMaxId() + 1;
			Equipment equipment = equipmentDAO.findByEquipmentId(eqid);
			FileUpload fileupload = new FileUpload();
			if (fileUpload != null) {
				ServletContext context = request.getServletContext();
				String fileServerPath = context.getRealPath("/");
				fileupload.setSize(fileUploadSize);
				String fileName = fileUploadFileName;
				fileupload.setPath("/upload/user/" + maxId + "_" + fileName);
				FileUtil.upload(fileUpload, fileServerPath + "upload/user/", maxId + "_" + fileName);
				int l = fileUploadFileName.length();
				int split = fileUploadFileName.indexOf(".");
				String name2 = fileUploadFileName.substring(0, split);
				String type2 = (String) fileUploadFileName.subSequence(split, l);
				fileupload.setFileId(maxId);
				fileupload.setUserId(userLogin);
				fileupload.setUserUpdate(userLogin);
				fileupload.setName(name2);
				fileupload.setType(type2);
				fileupload.setTimeUpdate(DateUtil.getCurrentTime());
				fileupload.setPage("equipment");
				fileupload.setPageId(String.valueOf(equipment.getEquipmentId()));
				fileuploadDAO.save(fileupload);
				equipment.setImage("/upload/user/" + maxId + "_" + fileName);
				equipment.setTimeUpdate(DateUtil.getCurrentTime());
				equipment.setItemNo(itemNo);
				equipment.setUserUpdate(userLogin);
				equipment.setType(type);
				equipment.setName(name);
				equipment.setProcess(process);
				equipment.setBattery(battery);
				equipment.setHdd(hdd);
				equipment.setWindows(window);
				equipment.setRam(ram);
				equipment.setStatus(status);
				equipment.setSerialNo(serialno);
				equipment.setLocation(location);
				equipment.setDetail(detail);
				equipmentDAO.update(equipment);
			} else {
				equipment.setTimeUpdate(DateUtil.getCurrentTime());
				equipment.setItemNo(itemNo);
				equipment.setUserUpdate(userLogin);
				equipment.setType(type);
				equipment.setName(name);
				equipment.setProcess(process);
				equipment.setBattery(battery);
				equipment.setHdd(hdd);
				equipment.setWindows(window);
				equipment.setRam(ram);
				equipment.setStatus(status);
				equipment.setSerialNo(serialno);
				equipment.setLocation(location);
				equipment.setDetail(detail);
				equipmentDAO.update(equipment);
			}
			request.setAttribute("xxx", equipmentDAO.listdetail());
			request.setAttribute("role", roleId);
			request.setAttribute(USERID, ur.getId());
			request.setAttribute("test", "test");
			return SUCCESS;
		} catch (Exception e) {
			log.error(e);
			return ERROR;
		}
	}

	public String saveNew() {
		try {
			User ur = (User) request.getSession().getAttribute(ONLINEUSER);
			int maxId = fileuploadDAO.getMaxId() + 1;
			FileUpload fileupload = new FileUpload();
			if (fileUpload != null) {
				ServletContext context = request.getServletContext();
				String fileServerPath = context.getRealPath("/");
				fileupload.setSize(fileUploadSize);
				String fileName = fileUploadFileName;
				fileupload.setPath("/upload/user/" + maxId + "_" + fileName);
				FileUtil.upload(fileUpload, fileServerPath + "upload/user/", maxId + "_" + fileName);
				int l = fileUploadFileName.length();
				int split = fileUploadFileName.indexOf(".");
				String name2 = fileUploadFileName.substring(0, split);
				String type2 = (String) fileUploadFileName.subSequence(split, l);
				fileupload.setFileId(maxId);
				fileupload.setUserId(ur.getId());
				fileupload.setUserCreate(ur.getId());
				fileupload.setName(name2);
				fileupload.setType(type2);
				fileupload.setTimeCreate(DateUtil.getCurrentTime());
				fileupload.setPage("equipment");
				fileupload.setPageId(String.valueOf(equipmentDAO.getMaxId() + 1));
				fileuploadDAO.save(fileupload);
				Equipment equipment = new Equipment();
				equipment.setUserCreate(ur.getId());
				equipment.setEquipmentId(equipmentDAO.getMaxId() + 1);
				equipment.setProcess(process);
				equipment.setItemNo(itemNo);
				equipment.setSerialNo(serialno);
				equipment.setBattery(battery);
				equipment.setHdd(hdd);
				equipment.setWindows(window);
				equipment.setRam(ram);
				equipment.setLocation(location);
				equipment.setAmount(1);
				equipment.setName(name);
				equipment.setStatus(status);
				equipment.setType(type);
				equipment.setDetail(detail);
				equipment.setTimeCreate(DateUtil.getCurrentTime());
				equipment.setImage("/upload/user/" + maxId + "_" + fileName);
				equipmentDAO.save(equipment);
			} else {
				Equipment equipment = new Equipment();
				equipment.setDetail(detail);
				equipment.setUserCreate(ur.getId());
				equipment.setEquipmentId(equipmentDAO.getMaxId() + 1);
				equipment.setProcess(process);
				equipment.setItemNo(itemNo);
				equipment.setSerialNo(serialno);
				equipment.setBattery(battery);
				equipment.setHdd(hdd);
				equipment.setWindows(window);
				equipment.setRam(ram);
				equipment.setLocation(location);
				equipment.setAmount(1);
				equipment.setName(name);
				equipment.setStatus(status);
				equipment.setType(type);
				equipment.setTimeCreate(DateUtil.getCurrentTime());
				equipmentDAO.save(equipment);
			}
			request.setAttribute("xxx", equipmentDAO.listdetail());
			return SUCCESS;
		} catch (Exception e) {
			log.error(e);
			return ERROR;
		}
	}

	public String search() {
		try {
			request.setAttribute("xxx", equipmentDAO.searchAvai(request.getParameter(STATUSFLAG)));
			return SUCCESS;
		} catch (Exception e) {
			log.error(e);
			return ERROR;
		}
	}

	public String updateStatus() {
		try {
			Equipment bo = equipmentDAO.findById(Integer.valueOf(request.getParameter("statusequipment")));
			bo.setStatus("B");
			equipmentDAO.update(bo);
			String id_borrow = request.getParameter("id_borrow");
			Borrow b = borrowDAO.findById(Integer.valueOf(id_borrow));
			b.setStatus("B");
			borrowDAO.update(b);

			request.setAttribute(APPROVEBORROW, equipmentDAO.approve());
			return SUCCESS;
		} catch (Exception e) {
			log.error(e);
			return ERROR;
		}
	}

	public String reStatusEquipment() {
		try {
			Equipment bo = equipmentDAO.findById(Integer.valueOf(request.getParameter("restatus")));
			bo.setStatus("A");
			bo.setAmount(1);
			equipmentDAO.update(bo);
			request.setAttribute(APPROVEBORROW, equipmentDAO.approve());
			return SUCCESS;
		} catch (Exception e) {
			log.error(e);
			return ERROR;
		}
	}

	public String updateBorrowStatus() { //
		try {

			Borrow borrow = borrowDAO.findById(Integer.parseInt(request.getParameter("borrow_id")));
			if (request.getParameter("return_type").equals("return")) {
				if (borrow != null) {
					Equipment equipment = equipmentDAO.findByEquipmentId(Integer.parseInt(borrow.getEquipmentId()));
					borrow.setStatus("F");
					borrowDAO.update(borrow);
					equipment.setAmount(1);
					equipment.setStatus("A");
					equipmentDAO.update(equipment);
				}
			} else {
				if (borrow != null) {
					borrow.setStatus("X");
					borrowDAO.update(borrow);
				}
			}
			this.borrow = borrow;
			return SUCCESS;
		} catch (Exception e) {
			log.error(e);
			return ERROR;
		}
	}

	public String deleteBorrow() {
		try {
			Borrow borrow = borrowDAO.findById(Integer.valueOf(request.getParameter("borrowid")));
			Equipment equipment = equipmentDAO.findByEquipmentId(Integer.parseInt(borrow.getEquipmentId()));
			borrow.setStatus("U");
			equipment.setStatus("A");
			equipment.setAmount(1);
			equipmentDAO.update(equipment);
			borrowDAO.update(borrow);
			request.setAttribute(APPROVEBORROW, equipmentDAO.approve());
			return SUCCESS;
		} catch (Exception e) {
			log.error(e);
			return ERROR;
		}
	}

	public String reStatusEquipmentToX() {
		try {
			Borrow borrow = borrowDAO.findById(Integer.valueOf(request.getParameter("borrowid")));
			borrow.setStatus("X");
			borrowDAO.update(borrow);
			request.setAttribute(APPROVEBORROW, equipmentDAO.approve());
			return SUCCESS;
		} catch (Exception e) {
			log.error(e);
			return ERROR;
		}
	}

	public String detailBorrow() {
		try {
			int borrowid = Integer.parseInt(request.getParameter("borrowid"));
			request.setAttribute("list", borrowDAO.Borrowlistnirobonxx(borrowid));
			return SUCCESS;
		} catch (Exception e) {
			log.error(e);
			return ERROR;
		}
	}

	public String calendar() {
		try {
			User ur = (User) request.getSession().getAttribute(ONLINEUSER);
			String userId = ur.getId();
			String userLogin = ur.getId();
			String dateNow = request.getParameter("date");
			request.setAttribute("leaveQuota", ur.getLeaveQuota1());
			request.setAttribute("userSelect", userId);
			String name = request.getParameter(USERID);
			if (name != null) {
				userId = name;
			}
			if (dateNow != null) {
				java.util.Date utilDate = new SimpleDateFormat("dd-MM-yyyy").parse(dateNow);
				java.sql.Date startDate = new java.sql.Date(utilDate.getTime());

				request.setAttribute("flag12", startDate);
			}
			User user = userDAO.findById(userId);
			List<Map<String, Object>> leave = leaveDAO.searchtable3(userId);
			BigDecimal x1 = new BigDecimal(0);
			BigDecimal x2 = new BigDecimal(0);
			BigDecimal x3 = new BigDecimal(0);
			BigDecimal x4;
			List<Map<String, Object>> wanla1 = leaveDAO.findleaveallByType(userId, 1);
			List<Map<String, Object>> wanla2 = leaveDAO.findleaveallByType(userId, 2);
			List<Map<String, Object>> wanla3 = leaveDAO.findleaveallByType(userId, 3);
			for (int i = 0; i < wanla1.size(); i++) {
				BigDecimal aa = (BigDecimal) wanla1.get(i).get("no_day");
				BigDecimal b = aa;
				x1 = b.add(x1);
				request.setAttribute("x1", x1);
			}
			for (int i = 0; i < wanla2.size(); i++) {
				BigDecimal aa = (BigDecimal) wanla2.get(i).get("no_day");
				BigDecimal b = aa;
				x2 = b.add(x2);
				request.setAttribute("x2", x2);
			}
			for (int i = 0; i < wanla3.size(); i++) {
				BigDecimal aa = (BigDecimal) wanla3.get(i).get("no_day");
				BigDecimal b = aa;
				x3 = b.add(x3);
				request.setAttribute("x3", x3);
			}
			x4 = x1.add(x2).add(x3);
			request.setAttribute("userseq", userDAO.sequense());
			request.setAttribute("x4", x4);
			request.setAttribute("leave", leave);
			request.setAttribute("a", user);
			request.setAttribute(USERID, userId);
			request.setAttribute("flag_search", "");
			request.setAttribute("holidayList", holidayDAO.findAll());
			List<LeaveType> typeLeave = leavetypeDAO.findAll_calendar();
			request.setAttribute("type_1", typeLeave.get(0).getLeaveTypeName());
			request.setAttribute("type_2", typeLeave.get(1).getLeaveTypeName());
			request.setAttribute("type_3", typeLeave.get(2).getLeaveTypeName());
			request.setAttribute("type_id_1", typeLeave.get(0).getLeaveTypeId());
			request.setAttribute("type_id_2", typeLeave.get(1).getLeaveTypeId());
			request.setAttribute("type_id_3", typeLeave.get(2).getLeaveTypeId());

			List<LeaveType> leavetypeList = leavetypeDAO.findAll_calendar();

			request.setAttribute("leavetypeList", leavetypeList);

			// String userId = request.getParameter("userId"); // applicant = null
			if (userId == null || userId == userLogin) { // null not in loop
				userId = userLogin;
			}
			if (userId == null && userId == userLogin) {
				List<User> leader = userDAO.findBySelect(userId);
				request.setAttribute("leader", leader);
				request.setAttribute("userId", userId);
			}
			List<User> leader = userDAO.findBySelect(userId);
			request.setAttribute("leader", leader);
			request.setAttribute("userId", userId);

			return SUCCESS;
		} catch (Exception e) {
			log.error(e);
			return ERROR;
		}
	}

	public String searchLeaveCalendar() {
		try {
			request.setAttribute(USERID, request.getParameter("name"));
			return SUCCESS;
		} catch (Exception e) {
			log.error(e);
			return ERROR;
		}
	}

	public String resizeCalendar() {
		try {
			int dateId = Integer.parseInt(request.getParameter("id"));
			Timestamp endDate = DateUtil.dateFormatEdit(request.getParameter("date_end"));
			Leaves leaveid = leaveDAO.findByLeaveId(dateId);
			leaveid.setEndDate(endDate);
			leaveDAO.update(leaveid);
			request.setAttribute("flag12", endDate);
			return SUCCESS;
		} catch (Exception e) {
			log.error(e);
			return ERROR;
		}
	}

	public String openBorrwCharts() throws Exception {
		try {

			List<Map<String, Object>> borrowStatus = borrowDAO.findBorrowAll();

			log.info(borrowStatus.size());
			int available = 0, borrowed = 0, waiting = 0, corrupted = 0, lost = 0, fixed = 0;

			for (int i = 0; i < borrowStatus.size(); i++) {
				String status = borrowStatus.get(i).get("status").toString();
				log.info(status);

				if (status.equals("A")) {
					available += 1;
					log.info(5);
				} else if (status.equals("B")) {
					borrowed++;
					log.info(4);
				} else if (status.equals("D")) {
					waiting++;
					log.info(3);
				} else if (status.equals("C")) {
					corrupted++;
					log.info(2);
				} else if (status.equals("L")) {
					lost++;
					log.info(1);
				} else if (status.equals("F")) {
					fixed++;
					log.info(0);
				}
			}
			request.setAttribute("available", available);
			request.setAttribute("borrowed", borrowed);
			request.setAttribute("waiting", waiting);
			request.setAttribute("corrupted", corrupted);
			request.setAttribute("lost", lost);
			request.setAttribute("fixed", fixed);
			return SUCCESS;
		} catch (Exception e) {
			return ERROR;
		}
	}
	public boolean tryParseInt(String value) {
	    try {
	        int x= Integer.parseInt(value);
	        return true;
	    } catch (NumberFormatException e) {
	        return false;
	    }
	}

	public String leave_calendar() throws Exception{
		try {
			User ur = (User) request.getSession().getAttribute(ONLINEUSER);
			String userId = ur.getId();
			String dateNow = request.getParameter("date");
			request.setAttribute("userSelect", userId);
			String name = request.getParameter(USERID);
			if (name != null) {
				userId = name;
			}
			if (dateNow != null) {
				java.util.Date utilDate = new SimpleDateFormat("dd-MM-yyyy").parse(dateNow);
				java.sql.Date startDate = new java.sql.Date(utilDate.getTime());

				request.setAttribute("flag12", startDate);
			}
			
			request.setAttribute("userseq", userDAO.sequense());
			request.setAttribute(USERID, userId);
			request.setAttribute("flag_search", "");
			request.setAttribute("holidayList", holidayDAO.findAll2years());
			List<LeaveType> leavetypeList = leavetypeDAO.findAll_calendar();
			request.setAttribute("leavetypeList", leavetypeList);

			List<LeaveType> type_leave = leavetypeDAO.findAll_calendar();
			for (int i = 0; i < type_leave.size(); i++) {
				LeaveType leave = type_leave.get(i);
				request.setAttribute("type_" + leave.getLeaveTypeId(), leave.getLeaveTypeName());
			}

			DateTimeFormatter date1 = DateTimeFormatter.ofPattern("01-01-yyyy");
			LocalDate localDate = LocalDate.now();
			String s = "00:00:00.0";

			Timestamp start_date = DateUtil.dateToTimestamp(date1.format(localDate), s);
			Timestamp end_date = DateUtil.changetoEndYear(date1.format(localDate));
			List leavelist = leaveDAO.myLeavesList(userId, start_date, end_date);
			Double leave_1 = 0.000, leave_2 = 0.000, leave_3 = 0.000, leave_5 = 0.000, leave_6 = 0.000;
			
			String status = "1";
			List LeaveID = leaveDAO.findLeaveId(userId, start_date, end_date, status);
			
			if (leavelist != null) {
				request.setAttribute("leave", leavelist);
				int x=0;
				
				while (x <= LeaveID.size()-1) {
					System.out.println("inLoopWhile");
					String a[] = LeaveID.get(x).toString().split("[={}]");
					System.out.println("Split Success");
					for(int b=0;b<=a.length-1;b++) {
						System.out.println("a["+b+"]= "+a[b]);
					}
					int id=0;
					for(int b=0;b<=a.length-1;b++) {
						System.out.println("inLoopFor");
						if(tryParseInt(a[b])) {
							System.out.println("inIf");
							id=Integer.parseInt(a[b]);
							System.out.println("This is Array No: "+b+" ="+a[b]);
							Leaves leaveDashboard =  leaveDAO.findByLeaveId(id);
							System.out.println("Ref Success");
							Double noday = leaveDashboard.getNoDay().doubleValue();
							System.out.println("This NoDay : "+noday);
							if (leaveDashboard.getLeaveTypeId().contains("1")) {
								leave_1 = leave_1 + noday;
							}
							if (leaveDashboard.getLeaveTypeId().contains("2")) {
								leave_2 = leave_2 + noday;
							}
							if (leaveDashboard.getLeaveTypeId().contains("3")) {
								leave_3 = leave_3 + noday;
							}
							if (leaveDashboard.getLeaveTypeId().contains("5")) {
								leave_5 = leave_5 + noday;
							}
							if (leaveDashboard.getLeaveTypeId().contains("6")) {
								leave_6 = leave_6 + noday;
							}
						}
					}
					x++;
				}
	System.out.println("666666");
			}
			request.setAttribute("leave_1", leave_1);
			request.setAttribute("leave_2", leave_2);
			request.setAttribute("leave_3", leave_3);
			request.setAttribute("leave_5", leave_5);
			request.setAttribute("leave_6", leave_6);

			Date day = new Date();
			LocalDate localdate = day.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
			Double quotaLastYear = leaveDAO.LastYearQuota(userId, localdate.getYear());
			Double quotaThisYear = leaveDAO.ThisYearQuota(userId);
			request.setAttribute("quotaThisYear", quotaThisYear);
			request.setAttribute("quotaLastYear", quotaLastYear);
			request.setAttribute("leave_6l", quotaLastYear - leave_6);
			
			String year = localdate.toString().substring(0, 4);
			Timestamp tend = Timestamp.valueOf(year+"-04-01 00:00:00");
			Timestamp tnow = new Timestamp(day.getTime());
			
			request.setAttribute("tnow", tnow);
			request.setAttribute("tend", tend);
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}
	
	public String listBorrower() {
		try {
			String id = request.getParameter("id");
			request.setAttribute("borrowList", borrowDAO.borrower(id));

		} catch (Exception e) {
			log.error(e);
			return ERROR;
		}
		return SUCCESS;
	}
		
	
}