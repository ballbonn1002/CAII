<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/permission.tld" prefix="perm"%>
<fmt:setLocale value="en_US" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link
	href="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.css"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/assets/css/style.bundle.css"
	rel="stylesheet" />

<script
	src="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.js"></script>
<script
	src="${pageContext.request.contextPath}/assets/js/scripts.bundle.js"></script>
<link
	href="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.css"
	rel="stylesheet" type="text/css" />
<script
	src="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.js"></script>
<script src="https://cdn.jsdelivr.net/npm/signature_pad@4.1.7/dist/signature_pad.umd.min.js"></script>

<style>
/* Table MR */
[data-bs-theme="light"] #mrResultTable.table.table-striped > tbody > tr:nth-of-type(odd) > * {
    background-color: #FBFBFB !important; 
    box-shadow: none !important;
  }
 [data-bs-theme="dark"] #mrResultTable.table.table-striped > tbody > tr:nth-of-type(odd) > * {
    background-color: #191B20 !important; 
    box-shadow: none !important;
  }

#mrResultTable thead th {
	white-space: nowrap !important;
	position: relative !important;
	padding-right: 35px !important;
	cursor: pointer;
}

#mrResultTable thead th.sorting:after, #mrResultTable thead th.sorting_asc:after,
#mrResultTable thead th.sorting_desc:after, #mrResultTable thead th.sorting:before,	
#mrResultTable thead th.sorting_asc:before, #mrResultTable thead th.sorting_desc:before
	{
	position: absolute !important;
	top: 10px !important;
	right: 10px !important;
	display: block !important;
	opacity: 0.5;
}

#mrResultTable thead th.sorting:before {
	margin-top: -6px;
}

#mrResultTable thead th.sorting:after {
	margin-top: 4px;
}

#mrResultTable thead th:first-child, th:last-child {
    padding-right: 0 !important;
}

#mrResultTable thead th:last-child {
    text-align: right !important;
    padding-right: 0 !important;
}


.text-orange{
	color: #FD7E14 ;
}
.btn-cyan{
	background-color: #0DCAF0 !important;
}


/* ===== Signature Box ===== */
.sig-box {
	width: 100%;
	height: 200px;
	border-radius: 10px;
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	position: relative;
	overflow: hidden;
}

.sig-box.locked {
	border: 2px solid #E4E6EF;
	background: #F9F9F9;
	cursor: default;
}

.sig-box.uploadable {
	border: 2px dashed #C9D0E0;
	background: #FAFAFA;
	cursor: pointer;
}

.sig-box.uploadable:hover {
	border-color: #009EF7;
	background: #F0FAFF;
}

.sig-box.unuploadable {
	border: 2px dashed #C9D0E0;
	background: #FAFAFA;
}

.sig-lock-badge {
	position: absolute;
	top: 6px;
	right: 8px;
	font-size: .7rem;
	color: #A1A5B7;
	display: flex;
	align-items: center;
	gap: 3px;
}
</style>

