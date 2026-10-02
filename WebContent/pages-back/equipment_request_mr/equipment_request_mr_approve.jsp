<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
<script
	src="${pageContext.request.contextPath}/assets/js/custom/utilities/attachFile/attcahfile.js"></script>

<style>
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
							Equipment Request
						</h1>
						<ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
							<li class="breadcrumb-item text-muted"><a class="text-muted text-hover-primary">Home</a></li>
							<li class="breadcrumb-item"><span class="bullet bg-gray-500 w-5px h-2px"></span></li>
							<li class="breadcrumb-item text-muted"><a class="text-muted text-hover-primary">Product</a></li>
						</ul>
					</div>

					<div class="d-flex align-items-center gap-4">
						<span class="fs-2hx fw-bold text-primary">#<c:out value="${mr.mrId}" /></span>
						<span class="badge badge-lg badge-${mrStatus.color} fw-semibold fs-7 p-4 ${mrStatus.color == 'secondary' ? 'text-dark' : 'text-white'}">
							<c:out value="${empty mrStatus ? '-' : mrStatus.statusName}" />
						</span>
					</div>
					
				</div>
			</div>

			<div id="kt_app_content" class="app-content flex-column-fluid">
				<div id="kt_app_content_container" class="app-container container-fluid">
				
				<c:choose>
					<c:when test="${mrStatus.statusCode == '2' || mrStatus.statusCode == '3' || mrStatus.statusCode == '4' || mrStatus.statusCode == '5'}">
						<div class="card mb-10">
							<div class="card-header border-0 px-9 pt-7 d-flex align-items-center">
								<div class="card-title">
									<h3 class="fw-semibold text-gray-900">Equipment Request  - Detail</h3>
								</div>
							</div>
							<div class="card-body px-9 py-9">
								<div class="row g-8">
									<div class="col-6">
										<div class="d-flex align-items-center">
											<div class="symbol symbol-45px symbol-circle me-5 flex-shrink-0">
												<c:choose>
													<c:when test="${not empty loginUser.path}">
														<img src="${pageContext.request.contextPath}${loginUser.path}"
															alt="<c:out value='${loginUser.nameEN}' />" class="object-fit-cover" />
													</c:when>
													<c:otherwise>
														<span class="symbol-label bg-light-primary text-primary fw-bold fs-4">
															<c:out value="${empty loginUser.nameEN ? '?' : fn:toUpperCase(fn:substring(loginUser.nameEN, 0, 1))}" />
														</span>
													</c:otherwise>
												</c:choose>
											</div>

											<div class="d-flex flex-column">
												<span class="text-gray-900 fs-6 fw-normal mb-3">
													<c:out value="${loginUser.employeeId}" /> - <c:out value="${loginUser.nameEN}" />
												</span>
												<span class="text-gray-900 fs-6 fw-normal">
													<fmt:formatDate value="${mr.requestDate}" pattern="d MMM yyyy, HH:mm" />
												</span>
											</div>

										</div>
										
									</div>
									<div class="col-6">
										<div class="row"> 
											<div class="d-flex align-items-center flex-wrap mb-6">
												<c:if test="${not empty mrItemType}">
													<span class="d-flex align-items-center fw-medium text-gray-800 ">
														<div class="symbol symbol-40px d-flex align-items-center">
															<c:if test="${mrItemType == '1'}">
																<i class="ki-duotone ki-monitor-mobile fs-2 text-primary me-2">
																	<span class="path1"></span><span class="path2"></span>
																</i><span>Equipment</span>
															</c:if>
															<c:if test="${mrItemType == '2'}">
																<i class="ki-duotone ki-lots-shopping fs-2 text-orange me-2">
																	<span class="path1"></span><span class="path2"></span>
																	<span class="path3"></span><span class="path4"></span>
																	<span class="path5"></span><span class="path6"></span>
																	<span class="path7"></span><span class="path8"></span>
																</i><span>Consumables</span>
															</c:if>
															<c:if test="${mrItemType == '3'}">
																<i class="ki-duotone ki-medal-star fs-2 text-teal me-2">
																	<span class="path1"></span><span class="path2"></span>
																	<span class="path3"></span><span class="path4"></span>
																</i><span>Accessory</span>
															</c:if>
															<c:if test="${mrItemType == '4'}">
																<i class="ki-duotone ki-parcel fs-2 text-success me-2">
																	<span class="path1"></span><span class="path2"></span>
																	<span class="path3"></span><span class="path4"></span>
																	<span class="path5"></span>
																</i><span>Office Supplies</span>
															</c:if>
														</div>
													</span>
												</c:if>
												
												<i class="ki-duotone ki-black-right mx-2 text-gray-500 fs-2">
													<span class="path1"></span><span class="path2"></span><span class="path3"></span>
												</i>
												<span class="fs-6 fw-normal text-gray-900">
													<c:out value="${mrItemName}"/>
													<c:if test="${not empty mrSubItemName}">
														<span class="mx-2 text-gray-500">|</span><c:out value="${mrSubItemName}"/>
													</c:if>
												</span>
												<span class="mx-5 fs-4 text-gray-900">:</span>
												<span class="fs-6 fw-normal text-gray-900"> 
													<fmt:formatNumber value="${mr.amount}" maxFractionDigits="0" groupingUsed="false" />
													<span id="mr_unit_label"><c:out value="${mrUnitName}" default="-"/></span>
												</span>
											</div> 
											<c:if test="${not empty mr.description}">
												<div class="d-flex align-items-center">
													<i class="ki-duotone ki-document fs-2 fw-normal text-muted me-2">
																<span class="path1"></span>
																<span class="path2"></span>
													</i>
													<span class="fs-5 fw-normal text-gray-900">${mr.description}</span>
												</div>
											</c:if>
									
										</div>
									</div>
									
									<c:if test="${not empty attachmentList}">
										<div class="col-12">
											<h4 class="fw-semibold text-gray-900">
												Attach Files
											</h4>
											<div id="existingFileList" class="d-flex flex-wrap align-items-center gap-6 mt-4">
												<c:forEach var="af" items="${attachmentList}">
													<c:set var="fType" value="${fn:toLowerCase(af.type)}" />
													<div class="d-flex align-items-center" data-file-id="${af.fileId}">
														<a href="${pageContext.request.contextPath}${af.path}" target="_blank"
															class="d-flex align-items-center text-decoration-none text-gray-800">
															<c:choose>
																<c:when test="${fType == '.pdf'}">
																	<img src="${pageContext.request.contextPath}/assets/media/svg/files/pdf.svg" class="w-25px h-25px me-3" alt="icon" />
																</c:when>
																<c:when test="${fType == '.doc' or fType == '.docx'}">
																	<img src="${pageContext.request.contextPath}/assets/media/svg/files/doc.svg" class="w-25px h-25px me-3" alt="icon" />
																</c:when>
																<c:when test="${fType == '.png' or fType == '.jpg' or fType == '.jpeg' or fType == '.gif' or fType == '.webp'}">
																	<img src="${pageContext.request.contextPath}/assets/media/svg/files/blank-image.svg" class="w-25px h-25px me-3" alt="icon" />
																</c:when>
																<c:otherwise>
																	<img src="${pageContext.request.contextPath}/assets/media/svg/files/folder-document.svg" class="w-25px h-25px me-3" alt="icon" />
																</c:otherwise>
															</c:choose>
															<span class="fs-6 fw-medium text-truncate" style="max-width: 220px;" title="${fn:escapeXml(af.name)}${fn:escapeXml(af.type)}"><c:out value="${af.name}" /> <c:out value="${af.type}" /></span>
														</a>
														
													</div>
												</c:forEach>
											</div>
											<div id="attachFileList" class="d-flex flex-wrap align-items-center gap-6 mt-4"></div>
											<div id="errorMsgAF" class="text-danger fs-8 mt-1"></div>
										</div>
									</c:if>
								</div>
							</div>
						</div>
					</c:when>
					<c:when test="${mrStatus.statusCode == '3'}">

					</c:when>
						<c:otherwise>
					</c:otherwise>
				</c:choose>
					
				<c:choose>
					<c:when test="${mrStatus.statusCode == '1'}">
						<!-- Signature -->
						<div class="card mb-10">
							<div class="card-header border-0 px-9 pt-7 d-flex align-items-center justify-content-between">
								<div class="card-title">
									<h3 class="fw-semibold text-gray-900">Signature</h3>
								</div>
							</div>
							<form id="signatureForm" method="post" action="update_signature" enctype="multipart/form-data">
								<div class="card-body filter-card px-10 py-9 rounded-3 row g-5">
									<div class="col-md-6 col-12">
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
															<span class="text-muted fs-8 mt-2">Click to upload Signature</span>
														</div>
													</div>
													<input type="file" id="signatureFileInput" name="fileUpload" accept="image/png,image/jpeg" class="d-none" />
													<span class="text-muted fs-8">Allowed: png, jpg, jpeg</span>
												</c:otherwise>
											</c:choose>
										</div>
									</div>

									<div class="col-md-6 col-12">
										<div class="border ${empty mr.requestDate ? 'border-gray-300' : 'border-success bg-light-success'} rounded-3 h-100 d-flex flex-column align-items-center justify-content-center text-center py-8" id="receiverCard1" ${not empty mr.requestDate ? 'data-signed="true"' : ''}>
											<div class="receiver-box d-flex flex-fill flex-column align-items-center justify-content-center gap-2" id="receiverBox1">
												<c:choose>
													<c:when test="${not empty mr.requestDate}">
														<div id="receiverPreview1" style="min-height: 44px; display: flex; flex-direction: column; align-items: center;">
															<span class="text-primary pb-2 fs-7 fw-semibold">ชื่อ ผู้ขอเบิก</span>
															<div class="d-flex flex-column align-items-center">
																<span class="text-dark fw-semibold fs-7">${fn:escapeXml(loginUser.employeeId)} - ${fn:escapeXml(loginUser.nameEN)}</span>
																<span class="text-muted fs-8"><fmt:formatDate value="${mr.requestDate}" pattern="d MMM yyyy, HH:mm" /></span>
															</div>
														</div>
													</c:when>
													<c:otherwise>
														<span class="text-muted fs-7" id="receiverLabel1">คลิก เพื่อยืนยันผู้รับเงิน</span>
														<div id="receiverPreview1" style="min-height: 44px; display: flex; flex-direction: column; align-items: center;"></div>
														<button type="button" class="btn btn-primary btn-sm px-5" id="receiverBtn1" onclick="confirmReceiver(1)">
															ลงชื่อ ผู้ขอเบิก
														</button>
													</c:otherwise>
												</c:choose>
											</div>
										</div>
									</div>
								</div>
							</form>
						</div>
					</c:when>
					<c:otherwise>
						<!-- Signature -->
						<div class="card mb-10">
							<div class="card-header border-0 px-9 pt-7 d-flex align-items-center justify-content-between">
								<div class="card-title">
									<h3 class="fw-semibold text-gray-900">Signature</h3>
								</div>
							</div>
						
							<div class="card-body filter-card px-10 py-9 rounded-3 row g-5">
								<!-- Pending status -->
								<c:if test="${mrStatus.statusCode == '2' || mrStatus.statusCode == '5'}">
									<c:if test="${not empty mr.requestUser}">
										<div class="col-12 p-16 m-0">
											<div class="d-flex flex-column align-items-center gap-3">
												<c:if test="${not empty userRequest.pathSignature}">
													<img src="${pageContext.request.contextPath}${userRequest.pathSignature}"
														style="max-height: 150px; max-width: 360px; object-fit: contain;" />
												</c:if>
												<span class="text-primary pt-3 fs-4 fw-medium">ชื่อ ผู้ขอเบิก</span>
												<div class="d-flex flex-column align-items-center">
													<span class="text-gray-900 fw-medium fs-5 pb-2">${empty userRequest.nameEN ? userRequest.name : userRequest.nameEN}</span>
													<span class="text-gray-900 fw-medium fs-6">
														<fmt:formatDate value="${requestDate}" pattern="d MMM yyyy , H:mm" />
													</span>
												</div>
											</div>
										</div>
									</c:if>
								</c:if>

								<!-- Approved status -->
								<c:if test="${mrStatus.statusCode == '3'}">
									<c:if test="${not empty mr.requestUser}">
										<div class="col-6 p-16 m-0">
											<div class="d-flex flex-column align-items-center gap-3">
												<c:if test="${not empty userRequest.pathSignature}">
													<img src="${pageContext.request.contextPath}${userRequest.pathSignature}"
														style="max-height: 150px; max-width: 360px; object-fit: contain;" />
												</c:if>
												<span class="text-primary pt-3 fs-4 fw-medium">ชื่อ ผู้ขอเบิก</span>
												<div class="d-flex flex-column align-items-center">
													<span class="text-gray-900 fw-medium fs-5 pb-2">${empty userRequest.nameEN ? userRequest.name : userRequest.nameEN}</span>
													<span class="text-gray-900 fw-medium fs-6">
														<fmt:formatDate value="${requestDate}" pattern="d MMM yyyy , H:mm" />
													</span>
												</div>
											</div>
										</div>
									</c:if>

									<c:if test="${not empty mr.approveUser}">
										<div class="col-6 p-16 m-0">
											<div class="d-flex flex-column align-items-center gap-3">
												<c:if test="${not empty userApprove.pathSignature}">
													<img src="${pageContext.request.contextPath}${userApprove.pathSignature}"
														style="max-height: 150px; max-width: 360px; object-fit: contain;" />
												</c:if>
												<span class="text-primary pt-3 fs-4 fw-medium">ชื่อ ผู้อนุมัติ</span>
												<div class="d-flex flex-column align-items-center">
													<span class="text-gray-900 fw-medium fs-5 pb-2">${empty userApprove.nameEN ? userApprove.name : userApprove.nameEN}</span>
													<span class="text-gray-900 fw-medium fs-6">
														<fmt:formatDate value="${approveDate}" pattern="d MMM yyyy , H:mm" />
													</span>
												</div>
											</div>
										</div>
									</c:if>
								</c:if>

								<!-- Delivered status -->
								<c:if test="${mrStatus.statusCode == '4'}">
									<c:if test="${not empty mr.requestUser}">
										<div class="col-4 p-16 m-0">
											<div class="d-flex flex-column align-items-center gap-3">
												<c:if test="${not empty userRequest.pathSignature}">
													<img src="${pageContext.request.contextPath}${userRequest.pathSignature}"
														style="max-height: 150px; max-width: 360px; object-fit: contain;" />
												</c:if>
												<span class="text-primary pt-3 fs-4 fw-medium">ชื่อ ผู้ขอเบิก</span>
												<div class="d-flex flex-column align-items-center">
													<span class="text-gray-900 fw-medium fs-5 pb-2">${empty userRequest.nameEN ? userRequest.name : userRequest.nameEN}</span>
													<span class="text-gray-900 fw-medium fs-6">
														<fmt:formatDate value="${requestDate}" pattern="d MMM yyyy , H:mm" />
													</span>
												</div>
											</div>
										</div>
									</c:if>

									<c:if test="${not empty mr.receiveUser}">
										<div class="col-4 p-16 m-0">
											<div class="d-flex flex-column align-items-center gap-3">
												<c:if test="${not empty userReceive.pathSignature}">
													<img src="${pageContext.request.contextPath}${userReceive.pathSignature}"
														style="max-height: 150px; max-width: 360px; object-fit: contain;" />
												</c:if>
												<span class="text-primary pt-3 fs-4 fw-medium">ชื่อ ผู้รับ</span>
												<div class="d-flex flex-column align-items-center">
													<span class="text-gray-900 fw-medium fs-5 pb-2">${empty userReceive.nameEN ? userReceive.name : userReceive.nameEN}</span>
													<span class="text-gray-900 fw-medium fs-6">
														<fmt:formatDate value="${receiveDate}" pattern="d MMM yyyy , H:mm" />
													</span>
												</div>
											</div>
										</div>
									</c:if>

									<c:if test="${not empty mr.approveUser}">
										<div class="col-4 p-16 m-0">
											<div class="d-flex flex-column align-items-center gap-3">
												<c:if test="${not empty userApprove.pathSignature}">
													<img src="${pageContext.request.contextPath}${userApprove.pathSignature}"
														style="max-height: 150px; max-width: 360px; object-fit: contain;" />
												</c:if>
												<span class="text-primary pt-3 fs-4 fw-medium">ชื่อ ผู้อนุมัติ</span>
												<div class="d-flex flex-column align-items-center">
													<span class="text-gray-900 fw-medium fs-5 pb-2">${empty userApprove.nameEN ? userApprove.name : userApprove.nameEN}</span>
													<span class="text-gray-900 fw-medium fs-6">
														<fmt:formatDate value="${approveDate}" pattern="d MMM yyyy , H:mm" />
													</span>

													<c:if test="${not empty mr.reason}">
														<span class="d-flex align-items-center mt-3">
															<i class="ki-duotone ki-document fs-2 fw-normal text-muted me-2">
																<span class="path1"></span>
																<span class="path2"></span>
															</i>
															<span class="fs-5 fw-normal text-gray-900">${mr.reason}</span>
														</span>
													</c:if>
												</div>
											</div>
										</div>
									</c:if>
								</c:if>

							</div>
									
						</div>
					</c:otherwise>
				</c:choose>

				<c:if test="${mrStatus.statusCode == '2'}">
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

					
				<c:if test="${mrStatus.statusCode == '3' || mrStatus.statusCode == '5' || mrStatus.statusCode == '6'}">
					<c:choose>
						<c:when test="${mrStatus.statusCode == '3'}"><c:set var="actionLabel" value="Approved By"/></c:when>
						<c:when test="${mrStatus.statusCode == '5'}"><c:set var="actionLabel" value="Rejected By"/></c:when>
						<c:when test="${mrStatus.statusCode == '6'}"><c:set var="actionLabel" value="Cancel By"/></c:when>
					</c:choose>

					<div class="card mb-10">
						<div class="card-body filter-card px-10 py-9 rounded-3">
							<div class="d-flex align-items-center fs-6">
								<span>${actionLabel} : ${userUpdate.employeeId} ${userUpdate.nameEN},
									<c:choose>
										<c:when test="${not empty mr.approveDate}">
											<fmt:formatDate value="${mr.approveDate}" pattern="d MMM yyyy HH:mm" />
										</c:when>
										<c:otherwise>
											<fmt:formatDate value="${mr.timeUpdate}" pattern="d MMM yyyy HH:mm" />
										</c:otherwise>
									</c:choose>
								</span>

								<c:if test="${(mrStatus.statusCode == '5' || mrStatus.statusCode == '3') and not empty mr.reason}">
									<span class="ms-5 d-inline-flex align-items-center">
										<i class="ki-duotone ki-document fs-3 me-3">
											<span class="path1"></span>
											<span class="path2"></span>
										</i>
										<span>${mr.reason}</span>
									</span>
								</c:if>
							</div>
						</div>
					</div>
				</c:if>


					<div class="d-flex justify-content-between mb-10">
						<div class="d-flex">
							<button type="button" id="backFormBtn"
								onclick="location.href='equipment_request_mr_list_admin'"
								class="btn btn-lg btn-light fw-medium text-light-inverse px-6 py-4 me-4 border">Back
							</button>
							
							<!-- <c:if test="${mrStatus.statusCode == '1' || mrStatus.statusCode == '2'}">
								<button type="button" id="cancelFormBtn"
									onclick="cancelMr()"
									class="btn btn-lg btn-dark fw-medium px-6 py-4">Cancel
								</button>
							</c:if> -->
						</div>
						<c:choose>
							<c:when test="${mrStatus.statusCode == '2'}">
								<div class="d-flex">
									<button type="button" id="rejectMRBtn" onclick="rejectMR()"
										class="btn btn-lg btn-danger text-white fw-medium px-6 py-4 me-4">Reject</button>
									<button type="button" id="approveMRBtn" onclick="approveMR()"
										class="btn btn-lg btn-success text-white fw-medium px-6 py-4">Approve</button>
								</div>
							</c:when>
						</c:choose>
					</div>

				</div>
			</div>
		</div>
	</div>

