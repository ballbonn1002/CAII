<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.reflect.TypeToken"%>
<%@ page import="java.lang.reflect.Type"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.text.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<fmt:setLocale value="en_US" />

<%
// ถ้า action ไหนเซต borrowList มาแล้ว (เช่น eBorrowEdit) จะไม่ทำซ้ำ
if (request.getAttribute("borrowList") == null) {

	String borrowJson = (String) request.getAttribute("borrows"); // จาก newEquipBorrowList()
	String equipJson = (String) request.getAttribute("equipments");
	String typeJson = (String) request.getAttribute("type");
	String userJson = (String) request.getAttribute("userList");

	Gson gson = new Gson();
	Type listMapType = new TypeToken<List<Map<String, Object>>>() {
	}.getType();

	// ===== JSON → List<Map<String,Object>> =====
	List<Map<String, Object>> borrows = (borrowJson != null && !borrowJson.isEmpty())
	? gson.fromJson(borrowJson, listMapType)
	: new ArrayList<Map<String, Object>>();

	List<Map<String, Object>> equipments = (equipJson != null && !equipJson.isEmpty())
	? gson.fromJson(equipJson, listMapType)
	: new ArrayList<Map<String, Object>>();

	List<Map<String, Object>> typeList = (typeJson != null && !typeJson.isEmpty())
	? gson.fromJson(typeJson, listMapType)
	: new ArrayList<Map<String, Object>>();

	List<Map<String, Object>> userListObj = (userJson != null && !userJson.isEmpty())
	? gson.fromJson(userJson, listMapType)
	: new ArrayList<Map<String, Object>>();

	// ================== index equipment ด้วย equipment_id (แก้ 1.0 → "1") ==================
	Map<String, Map<String, Object>> equipById = new HashMap<String, Map<String, Object>>();

	for (Map<String, Object> e : equipments) {
		Object idObj = e.get("equipment_id");
		if (idObj == null)
	idObj = e.get("equipmentId");
		if (idObj == null)
	continue;

		String key;
		if (idObj instanceof Number) {
	key = String.valueOf(((Number) idObj).longValue()); // 1.0 -> "1"
		} else {
	key = String.valueOf(idObj);
		}
		equipById.put(key, e);
	}

	// ================== index user แบบไม่สนพิมพ์เล็ก/ใหญ่ ==================
	Map<String, Map<String, Object>> userByKey = new HashMap<String, Map<String, Object>>();

	for (Map<String, Object> u : userListObj) {

		// key ที่ 1 : id (ตัวเลข)
		Object uidObj = u.get("id");
		if (uidObj == null)
	uidObj = u.get("user_id");
		if (uidObj != null) {
	String k = String.valueOf(uidObj).toLowerCase();
	userByKey.put(k, u);
		}

		// key ที่ 2 : login / user_borrowid (เช่น sukuntamas.r)
		Object loginObj = u.get("id");
		if (loginObj == null)
	loginObj = u.get("userBorrowid");
		if (loginObj == null)
	loginObj = u.get("name");
		if (loginObj != null) {
	String k = String.valueOf(loginObj).toLowerCase();
	userByKey.put(k, u);
		}
	}
	// ================== สร้าง viewList ที่ JSP ใช้ ==================
	// ================== สร้าง viewList ที่ JSP ใช้ ==================
	List<Map<String, Object>> viewList = new ArrayList<Map<String, Object>>();

	for (Map<String, Object> b : borrows) {

		Map<String, Object> row = new HashMap<String, Object>();

		// ---- borrow_id ----
		Object borrowIdObj = b.get("borrow_id");
		if (borrowIdObj == null)
	borrowIdObj = b.get("borrowId");

		String borrowIdStr = null;
		if (borrowIdObj instanceof Number) {
	borrowIdStr = String.valueOf(((Number) borrowIdObj).longValue()); // กัน 1.0
		} else if (borrowIdObj != null) {
	borrowIdStr = String.valueOf(borrowIdObj);
		}

		// ---- equipment_id ----
		Object equipIdObj = b.get("equipment_id");
		if (equipIdObj == null)
	equipIdObj = b.get("equipmentId");

		String equipIdKey = null;
		if (equipIdObj instanceof Number) {
	equipIdKey = String.valueOf(((Number) equipIdObj).longValue());
		} else if (equipIdObj != null) {
	equipIdKey = String.valueOf(equipIdObj);
		}

		// ---- user_borrowid (ค่าที่อยู่ในตาราง borrow) ----
		Object userBorrowObj = b.get("user_borrowid");
		if (userBorrowObj == null)
	userBorrowObj = b.get("userBorrowid");

		String userBorrowKey = null;
		if (userBorrowObj != null) {
	userBorrowKey = String.valueOf(userBorrowObj).toLowerCase(); // ไม่สนพิมพ์เล็ก/ใหญ่
		}

		// ---- status ----
		Object status = b.get("status");
		if (status == null)
	status = b.get("statusborrow");

		// ---- location จาก borrow (ไว้ใช้ fallback ถ้าใน equipment ว่าง) ----
		Object borrowLoc = b.get("location");

		// ================== หา equipment ==================
		Map<String, Object> equip = null;
		if (equipIdKey != null) {
	equip = equipById.get(equipIdKey);
		}

		// ================== หา user (เอาชื่อ + ข้อมูลอื่น) – case-insensitive ==================
		String borrowerName = null;
		String employeeId = null;
		String borrowerNameEn = null;
		String department = null;
		String roleId = null;

		if (userBorrowKey != null) {
	Map<String, Object> u = userByKey.get(userBorrowKey);
	if (u != null) {
		// ชื่อภาษาไทย
		Object n = u.get("name");
		if (n == null)
			n = u.get("user_name");
		borrowerName = (n != null) ? String.valueOf(n) : null;

		// employee_id
		Object emp = u.get("employee_id");
		if (emp != null)
			employeeId = String.valueOf(emp);

		// name_en
		Object ne = u.get("name_en");
		if (ne != null)
			borrowerNameEn = String.valueOf(ne);

		// department
		Object dept = u.get("department");
		if (dept != null)
			department = String.valueOf(dept);

		Object role = u.get("role");
		if (dept != null)
			roleId = String.valueOf(role);
	}
		}

		// ----------------- ใส่ค่าลง row -----------------
		row.put("borrow_id", borrowIdStr);
		row.put("equipment_id", equipIdKey);
		row.put("user_borrowid", userBorrowObj); // รหัส/ล็อกอินเดิม
		row.put("borrower_name", borrowerName); // ชื่อไทย
		row.put("employee_id", employeeId); // รหัสพนักงาน
		row.put("name_en", borrowerNameEn); // ชื่ออังกฤษ
		row.put("department", department); // แผนก
		row.put("statusborrow", status);
		row.put("role_id", roleId);

		if (equip != null) {
	Object itemNo = equip.get("item_no");
	if (itemNo == null)
		itemNo = equip.get("itemNo");

	Object name = equip.get("name");
	Object detail = equip.get("detail");
	Object loc = b.get("location");
	Object type = equip.get("type");
	Object dateCreate = equip.get("time_create");
	if (dateCreate == null)
		dateCreate = equip.get("timeCreate");
	Object serial = equip.get("serialNo");
	Object amount = equip.get("amount");
	Object ram = equip.get("ram");
	Object process = equip.get("process");
	Object battery = equip.get("battery");
	Object hdd = equip.get("hdd");
	Object windows = equip.get("windows");
	Object wifi = equip.get("wifiaddress");
	Object lan = equip.get("lanaddress");
	Object display = equip.get("display");

	Object dateStart = b.get("date_start");
	if (dateStart == null)
		dateStart = b.get("dateStart");

	Object dateEnd = b.get("date_end");
	if (dateEnd == null)
		dateEnd = b.get("dateEnd");

	row.put("item_no", itemNo);
	row.put("name", name);
	row.put("detail", detail);
	row.put("location", (loc != null ? loc : borrowLoc));
	row.put("type", type);
	row.put("time_create", dateCreate);
	row.put("serial_no", serial);
	row.put("amount", amount);
	row.put("ram", ram);
	row.put("process", process);
	row.put("battery", battery);
	row.put("hdd", hdd);
	row.put("windows", windows);
	row.put("wifiaddress", wifi);
	row.put("lanaddress", lan);
	row.put("display", display);

	row.put("date_start", dateStart);
	row.put("date_end", dateEnd);
		} else {
	row.put("item_no", null);
	row.put("name", null);
	row.put("detail", null);
	row.put("location", borrowLoc);
	row.put("type", null);
		}
		viewList.add(row);
	}
	// ส่งให้ JSTL ใช้
	request.setAttribute("borrowList", viewList);
	request.setAttribute("typeList", typeList);
}
%>


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

