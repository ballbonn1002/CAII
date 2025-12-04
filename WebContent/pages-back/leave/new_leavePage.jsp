<%@page import="org.apache.velocity.runtime.directive.Foreach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/permission.tld" prefix="perm"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<!DOCTYPE html>
<html>
<c:set var="now" value="<%=new java.util.Date()%>" />
<fmt:formatDate type="date" value="${now}" pattern="dd-MM-yyyy" var="date_now" />
<fmt:formatDate type="date" value="${now}" pattern="dd-MM-yyyy" var="lastday" />
<head>
<meta charset="utf-8">
<title><tiles:insertAttribute name="title" ignore="true" /></title>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

<!--begin::Fonts(mandatory for all pages)-->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Inter:300,400,500,600,700" />
<!--end::Fonts-->
<!--begin::Vendor Stylesheets(used for this page only)-->

<!-- Keenicons (ใช้กับ .ki-*) -->
<!-- <link rel="stylesheet" href="assets/vendors/keenicons/styles.bundle.css" /> -->
<!-- Keenicons (ใช้กับ .ki-*) -->

<link href="assets/plugins/custom/fullcalendar/fullcalendar.bundle.css" rel="stylesheet" type="text/css" />
<link href="assets/plugins/custom/datatables/datatables.bundle.css" rel="stylesheet" type="text/css" />
<!--end::Vendor Stylesheets-->

<!--begin::Global Stylesheets Bundle(mandatory for all pages)-->
<link href="assets/plugins/global/plugins.bundle.css" rel="stylesheet" type="text/css" />
<link href="assets/css/style.bundle.css" rel="stylesheet" type="text/css" />

<!-- ===== [ใหม่] Metronic Tailwind CSS ===== -->
<!-- <link rel="stylesheet" href="assets/vendors/apexcharts/apexcharts.css" /> -->
<!-- <link rel="stylesheet" href="assets/css/styles.css" /> --><!-- Tailwind build -->
<!-- ===== [ใหม่] Metronic Tailwind CSS ===== -->

<!--end::Global Stylesheets Bundle-->
<!--begin::Javascript-->
<script>var hostUrl = "assets/";</script>
<!--begin::Global Javascript Bundle(mandatory for all pages)-->
<script src="assets/plugins/global/plugins.bundle.js"></script>
<script src="assets/js/scripts.bundle.js"></script>
<!--end::Global Javascript Bundle-->
<!--begin::Vendors Javascript(used for this page only)-->
<!-- <script src="assets/plugins/custom/fullcalendar/fullcalendar.bundle.js"></script> -->
<script src="https://cdn.amcharts.com/lib/5/index.js"></script>
<script src="https://cdn.amcharts.com/lib/5/xy.js"></script>
<script src="https://cdn.amcharts.com/lib/5/percent.js"></script>
<script src="https://cdn.amcharts.com/lib/5/radar.js"></script>
<script src="https://cdn.amcharts.com/lib/5/themes/Animated.js"></script>
<script src="https://cdn.amcharts.com/lib/5/map.js"></script>
<script src="https://cdn.amcharts.com/lib/5/geodata/worldLow.js"></script>
<script src="https://cdn.amcharts.com/lib/5/geodata/continentsLow.js"></script>
<script src="https://cdn.amcharts.com/lib/5/geodata/usaLow.js"></script>
<script src="https://cdn.amcharts.com/lib/5/geodata/worldTimeZonesLow.js"></script>
<script src="https://cdn.amcharts.com/lib/5/geodata/worldTimeZoneAreasLow.js"></script>
<script src="assets/plugins/custom/datatables/datatables.bundle.js"></script>
<!--end::Vendors Javascript-->
<!--begin::Custom Javascript(used for this page only)-->
<script src="assets/js/widgets.bundle.js"></script>
<script src="assets/js/custom/widgets.js"></script>
<script src="assets/js/custom/apps/chat/chat.js"></script>
<script src="assets/js/custom/utilities/modals/upgrade-plan.js"></script>
<script src="assets/js/custom/utilities/modals/create-app.js"></script>
<script src="assets/js/custom/utilities/modals/new-target.js"></script>
<script src="assets/js/custom/utilities/modals/users-search.js"></script>
<!--end::Custom Javascript-->
<!--end::Javascript-->

</head>
<body class="app-default">

	<%
		//comment for fix ClassCastException
		//var action = '${action}'; can still be used
		//String action = (String) request.getAttribute("action");
	%>


	<!--begin::Theme mode setup on page load-->
	<script>
		var defaultThemeMode = "light"; 
		var themeMode; 
		if ( document.documentElement ) {
			if ( document.documentElement.hasAttribute("data-bs-theme-mode")) { 
				themeMode = document.documentElement.getAttribute("data-bs-theme-mode"); 
			} else { 
				if ( localStorage.getItem("data-bs-theme") !== null ) { 
					themeMode = localStorage.getItem("data-bs-theme"); 
				} else { 
					themeMode = defaultThemeMode; 
				} 
			} 
			if (themeMode === "system") { 
				themeMode = window.matchMedia("(prefers-color-scheme: dark)").matches ? "dark" : "light"; 
			} 
			document.documentElement.setAttribute("data-bs-theme", themeMode); 
		}
