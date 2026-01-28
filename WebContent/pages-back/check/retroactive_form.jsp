<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<style>
.btn-check:checked+label span {
	color: #fff !important;
}

.form-check.form-check-info .form-check-input:checked {
	background-color: var(--bs-info);
}

.min-w-170px {
	min-width: 170px !important;
}

.flatpickr-wrapper {
	display: block !important;
	width: 100% !important;
}

.flatpickr-wrapper .flatpickr-input {
	width: 100% !important;
}
</style>

<fmt:setLocale value="en_US" />
<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
	<div class="d-flex flex-column flex-column-fluid">
		<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
			<div id="kt_app_toolbar_container"
				class="app-container container-fluid d-flex flex-stack">
				<div
					class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
					<h1
						class="page-heading d-flex text-gray-700 fw-semibold flex-column justify-content-center my-0">Retroactively</h1>
					<ul
						class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
						<li class="breadcrumb-item text-muted">Home</li>
						<li class="breadcrumb-item"><span
							class="bullet bg-gray-500 w-5px h-2px"></span></li>
						<li class="breadcrumb-item text-muted">Check In / Check Out</li>
					</ul>
				</div>
			</div>
		</div>
		<div id="kt_app_content" class="app-content flex-column-fluid">
			<div id="kt_app_content_container"
				class="app-container container-xxl">
				<div class="row gx-5 gx-xl-10 mb-xl-10">
					<div class="col-xl-8 col-lg-8 col-md-8 col-sm-12 col-12 mb-10">
						<div class="card card-flush h-auto mb-5 mb-xl-10">
							<div
								class="card-header pt-5 d-flex justify-content-between align-items-center">
								<div class="card-title col-lg-12 col-md-12 col-sm-12 col-12">
									<div class="d-flex flex-column w-100">
										<span class="fw-medium text-gray-900 me-2 lh-1"> Work
											Hours</span>
										<div class="d-flex align-items-center pt-2 gap-2">
											<c:choose>
												<c:when test="${not empty jobsiteList}">
													<c:forEach var="site" items="${jobsiteList}">
														<span
															class="text-white fw-semibold fs-7 bg-primary rounded px-2 py-1">
															<c:out value="${site['name_site']}" />
														</span>
													</c:forEach>
												</c:when>
												<c:otherwise>
													<span
														class="text-white fw-semibold fs-7 bg-primary rounded px-2 py-1">
														None </span>
												</c:otherwise>
											</c:choose>
											<span class="text-gray-700 pe-2 fw-semibold fs-7">
												${user.workTimeStart} - ${user.workTimeEnd} </span>
										</div>
									</div>
								</div>
							</div>
							<div class="card-body d-flex flex-column">
								<div class="px-13">
									<div class="row mb-5 gx-10">
										<div class="col-md-6 col-sm-6 col-6">
											<label for="mdDate"
												class="required form-label fw-medium text-gray-800">Date</label>
											<div class="position-relative">
												<input class="form-control ps-15" id="mdDate"
													placeholder="Select date" /> <i
													class="ki-duotone ki-calendar-8 fs-1 position-absolute start-0 top-50 translate-middle-y ms-3 text-muted">
													<span class="path1"></span><span class="path2"></span><span
													class="path3"></span> <span class="path4"></span><span
													class="path5"></span><span class="path6"></span>
												</i>
											</div>
										</div>
										<div class="col-md-6 col-sm-6 col-6">
											<label for="mdTime"
												class="required form-label fw-medium text-gray-800">Time</label>
											<div class="position-relative">
												<input class="form-control ps-15" id="mdTime"
													placeholder="Select time" /> <i
													class="ki-duotone ki-calendar-8 fs-1 position-absolute start-0 top-50 translate-middle-y ms-3 text-muted">
													<span class="path1"></span><span class="path2"></span><span
													class="path3"></span> <span class="path4"></span><span
													class="path5"></span><span class="path6"></span>
												</i>
											</div>
											<div class="mdTime invalid-feedback" style="display: none;"></div>
										</div>
									</div>

									<!-- Check Type -->
									<div class="row py-7 mb-5 gx-10">
										<div class="col-6">
											<input type="radio" class="btn-check" name="mdCheckType"
												id="checkType1" value="1" checked="checked"> <label
												for="checkType1"
												class="btn bg-light w-100 h-150px btn-active-success d-flex flex-column justify-content-center align-items-center py-7">
												<i class="ki-duotone ki-time fs-2hx mb-5"> <span
													class="path1"></span> <span class="path2"></span>
											</i> <span class="fs-2 fw-medium text-muted">Check-In</span>
											</label>
										</div>
										<div class="col-6">
											<input type="radio" class="btn-check" name="mdCheckType"
												id="checkType2" value="2"> <label for="checkType2"
												class="btn bg-light w-100 h-150px btn-active-info d-flex flex-column justify-content-center align-items-center py-7">
												<i class="ki-duotone ki-time fs-2hx mb-5"> <span
													class="path1"></span> <span class="path2"></span>
											</i> <span class="fs-2 fw-medium text-muted">Check-Out</span>
											</label>
										</div>
									</div>

									<div class="d-flex mb-7">
										<label class="fw-bold text-gray-800 required"> Your
											Work Location</label>
									</div>
									<div class="d-flex align-items-center mb-7">
										<div class="col-md-6 col-sm-6 col-6 py-2 me-6 mb-3">
											<div
												class="form-check form-check-custom form-check-primary form-check-solid form-check-md">
												<input name="mdWorkType" class="form-check-input me-2"
													id="workType1" type="radio" value="1"
													<c:if test="${user.workType == 1}">checked</c:if>>
												<i class="ki-duotone ki-map fs-1 ms-1 text-primary"> <span
													class="path1"></span> <span class="path2"></span> <span
													class="path3"></span>
												</i> <label for="workType1"
													class="form-check-label fs-6 fw-normal text-gray-800">On-Site</label>
											</div>
										</div>
										<div class="col-md-6 col-sm-6 col-6 py-2 me-6 mb-3">
											<div
												class="form-check form-check-custom form-check-primary form-check-solid form-check-md">
												<input name="mdWorkType" class="form-check-input pe-2 me-2"
													id="workType2" type="radio" value="2"
													<c:if test="${user.workType == 2}">checked</c:if>>
												<i class="ki-duotone ki-home-2 fs-1 ms-1 text-success">
													<span class="path1"></span> <span class="path2"></span>
												</i> <label for="workType2"
													class="form-check-label fs-6 fw-normal text-gray-800">WFH</label>
											</div>
										</div>
									</div>
									<div class="mb-4">
										<label class=" fw-medium text-gray-800 required">
											Reason</label>
									</div>
									<textarea id="mdReason" name="reason" class="form-control mb-10" rows="4"
										style="resize: none;" placeholder="Please provide a reason."></textarea>
									<div class="reason invalid-feedback font-weight-bold mb-10"
										style="display: none;"></div>
									<div class="d-flex gap-10">
										<a href="check_in_out"
											class="btn btn-lg btn-light fw-medium w-100 h-44px d-flex justify-content-center align-items-center">
											Cancel </a>

										<button id="mdSubmitBtn" type="button"
											class="btn btn-lg fw-medium btn-success w-100 h-44px">
											Submit</button>
									</div>
								</div>
							</div>
						</div>

					</div>
					<div class="col-xl-4 col-lg-4 col-md-4 col-sm-12 col-12 mb-10">
						<div class="card card-flush h-auto mb-5 mb-xl-10">
							<div class="card-header pt-5">
								<div class="card-title col-lg-12 d-flex flex-column">
									<span class="fs-2 fw-bold text-gray-900 me-2 lh-1">
										Holiday</span>
								</div>
							</div>
							<div class="card-body pt-2 pb-4 px-0">
								<div class="tab-content mb-2 px-9">
									<c:if test="${not empty holidayList}">
										<div class="tab-pane fade show active"
											id="kt_timeline_widget_3_tab_content_4">
											<c:forEach var="hld" items="${holidayList}">
												<div class="d-flex align-items-center mb-6">
													<fmt:formatDate value="${hld.start_date}" pattern="u"
														var="day" />
													<span data-kt-element="bullet"
														class="dayofWeek bullet bullet-vertical d-flex align-items-center min-h-40px mh-100 me-4
													<c:if test="${day == '1'}"> bg-yellow</c:if>
													<c:if test="${day == '2'}"> bg-pink</c:if>
													<c:if test="${day == '3'}"> bg-success</c:if>
													<c:if test="${day == '4'}"> bg-orange</c:if>
													<c:if test="${day == '5'}"> bg-primary</c:if>"></span>
													<div class="flex-grow-1 me-5">
														<div class="text-grey fw-medium fs-3">${hld.head}</div>
														<div class="text-grey fw-medium fs-6">
															<fmt:formatDate value="${hld.start_date}"
																pattern="E, dd MMM" />
														</div>
													</div>
													<jsp:useBean id="now" class="java.util.Date" />
													<fmt:formatDate var="todayStr" value="${now}"
														pattern="yyyy-MM-dd" />
													<fmt:formatDate var="holidayStr" value="${hld.start_date}"
														pattern="yyyy-MM-dd" />
													<c:if test="${holidayStr eq todayStr}">
														<span class="badge badge-light-danger">Today</span>
													</c:if>
												</div>
											</c:forEach>
										</div>
									</c:if>
									<c:if test="${empty holidayList}">
										<div class="tab-pane fade show active"
											id="kt_timeline_widget_3_tab_content_4">
											<div class="d-flex align-items-center mb-6">
												<span class="fs-4 fw-semibold text-danger">No
													holidays</span>
											</div>
										</div>
									</c:if>
								</div>
							</div>
						</div>

						<div class="card card-flush h-auto mb-5 mb-xl-10">
							<div class="card-header pt-5 mb-2">
								<div class="card-title d-flex flex-column">
									<span class="fs-2 fw-medium text-gray-900 me-2 lh-1 mb-2">
										Last Update</span> <span class="text-muted fw-medium pt-1 fs-7">Check
										In / Check Out</span>
								</div>
								<div class="d-flex flex-column">
									<a
										class="btn btn-sm btn-icon btn-secondary w-40px h-40px d-flex"
										href="checkAllCalendar"> <i
										class="ki-duotone ki-calendar-tick fs-1 text-muted"> <span
											class="path1"></span><span class="path2"></span> <span
											class="path3"></span><span class="path4"></span> <span
											class="path5"></span><span class="path6"></span>
									</i></a>
								</div>
							</div>
							<div class="card-body pt-2 pb-4 flex-wrap">
								<div class="tab-content mb-2 px-0">
									<div class="tab-pane fade show active"
										id="kt_timeline_widget_3_tab_content_4">
										<div class="d-flex align-items-center mb-10">
											<span data-kt-element="bullet"
												class="bullet bullet-vertical d-flex align-items-center bg-success min-h-25px mh-300 me-4 rounded-0"></span>
											<div class="flex-grow-1 me-5">
												<div class=" col-lg-12 text-gray-900">
													<c:if
														test="${not empty lastcheckin[0].work_hours_time_work || lastcheckin[0].work_hours_time_work != null}">
														<span class="fs-2 me-4 fw-medium"><fmt:formatDate
																value="${lastcheckin[0].work_hours_time_work}"
																pattern="HH:mm" /></span>
														<span class="fs-6 ms-4 fw-medium"><fmt:formatDate
																value="${lastcheckin[0].work_hours_time_work}"
																pattern="dd MMM yyyy" /></span>
													</c:if>
													<c:if
														test="${empty lastcheckin[0].work_hours_time_work || lastcheckin[0].work_hours_time_work == null}">
														<span class="fs-4 me-4">No Data</span>
													</c:if>
												</div>
											</div>
											<c:if test="${lastcheckin[0].work_type.toString() eq '1'}">
												<i class="ki-duotone ki-map fs-1 text-primary"> <span
													class="path1"></span><span class="path2"></span><span
													class="path3"></span>
												</i>
											</c:if>
											<c:if test="${lastcheckin[0].work_type.toString() eq '2'}">
												<i class="ki-duotone ki-home-2 fs-1 text-success"> <span
													class="path1"></span> <span class="path2"></span>
												</i>
											</c:if>
										</div>
										<div class="d-flex align-items-center mb-4">
											<span data-kt-element="bullet"
												class="bullet bullet-vertical d-flex align-items-center bg-info min-h-25px mh-100 me-4 rounded-0"></span>
											<div class="flex-grow-1 me-5">
												<div class=" col-lg-12 text-gray-900">
													<c:if
														test="${not empty lastcheckout[0].work_hours_time_work || lastcheckout[0].work_hours_time_work != null}">
														<span class="fs-2 me-4 fw-medium"><fmt:formatDate
																value="${lastcheckout[0].work_hours_time_work}"
																pattern="HH:mm" /></span>
														<span class="fs-6 ms-4 fw-medium"><fmt:formatDate
																value="${lastcheckout[0].work_hours_time_work}"
																pattern="dd MMM yyyy" /></span>
													</c:if>
													<c:if
														test="${empty lastcheckout[0].work_hours_time_work || lastcheckout[0].work_hours_time_work == null}">
														<span class="fs-4 me-4">No Data</span>
													</c:if>
												</div>
											</div>
											<c:if test="${lastcheckout[0].work_type.toString() eq '1'}">
												<i class="ki-duotone ki-map fs-1 text-primary ms-auto">
													<span class="path1"></span> <span class="path2"></span> <span
													class="path3"></span>
												</i>
											</c:if>
											<c:if test="${lastcheckout[0].work_type.toString() eq '2'}">
												<i class="ki-duotone ki-home-2 fs-1 text-success ms-auto">
													<span class="path1"></span> <span class="path2"></span>
												</i>
											</c:if>
										</div>

									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="page-loader"></div>