</head>
<body class="app-default">
<input type="hidden" id="hasSignature" value="${not empty imgPathSignature}" />
	<div class="app-main flex-column flex-row-fluid">
		<div class="d-flex flex-column flex-column-fluid">
			<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
				<div id="kt_app_toolbar_container" class="app-container container-fluid d-flex flex-stack">
				
					<div class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
						<h1 class="page-heading d-flex text-gray-700 fw-semibold flex-column justify-content-center my-0">
							Edit PO - Purchase Order
						</h1>
						<ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
							<li class="breadcrumb-item text-muted"><a class="text-muted text-hover-primary">Home</a></li>
							<li class="breadcrumb-item"><span class="bullet bg-gray-500 w-5px h-2px"></span></li>
							<li class="breadcrumb-item text-muted"><a class="text-muted text-hover-primary">Product</a></li>
						</ul>
					</div>
			
					<div class="d-flex align-items-center gap-2">
						<span class="fs-2hx text-primary fw-bold" id="">#${poList.poId}</span>
							<c:choose >
								<c:when test="${poList.status == '0'}">
									<span class="badge badge-lg bg-light-secondary fw-semibold fs-7">Draft</span>
								</c:when>
								<c:when test="${poList.status == '2'}">
									<span class="badge badge-lg badge-warning fw-semibold fs-7">Pending</span>
								</c:when>
								<c:when test="${poList.status == '5'}">
									<span class="badge badge-lg bg-success fw-semibold fs-7">Approved</span>
								</c:when>
								<c:when test="${poList.status == '1'}">
									<span class="badge badge-lg bg-cyan text-white fw-semibold fs-7">In-Progress</span>
								</c:when>
								<c:when test="${poList.status == '3'}">
									<span class="badge badge-lg badge-info fw-semibold fs-7">Return</span>
								</c:when>
								<c:when test="${poList.status == 'C'}">
									<span class="badge badge-lg bg-danger fw-semibold fs-7">Rejected</span>
								</c:when>
								<c:when test="${poList.status == 'T'}">
									<span class="badge badge-lg bg-dark fw-semibold fs-7">Closed</span>
								</c:when>
								<c:otherwise>
									<span class="badge badge-lg bg-light-secondary fw-semibold fs-7">-</span>
								</c:otherwise>
							</c:choose> 
						
						<!-- <span class="badge badge-lg bg-light-secondary fw-semibold fs-7">Draft</span> -->
					</div>
			
				</div>
			</div>
			
			<div id="kt_app_content" class="app-content flex-column-fluid">
				<div id="kt_app_content_container" class="app-container container-fluid">
					<div class="card mb-10">
						<div class="card-header border-0 px-9 pt-7 d-flex align-items-center justify-content-between">
							<div class="card-title">
								<h3 class="fw-semibold text-gray-900">PO - Header</h3>
							</div>
						</div>
						<div class="card-body filter-card px-10 py-9 rounded-3">
							<div class="row g-5">
								<div class="col-lg-6 col-md-6 col-12 d-flex align-items-center">
									<i class="ki-duotone ki-user-tick fs-3 me-3">
										 <span class="path1"></span>
										 <span class="path2"></span>
										 <span class="path3"></span>
									</i>
									<span class="fs-6 fw-bold text-gray-800">${empty loginUser.employeeId ? '' : loginUser.employeeId} - ${empty loginUser.nameEN ? loginUser.name : loginUser.nameEN}</span>
									<%-- <span class="fs-6 fw-bold text-gray-800">${empty user.employeeId ? '' : user.employeeId} - ${empty user.nameEN ? 'user.name' : user.nameEN}</span> --%>
								</div>
								
								<div class="col-lg-6 col-md-6 col-12 d-flex align-items-center">
									<i class="ki-duotone ki-calendar-2 fs-3 me-3">
										 <span class="path1"></span>
										 <span class="path2"></span>
										 <span class="path3"></span>
										 <span class="path4"></span>
 										 <span class="path5"></span>
									</i>
									<span class="fs-6 fw-medium text-gray-800"><fmt:formatDate value="${poList.timeCreate}" pattern="d MMM yyyy, HH:mm" /></span>
								</div>
								
								<div class="col-12 mt-9">
									<label class="required fw-medium text-gray-800 mb-2">Description</label>
									<textarea class="form-control text-gray-700" id="description" name="description"
										placeholder="Description" rows="3">${empty poList.description ? '' : fn:escapeXml(poList.description)}</textarea>
								</div>
							</div>
						</div>
					</div>
					
					<div class="card mb-10">
						<div class="card-header border-0 px-9 pt-7 d-flex align-items-center justify-content-between">
							<div class="card-title">
								<h3 class="fw-semibold text-gray-900">Vendor</h3>
							</div>
						</div>
						<div class="card-body filter-card px-10 py-9 rounded-3">
							<div class="row g-5 mb-6">
								<div class="col-lg-6 col-md-6 col-12 d-flex flex-column">
									<label class="fw-medium text-gray-800 mb-2">Reference Invoice/Quotation NO</label>
									<input type="text" class="form-control text-gray-700 h-45px"
											placeholder="Reference Invoice/Quotation NO" name="reference_no"
											id="reference_no" value="${empty poList.refNo ? '' : poList.refNo}" />
								</div>
								
								<div class="col-lg-6 col-md-6 col-12 d-flex flex-column">
									<label class="fw-medium text-gray-800 mb-2">Reference Invoice/Quotation Date</label>
									<div class="position-relative d-flex align-items-center">
										<i class="ki-duotone ki-calendar-8 position-absolute ms-4 mb-1 text-gray-500 fs-3">
											<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span>
										</i>
										<%-- <input class="form-control text-gray-700 ps-12 h-45px" 
											   id="kt_reference_datepicker" name="reference_date" placeholder="Select date" 
											   value="<fmt:formatDate value="${poList.refDate}" pattern="d MMM yyyy" />"/> --%>
										<input class="form-control text-gray-700 ps-12 h-45px" 
										       id="kt_reference_datepicker" name="reference_date" placeholder="Select date" 
										       value="<fmt:formatDate value="${poList.refDate}" pattern="d MMM yyyy" />"/>
										<input type="hidden" id="poRefDateRaw" value="<fmt:formatDate value="${poList.refDate}" pattern="yyyy-MM-dd" />" />
									</div>
								</div>
							</div>
					
							<div class="row g-5 mb-6">
								
									<div class="col-lg-6 col-md-6 col-12 d-flex flex-column">
										<div class="d-flex justify-content-between align-items-center mb-2">
											<label class="required fw-medium text-gray-800">Company Name</label>
											<!-- <a href="#" class="text-success fw-medium fs-7 text-hover-primary" style="text-decoration: none;">
												<i class="ki-outline ki-plus fs-7 text-success me-1"></i>Create
											</a> -->
										</div>
										<select name="vendor_id" id="vendor_id" class="form-select h-45px" data-control="select2" data-placeholder="Select Company Name">
										    <option value=""></option>
										    <c:forEach var="company" items="${companyAll}">
										        <option value="${company.company_id}"
										            <c:if test="${company.company_id == poList.companyId}">selected</c:if>>
										            ${company.company_en}
										        </option>
										    </c:forEach>
										</select>
										
										<input type="hidden" id="poVendorLocationId" value="${empty poList.companyLocation ? '' : poList.companyLocation}" />
										<input type="hidden" id="poContactId" value="${empty poList.contactId ? '' : poList.contactId}" />
											<div id="companyTaxInfo" class="d-flex align-items-center text-gray-500 fs-7 mt-3 px-1 d-none">
												<i class="ki-duotone ki-credit-cart fs-3 me-2 text-muted"><span class="path1"></span><span class="path2"></span></i>
												<span class="fs-6 fw-normal text-gray-800">Tax ID : <span id="companyTaxNumber"></span></span>
											</div>
									</div>
						
								<div class="col-lg-6 col-md-6 col-12 d-flex flex-column">
									<label class="required fw-medium text-gray-800 mb-2">Company Location</label>
									<select name="vendor_location_right_id" id="vendor_location_id" class="form-select h-45px" data-control="select2" data-placeholder="Select Company Location" disabled>
									   <option value=""></option>
									</select>
									
									<div id="companyAddressInfo" class="d-flex align-items-center text-gray-500 fs-7 mt-3 px-1 d-none">
										<i class="ki-duotone ki-map fs-3 me-2 text-muted"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i>
										<span class="fs-6 fw-normal text-gray-800" id="companyAddress"></span>
									</div>
								</div>
							</div>
					
							<div class="row g-5 mb-6">		
								<div class="col-lg-6 col-md-6 col-12 d-flex flex-column">
									<div class="d-flex justify-content-between align-items-center mb-2">
										<label class="required fw-medium text-gray-800">Contact Name</label>
										<!-- <a href="#" class="text-success fw-medium fs-7 text-hover-primary" style="text-decoration: none;">
											<i class="ki-outline ki-plus fs-7 me-1 text-success"></i>Create
										</a> -->
									</div>
									<select name="contact_id" id="contact_id" class="form-select h-45px" data-control="select2" data-placeholder="Select Contact Name" disabled>
										<option value=""></option>
									</select>
									
									<div id="contactInfo" class="d-flex flex-column gap-1 mt-3 px-1 d-none">
										<div class="d-flex align-items-center text-gray-500 fs-7">
											<i class="ki-duotone ki-address-book fs-3 me-2 text-muted"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i>
											<span class="fs-6 fw-normal text-gray-800" id="contactPhone"></span>
										</div>
										<div class="d-flex align-items-center text-gray-500 fs-7">
											<i class="ki-duotone ki-sms fs-3 me-2 text-muted"><span class="path1"></span><span class="path2"></span></i>
											<span class="fs-6 fw-normal text-gray-800" id="contactEmail"></span>
										</div>
									</div>
								</div>
								
								<div class="col-lg-6 col-md-6 col-12 d-flex flex-column">
									<label class="fw-medium text-gray-800 mb-2">Description</label>
									<textarea class="form-control text-gray-700" rows="3" name="vendor_description" id="vendor_description" placeholder="Description"></textarea>
								</div>
							</div>
						</div>
					</div>
					
					<div class="card mb-10">
						<div class="card-header border-0 px-9 pt-7 d-flex align-items-center justify-content-between">
					        <div class="card-title">
					            <h3 class="fw-semibold text-gray-900">PO - Detail</h3>
					        </div>
					        <div class="card-title gap-3">
						         <button type="button" class="btn btn-lg btn-success fw-medium text-white px-6 py-4" data-bs-toggle="modal" data-bs-target="#modal_create_po">
									<i class="ki-outline ki-plus fs-3 me-1"></i>Create
								</button>
								
								<button type="button" class="btn btn-lg btn-primary fw-medium text-white px-6 py-4" data-bs-toggle="modal" data-bs-target="#modal_search_mr">
									<i class="ki-duotone ki-magnifier fs-3 me-1">
						                <span class="path1"></span><span class="path2"></span></i>Search MR
								</button>
					            
					        </div>
					    </div>
						<div class="card-body filter-card px-9 py-8 rounded-3">
							<!-- Item Group -->
						<c:forEach items="${poDetailList}" var="itemPoDetail" > 
							
							<div class="po-item-group border-gray-400 border-bottom py-9 px-6">
							    <div class="d-flex align-items-center justify-content-between row">
							        <div class="col-7 d-flex align-items-center">
							            <!-- <div class="symbol symbol-40px me-4">
							                 <i class="ki-duotone ki-monitor-mobile fs-2 text-primary">
							                     <span class="path1"></span><span class="path2"></span></i>
							            </div> -->
							            
							            <!-- <span class="text-gray-900 fs-5 me-3">Equipment</span> -->
											 <c:choose>
												<c:when test="${itemPoDetail.items_type == '1'}">
													<div class="symbol symbol-40px me-4">
										                 <i class="ki-duotone ki-monitor-mobile fs-2 text-primary">
										                     <span class="path1"></span><span class="path2"></span></i>
										            </div>
													<span class="text-gray-900 fs-5 me-3">Equipment</span>
												</c:when>
												<c:when test="${itemPoDetail.items_type == '2'}">
													<div class="symbol symbol-40px me-4">
										                 <i class="ki-duotone ki-lots-shopping fs-2 text-orange">
										                     <span class="path1"></span><span class="path2"></span>
										                     <span class="path3"></span><span class="path4"></span>
										                     <span class="path5"></span><span class="path6"></span>
										                     <span class="path7"></span><span class="path8"></span>
									                     </i>
										            </div>
														  <span class="text-gray-900 fs-5 me-3">Consumables</span>
												</c:when>
												<c:when test="${itemPoDetail.items_type == '3'}">
													<div class="symbol symbol-40px me-4">
										                 <i class="ki-duotone ki-parcel fs-2 text-success">
										                     <span class="path1"></span><span class="path2"></span><span class="path3"></span>
 															 <span class="path4"></span><span class="path5"></span></i>
										            </div>
														  <span class="text-gray-900 fs-5 me-3">Office supplies</span>
												</c:when>
												<c:otherwise>
													<div class="symbol symbol-40px me-4">
										                 <i class="ki-duotone ki-monitor-mobile fs-2 text-primary">
										                     <span class="path1"></span><span class="path2"></span></i>
										            </div>
													<span class="text-gray-900 fs-5 me-3">Equipment</span>
												</c:otherwise>
											</c:choose>
							            <span class="text-gray-900 fs-5 me-3"></span>
							            <div class="d-flex align-items-center">
								        	<i class="ki-duotone ki-document fs-2 text-muted me-2">
								        		<span class="path1"></span><span class="path2"></span></i>
								            <span class="text-gray-900 fs-5">${empty itemPoDetail.description ? '': fn:escapeXml(itemPoDetail.description)}</span>
							            </div>
							        </div>
							        <div class="col-3 d-flex align-items-center justify-content-between px-0">
								            <div class="col-2 d-flex flex-column text-end">
								                <span class="fs-6 text-gray-900">${itemPoDetail.unit}</span>
								                <span class="fw-semibold fs-5 text-gray-800"><fmt:formatNumber value="${itemPoDetail.amount_total}" maxFractionDigits="0" /></span>
								            </div>
								            <div class="col-4 d-flex flex-column text-end">
								                <span class="fs-6 text-gray-900">Price</span>
								                <span class="fw-semibold fs-5 text-gray-800"><fmt:formatNumber value="${itemPoDetail.unit_price}" pattern="#,##0.00" /></span>
								            </div>
								            <div class="col-4 d-flex flex-column text-end">
								                <span class="fs-6 text-gray-900">Total</span>
								                <span class="fw-semibold fs-5 text-primary"><fmt:formatNumber value="${itemPoDetail.price_total}" pattern="#,##0.00" /></span>
								            </div>
								    </div>
								        
							        <!-- <div class="col-3 d-flex align-items-center gap-8">
							            <div class="text-end">
							                <span class="fs-6 text-gray-900">เครื่อง</span>
							                <span class="fw-semibold fs-5 text-gray-800">5</span>
							            </div>
							            <div class="text-end">
							                <span class="fs-6 text-gray-900">Price</span>
							                <span class="fw-semibold fs-5 text-gray-800">29,000.00</span>
							            </div>
							            <div class="text-end">
							                <span class="fs-6 text-gray-900">Total</span>
							                <span class="fw-semibold fs-5 text-primary">116,000.00</span>
							            </div>
							         </div> -->
							        
							            <div class="col-2 d-flex justify-content-end align-items-center gap-2 px-0">
							                <a href="#" 
											   class="btn btn-icon btn-light-primary btn-sm existing-detail-edit-btn" 
											   title="Edit"
											   data-po-detail-id="${itemPoDetail.po_detail_id}"
											   data-product-id="${itemPoDetail.product_id}"
											   data-qty="${itemPoDetail.amount_total}"
											   data-unit="${itemPoDetail.unit}"
											   data-price="${itemPoDetail.unit_price}"
											   data-description="${empty itemPoDetail.description ? '' : fn:escapeXml(itemPoDetail.description)}"> 
											    <i class="ki-duotone ki-pencil fs-2"><span class="path1"></span><span class="path2"></span></i>
											</a> 
											<a href="#" 
											   class="btn btn-icon btn-light-danger btn-sm existing-detail-delete-btn" 
											   title="Delete"
											   data-po-detail-id="${itemPoDetail.po_detail_id}">
											    <i class="ki-duotone ki-trash fs-2"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i>
											</a>
							                
							                <a id="poGroupBtn_${itemPoDetail.po_detail_id}" class="collapsed">
											    <i class="ki-duotone ki-up-square fs-2hx">
											        <span class="path1"></span><span class="path2"></span>
											    </i>
											</a>
							            </div>
							    </div>
							
							    <div class="collapse border-gray-300 border-top mt-3" id="poGroup_${itemPoDetail.po_detail_id}">
							    <%-- id="poGroup_${status.index}"> --%>
							        <div class="ps-9 pt-9">
							        <c:forEach items="${poParentList}" var="itemPoParentList" >
							        	<c:if test="${itemPoParentList.po_detail_id == itemPoDetail.po_detail_id}">
								            <div class="d-flex align-items-center justify-content-between mb-5 row ">
								            	<div class="col-11">
									                <div class="d-flex align-items-center fs-7 ">
									                	<div class="col-4">
										                    <i class="ki-duotone ki-user-tick fs-3 text-muted me-2">
										                    	<span class="path1"></span><span class="path3"></span><span class="path3"></span>
										                    </i>
										                    <span class="text-gray-800 fs-5">${itemPoParentList.userEmployeeId} - ${itemPoParentList.user_create_nameEN}</span>
									                    </div>
									                    <div class="col-4 d-flex align-items-center">
										                    <i class="ki-duotone ki-calendar-2 fs-3 me-2">
																 <span class="path1"></span>
																 <span class="path2"></span>
																 <span class="path3"></span>
																 <span class="path4"></span>
						 										 <span class="path5"></span>
															</i>
										                    <span class="text-gray-800 fs-5"><fmt:formatDate value="${itemPoParentList.time_create}" pattern="d MMM yyyy, HH:mm" /></span>
									                    </div>
									                    <div class="col-3 d-flex align-items-center">
										                    <i class="ki-duotone ki-tablet-book fs-3 me-2">
											                     <span class="path1"></span><span class="path2"></span>
															</i>
															<span class="badge badge-lg badge-light-primary text-primary fs-7 fw-semibold me-1 text-center">-</span>
										                    <!-- <span class="badge badge-lg badge-light-primary text-primary fs-7 fw-semibold me-1">PR001</span>
										                    <span class="badge badge-lg badge-light-info text-info fs-7 fw-semibold ">MR001</span> -->
									                    </div>
									                </div>
								                </div>
								                <div class="col-1 text-end">
								                	<span class="text-gray-800 fs-5"><fmt:formatNumber value="${itemPoParentList.amount}" maxFractionDigits="0" /> ${itemPoParentList.unit}</span>
								                </div>
								            </div>
							            </c:if>
							          </c:forEach>
							            <!-- <div class="d-flex align-items-center justify-content-between mb-5 row">
							            	<div class="col-11">
								                <div class="d-flex align-items-center fs-7 ">
								                	<div class="col-4 d-flex align-items-center">
									                    <i class="ki-duotone ki-user-tick fs-3 text-muted me-2">
									                    	<span class="path1"></span><span class="path3"></span><span class="path3"></span>
									                    </i>
									                    <span class="text-gray-800 fs-5">A292 - Supaporn Sukthiamsuwan</span>
								                    </div>
								                    <div class="col-4 d-flex align-items-center">
									                    <i class="ki-duotone ki-calendar-2 fs-3 me-2">
															 <span class="path1"></span>
															 <span class="path2"></span>
															 <span class="path3"></span>
															 <span class="path4"></span>
					 										 <span class="path5"></span>
														</i>
									                    <span class="text-gray-800 fs-5">25 May 2024, 10:00</span>
								                    </div>
								                    <div class="col-3 d-flex align-items-center">
									                    <i class="ki-duotone ki-tablet-book fs-3 me-2">
										                     <span class="path1"></span><span class="path2"></span>
														</i>
									                    <span class="badge badge-lg badge-light-primary text-primary fs-7 fw-semibold me-1">PR002</span>
									                  
								                    </div>
								                </div>
							                </div>
							                <div class="col-1 text-end">
							                	<span class="text-gray-800 fs-5">4 เครื่อง</span>
							                </div>
							            </div> -->
							            
							        </div>
							    </div>
							</div>
							</c:forEach>
							<div id="newPoDetailContainer"></div>
					        <!-- Grand Total -->
					        <div class="d-flex align-items-center justify-content-end pt-3 mt-3 g-3">
					            <span class="text-gray-900 fs-6 me-5">Total</span>
					            <h1 class="fw-semibold text-primary ps-9 text-end"><fmt:formatNumber value="${poList.poTotal}" pattern="#,##0.00" /></h1>
					            <span class="text-gray-900 fs-6 text-end ms-3">บาท</span>
					        </div>
											
						</div>
					</div>
					
					
					
					<div class="card mb-10">
						<div class="card-header border-0 px-9 pt-7 d-flex align-items-center justify-content-between">
							<div class="card-title">
								<h3 class="fw-semibold text-gray-900">Signature</h3>
							</div>
						</div>
					<form id="signatureForm" method="post" action="update_signature" enctype="multipart/form-data">
						<div class="card-body filter-card px-10 py-9 rounded-3 row g-5">
						
							<div class="col-6">
								<div class="d-flex flex-column align-items-center gap-2">
									<c:choose>
										<c:when test="${not empty imgPathSignature}">
											<div class="sig-box locked">
												<img src="${pageContext.request.contextPath}${imgPathSignature}"
													style="max-height: 150px; max-width: 360px; object-fit: contain;" />
													<div class="sig-lock-badge">
														<i class="ki-duotone ki-lock fs-7"> <span
															class="path1"></span><span class="path2"></span>
														</i> Signature on file
													</div>
												</div>
										</c:when>
	
										<c:otherwise>
							                <div class="sig-box uploadable" id="uploadSignatureBox">
							                    <img id="signaturePreview" style="max-height:150px; max-width:360px; object-fit:contain; display:none;" />
							                    <div id="uploadPlaceholder" class="d-flex flex-column align-items-center">
							                        <i class="ki-duotone ki-cloud-add fs-2x text-muted">
							                            <span class="path1"></span><span class="path2"></span>
							                        </i>
							                        <span class="text-muted fs-8 mt-2">Click to upload your signature</span>
							                    </div>
							                </div>
							                <input type="file" id="signatureFileInput" name="fileUpload" accept="image/*" class="d-none" />
							            </c:otherwise>
									</c:choose>
								</div>
							</div>

							<div class="col-6">
								<div class="border border-gray-300 rounded-3 h-100 d-flex flex-column align-items-center justify-content-center text-center py-8">
									<div class="receiver-box d-flex flex-fill flex-column align-items-center gap-2" id="receiverBox1">
							            <c:choose>
							                <c:when test="${empty statusActiveSafe}">
							                    <span class="text-muted fs-7" id="receiverLabel1">คลิ๊ก เพื่อยืนยันผู้ขอเบิกเงิน</span>
							                    <div id="receiverPreview1" style="min-height: 44px; display: flex; flex-direction: column; align-items: center;"></div>
							                    <button type="button" class="btn btn-primary btn-sm px-5" id="receiverBtn1" onclick="confirmReceiver(1)">
							                        ลงชื่อ ผู้ขอเบิก
							                    </button>
							                </c:when>
							
							                <c:otherwise>
							                    <div id="receiverPreview1" style="min-height: 44px; display: flex; flex-direction: column; align-items: center;">
							                        <span class="text-primary pb-2 fs-7 fw-semibold">ชื่อ ผู้ขอเบิก</span>
							                        <div class="d-flex flex-column align-items-center">
							                            <span class="text-dark fw-semibold fs-7">${userObj.nameEN}</span>
							                            <span class="text-muted fs-8">
							                                <fmt:formatDate value="${requestAt}" pattern="d MMM yyyy, H:mm" />
							                            </span>
							                        </div>
							                    </div>
							                </c:otherwise>
							            </c:choose>
							        </div>
								</div>
							</div>
						</div>
						</form>
					</div>
					
					
					<div class="modal fade" tabindex="-1" id="modal_create_po">
						<div class="modal-dialog modal-lg">
						    <div class="modal-content">
						        <div class="modal-header">
						            <h3 class="modal-title">Create PO - Detail</h3>
					
						            <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
						                <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
						            </div>
						        </div>
						
						        <div class="modal-body">
						            <div class="row g-5 mb-6">
										<div class="col-lg-6 col-md-6 col-12 d-flex flex-column">
											<label class="required fw-medium text-gray-800 mb-2">Category</label>
											<div class="position-relative d-flex align-items-center">
												<select name="items_type" id="items_type" class="form-select h-45px" data-control="select2">
													<option value="equipment">Equipment</option>
													<option value="consumables">Consumables</option>
													<option value="office">Office supplies</option>
												</select>
											</div>
										</div>
										
										<div class="col-lg-6 col-md-6 col-12 d-flex flex-column">
											<label class="required fw-medium text-gray-800 mb-2">Product Name</label>
											<div class="position-relative d-flex align-items-center">
												<%-- <c:choose>
													<c:when test="${not empty sessionScope.userImgPath}">
													</c:when>
														<c:otherwise>
														</c:otherwise>
												</c:choose>
												<c:forEach var="company" items="${companyList}">
												</c:forEach> --%>
												<select name="product_name" id="product_name" class="form-select h-45px" data-control="select2">
													<option value=""></option>
												</select>
											</div>
										</div>
									</div>
									
									<div class="row g-5 mb-6">
										<div class="col-lg-6 col-md-6 col-12 d-flex flex-column">
											<label class="required fw-medium text-gray-800 mb-2">จำนวน</label>
											<input type="number" class="form-control text-gray-700 h-45px" min="1"
													name="po_qty" id="po_qty" placeholder="1" value="1" />
										</div>
										
										<div class="col-lg-6 col-md-6 col-12 d-flex flex-column">
											<label class="required fw-medium text-gray-800 mb-2">Unit</label>
											<div class="position-relative d-flex align-items-center">
												<input type="text" class="form-control text-gray-700 h-45px" min="1"
													name="unit" id="unit" placeholder="เครื่อง" value="" />
												
											</div>
										</div>
									</div>
									
									<div class="row g-5 mb-6">
										<div class="col-lg-6 col-md-6 col-12 d-flex flex-column">
											<label class="required fw-medium text-gray-800 mb-2">ราคาต่อหน่วย</label>
											<input type="text" class="form-control text-gray-700 h-45px"
													name="po_price" id="po_price" placeholder="0.00" />
										</div>
									<!-- </div>
									
									<div class="row g-5 mb-6"> -->
										<div class="col-6 d-flex flex-column">
											<label class="required fw-medium text-gray-800 mb-2">Description / Detail</label>
											<textarea class="form-control text-gray-700" rows="3" id="po_description" name="po_description" placeholder="Description"></textarea>
										</div>
									</div>
						        </div>
						
						        <div class="modal-footer">
						            <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
						            <button type="button" class="btn btn-success" id="btnSavePoDetail"
        									onclick="addPoDetailToCart()">Save</button>
						        </div>
						    </div>
						</div>
					</div>
					
					<div class="modal fade" tabindex="-1" id="modal_create_pr">
						<div class="modal-dialog modal-lg">
						    <div class="modal-content">
						        <div class="modal-header">
						            <h3 class="modal-title">Create PR</h3>
					
						            <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
						                <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
						            </div>
						        </div>
						
						        <div class="modal-body">
						            <div class="row g-5 mb-6">
										<div class="col-lg-6 col-md-6 col-12 d-flex flex-column">
											<label class="required fw-medium text-gray-800 mb-2">Category</label>
											<div class="position-relative d-flex align-items-center">
												<select name="" class="form-select h-45px" data-control="select2">
													<option value="" selected>Equipment</option>
													<option value="" selected>Consumables</option>
													<option value="" selected>Office supplies</option>
												</select>
											</div>
										</div>
										
										<div class="col-lg-6 col-md-6 col-12 d-flex flex-column">
											<label class="required fw-medium text-gray-800 mb-2">Product Name</label>
											<div class="position-relative d-flex align-items-center">
												<select name="" class="form-select h-45px" data-control="select2">
													<option value="" selected>Macbook air</option>
												</select>
											</div>
										</div>
									</div>
									
									<div class="row g-5 mb-6">
										<div class="col-lg-6 col-md-6 col-12 d-flex flex-column">
											<label class="required fw-medium text-gray-800 mb-2">จำนวน</label>
											<input type="number" class="form-control text-gray-700 h-45px" min="1"
													name="" id="" value="1" />
										</div>
										
										<div class="col-lg-6 col-md-6 col-12 d-flex flex-column">
											<label class="required fw-medium text-gray-800 mb-2">Unit</label>
											<div class="position-relative d-flex align-items-center">
												<select name="" class="form-select h-45px" data-control="select2">
													<option value="1" selected>เครื่อง</option>
												</select>
											</div>
										</div>
									</div>
									
									<div class="row g-5 mb-6">
										<div class="col-12 d-flex flex-column">
											<label class="required fw-medium text-gray-800 mb-2">Description / Detail</label>
											<textarea class="form-control text-gray-700" rows="3" name="description" placeholder="Description"></textarea>
										</div>
									</div>
						        </div>
						
						        <div class="modal-footer">
						            <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
						            <button type="button" class="btn btn-success">Save</button>
						        </div>
						    </div>
						</div>
					</div>
					
					
					<%-- <div class="card mb-10">
						<div class="card-header border-0 px-9 pt-7 d-flex align-items-center justify-content-between">
							<div class="card-title">
								<h3 class="fw-semibold text-gray-900">Signature</h3>
							</div>
						</div>
						<div class="card-body filter-card px-10 py-9 rounded-3">
							<div class="row g-5">
								<div class="col-lg-6 col-12">
									<div class="d-flex gap-2 mb-3">
										<button type="button" id="btnModeDraw"
											class="btn btn-sm btn-primary flex-grow-1">
											<i class="ki-duotone ki-pencil fs-5 me-1"><span class="path1"></span><span class="path2"></span></i>
											วาดลายเซ็น
										</button>
										<button type="button" id="btnModeUpload"
											class="btn btn-sm btn-light flex-grow-1">
											<i class="ki-duotone ki-picture fs-5 me-1"><span class="path1"></span><span class="path2"></span></i>
											อัปโหลดรูปภาพ
										</button>
									</div>
									
									<div id="drawModeBox" class="border border-gray-300 rounded-3 position-relative" style="height: 150px;">
										<canvas id="signaturePad" class="w-100 h-100"></canvas>
										<a href="javascript:void(0);" id="btnClearSignature"
											class="position-absolute top-0 end-0 m-2 btn btn-icon btn-sm btn-light-danger" title="ล้างลายเซ็น">
											<i class="ki-duotone ki-trash fs-3">
												<span class="path1"></span><span class="path2"></span>
												<span class="path3"></span><span class="path4"></span><span class="path5"></span>
											</i>
										</a>
									</div>
	
									<div id="uploadModeBox" class="border border-gray-300 rounded-3 position-relative d-none"
										style="height: 150px; overflow: hidden;">
										<img id="uploadPreview" class="w-100 h-100" style="object-fit: contain; display: none;" />
										<div id="uploadPlaceholder"
											class="w-100 h-100 d-flex flex-column align-items-center justify-content-center text-muted"
											style="cursor: pointer;">
											<i class="ki-duotone ki-picture fs-3x mb-2">
												<span class="path1"></span><span class="path2"></span>
											</i>
											<span class="fs-7">คลิกเพื่อเลือกรูปภาพลายเซ็น</span>
										</div>
										<a href="javascript:void(0);" id="btnClearUpload"
											class="position-absolute top-0 end-0 m-2 btn btn-icon btn-sm btn-light-danger d-none" title="ลบรูปภาพ">
											<i class="ki-duotone ki-trash fs-3">
												<span class="path1"></span><span class="path2"></span>
												<span class="path3"></span><span class="path4"></span><span class="path5"></span>
											</i>
										</a>
										<input type="file" id="signatureFileInput" accept="image/*" class="d-none" />
									</div>
									
									<input type="hidden" name="signature_data" id="signatureData" />
									<input type="hidden" name="signature_type" id="signatureType" value="draw" />
								</div>
								
								<div class="col-lg-6 col-12">
									<div class="border border-gray-300 rounded-3 h-100 d-flex flex-column align-items-center justify-content-center text-center py-8">
										<span class="text-primary fw-medium fs-6 mb-3">ชื่อ ผู้ขอเบิก</span>
										<span class="text-gray-800 fw-semibold fs-6">A292 - Supaporn Sukthiamsuwan</span>
										<span class="text-gray-800 fw-semibold fs-6">27 May 2026, 10:00</span>
									</div>
								</div>
						</div>
					</div>
				</div> --%>
				
				<div class="modal fade" tabindex="-1" id="modal_search_mr">
					    <div class="modal-dialog modal-lg">
					        <div class="modal-content px-3">
					            <div class="modal-header border-0">
					                <h3 class="modal-title">Search MR</h3>
					                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
					                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
					                </div>
					            </div>
					
					            <div class="modal-body">
					                <div class="row g-5 mb-3">
					                    <div class="col-lg-6 col-md-6 col-12 d-flex flex-column">
					                        <label class="required fw-medium text-gray-800 mb-2">Search PR</label>
					                        <div class="input-group">
					                            <input type="text" class="form-control text-gray-700 h-45px"
					                                    name="" id="" placeholder="PR name" />
					                            
					                        </div>
					                    </div>
					
					                    <div class="col-lg-6 col-md-6 col-12 d-flex flex-column">
					                        <label class="required fw-medium text-gray-800 mb-2">Category</label>
					                        <select name="searchMrCategory" id="searchMrCategory" class="form-select h-45px" data-control="select2">
					                            <option value="" selected>All</option>
					                            <option value="equipment">Equipment</option>
					                            <option value="consumables">Consumables</option>
					                            <option value="office">Office supplies</option>
					                        </select>
					                    </div>
					                </div>
					
					                <div class="row g-5 mb-6 mt-3">
						                    <div class="d-flex align-items-center justify-content-between mb-4 ">
							                    <div class="d-flex align-items-center gap-2">
								                    <h3 class="text-gray-900 fw-bold">
												        <span id="mrItemsFoundCount"></span> Items Found 
												    </h3>
												
												  
												    <span id="mrSortLabel" class="fw-bold fs-6 text-gray-500">by Recent Updates</span>
												</div>
												        <h3 class="text-primary fw-bold">
												            <span id="mrSelectedCount"></span> Selected
												        </h3>
												    
							        
											    
											</div>
					                        <div class="table-responsive">
					                            <table class="table table-striped align-middle gy-4 gs-7" id="mrResultTable">
					                                <thead>
					                                    <tr class="fs-7 fw-bold text-gray-500 text-uppercase border-bottom border-gray-200 mb-0">
					                                        <th class="w-25px ">
					                                            <div class="text-center form-check form-check-sm">
					                                                <input class="form-check-input" type="checkbox" id="checkAllMr" />
					                                            </div>
					                                        </th>
					                                        <th class="min-w-40px">#</th>
					                                        <th class="min-w-80px">MR ID</th>
					                                        <th class="min-w-100px">Category</th>
					                                         <th class="min-w-200px">Request Name</th>
					                                        <th class="min-w-200px">Product</th>
					                                        <th class="min-w-100px text-center">Status</th>
					                                    </tr>
					                                </thead>
					                                <tbody id="mrResultBody">
					                                    <tr class="fw-semibold fs-6 text-gray-800 border-bottom border-gray-200">
					                                        <td>
					                                            <div class="form-check form-check-sm">
					                                                <input class="form-check-input mr-row-check" type="checkbox" />
					                                            </div>
					                                        </td>
					                                        <td class="fw-semibold text-gray-900 fs-7 row-number"></td>
					                                        <td class="text-gray-900 fs-5">MR001</td>
					                                        <td>
					                                        	<div class="d-flex align-items-center">
							                                        <div class="symbol symbol-40px me-4">
														                 <i class="ki-duotone ki-monitor-mobile fs-2 text-primary">
														                     <span class="path1"></span><span class="path2"></span></i>
														            </div>
							                                        <span class="text-gray-900 fs-6">Equipment</span>
						                                        </div>
					                                        </td>
					                                        <td>
															    <div class="d-flex align-items-center gap-3">
															        
															        <div class="symbol symbol-35px"
															             data-kt-menu-trigger="{default: 'click', lg: 'hover'}"
															             data-kt-menu-attach="parent" data-kt-menu-placement="bottom-end">
															            <c:choose>
															                <c:when test="${not empty sessionScope.userImgPath}">
															                    <img id="avatarPreview" src="${sessionScope.userImgPath}" alt="${not empty onlineUser.nameEN ? onlineUser.nameEN : onlineUser.name}"
															                         class="rounded-circle w-35px h-35px" style="object-fit: cover;"> 
															                </c:when>
															                <c:otherwise>
															                  
															                    <div id="avatarPreview" class="rounded-circle w-35px h-35px bg-light text-primary d-flex justify-content-center align-items-center fw-bold">
															                        <c:choose>
															                            <c:when test="${not empty onlineUser.nameEN and fn:length(onlineUser.nameEN) >= 1}">
															                                ${fn:toUpperCase(fn:substring(onlineUser.nameEN, 0, 1))}
															                            </c:when>
															                            <c:when test="${not empty onlineUser.name and fn:length(onlineUser.name) >= 1}">
															                                ${fn:toUpperCase(fn:substring(onlineUser.name, 0, 1))}
															                            </c:when>
															                            <c:otherwise>-</c:otherwise>
															                        </c:choose>
															                    </div>
															                </c:otherwise>
															            </c:choose>
															        </div>
															
															        <div class="d-flex flex-column">
															            <span class="text-gray-900 fs-6">Kridsada Ninpetch</span>
															            <span class="text-gray-900 fs-6">1 Jan 2026, 12:33</span>
															        </div>
															        
															    </div>
															</td>
					                                        <td>
					                                        	<div class="d-flex flex-column">
															        <span class="text-gray-900 fs-6">Lenovo LOQ 15IAXB</span>
															        <span class="text-gray-900 fs-6">1 เครื่อง</span>
															 	</div>
															</td>
					                                        <td class="text-end">
					                                        <%-- <c:choose>
																<c:when test="${item.status == 'B'}">
																	<span class="badge badge-lg bg-light fw-semibold fs-7 text-gray-600">Draft</span>
																</c:when>
																<c:when test="${item.status == 'W'}">
																	<span class="badge badge-lg badge-warning fw-semibold fs-7">Pending</span>
																</c:when>
																<c:when test="${item.status == 'C'}">
																	<span class="badge badge-lg bg-success fw-semibold fs-7">Approved</span>
																</c:when>
																<c:when test="${item.status == 'T'}">
																	<span class="badge badge-lg bg-cyan text-white fw-semibold fs-7">In-Progress</span>
																</c:when>
																<c:when test="${item.status == 'W'}">
																	<span class="badge badge-lg badge-info fw-semibold fs-7">Return</span>
																</c:when>
																<c:when test="${item.status == 'C'}">
																	<span class="badge badge-lg bg-danger fw-semibold fs-7">Rejected</span>
																</c:when>
																<c:when test="${item.status == 'T'}">
																	<span class="badge badge-lg bg-dark fw-semibold fs-7">Closed</span>
																</c:when>
																<c:otherwise>
																	<span class="badge badge-lg bg-light-secondary fw-semibold fs-7">-</span>
																</c:otherwise>
															</c:choose> --%>
															
															<span class="badge badge-lg bg-light-secondary fw-semibold fs-7">Draft</span>
					                                        </td>
					                                    </tr>
					                                    <tr class="fw-semibold fs-6 text-gray-800 border-bottom border-gray-200">
					                                        <td>
					                                            <div class="form-check form-check-sm">
					                                                <input class="form-check-input mr-row-check" type="checkbox" />
					                                            </div>
					                                        </td>
					                                        <td class="fw-semibold text-gray-900 fs-7 row-number"></td>
					                                        <td class="text-gray-900 fs-5">MR002</td>
					                                        <td>
					                                        	<div class="d-flex align-items-center">
							                                        <div class="symbol symbol-40px me-4">
							                                        <i class="ki-duotone ki-lots-shopping fs-2 text-orange">
													                     <span class="path1"></span><span class="path2"></span>
													                     <span class="path3"></span><span class="path4"></span>
													                     <span class="path5"></span><span class="path6"></span>
													                     <span class="path7"></span><span class="path8"></span>
												                     </i>
														            </div>
							                                        <span class="text-gray-900 fs-6">Consumables</span>
						                                        </div>
					                                        </td>
					                                        <td>
															    <div class="d-flex align-items-center gap-3">
															        
															        <div class="symbol symbol-35px"
															             data-kt-menu-trigger="{default: 'click', lg: 'hover'}"
															             data-kt-menu-attach="parent" data-kt-menu-placement="bottom-end">
															            <c:choose>
															                <c:when test="${not empty sessionScope.userImgPath}">
															                    <img id="avatarPreview" src="${sessionScope.userImgPath}" alt="${not empty onlineUser.nameEN ? onlineUser.nameEN : onlineUser.name}"
															                         class="rounded-circle w-35px h-35px" style="object-fit: cover;"> 
															                </c:when>
															                <c:otherwise>
															                  
															                    <div id="avatarPreview" class="rounded-circle w-35px h-35px bg-light text-primary d-flex justify-content-center align-items-center fw-bold">
															                        <c:choose>
															                            <c:when test="${not empty onlineUser.nameEN and fn:length(onlineUser.nameEN) >= 1}">
															                                ${fn:toUpperCase(fn:substring(onlineUser.nameEN, 0, 1))}
															                            </c:when>
															                            <c:when test="${not empty onlineUser.name and fn:length(onlineUser.name) >= 1}">
															                                ${fn:toUpperCase(fn:substring(onlineUser.name, 0, 1))}
															                            </c:when>
															                            <c:otherwise>-</c:otherwise>
															                        </c:choose>
															                    </div>
															                </c:otherwise>
															            </c:choose>
															        </div>
															
															        <div class="d-flex flex-column">
															            <span class="text-gray-900 fs-6">Kridsada Ninpetch</span>
															            <span class="text-gray-900 fs-6">1 Jan 2026, 12:33</span>
															        </div>
															        
															    </div>
															</td>
					                                        <td>
					                                        	<div class="d-flex flex-column">
															        <span class="text-gray-900 fs-6">A4</span>
															        <span class="text-gray-900 fs-6">1 รีม</span>
															 	</div>
															</td>
															
					                                        <td class="text-end"><span class="badge badge-lg badge-warning fw-semibold fs-7">Pending</span></td>
					                                    </tr>
					                                    <tr class="fw-semibold fs-6 text-gray-800 border-bottom border-gray-200">
					                                        <td>
					                                            <div class="form-check form-check-sm">
					                                                <input class="form-check-input mr-row-check" type="checkbox" />
					                                            </div>
					                                        </td>
					                                        <td class="fw-semibold text-gray-900 fs-7 row-number"></td>
					                                        <td class="text-gray-900 fs-5">MR003</td>
					                                        <td>
					                                        	<div class="d-flex align-items-center">
							                                        <div class="symbol symbol-40px me-4">
														                 <i class="ki-duotone ki-keyboard fs-2 text-dark">
														                     <span class="path1"></span><span class="path2"></span></i>
														            </div>
							                                        <span class="text-gray-900 fs-6">Instrument</span>
						                                        </div>
					                                        </td>
					                                        <td>
															    <div class="d-flex align-items-center gap-3">
															        
															        <div class="symbol symbol-35px"
															             data-kt-menu-trigger="{default: 'click', lg: 'hover'}"
															             data-kt-menu-attach="parent" data-kt-menu-placement="bottom-end">
															            <c:choose>
															                <c:when test="${not empty sessionScope.userImgPath}">
															                    <img id="avatarPreview" src="${sessionScope.userImgPath}" alt="${not empty onlineUser.nameEN ? onlineUser.nameEN : onlineUser.name}"
															                         class="rounded-circle w-35px h-35px" style="object-fit: cover;"> 
															                </c:when>
															                <c:otherwise>
															                  
															                    <div id="avatarPreview" class="rounded-circle w-35px h-35px bg-light text-primary d-flex justify-content-center align-items-center fw-bold">
															                        <c:choose>
															                            <c:when test="${not empty onlineUser.nameEN and fn:length(onlineUser.nameEN) >= 1}">
															                                ${fn:toUpperCase(fn:substring(onlineUser.nameEN, 0, 1))}
															                            </c:when>
															                            <c:when test="${not empty onlineUser.name and fn:length(onlineUser.name) >= 1}">
															                                ${fn:toUpperCase(fn:substring(onlineUser.name, 0, 1))}
															                            </c:when>
															                            <c:otherwise>-</c:otherwise>
															                        </c:choose>
															                    </div>
															                </c:otherwise>
															            </c:choose>
															        </div>
															
															        <div class="d-flex flex-column">
															            <span class="text-gray-900 fs-6">Kridsada Ninpetch</span>
															            <span class="text-gray-900 fs-6">1 Jan 2026, 12:33</span>
															        </div>
															        
															    </div>
															</td>
					                                        <td>
					                                        	<div class="d-flex flex-column">
															        <span class="text-gray-900 fs-6">ต้นคริสมาส</span>
															        <span class="text-gray-900 fs-6">1 ต้น</span>
															 	</div>
															</td>
					                                         <td class="text-end"><span class="badge badge-lg badge-warning fw-semibold fs-7">Pending</span></td>
					                                    </tr>
					                                </tbody>
					                            </table>
					                        </div>
					                        <div class="text-muted fs-7 mt-2" id="mrNoResult" style="display:none;">No matching MR found.</div>
					                    
					                </div>
					            </div>
					
					            <div class="modal-footer pt-0 mt-0 mb-2 border-0">
					                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
					                <button type="button" class="btn btn-success" id="btnSubmitMr">Submit</button>
					            </div>
					        </div>
					    </div>
					</div>
					
					<div class="d-flex justify-content-between g-10">
						<div class="d-flex">
							<button type="button" id="backFormBtn"
								onclick="location.href='purchase_order_list'"
								class="btn btn-lg btn-light fw-medium text-light-inverse px-6 py-4 me-4 border">Back
							</button>
							<button type="button" id="cancelFormBtn"
								onclick="confirmLeaveForm('purchase_order_list')"
								class="btn btn-lg btn-dark fw-medium px-6 py-4">Cancel
							</button>
						</div>
						<div class="d-flex">
							
							<button type="button" id="saveDraft" onclick="saveDraftForm()"
								class="btn btn-lg btn-cyan text-white fw-medium px-6 py-4 me-4">Save Draft
							</button>
							<button type="button" id="savePOFormBtn" onclick="submitPO()"
								class="btn btn-success text-white fw-medium px-6 py-4">Submit PO</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
