package com.cubesofttech.action;

import java.io.File;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
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
import org.jfree.util.Log;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;

import com.cubesofttech.dao.EquipmentRequestMrDAO;
import com.cubesofttech.dao.ExpTravelTypeDAO;
import com.cubesofttech.dao.ExpenseDAO;
import com.cubesofttech.dao.ExpenseDetailDAO;
import com.cubesofttech.dao.ExpenseGroupDAO;
import com.cubesofttech.dao.FileUploadDAO;
import com.cubesofttech.dao.ProductDAO;
import com.cubesofttech.dao.UserDAO;
import com.cubesofttech.model.EquipmentRequestMr;
import com.cubesofttech.model.DocStatus;
import com.cubesofttech.model.ExpTravelType;
import com.cubesofttech.model.Expense;
import com.cubesofttech.model.ExpenseDetail;
import com.cubesofttech.model.ExpenseGroup;
import com.cubesofttech.model.FileUpload;
import com.cubesofttech.model.User;
import com.cubesofttech.model.Product;
import com.cubesofttech.util.DateUtil;
import com.cubesofttech.util.FileUtil;
import com.google.gson.Gson;
import com.ibm.icu.util.Calendar;
import com.opensymphony.xwork2.ActionSupport;

import org.json.JSONArray;
import org.json.JSONObject;

public class EquipmentRequestAction extends ActionSupport {
	  
	  @Autowired
	   private EquipmentRequestMrDAO equipmentRequestMrDAO;
	  
	  @Autowired
		private FileUploadDAO fileuploadDAO;
	  
		@Autowired
		private UserDAO userDAO;
		
		@Autowired
		private ExpenseDAO expenseDAO;
		
		@Autowired
		private ExpenseGroupDAO expenseGroupDAO;
		
		@Autowired
		private ExpenseDetailDAO expenseDetailDAO;
		
		@Autowired
		private ExpTravelTypeDAO expTravelTypeDAO;

		@Autowired
		private ProductDAO productDAO;
		
		
	  	
	  Logger log = Logger.getLogger(getClass());
	    
	  private long selectedCatalogId;
	  private String mr_id;
	  private String catalog_items_id;
	  private String items_type;
	  private double amount;
	  private String description;
	  private String request_user;
	  private String item_sub_id;
	  private String status;
	  private String url_ref;
	  private String action;
	  private String request_date;
	  
	  private java.io.File[] files;
	  private String[] filesFileName;
	  private String[] filesContentType;
	  private String filesUploadFileName;
	  private String fileUploadId;
	  
	  
		  private File fileUpload;
		  private String fileUploadFileName;
		  private List<String> fileUploadContentType;
		private String fileUploadSize;
		private FileUpload file;
		private FileUpload filenoteimg;
		private String sortOrder;
	  
	  public String getSortOrder() {
			return sortOrder;
		}

		public void setSortOrder(String sortOrder) {
			this.sortOrder = sortOrder;
		}

	  public FileUploadDAO getFileuploadDAO() {
			return fileuploadDAO;
		}

		public void setFileuploadDAO(FileUploadDAO fileuploadDAO) {
			this.fileuploadDAO = fileuploadDAO;
		}

		public String getFileUploadFileName() {
			return fileUploadFileName;
		}

		public void setFileUploadFileName(String fileUploadFileName) {
			this.fileUploadFileName = fileUploadFileName;
		}

		public List<String> getFileUploadContentType() {
			return fileUploadContentType;
		}

		public void setFileUploadContentType(List<String> fileUploadContentType) {
			this.fileUploadContentType = fileUploadContentType;
		}

		public String getFileUploadSize() {
			return fileUploadSize;
		}

		public void setFileUploadSize(String fileUploadSize) {
			this.fileUploadSize = fileUploadSize;
		}

		public FileUpload getFilenoteimg() {
			return filenoteimg;
		}

		public void setFilenoteimg(FileUpload filenoteimg) {
			this.filenoteimg = filenoteimg;
		}

	  public File getFileUpload() {
		return fileUpload;
	}

	  public void setFileUpload(File fileUpload) {
		  this.fileUpload = fileUpload;
	  }

