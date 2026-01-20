<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />

<link href="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.js"></script>
<link href="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/scripts.bundle.js"></script>

<style>
[data-bs-theme="light"] #kt_table.table.table-striped>tbody>tr:nth-of-type(odd)>* {
	background-color: #FBFBFB !important;
	box-shadow: none !important;
}
[data-bs-theme="light"] #kt_table.table-hover tbody tr:hover>*, 
[data-bs-theme="light"] #kt_table.dataTable>tbody>tr:hover>* {
	background-color: #F9F9F9 !important;
	box-shadow: none !important;
	transition: background-color .15s ease-in-out;
}
[data-bs-theme="dark"] #kt_table.table.table-striped>tbody>tr:nth-of-type(odd)>* {
	background-color: #191B20 !important;
	box-shadow: none !important;
}
[data-bs-theme="dark"] #kt_table.table.table-striped>tbody>tr:nth-of-type(even)>* {
	background-color: #15171C !important;
	box-shadow: none !important;
}
[data-bs-theme="dark"] #kt_table.table-hover tbody tr:hover>*, 
[data-bs-theme="dark"] #kt_table.dataTable>tbody>tr:hover>* {
	background-color: #1B1C22 !important;
	box-shadow: none !important;
	transition: background-color .15s ease-in-out;
}
.rotate-180 { transform: rotate(180deg); }
</style>
</head>

