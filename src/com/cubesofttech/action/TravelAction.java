package com.cubesofttech.action;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.cubesofttech.dao.ExpTravelTypeDAO;
import com.cubesofttech.dao.ExpenseDAO;
import com.cubesofttech.dao.ExpenseDetailDAO;
import com.cubesofttech.dao.ExpenseGroupDAO;
import com.cubesofttech.dao.FileUploadDAO;
import com.cubesofttech.dao.UserDAO;

import com.cubesofttech.model.ExpTravelType;
import com.cubesofttech.model.Expense;
import com.cubesofttech.model.ExpenseDetail;
import com.cubesofttech.model.ExpenseGroup;
import com.cubesofttech.model.FileUpload;
import com.cubesofttech.model.User;

import com.cubesofttech.service.FileAttachmentService;
import com.cubesofttech.util.DateUtil;
import com.cubesofttech.util.FileUtil;
import com.cubesofttech.util.ReportUtil;
import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;

import net.sf.jasperreports.engine.JasperCompileManager;

public class TravelAction extends ActionSupport {

	private static final long serialVersionUID = 1L;
	public static final String LOGOPATH = "logoPath";
	public static final String JASPERPATH = "/WEB-INF/classes/jasper";
	public static final String IMAGEPATH = "/images";

	private Map<String, Object> jsonData;
	
	private String status;

	Logger log = Logger.getLogger(getClass());

	@Autowired
	private ExpenseDAO expenseDAO;
	@Autowired
	private ExpenseDetailDAO expenseDetailDAO;
	@Autowired
	private ExpenseGroupDAO expenseGroupDAO;
	@Autowired
	private UserDAO userDAO;
	@Autowired
	private ExpTravelTypeDAO expTravelTypeDAO;
	@Autowired
	private FileUploadDAO fileuploadDAO;
	@Autowired
	private FileAttachmentService fileAttachmentService;

	private java.io.File[] files;
	private String[] filesFileName;
	private String[] filesContentType;
	private String filesUploadFileName;
	private String fileUploadId;

	public java.io.File[] getFiles() {
		return files;
	}

	public void setFiles(java.io.File[] v) {
		this.files = v;
	}

	public String[] getFilesFileName() {
		return filesFileName;
	}

	public void setFilesFileName(String[] v) {
		this.filesFileName = v;
	}

	public String[] getFilesContentType() {
		return filesContentType;
	}

	public void setFilesContentType(String[] v) {
		this.filesContentType = v;
	}

	public String getFilesUploadFileName() {
		return filesUploadFileName;
	}

	public void setFilesUploadFileName(String v) {
		this.filesUploadFileName = v;
	}

	public String getFileUploadId() {
		return fileUploadId;
	}

	public void setFileUploadId(String v) {
		this.fileUploadId = v;
	}

	public Map<String, Object> getJsonData() {
		return jsonData;
	}
	
	public String getStatus() {
	    return status;
	}

	public void setStatus(String status) {
	    this.status = status;
	}

