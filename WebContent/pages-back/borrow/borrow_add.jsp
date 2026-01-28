<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

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
								method="post" class="card shadow-none"
								style="height: fit-content;">

								<input type="hidden" name="id" value="" />

								<div class="card-header py-4"
									style="border-bottom: 1px solid #E4E6EF;">
									<h3 class="card-title fw-bold mb-0">Borrow Equipment</h3>
								</div>

								<div class="card-body pt-6">

									<!-- Borrower -->
									<div class="mb-7">
										<label class="form-label required fw-medium">Borrower</label>
										<select name="user" id="user_select"
											class="form-select form-select fw-medium"
											data-control="select2" data-placeholder="Select Borrower"
											required>
											<option value="">-- Select borrower --</option>
										</select>
									</div>

									<!-- Status -->
									<div class="mb-7">
										<label class="required fw-medium mb-2 d-block">Status</label>
										<select id="status_select" name="status" class="form-select"
											data-control="select2" required>
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
													placeholder="Select Date & Time" value=""
													autocomplete="off" required />
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

							<!-- Equipment Detail Card -->
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
										<div id="d_imgWrap"></div>
									</div>

									<!-- ROWS -->
									<div
										class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
										<div class="text-gray-600">Name</div>
										<div class="fw-normal fs-6 text-gray-800 text-end text-break"
											id="d_name"></div>
									</div>

									<div
										class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
										<div class="text-gray-600">Type</div>
										<div
											class="fw-normal fs-6 text-gray-800 d-flex align-items-center justify-content-end text-end w-100">
											<span id="d_typeText">-</span> <span id="d_typeIcons"
												class="d-inline-flex align-items-center ms-3"> <i
												id="ico_c"
												class="ki-solid ki-laptop fs-1 text-gray-600 d-none"> </i> <i
												id="ico_in"
												class="ki-solid ki-keyboard fs-1 text-gray-600 d-none">
											</i> <i id="ico_sl"
												class="ki-solid ki-verify fs-1 text-gray-600 d-none"> </i> <i
												id="ico_mob"
												class="ki-solid ki-phone fs-1 text-gray-600 d-none"> </i> <i
												id="ico_p"
												class="ki-solid ki-wifi-square fs-1 text-gray-600 d-none">
											</i> <i id="ico_other"
												class="ki-solid ki-dots-square fs-1 text-gray-600 d-none">
											</i>
											</span>
										</div>
									</div>

									<div
										class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
										<div class="text-gray-600">Serial No</div>
										<div class="fw-normal fs-6 text-gray-800 text-end text-break"
											id="d_serial"></div>
									</div>

									<div
										class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
										<div class="text-gray-600">Amount</div>
										<div class="fw-normal fs-6 text-gray-800 text-end"
											id="d_amount"></div>
									</div>

									<div
										class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
										<div class="text-gray-600">Date of Purchase</div>
										<div class="fw-normal fs-6 text-gray-800 text-end text-break"
											id="d_purchase"></div>
									</div>

									<div
										class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
										<div class="text-gray-600">Detail</div>
										<div class="fw-normal fs-6 text-gray-800 text-end text-break"
											id="d_detail"></div>
									</div>

									<!-- More Detail -->
									<div id="moreDetailSection">
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
												<div
													class="fw-normal fs-6 text-gray-800 text-end text-break"
													id="d_windows">-</div>
											</div>

											<div
												class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
												<div class="text-gray-600">CPU</div>
												<div
													class="fw-normal fs-6 text-gray-800 text-end text-break"
													id="d_cpu">-</div>
											</div>

											<div
												class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
												<div class="text-gray-600">Ram</div>
												<div
													class="fw-normal fs-6 text-gray-800 text-end text-break"
													id="d_ram">-</div>
											</div>

											<div
												class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
												<div class="text-gray-600">Storage</div>
												<div
													class="fw-normal fs-6 text-gray-800 text-end text-break"
													id="d_storage">-</div>
											</div>

											<div
												class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
												<div class="text-gray-600">Battery</div>
												<div
													class="fw-normal fs-6 text-gray-800 text-end text-break"
													id="d_battery">-</div>
											</div>

											<div
												class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
												<div class="text-gray-600">WIFI Address</div>
												<div
													class="fw-normal fs-6 text-gray-800 text-end text-break"
													id="d_wifi">-</div>
											</div>

											<div
												class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
												<div class="text-gray-600">LAN Address</div>
												<div
													class="fw-normal fs-6 text-gray-800 text-end text-break"
													id="d_lan">-</div>
											</div>

											<div
												class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
												<div class="text-gray-600">Display</div>
												<div
													class="fw-normal fs-6 text-gray-800 text-end text-break"
													id="d_display">-</div>
											</div>
										</div>
									</div>
								</div>
							</div>

							<!-- Status Log -->
							<div class="card shadow-sm mb-5 mb-xl-10">
								<div class="card-header fs-4">
									<div class="card-title">
										<h3 class="fw-semibold m-0 bs-gray-900">Status Log</h3>
									</div>

									<div class="card-toolbar">
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

	<!-- Initialize Data Variables -->
	<script>
		// ดึงข้อมูลจาก request attributes
		var equipments = ${equipments != null ? equipments : '[]'};
		var users = ${userList != null ? userList : '[]'};
		var dbStatusList = ${status != null ? status : '[]'};
		var dbTypeList = ${type != null ? type : '[]'};
		var preselectedEquipId = '${eId != null ? eId : ""}';
	</script>

	<!-- Populate User Select -->
	<script>
