<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<script
	src="${pageContext.request.contextPath}/assets/js/custom/utilities/attachFile/attcahfile.js"></script>
<style>
/* ===== Table Header ===== */

#prResultTable thead th {
    white-space: nowrap !important;
    vertical-align: middle !important;
    padding-right: 35px !important;
}


/* ===== DataTables Header ===== */
 
#prResultTable thead th .dt-column-header {
    display: inline-flex !important;
    align-items: center !important;
    width: auto !important;
    white-space: nowrap !important;
}

#prResultTable thead th .dt-column-title {
    display: inline-block !important;
    white-space: nowrap !important;
}

/* ===== Remove old DataTables arrow ===== */

#prResultTable thead th.sorting::before,
#prResultTable thead th.sorting::after,
#prResultTable thead th.sorting_asc::before,
#prResultTable thead th.sorting_asc::after,
#prResultTable thead th.sorting_desc::before,
#prResultTable thead th.sorting_desc::after {
    display: none !important;
}

/* ===== First / Last Column ===== */

#prResultTable thead th:first-child{
    padding-right: 0 !important;
}

/* ===== PR Search Modal ===== */

#modal_search_pr .table-responsive {
    max-height: 45vh;
    overflow-y: auto;
}

/* ======= Signature Box ======= */

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