<script type="text/javascript">
	const ctx = "${pageContext.request.contextPath}";

	document.addEventListener("DOMContentLoaded", function () {
		
		$("#kt_reference_datepicker").daterangepicker({
			singleDatePicker: true,
			showDropdowns: true,
			locale: {
				format: "D MMM YYYY"
			}
		});
		
		// Table MR
		var table = $('#mrResultTable').DataTable({
			ordering : true,
			searching : true,
			autoWidth : false,
			info: false, 
			paging: false,
			columnDefs : [ {
				orderable : false,
				targets : [ 0 ]
			}, {
				orderable : true,
				targets : [ 1, 2, 3, 4, 5 ]
			}, {
				targets: [ 5 ],
				type: 'string'
			} ],
			order : [],
			headerCallback : function(thead) {
				$(thead).find('th').each(
						function(index) {
							if (index === 0) return;
							if ($(this).find('.th-wrapper').length === 0) {
								$(this).wrapInner(
										'<span class="th-wrapper" style="display:inline-flex; align-items:center; white-space:nowrap; pointer-events:none;"></span>');
								}
							});
				}
		});
		
		
		document.querySelectorAll('.po-item-group .collapse').forEach(function (collapseEl) {
			var btn = document.getElementById(collapseEl.id.replace('poGroup_', 'poGroupBtn_'));
			if (!btn) return;

			var icon = btn.querySelector('i');

			btn.addEventListener('click', function () {
				var isOpen = collapseEl.classList.contains('show');

				if (isOpen) {
					collapseEl.classList.remove('show');
					btn.classList.add('collapsed');
					icon.classList.remove('ki-down-square');
					icon.classList.add('ki-up-square');
				} else {
					collapseEl.classList.add('show');
					btn.classList.remove('collapsed');
					icon.classList.remove('ki-up-square');
					icon.classList.add('ki-down-square');
				}
			});
		});
		
		//running number
		/* function runNumber() {
			const info = table.page.info();
			table.column(1, {
				page : 'current'
					}).nodes().each(function(cell, i) {
						cell.innerHTML = info.start + i + 1;
						});
			}
		
		table.on('draw.dt order.dt search.dt', runNumber);
		runNumber(); */
		
		
		// --- Modal ---
		 var elements = Array.prototype.slice.call(document.querySelectorAll("[data-bs-stacked-modal]"));
		    if (elements && elements.length > 0) {
		        elements.forEach((element) => {
		            if (element.getAttribute("data-kt-initialized") === "1") {
		                return;
		            }

		            element.setAttribute("data-kt-initialized", "1");

		            element.addEventListener("click", function(e) {
		                e.preventDefault();

		                const modalEl = document.querySelector(this.getAttribute("data-bs-stacked-modal"));

		                if (modalEl) {
		                    const modal = new bootstrap.Modal(modalEl);
		                    modal.show();
		                }
		            });
		        });
		    }
		    
		    document.querySelectorAll('a.btn-primary[href="#"]').forEach(function (btn) {
		        if (btn.textContent.trim().includes('Search MR')) {
		            btn.setAttribute('data-bs-toggle', 'modal');
		            btn.setAttribute('data-bs-target', '#modal_search_mr');
		        }
		    });

		    document.getElementById('checkAllMr').addEventListener('change', function () {
		        document.querySelectorAll('.mr-row-check').forEach(cb => cb.checked = this.checked);
		        updateMrSelectedCount();
		    });

		    document.querySelectorAll('.mr-row-check').forEach(function (cb) {
		        cb.addEventListener('change', updateMrSelectedCount);
		    });

		    function updateMrSelectedCount() {
		        var count = document.querySelectorAll('.mr-row-check:checked').length;
		        document.getElementById('mrSelectedCount').textContent = count;
		    }
		    updateMrSelectedCount();  

		    function updateItemsFoundCount() {
		        var count = table.rows({ search: 'applied' }).count();
		        document.getElementById('mrItemsFoundCount').textContent = count;
		    }

		    table.on('draw.dt search.dt', updateItemsFoundCount);
		    updateItemsFoundCount();
});
	
	
	function confirmLeaveForm(redirectUrl){
	    Swal.fire({
	        title: "Are you sure?!",
	        text: "Closing will discard any unsaved data.",
	        icon: "warning",
	        showCancelButton: true,
	        confirmButtonText: "Yes, discard it",
	        cancelButtonText: "Cancel",
	        buttonsStyling: false,
	        customClass: {
	            confirmButton: "btn btn-danger",
	            cancelButton: "btn btn-secondary"
	        }
	    }).then((result) => {
	        if (result.isConfirmed) {
	            window.location.href = redirectUrl;
	        }
	    });
	}
	
	// --- compressImage ---
	async function compressImage(file, maxWidth = 1280, maxHeight = 1280, quality = 0.8) {
		if (!file.type.match(/image\/(jpeg|jpg|png)/)) {
			return file;
		}

		return new Promise((resolve, reject) => {
			const reader = new FileReader();
			reader.readAsDataURL(file);
			reader.onload = event => {
				const img = new Image();
				img.src = event.target.result;
				img.onload = () => {
					let width = img.width;
					let height = img.height;

					if (width > maxWidth || height > maxHeight) {
						const ratio = Math.min(maxWidth / width, maxHeight / height);
						width = width * ratio;
						height = height * ratio;
					}

					const canvas = document.createElement('canvas');
					canvas.width = width;
					canvas.height = height;
					const c2d = canvas.getContext('2d');
					c2d.drawImage(img, 0, 0, width, height);

					canvas.toBlob((blob) => {
						if (blob) {
							const newFileName = file.name.replace(/\.[^/.]+$/, ".jpg");
							const newFile = new File([blob], newFileName, {
								type: 'image/jpeg',
								lastModified: Date.now()
							});
							resolve(newFile);
						} else {
							resolve(file);
						}
					}, 'image/jpeg', quality);
				};
				img.onerror = error => reject(error);
			};
			reader.onerror = error => reject(error);
		});
	}

	// --- Signature Upload ---
	(function initSignatureUpload() {
		const uploadBox = document.getElementById('uploadSignatureBox');
		const fileInput = document.getElementById('signatureFileInput');
		const previewImg = document.getElementById('signaturePreview');
		const placeholder = document.getElementById('uploadPlaceholder');
		const signatureForm = document.getElementById('signatureForm');

		if (!uploadBox || !fileInput) return;

		uploadBox.addEventListener('click', function () {
			fileInput.click();
		});

		fileInput.addEventListener('change', async function () {
			const file = this.files[0];
			if (!file) return;

			if (!file.type.match(/image\/(jpeg|jpg|png)/)) {
				Swal.fire('Invalid file', 'กรุณาเลือกไฟล์รูปภาพ (jpg, jpeg, png)', 'error');
				fileInput.value = '';
				return;
			}
			if (file.size > 5 * 1024 * 1024) {
				Swal.fire('File too large', 'ขนาดไฟล์ต้องไม่เกิน 5MB', 'error');
				fileInput.value = '';
				return;
			}

			let finalFile;
			try {
				finalFile = await compressImage(file);
			} catch (e) {
				finalFile = file;
			}

			const dt = new DataTransfer();
			dt.items.add(finalFile);
			fileInput.files = dt.files;

			const reader = new FileReader();
			reader.onload = function (e) {
				previewImg.src = e.target.result;
				previewImg.style.display = 'block';
				if (placeholder) placeholder.style.display = 'none';
			};
			reader.readAsDataURL(finalFile);

			submitSignature();
		});

		function submitSignature() {
			const formData = new FormData(signatureForm);

			fetch(ctx + '/update_signature', {
				method: 'POST',
				body: formData
			})
			.then(res => {
				if (!res.ok) throw new Error('Upload failed');
				return res.text();
			})
			.then(() => {
				Swal.fire({
					title: 'Save Success',
					text: 'Signature has been successfully recorded.',
					icon: 'success',
					timer: 1200,
					showConfirmButton: false
				}).then(() => {
					window.location.href = window.location.href;
				});
			})
			.catch(err => {
				console.error(err);
				previewImg.style.display = 'none';
				if (placeholder) placeholder.style.display = 'flex';
				fileInput.value = '';
			});
		}
	})();
	
	// ================== Company / Location / Contact ==================

	function loadCompanyProfile(companyId, preselectLocationId, preselectContactId) {
	    if (!companyId) return;

	    $.ajax({
	        url: ctx + '/get_company_profile',
	        type: 'POST',
	        dataType: 'json',
	        data: { companyId: companyId },
	        success: function (resp) {
	            if (resp.debug) console.log('[get_company_profile debug]', resp.debug);
	            var data = resp.data;
	            if (!data) return;

	            $('#companyTaxNumber').text(data.taxId || '');
	            $('#companyTaxInfo').removeClass('d-none');

	            var options = '<option value=""></option>';
	            (data.locationList || []).forEach(function (loc) {
	                var sel = (preselectLocationId && String(loc.company_address_id) === String(preselectLocationId)) ? ' selected' : '';
	                options += '<option value="' + loc.company_address_id + '"' + sel + '>' + loc.address_name + '</option>';
	            });
	            $('#vendor_location_id').html(options).prop('disabled', false);

	            if (preselectLocationId) {
	                loadCompanyLocation(preselectLocationId, preselectContactId, true);
	            } else {
	                $('#vendor_location_id').trigger('change');
	            }
	        },
	        error: function () {
	            Swal.fire('Error', 'ไม่สามารถโหลดข้อมูลบริษัทได้', 'error');
	        }
	    });
	}

	function loadCompanyLocation(addressId, preselectContactId, isInitial) {
	    if (!addressId) return;

	    $.ajax({
	        url: ctx + '/get_company_location',
	        type: 'POST',
	        dataType: 'json',
	        data: { addressId: addressId },
	        success: function (resp) {
	            if (resp.debug) console.log('[get_company_location debug]', resp.debug);
	            var data = resp.data;
	            if (!data) return;

	            $('#companyAddress').text(data.address ? data.address.address : '');
	            $('#companyAddressInfo').removeClass('d-none');

	            var options = '<option value=""></option>';
	            (data.contactList || []).forEach(function (c) {
	                var sel = (preselectContactId && String(c.company_contact_id) === String(preselectContactId)) ? ' selected' : '';
	                options += '<option value="' + c.company_contact_id + '"' + sel + '>' + c.contact_name + '</option>';
	            });
	            $('#contact_id').html(options).prop('disabled', false);

	            if (isInitial) {
	                // sync select2 ให้ตรงกับ option ที่ selected อยู่ (สำคัญมากถ้าใช้ select2)
	                $('#vendor_location_id').val(addressId).trigger('change.select2');
	                if (preselectContactId) {
	                    loadCompanyContact(preselectContactId, true);
	                }
	            } else {
	                $('#contact_id').trigger('change');
	            }
	        },
	        error: function () {
	            Swal.fire('Error', 'ไม่สามารถโหลดข้อมูล Location ได้', 'error');
	        }
	    });
	}

	function loadCompanyContact(contactId, isInitial) {
	    if (!contactId) return;

	    $.ajax({
	        url: ctx + '/get_company_contact',
	        type: 'POST',
	        dataType: 'json',
	        data: { contactId: contactId },
	        success: function (resp) {
	            if (resp.debug) console.log('[get_company_contact debug]', resp.debug);
	            var data = resp.data;
	            if (!data) return;

	            $('#contactPhone').text(data.phone || '');
	            $('#contactEmail').text(data.email || '');
	            $('#contactInfo').removeClass('d-none');

	            if (isInitial) {
	                $('#contact_id').val(contactId).trigger('change.select2');
	            }
	        },
	        error: function () {
	            Swal.fire('Error', 'ไม่สามารถโหลดข้อมูล Contact ได้', 'error');
	        }
	    });
	}

	// --- User เปลี่ยน Company ---
	$('#vendor_id').on('change', function () {
	    var companyId = $(this).val();

	    $('#companyTaxInfo').addClass('d-none');
	    $('#companyAddressInfo').addClass('d-none');
	    $('#contactInfo').addClass('d-none');

	    $('#vendor_location_id').html('<option value=""></option>').prop('disabled', true).trigger('change.select2');
	    $('#contact_id').html('<option value=""></option>').prop('disabled', true).trigger('change.select2');

	    if (!companyId) return;

	    loadCompanyProfile(companyId, null, null);
	});

	$('#vendor_location_id').on('change', function () {
	    var addressId = $(this).val();

	    $('#companyAddressInfo').addClass('d-none');
	    $('#contactInfo').addClass('d-none');
	    $('#contact_id').html('<option value=""></option>').prop('disabled', true).trigger('change.select2');

	    if (!addressId) return;

	    loadCompanyLocation(addressId, null, false);
	});

	$('#contact_id').on('change', function () {
	    var contactId = $(this).val();
	    $('#contactInfo').addClass('d-none');

	    if (!contactId) return;

	    loadCompanyContact(contactId, false);
	});

	// --- company/location/contact ของ PO ---
	$(function () {
	    var initCompanyId = $('#vendor_id').val();
	    var initLocationId = $('#poVendorLocationId').val();
	    var initContactId  = $('#poContactId').val();

	    if (initCompanyId) {
	        loadCompanyProfile(initCompanyId, initLocationId, initContactId);
	    }
	});
	
	
