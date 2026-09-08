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
	height: 148px;
	border-radius: 10px;
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	position: relative;
	overflow: hidden;
	margin-top: 24px;
}

.sig-box.locked {
/* 	border: 2px solid #E4E6EF; */
/* 	background: #FFF; */
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
    padding-top: 5rem !important;
    padding-bottom: 5rem !important;
}
.p-user-request{
padding-top: 6rem;
    padding-bottom: 6rem;
    }
    
 .input-amount{
 width : 80%;border-top-right-radius: 0px !important;border-bottom-right-radius: 0px !important;
 }   
 .unit-style{
 width: 20%;
 text-align: center;
 align-items: center !important;
 display: inline-grid !important;
 border-top-right-radius: 10px !important;
 border-bottom-right-radius: 10px !important;
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
									<div class="col-xl-12">
										<div class="btn btn-primary btn-sm px-4" style="pointer-events: none;">New</div>
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
											<div class="d-flex justify-content-between">
											<label class="form-label required fw-semibold">item</label>
							        	<div>
							        	<div id="iconEquipment" style="display : none">							        	
								        	<div>
									        	<i class="ki-duotone ki-monitor-mobile text-primary fs-1"><span class="path1"></span><span class="path2"></span>
								                     <span class="path3"></span><span class="path4"></span>
								                     <span class="path5"></span><span class="path6"></span>
								                     <span class="path7"></span><span class="path8"></span>
							                     </i>
						                     </div>
						                    <div class="ms-2"> 
						                    	<span>Equipment</span>
						                    </div>
					                     </div>
					                     <div id="iconConsumables" style="display : none">
					                     	<div>
				                     			<i class="ki-duotone ki-lots-shopping fs-2 text-orange"><span class="path1"></span><span class="path2"></span>
								                     <span class="path3"></span><span class="path4"></span>
								                     <span class="path5"></span><span class="path6"></span>
								                     <span class="path7"></span><span class="path8"></span>
							                     </i>
							                </div>
							                <div class="ms-2">
							                     <span>Consumables</span>
							                 </div>
										 </div>
					                     </div>
					                     </div>
							        
							            <select class="form-select ps-11" id="itemSelect" name="itemSelect" style="width: 100%;"
							            onchange="getdataitem()">
							               <!-- ช่องตั้งต้นเมื่อเคลียร์คำค้นหา -->
							                <option value="All"> search </option>			
							<!--                     🆕 วนลูปข้อมูลแถวทั้งหมดจากเบื้องหลัง เพื่อสร้างเป็นตัวเลือกกางโชว์ตั้งแต่แรก -->
										<c:forEach var="itemEqptList" items="${catalogEqptList}">
										    <option value="${itemEqptList.id}" data-type="${itemEqptList.type}"
										    data-parent_product="${itemEqptList.parent_product_id}"
										    data-items_type="${itemEqptList.items_type}"
										    data-unit_name="${itemEqptList.unit_name}"
										    data-unit_id="${itemEqptList.unit_id}">
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
											        <option value="${product.productId}"
											        data-parent_product="${product.parentProductId} }">
											            ${product.productName}
											        </option>
											    </c:forEach>
											</select>
										</div>
										
									<%-- Quantity --%>
										<div class="col-md-4">
											<label class="form-label required fw-semibold">Quantity</label>
											<div class="d-flex">
												<div
													class="d-flex align-items-center border border-gray-300 rounded px-3 py-3 input-amount" 
													>
												<input type="number"
												       class="form-control bg-transparent border-0 shadow-none p-0 fw-medium text-gray-900"
												       style="font-size: 1rem;" 
												       name="amount"
												       id="amount"
												       value="${param.amount}" 
												       required  
												       step="1"
												       onblur="if(this.value !== '') { this.value = Math.trunc(this.value); }" />
													
												</div>
												<div class="align-items-center d-flex badge-secondary unit-style border border-gray-300">
													<span id="unit"></span>
												</div>
											</div>
										</div>
									</div>

									<div class="row g-5 mb-5">
										<%-- Beginning --%>
										<div class="col-md-6">
											<label class="form-label fw-semibold">Description</label>
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
											<label class="form-label fw-semibold">URL Reference</label>
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
										<div class="container">
												<div class="col-xl-2">
												<div>
													<label
														class="btn btn-primary btn-flex h-40px border-0 fw-medium w-100 d-flex justify-content-center align-items-center text-center mx-auto"
														id="lbFile" for="myFile" style="height: 44px;">
														Attach Files <input type="file" id="myFile" name="files"
														multiple style="display: none;"
														accept=".pdf, .doc, .docx, .xlsx, .pptx, .csv, .png, .jpg, .jpeg, .gif, .webp, .mp4" />
														<input type="hidden" name="filesUploadFileName"
														id="filesUploadFileName" /> <input type="hidden"
														name="fileUploadId" id="fileUploadId" />
													</label>	
													</div>
													<div id="oldFileList" class="d-flex flex-column mt-3 gap-2"></div>
																
													<div id="errorMsgAF" class="text-center text-danger mt-2"></div>
												</div>
											<div id="newFileList" class="d-flex mt-3 flex-wrap gap-5"></div>
												
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
								<div class="card-body">
									<div class="d-flex gap-8 flex-wrap align-items-start">

										<div style="border: 1px solid #e4e6ef;border-radius: 20px;">
										<!-- LEFT: Signature Image -->
										<div class="d-flex  flex-column align-items-center gap-2 ps-15 pe-15 pt-3 pb-4
										 <c:choose>
									        <c:when test="${not empty userObj.pathSignature}">pt-10 pb-11</c:when>
									    </c:choose>"> 
											<c:choose>
												<%-- ✅ มีรูปแล้ว → ล็อค ห้ามเปลี่ยน ไม่มี input file --%>
												<c:when test="${not empty userObj.pathSignature}">
													<div class="sig-box locked
																 <c:choose>
													        <c:when test="${not empty userObj.pathSignature}">m-0</c:when>
													    </c:choose>">
														<img src="${ctx}${userObj.pathSignature}"
															style="max-height: 160px; max-width: 360px; object-fit: contain;" />
														<div class="sig-lock-badge">
															<i class="ki-duotone ki-lock fs-7"> <span
																class="path1"></span><span class="path2"></span>
															</i> Signature on file
														</div>
													</div>
												</c:when>

												<%-- ✅ ไม่มีรูป → upload ได้ + มี input file ส่ง action --%>
												<c:otherwise>
													<c:choose>
														<c:when test="${empty statusActiveSafe}">
															<div class="sig-box uploadable" id="uploadSignatureBox"
																onclick="document.getElementById('sigFileInput').click()">
																<i class="ki-duotone ki-cloud-add fs-2x text-muted">
																	<span class="path1"></span><span class="path2"></span>
																</i> <span class="text-muted fs-8 mt-2">Click to
																	upload Signature</span>
															</div>
															<span class="text-muted fs-8">Allowed: png, jpg,
																jpeg</span>
															<%-- ✅ name="files" ตรงกับ Struts2 field files[] ใน TravelAction --%>
															<input type="file" id="sigFileInput" name="files"
																accept=".png,.jpg,.jpeg" style="display: none;" />
														</c:when>
														<c:otherwise>
															<div class="sig-box unuploadable" id="uploadSignatureBox">
																<i class="ki-duotone ki-cloud-add fs-2x text-muted">
																	<span class="path1"></span><span class="path2"></span>
																</i> <span class="text-muted fs-8 mt-2">The signature
																	has not been uploaded yet</span>
															</div>
														</c:otherwise>
													</c:choose>
												</c:otherwise>
											</c:choose>
										</div>
</div>
										<!-- MIDDLE: Receiver 1 = ผู้ขอเบิก -->
										<div
											class="receiver-box d-flex flex-fill flex-column align-items-center gap-2 p-user-request"
											id="receiverBox1">
											<c:choose>
												<c:when test="${empty statusActiveSafe}">
													<span class="text-muted fs-7" id="receiverLabel1">คลิ๊ก
														เพื่อยืนยันผู้ขอเบิกเงิน</span>
													<div id="receiverPreview1"
														style="min-height: 44px; display: none; flex-direction: column; align-items: center;">
													</div>
													<button type="button" class="btn btn-primary btn-sm px-5"
														id="receiverBtn1" onclick="confirmReceiver(1)">
														ลงชื่อ ผู้ขอเบิก</button>
												</c:when>
												<c:otherwise>
													<div id="receiverPreview1"
														style="min-height: 44px; display: none; flex-direction: column; align-items: center;">
														<span class="text-primary pb-7 fs-7" id="receiverLabel1">ชื่อ
															ผู้ขอเบิก</span>
														<div class="d-flex flex-column">
															<span class="text-dark fw-semibold fs-7">${userObj.nameEN}</span>
															<span class="text-muted fs-8"><fmt:formatDate
																	value="${requestAt}" pattern="d MMM yyyy, H:mm" /></span> 

														</div>
													</div>
												</c:otherwise>
											</c:choose>
										</div>

										<!-- RIGHT: Receiver 2 = ผู้รับเงิน -->
<!-- 										<div -->
<!-- 											class="receiver-box d-flex flex-fill flex-column align-items-center gap-2" -->
<!-- 											id="receiverBox2"> -->
<%-- 											<c:choose> --%>
<%-- 												<c:when test="${empty statusActiveSafe}"> --%>
<!-- 													<span class="text-muted fs-7" id="receiverLabel2">คลิ๊ก -->
<!-- 														เพื่อยืนยันผู้รับเงิน</span> -->
<!-- 													<div id="receiverPreview2" -->
<!-- 														style="min-height: 44px; display: flex; flex-direction: column; align-items: center;"> -->
<!-- 													</div> -->
<!-- 													<button type="button" class="btn btn-primary btn-sm px-5" -->
<!-- 														id="receiverBtn2" onclick="confirmReceiver(2)"> -->
<!-- 														ลงชื่อ ผู้รับ</button> -->

<%-- 												</c:when> --%>
<%-- 												<c:otherwise> --%>
<!-- 													<div id="receiverPreview2" -->
<!-- 														style="min-height: 44px; display: flex; flex-direction: column; align-items: center;"> -->
<!-- 														<span class="text-primary pb-7 fs-7" id="receiverLabel1">ชื่อ -->
<%-- 															ผู้รับเงิน</span> <span class="text-dark fw-semibold fs-7">${userObj.nameEN}</span> --%>
<%-- 														<span class="text-muted fs-8"><fmt:formatDate --%>
<%--  																value="${requestAt}" pattern="d MMM yyyy, H:mm" /></span>  --%>
<!-- 													</div> -->
<%-- 												</c:otherwise> --%>
<%-- 											</c:choose> --%>
<!-- 										</div> -->
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
						<button type="button" id="BtnSaveDraft" onclick="submitData(this)"  class="btn btn-secondary px-6">
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
<script src="${pageContext.request.contextPath}/assets/js/custom/utilities/attachFile/attcahfile.js"></script>

	<script>
		const ctx             = "${pageContext.request.contextPath}";
		const currentUserName = "${userObj.nameEN}";
		const hasSignature    = ${not empty userObj.pathSignature ? 'true' : 'false'};
		
		// ── ติดตาม state ──────────────────────────────────────────
		let confirmed1 = false;
		let confirmed2 = false;
		 var selectedFiles = []; 
		// ── เปิดใช้ Submit เมื่อทำครบ ──────────────────────────────
		function checkSubmitReady() {
		    const sigOk = hasSignature || document.getElementById('sigFileInput') &&
		                  document.getElementById('sigFileInput').files.length > 0;
		    const amount = document.getElementById('amount').value != ''
		    const itemSelect =	document.getElementById('itemSelect').value != ''  &&  document.getElementById('itemSelect').value != 'All'
			const subItemSelect = (document.getElementById('subItemSelect').value != '' && document.getElementById('subItemSelect').disabled != true) || document.getElementById('subItemSelect').disabled 
		    const ready = confirmed1 && sigOk && amount && itemSelect && subItemSelect;
		    document.getElementById('BtnSubmit_Equipment_Request').disabled = !ready;
		}
		
		// ── Upload Signature Preview ───────────────────────────────
		// ✅ ใช้ addEventListener เฉพาะตอนไม่มีรูป (element ถึงจะมีใน DOM)
	if (!hasSignature) {
    document.getElementById('sigFileInput').addEventListener('change', async function () { 
        console.log('เข้า uploadfile js');
        let file = this.files[0];
        if (!file) return;

        try {
       
            const processedFile = await processAndRemoveWhiteBg(file);
            
            const dt = new DataTransfer();
            dt.items.add(processedFile);
            this.files = dt.files;
            file = this.files[0];
        } catch (error) {
            console.error("Image processing failed", error);
        }

        const reader = new FileReader();
        reader.onload = function (e) {
            const box = document.getElementById('uploadSignatureBox');
            box.innerHTML = '<img src="' + e.target.result + '" style="max-height:160px;max-width:360px;object-fit:contain;" />';
        };
        reader.readAsDataURL(file);
        attachfilecallApi() 
    });
}
		
		// ── Confirm Receiver ──────────────────────────────────────
		function confirmReceiver(slot) {
		    const now = new Date();
		    const pad = n => String(n).padStart(2, '0');
		    const months = ['Jan','Feb','Mar','Apr','May','Jun',
		                    'Jul','Aug','Sep','Oct','Nov','Dec'];
		    const dateStr = now.getDate() + ' ' + months[now.getMonth()] + ' ' + now.getFullYear();
		    const timeStr = pad(now.getHours()) + ':' + pad(now.getMinutes());
		    const timestamp = dateStr + ' , ' + timeStr;
		
		    // แสดงชื่อ + เวลา
		    document.getElementById('receiverPreview' + slot).innerHTML =
		        '<span class="fw-semibold text-dark fs-7">' + currentUserName + '</span>' +
		        '<span class="text-muted fs-8 mt-1">' + timestamp + '</span>';
		
		    // ซ่อน label
		    document.getElementById('receiverLabel' + slot).style.display = 'none';
		
		    // เปลี่ยนปุ่มเป็น confirmed style + disable
		    const btn = document.getElementById('receiverBtn' + slot);
		    btn.textContent  = '✓ ยืนยันแล้ว';
		    btn.className    = 'btn btn-success btn-sm px-5';
		    btn.disabled     = true;
		
		    // เพิ่ม border เขียวให้ box
		    document.getElementById('receiverBox' + slot).classList.add('receiver-confirmed');
		  
		    if (slot === 1) confirmed1 = true;
// 		    if (slot === 2) confirmed2 = true;
		
		    checkSubmitReady();
		}
		
		// ── เช็ค initial state (กรณีมี signature แล้ว) ────────────
		checkSubmitReady();
	    function getFileIconPathLocal(fileName) {
	        var ext = fileName.split('.').pop().toLowerCase();
	        switch (ext) {
	            case 'pdf': return 'assets/media/svg/files/pdf.svg';
	            case 'doc': case 'docx': return 'assets/media/svg/files/doc.svg';
	            default: return 'assets/media/svg/files/folder-document.svg';
	        }
	    }
		
	// Image compression logic
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
					const ctx = canvas.getContext('2d');
					ctx.drawImage(img, 0, 0, width, height);

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
	
	 function submitData(id_btn) {
		 var item_catalog = $('#itemSelect').val() ? $('#itemSelect').val().trim() : '';
		 var quantity = $('#quantity').val() ? $('#quantity').val().trim() : '';
		 var description = $('#Description').val() ? $('#Description').val().trim() : '';
		    
		 var status;
		 if (id_btn.id == 'BtnSaveDraft') {
		     status = '0';
		 } else {
		     status = '2';
		 }
		 const formData = new FormData();
		     
		 // ชุดที่ 1: ลายเซ็น ยึดคีย์ 'files' ตามโมเดลเดิมของคุณ
		 const fileInput = document.getElementById('sigFileInput');
		 if (fileInput && fileInput.files.length > 0) {
		     formData.append('files', fileInput.files[0]); 
		     formData.append('filesFileName', fileInput.files[0].name);
		 } else {
		     formData.append('filesFileName', '');
		 }
		     
		 // ชุดที่ 2: ลิสต์ไฟล์แนบ (ยึดตามคีย์ระบบเดิมคือ fileUpload)
		 var inputFile = document.getElementById("myFile");

		 if (selectedFiles && selectedFiles.length > 0) {
		     
		     var dataTransfer = new DataTransfer();
		     selectedFiles.forEach(file => dataTransfer.items.add(file));
		     inputFile.files = dataTransfer.files;
		     
		     // วนลูปยัดกลุ่มไฟล์แนบเข้าคีย์ fileUpload (แมปเข้าลิสต์หลังบ้าน)
		     selectedFiles.forEach(file => {
		         formData.append('fileUpload', file); 
		     });
		     
		     // แปลงชื่อไฟล์แนบเป็นสตริงก์ JSON
		     var fileNames = selectedFiles.map(file => file.name);
		     var filesUploadFileNameEl = document.getElementById("filesUploadFileName");
		     if (filesUploadFileNameEl) {
		         filesUploadFileNameEl.value = JSON.stringify(fileNames);
		     }
		     
		     // ⚠️ ส่งชื่อไฟล์เป็น JSON String ผ่านคีย์ชื่อ 'filesUploadFileName' (ต้องตรงกับ Java)
		     formData.append('filesUploadFileName', JSON.stringify(fileNames));
		     
		     var fileUploadIdEl = document.getElementById("fileUploadId");
		     if (fileUploadIdEl) {
		         if (!fileUploadIdEl.value || fileUploadIdEl.value.trim() === "") {
		             fileUploadIdEl.value = "[]";
		         }
		         formData.append('fileUploadId', fileUploadIdEl.value);
		     }
		 }

		 // ยัดฟิลด์ข้อมูลอื่น ๆ
		 formData.append('catalog_items_id', item_catalog);
		 formData.append('amount', $('#amount').val());
		 formData.append('description', $('#description').val());
		 formData.append('request_user', $('#userId').val());
		 formData.append('item_sub_id', $('#subItemSelect').val());
		 formData.append('items_type', $('#itemSelect').find(':selected').attr('data-items_type'));
		 formData.append('status', status);
		 formData.append('url_ref', $('#urlref').val());
		 formData.append('action', "insert");

		 $.ajax({
		     url: ctx + '/equipment_request_save',
		     method: 'POST',
		     data: formData,
		     processData: false,   
		     contentType: false,   
		     success: function (res) {
		         $('#modal_equipment').modal('hide');
		         Swal.fire({
		             title: 'Success!',
		             text: 'Item saved successfully!',
		             icon: 'success',
		             timer: 1000,
		             timerProgressBar: true,
		             showConfirmButton: false
		         }).then(() => {
		             window.location.replace("equipment_request_list");	
		         });
		     },
		     error: function (xhr) {
		         console.error("HTTP Status:", xhr.status);
		         Swal.fire('Error!', 'Failed to submit return request.', 'error');
		     }
		 });

		}
	 
	   function renderNewFileList() {
	    	var fileListDiv = document.getElementById('newFileList');
	    	fileListDiv.innerHTML = "";
	        fileListDiv.innerHTML = ""; 

// 	        fileListDiv.style.display = "flex";
// 	        fileListDiv.style.flexDirection = "column"; 

	        if (selectedFiles.length > 0) {
	            selectedFiles.forEach(file => {
	                const fileName = file.name;
	                const lastDotIndex = fileName.lastIndexOf('.');
	                const nameOnly = fileName.substring(0, lastDotIndex);
	                const fileExt = fileName.substring(lastDotIndex); // .pdf
	                const iconPath = getFileIconPath(fileName);

	                const outerDiv = document.createElement('div');
	                outerDiv.className = 'p-2 rounded border text-gray-800';

	                outerDiv.innerHTML = `
	                    <div class="d-flex p-2 rounded" style="width: 18rem">
	                        <div class="d-flex text-decoration-none text-gray-800" style="flex-grow: 1;">
	                            <img src="` + iconPath + `" class="w-25px h-25px me-3" alt="icon" />
	                            <span class="fs-6 fw-medium">
	                                ` + nameOnly + `
	                                <span class="text-gray-800 fw-medium ms-1">` + fileExt + `</span>
	                            </span>
	                        </div>
	                        
	                        <span class="badge badge-light-danger bg-hover cursor-pointer delete-btn ms-3">
	                            <i class="ki-duotone ki-trash text-danger fs-2">
	                                <span class="path1"></span><span class="path2"></span>
	                                <span class="path3"></span><span class="path4"></span><span class="path5"></span>
	                            </i>
	                        </span>
	                    </div>
	                `;

	                outerDiv.querySelector('.delete-btn').addEventListener('click', function() {
	                    selectedFiles = selectedFiles.filter(f => f.name !== fileName);
	                    renderNewFileList(); 
	                    updateInputFiles(); 
	                });

	                fileListDiv.appendChild(outerDiv);
	            });
	        }
	    }
	   
	    function getFileIconPath(fileName) {
	        var ext = fileName.split('.').pop().toLowerCase();
	        switch (ext) {
	            case 'pdf': return 'assets/media/svg/files/pdf.svg';
	            case 'doc': case 'docx': return 'assets/media/svg/files/doc.svg';
	            default: return 'assets/media/svg/files/folder-document.svg';
	        }
	    }

	    function updateInputFiles() {
	        var inputFile = document.getElementById("myFile");
	        var dataTransfer = new DataTransfer();
	        selectedFiles.forEach(file => dataTransfer.items.add(file));
	        inputFile.files = dataTransfer.files;
	    }
	 
	   async function processFiles(fileListInput) {
	    	const maxSize = 2 * 1024 * 1024;
	        var oversizedFiles = [];

	        for (let i = 0; i < fileListInput.length; i++) {
	            const file = fileListInput[i];
	            const existing = selectedFiles.find(f => f.name === file.name && f.size === file.size);
	            
	            if (!existing) {
	                
	                if (file.type.match(/image\/(jpeg|jpg|png)/)) {
	                    const processedFile = await compressImage(file);
	                    selectedFiles.push(processedFile);
	                } else {
	                    if (file.size > maxSize) {
	                        oversizedFiles.push(file.name);
	                    } else {
	                        selectedFiles.push(file);
	                    }
	                }
	                const errorMsgAF = document.getElementById("errorMsgAF");
	                if (oversizedFiles.length > 0) {
	                    errorMsgAF.innerHTML = "Files exceed 2MB: <strong>" + oversizedFiles.join(", ") + "</strong>";
	                } else {
	                    errorMsgAF.textContent = "";
	                }
	            }
	            
	        }
	        renderNewFileList();
	        updateInputFiles();
	    }
	 
	 
	var dropdown
	var dataList
	$(document).ready(function() {
		
		   document.getElementById('myFile').addEventListener('change', function(event) {
		        processFiles(event.target.files);
		        console.log('stap1')
		    });
		
		$('#receiverBtn1').on('click', function() {
			$('#receiverBtn1').prev().css('display','flex')
			$('#receiverPreview1').css('display','flex')
			
		})
		
		<perm:permission object="admin">
		$("#dowpdownselectuser").prop("disabled", false);
		</perm:permission>
		
	
		$.ajax({
		    url: ctx + '/getauto_id_load',
		    method: 'GET', 
		    dataType: 'json',
		    success: function (res) {
		        // เอาเลขรหัสที่ได้จากหลังบ้าน ไปใส่ในช่องกรอกข้อมูล
		        if (res && res.nextMrId) {
		            dropdown = document.getElementById('subItemSelect'); subItemSelect
		            
		          	 dataList = Array.from(dropdown.options).map(option => {
					    // ดึงค่าแอตทริบิวต์ data-parent_product ออกมาลอย ๆ
					    var rawParent = option.getAttribute("data-parent_product"); 

					    // เคลียร์เอาเครื่องหมาย " }" และช่องว่างที่พิมพ์เกินออกให้เหลือแต่ตัวเลข
					    var cleanParent = rawParent ? rawParent.replace("}", "").trim() : null;
					
					    return {
					        value: option.value,
					        text: option.text.trim(), // ลบช่องว่างส่วนเกินรอบตัวหนังสือออกให้สวยงาม
					        parent_product: cleanParent // ได้ค่าเป็นตัวเลขคลีน ๆ เช่น "0" หรือ "1"
					    };
					})
		        }
		    },
		    error: function (xhr) {
		        console.error("HTTP Status:", xhr.status);
		        console.error("Error Response:", xhr.responseText);
		        Swal.fire('Error!', 'ไม่สามารถโหลดรหัสอัตโนมัติได้', 'error');
		    }
		});
		$("#dowpdownselectuser").select2({   placeholder: "ค้นหา...",
	        allowClear: true,
	        width: '100%',
	        tags: true, // ยอมรับคำพิมพ์ใหม่ๆ อิสระ
	        
	        createTag: function (params) {
	            var term = $.trim(params.term);
	            if (term === '') {
	                return null;
	            }
	            return {
	                id: term,
	                text: term,
	                newTag: true 
	            }
	        }}); 
	
	 $('#itemSelect').select2({
	        placeholder: "ค้นหา...",
	        allowClear: true,
	        width: '100%',
	        tags: true, // ยอมรับคำพิมพ์ใหม่ๆ อิสระ
	        
	        createTag: function (params) {
	            var term = $.trim(params.term);
	            if (term === '') {
	                return null;
	            }
	            return {
	                id: term,
	                text: term,
	                newTag: true 
	            }
	        }
	    });
	    $('input, select, textarea').on('input change', function() {
	        checkSubmitReady()
	    });
	    
//     $('#BtnSubmit_Equipment_Request').on('click', function () {
//     	submitData()
	        /* var url = CTX + '/' + (id ? 'item_catalog_update' : 'item_catalog_add'); */

	   
// 	        if (id) {
// 	            Swal.fire({
// 	                title: "Are you sure?!",
// 	                text: "Do you want to save the changes?",
// 	                icon: "warning",
// 	                showCancelButton: true,
// 	                confirmButtonText: "Save",
// 	                cancelButtonText: "Close"
// 	                buttonsStyling: false,
// 	                customClass: {
// 	                    confirmButton: "btn btn-success",
// 	                    cancelButton: "btn btn-secondary"
// 	                }
// 	            }).then((result) => {
// 	                if (result.isConfirmed) {
// 	                    submitData();
// 	                }
// 	            });
// 	        } else {
// 	            submitData();
// 	        }
// 	    });
	 
	});

	function getdataitem(){
	    console.log('--- เริ่มรันฟังก์ชัน getdataitem ---');      
	        var subDropdown = $('#subItemSelect');
// 	        subDropdown.empty().append('<option value="">No data</option>');
	        
	        // ตัวแปรไว้เช็คสถานะการปลดล็อค
	        var shouldUnlock = false;
	        
			   const filteredResult = dataList.filter(item => {
			    // กรองเอาแถวเริ่มต้นติดมาด้วย และคัดเฉพาะตัวที่ idProduct ตรงกัน
			    return item.parent_product == $('#itemSelect').val()
// 			    && item.parent_product == $('#itemSelect').find(':selected').attr('data-parent_product') 
			    && item.parent_product != 0 && item.value != 'allType'
				});
	         
		         if(filteredResult.length != 0){
		        	 shouldUnlock = true
		        	 subDropdown.empty().append('<option value="">Search</option>');
		         }else{
		        	 subDropdown.empty().append('<option value="">No data</option>');
		        	 shouldUnlock = false 
		         }
	         
	         filteredResult.forEach(item => {
	        	 shouldUnlock = true
	        	    // ใส่เครื่องหมาย ' ครอบตัว value และดึงค่า text มาแสดงผล
	        	    $('#subItemSelect').append("<option value='" + item.value + "'>" + item.text + "</option>");
	        	});
	          
	        if (shouldUnlock) {
	            subDropdown.prop('disabled', false); // ปลดล็อคกล่อง (ลบ disabled ออก) ให้กดได้ปกติ
	        } else {
	            subDropdown.prop('disabled', true);  // หากไม่ตรงเงื่อนไข ให้ล็อคไว้ตามเดิม
	        }
           	
            if (typeof subDropdown.trigger === 'function') {
                subDropdown.trigger('change'); 
            }
            
            $('#unit').text( $('#itemSelect').find(':selected').attr('data-unit_name'))
            setTypeProduct()
	}
    function setTypeProduct(){
   	 if($('#itemSelect').find(':selected').attr('data-items_type') == '1'){
			 $('#iconEquipment').css('display','flex')
			 $('#iconConsumables').css('display','none')
		 }else{
			 $('#iconEquipment').css('display','none')
			 $('#iconConsumables').css('display','flex') 
		 }
   }
    
    function attachfilecallApi() {	
    	const formData = new FormData();
    	const fileInput = document.getElementById('sigFileInput');

    	if (fileInput && fileInput.files.length > 0) {
    	    // ส่งคีย์เป็น fileUpload ตามโครงสร้างของ Java Struts2
    	    formData.append('fileUpload', fileInput.files[0]); 
    	    formData.append('fileUploadFileName', fileInput.files[0].name);
    	} else {
    	    formData.append('fileUploadFileName', '');
    	}

    	fetch(ctx + '/update_signature', {
    	    method: 'POST',
    	    headers: { 'X-Requested-With': 'XMLHttpRequest' },
    	    body: formData 
    	})
    	.then(function (res) { return res.json(); })
    	.then(function (data) {
    	    if (data.success) {
    	        // อัปเดตและอัปโหลดไฟล์สำเร็จ -> รีโหลดหน้าเว็บทันที
    	        window.location.reload();
    	    } else {
    	        console.error('Update failed:', data.message);
    	        alert(data.message || 'เกิดข้อผิดพลาดจากระบบ');
    	    }
    	})
//     	.catch(function (err) {
//     	    console.error('Update error:', err);
//     	    alert('ไม่สามารถเชื่อมต่อกับเซิร์ฟเวอร์ได้');
//     	});
	}
</script>
	
</body>
</html>