.po-src-actions { display: none; min-width: 80px; }
.po-src-menu.menu-open .po-src-actions { display: block; }
.po-src-menu.menu-open > .btn { background-color: var(--bs-primary); color: #fff; }
@media (max-width: 767.98px) {
	.po-src-actions { max-width: calc(100vw - 32px); }
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
						<span class="badge badge-lg bg-${poStatusColors[poList.status]} fw-semibold fs-7 p-4
									${poStatusColors[poList.status] == 'secondary' ? 'text-dark' : 'text-white'}">
							${poStatusNames[poList.status]}
						</span>
					</div>
			
				</div>
			</div>
			
			<div id="kt_app_content" class="app-content flex-column-fluid">
				<div id="kt_app_content_container" class="app-container container-fluid">
					<div class="row g-5 gx-xl-10">
						<div class="col-md-12 col-lg-7 col-xl-7 col-xxl-8 mb-md-5">
							<div class="card h-100">
								<div class="card-header border-0 px-9 pt-7 d-flex align-items-center justify-content-between">
									<div class="card-title">
										<h3 class="fw-semibold text-gray-900">PO - Header</h3>
									</div>
								</div>
								<div class="card-body filter-card px-10 py-9 rounded-3">
									<div class="row g-5">
										<div class="col-lg-6 col-md-6 col-12 d-flex align-items-center">
											<i class="ki-duotone ki-user-tick fs-3 me-3">
												<span class="path1"></span><span class="path2"></span><span class="path3"></span>
											</i>
											<span class="fs-6 fw-medium text-gray-800">${empty userCreate.employeeId ? '' : userCreate.employeeId} - ${empty userCreate.nameEN ? '' : userCreate.nameEN}</span>
										</div>

										<div class="col-lg-6 col-md-6 col-12 d-flex align-items-center">
											<i class="ki-duotone ki-calendar-2 fs-3 me-3">
												<span class="path1"></span><span class="path2"></span><span class="path3"></span>
												<span class="path4"></span><span class="path5"></span>
											</i>
											<span class="fs-6 fw-medium text-gray-800"><fmt:formatDate value="${poList.timeCreate}" pattern="d MMM yyyy" /></span>
										</div>

										<c:choose>
											<c:when test="${poList.status == '1'}">
												<div class="col-12 mt-9">
													<label class="required fw-medium text-gray-800 mb-5">Description</label>
													<textarea class="form-control text-gray-700" id="description" name="description"
														placeholder="Description" rows="3">${poList.description}</textarea>
												</div>
											</c:when>
											<c:otherwise>
												<div class="col-12 mt-9 d-flex align-items-center">
													<i class="ki-duotone ki-document fs-3 me-3">
														<span class="path1"></span><span class="path2"></span>
													</i>
													<span class="fs-6 fw-medium text-gray-800">${empty poList.description ? '-' : poList.description}</span>
												</div>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
							</div>
						</div>
						
						<div class="col-md-12 col-lg-5 col-xl-5 col-xxl-4 mb-md-5">
							<div class="card h-100 d-flex flex-column">
								<div class="card-header border-0 px-9 pt-7 d-flex align-items-center justify-content-between">
									<div class="card-title">
										<h3 class="fw-semibold text-gray-900">Attach files</h3>
									</div>
									<c:if test="${poList.status == '1'}">
										<label for="myFile" id="lbFile" class="btn btn-lg btn-primary d-inline-flex align-items-center justify-content-center fw-medium h-40px my-0">
											Upload
											<input type="file" id="myFile" name="files" multiple style="display:none;"
												accept="image/*,application/pdf,application/zip,application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document">
										</label>
									</c:if>
								</div>
								<div class="card-body filter-card px-10 py-9 rounded-3">
									<c:if test="${poList.status == '1'}">
										<div id="attachFileWarningBox" class="border border-2 border-warning rounded border-active active w-100"
											style="${not empty attachmentList ? 'display:none;' : ''}">
											<div class="py-5 d-flex flex-column align-items-center">
												<div class="fs-3 fw-bold text-warning d-flex justify-content-center align-items-center gap-2 mb-5">
													<i class="ki-duotone ki-information-2 fs-3x text-warning">
														<span class="path1"></span><span class="path2"></span><span class="path3"></span>
													</i> Attach files
												</div>
												<div class="d-flex justify-content-center align-items-center text-center fw-medium fs-7 mb-5 text-gray-800">
													Only English filenames are accepted.
												</div>
												<div class="d-flex justify-content-center align-items-center text-center fw-medium fs-7 text-muted">
													Files with Thai or special characters may<br> not open correctly after upload.
												</div>
											</div>
										</div>
									</c:if>
									<c:if test="${poList.status != '1' and empty attachmentList}">
										<div class="d-flex flex-column align-items-center justify-content-center text-center">
											<i class="ki-duotone ki-file-deleted fs-2x text-muted mb-3">
												<span class="path1"></span><span class="path2"></span>
											</i>
											<span class="fs-5 fw-medium text-muted">No files</span>
										</div>
									</c:if>

									<div class="d-flex flex-column h-100" style="min-height:0;">
										<div id="attachFileList" class="d-flex flex-column gap-2 mt-2">
											<c:forEach var="af" items="${attachmentList}">
												<c:set var="fType" value="${fn:toLowerCase(af.type)}" />
												<div class="d-flex align-items-center justify-content-center mb-2" data-file-id="${af.fileId}">
													<div class="d-flex align-items-center justify-content-between w-100 p-2 rounded">
														<a href="${pageContext.request.contextPath}${af.path}" target="_blank"
														class="d-flex align-items-center text-decoration-none text-gray-800 overflow-hidden" style="flex-grow:1;min-width:0;">
															<c:choose>
																<c:when test="${fType == '.pdf'}">
																	<img src="${pageContext.request.contextPath}/assets/media/svg/files/pdf.svg" class="w-25px h-25px me-3 flex-shrink-0" alt="icon" />
																</c:when>
																<c:when test="${fType == '.doc' or fType == '.docx'}">
																	<img src="${pageContext.request.contextPath}/assets/media/svg/files/doc.svg" class="w-25px h-25px me-3 flex-shrink-0" alt="icon" />
																</c:when>
																<c:when test="${fType == '.png' or fType == '.jpg' or fType == '.jpeg' or fType == '.gif' or fType == '.webp'}">
																	<img src="${pageContext.request.contextPath}/assets/media/svg/files/blank-image.svg" class="w-25px h-25px me-3 flex-shrink-0" alt="icon" />
																</c:when>
																<c:otherwise>
																	<img src="${pageContext.request.contextPath}/assets/media/svg/files/folder-document.svg" class="w-25px h-25px me-3 flex-shrink-0" alt="icon" />
																</c:otherwise>
															</c:choose>
															<span class="fs-6 fw-medium text-truncate" style="min-width:0;" title="${af.name}${af.type}">${af.name}${af.type}</span>
														</a>
														<c:if test="${poList.status == '1'}">
															<span class="badge badge-light-danger bg-hover cursor-pointer ms-3 flex-shrink-0"
																title="Delete" onclick="removeExistingAttachment('${af.fileId}', this)">
																<i class="ki-duotone ki-trash text-danger fs-2">
																	<span class="path1"></span><span class="path2"></span>
																	<span class="path3"></span><span class="path4"></span><span class="path5"></span>
																</i>
															</span>
														</c:if>
													</div>
												</div>
											</c:forEach>
										</div>
										<div id="errorMsgAF" class="text-danger fs-8 mt-1"></div>
									</div>
								</div>
							</div>
						</div>
						
					</div>
					
					
					<div class="card mb-10 mt-5">
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
											name="reference_no" id="reference_no" placeholder="Reference Invoice/Quotation NO" value="${poList.refNo}" ${poList.status != '1' ? 'disabled' : ''} />
								</div>
								
								<div class="col-lg-6 col-md-6 col-12 d-flex flex-column">
									<label class="fw-medium text-gray-800 mb-2">Reference Invoice/Quotation Date</label>
									<div class="position-relative d-flex align-items-center">
										<i class="ki-duotone ki-calendar-8 position-absolute ms-4 mb-1 text-gray-500 fs-3">
											<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span>
										</i>
										<input class="form-control text-gray-700 ps-12 h-45px" 
											   id="kt_reference_datepicker" name="reference_date" placeholder="Select date" 
											   value="<fmt:formatDate value="${poList.refDate}" pattern="yyyy-MM-dd"/>" ${poList.status != '1' ? 'disabled' : ''} />
									</div>
								</div>
							</div>
					
							<div class="row g-5 mb-6">
								
									<div class="col-lg-6 col-md-6 col-12 d-flex flex-column">
										<div class="d-flex justify-content-between align-items-center mb-2">
											<label class="required fw-medium text-gray-800">Company Name</label>
											<c:if test="${poList.status == '1'}">
												<a href="/company_add" target="_blank" class="text-success fw-medium fs-7 text-hover-primary" style="text-decoration: none;">
													<i class="ki-outline ki-plus fs-7 text-success me-1"></i>Create
												</a>
											</c:if>
										</div>
										<select name="vendor_id" id="vendor_id" class="form-select h-45px" data-control="select2" data-placeholder="Select Company Name" 
											${poList.status != '1' ? 'disabled' : ''}>
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
										<c:if test="${poList.status == '1'}">
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
									<textarea class="form-control text-gray-700" rows="3" name="vendor_description" id="vendor_description" placeholder="Description" ${poList.status != '1' ? 'disabled' : ''}>${poList.descriptionVendor}</textarea>
								</div>
							</div>
						</div>
					</div>
					
					<div class="card mb-10">
						<div class="card-header border-0 px-9 pt-7 d-flex align-items-center justify-content-between">
					        <div class="card-title">
					            <h3 class="fw-semibold text-gray-900">PO - Detail</h3>
					        </div>
							<c:if test="${poList.status == '1'}">
								<div class="card-title gap-3">
									<button type="button" id="btnOpenCreatePo" class="btn btn-lg btn-success fw-medium text-white px-6 py-4" >
										<i class="ki-outline ki-plus fs-3 me-1"></i>Create
									</button>
									
									<button type="button" id="btnOpenSearchPr" class="btn btn-lg btn-primary fw-medium text-white px-6 py-4">
										<i class="ki-duotone ki-magnifier fs-3 me-1">
											<span class="path1"></span><span class="path2"></span></i>Search PR
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
								<c:if test="${poList.status == '1'}">
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

												<c:when test="${poList.status == '1'}">
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
								<c:if test="${poList.status == '3' or poList.status == '7'}">
									<c:if test="${not empty poList.signDate}">
										<div class="col-6 p-16 m-0">
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
										<div class="col-6 p-16 m-0">
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
								<c:if test="${poList.status == '2' or poList.status == '4' or poList.status == '5' or poList.status == '6'}">
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

					<c:if test="${poList.status == '4' || poList.status == '5' || poList.status == '6'|| poList.status == '7'}">
						<c:choose>
							<c:when test="${poList.status == '4'}"><c:set var="actionLabel" value="Returned By"/></c:when>
							<c:when test="${poList.status == '5'}"><c:set var="actionLabel" value="Rejected By"/></c:when>
							<c:when test="${poList.status == '6'}"><c:set var="actionLabel" value="Cancel By"/></c:when>
							<c:when test="${poList.status == '7'}"><c:set var="actionLabel" value="In Progress By"/></c:when>
						</c:choose>

						<div class="card mb-10">
							<div class="card-body filter-card px-10 py-9 rounded-3">
								<div class="d-flex align-items-center fs-6">
									<span>${actionLabel} : ${userUpdate.employeeId} ${userUpdate.nameEN},
										<fmt:formatDate value="${poList.timeUpdate}" pattern="d MMM YYYY HH:mm" />
									</span>

									<c:if test="${(poList.status == '4' || poList.status == '5' || poList.status == '7') and not empty poList.reason}">
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
						<div class="modal-dialog modal-lg modal-dialog-centered">
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
													<option value="accessory">Accessory</option>
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
									
									<div class="row g-5 mb-6" id="poQtyUnitRow">
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
										<div class="col-lg-6 col-md-6 col-12 d-flex flex-column" id="poPriceRow">
											<label class="required fw-medium text-gray-800 mb-2">ราคารวม</label>
											<input type="text" class="form-control text-gray-700 h-45px"
													name="po_price" id="po_price" placeholder="0.00" />
										</div>
									
										<div class="col-lg-6 col-md-6 col-12 d-flex flex-column" id="poDescRow">
											<label class="fw-medium text-gray-800 mb-2">Description / Detail</label>
											<textarea class="form-control text-gray-700" rows="3" name="po_item_description" id="po_description" placeholder="Description"></textarea>
										</div>
									</div>
						        </div>
						
						        <div class="modal-footer">
						            <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
						            <button type="button" class="btn btn-success" id="btnSavePoDetail"
        									onclick="addPoDetailToCart()">
        									<span class="indicator-label">Save</span>
        									<span class="indicator-progress">Saving...<span class="spinner-border spinner-border-sm align-middle ms-2"></span></span>
        								</button>
						        </div>
						    </div>
						</div>
					</div>
					
					
					<div class="modal fade" tabindex="-1" id="modal_search_pr">
					    <div class="modal-dialog modal-xl">
					        <div class="modal-content px-3">
					            <div class="modal-header border-0">
					                <h3 class="modal-title">Search PR</h3>
					                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
					                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
					                </div>
					            </div>
					
					            <div class="modal-body">
					                <div class="row g-5 mb-3">
					                    <div class="col-lg-6 col-md-6 col-12 d-flex flex-column">
					                        <label class="required fw-medium text-gray-800 mb-2">Search PR</label>
					                        <div class="input-group">
					                            <input type="text" class="form-control text-gray-700 h-45px" name="searchPrKeyword" id="searchPrKeyword" />
					                        </div>
					                    </div>
					
					                    <div class="col-lg-6 col-md-6 col-12 d-flex flex-column">
					                        <label class="required fw-medium text-gray-800 mb-2">Category</label>
					                        <select name="searchPrCategory" id="searchPrCategory" class="form-select h-45px" data-control="select2">
					                            <option value="" selected>All</option>
					                            <option value="equipment">Equipment</option>
					                            <option value="consumables">Consumables</option>
												<option value="accessory">Accessory</option>
					                            <option value="office">Office supplies</option>
					                        </select>
					                    </div>
					                </div>
					
					                <div class="row g-5 mb-6 mt-3">
					                    <div class="d-flex align-items-center justify-content-between mb-4 ">
					                        <div class="d-flex align-items-center gap-2">
					                            <h3 class="text-gray-900 fw-bold">
					                                <span id="prItemsFoundCount"></span> Items Found
					                            </h3>
					                            <span id="prSortLabel" class="fw-bold fs-6 text-gray-500">by Recent Updates ↓</span>
					                        </div>
					                        <h3 class="text-primary fw-bold">
					                            <span id="prSelectedCount"></span> Selected
					                        </h3>
					                    </div>
					                    <div class="table-responsive">
					                        <table class="table align-middle gy-4 gs-7 border-bottom border-gray-200" id="prResultTable">
					                            <thead>
					                                <tr class="fs-7 fw-bold text-gray-500 text-uppercase border-bottom border-gray-200 mb-0">
					                                    <th class="min-w-15px ">
					                                        <div class="text-center form-check form-check-sm">
					                                            <input class="form-check-input" type="checkbox" id="checkAllPr" />
					                                        </div>
					                                    </th>
					                                    <th class="min-w-40px text-start mx-0">#</th>
					                                    <th class="min-w-80px">PR ID</th>
					                                    <th class="min-w-100px">Category</th>
					                                    <th class="min-w-200px">Request Name</th>
					                                    <th class="min-w-200px">Product</th>
					                                    <th class="min-w-100px text-end px-2">Status</th>
					                                </tr>
					                            </thead>
					                            <tbody id="prResultBody"></tbody>
					                        </table>
					                    </div>
					                    <div class="text-muted fs-7 mt-2" id="prNoResult" style="display:none;">No matching PR found.</div>
					                </div>
					            </div>
					
					            <div class="modal-footer pt-0 mt-0 mb-2 border-0">
					                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
					                <button type="button" class="btn btn-success" id="btnSubmitPr">Submit</button>
					            </div>
					        </div>
					    </div>
					</div>

					<div class="modal fade" tabindex="-1" id="modal_edit_source">
						<div class="modal-dialog modal-lg modal-dialog-centered">
							<div class="modal-content">
								<div class="modal-header">
									<h3 class="modal-title">Edit PO - Detail</h3>
									<div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
										<i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
									</div>
								</div>

								<div class="modal-body">
									<div class="d-flex align-items-center mb-4">
										<div class="symbol symbol-40px me-3" id="editSrcTypeIcon"></div>
										<span class="fs-6 fw-normal text-gray-900" id="editSrcTypeName"></span>
										<i class="ki-duotone ki-black-right mx-2 text-gray-500 fs-2">
											<span class="path1"></span><span class="path2"></span><span class="path3"></span>
										</i>
										<span class="fs-6 fw-normal text-gray-900" id="editSrcProduct"></span>
									</div>

									<div class="d-flex align-items-start justify-content-between gap-5 bg-light rounded p-5 mb-8">
                                        <div class="d-grid align-items-center flex-grow-1" style="grid-template-columns: auto 1fr; gap: .75rem 1rem;">

                                            <i class="ki-duotone ki-user-tick fs-3 text-muted"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i>
                                            <span class="text-gray-800 fs-5" id="editSrcCreator"></span>

                                            <i class="ki-duotone ki-calendar-2 fs-3"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i>
                                            <span class="text-gray-800 fs-5" id="editSrcDate"></span>

                                            <i class="ki-duotone ki-tablet-book fs-3"><span class="path1"></span><span class="path2"></span></i>
                                            <span class="d-flex flex-wrap align-items-center gap-2" id="editSrcMr"></span>
                                        </div>

                                        <div class="text-end flex-shrink-0">
                                            <div class="text-muted fs-8">ปัจจุบัน</div>
                                            <div class="text-gray-900 fs-5 fw-no" id="editSrcCurrent"></div>
                                        </div>

                                    </div>

									<div class="row g-5">
										<div class="col-12 col-sm-6 d-flex flex-column">
											<label class="required fw-medium text-gray-800 mb-2">จำนวน</label>
											<input type="number" class="form-control text-gray-700 h-45px" min="1" id="edit_src_qty" />
										</div>
										<div class="col-12 col-sm-6 d-flex flex-column">
											<label class="required fw-medium text-gray-800 mb-2">Unit</label>
											<select id="edit_src_unit" class="form-select h-45px" data-control="select2"
													data-dropdown-parent="#modal_edit_source" data-hide-search="true">
												<option value=""></option>
											</select>
										</div>
									</div>
									<div class="text-muted fs-7 mt-3" id="editSrcPreview"></div>
								</div>

								<div class="modal-footer">
									<button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
									<button type="button" class="btn btn-success" id="btnSaveEditSource" onclick="saveEditSource()">
										<span class="indicator-label">Update</span>
										<span class="indicator-progress">Updating...<span class="spinner-border spinner-border-sm align-middle ms-2"></span></span>
									</button>
								</div>
							</div>
						</div>
					</div>
					
					<div class="d-flex justify-content-between g-10">
						<div class="d-flex">
							<button type="button" id="backFormBtn" onclick="goBack()" 
                                class="btn btn-lg btn-light fw-medium text-light-inverse px-6 py-4 me-4 border">Back
							</button>
							<c:if test="${poList.status == '1' or poList.status == '4'}">
								<button type="button" id="cancelFormBtn"
									onclick="cancelPO()"
									class="btn btn-lg btn-dark fw-medium px-6 py-4">
									<span class="indicator-label">Cancel</span>
									<span class="indicator-progress">Cancelling...<span class="spinner-border spinner-border-sm align-middle ms-2"></span></span>
								</button>
							</c:if>
						</div>
						<c:choose>
							<c:when test="${poList.status == '1'}">
								<div class="d-flex">
									<button type="button" id="saveDraft" onclick="saveDraftForm()"
										class="btn btn-lg btn-cyan text-white fw-medium px-6 py-4 me-4">
										<span class="indicator-label">Save Draft</span>
										<span class="indicator-progress">Saving...<span class="spinner-border spinner-border-sm align-middle ms-2"></span></span>
									</button>
									<button type="button" id="savePOFormBtn"
										class="btn btn-success text-white fw-medium px-6 py-4"
										onclick="submitPO()">
										<span class="indicator-label">Submit PO</span>
										<span class="indicator-progress">Submitting...<span class="spinner-border spinner-border-sm align-middle ms-2"></span></span>
									</button>
								</div>
							</c:when>
							
							<c:when test="${poList.status == '2'}">
									<div class="d-flex">
										<button type="button" id="returnPOBtn" onclick="returnPO()"
												class="btn btn-lg btn-info text-white fw-medium px-6 py-4 me-4">
												<span class="indicator-label">Return</span>
												<span class="indicator-progress">Returning...<span class="spinner-border spinner-border-sm align-middle ms-2"></span></span>
											</button>
										<button type="button" id="rejectPOBtn" onclick="rejectPO()"
												class="btn btn-lg btn-danger text-white fw-medium px-6 py-4 me-4">
												<span class="indicator-label">Reject</span>
												<span class="indicator-progress">Rejecting...<span class="spinner-border spinner-border-sm align-middle ms-2"></span></span>
											</button>
										<button type="button" id="approvePOBtn" onclick="approvePO()"
													class="btn btn-lg btn-success text-white fw-medium px-6 py-4">
													<span class="indicator-label">Approve</span>
													<span class="indicator-progress">Approving...<span class="spinner-border spinner-border-sm align-middle ms-2"></span></span>
												</button>
									</div>
								
							</c:when>

							<c:when test="${poList.status == '4'}">
								<div class="d-flex">
									<button type="button" id="editPOFormBtn"
										class="btn btn-lg btn-primary fw-medium px-6 py-4"
										onclick="editPO()">
										<span class="indicator-label">Edit</span>
										<span class="indicator-progress">Loading...<span class="spinner-border spinner-border-sm align-middle ms-2"></span></span>
									</button>
								</div>
							</c:when>

							<c:when test="${poList.status == '3'}">
								<div class="d-flex">
									<button type="button" id="inProgressPOFormBtn"
										class="btn btn-lg bg-cyan text-white fw-medium px-6 py-4"
										onclick="inProgressPO()">
										<span class="indicator-label">In-Progress</span>
										<span class="indicator-progress">Processing...<span class="spinner-border spinner-border-sm align-middle ms-2"></span></span>
									</button>
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
	const canEditPoDetail = (poStatus === '1');
	
	let pendingLocationId = editLocationId || null;
	let pendingContactId  = editContactId  || null;
	
	const serverPoDetailCart = [
	    <c:forEach var="d" items="${poDetailList}" varStatus="st">
	    {
	        poDetailId: "${d.po_detail_id}",
	        productId: "${d.product_id}",
	        productName: "${fn:replace(fn:replace(empty d.product_name ? '' : d.product_name, '\\', '\\\\'), '"', '\\"')}",
            parentProductName: "${fn:replace(fn:replace(empty d.parent_product_name ? '' : d.parent_product_name, '\\', '\\\\'), '"', '\\"')}",
	        itemsType: "${empty d.product_type ? '' : d.product_type}",
	        qty: ${empty d.amount_total ? 0 : d.amount_total},
	        unit: "${empty d.unit ? '' : d.unit}",
			unitName: "${empty d.unit_name ? '' : d.unit_name}",
	        price: ${empty d.unit_price ? 0 : d.unit_price},
	        total: ${empty d.price_total ? 0 : d.price_total},
	        description: "${fn:replace(fn:replace(empty d.description ? '' : d.description, '\\', '\\\\'), '"', '\\"')}",
	        savedAt: "<fmt:formatDate value="${d.time_create}" pattern="d MMM yyyy, HH:mm"/>",
			sources: [
				<c:forEach var="p" items="${d.poParentList}" varStatus="ps">
				{
					poParentId: "${empty p.po_parent_id ? '' : p.po_parent_id}",
					prId: "${p.pr_id}",
					refLink: "${empty p.ref_link ? '' : p.ref_link}",
					qty: ${empty p.amount ? 0 : p.amount},
					unit: "${empty p.unit ? '' : p.unit}",
					unitName: "${empty p.unit_name ? '' : p.unit_name}",
					baseQty: ${empty p.base_qty ? (empty p.amount ? 0 : p.amount) : p.base_qty},
					creatorName: "${empty p.userEmployeeId ? '' : p.userEmployeeId} ${empty p.user_create_nameEN ? '' : ' - '.concat(p.user_create_nameEN)}",
					savedAt: "<fmt:formatDate value="${p.time_create}" pattern="d MMM yyyy, HH:mm"/>",
					mrIds: [
						<c:forEach var="m" items="${p.mrList}" varStatus="ms">
						{
							id: "${m.mr_id}",
							url: "${fn:replace(fn:replace(empty m.url_ref ? '' : m.url_ref, '\\', '\\\\'), '"', '\\"')}"
						}${!ms.last ? ',' : ''}
						</c:forEach>
					]
				}${!ps.last ? ',' : ''}
				</c:forEach>
			]
	    }${!st.last ? ',' : ''}
	    </c:forEach>
	];

	let existingAttachmentCount = ${not empty attachmentList ? fn:length(attachmentList) : 0};

	function formatNowDateTime(inputDate){
	    const d = inputDate ? new Date(String(inputDate).replace(' ', 'T')) : new Date();
	    const months = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
	    const pad = n => String(n).padStart(2,'0');
	    return `\${d.getDate()} \${months[d.getMonth()]} \${d.getFullYear()}, \${pad(d.getHours())}:\${pad(d.getMinutes())}`;
	}
	
	document.addEventListener("DOMContentLoaded", function () {
		flatpickr("#kt_reference_datepicker", {
	        dateFormat: "Y-m-d",  
	        altInput: true,
	        altFormat: "d M Y",   
	        locale: "en",        
	        allowInput: false
	    });
		
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
		    
		    if (!editCompanyId) { // เฉพาะ add เท่านั้น
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
		        setBtnLoading('#btnSavePoDetail', false);
		        if (editingIndex === -1 && !editingExistingDetailId) {
		            $('#items_type').val('equipment').trigger('change');
		            $('#po_qty').val('1');
		            $('#unit').val('');
		            $('#po_price').val('');
		            $('#po_description').val('');
		            $('#modal_create_po .modal-title').text('Create PO - Detail');
		            $('#btnSavePoDetail .indicator-label').text('Save');
					$('#poQtyUnitRow').removeClass('d-none');
					$('#poPriceRow').addClass('d-none');
        			$('#poDescRow').removeClass('col-lg-6 col-md-6');
				} else {
					// Edit
					$('#poQtyUnitRow').addClass('d-none');
					$('#poPriceRow').removeClass('d-none');
					$('#poDescRow').addClass('col-lg-6 col-md-6');
				}
		    });

		    createPoModalEl.addEventListener('hidden.bs.modal', function () {
				editingIndex = -1;
				editingExistingDetailId = null;
			});

			document.getElementById('modal_edit_source').addEventListener('hidden.bs.modal', function () {
				editingSrc = null;
			});

			document.getElementById('modal_edit_source').addEventListener('show.bs.modal', function () {
				setBtnLoading('#btnSaveEditSource', false);
			});
		    
			const btnOpenCreatePo = document.getElementById('btnOpenCreatePo');
			if (btnOpenCreatePo) {
				btnOpenCreatePo.addEventListener('click', function () {
					editingIndex = -1;
					editingExistingDetailId = null;
					bootstrap.Modal.getOrCreateInstance(createPoModalEl, { backdrop: true }).show();
				});
			}

			const searchPrModalEl = document.getElementById('modal_search_pr');

			searchPrModalEl.addEventListener('hide.bs.modal', function () {
				if (document.activeElement && searchPrModalEl.contains(document.activeElement)) {
					document.activeElement.blur();
				}
			});

			searchPrModalEl.addEventListener('hidden.bs.modal', function () {
				isSearchPrModalOpen = false;

				// ล้างติ๊กค้างใน modal Search PR
				if (prDetailTable) { prDetailTable.destroy(); prDetailTable = null; }
				$('#prResultBody').empty();
				$('#checkAllPr').prop('checked', false);
				$('#prSelectedCount').text('0');
			
				selectedPrCategory = '';
				$('#searchPrCategory').val('').trigger('change.select2');
			});

			searchPrModalEl.addEventListener('show.bs.modal', function () {
				isSearchPrModalOpen = true;
				loadInprogressPrDetail();
			});

			const btnOpenSearchPr = document.getElementById('btnOpenSearchPr');
			if (btnOpenSearchPr) {
				btnOpenSearchPr.addEventListener('click', function () {
					bootstrap.Modal.getOrCreateInstance(searchPrModalEl).show();
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
				sessionStorage.removeItem(PO_EXISTING_SRC_KEY);
				sessionStorage.removeItem(PO_EXISTING_EDIT_KEY);
				sessionStorage.removeItem(PO_SOURCE_EDIT_KEY);
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
	
	// --- Multi-file Attach ---
	var selectedFiles = [];

	function getFileIconPath(fileName) {
	    var ext = fileName.split('.').pop().toLowerCase();
	    switch (ext) {
	        case 'pdf': return ctx + '/assets/media/svg/files/pdf.svg';
	        case 'doc': case 'docx': return ctx + '/assets/media/svg/files/doc.svg';
	        case 'png': case 'jpg': case 'jpeg': case 'gif': case 'webp':
	            return ctx + '/assets/media/svg/files/blank-image.svg';
	        default: return ctx + '/assets/media/svg/files/folder-document.svg';
	    }
	}

	async function processFiles(fileListInput) {
	    var maxSize = 5 * 1024 * 1024;
	    var oversizedFiles = [];
	    var errorMsgAF = document.getElementById('errorMsgAF');

	    for (let i = 0; i < fileListInput.length; i++) {
	        const file = fileListInput[i];
	        const existing = selectedFiles.find(f => f.name === file.name && f.size === file.size);
	        if (existing) continue;

	        if (file.type.match(/image\/(jpeg|jpg|png)/)) {
	            const processedFile = await compressImage(file);
	            selectedFiles.push(processedFile);
	        } else if (file.size > maxSize) {
	            oversizedFiles.push(file.name);
	        } else {
	            selectedFiles.push(file);
	        }
	    }
	    if (errorMsgAF) {
	        errorMsgAF.innerHTML = oversizedFiles.length > 0
	            ? 'Files exceed 5MB: <strong>' + oversizedFiles.join(', ') + '</strong>' : '';
	    }
	    renderNewFileList();
	    updateInputFiles();
	}

	function updateWarningBoxVisibility() {
		var warn = document.getElementById('attachFileWarningBox');
		if (!warn) return;
		var totalFiles = existingAttachmentCount + selectedFiles.length;
		warn.style.display = totalFiles > 0 ? 'none' : 'block';
	}

	function renderNewFileList() {
		var container = document.getElementById('attachFileList');
		if (!container) return;

		container.querySelectorAll('.new-attach-item').forEach(function (el) { el.remove(); });

		selectedFiles.forEach(function (file) {
			const fileName = file.name;
			const lastDotIndex = fileName.lastIndexOf('.');
			const nameOnly = lastDotIndex > -1 ? fileName.substring(0, lastDotIndex) : fileName;
			const fileExt = lastDotIndex > -1 ? fileName.substring(lastDotIndex) : '';
			const iconPath = getFileIconPath(fileName);

			const wrapper = document.createElement('div');
			wrapper.className = 'd-flex align-items-center justify-content-center mb-2 new-attach-item';

			wrapper.innerHTML =
				'<div class="d-flex align-items-center justify-content-between w-100 p-2 rounded">' +
					'<div class="d-flex align-items-center overflow-hidden" style="flex-grow:1;min-width:0;">' +
						'<img src="' + iconPath + '" class="w-25px h-25px me-3 flex-shrink-0" alt="icon" />' +
						'<span class="fs-6 fw-medium d-flex" style="min-width:0;" title="' + fileName + '">' +
							'<span class="text-truncate">' + nameOnly + '</span>' +
							'<span class="text-gray-800 fw-medium flex-shrink-0">' + fileExt + '</span>' +
						'</span>' +
					'</div>' +
					'<span class="badge badge-light-danger bg-hover cursor-pointer ms-2 flex-shrink-0" title="Delete">' +
						'<i class="ki-duotone ki-trash text-danger fs-2">' +
							'<span class="path1"></span><span class="path2"></span>' +
							'<span class="path3"></span><span class="path4"></span><span class="path5"></span>' +
						'</i>' +
					'</span>' +
				'</div>';

			wrapper.querySelector('.badge-light-danger').addEventListener('click', function () {
				selectedFiles = selectedFiles.filter(f => f.name !== fileName);
				renderNewFileList();
				updateInputFiles();
			});

			container.appendChild(wrapper);
		});
		 updateWarningBoxVisibility();
	}

	function updateInputFiles() {
	    var inputFile = document.getElementById('myFile');
	    if (!inputFile) return;
	    var dataTransfer = new DataTransfer();
	    selectedFiles.forEach(file => dataTransfer.items.add(file));
	    inputFile.files = dataTransfer.files;
	}

	(function initAttach() {
	    var input = document.getElementById('myFile');
	    if (input) input.addEventListener('change', function (event) { processFiles(event.target.files); });
	})();
	
	function removeExistingAttachment(fileId, el){
	    Swal.fire({
	        title: "Are you sure?!",
	        text: "Are you sure you want to delete this file?",
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
	        if (!result.isConfirmed) return;

	        $.ajax({
	            url: ctx + '/delete_po_attachment',
	            type: 'POST',
	            dataType: 'json',
	            data: { fileId: fileId },
	            success: function (resp) {
	                if (resp.data && resp.data.success) {
	                    $(el).closest('[data-file-id]').remove();
						existingAttachmentCount = Math.max(0, existingAttachmentCount - 1);
        				updateWarningBoxVisibility();
                        toastOk('ลบไฟล์สำเร็จ');
	                } else {
	                    toastFail('ไม่สามารถลบไฟล์ได้');
	                }
	            },
	            error: function () {
	              toastFail('เกิดข้อผิดพลาดในการลบไฟล์');
	            }
	        });
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
				finalFile = await processAndRemoveWhiteBg(file);
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
	
	const isVendorReadOnly = ${poList.status != '1' ? 'true' : 'false'};
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
		$('#unit').html('<option value=""></option>').data('base-unit-id', '').data('base-unit-name', '').trigger('change');
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
				var baseUnit = null;
				if (list.length === 0) {
					options = '<option value=""></option>';
				} else {
					list.forEach(function (item, index) {
						if (String(item.sequence) === '0') baseUnit = item;
						options += '<option value="' + item.id + '"'
							+ ' data-conversion-rate="' + (item.conversionRate != null ? item.conversionRate : 1) + '"'
							+ ' data-sequence="' + (item.sequence != null ? item.sequence : '') + '"'
							+ (index === 0 ? ' selected' : '') + '>' + item.name + '</option>';
					});
				}

				$('#unit').html(options)
					.data('base-unit-id', baseUnit ? baseUnit.id : '')
					.data('base-unit-name', baseUnit ? baseUnit.name : '')
					.trigger('change');
			},
			error: function () {
				Swal.fire('Error', 'ไม่สามารถโหลดข้อมูล Unit ได้', 'error');
			}
		});
	});
	
</script>

<script>
let poDetailCart = []; // เก็บรายการใหม่ ที่เพิ่มระหว่างแก้ไข ยังไม่ถูกบันทึกลง DB
let existingPoDetailList = (typeof serverPoDetailCart !== 'undefined') ? serverPoDetailCart : []; // รายการเดิมที่มีอยู่แล้วใน DB
let poDetailCounter = 0;
let editingIndex = -1;
let editingExistingDetailId = null; // po_detail_id ของรายการเดิมที่กำลังแก้ (ถ้ามี)
let pendingExistingPoSources = {}; //source ใหม่ที่ต่อเข้าการ์ดเดิม ยังไม่ save
let prUnitCatalogCache = {};
let confirmed1 = ${empty poList.signDate ? 'false' : 'true'}; //track ว่าลงชื่อ ผู้ขอเบิก แล้วหรือยัง

let pendingExistingEdits = {}; // { poDetailId: { total, description } } ส่วนของ db ที่ผู้ใช้แก้ไว้ ยังไม่ save
const PO_EXISTING_EDIT_KEY = 'poExistingEdit_draft_' + (EDIT_PO_ID || 'new');

let pendingSourceEdits = {}; // { poDetailId: { poParentId: { qty, unit, unitName, baseQty } } } แก้ qty/unit ของ source เดิมใน db ยังไม่ save
const PO_SOURCE_EDIT_KEY = 'poSourceEdit_draft_' + (EDIT_PO_ID || 'new');

const PO_CART_STORAGE_KEY = 'poDetailCart_draft_' + (EDIT_PO_ID || 'new');
const PO_EXISTING_SRC_KEY = 'poExistingSrc_draft_' + (EDIT_PO_ID || 'new');
loadCartFromSession();


function pendingSrcTotal(poDetailId){
    return (pendingExistingPoSources[String(poDetailId)] || [])
        .reduce(function(a, s){ return a + (Number(s.total) || 0); }, 0);
}
function dbTotalOf(item){   // ยอดส่วนของ db (รวมที่แก้ค้างไว้)
    const e = pendingExistingEdits[String(item.poDetailId)];
    return e ? Number(e.total) : (Number(item.total) || 0);
}
function dbDescOf(item){
    const e = pendingExistingEdits[String(item.poDetailId)];
    return e ? e.description : (item.description || '');
}

function hasUnsavedChanges(){
    if (!canEditPoDetail) return false;   // เตือนเฉพาะ status = 1
    if (poDetailCart.length > 0) return true;
    if (Object.keys(pendingExistingEdits).length > 0) return true;
    const hasPendingSrc = Object.keys(pendingExistingPoSources).some(function(k){
        return (pendingExistingPoSources[k] || []).length > 0;
    });
    if (hasPendingSrc) return true;
    const hasPendingSrcEdit = Object.keys(pendingSourceEdits).some(function(k){
        return Object.keys(pendingSourceEdits[k] || {}).length > 0;
    });
    if (hasPendingSrcEdit) return true;
    if (typeof selectedFiles !== 'undefined' && selectedFiles.length > 0) return true;
    return false;
}

function mapDbItemsTypeToSelect(val){
    switch(String(val)){
        case '1': return 'equipment';
        case '2': return 'consumables';
		case '3': return 'accessory';
        case '4': return 'office';
        default:  return val;
    }
}

// ถ้าสินค้านี้มีการ์ดอยู่ใน DB แล้ว เก็บเป็น source ใหม่ของการ์ดนั้น คืน true ถ้าจัดการให้แล้ว
function addToExistingPoDetail(productId, sourceEntry, addTotal){
    const ex = existingPoDetailList.find(function(it){
        return String(it.productId) === String(productId);
    });
    if (!ex) return false;

    const pid = String(ex.poDetailId);
    const pending = pendingExistingPoSources[pid] || [];

    // กันดึง PR detail ซ้ำ
    if (sourceEntry.prDetailId) {
        const dup = (ex.sources || []).concat(pending).some(function(s){
            return String(s.prDetailId) === String(sourceEntry.prDetailId);
        });
        if (dup) return true;
    }
    pending.push({ ...sourceEntry, total: Number(addTotal) || 0 });
    pendingExistingPoSources[pid] = pending;
    return true;
}

function saveCartToSession(){
    try {
        sessionStorage.setItem(PO_CART_STORAGE_KEY, JSON.stringify(poDetailCart));
        sessionStorage.setItem(PO_EXISTING_SRC_KEY, JSON.stringify(pendingExistingPoSources));
        sessionStorage.setItem(PO_EXISTING_EDIT_KEY, JSON.stringify(pendingExistingEdits));
        sessionStorage.setItem(PO_SOURCE_EDIT_KEY, JSON.stringify(pendingSourceEdits));
    } catch (e) { console.error('ไม่สามารถบันทึก cart ลง sessionStorage ได้', e); }
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

			const savedEx = sessionStorage.getItem(PO_EXISTING_SRC_KEY);
			if (savedEx) pendingExistingPoSources = JSON.parse(savedEx) || {};
        }
        const savedEdit = sessionStorage.getItem(PO_EXISTING_EDIT_KEY);
if (savedEdit) pendingExistingEdits = JSON.parse(savedEdit) || {};
        const savedSrcEdit = sessionStorage.getItem(PO_SOURCE_EDIT_KEY);
        if (savedSrcEdit) pendingSourceEdits = JSON.parse(savedSrcEdit) || {};
    } catch (e) {
        console.error('ไม่สามารถโหลด cart จาก sessionStorage ได้', e);
        poDetailCart = [];
		pendingExistingPoSources = {};
        pendingExistingEdits = {};
        pendingSourceEdits = {};
    }
}

//กันข้อมูลหายตอน refresh
loadCartFromSession();
document.addEventListener('DOMContentLoaded', function(){
    renderPoDetailCart();
   
});

function validatePoDetailForm(){
    let errors = [];

    if (!$('#items_type').val() || !$('#items_type').val().trim()) errors.push('Category');
    if (!$('#product_name').val() || !$('#product_name').val().trim()) errors.push('Product Name');

    const qty = $('#po_qty').val().trim();
    if (!qty || Number(qty) <= 0) errors.push('จำนวน');

    if (!$('#unit').val().trim()) errors.push('Unit');

    if (editingIndex >= 0 || editingExistingDetailId) {
        const price = $('#po_price').val().trim();
        if (!price || parseFormattedNumber(price) < 0) errors.push('ราคารวม');
    }

    return errors;
}

function setBtnLoading(selector, loading){
    const el = document.querySelector(selector);
    if (!el) return;
    if (loading) { el.setAttribute('data-kt-indicator', 'on'); el.disabled = true; }
    else { el.removeAttribute('data-kt-indicator'); el.disabled = false; }
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

    setBtnLoading('#btnSavePoDetail', true);

    setTimeout(function(){
    // po_qty/unit คือหน่วยที่ user เลือก (อาจไม่ใช่หน่วยเล็กสุด) 
    // ส่วน po_price (base unit) ก่อนเก็บลง cart เสมอ
    const rawQty = Number($("#po_qty").val()) || 0;
    const rawUnitId = $("#unit").val();
    const rawUnitName = $("#unit option:selected").text();
    const conversionRate = Number($("#unit option:selected").data('conversion-rate')) || 1;
    const baseUnitId = $('#unit').data('base-unit-id') || rawUnitId;
    const baseUnitName = $('#unit').data('base-unit-name') || rawUnitName;
    const baseQty = rawQty * conversionRate;
    const total = parseFormattedNumber($("#po_price").val());
    const price = baseQty > 0 ? (total / baseQty) : 0;
    const description = $("#po_description").val();

    const item = {
        itemsType: $("#items_type").val(),
        itemsTypeText: $("#items_type option:selected").text(),
        productId: $("#product_name").val(),
        productName: $("#product_name option:selected").text(),
        qty: baseQty,
        unit: baseUnitId,
		unitName: baseUnitName,
        price: price,
        total: total,
        description: description,
        savedAt: formatNowDateTime()
    };

    if (editingExistingDetailId) {
        const id = String(editingExistingDetailId);
        const newDbTotal = total - pendingSrcTotal(id);
        if (newDbTotal < 0) {
            Swal.fire('Error', 'ราคารวมต้องไม่น้อยกว่ายอดของรายการที่เพิ่มใหม่ที่ยังไม่ได้บันทึก', 'error');
            setBtnLoading('#btnSavePoDetail', false);
            return;
        }
        pendingExistingEdits[id] = { total: newDbTotal, description: description };
        editingExistingDetailId = null;
        saveCartToSession();
        renderPoDetailCart();
        if (document.activeElement) document.activeElement.blur();
        bootstrap.Modal.getOrCreateInstance(document.getElementById("modal_create_po")).hide();
        return;
    }

    if (editingIndex >= 0) {
		const old = poDetailCart[editingIndex];

		// เก็บ sources เดิมไว้ ถ้ายังเป็น product เดิม
		if (old && old.sources && old.sources.length > 0
				&& String(old.productId) === String(item.productId)) {
			item.sources = old.sources;
		}

        poDetailCart[editingIndex] = item;
        editingIndex = -1;
    } else {
		// สร้างใหม่ เช็คก่อนว่ามี item productId เดียวกันอยู่แล้วใน cart มั้ย ไม่ว่าจะมาจากการสร้างเองมาก่อน หรือดึงจาก PR มาก่อน ก็ต้อง group เข้าด้วยกัน
        const sourceEntry = {
            prId: null,
            prDetailId: null,
            mrIds: [],
            qty: rawQty,
            unit: rawUnitId,
            unitName: rawUnitName,
            baseQty: baseQty,
            refLink: '',
            creatorName: currentUserDisplay,
            savedAt: formatNowDateTime()
        };

		if (addToExistingPoDetail(item.productId, sourceEntry, 0)) {
			saveCartToSession();
			renderPoDetailCart();
			if (document.activeElement) document.activeElement.blur();
			bootstrap.Modal.getOrCreateInstance(document.getElementById("modal_create_po")).hide();
			return;
		}

        const existingIndex = poDetailCart.findIndex(function(it){
            return String(it.productId) === String(item.productId);
        });

        if (existingIndex >= 0) {
            const existing = poDetailCart[existingIndex];
            // ถ้า item เดิมยังไม่มี sources (สร้างเองรายการเดียวไม่เคยดึงจาก PR) ให้ห่อตัวเอง เป็น source แรกก่อน
            if (!existing.sources || existing.sources.length === 0) {
         // existing.unit ตอนนี้เป็นหน่วยเล็กสุด (base) ไปแล้วตั้งแต่ตอนสร้างไม่ใช่หน่วยดิบที่ user เลือกตอนนั้นจริงๆ (เก็บไว้เฉพาะ item ใหม่ที่สร้างหลังแก้นี้)
                existing.sources = [{
                    prId: existing.prId || null,
                    prDetailId: existing.prDetailId || null,
                    mrIds: existing.mrIds || [],
                    qty: existing.qty,
                    unit: existing.unit,
                    unitName: existing.unitName,
                    baseQty: existing.qty,
                    refLink: existing.refLink || '',
                    creatorName: existing.creatorName || currentUserDisplay,
                    savedAt: existing.savedAt || formatNowDateTime()
                }];
            }

            existing.sources.push(sourceEntry);
            existing.qty = (Number(existing.qty) || 0) + baseQty;
            existing.price = existing.qty > 0 ? (existing.total / existing.qty) : 0;
            if (!existing.description && description) {
                existing.description = description;
            }
        } else {
            item.sources = [sourceEntry];
            poDetailCart.push(item);
        }
    }

    saveCartToSession();
    renderPoDetailCart();

    if (document.activeElement) {
        document.activeElement.blur();
    }

    const modalEl = document.getElementById("modal_create_po");
    const modal = bootstrap.Modal.getOrCreateInstance(modalEl);
    modal.hide();
    }, 300);
}

function renderPoDetailCart(){

    let html = "";
    let grandTotal = 0;

    existingPoDetailList.forEach(function(item){

        html += createPoCard(item, null, item.poDetailId);
        grandTotal += dbTotalOf(item);

    });

	Object.keys(pendingExistingPoSources).forEach(function(pid){
		pendingExistingPoSources[pid].forEach(function(s){ grandTotal += Number(s.total) || 0; });
	});

    poDetailCart.forEach(function(item,index){

        html += createPoCard(item, index, null);
        grandTotal += item.total;

    });

	const totalCount = existingPoDetailList.length + poDetailCart.length;

    if (totalCount === 0 ) {
        html = `
            <div class="d-flex flex-column align-items-center justify-content-center py-5 text-center">
                <i class="ki-duotone ki-file-deleted fs-2x text-muted mb-3">
                    <span class="path1"></span><span class="path2"></span>
                </i>
                <span class="fs-5 fw-medium text-muted">No items</span>
            </div>
        `;
    }

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
    const safeTotal = poDetailId ? dbTotalOf(item) : (Number(item.total) || (safeQty * safePrice));
	const pending = poDetailId ? (pendingExistingPoSources[String(poDetailId)] || []) : [];
	const pendingQty = pending.reduce(function(a, s){ return a + (Number(s.baseQty != null ? s.baseQty : s.qty) || 0); }, 0);
	const pendingTotal = pending.reduce(function(a, s){ return a + (Number(s.total) || 0); }, 0);
	const srcEditsMap = poDetailId ? (pendingSourceEdits[String(poDetailId)] || {}) : {};
	// แก้ qty ของ source เดิมที่ยัง pending ยอด qty รวมของการ์ดต้องขยับตาม แต่ total คงเดิม
	const editQtyDelta = (item.sources || []).reduce(function(a, s){
		if (!s.poParentId || !srcEditsMap[String(s.poParentId)]) return a;
		const oldBase = Number(s.baseQty != null ? s.baseQty : s.qty) || 0;
		const newBase = Number(srcEditsMap[String(s.poParentId)].baseQty) || 0;
		return a + (newBase - oldBase);
	}, 0);
	const displayQty = safeQty + pendingQty + editQtyDelta;
	const displayTotal = safeTotal + pendingTotal;
	const displayPrice = displayQty > 0 ? (displayTotal / displayQty) : 0;
	const totalColorClass = displayTotal <= 0 ? 'text-danger' : 'text-primary';

	let baseSources = (item.sources || []).map(function(s){
		if (!s.poParentId) return s;
		const e = srcEditsMap[String(s.poParentId)];
		return e ? { ...s, qty: e.qty, unit: e.unit, unitName: e.unitName, baseQty: e.baseQty, edited: true } : s;
	});
	if (baseSources.length === 0 && pending.length > 0 && safeQty > 0) {
		// การ์ดเดิมไม่มี po_parent ห่อตัวเองเป็นแถวแรก ไม่งั้นยอดเดิมจะหายจากการแสดงผล
		baseSources = [{ prId: null, mrIds: [], qty: safeQty, unitName: item.unitName, baseQty: safeQty,
						refLink: '', creatorName: '', savedAt: item.savedAt }];
	}
	const allSources = baseSources.concat(pending);
	const pendingStartIndex = baseSources.length;

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
    }else if(item.itemsType=="accessory" || item.itemsType=="3"){
        category="Accessory";
        icon=`
            <div class="symbol symbol-40px me-4">
                <i class="ki-duotone ki-medal-star fs-2 text-teal">
                    <span class="path1"></span><span class="path2"></span>
                    <span class="path3"></span><span class="path4"></span>
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
	const displayProductName = item.parentProductName
		? item.parentProductName + ' > ' + (item.productName || '')
		: (item.productName || '');

    const descText = poDetailId ? dbDescOf(item) : (item.description || '');
    const descriptionHtml = (descText
        ? '<i class="ki-duotone ki-document fs-2 text-muted me-2">'
            + '<span class="path1"></span><span class="path2"></span>'
        + '</i>'
        + '<span class="text-gray-900 fs-5 fw-normal">' + descText + '</span> '
        : '');

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

    return `<div class="po-item-group border-gray-400 border-bottom pt-9 pb-6 px-6">
    			<div class="d-flex align-items-center justify-content-between row">
    				<div class="col-7 d-flex align-items-center">\${icon}
						<span class="text-gray-900 fs-5 fw-normal me-3">\${category}</span>
						<span class="text-gray-900 fs-5 fw-normal me-3">\${displayProductName}</span>

						<div class="d-flex align-items-center">
							\${descriptionHtml}
						</div>
					</div>
		
					<div class="col-3 d-flex align-items-center justify-content-between px-0">
						<div class="col-2 d-flex flex-column text-end">
							<span class="fs-6 fw-normal text-gray-900">\${item.unitName}</span>
							<span class="fw-semibold text-gray-800 fs-5">\${displayQty}</span>
					</div>
		
					<div class="col-4 d-flex flex-column text-end">
						<span class="fs-6 fw-normal text-gray-900">Price/Unit</span>
						<span class="fw-semibold text-gray-800 fs-5">\${displayPrice.toLocaleString(undefined, {minimumFractionDigits: 2, maximumFractionDigits: 2})}</span>
					</div>
					
					<div class="col-4 d-flex flex-column text-end">
						<span class="fs-6 fw-normal text-gray-900">Total</span>
						<span class="fs-5 fw-semibold \${totalColorClass}">\${displayTotal.toLocaleString(undefined, {minimumFractionDigits: 2, maximumFractionDigits: 2})}</span>
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
	                \${
						(allSources.length > 0)
							? allSources.map(function(s, i){
								var srcBaseQty = (s.baseQty != null) ? s.baseQty : s.qty;
								var isNewSource = !!poDetailId && i >= pendingStartIndex;

								var menuCtx = null;
								if (canEditPoDetail) {
									if (!poDetailId) menuCtx = { scope: 'cart', a: index, b: i };
									else if (isNewSource) menuCtx = { scope: 'pending', a: poDetailId, b: i - pendingStartIndex };
									else if (s.poParentId) menuCtx = { scope: 'db', a: poDetailId, b: i };
								}
								return createPoSourceRow(s.qty, s.unitName || item.unitName, srcBaseQty, item.unitName,
										s.savedAt, s.prId, s.mrIds, s.refLink, s.creatorName, isNewSource, menuCtx, !!s.edited);
							}).join('')
							: createPoSourceRow(item.qty, item.unitName, item.qty, item.unitName, item.savedAt, item.prId, item.mrIds, item.refLink, item.creatorName, false, null, false)
					}
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
    $('#btnSavePoDetail .indicator-label').text('Update');

    $('#items_type').val(mapDbItemsTypeToSelect(item.itemsType)).trigger('change');

    const waitForProductList = setInterval(function(){
        if ($('#product_name option[value="' + item.productId + '"]').length > 0) {
            $('#product_name').val(item.productId).trigger('change');
            clearInterval(waitForProductList);
			
			const waitForUnitList = setInterval(function(){
                if ($('#unit option[value="' + item.unit + '"]').length > 0) {
                    $('#unit').val(item.unit).trigger('change');
                    clearInterval(waitForUnitList);
                }
            }, 100);
            setTimeout(function(){ clearInterval(waitForUnitList); }, 3000);
        }
    }, 100);

    setTimeout(function(){ clearInterval(waitForProductList); }, 3000);

    $('#po_qty').val(item.qty);
    $('#po_price').val(Number(item.total).toLocaleString(undefined, {minimumFractionDigits: 2, maximumFractionDigits: 2}));
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
			const removedItem = poDetailCart[index];
            poDetailCart.splice(index, 1);
            saveCartToSession();
            renderPoDetailCart();
			uncheckPrCheckboxesForItem(removedItem);
        }
    });
    return false;
}

