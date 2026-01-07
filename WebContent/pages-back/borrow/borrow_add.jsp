<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page
	import="java.util.*, com.google.gson.Gson, com.google.gson.reflect.TypeToken, java.lang.reflect.Type"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.text.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%
String userJson = (String) request.getAttribute("userList");
String equipsJson = (String) request.getAttribute("equipments");
String statusJson = (String) request.getAttribute("status");

Gson gson = new Gson();

// userListObj เป็น List<Map> เพราะ userListJSON() มักคืนเป็น JSON ของ map
Type listMapType = new TypeToken<List<Map<String, Object>>>() {
}.getType();
List<Map<String, Object>> userListObj = (userJson != null && !userJson.trim().isEmpty())
		? gson.fromJson(userJson, listMapType)
		: new ArrayList<>();

// equipmentsObj เป็น List<Map> เช่นกัน (เพราะคุณส่ง toJson(list) มา)
List<Map<String, Object>> equipmentsObj = (equipsJson != null && !equipsJson.trim().isEmpty())
		? gson.fromJson(equipsJson, listMapType)
		: new ArrayList<>();

// statusListObj เป็น List<Map> เช่นกัน (เช่น {code:'A',name:'Available'} แล้วแต่ schema)
List<Map<String, Object>> statusListObj = (statusJson != null && !statusJson.trim().isEmpty())
		? gson.fromJson(statusJson, listMapType)
		: new ArrayList<>();

request.setAttribute("userListObj", userListObj);
request.setAttribute("equipmentsObj", equipmentsObj);
request.setAttribute("statusListObj", statusListObj);

// preselect equipment id (จาก eBorrow())
String eId = (String) request.getAttribute("eId");
request.setAttribute("equipId", eId);
%>

