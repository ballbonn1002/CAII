<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<fmt:setLocale value="en_US" />

<%-- =====================================================================
     OLD: desktop My Travel edit (disabled, kept for reference)
     ===================================================================== --%>
<%--
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Edit My Travel | CubeSoftTech</title>

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
.table thead th {
	background-color: #F9F9F9;
	text-transform: uppercase;
	font-size: .75rem;
	color: #A1A5B7;
}

.breadcrumb-item+.breadcrumb-item::before {
	content: "-" !important;
}

.card.card-flush>.card-header {
	border-bottom: 1px solid #EEF0F3 !important;
}

#expenseTable thead th {
	background-color: #fff !important;
	color: #181c32 !important;
}

#expenseModal .modal-body {
	overflow-y: auto !important;
	overflow-x: hidden !important;
	max-height: 60vh !important;
}

.select2-container--open {
	z-index: 9999 !important;
}

.select2-dropdown {
	z-index: 9999 !important;
}
</style>
</head>

<body id="kt_app_body" class="app-default">

	<c:set var="ctx" value="${pageContext.request.contextPath}" />
	<c:set var="onlineUser" value="${sessionScope.onlineUser}" />

	<div class="d-flex flex-column flex-root" id="kt_app_root">
		<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
			<div class="d-flex flex-column flex-column-fluid">

				<!-- Toolbar -->
				<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
					<div id="kt_app_toolbar_container"
						class="app-container container-fluid d-flex align-items-center">
						<div
							class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
							<h1
								class="page-heading d-flex text-dark fw-bold fs-3 flex-column justify-content-center my-0">
								My Travel</h1>
							<ul
								class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
								<li class="breadcrumb-item text-muted">Home</li>
								<li class="breadcrumb-item"><span
									class="bullet bg-gray-400 w-5px h-2px"></span></li>
								<li class="breadcrumb-item text-muted">Cube Management</li>
							</ul>
						</div>
					</div>
				</div>

				<!-- Content -->
				<div id="kt_app_content" class="app-content flex-column-fluid">
					<div id="kt_app_content_container"
						class="app-container container-fluid">

						<form id="travelEditForm" method="post"
							action="${ctx}/travel_update" enctype="multipart/form-data">

							<input type="hidden" name="expenseId"
								value="${expenseObj.expenseId}" /> <input type="hidden"
								name="expenseGroupId" value="${expenseObj.expenseGroupId}" /> <input
								type="hidden" id="grandTotalInput" name="amount"
								value="${expenseObj.amount}" /> <input type="hidden"
								name="filesUploadFileName" id="filesUploadFileName" /> <input
								type="hidden" name="fileUploadId" id="fileUploadId" value="[]" />

							<!-- ===== Record travel expense form ===== -->
							<div class="card card-flush mb-7">
								<div class="card-header">
									<div class="card-title">
										<h3 class="fw-bold m-0">Record travel expense form</h3>
									</div>
								</div>

								<div class="card-body">

									<!-- Row 1 -->
									<div class="row g-5 mb-5">

--%>
										<%-- Request Date --%>
<%--
										<div class="col-md-4">
											<label class="form-label required fw-semibold">Request
												Date</label>
											<div
												class="d-flex align-items-center bg-gray-100 border border-gray-300 rounded px-3 py-3">
												<i class="ki-duotone ki-calendar fs-1 me-3 text-muted">
													<span class="path1"></span><span class="path2"></span>
												</i> <input type="hidden" id="requestDateVal" name="requestDate"
													value="<fmt:formatDate value='${expenseObj.timeCreate}' pattern='yyyy-MM-dd'/>" />
												<input type="text"
													class="form-control bg-transparent border-0 shadow-none p-0 fw-medium text-gray-900"
													style="font-size: 1rem;" id="requestDate"
													placeholder="DD MMM YYYY" readonly />
											</div>
										</div>

--%>
										<%-- User --%>
<%--
										<div class="col-md-8">
											<label class="form-label required fw-semibold">User</label>
											<div
												class="d-flex align-items-center bg-gray-100 border border-gray-300 rounded px-3 py-3">
												<i class="ki-duotone ki-magnifier fs-1 me-4 text-muted">
													<span class="path1"></span><span class="path2"></span>
												</i>
												<div class="w-100">
													<select id="userId"
														class="form-select bg-transparent border-0 shadow-none p-0 fw-medium text-gray-900"
														data-control="select2"
														style="width: 100%; font-size: 1rem;" disabled>
														<option value=""></option>
														<c:forEach var="u" items="${userListObj}">
															<c:set var="enabled" value="${u['enable']}" />
															<c:if test="${enabled == 1 || enabled == '1'}">
																<c:set var="uid"
																	value="${not empty u['id'] ? u['id'] : ''}" />
																<c:set var="emp"
																	value="${not empty u['employee_id'] ? u['employee_id'] : ''}" />
																<c:set var="nameEN"
																	value="${not empty u['name_en'] ? u['name_en'] : ''}" />
																<c:set var="nameTH"
																	value="${not empty u['name'] ? u['name'] : ''}" />
																<c:set var="dept"
																	value="${not empty u['department'] ? u['department'] : ''}" />
																<option value="${uid}"
																	<c:if test="${expenseObj.userId == uid}">selected</c:if>>
																	${emp} - ${nameEN} - ${nameTH} - ${dept}</option>
															</c:if>
														</c:forEach>
													</select> <input type="hidden" name="userId"
														value="${expenseObj.userId}" />
												</div>
											</div>
										</div>
									</div>

									<!-- Row 2 -->
									<div class="row g-5 mb-5">

--%>
										<%-- Day of departure --%>
<%--
										<div class="col-md-4">
											<label class="form-label required fw-semibold">Day of
												departure</label>
											<div
												class="d-flex align-items-center border border-gray-300 rounded px-3 py-3">
												<i class="ki-duotone ki-calendar fs-1 me-3 text-muted">
													<span class="path1"></span><span class="path2"></span>
												</i> <input type="hidden" id="departureDateVal"
													name="departureDate"
													value="<fmt:formatDate value='${expenseObj.dtStart}' pattern='yyyy-MM-dd'/>" />
												<input type="text"
													class="form-control bg-transparent border-0 shadow-none p-0 fw-medium text-gray-900"
													style="font-size: 1rem;" id="departureDate"
													placeholder="DD MMM YYYY" />
											</div>
										</div>

--%>
										<%-- Purpose of journey --%>
<%--
										<div class="col-md-8">
											<label class="form-label required fw-semibold">Purpose
												of journey</label>
											<div
												class="d-flex align-items-center border border-gray-300 rounded px-3 py-3">
												<input type="text"
													class="form-control bg-transparent border-0 shadow-none p-0 fw-medium text-gray-900"
													style="font-size: 1rem;" id="purposeOfJourney"
													name="purposeOfJourney"
													placeholder="Enter purpose of journey"
													value="${expenseObj.description}" required />
											</div>
										</div>
									</div>

									<!-- Row 3 -->
									<div class="row g-5 mb-5">

--%>
										<%-- Beginning --%>
<%--
										<div class="col-md-3">
											<label class="form-label required fw-semibold">Beginning</label>
											<div
												class="d-flex align-items-center border border-gray-300 rounded px-3 py-3">
												<input type="text"
													class="form-control bg-transparent border-0 shadow-none p-0 fw-medium text-gray-900"
													style="font-size: 1rem;" id="beginning" name="beginning"
													placeholder="e.g. Head Office"
													value="${expenseObj.fromLocation}" required />
											</div>
										</div>

--%>
										<%-- Beginning Time --%>
<%--
										<div class="col-md-3">
											<label class="form-label required fw-semibold">Beginning
												Time</label>
											<div
												class="d-flex align-items-center border border-gray-300 rounded px-3 py-3">
												<input type="text"
													class="form-control bg-transparent border-0 shadow-none p-0 fw-medium text-gray-900"
													style="font-size: 1rem;" id="beginTime" name="beginTime"
													placeholder="HH:mm"
													value="<fmt:formatDate value='${expenseObj.dtStart}' pattern='HH:mm'/>"
													required />
											</div>
										</div>

--%>
										<%-- Destination --%>
<%--
										<div class="col-md-3">
											<label class="form-label required fw-semibold">Destination</label>
											<div
												class="d-flex align-items-center border border-gray-300 rounded px-3 py-3">
												<input type="text"
													class="form-control bg-transparent border-0 shadow-none p-0 fw-medium text-gray-900"
													style="font-size: 1rem;" id="destination"
													name="destination" placeholder="e.g. Customer site"
													value="${expenseObj.toLocation}" required />
											</div>
										</div>

--%>
										<%-- Destination Time --%>
<%--
										<div class="col-md-3 mb-3">
											<label class="form-label required fw-semibold">Destination
												Time</label>
											<div
												class="d-flex align-items-center border border-gray-300 rounded px-3 py-3">
												<input type="text"
													class="form-control bg-transparent border-0 shadow-none p-0 fw-medium text-gray-900"
													style="font-size: 1rem;" id="destTime" name="destTime"
													placeholder="HH:mm"
													value="<fmt:formatDate value='${expenseObj.dtEnd}' pattern='HH:mm'/>"
													required />
											</div>
										</div>
									</div>

									<!-- Row 4: Attach Files -->
									<div class="row g-5">
										<div class="col-12">
											<div class="rounded">
												<div class="d-flex align-items-center flex-wrap gap-3">
													<label
														class="btn btn-primary h-40px border-0 fw-medium"
														for="travelFiles"> Attach files <input type="file" id="travelFiles"
														name="files" multiple style="display: none;"
														accept=".pdf,.doc,.docx,.xlsx,.pptx,.csv,.png,.jpg,.jpeg,.gif,.webp,.mp4" />
													</label>

													<div id="travelFileList"
														class="d-flex flex-wrap align-items-center gap-3">
--%>
														<%-- existing files — icon ตาม extension --%>
