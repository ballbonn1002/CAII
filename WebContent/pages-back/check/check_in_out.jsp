<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<style>
.bg-yellow {
	background-color: var(--bs-yellow) !important;
}
.bg-pink {
	background-color: var(--bs-pink) !important;
}
.bg-orange {
	background-color: var(--bs-orange) !important;
}
.btn-check:checked + label span {
  color: #fff !important;
}
.form-check.form-check-info .form-check-input:checked{
	background-color: var(--bs-info);
}
</style>

<!--begin::Main-->
<div class="app-main flex-column flex-row-fluid" id="kt_app_main">

	<!--begin::Content wrapper-->
	<div class="d-flex flex-column flex-column-fluid">
		<!--begin::Toolbar-->
		<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
		<div id="kt_app_toolbar_container" class="app-container container-fluid d-flex flex-stack">
			<!--begin::Page title-->
			<div class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
				<h1 class="page-heading d-flex text-gray-900 fw-bold fs-3 flex-column justify-content-center my-0">Check
						In / Check Out</h1>
				<ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
					<li class="breadcrumb-item text-muted"><a href="demo_dashboard"
						class="text-muted text-hover-primary">Home</a></li>
					<li class="breadcrumb-item">
						<span class="bullet bg-gray-500 w-5px h-2px"></span></li>
					<li class="breadcrumb-item text-muted">Check In / Check Out</li>
				</ul>
			</div>
			<!--end::Page title-->
		</div>
		</div>
		<!--end::Toolbar-->
		<!--begin::Content-->
		<div id="kt_app_content" class="app-content flex-column-fluid">
			<div id="kt_app_content_container" class="app-container container-xxl">
				<!--begin::Row-->
				<div class="row gx-5 gx-xl-10 mb-xl-10">
					<!--begin::Col-->
					<div class="col-xl-8 col-lg-8 col-md-8 mb-10">
						<div class="card card-flush h-auto mb-5 mb-xl-10">
							<!--begin::Header-->
							<div class="card-header pt-5 d-flex justify-content-between align-items-center">
								<div class="card-title col-lg-12 col-md-12 col-sm-12">
										<div class="d-flex flex-column w-100">
											<span class="fs-2 fw-bold text-gray-900 me-2 lh-1 ls-n2">
											Work Hours</span>
											<div class="d-flex align-items-center pt-2">
												<span class="text-white fw-semibold fs-7 bg-primary">${jobsite.name_site}</span>
												<span class="text-gray-700 px-2 fw-semibold fs-7">${user.workTimeStart}
													- ${user.workTimeEnd}</span>
											</div>
										</div>
										<div class="d-flex flex-column">
											<button type="button" class="btn btn-sm btn-flex btn-secondary"
												data-bs-toggle="modal" data-bs-target="#retroModal">
											<i class="ki-duotone ki-calendar-edit fs-1">
												<span class="path1"></span>
												<span class="path2"></span>
												<span class="path3"></span>
											</i> Retroactively
											</button>
										</div>
								</div>
							</div>
							<!--end::Header-->
							<!--begin::Card body-->
							<div class="card-body d-flex flex-column">
								<div class="px-15">
									<!-- Real-Time Clock -->
									<div class="d-flex flex-center">
										<span id="clock" class="fs-4x fw-bold text-gray-900 text-center"></span> 
										<span id="clock-second" class="fs-3x fw-bold text-gray-500"></span>
									</div>
									<!-- Date -->
									<div id="date" class="fs-2x fw-semibold text-gray-800 text-center"></div>
									<!-- Check Type -->
									<div class="d-flex justify-content-between gap-10 py-7">
										<div class="flex-fill">
										<input type="radio" class="btn-check" name="checkType" id="checkType1" value="1">
										<label for="checkType1"
											class="btn bg-light btn-active-success d-flex flex-column justify-content-center align-items-center py-7">
											<i class="ki-duotone ki-time fs-1">
												<span class="path1"></span>
												<span class="path2"></span>
											</i>
											<span class="fs-2 text-muted">Check-In</span>
										</label>
										</div>
										<div class="flex-fill">
										<input type="radio" class="btn-check" name="checkType" id="checkType2" value="2">
										<label for="checkType2" 
											class="btn bg-light btn-active-info d-flex flex-column justify-content-center align-items-center py-7">
											<i class="ki-duotone ki-time fs-1">
												<span class="path1"></span>
												<span class="path2"></span>
											</i>
											<span class="fs-2 text-muted">Check-Out</span>
										</label>
										</div>
									</div>
									<div class="d-flex mb-4">
										<span class="fs-3 fw-semibold text-gray-800">
											Work Your Location</span><span class="text-danger">*</span>
									</div>
									<div class="d-flex align-items-center">
										<div class="col-md-6 col-sm-6 py-2 me-6 mb-3">
											<div class="form-check form-check-custom form-check-primary form-check-solid form-check-md">
												<input name="workType" class="form-check-input" id="workType1" type="radio" value="1"
													<c:if test="${user.workType == 1}">checked</c:if>> 
												<i class="ki-duotone ki-map fs-1"> 
													<span class="path1"></span> 
													<span class="path2"></span> 
													<span class="path3"></span>
												</i>
												<label for="workType1" class="form-check-label fs-6">On-Site</label>
											</div>
										</div>
										<div class="col-md-6 col-sm-6 py-2 me-6 mb-3">
											<div class="form-check form-check-custom form-check-primary form-check-solid form-check-md">
												<input name="workType" class="form-check-input" id="workType2" type="radio" value="2"
													<c:if test="${user.workType == 2}">checked</c:if>> 
												<i class="ki-duotone ki-home-2 fs-1">
													<span class="path1"></span>
													<span class="path2"></span>
												</i>
												<label for="workType2" class="form-check-label fs-6">WFH</label>
											</div>
										</div>
									</div>
									<div class="d-flex">
										<button id="submitBtn"
											class="btn btn-primary w-100 text-center">Accept</button>
									</div>
								</div>
							</div>
							<!--end::Card body-->
						</div>
					</div>
					<!--end::Col-->
					<!--begin::Last Check-->
					<div class="col-xl-4 col-lg-4 col-md-4 col-sm-12 mb-10">
						<div class="card card-flush h-auto mb-5 mb-xl-10">
							<div class="card-header pt-5">
								<div class="card-title d-flex flex-column">
									<span class="fs-2 fw-bold text-gray-900 me-2 lh-1 ls-n2">
										Last Update</span>
									<span class="text-gray-500 pt-1 fs-7">Check
										In / Check Out</span>
								</div>
								<div class="d-flex flex-column">
								<button type="button" class="btn btn-sm btn-flex btn-secondary px-2">
								<i class="ki-duotone ki-calendar-tick fs-1">
									<span class="path1"></span><span class="path2"></span>
									<span class="path3"></span><span class="path4"></span>
									<span class="path5"></span><span class="path6"></span>
								</i></button>
								</div>
							</div>
							<div class="card-body pt-2 pb-4 d-flex flex-wrap">
								<div class="tab-content mb-2 px-0">
									<div class="tab-pane fade show active"
										id="kt_timeline_widget_3_tab_content_4">
										<div class="d-flex mb-6">
											<span data-kt-element="bullet"
												class="bullet bullet-vertical d-flex align-items-center bg-success min-h-40px mh-100 me-4"></span>
											<div class="flex-grow-1 me-5">
												<div class=" col-lg-12 text-gray-900">
													<span class="fs-2 me-4"><fmt:formatDate
														value="${lastcheckin[0].work_hours_time_work}" pattern="dd MMM yyyy"/></span>	
													<span class="fs-6"><fmt:formatDate 
														value="${lastcheckin[0].work_hours_time_work}" pattern="HH:mm"/></span>												
												</div>
											</div>
											<c:if test="${lastcheckin[0].work_type.toString() eq '1'}">
														<i class="ki-duotone ki-map fs-1"> 
															<span class="path1"></span> 
															<span class="path2"></span> 
															<span class="path3"></span>
														</i>
											</c:if>
											<c:if test="${lastcheckin[0].work_type.toString() eq '2'}">
														<i class="ki-duotone ki-home-2 fs-1">
															<span class="path1"></span>
															<span class="path2"></span>
														</i>
											</c:if>
										</div>
										<div class="d-flex align-items-center mb-6">
											<span data-kt-element="bullet"
												class="bullet bullet-vertical d-flex align-items-center bg-info min-h-40px mh-100 me-4"></span>
											<div class="flex-grow-1 me-5">
												<div class=" col-lg-12 text-gray-900">
													<span class="fs-2 me-4"><fmt:formatDate
														value="${lastcheckout[0].work_hours_time_work}" pattern="dd MMM yyyy" /></span>
													<span class="fs-6"><fmt:formatDate 
														value="${lastcheckout[0].work_hours_time_work}" pattern="HH:mm"/></span>
												</div>												
											</div>
											<c:if test="${lastcheckout[0].work_type.toString() eq '1'}">
												<i class="ki-duotone ki-map fs-1"> 
													<span class="path1"></span> 
													<span class="path2"></span> 
													<span class="path3"></span>
												</i>			
											</c:if>
											<c:if test="${lastcheckout[0].work_type.toString() eq '2'}">
												<i class="ki-duotone ki-home-2 fs-1">
													<span class="path1"></span>
													<span class="path2"></span>
												</i>
											</c:if>
										</div>
										
									</div>
								</div>
							</div>
						</div>
						<div class="card card-flush h-auto mb-5 mb-xl-10">
							<div class="card-header pt-5">
								<div class="card-title col-lg-12 d-flex flex-column">
									<span class="fs-2 fw-bold text-gray-900 me-2 lh-1 ls-n2">
										Holiday</span>
								</div>
							</div>
							<div class="card-body pt-2 pb-4 px-0">
								<div class="tab-content mb-2 px-9">
								<c:if test="${not empty holidayList}">
									<div class="tab-pane fade show active" id="kt_timeline_widget_3_tab_content_4">
										<c:forEach var="hld" items="${holidayList}">
											<div class="d-flex align-items-center mb-6">
												<fmt:formatDate value="${hld.start_date}" pattern="u" var="day"/>
												<span data-kt-element="bullet"
													class="dayofWeek bullet bullet-vertical d-flex align-items-center min-h-40px mh-100 me-4
													<c:if test="${day == '1'}"> bg-yellow</c:if>
													<c:if test="${day == '2'}"> bg-pink</c:if>
													<c:if test="${day == '3'}"> bg-success</c:if>
													<c:if test="${day == '4'}"> bg-orange</c:if>
													<c:if test="${day == '5'}"> bg-primary</c:if>"></span>
												<div class="flex-grow-1 me-5">
													<div class="text-grey fw-semibold fs-3">${hld.head}</div>
													<div class="text-grey fw-semibold fs-6"><fmt:formatDate value="${hld.start_date}" pattern="E, dd MMM"/></div>
												</div>
												<jsp:useBean id="now" class="java.util.Date" />
												<fmt:formatDate var="todayStr" value="${now}" pattern="yyyy-MM-dd" />
												<fmt:formatDate var="holidayStr" value="${hld.start_date}" pattern="yyyy-MM-dd" />
												<c:if test="${holidayStr eq todayStr}}">
													<span class="badge badge-light-danger">Today</span>
												</c:if>
											</div>
										</c:forEach>
									</div>
								</c:if>
								<c:if test="${empty holidayList}">
									<div class="tab-pane fade show active" id="kt_timeline_widget_3_tab_content_4">
											<div class="d-flex align-items-center mb-6">
												<span class="fs-2 fw-semibold text-danger">No holidays</span>
											</div>
									</div>
								</c:if>
								</div>
							</div>
						</div>
						<div class="card card-flush h-auto mb-5 mb-xl-10">
							<div class="accordion" id="kt_accordion_1">
								<div class="accordion-item">
							        <h2 class="accordion-header" id="kt_accordion_1_header_1">
							            <button class="accordion-button fs-2 fw-bold lh-1 ls-n2" type="button" data-bs-toggle="collapse" 
							            	data-bs-target="#kt_accordion_1_body_1" aria-expanded="true" aria-controls="kt_accordion_1_body_1">
							                Your Location
							            </button>
							        </h2>
							        <div id="kt_accordion_1_body_1" class="accordion-collapse collapse show" aria-labelledby="kt_accordion_1_header_1" data-bs-parent="#kt_accordion_1">
							            <div class="accordion-body">
											<div id="map" style="width:100%; height:350px;"></div>
											<input type="hidden" id="x" class="latitude" name="latitude">
											<input type="hidden" id="y" class="longitude" name="longitude">
							            </div>
							        </div>
							    </div>
							</div>
							
						</div>
					</div>
					<!--end::Last Check-->
					
				</div>
				<!--end::Row-->
			</div>
		</div>
		<!--end::Content-->
	</div>
	<!--end::Content wrapper-->