<%
Logger log = Logger.getLogger("com.cubesofttech.jsp.borrow_add");
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
	<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
		<div class="d-flex flex-column flex-column-fluid">

			<!-- Toolbar -->
			<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
				<div id="kt_app_toolbar_container"
					class="app-container container-fluid d-flex align-items-center justify-content-start">
					<div
						class="page-title d-flex flex-column flex-wrap me-3 align-items-start">
						<h1 class="page-heading fw-semibold my-0 text-start"
							style="color: #4b5675;">Borrow Add</h1>
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
							<li class="breadcrumb-item text-muted">Borrow Add</li>
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
								action="${pageContext.request.contextPath}/eBorrowAdd.action"
								method="post" class="card h-xl-100 shadow-none">

								<!-- ถ้าเป็นหน้าเพิ่มใหม่ ไม่ต้องมี id ก็ลบได้ -->
								<input type="hidden" name="id" value="" /> <input type="hidden"
									name="onlineUser.id" value="${sessionScope.onlineUser.id}" />


								<div class="card-header py-4"
									style="border-bottom: 1px solid #E4E6EF;">
									<h3 class="card-title fw-bold mb-0">Borrow Equipment</h3>
								</div>

								<div class="card-body pt-6">

									<!-- Borrower -->
									<div class="mb-7">
										<label class="form-label required fw-medium">Borrower</label>
										<select name="user"
											class="form-select form-select-lg fw-medium"
											data-control="select2" data-placeholder="Select Borrower"
											data-hide-search="true" required>
											<option value="">-- Select borrower --</option>

											<c:forEach var="u" items="${userListObj}">
												<c:set var="uid"
													value="${not empty u['id'] ? u['id']
            : (not empty u['user_id'] ? u['user_id']
            : (not empty u['USER_ID'] ? u['USER_ID'] : ''))}" />

												<c:set var="emp"
													value="${not empty u['employee_id'] ? u['employee_id']
            : (not empty u['employeeId'] ? u['employeeId']
            : '')}" />

												<c:set var="nameTH"
													value="${not empty u['name'] ? u['name']
            : (not empty u['fullname'] ? u['fullname']
            : '')}" />

												<c:set var="nameEN"
													value="${not empty u['name_en'] ? u['name_en']
            : (not empty u['nameEn'] ? u['nameEn']
            : '')}" />
												<c:set var="role"
													value="${not empty u['role'] ? u['role'] : ''}" />
												<option value="${uid}">${emp}-${nameTH}-${nameEN}-
													${role}</option>
											</c:forEach>
										</select>

									</div>

									<!-- Status -->
									<div class="mb-7">
										<label class="required fw-medium mb-2 d-block">Status</label>
										<select name="status"
											class="form-select form-select-lg text-muted" required>
											<option value="">Select status</option>
											<option value="B">Borrowing</option>
											<option value="W">Wait for approve</option>
										</select>

									</div>

									<!-- Equipment -->
									<div class="mb-7">
										<label class="required fw-medium mb-2 d-block">Equipment</label>

										<select id="equipment_select" name="equipment"
											class="form-select form-select-lg fw-medium text-muted"
											required>
											<option value="">Select equipment</option>

											<c:forEach var="e" items="${equipmentsObj}">
												<c:set var="eqStatusLog"
													value="${not empty e['statusLog'] ? e['statusLog']
        : (not empty e['status_log'] ? e['status_log']
        : (not empty e['STATUS_LOG'] ? e['STATUS_LOG'] : ''))}" />


												<!-- ID -->
												<c:set var="eqId"
													value="${not empty e['equipmentId'] ? e['equipmentId']
              : (not empty e['equipment_id'] ? e['equipment_id']
           		:'')}" />

												<!-- ItemNo / Name -->
												<c:set var="itemNo"
													value="${not empty e['itemNo'] ? e['itemNo']
              : (not empty e['item_no'] ? e['item_no']
              :'')}" />

												<c:set var="eqName"
													value="${not empty e['name'] ? e['name']
              :''}" />

												<!-- Basic fields -->
												<c:set var="eqStatus"
													value="${not empty e['status'] ? e['status']
              :''}" />

												<c:set var="eqType"
													value="${not empty e['type'] ? e['type']
              :''}" />

												<c:set var="eqSerial"
													value="${not empty e['serialNo'] ? e['serialNo']
              : (not empty e['serial_no'] ? e['serial_no']
              :'')}" />

												<c:set var="eqAmount"
													value="${not empty e['amount'] ? e['amount']
              :''}" />

												<c:set var="eqDetail"
													value="${not empty e['detail'] ? e['detail']
              :''}" />

												<c:set var="eqImage"
													value="${not empty e['image'] ? e['image']
              :''}" />

												<c:set var="eqPurchase"
													value="${not empty e['timeCreate'] ? e['timeCreate']
              : (not empty e['time_create'] ? e['time_create']
              :'')}" />

												<!-- More Detail fields -->
												<c:set var="eqWindows"
													value="${not empty e['windows'] ? e['windows'] : ''}" />
												<c:set var="eqCPU"
													value="${not empty e['process'] ? e['process'] : (not empty e['cpu'] ? e['cpu'] : '')}" />
												<c:set var="eqRam"
													value="${not empty e['ram'] ? e['ram'] : ''}" />
												<c:set var="eqStorage"
													value="${not empty e['hdd'] ? e['hdd'] : (not empty e['storage'] ? e['storage'] : '')}" />
												<c:set var="eqBattery"
													value="${not empty e['battery'] ? e['battery'] : ''}" />
												<c:set var="eqWifi"
													value="${not empty e['wifiaddress'] ? e['wifiaddress'] : (not empty e['wifiAddress'] ? e['wifiAddress'] : '')}" />
												<c:set var="eqLan"
													value="${not empty e['lanaddress'] ? e['lanaddress'] : (not empty e['lanAddress'] ? e['lanAddress'] : '')}" />
												<c:set var="eqDisplay"
													value="${not empty e['display'] ? e['display'] : ''}" />

												<c:set var="eqIdClean" value="${fn:replace(eqId, '.0', '')}" />

												<option value="${fn:escapeXml(eqIdClean)}"
													data-itemno="${fn:escapeXml(itemNo)}"
													data-name="${fn:escapeXml(eqName)}"
													data-status="${fn:escapeXml(eqStatus)}"
													data-type="${fn:escapeXml(eqType)}"
													data-serial="${fn:escapeXml(eqSerial)}"
													data-amount="${fn:escapeXml(eqAmount)}"
													data-detail="${fn:escapeXml(eqDetail)}"
													data-image="${fn:escapeXml(eqImage)}"
													data-purchase="${fn:escapeXml(eqPurchase)}"
													data-windows="${fn:escapeXml(eqWindows)}"
													data-cpu="${fn:escapeXml(eqCPU)}"
													data-ram="${fn:escapeXml(eqRam)}"
													data-storage="${fn:escapeXml(eqStorage)}"
													data-battery="${fn:escapeXml(eqBattery)}"
													data-wifi="${fn:escapeXml(eqWifi)}"
													data-lan="${fn:escapeXml(eqLan)}"
													data-display="${fn:escapeXml(eqDisplay)}"
													data-statuslog="${fn:escapeXml(eqStatusLog)}">
													${itemNo} - ${eqName}</option>

											</c:forEach>
										</select>
									</div>


									<!-- Start / End Date -->
									<div class="row mb-7">
										<div class="col-lg-6">
											<label class="form-label required fw-medium fs-6">Start
												Date</label>
											<div class="position-relative d-flex align-items-center">
												<i
													class="ki-outline ki-calendar fs-3 position-absolute ms-4"></i>
												<input type="text" id="start_date"
													class="form-control form-control-lg ps-12" name="date_from"
													placeholder="Select Date" value="" autocomplete="off"
													required />
											</div>
										</div>

										<div class="col-lg-6">
											<label class="form-label required fw-medium fs-6">End
												Date</label>
											<div class="position-relative d-flex align-items-center">
												<i
													class="ki-outline ki-calendar fs-3 position-absolute ms-4"></i>
												<input type="text" id="end_date"
													class="form-control form-control-lg ps-12" name="date_to"
													placeholder="Select Date" value="" autocomplete="off"
													required />
											</div>
										</div>
									</div>


									<!-- Location -->
									<div class="mb-7">
										<label class="required fw-medium fs-6 mb-2 d-block">Location</label>
										<input class="form-control form-control-lg" type="text"
											name="location" value="" placeholder="Location" required />
									</div>

									<!-- Reason -->
									<div class="mb-7">
										<label class="fw-medium fs-6 mb-2 d-block">Reason</label>
										<textarea class="form-control form-control-lg" rows="4"
											name="reason" placeholder="ระบุเหตุผลการยืม"></textarea>
									</div>

									<!-- Contact Address -->
									<div class="mb-7">
										<label class="fw-medium fs-6 mb-2 d-block">Contact
											Address</label>
										<textarea class="form-control form-control-lg" rows="4"
											name="contact" placeholder="Address"></textarea>
									</div>

									<!-- Remark -->
									<div class="mb-7">
										<label class="fw-medium fs-6 mb-2 d-block">Remark</label>
										<textarea class="form-control form-control-lg" rows="4"
											name="remark" placeholder="Remark"></textarea>
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
						<!-- Right -->
						<div class="col-xl-4">

							<!-- ================== Equipment Detail Card (STATIC TEMPLATE) ================== -->
							<div class="card mb-5">
								<div class="card-header border-0 pt-6">
									<div
										class="card-title d-flex justify-content-between align-items-center w-100">
										<span class="fw-bold fs-4 me-2">Equipment Detail</span>
									</div>
								</div>

								<div class="card-body pt-0">

									<!-- TOP -->
									<div class="mb-4 d-flex flex-column align-items-start">
										<div
											class="mb-3 d-flex justify-content-between align-items-center w-100">
											<span class="fw-bold fs-1 text-primary" id="d_itemNo">-</span>

											<span> <!-- badge จะถูกเปลี่ยน class/ข้อความ --> <span
												id="d_badge"
												class="badge badge-lg rounded-pill px-4 fw-semibold bg-light text-gray-700">
													- </span>
											</span>
										</div>

										<div class="symbol symbol-150px">
											<img id="d_img" src="/assets/media/placeholder/equipment.png"
												alt="equipment" class="border rounded-3" />
										</div>
									</div>

									<!-- ROWS (แบบรูปซ้าย ไม่เพิ่ม style) -->
									<div
										class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
										<div class="text-gray-600">Name:</div>
										<div class="fw-semibold text-gray-800 text-end text-break"
											id="d_name"></div>
									</div>

									<div
										class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
										<div class="text-gray-600">Type:</div>

										<!-- ฝั่งขวาให้ชิดขวาสุดเหมือนแถวอื่น -->
										<div
											class="fw-semibold text-gray-800 d-flex align-items-center justify-content-end text-end w-100">
											<span id="d_typeText">-</span>

											<!-- ไอคอนค่อยดันออกไปด้วย ms-3 -->
											<span id="d_typeIcons"
												class="d-inline-flex align-items-center ms-3"> <i
												id="ico_c"
												class="ki-duotone ki-laptop fs-4 text-gray-600 d-none"><span
													class="path1"></span><span class="path2"></span></i> <i
												id="ico_in"
												class="ki-duotone ki-keyboard fs-4 text-gray-600 d-none"><span
													class="path1"></span><span class="path2"></span></i> <i
												id="ico_sl"
												class="ki-duotone ki-verify fs-4 text-gray-600 d-none"><span
													class="path1"></span><span class="path2"></span></i> <i
												id="ico_mob"
												class="ki-duotone ki-phone fs-4 text-gray-600 d-none"><span
													class="path1"></span><span class="path2"></span></i> <i
												id="ico_p"
												class="ki-duotone ki-wifi-square fs-4 text-gray-600 d-none"><span
													class="path1"></span><span class="path2"></span><span
													class="path3"></span><span class="path4"></span></i> <i
												id="ico_other"
												class="ki-duotone ki-dots-square fs-4 text-gray-600 d-none"><span
													class="path1"></span><span class="path2"></span><span
													class="path3"></span><span class="path4"></span></i>
											</span>
										</div>
									</div>
									<div
										class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
										<div class="text-gray-600">Serial No:</div>
										<div class="fw-semibold text-gray-800 text-end text-break"
											id="d_serial"></div>
									</div>

									<div
										class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
										<div class="text-gray-600">Amount:</div>
										<div class="fw-semibold text-gray-800 text-end" id="d_amount"></div>
									</div>

									<div
										class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
										<div class="text-gray-600">Date of Purchase:</div>
										<div class="fw-semibold text-gray-800 text-end text-break"
											id="d_purchase"></div>
									</div>

									<div
										class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
										<div class="text-gray-600">Detail:</div>
										<div class="fw-semibold text-gray-800 text-end text-break"
											id="d_detail"></div>
									</div>

									<!-- More Detail -->
									<div id="moreDetailSection">
										<!-- ปุ่ม More Detail เป็น “แถว” เหมือนรูปซ้าย -->
										<button type="button" id="btn_moreDetail_1"
											class="btn btn-link p-0 w-100 text-primary fw-semibold d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200"
											aria-expanded="false" aria-controls="moreDetailCollapse_1">
											<span>More Detail</span> <i
												class="ki-duotone ki-down fs-3" id="icon_1"> <span
												class="path1"></span><span class="path2"></span>
											</i>
										</button>

										<div class="collapse" id="moreDetailCollapse_1">

											<div
												class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
												<div class="text-gray-600">Windows</div>
												<div class="fw-semibold text-gray-800 text-end text-break"
													id="d_windows">-</div>
											</div>

											<div
												class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
												<div class="text-gray-600">CPU</div>
												<div class="fw-semibold text-gray-800 text-end text-break"
													id="d_cpu">-</div>
											</div>

											<div
												class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
												<div class="text-gray-600">Ram</div>
												<div class="fw-semibold text-gray-800 text-end text-break"
													id="d_ram">-</div>
											</div>

											<div
												class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
												<div class="text-gray-600">Storage</div>
												<div class="fw-semibold text-gray-800 text-end text-break"
													id="d_storage">-</div>
											</div>

											<div
												class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
												<div class="text-gray-600">Battery</div>
												<div class="fw-semibold text-gray-800 text-end text-break"
													id="d_battery">-</div>
											</div>

											<div
												class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
												<div class="text-gray-600">WIFI Address</div>
												<div class="fw-semibold text-gray-800 text-end text-break"
													id="d_wifi">-</div>
											</div>

											<div
												class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
												<div class="text-gray-600">LAN Address</div>
												<div class="fw-semibold text-gray-800 text-end text-break"
													id="d_lan">-</div>
											</div>

											<div
												class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
												<div class="text-gray-600">Display</div>
												<div class="fw-semibold text-gray-800 text-end text-break"
													id="d_display">-</div>
											</div>

										</div>
									</div>
								</div>
							</div>
							<!-- ================== Status Log (STATIC TEMPLATE) ================== -->
							<div class="card">
								<div class="card-header border-0 pt-6">
									<div class="card-title">
										<span class="fw-bold fs-5">Status Log</span>
									</div>
								</div>

								<div class="card-body pt-0">
									<div id="statusLogList"></div>

									<div id="statusLogEmpty" class="text-muted d-none">No
										status log</div>
								</div>

							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
