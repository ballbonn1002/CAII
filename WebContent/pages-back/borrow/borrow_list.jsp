<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<fmt:setLocale value="en_US" />

<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />

<link href="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.js"></script>

<link href="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.js"></script>

<style>
/* Light Mode */
[data-bs-theme="light"] #kt_table.table.table-striped>tbody>tr:nth-of-type(odd)>* {
	background-color: #FBFBFB !important;
	box-shadow: none !important;
}

[data-bs-theme="light"] #kt_table.table-hover tbody tr:hover>*, 
[data-bs-theme="light"] #kt_table.table-hover tbody tr:hover>td,
[data-bs-theme="light"] #kt_table.table-hover tbody tr:hover>th, 
[data-bs-theme="light"] #kt_table.table.table-hover>tbody>tr:hover>*,
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
[data-bs-theme="dark"] #kt_table.table-hover tbody tr:hover>td,
[data-bs-theme="dark"] #kt_table.table-hover tbody tr:hover>th, 
[data-bs-theme="dark"] #kt_table.table.table-hover>tbody>tr:hover>*,
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

.select2-selection--multiple {
	min-height: 38px !important;
}

.select2-selection__choice {
	background-color: #e7e9ed !important;
	border: none !important;
	border-radius: 4px !important;
	padding: 4px 8px !important;
	color: #6c757d !important;
}

.select2-selection__choice__remove {
	color: #6c757d !important;
	margin-right: 5px !important;
}

.select2-results__option {
	padding: 8px 12px !important;
}

.select2-results__option input[type="checkbox"] {
	cursor: pointer;
}

.type-select-buttons {
	position: sticky;
	bottom: 0;
	z-index: 1000;
}

.select2-container--default .select2-results__option--highlighted {
	background-color: #f8f9fa !important;
	color: inherit !important;
}

.select2-results__options {
	max-height: 250px !important;
}

.type-select-buttons .btn {
	font-size: 14px;
	padding: 8px 16px;
}

th.sort {
	cursor: pointer;
	user-select: none;
}

th.sort:hover {
	background-color: rgba(0, 0, 0, 0.02);
}

