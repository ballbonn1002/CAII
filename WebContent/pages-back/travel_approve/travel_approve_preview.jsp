<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<fmt:setLocale value="en_US" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Travel Approve| CubeSoftTech</title>

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
.breadcrumb-item+.breadcrumb-item::before {
	content: "-" !important;
}

.card.card-flush>.card-header {
	border-bottom: 1px solid #EEF0F3 !important;
}

.total-badge {
	background: #009EF7;
	color: #fff;
	border-radius: 8px;
	padding: 10px 22px;
	font-weight: 700;
	font-size: 1rem;
	white-space: nowrap;
}

/* ===== Expense Block ===== */
.expense-block {
	border: 1px solid #EEF0F3;
	border-radius: 12px;
	padding: 24px;
	margin-bottom: 20px;
	background: #fff;
}

.expense-block:last-child {
	margin-bottom: 0;
}

.expense-id {
	color: #009EF7;
	font-weight: 700;
	font-size: 1rem;
	margin-bottom: 16px;
}

.expense-meta {
	display: grid;
	grid-template-columns: 1fr 1fr 1fr;
	gap: 10px 16px;
	margin-bottom: 16px;
}

.meta-item {
	display: flex;
	align-items: center;
	gap: 8px;
	color: #5E6278;
	font-size: .875rem;
}

.meta-item i {
	color: #A1A5B7;
	font-size: 1.1rem;
}

.meta-item.destination i {
	color: #50CD89;
}

.meta-item.origin i {
	color: #009EF7;
}

/* ===== Detail Table ===== */
.detail-table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 8px;
}

.detail-table td {
	padding: 8px 6px;
	font-size: .875rem;
	color: #3F4254;
	border-bottom: 1px solid #F4F4F4;
}

.detail-table td:last-child {
	text-align: right;
	font-weight: 600;
}

.detail-table .seq-col {
	color: #A1A5B7;
	width: 36px;
}

.detail-table .total-row td {
	border-bottom: none;
	padding-top: 12px;
	font-weight: 700;
}

.detail-table .total-row td:last-child {
	color: #009EF7;
}

