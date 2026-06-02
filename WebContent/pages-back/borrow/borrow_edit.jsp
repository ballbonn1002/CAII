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

a.btn-open-return-modal{
	color: inherit;
	text-decoration: underline;
    cursor: pointer;
    transition: 0.2s;
}
a.btn-open-return-modal:hover{
	color: #17C653;
	text-decoration: underline !important;
}

</style>

</head>
<body>
	<input type="hidden" id="hasSignature" value="${hasSignature}" />
	<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
		<div class="d-flex flex-column flex-column-fluid">

			<!-- Toolbar -->
			<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
				<div id="kt_app_toolbar_container" class="app-container container-fluid d-flex align-items-center justify-content-between">
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
			<c:if test="${not empty borrowlistwithUser}">
				<c:choose>
				   
				            <c:when test="${borrowObj.status == 'B'
				                            and empty borrowObj.user_delivery 
				                            and empty borrowObj.user_receive
				                            and empty borrowObj.user_return
				                            and empty borrowObj.user_return_receive}">
				                <div class="d-flex align-items-center gap-2">
				                    <button type="button" class="btn btn-primary" id="btnDeliverEquipment">
				                        Deliver Equipment
				                    </button>
				                </div>
				            </c:when>
				            
				            <c:when test="${borrowObj.status == 'B'
				                            and not empty borrowObj.user_delivery 
				                            and empty borrowObj.user_receive
				                            and empty borrowObj.user_return
				                            and empty borrowObj.user_return_receive}">
				                <div class="d-flex align-items-center gap-2">
				                    <button type="button" class="btn btn-secondary" disabled>
				                        Waiting to Receive
				                    </button>
				                </div>
				            </c:when>
				            
				            <c:when test="${borrowObj.status == 'B'
				                            and not empty borrowObj.user_delivery 
				                            and not empty borrowObj.user_receive
				                            and empty borrowObj.user_return
				                            and empty borrowObj.user_return_receive}">
				                <div class="d-flex align-items-center gap-2">
				                    <button type="button" class="btn btn-warning btn-request-return">
				                        Request for Return
				                    </button>
				                </div>
				            </c:when>
				            
				            <c:when test="${borrowObj.status == 'T'
				                             and not empty borrowObj.user_delivery 
				                             and not empty borrowObj.user_receive 
				                             and empty borrowObj.user_return
				                             and empty borrowObj.user_return_receive}">
				                <div class="d-flex align-items-center gap-2">
				                    <a class="me-3 fs-6 btn-open-return-modal">
				                        Confirm Received
				                    </a>
				                    <button type="button" class="btn btn-secondary" disabled>
				                        Waiting for Return
				                    </button>
				                </div>
				            </c:when>
				            
				            <c:when test="${borrowObj.status == 'T'
				                             and not empty borrowObj.user_delivery 
				                             and not empty borrowObj.user_receive 
				                             and not empty borrowObj.user_return
				                             and empty borrowObj.user_return_receive}">
				                <div class="d-flex align-items-center gap-2">
				                    <button type="button" class="btn btn-success btn-open-return-modal">
				                        Confirm Received
				                    </button>
				                </div>
				            </c:when>
				       </c:choose>
				   
				</c:if>
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
								<div class="card-header py-4" style="border-bottom: 1px solid #E4E6EF;">
									<h3 class="card-title fw-bold mb-0">Borrow Equipment</h3>
								</div>

								<div class="card-body pt-6">

									<!-- Borrower -->
									<div class="mb-7">
										<label class="form-label required fw-medium">Borrower</label>
										<select name="user_display" id="borrower-select" class="form-select form-select fw-medium text-muted" data-control="select2" data-placeholder="Select Borrower" disabled>
										</select>
										<input type="hidden" name="user" id="user-hidden" />
									</div>

									<!-- Status -->
									<div class="mb-7">
										<label class="required fw-semibold fs-6 mb-2 d-block">Status</label>
										<select name="status" id="status-select" class="form-select form-select" data-control="select2" data-placeholder="Select Status" data-hide-search="true" required>
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
										
											
											<c:if test="${borrowObj.status == 'B'
														 and not empty borrowObj.user_delivery 
														 and not empty borrowObj.user_receive }">
												<button type="button" class="btn btn-sm btn-warning btn-request-return">
													Request for Return
												</button>
											</c:if>
											
											<c:if test="${borrowObj.status == 'T'
														 and not empty borrowObj.user_delivery 
														 and not empty borrowObj.user_receive 
														 and not empty borrowObj.user_return
														 and empty borrowObj.user_return_receive}">
												<button type="button" class="btn btn-sm btn-success btn-open-return-modal">
													Confirm Received
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
																			
																			<c:when test="${not empty borrow.time_return}">
																				<fmt:setLocale value="en_US" />
																				<fmt:formatDate value="${borrow.time_return}" pattern="d MMMM yyyy, HH:mm" />
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
						<textarea id="bd_approver_note" class="form-control form-control" rows="4" placeholder="Enter maintenance or repair notes..."></textarea>
					</div>
				</div>

				<div class="modal-footer border-0 pt-0 pb-6 px-6 d-flex justify-content-end gap-3">
					<button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
					<button type="button" class="btn btn-success" id=bd_confirm_received>Confirm Received</button>
				</div>
			</div>
		</div>
	</div>

	<!-- ===== JavaScript ===== -->
	<script>
	// ===== Global Variables =====
	var userList = ${userList != null ? userList : '[]'};
	var equipments = ${equipments != null ? equipments : '[]'};
	var borrowData = ${borrow != null ? borrow : '{}'};
	var statusList = ${status != null ? status : '[]'};
	var borrowWithUserList = ${borrowlistwithUserJSON != null ? borrowlistwithUserJSON : '[]'};
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

	// ===== Helper Functions =====
	function getBorrowField(field) {
		return borrowData[field] || borrowData[field.replace(/([A-Z])/g, '_$1').toLowerCase()] || '';
	}

	function setText(id, val) {
		var el = document.getElementById(id);
		if (!el) return;
		el.textContent = (val !== undefined && val !== null && String(val).trim() !== "") ? val : "-";
	}

	function formatNumber(num) {
		if (!num) return '1';
		var n = Number(num);
		return isNaN(n) ? '1' : Math.floor(n).toString();
	}

	// Equipment Status Badge
	function getStatusBadge(status) {
		var badges = {
			'B': 'bg-primary text-white">Borrowing',
			'A': 'bg-success text-white">Available',
			'C': 'bg-danger text-white">Corrupted',
			'F': 'bg-info text-white">Fixed',
			'L': 'bg-dark text-white">Lost',
			'S': 'bg-warning text-dark">Sold Out',
			'W': 'bg-warning text-dark">Wait for approve',
			'Z': 'bg-secondary text-white">Disabled',
			'T': 'bg-warning text-white">Waiting for Return',
		};
		var badge = badges[status] || 'bg-light text-gray-700">-';
		return '<span class="badge badge-lg px-4 fw-semibold ' + badge + '</span>';
	}

	// Equipment Type Info
	function getTypeInfo(type) {
		var types = {
			'c': { label: 'Computer', icon: 'ki-laptop' },
			'in': { label: 'Instrument', icon: 'ki-keyboard' },
			'L': { label: 'Software License', icon: 'ki-verify' },
			'sl': { label: 'Software License', icon: 'ki-verify' },
			'Mob': { label: 'Mobile', icon: 'ki-phone' },
			'p': { label: 'Pocket Wifi', icon: 'ki-wifi-square' }
		};
		return types[type] || { label: 'Other', icon: 'ki-dots-square' };
	}

	// Create Detail Row
	function createDetailRow(label, value) {
		return '<div class="d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200">' +
			'<div class="text-gray-500" style="min-width: 130px;">' + label + '</div>' +
			'<div class="fw-normal fs-6 text-gray-800 text-break">' + (value || '-') + '</div></div>';
	}

	// ===== Initialize Page =====
	$(document).ready(function() {
		initializeBorrowerSelect();
		initializeStatusSelect();
		initializeEquipmentSelect();
		setFormValues();
		initializeDatePickers();
		renderEquipmentCard();
		setupEventHandlers();
	});
	
	function checkSignatureBeforeAction() {
		/* const hasSignature = $('#hasSignature').val() === 'true'; */
	     const rawVal = $('#hasSignature').val();
    // รองรับทั้ง "true", "True", "TRUE"
    const hasSignature = String(rawVal).toLowerCase() === 'true';
    
    console.log("hasSignature raw:", rawVal); // debug
    console.log("hasSignature bool:", hasSignature);
    
	    if (!hasSignature) {
	        Swal.fire({
	            title: "Signature Required!",
	            text: "Please upload your signature before continuing.",
	            icon: "warning",
	            confirmButtonText: "Go to My Profile",
	            showCancelButton: true,
	            cancelButtonText: "Cancel",
	            buttonsStyling: false,
	            customClass: {
	                confirmButton: "btn btn-warning",
	                cancelButton: "btn btn-secondary"
	            }
	        }).then((result) => {
	            if (result.isConfirmed) {
	            	window.open(CTX + "/my_profile", "_blank");
	            }
	        });
	        return false;
	    }
	    return true;
	}

	// ===== 1. Initialize Borrower Select =====
	function initializeBorrowerSelect() {
	    var $select = $('#borrower-select');
	    var borrowerId = getBorrowField('userBorrowid') || getBorrowField('user_borrowid');
	    
	    $select.empty();
	    
	    userList.forEach(function(user) {
	        var uid = user.id || user.user_id || user.USER_ID || '';
	        var empId = user.employee_id || user.employeeId || user.EMPLOYEE_ID || '';
	        var nameTh = user.name || user.fullname || user.USER_NAME || '';
	        var nameEn = user.name_en || user.nameEn || user.NAME_EN || '';
	        var role = user.role_id || user.roleId || user.role || '';
	        
	        var text = (empId || '-') + '  -  ' + (nameEn || '-') + '  -  ' + (nameTh || '-') + '  -  ' + (role || '-');
	        var isSelected = String(uid).toLowerCase().trim() === String(borrowerId).toLowerCase().trim();
	        
	        $select.append(new Option(text, uid, isSelected, isSelected));
	    });
	    
	    // เพิ่ม: Set hidden input value
	    $('#user-hidden').val(borrowerId);
	    
	    if ($.fn.select2 && $select.data('control') === 'select2') {
	        $select.select2();
	    }
	}

	// ===== 2. Initialize Status Select =====
	function initializeStatusSelect() {
	    var $select = $('#status-select');
	
	    var currentStatus = getBorrowField('status') || getBorrowField('statusBorrow') || getBorrowField('status_borrow');
	
	    //แปลงเป็นพิมพ์ใหญ่ กรณี t/r/b
	    currentStatus = String(currentStatus || '').toUpperCase();
	    $select.empty();
	    $select.append('<option value="">-- Select status --</option>');
	
	    var allowedStatuses = {
	        'B': 'Borrowing',
	        'C': 'Cancel',
	        'W': 'Wait for Approve',
	        'R': 'Request for Return',
	        'T': 'Waiting for Return'
	    };
	
	    statusList.forEach(function(status) {
	        var statusId = status.statusId || status.status_id || '';
	
	        statusId = String(statusId).toUpperCase();
	        if (allowedStatuses[statusId]) {
	            var isSelected = statusId === currentStatus;
	
	            $select.append(
	                new Option(
	                    allowedStatuses[statusId],
	                    statusId,
	                    isSelected,
	                    isSelected
	                )
	            );
	        }
	    });
	
	    //กรณีไม่มีใน DB
	    Object.keys(allowedStatuses).forEach(function(key) {
	        if (!$select.find('option[value="' + key + '"]').length) {
	            var isSelected = key === currentStatus;
	            $select.append(
	                new Option(
	                    allowedStatuses[key],
	                    key,
	                    isSelected,
	                    isSelected
	                )
	            );
	        }
	    });
	
	    // refresh select2
	    $select.trigger('change');
	}
	

	// ===== 3. Initialize Equipment Select =====
	function initializeEquipmentSelect() {
		var $select = $('#equipment-select');
		var currentEquipId = getBorrowField('equipmentId') || getBorrowField('equipment_id');
		
		equipments.forEach(function(equip) {
			var equipId = equip.equipmentId || equip.equipment_id || '';
			var itemNo = equip.itemNo || equip.item_no || '';
			var name = equip.name || '';
			var text = itemNo + ' - ' + name;
			var isSelected = String(equipId) === String(currentEquipId);
			
			$select.append(new Option(text, equipId, isSelected, isSelected));
		});
		
		$('#equipment-hidden').val(currentEquipId);
	}

	// ===== 4. Set Form Values =====
	function setFormValues() {
	    $('#location-input').val(getBorrowField('location') || '');
	    $('#reason-textarea').val(getBorrowField('reason') || '');
	    $('#contact-textarea').val(getBorrowField('contactAddr') 
	        || getBorrowField('contact_addr') || '');
	    $('#remark-textarea').val(getBorrowField('remark') || '');
	}

	// ===== 5. Initialize DatePickers =====
	function initializeDatePickers() {
	    if (typeof flatpickr === "undefined") return;
	
	    function parseGsonDate(str) {
	        if (!str) return null;
	        var normalized = str.replace(" ", "T");
	        var d = new Date(normalized);
	        return isNaN(d.getTime()) ? null : d;
	    }
	
	    var dateStart = getBorrowField('dateStart') || getBorrowField('date_start');
	    var dateEnd   = getBorrowField('dateEnd')   || getBorrowField('date_end');
	
	    var parsedStart = parseGsonDate(dateStart);
	    var parsedEnd   = parseGsonDate(dateEnd);
	
	    var config = {
	        enableTime: true,
	        time_24hr: true,
	        dateFormat: "Y-m-d H:i",  
	        altInput: true,
	        altFormat: "d M Y, H:i", 
	        allowInput: false        
	    };
	
	    flatpickr("#start_date", {
	        ...config,
	        defaultDate: parsedStart
	    });
	
	    flatpickr("#end_date", {
	        ...config,
	        defaultDate: parsedEnd
	    });
	}

	function renderEquipmentCard() {
		var eq = currentEquipment;
		var typeInfo = getTypeInfo(eq.type);

		// Image
		var imageHTML = eq.image ? 
			'<img src="' + eq.image + '" alt="' + eq.itemNo + '" class="border rounded-3 object-fit-cover w-100 h-100" />' :
			'<i class="fa-solid fa-image fs-1 text-muted"></i>';

		// Basic Details
		var details = '';
		details += createDetailRow('Name', eq.name);
		details += createDetailRow('Type', typeInfo.label + ' <i class="ki-solid ' + typeInfo.icon + ' fs-1 text-gray-500"></i>');
		details += createDetailRow('Serial No', eq.serialNo);
		details += createDetailRow('Amount', formatNumber(eq.amount));
		details += createDetailRow('Date of Purchase', eq.purchaseFmt);
		details += createDetailRow('Detail', eq.detail);

		// More Details (สำหรับ Computer เท่านั้น)
		var moreDetails = '';
		if (eq.type && eq.type.toLowerCase() === 'c') {
			moreDetails = '<div>' +
				'<button type="button" class="btn btn-link p-0 w-100 text-primary fw-semibold d-flex justify-content-between align-items-center py-5 border-bottom border-gray-200" ' +
				'data-collapse-target="#moreDetailCollapse" aria-expanded="false">' +
				'<span>More Detail</span>' +
				'<i class="ki-duotone ki-down fs-3 collapse-icon"><span class="path1"></span><span class="path2"></span></i>' +
				'</button>' +
				'<div class="collapse mt-3" id="moreDetailCollapse">' +
				createDetailRow('Windows', eq.windows) +
				createDetailRow('CPU', eq.process) +
				createDetailRow('Ram', eq.ram) +
				createDetailRow('Storage', eq.hdd) +
				createDetailRow('Battery', eq.battery) +
				createDetailRow('WIFI Address', eq.wifiaddress) +
				createDetailRow('LAN Address', eq.lanaddress) +
				createDetailRow('Display', eq.display) +
				'</div></div>';
		}

		// Build Card HTML
		var cardHTML = '<div class="card-header border-0 pt-6">' +
			'<div class="card-title fw-bold fs-4">Equipment Detail</div></div>' +
			'<div class="card-body pt-0">' +
			'<div class="mb-4 d-flex flex-column align-items-start">' +
			'<div class="mb-3 d-flex justify-content-between align-items-center w-100">' +
			'<span class="fw-bold fs-1 text-primary">' + (eq.itemNo || '-') + '</span>' +
			getStatusBadge(eq.status) +
			'</div>' +
			'<div class="symbol symbol-150px border rounded-3 bg-light d-flex align-items-center justify-content-center">' +
			imageHTML + '</div>' + '</div>' + details + moreDetails + '</div>';

		$('#equipment-detail-card').html(cardHTML);
	}

	// ===== 7. Setup Event Handlers =====
	function setupEventHandlers() {
		// Collapse Toggle
		$(document).on('click', '[data-collapse-target]', function(e) {
			e.preventDefault();
			var target = document.querySelector($(this).data('collapse-target'));
			if (!target) return;

			var collapse = bootstrap.Collapse.getOrCreateInstance(target, { toggle: false });
			var isOpen = target.classList.contains('show');

			isOpen ? collapse.hide() : collapse.show();
			$(this).attr('aria-expanded', !isOpen);
			$(this).find('.collapse-icon').toggleClass('rotate-180', !isOpen);
		});

		// Modal: Open Return Modal
		$(document).on('click', '.btn-open-return-modal', function(e) {
			e.preventDefault();
			openReturnModal();
		});

		// Modal: Submit Return Request
		$('#bd_confirm_received').on('click', function(e) {
			e.preventDefault();
			submitConfirmReceived();
		});

		// Modal: Close
		$('#borrowDetailModal').on('click', '[data-bs-dismiss="modal"]', function(e) {
			e.preventDefault();
			var modal = bootstrap.Modal.getInstance(document.getElementById('borrowDetailModal'));
			if (modal) modal.hide();
		});

		// Modal Collapse
		$(document).on('click', '#bd_moreDetailToggle', function(e) {
			e.preventDefault();
			var collapseEl = document.getElementById('bd_moreDetailCollapse');
			if (!collapseEl) return;
			
			var collapse = bootstrap.Collapse.getOrCreateInstance(collapseEl, { toggle: false });
			var isOpen = collapseEl.classList.contains('show');
			isOpen ? collapse.hide() : collapse.show();
			
			$('#bd_moreDetailToggle').attr('aria-expanded', !isOpen);
			$('#bd_moreDetailIcon').toggleClass('rotate-180', !isOpen);
		});

		$('#bd_moreDetailCollapse').on('shown.bs.collapse hidden.bs.collapse', function(e) {
			var isOpen = e.type === 'shown';
			$('#bd_moreDetailToggle').attr('aria-expanded', isOpen);
			$('#bd_moreDetailIcon').toggleClass('rotate-180', isOpen);
		});

		// เพิ่ม: Handle Form Submit - ตรวจสอบว่าเลือก Return หรือไม่
		$('form[action*="eBorrowUpdate.action"]').on('submit', function(e) {
		    var selectedStatus = $('#status-select').val();

		    // ถ้าเลือก Request for Return (R)
		    if (selectedStatus === 'R') {
		        e.preventDefault(); // ยกเลิกการ submit ปกติ

		        var borrowId = '${sessionScope.bId}';
		        var remark = $('#remark-textarea').val();

		        Swal.fire({
		            title: 'Confirm Return',
		            text: 'Are you sure you want to request return for this item?',
		            icon: 'question',
		            showCancelButton: true,
		            confirmButtonText: 'Yes, request return',
		            cancelButtonText: 'Cancel',
		            buttonsStyling: false,
			        customClass: {
			            confirmButton: "btn btn-warning",
			            cancelButton: "btn btn-secondary"
			        }
		        }).then((result) => {
		            if (result.isConfirmed) {
		                // ส่งไปที่ eBorrowReturn.action แทน
		                $.ajax({
		                    url: CTX + "/eBorrowReturn.action",
		                    type: "POST",
		                    dataType: "json",
		                    data: {
		                        id: borrowId
		                    },
		                    success: function(data) {
		                        if (data && String(data.message).toLowerCase() === "success") {
		                            Swal.fire('Success!', 'Return request submitted successfully!', 'success').then(() => {
		                                window.location.replace(CTX + "/borrow_list");
		                            });
		                        } else {
		                            Swal.fire('Error!', "Something went wrong: " + (data ? data.message : "no data"), 'error');
		                        }
		                    },
		                    error: function(xhr) {
		                        console.error("HTTP", xhr.status, xhr.responseText);
		                        Swal.fire('Error!', 'Failed to submit return request.', 'error');
		                    }
		                });
		            }
		        });

		        return false;
		    }

		    // ถ้าเลือก status อื่นๆ ให้ submit ตามปกติ
		    return true;
		});
		
		// ----- Deliver Equipment -----
		$('#btnDeliverEquipment').on('click',function(e){
			e.preventDefault();
			if (!checkSignatureBeforeAction()) {
				return;
			}
			Swal.fire({
		        title: "Confirm Deliver Equipment?!",
		        text: "Do you want to deliver this equipment?",
		        icon: "question",
		        showCancelButton: true,
		        confirmButtonText: "Yes, deliver it",
		        cancelButtonText: "Cancel",
		        buttonsStyling: false,
		        customClass: {
		            confirmButton: "btn btn-success",
		            cancelButton: "btn btn-secondary"
		        }
		    }).then((result) => {
		        if (result.isConfirmed) {
		        	fetch(CTX + "deliver_equipment.action", {
		        	    method: "POST",
		        	    headers: {
		        	        "Content-Type": "application/x-www-form-urlencoded"
		        	    },
		        	    body: "id=" + encodeURIComponent(
		        	        getBorrowField('borrowId') || getBorrowField('borrow_id')
		        	    )
		        	})
		        	.then(response => response.text())
		        	.then(data => {
		        	    location.reload();
		        	})
		        	.catch(error => {
		        	    console.error(error);

		        	    Swal.fire({
		        	        icon: "error",
		        	        title: "Error",
		        	        text: "Failed to deliver equipment"
		        	    });

		        	});
		        }
		    });
		})
		
		// ----- Request for Return -----
		$('.btn-request-return').on('click', function (e) {
		    e.preventDefault();
		
		    Swal.fire({
		        title: 'Confirm Request for Return?',
		        text: 'Are you sure you want to request return for this item?',
		        icon: 'question',
		        showCancelButton: true,
		        confirmButtonText: 'Yes, request return',
		        cancelButtonText: "Cancel",
		        buttonsStyling: false,
		        customClass: {
		            confirmButton: "btn btn-warning",
		            cancelButton: "btn btn-secondary"
		        }
		    }).then((result) => {
		        if (result.isConfirmed) {
		            fetch(CTX + "/request_return.action", {
		                method: "POST",
		                headers: {
		                    "Content-Type": "application/x-www-form-urlencoded"
		                },
		                body: "id=" + encodeURIComponent(getBorrowField('borrowId'))
		            })
		            .then(res => res.json())
		            .then(data => {
		                if (data.message === "success") {
		                	location.reload();
		                } else {
		                    Swal.fire("Error", data.message, "error");
		                }
		            })
		            .catch(err => {
		                console.error(err);
		                Swal.fire("Error", "Request failed", "error");
		            });
		        }
		    });
		});
		
	}

	// ===== Open Return Modal =====
	function openReturnModal() {
		var modal = bootstrap.Modal.getOrCreateInstance(document.getElementById('borrowDetailModal'));
		if (!modal) {
			alert('Modal not found');
			return;
		}

		var borrowId = borrowWithUserList.length > 0 ? borrowWithUserList[0].borrow_id : '';
		if (!borrowId) {
			alert('Borrow ID not found.');
			return;
		}

		var eq = currentEquipment;

		// Set modal data
		$('#borrowDetailModal').data('borrowId', String(borrowId).trim());
		$('#bd_item_link').text('ID: ' + (eq.itemNo || '-'));
		setText('bd_name', eq.name);
		setText('bd_serial', eq.serialNo);
		setText('bd_detail', eq.detail);
		setText('bd_amount', eq.amount || '1');
		setText('bd_purchase_date', eq.purchaseFmt || '-');

		// Status Badge
		var $badge = $('#bd_status_badge');
	/* 	$badge.removeClass().addClass('badge badge-lg rounded-pill px-4 fw-semibold bg-warning text-white').text('Borrowing'); */
		$badge.removeClass().addClass('badge badge-lg rounded-pill px-4 fw-semibold bg-warning text-white').text('Waiting for Return');

		// More Details (Computer only)
		var isComputer = String(eq.type || '').toLowerCase() === 'c';
		$('#bd_moreDetailWrapper').toggle(isComputer);

		if (isComputer) {
			setText('bd_windows', eq.windows);
			setText('bd_ram', eq.ram);
			setText('bd_storage', eq.hdd);
			setText('bd_storage2', eq.hdd);
			setText('bd_wifi', eq.wifiaddress);
			setText('bd_lan', eq.lanaddress);
			setText('bd_display', eq.display);
			setText('bd_cpu', eq.process);
			setText('bd_battery', eq.battery);
		}

		// Reset
		$('#bd_approver_note').val('');
		var collapse = bootstrap.Collapse.getInstance(document.getElementById('bd_moreDetailCollapse'));
		if (collapse) collapse.hide();
		$('#bd_moreDetailToggle').attr('aria-expanded', 'false');
		$('#bd_moreDetailIcon').removeClass('rotate-180');

		modal.show();
	}

	// ===== Submit Return Request =====
	function submitConfirmReceived() {
	    var borrowId = ($('#borrowDetailModal').data('borrowId') || '').toString().trim();
	    var note = $('#bd_approver_note').val();
	
	    if (!borrowId) {
	        Swal.fire('Error!', 'Borrow ID not found.', 'error');
	        return;
	    }
	    
	    if (!checkSignatureBeforeAction()) {
	        var modal = bootstrap.Modal.getInstance( document.getElementById('borrowDetailModal') );
	        if (modal) modal.hide();
	        return;
	    }
	
	    Swal.fire({
	    	title: "Confirm Received?",
	        text: "Have you return received this equipment?",
	        icon: "question",
	        showCancelButton: true,
	        confirmButtonText: "Yes, received it",
	        cancelButtonText: 'Cancel',
	        buttonsStyling: false,
	        customClass: {
	            confirmButton: "btn btn-warning",
	            cancelButton: "btn btn-secondary"
	        }
	    }).then((result) => {
	        if (result.isConfirmed) {
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
	                        Swal.fire('Success!', 'Return request submitted successfully!', 'success').then(() => {
	                            var modal = bootstrap.Modal.getInstance(document.getElementById('borrowDetailModal'));
	                            if (modal) modal.hide();
	                            window.open(CTX + "/borrowReport?borrowId=" + borrowId,"_blank");
	                            window.location.href = CTX + "/borrow_list";
	                        });
	                    } else {
	                        Swal.fire('Error!', "Something went wrong: " + (data ? data.message : "no data"), 'error');
	                    }
	                },
	                error: function(xhr) {
	                    console.error("HTTP", xhr.status, xhr.responseText);
	                    Swal.fire('Error!', 'Failed to submit return request.', 'error');
	                }
	            });
	        }
	    });
	}
	
	</script>
	
</body>
</html>