</script>
<script type="text/javascript">

/* ================== Fix daterangepicker ให้ sync กับค่าเดิม ================== */
document.addEventListener("DOMContentLoaded", function () {
    var rawDate = $('#poRefDateRaw').val();
    var picker = $("#kt_reference_datepicker");
    picker.daterangepicker({
        singleDatePicker: true,
        showDropdowns: true,
        locale: { format: "D MMM YYYY" },
        startDate: rawDate ? moment(rawDate, "YYYY-MM-DD") : moment()
    });
});


/* ================== confirmReceiver (หายไปจากหน้า Edit) ================== */
let confirmed1 = ${empty statusActiveSafe ? 'false' : 'true'};

function confirmReceiver(slot) {
    const currentUserDisplay = "${empty loginUser.employeeId ? '' : loginUser.employeeId} - ${empty loginUser.nameEN ? loginUser.name : loginUser.nameEN}";
    const now = new Date();
    const pad = n => String(n).padStart(2, '0');
    const months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    const dateStr = now.getDate() + ' ' + months[now.getMonth()] + ' ' + now.getFullYear();
    const timeStr = pad(now.getHours()) + ':' + pad(now.getMinutes());
    const timestamp = dateStr + ' , ' + timeStr;

    document.getElementById('receiverPreview' + slot).innerHTML =
        '<span class="fw-semibold text-dark fs-7">' + currentUserDisplay + '</span>' +
        '<span class="text-muted fs-8 mt-1">' + timestamp + '</span>';

    const label = document.getElementById('receiverLabel' + slot);
    if (label) label.style.visibility = 'hidden';

    const btn = document.getElementById('receiverBtn' + slot);
    btn.textContent  = '✓ ยืนยันแล้ว';
    btn.className    = 'btn btn-success btn-sm px-5';
    btn.disabled     = true;

    document.getElementById('receiverBox' + slot).classList.add('receiver-confirmed');

    if (slot === 1) confirmed1 = true;
}


