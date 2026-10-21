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
/* ==================== Table MR ==================== */

[data-bs-theme="light"] #mrResultTable.table.table-striped > tbody > tr:nth-of-type(odd) > * {
    background-color: #FBFBFB !important;
    box-shadow: none !important;
}

[data-bs-theme="dark"] #mrResultTable.table.table-striped > tbody > tr:nth-of-type(odd) > * {
    background-color: #191B20 !important;
    box-shadow: none !important;
}


/* ===== Table Header ===== */

#mrResultTable thead th {
    white-space: nowrap !important;
    vertical-align: middle !important;
    padding-right: 35px !important;
    cursor: pointer;
}


/* ===== DataTables Header ===== */

#mrResultTable thead th .dt-column-header {
    display: inline-flex !important;
    align-items: center !important;
    width: auto !important;
    white-space: nowrap !important;
}

#mrResultTable thead th .dt-column-title {
    display: inline-block !important;
    white-space: nowrap !important;
}

/* ===== Remove old DataTables arrow ===== */

#mrResultTable thead th.sorting::before,
#mrResultTable thead th.sorting::after,
#mrResultTable thead th.sorting_asc::before,
#mrResultTable thead th.sorting_asc::after,
#mrResultTable thead th.sorting_desc::before,
#mrResultTable thead th.sorting_desc::after {
    display: none !important;
}

/* ===== First / Last Column ===== */

#mrResultTable thead th:first-child{
    padding-right: 0 !important;
}

/* ===== MR Search Modal ===== */

#modal_search_mr .table-responsive {
    max-height: 50vh;
    overflow-y: auto;
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

.pr-src-actions {
	display: none;
	min-width: 80px;
}
.pr-src-menu.menu-open .pr-src-actions {
	display: block;
}
.pr-src-menu.menu-open > .btn {
	background-color: var(--bs-primary);
	color: #fff;
}

/* ===== Responsive (mobile < 768px) ===== */
@media (max-width: 767.98px) {
	.sig-box {
		height: 160px;
	}

	.pr-src-actions {
		max-width: calc(100vw - 32px);
	}

	#kt_scrolltop {
		bottom: 90px !important;
	}
}
</style>