/* ──────── แก้ไข / ลบ รายการที่มีอยู่แล้วใน DB ───── */
function editExistingCartItem(poDetailId){
    const item = existingPoDetailList.find(function(d){ return String(d.poDetailId) === String(poDetailId); });
    if (!item) return false;

    editingExistingDetailId = poDetailId;
    editingIndex = -1;

    $('#modal_create_po .modal-title').text('Edit PO - Detail');
    $('#btnSavePoDetail .indicator-label').text('Update');

    $('#items_type').val(mapDbItemsTypeToSelect(item.itemsType)).trigger('change');

    const waitForProductList = setInterval(function(){
        if ($('#product_name option[value="' + item.productId + '"]').length > 0) {
            $('#product_name').val(item.productId).trigger('change');
            clearInterval(waitForProductList);

			const waitForUnitList = setInterval(function(){
                if ($('#unit option[value="' + item.unit + '"]').length > 0) {
                    $('#unit').val(item.unit).trigger('change');
                    clearInterval(waitForUnitList);
                }
            }, 100);
            setTimeout(function(){ clearInterval(waitForUnitList); }, 3000);
        }
    }, 100);

    setTimeout(function(){ clearInterval(waitForProductList); }, 3000);

    $('#po_qty').val(item.qty);
	$('#po_price').val((dbTotalOf(item) + pendingSrcTotal(poDetailId))
        .toLocaleString(undefined, {minimumFractionDigits: 2, maximumFractionDigits: 2}));
    $('#po_description').val(dbDescOf(item));

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
						delete pendingExistingPoSources[String(poDetailId)];
                        delete pendingExistingEdits[String(poDetailId)];
						saveCartToSession();
						toastOk('ลบรายการสำเร็จ', function(){ window.location.reload(); });
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


function toastOk(msg, after){
    Swal.fire({ toast: true, position: 'top-end', icon: 'success',
        title: msg, showConfirmButton: false, timer: 1200 })
    .then(function(){ if (after) after(); });
}

function toastFail(msg){
    Swal.fire({ toast: true, position: 'top-end', icon: 'error',
        title: msg || 'บันทึกไม่สำเร็จ', showConfirmButton: false, timer: 1200 });
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
                 toastFail('ไม่สามารถแก้ไขรายการได้');
            }
        },
        error: function () {
            toastFail('เกิดข้อผิดพลาดในการแก้ไขรายการ');
        }
    });
}

