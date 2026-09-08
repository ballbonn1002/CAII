<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/tlds/permission.tld" prefix="perm"%>
<fmt:setLocale value="en_US" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Equipment Request | CubeSoftTech</title>

<link
	href="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/assets/css/style.bundle.css"
	rel="stylesheet" type="text/css" />

<script
	src="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.js"></script>
<script
	src="${pageContext.request.contextPath}/assets/js/scripts.bundle.js"></script>

<style>
.btn-purple-light {
	background-color: #E8D9F2 !important;
	color: #7E3391 !important;
	border: none;
}

.btn-purple-light:hover {
	background-color: #7E3391 !important;
	color: white !important;
}

.btn-blue-light {
	background-color: #E1F0FF !important;
	color: #0095E8 !important;
	border: none;
}

.btn-red-light {
	background-color: #FFE2E5 !important;
	color: #F64E60 !important;
	border: none;
}

.table thead th {
	background-color: #F9F9F9;
	text-transform: uppercase;
	font-size: 0.75rem;
	color: #A1A5B7;
}

.breadcrumb-item+.breadcrumb-item::before {
	content: "-" !important;
}

.bg-user-info {
	background-color: #F5F8FA;
	border-radius: 8px;
}

.card.card-flush>.card-header {
	border-bottom: 1px solid #EEF0F3 !important;
}

#kt_travel_table thead th {
	background-color: #fff !important;
}

/* Loading overlay */
.table-loading-overlay {
	position: absolute;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background: rgba(255, 255, 255, 0.85);
	display: none;
	align-items: center;
	justify-content: center;
	z-index: 10;
	border-radius: 8px;
}

.table-loading-overlay.active {
	display: flex;
}

#filterUser+.select2-container .select2-selection__rendered {
	color: #181c32 !important;
	font-weight: 500 !important;
}

.nav-line-tabs .nav-item .nav-link.active, .nav-line-tabs .nav-item .nav-link:hover:not(.disabled), .nav-line-tabs .nav-item.show .nav-link {
    background-color: transparent;
    border: 0;
    border: 1px solid var(--bs-primary);
    color: var(--bs-primary);
    transition: color .2s ease;
}

.padding-custom-nav-bar{
padding: 15px 20px 15px 20px !important;
border-radius: 10px;
}
.nav-line-tabs .nav-item .nav-link {
    color: var(--bs-gray-700);
    border: 0;
    border-bottom: 1px solid transparent;
    transition: color .2s ease;
    padding: .5rem 0;
    margin: 0 ;
}

.badge {
    --bs-badge-padding-x: 0.5rem;
    --bs-badge-padding-y: 0.325rem;
    --bs-badge-font-size: 0.85rem;
    --bs-badge-font-weight: 600;
    --bs-badge-border-radius: 0.425rem;
    display: inline-block;
    padding: var(--bs-badge-padding-y) var(--bs-badge-padding-x);
    font-size: var(--bs-badge-font-size);
    font-weight: var(--bs-badge-font-weight);
    line-height: 1;
    /* color: var(--bs-badge-color); */
    text-align: center;
    white-space: nowrap;
    vertical-align: baseline;
    border-radius: var(--bs-badge-border-radius);
}
.active{
color: var(--bs-primary);
}

.active-status {
    font-weight: bold;
    color : #fff;
   background-color: var(--bs-primary)  !important;
}

.search-icon {
    position: absolute;
    top: 50%;
    left: 14px;
    transform: translateY(-70%);
    z-index: 10;
    pointer-events: none;
}
</style>
</head>

<body id="kt_app_body" class="app-default">

	<c:set var="ctx" value="${pageContext.request.contextPath}" />

	<%-- ✅ default = Draft --%>
	<c:set var="statusActiveSafe"
		value="${not empty param.status ? param.status : (empty statusActive ? 'All' : statusActive)}" />

	<div class="d-flex flex-column flex-root" id="kt_app_root">
		<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
			<div class="d-flex flex-column flex-column-fluid">

				<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
					<div id="kt_app_toolbar_container"
						class="app-container container-fluid d-flex align-items-center">
						<div
							class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
							<h1
								class="page-heading d-flex text-dark fw-bold fs-3 flex-column justify-content-center my-0">
								Equipment Request</h1>
							<ul
								class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
								<li class="breadcrumb-item text-muted">Home</li>
								<li class="breadcrumb-item"><span
									class="bullet bg-gray-400 w-5px h-2px "></span></li>
								<li class="breadcrumb-item text-muted">Cube Management</li>
							</ul>
						</div>
					</div>
				</div>

				<div id="kt_app_content" class="app-content flex-column-fluid">
					<div id="kt_app_content_container"
						class="app-container container-fluid">

						<!-- Filter Bar -->
						<div class="card mb-5 mb-xl-8">
							<div class="card-body py-3 ">
				<!-- 🆕 ฟอร์มค้นหาอัจฉริยะ (แก้ไขโครงสร้างให้ถูกต้อง แถบเลือกวันที่ไม่หาย) -->
				<form id="filterForm" method="get" action="${ctx}/equipment_request_list">
				<!--     ซ่อนค่าสถานะปัจจุบันและหน้าปัจจุบันเอาไว้ไม่ให้หลุดเวลาส่งค่าค้นหา -->
				    <input type="hidden" name="status" value="${not empty param.status ? param.status : 'All'}" />
				    <input type="hidden" name="page" value="1" />
				
				    <div class="d-flex flex-stack gap-5">
				<!--         LEFT: Dropdown พิมพ์ค้นหาอัจฉริยะ -->
		        <div class="position-relative w-100">
		            <i class="ki-duotone ki-magnifier search-icon fs-3"> 
		                <span class="path1"></span> <span class="path2"></span>
		            </i> 
		            
		            <select class="form-select ps-11" id="userSelect" name="userSelect" style="width: 100%;">
		               <!-- ช่องตั้งต้นเมื่อเคลียร์คำค้นหา -->
		                <option value="All" ${idUserSelected == 'All' || empty idUserSelected ? 'selected' : ''}> search </option>
		                
		                <optgroup>
		                    <c:forEach var="u" items="${EquipmentRequestlist}">
		                        <option value="${u.mr_id}" ${u.mr_id == idUserSelected ? 'selected' : ''}>
		                            ${u.mr_id} | ${u.item_type} | ${u.product_name} | ${u.status_name}
		                        </option>
		                    </c:forEach>
		                </optgroup>
	                <c:if test="${not empty idUserSelected && idUserSelected != 'All'}">
	                    <option value="${idUserSelected}" selected>${idUserSelected}</option>
	                </c:if>
	            </select>
	        </div>

		<!-- Date Range Picker -->
		<div class="col-12 col-md-4">
			<div class="position-relative">
				<i class="ki-duotone 
				ki-calendar-8 fs-2 
				text-gray-500 
				position-absolute 
				top-50 
				translate-middle-y 
				ms-4">
					<span class="path1"></span><span class="path2"></span>
					<span class="path3"></span><span class="path4"></span>
					<span class="path5"></span><span class="path6"></span>
				</i> <input type="text" class="form-control ps-12" id="kt_daterangepicker_fm" 
       value="${not empty startDate ? startDate : ''} ${not empty endDate ? ' - '.concat(endDate) : ''}" />
			</div>
		</div>
		</div>		
		</form>
			</div>
		</div>
						<div class="card card-flush">
							<div class="card-body pt-0">