	  private List<User> userList;
	  private List<Product> Product; 
	  private List<Object[]> catalogList; 
	  private List<DocStatus> StatusList;  
	  private List<FileUpload> fileUploadlist;
	  
	  
	  public List<FileUpload> getFileUploadlist() {
		return fileUploadlist;
	}

	  public void setFileUploadlist(List<FileUpload> fileUploadlist) {
		  this.fileUploadlist = fileUploadlist;
	  }

	  public String getRequest_date() {
		return request_date;
	}

	  public void setRequest_date(String request_date) {
		  this.request_date = request_date;
	  }

	  public String getAction() {
		return action;
	}

	  public void setAction(String action) {
		  this.action = action;
	  }

	  public java.io.File[] getFiles() {
			return files;
		}

		public void setFiles(java.io.File[] files) {
			this.files = files;
		}

		public String[] getFilesFileName() {
			return filesFileName;
		}

		public void setFilesFileName(String[] filesFileName) {
			this.filesFileName = filesFileName;
		}

		public String[] getFilesContentType() {
			return filesContentType;
		}

		public void setFilesContentType(String[] filesContentType) {
			this.filesContentType = filesContentType;
		}

		public String getFilesUploadFileName() {
			return filesUploadFileName;
		}

		public void setFilesUploadFileName(String filesUploadFileName) {
			this.filesUploadFileName = filesUploadFileName;
		}

		public String getFileUploadId() {
			return fileUploadId;
		}

		public void setFileUploadId(String fileUploadId) {
			this.fileUploadId = fileUploadId;
		}

	  public String getUrl_ref() {
		return url_ref;
	}

	  public void setUrl_ref(String url_ref) {
		  this.url_ref = url_ref;
	  }

	  public String getStatus() {
		return status;
	}

	  public void setStatus(String status) {
		  this.status = status;
	  }
	  
	  public String getItems_type() {
		return items_type;
	}

	  public void setItems_type(String items_type) {
		  this.items_type = items_type;
	  }

	  public String getItem_sub_id() {
		  return item_sub_id;
	  }

	  public void setItem_sub_id(String item_sub_id) {
		  this.item_sub_id = item_sub_id;
	  }

	  public String getRequest_user() {
		return request_user;
	}

	  public void setRequest_user(String request_user) {
		  this.request_user = request_user;
	  }

	  public String getMr_id() {
		return mr_id;
	}

	  public void setMr_id(String mr_id) {
		  this.mr_id = mr_id;
	  }
	  
	  public String getCatalog_items_id() {
		return catalog_items_id;
	}

	  public void setCatalog_items_id(String catalog_items_id) {
		  this.catalog_items_id = catalog_items_id;
	  }


	  public double getAmount() {
		return amount;
	}

	  public void setAmount(double amount) {
		  this.amount = amount;
	  }

	  public String getDescription() {
		  return description;
	  }

	  public void setDescription(String description) {
		  this.description = description;
	  }
	  
	  public long getSelectedCatalogId() {
		return selectedCatalogId;
	}

	  public void setSelectedCatalogId(long selectedCatalogId) {
		  this.selectedCatalogId = selectedCatalogId;
	  }

	HttpServletRequest request = ServletActionContext.getRequest();
	HttpServletResponse response = ServletActionContext.getResponse();
    
	@Override
    public String execute() throws Exception {
    	System.out.println("เข้า execute()");
        return SUCCESS;
    }