/* ===== Signature Box ===== */
.sig-box {
	width: 400px;
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

/* ===== Receiver Box ===== */
.receiver-box {
	border: 1px solid #EEF0F3;
	border-radius: 10px;
	padding: 16px 24px;
	min-width: 180px;
	text-align: center;
	background: #fff;
}

.receiver-confirmed {
	border-color: #50CD89 !important;
	background: #F6FFF9 !important;
}
</style>
</head>

<body id="kt_app_body" class="app-default">
	<c:set var="ctx" value="${pageContext.request.contextPath}" />

	<div class="d-flex flex-column flex-root" id="kt_app_root">
		<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
			<div class="d-flex flex-column flex-column-fluid">

				<!-- ===== Toolbar ===== -->
				<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
					<div id="kt_app_toolbar_container"
						class="app-container container-fluid d-flex align-items-center justify-content-between">
						<div
							class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
							<h1
								class="page-heading d-flex text-dark fw-bold fs-3 flex-column justify-content-center my-0">
								Approve Expense</h1>
							<ul
								class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
								<li class="breadcrumb-item text-muted">Home</li>
								<li class="breadcrumb-item"><span
									class="bullet bg-gray-400 w-5px h-2px"></span></li>
								<li class="breadcrumb-item text-muted">Admin Management</li>
							</ul>
						</div>
						<c:choose>
							<c:when test="${statusActiveSafe eq 'W'}">
								<div class="btn btn-sm btn-light-warning border border-warning">Wait
									for Approve</div>
							</c:when>
							<c:when test="${statusActiveSafe eq 'C'}">
								<div class="btn btn-sm btn-light-danger border border-danger">Canceled</div>
							</c:when>
							<c:when test="${statusActiveSafe eq 'A'}">
								<div class="btn btn-sm btn-light-success border border-success">Approved</div>
							</c:when>
							<c:when test="${statusActiveSafe eq 'P'}">
								<div class="btn btn-sm btn-light-info border border-info">Paid
									Already</div>
							</c:when>
							<c:when test="${statusActiveSafe eq 'R'}">
								<div class="btn btn-sm btn-light-danger border border-danger">Rejected</div>
							</c:when>
						</c:choose>
					</div>
				</div>

				<!-- ===== Content ===== -->
				<div id="kt_app_content" class="app-content flex-column-fluid">
					<div id="kt_app_content_container"
						class="app-container container-fluid">

						<form id="submitRequestForm" method="post"
							action="${ctx}/travel_submit" enctype="multipart/form-data">

							<c:forEach var="sid" items="${selectedIds}">
								<input type="hidden" name="ids" value="${sid}" />
							</c:forEach>

							<!-- ===== Expense List ===== -->
							<div class="card card-flush mb-6">
								<div class="card-header flex-column gap-2 py-5">
									<div class="card-title m-0">
										<h3 class="fw-semibold m-0">Request travel expense form</h3>
									</div>
									<div class="fw-normal text-gray-900 fs-6">
										<span> Request by : ${userObj.employeeId}
											&nbsp;&ndash;&nbsp; ${userObj.nameEN} &nbsp;&ndash;&nbsp;
											${userObj.name} &nbsp;&ndash;&nbsp; ${userObj.departmentId},
										</span> <span> <c:choose>
												<c:when test="${not empty expense_group_create_date}">
													<fmt:formatDate value="${expense_group_create_date}"
														pattern="d MMM yyyy H:mm" />
												</c:when>
												<c:otherwise>
													<fmt:formatDate value="<%=new java.util.Date()%>"
														pattern="d MMM yyyy H:mm" />
												</c:otherwise>
											</c:choose>
										</span>
									</div>
								</div>
								<div class="card-body py-6">
									<div class="table-responsive" style="position: relative;">
										<table class="m-0 table table-striped">
											<thead class="text-gray-500 border-bottom">
												<tr>
													<th>#</th>
													<th>ID</th>
													<th>REQUESTS</th>
													<th>CATEGORIZED</th>
													<th>MENU</th>
													<th>BY</th>
													<th class="text-end">AMOUNT</th>
													<th class="text-end">TOTAL</th>

												</tr>
											</thead>
											<tbody>
												<c:forEach var="exp" items="${expenseListObj}"
													varStatus="st">
													<tr class="border-bottom">
														<td>${st.count}</td>
														<td>#${exp['expense_id']}</td>
														<td><c:choose>
																<c:when test="${not empty exp['dt_start']}">
																	<fmt:formatDate value="${exp['dt_start']}"
																		pattern="d MMM yyyy" />
																</c:when>
																<c:otherwise>-</c:otherwise>
															</c:choose></td>
														<td><div class="d-flex flex-column gap-3">
																<div class="d-flex align-items-center gap-2">
																	<i class="ki-duotone ki-geolocation fs-3 text-primary"><span
																		class="path1"></span><span class="path2"></span></i> <span>
																		${exp['from_location']} </span>
																</div>
																<div class="d-flex align-items-center gap-2">
																	<i class="ki-duotone ki-geolocation fs-3 text-success"><span
																		class="path1"></span><span class="path2"></span></i> <span>
																		${exp['to_location']} </span>
																</div>
															</div></td>
														<td><div class="d-flex flex-column gap-3">
																<div class="d-flex align-items-center gap-2">
																	<i class="ki-duotone ki-time fs-3"><span
																		class="path1"></span><span class="path2"></span></i> <span>
																		<c:choose>
																			<c:when test="${not empty exp['dt_start']}">
																				<fmt:formatDate value="${exp['dt_start']}"
																					pattern="H:mm" />
																			</c:when>
																			<c:otherwise>-</c:otherwise>
																		</c:choose>
																	</span>
																</div>
																<div class="d-flex align-items-center gap-2">
																	<i class="ki-duotone ki-time fs-3"><span
																		class="path1"></span><span class="path2"></span></i> <span>
																		<c:choose>
																			<c:when test="${not empty exp['dt_end']}">
																				<fmt:formatDate value="${exp['dt_end']}"
																					pattern="H:mm" />
																			</c:when>
																			<c:otherwise>-</c:otherwise>
																		</c:choose>
																	</span>
																</div>
															</div></td>
														<td>
															<div class="d-flex flex-column gap-3">
																<c:forEach var="det" items="${exp['details']}"
																	varStatus="ds">
																	<c:set var="total_amount" value="${exp['amount']}"></c:set>
																	<div>
																		<span>${det['travel_type_name']} </span>
																		<c:if test="${not empty det['description'] }">
																			<span class="text-gray-600"> :
																				${det['description']}</span>
																		</c:if>
																	</div>
																</c:forEach>
															</div>
														</td>
														<td>
															<div class="d-flex flex-column align-items-end gap-3">
																<c:forEach var="det" items="${exp['details']}"
																	varStatus="ds">
																	<span> <c:if test="${not empty det['total']}">
																			<fmt:formatNumber value="${det['total']}"
																				pattern="#,##0.00" />
																		</c:if>
																	</span>
																</c:forEach>
															</div>
														</td>
														<td class="text-end"><c:if
																test="${not empty total_amount}">${total_amount}</c:if>
														</td>
													</tr>
													<tr>
														<td colspan="8">
															<div class="d-flex flex-column gap-3">
																<span class="text-gray-500">Purpose of journey :
																	<span class="text-dark">${exp['description']} </span>
																</span>
																<c:if test="${not empty exp['files']}">
																	<div class="d-flex flex-warp align-items-center gap-4">
																		<c:forEach var="file" items="${exp['files']}">
																			<a href="${ctx}${file.path}"
																				class="text-primary d-flex align-items-center"><i
																				class="ki-duotone ki-document fs-3 me-2"><span
																					class="path1"></span> <span class="path2"></span> </i>${file.name}${file.type}</a>
																		</c:forEach>
																	</div>
																</c:if>
															</div>
														</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</div>

									<c:if test="${empty expenseListObj}">
										<div class="text-center text-muted py-10">No data.</div>
									</c:if>
								</div>

								<c:if test="${not empty expenseListObj}">
									<div class="card-footer pt-0 d-flex justify-content-end gap-1 ">
										<h3 class="m-0 fs-6 fw-bold text-primary">Total</h3>
										<h3 class="m-0 fs-6 fw-bold text-primary">
											<fmt:formatNumber value="${grandTotal}" pattern="#,##0.00" />
											บาท
										</h3>
									</div>
								</c:if>
							</div>

							<!-- ===== Signature ===== -->
							<div class="card card-flush mb-6">
								<div class="card-header">
									<div class="card-title">
										<h3 class="fw-bold m-0">Signature</h3>
									</div>
								</div>
								<div class="card-body py-5">
									<div class="d-flex align-items-start gap-8 flex-wrap">

										<!-- LEFT: Signature Image -->
										<div class="d-flex flex-column align-items-center gap-2">

											<c:choose>
												<%-- มีรูปแล้ว → ล็อค ห้ามเปลี่ยน ไม่มี input file --%>
												<c:when test="${not empty signaturePath}">
													<div class="sig-box locked">
														<img src="${ctx}${signaturePath}"
															style="max-height: 160px; max-width: 360px; object-fit: contain;" />
														<div class="sig-lock-badge">
															<i class="ki-duotone ki-lock fs-7"> <span
																class="path1"></span><span class="path2"></span>
															</i> Signature on file
														</div>
													</div>
												</c:when>

												<%-- ไม่มีรูป --%>
												<c:otherwise>
													<div class="sig-box unuploadable" id="uploadSignatureBox">
														<i class="ki-duotone ki-cloud-add fs-2x text-muted"> <span
															class="path1"></span><span class="path2"></span>
														</i> <span class="text-muted fs-8 mt-2">The signature
															has not been uploaded yet</span>
													</div>
												</c:otherwise>
											</c:choose>
										</div>

										<!-- MIDDLE: Receiver 1 = ผู้ขอเบิก -->
										<div
											class="receiver-box d-flex flex-fill flex-column align-items-center gap-2"
											id="receiverBox1">
											<div id="receiverPreview1"
												style="min-height: 44px; display: flex; flex-direction: column; align-items: center;">
												<span class="text-primary pb-7 fs-7" id="receiverLabel1">ชื่อ
													ผู้ขอเบิก</span>
												<div class="d-flex flex-column">
													<span class="text-dark fw-semibold fs-7">${userObj.nameEN}</span>
													<span class="text-muted fs-8"><fmt:formatDate
															value="${requestAt}" pattern="d MMM yyyy, H:mm" /></span>

												</div>
											</div>
										</div>

										<!-- RIGHT: Receiver 2 = ผู้รับเงิน -->
										<div
											class="receiver-box d-flex flex-fill flex-column align-items-center gap-2"
											id="receiverBox2">
											<div id="receiverPreview2"
												style="min-height: 44px; display: flex; flex-direction: column; align-items: center;">
												<span class="text-primary pb-7 fs-7" id="receiverLabel1">ชื่อ
													ผู้รับเงิน</span> <span class="text-dark fw-semibold fs-7">${userObj.nameEN}</span>
												<span class="text-muted fs-8"><fmt:formatDate
														value="${requestAt}" pattern="d MMM yyyy, H:mm" /></span>
											</div>
										</div>
									</div>
								</div>
							</div>

							<c:if test="${statusActiveSafe eq 'W'}">
								<div class="card card-flush mb-6">
									<div class="card-header">
										<div class="card-title">
											<h3 class="fw-bold m-0">Approval reason</h3>
										</div>
									</div>
									<div class="card-body">
										<label class="form-label fw-medium text-gray-800">Please
											enter a reason</label>
										<textarea name="description_appr"
											class="form-control resize-none fw-medium text-gray-900 ${statusActiveSafe ne 'W'  ? 'bg-light' : ''}"
											rows="3"></textarea>
									</div>
								</div>
							</c:if>

							<c:if test="${not empty userAppr}">
								<div class="card card-flush mb-6">
									<div class="card-body py-5">
										<div class="d-flex gap-5 fw-normal text-gray-900 fs-6">
											<span> Approved by : ${userAppr.employeeId}
												&nbsp;&ndash;&nbsp; ${userAppr.nameEN} &nbsp;&ndash;&nbsp;
												${userAppr.name} &nbsp;&ndash;&nbsp;
												${userAppr.departmentId}, <fmt:formatDate
													value="${approved_at}" pattern="d MMM yyyy H:mm" />
											</span>

											<c:if test="${not empty description_appr}">
												<div class="d-flex gap-2 align-items-center">
													<i class="ki-duotone ki-document fs-2"> <span
														class="path1"></span> <span class="path2"></span>
													</i> <span>${description_appr}</span>
												</div>
											</c:if>
										</div>
									</div>
								</div>
							</c:if>

							<div class="d-flex justify-content-between mb-10">
								<a href="${ctx}/travel_approve?status=W"
									class="btn btn-light px-6"><i
									class="ki-duotone ki-arrow-left fs-2"> <span class="path1"></span>
										<span class="path2"></span>
								</i>Back</a>
								<c:choose>
									<c:when test="${statusActiveSafe == 'W'}">
										<div>
											<button type="submit"
												formaction="${ctx}/travel_approve_reject?expense_group_id=${expense_group_id}"
												class="btn btn-danger px-6"
												onclick="return validateReject(event);">Reject</button>
											<button type="submit"
												formaction="${ctx}/travel_approve_paid?expense_group_id=${expense_group_id}"
												class="btn btn-info px-6 ms-4">Paid</button>
											<button type="submit"
												formaction="${ctx}/travel_approve_approve?expense_group_id=${expense_group_id}"
												class="btn btn-success px-6 ms-4">Approve</button>
										</div>
									</c:when>
									<c:when test="${statusActiveSafe == 'A'}">
										<button type="submit"
											formaction="${ctx}/travel_approve_paid?expense_group_id=${expense_group_id}"
											class="btn btn-info px-6 ms-4">Paid</button>
									</c:when>
								</c:choose>

							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
		const ctx             = "${pageContext.request.contextPath}";
		const currentUserName = "${userObj.nameEN}";
		const hasSignature    = ${not empty signaturePath ? 'true' : 'false'};
		
		function validateReject(event) {
		    const description = document.querySelector('textarea[name="description_appr"]').value.trim();

		    if (description === "") {
		        event.preventDefault(); // หยุดการ Submit Form ทันที
		        
		    	Swal.fire({
					text : "Please enter a reason.",
					icon : "warning",
				});
		        
		        return false;
		    }
		   
		    return true;
		}
</script>
</body>
</html>