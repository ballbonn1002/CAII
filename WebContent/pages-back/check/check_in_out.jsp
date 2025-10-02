<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script async defer
src="https://maps.googleapis.com/maps/api/js?key=${GOOGLE_API_KEY}&callback=initMap">
</script>

<style>
.bs-indigo {
	color: #6610f2;
}
.bs-pink {
	color: #d63384;
}

</style>

<!--begin::Main-->
<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
	<!--begin::Content wrapper-->
	<div class="d-flex flex-column flex-column-fluid">
		<!--begin::Toolbar-->
		<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
			<!--begin::Toolbar container-->
			<div id="kt_app_toolbar_container"
				class="app-container container-fluid d-flex flex-stack">
				<!--begin::Page title-->
				<div
					class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
					<!--begin::Title-->
					<h1
						class="page-heading d-flex text-gray-900 fw-bold fs-3 flex-column justify-content-center my-0">Check
						In / Check Out</h1>
					<!--end::Title-->
					<!--begin::Breadcrumb-->
					<ul
						class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
						<li class="breadcrumb-item text-muted"><a href="demo_dashboard"
							class="text-muted text-hover-primary">Home</a></li>
						<li class="breadcrumb-item">
							<span class="bullet bg-gray-500 w-5px h-2px"></span></li>
						<li class="breadcrumb-item text-muted">Check In / Check Out</li>
					</ul>
					<!--end::Breadcrumb-->
				</div>
				<!--end::Page title-->
			</div>
			<!--end::Toolbar container-->
		</div>
		<!--end::Toolbar-->
		<!--begin::Content-->
		<div id="kt_app_content" class="app-content flex-column-fluid">
			<!--begin::Content container-->
			<div id="kt_app_content_container"
				class="app-container container-xxl">
				<!--begin::Row-->
				<div class="row gx-5 gx-xl-10 mb-xl-10">
					<!--begin::Col-->
					<div class="col-md-8 col-lg-8 col-xl-8 col-xxl-8 mb-10">
						<!--begin::Card Last Up-->
						<div
							class="card card-flush bgi-no-repeat bgi-size-contain bgi-position-x-center border-0 h-md-50 mb-5 mb-xl-10"
							style="background-color: #080655">
							<!--begin::Header-->
							<div class="card-header pt-5 pb-5">
								<!--begin::Title-->
								<div class="card-title d-flex flex-column">
									<span class="fs-2x fw-bold text-white me-2 lh-1 ls-n2">
										Last Update</span>
									<!--begin::Subtitle-->
									<span class="text-white opacity-50 pt-1 fw-semibold fs-6">Check
										In / Check Out</span>
									<!--end::Subtitle-->
								</div>
								<div>
									<button
										class="btn btn-sm bg-white btn-color-white bg-opacity-20">
										<i class="ki-duotone ki-calendar-tick"> <span
											class="path1"></span> <span class="path2"></span> <span
											class="path3"></span> <span class="path4"></span> <span
											class="path5"></span> <span class="path6"></span>
										</i>
									</button>
								</div>
								<!--end::Title-->
							</div>
							<!--end::Header-->
							<!--begin::Card body-->
							<div class="card-body d-flex h-auto">
								<div class="col-lg-12">
									<!--begin::Tab Content (ishlamayabdi)-->
									<div class="tab-content mb-2 px-9">
										<!--begin::Tap pane-->
										<div class="tab-pane fade show active"
											id="kt_timeline_widget_3_tab_content_4">
											<div class="row">
											<div class="col-md-6">
											<!--begin::Wrapper-->
											<div class="d-flex align-items-center mb-6">
												<!--begin::Bullet-->
												<span data-kt-element="bullet"
													class="bullet bullet-vertical d-flex align-items-center min-h-70px mh-100 me-4 bg-success"></span>
												<!--end::Bullet-->
												<!--begin::Info-->
												<div class="flex-grow-1 me-5">
													<!--begin::Date Time-->
													<div class="text-white fw-semibold fs-2">
														<fmt:formatDate
															value="${lastcheckin[0].work_hours_time_work}"
															pattern="HH:mm" />
													</div>
													<div class="text-white fw-semibold fs-6">
														<fmt:formatDate
															value="${lastcheckin[0].work_hours_time_work}"
															pattern="dd MMM yyyy" />
													</div>
													<!--end::Date Time-->
												</div>
												<!--end::Info-->
											</div>
											<!--end::Wrapper-->
											</div>
											
											<div class="col-md-6">
											<!--begin::Wrapper-->
											<div class="d-flex align-items-center mb-6">
												<!--begin::Bullet-->
												<span data-kt-element="bullet"
													class="bullet bullet-vertical d-flex align-items-center min-h-70px mh-100 me-4 bg-info"></span>
												<!--end::Bullet-->
												<!--begin::Info-->
												<div class="flex-grow-1 me-5">
													<!--begin::Time-->
													<div class="text-white fw-semibold fs-2">
														<fmt:formatDate
															value="${lastcheckout[0].work_hours_time_work}"
															pattern="HH:mm" />
													</div>
													<!--end::Time-->
													<!--begin::Description-->
													<div class="text-white fw-semibold fs-6">
														<fmt:formatDate
															value="${lastcheckout[0].work_hours_time_work}"
															pattern="dd MMM yyyy" />
													</div>
													<!--end::Description-->
												</div>
												<!--end::Info-->
											</div>
											<!--end::Wrapper-->
											</div>
											</div>
										</div>
										<!--end::Tap pane-->
									</div>
									<!--end::Tab Content-->
								</div>
							</div>
							<!--end::Card body-->
						</div>
						<!--end::Card widget 16-->
						<!--begin::Card widget 7-->
						<div class="card card-flush h-md-50 mb-5 mb-xl-10">
							<!--begin::Header-->
							<div class="card-header pt-5">
								<!--begin::Title-->
								<div class="card-title col-lg-12 d-flex flex-column">

									<span class="fs-2hx fw-bold text-gray-900 me-2 lh-1 ls-n2">Work
										Hours</span>
									<!--begin::Sub Title-->
									<div>
										<span class="text-white fw-semibold fs-7 bg-primary p-1">In-House</span>
										<span class="text-gray-700 pt-1 fw-semibold fs-7">9:00
											- 18:00</span>
									</div>
									<!--end::Sub Title-->

								</div>
								<!--end::Title-->
							</div>
							<!--end::Header-->

							<!--begin::Card body-->
							<div class="card-body d-flex flex-column">
								<div class="d-flex flex-center">
									<span id="clock"
										class="fs-4x fw-bold text-gray-900 text-center"></span> 
										<span id="clock-second"
										class="fs-3x fw-bold text-gray-500 text-center"></span>
								</div>
								<div id="date"
									class="fs-2x fw-semibold text-gray-800 text-center"></div>
								<div class="d-flex flex-center align-items-center ">
									<div class="col-lg-5 align-items-center">
										<div class="rounded p-5 ">
											<button id="checkin_btn" name="checkBtn"
												class="check-btn btn btn-lg btn-light" data-value="1">
												<i class="ki-duotone ki-time"> <span class="path1"></span>
													<span class="path2"></span>
												</i>
												<div class="fs-6">Check-In</div>
											</button>
										</div>
									</div>
									<div class="col-lg-5">
										<div class="rounded p-5">
											<button id="checkout_btn" name="checkBtn"
												class="check-btn btn btn-lg btn-light" data-value="2">
												<i class="ki-duotone ki-time"> <span class="path1"></span>
													<span class="path2"></span>
												</i>
												<div class="fs-6">Check-Out</div>
											</button>
										</div>
									</div>
								</div>
								<div class="d-flex flex-column mb-4">
									<span class="fs-3 fw-semibold text-muted">Work Your
										Location</span>
								</div>
								<div class="d-flex">
									<div class="py-2 px-4 me-6 mb-3">
										<div
											class="form-check form-check-custom form-check-primary form-check-solid form-check-md">
											<input name="workType" class="form-check-input" type="radio" value="2"
												<c:if test="${user.workType == 2}">checked</c:if>> 
											<label for="checkin_btn" class="form-check-label fs-6">WFH</label>
										</div>
									</div>
									<div class="py-2 px-4 me-6 mb-3">
										<div
											class="form-check form-check-custom form-check-primary form-check-solid form-check-md">
											<input name="workType" class="form-check-input" type="radio" value="1"
												<c:if test="${user.workType == 1}">checked</c:if>> 
											<i class="ki-duotone ki-map "> 
												<span class="path1"></span> 
												<span class="path2"></span> 
												<span class="path3"></span>
											</i>
											<label for="checkout_btn" class="form-check-label fs-6">On-Site</label>
										</div>
									</div>
								</div>
								<div class="d-flex">
									<button id="submitBtn"
										class="btn btn-primary w-100 text-center">Accept</button>
								</div>
							</div>
							<!--end::Card body-->
						</div>
						<!--end::Card widget 7-->
					</div>
					<!--end::Col-->
					<!--begin::Col-->
					<div class="col-md-4 col-lg-4 col-xl-4 col-xxl-4 mb-10">
						<!--begin::Card widget 17-->
						<div class="card card-flush h-md-50 mb-5 mb-xl-10">
							<!--begin::Header-->
							<div class="card-header pt-5">
								<!--begin::Title-->
								<div class="card-title d-flex flex-column">
									<!--begin::Info-->
									<div class="d-flex align-items-center">
										<!--begin::Amount-->
										<span class="fs-2 fw-bold text-gray-900 me-2 lh-1 ls-n2">Holiday</span>
										<!--end::Amount-->
									</div>
									<!--end::Info-->
								</div>
								<!--end::Title-->
							</div>
							<!--end::Header-->
							<!--begin::Card body-->
							<c:if test="${holidayList != null}">
								<div
									class="card-body pt-2 pb-4 d-flex flex-wrap align-items-center">
									<c:forEach var="hld" items="${holidayList}">
									<!--begin::Tab Content (ishlamayabdi)-->
									<div class="tab-content mb-2 px-9">
										<!--begin::Tap pane-->
										<div class="tab-pane fade show active"
											id="kt_timeline_widget_3_tab_content_4">
											<!--begin::Wrapper-->
											<div class="d-flex align-items-center mb-6">
												<!--begin::Bullet-->
												<fmt:formatDate value="${hld.start_date}" pattern="u" var="day"/>
												<span data-kt-element="bullet"
													class="dayofWeek bullet bullet-vertical d-flex align-items-center min-h-70px mh-100 me-4
													<c:if test="${day == '1'}"> bs-indigo</c:if>
													<c:if test="${day == '3'}"> bs-pink</c:if>
													<c:if test="${day == '3'}"> bs-success</c:if>
													<c:if test="${day == '4'}"> bg-warning</c:if>
													<c:if test="${day == '5'}"> bg-primary</c:if>"></span>
												<!--end::Bullet-->
												<!--begin::Info-->
												<div class="flex-grow-1 me-5">
													<div class="text-grey fw-semibold fs-2">${hld.head}</div>
													
													<div class="text-grey fw-semibold fs-6">														
														<c:if test="${day == '1'}">Mon, </c:if>
														<c:if test="${day == '2'}">Tue, </c:if>
														<c:if test="${day == '3'}">Wed, </c:if>
														<c:if test="${day == '4'}">Thu, </c:if>
														<c:if test="${day == '5'}">Fri, </c:if>
														<fmt:formatDate value="${hld.start_date}" pattern="dd MMM"/>
													</div>
												</div>
												<!--end::Info-->
											</div>
											<!--end::Wrapper-->
										</div>
										<!--end::Tap pane-->
									</div>
									<!--end::Tab Content-->
									</c:forEach>
								</div>
							</c:if>
							<c:if test="${holidayList == null}">
								<div class="card-body pt-2 pb-4 d-flex flex-wrap">
									<!--begin::Tab Content (ishlamayabdi)-->
									<div class="tab-content mb-2 px-9">
										<!--begin::Tap pane-->
										<div class="tab-pane fade show active"
											id="kt_timeline_widget_3_tab_content_4">
											<!--begin::Wrapper-->
											<div class="d-flex mb-6">
												<div class="flex-grow-1 me-5">
													<div class="text-grey-500 fw-semibold fs-6">No
														holiday in this month.</div>
												</div>
											</div>
											<!--end::Wrapper-->
										</div>
										<!--end::Tap pane-->
									</div>
									<!--end::Tab Content-->
								</div>
							</c:if>
							<!--end::Card body-->
						</div>
						<!--end::Card widget 17-->
						<!--begin::List widget 25-->
						<div class="card card-flush h-lg-50">
							<!--begin::Header-->
							<div class="card-header pt-5">
								<!--begin::Title-->
								<h3 class="card-title text-gray-800">Your Location</h3>
								<!--end::Title-->
							</div>
							<!--end::Header-->
							<!--begin::Body-->
							<div class="card-body pt-5">
								<!--begin::Item-->
								<div class="d-flex flex-stack">
									<div id="map">
									</div>
									<input type="hidden" id="x" class="latitude" name="latitude">
									<input type="hidden" id="y" class="longitude" name="longitude">
								</div>
								<!--end::Item-->
							</div>
							<!--end::Body-->
						</div>
						<!--end::LIst widget 25-->
					</div>
					<!--end::Col-->
				</div>
				<!--end::Row-->
			</div>
			<!--end::Content container-->
		</div>
	</div>
	<!--end::Content wrapper-->