</body>
<script type="text/javascript">
	const ctx = "${pageContext.request.contextPath}";
	const currentUserDisplay = "${fn:escapeXml(loginUser.employeeId)} - ${fn:escapeXml(loginUser.nameEN)}";
	const ITEM_TYPE_LABELS = { '1': 'Equipment', '2': 'Consumables', '3': 'Accessory', '4': 'Office supplies' };

	var requesterSign = null;
	var confirmed1 = (document.getElementById('receiverCard1')?.dataset.signed === 'true');
	var hasSubItems = false;

	// --- Item / Sub item / Unit ---
	const ITEM_TYPE_MAP = {
		'1': { label: 'Equipment', color: 'text-primary',
			icon: '<i class="ki-duotone ki-monitor-mobile fs-2 text-primary"><span class="path1"></span><span class="path2"></span></i>' },
		'2': { label: 'Consumables', color: 'text-orange',
			icon: '<i class="ki-duotone ki-lots-shopping fs-2 text-orange"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span><span class="path7"></span><span class="path8"></span></i>' },
		'3': { label: 'Accessory', color: 'text-teal',
			icon: '<i class="ki-duotone ki-medal-star fs-2 text-teal"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i>' },
		'4': { label: 'Office supplies', color: 'text-success',
			icon: '<i class="ki-duotone ki-parcel fs-2 text-success"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i>' }
	};

	function updateItemTypeBox(type) {
		var info = ITEM_TYPE_MAP[String(type)];
		if (info) {
			$('#itemTypeIcon').html(info.icon);
			$('#itemTypeLabel').text(info.label);
			$('#itemTypeBox').removeClass('d-none').addClass('d-flex');
		} else {
			$('#itemTypeBox').removeClass('d-flex').addClass('d-none');
		}
	}

	$('#mr_item').on('change', function () {
		var productId = $(this).val();
		var type = $(this).find('option:selected').data('type');

		updateItemTypeBox(type); 

		loadSubItems(productId);
		loadUnit();
	});

	$('#mr_sub_item').on('change', function () {
		loadUnit();
	});

	// --- Quantity: บังคับจำนวนเต็มบวก ---
	$('#mr_amount').on('keydown', function (e) {
		if (e.key === '.' || e.key === ',' || e.key === 'e' || e.key === 'E' || e.key === '-' || e.key === '+') {
			e.preventDefault();
		}
	});

	// กัน paste ทศนิยม / spinner ที่ให้ค่าทศนิยม
	$('#mr_amount').on('input', function () {
		var val = $(this).val();
		if (val === '') return;
		var num = parseFloat(val);
		if (!isNaN(num)) {
			var intVal = Math.floor(Math.abs(num));
			if (String(intVal) !== val) {
				$(this).val(intVal);
			}
		}
	});

	// --- หน้า edit: preselect Item / Sub item จากข้อมูลเดิมใน DB (ไม่ใช้ session draft) ---
	const MR_ID = "${fn:escapeXml(mr.mrId)}";
	const SAVED_ITEM_ID = "${fn:escapeXml(selectedItemId)}";
	const MR_ITEM_TYPE = "${fn:escapeXml(mrItemType)}";
	var pendingSubItemId = "${fn:escapeXml(selectedSubItemId)}" || null;

	document.addEventListener("DOMContentLoaded", function () {
		var $item = $('#mr_item');
		if ($item.length === 0) {
			updateItemTypeBox(MR_ITEM_TYPE);
			return;
		}
		if (SAVED_ITEM_ID && $item.find('option[value="' + SAVED_ITEM_ID + '"]').length) {
			$item.val(SAVED_ITEM_ID).trigger('change');
			return;
		}
		// Item เดิมไม่ active แล้ว/ไม่อยู่ในลิสต์ fallback เลือกตัวแรก
		pendingSubItemId = null;
		var firstVal = $item.find('option').filter(function () { return this.value !== ''; }).first().val();
		if (firstVal) {
			$item.val(firstVal).trigger('change');
		}
	});

	function refreshSubItemSelect2(placeholderText) {
    var $sub = $('#mr_sub_item');
    if ($sub.hasClass('select2-hidden-accessible')) {
        $sub.select2('destroy');
    }
    $sub.select2({
        placeholder: placeholderText,
        dropdownParent: $sub.closest('.col-lg-4')
    });
}

