<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page
	import="java.util.*, com.google.gson.Gson, com.google.gson.reflect.TypeToken, java.lang.reflect.Type"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.text.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<fmt:setLocale value="en_US" />
<%
/* =========================
   1) รับ JSON จาก eBorrowEdit
   ========================= */
String userJson = (String) request.getAttribute("userList");
String equipJson = (String) request.getAttribute("equipments");
String statusJson = (String) request.getAttribute("status");
String borrowJson = (String) request.getAttribute("borrow");

Gson gson = new Gson();

Type listMapType = new TypeToken<List<Map<String, Object>>>() {
}.getType();
Type mapType = new TypeToken<Map<String, Object>>() {
}.getType();

List<Map<String, Object>> userListObj = (userJson != null) ? gson.fromJson(userJson, listMapType) : new ArrayList<>();
List<Map<String, Object>> equipmentsObj = (equipJson != null)
		? gson.fromJson(equipJson, listMapType)
		: new ArrayList<>();
List<Map<String, Object>> statusObj = (statusJson != null) ? gson.fromJson(statusJson, listMapType) : new ArrayList<>();
Map<String, Object> borrowObj = (borrowJson != null) ? gson.fromJson(borrowJson, mapType) : new HashMap<>();

request.setAttribute("userListObj", userListObj);
request.setAttribute("equipmentsObj", equipmentsObj);
request.setAttribute("statusObj", statusObj);
request.setAttribute("borrowObj", borrowObj);
%>

<%!/* ===== Helper: normalize id ให้เทียบกันได้ (กันเคส 90.0 จาก Gson/DB) ===== */
	private String normId2(Object o) {
		if (o == null)
			return "";
		String s = String.valueOf(o).trim();
		if (s.isEmpty() || "null".equalsIgnoreCase(s))
			return "";

		try {
			double d = Double.parseDouble(s);
			long L = (long) d;
			if (Math.abs(d - L) < 0.0000001)
				return String.valueOf(L);
		} catch (Exception ignore) {
		}

		return s;
	}%>

<%
String _borrowLocation = "";
if (borrowObj != null) {
	Object _loc = borrowObj.get("location");
	if (_loc != null)
		_borrowLocation = String.valueOf(_loc).trim();
}
request.setAttribute("borrowLocation", _borrowLocation);

String _equipIdStr = "";
if (borrowObj != null) {
	Object _eid = borrowObj.get("equipmentId");
	if (_eid == null)
		_eid = borrowObj.get("equipment_id");
	_equipIdStr = normId2(_eid);
}
request.setAttribute("equipIdStr", _equipIdStr);

// 3.2 หา equip ตัวเดียวใน equipmentsObj
Map<String, Object> _equip = null;
if (equipmentsObj != null && _equipIdStr != null && !_equipIdStr.isEmpty()) {
	for (Map<String, Object> e : equipmentsObj) {
		Object _id1 = e.get("equipmentId");
		if (_id1 == null)
	_id1 = e.get("equipment_id");
		String _eIdStr = normId2(_id1);
		if (_equipIdStr.equals(_eIdStr)) {
	_equip = e;
	break;
		}
	}
}
request.setAttribute("equip", _equip);

// 3.3 ดึง raw status_log จาก equip (ตาราง equipment)
String _rawStatusLog = "";
if (_equip != null) {
	Object _rawObj = _equip.get("statusLog");
	if (_rawObj == null)
		_rawObj = _equip.get("status_log");
	if (_rawObj == null)
		_rawObj = _equip.get("STATUS_LOG");
	_rawStatusLog = (_rawObj == null) ? "" : String.valueOf(_rawObj);
}
request.setAttribute("RAW_STATUS_LOG", _rawStatusLog);

// 3.4 parse JSON array -> statusLogList
List<Map<String, Object>> _statusLogList = new ArrayList<>();
String _statusLogParseError = null;

try {
	String raw = (_rawStatusLog == null) ? "" : _rawStatusLog.trim();

	if (!raw.isEmpty() && !"null".equalsIgnoreCase(raw)) {
		Gson _gsonn = new Gson();

		// เคส: เก็บเป็น "...." (JSON string ครอบอีกชั้น)
		if ((raw.startsWith("\"") && raw.endsWith("\"")) || (raw.startsWith("'") && raw.endsWith("'"))) {
	raw = _gsonn.fromJson(raw, String.class);
	if (raw != null)
		raw = raw.trim();
		}

		// เคส: มี escape \" เยอะๆ เช่น [{\"userUpdate\":\"x\"}]
		if (raw != null && raw.contains("\\\""))
	raw = raw.replace("\\\"", "\"");
		if (raw != null && raw.contains("\\\\"))
	raw = raw.replace("\\\\", "\\");

		Type statusLogListType = new TypeToken<List<Map<String, Object>>>() {
		}.getType();

		// ใช้ gson เดิมของหน้า ถ้ามี; ถ้าไม่มีให้ fallback เป็น _gsonn
		Gson _useGson = (gson != null) ? gson : _gsonn;

		List<Map<String, Object>> parsed = _useGson.fromJson(raw, statusLogListType);
		if (parsed != null)
	_statusLogList = parsed;
	}
} catch (Exception ex) {
	_statusLogParseError = ex.toString();
}

try {
	final java.text.SimpleDateFormat[] fms = new java.text.SimpleDateFormat[]{
	new java.text.SimpleDateFormat("MMM d, yyyy, h:mm:ss a", java.util.Locale.ENGLISH),
	new java.text.SimpleDateFormat("MMM dd, yyyy, h:mm:ss a", java.util.Locale.ENGLISH),
	new java.text.SimpleDateFormat("MMM d, yyyy, h:mm a", java.util.Locale.ENGLISH),
	new java.text.SimpleDateFormat("MMM dd, yyyy, h:mm a", java.util.Locale.ENGLISH),

	new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", java.util.Locale.ENGLISH),
	new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S", java.util.Locale.ENGLISH),
	new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SS", java.util.Locale.ENGLISH),
	new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS", java.util.Locale.ENGLISH),

	new java.text.SimpleDateFormat("yyyy/MM/dd HH:mm:ss", java.util.Locale.ENGLISH),
	new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss", java.util.Locale.ENGLISH),
	new java.text.SimpleDateFormat("dd-MM-yyyy HH:mm:ss", java.util.Locale.ENGLISH),

	new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm", java.util.Locale.ENGLISH),
	new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm", java.util.Locale.ENGLISH),
	new java.text.SimpleDateFormat("dd-MM-yyyy HH:mm", java.util.Locale.ENGLISH),

	new java.text.SimpleDateFormat("yyyy-MM-dd", java.util.Locale.ENGLISH),
	new java.text.SimpleDateFormat("dd/MM/yyyy", java.util.Locale.ENGLISH),
	new java.text.SimpleDateFormat("dd-MM-yyyy", java.util.Locale.ENGLISH)};
	for (java.text.SimpleDateFormat fm : fms)
		fm.setLenient(true);

	java.util.Collections.sort(_statusLogList, new java.util.Comparator<Map<String, Object>>() {
		private long toMillis(Object o) {
	if (o == null)
		return 0L;

	String t = String.valueOf(o).trim();
	if (t.isEmpty() || "null".equalsIgnoreCase(t))
		return 0L;

	if (t.startsWith("[") && t.endsWith("]"))
		t = t.substring(1, t.length() - 1).trim();
	t = t.replace("T", " ");
	if (t.endsWith("Z"))
		t = t.substring(0, t.length() - 1).trim();
	t = t.replace('\u202F', ' ').replace('\u00A0', ' ').trim();
	t = t.replaceAll(" +", " ");

	java.util.Date d = null;
	for (java.text.SimpleDateFormat fm : fms) {
		try {
			d = fm.parse(t);
			break;
		} catch (Exception ignore) {
		}
	}
	if (d == null)
		return 0L;

	java.util.Calendar cal = java.util.Calendar.getInstance(java.util.Locale.ENGLISH);
	cal.setTime(d);
	int year = cal.get(java.util.Calendar.YEAR);
	if (year >= 2500) { // กันปี พ.ศ.
		cal.add(java.util.Calendar.YEAR, -543);
		d = cal.getTime();
	}
	return d.getTime();
		}

		@Override
		public int compare(Map<String, Object> a, Map<String, Object> b) {
	Object ta = (a != null) ? a.get("timeUpdate") : null;
	Object tb = (b != null) ? b.get("timeUpdate") : null;

	long ma = toMillis(ta);
	long mb = toMillis(tb);

	return Long.compare(mb, ma);
		}
	});
} catch (Exception ignoreSort) {
}