document.addEventListener("DOMContentLoaded", function () {
  const collapseEl = document.getElementById("moreDetailCollapse_1");
  const btn = document.getElementById("btn_moreDetail_1");
  const iconEl = document.getElementById("icon_1");
  if (!collapseEl || !btn || !iconEl) return;

  const instance = bootstrap.Collapse.getOrCreateInstance(collapseEl, { toggle: false });

  btn.addEventListener("click", function (e) {
    e.preventDefault();
    e.stopPropagation();

    // ถ้าเปิดอยู่ -> ปิด, ถ้าปิดอยู่ -> เปิด
    if (collapseEl.classList.contains("show")) instance.hide();
    else instance.show();
  });

  collapseEl.addEventListener("show.bs.collapse", function () {
    iconEl.style.transform = "rotate(180deg)";
    btn.setAttribute("aria-expanded", "true");
  });

  collapseEl.addEventListener("hide.bs.collapse", function () {
    iconEl.style.transform = "rotate(0deg)";
    btn.setAttribute("aria-expanded", "false");
  });
});
</script>
	<script>
document.addEventListener("DOMContentLoaded", function () {

  // กันกรณี flatpickr ไม่ถูกโหลด
  if (typeof flatpickr === "undefined") {
    console.error("flatpickr not loaded");
    return;
  }

  const startEl = document.getElementById("start_date");
  const endEl   = document.getElementById("end_date");

  // init flatpickr (ส่งค่าแบบ dd-MM-yyyy)
  const startPicker = flatpickr(startEl, {
	enableTime : true,
	time_24hr : true,
    dateFormat: "d-m-Y",
    allowInput: true
  });

  const endPicker = flatpickr(endEl, {
	enableTime : true,
	time_24hr : true,
    dateFormat: "d-m-Y",
    allowInput: true
  });

  // end ต้องไม่ก่อน start (ใช้ minDate ของ flatpickr)
  startEl.addEventListener("change", function () {
    const v = this.value || "";
    endPicker.set("minDate", v || null);

    // ถ้า end ว่าง หรือ end < start ให้ดัน end = start
    if (v && endEl.value && endEl.value < v) {
      endEl.value = v;
    }
  });

});
</script>
	<script>
		document
				.addEventListener(
						"DOMContentLoaded",
						function() {
							const CTX = "${pageContext.request.contextPath}";
							const sel = document
									.getElementById("equipment_select");

							function setText(id, val) {
								const el = document.getElementById(id);
								if (!el)
									return;
								el.textContent = (val && String(val).trim() !== "") ? val
										: "";
							}

							function setBadge(status) {
								  const badge = document.getElementById("d_badge");
								  if (!badge) return;

								  const st = (status || "").toUpperCase();

								  const map = {
								    A: { text: "Available", cls: "bg-success text-white" },
								    B: { text: "Borrowing", cls: "bg-primary text-white" },
								    W: { text: "Wait for approve", cls: "bg-warning text-dark" },
								    C: { text: "Corrupted", cls: "bg-danger text-white" },
								    F: { text: "Fixed", cls: "bg-info text-white" },
								    L: { text: "Lost", cls: "bg-dark text-white" },
								    S: { text: "Sold Out", cls: "bg-warning text-dark" },
								    Z: { text: "Disabled", cls: "bg-secondary text-white" }
								  };

								  badge.className = "badge badge-lg rounded-pill px-4 fw-semibold bg-light text-gray-700";
								  badge.textContent = "";

								  if (map[st]) {
								    badge.textContent = map[st].text;
								    badge.className = "badge badge-lg rounded-pill px-4 fw-semibold " + map[st].cls;
								  }
								}


							function setImage(imgPath, altText) {
								const img = document.getElementById("d_img");
								if (!img)
									return;

								let src = (imgPath || "").trim();
								if (!src) {
									src = CTX
											+ "/assets/media/placeholder/equipment.png";
								} else if (!src.startsWith("http")) {
									if (!src.startsWith("/"))
										src = "/" + src;
									src = CTX + src;
								}
								img.src = src;
								img.alt = altText || "equipment";
							}
							function setTypeUI(typeCode) {
								  const textEl = document.getElementById("d_typeText");
								  const iconsWrap = document.getElementById("d_typeIcons");
								  if (!textEl) return;

								  // ซ่อนไอคอนทั้งหมดก่อน
								  const ids = ["ico_c","ico_in","ico_sl","ico_mob","ico_p","ico_other"];
								  ids.forEach(id => document.getElementById(id)?.classList.add("d-none"));

								  const t = (typeCode ?? "").toString().trim().toLowerCase();

								  if (!t) {
  									textEl.textContent = ""; 
									  if (iconsWrap) iconsWrap.classList.add("d-none");
									  return;
									}


								  // ✅ มีค่าแล้ว -> โชว์พื้นที่ไอคอนกลับมา
								  if (iconsWrap) iconsWrap.classList.remove("d-none");

								  if (t === "c") {
								    textEl.textContent = "Computer";
								    document.getElementById("ico_c")?.classList.remove("d-none");
								  } else if (t === "in") {
								    textEl.textContent = "Instrument";
								    document.getElementById("ico_in")?.classList.remove("d-none");
								  } else if (t === "sl" || t === "l") {
								    textEl.textContent = "Software License";
								    document.getElementById("ico_sl")?.classList.remove("d-none");
								  } else if (t === "mob") {
								    textEl.textContent = "Mobile";
								    document.getElementById("ico_mob")?.classList.remove("d-none");
								  } else if (t === "p") {
								    textEl.textContent = "Pocket WIFI";
								    document.getElementById("ico_p")?.classList.remove("d-none");
								  } else {
								    textEl.textContent = "Other";
								    document.getElementById("ico_other")?.classList.remove("d-none");
								  }
								}

							function formatPurchase(raw) {
								  var s = (raw || "").toString().trim();
								  if (!s || s.toLowerCase() === "null") return "-";

								  // ล้างช่องว่างแปลกๆ
								  s = s.replace(/\u202F/g, " ").replace(/\u00A0/g, " ").trim();
								  s = s.replace("T", " ");
								  if (s.endsWith("Z")) s = s.slice(0, -1).trim();

								  var monthNames = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];

								  function fmt(mIndex, day, year) {
								    // mIndex = 0-11
								    return monthNames[mIndex] + " " + String(day).padStart(2, "0") + ", " + year;
								  }

								  // 1) yyyy-MM-dd (หรือมีเวลา)
								  var m = s.match(/^(\d{4})-(\d{2})-(\d{2})/);
								  if (m) {
								    var y = parseInt(m[1], 10);
								    var mo = parseInt(m[2], 10); // 1-12
								    var d = parseInt(m[3], 10);
								    return fmt(mo - 1, d, y);
								  }

								  // 2) dd-MM-yyyy หรือ dd/MM/yyyy
								  m = s.match(/^(\d{2})[\/-](\d{2})[\/-](\d{4})/);
								  if (m) {
								    var d2 = parseInt(m[1], 10);
								    var mo2 = parseInt(m[2], 10); // 1-12
								    var y2 = parseInt(m[3], 10);
								    return fmt(mo2 - 1, d2, y2);
								  }

								  // 3) อังกฤษ เช่น "May 15, 2024, 2:22:35 AM"
								  var parsed = Date.parse(s);
								  if (!Number.isNaN(parsed)) {
								    var dt = new Date(parsed);
								    var d3 = dt.getDate();
								    var mo3 = dt.getMonth(); // 0-11
								    var y3 = dt.getFullYear();
								    return fmt(mo3, d3, y3);
								  }

								  return s;
								}

							function updateCard() {
								const opt = sel.options[sel.selectedIndex];
								const moreSec = document
										.getElementById("moreDetailSection");
								const collapseEl = document
										.getElementById("moreDetailCollapse_1");

								if (!opt || !opt.value) {
									  setText("d_itemNo", "");
									  setBadge("");
									  setImage("", "");
									  setText("d_name", "");
									  setTypeUI("");
									  setText("d_serial", "");
									  setText("d_amount", "");
									  setText("d_purchase", "");
									  setText("d_detail", "");

									  if (moreSec) moreSec.classList.add("d-none");
									  return;
									}


								const d = opt.dataset;

								setText("d_itemNo", d.itemno);
								setBadge(d.status);
								setImage(d.image, d.itemno);
								setText("d_name", d.name);
								setTypeUI(d.type);
								setText("d_serial", d.serial);
								setText("d_amount", d.amount);
								setText("d_purchase", formatPurchase(d.purchase));
								setText("d_detail", d.detail);

								// ✅ show/hide More Detail เฉพาะ type=c
								const isComputer = (d.type || "").trim()
										.toLowerCase() === "c";
								if (moreSec)
									moreSec.classList.toggle("d-none",
											!isComputer);

								if (isComputer) {
									setText("d_windows", d.windows);
									setText("d_cpu", d.cpu);
									setText("d_ram", d.ram);
									setText("d_storage", d.storage);
									setText("d_battery", d.battery);
									setText("d_wifi", d.wifi);
									setText("d_lan", d.lan);
									setText("d_display", d.display);
								}

								// เปลี่ยนอุปกรณ์แล้วให้พับ collapse กลับ
								if (collapseEl
										&& collapseEl.classList
												.contains("show")) {
									if (window.bootstrap)
										bootstrap.Collapse.getOrCreateInstance(
												collapseEl).hide();
								}
							}

							sel.addEventListener("change", updateCard);

							// ✅ ถ้าใช้ select2 ให้ฟัง change.select2 ด้วย (ชัวร์สุด)
							if (window.jQuery) {
								jQuery(sel).on("change.select2", updateCard);
							}

							updateCard();
						});
	</script>
	<!-- JS StatusLog -->
	<script>