function loadSubItems(productId) {
    var $sub = $('#mr_sub_item');
    $sub.empty().append('<option value="">No data</option>')
        .prop('disabled', true)
        .addClass('form-select-solid');
    refreshSubItemSelect2('No data');   // ตอนยังไม่มีข้อมูล
    hasSubItems = false;
    if (!productId) return;

    $.ajax({
        url: ctx + '/get_mr_sub_item',
        type: 'POST',
        dataType: 'json',
        data: { productId: productId },
        success: function (resp) {
            var list = (resp.data && resp.data.subItemList) || [];
            var restoreId = pendingSubItemId;
            pendingSubItemId = null;
            if (list.length === 0) return; 

            hasSubItems = true;
            $sub.empty().append('<option value="">No data</option>');
            list.forEach(function (item) {
                $sub.append($('<option>').val(item.id).text(item.name));
            });
            $sub.prop('disabled', false).removeClass('form-select-solid');

            var hasRestore = restoreId && list.some(function (it) { return String(it.id) === String(restoreId); });
            $sub.val(hasRestore ? restoreId : list[0].id);
            refreshSubItemSelect2('No data'); 
            loadUnit();
        },
        error: function () {
            pendingSubItemId = null;
            Swal.fire('Error', 'ไม่สามารถโหลด Sub item ได้', 'error');
        }
    });
}

	// ใช้ product_id ตัวที่เลือกล่างสุด (sub item ถ้ามี) ไปหาหน่วยเล็กสุด
	function loadUnit() {
		var productId = $('#mr_item').val();
		var subProductId = $('#mr_sub_item').val();
		$('#mr_unit_label').text('-');
		if (!productId) return;

		$.ajax({
			url: ctx + '/get_mr_unit',
			type: 'POST',
			dataType: 'json',
			data: { productId: productId, subProductId: subProductId || '' },
			success: function (resp) {
				var unitName = resp.data && resp.data.unitName;
				$('#mr_unit_label').text(unitName || '-');
			}
		});
	}

	// --- Multi-file Attach  ---
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
					canvas.getContext('2d').drawImage(img, 0, 0, width, height);
					canvas.toBlob((blob) => {
						if (blob) {
							const newFileName = file.name.replace(/\.[^/.]+$/, ".jpg");
							resolve(new File([blob], newFileName, { type: 'image/jpeg', lastModified: Date.now() }));
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
				selectedFiles.push(await compressImage(file));
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

		selectedFiles.forEach(function (file) {
			const fileName = file.name;
			const lastDotIndex = fileName.lastIndexOf('.');
			const nameOnly = lastDotIndex > -1 ? fileName.substring(0, lastDotIndex) : fileName;
			const fileExt = lastDotIndex > -1 ? fileName.substring(lastDotIndex) : '';

			const item = document.createElement('div');
			item.className = 'd-flex align-items-center';

			const icon = document.createElement('img');
			icon.src = getFileIconPath(fileName);
			icon.className = 'w-25px h-25px me-3';
			icon.alt = 'icon';

			const name = document.createElement('span');
			name.className = 'fs-6 fw-medium text-gray-800 text-truncate';
			name.style.maxWidth = '220px';
			name.title = fileName;
			name.textContent = nameOnly + ' ' + fileExt;

			const del = document.createElement('span');
			del.className = 'badge badge-light-danger bg-hover cursor-pointer ms-3';
			del.innerHTML = '<i class="ki-duotone ki-trash text-danger fs-2">' +
				'<span class="path1"></span><span class="path2"></span>' +
				'<span class="path3"></span><span class="path4"></span><span class="path5"></span></i>';
			del.addEventListener('click', function () {
				selectedFiles = selectedFiles.filter(f => f.name !== fileName);
				renderNewFileList();
				updateInputFiles();
			});

			item.appendChild(icon);
			item.appendChild(name);
			item.appendChild(del);
			fileListDiv.appendChild(item);
		});
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


	// --- Signature Upload  ---
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

			fetch(ctx + '/update_signature', {
				method: 'POST',
				body: new FormData(signatureForm)
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
		});
	})();

	// --- ลงชื่อ ผู้ขอเบิก ---
	function confirmReceiver(slot) {
		const now = new Date();
		const pad = n => String(n).padStart(2, '0');
		const months = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];

		const timestamp = now.getFullYear() + "-" + pad(now.getMonth() + 1) + "-" + pad(now.getDate()) + " " +
			pad(now.getHours()) + ":" + pad(now.getMinutes()) + ":" + pad(now.getSeconds());
		const displayTimestamp = now.getDate() + " " + months[now.getMonth()] + " " + now.getFullYear() +
			", " + pad(now.getHours()) + ":" + pad(now.getMinutes());

		requesterSign = { userName: currentUserDisplay, requestAt: timestamp };

		const labelEl = document.getElementById('receiverLabel' + slot);
		if (labelEl) labelEl.style.display = 'none';

		const preview = document.getElementById('receiverPreview' + slot);
		preview.innerHTML = '';
		const nameEl = document.createElement('span');
		nameEl.className = 'fw-semibold text-dark fs-7';
		nameEl.textContent = requesterSign.userName;
		const timeEl = document.createElement('span');
		timeEl.className = 'text-muted fs-8 mt-1';
		timeEl.textContent = displayTimestamp;
		preview.appendChild(nameEl);
		preview.appendChild(timeEl);

		const btn = document.getElementById('receiverBtn' + slot);
		btn.textContent = "✓ ยืนยันแล้ว";
		btn.className = "btn btn-success btn-sm px-5";
		btn.disabled = true;

		const card = document.getElementById('receiverCard' + slot);
		if (card) {
			card.classList.remove('border-gray-300');
			card.classList.add('border-success', 'bg-light-success');
		}

		if (slot === 1) confirmed1 = true;
	}

	// --- Save / Submit ---
	function validateMrForm(isSubmit) {
		let errors = [];
		if (!$('#mr_item').val()) errors.push('Item');
		if (hasSubItems && !$('#mr_sub_item').val()) errors.push('Sub item');
		const qty = Number($('#mr_amount').val());
		if (!qty || qty <= 0 || !Number.isInteger(qty)) errors.push('Quantity');

		if (isSubmit) {
			if ($('#hasSignature').val() !== 'true') errors.push('ลายเซ็น (Signature)');
			if (!confirmed1) errors.push('ลงชื่อ ผู้ขอเบิก');
		}
		return errors;
	}

	function submitMr() {
		const errors = validateMrForm(true);
		if (errors.length > 0) {
			Swal.fire({
				title: 'Please complete the form!',
				html: "Please fill in the following fields:<br><strong>" + errors.join(", ") + "</strong>",
				icon: "error",
				confirmButtonText: "OK"
			});
			return;
		}

		Swal.fire({
			title: "Are you sure?!",
			text: "Do you want to submit this request?",
			icon: "warning",
			showCancelButton: true,
			confirmButtonText: "Submit",
			cancelButtonText: "Close",
			buttonsStyling: false,
			customClass: {
				confirmButton: "btn btn-success",
				cancelButton: "btn btn-secondary"
			}
		}).then((result) => {
			if (result.isConfirmed) saveMr('2');
		});
	}

	function saveMr(status) {
		if (status === '1') {
			const errors = validateMrForm(false);
			if (errors.length > 0) {
				Swal.fire({
					title: 'Please complete the form!',
					html: "Please fill in the following fields:<br><strong>" + errors.join(", ") + "</strong>",
					icon: "error",
					confirmButtonText: "OK"
				});
				return;
			}
		}

		const payload = {
			mrId: MR_ID,
			productId: $('#mr_item').val() || '',
			subProductId: $('#mr_sub_item').val() || '',
			amount: $('#mr_amount').val() || '',
			description: $('#mr_description').val().trim(),
			urlRef: $('#mr_url_ref').val().trim(),
			status: status,
			signDate: requesterSign ? requesterSign.requestAt : ''
		};

		const fd = new FormData();
		Object.keys(payload).forEach(function (k) { fd.append(k, payload[k]); });
		selectedFiles.forEach(function (file) { fd.append('files', file, file.name); });

		$('#saveDraftBtn, #submitMrBtn').prop('disabled', true);

		$.ajax({
			url: ctx + '/update_mr',
			type: 'POST',
			dataType: 'json',
			data: fd,
			processData: false,
			contentType: false,
			success: function (resp) {
				if (resp.data && resp.data.mrId) {
					Swal.fire({
						title: 'Success!',
						text: (status === '2' ? 'MR submitted successfully! ' : 'MR updated successfully! ') + resp.data.mrId,
						icon: 'success'
					}).then(() => {
						window.location.href = ctx + '/equipment_request_mr_list_admin';
					});
				} else {
					Swal.fire('Error', 'ไม่สามารถบันทึก MR ได้', 'error');
				}
			},
			error: function () {
				Swal.fire('Error', 'เกิดข้อผิดพลาดในการบันทึก', 'error');
			},
			complete: function () {
				$('#saveDraftBtn, #submitMrBtn').prop('disabled', false);
			}
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

	function updateMrStatus(opts){
		Swal.fire({
			title: "Are you sure?!",
			text: opts.confirmText,
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

			const payload = { mrId: MR_ID, status: opts.status };
			if (opts.reason) payload.reason = opts.reason;

			$('#rejectMRBtn, #approveMRBtn').prop('disabled', true);

			$.ajax({
				url: ctx + '/update_status_mr',
				type: 'POST',
				dataType: 'json',
				data: payload,
				success: function (resp) {
					if (resp.data && resp.data.mrId) {
						Swal.fire({
							title: 'Success!',
							text: opts.successText,
							icon: 'success'
						}).then(() => {
							if (opts.redirectUrl) {
								window.location.href = opts.redirectUrl;
							} else {
								location.reload();
							}
						});
					} else {
						Swal.fire('Error', opts.errorText, 'error');
						$('#rejectMRBtn, #approveMRBtn').prop('disabled', false);
					}
				},
				error: function () {
					Swal.fire('Error', 'เกิดข้อผิดพลาดในการส่งข้อมูล', 'error');
					$('#rejectMRBtn, #approveMRBtn').prop('disabled', false);
				}
			});
		});
	}

	function rejectMR(){
		const reasonVal = validateReason(); // Reject บังคับกรอก
		if (reasonVal === null) return;

		updateMrStatus({
			status: '5',
			reason: reasonVal,
			confirmText: 'Do you want to reject this MR?',
			successText: 'MR rejected successfully!',
			errorText: 'ไม่สามารถปฏิเสธ MR ได้',
			redirectUrl: ctx + '/equipment_request_mr_list_admin'
		});
	}

	function approveMR(){
		const reasonVal = ($('#reason').val() || '').trim(); // Approve ไม่บังคับ

		updateMrStatus({
			status: '3',
			reason: reasonVal,
			confirmText: 'Do you want to approve this MR?',
			successText: 'MR approved successfully!',
			errorText: 'ไม่สามารถอนุมัติ MR ได้'
		});
	}
</script>
</html>