<!-- 								<form id="submitForm" method="post" -->
<%-- 									action="${ctx}/equipment_request_create"> --%>

									<c:url var="createUrl" value="/equipment_request_create" />

									<%-- ✅ Submit + Create button แสดงเฉพาะ tab Draft --%>
									<div 
										class="d-flex  justify-between  gap-1 mt-6 mb-6">
											<div class="d-flex col-xl-6 gap-4" style="margin: auto;">Equipment Request List </div>
											<div class="d-flex col-xl-6 gap-4 justify-content-end">
												<a href="${createUrl}" class="btn btn-success btn-sm px-4"
													data-route="my_travelA" id="btn_create"> <i
													class="ki-duotone ki-plus fs-4 me-2"> <span
														class="path1"></span><span class="path2"></span>
												</i> Create
												</a>
											</div>
									</div>

									<div class="card-toolbar">
									<c:url var="tabAll" value="/equipment_request_list">
										<c:param name="status" value="All" />
										<c:param name="page" value="1" />
										<c:if test="${not empty param.dateRange}">
											<c:param name="dateRange" value="All" />
										</c:if>
									</c:url>
									
									<c:url var="tabDraft" value="/equipment_request_list">
										<c:param name="status" value="Draft" />
										<c:param name="page" value="1" />
										<c:if test="${not empty param.dateRange}">
											<c:param name="dateRange" value="${param.dateRange}" />
										</c:if>
									</c:url>

									<c:url var="tabPending" value="/equipment_request_list">
										<c:param name="status" value="Pending" />
										<c:param name="page" value="1" />
										<c:if test="${not empty param.dateRange}">
											<c:param name="dateRange" value="${param.dateRange}" />
										</c:if>
									</c:url>

									<c:url var="tabCancel" value="/equipment_request_list">
										<c:param name="status" value="Cancel" />
										<c:param name="page" value="1" />
										<c:if test="${not empty param.dateRange}">
											<c:param name="dateRange" value="${param.dateRange}" />
										</c:if>
									</c:url>

									<c:url var="tabApproved" value="/equipment_request_list">
										<c:param name="status" value="Approved" />
										<c:param name="page" value="1" />
										<c:if test="${not empty param.dateRange}">
											<c:param name="dateRange" value="${param.dateRange}" />
										</c:if>
									</c:url>

									<c:url var="tabDelivered" value="/equipment_request_list">
										<c:param name="status" value="Delivered" />
										<c:param name="page" value="1" />
										<c:if test="${not empty param.dateRange}">
											<c:param name="dateRange" value="${param.dateRange}" />
										</c:if>
									</c:url>

									<c:url var="Rejected" value="/equipment_request_list">
										<c:param name="status" value="Rejected" />
										<c:param name="page" value="1" />
										<c:if test="${not empty param.dateRange}">
											<c:param name="dateRange" value="${param.dateRange}" />
										</c:if>
									</c:url>

									<ul
										class="nav nav-stretch nav-line-tabs nav-line-tabs-2x border-transparent fs-5 fw-bold mt-10 mb-10">
										<%-- ✅ Draft tab — ไม่มีสถานะ ดูจาก expense_group_id = 0 --%>
											<li class="nav-item p-2">
												<a class="nav-link text-active-primary ${statusActiveSafe=='All' ? 'active' : ''} padding-custom-nav-bar"
												href="${tabAll}" data-status="All">
												<span class="badge mr-2 fs-1 text-primary">${total_status_draft 
												+ total_status_pending + total_status_approved + total_status_rejected
												+ total_status_cancel
												+ total_status_delivered }</span> &nbsp;&nbsp;
												<span class="badge active-status  fs-9 px-4 py-1 rounded-2">All </span>
												</a>
											</li>
										<li class="nav-item p-2"><a
											class="nav-link text-active-primary ${statusActiveSafe=='Draft' ? 'active' : ''} padding-custom-nav-bar"
											href="${tabDraft}" data-status="Draft"> 
											<span class="badge ms-2 fs-1 text-gray">${total_status_draft}</span> &nbsp;&nbsp;
											<span class="badge bg-secondary fs-9 px-4 py-1 rounded-2"> Draft</span>
											</a></li>
										<li class="nav-item p-2"><a
											class="nav-link text-active-primary  ${statusActiveSafe=='Pending' ? 'active' : ''} padding-custom-nav-bar"
											href="${tabPending}" data-status="Pending"><span
												class="badge ms-2 fs-1 text-warning">${total_status_pending}</span> &nbsp;&nbsp;
											<span class="bg-warning text-white fs-9 px-4 py-1 rounded-2"style="font-size: 10px">	Pending </span>
										</a></li>
										<li class="nav-item p-2"><a
											class="nav-link text-active-primary ${statusActiveSafe=='Approved' ? 'active' : ''} padding-custom-nav-bar"
											href="${tabApproved}" data-status="Approved">
											<span class="badge mr-2 fs-1 text-success">${total_status_approved}</span> &nbsp;&nbsp;
											<span class="bg-success text-white fs-9 px-4 py-1 rounded-2"style="font-size: 10px"> Approved </span>
										</a></li>
										<li class="nav-item p-2"><a
											class="nav-link text-active-primary ${statusActiveSafe=='Delivered' ? 'active' : ''} padding-custom-nav-bar"
											href="${tabDelivered}" data-status="Delivered"><span
												class="badge mr-2 fs-1 text-cyan">${total_status_delivered}</span> &nbsp;&nbsp;
											<span class="bg-cyan text-white fs-9 px-4 py-1 rounded-2"style="font-size: 10px">Delivered </span> 
										</a></li>
										<li class="nav-item p-2"><a
											class="nav-link text-active-primary ${statusActiveSafe=='Rejected' ? 'active' : ''} padding-custom-nav-bar"
											href="${tabRejected}" data-status="Rejected"><span
												class="badge mr-2 fs-1 text-danger">${total_status_rejected}</span> &nbsp;&nbsp;
										<span class="bg-danger text-white fs-9 px-4 py-1 rounded-2"style="font-size: 10px">Rejected </span> 
										</a></li>
										<li class="nav-item p-2"><a
											class="nav-link text-active-primary ${statusActiveSafe=='Cancel' ? 'active' : ''} padding-custom-nav-bar"
											href="${tabCancel}" data-status="Cancel"><span
												class="badge mr-2 fs-1 text-dark">${total_status_cancel}</span>&nbsp;&nbsp;
												<span class="bg-dark text-white fs-9 px-4 py-1 rounded-2"style="font-size: 10px"> Cancel </span>
												 </a></li>
									</ul>
								</div>

									<div class="table-responsive" style="position: relative;">
										<div id="tableLoadingOverlay" class="table-loading-overlay">
											<div class="text-center">
												<span class="spinner-border text-primary"></span>
												<div class="mt-3 text-muted fw-semibold">Loading...</div>
											</div>
										</div>

										<c:set var="isGroupView" value="${viewMode == 'group'}" />

										<table class="table align-middle table-row-dashed fs-6 gy-5"
											id="kt_travel_table">
											<thead>
												<tr
													class="text-start text-muted fw-bold fs-7 text-uppercase gs-0">

														<th class="w-25px">
														#
													<th>MR ID</th>
													<th>Category</th>
													<th>Product Name</th>
													<th>Quantity / UNit</th>
														<th>Request Date</th>		
													<th class="text-center">Status</th>
													<th class="text-end">Action</th>
												</tr>
											</thead>

											<tbody class="text-gray-600 fw-semibold">
												<c:choose>

													<%-- ===== DRAFT view ===== --%>
													<c:when test="${statusActiveSafe == 'Draft'}">
														<c:forEach var="row" items="${EquipmentRequestlist}">
													<c:if test="${row.status_name == 'Draft'}">
															<tr>
															<td><span class="text-gray-600 fw-bold">${row.no}</span></td>
																<td><span class="text-gray-600 fw-bold">${row.mr_id}</span></td>
																	<td>
																	<c:choose>
																	<c:when test="${row.item_type == 'Equipment'}">
																	     <div class="d-inline-flex align-items-center gap-2">
																		<i class="ki-duotone ki-monitor-mobile text-primary fs-1">
																		 <span class="path1"></span>
																		 <span class="path2"></span>
																		</i>
																	</c:when>
																	<c:when test="${row.item_type == 'Consumables'}">
																		<i class="ki-duotone ki-lots-shopping fs-2 text-orange"><span class="path1"></span><span class="path2"></span>
													                     <span class="path3"></span><span class="path4"></span>
													                     <span class="path5"></span><span class="path6"></span>
													                     <span class="path7"></span><span class="path8"></span>
												                     </i>
																  </c:when>
																	<c:otherwise>
																	 <i class="ki-duotone ki-parcel fs-2 text-success">
												                     <span class="path1"></span><span class="path2"></span><span class="path3"></span>
																	 <span class="path4"></span><span class="path5"></span></i>
																				</c:otherwise>
																	</c:choose>	
																<span class="text-gray-600 fw-bold">${row.item_type}</span></td>
																<td><span class="text-gray-600 fw-bold">${not empty row.product_name ? row.product_name : '-'}</span></td>
																	<td>
																	<span class="text-gray-600 fw-bold">
																	<fmt:formatNumber value="${row.quantity}" pattern="#,##0" />
																	</span>
																	</td>
																<td class="text-start"><fmt:formatDate value="${row.request_date}" pattern="d MMM yyyy, H:mm" /></td>
																<td class="text-center">
																			<span class="badge badge-secondary">Draft</span>
																	</td>
																<td class="text-end">
																	<div class="d-flex justify-content-end gap-2">
																	<button  data-note="btn edit" onclick="gotoeditpage(`${row.mr_id}`)" title="Edit" class="btn btn-icon btn-sm btn-light-primary">
																			<i class="ki-duotone ki-pencil fs-5">
																				<span class="path1"></span>
																				<span class="path2"></span>
																			</i>
																		</button >	
																		<button type="button"
																			class="btn btn-icon btn-sm btn-light-danger btn-delete-expense"
																			data-id="${row.mr_id}" title="Delete">
																			<i class="ki-duotone ki-trash fs-1"> <span
																				class="path1"></span><span class="path2"></span> <span
																				class="path3"></span><span class="path4"></span>
																			</i>
																		</button>
																	</div>
																</td>
															</tr>
															 </c:if>
														</c:forEach>
														<c:if test="${EquipmentRequestlist.stream().filter(row -> row.status_name == 'Draft').count() == 0}">
															<tr>
																<td colspan="7" class="text-center text-muted py-10">No
																	data.</td>
															</tr>
														</c:if>
													</c:when>

													<c:when test="${statusActiveSafe == 'Pending'}">
														<c:forEach var="row" items="${EquipmentRequestlist}">
														<c:if test="${row.status_name == 'Pending'}">
															<tr>
															<td><span class="text-gray-600 fw-bold">${row.no}</span></td>
																<td><span class="text-gray-600 fw-bold">${row.mr_id}</span></td>
																	<td>
																	<c:choose>
																	<c:when test="${row.item_type == 'Equipment'}">
																	     <div class="d-inline-flex align-items-center gap-2">
																		<i class="ki-duotone ki-monitor-mobile text-primary fs-1">
																		 <span class="path1"></span>
																		 <span class="path2"></span>
																		</i>
																	</c:when>
																	<c:when test="${row.item_type == 'Consumables'}">
																		<i class="ki-duotone ki-lots-shopping fs-2 text-orange"><span class="path1"></span><span class="path2"></span>
													                     <span class="path3"></span><span class="path4"></span>
													                     <span class="path5"></span><span class="path6"></span>
													                     <span class="path7"></span><span class="path8"></span>
												                     </i>
																  </c:when>
																	<c:otherwise>
																	 <i class="ki-duotone ki-parcel fs-2 text-success">
												                     <span class="path1"></span><span class="path2"></span><span class="path3"></span>
																	 <span class="path4"></span><span class="path5"></span></i>
																				</c:otherwise>
																	</c:choose>	
																<span class="text-gray-600 fw-bold">${row.item_type}</span></td>
																<td><span class="text-gray-600 fw-bold">${not empty row.product_name ? row.product_name : '-'}</span></td>
																	<td>
																	<span class="text-gray-600 fw-bold">
																	<fmt:formatNumber value="${row.quantity}" pattern="#,##0" />
																	</span>
																	</td>
																<td class="text-start"><fmt:formatDate value="${row.request_date}" pattern="d MMM yyyy, H:mm" /></td>
																<td class="text-center">
																			<span class="badge badge-warning">Pending</span>
																		</td>
																<td class="text-end">
																	<div class="d-flex justify-content-end gap-2">
																	<button  data-note="btn edit" onclick="gotoeditpage(`${row.mr_id}`)" title="Edit" class="btn btn-icon btn-sm btn-light-primary">
																			<i class="ki-duotone ki-pencil fs-5">
																				<span class="path1"></span>
																				<span class="path2"></span>
																			</i>
																		</button >	
																																
																		<button type="button"
																			class="btn btn-icon btn-sm btn-light-danger btn-delete-expense"
																			data-id="${row.mr_id}" title="Delete">
																			<i class="ki-duotone ki-trash fs-1"> <span
																				class="path1"></span><span class="path2"></span> <span
																				class="path3"></span><span class="path4"></span>
																			</i>
																		</button>
																	</div>
																</td>
															</tr>
															 </c:if>
														</c:forEach>
														<c:if test="${EquipmentRequestlist.stream().filter(row -> row.status_name == 'Pending').count() == 0}">
															<tr>
																<td colspan="7" class="text-center text-muted py-10">No
																	data.</td>
															</tr>
														</c:if>
													</c:when>
													
													  <c:when test="${statusActiveSafe == 'Approved'}">
														<c:forEach var="row" items="${EquipmentRequestlist}">
														<c:if test="${row.status_name == 'Approved'}">
															<tr>
															<td><span class="text-gray-600 fw-bold">${row.no}</span></td>
																<td><span class="text-gray-600 fw-bold">${row.mr_id}</span></td>
																<td>
																	<c:choose>
																	<c:when test="${row.item_type == 'Equipment'}">
																	     <div class="d-inline-flex align-items-center gap-2">
																		<i class="ki-duotone ki-monitor-mobile text-primary fs-1">
																		 <span class="path1"></span>
																		 <span class="path2"></span>
																		</i>
																	</c:when>
																	<c:when test="${row.item_type == 'Consumables'}">
																		<i class="ki-duotone ki-lots-shopping fs-2 text-orange"><span class="path1"></span><span class="path2"></span>
													                     <span class="path3"></span><span class="path4"></span>
													                     <span class="path5"></span><span class="path6"></span>
													                     <span class="path7"></span><span class="path8"></span>
												                     </i>
																  </c:when>
																	<c:otherwise>
																	 <i class="ki-duotone ki-parcel fs-2 text-success">
												                     <span class="path1"></span><span class="path2"></span><span class="path3"></span>
																	 <span class="path4"></span><span class="path5"></span></i>
																				</c:otherwise>
																	</c:choose>	
																<span class="text-gray-600 fw-bold">${row.item_type}</span></td>
																<td><span class="text-gray-600 fw-bold">${not empty row.product_name ? row.product_name : '-'}</span></td>
																	<td>
																	<span class="text-gray-600 fw-bold">
																	<fmt:formatNumber value="${row.quantity}" pattern="#,##0" />
																	</span>
																	</td>
																<td class="text-start"><fmt:formatDate value="${row.request_date}" pattern="d MMM yyyy, H:mm" /></td>
																<td class="text-center">
																			<span class="badge badge-success">Approved</span>
																	</td>
																<td class="text-end">
																	<div class="d-flex justify-content-end gap-2">
																	<button  data-note="btn edit" onclick="gotoeditpage(`${row.mr_id}`)" title="Edit" class="btn btn-icon btn-sm btn-light-primary">
																			<i class="ki-duotone ki-pencil fs-5">
																				<span class="path1"></span>
																				<span class="path2"></span>
																			</i>
																		</button >	
																		<button type="button"
																			class="btn btn-icon btn-sm btn-light-danger btn-delete-expense"
																			data-id="${row.mr_id}" title="Delete">
																			<i class="ki-duotone ki-trash fs-1"> <span
																				class="path1"></span><span class="path2"></span> <span
																				class="path3"></span><span class="path4"></span>
																			</i>
																		</button>
																	</div>
																</td>
															</tr>
															 </c:if>
														</c:forEach>
														<c:if test="${EquipmentRequestlist.stream().filter(row -> row.status_name == 'Approved').count() == 0}">
															<tr>
																<td colspan="7" class="text-center text-muted py-10">No
																	data.</td>
															</tr>
														</c:if>
													</c:when>

  														<c:when test="${statusActiveSafe == 'Delivered'}">
														<c:forEach var="row" items="${EquipmentRequestlist}">
														<c:if test="${row.status_name == 'Delivered'}">
															<tr>
															<td><span class="text-gray-600 fw-bold">${row.no}</span></td>
																<td><span class="text-gray-600 fw-bold">${row.mr_id}</span></td>
																<td>
																	<c:choose>
																	<c:when test="${row.item_type == 'Equipment'}">
																	     <div class="d-inline-flex align-items-center gap-2">
																		<i class="ki-duotone ki-monitor-mobile text-primary fs-1">
																		 <span class="path1"></span>
																		 <span class="path2"></span>
																		</i>
																	</c:when>
																	<c:when test="${row.item_type == 'Consumables'}">
																		<i class="ki-duotone ki-lots-shopping fs-2 text-orange"><span class="path1"></span><span class="path2"></span>
													                     <span class="path3"></span><span class="path4"></span>
													                     <span class="path5"></span><span class="path6"></span>
													                     <span class="path7"></span><span class="path8"></span>
												                     </i>
																  </c:when>
																	<c:otherwise>
																	 <i class="ki-duotone ki-parcel fs-2 text-success">
												                     <span class="path1"></span><span class="path2"></span><span class="path3"></span>
																	 <span class="path4"></span><span class="path5"></span></i>
																				</c:otherwise>
																	</c:choose>	
																<span class="text-gray-600 fw-bold">${row.item_type}</span></td>
																<td><span class="text-gray-600 fw-bold">${not empty row.product_name ? row.product_name : '-'}</span></td>
																	<td>
																	<span class="text-gray-600 fw-bold">
																	<fmt:formatNumber value="${row.quantity}" pattern="#,##0" />
																	</span>
																	</td>
																<td class="text-start"><fmt:formatDate value="${row.request_date}" pattern="d MMM yyyy, H:mm" /></td>
																<td class="text-center">
																			<span class="badge badge-cyan">Delivered</span>
																	</td>
																<td class="text-end">
																	<div class="d-flex justify-content-end gap-2">
																	<button  data-note="btn edit" onclick="gotoeditpage(`${row.mr_id}`)" title="Edit" class="btn btn-icon btn-sm btn-light-primary">
																			<i class="ki-duotone ki-pencil fs-5">
																				<span class="path1"></span>
																				<span class="path2"></span>
																			</i>
																		</button >																		
																		<button type="button"
																			class="btn btn-icon btn-sm btn-light-danger btn-delete-expense"
																			data-id="${row.mr_id}" title="Delete">
																			<i class="ki-duotone ki-trash fs-1"> <span
																				class="path1"></span><span class="path2"></span> <span
																				class="path3"></span><span class="path4"></span>
																			</i>
																		</button>
																	</div>
																</td>
															</tr>
															 </c:if>
														</c:forEach>
														<c:if test="${EquipmentRequestlist.stream().filter(row -> row.status_name == 'Delivered').count() == 0}">
															<tr>
																<td colspan="7" class="text-center text-muted py-10">No
																	data.</td>
															</tr>
														</c:if>
													</c:when>
													
														<c:when test="${statusActiveSafe == 'Rejected'}">
														<c:forEach var="row" items="${EquipmentRequestlist}">
														<c:if test="${row.status_name == 'Rejected'}">
															<tr>
															<td><span class="text-gray-600 fw-bold">${row.no}</span></td>
																<td><span class="text-gray-600 fw-bold">${row.mr_id}</span></td>
																<td>
																	<c:choose>
																	<c:when test="${row.item_type == 'Equipment'}">
																	     <div class="d-inline-flex align-items-center gap-2">
																		<i class="ki-duotone ki-monitor-mobile text-primary fs-1">
																		 <span class="path1"></span>
																		 <span class="path2"></span>
																		</i>
																	</c:when>
																	<c:when test="${row.item_type == 'Consumables'}">
																		<i class="ki-duotone ki-lots-shopping fs-2 text-orange"><span class="path1"></span><span class="path2"></span>
													                     <span class="path3"></span><span class="path4"></span>
													                     <span class="path5"></span><span class="path6"></span>
													                     <span class="path7"></span><span class="path8"></span>
												                     </i>
																  </c:when>
																	<c:otherwise>
																	 <i class="ki-duotone ki-parcel fs-2 text-success">
												                     <span class="path1"></span><span class="path2"></span><span class="path3"></span>
																	 <span class="path4"></span><span class="path5"></span></i>
																				</c:otherwise>
																	</c:choose>	
																<span class="text-gray-600 fw-bold">${row.item_type}</span></td>
																<td><span class="text-gray-600 fw-bold">
																${not empty row.product_name ? row.product_name : '-'}</span></td>
																	<td>
																	<span class="text-gray-600 fw-bold">
																	<fmt:formatNumber value="${row.quantity}" pattern="#,##0" />
																	</span>
																	</td>
																<td class="text-start"><fmt:formatDate value="${row.request_date}" pattern="d MMM yyyy, H:mm" /></td>
																<td class="text-center">
																			<span class="badge badge-danger">Rejected</span>
																	</td>
																<td class="text-end">
																	<div class="d-flex justify-content-end gap-2">
																	<button  data-note="btn edit" onclick="gotoeditpage(`${row.mr_id}`)" title="Edit" class="btn btn-icon btn-sm btn-light-primary">
																			<i class="ki-duotone ki-pencil fs-5">
																				<span class="path1"></span>
																				<span class="path2"></span>
																			</i>
																		</button >																			
																		<button type="button"
																			class="btn btn-icon btn-sm btn-light-danger btn-delete-expense"
																			data-id="${row.mr_id}" title="Delete">
																			<i class="ki-duotone ki-trash fs-1"> <span
																				class="path1"></span><span class="path2"></span> <span
																				class="path3"></span><span class="path4"></span>
																			</i>
																		</button>
																	</div>
																</td>
															</tr>
															 </c:if>
														</c:forEach>
														<c:if test="${EquipmentRequestlist.stream().filter(row -> row.status_name == 'Rejected').count() == 0}">
															<tr>
																<td colspan="7" class="text-center text-muted py-10">No
																	data.</td>
															</tr>
														</c:if>
													</c:when>
													
														<c:when test="${statusActiveSafe == 'Cancel'}">
														<c:forEach var="row" items="${EquipmentRequestlist}">
														<c:if test="${row.status_name == 'Cancel'}">
															<tr>
															<td><span class="text-gray-600 fw-bold">${row.no}</span></td>
																<td><span class="text-gray-600 fw-bold">${row.mr_id}</span></td>
																<td>
																	<c:choose>
																	<c:when test="${row.item_type == 'Equipment'}">
																	     <div class="d-inline-flex align-items-center gap-2">
																		<i class="ki-duotone ki-monitor-mobile text-primary fs-1">
																		 <span class="path1"></span>
																		 <span class="path2"></span>
																		</i>
																	</c:when>
																	<c:when test="${row.item_type == 'Consumables'}">
																		<i class="ki-duotone ki-lots-shopping fs-2 text-orange"><span class="path1"></span><span class="path2"></span>
													                     <span class="path3"></span><span class="path4"></span>
													                     <span class="path5"></span><span class="path6"></span>
													                     <span class="path7"></span><span class="path8"></span>
												                     </i>
																  </c:when>
																	<c:otherwise>
																	 <i class="ki-duotone ki-parcel fs-2 text-success">
												                     <span class="path1"></span><span class="path2"></span><span class="path3"></span>
																	 <span class="path4"></span><span class="path5"></span></i>
																				</c:otherwise>
																	</c:choose>	
																<span class="text-gray-600 fw-bold">${row.item_type}</span></td>
																<td>
																	<span class="text-gray-600 fw-bold">
																	${not empty row.product_name ? row.product_name : '-'}
																	</span>
																</td>
																	<td>
																	<span class="text-gray-600 fw-bold">
																	<fmt:formatNumber value="${row.quantity}" pattern="#,##0" />
																	</span>
																	</td>
																<td class="text-start"><fmt:formatDate value="${row.request_date}" pattern="d MMM yyyy, H:mm" /></td>
																<td class="text-center">
																			<span class="badge badge-dark">Cancel</span>
																	</td>
																<td class="text-end">
																	<div class="d-flex justify-content-end gap-2">
																	<button  data-note="btn edit" onclick="gotoeditpage(`${row.mr_id}`)" title="Edit" class="btn btn-icon btn-sm btn-light-primary">
																			<i class="ki-duotone ki-pencil fs-5">
																				<span class="path1"></span>
																				<span class="path2"></span>
																			</i>
																		</button >																	
																		<button type="button"
																			class="btn btn-icon btn-sm btn-light-danger btn-delete-expense"
																			data-id="${row.mr_id}" title="Delete">
																			<i class="ki-duotone ki-trash fs-1"> <span
																				class="path1"></span><span class="path2"></span> <span
																				class="path3"></span><span class="path4"></span>
																			</i>
																		</button>
																	</div>
																</td>
															</tr>
															 </c:if>
														</c:forEach>
														<c:if test="${EquipmentRequestlist.stream().filter(row -> row.status_name == 'Cancel').count() == 0}">
															<tr>
																<td colspan="7" class="text-center text-muted py-10">No
																	data.</td>
															</tr>
														</c:if>
													</c:when>

													<c:otherwise>
														<c:forEach var="row" items="${EquipmentRequestlist}">
															<tr>
															<td><span class="text-gray-600 fw-bold">${row.no}</span></td>
																<td><span class="text-gray-600 fw-bold">${row.mr_id}</span></td>
																<td>
																<c:choose>
																	<c:when test="${row.item_type == 'Equipment'}">
																	     <div class="d-inline-flex align-items-center gap-2">
																		<i class="ki-duotone ki-monitor-mobile text-primary fs-1">
																		 <span class="path1"></span>
																		 <span class="path2"></span>
																		</i>
																	</c:when>
																	<c:when test="${row.item_type == 'Consumables'}">
																		<i class="ki-duotone ki-lots-shopping fs-2 text-orange"><span class="path1"></span><span class="path2"></span>
													                     <span class="path3"></span><span class="path4"></span>
													                     <span class="path5"></span><span class="path6"></span>
													                     <span class="path7"></span><span class="path8"></span>
												                     </i>
																  </c:when>
																	<c:otherwise>
															 <i class="ki-duotone ki-parcel fs-2 text-success">
										                     <span class="path1"></span><span class="path2"></span><span class="path3"></span>
															 <span class="path4"></span><span class="path5"></span></i>
																		</c:otherwise>
																	</c:choose>														
																	<span class="text-gray-600 fw-bold ml-5">${row.item_type}</span>
																	</div>
																</td>
																<td>
																<span class="text-gray-600 fw-bold">${not empty row.product_name ? row.product_name : '-'}</span>
																</td>
																	<td>
																	<span class="text-gray-600 fw-bold">
																	<fmt:formatNumber value="${row.quantity}" pattern="#,##0" />
																	</span>
																	</td>
																<td class="text-start"><fmt:formatDate value="${row.request_date}" pattern="d MMM yyyy, H:mm" /></td>
																<td class="text-center"><c:choose>
																		<c:when test="${row.status_name == 'Draft'}">
																			<span class="badge badge-secondary">Draft</span>
																		</c:when>
																		<c:when test="${row.status_name == 'Approved'}">
																			<span class="badge badge-success">Approved</span>
																		</c:when>
																		<c:when test="${row.status_name == 'Pending'}">
																			<span class="badge badge-warning">Pending</span>
																		</c:when>
																		<c:when test="${row.status_name == 'Delivered'}">
																			<span class="badge badge-cyan">Delivered</span>
																		</c:when>
																		<c:when test="${row.status_name == 'Cancel'}">
																			<span class="badge badge-dark">Cancel</span>
																		</c:when>
																		<c:when test="${row.status_name == 'Rejected'}">
																			<span class="badge badge-danger">Rejected</span>
																		</c:when>
																	</c:choose></td>
																<td class="text-end">
																	<div class="d-flex justify-content-end gap-2">
																	
																	<c:if test="${onlineUser.roleId == 'admin'}">
																		<button  data-note="btn edit" onclick="gotoeditpage(`${row.mr_id}`,`${onlineUser.roleId}`)" title="Edit" class="btn btn-icon btn-sm btn-light-info">
																			<i class="ki-duotone ki-document fs-5">
																				<span class="path1"></span>
																				<span class="path2"></span>
																			</i>
																		</button >
																	</c:if>
																	
																	<c:if test="${onlineUser.roleId != 'admin'}">
																	<button  data-note="btn edit" onclick="gotoeditpage(`${row.mr_id}`,`${onlineUser.roleId}`)" title="Edit" class="btn btn-icon btn-sm btn-light-primary">
																			<i class="ki-duotone ki-pencil fs-5">
																				<span class="path1"></span>
																				<span class="path2"></span>
																			</i>
																		</button>	
																	</c:if>		
																	
																	<c:if test="${onlineUser.roleId != 'admin'}">							
																		<button type="button"
																			class="btn btn-icon btn-sm btn-light-danger btn-delete-expense"
																			data-id="${row.mr_id}" title="Delete">
																			<i class="ki-duotone ki-trash fs-1"> <span
																				class="path1"></span><span class="path2"></span> <span
																				class="path3"></span><span class="path4"></span>
																			</i>
																		</button>
																	</c:if>	
																	
																	</div>
																</td>
															</tr>
														</c:forEach>
														<c:if test="${empty EquipmentRequestlist}">
															<tr>
																<td colspan="7" class="text-center text-muted py-10">No
																	data.</td>
															</tr>
														</c:if>
													</c:otherwise>
												</c:choose>
											</tbody>
										</table>
									</div>

									<!-- Pagination -->
									<div id="paginationContainer"
										class="d-flex align-items-center justify-content-between flex-wrap mt-6">

										<div class="d-flex align-items-center gap-2">
											<select id="pageSizeSelect"
												class="form-select form-select-sm w-auto">
												<option value="25" ${pageSize == 25 ? 'selected' : ''}>25</option>
												<option value="50" ${pageSize == 50 ? 'selected' : ''}>50</option>
												<option value="100" ${pageSize == 100 ? 'selected' : ''}>100</option>
											</select>
										</div>

										<div class="d-flex align-items-center gap-1">

											<c:choose>
												<c:when test="${currentPage > 1}">
													<button type="button"
														class="btn btn-icon btn-sm btn-light pagination-link"
														data-page="${currentPage - 1}">
														<i class="ki-duotone ki-left fs-4"></i>
													</button>
												</c:when>
												<c:otherwise>
													<button type="button" class="btn btn-icon btn-sm btn-light"
														disabled>
														<i class="ki-duotone ki-left fs-4"></i>
													</button>
												</c:otherwise>
											</c:choose>

											<c:forEach begin="1" end="${totalPages}" var="i">
												<c:choose>
													<c:when
														test="${totalPages > 7 && i > 3 && i < totalPages - 2 && i != currentPage}">
														<c:if test="${i == 4}">
															<span class="btn btn-icon btn-sm btn-light disabled">...</span>
														</c:if>
													</c:when>
													<c:otherwise>
														<button type="button"
															class="btn btn-icon btn-sm pagination-link ${i == currentPage ? 'btn-primary' : 'btn-light'}"
															data-page="${i}">${i}</button>
													</c:otherwise>
												</c:choose>
											</c:forEach>

											<c:choose>
												<c:when test="${currentPage < totalPages}">
													<button type="button"
														class="btn btn-icon btn-sm btn-light pagination-link"
														data-page="${currentPage + 1}">
														<i class="ki-duotone ki-right fs-4"></i>
													</button>
												</c:when>
												<c:otherwise>
													<button type="button" class="btn btn-icon btn-sm btn-light"
														disabled>
														<i class="ki-duotone ki-right fs-4"></i>
													</button>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
