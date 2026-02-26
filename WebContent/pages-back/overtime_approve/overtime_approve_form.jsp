<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<style>
.color-sun {
	color: var(--bs-red) !important;
}

.color-mon {
	color: var(--bs-yellow) !important;
}

.color-tue {
	color: var(--bs-pink) !important;
}

.color-wed {
	color: var(--bs-green) !important;
}

.color-thu {
	color: var(--bs-orange) !important;
}

.color-fri {
	color: var(--bs-blue) !important;
}

.color-sat {
	color: var(--bs-purple) !important;
}
</style>

<fmt:setLocale value="en_US" />
<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
	<div class="d-flex flex-column flex-column-fluid">
		<div id="kt_app_toolbar_container"
			class="app-container container-fluid d-flex flex-stack">
			<div
				class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
				<h1
					class="page-heading d-flex text-gray-700 fw-semibold flex-column justify-content-center my-0">
					Overtime Approve</h1>
				<ul
					class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
					<li class="breadcrumb-item text-muted">Home</li>
					<li class="breadcrumb-item"><span
						class="bullet bg-gray-500 w-5px h-2px"></span></li>
					<li class="breadcrumb-item text-muted">Admin Management</li>
					<li class="breadcrumb-item"><span
						class="bullet bg-gray-500 w-5px h-2px"></span></li>
					<li class="breadcrumb-item text-muted">Overtime Approve</li>
				</ul>
			</div>

			<div class="d-flex align-items-center">
				<span
					class="badge badge-lg badge-light-${status_color} text-${status_color} border border-${status_color} fw-medium h-45px px-4 py-3">
					${status_name} </span>
			</div>
		</div>

		<div id="kt_app_content" class="app-content flex-column-fluid mt-8">
			<div id="kt_app_content_container"
				class="app-container container-xxl">

				<div class="card mb-8">
					<div
						class="card-header border-0 pt-6 d-flex justify-content-between">
						<div class="card-title">
							<h3 class="fw-bold text-gray-900 m-0">Overtime From</h3>
						</div>
						<div class="fw-medium text-gray-700 fs-6">
							Request date:
							<fmt:formatDate value="${overtime.time_create}"
								pattern="d MMM yyyy, HH:mm" />
						</div>
					</div>
					<div class="card-body pt-0">
						<div class="d-flex align-items-center mb-8 mt-4">
							<i class="ki-duotone ki-user-square fs-2 text-gray-500 me-4">
								<span class="path1"></span><span class="path2"></span><span
								class="path3"></span><span class="path4"></span>
							</i>
							<div class="fw-medium fs-5 text-gray-900">${displayName}</div>
						</div>
						<div class="row mb-8 align-items-center">

							<div
								class="col-12 col-md-4 d-flex align-items-center mb-3 mb-md-0">
								<i class="ki-duotone ki-calendar-2 fs-2 text-gray-500 me-3">
									<span class="path1"></span><span class="path2"></span><span
									class="path3"></span> <span class="path4"></span><span
									class="path5"></span><span class="path6"></span>
								</i>
								<div class="fw-medium fs-6 text-gray-800">
									<fmt:formatDate value="${overtime.start_time}" pattern="EEE"
										var="startDay" />
									<span class="color-${fn:toLowerCase(startDay)} fw-bold">
										<fmt:formatDate value="${overtime.start_time}" pattern="EEE" />
									</span>
									<fmt:formatDate value="${overtime.start_time}"
										pattern="d MMM yyyy, H:mm" />
								</div>
							</div>

							<div
								class="col-12 col-md-4 d-flex align-items-center mb-3 mb-md-0">
								<i class="ki-duotone ki-calendar-2 fs-2 text-gray-500 me-3">
									<span class="path1"></span><span class="path2"></span><span
									class="path3"></span> <span class="path4"></span><span
									class="path5"></span><span class="path6"></span>
								</i>
								<div class="fw-medium fs-5 text-gray-800">
									<fmt:formatDate value="${overtime.end_time}" pattern="EEE"
										var="endDay" />
									<span class="color-${fn:toLowerCase(endDay)} fw-bold"> <fmt:formatDate
											value="${overtime.end_time}" pattern="EEE" />
									</span>
									<fmt:formatDate value="${overtime.end_time}"
										pattern="d MMM yyyy, H:mm" />
								</div>
							</div>

							<div
								class="col-12 col-md-4 d-flex align-items-center justify-content-start">
								<span
									class="badge badge-lg badge-light-primary fw-semibold h-25px px-4 d-inline-flex align-items-center justify-content-center">
									${fn:replace(overtime.req_hours, '.', ':')} Hrs </span>
							</div>

						</div>

						<div class="d-flex align-items-center">
							<i class="ki-duotone ki-document fs-2 me-3"> <span
								class="path1"></span><span class="path2"></span>
							</i> <span class="fw-normal fs-6"
								style="color: #333333; white-space: pre-wrap; word-break: break-word; line-height: 1.5;">${overtime.description}</span>
						</div>
					</div>
				</div>

				<form action="overtime_approve_update" method="post"
					id="approveForm">
					<input type="hidden" name="ot_id" value="${overtime.ot_id}" /> <input
						type="hidden" name="status" id="approveStatus" value="" />

					<div class="card">
						<div
							class="card-header border-0 pt-6 d-flex justify-content-between align-items-center">
							<div class="card-title m-0">
								<h3 class="fw-bold text-gray-900 m-0">Approve From</h3>
							</div>
							<div class="fw-medium text-gray-700 fs-6">
								Approve date:
								<jsp:useBean id="now" class="java.util.Date" />
								<fmt:formatDate
									value="${not empty overtime.approved_at ? overtime.approved_at : now}"
									pattern="d MMM yyyy, HH:mm" />
							</div>
						</div>

						<div class="card-body pt-0">
							<c:set var="apprDisplayName"
								value="${sessionScope.onlineUser.employeeId}" />
							<c:choose>
								<c:when test="${not empty sessionScope.onlineUser.nameEN}">
									<c:set var="apprDisplayName"
										value="${apprDisplayName} - ${sessionScope.onlineUser.nameEN}" />
								</c:when>
								<c:otherwise>
									<c:if test="${not empty sessionScope.onlineUser.name}">
										<c:set var="apprDisplayName"
											value="${apprDisplayName} - ${sessionScope.onlineUser.name}" />
									</c:if>
								</c:otherwise>
							</c:choose>

							<div class="d-flex align-items-center mb-8 mt-4">
								<i class="ki-duotone ki-user-tick fs-2 text-gray-500 me-4">
									<span class="path1"></span><span class="path2"></span><span
									class="path3"></span>
								</i>
								<div class="fw-medium fs-5 text-gray-800">${apprDisplayName}</div>
							</div>

							<div class="row g-9 mb-8">
								<div class="col-md-6">
									<label class="form-label fw-medium text-gray-800 required">Actual
										(hr)</label>
									<div class="position-relative">
										<i
											class="ki-duotone ki-time fs-2 position-absolute top-50 start-0 translate-middle-y ms-4">
											<span class="path1"></span><span class="path2"></span>
										</i> <input type="hidden" name="appr_hours" id="appr_hours_hidden"
											value="${overtime.appr_hours}" /> <input type="text"
											id="appr_hours_display"
											class="form-control form-control-lg ps-15 h-55px fw-bold text-gray-800 ${overtime.status ne 'W' ? 'bg-light' : 'cursor-pointer'}"
											value="${fn:replace(overtime.appr_hours, '.', ':')}"
											placeholder="Select time"
											${overtime.status ne 'W' ? 'disabled' : ''} />
									</div>
								</div>
								<div class="col-md-6">
									<label class="form-label fw-medium text-gray-800 required">Default
										select</label> <select name="type_of_ot" id="type_of_ot"
										class="form-select form-select-lg" data-control="select2"
										data-hide-search="true"
										${overtime.status ne 'W' ? 'disabled' : ''}>
										<option value="1.0"
											${overtime.type_of_ot eq 1.0 ? 'selected' : ''}>1.0
											X</option>
										<option value="1.5"
											${overtime.type_of_ot eq 1.5 ? 'selected' : ''}>1.5
											X</option>
										<option value="3.0"
											${overtime.type_of_ot eq 3.0 ? 'selected' : ''}>3.0
											X</option>
									</select>
								</div>
							</div>
							<div class="fv-row">
								<label class="form-label fw-medium text-gray-800">Description</label>
								<textarea name="description_appr"
									class="form-control resize-none fw-medium text-gray-900 ${overtime.status ne 'W' ? 'bg-light' : ''}"
									rows="3" ${overtime.status ne 'W' ? 'readonly' : ''}>${overtime.description_appr}</textarea>
							</div>
						</div>
						<div class="card-footer d-flex justify-content-end gap-3">
							<button type="button" class="btn btn-light h-45px"
								onclick="history.back()">Close</button>

							<c:if test="${overtime.status eq 'W'}">
								<button type="button" class="btn btn-danger h-45px"
									onclick="submitWithStatus('R')">Reject</button>
								<button type="button" class="btn btn-success h-45px"
									onclick="submitWithStatus('A')">Approve</button>
							</c:if>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<script>
	$(document)
			.ready(
					function() {
						var rawReqHours = "${overtime.req_hours}";
						var rawApprHours = "${overtime.appr_hours}";
						var status = "${overtime.status}";
						var defaultTime = "00:00";

						function decimalToTimeStr(decimalValue) {
							var hrs = Math.floor(decimalValue);
							var mins = Math.round((decimalValue - hrs) * 60);
							var hrsStr = hrs < 10 ? hrs : hrs;
							var minsStr = mins < 10 ? "0" + mins : mins;
							return hrsStr + ":" + minsStr;
						}

						// CALCULATION LOGIC
						var startDateTimeStr = '<fmt:formatDate value="${overtime.start_time}" pattern="yyyy-MM-dd" />';
						var otDate = moment(startDateTimeStr, "YYYY-MM-DD");
						var isWeekend = (otDate.day() === 0 || otDate.day() === 6);

						function calculateOTCondition(decimalHours) {
							var finalHours = parseFloat(decimalHours);

							var calculatedApprHours = finalHours;

							var recommendedRate = "1.5"; 

							if (isWeekend) {
								recommendedRate = "1.0";
							}

							$("#type_of_ot").val(recommendedRate).trigger(
									'change.select2');

							return calculatedApprHours;
						}

						var fpInstance = flatpickr(
								"#appr_hours_display",
								{
									enableTime : true,
									noCalendar : true,
									dateFormat : "H:i",
									time_24hr : true,
									onChange : function(selectedDates, dateStr,
											instance) {
										var decimalFormat = dateStr.replace(
												':', '.');
										if (decimalFormat.startsWith("0")) {
											decimalFormat = decimalFormat
													.substring(1);
										}

										var calculatedHours = calculateOTCondition(decimalFormat);

										$("#appr_hours_hidden").val(
												calculatedHours);

										var newDisplayTime = decimalToTimeStr(calculatedHours);
										instance.setDate(newDisplayTime, false);
										$("#appr_hours_display").val(
												newDisplayTime);
									}
								});

						if (status === 'W') {
							if (rawReqHours && parseFloat(rawReqHours) > 0) {
								var initialCalc = calculateOTCondition(rawReqHours);

								$("#appr_hours_hidden").val(initialCalc);

								var initialTimeStr = decimalToTimeStr(initialCalc);
								fpInstance.setDate(initialTimeStr, false);
								$("#appr_hours_display").val(initialTimeStr);
							}
						} else {
							if (rawApprHours && parseFloat(rawApprHours) > 0) {
								var apprTimeStr = decimalToTimeStr(parseFloat(rawApprHours));
								fpInstance.setDate(apprTimeStr, false);
								$("#appr_hours_display").val(apprTimeStr);
							}
						}
					});

	function submitWithStatus(status) {
		document.getElementById('approveStatus').value = status;
		document.getElementById('approveForm').submit();
	}
</script>