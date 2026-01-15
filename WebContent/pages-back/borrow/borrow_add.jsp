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
								<input type="hidden" name="id" value="" />

								<div class="card-header py-4"
									style="border-bottom: 1px solid #E4E6EF;">
									<h3 class="card-title fw-bold mb-0">Borrow Equipment</h3>
								</div>

								<div class="card-body pt-6">

									<!-- Borrower -->
									<div class="mb-7">
										<label class="form-label required fw-medium">Borrower</label>

										<select name="user"
											class="form-select form-select fw-medium"
											data-control="select2" data-placeholder="Select Borrower"
											required>
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

												<!-- enable: รองรับ key ได้หลายแบบ + แปลงให้เป็น string เพื่อเทียบง่าย -->
												<c:set var="enableVal"
													value="${not empty u['enable'] ? u['enable']
        : (not empty u['ENABLE'] ? u['ENABLE']
        : (not empty u['is_enable'] ? u['is_enable']
        : (not empty u['isEnable'] ? u['isEnable']
        : '0')))}" />

												<c:if
													test="${enableVal == 1 || enableVal == '1' || enableVal == true || enableVal == 'true'}">
													<option value="${uid}">${emp}-${nameTH}-${nameEN}-${role}</option>
												</c:if>
											</c:forEach>
										</select>
									</div>

									<!-- Status -->
									<div class="mb-7">
										<label class="required fw-medium mb-2 d-block">Status</label>
										<select name="status"
											class="form-select form-select text-muted" required>
											<option value="">Select status</option>
											<option value="B">Borrowing</option>
											<option value="W">Wait for approve</option>
										</select>

									</div>

									<!-- Equipment -->
									<div class="mb-7">
										<label class="required fw-medium mb-2 d-block">Equipment</label>

										<select id="equipment_select" name="equipment"
											class="form-select form-select fw-medium text-muted"
											data-control="select2" data-placeholder="Select equipment"
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
													class="form-control form-control ps-12" name="date_from"
													placeholder="Select Date" value="" autocomplete="off"
													required />
											</div>
										</div>

										<div class="col-lg-6">
											<label class="form-label fw-medium fs-6">End Date</label>
											<div class="position-relative d-flex align-items-center">
												<i
													class="ki-outline ki-calendar fs-3 position-absolute ms-4"></i>
												<input type="text" id="end_date"
													class="form-control form-control ps-12" name="date_to"
													placeholder="Select Date" value="" autocomplete="off" />
											</div>
										</div>
									</div>


									<!-- Location -->
									<div class="mb-7">
										<label class="required fw-medium fs-6 mb-2 d-block">Location</label>
										<input class="form-control form-control" type="text"
											name="location" value="" placeholder="Location" required />
									</div>

									<!-- Reason -->
									<div class="mb-7">
										<label class="fw-medium fs-6 mb-2 d-block">Reason</label>
										<textarea class="form-control form-control" rows="4"
											name="reason" placeholder="ระบุเหตุผลการยืม"></textarea>
									</div>

									<!-- Contact Address -->
									<div class="mb-7">
										<label class="fw-medium fs-6 mb-2 d-block">Contact
											Address</label>
										<textarea class="form-control form-control" rows="4"
											name="contact" placeholder="Address"></textarea>
									</div>

									<!-- Remark -->
									<div class="mb-7">
										<label class="fw-medium fs-6 mb-2 d-block">Remark</label>
										<textarea class="form-control form-control" rows="4"
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

											<span> <span id="d_badge"
												class="badge badge-lg rounded-pill px-4 fw-semibold bg-light text-gray-700">-</span>
											</span>
										</div>

										<!-- ✅ container สำหรับสลับ img / icon -->
										<div id="d_imgWrap"></div>
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
											<span>More Detail</span> <i class="ki-duotone ki-down fs-3"
												id="icon_1"> <span class="path1"></span><span
												class="path2"></span>
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
							<div class="card shadow-sm mb-5 mb-xl-10">
								<div class="card-header fs-4">
									<div class="card-title">
										<h3 class="fw-semibold m-0 bs-gray-900">Status Log</h3>
									</div>

									<div class="card-toolbar">
										<!-- ซ่อนก่อน แล้วค่อยเปิดด้วย JS -->
										<button id="btnRequestReturn" type="button"
											class="btn btn-sm btn-warning btn-open-return-modal d-none">
											Request for Return</button>
									</div>
								</div>

								<div class="card-body pt-0 mt-6">
									<div id="statusLogBox"></div>

									<div id="statusLogEmpty" class="d-none">
										<div
											class="d-flex flex-column align-items-center justify-content-center py-10">
											<i class="ki-duotone ki-cube-2 fs-3x text-gray-500 mb-4">
												<span class="path1"></span><span class="path2"></span><span
												class="path3"></span>
											</i> <span class="text-gray-800 fw-semibold fs-5">No data</span>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Js ID -->
	<script>