function mapSelectToDbItemsType(val){
    switch(String(val)){
        case 'equipment':   return '1';
        case 'consumables': return '2';
        case 'accessory':   return '3';
        case 'office':      return '4';
        default:            return String(val);
    }
}

function closeAllSrcMenus(){
    document.querySelectorAll('.po-src-menu.menu-open').forEach(function(m){ m.classList.remove('menu-open'); });
}
document.addEventListener('click', closeAllSrcMenus);

function toggleSrcMenu(btn, e){
    e.preventDefault(); e.stopPropagation();
    const menu = btn.closest('.po-src-menu');
    const wasOpen = menu.classList.contains('menu-open');
    closeAllSrcMenus();
    if (!wasOpen) menu.classList.add('menu-open');
    return false;
}

// cart = การ์ดใหม่, pending = source ใหม่ของการ์ดเดิม (ยังไม่ save), db = แถว po_parent ที่อยู่ใน DB
function resolveSrc(scope, a, b){
    if (scope === 'cart') {
        const item = poDetailCart[Number(a)];
        const list = item && item.sources;
        return { item: item, list: list, src: list && list[b] };
    }
    const item = existingPoDetailList.find(function(it){ return String(it.poDetailId) === String(a); });
    if (scope === 'db') {
        const list = item && item.sources;
        let src = list && list[b];
        // มี pending edit ค้างไว้สำหรับ po_parent แถวนี้ ให้เห็นค่าล่าสุดที่ยังไม่ save แทนค่าเดิมใน db
        if (src && src.poParentId) {
            const e = (pendingSourceEdits[String(a)] || {})[String(src.poParentId)];
            if (e) src = { ...src, ...e };
        }
        return { item: item, list: list, src: src };
    }
    const list = pendingExistingPoSources[String(a)];
    return { item: item, list: list, src: list && list[b] };
}