document.addEventListener("DOMContentLoaded", function () {

  const sel = document.getElementById("equipment_select");
  const box = document.getElementById("statusLogList");
  const empty = document.getElementById("statusLogEmpty");

  if (!sel || !box || !empty) return;

  function statusMeta(st) {
    const s = (st || "").toUpperCase();
    if (s === "B") return { text: "Borrowing", badge: "bg-warning text-white" };
    if (s === "R") return { text: "Return", badge: "bg-success text-white" };
    if (s === "W") return { text: "Wait for approve", badge: "bg-info text-white" };
    if (s === "C") return { text: "Corrupted", badge: "bg-danger text-white" };
    if (s === "A") return { text: "Available", badge: "bg-success text-white" };
    return { text: (s || "-"), badge: "bg-secondary text-white" };
  }

  function parseStatusLog(raw) {
    raw = (raw || "").trim();
    if (!raw || raw.toLowerCase() === "null") return [];

    try {
      // กันเคสถูกห่อเป็นสตริงอีกชั้น
      if ((raw.startsWith('"') && raw.endsWith('"')) || (raw.startsWith("'") && raw.endsWith("'"))) {
        raw = JSON.parse(raw);
      }
      const arr = JSON.parse(raw);
      return Array.isArray(arr) ? arr : [];
    } catch (e) {
      console.log("statuslog parse error:", e, raw);
      return [];
    }
  }

  function clearLogs() {
    box.innerHTML = "";
    empty.classList.add("d-none");
  }

  function showEmpty() {
    box.innerHTML = "";
    empty.classList.remove("d-none");
  }

  function renderLogs(logs) {
    clearLogs();

    if (!logs || logs.length === 0) {
      showEmpty();
      return;
    }

    logs.forEach(function (it, idx) {
      const meta = statusMeta(it && it.status);
      const user = (it && it.userUpdate) ? it.userUpdate : "-";
      const time = (it && it.timeUpdate) ? it.timeUpdate : "-";

      const wrap = document.createElement("div");
      wrap.className = "d-flex mb-5";

      const left = document.createElement("span");
      left.className = "d-inline-flex align-items-center justify-content-center rounded-circle border border-2 border-dashed border-gray-300 flex-shrink-0 me-3";
      left.style.width = "38px";
      left.style.height = "38px";
      left.innerHTML = '<i class="ki-duotone ki-cd dashed fs-2 text-gray-300"><span class="path1"></span><span class="path2"></span></i>';

      const right = document.createElement("div");
      right.className = "flex-grow-1";

      const badgeRow = document.createElement("div");
      badgeRow.className = "mb-2";
      const badge = document.createElement("b");
      badge.className = "badge badge-lg rounded-pill px-2 fw-semibold " + meta.badge;
      badge.textContent = meta.text;
      badgeRow.appendChild(badge);

      const userRow = document.createElement("div");
      userRow.className = "d-flex align-items-center";
      userRow.innerHTML = '<i class="ki-duotone ki-user fs-5 me-2"><span class="path1"></span><span class="path2"></span></i>';
      const userSpan = document.createElement("span");
      userSpan.textContent = user;
      userRow.appendChild(userSpan);

      const timeRow = document.createElement("div");
      timeRow.className = "d-flex align-items-center mt-1";
      timeRow.innerHTML = '<i class="ki-duotone ki-calendar fs-5 me-2"><span class="path1"></span><span class="path2"></span></i>';
      const timeSpan = document.createElement("span");
      timeSpan.textContent = time;
      timeRow.appendChild(timeSpan);

      right.appendChild(badgeRow);
      right.appendChild(userRow);
      right.appendChild(timeRow);

      wrap.appendChild(left);
      wrap.appendChild(right);

      box.appendChild(wrap);

      if (idx < logs.length - 1) {
        box.appendChild(document.createElement("hr"));
      }
    });
  }

  function onChange() {
    const opt = sel.options[sel.selectedIndex];
    const raw = opt ? (opt.dataset.statuslog || "") : "";
    const logs = parseStatusLog(raw);
    console.log("selected=", sel.value);
    console.log("raw statuslog=", raw);
    console.log("parsed logs size=", logs.length, logs);
    renderLogs(logs);
  }

  sel.addEventListener("change", onChange);
  onChange();
});
</script>
</body>
</html>