</script>
	<!--end::Theme mode setup on page load-->


	<!--begin::Main-->
	<div class="app-main flex-column flex-row-fluid">

		<!--begin::Content wrapper-->
		<div class="d-flex flex-column flex-column-fluid">

			<!--begin::Toolbar-->
			<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
				<!--begin::Toolbar container-->
				<div id="kt_app_toolbar_container" class="app-container container-fluid d-flex flex-stack">
					<!--begin::Page title-->
					<div class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
						<!--begin::Title-->
						<h1 class="page-heading d-flex text-gray-900 fw-bold fs-3 flex-column justify-content-center my-0">Create a leave form</h1>
						<!--end::Title-->
						<!--begin::Breadcrumb-->
						<ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
							<li class="breadcrumb-item text-muted"><a href="demo_dashboard" class="text-muted text-hover-primary">Home</a></li>
						</ul>
						<!--end::Breadcrumb-->
					</div>
					<!--end::Page title-->
				</div>
				<!--end::Toolbar container-->
			</div>
			<!--end::Toolbar-->
			
			<div id="kt_app_content" class="app-content flex-column-fluid">
				<div id="kt_app_content_container" class="app-container container-fluid">
				
				<!-- Summary Leave -->
					<div class="d-flex flex-row">
						<div class="flex-row-fluid mb-5">
							<div class="card card-flush bgi-no-repeat bgi-size-contain bgi-position-x-center border-0 mb-5 mb-xl-10">
								<div class="card-body">
									<div class="row g-5">
	
										<!-- ลาพักร้อน -->
										<div class="col-6 col-md-4 col-xl-3">
											<div class="d-flex align-items-center">
												<div class="symbol symbol-50px me-4">
													<span class="symbol-label bg-light-success">
														<i class="ki-duotone ki-airplane fs-2x text-success">
															<span class="path1"></span>
															<span class="path2"></span>
														</i>
													</span>
												</div>
												<div class="d-flex flex-column">
													<span class="fs-2 fw-bold text-dark">
														<fmt:formatNumber type="number" pattern="#.##" value="${leave_1}"/>/<fmt:formatNumber type="number" pattern="#.##" value="${quota_1-3}"/>
													</span>
													<span class="text-muted fs-5">
													${type_1}
													</span>
												</div>
											</div>
										</div>
	
										<!-- ลากิจ -->
										<div class="col-6 col-md-4 col-xl-3">
											<div class="d-flex align-items-center">
												<div class="symbol symbol-50px me-4">
													<span class="symbol-label bg-light-primary">
														<i class="ki-duotone ki-car-2 fs-2x text-primary">
															<span class="path1"></span>
															<span class="path2"></span>
															<span class="path3"></span>
															<span class="path4"></span>
															<span class="path5"></span>
															<span class="path6"></span>
														</i>
													</span>
												</div>
												<div class="d-flex flex-column">
													<span class="fs-2 fw-bold text-dark">
														<fmt:formatNumber type="number" pattern="#.##" value="${leave_2}"/>/<fmt:formatNumber type="number" pattern="#.##" value="3"/><!-- fix hard code 3 day -->
													</span>
													<span class="text-muted fs-5">
													${type_2}
													</span>
												</div>
											</div>
										</div>
	
										<!-- ลาพักร้อนที่เหลือ -->
										<div class="col-6 col-md-4 col-xl-3">
											<div class="d-flex align-items-center">
												<div class="symbol symbol-50px me-4">
													<span class="symbol-label bg-light-warning">
														<i class="ki-duotone ki-timer fs-2x text-warning">
														 <span class="path1"></span>
														 <span class="path2"></span>
														 <span class="path3"></span>
														</i>
													</span>
												</div>
												<div class="d-flex flex-column">
													<span class="fs-2 fw-bold text-dark">
														<fmt:formatNumber type="number" pattern="#.##" value="${leave_6}"/>
														<c:if test="${quota_4 != null || quota_4 != 0.0 || quota_4 != ''} ">
															/<fmt:formatNumber type="number" pattern="#" value="${quota_4}"/>
														</c:if>
													</span>
													<span class="text-muted fs-5">
													${type_6}
													</span>
												</div>
											</div>
										</div>
	
										<!-- ลาป่วย -->
										<div class="col-6 col-md-4 col-xl-3">
											<div class="d-flex align-items-center">
												<div class="symbol symbol-50px me-4">
													<span class="symbol-label bg-light-info">
														<i class="ki-duotone ki-pulse fs-2x text-info">
															<span class="path1"></span>
															<span class="path2"></span>
														</i>
													</span>
												</div>
												<div class="d-flex flex-column">
													<span class="fs-2 fw-bold text-dark">
														<fmt:formatNumber type="number" pattern="#.##" value="${leave_3}"/>
														<c:if test="${quota_3 != null || quota_3 != 0.0 || quota_3 != ''} ">
															/<fmt:formatNumber type="number" pattern="#" value="${quota_3}"/>
														</c:if>
													</span>
													<span class="text-muted fs-5">
													${type_3}
													</span>
												</div>
											</div>
										</div>
	
										<!-- ขาดงาน -->
										<div class="col-6 col-md-4 col-xl-3">
											<div class="d-flex align-items-center">
												<div class="symbol symbol-50px me-4">
													<span class="symbol-label bg-light-danger">
														<i class="ki-duotone ki-calendar-remove fs-2x text-danger">
															<span class="path1"></span>
															<span class="path2"></span>
															<span class="path3"></span>
															<span class="path4"></span>
															<span class="path5"></span>
															<span class="path6"></span>
														</i>
													</span>
												</div>
												<div class="d-flex flex-column">
													<span class="fs-2 fw-bold text-dark">
														<fmt:formatNumber type="number" pattern="#.##" value="${leave_4}"/>
													</span>
													<span class="text-muted fs-5">
														${type_4}
													</span>
												</div>
											</div>
										</div>
	
										<!-- ลาโดยไม่รับค่าจ้าง -->
										<div class="col-6 col-md-4 col-xl-3">
											<div class="d-flex align-items-center">
												<div class="symbol symbol-50px me-4">
													<span class="symbol-label bg-light-dark">
														<i class="ki-duotone ki-brifecase-cros fs-2x text-dark">
															<span class="path1"></span>
															<span class="path2"></span>
															<span class="path3"></span>
														</i>
													</span>
												</div>
												<div class="d-flex flex-column">
													<span class="fs-2 fw-bold text-dark">
														<fmt:formatNumber type="number" pattern="#.##" value="${leave_5}"/>
													</span>
													<span class="text-muted fs-5">
														${type_5}
													</span>
												</div>
											</div>
										</div>
	
										<!-- ลาอื่น ๆ -->
										<div class="col-6 col-md-4 col-xl-3">
											<div class="d-flex align-items-center">
												<div class="symbol symbol-50px me-4">
													<span class="symbol-label" style="background-color: #4B5675;">
														<i class="ki-duotone ki-abstract-12 fs-2x" style="color: #FFFFFF;">
															<span class="path1"></span>
															<span class="path2"></span>
														</i>
													</span>
												</div>
												<div class="d-flex flex-column">
													<span class="fs-2 fw-bold text-dark">
														<fmt:formatNumber type="number" pattern="#.##" value="${leave_7}"/>
													</span>
													<span class="text-muted fs-5">
													${type_7}
													</span>
												</div>
											</div>
										</div>
	
									</div>
								</div>
							</div>
						</div>
					</div>
				<!-- Summary Leave -->
				
				</div>
			</div>				

			<!--begin::Content-->
			<div id="kt_app_content" class="app-content flex-column-fluid">

				<!--begin::Content container-->
				<div id="kt_app_content_container" class="app-container container-fluid">

					<!-- DDL -->
					<div class="d-flex flex-row">
						<div class="flex-row-fluid mb-5">
							<div class="card card-flush bgi-no-repeat bgi-size-contain bgi-position-x-center border-0 mb-5 mb-xl-10">
								<div class="card-body">

									<form method="post" id="formid" class="form-horizontal" action="new_LeaveEdit_Do" enctype="multipart/form-data">

										<!--Header -->
										<div class="d-flex justify-content-between align-items-center mb-6">
											<!-- ด้านซ้าย -->
											<div>
												<h3 class="fw-bold text-gray-800 mb-1 fs-4">Leave form</h3>
											</div>

											<!-- ด้านขวา -->
											<div class="d-flex justify-content-end">
												<select class="form-select" id="status" name="status" disabled required style="min-width: 200px; max-width: 300px;">
													<option value="0">Wait for approve</option>
													<option value="1">Approved</option>
													<option value="2">Reject</option>
													<option value="3">Cancel</option>
												</select>
												<input type="hidden" name="status_hidden" id="status_hidden">
											</div>
										</div>

										<div class="mb-10">
											<select id="user" name="user" class="form-select" onchange="userOnChange()" disabled required>
												<option></option>
												<optgroup id='u_enable' label="Enable"></optgroup>
												<optgroup id='u_disable' label="Disable"></optgroup>
											</select>
											<input hidden name="user_hidden" id="user_hidden" type="text">
											<input hidden name="leaveId_hidden" id="leaveId_hidden" type="text">
										</div>

										<div class="mb-8">
											<label class="form-label fw-semibold fs-5">Type of leave</label>
											<div id="leaveTypes" class="row g-6 fs-4">
												<!-- Loop Leave Type Javascript -->
											</div>
										</div>

										<!--Type of leave -->
										<div class="mb-6">
											<div class="row g-6">

												<!--Date range & half-day -->
												<div class="row mb-8">

													<!-- Date Range -->
													<div class="row mb-8">

														<div class="col-md-6">

															<div class="row mb-6 align-items-end">
																<!-- Start Date -->
																<div class="col-md-6">
																	<label class="form-label fw-semibold fs-5">Start Date <span class="text-danger">*</span></label>
																	<div class="input-group date date-picker input-daterange" data-provide="datepicker" data-date-format="dd M yyyy">
																		<input type="text" class="form-control" id="date_from" name="from" autocomplete="off" required>
																		<input class="hide" name="from_hidden" id="date_from_hidden" type="text" hidden>
																	</div>
																</div>

																<!-- End Date -->
																<div class="col-md-6">
																	<label class="form-label fw-semibold fs-5">End Date <span class="text-danger">*</span></label>
																	<div class="input-group date date-picker input-daterange" data-provide="datepicker" data-date-format="dd M yyyy">
																		<input type="text" class="form-control" id="date_to" name="to" autocomplete="off" required>
																		<input class="hide" name="to_hidden" id="date_to_hidden" type="text" hidden>
																	</div>
																</div>
															</div>

														</div>

														<div class="col-md-6">
															<label class="form-label required fs-5">ช่วงเวลาในการลา</label>
															<select class="form-select input-daterange"
																id="halfDay" name="halfDay" required>
																<option value="0" selected>เต็มวัน</option>
																<option value="1">ช่วงเช้า</option>
																<option value="2">ช่วงบ่าย</option>
																<option value="3">เลือกช่วงเวลา</option>
															</select>
														</div>

													</div>

												</div>

												<div class="row mb-8">
													<!-- Start Time -->
													<div class="col-md-6">
														<label class="form-label fw-semibold fs-5">Start Time <span class="text-danger">*</span></label>
														<div class="input-group">
															<input type="text" class="form-control timepicker timepicker-24 checkHours" id="time_from" name="time_from" autocomplete="off" required disabled>
														</div>
														<input class="hide" id="time_from_hidden" name="time_from_hidden" hidden>
													</div>

													<!-- End Time -->
													<div class="col-md-6">
														<label class="form-label fw-semibold fs-5">End Time <span class="text-danger">*</span></label>
														<div class="input-group">
															<input type="text" class="form-control timepicker timepicker-24 checkHours" id="time_to" name="time_to" autocomplete="off" required disabled>
														</div>
														<input class="hide" id="time_to_hidden" name="time_to_hidden" hidden>
														<div class="form-text text-danger" id="alert_time_to"></div>
													</div>
												</div>

												<div class="row mb-8">
													<!-- Start Time -->
													<div class="col-md-6">
														<label class="form-label fw-semibold fs-5">Day</label>
														<div class="input-group">
															<input type="text" class="form-control timepicker timepicker-24 checkHours" id="amount" name="amount" min="1" max="1000" maxlength="3" disabled>
														</div>
														<input class="hide" id="amount_hidden" name="amount_hidden" hidden>
													</div>

													<!-- End Time -->
													<div class="col-md-6">
														<label class="form-label fw-semibold fs-5">Hours</label>
														<div class="input-group">
															<input type="text" class="form-control timepicker timepicker-24 checkHours" id="amount_sub" name="amount_sub" value="0" min="1" max="1000" maxlength="3" onchange="check()" disabled>
														</div>
														<input class="hide" value="0" id="amount_sub_hidden" name="amount_sub_hidden" hidden>
													</div>
												</div>

												<!--Description -->
												<div class="mb-8">
													<label class="form-label required fs-5">Description</label>

													<textarea
														class="form-control"
														style="word-break: break-all; white-space: normal;" maxlength="1024"
														name="description"
														id="description"
														rows="3" placeholder="Enter a reason."
														required></textarea>

													<input hidden class="hide" name="description_hidden" id="description_hidden" type="text">

													<div class="text-danger mt-2">กรุณาระบุเหตุผลในการลา ตัวอย่าง ลางานเนื่องจากท้องเสีย</div>
												</div>

												<!--File Upload -->
												<%-- <div class="mb-8">
													<label class="form-label fs-5">Attach files</label>
													<div class="d-flex flex-column">

														<!-- ปุ่มแนว Metronic แต่ยังใช้ ID/NAME เดิม -->
														<label for="myFile" id="lbFile" class="btn btn-primary w-150px mb-2 d-inline-flex align-items-center justify-content-center gap-2" style="height: 40px;">
															Attach files
															<input type="file" id="myFile" name="fileUpload" style="display:none;" accept="image/*, application/zip" onchange="showFileName(this)">
														</label>

														<!-- Hidden inputs ตามต้นฉบับ -->
														<input type="hidden" name="fileUploadSize" value="${size}" id="size">
														<input type="hidden" name="fileUploadId" id="fileUploadId">

														<!-- ข้อความเตือน -->
														<div class="text-danger mb-2">
															กรุณาอัปโหลดเฉพาะไฟล์ชื่อภาษาอังกฤษเท่านั้น
														</div>

														<a target="_blank" id="linkImage" class="mt-3 border border-gray-300 rounded px-4 py-3 bg-light text-gray-700">
															ยังไม่ได้เลือกไฟล์
														</a>

														<!-- ภาพ preview -->
														<!-- <img id="frame" src="" style="max-width: 150px; display: none; margin-top: 10px;" /> -->

													</div>
												</div> --%>
												
												<!--File Upload -->
												<div class="mb-8">
												    <label class="form-label fs-5">Attach files</label>
												    <div class="d-flex flex-column">
												        <label for="myFile" id="lbFile" class="btn btn-primary w-150px mb-2 d-inline-flex align-items-center justify-content-center gap-2" style="height: 40px;">
												            Attach files
												            <input type="file" id="myFile" name="fileUpload" style="display:none;" accept="image/*, application/zip"> 
												        </label>
												
												        <input type="hidden" name="deleteFileId" id="deleteFileId">
												        <input type="hidden" name="fileUploadSize" value="${size}" id="size">
												        <input type="hidden" name="fileUploadId" id="fileUploadId">
												
												        <div id="filePreviewContainer" class="mt-2" style="max-width: 400px;"></div>
												    </div>
												</div>

												<!--Approver -->
												<div class="mb-10">
													<label class="form-label required fs-5">Approvers</label>
													<select id="approver" name="approver" class="form-select" required>
														<option value="admin">แอดมิน</option>
													</select>
													<input hidden name="approver_hidden" id="approver_hidden" type="text">
												</div>

												<!--Buttons -->
												<div class="d-flex justify-content-end gap-3">
													<button type="button" class="btn btn-light" onclick="window.history.go(-1); return false;">Cancel</button>
													<button type="button" class="btn btn-success" onclick="beforeSubmit();">Submit</button>
												</div>

											</div>
										</div>

									</form>

								</div>
							</div>
						</div>
					</div>
					<!-- DDL -->

				</div>
				<!--end::Content container-->

			</div>
			<!--end::Content-->

		</div>
		<!--end::Content wrapper-->

	</div>
	<!--end:::Main-->