</div>

<script>

// Submit Logic
$("#mdSubmitBtn").click(function() {
	const userId = "${logonUser}";
	const workType = $("input[name='mdWorkType']:checked").val();
	const checkType = $("input[name='mdCheckType']:checked").val();
	const date = $("#mdDate").val();
	const time = $("#mdTime").val();
	const reasonRaw = $("#mdReason").val();
    const reason = reasonRaw ? reasonRaw.trim() : "";
	const lat = "";
	const lng = "";
	
	let valid = true;
	
	// Validation
	if(!date){ $("#mdDate").addClass("is-invalid"); valid = false; } 
    else { $("#mdDate").removeClass("is-invalid"); }
	
	if(!time){ $("#mdTime").addClass("is-invalid"); valid = false; } 
    else {
		const [hour, minute] = time.split(":").map(Number);
	    const selectedDateTime = new Date(date);
	    selectedDateTime.setHours(hour);
	    selectedDateTime.setMinutes(minute);
	    selectedDateTime.setSeconds(0);
	    selectedDateTime.setMilliseconds(0);
	    const now = new Date();
	    if (selectedDateTime > now) {
	    	$(".mdTime.invalid-feedback").text("Can't select a future time.").show();
	    	$("#mdTime").addClass("is-invalid");
	    	valid = false;
	    } else {
	    	$(".mdTime.invalid-feedback").hide();
	    	$("#mdTime").removeClass("is-invalid");
	    }
	}
	
	if(!checkType){ $(".checkType.invalid-feedback").show(); valid = false; } 
    else { $(".checkType.invalid-feedback").hide(); }
	
	if(!workType){ $(".workType.invalid-feedback").show(); valid = false; } 
    else { $(".workType.invalid-feedback").hide(); }
	
	const reasonEl = $("#mdReason");
    const reasonErrorEl = $(".reason.invalid-feedback");
	
    if(!reason){
        console.log("Empty or just spaces");
        reasonErrorEl.text("Please provide a reason.").show();
        reasonEl.addClass("is-invalid");
        valid = false;
    } else if(reason.length < 10){
        console.log("Too short");
        reasonErrorEl.text("Reason must be at least 10 characters long.").show();
        reasonEl.addClass("is-invalid");
        valid = false;
    } else {
    	reasonErrorEl.hide();
    	reasonEl.removeClass("is-invalid");
    }
	
	if(!valid){ return; }
	
	saveCheckInOut(userId, workType, checkType, "retro", date, time, reason, lat, lng);
});