    public String myEquipmentRequest() {
    
        try {
            String userSelect = request.getParameter("userSelect");
            String status = request.getParameter("status");
            
            String startDateStr = request.getParameter("startDate");
            String endDateStr   = request.getParameter("endDate");
            
            Date startDate = null;
            Date endDate = null;
            
         // 🛠️ แก้ไขบรรทัดนี้: เปลี่ยนจาก "yyyy-MM-dd" เป็น "d MMM yyyy" 
            SimpleDateFormat sdf = new SimpleDateFormat("d MMM yyyy", Locale.US);

            try {
                if (startDateStr != null && !startDateStr.isEmpty()
                        && endDateStr != null && !endDateStr.isEmpty()) {
                    startDate = sdf.parse(startDateStr.trim());
                    Date rawEnd = sdf.parse(endDateStr.trim());
                    Calendar cal = Calendar.getInstance();
                    cal.setTime(rawEnd);
                    cal.set(Calendar.HOUR_OF_DAY, 23);
                    cal.set(Calendar.MINUTE, 59);
                    cal.set(Calendar.SECOND, 59);
                    endDate = cal.getTime();
                } else {
                    // ... โค้ดคำนวณ Default 1 ม.ค. - 31 ธ.ค. ของปีปัจจุบัน (เหมือนเดิมของคุณ) ...
                    Calendar cal = Calendar.getInstance();
                    cal.set(Calendar.MONTH, Calendar.DECEMBER); cal.set(Calendar.DAY_OF_MONTH, 31);
                    cal.set(Calendar.HOUR_OF_DAY, 23); cal.set(Calendar.MINUTE, 59); cal.set(Calendar.SECOND, 59);
                    endDate = cal.getTime();
                    
                    cal.set(Calendar.MONTH, Calendar.JANUARY); cal.set(Calendar.DAY_OF_MONTH, 1);
                    cal.set(Calendar.HOUR_OF_DAY, 0); cal.set(Calendar.MINUTE, 0); cal.set(Calendar.SECOND, 0);
                    startDate = cal.getTime();
                    
                    startDateStr = sdf.format(startDate);
                    endDateStr = sdf.format(endDate);
                }
            } catch (Exception e) {
                // กันเหนียวถ้ามีปัญหาให้ใช้ค่าของปีปัจจุบัน
                Calendar cal = Calendar.getInstance();
                cal.set(Calendar.MONTH, Calendar.DECEMBER); cal.set(Calendar.DAY_OF_MONTH, 31); endDate = cal.getTime();
                cal.set(Calendar.MONTH, Calendar.JANUARY); cal.set(Calendar.DAY_OF_MONTH, 1); startDate = cal.getTime();
                startDateStr = sdf.format(startDate); endDateStr = sdf.format(endDate);
            }

                  
            if (status == null || status.trim().isEmpty()) {
            	status = "All";
            }

            // ── Page size ───────────────────────────────────────
            int pageSize = 25;
            String ps = request.getParameter("pageSize");
            if (ps != null && ps.trim().matches("\\d+")) {
                int v = Integer.parseInt(ps.trim());
                if (v == 50 || v == 100)
                    pageSize = v;
            }

            // ── Current page ─────────────────────────────────────
            int currentPage = 1;
            String pg = request.getParameter("page");
            if (pg != null && pg.trim().matches("\\d+")) {
                currentPage = Integer.parseInt(pg.trim());
                if (currentPage < 1)
                    currentPage = 1;
            }
            User onlineUser = (User) request.getSession().getAttribute("onlineUser");
            
            EquipmentRequestMr equipmentRequestMr = new EquipmentRequestMr();
            
            if (onlineUser != null) {
                equipmentRequestMr.setRequestUser(onlineUser.getId()); 
            }
            
         // 1. เรียกใช้งานข้อมูลจากฐานข้อมูลจริง
            List<Object[]> rawDataList = equipmentRequestMrDAO.getAllEquopmentRequestMr(equipmentRequestMr);
            List<Map<String, Object>> allList = new ArrayList<>();

            if (rawDataList != null) {
            	int i = 0;
                for (Object[] row : rawDataList) {
                    Map<String, Object> map = new HashMap<>();
                                       
                    map.put("no", (i + 1));
                    map.put("mr_id", row[0]);
                    map.put("product_name", row[1]);
                    map.put("item_type", row[2]);
                    map.put("item_sub_id", row[3]);
                    map.put("quantity", row[4]);
                    map.put("status_id", row[5]);
                    map.put("reqest_user", row[6]);
                    map.put("request_date", row[7]); // ใช้คีย์นี้ให้ตรงกับตัวตรวจสอบเงื่อนไขวันที่
                    map.put("Approve_user", row[8]);
                    map.put("Approve_date", row[9]);
                    map.put("receive_user", row[10]);
                    map.put("recevie_date", row[11]);
                    map.put("description", row[12]);
                    map.put("user_update", row[13]);
                    map.put("time_create", row[14]);
                    map.put("time_update", row[15]);
                    map.put("status_name", row[16]);
                    i++;
                    allList.add(map);
                }
            }

            List<Map<String, Object>> filteredList = new ArrayList<>();
            if (allList != null) {
                for (Map<String, Object> row : allList) {
                    
                    //  เช็คเงื่อนไขเรื่องวันที่ (Request Date)
                    if (startDate != null && endDate != null) {
                        Object reqDateObj = row.get("request_date");
                        if (reqDateObj instanceof Date) {
                            Date rowDate = (Date) reqDateObj;
                            // ถ้านอกช่วงเวลาที่ระบุ ให้ข้ามแถวนี้ไปเลย
                            if (rowDate.before(startDate) || rowDate.after(endDate)) {
                                continue;
                            }
                        }
                    }

                    if (userSelect != null && !userSelect.isEmpty() && !"All".equals(userSelect)) {
                        String searchKeyword = userSelect.trim().toLowerCase();
                        
                        String mrId = String.valueOf(row.get("mr_id")).toLowerCase();
                        String category = String.valueOf(row.get("category")).toLowerCase();
                        String productName = String.valueOf(row.get("product_name")).toLowerCase();
                        String statusSearch = String.valueOf(row.get("status_name")).toLowerCase();
                        
                        boolean isMatch = mrId.contains(searchKeyword) 
                                       || category.contains(searchKeyword) 
                                       || productName.contains(searchKeyword)
                            		   || statusSearch.contains(searchKeyword);
                        
                        if (!isMatch) {
                            continue; 
                        }
                    }
                    
                    filteredList.add(row); // แถวไหนรอดชีวิต เก็บลงกล่องนี้
                }
            }

            // วางจุดจัดการ Badge Counts (ย้ายมาอยู่ตรงนี้ เพื่อให้นับตามลิสต์ที่ผ่านการกรองแล้วออโต้)
            Map<String, Integer> counts = new HashMap<>();
            counts.put("Draft", 0);
            counts.put("Pending", 0);
            counts.put("Approved", 0); 
            counts.put("Rejected", 0);
            counts.put("Cancel", 0);
            counts.put("Delivered", 0);
            
            //  เปลี่ยนจากเดิมที่เป็น allList มาวนลูปนับจาก filteredList เพื่อให้ตัวเลขลดลงตามที่ค้นหาจริง
            if (filteredList != null) {
                for (Map<String, Object> row : filteredList) {
                    String itemStatus = String.valueOf(row.get("status_name")); 
                    if (counts.containsKey(itemStatus)) {
                        counts.put(itemStatus, counts.get(itemStatus) + 1);
                    }
                }
            }

            int totalDraft = counts.getOrDefault("Draft", 0);
            int totalPending = counts.getOrDefault("Pending", 0);
            int totalApproved = counts.getOrDefault("Approved", 0);
            int totalRejected = counts.getOrDefault("Rejected", 0);
            int totalCancel = counts.getOrDefault("Cancel", 0);
            int totalDelivered = counts.getOrDefault("Delivered", 0);
            
            // คัดกรองด่านสุดท้าย: เลือกเฉพาะแถวที่มีสถานะตรงกับแท็บ (Status) ที่กำลังเปิดอยู่เพื่อแสดงในตาราง
            List<Map<String, Object>> finalDisplayList = new ArrayList<>();
            for (Map<String, Object> row : filteredList) {
                if ("All".equals(status) || status.equals(row.get("status_name"))) {
                    finalDisplayList.add(row);
                }
            }
            
            //   ผูกยอดรวมของตารางปัจจุบันให้ดึงจากจำนวนแถวที่คัดมาโชว์จริงๆ
            int total = finalDisplayList.size();

            //  นำเฉพาะรายการที่กรองแล้วมาคำนวณ Pagination (เปลี่ยนจาก filteredList เป็น finalDisplayList) ──
            int totalPages = Math.max(1, (int) Math.ceil(total / (double) pageSize));
            if (currentPage > totalPages)
                currentPage = totalPages;
            int offset = (currentPage - 1) * pageSize;
            int fromIdx = total == 0 ? 0 : offset + 1;
            int toIdx = Math.min(offset + pageSize, total);

            // ตัดแบ่งย่อยลิสต์เพื่อนำส่งเฉพาะหน้าปัจจุบันไปแสดง (Pagination)
            List<Map<String, Object>> list = new ArrayList<>();
            if (!finalDisplayList.isEmpty() && total > 0) {
                int safeToIdx = Math.min(toIdx, finalDisplayList.size());
                int safeFromIdx = Math.min(offset, safeToIdx);
                list = finalDisplayList.subList(safeFromIdx, safeToIdx);
            }

            // ── 💡 ผูกข้อมูลส่งกลับไปหน้าบ้าน (JSP) ──
            request.setAttribute("status", status);
            request.setAttribute("EquipmentRequestlist", list); 
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("pageSize", pageSize);
            request.setAttribute("total", total); 
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("fromIdx", fromIdx);
            request.setAttribute("toIdx", toIdx);
            request.setAttribute("viewMode", "Draft".equals(status) ? "expense" : "group");

            request.setAttribute("total_status_draft", totalDraft);
            request.setAttribute("total_status_pending", totalPending);
            request.setAttribute("total_status_approved", totalApproved); 
            request.setAttribute("total_status_rejected", totalRejected);
            request.setAttribute("total_status_cancel", totalCancel);
            request.setAttribute("total_status_delivered", totalDelivered);
            
            request.setAttribute("idUserSelected", userSelect);
            
            
            request.setAttribute("startDateStr", startDateStr != null ? startDateStr : "");
            request.setAttribute("endDateStr",   endDateStr   != null ? endDateStr   : "");
            
            return SUCCESS;

        } catch (Exception e) {
            e.printStackTrace();
            return ERROR;
        }

    }
    