<!-- 								</form> -->
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


	<!-- Modal -->
	<div class="modal fade" id="travelDetailModal" tabindex="-1"
		aria-hidden="true">
		<div
			class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
			<div class="modal-content"
				style="border-radius: 16px; border: none; box-shadow: 0 20px 60px rgba(0, 0, 0, 0.15);">

				<div class="modal-header border-0 pb-0 px-8 pt-7 mb-6">
					<h5 class="modal-title fw-bold fs-4">Travel expense</h5>
					<button type="button"
						class="btn btn-icon btn-sm btn-active-light-primary ms-2"
						data-bs-dismiss="modal">
						<i class="ki-duotone ki-cross fs-2"><span class="path1"></span><span
							class="path2"></span></i>
					</button>
				</div>

				<div class="modal-body px-8 py-6">

					<div class="row mb-10">
						<div class="col-6 d-flex align-items-start gap-5">
							<span id="m_expenseId" class="fw-bold fs-5 text-primary"></span>
							<%-- ✅ Draft ไม่มี status badge — ซ่อนถ้าว่าง --%>
							<span id="m_statusBadge" class="fs-7 fw-semibold px-3 py-2"></span>
						</div>
						<div class="col-6 d-flex align-items-center gap-3">
							<span id="m_requestDate" class="text-gray-700 fw-medium fs-6"></span>
						</div>
					</div>

					<div class="d-flex align-items-center gap-3 mb-8 rounded-2">
						<i class="ki-duotone ki-user-square fs-1"> <span class="path1"></span><span
							class="path2"></span><span class="path3"></span>
						</i> <span id="m_user" class="fw-medium text-gray-900 fs-6"></span>
					</div>

					<div class="row mb-8">
						<div class="col-6 d-flex align-items-center gap-3">
							<i class="ki-duotone ki-calendar fs-2 text-muted"> <span
								class="path1"></span><span class="path2"></span>
							</i> <span id="m_date" class="fw-semibold text-gray-800 fs-6"></span>
						</div>
						<div class="col-6 d-flex align-items-center gap-3">
							<i class="ki-duotone ki-notepad fs-2 text-muted"> <span
								class="path1"></span><span class="path2"></span> <span
								class="path3"></span><span class="path4"></span> <span
								class="path5"></span>
							</i> <span id="m_purpose" class="fw-semibold text-gray-700 fs-6"></span>
						</div>
					</div>

					<div class="row gy-8 mb-12">
						<div class="col-6">
							<div class="d-flex align-items-center gap-3">
								<i class="ki-duotone ki-geolocation fs-2 text-primary"> <span
									class="path1"></span><span class="path2"></span>
								</i>
								<div>
									<span class="text-muted fs-6">Beginning : </span> <span
										id="m_from" class="fw-semibold text-gray-800 fs-6"></span>
								</div>
							</div>
						</div>
						<div class="col-6 d-flex align-items-center gap-3">
							<i class="ki-duotone ki-time fs-2 text-muted"> <span
								class="path1"></span><span class="path2"></span>
							</i> <span id="m_timeFrom" class="fw-medium text-gray-700 fs-6"></span>
						</div>

						<div class="col-6">
							<div class="d-flex align-items-center gap-3">
								<i class="ki-duotone ki-geolocation fs-2 text-success"> <span
									class="path1"></span><span class="path2"></span>
								</i>
								<div>
									<span class="text-muted fs-6">Destination : </span> <span
										id="m_to" class="fw-medium text-gray-800 fs-6"></span>
								</div>
							</div>
						</div>
						<div class="col-6 d-flex align-items-center gap-3">
							<i class="ki-duotone ki-time fs-2 text-muted"> <span
								class="path1"></span><span class="path2"></span>
							</i> <span id="m_timeTo" class="fw-semibold text-gray-700 fs-6"></span>
						</div>
					</div>

					<div class="separator separator-dashed mb-12"></div>

					<div class="d-flex align-items-center justify-content-between mb-4">
						<span class="text-gray-700 fw-medium fs-5">Expense form</span> <span
							id="m_total" class="fw-bold fs-6 px-3 py-1 rounded"
							style="background: #E8F4FF; color: #0095E8;"></span>
					</div>

					<div id="m_expenseRows"></div>

				</div>

				<div
					class="modal-footer border-0 px-8 pb-7 pt-15 justify-content-end">
					<button type="button" class="btn btn-light btn-sm px-6 fw-medium"
						data-bs-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

	<script>
	const ctx = "${pageContext.request.contextPath}";

	const elements = {
	    form: null,
	    dateRangeEl: null,
	    statusInput: null,
	    pageInput: null,
	    tableBody: null,
	    paginationContainer: null,
	    submitButtonContainer: null,
	    selectAll: null,
	    selectedCount: null,
	    loadingOverlay: null
	};
	const urlParamsCurrent = new URLSearchParams(window.location.search);
	const state = {
	    isLoading: false,
	    currentFilters: {
	        status: "${statusActiveSafe}",
	        userSelect: "${idUserSelected}",
	        startDate: urlParamsCurrent.get('startDate') || '${param.startDate}'.trim() || "",
	        endDate: urlParamsCurrent.get('endDate') || '${param.endDate}'.trim() || "",
	        page: 1,
	        pageSize: 25
	    }
	};

	function debounce(func, wait) {
	    let timeout;
	    return function (...args) {
	        clearTimeout(timeout);
	        timeout = setTimeout(() => func(...args), wait);
	    };
	}

	function cacheElements() {
	    elements.form                  = document.getElementById('filterForm');
	    elements.statusInput           = document.querySelector('input[name="status"]');
	    elements.pageInput             = document.querySelector('input[name="page"]');
	    elements.tableBody             = document.querySelector('#kt_travel_table tbody');
	    elements.paginationContainer   = document.getElementById('paginationContainer');
	    elements.submitButtonContainer = document.getElementById('submitButtonContainer');
	    elements.selectAll             = document.getElementById('selectAll');
	    elements.selectedCount         = document.getElementById('selectedCount');
	    elements.loadingOverlay        = document.getElementById('tableLoadingOverlay');
	}

	function buildUrlParams() {
	    const params = new URLSearchParams();
	    
	    // 1. ใส่ค่าฟิลเตอร์ตัวอื่นๆ ตามปกติของระบบคุณ
	    if (state.currentFilters.status) {
	        params.append('status', state.currentFilters.status);
	    }
	    if (state.currentFilters.userSelect) {
	        params.append('userSelect', state.currentFilters.userSelect);
	    }
	    if (state.currentFilters.page) {
	        params.append('page', state.currentFilters.page);
	    }
	    if (state.currentFilters.pageSize) {
	        params.append('pageSize', state.currentFilters.pageSize);
	    }

	    // [จุดแก้ไขสำคัญ] ลบการ append('dateRange', ...) แบบเก่าออก 
	    // แล้วเปลี่ยนมาส่งเป็นสองตัวแปรนี้แทน
	    if (state.currentFilters.startDate) {
	        params.append('startDate', state.currentFilters.startDate);
	    }
	    if (state.currentFilters.endDate) {
	        params.append('endDate', state.currentFilters.endDate);
	    }

	    return params;
	}



	function showLoading() {
	    if (elements.loadingOverlay) elements.loadingOverlay.classList.add('active');
	    state.isLoading = true;
	}

	function hideLoading() {
	    if (elements.loadingOverlay) elements.loadingOverlay.classList.remove('active');
	    state.isLoading = false;
	}

	function showError(message) {
	    if (!elements.tableBody) return;
	    elements.tableBody.innerHTML =
	        '<tr><td colspan="7" class="text-center text-danger py-10">' +
	        '<div class="fw-bold">Error loading data</div>' +
	        '<div class="text-muted fs-7 mt-2">' + (message || 'An error occurred') + '</div>' +
	        '</td></tr>';
	}

	async function loadTableData() {
	    if (state.isLoading) return;
	    const params = buildUrlParams();
	    showLoading();
	    try {
	        const url = ctx + '/equipment_request_list?' + params.toString();
	        const response = await fetch(url, {
	            headers: { 'X-Requested-With': 'XMLHttpRequest' }
	        });
	        if (!response.ok) throw new Error('HTTP error! status: ' + response.status);
	        const html = await response.text();
	        updateDOM(html);
	        updateURL(params);
	    } catch (error) {
	        console.error('Error:', error);
	        showError(error.message);
	    } finally {
	        hideLoading();
	    }
	}

	function updateDOM(html) {
	    const parser = new DOMParser();
	    const doc = parser.parseFromString(html, 'text/html');
	    updateTable(doc);
	    updatePagination(doc);
	    updateSubmitArea(doc);
	    updateTabBadges(doc); 
	    updateActiveTab();
	    resetCheckboxState();
	    
	    // 🛠️ เพิ่มโค้ดล็อกค่าปฏิทินชุดนี้ไว้ที่ท้ายฟังก์ชัน updateDOM:
	    if (state.currentFilters.startDate && state.currentFilters.endDate) {
	        var freshStart = moment(state.currentFilters.startDate, 'D MMM YYYY');
	        var freshEnd   = moment(state.currentFilters.endDate, 'D MMM YYYY');
	        
	        if (freshStart.isValid() && freshEnd.isValid()) {
	            var drp = $('#kt_daterangepicker_fm').data('daterangepicker');
	            if (drp) {
	                drp.setStartDate(freshStart);
	                drp.setEndDate(freshEnd);
	            }
	            $('#kt_daterangepicker_fm').val(state.currentFilters.startDate + ' - ' + state.currentFilters.endDate);
	        }
	    }
	}


	//  Badge ของแต่ละ Status Tab
	function updateTabBadges(doc) {
	    const statuses = ['All','Draft', 'Pending', 'Cancel', 'Delivered','Approved', 'Rejected'];
	    
	    statuses.forEach(function(status) {
	     
	        const newBadge = doc.querySelector('.nav-link[data-status="' + status + '"] .badge');
	  
	        const curBadge = document.querySelector('.nav-link[data-status="' + status + '"] .badge');
	        
	        if (newBadge && curBadge) {
	         
	            curBadge.textContent = newBadge.textContent;
	        }
	    });
	}
	
	function updateTable(doc) {
	    const newTable     = doc.querySelector('#kt_travel_table');
	    const currentTable = document.querySelector('#kt_travel_table');
	    if (!newTable || !currentTable) return;

	    const newHead     = newTable.querySelector('thead');
	    const currentHead = currentTable.querySelector('thead');
	    if (newHead && currentHead) currentHead.innerHTML = newHead.innerHTML;

	    const newBody     = newTable.querySelector('tbody');
	    const currentBody = currentTable.querySelector('tbody');
	    if (newBody && currentBody) {
	        currentBody.innerHTML = newBody.innerHTML;
	        elements.tableBody = currentBody;
	    }
	}

	function updatePagination(doc) {
	    const newPag = doc.getElementById('paginationContainer');
	    const curPag = document.getElementById('paginationContainer');
	    if (!newPag || !curPag) return;
	    curPag.innerHTML = newPag.innerHTML;
	    bindPaginationEvents();
	    const pageSizeEl = document.getElementById('pageSizeSelect');
	    if (pageSizeEl) {
	        pageSizeEl.value = String(state.currentFilters.pageSize);
	        pageSizeEl.addEventListener('change', function () {
	            state.currentFilters.pageSize = parseInt(this.value) || 25;
	            state.currentFilters.page = 1;
	            loadTableData();
	        });
	    }
	}

	function updateSubmitArea(doc) {
	    const newArea = doc.getElementById('submitButtonContainer');
	    const curArea = document.getElementById('submitButtonContainer');
	    if (!newArea || !curArea) return;
	    curArea.className = newArea.className;
	    curArea.innerHTML = newArea.innerHTML;
	    elements.submitButtonContainer = curArea;
	    elements.selectedCount = document.getElementById('selectedCount');
	}

	function updateActiveTab() {
	    document.querySelectorAll('.nav-link[data-status]').forEach(link => {
	        link.classList.toggle('active', link.getAttribute('data-status') === state.currentFilters.status);
	    });
	}

	function updateURL(params) {
	    const newUrl = ctx + '/equipment_request_list?' + params.toString();
	    history.pushState({ path: newUrl }, '', newUrl);
	}

	function bindPaginationEvents() {
	    document.querySelectorAll('.pagination-link').forEach(link => {
	        link.addEventListener('click', function (e) {
	            e.preventDefault();
	            const page = parseInt(this.getAttribute('data-page'), 10);
	            if (!isNaN(page)) {
	                state.currentFilters.page = page;
	                if (elements.pageInput) elements.pageInput.value = page;
	                loadTableData();
	            }
	        });
	    });
	}

	function bindStatusTabs() {
	    document.querySelectorAll('.nav-link[data-status]').forEach(tab => {
	        tab.addEventListener('click', function (e) {
	            e.preventDefault();
	            state.currentFilters.status = this.getAttribute('data-status');
	            state.currentFilters.page = 1;
	            if (elements.statusInput) elements.statusInput.value = state.currentFilters.status;
	            if (elements.pageInput)   elements.pageInput.value   = 1;
	            loadTableData();
	        });
	    });
	}

	function bindDateRangeFilter() {
	    var currentYear = new Date().getFullYear();

	    // ดึงค่าเริ่มต้นจากที่ Java ส่งมา หรือค่าบน URL ถ้าไม่มีให้ใช้ 1 ม.ค. - 31 ธ.ค. ปีปัจจุบัน
	    var startStr = state.currentFilters.startDate || ('1 Jan ' + currentYear);
	    var endStr   = state.currentFilters.endDate   || ('31 Dec ' + currentYear);

	    var fmStart = moment(startStr, 'D MMM YYYY');
	    var fmEnd   = moment(endStr, 'D MMM YYYY');

	    if (!fmStart.isValid() || !fmEnd.isValid()) {
	        fmStart = moment().startOf('year');
	        fmEnd = moment().endOf('year');
	    }

	    state.currentFilters.startDate = fmStart.format('D MMM YYYY');
	    state.currentFilters.endDate   = fmEnd.format('D MMM YYYY');

	    // ผูก daterangepicker
	    $('#kt_daterangepicker_fm').daterangepicker({
	        startDate : fmStart,
	        endDate : fmEnd,
	        showDropdowns: true,
	        locale : { format : 'D MMM YYYY' },
	        ranges : {
	            'Today' : [ moment(), moment() ],
	            'Yesterday' : [ moment().subtract(1, 'days'), moment().subtract(1, 'days') ],
	            'Last 7 Days' : [ moment().subtract(6, 'days'), moment() ],
	            'Last 30 Days' : [ moment().subtract(29, 'days'), moment() ],
	            'This Month' : [ moment().startOf('month'), moment().endOf('month') ],
	            'Last Month' : [ moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month') ],
	            'This Year' : [ moment().startOf('year'), moment().endOf('year') ],
	            'Last Year' : [ moment().subtract(1, 'year').startOf('year'), moment().subtract(1, 'year').endOf('year') ]
	        }
	    }, function(start, end) {
	        fmCb(start, end);
	    });

	    // เซ็ตข้อความหน้ากล่องปฏิทินตอนโหลดหน้าเว็บครั้งแรก
	    $('#kt_daterangepicker_fm').val(fmStart.format('D MMM YYYY') + ' - ' + fmEnd.format('D MMM YYYY'));

	    // 🛠️ แก้ไขท่อนนี้: ดักจับเหตุการณ์การเลือกเสร็จสิ้น แล้วสั่งเปลี่ยนตารางทันที
	    $('#kt_daterangepicker_fm').off('apply.daterangepicker').on('apply.daterangepicker', function(ev, picker) {
	        const selectedStart = picker.startDate.format('D MMM YYYY');
	        const selectedEnd   = picker.endDate.format('D MMM YYYY');

	        // แสดงผลบนหน้าจอ
	        $('#kt_daterangepicker_fm').val(selectedStart + ' - ' + selectedEnd);
	        
	        // อัปเดตข้อมูลเข้าไปในหน่วยความจำ state
	        state.currentFilters.startDate = selectedStart;
	        state.currentFilters.endDate   = selectedEnd;
	        
	        // สั่งอัปเดตตารางผ่าน Ajax ทันที
	        state.currentFilters.page = 1; 
	        loadTableData();
	    });
	}


	function updateSelectedCount() {
	    if (!elements.selectedCount) return;
	    elements.selectedCount.textContent = document.querySelectorAll('.row-checkbox:checked').length;
	}
	
	function updateSubmitButtonState() {
	    const btn = document.getElementById('btn-submit-request');
	    if (!btn) return;

	    const checkedCount = document.querySelectorAll('.row-checkbox:checked').length;

	    btn.disabled = checkedCount === 0;
	}

	function handleSelectAllChange() {
	    const selectAll = document.getElementById('selectAll');
	    if (!selectAll) return;
	    document.querySelectorAll('.row-checkbox').forEach(cb => cb.checked = selectAll.checked);
	    updateSelectedCount();
	    updateSubmitButtonState();
	}

	function handleRowCheckboxChange() {
	    const selectAll = document.getElementById('selectAll');
	    if (!selectAll) return;
	    const all     = document.querySelectorAll('.row-checkbox');
	    const checked = document.querySelectorAll('.row-checkbox:checked');
	    selectAll.checked = (all.length > 0 && checked.length === all.length);
	    updateSelectedCount();
	    updateSubmitButtonState();
	}

	function resetCheckboxState() {
	    const selectedCount = document.getElementById('selectedCount');
	    if (selectedCount) selectedCount.textContent = '0';
	    const selectAll = document.getElementById('selectAll');
	    if (selectAll) {
	        selectAll.checked = false;
	        selectAll.removeEventListener('change', handleSelectAllChange);
	        selectAll.addEventListener('change', handleSelectAllChange);
	    }
	    
	    updateSubmitButtonState();
	}

	function initModal() {
	    const modalEl = document.getElementById('travelDetailModal');
	    if (!modalEl) return;
	    const modal = new bootstrap.Modal(modalEl);

	    document.addEventListener('click', function (e) {
	        const btn = e.target.closest('.btn-open-modal');
	        if (!btn) return;
	        const id = btn.getAttribute('data-expense-id');
	        if (!id) return;
	        const src = document.querySelector('#modalDataStore .modal-data-item[data-id="' + id + '"]');
	        if (!src) return;
	        fillModal(src);
	        modal.show();
	    });
	}

	function fillModal(src) {
	    function txt(cls) {
	        const el = src.querySelector('.' + cls);
	        return el ? el.textContent.trim() : '-';
	    }
	    function set(id, val) {
	        const el = document.getElementById(id);
	        if (el) el.textContent = val || '-';
	    }

	    set('m_expenseId',   '#' + txt('md-expense-id'));
	    set('m_requestDate', 'Request by: ' + txt('md-request-date'));
	    set('m_user',        txt('md-user'));
	    set('m_date',        txt('md-date'));
	    set('m_purpose',     txt('md-purpose'));
	    set('m_from',        txt('md-from'));
	    set('m_to',          txt('md-to'));
	    set('m_timeFrom',    txt('md-time-from'));
	    set('m_timeTo',      txt('md-time-to'));
	    set('m_total',       txt('md-amount') + ' บาท');

	    const statusMap = {
	        'Pending': { label: 'Waiting',  cls: 'badge-warning' },
	        'Cancel': { label: 'Cancel', cls: 'badge-dark'            },
	        'Approved': { label: 'Approved', cls: 'badge-success'           },
	        'Delivered': { label: 'Delivered', cls: 'bg-cyan'           },
	        'Rejected': { label: 'Rejected', cls: 'badge-danger'            }
	    };
	    const sid   = txt('md-status-id');
	    const badge = document.getElementById('m_statusBadge');
	    if (badge) {
	        if (sid && statusMap[sid]) {
	            const sm = statusMap[sid];
	            badge.className   = 'badge fs-8 fw-semibold px-3 py-2 ' + sm.cls;
	            badge.textContent = sm.label;
	        } else {
	            badge.className   = '';
	            badge.textContent = '';
	        }
	    }

	    const rowsEl = document.getElementById('m_expenseRows');
	    if (!rowsEl) return;
	    rowsEl.innerHTML = '';

	    src.querySelectorAll('.md-detail-row').forEach(function (det) {
	        const typeName  = det.getAttribute('data-type')  || '-';
	        const desc      = det.getAttribute('data-desc')  || '-';
	        const total     = det.getAttribute('data-total') || '0';
	        const num       = parseFloat(total);
	        const formatted = isNaN(num) ? total
	            : num.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 });

	        const row = document.createElement('div');
	        row.className = 'd-flex align-items-center justify-content-between py-3 mb-3';
	        row.innerHTML =
	            '<div class="d-flex align-items-center gap-3" style="flex:1;">' +
	                '<i class="ki-duotone ki-car fs-3"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i>' +
	                '<span class="fw-semibold text-gray-800 fs-7">' + typeName + '</span>' +
	            '</div>' +
	            '<div class="d-flex align-items-center gap-3" style="flex:1;">' +
	                '<i class="ki-duotone ki-message-text fs-3 text-muted"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i>' +
	                '<span class="text-gray-600 fs-7">' + desc + '</span>' +
	            '</div>' +
	            '<div class="fw-bold text-gray-800 fs-7 text-nowrap">' + formatted + ' บาท</div>';

	        rowsEl.appendChild(row);
	    });
	}

	//  ============ Delete Expense (Draft only) ============
	function initDeleteExpense() {
	    document.addEventListener('click', function (e) {
	        const btn = e.target.closest('.btn-delete-expense');
	        if (!btn) return;

	        const expenseId = btn.getAttribute('data-id');
	        if (!expenseId) return;

	        Swal.fire({
	            title: 'ลบรายการนี้?',
	            html: 'Expense <strong>#' + expenseId + '</strong> ',
	            icon: 'warning',
	            showCancelButton: true,
	            confirmButtonText: 'ลบ',
	            cancelButtonText: 'ยกเลิก',
	            confirmButtonColor: '#F64E60',
	            reverseButtons: true
	        }).then(function (result) {
	            if (!result.isConfirmed) return;

	            // แสดง loading บน button ระหว่างรอ
	            btn.disabled = true;
	            btn.innerHTML = '<span class="spinner-border spinner-border-sm"></span>';

	            fetch(ctx + '/equipment_request_listdelete?id=' + expenseId, {
	                method: 'POST',
	                headers: { 'X-Requested-With': 'XMLHttpRequest' }
	            })
	            .then(function (res) { return res.json(); })
	            .then(function (data) {
	                if (data.success) {
	                    Swal.fire({
	                        icon: 'success',
	                        title: 'ลบแล้ว',
	                        text: 'Expense #' + expenseId + ' ถูกลบเรียบร้อย',
	                        timer: 1500,
	                        showConfirmButton: false
	                    }).then(function () {
	                        loadTableData(); // โหลด table ใหม่ ไม่ reload หน้า
	                    });
	                } else {
	                    // คืนค่า icon ให้ button
	                    btn.disabled = false;
	                    btn.innerHTML =
	                        '<i class="ki-duotone ki-trash fs-1">' +
	                        '<span class="path1"></span><span class="path2"></span>' +
	                        '<span class="path3"></span><span class="path4"></span></i>';
	                    Swal.fire({
	                        icon: 'error',
	                        title: 'ไม่สามารถลบได้',
	                        text: data.message || 'เกิดข้อผิดพลาด'
	                    });
	                }
	            })
	            .catch(function (err) {
	                console.error('Delete error:', err);
	                btn.disabled = false;
	                btn.innerHTML =
	                    '<i class="ki-duotone ki-trash fs-1">' +
	                    '<span class="path1"></span><span class="path2"></span>' +
	                    '<span class="path3"></span><span class="path4"></span></i>';
	                Swal.fire({
	                    icon: 'error',
	                    title: 'Network error',
	                    text: 'กรุณาลองใหม่อีกครั้ง'
	                });
	            });
	        });
	    });
	}

	function initBrowserNavigation() {
	    window.addEventListener('popstate', function (e) {
	        if (e.state && e.state.path) location.reload();
	    });
	}
	
	function gotoeditpage(id,role){
		if(role == 'admin'){
			window.location.replace("equipment_request_admin?id="+id);
		}else{
			window.location.replace("equipment_request_update?id="+id);
		}
	}

	document.addEventListener('DOMContentLoaded', function () {
	    cacheElements();

	    // 📅 1. ปรับปรุงระบบคัดกรองวันที่เริ่มต้น-สิ้นสุด แบบใหม่
	    var currentYear = new Date().getFullYear();
	    
	    // ดึงค่าจาก Parameter ของ URL หรือฝั่ง Server 
	    var paramStart = "${param.startDate}".trim();
	    var paramEnd   = "${param.endDate}".trim();

	    if (paramStart && paramEnd) {
	        // ถ้าหน้าเว็บส่งค่าเก่ามา ให้เก็บค่านั้นไว้ใน state ตัวใหม่
	        state.currentFilters.startDate = paramStart;
	        state.currentFilters.endDate   = paramEnd;
	    } else {
	        // 💡 ถ้าเปิดมาครั้งแรก (ค่าว่าง) ให้เซ็ต Default เป็น 1 Jan ของปีปัจจุบัน ถึง 31 Dec ของปีปัจจุบัน
	        state.currentFilters.startDate = '1 Jan ' + currentYear;
	        state.currentFilters.endDate   = '31 Dec ' + currentYear;
	    }

	    // (หลังจากจุดนี้ ใช้โค้ดส่วนอื่นเดิมของคุณได้ทั้งหมด)
	    const pageSizeEl = document.getElementById('pageSizeSelect');
	    if (pageSizeEl) {
	        state.currentFilters.pageSize = parseInt(pageSizeEl.value) || 25;
	        pageSizeEl.addEventListener('change', function () {
	            state.currentFilters.pageSize = parseInt(this.value) || 25;
	            state.currentFilters.page = 1;
	            if (elements.pageInput) elements.pageInput.value = 1;
	            loadTableData();
	        });
	    }

	    bindStatusTabs();
	    bindDateRangeFilter(); 
	    bindPaginationEvents();

	    const selectAll = document.getElementById('selectAll');
	    if (selectAll) selectAll.addEventListener('change', handleSelectAllChange);

	    document.addEventListener('change', function (e) {
	        if (e.target && e.target.classList.contains('row-checkbox')) {
	            handleRowCheckboxChange();
	        }
	    });

	    initModal();
	    initDeleteExpense(); 
	    initBrowserNavigation();
	    updateSelectedCount();

	    loadTableData();
	});

	
	function fmCb(start, end) {
	    if(start && end) {
	        $('#kt_daterangepicker_fm').val(start.format('D MMM YYYY') + ' - ' + end.format('D MMM YYYY'));
	    }
	}
	
	function reloadList() {
		var picker = $('#kt_daterangepicker_fm').data('daterangepicker');
	}
	
	var serverStartDate = '${startDate}';
	var serverEndDate = '${endDate}';
	
	var currentYear = new Date().getFullYear();
	var fmStart = (serverStartDate && serverStartDate.trim().length > 0) ? moment(serverStartDate, 'D MMM YYYY') : moment('1 Jan ' + currentYear, 'D MMM YYYY');
	var fmEnd   = (serverEndDate && serverEndDate.trim().length > 0) ? moment(serverEndDate, 'D MMM YYYY') : moment('31 Dec ' + currentYear, 'D MMM YYYY');

	$(document).ready(function() {
		
		<perm:permission object="admin">
		$('#btn_create').attr('style', 'display: none !important')       
		</perm:permission>
		
		
		if ($('#kt_daterangepicker_fm').data('daterangepicker')) {
			$('#kt_daterangepicker_fm').data('daterangepicker').remove();
		}
		
		$('#kt_daterangepicker_fm').daterangepicker({
			startDate : fmStart,
			endDate : fmEnd,
			showDropdowns: true,
			locale : { format : 'D MMM YYYY' },
			ranges : {
				'Today' : [ moment(), moment() ],
				'Yesterday' : [ moment().subtract(1, 'days'), moment().subtract(1, 'days') ],
				'Last 7 Days' : [ moment().subtract(6, 'days'), moment() ],
				'Last 30 Days' : [ moment().subtract(29, 'days'), moment() ],
				'This Month' : [ moment().startOf('month'), moment().endOf('month') ],
				'Last Month' : [ moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month') ],
				'This Year' : [ moment().startOf('year'), moment().endOf('year') ],
				'Last Year' : [ moment().subtract(1, 'year').startOf('year'), moment().subtract(1, 'year').endOf('year') ]
			}
		}, fmCb);
		
		fmCb(fmStart, fmEnd);
		
		
		
		// เก็บออปชันเริ่มต้นของหน้าจอไว้เป็นก้อนพิมพ์เขียว (ไม่ให้ข้อมูลจริงโดนลบ)
		var originalOptionsHtml = $('#userSelect').html();

		// ฟังก์ชันสำหรับสั่งเริ่มต้นเปิดใช้งาน Select2 ใหม่ทุกครั้งที่มีการล้างกระดาน
		function initUserSelect2() {
		    $('#userSelect').select2({
		        placeholder: "ค้นหา...",
		        allowClear: true,
		        width: '100%',
		        tags: true,
		        createTag: function (params) {
		            var term = $.trim(params.term);
		            if (term === '') return null;
		            return { id: term, text: term, newTag: true }
		        }
		    });
		}

		// ฟังก์ชันศูนย์กลางสำหรับส่งค่าไปกรองตารางด้วย Ajax
		function handleSmartSearchUpdate(value) {
		    var currentValue = value || "";
		    if (typeof state !== 'undefined' && state.currentFilters) {
		        state.currentFilters.userSelect = currentValue;
		        state.currentFilters.page = 1;
		        if (typeof loadTableData === 'function') {
		            loadTableData();
		        }
		    }
		    console.log('Smart search triggered lookup with value:', currentValue);
		}

		// เรียกใช้งาน Select2 ครั้งแรกตอนโหลดหน้าเว็บ
		initUserSelect2();

		// 1. นำค่าเก่าจากฐานข้อมูลมายัดคืนใส่ช่องตอนเปิดหน้าเว็บครั้งแรก
		var previousSelectedValue = "${idUserSelected}";
		if (previousSelectedValue && previousSelectedValue.trim() !== '' && previousSelectedValue !== 'null') {
		    $('#userSelect').off('change'); 
		    if ($('#userSelect').find("option[value='" + previousSelectedValue + "']").length === 0) {
		        var newOption = new Option(previousSelectedValue, previousSelectedValue, true, true);
		        $('#userSelect').append(newOption);
		    } else {
		        $('#userSelect').val(previousSelectedValue);
		    }
		    $('#userSelect').trigger('change.select2');
		}

		// 2. ดักจับเหตุการณ์เมื่อผู้ใช้คลิกเลือกหรือสลับตัวเลือก
		$('#userSelect').off('change').on('change', function() {
		    var currentValue = $(this).val() || "";
		    handleSmartSearchUpdate(currentValue);
		});	

		// 3. 🛠️ [แก้บัคเคลียร์ค่า] ดักจับทั้งปุ่มกากบาท "x" และปุ่ม Clear ใหญ่ของระบบ
		$('#userSelect').on('select2:clearing', function (e) {
		    e.preventDefault(); // สกัดกั้นกลไกเดิมที่ทำให้ค่าค้าง
		    
		    // ทำลายสแตทเก่า ยัดโครงสร้าง HTML ดั้งเดิมกลับเข้าไป แล้วชุบชีวิต Select2 ขึ้นมาใหม่
		    $('#userSelect').select2('destroy').html(originalOptionsHtml).val(null);
		    initUserSelect2();
		    
		    // สั่งให้ตารางโหลดข้อมูลกลับมาทั้งหมด
		    handleSmartSearchUpdate(""); 
		    console.log('ล้างกล่องข้อความและคืนค่ารายการ Dropdown เรียบร้อยแล้ว');
		});

		// 4. ดักจับเมื่อผู้ใช้งานพิมพ์ข้อความเสร็จแล้วกดปุ่ม "Enter" 
		$('#userSelect').off('keydown').on('keydown', function(e) {
		    if (e.key === "Enter" || e.keyCode === 13) {
		        e.preventDefault();
		        var currentValue = $(this).val() || "";
		        handleSmartSearchUpdate(currentValue);
		    }
		});




	    	    //  [แก้ไขจุดที่ 3] ดักจับแถบเลือกวันที่ เมื่อเปลี่ยนค่าให้สั่งเปลี่ยนข้อมูลในตารางแบบ Pure Ajax ไม่รีโหลดหน้า
	    	    $('#kt_daterangepicker_fm').off('apply.daterangepicker').on('apply.daterangepicker', function(ev, picker) {
	    	        const selectedStart = picker.startDate.format('D MMM YYYY');
	    	        const selectedEnd   = picker.endDate.format('D MMM YYYY');

	    	        // อัปเดตข้อความบนหน้าจออินพุต
	    	        $('#kt_daterangepicker_fm').val(selectedStart + ' - ' + selectedEnd);
	    	        
	    	        // อัปเดตค่าลงหน่วยความจำส่วนกลาง (state)
	    	        if (typeof state !== 'undefined') {
	    	            state.currentFilters.startDate = selectedStart;
	    	            state.currentFilters.endDate   = selectedEnd;
	    	            state.currentFilters.page = 1;
	    	            
	    	            // สั่งอัปเดตตารางข้อมูลผ่าน Ajax ทันที
	    	            if (typeof loadTableData === 'function') {
	    	                console.log('Date changed, loading table data via Ajax...');
	    	                loadTableData();
	    	            }
	    	        }
	    	    });

	});
	</script>
</body>
</html>