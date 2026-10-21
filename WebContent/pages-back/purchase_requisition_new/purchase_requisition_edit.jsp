<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/permission.tld" prefix="perm"%>
<% pageContext.setAttribute("nl", "\n"); pageContext.setAttribute("cr", "\r"); %>
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
    max-height: 300px;
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

/* ===== Responsive: sticky action bar (mobile) ===== */
@media (max-width: 767.98px) {
	.pr-src-actions {
		max-width: calc(100vw - 32px);
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
							Edit PR - Purchase Requisition
						</h1>
						<ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
							<li class="breadcrumb-item text-muted"><a class="text-muted text-hover-primary">Home</a></li>
							<li class="breadcrumb-item"><span class="bullet bg-gray-500 w-5px h-2px"></span></li>
							<li class="breadcrumb-item text-muted"><a class="text-muted text-hover-primary">Product</a></li>
						</ul>
					</div>
		
					<div class="d-flex align-items-center gap-2">
						<span class="fs-1 fs-md-2hx text-primary fw-bold" id="">#${prList.prId}</span>
						<span class="badge badge-lg bg-${prStatusColors[prList.status]} fw-semibold fs-7 p-4
									${prStatusColors[prList.status] == 'secondary' ? 'text-dark' : 'text-white'}">
							${prStatusNames[prList.status]}
						</span>
					</div>
			
				</div>
			</div>
			
			<div id="kt_app_content" class="app-content flex-column-fluid">
				<div id="kt_app_content_container" class="app-container container-fluid">
					<div class="row g-5 gx-xl-10">
						<div class="col-md-12 col-lg-7 col-xl-7 col-xxl-8 mb-10">
							<div class="card h-100">
								<div class="card-header border-0 px-9 pt-7 d-flex align-items-center justify-content-between">
									<div class="card-title">
										<h3 class="fw-semibold text-gray-900">PR - Header</h3>
									</div>
								</div>
								<div class="card-body filter-card px-5 px-lg-10 py-9 rounded-3">
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
											<span class="fs-6 fw-medium text-gray-800"><fmt:formatDate value="${prList.timeCreate}" pattern="d MMM yyyy, HH:mm" /></span>
										</div>

										<c:choose>
											<c:when test="${prList.status == '1'}">
												<div class="col-12 mt-9">
													<label class="required fw-medium text-gray-800 mb-5">Description</label>
													<textarea class="form-control text-gray-700" id="description" name="description"
														placeholder="Description" rows="3">${prList.description}</textarea>
												</div>
											</c:when>
											<c:otherwise>
												<div class="col-12 mt-9 d-flex align-items-center">
													<i class="ki-duotone ki-document fs-3 me-3">
														<span class="path1"></span><span class="path2"></span>
													</i>
													<span class="fs-6 fw-medium text-gray-800">${empty prList.description ? '-' : prList.description}</span>
												</div>
											</c:otherwise>
										</c:choose>
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
									<c:if test="${prList.status == '1'}">
										<label for="myFile" id="lbFile" class="btn btn-lg btn-primary d-inline-flex align-items-center justify-content-center fw-medium h-40px my-0">
											Upload
											<input type="file" id="myFile" name="files" multiple style="display:none;"
												accept="image/*,application/pdf,application/zip,application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document">
										</label>
									</c:if>
								</div>
								<div class="card-body filter-card px-5 px-lg-10 py-9 rounded-3">
									<c:if test="${prList.status == '1'}">
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
									<c:if test="${prList.status != '1' and empty attachmentList}">
										<div class="d-flex flex-column align-items-center justify-content-center text-center">
											<i class="ki-duotone ki-file-deleted fs-2x text-muted mb-3">
												<span class="path1"></span><span class="path2"></span>
											</i>
											<span class="fs-5 fw-medium text-muted">No files</span>
										</div>
									</c:if>

									<div class="d-flex flex-column h-100" style="min-height:0;">
										<div id="attachFileList" class="d-flex flex-column gap-5">
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
														<c:if test="${prList.status == '1'}">
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
					
					<div class="card mb-10">
						<div class="card-header border-0 px-9 pt-7 d-flex flex-wrap align-items-center justify-content-between gap-3">
					        <div class="card-title">
					            <h3 class="fw-semibold text-gray-900">PR - Detail</h3>
					        </div>
							<c:if test="${prList.status == '1'}">
								<div class="card-title flex-wrap gap-3">
									<button type="button" id="btnOpenCreatePr" class="btn btn-lg btn-success fw-medium text-white px-6 py-4" >
										<i class="ki-outline ki-plus fs-3 me-1"></i>Create
									</button>
									
									<button type="button" id="btnOpenSearchMr" class="btn btn-lg btn-primary fw-medium text-white px-6 py-4">
										<i class="ki-duotone ki-magnifier fs-3 me-1">
											<span class="path1"></span><span class="path2"></span></i>Search MR
									</button>
								</div>
							</c:if>

							<c:if test="${prList.status == '7'}">
								<h2 class="fw-bold text-primary">
									 In-Progress : <span id="prInProgressCount">0</span>/<span id="prInProgressTotal">0</span>
								</h2>
							</c:if>
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
								<!-- Draft status -->
								<c:if test="${prList.status == '1'}">
									<div class="col-12 col-md-6">
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

												<c:when test="${prList.status == '1'}">
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

									<div class="col-12 col-md-6">
										<div class="border ${empty prList.signDate ? 'border-gray-300' : 'border-success bg-light-success'} rounded-3 h-100 d-flex flex-column align-items-center justify-content-center text-center py-8" id="receiverCard1">
											<div class="receiver-box d-flex flex-fill flex-column align-items-center justify-content-center gap-2" id="receiverBox1">
												<c:choose>
													<c:when test="${empty prList.signDate}">
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
																	<fmt:formatDate value="${prList.signDate}" pattern="d MMM yyyy , H:mm" />
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
								<c:if test="${prList.status == '3' or prList.status == '7'}">
									<c:if test="${not empty prList.signDate}">
										<div class="col-12 col-md-6 p-5 p-md-16 m-0">
											<div class="d-flex flex-column align-items-center gap-3">
												<c:if test="${not empty imgPathSignature}">
													<img src="${pageContext.request.contextPath}${imgPathSignature}"
														style="max-height: 150px; max-width: 360px; object-fit: contain;" />
												</c:if>
												<span class="text-primary pt-3 fs-4 fw-medium">ชื่อ ผู้ขอเบิก</span>
												<div class="d-flex flex-column align-items-center">
													<span class="text-gray-900 fw-medium fs-5 pb-2">${empty userSignUser.nameEN ? userSignUser.name : userSignUser.nameEN}</span>
													<span class="text-gray-900 fw-medium fs-6">
														<fmt:formatDate value="${prList.signDate}" pattern="d MMM yyyy , H:mm" />
													</span>
												</div>
											</div>
										</div>
									</c:if>
									
									<c:if test="${not empty prList.approveDate}">
										<div class="col-12 col-md-6 p-5 p-md-16 m-0">
											<div class="d-flex flex-column align-items-center gap-3">
												<c:if test="${not empty imgPathApproveSignature}">
													<img src="${pageContext.request.contextPath}${imgPathApproveSignature}"
														style="max-height: 150px; max-width: 360px; object-fit: contain;" />
												</c:if>
											
												<span class="text-primary pt-3 fs-4 fw-medium">ชื่อ ผู้อนุมัติ</span>
												<div class="d-flex flex-column align-items-center">
													<span class="text-gray-900 fw-medium fs-5 pb-2">${empty userApproveUser.nameEN ? userApproveUser.name : userApproveUser.nameEN}</span>
													<span class="text-gray-900 fw-medium fs-6">
														<fmt:formatDate value="${prList.approveDate}" pattern="d MMM yyyy , H:mm" />
													</span>

													<c:if test="${not empty prList.reason}">
														<span class="d-flex align-items-center mt-3">
															<i class="ki-duotone ki-document fs-2 fw-normal text-muted me-2">
																<span class="path1"></span>
																<span class="path2"></span>
															</i>
															<span class="fs-5 fw-normal text-gray-900">${prList.reason}</span>
														</span>
													</c:if>
												</div>
											</div>
										</div>
									</c:if>
								</c:if>

								<!-- Pending status -->
								<c:if test="${prList.status == '2' or prList.status == '4' or prList.status == '5' or prList.status == '6'}">
									<div class="col-12 col-md-6">
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

									<div class="col-12 col-md-6">
										<div class="border ${empty prList.signDate ? 'border-gray-300' : 'border-success bg-light-success'} rounded-3 h-100 d-flex flex-column align-items-center justify-content-center text-center py-8">
											<div class="d-flex flex-fill flex-column align-items-center justify-content-center gap-2">
												<c:choose>
													<c:when test="${empty prList.signDate}">
														<span class="text-muted fs-7">ยังไม่มีการลงชื่อ ผู้ขอเบิก</span>
													</c:when>
													<c:otherwise>
														<span class="text-primary pb-2 fs-7 fw-semibold">ชื่อ ผู้ขอเบิก</span>
														<div class="d-flex flex-column align-items-center">
															<span class="text-dark fw-semibold fs-7">${empty userSignUser.nameEN ? userSignUser.name : userSignUser.nameEN}</span>
															<span class="text-muted fs-8">
																<fmt:formatDate value="${prList.signDate}" pattern="d MMM yyyy , H:mm" />
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
					
					<c:if test="${prList.status == '2'}">
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

					<c:if test="${prList.status == '4' || prList.status == '5' || prList.status == '6'|| prList.status == '7'}">
						<c:choose>
							<c:when test="${prList.status == '4'}"><c:set var="actionLabel" value="Returned By"/></c:when>
							<c:when test="${prList.status == '5'}"><c:set var="actionLabel" value="Rejected By"/></c:when>
							<c:when test="${prList.status == '6'}"><c:set var="actionLabel" value="Cancel By"/></c:when>
							<c:when test="${prList.status == '7'}"><c:set var="actionLabel" value="In Progress By"/></c:when>
						</c:choose>

						<div class="card mb-10">
							<div class="card-body filter-card px-5 px-lg-10 py-5 rounded-3">
								<div class="d-flex align-items-center fs-6">
									<span>${actionLabel} : ${userUpdate.employeeId} ${userUpdate.nameEN},
										<fmt:formatDate value="${prList.timeUpdate}" pattern="d MMM YYYY HH:mm" />
									</span>

									<c:if test="${(prList.status == '4' || prList.status == '5' || prList.status == '7') and not empty prList.reason}">
										<span class="ms-5 d-inline-flex align-items-center">
											<i class="ki-duotone ki-document fs-3 me-3">
												<span class="path1"></span>
												<span class="path2"></span>
											</i>
											<span>${prList.reason}</span>
										</span>
									</c:if>
								</div>
							</div>
						</div>
					</c:if>

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
												<select id="unit" class="form-select h-45px" data-control="select2">
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
											<textarea class="form-control text-gray-700" rows="3"
													name="pr_ref_link" id="pr_ref_link" placeholder="https://..."></textarea>
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
					                                    <th class="min-w-40px text-start mx-0">#</th>
					                                    <th class="min-w-80px">MR ID</th>
					                                    <th class="min-w-100px">Category</th>
					                                    <th class="min-w-200px">Request Name</th>
					                                    <th class="min-w-200px">Product</th>
					                                    <th class="min-w-100px text-end px-2">Status</th>
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
								onclick="clearDraftStorage(); location.href='purchase_requisition_list'"
    							class="btn btn-lg btn-light fw-medium text-light-inverse px-6 py-4 border">Back
							</button>
							<c:if test="${prList.status == '1' or prList.status == '4'}">
								<button type="button" id="cancelFormBtn"
									onclick="cancelPR()"
									class="btn btn-lg btn-dark fw-medium px-6 py-4">Cancel
								</button>
							</c:if>
						</div>
						<c:choose>
							<c:when test="${prList.status == '1'}">
								<div class="d-flex flex-wrap gap-3">
									<button type="button" id="saveDraft" onclick="saveDraftForm()"
										class="btn btn-lg btn-cyan text-white fw-medium px-6 py-4">Save Draft
									</button>
									<button type="button" id="savePRFormBtn"
										class="btn btn-success text-white fw-medium px-6 py-4"
										onclick="submitPR()">Submit PR</button>
								</div>
							</c:when>
							
							<c:when test="${prList.status == '2'}">
									<div class="d-flex flex-wrap gap-3">
										<button type="button" id="returnPRBtn" onclick="returnPR()"
												class="btn btn-lg btn-info text-white fw-medium px-6 py-4">Return</button>
										<button type="button" id="rejectPRBtn" onclick="rejectPR()"
												class="btn btn-lg btn-danger text-white fw-medium px-6 py-4">Reject</button>
										<button type="button" id="approvePRBtn" onclick="approvePR()"
													class="btn btn-lg btn-success text-white fw-medium px-6 py-4">Approve</button>
									</div>
								
							</c:when>

							<c:when test="${prList.status == '4'}">
								<div class="d-flex flex-wrap gap-3">
									<button type="button" id="editPRFormBtn"
										class="btn btn-lg btn-primary fw-medium px-6 py-4"
										onclick="editPR()">Edit</button>
								</div>
							</c:when>

							<c:when test="${prList.status == '3'}">
								<div class="d-flex flex-wrap gap-3">
									<button type="button" id="inProgressPRFormBtn"
										class="btn btn-lg bg-cyan text-white fw-medium px-6 py-4"
										onclick="inProgressPR()">In-Progress</button>
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
	
	const EDIT_PR_ID     = "${empty prList.prId ? '' : prList.prId}";
	const prStatus       = "${empty prList.status ? '' : prList.status}";
	const canEditPrDetail = (prStatus === '1');
	
	
	const serverPrDetailCart = [
		<c:forEach var="d" items="${prDetailList}" varStatus="st">
		{
			prDetailId: "${d.pr_detail_id}",
			productId: "${d.product_id}",
			productName: "${fn:replace(fn:replace(fn:replace(fn:replace(empty d.product_name ? '' : d.product_name, '\\', '\\\\'), '"', '\\"'), cr, ''), nl, '\\n')}",
			parentProductName: "${fn:replace(fn:replace(fn:replace(fn:replace(empty d.parent_product_name ? '' : d.parent_product_name, '\\', '\\\\'), '"', '\\"'), cr, ''), nl, '\\n')}",
			itemsType: "${empty d.product_type ? '' : d.product_type}",
			qty: ${empty d.amount_total ? 0 : d.amount_total},
			unit: "${empty d.unit ? '' : d.unit}",
			unitName: "${fn:replace(fn:replace(fn:replace(fn:replace(empty d.unit_name ? '' : d.unit_name, '\\', '\\\\'), '"', '\\"'), cr, ''), nl, '\\n')}",
			description: "${fn:replace(fn:replace(fn:replace(fn:replace(empty d.description ? '' : d.description, '\\', '\\\\'), '"', '\\"'), cr, ''), nl, '\\n')}",
			savedAt: "<fmt:formatDate value="${d.time_create}" pattern="d MMM yyyy, HH:mm"/>",
			status: "${empty d.status ? '' : d.status}",
			sources: [
				<c:forEach var="p" items="${d.prParentList}" varStatus="ps">
				{
					prParentId: "${empty p.pr_parent_id ? '' : p.pr_parent_id}",
					mrId: "${empty p.mr_id ? '' : p.mr_id}",
					refLink: "${fn:replace(fn:replace(fn:replace(fn:replace(empty p.ref_link ? '' : p.ref_link, '\\', '\\\\'), '"', '\\"'), cr, ''), nl, '\\n')}",
					qty: ${empty p.amount ? 0 : p.amount},
					unit: "${empty p.unit ? '' : p.unit}",
					unitName: "${fn:replace(fn:replace(fn:replace(fn:replace(empty p.unit_name ? '' : p.unit_name, '\\', '\\\\'), '"', '\\"'), cr, ''), nl, '\\n')}",
					baseQty: ${empty p.base_qty ? (empty p.amount ? 0 : p.amount) : p.base_qty},
					description: "${fn:replace(fn:replace(fn:replace(fn:replace(empty p.description ? '' : p.description, '\\', '\\\\'), '"', '\\"'), cr, ''), nl, '\\n')}",
					creatorName: "${empty p.userEmployeeId ? '' : p.userEmployeeId}${empty p.user_create_nameEN ? '' : ' - '.concat(p.user_create_nameEN)}",
					savedAt: "<fmt:formatDate value="${p.time_create}" pattern="d MMM yyyy, HH:mm"/>"
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

		document.querySelector('#kt_app_content_container').addEventListener('click', function(e){
			const btn = e.target.closest('.pr-group-toggle');
			if (!btn) return;

			const collapseEl = document.getElementById('prGroup_' + btn.dataset.target);
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
		    
		    
		    const createPrModalEl = document.getElementById('modal_create_pr');

		    createPrModalEl.addEventListener('show.bs.modal', function () {
		        if (editingIndex === -1 && !editingExistingDetailId) {
		            $('#items_type').val('equipment').trigger('change');
		            $('#pr_qty').val('1');
		            $('#unit').val('');
		            $('#pr_ref_link').val('');
		            $('#pr_description').val('');
		            $('#modal_create_pr .modal-title').text('Create PR - Detail');
		            $('#btnSavePrDetail').text('Save');
		            $('#prQtyUnitRow').removeClass('d-none');
		            $('#prRefLinkRow').removeClass('d-none');
		        } else {
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
		        editingExistingDetailId = null;
		        document.querySelectorAll('.modal-backdrop').forEach(el => el.remove());
		        document.body.classList.remove('modal-open');
		        document.body.style.removeProperty('padding-right');
		        document.body.style.removeProperty('overflow');
		        document.documentElement.style.removeProperty('overflow');
		    });
		    
			const btnOpenCreatePr = document.getElementById('btnOpenCreatePr');
			if (btnOpenCreatePr) {
				btnOpenCreatePr.addEventListener('click', function () {
					editingIndex = -1;
					editingExistingDetailId = null;
					bootstrap.Modal.getOrCreateInstance(createPrModalEl, { backdrop: true }).show();
				});
			}

			document.getElementById('modal_edit_source').addEventListener('hidden.bs.modal', function () {
				editingSrc = null;
			});

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
	        	clearDraftStorage();
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
	            '<div class="d-flex align-items-center justify-content-between w-100 rounded">' +
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
	            url: ctx + '/delete_pr_attachment',
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
let prDetailCart = []; // เก็บรายการใหม่ ที่เพิ่มระหว่างแก้ไข ยังไม่ถูกบันทึกลง DB
let existingPrDetailList = (typeof serverPrDetailCart !== 'undefined') ? serverPrDetailCart : []; // รายการเดิมที่มีอยู่แล้วใน DB (แก้/ลบผ่าน AJAX ทันที)
let prDetailCounter = 0;
let editingIndex = -1;
let editingExistingDetailId = null; // pr_detail_id ของรายการเดิมที่กำลังแก้ (ถ้ามี)
let pendingExistingSources = {};
let confirmed1 = ${empty prList.signDate ? 'false' : 'true'}; //track ว่าลงชื่อ ผู้ขอเบิก แล้วหรือยัง

const PR_CART_STORAGE_KEY = 'prDetailCart_draft_' + (EDIT_PR_ID || 'new');
const PR_EXISTING_SRC_KEY = 'prExistingSrc_draft_' + (EDIT_PR_ID || 'new');
let pendingSourceEdits = {}; // { prDetailId: { prParentId: { qty, unit, unitName, baseQty } } }
const PR_SOURCE_EDIT_KEY = 'prSourceEdit_draft_' + (EDIT_PR_ID || 'new');
let pendingExistingEdits = {};   // { prDetailId: { description, refLink, [productId, productName, parentProductName, itemsType, unit, unitName] } }
const PR_EXISTING_EDIT_KEY = 'prExistingEdit_draft_' + (EDIT_PR_ID || 'new');

function clearDraftStorage(){
    sessionStorage.removeItem(PR_CART_STORAGE_KEY);
    sessionStorage.removeItem(PR_EXISTING_SRC_KEY);
    sessionStorage.removeItem(PR_SOURCE_EDIT_KEY);
    sessionStorage.removeItem(PR_EXISTING_EDIT_KEY);
}

function effectiveExisting(item){
    const e = item && item.prDetailId ? pendingExistingEdits[String(item.prDetailId)] : null;
    if (!e) return item;
    const out = { ...item, description: e.description };
    if (e.productId && String(e.productId) !== String(item.productId)) {
        out.productId = e.productId;
        out.productName = e.productName;
        out.parentProductName = e.parentProductName || '';
        out.itemsType = e.itemsType;
        out.unit = e.unit;
        out.unitName = e.unitName;
    }
    return out;
}

loadCartFromSession();
document.addEventListener('DOMContentLoaded', function(){
    renderPrDetailCart();
});


function addSourceToCart(itemBase, source){
	// ถ้าสินค้านี้มีการ์ดอยู่แล้วใน DB ต่อเป็น source ใหม่ของการ์ดนั้น
    const exItem = existingPrDetailList.find(function(it){
        return String(effectiveExisting(it).productId) === String(itemBase.productId);
    });
    if (exItem) {
        const pid = String(exItem.prDetailId);
        const pending = pendingExistingSources[pid] || [];
        const dup = (exItem.sources || []).concat(pending).some(function(s){
            return source.mrId && String(s.mrId) === String(source.mrId);
        });
        if (dup) return;
        pending.push(source);
        pendingExistingSources[pid] = pending;
        return;
    }

    const idx = prDetailCart.findIndex(function(it){
        return String(it.productId) === String(itemBase.productId);
    });
    if (idx >= 0) {
        const ex = prDetailCart[idx];

        // item เดิมที่ยังไม่มี sources ห่อตัวเองเป็น source แรกก่อน
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

// draft เก่าใน sessionStorage ที่ยังไม่มี sources
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

function mapDbItemsTypeToSelect(val){
    switch(String(val)){
        case '1': return 'equipment';
        case '2': return 'consumables';
		case '3': return 'accessory';
        case '4': return 'office';
        default:  return val;
    }
}
function saveCartToSession(){
    try {
        sessionStorage.setItem(PR_CART_STORAGE_KEY, JSON.stringify(prDetailCart));
        sessionStorage.setItem(PR_EXISTING_SRC_KEY, JSON.stringify(pendingExistingSources));
        sessionStorage.setItem(PR_SOURCE_EDIT_KEY, JSON.stringify(pendingSourceEdits));
        sessionStorage.setItem(PR_EXISTING_EDIT_KEY, JSON.stringify(pendingExistingEdits));
    } catch (e) {
        console.error('ไม่สามารถบันทึก cart ลง sessionStorage ได้', e);
    }
}

function loadCartFromSession(){
    try {
        const saved = sessionStorage.getItem(PR_CART_STORAGE_KEY);
        if (saved) prDetailCart = JSON.parse(saved).map(normalizeCartItem);

        const savedEx = sessionStorage.getItem(PR_EXISTING_SRC_KEY);
        if (savedEx) pendingExistingSources = JSON.parse(savedEx) || {};

        const savedEdits = sessionStorage.getItem(PR_SOURCE_EDIT_KEY);
        if (savedEdits) pendingSourceEdits = JSON.parse(savedEdits) || {};

        const savedExEdits = sessionStorage.getItem(PR_EXISTING_EDIT_KEY);
        if (savedExEdits) pendingExistingEdits = JSON.parse(savedExEdits) || {};

    } catch (e) {
        console.error('ไม่สามารถโหลด cart จาก sessionStorage ได้', e);
        prDetailCart = [];
        pendingExistingSources = {};
        pendingSourceEdits = {};
        pendingExistingEdits = {};
    }
}

//กันข้อมูลหายตอน refresh
loadCartFromSession();
document.addEventListener('DOMContentLoaded', function(){
    if (prDetailCart.length > 0 || existingPrDetailList.length > 0) {
        renderPrDetailCart();
    }
});

function validatePrDetailForm(){
    let errors = [];

    if (!$('#items_type').val() || !$('#items_type').val().trim()) errors.push('Category');
    if (!$('#product_name').val() || !$('#product_name').val().trim()) errors.push('Product Name');

    if (editingIndex === -1 && !editingExistingDetailId) {
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

    if (editingExistingDetailId) {
        stageExistingPrDetailEdit(editingExistingDetailId, {
            itemsType: $("#items_type").val(),
            productId: $("#product_name").val(),
            productName: $("#product_name option:selected").text(),
            description: description,
            refLink: refLink
        });
        return;
    }

    if (editingIndex >= 0) {
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

    if (document.activeElement) {
        document.activeElement.blur();
    }

    const modalEl = document.getElementById("modal_create_pr");
    const modal = bootstrap.Modal.getOrCreateInstance(modalEl);
    modal.hide();
}

function updateInProgressCount(){
    const countEl = document.getElementById('prInProgressCount');
    const totalEl = document.getElementById('prInProgressTotal');
    if (!countEl || !totalEl) return; //แค่status = 7

    const total = existingPrDetailList.length; // จำนวน PR-Detail ทั้งหมด
    const approvedCount = existingPrDetailList.filter(function(item){
        return item.status == 1; // 
    }).length;

    countEl.textContent = approvedCount;
    totalEl.textContent = total;
}
function renderPrDetailCart(){

    let html = "";

    existingPrDetailList.forEach(function(item){

        html += createPrCard(item, null, item.prDetailId);

    });

    prDetailCart.forEach(function(item,index){

        html += createPrCard(item, index, null);

    });

    const totalCount = existingPrDetailList.length + prDetailCart.length;

    if (totalCount === 0) {
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

	updateInProgressCount();

}

//-------- PR- Detail -----------
function createPrCard(item,index,prDetailId){
    const origItem = item;
    const editInfo = prDetailId ? pendingExistingEdits[String(prDetailId)] : null;
    const productChanged = !!(editInfo && editInfo.productId && String(editInfo.productId) !== String(origItem.productId));
    if (prDetailId) item = effectiveExisting(item);
    const manualIdx = editInfo ? getManualRefSourceIndex(origItem) : -1;
    const safeQty = Number(item.qty) || 0;
	const pending = prDetailId ? (pendingExistingSources[String(prDetailId)] || []) : [];
	const pendingQty = pending.reduce(function(a, s){
		return a + (Number(s.baseQty != null ? s.baseQty : s.qty) || 0);
	}, 0);
	const srcEditsMap = prDetailId ? (pendingSourceEdits[String(prDetailId)] || {}) : {};
    const existingSources = (item.sources || []).map(function(s, i){
        const e = s.prParentId ? srcEditsMap[String(s.prParentId)] : null;
        let out = e ? { ...s, qty: e.qty, unit: e.unit, unitName: e.unitName, baseQty: e.baseQty } : s;
        if (!e && productChanged) {
            const b = Number(s.baseQty != null ? s.baseQty : s.qty) || 0;
            out = { ...s, qty: b, baseQty: b, unit: editInfo.unit, unitName: editInfo.unitName };
        }
        if (editInfo && i === manualIdx) out = { ...out, refLink: editInfo.refLink };
        return out;
    });
    const editQtyDelta = (item.sources || []).reduce(function(a, s){
        const e = s.prParentId ? srcEditsMap[String(s.prParentId)] : null;
        if (!e) return a;
        const oldBase = Number(s.baseQty != null ? s.baseQty : s.qty) || 0;
        return a + ((Number(e.baseQty) || 0) - oldBase);
    }, 0);
    const displayQty = safeQty + pendingQty + editQtyDelta;
    const allSources = existingSources.concat(pending);
	const pendingStartIndex = existingSources.length; // index ตั้งแต่ตรงนี้เป็นต้นไป = source ใหม่ที่ยังไม่ save

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

    const groupId = prDetailId ? ("existing_" + prDetailId) : ("cart_" + index);
    const displayProductName = item.parentProductName
        ? item.parentProductName + ' > ' + (item.productName || '')
        : (item.productName || '');
		
	const descriptionHtml = item.description
        ? '<div class="d-flex align-items-center">'
            + '<i class="ki-duotone ki-document fs-2 text-muted me-2">'
                + '<span class="path1"></span><span class="path2"></span>'
            + '</i>'
            + '<span class="text-gray-900 fs-5 fw-normal">' + item.description + '</span>'
        + '</div>'
        : '';

	const manualSrc = allSources.find(function(s){
        return !s.mrId && s.refLink;
    }) || ((editInfo && editInfo.refLink) ? { refLink: editInfo.refLink } : null);
	const headerRefLinkHtml = manualSrc ? `
		<a href="\${manualSrc.refLink}" target="_blank" rel="noopener" class="text-primary d-inline-flex ms-2" onclick="event.stopPropagation();" title="Ref Link">
			<i class="ki-duotone ki-fasten fs-2 text-primary"><span class="path1"></span><span class="path2"></span></i>
		</a>` : '';

    let actionButtons = '';
    if (canEditPrDetail) {
        actionButtons = prDetailId
        ? `<a href="#" onclick="return editExistingCartItem('\${prDetailId}');" class="btn btn-icon btn-light-primary btn-sm" title="Edit">
                <i class="ki-duotone ki-pencil fs-2"><span class="path1"></span><span class="path2"></span></i>
            </a>
            <a href="#" onclick="return removeExistingCartItem('\${prDetailId}');" class="btn btn-icon btn-light-danger btn-sm" title="Delete">
                <i class="ki-duotone ki-trash fs-2"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i>
            </a>`
        : `<a href="#" onclick="return editCartItem(\${index});" class="btn btn-icon btn-light-primary btn-sm" title="Edit">
                <i class="ki-duotone ki-pencil fs-2"><span class="path1"></span><span class="path2"></span></i>
            </a>
            <a href="#" onclick="return removeCartItem(\${index});" class="btn btn-icon btn-light-danger btn-sm" title="Delete">
                <i class="ki-duotone ki-trash fs-2"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i>
            </a>`;
	}

    return `<div class="pr-item-group border-gray-400 border-bottom pt-9 pb-6 px-6">
    			<div class="d-flex align-items-center justify-content-between row g-3">
    				<div class="col-12 col-lg-7 d-flex flex-wrap align-items-center">\${icon}
						<span class="text-gray-900 fs-5 fw-normal me-3">\${category}</span>
						<span class="text-gray-900 fs-5 fw-normal me-3">\${displayProductName}</span>

						\${descriptionHtml} \${headerRefLinkHtml}
					</div>
		
					<div class="col-5 col-lg-2 d-flex align-items-center justify-content-between px-0">
						<div class="col-12 d-flex flex-column text-start text-lg-end">
							<span class="fs-6 fw-normal text-gray-900">\${item.unitName}</span>
							<span class="fw-semibold text-gray-800 fs-5">\${displayQty}</span>
						</div>
					</div>
		
					<div class="col-7 col-lg-3 d-flex justify-content-end align-items-center gap-2 px-0">
						\${actionButtons}
						<a class="collapsed pr-group-toggle" data-target="\${groupId}">
							<i class="ki-duotone ki-up-square fs-2hx">
								<span class="path1"></span><span class="path2"></span>
							</i>
						</a>
						\${
							prStatus === '7'
								? (item.status == 1
									? '<i class="ki-solid ki-check-square fs-2hx text-success"></i>'
									: '<i class="ki-solid ki-cross-square fs-2hx text-disabled"></i>')
								: ''
						}
					</div>
			</div>
			
			<div class="collapse border-gray-300 border-top mt-3" id="prGroup_\${groupId}">
	            <div class="ps-9 pt-9">
	                \${
						allSources.length > 0
                            ? allSources.map(function(s, i){
								var srcBaseQty = (s.baseQty != null) ? s.baseQty : s.qty;
								var isNewSource = !!prDetailId && i >= pendingStartIndex;
								var rowRefLink = s.mrId ? s.refLink : '';
								
								// เมนูแสดงทุกแถว (ทั้งที่ยังไม่ save และที่ save ลง DB แล้ว) เมื่อ PR เป็น Draft
								var menuCtx = null;
								if (canEditPrDetail) {
									if (!prDetailId) menuCtx = { scope: 'cart', a: index, b: i };
									else if (isNewSource) menuCtx = { scope: 'pending', a: prDetailId, b: i - pendingStartIndex };
									else menuCtx = { scope: 'db', a: prDetailId, b: i };
								}
								return createPrSourceRow(s.qty, s.unitName || item.unitName, srcBaseQty, item.unitName,
														s.savedAt, s.mrId, rowRefLink, s.creatorName, isNewSource, menuCtx);
						}).join('')
							: ((Number(item.qty) || 0) > 0
                                ? createPrSourceRow(item.qty, item.unitName, item.qty, item.unitName, item.savedAt, null, '', currentUserDisplay, false, null)
                                : 'ไม่มีรายการ')
					}
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

function createPrSourceRow(qty, unitName, baseQty, baseUnitName, savedAt, mrId, refLink, creatorName, isNew, menuCtx){
    const qtyUnitDisplay = qty + ' ' + unitName + ' (= ' + baseQty + ' ' + baseUnitName + ')';

    const menuHtml = menuCtx ? `
            <div class="pr-src-menu position-relative d-inline-block flex-shrink-0">
                <a href="#" class="btn btn-icon btn-sm btn-light-primary w-30px h-30px"
                   onclick="return toggleSrcMenu(this, event);" aria-label="More actions" aria-haspopup="true">
                    <i class="ki-outline ki-dots-horizontal fs-2"></i>
                </a>

                <div class="pr-src-actions position-absolute end-0 top-100 mt-2 bg-body rounded-3 shadow z-index-3">
                    <div class="py-2">
                        <a href="#" class="pr-src-item d-block px-6 py-3 fs-6 fw-normal text-gray-800 bg-hover-light"
                           onclick="event.stopPropagation(); return editSource('\${menuCtx.scope}', '\${menuCtx.a}', \${menuCtx.b});">Edit</a>
                        <a href="#" class="pr-src-item d-block px-6 py-3 fs-6 fw-normal text-gray-800 bg-hover-light"
                           onclick="event.stopPropagation(); return removeSource('\${menuCtx.scope}', '\${menuCtx.a}', \${menuCtx.b});">Delete</a>
                    </div>
                </div>
            </div>` : '';

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
            \${menuHtml}
        </div>
    </div>`;
}

function editCartItem(index){
    const item = prDetailCart[index];
    if (!item) return false;

    editingIndex = index;

    $('#modal_create_pr .modal-title').text('Edit PR - Detail');
    $('#btnSavePrDetail').text('Update');

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

    $('#pr_qty').val(item.qty);
    // $('#unit').val(item.unit);
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

// หา item / src / list จาก scope: 'cart' = การ์ดใหม่ (prDetailCart), 'pending' = source ใหม่ของการ์ดเดิม
// ที่ยังไม่ save, 'db' = source ที่ save ลง pr_parent จริงแล้ว (list = item.sources)
function resolveSrc(scope, a, b){
    if (scope === 'cart') {
        const item = prDetailCart[Number(a)];
        const list = item && item.sources;
        return { item: item, list: list, src: list && list[b] };
    }
    if (scope === 'db') {
        const item = effectiveExisting(existingPrDetailList.find(function(it){ return String(it.prDetailId) === String(a); }));
        const list = item && item.sources;
        let src = list && list[b];
        if (src && src.prParentId) {
            const e = (pendingSourceEdits[String(a)] || {})[String(src.prParentId)];
            if (e) src = { ...src, ...e };
        }
        return { item: item, list: list, src: src };
    }
    const item = effectiveExisting(existingPrDetailList.find(function(it){ return String(it.prDetailId) === String(a); }));
    const list = pendingExistingSources[String(a)];
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
            const prDetailIdVal = a;
            const hasPendingNew = (pendingExistingSources[String(a)] || []).length > 0;
            const isLast = r.list.length <= 1 && !hasPendingNew;   // มี pending ค้างอยู่ = ยังไม่ใช่แถวสุดท้ายจริง

            const onDone = function (resp) {
                if (resp.data && resp.data.success) {
                    if (pendingSourceEdits[String(prDetailIdVal)]) {
                        delete pendingSourceEdits[String(prDetailIdVal)][String(removed.prParentId)];
                    }
                    if (isLast) {
                        delete pendingExistingSources[String(prDetailIdVal)];
                        delete pendingSourceEdits[String(prDetailIdVal)];
                        delete pendingExistingEdits[String(prDetailIdVal)];
                    }
                    saveCartToSession();
                    toastOk('ลบรายการสำเร็จ', function(){ window.location.reload(); });
                } else {
                    toastFail('ไม่สามารถลบรายการได้');
                }
            };
            const onFail = function () { toastFail('เกิดข้อผิดพลาดในการลบรายการ'); };

            if (isLast) {
                $.ajax({ url: ctx + '/delete_pr_detail', type: 'POST', dataType: 'json',
                    data: { prDetailId: prDetailIdVal, prId: EDIT_PR_ID }, success: onDone, error: onFail });
            } else {
                $.ajax({ url: ctx + '/delete_pr_source', type: 'POST', dataType: 'json',
                    data: { prParentId: removed.prParentId, prDetailId: prDetailIdVal, prId: EDIT_PR_ID,
                            keepDetail: (r.list.length <= 1) ? 'true' : 'false' },
                    success: onDone, error: onFail });
            }
            return;
        } else if (scope === 'pending') {
            r.list.splice(b, 1);
            const stillHasDbSource = (r.item.sources || []).length > 0;   // r.item.sources = source จริงใน DB (ไม่รวม pending)
            if (r.list.length === 0) delete pendingExistingSources[String(a)];

            if (!stillHasDbSource && r.list.length === 0) {
                // DB ไม่มี source เหลือเลย (ถูกลบไปตอน keepDetail) + pending ก็หมดแล้ว
                // การ์ดนี้ไม่มีอะไรเหลือจริงๆ ต้องลบ pr_detail ทิ้งให้จบ ไม่งั้นจะเหลือเป็น ghost row ว่างเปล่าใน DB
                delete pendingSourceEdits[String(a)];
                delete pendingExistingEdits[String(a)];
                $.ajax({
                    url: ctx + '/delete_pr_detail',
                    type: 'POST', dataType: 'json',
                    data: { prDetailId: a, prId: EDIT_PR_ID },
                    success: function (resp) {
                        saveCartToSession();
                        if (resp.data && resp.data.success) {
                            toastOk('ลบรายการสำเร็จ', function(){ window.location.reload(); });
                        } else {
                            toastFail('ไม่สามารถลบรายการได้');
                            renderPrDetailCart();
                        }
                    },
                    error: function () { toastFail('เกิดข้อผิดพลาดในการลบรายการ'); renderPrDetailCart(); }
                });
                return;   // ข้าม saveCartToSession/renderPrDetailCart ท้ายฟังก์ชัน เพราะจัดการใน success/error แล้ว
            }
        } else if (scope === 'cart') {
            const baseQty = Number(removed.baseQty != null ? removed.baseQty : removed.qty) || 0;
            r.list.splice(b, 1);
            if (r.list.length === 0) {
                prDetailCart.splice(Number(a), 1);
            } else {
                r.item.qty = Math.max(0, (Number(r.item.qty) || 0) - baseQty);
            }
        }

        saveCartToSession();
        renderPrDetailCart();
        uncheckMrCheckboxesForItem({ sources: [removed] });
    });
    return false;
}

let editingSrc = null;

function editSource(scope, a, b){
    closeAllSrcMenus();
    const r = resolveSrc(scope, a, b);
    if (!r.item || !r.src) return false;
    const item = r.item, src = r.src;
    if (scope === 'db') {
        const stagedEdit = pendingExistingEdits[String(a)];
        const orig = existingPrDetailList.find(function(it){ return String(it.prDetailId) === String(a); });
        if (stagedEdit && stagedEdit.productId && orig && String(stagedEdit.productId) !== String(orig.productId)) {
            Swal.fire('Error', 'มีการเปลี่ยนสินค้าที่ยังไม่ได้บันทึก กรุณากด Save ก่อนแก้ไขจำนวนของแถวเดิม', 'error');
            return false;
        }
    }

     const fullName = item.parentProductName
        ? item.parentProductName + ' > ' + (item.productName || '')
        : (item.productName || '');

    // source ที่ดึงมาจาก MR เปิด Search MR พร้อมใส่ชื่อสินค้าในช่อง search
    if (src.mrId) {
        openSearchMrWithKeyword(fullName);
        return false;
    }

    editingSrc = { scope: scope, a: a, b: b };
    const baseQty = (src.baseQty != null) ? src.baseQty : src.qty;
    const cat = getCategoryIcon(mapSelectToDbItemsType(item.itemsType));
    // const fullName = item.parentProductName
    //     ? item.parentProductName + ' > ' + (item.productName || '')
    //     : (item.productName || '');

    $('#editSrcTypeIcon').html(cat.icon);
    $('#editSrcTypeName').text(cat.name);
    $('#editSrcProduct').text(fullName);
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
            icon: "error",
            confirmButtonText: "OK"
        });
        return;
    }

    const r = resolveSrc(editingSrc.scope, editingSrc.a, editingSrc.b);
    if (!r.item || !r.src) return;

    const old = r.src;

    if (editingSrc.scope === 'db') {
        const dbUnitName = $('#edit_src_unit option:selected').text();
        const dbRate = Number($('#edit_src_unit option:selected').data('conversion-rate')) || 1;
        const pid = String(editingSrc.a);
        const ppid = String(old.prParentId);
        pendingSourceEdits[pid] = pendingSourceEdits[pid] || {};
        pendingSourceEdits[pid][ppid] = { qty: qty, unit: unitId, unitName: dbUnitName, baseQty: qty * dbRate };

        saveCartToSession();
        renderPrDetailCart();
        if (document.activeElement) document.activeElement.blur();
        bootstrap.Modal.getOrCreateInstance(document.getElementById('modal_edit_source')).hide();
        return;
    }

    const unitName = $('#edit_src_unit option:selected').text();
    const rate = Number($('#edit_src_unit option:selected').data('conversion-rate')) || 1;
    const baseQty = qty * rate;
    const oldBase = Number(old.baseQty != null ? old.baseQty : old.qty) || 0;
    const updated = { ...old, qty: qty, unit: unitId, unitName: unitName, baseQty: baseQty };

    r.list[editingSrc.b] = updated;
    if (editingSrc.scope === 'cart') {
        r.item.qty = (Number(r.item.qty) || 0) + (baseQty - oldBase);   // ปรับยอดรวมของการ์ดใหม่
    }
    // scope 'pending': ยอดรวมคำนวณจาก pending 

    saveCartToSession();
    renderPrDetailCart();

    if (document.activeElement) document.activeElement.blur();
    bootstrap.Modal.getOrCreateInstance(document.getElementById('modal_edit_source')).hide();
}

/* ──────── แก้ไข / ลบ รายการที่มีอยู่แล้วใน DB ──────── */
function editExistingCartItem(prDetailId){
    const rawItem = existingPrDetailList.find(function(d){ return String(d.prDetailId) === String(prDetailId); });
    if (!rawItem) return false;
    const item = effectiveExisting(rawItem);
    const stagedEdit = pendingExistingEdits[String(prDetailId)];

    editingExistingDetailId = prDetailId;
    editingIndex = -1;

    $('#modal_create_pr .modal-title').text('Edit PR - Detail');
    $('#btnSavePrDetail').text('Update');

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

    $('#pr_qty').val(item.qty);
    $('#pr_description').val(item.description);
	const manualSrc = getManualRefSource(rawItem);
    $('#pr_ref_link').val(stagedEdit ? (stagedEdit.refLink || '') : (manualSrc ? (manualSrc.refLink || '') : ''));

    const modalEl = document.getElementById("modal_create_pr");
    const modal = bootstrap.Modal.getOrCreateInstance(modalEl);
    modal.show();

    return false;
}

function removeExistingCartItem(prDetailId){
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
                url: ctx + '/delete_pr_detail',
                type: 'POST',
                dataType: 'json',
                data: { prDetailId: prDetailId, prId: EDIT_PR_ID },
                success: function (resp) {
                    if (resp.data && resp.data.success) {
						delete pendingExistingSources[String(prDetailId)];
                        delete pendingSourceEdits[String(prDetailId)];
                        delete pendingExistingEdits[String(prDetailId)];
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
        }
    });
    return false;
}

// ปิด modal ให้เสร็จก่อน (รอ hidden.bs.modal) แล้วค่อยทำ after()
function hideModalThen(modalId, after){
    var el = document.getElementById(modalId);
    if (!el || !el.classList.contains('show')) { if (after) after(); return; }
    el.addEventListener('hidden.bs.modal', function(){ if (after) after(); }, { once: true });
    bootstrap.Modal.getOrCreateInstance(el).hide();
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

function stageExistingPrDetailEdit(prDetailId, form){
    const id = String(prDetailId);
    const orig = existingPrDetailList.find(function(d){ return String(d.prDetailId) === id; });
    if (!orig) return;

    const productChanged = String(form.productId) !== String(orig.productId);
    const edit = { description: form.description, refLink: form.refLink };

    if (productChanged) {
        const hasPending = (pendingExistingSources[id] || []).length > 0
            || Object.keys(pendingSourceEdits[id] || {}).length > 0;
        if (hasPending) {
            Swal.fire('Error', 'การ์ดนี้มีรายการที่ยังไม่ได้บันทึก กรุณากด Save ก่อนเปลี่ยนสินค้า', 'error');
            return;
        }
        const baseUnitId = $('#unit').data('base-unit-id');
        if (!baseUnitId) {
            Swal.fire('Error', 'ยังโหลดหน่วยนับของสินค้าที่เลือกไม่เสร็จ หรือสินค้านี้ยังไม่มีหน่วยนับ', 'error');
            return;
        }
        edit.productId = form.productId;
        edit.productName = form.productName;
        edit.parentProductName = '';
        edit.itemsType = form.itemsType;
        edit.unit = baseUnitId;
        edit.unitName = $('#unit').data('base-unit-name') || '';
    }

    const manualSrc = getManualRefSource(orig);
    const sameDesc = (form.description || '') === (orig.description || '');
    const sameRef = (form.refLink || '') === ((manualSrc && manualSrc.refLink) || '');
    if (!productChanged && sameDesc && sameRef) delete pendingExistingEdits[id];
    else pendingExistingEdits[id] = edit;

    editingExistingDetailId = null;
    saveCartToSession();
    renderPrDetailCart();
    if (document.activeElement) document.activeElement.blur();
    bootstrap.Modal.getOrCreateInstance(document.getElementById("modal_create_pr")).hide();
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
            if (requestToken !== mrSearchRequestToken || !isSearchMrModalOpen) {
                return;
            }
            var data = resp.data;
            inprogressMrDetailList = (data && data.mrDetailList) || [];
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

function isMrDetailIdHiddenFromSearch(mrId){
    return existingPrDetailList.some(function(it){
        return (it.sources || []).some(function(s){ return String(s.mrId) === String(mrId); });
    });
}

function isMrDetailIdInNewCart(mrId){
    var inNewCart = prDetailCart.some(function(it){
        return (it.sources || []).some(function(s){ return String(s.mrId) === String(mrId); });
    });
    if (inNewCart) return true;

    return Object.keys(pendingExistingSources).some(function(pid){
        return pendingExistingSources[pid].some(function(s){ return String(s.mrId) === String(mrId); });
    });
}

function renderMrResultTable(fullList){
    var tbody = document.getElementById('mrResultBody');
    var html = '';

    // รายการที่ดึงมาใหม่ ยังโผล่และถูกติ๊กไว้ ให้ถอดติ๊กเพื่อลบออกจาก cart ได้
    var list = (fullList || []).filter(function(item){
        return !isMrDetailIdHiddenFromSearch(item.mr_id);
    });

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
                        data-mr-detail-id="\${item.mr_id}"\${isMrDetailIdInNewCart(item.mr_id) ? ' checked' : ''} />
                </div>
            </td>
            <td class="fw-bold text-gray-900 fs-7 row-number text-start"></td>
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
            <td class="text-end pe-2">
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
        ordering : true,
        searching : true,
        autoWidth : false,
        info: false,
        paging: false,
        columnDefs : [
            { orderable: false, targets: [0,6] },
            { orderable: true, targets: [1,2,3,4,5] },
            { targets: -1, orderable: false }
        ],
        order: [],
        drawCallback: function(settings) {
            var api = this.api();

            api.column(1, { search: 'applied', order: 'applied' })
                .nodes()
                .each(function (cell, i) {
                    cell.innerHTML = i + 1;
                });

            document.getElementById('mrItemsFoundCount').textContent = api.rows({ search: 'applied' }).count();
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

	checkAll.checked = list.length > 0 && list.every(function (d) { return isMrDetailIdInNewCart(d.mr_id); });
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

    inprogressMrDetailList.forEach(function(d){
        var mrId = String(d.mr_id);
        if (selectedIdSet[mrId]) return; // ยังติ๊กอยู่ ไม่ต้องลบ

        // เอาออกจาก prDetailCart (การ์ดใหม่)
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

        // เอาออกจาก pendingExistingSources (source ใหม่ที่ต่อเข้าการ์ดเดิม ยังไม่ save)
        Object.keys(pendingExistingSources).forEach(function(pid){
            var pending = pendingExistingSources[pid];
            var idx = pending.findIndex(function(s){ return String(s.mrId) === mrId; });
            if (idx === -1) return;
            pending.splice(idx, 1);
            if (pending.length === 0) delete pendingExistingSources[pid];
        });
    });

    // รายการที่ดึงมาจาก Search MR ทั้งหมดเป็นของใหม่ (ยังไม่ save ลง DB)
	// group ตาม productId เฉพาะกับรายการใหม่ใน prDetailCart เท่านั้น ไม่ยุ่งกับ existingPrDetailList
    selectedIds.forEach(function(mrId){
        var src = inprogressMrDetailList.find(function(d){ return String(d.mr_id) === String(mrId); });
        if (!src) return;
        if (isMrDetailIdInNewCart(mrId)) return; // กันเพิ่มซ้ำ

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

    if (document.activeElement) {
        document.activeElement.blur();
    }

    var modalEl = document.getElementById('modal_search_mr');
    bootstrap.Modal.getOrCreateInstance(modalEl).hide();
});

//────────── Confirm Receiver ──────────
function confirmReceiver(slot) {
    if (!EDIT_PR_ID) return;

    const btn = document.getElementById('receiverBtn' + slot);
    btn.disabled = true; // กันกดซ้ำระหว่างรอ ajax

    $.ajax({
        url: ctx + '/confirm_pr_sign',
        type: 'POST',
        dataType: 'json',
        data: { prId: EDIT_PR_ID },
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

function buildCartPayload(){
    const merged = [];
    const ids = {};
    Object.keys(pendingExistingSources).forEach(function(k){ ids[k] = true; });
    Object.keys(pendingSourceEdits).forEach(function(k){ ids[k] = true; });
    Object.keys(pendingExistingEdits).forEach(function(k){ ids[k] = true; });

    Object.keys(ids).forEach(function(pid){
        const exRaw = existingPrDetailList.find(function(it){ return String(it.prDetailId) === String(pid); });
        if (!exRaw) return;
        const ex = effectiveExisting(exRaw);
        const edit = pendingExistingEdits[pid];
        const srcs = pendingExistingSources[pid] || [];
        const editsMap = pendingSourceEdits[pid] || {};
        const editIds = Object.keys(editsMap);
        if (srcs.length === 0 && editIds.length === 0 && !edit) return;

        const row = {
            prDetailId: pid,
            productId: ex.productId,
            itemsType: ex.itemsType,
            unit: ex.unit,
            description: '',
            qty: srcs.reduce(function(a, s){
                return a + (Number(s.baseQty != null ? s.baseQty : s.qty) || 0);
            }, 0),
            sources: srcs,
            sourceEdits: editIds.map(function(id){
                return { prParentId: id, qty: editsMap[id].qty, unit: editsMap[id].unit };
            })
        };
        if (edit) {
            row.editDescription = edit.description || '';
            row.editRefLink = edit.refLink || '';
            if (edit.productId && String(edit.productId) !== String(exRaw.productId)) {
                row.editProductId = edit.productId;
            }
        }
        merged.push(row);
    });
    return prDetailCart.concat(merged);
}

function saveDraftForm(){
    const payload = {
		prId: EDIT_PR_ID || '',
        description: $('#description').val() || '',
        prDetailCartJson: JSON.stringify(buildCartPayload())
    };
    const fd = new FormData();
    Object.keys(payload).forEach(function (k) { fd.append(k, payload[k]); });
    if (typeof selectedFiles !== 'undefined') {
        selectedFiles.forEach(function (file) { fd.append('files', file, file.name); });
    }
    
 	$('#saveDraft').prop('disabled', true);
 
    $.ajax({
    	url: ctx + (EDIT_PR_ID ? '/update_pr' : '/save_pr'),
        type: 'POST',
        dataType: 'json',
        data: fd,
        processData: false,
        contentType: false,
        success: function (resp) {
            if (resp.data && resp.data.prId) {
                clearDraftStorage();
                Swal.fire({ title: 'Success!', text: 'Pr saved draft successfully!', icon: 'success' })
                    .then(() => { window.location.href = ctx + '/purchase_requisition_list'; });
            } else {
                Swal.fire('Error', 'ไม่สามารถบันทึก Draft ได้', 'error');
            }
        },
        error: function () {
            Swal.fire('Error', 'เกิดข้อผิดพลาดในการบันทึก', 'error');
        },
        complete: function(){ $('#saveDraft').prop('disabled', false); }
    });
}

function getExistingCardTotalQty(item){
    const pid = String(item.prDetailId);
    const eff = effectiveExisting(item);
    const pending = pendingExistingSources[pid] || [];
    const pendingQty = pending.reduce(function(a, s){
        return a + (Number(s.baseQty != null ? s.baseQty : s.qty) || 0);
    }, 0);
    const editsMap = pendingSourceEdits[pid] || {};
    const delta = (eff.sources || []).reduce(function(a, s){
        const e = s.prParentId ? editsMap[String(s.prParentId)] : null;
        if (!e) return a;
        const oldBase = Number(s.baseQty != null ? s.baseQty : s.qty) || 0;
        return a + ((Number(e.baseQty) || 0) - oldBase);
    }, 0);
    return (Number(eff.qty) || 0) + pendingQty + delta;
}

function cardFullName(it){
    return it.parentProductName
        ? it.parentProductName + ' > ' + (it.productName || '')
        : (it.productName || '');
}


function validatePRForm(){
    let errors = [];
    if (!($('#description').val() || '').trim()) errors.push('Description');
    const totalDetailCount = (existingPrDetailList ? existingPrDetailList.length : 0) + (prDetailCart ? prDetailCart.length : 0);
    if (totalDetailCount === 0) errors.push('Please add at least 1 Pr Detail');

    const hasSignature = $('#hasSignature').val() === 'true';
    if (!hasSignature) errors.push('ลายเซ็น (Signature)');

    if (!confirmed1) errors.push('ลงชื่อ ผู้ขอเบิก');

    // การ์ด PR-Detail ที่ยอดรวมเป็น 0 ห้าม submit
    const zeroItems = [];
    existingPrDetailList.forEach(function(it){
        if (getExistingCardTotalQty(it) <= 0) zeroItems.push(cardFullName(effectiveExisting(it)));
    });
    prDetailCart.forEach(function(it){
        if ((Number(it.qty) || 0) <= 0) zeroItems.push(cardFullName(it));
    });
    if (zeroItems.length > 0) errors.push('จำนวนต้องมากกว่า 0 (' + zeroItems.join(', ') + ')');

    return errors;
}

function submitPR(){
    const errors = validatePRForm();

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
        	prId: EDIT_PR_ID || '',
            description: $('#description').val().trim() || '',
            prDetailCartJson: JSON.stringify(buildCartPayload()),
            status: '2'
        };
        
        const fd = new FormData();
        Object.keys(payload).forEach(function (k) { fd.append(k, payload[k]); });
        if (typeof selectedFiles !== 'undefined') {
            selectedFiles.forEach(function (file) { fd.append('files', file, file.name); });
        }

        $('#savePRFormBtn').prop('disabled', true);

        $.ajax({
        	url: ctx + (EDIT_PR_ID ? '/update_pr' : '/save_pr'),
            type: 'POST',
            dataType: 'json',
            data: fd,
            processData: false,
            contentType: false,
            success: function (resp) {
                if (resp.data && resp.data.prId) {
                    clearDraftStorage();
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

function returnPR(){
    const reasonVal = validateReason();
    if (reasonVal === null) return;

    const errors = validatePRForm();

    Swal.fire({
        title: "Are you sure?!",
        text: "Do you want to return this PR?",
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
            prId: EDIT_PR_ID || '',
            reason: reasonVal,
            status: '4'
        };

        $('#returnPRBtn').prop('disabled', true);

        $.ajax({
            url: ctx + ('/update_status_pr'),
            type: 'POST',
            dataType: 'json',
            data: payload,
            success: function (resp) {
                if (resp.data && resp.data.prId) {
                    clearDraftStorage();
                    Swal.fire({
                        title: 'Success!',
                        text: 'Pr returned successfully!',
                        icon: 'success'
                    }).then(() => {
						location.reload();
                    });
                } else {
                    Swal.fire('Error', 'ไม่สามารถคืน PR ได้', 'error');
                }
            },
            error: function () {
                Swal.fire('Error', 'เกิดข้อผิดพลาดในการส่งข้อมูล', 'error');
            },
            complete: function(){
                $('#returnPRBtn').prop('disabled', false);
            }
        });
    });
}

function editPR(){
        const payload = {
            prId: EDIT_PR_ID || '',
            status: '1'
        };

        $('#returnPRBtn').prop('disabled', true);

        $.ajax({
            url: ctx + ('/update_status_pr'),
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
                $('#returnPRBtn').prop('disabled', false);
            }
        });
    // });
}


function rejectPR(){
    const reasonVal = validateReason();
    if (reasonVal === null) return;

    const errors = validatePRForm();

    Swal.fire({
        title: "Are you sure?!",
        text: "Do you want to reject this PR?",
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
            prId: EDIT_PR_ID || '',
            reason: reasonVal,
            status: '5'
        };

        $('#rejectPRBtn').prop('disabled', true);

        $.ajax({
            url: ctx + ('/update_status_pr'),
            type: 'POST',
            dataType: 'json',
            data: payload,
            success: function (resp) {
                if (resp.data && resp.data.prId) {
                    clearDraftStorage();
                    Swal.fire({
                        title: 'Success!',
                        text: 'Pr rejected successfully!',
                        icon: 'success'
                    }).then(() => {
                        location.reload();
                    });
                } else {
                    Swal.fire('Error', 'ไม่สามารถปฏิเสธ PR ได้', 'error');
                }
            },
            error: function () {
                Swal.fire('Error', 'เกิดข้อผิดพลาดในการส่งข้อมูล', 'error');
            },
            complete: function(){
                $('#rejectPRBtn').prop('disabled', false);
            }
        });
    });
}

function approvePR(){
	const reasonVal = validateReason();
    if (reasonVal === null) return;

    Swal.fire({
        title: "Are you sure?!",
        text: "Do you want to approve this PR?",
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
            prId: EDIT_PR_ID || '',
			reason: reasonVal,
            status: '3' 
        };

        $('#approvePRBtn').prop('disabled', true);

        $.ajax({
            url: ctx + '/update_status_pr',
            type: 'POST',
            dataType: 'json',
            data: payload,
            success: function (resp) {
                if (resp.data && resp.data.prId) {
                    clearDraftStorage();
                    Swal.fire({
                        title: 'Success!',
                        text: 'PR approved successfully!',
                        icon: 'success'
                    }).then(() => {
                        location.reload();
                        // window.location.href = ctx + '/purchase_requisition_list';
                    });
                } else {
                    Swal.fire('Error', 'ไม่สามารถอนุมัติ PR ได้', 'error');
                }
            },
            error: function () {
                Swal.fire('Error', 'เกิดข้อผิดพลาดในการส่งข้อมูล', 'error');
            },
            complete: function(){
                $('#approvePRBtn').prop('disabled', false);
            }
        });
    });
}

function inProgressPR(){
    Swal.fire({
        title: "Are you sure?!",
        text: "Do you want to in progress this PR?",
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
            prId: EDIT_PR_ID || '',
            status: '7' 
        };

        $('#inProgressPRFormBtn').prop('disabled', true);

        $.ajax({
            url: ctx + '/update_status_pr',
            type: 'POST',
            dataType: 'json',
            data: payload,
            success: function (resp) {
                if (resp.data && resp.data.prId) {
                    clearDraftStorage();
                    Swal.fire({
                        title: 'Success!',
                        text: 'PR in progress successfully!',
                        icon: 'success'
                    }).then(() => {
                        location.reload();
                        // window.location.href = ctx + '/purchase_requisition_list';
                    });
                } else {
                    Swal.fire('Error', 'ไม่สามารถอนุมัติ PR ได้', 'error');
                }
            },
            error: function () {
                Swal.fire('Error', 'เกิดข้อผิดพลาดในการส่งข้อมูล', 'error');
            },
            complete: function(){
                $('#inProgressPRFormBtn').prop('disabled', false);
            }
        });
    });
}

function cancelPR(){
    Swal.fire({
        title: "Are you sure?!",
        text: "Do you want to cancel this PR?",
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
            prId: EDIT_PR_ID || '',
            status: '6' 
        };

        $('#cancelFormBtn').prop('disabled', true);

        $.ajax({
            url: ctx + '/update_status_pr',
            type: 'POST',
            dataType: 'json',
            data: payload,
            success: function (resp) {
                if (resp.data && resp.data.prId) {
                    clearDraftStorage();
                    Swal.fire({
                        title: 'Success!',
                        text: 'PR cancel successfully!',
                        icon: 'success'
                    }).then(() => {
                        location.reload();
                        // window.location.href = ctx + '/purchase_requisition_list';
                    });
                } else {
                    Swal.fire('Error', 'ไม่สามารถลบ PR ได้', 'error');
                }
            },
            error: function () {
                Swal.fire('Error', 'เกิดข้อผิดพลาดในการส่งข้อมูล', 'error');
            },
            complete: function(){
                $('#cancelFormBtn').prop('disabled', false);
            }
        });
    });
}

</script>

</html>