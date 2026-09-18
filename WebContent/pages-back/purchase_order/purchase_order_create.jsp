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
<script
	src="${pageContext.request.contextPath}/assets/js/custom/utilities/attachFile/attcahfile.js"></script>

<style>
/* ==================== Table PR ==================== */

[data-bs-theme="light"] #prResultTable.table.table-striped > tbody > tr:nth-of-type(odd) > * {
    background-color: #FBFBFB !important;
    box-shadow: none !important;
}

[data-bs-theme="dark"] #prResultTable.table.table-striped > tbody > tr:nth-of-type(odd) > * {
    background-color: #191B20 !important;
    box-shadow: none !important;
}


/* ===== Table Header ===== */

#prResultTable thead th {
    white-space: nowrap !important;
    vertical-align: middle !important;
    padding-right: 35px !important;
    cursor: pointer;
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
    max-height: 300px;
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
							Add PO - Purchase Order
						</h1>
						<ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
							<li class="breadcrumb-item text-muted"><a class="text-muted text-hover-primary">Home</a></li>
							<li class="breadcrumb-item"><span class="bullet bg-gray-500 w-5px h-2px"></span></li>
							<li class="breadcrumb-item text-muted"><a class="text-muted text-hover-primary">Product</a></li>
						</ul>
					</div>
			
					<div class="d-flex align-items-center gap-2">
						<span class="badge badge-lg bg-secondary fw-semibold fs-7 p-4">Draft</span>
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
										
										<div class="col-12 mt-9">
											<label class="required fw-medium text-gray-800 mb-5">Description</label>
											<textarea class="form-control text-gray-700" id="description" name="description"
												placeholder="Description" rows="3"></textarea>
										</div>
										<!-- <div class="col-12 mt-5">
											<label for="myFile" id="lbFile" class="btn btn-primary d-inline-flex align-items-center justify-content-center gap-2 fw-medium mb-3">
													Attach files
												<input type="file" id="myFile" name="files" style="display:none;" accept="image/*,application/pdf,application/zip,application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document" multiple>
											</label>
											<div id="attachFileList" class="d-flex flex-column mt-3 gap-2"></div>
											<div id="errorMsgAF" class="text-danger fs-8 mt-1"></div>
										</div> -->
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
									<label for="myFile" id="lbFile" class="btn btn-lg btn-primary d-inline-flex align-items-center justify-content-center fw-medium h-40px my-0">
											Upload
										<input type="file" id="myFile" name="files" multiple style="display: none;"
											accept="image/*,application/pdf,application/zip,application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document" multiple>
											
									</label>
								</div>
								<div class="card-body filter-card px-10 py-9 rounded-3">
									<div id="attachFileWarningBox"
										class="border border-2 border-warning rounded border-active active w-100">
										<div class="py-5 d-flex flex-column align-items-center">
											<div
												class="fs-3 fw-bold text-warning d-flex justify-content-center align-items-center gap-2 mb-5">
												<i class="ki-duotone ki-information-2 fs-3x text-warning">
													<span class="path1"></span> <span class="path2"></span> <span
													class="path3"></span>
												</i> Attach files
											</div>
											<div
												class="d-flex justify-content-center align-items-center text-center fw-medium fs-7 mb-5 text-gray-800">Only
												English filenames are accepted.</div>
											<div
												class="d-flex justify-content-center align-items-center text-center fw-medium fs-7 text-muted">
												Files with Thai or special characters may<br> not open
												correctly after upload.
											</div>
										</div>
									</div>
									<div class="d-flex flex-column h-100" style="min-height: 0;">
										<div id="attachFileList" class="d-flex flex-column gap-2 mt-2"></div>
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
											placeholder="Reference Invoice/Quotation NO" name="reference_no"
											id="reference_no" value="" />
								</div>
								
								<div class="col-lg-6 col-md-6 col-12 d-flex flex-column">
									<label class="fw-medium text-gray-800 mb-2">Reference Invoice/Quotation Date</label>
									<div class="position-relative d-flex align-items-center">
										<i class="ki-duotone ki-calendar-8 position-absolute ms-4 mb-1 text-gray-500 fs-3">
											<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span>
										</i>
										<input class="form-control text-gray-700 ps-12 h-45px" 
											   id="kt_reference_datepicker" name="reference_date" placeholder="Select date" 
											   value=""/>
									</div>
								</div>
							</div>
					
							<div class="row g-5 mb-6">
								
									<div class="col-lg-6 col-md-6 col-12 d-flex flex-column">
										<div class="d-flex justify-content-between align-items-center mb-2">
											<label class="required fw-medium text-gray-800">Company Name</label>
											<a href="/company_add" target="_blank" class="text-success fw-medium fs-7 text-hover-primary" style="text-decoration: none;">
												<i class="ki-outline ki-plus fs-7 text-success me-1"></i>Create
											</a>
										</div>
										<select name="vendor_id" id="vendor_id" class="form-select h-45px" data-control="select2" data-placeholder="Select Company Name">
									   		<option value=""></option>     
									        <c:forEach var="company" items="${companyList}">
									            <option value="${company.company_id}">${company.company_en}</option>
									        </c:forEach>
									    </select>
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
										<a href="/contact_add" target="_blank" class="text-success fw-medium fs-7 text-hover-primary" style="text-decoration: none;">
											<i class="ki-outline ki-plus fs-7 me-1 text-success"></i>Create
										</a>
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
						         <button type="button" id="btnOpenCreatePo" class="btn btn-lg btn-success fw-medium text-white px-6 py-4">
									<i class="ki-outline ki-plus fs-3 me-1"></i>Create
								</button>
								
								<button type="button" id="btnOpenSearchPr" class="btn btn-lg btn-primary fw-medium text-white px-6 py-4">
									<i class="ki-duotone ki-magnifier fs-3 me-1">
						                <span class="path1"></span><span class="path2"></span></i>Search PR
								</button>
					            
					        </div>
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
						
							<div class="col-6">
								<div class="d-flex flex-column align-items-center gap-2">
									<c:choose>
										<c:when test="${not empty imgPathSignature}">
											<div class="sig-box locked">
												<img src="${pageContext.request.contextPath}${imgPathSignature}"
													style="max-height: 150px; max-width: 360px; object-fit: contain;" />													<div class="sig-lock-badge">
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
								<div class="border border-gray-200 rounded-3 h-100 d-flex flex-column align-items-center justify-content-center text-center py-8" id="receiverCard1">
										<div class="receiver-box d-flex flex-fill flex-column align-items-center justify-content-center gap-2" id="receiverBox1">
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
													<option value="equipment" selected>Equipment</option>
						                            <option value="consumables">Consumables</option>
													<option value="accessory">Accessory</option>
						                            <option value="office">Office supplies</option>
													<option value="accessory">Accessory</option>
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
												<select name="unit" id="unit" class="form-select h-45px" data-control="select2" data-placeholder="Select Unit">
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
								
										<div class="col-6 d-flex flex-column">
											<label class="required fw-medium text-gray-800 mb-2">Description / Detail</label>
											<textarea class="form-control text-gray-700" rows="3" name="po_item_description" id="po_description" placeholder="Description"></textarea>
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
												
												  
												    <span id="prSortLabel" class="fw-bold fs-6 text-gray-500">by Recent Updates</span>
												</div>
												        <h3 class="text-primary fw-bold">
												            <span id="prSelectedCount"></span> Selected
												        </h3>
												    
							        
											    
											</div>
					                        <div class="table-responsive">
					                            <table class="table table-striped align-middle gy-4 gs-7" id="prResultTable">
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
					
					<div class="d-flex justify-content-between g-10">
						<div class="d-flex">
							<button type="button" id="backFormBtn"
								onclick="location.href='purchase_order_list'"
								class="btn btn-lg btn-light fw-medium text-light-inverse px-6 py-4 me-4 border">Back
							</button>
						</div>
						<div class="d-flex">
							
							<button type="button" id="saveDraft" onclick="saveDraftForm()"
								class="btn btn-lg btn-cyan text-white fw-medium px-6 py-4 me-4">Save Draft
							</button>
							<button type="button" id="savePOFormBtn"
								class="btn btn-success text-white fw-medium px-6 py-4"
								onclick="submitPO()">Submit PO</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
