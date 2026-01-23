<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<style>
.btn-check:checked + label span {
	color: #fff !important;
}

.form-check.form-check-info .form-check-input:checked {
	background-color: var(--bs-info);
}

.min-w-170px {
	min-width: 170px !important;
}
</style>

<!--begin::Main-->
<fmt:setLocale value="en_US" />
<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
	<!--begin::Content wrapper-->
	<div class="d-flex flex-column flex-column-fluid">
		<!--begin::Toolbar-->
		<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
			<div id="kt_app_toolbar_container"
				class="app-container container-fluid d-flex flex-stack">
				<!--begin::Page title-->
				<div
					class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
					<h1
						class="page-heading d-flex text-gray-700 fw-semibold flex-column justify-content-center my-0">Check
						In / Check Out</h1>
					<ul
						class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
						<li class="breadcrumb-item text-muted">Home</li>
						<li class="breadcrumb-item"><span
							class="bullet bg-gray-500 w-5px h-2px"></span></li>
						<li class="breadcrumb-item text-muted">Check In / Check Out</li>
					</ul>
				</div>
				<!--end::Page title-->
			</div>
		</div>
		<!--end::Toolbar-->
		<!--begin::Content-->
		<div id="kt_app_content" class="app-content flex-column-fluid">
			<div id="kt_app_content_container"
				class="app-container container-xxl">
				<!--begin::Row-->
				<div class="row gx-5 gx-xl-10 mb-xl-10">
					<!--begin::Col-->
					<div class="col-xl-8 col-lg-8 col-md-8 col-sm-12 col-12 mb-10">
						<div class="card card-flush h-auto mb-5 mb-xl-10">
							<!--begin::Header-->
							<div
								class="card-header pt-5 d-flex justify-content-between align-items-center">
								<div class="card-title col-lg-12 col-md-12 col-sm-12 col-12">
									<div class="d-flex flex-column w-100">
										<span class="fw-medium text-gray-900 me-2 lh-1">
											Work Hours</span>
										<div class="d-flex align-items-center pt-2 gap-2">
											<c:choose>
												<c:when test="${not empty jobsiteList}">
													<c:forEach var="site" items="${jobsiteList}">
														<span
															class="text-white fw-semibold fs-7 bg-primary px-2 py-1 rounded">
															<c:out value="${site['name_site']}" />
														</span>
													</c:forEach>
												</c:when>
												<c:otherwise>
													<span
														class="text-white fw-semibold fs-7 bg-primary px-2 py-1 rounded">
														None </span>
												</c:otherwise>
											</c:choose>
											<span class="text-gray-700 pe-2 fw-semibold fs-7">
												${user.workTimeStart} - ${user.workTimeEnd} </span>
										</div>
									</div>
									<div class="d-flex flex-column">
										<a href="retroactive"
											class="btn btn-sm btn-icon btn-flex btn-secondary min-h-45px min-w-170px">

											<i class="ki-duotone ki-calendar-edit text-muted fs-1"> <span
												class="path1"></span> <span class="path2"></span> <span
												class="path3"></span>
										</i> <span class="fw-medium fs-6 text-inverse-secondary ps-2">Retroactively</span>
										</a>
									</div>
								</div>
							</div>
							<!--end::Header-->
							<!--begin::Card body-->
							<div class="card-body d-flex flex-column">
								<div class="px-13">
									<!-- Real-Time Clock -->
									<div class="d-flex flex-center align-items-baseline mb-5">
										<span id="clock"
											class=" fw-semibold text-gray-900 text-center"
											style="font-size: 52px;"></span> <span id="clock-second"
											class="fs-2x fw-semibold text-gray-500"></span>
									</div>
									<!-- Date -->
									<div id="date"
										class="fs-2x fw-normal text-gray-900 text-center mb-5"></div>
										
									<!-- Check Type -->
									<div class="row py-7 mb-5 gx-10">
										<div class="col-6">
											<input type="radio" class="btn-check" name="checkType"
												id="checkType1" value="1"> <label for="checkType1"
												class="btn bg-light h-150px btn-active-success d-flex flex-column justify-content-center align-items-center py-7">
												<i class="ki-duotone ki-time fs-2hx mb-5"> <span
													class="path1"></span> <span class="path2"></span>
											</i> <span class="fs-2 fw-medium text-muted">Check-In</span>
											</label>
										</div>
										<div class="col-6">
											<input type="radio" class="btn-check" name="checkType"
												id="checkType2" value="2"> <label for="checkType2"
												class="btn bg-light h-150px btn-active-info d-flex flex-column justify-content-center align-items-center py-7">
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
									<div class="d-flex align-items-center mb-5">
										<div class="col-md-6 col-sm-6 col-6 py-2 me-6 mb-3">
											<div
												class="form-check form-check-custom form-check-primary form-check-solid form-check-md">
												<input name="workType" class="form-check-input me-2"
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
												<input name="workType" class="form-check-input pe-2 me-2"
													id="workType2" type="radio" value="2"
													<c:if test="${user.workType == 2}">checked</c:if>>
												<i class="ki-duotone ki-home-2 fs-1 ms-1 text-success">
													<span class="path1"></span> <span class="path2"></span>
												</i> <label for="workType2"
													class="form-check-label fs-6 fw-normal text-gray-800">WFH</label>
											</div>
										</div>
									</div>
									<div class="d-flex">
										<button id="submitBtn"
											class="btn btn-lg btn-primary w-100 text-center fw-medium">Accept</button>
									</div>
								</div>
							</div>
							<!--end::Card body-->
						</div>

						<!-- begin:Last Update -->
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
										href="checkAllCalendar2"> <i
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
						<!-- end:Last Update -->

						<!-- begin:Your Location -->
						<div class="card card-flush h-auto mb-5 mb-xl-10">
							<div class="accordion" id="kt_accordion_1">
								<div class="accordion-item">
									<h2 class="accordion-header" id="kt_accordion_1_header_1">
										<button class="accordion-button lh-1" type="button"
											data-bs-toggle="collapse"
											data-bs-target="#kt_accordion_1_body_1" aria-expanded="true"
											aria-controls="kt_accordion_1_body_1">
											<span class="fs-2 fw-medium mt-3">Your Location</span>
										</button>
									</h2>
									<div id="kt_accordion_1_body_1"
										class="accordion-collapse collapse show"
										aria-labelledby="kt_accordion_1_header_1"
										data-bs-parent="#kt_accordion_1">
										<div class="accordion-body">
											<div id="map" style="width: 100%; height: 350px;"></div>
											<input type="hidden" id="x" class="latitude" name="latitude">
											<input type="hidden" id="y" class="longitude"
												name="longitude">
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- end:Your Location -->

					</div>
					<!--end::Col-->
					<!--begin::Last Check-->
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

						<!--begin::Announcement-->
						<div class="d-flex align-items-center mb-6">
							<i class="ki-duotone ki-information text-danger"
								style="font-size: 32px;"> <span class="path1"></span> <span
								class="path2"></span> <span class="path3"></span>
							</i>
							<h2 class="fw-bold text-danger mb-0 ms-3">Announcement</h2>
						</div>

						<c:if test="${not empty announcementList}">

							<jsp:useBean id="nowDate" class="java.util.Date" />
							<fmt:formatDate var="todayStr" value="${nowDate}"
								pattern="yyyy-MM-dd" />

							<c:forEach var="ann" items="${announcementList}">

								<c:if test="${fn:trim(ann.highlight) eq '1'}">

									<fmt:formatDate var="announcementDateStr"
										value="${ann.announcement_date}" pattern="yyyy-MM-dd" />

									<div
										class="card hover-elevate-up shadow-sm parent-hover position-relative mb-10"
										style="cursor: pointer; margin: 0 auto;"
										onclick="window.location.href='${pageContext.request.contextPath}/announcementRead?id=${ann.announcementId}'">

										<div
											style="display: flex; justify-content: flex-end; gap: 6px; position: absolute; top: 10px; right: 10px; z-index: 2;">

											<c:if test="${ann.status == '0'}">
												<span class="badge fw-semibold text-dark"
													style="background-color: #FFC107;">Draft</span>
											</c:if>

											<c:if test="${announcementDateStr > todayStr}">
												<span class="badge fw-semibold text-white"
													style="background-color: #F1C40F;">Pending</span>
											</c:if>

											<c:if
												test="${not empty islastest and (ann.announcementId == islastest)}">
												<span class="badge fw-semibold text-white h-25px mt-4 me-4"
													style="background-color: #007BFF;">New</span>
											</c:if>
										</div>

										<div class="card-header p-0 border-0 h-250px">
											<c:choose>
												<c:when
													test="${not empty ann.fileUpload and not empty ann.fileUpload.path}">

													<img src="${ann.fileUpload.path}" alt="${ann.topic}"
														class="w-100 h-100 rounded-top d-block"
														style="object-fit: cover;">

												</c:when>
												<c:otherwise>
													<div
														class="d-flex align-items-center justify-content-center bg-light w-100 h-200px rounded-top">
														<span class="text-gray-400 fs-7">No Image</span>
													</div>
												</c:otherwise>
											</c:choose>
										</div>
										<div
											class="card-body p-9 d-flex flex-column justify-content-center"
											style="min-height: 140px;">

											<div class="fs-6 fw-bold text-gray-800 mb-5 lh-bases">
												${ann.topic}</div>

											<div class="d-flex align-items-center gap-4">
												<span
													class="d-flex align-items-center fs-7 fw-medium text-gray-800 me-1">
													<i class="ki-duotone ki-calendar-2 me-2 text-muted fs-1">
														<span class="path1"></span><span class="path2"></span><span
														class="path3"></span> <span class="path4"></span><span
														class="path5"></span>
												</i> <fmt:formatDate value="${ann.announcement_date}"
														pattern="dd MMM yyyy" />
												</span> <span
													class="d-flex align-items-center fs-7 fw-medium text-gray-800">
													<i class="ki-duotone ki-eye me-2 text-muted fs-1"> <span
														class="path1"></span><span class="path2"></span><span
														class="path3"></span>
												</i> ${empty ann.readcount ? 0 : ann.readcount} Views
												</span>
											</div>
										</div>
									</div>
									<!--end::Announcement-->

								</c:if>
							</c:forEach>
						</c:if>
					</div>
					<!--end::Last Check-->

				</div>
				<!--end::Row-->
			</div>
		</div>
		<!--end::Content-->
	</div>
	<!--end::Content wrapper-->
	<!--begin::Page loader-->
	<!--end::Page loader-->