/* ================== เพิ่มรายการ PO Detail ใหม่ (cart สำหรับของที่เพิ่มระหว่างแก้ไข) ================== */
let poDetailCart = [];      // เก็บเฉพาะรายการ "ใหม่" ที่เพิ่มระหว่างแก้ไขนี้ ยังไม่ถูกบันทึกลง DB
let editingIndex = -1;      // index ใน poDetailCart ที่กำลังแก้ (สำหรับรายการใหม่)
let editingExistingDetailId = null; // po_detail_id ของรายการเดิมที่กำลังแก้ (ถ้ามี)

function parseFormattedNumber(str) {
    if (!str) return 0;
    return Number(String(str).replace(/,/g, ''));
}

function validatePoDetailForm(){
    let errors = [];
    if (!$('#items_type').val() || !$('#items_type').val().trim()) errors.push('Category');
    if (!$('#product_name').val() || !$('#product_name').val().trim()) errors.push('Product Name');

    const qty = $('#po_qty').val().trim();
    if (!qty || Number(qty) <= 0) errors.push('จำนวน');

    if (!$('#unit').val().trim()) errors.push('Unit');

    const price = $('#po_price').val().trim();
    if (!price || parseFormattedNumber(price) < 0) errors.push('ราคาต่อหน่วย');

    if (!$('#po_description').val().trim()) errors.push('Description / Detail');

    return errors;
}