<script type="text/javascript">
	const ctx = "${pageContext.request.contextPath}";
	const currentUserDisplay = "${empty loginUser.employeeId ? '' : loginUser.employeeId} - ${empty loginUser.nameEN ? '' : loginUser.nameEN}";

	function formatNowDateTime(){
	    const d = new Date();
	    const months = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
	    const pad = n => String(n).padStart(2,'0');
	    return `\${d.getDate()} \${months[d.getMonth()]} \${d.getFullYear()}, \${pad(d.getHours())}:\${pad(d.getMinutes())}`;

	}

	// --- PO Header/Vendor draft (sessionStorage) ---
	var poHeaderDraft = null;      // ค่าที่โหลดจาก session ตอน init
	var pendingLocationId = null;  // vendor_location_id ที่รอ consume หลัง get_company_profile
	var pendingContactId = null;   // contact_id ที่รอ consume หลัง get_company_location

	function saveHeaderToSession(){
		try {
			var data = {
				description: $('#description').val() || '',
				reference_no: $('#reference_no').val() || '',
				reference_date: $('#kt_reference_datepicker').val() || '',
				vendor_id: $('#vendor_id').val() || '',
				vendor_location_id: $('#vendor_location_id').val() || '',
				contact_id: $('#contact_id').val() || '',
				vendor_description: $('#vendor_description').val() || ''
			};
			sessionStorage.setItem(PO_HEADER_STORAGE_KEY, JSON.stringify(data));
		} catch (e) { console.error('save PO header draft failed', e); }
	}

	function loadHeaderFromSession(){
		try {
			var saved = sessionStorage.getItem(PO_HEADER_STORAGE_KEY);
			if (!saved) return;
			poHeaderDraft = JSON.parse(saved) || null;
			if (!poHeaderDraft) return;

			$('#description').val(poHeaderDraft.description || '');
			$('#reference_no').val(poHeaderDraft.reference_no || '');
			$('#vendor_description').val(poHeaderDraft.vendor_description || '');

			pendingLocationId = poHeaderDraft.vendor_location_id || null;
			pendingContactId = poHeaderDraft.contact_id || null;
		} catch (e) { console.error('load PO header draft failed', e); poHeaderDraft = null; }
	}

	document.addEventListener("DOMContentLoaded", function () {

		loadHeaderFromSession();

		var _refFp = flatpickr("#kt_reference_datepicker", {
	        dateFormat: "Y-m-d",
	        altInput: true,
	        altFormat: "d M Y",
	        locale: "en",
	        allowInput: false,
	        defaultDate: new Date()
	    });
		// ทับ default date ด้วยค่าที่ save ไว้
		if (poHeaderDraft && poHeaderDraft.reference_date) {
			_refFp.setDate(poHeaderDraft.reference_date, false);
		}
		
		document.querySelector('#kt_app_content_container').addEventListener('click', function(e){
		    const btn = e.target.closest('.collapsed, [data-target^="cart_"], a[id^="poGroupBtn_"]');
		    if (!btn) return;

		    let collapseEl;
		    if (btn.dataset.target) {
		        collapseEl = document.getElementById('poGroup_' + btn.dataset.target);
		    } else if (btn.id.startsWith('poGroupBtn_')) {
		        collapseEl = document.getElementById(btn.id.replace('poGroupBtn_', 'poGroup_'));
		    }
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
		
		//running number
		// function runNumber() {
		// 	const info = table.page.info();
		// 	table.column(1, {
		// 		page : 'current'
		// 			}).nodes().each(function(cell, i) {
		// 				cell.innerHTML = info.start + i + 1;
		// 				});
		// 	}
		
		// table.on('draw.dt order.dt search.dt', runNumber);
		// runNumber();
		
		
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
		                    const modal = bootstrap.Modal.getOrCreateInstance(modalEl);
		                    modal.show();
		                }
		            });
		        });
		    }
		    
		    var $vendorId = $('#vendor_id');
		    if (poHeaderDraft && poHeaderDraft.vendor_id) {
		        // มี draft -> ใช้ค่าที่ save ไว้ ไม่ auto-select บริษัทแรก
		        $vendorId.val(poHeaderDraft.vendor_id).trigger('change');
		    } else {
		        var $firstCompany = $vendorId.find('option').filter(function () {
		            return $(this).val() !== '';
		        }).first();

		        if ($firstCompany.length) {
		            $vendorId.val($firstCompany.val()).trigger('change');
		        }
		    }
		    
		   /*  const createPoModalEl = document.getElementById('modal_create_po');
		    const createPoModal = bootstrap.Modal.getOrCreateInstance(createPoModalEl);

		    createPoModalEl.addEventListener('hidden.bs.modal', function () {
		        $('#items_type').val('equipment').trigger('change');
		        $('#po_qty').val('');
		        $('#unit').val('');
		        $('#po_price').val('');
		        $('#po_description').val('');
		        
		        editingIndex = -1;
		        $('#modal_create_po .modal-title').text('Create PO - Detail');
		        $('#btnSavePoDetail').text('Save');

		        if (!document.querySelector('.modal.show')) {
		            document.body.classList.remove('modal-open');
		            document.body.style.removeProperty('overflow');
		            document.body.style.removeProperty('padding-right');
		            document.querySelectorAll('.modal-backdrop').forEach(el => el.remove());
		        }
		    }); */
		    const createPoModalEl = document.getElementById('modal_create_po');

		    createPoModalEl.addEventListener('show.bs.modal', function () {
		        if (editingIndex === -1) {
		            $('#items_type').val('equipment').trigger('change');
		            $('#po_qty').val('1');
		            $('#unit').val('');
		            $('#po_price').val('');
		            $('#po_description').val('');
		            $('#modal_create_po .modal-title').text('Create PO - Detail');
		            $('#btnSavePoDetail').text('Save');
		        }
		    });

		    createPoModalEl.addEventListener('hidden.bs.modal', function () {
		        editingIndex = -1;
		        // document.querySelectorAll('.modal-backdrop').forEach(el => el.remove());
		        // document.body.classList.remove('modal-open');
		        // document.body.style.removeProperty('padding-right');
		        // document.body.style.removeProperty('overflow');
		        // document.documentElement.style.removeProperty('overflow');
		    });

		    document.getElementById('btnOpenCreatePo').addEventListener('click', function () {
		        editingIndex = -1;
		        bootstrap.Modal.getOrCreateInstance(createPoModalEl, { backdrop: true }).show();
		    });

			const searchPrModalEl = document.getElementById('modal_search_pr');

			searchPrModalEl.addEventListener('hide.bs.modal', function () {
				if (document.activeElement && searchPrModalEl.contains(document.activeElement)) {
					document.activeElement.blur();
				}
			});
			
			searchPrModalEl.addEventListener('hidden.bs.modal', function () {
				isSearchPrModalOpen = false;
				selectedPrCategory = '';
				$('#searchPrCategory').val('').trigger('change.select2');
			});

			searchPrModalEl.addEventListener('show.bs.modal', function () {
				isSearchPrModalOpen = true;
				loadInprogressPrDetail();
			});

			// เปิด modal นี้ผ่าน JS เอง แทน data-bs-toggle="modal" เดิม — ใช้ pattern
			// เดียวกับ btnOpenCreatePo เป๊ะๆ (getOrCreateInstance().show() ตรงๆ ไม่ dispose
			// instance เก่า เพราะ dispose() แบบ synchronous กลางทาง transition ที่ยังไม่จบ
			// ทำให้ backdrop object หลุด track ค้างใน DOM ได้)
			document.getElementById('btnOpenSearchPr').addEventListener('click', function () {
				bootstrap.Modal.getOrCreateInstance(searchPrModalEl).show();
			});
		    
		    
	});
	
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

	// --- Multi-file Attach  ---
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

	function renderNewFileList() {
		var fileListDiv = document.getElementById('attachFileList');
		if (!fileListDiv) return;
		fileListDiv.innerHTML = '';
		fileListDiv.className = 'd-flex flex-column mt-3 gap-2';

		selectedFiles.forEach(function (file) {
			const fileName = file.name;
			const lastDotIndex = fileName.lastIndexOf('.');
			const nameOnly = lastDotIndex > -1 ? fileName.substring(0, lastDotIndex) : fileName;
			const fileExt = lastDotIndex > -1 ? fileName.substring(lastDotIndex) : '';
			const iconPath = getFileIconPath(fileName);

			const outerDiv = document.createElement('div');
			outerDiv.className = 'd-flex align-items-center justify-content-center mb-2';

			outerDiv.innerHTML =
				'<div class="d-flex align-items-center justify-content-between w-100 p-2 rounded">' +
					'<div class="d-flex align-items-center text-decoration-none text-gray-800 overflow-hidden" style="flex-grow: 1; min-width: 0;">' +
						'<img src="' + iconPath + '" class="w-25px h-25px me-3 flex-shrink-0" alt="icon" />' +
						'<span class="fs-6 fw-medium d-flex" style="min-width: 0;" title="' + fileName + '">' +
							'<span class="text-truncate">' + nameOnly + '</span>' +
							'<span class="text-gray-800 fw-medium flex-shrink-0">' + fileExt + '</span>' +
						'</span>' +
					'</div>' +
					'<span class="badge badge-light-danger bg-hover cursor-pointer delete-btn ms-3 flex-shrink-0">' +
						'<i class="ki-duotone ki-trash text-danger fs-2">' +
							'<span class="path1"></span><span class="path2"></span>' +
							'<span class="path3"></span><span class="path4"></span><span class="path5"></span>' +
						'</i>' +
					'</span>' +
				'</div>';

			outerDiv.querySelector('.delete-btn').addEventListener('click', function () {
				selectedFiles = selectedFiles.filter(f => f.name !== fileName);
				renderNewFileList();
				updateInputFiles();
			});

			fileListDiv.appendChild(outerDiv);
		});

		var warn = document.getElementById('attachFileWarningBox');
		if (warn) warn.style.display = selectedFiles.length > 0 ? 'none' : 'block';
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
	            if (list.length === 0) {
	                options = '<option value=""></option>';
	            } else {
	                var matchLoc = pendingLocationId != null && list.some(function (l) {
	                    return String(l.company_address_id) === String(pendingLocationId);
	                });
	                list.forEach(function (loc, index) {
	                    var isSel = matchLoc ? (String(loc.company_address_id) === String(pendingLocationId)) : (index === 0);
	                    options += '<option value="' + loc.company_address_id + '"' + (isSel ? ' selected' : '') + '>' + loc.address_name + '</option>';
	                });
	            }
	            $('#vendor_location_id').html(options).prop('disabled', false).trigger('change');
	            pendingLocationId = null; // consume ครั้งเดียว
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
	    $('#contact_id').html('<option value=""></option>').prop('disabled', true).trigger('change');

	    if (!addressId) return;

	    $.ajax({
	        url: ctx + '/get_company_location',
	        type: 'POST',
	        dataType: 'json',
	        data: { addressId: addressId },
	        success: function (resp) {
	            // if (resp.debug) console.log('[get_company_location debug]', resp.debug);
	            var data = resp.data;
	            if (!data) return;

	            $('#companyAddress').text(data.address ? data.address.address : '');
	            $('#companyAddressInfo').removeClass('d-none');

	            var list = data.contactList || [];
	            var options = '';
	            if (list.length === 0) {
	                options = '<option value=""></option>';
	            } else {
	                var matchC = pendingContactId != null && list.some(function (x) {
	                    return String(x.company_contact_id) === String(pendingContactId);
	                });
	                list.forEach(function (c, index) {
	                    var isSel = matchC ? (String(c.company_contact_id) === String(pendingContactId)) : (index === 0);
	                    options += '<option value="' + c.company_contact_id + '"' + (isSel ? ' selected' : '') + '>' + c.contact_name + '</option>';
	                });
	            }
	            $('#contact_id').html(options).prop('disabled', false).trigger('change');
	            pendingContactId = null; // consume ครั้งเดียว
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
		var itemsType = $(this).val().trim();
		if(!itemsType) return;
		
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

	// auto-save PO Header/Vendor draft ทุกครั้งที่ field เปลี่ยน
	$(document.body).on('input change', '#description, #reference_no, #vendor_description, #kt_reference_datepicker', saveHeaderToSession);
	$(document.body).on('change', '#vendor_id, #vendor_location_id, #contact_id', saveHeaderToSession);

</script>

<script>
let poDetailCart = [];
let poDetailCounter = 0;
let editingIndex = -1;
let confirmed1 = ${empty statusActiveSafe ? 'false' : 'true'}; //track ว่าลงชื่อ ผู้ขอเบิก แล้วหรือยัง

let requesterSign = null;

const PO_HEADER_STORAGE_KEY = 'poHeader_draft';
const PO_CART_STORAGE_KEY = 'poDetailCart_draft';

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
        renderPoDetailCart();
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

	// ถ้ากำลัง edit ของเดิม ให้เอา object เดิมมาเป็นฐานก่อน (เก็บ prId, mrId, prDetailId, refLink ไว้)
    const baseItem = (editingIndex >= 0 && poDetailCart[editingIndex]) ? poDetailCart[editingIndex] : {};

    const item = {
		...baseItem,
        itemsType: $("#items_type").val(),
        itemsTypeText: $("#items_type option:selected").text(),
        productId: $("#product_name").val(),
        productName: $("#product_name option:selected").text(),
        qty: Number($("#po_qty").val()),
        unit: $("#unit").val(),
        unitName: $("#unit option:selected").text(), 
        price: parseFormattedNumber($("#po_price").val()),
        description: $("#po_description").val(),
		creatorName: currentUserDisplay,
        savedAt: formatNowDateTime()
    };

    item.total = item.qty * item.price;

    if (editingIndex >= 0) {
        poDetailCart[editingIndex] = item;
        editingIndex = -1;
    } else {
        poDetailCart.push(item);
    }

    // console.log(item);
    // console.log(poDetailCart);
    
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

    poDetailCart.forEach(function(item,index){

        html += createPoCard(item,index);

    });

	if (poDetailCart.length === 0) {
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
    poDetailCart.forEach(function(item){

        grandTotal += item.total;

    });

    $("#poDetailGrandTotal").text(
        grandTotal.toLocaleString(undefined,{
            minimumFractionDigits:2,
            maximumFractionDigits:2
        })
    );

}

//-------- PO- Detail -----------
function createPoCard(item,index){
	const safePrice = Number(item.price) || 0;
    const safeQty = Number(item.qty) || 0;
    const safeTotal = Number(item.total) || (safeQty * safePrice);

    let icon = "";
    let category = "";

    if(item.itemsType=="equipment"){
        category="Equipment";
        icon=`
            <div class="symbol symbol-40px me-4">
                <i class="ki-duotone ki-monitor-mobile fs-2 text-primary">
                    <span class="path1"></span><span class="path2"></span>
                </i>
            </div>
        `;
    }else if(item.itemsType=="consumables"){
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

    const groupId = "cart_" + index;

    return `<div class="po-item-group border-gray-400 border-bottom pt-9 pb-6 px-6">
    			<div class="d-flex align-items-center justify-content-between row">
    				<div class="col-7 d-flex align-items-center">\${icon}
						<span class="text-gray-900 fs-5 fw-normal me-3">\${category}</span>
						<span class="text-gray-900 fs-5 fw-normal me-3">\${item.productName}</span>
		
						<div class="d-flex align-items-center">
							<i class="ki-duotone ki-document fs-2 text-muted me-2">
								<span class="path1"></span>
								<span class="path2"></span>
							</i>
		
							<span class="text-gray-900 fs-5 fw-normal">\${item.description}</span>
		
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
	                <a href="#" onclick="return editCartItem(\${index});" class="btn btn-icon btn-light-primary btn-sm" title="Edit">
	                    <i class="ki-duotone ki-pencil fs-2"><span class="path1"></span><span class="path2"></span></i>
	                </a>
	                <a href="#" onclick="return removeCartItem(\${index});" class="btn btn-icon btn-light-danger btn-sm" title="Delete">
	                    <i class="ki-duotone ki-trash fs-2"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i>
	                </a>
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
	                    (item.sources && item.sources.length > 0)
	                        ? item.sources.map(function(s){
	                            return createPoSourceRow(s.qty, s.unitName || item.unitName, s.savedAt, s.prId, s.mrId, s.refLink, s.creatorName);
	                          }).join('')
	                        : createPoSourceRow(item.qty, item.unitName, item.savedAt, item.prId, item.mrId, item.refLink, item.creatorName)
	                }
	            </div>
	        </div>
		
		</div>
		
		`;
}

function createPrMrBadges(prId, mrId, refLink){
    let html = '';

    if (prId) {
        html += `
        <a href="\${ctx}/purchase_requisition_edit?prId=\${prId}"
            target="_blank" onclick="event.stopPropagation();"
            class="badge badge-lg fs-7 fw-semibold d-inline-block text-center text-decoration-none badge-light-primary text-primary">
            \${prId}
        </a>`;

        if (mrId || refLink) {
            if (refLink) {
                html += `
                <a href="\${refLink}" target="_blank" class="text-primary d-inline-flex mx-1" onclick="event.stopPropagation();">
                    <i class="ki-duotone ki-fasten fs-2 text-primary">
                        <span class="path1"></span><span class="path2"></span>
                    </i>
                </a>`;
            } else {
                html += `
                <i class="ki-duotone ki-fasten fs-2 text-primary mx-1">
                    <span class="path1"></span><span class="path2"></span>
                </i>`;
            }
        }
    }

    if (mrId) {
        html += `
        <a href="\${ctx}/material_requisition_edit?mrId=\${mrId}"
            target="_blank" onclick="event.stopPropagation();"
            class="badge badge-lg fs-7 fw-semibold d-inline-block text-center text-decoration-none badge-light-purple text-purple">
            \${mrId}
        </a>`;
    }

    if (!prId && !mrId) {
        html = `<span class="badge badge-lg fs-7 fw-semibold d-inline-block text-center badge-light-primary text-primary">-</span>`;
    }

    return html;
}

function createPoSourceRow(qty, unitName, savedAt, prId, mrId, refLink, creatorName){
    return `
    <div class="d-flex align-items-center justify-content-between row mb-6">
        <div class="col-11">
            <div class="d-flex align-items-center fs-7">
                <div class="col-4">
                    <i class="ki-duotone ki-user-tick fs-3 text-muted me-2">
                        <span class="path1"></span><span class="path2"></span><span class="path3"></span>
                    </i>
                    <span class="text-gray-800 fs-5 fw-normal">\${creatorName || currentUserDisplay}</span>
                </div>
                <div class="col-4 d-flex align-items-center">
                    <i class="ki-duotone ki-calendar-2 fs-3 me-2">
                        <span class="path1"></span><span class="path2"></span><span class="path3"></span>
                        <span class="path4"></span><span class="path5"></span>
                    </i>
                    <span class="text-gray-800 fs-5 fw-normal">\${savedAt}</span>
                </div>
                <div class="col-3 d-flex align-items-center gap-2">
                    <i class="ki-duotone ki-tablet-book fs-3">
                         <span class="path1"></span><span class="path2"></span>
                    </i>
                    \${createPrMrBadges(prId, mrId, refLink)}
                </div>
            </div>
        </div>
        <div class="col-1 text-end">
            <span class="text-gray-800 fs-5 fw-normal">\${qty}</span>
    		<span class="text-gray-800 fs-5 fw-normal ms-2">\${unitName}</span>
        </div>
    </div>`;
}

function editCartItem(index){
    const item = poDetailCart[index];
    if (!item) return false;

    editingIndex = index;

    $('#modal_create_po .modal-title').text('Edit PO - Detail');
    $('#btnSavePoDetail').text('Update');

    $('#items_type').val(item.itemsType).trigger('change');

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
    $('#unit').val(item.unit).trigger('change');
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
			const removedItem = poDetailCart[index];
            poDetailCart.splice(index, 1);
            saveCartToSession();    
            renderPoDetailCart();
			uncheckPrCheckboxesForItem(removedItem);
        }
    });
    return false;
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


//──────── Confirm Receiver ───────────
function confirmReceiver(slot) {
    const now = new Date();
    const pad = n => String(n).padStart(2, '0');
    const months = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];

    const timestamp =
        now.getFullYear() + "-" +
        pad(now.getMonth()+1) + "-" +
        pad(now.getDate()) + " " +
        pad(now.getHours()) + ":" +
        pad(now.getMinutes()) + ":" +
        pad(now.getSeconds());

    const displayTimestamp = now.getDate() + " " + months[now.getMonth()] + " " + now.getFullYear() +
        " , " + pad(now.getHours()) + ":" + pad(now.getMinutes());

    requesterSign = {
        userId: "${loginUser.employeeId}",
        userName: currentUserDisplay,
        requestAt: timestamp
    };

    sessionStorage.setItem("poRequesterSign", JSON.stringify(requesterSign));

    const labelEl = document.getElementById('receiverLabel'+slot);
    if (labelEl) labelEl.style.display = 'none';

    document.getElementById('receiverPreview'+slot).innerHTML =
        '<span class="fw-semibold text-dark fs-7">' + requesterSign.userName + '</span>' +
        '<span class="text-muted fs-8 mt-1">' + displayTimestamp + '</span>';

    const btn = document.getElementById('receiverBtn'+slot);
    btn.textContent = "✓ ยืนยันแล้ว";
    btn.className = "btn btn-success btn-sm px-5";
    btn.disabled = true;

    const card = document.getElementById('receiverCard'+slot);
    if (card) {
        card.classList.remove('border-gray-300');
        card.classList.add('border-success', 'bg-light-success');
    }

    if (slot === 1) {
        confirmed1 = true;
    }
}

function saveDraftForm(){
    const payload = {
        companyId: $('#vendor_id').val().trim() || '',
        companyLocation: $('#vendor_location_id').val().trim() || '',
        contactId: $('#contact_id').val().trim() || '',
        description: $('#description').val().trim() || '',
		descriptionVendor: $('#vendor_description').val().trim() || '',
        referenceNo: $('#reference_no').val().trim() || '',
        referenceDate: $('#kt_reference_datepicker').val().trim() || '',
        poDetailCartJson: JSON.stringify(poDetailCart),
        signDate: requesterSign?.requestAt ?? '',
    };

    const fd = new FormData();
    Object.keys(payload).forEach(function (k) { fd.append(k, payload[k]); });
    selectedFiles.forEach(function (file) { fd.append('files', file, file.name); });

    $.ajax({
        url: ctx + '/save_po',
        type: 'POST',
        dataType: 'json',
        data: fd,
        processData: false,
        contentType: false,
        success: function (resp) {
            // if (resp.debug) console.log('[save_po debug]', resp.debug);
            if (resp.data && resp.data.poId) {
                sessionStorage.removeItem(PO_CART_STORAGE_KEY);
                sessionStorage.removeItem(PO_HEADER_STORAGE_KEY);
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
    if (!$('#description').val().trim()) errors.push('Description');
    if (!$('#vendor_id').val().trim()) errors.push('Company Name');
    if (!$('#vendor_location_id').val().trim()) errors.push('Company Location');
    if (!$('#contact_id').val().trim()) errors.push('Contact Name');
    if (!poDetailCart || poDetailCart.length === 0) {
        errors.push('Please add at least 1 Po Detail');
    } else {
        // เช็คว่ามีรายการไหนราคายังเป็น 0 / ยังไม่ได้ใส่ราคา
        const zeroPriceItems = poDetailCart.filter(item => !item.price || Number(item.price) <= 0);
        if (zeroPriceItems.length > 0) {
            const names = zeroPriceItems.map(i => i.productName).join(', ');
            errors.push('กรุณาใส่ราคาต่อหน่วยให้ครบทุกรายการ (' + names + ')');
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
            companyId: $('#vendor_id').val().trim() || '',
            companyLocation: $('#vendor_location_id').val().trim() || '',
            contactId: $('#contact_id').val().trim() || '',
            description: $('#description').val().trim() || '',
			descriptionVendor: $('#vendor_description').val().trim() || '',
            referenceNo: $('#reference_no').val().trim() || '',
            referenceDate: $('#kt_reference_datepicker').val().trim() || '',
            poDetailCartJson: JSON.stringify(poDetailCart),
            status: '2',
            signDate: requesterSign?.requestAt ?? ''
        };

        const fd = new FormData();
        Object.keys(payload).forEach(function (k) { fd.append(k, payload[k]); });
        selectedFiles.forEach(function (file) { fd.append('files', file, file.name); });

        $('#savePOFormBtn').prop('disabled', true);

        $.ajax({
            url: ctx + '/save_po',
            type: 'POST',
            dataType: 'json',
            data: fd,
            processData: false,
            contentType: false,
            success: function (resp) {
                // if (resp.debug) console.log('[save_po debug]', resp.debug);
                if (resp.data && resp.data.poId) {
                    sessionStorage.removeItem(PO_CART_STORAGE_KEY);
                    sessionStorage.removeItem(PO_HEADER_STORAGE_KEY);
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

// Modal PR
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

    var mapped = mapDbItemsTypeToSelect(item.product_type);
    console.log('[DEBUG] row', dataIndex, '| product_type:', item.product_type, '| mapped:', mapped, '| selected:', selectedPrCategory, '| match:', mapped === selectedPrCategory);
    return mapped === selectedPrCategory;
});

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
            inprogressPrDetailList = (data && data.prDetailList) || [];
            renderPrResultTable(inprogressPrDetailList);
        },
        error: function () {
            Swal.fire('Error', 'ไม่สามารถโหลดข้อมูล PR ได้', 'error');
        }
    });
}

function getCategoryIcon(productType){
    switch(String(productType)){
        case '1': return { name: 'Equipment', icon: '<i class="ki-duotone ki-monitor-mobile fs-2 text-primary"><span class="path1"></span><span class="path2"></span></i>' };
        case '2': return { name: 'Consumables', icon: '<i class="ki-duotone ki-lots-shopping fs-2 text-orange"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span><span class="path7"></span><span class="path8"></span></i>' };
        case '3': return { name: 'Accessory', icon: '<i class="ki-duotone ki-medal-star fs-2 text-teal"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i>' };
        case '4': return { name: 'Office supplies', icon: '<i class="ki-duotone ki-parcel fs-2 text-success"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i>' };
        default:  return { name: '-', icon: '' };
    }
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

// function formatTimeCreate(inputDate){
//     const d = inputDate ? new Date(String(inputDate).replace(' ', 'T')) : new Date();
//     const months = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
//     const pad = n => String(n).padStart(2,'0');
//     return `\${d.getDate()} \${months[d.getMonth()]} \${d.getFullYear()}, \${pad(d.getHours())}:\${pad(d.getMinutes())}`;
// }
function formatNowDateTime(inputDate){
    const d = inputDate ? new Date(String(inputDate).replace(' ', 'T')) : new Date();
    const months = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
    const pad = n => String(n).padStart(2,'0');
    return `\${d.getDate()} \${months[d.getMonth()]} \${d.getFullYear()}, \${pad(d.getHours())}:\${pad(d.getMinutes())}`;
}

$(document.body).on('keyup input', '#searchPrKeyword', function () {
    if (prDetailTable) {
        prDetailTable.search(this.value).draw();
    }
});

$(document.body).on('change', '#searchPrCategory', function () {
    selectedPrCategory = $(this).val();
	console.log('[DEBUG] category changed →', selectedPrCategory, '| table exists:', !!prDetailTable);
    if (prDetailTable) {
        prDetailTable.draw();
    }
});

function isPrDetailIdInCart(prDetailId){
    return poDetailCart.some(function(it){
        return (it.sources || []).some(function(s){
            return String(s.prDetailId) === String(prDetailId);
        });
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
		var description = item.description || '';
		var initial = userName.charAt(0).toUpperCase();
		var userPath = item.user_create_path || '';
		var statusBadge = item.pr_status == '3'
			? '<span class="badge badge-lg bg-success fw-semibold fs-7 text-white">Approved</span>'
			: item.pr_status == '7'
			? '<span class="badge badge-lg bg-cyan fw-semibold fs-7 text-white">In-Progress</span>'
			: '';

		html += `
		<tr class="fw-semibold fs-6 text-gray-800 border-bottom border-gray-200">
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
				<div class="d-flex flex-column">
					<span class="text-gray-900 fs-6 fw-normal">\${item.product_name || ''}</span>
					
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
		ordering : true,
		searching : true,
		autoWidth : false,
		info: false,
		paging: false,
		columnDefs : [
			{ orderable: false, targets: [0,6] },
			{ orderable: true, targets: [1,2,3,4,5] },
			{
				targets: -1,
				orderable: false
			}
		],
		order: [],
		drawCallback: function(settings) {
			var api = this.api();

			// อัปเดตเลขลำดับแถว (running number) ตามที่แสดงจริง
			api.column(1, { search: 'applied', order: 'applied' })
				.nodes()
				.each(function (cell, i) {
					cell.innerHTML = i + 1;
				});

			// อัปเดตจำนวน Items Found ตามที่ filter/search เหลือจริง
			document.getElementById('prItemsFoundCount').textContent = api.rows({ search: 'applied' }).count();
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
        });
    });

    checkAll.checked = list.length > 0 && list.every(function (d) { return isPrDetailIdInCart(d.pr_detail_id); });
    checkAll.onchange = function(){
        document.querySelectorAll('.pr-row-check').forEach(cb => cb.checked = this.checked);
        updatePrSelectedCountReal();
    };
}

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

document.getElementById('btnSubmitPr').addEventListener('click', function(){
    var selectedIds = [];
    document.querySelectorAll('.pr-row-check:checked').forEach(function(cb){
        selectedIds.push(cb.getAttribute('data-pr-detail-id'));
    });
    var selectedIdSet = {};
    selectedIds.forEach(function(id){ selectedIdSet[String(id)] = true; });

    // เอารายการออกจาก poDetailCart: รายการที่เคยดึงเข้ามาจากตารางนี้
    inprogressPrDetailList.forEach(function(d){
        var prDetailId = String(d.pr_detail_id);
        if (selectedIdSet[prDetailId]) return; //ถ้ายังติ๊กอยู่ ไม่ต้องลบ

        for (var i = poDetailCart.length - 1; i >= 0; i--) {
            var cartItem = poDetailCart[i];
            if (!cartItem.sources) continue;

            var srcIdx = cartItem.sources.findIndex(function (s) {
                return String(s.prDetailId) === prDetailId;
            });
            if (srcIdx === -1) continue;

            var removedQty = Number(cartItem.sources[srcIdx].qty) || 0;
            cartItem.sources.splice(srcIdx, 1);

            if (cartItem.sources.length === 0) {
                poDetailCart.splice(i, 1);
            } else {
                cartItem.qty = Math.max(0, (Number(cartItem.qty) || 0) - removedQty);
                cartItem.total = cartItem.qty * (Number(cartItem.price) || 0);
            }
        }
    });

    // เพิ่มเข้า poDetailCart: รายการที่ติ๊กใหม่ (ยังไม่มีใน poDetailCart) หรือรายการที่เคยติ๊กแล้วแต่ถูกลบออกไปก่อนหน้านี้
    selectedIds.forEach(function(prDetailId){
        var src = inprogressPrDetailList.find(function(d){ return String(d.pr_detail_id) === String(prDetailId); });
        if (!src) return;

        var qty = Number(src.amount_total) || 0;
        var price = Number(src.unit_price) || 0;

        // ข้อมูลที่มา (ต่อ PR แต่ละใบ)
        var sourceEntry = {
            prId: src.pr_id,
            prDetailId: src.pr_detail_id,
            mrId: src.mr_id || '',
            qty: qty,
            unitName: src.unit_name || '',
            refLink: src.ref_link || '',
			creatorName: (src.user_create_emp_id ? src.user_create_emp_id + ' - ' : '') + (src.user_create_name || ''),
            savedAt: formatNowDateTime(src.time_create)
        };

        // หา item ที่ productId เดียวกันใน cart อยู่แล้วหรือยัง (group ตาม Product)
        var existingIndex = poDetailCart.findIndex(function(it){
            return String(it.productId) === String(src.product_id);
        });

        if (existingIndex >= 0) {
            var existing = poDetailCart[existingIndex];

            // กันเพิ่มซ้ำ ถ้า pr_detail_id นี้ถูกดึงมาแล้ว
            var alreadyAdded = (existing.sources || []).some(function(s){
                return String(s.prDetailId) === String(src.pr_detail_id);
            });
            if (alreadyAdded) return;

            existing.sources = existing.sources || [];
            existing.sources.push(sourceEntry);
            existing.qty = (Number(existing.qty) || 0) + qty;
            existing.total = existing.qty * (Number(existing.price) || 0);
        } else {
            var item = {
                itemsType: mapDbItemsTypeToSelect(src.product_type),
                itemsTypeText: getCategoryIcon(src.product_type).name,
                productId: src.product_id,
                productName: src.product_name || '',
                qty: qty,
                unit: src.unit,
                unitName: src.unit_name || '',
                price: price,
                description: '',
                sources: [sourceEntry]
            };
            item.total = item.qty * item.price;
            poDetailCart.push(item);
        }
    });

    saveCartToSession();
    renderPoDetailCart();

	if (document.activeElement) {
        document.activeElement.blur();
    }

    var modalEl = document.getElementById('modal_search_pr');
	var modal = bootstrap.Modal.getInstance(modalEl);

	if (modal) {
		modal.hide();
	}
});

</script>
</html>