	// ===================== หน้า add form =====================
	public String travelAdd() {
		HttpServletRequest request = ServletActionContext.getRequest();
		try {
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			if (onlineUser == null)
				return ERROR;

			String userJSON = userDAO.userListJSON();
			List<Map<String, Object>> userListObj = new Gson().fromJson(userJSON,
					new com.google.gson.reflect.TypeToken<List<Map<String, Object>>>() {
					}.getType());

			List<ExpTravelType> exptr = expTravelTypeDAO.findAllActive();
			request.setAttribute("userListObj", userListObj);
			request.setAttribute("expTravelTypeList", exptr);
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	// ===================== LIST =====================
	public String myTravelList() {
		HttpServletRequest request = ServletActionContext.getRequest();
		try {
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			if (onlineUser == null)
				return ERROR;

			String userJSON = userDAO.userListJSON();
			List<Map<String, Object>> userListObj = new Gson().fromJson(userJSON,
					new com.google.gson.reflect.TypeToken<List<Map<String, Object>>>() {
					}.getType());

			String status = request.getParameter("status");
			if (status == null || status.trim().isEmpty())
				status = "Draft";

			String userId = onlineUser.getId();
			// Comment

			// ── Date range ──────────────────────────────────────────────────────
			String dateRange = request.getParameter("dateRange");
			java.sql.Date dateFrom = null, dateTo = null;
			if (dateRange != null && !dateRange.trim().isEmpty()) {
				String[] parts = dateRange.trim().split("\\s+to\\s+");
				if (parts.length == 2) {
					try {
						if (!parts[0].trim().isEmpty())
							dateFrom = java.sql.Date.valueOf(parts[0].trim());
					} catch (Exception ignored) {
					}
					try {
						if (!parts[1].trim().isEmpty())
							dateTo = java.sql.Date.valueOf(parts[1].trim());
					} catch (Exception ignored) {

					}
				} else if (parts.length == 1) {
					dateFrom = java.sql.Date.valueOf(parts[0].trim());
					dateTo = java.sql.Date.valueOf(parts[0].trim());
				}
			}

			if (dateTo != null) {
				Calendar cal = Calendar.getInstance();
				cal.setTime(dateTo);
				cal.add(Calendar.DATE, 1);
				dateTo = new java.sql.Date(cal.getTimeInMillis());
			}

			// ── Page size ───────────────────────────────────────────────────────
			int pageSize = 25;
			String ps = request.getParameter("pageSize");
			if (ps != null && ps.trim().matches("\\d+")) {
				int v = Integer.parseInt(ps.trim());
				if (v == 50 || v == 100)
					pageSize = v;
			}

			// ── Current page ────────────────────────────────────────────────────
			int currentPage = 1;
			String pg = request.getParameter("page");
			if (pg != null && pg.trim().matches("\\d+")) {
				currentPage = Integer.parseInt(pg.trim());
				if (currentPage < 1)
					currentPage = 1;
			}

			int total;
			List<Map<String, Object>> list;

			int totalDraft = expenseDAO.countMyTravelDraftNoGroup(userId, dateFrom, dateTo);

			if ("Draft".equals(status)) {
				total = totalDraft;

				int totalPages = Math.max(1, (int) Math.ceil(total / (double) pageSize));
				if (currentPage > totalPages)
					currentPage = totalPages;
				int offset = (currentPage - 1) * pageSize;
				int fromIdx = total == 0 ? 0 : offset + 1;
				int toIdx = Math.min(offset + pageSize, total);

				list = expenseDAO.findMyTravelDraftNoGroup(userId, dateFrom, dateTo, offset, pageSize);

				enrichRows(list);

				setAttrs(request, userListObj, userJSON, status, list, currentPage, pageSize, total, totalPages,
						fromIdx, toIdx);

				request.setAttribute("viewMode", "expense");

			} else {

				int offset = (currentPage - 1) * pageSize;

				Map<String, Object> daoResult = expenseGroupDAO.findMyGroupsAndCountByStatus(status, userId, dateFrom,
						dateTo, offset, pageSize);

				list = (List<Map<String, Object>>) daoResult.get("data");

				total = (int) daoResult.get("total");

				int totalPages = Math.max(1, (int) Math.ceil(total / (double) pageSize));
				if (currentPage > totalPages)
					currentPage = totalPages;

				int fromIdx = total == 0 ? 0 : offset + 1;
				int toIdx = Math.min(offset + pageSize, total);

				setAttrs(request, userListObj, userJSON, status, list, currentPage, pageSize, total, totalPages,
						fromIdx, toIdx);

				request.setAttribute("viewMode", "group");
			}

			Map<String, Integer> counts = expenseDAO.countMyTravelListAllStatus(userId, dateFrom, dateTo);

			if (counts == null) {
				counts = new HashMap<>();
			}

			int totalWaiting = counts.getOrDefault("W", 0);
			int totalApproved = counts.getOrDefault("A", 0);
			int totalRejected = counts.getOrDefault("R", 0);
			int totalCanceled = counts.getOrDefault("C", 0);
			int totalPaid = counts.getOrDefault("P", 0);

			request.setAttribute("total_status_draft", totalDraft);
			request.setAttribute("total_status_waiting", totalWaiting);
			request.setAttribute("total_status_approved", totalApproved);
			request.setAttribute("total_status_rejected", totalRejected);
			request.setAttribute("total_status_canceled", totalCanceled);
			request.setAttribute("total_status_paid", totalPaid);

			request.setAttribute("total_status_waiting", totalWaiting);
			request.setAttribute("total_status_approved", totalApproved);
			request.setAttribute("total_status_rejected", totalRejected);
			request.setAttribute("total_status_canceled", totalCanceled);
			request.setAttribute("total_status_paid", totalPaid);

			return SUCCESS;

		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	public String travelDelete() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		try {
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			if (onlineUser == null) {
				writeJson("{\"success\":false,\"message\":\"Session expired\"}", response);
				return null;
			}

			String idStr = request.getParameter("id");
			if (idStr == null || !idStr.trim().matches("\\d+")) {
				writeJson("{\"success\":false,\"message\":\"Invalid ID\"}", response);
				return null;
			}

			Long expenseId = Long.parseLong(idStr.trim());
			Expense exp = expenseDAO.findById(expenseId);

			if (exp == null) {
				writeJson("{\"success\":false,\"message\":\"Expense not found\"}", response);
				return null;
			}

			// ✅ ป้องกัน: ลบได้เฉพาะ Draft (group_id = 0) และเป็นของ user คนนี้
			if (exp.getExpenseGroupId() != null && exp.getExpenseGroupId() > 0) {
				writeJson("{\"success\":false,\"message\":\"Cannot delete submitted expense\"}", response);
				return null;
			}

			if (!onlineUser.getId().equals(exp.getUserId())) {
				writeJson("{\"success\":false,\"message\":\"Permission denied\"}", response);
				return null;
			}

			// ── ลบ ExpenseDetail ────────────────────────────────────────────────
			expenseDetailDAO.deleteByExpenseId(expenseId);

			// ── ลบไฟล์แนบ (ถ้ามี) ─────────────────────────────────────────────
			List<FileUpload> attachedFiles = fileuploadDAO.findByPageAndPageId("travel",
					String.valueOf(expenseId));
			if (attachedFiles != null) {
				String serverRoot = ServletActionContext.getServletContext().getRealPath("/");
				for (FileUpload fu : attachedFiles) {
					try {
						java.io.File phys = new java.io.File(serverRoot + fu.getPath());
						if (phys.exists())
							phys.delete();
					} catch (Exception ignoreFile) {
					}
					fileuploadDAO.delete(fu);
				}
			}

			// ── ลบ Expense ─────────────────────────────────────────────────────
			expenseDAO.delete(exp);

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

	private void enrichRows(List<Map<String, Object>> list) throws Exception {
		for (Map<String, Object> row : list) {
			Object expId = row.get("expense_id");
			if (expId == null)
				continue;
			Long expenseId = Long.parseLong(expId.toString());

			Expense exp = expenseDAO.findById(expenseId);
			if (exp != null) {
				row.put("user_id", exp.getUserId());
				row.put("from_location", exp.getFromLocation());
				row.put("to_location", exp.getToLocation());
				row.put("description", exp.getDescription());
				row.put("dt_start", exp.getDtStart() != null ? new java.util.Date(exp.getDtStart().getTime()) : null);
				row.put("dt_end", exp.getDtEnd() != null ? new java.util.Date(exp.getDtEnd().getTime()) : null);
				row.put("time_create",
						exp.getTimeCreate() != null ? new java.util.Date(exp.getTimeCreate().getTime()) : null);
			}

			List<ExpenseDetail> details = expenseDetailDAO.findByExpenseId(expenseId);
			List<Map<String, Object>> detailMaps = new ArrayList<>();
			for (ExpenseDetail det : details) {
				Map<String, Object> d = new HashMap<>();
				String typeName = "-";
				if (det.getGoBy() != null && det.getGoBy() > 0) {
					ExpTravelType ett = expTravelTypeDAO.findById(det.getGoBy());
					if (ett != null)
						typeName = ett.getName();
				}
				d.put("travel_type_name", typeName);
				d.put("description", det.getDescription());
				d.put("total", det.getTotal());
				detailMaps.add(d);
			}
			row.put("details", detailMaps);
		}
	}

	private void setAttrs(HttpServletRequest request, List<Map<String, Object>> userListObj, String userJSON,
			String status, List<Map<String, Object>> list, int currentPage, int pageSize, int total, int totalPages,
			int fromIndex, int toIndex) {
		request.setAttribute("userListObj", userListObj);
		request.setAttribute("userList", userJSON);
		request.setAttribute("statusActive", status);
		request.setAttribute("travelListObj", list);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("total", total);
		request.setAttribute("totalPages", totalPages);
		request.setAttribute("fromIndex", fromIndex);
		request.setAttribute("toIndex", toIndex);
	}

	// ===================== MODAL JSON =====================
	public String travelExpenseModalJSON() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		try {
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			if (onlineUser == null) {
				writeJson("{\"expense\":null,\"group\":null}", response);
				return null;
			}

			String id = request.getParameter("id");
			if (id == null || id.trim().isEmpty() || !id.trim().matches("\\d+")) {
				writeJson("{\"expense\":null,\"group\":null}", response);
				return null;
			}

			Map<String, Object> data = expenseDAO.getTravelExpenseModalData(Long.parseLong(id.trim()));
			writeJson(new Gson().toJson(data), response);
			return null;

		} catch (Exception e) {
			e.printStackTrace();
			try {
				writeJson("{\"expense\":null,\"group\":null}", response);
			} catch (Exception ignore) {
			}
			return null;
		}
	}

	// ===================== SAVE =====================
	public String travelSave() {
		HttpServletRequest request = ServletActionContext.getRequest();
		try {
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			if (onlineUser == null)
				return ERROR;
			String departureDate = request.getParameter("departureDate");
			String userId = request.getParameter("userId");
			String beginning = request.getParameter("beginning");
			String beginTime = request.getParameter("beginTime");
			String destination = request.getParameter("destination");
			String destTime = request.getParameter("destTime");
			String purposeText = request.getParameter("purposeOfJourney");

			String[] goByArr = request.getParameterValues("detailGoBy");
			String[] totalArr = request.getParameterValues("detailTotal");
			String[] descArr = request.getParameterValues("detailDescription");
			String[] kmArr = request.getParameterValues("detailKilometers");

			Timestamp now = DateUtil.getCurrentTime();
			Timestamp dtStart = combineDateTime(departureDate, beginTime);
			Timestamp dtEnd = combineDateTime(departureDate, destTime);

			if (dtStart != null && dtEnd != null && dtEnd.before(dtStart)) {
				Calendar cal = Calendar.getInstance();
				cal.setTimeInMillis(dtEnd.getTime());
				cal.add(Calendar.DAY_OF_MONTH, 1);
				dtEnd = new Timestamp(cal.getTimeInMillis());
			}

			BigDecimal amount = BigDecimal.ZERO;
			if (totalArr != null) {
				for (String t : totalArr) {
					if (t == null || t.trim().isEmpty())
						continue;
					try {
						amount = amount.add(new BigDecimal(t.trim()));
					} catch (Exception ignore) {
					}
				}
			}

			Long dtBy = 0L;
			if (goByArr != null && goByArr.length > 0) {
				String last = goByArr[goByArr.length - 1];
				if (last != null && last.trim().matches("\\d+"))
					dtBy = Long.parseLong(last.trim());
			}

			Long newExpenseId = expenseDAO.getMaxId() + 1;

			Expense e = new Expense();
			e.setExpenseId(newExpenseId);
			e.setExpenseGroupId(0L);
			e.setExpTypeId("T");

			e.setDtStart(dtStart);
			e.setDtEnd(dtEnd);

			e.setDtBy(dtBy);
			e.setUserId(userId);
			e.setFromLocation(beginning);
			e.setToLocation(destination);
			e.setFromLat(null);
			e.setFromLon(null);
			e.setToLat(null);
			e.setToLon(null);
			e.setAmount(amount);
			e.setDescription(purposeText);
			e.setUserCreate(onlineUser.getId());
			e.setUserUpdate(onlineUser.getId());
			e.setTimeCreate(now);
			e.setTimeUpdate(now);
			expenseDAO.save(e);

			// Save details
			if (goByArr != null && totalArr != null) {
				Long maxDetailId = expenseDetailDAO.getMaxId();
				long nextDetailId = (maxDetailId == null ? 0L : maxDetailId) + 1;
				int n = Math.min(goByArr.length, totalArr.length);

				for (int i = 0; i < n; i++) {
					String goBy = goByArr[i];
					String total = totalArr[i];
					String desc = (descArr != null && i < descArr.length) ? descArr[i] : null;

					if ((goBy == null || goBy.trim().isEmpty()) && (total == null || total.trim().isEmpty())
							&& (desc == null || desc.trim().isEmpty()))
						continue;

					ExpenseDetail d = new ExpenseDetail();
					d.setExpenseDetailId(nextDetailId++);
					d.setExpenseId(newExpenseId);

					Long goById = 0L;
					if (goBy != null && goBy.trim().matches("\\d+"))
						goById = Long.parseLong(goBy.trim());
					d.setGoBy(goById);

					BigDecimal bd = BigDecimal.ZERO;
					try {
						if (total != null && !total.trim().isEmpty())
							bd = new BigDecimal(total.trim());
					} catch (Exception ignore) {
					}
					d.setTotal(bd);

					BigDecimal km = BigDecimal.ZERO;
					try {
						String ks = (kmArr != null && i < kmArr.length) ? kmArr[i] : null;
						if (ks != null && !ks.trim().isEmpty())
							km = new BigDecimal(ks.trim());
					} catch (Exception ignore) {
					}
					d.setKilometers(km);

					d.setDescription(desc);
					d.setUserCreate(onlineUser.getId());
					d.setUserUpdate(onlineUser.getId());
					d.setTimeCreate(now);
					d.setTimeUpdate(now);
					expenseDetailDAO.save(d);
				}
			}

			if (files != null && files.length > 0) {
				String serverRealPath =
						ServletActionContext.getServletContext().getRealPath("/");

				fileAttachmentService.attach(
					Arrays.asList(files),
					filesFileName != null
						? Arrays.asList(filesFileName)
						: null,
					"travel",
					String.valueOf(newExpenseId),
					onlineUser.getId(),
					serverRealPath
				);
			}
			// saveAttachedFiles(files, filesFileName, filesUploadFileName, "travel", String.valueOf(newExpenseId),
			// 		onlineUser.getId(), now);

			return SUCCESS;

		} catch (Exception ex) {
			ex.printStackTrace();
			return ERROR;
		}
	}

	// ===================== EDIT =====================
	public String travelEdit() {
		HttpServletRequest request = ServletActionContext.getRequest();
		try {
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			if (onlineUser == null)
				return ERROR;

			String id = request.getParameter("id");
			if (id == null || id.trim().isEmpty() || !id.trim().matches("\\d+"))
				return ERROR;

			Long expenseId = Long.parseLong(id.trim());
			Expense expense = expenseDAO.findById(expenseId);
			if (expense == null)
				return ERROR;

			List<ExpenseDetail> detailList = expenseDetailDAO.findByExpenseId(expenseId);
			List<FileUpload> travelFiles = fileuploadDAO.findByPageAndPageId("travel", id);

			String userJSON = userDAO.userListJSON();
			List<Map<String, Object>> userListObj = new Gson().fromJson(userJSON,
					new com.google.gson.reflect.TypeToken<List<Map<String, Object>>>() {
					}.getType());
			List<ExpTravelType> exptr = expTravelTypeDAO.findAllActive();

			Gson gson = new Gson();
			request.setAttribute("travelFiles", travelFiles);
			request.setAttribute("expenseObj", expense);
			request.setAttribute("detailList", detailList);
			request.setAttribute("userListObj", userListObj);
			request.setAttribute("expTravelTypeList", exptr);
			request.setAttribute("expenseJSON", gson.toJson(expense));
			request.setAttribute("detailListJSON", gson.toJson(detailList));
			request.setAttribute("userList", userJSON);
			request.setAttribute("expTravelTypeListJSON", gson.toJson(exptr));

			request.getSession().setAttribute("expenseId", String.valueOf(expenseId));
			return SUCCESS;

		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	// ===================== UPDATE =====================
	public String travelUpdate() {
		HttpServletRequest request = ServletActionContext.getRequest();
		try {
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			if (onlineUser == null)
				return ERROR;

			String expIdStr = request.getParameter("expenseId");
			if (expIdStr == null || !expIdStr.trim().matches("\\d+"))
				return ERROR;
			Long expenseId = Long.parseLong(expIdStr.trim());

			Expense old = expenseDAO.findById(expenseId);
			if (old == null)
				return ERROR;

			Timestamp now = DateUtil.getCurrentTime();

			String departureDate = request.getParameter("departureDate");
			String beginning = request.getParameter("beginning");
			String beginTime = request.getParameter("beginTime");
			String destination = request.getParameter("destination");
			String destTime = request.getParameter("destTime");
			String purposeText = request.getParameter("purposeOfJourney");

			String[] goByArr = request.getParameterValues("detailGoBy");
			String[] totalArr = request.getParameterValues("detailTotal");
			String[] descArr = request.getParameterValues("detailDescription");
			String[] kmArr = request.getParameterValues("detailKilometers");

			Timestamp dtStart = combineDateTime(departureDate, beginTime);
			Timestamp dtEnd = combineDateTime(departureDate, destTime);

			if (dtStart != null && dtEnd != null && dtEnd.before(dtStart)) {
				Calendar cal = Calendar.getInstance();
				cal.setTimeInMillis(dtEnd.getTime());
				cal.add(Calendar.DAY_OF_MONTH, 1);
				dtEnd = new Timestamp(cal.getTimeInMillis());
			}

			BigDecimal newAmount = BigDecimal.ZERO;
			if (totalArr != null) {
				for (String t : totalArr) {
					if (t == null || t.trim().isEmpty())
						continue;
					try {
						newAmount = newAmount.add(new BigDecimal(t.trim()));
					} catch (Exception ignore) {
					}
				}
			}

			Long dtBy = 0L;
			if (goByArr != null && goByArr.length > 0) {
				String last = goByArr[goByArr.length - 1];
				if (last != null && last.trim().matches("\\d+"))
					dtBy = Long.parseLong(last.trim());
			}

			// ✅ ถ้า expense ผูกกับ group จริง (group_id > 0) ให้อัปเดต total amount ของ
			// group ด้วย
			Long oldGroupId = old.getExpenseGroupId();
			BigDecimal oldAmount = (old.getAmount() == null ? BigDecimal.ZERO : old.getAmount());

			old.setDtStart(dtStart);
			old.setDtEnd(dtEnd);
			old.setDtBy(dtBy);
			old.setFromLocation(beginning);
			old.setToLocation(destination);
			old.setAmount(newAmount);
			old.setDescription(purposeText);
			old.setUserUpdate(onlineUser.getId());
			old.setTimeUpdate(now);
			expenseDAO.update(old);

			if (oldGroupId != null && oldGroupId > 0) {
				ExpenseGroup g = expenseGroupDAO.findById(oldGroupId);
				if (g != null) {
					BigDecimal gt = (g.getTotalAmount() == null ? BigDecimal.ZERO : g.getTotalAmount());
					gt = gt.subtract(oldAmount).add(newAmount);
					if (gt.compareTo(BigDecimal.ZERO) < 0)
						gt = BigDecimal.ZERO;
					g.setTotalAmount(gt);
					g.setUserUpdate(onlineUser.getId());
					g.setTimeUpdate(now);
					expenseGroupDAO.update(g);
				}
			}

			expenseDetailDAO.deleteByExpenseId(expenseId);

			if (goByArr != null && totalArr != null) {
				Long maxDetailId = expenseDetailDAO.getMaxId();
				long nextId = (maxDetailId == null ? 0L : maxDetailId) + 1;
				int n = Math.min(goByArr.length, totalArr.length);

				for (int i = 0; i < n; i++) {
					String goBy = goByArr[i];
					String total = totalArr[i];
					String desc = (descArr != null && i < descArr.length) ? descArr[i] : null;

					if ((goBy == null || goBy.trim().isEmpty()) && (total == null || total.trim().isEmpty())
							&& (desc == null || desc.trim().isEmpty()))
						continue;

					ExpenseDetail d = new ExpenseDetail();
					d.setExpenseDetailId(nextId++);
					d.setExpenseId(expenseId);

					Long goById = 0L;
					if (goBy != null && goBy.trim().matches("\\d+"))
						goById = Long.parseLong(goBy.trim());
					d.setGoBy(goById);

					BigDecimal bd = BigDecimal.ZERO;
					try {
						if (total != null && !total.trim().isEmpty())
							bd = new BigDecimal(total.trim());
					} catch (Exception ignore) {
					}
					d.setTotal(bd);

					BigDecimal km = BigDecimal.ZERO;
					try {
						String ks = (kmArr != null && i < kmArr.length) ? kmArr[i] : null;
						if (ks != null && !ks.trim().isEmpty())
							km = new BigDecimal(ks.trim());
					} catch (Exception ignore) {
					}
					d.setKilometers(km);

					d.setDescription(desc);
					d.setUserCreate(onlineUser.getId());
					d.setUserUpdate(onlineUser.getId());
					d.setTimeCreate(now);
					d.setTimeUpdate(now);
					expenseDetailDAO.save(d);
				}
			}

			// ลบไฟล์ที่ mark ว่าจะลบ
			if (fileUploadId != null && !fileUploadId.trim().isEmpty() && !fileUploadId.trim().equals("[]")) {
				try {
					String[] fileIds = new Gson().fromJson(fileUploadId.trim(), String[].class);
					if (fileIds != null) {
						for (String fid : fileIds) {
							if (fid == null || fid.trim().isEmpty())
								continue;
							try {
								FileUpload fu = fileuploadDAO.findById(Integer.parseInt(fid.trim()));
								if (fu != null) {
									try {
										java.io.File phys = new java.io.File(
												ServletActionContext.getServletContext().getRealPath(fu.getPath()));
										if (phys.exists())
											phys.delete();
									} catch (Exception ignoreFile) {
									}
									fileuploadDAO.delete(fu);
								}
							} catch (NumberFormatException ignore) {
							}
						}
					}
				} catch (Exception parseEx) {
					log.error("Failed to parse fileUploadId: " + fileUploadId, parseEx);
				}
			}

			if (files != null && files.length > 0) {
				String serverRealPath = ServletActionContext.getServletContext().getRealPath("/");

				fileAttachmentService.attach(
					Arrays.asList(files),
					filesFileName != null
						? Arrays.asList(filesFileName)
						: null,
					"travel",
					String.valueOf(expenseId),
					onlineUser.getId(),
					serverRealPath
				);
			}
			// saveAttachedFiles(files, filesFileName, filesUploadFileName, "travel", String.valueOf(expenseId),
			// 		onlineUser.getId(), now);

			return SUCCESS;

		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	// ===================== Travel Cancel =====================
	public String travelCancel() {
		try {

			HttpServletRequest request = ServletActionContext.getRequest();
			String expenseGroupIdStr = request.getParameter("expense_group_id");

			Long expenseGroupId = Long.parseLong(expenseGroupIdStr);
			ExpenseGroup expense = expenseGroupDAO.findById(expenseGroupId);

			Timestamp now = DateUtil.getCurrentTime();
			expense.setStatusId("C");
			expense.setTimeUpdate(now);

			expenseGroupDAO.update(expense);

			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	// ===================== Submit Preview =====================
	public String submitTravelPreview() {
		HttpServletRequest request = ServletActionContext.getRequest();
		try {
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			if (onlineUser == null)
				return ERROR;

			String[] ids = request.getParameterValues("ids");

			String expenseGroupIdStr = request.getParameter("expense_group_id");
			String status = request.getParameter("status");

			List<Long> expenseIds = new ArrayList<>();
			if (ids != null) {
				Arrays.sort(ids, Comparator.comparingLong(Long::parseLong));
				for (String s : ids) {
					if (s != null) {
						String t = s.trim();
						if (!t.isEmpty() && t.matches("\\d+"))
							expenseIds.add(Long.parseLong(t));
					}
				}
			} else if (expenseGroupIdStr != null && !expenseGroupIdStr.isEmpty()) {
				long expenseGroupId = Long.parseLong(expenseGroupIdStr);
				List<Expense> expenseList = expenseDAO.findByGroupId(expenseGroupId);

				ExpenseGroup expenseGroup = expenseGroupDAO.findById(expenseGroupId);
				String userApprId = expenseGroup.getAppr_user_id();

				for (Expense expense : expenseList) {
					expenseIds.add(expense.getExpenseId());
				}

				if (userApprId != null && !userApprId.isEmpty()) {
					User user = userDAO.findById(userApprId);
					request.setAttribute("userAppr", user);
					request.setAttribute("approved_at", expenseGroup.getApproved_at());
				}

				request.setAttribute("requestAt", expenseGroup.getRequestedAt());

				request.setAttribute("description_appr", expenseGroup.getDescription_appr());
				request.setAttribute("statusActiveSafe", status);
				request.setAttribute("expense_group_id", expenseGroupIdStr);
				request.setAttribute("expense_group_create_date", expenseGroup.getTimeCreate());

			}

			List<Map<String, Object>> expenseListObj = new ArrayList<>();
			BigDecimal grandTotal = BigDecimal.ZERO;

			for (Long expenseId : expenseIds) {
				Expense exp = expenseDAO.findById(expenseId);
				if (exp == null)
					continue;

				Map<String, Object> expMap = new HashMap<>();
				expMap.put("expense_id", exp.getExpenseId());
				expMap.put("expense_group_id", exp.getExpenseGroupId());
				expMap.put("dt_start",
						exp.getDtStart() != null ? new java.util.Date(exp.getDtStart().getTime()) : null);
				expMap.put("dt_end", exp.getDtEnd() != null ? new java.util.Date(exp.getDtEnd().getTime()) : null);
				expMap.put("from_location", exp.getFromLocation());
				expMap.put("to_location", exp.getToLocation());
				expMap.put("description", exp.getDescription());
				expMap.put("amount", exp.getAmount());
				expMap.put("time_create",
						exp.getTimeCreate() != null ? new java.util.Date(exp.getTimeCreate().getTime()) : null);

				// ── Details ──────────────────────────────────────────
				List<ExpenseDetail> details = expenseDetailDAO.findByExpenseId(expenseId);
				List<Map<String, Object>> detailMaps = new ArrayList<>();
				if (details != null) {
					for (ExpenseDetail det : details) {
						Map<String, Object> d = new HashMap<>();
						String typeName = "-";
						if (det.getGoBy() != null && det.getGoBy() > 0) {
							ExpTravelType ett = expTravelTypeDAO.findById(det.getGoBy());
							if (ett != null && ett.getName() != null)
								typeName = ett.getName();
						}
						d.put("travel_type_name", typeName);
						d.put("description", det.getDescription());
						d.put("total", det.getTotal());
						detailMaps.add(d);
					}
				}
				expMap.put("details", detailMaps);

				// ── Attached files ───────────────────────────────────
				List<FileUpload> fileList = fileuploadDAO.findByPageAndPageId("travel", String.valueOf(expenseId));
				expMap.put("files", fileList != null ? fileList : new ArrayList<>());

				if (exp.getAmount() != null)
					grandTotal = grandTotal.add(exp.getAmount());
				expenseListObj.add(expMap);
			}

			// ── User ─────────────────────────────────────────────────
			User userObj = userDAO.findById(onlineUser.getId());

			request.setAttribute("expenseListObj", expenseListObj);
			request.setAttribute("userObj", userObj);
			request.setAttribute("grandTotal", grandTotal);
			request.setAttribute("selectedIds", ids != null ? Arrays.asList(ids) : java.util.Collections.emptyList());

			if (userObj != null) {
				String imgPathSignature = fileAttachmentService.getFileUrl(userObj.getPathSignature());
				if (imgPathSignature != null) {
					request.setAttribute("signaturePath", imgPathSignature);
				}
			}

			return SUCCESS;

		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	public String submitTravelRequest() {
		HttpServletRequest request = ServletActionContext.getRequest();
		try {
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			if (onlineUser == null)
				return ERROR;

			// ── 1. รับ expense ids ──────────────────────────────────
			String[] ids = request.getParameterValues("ids");
			List<Long> expenseIds = new ArrayList<>();
			if (ids != null) {
				for (String s : ids) {
					if (s != null && !s.trim().isEmpty() && s.trim().matches("\\d+"))
						expenseIds.add(Long.parseLong(s.trim()));
				}
			}
			if (expenseIds.isEmpty())
				return "redirect_back";

			Timestamp now = DateUtil.getCurrentTime();

			// ── 2. โหลด Expense + คำนวณ grandTotal ─────────────────
			BigDecimal grandTotal = BigDecimal.ZERO;
			List<Expense> expenseList = new ArrayList<>();
			for (Long expId : expenseIds) {
				Expense exp = expenseDAO.findById(expId);
				if (exp == null)
					continue;
				expenseList.add(exp);
				if (exp.getAmount() != null)
					grandTotal = grandTotal.add(exp.getAmount());
			}
			if (expenseList.isEmpty())
				return "redirect_back";

			// ── 3. สร้าง ExpenseGroup ใหม่ ──────────────────────────
			Long newGroupId = expenseGroupDAO.getMaxId() + 1;

			ExpenseGroup group = new ExpenseGroup();
			group.setExpenseGroupId(newGroupId);
			group.setExpTypeId("T");
			group.setTotalAmount(grandTotal);
			group.setStatusId("W");
			group.setUserId(onlineUser.getId());

			group.setRequestedBy(onlineUser.getId());
			group.setRequestedAt(now);

			group.setReceivedBy(onlineUser.getId());
			group.setReceivedAt(null);

			group.setUserCreate(onlineUser.getId());
			group.setUserUpdate(onlineUser.getId());
			group.setTimeCreate(now);
			group.setTimeUpdate(now);
			expenseGroupDAO.save(group);

			// ── 4. ผูก Expense ทุกตัวเข้า group ใหม่ ────────────────
			for (Expense exp : expenseList) {
				exp.setExpenseGroupId(newGroupId);
				exp.setUserUpdate(onlineUser.getId());
				exp.setTimeUpdate(now);
				expenseDAO.update(exp);
			}

			// ── 5. บันทึก Signature ใหม่ (ถ้ามี upload) ─────────────
			if (files != null && files.length > 0 && filesFileName != null && filesFileName.length > 0) {
				try {
					List<FileUpload> savedFiles = fileAttachmentService.attach(
						Arrays.asList(files[0]),
						Arrays.asList(filesFileName[0]),
						"user",
						onlineUser.getId(),
						onlineUser.getId(),
						ServletActionContext.getServletContext().getRealPath("/")
					);

					if (savedFiles != null && !savedFiles.isEmpty()) {
						String savePath = savedFiles.get(0).getPath();

						// ── อัปเดต path_signature ใน User ────────────────────────────
						User u = userDAO.findById(onlineUser.getId());
						if (u != null) {
							u.setPathSignature(savePath);
							u.setTimeUpdate(now);
							userDAO.update(u);

							onlineUser.setPathSignature(savePath);
							request.getSession().setAttribute("onlineUser", onlineUser);
						}
					}

				} catch (Exception sigEx) {
					log.error("Error saving signature file", sigEx);
				}
			}

			return SUCCESS;

		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	// ===================== Helpers =====================
	private void saveAttachedFiles(java.io.File[] files, String[] filesFileName, String filesUploadFileName,
			String page, String pageId, String userId, Timestamp now) {
		if (files == null || files.length == 0)
			return;
		if (filesUploadFileName == null || filesUploadFileName.trim().isEmpty())
			return;
		try {
			String[] fileNames = new Gson().fromJson(filesUploadFileName, String[].class);
			if (fileNames == null)
				return;
			ServletContext ctx = ServletActionContext.getServletContext();
			String serverPath = ctx.getRealPath("/");

			for (int i = 0; i < files.length; i++) {
				fileAttachmentService.attach(
				Arrays.asList(files).subList(0, i),
				Arrays.asList(fileNames).subList(0, i),
				page,
				pageId,
				userId,
				serverPath
			);
				// if (i >= fileNames.length)
				// 	continue;
				// int maxFileId = fileuploadDAO.getMaxId() + 1;
				// String fileName = fileNames[i];
				// long fileSize = files[i].length();
				// int dotIdx = fileName.lastIndexOf('.');
				// String nameOnly = dotIdx > 0 ? fileName.substring(0, dotIdx) : fileName;
				// String ext = dotIdx > 0 ? fileName.substring(dotIdx) : "";
				// String saveName = maxFileId + "_" + fileName;
				// String savePath = "/upload/" + page + "/" + saveName;

				// FileUtil.upload(files[i], serverPath + "upload/" + page + "/", saveName);

				// FileUpload fu = new FileUpload();
				// fu.setFileId(maxFileId);
				// fu.setName(nameOnly);
				// fu.setType(ext);
				// fu.setPath(savePath);
				// fu.setSize(formatFileSize(fileSize));
				// fu.setPage(page);
				// fu.setPageId(pageId);
				// fu.setUserId(userId);
				// fu.setUserCreate(userId);
				// fu.setUserUpdate(userId);
				// fu.setTimeCreate(now);
				// fileuploadDAO.save(fu);
			}

			// เหมือน logic เดิม: ถ้าไฟล์มากกว่าชื่อไฟล์ที่ส่งมา ตัดไฟล์ส่วนเกินทิ้ง ไม่แนบ
			// int n = Math.min(files.length, fileNames.length);
			// String serverPath = ServletActionContext.getServletContext().getRealPath("/");

			// fileAttachmentService.attach(
			// 	Arrays.asList(files).subList(0, n),
			// 	Arrays.asList(fileNames).subList(0, n),
			// 	page,
			// 	pageId,
			// 	userId,
			// 	serverPath
			// );
		} catch (Exception e) {
			log.error("Error saving travel files", e);
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

	private void writeJson(String json, HttpServletResponse response) throws Exception {
		response.setContentType("application/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println(json);
		out.flush();
	}

	private Timestamp combineDateTime(String date, String time) {
		try {
			if (date == null || date.trim().isEmpty())
				return null;
			if (time == null || time.trim().isEmpty())
				time = "00:00";
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.ENGLISH);
			sdf.setLenient(false);
			return new Timestamp(sdf.parse(date.trim() + " " + time.trim() + ":00").getTime());
		} catch (Exception e) {
			return null;
		}
	}

	// ===================== Travel Approve =====================

	public String travelApproveList() {
		HttpServletRequest request = ServletActionContext.getRequest();
		try {
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			if (onlineUser == null)
				return ERROR;

			String userJSON = userDAO.userListJSON();

			List<Map<String, Object>> userListObj = userDAO.findUserActive();

			String status = request.getParameter("status");
			String userId = request.getParameter("userId");

			if (userId == null || userId.trim().isEmpty()) {
				userId = "all";
			}

			if (status == null || status.trim().isEmpty()) {
				status = "W";
			}

			// ── Date range ──────────────────────────────────────────────────────
			String dateRange = request.getParameter("dateRange");
			java.sql.Date dateFrom = null, dateTo = null;

			if (dateRange != null && !dateRange.trim().isEmpty()) {
				String[] parts = dateRange.trim().split("\\s+to\\s+");
				if (parts.length == 2) {
					try {
						if (!parts[0].trim().isEmpty())
							dateFrom = java.sql.Date.valueOf(parts[0].trim());
					} catch (Exception ignored) {
					}
					try {
						if (!parts[1].trim().isEmpty())
							dateTo = java.sql.Date.valueOf(parts[1].trim());
					} catch (Exception ignored) {
					}
				} else if (parts.length == 1) {
					dateFrom = java.sql.Date.valueOf(parts[0].trim());
					dateTo = java.sql.Date.valueOf(parts[0].trim());
				}
			}

			if (dateTo != null) {
				Calendar cal = Calendar.getInstance();
				cal.setTime(dateTo);
				cal.add(Calendar.DATE, 1);
				dateTo = new java.sql.Date(cal.getTimeInMillis());
			}

			// ── Page size ───────────────────────────────────────────────────────
			int pageSize = 25;
			String ps = request.getParameter("pageSize");
			if (ps != null && ps.trim().matches("\\d+")) {
				int v = Integer.parseInt(ps.trim());
				if (v == 50 || v == 100)
					pageSize = v;
			}

			// ── Current page ────────────────────────────────────────────────────
			int currentPage = 1;
			String pg = request.getParameter("page");
			if (pg != null && pg.trim().matches("\\d+")) {
				currentPage = Integer.parseInt(pg.trim());
				if (currentPage < 1)
					currentPage = 1;
			}

			int offset = (currentPage - 1) * pageSize;

			Map<String, Object> daoResult = expenseGroupDAO.findMyGroupsAndCountByStatus(status, userId, dateFrom,
					dateTo, offset, pageSize);

			List<Map<String, Object>> list = (List<Map<String, Object>>) daoResult.get("data");

			int total = (int) daoResult.get("total");

			int totalPages = Math.max(1, (int) Math.ceil(total / (double) pageSize));
			if (currentPage > totalPages)
				currentPage = totalPages;

			int fromIdx = total == 0 ? 0 : offset + 1;
			int toIdx = Math.min(offset + pageSize, total);

			setAttrs(request, userListObj, userJSON, status, list, currentPage, pageSize, total, totalPages, fromIdx,
					toIdx);

			request.setAttribute("viewMode", "group");

			Map<String, Integer> counts = expenseDAO.countMyTravelListAllStatus(userId, dateFrom, dateTo);

			if (counts == null) {
				counts = new HashMap<>();
			}

			int totalWaiting = counts.getOrDefault("W", 0);
			int totalApproved = counts.getOrDefault("A", 0);
			int totalRejected = counts.getOrDefault("R", 0);
			int totalCanceled = counts.getOrDefault("C", 0);
			int totalPaid = counts.getOrDefault("P", 0);

			request.setAttribute("total_status_waiting", totalWaiting);
			request.setAttribute("total_status_approved", totalApproved);
			request.setAttribute("total_status_rejected", totalRejected);
			request.setAttribute("total_status_canceled", totalCanceled);
			request.setAttribute("total_status_paid", totalPaid);

			return SUCCESS;

		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	// ===================== Travel Approve Preview =====================
	public String travelApprovePreview() {
		HttpServletRequest request = ServletActionContext.getRequest();
		try {
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			if (onlineUser == null)
				return ERROR;

			String[] ids = request.getParameterValues("ids");
			String expenseGroupIdStr = request.getParameter("expense_group_id");
			String status = request.getParameter("status");
			String userId = null;

			List<Long> expenseIds = new ArrayList<>();

			if (expenseGroupIdStr != null && !expenseGroupIdStr.isEmpty()) {
				long expenseGroupId = Long.parseLong(expenseGroupIdStr);
				List<Expense> expenseList = expenseDAO.findByGroupId(expenseGroupId);
				ExpenseGroup expenseGroup = expenseGroupDAO.findById(expenseGroupId);
				userId = expenseGroup.getUserId();
				String userApprId = expenseGroup.getAppr_user_id();

				if (userApprId != null && !userApprId.isEmpty()) {
					User user = userDAO.findById(userApprId);
					request.setAttribute("userAppr", user);
					request.setAttribute("approved_at", expenseGroup.getApproved_at());
				}

				request.setAttribute("requestAt", expenseGroup.getRequestedAt());

				request.setAttribute("expense_group_create_date", expenseGroup.getTimeCreate());
				request.setAttribute("description_appr", expenseGroup.getDescription_appr());

				for (Expense expense : expenseList) {
					expenseIds.add(expense.getExpenseId());
				}

				request.setAttribute("statusActiveSafe", status);
				request.setAttribute("expense_group_id", expenseGroupIdStr);
			}

			List<Map<String, Object>> expenseListObj = new ArrayList<>();
			BigDecimal grandTotal = BigDecimal.ZERO;

			for (Long expenseId : expenseIds) {
				Expense exp = expenseDAO.findById(expenseId);
				if (exp == null)
					continue;

				Map<String, Object> expMap = new HashMap<>();
				expMap.put("expense_id", exp.getExpenseId());
				expMap.put("expense_group_id", exp.getExpenseGroupId());
				expMap.put("dt_start",
						exp.getDtStart() != null ? new java.util.Date(exp.getDtStart().getTime()) : null);
				expMap.put("dt_end", exp.getDtEnd() != null ? new java.util.Date(exp.getDtEnd().getTime()) : null);
				expMap.put("from_location", exp.getFromLocation());
				expMap.put("to_location", exp.getToLocation());
				expMap.put("description", exp.getDescription());
				expMap.put("amount", exp.getAmount());
				expMap.put("time_create",
						exp.getTimeCreate() != null ? new java.util.Date(exp.getTimeCreate().getTime()) : null);

				// ── Details ──────────────────────────────────────────
				List<ExpenseDetail> details = expenseDetailDAO.findByExpenseId(expenseId);
				List<Map<String, Object>> detailMaps = new ArrayList<>();
				if (details != null) {
					for (ExpenseDetail det : details) {
						Map<String, Object> d = new HashMap<>();
						String typeName = "-";
						if (det.getGoBy() != null && det.getGoBy() > 0) {
							ExpTravelType ett = expTravelTypeDAO.findById(det.getGoBy());
							if (ett != null && ett.getName() != null)
								typeName = ett.getName();
						}
						d.put("travel_type_name", typeName);
						d.put("description", det.getDescription());
						d.put("total", det.getTotal());
						detailMaps.add(d);
					}
				}

				expMap.put("details", detailMaps);

				// ── Attached files ───────────────────────────────────
				List<FileUpload> fileList = fileuploadDAO.findByPageAndPageId("travelFiles", String.valueOf(expenseId));
				expMap.put("files", fileList != null ? fileList : new ArrayList<>());

				if (exp.getAmount() != null)
					grandTotal = grandTotal.add(exp.getAmount());
				expenseListObj.add(expMap);
			}

			// ── User ─────────────────────────────────────────────────
			User userObj = userDAO.findById(userId);

			request.setAttribute("expenseListObj", expenseListObj);
			request.setAttribute("userObj", userObj);
			request.setAttribute("grandTotal", grandTotal);
			request.setAttribute("selectedIds", ids != null ? Arrays.asList(ids) : java.util.Collections.emptyList());

			if (userObj != null) {
				String imgPathSignature = fileAttachmentService.getFileUrl(userObj.getPathSignature());
				if (imgPathSignature != null) {
					request.setAttribute("signaturePath", imgPathSignature);
				}
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

	// ===================== Travel Approve =====================
	public String travelApprove() {
		try {

			HttpServletRequest request = ServletActionContext.getRequest();
			String expenseGroupIdStr = request.getParameter("expense_group_id");
			String descriptionAppr = request.getParameter("description_appr");
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			if (onlineUser == null)
				return ERROR;

			Long expenseGroupId = Long.parseLong(expenseGroupIdStr);
			ExpenseGroup expense = expenseGroupDAO.findById(expenseGroupId);

			Timestamp now = DateUtil.getCurrentTime();
			expense.setStatusId("A");
			expense.setAppr_user_id(onlineUser.getId());
			expense.setApproved_at(now);
			expense.setDescription_appr(descriptionAppr == null || descriptionAppr.isEmpty() ? null : descriptionAppr);

			expenseGroupDAO.update(expense);

			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	// ===================== Travel Paid =====================
	public String travelPaid() {
		try {

			HttpServletRequest request = ServletActionContext.getRequest();
			String expenseGroupIdStr = request.getParameter("expense_group_id");
			String descriptionAppr = request.getParameter("description_appr");
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			if (onlineUser == null)
				return ERROR;

			Long expenseGroupId = Long.parseLong(expenseGroupIdStr);
			ExpenseGroup expense = expenseGroupDAO.findById(expenseGroupId);

			Timestamp now = DateUtil.getCurrentTime();
			Calendar cal = Calendar.getInstance();
			cal.setTime(now);

			if (expense.getStatusId().equals("W")) {
				// Waiting
				expense.setApproved_at(now);
				expense.setDescription_appr(
						descriptionAppr == null || descriptionAppr.isEmpty() ? null : descriptionAppr);
				expense.setAppr_user_id(onlineUser.getId());
			}

			expense.setStatusId("P");
			expense.setReceivedAt(now);

			short currentMonth = (short) (cal.get(Calendar.MONTH) + 1);
			Integer currentYear = cal.get(Calendar.YEAR);

			expense.setPaidMonth(currentMonth);
			expense.setPaidYear(currentYear);
			expenseGroupDAO.update(expense);

			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	// ===================== Travel Reject =====================
	public String travelReject() {
		try {

			HttpServletRequest request = ServletActionContext.getRequest();
			String expenseGroupIdStr = request.getParameter("expense_group_id");
			String descriptionAppr = request.getParameter("description_appr");
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			if (onlineUser == null)
				return ERROR;

			Long expenseGroupId = Long.parseLong(expenseGroupIdStr);
			ExpenseGroup expense = expenseGroupDAO.findById(expenseGroupId);

			Timestamp now = DateUtil.getCurrentTime();
			expense.setStatusId("R");
			expense.setAppr_user_id(onlineUser.getId());
			expense.setApproved_at(now);
			expense.setDescription_appr(descriptionAppr == null || descriptionAppr.isEmpty() ? null : descriptionAppr);

			expenseGroupDAO.update(expense);

			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	public String expenseTravelReport() {
		try {

			HttpServletRequest request = ServletActionContext.getRequest();
			HttpServletResponse response = ServletActionContext.getResponse();
			ServletContext context = request.getServletContext();
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			if (onlineUser == null) {
				return ERROR;
			}

			String expenseGroupIdStr = request.getParameter("expense_group_id");
			String jasperPath = context.getRealPath(JASPERPATH);
			String imagePath = context.getRealPath(IMAGEPATH);

			String basePath = context.getRealPath("");

			Map<String, Object> reportParameter = new HashMap<>();

			File logo = new File(imagePath + "/logo_cubesofttech.png");

			BufferedImage image = ImageIO.read(logo);

			reportParameter.put(LOGOPATH, image);
			reportParameter.put("basePath", basePath);
			reportParameter.put("expenseGroupId", expenseGroupIdStr);

			ExpenseGroup expenseGroup = expenseGroupDAO.findById(Long.parseLong(expenseGroupIdStr));

			// เช็คว่ามีตารางลูกไหม
			if (expenseGroup.getRequestedBy() == null) {
				ReportUtil.printReportToBrowsePdf(jasperPath, "/expTravel", "expTravel.pdf", reportParameter, request,
						response);
			} else {
				ReportUtil.printReportToBrowsePdf(jasperPath, "/expTravelNew", "expTravel.pdf", reportParameter,
						request, response);
			}

			return null;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	// ============== Travel Setting =============

	public String travelSettingList() {

		HttpServletRequest request = ServletActionContext.getRequest();
		try {
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			if (onlineUser == null) {
				return ERROR;
			}

			List<ExpTravelType> expTravelTypes = expTravelTypeDAO.findAll();

			// หา count ของ expense ที่ใช้ go by แต่ละ type
			Map<Long, Integer> expTravelTypeCountMap = expTravelTypeDAO.getCountUseType();

			request.setAttribute("travelTypeList", expTravelTypes);
			request.setAttribute("expTravelTypeCountMap", expTravelTypeCountMap);

			return SUCCESS;

		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}

	}

	// ============== Travel Setting Delete =============
	public String travelSettingDelete() {

		try {
			HttpServletRequest request = ServletActionContext.getRequest();
			String typeIdStr = request.getParameter("typeId");

			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			if (onlineUser == null) {
				return ERROR;
			}

			Long typeIdLong = typeIdStr == null || typeIdStr.isEmpty() ? null : Long.parseLong(typeIdStr);

			ExpTravelType expTravelTypes = expTravelTypeDAO.findById(typeIdLong);

			expTravelTypeDAO.delete(expTravelTypes);

			return SUCCESS;

		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}

	}

	// ============== Travel Setting Add =============
	public String travelSettingAdd() {

	    try {

	        HttpServletRequest request = ServletActionContext.getRequest();

	        String typeDescription = request.getParameter("typeDescription");
	        String typeName = request.getParameter("typeName");
	        String typeActive = request.getParameter("typeActive");

	        // trim กัน space
	        typeName = typeName == null ? "" : typeName.trim();

	        // convert active
	        if ("on".equals(typeActive)) {
	            typeActive = "1";
	        } else {
	            typeActive = "0";
	        }

	        User onlineUser =
	                (User) request.getSession().getAttribute("onlineUser");

	        if (onlineUser == null) {

	            return ERROR;
	        }
	   

	        // ================= CHECK DUPLICATE =================
	        boolean isDuplicate =
	                expTravelTypeDAO.checkDuplicateName(typeName);

	        if (isDuplicate) {

	            status = "duplicate";

	            return SUCCESS;
	        }
	        
	    

	        // ================= SAVE =================
	        ExpTravelType newExpTravelType = new ExpTravelType();

	        Timestamp now = DateUtil.getCurrentTime();

	        newExpTravelType.setExpTravelTypeId(
	                expTravelTypeDAO.getMaxId() + 1);

	        newExpTravelType.setName(typeName);

	        newExpTravelType.setDescription(
	                typeDescription == null || typeDescription.isEmpty()
	                        ? null
	                        : typeDescription);

	        newExpTravelType.setActive(typeActive);

	        newExpTravelType.setTimeCreate(now);
	        newExpTravelType.setTimeUpdate(now);

	        newExpTravelType.setUserCreate(onlineUser.getId());
	        newExpTravelType.setUserUpdate(onlineUser.getId());

	        expTravelTypeDAO.save(newExpTravelType);

	        status = "success";

	        return SUCCESS;

	    } catch (Exception e) {

	        return ERROR;
	    }
	}

	// ============== Travel Setting Edit =============
	public String travelSettingEdit() {

		try {
			HttpServletRequest request = ServletActionContext.getRequest();
			String typeId = request.getParameter("typeId");

			Long typeIdLong = typeId == null || typeId.isEmpty() ? null : Long.parseLong(typeId);

			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			if (onlineUser == null) {
				return ERROR;
			}

			ExpTravelType expTravelType = expTravelTypeDAO.findById(typeIdLong);

			jsonData = new HashMap<>();

			jsonData.put("expTravelTypeId", expTravelType.getExpTravelTypeId());
			jsonData.put("name", expTravelType.getName());
			jsonData.put("description", expTravelType.getDescription());
			jsonData.put("active", expTravelType.getActive());

			return SUCCESS;

		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	// ============== Travel Setting Update =============
	public String travelSettingUpdate() {

		try {
			HttpServletRequest request = ServletActionContext.getRequest();
			String typeId = request.getParameter("typeId");
			String typeDescription = request.getParameter("typeDescription");
			String typeName = request.getParameter("typeName");
			String typeActive = request.getParameter("typeActive");

			Long typeIdLong = typeId == null || typeId.isEmpty() ? null : Long.parseLong(typeId);

			if ("on".equals(typeActive)) {
				typeActive = "1";
			} else {
				typeActive = "0";
			}

			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			if (onlineUser == null) {
				return ERROR;
			}

			ExpTravelType expTravelType = expTravelTypeDAO.findById(typeIdLong);
			Timestamp now = DateUtil.getCurrentTime();

			expTravelType.setName(typeName);
			expTravelType.setDescription(typeDescription == null || typeDescription.isEmpty() ? null : typeDescription);
			expTravelType.setActive(typeActive);
			expTravelType.setTimeUpdate(now);
			expTravelType.setUserUpdate(onlineUser.getId());

			expTravelTypeDAO.update(expTravelType);

			return SUCCESS;

		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}

	}
}