function addPoDetailToCart(){
    const errors = validatePoDetailForm();
    if (errors.length > 0) {
        Swal.fire({
            title: 'Please complete the form!',
            html: "Please fill in the following fields:<br><strong>" + errors.join(", ") + "</strong>",
            icon: "error",
            confirmButtonText: "OK",
        });
        return;
    }

    const item = {
        itemsType: $("#items_type").val(),
        productId: $("#product_name").val(),
        productName: $("#product_name option:selected").text(),
        qty: Number($("#po_qty").val()),
        unit: $("#unit").val(),
        price: parseFormattedNumber($("#po_price").val()),
        description: $("#po_description").val()
    };
    item.total = item.qty * item.price;

    if (editingExistingDetailId) {
        // แก้ไขรายการเดิมที่มีอยู่แล้วใน DB -> เรียก AJAX update ทันที
        updateExistingPoDetail(editingExistingDetailId, item);
    } else if (editingIndex >= 0) {
        poDetailCart[editingIndex] = item;
        editingIndex = -1;
        renderNewPoDetailCart();
        closeCreatePoModal();
    } else {
        poDetailCart.push(item);
        renderNewPoDetailCart();
        closeCreatePoModal();
    }
}

function closeCreatePoModal(){
    const modalEl = document.getElementById("modal_create_po");
    const modal = bootstrap.Modal.getOrCreateInstance(modalEl);
    modal.hide();
}