<%--
														<c:forEach var="f" items="${travelFiles}">
															<c:set var="ftype" value="${f.type}" />
															<c:choose>
																<c:when test="${ftype == '.pdf'}">
																	<c:set var="ficon"
																		value="${ctx}/assets/media/svg/files/pdf.svg" />
																</c:when>
																<c:when test="${ftype == '.doc' || ftype == '.docx'}">
																	<c:set var="ficon"
																		value="${ctx}/assets/media/svg/files/doc.svg" />
																</c:when>
																<c:when test="${ftype == '.xls' || ftype == '.xlsx'}">
																	<c:set var="ficon"
																		value="${ctx}/assets/media/svg/files/xls.svg" />
																</c:when>
																<c:when test="${ftype == '.ppt' || ftype == '.pptx'}">
																	<c:set var="ficon"
																		value="${ctx}/assets/media/svg/files/ppt.svg" />
																</c:when>
																<c:when test="${ftype == '.csv'}">
																	<c:set var="ficon"
																		value="${ctx}/assets/media/svg/files/csv.svg" />
																</c:when>
																<c:when
																	test="${ftype == '.png' || ftype == '.jpg' || ftype == '.jpeg' || ftype == '.gif' || ftype == '.webp'}">
																	<c:set var="ficon"
																		value="${ctx}/assets/media/svg/files/jpg.svg" />
																</c:when>
																<c:when test="${ftype == '.mp4'}">
																	<c:set var="ficon"
																		value="${ctx}/assets/media/svg/files/mp4.svg" />
																</c:when>
																<c:otherwise>
																	<c:set var="ficon"
																		value="${ctx}/assets/media/svg/files/folder-document.svg" />
																</c:otherwise>
															</c:choose>

															<div
																class="d-flex align-items-center gap-2 px-3 py-2 rounded bg-light border border-gray-200 existing-file-row"
																data-file-id="${f.fileId}">
																<img src="${ficon}" class="w-25px h-25px flex-shrink-0"
																	alt="icon" /> <a href="${ctx}${f.path}"
																	target="_blank"
																	class="fs-7 fw-medium text-gray-800 text-hover-primary text-truncate"
																	style="max-width: 130px;"> ${f.name}<span
																	class="text-muted">${f.type}</span>
																</a> <span
																	class="btn-del-existing-file cursor-pointer flex-shrink-0"
																	data-file-id="${f.fileId}"> <i
																	class="ki-duotone ki-trash text-danger fs-4"> <span
																		class="path1"></span><span class="path2"></span> <span
																		class="path3"></span><span class="path4"></span><span
																		class="path5"></span>
																</i>
																</span>
															</div>
														</c:forEach>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>

							<!-- ===== Expense Items ===== -->
							<div class="card card-flush mb-7">
								<div class="card-header">
									<div class="card-title">
										<h3 class="fw-bold m-0">Expense form</h3>
									</div>
									<div class="card-toolbar">
										<button type="button" class="btn btn-sm btn-success"
											id="btnCreateExpense">
											<i class="ki-duotone ki-plus fs-5 me-1"></i> Create
										</button>
									</div>
								</div>

								<div class="card-body">
									<div class="table-responsive">
										<table class="table align-middle table-row-bordered fs-7"
											id="expenseTable">
											<thead>
												<tr>
													<th style="width: 60px;">#</th>
													<th>GO BY</th>
													<th>DESCRIPTION</th>
													<th style="width: 160px;" class="text-end">TOTAL</th>
													<th style="width: 100px;" class="text-end">ACTION</th>
												</tr>
											</thead>
											<tbody id="expenseTbody">
												<tr id="noDataRow"
													<c:if test="${not empty detailList}">style="display:none"</c:if>>
													<td colspan="5" class="text-center text-muted py-8">No
														Data</td>
												</tr>

												<c:forEach var="d" items="${detailList}" varStatus="st">
													<tr class="expense-row">
														<td class="row-no">${st.index + 1}</td>
														<td><c:set var="goName" value="-" /> <c:forEach
																var="t" items="${expTravelTypeList}">
																<c:if test="${t.expTravelTypeId == d.goBy}">
																	<c:set var="goName" value="${t.name}" />
																</c:if>
															</c:forEach> <c:out value="${goName}" /> <input type="hidden"
															name="detailGoBy" value="${d.goBy}" /> <input
															type="hidden" name="detailKilometers"
															value="${d.kilometers}" /></td>
														<td><c:out
																value="${empty d.description ? '-' : d.description}" />
															<input type="hidden" name="detailDescription"
															value="${d.description}" /></td>
														<td class="text-end"><fmt:formatNumber
																value="${d.total}" minFractionDigits="2"
																maxFractionDigits="2" /> <input type="hidden"
															name="detailTotal" value="${d.total}" /></td>
														<td class="text-end">
															<div class="d-flex justify-content-end gap-2">
																<button type="button"
																	class="btn btn-icon btn-sm btn-light-primary btn-edit-row"
																	title="Edit">
																	<i class="ki-duotone ki-pencil fs-4"><span
																		class="path1"></span><span class="path2"></span></i>
																</button>
																<button type="button"
																	class="btn btn-icon btn-sm btn-light-danger btn-remove-row"
																	title="Remove">
																	<i class="ki-duotone ki-trash fs-4"><span
																		class="path1"></span><span class="path2"></span><span
																		class="path3"></span></i>
																</button>
															</div>
														</td>
													</tr>
												</c:forEach>
											</tbody>
											<tfoot>
												<tr class="border-top border-gray-200">
													<td class="fw-normal text-gray-900 fs-6 py-4">Total</td>
													<td></td>
													<td></td>
													<td class="text-end fw-normal text-gray-900 fs-6 py-4">
														<span id="grandTotal">0.00</span>
													</td>
													<td></td>
												</tr>
											</tfoot>
										</table>
									</div>

									<div class="d-flex justify-content-end gap-3 mt-6">
										<a href="${ctx}/my_travel?status=Draft" class="btn btn-light">Cancel</a>
										<button type="submit" id="btnSubmitSave"
											class="btn btn-success" disabled>Save</button>
									</div>
								</div>
							</div>

						</form>

						<!-- ===== Expense Modal ===== -->
						<div class="modal fade" id="expenseModal" tabindex="-1"
							aria-hidden="true">
							<div class="modal-dialog modal-dialog-scrollable modal-lg">
								<div class="modal-content">

									<div class="modal-header">
										<h3 class="fw-bold m-0">Add expense detail</h3>
										<button type="button"
											class="btn btn-icon btn-sm btn-active-light-primary"
											data-bs-dismiss="modal" aria-label="Close">
											<i class="ki-duotone ki-cross fs-2"><span class="path1"></span>
 												<span class="path2"></span></i>
										</button>
									</div>

									<div class="modal-body">
										<div class="mb-5">
											<label class="form-label fw-semibold required">Go by</label>
											<select id="mGoBy" class="form-select" data-control="select2"
											data-dropdown-parent="#expenseModal"
												data-placeholder="Select go by" required>
												<option value=""></option>
												<c:forEach var="t" items="${expTravelTypeList}">
													<option value="${t.expTravelTypeId}">
														<c:out value="${t.name}" />
													</option>
												</c:forEach>
											</select>
										</div>
										<div class="mb-5" id="distanceGroup" style="display: none;">
											<div class="row g-4 align-items-end">
												<div class="col-6">
													<label class="form-label fw-semibold required">Distance</label>
													<div class="input-group">
														<input id="mKilometers" type="number" class="form-control"
															min="0" step="0.01" placeholder="0" /> <span
															class="input-group-text">Km.</span>
													</div>
												</div>
												<div class="col-6">
													<label
														class="form-label fw-semibold d-flex justify-content-between w-100">
														<span class="required">Total</span> <span
														class="text-muted fw-normal">7 บาท / Km</span>
													</label>
													<div class="input-group">
														<input id="mTotal" type="number" class="form-control"
															style="text-align: left;" min="0" step="0.01"
															placeholder="0.00" required /> <span
															class="input-group-text">บาท</span>
													</div>
												</div>
											</div>
										</div>
										<div class="mb-5" id="totalGroupNormal">
											<label class="form-label fw-semibold required">Total</label>
											<div class="input-group">
												<input id="mTotalNormal" type="number" class="form-control"
													style="text-align: left;" min="0" step="0.01"
													placeholder="0.00" required /> <span
													class="input-group-text">บาท</span>
											</div>
										</div>
										<div class="mb-0">
											<label class="form-label fw-semibold">Description</label>
											<textarea id="mDescription" class="form-control" rows="3"
												placeholder="Description"></textarea>
										</div>
									</div>

									<div class="modal-footer">
										<button type="button" class="btn btn-light"
											data-bs-dismiss="modal">Cancel</button>
										<button type="button" id="btnModalSave"
											class="btn btn-success" disabled>Save</button>
									</div>
								</div>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
		(function() {

			var CAR_PRIVATE_ID = "6";
			var RATE_PER_KM = 7;

			// icon ตาม extension — ใช้ทั้ง existing และ new files
			var ctx = "${ctx}";
			function getFileIcon(fileName) {
				var ext = (fileName || '').split('.').pop().toLowerCase();
				var base = ctx + '/assets/media/svg/files/';
				switch (ext) {
				case 'pdf':
					return base + 'pdf.svg';
				case 'doc':
				case 'docx':
					return base + 'doc.svg';
				case 'xls':
				case 'xlsx':
					return base + 'xls.svg';
				case 'ppt':
				case 'pptx':
					return base + 'ppt.svg';
				case 'csv':
					return base + 'csv.svg';
				case 'png':
				case 'jpg':
				case 'jpeg':
				case 'gif':
				case 'webp':
					return base + 'jpg.svg';
				case 'mp4':
					return base + 'mp4.svg';
				default:
					return base + 'folder-document.svg';
				}
			}

			function initSelect2(el, opts) {
				if (!el)
					return;
				if (window.$ && $(el).select2) {
					if ($(el).data("select2"))
						return;
					$(el).select2(Object.assign({
						allowClear : true,
						width : "resolve"
					}, opts || {}));
				}
			}

			var MONTH_SHORT = [ "Jan", "Feb", "Mar", "Apr", "May", "Jun",
					"Jul", "Aug", "Sep", "Oct", "Nov", "Dec" ];

			function toIsoDate(dateObj) {
				if (!dateObj)
					return "";
				var y = dateObj.getFullYear();
				var m = String(dateObj.getMonth() + 1).padStart(2, "0");
				var d = String(dateObj.getDate()).padStart(2, "0");
				return y + "-" + m + "-" + d;
			}

			function toDisplayDate(dateObj) {
				if (!dateObj)
					return "";
				var d = String(dateObj.getDate()).padStart(2, "0");
				return d + " " + MONTH_SHORT[dateObj.getMonth()] + " "
						+ dateObj.getFullYear();
			}

			function parseIso(isoStr) {
				if (!isoStr)
					return null;
				var p = isoStr.split("-");
				if (p.length !== 3)
					return null;
				return new Date(parseInt(p[0]), parseInt(p[1]) - 1,
						parseInt(p[2]));
			}

			function escapeHtml(s) {
				return (s || "").replace(/[&<>"']/g, function(c) {
					return {
						"&" : "&amp;",
						"<":"&lt;", ">" : "&gt;",
						'"' : "&quot;",
						"'" : '&#39;'
					}[c];
				});
			}

			function escapeAttr(s) {
				return (s || "").replace(/["']/g, function(c) {
					return c === '"' ? "&quot;" : "&#39;";
				});
			}

			// ===== Request Date (readonly) =====
			var reqDateEl = document.getElementById("requestDate");
			var reqDateValEl = document.getElementById("requestDateVal");
			if (reqDateEl) {
				var isoVal = reqDateValEl ? reqDateValEl.value : "";
				if (isoVal) {
					var d = parseIso(isoVal);
					if (d)
						reqDateEl.value = toDisplayDate(d);
				} else {
					reqDateEl.value = toDisplayDate(new Date());
					if (reqDateValEl)
						reqDateValEl.value = toIsoDate(new Date());
				}
				reqDateEl.setAttribute("readonly", "readonly");
			}

			// ===== User select2 (disabled) =====
			initSelect2(document.getElementById("userId"));

			var modalEl = document.getElementById("expenseModal");
			initSelect2(document.getElementById("mGoBy"), {
				dropdownParent : $(modalEl),
				width : "100%"
			});

			// ===== Day of departure flatpickr =====
			var depDisplayEl = document.getElementById("departureDate");
			var depValEl = document.getElementById("departureDateVal");
			if (depDisplayEl && typeof flatpickr !== "undefined") {
				flatpickr(
						depDisplayEl,
						{
							defaultDate : "today",
							dateFormat : "d M Y",
							allowInput : false,
							onChange : function(selectedDates) {
								if (depValEl)
									depValEl.value = selectedDates.length > 0 ? toIsoDate(selectedDates[0])
											: "";

								// อัปเดตสถานะปุ่มเมื่อเลือกวันที่
								checkSubmitState();
							},
							onReady : function(selectedDates, dateStr, fp) {
								if (depValEl) {
									if (depValEl.value) {
										var p = depValEl.value.split("-");
										if (p.length === 3)
											fp.setDate(new Date(parseInt(p[0]),
													parseInt(p[1]) - 1,
													parseInt(p[2])), false);
									} else if (selectedDates.length > 0) {
										depValEl.value = toIsoDate(selectedDates[0]);
									}
								}
							}
						});
			}

			// ===== Time pickers =====
			function initTime(id) {
				var el = document.getElementById(id);
				if (!el || typeof flatpickr === "undefined")
					return;

				flatpickr(el, {
					enableTime : true,
					noCalendar : true,
					dateFormat : "H:i",
					time_24hr : true,
					allowInput : true,

					onReady : function(selectedDates, dateStr, instance) {

						instance.input.addEventListener("input", function(e) {
							// อนุญาตเฉพาะ 0-9 และ :
							this.value = this.value.replace(/[^0-9:]/g, "");
						});

					},

					onChange : function() {
						checkSubmitState();
					}
				});
			}
			initTime("beginTime");
			initTime("destTime");

			// ===== Expense table =====
			var tbody = document.getElementById("expenseTbody");
			var noDataRow = document.getElementById("noDataRow");
			var grandTotalEl = document.getElementById("grandTotal");
			var grandTotalInput = document.getElementById("grandTotalInput");
			var btnModalSave = document.getElementById("btnModalSave");
			var btnSubmitSave = document.getElementById("btnSubmitSave");

			// (เช็ค Required Fields ของหน้าหลัก):
			function checkSubmitState() {
				if (!btnSubmitSave)
					return;

				var rowCount = tbody.querySelectorAll("tr.expense-row").length;
				var hasExpenseRows = (rowCount > 0);

				var valDeparture = document.getElementById("departureDate") ? document
						.getElementById("departureDate").value.trim()
						: "";
				var valPurpose = document.getElementById("purposeOfJourney") ? document
						.getElementById("purposeOfJourney").value.trim()
						: "";
				var valBeginning = document.getElementById("beginning") ? document
						.getElementById("beginning").value.trim()
						: "";
				var valBeginTime = document.getElementById("beginTime") ? document
						.getElementById("beginTime").value.trim()
						: "";
				var valDestination = document.getElementById("destination") ? document
						.getElementById("destination").value.trim()
						: "";
				var valDestTime = document.getElementById("destTime") ? document
						.getElementById("destTime").value.trim()
						: "";

				var allRequiredFilled = (valDeparture !== ""
						&& valPurpose !== "" && valBeginning !== ""
						&& valBeginTime !== "" && valDestination !== "" && valDestTime !== "");

				if (hasExpenseRows && allRequiredFilled) {
					btnSubmitSave.removeAttribute("disabled");
				} else {
					btnSubmitSave.setAttribute("disabled", "disabled");
				}
			}

			// (เช็ค Required Fields ของ Modal):
			function checkModalSubmitState() {
				if (!btnModalSave)
					return;

				var goSel = document.getElementById("mGoBy");
				var goByVal = goSel ? goSel.value.trim() : "";

				var isCar = (goByVal === CAR_PRIVATE_ID);
				var isValid = false;

				if (goByVal !== "") {
					if (isCar) {
						var kmVal = document.getElementById("mKilometers") ? document
								.getElementById("mKilometers").value.trim()
								: "";
						var totalVal = document.getElementById("mTotal") ? document
								.getElementById("mTotal").value.trim()
								: "";
						// เช็คว่ากรอกทั้ง Distance และ Total
						if (kmVal !== "" && totalVal !== "") {
							isValid = true;
						}
					} else {
						var totalNormalVal = document
								.getElementById("mTotalNormal") ? document
								.getElementById("mTotalNormal").value.trim()
								: "";
						// เช็คว่ากรอก Total (กรณีปกติ)
						if (totalNormalVal !== "") {
							isValid = true;
						}
					}
				}

				if (isValid) {
					btnModalSave.removeAttribute("disabled");
				} else {
					btnModalSave.setAttribute("disabled", "disabled");
				}
			}

			// ผูก Event ฝั่งหน้าหลัก
			var requiredInputIds = [ "departureDate", "purposeOfJourney",
					"beginning", "beginTime", "destination", "destTime" ];
			requiredInputIds.forEach(function(id) {
				var el = document.getElementById(id);
				if (el) {
					el.addEventListener("input", checkSubmitState);
					el.addEventListener("change", checkSubmitState);
				}
			});

			// ผูก Event ฝั่ง Modal Inputs
			var modalInputIds = [ "mKilometers", "mTotal", "mTotalNormal" ];
			modalInputIds.forEach(function(id) {
				var el = document.getElementById(id);
				if (el) {
					el.addEventListener("input", checkModalSubmitState);
				}
			});

			function reindex() {
				tbody.querySelectorAll("tr.expense-row").forEach(
						function(row, idx) {
							var no = row.querySelector(".row-no");
							if (no)
								no.textContent = String(idx + 1);
						});
			}

			function calcTotal() {
				var sum = 0;
				tbody.querySelectorAll("tr.expense-row").forEach(function(row) {
					var inp = row.querySelector("input[name='detailTotal']");
					if (!inp)
						return;
					var v = parseFloat(inp.value);
					if (!isNaN(v))
						sum += v;
				});
				var text = sum.toFixed(2);
				if (grandTotalEl)
					grandTotalEl.textContent = text;
				if (grandTotalInput)
					grandTotalInput.value = text;
				if (noDataRow) {
					noDataRow.style.display = tbody
							.querySelectorAll("tr.expense-row").length === 0 ? ""
							: "none";
				}
			}

			function removeRow(btn) {
				var row = btn.closest("tr.expense-row");
				if (row)
					row.remove();
				reindex();
				calcTotal();

				checkSubmitState();
			}

			function toggleDistanceField(goByVal) {
				var group = document.getElementById("distanceGroup");
				var normalGroup = document.getElementById("totalGroupNormal");
				var kmEl = document.getElementById("mKilometers");
				if (!group)
					return;
				if (String(goByVal) === CAR_PRIVATE_ID) {
					group.style.display = "";
					normalGroup.style.display = "none";
				} else {
					group.style.display = "none";
					normalGroup.style.display = "";
					if (kmEl)
						kmEl.value = "";
				}
			}

			var mGoByEl = document.getElementById("mGoBy");
			if (mGoByEl && window.$) {
				$(mGoByEl).on("change", function() {
					var val = $(this).val() || "";
					toggleDistanceField(val);
					var t1 = document.getElementById("mTotal");
					var t2 = document.getElementById("mTotalNormal");
					if (t1)
						t1.value = "";
					if (t2)
						t2.value = "";
					var kmEl = document.getElementById("mKilometers");
					if (kmEl)
						kmEl.value = "";

					checkModalSubmitState();
				});
			}

			var mKmEl = document.getElementById("mKilometers");
			if (mKmEl) {
				mKmEl.addEventListener("input", function() {
					var km = parseFloat(this.value);
					var totalEl = document.getElementById("mTotal");
					if (!isNaN(km) && km >= 0) {
						totalEl.value = (km * RATE_PER_KM).toFixed(2);
					} else {
						totalEl.value = "";
					}
					checkModalSubmitState();
				});
			}

			function buildRowHtml(goByText, goByVal, descVal, totalNum, kmVal) {
				return ("<td class='row-no fs-6 fw-normal'>1</td>"
						+ "<td class='fs-6 fw-normal'>"
						+ escapeHtml(goByText)
						+ "<input type='hidden' name='detailGoBy' value='"
						+ escapeAttr(goByVal)
						+ "' />"
						+ "<input type='hidden' name='detailKilometers' value='"
						+ escapeAttr(kmVal || "0")
						+ "' />"
						+ "</td>"
						+ "<td class='fs-6 fw-normal'>"
						+ escapeHtml(descVal || "-")
						+ "<input type='hidden' name='detailDescription' value='"
						+ escapeAttr(descVal)
						+ "' />"
						+ "</td>"
						+ "<td class='text-end fs-6 fw-normal'>"
						+ totalNum.toFixed(2)
						+ "<input type='hidden' name='detailTotal' value='"
						+ totalNum.toFixed(2)
						+ "' />"
						+ "</td>"
						+ "<td class='text-end'><div class='d-flex justify-content-end gap-2'>"
						+ "<button type='button' class='btn btn-icon btn-sm btn-light-primary btn-edit-row' title='Edit'>"
						+ "<i class='ki-duotone ki-pencil fs-4'><span class='path1'></span><span class='path2'></span></i>"
						+ "</button>"
						+ "<button type='button' class='btn btn-icon btn-sm btn-light-danger btn-remove-row' title='Remove'>"
						+ "<i class='ki-duotone ki-trash fs-4'><span class='path1'></span><span class='path2'></span><span class='path3'></span></i>" + "</button></div></td>");
			}

			function resetModal() {
				var goSel = document.getElementById("mGoBy");
				if (window.$ && $(goSel).data("select2")) {
					$(goSel).val(null).trigger("change");
				} else {
					goSel.value = "";
					goSel.selectedIndex = 0;
				}
				var t1 = document.getElementById("mTotal");
				var t2 = document.getElementById("mTotalNormal");
				if (t1)
					t1.value = "";
				if (t2)
					t2.value = "";
				document.getElementById("mDescription").value = "";
				document.getElementById("mKilometers").value = "";
				document.getElementById("distanceGroup").style.display = "none";
				document.getElementById("totalGroupNormal").style.display = "";
				delete modalEl.dataset.editRow;

				checkModalSubmitState();
			}

			function openEditModal(row) {
				var goByVal = row.querySelector("input[name='detailGoBy']").value;
				var kmInput = row
						.querySelector("input[name='detailKilometers']");
				var kmVal = kmInput ? kmInput.value : "0";
				var descVal = row
						.querySelector("input[name='detailDescription']").value;
				var totalVal = row.querySelector("input[name='detailTotal']").value;

				var goSel = document.getElementById("mGoBy");
				if (window.$ && $(goSel).data("select2")) {
					$(goSel).val(goByVal).trigger("change");
				} else {
					goSel.value = goByVal;
				}

				setTimeout(
						function() {
							toggleDistanceField(goByVal);
							if (String(goByVal) === CAR_PRIVATE_ID) {
								document.getElementById("mKilometers").value = kmVal;
								document.getElementById("mTotal").value = totalVal;
							} else {
								document.getElementById("mTotalNormal").value = totalVal;
							}
							document.getElementById("mDescription").value = descVal;

							checkModalSubmitState();
						}, 0);

				modalEl.dataset.editRow = Array.from(
						tbody.querySelectorAll("tr.expense-row")).indexOf(row);
				bootstrap.Modal.getOrCreateInstance(modalEl).show();
			}

			function bindRowEvents(tr) {
				tr.querySelector(".btn-remove-row").addEventListener("click",
						function() {
							removeRow(this);
						});
				tr.querySelector(".btn-edit-row").addEventListener("click",
						function() {
							openEditModal(this.closest("tr.expense-row"));
						});
			}

			tbody.querySelectorAll("tr.expense-row").forEach(function(tr) {
				bindRowEvents(tr);
			});

			var btnCreate = document.getElementById("btnCreateExpense");
			if (btnCreate) {
				btnCreate.addEventListener("click", function() {
					resetModal();
					bootstrap.Modal.getOrCreateInstance(modalEl).show();
				});
			}

			btnModalSave
					.addEventListener(
							"click",
							function() {
								var goSel = document.getElementById("mGoBy");
								var descEl = document
										.getElementById("mDescription");
								var kmEl = document
										.getElementById("mKilometers");

								var goByVal = (goSel.value || "").trim();
								var goByText = (goSel.options[goSel.selectedIndex] ? goSel.options[goSel.selectedIndex].text
										: "").trim();
								var descVal = (descEl.value || "").trim();

								var isCar = String(goByVal) === CAR_PRIVATE_ID;
								var totalEl = isCar ? document
										.getElementById("mTotal") : document
										.getElementById("mTotalNormal");
								var totalVal = (totalEl ? totalEl.value || ""
										: "").trim();
								var kmVal = isCar ? (kmEl.value || "0") : "0";

								if (!goByVal) {
									alert("Please select Go by.");
									return;
								}
								if (!totalVal || isNaN(parseFloat(totalVal))) {
									alert("Please enter Total.");
									return;
								}

								var totalNum = Math
										.max(0, parseFloat(totalVal));
								var editIdx = modalEl.dataset.editRow;

								if (editIdx !== undefined && editIdx !== "") {
									var rows = tbody
											.querySelectorAll("tr.expense-row");
									var editRow = rows[parseInt(editIdx, 10)];
									if (editRow) {
										editRow
												.querySelector("input[name='detailGoBy']").value = goByVal;
										editRow
												.querySelector("input[name='detailKilometers']").value = kmVal;
										editRow
												.querySelector("input[name='detailDescription']").value = descVal;
										editRow
												.querySelector("input[name='detailTotal']").value = totalNum
												.toFixed(2);
										var tds = editRow
												.querySelectorAll("td");
										tds[1].childNodes[0].textContent = goByText;
										tds[2].childNodes[0].textContent = descVal
												|| "-";
										tds[3].childNodes[0].textContent = totalNum
												.toFixed(2);
									}
								} else {
									var tr = document.createElement("tr");
									tr.className = "expense-row";
									tr.innerHTML = buildRowHtml(goByText,
											goByVal, descVal, totalNum, kmVal);
									tbody.appendChild(tr);
									bindRowEvents(tr);
								}

								reindex();
								calcTotal();
								checkSubmitState();
								bootstrap.Modal.getOrCreateInstance(modalEl)
										.hide();
							});

			modalEl.addEventListener("shown.bs.modal", function() {
				document.body.classList.add("modal-open");
				document.body.style.overflow = "hidden";
				document.documentElement.style.overflow = "hidden";
			});
			modalEl.addEventListener("hidden.bs.modal", function() {
				document.querySelectorAll(".modal-backdrop").forEach(
						function(b) {
							b.remove();
						});
				document.body.classList.remove("modal-open");
				document.body.style.removeProperty("padding-right");
				document.body.style.removeProperty("overflow");
				document.documentElement.style.removeProperty("overflow");
				resetModal();
			});

			reindex();
			calcTotal();

			checkSubmitState();

			// ===== File upload =====
			var travelSelectedFiles = [];
			var deletedFileIds = [];

			function renderNewFileList() {
				var listDiv = document.getElementById('travelFileList');
				listDiv.querySelectorAll('.new-file-row').forEach(function(el) {
					el.remove();
				});

				travelSelectedFiles
						.forEach(function(file) {
							var dotIdx = file.name.lastIndexOf('.');
							var nameOnly = dotIdx > 0 ? file.name.substring(0,
									dotIdx) : file.name;
							var fileExt = dotIdx > 0 ? file.name
									.substring(dotIdx) : '';
							// ใช้ getFileIcon แทน getTravelFileIcon เดิม
							var iconPath = getFileIcon(file.name);

							var outerDiv = document.createElement('div');
							outerDiv.className = 'd-flex align-items-center new-file-row';
							outerDiv.innerHTML = '<div class="d-flex align-items-center justify-content-between w-100 p-2 rounded bg-hover-light">'
									+ '<div class="d-flex align-items-center" style="flex-grow:1;">'
									+ '<img src="' + iconPath + '" class="w-25px h-25px me-3" alt="icon" />'
									+ '<span class="fs-6 fw-medium">'
									+ escapeHtml(nameOnly)
									+ '<span class="text-muted ms-1">'
									+ escapeHtml(fileExt)
									+ '</span>'
									+ '</span>'
									+ '<span class="badge badge-light-primary ms-2 fs-9">New</span>'
									+ '</div>'
									+ '<span class="badge badge-light-danger cursor-pointer btn-del-new-file ms-3">'
									+ '<i class="ki-duotone ki-trash text-danger fs-2">'
									+ '<span class="path1"></span><span class="path2"></span>'
									+ '<span class="path3"></span><span class="path4"></span><span class="path5"></span>'
									+ '</i></span>' + '</div>';

							(function(f) {
								outerDiv
										.querySelector('.btn-del-new-file')
										.addEventListener(
												'click',
												function() {
													travelSelectedFiles = travelSelectedFiles
															.filter(function(x) {
																return !(x.name === f.name && x.size === f.size);
															});
													renderNewFileList();
													updateTravelInputFiles();
												});
							})(file);

							listDiv.appendChild(outerDiv);
						});
			}

			function updateTravelInputFiles() {
				var inputFile = document.getElementById('travelFiles');
				var dt = new DataTransfer();
				travelSelectedFiles.forEach(function(f) {
					dt.items.add(f);
				});
				inputFile.files = dt.files;

				var fileNames = travelSelectedFiles.map(function(f) {
					return f.name;
				});
				document.getElementById('filesUploadFileName').value = JSON
						.stringify(fileNames);
				document.getElementById('fileUploadId').value = JSON
						.stringify(deletedFileIds);
			}

			document.getElementById('travelFileList').querySelectorAll(
					'.btn-del-existing-file').forEach(function(btn) {
				btn.addEventListener('click', function() {
					var fileId = this.getAttribute('data-file-id');
					var row = this.closest('.existing-file-row');
					if (fileId && deletedFileIds.indexOf(fileId) === -1)
						deletedFileIds.push(fileId);
					if (row)
						row.remove();
					updateTravelInputFiles();
				});
			});

			document
					.getElementById('travelFiles')
					.addEventListener(
							'change',
							function(e) {
								Array
										.from(e.target.files)
										.forEach(
												function(file) {
													var exists = travelSelectedFiles
															.find(function(f) {
																return f.name === file.name
																		&& f.size === file.size;
															});
													if (!exists)
														travelSelectedFiles
																.push(file);
												});
								renderNewFileList();
								updateTravelInputFiles();
							});

		})();
	</script>
