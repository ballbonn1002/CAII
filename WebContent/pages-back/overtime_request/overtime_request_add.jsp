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
								Request</h3>
						</div>

						<div class="card-toolbar d-flex flex-column align-items-end">
							<div class="text-gray-700 fw-medium fs-6">
								Request date: <span id="currentDateTime"></span>
							</div>
						</div>
					</div>

					<form action="save_overtime" method="post" id="otForm">
						<input type="hidden" id="raw_ot_date" name="raw_ot_date" value="" />
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
									<c:if test="${not empty sessionScope.onlineUser.roleId}">
										<c:set var="displayName"
											value="${displayName} - ${sessionScope.onlineUser.roleId}" />
									</c:if>

									<div class="position-relative">
										<i
											class="ki-duotone ki-magnifier fs-3 position-absolute top-50 start-0 translate-middle-y ms-4">
											<span class="path1"></span><span class="path2"></span>
										</i> <input type="text"
											class="form-control form-control-lg ps-15 h-55px fw-bold text-gray-900 bg-light"
											value="${displayName}" readonly />
									</div>
									<input type="hidden" name="overtime.user_id"
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
											class="form-control form-control-lg ps-15 h-55px fw-bold text-gray-800" />
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
											class="form-control form-control-lg ps-15 h-55px fw-bold text-gray-800" />
									</div>
								</div>
							</div>

							<div class="row mb-8">
								<div class="col-12">
									<label class="form-label fw-bold text-gray-700 required">Actual
										(Hr)</label>
									<div class="position-relative">
										<i
											class="ki-duotone ki-time fs-2 position-absolute top-50 start-0 translate-middle-y ms-4">
											<span class="path1"></span><span class="path2"></span>
										</i> <input type="hidden" name="req_hours" id="req_hours_hidden" />

										<input type="text" id="req_hours_display"
											class="form-control form-control-lg ps-15 h-55px fw-bold text-gray-800 bg-light"
											readonly />
									</div>
								</div>
							</div>

							<div class="row">
								<div class="col-12">
									<label class="form-label fw-bold text-gray-800">Description</label>
									<textarea name="description" id="description"
										class="form-control mb-10 fw-bold text-gray-900" rows="3"
										style="resize: none;"></textarea>
								</div>
							</div>
						</div>

						<div class="card-footer d-flex justify-content-end gap-3 p-8">
							<button type="button"
								class="btn btn-light btn-lg fw-bold h-45px d-flex align-items-center justify-content-center"
								onclick="backToList()">Cancel</button>
							<button type="submit"
								class="btn btn-success btn-lg fw-medium h-45px d-flex align-items-center justify-content-center">Submit</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        
        function updateDateTime() {
            const now = moment().format('D MMM YYYY, HH:mm');
            const dateTimeElem = document.getElementById("currentDateTime");
            if (dateTimeElem) {
                dateTimeElem.textContent = now;
            }
        }
        updateDateTime();

        // Flatpickr สำหรับ Date OT 
        flatpickr("#ot_date", {
            dateFormat: "d/m/Y",
            defaultDate: "today",
            altInput: true,
            altFormat: "j M Y",
            onReady: function(selectedDates, dateStr, instance) {
                if (selectedDates.length > 0) {
                    document.getElementById('raw_ot_date').value = instance.formatDate(selectedDates[0], "Y-m-d");
                }
            },
            onChange: function(selectedDates, dateStr, instance) {
                if (selectedDates.length > 0) {
                    document.getElementById('raw_ot_date').value = instance.formatDate(selectedDates[0], "Y-m-d");
                }
            }
        });

        // Flatpickr สำหรับ Start / End
        const dateTimePickerOptions = {
            enableTime: true,
            dateFormat: "Y-m-d H:i", 
            altInput: true,
            altFormat: "j M Y, H:i", 
            time_24hr: true,
            onChange: calculateActual
        };

        const today = new Date();
        const defaultStart = new Date(today.setHours(9, 0, 0, 0));
        const defaultEnd = new Date(today.setHours(18, 0, 0, 0));

        flatpickr("#start_time", { ...dateTimePickerOptions, defaultDate: defaultStart });
        flatpickr("#end_time", { ...dateTimePickerOptions, defaultDate: defaultEnd });
		
        // calculate hrs
        function calculateActual() {
            const startStr = document.getElementById('start_time').value;
            const endStr = document.getElementById('end_time').value;
            
            if (startStr && endStr) {
                let start = moment(startStr, "YYYY-MM-DD HH:mm");
                let end = moment(endStr, "YYYY-MM-DD HH:mm");

                if (end.isBefore(start) && start.format("YYYY-MM-DD") === end.format("YYYY-MM-DD")) {
                    end.add(1, 'days');
                    
                    const endPicker = document.getElementById('end_time')._flatpickr;
                    if (endPicker) {
                        endPicker.setDate(end.toDate(), false);
                    }
                } 
                else if (end.isBefore(start)) {
                	document.getElementById('req_hours_hidden').value = "0.00";
                    document.getElementById('req_hours_display').value = "0:00";
                    return;
                }

                const duration = moment.duration(end.diff(start));
                
                const hours = Math.floor(duration.asHours());
                const minutes = duration.minutes();

                const decimalFormatted = hours + '.' + String(minutes).padStart(2, '0');
                const timeFormatted = hours + ':' + String(minutes).padStart(2, '0');
                
                document.getElementById('req_hours_hidden').value = decimalFormatted;
                document.getElementById('req_hours_display').value = timeFormatted;
            }
        }
        calculateActual();

        //  Trim Description 
        document.getElementById("otForm").addEventListener("submit", function() {
            const desc = document.getElementById("description");
            if (desc) desc.value = desc.value.trim();
        });
    });

    function backToList() {
        window.location.href = "${pageContext.request.contextPath}/overtime_request_list";
    }
</script>