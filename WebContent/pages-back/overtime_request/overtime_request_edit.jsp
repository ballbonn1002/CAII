<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<link
	href="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.css"
	rel="stylesheet" type="text/css" />
<script
	src="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.js"></script>
<script
	src="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.js"></script>

<fmt:setLocale value="en_US" />
<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
	<div class="d-flex flex-column flex-column-fluid">
		<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
			<div id="kt_app_toolbar_container"
				class="app-container container-fluid d-flex flex-stack">
				<div
					class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
					<h1
						class="page-heading d-flex text-gray-700 fw-semibold flex-column justify-content-center my-0">Overtime
						Request</h1>
					<ul
						class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
						<li class="breadcrumb-item text-muted">Home</li>
						<li class="breadcrumb-item"><span
							class="bullet bg-gray-500 w-5px h-2px"></span></li>
						<li class="breadcrumb-item text-muted">Cube Management</li>
						<li class="breadcrumb-item"><span
							class="bullet bg-gray-500 w-5px h-2px"></span></li>
						<li class="breadcrumb-item text-muted">Overtime Request</li>
					</ul>
				</div>
			</div>
		</div>

		<div id="kt_app_content" class="app-content flex-column-fluid">
			<div id="kt_app_content_container"
				class="app-container container-xxl">
				<div class="card">
					<div
						class="card-header border-0 pt-6 d-flex justify-content-between align-items-center mb-4">

						<div class="card-title pt-3">
							<h3 class="page-heading d-flex text-gray-900 fw-bold my-0">Overtime
								Request Edit</h3>
						</div>

						<div class="card-toolbar d-flex flex-column align-items-end">
							<div class="text-gray-700 fw-medium fs-6">
								Request date: <span class="text-gray-700 fw-medium fs-6">
									<fmt:formatDate value="${overtime.time_create}"
										pattern="dd MMM yyyy, HH:mm" />
								</span>
							</div>
						</div>
					</div>

					<form action="overtime_request_update" method="post" id="otForm">
						<input type="hidden" name="ot_id" value="${overtime.ot_id}" /> <input
							type="hidden" name="id" value="${overtime.ot_id}" /> <input
							type="hidden" id="raw_ot_date" name="raw_ot_date"
							value="${overtime.ot_date}" /> <input type="hidden"
							name="user_id" value="${overtime.user_id}" />
						<div class="card-body p-10 pt-3">
							<div class="row mb-8">
								<div class="col-12">
									<c:set var="displayName" value="" />
									<c:if test="${not empty sessionScope.onlineUser.employeeId}">
										<c:set var="displayName"
											value="${sessionScope.onlineUser.employeeId}" />
									</c:if>
									<c:if test="${not empty sessionScope.onlineUser.nameEN}">
										<c:if test="${not empty displayName}">
											<c:set var="displayName" value="${displayName} - " />
										</c:if>
										<c:set var="displayName"
											value="${displayName}${sessionScope.onlineUser.nameEN}" />
									</c:if>
									<c:if test="${not empty sessionScope.onlineUser.name}">
										<c:if test="${not empty displayName}">
											<c:set var="displayName" value="${displayName} - " />
										</c:if>
										<c:set var="displayName"
											value="${displayName}${sessionScope.onlineUser.name}" />
									</c:if>

									<div class="position-relative">
										<i
											class="ki-duotone ki-magnifier fs-3 position-absolute top-50 start-0 translate-middle-y ms-4">
											<span class="path1"></span><span class="path2"></span>
										</i> <input type="text"
											class="form-control form-control-lg ps-15 h-55px fw-bold text-gray-900 bg-light"
											value="${displayName}" readonly />
									</div>
									<input type="hidden" name="user_id"
										value="${sessionScope.onlineUser.id}" />
								</div>
							</div>

							<div class="row mb-8">
								<div class="col-12">
									<label class="form-label fw-bold text-gray-700 required">Date
										OT</label>
									<div class="position-relative">
										<i
											class="ki-duotone ki-calendar-8 fs-2 position-absolute top-50 start-0 translate-middle-y ms-4">
											<span class="path1"></span><span class="path2"></span><span
											class="path3"></span> <span class="path4"></span><span
											class="path5"></span><span class="path6"></span>
										</i> <input type="text" name="ot_date" id="ot_date"
											class="form-control form-control-lg ps-15 h-55px fw-bold text-gray-800"
											value="<fmt:formatDate value='${ot_date}' pattern='dd/MM/yyyy'/>"
											placeholder="Select date" />
									</div>
								</div>
							</div>

							<div class="row mb-8">
								<div class="col-6">
									<label class="form-label fw-bold text-gray-700 required">Start
										Date Time</label>
									<div class="position-relative">
										<i
											class="ki-duotone ki-calendar-8 fs-2 position-absolute top-50 start-0 translate-middle-y ms-4">
											<span class="path1"></span><span class="path2"></span><span
											class="path3"></span> <span class="path4"></span><span
											class="path5"></span><span class="path6"></span>
										</i> <input type="text" name="start_time" id="start_time"
											class="form-control form-control-lg ps-15 h-55px fw-bold text-gray-800"
											value="<fmt:formatDate value='${overtime.start_time}' pattern='yyyy-MM-dd HH:mm'/>" />
									</div>
								</div>

								<div class="col-6">
									<label class="form-label fw-bold text-gray-700 required">End
										Date Time</label>
									<div class="position-relative">
										<i
											class="ki-duotone ki-calendar-8 fs-2 position-absolute top-50 start-0 translate-middle-y ms-4">
											<span class="path1"></span><span class="path2"></span><span
											class="path3"></span> <span class="path4"></span><span
											class="path5"></span><span class="path6"></span>
										</i> <input type="text" name="end_time" id="end_time"
											class="form-control form-control-lg ps-15 h-55px fw-bold text-gray-800"
											value="<fmt:formatDate value='${overtime.end_time}' pattern='yyyy-MM-dd HH:mm'/>" />
									</div>
								</div>
							</div>

							<div class="row mb-8">
								<div class="col-12">
									<label class="form-label fw-bold text-gray-700 required">Actual
										(hr)</label>
									<div class="position-relative">
										<i
											class="ki-duotone ki-time fs-2 position-absolute top-50 start-0 translate-middle-y ms-4">
											<span class="path1"></span><span class="path2"></span>
										</i> <input type="text" name="req_hours" id="req_hours"
											class="form-control form-control-lg ps-15 h-55px fw-bold text-gray-800 bg-light"
											value="${overtime.req_hours}" readonly />
									</div>
								</div>
							</div>

							<div class="row">
								<div class="col-12">
									<label class="form-label fw-bold text-gray-800">Description</label>
									<textarea name="description" id="description"
										class="form-control mb-10 fw-bold text-gray-900" rows="3"
										style="resize: none;">${overtime.description}</textarea>
								</div>
							</div>
						</div>

						<div class="card-footer d-flex justify-content-end gap-3 p-8">
							<button type="button"
								class="btn btn-light btn-lg fw-bold h-45px d-flex align-items-center justify-content-center"
								onclick="backToList()">Cancel</button>
							<button type="submit"
								class="btn btn-success btn-lg fw-medium h-45px d-flex align-items-center justify-content-center">Save</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
	document.addEventListener("DOMContentLoaded", function() {
		
		var dbDate = "<fmt:formatDate value='${overtime.ot_date}' pattern='dd/MM/yyyy'/>";
		var dbStart = '<fmt:formatDate value="${overtime.start_time}" pattern="yyyy-MM-dd HH:mm" />';
		var dbEnd = '<fmt:formatDate value="${overtime.end_time}" pattern="yyyy-MM-dd HH:mm" />';

		let endPickerInstance;

		const dateTimePickerOptions = {
			enableTime: true,
			dateFormat: "Y-m-d H:i", 
			altInput: true,
			altFormat: "j M Y, H:i", 
			time_24hr: true,
			onChange: calculateActual,
			onClose: checkCrossNight 
		};
		
		flatpickr("#ot_date", {
            dateFormat: "d/m/Y",
            defaultDate: dbDate ? dbDate : "today", 
            altInput: true,
            altFormat: "j M Y",
            onReady: function(selectedDates, dateStr, instance) {
                if (selectedDates.length > 0) {
                    var rawInput = document.getElementById('raw_ot_date');
                    if (rawInput) rawInput.value = instance.formatDate(selectedDates[0], "Y-m-d");
                }
            },
            onChange: function(selectedDates, dateStr, instance) {
                if (selectedDates.length > 0) {
                    var rawInput = document.getElementById('raw_ot_date');
                    if (rawInput) rawInput.value = instance.formatDate(selectedDates[0], "Y-m-d");
                }
            }
        });

		flatpickr("#start_time", { 
			...dateTimePickerOptions, 
			defaultDate: dbStart ? dbStart : new Date().setHours(9, 0, 0, 0)
		});
		
		endPickerInstance = flatpickr("#end_time", { 
			...dateTimePickerOptions, 
			defaultDate: dbEnd ? dbEnd : new Date().setHours(18, 0, 0, 0)
		});

		// calculate hrs
		function calculateActual() {
			const startStr = document.getElementById('start_time').value;
			const endStr = document.getElementById('end_time').value;
			
			if (startStr) {
				const dateOnly = moment(startStr, "YYYY-MM-DD HH:mm").format("DD/MM/YYYY");
				const rawDateOnly = moment(startStr, "YYYY-MM-DD HH:mm").format("YYYY-MM-DD");
				
				const otDateInput = document.getElementById('ot_date');
				if (otDateInput) otDateInput.value = dateOnly;
				
				const rawOtDateInput = document.getElementById('raw_ot_date');
				if (rawOtDateInput) rawOtDateInput.value = rawDateOnly;
			}

			if (startStr && endStr) {
				let start = moment(startStr, "YYYY-MM-DD HH:mm");
				let end = moment(endStr, "YYYY-MM-DD HH:mm");

				if (end.isBefore(start)) {
					document.getElementById('req_hours').value = "0.00";
					return;
				}

				const duration = moment.duration(end.diff(start));
				const hours = Math.floor(duration.asHours());
				const minutes = duration.minutes();

				const formatted = hours + '.' + String(minutes).padStart(2, '0');
				
				document.getElementById('req_hours').value = formatted;
			}
		}

		function checkCrossNight() {
			const startStr = document.getElementById('start_time').value;
			const endStr = document.getElementById('end_time').value;

			if (startStr && endStr) {
				let start = moment(startStr, "YYYY-MM-DD HH:mm");
				let end = moment(endStr, "YYYY-MM-DD HH:mm");

				if (end.isBefore(start) && start.format("YYYY-MM-DD") === end.format("YYYY-MM-DD")) {
					end.add(1, 'days');
					
					if (endPickerInstance) {
						endPickerInstance.setDate(end.toDate(), true);
					}
				}
			}
		}

		calculateActual();

		// Trim Description
		document.getElementById("otForm").addEventListener("submit", function() {
			const desc = document.getElementById("description");
			if (desc) desc.value = desc.value.trim();
		});
	});

	function backToList() {
		window.location.href = "${pageContext.request.contextPath}/overtime_request_list";
	}
</script>