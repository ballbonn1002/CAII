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

.pr-desc-clamp {
    display: -webkit-box;
    /* -webkit-line-clamp: 2; */
    -webkit-box-orient: vertical;
    overflow: hidden;
    /* word-break: break-word; */
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
						<span class="fs-1 fs-md-2x text-primary fw-bold" id="">#${prList.prId}</span>
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
										<div id="attachFileList" class="d-flex flex-column gap-3 gap-lg-5">
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

							<div class="card-toolbar">
								<a href="#" id="btnToggleSignature" class="pr-sig-toggle" role="button" aria-expanded="true">
									<i class="ki-duotone ki-down-square fs-2hx">
										<span class="path1"></span><span class="path2"></span>
									</i>
								</a>
							</div>
						</div>
						<div id="signatureCollapse" class="collapse show">
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
											<div class="col-12 col-md-6 p-6 p-md-16 m-0">
												<div class="d-flex flex-column align-items-center gap-3">
													<c:if test="${not empty imgPathSignature}">
														<img src="${pageContext.request.contextPath}${imgPathSignature}"
															class="img-fluid d-block mx-auto w-75" />
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
											<div class="col-12 col-md-6 p-6 p-md-16 m-0">
												<div class="d-flex flex-column align-items-center gap-3">
													<c:if test="${not empty imgPathApproveSignature}">
														<img src="${pageContext.request.contextPath}${imgPathApproveSignature}"
															class="img-fluid d-block mx-auto w-75" />
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
											<input type="number" class="form-control text-gray-700 h-45px" min="1" step="1"
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
											<label class="fw-medium text-gray-800 mb-2">URL Reference</label>
											<textarea class="form-control text-gray-700" rows="3"
													name="pr_ref_link" id="pr_ref_link" placeholder="https://..."></textarea>
											<div id="prRefLinkError" class="text-danger fs-8 mt-1"></div>
										</div>
									</div>
						        </div>
						
						        <div class="modal-footer">
						            <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
						            <button type="button" class="btn btn-success" id="btnSavePrDetail"
        									onclick="addPrDetailToCart()">
        									<span class="indicator-label">Save</span>
        									<span class="indicator-progress">Saving...
        									    <span class="spinner-border spinner-border-sm align-middle ms-2"></span>
        									</span>
        								</button>
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
					                <button type="button" class="btn btn-success" id="btnSubmitMr">
					                    <span class="indicator-label">Submit</span>
					                    <span class="indicator-progress">Saving...
					                        <span class="spinner-border spinner-border-sm align-middle ms-2"></span>
					                    </span>
					                </button>
					            </div>
					        </div>
					    </div>
					</div>

					<div class="modal fade" tabindex="-1" id="modal_edit_source">
						<div class="modal-dialog modal-dialog-centered">
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

									<div class="row g-5">
										<div class="col-12 d-flex flex-column">
											<label class="required fw-medium text-gray-800 mb-2">จำนวน</label>
											<input type="number" class="form-control text-gray-700 h-45px" min="1" step="1" id="edit_src_qty" />
										</div>
										<div class="col-12 d-flex flex-column">
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
									<button type="button" class="btn btn-success" id="btnUpdateSource" onclick="saveEditSource()">
										<span class="indicator-label">Update</span>
										<span class="indicator-progress">Updating...
										    <span class="spinner-border spinner-border-sm align-middle ms-2"></span>
										</span>
									</button>
								</div>
							</div>
						</div>
					</div>

					<div class="pr-action-bar d-flex flex-wrap justify-content-between gap-3">
						<div class="d-flex flex-wrap gap-3">
							<button type="button" id="backFormBtn" onclick="goBack()"
    							class="btn btn-lg btn-light fw-medium text-light-inverse px-6 py-4 border">Back
							</button>
							<c:if test="${prList.status == '1' or prList.status == '4'}">
								<button type="button" id="cancelFormBtn"
									onclick="cancelPR()"
									class="btn btn-lg btn-dark fw-medium px-6 py-4">
									<span class="indicator-label">Cancel</span>
									<span class="indicator-progress">Cancelling...
									    <span class="spinner-border spinner-border-sm align-middle ms-2"></span>
									</span>
								</button>
							</c:if>
						</div>
						<c:choose>
							<c:when test="${prList.status == '1'}">
								<div class="d-flex flex-wrap gap-3">
									<button type="button" id="saveDraft" onclick="saveDraftForm()"
										class="btn btn-lg btn-cyan text-white fw-medium px-6 py-4">
										<span class="indicator-label">Save Draft</span>
										<span class="indicator-progress">Saving...
										    <span class="spinner-border spinner-border-sm align-middle ms-2"></span>
										</span>
									</button>
									<button type="button" id="savePRFormBtn"
										class="btn btn-success text-white fw-medium px-6 py-4"
										onclick="submitPR()">
										<span class="indicator-label">Submit PR</span>
										<span class="indicator-progress">Submitting...
										    <span class="spinner-border spinner-border-sm align-middle ms-2"></span>
										</span>
									</button>
								</div>
							</c:when>

							<c:when test="${prList.status == '2'}">
									<div class="d-flex flex-wrap gap-3">
										<button type="button" id="returnPRBtn" onclick="returnPR()"
												class="btn btn-lg btn-info text-white fw-medium px-6 py-4">
												<span class="indicator-label">Return</span>
												<span class="indicator-progress">Returning...
												    <span class="spinner-border spinner-border-sm align-middle ms-2"></span>
												</span>
										</button>
										<button type="button" id="rejectPRBtn" onclick="rejectPR()"
												class="btn btn-lg btn-danger text-white fw-medium px-6 py-4">
												<span class="indicator-label">Reject</span>
												<span class="indicator-progress">Rejecting...
												    <span class="spinner-border spinner-border-sm align-middle ms-2"></span>
												</span>
										</button>
										<button type="button" id="approvePRBtn" onclick="approvePR()"
													class="btn btn-lg btn-success text-white fw-medium px-6 py-4">
													<span class="indicator-label">Approve</span>
													<span class="indicator-progress">Approving...
													    <span class="spinner-border spinner-border-sm align-middle ms-2"></span>
													</span>
										</button>
									</div>

							</c:when>

							<c:when test="${prList.status == '4'}">
								<div class="d-flex flex-wrap gap-3">
									<button type="button" id="editPRFormBtn"
										class="btn btn-lg btn-primary fw-medium px-6 py-4"
										onclick="editPR()">
										<span class="indicator-label">Edit</span>
										<span class="indicator-progress">Loading...
										    <span class="spinner-border spinner-border-sm align-middle ms-2"></span>
										</span>
									</button>
								</div>
							</c:when>

							<c:when test="${prList.status == '3'}">
								<div class="d-flex flex-wrap gap-3">
									<button type="button" id="inProgressPRFormBtn"
										class="btn btn-lg bg-cyan text-white fw-medium px-6 py-4"
										onclick="inProgressPR()">
										<span class="indicator-label">In-Progress</span>
										<span class="indicator-progress">Processing...
										    <span class="spinner-border spinner-border-sm align-middle ms-2"></span>
										</span>
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
			refLink: "${fn:replace(fn:replace(fn:replace(fn:replace(empty d.ref_link ? '' : d.ref_link, '\\', '\\\\'), '"', '\\"'), cr, ''), nl, '\\n')}",
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
				$('#pr_ref_link').removeClass('is-invalid');
				$('#prRefLinkError').text('');
		      setBtnLoading('#btnSavePrDetail', false);
		      if (!editingExistingDetailId) {
                    $('#items_type, #product_name').prop('disabled', false);
		            $('#items_type').val('equipment').trigger('change');
		            $('#pr_qty').val('1');
		            $('#unit').val('');
		            $('#pr_ref_link').val('');
		            $('#pr_description').val('');
		            $('#modal_create_pr .modal-title').text('Create PR - Detail');
		            $('#btnSavePrDetail .indicator-label').text('Save');
		            $('#prQtyUnitRow').removeClass('d-none');
		            $('#prRefLinkRow').removeClass('d-none');
		        } else {
                    $('#items_type, #product_name').prop('disabled', true);
		            $('#prQtyUnitRow').addClass('d-none');
		        }
		    });

		    createPrModalEl.addEventListener('shown.bs.modal', function () {
		        document.body.classList.add('modal-open');
		        document.body.style.overflow = 'hidden';
		        document.documentElement.style.overflow = 'hidden';
		    });

		    createPrModalEl.addEventListener('hidden.bs.modal', function () {
		        editingExistingDetailId = null;
                $('#items_type, #product_name').prop('disabled', false); 
		        document.querySelectorAll('.modal-backdrop').forEach(el => el.remove());
		        document.body.classList.remove('modal-open');
		        document.body.style.removeProperty('padding-right');
		        document.body.style.removeProperty('overflow');
		        document.documentElement.style.removeProperty('overflow');
		    });
		    
			const btnOpenCreatePr = document.getElementById('btnOpenCreatePr');
			if (btnOpenCreatePr) {
				btnOpenCreatePr.addEventListener('click', function () {
					editingExistingDetailId = null;
					bootstrap.Modal.getOrCreateInstance(createPrModalEl, { backdrop: true }).show();
				});
			}

			document.getElementById('modal_edit_source').addEventListener('hidden.bs.modal', function () {
				editingSrc = null;
			});
			document.getElementById('modal_edit_source').addEventListener('show.bs.modal', function () {
				setBtnLoading('#btnUpdateSource', false);
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
				setBtnLoading('#btnSubmitMr', false);
				loadInprogressMrDetail();
			});

			const btnOpenSearchMr = document.getElementById('btnOpenSearchMr');
			if (btnOpenSearchMr) {
				btnOpenSearchMr.addEventListener('click', function () {
					bootstrap.Modal.getOrCreateInstance(searchMrModalEl).show();
				});
			}

			document.getElementById('btnToggleSignature').addEventListener('click', function (e) {
				e.preventDefault();
				const collapseEl = document.getElementById('signatureCollapse');
				const icon = this.querySelector('i');
				const isOpen = collapseEl.classList.contains('show');

				collapseEl.classList.toggle('show', !isOpen);
				this.setAttribute('aria-expanded', String(!isOpen));
				icon.classList.toggle('ki-down-square', !isOpen);
				icon.classList.toggle('ki-up-square', isOpen);
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
                skipLeaveWarning = true;
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
					timer: 800,
					showConfirmButton: false
				}).then(() => {
                    skipLeaveWarning = true;
					location.reload();
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
function setBtnLoading(selector, loading){
    const el = document.querySelector(selector);
    if (!el) return;
    if (loading) {
        el.setAttribute('data-kt-indicator', 'on');
        el.disabled = true;
    } else {
        el.removeAttribute('data-kt-indicator');
        el.disabled = false;
    }
}

let existingPrDetailList = (typeof serverPrDetailCart !== 'undefined') ? serverPrDetailCart : []; // รายการเดิมที่มีอยู่แล้วใน DB (แก้/ลบผ่าน AJAX ทันที)
let editingExistingDetailId = null; // pr_detail_id ของรายการเดิมที่กำลังแก้ (ถ้ามี)
let confirmed1 = ${empty prList.signDate ? 'false' : 'true'}; //track ว่าลงชื่อ ผู้ขอเบิก แล้วหรือยัง

let skipLeaveWarning = false; //ตั้ง true ตอน Save/Submit/Back สำเร็จ เพื่อไม่ให้เตือน

let initialDescription = '';
const DESC_STASH_KEY = 'prDescStash_' + (EDIT_PR_ID || 'new');

function reloadPage(){
    skipLeaveWarning = true;
    const d = document.getElementById('description');
    try {
        if (d && d.value !== initialDescription) sessionStorage.setItem(DESC_STASH_KEY, d.value);
    } catch(e){}
    location.reload();
}

function ajaxAction(opts){
    if (opts.btn) setBtnLoading(opts.btn, true);
    $.ajax({
        url: ctx + opts.url, type: 'POST', dataType: 'json', data: opts.data,
        success: function(resp){
            if (resp.data && resp.data.success) {
                toastOk(opts.okMsg || 'บันทึกรายการสำเร็จ', reloadPage); // ปุ่มโหลดค้างจนกว่าจะ reload
            } else {
                toastFail(opts.failMsg || 'ไม่สามารถบันทึกรายการได้');
                if (opts.btn) setBtnLoading(opts.btn, false);
            }
        },
        error: function(){
            toastFail('เกิดข้อผิดพลาด');
            if (opts.btn) setBtnLoading(opts.btn, false);
        }
    });
}

function findExistingDetailByProduct(productId){
    return existingPrDetailList.find(function(it){ return String(it.productId) === String(productId); });
}

document.addEventListener('DOMContentLoaded', function(){
    renderPrDetailCart();
    const d = document.getElementById('description');
    if (!d) return;
    initialDescription = d.value;
    const nav = performance.getEntriesByType('navigation')[0];
    let stash = null;
    try { stash = sessionStorage.getItem(DESC_STASH_KEY); } catch(e){}
    if (stash !== null && nav && nav.type === 'reload') d.value = stash;
    try { sessionStorage.removeItem(DESC_STASH_KEY); } catch(e){}
});

function clearDraftStorage(){
    try { sessionStorage.removeItem(DESC_STASH_KEY); } catch(e){}
}

function hasUnsavedChanges(){
    if (!canEditPrDetail) return false; // เตือนเฉพาะ status = 1
    const d = document.getElementById('description');
    if (d && d.value !== initialDescription) return true;
    if (typeof selectedFiles !== 'undefined' && selectedFiles.length > 0) return true;
    return false;
}

function goBack(){
    if (hasUnsavedChanges()) {
        confirmLeaveForm('purchase_requisition_list');
    } else {
        skipLeaveWarning = true;
        clearDraftStorage();
        location.href = 'purchase_requisition_list';
    }
}

window.addEventListener('beforeunload', function(e){
    if (!canEditPrDetail || skipLeaveWarning || !hasUnsavedChanges()) return;
    e.preventDefault();
    e.returnValue = ''; // เบราว์เซอร์จะแสดงข้อความมาตรฐานของตัวเอง ปรับข้อความเองไม่ได้
});

function mapDbItemsTypeToSelect(val){
    switch(String(val)){
        case '1': return 'equipment';
        case '2': return 'consumables';
		case '3': return 'accessory';
        case '4': return 'office';
        default:  return val;
    }
}

// --- URL Reference ต้องเป็นลิงก์ (ปล่อยว่างได้) ---
function validateRefLinkField() {
    var $ta = $('#pr_ref_link');
    var text = ($ta.val() || '').trim();

    if (text !== '' && !/^https?:\/\/\S+$/i.test(text)) {
        $ta.addClass('is-invalid');
        $('#prRefLinkError').text('ต้องเป็นลิงก์ที่ขึ้นต้นด้วย http:// หรือ https:// เท่านั้น');
        return false;
    }
    $ta.removeClass('is-invalid');
    $('#prRefLinkError').text('');
    return true;
}

$(document.body).on('input blur', '#pr_ref_link', validateRefLinkField);

function validatePrDetailForm(){
    const errors = [];
    if (!editingExistingDetailId) {
        if (!$('#items_type').val()) errors.push('Category');
        if (!$('#product_name').val()) errors.push('Product Name');
        const qty = ($('#pr_qty').val() || '').trim();
        if (!qty || Number(qty) <= 0) errors.push('จำนวน');
        else if (!Number.isInteger(Number(qty))) errors.push('จำนวน (ต้องเป็นจำนวนเต็ม)');
        if (!$('#unit').val()) errors.push('Unit');
    }
    return errors;
}

function addPrDetailToCart(){
    const errors = validatePrDetailForm();
    if (errors.length > 0) {
        Swal.fire({
            title: 'Please complete the form!',
            html: "Please fill in the following fields:<br><strong>" + errors.join(", ") + "</strong>",
            icon: "error", confirmButtonText: "OK"
        });
        return;
    }

	 if (!validateRefLinkField()) {
        $('#pr_ref_link').trigger('focus');
        return;
    }

    const description = $('#pr_description').val();
    const refLink = $('#pr_ref_link').val().trim();

    // Edit: ใช้ productId เดิมจาก DB (select ถูก disable)
    if (editingExistingDetailId) {
        const orig = existingPrDetailList.find(function(d){
            return String(d.prDetailId) === String(editingExistingDetailId);
        });
        if (!orig) return;
        ajaxAction({
            url: '/update_pr_detail',
            data: { prId: EDIT_PR_ID, prDetailId: orig.prDetailId, productId: orig.productId,
                    description: description, refLink: refLink },
            btn: '#btnSavePrDetail',
            okMsg: 'แก้ไขรายการสำเร็จ', failMsg: 'ไม่สามารถแก้ไขรายการได้'
        });
        return;
    }

    // Create
    const rawQty = Number($('#pr_qty').val()) || 0;
    const rawUnitId = $('#unit').val();
    const rate = Number($('#unit option:selected').data('conversion-rate')) || 1;
    const baseUnitId = $('#unit').data('base-unit-id') || rawUnitId;
    const baseQty = rawQty * rate;
    const productId = $('#product_name').val();
    const ex = findExistingDetailByProduct(productId);

    const item = {
        prDetailId: ex ? ex.prDetailId : '',
        productId: productId,
        itemsType: $('#items_type').val(),
        unit: baseUnitId,
        description: description,
        refLink: refLink,
        qty: baseQty,
        sources: [{ mrId: null, qty: rawQty, unit: rawUnitId, baseQty: baseQty,
                    refLink: refLink, description: description }]
    };

    ajaxAction({
        url: '/add_pr_detail',
        data: { prId: EDIT_PR_ID, prDetailCartJson: JSON.stringify([item]) },
        btn: '#btnSavePrDetail',
        okMsg: 'เพิ่มรายการสำเร็จ', failMsg: 'ไม่สามารถเพิ่มรายการได้'
    });
}

function updateInProgressCount(){
    const countEl = document.getElementById('prInProgressCount');
    const totalEl = document.getElementById('prInProgressTotal');
    if (!countEl || !totalEl) return; //แค่status = 7

    const total = existingPrDetailList.length; // จำนวน PR-Detail ทั้งหมด
    const approvedCount = existingPrDetailList.filter(function(item){
        return item.status == 1;
    }).length;

    countEl.textContent = approvedCount;
    totalEl.textContent = total;
}
function renderPrDetailCart(){

    let html = "";

    existingPrDetailList.forEach(function(item){

        html += createPrCard(item, null, item.prDetailId);

    });
    const totalCount = existingPrDetailList.length;

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
    const displayQty = Number(item.qty) || 0;
    const allSources = item.sources || [];

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
		
	// const descriptionHtml = item.description
    //     ? '<div class="d-flex align-items-center">'
    //         + '<i class="ki-duotone ki-document fs-2 text-muted me-2">'
    //             + '<span class="path1"></span><span class="path2"></span>'
    //         + '</i>'
    //         + '<span class="text-gray-900 fs-5 fw-normal">' + item.description + '</span>'
    //     + '</div>'
    //     : '';

	const descriptionHtml = item.description
		? '<i class="ki-duotone ki-document fs-2 text-muted me-2 flex-shrink-0">'
			+ '<span class="path1"></span><span class="path2"></span>'
		+ '</i>'
		+ '<span class="text-gray-900 fs-5 fw-normal pr-desc-clamp">' + item.description + '</span>'
		: '';

    const headerRefLink = item.refLink || '';
    const headerRefLinkHtml = headerRefLink ? `
		<a href="\${headerRefLink}" target="_blank" rel="noopener" class="text-primary d-inline-flex ms-2 flex-shrink-0" onclick="event.stopPropagation();" title="URL Reference">
			<i class="ki-duotone ki-fasten fs-2 text-primary"><span class="path1"></span><span class="path2"></span></i>
		</a>` : '';
	const hasDesc = !!item.description;
	// ไม่มี description แต่มีลิงก์
	const inlineLinkHtml = (!hasDesc && headerRefLink) ? headerRefLinkHtml : '';
	const descRowHtml = hasDesc
		? '<div class="d-flex align-items-start ps-9 mt-3">' + descriptionHtml + headerRefLinkHtml + '</div>'
		: '';

    let actionButtons = '';
        if (canEditPrDetail) {
            actionButtons = `<a href="#" onclick="return editExistingCartItem('\${prDetailId}');" class="btn btn-icon btn-light-primary btn-sm" title="Edit">
                    <i class="ki-duotone ki-pencil fs-2"><span class="path1"></span><span class="path2"></span></i>
                </a>
                <a href="#" onclick="return removeExistingCartItem('\${prDetailId}');" class="btn btn-icon btn-light-danger btn-sm" title="Delete">
                    <i class="ki-duotone ki-trash fs-2"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i>
                </a>`;
        }

      return `<div class="pr-item-group border-gray-400 border-bottom pt-9 pb-6 px-6">
    			<div class="row g-3 align-items-center flex-nowrap">
    				<div class="col" style="min-width:0;">
						<div class="d-flex flex-wrap align-items-center">\${icon}
							<span class="text-gray-900 fs-5 fw-normal me-3">\${category}</span>
							<span class="text-gray-900 fs-5 fw-normal me-3">\${displayProductName}</span>
							\${inlineLinkHtml}
						</div>
						\${descRowHtml}
					</div>

					<div class="col-auto d-flex align-items-center justify-content-end gap-8 ">
						<div class="d-flex flex-column text-end min-w-80px">
							<span class="fs-6 fw-normal text-gray-900">\${item.unitName}</span>
							<span class="fw-semibold text-gray-800 fs-5">\${displayQty}</span>
						</div>

						<div class="d-flex align-items-center justify-content-end gap-2 min-w-200px">
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
				</div>
			
			<div class="collapse border-gray-300 border-top mt-3" id="prGroup_\${groupId}">
	            <div class="ps-9 pt-9">
	                \${
						allSources.length > 0
                            ? allSources.map(function(s, i){
								var srcBaseQty = (s.baseQty != null) ? s.baseQty : s.qty;
								var srcBaseQty = (s.baseQty != null) ? s.baseQty : s.qty;
                                var rowRefLink = s.mrId ? s.refLink : '';
                                var menuCtx = canEditPrDetail ? { scope: 'db', a: prDetailId, b: i } : null;
                                return createPrSourceRow(s.qty, s.unitName || item.unitName, srcBaseQty, item.unitName,
                                                        s.savedAt, s.mrId, rowRefLink, s.creatorName, false, menuCtx);
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

// function createPrSourceRow(qty, unitName, baseQty, baseUnitName, savedAt, mrId, refLink, creatorName, isNew, menuCtx){
//     const qtyUnitDisplay = qty + ' ' + unitName + ' (= ' + baseQty + ' ' + baseUnitName + ')';

//     const menuHtml = menuCtx ? `
//             <div class="pr-src-menu position-relative d-inline-block flex-shrink-0">
//                 <a href="#" class="btn btn-icon btn-sm btn-light-primary w-30px h-30px"
//                    onclick="return toggleSrcMenu(this, event);" aria-label="More actions" aria-haspopup="true">
//                     <i class="ki-outline ki-dots-horizontal fs-2"></i>
//                 </a>

//                 <div class="pr-src-actions position-absolute end-0 top-100 mt-2 bg-body rounded-3 shadow z-index-3">
//                     <div class="py-2">
//                         <a href="#" class="pr-src-item d-block px-6 py-3 fs-6 fw-normal text-gray-800 bg-hover-light"
//                            onclick="event.stopPropagation(); return editSource('\${menuCtx.scope}', '\${menuCtx.a}', \${menuCtx.b});">Edit</a>
//                         <a href="#" class="pr-src-item d-block px-6 py-3 fs-6 fw-normal text-gray-800 bg-hover-light"
//                            onclick="event.stopPropagation(); return removeSource('\${menuCtx.scope}', '\${menuCtx.a}', \${menuCtx.b});">Delete</a>
//                     </div>
//                 </div>
//             </div>` : '';

//     return `
//     <div class="pr-src-row row g-2 align-items-center mb-4 py-2">
//         <div class="col-12 col-xl-9">
//             <div class="row g-2 align-items-center fs-7">
//                 <div class="col-12 col-md-4">
//                     <i class="ki-duotone ki-user-tick fs-3 text-muted me-2"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i>
//                     <span class="text-gray-800 fs-5 fw-normal">\${creatorName || currentUserDisplay}</span>
//                 </div>
//                 <div class="col-12 col-md-4 d-flex align-items-center">
//                     <i class="ki-duotone ki-calendar-2 fs-3 me-2"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i>
//                     <span class="text-gray-800 fs-5 fw-normal">\${savedAt}</span>
//                 </div>
//                 <div class="col-12 col-md-4 d-flex align-items-center gap-2">
//                     <i class="ki-duotone ki-tablet-book fs-3 flex-shrink-0"><span class="path1"></span><span class="path2"></span></i>
//                     <div class="d-flex flex-wrap align-items-center gap-2">\${createMrBadge(mrId, refLink)}</div>
//                 </div>
//             </div>
//         </div>

//         <div class="col-12 col-xl-3 d-flex align-items-center justify-content-between justify-content-xl-end gap-3">
//             <span class="text-gray-800 fs-5 fw-normal">\${qtyUnitDisplay}</span>
//             \${menuHtml}
//         </div>
//     </div>`;
// }

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
    <div class="pr-src-row d-flex align-items-center justify-content-between gap-3 mb-4 py-2">

        <div class="flex-grow-1 overflow-hidden">
            <div class="row g-2 fs-7">
                <div class="col-12 col-xl-4 d-flex align-items-center">
                    <i class="ki-duotone ki-user-tick fs-3 text-muted me-2 flex-shrink-0"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i>
                    <span class="text-gray-800 fs-5 fw-normal text-break">\${creatorName || currentUserDisplay}</span>
                </div>
                <div class="col-12 col-xl-4 d-flex align-items-center">
                    <i class="ki-duotone ki-calendar-2 fs-3 me-2 flex-shrink-0"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i>
                    <span class="text-gray-800 fs-5 fw-normal">\${savedAt}</span>
                </div>
                <div class="col-12 col-xl-4 d-flex align-items-center gap-2">
                    <i class="ki-duotone ki-tablet-book fs-3 flex-shrink-0"><span class="path1"></span><span class="path2"></span></i>
                    <div class="d-flex flex-wrap align-items-center gap-2">\${createMrBadge(mrId, refLink)}</div>
                </div>
            </div>
        </div>

        <div class="d-flex align-items-center justify-content-end gap-3">
            <span class="text-gray-800 fs-5 fw-normal text-end">\${qtyUnitDisplay}</span>
            \${menuHtml}
        </div>
    </div>`;
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

function resolveSrc(scope, a, b){
    const item = existingPrDetailList.find(function(it){ return String(it.prDetailId) === String(a); });
    const list = item && item.sources;
    return { item: item, list: list, src: list && list[b] };
}

function removeSource(scope, a, b){
    closeAllSrcMenus();
    const r = resolveSrc(scope, a, b);
    if (!r.item || !r.src) return false;
    const isLast = r.list.length <= 1;

    Swal.fire({
        title: "ยืนยันการลบ?!",
        text: "รายการนี้จะถูกลบออกจากฐานข้อมูล และไม่สามารถกู้คืนได้",
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "ยืนยัน",
        cancelButtonText: "ยกเลิก",
        buttonsStyling: false,
        customClass: { confirmButton: "btn btn-danger", cancelButton: "btn btn-secondary" }
    }).then(function(result){
        if (!result.isConfirmed) return;
        if (isLast) {
            ajaxAction({ url: '/delete_pr_detail',
                data: { prDetailId: a, prId: EDIT_PR_ID },
                okMsg: 'ลบรายการสำเร็จ', failMsg: 'ไม่สามารถลบรายการได้' });
        } else {
            ajaxAction({ url: '/delete_pr_source',
                data: { prParentId: r.src.prParentId, prDetailId: a, prId: EDIT_PR_ID, keepDetail: 'false' },
                okMsg: 'ลบรายการสำเร็จ', failMsg: 'ไม่สามารถลบรายการได้' });
        }
    });
    return false;
}

let editingSrc = null;

function editSource(scope, a, b){
    closeAllSrcMenus();
    const r = resolveSrc(scope, a, b);
    if (!r.item || !r.src) return false;
    const item = r.item, src = r.src;

    const fullName = item.parentProductName
        ? item.parentProductName + ' > ' + (item.productName || '')
        : (item.productName || '');

    // แถวจาก MR โยนชื่อไป Search MR
    if (src.mrId) {
        openSearchMrWithKeyword(fullName);
        return false;
    }

    // แถวสร้างเอง เปิด modal_edit_source
    editingSrc = { scope: scope, a: a, b: b };
    const baseQty = (src.baseQty != null) ? src.baseQty : src.qty;
    const cat = getCategoryIcon(mapSelectToDbItemsType(item.itemsType));

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

$(document.body).on('keydown', '#pr_qty, #edit_src_qty', function(e){
    if (['.', ',', 'e', 'E', '+', '-'].indexOf(e.key) !== -1) e.preventDefault();
});

function saveEditSource(){
    if (!editingSrc) return;

    const qty = Number($('#edit_src_qty').val()) || 0;
    const unitId = $('#edit_src_unit').val();
    const errors = [];
    if (qty <= 0) errors.push('จำนวน');
    else if (!Number.isInteger(qty)) errors.push('จำนวน (ต้องเป็นจำนวนเต็ม)');
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

    ajaxAction({
        url: '/update_pr_source',
        data: { prId: EDIT_PR_ID, prDetailId: editingSrc.a, prParentId: r.src.prParentId, qty: qty, unit: unitId },
        btn: '#btnUpdateSource',
        okMsg: 'แก้ไขรายการสำเร็จ', failMsg: 'ไม่สามารถแก้ไขรายการได้'
    });
}

/* ──────── แก้ไข / ลบ รายการที่มีอยู่แล้วใน DB ──────── */
function editExistingCartItem(prDetailId){
    const item = existingPrDetailList.find(function(d){ return String(d.prDetailId) === String(prDetailId); });
    if (!item) return false;

    editingExistingDetailId = prDetailId;

    $('#modal_create_pr .modal-title').text('Edit PR - Detail');
    $('#btnSavePrDetail .indicator-label').text('Update');

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
    $('#pr_ref_link').val(item.refLink || '');

    const modalEl = document.getElementById("modal_create_pr");
    const modal = bootstrap.Modal.getOrCreateInstance(modalEl);
    modal.show();

    return false;
}

function removeExistingCartItem(prDetailId){
    Swal.fire({
        title: "ยืนยันการลบ?!",
        text: "รายการนี้จะถูกลบออกจากฐานข้อมูล และไม่สามารถกู้คืนได้",
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "ยืนยัน",
        cancelButtonText: "ยกเลิก",
        buttonsStyling: false,
        customClass: {
            confirmButton: "btn btn-danger",
            cancelButton: "btn btn-secondary"
        }
    }).then((result) => {
        if (result.isConfirmed) {
            ajaxAction({ 
                url: '/delete_pr_detail', 
                data: { prDetailId: prDetailId, prId: EDIT_PR_ID },
                okMsg: 'ลบรายการสำเร็จ', failMsg: 'ไม่สามารถลบรายการได้' });
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

function toastFail(msg, after){
    Swal.fire({ toast: true, position: 'top-end', icon: 'error',
        title: msg || 'บันทึกไม่สำเร็จ', showConfirmButton: false, timer: 1200 })
    .then(function(){ if (after) after(); });
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
        data: { prId: EDIT_PR_ID },
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

function renderMrResultTable(fullList){
    var tbody = document.getElementById('mrResultBody');
    var html = '';

    var list = fullList || [];

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
        var isPulled = !!item.pr_parent_id;

        html += `
        <tr class="fw-semibold fs-6 text-gray-800 border-bottom border-gray-200">
            <td>
                <div class="form-check form-check-sm">
                    <input class="form-check-input mr-row-check" type="checkbox"
                        data-mr-detail-id="\${item.mr_id}"
                        data-pulled="\${isPulled ? '1' : '0'}"
                        data-pr-detail-id="\${item.pr_detail_id || ''}"
                        data-pr-parent-id="\${item.pr_parent_id || ''}"
                        \${isPulled ? ' checked' : ''} />
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

    if (pendingMrKeyword !== null) {
        $('#searchMrKeyword').val(pendingMrKeyword);
        mrDetailTable.search(pendingMrKeyword).draw();
        pendingMrKeyword = null;
    }

	var checkAll = document.getElementById('checkAllMr');

	document.querySelectorAll('.mr-row-check').forEach(function (cb) {
		cb.addEventListener('change', refreshMrCheckState);
	});

	checkAll.onchange = function(){
		var checked = this.checked;
		document.querySelectorAll('.mr-row-check').forEach(function(cb){ cb.checked = checked; });
		refreshMrCheckState();
	};

	refreshMrCheckState();
}

function refreshMrCheckState(){
    var boxes = document.querySelectorAll('.mr-row-check');
    var checked = document.querySelectorAll('.mr-row-check:checked').length;
    document.getElementById('mrSelectedCount').textContent = checked;

    var checkAll = document.getElementById('checkAllMr');
    if (checkAll) checkAll.checked = boxes.length > 0 && checked === boxes.length;
}

function updateMrSelectedCountReal(){
    refreshMrCheckState();
}

function buildAddItems(addIds){
    var groups = {}; // productId -> item
    addIds.forEach(function(mrId){
        var src = inprogressMrDetailList.find(function(d){ return String(d.mr_id) === String(mrId); });
        if (!src) return;

        var productId = src.product_id;
        var qty = Number(src.amount_total) || 0;

        if (!groups[productId]) {
            var existing = findExistingDetailByProduct(productId);
            groups[productId] = {
                prDetailId: existing ? existing.prDetailId : '',
                productId: productId,
                itemsType: mapDbItemsTypeToSelect(src.product_type),
                unit: src.unit,
                description: '',
                refLink: '',
                qty: 0,
                sources: []
            };
        }

        groups[productId].qty += qty;
        groups[productId].sources.push({
            mrId: src.mr_id,
            qty: qty, unit: src.unit,
            baseQty: qty, // MR เก็บเป็นหน่วยเล็กสุดอยู่แล้ว
            refLink: src.ref_link || '',
            description: src.description || ''
        });
    });
    return Object.keys(groups).map(function(k){ return groups[k]; });
}

function runSubmitMr(removeCbs, addIds){
    setBtnLoading('#btnSubmitMr', true);

    var removeList = removeCbs.map(function(cb){
        return { prDetailId: cb.getAttribute('data-pr-detail-id'), prParentId: cb.getAttribute('data-pr-parent-id') };
    });

    function fail(){
        toastFail('ไม่สามารถบันทึกรายการได้', function(){
            setBtnLoading('#btnSubmitMr', false);
            reloadPage();
        });
    }

    function finishRemoves(){
        if (addIds.length === 0) { toastOk('บันทึกรายการสำเร็จ', reloadPage); return; }
        var items = buildAddItems(addIds);
        if (items.length === 0) { toastOk('บันทึกรายการสำเร็จ', reloadPage); return; }
        ajaxAction({
            url: '/add_pr_detail',
            data: { prId: EDIT_PR_ID, prDetailCartJson: JSON.stringify(items) },
            btn: '#btnSubmitMr',
            okMsg: 'บันทึกรายการสำเร็จ', failMsg: 'ไม่สามารถบันทึกรายการได้'
        });
    }

    // ลบทีละรายการ เพราะการ์ดเดียวกันอาจมีหลายแถวถูกถอด ต้องคำนวณ isLast ใหม่ทุกรอบ
    function doRemoves(i){
        if (i >= removeList.length) { finishRemoves(); return; }
        var r = removeList[i];
        var item = existingPrDetailList.find(function(d){ return String(d.prDetailId) === String(r.prDetailId); });
        var isLast = !item || (item.sources || []).length <= 1;
        var url = isLast ? '/delete_pr_detail' : '/delete_pr_source';
        var data = isLast
            ? { prDetailId: r.prDetailId, prId: EDIT_PR_ID }
            : { prParentId: r.prParentId, prDetailId: r.prDetailId, prId: EDIT_PR_ID, keepDetail: 'false' };

        $.ajax({
            url: ctx + url, type: 'POST', dataType: 'json', data: data,
            success: function(resp){
                if (!resp.data || !resp.data.success) { fail(); return; }

                // อัปเดต existingPrDetailList ใน memory ให้ตรงกับ DB (ไม่ render ตรงนี้ รอ reloadPage)
                if (item) {
                    var srcIdx = (item.sources || []).findIndex(function(s){ return String(s.prParentId) === String(r.prParentId); });
                    if (srcIdx !== -1) {
                        var removed = item.sources[srcIdx];
                        var removedBaseQty = Number(removed.baseQty != null ? removed.baseQty : removed.qty) || 0;
                        item.sources.splice(srcIdx, 1);
                        item.qty = Math.max(0, (Number(item.qty) || 0) - removedBaseQty);
                    }
                    if (item.sources.length === 0) {
                        var idx = existingPrDetailList.indexOf(item);
                        if (idx !== -1) existingPrDetailList.splice(idx, 1);
                    }
                }

                doRemoves(i + 1);
            },
            error: fail
        });
    }

    doRemoves(0);
}

document.getElementById('btnSubmitMr').addEventListener('click', function(){
    var removeCbs = Array.prototype.slice.call(
        document.querySelectorAll('.mr-row-check[data-pulled="1"]:not(:checked)'));
    var addIds = [];
    document.querySelectorAll('.mr-row-check:checked:not([data-pulled="1"])').forEach(function(cb){
        addIds.push(cb.getAttribute('data-mr-detail-id'));
    });

    if (removeCbs.length === 0 && addIds.length === 0) {
        if (document.activeElement) document.activeElement.blur();
        bootstrap.Modal.getOrCreateInstance(document.getElementById('modal_search_mr')).hide();
        return;
    }

    runSubmitMr(removeCbs, addIds);
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

function saveDraftForm(){
    const payload = {
		prId: EDIT_PR_ID || '',
        description: $('#description').val() || ''
    };
    const fd = new FormData();
    Object.keys(payload).forEach(function (k) { fd.append(k, payload[k]); });
    if (typeof selectedFiles !== 'undefined') {
        selectedFiles.forEach(function (file) { fd.append('files', file, file.name); });
    }
    
 	setBtnLoading('#saveDraft', true);

    $.ajax({
    	url: ctx + (EDIT_PR_ID ? '/update_pr' : '/save_pr'),
        type: 'POST',
        dataType: 'json',
        data: fd,
        processData: false,
        contentType: false,
        success: function (resp) {
            if (resp.data && resp.data.prId) {
                skipLeaveWarning = true;
                clearDraftStorage();
                Swal.fire({ title: 'Success!', 
				text: 'Pr saved draft successfully!', 
				icon: 'success',
				timer: 800,
				showConfirmButton: false
			})
        
			.then(() => { window.location.href = ctx + '/purchase_requisition_list'; });
            } else {
                setBtnLoading('#saveDraft', false);
                Swal.fire('Error', 'ไม่สามารถบันทึก Draft ได้', 'error');
            }
        },
        error: function () {
            setBtnLoading('#saveDraft', false);
            Swal.fire('Error', 'เกิดข้อผิดพลาดในการบันทึก', 'error');
        }
    });
}

function cardFullName(it){
    return it.parentProductName
        ? it.parentProductName + ' > ' + (it.productName || '')
        : (it.productName || '');
}


function validatePRForm(){
    let errors = [];
    if (!($('#description').val() || '').trim()) errors.push('Description');
    const totalDetailCount = existingPrDetailList ? existingPrDetailList.length : 0;
    if (totalDetailCount === 0) errors.push('Please add at least 1 Pr Detail');

    const hasSignature = $('#hasSignature').val() === 'true';
    if (!hasSignature) errors.push('ลายเซ็น (Signature)');

    if (!confirmed1) errors.push('ลงชื่อ ผู้ขอเบิก');

    // การ์ด PR-Detail ที่ยอดรวมเป็น 0 ห้าม submit
    const zeroItems = [];
    existingPrDetailList.forEach(function(it){
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
            status: '2'
        };
        
        const fd = new FormData();
        Object.keys(payload).forEach(function (k) { fd.append(k, payload[k]); });
        if (typeof selectedFiles !== 'undefined') {
            selectedFiles.forEach(function (file) { fd.append('files', file, file.name); });
        }

        setBtnLoading('#savePRFormBtn', true);

        $.ajax({
        	url: ctx + (EDIT_PR_ID ? '/update_pr' : '/save_pr'),
            type: 'POST',
            dataType: 'json',
            data: fd,
            processData: false,
            contentType: false,
            success: function (resp) {
                if (resp.data && resp.data.prId) {
                    skipLeaveWarning = true;
                    clearDraftStorage();
                    Swal.fire({
                        title: 'Success!',
                        text: 'Pr saved successfully!', 
						icon: 'success',
						timer: 800,
						showConfirmButton: false
                    }).then(() => {
                        window.location.href = ctx + '/purchase_requisition_list';
                    });
                } else {
                    setBtnLoading('#savePRFormBtn', false);
                    Swal.fire('Error', 'ไม่สามารถส่ง PR ได้', 'error');
                }
            },
            error: function () {
                setBtnLoading('#savePRFormBtn', false);
                Swal.fire('Error', 'เกิดข้อผิดพลาดในการส่งข้อมูล', 'error');
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

        setBtnLoading('#returnPRBtn', true);

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
						icon: 'success',
						timer: 800,
						showConfirmButton: false
                    }).then(() => {
                        skipLeaveWarning = true;
						location.reload();
                    });
                } else {
                    setBtnLoading('#returnPRBtn', false);
                    Swal.fire('Error', 'ไม่สามารถคืน PR ได้', 'error');
                }
            },
            error: function () {
                setBtnLoading('#returnPRBtn', false);
                Swal.fire('Error', 'เกิดข้อผิดพลาดในการส่งข้อมูล', 'error');
            }
        });
    });
}

