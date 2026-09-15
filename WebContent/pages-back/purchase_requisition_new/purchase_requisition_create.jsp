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
						<div class="col-md-12 col-lg-7 col-xl-7 col-xxl-8 mb-md-5">
							<div class="card h-100">
								<div class="card-header border-0 px-9 pt-7 d-flex align-items-center justify-content-between">
									<div class="card-title">
										<h3 class="fw-semibold text-gray-900">PR - Header</h3>
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
									<label class="required fw-medium text-gray-800 mb-2">Description</label>
									<textarea class="form-control text-gray-700" id="description" name="description"
										placeholder="Description" rows="3"></textarea>
								</div>
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
											accept="image/*,application/pdf,application/zip,application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document">
									</label>
								</div>
								<div class="card-body filter-card px-10 py-9 rounded-3">
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
										<div id="attachFileList" class="d-flex flex-column gap-2 mt-2"></div>
										<div id="errorMsgAF" class="text-danger fs-8 mt-1"></div>
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="card mb-10">
						<div class="card-header border-0 px-9 pt-7 d-flex align-items-center justify-content-between">
					        <div class="card-title">
					            <h3 class="fw-semibold text-gray-900">PR - Detail</h3>
					        </div>
					        <div class="card-title gap-3">
						         <button type="button" id="btnOpenCreatePr" class="btn btn-lg btn-success fw-medium text-white px-6 py-4">
									<i class="ki-outline ki-plus fs-3 me-1"></i>Create
								</button>
								
								<button type="button" class="btn btn-lg btn-primary fw-medium text-white px-6 py-4" data-bs-toggle="modal" data-bs-target="#modal_search_mr">
									<i class="ki-duotone ki-magnifier fs-3 me-1">
						                <span class="path1"></span><span class="path2"></span></i>Search MR
								</button>
					            
					        </div>
					    </div>
						<div class="card-body filter-card px-9 py-8 rounded-3">
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
					
					
					<div class="modal fade" tabindex="-1" id="modal_create_pr">
						<div class="modal-dialog modal-lg">
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
									
									<div class="row g-5 mb-6">
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
										<div class="col-6 d-flex flex-column">
											<label class="required fw-medium text-gray-800 mb-2">Description / Detail</label>
											<textarea class="form-control text-gray-700" rows="3" name="description" id="pr_description" placeholder="Description"></textarea>
										</div>

										<div class="col-lg-6 col-md-6 col-12 d-flex flex-column">
											<label class="fw-medium text-gray-800 mb-2">Ref Link</label>
											<input type="text" class="form-control text-gray-700 h-45px"
													name="pr_ref_link" id="pr_ref_link" placeholder="https://..." />
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
					                        <label class="required fw-medium text-gray-800 mb-2">Search MR</label>
					                        <div class="input-group">
					                            <input type="text" class="form-control text-gray-700 h-45px"
					                                    name="" id="" />
					                            
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
					                                        <td class="fw-normal text-gray-900 fs-5">MR001</td>
					                                        <td>
					                                        	<div class="d-flex align-items-center">
							                                        <div class="symbol symbol-40px me-4">
														                 <i class="ki-duotone ki-monitor-mobile fs-2 text-primary">
														                     <span class="path1"></span><span class="path2"></span></i>
														            </div>
							                                        <span class="fw-normal text-gray-900 fs-5">Equipment</span>
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
															            <span class="fw-normal text-gray-900 fs-6">Kridsada Ninpetch</span>
															            <span class="fw-normal text-gray-900 fs-6">1 Jan 2026, 12:33</span>
															        </div>
															        
															    </div>
															</td>
					                                        <td>
					                                        	<div class="d-flex flex-column">
															        <span class="fw-normal text-gray-900 fs-6">Lenovo LOQ 15IAXB</span>
															        <span class="fw-normal text-gray-900 fs-6">1 เครื่อง</span>
															 	</div>
															</td>
					                                        <td class="text-end">
					                                        <c:choose>
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
																</c:otherwise>
															</c:choose>
															
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
					                                        <td class="fw-normal text-gray-900 fs-5">MR002</td>
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
							                                        <span class="fw-normal text-gray-900 fs-5">Consumables</span>
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
															            <span class="fw-normal text-gray-900 fs-6">Kridsada Ninpetch</span>
															            <span class="fw-normal text-gray-900 fs-6">1 Jan 2026, 12:33</span>
															        </div>
															        
															    </div>
															</td>
					                                        <td>
					                                        	<div class="d-flex flex-column">
															        <span class="fw-normal text-gray-900 fs-6">A4</span>
															        <span class="fw-normal text-gray-900 fs-6">1 รีม</span>
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
					                                        <td class="fw-normal text-gray-900 fs-7 row-number"></td>
					                                        <td class="fw-normal text-gray-900 fs-5">MR003</td>
					                                        <td>
					                                        	<div class="d-flex align-items-center">
							                                        <div class="symbol symbol-40px me-4">
														                 <i class="ki-duotone ki-keyboard fs-2 text-dark">
														                     <span class="path1"></span><span class="path2"></span></i>
														            </div>
							                                        <span class="fw-normal text-gray-900 fs-5">Instrument</span>
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
															            <span class="fw-normal text-gray-900 fs-6">Kridsada Ninpetch</span>
															            <span class="fw-normal text-gray-900 fs-6">1 Jan 2026, 12:33</span>
															        </div>
															        
															    </div>
															</td>
					                                        <td>
					                                        	<div class="d-flex flex-column">
															        <span class="fw-normal text-gray-900 fs-6">ต้นคริสมาส</span>
															        <span class="fw-normal text-gray-900 fs-6">1 ต้น</span>
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
								onclick="location.href='purchase_requisition_list'"
								class="btn btn-lg btn-light fw-medium text-light-inverse px-6 py-4 me-4 border">Back
							</button>
						</div>
						<div class="d-flex">
							
							<button type="button" id="saveDraft" onclick="saveDraftForm()"
								class="btn btn-lg btn-cyan text-white fw-medium px-6 py-4 me-4">Save Draft
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

	function formatNowDateTime(){
	    const d = new Date();
	    const months = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
	    const pad = n => String(n).padStart(2,'0');
	    return `\${d.getDate()} \${months[d.getMonth()]} \${d.getFullYear()}, \${pad(d.getHours())}:\${pad(d.getMinutes())}`;

	}

	// --- PO Header/Vendor draft (sessionStorage) ---
	var prHeaderDraft = null;      // ค่าที่โหลดจาก session ตอน init

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
		
		//running number
		function runNumber() {
			const info = table.page.info();
			table.column(1, {
				page : 'current'
					}).nodes().each(function(cell, i) {
						cell.innerHTML = info.start + i + 1;
						});
			}
		
		table.on('draw.dt order.dt search.dt', runNumber);
		runNumber();
		
		
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
		    // MR
		    // document.querySelectorAll('a.btn-primary[href="#"]').forEach(function (btn) {
		    //     if (btn.textContent.trim().includes('Search MR')) {
		    //         btn.setAttribute('data-bs-toggle', 'modal');
		    //         btn.setAttribute('data-bs-target', '#modal_search_mr');
		    //     }
		    // });

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
		    
		    /* $('#modal_create_pr').on('shown.bs.modal', function () {
		        $('#items_type').val('equipment').trigger('change');
		    });
		     */
		    
		    
		   /*  const createPrModalEl = document.getElementById('modal_create_pr');
		    const createPrModal = bootstrap.Modal.getOrCreateInstance(createPrModalEl);

		    createPrModalEl.addEventListener('hidden.bs.modal', function () {
		        $('#items_type').val('equipment').trigger('change');
		        $('#pr_qty').val('');
		        $('#unit').val('');
		        $('#pr_price').val('');
		        $('#pr_description').val('');
		        
		        editingIndex = -1;
		        $('#modal_create_pr .modal-title').text('Create PR - Detail');
		        $('#btnSavePrDetail').text('Save');

		        if (!document.querySelector('.modal.show')) {
		            document.body.classList.remove('modal-open');
		            document.body.style.removeProperty('overflow');
		            document.body.style.removeProperty('padding-right');
		            document.querySelectorAll('.modal-backdrop').forEach(el => el.remove());
		        }
		    }); */
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
		        }
		    });

		    createPrModalEl.addEventListener('shown.bs.modal', function () {
		        document.body.classList.add('modal-open');
		        document.body.style.overflow = 'hidden';
		        document.documentElement.style.overflow = 'hidden';
		    });

		    createPrModalEl.addEventListener('hidden.bs.modal', function () {
		        editingIndex = -1;
		        document.querySelectorAll('.modal-backdrop').forEach(el => el.remove());
		        document.body.classList.remove('modal-open');
		        document.body.style.removeProperty('padding-right');
		        document.body.style.removeProperty('overflow');
		        document.documentElement.style.removeProperty('overflow');
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

	// auto-save PR Header draft ทุกครั้งที่ field เปลี่ยน
	$(document.body).on('input change', '#description', saveHeaderToSession);

</script>

<script>
let prDetailCart = [];
let prDetailCounter = 0;
let editingIndex = -1;
let confirmed1 = ${empty statusActiveSafe ? 'false' : 'true'}; //track ว่าลงชื่อ ผู้ขอเบิก แล้วหรือยัง

let requesterSign = null;

const PR_HEADER_STORAGE_KEY = 'prHeader_draft';
const PR_CART_STORAGE_KEY = 'prDetailCart_draft';

function saveCartToSession(){
    try {
        sessionStorage.setItem(PR_CART_STORAGE_KEY, JSON.stringify(prDetailCart));
    } catch (e) {
        console.error('ไม่สามารถบันทึก cart ลง sessionStorage ได้', e);
    }
}

function loadCartFromSession(){
    try {
        const saved = sessionStorage.getItem(PR_CART_STORAGE_KEY);
        if (saved) {
            prDetailCart = JSON.parse(saved);
            
            prDetailCart = prDetailCart.map(item => ({
                ...item,
                qty: Number(item.qty) || 0,
                refLink: item.refLink || '',
                total: 0,
                savedAt: item.savedAt || formatNowDateTime()
            }));
        }
    } catch (e) {
        console.error('ไม่สามารถโหลด cart จาก sessionStorage ได้', e);
        prDetailCart = [];
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

    const qty = $('#pr_qty').val().trim();
    if (!qty || Number(qty) <= 0) errors.push('จำนวน');

    if (!$('#unit').val().trim()) errors.push('Unit');

    if (!$('#pr_description').val().trim()) errors.push('Description / Detail');

    return errors;
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

    const item = {
        itemsType: $("#items_type").val(),
        itemsTypeText: $("#items_type option:selected").text(),
        productId: $("#product_name").val(),
        productName: $("#product_name option:selected").text(),
        qty: Number($("#pr_qty").val()),
        unit: $("#unit").val(),
        unitName: $("#unit option:selected").text(),
        refLink: $("#pr_ref_link").val().trim(),
        description: $("#pr_description").val(),
        savedAt: formatNowDateTime()
    };

    item.total = 0;

    if (editingIndex >= 0) {
        prDetailCart[editingIndex] = item;
        editingIndex = -1;
    } else {
        prDetailCart.push(item);
    }

    // console.log(item);
    // console.log(prDetailCart);
    
    saveCartToSession();
    renderPrDetailCart();
    
    if (document.activeElement) {
        document.activeElement.blur();
    }

    const modalEl = document.getElementById("modal_create_pr");
    const modal = bootstrap.Modal.getOrCreateInstance(modalEl);
    modal.hide();
}

/* function addPrDetailToCart(){
    const item = {
        itemsType: $("#items_type").val(),
        itemsTypeText: $("#items_type option:selected").text(),
        productId: $("#product_name").val(),
        productName: $("#product_name option:selected").text(),
        qty: Number($("#pr_qty").val()),
        unit: $("#unit").val(),
        price: parseFormattedNumber($("#pr_price").val()),
        description: $("#pr_description").val(),
        savedAt: formatNowDateTime()
    };

    item.total = item.qty * item.price;

    if (editingIndex >= 0) {
        prDetailCart[editingIndex] = item;
        editingIndex = -1; 
    } else {
        prDetailCart.push(item);
    }

    saveCartToSession(); 
    renderPrDetailCart();

    renderPrDetailCart();

    const modalEl = document.getElementById("modal_create_pr");
    const modal = bootstrap.Modal.getOrCreateInstance(modalEl);
    modal.hide();
} */

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

    return `<div class="pr-item-group border-gray-400 border-bottom py-9 px-6">
    			<div class="d-flex align-items-center justify-content-between row">
    				<div class="col-7 d-flex align-items-center">\${icon}
						<span class="text-gray-900 fs-5 fw-normal me-3">\${category}</span>
						<span class="text-gray-900 fs-5 fw-normal me-3">\${item.productName}</span>
		
						<div class="d-flex align-items-center">
							<i class="ki-duotone ki-document fs-2 text-muted me-2">
								<span class="path1"></span>
								<span class="path2"></span>
							</i>
		
							<span class="text-gray-900 fs-5 fw-normal me-3">\${item.description}</span>

						</div>
					</div>
		
					<div class="col-1 d-flex align-items-center justify-content-between px-0">
						<div class="col-12 d-flex flex-column text-end">
							<span class="fs-6 fw-normal text-gray-900">\${item.unitName}</span>
							<span class="fw-semibold text-gray-800 fs-5">\${item.qty}</span>
						</div>
					</div>
		
				<div class="col-2 d-flex justify-content-end align-items-center gap-2 px-0">
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
	                <div class="d-flex align-items-center justify-content-between row">
	                    <div class="col-11">
	                        <div class="d-flex align-items-center fs-7 gap-3">
	                            <div class="col-4">
	                                <i class="ki-duotone ki-user-tick fs-3 text-muted me-2">
	                                    <span class="path1"></span><span class="path2"></span><span class="path3"></span>
	                                </i>
	                                <span class="text-gray-800 fs-5">\${currentUserDisplay}</span>
	                            </div>
	                            <div class="col-5 d-flex align-items-center">
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
									<span class="badge badge-lg badge-light-primary text-primary fs-7 fw-semibold d-inline-block text-center me-3">-</span>
									\${item.refLink 
										? `<a href="\${item.refLink}" target="_blank" class="my-0 d-flex align-items-center">
											<i class="ki-duotone ki-fasten fs-2 me-2 text-primary">
					                     		<span class="path1"></span><span class="path2"></span>
											</i>
											</a>`
										: ''
									}
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
    const item = prDetailCart[index];
    if (!item) return false;

    editingIndex = index;

    $('#modal_create_pr .modal-title').text('Edit PR - Detail');
    $('#btnSavePrDetail').text('Update');

    $('#items_type').val(item.itemsType).trigger('change');

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

    $('#pr_qty').val(item.qty);
    $('#unit').val(item.unit);
    $('#pr_ref_link').val(item.refLink || '');
    $('#pr_description').val(item.description);

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
            prDetailCart.splice(index, 1);
            saveCartToSession();    
            renderPrDetailCart();
        }
    });
    return false;
}

function parseFormattedNumber(str) {
    if (!str) return 0;
    return Number(String(str).replace(/,/g, ''));
}

//── Confirm Receiver ──────────────────────────────────────
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
   /*  if (!prDetailCart || prDetailCart.length === 0) {
        Swal.fire('error', 'กรุณาเพิ่มรายการ PO อย่างน้อย 1 รายการ', 'warning');
        return;
    }
 */
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