.sort-arrow {
	display: inline-block;
	margin-left: 5px;
	font-size: 10px;
	color: #6c757d;
	vertical-align: middle;
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
				<div id="kt_app_toolbar_container" class="app-container container-fluid d-flex align-items-center justify-content-start">
					<div class="page-title d-flex flex-column flex-wrap me-3 align-items-start">
						<h1 class="page-heading fw-semibold my-0 text-start" style="color: #4b5675;">Borrow List</h1>
						<ul class="breadcrumb breadcrumb-separatorless fw-medium fs-7 my-0 pt-1">
							<li class="breadcrumb-item text-muted">
								<a href="${pageContext.request.contextPath}/demo_dashboard" class="text-muted text-hover-primary">Home</a>
							</li>
							<li class="breadcrumb-item"><span class="bullet bg-gray-500 w-4px h-1px"></span></li>
							<li class="breadcrumb-item text-muted">Borrow</li>
						</ul>
					</div>
				</div>
			</div>
			<!--end::Toolbar-->

			<!--begin::Content-->
			<div id="kt_app_content" class="app-content flex-column-fluid">
				<!--begin::Content container-->
				<div id="kt_app_content_container" class="app-container container-fluid">
					<div class="d-flex flex-row">
						<div class="flex-row-fluid mb-5">

							<!-- 🔍 Search form -->
							<form action="new_search_borrow" method="POST" id="searchForm">
								<div class="card card-flush bgi-no-repeat bgi-size-contain bgi-position-x-center border-0 mb-5 mb-xl-10">
									<div class="card-body py-5 px-6">
										<div class="row g-5 align-items-end">

											<!-- Search -->
											<div class="col-md-5">
												<div class="d-flex align-items-center border border-gray-300 rounded-3 px-4 py-2 gap-3 h-55px bg-body">
													<i class="ki-duotone ki-magnifier fs-4 text-gray-500">
														<span class="path1"></span> <span class="path2"></span>
													</i>
													<input type="text" name="keyword" class="form-control border-0 bg-transparent ps-0" placeholder="Search" />
												</div>
											</div>

											<!-- Status -->
											<div class="col-md-3">
												<label class="select-default">Status:</label> 
												<select name="status" class="form-select form-select-solid border border-gray-300 rounded-3 px-4 py-2 gap-3 h-55px bg-body">
													<option value="">All Status</option>
													<option value="B">Borrowed</option>
													<option value="W">Wait for Approve</option>
												</select>
											</div>

											<!-- Type -->
											<div class="col-md-3">
												<label class="select-default">Type:</label> 
												<select id="typeFilter" name="type" class="form-select form-select-solid text-muted border border-gray-300 rounded-3 px-4 py-2 gap-3 h-55px bg-body" multiple data-control="select2" data-placeholder="Select">
													<option value="c">Computer</option>
													<option value="in">Instrument</option>
													<option value="l">Software License</option>
													<option value="mob">Mobile</option>
													<option value="other">Other</option>
													<option value="p">Pocket WIFI</option>
												</select>
											</div>
										</div>
									</div>
								</div>
							</form>

							<!-- items -->
							<div class="d-flex align-items-center justify-content-between mt-8 mb-6">
								<div class="d-flex align-items-baseline gap-1">
									<h3 class="page-heading text-gray-900 fw-bold mb-0 d-flex align-items-baseline flex-nowrap">
										<span id="itemsFound" class="me-2">0 Items Found</span> 
										<span class="fs-6 fw-semibold text-gray-500 d-inline-flex align-items-center text-nowrap">by Recent Updates ↓</span>
									</h3>
								</div>

								<div>
									<a href="${pageContext.request.contextPath}/borrow_add" data-route="borrow_add" class="btn btn-success d-inline-flex align-items-center py-3 px-6 gap-2">
										<i class="ki-duotone ki-plus fs-5"> 
											<span class="path1"></span>
											<span class="path2"></span>
										</i> 
										<span class="fw-bold">Create</span>
									</a>
								</div>
							</div>

							<!-- Type Box -->
							<div class="card">
								<div class="card-border-radius">
									<div class="card-body">
										<!-- Type Box (อยู่ในกล่องเดียวกัน) -->
										<div class="border border-dashed border-gray-400 rounded-3 px-7 py-6 mb-8 bg-transparent">
											<div class="d-flex flex-column">
												<!-- หัวข้อ -->
												<div class="fs-4 text-gray-800 fw-bold mb-4">Type</div>

												<!-- รายการ Type -->
												<div class="d-flex flex-wrap align-items-center gap-9">
													<div class="d-flex align-items-center gap-4">
														<i class="ki-duotone ki-laptop fs-4 text-gray-600"> 
															<span class="path1"></span><span class="path2"></span>
														</i> 
														<span class="text-gray-800">Computer</span>
													</div>

													<div class="d-flex align-items-center gap-4">
														<i class="ki-duotone ki-keyboard fs-4 text-gray-600">
															<span class="path1"></span><span class="path2"></span>
														</i> 
														<span class="text-gray-800">Instrument</span>
													</div>

													<div class="d-flex align-items-center gap-4">
														<i class="ki-duotone ki-verify fs-4 text-gray-600"> 
															<span class="path1"></span><span class="path2"></span>
														</i> 
														<span class="text-gray-800">Software License</span>
													</div>

													<div class="d-flex align-items-center gap-4">
														<i class="ki-duotone ki-phone fs-4 text-gray-600"> 
															<span class="path1"></span><span class="path2"></span>
														</i> 
														<span class="text-gray-800">Mobile</span>
													</div>

													<div class="d-flex align-items-center gap-4">
														<i class="ki-duotone ki-dots-square fs-4 text-gray-600">
															<span class="path1"></span><span class="path2"></span> 
															<span class="path3"></span><span class="path4"></span>
														</i> 
														<span class="text-gray-800">Other</span>
													</div>

													<div class="d-flex align-items-center gap-4">
														<i class="ki-duotone ki-wifi-square fs-4 text-gray-600">
															<span class="path1"></span><span class="path2"></span> 
															<span class="path3"></span><span class="path4"></span>
														</i> 
														<span class="text-gray-800">Pocket WIFI</span>
													</div>
												</div>
											</div>
										</div>

										<!-- ตาราง Borrow -->
										<div class="table-responsive">
											<table id="borrow_table" class="table align-middle fs-6 mb-0 ca-eq-table">
												<thead class="fs-7 text-gray-500 text-uppercase">
													<tr class="fw-semibold">
														<th class="min-w-60px sort" data-sort="number">ID</th>
														<th class="min-w-120px sort" data-sort="text">ITEM NO</th>
														<th class="min-w-90px text-center sort" data-sort="type">TYPE</th>
														<th class="min-w-350px sort" data-sort="text">EQUIPMENT / DETAIL</th>
														<th class="min-w-250px sort" data-sort="text">LOCATION</th>
														<th class="min-w-250px sort" data-sort="status">STATUS</th>
														<th class="min-w-200px text-end">ACTIONS</th>
													</tr>
												</thead>

												<tbody id="borrowTableBody" class="text-gray-700">
													<!-- จะถูก render ด้วย JavaScript -->
												</tbody>
											</table>
										</div>
									</div>
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

	<!-- Modal: Equipment Detail -->
	<div class="modal fade" id="borrowModal" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-lg">
			<div class="modal-content">
				<!-- Header -->
				<div class="modal-header border-0 px-6 pt-5 pb-0 align-items-center">
					<h2 class="modal-title fw-bold mb-0">Equipment Detail</h2>
					<button type="button" class="btn btn-icon btn-sm btn-light btn-active-light-primary" data-bs-dismiss="modal">
						<i class="ki-duotone ki-cross fs-2"> 
							<span class="path1"></span><span class="path2"></span>
						</i>
					</button>
				</div>

				<!-- Body -->
				<div class="modal-body scroll-y px-5 px-xl-10 py-7">
					<div class="row mb-6">
						<div class="col-md-6 pe-md-6">
							<div class="d-flex align-items-center gap-5 mb-3 pb-4">
								<a href="javascript:void(0);" id="m_item_link" class="fw-bold fs-5 text-primary"></a> 
								<span id="m_status_badge" class="badge badge-lg rounded-pill px-4 fw-semibold"></span>
							</div>

							<div class="d-flex flex-column fs-7 text-gray-700">
								<div class="pb-4">
									<span class="fw-normal fs-5 text-gray-700 me-2">Serial No:</span> 
									<span id="m_serial" class="fw-normal fs-5 text-gray-800 text-break"></span>
								</div>
								<div>
									<span class="fw-normal fs-5 text-gray-700 me-2">Detail:</span>
									<span id="m_detail_top" class="fw-normal fs-5 text-gray-800 text-break"></span>
								</div>
							</div>
						</div>

						<div class="col-md-6 ps-md-10 mt-5 mt-md-0">
							<div class="d-flex align-items-center mb-1 pb-4">
								<i class="ki-duotone ki-laptop fs-2x text-gray-600 me-3" id="m_type_icon"> 
									<span class="path1"></span><span class="path2"></span>
								</i> 
								<span class="fw-bold fs-5 text-gray-800 text-break" id="m_name"></span>
							</div>

							<div class="fs-5 text-gray-700 fw-normal mt-1 pb-4 me-4">
								Amount: <span id="m_amount" class="fw-semibold text-gray-800"></span>
							</div>

							<div class="fs-5 text-gray-700 fw-normal mt-1 pb-4 me-4">
								Date of Purchase: <span id="m_purchase_date" class="fw-normal text-gray-800 text-break"></span>
							</div>
						</div>
					</div>

					<!-- More Detail -->
					<div id="moreDetailWrapper" class="mt-2">
						<a href="#" id="moreDetailToggle" class="fw-medium fs-5 pb-4 text-primary d-inline-flex align-items-center" role="button" aria-controls="moreDetailCollapse" aria-expanded="false"> 
							More Detail 
							<i id="moreDetailIcon" class="ki-duotone ki-down fs-4 ms-4"> 
								<span class="path1"></span><span class="path2"></span>
							</i>
						</a>

						<div class="collapse mt-3" id="moreDetailCollapse">
							<div class="row fs-7 text-gray-700">
								<div class="col-md-6 pe-md-10">
									<div class="mb-3 pb-4">
										<span class="fw-normal fs-5 text-gray-700 me-3">Windows</span>
										<span id="m_windows" class="ms-1 fw-normal fs-5 text-gray-800 text-break"></span>
									</div>
									<div class="mb-3 pb-4">
										<span class="fw-normal fs-5 text-gray-700 me-3">RAM</span> 
										<span id="m_ram" class="ms-1 fw-normal fs-5 text-gray-800 text-break"></span>
									</div>
									<div class="mb-3 pb-4">
										<span class="fw-normal fs-5 text-gray-700 me-3">Storage</span>
										<span id="m_hdd" class="ms-1 fw-normal fs-5 text-gray-800 text-break"></span>
									</div>
									<div class="mb-3 pb-4">
										<span class="fw-normal fs-5 text-gray-700 me-3">WIFI Address</span> 
										<span id="m_wifi" class="ms-1 fw-normal fs-5 text-gray-800 text-break"></span>
									</div>
									<div class="mb-3 pb-4">
										<span class="fw-normal fs-5 text-gray-700 me-3">Display</span>
										<span id="m_display" class="ms-1 fw-normal fs-5 text-gray-800 text-break"></span>
									</div>
								</div>

								<div class="col-md-6 ps-md-10">
									<div class="mb-3 pb-4">
										<span class="fw-normal fs-5 text-gray-700 me-3">CPU</span> 
										<span id="m_process" class="ms-1 fw-normal fs-5 text-gray-800 text-break"></span>
									</div>
									<div class="mb-3 pb-4">
										<span class="fw-normal fs-5 text-gray-700 me-3">Storage</span>
										<span id="m_hddd" class="ms-1 fw-normal fs-5 text-gray-800 text-break"></span>
									</div>
									<div class="mb-3 pb-4">
										<span class="fw-normal fs-5 text-gray-700 me-3">Battery</span>
										<span id="m_battery" class="ms-1 fw-normal fs-5 text-gray-800 text-break"></span>
									</div>
									<div class="mb-3 pb-4">
										<span class="fw-normal fs-5 text-gray-700 me-3">LAN Address</span> 
										<span id="m_lan" class="ms-1 fw-normal fs-5 text-gray-800 text-break"></span>
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="separator separator-dashed my-6"></div>

					<!-- Borrow Info -->
					<div class="fs-7 text-gray-700">
						<div class="d-flex mb-3 pb-4">
							<span class="fw-bold me-4 fs-5 text-gray-700">Borrow ID</span> 
							<span id="m_borrow_id" class="fw-bold fs-5 text-primary"></span>
						</div>
						<div class="d-flex mb-3 pb-4">
							<span class="fw-normal me-4 fs-5 text-gray-700">Borrow by:</span>
							<span id="m_borrower" class="fw-medium fs-5 text-gray-800 text-break"></span>
						</div>
						<div class="d-flex mb-3 pb-4">
							<span class="fw-normal me-4 fs-5 text-gray-700">Location:</span>
							<span id="m_location" class="fw-normal fs-5 text-gray-800 text-break"></span>
						</div>
						<div class="d-flex mb-1 pb-4">
							<span class="fw-normal me-4 fs-5 text-gray-700">Borrow Date:</span> 
							<span id="m_borrow_date" class="fw-normal fs-5 text-gray-800 text-break"></span>
						</div>
					</div>
				</div>

				<!-- Footer -->
				<div class="modal-footer border-0 pt-0 pb-6 px-6 d-flex justify-content-end gap-3">
					<button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
					<button type="button" class="btn btn-primary" id="btn_edit">Edit</button>
					<button type="button" class="btn btn-warning" id="btn_request_return" style="display: none;">Request for Return</button>
					<button type="button" class="btn btn-danger" id="btn_cancel_borrow" style="display: none;">Cancel</button>
					<button type="button" class="btn btn-success" id="btn_confirm_borrow" style="display: none;">Confirm Borrow</button>
				</div>
			</div>
		</div>
	</div>

	<!-- Modal Return -->
	<div class="modal fade" id="borrowDetailModal" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-lg">
			<div class="modal-content">
				<!-- Header -->
				<div class="modal-header border-0 px-6 pt-5 pb-0 align-items-center">
					<h2 class="modal-title fw-bold mb-0">Borrow Detail</h2>
					<button type="button" class="btn btn-icon btn-sm btn-light btn-active-light-primary" data-bs-dismiss="modal">
						<i class="ki-duotone ki-cross fs-2"> 
							<span class="path1"></span><span class="path2"></span>
						</i>
					</button>
				</div>

				<!-- Body -->
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
								<i class="ki-duotone ki-laptop fs-2x text-gray-600 me-3"> 
									<span class="path1"></span><span class="path2"></span>
								</i> 
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

					<!-- More Detail -->
					<div id="bd_moreDetailWrapper" class="mt-2">
						<a href="#" id="bd_moreDetailToggle" class="fw-medium fs-5 pb-4 text-primary d-inline-flex align-items-center" role="button" aria-controls="bd_moreDetailCollapse" aria-expanded="false"> 
							More Detail 
							<i id="bd_moreDetailIcon" class="ki-duotone ki-down fs-4 ms-4"> 
								<span class="path1"></span><span class="path2"></span>
							</i>
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
										<span class="fw-normal fs-5 text-gray-700 me-3">Dispaly</span>
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

					<!-- Approver -->
					<div class="mt-10">
						<div class="text-primary fw-bold fs-5 mb-7">Approver</div>
						<div class="text-gray-800 fs-7 mb-4">Specify a note when changing status (optional)</div>
						<textarea id="bd_approver_note" class="form-control form-control" rows="4" placeholder="Enter maintenance or repair notes..."></textarea>
					</div>
				</div>

				<!-- Footer -->
				<div class="modal-footer border-0 pt-0 pb-6 px-6 d-flex justify-content-end gap-3">
					<button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
					<button type="button" class="btn btn-warning" id="bd_request_return">Request for Return</button>
				</div>
			</div>
		</div>
	</div>

	<!-- JavaScript -->
	<script>
	// ดึงข้อมูลจาก request attributes
	var equipments = ${equipments != null ? equipments : '[]'};
	var borrows = ${borrows != null ? borrows : '[]'};
	var users = ${userList != null ? userList : '[]'};
	var dbTypeList = ${type != null ? type : '[]'};

	console.log('Raw Data:', { equipments, borrows, users, dbTypeList });

	// ฟังก์ชันสร้าง Map สำหรับ Equipment
	function createEquipmentMap(equipments) {
		var equipById = {};
		equipments.forEach(function(e) {
			var idObj = e.equipment_id || e.equipmentId;
			if (!idObj) return;
			
			var key = String(idObj);
			equipById[key] = e;
		});
		return equipById;
	}

	// ฟังก์ชันสร้าง Map สำหรับ User
	function createUserMap(users) {
		var userByKey = {};
		users.forEach(function(u) {
			var uidObj = u.id || u.user_id;
			if (uidObj) {
				var k = String(uidObj).toLowerCase();
				userByKey[k] = u;
			}
			
			var loginObj = u.id || u.userBorrowid || u.name;
			if (loginObj) {
				var k = String(loginObj).toLowerCase();
				userByKey[k] = u;
			}
		});
		return userByKey;
	}

	// ฟังก์ชันประมวลผลข้อมูล Borrow
	function processBorrowData(borrows, equipById, userByKey) {
		var viewList = [];
		
		borrows.forEach(function(b) {
			var row = {};
			
			// Borrow ID
			var borrowIdObj = b.borrow_id || b.borrowId;
			var borrowIdStr = borrowIdObj ? String(borrowIdObj) : null;
			
			// Equipment ID
			var equipIdObj = b.equipment_id || b.equipmentId;
			var equipIdKey = equipIdObj ? String(equipIdObj) : null;
			
			// User Borrow ID
			var userBorrowObj = b.user_borrowid || b.userBorrowid;
			var userBorrowKey = userBorrowObj ? String(userBorrowObj).toLowerCase() : null;
			
			// Status
			var status = b.status || b.statusborrow;
			var borrowLoc = b.location;
			
			// ดึงข้อมูล Equipment
			var equip = equipIdKey ? equipById[equipIdKey] : null;
			
			// ดึงข้อมูล User
			var borrowerName = null;
			var employeeId = null;
			var borrowerNameEn = null;
			var department = null;
			var roleId = null;
			
			if (userBorrowKey) {
				var u = userByKey[userBorrowKey];
				if (u) {
					var n = u.name || u.user_name;
					borrowerName = n ? String(n) : null;
					
					if (u.employee_id) employeeId = String(u.employee_id);
					if (u.name_en) borrowerNameEn = String(u.name_en);
					if (u.department) department = String(u.department);
					if (u.role) roleId = String(u.role);
				}
			}
			
			// เติมข้อมูลพื้นฐาน
			row.borrow_id = borrowIdStr;
			row.equipment_id = equipIdKey;
			row.user_borrowid = userBorrowObj;
			row.borrower_name = borrowerName;
			row.employee_id = employeeId;
			row.name_en = borrowerNameEn;
			row.department = department;
			row.statusborrow = status;
			row.role_id = roleId;
			
			// เติมข้อมูล Equipment
			if (equip) {
				row.item_no = equip.item_no || equip.itemNo;
				row.name = equip.name;
				row.detail = equip.detail;
				row.location = b.location || borrowLoc;
				row.type = equip.type;
				row.time_create = equip.time_create || equip.timeCreate;
				row.serial_no = equip.serialNo;
				row.amount = equip.amount;
				row.ram = equip.ram;
				row.process = equip.process;
				row.battery = equip.battery;
				row.hdd = equip.hdd;
				row.windows = equip.windows;
				row.wifiaddress = equip.wifiaddress;
				row.lanaddress = equip.lanaddress;
				row.display = equip.display;
				row.date_start = b.date_start || b.dateStart;
				row.date_end = b.date_end || b.dateEnd;
			} else {
				row.item_no = null;
				row.name = null;
				row.detail = null;
				row.location = borrowLoc;
				row.type = null;
			}
			
			viewList.push(row);
		});
		
		return viewList;
	}

	// ประมวลผลข้อมูล
	var equipById = createEquipmentMap(equipments);
	var userByKey = createUserMap(users);
	var borrowList = processBorrowData(borrows, equipById, userByKey);

	console.log('Processed borrowList:', borrowList);

	// ฟังก์ชันแสดงผลตาราง
	function renderBorrowTable(data) {
		var tbody = $('#borrowTableBody');
		tbody.empty();
		
		data.forEach(function(row) {
			var tr = $('<tr>')
				.attr('data-item-no', row.item_no || '')
				.attr('data-name', row.name || '')
				.attr('data-detail', row.detail || '')
				.attr('data-location', row.location || '')
				.attr('data-borrower', row.user_borrowid || '')
				.attr('data-status', row.statusborrow || '')
				.attr('data-type', row.type || '')
				.attr('data-serial', row.serial_no || '')
				.attr('data-amount', row.amount || '')
				.attr('data-ram', row.ram || '')
				.attr('data-process', row.process || '')
				.attr('data-battery', row.battery || '')
				.attr('data-hdd', row.hdd || '')
				.attr('data-windows', row.windows || '')
				.attr('data-wifi', row.wifiaddress || '')
				.attr('data-lan', row.lanaddress || '')
				.attr('data-display', row.display || '')
				.attr('data-date-start', row.date_start || '')
				.attr('data-date-end', row.date_end || '')
				.attr('data-borrower-name', row.borrower_name || '')
				.attr('data-employee-id', row.employee_id || '')
				.attr('data-name-en', row.name_en || '')
				.attr('data-department', row.department || '')
				.attr('data-time-create', row.time_create || '')
				.attr('data-role-id', row.role_id || '');
			
			// ID
			tr.append($('<td>').addClass('text-gray-900 fw-bold fs-6').text(row.borrow_id || ''));
			
			// Item No
			tr.append($('<td>').addClass('text-gray-900 fw-normal fs-5').text(row.item_no || ''));
			
			// Type Icon
			var typeCell = $('<td>').attr('data-type', row.type).addClass('text-center');
			var typeIcon = getTypeIcon(row.type);
			typeCell.append($('<div>').addClass('d-flex align-items-center justify-content-center').html(typeIcon));
			tr.append(typeCell);
			
			// Equipment/Detail
			var equipCell = $('<td>');
			equipCell.append($('<div>').addClass('fw-semibold text-gray-900 mb-1').text(row.name || ''));
			var detailDiv = $('<div>').addClass('d-flex align-items-center');
			detailDiv.append('<span class="btn btn-icon btn-light-secondary btn-sm me-2"><i class="ki-duotone ki-message-text fs-4 text-gray-600"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i></span>');
			detailDiv.append($('<div>').addClass('text-gray-500 fs-8').text(row.detail || ''));
			equipCell.append(detailDiv);
			tr.append(equipCell);
			
			// Location
			tr.append($('<td>').addClass('fw-semibold').text(row.location || ''));
			
			// Status
			var statusCell = $('<td>').attr('data-status', row.statusborrow);
			var statusDiv = $('<div>').addClass('d-flex flex-column align-items-start');
			var statusBadge = getStatusBadge(row.statusborrow);
			statusDiv.append(statusBadge);
			var borrowerText = row.name_en || row.borrower_name || '';
			statusDiv.append($('<span>').addClass('fw-normal fs-6 text-gray-800 mt-1').text(borrowerText));
			statusCell.append(statusDiv);
			tr.append(statusCell);
			
			// Actions
			var actionsCell = $('<td>').addClass('text-end');
			actionsCell.html(
				'<a href="javascript:void(0);" class="btn btn-icon btn-sm btn-light-info mb-1 fs-3 btn-view-borrow" data-borrow-id="' + (row.borrow_id || '') + '">' +
				'<i class="ki-duotone ki-document fs-1"><span class="path1"></span><span class="path2"></span></i></a> ' +
				'<a href="${pageContext.request.contextPath}/borrow_edit?id=' + (row.borrow_id || '') + '" data-route="borrow_edit" class="btn btn-icon btn-sm btn-light-primary mb-1 fs-3">' +
				'<i class="ki-duotone ki-pencil fs-1"><span class="path1"></span><span class="path2"></span></i></a> ' +
				'<button type="button" class="btn btn-icon btn-sm btn-light-warning btn-borrow-detail mb-1 fs-3 me-3" title="Borrow Detail">' +
				'<i class="ki-duotone ki-file-left fs-1"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i></button>'
			);
			tr.append(actionsCell);
			
			tbody.append(tr);
		});
	}

	function getTypeIcon(type) {
		var typeStr = (type || '').toLowerCase();
		switch(typeStr) {
			case 'c':
				return '<i class="ki-duotone ki-laptop fs-1 text-gray-500"><span class="path1"></span><span class="path2"></span></i>';
			case 'in':
				return '<i class="ki-duotone ki-keyboard fs-1 text-gray-500"><span class="path1"></span><span class="path2"></span></i>';
			case 'l':
			case 'sl':
				return '<i class="ki-duotone ki-verify fs-1 text-gray-500"><span class="path1"></span><span class="path2"></span></i>';
			case 'mob':
				return '<i class="ki-duotone ki-phone fs-1 text-gray-500"><span class="path1"></span><span class="path2"></span></i>';
			case 'p':
				return '<i class="ki-duotone ki-wifi-square fs-1 text-gray-500"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i>';
			default:
				return '<i class="ki-duotone ki-dots-square fs-1 text-gray-500"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i>';
		}
	}

	function getStatusBadge(status) {
		var statusStr = (status || '').toUpperCase();
		switch(statusStr) {
			case 'B':
				return '<span class="badge badge-primary me-2" style="width: fit-content;">Borrowed</span>';
			case 'W':
				return '<span class="badge badge-light me-2" style="width: fit-content;">Wait for Approve</span>';
			default:
				return '<span class="badge badge-light me-2" style="width: fit-content;">-</span>';
		}
	}

	$(document).ready(function() {
		const CTX = "${pageContext.request.contextPath}";

		// Render ตารางครั้งแรก
		renderBorrowTable(borrowList);
		$('#itemsFound').text(borrowList.length + ' Items Found');

		// ===== Bootstrap modal instances =====
		const borrowModalEl = document.getElementById('borrowModal');
		const modalObj = bootstrap.Modal.getOrCreateInstance(borrowModalEl);

		const bdModalEl = document.getElementById('borrowDetailModal');
		const bdModalObj = bootstrap.Modal.getOrCreateInstance(bdModalEl);

		const $keywordInput = $('#searchForm input[name="keyword"]');
		const $statusSelect = $('#searchForm select[name="status"]');
		const $typeSelect = $('#searchForm select[name="type"]');
		const $searchForm = $('#searchForm');

		// ===== Initialize Select2 =====
		$typeSelect.select2({
			placeholder: "Select",
			closeOnSelect: false,
			allowClear: true,
			width: '100%',
			templateResult: formatStateWithCheckbox
		});

		function formatStateWithCheckbox(state) {
			if (!state.id) {
				return state.text;
			}

			var isSelected = $typeSelect.val() && $typeSelect.val().includes(state.id);
			
			var $state = $(
				'<div class="d-flex align-items-center w-100">' +
					'<input type="checkbox" class="form-check-input me-2" ' + 
					(isSelected ? 'checked' : '') + '> ' +
					'<span>' + state.text + '</span>' +
				'</div>'
			);
			
			return $state;
		}

		$(document).on('mousedown', '.select2-results__option input[type="checkbox"]', function(e) {
			e.stopPropagation();
		});

		$typeSelect.on('select2:select select2:unselect', function(e) {
			$typeSelect.select2('close');
			$typeSelect.select2('open');
		});

		$typeSelect.on('select2:open', function() {
			setTimeout(function() {
				if (!$('.type-select-buttons').length) {
					var buttonsHtml = 
						'<div class="type-select-buttons d-flex gap-2 p-3 border-top bg-white">' +
							'<button type="button" class="btn btn-light flex-fill type-deselect-btn">Deselect All</button>' +
							'<button type="button" class="btn btn-primary flex-fill type-select-btn">Select All</button>' +
						'</div>';
					
					$('.select2-dropdown').append(buttonsHtml);
					
					$('.type-deselect-btn').on('click', function(e) {
						e.preventDefault();
						e.stopPropagation();
						$typeSelect.val(null).trigger('change');
						$typeSelect.select2('close');
					});
					
					$('.type-select-btn').on('click', function(e) {
						e.preventDefault();
						e.stopPropagation();
						var allValues = $typeSelect.find('option').map(function() {
							return $(this).val();
						}).get();
						$typeSelect.val(allValues).trigger('change');
						$typeSelect.select2('close');
					});
				}
			}, 10);
		});

		// ===== Custom filter =====
		$.fn.dataTable.ext.search.push(function(settings, data, dataIndex) {
			if (settings.nTable.id !== 'borrow_table') return true;

			var keyword = ($keywordInput.val() || '').trim().toLowerCase();
			var statusFilter = ($statusSelect.val() || '').toUpperCase();
			var typeFilterArray = $typeSelect.val() || [];

			var rowNode = settings.aoData[dataIndex].nTr;
			var statusCode = (rowNode.dataset.status || '').toUpperCase();
			var typeCode = (rowNode.dataset.type || '').toLowerCase();

			if (typeCode === 'sl') {
				typeCode = 'l';
			}

			if (statusFilter && statusCode !== statusFilter) {
				return false;
			}

			if (typeFilterArray.length > 0) {
				if (!typeFilterArray.includes(typeCode)) {
					return false;
				}
			}

			var rowText = (rowNode.textContent || '').toLowerCase();
			if (keyword && rowText.indexOf(keyword) === -1) {
				return false;
			}

			return true;
		});

		// ===== init DataTable =====
		var table = $('#borrow_table').DataTable({
			pageLength: 10,
			lengthMenu: [10, 20, 50, 100],
			ordering: false,
			searching: true,
			info: false,
			pagingType: "simple_numbers",
			dom: "<'row'<'col-12'tr>>" +
				 "<'row mt-3'<'col-sm-6 d-flex align-items-center'l>" +
				 "<'col-sm-6 d-flex justify-content-end'p>>",
			language: {
				lengthMenu: "_MENU_",
				paginate: {
					first: "«",
					last: "»",
					next: ">",
					previous: "<"
				},
				zeroRecords: "ไม่พบข้อมูล"
			}
		});

		table.on('draw', function() {
			var count = table.rows({ filter: 'applied' }).count();
			$('#itemsFound').text(count + ' Items Found');
		});

		table.draw();

		// ===== Events =====
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
			e.preventDefault();
			table.draw();
		});

		// ===== Helpers =====
		function setText(id, val) {
			const el = document.getElementById(id);
			if (!el) return;
			el.textContent = (val !== undefined && val !== null && String(val).trim() !== "") ? val : "-";
		}

		function formatBorrowDate(dtStr) {
			if (!dtStr) return '';
			const d = new Date(String(dtStr).replace(' ', 'T'));
			if (isNaN(d.getTime())) return String(dtStr);

			const day = d.getDate();
			const monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
			const month = monthNames[d.getMonth()];
			const year = d.getFullYear();

			return day + ' ' + month + ' ' + year;
		}

		function formatDateRange(startStr, endStr) {
			const s = formatBorrowDate(startStr);
			const e = formatBorrowDate(endStr);
			if (!s && !e) return '-';
			if (s && e) return s + ' - ' + e;
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
		const moreCollapseEl = document.getElementById('moreDetailCollapse');
		if (moreCollapseEl) {
			const moreCollapseObj = bootstrap.Collapse.getOrCreateInstance(moreCollapseEl, {
				toggle: false
			});

			$('#moreDetailToggle').on('click', function(e) {
				e.preventDefault();
				moreCollapseObj.toggle();
			});

			moreCollapseEl.addEventListener('shown.bs.collapse', function() {
				$('#moreDetailIcon').addClass('is-open');
				$('#moreDetailToggle').attr('aria-expanded', 'true');
			});

			moreCollapseEl.addEventListener('hidden.bs.collapse', function() {
				$('#moreDetailIcon').removeClass('is-open');
				$('#moreDetailToggle').attr('aria-expanded', 'false');
			});
		}

		// ===== Collapse: More Detail (modal ล่าง) =====
		const bdCollapseEl = document.getElementById('bd_moreDetailCollapse');
		if (bdCollapseEl) {
			const bdCollapseObj = bootstrap.Collapse.getOrCreateInstance(bdCollapseEl, {
				toggle: false
			});

			$('#bd_moreDetailToggle').on('click', function(e) {
				e.preventDefault();
				bdCollapseObj.toggle();
			});

			bdCollapseEl.addEventListener('shown.bs.collapse', function() {
				$('#bd_moreDetailIcon').addClass('is-open');
				$('#bd_moreDetailToggle').attr('aria-expanded', 'true');
			});

			bdCollapseEl.addEventListener('hidden.bs.collapse', function() {
				$('#bd_moreDetailIcon').removeClass('is-open');
				$('#bd_moreDetailToggle').attr('aria-expanded', 'false');
			});

			bdModalEl.addEventListener('hidden.bs.modal', function() {
				bdCollapseObj.hide();
				$('#bd_moreDetailIcon').removeClass('is-open');
				$('#bd_moreDetailToggle').attr('aria-expanded', 'false');
			});
		}

		function fillBorrowDetailModal(p) {
			if (!p) return;

			$('#borrowDetailModal').data('borrowId', p.borrowId);

			$('#bd_item_link').text('ID: ' + (p.itemNo || '-'));
			setText('bd_name', p.name);
			setText('bd_serial', p.serial);
			setText('bd_detail', p.detail);
			setText('bd_amount', p.amountText || '1');
			setText('bd_purchase_date', formatTime(p.purchaseDate));

			const $b = $('#bd_status_badge');
			$b.removeClass().addClass('badge badge-lg rounded-pill px-4 fw-semibold');

			if (p.status === 'B') {
				$b.addClass('bg-warning text-white').text('Borrowing');
			} else if (p.status === 'W') {
				$b.addClass('bg-light text-dark').text('Wait for Approve');
			} else if (p.status === 'R') {
				$b.addClass('bg-success text-white').text('Returned');
			} else {
				$b.addClass('bg-light text-muted').text('-');
			}

			const isComputer = String(p.type || '').toLowerCase() === 'c';
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

			$('#bd_approver_note').val('');
		}

		function resetMoreDetailTop() {
			const el = document.getElementById('moreDetailCollapse');
			if (!el) return;

			const c = bootstrap.Collapse.getOrCreateInstance(el, { toggle: false });
			c.hide();

			$('#moreDetailIcon').removeClass('is-open');
			$('#moreDetailToggle').attr('aria-expanded', 'false');
		}

		// ===== กดปุ่ม View =====
		$(document).on('click', '.btn-view-borrow', function(e) {
			e.preventDefault();

			const $tr = $(this).closest('tr');
			const borrowId = $.trim($tr.find('td').eq(0).text());

			const itemNo = $tr.data('itemNo') || $tr.attr('data-item-no') || '';
			const name = $tr.data('name') || '';
			const detail = $tr.data('detail') || '';
			const location = $tr.data('location') || '';
			const status = String($tr.data('status') || '').toUpperCase();
			const type = String($tr.data('type') || '');

			setBorrowModalButtons(status);

			const serial = $tr.data('serial') || '';
			const borrower = $tr.data('borrowerName') || $tr.attr('data-borrower-name') || '';

			const amountRaw = $tr.data('amount');
			let amountText = '1';
			if (amountRaw !== undefined && amountRaw !== null && amountRaw !== '') {
				const n = parseFloat(amountRaw);
				if (!isNaN(n))
					amountText = (n % 1 === 0) ? String(parseInt(n, 10)) : String(n);
				else
					amountText = String(amountRaw);
			}

			const ram = $tr.data('ram') || '';
			const process = $tr.data('process') || '';
			const battery = $tr.data('battery') || '';
			const hdd = $tr.data('hdd') || '';
			const windows = $tr.data('windows') || '';
			const wifi = $tr.data('wifi') || '';
			const lan = $tr.data('lan') || '';
			const display = $tr.data('display') || '';

			const dateStart = $tr.data('dateStart') || $tr.attr('data-date-start') || '';
			const dateEnd = $tr.data('dateEnd') || $tr.attr('data-date-end') || '';
			const timeCreate = $tr.data('timeCreate') || $tr.attr('data-time-create') || '';

			setText('m_item_link', 'ID: ' + itemNo);
			setText('m_borrow_id', 'ID: ' + borrowId);
			setText('m_borrower', borrower);
			setText('m_serial', serial);
			setText('m_detail_top', detail);
			setText('m_amount', amountText);
			setText('m_location', location);
			setText('m_borrow_date', formatDateRange(dateStart, dateEnd));
			setText('m_purchase_date', formatTime(timeCreate));

			const $badge = $('#m_status_badge');
			if ($badge.length) {
				$badge.removeClass().addClass('badge badge-lg rounded-pill px-4 fw-semibold');
				if (status === 'B')
					$badge.addClass('bg-warning text-white').text('Borrowing');
				else if (status === 'R')
					$badge.addClass('bg-success text-white').text('Returned');
				else if (status === 'W')
					$badge.addClass('bg-light text-dark').text('Wait for Approve');
				else
					$badge.addClass('bg-light text-muted').text('-');
			}

			const moreWrapper = $('#moreDetailWrapper');
			if (String(type).toLowerCase() === 'c') {
				moreWrapper.show();
				setText('m_windows', windows);
				setText('m_ram', ram);
				setText('m_hdd', hdd);
				setText('m_hddd', hdd);
				setText('m_display', display);
				setText('m_process', process);
				setText('m_battery', battery);
				setText('m_wifi', wifi);
				setText('m_lan', lan);
			} else {
				moreWrapper.hide();
			}

			$('#borrowModal').data('borrowPayload', {
				borrowId: borrowId,
				itemNo: itemNo,
				name: name,
				serial: serial,
				detail: detail,
				amountText: amountText,
				purchaseDate: timeCreate,
				status: status,
				type: type,
				windows: windows,
				ram: ram,
				hdd: hdd,
				display: display,
				process: process,
				battery: battery,
				wifi: wifi,
				lan: lan
			});

			resetMoreDetailTop();

			if (String(type).toLowerCase() === 'c') {
				$('#moreDetailWrapper').show();
			} else {
				$('#moreDetailWrapper').hide();
				resetMoreDetailTop();
			}

			modalObj.show();
		});

		// ===== กดปุ่ม Request for Return =====
		$('#btn_request_return').on('click', function(e) {
			e.preventDefault();

			const payload = $('#borrowModal').data('borrowPayload');

			$('.modal-backdrop').remove();
			$('body').removeClass('modal-open');

			modalObj.hide();

			setTimeout(function() {
				fillBorrowDetailModal(payload);
				bdModalObj.show();
			}, 300);
		});

		// ===== ปุ่ม Cancel / Confirm =====
		function ajaxBorrowAction(actionUrl, borrowId) {
			return $.ajax({
				url: actionUrl,
				type: 'POST',
				dataType: 'json',
				data: {
					id: borrowId
				}
			});
		}

		$('#btn_cancel_borrow').on('click', function(e) {
			e.preventDefault();
			const payload = $('#borrowModal').data('borrowPayload') || {};
			const borrowId = payload.borrowId || '';
			if (!borrowId) return alert('Borrow ID not found.');

			if (!confirm('Cancel this borrow request?')) return;

			ajaxBorrowAction(CTX + '/eBorrowCancel.action', borrowId)
				.done(function(data) {
					if (data && data.message === 'success') {
						window.location.href = CTX + '/borrow_list.action';
					} else {
						alert('Cancel failed: ' + (data ? data.message : 'no response'));
					}
				})
				.fail(function(xhr) {
					console.log('RAW:', xhr.responseText);
					alert('Cancel error');
				});
		});

		$('#btn_confirm_borrow').on('click', function(e) {
			e.preventDefault();
			const payload = $('#borrowModal').data('borrowPayload') || {};
			const borrowId = payload.borrowId || '';
			if (!borrowId) return alert('Borrow ID not found.');

			if (!confirm('Confirm this borrow request?')) return;

			ajaxBorrowAction(CTX + '/eBorrowConfirm.action', borrowId)
				.done(function(data) {
					if (data && data.message === 'success') {
						window.location.href = CTX + '/borrow_list.action';
					} else {
						alert('Confirm failed: ' + (data ? data.message : 'no response'));
					}
				})
				.fail(function(xhr) {
					console.log('RAW:', xhr.responseText);
					alert('Confirm error');
				});
		});

		// ===== Edit =====
		$('#btn_edit').on('click', function(e) {
			e.preventDefault();

			const payload = $('#borrowModal').data('borrowPayload') || {};
			const borrowId = payload.borrowId || '';

			if (!borrowId) {
				alert('Borrow ID not found.');
				return;
			}

			window.location.href = CTX + '/borrow_edit.action?id=' + encodeURIComponent(borrowId);
		});

		// ===== ปุ่ม Request for Return ใน modal Return =====
		$('#bd_request_return').on('click', function(e) {
			e.preventDefault();

			const borrowId = $('#borrowDetailModal').data('borrowId') || '';
			const note = $('#bd_approver_note').val();

			if (!borrowId) {
				alert('Borrow ID not found.');
				return;
			}

			if (!confirm('Are you sure you want to request return for this item?')) return;

			$.ajax({
				url: CTX + "/eBorrowReturn.action",
				type: "POST",
				dataType: "json",
				data: { id: borrowId, note: note },
				success: function(data) {
					if (data && data.message === "success") {
						alert("Return request submitted successfully!");
						bdModalObj.hide();
						window.location.href = CTX + "/borrow_list.action";
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
		});

		// ===== แก้ไขปัญหาปุ่ม X และ Cancel =====
		$('#borrowDetailModal').on('click', '[data-bs-dismiss="modal"]', function(e) {
			e.preventDefault();
			e.stopPropagation();
			bdModalObj.hide();
		});

		$('#borrowDetailModal').on('shown.bs.modal', function() {
			const $backdrop = $('.modal-backdrop').last();
			const currentZIndex = parseInt($(this).css('z-index'), 10);

			if ($backdrop.length) {
				$backdrop.css('z-index', currentZIndex - 1);
			}

			$(this).css('z-index', currentZIndex + 2);
		});

		// ===== เปิด modal Return โดยตรง =====
		$(document).on('click', '.btn-borrow-detail', function(e) {
			e.preventDefault();

			const $tr = $(this).closest('tr');
			const borrowId = $.trim($tr.find('td').eq(0).text());

			const itemNo = $tr.data('itemNo') || $tr.attr('data-item-no') || '';
			const name = $tr.data('name') || '';
			const detail = $tr.data('detail') || '';
			const serial = $tr.data('serial') || '';
			const status = (($tr.data('status') || '') + '').toUpperCase();

			const amountRaw = $tr.data('amount');
			let amountText = '1';
			if (amountRaw !== undefined && amountRaw !== null && amountRaw !== '') {
				const n = parseFloat(amountRaw);
				amountText = (!isNaN(n) && n % 1 === 0) ? parseInt(n, 10).toString() : (amountRaw + '');
			}

			const timeCreate = $tr.data('timeCreate') || $tr.attr('data-time-create') || '';

			const type = (($tr.data('type') || '') + '').toLowerCase();
			const windows = $tr.data('windows') || '';
			const ram = $tr.data('ram') || '';
			const hdd = $tr.data('hdd') || '';
			const wifi = $tr.data('wifi') || '';
			const lan = $tr.data('lan') || '';
			const display = $tr.data('display') || '';
			const cpu = $tr.data('process') || $tr.data('cpu') || '';
			const battery = $tr.data('battery') || '';

			const $badge = $('#bd_status_badge');
			$badge.removeClass().addClass('badge badge-lg rounded-pill px-4 fw-semibold');

			if (status === 'B') {
				$badge.addClass('bg-warning text-white').text('Borrowing');
			} else if (status === 'R') {
				$badge.addClass('bg-success text-white').text('Returned');
			} else if (status === 'W') {
				$badge.addClass('bg-light text-dark').text('Wait for Approve');
			} else {
				$badge.addClass('bg-light text-muted').text('-');
			}

			$('#bd_item_link').text('ID: ' + itemNo);
			$('#bd_name').text(name);
			$('#bd_serial').text(serial);
			$('#bd_detail').text(detail);
			$('#bd_amount').text(amountText);
			$('#bd_purchase_date').text(formatBorrowDate(timeCreate) || '-');

			if (bdCollapseEl) {
				const bdCollapseObj = bootstrap.Collapse.getOrCreateInstance(bdCollapseEl, { toggle: false });
				bdCollapseObj.hide();
				$('#bd_moreDetailIcon').removeClass('is-open');
				$('#bd_moreDetailToggle').attr('aria-expanded', 'false');
			}

			if (type === 'c') {
				$('#bd_moreDetailWrapper').show();
				$('#bd_windows').text(windows);
				$('#bd_ram').text(ram);
				$('#bd_storage').text(hdd);
				$('#bd_storage2').text(hdd);
				$('#bd_wifi').text(wifi);
				$('#bd_lan').text(lan);
				$('#bd_display').text(display);
				$('#bd_cpu').text(cpu);
				$('#bd_battery').text(battery);
			} else {
				$('#bd_moreDetailWrapper').hide();
			}

			$('#borrowDetailModal').data('borrowId', borrowId);
			$('#bd_approver_note').val('');

			bdModalObj.show();
		});
	});
	</script>

	<!-- Sort Script -->
	<script>
	document.addEventListener("DOMContentLoaded", function () {
		const tbody = document.getElementById("borrowTableBody");
		const headers = document.querySelectorAll("th.sort");
		let sortDir = {};
		
		headers.forEach((th, colIndex) => {
			th.addEventListener("click", () => {
				const type = th.dataset.sort;
				const dir = sortDir[colIndex] = !(sortDir[colIndex]);
				const rows = Array.from(tbody.querySelectorAll("tr"));
				
				headers.forEach(header => {
					header.classList.remove("sort-asc", "sort-desc");
					const arrow = header.querySelector('.sort-arrow');
					if (arrow) arrow.remove();
				});
				
				th.classList.add(dir ? "sort-asc" : "sort-desc");
				const arrow = document.createElement('span');
				arrow.className = 'sort-arrow';
				arrow.innerHTML = dir ? ' ▲' : ' ▼';
				th.appendChild(arrow);
				
				rows.sort((a, b) => {
					let A, B;
					
					switch (type) {
						case "number":
							A = parseInt(a.children[colIndex].textContent.trim(), 10) || 0;
							B = parseInt(b.children[colIndex].textContent.trim(), 10) || 0;
							return dir ? A - B : B - A;
						
						case "type":
							A = a.querySelector("td[data-type]")?.dataset.type || "";
							B = b.querySelector("td[data-type]")?.dataset.type || "";
							A = A.toLowerCase() === "sl" ? "l" : A.toLowerCase();
							B = B.toLowerCase() === "sl" ? "l" : B.toLowerCase();
							return dir ? A.localeCompare(B) : B.localeCompare(A);
						
						case "status":
							A = a.querySelector("td[data-status]")?.dataset.status || "";
							B = b.querySelector("td[data-status]")?.dataset.status || "";
							return dir ? A.localeCompare(B) : B.localeCompare(A);
						
						default:
							A = a.children[colIndex].textContent.trim().toLowerCase();
							B = b.children[colIndex].textContent.trim().toLowerCase();
							return dir ? A.localeCompare(B, undefined, { numeric: true })
									   : B.localeCompare(A, undefined, { numeric: true });
					}
				});
				rows.forEach(r => tbody.appendChild(r));
			});
		});
	});
	</script>
</body>
</html>