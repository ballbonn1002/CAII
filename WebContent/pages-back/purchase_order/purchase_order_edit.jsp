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
/* [data-bs-theme="light"] #mrResultTable.table.table-striped > tbody > tr:nth-of-type(odd) > * {
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
} */


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
							<c:choose>
								<c:when test="${poList.status == '0'}">
									<span class="badge badge-lg bg-light-secondary fw-semibold fs-7 p-4">Draft</span>
								</c:when>
								<c:when test="${poList.status == '1'}">
									<span class="badge badge-lg bg-cyan text-white fw-semibold fs-7 p-4">In-Progress</span>
								</c:when>
								<c:when test="${poList.status == '2'}">
									<span class="badge badge-lg badge-warning text-white fw-semibold fs-7 p-4">Pending</span>
								</c:when>
								<c:when test="${poList.status == '3'}">
									<span class="badge badge-lg badge-info text-white fw-semibold fs-7 p-4">Return</span>
								</c:when>
								<c:when test="${poList.status == '4'}">
									<span class="badge badge-lg bg-success text-white fw-semibold fs-7 p-4">Approved</span>
								</c:when>
								<c:when test="${poList.status == '5'}">
									<span class="badge badge-lg bg-danger text-white fw-semibold fs-7 p-4">Rejected</span>
								</c:when>
								<c:when test="${poList.status == '6'}">
									<span class="badge badge-lg bg-dark text-white fw-semibold fs-7 p-4">Closed</span>
								</c:when>
								
								<c:otherwise>
								</c:otherwise>
							</c:choose>
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
									<span class="fs-6 fw-medium text-gray-800">${empty loginUser.employeeId ? '' : loginUser.employeeId} - ${empty loginUser.nameEN ? '' : loginUser.nameEN}</span>
								</div>
								
								<div class="col-lg-6 col-md-6 col-12 d-flex align-items-center">
									<i class="ki-duotone ki-calendar-2 fs-3 me-3">
										 <span class="path1"></span>
										 <span class="path2"></span>
										 <span class="path3"></span>
										 <span class="path4"></span>
 										 <span class="path5"></span>
									</i>
									<span class="fs-6 fw-medium text-gray-800"><fmt:formatDate value="${requestDateTime}" pattern="d MMM yyyy" /></span>
								</div>
								<c:choose>
									<c:when test="${poList.status == '0'}">
										<div class="col-12 mt-9">
											<label class="required fw-medium text-gray-800 mb-2">Description</label>
											<textarea class="form-control text-gray-700" id="description" name="description"
												placeholder="Description" rows="3">${poList.description}</textarea>
										</div>
									</c:when>
									<c:otherwise>
										<div class="col-12 mt-9 d-flex align-items-center">
											<i class="ki-duotone ki-document fs-3 me-3">
												<span class="path1"></span>
												<span class="path2"></span>
											</i>
											<span class="fs-6 fw-medium text-gray-800">${poList.description}</span>
										</div>
									</c:otherwise>
								</c:choose>
								
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
											name="reference_no" id="reference_no" value="${poList.refNo}" ${poList.status != '0' ? 'disabled' : ''} />
								</div>
								
								<div class="col-lg-6 col-md-6 col-12 d-flex flex-column">
									<label class="fw-medium text-gray-800 mb-2">Reference Invoice/Quotation Date</label>
									<div class="position-relative d-flex align-items-center">
										<i class="ki-duotone ki-calendar-8 position-absolute ms-4 mb-1 text-gray-500 fs-3">
											<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span>
										</i>
										<input class="form-control text-gray-700 ps-12 h-45px" 
											   id="kt_reference_datepicker" name="reference_date" placeholder="Select date" 
											   value="<fmt:formatDate value="${poList.refDate}" pattern="yyyy-MM-dd"/>" ${poList.status != '0' ? 'disabled' : ''} />
									</div>
								</div>
							</div>
					
							<div class="row g-5 mb-6">
								
									<div class="col-lg-6 col-md-6 col-12 d-flex flex-column">
										<div class="d-flex justify-content-between align-items-center mb-2">
											<label class="required fw-medium text-gray-800">Company Name</label>
											<c:if test="${poList.status == '0'}">
												<a href="/company_add" target="_blank" class="text-success fw-medium fs-7 text-hover-primary" style="text-decoration: none;">
													<i class="ki-outline ki-plus fs-7 text-success me-1"></i>Create
												</a>
											</c:if>
										</div>
										<select name="vendor_id" id="vendor_id" class="form-select h-45px" data-control="select2" data-placeholder="Select Company Name" 
											${poList.status != '0' ? 'disabled' : ''}>
										    <option value=""></option>     
										    <c:forEach var="company" items="${companyList}">
										        <option value="${company.company_id}"
										            ${not empty poList.companyId and poList.companyId == company.company_id ? 'selected' : ''}>
										            ${company.company_en}
										        </option>     
										    </c:forEach>
										</select>
										<div id="companyTaxInfo" class="d-flex align-items-center text-gray-500 fs-7 mt-3 px-1 d-none">
											<i class="ki-duotone ki-credit-cart fs-3 me-2 text-muted"><span class="path1"></span><span class="path2"></span></i>
											<span class="fs-6 fw-normal text-gray-800">Tax ID : <span id="companyTaxNumber"></span></span>
										</div>

									</div>
						
								<div class="col-lg-6 col-md-6 col-12 d-flex flex-column">
									<label class="required fw-medium text-gray-800 mb-2">Company Location</label>
									<select name="vendor_location_right_id" id="vendor_location_id" class="form-select h-45px" data-control="select2" data-placeholder="Select Company Location" 
										disabled>
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
										<c:if test="${poList.status == '0'}">
											<a href="/contact_add" target="_blank" class="text-success fw-medium fs-7 text-hover-primary" style="text-decoration: none;">
												<i class="ki-outline ki-plus fs-7 me-1 text-success"></i>Create
											</a>
										</c:if>
									</div>
									
									<select name="contact_id" id="contact_id" class="form-select h-45px" data-control="select2" data-placeholder="Select Contact Name" 
										disabled>
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
									<textarea class="form-control text-gray-700" rows="3" name="vendor_description" id="vendor_description" ${poList.status != '0' ? 'disabled' : ''}>${poList.descriptionVendor}</textarea>
								</div>
							</div>
						</div>
					</div>
					
					<div class="card mb-10">
						<div class="card-header border-0 px-9 pt-7 d-flex align-items-center justify-content-between">
					        <div class="card-title">
					            <h3 class="fw-semibold text-gray-900">PO - Detail</h3>
					        </div>
							<c:if test="${poList.status == '0'}">
								<div class="card-title gap-3">
									<button type="button" id="btnOpenCreatePo" class="btn btn-lg btn-success fw-medium text-white px-6 py-4" >
										<i class="ki-outline ki-plus fs-3 me-1"></i>Create
									</button>
									
									<button type="button" class="btn btn-lg btn-primary fw-medium text-white px-6 py-4" data-bs-toggle="modal" data-bs-target="#modal_search_mr">
										<i class="ki-duotone ki-magnifier fs-3 me-1">
											<span class="path1"></span><span class="path2"></span></i>Search MR
									</button>
								</div>
							</c:if>
					    </div>
						<div class="card-body filter-card px-9 py-8 rounded-3">
							<div id="poDetailCartContainer"></div>
					        <!-- Grand Total -->
					        <div class="d-flex align-items-center justify-content-end pt-3 mt-3 g-3">
					            <span class="text-gray-900 fs-6 me-5">Total</span>
					            <h1 class="fw-semibold text-primary ps-9 text-end" id="poDetailGrandTotal">0.00</h1>
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
								<!-- Draft status -->
								<c:if test="${poList.status == '0'}">
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

												<c:when test="${poList.status == '0'}">
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
												</c:when>

												<c:otherwise>
													<div class="sig-box unuploadable">
														<span class="text-muted fs-8">No signature</span>
													</div>
												</c:otherwise>
											</c:choose>
										</div>
									</div>

									<div class="col-6">
										<div class="border ${empty poList.signDate ? 'border-gray-300' : 'border-success bg-light-success'} rounded-3 h-100 d-flex flex-column align-items-center justify-content-center text-center py-8" id="receiverCard1">
											<div class="receiver-box d-flex flex-fill flex-column align-items-center justify-content-center gap-2" id="receiverBox1">
												<c:choose>
													<c:when test="${empty poList.signDate}">
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
																<span class="text-dark fw-semibold fs-7">${empty userSignUser.nameEN ? userSignUser.name : userSignUser.nameEN}</span>
																<span class="text-muted fs-8">
																	<fmt:formatDate value="${poList.signDate}" pattern="d MMM yyyy , H:mm" />
																</span>
															</div>
														</div>
													</c:otherwise>
												</c:choose>
											</div>
										</div>
									</div>
								</c:if>

								<!-- Approved status -->
								<c:if test="${poList.status == '4' or poList.status == '1'}">
									<c:if test="${not empty poList.signDate}">
										<div class="col-6">
											<div class="d-flex flex-column align-items-center gap-3">
												<c:if test="${not empty imgPathSignature}">
													<img src="${pageContext.request.contextPath}${imgPathSignature}"
														style="max-height: 150px; max-width: 360px; object-fit: contain;" />
												</c:if>
												<span class="text-primary pt-3 fs-4 fw-medium">ชื่อ ผู้ขอเบิก</span>
												<div class="d-flex flex-column align-items-center">
													<span class="text-gray-900 fw-medium fs-5 pb-2">${empty userSignUser.nameEN ? userSignUser.name : userSignUser.nameEN}</span>
													<span class="text-gray-900 fw-medium fs-6">
														<fmt:formatDate value="${poList.signDate}" pattern="d MMM yyyy , H:mm" />
													</span>
												</div>
											</div>
										</div>
									</c:if>
									
									<c:if test="${not empty poList.approveDate}">
										<div class="col-6">
											<div class="d-flex flex-column align-items-center gap-3">
												<c:if test="${not empty imgPathApproveSignature}">
													<img src="${pageContext.request.contextPath}${imgPathApproveSignature}"
														style="max-height: 150px; max-width: 360px; object-fit: contain;" />
												</c:if>
											
												<span class="text-primary pt-3 fs-4 fw-medium">ชื่อ ผู้อนุมัติ</span>
												<div class="d-flex flex-column align-items-center">
													<span class="text-gray-900 fw-medium fs-5 pb-2">${empty userApproveUser.nameEN ? userApproveUser.name : userApproveUser.nameEN}</span>
													<span class="text-gray-900 fw-medium fs-6">
														<fmt:formatDate value="${poList.approveDate}" pattern="d MMM yyyy , H:mm" />
													</span>

													<c:if test="${not empty poList.reason}">
														<span class="d-flex align-items-center mt-3">
															<i class="ki-duotone ki-document fs-2 fw-normal text-muted me-2">
																<span class="path1"></span>
																<span class="path2"></span>
															</i>
															<span class="fs-5 fw-normal text-gray-900">${poList.reason}</span>
														</span>
													</c:if>
												</div>
											</div>
										</div>
									</c:if>
								</c:if>

								<!-- Pending status -->
								<c:if test="${poList.status == '2' or poList.status == '3' or poList.status == '5'}">
									<div class="col-6">
										<div class="d-flex flex-column align-items-center gap-2">
											<c:choose>
												<c:when test="${not empty imgPathSignature}">
													<div class="sig-box locked">
														<img src="${pageContext.request.contextPath}${imgPathSignature}"
															style="max-height: 150px; max-width: 360px; object-fit: contain;" />
														<div class="sig-lock-badge">
															<i class="ki-duotone ki-lock fs-7"><span class="path1"></span><span class="path2"></span></i>
															Signature on file
														</div>
													</div>
												</c:when>
												<c:otherwise>
													<div class="sig-box unuploadable">
														<span class="text-muted fs-8">No signature</span>
													</div>
												</c:otherwise>
											</c:choose>
										</div>
									</div>

									<div class="col-6">
										<div class="border ${empty poList.signDate ? 'border-gray-300' : 'border-success bg-light-success'} rounded-3 h-100 d-flex flex-column align-items-center justify-content-center text-center py-8">
											<div class="d-flex flex-fill flex-column align-items-center justify-content-center gap-2">
												<c:choose>
													<c:when test="${empty poList.signDate}">
														<span class="text-muted fs-7">ยังไม่มีการลงชื่อ ผู้ขอเบิก</span>
													</c:when>
													<c:otherwise>
														<span class="text-primary pb-2 fs-7 fw-semibold">ชื่อ ผู้ขอเบิก</span>
														<div class="d-flex flex-column align-items-center">
															<span class="text-dark fw-semibold fs-7">${empty userSignUser.nameEN ? userSignUser.name : userSignUser.nameEN}</span>
															<span class="text-muted fs-8">
																<fmt:formatDate value="${poList.signDate}" pattern="d MMM yyyy , H:mm" />
															</span>
														</div>
													</c:otherwise>
												</c:choose>
											</div>
										</div>
									</div>
								</c:if>
							</div>
						</form>
					</div>
					
					<c:if test="${poList.status == '2'}">
						<div class="card mb-10">
							<div class="card-header border-0 px-9 pt-7 d-flex align-items-center justify-content-between">
								<div class="card-title">
									<h3 class="fw-semibold text-gray-900">Approver</h3>
								</div>
							</div>
								<div class="card-body filter-card rounded-3 row g-5">
									<div class="col-12 mt-5">
										<label class="fw-medium text-gray-800 mb-2">Reason</label>
										<textarea class="form-control text-gray-700" id="reason" name="reason"
											rows="3"></textarea>
										<div class="invalid-feedback d-block d-none" id="reasonError"></div>
									</div>
								</div>
						</div>
					</c:if>

					<c:if test="${poList.status == '3'}">
						<div class="card mb-10">
							<div class="card-body filter-card px-10 py-9 rounded-3">
								<div class="d-flex align-items-center fs-6">

									<span>Returned By : ${userUpdate.employeeId} ${userUpdate.nameEN},
										<fmt:formatDate value="${userUpdate.timeUpdate}" pattern="d MMM YYYY HH:mm" />
									</span>

									<c:if test="${not empty poList.reason}">
										<span class="ms-5 d-inline-flex align-items-center">
											<i class="ki-duotone ki-document fs-3 me-3">
												<span class="path1"></span>
												<span class="path2"></span>
											</i>
											<span>${poList.reason}</span>
										</span>
									</c:if>

								</div>
							</div>
						</div>
					</c:if>

					<c:if test="${poList.status == '5'}">
						<div class="card mb-10">
							<div class="card-body filter-card px-10 py-9 rounded-3">
								<div class="d-flex align-items-center fs-6">

									<span>Rejected By : ${userUpdate.employeeId} ${userUpdate.nameEN},
										<fmt:formatDate value="${userUpdate.timeUpdate}" pattern="d MMM YYYY HH:mm" />
									</span>

									<c:if test="${not empty poList.reason}">
										<span class="ms-5 d-inline-flex align-items-center">
											<i class="ki-duotone ki-document fs-3 me-3">
												<span class="path1"></span>
												<span class="path2"></span>
											</i>
											<span>${poList.reason}</span>
										</span>
									</c:if>

								</div>
							</div>
						</div>
					</c:if>

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
													<option value="equipment" selected>Equipment</option>
						                            <option value="consumables">Consumables</option>
						                            <option value="office">Office supplies</option>
												</select>
											</div>
										</div>
										
										<div class="col-lg-6 col-md-6 col-12 d-flex flex-column">
											<label class="required fw-medium text-gray-800 mb-2">Product Name</label>
											<div class="position-relative d-flex align-items-center">
												
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
												<select id="unit" class="form-select h-45px" data-control="select2">
													<option value=""></option>
												</select>
												
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
											<textarea class="form-control text-gray-700" rows="3" name="description" id="po_description" placeholder="Description"></textarea>
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
					
					
					<div class="d-flex justify-content-between g-10">
						<div class="d-flex">
							<button type="button" id="backFormBtn"
								onclick="sessionStorage.removeItem('poDetailCart_draft'); location.href='purchase_order_list'"
    							class="btn btn-lg btn-light fw-medium text-light-inverse px-6 py-4 me-4 border">Back
							</button>
							<c:if test="${poList.status != '4' and poList.status != '5' and poList.status != '6'}">
								<button type="button" id="cancelFormBtn"
									onclick="confirmLeaveForm('purchase_order_list')"
									class="btn btn-lg btn-dark fw-medium px-6 py-4">Cancel
								</button>
							</c:if>
						</div>
						<c:choose>
							<c:when test="${poList.status == '0'}">
								<div class="d-flex">
									<button type="button" id="saveDraft" onclick="saveDraftForm()"
										class="btn btn-lg btn-cyan text-white fw-medium px-6 py-4 me-4">Save Draft
									</button>
									<button type="button" id="savePOFormBtn"
										class="btn btn-success text-white fw-medium px-6 py-4"
										onclick="submitPO()">Submit PO</button>
								</div>
							</c:when>
							
							<c:when test="${poList.status == '2'}">
								
									<div class="d-flex">
										<button type="button" id="returnPOBtn" onclick="returnPO()"
												class="btn btn-lg btn-info text-white fw-medium px-6 py-4 me-4">Return</button>
										<button type="button" id="rejectPOBtn" onclick="rejectPO()"
												class="btn btn-lg btn-danger text-white fw-medium px-6 py-4 me-4">Reject</button>
										<button type="button" id="approvePOBtn" onclick="approvePO()"
													class="btn btn-lg btn-success text-white fw-medium px-6 py-4">Approve</button>
									</div>
								
							</c:when>

							<c:when test="${poList.status == '3'}">
								<div class="d-flex">
									<button type="button" id="editPOFormBtn"
										class="btn btn-lg btn-primary fw-medium px-6 py-4"
										onclick="editPO()">Edit</button>
								</div>
							</c:when>

							<c:when test="${poList.status == '4'}">
								<div class="d-flex">
									<button type="button" id="inProgressPOFormBtn"
										class="btn btn-lg bg-cyan text-white fw-medium px-6 py-4"
										onclick="inProgressPO()">In-Progress</button>
								</div>
							</c:when>

							<c:otherwise>
								
							</c:otherwise>
						</c:choose>
					</div>

				</div>
			</div>
		</div>
	</div>