document.addEventListener("DOMContentLoaded", function () {
	const userSelect = document.getElementById("user_select");
	const hiddenId = document.querySelector('input[name="id"]');
	
	if (!userSelect || !Array.isArray(users)) return;

	users.forEach(function(u) {
		const uid = u.id || u.user_id || u.USER_ID || '';
		const emp = u.employee_id || u.employeeId || '';
		const nameTH = u.name || u.fullname || '';
		const nameEN = u.name_en || u.nameEn || '';
		const role = u.role || '';
		const enableVal = u.enable || u.ENABLE || u.is_enable || u.isEnable || '0';

		// เช็คว่า enable = true
		if (enableVal == 1 || enableVal == '1' || enableVal == true || enableVal == 'true') {
			const opt = document.createElement('option');
			opt.value = uid;
			opt.textContent = emp + ' - ' + nameEN + ' - ' + nameTH + ' - ' + role;
			userSelect.appendChild(opt);
		}
	});

	// อัพเดท hidden id เมื่อเลือก user
	if (hiddenId) {
		userSelect.addEventListener("change", function () {
			hiddenId.value = this.value || "";
		});
	}
});
	</script>

	<!-- Populate Equipment Select -->
	<script>
document.addEventListener("DOMContentLoaded", function () {
	const equipSelect = document.getElementById("equipment_select");
	
	if (!equipSelect || !Array.isArray(equipments)) return;

	equipments.forEach(function(e) {
		const eqId = e.equipmentId || e.equipment_id || '';
		const itemNo = e.itemNo || e.item_no || '';
		const eqName = e.name || '';
		const eqStatus = e.status || '';
		const eqType = e.type || '';
		const eqSerial = e.serialNo || e.serial_no || '';
		const eqAmount = e.amount || '';
		const eqDetail = e.detail || '';
		const eqImage = e.image || '';
		const eqPurchase = e.timeCreate || e.time_create || '';
		const eqWindows = e.windows || '';
		const eqCPU = e.process || e.cpu || '';
		const eqRam = e.ram || '';
		const eqStorage = e.hdd || e.storage || '';
		const eqBattery = e.battery || '';
		const eqWifi = e.wifiaddress || e.wifiAddress || '';
		const eqLan = e.lanaddress || e.lanAddress || '';
		const eqDisplay = e.display || '';
		const eqStatusLog = e.statusLog || e.status_log || e.STATUS_LOG || '';

		const opt = document.createElement('option');
		opt.value = String(eqId).replace('.0', '');
		opt.textContent = itemNo + ' - ' + eqName;
		
		// เก็บ data attributes
		opt.dataset.itemno = itemNo;
		opt.dataset.name = eqName;
		opt.dataset.status = eqStatus;
		opt.dataset.type = eqType;
		opt.dataset.serial = eqSerial;
		opt.dataset.amount = eqAmount;
		opt.dataset.detail = eqDetail;
		opt.dataset.image = eqImage;
		opt.dataset.purchase = eqPurchase;
		opt.dataset.windows = eqWindows;
		opt.dataset.cpu = eqCPU;
		opt.dataset.ram = eqRam;
		opt.dataset.storage = eqStorage;
		opt.dataset.battery = eqBattery;
		opt.dataset.wifi = eqWifi;
		opt.dataset.lan = eqLan;
		opt.dataset.display = eqDisplay;
		opt.dataset.statuslog = eqStatusLog;

		equipSelect.appendChild(opt);
	});

	// ถ้ามี preselected id
	if (preselectedEquipId) {
		equipSelect.value = preselectedEquipId;
		// trigger change event
		const event = new Event('change');
		equipSelect.dispatchEvent(event);
	}
});
	</script>

	<!-- Borrower ID Handler -->
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

	<!-- More Detail Collapse -->
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

	<!-- Flatpickr Date Picker -->
	<script>
	document.addEventListener("DOMContentLoaded", function () {
		if (typeof flatpickr === "undefined") {
			console.error("flatpickr not loaded");
			return;
		}

		const startEl = document.getElementById("start_date");
		const endEl = document.getElementById("end_date");

		const startPicker = flatpickr(startEl, {
			enableTime: true,
			time_24hr: true,
			dateFormat: "d m Y , H : i",
			altInput: true,
			altFormat: "d M Y , H : i",
			allowInput: true,
			defaultDate: new Date()  // เพิ่มบรรทัดนี้ - ตั้งค่าเริ่มต้นเป็นเวลาปัจจุบัน
		});

		const endPicker = flatpickr(endEl, {
			enableTime: true,
			time_24hr: true,
			dateFormat: "d m Y , H : i",
			altInput: true,
			altFormat: "d M Y , H : i",
			allowInput: true
		});

		startEl.addEventListener("change", function () {
			const v = this.value || "";
			endPicker.set("minDate", v || null);

			if (v && endEl.value && endEl.value < v) {
				endEl.value = v;
			}
		});
	});
	</script>

	<!-- Equipment Detail Card Update -->
	<script>