function removeSource(scope, a, b){
    closeAllSrcMenus();
    Swal.fire({
        title: "Are you sure?!",
        text: "Are you sure you want to delete this row?",
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "Yes, delete it",
        cancelButtonText: "Cancel",
        buttonsStyling: false,
        customClass: { confirmButton: "btn btn-danger", cancelButton: "btn btn-secondary" }
    }).then(function(result){
        if (!result.isConfirmed) return;

        const r = resolveSrc(scope, a, b);
        if (!r.item || !r.src) return;
        const removed = r.src;

        if (scope === 'db') {
            const hasPendingNew = (pendingExistingPoSources[String(a)] || []).length > 0;
            const isLast = r.list.length <= 1 && !hasPendingNew;   // มี pending ค้างอยู่ = ยังไม่ใช่แถวสุดท้ายจริง
            $.ajax({
                url: ctx + (isLast ? '/delete_po_detail' : '/delete_po_source'),
                type: 'POST',
                dataType: 'json',
                data: isLast
                    ? { poDetailId: a, poId: EDIT_PO_ID }
                    : { poParentId: removed.poParentId, poDetailId: a, poId: EDIT_PO_ID,
                        keepDetail: (r.list.length <= 1) ? 'true' : 'false' },
                success: function (resp) {
                    if (resp.data && resp.data.success) {
                        // source นี้ไม่อยู่แล้ว เคลียร์ pending edit ของมันทิ้งไปด้วย กันค้างไว้ส่งซ้ำตอน save
                        if (pendingSourceEdits[String(a)]) {
                            delete pendingSourceEdits[String(a)][String(removed.poParentId)];
                        }
                        if (isLast) {
                            delete pendingExistingPoSources[String(a)];
                            delete pendingExistingEdits[String(a)];
                            delete pendingSourceEdits[String(a)];
                        }
                        saveCartToSession();
                        toastOk('ลบรายการสำเร็จ', function(){ window.location.reload(); });
                    } else {
                        toastFail('ไม่สามารถลบรายการได้');
                    }
                },
                error: function () {
                    toastFail('เกิดข้อผิดพลาดในการลบรายการ');
                }
            });
            return;
        }

        if (scope === 'cart') {
            const baseQty = Number(removed.baseQty != null ? removed.baseQty : removed.qty) || 0;
            r.list.splice(b, 1);
            if (r.list.length === 0) {
                poDetailCart.splice(Number(a), 1);
            } else {
                r.item.qty = Math.max(0, (Number(r.item.qty) || 0) - baseQty);
                r.item.price = r.item.qty > 0 ? ((Number(r.item.total) || 0) / r.item.qty) : 0; // total คงเดิม
            }
        } else {
            r.list.splice(b, 1);
            if (r.list.length === 0) delete pendingExistingPoSources[String(a)];
        }

        saveCartToSession();
        renderPoDetailCart();
        uncheckPrCheckboxesForItem({ sources: [removed] });
    });
    return false;
}

let editingSrc = null;

function editSource(scope, a, b){
    closeAllSrcMenus();
    const r = resolveSrc(scope, a, b);
    if (!r.item || !r.src) return false;
    const item = r.item, src = r.src;

    editingSrc = { scope: scope, a: a, b: b };
    const baseQty = (src.baseQty != null) ? src.baseQty : src.qty;
    const cat = getCategoryIcon(mapSelectToDbItemsType(item.itemsType));
    const fullName = item.parentProductName
        ? item.parentProductName + ' > ' + (item.productName || '')
        : (item.productName || '');

    $('#editSrcTypeIcon').html(cat.icon);
    $('#editSrcTypeName').text(cat.name);
    $('#editSrcProduct').text(fullName);
    $('#editSrcCreator').text(src.creatorName || currentUserDisplay);
    $('#editSrcDate').text(src.savedAt);
    $('#editSrcMr').html(createPrMrBadges(src.prId, src.mrIds, src.refLink));
    $('#editSrcCurrent').text(src.qty + ' ' + (src.unitName || item.unitName) + ' (= ' + baseQty + ' ' + item.unitName + ')');
    $('#edit_src_qty').val(src.qty);
    $('#editSrcPreview').text('');

    loadEditSrcUnits(item.productId, src.unit);
    bootstrap.Modal.getOrCreateInstance(document.getElementById('modal_edit_source')).show();
    return false;
}

function loadEditSrcUnits(productId, selectedUnitId){
    $('#edit_src_unit').html('<option value=""></option>');
    $.ajax({
        url: ctx + '/get_unit_of_measure',
        type: 'POST',
        dataType: 'json',
        data: { productId: productId },
        success: function (resp) {
            const list = (resp.data && resp.data.unitList) || [];
            let opts = '';
            list.forEach(function (u) {
                opts += '<option value="' + u.id + '"'
                    + ' data-conversion-rate="' + (u.conversionRate != null ? u.conversionRate : 1) + '"'
                    + (String(u.id) === String(selectedUnitId) ? ' selected' : '') + '>' + u.name + '</option>';
            });
            $('#edit_src_unit').html(opts).trigger('change');
        },
        error: function () {
            Swal.fire('Error', 'ไม่สามารถโหลดข้อมูล Unit ได้', 'error');
        }
    });
}

