package com.cubesofttech.action;

import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.cubesofttech.dao.BorrowDAO;
import com.cubesofttech.dao.EquipmentDAO;
import com.cubesofttech.dao.EquipmentStatusDAO;
import com.cubesofttech.dao.EquipmentTypeDAO;
import com.cubesofttech.dao.UserDAO;
import com.cubesofttech.model.Borrow;
import com.cubesofttech.model.Equipment;
import com.cubesofttech.model.EquipmentStatus;
import com.cubesofttech.model.EquipmentType;
import com.cubesofttech.model.User;
import com.cubesofttech.util.DateUtil;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.opensymphony.xwork2.ActionSupport;

public class BorrowingAction extends ActionSupport {

	private static final long serialVersionUID = 2280661337420278284L;

	Logger log = Logger.getLogger(getClass());
	HttpServletRequest request = ServletActionContext.getRequest();
	HttpServletResponse response = ServletActionContext.getResponse();

	@Autowired
	private EquipmentDAO equipmentDAO;
	
	@Autowired
	private EquipmentStatusDAO equipmentStatusDAO;

	@Autowired
	private UserDAO userDAO;

	@Autowired
	private BorrowDAO borrowDAO;
	
	@Autowired
	private EquipmentTypeDAO equipmentTypeDAO;

	public EquipmentDAO getEquipmentDAO() {
		return equipmentDAO;
	}

	public void setEquipmentDAO(EquipmentDAO equipmentDAO) {
		this.equipmentDAO = equipmentDAO;
	}

	public UserDAO getUserDAO() {
		return userDAO;
	}

	public void setUserDAO(UserDAO userDAO) {
		this.userDAO = userDAO;
	}

	public BorrowDAO getBorrowDAO() {
		return borrowDAO;
	}

	public void setBorrowDAO(BorrowDAO borrowDAO) {
		this.borrowDAO = borrowDAO;
	}

	public static final String USERSEQ = "userseq";
	public static final String USERS = "users";
	public static final String ONLINEUSER = "onlineUser";
	public static final String USERBORROWID = "userborrowId";
	public static final String SEARCHUSER = "searchuser";
	public static final String EQIID = "eqi_id";
	public static final String NAME = "name";
	public static final String SELECTCHECK = "selectchect";
	public static final String LIST = "list";
	public static final String ONLINE = "online";
	
	private User onlineUser = (User) request.getSession().getAttribute("onlineUser");
	private Set<String> userAuthority = (Set<String>) request.getSession().getAttribute("userAuthority");
	private Timestamp timestamp = new Timestamp(System.currentTimeMillis());
	
	public String open() {
		try {

			request.setAttribute(USERSEQ, userDAO.sequense());

			request.setAttribute(USERS, userDAO.sequense());

			List<Equipment> name = equipmentDAO.findAllBorrow();

			request.setAttribute(NAME, name);

			request.setAttribute("bor", borrowDAO.findAll());

			User ur = (User) request.getSession().getAttribute(ONLINEUSER);
			String logonUser = ur.getId();

			request.setAttribute(LIST, borrowDAO.Borrowinglist());

			request.setAttribute("select", borrowDAO.check());

			String userborrowId = request.getParameter(USERBORROWID);
			request.setAttribute(SEARCHUSER, userborrowId);

			request.setAttribute(EQIID, request.getParameter("id_eqi"));

			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}

	}