</body>
</html>
--%>
<!-- ===== END: old desktop-clone content (commented out) ===== -->

<%-- =====================================================================
     NEW: LINE LIFF
     ===================================================================== --%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/compressorjs/1.2.1/compressor.min.js"></script>
<style>
.liff-upload-badge { box-sizing: border-box; display: inline-flex; align-items: center; justify-content: center; gap: 10px; margin-left: auto; width: 84px; height: 24px; padding: 0 8px; border-radius: 5.53px; background: var(--bs-primary-bg-subtle); color: var(--bs-primary); font-weight: 600; font-size: 12px; white-space: nowrap; cursor: pointer; }
.liff-upload-badge i { color: var(--bs-primary); }
.liff-submit-bar { display: flex; gap: 10px; margin-top: 20px; }
.liff-submit-bar .btn { flex: 1; }
#travelEditForm > .card { box-shadow: 0px 3px 4px 0px #00000008; }
#expenseModal .liff-field-value[type=number] { -moz-appearance: textfield; }
#expenseModal .liff-field-value[type=number]::-webkit-inner-spin-button, #expenseModal .liff-field-value[type=number]::-webkit-outer-spin-button { -webkit-appearance: none; margin: 0; }
</style>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="onlineUser" value="${sessionScope.onlineUser}" />