	public String EquipmentDelete() {

		try {
			
			   String id = request.getParameter("id"); 
			   
			   System.out.println("ลบข้อมูลไอดี: " + id);
			   EquipmentRequestMr equipment = new EquipmentRequestMr();
			   
			   equipment.setMrId(id);
		        
		        // เรียกผ่าน Service -> DAO
			   equipmentRequestMrDAO.deleteMr(equipment); 
			
			response.setContentType("application/json;charset=UTF-8");
			writeJson("{\"success\":true}", response); 
			
			return null;

		} catch (Exception e) {
			e.printStackTrace();
			try {
				writeJson("{\"success\":false,\"message\":\"" + e.getMessage() + "\"}", response);
			} catch (Exception ignore) {
			}
			return null;
		}
	}
	
	public String updateStatus() {

		try {
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
   
      		if (onlineUser == null)
  				return ERROR;
      		
      		   log.debug("onlineUser.getId() !!!!"+onlineUser.getId());
			
			   String id = request.getParameter("id"); 
			   String status = request.getParameter("status");
			   log.debug("status >>>"+status);
		        // เรียกผ่าน Service -> DAO
			   equipmentRequestMrDAO.updateStatus(id,status,onlineUser.getId()); 

			response.setContentType("application/json;charset=UTF-8");
			writeJson("{\"success\":true}", response); 
			
			return null;

		} catch (Exception e) {
			e.printStackTrace();
			try {
				writeJson("{\"success\":false,\"message\":\"" + e.getMessage() + "\"}", response);
			} catch (Exception ignore) {
			}
			return null;
		}
	}

