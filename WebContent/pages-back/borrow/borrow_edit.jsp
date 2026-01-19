<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<fmt:setLocale value="en_US" />
<fmt:formatDate value="${equipmentbyId.timeCreate}" pattern="d MMM yyyy" var="purchaseFmt" />

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
/* Light Mode */
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

/* Dark Mode */
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
				<div id="kt_app_toolbar_container" class="app-container container-fluid d-flex align-items-center justify-content-start">
					<div class="page-title d-flex flex-column flex-wrap me-3 align-items-start">
						<h1 class="page-heading fw-semibold my-0 text-start" style="color: #4b5675;">Borrow Detail</h1>
						<ul class="breadcrumb breadcrumb-separatorless fw-medium fs-7 my-0 pt-1">
							<li class="breadcrumb-item text-muted">
								<a href="${pageContext.request.contextPath}/demo_dashboard" class="text-muted text-hover-primary">Home</a>
							</li>
							<li class="breadcrumb-item"><span class="bullet bg-gray-500 w-4px h-1px"></span></li>
							<li class="breadcrumb-item text-muted">
								<a href="${pageContext.request.contextPath}/borrow_list" class="text-muted text-hover-primary">Borrow</a>
							</li>
							<li class="breadcrumb-item"><span class="bullet bg-gray-500 w-4px h-1px"></span></li>
							<li class="breadcrumb-item text-muted">Borrow Detail</li>
						</ul>
					</div>
				</div>
			</div>
			<!-- end Toolbar -->

			<div id="kt_app_content" class="app-content flex-column-fluid">
				<div id="kt_app_content_container" class="app-container container-fluid">

					<div class="row g-5 g-xl-10">

						<!-- LEFT : FORM -->
						<div class="col-xl-8">
							<form action="${pageContext.request.contextPath}/eBorrowUpdate.action" method="post" class="card shadow-none"
								style="height: fit-content;">
								<input type="hidden" name="id" value="${sessionScope.bId}" />
								<div class="card-header py-4" style="border-bottom: 1px solid #E4E6EF;">
									<h3 class="card-title fw-bold mb-0">Borrow Equipment</h3>
								</div>

								<div class="card-body pt-6">

									<!-- Borrower -->
									<div class="mb-7">
										<label class="form-label required fw-medium">Borrower</label>
										<select name="user" id="borrower-select" class="form-select form-select fw-medium text-muted" data-control="select2" data-placeholder="Select Borrower" disabled>
										</select>
									</div>

									<!-- Status -->
									<div class="mb-7">
										<label class="required fw-semibold fs-6 mb-2 d-block">Status</label>
										<select name="status" id="status-select" class="form-select form-select" required>
											<option value="">-- Select status --</option>
										</select>
									</div>

									<!-- Equipment -->
									<div class="mb-7">
										<label class="required fw-semibold fs-6 mb-2 d-block">Equipment</label>
										<select id="equipment-select" class="form-select form-select fw-medium text-muted" required disabled>
											<option value="">-- Select equipment --</option>
										</select>
										<input type="hidden" name="equipment" id="equipment-hidden" value="${equipId}" />
									</div>

									<!-- Start / End Date -->
									<div class="row mb-7">
										<div class="col-lg-6">
											<label class="form-label required fw-semibold fs-6">Start Date</label>
											<div class="position-relative d-flex align-items-center">
												<i class="ki-outline ki-calendar fs-3 position-absolute ms-4"></i>
												<input type="text" id="start_date" class="form-control form-control ps-12" name="date_from" placeholder="Select Date" autocomplete="off" required />
											</div>
										</div>

										<div class="col-lg-6">
											<label class="form-label fw-semibold fs-6">End Date</label>
											<div class="position-relative d-flex align-items-center">
												<i class="ki-outline ki-calendar fs-3 position-absolute ms-4"></i>
												<input type="text" id="end_date" class="form-control form-control ps-12" name="date_to" placeholder="Select Date" autocomplete="off" />
											</div>
										</div>
									</div>

									<!-- Location -->
									<div class="mb-7">
										<label class="required fw-semibold fs-6 mb-2 d-block">Location</label>
										<input class="form-control form-control" type="text" name="location" id="location-input" />
									</div>

									<!-- Reason -->
									<div class="mb-7">
										<label class="fw-semibold fs-6 mb-2 d-block">Reason</label>
										<textarea class="form-control form-control" rows="4" name="reason" id="reason-textarea" placeholder="ระบุเหตุผลการยืม"></textarea>
									</div>

									<!-- Contact Address -->
									<div class="mb-7">
										<label class="fw-semibold fs-6 mb-2 d-block">Contact Address</label>
										<textarea class="form-control form-control" rows="4" name="contact" id="contact-textarea" placeholder="Address"></textarea>
									</div>

									<!-- Remark -->
									<div class="mb-7">
										<label class="fw-semibold fs-6 mb-2 d-block">Remark</label>
										<textarea class="form-control form-control" rows="4" name="remark" id="remark-textarea" placeholder="Remark"></textarea>
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

						<!-- RIGHT : Equipment Detail & Status Log -->
						<div class="col-xl-4">

							<!-- Equipment Detail Card -->
							<div class="card mb-5" id="equipment-detail-card">
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
												<button type="button" class="btn btn-sm btn-warning btn-open-return-modal">
													Request for Return
												</button>
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
																<i class="ki-duotone ki-cd fs-2 text-success"><span class="path1"></span><span class="path2"></span></i>
															</div>
															<div class="timeline-content mb-5 mt-n1">
																<div class="mb-2">
																	<span class="badge badge-success fw-bold fs-7">Returned</span>
																</div>
																<div class="d-flex align-items-center mt-4 mb-2">
																	<i class="ki-duotone ki-user fs-4 text-gray-700 me-3"><span class="path1"></span><span class="path2"></span></i>
																	<div class="fs-5 fw-semibold text-gray-800">
																		<c:if test="${not empty borrow.employee_id}">${borrow.employee_id} - </c:if>${borrow.name}
																		<c:if test="${not empty borrow.name_en}"> - ${borrow.name_en}</c:if>
																	</div>
																</div>
																<div class="d-flex align-items-center mt-4 fs-7 text-muted">
																	<i class="ki-duotone ki-calendar fs-4 text-gray-700 me-3"><span class="path1"></span><span class="path2"></span></i>
																	<div class="fs-5 fw-semibold text-gray-800">
																		<c:choose>
																			<c:when test="${not empty borrow.date_end}">
																				<fmt:setLocale value="en_US" />
																				<fmt:formatDate value="${borrow.date_end}" pattern="d MMMM yyyy, HH:mm" />
																			</c:when>
																			<c:otherwise>Unknown Return Date</c:otherwise>
																		</c:choose>
																	</div>
																</div>
																<c:if test="${not empty borrow.location}">
																	<div class="d-flex align-items-center mt-4 mb-2 fs-7 text-muted">
																		<i class="ki-duotone ki-geolocation fs-2 me-3"><span class="path1"></span><span class="path2"></span></i>
																		<div class="fs-5 fw-semibold text-gray-800">${borrow.location}</div>
																	</div>
																</c:if>
															</div>
														</div>
													</c:if>

													<div class="timeline-item">
														<div class="timeline-icon">
															<i class="ki-duotone ki-cd fs-2 text-warning"><span class="path1"></span><span class="path2"></span></i>
														</div>
														<div class="timeline-content mb-0 mt-n1">
															<div class="mb-2">
																<span class="badge badge-warning fw-bold fs-7">
																	${borrow.status == 'B' ? 'Borrowing' : 'Borrowed'}
																</span>
															</div>
															<div class="d-flex align-items-center mt-4 mb-2">
																<i class="ki-duotone ki-user fs-4 text-gray-700 me-3"><span class="path1"></span><span class="path2"></span></i>
																<div class="fs-5 fw-semibold text-gray-800">
																	<c:if test="${not empty borrow.employee_id}">${borrow.employee_id} - </c:if>${borrow.name}
																	<c:if test="${not empty borrow.name_en}"> - ${borrow.name_en}</c:if>
																</div>
															</div>
															<div class="d-flex align-items-center mt-4 fs-7 text-muted">
																<i class="ki-duotone ki-calendar fs-4 text-gray-700 me-3"><span class="path1"></span><span class="path2"></span></i>
																<div class="fs-5 fw-semibold text-gray-800">
																	<fmt:setLocale value="en_US" />
																	<fmt:formatDate value="${borrow.date_start}" pattern="d MMMM yyyy, HH:mm" />
																</div>
															</div>
															<c:if test="${not empty borrow.location}">
																<div class="d-flex align-items-center mt-4 fs-7 text-muted">
																	<i class="ki-duotone ki-geolocation fs-4 text-gray-700 me-3"><span class="path1"></span><span class="path2"></span></i>
																	<div class="fs-5 fw-semibold text-gray-800">${borrow.location}</div>
																</div>
															</c:if>
														</div>
													</div>

													<div class="separator separator-dashed border-gray-300 my-5"></div>
												</c:forEach>
											</div>
										</c:when>
										<c:otherwise>
											<div class="d-flex flex-column align-items-center justify-content-center py-10">
												<i class="ki-duotone ki-cube-2 fs-3x text-gray-500 mb-4">
													<span class="path1"></span><span class="path2"></span><span class="path3"></span>
												</i>
												<span class="text-gray-800 fw-semibold fs-5">No data</span>
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
	<div class="modal fade" id="borrowDetailModal" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-lg">
			<div class="modal-content">
				<div class="modal-header border-0 px-6 pt-5 pb-0 align-items-center">
					<h2 class="modal-title fw-bold mb-0">Borrow Detail</h2>
					<button type="button" class="btn btn-icon btn-sm btn-light btn-active-light-primary" data-bs-dismiss="modal">
						<i class="ki-duotone ki-cross fs-2"><span class="path1"></span><span class="path2"></span></i>
					</button>
				</div>

				<div class="modal-body scroll-y px-5 px-xl-10 py-7">
					<div class="row mb-6">
						<div class="col-md-6 pe-md-6">
							<div class="d-flex align-items-center gap-5 mb-3 pb-4">
								<a href="javascript:void(0);" id="bd_item_link" class="fw-bold fs-5 text-primary"></a>
								<span id="bd_status_badge" class="badge badge-lg rounded-pill px-4 fw-semibold"></span>
							</div>
							<div class="d-flex flex-column fs-7 text-gray-700">
								<div class="pb-4">
									<span class="fw-normal fs-5 text-gray-700 me-2">Serial No:</span>
									<span id="bd_serial" class="fw-normal fs-5 text-gray-800 text-break"></span>
								</div>
								<div>
									<span class="fw-normal fs-5 text-gray-700 me-2">Detail:</span>
									<span id="bd_detail" class="fw-normal fs-5 text-gray-800 text-break"></span>
								</div>
							</div>
						</div>

						<div class="col-md-6 ps-md-10 mt-5 mt-md-0">
							<div class="d-flex align-items-center mb-1 pb-4">
								<i class="ki-duotone ki-laptop fs-2x text-gray-600 me-3"><span class="path1"></span><span class="path2"></span></i>
								<span class="fw-bold fs-5 text-gray-800 text-break" id="bd_name"></span>
							</div>
							<div class="fs-5 text-gray-700 fw-normal mt-1 pb-4 me-4">
								Amount: <span id="bd_amount" class="fw-semibold text-gray-800"></span>
							</div>
							<div class="fs-5 text-gray-700 fw-normal mt-1 pb-4 me-4">
								Date of Purchase: <span id="bd_purchase_date" class="fw-normal text-gray-800 text-break"></span>
							</div>
						</div>
					</div>

					<div id="bd_moreDetailWrapper" class="mt-2">
						<a href="#" id="bd_moreDetailToggle" class="fw-medium fs-5 pb-4 text-primary d-inline-flex align-items-center" role="button" aria-controls="bd_moreDetailCollapse" aria-expanded="false">
							More Detail
							<i id="bd_moreDetailIcon" class="ki-duotone ki-down fs-4 ms-4"><span class="path1"></span><span class="path2"></span></i>
						</a>

						<div class="collapse mt-3" id="bd_moreDetailCollapse">
							<div class="row fs-7 text-gray-700">
								<div class="col-md-6 pe-md-10">
									<div class="mb-3 pb-4">
										<span class="fw-normal fs-5 text-gray-700 me-3">Windows</span>
										<span id="bd_windows" class="ms-1 fw-normal fs-5 text-gray-800 text-break"></span>
									</div>
									<div class="mb-3 pb-4">
										<span class="fw-normal fs-5 text-gray-700 me-3">Ram</span>
										<span id="bd_ram" class="ms-1 fw-normal fs-5 text-gray-800 text-break"></span>
									</div>
									<div class="mb-3 pb-4">
										<span class="fw-normal fs-5 text-gray-700 me-3">Storage</span>
										<span id="bd_storage" class="ms-1 fw-normal fs-5 text-gray-800 text-break"></span>
									</div>
									<div class="mb-3 pb-4">
										<span class="fw-normal fs-5 text-gray-700 me-3">WIFI Address</span>
										<span id="bd_wifi" class="ms-1 fw-normal fs-5 text-gray-800 text-break"></span>
									</div>
									<div class="mb-3 pb-4">
										<span class="fw-normal fs-5 text-gray-700 me-3">Display</span>
										<span id="bd_display" class="ms-1 fw-normal fs-5 text-gray-800 text-break"></span>
									</div>
								</div>

								<div class="col-md-6 ps-md-10">
									<div class="mb-3 pb-4">
										<span class="fw-normal fs-5 text-gray-700 me-3">CPU</span>
										<span id="bd_cpu" class="ms-1 fw-normal fs-5 text-gray-800 text-break"></span>
									</div>
									<div class="mb-3 pb-4">
										<span class="fw-normal fs-5 text-gray-700 me-3">Storage</span>
										<span id="bd_storage2" class="ms-1 fw-normal fs-5 text-gray-800 text-break"></span>
									</div>
									<div class="mb-3 pb-4">
										<span class="fw-normal fs-5 text-gray-700 me-3">Battery</span>
										<span id="bd_battery" class="ms-1 fw-normal fs-5 text-gray-800 text-break"></span>
									</div>
									<div class="mb-3 pb-4">
										<span class="fw-normal fs-5 text-gray-700 me-3">LAN Address</span>
										<span id="bd_lan" class="ms-1 fw-normal fs-5 text-gray-800 text-break"></span>
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="mt-10">
						<div class="text-primary fw-bold fs-5 mb-7">Approver</div>
						<div class="text-gray-800 fs-7 mb-4">Specify a note when changing status (optional)</div>
						<textarea id="bd_approver_note" class="form-control form-control-solid" rows="3" placeholder="Enter maintenance or repair notes..."></textarea>
					</div>
				</div>

				<div class="modal-footer border-0 pt-0 pb-6 px-6 d-flex justify-content-end gap-3">
					<button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
					<button type="button" class="btn btn-warning" id="bd_request_return">Request for Return</button>
				</div>
			</div>
		</div>
	</div>

	<!-- ===== JavaScript ===== -->
	<script>
	// ดึงข้อมูลจาก JSP attributes ที่ส่งมาจาก Action
	var userList = ${userList != null ? userList : '[]'};
	var equipments = ${equipments != null ? equipments : '[]'};
	var borrowData = ${borrow != null ? borrow : '{}'};
	var statusList = ${status != null ? status : '[]'};
	var typeList = ${type != null ? type : '[]'};
	var borrowWithUserList = ${borrowlistwithUserJSON != null ? borrowlistwithUserJSON : '[]'};

	// Context path
	var CTX = "${pageContext.request.contextPath}";

	// ข้อมูล Equipment ปัจจุบัน
	var currentEquipment = {
		id: "${equipmentbyId.equipmentId}",
		itemNo: "${equipmentbyId.itemNo}",
		name: "${equipmentbyId.name}",
		serialNo: "${equipmentbyId.serialNo}",
		detail: "${equipmentbyId.detail}",
		amount: "${equipmentbyId.amount}",
		status: "${equipmentbyId.status}",
		type: "${equipmentbyId.type}",
		image: "${equipmentbyId.image}",
		timeCreate: "${equipmentbyId.timeCreate}",
		purchaseFmt: "${purchaseFmt}",
		windows: "${equipmentbyId.windows}",
		process: "${equipmentbyId.process}",
		ram: "${equipmentbyId.ram}",
		hdd: "${equipmentbyId.hdd}",
		battery: "${equipmentbyId.battery}",
		wifiaddress: "${equipmentbyId.wifiaddress}",
		lanaddress: "${equipmentbyId.lanaddress}",
		display: "${equipmentbyId.display}"
	};

	// Helper functions
	function getBorrowField(field) {
		return borrowData[field] || borrowData[field.replace(/([A-Z])/g, '_$1').toLowerCase()] || '';
	}

	function setText(id, val) {
		const el = document.getElementById(id);
		if (!el) return;
		el.textContent = (val !== undefined && val !== null && String(val).trim() !== "") ? val : "-";
	}

	function setBadge(status) {
		const $b = $('#bd_status_badge');
		if (!$b.length) return;

		$b.removeClass().addClass('badge badge-lg rounded-pill px-4 fw-semibold');

		const st = String(status || '').toUpperCase();
		if (st === 'B') {
			$b.addClass('bg-warning text-white').text('Borrowing');
		} else if (st === 'W') {
			$b.addClass('bg-light text-dark').text('Wait for Approve');
		} else if (st === 'R') {
			$b.addClass('bg-success text-white').text('Returned');
		} else {
			$b.addClass('bg-light text-muted').text('-');
		}
	}

	function formatNumber(num) {
		if (!num) return '1';
		return Math.floor(Number(num));
	}

	function getEquipmentStatusBadge(status) {
		const badges = {
			'B': '<span class="badge badge-lg px-4 fw-semibold bg-primary text-white">Borrowing</span>',
			'A': '<span class="badge badge-lg px-4 fw-semibold bg-success text-white">Available</span>',
			'C': '<span class="badge badge-lg px-4 fw-semibold bg-danger text-white">Corrupted</span>',
			'F': '<span class="badge badge-lg px-4 fw-semibold bg-info text-white">Fixed</span>',
			'L': '<span class="badge badge-lg px-4 fw-semibold bg-dark text-white">Lost</span>',
			'S': '<span class="badge badge-lg px-4 fw-semibold bg-warning text-dark">Sold Out</span>',
			'W': '<span class="badge badge-lg px-4 fw-semibold bg-warning text-dark">Wait for approve</span>',
			'Z': '<span class="badge badge-lg px-4 fw-semibold bg-secondary text-white">Disabled</span>'
		};
		return badges[status] || '<span class="badge badge-lg px-4 fw-semibold bg-light text-gray-700">-</span>';
	}

	function getEquipmentTypeInfo(type) {
		const types = {
			'c': { label: 'Computer', icon: 'ki-duotone ki-laptop fs-4 text-gray-600' },
			'in': { label: 'Instrument', icon: 'ki-duotone ki-keyboard fs-4 text-gray-600' },
			'L': { label: 'Software License', icon: 'ki-duotone ki-verify fs-4 text-gray-600' },
			'sl': { label: 'Software License', icon: 'ki-duotone ki-verify fs-4 text-gray-600' },
			'Mob': { label: 'Mobile', icon: 'ki-duotone ki-phone fs-4 text-gray-600' },
			'p': { label: 'Pocket Wifi', icon: 'ki-duotone ki-wifi-square fs-4 text-gray-600' }
		};
		return types[type] || { label: 'Other', icon: 'ki-duotone ki-dots-square fs-4 text-gray-600' };
	}

	// ===== Initialize Page =====
	$(document).ready(function() {
		// Populate Borrower Select
		const $borrowerSelect = $('#borrower-select');
		const borrowerId = getBorrowField('userBorrowid') || getBorrowField('user_borrowid');
		
		$borrowerSelect.empty();
		userList.forEach(function(user) {
			const uid = user.id || user.user_id || user.USER_ID || '';
			const employeeId = user.employee_id || user.employeeId || user.EMPLOYEE_ID || '';
			const nameTh = user.name || user.fullname || user.USER_NAME || '';
			const nameEn = user.name_en || user.nameEn || user.NAME_EN || '';
			const roleId = user.role_id || user.roleId || user.role || '';
			
			const text = (employeeId || '-') + '  -  ' + (nameTh || '-') + '  -  ' + (nameEn || '-') + '  -  ' + (roleId || '-');
			const isSelected = String(uid).toLowerCase().trim() === String(borrowerId).toLowerCase().trim();
			
			$borrowerSelect.append(new Option(text, uid, isSelected, isSelected));
		});
		
		if ($.fn.select2 && $borrowerSelect.data('control') === 'select2') {
			$borrowerSelect.select2();
		}

		// Populate Status Select
		const $statusSelect = $('#status-select');
		const currentStatus = getBorrowField('status') || getBorrowField('statusborrow') || getBorrowField('status_code');
		
		const allowedStatuses = ['B', 'C', 'W'];
		const statusLabels = {
			'B': 'Borrowing',
			'C': 'Cancel',
			'W': 'Wait for Approve'
		};
		
		statusList.forEach(function(status) {
			const statusId = status.statusId || status.status_id || '';
			if (allowedStatuses.includes(statusId)) {
				const label = statusLabels[statusId] || statusId;
				const isSelected = statusId === currentStatus;
				$statusSelect.append(new Option(label, statusId, isSelected, isSelected));
			}
		});

		// Populate Equipment Select
		const $equipmentSelect = $('#equipment-select');
		const currentEquipId = getBorrowField('equipmentId') || getBorrowField('equipment_id');
		
		equipments.forEach(function(equip) {
			const equipId = equip.equipmentId || equip.equipment_id || '';
			const itemNo = equip.itemNo || equip.item_no || '';
			const name = equip.name || '';
			const text = itemNo + ' - ' + name;
			const isSelected = String(equipId) === String(currentEquipId);
			$equipmentSelect.append(new Option(text, equipId, isSelected, isSelected));
		});
		
		$('#equipment-hidden').val(currentEquipId);

		// Set Form Values
		const dateStart = getBorrowField('dateStart') || getBorrowField('date_start');
		const dateEnd = getBorrowField('dateEnd') || getBorrowField('date_end');
		
		if (dateStart) $('#start_date').val(dateStart);
		if (dateEnd) $('#end_date').val(dateEnd);
		
		$('#location-input').val(getBorrowField('location') || '');
		$('#reason-textarea').val(getBorrowField('reason') || '');
		$('#contact-textarea').val(getBorrowField('contactAddr') || getBorrowField('contact_addr') || '');
		$('#remark-textarea').val(getBorrowField('remark') || '');

		// Initialize DatePickers
		if (typeof flatpickr !== 'undefined') {
			flatpickr("#start_date", {
				enableTime: true,
				time_24hr: true,
				dateFormat: "d M Y , H:i"
			});

			flatpickr("#end_date", {
				enableTime: true,
				time_24hr: true,
				dateFormat: "d M Y , H:i"
			});
		}

		// Render Equipment Detail Card
		renderEquipmentDetailCard();

		// Setup Collapse Toggle
		setupCollapseToggle();

		// Setup Modal Handlers
		setupModalHandlers();
	});

	// ===== Render Equipment Detail Card =====
	function renderEquipmentDetailCard() {
		const equip = currentEquipment;
		const equipId = equip.id;
		
		const statusBadge = getEquipmentStatusBadge(equip.status);
		const typeInfo = getEquipmentTypeInfo(equip.type);
		
		const imageHTML = equip.image 
			? '<div class="symbol symbol-150px"><img src="' + equip.image + '" alt="' + equip.itemNo + '" class="border rounded-3 object-fit-cover w-100 h-100" /></div>'
			: '<div class="symbol symbol-150px border rounded-3 bg-light d-flex align-items-center justify-content-center"><i class="fa-solid fa-image fs-1 text-muted"></i></div>';
		
		let detailRows = '';
		detailRows += '<div class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">';
		detailRows += '<div class="text-gray-500" style="min-width: 130px;">Name:</div>';
		detailRows += '<div class="fw-semibold text-gray-800 text-break">' + (equip.name || '-') + '</div></div>';
		
		detailRows += '<div class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">';
		detailRows += '<div class="text-gray-500" style="min-width: 130px;">Type:</div>';
		detailRows += '<div class="fw-semibold text-gray-800 d-flex align-items-center gap-2 text-break">';
		detailRows += typeInfo.label + ' <i class="' + typeInfo.icon + '"><span class="path1"></span><span class="path2"></span></i></div></div>';
		
		detailRows += '<div class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">';
		detailRows += '<div class="text-gray-500" style="min-width: 130px;">Serial No:</div>';
		detailRows += '<div class="fw-semibold text-gray-800 text-break">' + (equip.serialNo || '-') + '</div></div>';
		
		detailRows += '<div class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">';
		detailRows += '<div class="text-gray-500" style="min-width: 130px;">Amount:</div>';
		detailRows += '<div class="fw-semibold text-gray-800">' + formatNumber(equip.amount) + '</div></div>';
		
		detailRows += '<div class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">';
		detailRows += '<div class="text-gray-500" style="min-width: 130px;">Date of Purchase:</div>';
		detailRows += '<div class="fw-semibold text-gray-800 text-break">' + (equip.purchaseFmt || '-') + '</div></div>';
		
		detailRows += '<div class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">';
		detailRows += '<div class="text-gray-500" style="min-width: 130px;">Detail:</div>';
		detailRows += '<div class="fw-semibold text-gray-800 text-break">' + (equip.detail || '-') + '</div></div>';
		
		let moreDetailSection = '';
		if (equip.type && equip.type.toLowerCase() === 'c') {
			moreDetailSection = '<div>';
			moreDetailSection += '<button type="button" class="btn btn-link p-0 w-100 text-primary fw-semibold d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200" ';
			moreDetailSection += 'data-collapse-target="#moreDetailCollapse_' + equipId + '" aria-expanded="false" aria-controls="moreDetailCollapse_' + equipId + '">';
			moreDetailSection += '<span>More Detail</span>';
			moreDetailSection += '<i class="ki-duotone ki-down fs-3" id="icon_' + equipId + '" style="transition: transform .2s ease;"><span class="path1"></span><span class="path2"></span></i>';
			moreDetailSection += '</button>';
			
			moreDetailSection += '<div class="collapse mt-3" id="moreDetailCollapse_' + equipId + '" data-equip-id="' + equipId + '">';
			moreDetailSection += '<div class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">';
			moreDetailSection += '<div class="text-gray-500" style="min-width: 130px;">Windows</div>';
			moreDetailSection += '<div class="fw-semibold text-gray-800 text-break">' + (equip.windows || '-') + '</div></div>';
			
			moreDetailSection += '<div class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">';
			moreDetailSection += '<div class="text-gray-500" style="min-width: 130px;">CPU</div>';
			moreDetailSection += '<div class="fw-semibold text-gray-800 text-break">' + (equip.process || '-') + '</div></div>';
			
			moreDetailSection += '<div class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">';
			moreDetailSection += '<div class="text-gray-500" style="min-width: 130px;">Ram</div>';
			moreDetailSection += '<div class="fw-semibold text-gray-800 text-break">' + (equip.ram || '-') + '</div></div>';
			
			moreDetailSection += '<div class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">';
			moreDetailSection += '<div class="text-gray-500" style="min-width: 130px;">Storage</div>';
			moreDetailSection += '<div class="fw-semibold text-gray-800 text-break">' + (equip.hdd || '-') + '</div></div>';
			
			moreDetailSection += '<div class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">';
			moreDetailSection += '<div class="text-gray-500" style="min-width: 130px;">Battery</div>';
			moreDetailSection += '<div class="fw-semibold text-gray-800 text-break">' + (equip.battery || '-') + '</div></div>';
			
			moreDetailSection += '<div class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">';
			moreDetailSection += '<div class="text-gray-500" style="min-width: 130px;">WIFI Address</div>';
			moreDetailSection += '<div class="fw-semibold text-gray-800 text-break">' + (equip.wifiaddress || '-') + '</div></div>';
			
			moreDetailSection += '<div class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">';
			moreDetailSection += '<div class="text-gray-500" style="min-width: 130px;">LAN Address</div>';
			moreDetailSection += '<div class="fw-semibold text-gray-800 text-break">' + (equip.lanaddress || '-') + '</div></div>';
			
			moreDetailSection += '<div class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">';
			moreDetailSection += '<div class="text-gray-500" style="min-width: 130px;">Display</div>';
			moreDetailSection += '<div class="fw-semibold text-gray-800 text-break">' + (equip.display || '-') + '</div></div>';
			
			moreDetailSection += '</div></div>';
		}
		
		let cardHTML = '';
		cardHTML += '<div class="card-header border-0 pt-6">';
		cardHTML += '<div class="card-title d-flex justify-content-between align-items-center w-100">';
		cardHTML += '<span class="fw-bold fs-4 me-2">Equipment Detail</span></div></div>';
		
		cardHTML += '<div class="card-body pt-0">';
		cardHTML += '<div class="mb-4 d-flex flex-column align-items-start">';
		cardHTML += '<div class="mb-3 d-flex justify-content-between align-items-center w-100">';
		cardHTML += '<span class="fw-bold fs-1 text-primary">' + (equip.itemNo || '-') + '</span>';
		cardHTML += '<span>' + statusBadge + '</span></div>';
		cardHTML += imageHTML + '</div>';
		cardHTML += detailRows + moreDetailSection + '</div>';
		
		$('#equipment-detail-card').html(cardHTML);
	}

	// ===== Setup Collapse Toggle =====
	function setupCollapseToggle() {
		document.addEventListener('click', function(e) {
			const btn = e.target.closest('[data-collapse-target]');
			if (!btn) return;

			e.preventDefault();
			e.stopPropagation();
			if (typeof e.stopImmediatePropagation === 'function') {
				e.stopImmediatePropagation();
			}

			const sel = btn.getAttribute('data-collapse-target');
			const target = document.querySelector(sel);
			if (!target) {
				console.warn('[CollapseFix] target not found:', sel);
				return;
			}

			const inst = bootstrap.Collapse.getOrCreateInstance(target, { toggle: false });
			const isOpen = target.classList.contains('show');
			
			if (isOpen) {
				inst.hide();
			} else {
				inst.show();
			}

			btn.setAttribute('aria-expanded', String(!isOpen));
			const iconId = 'icon_' + target.id.replace('moreDetailCollapse_', '');
			const icon = document.getElementById(iconId);
			if (icon) {
				icon.classList.toggle('rotate-180', !isOpen);
			}
		}, true);
	}

	// ===== Setup Modal Handlers =====
	function setupModalHandlers() {
		const bdModalEl = document.getElementById('borrowDetailModal');
		const bdModalObj = bdModalEl ? bootstrap.Modal.getOrCreateInstance(bdModalEl) : null;
		
		const bdCollapseEl = document.getElementById('bd_moreDetailCollapse');
		const bdCollapseObj = bdCollapseEl ? bootstrap.Collapse.getOrCreateInstance(bdCollapseEl, { toggle: false }) : null;

		$(document).on('click', '#bd_moreDetailToggle', function(e) {
			e.preventDefault();
			e.stopPropagation();
			if (typeof e.stopImmediatePropagation === 'function') {
				e.stopImmediatePropagation();
			}
			if (bdCollapseObj) {
				bdCollapseObj.toggle();
			}
		});

		if (bdCollapseEl) {
			bdCollapseEl.addEventListener('shown.bs.collapse', function() {
				$('#bd_moreDetailToggle').attr('aria-expanded', 'true');
				$('#bd_moreDetailIcon').addClass('rotate-180');
			});
			
			bdCollapseEl.addEventListener('hidden.bs.collapse', function() {
				$('#bd_moreDetailToggle').attr('aria-expanded', 'false');
				$('#bd_moreDetailIcon').removeClass('rotate-180');
			});
		}

		$(document).on('click', '.btn-open-return-modal', function(e) {
			e.preventDefault();
			openBorrowDetailModal();
		});

		$('#bd_request_return').on('click', function(e) {
			e.preventDefault();
			handleReturnRequest();
		});

		$('#borrowDetailModal').on('click', '[data-bs-dismiss="modal"]', function(e) {
			e.preventDefault();
			e.stopPropagation();
			if (bdModalObj) {
				bdModalObj.hide();
			}
		});
	}

	// ===== Open Borrow Detail Modal =====
	function openBorrowDetailModal() {
		const bdModalEl = document.getElementById('borrowDetailModal');
		const bdModalObj = bdModalEl ? bootstrap.Modal.getOrCreateInstance(bdModalEl) : null;
		
		if (!bdModalObj) {
			alert('Modal #borrowDetailModal not found');
			return;
		}

		const borrowId = borrowWithUserList.length > 0 ? borrowWithUserList[0].borrow_id : '';
		const equip = currentEquipment;

		if (!borrowId) {
			alert('Borrow ID not found.');
			return;
		}

		$('#borrowDetailModal').data('borrowId', String(borrowId).trim());

		$('#bd_item_link').text('ID: ' + (equip.itemNo || '-'));
		setText('bd_name', equip.name);
		setText('bd_serial', equip.serialNo);
		setText('bd_detail', equip.detail);
		setText('bd_amount', equip.amount || '1');
		setText('bd_purchase_date', equip.purchaseFmt || '-');
		setBadge('B');

		const t = String(equip.type || '').toLowerCase();
		if (t === 'c') {
			$('#bd_moreDetailWrapper').show();
			setText('bd_windows', equip.windows);
			setText('bd_ram', equip.ram);
			setText('bd_storage', equip.hdd);
			setText('bd_storage2', equip.hdd);
			setText('bd_wifi', equip.wifiaddress);
			setText('bd_lan', equip.lanaddress);
			setText('bd_display', equip.display);
			setText('bd_cpu', equip.process);
			setText('bd_battery', equip.battery);
		} else {
			$('#bd_moreDetailWrapper').hide();
		}

		$('#bd_approver_note').val('');

		const bdCollapseEl = document.getElementById('bd_moreDetailCollapse');
		const bdCollapseObj = bdCollapseEl ? bootstrap.Collapse.getOrCreateInstance(bdCollapseEl, { toggle: false }) : null;
		
		if (bdCollapseObj) {
			bdCollapseObj.hide();
		}
		$('#bd_moreDetailToggle').attr('aria-expanded', 'false');
		$('#bd_moreDetailIcon').removeClass('rotate-180');

		bdModalObj.show();
	}

	// ===== Handle Return Request =====
	function handleReturnRequest() {
		const borrowId = ($('#borrowDetailModal').data('borrowId') || '').toString().trim();
		const note = $('#bd_approver_note').val();

		if (!borrowId) {
			alert('Borrow ID not found.');
			return;
		}

		if (!confirm('Are you sure you want to request return for this item?')) {
			return;
		}

		$.ajax({
			url: CTX + "/eBorrowReturn.action",
			type: "POST",
			dataType: "json",
			data: {
				id: borrowId,
				note: note
			},
			success: function(data) {
				if (data && String(data.message).toLowerCase() === "success") {
					alert("Return request submitted successfully!");
					
					const bdModalEl = document.getElementById('borrowDetailModal');
					const bdModalObj = bdModalEl ? bootstrap.Modal.getOrCreateInstance(bdModalEl) : null;
					
					if (bdModalObj) {
						bdModalObj.hide();
					}

					window.location.replace(CTX + "/borrow_list");
				} else {
					alert("Something went wrong: " + (data ? data.message : "no data"));
				}
			},
			error: function(xhr) {
				console.log("HTTP", xhr.status);
				console.log("RAW", xhr.responseText);
				alert("Failed to submit return request.");
			}
		});
	}
	</script>

</body>
</html>