<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<fmt:setLocale value="en_US" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>My Travel | CubeSoftTech</title>

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

	<div class="d-flex flex-column flex-root" id="kt_app_root">
		<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
			<div class="d-flex flex-column flex-column-fluid">

				<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
					<div id="kt_app_toolbar_container"
						class="app-container container-fluid d-flex align-items-center">
						<div
							class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
							<h1
								class="page-heading d-flex text-dark fw-bold fs-3 flex-column justify-content-center my-0">My
								Travel</h1>
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

				<div id="kt_app_content" class="app-content flex-column-fluid">
					<div id="kt_app_content_container"
						class="app-container container-fluid">

						<form id="travelAddForm" method="post" action="${ctx}/travel_save"
							enctype="multipart/form-data">

							<input type="hidden" id="grandTotalInput" name="amount"
								value="0.00" />

							<div class="card card-flush mb-7">
								<div class="card-header">
									<div class="card-title">
										<h3 class="fw-bold m-0">Record travel expense form</h3>
									</div>
								</div>

								<div class="card-body">
									<div class="row g-5 mb-5">
										<%-- Request Date --%>
										<div class="col-md-4">
											<label class="form-label required fw-semibold">Request
												Date</label>
											<div
												class="d-flex align-items-center bg-gray-100 border border-gray-300 rounded px-3 py-3">
												<i class="ki-duotone ki-calendar fs-1 me-3 text-muted">
													<span class="path1"></span><span class="path2"></span>
												</i> <input type="hidden" id="requestDateVal" name="requestDate"
													value="" /> <input type="text"
													class="form-control bg-transparent border-0 shadow-none p-0 fw-medium text-gray-900"
													style="font-size: 1rem;" id="requestDate"
													placeholder="DD MM YYYY" readonly />
											</div>
										</div>

										<%-- User --%>
										<c:set var="onlineUser" value="${sessionScope.onlineUser}" />
										<div class="col-md-8">
											<label class="form-label required fw-semibold">User</label>
											<div
												class="d-flex align-items-center bg-gray-100 border border-gray-300 rounded px-3 py-3">
												<i class="ki-duotone ki-magnifier fs-1 me-4 text-muted">
													<span class="path1"></span><span class="path2"></span>
												</i>
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
											<label class="form-label required fw-semibold">Day of
												departure</label>
											<div
												class="d-flex align-items-center border border-gray-300 rounded px-3 py-3">
												<i class="ki-duotone ki-calendar fs-1 me-3 text-muted">
													<span class="path1"></span><span class="path2"></span>
												</i> <input type="hidden" id="departureDateVal"
													name="departureDate" value="${param.departureDate}" /> <input
													type="text"
													class="form-control bg-transparent border-0 shadow-none p-0 fw-medium text-gray-900"
													style="font-size: 1rem;" id="departureDate"
													placeholder="DD MMM YYYY" required />
											</div>
										</div>

										<%-- Purpose of journey --%>
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
													value="${param.purposeOfJourney}" required />
											</div>
										</div>
									</div>

									<div class="row g-5 mb-5">
										<%-- Beginning --%>
										<div class="col-md-3">
											<label class="form-label required fw-semibold">Beginning</label>
											<div
												class="d-flex align-items-center border border-gray-300 rounded px-3 py-3">
												<input type="text"
													class="form-control bg-transparent border-0 shadow-none p-0 fw-medium text-gray-900"
													style="font-size: 1rem;" name="beginning" id="beginning"
													placeholder="e.g. Head Office" value="${param.beginning}"
													required />
											</div>
										</div>

										<%-- Beginning Time --%>
										<div class="col-md-3">
											<label class="form-label required fw-semibold">Beginning
												Time</label>
											<div
												class="d-flex align-items-center border border-gray-300 rounded px-3 py-3">
												<input type="text"
													class="form-control bg-transparent border-0 shadow-none p-0 fw-medium text-gray-900"
													style="font-size: 1rem;" id="beginTime" name="beginTime"
													placeholder="HH:mm" value="${param.beginTime}" required />
											</div>
										</div>

										<%-- Destination --%>
										<div class="col-md-3">
											<label class="form-label required fw-semibold">Destination</label>
											<div
												class="d-flex align-items-center border border-gray-300 rounded px-3 py-3">
												<input type="text"
													class="form-control bg-transparent border-0 shadow-none p-0 fw-medium text-gray-900"
													style="font-size: 1rem;" name="destination"
													id="destination" placeholder="e.g. Customer site"
													value="${param.destination}" required />
											</div>
										</div>

										<%-- Destination Time --%>
										<div class="col-md-3 mb-3">
											<label class="form-label required fw-semibold">Destination
												Time</label>
											<div
												class="d-flex align-items-center border border-gray-300 rounded px-3 py-3">
												<input type="text"
													class="form-control bg-transparent border-0 shadow-none p-0 fw-medium text-gray-900"
													style="font-size: 1rem;" id="destTime" name="destTime"
													placeholder="HH:mm" value="${param.destTime}" required />
											</div>
										</div>
									</div>

									<div class="row g-5">
										<div class="col-12">
											<div class="rounded">
												<div class="d-flex align-items-center flex-wrap gap-3">
													<label class="btn btn-primary h-40px border-0 fw-medium "
														for="travelFiles">Attach files <input type="file"
														id="travelFiles" name="files" multiple
														style="display: none;"
														accept=".pdf,.doc,.docx,.xlsx,.pptx,.csv,.png,.jpg,.jpeg,.gif,.webp,.mp4" />
													</label> <input type="hidden" name="filesUploadFileName"
														id="filesUploadFileName" /> <input type="hidden"
														name="fileUploadId" id="fileUploadId" value="[]" />

													<div id="travelFileList"
														class="d-flex flex-wrap align-items-center gap-3"></div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>

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
												<tr id="noDataRow">
													<td colspan="5" class="text-center text-muted py-8">No
														Data</td>
												</tr>
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

										<%-- ✅ กำหนดปุ่ม Submit และใส่ disabled ไว้ตอนเริ่มต้น --%>
										<button type="submit" id="btnSubmitSave"
											class="btn btn-success" disabled>Save</button>
									</div>
								</div>
							</div>

						</form>

						<div class="modal fade" id="expenseModal" aria-hidden="true">
							<div class="modal-dialog modal-dialog-scrollable modal-lg">
								<div class="modal-content">

									<div class="modal-header">
										<h3 class="fw-bold m-0">Add expense detail</h3>
										<button type="button"
											class="btn btn-icon btn-sm btn-active-light-primary"
											data-bs-dismiss="modal" aria-label="Close">
											<i class="ki-duotone ki-cross fs-2"></i>
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
														<!-- ✅ ลบ disabled ออกเพื่อไม่ให้กระทบเรื่อง required validation -->
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
										<%-- ✅ เพิ่ม disabled ให้ปุ่ม Save ใน Modal --%>
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

			var ctx = "${ctx}";
			function getTravelFileIcon(fileName) {
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

			function escapeAttr(s) {
				return (s || "").replace(/["']/g, function(c) {
					return c === '"' ? "&quot;" : "&#39;";
				});
			}

			var reqDateEl = document.getElementById("requestDate");
			var reqDateValEl = document.getElementById("requestDateVal");
			if (reqDateEl) {
				var today = new Date();
				if (reqDateValEl)
					reqDateValEl.value = toIsoDate(today);
				reqDateEl.value = toDisplayDate(today);
				reqDateEl.setAttribute("readonly", "readonly");
			}

			var modalEl = document.getElementById("expenseModal");
			initSelect2(document.getElementById("mGoBy"), {
				dropdownParent : $(modalEl),
				width : "100%"
			});

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

			var tbody = document.getElementById("expenseTbody");
			var noDataRow = document.getElementById("noDataRow");
			var grandTotalEl = document.getElementById("grandTotal");
			var grandTotalInput = document.getElementById("grandTotalInput");
			var btnModalSave = document.getElementById("btnModalSave");
			var btnSubmitSave = document.getElementById("btnSubmitSave");

			// (เช็ค Required Fields ของฟอร์มหลัก):
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

			// ✅ (เช็ค Required Fields ของ Modal):
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
						if (kmVal !== "" && totalVal !== "") {
							isValid = true;
						}
					} else {
						var totalNormalVal = document
								.getElementById("mTotalNormal") ? document
								.getElementById("mTotalNormal").value.trim()
								: "";
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

			var requiredInputIds = [ "departureDate", "purposeOfJourney",
					"beginning", "beginTime", "destination", "destTime" ];
			requiredInputIds.forEach(function(id) {
				var el = document.getElementById(id);
				if (el) {
					el.addEventListener("input", checkSubmitState);
					el.addEventListener("change", checkSubmitState);
				}
			});

			// ✅ ผูก Event ฝั่ง Modal Inputs
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

				checkSubmitState(); // อัปเดตปุ่มตอนลบรายการ
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

					// ✅ เรียกตรวจสอบ
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

					// ✅ เรียกตรวจสอบ
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
						+ "<td class='text-end'>"
						+ "<div class='d-flex justify-content-end gap-2'>"
						+ "<button type='button' class='btn btn-icon btn-sm btn-light-primary btn-edit-row' title='Edit'>"
						+ "<i class='ki-duotone ki-pencil fs-4'><span class='path1'></span><span class='path2'></span></i>"
						+ "</button>"
						+ "<button type='button' class='btn btn-icon btn-sm btn-light-danger btn-remove-row' title='Remove'>"
						+ "<i class='ki-duotone ki-trash fs-4'><span class='path1'></span><span class='path2'></span><span class='path3'></span></i>"
						+ "</button>" + "</div>" + "</td>");
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

				// ✅ เรียกตรวจสอบ
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

							// ✅ เรียกตรวจสอบ
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

								checkSubmitState(); // อัปเดตปุ่มตอนเพิ่มรายการเสร็จ

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

			calcTotal();

			// รันเช็คสถานะครั้งแรกตอนโหลดหน้าจอ
			checkSubmitState();

			var travelSelectedFiles = [];

			function renderTravelFileList() {
				var listDiv = document.getElementById('travelFileList');
				listDiv.innerHTML = '';

				travelSelectedFiles
						.forEach(function(file) {
							var dotIdx = file.name.lastIndexOf('.');
							var nameOnly = dotIdx > 0 ? file.name.substring(0,
									dotIdx) : file.name;
							var fileExt = dotIdx > 0 ? file.name
									.substring(dotIdx) : '';
							var iconPath = getTravelFileIcon(file.name);

							var item = document.createElement('div');
							item.className = 'd-flex align-items-center gap-2 px-3 py-2 rounded bg-light border border-gray-200';
							item.style.cssText = 'max-width: 240px;';
							item.innerHTML = '<img src="' + iconPath + '" class="w-25px h-25px flex-shrink-0" alt="icon" />'
									+ '<span class="fs-7 fw-medium text-truncate" style="max-width:120px;">'
									+ escapeHtml(nameOnly)
									+ '<span class="text-muted ms-1">'
									+ escapeHtml(fileExt)
									+ '</span>'
									+ '</span>'
									+ '<span class="btn-del-travel-file cursor-pointer ms-1 flex-shrink-0">'
									+ '<i class="ki-duotone ki-trash text-danger fs-4">'
									+ '<span class="path1"></span><span class="path2"></span>'
									+ '<span class="path3"></span><span class="path4"></span><span class="path5"></span>'
									+ '</i>' + '</span>';

							(function(f) {
								item
										.querySelector('.btn-del-travel-file')
										.addEventListener(
												'click',
												function() {
													travelSelectedFiles = travelSelectedFiles
															.filter(function(x) {
																return !(x.name === f.name && x.size === f.size);
															});
													renderTravelFileList();
													updateTravelInputFiles();
												});
							})(file);

							listDiv.appendChild(item);
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
			}

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
								renderTravelFileList();
								updateTravelInputFiles();
							});

		})();
	</script>
</body>
</html>