<style>
/* Light Mode */
[data-bs-theme="light"] #kt_table.table.table-striped>tbody>tr:nth-of-type(odd)>*
	{
	background-color: #FBFBFB !important;
	box-shadow: none !important;
}

[data-bs-theme="light"] #kt_table.table-hover tbody tr:hover>*, [data-bs-theme="light"] #kt_table.table-hover tbody tr:hover>td,
	[data-bs-theme="light"] #kt_table.table-hover tbody tr:hover>th, [data-bs-theme="light"] #kt_table.table.table-hover>tbody>tr:hover>*,
	[data-bs-theme="light"] #kt_table.dataTable>tbody>tr:hover>* {
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

[data-bs-theme="dark"] #kt_table.table-hover tbody tr:hover>*, [data-bs-theme="dark"] #kt_table.table-hover tbody tr:hover>td,
	[data-bs-theme="dark"] #kt_table.table-hover tbody tr:hover>th, [data-bs-theme="dark"] #kt_table.table.table-hover>tbody>tr:hover>*,
	[data-bs-theme="dark"] #kt_table.dataTable>tbody>tr:hover>* {
	background-color: #1B1C22 !important;
	box-shadow: none !important;
	transition: background-color .15s ease-in-out;
}

#moreDetailIcon {
	transition: transform .2s ease;
}

#moreDetailIcon.is-open {
	transform: rotate(180deg);
}

#bd_moreDetailIcon {
	transition: transform .2s ease;
	transform: rotate(0deg);
	display: inline-block;
}