	public String save() {
		try {

			request.setAttribute(USERSEQ, userDAO.sequense());

			request.setAttribute(USERS, userDAO.sequense());

			request.setAttribute(NAME, equipmentDAO.findAllBorrow());

			User ur = (User) request.getSession().getAttribute(ONLINEUSER);
			String logonUser = ur.getId();

			String time = request.getParameter("worktime");
			String start = request.getParameter("datestart");
			Timestamp dt_start = DateUtil.dateToTimestamp(start, time);

			Timestamp dt_ednd = null; // Check DateEnd
			String ednd = request.getParameter("dateend");
			if (ednd != "") {
				dt_ednd = DateUtil.dateToTimestamp(ednd, time);
			} else if (ednd == "") {
				dt_ednd = null;

			}

			String up = request.getParameter("equipmentid");
			Equipment eq = equipmentDAO.findById(Integer.valueOf(up));
			eq.setAmount(1);
			eq.setStatus("B");
			equipmentDAO.update(eq);

			String userborrow = request.getParameter(USERBORROWID);
			String reason = request.getParameter("reason");
			String location = request.getParameter("location");
			String contract = request.getParameter("contract");
			String remarks = request.getParameter("remarks");
			String item = request.getParameter("equipmentid");

			Borrow bo = new Borrow();
			bo.setUserCreate(logonUser);
			bo.setUserUpdate(logonUser);
			bo.setUserBorrowid(userborrow);
			bo.setEquipmentId(item);
			bo.setDateStart(dt_start);
			bo.setDateEnd(dt_ednd);
			bo.setReason(reason);
			bo.setLocation(location);
			bo.setContactAddr(contract);
			bo.setBorrowAmout(1);
			bo.setSum(1);
			bo.setStatus("W");

			bo.setBorrowId(borrowDAO.getMaxId() + 1);

			bo.setRemark(remarks);
			bo.setTimeCreate(DateUtil.getCurrentTime());
			bo.setTimeUpdate(DateUtil.getCurrentTime());
			borrowDAO.save(bo);

			List<Map<String, Object>> list = borrowDAO.Borrowinglist();
			request.setAttribute(LIST, list);

			List<Map<String, Object>> selectchect = borrowDAO.Borrowcheck();
			request.setAttribute(SELECTCHECK, selectchect);

			return SUCCESS;
		} catch (

		Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	public String add() {

		return SUCCESS;
	}

	public String search() {
		try {

			request.setAttribute(USERSEQ, userDAO.sequense());

			request.setAttribute(USERS, userDAO.sequense());

			request.setAttribute(NAME, equipmentDAO.findAllBorrow());

			request.setAttribute("bor", borrowDAO.findAll());

			User ur = (User) request.getSession().getAttribute(ONLINEUSER);
			String logonUser = ur.getId();

			List<Map<String, Object>> select = borrowDAO.check();
			request.setAttribute("select", select);

			String userborrowId = request.getParameter(USERBORROWID);
			log.info(userborrowId);
			if (userborrowId.equals("All")) {

				request.setAttribute(LIST, borrowDAO.Borrowinglist());

			} else {

				request.setAttribute(LIST, borrowDAO.search_borrow(userborrowId));
			}

			String eqi = request.getParameter("id_eqi");
			request.setAttribute(EQIID, eqi);

			request.setAttribute(SEARCHUSER, userborrowId);

			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}

	}

	public String delete() {
		try {

			request.setAttribute(USERSEQ, userDAO.sequense());

			String up = request.getParameter("eqid");
			Equipment eq = equipmentDAO.findById(Integer.valueOf(up));
			eq.setAmount(1);
			eq.setStatus("A");
			equipmentDAO.update(eq);

			request.setAttribute(USERS, userDAO.sequense());

			request.setAttribute(NAME, equipmentDAO.findAllBorrow());

			request.setAttribute(SEARCHUSER, request.getParameter(USERBORROWID));

			User ur = (User) request.getSession().getAttribute(ONLINEUSER);
			String logonUser = ur.getId();

			request.setAttribute(LIST, borrowDAO.Borrowinglist());

			return SUCCESS;
		} catch (Exception e) {
			return ERROR;
		}
	}

	public String update() {
		try {

			request.setAttribute(USERSEQ, userDAO.sequense());

			String up = request.getParameter("returnborrow");
			String online = request.getParameter(ONLINE);
			Borrow bo = borrowDAO.findById(Integer.valueOf(up));
			bo.setStatus("R");
			bo.setUserUpdate(online);
			bo.setTimeUpdate(DateUtil.getCurrentTime());

			borrowDAO.update(bo);
			String eqi_id = request.getParameter(EQIID);
			Equipment eq = equipmentDAO.findById(Integer.valueOf(eqi_id));
			eq.setStatus("A");
			equipmentDAO.update(eq);
			request.setAttribute(USERS, userDAO.sequense());
			request.setAttribute(NAME, equipmentDAO.findAllBorrow());

			request.setAttribute(SEARCHUSER, request.getParameter(USERBORROWID));

			User ur = (User) request.getSession().getAttribute(ONLINEUSER);
			String logonUser = ur.getId();

			request.setAttribute(LIST, borrowDAO.Borrowinglist());

			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}

	}

	public String show() {
		try {

			request.setAttribute(USERSEQ, userDAO.sequense());

			request.setAttribute("Showdetail", borrowDAO.Showdetail());

			request.setAttribute("select", borrowDAO.check());

			request.setAttribute("idborrow", request.getParameter("idborrow"));

			request.setAttribute(SELECTCHECK, borrowDAO.Borrowcheck());

			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}

	}

	public String statusSuccress() {
		try {

			request.setAttribute(USERSEQ, userDAO.sequense());

			String update = request.getParameter("return_succress");
			Borrow status = borrowDAO.findById(Integer.valueOf(update));
			status.setStatus("S");
			borrowDAO.update(status);

			request.setAttribute(USERS, userDAO.sequense());

			request.setAttribute(NAME, equipmentDAO.findAllBorrow());

			String userborrowId = request.getParameter(USERBORROWID);
			request.setAttribute(SEARCHUSER, userborrowId);

			User ur = (User) request.getSession().getAttribute(ONLINEUSER);
			String logonUser = ur.getId();

			request.setAttribute(LIST, borrowDAO.Borrowinglist());

			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}

	}

	public String unApprove() {
		try {
			List<Map<String, Object>> userseq = userDAO.sequense();
			request.setAttribute(USERSEQ, userseq);

			String update = request.getParameter("status_unapprove");
			Borrow status = borrowDAO.findById(Integer.valueOf(update));
			status.setStatus("S");
			status.setBorrowAmout(0);
			status.setSum(0);
			borrowDAO.update(status);

			request.setAttribute(USERS, userDAO.sequense());

			request.setAttribute(NAME, equipmentDAO.findAllBorrow());

			request.setAttribute(SEARCHUSER, request.getParameter(USERBORROWID));

			request.setAttribute(LIST, borrowDAO.Borrowinglist());

			return SUCCESS;
		} catch (Exception e) {
			return ERROR;
		}
	}

	public String cancle() {
		try {

			request.setAttribute(USERSEQ, userDAO.sequense());

			String update = request.getParameter("cancle");
			String online = request.getParameter(ONLINE);
			request.setAttribute(ONLINE, online);
			Borrow status = borrowDAO.findById(Integer.valueOf(update));
			status.setStatus("S");
			status.setUserUpdate(online);
			status.setBorrowAmout(0);
			status.setSum(0);
			status.setReasona("CANCEL");
			status.setTimeUpdate(DateUtil.getCurrentTime());
			borrowDAO.update(status);

			String up = request.getParameter("eqid");
			Equipment eq = equipmentDAO.findById(Integer.valueOf(up));
			eq.setAmount(1);
			eq.setStatus("A");
			equipmentDAO.update(eq);

			request.setAttribute(USERS, userDAO.sequense());

			request.setAttribute(NAME, equipmentDAO.findAllBorrow());

			String userborrowId = request.getParameter(USERBORROWID);
			request.setAttribute(SEARCHUSER, userborrowId);

			User ur = (User) request.getSession().getAttribute(ONLINEUSER);
			String logonUser = ur.getId();

			request.setAttribute(LIST, borrowDAO.Borrowinglist());

			return SUCCESS;
		} catch (Exception e) {
			return ERROR;
		}
	}

	public String cancelReturn() {
		try {

			request.setAttribute(USERSEQ, userDAO.sequense());

			String update = request.getParameter("Cancel_Return");
			Borrow status = borrowDAO.findById(Integer.valueOf(update));
			status.setStatus("W");
			borrowDAO.update(status);
			String eqi_id = request.getParameter(EQIID);
			Equipment eq = equipmentDAO.findById(Integer.valueOf(eqi_id));
			eq.setStatus("A");

			equipmentDAO.update(eq);

			request.setAttribute(USERS, userDAO.sequense());

			request.setAttribute(NAME, equipmentDAO.findAllBorrow());

			request.setAttribute(SEARCHUSER, request.getParameter(USERBORROWID));

			request.setAttribute(LIST, borrowDAO.Borrowinglist());

			return SUCCESS;
		} catch (Exception e) {
			return ERROR;
		}
	}

	public String updateBorrowDetail() {
		try {

			User ur = (User) request.getSession().getAttribute(ONLINEUSER);

			request.setAttribute(USERSEQ, userDAO.sequense());
			request.setAttribute(USERS, userDAO.sequense());

			List<Equipment> name = equipmentDAO.findAllBorrow();
			request.setAttribute(NAME, name);

			String up = request.getParameter("id_equipment");
			Equipment eq = equipmentDAO.findById(Integer.valueOf(up));

			String date_end = request.getParameter("date_end");
			String reason = request.getParameter("reason");
			String location = request.getParameter("location");
			String contact_address = request.getParameter("contact_address");
			String remark = request.getParameter("remark");

			String status_eqi = "";
			String status_borrow = request.getParameter("status_borrow");

			if (status_borrow.equals("W")) {
				status_eqi = "B";
			}
			if (status_borrow.equals("B")) {
				status_eqi = "B";
			}
			if (status_borrow.equals("R")) {
				status_eqi = "A";
			}
			if (status_borrow.equals("C")) {
				status_eqi = "A";
			}

			eq.setAmount(1);
			eq.setStatus(status_eqi);
			equipmentDAO.update(eq);

			String borrow_id = request.getParameter("id_borrow");
			Borrow bo = borrowDAO.findById(Integer.valueOf(borrow_id));
			bo.setStatus(status_borrow);
			bo.setContactAddr(contact_address);
			bo.setReason(reason);
			bo.setRemark(remark);
			bo.setLocation(location);
			if (date_end != "") {
				java.util.Date utilDate1 = new SimpleDateFormat("dd-MM-yyyy").parse(date_end);
				java.sql.Timestamp end_date = new java.sql.Timestamp(utilDate1.getTime());

				bo.setDateEnd(end_date);
			}
			borrowDAO.update(bo);

			request.setAttribute(LIST, borrowDAO.Borrowinglist());

			request.setAttribute(SELECTCHECK, borrowDAO.Borrowcheck());
			request.setAttribute(SEARCHUSER, "All");
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}

	}

	// Borrow re-make

	public String eBorrow() {
		try {
			String userJSON = userDAO.userListJSON();
			List<Equipment> e_available = equipmentDAO.findByStatus("A");
			List<EquipmentType> type = equipmentTypeDAO.getall();
			List<EquipmentStatus> status = equipmentStatusDAO.getall();
			
			String id = request.getParameter("id");
			
			if(id != null) { request.setAttribute("eId", id); }
			request.setAttribute("userList", userJSON);
			request.setAttribute("type", new Gson().toJson(type));
			request.setAttribute("equipments", new Gson().toJson(e_available));
			request.setAttribute("status", new Gson().toJson(status));
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}
	
	public String eBorrowLog() {
	    try {
	        String equipmentId = request.getParameter("equipmentId");

	        if (equipmentId == null || equipmentId.trim().isEmpty()) {
	            ServletActionContext.getResponse().setContentType("application/json;charset=UTF-8");
	            ServletActionContext.getResponse().getWriter().write("[]");
	            return null;
	        }

	        List<Map<String, Object>> borrowWithUser =
	                borrowDAO.findBorrowWithUserByEquipmentId(equipmentId.trim());

	        ServletActionContext.getResponse().setContentType("application/json;charset=UTF-8");
	        ServletActionContext.getResponse().getWriter().write(new Gson().toJson(borrowWithUser));
	        return null;

	    } catch (Exception ex) {
	        ex.printStackTrace();
	        try {
	            ServletActionContext.getResponse().setContentType("application/json;charset=UTF-8");
	            ServletActionContext.getResponse().getWriter().write("[]");
	        } catch (Exception ignore) {}
	        return null;
	    }
	}
	
	public String eBorrowEdit() {
	    try {
	        String bId = request.getParameter("id");

	        String userJSON = userDAO.userListJSON();
	        List<Equipment> equipments = equipmentDAO.getAll();
	        List<EquipmentType> type = equipmentTypeDAO.getall();
	        List<EquipmentStatus> status = equipmentStatusDAO.getall();

	        Borrow borrow = borrowDAO.findById(Integer.parseInt(bId));

	        String equipmentId = String.valueOf(borrow.getEquipmentId()); 

	        List<Map<String, Object>> borrowWithUser =
	                borrowDAO.findBorrowWithUserByEquipmentId(equipmentId);

	        request.setAttribute("borrowlistwithUser", borrowWithUser);
	        request.setAttribute("borrowlistwithUserJSON", new Gson().toJson(borrowWithUser));

	        Equipment eq = equipmentDAO.getById(Integer.parseInt(equipmentId));

	        // ===== ของเดิม =====
	        request.setAttribute("userList", userJSON);
	        request.setAttribute("type", new Gson().toJson(type));
	        request.setAttribute("equipments", new Gson().toJson(equipments));
	        request.setAttribute("borrow", new Gson().toJson(borrow));
	        request.setAttribute("status", new Gson().toJson(status));
	        request.getSession().setAttribute("bId", bId);

	        // เผื่อ JSP ใช้
	        request.setAttribute("equipId", equipmentId);
	        request.setAttribute("equipmentbyId", eq);

	        return SUCCESS;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return ERROR;
	    }
	}

	public String eBorrowAdd() {
		try {
			User user = (User) request.getSession().getAttribute("onlineUser");
			
			String borrower = request.getParameter("user");
			if (borrower == null) {
				borrower = request.getParameter("user_hidden");
			}
			String equipment = request.getParameter("equipment");
			String date_from = request.getParameter("date_from");
			String date_to = request.getParameter("date_to");
			String reason = request.getParameter("reason");
			String location = request.getParameter("location");
			String contact = request.getParameter("contact");
			String remark = request.getParameter("remark");
			String status = request.getParameter("status");
			if (status == null) {
				status = request.getParameter("status_hidden");
			}

			Timestamp startDate = DateUtil.dateFormatEdit(date_from);
			Timestamp endDate = DateUtil.dateFormatEdit(date_to);
			Timestamp timestamp = new Timestamp(System.currentTimeMillis());

			Borrow b = new Borrow();

			b.setBorrowAmout(1);
			b.setBorrowId(borrowDAO.getMaxId() + 1);
			b.setContactAddr(contact);
			b.setDateEnd(endDate);
			b.setDateStart(startDate);
			b.setEquipmentId(equipment);
			b.setLocation(location);
			b.setReason(reason);
			b.setRemark(remark);
			b.setStatus(status);
			b.setUserBorrowid(borrower);
			b.setUserCreate(onlineUser.getId());
			b.setTimeCreate(timestamp);
			borrowDAO.save(b);

			if (status.equals("B") || status.equals("W")) {
				Equipment e = equipmentDAO.getById(Integer.parseInt(equipment));
				String statusLogData = e.getStatusLog();
				
				Gson gson = new GsonBuilder().setPrettyPrinting().create();
				List<Map<String, Object>> logList;

				if (statusLogData == null || statusLogData.trim().isEmpty()) {
				    logList = new ArrayList<>();
				} else {
				    Type listType = new TypeToken<List<Map<String, Object>>>(){}.getType();
				    logList = gson.fromJson(statusLogData, listType);
				}

				Map<String, Object> newLog = new HashMap<>();
				newLog.put("status", status);
				Date currentTime = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy", Locale.ENGLISH);
				String currentDate = sdf.format(currentTime);
				newLog.put("timeUpdate", currentDate);
				newLog.put("userUpdate", user.getId());
				newLog.put("statusChange", null);
				
				logList.add(newLog);

				String updatedStatusLog = gson.toJson(logList);
				e.setStatusLog(updatedStatusLog);
				e.setStatus(status);
				equipmentDAO.update(e);
			}

			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}
	
	public String eBorrowUpdate() {
		try {
			User user = (User) request.getSession().getAttribute("onlineUser");
			
			String borrower = request.getParameter("user");
			if (borrower == null) {
				borrower = request.getParameter("user_hidden");
			}
			String equipment = request.getParameter("equipment");
			if(equipment == null) {
				equipment = request.getParameter("equipment_hidden");
			}
			String date_from = request.getParameter("date_from");
			String date_to = request.getParameter("date_to");
			String reason = request.getParameter("reason");
			String location = request.getParameter("location");
			String contact = request.getParameter("contact");
			String remark = request.getParameter("remark");
			String status = request.getParameter("status");
			if (status == null) {
				status = request.getParameter("status_hidden");
			}

			Timestamp startDate = DateUtil.dateFormatEdit(date_from);
			Timestamp endDate = DateUtil.dateFormatEdit(date_to);
			String bId = (String) request.getSession().getAttribute("bId");
			
			Borrow b = borrowDAO.findById(Integer.parseInt(bId));

			b.setContactAddr(contact);
			b.setDateEnd(endDate);
			b.setDateStart(startDate);
			b.setEquipmentId(equipment);
			b.setLocation(location);
			b.setReason(reason);
			b.setRemark(remark);
			b.setStatus(status);
			b.setUserBorrowid(borrower);
			b.setUserUpdate(onlineUser.getId());
			b.setTimeUpdate(timestamp);
			borrowDAO.update(b);
			
			request.getSession().removeAttribute("bId");

			if (status.equals("B") || status.equals("W")) {
				Equipment e = equipmentDAO.getById(Integer.parseInt(equipment));
				String oldStatus = e.getStatus();
				System.out.println("Old status: " + oldStatus + " new Status " + status);
				
				if (!oldStatus.equals(status)) { 
					String statusLogData = e.getStatusLog();
					
					Gson gson = new GsonBuilder().setPrettyPrinting().create();
					List<Map<String, Object>> logList;

					if (statusLogData == null || statusLogData.trim().isEmpty()) {
					    logList = new ArrayList<>();
					} else {
					    Type listType = new TypeToken<List<Map<String, Object>>>(){}.getType();
					    logList = gson.fromJson(statusLogData, listType);
					}

					Map<String, Object> newLog = new HashMap<>();
					if ("R".equals(status)) {
						newLog.put("status", "A");
					} else {
						newLog.put("status", status);
					}
					Date currentTime = new Date();
					SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy", Locale.ENGLISH);
					String currentDate = sdf.format(currentTime);
					newLog.put("timeUpdate", currentDate);
					newLog.put("userUpdate", user.getId());
					newLog.put("statusChange", null);
					
					logList.add(newLog);

					String updatedStatusLog = gson.toJson(logList);
					e.setStatusLog(updatedStatusLog);
				}
				e.setStatus(status);
				equipmentDAO.update(e);
			}
			
			if (status.equals("R") || status.equals("C")) {
				Equipment e = equipmentDAO.getById(Integer.parseInt(equipment));
				String oldStatus = e.getStatus();
				System.out.println("Old status: " + oldStatus + " new Status: " + status);
				
				if (!oldStatus.equals(status)) { 
					String statusLogData = e.getStatusLog();
					
					Gson gson = new GsonBuilder().setPrettyPrinting().create();
					List<Map<String, Object>> logList;

					if (statusLogData == null || statusLogData.trim().isEmpty()) {
					    logList = new ArrayList<>();
					} else {
					    Type listType = new TypeToken<List<Map<String, Object>>>(){}.getType();
					    logList = gson.fromJson(statusLogData, listType);
					}

					Map<String, Object> newLog = new HashMap<>();
					if ("R".equals(status)) {
						newLog.put("status", "A");
					} else {
						newLog.put("status", status);
					}
					//newLog.put("status", status);
					Date currentTime = new Date();
					SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy", Locale.ENGLISH);
					String currentDate = sdf.format(currentTime);
					newLog.put("timeUpdate", currentDate);
					newLog.put("userUpdate", user.getId());
					newLog.put("statusChange", null);
					
					logList.add(newLog);

					String updatedStatusLog = gson.toJson(logList);
					e.setStatusLog(updatedStatusLog);
				}
				e.setStatus("A");
				equipmentDAO.update(e);
			}

			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}
	
	public String eBorrowList() {
		try {
			List<Borrow> borrows = borrowDAO.findAll();
			List<Equipment> equipments = equipmentDAO.getAll();
			List<EquipmentType> type = equipmentTypeDAO.getall(); //append type to sort by type in borrow list
			
			request.setAttribute("borrows", new Gson().toJson(borrows));
			request.setAttribute("equipments", new Gson().toJson(equipments));
			request.setAttribute("type", new Gson().toJson(type));
			return SUCCESS;
		} catch(Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}
	
	public String newEquipBorrowList() {
		try {
			log.debug("Test BorrowList");
			List<Borrow> borrows = borrowDAO.findAll_exceptStatus_A();
			List<Equipment> equipments = equipmentDAO.getAll();
			List<EquipmentType> type = equipmentTypeDAO.getall();
			String userJSON = userDAO.userListJSON();
			log.debug(borrows);
			log.debug(equipments);
			log.debug(type);
			log.debug(userJSON);
			
			request.setAttribute("userList", userJSON);
			request.setAttribute("borrows", new Gson().toJson(borrows));
			request.setAttribute("equipments", new Gson().toJson(equipments));
			request.setAttribute("type", new Gson().toJson(type));
			return SUCCESS;
		} catch(Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}
	
	public String myBorrow() {
		try {
			List<Borrow> borrows = borrowDAO.findBorrowByUser(onlineUser.getId());
			List<Equipment> equipments = equipmentDAO.getAll();
			List<EquipmentType> type = equipmentTypeDAO.getall();
			
			request.setAttribute("borrows", new Gson().toJson(borrows));
			request.setAttribute("equipments", new Gson().toJson(equipments));
			request.setAttribute("type", new Gson().toJson(type));
			return SUCCESS;
		} catch(Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}
	
	public String eBorrowApprove() {
		try {
			List<Borrow> borrows = borrowDAO.findBorrowByStatus("W");
			List<Equipment> equipments = equipmentDAO.getAll();
			
			request.setAttribute("borrows", new Gson().toJson(borrows));
			request.setAttribute("equipments", new Gson().toJson(equipments));
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}
	
	public void getBorrowJSON() {
		try {
			if(onlineUser != null && userAuthority.contains("borrowlist.searchall")) {
				List<Borrow> list = borrowDAO.findAll();
				response.setContentType("application/json");
				PrintWriter out = response.getWriter();
				out.println(new Gson().toJson(list));
				out.flush();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// new
	public void borrowMyNewBorrow() {
		try {
			User user = (User) request.getSession().getAttribute("onlineUser");
			String id = request.getParameter("id");
			Map<String,String> map = new HashMap<String,String>();
			Borrow borrow = borrowDAO.findById(Integer.parseInt(id));
			
			if(borrow.getStatus().equals("W")) 
			{
				borrow.setStatus("B");
				borrow.setUserUpdate(onlineUser.getId());
				borrow.setTimeUpdate(timestamp);
				borrowDAO.update(borrow);
				Equipment equipment = equipmentDAO.getById(Integer.parseInt(borrow.getEquipmentId()));
				if(equipment.getStatus().equals("W")) {
					equipment.setStatus("B");
					equipment.setUserUpdate(onlineUser.getId());
					equipment.setTimeUpdate(timestamp);
					String statusLogData = equipment.getStatusLog();
					
					Gson gson = new GsonBuilder().setPrettyPrinting().create();
					List<Map<String, Object>> logList;

					if (statusLogData == null || statusLogData.trim().isEmpty()) {
					    logList = new ArrayList<>();
					} else {
					    Type listType = new TypeToken<List<Map<String, Object>>>(){}.getType();
					    logList = gson.fromJson(statusLogData, listType);
					}

					Map<String, Object> newLog = new HashMap<>();
					newLog.put("status", "B");
					Date currentTime = new Date();
					SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy", Locale.ENGLISH);
					String currentDate = sdf.format(currentTime);
					newLog.put("timeUpdate", currentDate);
					newLog.put("userUpdate", user.getId());
					newLog.put("statusChange", null);
					
					logList.add(newLog);

					String updatedStatusLog = gson.toJson(logList);
					equipment.setStatusLog(updatedStatusLog);
					
					equipmentDAO.update(equipment);
				}
				map.put("message", "success");
			} else {
				map.put("message", "something wrong");
			}
			
			response.setContentType("application/json");
			PrintWriter out = response.getWriter();
			out.println(new Gson().toJson(map));
			out.flush();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void cancelMyNewBorrow() {
		try {
			User user = (User) request.getSession().getAttribute("onlineUser");
			String id = request.getParameter("id");
			Map<String,String> map = new HashMap<String,String>();
			Borrow borrow = borrowDAO.findById(Integer.parseInt(id));
			
			if(borrow.getStatus().equals("W")) 
			{
				borrow.setStatus("C");
				borrow.setUserUpdate(onlineUser.getId());
				borrow.setTimeUpdate(timestamp);
				borrowDAO.update(borrow);
				Equipment equipment = equipmentDAO.getById(Integer.parseInt(borrow.getEquipmentId()));
				if(equipment.getStatus().equals("W")) {
					equipment.setStatus("A");
					equipment.setUserUpdate(onlineUser.getId());
					equipment.setTimeUpdate(timestamp);
					String statusLogData = equipment.getStatusLog();
					
					Gson gson = new GsonBuilder().setPrettyPrinting().create();
					List<Map<String, Object>> logList;

					if (statusLogData == null || statusLogData.trim().isEmpty()) {
					    logList = new ArrayList<>();
					} else {
					    Type listType = new TypeToken<List<Map<String, Object>>>(){}.getType();
					    logList = gson.fromJson(statusLogData, listType);
					}

					Map<String, Object> newLog = new HashMap<>();
					newLog.put("status", "A");
					Date currentTime = new Date();
					SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy", Locale.ENGLISH);
					String currentDate = sdf.format(currentTime);
					newLog.put("timeUpdate", currentDate);
					newLog.put("userUpdate", user.getId());
					newLog.put("statusChange", null);
					
					logList.add(newLog);

					String updatedStatusLog = gson.toJson(logList);
					equipment.setStatusLog(updatedStatusLog);
					
					equipmentDAO.update(equipment);
				}
				map.put("message", "success");
			} else {
				map.put("message", "something wrong");
			}
			
			response.setContentType("application/json");
			PrintWriter out = response.getWriter();
			out.println(new Gson().toJson(map));
			out.flush();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void returnMyNewBorrow() {
		try {
			User user = (User) request.getSession().getAttribute("onlineUser");
			String id = request.getParameter("id");
			String note = request.getParameter("note");
			Map<String,String> map = new HashMap<String,String>();
			Borrow borrow = borrowDAO.findById(Integer.parseInt(id));
			
			if(borrow.getStatus().equals("B")) 
			{
				borrow.setStatus("R");
				borrow.setUserUpdate(onlineUser.getId());
				borrow.setTimeUpdate(timestamp);
				borrowDAO.update(borrow);
				Equipment equipment = equipmentDAO.getById(Integer.parseInt(borrow.getEquipmentId()));
				if(equipment.getStatus().equals("B")) {
					equipment.setStatus("A");
					equipment.setUserUpdate(onlineUser.getId());
					equipment.setTimeUpdate(timestamp);
					
					String statusLogData = equipment.getStatusLog();
					
					Gson gson = new GsonBuilder().setPrettyPrinting().create();
					List<Map<String, Object>> logList;

					if (statusLogData == null || statusLogData.trim().isEmpty()) {
					    logList = new ArrayList<>();
					} else {
					    Type listType = new TypeToken<List<Map<String, Object>>>(){}.getType();
					    logList = gson.fromJson(statusLogData, listType);
					}

					Map<String, Object> newLog = new HashMap<>();
					newLog.put("status", "A");
					Date currentTime = new Date();
					SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy", Locale.ENGLISH);
					String currentDate = sdf.format(currentTime);
					newLog.put("timeUpdate", currentDate);
					newLog.put("userUpdate", user.getId());
					if (note == null || note.trim().isEmpty()) {
						note = null;
					}
					newLog.put("statusChange", note);
					
					logList.add(newLog);

					String updatedStatusLog = gson.toJson(logList);
					equipment.setStatusLog(updatedStatusLog);
					
					equipmentDAO.update(equipment);
				}
				map.put("message", "success");
			} else {
				map.put("message", "something wrong");
			}
			
			response.setContentType("application/json");
			PrintWriter out = response.getWriter();
			out.println(new Gson().toJson(map));
			out.flush();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void cancleMyBorrow() {
		try {
			User user = (User) request.getSession().getAttribute("onlineUser");
			String id = request.getParameter("id");
			Map<String,String> map = new HashMap<String,String>();
			Borrow borrow = borrowDAO.findById(Integer.parseInt(id));
			
			if( borrow.getUserBorrowid().equals(onlineUser.getId())
					&& borrow.getStatus().equals("W") ) 
			{
				borrow.setStatus("C");
				borrow.setUserUpdate(onlineUser.getId());
				borrow.setTimeUpdate(timestamp);
				borrowDAO.update(borrow);
				Equipment equipment = equipmentDAO.getById(Integer.parseInt(borrow.getEquipmentId()));
				if(equipment.getStatus().equals("W")) {
					equipment.setStatus("A");
					equipment.setUserUpdate(onlineUser.getId());
					equipment.setTimeUpdate(timestamp);
					equipmentDAO.update(equipment);
				}
				map.put("message", "success");
			} else {
				map.put("message", "something wrong");
			}
			
			response.setContentType("application/json");
			PrintWriter out = response.getWriter();
			out.println(new Gson().toJson(map));
			out.flush();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void returnMyBorrow() {
		try {
			String id = request.getParameter("id");
			Map<String,String> map = new HashMap<String,String>();
			Borrow borrow = borrowDAO.findById(Integer.parseInt(id));
			
			if( borrow.getUserBorrowid().equals(onlineUser.getId())
					&& borrow.getStatus().equals("B") ) 
			{
				borrow.setStatus("R");
				borrow.setUserUpdate(onlineUser.getId());
				borrow.setTimeUpdate(timestamp);
				borrowDAO.update(borrow);
				Equipment equipment = equipmentDAO.getById(Integer.parseInt(borrow.getEquipmentId()));
				if(equipment.getStatus().equals("B")) {
					equipment.setStatus("A");
					equipment.setUserUpdate(onlineUser.getId());
					equipment.setTimeUpdate(timestamp);
					equipmentDAO.update(equipment);
				}
				map.put("message", "success");
			} else {
				map.put("message", "something wrong");
			}
			
			response.setContentType("application/json");
			PrintWriter out = response.getWriter();
			out.println(new Gson().toJson(map));
			out.flush();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void approveBorrow() {
		try {
			String bId = request.getParameter("id");
			String remark = request.getParameter("remark");
			Borrow b = borrowDAO.findById(Integer.parseInt(bId));
			Equipment e = equipmentDAO.getById(Integer.parseInt(b.getEquipmentId()));
			Map<String,String> map = new HashMap<String,String>();
			
			if(e.getStatus().equals("A") || e.getStatus().equals("W")) {
				b.setStatus("B");
				b.setRemark(remark);
				b.setUserUpdate(onlineUser.getId());
				b.setTimeUpdate(timestamp);
				borrowDAO.update(b);
				
				String statusLogData = e.getStatusLog();
				
				Gson gson = new GsonBuilder().setPrettyPrinting().create();
				List<Map<String, Object>> logList;

				if (statusLogData == null || statusLogData.trim().isEmpty()) {
				    logList = new ArrayList<>();
				} else {
				    Type listType = new TypeToken<List<Map<String, Object>>>(){}.getType();
				    logList = gson.fromJson(statusLogData, listType);
				}

				Map<String, Object> newLog = new HashMap<>();
				newLog.put("status", "B");
				Date currentTime = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy", Locale.ENGLISH);
				String currentDate = sdf.format(currentTime);
				newLog.put("timeUpdate", currentDate);
				newLog.put("userUpdate", onlineUser.getId());
				newLog.put("statusChange", null);
				
				logList.add(newLog);

				String updatedStatusLog = gson.toJson(logList);
				e.setStatusLog(updatedStatusLog);
				
				e.setStatus("B");
				e.setUserUpdate(onlineUser.getId());
				e.setTimeUpdate(timestamp);
				equipmentDAO.update(e);
				map.put("message", "success");
			} else {
				map.put("message", "Equipment is not available!");
			}
			response.setContentType("application/json");
			PrintWriter out = response.getWriter();
			out.println(new Gson().toJson(map));
			out.flush();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void cancelBorrow() {
		try {
			String bId = request.getParameter("id");
			String remark = request.getParameter("remark");
			Borrow b = borrowDAO.findById(Integer.parseInt(bId));
			Equipment e = equipmentDAO.getById(Integer.parseInt(b.getEquipmentId()));
			Map<String,String> map = new HashMap<String,String>();
			
			b.setStatus("C");
			b.setRemark(remark);
			b.setUserUpdate(onlineUser.getId());
			b.setTimeUpdate(timestamp);
			borrowDAO.update(b);
			
			if(e.getStatus().equals("W")) {
				String statusLogData = e.getStatusLog();
				
				Gson gson = new GsonBuilder().setPrettyPrinting().create();
				List<Map<String, Object>> logList;

				if (statusLogData == null || statusLogData.trim().isEmpty()) {
				    logList = new ArrayList<>();
				} else {
				    Type listType = new TypeToken<List<Map<String, Object>>>(){}.getType();
				    logList = gson.fromJson(statusLogData, listType);
				}

				Map<String, Object> newLog = new HashMap<>();
				newLog.put("status", "A");
				Date currentTime = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy", Locale.ENGLISH);
				String currentDate = sdf.format(currentTime);
				newLog.put("timeUpdate", currentDate);
				newLog.put("userUpdate", onlineUser.getId());
				newLog.put("statusChange", null);
				
				logList.add(newLog);

				String updatedStatusLog = gson.toJson(logList);
				e.setStatusLog(updatedStatusLog);
				
				e.setStatus("A");
				e.setUserUpdate(onlineUser.getId());
				e.setTimeUpdate(timestamp);
				equipmentDAO.update(e);
			}
			
			map.put("message", "success");

			response.setContentType("application/json");
			PrintWriter out = response.getWriter();
			out.println(new Gson().toJson(map));
			out.flush();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}