</div>
<!--end:::Main-->
<!--begin:::Modal-->

<!--end:::Modal-->
<div class="modal fade" tabindex="-1" id="retroModal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<div class="modal-title"></div>
				<!--begin::Close Icon-->
                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                </div>
                <!--end::Close Icon-->
			</div>
			<div class="modal-body">
				<div class="flex-column">
					<div class="flex-column align-items-center pb-12">
						<h1 class="text-gray-900">Retroactively Work Hours</h1>
						<span class="text-gray-500">Can be retroactive for 1 business day</span>
					</div>
					<div class="row mb-10">
						<label for="dateTimeInput" class="required form-label">Date-Time</label>
						<div class="col-md-6 col-sm-6">
							<input class="form-control" id="mdDate"/>
						</div>
						<div class="col-md-6 col-sm-6">
							<input class="form-control" id="mdTime"/>
							<div class="mdTime invalid-feedback" style="display:none;"></div>
						</div>
					</div>
					<div class="row mb-10">
						<div class="col-md-6 col-sm-6">
							<div class="form-check form-check-custom form-check-success">
							    <input class="form-check-input" type="radio" name="mdCheckType" id="mdCheckin" value="1"/>
							    <label class="form-check-label text-gray-800" for="mdCheckin">Check-In</label>
							</div>
						</div>
						<div class="col-md-6 col-sm-6">
							<div class="form-check form-check-custom form-check-info">
							    <input class="form-check-input" type="radio" name="mdCheckType" id="mdCheckout" value="2"/>
							    <label class="form-check-label text-gray-800" for="mdCheckout">Check-Out</label>
							</div>
						</div>
						<div class="checkType invalid-feedback" style="display:none;">Please select your check type (Check-In or Check-Out).</div>
					</div>
					<div class="row mb-10">
						<label for="workTypeInput" class="required form-label">Your Work Location</label>
						<div class="col-md-6 col-sm-6">
							<input class="form-check-input" name="mdWorkType" type="radio" value="1"
							<c:if test="${user.workType == 1}"> checked </c:if>>
							<label class="form-check-label text-gray-800" for="">On-Site</label>
						</div>
						<div class="col-md-6 col-sm-6">
							<input class="form-check-input" name="mdWorkType" type="radio" value="2"
							<c:if test="${user.workType == 2}"> checked </c:if>>
							<label class="form-check-label text-gray-800" for="">WFH</label>
						</div>
						<div class="workType invalid-feedback" style="display:none;">Please select your work location (WFH or On-Site).</div>
					</div>
					<div class="row mb-10">
						<div class="col-md-12 col-sm-12">
							<span class="">Reason</span>
							<textarea class="form-control" name="mdReason" id="mdReason" rows="" cols="" placeholder="Please provide a reason."></textarea>
							<div class="reason invalid-feedback" style="display:none;"></div>
						</div>
					</div>
					<div class="row">
						<div class="d-flex flex-center gap-4">
							<button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
		                	<button type="button" class="btn btn-success" id="mdSubmitBtn">Submit</button>
		                </div>
					</div>
                </div>
			</div>
		</div>
	</div>