request.setAttribute("statusLogList", _statusLogList);
request.setAttribute("statusLogParseError", _statusLogParseError);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />

<link
	href="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.css"
	rel="stylesheet" type="text/css" />
<script
	src="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.js"></script>

<link
	href="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.css"
	rel="stylesheet" type="text/css" />
<script
	src="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.js"></script>
<script
	src="${pageContext.request.contextPath}/assets/js/scripts.bundle.js"></script>
<style>
/* Light Mode */
[data-bs-theme="light"] #kt_table.table.table-striped>tbody>tr:nth-of-type(odd)>*
	{
	background-color: #FBFBFB !important;
	box-shadow: none !important;
}

[data-bs-theme="light"] #kt_table.table-hover tbody tr:hover>*, [data-bs-theme="light"] #kt_table.dataTable>tbody>tr:hover>*
	{
	background-color: #F9F9F9 !important;
	box-shadow: none !important;
	transition: background-color .15s ease-in-out;
}

/* Dark Mode */
[data-bs-theme="dark"] #kt_table.table.table-striped>tbody>tr:nth-of-type(odd)>*
	{
	background-color: #191B20 !important;
	box-shadow: none !important;
}

[data-bs-theme="dark"] #kt_table.table.table-striped>tbody>tr:nth-of-type(even)>*
	{
	background-color: #15171C !important;
	box-shadow: none !important;
}

[data-bs-theme="dark"] #kt_table.table-hover tbody tr:hover>*, [data-bs-theme="dark"] #kt_table.dataTable>tbody>tr:hover>*
	{
	background-color: #1B1C22 !important;
	box-shadow: none !important;
	transition: background-color .15s ease-in-out;
}

.rotate-180 {
	transform: rotate(180deg);
}
</style>

