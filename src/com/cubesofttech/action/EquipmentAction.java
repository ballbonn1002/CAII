package com.cubesofttech.action;

import java.io.File;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.cubesofttech.util.DateUtil;
import com.cubesofttech.util.FileUtil;
import com.cubesofttech.dao.BorrowDAO;
import com.cubesofttech.dao.EquipmentDAO;
import com.cubesofttech.dao.EquipmentStatusDAO;

import com.cubesofttech.dao.FileUploadDAO;
import com.cubesofttech.dao.UserDAO;
import com.cubesofttech.model.Borrow;

import com.cubesofttech.dao.EquipmentTypeDAO;

import com.cubesofttech.model.Equipment;
import com.cubesofttech.model.EquipmentStatus;

import com.cubesofttech.model.FileUpload;

import com.cubesofttech.model.EquipmentType;

import com.cubesofttech.model.User;
import com.cubesofttech.service.FileAttachmentService;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.opensymphony.xwork2.ActionSupport;

public class EquipmentAction extends ActionSupport {
		
	private static final long serialVersionUID = 1L;
	Logger log = Logger.getLogger(getClass());
	HttpServletRequest request = ServletActionContext.getRequest();
	HttpServletResponse response = ServletActionContext.getResponse();

	@Autowired
	private EquipmentDAO equipmentDAO;
	
	@Autowired
	private EquipmentStatusDAO equipmentStatusDAO;
	
	@Autowired
	private FileUploadDAO fileuploadDAO;

	@Autowired
	private FileAttachmentService fileAttachmentService;

	@Autowired
	private BorrowDAO borrowDAO;
	
	@Autowired
	private UserDAO userDAO;
	
	private File image;
	private String imageContentType;
	private String imageFileName;
	
	private String itemNo;
	private String type;
	private String name;
	private String serialNo;
	private int amount;
	private String location;
	private String windows;
	private String process;
	private String ram;
	private String hdd;
	private String battery;
	private String detail;
	private String status;
	private String note;
	private String wifiaddress;
	private String lanaddress;
	private String display;
	private String statusChange;
	private String UPLOAD_PATH = "upload/equipment/";
	private String id; // use for redirect this id to edit page
	
	private String datePurchase;
	
	private User onlineUser = (User) request.getSession().getAttribute("onlineUser");
	