</head>
<body class="app-default">
<input type="hidden" id="hasSignature" value="${not empty imgPathSignature}" />
	<div class="app-main flex-column flex-row-fluid">
		<div class="d-flex flex-column flex-column-fluid">
			<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
				<div id="kt_app_toolbar_container" class="app-container container-fluid d-flex flex-stack flex-wrap gap-3">
				
					<div class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
						<h1 class="page-heading d-flex text-gray-700 fw-semibold flex-column justify-content-center my-0">
							Add PR - Purchase Requisition
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
						<div class="col-md-12 col-lg-7 col-xl-7 col-xxl-8 mb-10">
							<div class="card h-100 ">
								<div class="card-header border-0 px-9 pt-7 d-flex align-items-center justify-content-between">
									<div class="card-title">
										<h3 class="fw-semibold text-gray-900">PR - Header</h3>
									</div>
								</div>
								<div class="card-body filter-card px-5 px-lg-10 py-9 rounded-3">
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
									<label class="required fw-medium text-gray-800 mb-2">Description</label>
									<textarea class="form-control text-gray-700" id="description" name="description"
										placeholder="Description" rows="3"></textarea>
								</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-12 col-lg-5 col-xl-5 col-xxl-4 mb-10 mt-0 mt-lg-5">
							<div class="card h-100 d-flex flex-column">
								<div class="card-header border-0 px-9 pt-7 d-flex align-items-center justify-content-between">
									<div class="card-title">
										<h3 class="fw-semibold text-gray-900">Attach files</h3>
									</div>
									<label for="myFile" id="lbFile" class="btn btn-lg btn-primary d-inline-flex align-items-center justify-content-center fw-medium h-40px my-0">
										Upload
										<input type="file" id="myFile" name="files" multiple style="display: none;"
											accept="image/jpeg,image/png,image/gif,image/webp,image/bmp,application/pdf,application/zip,application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document">
									</label>
								</div>
								<div class="card-body filter-card px-5 px-lg-10 py-5 rounded-3">
									<div id="attachFileWarningBox"
										class="border border-2 border-warning rounded border-active active w-100">
										<div class="py-5 d-flex flex-column align-items-center">
											<div class="fs-3 fw-bold text-warning d-flex justify-content-center align-items-center gap-2 mb-5">
												<i class="ki-duotone ki-information-2 fs-3x text-warning">
													<span class="path1"></span> <span class="path2"></span> <span class="path3"></span>
												</i> Attach files
											</div>
											<div class="d-flex justify-content-center align-items-center text-center fw-medium fs-7 mb-5 text-gray-800">Only
												English filenames are accepted.</div>
											<div class="d-flex justify-content-center align-items-center text-center fw-medium fs-7 text-muted">
												Files with Thai or special characters may<br> not open
												correctly after upload.
											</div>
										</div>
									</div>
									<div class="d-flex flex-column h-100" style="min-height: 0;">
										<div id="attachFileList" class="d-flex flex-column gap-5"></div>
										<div id="errorMsgAF" class="text-danger fs-8 mt-1"></div>
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="card mb-10">
						<div class="card-header border-0 px-9 pt-7 d-flex flex-wrap align-items-center justify-content-between gap-3">
					        <div class="card-title">
					            <h3 class="fw-semibold text-gray-900">PR - Detail</h3>
					        </div>
					        <div class="card-title flex-wrap gap-3">
						         <button type="button" id="btnOpenCreatePr" class="btn btn-lg btn-success fw-medium text-white px-6 py-4">
									<i class="ki-outline ki-plus fs-3 me-1"></i>Create
								</button>
								
								<button type="button" id="btnOpenSearchMr" class="btn btn-lg btn-primary fw-medium text-white px-6 py-4">
									<i class="ki-duotone ki-magnifier fs-3 me-1">
						                <span class="path1"></span><span class="path2"></span></i>Search MR
								</button>
					            
					        </div>
					    </div>
						<div class="card-body filter-card px-5 px-lg-10 py-8 rounded-3">
							<div id="prDetailCartContainer"></div>
						</div>
					</div>
					
					
					
					<div class="card mb-10">
						<div class="card-header border-0 px-9 pt-7 d-flex align-items-center justify-content-between">
							<div class="card-title">
								<h3 class="fw-semibold text-gray-900">Signature</h3>
							</div>
						</div>
					<form id="signatureForm" method="post" action="update_signature" enctype="multipart/form-data">
						<div class="card-body filter-card px-5 px-lg-10 py-9 rounded-3 row g-5">
						
							<div class="col-12 col-md-6">
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

							<div class="col-12 col-md-6">
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
					
					
					<div class="modal fade" tabindex="-1" id="modal_create_pr">
						<div class="modal-dialog modal-lg modal-fullscreen-sm-down modal-dialog-centered">
						    <div class="modal-content">
						        <div class="modal-header">
						            <h3 class="modal-title">Create PR - Detail</h3>
					
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
									
									<div class="row g-5 mb-6" id="prQtyUnitRow">
										<div class="col-lg-6 col-md-6 col-12 d-flex flex-column">
											<label class="required fw-medium text-gray-800 mb-2">จำนวน</label>
											<input type="number" class="form-control text-gray-700 h-45px" min="1"
													name="pr_qty" id="pr_qty" placeholder="1" value="1" />
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
										<div class="col-12 col-md-6 d-flex flex-column">
											<label class="fw-medium text-gray-800 mb-2">Description / Detail</label>
											<textarea class="form-control text-gray-700" rows="3" name="pr_description" id="pr_description" placeholder="Description"></textarea>
										</div>

										<div class="col-lg-6 col-md-6 col-12 d-flex flex-column" id="prRefLinkRow">
											<label class="fw-medium text-gray-800 mb-2">Ref Link</label>
											<textarea class="form-control text-gray-700" rows="3" name="pr_ref_link" id="pr_ref_link" placeholder="https://..."></textarea>
										</div>

									</div>
						        </div>
						
						        <div class="modal-footer">
						            <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
						            <button type="button" class="btn btn-success" id="btnSavePrDetail"
        									onclick="addPrDetailToCart()">Save</button>
						        </div>
						    </div>
						</div>
					</div>
				
					<div class="modal fade" tabindex="-1" id="modal_search_mr">
					    <div class="modal-dialog modal-xl modal-fullscreen-lg-down">
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
					                        <label class="required fw-medium text-gray-800 mb-2">Search</label>
					                        <div class="input-group">
					                            <input type="text" class="form-control text-gray-700 h-45px" name="searchMrKeyword" id="searchMrKeyword" />

					                        </div>
					                    </div>

					                    <div class="col-lg-6 col-md-6 col-12 d-flex flex-column">
					                        <label class="required fw-medium text-gray-800 mb-2">Category</label>
					                        <select name="searchMrCategory" id="searchMrCategory" class="form-select h-45px" data-control="select2">
					                            <option value="" selected>All</option>
					                            <option value="equipment">Equipment</option>
					                            <option value="consumables">Consumables</option>
												<option value="accessory">Accessory</option>
					                            <option value="office">Office supplies</option>
					                        </select>
					                    </div>
					                </div>

					                <div class="row g-5 mb-6 mt-3">
						                    <div class="d-flex flex-wrap align-items-center justify-content-between gap-2 mb-4">
							                    <div class="d-flex align-items-center gap-2">
								                    <h3 class="text-gray-900 fw-bold">
													        <span id="mrItemsFoundCount"></span> Items Found
													    </h3>

														<span id="mrSortLabel" class="fw-bold fs-6 text-gray-500">by Recent Updates ↓</span>
													</div>
													<h3 class="text-primary fw-bold">
													    <span id="mrSelectedCount"></span> Selected
													</h3>

											</div>
					                        <div class="table-responsive">
					                            <table class="table table-striped align-middle gy-4 gs-7" id="mrResultTable">
					                                <thead>
					                                    <tr class="fs-7 fw-bold text-gray-500 text-uppercase border-bottom border-gray-200 mb-0">
					                                        <th class="min-w-15px ">
					                                            <div class="text-center form-check form-check-sm">
					                                                <input class="form-check-input" type="checkbox" id="checkAllMr" />
					                                            </div>
					                                        </th>
					                                        <th class="min-w-40px text-start mx-0 d-none d-md-table-cell">#</th>
					                                        <th class="min-w-80px">MR ID</th>
					                                        <th class="min-w-100px">Category</th>
					                                         <th class="min-w-200px">Request Name</th>
					                                        <th class="min-w-200px">Product</th>
					                                        <th class="min-w-100px text-end px-2 d-none d-md-table-cell">Status</th>
					                                    </tr>
					                                </thead>
					                                <tbody id="mrResultBody"></tbody>
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

					<div class="modal fade" tabindex="-1" id="modal_edit_source">
						<div class="modal-dialog modal-lg modal-dialog-centered">
							<div class="modal-content">
								<div class="modal-header">
									<h3 class="modal-title">Edit PR - Detail</h3>
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

									<div class="d-flex align-items-center justify-content-between flex-wrap gap-5 bg-light rounded p-5 mb-8">
										<div class="d-flex align-items-center flex-wrap gap-8">
											<div class="d-flex align-items-center">
												<i class="ki-duotone ki-user-tick fs-3 text-muted me-2"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i>
												<span class="text-gray-800 fs-5" id="editSrcCreator"></span>
											</div>
											<div class="d-flex align-items-center">
												<i class="ki-duotone ki-calendar-2 fs-3 me-2"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i>
												<span class="text-gray-800 fs-5" id="editSrcDate"></span>
											</div>
											<div class="d-flex align-items-center gap-2">
												<i class="ki-duotone ki-tablet-book fs-3"><span class="path1"></span><span class="path2"></span></i>
												<span id="editSrcMr"></span>
											</div>
										</div>
										<div class="text-end">
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
									<button type="button" class="btn btn-success" onclick="saveEditSource()">Update</button>
								</div>
							</div>
						</div>
					</div>
					
					<div class="pr-action-bar d-flex flex-wrap justify-content-between gap-3">
						<div class="d-flex flex-wrap gap-3">
							<button type="button" id="backFormBtn"
								onclick="location.href='purchase_requisition_list'"
								class="btn btn-lg btn-light fw-medium text-light-inverse px-6 py-4 border">Back
							</button>
						</div>
						<div class="d-flex flex-wrap gap-3">
							
							<button type="button" id="saveDraft" onclick="saveDraftForm()"
								class="btn btn-lg btn-cyan text-white fw-medium px-6 py-4">Save Draft
							</button>
							<button type="button" id="savePRFormBtn"
								class="btn btn-success text-white fw-medium px-6 py-4"
								onclick="submitPR()">Submit PR</button>
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

	function formatNowDateTime(inputDate){
		const d = inputDate ? new Date(String(inputDate).replace(' ', 'T')) : new Date();
		const months = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
		const pad = n => String(n).padStart(2,'0');
		return `\${d.getDate()} \${months[d.getMonth()]} \${d.getFullYear()}, \${pad(d.getHours())}:\${pad(d.getMinutes())}`;
	}

	// --- PO Header/Vendor draft (sessionStorage) ---
	var prHeaderDraft = null; // ค่าที่โหลดจาก session ตอน init

	function saveHeaderToSession(){
		try {
			var data = {
				description: $('#description').val() || ''
			};
			sessionStorage.setItem(PR_HEADER_STORAGE_KEY, JSON.stringify(data));
		} catch (e) { console.error('save PR header draft failed', e); }
	}

	function loadHeaderFromSession(){
		try {
			var saved = sessionStorage.getItem(PR_HEADER_STORAGE_KEY);
			if (!saved) return;
			prHeaderDraft = JSON.parse(saved) || null;
			if (!prHeaderDraft) return;

			$('#description').val(prHeaderDraft.description || '');

		} catch (e) { console.error('load PR header draft failed', e); prHeaderDraft = null; }
	}

	document.addEventListener("DOMContentLoaded", function () {
		loadHeaderFromSession();

		document.querySelector('#kt_app_content_container').addEventListener('click', function(e){
		    const btn = e.target.closest('.collapsed, [data-target^="cart_"], a[id^="prGroupBtn_"]');
		    if (!btn) return;

		    let collapseEl;
		    if (btn.dataset.target) {
		        collapseEl = document.getElementById('prGroup_' + btn.dataset.target);
		    } else if (btn.id.startsWith('prGroupBtn_')) {
		        collapseEl = document.getElementById(btn.id.replace('prGroupBtn_', 'prGroup_'));
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

		    const searchMrModalEl = document.getElementById('modal_search_mr');

		    searchMrModalEl.addEventListener('hide.bs.modal', function () {
		        if (document.activeElement && searchMrModalEl.contains(document.activeElement)) {
		            document.activeElement.blur();
		        }
		    });

		    searchMrModalEl.addEventListener('hidden.bs.modal', function () {
		        isSearchMrModalOpen = false;
                // ล้างติ๊กค้างใน modal Search MR
                if (mrDetailTable) { mrDetailTable.destroy(); mrDetailTable = null; }
                $('#mrResultBody').empty();
                $('#checkAllMr').prop('checked', false);
                $('#mrSelectedCount').text('0');

		        selectedMrCategory = '';
				pendingMrKeyword = null;
        		$('#searchMrKeyword').val('');
		        $('#searchMrCategory').val('').trigger('change.select2');
		    });

		    searchMrModalEl.addEventListener('show.bs.modal', function () {
		        isSearchMrModalOpen = true;
		        loadInprogressMrDetail();
		    });

		    document.getElementById('btnOpenSearchMr').addEventListener('click', function () {
		        bootstrap.Modal.getOrCreateInstance(searchMrModalEl).show();
		    });

		    const createPrModalEl = document.getElementById('modal_create_pr');

		    createPrModalEl.addEventListener('show.bs.modal', function () {
				if (editingIndex === -1) {
					$('#items_type').val('equipment').trigger('change');
					$('#pr_qty').val('1');
					$('#unit').val('');
					$('#pr_ref_link').val('');
					$('#pr_description').val('');
					$('#modal_create_pr .modal-title').text('Create PR - Detail');
					$('#btnSavePrDetail').text('Save');
					$('#prQtyUnitRow').removeClass('d-none');
					$('#prRefLinkRow').removeClass('d-none');
				}  else {
					$('#prQtyUnitRow').addClass('d-none');
				}
			});

		    createPrModalEl.addEventListener('shown.bs.modal', function () {
		        document.body.classList.add('modal-open');
		        document.body.style.overflow = 'hidden';
		        document.documentElement.style.overflow = 'hidden';
		    });

		    createPrModalEl.addEventListener('hidden.bs.modal', function () {
		        editingIndex = -1;
		        editAllowProductChange = false;
		        $('#items_type').prop('disabled', false);
		        $('#product_name').prop('disabled', false);
		        document.querySelectorAll('.modal-backdrop').forEach(el => el.remove());
		        document.body.classList.remove('modal-open');
		        document.body.style.removeProperty('padding-right');
		        document.body.style.removeProperty('overflow');
		        document.documentElement.style.removeProperty('overflow');
		    });

			document.getElementById('modal_edit_source').addEventListener('hidden.bs.modal', function () {
				editingSrc = null;
			});

		    document.getElementById('btnOpenCreatePr').addEventListener('click', function () {
		        editingIndex = -1;
		        bootstrap.Modal.getOrCreateInstance(createPrModalEl, { backdrop: true }).show();
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
		fileListDiv.className = 'd-flex flex-column gap-5';

		selectedFiles.forEach(function (file) {
			const fileName = file.name;
			const lastDotIndex = fileName.lastIndexOf('.');
			const nameOnly = lastDotIndex > -1 ? fileName.substring(0, lastDotIndex) : fileName;
			const fileExt = lastDotIndex > -1 ? fileName.substring(lastDotIndex) : '';
			const iconPath = getFileIconPath(fileName);

			const outerDiv = document.createElement('div');
			outerDiv.className = 'd-flex align-items-center justify-content-center mb-2';

			outerDiv.innerHTML =
				'<div class="d-flex align-items-center justify-content-between w-100 rounded">' +
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

	// auto-save PR Header draft ทุกครั้งที่ field เปลี่ยน
	$(document.body).on('input change', '#description', saveHeaderToSession);

</script>

<script>
let prDetailCart = [];
let prDetailCounter = 0;
let editingIndex = -1;
let editAllowProductChange = false;
let confirmed1 = ${empty statusActiveSafe ? 'false' : 'true'}; //track ว่าลงชื่อ ผู้ขอเบิก แล้วหรือยัง

let requesterSign = null;

const PR_HEADER_STORAGE_KEY = 'prHeader_draft';
const PR_CART_STORAGE_KEY = 'prDetailCart_draft';

function addSourceToCart(itemBase, source){
    const idx = prDetailCart.findIndex(function(it){
        return String(it.productId) === String(itemBase.productId);
    });
    if (idx >= 0) {
        const ex = prDetailCart[idx];

        // item เดิมที่ยังไม่มี sources → ห่อตัวเองเป็น source แรกก่อน (เหมือน PO)
        if (!ex.sources || ex.sources.length === 0) {
            ex.sources = [{
                mrId: null,
                qty: ex.qty, unit: ex.unit, unitName: ex.unitName, baseQty: ex.qty,
                refLink: '', description: ex.description || '',
                creatorName: ex.creatorName || currentUserDisplay,
                savedAt: ex.savedAt || formatNowDateTime()
            }];
        }

        // กันเพิ่มซ้ำ ถ้า mr_id นี้ถูกดึงมาแล้ว
        if (source.mrId && ex.sources.some(function(s){ return String(s.mrId) === String(source.mrId); })) return;

        ex.sources.push(source);
        ex.qty = (Number(ex.qty) || 0) + source.baseQty;
        if (!ex.description && itemBase.description) ex.description = itemBase.description;
    } else {
        prDetailCart.push({ ...itemBase, qty: source.baseQty, sources: [source] });
    }
}

// draft เก่าใน sessionStorage ที่ยังไม่มี sources ห่อเป็นโครงสร้างใหม่
function normalizeCartItem(item){
    const qty = Number(item.qty) || 0;
    if (!item.sources || item.sources.length === 0) {
        item.sources = [{
            mrId: item.mrId || null,
            qty: qty, unit: item.unit, unitName: item.unitName, baseQty: qty,
            refLink: item.refLink || '',
            description: item.description || '',
            creatorName: item.creatorName || currentUserDisplay,
            savedAt: item.savedAt || formatNowDateTime()
        }];
    }
    delete item.mrId; delete item.refLink; delete item.total;
    item.qty = qty;
    item.savedAt = item.savedAt || formatNowDateTime();
    return item;
}

function loadCartFromSession(){
    try {
        const saved = sessionStorage.getItem(PR_CART_STORAGE_KEY);
        if (saved) prDetailCart = JSON.parse(saved).map(normalizeCartItem);
    } catch (e) {
        console.error('ไม่สามารถโหลด cart จาก sessionStorage ได้', e);
        prDetailCart = [];
    }
}

function saveCartToSession(){
    try {
        sessionStorage.setItem(PR_CART_STORAGE_KEY, JSON.stringify(prDetailCart));
    } catch (e) {
        console.error('ไม่สามารถบันทึก cart ลง sessionStorage ได้', e);
    }
}

//กันข้อมูลหายตอน refresh
loadCartFromSession();

document.addEventListener('DOMContentLoaded', function(){
    renderPrDetailCart();
});

function validatePrDetailForm(){
    let errors = [];

    if (!$('#items_type').val() || !$('#items_type').val().trim()) errors.push('Category');
    if (!$('#product_name').val() || !$('#product_name').val().trim()) errors.push('Product Name');

    if (editingIndex === -1 || editAllowProductChange) {
        const qty = $('#pr_qty').val().trim();
        if (!qty || Number(qty) <= 0) errors.push('จำนวน');
        if (!$('#unit').val().trim()) errors.push('Unit');
    }

    return errors;
}

function getManualRefSourceIndex(item){
    const srcs = item.sources || [];
    let idx = srcs.findIndex(function(s){ return !s.mrId && s.refLink; });
    if (idx === -1) idx = srcs.findIndex(function(s){ return !s.mrId; });
    return idx;
}
function getManualRefSource(item){
    const idx = getManualRefSourceIndex(item);
    return idx >= 0 ? item.sources[idx] : null;
}

function addPrDetailToCart(){
    const errors = validatePrDetailForm();
    if (errors.length > 0) {
        Swal.fire({
            title: 'Please complete the form!',
            html: "Please fill in the following fields:<br><strong>" + errors.join(", ") + "</strong>",
            icon: "error",
            confirmButtonText: "OK",
        });
        return;
    }

    const description = $("#pr_description").val();
    const refLink = $("#pr_ref_link").val().trim();

    if (editingIndex >= 0 && editAllowProductChange) {
        prDetailCart.splice(editingIndex, 1);
        editingIndex = -1;
    }

    if (editingIndex >= 0) {
		// Edit
		const old = prDetailCart[editingIndex] || {};
		const updated = { ...old, description: description };

		const targetIdx = getManualRefSourceIndex(old);
		updated.sources = (old.sources || []).map(function(s, i){
			if (i !== targetIdx) return s;
			return { ...s, description: description, refLink: refLink };
		});

		prDetailCart[editingIndex] = updated;
		editingIndex = -1;
	} else {
        const rawQty = Number($("#pr_qty").val()) || 0;
        const rawUnitId = $("#unit").val();
        const rawUnitName = $("#unit option:selected").text();
        const conversionRate = Number($("#unit option:selected").data('conversion-rate')) || 1;
        const baseUnitId = $('#unit').data('base-unit-id') || rawUnitId;
        const baseUnitName = $('#unit').data('base-unit-name') || rawUnitName;
        const baseQty = rawQty * conversionRate;

        addSourceToCart({
            itemsType: $("#items_type").val(),
            itemsTypeText: $("#items_type option:selected").text(),
            productId: $("#product_name").val(),
            productName: $("#product_name option:selected").text(),
            unit: baseUnitId,
            unitName: baseUnitName,
           	description: description, 
            creatorName: currentUserDisplay,
            savedAt: formatNowDateTime()
        }, {
            mrId: null,
            qty: rawQty, unit: rawUnitId, unitName: rawUnitName,
            baseQty: baseQty,
            refLink: refLink,
			description: description, 
            creatorName: currentUserDisplay,
            savedAt: formatNowDateTime()
        });
    }

    saveCartToSession();
    renderPrDetailCart();

    if (document.activeElement) document.activeElement.blur();
    bootstrap.Modal.getOrCreateInstance(document.getElementById("modal_create_pr")).hide();
}

function renderPrDetailCart(){

    let html = "";

    prDetailCart.forEach(function(item,index){

        html += createPrCard(item,index);

    });

	if (prDetailCart.length === 0) {
        html = `
            <div class="d-flex flex-column align-items-center justify-content-center py-5 text-center">
                <i class="ki-duotone ki-file-deleted fs-2x text-muted mb-3">
                    <span class="path1"></span><span class="path2"></span>
                </i>
                <span class="fs-5 fw-medium text-muted">No items</span>
            </div>
        `;
    }

    $("#prDetailCartContainer").html(html);

}

//-------- PO- Detail -----------
function createPrCard(item,index){
    const safeQty = Number(item.qty) || 0;

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
	
	const descriptionHtml = item.description
        ? '<div class="d-flex align-items-center">'
            + '<i class="ki-duotone ki-document fs-2 text-muted me-2">'
                + '<span class="path1"></span><span class="path2"></span>'
            + '</i>'
            + '<span class="text-gray-900 fs-5 fw-normal">' + item.description + '</span>'
        + '</div>'
        : '';

	const manualSrc = (item.sources || []).find(function(s){
		return !s.mrId && s.refLink;
	});
	const headerRefLinkHtml = manualSrc ? `
		<a href="\${manualSrc.refLink}" target="_blank" rel="noopener" class="text-primary d-inline-flex ms-2" onclick="event.stopPropagation();" title="Ref Link">
			<i class="ki-duotone ki-fasten fs-2 text-primary"><span class="path1"></span><span class="path2"></span></i>
		</a>` : '';
		
    return `<div class="pr-item-group border-gray-400 border-bottom pt-9 pb-6 px-6">
    			<div class="d-flex align-items-center justify-content-between row g-3">
    				<div class="col-12 col-lg-7 d-flex flex-wrap align-items-center">\${icon}
						<span class="text-gray-900 fs-5 fw-normal me-3">\${category}</span>
						<span class="text-gray-900 fs-5 fw-normal me-3">\${item.productName}</span>
		
						\${descriptionHtml} \${headerRefLinkHtml}
					</div>
		
					<div class="col-5 col-lg-2 d-flex align-items-center justify-content-between px-0">
						<div class="col-12 d-flex flex-column text-start text-lg-end">
							<span class="fs-6 fw-normal text-gray-900">\${item.unitName}</span>
							<span class="fw-semibold text-gray-800 fs-5">\${item.qty}</span>
						</div>
					</div>
		
				<div class="col-7 col-lg-3 d-flex justify-content-end align-items-center gap-2 px-0">
	                <a href="#" onclick="return editCartItem(\${index});" class="btn btn-icon btn-light-primary btn-sm" title="Edit">
	                    <i class="ki-duotone ki-pencil fs-2"><span class="path1"></span><span class="path2"></span></i>
	                </a>
	                <a href="#" onclick="return removeCartItem(\${index});" class="btn btn-icon btn-light-danger btn-sm" title="Delete">
	                    <i class="ki-duotone ki-trash fs-2"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i>
	                </a>
	                <a class="collapsed pr-group-toggle" data-target="\${groupId}">
	                    <i class="ki-duotone ki-up-square fs-2hx">
	                        <span class="path1"></span><span class="path2"></span>
	                    </i>
	                </a>
            	</div>
			</div>
			
			<div class="collapse border-gray-300 border-top mt-3" id="prGroup_\${groupId}">
				<div class="ps-9 pt-9">
					\${(item.sources || []).map(function(s, si){
						var srcBaseQty = (s.baseQty != null) ? s.baseQty : s.qty;
						var rowRefLink = s.mrId ? s.refLink : '';
						return createPrSourceRow(s.qty, s.unitName || item.unitName, srcBaseQty, item.unitName,
												s.savedAt, s.mrId, rowRefLink, s.creatorName, index, si);
					}).join('')}
				</div>
			</div>
		
		</div>
		
		`;
}

function createMrBadge(mrId, refLink){
    const linkColor = mrId ? 'info' : 'primary';

    const link = refLink ? `
        <a href="\${refLink}" target="_blank" rel="noopener" class="text-\${linkColor} d-inline-flex ms-1" onclick="event.stopPropagation();">
            <i class="ki-duotone ki-fasten fs-2 text-\${linkColor}"><span class="path1"></span><span class="path2"></span></i>
        </a>` : '';

    if (!mrId) {
        return `
        <span class="d-inline-flex align-items-center flex-shrink-0">
            <span class="badge badge-lg fs-7 fw-semibold d-inline-block text-center badge-light-primary text-primary">-</span>\${link}
        </span>`;
    }

    return `
    <span class="d-inline-flex align-items-center flex-shrink-0">
        <a href="\${ctx}/equipment_request_mr_approve?mrId=\${mrId}" target="_blank" onclick="event.stopPropagation();"
           class="badge badge-lg fs-7 fw-semibold text-center text-decoration-none text-nowrap badge-light-info text-info">\${mrId}</a>\${link}
    </span>`;
}

function createPrSourceRow(qty, unitName, baseQty, baseUnitName, savedAt, mrId, refLink, creatorName, itemIndex, srcIndex){
    const qtyUnitDisplay = qty + ' ' + unitName + ' (= ' + baseQty + ' ' + baseUnitName + ')';

    return `
    <div class="pr-src-row row g-2 align-items-center mb-4 py-2">
        <div class="col-12 col-xl-9">
            <div class="row g-2 align-items-center fs-7">
                <div class="col-12 col-md-4">
                    <i class="ki-duotone ki-user-tick fs-3 text-muted me-2"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i>
                    <span class="text-gray-800 fs-5 fw-normal">\${creatorName || currentUserDisplay}</span>
                </div>
                <div class="col-12 col-md-4 d-flex align-items-center">
                    <i class="ki-duotone ki-calendar-2 fs-3 me-2"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i>
                    <span class="text-gray-800 fs-5 fw-normal">\${savedAt}</span>
                </div>
                <div class="col-12 col-md-4 d-flex align-items-center gap-2">
                    <i class="ki-duotone ki-tablet-book fs-3 flex-shrink-0"><span class="path1"></span><span class="path2"></span></i>
                    <div class="d-flex flex-wrap align-items-center gap-2">\${createMrBadge(mrId, refLink)}</div>
                </div>
            </div>
        </div>

        <div class="col-12 col-xl-3 d-flex align-items-center justify-content-between justify-content-xl-end gap-3">
            <span class="text-gray-800 fs-5 fw-normal">\${qtyUnitDisplay}</span>

            <div class="pr-src-menu position-relative d-inline-block flex-shrink-0">
                <a href="#" class="btn btn-icon btn-sm btn-light-primary w-30px h-30px"
                   onclick="return toggleSrcMenu(this, event);" aria-label="More actions" aria-haspopup="true">
                    <i class="ki-outline ki-dots-horizontal fs-2"></i>
                </a>

                <div class="pr-src-actions position-absolute end-0 top-100 mt-2 bg-body rounded-3 shadow z-index-3">
                    <div class="py-2">
                        <a href="#" class="pr-src-item d-block px-6 py-3 fs-6 fw-normal text-gray-800 bg-hover-light"
                           onclick="event.stopPropagation(); return editSource(\${itemIndex}, \${srcIndex});">Edit</a>
                        <a href="#" class="pr-src-item d-block px-6 py-3 fs-6 fw-normal text-gray-800 bg-hover-light"
                           onclick="event.stopPropagation(); return removeSource(\${itemIndex}, \${srcIndex});">Delete</a>
                    </div>
                </div>
            </div>
        </div>
    </div>`;
}

function editCartItem(index){
    const item = prDetailCart[index];
    if (!item) return false;

    editingIndex = index;


    const srcs = item.sources || [];
    editAllowProductChange = srcs.length <= 1 && !(srcs[0] && srcs[0].mrId);
    const prefillSrc = srcs[0] || null;
    const prefillUnit = prefillSrc ? prefillSrc.unit : item.unit;
    const prefillQty = prefillSrc ? prefillSrc.qty : item.qty;

    $('#modal_create_pr .modal-title').text('Edit PR - Detail');
    $('#btnSavePrDetail').text('Update');
    $('#items_type').prop('disabled', !editAllowProductChange);
    $('#product_name').prop('disabled', !editAllowProductChange);

    $('#items_type').val(item.itemsType).trigger('change');

    const waitForProductList = setInterval(function(){
        if ($('#product_name option[value="' + item.productId + '"]').length > 0) {
            $('#product_name').val(item.productId).trigger('change');
            clearInterval(waitForProductList);

			const waitForUnitList = setInterval(function(){
                if ($('#unit option[value="' + prefillUnit + '"]').length > 0) {
                    $('#unit').val(prefillUnit).trigger('change');
                    clearInterval(waitForUnitList);
                }
            }, 100);
            setTimeout(function(){ clearInterval(waitForUnitList); }, 3000);
        }
    }, 100);

    setTimeout(function(){ clearInterval(waitForProductList); }, 3000);

    $('#pr_qty').val(prefillQty);
    $('#unit').val(prefillUnit).trigger('change');
    $('#pr_description').val(item.description);
	const manualSrc = getManualRefSource(item);
	$('#pr_ref_link').val(manualSrc ? (manualSrc.refLink || '') : '');

    const modalEl = document.getElementById("modal_create_pr");
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
            const removedItem = prDetailCart[index];
            prDetailCart.splice(index, 1);
            saveCartToSession();
            renderPrDetailCart();
            uncheckMrCheckboxesForItem(removedItem);
        }
    });
    return false;
}

function closeAllSrcMenus(){
    document.querySelectorAll('.pr-src-menu.menu-open').forEach(function(m){ m.classList.remove('menu-open'); });
}
document.addEventListener('click', closeAllSrcMenus);

function toggleSrcMenu(btn, e){
    e.preventDefault(); e.stopPropagation();
    const menu = btn.closest('.pr-src-menu');
    const wasOpen = menu.classList.contains('menu-open');
    closeAllSrcMenus();
    if (!wasOpen) menu.classList.add('menu-open');
    return false;
}

function removeSource(itemIndex, srcIndex){
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

        const item = prDetailCart[itemIndex];
        const src = item && item.sources && item.sources[srcIndex];
        if (!src) return;

        const baseQty = Number(src.baseQty != null ? src.baseQty : src.qty) || 0;
        item.sources.splice(srcIndex, 1);

        if (item.sources.length === 0) {
            prDetailCart.splice(itemIndex, 1);
        } else {
            item.qty = Math.max(0, (Number(item.qty) || 0) - baseQty);
        }

        saveCartToSession();
        renderPrDetailCart();
        uncheckMrCheckboxesForItem({ sources: [src] });
    });
    return false;
}

let editingSrc = null;

function editSource(itemIndex, srcIndex){
    closeAllSrcMenus();
    const item = prDetailCart[itemIndex];
    const src = item && item.sources && item.sources[srcIndex];
    if (!src) return false;

	if (src.mrId) {
        openSearchMrWithKeyword(item.productName);
        return false;
    }

    editingSrc = { itemIndex: itemIndex, srcIndex: srcIndex };
    const baseQty = (src.baseQty != null) ? src.baseQty : src.qty;
	const cat = getCategoryIcon(mapSelectToDbItemsType(item.itemsType));
	$('#editSrcTypeIcon').html(cat.icon);
	$('#editSrcTypeName').text(cat.name);
    $('#editSrcProduct').text(item.productName);
    $('#editSrcCreator').text(src.creatorName || currentUserDisplay);
    $('#editSrcDate').text(src.savedAt);
    $('#editSrcMr').html(createMrBadge(src.mrId, src.refLink));
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
    const item = prDetailCart[editingSrc.itemIndex];
    if (!item) return;
    const qty = Number($('#edit_src_qty').val()) || 0;
    const rate = Number($('#edit_src_unit option:selected').data('conversion-rate')) || 1;
    $('#editSrcPreview').text('= ' + (Math.round(qty * rate * 1000) / 1000) + ' ' + item.unitName);
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
            icon: "error",
            confirmButtonText: "OK"
        });
        return;
    }

    const item = prDetailCart[editingSrc.itemIndex];
    const old = item.sources[editingSrc.srcIndex];
    const unitName = $('#edit_src_unit option:selected').text();
    const rate = Number($('#edit_src_unit option:selected').data('conversion-rate')) || 1;
    const baseQty = qty * rate;
    const oldBase = Number(old.baseQty != null ? old.baseQty : old.qty) || 0;

    item.sources[editingSrc.srcIndex] = { ...old, qty: qty, unit: unitId, unitName: unitName, baseQty: baseQty };
    item.qty = (Number(item.qty) || 0) + (baseQty - oldBase);   // ปรับยอดรวมของรายการหลัก

    saveCartToSession();
    renderPrDetailCart();

    if (document.activeElement) document.activeElement.blur();
    bootstrap.Modal.getOrCreateInstance(document.getElementById('modal_edit_source')).hide();
}

function parseFormattedNumber(str) {
    if (!str) return 0;
    return Number(String(str).replace(/,/g, ''));
}

//-------- Modal MR (Search MR) -----------
let inprogressMrDetailList = [];
let mrDetailTable = null;
let selectedMrCategory = '';
let mrSearchRequestToken = 0;
let isSearchMrModalOpen = false;
let pendingMrKeyword = null;

function openSearchMrWithKeyword(keyword){
    pendingMrKeyword = keyword;
    $('#searchMrKeyword').val(keyword);
    bootstrap.Modal.getOrCreateInstance(document.getElementById('modal_search_mr')).show();
}

$.fn.dataTable.ext.search.push(function (settings, data, dataIndex) {
    if (settings.nTable.id !== 'mrResultTable') return true;
    if (!selectedMrCategory) return true;

    var item = inprogressMrDetailList[dataIndex];
    if (!item) return true;

    return mapDbItemsTypeToSelect(item.product_type) === selectedMrCategory;
});

function loadInprogressMrDetail(){
    var requestToken = ++mrSearchRequestToken;
    $.ajax({
        url: ctx + '/search_approved_mr',
        type: 'POST',
        dataType: 'json',
        success: function (resp) {
            if (requestToken !== mrSearchRequestToken || !isSearchMrModalOpen) return;
            inprogressMrDetailList = (resp.data && resp.data.mrDetailList) || [];
            renderMrResultTable(inprogressMrDetailList);
        },
        error: function () {
            Swal.fire('Error', 'ไม่สามารถโหลดข้อมูล MR ได้', 'error');
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

function mapSelectToDbItemsType(val){
    switch(String(val)){
        case 'equipment':   return '1';
        case 'consumables': return '2';
        case 'accessory':   return '3';
        case 'office':      return '4';
        default:            return String(val);
    }
}

$(document.body).on('keyup input', '#searchMrKeyword', function () {
    if (mrDetailTable) {
        mrDetailTable.search(this.value).draw();
    }
});

$(document.body).on('change', '#searchMrCategory', function () {
    selectedMrCategory = $(this).val();
    if (mrDetailTable) {
        mrDetailTable.draw();
    }
});

function isMrDetailIdInCart(mrId){
    return prDetailCart.some(function(it){
        return (it.sources || []).some(function(s){ return String(s.mrId) === String(mrId); });
    });
}

function renderMrResultTable(list){
    var tbody = document.getElementById('mrResultBody');
    var html = '';

    list.forEach(function(item, index){
        var cat = getCategoryIcon(item.product_type);
        var qty = item.amount_total || 0;
        var unitName = item.unit_name || '';
        var userName = item.user_create_name || '-';
        var timeCreate = formatNowDateTime(item.time_create);
        var initial = userName.charAt(0).toUpperCase();
        var userPath = item.user_create_path || '';
        var statusBadge = item.mr_status == '3'
            ? '<span class="badge badge-lg bg-success fw-semibold fs-7 text-white">Approved</span>'
            : '';
		var fullProductName = item.parent_product_name
			? item.parent_product_name + ' > ' + (item.product_name || '')
			: (item.product_name || '');

        html += `
        <tr class="fw-semibold fs-6 text-gray-800 border-bottom border-gray-200">
            <td>
                <div class="form-check form-check-sm">
                    <input class="form-check-input mr-row-check" type="checkbox"
                        data-mr-detail-id="\${item.mr_id}"\${isMrDetailIdInCart(item.mr_id) ? ' checked' : ''} />
                </div>
            </td>
            <td class="fw-bold text-gray-900 fs-7 row-number text-start d-none d-md-table-cell"></td>
            <td class="text-gray-900 fs-6 fw-normal">\${item.mr_id}</td>
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
                    <span class="text-gray-900 fs-6 fw-normal">\${fullProductName}</span>

                    <span class="text-gray-900 fs-6 fw-normal">\${qty} \${unitName}</span>
                </div>
            </td>
            <td class="text-end pe-2 d-none d-md-table-cell">
                \${statusBadge}
            </td>
        </tr>`;
    });
    tbody.innerHTML = html;

    if (mrDetailTable) {
        mrDetailTable.destroy();
        mrDetailTable = null;
    }
    mrDetailTable = $('#mrResultTable').DataTable({
		ordering : false,
		searching : true,
		autoWidth : false,
		info: false,
		paging: false,
		drawCallback: function () {
			var api = this.api();
			var $rows = $(api.rows({ search: 'applied', order: 'applied' }).nodes());

			$rows.each(function (i) {
				$(this).find('.row-number').text(i + 1);
			});

			document.getElementById('mrItemsFoundCount').textContent = $rows.length;
		}
	});
    updateMrSelectedCountReal();

    if (pendingMrKeyword !== null) {
        $('#searchMrKeyword').val(pendingMrKeyword);
        mrDetailTable.search(pendingMrKeyword).draw();
        pendingMrKeyword = null;
    }

    var checkAll = document.getElementById('checkAllMr');

    function syncCheckAllState(){
        var allBoxes = document.querySelectorAll('.mr-row-check');
        checkAll.checked = allBoxes.length > 0 && Array.prototype.every.call(allBoxes, function (box) { return box.checked; });
    }

    document.querySelectorAll('.mr-row-check').forEach(function (cb) {
        cb.addEventListener('change', function () {
            updateMrSelectedCountReal();
            syncCheckAllState();
        });
    });

    checkAll.checked = list.length > 0 && list.every(function (d) { return isMrDetailIdInCart(d.mr_id); });
    checkAll.onchange = function(){
        document.querySelectorAll('.mr-row-check').forEach(cb => cb.checked = this.checked);
        updateMrSelectedCountReal();
    };
}

function updateMrSelectedCountReal(){
    var count = document.querySelectorAll('.mr-row-check:checked').length;
    document.getElementById('mrSelectedCount').textContent = count;
}

function uncheckMrCheckboxesForItem(item){
    if (!item || !item.sources) return;
    item.sources.forEach(function(s){
        if (!s.mrId) return;
        var cb = document.querySelector('.mr-row-check[data-mr-detail-id="' + s.mrId + '"]');
        if (cb) cb.checked = false;
    });
    updateMrSelectedCountReal();

    var checkAll = document.getElementById('checkAllMr');
    if (checkAll) {
        var allBoxes = document.querySelectorAll('.mr-row-check');
        checkAll.checked = allBoxes.length > 0 &&
            Array.prototype.every.call(allBoxes, function (box) { return box.checked; });
    }
}

document.getElementById('btnSubmitMr').addEventListener('click', function(){
    var selectedIds = [];
    document.querySelectorAll('.mr-row-check:checked').forEach(function(cb){
        selectedIds.push(cb.getAttribute('data-mr-detail-id'));
    });
    var selectedIdSet = {};
    selectedIds.forEach(function(id){ selectedIdSet[String(id)] = true; });

    //เอา source ของ MR ที่ติ๊กออกแล้วออกจาก cart
    inprogressMrDetailList.forEach(function(d){
        var mrId = String(d.mr_id);
        if (selectedIdSet[mrId]) return;

        for (var i = prDetailCart.length - 1; i >= 0; i--) {
            var cartItem = prDetailCart[i];
            if (!cartItem.sources) continue;

            var srcIdx = cartItem.sources.findIndex(function(s){ return String(s.mrId) === mrId; });
            if (srcIdx === -1) continue;

            var removedSrc = cartItem.sources[srcIdx];
            var removedBaseQty = Number(removedSrc.baseQty != null ? removedSrc.baseQty : removedSrc.qty) || 0;
            cartItem.sources.splice(srcIdx, 1);

            if (cartItem.sources.length === 0) {
                prDetailCart.splice(i, 1);
            } else {
                cartItem.qty = Math.max(0, (Number(cartItem.qty) || 0) - removedBaseQty);
            }
        }
    });

    //เพิ่มรายการที่ติ๊กใหม่ (productId เดียวกันจะ group เข้า item เดิม, mr_id ซ้ำจะถูกข้าม)
    selectedIds.forEach(function(mrId){
        var src = inprogressMrDetailList.find(function(d){ return String(d.mr_id) === String(mrId); });
        if (!src) return;
 	
        var qty = Number(src.amount_total) || 0;
        var creator = (src.user_create_emp_id ? src.user_create_emp_id + ' - ' : '') + (src.user_create_name || '');
        var savedAt = formatNowDateTime();
		var cartProductName = src.parent_product_name
			? src.parent_product_name + ' > ' + (src.product_name || '')
			: (src.product_name || '');

		addSourceToCart({
			itemsType: mapDbItemsTypeToSelect(src.product_type),
			itemsTypeText: getCategoryIcon(src.product_type).name,
			productId: src.product_id,
    		productName: cartProductName,
			unit: src.unit,
			unitName: src.unit_name || '',
			description: '',
			creatorName: creator,
			savedAt: savedAt
        }, {
            mrId: src.mr_id,
            qty: qty, unit: src.unit, unitName: src.unit_name || '',
            baseQty: qty, // MR เก็บเป็นหน่วยเล็กสุดอยู่แล้ว
            refLink: src.ref_link || '',
            description: src.description || '',
            creatorName: creator,
            savedAt: savedAt
        });
    });

    saveCartToSession();
    renderPrDetailCart();

    if (document.activeElement) document.activeElement.blur();
    var modal = bootstrap.Modal.getInstance(document.getElementById('modal_search_mr'));
    if (modal) modal.hide();
});

//────────────────── Confirm Receiver ──────────────────
function confirmReceiver(slot) {
    const now = new Date();
    const pad = n => String(n).padStart(2, '0');
    const months = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];

    //ส่ง backend
    const timestamp =
        now.getFullYear() + "-" +
        pad(now.getMonth()+1) + "-" +
        pad(now.getDate()) + " " +
        pad(now.getHours()) + ":" +
        pad(now.getMinutes()) + ":" +
        pad(now.getSeconds());

    //แสดงผล
    const displayTimestamp = now.getDate() + " " + months[now.getMonth()] + " " + now.getFullYear() +
        " , " + pad(now.getHours()) + ":" + pad(now.getMinutes());

    requesterSign = {
        userId: "${loginUser.employeeId}",
        userName: currentUserDisplay,
        requestAt: timestamp
    };

    sessionStorage.setItem("prRequesterSign", JSON.stringify(requesterSign));

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
        description: $('#description').val().trim() || '',
        prDetailCartJson: JSON.stringify(prDetailCart),
        signDate: requesterSign?.requestAt ?? '',
    };

    const fd = new FormData();
    Object.keys(payload).forEach(function (k) { fd.append(k, payload[k]); });
    selectedFiles.forEach(function (file) { fd.append('files', file, file.name); });

    $.ajax({
        url: ctx + '/save_pr',
        type: 'POST',
        dataType: 'json',
        data: fd,
        processData: false,
        contentType: false,
        success: function (resp) {
            // if (resp.debug) console.log('[save_pr debug]', resp.debug);
            if (resp.data && resp.data.prId) {
                sessionStorage.removeItem(PR_CART_STORAGE_KEY);
                sessionStorage.removeItem(PR_HEADER_STORAGE_KEY);
                Swal.fire({
                    title: 'Success!',
                    text: 'Pr saved draft successfully!',
                    icon: 'success'
                }).then(() => {
                    window.location.href = ctx + '/purchase_requisition_list';
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

function validatePRForm(){
    let errors = [];
    if (!$('#description').val().trim()) errors.push('Description');
    if (!prDetailCart || prDetailCart.length === 0) errors.push('Please add at least 1 Pr Detail');
    
    const hasSignature = $('#hasSignature').val() === 'true';
    if (!hasSignature) errors.push('ลายเซ็น (Signature)');

    if (!confirmed1) errors.push('ลงชื่อ ผู้ขอเบิก');
    
    return errors;
}

function submitPR(){
    const errors = validatePRForm();

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
            description: $('#description').val().trim() || '',
            prDetailCartJson: JSON.stringify(prDetailCart),
            status: '2',
            signDate: requesterSign?.requestAt ?? ''
        };

        const fd = new FormData();
        Object.keys(payload).forEach(function (k) { fd.append(k, payload[k]); });
        selectedFiles.forEach(function (file) { fd.append('files', file, file.name); });

        $('#savePRFormBtn').prop('disabled', true);

        $.ajax({
            url: ctx + '/save_pr',
            type: 'POST',
            dataType: 'json',
            data: fd,
            processData: false,
            contentType: false,
            success: function (resp) {
                // if (resp.debug) console.log('[save_pr debug]', resp.debug);
                if (resp.data && resp.data.prId) {
                    sessionStorage.removeItem(PR_CART_STORAGE_KEY);
                    sessionStorage.removeItem(PR_HEADER_STORAGE_KEY);
                    Swal.fire({
                        title: 'Success!',
                        text: 'Pr saved successfully!',
                        icon: 'success'
                    }).then(() => {
                        window.location.href = ctx + '/purchase_requisition_list';
                    });
                } else {
                    Swal.fire('Error', 'ไม่สามารถส่ง PR ได้', 'error');
                }
            },
            error: function () {
                Swal.fire('Error', 'เกิดข้อผิดพลาดในการส่งข้อมูล', 'error');
            },
            complete: function(){
                $('#savePRFormBtn').prop('disabled', false);
            }
        });
    });
}

</script>
</html>