function updateEditSrcPreview(){
    if (!editingSrc) return;
    const r = resolveSrc(editingSrc.scope, editingSrc.a, editingSrc.b);
    if (!r.item) return;
    const qty = Number($('#edit_src_qty').val()) || 0;
    const rate = Number($('#edit_src_unit option:selected').data('conversion-rate')) || 1;
    $('#editSrcPreview').text('= ' + (Math.round(qty * rate * 1000) / 1000) + ' ' + r.item.unitName);
}
$(document.body).on('input change', '#edit_src_qty, #edit_src_unit', updateEditSrcPreview);

function saveEditSource(){
    if (!editingSrc) return;

    const qty = Number($('#edit_src_qty').val()) || 0;
    const unitId = $('#edit_src_unit').val();
    const errors = [];
    if (qty <= 0) errors.push('จำนวน');
    if (!unitId) errors.push('Unit');
    if (errors.length > 0) {
        Swal.fire({
            title: 'Please complete the form!',
            html: "Please fill in the following fields:<br><strong>" + errors.join(", ") + "</strong>",
            icon: "error", confirmButtonText: "OK"
        });
        return;
    }

    setBtnLoading('#btnSaveEditSource', true);

    setTimeout(function(){
    const r = resolveSrc(editingSrc.scope, editingSrc.a, editingSrc.b);
    if (!r.item || !r.src) { setBtnLoading('#btnSaveEditSource', false); return; }
    const old = r.src;

    if (editingSrc.scope === 'db') {
        const dbUnitName = $('#edit_src_unit option:selected').text();
        const dbRate = Number($('#edit_src_unit option:selected').data('conversion-rate')) || 1;
        const dbBaseQty = qty * dbRate;

        const pid = String(editingSrc.a);
        const ppid = String(old.poParentId);
        pendingSourceEdits[pid] = pendingSourceEdits[pid] || {};
        pendingSourceEdits[pid][ppid] = { qty: qty, unit: unitId, unitName: dbUnitName, baseQty: dbBaseQty };

        saveCartToSession();
        renderPoDetailCart();

        if (document.activeElement) document.activeElement.blur();
        bootstrap.Modal.getOrCreateInstance(document.getElementById('modal_edit_source')).hide();
        return;
    }

    const unitName = $('#edit_src_unit option:selected').text();
    const rate = Number($('#edit_src_unit option:selected').data('conversion-rate')) || 1;
    const baseQty = qty * rate;
    const oldBase = Number(old.baseQty != null ? old.baseQty : old.qty) || 0;

    r.list[editingSrc.b] = { ...old, qty: qty, unit: unitId, unitName: unitName, baseQty: baseQty };
    if (editingSrc.scope === 'cart') {
        r.item.qty = (Number(r.item.qty) || 0) + (baseQty - oldBase);
        r.item.price = r.item.qty > 0 ? ((Number(r.item.total) || 0) / r.item.qty) : 0; // total คงเดิม
    }

    saveCartToSession();
    renderPoDetailCart();

    if (document.activeElement) document.activeElement.blur();
    bootstrap.Modal.getOrCreateInstance(document.getElementById('modal_edit_source')).hide();
    }, 300);
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

function buildPoCartPayload(){
    const merged = [];
    const ids = {};
    Object.keys(pendingExistingPoSources).forEach(function(k){ ids[k] = true; });
    Object.keys(pendingExistingEdits).forEach(function(k){ ids[k] = true; });
    Object.keys(pendingSourceEdits).forEach(function(k){ ids[k] = true; });

    Object.keys(ids).forEach(function(pid){
        const ex = existingPoDetailList.find(function(it){ return String(it.poDetailId) === String(pid); });
        if (!ex) return;
        const srcs = pendingExistingPoSources[pid] || [];
        const edit = pendingExistingEdits[pid];
        const srcEditsMap = pendingSourceEdits[pid] || {};
        const srcEditIds = Object.keys(srcEditsMap);
        if (srcs.length === 0 && !edit && srcEditIds.length === 0) return;

        const addQty = srcs.reduce(function(a, s){ return a + (Number(s.baseQty != null ? s.baseQty : s.qty) || 0); }, 0);
        const addTotal = srcs.reduce(function(a, s){ return a + (Number(s.total) || 0); }, 0);
        const row = {
            poDetailId: pid, productId: ex.productId, itemsType: ex.itemsType, unit: ex.unit,
            description: '', qty: addQty, total: addTotal, sources: srcs
        };
        if (edit) { row.editTotal = edit.total; row.editDescription = edit.description; }
        if (srcEditIds.length > 0) {
            // แก้ qty/unit ของ po_parent เดิม (ไม่ใช่ source ใหม่) — ไม่กระทบ total ของการ์ด
            row.sourceEdits = srcEditIds.map(function(ppid){
                return { poParentId: ppid, qty: srcEditsMap[ppid].qty, unit: srcEditsMap[ppid].unit };
            });
        }
        merged.push(row);
    });
    return poDetailCart.concat(merged);
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
        poDetailCartJson: JSON.stringify(buildPoCartPayload())
    };
    const fd = new FormData();
    Object.keys(payload).forEach(function (k) { fd.append(k, payload[k]); });
    if (typeof selectedFiles !== 'undefined') {
        selectedFiles.forEach(function (file) { fd.append('files', file, file.name); });
    }
    
 	setBtnLoading('#saveDraft', true);
 
    $.ajax({
    	url: ctx + (EDIT_PO_ID ? '/update_po' : '/save_po'),
        type: 'POST',
        dataType: 'json',
        data: fd,
        processData: false,
        contentType: false,
        success: function (resp) {
            if (resp.data && resp.data.poId) {
                sessionStorage.removeItem(PO_CART_STORAGE_KEY);
				sessionStorage.removeItem(PO_EXISTING_SRC_KEY);
                sessionStorage.removeItem(PO_EXISTING_EDIT_KEY);
				sessionStorage.removeItem(PO_SOURCE_EDIT_KEY);
                Swal.fire({ title: 'Success!', text: 'Po saved draft successfully!', icon: 'success' })
                    .then(() => { window.location.href = ctx + '/purchase_order_list'; });
            } else {
                Swal.fire('Error', 'ไม่สามารถบันทึก Draft ได้', 'error');
            }
        },
        error: function () {
            Swal.fire('Error', 'เกิดข้อผิดพลาดในการบันทึก', 'error');
        },
        complete: function(){ setBtnLoading('#saveDraft', false); }
    });
}

function validatePOForm(){
    let errors = [];
    if (!($('#description').val() || '').trim()) errors.push('Description');
    if (!($('#vendor_id').val() || '').trim()) errors.push('Company Name');
    if (!($('#vendor_location_id').val() || '').trim()) errors.push('Company Location');
    if (!($('#contact_id').val() || '').trim()) errors.push('Contact Name');

    const existingList = existingPoDetailList || [];
    const cartList = poDetailCart || [];
    const totalDetailCount = existingList.length + cartList.length;

    if (totalDetailCount === 0) {
        errors.push('Please add at least 1 Po Detail');
    } else {
        // เช็คว่ามีรายการไหนราคารวมยังเป็น 0 / ยังไม่ได้ใส่ราคา
        const zeroPriceItems = existingList.concat(cartList).filter(function(item){
            if (item.poDetailId) return dbTotalOf(item) + pendingSrcTotal(item.poDetailId) <= 0;
            return (Number(item.total) || 0) <= 0;
        });
        if (zeroPriceItems.length > 0) {
            const names = zeroPriceItems.map(i => i.productName).join(', ');
            errors.push('กรุณาใส่ราคารวมให้ครบทุกรายการ (' + names + ')');
        }
    }

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
            poDetailCartJson: JSON.stringify(buildPoCartPayload()),
            status: '2'
        };
        
        const fd = new FormData();
        Object.keys(payload).forEach(function (k) { fd.append(k, payload[k]); });
        if (typeof selectedFiles !== 'undefined') {
            selectedFiles.forEach(function (file) { fd.append('files', file, file.name); });
        }

        setBtnLoading('#savePOFormBtn', true);

        $.ajax({
        	url: ctx + (EDIT_PO_ID ? '/update_po' : '/save_po'),
            type: 'POST',
            dataType: 'json',
            data: fd,
            processData: false,
            contentType: false,
            success: function (resp) {
                if (resp.data && resp.data.poId) {
                    sessionStorage.removeItem(PO_CART_STORAGE_KEY);
					sessionStorage.removeItem(PO_EXISTING_SRC_KEY);
					sessionStorage.removeItem(PO_EXISTING_EDIT_KEY);
				sessionStorage.removeItem(PO_SOURCE_EDIT_KEY);
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
                setBtnLoading('#savePOFormBtn', false);
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
            status: '4'
        };

        setBtnLoading('#returnPOBtn', true);

        $.ajax({
            url: ctx + ('/update_status_po'),
            type: 'POST',
            dataType: 'json',
            data: payload,
            success: function (resp) {
                if (resp.data && resp.data.poId) {
                    sessionStorage.removeItem(PO_CART_STORAGE_KEY);
                    sessionStorage.removeItem(PO_EXISTING_SRC_KEY);
					sessionStorage.removeItem(PO_EXISTING_EDIT_KEY);
				sessionStorage.removeItem(PO_SOURCE_EDIT_KEY);
                    Swal.fire({
                        title: 'Success!',
                        text: 'Po returned successfully!',
                        icon: 'success'
                    }).then(() => {
                        location.reload();
                        // window.location.href = ctx + '/purchase_order_list';
                    });
                } else {
                    Swal.fire('Error', 'ไม่สามารถคืน PO ได้', 'error');
                }
            },
            error: function () {
                Swal.fire('Error', 'เกิดข้อผิดพลาดในการส่งข้อมูล', 'error');
            },
            complete: function(){
                setBtnLoading('#returnPOBtn', false);
            }
        });
    });
}

function editPO(){
    const payload = {
        poId: EDIT_PO_ID || '',
		status: '1'
    };

    setBtnLoading('#editPOFormBtn', true);

    $.ajax({
    	url: ctx + ('/update_status_po'),
    	type: 'POST',
        dataType: 'json',
        data: payload,
        success: function (resp) {
            location.reload();
        },
		error: function () {
            Swal.fire('Error', 'เกิดข้อผิดพลาดในการส่งข้อมูล', 'error');
        },
        complete: function(){
            setBtnLoading('#editPOFormBtn', false);
        }
    });
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

        setBtnLoading('#rejectPOBtn', true);

        $.ajax({
            url: ctx + ('/update_status_po'),
            type: 'POST',
            dataType: 'json',
            data: payload,
            success: function (resp) {
                if (resp.data && resp.data.poId) {
                    sessionStorage.removeItem(PO_CART_STORAGE_KEY);
					sessionStorage.removeItem(PO_EXISTING_SRC_KEY);
					sessionStorage.removeItem(PO_EXISTING_EDIT_KEY);
				sessionStorage.removeItem(PO_SOURCE_EDIT_KEY);
                    Swal.fire({
                        title: 'Success!',
                        text: 'Po rejected successfully!',
                        icon: 'success'
                    }).then(() => {
						location.reload();
                        // window.location.href = ctx + '/purchase_order_list';
                    });
                } else {
                    Swal.fire('Error', 'ไม่สามารถปฏิเสธ PO ได้', 'error');
                }
            },
            error: function () {
                Swal.fire('Error', 'เกิดข้อผิดพลาดในการส่งข้อมูล', 'error');
            },
            complete: function(){
                setBtnLoading('#rejectPOBtn', false);
            }
        });
    });
}

function approvePO(){
	const reasonVal = ($('#reason').val() || '').trim();

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
			reason: reasonVal,
            status: '3' 
        };

        setBtnLoading('#approvePOBtn', true);

        $.ajax({
            url: ctx + '/update_status_po',
            type: 'POST',
            dataType: 'json',
            data: payload,
            success: function (resp) {
                if (resp.data && resp.data.poId) {
                    sessionStorage.removeItem(PO_CART_STORAGE_KEY);
					sessionStorage.removeItem(PO_EXISTING_SRC_KEY);
					sessionStorage.removeItem(PO_EXISTING_EDIT_KEY);
				sessionStorage.removeItem(PO_SOURCE_EDIT_KEY);
                    Swal.fire({
                        title: 'Success!',
                        text: 'PO approved successfully!',
                        icon: 'success'
                    }).then(() => {
						location.reload();
                        // window.location.href = ctx + '/purchase_order_list';
                    });
                } else {
                    Swal.fire('Error', 'ไม่สามารถอนุมัติ PO ได้', 'error');
                }
            },
            error: function () {
                Swal.fire('Error', 'เกิดข้อผิดพลาดในการส่งข้อมูล', 'error');
            },
            complete: function(){
                setBtnLoading('#approvePOBtn', false);
            }
        });
    });
}