</body>

<script type="text/javascript">
	const ctx = "${pageContext.request.contextPath}";
	const currentUserDisplay = "${empty loginUser.employeeId ? '' : loginUser.employeeId} - ${empty loginUser.nameEN ? '' : loginUser.nameEN}";
	
	const EDIT_PO_ID     = "${empty poList.poId ? '' : poList.poId}";
	const editCompanyId  = "${empty poList.companyId ? '' : poList.companyId}";
	const editLocationId = "${empty poList.companyLocation ? '' : poList.companyLocation}";
	const editContactId  = "${empty poList.contactId ? '' : poList.contactId}";
	const poStatus       = "${empty poList.status ? '' : poList.status}";
	const canEditPoDetail = (poStatus === '0');
	
	let pendingLocationId = editLocationId || null;
	let pendingContactId  = editContactId  || null;
	
	const serverPoDetailCart = [
	    <c:forEach var="d" items="${poDetailList}" varStatus="st">
	    {
	        poDetailId: "${d.po_detail_id}",
	        productId: "${d.product_id}",
	        productName: "${empty d.product_name ? '' : d.product_name}",
	        itemsType: "${empty d.product_type ? '' : d.product_type}",
	        qty: ${empty d.amount_total ? 0 : d.amount_total},
	        unit: "${empty d.unit ? '' : d.unit}",
			unitName: "${empty d.unit_name ? '' : d.unit_name}",
	        price: ${empty d.unit_price ? 0 : d.unit_price},
	        total: ${empty d.price_total ? 0 : d.price_total},
	        description: "${fn:replace(fn:replace(empty d.description ? '' : d.description, '\\', '\\\\'), '"', '\\"')}",
	        savedAt: "<fmt:formatDate value="${d.time_create}" pattern="d MMM yyyy, HH:mm"/>"
	    }${!st.last ? ',' : ''}
	    </c:forEach>
	];

	function formatNowDateTime(){
	    const d = new Date();
	    const months = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
	    const pad = n => String(n).padStart(2,'0');
	    return `\${d.getDate()} \${months[d.getMonth()]} \${d.getFullYear()}, \${pad(d.getHours())}:\${pad(d.getMinutes())}`;
	    /* return `\${d.getDate()} \${months[d.getMonth()]} \${d.getFullYear()}, \${pad(d.getHours())}:\${pad(d.getMinutes())}`; */
	}
	
	document.addEventListener("DOMContentLoaded", function () {
		flatpickr("#kt_reference_datepicker", {
	        dateFormat: "Y-m-d",  
	        altInput: true,
	        altFormat: "d M Y",   
	        locale: "en",        
	        allowInput: false
	    });
		
		// Table MR
		// var table = $('#mrResultTable').DataTable({
		// 	ordering : true,
		// 	searching : true,
		// 	autoWidth : false,
		// 	info: false, 
		// 	paging: false,
		// 	columnDefs : [ {
		// 		orderable : false,
		// 		targets : [ 0 ]
		// 	}, {
		// 		orderable : true,
		// 		targets : [ 1, 2, 3, 4, 5 ]
		// 	}, {
		// 		targets: [ 5 ],
		// 		type: 'string'
		// 	} ],
		// 	order : [],
		// 	headerCallback : function(thead) {
		// 		$(thead).find('th').each(
		// 				function(index) {
		// 					if (index === 0) return;
		// 					if ($(this).find('.th-wrapper').length === 0) {
		// 						$(this).wrapInner(
		// 								'<span class="th-wrapper" style="display:inline-flex; align-items:center; white-space:nowrap; pointer-events:none;"></span>');
		// 						}
		// 					});
		// 		}
		// });
		
		document.querySelector('#kt_app_content_container').addEventListener('click', function(e){
			const btn = e.target.closest('.po-group-toggle');
			if (!btn) return;

			const collapseEl = document.getElementById('poGroup_' + btn.dataset.target);
			if (!collapseEl) return;

			const icon = btn.querySelector('i');
			const isOpen = collapseEl.classList.contains('show');

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
		// document.querySelector('#kt_app_content_container').addEventListener('click', function(e){
		//     const btn = e.target.closest('.collapsed, [data-target^="cart_"], a[id^="poGroupBtn_"]');
		//     if (!btn) return;

		//     let collapseEl;
		//     if (btn.dataset.target) {
		//         collapseEl = document.getElementById('poGroup_' + btn.dataset.target);
		//     } else if (btn.id.startsWith('poGroupBtn_')) {
		//         collapseEl = document.getElementById(btn.id.replace('poGroupBtn_', 'poGroup_'));
		//     }
		//     if (!collapseEl) return;

		//     const icon = btn.querySelector('i');
		//     const isOpen = collapseEl.classList.contains('show');

		//     if (isOpen) {
		//         collapseEl.classList.remove('show');
		//         btn.classList.add('collapsed');
		//         icon.classList.remove('ki-down-square');
		//         icon.classList.add('ki-up-square');
		//     } else {
		//         collapseEl.classList.add('show');
		//         btn.classList.remove('collapsed');
		//         icon.classList.remove('ki-up-square');
		//         icon.classList.add('ki-down-square');
		//     }
		// });
		
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
		runNumber();
		 */
		
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
		    
		    if (!editCompanyId) { // เฉพาะโหมด add เท่านั้น
		        var $vendorId = $('#vendor_id');
		        var $firstCompany = $vendorId.find('option').filter(function () {
		            return $(this).val() !== '';
		        }).first();
		        if ($firstCompany.length) {
		            $vendorId.val($firstCompany.val()).trigger('change');
		        }
		    }
		    
		    const createPoModalEl = document.getElementById('modal_create_po');

		    createPoModalEl.addEventListener('show.bs.modal', function () {
		        if (editingIndex === -1 && !editingExistingDetailId) {
		            $('#items_type').val('equipment').trigger('change');
		            $('#po_qty').val('1');
		            $('#unit').val('');
		            $('#po_price').val('');
		            $('#po_description').val('');
		            $('#modal_create_po .modal-title').text('Create PO - Detail');
		            $('#btnSavePoDetail').text('Save');
		        }
		    });

		    createPoModalEl.addEventListener('shown.bs.modal', function () {
		        document.body.classList.add('modal-open');
		        document.body.style.overflow = 'hidden';
		        document.documentElement.style.overflow = 'hidden';
		    });

		    createPoModalEl.addEventListener('hidden.bs.modal', function () {
		        editingIndex = -1;
		        editingExistingDetailId = null;
		        document.querySelectorAll('.modal-backdrop').forEach(el => el.remove());
		        document.body.classList.remove('modal-open');
		        document.body.style.removeProperty('padding-right');
		        document.body.style.removeProperty('overflow');
		        document.documentElement.style.removeProperty('overflow');
		    });
		    
			const btnOpenCreatePo = document.getElementById('btnOpenCreatePo');
			if (btnOpenCreatePo) {
				btnOpenCreatePo.addEventListener('click', function () {
					editingIndex = -1;
					editingExistingDetailId = null;
					bootstrap.Modal.getOrCreateInstance(createPoModalEl, { backdrop: true }).show();
				});
			}

			if (editCompanyId) {
				$('#vendor_id').val(editCompanyId).trigger('change');
			}
		    
		    
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
	        	sessionStorage.removeItem(PO_CART_STORAGE_KEY);
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
	
	const isVendorReadOnly = ${poList.status != '0' ? 'true' : 'false'};
	$('#vendor_id').on('change', function () {
	    var companyId = $(this).val();

	    $('#companyTaxInfo').addClass('d-none');
	    $('#companyAddressInfo').addClass('d-none');
	    $('#contactInfo').addClass('d-none');

	    $('#vendor_location_id').html('<option value=""></option>').prop('disabled', true).trigger('change');
	    $('#contact_id').html('<option value=""></option>').prop('disabled', true).trigger('change');

	    if (!companyId) return;

	    $.ajax({
	        url: ctx + '/get_company_profile',
	        type: 'POST',
	        dataType: 'json',
	        data: { companyId: companyId },
	        success: function (resp) {
	            // if (resp.debug) console.log('[get_company_profile debug]', resp.debug);
	            var data = resp.data;
	            if (!data) return;

	            $('#companyTaxNumber').text(data.taxId || '');
	            $('#companyTaxInfo').removeClass('d-none');

	            var list = data.locationList || [];
	            var options = '';
	            var matched = pendingLocationId &&
                list.some(l => String(l.company_address_id) === String(pendingLocationId));
            	var selectedLocId = matched ? pendingLocationId
                                : (list.length ? list[0].company_address_id : '');
            	if (list.length === 0) {
                    options = '<option value=""></option>';
                } else {
                    list.forEach(function (loc) {
                        var isSel = String(loc.company_address_id) === String(selectedLocId);
                        options += '<option value="' + loc.company_address_id + '"' + (isSel ? ' selected' : '') + '>' + loc.address_name + '</option>';
                    });
                }
            	
            	$('#vendor_location_id').html(options).prop('disabled', isVendorReadOnly);
                pendingLocationId = null; // ใช้ไปแล้ว เคลียร์ทิ้ง กันเลือกซ้ำรอบหน้า
                $('#vendor_location_id').trigger('change');
	        },
	        error: function () {
	            Swal.fire('Error', 'ไม่สามารถโหลดข้อมูลบริษัทได้', 'error');
	        }
	    });
	});

	$('#vendor_location_id').on('change', function () {
	    var addressId = $(this).val() ? $(this).val().trim() : '';

	    $('#companyAddressInfo').addClass('d-none');
	    $('#contactInfo').addClass('d-none');
	    $('#contact_id').html('<option value=""></option>').prop('disabled', true);

	    if (!addressId) return;

	    $.ajax({
	        url: ctx + '/get_company_location',
	        type: 'POST',
	        dataType: 'json',
	        data: { addressId: addressId },
	        success: function (resp) {
	            var data = resp.data;
	            if (!data) return;

	            $('#companyAddress').text(data.address ? data.address.address : '');
	            $('#companyAddressInfo').removeClass('d-none');

	            var list = data.contactList || [];
	            var options = '';

	            var matched = pendingContactId &&
	                list.some(c => String(c.company_contact_id) === String(pendingContactId));
	            var selectedContactId = matched ? pendingContactId
	                                    : (list.length ? list[0].company_contact_id : '');

	            if (list.length === 0) {
	                options = '<option value=""></option>';
	            } else {
	                list.forEach(function (c) {
	                    var isSel = String(c.company_contact_id) === String(selectedContactId);
	                    options += '<option value="' + c.company_contact_id + '"' + (isSel ? ' selected' : '') + '>' + c.contact_name + '</option>';
	                });
	            }

	            $('#contact_id').html(options).prop('disabled', isVendorReadOnly);
	            pendingContactId = null; // ใช้ไปแล้ว เคลียร์ทิ้ง
	            $('#contact_id').trigger('change');
	        },
	        error: function () {
	            Swal.fire('Error', 'ไม่สามารถโหลดข้อมูล Location ได้', 'error');
	        }
	    });
	});

	$('#contact_id').on('change', function () {
	    var contactId = $(this).val();
	    $('#contactInfo').addClass('d-none');

	    if (!contactId) return;

	    $.ajax({
	        url: ctx + '/get_company_contact',
	        type: 'POST',
	        dataType: 'json',
	        data: { contactId: contactId },
	        success: function (resp) {
	            // if (resp.debug) console.log('[get_company_contact debug]', resp.debug);
	            var data = resp.data;
	            if (!data) return;

	            $('#contactPhone').text(data.phone || '');
	            $('#contactEmail').text(data.email || '');
	            $('#contactInfo').removeClass('d-none');
	        },
	        error: function () {
	            Swal.fire('Error', 'ไม่สามารถโหลดข้อมูล Contact ได้', 'error');
	        }
	    });
	});
	
	$('#items_type').on('change', function(){
		var itemsType = $(this).val();
		if(!itemsType) return;
		itemsType = itemsType.trim();
		
		$.ajax({
			 url: ctx + '/get_items_catalog',
		        type: 'POST',
		        dataType: 'json',
		        data: { itemsType: itemsType },
		        success: function (resp) {
		            // if (resp.debug) console.log('[get_items_catalog debug]', resp.debug);
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
	})

	$('#product_name').on('change', function(){
		var productId = $(this).val();
		$('#unit').html('<option value=""></option>').trigger('change');
		if(!productId) return;

		$.ajax({
			url: ctx + '/get_unit_of_measure',
			type: 'POST',
			dataType: 'json',
			data: { productId: productId },
			success: function (resp) {
				var data = resp.data;
				if (!data) return;
				var list = (data && data.unitList) || [];

				var options = '';
				if (list.length === 0) {
					options = '<option value=""></option>';
				} else {
					list.forEach(function (item, index) {
						options += '<option value="' + item.id + '"' + (index === 0 ? ' selected' : '') + '>' + item.name + '</option>';
					});
				}

				$('#unit').html(options).trigger('change');
			},
			error: function () {
				Swal.fire('Error', 'ไม่สามารถโหลดข้อมูล Unit ได้', 'error');
			}
		});
	});
	
</script>

<script>
let poDetailCart = []; // เก็บรายการใหม่ ที่เพิ่มระหว่างแก้ไข ยังไม่ถูกบันทึกลง DB
let existingPoDetailList = (typeof serverPoDetailCart !== 'undefined') ? serverPoDetailCart : []; // รายการเดิมที่มีอยู่แล้วใน DB (แก้/ลบผ่าน AJAX ทันที)
let poDetailCounter = 0;
let editingIndex = -1;
let editingExistingDetailId = null; // po_detail_id ของรายการเดิมที่กำลังแก้ (ถ้ามี)
let confirmed1 = ${empty poList.signDate ? 'false' : 'true'}; //track ว่าลงชื่อ ผู้ขอเบิก แล้วหรือยัง

const PO_CART_STORAGE_KEY = 'poDetailCart_draft_' + (EDIT_PO_ID || 'new');
loadCartFromSession();

function mapDbItemsTypeToSelect(val){
    switch(String(val)){
        case '1': return 'equipment';
        case '2': return 'consumables';
        case '3': return 'office';
        default:  return val; // เผื่อเป็น 'equipment'/'consumables'/'office' อยู่แล้ว
    }
}
function saveCartToSession(){
    try {
        sessionStorage.setItem(PO_CART_STORAGE_KEY, JSON.stringify(poDetailCart));
    } catch (e) {
        console.error('ไม่สามารถบันทึก cart ลง sessionStorage ได้', e);
    }
}

function loadCartFromSession(){
    try {
        const saved = sessionStorage.getItem(PO_CART_STORAGE_KEY);
        if (saved) {
            poDetailCart = JSON.parse(saved);
            
            poDetailCart = poDetailCart.map(item => ({
                ...item,
                price: Number(item.price) || 0,
                qty: Number(item.qty) || 0,
                total: Number(item.total) || (Number(item.qty) || 0) * (Number(item.price) || 0),
                savedAt: item.savedAt || formatNowDateTime()
            }));
        }
    } catch (e) {
        console.error('ไม่สามารถโหลด cart จาก sessionStorage ได้', e);
        poDetailCart = [];
    }
}

//กันข้อมูลหายตอน refresh
loadCartFromSession();
document.addEventListener('DOMContentLoaded', function(){
    if (poDetailCart.length > 0 || existingPoDetailList.length > 0) {
        renderPoDetailCart();
    }
});

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
        itemsTypeText: $("#items_type option:selected").text(),
        productId: $("#product_name").val(),
        productName: $("#product_name option:selected").text(),
        qty: Number($("#po_qty").val()),
        unit: $("#unit").val(),
		unitName: $("#unit option:selected").text(), 
        price: parseFormattedNumber($("#po_price").val()),
        description: $("#po_description").val(),
        savedAt: formatNowDateTime()
    };

    item.total = item.qty * item.price;

    if (editingExistingDetailId) {
        // แก้ไขรายการเดิมที่มีอยู่แล้วใน DB -> เรียก AJAX update ทันที
        updateExistingPoDetail(editingExistingDetailId, item);
        return;
    }

    if (editingIndex >= 0) {
        poDetailCart[editingIndex] = item;
        editingIndex = -1;
    } else {
        poDetailCart.push(item);
    }

    saveCartToSession();
    renderPoDetailCart();

    if (document.activeElement) {
        document.activeElement.blur();
    }

    const modalEl = document.getElementById("modal_create_po");
    const modal = bootstrap.Modal.getOrCreateInstance(modalEl);
    modal.hide();
}

function renderPoDetailCart(){

    let html = "";
    let grandTotal = 0;

    existingPoDetailList.forEach(function(item){

        html += createPoCard(item, null, item.poDetailId);
        grandTotal += item.total;

    });

    poDetailCart.forEach(function(item,index){

        html += createPoCard(item, index, null);
        grandTotal += item.total;

    });

    $("#poDetailCartContainer").html(html);

    $("#poDetailGrandTotal").text(
        grandTotal.toLocaleString(undefined,{
            minimumFractionDigits:2,
            maximumFractionDigits:2
        })
    );

}

//-------- PO- Detail -----------
function createPoCard(item,index,poDetailId){
	const safePrice = Number(item.price) || 0;
    const safeQty = Number(item.qty) || 0;
    const safeTotal = Number(item.total) || (safeQty * safePrice);

    let icon = "";
    let category = "";

    if(item.itemsType=="equipment" || item.itemsType=="1"){
        category="Equipment";
        icon=`
            <div class="symbol symbol-40px me-4">
                <i class="ki-duotone ki-monitor-mobile fs-2 text-primary">
                    <span class="path1"></span><span class="path2"></span>
                </i>
            </div>
        `;
    }else if(item.itemsType=="consumables" || item.itemsType=="2"){
        category="Consumables";
        icon=`
            <div class="symbol symbol-40px me-4">
                <i class="ki-duotone ki-lots-shopping fs-2 text-orange">
                    <span class="path1"></span><span class="path2"></span>
                    <span class="path3"></span><span class="path4"></span>
                    <span class="path5"></span><span class="path6"></span>
                    <span class="path7"></span><span class="path8"></span>
                </i>
            </div>
        `;
    }else{
        category="Office supplies";
        icon=`
            <div class="symbol symbol-40px me-4">
                <i class="ki-duotone ki-parcel fs-2 text-success">
                    <span class="path1"></span><span class="path2"></span>
                    <span class="path3"></span><span class="path4"></span>
                    <span class="path5"></span>
                </i>
            </div>
        `;
    }

    const groupId = poDetailId ? ("existing_" + poDetailId) : ("cart_" + index);
    const badgeNew = poDetailId ? "" : `<span class="badge badge-light-success me-3">New</span>`;

    let actionButtons = '';
    if (canEditPoDetail) {
        actionButtons = poDetailId
        ? `<a href="#" onclick="return editExistingCartItem('\${poDetailId}');" class="btn btn-icon btn-light-primary btn-sm" title="Edit">
                <i class="ki-duotone ki-pencil fs-2"><span class="path1"></span><span class="path2"></span></i>
            </a>
            <a href="#" onclick="return removeExistingCartItem('\${poDetailId}');" class="btn btn-icon btn-light-danger btn-sm" title="Delete">
                <i class="ki-duotone ki-trash fs-2"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i>
            </a>`
        : `<a href="#" onclick="return editCartItem(\${index});" class="btn btn-icon btn-light-primary btn-sm" title="Edit">
                <i class="ki-duotone ki-pencil fs-2"><span class="path1"></span><span class="path2"></span></i>
            </a>
            <a href="#" onclick="return removeCartItem(\${index});" class="btn btn-icon btn-light-danger btn-sm" title="Delete">
                <i class="ki-duotone ki-trash fs-2"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i>
            </a>`;
	}

    return `<div class="po-item-group border-gray-400 border-bottom py-9 px-6">
    			<div class="d-flex align-items-center justify-content-between row">
    				<div class="col-7 d-flex align-items-center">\${icon}
						<span class="text-gray-900 fs-5 fw-normal me-3">\${category}</span>
						<span class="text-gray-900 fs-5 fw-normal me-3">\${item.productName}</span>
		
						<div class="d-flex align-items-center">
							<i class="ki-duotone ki-document fs-2 text-muted me-2">
								<span class="path1"></span>
								<span class="path2"></span>
							</i>
		
							<span class="text-gray-900 fs-5 fw-normal">\${item.description} \${badgeNew}</span> 
		
						</div>
					</div>
		
					<div class="col-3 d-flex align-items-center justify-content-between px-0">
						<div class="col-2 d-flex flex-column text-end">
							<span class="fs-6 fw-normal text-gray-900">\${item.unitName}</span>
							<span class="fw-semibold text-gray-800 fs-5">\${item.qty}</span>
					</div>
		
					<div class="col-4 d-flex flex-column text-end">
						<span class="fs-6 fw-normal text-gray-900">Price</span>
						<span class="fw-semibold text-gray-800 fs-5">\${safePrice.toLocaleString(undefined, {minimumFractionDigits: 2, maximumFractionDigits: 2})}</span>
					</div>
					
					<div class="col-4 d-flex flex-column text-end">
						<span class="fs-6 fw-normal text-gray-900">Total</span>
						<span class="fs-5 fw-semibold text-primary">\${safeTotal.toLocaleString(undefined, {minimumFractionDigits: 2, maximumFractionDigits: 2})}</span>
					</div>
		
				</div>
		
				<div class="col-2 d-flex justify-content-end align-items-center gap-2 px-0">
	                \${actionButtons}
	                <a class="collapsed po-group-toggle" data-target="\${groupId}">
	                    <i class="ki-duotone ki-up-square fs-2hx">
	                        <span class="path1"></span><span class="path2"></span>
	                    </i>
	                </a>
            	</div>
			</div>
			
			<div class="collapse border-gray-300 border-top mt-3" id="poGroup_\${groupId}">
	            <div class="ps-9 pt-9">
	                <div class="d-flex align-items-center justify-content-between row">
	                    <div class="col-11">
	                        <div class="d-flex align-items-center fs-7">
	                            <div class="col-4">
	                                <i class="ki-duotone ki-user-tick fs-3 text-muted me-2">
	                                    <span class="path1"></span><span class="path2"></span><span class="path3"></span>
	                                </i>
	                                <span class="text-gray-800 fs-5">\${currentUserDisplay}</span>
	                            </div>
	                            <div class="col-4 d-flex align-items-center">
	                                <i class="ki-duotone ki-calendar-2 fs-3 me-2">
	                                    <span class="path1"></span><span class="path2"></span><span class="path3"></span>
	                                    <span class="path4"></span><span class="path5"></span>
	                                </i>
	                                <span class="text-gray-800 fs-5">\${item.savedAt}</span>
	                            </div>
	                            <div class="col-3 d-flex align-items-center">
				                    <i class="ki-duotone ki-tablet-book fs-3 me-2">
					                     <span class="path1"></span><span class="path2"></span>
									</i>
				                    <span class="badge badge-lg badge-light-primary text-primary fs-7 fw-semibold d-inline-block text-center">-</span>
		                    	</div>
	                        </div>
	                    </div>
	                    <div class="col-1 text-end">
	                        <span class="text-gray-800 fs-5">\${item.qty} \${item.unitName}</span>
	                    </div>
	                </div>
	            </div>
	        </div>
		
		</div>
		
		`;
}

function editCartItem(index){
    const item = poDetailCart[index];
    if (!item) return false;

    editingIndex = index;

    $('#modal_create_po .modal-title').text('Edit PO - Detail');
    $('#btnSavePoDetail').text('Update');

    $('#items_type').val(mapDbItemsTypeToSelect(item.itemsType)).trigger('change');

    const waitForProductList = setInterval(function(){
        if ($('#product_name option[value="' + item.productId + '"]').length > 0) {
            $('#product_name').val(item.productId).trigger('change');
            clearInterval(waitForProductList);
			
			const waitForUnitList = setInterval(function(){
                if ($('#unit option[value="' + item.unit + '"]').length > 0) {
                    $('#unit').val(item.unit);
                    clearInterval(waitForUnitList);
                }
            }, 100);
            setTimeout(function(){ clearInterval(waitForUnitList); }, 3000);
        }
    }, 100);

    setTimeout(function(){ clearInterval(waitForProductList); }, 3000);

    $('#po_qty').val(item.qty);
    // $('#unit').val(item.unit);
    $('#po_price').val(Number(item.price).toLocaleString(undefined, {minimumFractionDigits: 2, maximumFractionDigits: 2}));
    $('#po_description').val(item.description);

    const modalEl = document.getElementById("modal_create_po");
    const modal = bootstrap.Modal.getOrCreateInstance(modalEl);
    modal.show();

    return false;
}

function removeCartItem(index){
    Swal.fire({
        title: "Are you sure?!",
        text: "Are you sure you want to delete this item?",
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "Yes, delete it",
        cancelButtonText: "Cancel",
        buttonsStyling: false,
        customClass: {
            confirmButton: "btn btn-danger",
            cancelButton: "btn btn-secondary"
        }
    }).then((result) => {
        if (result.isConfirmed) {
            poDetailCart.splice(index, 1);
            saveCartToSession();
            renderPoDetailCart();
        }
    });
    return false;
}

/* ──────── แก้ไข / ลบ รายการที่มีอยู่แล้วใน DB ──────── */
function editExistingCartItem(poDetailId){
    const item = existingPoDetailList.find(function(d){ return String(d.poDetailId) === String(poDetailId); });
    if (!item) return false;

    editingExistingDetailId = poDetailId;
    editingIndex = -1;

    $('#modal_create_po .modal-title').text('Edit PO - Detail');
    $('#btnSavePoDetail').text('Update');

    $('#items_type').val(mapDbItemsTypeToSelect(item.itemsType)).trigger('change');

    const waitForProductList = setInterval(function(){
        if ($('#product_name option[value="' + item.productId + '"]').length > 0) {
            $('#product_name').val(item.productId).trigger('change');
            clearInterval(waitForProductList);

			const waitForUnitList = setInterval(function(){
                if ($('#unit option[value="' + item.unit + '"]').length > 0) {
                    $('#unit').val(item.unit);
                    clearInterval(waitForUnitList);
                }
            }, 100);
            setTimeout(function(){ clearInterval(waitForUnitList); }, 3000);
        }
    }, 100);

    setTimeout(function(){ clearInterval(waitForProductList); }, 3000);

    $('#po_qty').val(item.qty);
    // $('#unit').val(item.unit);
    $('#po_price').val(Number(item.price).toLocaleString(undefined, {minimumFractionDigits: 2, maximumFractionDigits: 2}));
    $('#po_description').val(item.description);

    const modalEl = document.getElementById("modal_create_po");
    const modal = bootstrap.Modal.getOrCreateInstance(modalEl);
    modal.show();

    return false;
}

function removeExistingCartItem(poDetailId){
    Swal.fire({
        title: "Are you sure?!",
        text: "Are you sure you want to delete this item?",
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "Yes, delete it",
        cancelButtonText: "Cancel",
        buttonsStyling: false,
        customClass: {
            confirmButton: "btn btn-danger",
            cancelButton: "btn btn-secondary"
        }
    }).then((result) => {
        if (result.isConfirmed) {
            $.ajax({
                url: ctx + '/delete_po_detail',
                type: 'POST',
                dataType: 'json',
                data: { poDetailId: poDetailId, poId: EDIT_PO_ID },
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
    return false;
}

function updateExistingPoDetail(poDetailId, item){
    $.ajax({
        url: ctx + '/update_po_detail',
        type: 'POST',
        dataType: 'json',
        data: {
            poDetailId: poDetailId,
            poId: EDIT_PO_ID,
            productId: item.productId,
            qty: item.qty,
            unit: item.unit,
            price: item.price,
            description: item.description
        },
        success: function (resp) {
            if (resp.data && resp.data.success) {
                editingExistingDetailId = null;
                const modalEl = document.getElementById("modal_create_po");
                bootstrap.Modal.getOrCreateInstance(modalEl).hide();
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

function parseFormattedNumber(str) {
    if (!str) return 0;
    return Number(String(str).replace(/,/g, ''));
}

$(document.body).on('input', '#po_price', function() {
    let value = $(this).val();

    value = value.replace(/[^0-9.]/g, '');

    const parts = value.split('.');
    if (parts.length > 2) {
        value = parts[0] + '.' + parts.slice(1).join('');
    }

    if (parts[0]) {
        parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ',');
    }

    $(this).val(parts.join('.'));
});

$(document.body).on('blur', '#po_price', function() {
    let raw = parseFormattedNumber($(this).val());
    if ($(this).val() === '' ) return;
    $(this).val(raw.toLocaleString(undefined, {
        minimumFractionDigits: 2,
        maximumFractionDigits: 2
    }));
});


//────────── Confirm Receiver ──────────
function confirmReceiver(slot) {
    if (!EDIT_PO_ID) return;

    const btn = document.getElementById('receiverBtn' + slot);
    btn.disabled = true; // กันกดซ้ำระหว่างรอ ajax

    $.ajax({
        url: ctx + '/confirm_po_sign',
        type: 'POST',
        dataType: 'json',
        data: { poId: EDIT_PO_ID },
        success: function (resp) {
            // if (resp.debug) console.log('[confirm_po_sign debug]', resp.debug);

            if (resp.data && resp.data.success) {
                confirmed1 = true;

                document.getElementById('receiverPreview' + slot).innerHTML =
                    '<span class="text-primary pb-2 fs-7 fw-semibold">ชื่อ ผู้ขอเบิก</span>' +
                    '<div class="d-flex flex-column align-items-center">' +
                        '<span class="text-dark fw-semibold fs-7">' + resp.data.signUserName + '</span>' +
                        '<span class="text-muted fs-8">' + resp.data.signDateDisplay + '</span>' +
                    '</div>';

                document.getElementById('receiverLabel' + slot).style.visibility = 'hidden';

                btn.textContent = '✓ ยืนยันแล้ว';
                btn.className = 'btn btn-success btn-sm px-5';
                btn.disabled = true;

				const card = document.getElementById('receiverCard' + slot);
                if (card) {
                    card.classList.remove('border-gray-300');
                    card.classList.add('border-success', 'bg-light-success');
                }

            } else {
                Swal.fire('Error', resp.data && resp.data.message ? resp.data.message : 'ไม่สามารถลงชื่อได้', 'error');
                btn.disabled = false;
            }
        },
        error: function () {
            Swal.fire('Error', 'เกิดข้อผิดพลาดในการลงชื่อ', 'error');
            btn.disabled = false;
        }
    });
}

function saveDraftForm(){
    const payload = {
		poId: EDIT_PO_ID || '',
        companyId: $('#vendor_id').val() || '',
        companyLocation: $('#vendor_location_id').val() || '',
        contactId: $('#contact_id').val() || '',
        description: $('#description').val() || '',
        descriptionVendor: $('#vendor_description').val() || '',
        referenceNo: $('#reference_no').val() || '',
        referenceDate: $('#kt_reference_datepicker').val() || '',
        poDetailCartJson: JSON.stringify(poDetailCart)
    };
 	$('#saveDraft').prop('disabled', true);
 
    $.ajax({
    	url: ctx + (EDIT_PO_ID ? '/update_po' : '/save_po'),
        type: 'POST',
        dataType: 'json',
        data: payload,
        success: function (resp) {
            // if (resp.debug) console.log('[save_po debug]', resp.debug);
            if (resp.data && resp.data.poId) {
                sessionStorage.removeItem(PO_CART_STORAGE_KEY);
                Swal.fire({
                    title: 'Success!',
                    text: 'Po saved draft successfully!',
                    icon: 'success'
                }).then(() => {
                    window.location.href = ctx + '/purchase_order_list';
                });
            } else {
                Swal.fire('Error', 'ไม่สามารถบันทึก Draft ได้', 'error');
            }
        },
        error: function () {
            Swal.fire('Error', 'เกิดข้อผิดพลาดในการบันทึก', 'error');
        }
    });
}

function validatePOForm(){
    let errors = [];
    if (!($('#description').val() || '').trim()) errors.push('Description');
    if (!($('#vendor_id').val() || '').trim()) errors.push('Company Name');
    if (!($('#vendor_location_id').val() || '').trim()) errors.push('Company Location');
    if (!($('#contact_id').val() || '').trim()) errors.push('Contact Name');
    const totalDetailCount = (existingPoDetailList ? existingPoDetailList.length : 0) + (poDetailCart ? poDetailCart.length : 0);
    if (totalDetailCount === 0) errors.push('Please add at least 1 Po Detail');

    const hasSignature = $('#hasSignature').val() === 'true';
    if (!hasSignature) errors.push('ลายเซ็น (Signature)');

    if (!confirmed1) errors.push('ลงชื่อ ผู้ขอเบิก');

    return errors;
}

function submitPO(){
    const errors = validatePOForm();

    if (errors.length > 0) {
        Swal.fire({
            title: 'Please complete the form!',
            /* html: errors.join('<br>'),
            icon: 'warning' */
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
        customClass: {
            confirmButton: "btn btn-success",
            cancelButton: "btn btn-secondary"
        }
    }).then((result) => {
        if (!result.isConfirmed) return;

        const payload = {
        	poId: EDIT_PO_ID || '',
            companyId: $('#vendor_id').val() || '',
            companyLocation: $('#vendor_location_id').val() || '',
            contactId: $('#contact_id').val() || '',
            description: $('#description').val().trim() || '',
            descriptionVendor: $('#vendor_description').val().trim() || '',
            referenceNo: $('#reference_no').val().trim() || '',
            referenceDate: $('#kt_reference_datepicker').val() || '',
            poDetailCartJson: JSON.stringify(poDetailCart),
            status: '2'
        };

        $('#savePOFormBtn').prop('disabled', true);

        $.ajax({
        	url: ctx + (EDIT_PO_ID ? '/update_po' : '/save_po'),
            type: 'POST',
            dataType: 'json',
            data: payload,
            success: function (resp) {
                // if (resp.debug) console.log('[save_po debug]', resp.debug);
                if (resp.data && resp.data.poId) {
                    sessionStorage.removeItem(PO_CART_STORAGE_KEY);
                    Swal.fire({
                        title: 'Success!',
                        text: 'Po saved successfully!',
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

function validateReason(){
    const reasonVal = $('#reason').val() ? $('#reason').val().trim() : '';

    if (!reasonVal) {
        $('#reason').addClass('is-invalid').css('border-color', '#f1416c');
        $('#reasonError').text('Please provide a reason.').removeClass('d-none');
        $('#reason').focus();
        return null;
    }

    if (reasonVal.length < 10) {
        $('#reason').addClass('is-invalid').css('border-color', '#f1416c');
        $('#reasonError').text('Reason must be at least 10 characters long.').removeClass('d-none');
        $('#reason').focus();
        return null;
    }

    $('#reason').removeClass('is-invalid').css('border-color', '');
    $('#reasonError').addClass('d-none');
    return reasonVal;
}

function returnPO(){
    const reasonVal = validateReason();
    if (reasonVal === null) return;

    const errors = validatePOForm();

    Swal.fire({
        title: "Are you sure?!",
        text: "Do you want to return this PO?",
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "Save",
        cancelButtonText: "Close",
        buttonsStyling: false,
        customClass: {
            confirmButton: "btn btn-success",
            cancelButton: "btn btn-secondary"
        }
    }).then((result) => {
        if (!result.isConfirmed) return;

        const payload = {
            poId: EDIT_PO_ID || '',
            reason: reasonVal,
            status: '3'
        };

        $('#returnPOBtn').prop('disabled', true);

        $.ajax({
            url: ctx + ('/update_status_po'),
            type: 'POST',
            dataType: 'json',
            data: payload,
            success: function (resp) {
                if (resp.data && resp.data.poId) {
                    sessionStorage.removeItem(PO_CART_STORAGE_KEY);
                    Swal.fire({
                        title: 'Success!',
                        text: 'Po returned successfully!',
                        icon: 'success'
                    }).then(() => {
                        window.location.href = ctx + '/purchase_order_list';
                    });
                } else {
                    Swal.fire('Error', 'ไม่สามารถคืน PO ได้', 'error');
                }
            },
            error: function () {
                Swal.fire('Error', 'เกิดข้อผิดพลาดในการส่งข้อมูล', 'error');
            },
            complete: function(){
                $('#returnPOBtn').prop('disabled', false);
            }
        });
    });
}

function editPO(){

    // Swal.fire({
    //     title: "Are you sure?!",
    //     text: "Do you want to return this PO?",
    //     icon: "warning",
    //     showCancelButton: true,
    //     confirmButtonText: "Save",
    //     cancelButtonText: "Close",
    //     buttonsStyling: false,
    //     customClass: {
    //         confirmButton: "btn btn-success",
    //         cancelButton: "btn btn-secondary"
    //     }
    // }).then((result) => {
    //     if (!result.isConfirmed) return;

        const payload = {
            poId: EDIT_PO_ID || '',
            status: '0'
        };

        $('#returnPOBtn').prop('disabled', true);

        $.ajax({
            url: ctx + ('/update_status_po'),
            type: 'POST',
            dataType: 'json',
            data: payload,
            success: function (resp) {
                // if (resp.data && resp.data.poId) {
                //     sessionStorage.removeItem(PO_CART_STORAGE_KEY);
                //     Swal.fire({
                //         title: 'Success!',
                //         text: 'Po returned successfully!',
                //         icon: 'success'
                //     }).then(() => {
                       location.reload();
                    // });
                // } else {
                //     Swal.fire('Error', 'ไม่สามารถคืน PO ได้', 'error');
                // }
            },
            error: function () {
                Swal.fire('Error', 'เกิดข้อผิดพลาดในการส่งข้อมูล', 'error');
            },
            complete: function(){
                $('#returnPOBtn').prop('disabled', false);
            }
        });
    // });
}


function rejectPO(){
    const reasonVal = validateReason();
    if (reasonVal === null) return;

    const errors = validatePOForm();

    Swal.fire({
        title: "Are you sure?!",
        text: "Do you want to reject this PO?",
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "Save",
        cancelButtonText: "Close",
        buttonsStyling: false,
        customClass: {
            confirmButton: "btn btn-success",
            cancelButton: "btn btn-secondary"
        }
    }).then((result) => {
        if (!result.isConfirmed) return;

        const payload = {
            poId: EDIT_PO_ID || '',
            reason: reasonVal,
            status: '5'
        };

        $('#rejectPOBtn').prop('disabled', true);

        $.ajax({
            url: ctx + ('/update_status_po'),
            type: 'POST',
            dataType: 'json',
            data: payload,
            success: function (resp) {
                if (resp.data && resp.data.poId) {
                    sessionStorage.removeItem(PO_CART_STORAGE_KEY);
                    Swal.fire({
                        title: 'Success!',
                        text: 'Po rejected successfully!',
                        icon: 'success'
                    }).then(() => {
                        window.location.href = ctx + '/purchase_order_list';
                    });
                } else {
                    Swal.fire('Error', 'ไม่สามารถปฏิเสธ PO ได้', 'error');
                }
            },
            error: function () {
                Swal.fire('Error', 'เกิดข้อผิดพลาดในการส่งข้อมูล', 'error');
            },
            complete: function(){
                $('#rejectPOBtn').prop('disabled', false);
            }
        });
    });
}

function approvePO(){
    Swal.fire({
        title: "Are you sure?!",
        text: "Do you want to approve this PO?",
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "Save",
        cancelButtonText: "Close",
        buttonsStyling: false,
        customClass: {
            confirmButton: "btn btn-success",
            cancelButton: "btn btn-secondary"
        }
    }).then((result) => {
        if (!result.isConfirmed) return;

        const payload = {
            poId: EDIT_PO_ID || '',
            status: '4' 
        };

        $('#approvePOBtn').prop('disabled', true);

        $.ajax({
            url: ctx + '/update_status_po',
            type: 'POST',
            dataType: 'json',
            data: payload,
            success: function (resp) {
                if (resp.data && resp.data.poId) {
                    sessionStorage.removeItem(PO_CART_STORAGE_KEY);
                    Swal.fire({
                        title: 'Success!',
                        text: 'PO approved successfully!',
                        icon: 'success'
                    }).then(() => {
                        window.location.href = ctx + '/purchase_order_list';
                    });
                } else {
                    Swal.fire('Error', 'ไม่สามารถอนุมัติ PO ได้', 'error');
                }
            },
            error: function () {
                Swal.fire('Error', 'เกิดข้อผิดพลาดในการส่งข้อมูล', 'error');
            },
            complete: function(){
                $('#approvePOBtn').prop('disabled', false);
            }
        });
    });
}

</script>

</html>