</body>

<script>
	//var action = '${action}';
	var action = '${empty action ? "" : action}';
	console.log("action = " + action);
	$( document ).ready(function() {
		$('#halfDay').on('change', function() {
			  if(this.value == 3){
				  document.getElementById('time_from').disabled = false;
				  document.getElementById('time_to').disabled = false;
				  document.getElementById('date_to').disabled = true;
				  if(action == 'Add'){
					  document.getElementById('time_from').value = "9:00";
					  document.getElementById('time_to').value = "";
				  }
				  $('#amount').val(0);
				  $('#amount_sub').val(0);
				  $('#amount_hidden').val(0);
				  $('#amount_sub_hidden').val(0);
			  } else if(this.value == 0){
				  document.getElementById('time_from').disabled = true;
				  document.getElementById('time_to').disabled = true;
				  document.getElementById('date_to').disabled = false;
				  document.getElementById('time_from').value = "9:00";
				  document.getElementById('time_to').value = "18:00";
				  $('#amount_sub').val(0);
				  $('#amount_sub_hidden').val(0);
				  $('#alert_time_to').text('')
			  } else if(this.value == 1){
				  document.getElementById('time_from').disabled = true;
				  document.getElementById('time_to').disabled = true;
				  document.getElementById('date_to').disabled = true;
				  document.getElementById('time_from').value = "8:00";
				  document.getElementById('time_to').value = "12:00";
				  $('#amount_sub').val(4);
				  $('#amount_sub_hidden').val(4);
				  $('#alert_time_to').text('')
			  } else if(this.value == 2){
				  document.getElementById('time_from').disabled = true;
				  document.getElementById('time_to').disabled = true;
				  document.getElementById('date_to').disabled = true;
				  document.getElementById('time_from').value = "13:00";
				  document.getElementById('time_to').value = "17:00";
				  $('#amount_sub').val(4);
				  $('#amount_sub_hidden').val(4);
				  $('#alert_time_to').text('')
			  }
		});
		
		$('#myFile').on("change", function(){
		    const file = this.files[0];
		    const fileName = this.files[0].name;
		    
		    // ตรวจสอบอักขระที่ Windows ไม่อนุญาต
		    const forbiddenChars = /[\/:*?"<>|]/;

		    // หากพบอักขระที่ห้ามแสดง alert
		    if(forbiddenChars.test(fileName)) {
		        alert("File name contains invalid characters for Windows");
		        $(this).val('');  // รีเซ็ตไฟล์
		        $('#linkImage').text('');
		        $('#size').val('');
		        return;
		    }

		    $('#linkImage').text(fileName);

		    var fSExt = new Array('Bytes', 'KB', 'MB', 'GB');
		    fSize = this.files[0].size;
		    i = 0;
		    while (fSize > 900) {
		        fSize /= 1024;
		        i++;
		    }
		    var size_n = (Math.round(fSize * 100) / 100);
		    var size = size_n + ' ' + fSExt[i];
		    console.log(size)
		    $('#size').val(size);
		});
		
		
	});
</script>

<script>
	var toISODate = (date) => {
		return date.substring(3,6)+"-"+date.substring(0,2)+"-"+date.substring(7,11);
	}
	var toISODate2 = (date) => {
		return date.substring(3,5)+"-"+date.substring(0,2)+"-"+date.substring(6,10);
	}
	var toTimestamp = (date) => {
		return Date.parse(toISODate(date));
	}
	var toTimestamp2 = (date) => {
		return Date.parse(toISODate2(date));
	}
	var toDisplayDate = (date) => {
		return date.toLocaleDateString('en-GB').replace('/','-').replace("/",'-');
	}
</script>

<!-- Start leaveType Radio -->
<c:if test="${leaveType != null}">
	<script>
		$(function(){
			var leaveTypes;
			leaveTypes = JSON.parse('${leaveType}');
			let leaveCheck = [${leave1Check},${leave2Check},${leave3Check},'','',${leave6Check}];
			console.log(leaveCheck);
			for(let i=0; i<leaveTypes.length; i++){
				if(leaveTypes[i].id == '1' || leaveTypes[i].id == '2' || leaveTypes[i].id == '3' || leaveTypes[i].id == '6'){
					if(leaveTypes[i].id == '6'){
						const d = new Date();
						let month = d.getMonth();
						if(month <= 2){
							if(leaveCheck[i] == '1'){
								let radio =	'<div class="col-12 col-sm-6 col-md-3"><div class="form-check form-check-custom form-check-solid mb-3">'
									+'<input class="form-check-input me-3" type="radio" name="leaveType" id="lt_'+leaveTypes[i].id+'" value="'+leaveTypes[i].id+'" disabled required>'+leaveTypes[i].name
									+'</div></div>'
									+'<input type="hidden" class="hide" name="leaveType_hidden" id="lt_hidden">';
								$('#leaveTypes').addClass('row g-6').append(radio);
							} else {
								let radio =	'<div class="col-12 col-sm-6 col-md-3"><div class="form-check form-check-custom form-check-solid mb-3">'
									+'<input class="form-check-input me-3" type="radio" name="leaveType" id="lt_'+leaveTypes[i].id+'" value="'+leaveTypes[i].id+'" required>'+leaveTypes[i].name
									+'</div></div>'
									+'<input type="hidden" class="hide" name="leaveType_hidden" id="lt_hidden">';
								$('#leaveTypes').addClass('row g-6').append(radio);
							}
						}
					} else {
						if(leaveCheck[i] == '1'){
							let radio =	'<div class="col-12 col-sm-6 col-md-3"><div class="form-check form-check-custom form-check-solid mb-3">'
								+'<input class="form-check-input me-3" type="radio" name="leaveType" id="lt_'+leaveTypes[i].id+'" value="'+leaveTypes[i].id+'" disabled required>'+leaveTypes[i].name
								+'</div></div>'
								+'<input type="hidden" class="hide" name="leaveType_hidden" id="lt_hidden">';
							$('#leaveTypes').addClass('row g-6').append(radio);
						} else {
							let radio =	'<div class="col-12 col-sm-6 col-md-3"><div class="form-check form-check-custom form-check-solid mb-3">'
								+'<input class="form-check-input me-3" type="radio" name="leaveType" id="lt_'+leaveTypes[i].id+'" value="'+leaveTypes[i].id+'" required>'+leaveTypes[i].name
								+'</div></div>'
								+'<input type="hidden" class="hide" name="leaveType_hidden" id="lt_hidden">';
							$('#leaveTypes').addClass('row g-6').append(radio);
						}
					}
				} 
				
				else if(leaveTypes[i].id == '5') {
					// Leave w/o pay can be created by user who has 'leave.approve'
					<perm:permission object="leave.approve">
					
					let radio =	'<div class="col-12 col-sm-6 col-md-3"><div class="form-check form-check-custom form-check-solid mb-3">'
						+'<input class="form-check-input me-3" type="radio" name="leaveType" id="lt_'+leaveTypes[i].id+'" value="'+leaveTypes[i].id+'" required>'+leaveTypes[i].name
						+'</div></div>'
						+'<input type="hidden" class="hide" name="leaveType_hidden" id="lt_hidden">';
					$('#leaveTypes').addClass('row g-6').append(radio);
					
    				</perm:permission>
				}
				
				else if(leaveTypes[i].id != '9') {
					let radio =	'<div class="col-12 col-sm-6 col-md-3"><div class="form-check form-check-custom form-check-solid mb-3">'
						+'<input class="form-check-input me-3" type="radio" name="leaveType" id="lt_'+leaveTypes[i].id+'" value="'+leaveTypes[i].id+'" required>'+leaveTypes[i].name
						+'</div></div>'
						+'<input type="hidden" class="hide" name="leaveType_hidden" id="lt_hidden">';
					$('#leaveTypes').addClass('row g-6').append(radio);
				}
			}
			
			

			$('input:radio[name="leaveType"]').change(function(){
				if( $(this).val() == '6' ){
					let lastday = '${lastday}';
					let lastday_ts = toTimestamp(lastday);
					let selectedDateTo = $('#date_to').val();
					let selectedDateTo_ts = toTimestamp(selectedDateTo);
					$('#date_to').datepicker('setEndDate',lastday);
					if(selectedDateTo_ts > lastday_ts){
						$('#date_to').val(lastday);
					}
				
				else{
					$('#date_to').datepicker('setEndDate','');
				}
				}
			});
		});
	</script>
</c:if>
<!-- End leaveType Radio -->

<c:if test="${leave == null}">
	<c:set var="leave" value="''" />
</c:if>
<c:if test="${fileLeave == null}">
	<c:set var="fileLeave" value="''" />
</c:if>

<script>
	/* $("#kt_daterangepicker").daterangepicker({
		startDate : moment().startOf("year"),
		endDate : moment().endOf("year"),
		locale : {
			format : "DD MMM YYYY"
		}
	}); */

/* 	$(document).ready(function () {
		// กำหนดค่าเริ่มต้น
		//var start = moment("<fmt:formatDate value='${startdate}' pattern='dd-MM-yyyy'/>", "DD-MM-YYYY");
		//var end = moment("<fmt:formatDate value='${enddate}' pattern='dd-MM-yyyy'/>", "DD-MM-YYYY");

		// สร้าง Date Range Picker
		$("#kt_daterangepicker").daterangepicker({
	        //startDate: start,
	        //endDate: end,
			locale: {
				format: "DD MMM YYYY"
	        },
	        showDropdowns: true,     //มี dropdown เดือน/ปี
	        linkedCalendars: false,  //เดือนซ้าย-ขวาอิสระ ไม่ fix
	        alwaysShowCalendars: true,
	        opens: 'center'
		}, function (start, end) {
			//อัปเดต hidden input ทุกครั้งที่เลือกช่วงวันใหม่
			$("#startdate").val(start.format("DD-MM-YYYY"));
			$("#enddate").val(end.format("DD-MM-YYYY"));

			//auto-submit form
			$("#searchForm").submit();
		});

		// ตั้งค่าเริ่มต้นตอนโหลด
		//$("#startdate").val(start.format("DD-MM-YYYY"));
		//$("#enddate").val(end.format("DD-MM-YYYY"));
	});
 */	
</script>

<script>
    $(()=>{
        var userList = ${userList};
        var action = '${action}';
        var user;
        var manager;
        const queryString = window.location.search;
    	const urlParams = new URLSearchParams(queryString);
    	const la = urlParams.get('la');
    	console.log(la);
        if(action == 'Edit'){
            var leave = ${leave};
            var fileLeave = ${fileLeave};
            user = leave.userId;
            manager = leave.apprUserId;
            department = leave.leaveStatusId.toString();
            if(la == '1'){
            	$('form').attr('action','new_LeaveEdit_Do_LA');
            	<perm:permission object="leave.approve">
    				document.getElementById('status').disabled = false;
    			</perm:permission>
            } else{
            	$('form').attr('action','new_LeaveEdit_Do');	
            }
            
        } else {
            user = "${onlineUser.id}";
            manager = "${onlineUser.managerId}";
            if(la == '1'){
            	$('form').attr('action','new_LeaveAdd_Do_LA');
            } else{
            	$('form').attr('action','new_LeaveAdd_Do');	
            }
            if(la == '1'){
            	<perm:permission object="leave.viewall">
            		document.getElementById('user').disabled = false;
				</perm:permission>
				
            }
            
        }
        user = user.toLowerCase();
        manager = manager.toLowerCase();

        /* Date from leave calendar */
        
        $('#date_from').val('${date}');
		$('#date_to').val('${date}');
        $('#amount').val(1);
        
        /* Set time format from Add Leave */
            
            
        /* Start amount of day from Add Leave */
        var holiday;
		var holidays = [];
		holiday = JSON.parse('${holiday}');

		for(let i=0;i<holiday.length;i++){
			let start = new Date(holiday[i].start);
			let end = new Date(holiday[i].end);
			for(let j=start; j<=end; j.setDate(j.getDate()+1)){
				holidays.push(toDisplayDate(j));
			}
		}
        
  		/* $('.input-daterange').change(function(){
			let amount = 0;
			let holiday_count = 0;
			let from = new Date( toISODate( $('#date_from').val() ) );
			let to = new Date( toISODate( $('#date_to').val() ) );
			let halfDay = $('#halfDay').val();
			if(halfDay !== "0"){
				$('#date_to').val($('#date_from').val());
				$('#date_to_hidden').val($('#date_from').val());
				$('#amount').val(0);
				$('#amount_hidden').val(0);
			} else {
				if(from < to){
					amount = ((to-from)/86400000)+1;
					for(let i=from; i<to; i.setDate(i.getDate()+1)){
						for(let j=0; j<holidays.length; j++){
							let holiday_ts = toTimestamp2(holidays[j]);
							if(i.getTime() == holiday_ts){
								holiday_count++;
							}
						}
						console.log(holiday_count);
						if(i.getDay() == '0' || i.getDay() == '6'){
							holiday_count++;
						}
					}
					amount -= holiday_count;
				} else if(from > to){
					$('#date_from').val('');
					$('#date_to').val('');
	  			} else if(from.getTime() === to.getTime() && halfDay === "0"){
					amount = 1;
				} else if(from.getTime() === to.getTime() && halfDay !== "0"){
					amount = 0;
				}
				$('#amount').val(amount);
				$('#amount_hidden').val(amount);
				//console.log($('#amount_hidden').val());
			}
		}); */
		  function handleDateChange() {
		    let amount = 0;
		    let holiday_count = 0;
		    let from = new Date(toISODate($('#date_from').val()));
		    let to = new Date(toISODate($('#date_to').val()));
		    let halfDay = $('#halfDay').val();

		    if (halfDay !== "0") {
		      $('#date_to').val($('#date_from').val());
		      $('#date_to_hidden').val($('#date_from').val());
		      $('#amount').val(0);
		      $('#amount_hidden').val(0);
		    } else {
		      if (from < to) {
		        amount = ((to - from) / 86400000) + 1;
		        for (let i = from; i < to; i.setDate(i.getDate() + 1)) {
		          for (let j = 0; j < holidays.length; j++) {
		            let holiday_ts = toTimestamp2(holidays[j]);
		            if (i.getTime() == holiday_ts) holiday_count++;
		          }
		          if (i.getDay() == '0' || i.getDay() == '6') holiday_count++;
		        }
		        amount -= holiday_count;
		      } else if (from > to) {
		        $('#date_from').val('');
		        $('#date_to').val('');
		      } else if (from.getTime() === to.getTime() && halfDay === "0") {
		        amount = 1;
		      } else if (from.getTime() === to.getTime() && halfDay !== "0") {
		        amount = 0;
		      }
		      $('#amount').val(amount);
		      $('#amount_hidden').val(amount);
		    }
		  }

		  const dateFrom = document.getElementById("date_from");
		  const dateTo = document.getElementById("date_to");
		  const dateRangeDiv = document.querySelector(".input-daterange");

		  // ยิง event ขึ้น div
		  dateFrom.addEventListener("change.td", function () {
		    $(dateRangeDiv).trigger("change");
		  });
		  dateTo.addEventListener("change.td", function () {
		    $(dateRangeDiv).trigger("change");
		  });

		  // jQuery ฟังที่ div เหมือนเดิม
		  $('.input-daterange').on('change', handleDateChange);

		  
		
  		$('.checkHours').change(function(){
  			let timeFrom = new Date("01/01/2007 " + $('#time_from').val()).getHours();
  			let timeTo = new Date("01/01/2007 " + $('#time_to').val()).getHours();
  			let hourDiff = timeTo - timeFrom;
  			if (hourDiff <= 0) {
  				hourDiff = 0;
  				$('#time_to').val('');
  				$('#alert_time_to').text('กรุณาระบุเวลาสิ้นสุดใหม่').css({
  				    fontSize: "12px",
  				    color: "red"
  				});
  			} else if(hourDiff > 0 && hourDiff < 8) {
  				$('#time_to').css('color', 'black');
  				$('#alert_time_to').text('');
  			} else if(hourDiff >= 8){
  				hourDiff = 0;
  				$('#time_to').val('');
  				$('#alert_time_to').text('8 ชม. ขึ้นไป กรุณาเลือกการลาแบบเต็มวัน').css({
  				    fontSize: "12px",
  				    color: "red"
  				});
  			} else {
  				hourDiff = null;
  			}
  			$('#amount_sub').val(hourDiff);
  			$('#amount_sub_hidden').val(hourDiff);

            // อัปเดตค่าแสดงผล (display text)
            updateLeaveDisplay();
  			
        });

		function updateLeaveDisplay() {
		  const day = parseFloat($('#amount').val()) || 0;
		  const hour = parseFloat($('#amount_sub').val()) || 0;
		  const total = day + (hour / 8); // 8 ชม. = 1 วัน
		  $('#amount_display').text(`${total.toFixed(2)} day`);
		}

        // เรียกอัปเดตเมื่อมีการเปลี่ยนวันที่ด้วย
        $('.input-daterange').on('change', updateLeaveDisplay);
        
  		/* End amount of day from Add Leave */
  			
        

        /* Start Applicant/Approver List */
        for(let i=0; i<userList.length; i++){
        	let id = userList[i].id.toLowerCase();
            let name = userList[i].name;
            let name_en = userList[i].name_en;
            let employee_id = userList[i].employee_id;
            let status = userList[i].enable;

            let displayText = '';

            if (employee_id) {
                displayText += employee_id;
            }
            if (name) {
                if (displayText) displayText += ' - ';
                displayText += name;
            }
            if (name_en) {
                if (displayText) displayText += ' - ';
                displayText += name_en;
            }

            let option = '<option value="'+id+'">'+displayText+'</option>';

            if(status == '1'){
                $('#u_enable').append(option);
            }
            else{
                $('#u_disable').append(option);
            }
            if(id == manager){
            	$('#approver').append(option);
            }
        }
        $('#user').val(user);
        $('#user').trigger('change');
        $('#user_hidden').val(user);
        $('#status_hidden').val(0);
        $('#approver').val(manager);
        $('#approver').trigger('change');
        $('#user').change(()=>{
            let val = $('#user').val();
            for(let i=0; i<userList.length; i++){
                let user = userList[i].id.toLowerCase();
                let mng = userList[i].manager;
                if( user == val ){
                    $('#approver').val(mng.toLowerCase());
                    $('#approver').trigger('change');
                }
            }
        });
        /* End Applicant/Approver List */

        console.log(leave);
        console.log(fileLeave);
        /* Start Leave Edit init */
        if(leave != null){
        	$('#user_hidden').val(leave.userCreate);
        	$('#leaveId_hidden').val(leave.leaveId);
        	console.log($('#leaveId_hidden').val());
        	$('#status_hidden').val(leave.leaveStatusId);
        	var noDay = leave.noDay.toString().split(".");
			var amount = noDay[0];
			var amount_sub = (leave.noDay%1)*8;
			if(isNaN(amount_sub)){ amount_sub = 0;}
			var s_date = moment(leave.startDate, 'MMM D, Y').format('DD MMM YYYY');
			var e_date = moment(leave.endDate, 'MMM D, Y').format('DD MMM YYYY');
			$('#date_from').val(s_date);
			$('#date_to').val(e_date);
			if(leave.halfDay === '3'){
				$('#time_from').val(leave.startTime);
				$('#time_to').val(leave.endTime);	
			}
			$('#amount').val(amount);
			$('#amount_hidden').val(amount);
			$('#amount_sub').val(amount_sub);
			$('#amount_sub_hidden').val(amount_sub);
			$('#description').val(leave.description);
			$('#status').val(leave.leaveStatusId).change();
			$('#lt_'+leave.leaveTypeId).prop('checked','checked');
			$('#halfDay').val(leave.halfDay).change();
			$('#approver').val(leave.apprUserId).change();
			
			// old
			/* if(fileLeave != ''){
			    $('#linkImage').text(fileLeave.name+fileLeave.type);
			    $('#linkImage').attr('href', 'preview_File?id='+fileLeave.fileId);
			    $('#fileUploadId').val(fileLeave.fileId);
			} */

			// new
			if(fileLeave != '' && fileLeave != null){
			    const fullFileName = fileLeave.name + fileLeave.type;
			    const downloadPath = 'preview_File?id=' + fileLeave.fileId;
			    renderSingleFilePreview(fullFileName, downloadPath, true, fileLeave.fileId);
			    $('#fileUploadId').val(fileLeave.fileId);
			}
        }
        /* End Leave Edit init */
        
        const qThisYear = '${quotaThisYear}';
    	console.log(qThisYear);
        /* beforeSubmit = function(){
        	var spinner = $('#loader');
        	var form = $('#formid');
        	var reportValidity = form[0].reportValidity();
        	if(reportValidity){
        		spinner.show();
        		$('#btn_submit').prop('disabled', true);
        		console.log(form);
        		form.submit();
        		
        		// Refresh the window that opened this one, if it exists to show the latest data
        		if (window.opener) {
                    window.opener.location.reload();
                }
        	}
        } */
    });

    function userOnChange(){
		console.log("[userOnChange]");

		var empId = $('#user').find(":selected").text().split(" ")[0];
		console.log("[userOnChange] empId = " + empId);
		
		var userId = $('#user').val();
		console.log("[userOnChange] userId  = " + userId);

		$.ajax({
			url : "getManagerIdAndManagerName",
			method : "POST",
			type : "JSON",
			data : {
				"userId" : userId
			},
			success : function(data) {
				console.log(data);
				var dataObj = JSON.parse(data);
				$("#approver option[value != 'admin']").remove();
				$('#approver').append(dataObj.option)
				$("#approver").val(dataObj.approverId).change();
			}
		})
		
        }

</script>

<script>
  /* document.addEventListener('DOMContentLoaded', function () {
    //Start time picker
    flatpickr("#start_time", {
      enableTime: true,
      noCalendar: true,
      dateFormat: "H:i",
      time_24hr: true,
      defaultHour: 9,
      defaultMinute: 0,
      defaultDate: "09:00",
    });

    //End time picker
    flatpickr("#end_time", {
      enableTime: true,
      noCalendar: true,
      dateFormat: "H:i",
      time_24hr: true,
      defaultHour: 18,
      defaultMinute: 0,
      defaultDate: "18:00",
    });
  }); */
  document.addEventListener("DOMContentLoaded", function () {
	  // Start Time picker
	  const startTimePicker = new tempusDominus.TempusDominus(document.getElementById("time_from"), {
	    display: {
	      components: {
	        calendar: false, // ไม่ต้องมีปฏิทิน
	        clock: true,     // แสดงนาฬิกา
	        hours: true,
	        minutes: true,
	        seconds: false,
	        useTwentyfourHour: true // ปิด AM/PM
	      },
	      theme: "light"
	    },
	    localization: {
	      hourCycle: 'h23', // ใช้ 24-hour system
	      format: "HH:mm"
	    },
	    useCurrent: false
	  });

	  // ตั้งค่าเริ่มต้นเป็น 09:00
	  startTimePicker.dates.setValue(tempusDominus.DateTime.convert(new Date(0, 0, 0, 9, 0)));

	  // End Time picker
	  const endTimePicker = new tempusDominus.TempusDominus(document.getElementById("time_to"), {
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

	  // ตั้งค่าเริ่มต้นเป็น 18:00
	  endTimePicker.dates.setValue(tempusDominus.DateTime.convert(new Date(0, 0, 0, 18, 0)));
	});
</script>

<script>
function showFileName(input) {
    const fileDisplay = document.getElementById("fileNameDisplay");
    if (input.files.length > 0) {
        fileDisplay.textContent = input.files[0].name;
    } else {
        fileDisplay.textContent = "ยังไม่ได้เลือกไฟล์";
    }
}
</script>

<script>
function beforeSubmit() {
	var spinner = $('#loader');
	var form = $('#formid');
	var reportValidity = form[0].reportValidity();
	if(reportValidity){
		spinner.show();
		$('#btn_submit').prop('disabled', true);
		console.log(form);
		form.submit();
		
		// Refresh the window that opened this one, if it exists to show the latest data
		if (window.opener) {
            window.opener.location.reload();
        }
	}
}
</script>

<script>
document.addEventListener("DOMContentLoaded", function () {

/*   // Start Date Picker
  const startPicker = new tempusDominus.TempusDominus(document.getElementById("date_from"), {
    localization: {
      format: "dd MMM yyyy",
    },
    display: {
      components: {
        calendar: true,
        date: true,
        month: true,
        year: true,
        clock: false
      },
      theme: 'light'
    },
    useCurrent: false
  });

  // End Date Picker
  const endPicker = new tempusDominus.TempusDominus(document.getElementById("date_to"), {
    localization: {
      format: "dd MMM yyyy",
    },
    display: {
      components: {
        calendar: true,
        date: true,
        month: true,
        year: true,
        clock: false
      },
      theme: 'light'
    },
    useCurrent: false
  }); */





//Start Date Picker
  $("#date_from").daterangepicker({
    singleDatePicker: true,
    showDropdowns: true,
    autoApply: true,  // ยืนยันโดยอัตโนมัติเมื่อเลือกวันที่
    locale: {
      format: "DD MMM YYYY",  // รูปแบบวันที่
      monthNames: [
        "January", "February", "March", "April", "May", "June",
        "July", "August", "September", "October", "November", "December"
      ],  // กำหนดชื่อเดือนเต็ม
    },
    drops: "down",
    theme: 'light',  // ใช้ธีมแสง
  });

  // End Date Picker
  $("#date_to").daterangepicker({
    singleDatePicker: true,
    showDropdowns: true,
    autoApply: true,  // ยืนยันโดยอัตโนมัติเมื่อเลือกวันที่
    locale: {
        format: "DD MMM YYYY",  // รูปแบบวันที่
        monthNames: [
          "January", "February", "March", "April", "May", "June",
          "July", "August", "September", "October", "November", "December"
        ],  // กำหนดชื่อเดือนเต็ม
    },
    drops: "down",
    theme: 'light',  // ใช้ธีมแสง
  });






  

  // ซิงค์ค่า hidden input
  document.getElementById("date_from").addEventListener("change.td", function (e) {
    const val = e.detail.date ? e.detail.date.format("DD-MM-YYYY") : "";
    document.getElementById("date_from_hidden").value = val;
  });

  document.getElementById("date_to").addEventListener("change.td", function (e) {
    const val = e.detail.date ? e.detail.date.format("DD-MM-YYYY") : "";
    document.getElementById("date_to_hidden").value = val;
  });

/*
  // ⚙️ บังคับ End ≥ Start
  startPicker.subscribe(tempusDominus.Namespace.events.change, (e) => {
    if (e.date) {
      // ปรับ minDate ของ End
      endPicker.updateOptions({
        restrictions: { minDate: e.date }
      });

      // ถ้า End ที่เลือกไว้น้อยกว่า Start → ล้างค่า End
      const endDate = endPicker.dates.lastPicked;
      if (endDate && endDate < e.date) {
        endPicker.dates.clear();
      }
    }
  });

  // ⚙️ บังคับ Start ≤ End
  endPicker.subscribe(tempusDominus.Namespace.events.change, (e) => {
    if (e.date) {
      // ปรับ maxDate ของ Start
      startPicker.updateOptions({
        restrictions: { maxDate: e.date }
      });

      // ถ้า Start ที่เลือกไว้อยู่หลัง End → ล้างค่า Start
      const startDate = startPicker.dates.lastPicked;
      if (startDate && startDate > e.date) {
        startPicker.dates.clear();
      }
    }
  });
*/

  
});
</script>

<script>
    function renderSingleFilePreview(fileName, fileUrl, isExisting = false, fileId = null) {
        const container = document.getElementById('filePreviewContainer');
        if (!container) return; 
        container.innerHTML = '';
        const fileExtension = fileName.split('.').pop().toLowerCase();
        
        // เลือกไอคอนตามนามสกุลไฟล์
        let iconClass = "fa-file"; 
        if (fileExtension === "pdf") iconClass = "ki-duotone ki-file-pdf";
        else if (["doc", "docx"].includes(fileExtension)) iconClass = "fa-file-word-o";
        else if (["xls", "xlsx"].includes(fileExtension)) iconClass = "fa-file-excel-o";
        else if (["png", "jpg", "jpeg", "gif"].includes(fileExtension)) iconClass = "fa-file-image-o";

        const fileWrapper = document.createElement('div');
        fileWrapper.className = 'd-flex justify-content-between align-items-center p-2 border rounded bg-light';

        // Left Group (Icon + Link)
        const leftGroup = document.createElement('div');
        leftGroup.className = 'd-flex align-items-center overflow-hidden';
        
        const icon = document.createElement('i');
        icon.className = `${iconClass} fs-2 me-3`; 

        const link = document.createElement('a');
        link.href = fileUrl || '#';
        link.target = '_blank';
        link.className = 'text-gray-800 fw-medium text-hover-primary text-truncate';
        link.textContent = fileName;
        link.style.maxWidth = '250px';

        leftGroup.appendChild(icon);
        leftGroup.appendChild(link);
        
        // Right Group (Delete Button)
        const removeBtn = document.createElement('span');
        removeBtn.className = 'btn btn-icon btn-sm btn-light-danger cursor-pointer';
        
        // Event Handler
        removeBtn.onclick = function() {
            removeSingleFile(isExisting, fileId);
        };

        const trashIcon = document.createElement('i');
        trashIcon.className = 'ki-duotone ki-trash fs-3';
        trashIcon.innerHTML = `<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span>`;
        
        removeBtn.appendChild(trashIcon);

        fileWrapper.appendChild(leftGroup);
        fileWrapper.appendChild(removeBtn);
        container.appendChild(fileWrapper);
    }

    // fn remove file
    window.removeSingleFile = function(isExisting, fileId) {
        document.getElementById('filePreviewContainer').innerHTML = '';
        
        const fileInput = document.getElementById('myFile');
        if (fileInput) {
             fileInput.value = '';
        }
        
        const sizeInput = document.getElementById('size');
        if (sizeInput) {
            sizeInput.value = '';
        }
        
        if (isExisting === true && fileId != null) {
            document.getElementById('deleteFileId').value = fileId;
            document.getElementById('fileUploadId').value = ''; 
        } else if (isExisting === 'true' && fileId !== 'null' && fileId !== '') {
            document.getElementById('deleteFileId').value = fileId;
            document.getElementById('fileUploadId').value = ''; 
        }
    };

    document.addEventListener('DOMContentLoaded', function() {
        const fileInput = document.getElementById('myFile');
        
        if (typeof action !== 'undefined' && action === 'Edit' && typeof fileLeave !== 'undefined' && fileLeave != null && fileLeave != ''){
            
            const fullFileName = fileLeave.name + fileLeave.type;
            const downloadPath = 'preview_File?id=' + fileLeave.fileId;
            
            renderSingleFilePreview(fullFileName, downloadPath, true, fileLeave.fileId);

            $('#fileUploadId').val(fileLeave.fileId);
            
            $('#deleteFileId').val('');
        }

        if (!fileInput) {
             console.error("Critical Error: File input element with ID 'myFile' not found.");
             return;
        }

        fileInput.addEventListener('change', function(event) {
            const file = event.target.files[0];
            
            if (!file) return;

            const forbiddenChars = /[\/:*?"<>|]/;
            if(forbiddenChars.test(file.name)) {
                alert("File name contains invalid characters.");
                this.value = ''; 
                document.getElementById('filePreviewContainer').innerHTML = '';
                document.getElementById('size').value = '';
                return;
            }

            var fSExt = new Array('Bytes', 'KB', 'MB', 'GB');
            var fSize = file.size;
            var i = 0;
            while (fSize > 900) { fSize /= 1024; i++; }
            var size_n = (Math.round(fSize * 100) / 100);
            document.getElementById('size').value = size_n + ' ' + fSExt[i];

            const tempUrl = URL.createObjectURL(file); 
            renderSingleFilePreview(file.name, tempUrl, false);
            
            document.getElementById('deleteFileId').value = '';
            document.getElementById('fileUploadId').value = ''; 
        });

    });
</script>
</html>