<div class="liff-shell">

	<div id="liffLoadingOverlay" class="liff-loading-overlay liff-loading-delayed">
		<div class="spinner-border text-primary" role="status"><span class="visually-hidden">Loading...</span></div>
	</div>

	<div class="d-flex align-items-center gap-3 mb-6 pt-6">
		<a href="javascript:void(0)" class="liff-back-btn" onclick="liffShowLoading(); window.history.go(-1); return false;" aria-label="Back">
			<i class="ki-outline ki-left fs-2 text-gray-700"></i>
		</a>
		<h1 class="liff-page-title text-gray-700 mb-0 flex-grow-1">Edit Travel</h1>
	</div>

	<form id="travelEditForm" method="post" action="${ctx}/line_travel_update" enctype="multipart/form-data">

		<input type="hidden" name="expenseId" value="${fn:escapeXml(expenseObj.expenseId)}" />
		<input type="hidden" name="expenseGroupId" value="${fn:escapeXml(expenseObj.expenseGroupId)}" />
		<input type="hidden" id="grandTotalInput" name="amount" value="${fn:escapeXml(expenseObj.amount)}" />

		<%-- ข้อมูล --%>
		<div class="card card-flush mb-7">
			<div class="card-body pt-6 pb-7">

				<div class="liff-field-row mb-3">
					<input id="userId" class="form-control liff-field-value text-truncate text-start text-primary" aria-label="User"
						value="${fn:escapeXml(onlineUser.employeeId)} - ${fn:escapeXml(onlineUser.nameEN)}" readonly />
					<input type="hidden" name="userId" value="${fn:escapeXml(expenseObj.userId)}" />
				</div>

				<div class="liff-field-row mb-6">
					<label class="liff-field-label" for="requestDate">Request Date</label>
					<input type="hidden" id="requestDateVal" name="requestDate" value="<fmt:formatDate value='${expenseObj.timeCreate}' pattern='yyyy-MM-dd'/>" />
					<input type="text" class="form-control liff-field-value" id="requestDate" placeholder="DD MM YYYY" readonly />
				</div>

				<div class="liff-field-row mb-3">
					<label class="liff-field-label" for="departureDate">Day of departure <span class="text-danger">*</span></label>
					<input type="hidden" id="departureDateVal" name="departureDate" value="<fmt:formatDate value='${expenseObj.dtStart}' pattern='yyyy-MM-dd'/>" />
					<input type="text" class="form-control liff-field-value" id="departureDate" autocomplete="off" placeholder="DD MMM YYYY" required />
					<i class="ki-duotone ki-calendar fs-4 text-gray-500"><span class="path1"></span><span class="path2"></span></i>
				</div>

				<div class="liff-field-row mb-6">
					<label class="liff-field-label" for="purposeOfJourney">Purpose of journey <span class="text-danger">*</span></label>
					<input type="text" class="form-control liff-field-value" id="purposeOfJourney" name="purposeOfJourney"
						placeholder="Enter purpose" value="${fn:escapeXml(expenseObj.description)}" required />
				</div>

				<div class="liff-field-row mb-3">
					<label class="liff-field-label" for="beginning">Beginning <span class="text-danger">*</span></label>
					<input type="text" class="form-control liff-field-value" name="beginning" id="beginning" placeholder="e.g. Head Office" value="${fn:escapeXml(expenseObj.fromLocation)}" required />
				</div>

				<div class="liff-field-row mb-3">
					<label class="liff-field-label" for="beginTime">Beginning Time <span class="text-danger">*</span></label>
					<input type="text" class="form-control liff-field-value" id="beginTime" name="beginTime" autocomplete="off" placeholder="HH:mm" value="<fmt:formatDate value='${expenseObj.dtStart}' pattern='HH:mm'/>" required />
					<i class="ki-duotone ki-time fs-4 text-gray-500"><span class="path1"></span><span class="path2"></span></i>
				</div>

				<div class="liff-field-row mb-3">
					<label class="liff-field-label" for="destination">Destination <span class="text-danger">*</span></label>
					<input type="text" class="form-control liff-field-value" name="destination" id="destination" placeholder="e.g. Customer site" value="${fn:escapeXml(expenseObj.toLocation)}" required />
				</div>

				<div class="liff-field-row">
					<label class="liff-field-label" for="destTime">Destination Time <span class="text-danger">*</span></label>
					<input type="text" class="form-control liff-field-value" id="destTime" name="destTime" autocomplete="off" placeholder="HH:mm" value="<fmt:formatDate value='${expenseObj.dtEnd}' pattern='HH:mm'/>" required />
					<i class="ki-duotone ki-time fs-4 text-gray-500"><span class="path1"></span><span class="path2"></span></i>
				</div>

			</div>
		</div>

		<%-- Attach file --%>
		<div class="card card-flush mb-7">
			<div class="card-body pt-6 pb-7">

				<div class="liff-field-row mb-3">
					<label class="liff-field-label" for="travelFiles">Attach files</label>
					<label for="travelFiles" class="liff-upload-badge">
						<i class="ki-duotone ki-file-up fs-7"><span class="path1"></span><span class="path2"></span></i>
						Upload
						<input type="file" id="travelFiles" name="files" multiple class="d-none"
							accept=".pdf,.doc,.docx,.xlsx,.pptx,.csv,.png,.jpg,.jpeg,.gif,.webp,.mp4" />
					</label>
					<input type="hidden" name="filesUploadFileName" id="filesUploadFileName" />
					<input type="hidden" name="fileUploadId" id="fileUploadId" value="[]" />
				</div>
				<div id="travelFileList" class="d-flex flex-wrap gap-2"></div>

				<%-- ไฟล์เดิมจาก BE ให้ JS วาดแถวแบบเดียวกับไฟล์ใหม่ --%>
				<div id="travelExistingFiles" class="d-none">
					<c:forEach var="f" items="${travelFiles}">
						<span data-file-id="${fn:escapeXml(f.fileId)}" data-name="${fn:escapeXml(f.name)}${fn:escapeXml(f.type)}" data-url="${ctx}${fn:escapeXml(f.path)}"></span>
					</c:forEach>
				</div>

			</div>
		</div>

		<%-- Expense --%>
		<div class="card card-flush mb-7">
			<div class="card-body pt-6 pb-7">

				<div class="d-flex align-items-center justify-content-between gap-3 mb-3">
					<div class="d-flex align-items-center gap-2" style="min-width:0;">
						<span class="text-gray-700 fw-medium fs-5 text-nowrap">Total <span class="text-danger">*</span></span>
						<span class="fw-bold text-primary fs-5 text-nowrap"><span id="grandTotal">0.00</span> บาท</span>
					</div>
					<button type="button" class="btn btn-sm btn-success flex-shrink-0" id="btnCreateExpense">
						<i class="ki-duotone ki-plus fs-5 me-1"></i> Expense
					</button>
				</div>

				<div id="expenseTbody">
					<div id="noDataRow" class="text-center text-muted fs-7 py-8 mb-3 border border-dashed border-gray-300 rounded">No Data</div>
				</div>

				<%-- รายการเดิมจาก BE ให้ JS วาดการ์ดด้วย buildRowHtml --%>
				<div id="travelExistingDetails" class="d-none">
					<c:forEach var="d" items="${detailList}">
						<span data-go-by="${fn:escapeXml(d.goBy)}" data-km="${fn:escapeXml(d.kilometers)}" data-desc="${fn:escapeXml(d.description)}" data-total="${fn:escapeXml(d.total)}"></span>
					</c:forEach>
				</div>

			</div>
		</div>

		<div class="liff-submit-bar mt-0">
			<a href="${ctx}/line_my_travel?status=Draft" class="btn btn-light">Cancel</a>
			<button type="submit" id="btnSubmitSave" class="btn btn-success" disabled>Save</button>
		</div>

	</form>

	<div class="modal fade" id="expenseModal" aria-hidden="true">
		<div class="modal-dialog modal-dialog-scrollable modal-fullscreen-sm-down">
			<div class="modal-content">
				<div class="modal-header py-4" style="padding-left: 22px; padding-right: 22px;">
					<h1 class="liff-page-title text-gray-700 mb-0">Expense detail</h1>
					<button type="button" class="btn btn-icon btn-light w-45px h-45px flex-shrink-0" data-bs-dismiss="modal" aria-label="Close">
						<i class="ki-duotone ki-cross fs-2x"><span class="path1"></span><span class="path2"></span></i>
					</button>
				</div>
				<div class="modal-body" style="padding: 22px;">
					<div class="liff-field-row mb-3">
						<label class="liff-field-label" for="mGoBy">Go by <span class="text-danger">*</span></label>
						<select id="mGoBy" class="form-select liff-field-value liff-field-dropdown" required>
							<option value="">Select go by</option>
							<c:forEach var="t" items="${expTravelTypeList}">
								<option value="${t.expTravelTypeId}"><c:out value="${t.name}" /></option>
							</c:forEach>
						</select>
					</div>
					<div id="distanceGroup" style="display: none;">
						<div class="liff-field-row mb-3">
							<label class="liff-field-label" for="mKilometers">Distance <span class="text-danger">*</span></label>
							<input id="mKilometers" type="number" inputmode="decimal" class="form-control liff-field-value" min="0" step="0.01" placeholder="0" />
							<span class="text-gray-600 fs-7">Km.</span>
						</div>
						<div class="liff-field-row mb-3">
							<label class="liff-field-label" for="mTotal">Total <span class="text-danger">*</span> <span class="text-muted fw-normal fs-8 ms-1">7 บาท / Km</span></label>
							<input id="mTotal" type="number" inputmode="decimal" class="form-control liff-field-value" min="0" step="0.01" placeholder="0.00" required />
							<span class="text-gray-600 fs-7">บาท</span>
						</div>
					</div>
					<div id="totalGroupNormal">
						<div class="liff-field-row mb-3">
							<label class="liff-field-label" for="mTotalNormal">Total <span class="text-danger">*</span></label>
							<input id="mTotalNormal" type="number" inputmode="decimal" class="form-control liff-field-value" min="0" step="0.01" placeholder="0.00" required />
							<span class="text-gray-600 fs-7">บาท</span>
						</div>
					</div>
					<div class="mt-6">
						<label class="form-label fs-6" for="mDescription">Description</label>
						<textarea id="mDescription" class="form-control liff-input-underline" rows="3" placeholder="Description"></textarea>
					</div>
					<div class="liff-submit-bar">
						<button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
						<button type="button" id="btnModalSave" class="btn btn-success" disabled>Save</button>
					</div>
				</div>
			</div>
		</div>
	</div>