function inProgressPO(){
    Swal.fire({
        title: "Are you sure?!",
        text: "Do you want to in progress this PO?",
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
            status: '7' 
        };

        setBtnLoading('#inProgressPOFormBtn', true);

        $.ajax({
            url: ctx + '/update_status_po',
            type: 'POST',
            dataType: 'json',
            data: payload,
            success: function (resp) {
                if (resp.data && resp.data.poId) {
                    sessionStorage.removeItem(PO_CART_STORAGE_KEY);
					sessionStorage.removeItem(PO_EXISTING_SRC_KEY);
					sessionStorage.removeItem(PO_EXISTING_EDIT_KEY);
				sessionStorage.removeItem(PO_SOURCE_EDIT_KEY);
                    Swal.fire({
                        title: 'Success!',
                        text: 'PO in progress successfully!',
                        icon: 'success'
                    }).then(() => {
                        location.reload();
                        // window.location.href = ctx + '/purchase_order_list';
                    });
                } else {
                    Swal.fire('Error', 'ไม่สามารถอนุมัติ PO ได้', 'error');
                }
            },
            error: function () {
                Swal.fire('Error', 'เกิดข้อผิดพลาดในการส่งข้อมูล', 'error');
            },
            complete: function(){
                setBtnLoading('#inProgressPOFormBtn', false);
            }
        });
    });
}

function goBack(){
    if (hasUnsavedChanges()) {
        confirmLeaveForm('purchase_order_list');
    } else {
        sessionStorage.removeItem(PO_CART_STORAGE_KEY);
        sessionStorage.removeItem(PO_EXISTING_SRC_KEY);
        sessionStorage.removeItem(PO_EXISTING_EDIT_KEY);
		sessionStorage.removeItem(PO_SOURCE_EDIT_KEY);
        location.href = 'purchase_order_list';
    }
}

function cancelPO(){
    Swal.fire({
        title: "Are you sure?!",
        text: "Do you want to cancel this PO?",
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
            status: '6' 
        };

        setBtnLoading('#cancelFormBtn', true);

        $.ajax({
            url: ctx + '/update_status_po',
            type: 'POST',
            dataType: 'json',
            data: payload,
            success: function (resp) {
                if (resp.data && resp.data.poId) {
                    sessionStorage.removeItem(PO_CART_STORAGE_KEY);
					sessionStorage.removeItem(PO_EXISTING_SRC_KEY);
					sessionStorage.removeItem(PO_EXISTING_EDIT_KEY);
				sessionStorage.removeItem(PO_SOURCE_EDIT_KEY);
                    Swal.fire({
                        title: 'Success!',
                        text: 'PO cancel successfully!',
                        icon: 'success'
                    }).then(() => {
                        location.reload();
                        // window.location.href = ctx + '/purchase_order_list';
                    });
                } else {
                    Swal.fire('Error', 'ไม่สามารถลบ PO ได้', 'error');
                }
            },
            error: function () {
                Swal.fire('Error', 'เกิดข้อผิดพลาดในการส่งข้อมูล', 'error');
            },
            complete: function(){
                setBtnLoading('#cancelFormBtn', false);
            }
        });
    });
}


function createPrMrBadges(prId, mrIds, refLink){
    mrIds = mrIds || [];
    let html = '';

    if (prId) {
        html += `
        <a href="\${ctx}/purchase_requisition_edit?prId=\${prId}"
            target="_blank" onclick="event.stopPropagation();"
            class="badge badge-lg fs-7 fw-semibold d-inline-block text-center text-decoration-none text-nowrap badge-light-primary text-primary">
            \${prId}
        </a>`;

        if (refLink) {
            html += `
            <a href="\${refLink}" target="_blank" class="text-primary d-inline-flex mx-1" onclick="event.stopPropagation();">
                <i class="ki-duotone ki-fasten fs-2 text-primary">
                    <span class="path1"></span><span class="path2"></span>
                </i>
            </a>`;
        }
    }

    mrIds.forEach(function(m){
        html += `
        <a href="\${ctx}/equipment_request_mr_approve?mrId=\${m.id}"
            target="_blank" onclick="event.stopPropagation();"
            class="badge badge-lg fs-7 fw-semibold d-inline-block text-center text-decoration-none text-nowrap badge-light-info text-info">
            \${m.id}
        </a>`;

        if (m.url) {
            html += `
            <a href="\${m.url}" target="_blank" class="text-info d-inline-flex mx-1" onclick="event.stopPropagation();">
                <i class="ki-duotone ki-fasten fs-2 text-info">
                    <span class="path1"></span><span class="path2"></span>
                </i>
            </a>`;
        }
    });

    if (!prId && mrIds.length === 0) {
        html = `<span class="badge badge-lg fs-7 fw-semibold d-inline-block text-center badge-light-primary text-primary">-</span>`;
    }

    return html;
}

function createPoSourceRow(qty, unitName, baseQty, baseUnitName, savedAt, prId, mrIds, refLink, creatorName, isNew, menuCtx, isEdited){
    const qtyUnitDisplay = (qty + ' ' + unitName + ' (= ' + baseQty + ' ' + baseUnitName + ')');

    const menuHtml = menuCtx ? `
        <div class="po-src-menu position-relative d-inline-block flex-shrink-0">
            <a href="#" class="btn btn-icon btn-sm btn-light-primary w-30px h-30px"
               onclick="return toggleSrcMenu(this, event);" aria-label="More actions" aria-haspopup="true">
                <i class="ki-outline ki-dots-horizontal fs-2"></i>
            </a>
            <div class="po-src-actions position-absolute end-0 top-100 mt-2 bg-body rounded-3 shadow z-index-3">
                <div class="py-2">
                    <a href="#" class="d-block px-6 py-3 fs-6 fw-normal text-gray-800 bg-hover-light"
                       onclick="event.stopPropagation(); return editSource('\${menuCtx.scope}', '\${menuCtx.a}', \${menuCtx.b});">Edit</a>
                    <a href="#" class="d-block px-6 py-3 fs-6 fw-normal text-gray-800 bg-hover-light"
                       onclick="event.stopPropagation(); return removeSource('\${menuCtx.scope}', '\${menuCtx.a}', \${menuCtx.b});">Delete</a>
                </div>
            </div>
        </div>` : '';

    return `
    <div class="d-flex align-items-center justify-content-between row mb-4 py-2">
        <div class="col-12 col-xl-9">
            <div class="d-flex align-items-center fs-7">
                <div class="col-12 col-md-4">
                    <i class="ki-duotone ki-user-tick fs-3 text-muted me-2">
                        <span class="path1"></span><span class="path2"></span><span class="path3"></span>
                    </i>
                    <span class="text-gray-800 fs-5 fw-normal">\${creatorName || currentUserDisplay}</span>
                </div>
                <div class="col-12 col-md-4 d-flex align-items-center">
                    <i class="ki-duotone ki-calendar-2 fs-3 me-2">
                        <span class="path1"></span><span class="path2"></span><span class="path3"></span>
                        <span class="path4"></span><span class="path5"></span>
                    </i>
                    <span class="text-gray-800 fs-5 fw-normal">\${savedAt}</span>
                </div>
                <div class="col-12 col-md-4 d-flex align-items-center gap-2">
					<i class="ki-duotone ki-tablet-book fs-3 flex-shrink-0">
						<span class="path1"></span><span class="path2"></span>
					</i>
					<div class="d-flex flex-wrap align-items-center gap-2">
						\${createPrMrBadges(prId, mrIds, refLink)}
					</div>
				</div>
            </div>
        </div>
		<div class="col-12 col-xl-3 d-flex align-items-center justify-content-between justify-content-xl-end gap-3">
            <span class="text-gray-800 fs-5 fw-normal">\${qtyUnitDisplay}</span>
            \${menuHtml}
        </div>
		
    </div>`;
}

// Modal Search PR
let inprogressPrDetailList = [];
let prDetailTable = null;
let selectedPrCategory = '';
let prSearchRequestToken = 0;
let isSearchPrModalOpen = false; 

$.fn.dataTable.ext.search.push(function (settings, data, dataIndex) {
    if (settings.nTable.id !== 'prResultTable') return true;
    if (!selectedPrCategory) return true;

    var item = inprogressPrDetailList[dataIndex];
    if (!item) return true;

    return mapDbItemsTypeToSelect(item.product_type) === selectedPrCategory;
});

function getCategoryIcon(productType){
    switch(String(productType)){
        case '1': return { name: 'Equipment', icon: '<i class="ki-duotone ki-monitor-mobile fs-2 text-primary"><span class="path1"></span><span class="path2"></span></i>' };
        case '2': return { name: 'Consumables', icon: '<i class="ki-duotone ki-lots-shopping fs-2 text-orange"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span><span class="path7"></span><span class="path8"></span></i>' };
        case '3': return { name: 'Accessory', icon: '<i class="ki-duotone ki-medal-star fs-2 text-teal"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i>' };
        case '4': return { name: 'Office supplies', icon: '<i class="ki-duotone ki-parcel fs-2 text-success"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i>' };
        default:  return { name: '-', icon: '' };
    }
}

function loadInprogressPrDetail(){
    var requestToken = ++prSearchRequestToken;
    $.ajax({
        url: ctx + '/search_inprogress_pr',
        type: 'POST',
        dataType: 'json',
        success: function (resp) {
            if (requestToken !== prSearchRequestToken || !isSearchPrModalOpen) {
                return;
            }
            var data = resp.data;
            var rows = (data && data.prDetailList) || [];

            // pr_detail อาจมีหลาย MR รวมให้เหลือ 1 แถวต่อ pr_detail
            var map = {};
            inprogressPrDetailList = [];

            rows.forEach(function(r){
                var key = String(r.pr_detail_id);
                if (!map[key]) {
                    r.mrs = [];
                    map[key] = r;
                    inprogressPrDetailList.push(r);
                }
                if (r.mr_id) {
                    map[key].mrs.push({ id: r.mr_id, url: r.url_ref || '' });
                }
            });

			// เรียงให้ pr_id เดียวกันอยู่ติดกัน
            var groupTime = {};
            inprogressPrDetailList.forEach(function(r){
                var t = new Date(String(r.time_sort || r.time_create || '').replace(' ', 'T')).getTime() || 0;
                groupTime[r.pr_id] = Math.max(groupTime[r.pr_id] || 0, t);
            });
            inprogressPrDetailList.sort(function(a, b){
                if (String(a.pr_id) !== String(b.pr_id)) {
                    var d = groupTime[b.pr_id] - groupTime[a.pr_id];
                    if (d !== 0) return d;
                    return String(a.pr_id) < String(b.pr_id) ? -1 : 1;
                }
                return Number(a.pr_detail_id) - Number(b.pr_detail_id);
            });

            renderPrResultTable(inprogressPrDetailList);
        },
        error: function () {
            Swal.fire('Error', 'ไม่สามารถโหลดข้อมูล PR ได้', 'error');
        }
    });
}

$(document.body).on('keyup input', '#searchPrKeyword', function () {
    if (prDetailTable) {
        prDetailTable.search(this.value).draw();
    }
});

$(document.body).on('change', '#searchPrCategory', function () {
    selectedPrCategory = $(this).val();
    if (prDetailTable) {
        prDetailTable.draw();
    }
});

function isPrDetailIdInCart(prDetailId){
    var inCart = poDetailCart.some(function(it){
        return (it.sources || []).some(function(s){ return String(s.prDetailId) === String(prDetailId); });
    });
    if (inCart) return true;
    return Object.keys(pendingExistingPoSources).some(function(pid){
        return pendingExistingPoSources[pid].some(function(s){ return String(s.prDetailId) === String(prDetailId); });
    });
}