</div>
<!--end:::Main-->
<script>
let serverTimeOffset = 0;

$(document).ready(function() {
	const now = new Date();
	const hour = now.getHours();
	const minute = now.getMinutes();
	const currentTime = hour + (minute / 60);
// Set check type button by time
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
	
	syncServerTime();
	setInterval(updateClock, 1000);
	
});
// Real-Time Clock
function syncServerTime() {
	fetch("https://timeapi.io/api/Time/current/zone?timeZone=Asia/Bangkok")
	.then(resp => resp.json())
	.then(data => {
        let serverTime = new Date(data.dateTime).getTime();
        let localTime = new Date().getTime();
        serverTimeOffset = serverTime - localTime;
        updateClock();
    })
    .catch(err => console.error("Sync error:", err));
}
//Real-Time Clock Helper
function updateClock() {
	let currentServerTime = new Date(new Date().getTime() + serverTimeOffset);
	let hours = currentServerTime.getHours().toString().padStart(2, '0');
	let minutes = currentServerTime.getMinutes().toString().padStart(2, '0');
	let seconds = currentServerTime.getSeconds().toString().padStart(2, '0');
	
	$("#clock").text(hours + ":" + minutes);
	$("#clock-second").text(":" + seconds);
	
	let options = { day: '2-digit', month: 'short', year: 'numeric' };
	let dateStr = currentServerTime.toLocaleDateString('en-GB', options).replace(/,/g, '');
	$("#date").text(dateStr);
}