function renderNewPoDetailCart(){
    let html = "";
    poDetailCart.forEach(function(item, index){
        html += `
        <div class="po-item-group border-gray-400 border-bottom py-9 px-6 bg-light-success bg-opacity-25">
            <div class="d-flex align-items-center justify-content-between row">
                <div class="col-7 d-flex align-items-center">
                    <span class="badge badge-light-success me-3">New</span>
                    <span class="text-gray-900 fs-5 me-3">\${item.productName}</span>
                    <span class="text-gray-900 fs-5">\${item.description}</span>
                </div>
                <div class="col-3 d-flex align-items-center justify-content-between px-0">
                    <div class="col-4 d-flex flex-column text-end">
                        <span class="fs-6 text-gray-900">\${item.unit}</span>
                        <span class="fw-semibold fs-5 text-gray-800">\${item.qty}</span>
                    </div>
                    <div class="col-4 d-flex flex-column text-end">
                        <span class="fs-6 text-gray-900">Price</span>
                        <span class="fw-semibold fs-5 text-gray-800">\${item.price.toLocaleString(undefined,{minimumFractionDigits:2,maximumFractionDigits:2})}</span>
                    </div>
                    <div class="col-4 d-flex flex-column text-end">
                        <span class="fs-6 text-gray-900">Total</span>
                        <span class="fw-semibold fs-5 text-primary">\${item.total.toLocaleString(undefined,{minimumFractionDigits:2,maximumFractionDigits:2})}</span>
                    </div>
                </div>
                <div class="col-2 d-flex justify-content-end align-items-center gap-2 px-0">
                    <a href="#" onclick="return editNewCartItem(\${index});" class="btn btn-icon btn-light-primary btn-sm" title="Edit">
                        <i class="ki-duotone ki-pencil fs-2"><span class="path1"></span><span class="path2"></span></i>
                    </a>
                    <a href="#" onclick="return removeNewCartItem(\${index});" class="btn btn-icon btn-light-danger btn-sm" title="Delete">
                        <i class="ki-duotone ki-trash fs-2"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i>
                    </a>
                </div>
            </div>
        </div>`;
    });
    $("#newPoDetailContainer").html(html);
}