	public String eAdd() {
		try {
			if (onlineUser == null) {
				return "login";
			}
			List<EquipmentStatus> status = equipmentStatusDAO.getall();
			List<EquipmentType> type = equipmentTypeDAO.getall();
			
			// String jsonStatus = new Gson().toJson(status);
			// System.out.println("DEBUG STATUS JSON: " + jsonStatus);
			
			request.setAttribute("type", new Gson().toJson(type));
			request.setAttribute("status", new Gson().toJson(status));
			return SUCCESS;
		} catch(Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}
	
	public String eEdit() {
		try {
			if (onlineUser == null) {
				return "login";
			}
			int id = Integer.parseInt(request.getParameter("id"));
			Equipment e = equipmentDAO.getById(id);
			Map<String, Object> userCreate = equipmentDAO.getUserCreateByEquipmentId(id);
			
			List<EquipmentStatus> status = equipmentStatusDAO.getall();
			List<EquipmentType> type = equipmentTypeDAO.getall();
			List<Borrow> borrow = borrowDAO.findBorrowByEquipmentId(request.getParameter("id"));
			
			// get borrow detail with user id, TH name, EN name
			List<Map<String, Object>> borrowWithUser = borrowDAO.findBorrowWithUserByEquipmentId2(request.getParameter("id"));
			
			// get statusLog -> transfer statusLog to List<Map<String, String>>
			List<Map<String, String>> statusLogList = new ArrayList<>();
			try {
			    statusLogList = new Gson().fromJson(e.getStatusLog(), new TypeToken<List<Map<String, String>>>() {}.getType());
			} catch (Exception ex) {
			    ex.printStackTrace();
			}
			
			if (statusLogList == null) {
			    statusLogList = new ArrayList<>();
			}
			
			Collections.reverse(statusLogList); // Reverse the status log to show the latest logs first
			request.setAttribute("statusLogList", statusLogList);
			User ur = (User) request.getSession().getAttribute("onlineUser");
	        boolean hasSignature = false;

	        if (ur != null) {
	            User u = userDAO.findById(ur.getId()); 
	            if (u != null) {
	                String sig = u.getPathSignature();
	                
	                hasSignature = sig != null && !sig.trim().isEmpty() && !"null".equalsIgnoreCase(sig.trim());
	            }
	        }

	        request.setAttribute("hasSignature", hasSignature);
			
			request.setAttribute("borrowlistwithUser", borrowWithUser);
//			log.debug("borrowlistwithUser : " +borrowWithUser);
			request.setAttribute("borrowlistwithUserJSON", new Gson().toJson(borrowWithUser));
			
			request.getSession().setAttribute("id_s", id);
			request.setAttribute("equipment", new Gson().toJson(e));
			request.setAttribute("equipmentbyId", e);
			request.setAttribute("status", new Gson().toJson(status));
			request.setAttribute("type", new Gson().toJson(type));
			//edit on 22/04/20 add -> request.setAttribute("borrowlist", borrow);
			request.setAttribute("borrowlist", borrow);
			request.setAttribute("borrowlistJSON", new Gson().toJson(borrow));
			request.setAttribute("userCreate", userCreate);
			
//			boolean legacyBorrow = false;
//			if (borrow != null && !borrow.isEmpty()) {
//			    legacyBorrow = isLegacyBorrow(borrow.get(0));
//			}
//
//			request.setAttribute("isLegacyBorrow", legacyBorrow);
			
			
			return SUCCESS;
		} catch(Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}
	
	public String newE() {
		try {					
			User user = (User) request.getSession().getAttribute("onlineUser");
			if (user == null) {
				return "login";
			}
			Equipment existingEq = equipmentDAO.findByItemNo(itemNo);
	        if (existingEq != null) {
	            request.setAttribute("errMsg", "Duplicate Item No: " + itemNo);
	            return ERROR;
	        }
			Timestamp timestamp = new Timestamp(System.currentTimeMillis());
			
			Equipment e = new Equipment();
			int nextEqId = equipmentDAO.getMaxId() + 1;
			
			if(image != null) {
				List<FileUpload> savedFiles = fileAttachmentService.attach(
					Arrays.asList(image),
					Arrays.asList(imageFileName),
					"equipment",
					String.valueOf(nextEqId),
					user.getId(),
					request.getServletContext().getRealPath("/")
				);
				if (savedFiles != null && !savedFiles.isEmpty()) {
					e.setImage(savedFiles.get(0).getPath());
				}
			}

			e.setAmount(amount);
			e.setBattery(battery);
			e.setDetail(detail);
			e.setEquipmentId(nextEqId);
			e.setHdd(hdd);
			e.setItemNo(itemNo);
			e.setLocation(location);
			e.setName(name);
			e.setNote(note);
			e.setProcess(process);
			e.setRam(ram);
			e.setSerialNo(serialNo);
			e.setStatus(status);
			// e.setTimeCreate(timestamp);
			if (datePurchase != null && !datePurchase.trim().isEmpty()) {
	            try {
	                SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy", Locale.ENGLISH);
	                Date parsedDate = sdf.parse(datePurchase);    
	                e.setTimeCreate(new Timestamp(parsedDate.getTime()));
	                
	            } catch (Exception ex) {
	                e.setTimeCreate(timestamp);
	            }
	        } else {
	            // ถ้าไม่เลือกวันที่ ให้ใช้วันปัจจุบัน
	            e.setTimeCreate(timestamp);
	        }
			e.setType(type);
			e.setUserCreate(user.getId());
			e.setUserUpdate(user.getId());
			e.setTimeUpdate(DateUtil.getCurrentTime());
			e.setWindows(windows);
			e.setWifiaddress(wifiaddress);
			e.setLanaddress(lanaddress);
			e.setDisplay(display);
			
			// New Status log
			List<Map<String, Object>> logList = new ArrayList<>();

			Map<String, Object> newLog = new HashMap<>();
			newLog.put("status", status);
			Date currentTime = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy", Locale.ENGLISH);
			String currentDate = sdf.format(currentTime);
			newLog.put("timeUpdate", currentDate);
			newLog.put("userUpdate", user.getId());
			if (statusChange == null || statusChange.trim().isEmpty()) {
				statusChange = null;
			}
			newLog.put("statusChange", statusChange);

			logList.add(newLog);

			Gson gson = new GsonBuilder().setPrettyPrinting().create();
			String updatedStatusLog = gson.toJson(logList);

			e.setStatusLog(updatedStatusLog);
			
			equipmentDAO.save(e);
				
			return SUCCESS;
		} catch(Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}
	
	public String updateE() {
		try {
			User user = (User) request.getSession().getAttribute("onlineUser");
	        if (user == null) {
	            return "login";
	        }
			int id_s = (int) request.getSession().getAttribute("id_s");
			Timestamp timestamp = new Timestamp(System.currentTimeMillis());
			
			Equipment e = equipmentDAO.getById(id_s);
			Timestamp oldTimeCreate = e.getTimeCreate();
			String oldStatus = e.getStatus();
			
			if(image != null) {
				List<FileUpload> savedFiles = fileAttachmentService.attach(
					Arrays.asList(image),
					Arrays.asList(imageFileName),
					"equipment",
					String.valueOf(e.getEquipmentId()),
					user.getId(),
					request.getServletContext().getRealPath("/")
				);
				if (savedFiles != null && !savedFiles.isEmpty()) {
					e.setImage(savedFiles.get(0).getPath());
				}
			}

			e.setAmount(amount);
			e.setBattery(battery);
			e.setDetail(detail);
			e.setHdd(hdd);
			e.setItemNo(itemNo);
			e.setLocation(location);
			e.setName(name);
			e.setNote(note);
			e.setProcess(process);
			e.setRam(ram);
			e.setSerialNo(serialNo);
			e.setStatus(status);
			if (datePurchase != null && !datePurchase.trim().isEmpty()) {
	            try {
	                SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy", Locale.ENGLISH);
	                Date parsedDate = sdf.parse(datePurchase);      
	                Timestamp newTimestamp = new Timestamp(parsedDate.getTime());
	               
	                SimpleDateFormat compareSdf = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
	                String newDateStr = compareSdf.format(newTimestamp);
	                String oldDateStr = (oldTimeCreate != null) ? compareSdf.format(oldTimeCreate) : "";

	                if (newDateStr.equals(oldDateStr)) {
	                    e.setTimeCreate(oldTimeCreate);
	                } else {
	                    e.setTimeCreate(newTimestamp);
	                }

	            } catch (Exception ex) {
	                e.setTimeCreate(oldTimeCreate);
	            }
	        } else {
	            e.setTimeCreate(oldTimeCreate);
	        }
			e.setType(type);
			e.setWifiaddress(wifiaddress);
			e.setLanaddress(lanaddress);
			e.setUserCreate(user.getId());
			e.setWindows(windows);
			e.setDisplay(display);
			
			// status log
			// System.out.println("Old status: " + oldStatus + " new Status : " + status);
			
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
			    newLog.put("userUpdate", user.getId()); 
			    newLog.put("status", status);     
			    
			    if (statusChange == null || statusChange.trim().isEmpty()) {
			        newLog.put("statusChange", null); 
			    } else {
			        newLog.put("statusChange", statusChange); 
			    }

			    Date currentTime = new Date();
			    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.ENGLISH);
			    String currentDate = sdf.format(currentTime);
			    newLog.put("timeUpdate", currentDate); 
			    
			    logList.add(newLog);

			    String updatedStatusLog = gson.toJson(logList);
			    e.setStatusLog(updatedStatusLog);
				
				// if change new status -> "B" or "W" create new history
				if (("B".equals(status) || "W".equals(status)) && (!"B".equals(oldStatus) && !"W".equals(oldStatus))) {
					Borrow b = new Borrow();
					
					b.setEquipmentId(String.valueOf(id_s));
					b.setBorrowId(borrowDAO.getMaxId() + 1);
					b.setStatus(status);
					b.setUserUpdate(user.getId());
					b.setUserBorrowid(user.getId());
					b.setDateStart(timestamp); // use time create
					b.setDateEnd(null);
					b.setLocation(null);
					b.setTimeCreate(timestamp);
					b.setTimeUpdate(timestamp);
					b.setBorrowAmout(1);
					b.setReason(statusChange);
					
					borrowDAO.save(b);
					
				} else if ("W".equals(oldStatus) && "B".equals(status)) {
					// W -> B => update old borrow history
					String borrowS = borrowDAO.findlatestborrowbyequipmentid(id_s);

		  			// log.debug("********"+borrowS);
					Borrow borrow = borrowDAO.findById(Integer.parseInt(borrowS));
					borrow.setStatus("B");
					
					borrowDAO.save(borrow);
				} // else if ("B".equals(oldStatus) && "W".equals(status)) {}
			}

			equipmentDAO.update(e);
			
			// set id สำหรับ redirect ไปหน้า edit
			id = String.valueOf(e.getEquipmentId());
			
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}
		
	public String deleteE() {
		try {
			if (onlineUser == null) { 
	            return "login"; 
	        }
			String id = request.getParameter("id");
			
			Equipment e = equipmentDAO.findByEquipmentId(Integer.parseInt(id));
			equipmentDAO.delete(e);
			
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}
	

	@Autowired
	private EquipmentTypeDAO equipmentTypeDAO;
	

	public String statusList() {
		try {
			if (onlineUser == null) { 
	            return "login"; 
	        }
			List<EquipmentStatus> list = equipmentStatusDAO.getall();
			request.setAttribute("list", new Gson().toJson(list));
			List<EquipmentType> listT = equipmentTypeDAO.getall();
			request.setAttribute("tlist", new Gson().toJson(listT));
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}
		
	public String statusSave() {
		try {
			if (onlineUser == null) { 
	            return "login"; 
	        }
			String status = request.getParameter("status");
			String color = request.getParameter("color");
			String color2 = request.getParameter("color2"); 
			String description = request.getParameter("description");
			User user = (User) request.getSession().getAttribute("onlineUser");
			Timestamp timestamp = new Timestamp(System.currentTimeMillis());
			
			EquipmentStatus eStatus = new EquipmentStatus();
			if (color2 != null && !color2.trim().isEmpty()) {
			    eStatus.setColor2(color2);
			} else {
			    eStatus.setColor(color);
			};
			eStatus.setDescription(description);
			eStatus.setStatusId(status);
			eStatus.setTimeCreate(timestamp);
			eStatus.setUserCreate(user.getId());
			equipmentStatusDAO.save(eStatus);
			
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}
	
	public String statusUpdate() {
		try {
			if (onlineUser == null) { 
	            return "login"; 
	        }
			String status = request.getParameter("status");
			String color = request.getParameter("color");
			String color2 = request.getParameter("color2"); 
			String description = request.getParameter("description");
			User user = (User) request.getSession().getAttribute("onlineUser");
			Timestamp timestamp = new Timestamp(System.currentTimeMillis());
			
			EquipmentStatus eStatus = equipmentStatusDAO.findByStatus(status);
			if(eStatus == null) {
				eStatus = new EquipmentStatus();
				if (color2 != null && !color2.trim().isEmpty()) {
				    eStatus.setColor2(color2);
				} else {
				    eStatus.setColor(color);
				}
				eStatus.setDescription(description);
				eStatus.setStatusId(status);
				eStatus.setTimeCreate(timestamp);
				eStatus.setUserCreate(user.getId());
				equipmentStatusDAO.save(eStatus);
			} else {
				if (color2 != null && !color2.trim().isEmpty()) {
			        eStatus.setColor2(color2);
			    } else {
			        eStatus.setColor(color);
			    }
				eStatus.setDescription(description);
				eStatus.setUserUpdate(user.getId());
				eStatus.setTimeUpdate(timestamp);
				equipmentStatusDAO.update(eStatus);
			}
	
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}
	
	public String statusDelete() {
		try {
			if (onlineUser == null) { 
	            return "login"; 
	        }
			String id = request.getParameter("id");
			
			EquipmentStatus eStatus = equipmentStatusDAO.findByStatus(id);
			equipmentStatusDAO.delete(eStatus);
			
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	public String statusEdit() {
		try {
			if (onlineUser == null) { 
	            return "login"; 
	        }
			String id = request.getParameter("id");
			
			EquipmentStatus eStatus = equipmentStatusDAO.findByStatus(id);
			
			request.setAttribute("info", new Gson().toJson(eStatus));
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}
	
	public String statusAdd() {
		if (onlineUser == null) { 
            return "login"; 
        }
        return SUCCESS;
    }

	
	public String table() {
		String selType = request.getParameter("type");
		String selStatus = request.getParameter("status");
		try {
			if (onlineUser == null) { 
	            return "login"; 
	        }
			List<EquipmentStatus> status = equipmentStatusDAO.getall();
			List<EquipmentType> type = equipmentTypeDAO.getall();
			List<Borrow> borrows = borrowDAO.findAll();
			List<Equipment> equipments = equipmentDAO.getAll();
			
			List<Equipment> equipmentall = equipmentDAO.getAll();
			String userJSON = userDAO.userListJSON();
			
			User ur = (User) request.getSession().getAttribute("onlineUser");
	        boolean hasSignature = false;

	        if (ur != null) {
	            User u = userDAO.findById(ur.getId()); 
	            
	            log.debug("User ID from Session: " + ur.getId());
	            log.debug("User found in DB: " + (u != null));
	            
	            if (u != null) {
	                String sig = u.getPathSignature();
	                log.debug("PathSignature from DB: [" + sig + "]");
	                
	                hasSignature = sig != null && !sig.trim().isEmpty() && !"null".equalsIgnoreCase(sig.trim());
	            }
	        }

	        request.setAttribute("hasSignature", hasSignature);
			
			request.setAttribute("userList", userJSON);
			
			request.setAttribute("borrows", new Gson().toJson(borrows));
			request.setAttribute("equipments", new Gson().toJson(equipments));
			request.setAttribute("selStatus", selStatus);
			request.setAttribute("selType", selType);
			request.setAttribute("status", new Gson().toJson(status));
			request.setAttribute("type", new Gson().toJson(type));
			
			request.setAttribute("equipmentall", equipmentall);
			
			return SUCCESS;
		} catch(Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}
	
	public String getBorrowById() {
		try {
			// get borrow detail with user id, TH name, EN name
			List<Map<String, Object>> borrowWithUser = borrowDAO.findBorrowWithUserByEquipmentId(request.getParameter("id"));

			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			
			// Check null value 
			String json;
			if (borrowWithUser == null || borrowWithUser.isEmpty()) {
				json = "[]"; // if null return blank array
			} else {
				json = new Gson().toJson(borrowWithUser);
			}
			
		    response.getWriter().write(json);

			return null; // Because AJAX don't need to forward to JSP page
		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			return null;
		}
	}
	
	public String returnEquipment() {
	    try {
	    	User user = (User) request.getSession().getAttribute("onlineUser");
	    	if (user == null) {
	            response.setCharacterEncoding("UTF-8");
	            response.getWriter().write("login");
	            return null;
	        }
	        int equipmentId = Integer.parseInt(request.getParameter("equipmentId"));
	        int borrowId = Integer.parseInt(request.getParameter("borrowId"));
	        String note = request.getParameter("note");

	        Equipment equipment = equipmentDAO.getById(equipmentId);
	        Borrow borrow = borrowDAO.findById(borrowId);

	        if (equipment == null || borrow == null) {
	            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
	            return null;
	        }
	        
	        // save status log
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
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.ENGLISH);
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

	        // update equipment status
	        equipment.setStatus("A");
	        //equipment.setStatusLog(note);
	        equipmentDAO.update(equipment);
	        Timestamp timestamp = new Timestamp(System.currentTimeMillis());
	        // Check date end if null use current time
	        if (borrow.getDateEnd() == null) {
	            // convert String into Date (time will be 00:00:00)
	            Date parsedDate = sdf.parse(currentDate);

	            borrow.setDateEnd(timestamp);
	        }

	        // update borrow status
//	        Borrow borrowById = borrowDAO.findById(borrowId);
//	        if(borrowById.getUser_return() == null || borrowById.getUser_return().trim().isEmpty()) {
//	        	borrowById.setUser_return(borrowById.getUserBorrowid());
//	        	borrowById.setTime_return(timestamp);
//			}
	        
	        borrow.setStatus("R");
	        borrow.setUser_return_receive(onlineUser.getId());
	        borrow.setTime_return_receive(timestamp);
	        borrow.setUserUpdate(onlineUser.getId());
	        borrow.setTimeUpdate(timestamp);
	        borrowDAO.update(borrow);

	        response.setStatus(HttpServletResponse.SC_OK);
	        response.getWriter().write("success");
	        return null;

	    } catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	
	public String EquipmentPieChart() {
		try {
			if (onlineUser == null) {
				return "login";
			}
			List<Equipment> list = equipmentDAO.getAll();
			List<EquipmentStatus> status = equipmentStatusDAO.getall();
			List<EquipmentType> type = equipmentTypeDAO.getall();
			
			request.setAttribute("info", new Gson().toJson(list));
			request.setAttribute("status", new Gson().toJson(status));
			request.setAttribute("type", new Gson().toJson(type));
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getStatusChange() {
		return statusChange;
	}

	public void setStatusChange(String statusChange) {
		this.statusChange = statusChange;
	}

	public String getDisplay() {
		return display;
	}

	public void setDisplay(String display) {
		this.display = display;
	}

	public String getWifiaddress() {
		return wifiaddress;
	}

	public void setWifiaddress(String wifiaddress) {
		this.wifiaddress = wifiaddress;
	}

	public String getLanaddress() {
		return lanaddress;
	}

	public void setLanaddress(String lanaddress) {
		this.lanaddress = lanaddress;
	}

	public File getImage() {
		return image;
	}

	public void setImage(File image) {
		this.image = image;
	}

	public String getImageContentType() {
		return imageContentType;
	}

	public void setImageContentType(String imageContentType) {
		this.imageContentType = imageContentType;
	}

	public String getImageFileName() {
		return imageFileName;
	}

	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}

	public String getItemNo() {
		return itemNo;
	}

	public void setItemNo(String itemNo) {
		this.itemNo = itemNo;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSerialNo() {
		return serialNo;
	}

	public void setSerialNo(String serialNo) {
		this.serialNo = serialNo;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getWindows() {
		return windows;
	}

	public void setWindows(String windows) {
		this.windows = windows;
	}

	public String getProcess() {
		return process;
	}

	public void setProcess(String process) {
		this.process = process;
	}

	public String getRam() {
		return ram;
	}

	public void setRam(String ram) {
		this.ram = ram;
	}

	public String getHdd() {
		return hdd;
	}

	public void setHdd(String hdd) {
		this.hdd = hdd;
	}

	public String getBattery() {
		return battery;
	}

	public void setBattery(String battery) {
		this.battery = battery;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}
	
	
	//Equipment Type
	public String typelist() {
		try {
			if (onlineUser == null) {
				return "login";
			}
			List<EquipmentType> list = equipmentTypeDAO.getall();
			request.setAttribute("tlist", new Gson().toJson(list));
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}
	
	public void TypeRecord() {
		try {
			String Type = request.getParameter("Type");
			List<Equipment> list = equipmentDAO.findByTypes(Type);
			Map<String, String> map = new HashMap<String, String>();

			if(list.size()==0) {
				map.put("message", "ok");
			} else {
				map.put("message", "can't");
				map.put("count", Integer.toString(list.size()));
			}
			
			response.setContentType("application/json");
			PrintWriter out = response.getWriter();
			out.println(new Gson().toJson(map));
			out.flush();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public String typeSave() {
		try {
			if (onlineUser == null) { 
	            return "login"; 
	        }
			String Type = request.getParameter("Type");
			String description = request.getParameter("description");
			User user = (User) request.getSession().getAttribute("onlineUser");
			String typeText = request.getParameter("type_text");
			Timestamp timestamp = new Timestamp(System.currentTimeMillis());
			
			EquipmentType typeS = new EquipmentType();
			typeS.setDescription(description);
			typeS.setTypeID(Type);
			typeS.setTimeCreate(timestamp);
			typeS.setUserCreate(user.getId());
			typeS.setTypeText(typeText);
			equipmentTypeDAO.save(typeS);

			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}
	
	public String typeUpdate() {
		try {
			if (onlineUser == null) { 
	            return "login"; 
	        }
			String Type = request.getParameter("Type");
			String description = request.getParameter("description");
			User user = (User) request.getSession().getAttribute("onlineUser");
			String typeText = request.getParameter("type_text");
			Timestamp timestamp = new Timestamp(System.currentTimeMillis());
			
			EquipmentType TypeU = equipmentTypeDAO.findByType(Type);
			if(TypeU == null) {
				TypeU = new EquipmentType();
				TypeU.setDescription(description);
				TypeU.setTypeID(Type);
				TypeU.setTimeCreate(timestamp);
				TypeU.setUserCreate(user.getId());
				TypeU.setTypeText(typeText);
				equipmentTypeDAO.save(TypeU);
			} else {
				TypeU.setDescription(description);
				TypeU.setUserUpdate(user.getId());
				TypeU.setTimeUpdate(timestamp);
				TypeU.setTypeText(typeText);
				equipmentTypeDAO.update(TypeU);
			}
	
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}
	
	public String typeAdd() {
		if (onlineUser == null) { 
			return "login"; 
		}
        return SUCCESS;
    }
	
	public String typeDelete() {
		try {
			if (onlineUser == null) { 
	            return "login"; 
	        }
			String id = request.getParameter("id");
			EquipmentType TypeD = equipmentTypeDAO.findByType(id);
			equipmentTypeDAO.delete(TypeD);
			
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	public String typeEdit() {
		try {
			if (onlineUser == null) { 
	            return "login"; 
	        }
			String id = request.getParameter("id");
			EquipmentType TypeE = equipmentTypeDAO.findByType(id);
			request.setAttribute("info", new Gson().toJson(TypeE));
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}
	public String typeEdit2() {
		try {
			if (onlineUser == null) { 
	            return "login"; 
	        }
			String id = request.getParameter("Type");
			EquipmentType TypeE = equipmentTypeDAO.findByType(id);
			request.setAttribute("save", new Gson().toJson(TypeE));
			
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}
	
	//JSON API
	public void getEquipmentJSON() {
		try {
			if(onlineUser != null) {
				List<Equipment> list = equipmentDAO.getAll();
				response.setContentType("application/json");
				PrintWriter out = response.getWriter();
				out.println(new Gson().toJson(list));
				out.flush();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void getEquipmentStatusJSON() {
		try {
			List<EquipmentStatus> list = equipmentStatusDAO.getall();
			response.setContentType("application/json");
			PrintWriter out = response.getWriter();
			out.println(new Gson().toJson(list));
			out.flush();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void getEquipmentTypeJSON() {
		try {
			List<EquipmentType> list = equipmentTypeDAO.getall();
			response.setContentType("application/json");
			PrintWriter out = response.getWriter();
			out.println(new Gson().toJson(list));
			out.flush();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void updateStatusColor() {
		try {
			if (onlineUser == null) { 
				return; 
			}
			String id = request.getParameter("id");
			String color = request.getParameter("color");
			String color2 = request.getParameter("color2"); 
			User user = (User) request.getSession().getAttribute("onlineUser");
			Timestamp timestamp = new Timestamp(System.currentTimeMillis());
			
			EquipmentStatus eStatus = equipmentStatusDAO.findByStatus(id);
			if (color2 != null && !color2.trim().isEmpty()) {
			    eStatus.setColor2(color2);
			} else {
			    eStatus.setColor(color);
			}
			eStatus.setUserUpdate(user.getId());
			eStatus.setTimeUpdate(timestamp);
			equipmentStatusDAO.update(eStatus);
			
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			out.println("success");
			out.flush();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void eCheckItemNo() {
		try {
			String itemNo = request.getParameter("itemNo");
			Map<String, String> map = new HashMap<String, String>();
			Equipment e = equipmentDAO.findByItemNo(itemNo);
			
			if(e == null) {
				map.put("message","available");
			} else {
				map.put("message", "used");
				map.put("name", e.getName());
			}
			
			response.setContentType("application/json");
			PrintWriter out = response.getWriter();
			out.println(new Gson().toJson(map));
			out.flush();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void eCheckBorrow() {
		try {
			String eId = request.getParameter("eId");
			List<Borrow> borrows = borrowDAO.findBorrowByEquipmentIdAndStatus(eId, "B");
			
			response.setContentType("application/json");
			PrintWriter out = response.getWriter();
			out.println(new Gson().toJson(borrows));
			out.flush();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void eCheckAllBorrow() {
		try {
			String eId = request.getParameter("eId");
			List<Borrow> borrows = borrowDAO.findBorrowByEquipmentId(eId);
			
			response.setContentType("application/json");
			PrintWriter out = response.getWriter();
			out.println(new Gson().toJson(borrows));
			out.flush();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void checkEStatusRecord() {
		try {
			String status = request.getParameter("status");
			List<Equipment> list = equipmentDAO.findByStatus(status);
			Map<String, String> map = new HashMap<String, String>();

			if(list.size()==0) {
				map.put("message", "ok");
			} else {
				map.put("message", "can't");
				map.put("count", Integer.toString(list.size()));
			}
			
			response.setContentType("application/json");
			PrintWriter out = response.getWriter();
			out.println(new Gson().toJson(map));
			out.flush();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public String changeEquipStatusAndBorrowStatus() {
		try {
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			if (onlineUser == null) {
				return "login";
			}
			String id_s = request.getParameter("equip_id");
			String eStatus = request.getParameter("equip_status");
			int id = Integer.parseInt(id_s);

			String user = request.getParameter("user");

			Equipment equipment = equipmentDAO.findByEquipmentId(id);
			
			equipment.setStatus(eStatus);
			
			log.debug("eStatus"+equipment.getStatus());
			if(equipment.getStatus().equals("A")) {
				String borrowS = borrowDAO.findlatestborrowbyequipmentid(id);

	  			// log.debug("********"+borrowS);
				Borrow borrow = borrowDAO.findById(Integer.parseInt(borrowS));
				borrow.setStatus("R");
				borrowDAO.save(borrow);
				// log.debug("In if where eStatus = "+equipment.getStatus());
				// log.debug("borrow_getStatus = " + borrow.getStatus());
			}
			
			
			equipmentDAO.save(equipment);
			
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}
	
    public void checkStatusDuplicate() {
        try {
            String statusId = request.getParameter("statusId");
            EquipmentStatus status = equipmentStatusDAO.findByStatus(statusId);
            
            Map<String, String> map = new HashMap<String, String>();

            if (status != null) {
                map.put("status", "duplicate");
            } else {
                map.put("status", "available");
            }

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(new Gson().toJson(map));
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
	
	public void checkTypeDuplicate() {
        try {
            String typeId = request.getParameter("typeId");
            EquipmentType type = equipmentTypeDAO.findByType(typeId);
            
            Map<String, String> map = new HashMap<String, String>();

            if (type != null) {
                map.put("status", "duplicate");
            } else {
                map.put("status", "available");
            }

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(new Gson().toJson(map));
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
	
	// Getter/Setter
	public String getDatePurchase() {
		   return datePurchase;
	}
	public void setDatePurchase(String datePurchase) {
		    this.datePurchase = datePurchase;
	}
	
	//END JSON API
	//เช็คข้อมูล borrow เดิม ก่อนเพิ่ม process
//	private boolean isLegacyBorrow(Borrow borrow) {
//	    if (borrow == null) {
//	        return false;
//	    }
//
//	    Timestamp migrationDate = Timestamp.valueOf("2026-05-22 00:00:00");
//
//	    boolean isOldData =
//	            borrow.getTimeCreate() != null &&
//	            borrow.getTimeCreate().before(migrationDate);
//
//	    boolean allNewFieldsNull =
//	            borrow.getUser_delivery() == null &&
//	            borrow.getUser_receive() == null;
//
//	    return isOldData && allNewFieldsNull;
//	}
	
}