function renderPrResultTable(list){
    var tbody = document.getElementById('prResultBody');
    var html = '';

    list.forEach(function(item, index){
        var cat = getCategoryIcon(item.product_type);
        var qty = item.amount_total || 0;
        var unitName = item.unit_name || '';
        var userName = item.user_create_name || '-';
        var timeCreate = formatNowDateTime(item.time_create);
        var initial = userName.charAt(0).toUpperCase();
        var userPath = item.user_create_path || '';
        var statusBadge = item.pr_status == '3'
            ? '<span class="badge badge-lg bg-success fw-semibold fs-7 text-white">Approved</span>'
            : item.pr_status == '7'
            ? '<span class="badge badge-lg bg-cyan fw-semibold fs-7 text-white">In-Progress</span>'
            : '';
		var fullProductName = item.parent_product_name
			? item.parent_product_name + ' > ' + (item.product_name || '')
			: (item.product_name || '');

        html += `
        <tr class="fw-semibold fs-6 text-gray-800 border-bottom border-gray-200" data-pr-id="\${item.pr_id}">
            <td>
                <div class="form-check form-check-sm">
                    <input class="form-check-input pr-row-check" type="checkbox"
                            data-pr-detail-id="\${item.pr_detail_id}"\${isPrDetailIdInCart(item.pr_detail_id) ? ' checked' : ''} />
                </div>
            </td>
            <td class="fw-bold text-gray-900 fs-7 row-number text-start"></td>
            <td class="text-gray-900 fs-6 fw-normal">\${item.pr_id}</td>
            <td>
                <div class="d-flex align-items-center">
                    <div class="symbol symbol-40px me-4">\${cat.icon}</div>
                    <span class="text-gray-900 fs-5 fw-normal">\${cat.name}</span>
                </div>
            </td>
            <td>
                <div class="d-flex align-items-center">
                    <div class="symbol symbol-35px symbol-circle me-3">
                        <div class="symbol symbol-35px symbol-circle me-3">
                            \${userPath
                                ? '<img src="' + userPath + '" alt="' + userName + '" class="object-fit-cover" />'
                                : '<span class="symbol-label bg-light-primary text-primary fw-bold">' + initial + '</span>'
                            }
                        </div>
                    </div>
                    <div class="d-flex flex-column">
                        <span class="text-gray-900 fs-6 fw-normal">\${userName}</span>
                        <span class="text-gray-900 fs-6 fw-normal">\${timeCreate}</span>
                    </div>
                </div>
            </td>
            <td>
                <div class="d-flex flex-column">\${fullProductName}</span>
                    <span class="text-gray-900 fs-6 fw-normal">\${qty} \${unitName}</span>
                </div>
            </td>
            <td class="text-end pe-2">
                \${statusBadge}
            </td>
        </tr>`;
    });
    tbody.innerHTML = html;

    if (prDetailTable) {
        prDetailTable.destroy();
        prDetailTable = null;
    }
    prDetailTable = $('#prResultTable').DataTable({
        ordering : false,
        searching : true,
        autoWidth : false,
        info: false,
        paging: false,
        drawCallback: function () {
            var api = this.api();
            var $rows = $(api.rows({ search: 'applied', order: 'applied' }).nodes());

            // ลบหัวกลุ่มเก่า แล้วสร้างใหม่ทุกครั้งที่ draw (search / filter)
            $(api.table().body()).find('tr.pr-group-row').remove();

            var counts = {};
            $rows.each(function () {
                var id = String($(this).data('pr-id'));
                counts[id] = (counts[id] || 0) + 1;
            });

            var lastPr = null;
            $rows.each(function (i) {
                $(this).find('.row-number').text(i + 1);

                var prId = String($(this).data('pr-id'));
                if (prId !== lastPr) {
                    $(this).before(buildPrGroupRow(prId, counts[prId]));
                    lastPr = prId;
                }
            });

            document.getElementById('prItemsFoundCount').textContent = $rows.length;
            syncGroupChecks();
        }
    });
    updatePrSelectedCountReal();

    var checkAll = document.getElementById('checkAllPr');

    function syncCheckAllState(){
        var allBoxes = document.querySelectorAll('.pr-row-check');
        checkAll.checked = allBoxes.length > 0 && Array.prototype.every.call(allBoxes, function (box) { return box.checked; });
    }

    document.querySelectorAll('.pr-row-check').forEach(function (cb) {
        cb.addEventListener('change', function () {
            updatePrSelectedCountReal();
            syncCheckAllState();
            syncGroupChecks();
        });
    });

    checkAll.checked = list.length > 0 && list.every(function (d) { return isPrDetailIdInCart(d.pr_detail_id); });
    checkAll.onchange = function(){
        document.querySelectorAll('.pr-row-check').forEach(cb => cb.checked = this.checked);
        updatePrSelectedCountReal();
        syncGroupChecks();
    };
}

function buildPrGroupRow(prId, count){
    return '<tr class="pr-group-row" data-pr-id="' + prId + '">'
        + '<td colspan="7" class="bg-light-primary">'
            + '<div class="d-flex align-items-center gap-4">'
                + '<div class="form-check form-check-sm">'
                    + '<input class="form-check-input pr-group-check" type="checkbox" data-pr-id="' + prId + '" />'
                + '</div>'
                + '<span class="fw-bold fs-5 text-primary">' + prId + '</span>'
                + '<span class="text-muted fs-7">' + count + ' item' + (count > 1 ? 's' : '') + '</span>'
            + '</div>'
        + '</td>'
    + '</tr>';
}

// ติ๊กหัวกลุ่มให้ตรงกับสถานะของแถวข้างใต้
function syncGroupChecks(){
    document.querySelectorAll('.pr-group-check').forEach(function (g) {
        var boxes = document.querySelectorAll(
            'tr:not(.pr-group-row)[data-pr-id="' + g.getAttribute('data-pr-id') + '"] .pr-row-check');
        g.checked = boxes.length > 0 &&
            Array.prototype.every.call(boxes, function (b) { return b.checked; });
    });
}

// ติ๊กที่หัวกลุ่ม = ติ๊กทุกแถวใน PR นั้น
$(document.body).on('change', '.pr-group-check', function () {
    var checked = this.checked;
    var prId = this.getAttribute('data-pr-id');
    document.querySelectorAll('tr:not(.pr-group-row)[data-pr-id="' + prId + '"] .pr-row-check')
        .forEach(function (cb) { cb.checked = checked; });

    updatePrSelectedCountReal();

    var checkAll = document.getElementById('checkAllPr');
    var allBoxes = document.querySelectorAll('.pr-row-check');
    checkAll.checked = allBoxes.length > 0 &&
        Array.prototype.every.call(allBoxes, function (b) { return b.checked; });
});

function updatePrSelectedCountReal(){
    var count = document.querySelectorAll('.pr-row-check:checked').length;
    document.getElementById('prSelectedCount').textContent = count;
}

function uncheckPrCheckboxesForItem(item){
    if (!item || !item.sources || item.sources.length === 0) return;

    item.sources.forEach(function(s){
        if (!s.prDetailId) return;
        var cb = document.querySelector('.pr-row-check[data-pr-detail-id="' + s.prDetailId + '"]');
        if (cb) cb.checked = false;
    });

    updatePrSelectedCountReal();

    var checkAll = document.getElementById('checkAllPr');
    if (checkAll) {
        var allBoxes = document.querySelectorAll('.pr-row-check');
        checkAll.checked = allBoxes.length > 0 &&
            Array.prototype.every.call(allBoxes, function (box) { return box.checked; });
    }
}

// หา unit, base ของ unitId ที่กำหนด จาก unit catalog 
// unit = entry ของ unitId นั้น(เอา conversionRate), base = entry ที่ sequence === '0' (หน่วยเล็กสุด)
function findUnitAndBase(catalog, unitId){
    var unit = null, base = null;
    (catalog || []).forEach(function(u){
        if (String(u.id) === String(unitId)) unit = u;
        if (String(u.sequence) === '0') base = u;
    });
    return { unit: unit, base: base };
}

document.getElementById('btnSubmitPr').addEventListener('click', function(){
    var selectedIds = [];
    document.querySelectorAll('.pr-row-check:checked').forEach(function(cb){
        selectedIds.push(cb.getAttribute('data-pr-detail-id'));
    });
    var selectedIdSet = {};
    selectedIds.forEach(function(id){ selectedIdSet[String(id)] = true; });

    // เอาออกจาก poDetailCart รายการที่เคยดึงเข้ามาจากตารางนี้ แต่ตอนนี้ถูกเลิกติ๊กแล้ว
    inprogressPrDetailList.forEach(function(d){
        var prDetailId = String(d.pr_detail_id);
        if (selectedIdSet[prDetailId]) return;

        for (var i = poDetailCart.length - 1; i >= 0; i--) {
            var cartItem = poDetailCart[i];
            if (!cartItem.sources) continue;

            var srcIdx = cartItem.sources.findIndex(function (s) {
                return String(s.prDetailId) === prDetailId;
            });
            if (srcIdx === -1) continue;

            var removedSrc = cartItem.sources[srcIdx];
            var removedBaseQty = Number(removedSrc.baseQty != null ? removedSrc.baseQty : removedSrc.qty) || 0;
            cartItem.sources.splice(srcIdx, 1);

            if (cartItem.sources.length === 0) {
                poDetailCart.splice(i, 1);
            } else {
                cartItem.qty = Math.max(0, (Number(cartItem.qty) || 0) - removedBaseQty);
                cartItem.price = cartItem.qty > 0 ? ((Number(cartItem.total) || 0) / cartItem.qty) : 0;
            }
        }
    });

    // search_inprogress_pr ไม่มี conversion rate ติดมาด้วย ต้อง fetch unit catalog ของแต่ละ product_id ที่เลือกเอง
    var productIdsToFetch = [];
    selectedIds.forEach(function(prDetailId){
        var src = inprogressPrDetailList.find(function(d){ return String(d.pr_detail_id) === String(prDetailId); });
        if (!src || !src.product_id) return;
        var pid = String(src.product_id);
        if (!prUnitCatalogCache[pid] && productIdsToFetch.indexOf(pid) === -1) {
            productIdsToFetch.push(pid);
        }
    });

    var fetches = productIdsToFetch.map(function(pid){
        return $.ajax({
            url: ctx + '/get_unit_of_measure',
            type: 'POST',
            dataType: 'json',
            data: { productId: pid }
        }).then(function(resp){
            prUnitCatalogCache[pid] = (resp.data && resp.data.unitList) || [];
        }, function(){
            prUnitCatalogCache[pid] = []; // โหลดไม่สำเร็จ ใช้ conversionRate=1 (ไม่แปลงหน่วย)
        });
    });

    $.when.apply($, fetches).always(function(){
        // รายการที่ดึงมาจาก Search PR ทั้งหมดเป็นของใหม่ (ยังไม่ save ลง DB)
        selectedIds.forEach(function(prDetailId){
            var src = inprogressPrDetailList.find(function(d){ return String(d.pr_detail_id) === String(prDetailId); });
            if (!src) return;

            var qty = Number(src.amount_total) || 0;
            var price = Number(src.unit_price) || 0;
            var mrs = src.mrs || [];

            var catalog = prUnitCatalogCache[String(src.product_id)] || [];
            var found = findUnitAndBase(catalog, src.unit);
            var conversionRate = (found.unit && Number(found.unit.conversionRate)) || 1;
            var baseUnit = found.base || found.unit;
            var baseQty = qty * conversionRate;
            var baseUnitId = baseUnit ? baseUnit.id : src.unit;
            var baseUnitName = baseUnit ? baseUnit.name : (src.unit_name || '');

            // ข้อมูลที่มา (ต่อ PR แต่ละใบ) — qty/unitName เป็นหน่วยดิบตามที่ PR บันทึกไว้
            var sourceEntry = {
                prId: src.pr_id,
                prDetailId: src.pr_detail_id,
                mrIds: mrs,
                qty: qty,
                unit: src.unit,
                unitName: src.unit_name || '',
                baseQty: baseQty,
                refLink: src.ref_link || '',
                creatorName: (src.user_create_emp_id ? src.user_create_emp_id + ' - ' : '') + (src.user_create_name || ''),
                savedAt: formatNowDateTime()
            };

			if (addToExistingPoDetail(src.product_id, sourceEntry, baseQty * price)) return;

            // group ตาม productId เฉพาะกับรายการใหม่ใน poDetailCart (ไม่ยุ่งกับ existingPoDetailList)
            var existingIndex = poDetailCart.findIndex(function(it){
                return String(it.productId) === String(src.product_id);
            });

            if (existingIndex >= 0) {
                var existing = poDetailCart[existingIndex];

                if (!existing.sources || existing.sources.length === 0) {
                    existing.sources = [{
                        prId: existing.prId || null,
                        prDetailId: existing.prDetailId || null,
                        mrIds: existing.mrIds || [],
                        qty: existing.qty,
                        unit: existing.unit,
                        unitName: existing.unitName,
                        baseQty: existing.qty,
                        refLink: existing.refLink || '',
                        creatorName: existing.creatorName || currentUserDisplay,
                        savedAt: existing.savedAt || formatNowDateTime()
                    }];
                }

                var alreadyAdded = (existing.sources || []).some(function(s){
                    return String(s.prDetailId) === String(src.pr_detail_id);
                });
                if (alreadyAdded) return;

                existing.sources.push(sourceEntry);
                existing.qty = (Number(existing.qty) || 0) + baseQty;
                existing.total = (Number(existing.total) || 0) + (baseQty * price);
                existing.price = existing.qty > 0 ? (existing.total / existing.qty) : 0;
            } else {
				var cartProductName = src.parent_product_name
					? src.parent_product_name + ' > ' + (src.product_name || '')
					: (src.product_name || '');

                var item = {
                    itemsType: mapDbItemsTypeToSelect(src.product_type),
                    itemsTypeText: getCategoryIcon(src.product_type).name,
                    productId: src.product_id,
                    productName: src.product_name || '',
    				parentProductName: src.parent_product_name || '',
                    qty: baseQty,
                    unit: baseUnitId,
                    unitName: baseUnitName,
                    price: price,
                    description: '',
                    sources: [sourceEntry]
                };
                item.total = baseQty * price;
                poDetailCart.push(item);
            }
        });

        saveCartToSession();
        renderPoDetailCart();

        if (document.activeElement) {
            document.activeElement.blur();
        }

        var modalEl = document.getElementById('modal_search_pr');
        bootstrap.Modal.getOrCreateInstance(modalEl).hide();
    });
});

</script>

</html>