// Save Function
function saveCheckInOut(userId, workType, checkType, mode, selectDate, selectTime, reason, lat, lng){
	console.log(userId+"|"+workType+"|"+checkType+"|"+mode+"|"+selectDate+"|"+selectTime+"|"+reason);
	toastr.options = {
		"closeButton": false,
		"debug": false,
		"newestOnTop": false,
		"progressBar": false,
		"positionClass": "toastr-top-right",
		"preventDuplicates": false,
		"onclick": null,
		"showDuration": "300",
		"hideDuration": "1000",
		"timeOut": "2000",
		"extendedTimeOut": "1000",
		"showEasing": "swing",
		"hideEasing": "linear",
		"showMethod": "fadeIn",
		"hideMethod": "fadeOut"
	};
	
	const data = {
			"userId": userId,
			"workType": workType,
			"checkType": checkType,
			"mode": mode,
			"reason": reason,
			"latitude": lat,
			"longitude": lng,
	};
	
	if(mode === "retro"){
		data.date = selectDate;
	    data.time = selectTime;
	}
	
	var loadingEl = $("<div>")
		.attr("id", "page-loader")
		.css({
            "position": "fixed",
            "top": "0", "left": "0",
            "width": "100%", "height": "100%",
            "background-color": "rgba(0, 0, 0, 0.5)",
            "z-index": "9999",
            "display": "flex",
            "align-items": "center",
            "justify-content": "center",
            "flex-direction": "column",
            "backdrop-filter": "blur(2px)"
        })
        .html('<div class="spinner-border text-primary" role="status" style="width: 3rem; height: 3rem;"></div>'
        	+'<span class="text-white fs-4 fw-bold mt-3">Processing...</span>');
	$("body").append(loadingEl);
	
	$.ajax({
	    url: "saveCheckInOut",
	    type: "POST",
	    dataType: "json",
	    data: data,
	    success: function (res) {
	    	console.log(res);
	      	let type = res.type === "1" ? "Check-in" : "Check-out";
	      	if(res.status === "success"){
	      		toastr.success(type + " : " + res.time, "Saved successfully!");
	      		setTimeout(function() {
	      			window.location.href = "check_in_out";
	    		}, 2000);
	      	} else {
	      		$("#page-loader").remove();
	      		toastr.error(res.message || "Failed to record your attendance. Please try again.");
	      	}
	      $("#retroModal").modal("hide");
	    },
	    error: function (xhr, status, error) {
	    	$("#page-loader").remove();
	    	toastr.error("Error saving data: " + error);
	    }
	  });
}

// Flatpickr Setup
const ALLOWED_DATE = "${allowedDate}";
const TODAY = new Date();

const datePicker = flatpickr("#mdDate", {
	altInput: true,
	static: true,
    disableMobile: "true",
	altFormat: "j, M Y",
	dateFormat: "Y-m-d",
    enableTime: false,
    defaultDate: "today",
    minDate: new Date(ALLOWED_DATE),
    maxDate: "today",
    static: true,
    onOpen: function(selectedDates, dateStr, instance) {
        if (timePicker.isOpen) timePicker.close();
    },
});

const timePicker = flatpickr("#mdTime", {
    enableTime: true,
    noCalendar: true,
    dateFormat: "H:i",
    time_24hr: true,
    defaultDate: TODAY,
    static: true,
    onOpen: function(selectedDates, dateStr, instance) {
        if (datePicker.isOpen) datePicker.close();
    },
});

</script>