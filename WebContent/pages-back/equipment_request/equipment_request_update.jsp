<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/permission.tld" prefix="perm"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<fmt:setLocale value="en_US" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Equipment Request  | CubeSoftTech</title>

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

.meta-item.amount i {
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
								Equipment Request </h1>
							<ul
								class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
								<li class="breadcrumb-item text-muted">Home</li>
								<li class="breadcrumb-item"><span
									class="bullet bg-gray-400 w-5px h-2px"></span></li>
								<li class="breadcrumb-item text-muted">Cube Management</li>
							</ul>
						</div>

<%-- 						<c:choose> --%>
<%-- 							<c:when test="${empty catalogList}"> --%>

								<div class="row">
									<div class="col-xl-9 fs-1 text-primary fw-bold">#<span id="mr_id"></span></div>
									<div class="col-xl-3 ">
										<div class="btn btn-secondary btn-sm px-4" style="pointer-events: none;">Draft</div>
									</div>
								</div>
<%-- 							</c:when> --%>
<%-- 							<c:when test="${statusActiveSafe eq 'W'}"> --%>
<!-- 								<div class="btn btn-sm btn-light-warning border border-warning">Wait -->
<!-- 									for Approve</div> -->
<%-- 							</c:when> --%>
<%-- 							<c:when test="${statusActiveSafe eq 'C'}"> --%>
<!-- 								<div class="btn btn-sm btn-light-danger border border-danger">Canceled</div> -->
<%-- 							</c:when> --%>
<%-- 							<c:when test="${statusActiveSafe eq 'A'}"> --%>
<!-- 								<div class="btn btn-sm btn-light-success border border-success">Approved</div> -->
<%-- 							</c:when> --%>
<%-- 							<c:when test="${statusActiveSafe eq 'P'}"> --%>
<!-- 								<div class="btn btn-sm btn-light-info border border-info">Paid -->
<!-- 									Already</div> -->
<%-- 							</c:when> --%>
<%-- 							<c:when test="${statusActiveSafe eq 'R'}"> --%>
<!-- 								<div class="btn btn-sm btn-light-danger border border-danger">Rejected</div> -->
<%-- 							</c:when> --%>
<%-- 						</c:choose> --%>

					</div>
				</div>

							<div id="kt_app_content" class="app-content flex-column-fluid">
					<div id="kt_app_content_container"
						class="app-container container-fluid">

						<form id="equipment_request_create" method="post" action="${ctx}/equipment_request_list"
							enctype="multipart/form-data">

							<input type="hidden" id="grandTotalInput" name="amount"
								value="0.00" />

							<div class="card card-flush mb-7">
								<div class="card-header">
									<div class="card-title">
										<h3 class="fw-bold m-0">From Equipment Request</h3>
									</div>
								</div>

								<div class="card-body">
									<div class="row g-5 mb-5">
										<%-- Request Date --%>


										<%-- User --%>
										<c:set var="onlineUser" value="${sessionScope.onlineUser}" />
										<div class="col-md-12">
											<label class="form-label required fw-semibold">User</label>
											<div
												class="d-flex align-items-center bg-gray-100 border border-gray-300 rounded px-3 py-3">
												<div class="w-100">
													<input id="userId"
														class="form-control bg-transparent border-0 shadow-none p-0 fw-medium text-gray-900"
														value="${onlineUser.employeeId} - ${onlineUser.nameEN} - ${onlineUser.name} - ${onlineUser.departmentId}"
														style="width: 100%; font-size: 1rem;" readonly /> <input
														type="hidden" name="userId" value="${onlineUser.id}" />
												</div>
											</div>
										</div>
									</div>

									<div class="row g-5 mb-5">
										<%-- Day of departure --%>
										<div class="col-md-4">
											<label class="form-label required fw-semibold">item</label>
							        
							            <select class="form-select ps-11" id="userSelect" name="userSelect" style="width: 100%;"
							            onchange="getdataitem()">
							               <!-- ช่องตั้งต้นเมื่อเคลียร์คำค้นหา -->
							                <option value="All"> search </option>			
							<!--                     🆕 วนลูปข้อมูลแถวทั้งหมดจากเบื้องหลัง เพื่อสร้างเป็นตัวเลือกกางโชว์ตั้งแต่แรก -->
										<c:forEach var="itemEqptList" items="${catalogEqptList}">
										    <option value="${itemEqptList.id}" data-type="${itemEqptList.type}"
										    data-parent_product="${itemEqptList.parent_product_id}"
										    data-items_type="${itemEqptList.items_type}">
										        ${itemEqptList.name}
										    </option>
										</c:forEach>

						            </select>
			          
										</div>

										<%-- Purpose of journey --%>
										<div class="col-md-4">
											<label class="form-label required fw-semibold">Sub item</label>
										<select id="subItemSelect" class="form-select" data-placeholder="No Data" name="type" disabled>
											    <option value="allType">No data</option>
											    
											    <!-- 🔄 เปลี่ยน var จาก product_list ให้เหลือแค่ product ให้ตรงกับด้านล่างครับ -->
											    <c:forEach var="product" items="${ProductList}">
											        <option value="${product.product_id}"
											        data-parent_product="${product.parent_product_id} }">
											            ${product.product_name}
											        </option>
											    </c:forEach>
											</select>
										</div>
										
									<%-- Quantity --%>
										<div class="col-md-4">
											<label class="form-label required fw-semibold">Quantity</label>
											<div
												class="d-flex align-items-center border border-gray-300 rounded px-3 py-3">
												<input type="number"
													class="form-control bg-transparent border-0 shadow-none p-0 fw-medium text-gray-900"
													style="font-size: 1rem;" name="amount"
													id="amount"
													value="${param.amount}" required  maxlength="3"/>
											</div>
										</div>
									</div>

									<div class="row g-5 mb-5">
										<%-- Beginning --%>
										<div class="col-md-6">
											<label class="form-label required fw-semibold">Description</label>
											<div
												class="d-flex align-items-center border border-gray-300 rounded px-3 py-3">
												<textarea class="form-control bg-transparent border-0 shadow-none p-0 fw-medium text-gray-900"
										          style="font-size: 1rem; resize: none;" 
										          id="description" 
										          name="description"
										          rows="3" 
										          required> </textarea>
											</div>
										</div>
										<div class="col-md-6">
											<label class="form-label required fw-semibold">URL Reference</label>
											<div
												class="d-flex align-items-center border border-gray-300 rounded px-3 py-3">
												<textarea class="form-control bg-transparent border-0 shadow-none p-0 fw-medium text-gray-900"
										          style="font-size: 1rem; resize: none;" 
										          id="urlref" 
										          name="urlref"
										          rows="3" 
										          required> </textarea>
											</div>
										</div>

									
									</div>

								</div>
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
								<a href="${ctx}/equipment_request_list?status=All"
									class="btn btn-light px-6"><i
									class="ki-duotone ki-arrow-left fs-2"> <span class="path1"></span>
										<span class="path2"></span>
								</i>Back </a>
						<div>
						<button type="button" id="BtnSaveDreft" onclick="submitData(this)"  class="btn btn-secondary px-6">
							    Save Draft
						</button>		
						<button type="button" id="BtnSubmit_Equipment_Request" onclick="submitData(this)"  class="btn btn-success px-6">
							    Submit PR
						</button>
						</div>

<%-- 								<c:if test="${empty statusActiveSafe}"> --%>
<!-- 									<button type="submit" id="Submit_Equipment_Request" -->
<!-- 										class="btn btn-primary px-6"> -->
<!-- 										<i class="ki-duotone ki-send fs-4 me-2"> <span -->
<!-- 											class="path1"></span><span class="path2"></span> -->
<!-- 										</i> Submit Request -->
<!-- 									</button> -->
<%-- 								</c:if> --%>
								<c:if test="${statusActiveSafe == 'W'}">
									<a
										href="${ctx}/my_travel_group_cancel?expense_group_id=${expense_group_id}"
										class="btn btn-danger px-6">Cancel</a>
								</c:if>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
	

	
</script>
	
</body>
</html>