</div>

<script>
$(document).ready(function() {
	setInterval(updateClock, 1000);
	updateClock();
	
	const now = new Date();
	const hour = now.getHours();
	const minute = now.getMinutes();
	const currentTime = hour + (minute / 60);
	
	$("input[name='mdCheckType']").prop("checked", false);
	if (currentTime >= 0 && currentTime <= 12) {
		$("#checkType1").prop("checked", true);
		$("#mdCheckin").prop("checked", true);
		console.log("Auto selected: Check-In");
	} else if (currentTime > 12 && currentTime < 24) {
	    $("#checkType2").prop("checked", true);
	    $("#mdCheckout").prop("checked", true);
	    console.log("Auto selected: Check-Out");
	  } else {
	    console.log("not selecting any option");
	  }
});

function updateClock() {
	fetch("https://timeapi.io/api/Time/current/zone?timeZone=Asia/Bangkok")
		.then(resp => resp.json())
	    .then(data => {
	        let dateTimeStr = data.dateTime; // "2025-09-09T09:09:09"
	        let dt = new Date(dateTimeStr);
	        
	        let hours = dt.getHours().toString().padStart(2, '0');
	        let minutes = dt.getMinutes().toString().padStart(2, '0');
	        let seconds = dt.getSeconds().toString().padStart(2, '0');
	        let time = hours+":"+minutes
	    	$("#clock").text(time); // หรือ format เอา
	    	$("#clock-second").text(":"+seconds);
	    	//$("#clock").text(dateTimeStr);
	    	
	        let options = { day: '2-digit', month: 'short', year: 'numeric' };
	        let dateStr = dt.toLocaleDateString('en-GB', options).replace(/,/g, '');
	        $("#date").text(dateStr);
	    })
	    .catch(err => console.error("error:", err));
}