</div>


<script>
	(function() {

		var CAR_PRIVATE_ID = "6";
		var RATE_PER_KM = 7;

		var TRAVEL_FILE_FORBIDDEN = /[\/:*?"<>|]/;
		var TRAVEL_FILE_IMAGE_LIMIT = 500 * 1024;
		var TRAVEL_FILE_TOTAL_LIMIT = 2 * 1024 * 1024;
		var travelSelectedFiles = [];
		var travelLoadingFiles = [];
		var travelLoadingSeq = 0;
		var travelExistingFiles = [];
		var deletedFileIds = [];

		var ctx = "${ctx}";

		function fieldValue(id) {
			var el = document.getElementById(id);
			return el ? el.value.trim() : "";
		}

		// ไอคอนไฟล์แบบเดียวกับ getFileIconPath ของ create leave (ใช้เฉพาะ svg ที่มีจริง)
		function getFileIcon(fileName) {
			var ext = (fileName || '').split('.').pop().toLowerCase();
			var base = ctx + '/assets/media/svg/files/';
			switch (ext) {
			case 'pdf':
				return base + 'pdf.svg';
			case 'doc':
			case 'docx':
				return base + 'doc.svg';
			case 'png':
			case 'jpg':
			case 'jpeg':
			case 'gif':
			case 'webp':
				return base + 'blank-image.svg';
			default:
				return base + 'folder-document.svg';
			}
		}

		var MONTH_SHORT = [ "Jan", "Feb", "Mar", "Apr", "May", "Jun",
				"Jul", "Aug", "Sep", "Oct", "Nov", "Dec" ];

		function toIsoDate(dateObj) {
			if (!dateObj)
				return "";
			var y = dateObj.getFullYear();
			var m = String(dateObj.getMonth() + 1).padStart(2, "0");
			var d = String(dateObj.getDate()).padStart(2, "0");
			return y + "-" + m + "-" + d;
		}

		function toDisplayDate(dateObj) {
			if (!dateObj)
				return "";
			var d = String(dateObj.getDate()).padStart(2, "0");
			return d + " " + MONTH_SHORT[dateObj.getMonth()] + " "
					+ dateObj.getFullYear();
		}

		function escapeHtml(s) {
			return (s || "").replace(/[&<>"']/g, function(c) {
				return {
					"&" : "&amp;",
					"<": "&lt;", ">" : "&gt;",
					'"' : "&quot;",
					"'" : "&#39;"
				}[c];
			});
		}

		// Request Date ใช้วันที่สร้างรายการ (ไม่มีค่าใช้วันนี้)
		var reqDateEl = document.getElementById("requestDate");
		var reqDateValEl = document.getElementById("requestDateVal");
		if (reqDateEl) {
			var reqDate = reqDateValEl && reqDateValEl.value ? moment(reqDateValEl.value, "YYYY-MM-DD").toDate() : new Date();
			if (reqDateValEl)
				reqDateValEl.value = toIsoDate(reqDate);
			reqDateEl.value = toDisplayDate(reqDate);
			reqDateEl.setAttribute("readonly", "readonly");
		}

		var modalEl = document.getElementById("expenseModal");
		// Go by ใช้ dropdown แบบ create leave แทน select2
		liffMountSelectDropdown(document.getElementById("mGoBy"));

		// วันเดินทาง: daterangepicker แบบเดียวกับ create leave
		var depDisplayEl = document.getElementById("departureDate");
		var depValEl = document.getElementById("departureDateVal");
		if (depDisplayEl) {
			var depStart = depValEl && depValEl.value ? moment(depValEl.value, "YYYY-MM-DD") : moment();
			var $dep = $(depDisplayEl);
			$dep.daterangepicker({
				singleDatePicker: true,
				showDropdowns: true,
				autoUpdateInput: false,
				autoApply: true,
				startDate: depStart,
				locale: {
					format: "DD MMM YYYY",
					monthNames: [
						"January", "February", "March", "April", "May", "June",
						"July", "August", "September", "October", "November", "December"
					],
				},
				drops: "down",
				theme: 'light'
			});
			$dep.val(depStart.format('DD MMM YYYY'));
			if (depValEl) depValEl.value = depStart.format('YYYY-MM-DD');

			$dep.on('apply.daterangepicker', function (ev, picker) {
				$(this).val(picker.startDate.format('DD MMM YYYY'));
				if (depValEl) depValEl.value = picker.startDate.format('YYYY-MM-DD');
				checkSubmitState();
			});
		}

		// เวลาเริ่ม/ถึง: tempusDominus แบบเดียวกับ create leave
		function createTimePicker(inputId) {
			var el = document.getElementById(inputId);
			if (!el) return;
			var initial = el.value;
			var picker = new tempusDominus.TempusDominus(el, {
				display: {
					components: {
						calendar: false,
						clock: true,
						hours: true,
						minutes: true,
						seconds: false,
						useTwentyfourHour: true
					},
					theme: "light"
				},
				localization: {
					hourCycle: 'h23',
					format: "HH:mm"
				},
				useCurrent: false
			});
			function setTime(h, mi) {
				picker.dates.setValue(tempusDominus.DateTime.convert(new Date(0, 0, 0, h, mi)));
			}
			// คงค่าเดิมของรายการ
			var m = /^(\d{1,2}):(\d{2})$/.exec(initial || '');
			if (m) setTime(parseInt(m[1], 10), parseInt(m[2], 10));
			// เปิดครั้งแรกตอนยังว่าง ใส่ 12:00 เหมือน legacy (flatpickr defaultHour)
			el.addEventListener('show.td', function () {
				if (!el.value) setTime(12, 0);
			});
			// พิมพ์ได้เฉพาะตัวเลขกับ : เหมือน legacy
			el.addEventListener('input', function () {
				this.value = this.value.replace(/[^0-9:]/g, '');
				el.dataset.typed = this.value;
			});
			el.addEventListener('change', function () {
				var typed = el.dataset.typed;
				if (typed === undefined) return;
				delete el.dataset.typed;
				var t = /^(\d{1,2}):(\d{2})$/.exec(typed);
				if (t && parseInt(t[1], 10) < 24 && parseInt(t[2], 10) < 60) {
					setTime(parseInt(t[1], 10), parseInt(t[2], 10));
				} else {
					picker.dates.clear();
					el.value = '';
				}
				checkSubmitState();
			});
			el.addEventListener('change.td', checkSubmitState);
		}

		createTimePicker("beginTime");
		createTimePicker("destTime");

		var expenseList = document.getElementById("expenseTbody");
		var noDataRow = document.getElementById("noDataRow");
		var grandTotalEl = document.getElementById("grandTotal");
		var grandTotalInput = document.getElementById("grandTotalInput");
		var mGoByEl = document.getElementById("mGoBy");
		var btnModalSave = document.getElementById("btnModalSave");
		var btnSubmitSave = document.getElementById("btnSubmitSave");

		var requiredInputIds = [ "departureDate", "purposeOfJourney",
				"beginning", "beginTime", "destination", "destTime" ];

		// เช็ค Required Fields ของฟอร์มหลัก
		function checkSubmitState() {
			if (!btnSubmitSave)
				return;

			var hasExpenseRows = expenseList.querySelectorAll(".expense-row").length > 0;
			var allRequiredFilled = requiredInputIds.every(function(id) {
				return fieldValue(id) !== "";
			});
			var timesValid = [ "beginTime", "destTime" ].every(function(id) {
				return /^([01]\d|2[0-3]):[0-5]\d$/.test(fieldValue(id));
			});
			var isProcessingFiles = travelLoadingFiles.length > 0;

			if (hasExpenseRows && allRequiredFilled && timesValid && !isProcessingFiles) {
				btnSubmitSave.removeAttribute("disabled");
			} else {
				btnSubmitSave.setAttribute("disabled", "disabled");
			}
		}

		// เช็ค Required Fields ของ Modal
		function checkModalSubmitState() {
			if (!btnModalSave)
				return;

			var goByVal = fieldValue("mGoBy");
			var isCar = (goByVal === CAR_PRIVATE_ID);
			var isValid = false;

			if (goByVal !== "") {
				if (isCar) {
					isValid = fieldValue("mKilometers") !== "" && fieldValue("mTotal") !== "";
				} else {
					isValid = fieldValue("mTotalNormal") !== "";
				}
			}

			if (isValid) {
				btnModalSave.removeAttribute("disabled");
			} else {
				btnModalSave.setAttribute("disabled", "disabled");
			}
		}

		requiredInputIds.forEach(function(id) {
			var el = document.getElementById(id);
			if (el) {
				el.addEventListener("input", checkSubmitState);
				el.addEventListener("change", checkSubmitState);
			}
		});

		// ผูก Event ฝั่ง Modal Inputs
		var modalInputIds = [ "mKilometers", "mTotal", "mTotalNormal" ];
		modalInputIds.forEach(function(id) {
			var el = document.getElementById(id);
			if (el) {
				el.addEventListener("input", checkModalSubmitState);
			}
		});

		function reindex() {
			expenseList.querySelectorAll(".expense-row").forEach(function(row, idx) {
				var no = row.querySelector(".row-no");
				if (no)
					no.textContent = String(idx + 1);
			});
		}

		function calcTotal() {
			var sum = 0;
			expenseList.querySelectorAll(".expense-row").forEach(function(row) {
				var inp = row.querySelector("input[name='detailTotal']");
				if (!inp)
					return;
				var v = parseFloat(inp.value);
				if (!isNaN(v))
					sum += v;
			});
			var text = sum.toFixed(2);
			if (grandTotalEl)
				grandTotalEl.textContent = text;
			if (grandTotalInput)
				grandTotalInput.value = text;
			if (noDataRow) {
				noDataRow.style.display = expenseList.querySelectorAll(".expense-row").length === 0 ? "" : "none";
			}
		}

		function removeRow(btn) {
			var row = btn.closest(".expense-row");
			if (row)
				row.remove();
			reindex();
			calcTotal();
			checkSubmitState();
		}

		function toggleDistanceField(goByVal) {
			var group = document.getElementById("distanceGroup");
			var normalGroup = document.getElementById("totalGroupNormal");
			var kmEl = document.getElementById("mKilometers");
			if (!group)
				return;
			if (String(goByVal) === CAR_PRIVATE_ID) {
				group.style.display = "";
				normalGroup.style.display = "none";
			} else {
				group.style.display = "none";
				normalGroup.style.display = "";
				if (kmEl)
					kmEl.value = "";
			}
		}

		if (mGoByEl && window.$) {
			$(mGoByEl).on("change", function() {
				var val = $(this).val() || "";
				toggleDistanceField(val);
				var t1 = document.getElementById("mTotal");
				var t2 = document.getElementById("mTotalNormal");
				if (t1)
					t1.value = "";
				if (t2)
					t2.value = "";
				var kmEl = document.getElementById("mKilometers");
				if (kmEl)
					kmEl.value = "";
				checkModalSubmitState();
			});
		}

		var mKmEl = document.getElementById("mKilometers");
		if (mKmEl) {
			mKmEl.addEventListener("input", function() {
				var km = parseFloat(this.value);
				var totalEl = document.getElementById("mTotal");
				if (!isNaN(km) && km >= 0) {
					totalEl.value = (km * RATE_PER_KM).toFixed(2);
				} else {
					totalEl.value = "";
				}
				checkModalSubmitState();
			});
		}

		// การ์ดรายการ: ยอด | แก้ไข ลบ / ประเภท · รายละเอียด (hidden input ลำดับเดิม)
		function buildRowHtml(goByText, goByVal, descVal, totalNum, kmVal) {
			return ("<div class='card-body p-4 d-flex flex-column gap-3'>"
					+ "<div class='d-flex align-items-center justify-content-between gap-3'>"
					+ "<span class='badge badge-primary fs-6 fw-bold text-nowrap'><span class='row-total'>"
					+ totalNum.toFixed(2)
					+ "</span>&nbsp;บาท</span>"
					+ "<div class='d-flex align-items-center gap-2 flex-shrink-0'>"
					+ "<button type='button' class='btn btn-icon btn-sm btn-light-primary w-30px h-30px btn-edit-row' title='Edit'>"
					+ "<i class='ki-duotone ki-pencil fs-5'><span class='path1'></span><span class='path2'></span></i>"
					+ "</button>"
					+ "<button type='button' class='btn btn-icon btn-sm btn-light-danger w-30px h-30px btn-remove-row' title='Remove'>"
					+ "<i class='ki-duotone ki-trash fs-5'><span class='path1'></span><span class='path2'></span><span class='path3'></span><span class='path4'></span><span class='path5'></span></i>"
					+ "</button>" + "</div>"
					+ "</div>"
					+ "<div class='d-flex align-items-start gap-2 fs-7' style='min-width:0;'>"
					+ "<span class='row-goby fw-semibold text-gray-800 flex-shrink-0'>"
					+ escapeHtml(goByText)
					+ "</span>"
					+ "<input type='hidden' name='detailGoBy' value='"
					+ escapeHtml(goByVal)
					+ "' />"
					+ "<input type='hidden' name='detailKilometers' value='"
					+ escapeHtml(kmVal || "0")
					+ "' />"
					+ "<div class='d-flex align-items-start gap-1 text-gray-600' style='min-width:0;'>"
					+ "<i class='ki-duotone ki-document fs-5 flex-shrink-0'><span class='path1'></span><span class='path2'></span></i>"
					+ "<span class='row-desc text-break'>"
					+ escapeHtml(descVal || "-")
					+ "</span>"
					+ "</div>"
					+ "<input type='hidden' name='detailDescription' value='"
					+ escapeHtml(descVal)
					+ "' />"
					+ "<input type='hidden' name='detailTotal' value='"
					+ totalNum.toFixed(2)
					+ "' />"
					+ "</div>" + "</div>");
		}

		function appendExpenseRow(goByText, goByVal, descVal, totalNum, kmVal) {
			var row = document.createElement("div");
			row.className = "expense-row card card-bordered mb-3";
			row.innerHTML = buildRowHtml(goByText, goByVal, descVal, totalNum, kmVal);
			expenseList.appendChild(row);
			bindRowEvents(row);
		}

		function resetModal() {
			mGoByEl.value = "";
			mGoByEl.selectedIndex = 0;
			// trigger change ให้ dropdown อัปเดตข้อความ
			$(mGoByEl).trigger("change");
			var t1 = document.getElementById("mTotal");
			var t2 = document.getElementById("mTotalNormal");
			if (t1)
				t1.value = "";
			if (t2)
				t2.value = "";
			document.getElementById("mDescription").value = "";
			document.getElementById("mKilometers").value = "";
			document.getElementById("distanceGroup").style.display = "none";
			document.getElementById("totalGroupNormal").style.display = "";
			delete modalEl.dataset.editRow;
			checkModalSubmitState();
		}

		function openEditModal(row) {
			var goByVal = row.querySelector("input[name='detailGoBy']").value;
			var kmInput = row.querySelector("input[name='detailKilometers']");
			var kmVal = kmInput ? kmInput.value : "0";
			var descVal = row.querySelector("input[name='detailDescription']").value;
			var totalVal = row.querySelector("input[name='detailTotal']").value;

			mGoByEl.value = goByVal;
			$(mGoByEl).trigger("change");

			setTimeout(function() {
				toggleDistanceField(goByVal);
				if (String(goByVal) === CAR_PRIVATE_ID) {
					document.getElementById("mKilometers").value = kmVal;
					document.getElementById("mTotal").value = totalVal;
				} else {
					document.getElementById("mTotalNormal").value = totalVal;
				}
				document.getElementById("mDescription").value = descVal;
				checkModalSubmitState();
			}, 0);

			modalEl.dataset.editRow = Array.from(expenseList.querySelectorAll(".expense-row")).indexOf(row);
			bootstrap.Modal.getOrCreateInstance(modalEl).show();
		}

		function bindRowEvents(row) {
			row.querySelector(".btn-remove-row").addEventListener("click", function() {
				removeRow(this);
			});
			row.querySelector(".btn-edit-row").addEventListener("click", function() {
				openEditModal(this.closest(".expense-row"));
			});
		}

		var btnCreate = document.getElementById("btnCreateExpense");
		if (btnCreate) {
			btnCreate.addEventListener("click", function() {
				resetModal();
				bootstrap.Modal.getOrCreateInstance(modalEl).show();
			});
		}

		btnModalSave.addEventListener("click", function() {
			var selectedOption = mGoByEl.options[mGoByEl.selectedIndex];
			var goByVal = (mGoByEl.value || "").trim();
			var goByText = (selectedOption ? selectedOption.text : "").trim();
			var descVal = (document.getElementById("mDescription").value || "").trim();

			var isCar = String(goByVal) === CAR_PRIVATE_ID;
			var totalVal = fieldValue(isCar ? "mTotal" : "mTotalNormal");
			var kmVal = isCar ? (document.getElementById("mKilometers").value || "0") : "0";

			var totalNum = Math.max(0, parseFloat(totalVal));
			var editIdx = modalEl.dataset.editRow;

			if (editIdx !== undefined && editIdx !== "") {
				var editRow = expenseList.querySelectorAll(".expense-row")[parseInt(editIdx, 10)];
				if (editRow) {
					editRow.querySelector("input[name='detailGoBy']").value = goByVal;
					editRow.querySelector("input[name='detailKilometers']").value = kmVal;
					editRow.querySelector("input[name='detailDescription']").value = descVal;
					editRow.querySelector("input[name='detailTotal']").value = totalNum.toFixed(2);
					editRow.querySelector(".row-goby").textContent = goByText;
					editRow.querySelector(".row-desc").textContent = descVal || "-";
					editRow.querySelector(".row-total").textContent = totalNum.toFixed(2);
				}
			} else {
				appendExpenseRow(goByText, goByVal, descVal, totalNum, kmVal);
			}

			reindex();
			calcTotal();
			checkSubmitState();
			bootstrap.Modal.getOrCreateInstance(modalEl).hide();
		});

		modalEl.addEventListener("shown.bs.modal", function() {
			document.body.classList.add("modal-open");
			document.body.style.overflow = "hidden";
			document.documentElement.style.overflow = "hidden";
		});

		modalEl.addEventListener("hidden.bs.modal", function() {
			document.querySelectorAll(".modal-backdrop").forEach(
					function(b) {
						b.remove();
					});
			document.body.classList.remove("modal-open");
			document.body.style.removeProperty("padding-right");
			document.body.style.removeProperty("overflow");
			document.documentElement.style.removeProperty("overflow");
			resetModal();
		});

		// รายการเดิม ชื่อ Go by เอาจาก option (ประเภทที่ปิดใช้แล้วแสดง -)
		document.querySelectorAll("#travelExistingDetails > span").forEach(function(el) {
			var goByVal = el.dataset.goBy || "";
			var opt = Array.prototype.find.call(mGoByEl.options, function(o) {
				return o.value !== "" && o.value === goByVal;
			});
			var totalNum = Math.max(0, parseFloat(el.dataset.total) || 0);
			appendExpenseRow(opt ? opt.text.trim() : "-", goByVal, el.dataset.desc || "", totalNum, el.dataset.km || "0");
		});

		reindex();
		calcTotal();

		// รันเช็คสถานะครั้งแรกตอนโหลดหน้าจอ
		checkSubmitState();

		// แถวไฟล์หน้าตาเดียวกับ lfMakeItem ของหน้า Create Leave
		function makeTravelFileItem(name, url, onRemove) {
			var item = document.createElement('div');
			item.className = 'd-flex w-100 justify-content-between align-items-center p-2 border border-gray-300 rounded bg-white';

			var leftGroup = document.createElement('div');
			leftGroup.className = 'd-flex align-items-center overflow-hidden me-4';

			var icon = document.createElement('img');
			icon.src = getFileIcon(name);
			icon.className = 'w-25px h-25px me-3 flex-shrink-0';
			icon.alt = 'icon';

			var link = document.createElement('a');
			link.href = url;
			link.target = '_blank';
			link.className = 'text-gray-800 fw-medium text-hover-primary text-truncate';
			link.textContent = name;
			link.style.maxWidth = '250px';

			leftGroup.appendChild(icon);
			leftGroup.appendChild(link);

			var removeBtn = document.createElement('span');
			removeBtn.className = 'btn btn-icon btn-sm btn-light-danger cursor-pointer btn-del-travel-file';
			removeBtn.innerHTML = '<i class="ki-duotone ki-trash fs-3"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i>';
			removeBtn.addEventListener('click', onRemove);

			item.appendChild(leftGroup);
			item.appendChild(removeBtn);
			return item;
		}

		// ไฟล์เดิมอยู่บนสุด ต่อด้วยไฟล์ใหม่ และแถวที่กำลังประมวลผล
		function renderNewFileList() {
			var listDiv = document.getElementById('travelFileList');
			listDiv.innerHTML = '';

			travelExistingFiles.forEach(function(ex) {
				if (deletedFileIds.indexOf(ex.fileId) !== -1)
					return;
				listDiv.appendChild(makeTravelFileItem(ex.name, ex.url, function() {
					deletedFileIds.push(ex.fileId);
					renderNewFileList();
					updateTravelInputFiles();
				}));
			});

			travelSelectedFiles.forEach(function(file) {
				listDiv.appendChild(makeTravelFileItem(file.name, URL.createObjectURL(file), function() {
					travelSelectedFiles = travelSelectedFiles.filter(function(x) {
						return !(x.name === file.name && x.size === file.size);
					});
					renderNewFileList();
					updateTravelInputFiles();
				}));
			});

			travelLoadingFiles.forEach(function(loading) {
				listDiv.appendChild(makeTravelLoadingItem(loading.name));
			});

			checkSubmitState();
		}

		function updateTravelInputFiles() {
			var inputFile = document.getElementById('travelFiles');
			var dt = new DataTransfer();
			travelSelectedFiles.forEach(function(f) {
				dt.items.add(f);
			});
			inputFile.files = dt.files;

			var fileNames = travelSelectedFiles.map(function(f) {
				return f.name;
			});
			document.getElementById('filesUploadFileName').value = JSON.stringify(fileNames);
			document.getElementById('fileUploadId').value = JSON.stringify(deletedFileIds);
		}

		function makeTravelLoadingItem(name) {
			var wrapper = document.createElement('div');
			wrapper.className = 'd-flex w-100 align-items-center p-2 border border-gray-300 rounded bg-white';

			var spinner = document.createElement('span');
			spinner.className = 'spinner-border spinner-border-sm text-primary me-3 flex-shrink-0';
			spinner.setAttribute('role', 'status');

			var label = document.createElement('span');
			label.className = 'text-gray-600 fs-6 text-truncate';
			label.textContent = 'กำลังประมวลผล ' + name + '...';
			label.style.maxWidth = '250px';

			wrapper.appendChild(spinner);
			wrapper.appendChild(label);
			return wrapper;
		}

		function removeTravelLoading(loadingId) {
			travelLoadingFiles = travelLoadingFiles.filter(function(l) { return l.id !== loadingId; });
		}

		function isTravelDuplicate(file) {
			return travelSelectedFiles.some(function(f) { return f.name === file.name && f.size === file.size; });
		}

		// นับเฉพาะไฟล์ใหม่ ไฟล์เดิมอยู่บน server แล้วไม่ได้ส่งไปกับ request
		function travelFilesTotalSize() {
			var total = 0;
			travelSelectedFiles.forEach(function(f) { total += f.size; });
			return total;
		}

		function alertTravelHeic() {
			Swal.fire({
				icon: 'error',
				title: 'ไม่รองรับไฟล์ HEIC',
				html: 'ไม่รองรับไฟล์นามสกุล .heic กรุณาแปลงก่อนแนบไฟล์'
					+ '<br><br><span class="text-muted fs-7">ไฟล์ที่รองรับ: PDF, DOC, DOCX, XLSX, PPTX, CSV, PNG, JPG, JPEG, GIF, WEBP, MP4</span>',
				confirmButtonText: 'รับทราบ',
				buttonsStyling: false,
				customClass: { confirmButton: "btn btn-primary" }
			});
		}

		function alertTravelBadName(fileName) {
			Swal.fire({
				icon: 'error',
				title: 'Invalid file name',
				text: 'File name contains invalid characters: ' + fileName,
				confirmButtonText: 'OK',
				buttonsStyling: false,
				customClass: { confirmButton: "btn btn-primary" }
			});
		}

		function isTravelHeic(file) {
			var name = (file.name || '').toLowerCase();
			return name.endsWith('.heic') || name.endsWith('.heif')
				|| file.type === 'image/heic' || file.type === 'image/heif';
		}

		function compressTravelFileIfNeeded(file, loadingId) {
			if (file.type && file.type.indexOf('image/') === 0 && file.size > TRAVEL_FILE_IMAGE_LIMIT && typeof Compressor !== 'undefined') {
				new Compressor(file, {
					quality: 0.8, maxWidth: 1024, maxHeight: 1024,
					success: function(result) {
						var compressed = new File([result], file.name, { type: result.type, lastModified: Date.now() });
						tryAddTravelFile(compressed, loadingId);
					},
					error: function() {
						tryAddTravelFile(file, loadingId);
					}
				});
			} else {
				tryAddTravelFile(file, loadingId);
			}
		}

		function processTravelFile(file, loadingId) {
			if (isTravelHeic(file)) {
				removeTravelLoading(loadingId);
				renderNewFileList();
				alertTravelHeic();
				return;
			}
			compressTravelFileIfNeeded(file, loadingId);
		}

		function tryAddTravelFile(file, loadingId) {
			removeTravelLoading(loadingId);
			if (travelFilesTotalSize() + file.size > TRAVEL_FILE_TOTAL_LIMIT) {
				Swal.fire({
					icon: 'warning',
					title: 'ไฟล์มีขนาดเกินกำหนด',
					text: 'ไม่สามารถแนบไฟล์ "' + file.name + '" ได้ เนื่องจากขนาดไฟล์รวมเกินขนาดสูงสุดที่กำหนดไว้',
					confirmButtonText: 'รับทราบ',
					buttonsStyling: false,
					customClass: { confirmButton: "btn btn-primary" }
				});
				renderNewFileList();
				return;
			}
			travelSelectedFiles.push(file);
			updateTravelInputFiles();
			renderNewFileList();
		}

		function addTravelFiles(fileList) {
			Array.prototype.slice.call(fileList).forEach(function(file) {
				if (TRAVEL_FILE_FORBIDDEN.test(file.name)) {
					alertTravelBadName(file.name);
					return;
				}
				if (isTravelDuplicate(file)) {
					return;
				}

				var loadingId = ++travelLoadingSeq;
				travelLoadingFiles.push({ id: loadingId, name: file.name });
				renderNewFileList();

				processTravelFile(file, loadingId);
			});
		}

		document.getElementById('travelFiles').addEventListener('change', function(e) {
			addTravelFiles(e.target.files);
		});

		document.querySelectorAll('#travelExistingFiles > span').forEach(function(el) {
			travelExistingFiles.push({ fileId: el.dataset.fileId, name: el.dataset.name || 'file', url: el.dataset.url });
		});
		renderNewFileList();

		// บันทึกสำเร็จ BE redirect ไป line_my_travel (error จะ forward ไป index.jsp ไม่ redirect)
		function isTravelSaved(res) {
			return res.ok && res.redirected && res.url.indexOf('line_my_travel') !== -1;
		}

		// session หมด AuthInterceptor redirect ไปหน้า login
		function isSessionExpired(res) {
			return res.redirected && res.url.indexOf('/pages-line/index.jsp') !== -1;
		}

		// ส่ง form ด้วย fetch แบบ doSubmit() ของ create leave จะได้รู้ผลแล้วขึ้น toast
		var travelSubmitting = false;
		document.getElementById('travelEditForm').addEventListener('submit', function (e) {
			e.preventDefault();
			if (travelSubmitting) { return; }
			travelSubmitting = true;

			var form = this;
			var spinner = $('#liffLoadingOverlay');
			spinner.css('display', 'flex');
			btnSubmitSave.setAttribute('disabled', 'disabled');
			updateTravelInputFiles();

			fetch(form.action, { method: 'POST', body: new FormData(form) })
				.then(function (res) {
					// session หมด ไปหน้า login
					if (isSessionExpired(res)) {
						window.location.href = res.url;
						return;
					}
					// บันทึกไม่สำเร็จ ไป catch
					if (!isTravelSaved(res)) { throw new Error('save failed'); }

					// บันทึกสำเร็จ ไปหน้า My Travel พร้อม toast
					var separator = (res.url.indexOf('?') === -1) ? '?' : '&';
					window.location.href = res.url + separator + 'saved=edit';
				})
				.catch(function () {
					travelSubmitting = false;
					spinner.css('display', 'none');
					checkSubmitState();
					liffToastError("Unable to save your travel expense. Please try again.", "Save failed");
				});
		});

	})();
</script>