document.addEventListener("DOMContentLoaded", function() {
	const CTX = "${pageContext.request.contextPath}";
	const sel = document.getElementById("equipment_select");

	function setText(id, val) {
		const el = document.getElementById(id);
		if (!el) return;
		el.textContent = (val && String(val).trim() !== "") ? val : "";
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

	    let src = imgPath || "";
	    let alt = altText || "equipment";
	    
	    if (!src) {
	        wrap.innerHTML = `
	            <div class="symbol symbol-150px border rounded-3 bg-light d-flex align-items-center justify-content-center">
	                <i class="fa-solid fa-image fs-1 text-muted"></i>
	            </div>
	        `;
	        return;
	    }
		
	    const container = document.createElement('div');
	    container.className = 'symbol symbol-150px border rounded-3 bg-light d-flex align-items-center justify-content-center';

	    const img = document.createElement('img');
	    img.src = src;
	    img.alt = alt;
	    img.className = 'border rounded-3 object-fit-cover w-100 h-100';

	    container.appendChild(img);
	    wrap.innerHTML = '';
	    wrap.appendChild(container);
	}

	function setTypeUI(typeCode) {
		const textEl = document.getElementById("d_typeText");
		const iconsWrap = document.getElementById("d_typeIcons");
		if (!textEl) return;

		const ids = ["ico_c","ico_in","ico_sl","ico_mob","ico_p","ico_other"];
		ids.forEach(id => document.getElementById(id)?.classList.add("d-none"));

		const t = (typeCode ?? "").toString().trim().toLowerCase();

		if (!t) {
			textEl.textContent = ""; 
			if (iconsWrap) iconsWrap.classList.add("d-none");
			return;
		}

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
			var mo = parseInt(m[2], 10);
			var d = parseInt(m[3], 10);
			return fmt(mo - 1, d, y);
		}

		m = s.match(/^(\d{2})[\/-](\d{2})[\/-](\d{4})/);
		if (m) {
			var d2 = parseInt(m[1], 10);
			var mo2 = parseInt(m[2], 10);
			var y2 = parseInt(m[3], 10);
			return fmt(mo2 - 1, d2, y2);
		}

		var parsed = Date.parse(s);
		if (!Number.isNaN(parsed)) {
			var dt = new Date(parsed);
			var d3 = dt.getDate();
			var mo3 = dt.getMonth();
			var y3 = dt.getFullYear();
			return fmt(mo3, d3, y3);
		}

		return s;
	}

	function updateCard() {
		const opt = sel.options[sel.selectedIndex];
		const moreSec = document.getElementById("moreDetailSection");
		const collapseEl = document.getElementById("moreDetailCollapse_1");

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

		const isComputer = (d.type || "").trim().toLowerCase() === "c";
		if (moreSec) moreSec.classList.toggle("d-none", !isComputer);

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

		if (collapseEl && collapseEl.classList.contains("show")) {
			if (window.bootstrap) bootstrap.Collapse.getOrCreateInstance(collapseEl).hide();
		}
	}

	sel.addEventListener("change", updateCard);

	if (window.jQuery) {
		jQuery(sel).on("change.select2", updateCard);
	}

	updateCard();
});
	</script>

	<!-- Status Log -->
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
		const emp = row.employee_id || "";
		const name = row.name || "";
		const en = row.name_en || "";
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

				const uRow = el("div", "d-flex align-items-center mt-4 mb-2");
				uRow.innerHTML = '<i class="ki-duotone ki-user fs-4 text-gray-700 me-3"><span class="path1"></span><span class="path2"></span></i>';
				const uDiv = el("div", "fs-5 fw-semibold text-gray-800");
				uDiv.textContent = whoText(borrow);
				uRow.appendChild(uDiv);
				content.appendChild(uRow);

				const tRow = el("div", "d-flex align-items-center mt-4 fs-7 text-muted");
				tRow.innerHTML = '<i class="ki-duotone ki-calendar fs-4 text-gray-700 me-3"><span class="path1"></span><span class="path2"></span></i>';
				const tDiv = el("div", "fs-5 fw-semibold text-gray-800");
				tDiv.textContent = formatEN(borrow.date_end) || "Unknown Return Date";
				tRow.appendChild(tDiv);
				content.appendChild(tRow);

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

			tl.appendChild(el("div", "separator separator-dashed border-gray-300 my-5"));
		});

		box.appendChild(tl);
	}

	function loadByEquipmentId(eqId){
		if (!eqId) { renderTimeline([]); return; }

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
		const eqId = (sel.value || "").trim();
		loadByEquipmentId(eqId);
	}

	sel.addEventListener("change", onChange);
	if (window.jQuery) jQuery(sel).on("change.select2", onChange);
	onChange();
});
	</script>
	<script>
		document.addEventListener("DOMContentLoaded", function () {
		  $("#status_select").select2({
		    minimumResultsForSearch: Infinity,
		    width: "100%"
		  });
		});
</script>
</body>
</html>