$("#submitBtn").click(function() {
	const userId = "${logonUser}";
	const workType = $("input[name='workType']:checked").val();
	const checkType = $("input[name='checkType']:checked").val();
	const lat = $("input[name='latitude']").val();
	const lng = $("input[name='longitude']").val();
	console.log(userId+"/"+workType+"/"+checkType);
	saveCheckInOut(userId, workType, checkType, "normal", null, null, null, lat, lng);
});

$("#mdSubmitBtn").click(function() {
	const userId = "${logonUser}";
	const workType = $("input[name='mdWorkType']:checked").val();
	const checkType = $("input[name='mdCheckType']:checked").val();
	const date = $("#mdDate").val();
	const time = $("#mdTime").val();
	const reason = $("#mdReason").val();
	const lat = $("input[name='latitude']").val();
	const lng = $("input[name='longitude']").val();
	let valid = true;
	if(!date){
		$("#mdDate").addClass("is-invalid");
		valid = false;
	} else {
		$("#mdDate").removeClass("is-invalid");
	}
	
	if(!time){
		$("#mdTime").addClass("is-invalid");
		valid = false;
	} else {
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
	
	if(!checkType){
		$(".checkType.invalid-feedback").show();
		valid = false;
	} else {
		$(".checkType.invalid-feedback").hide();
	}
	
	if(!workType){
		$(".workType.invalid-feedback").show();
		valid = false;
	} else {
		$(".workType.invalid-feedback").hide();
	}
	
	if(!reason){
		console.log(1);
		$("#mdReason").addClass("is-invalid");
		valid = false;
	} else if(reason.length < 10){
		console.log(2);
		$(".reason.invalid-feedback")
		.text("Reason must be at least 10 characters long.").show();
		$("#mdReason").addClass("is-invalid");
		valid = false;
	} else {
		$(".reason.invalid-feedback").hide();
		$("#mdReason").removeClass("is-invalid");
	}
	if(!valid){
		return;
	}
	saveCheckInOut(userId, workType, checkType, "retro", date, time, reason, lat, lng);
});

const ALLOWED_DATE = "${allowedDate}";
const TODAY = new Date();
console.log(ALLOWED_DATE);


const datePicker = flatpickr("#mdDate", {
	altInput: true,
	altFormat: "j M Y",
	dateFormat: "Y-m-d",
    enableTime: false,
    defaultDate: "today",
    minDate: new Date(ALLOWED_DATE),
    maxDate: "today",
    static: true,
    onOpen: function(selectedDates, dateStr, instance) {
        if (timePicker.isOpen) {
            timePicker.close();
        }
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
        if (datePicker.isOpen) {
            datePicker.close();
        }
    },
});

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
	    			location.reload();
	    		}, 2000);
	      	} else {
	      		toastr.error(res.message || "Failed to record your attendance. Please try again.");
	      	}
	    	
	      console.log("Response:", res);
	      $("#retroModal").modal("hide");
	    },
	    error: function (xhr, status, error) {
	      toastr.error("Error saving data: " + error);
	    }
	  });
}
</script>
<script>
var map, infoWindow, marker;
function initMap() {
	map = new google.maps.Map(document.getElementById('map'), {
		center : {
			lat : -34.397,
			lng : 150.644
		},
		zoom : 16
	});
	var latEl = document.querySelector('.latitude');
	var longEl = document.querySelector('.longitude');
	infoWindow = new google.maps.InfoWindow;
	marker = new google.maps.Marker;
	if (navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(function(position) {
			var pos = {
				lat : position.coords.latitude,
				lng : position.coords.longitude
			};
			x = pos.lat;	y = pos.lng;

			marker.setPosition(pos),
			marker.setMap(map),
			marker.setDraggable(true);

			infoWindow.setContent('Current Position');
			infoWindow.open(map,marker);
			map.setCenter(pos);
			adddata();
			google.maps.event.addListener(marker, "dragend", function(event) {
				var lati, lngti, address;
				console.log('i am dragged');
				lati = marker.getPosition().lat();
				lngti = marker.getPosition().lng();
				var geocoder = new google.maps.Geocoder();
				geocoder.geocode({
					latLng : marker.getPosition()
				},
				function(result, status) {
					if ('OK' === status) { // This line can also be written like if ( status == google.maps.GeocoderStatus.OK ) {
						address = result[0].formatted_address;
						resultArray = result[0].address_components;
						// Get the city and set the city input value to the one selected
							
						latEl.value = lati;
						longEl.value = lngti;
					} else {
						console.log('Geocode was not successful for the following reason: ' + status);
					}
					if (infoWindow) {
						infoWindow.close();
					}
					/* Creates the info Window at the top of the marker */
					infoWindow = new google.maps.InfoWindow({
						content : address
					});
					infoWindow.open(map, marker);
				});
			});
		},
		function() {
			handleLocationError(true, infoWindow, map.getCenter());
		});
	} else {
		// Browser doesn't support Geolocation
		handleLocationError(false, infoWindow, map.getCenter());
	}
}
function adddata() {
	$(document).ready(function() {
		document.getElementById("x").value = x;
	});

	$(document).ready(function() {
		document.getElementById("y").value = y;
	});
}
function handleLocationError(browserHasGeolocation, infoWindow, pos) {
	infoWindow.setPosition(pos);
	infoWindow.setContent(browserHasGeolocation ? 'Error: The Geolocation service failed.' 
			: 'Error: Your browser doesn\'t support geolocation.');
	infoWindow.open(map);
}
</script>
<script async defer
	src="https://maps.googleapis.com/maps/api/js?key=${GOOGLE_API_KEY}&callback=initMap">
</script>