function editPR(){
        const payload = {
            prId: EDIT_PR_ID || '',
            status: '1'
        };

        setBtnLoading('#editPRFormBtn', true);

        $.ajax({
            url: ctx + ('/update_status_pr'),
            type: 'POST',
            dataType: 'json',
            data: payload,
            success: function (resp) {
                skipLeaveWarning = true;
                location.reload();
            },
            error: function () {
                setBtnLoading('#editPRFormBtn', false);
                Swal.fire('Error', 'เกิดข้อผิดพลาดในการส่งข้อมูล', 'error');
            }
        });
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

        setBtnLoading('#rejectPRBtn', true);

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
						icon: 'success',
						timer: 800,
						showConfirmButton: false
                    }).then(() => {
                        skipLeaveWarning = true;
                        location.reload();
                    });
                } else {
                    setBtnLoading('#rejectPRBtn', false);
                    Swal.fire('Error', 'ไม่สามารถปฏิเสธ PR ได้', 'error');
                }
            },
            error: function () {
                setBtnLoading('#rejectPRBtn', false);
                Swal.fire('Error', 'เกิดข้อผิดพลาดในการส่งข้อมูล', 'error');
            }
        });
    });
}

function approvePR(){
	const reasonVal = ($('#reason').val() || '').trim();

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

        setBtnLoading('#approvePRBtn', true);

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
						icon: 'success',
						timer: 800,
						showConfirmButton: false
                    }).then(() => {
                        skipLeaveWarning = true;
                        location.reload();
                    });
                } else {
                    setBtnLoading('#approvePRBtn', false);
                    Swal.fire('Error', 'ไม่สามารถอนุมัติ PR ได้', 'error');
                }
            },
            error: function () {
                setBtnLoading('#approvePRBtn', false);
                Swal.fire('Error', 'เกิดข้อผิดพลาดในการส่งข้อมูล', 'error');
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

        setBtnLoading('#inProgressPRFormBtn', true);

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
						icon: 'success',
						timer: 800,
						showConfirmButton: false
                    }).then(() => {
                        skipLeaveWarning = true;
                        location.reload();
                    });
                } else {
                    setBtnLoading('#inProgressPRFormBtn', false);
                    Swal.fire('Error', 'ไม่สามารถอนุมัติ PR ได้', 'error');
                }
            },
            error: function () {
                setBtnLoading('#inProgressPRFormBtn', false);
                Swal.fire('Error', 'เกิดข้อผิดพลาดในการส่งข้อมูล', 'error');
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
        confirmButtonText: "Yes, cancel it",
        cancelButtonText: "Close",
        buttonsStyling: false,
        customClass: { confirmButton: "btn btn-danger", cancelButton: "btn btn-secondary" }
    }).then((result) => {
        if (!result.isConfirmed) return;

        const payload = {
            prId: EDIT_PR_ID || '',
            status: '6' 
        };

        setBtnLoading('#cancelFormBtn', true);

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
						icon: 'success',
						timer: 800,
						showConfirmButton: false
                    }).then(() => {
                        skipLeaveWarning = true;
                        location.reload();
                    });
                } else {
                    setBtnLoading('#cancelFormBtn', false);
                    Swal.fire('Error', 'ไม่สามารถลบ PR ได้', 'error');
                }
            },
            error: function () {
                setBtnLoading('#cancelFormBtn', false);
                Swal.fire('Error', 'เกิดข้อผิดพลาดในการส่งข้อมูล', 'error');
            }
        });
    });
}

</script>

</html>