function editNewCartItem(index){
    const item = poDetailCart[index];
    if (!item) return false;

    editingIndex = index;
    editingExistingDetailId = null;

    $('#modal_create_po .modal-title').text('Edit PO - Detail');
    $('#btnSavePoDetail').text('Update');
    $('#items_type').val(item.itemsType).trigger('change');

    const waitForProductList = setInterval(function(){
        if ($('#product_name option[value="' + item.productId + '"]').length > 0) {
            $('#product_name').val(item.productId).trigger('change');
            clearInterval(waitForProductList);
        }
    }, 100);
    setTimeout(function(){ clearInterval(waitForProductList); }, 3000);

    $('#po_qty').val(item.qty);
    $('#unit').val(item.unit);
    $('#po_price').val(item.price.toLocaleString(undefined, {minimumFractionDigits: 2, maximumFractionDigits: 2}));
    $('#po_description').val(item.description);

    const modalEl = document.getElementById("modal_create_po");
    bootstrap.Modal.getOrCreateInstance(modalEl).show();
    return false;
}

function removeNewCartItem(index){
    Swal.fire({
        title: "Are you sure?!",
        text: "Are you sure you want to delete this item?",
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "Yes, delete it",
        cancelButtonText: "Cancel",
        buttonsStyling: false,
        customClass: { confirmButton: "btn btn-danger", cancelButton: "btn btn-secondary" }
    }).then((result) => {
        if (result.isConfirmed) {
            poDetailCart.splice(index, 1);
            renderNewPoDetailCart();
        }
    });
    return false;
}


/* ================== แก้ไข / ลบ รายการที่มีอยู่แล้วใน DB ================== */
document.addEventListener('click', function(e){
    const editBtn = e.target.closest('.existing-detail-edit-btn');
    if (editBtn) {
        e.preventDefault();
        editingExistingDetailId = editBtn.dataset.poDetailId;
        editingIndex = -1;

        $('#modal_create_po .modal-title').text('Edit PO - Detail');
        $('#btnSavePoDetail').text('Update');

        // หมายเหตุ: ระบบยังไม่ได้เก็บ items_type แยกไว้ใน po_detail
        // จึง default เป็น equipment แล้วให้ผู้ใช้เลือก category ใหม่เองถ้าจำเป็น
        $('#items_type').val('equipment').trigger('change');

        const productId = editBtn.dataset.productId;
        const waitForProductList = setInterval(function(){
            if ($('#product_name option[value="' + productId + '"]').length > 0) {
                $('#product_name').val(productId).trigger('change');
                clearInterval(waitForProductList);
            }
        }, 100);
        setTimeout(function(){ clearInterval(waitForProductList); }, 3000);

        $('#po_qty').val(editBtn.dataset.qty);
        $('#unit').val(editBtn.dataset.unit);
        $('#po_price').val(Number(editBtn.dataset.price).toLocaleString(undefined, {minimumFractionDigits: 2, maximumFractionDigits: 2}));
        $('#po_description').val(editBtn.dataset.description);

        const modalEl = document.getElementById("modal_create_po");
        bootstrap.Modal.getOrCreateInstance(modalEl).show();
        return;
    }

    const delBtn = e.target.closest('.existing-detail-delete-btn');
    if (delBtn) {
        e.preventDefault();
        const poDetailId = delBtn.dataset.poDetailId;
        Swal.fire({
            title: "Are you sure?!",
            text: "Are you sure you want to delete this item?",
            icon: "warning",
            showCancelButton: true,
            confirmButtonText: "Yes, delete it",
            cancelButtonText: "Cancel",
            buttonsStyling: false,
            customClass: { confirmButton: "btn btn-danger", cancelButton: "btn btn-secondary" }
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: ctx + '/delete_po_detail',
                    type: 'POST',
                    dataType: 'json',
                    data: { poDetailId: poDetailId, poId: '${poList.poId}' },
                    success: function (resp) {
                        if (resp.data && resp.data.success) {
                            window.location.reload();
                        } else {
                            Swal.fire('Error', 'ไม่สามารถลบรายการได้', 'error');
                        }
                    },
                    error: function () {
                        Swal.fire('Error', 'เกิดข้อผิดพลาดในการลบรายการ', 'error');
                    }
                });
            }
        });
    }
});

function updateExistingPoDetail(poDetailId, item){
    $.ajax({
        url: ctx + '/update_po_detail',
        type: 'POST',
        dataType: 'json',
        data: {
            poDetailId: poDetailId,
            poId: '${poList.poId}',
            productId: item.productId,
            qty: item.qty,
            unit: item.unit,
            price: item.price,
            description: item.description
        },
        success: function (resp) {
            if (resp.data && resp.data.success) {
                closeCreatePoModal();
                window.location.reload();
            } else {
                Swal.fire('Error', 'ไม่สามารถแก้ไขรายการได้', 'error');
            }
        },
        error: function () {
            Swal.fire('Error', 'เกิดข้อผิดพลาดในการแก้ไขรายการ', 'error');
        }
    });
}

// รีเซ็ต modal ทุกครั้งที่ปิด
$(document).ready(function(){
    const createPoModalEl = document.getElementById('modal_create_po');
    createPoModalEl.addEventListener('hidden.bs.modal', function () {
        $('#items_type').val('equipment').trigger('change');
        $('#po_qty').val('');
        $('#unit').val('');
        $('#po_price').val('');
        $('#po_description').val('');

        editingIndex = -1;
        editingExistingDetailId = null;
        $('#modal_create_po .modal-title').text('Create PO - Detail');
        $('#btnSavePoDetail').text('Save');
    });

    $('#modal_create_po').on('shown.bs.modal', function () {
        if (editingIndex < 0 && !editingExistingDetailId) {
            $('#items_type').val('equipment').trigger('change');
        }
    });
});

$('#items_type').on('change', function(){
    var itemsType = $(this).val().trim();
    if(!itemsType) return;

    $.ajax({
        url: ctx + '/get_items_catalog',
        type: 'POST',
        dataType: 'json',
        data: { itemsType: itemsType },
        success: function (resp) {
            var data = resp.data;
            if (!data) return;
            var list = (data && data.productList) || [];

            var options = '';
            if (list.length === 0) {
                options = '<option value=""></option>';
            } else {
                list.forEach(function (item, index) {
                    options += '<option value="' + item.id + '"' + (index === 0 ? ' selected' : '') + '>' + item.name + '</option>';
                });
            }
            $('#product_name').html(options).trigger('change');
        },
        error: function () {
            Swal.fire('Error', 'ไม่สามารถโหลดข้อมูล Items Catalog ได้', 'error');
        }
    });
});


/* ================== Price input formatting (เหมือนหน้า Add) ================== */
$(document.body).on('input', '#po_price', function() {
    let value = $(this).val();
    value = value.replace(/[^0-9.]/g, '');
    const parts = value.split('.');
    if (parts.length > 2) value = parts[0] + '.' + parts.slice(1).join('');
    if (parts[0]) parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ',');
    $(this).val(parts.join('.'));
});

$(document.body).on('blur', '#po_price', function() {
    if ($(this).val() === '') return;
    let raw = parseFormattedNumber($(this).val());
    $(this).val(raw.toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 }));
});


/* ================== Save Draft / Submit PO ================== */
function validatePOForm(){
    let errors = [];
    if (!$('#description').val().trim()) errors.push('Description');
    if (!$('#reference_no').val().trim()) errors.push('Reference Invoice/Quotation NO');
    if (!$('#vendor_id').val() || !$('#vendor_id').val().trim()) errors.push('Company Name');
    if (!$('#vendor_location_id').val() || !$('#vendor_location_id').val().trim()) errors.push('Company Location');
    if (!$('#contact_id').val() || !$('#contact_id').val().trim()) errors.push('Contact Name');

    const hasSignature = $('#hasSignature').val() === 'true';
    if (!hasSignature) errors.push('ลายเซ็น (Signature)');

    if (!confirmed1) errors.push('ลงชื่อ ผู้ขอเบิก');

    return errors;
}

function buildUpdatePayload(status){
    return {
        poId: '${poList.poId}',
        companyId: $('#vendor_id').val() || '',
        companyLocation: $('#vendor_location_id').val() || '',
        contactId: $('#contact_id').val() || '',
        description: $('#description').val() || '',
        referenceNo: $('#reference_no').val() || '',
        referenceDate: $('#kt_reference_datepicker').val() || '',
        poDetailCartJson: JSON.stringify(poDetailCart), // เฉพาะรายการใหม่ที่เพิ่มระหว่างแก้ไขนี้
        status: status
    };
}


function saveDraftForm(){
    const payload = buildUpdatePayload('0');
    $('#saveDraft').prop('disabled', true);

    $.ajax({
        url: ctx + '/update_po',
        type: 'POST',
        dataType: 'json',
        data: payload,
        success: function (resp) {
            ...
        },
        error: function () {
            Swal.fire('Error', 'เกิดข้อผิดพลาดในการบันทึก', 'error');
        },
        complete: function(){
            $('#saveDraft').prop('disabled', false);
        }
    });
}


function submitPO(){
    const errors = validatePOForm();
    if (errors.length > 0) {
        Swal.fire({
            title: 'Please complete the form!',
            html: "Please fill in the following fields:<br><strong>" + errors.join(", ") + "</strong>",
            icon: "error",
            confirmButtonText: "OK",
        });
        return;
    }

    Swal.fire({
        title: "Are you sure?!",
        text: "Do you want to save the changes?",
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "Save",
        cancelButtonText: "Close",
        buttonsStyling: false,
        customClass: { confirmButton: "btn btn-success", cancelButton: "btn btn-secondary" }
    }).then((result) => {
        if (!result.isConfirmed) return;

        const payload = buildUpdatePayload('2');
        $('#savePOFormBtn').prop('disabled', true);

        $.ajax({
            url: ctx + '/update_po',
            type: 'POST',
            dataType: 'json',
            data: payload,
            success: function (resp) {
                if (resp.data && resp.data.poId) {
                    Swal.fire({
                        title: 'Success!',
                        text: 'บันทึก PO เรียบร้อยแล้ว',
                        icon: 'success'
                    }).then(() => {
                        window.location.href = ctx + '/purchase_order_list';
                    });
                } else {
                    Swal.fire('Error', 'ไม่สามารถส่ง PO ได้', 'error');
                }
            },
            error: function () {
                Swal.fire('Error', 'เกิดข้อผิดพลาดในการส่งข้อมูล', 'error');
            },
            complete: function(){
                $('#savePOFormBtn').prop('disabled', false);
            }
        });
    });
}

</script>
</html>