$("#submitBtn").click(function() {
	const userId = "${logonUser}";
	const workType = $("input[name='workType']:checked").val();
	const checkType = $("input[name='checkType']:checked").val();
	const lat = $("input[name='latitude']").val();
	const lng = $("input[name='longitude']").val();
	console.log(userId + "/" + workType + "/" + checkType);
	saveCheckInOut(userId, workType, checkType, "normal", null, null, null, lat, lng);
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
			"reason": "",
			"latitude": lat,
			"longitude": lng,
	};
	
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
	    			location.reload();
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
<script>
var inactivityTime = function () {
    var time;
    const TIMEOUT_PERIOD = 1800000;	// 30 * minutes * 1000

    function resetTimer() {
        clearTimeout(time);
        time = setTimeout(logout, TIMEOUT_PERIOD);
    }

    function logout() {
        window.location.href = 'signout.action';
    }

    // --- Events for Desktop ---
    document.onmousemove = resetTimer;
    document.onkeypress = resetTimer;
    document.onclick = resetTimer;
    // --- Events for Mobile ---
    document.ontouchstart = resetTimer; 
    document.ontouchmove = resetTimer;
    // --- Event for Scroll ---
    window.onscroll = resetTimer; 

    resetTimer();
};

window.onload = function() {
    inactivityTime();
};
</script>