<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page
	import="java.util.*, com.google.gson.Gson, com.google.gson.reflect.TypeToken, java.lang.reflect.Type"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.text.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<fmt:setLocale value="en_US" />
<fmt:formatDate value="${equipmentbyId.timeCreate}" pattern="d MMM yyyy"
	var="purchaseFmt" />
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
											class="form-select form-select fw-medium text muted"
											data-control="select2" data-placeholder="Select Borrower"
											disabled>

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
													<c:if test="${fn:toLowerCase(fn:trim(uid)) == fn:toLowerCase(fn:trim(borrowerId))}">selected</c:if>>
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

										<select name="status" class="form-select form-select" required>
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

										<select class="form-select form-select fw-medium text-muted"
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
													class="form-control form-control ps-12" name="date_from"
													placeholder="Select Date" value="${borrowObj['dateStart']}"
													autocomplete="off" required />
											</div>
										</div>

										<div class="col-lg-6">
											<label class="form-label fw-semibold fs-6">End Date</label>
											<div class="position-relative d-flex align-items-center">
												<i
													class="ki-outline ki-calendar fs-3 position-absolute ms-4"></i>
												<input type="text" id="end_date"
													class="form-control form-control ps-12" name="date_to"
													placeholder="Select Date" value="${borrowObj['dateEnd']}"
													autocomplete="off" />
											</div>
										</div>
									</div>

									<!-- Location (label อยู่บน / ช่องอยู่ล่าง) -->
									<div class="mb-7">
										<label class="required fw-semibold fs-6 mb-2 d-block">Location</label>

										<input class="form-control form-control" type="text"
											name="location" value="${locationVal}" />

									</div>

									<!-- Reason -->
									<div class="mb-7">
										<label class="fw-semibold fs-6 mb-2 d-block">Reason</label>
										<textarea class="form-control form-control" rows="4"
											name="reason" placeholder="ระบุเหตุผลการยืม"><c:out
												value="${borrowObj['reason']}" /></textarea>
									</div>

									<!-- Contact Address (ทำเป็น textarea ด้วย) -->
									<div class="mb-7">
										<label class="fw-semibold fs-6 mb-2 d-block">Contact
											Address</label>
										<textarea class="form-control form-control" rows="4"
											name="contact" placeholder="Address"><c:out
												value="${borrowObj['contactAddr']}" /></textarea>
									</div>

									<!-- Remark -->
									<div class="mb-7">
										<label class="fw-semibold fs-6 mb-2 d-block">Remark</label>
										<textarea class="form-control form-control" rows="4"
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
										<c:choose>
											<c:when test="${not empty equip.image}">
												<div class="symbol symbol-150px">
													<img src="${equip.image}" alt="${equip.code}"
														class="border rounded-3 object-fit-cover w-100 h-100" />
												</div>
											</c:when>

											<c:otherwise>
												<div
													class="symbol symbol-150px border rounded-3 bg-light d-flex align-items-center justify-content-center">
													<i class="fa-solid fa-image fs-1 text-muted"></i>
												</div>
											</c:otherwise>
										</c:choose>
									</div>

									<!-- ===== ROW STYLE: label ซ้าย (กว้างคงที่) / value อยู่ถัดมา (ไม่ชิดขวา) ===== -->
									<div
										class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
										<div class="text-gray-500" style="min-width: 130px;">Name:</div>
										<div class="fw-semibold text-gray-800 text-break">
											<c:out value="${equip.name}" />
										</div>
									</div>

									<div
										class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
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

									<div
										class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
										<div class="text-gray-500" style="min-width: 130px;">Serial
											No:</div>
										<div class="fw-semibold text-gray-800 text-break">
											<c:out value="${equip.serialNo}" />
										</div>
									</div>

									<div
										class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
										<div class="text-gray-500" style="min-width: 130px;">Amount:</div>
										<div class="fw-semibold text-gray-800">
											<fmt:formatNumber value="${equip.amount}" pattern="#" />
										</div>
									</div>

									<div
										class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
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
													? new java.text.SimpleDateFormat("dd MMM yyyy", java.util.Locale.ENGLISH).format(parsed)
													: raww;

											pageContext.setAttribute("PURCHASE_DISPLAY", display);
											%>
											<c:out value="${PURCHASE_DISPLAY}" />
										</div>
									</div>

									<div
										class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
										<div class="text-gray-500" style="min-width: 130px;">Detail:</div>
										<div class="fw-semibold text-gray-800 text-break">
											<c:out value="${equip.detail}" />
										</div>
									</div>

									<c:if test="${equip.type == 'c'}">

										<div>
											<!-- ใช้ button แทน a เพื่อให้ toggle ปิด/เปิดชัวร์ -->
											<button type="button"
												class="btn btn-link p-0 w-100 text-primary fw-semibold d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200"
												data-collapse-target="#moreDetailCollapse_${equipId}"
												aria-expanded="false"
												aria-controls="moreDetailCollapse_${equipId}">
												<span>More Detail</span> <i class="ki-duotone ki-down fs-3"
													id="icon_${equipId}"
													style="transition: transform .2s ease;"> <span
													class="path1"></span><span class="path2"></span>
												</i>
											</button>

											<div class="collapse mt-3" id="moreDetailCollapse_${equipId}"
												data-equip-id="${equipId}">

												<div
													class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
													<div class="text-gray-500" style="min-width: 130px;">Windows</div>
													<div class="fw-semibold text-gray-800 text-break">
														<c:out value="${equip.windows}" />
													</div>
												</div>

												<div
													class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
													<div class="text-gray-500" style="min-width: 130px;">CPU</div>
													<div class="fw-semibold text-gray-800 text-break">
														<c:out value="${equip.process}" />
													</div>
												</div>

												<div
													class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
													<div class="text-gray-500" style="min-width: 130px;">Ram</div>
													<div class="fw-semibold text-gray-800 text-break">
														<c:out value="${equip.ram}" />
													</div>
												</div>

												<div
													class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
													<div class="text-gray-500" style="min-width: 130px;">Storage</div>
													<div class="fw-semibold text-gray-800 text-break">
														<c:out value="${equip.hdd}" />
													</div>
												</div>

												<div
													class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
													<div class="text-gray-500" style="min-width: 130px;">Battery</div>
													<div class="fw-semibold text-gray-800 text-break">
														<c:out value="${equip.battery}" />
													</div>
												</div>

												<div
													class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
													<div class="text-gray-500" style="min-width: 130px;">WIFI
														Address</div>
													<div class="fw-semibold text-gray-800 text-break">
														<c:out value="${equip.wifiaddress}" />
													</div>
												</div>

												<div
													class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
													<div class="text-gray-500" style="min-width: 130px;">LAN
														Address</div>
													<div class="fw-semibold text-gray-800 text-break">
														<c:out value="${equip.lanaddress}" />
													</div>
												</div>

												<div
													class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
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
							<div class="card shadow-sm mb-5 mb-xl-10">
								<div class="card-header fs-4">
									<div class="card-title">
										<h3 class="fw-semibold m-0 bs-gray-900">Status Log</h3>
									</div>

									<div class="card-toolbar">
										<c:if test="${not empty borrowlistwithUser}">
											<c:if test="${borrowlistwithUser[0].status == 'B'}">
												<button type="button"
													class="btn btn-sm btn-warning btn-open-return-modal">
													Request for Return</button>
											</c:if>
										</c:if>
									</div>
								</div>

								<div class="card-body pt-0 mt-6">
									<c:choose>
										<c:when test="${not empty borrowlistwithUser}">
											<div class="timeline timeline-border-dashed">
												<c:forEach var="borrow" items="${borrowlistwithUser}">

													<c:if test="${borrow.status == 'R'}">
														<div class="timeline-item">
															<div class="timeline-line"></div>
															<div class="timeline-icon">
																<i class="ki-duotone ki-cd fs-2 text-success"><span
																	class="path1"></span><span class="path2"></span></i>
															</div>

															<div class="timeline-content mb-5 mt-n1">
																<div class="mb-2">
																	<span class="badge badge-success fw-bold fs-7">Returned</span>
																</div>

																<div class="d-flex align-items-center mt-4 mb-2">
																	<i class="ki-duotone ki-user fs-4 text-gray-700 me-3"><span
																		class="path1"></span><span class="path2"></span></i>
																	<div class="fs-5 fw-semibold text-gray-800">
																		<c:if test="${not empty borrow.employee_id}">${borrow.employee_id} - </c:if>${borrow.name}
																		<c:if test="${not empty borrow.name_en}"> - ${borrow.name_en}</c:if>
																	</div>
																</div>

																<div
																	class="d-flex align-items-center mt-4 fs-7 text-muted">
																	<i
																		class="ki-duotone ki-calendar fs-4 text-gray-700 me-3"><span
																		class="path1"></span><span class="path2"></span></i>
																	<div class="fs-5 fw-semibold text-gray-800">
																		<c:choose>
																			<c:when test="${not empty borrow.date_end}">
																				<fmt:setLocale value="en_US" />
																				<fmt:formatDate value="${borrow.date_end}"
																					pattern="d MMMM yyyy, HH:mm" />
																			</c:when>
																			<c:otherwise>Unknown Return Date</c:otherwise>
																		</c:choose>
																	</div>
																</div>

																<c:if test="${not empty borrow.location}">
																	<div
																		class="d-flex align-items-center mt-4 mb-2 fs-7 text-muted">
																		<i class="ki-duotone ki-geolocation fs-2 me-3"><span
																			class="path1"></span><span class="path2"></span></i>
																		<div class="fs-5 fw-semibold text-gray-800">${borrow.location}</div>
																	</div>
																</c:if>
															</div>
														</div>
													</c:if>

													<div class="timeline-item">
														<div class="timeline-icon">
															<i class="ki-duotone ki-cd fs-2 text-warning"><span
																class="path1"></span><span class="path2"></span></i>
														</div>

														<div class="timeline-content mb-0 mt-n1">
															<div class="mb-2">
																<span class="badge badge-warning fw-bold fs-7">
																	${borrow.status == 'B' ? 'Borrowing' : 'Borrowed'} </span>
															</div>

															<div class="d-flex align-items-center mt-4 mb-2">
																<i class="ki-duotone ki-user fs-4 text-gray-700 me-3"><span
																	class="path1"></span><span class="path2"></span></i>
																<div class="fs-5 fw-semibold text-gray-800">
																	<c:if test="${not empty borrow.employee_id}">${borrow.employee_id} - </c:if>${borrow.name}
																	<c:if test="${not empty borrow.name_en}"> - ${borrow.name_en}</c:if>
																</div>
															</div>

															<div
																class="d-flex align-items-center mt-4 fs-7 text-muted">
																<i
																	class="ki-duotone ki-calendar fs-4 text-gray-700 me-3"><span
																	class="path1"></span><span class="path2"></span></i>
																<div class="fs-5 fw-semibold text-gray-800">
																	<fmt:setLocale value="en_US" />
																	<fmt:formatDate value="${borrow.date_start}"
																		pattern="d MMMM yyyy, HH:mm" />
																</div>
															</div>

															<c:if test="${not empty borrow.location}">
																<div
																	class="d-flex align-items-center mt-4 fs-7 text-muted">
																	<i
																		class="ki-duotone ki-geolocation fs-4 text-gray-700 me-3"><span
																		class="path1"></span><span class="path2"></span></i>
																	<div class="fs-5 fw-semibold text-gray-800">${borrow.location}</div>
																</div>
															</c:if>
														</div>
													</div>

													<div
														class="separator separator-dashed border-gray-300 my-5"></div>
												</c:forEach>
											</div>
										</c:when>

										<c:otherwise>
											<div
												class="d-flex flex-column align-items-center justify-content-center py-10">
												<i class="ki-duotone ki-cube-2 fs-3x text-gray-500 mb-4">
													<span class="path1"></span><span class="path2"></span><span
													class="path3"></span>
												</i> <span class="text-gray-800 fw-semibold fs-5">No data</span>
											</div>
										</c:otherwise>
									</c:choose>
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
				dateFormat : "d M Y , H : i"
			});

			flatpickr("#end_date", {
				enableTime : true,
				time_24hr : true,
				dateFormat : "d M Y , H : i"
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

							// ✅✅✅ [เพิ่มตรงนี้] ===== collapse instance สำหรับ More Detail =====
							const bdCollapseEl = document
									.getElementById('bd_moreDetailCollapse');
							const bdCollapseObj = bdCollapseEl ? bootstrap.Collapse
									.getOrCreateInstance(bdCollapseEl, {
										toggle : false
									})
									: null;

							// ✅✅✅ [เพิ่มตรงนี้] click toggle (กัน href="#" + กัน event อื่น)
							$(document)
									.on(
											'click',
											'#bd_moreDetailToggle',
											function(e) {
												e.preventDefault();
												e.stopPropagation();
												if (typeof e.stopImmediatePropagation === 'function')
													e
															.stopImmediatePropagation();
												if (!bdCollapseObj)
													return;
												bdCollapseObj.toggle();
											});

							// ✅✅✅ [เพิ่มตรงนี้] sync icon/aria
							if (bdCollapseEl) {
								bdCollapseEl.addEventListener(
										'shown.bs.collapse', function() {
											$('#bd_moreDetailToggle').attr(
													'aria-expanded', 'true');
											$('#bd_moreDetailIcon').addClass(
													'rotate-180');
										});
								bdCollapseEl.addEventListener(
										'hidden.bs.collapse', function() {
											$('#bd_moreDetailToggle').attr(
													'aria-expanded', 'false');
											$('#bd_moreDetailIcon')
													.removeClass('rotate-180');
										});
							}

							function setText(id, val) {
								const el = document.getElementById(id);
								if (!el)
									return;
								el.textContent = (val !== undefined
										&& val !== null && String(val).trim() !== "") ? val
										: "-";
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

							function formatPurchaseDMY(dtStr) {
								if (!dtStr)
									return "";

								let s = String(dtStr).trim();
								if (!s || s === "null")
									return "";

								// รองรับ: "2021-04-27 08:08:51.0" / "2021-04-27 08:08:51"
								const m = s
										.match(/^(\d{4})-(\d{2})-(\d{2})(?:[ T](\d{2}):(\d{2})(?::(\d{2}))?(?:\.\d+)?)?$/);
								if (!m)
									return s; // ถ้าไม่ตรง format ก็คืนค่าเดิม

								const y = parseInt(m[1], 10);
								const mo = parseInt(m[2], 10);
								const d = parseInt(m[3], 10);

								const months = [ "Jan", "Feb", "Mar", "Apr",
										"May", "Jun", "Jul", "Aug", "Sep",
										"Oct", "Nov", "Dec" ];
								const dd = String(d); // ไม่ต้อง 0 นำหน้า
								const mon = months[mo - 1] || "";

								return `${dd} ${mon} ${y}`; // d M Y
							}

							// ✅ เปิด modal แล้วเติมค่าจาก JSP (ไม่ต้องใช้ data-*)
							function openBorrowDetailModalFromJsp() {
								if (!bdModalObj) {
									alert('Modal #borrowDetailModal not found');
									return;
								}

								const borrowId = '${not empty borrowlistwithUser ? borrowlistwithUser[0].borrow_id : ""}';
								const itemNo = '${equipmentbyId.itemNo}';
								const name = '${equipmentbyId.name}';
								const serial = '${equipmentbyId.serialNo}';
								const detail = '${equipmentbyId.detail}';
								const amount = '${equipmentbyId.amount}';
								const timeCreate = '${equipmentbyId.timeCreate}';

								const type = '${equipmentbyId.type}';
								const windows = '${equipmentbyId.windows}';
								const ram = '${equipmentbyId.ram}';
								const hdd = '${equipmentbyId.hdd}';
								const wifi = '${equipmentbyId.wifiaddress}';
								const lan = '${equipmentbyId.lanaddress}';
								const display = '${equipmentbyId.display}';
								const cpu = '${equipmentbyId.process}';
								const battery = '${equipmentbyId.battery}';
								const purchaseFmt = '${purchaseFmt}';

								if (!borrowId) {
									alert('Borrow ID not found.');
									return;
								}

								$('#borrowDetailModal').data('borrowId',
										String(borrowId).trim());

								$('#bd_item_link').text(
										'ID: ' + (itemNo || '-'));
								setText('bd_name', name);
								setText('bd_serial', serial);
								setText('bd_detail', detail);
								setText('bd_amount', amount || '1');
								setText('bd_purchase_date', purchaseFmt || '-');
								setBadge('B');

								// more detail
								const t = String(type || '').toLowerCase();
								if (t === 'c') {
									$('#bd_moreDetailWrapper').show();
									setText('bd_windows', windows);
									setText('bd_ram', ram);
									setText('bd_storage', hdd);
									setText('bd_storage2', hdd);
									setText('bd_wifi', wifi);
									setText('bd_lan', lan);
									setText('bd_display', display);
									setText('bd_cpu', cpu);
									setText('bd_battery', battery);
								} else {
									$('#bd_moreDetailWrapper').hide();
								}

								$('#bd_approver_note').val('');

								// ✅✅✅ [เพิ่มตรงนี้] reset collapse ทุกครั้งก่อน show
								if (bdCollapseObj)
									bdCollapseObj.hide();
								$('#bd_moreDetailToggle').attr('aria-expanded',
										'false');
								$('#bd_moreDetailIcon').removeClass(
										'rotate-180');

								bdModalObj.show();
							}

							$(document).on('click', '.btn-open-return-modal',
									function(e) {
										e.preventDefault();
										openBorrowDetailModalFromJsp();
									});

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
																	if (bdModalObj)
																		bdModalObj
																				.hide();

																	// ✅ เด้งไปหน้า borrow_list
																	window.location
																			.replace(CTX
																					+ "/borrow_list");
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