document.addEventListener("DOMContentLoaded", function () {
    const borrowerSelect = document.querySelector('select[name="user"]');
    const hiddenId = document.querySelector('input[name="id"]');

    if (!borrowerSelect || !hiddenId) return;

    borrowerSelect.addEventListener("change", function () {
        hiddenId.value = this.value || "";
    });
});
</script>
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
  enableTime: true,
  time_24hr: true,
  dateFormat: "d m Y , H : i",
  altInput: true,
  altFormat: "d M Y , H : i",

  allowInput: true
});

const endPicker = flatpickr(endEl, {
  enableTime: true,
  time_24hr: true,
  dateFormat: "d m Y , H : i",
  altInput: true,
  altFormat: "d M Y , H : i",
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
								  const wrap = document.getElementById("d_imgWrap");
								  if (!wrap) return;

								  let src = (imgPath || "").trim();

								  // ====== ไม่มีรูป => แสดง icon เหมือน c:otherwise ======
								  if (!src) {
								    wrap.innerHTML = `
								      <div class="symbol symbol-150px border rounded-3 bg-light d-flex align-items-center justify-content-center">
								        <i class="fa-solid fa-image fs-1 text-muted"></i>
								      </div>
								    `;
								    return;
								  }

								  // ====== มีรูป => ทำ path เหมือนเดิม ======
								  if (!src.startsWith("http")) {
								    if (!src.startsWith("/")) src = "/" + src;
								    src = CTX + src;
								  }

								  // ====== แสดง img เหมือน c:when ======
								  wrap.innerHTML = `
								    <div class="symbol symbol-150px">
								      <img src="${src}"
								           alt="${altText || "equipment"}"
								           class="border rounded-3 object-fit-cover w-100 h-100" />
								    </div>
								  `;
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
								    return String(day).padStart(2, "0") + " " + monthNames[mIndex] + " " + year;
								  }

								  var m = s.match(/^(\d{4})-(\d{2})-(\d{2})/);
								  if (m) {
								    var y = parseInt(m[1], 10);
								    var mo = parseInt(m[2], 10); // 1-12
								    var d = parseInt(m[3], 10);
								    return fmt(mo - 1, d, y);
								  }

								  m = s.match(/^(\d{2})[\/-](\d{2})[\/-](\d{4})/);
								  if (m) {
								    var d2 = parseInt(m[1], 10);
								    var mo2 = parseInt(m[2], 10); // 1-12
								    var y2 = parseInt(m[3], 10);
								    return fmt(mo2 - 1, d2, y2);
								  }

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
  const CTX = "${pageContext.request.contextPath}";
  const sel = document.getElementById("equipment_select");
  if (!sel) return;

  const box = document.getElementById("statusLogBox");
  const empty = document.getElementById("statusLogEmpty");
  const btnReturn = document.getElementById("btnRequestReturn");
  if (!box || !empty) return;

  function formatEN(dtStr){
    if(!dtStr) return "";
    let s = String(dtStr).trim();
    if (/^\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}/.test(s)) s = s.replace(" ", "T");
    const d = new Date(s);
    if (isNaN(d.getTime())) return String(dtStr);

    const months = ["January","February","March","April","May","June","July","August","September","October","November","December"];
    const dd = d.getDate();
    const mm = months[d.getMonth()];
    const yy = d.getFullYear();
    const HH = String(d.getHours()).padStart(2,"0");
    const MI = String(d.getMinutes()).padStart(2,"0");
    return dd + " " + mm + " " + yy + ", " + HH + ":" + MI;
  }

  function whoText(row){
    const emp  = row.employee_id || "";
    const name = row.name || "";
    const en   = row.name_en || "";
    let t = "";
    if (emp) t += emp + " - ";
    t += name || "-";
    if (en) t += " - " + en;
    return t;
  }

  function el(tag, cls){
    const e = document.createElement(tag);
    if (cls) e.className = cls;
    return e;
  }

  function renderTimeline(list){
    box.innerHTML = "";
    empty.classList.add("d-none");
    if (btnReturn) btnReturn.classList.add("d-none");

    if (!list || list.length === 0) {
      empty.classList.remove("d-none");
      return;
    }

    // ✅ เหมือน JSTL: ถ้ารายการแรก status == B → โชว์ปุ่ม
    if (btnReturn && String(list[0].status || "").toUpperCase() === "B") {
      btnReturn.classList.remove("d-none");
    }

    const tl = el("div", "timeline timeline-border-dashed");

    list.forEach(function (borrow) {
      const st = String(borrow.status || "").toUpperCase();

      if (st === "R") {
        const item = el("div", "timeline-item");

        item.appendChild(el("div", "timeline-line"));

        const icon = el("div", "timeline-icon");
        icon.innerHTML = '<i class="ki-duotone ki-cd fs-2 text-success"><span class="path1"></span><span class="path2"></span></i>';
        item.appendChild(icon);

        const content = el("div", "timeline-content mb-5 mt-n1");

        const bRow = el("div", "mb-2");
        bRow.innerHTML = '<span class="badge badge-success fw-bold fs-7">Returned</span>';
        content.appendChild(bRow);

        // user row
        const uRow = el("div", "d-flex align-items-center mt-4 mb-2");
        uRow.innerHTML = '<i class="ki-duotone ki-user fs-4 text-gray-700 me-3"><span class="path1"></span><span class="path2"></span></i>';
        const uDiv = el("div", "fs-5 fw-semibold text-gray-800");
        uDiv.textContent = whoText(borrow);
        uRow.appendChild(uDiv);
        content.appendChild(uRow);

        // date_end
        const tRow = el("div", "d-flex align-items-center mt-4 fs-7 text-muted");
        tRow.innerHTML = '<i class="ki-duotone ki-calendar fs-4 text-gray-700 me-3"><span class="path1"></span><span class="path2"></span></i>';
        const tDiv = el("div", "fs-5 fw-semibold text-gray-800");
        tDiv.textContent = formatEN(borrow.date_end) || "Unknown Return Date";
        tRow.appendChild(tDiv);
        content.appendChild(tRow);

        // location
        if (borrow.location) {
          const lRow = el("div", "d-flex align-items-center mt-4 mb-2 fs-7 text-muted");
          lRow.innerHTML = '<i class="ki-duotone ki-geolocation fs-2 me-3"><span class="path1"></span><span class="path2"></span></i>';
          const lDiv = el("div", "fs-5 fw-semibold text-gray-800");
          lDiv.textContent = String(borrow.location);
          lRow.appendChild(lDiv);
          content.appendChild(lRow);
        }

        item.appendChild(content);
        tl.appendChild(item);
      }

      // ========== Borrowing/Borrowed block (เหมือน JSTL) ==========
      const item2 = el("div", "timeline-item");

      const icon2 = el("div", "timeline-icon");
      icon2.innerHTML = '<i class="ki-duotone ki-cd fs-2 text-warning"><span class="path1"></span><span class="path2"></span></i>';
      item2.appendChild(icon2);

      const content2 = el("div", "timeline-content mb-0 mt-n1");

      const bRow2 = el("div", "mb-2");
      const badgeText = (st === "B") ? "Borrowing" : "Borrowed";
      bRow2.innerHTML = '<span class="badge badge-warning fw-bold fs-7">' + badgeText + '</span>';
      content2.appendChild(bRow2);

      const uRow2 = el("div", "d-flex align-items-center mt-4 mb-2");
      uRow2.innerHTML = '<i class="ki-duotone ki-user fs-4 text-gray-700 me-3"><span class="path1"></span><span class="path2"></span></i>';
      const uDiv2 = el("div", "fs-5 fw-semibold text-gray-800");
      uDiv2.textContent = whoText(borrow);
      uRow2.appendChild(uDiv2);
      content2.appendChild(uRow2);

      const tRow2 = el("div", "d-flex align-items-center mt-4 fs-7 text-muted");
      tRow2.innerHTML = '<i class="ki-duotone ki-calendar fs-4 text-gray-700 me-3"><span class="path1"></span><span class="path2"></span></i>';
      const tDiv2 = el("div", "fs-5 fw-semibold text-gray-800");
      tDiv2.textContent = formatEN(borrow.date_start) || "-";
      tRow2.appendChild(tDiv2);
      content2.appendChild(tRow2);

      if (borrow.location) {
        const lRow2 = el("div", "d-flex align-items-center mt-4 fs-7 text-muted");
        lRow2.innerHTML = '<i class="ki-duotone ki-geolocation fs-4 text-gray-700 me-3"><span class="path1"></span><span class="path2"></span></i>';
        const lDiv2 = el("div", "fs-5 fw-semibold text-gray-800");
        lDiv2.textContent = String(borrow.location);
        lRow2.appendChild(lDiv2);
        content2.appendChild(lRow2);
      }

      item2.appendChild(content2);
      tl.appendChild(item2);

      // separator
      tl.appendChild(el("div", "separator separator-dashed border-gray-300 my-5"));
    });

    box.appendChild(tl);
  }

  function loadByEquipmentId(eqId){
    if (!eqId) { renderTimeline([]); return; }

    // ใช้ jQuery ajax แบบที่คุณมีอยู่ก็ได้
    if (!window.jQuery || !window.jQuery.ajax) {
      console.error("jQuery not loaded");
      renderTimeline([]);
      return;
    }

    jQuery.ajax({
      url: CTX + "/eBorrowLog.action",
      type: "GET",
      dataType: "json",
      data: { equipmentId: eqId },
      success: function(list){
        renderTimeline(Array.isArray(list) ? list : []);
      },
      error: function(xhr){
        console.log("AJAX ERROR", xhr.status, xhr.responseText);
        renderTimeline([]);
      }
    });
  }

  function onChange(){
    const eqId = (sel.value || "").trim(); // ✅ equipmentId จาก option value
    loadByEquipmentId(eqId);
  }

  sel.addEventListener("change", onChange);
  if (window.jQuery) jQuery(sel).on("change.select2", onChange);
  onChange();
});
</script>
</body>
</html>