<body>
	<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
		<div class="d-flex flex-column flex-column-fluid">

			<!-- Toolbar -->
			<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
				<div id="kt_app_toolbar_container" class="app-container container-fluid d-flex align-items-center justify-content-start">
					<div class="page-title d-flex flex-column flex-wrap me-3 align-items-start">
						<h1 class="page-heading fw-semibold my-0 text-start" style="color: #4b5675;">Borrow Add</h1>
						<ul class="breadcrumb breadcrumb-separatorless fw-medium fs-7 my-0 pt-1">
							<li class="breadcrumb-item text-muted"><a href="${pageContext.request.contextPath}/demo_dashboard" class="text-muted text-hover-primary">Home</a></li>
							<li class="breadcrumb-item"><span class="bullet bg-gray-500 w-4px h-1px"></span></li>
							<li class="breadcrumb-item text-muted"><a href="${pageContext.request.contextPath}/borrow_list" class="text-muted text-hover-primary">Borrow</a></li>
							<li class="breadcrumb-item"><span class="bullet bg-gray-500 w-4px h-1px"></span></li>
							<li class="breadcrumb-item text-muted">Borrow Add</li>
						</ul>
					</div>
				</div>
			</div>

			<div id="kt_app_content" class="app-content flex-column-fluid">
				<div id="kt_app_content_container" class="app-container container-fluid">
					<div class="row g-5 g-xl-10">

						<!-- LEFT FORM -->
						<div class="col-xl-8">
							<form action="${pageContext.request.contextPath}/eBorrowAdd.action" method="post" class="card shadow-none" style="height: fit-content;">
								<input type="hidden" name="id" value="" />

								<div class="card-header py-4" style="border-bottom: 1px solid #E4E6EF;">
									<h3 class="card-title fw-bold mb-0">Borrow Equipment</h3>
								</div>

								<div class="card-body pt-6">
									<div class="mb-7">
										<label class="form-label required fw-medium">Borrower</label>
										<select name="user" id="user_select" class="form-select form-select fw-medium" data-control="select2" data-placeholder="Select Borrower" required>
											<option value="">-- Select borrower --</option>
										</select>
									</div>

									<div class="mb-7">
										<label class="required fw-medium mb-2 d-block">Status</label>
										<select name="status" class="form-select form-select text-muted" required>
											<option value="">Select status</option>
											<option value="B">Borrowing</option>
											<option value="W">Wait for approve</option>
										</select>
									</div>

									<div class="mb-7">
										<label class="required fw-medium mb-2 d-block">Equipment</label>
										<select id="equipment_select" name="equipment" class="form-select form-select fw-medium text-muted" data-control="select2" data-placeholder="Select equipment" required>
											<option value="">Select equipment</option>
										</select>
									</div>

									<div class="row mb-7">
										<div class="col-lg-6">
											<label class="form-label required fw-medium fs-6">Start Date</label>
											<div class="position-relative d-flex align-items-center">
												<i class="ki-outline ki-calendar fs-3 position-absolute ms-4"></i>
												<input type="text" id="start_date" class="form-control form-control ps-12" name="date_from" placeholder="Select Date" autocomplete="off" required />
											</div>
										</div>
										<div class="col-lg-6">
											<label class="form-label fw-medium fs-6">End Date</label>
											<div class="position-relative d-flex align-items-center">
												<i class="ki-outline ki-calendar fs-3 position-absolute ms-4"></i>
												<input type="text" id="end_date" class="form-control form-control ps-12" name="date_to" placeholder="Select Date" autocomplete="off" />
											</div>
										</div>
									</div>

									<div class="mb-7">
										<label class="required fw-medium fs-6 mb-2 d-block">Location</label>
										<input class="form-control form-control" type="text" name="location" placeholder="Location" required />
									</div>

									<div class="mb-7">
										<label class="fw-medium fs-6 mb-2 d-block">Reason</label>
										<textarea class="form-control form-control" rows="4" name="reason" placeholder="ระบุเหตุผลการยืม"></textarea>
									</div>

									<div class="mb-7">
										<label class="fw-medium fs-6 mb-2 d-block">Contact Address</label>
										<textarea class="form-control form-control" rows="4" name="contact" placeholder="Address"></textarea>
									</div>

									<div class="mb-7">
										<label class="fw-medium fs-6 mb-2 d-block">Remark</label>
										<textarea class="form-control form-control" rows="4" name="remark" placeholder="Remark"></textarea>
									</div>
								</div>

								<div class="card-footer d-flex justify-content-end">
									<a href="${pageContext.request.contextPath}/borrow_list" class="btn btn-light me-3">Cancel</a>
									<button type="submit" class="btn btn-success">
										<span class="indicator-label">Save</span>
									</button>
								</div>
							</form>
						</div>

						<!-- RIGHT -->
						<div class="col-xl-4">
							<!-- Equipment Detail Card -->
							<div class="card mb-5">
								<div class="card-header border-0 pt-6">
									<div class="card-title d-flex justify-content-between align-items-center w-100">
										<span class="fw-bold fs-4 me-2">Equipment Detail</span>
									</div>
								</div>

								<div class="card-body pt-0">
									<div class="mb-4 d-flex flex-column align-items-start">
										<div class="mb-3 d-flex justify-content-between align-items-center w-100">
											<span class="fw-bold fs-1 text-primary" id="d_itemNo">-</span>
											<span id="d_badge" class="badge badge-lg rounded-pill px-4 fw-semibold bg-light text-gray-700">-</span>
										</div>
										<div id="d_imgWrap"></div>
									</div>

									<div class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
										<div class="text-gray-600">Name:</div>
										<div class="fw-semibold text-gray-800 text-end text-break" id="d_name"></div>
									</div>

									<div class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
										<div class="text-gray-600">Type:</div>
										<div class="fw-semibold text-gray-800 d-flex align-items-center justify-content-end text-end w-100">
											<span id="d_typeText">-</span>
											<span id="d_typeIcons" class="d-inline-flex align-items-center ms-3"> 
												<i id="ico_c" class="ki-duotone ki-laptop fs-4 text-gray-600 d-none"><span class="path1"></span><span class="path2"></span></i> 
												<i id="ico_in" class="ki-duotone ki-keyboard fs-4 text-gray-600 d-none"><span class="path1"></span><span class="path2"></span></i> 
												<i id="ico_sl" class="ki-duotone ki-verify fs-4 text-gray-600 d-none"><span class="path1"></span><span class="path2"></span></i> 
												<i id="ico_mob" class="ki-duotone ki-phone fs-4 text-gray-600 d-none"><span class="path1"></span><span class="path2"></span></i> 
												<i id="ico_p" class="ki-duotone ki-wifi-square fs-4 text-gray-600 d-none"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i> 
												<i id="ico_other" class="ki-duotone ki-dots-square fs-4 text-gray-600 d-none"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i>
											</span>
										</div>
									</div>

									<div class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
										<div class="text-gray-600">Serial No:</div>
										<div class="fw-semibold text-gray-800 text-end text-break" id="d_serial"></div>
									</div>

									<div class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
										<div class="text-gray-600">Amount:</div>
										<div class="fw-semibold text-gray-800 text-end" id="d_amount"></div>
									</div>

									<div class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
										<div class="text-gray-600">Date of Purchase:</div>
										<div class="fw-semibold text-gray-800 text-end text-break" id="d_purchase"></div>
									</div>

									<div class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
										<div class="text-gray-600">Detail:</div>
										<div class="fw-semibold text-gray-800 text-end text-break" id="d_detail"></div>
									</div>

									<!-- More Detail -->
									<div id="moreDetailSection" class="d-none">
										<button type="button" id="btn_moreDetail" class="btn btn-link p-0 w-100 text-primary fw-semibold d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
											<span>More Detail</span> 
											<i class="ki-duotone ki-down fs-3" id="icon_more"><span class="path1"></span><span class="path2"></span></i>
										</button>

										<div class="collapse" id="moreDetailCollapse">
											<div class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
												<div class="text-gray-600">Windows</div>
												<div class="fw-semibold text-gray-800 text-end text-break" id="d_windows">-</div>
											</div>
											<div class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
												<div class="text-gray-600">CPU</div>
												<div class="fw-semibold text-gray-800 text-end text-break" id="d_cpu">-</div>
											</div>
											<div class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
												<div class="text-gray-600">Ram</div>
												<div class="fw-semibold text-gray-800 text-end text-break" id="d_ram">-</div>
											</div>
											<div class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
												<div class="text-gray-600">Storage</div>
												<div class="fw-semibold text-gray-800 text-end text-break" id="d_storage">-</div>
											</div>
											<div class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
												<div class="text-gray-600">Battery</div>
												<div class="fw-semibold text-gray-800 text-end text-break" id="d_battery">-</div>
											</div>
											<div class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
												<div class="text-gray-600">WIFI Address</div>
												<div class="fw-semibold text-gray-800 text-end text-break" id="d_wifi">-</div>
											</div>
											<div class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
												<div class="text-gray-600">LAN Address</div>
												<div class="fw-semibold text-gray-800 text-end text-break" id="d_lan">-</div>
											</div>
											<div class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">
												<div class="text-gray-600">Display</div>
												<div class="fw-semibold text-gray-800 text-end text-break" id="d_display">-</div>
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
										<button id="btnRequestReturn" type="button" class="btn btn-sm btn-warning btn-open-return-modal d-none">
											Request for Return
										</button>
									</div>
								</div>

								<div class="card-body pt-0 mt-6">
									<div id="statusLogBox"></div>
									<div id="statusLogEmpty" class="d-none">
										<div class="d-flex flex-column align-items-center justify-content-center py-10">
											<i class="ki-duotone ki-cube-2 fs-3x text-gray-500 mb-4"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i> 
											<span class="text-gray-800 fw-semibold fs-5">No data</span>
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

	<script>
	(function() {
		'use strict';
		
		// Data variables
		const CTX = "${pageContext.request.contextPath}";
		const equipments = ${equipments != null ? equipments : '[]'};
		const users = ${userList != null ? userList : '[]'};
		const preselectedEquipId = '${eId != null ? eId : ""}';

		// Cache DOM elements
		const els = {
			userSelect: null,
			equipSelect: null,
			hiddenId: null,
			startDate: null,
			endDate: null,
			moreDetailSection: null,
			moreDetailBtn: null,
			moreDetailCollapse: null,
			moreDetailIcon: null,
			statusLogBox: null,
			statusLogEmpty: null,
			btnReturn: null
		};

		// Detail field IDs
		const detailFields = ['d_itemNo','d_badge','d_imgWrap','d_name','d_typeText','d_typeIcons',
			'd_serial','d_amount','d_purchase','d_detail','d_windows','d_cpu','d_ram','d_storage',
			'd_battery','d_wifi','d_lan','d_display'];

		// Status badge config
		const statusConfig = {
			A: { text: "Available", cls: "bg-success text-white" },
			B: { text: "Borrowing", cls: "bg-primary text-white" },
			W: { text: "Wait for approve", cls: "bg-warning text-dark" },
			C: { text: "Corrupted", cls: "bg-danger text-white" },
			F: { text: "Fixed", cls: "bg-info text-white" },
			L: { text: "Lost", cls: "bg-dark text-white" },
			S: { text: "Sold Out", cls: "bg-warning text-dark" },
			Z: { text: "Disabled", cls: "bg-secondary text-white" }
		};

		// Type config
		const typeConfig = {
			c: { text: "Computer", icon: "ico_c" },
			in: { text: "Instrument", icon: "ico_in" },
			sl: { text: "Software License", icon: "ico_sl" },
			l: { text: "Software License", icon: "ico_sl" },
			mob: { text: "Mobile", icon: "ico_mob" },
			p: { text: "Pocket WIFI", icon: "ico_p" }
		};

		const monthNames = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];

		// Utility functions
		function setText(id, val) {
			const el = document.getElementById(id);
			if (el) el.textContent = (val && String(val).trim()) || "";
		}

		function formatDate(raw) {
			const s = (raw || "").toString().trim().replace(/[TZ\u202F\u00A0]/g, " ").trim();
			if (!s || s === "null") return "-";

			const m1 = s.match(/^(\d{4})-(\d{2})-(\d{2})/);
			if (m1) {
				const d = String(m1[3]).padStart(2, "0");
				const m = monthNames[parseInt(m1[2], 10) - 1];
				return `${d} ${m} ${m1[1]}`;
			}

			const m2 = s.match(/^(\d{2})[\/-](\d{2})[\/-](\d{4})/);
			if (m2) {
				const d = String(m2[1]).padStart(2, "0");
				const m = monthNames[parseInt(m2[2], 10) - 1];
				return `${d} ${m} ${m2[3]}`;
			}

			const parsed = Date.parse(s);
			if (!isNaN(parsed)) {
				const dt = new Date(parsed);
				const d = String(dt.getDate()).padStart(2, "0");
				const m = monthNames[dt.getMonth()];
				return `${d} ${m} ${dt.getFullYear()}`;
			}

			return s;
		}

		function formatDateTimeLong(dtStr) {
			if (!dtStr) return "";
			let s = String(dtStr).trim();
			if (/^\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}/.test(s)) s = s.replace(" ", "T");
			const d = new Date(s);
			if (isNaN(d.getTime())) return String(dtStr);

			const months = ["January","February","March","April","May","June","July","August","September","October","November","December"];
			return `${d.getDate()} ${months[d.getMonth()]} ${d.getFullYear()}, ${String(d.getHours()).padStart(2,"0")}:${String(d.getMinutes()).padStart(2,"0")}`;
		}

		// Populate users
		function populateUsers() {
			if (!els.userSelect || !Array.isArray(users)) return;

			const fragment = document.createDocumentFragment();
			users.forEach(u => {
				const enable = u.enable || u.ENABLE || u.is_enable || u.isEnable || '0';
				if (enable == 1 || enable == '1' || enable == true || enable == 'true') {
					const opt = document.createElement('option');
					opt.value = u.id || u.user_id || u.USER_ID || '';
					opt.textContent = `${u.employee_id || u.employeeId || ''}-${u.name || u.fullname || ''}-${u.name_en || u.nameEn || ''}-${u.role || ''}`;
					fragment.appendChild(opt);
				}
			});
			els.userSelect.appendChild(fragment);

			els.userSelect.addEventListener("change", () => {
				if (els.hiddenId) els.hiddenId.value = els.userSelect.value || "";
			});
		}

		// Populate equipment
		function populateEquipment() {
			if (!els.equipSelect || !Array.isArray(equipments)) return;

			const fragment = document.createDocumentFragment();
			equipments.forEach(e => {
				const opt = document.createElement('option');
				const eqId = String(e.equipmentId || e.equipment_id || '').replace('.0', '');
				opt.value = eqId;
				opt.textContent = `${e.itemNo || e.item_no || ''} - ${e.name || ''}`;
				
				// Store data
				opt.dataset.itemno = e.itemNo || e.item_no || '';
				opt.dataset.name = e.name || '';
				opt.dataset.status = e.status || '';
				opt.dataset.type = e.type || '';
				opt.dataset.serial = e.serialNo || e.serial_no || '';
				opt.dataset.amount = e.amount || '';
				opt.dataset.detail = e.detail || '';
				opt.dataset.image = e.image || '';
				opt.dataset.purchase = e.timeCreate || e.time_create || '';
				opt.dataset.windows = e.windows || '';
				opt.dataset.cpu = e.process || e.cpu || '';
				opt.dataset.ram = e.ram || '';
				opt.dataset.storage = e.hdd || e.storage || '';
				opt.dataset.battery = e.battery || '';
				opt.dataset.wifi = e.wifiaddress || e.wifiAddress || '';
				opt.dataset.lan = e.lanaddress || e.lanAddress || '';
				opt.dataset.display = e.display || '';

				fragment.appendChild(opt);
			});
			els.equipSelect.appendChild(fragment);

			els.equipSelect.addEventListener("change", updateEquipmentDetail);
			if (window.jQuery) jQuery(els.equipSelect).on("change.select2", updateEquipmentDetail);

			if (preselectedEquipId) {
				els.equipSelect.value = preselectedEquipId;
				updateEquipmentDetail();
			}
		}

		// Update equipment detail card
		function updateEquipmentDetail() {
			const opt = els.equipSelect.options[els.equipSelect.selectedIndex];
			
			if (!opt || !opt.value) {
				clearEquipmentDetail();
				return;
			}

			const d = opt.dataset;
			const type = (d.type || "").trim().toLowerCase();
			const isComputer = type === "c";

			// Update basic info
			setText('d_itemNo', d.itemno);
			updateBadge(d.status);
			updateImage(d.image, d.itemno);
			setText('d_name', d.name);
			updateType(type);
			setText('d_serial', d.serial);
			setText('d_amount', d.amount);
			setText('d_purchase', formatDate(d.purchase));
			setText('d_detail', d.detail);

			// Show/hide more detail section
			if (els.moreDetailSection) {
				els.moreDetailSection.classList.toggle('d-none', !isComputer);
			}

			// Update computer details
			if (isComputer) {
				setText('d_windows', d.windows);
				setText('d_cpu', d.cpu);
				setText('d_ram', d.ram);
				setText('d_storage', d.storage);
				setText('d_battery', d.battery);
				setText('d_wifi', d.wifi);
				setText('d_lan', d.lan);
				setText('d_display', d.display);
			}

			// Collapse more detail if open
			if (els.moreDetailCollapse?.classList.contains("show") && window.bootstrap) {
				bootstrap.Collapse.getOrCreateInstance(els.moreDetailCollapse).hide();
			}

			// Load status log
			loadStatusLog(opt.value);
		}

		function clearEquipmentDetail() {
			detailFields.forEach(id => {
				const el = document.getElementById(id);
				if (el) el.textContent = "";
			});
			
			const badge = document.getElementById("d_badge");
			if (badge) {
				badge.className = "badge badge-lg rounded-pill px-4 fw-semibold bg-light text-gray-700";
				badge.textContent = "-";
			}

			const imgWrap = document.getElementById("d_imgWrap");
			if (imgWrap) imgWrap.innerHTML = "";

			if (els.moreDetailSection) els.moreDetailSection.classList.add('d-none');
			
			renderStatusLog([]);
		}

		function updateBadge(status) {
			const badge = document.getElementById("d_badge");
			if (!badge) return;

			const st = (status || "").toUpperCase();
			const config = statusConfig[st];

			badge.className = "badge badge-lg rounded-pill px-4 fw-semibold " + (config ? config.cls : "bg-light text-gray-700");
			badge.textContent = config ? config.text : "";
		}

		function updateImage(imgPath, altText) {
			const wrap = document.getElementById("d_imgWrap");
			if (!wrap) return;

			let src = (imgPath || "").trim();
			if (!src) {
				wrap.innerHTML = '<div class="symbol symbol-150px border rounded-3 bg-light d-flex align-items-center justify-content-center"><i class="fa-solid fa-image fs-1 text-muted"></i></div>';
				return;
			}

			if (!src.startsWith("http")) src = CTX + (src.startsWith("/") ? src : "/" + src);
			wrap.innerHTML = `<div class="symbol symbol-150px"><img src="${src}" alt="${altText || 'equipment'}" class="border rounded-3 object-fit-cover w-100 h-100" /></div>`;
		}

		function updateType(typeCode) {
			const textEl = document.getElementById("d_typeText");
			const iconsWrap = document.getElementById("d_typeIcons");
			if (!textEl) return;

			// Hide all icons
			['ico_c','ico_in','ico_sl','ico_mob','ico_p','ico_other'].forEach(id => {
				document.getElementById(id)?.classList.add("d-none");
			});

			const t = (typeCode || "").trim().toLowerCase();
			if (!t) {
				textEl.textContent = "";
				if (iconsWrap) iconsWrap.classList.add("d-none");
				return;
			}

			if (iconsWrap) iconsWrap.classList.remove("d-none");
			const config = typeConfig[t] || { text: "Other", icon: "ico_other" };
			textEl.textContent = config.text;
			document.getElementById(config.icon)?.classList.remove("d-none");
		}

		// Status log functions
		function loadStatusLog(eqId) {
			if (!eqId || !window.jQuery?.ajax) {
				renderStatusLog([]);
				return;
			}

			jQuery.ajax({
				url: `${CTX}/eBorrowLog.action`,
				type: "GET",
				dataType: "json",
				data: { equipmentId: eqId },
				success: list => renderStatusLog(Array.isArray(list) ? list : []),
				error: () => renderStatusLog([])
			});
		}

		function renderStatusLog(list) {
			if (!els.statusLogBox || !els.statusLogEmpty) return;

			els.statusLogBox.innerHTML = "";
			els.statusLogEmpty.classList.add("d-none");
			if (els.btnReturn) els.btnReturn.classList.add("d-none");

			if (!list || list.length === 0) {
				els.statusLogEmpty.classList.remove("d-none");
				return;
			}

			if (els.btnReturn && String(list[0].status || "").toUpperCase() === "B") {
				els.btnReturn.classList.remove("d-none");
			}

			const fragment = document.createDocumentFragment();
			const timeline = document.createElement("div");
			timeline.className = "timeline timeline-border-dashed";

			list.forEach(borrow => {
				const st = String(borrow.status || "").toUpperCase();
				
				// Returned status
				if (st === "R") {
					timeline.appendChild(createTimelineItem(borrow, "Returned", "success", borrow.date_end || "Unknown Return Date"));
				}

				// Borrowed/Borrowing status
				const badgeText = st === "B" ? "Borrowing" : "Borrowed";
				timeline.appendChild(createTimelineItem(borrow, badgeText, "warning", borrow.date_start || "-"));
				
				// Separator
				const sep = document.createElement("div");
				sep.className = "separator separator-dashed border-gray-300 my-5";
				timeline.appendChild(sep);
			});

			fragment.appendChild(timeline);
			els.statusLogBox.appendChild(fragment);
		}

		function createTimelineItem(borrow, badgeText, badgeType, dateValue) {
			const item = document.createElement("div");
			item.className = "timeline-item";

			const iconColor = badgeType === "success" ? "text-success" : "text-warning";
			item.innerHTML = `
				<div class="timeline-line"></div>
				<div class="timeline-icon">
					<i class="ki-duotone ki-cd fs-2 ${iconColor}"><span class="path1"></span><span class="path2"></span></i>
				</div>
				<div class="timeline-content mb-5 mt-n1">
					<div class="mb-2">
						<span class="badge badge-${badgeType} fw-bold fs-7">${badgeText}</span>
					</div>
					<div class="d-flex align-items-center mt-4 mb-2">
						<i class="ki-duotone ki-user fs-4 text-gray-700 me-3"><span class="path1"></span><span class="path2"></span></i>
						<div class="fs-5 fw-semibold text-gray-800">${getUserText(borrow)}</div>
					</div>
					<div class="d-flex align-items-center mt-4 fs-7 text-muted">
						<i class="ki-duotone ki-calendar fs-4 text-gray-700 me-3"><span class="path1"></span><span class="path2"></span></i>
						<div class="fs-5 fw-semibold text-gray-800">${formatDateTimeLong(dateValue)}</div>
					</div>
					${borrow.location ? `
					<div class="d-flex align-items-center mt-4 mb-2 fs-7 text-muted">
						<i class="ki-duotone ki-geolocation fs-2 me-3"><span class="path1"></span><span class="path2"></span></i>
						<div class="fs-5 fw-semibold text-gray-800">${borrow.location}</div>
					</div>` : ''}
				</div>
			`;

			return item;
		}

		function getUserText(row) {
			const emp = row.employee_id || "";
			const name = row.name || "-";
			const en = row.name_en || "";
			return `${emp ? emp + " - " : ""}${name}${en ? " - " + en : ""}`;
		}

		// Initialize collapse
		function initCollapse() {
			if (!els.moreDetailCollapse || !els.moreDetailBtn || !els.moreDetailIcon) return;

			const instance = bootstrap.Collapse.getOrCreateInstance(els.moreDetailCollapse, { toggle: false });

			els.moreDetailBtn.addEventListener("click", e => {
				e.preventDefault();
				if (els.moreDetailCollapse.classList.contains("show")) instance.hide();
				else instance.show();
			});

			els.moreDetailCollapse.addEventListener("show.bs.collapse", () => {
				els.moreDetailIcon.style.transform = "rotate(180deg)";
				els.moreDetailBtn.setAttribute("aria-expanded", "true");
			});

			els.moreDetailCollapse.addEventListener("hide.bs.collapse", () => {
				els.moreDetailIcon.style.transform = "rotate(0deg)";
				els.moreDetailBtn.setAttribute("aria-expanded", "false");
			});
		}

		// Initialize date pickers
		function initDatePickers() {
			if (typeof flatpickr === "undefined" || !els.startDate || !els.endDate) return;

			const startPicker = flatpickr(els.startDate, {
				enableTime: true,
				time_24hr: true,
				dateFormat: "d m Y , H : i",
				altInput: true,
				altFormat: "d M Y , H : i",
				allowInput: true
			});

			const endPicker = flatpickr(els.endDate, {
				enableTime: true,
				time_24hr: true,
				dateFormat: "d m Y , H : i",
				altInput: true,
				altFormat: "d M Y , H : i",
				allowInput: true
			});

			els.startDate.addEventListener("change", function() {
				const v = this.value || "";
				endPicker.set("minDate", v || null);
				if (v && els.endDate.value && els.endDate.value < v) {
					els.endDate.value = v;
				}
			});
		}

		// Initialize
		document.addEventListener("DOMContentLoaded", function() {
			// Cache all DOM elements
			els.userSelect = document.getElementById("user_select");
			els.equipSelect = document.getElementById("equipment_select");
			els.hiddenId = document.querySelector('input[name="id"]');
			els.startDate = document.getElementById("start_date");
			els.endDate = document.getElementById("end_date");
			els.moreDetailSection = document.getElementById("moreDetailSection");
			els.moreDetailBtn = document.getElementById("btn_moreDetail");
			els.moreDetailCollapse = document.getElementById("moreDetailCollapse");
			els.moreDetailIcon = document.getElementById("icon_more");
			els.statusLogBox = document.getElementById("statusLogBox");
			els.statusLogEmpty = document.getElementById("statusLogEmpty");
			els.btnReturn = document.getElementById("btnRequestReturn");

			// Initialize all features
			populateUsers();
			populateEquipment();
			initCollapse();
			initDatePickers();
		});
	})();
	</script>
</body>
</html>