	private void writeJson(String json, HttpServletResponse response) throws Exception {
		response.setContentType("application/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println(json);
		out.flush();
	}
    
    public String getauto_id_load() {
        try {
            String nextMrId = equipmentRequestMrDAO.getNextMrId();
            
            EquipmentRequestMr equipmentRequest = new EquipmentRequestMr();
            equipmentRequest.setMrId(nextMrId); 
            
            this.mr_id = nextMrId; 
            
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("nextMrId", nextMrId);

            PrintWriter out = response.getWriter();
            out.print(jsonResponse); // พ่น JSONObject ออกไป
            out.flush();           
            out.close();  
        	 return null;
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }
    
	 List<Product> ProductList = null;
    
	    public String initgetMaster() {
	        log.debug("เข้า getInit()");
	        try {
	        	
	        	DocStatus paramStatusdoc = new DocStatus();
	        	this.StatusList = equipmentRequestMrDAO.getDocStatus(paramStatusdoc);
	        	request.setAttribute("StatusList", this.StatusList); 
	        	
	        	Product paramProduct = new Product();
	    
	        	this.Product = productDAO.getproductid(paramProduct);
	        	
	        	// ส่งออกไปหน้าบ้านเหมือนเดิม
	        	request.setAttribute("ProductList", this.Product);
	        	        	
	    
	            
	            List<Map<String, Object>> unionList = new ArrayList<>();
	            
	            Product product = new Product();
	            // 1. เรียกใช้งานข้อมูลจากฐานข้อมูลจริง
	               List<Object[]> rawDataList = productDAO.getArrayProduct(product);
	               List<Map<String, Object>> allList = new ArrayList<>();

	               if (rawDataList != null) {
	                   for (Object[] row : rawDataList) {
	                       Map<String, Object> item = new HashMap<>();
	                       
	                       // แตกค่าจาก Object[] เข้า Map ตามลำดับดัชนีใน SQL SELECT
	                       item.put("id", row[0]);
	                       item.put("name", row[1]);              // pd.product_name
	                       item.put("type", "Cs");
	                       item.put("parent_product_id", row[2]); // pd.parent_product_id
	                       item.put("items_type", row[3]);  
	                       item.put("unit_name", row[4]);	
	                       item.put("unit_id", row[5]);
	                       unionList.add(item);
	                   }
	               }
	               
	            request.setAttribute("catalogEqptList", unionList);
	            getLatestAttachFile(request);
	            
	            return SUCCESS; 
	        } catch (Exception e) {
	            e.printStackTrace();
	            return ERROR;
	        }
	    }



    public List<User> getUserList() { return userList; }
    public void setUserList(List<User> userList) { this.userList = userList; }
    
    public String equipment_request_save() {
    	  System.out.println("เข้า equipment_request_save()");

        try {
      	  User onlineUser = (User) request.getSession().getAttribute("onlineUser");
      	  	String currentAction = this.action; 
      		if (onlineUser == null)
  				return ERROR;

            EquipmentRequestMr equipmentRequest;

               equipmentRequest = new EquipmentRequestMr();
               
         		String nextMrId = equipmentRequestMrDAO.getNextMrId();
                equipmentRequest.setMrId(nextMrId); 
            
               equipmentRequest.setCatalogItemsId(catalog_items_id);
               equipmentRequest.setAmount(amount);
               equipmentRequest.setDescription(description);
               equipmentRequest.setItemType(items_type);
               equipmentRequest.setItemSubId(item_sub_id);
               equipmentRequest.setStatusId(status);
               equipmentRequest.setUrlRef(url_ref);
               
              String mrIduploadfile = null;
               
               if("insert".equals(currentAction)) { 
                   equipmentRequest.setMrId(nextMrId);
            	  equipmentRequest.setRequestDate(DateUtil.getCurrentTime());
            	  mrIduploadfile = nextMrId;
               }else {
            	   equipmentRequest.setMrId(mr_id);
            	   equipmentRequest.setRequestDate(java.sql.Timestamp.valueOf(request_date.trim()));
            	   mrIduploadfile = mr_id;
               }
               equipmentRequest.setRequestUser(onlineUser.getId());
               equipmentRequest.setUserUpdate(DateUtil.getCurrentTime());
               equipmentRequest.setTimeCreate( DateUtil.getCurrentTime().toString());

           java.util.Map<String, Object> parameters = com.opensymphony.xwork2.ActionContext.getContext().getParameters();
           
           File[] myFilesArray = null;
           if (parameters != null && parameters.containsKey("fileUpload")) {
               Object fileObj = parameters.get("fileUpload");
               if (fileObj instanceof File[]) {
                   myFilesArray = (File[]) fileObj;
               } else if (fileObj instanceof File) {
                   myFilesArray = new File[] { (File) fileObj };
               }
           }

           if (myFilesArray != null && myFilesArray.length > 0 && filesUploadFileName != null && !filesUploadFileName.isEmpty()) {
               String[] fileNames = new com.google.gson.Gson().fromJson(filesUploadFileName, String[].class);
               
               for (int i = 0; i < myFilesArray.length; i++) {
                   if (i >= fileNames.length) {
                      log.warn("Mismatch between uploaded files and filenames. Skipping index: " + i);
                       continue;
                   }

                   int maxId1 = fileuploadDAO.getMaxId() + 1;
                   String fileName1 = fileNames[i];
                   ServletContext context1 = request.getServletContext();
                   String fileServerPath1 = context1.getRealPath("/");
                   long fileSize = myFilesArray[i].length();

                   FileUpload fileupload1 = new FileUpload();
                   fileupload1.setSize(formatFileSize(fileSize));
                  fileupload1.setPath("/upload/user/" + maxId1 + "_" + fileName1);
                   
                   // บันทึกไฟล์ลงดิสก์เครื่อง Server
                   FileUtil.upload(myFilesArray[i], fileServerPath1 + "upload/user/", maxId1 + "_" + fileName1);

                  int split1 = fileName1.lastIndexOf('.');
                   String name1 = fileName1.substring(0, split1);
                   String type1 = fileName1.substring(split1).toLowerCase();

                   fileupload1.setName(name1);
                   fileupload1.setType(type1);
                   fileupload1.setFileId(maxId1);
                   fileupload1.setUserId(onlineUser.getId());
                   fileupload1.setUserCreate(onlineUser.getId());
                   fileupload1.setPage("equipmentRequestFiles");
                   fileupload1.setPageId(mrIduploadfile); // ผูกไอดีเอกสารหลักหน้า Equipment ของคุณ
                   fileupload1.setUserUpdate(onlineUser.getId());
                   fileupload1.setTimeCreate(DateUtil.getCurrentTime());
                   
                   fileuploadDAO.save(fileupload1);
               }
           } else {
               log.debug("No new file to upload");
           }
        // ── ระบบแกะลบไฟล์ (Delete List) ปรับปรุงให้รองรับข้อมูลทุกรูปแบบ ──
           String[] fileIdss = new String[0];

           if (fileUploadId != null && !fileUploadId.isEmpty()) {
               // ล้างเครื่องหมายวงเล็บเหลี่ยม [ ] ช่องว่าง และเครื่องหมายคำพูด " ออกให้หมด
               String cleanIds = fileUploadId.replaceAll("[\\[\\]\\s\"]", "");
               
               // ถ้าล้างแล้วยังมีข้อมูลเหลืออยู่ ให้ทำการตัดด้วยเครื่องหมายจุลภาค (,)
               if (!cleanIds.isEmpty()) {
                   fileIdss = cleanIds.split(",");
               }
           }

           if (fileIdss != null && fileIdss.length > 0) {
               for (String fileId : fileIdss) {
                   // เพิ่ม try-catch ป้องกันกรณีหน้าบ้านเผลอส่งตัวอักษรที่ไม่ใช่ตัวเลขปนมา
                   try {
                       FileUpload file = fileuploadDAO.findById(Integer.parseInt(fileId.trim()));
                       if (file != null) {
                           fileuploadDAO.delete(file);
                       }
                   } catch (NumberFormatException e) {
                       log.error("Invalid file ID format: " + fileId);
                   }
               }
           } else {
               log.debug("No file to delete");
           }


			// บันทึก Signature ใหม่ (ถ้ามี upload) End─────────────
         
//            if (catalogEquipmentId != null) {
//            	catalogEquipmentDAO.update(catalogEquipment);
//            } else {

			  if("insert".equals(currentAction)) { 
		           equipmentRequestMrDAO.save(equipmentRequest);  
			  }else {
		           equipmentRequestMrDAO.update(equipmentRequest); 
			  }

//            }

            return null;

        } catch (Exception e) {
            e.printStackTrace();
            return ERROR;
        }
    }
   
    
    
	private String formatFileSize(long size) {
		String[] units = { "Bytes", "KB", "MB", "GB", "TB" };
		int idx = 0;
		double s = size;
		while (s > 900 && idx < units.length - 1) {
			s /= 1024;
			idx++;
		}
		return String.format("%.2f %s", s, units[idx]);
	}
	
	// ===================== Travel Approve Preview =====================
	public String EquipmentPreview() {
	    HttpServletRequest request = ServletActionContext.getRequest();
	    try {
	        User onlineUser = (User) request.getSession().getAttribute("onlineUser");
	        
	        if (onlineUser == null)
	            return ERROR;

	        String mr_id = request.getParameter("id");

	        Map<String, Object> dataload = equipmentRequestMrDAO.loaddataEquipment(mr_id);

	        request.setAttribute("Equipmentload", dataload);
	        
        	Product paramProduct = new Product();
    	    
        	this.Product = productDAO.getproductid(paramProduct);
        	
        	fileUploadlist = equipmentRequestMrDAO.findByPageAndPageId("equipmentRequestFiles", String.valueOf(mr_id));
			request.setAttribute("equipmentRequestMrFiles", fileUploadlist);
	        
	        if (fileUploadlist != null) {
	            request.setAttribute("equipmentRequestMrfiles", new Gson().toJson(fileUploadlist));
	        }
	        
        	request.setAttribute("ProductList", this.Product);
	                   
	            List<Map<String, Object>> unionList = new ArrayList<>();
	            

	            Product product = new Product();

	               List<Object[]> rawDataList = productDAO.getArrayProduct(product);
	               List<Map<String, Object>> allList = new ArrayList<>();

	               if (rawDataList != null) {
	                   for (Object[] row : rawDataList) {
	                       Map<String, Object> item = new HashMap<>();
	                       
	                       // แตกค่าจาก Object[] เข้า Map ตามลำดับดัชนีใน SQL SELECT
	                       item.put("id", row[0]);
	                       item.put("name", row[1]);              // pd.product_name
	                       item.put("type", "Cs");
	                       item.put("parent_product_id", row[2]); // pd.parent_product_id
	                       item.put("items_type", row[3]);  
	                       item.put("unit_name", row[4]);	
	                       item.put("unit_id", row[5]);
	                       unionList.add(item);
	                   }
	               }
	            request.setAttribute("catalogEqptList", unionList);   
	        
	        User userObj = null;
	        User userObjAdmin = null;
	        if("admin".equals(onlineUser.getRoleId())) {
	        	 userObj =  userDAO.findById(String.valueOf(dataload.get("request_user")));
	        	 userObjAdmin = userDAO.findById(onlineUser.getId());
	        }else { 
	        	 userObj = userDAO.findById(onlineUser.getId());
	        	 userObjAdmin = userDAO.findById(String.valueOf(dataload.get("user_create")));
	        }
	        request.setAttribute("userObjAdmin", userObjAdmin);
	        request.setAttribute("userObj", userObj);
	        request.setAttribute("selectedIds", mr_id != null ? Arrays.asList(mr_id) : java.util.Collections.emptyList());
	       
	        if (userObj != null) {
	        	request.setAttribute("signaturePath", userObj.getPathSignature());
	        }

	        if (userObjAdmin != null) {
			    request.setAttribute("signaturePath2", userObjAdmin.getPathSignature());
	        }

	        boolean onlineUserSignature = false;
	        if (onlineUser != null) {
	            User u = userDAO.findById(onlineUser.getId()); 
	            if (u != null) {
	                String sig = u.getPathSignature();
	                onlineUserSignature = sig != null && !sig.trim().isEmpty() && !"null".equalsIgnoreCase(sig.trim());
	            }
	        }
	        request.setAttribute("onlineUserSignature", onlineUserSignature);

	        return SUCCESS;

	    } catch (Exception e) {
	        e.printStackTrace();
	        return ERROR;
	    }
	}


	private void getLatestAttachFile(HttpServletRequest request) {
	    try {
	        User onlineUser = (User) request.getSession().getAttribute("onlineUser");
	        if (onlineUser != null) {
	            // ดึงไฟล์แนบทั้งหมดของ user รายนี้
	            String[] ids = request.getParameterValues("id");     

		        // จัดการข้อมูล User และลายเซ็น (โค้ดเดิมของคุณ) ──────────────────────
		        // ดึงข้อมูลโปรไฟล์ของ User ปัจจุบันมาแสดง
		        User userObj = userDAO.findById(onlineUser.getId());
		        request.setAttribute("userObj", userObj);
		        request.setAttribute("selectedIds", ids != null ? Arrays.asList(ids) : java.util.Collections.emptyList());

	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}





    
}