</div>
<!--end:::Main-->

<script>
$(document).ready(function() {
	setInterval(updateClock, 1000);
	updateClock();	
/* Google Map */
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
		// Try HTML5 geolocation.
		if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(function(position) {
				var pos = {
					lat : position.coords.latitude,
					lng : position.coords.longitude
				};
				x = pos.lat;
				y = pos.lng;

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
							/*for( var i = 0; i < resultArray.length; i++ ) {
								if ( resultArray[ i ].types[0]  ) {
									citi = resultArray[ i ].long_name;
									console.log( citi );
									city.value = citi;
								}
							}*/
							latEl.value = lati;
							longEl.value = lngti;
						} else {
							console.log('Geocode was not successful for the following reason: ' + status);
						}
						if (infoWindow) {
							infoWindow.close();
						}
						/**
						* Creates the info Window at the top of the marker
						*/
							
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
});

 function updateClock() {
	fetch("https://timeapi.io/api/Time/current/zone?timeZone=Asia/Bangkok")
		.then(resp => resp.json())
	    .then(data => {
	    	// ดึงค่าจาก API
	        let dateTimeStr = data.dateTime; // "2025-09-09T09:09:09"
	        let dt = new Date(dateTimeStr);
	        
	     // เวลา: HH:mm:ss
	        let hours = dt.getHours().toString().padStart(2, '0');
	        let minutes = dt.getMinutes().toString().padStart(2, '0');
	        let seconds = dt.getSeconds().toString().padStart(2, '0');
	        let time = hours+":"+minutes
	    	$("#clock").text(time); // หรือ format เอา
	    	$("#clock-second").text(":"+seconds);
	    	//$("#clock").text(dateTimeStr);
	    	
	     // วันที่: dd MMM yyyy
	        let options = { day: '2-digit', month: 'short', year: 'numeric' };
	        let dateStr = dt.toLocaleDateString('en-GB', options).replace(/,/g, '');
	        $("#date").text(dateStr);
	    })
	    .catch(err => console.error("error:", err));
}
 
let selectedCheckType = null;
$(".check-btn").on("click", function () {
	$(".check-btn").removeClass("btn-success btn-info");
	let value = $(this).data("value");
	if (value === 1 || value === "1") {
		$(this).addClass("btn-success");
	} else if (value === 2 || value === "2") {
		$(this).addClass("btn-info"); 
	}
    console.log("เลือกค่า:", value);
    selectedCheckType = value;
});

 
$("#submitBtn").click(function() {
	let userId = "${logonUser}";
	let workType = $("input[name='workType']:checked").val();
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
		"timeOut": "5000",
		"extendedTimeOut": "1000",
		"showEasing": "swing",
		"hideEasing": "linear",
		"showMethod": "fadeIn",
		"hideMethod": "fadeOut"
	};
	if (!workType) {
		e.preventDefault();
		toastr.error("Please select your work location (WFH or On-Site).");
        return;
	}
	$.ajax({
		url: "saveCheckInOut",
		type: "POST",
		dataType: "json",
		data: {
			"userId" : userId,
			"checkType" : selectedCheckType,
			"workType" : workType
		},
		success: function(res){
			let type = res.type === "1" ? "Check-in" : "Check-out";
			if (res.status === "success") {
				toastr.success(type + " : "+res.time, "Success");
			} else {
	            toastr.error(res.message || "Failed to record your attendance. Please try again.");
			}
		},error: function() {
	        console.error("AJAX Error:", status, err, xhr.responseText);
	        toastr.error("An unexpected error occurred.");
		}
 	});
});

</script>