</head>
<body>

	<!-- =========================
     2) ตั้งค่า id ต่างๆ ด้วย JSTL (fallback key)
     ========================= -->
	<c:set var="borrowerId" value="" />
	<c:choose>
		<c:when test="${not empty borrowObj['userBorrowid']}">
			<c:set var="borrowerId" value="${borrowObj['userBorrowid']}" />
		</c:when>
		<c:otherwise>
			<c:set var="borrowerId" value="${borrowObj['user_borrowid']}" />
		</c:otherwise>
	</c:choose>

	<c:set var="equipId" value="" />
	<c:choose>
		<c:when test="${not empty borrowObj['equipmentId']}">
			<c:set var="equipId" value="${borrowObj['equipmentId']}" />
		</c:when>
		<c:otherwise>
			<c:set var="equipId" value="${borrowObj['equipment_id']}" />
		</c:otherwise>
	</c:choose>

	<c:set var="statusCode" value="" />
	<c:choose>
		<c:when test="${not empty borrowObj['status']}">
			<c:set var="statusCode" value="${borrowObj['status']}" />
		</c:when>
		<c:when test="${not empty borrowObj['statusborrow']}">
			<c:set var="statusCode" value="${borrowObj['statusborrow']}" />
		</c:when>
		<c:otherwise>
			<c:set var="statusCode" value="${borrowObj['status_code']}" />
		</c:otherwise>
	</c:choose>

	<c:set var="locationVal" value="${borrowObj['location']}" />

	<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
		<div class="d-flex flex-column flex-column-fluid">

			<!-- Toolbar -->
			<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
				<div id="kt_app_toolbar_container"
					class="app-container container-fluid d-flex align-items-center justify-content-start">
					<div
						class="page-title d-flex flex-column flex-wrap me-3 align-items-start">
						<h1 class="page-heading fw-semibold my-0 text-start"
							style="color: #4b5675;">Borrow Detail</h1>
						<ul
							class="breadcrumb breadcrumb-separatorless fw-medium fs-7 my-0 pt-1">
							<li class="breadcrumb-item text-muted"><a
								href="${pageContext.request.contextPath}/demo_dashboard"
								class="text-muted text-hover-primary">Home</a></li>
							<li class="breadcrumb-item"><span
								class="bullet bg-gray-500 w-4px h-1px"></span></li>
							<li class="breadcrumb-item text-muted"><a
								href="${pageContext.request.contextPath}/borrow_list"
								class="text-muted text-hover-primary">Borrow</a></li>
							<li class="breadcrumb-item"><span
								class="bullet bg-gray-500 w-4px h-1px"></span></li>
							<li class="breadcrumb-item text-muted">Borrow Detail</li>
						</ul>
					</div>
				</div>
			</div>
			<!-- end Toolbar -->

			<div id="kt_app_content" class="app-content flex-column-fluid">
				<div id="kt_app_content_container"
					class="app-container container-fluid">

					<div class="row g-5 g-xl-10">

						<!-- LEFT : FORM -->
						<div class="col-xl-8">
							<form
								action="${pageContext.request.contextPath}/eBorrowUpdate.action"
								method="post" class="card h-xl-100 shadow-none">
								<input type="hidden" name="id" value="${sessionScope.bId}" />
								<div class="card-header py-4"
									style="border-bottom: 1px solid #E4E6EF;">
									<h3 class="card-title fw-bold mb-0">Borrow Equipment</h3>
								</div>

								<div class="card-body pt-6">

									<!-- Borrower (ดึงทั้งหมด + c:if เลือก selected) -->
									<div class="mb-7">
										<label class="form-label required fw-medium">Borrower</label>

										<select name="user"
											class="form-select form-select-lg fw-medium"
											data-control="select2" data-placeholder="Select Borrower"
											data-hide-search="true">

											<c:forEach var="u" items="${userListObj}">
												<c:set var="uid"
													value="${not empty u['id'] ? u['id'] : (not empty u['user_id'] ? u['user_id'] : u['USER_ID'])}" />

												<c:set var="employeeId"
													value="${not empty u['employee_id'] ? u['employee_id'] : (not empty u['employeeId'] ? u['employeeId'] : u['EMPLOYEE_ID'])}" />
												<c:set var="nameTh"
													value="${not empty u['name'] ? u['name'] : (not empty u['fullname'] ? u['fullname'] : u['USER_NAME'])}" />
												<c:set var="nameEn"
													value="${not empty u['name_en'] ? u['name_en'] : (not empty u['nameEn'] ? u['nameEn'] : u['NAME_EN'])}" />
												<c:set var="roleId"
													value="${not empty u['role_id'] ? u['role_id'] : (not empty u['roleId'] ? u['roleId'] : u['role'])}" />

												<option value="${uid}"
													<c:if test="${fn:trim(uid) == fn:trim(borrowerId)}">selected</c:if>>
													<c:out value="${empty employeeId ? '-' : employeeId}" />&nbsp;&nbsp;-&nbsp;&nbsp;
													<c:out value="${empty nameTh ? '-' : nameTh}" />&nbsp;&nbsp;-&nbsp;&nbsp;
													<c:out value="${empty nameEn ? '-' : nameEn}" />&nbsp;&nbsp;-&nbsp;&nbsp;
													<c:out value="${empty roleId ? '-' : roleId}" />
												</option>
											</c:forEach>

										</select>
									</div>

									<!-- Status (label อยู่บน / select อยู่ล่าง) -->
									<div class="mb-7">
										<label class="required fw-semibold fs-6 mb-2 d-block">Status</label>

										<select name="status" class="form-select form-select-lg"
											required>
											<option value="">-- Select status --</option>

											<c:forEach var="s" items="${statusObj}">
												<!-- filter เอาเฉพาะ B / C / W -->
												<c:if
													test="${s.statusId == 'B' or s.statusId == 'C' or s.statusId == 'W'}">
													<option value="${s.statusId}"
														<c:if test="${s.statusId == statusCode}">selected</c:if>>
														<!-- จะโชว์ description เดิม หรือจะกำหนดข้อความเองก็ได้ -->
														<c:choose>
															<c:when test="${s.statusId == 'B'}">Borrowing</c:when>
															<c:when test="${s.statusId == 'C'}">Cancel</c:when>
															<c:when test="${s.statusId == 'W'}">Wait for Approve</c:when>
														</c:choose>
													</option>
												</c:if>
											</c:forEach>
										</select>
									</div>

									<!-- Equipment (label อยู่บน / select อยู่ล่าง) -->
									<div class="mb-7">
										<label class="required fw-semibold fs-6 mb-2 d-block">Equipment</label>

										<select
											class="form-select form-select-lg fw-medium text-muted"
											required disabled>
											<option value="">-- Select equipment --</option>

											<c:forEach var="e" items="${equipmentsObj}">
												<option value="${e.equipmentId}"
													<c:if test="${e.equipmentId == equipId}">selected</c:if>>
													<c:out value="${e.itemNo}" /> -
													<c:out value="${e.name}" />
												</option>
											</c:forEach>
										</select> <input type="hidden" name="equipment" value="${equipId}" />
									</div>

									<!-- Start / End Date -->
									<div class="row mb-7">
										<div class="col-lg-6">
											<label class="form-label required fw-semibold fs-6">Start
												Date</label>
											<div class="position-relative d-flex align-items-center">
												<i
													class="ki-outline ki-calendar fs-3 position-absolute ms-4"></i>
												<input type="text" id="start_date"
													class="form-control form-control-lg ps-12" name="date_from"
													placeholder="Select Date" value="${borrowObj['dateStart']}"
													autocomplete="off" required />
											</div>
										</div>

										<div class="col-lg-6">
											<label class="form-label required fw-semibold fs-6">End
												Date</label>
											<div class="position-relative d-flex align-items-center">
												<i
													class="ki-outline ki-calendar fs-3 position-absolute ms-4"></i>
												<input type="text" id="end_date"
													class="form-control form-control-lg ps-12" name="date_to"
													placeholder="Select Date" value="${borrowObj['dateEnd']}"
													autocomplete="off" required />
											</div>
										</div>
									</div>

									<!-- Location (label อยู่บน / ช่องอยู่ล่าง) -->
									<div class="mb-7">
										<label class="required fw-semibold fs-6 mb-2 d-block">Location</label>

										<input class="form-control form-control-lg" type="text"
											name="location" value="${locationVal}" />

									</div>

									<!-- Reason -->
									<div class="mb-7">
										<label class="fw-semibold fs-6 mb-2 d-block">Reason</label>
										<textarea class="form-control form-control-lg" rows="4"
											name="reason" placeholder="ระบุเหตุผลการยืม"><c:out
												value="${borrowObj['reason']}" /></textarea>
									</div>

									<!-- Contact Address (ทำเป็น textarea ด้วย) -->
									<div class="mb-7">
										<label class="fw-semibold fs-6 mb-2 d-block">Contact
											Address</label>
										<textarea class="form-control form-control-lg" rows="4"
											name="contact" placeholder="Address"><c:out
												value="${borrowObj['contactAddr']}" /></textarea>
									</div>

									<!-- Remark -->
									<div class="mb-7">
										<label class="fw-semibold fs-6 mb-2 d-block">Remark</label>
										<textarea class="form-control form-control-lg" rows="4"
											name="remark" placeholder="Remark"><c:out
												value="${borrowObj['remark']}" /></textarea>
									</div>
								</div>

								<div class="card-footer d-flex justify-content-end">
									<a href="${pageContext.request.contextPath}/borrow_list"
										class="btn btn-light me-3">Cancel</a>
									<button type="submit" class="btn btn-success">
										<span class="indicator-label">Save</span>
									</button>
								</div>

							</form>
						</div>

						<!-- RIGHT : (ของเดิมคุณ) -->
						<div class="col-xl-4">

							<!-- ================== Equipment Detail Card ================== -->
							<div class="card mb-5">

								<div class="card-header border-0 pt-6">
									<div
										class="card-title d-flex justify-content-between align-items-center w-100">
										<span class="fw-bold fs-4 me-2">Equipment Detail</span>
									</div>
								</div>

								<div class="card-body pt-0">

									<!-- หา equipment ตัวเดียวที่ตรงกับ equipId -->
									<c:set var="equip" value="${null}" />
									<c:forEach var="e" items="${equipmentsObj}">
										<c:if
											test="${e.equipmentId == equipId || e.equipment_id == equipId}">
											<c:set var="equip" value="${e}" />
										</c:if>
									</c:forEach>

									<!-- ===== TOP: ITEM NO + BADGE + IMAGE ===== -->
									<div class="mb-4 d-flex flex-column align-items-start">

										<div
											class="mb-3 d-flex justify-content-between align-items-center w-100">
											<span class="fw-bold fs-1 text-primary"> <c:out
													value="${equip.itemNo}" />
											</span> <span> <c:choose>
													<c:when test="${equip.status == 'B'}">
														<span
															class="badge badge-lg px-4 fw-semibold bg-primary text-white">Borrowing</span>
													</c:when>
													<c:when test="${equip.status == 'A'}">
														<span
															class="badge badge-lg px-4 fw-semibold bg-success text-white">Available</span>
													</c:when>
													<c:when test="${equip.status == 'C'}">
														<span
															class="badge badge-lg px-4 fw-semibold bg-danger text-white">Corrupted</span>
													</c:when>
													<c:when test="${equip.status == 'F'}">
														<span
															class="badge badge-lg px-4 fw-semibold bg-info text-white">Fixed</span>
													</c:when>
													<c:when test="${equip.status == 'L'}">
														<span
															class="badge badge-lg px-4 fw-semibold bg-dark text-white">Lost</span>
													</c:when>
													<c:when test="${equip.status == 'S'}">
														<span
															class="badge badge-lg px-4 fw-semibold bg-warning text-dark">Sold
															Out</span>
													</c:when>
													<c:when test="${equip.status == 'W'}">
														<span
															class="badge badge-lg px-4 fw-semibold bg-warning text-dark">Wait
															for approve</span>
													</c:when>
													<c:when test="${equip.status == 'Z'}">
														<span
															class="badge badge-lg px-4 fw-semibold bg-secondary text-white">Disabled</span>
													</c:when>
													<c:otherwise>
														<span
															class="badge badge-lg px-4 fw-semibold bg-light text-gray-700">-</span>
													</c:otherwise>
												</c:choose>
											</span>
										</div>

										<!-- รูปชิดซ้ายใต้ ID -->
										<div class="symbol symbol-150px">
											<img src="${pageContext.request.contextPath}${equip.image}"
												alt="${equip.code}" class="border rounded-3" />
										</div>
									</div>

									<!-- ===== ROW STYLE: label ซ้าย (กว้างคงที่) / value อยู่ถัดมา (ไม่ชิดขวา) ===== -->
									<div class="d-flex py-2">
										<div class="text-gray-500" style="min-width: 130px;">Name:</div>
										<div class="fw-semibold text-gray-800 text-break">
											<c:out value="${equip.name}" />
										</div>
									</div>

									<div class="d-flex py-2">
										<div class="text-gray-500" style="min-width: 130px;">Type:</div>
										<div
											class="fw-semibold text-gray-800 d-flex align-items-center gap-2 text-break">
											<c:choose>
												<c:when test="${equip.type == 'c'}">
            Computer
            <i class="ki-duotone ki-laptop fs-4 text-gray-600"><span
														class="path1"></span><span class="path2"></span></i>
												</c:when>
												<c:when test="${equip.type == 'in'}">
            Instument
            <i class="ki-duotone ki-keyboard fs-4 text-gray-600"><span
														class="path1"></span><span class="path2"></span></i>
												</c:when>
												<c:when test="${equip.type == 'L' || equip.type == 'sl'}">
            Software License
            <i class="ki-duotone ki-verify fs-4 text-gray-600"><span
														class="path1"></span><span class="path2"></span></i>
												</c:when>
												<c:when test="${equip.type == 'Mob'}">
            Mobile
            <i class="ki-duotone ki-phone fs-4 text-gray-600"><span
														class="path1"></span><span class="path2"></span></i>
												</c:when>
												<c:when test="${equip.type == 'p'}">
            Pocket Wifi
            <i class="ki-duotone ki-wifi-square fs-4 text-gray-600"><span
														class="path1"></span><span class="path2"></span><span
														class="path3"></span><span class="path4"></span></i>
												</c:when>
												<c:otherwise>
            Other
            <i class="ki-duotone ki-dots-square fs-4 text-gray-600"><span
														class="path1"></span><span class="path2"></span><span
														class="path3"></span><span class="path4"></span></i>
												</c:otherwise>
											</c:choose>
										</div>
									</div>

									<div class="d-flex py-2">
										<div class="text-gray-500" style="min-width: 130px;">Serial
											No:</div>
										<div class="fw-semibold text-gray-800 text-break">
											<c:out value="${equip.serialNo}" />
										</div>
									</div>

									<div class="d-flex py-2">
										<div class="text-gray-500" style="min-width: 130px;">Amount:</div>
										<div class="fw-semibold text-gray-800">
											<fmt:formatNumber value="${equip.amount}" pattern="#" />
										</div>
									</div>

									<div class="d-flex py-2">
										<div class="text-gray-500" style="min-width: 130px;">Date
											of Purchase:</div>
										<div class="fw-semibold text-gray-800 text-break">
											<c:set var="RAW_TC_OBJ" value="${equip.timeCreate}"
												scope="page" />
											<%
											Object tcObj = pageContext.getAttribute("RAW_TC_OBJ");
											String raww = (tcObj == null) ? "" : String.valueOf(tcObj);
											String cleaned = raww.replace('\u00A0', ' ').replace('\u202F', ' ').trim();
											java.util.Date parsed = null;

											if (tcObj instanceof java.util.Date) {
												parsed = (java.util.Date) tcObj;
											} else {
												String[] patterns = new String[]{"MMM d, yyyy, h:mm:ss a", "MMM dd, yyyy, h:mm:ss a", "MMM d, yyyy h:mm:ss a",
												"yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd HH:mm:ss.S", "yyyy-MM-dd HH:mm:ss.SSS"};
												for (String p : patterns) {
													try {
												java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(p, java.util.Locale.US);
												sdf.setLenient(true);
												parsed = sdf.parse(cleaned);
												break;
													} catch (Exception ex) {
													}
												}
											}

											String display = (parsed != null)
													? new java.text.SimpleDateFormat("MMM dd , yyyy", java.util.Locale.ENGLISH).format(parsed)
													: raww;

											pageContext.setAttribute("PURCHASE_DISPLAY", display);
											%>
											<c:out value="${PURCHASE_DISPLAY}" />
										</div>
									</div>

									<div class="d-flex py-2">
										<div class="text-gray-500" style="min-width: 130px;">Detail:</div>
										<div class="fw-semibold text-gray-800 text-break">
											<c:out value="${equip.detail}" />
										</div>
									</div>

									<c:if test="${equip.type == 'c'}">

										<div class="border-top mt-4 pt-3">

											<!-- ใช้ button แทน a เพื่อให้ toggle ปิด/เปิดชัวร์ -->
											<button type="button"
												class="btn btn-link p-0 w-100 text-primary fw-semibold d-flex justify-content-between align-items-center"
												data-collapse-target="#moreDetailCollapse_${equipId}"
												aria-expanded="false"
												aria-controls="moreDetailCollapse_${equipId}">
												<span>More Detail</span> <i
													class="ki-duotone ki-down fs-3" id="icon_${equipId}"
													style="transition: transform .2s ease;"> <span
													class="path1"></span><span class="path2"></span>
												</i>
											</button>

											<div class="collapse mt-3" id="moreDetailCollapse_${equipId}"
												data-equip-id="${equipId}">

												<div class="d-flex py-2">
													<div class="text-gray-500" style="min-width: 130px;">Windows</div>
													<div class="fw-semibold text-gray-800 text-break">
														<c:out value="${equip.windows}" />
													</div>
												</div>

												<div class="d-flex py-2">
													<div class="text-gray-500" style="min-width: 130px;">CPU</div>
													<div class="fw-semibold text-gray-800 text-break">
														<c:out value="${equip.process}" />
													</div>
												</div>

												<div class="d-flex py-2">
													<div class="text-gray-500" style="min-width: 130px;">Ram</div>
													<div class="fw-semibold text-gray-800 text-break">
														<c:out value="${equip.ram}" />
													</div>
												</div>

												<div class="d-flex py-2">
													<div class="text-gray-500" style="min-width: 130px;">Storage</div>
													<div class="fw-semibold text-gray-800 text-break">
														<c:out value="${equip.hdd}" />
													</div>
												</div>

												<div class="d-flex py-2">
													<div class="text-gray-500" style="min-width: 130px;">Battery</div>
													<div class="fw-semibold text-gray-800 text-break">
														<c:out value="${equip.battery}" />
													</div>
												</div>

												<div class="d-flex py-2">
													<div class="text-gray-500" style="min-width: 130px;">WIFI
														Address</div>
													<div class="fw-semibold text-gray-800 text-break">
														<c:out value="${equip.wifiaddress}" />
													</div>
												</div>

												<div class="d-flex py-2">
													<div class="text-gray-500" style="min-width: 130px;">LAN
														Address</div>
													<div class="fw-semibold text-gray-800 text-break">
														<c:out value="${equip.lanaddress}" />
													</div>
												</div>

												<div class="d-flex py-2">
													<div class="text-gray-500" style="min-width: 130px;">Display</div>
													<div class="fw-semibold text-gray-800 text-break">
														<c:out value="${equip.display}" />
													</div>
												</div>

											</div>
										</div>
									</c:if>

								</div>
							</div>

							<!-- Status Log -->
							<div class="card">
								<div class="card-header border-0 pt-6">
									<div class="card-title">
										<span class="fw-bold fs-5">Status Log</span>
									</div>

									<div class="card-toolbar">
										<c:if test="${equip.status == 'B' || equip.status == 'b'}">
											<a href="#"
												class="btn btn-sm btn-warning btn-open-return-modal"
												data-borrow-id="${param.id}" data-item-no="${equip.itemNo}"
												data-name="${equip.name}" data-serial="${equip.serial}"
												data-detail="${equip.detail}" data-amount="${equip.amount}"
												data-time-create="${equip.time_create}"
												data-type="${equip.type}" data-windows="${equip.windows}"
												data-ram="${equip.ram}" data-hdd="${equip.hdd}"
												data-wifi="${equip.wifi}" data-lan="${equip.lan}"
												data-display="${equip.display}"
												data-process="${equip.process}"
												data-battery="${equip.battery}"> Request for Return </a>
										</c:if>
									</div>

								</div>

								<div class="card-body pt-0">

									<c:if test="${not empty statusLogParseError}">
										<div class="text-danger">Parse error:
											${statusLogParseError}</div>
									</c:if>

									<c:if test="${empty statusLogList}">
										<div class="text-muted">No status log.</div>
									</c:if>

									<c:forEach var="log" items="${statusLogList}">
										<c:set var="st" value="${log.status}" />

										<%-- badge/dot ตาม status --%>
										<c:set var="badgeText" value="${st}" />
										<c:set var="badgeClass"
											value="badge badge-lg px-2 fw-semibold bg-light text-gray-700" />

										<c:choose>
											<c:when test="${st == 'A' || st == 'a'}">
												<c:set var="badgeText" value="Available" />
												<c:set var="badgeClass"
													value="badge badge-lg px-2 fw-semibold bg-success text-white" />
											</c:when>

											<c:when test="${st == 'B' || st == 'b'}">
												<c:set var="badgeText" value="Borrowing" />
												<c:set var="badgeClass"
													value="badge badge-lg px-2 fw-semibold bg-warning text-white" />
											</c:when>

											<c:when test="${st == 'W' || st == 'w'}">
												<c:set var="badgeText" value="Wait for approve" />
												<c:set var="badgeClass"
													value="badge badge-lg px-2 fw-semibold bg-primary text-white" />
											</c:when>

											<c:when test="${st == 'R' || st == 'r'}">
												<c:set var="badgeText" value="Return" />
												<c:set var="badgeClass"
													value="badge badge-lg px-2 fw-semibold bg-success text-white" />
											</c:when>

											<c:when test="${st == 'C' || st == 'c'}">
												<c:set var="badgeText" value="Cancel" />
												<c:set var="badgeClass"
													value="badge badge-lg px-2 fw-semibold bg-danger text-white" />
											</c:when>
										</c:choose>

										<%-- ✅ userUpdate จาก JSON (ตามที่คุณบอกว่ามีเก็บ) --%>
										<c:set var="logUserUpdate" value="${log.userUpdate}" />

										<%-- หา user ใน userListObj (พยายาม match ทั้ง id/username) --%>
										<c:set var="emp" value="-" scope="page" />
										<c:set var="nmTH" value="-" scope="page" />
										<c:set var="nmEN" value="-" scope="page" />
										<c:set var="foundUser" value="false" scope="page" />

										<c:forEach var="u" items="${userListObj}">
											<c:set var="uUser"
												value="${not empty u['username'] ? u['username']
                : (not empty u['user_name'] ? u['user_name']
                : (not empty u['USER_NAME'] ? u['USER_NAME']
                : (not empty u['email'] ? u['email']
                : (not empty u['EMAIL'] ? u['EMAIL'] : ''))))}" />

											<c:if
												test="${not foundUser && fn:trim(uUser) == fn:trim(logUserUpdate)}">
												<c:set var="emp"
													value="${not empty u['employee_id'] ? u['employee_id']
                  : (not empty u['employeeId'] ? u['employeeId']
                  : (not empty u['EMPLOYEE_ID'] ? u['EMPLOYEE_ID'] : '-'))}"
													scope="page" />

												<c:set var="nmTH"
													value="${not empty u['name'] ? u['name']
                  : (not empty u['fullname'] ? u['fullname']
                  : (not empty u['USER_NAME'] ? u['USER_NAME'] : '-'))}"
													scope="page" />

												<c:set var="nmEN"
													value="${not empty u['name_en'] ? u['name_en']
                  : (not empty u['nameEn'] ? u['nameEn']
                  : (not empty u['NAME_EN'] ? u['NAME_EN'] : '-'))}"
													scope="page" />

												<c:set var="foundUser" value="true" scope="page" />
											</c:if>
										</c:forEach>

										<%-- ====== format เวลา จาก log.timeUpdate (เดิมของคุณ ใช้ได้เลย) ====== --%>
										<%
										Map<String, Object> logMap = (Map<String, Object>) pageContext.getAttribute("log");
										String z = (logMap != null && logMap.get("timeUpdate") != null) ? String.valueOf(logMap.get("timeUpdate")).trim() : "";

										String t = z;
										if (t != null) {
											t = t.trim();
											if (t.startsWith("[") && t.endsWith("]"))
												t = t.substring(1, t.length() - 1).trim();
											t = t.replace("T", " ");
											if (t.endsWith("Z"))
												t = t.substring(0, t.length() - 1).trim();
											t = t.replace('\u202F', ' ').replace('\u00A0', ' ').trim();
											t = t.replaceAll(" +", " ");
										}

										String timeDisplay = (t == null || t.isEmpty()) ? "-" : t;
										java.util.Date d = null;

										String[] patterns = new String[]{"MMM d, yyyy, h:mm:ss a", "MMM dd, yyyy, h:mm:ss a", "MMM d, yyyy, h:mm a",
												"MMM dd, yyyy, h:mm a", "dd-MM-yyyy", "dd/MM/yyyy", "yyyy-MM-dd", "yyyy/MM/dd", "dd-MM-yyyy HH:mm",
												"dd/MM/yyyy HH:mm", "yyyy-MM-dd HH:mm", "yyyy/MM/dd HH:mm", "dd-MM-yyyy HH:mm:ss", "dd/MM/yyyy HH:mm:ss",
												"yyyy-MM-dd HH:mm:ss", "yyyy/MM/dd HH:mm:ss", "yyyy-MM-dd HH:mm:ss.S", "yyyy-MM-dd HH:mm:ss.SS",
												"yyyy-MM-dd HH:mm:ss.SSS", "yyyy/MM/dd HH:mm:ss.S", "yyyy/MM/dd HH:mm:ss.SS", "yyyy/MM/dd HH:mm:ss.SSS"};

										if (t != null && !t.isEmpty() && !"null".equalsIgnoreCase(t)) {
											for (String p : patterns) {
												try {
											java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(p, java.util.Locale.ENGLISH);
											sdf.setLenient(true);
											d = sdf.parse(t);
											if (d != null)
												break;
												} catch (Exception ignore) {
												}
											}
										}

										if (d != null) {
											java.util.Calendar cal = java.util.Calendar.getInstance(java.util.Locale.ENGLISH);
											cal.setTime(d);
											int year = cal.get(java.util.Calendar.YEAR);
											if (year >= 2500) {
												cal.add(java.util.Calendar.YEAR, -543);
												d = cal.getTime();
											}
											timeDisplay = new java.text.SimpleDateFormat("dd MMM yyyy", java.util.Locale.ENGLISH).format(d);
										} else {
											timeDisplay = (t == null || t.isEmpty()) ? "-" : t;
										}

										pageContext.setAttribute("TIME_DISPLAY", timeDisplay);
										%>

										<%-- ====== UI แสดงผล ====== --%>
										<div class="d-flex mb-5">
											<span
												class="d-inline-flex align-items-center justify-content-center position-relative flex-shrink-0 me-3
                 rounded-circle border border-2 border-dashed border-gray-300"
												style="width: 38px; height: 38px;"> <i
												class="ki-duotone ki-cd dashed position-absolute top-50 start-50 translate-middle fs-2 text-gray-300">
													<span class="path1 text-warning"></span><span
													class="path2 text-warning"></span>
											</i>
											</span>

											<div class="flex-grow-1">
												<div class="mb-2">
													<b class="${badgeClass}">${badgeText}</b>
												</div>

												<div class="d-flex align-items-center">
													<i class="ki-duotone ki-user fs-5 me-2"><span
														class="path1"></span><span class="path2"></span></i> <span>
														<c:choose>
															<c:when test="${foundUser}">
                  ${emp} - ${nmTH} - ${nmEN}
                </c:when>
															<c:otherwise>
                  ${log.userUpdate}
                </c:otherwise>
														</c:choose>
													</span>
												</div>

												<div class="d-flex align-items-center mt-1">
													<i class="ki-duotone ki-calendar fs-5 me-2"><span
														class="path1"></span><span class="path2"></span></i> <span>${TIME_DISPLAY}</span>
												</div>

												<div class="d-flex align-items-center mt-1">
													<c:set var="borrowLocation" value="" />
													<c:choose>
														<c:when test="${not empty borrowObj['location']}">
															<c:set var="borrowLocation"
																value="${borrowObj['location']}" />
														</c:when>
														<c:when test="${not empty borrowObj['LOCATION']}">
															<c:set var="borrowLocation"
																value="${borrowObj['LOCATION']}" />
														</c:when>
														<c:otherwise>
															<c:set var="borrowLocation" value="" />
														</c:otherwise>
													</c:choose>

													<i class="ki-duotone ki-geolocation fs-5 me-2"><span
														class="path1"></span><span class="path2"></span></i> <span>
														<c:out
															value="${empty borrowLocation ? '-' : borrowLocation}" />
													</span>
												</div>

											</div>
										</div>

										<hr />
									</c:forEach>
								</div>
							</div>
						</div>
						<!-- end RIGHT -->

					</div>
				</div>
			</div>

		</div>
	</div>
	<!-- Modal Return -->
	<div class="modal fade" id="borrowDetailModal" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-lg">
			<div class="modal-content">

				<!-- Header -->
				<div class="modal-header border-0 px-6 pt-5 pb-0 align-items-center">
					<h2 class="modal-title fw-bold mb-0">Borrow Detail</h2>

					<button type="button"
						class="btn btn-icon btn-sm btn-light btn-active-light-primary"
						data-bs-dismiss="modal">
						<i class="ki-duotone ki-cross fs-2"> <span class="path1"></span><span
							class="path2"></span>
						</i>
					</button>
				</div>

				<!-- Body -->
				<div class="modal-body scroll-y px-5 px-xl-10 py-7">

					<!-- Top row -->
					<div class="row mb-6">
						<!-- Left -->
						<div class="col-md-6 pe-md-6">
							<!-- ID + Status -->
							<div class="d-flex align-items-center gap-5 mb-3 pb-4">
								<a href="javascript:void(0);" id="bd_item_link"
									class="fw-bold fs-5 text-primary"></a> <span
									id="bd_status_badge"
									class="badge badge-lg rounded-pill px-4 fw-semibold"></span>
							</div>

							<!-- Serial / Detail -->
							<div class="d-flex flex-column fs-7 text-gray-700">
								<div class="pb-4">
									<span class="fw-normal fs-5 text-gray-700 me-2">Serial
										No:</span> <span id="bd_serial"
										class="fw-normal fs-5 text-gray-800 text-break"></span>
								</div>

								<div>
									<span class="fw-normal fs-5 text-gray-700 me-2">Detail:</span>
									<span id="bd_detail"
										class="fw-normal fs-5 text-gray-800 text-break"></span>
								</div>
							</div>
						</div>

						<!-- Right -->
						<div class="col-md-6 ps-md-10 mt-5 mt-md-0">
							<div class="d-flex align-items-center mb-1 pb-4">
								<i class="ki-duotone ki-laptop fs-2x text-gray-600 me-3"> <span
									class="path1"></span><span class="path2"></span>
								</i> <span class="fw-bold fs-5 text-gray-800 text-break"
									id="bd_name"></span>
							</div>

							<div class="fs-5 text-gray-700 fw-normal mt-1 pb-4 me-4">
								Amount: <span id="bd_amount" class="fw-semibold text-gray-800"></span>
							</div>

							<div class="fs-5 text-gray-700 fw-normal mt-1 pb-4 me-4">
								Date of Purchase: <span id="bd_purchase_date"
									class="fw-normal text-gray-800 text-break"></span>
							</div>
						</div>
					</div>

					<!-- More Detail -->
					<div id="bd_moreDetailWrapper" class="mt-2">
						<a href="#" id="bd_moreDetailToggle"
							class="fw-medium fs-5 pb-4 text-primary d-inline-flex align-items-center"
							role="button" aria-controls="bd_moreDetailCollapse"
							aria-expanded="false"> More Detail <i id="bd_moreDetailIcon"
							class="ki-duotone ki-down fs-4 ms-4"> <span class="path1"></span><span
								class="path2"></span>
						</i>
						</a>

						<div class="collapse mt-3" id="bd_moreDetailCollapse">
							<div class="row fs-7 text-gray-700">
								<!-- Left -->
								<div class="col-md-6 pe-md-10">
									<div class="mb-3 pb-4">
										<span class="fw-normal fs-5 text-gray-700 me-3">Windows</span>
										<span id="bd_windows"
											class="ms-1 fw-normal fs-5 text-gray-800 text-break"></span>
									</div>
									<div class="mb-3 pb-4">
										<span class="fw-normal fs-5 text-gray-700 me-3">Ram</span> <span
											id="bd_ram"
											class="ms-1 fw-normal fs-5 text-gray-800 text-break"></span>
									</div>
									<div class="mb-3 pb-4">
										<span class="fw-normal fs-5 text-gray-700 me-3">Storage</span>
										<span id="bd_storage"
											class="ms-1 fw-normal fs-5 text-gray-800 text-break"></span>
									</div>
									<div class="mb-3 pb-4">
										<span class="fw-normal fs-5 text-gray-700 me-3">WIFI
											Address</span> <span id="bd_wifi"
											class="ms-1 fw-normal fs-5 text-gray-800 text-break"></span>
									</div>
									<div class="mb-3 pb-4">
										<span class="fw-normal fs-5 text-gray-700 me-3">Dispaly</span>
										<span id="bd_display"
											class="ms-1 fw-normal fs-5 text-gray-800 text-break"></span>
									</div>
								</div>

								<!-- Right -->
								<div class="col-md-6 ps-md-10">
									<div class="mb-3 pb-4">
										<span class="fw-normal fs-5 text-gray-700 me-3">CPU</span> <span
											id="bd_cpu"
											class="ms-1 fw-normal fs-5 text-gray-800 text-break"></span>
									</div>
									<div class="mb-3 pb-4">
										<span class="fw-normal fs-5 text-gray-700 me-3">Storage</span>
										<span id="bd_storage2"
											class="ms-1 fw-normal fs-5 text-gray-800 text-break"></span>
									</div>
									<div class="mb-3 pb-4">
										<span class="fw-normal fs-5 text-gray-700 me-3">Battery</span>
										<span id="bd_battery"
											class="ms-1 fw-normal fs-5 text-gray-800 text-break"></span>
									</div>
									<div class="mb-3 pb-4">
										<span class="fw-normal fs-5 text-gray-700 me-3">LAN
											Address</span> <span id="bd_lan"
											class="ms-1 fw-normal fs-5 text-gray-800 text-break"></span>
									</div>
								</div>
							</div>
						</div>
					</div>

					<!-- Approver -->
					<div class="mt-10">
						<div class="text-primary fw-bold fs-5 mb-7">Approver</div>
						<div class="text-gray-800 fs-7 mb-4">Specify a note when
							changing status (optional)</div>

						<textarea id="bd_approver_note"
							class="form-control form-control-solid" rows="3"
							placeholder="Enter maintenance or repair notes..."></textarea>
					</div>

				</div>

				<!-- Footer -->
				<div
					class="modal-footer border-0 pt-0 pb-6 px-6 d-flex justify-content-end gap-3">
					<button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
					<button type="button" class="btn btn-warning"
						id="bd_request_return">Request for Return</button>
				</div>

			</div>
		</div>
	</div>
	<script>
		document.addEventListener("DOMContentLoaded", function() {
			// ต้องมี flatpickr ถูกโหลดอยู่แล้ว (Metronic มักมี)
			flatpickr("#start_date", {
				enableTime : true,
				time_24hr : true,
				dateFormat : "d/m/Y" // <-- ได้ 16/12/2025, 00.00
			});

			flatpickr("#end_date", {
				enableTime : true,
				time_24hr : true,
				dateFormat : "d/m/Y"
			});
		});
	</script>
	<script>
		document.addEventListener('click', function(e) {
			const btn = e.target.closest('[data-collapse-target]');
			if (!btn)
				return;

			// กัน handler อื่น (เช่น BS4/jQuery) มายุ่ง
			e.preventDefault();
			e.stopPropagation();
			if (typeof e.stopImmediatePropagation === 'function')
				e.stopImmediatePropagation();

			const sel = btn.getAttribute('data-collapse-target');
			const target = document.querySelector(sel);
			if (!target) {
				console.warn('[CollapseFix] target not found:', sel);
				return;
			}

			// ถ้ามี id ซ้ำ จะพังทันที -> แจ้งเลย
			const dup = document.querySelectorAll(sel).length;
			if (dup > 1) {
				console.warn('[CollapseFix] duplicate id/selector found:', sel,
						'count=', dup);
			}

			// สั่งด้วย BS5 โดยตรง
			const inst = bootstrap.Collapse.getOrCreateInstance(target, {
				toggle : false
			});

			const isOpen = target.classList.contains('show');
			if (isOpen)
				inst.hide();
			else
				inst.show();

			// sync aria + icon
			btn.setAttribute('aria-expanded', String(!isOpen));
			const iconId = 'icon_'
					+ target.id.replace('moreDetailCollapse_', '');
			const icon = document.getElementById(iconId);
			if (icon)
				icon.classList.toggle('rotate-180', !isOpen);

		}, true); // ✅ capture phase = มาก่อน handler อื่น
	</script>
	<script>
		$(document)
				.ready(
						function() {
							const CTX = "${pageContext.request.contextPath}";

							// ===== modal instance =====
							const bdModalEl = document
									.getElementById('borrowDetailModal');
							const bdModalObj = bdModalEl ? bootstrap.Modal
									.getOrCreateInstance(bdModalEl) : null;

							// ===== collapse instance =====
							const bdCollapseEl = document
									.getElementById('bd_moreDetailCollapse');
							let bdCollapseObj = null;

							if (bdCollapseEl) {
								bdCollapseObj = bootstrap.Collapse
										.getOrCreateInstance(bdCollapseEl, {
											toggle : false
										});

								$('#bd_moreDetailToggle').on('click',
										function(e) {
											e.preventDefault();
											bdCollapseObj.toggle();
										});

								bdCollapseEl.addEventListener(
										'shown.bs.collapse', function() {
											$('#bd_moreDetailIcon').addClass(
													'is-open');
											$('#bd_moreDetailToggle').attr(
													'aria-expanded', 'true');
										});

								bdCollapseEl.addEventListener(
										'hidden.bs.collapse', function() {
											$('#bd_moreDetailIcon')
													.removeClass('is-open');
											$('#bd_moreDetailToggle').attr(
													'aria-expanded', 'false');
										});
							}

							// ===== helpers =====
							function setText(id, val) {
								const el = document.getElementById(id);
								if (!el)
									return;
								el.textContent = (val !== undefined
										&& val !== null && String(val).trim() !== "") ? val
										: "-";
							}

							function formatBorrowDate(dtStr) {
								if (!dtStr)
									return '';
								const d = new Date(String(dtStr).replace(' ',
										'T'));
								if (isNaN(d.getTime()))
									return String(dtStr);

								const day = d.getDate();
								const monthNames = [ 'Jan', 'Feb', 'Mar',
										'Apr', 'May', 'Jun', 'Jul', 'Aug',
										'Sep', 'Oct', 'Nov', 'Dec' ];
								const month = monthNames[d.getMonth()];
								const year = d.getFullYear();
								return day + ' ' + month + ' ' + year;
							}

							function getBorrowIdFromUrl() {
								const u = new URLSearchParams(
										window.location.search);
								return (u.get('id') || '').trim();
							}

							function setBadge(status) {
								const $b = $('#bd_status_badge');
								if (!$b.length)
									return;

								$b
										.removeClass()
										.addClass(
												'badge badge-lg rounded-pill px-4 fw-semibold');

								const st = String(status || '').toUpperCase();
								if (st === 'B') {
									$b.addClass('bg-warning text-white').text(
											'Borrowing');
								} else if (st === 'W') {
									$b.addClass('bg-light text-dark').text(
											'Wait for Approve');
								} else if (st === 'R') {
									$b.addClass('bg-success text-white').text(
											'Returned');
								} else {
									$b.addClass('bg-light text-muted')
											.text('-');
								}
							}

							function fillBorrowDetailModalFromBtn($btn) {
								// 1) borrowId: เอาจาก data ก่อน ถ้าไม่มีให้ใช้จาก URL (?id=...)
								const borrowId = ($btn.data('borrowId')
										|| $btn.data('borrow-id') || getBorrowIdFromUrl());

								if (!borrowId) {
									alert('Borrow ID not found.');
									return false;
								}

								// เก็บ borrowId ไว้ให้ปุ่มยิง action ใช้
								$('#borrowDetailModal').data('borrowId',
										String(borrowId).trim());

								// --- ถ้าไม่มี data fields ก็ไม่เป็นไร (จะแสดง "-") ---
								const amountRaw = $btn.data('amount');
								let amountText = '1';
								if (amountRaw !== undefined
										&& amountRaw !== null
										&& amountRaw !== '') {
									const n = parseFloat(amountRaw);
									amountText = (!isNaN(n) && n % 1 === 0) ? String(parseInt(
											n, 10))
											: String(amountRaw);
								}

								const itemNo = $btn.data('itemNo')
										|| $btn.data('item-no')
										|| ('Borrow ID: ' + borrowId);
								const name = $btn.data('name') || '';
								const serial = $btn.data('serial') || '';
								const detail = $btn.data('detail') || '';
								const timeCreate = $btn.data('timeCreate')
										|| $btn.data('time-create') || '';

								const type = String($btn.data('type') || '')
										.toLowerCase();
								const windows = $btn.data('windows') || '';
								const ram = $btn.data('ram') || '';
								const hdd = $btn.data('hdd') || '';
								const wifi = $btn.data('wifi') || '';
								const lan = $btn.data('lan') || '';
								const display = $btn.data('display') || '';
								const process = $btn.data('process')
										|| $btn.data('cpu') || '';
								const battery = $btn.data('battery') || '';

								// fill top
								$('#bd_item_link').text(
										'ID: ' + (itemNo || '-'));
								setText('bd_name', name);
								setText('bd_serial', serial);
								setText('bd_detail', detail);
								setText('bd_amount', amountText);
								setText('bd_purchase_date',
										formatBorrowDate(timeCreate) || '-');

								// badge (หน้านี้ปุ่มแสดงเฉพาะ Borrowing)
								setBadge('B');

								// reset collapse ทุกครั้ง
								if (bdCollapseObj)
									bdCollapseObj.hide();
								$('#bd_moreDetailIcon').removeClass('is-open');
								$('#bd_moreDetailToggle').attr('aria-expanded',
										'false');

								// show/hide more detail
								if (type === 'c') {
									$('#bd_moreDetailWrapper').show();
									setText('bd_windows', windows);
									setText('bd_ram', ram);
									setText('bd_storage', hdd);
									setText('bd_storage2', hdd);
									setText('bd_wifi', wifi);
									setText('bd_lan', lan);
									setText('bd_display', display);
									setText('bd_cpu', process);
									setText('bd_battery', battery);
								} else {
									$('#bd_moreDetailWrapper').hide();
								}

								// clear note
								$('#bd_approver_note').val('');

								return true;
							}

							// =========================================================
							// 1) กดปุ่มหน้า borrow_edit -> เปิด modal
							// =========================================================
							$(document)
									.on(
											'click',
											'.btn-open-return-modal',
											function(e) {
												e.preventDefault();
												if (!bdModalObj) {
													alert('Modal #borrowDetailModal not found');
													return;
												}

												const ok = fillBorrowDetailModalFromBtn($(this));
												if (!ok)
													return;

												bdModalObj.show();
											});

							// =========================================================
							// 2) กดปุ่มใน modal -> ยิง eBorrowReturn.action
							// =========================================================
							$('#bd_request_return')
									.on(
											'click',
											function(e) {
												e.preventDefault();

												const borrowId = ($(
														'#borrowDetailModal')
														.data('borrowId') || '')
														.toString().trim();
												const note = $(
														'#bd_approver_note')
														.val();

												if (!borrowId) {
													alert('Borrow ID not found.');
													return;
												}

												if (!confirm('Are you sure you want to request return for this item?'))
													return;

												$
														.ajax({
															url : CTX
																	+ "/eBorrowReturn.action",
															type : "POST",
															dataType : "json",
															data : {
																id : borrowId,
																note : note
															},
															success : function(
																	data) {
																if (data
																		&& String(
																				data.message)
																				.toLowerCase() === "success") {
																	alert("Return request submitted successfully!");
																	bdModalObj
																			.hide();

																	// กลับหน้า borrow_list
																	window.location
																			.replace(CTX
																					+ "/borrow_list.action");
																} else {
																	alert("Something went wrong: "
																			+ (data ? data.message
																					: "no data"));
																}
															},
															error : function(
																	xhr) {
																console
																		.log(
																				"HTTP",
																				xhr.status);
																console
																		.log(
																				"RAW",
																				xhr.responseText);
																alert("Failed to submit return request.");
															}
														});
											});

							// =========================================================
							// 3) FIX ปุ่ม X / Cancel ให้ปิดแน่นอน
							// =========================================================
							$('#borrowDetailModal').on('click',
									'[data-bs-dismiss="modal"]', function(e) {
										e.preventDefault();
										e.stopPropagation();
										if (bdModalObj)
											bdModalObj.hide();
									});

						});
	</script>
</body>
</html>