#bd_moreDetailIcon.is-open {
	transform: rotate(180deg);
}
</style>
</head>
<body>
	<!--begin::Main-->
	<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
		<!--begin::Content wrapper-->
		<div class="d-flex flex-column flex-column-fluid">

			<!--begin::Toolbar-->
			<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
				<div id="kt_app_toolbar_container"
					class="app-container container-fluid d-flex align-items-center justify-content-start">
					<div
						class="page-title d-flex flex-column flex-wrap me-3 align-items-start">
						<h1 class="page-heading fw-semibold my-0 text-start"
							style="color: #4b5675;">Borrow List</h1>
						<ul
							class="breadcrumb breadcrumb-separatorless fw-medium fs-7 my-0 pt-1">
							<li class="breadcrumb-item text-muted"><a
								href="${pageContext.request.contextPath}/demo_dashboard"
								class="text-muted text-hover-primary">Home</a></li>
							<li class="breadcrumb-item"><span
								class="bullet bg-gray-500 w-4px h-1px"></span></li>
							<li class="breadcrumb-item text-muted">Borrow</li>
						</ul>
					</div>
				</div>
			</div>
			<!--end::Toolbar-->

			<!--begin::Content-->
			<div id="kt_app_content" class="app-content flex-column-fluid">
				<!--begin::Content container-->
				<div id="kt_app_content_container"
					class="app-container container-fluid">
					<div class="d-flex flex-row">
						<div class="flex-row-fluid mb-5">

							<!-- 🔍 Search form -->
							<form action="new_search_borrow" method="POST" id="searchForm">
								<div
									class="card card-flush bgi-no-repeat bgi-size-contain bgi-position-x-center border-0 mb-5 mb-xl-10">
									<div class="card-body py-5 px-6">
										<div class="row g-5 align-items-end">

											<!-- Search -->
											<div class="col-md-5">
												<div
													class="d-flex align-items-center border border-gray-300 rounded-3 px-4 py-2 gap-3 h-55px bg-body">
													<!-- icon -->
													<i class="ki-duotone ki-magnifier fs-4 text-gray-500">
														<span class="path1"></span> <span class="path2"></span>
													</i>
													<!-- input -->
													<input type="text" name="keyword"
														class="form-control border-0 bg-transparent ps-0"
														placeholder="Search" />
												</div>
											</div>

											<!-- Status -->
											<div class="col-md-3">
												<label class="form-label fw-semibold fs-7 mb-2">Status</label>
												<select name="status" class="form-select form-select-solid">
													<option value="">All Status</option>
													<!-- ให้ value = B / R ตรงกับ statusborrow ใน DB -->
													<option value="B">Borrowed</option>
													<option value="W">Wait for Approve</option>
												</select>
											</div>

											<!-- Type -->
											<div class="col-md-3">
												<label class="form-label fw-semibold fs-7 mb-2">Type</label>
												<select name="type"
													class="form-select form-select-solid text-muted">
													<option value="">Select</option>
													<!-- ให้ value ตรงกับ row.type ที่ใช้เลือก icon -->
													<option value="c">Computer</option>
													<option value="in">instument</option>
													<option value="L">Software License</option>
													<option value="sl">Software License</option>
													<option value="Mob">Mobile</option>
													<option value="p">Pocket WIFI</option>
												</select>
											</div>
										</div>
									</div>
								</div>
							</form>

							<!-- items -->
							<div class="d-flex flex-stack mb-4">
								<div>
									<span id="itemsFound" class="fw-semibold fs-6">${borrowList.size()}
										Items Found</span> <span class="text-gray-500 fs-7 ms-2">by
										Recent Updates ↓</span>
								</div>
								<div>
									<a href="${pageContext.request.contextPath}/borrow_add"
										data-route="borrow_add"
										class="btn btn-success d-inline-flex align-items-center py-2 px-4 gap-2">
										<i class="ki-duotone ki-plus fs-5"> <span class="path1"></span>
											<span class="path2"></span>
									</i> <span class="fw-500">Create</span>
									</a>

								</div>
							</div>
							<!-- Type Box -->
							<div class="card">
								<div class="card-body px-7 py-7">
									<div class="border border-dashed border-gray-300 rounded-3 p-7">
										<!-- หัวข้อ -->
										<div class="fw-semibold fs-4 text-gray-800 mb-7">Type</div>

										<!-- รายการ Type -->
										<div class="d-flex flex-wrap align-items-center gap-9">

											<div class="d-flex align-items-center gap-4">
												<i class="ki-duotone ki-laptop fs-4 text-gray-600"><span
													class="path1"></span> <span class="path2"></span></i> <span
													class="text-gray-800">Computer</span>
											</div>

											<div class="d-flex align-items-center gap-4">
												<i class="ki-duotone ki-keyboard fs-4 text-gray-600"><span
													class="path1"></span> <span class="path2"></span></i> <span
													class="text-gray-800">Instrument</span>
											</div>

											<div class="d-flex align-items-center gap-4">
												<i class="ki-duotone ki-verify fs-4 text-gray-600"><span
													class="path1"></span> <span class="path2"></span></i> <span
													class="text-gray-800">Software License</span>
											</div>

											<div class="d-flex align-items-center gap-4">
												<i class="ki-duotone ki-phone fs-4 text-gray-600"><span
													class="path1"></span> <span class="path2"></span></i> <span
													class="text-gray-800">Mobile</span>
											</div>

											<div class="d-flex align-items-center gap-4">
												<i class="ki-duotone ki-dots-square fs-4 text-gray-600"><span
													class="path1"></span> <span class="path2"></span><span
													class="path3"></span><span class="path4"></span></i> <span
													class="text-gray-800">Other</span>
											</div>

											<div class="d-flex align-items-center gap-4">
												<i class="ki-duotone ki-wifi-square fs-4 text-gray-600"><span
													class="path1"></span> <span class="path2"></span><span
													class="path3"></span><span class="path4"></span></i> <span
													class="text-gray-800">Pocket WIFI</span>
											</div>

										</div>
									</div>
								</div>
							</div>
							<!-- ตาราง Borrow -->
							<div class="card">
								<div class="card-body px-6 py-5">
									<table id="borrow_table"
										class="table align-middle table-row-dashed fs-7 gy-3">
										<thead>
											<tr class="text-gray-500 text-uppercase fw-semibold">
												<th class="min-w-60px">ID</th>
												<th class="min-w-90px">ITEM NO</th>
												<th class="min-w-80px">TYPE</th>
												<th class="min-w-220px">EQUIPMENT / DETAIL</th>
												<th class="min-w-120px">LOCATION</th>
												<th class="min-w-180px">STATUS</th>
												<th class="min-w-120px text-end">ACTIONS</th>
											</tr>
										</thead>
										<tbody id="borrowTableBody" class="text-gray-700">
											<c:forEach var="row" items="${borrowList}">
												<tr data-item-no="${row.item_no}" data-name="${row.name}"
													data-detail="${row.detail}" data-location="${row.location}"
													data-borrower="${row.user_borrowid}"
													data-status="${row.statusborrow}" data-type="${row.type}"
													data-serial="${row.serial_no}" data-amount="${row.amount}"
													data-ram="${row.ram}" data-process="${row.process}"
													data-battery="${row.battery}" data-hdd="${row.hdd}"
													data-windows="${row.windows}"
													data-wifi="${row.wifiaddress}" data-lan="${row.lanaddress}"
													data-display="${row.display}"
													data-date-start="${row.date_start}"
													data-date-end="${row.date_end}"
													data-borrower-name="${row.borrower_name}"
													data-employee-id="${row.employee_id}"
													data-name-en="${row.name_en}"
													data-department="${row.department}"
													data-time-create="${row.time_create }"
													data-role-id="${row.role_id }">

													<td class="fw-semibold text-gray-800">
														${row.borrow_id}</td>

													<!-- ITEM NO -->
													<td class="fw-semibold">${row.item_no}</td>

													<!-- TYPE : ใส่ data-type="${row.type}" -->
													<td data-type="${row.type}">
														<div class="d-flex align-items-center">
															<c:choose>
																<c:when test="${row.type == 'c'}">
																	<span class="btn btn-icon btn-light-secondary btn-sm">
																		<i class="ki-duotone ki-laptop fs-4 text-gray-600">
																			<span class="path1"></span><span class="path2"></span>
																	</i>
																	</span>
																</c:when>
																<c:when test="${row.type == 'in'}">
																	<span class="btn btn-icon btn-light-secondary btn-sm">
																		<i class="ki-duotone ki-keyboard fs-4 text-gray-600">
																			<span class="path1"></span><span class="path2"></span>
																	</i>
																	</span>
																</c:when>
																<c:when test="${row.type == 'L' || row.type == 'sl'}">
																	<span class="btn btn-icon btn-light-secondary btn-sm">
																		<i class="ki-duotone ki-verify fs-4 text-gray-600">
																			<span class="path1"></span><span class="path2"></span>
																	</i>
																	</span>
																</c:when>
																<c:when test="${row.type == 'Mob'}">
																	<span class="btn btn-icon btn-light-secondary btn-sm">
																		<i class="ki-duotone ki-phone fs-4 text-gray-600">
																			<span class="path1"></span><span class="path2"></span>
																	</i>
																	</span>
																</c:when>
																<c:when test="${row.type == 'p'}">
																	<span class="btn btn-icon btn-light-secondary btn-sm">
																		<i
																		class="ki-duotone ki-wifi-square fs-4 text-gray-600">
																			<span class="path1"></span><span class="path2"></span>
																			<span class="path3"></span><span class="path4"></span>
																	</i>
																	</span>
																</c:when>
																<c:otherwise>
																	<span class="btn btn-icon btn-light-secondary btn-sm">
																		<i
																		class="ki-duotone ki-dots-square fs-4 text-gray-600">
																			<span class="path1"></span><span class="path2"></span>
																			<span class="path3"></span><span class="path4"></span>
																	</i>
																	</span>
																</c:otherwise>
															</c:choose>
														</div>
													</td>

													<!-- EQUIPMENT / DETAIL -->
													<td>
														<div class="fw-semibold text-gray-900 mb-1">
															${row.name}</div>
														<div class="d-flex align-items-center">
															<span
																class="btn btn-icon btn-light-secondary btn-sm me-2">
																<i class="ki-duotone ki-message-text fs-4 text-gray-600">
																	<span class="path1"></span><span class="path2"></span>
																	<span class="path3"></span><span class="path4"></span>
															</i>
															</span>

															<div class="text-gray-500 fs-8">${row.detail}</div>
														</div>
													</td>

													<!-- LOCATION -->
													<td class="fw-semibold">${row.location}</td>

													<!-- STATUS : ใส่ data-status="${row.statusborrow}" -->
													<td data-status="${row.statusborrow}">
														<div class="d-flex flex-column">
															<div>
																<c:choose>
																	<c:when test="${row.statusborrow == 'B'}">
																		<span class="badge badge-primary me-2">Borrowed</span>
																	</c:when>
																	<c:when test="${row.statusborrow == 'W'}">
																		<span class="badge badge-light me-2">Wait for
																			Approve</span>
																	</c:when>
																	<c:otherwise>
																		<span class="badge badge-light me-2">-</span>
																	</c:otherwise>
																</c:choose>
															</div>
															<span class="fw-normal fs-6 text-gray-800 mt-1">
																${row.borrower_name} </span>
														</div>
													</td>

													<!-- ACTIONS -->
													<td class="text-end"><a href="javascript:void(0);"
														class="btn btn-icon btn-sm btn-light-info me-2 btn-view-borrow"
														data-borrow-id="${row.borrow_id}"> <i
															class="ki-duotone ki-document fs-4"> <span
																class="path1"></span><span class="path2"></span>
														</i>
													</a> <a
														href="${pageContext.request.contextPath}/borrow_edit?id=${row.borrow_id}"
														data-route="borrow_edit"
														class="btn btn-icon btn-sm btn-light-primary me-2"> <i
															class="ki-duotone ki-pencil fs-4"> <span
																class="path1"></span><span class="path2"></span>
														</i>
													</a>
														<button type="button"
															class="btn btn-icon btn-sm btn-light-warning btn-borrow-detail"
															title="Borrow Detail">
															<i class="ki-duotone ki-file-left fs-4"> <span
																class="path1"></span><span class="path2"></span> <span
																class="path3"></span><span class="path4"></span>
															</i>
														</button></td>
												</tr>
											</c:forEach>
										</tbody>

									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!--end::Content container-->
			</div>
			<!--end::Content-->

		</div>
		<!--end::Content wrapper-->
	</div>
	<!--end::Main-->
	<script>
		$(document)
				.ready(
						function() {

							const $keywordInput = $('#searchForm input[name="keyword"]');
							const $statusSelect = $('#searchForm select[name="status"]');
							const $typeSelect = $('#searchForm select[name="type"]');
							const $searchForm = $('#searchForm');

							// ---------- Custom filter ----------
							$.fn.dataTable.ext.search
									.push(function(settings, data, dataIndex) {

										// ใช้กับตารางนี้เท่านั้น
										if (settings.nTable.id !== 'borrow_table')
											return true;

										// ค่าจากฟอร์ม
										var keyword = ($keywordInput.val() || '')
												.trim().toLowerCase();
										var statusFilter = ($statusSelect.val() || '')
												.toUpperCase(); // "", B, R
										var typeFilter = ($typeSelect.val() || '')
												.toLowerCase(); // "", c,in,L,...

										// แถวจริงใน DOM
										var rowNode = settings.aoData[dataIndex].nTr;
										var statusCode = (rowNode.dataset.status || '')
												.toUpperCase(); // B/R/W
										var typeCode = (rowNode.dataset.type || '')
												.toLowerCase(); // c,in,l,sl,...

										// ----- filter ตาม status -----
										if (statusFilter
												&& statusCode !== statusFilter) {
											return false;
										}

										// ----- filter ตาม type -----
										if (typeFilter
												&& typeCode !== typeFilter) {
											return false;
										}

										// ----- filter ตาม keyword -----
										var rowText = (rowNode.textContent || '')
												.toLowerCase();
										if (keyword
												&& rowText.indexOf(keyword) === -1) {
											return false;
										}

										return true;
									});

							// ---------- init DataTable ----------
							var table = $('#borrow_table')
									.DataTable(
											{
												pageLength : 10,
												lengthMenu : [ 10, 20, 50, 100 ],
												ordering : false,
												searching : true,
												info : false,
												pagingType : "simple_numbers",
												dom : "<'row'<'col-12'tr>>"
														+ "<'row mt-3'<'col-sm-6 d-flex align-items-center'l>"
														+ "<'col-sm-6 d-flex justify-content-end'p>>",
												language : {
													lengthMenu : "_MENU_",
													paginate : {
														first : "«",
														last : "»",
														next : ">",
														previous : "<"
													},
													zeroRecords : "ไม่พบข้อมูล"
												}
											});

							// 🔢 อัปเดตจำนวน Items Found ตามแถวที่ถูก filter แล้ว
							table.on('draw', function() {
								var count = table.rows({
									filter : 'applied'
								}).count(); // นับเฉพาะที่มองเห็นหลัง filter
								$('#itemsFound').text(count + ' Items Found');
							});

							// เรียกครั้งแรกให้ sync กับค่าเริ่มต้น
							table.draw();
							// ---------- event ทำให้ redraw ทันที ----------
							$keywordInput.on('input', function() {
								table.draw();
							});

							$statusSelect.on('change', function() {
								table.draw();
							});

							$typeSelect.on('change', function() {
								table.draw();
							});

							$searchForm.on('submit', function(e) {
								e.preventDefault(); // กันไม่ให้ยิงไป action
								table.draw();
							});

						});
	</script>

	<!-- Modal: Equipment Detail -->
	<div class="modal fade" id="borrowModal" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-lg">
			<div class="modal-content">

				<!-- Header -->
				<div class="modal-header border-0 px-6 pt-5 pb-0 align-items-center">
					<h2 class="modal-title fw-bold mb-0">Equipment Detail</h2>

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
					<!-- แถวบน: ซ้าย (ID/Serial/Detail) + ขวา (ชื่อเครื่อง/Amount) -->
					<div class="row mb-6">
						<!-- ซ้าย -->
						<div class="col-md-6 pe-md-6">
							<!-- ID + Status -->
							<div class="d-flex align-items-center gap-5 mb-3 pb-4">
								<a href="javascript:void(0);" id="m_item_link"
									class="fw-bold fs-5 text-primary"></a> <span
									id="m_status_badge"
									class="badge badge-lg rounded-pill px-4 fw-semibold"></span>
							</div>

							<!-- Serial / Detail -->
							<div class="d-flex flex-column fs-7 text-gray-700">
								<!-- แถว Serial No ใส่ pb-4 -->
								<div class="pb-4">
									<span class="fw-normal fs-5 text-gray-700 me-2">Serial
										No:</span> <span id="m_serial"
										class="fw-normal fs-5 text-gray-800 text-break"></span>
								</div>

								<!-- แถว Detail -->
								<div>
									<span class="fw-normal fs-5 text-gray-700 me-2">Detail:</span>
									<span id="m_detail_top"
										class="fw-normal fs-5 text-gray-800 text-break"></span>
								</div>
							</div>

						</div>

						<!-- ขวา -->
						<div class="col-md-6 ps-md-10 mt-5 mt-md-0">
							<!-- icon + name -->
							<div class="d-flex align-items-center mb-1 pb-4">
								<i class="ki-duotone ki-laptop fs-2x text-gray-600 me-3"
									id="m_type_icon"> <span class="path1"></span><span
									class="path2"></span>
								</i> <span class="fw-bold fs-5 text-gray-800 text-break" id="m_name"></span>
							</div>

							<!-- Amount -->
							<div class="fs-5 text-gray-700 fw-normal mt-1 pb-4 me-4">
								Amount: <span id="m_amount" class="fw-semibold text-gray-800"></span>
							</div>

							<!-- Date of Purchase -->
							<div class="fs-5 text-gray-700 fw-normal mt-1 pb-4 me-4">
								Date of Purchase: <span id="m_purchase_date"
									class="fw-normal text-gray-800 text-break"></span>
							</div>
						</div>
					</div>

					<!-- More Detail -->
					<div id="moreDetailWrapper" class="mt-2">
						<a href="#" id="moreDetailToggle"
							class="fw-medium fs-5 pb-4 text-primary d-inline-flex align-items-center"
							role="button" aria-controls="moreDetailCollapse"
							aria-expanded="false"> More Detail <i id="moreDetailIcon"
							class="ki-duotone ki-down fs-4 ms-4"> <span class="path1"></span><span
								class="path2"></span>
						</i>

						</a>


						<div class="collapse mt-3" id="moreDetailCollapse">
							<div class="row fs-7 text-gray-700">
								<!-- ซ้าย: Windows / RAM / Storage / WIFI / Display -->
								<div class="col-md-6 pe-md-10">
									<div class="mb-3 pb-4">
										<span class="fw-normal fs-5 text-gray-700 me-3">Windows</span>
										<span id="m_windows"
											class="ms-1 fw-normal fs-5 text-gray-800 text-break"></span>
									</div>
									<div class="mb-3 pb-4">
										<span class="fw-normal fs-5 text-gray-700 me-3">RAM</span> <span
											id="m_ram"
											class="ms-1 fw-normal fs-5 text-gray-800 text-break"></span>
									</div>
									<div class="mb-3 pb-4">
										<span class="fw-normal fs-5 text-gray-700 me-3">Storage</span>
										<span id="m_hdd"
											class="ms-1 fw-normal fs-5 text-gray-800 text-break"></span>
									</div>
									<div class="mb-3 pb-4">
										<span class="fw-normal fs-5 text-gray-700 me-3">WIFI
											Address</span> <span id="m_wifi"
											class="ms-1 fw-normal fs-5 text-gray-800 text-break"></span>
									</div>
									<div class="mb-3 pb-4">
										<span class="fw-normal fs-5 text-gray-700 me-3">Display</span>
										<span id="m_display"
											class="ms-1 fw-normal fs-5 text-gray-800 text-break"></span>
									</div>
								</div>

								<!-- ขวา: CPU / Storage / Battery / LAN -->
								<div class="col-md-6 ps-md-10">
									<div class="mb-3 pb-4">
										<span class="fw-normal fs-5 text-gray-700 me-3">CPU</span> <span
											id="m_process"
											class="ms-1 fw-normal fs-5 text-gray-800 text-break"></span>
									</div>
									<div class="mb-3 pb-4">
										<span class="fw-normal fs-5 text-gray-700 me-3">Storage</span>
										<span id="m_hddd"
											class="ms-1 fw-normal fs-5 text-gray-800 text-break"></span>
									</div>
									<div class="mb-3 pb-4">
										<span class="fw-normal fs-5 text-gray-700 me-3">Battery</span>
										<span id="m_battery"
											class="ms-1 fw-normal fs-5 text-gray-800 text-break"></span>
									</div>
									<div class="mb-3 pb-4">
										<span class="fw-normal fs-5 text-gray-700 me-3">LAN
											Address</span> <span id="m_lan"
											class="ms-1 fw-normal fs-5 text-gray-800 text-break"></span>
									</div>
								</div>
							</div>
						</div>
					</div>

					<!-- เส้นคั่น -->
					<div class="separator separator-dashed my-6"></div>

					<!-- Borrow Info -->
					<div class="fs-7 text-gray-700">
						<div class="d-flex mb-3 pb-4">
							<span class="fw-bold me-4 fs-5 text-gray-700">Borrow ID</span> <span
								id="m_borrow_id" class="fw-bold fs-5 text-primary"></span>
						</div>
						<div class="d-flex mb-3 pb-4">
							<span class="fw-normal me-4 fs-5 text-gray-700">Borrow by:</span>
							<span id="m_borrower"
								class="fw-medium fs-5 text-gray-800 text-break"></span>
						</div>
						<div class="d-flex mb-3 pb-4">
							<span class="fw-normal me-4 fs-5 text-gray-700">Location:</span>
							<span id="m_location"
								class="fw-normal fs-5 text-gray-800 text-break"></span>
						</div>
						<div class="d-flex mb-1 pb-4">
							<span class="fw-normal me-4 fs-5 text-gray-700">Borrow
								Date:</span> <span id="m_borrow_date"
								class="fw-normal fs-5 text-gray-800 text-break"></span>
						</div>
					</div>
				</div>
				<!-- Footer (Buttons) -->
				<div
					class="modal-footer border-0 pt-0 pb-6 px-6 d-flex justify-content-end gap-3">

					<button type="button" class="btn btn-light" data-bs-dismiss="modal">
						Cancel</button>

					<button type="button" class="btn btn-primary" id="btn_edit">
						Edit</button>

					<!-- status = B -->
					<button type="button" class="btn btn-warning"
						id="btn_request_return" style="display: none;">Request
						for Return</button>

					<!-- status = W -->
					<button type="button" class="btn btn-danger" id="btn_cancel_borrow"
						style="display: none;">Cancel</button>

					<button type="button" class="btn btn-success"
						id="btn_confirm_borrow" style="display: none;">Confirm
						Borrow</button>
				</div>
			</div>
		</div>
	</div>
	<script>
		$(document)
				.ready(
						function() {
							const CTX = "${pageContext.request.contextPath}";

							// ===== Bootstrap modal instances =====
							const borrowModalEl = document
									.getElementById('borrowModal');
							const modalObj = bootstrap.Modal
									.getOrCreateInstance(borrowModalEl);

							const bdModalEl = document
									.getElementById('borrowDetailModal');
							const bdModalObj = bootstrap.Modal
									.getOrCreateInstance(bdModalEl);

							// ===== Helpers =====
							function setText(id, val) {
								const el = document.getElementById(id);
								if (!el)
									return;
								el.textContent = (val !== undefined
										&& val !== null && String(val).trim() !== "") ? val
										: "-";
							}

							// "2014-09-22 17:00:00" -> "22 Sep 2014, 17:00"
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

								const hour = String(d.getHours()).padStart(2,
										'0');
								const min = String(d.getMinutes()).padStart(2,
										'0');

								return month + ' ' + day + ' ' + "," + ' ' + year;
							}

							function formatDateRange(startStr, endStr) {
								const s = formatBorrowDate(startStr);
								const e = formatBorrowDate(endStr);
								if (!s && !e)
									return '-';
								if (s && e)
									return s + ' - ' + e;
								return s || e;
							}

							function formatTime(x) {
								const z = formatBorrowDate(x);
								return z ? z : '-';
							}

							function setBorrowModalButtons(status) {
								$('#btn_request_return').hide();
								$('#btn_cancel_borrow').hide();
								$('#btn_confirm_borrow').hide();

								if (status === 'B') {
									$('#btn_request_return').show();
								} else if (status === 'W') {
									$('#btn_cancel_borrow').show();
									$('#btn_confirm_borrow').show();
								}
							}

							// ===== Collapse: More Detail (modal บน) =====
							const moreCollapseEl = document
									.getElementById('moreDetailCollapse');
							if (moreCollapseEl) {
								const moreCollapseObj = bootstrap.Collapse
										.getOrCreateInstance(moreCollapseEl, {
											toggle : false
										});

								$('#moreDetailToggle').on('click', function(e) {
									e.preventDefault();
									moreCollapseObj.toggle();
								});

								moreCollapseEl.addEventListener(
										'shown.bs.collapse', function() {
											$('#moreDetailIcon').addClass(
													'is-open');
											$('#moreDetailToggle').attr(
													'aria-expanded', 'true');
										});

								moreCollapseEl.addEventListener(
										'hidden.bs.collapse', function() {
											$('#moreDetailIcon').removeClass(
													'is-open');
											$('#moreDetailToggle').attr(
													'aria-expanded', 'false');
										});
							}

							// ===== Collapse: More Detail (modal ล่าง) =====
							const bdCollapseEl = document
									.getElementById('bd_moreDetailCollapse');
							if (bdCollapseEl) {
								const bdCollapseObj = bootstrap.Collapse
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

							// ===== เติมข้อมูลลง modal ล่าง (bd_) =====
							function fillBorrowDetailModal(p) {
								if (!p)
									return;

								// เก็บ borrowId ไว้สำหรับยิง action eBorrowReturn
								$('#borrowDetailModal').data('borrowId',
										p.borrowId);

								// Top info
								$('#bd_item_link').text(
										'ID: ' + (p.itemNo || '-'));
								setText('bd_name', p.name);
								setText('bd_serial', p.serial);
								setText('bd_detail', p.detail);
								setText('bd_amount', p.amountText || '1');
								setText('bd_purchase_date',
										formatTime(p.purchaseDate));

								// badge
								const $b = $('#bd_status_badge');
								$b
										.removeClass()
										.addClass(
												'badge badge-lg rounded-pill px-4 fw-semibold');

								if (p.status === 'B') {
									$b.addClass('bg-warning text-white').text(
											'Borrowing');
								} else if (p.status === 'W') {
									$b.addClass('bg-light text-dark').text(
											'Wait for Approve');
								} else if (p.status === 'R') {
									$b.addClass('bg-success text-white').text(
											'Returned');
								} else {
									$b.addClass('bg-light text-muted')
											.text('-');
								}

								// More detail: เฉพาะ Computer (type = 'c')
								const isComputer = String(p.type || '')
										.toLowerCase() === 'c';
								if (isComputer) {
									$('#bd_moreDetailWrapper').show();
									setText('bd_windows', p.windows);
									setText('bd_ram', p.ram);
									setText('bd_storage', p.hdd);
									setText('bd_storage2', p.hdd);
									setText('bd_display', p.display);
									setText('bd_cpu', p.process);
									setText('bd_battery', p.battery);
									setText('bd_wifi', p.wifi);
									setText('bd_lan', p.lan);
								} else {
									$('#bd_moreDetailWrapper').hide();
								}

								// reset note
								$('#bd_approver_note').val('');
							}

							// ===== เมื่อกดปุ่ม View (ปุ่มในตาราง) =====
							// ต้องมี class .btn-view-borrow ที่ปุ่มในตาราง
							$(document)
									.on(
											'click',
											'.btn-view-borrow',
											function(e) {
												e.preventDefault();

												const $tr = $(this).closest(
														'tr');

												// ✅ borrowId = id ของรายการยืม (ควรเป็นคอลัมน์แรก)
												const borrowId = $.trim($tr
														.find('td').eq(0)
														.text());

												// ข้อมูลจาก data-* ใน <tr>
												const itemNo = $tr
														.data('itemNo')
														|| '';
												const name = $tr.data('name')
														|| '';
												const detail = $tr
														.data('detail')
														|| '';
												const location = $tr
														.data('location')
														|| '';
												const status = String(
														$tr.data('status')
																|| '')
														.toUpperCase();
												const type = String($tr
														.data('type')
														|| '');

												setBorrowModalButtons(status);

												const serial = $tr
														.data('serial')
														|| '';

												// amount (ตัด .0)
												const amountRaw = $tr
														.data('amount');
												let amountText = '1';
												if (amountRaw !== undefined
														&& amountRaw !== null
														&& amountRaw !== '') {
													const n = parseFloat(amountRaw);
													if (!isNaN(n))
														amountText = (n % 1 === 0) ? String(parseInt(
																n, 10))
																: String(n);
													else
														amountText = String(amountRaw);
												}

												const ram = $tr.data('ram')
														|| '';
												const process = $tr
														.data('process')
														|| '';
												const battery = $tr
														.data('battery')
														|| '';
												const hdd = $tr.data('hdd')
														|| '';
												const windows = $tr
														.data('windows')
														|| '';
												const wifi = $tr.data('wifi')
														|| '';
												const lan = $tr.data('lan')
														|| '';
												const display = $tr
														.data('display')
														|| '';

												const dateStart = $tr
														.data('dateStart')
														|| '';
												const dateEnd = $tr
														.data('dateEnd')
														|| '';
												const timeCreate = $tr
														.data('timeCreate')
														|| '';

												// ===== เติม modal บน (ของคุณเดิม) =====
												// (ถ้า id บางตัวไม่มีจะไม่พัง เพราะเราใช้ setText)
												setText('m_item_link', 'ID: '
														+ itemNo);
												setText('m_borrow_id', 'ID: '
														+ itemNo);
												setText('m_name', name);
												setText('m_serial', serial);
												setText('m_detail_top', detail);
												setText('m_amount', amountText);
												setText('m_location', location);
												setText('m_borrow_date',
														formatDateRange(
																dateStart,
																dateEnd));
												setText('m_purchase_date',
														formatTime(timeCreate));

												// badge modal บน
												const $badge = $('#m_status_badge');
												if ($badge.length) {
													$badge
															.removeClass()
															.addClass(
																	'badge badge-lg rounded-pill px-4 fw-semibold');
													if (status === 'B')
														$badge
																.addClass(
																		'bg-warning text-white')
																.text(
																		'Borrowing');
													else if (status === 'R')
														$badge
																.addClass(
																		'bg-success text-white')
																.text(
																		'Returned');
													else if (status === 'W')
														$badge
																.addClass(
																		'bg-light text-dark')
																.text(
																		'Wait for Approve');
													else
														$badge
																.addClass(
																		'bg-light text-muted')
																.text('-');
												}

												// More detail modal บน
												const moreWrapper = $('#moreDetailWrapper');
												if (String(type).toLowerCase() === 'c') {
													moreWrapper.show();
													setText('m_windows',
															windows);
													setText('m_ram', ram);
													setText('m_hdd', hdd);
													setText('m_hddd', hdd);
													setText('m_display',
															display);
													setText('m_process',
															process);
													setText('m_battery',
															battery);
													setText('m_wifi', wifi);
													setText('m_lan', lan);
												} else {
													moreWrapper.hide();
												}

												// ✅ เก็บ payload ไว้ให้ modal ล่างใช้
												$('#borrowModal')
														.data(
																'borrowPayload',
																{
																	borrowId : borrowId, // สำคัญ: ใช้ยิง action
																	itemNo : itemNo, // เอาไปแสดงเป็น ID:
																	name : name,
																	serial : serial,
																	detail : detail,
																	amountText : amountText,
																	purchaseDate : timeCreate,
																	status : status,
																	type : type,
																	windows : windows,
																	ram : ram,
																	hdd : hdd,
																	display : display,
																	process : process,
																	battery : battery,
																	wifi : wifi,
																	lan : lan
																});

												// show modal บน
												modalObj.show();
											});

							// ===== กดปุ่ม Request for Return (ใน modal บน) -> เปิด modal ล่าง พร้อมข้อมูล =====
							$('#btn_request_return')
									.on(
											'click',
											function(e) {
												e.preventDefault();

												const payload = $(
														'#borrowModal').data(
														'borrowPayload');

												// ✅ ผูก event ก่อนค่อย hide (กันพลาด hidden event)
												$('#borrowModal')
														.one(
																'hidden.bs.modal',
																function() {
																	fillBorrowDetailModal(payload);
																	bdModalObj
																			.show();
																});

												modalObj.hide();
											});

							// ===== ปุ่ม Cancel / Confirm (status=W) ใน modal บน =====
							function ajaxBorrowAction(actionUrl, borrowId) {
								return $.ajax({
									url : actionUrl,
									type : 'POST',
									dataType : 'json',
									data : {
										id : borrowId
									}
								});
							}

							$('#btn_cancel_borrow')
									.on(
											'click',
											function(e) {
												e.preventDefault();
												const payload = $(
														'#borrowModal').data(
														'borrowPayload')
														|| {};
												const borrowId = payload.borrowId
														|| '';
												if (!borrowId)
													return alert('Borrow ID not found.');

												if (!confirm('Cancel this borrow request?'))
													return;

												ajaxBorrowAction(
														CTX
																+ '/eBorrowCancel.action',
														borrowId)
														.done(
																function(data) {
																	if (data
																			&& data.message === 'success') {
																		window.location.href = CTX
																				+ '/borrow_list.action';
																	} else {
																		alert('Cancel failed: '
																				+ (data ? data.message
																						: 'no response'));
																	}
																})
														.fail(
																function(xhr) {
																	console
																			.log(
																					'RAW:',
																					xhr.responseText);
																	alert('Cancel error');
																});
											});

							$('#btn_confirm_borrow')
									.on(
											'click',
											function(e) {
												e.preventDefault();
												const payload = $(
														'#borrowModal').data(
														'borrowPayload')
														|| {};
												const borrowId = payload.borrowId
														|| '';
												if (!borrowId)
													return alert('Borrow ID not found.');

												if (!confirm('Confirm this borrow request?'))
													return;

												ajaxBorrowAction(
														CTX
																+ '/eBorrowConfirm.action',
														borrowId)
														.done(
																function(data) {
																	if (data
																			&& data.message === 'success') {
																		window.location.href = CTX
																				+ '/borrow_list.action';
																	} else {
																		alert('Confirm failed: '
																				+ (data ? data.message
																						: 'no response'));
																	}
																})
														.fail(
																function(xhr) {
																	console
																			.log(
																					'RAW:',
																					xhr.responseText);
																	alert('Confirm error');
																});
											});
							// ===== Edit -> ไปหน้า borrow_edit.jsp?id=borrowId =====
							$('#btn_edit')
									.on(
											'click',
											function(e) {
												e.preventDefault();

												const payload = $(
														'#borrowModal').data(
														'borrowPayload')
														|| {};
												const borrowId = payload.borrowId
														|| '';

												if (!borrowId) {
													alert('Borrow ID not found.');
													return;
												}

												// ✅ ไปที่ action ที่ใช้เปิดหน้าแก้ไข (forward ไป borrow_edit.jsp)
												window.location.href = CTX
														+ '/borrow_edit.action?id='
														+ encodeURIComponent(borrowId);

												// ถ้าของคุณใช้ชื่อ action เป็น eBorrowEdit ให้ใช้บรรทัดนี้แทน:
												// window.location.href = CTX + '/eBorrowEdit.action?id=' + encodeURIComponent(borrowId);
											});
						});
	</script>
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
		$(document)
				.ready(
						function() {

							// modal instance
							var bdModalEl = document
									.getElementById('borrowDetailModal');
							var bdModalObj = new bootstrap.Modal(bdModalEl);

							// collapse instance
							var bdCollapseEl = document
									.getElementById('bd_moreDetailCollapse');
							var bdCollapseObj = bootstrap.Collapse
									.getOrCreateInstance(bdCollapseEl, {
										toggle : false
									});

							// toggle more detail
							$('#bd_moreDetailToggle').on('click', function(e) {
								e.preventDefault();
								bdCollapseObj.toggle();
							});

							bdCollapseEl.addEventListener('shown.bs.collapse',
									function() {
										$('#bd_moreDetailIcon').addClass(
												'is-open');
										$('#bd_moreDetailToggle').attr(
												'aria-expanded', 'true');
									});

							bdCollapseEl.addEventListener('hidden.bs.collapse',
									function() {
										$('#bd_moreDetailIcon').removeClass(
												'is-open');
										$('#bd_moreDetailToggle').attr(
												'aria-expanded', 'false');
									});

							// format date (ใช้แบบเดิมของคุณ)
							function formatBorrowDate(dtStr) {
								if (!dtStr)
									return '';
								var d = new Date(dtStr.replace(' ', 'T'));
								if (isNaN(d.getTime()))
									return dtStr;

								var day = d.getDate();
								var monthNames = [ 'Jan', 'Feb', 'Mar', 'Apr',
										'May', 'Jun', 'Jul', 'Aug', 'Sep',
										'Oct', 'Nov', 'Dec' ];
								var month = monthNames[d.getMonth()];
								var year = d.getFullYear();
								return month + ' ' + day + ' ' + "," + ' ' + year;
							}

							// click open Borrow Detail
							$(document)
									.on(
											'click',
											'.btn-borrow-detail',
											function(e) {
												e.preventDefault();

												var $tr = $(this).closest('tr');

												var borrowId = $.trim($tr.find(
														'td').eq(0).text()); // ใช้คอลัมน์แรกเป็น Borrow ID

												// basic
												var itemNo = $tr.data('itemNo')
														|| $tr.data('item-no')
														|| '';
												var name = $tr.data('name')
														|| '';
												var detail = $tr.data('detail')
														|| '';
												var serial = $tr.data('serial')
														|| '';
												var status = (($tr
														.data('status') || '') + '')
														.toUpperCase();

												// right
												var amountRaw = $tr
														.data('amount');
												var amountText = '1';
												if (amountRaw !== undefined
														&& amountRaw !== null
														&& amountRaw !== '') {
													var n = parseFloat(amountRaw);
													amountText = (!isNaN(n) && n % 1 === 0) ? parseInt(
															n, 10).toString()
															: (amountRaw + '');
												}

												var timeCreate = $tr
														.data('timeCreate')
														|| $tr
																.data('time-create')
														|| '';

												// more detail
												var type = (($tr.data('type') || '') + '')
														.toLowerCase();
												var windows = $tr
														.data('windows')
														|| '';
												var ram = $tr.data('ram') || '';
												var hdd = $tr.data('hdd') || '';
												var wifi = $tr.data('wifi')
														|| '';
												var lan = $tr.data('lan') || '';
												var display = $tr
														.data('display')
														|| '';
												var cpu = $tr.data('process')
														|| $tr.data('cpu')
														|| '';
												var battery = $tr
														.data('battery')
														|| '';

												// badge
												var $badge = $('#bd_status_badge');
												$badge
														.removeClass()
														.addClass(
																'badge badge-lg rounded-pill px-4 fw-semibold');

												if (status === 'B') {
													$badge
															.addClass(
																	'bg-warning text-white')
															.text('Borrowing');
												} else if (status === 'R') {
													$badge
															.addClass(
																	'bg-success text-white')
															.text('Returned');
												} else if (status === 'W') {
													$badge
															.addClass(
																	'bg-light text-dark')
															.text(
																	'Wait for Approve');
												} else {
													$badge
															.addClass(
																	'bg-light text-muted')
															.text('-');
												}

												// fill
												$('#bd_item_link').text(
														'ID: ' + itemNo);
												$('#bd_name').text(name);
												$('#bd_serial').text(serial);
												$('#bd_detail').text(detail);
												$('#bd_amount')
														.text(amountText);
												$('#bd_purchase_date')
														.text(
																formatBorrowDate(timeCreate)
																		|| '-');

												// reset collapse to closed every time
												bdCollapseObj.hide();
												$('#bd_moreDetailIcon')
														.removeClass('is-open');
												$('#bd_moreDetailToggle').attr(
														'aria-expanded',
														'false');

												// show/hide more detail (ตามแนวเดิม: type === 'c' เท่านั้น)
												if (type === 'c') {
													$('#bd_moreDetailWrapper')
															.show();
													$('#bd_windows').text(
															windows);
													$('#bd_ram').text(ram);
													$('#bd_storage').text(hdd);
													$('#bd_storage2').text(hdd);
													$('#bd_wifi').text(wifi);
													$('#bd_lan').text(lan);
													$('#bd_display').text(
															display);
													$('#bd_cpu').text(cpu);
													$('#bd_battery').text(
															battery);
												} else {
													$('#bd_moreDetailWrapper')
															.hide();
												}
												$('#borrowDetailModal').data(
														'borrowId', borrowId);

												// clear note each open (ตามรูป)
												$('#bd_approver_note').val('');

												// show modal
												bdModalObj.show();
											});
							const CTX = "${pageContext.request.contextPath}";

							$('#bd_request_return')
									.on(
											'click',
											function(e) {
												e.preventDefault();

												const borrowId = $(
														'#borrowDetailModal')
														.data('borrowId')
														|| '';
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
																		&& data.message === "success") {
																	alert("Return request submitted successfully!");
																	bdModalObj
																			.hide();
																	window.location.href = CTX
																			+ "/borrow_list.action";
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
							// FIX: ให้ปุ่ม X / Cancel ปิด modal แน่นอน (กันโดน theme กัน event)
							$('#borrowDetailModal').on('click',
									'[data-bs-dismiss="modal"]', function(e) {
										e.preventDefault();
										e.stopPropagation();
										bdModalObj.hide();
									});
						});
	</script>
</body>
</html>