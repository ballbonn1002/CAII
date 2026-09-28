<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/tlds/permission.tld" prefix="perm"%>
<%@ page trimDirectiveWhitespaces="true"%>

<c:set var="now" value="<%=new java.util.Date()%>" />
<fmt:formatDate type="date" value="${now}" pattern="dd-MM-yyyy" var="lastday" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/compressorjs/1.2.1/compressor.min.js"></script>

<%-- ===== OLD: desktop-clone content (commented out) =====
		<%
			//comment for fix ClassCastException
			//var action = '${action}'; can still be used
			//String action = (String) request.getAttribute("action");
		%>

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
											<!-- ลาพักร้อน + ลากิจ -->
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
														<div class="d-flex align-items-center">
															<span class="fs-2 fw-bold text-dark">
																<fmt:formatNumber type="number" pattern="#.##" value="${leave_1}"/>+<fmt:formatNumber type="number" pattern="#.##" value="${leave_2}"/>
																/<fmt:formatNumber type="number" pattern="#.##" value="${quota_1+quota_2}"/>
															</span>
															<c:set var="leaveWA1" value="${empty LeaveWAnumT1 ? 0 : LeaveWAnumT1}" />
															<c:set var="leaveWA2" value="${empty LeaveWAnumT2 ? 0 : LeaveWAnumT2}" />
															<c:if test="${(leaveWA1 + leaveWA2) > 0}">
															    <span class="badge badge-sm badge-warning ms-1">
															        <fmt:formatNumber type="number" pattern="#.##" value="${leaveWA1}" />+<fmt:formatNumber type="number" pattern="#.##" value="${leaveWA2}" />
															    </span>
															</c:if>
														</div>
														<span class="text-muted fs-5">${type_1}+${type_2}</span>
													</div>
												</div>
											</div>

											<!-- ลาพักร้อนที่เหลือ -->
											<div class="col-6 col-md-4 col-xl-3">
												<div class="d-flex align-items-center">
													<div class="symbol symbol-50px me-4">
														<span class="symbol-label bg-light-warning">
														<i class="ki-duotone ki-timer fs-2x text-warning">
															<span class="path1"></span><span class="path2"></span><span class="path3"></span>
														</i>
														</span>
													</div>
													<div class="d-flex flex-column">
														<div class="d-flex align-items-center">
															<span class="fs-2 fw-bold text-dark">
																<fmt:formatNumber type="number" pattern="#.##" value="${leave_6}"/>
																<c:if test="${quota_4.doubleValue() > 0}">
																	/<fmt:formatNumber type="number" pattern="#.##" value="${quota_4}"/>
																</c:if>
															</span>
															<c:if test="${LeaveWAnumT6.doubleValue() > 0}">
																<span class="badge badge-sm badge-warning ms-1">
																	<fmt:formatNumber type="number" pattern="#.##" value="${LeaveWAnumT6}"/>
																</span>
															</c:if>
														</div>
														<span class="text-muted fs-5">${type_6}</span>
													</div>
												</div>
											</div>

											<!-- ลาป่วย -->
											<div class="col-6 col-md-4 col-xl-3">
												<div class="d-flex align-items-center">
													<div class="symbol symbol-50px me-4">
														<span class="symbol-label bg-light-info">
															<i class="ki-duotone ki-pulse fs-2x text-info">
																<span class="path1"></span><span class="path2"></span>
															</i>
														</span>
													</div>
													<div class="d-flex flex-column">
														<div class="d-flex align-items-center">
															<span class="fs-2 fw-bold text-dark">
																<fmt:formatNumber type="number" pattern="#.##" value="${leave_3}"/>
															</span>
															<c:if test="${LeaveWAnumT3.doubleValue() > 0}">
																<span class="badge badge-sm badge-warning ms-1">
																	<fmt:formatNumber type="number" pattern="#.##" value="${LeaveWAnumT3}"/>
																</span>
															</c:if>
														</div>
														<span class="text-muted fs-5">${type_3}</span>
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
														<div class="d-flex align-items-center">
															<span class="fs-2 fw-bold text-dark">
																<fmt:formatNumber type="number" pattern="#.##" value="${leave_4}"/>
															</span>
															<c:if test="${LeaveWAnumT4.doubleValue() > 0}">
																<span class="badge badge-sm badge-warning ms-1">
																		<fmt:formatNumber type="number" pattern="#.##" value="${LeaveWAnumT4}"/>
																</span>
															</c:if>
														</div>
														<span class="text-muted fs-5">${type_4}</span>
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
														<div class="d-flex align-items-center">
															<span class="fs-2 fw-bold text-dark">
																<fmt:formatNumber type="number" pattern="#.##" value="${leave_5}"/>
															</span>
															<c:if test="${LeaveWAnumT5.doubleValue() > 0}">
																<span class="badge badge-sm badge-warning ms-1">
																		<fmt:formatNumber type="number" pattern="#.##" value="${LeaveWAnumT5}"/>
																</span>
															</c:if>
														</div>
														<span class="text-muted fs-5">${type_5}</span>
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
														<div class="d-flex align-items-center">
															<span class="fs-2 fw-bold text-dark">
																<fmt:formatNumber type="number" pattern="#.##" value="${leave_7}"/>
															</span>
															<c:if test="${LeaveWAnumT7.doubleValue() > 0}">
																<span class="badge badge-sm badge-warning ms-1">
																		<fmt:formatNumber type="number" pattern="#.##" value="${LeaveWAnumT7}"/>
																</span>
															</c:if>
														</div>
														<span class="text-muted fs-5">${type_7}</span>
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
						<div class="d-flex flex-row">
							<div class="flex-row-fluid mb-5">
								<div class="card card-flush bgi-no-repeat bgi-size-contain bgi-position-x-center border-0 mb-5 mb-xl-10">
									<div class="card-body">
										<form method="post" id="formid" class="form-horizontal" action="line_new_LeaveEdit_Do" enctype="multipart/form-data">

											<!--Header -->
											<div class="d-flex justify-content-between align-items-center mb-6">
												<!-- ด้านซ้าย -->
												<div>
													<h3 class="fw-bold text-gray-800 mb-1 fs-4">Leave form</h3>
												</div>

												<!-- ด้านขวา -->
												<!--DDL Status -->
												<div class="d-flex justify-content-end">
													<!-- Leave ID -->
													<div class="d-flex align-items-center fw-bold fs-4 text-primary me-7" id="leaveidInfo">
														#<span id="leaveId"></span>
													</div>
													<!-- Leave ID -->
													<select class="form-select" id="status" name="status" disabled required style="min-width: 200px; max-width: 300px;">
														<option value="0">Wait for approve</option>
														<option value="1">Approved</option>
														<option value="2">Reject</option>
														<option value="3">Cancel</option>
													</select>
													<input type="hidden" name="status_hidden" id="status_hidden">
												</div>
												<!--DDL Status -->

											</div>

											<!-- Next Year Leave-->
											<div class="mb-10" id="nextYearLeaveContainer">
												<div class="form-check form-check-custom form-check-solid">
													<input class="form-check-input me-3" type="checkbox" id="nextYearLeave" name="nextYearLeave" value="1" />
													<label class="form-check-label" for="nextYearLeave">
														<div class="fw-bold fs-3 text-primary">เลือกวันลาปีหน้า</div>
													</label>
												</div>
											</div>
											<!-- Next Year Leave-->


											<!-- DDL User -->
											<div class="mb-10">
												<select id="user" name="user" class="form-select" onchange="userOnChange()" disabled required>
													<option></option>
													<optgroup id='u_enable' label="Enable"></optgroup>
													<optgroup id='u_disable' label="Disable"></optgroup>
												</select>
												<input hidden name="user_hidden" id="user_hidden" type="text">
												<input hidden name="leaveId_hidden" id="leaveId_hidden" type="text">
											</div>
											<!-- DDL User -->

											<!-- Type of leave -->
											<div class="mb-14">
												<div class="col-12 mb-5">
													<label class="form-label fw-semibold fs-5">Type of leave</label>
												</div>
												<div id="leaveTypes" class="row g-6 fs-4">
													<!-- Loop Leave Type Javascript -->
												</div>
											</div>
											<!-- Type of leave -->

											<div class="mb-10">
												<div class="row g-6">

													<!--Date range & half-day -->
													<!-- Date Range -->
													<div class="row mb-10">

														<div class="col-md-6">

															<div class="row align-items-end">
																<!-- Start Date -->
																<div class="col-md-6 mb-5 mb-md-0">
																	<label class="form-label fw-semibold fs-5">Start Date <span class="text-danger">*</span></label>
																	<div class="input-group date date-picker input-daterange" data-provide="datepicker" data-date-format="dd M yyyy">
																		<input type="text" class="form-control" id="date_from" name="from" autocomplete="off" required>
																		<input class="hide" name="from_hidden" id="date_from_hidden" type="text" hidden>
																	</div>
																</div>

																<!-- End Date -->
																<div class="col-md-6 mb-5 mb-md-0">
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

													<!-- </div> -->

													<div class="row mb-10">
														<!-- Start Time -->
														<div class="col-md-6 mb-5 mb-md-0">
															<label class="form-label fw-semibold fs-5">Start Time <span class="text-danger">*</span></label>
															<div class="input-group">
																<input type="text" class="form-control timepicker timepicker-24 checkHours" id="time_from" name="time_from" autocomplete="off" required disabled>
															</div>
															<input class="hide" id="time_from_hidden" name="time_from_hidden" hidden>
														</div>

														<!-- End Time -->
														<div class="col-md-6 mb-5 mb-md-0">
															<label class="form-label fw-semibold fs-5">End Time <span class="text-danger">*</span></label>
															<div class="input-group">
																<input type="text" class="form-control timepicker timepicker-24 checkHours" id="time_to" name="time_to" autocomplete="off" required disabled>
															</div>
															<input class="hide" id="time_to_hidden" name="time_to_hidden" hidden>
															<div class="form-text text-danger" id="alert_time_to"></div>
														</div>
													</div>

													<div class="row mb-10">
														<!-- Start Time -->
														<div class="col-md-6 mb-5 mb-md-0">
															<label class="form-label fw-semibold fs-5">Day</label>
															<div class="input-group">
																<input type="text" class="form-control timepicker timepicker-24 checkHours" id="amount" name="amount" min="1" max="1000" maxlength="3" disabled>
															</div>
															<input class="hide" id="amount_hidden" name="amount_hidden" hidden>
														</div>

														<!-- End Time -->
														<div class="col-md-6 mb-5 mb-md-0">
															<label class="form-label fw-semibold fs-5">Hours</label>
															<div class="input-group">
																<input type="text" class="form-control timepicker timepicker-24 checkHours" id="amount_sub" name="amount_sub" value="0" min="1" max="1000" maxlength="3" onchange="check()" disabled>
															</div>
															<input class="hide" value="0" id="amount_sub_hidden" name="amount_sub_hidden" hidden>
														</div>
													</div>

													<!--Description -->
													<div class="mb-10">
														<label class="form-label required fs-5">Description</label>

														<textarea
															class="form-control"
															style="word-break: break-all; white-space: normal;" maxlength="1024"
															name="description" id="description"
															rows="3" placeholder="Enter a reason."
															required></textarea>

														<input hidden class="hide" name="description_hidden" id="description_hidden" type="text">

														<div class="text-danger mt-2">กรุณาระบุเหตุผลในการลา ตัวอย่าง ลางานเนื่องจากท้องเสีย</div>
													</div>

													<!--File Upload -->
													<div class="mb-10" id="fileUploadSection">
														<label class="form-label fs-5" id="fileUploadLabel">Attach files</label>
														<div class="d-flex flex-column">
															<div id="fileUploadControls">
																<label for="myFile" id="lbFile" class="btn btn-primary w-150px mb-2 d-inline-flex align-items-center justify-content-center gap-2" style="height: 40px;">
																Attach files
																<input type="file" id="myFile" name="fileUpload" style="display:none;" accept="image/*,application/pdf,application/zip"> 
																</label>
																<input type="hidden" name="deleteFileId" id="deleteFileId">
																<input type="hidden" name="fileUploadSize" value="${size}" id="size">
																<input type="hidden" name="fileUploadId" id="fileUploadId">
															</div>
															<div id="filePreviewContainer" class="mt-2" style="max-width: 400px;"></div>
														</div>
													</div>

													<div class="mb-10" id="exitingFileSection">
														<div id="exitingFilePreviewContainer" class="mt-2" style="max-width: 400px;"></div>
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
														<button type="button" class="btn btn-success" id="submitBtn" onclick="beforeSubmit();">Submit</button>
														<button type="button" id="lbafterFile" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#attachFileModal">
															Attach files
														</button>
													</div>
													<!-- <div id="filePreviewContainer_afterFile" class="d-flex justify-content-end gap-3"></div> -->

													<!-- Attach File Modal -->
													<div class="modal fade" id="attachFileModal" tabindex="-1" aria-hidden="true">
														<div class="modal-dialog modal-dialog-centered">
															<div class="modal-content">
																<div class="modal-header">
																	<h5 class="modal-title fw-bold">Attach File</h5>
																	<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
																</div>
																<div class="modal-body pt-5 pb-5">
																	<label for="afterFile" class="btn btn-primary mb-3">
																		Attach file
																		<input type="file" id="afterFile" name="afterFileUpload" style="display:none;" accept="image/*,application/pdf" onchange="previewModalFile(this)">
																	</label>
																	<div id="modalFilePreviewName" class="text-muted fs-6">No file selected</div>
																</div>
																<div class="modal-footer">
																	<button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
																	<button type="button" class="btn btn-success" onclick="submitModalFile()">Submit</button>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>

										</form>
										<div class="py-9">
											<div class="fs-6" id="requestInfo">
												Request By : <span class="" id="ucEmpId"></span> <span id="ucName"></span> , <span id="timeCreate"></span>
											</div>
											<div class="fs-6" id="approveInfo">
												Approved By : <span class="" id="aprEmpId"></span> <span class="" id="aprName"></span> - <span id="aprRole"></span> , <span id="timeUpdate"></span>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!--end::Content container-->
				</div>
				<!--end::Content-->

			</div>
			<!--end::Content wrapper-->

		</div>
		<!--end:::Main-->
--%>
<!-- ===== END: old desktop-clone content (commented out) ===== -->

<%-- =====================================================================
     NEW: LINE LIFF
     ===================================================================== --%>

<style>
/* .liff-shell / .liff-back-btn / .liff-loading-overlay / .liff-input-underline / .liff-field-*
   now live in _layout/baseLayout.jsp (shared across all LIFF pages) — kept here only what's
   specific to this leave form. */
.liff-leave-card { border-radius: 14px; }
.liff-day-badges { flex: 1 1 auto; display: flex; justify-content: flex-end; gap: 10px; }
.liff-day-badge { box-sizing: border-box; display: inline-flex; align-items: center; justify-content: center; min-width: 26px; height: 26px; padding: 4.23px 6.5px; border-radius: 5.52px; opacity: 1; background: var(--bs-gray-300); color: var(--bs-gray-700); font-weight: 600; font-size: 12px; white-space: nowrap; }
/* leaveType is now a real <select> (#leaveTypeSelect); the legacy-generated radios in #leaveTypes
   stay in the DOM (visually hidden) so the untouched scripts (quota disable, required validation,
   leave-id-6 date logic) keep working exactly as before — see the sync script below. */
#leaveTypes { position: absolute; width: 1px; height: 1px; overflow: hidden; clip: rect(0 0 0 0); white-space: nowrap; }
.liff-upload-badge { box-sizing: border-box; display: inline-flex; align-items: center; justify-content: center; gap: 10px; margin-left: auto; width: 84px; height: 24px; padding: 0 8px; border-radius: 5.53px; opacity: 1; background: var(--bs-primary-bg-subtle); color: var(--bs-primary); font-weight: 600; font-size: 12px; white-space: nowrap; cursor: pointer; }
.liff-upload-badge i { color: var(--bs-primary); }
.liff-submit-bar { display: flex; gap: 10px; margin-top: 20px; }
.liff-submit-bar .btn { flex: 1; }
#status.liff-status-select { font-size: 12px; font-weight: 600; padding: 4px 10px; min-width: 0; width: auto; border-radius: 8px; }</style>

<div class="liff-shell">

	<div id="liffLoadingOverlay" class="liff-loading-overlay">
		<div class="spinner-border text-primary" role="status"><span class="visually-hidden">Loading...</span></div>
	</div>

	<div class="d-flex align-items-center gap-3 mb-6 pt-6">
		<a href="javascript:void(0)" class="liff-back-btn" onclick="document.getElementById('liffLoadingOverlay').style.display='flex'; window.history.go(-1); return false;" aria-label="Back">
			<i class="ki-duotone ki-black-left fs-3 text-gray-700"><span class="path1"></span><span class="path2"></span></i>
		</a>
		<h1 class="liff-page-title text-gray-700 mb-0 flex-grow-1">Create Leave</h1>
		<!-- <div class="d-flex align-items-center" id="leaveidInfo" style="display:none;">
			<span class="fw-bold fs-6 text-primary">#<span id="leaveId"></span></span>
		</div> -->
	</div>

	<!-- Summary Leave: hidden per request (no longer shown in FE UI). Kept as a comment, not deleted,
	     in case it needs to come back. -->
	<!-- <div class="mb-6">
		<div class="card card-bordered liff-leave-card">
			<div class="card-body p-4">
				<div class="d-flex overflow-auto gap-5" style="scrollbar-width:none;">
					<div class="d-flex align-items-center gap-2" style="white-space:nowrap;">
						<span class="symbol symbol-40px">
							<span class="symbol-label bg-primary-subtle">
								<i class="ki-duotone ki-car-2 text-primary fs-3">
									<span class="path1"></span><span class="path2"></span><span class="path3"></span>
									<span class="path4"></span><span class="path5"></span><span class="path6"></span>
								</i>
							</span>
						</span>
						<div class="d-flex flex-column">
							<span class="fw-bold text-gray-800 fs-7">
								<fmt:formatNumber type="number" pattern="#.##" value="${leave_1}"/>+<fmt:formatNumber type="number" pattern="#.##" value="${leave_2}"/>
								/<fmt:formatNumber type="number" pattern="#.##" value="${quota_1+quota_2}"/>
							</span>
							<span class="text-gray-500" style="font-size:11px;">${type_1}+${type_2}</span>
						</div>
					</div>
					<div class="d-flex align-items-center gap-2" style="white-space:nowrap;">
						<span class="symbol symbol-40px">
							<span class="symbol-label bg-info-subtle">
								<i class="ki-duotone ki-pulse text-info fs-3"><span class="path1"></span><span class="path2"></span></i>
							</span>
						</span>
						<div class="d-flex flex-column">
							<span class="fw-bold text-gray-800 fs-7"><fmt:formatNumber type="number" pattern="#.##" value="${leave_3}"/></span>
							<span class="text-gray-500" style="font-size:11px;">${type_3}</span>
						</div>
					</div>
					<div class="d-flex align-items-center gap-2" style="white-space:nowrap;">
						<span class="symbol symbol-40px">
							<span class="symbol-label bg-warning-subtle">
								<i class="ki-duotone ki-timer text-warning fs-3"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i>
							</span>
						</span>
						<div class="d-flex flex-column">
							<span class="fw-bold text-gray-800 fs-7">
								<fmt:formatNumber type="number" pattern="#.##" value="${leave_6}"/>
								<c:if test="${quota_4.doubleValue() > 0}">/<fmt:formatNumber type="number" pattern="#.##" value="${quota_4}"/></c:if>
							</span>
							<span class="text-gray-500" style="font-size:11px;">${type_6}</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div> -->

	<!--begin::Leave form card-->
	<div class="card card-flush mb-7">
		<div class="card-body pt-6 pb-7">
	<form method="post" id="formid" class="form-horizontal" action="line_new_LeaveEdit_Do" enctype="multipart/form-data">

		<!-- Status: hidden per request (no longer shown in FE UI). status_hidden stays live outside
		     the comment — the halfDay handler reads it directly ($('#status_hidden').val() != '0')
		     to know whether an Edit-mode leave is still editable. -->
		<!-- <div class="d-flex justify-content-end mb-3">
			<select class="form-select liff-status-select" id="status" name="status" disabled required>
				<option value="0">Wait for approve</option>
				<option value="1">Approved</option>
				<option value="2">Reject</option>
				<option value="3">Cancel</option>
			</select>
		</div> -->
		<input type="hidden" name="status_hidden" id="status_hidden">

		<!-- Next Year Leave: hidden per request (no longer shown in FE UI). Safe to fully remove from
		     the DOM — nothing reads $('#nextYearLeave')'s value elsewhere; the unconditional
		     $('#nextYearLeave').trigger('change') on init just no-ops when the element doesn't exist,
		     and date_from/date_to still get their daterangepicker via the separate init block below. -->
		<!-- <div class="mb-6" id="nextYearLeaveContainer">
			<div class="form-check form-check-custom form-check-solid">
				<input class="form-check-input me-3" type="checkbox" id="nextYearLeave" name="nextYearLeave" value="1" />
				<label class="form-check-label" for="nextYearLeave">
					<div class="fw-bold fs-6 text-primary">เลือกวันลาปีหน้า</div>
				</label>
			</div>
		</div> -->

		<!-- DDL User: visually hidden per request (not shown in FE UI). Kept in the DOM (not commented
		     out) because userOnChange() reads $('#user').val()/.find(":selected") directly, and it
		     always runs once on page load (via the nextYearLeave init below) even outside the admin
		     on-behalf flow — removing the element from the DOM broke that with a JS error. -->
		<div class="mb-6" style="position:absolute; width:1px; height:1px; overflow:hidden; clip:rect(0 0 0 0); white-space:nowrap;">
			<select id="user" name="user" class="form-select liff-input-underline" onchange="userOnChange()" disabled required>
				<option></option>
				<optgroup id='u_enable' label="Enable"></optgroup>
				<optgroup id='u_disable' label="Disable"></optgroup>
			</select>
		</div>
		<input hidden name="user_hidden" id="user_hidden" type="text">
		<input hidden name="leaveId_hidden" id="leaveId_hidden" type="text">

		<!-- Type of leave: shown as a dropdown; mirrors the legacy hidden radio group below -->
		<div class="liff-field-row mb-6">
			<label class="liff-field-label" for="leaveTypeSelect">Type of leave <span class="text-danger">*</span></label>
			<select class="form-select liff-field-value liff-field-dropdown" id="leaveTypeSelect" required></select>
		</div>
		<div id="leaveTypes" class="row g-3 fs-7" aria-hidden="true">
			<!-- Loop Leave Type Javascript (legacy, kept for quota-disable + validation + leaveId=6 date logic) -->
		</div>

		<!-- Date range & half-day -->
		<div class="liff-field-row mb-3">
			<label class="liff-field-label" for="date_from">Start Date <span class="text-danger">*</span></label>
			<div class="input-group date date-picker input-daterange liff-field-grow" data-provide="datepicker" data-date-format="dd M yyyy">
				<input type="text" class="form-control liff-field-value" id="date_from" name="from" autocomplete="off" placeholder="DD/MM/YYYY" required>
				<input class="hide" name="from_hidden" id="date_from_hidden" type="text" hidden>
			</div>
			<i class="ki-duotone ki-calendar fs-4 text-gray-500"><span class="path1"></span><span class="path2"></span></i>
		</div>

		<div class="liff-field-row mb-3">
			<label class="liff-field-label" for="date_to">End Date <span class="text-danger">*</span></label>
			<div class="input-group date date-picker input-daterange liff-field-grow" data-provide="datepicker" data-date-format="dd M yyyy">
				<input type="text" class="form-control liff-field-value" id="date_to" name="to" autocomplete="off" placeholder="DD/MM/YYYY" required>
				<input class="hide" name="to_hidden" id="date_to_hidden" type="text" hidden>
			</div>
			<i class="ki-duotone ki-calendar fs-4 text-gray-500"><span class="path1"></span><span class="path2"></span></i>
		</div>

		<div class="liff-field-row mb-6">
			<label class="liff-field-label" for="halfDay">ช่วงเวลาในการลา <span class="text-danger">*</span></label>
			<select class="form-select liff-field-value liff-field-dropdown input-daterange" id="halfDay" name="halfDay" required>
				<option value="0" selected>เต็มวัน</option>
				<option value="1">ช่วงเช้า</option>
				<option value="2">ช่วงบ่าย</option>
				<option value="3">กำหนดเวลาเอง</option>
			</select>
		</div>

		<div class="liff-field-row mb-3">
			<label class="liff-field-label" for="time_from">Start Time <span class="text-danger">*</span></label>
			<input type="text" class="form-control liff-field-value liff-field-dropdown timepicker timepicker-24 checkHours" id="time_from" name="time_from" autocomplete="off" required disabled>
			<input class="hide" id="time_from_hidden" name="time_from_hidden" hidden>
		</div>
		<div class="liff-field-row mb-3">
			<label class="liff-field-label" for="time_to">End Time <span class="text-danger">*</span></label>
			<input type="text" class="form-control liff-field-value liff-field-dropdown timepicker timepicker-24 checkHours" id="time_to" name="time_to" autocomplete="off" required disabled>
			<input class="hide" id="time_to_hidden" name="time_to_hidden" hidden>
		</div>
		<div class="form-text text-danger mb-3" id="alert_time_to"></div>

		<div class="liff-field-row mb-6">
			<label class="liff-field-label">Day</label>
			<div class="liff-day-badges">
				<span class="liff-day-badge" id="amountDisplayDay">0D</span>
				<span class="liff-day-badge" id="amountDisplayHour">0H</span>
			</div>
			<!-- real values the legacy scripts read/write; kept in the DOM but not shown (mirrored into the two badges above) -->
			<input type="text" id="amount" name="amount" class="checkHours" hidden>
			<input id="amount_hidden" name="amount_hidden" hidden>
			<input type="text" id="amount_sub" name="amount_sub" class="checkHours" value="0" hidden>
			<input value="0" id="amount_sub_hidden" name="amount_sub_hidden" hidden>
		</div>

		<!-- Description -->
		<div class="mb-6">
			<label class="form-label required fs-6">Description</label>
			<textarea class="form-control liff-input-underline" style="word-break: break-all; white-space: normal;" maxlength="1024"
				name="description" id="description" rows="3" placeholder="Enter a reason." required></textarea>
			<input hidden class="hide" name="description_hidden" id="description_hidden" type="text">
			<div class="text-danger mt-2 fs-8">กรุณาระบุเหตุผลในการลา ตัวอย่าง ลางานเนื่องจากท้องเสีย</div>
		</div>

		<!-- File Upload -->
		<div class="liff-field-row mb-3" id="fileUploadSection">
			<label class="liff-field-label" for="myFile" id="fileUploadLabel">Attach files</label>
			<label for="myFile" id="lbFile" class="liff-upload-badge">
				<i class="ki-duotone ki-file-up fs-7"><span class="path1"></span><span class="path2"></span></i>
				Upload
				<input type="file" id="myFile" name="fileUpload" style="display:none;" accept="image/*,application/pdf,application/zip" multiple>
			</label>
			<input type="hidden" name="deleteFileId" id="deleteFileId">
			<input type="hidden" name="fileUploadSize" value="${size}" id="size">
			<input type="hidden" name="fileUploadId" id="fileUploadId">
		</div>
		<div class="form-text text-danger mb-3" id="alert_evidence"></div>
		<div id="filePreviewContainer" class="d-flex flex-wrap gap-2 mb-3"></div>

		<div class="mb-6" id="exitingFileSection">
			<div id="exitingFilePreviewContainer" class="d-flex flex-wrap gap-2 mt-2"></div>
			<div class="liff-field-row mb-3" id="afterFileRow">
				<label class="liff-field-label" for="afterFile">Attach files</label>
				<label for="afterFile" id="lbafterFile" class="liff-upload-badge">
					<i class="ki-duotone ki-file-up fs-7"><span class="path1"></span><span class="path2"></span></i>
					Upload
					<input type="file" id="afterFile" name="afterFileUpload" style="display:none;" accept="image/*,application/pdf" onchange="previewAfterFile(this)">
				</label>
			</div>
			<div id="modalFilePreviewName" class="text-muted fs-6 mt-2"></div>
		</div>

		<!-- Approver -->
		<div class="liff-field-row mb-10">
			<label class="liff-field-label" for="approver">Approvers <span class="text-danger">*</span></label>
			<select id="approver" name="approver" class="form-select liff-field-value liff-field-dropdown" required>
				<option value="admin">แอดมิน</option>
			</select>
			<input hidden name="approver_hidden" id="approver_hidden" type="text">
		</div>

		<!-- Buttons -->
		<div class="liff-submit-bar">
			<button type="button" class="btn btn-light" onclick="window.history.go(-1); return false;">Cancel</button>
			<button type="button" class="btn btn-success" id="submitBtn" onclick="beforeSubmit();">Submit</button>
			<button type="button" class="btn btn-success d-none" id="afterFileSubmitBtn" onclick="submitAfterFile();">Submit</button>
		</div>

	</form>
		</div>
	</div>
	<!--end::Leave form card-->

	<!-- Request/Approve-by info: hidden per request (no longer shown in FE UI). -->
	<!-- <div class="py-6" id="infoBlock">
		<div class="fs-8 text-gray-500" id="requestInfo">
			Request By : <span id="ucEmpId"></span> <span id="ucName"></span> , <span id="timeCreate"></span>
		</div>
		<div class="fs-8 text-gray-500" id="approveInfo">
			Approved By : <span id="aprEmpId"></span> <span id="aprName"></span> - <span id="aprRole"></span> , <span id="timeUpdate"></span>
		</div>
	</div> -->

</div>

<script>
/* ---------- dropdown ประเภทการลา + badge วัน/ชั่วโมง ---------- */
/* Mirrors the legacy #leaveTypes radio group (generated dynamically by the untouched script
   further down) into a proper dropdown (#leaveTypeSelect). Two-way synced so quota-disable
   (userOnChange ajax), edit-mode prefill, and the leaveId=6 date logic all keep working
   unmodified — this script never edits their behavior, only mirrors state. */
(function () {
	var $select = null;
	var syncing = false;

	function labelTextFor(radio) {
		// legacy markup is "<input .../>Label text" inside .form-check — grab the trailing text node
		var text = '';
		var node = radio.nextSibling;
		while (node) {
			if (node.nodeType === 3) text += node.textContent;
			node = node.nextSibling;
		}
		return text.trim();
	}

	function rebuildOptions() {
		if (!$select) return;
		var radios = document.querySelectorAll('#leaveTypes input[name="leaveType"]');
		var current = $select.value;
		$select.innerHTML = '<option value="" disabled ' + (current ? '' : 'selected') + '>เลือกประเภทการลา</option>';
		radios.forEach(function (radio) {
			var opt = document.createElement('option');
			opt.value = radio.value;
			opt.textContent = labelTextFor(radio) || radio.value;
			opt.disabled = radio.disabled;
			if (radio.checked) opt.selected = true;
			$select.appendChild(opt);
		});
	}

	function onSelectChange() {
		if (syncing) return;
		var radio = document.getElementById('lt_' + $select.value);
		if (!radio) return;
		syncing = true;
		radio.checked = true;
		$(radio).trigger('change');
		syncing = false;
	}

	document.addEventListener('DOMContentLoaded', function () {
		$select = document.getElementById('leaveTypeSelect');
		var container = document.getElementById('leaveTypes');
		if (!$select || !container) return;
		$select.addEventListener('change', onSelectChange);

		// The legacy scripts set .checked/.disabled as JS properties (not attributes), which a
		// MutationObserver can't see — so re-sync on radio creation (observable) AND on a short
		// stagger to catch the edit-mode "checked" set + the quota-disable ajax response, both of
		// which run as separate synchronous/async steps right after the radios are created.
		new MutationObserver(rebuildOptions).observe(container, { childList: true, subtree: true });
		[0, 150, 400, 900, 1600].forEach(function (ms) { setTimeout(rebuildOptions, ms); });

		// Admin "on behalf" flow (la=1): userOnChange() re-checks quota via ajax when #user changes.
		var userSelect = document.getElementById('user');
		if (userSelect) userSelect.addEventListener('change', function () { setTimeout(rebuildOptions, 900); });
	});
})();

/* "0D" / "0H" badges reading #amount (day) / #amount_sub (hour), which the legacy scripts set via
   plain .val() in several places (date range calc, half-day switch, checkHours handler, edit-mode
   init) without dispatching an event — so poll instead of trying to hook every call site. */
(function () {
	var lastDay = null, lastHour = null;
	function tick() {
		var dayEl = document.getElementById('amount');
		var hourEl = document.getElementById('amount_sub');
		var dayBadge = document.getElementById('amountDisplayDay');
		var hourBadge = document.getElementById('amountDisplayHour');
		if (!dayEl || !hourEl || !dayBadge || !hourBadge) return;
		var day = dayEl.value || '0';
		var hour = hourEl.value || '0';
		if (day !== lastDay || hour !== lastHour) {
			lastDay = day; lastHour = hour;
			dayBadge.textContent = day + 'D';
			hourBadge.textContent = hour + 'H';
		}
	}
	document.addEventListener('DOMContentLoaded', function () {
		tick();
		setInterval(tick, 250);
	});
})();

function liffMountSelectDropdown(selectEl) {
	if (!selectEl || selectEl.dataset.liffMounted) return;
	selectEl.dataset.liffMounted = '1';

	selectEl.classList.add('liff-select-hidden');

	var wrap = document.createElement('div');
	wrap.className = 'liff-select-dropdown';
	selectEl.parentNode.insertBefore(wrap, selectEl);
	wrap.appendChild(selectEl);

	var triggerClass = selectEl.className.replace('liff-select-hidden', '').trim();
	var btn = document.createElement('button');
	btn.type = 'button';
	btn.className = (triggerClass + ' liff-dropdown-trigger').trim();
	wrap.appendChild(btn);

	var menu = document.createElement('ul');
	menu.className = 'liff-dropdown-menu';
	wrap.appendChild(menu);

	function closeMenu() { wrap.classList.remove('liff-dropdown-open'); }
	function openMenu() {
		document.querySelectorAll('.liff-select-dropdown.liff-dropdown-open').forEach(function (el) {
			if (el !== wrap) el.classList.remove('liff-dropdown-open');
		});
		wrap.classList.add('liff-dropdown-open');
	}

	btn.addEventListener('click', function (e) {
		e.stopPropagation();
		if (btn.disabled) return;
		if (wrap.classList.contains('liff-dropdown-open')) closeMenu(); else openMenu();
	});
	document.addEventListener('click', function (e) {
		if (!wrap.contains(e.target)) closeMenu();
	});

	function sync() {
		var opts = selectEl.options;
		menu.innerHTML = '';
		var seenValues = {}; // legacy population code can append the same value more than once
		                      // (e.g. approver: once from the static markup, once from the user
		                      // list loop, once from the AJAX response) — only show it once, or
		                      // clicking a later duplicate looks like it does nothing (the select
		                      // just re-lands on whichever matching option came first).
		for (var i = 0; i < opts.length; i++) {
			(function (opt) {
				if (opt.value === '') return; // skip placeholder options
				if (Object.prototype.hasOwnProperty.call(seenValues, opt.value)) return;
				seenValues[opt.value] = true;
				var li = document.createElement('li');
				// plain <button>, not <a href="javascript:void(0)"> — this runs inside the LINE
				// in-app webview, which can be finicky about javascript: URIs; a button has no
				// navigation semantics to fight with at all.
				var a = document.createElement('button');
				a.type = 'button';
				a.className = 'dropdown-item' + (opt.selected ? ' active' : '') + (opt.disabled ? ' disabled' : '');
				a.textContent = opt.textContent;
				a.disabled = !!opt.disabled;
				if (!opt.disabled) {
					a.addEventListener('click', function (e) {
						e.preventDefault();
						e.stopPropagation();
						selectEl.value = opt.value;
						selectEl.dispatchEvent(new Event('change', { bubbles: true }));
						closeMenu();
					});
				}
				li.appendChild(a);
				menu.appendChild(li);
			})(opts[i]);
		}
		var selectedOpt = selectEl.options[selectEl.selectedIndex];
		btn.textContent = selectedOpt ? selectedOpt.textContent : '';
		btn.disabled = selectEl.disabled;
	}

	sync();
	$(selectEl).on('change', sync);
	new MutationObserver(sync).observe(selectEl, { childList: true, subtree: true, attributes: true, attributeFilter: ['disabled'] });
}

document.addEventListener('DOMContentLoaded', function () {
	['leaveTypeSelect', 'halfDay', 'approver'].forEach(function (id) {
		liffMountSelectDropdown(document.getElementById(id));
	});
});
</script>

<script>
/* ---------- halfDay: เต็มวัน / ครึ่งเช้า / ครึ่งบ่าย / ชั่วโมง ---------- */
var action = '${empty action ? "" : action}';
$(document).ready(initHalfDay);

function initHalfDay() {
	$('#halfDay').on('change', function () {
		if (action == 'Edit' && $('#status_hidden').val() != '0') return;
		if (this.value == 3) {
			document.getElementById('time_from').disabled = false;
			document.getElementById('time_to').disabled = false;
			document.getElementById('date_to').disabled = true;
			if (action == 'Add') {
				document.getElementById('time_from').value = "9:00";
				document.getElementById('time_to').value = "";
			}
			$('#amount').val(0);
			$('#amount_sub').val(0);
			$('#amount_hidden').val(0);
			$('#amount_sub_hidden').val(0);
		} else if (this.value == 0) {
			document.getElementById('time_from').disabled = true;
			document.getElementById('time_to').disabled = true;
			document.getElementById('date_to').disabled = false;
			document.getElementById('time_from').value = "9:00";
			document.getElementById('time_to').value = "18:00";
			$('#amount_sub').val(0);
			$('#amount_sub_hidden').val(0);
			$('#alert_time_to').text('')
		} else if (this.value == 1) {
			document.getElementById('time_from').disabled = true;
			document.getElementById('time_to').disabled = true;
			document.getElementById('date_to').disabled = true;
			document.getElementById('time_from').value = "8:00";
			document.getElementById('time_to').value = "12:00";
			$('#amount_sub').val(4);
			$('#amount_sub_hidden').val(4);
			$('#alert_time_to').text('')
		} else if (this.value == 2) {
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
}
</script>

<script>
/* ---------- date helpers ---------- */
var toISODate = (date) => {
	return date.substring(3, 6) + "-" + date.substring(0, 2) + "-" + date.substring(7, 11);
}
var toISODate2 = (date) => {
	return date.substring(3, 5) + "-" + date.substring(0, 2) + "-" + date.substring(6, 10);
}
var toTimestamp = (date) => {
	return Date.parse(toISODate(date));
}
var toTimestamp2 = (date) => {
	return Date.parse(toISODate2(date));
}
var toDisplayDate = (date) => {
	return date.toLocaleDateString('en-GB').replace('/', '-').replace("/", '-');
}
</script>

<!-- Start leaveType Radio -->
<c:if test="${leaveType != null}">
<script>
/* ---------- ประเภทการลา ---------- */
$(initLeaveTypeRadios);

function initLeaveTypeRadios() {
	var leaveTypes;
	leaveTypes = JSON.parse('${leaveType}');
	let leaveCheck = [${leave1Check},${leave2Check},${leave3Check},'','',${leave6Check}];
	for (let i = 0; i < leaveTypes.length; i++) {
		if (leaveTypes[i].id == '1' || leaveTypes[i].id == '2' || leaveTypes[i].id == '3' || leaveTypes[i].id == '6') {
			if (leaveTypes[i].id == '6') {
				if (leaveCheck[i] == '1') {
					let radio =	'<div class="col-6 col-sm-6 col-md-3" id="label_lt_6"><div class="form-check form-check-custom form-check-solid mb-3">'
					+'<input class="form-check-input me-3" type="radio" name="leaveType" id="lt_'+leaveTypes[i].id+'" value="'+leaveTypes[i].id+'" disabled required>'+leaveTypes[i].name
					+'</div></div>'
					+'<input type="hidden" class="hide" name="leaveType_hidden" id="lt_hidden">';
					$('#leaveTypes').addClass('row g-6').append(radio);
				} else {
					let radio =	'<div class="col-6 col-sm-6 col-md-3" id="label_lt_6"><div class="form-check form-check-custom form-check-solid mb-3">'
						+'<input class="form-check-input me-3" type="radio" name="leaveType" id="lt_'+leaveTypes[i].id+'" value="'+leaveTypes[i].id+'" required>'+leaveTypes[i].name
						+'</div></div>'
						+'<input type="hidden" class="hide" name="leaveType_hidden" id="lt_hidden">';
					$('#leaveTypes').addClass('row g-6').append(radio);
				}
			} else {
				if (leaveCheck[i] == '1') {
					let radio =	'<div class="col-6 col-sm-6 col-md-3"><div class="form-check form-check-custom form-check-solid mb-3">'
						+'<input class="form-check-input me-3" type="radio" name="leaveType" id="lt_'+leaveTypes[i].id+'" value="'+leaveTypes[i].id+'" disabled required>'+leaveTypes[i].name
						+'</div></div>'
						+'<input type="hidden" class="hide" name="leaveType_hidden" id="lt_hidden">';
					$('#leaveTypes').addClass('row g-6').append(radio);
				} else {
					let radio =	'<div class="col-6 col-sm-6 col-md-3"><div class="form-check form-check-custom form-check-solid mb-3">'
						+'<input class="form-check-input me-3" type="radio" name="leaveType" id="lt_'+leaveTypes[i].id+'" value="'+leaveTypes[i].id+'" required>'+leaveTypes[i].name
						+'</div></div>'
						+'<input type="hidden" class="hide" name="leaveType_hidden" id="lt_hidden">';
					$('#leaveTypes').addClass('row g-6').append(radio);
				}
			}
		} else if (leaveTypes[i].id == '5') {
			// Leave w/o pay can be created by user who has 'leave.approve'
			<perm:permission object="leave.approve">
				let radio =	'<div class="col-6 col-sm-6 col-md-3"><div class="form-check form-check-custom form-check-solid mb-3">'
					+'<input class="form-check-input me-3" type="radio" name="leaveType" id="lt_'+leaveTypes[i].id+'" value="'+leaveTypes[i].id+'" required>'+leaveTypes[i].name
					+'</div></div>'
					+'<input type="hidden" class="hide" name="leaveType_hidden" id="lt_hidden">';
			$('#leaveTypes').addClass('row g-6').append(radio);
			</perm:permission>
		} else if (leaveTypes[i].id != '9') {
			let radio =	'<div class="col-6 col-sm-6 col-md-3"><div class="form-check form-check-custom form-check-solid mb-3">'
				+'<input class="form-check-input me-3" type="radio" name="leaveType" id="lt_'+leaveTypes[i].id+'" value="'+leaveTypes[i].id+'" required>'+leaveTypes[i].name
				+'</div></div>'
				+'<input type="hidden" class="hide" name="leaveType_hidden" id="lt_hidden">';
			$('#leaveTypes').addClass('row g-6').append(radio);
		}
	}


	// NEW LOGIC: Always render leave ID 6 and control visibility by month/checkbox logic
	const d = new Date();
	let month = d.getMonth(); // 0 = Jan
	//month = 0;//for test display "ลาพักร้อนที่เหลือจากปีก่อน"
	//month = 10;//for test hide "ลาพักร้อนที่เหลือจากปีก่อน"

	const leave6Container = $('#label_lt_6'); //ลาพักร้อนที่เหลือจากปีก่อน
	if (leave6Container.length) { // validate #label_lt_6
		if (month <= 2) { // if Jan, Feb, Mar : display "ลาพักร้อนที่เหลือจากปีก่อน"
			leave6Container.show();
		} else {
			leave6Container.hide();
			$('#lt_6').prop('checked', false);
		}
	}
	// END NEW LOGIC: Always render leave ID 6 and control visibility by month/checkbox logic

	$('input:radio[name="leaveType"]').change(function () {
		if ($(this).val() == '6') {
			let lastday = '${lastday}';
			let lastday_ts = toTimestamp(lastday);
			let selectedDateTo = $('#date_to').val();
			let selectedDateTo_ts = toTimestamp(selectedDateTo);
			$('#date_to').datepicker('setEndDate', lastday);
			if (selectedDateTo_ts > lastday_ts) {
				$('#date_to').val(lastday);
			} else {
				$('#date_to').datepicker('setEndDate', '');
			}
		}
	});
}
</script>
</c:if>
<!-- End leaveType Radio -->

<c:if test="${leave == null}">
	<c:set var="leave" value="''" />
</c:if>
<c:if test="${fileLeave == null}">
	<c:set var="fileLeave" value="''" />
</c:if>
<c:if test="${fileLeaveList == null}">
	<c:set var="fileLeaveList" value="[]" />
</c:if>

<script>
/* ---------- Add / Edit leave form ---------- */
$(() => {
	var userList = ${userList};
	var action = '${action}';
	var user;
	var manager;
	var leave;
	var fileLeave;
	var leaveInfo;
	const queryString = window.location.search;
	const urlParams = new URLSearchParams(queryString);
	const la = urlParams.get('la');

	initFormMode();
	initDefaultDate();
	initLeaveAmount();
	initUserApprover();
	initEditValues();
	initNextYearLeave();

	// ตั้งค่าฟอร์มตามโหมด Add / Edit
	function initFormMode() {
		if (action == 'Edit') {
			initEditMode();
		} else {
			initAddMode();
		}
		user = user.toLowerCase();
		manager = manager.toLowerCase();
	}

	// Edit: โหลดใบลาเดิม
	function initEditMode() {
		leave = ${leave};
		fileLeave = ${fileLeave};
		leaveInfo = ${empty leaveInfo ? '[]' : leaveInfo};
		user = leave.userId;
		manager = leave.apprUserId;
		department = leave.leaveStatusId.toString();

		if (la == '1') {
			$('form').attr('action','line_new_LeaveEdit_Do_LA');
			<perm:permission object="leave.approve">
				document.getElementById('status').disabled = false;
			</perm:permission>
		} else {
			$('form').attr('action', 'line_new_LeaveEdit_Do');
		}

		// ข้อมูลผู้ขอ / ผู้อนุมัติ
		var aprEmpId;
		var aprName;
        var apprUserId;
        var aprRole;
        var ucEmpId;
        var ucName;
        var timeCreate;
        var timeUpdate;
		if (leaveInfo && leaveInfo.length > 0) {
			
			aprEmpId = leaveInfo[0].apr_emp_id;
			aprName = leaveInfo[0].apr_name;
	        apprUserId = leaveInfo[0].appr_user_id;
	        aprRole = leaveInfo[0].apr_role;
	        ucEmpId = leaveInfo[0].uc_emp_id;
	        ucName = leaveInfo[0].uc_name;
	        timeCreate = moment(leaveInfo[0].time_create).format("DD MMM YYYY HH:mm");
	        timeUpdate = moment(leaveInfo[0].time_update).format("DD MMM YYYY HH:mm");
		}
		// สถานะใบลา: 0 Wait for approve / 1 Approved / 2 Reject / 3 Cancel
		if (leave.leaveStatusId.toString() != '0') {
			initEditReadOnly();
		}
		// Wait for approve แก้ข้อมูลได้
		else if(leave.leaveStatusId.toString() == '0'){
			initEditPending();
		}
		
		$('#leaveId').text('${leaveId}');

		function initEditReadOnly() {
			// ล็อกทุกช่อง
		    $('input[name="leaveType"]').prop('disabled', true);
			$('#status, #date_from, #date_to, #halfDay, #description, #myFile, #removeFileBtn, #approver, #submitBtn').prop('disabled', true);
		    $('input[name="leaveType"]').closest('.form-check').css('pointer-events', 'none').css('opacity', '0.6');
			$('#leaveTypeSelect').prop('disabled', true);
			$('#leaveidInfo').show();
			$('#requestInfo').show();
		    $('#approveInfo').show();
		    
		    // ไฟล์เดิมแสดงแบบดูอย่างเดียว + ซ่อนปุ่ม Submit
		    $('#fileUploadSection').addClass('d-none');
			$('#filePreviewContainer').addClass('d-none'); // อยู่นอก #fileUploadSection ต้องซ่อนเอง
			$('#exitingFileSection').addClass('d-block');
			lfLoadExisting(${fileLeaveList});
			lfRenderExistingReadonly('exitingFilePreviewContainer');
		    $('#submitBtn').addClass('d-none');

		    // แนบไฟล์หลังอนุมัติ (#afterFileRow): มีเฉพาะ Approved เลือกไฟล์แล้วกด Submit ถึงส่ง
		    if (leave.leaveStatusId.toString() != '1') {
		    	$('#afterFileRow').addClass('d-none');
		    }
		    
		    $('#aprEmpId').text(aprEmpId);
	        $('#aprName').text(aprName);
	        $('#aprRole').text(aprRole);
	        $('#timeUpdate').text(timeUpdate);
	        
	        $('#ucEmpId').text(ucEmpId);
	        $('#ucName').text(ucName);
	        $('#timeCreate').text(timeCreate);
		}

		function initEditPending() {
			$('#leaveidInfo').show();
			$('#requestInfo').show();
		    $('#approveInfo').hide();
		    // แนบไฟล์ด้วย #fileUploadSection (เพิ่ม/ลบได้ ส่งตอนกด Submit) ซ่อน #afterFileRow
		    $('#afterFileRow').hide();
			$('#fileUploadSection').removeClass('d-none');
			$('#exitingFileSection').addClass('d-none');
			lfLoadExisting(${fileLeaveList});
			lfRenderAll();
			$('#ucEmpId').text(ucEmpId);
	        $('#ucName').text(ucName);
	        $('#timeCreate').text(timeCreate);
		}
	}

	// Add: ใบลาใหม่
	function initAddMode() {
		user = "${onlineUser.id}";
		manager = "${onlineUser.managerId}";
		if (la == '1') {
			$('form').attr('action', 'new_LeaveAdd_Do_LA');
		} else {
			$('form').attr('action', 'line_new_LeaveAdd_Do');
		}
		$('#leaveidInfo').hide();
		$('#requestInfo').hide();
		$('#approveInfo').hide();
		$('#afterFileRow').hide(); // แนบไฟล์หลังอนุมัติ ใช้เฉพาะ Approved
		
		if (la == '1') {
			<perm:permission object="leave.viewall">
				document.getElementById('user').disabled = false;
			</perm:permission>

		}
	}

	// วันที่เริ่มต้น (มาจากปฏิทินลา)
	function initDefaultDate() {
		/* Date from leave calendar */
		$('#date_from').val('${date}');
		$('#date_to').val('${date}');
		$('#amount').val(1);
	}

	// คำนวณจำนวนวัน / ชั่วโมงที่ลา
	function initLeaveAmount() {
		/* Start amount of day from Add Leave */
		var holiday;
		var holidays = [];
		holiday = JSON.parse('${holiday}');

		for (let i = 0; i < holiday.length; i++) {
			let start = new Date(holiday[i].start);
			let end = new Date(holiday[i].end);
			for (let j = start; j <= end; j.setDate(j.getDate() + 1)) {
				holidays.push(toDisplayDate(j));
			}
		}

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

		dateFrom.addEventListener("change.td", function () {
			$(dateRangeDiv).trigger("change");
		});
		dateTo.addEventListener("change.td", function () {
			$(dateRangeDiv).trigger("change");
		});

		$('.input-daterange').on('change', handleDateChange);

		$('.checkHours').change(function () {
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
			} else if (hourDiff > 0 && hourDiff < 8) {
				$('#time_to').css('color', 'black');
				$('#alert_time_to').text('');
			} else if (hourDiff >= 8) {
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

			updateLeaveDisplay();

		});

		function updateLeaveDisplay() {
			const day = parseFloat($('#amount').val()) || 0;
			const hour = parseFloat($('#amount_sub').val()) || 0;
			const total = day + (hour / 8); // 8 ชม. = 1 วัน
			$('#amount_display').text(`${total.toFixed(2)} day`);
		}

		$('.input-daterange').on('change', updateLeaveDisplay);

		/* End amount of day from Add Leave */
	}

	// รายชื่อผู้ลา / ผู้อนุมัติ
	function initUserApprover() {
		/* Start Applicant/Approver List */
		for (let i = 0; i < userList.length; i++) {
			let id = userList[i].id.toLowerCase();
			let name = userList[i].name;
			let name_en = userList[i].name_en;
			let employee_id = userList[i].employee_id;
			let status = userList[i].enable;
			userList = ${userList};
			
			userList.sort(function(a, b){

			    if(a.employee_id && b.employee_id){
			        let empCompare = a.employee_id.localeCompare(b.employee_id);
			        if(empCompare !== 0) return empCompare;
			    }

			    if(a.employee_id) return -1;
			    if(b.employee_id) return 1;

			    if(a.name_en && b.name_en){
			        let nameEnCompare = a.name_en.localeCompare(b.name_en);
			        if(nameEnCompare !== 0) return nameEnCompare;
			    }

			    if(a.name_en) return -1;
			    if(b.name_en) return 1;

			    return (a.name || "").localeCompare(b.name || "");
			});
			
			let displayText = '';

			if (employee_id) {
				displayText += employee_id;
			}
			
			if (name_en) {
				if (displayText) displayText += ' - ';
				displayText += name_en;
			}
			
			if (name) {
				if (displayText) displayText += ' - ';
				displayText += name;
			}

			let option = '<option value="' + id + '">' + displayText + '</option>';

			if (status == '1') {
				$('#u_enable').append(option);
			} else {
				$('#u_disable').append(option);
			}
			if (id == manager) {
				$('#approver').append(option);
			}
		}
		$('#user').val(user);
		$('#user').trigger('change');
		$('#user_hidden').val(user);
		$('#status_hidden').val(0);
		$('#approver').val(manager);
		$('#approver').trigger('change');
		$('#user').change(() => {
			let val = $('#user').val();
			for (let i = 0; i < userList.length; i++) {
				let user = userList[i].id.toLowerCase();
				let mng = userList[i].manager;
				if (user == val) {
					$('#approver').val(mng.toLowerCase());
					$('#approver').trigger('change');
				}
			}
		});
		/* End Applicant/Approver List */
	}

	// เติมค่าจากใบลาเดิม (Edit)
	function initEditValues() {
		/* Start Leave Edit init */
		if (leave != null) {
			$('#user_hidden').val(leave.userCreate);
			$('#leaveId_hidden').val(leave.leaveId);
			$('#status_hidden').val(leave.leaveStatusId);
			var noDay = leave.noDay.toString().split(".");
			var amount = noDay[0];
			var amount_sub = (leave.noDay % 1) * 8;
			if (isNaN(amount_sub)) {
				amount_sub = 0;
			}
			var s_date = moment(leave.startDate, 'MMM D, Y').format('DD MMM YYYY');
			var e_date = moment(leave.endDate, 'MMM D, Y').format('DD MMM YYYY');
			$('#date_from').val(s_date);
			$('#date_to').val(e_date);
			if (leave.halfDay === '3') {
				$('#time_from').val(leave.startTime);
				$('#time_to').val(leave.endTime);
			}
			$('#amount').val(amount);
			$('#amount_hidden').val(amount);
			$('#amount_sub').val(amount_sub);
			$('#amount_sub_hidden').val(amount_sub);
			$('#description').val(leave.description);
			$('#status').val(leave.leaveStatusId).change();
			$('#lt_' + leave.leaveTypeId).prop('checked', 'checked');
			$('#halfDay').val(leave.halfDay).change();
			$('#approver').val(leave.apprUserId).change();
		}
		/* End Leave Edit init */
	}

	// checkbox ลาปีหน้า
	function initNextYearLeave() {
		const qThisYear = '${quotaThisYear}';


		// begin checkbox ลาปีหน้า ==============================================================
		// display hide checkbox ลาปีหน้า
		const currentMonth = new Date().getMonth(); // JavaScript: 0 = ม.ค. ถึง 11 = ธ.ค.

		const $nextYearCheckboxContainer = $('#nextYearLeaveContainer');

		// display only month nov or dec : nov=10,dec=11
		if (currentMonth === 10 || currentMonth === 11) {
			$nextYearCheckboxContainer.show();
		} else {
			$nextYearCheckboxContainer.hide();
			// if hide checkbox = false
			$('#nextYearLeave').prop('checked', false); // if nextYearLeave = hide : uncheck nextYearLeave
		}
		// display hide checkbox ลาปีหน้า

		function updateDatePickerRange(isNextYear) {
			var currentYear = new Date().getFullYear();
			var targetYear = isNextYear ? (currentYear + 1) : currentYear;

			var startDate = '01 Jan ' + targetYear;
			var endDate = '31 Dec ' + targetYear;

			var $inputs = $('#date_from, #date_to');

			// ล้างค่าที่เลือกไว้เดิม เพื่อให้ User เลือกใหม่ในช่วงปีที่ถูกต้อง
			var action = '${empty action ? "" : action}';
			if (action === 'Add') {
				$inputs.val('');
				$('#date_from_hidden, #date_from, #date_to, #date_to_hidden').val('');
			}

			$inputs.daterangepicker({
				singleDatePicker: true,
				showDropdowns: true,
				autoUpdateInput: false,
				autoApply: true,
				minDate: startDate,
				maxDate: endDate,
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

			// for fix : autoUpdateInput: false,
			$inputs.on('apply.daterangepicker', function (ev, picker) {
				$(this).val(picker.startDate.format('DD MMM YYYY'));

				var hiddenId = '#' + $(this).attr('id') + '_hidden';
				$(hiddenId).val(picker.startDate.format('DD-MM-YYYY'));

				$(this).trigger('change');
			});

			$inputs.on('cancel.daterangepicker', function (ev, picker) {
				$(this).val('');
				var hiddenId = '#' + $(this).attr('id') + '_hidden';
				$(hiddenId).val('');
			});

		}


		$('#nextYearLeave').on('change', function () {
			var isNextYear = $(this).is(':checked');
			updateDatePickerRange(isNextYear);
			const leave6Container = $('#label_lt_6');

			const leaveTypeRadios = $('input:radio[name="leaveType"]');

			var action = '${empty action ? "" : action}';
			if (action !== 'Edit') {
				leaveTypeRadios.prop('checked', false); // nextYearLeave onChange : uncheck radio leave type
			}

			$('#lt_hidden').val('');
			if (isNextYear) {
				leaveTypeRadios.prop('disabled', false); // if nextYearLeave = true : ignore quota : radio leave type = enable all

				// if nextYearLeave = true : display "ลาพักร้อนที่เหลือจากปีก่อน"
				if (leave6Container.length) {
					leave6Container.show();
				}

			} else {
				userOnChange();

				// if nextYearLeave = false : control visibility by month logic
				if (leave6Container.length) {
					const currentMonth = new Date().getMonth();
					if (currentMonth > 2) {
						leave6Container.hide();
						$('#lt_6').prop('checked', false);
					} else {
						leave6Container.show();
					}
				}
			}

		});

		$('#nextYearLeave').trigger('change');
		// end checkbox ลาปีหน้า ==============================================================
	}
});

function userOnChange() {

	var empId = $('#user').find(":selected").text().split(" ")[0];
	var userId = $('#user').val();

	$.ajax({
		url: "line_getManagerIdAndManagerName",
		method: "POST",
		type: "JSON",
		data: {
			"userId": userId
		},
		success: function (data) {
			var dataObj = JSON.parse(data);
			$("#approver option[value != 'admin']").remove();
			$('#approver').append(dataObj.option)
			$("#approver").val(dataObj.approverId).change();
		}
	})

	$.ajax({
		url: "line_getLeaveCheckStatusJson",
		method: "POST",
		type: "JSON",
		data: {
			"userId": userId
		},
		success: function (data) {
			const responseData = JSON.parse(data);
			const leaveStatus = responseData.leaveCheckStatus;

			for (const leaveTypeId in leaveStatus) {

				if (leaveStatus.hasOwnProperty(leaveTypeId)) {
					const isQuotaFull = leaveStatus[leaveTypeId];

					const elementId = "lt_" + leaveTypeId; //ref id leaveType Radio

					const targetElement = document.getElementById(elementId);
					if (targetElement) {
						if (isQuotaFull === true) {
							targetElement.disabled = true;
						} else {
							targetElement.disabled = false;
						}
					}
				}
			}
		}
	});

}
</script>

<script>
/* ---------- time picker ---------- */
document.addEventListener("DOMContentLoaded", initTimePickers);

function initTimePickers() {
	// Start Time picker
	const startTimePicker = new tempusDominus.TempusDominus(document.getElementById("time_from"), {
		display: {
			components: {
				calendar: false, // ไม่ต้องมีปฏิทิน
				clock: true, // แสดงนาฬิกา
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
}
</script>

<script>
/* ---------- submit ---------- */
var leaveSubmitting = false; // กันกดซ้ำ

// สำเร็จ = redirect ไปหน้า list (error/session หมด = หน้า login)
function isLeaveSaved(res) {
	return res.ok && res.redirected && res.url.indexOf('index.jsp') === -1;
}

function doSubmit() {
	if (leaveSubmitting) { return; }
	leaveSubmitting = true;

	var spinner = $('#liffLoadingOverlay');
	var form = $('#formid');
	if (typeof lfSyncInput === 'function') { lfSyncInput(); } // รวมไฟล์แนบเข้า #myFile
	spinner.css('display', 'flex');
	// field ที่ disabled ไม่ถูกส่ง เปิดชั่วคราว
	var disabledInputs = form.find(':input:disabled').prop('disabled', false);
	var formData = new FormData(form[0]);
	disabledInputs.prop('disabled', true);
	$('#submitBtn, #lbafterFile, #afterFileSubmitBtn').prop('disabled', true).addClass('disabled');

	fetch(form.attr('action'), { method: 'POST', body: formData })
		.then(function (res) {
			if (!isLeaveSaved(res)) { throw new Error('save failed'); }
			if (window.opener) {
				window.opener.location.reload();
			}
			var savedParam = (action == 'Add') ? 'saved=add' : 'saved=edit';
			var separator = (res.url.indexOf('?') === -1) ? '?' : '&';
			window.location.href = res.url + separator + savedParam;
		})
		.catch(function () {
			leaveSubmitting = false;
			spinner.css('display', 'none');
			$('#submitBtn, #lbafterFile, #afterFileSubmitBtn').prop('disabled', false).removeClass('disabled');
			liffToastError("Unable to submit your leave request. Please try again.", "Submit failed");
		});
}

// มีไฟล์แนบอยู่ไหม (pending ใหม่ + existing เดิมที่ยังไม่ถูกลบ)
function lfHasAnyFile() {
	if (typeof LeaveFiles === 'undefined') return false;
	var activeExisting = LeaveFiles.existing.filter(function (ex) {
		return LeaveFiles.deleted.indexOf(ex.fileId) === -1;
	}).length;
	return (LeaveFiles.pending.length + activeExisting) > 0;
}

function beforeSubmit() {
	if (leaveSubmitting) { return; } // กำลังส่งอยู่ ไม่ต้องทำอะไรเพิ่ม
	if (LeaveFiles.loading.length > 0) { return; } // ไฟล์ยังประมวลผลไม่เสร็จ disabled ปุ่มไว้
	var form = $('#formid');
	if (!form[0].reportValidity()) {
		return;
	}

	// เช็คชื่อ leave type
	var typeName = $('#leaveTypeSelect option:selected').text() || '';
	var isSickOrPersonal = (typeName.indexOf('ลาป่วย') !== -1 || typeName.indexOf('ลากิจ') !== -1);

	if (isSickOrPersonal && !lfHasAnyFile()) {
		// ลาป่วย/ลากิจ แต่ยังไม่มีไฟล์แนบ -> เตือนใต้แถวแนบไฟล์
		$('#alert_evidence').text('กรณีลากิจ และลาป่วย ต้องแนบไฟล์การขออนุมัติจากหัวหน้าทุกครั้ง');
		document.getElementById('fileUploadSection').scrollIntoView({ behavior: 'smooth', block: 'center' });
		return;
	}
	doSubmit();
}

// กด back กลับมาหน้านี้ให้โหลดใหม่
window.addEventListener('pageshow', function (e) {
	if (e.persisted) location.reload();
});
</script>

<script>
/* ---------- select ผู้ลา + date picker ---------- */
document.addEventListener("DOMContentLoaded", initSelectAndDatePickers);

function initSelectAndDatePickers() {
	$("#user").select2({
		allowClear: true,
		width: '100%'
	});

	//Start Date Picker
	$("#date_from").daterangepicker({
		singleDatePicker: true,
		showDropdowns: true,
		autoApply: true, // ยืนยันโดยอัตโนมัติเมื่อเลือกวันที่
		locale: {
			format: "DD MMM YYYY", // รูปแบบวันที่
			monthNames: [
				"January", "February", "March", "April", "May", "June",
				"July", "August", "September", "October", "November", "December"
			], // กำหนดชื่อเดือนเต็ม
		},
		drops: "down",
		theme: 'light', // ใช้ธีมแสง
	});

	// End Date Picker
	$("#date_to").daterangepicker({
		singleDatePicker: true,
		showDropdowns: true,
		autoApply: true, // ยืนยันโดยอัตโนมัติเมื่อเลือกวันที่
		locale: {
			format: "DD MMM YYYY", // รูปแบบวันที่
			monthNames: [
				"January", "February", "March", "April", "May", "June",
				"July", "August", "September", "October", "November", "December"
			], // กำหนดชื่อเดือนเต็ม
		},
		drops: "down",
		theme: 'light', // ใช้ธีมแสง
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
}
</script>

<script>
/* ---------- ไฟล์แนบ: preview / ลบไฟล์ ---------- */
function renderSingleFilePreview(fileName, fileUrl, isExisting = false, fileId = null, containerId = 'filePreviewContainer', fileInputId = 'myFile', disableTrash = false) {
	const container = document.getElementById(containerId) || document.getElementById('filePreviewContainer');
	if (!container) return;
	container.innerHTML = '';
	const fileExtension = fileName.split('.').pop().toLowerCase();

	// เลือกไอคอนตามนามสกุลไฟล์
	let iconClass = "fa-file";
	if (isExisting === true) {
		iconClass = "ki-duotone ki-file-up";
	} else if (fileExtension === "pdf") iconClass = "ki-duotone ki-file-pdf";
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
	removeBtn.id = 'removeFileBtn' + (containerId ? ('_' + containerId) : '');

	// Event Handler - pass container and input id to removal
	removeBtn.onclick = function () {
		removeSingleFile(isExisting, fileId, containerId, fileInputId);
	};

	const trashIcon = document.createElement('i');
	trashIcon.className = 'ki-duotone ki-trash fs-3';
	trashIcon.innerHTML = `<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span>`;
	removeBtn.appendChild(trashIcon);
	if (disableTrash === true) {
		removeBtn.style.opacity = '0.5';
		removeBtn.style.pointerEvents = 'none';
		removeBtn.style.cursor = 'not-allowed';
	} else {
		removeBtn.classList.add('cursor-pointer');
		removeBtn.onclick = function () {         
			removeSingleFile(isExisting, fileId, containerId, fileInputId);
		};
	}

	fileWrapper.appendChild(leftGroup);
	fileWrapper.appendChild(removeBtn);

	container.appendChild(fileWrapper);
}

// fn remove file
window.removeSingleFile = function (isExisting, fileId, containerId = 'filePreviewContainer', fileInputId = 'myFile') {
	const container = document.getElementById(containerId) || document.getElementById('filePreviewContainer');
	if (container) container.innerHTML = '';

	const fileInput = document.getElementById(fileInputId);
	if (fileInput) {
		try { fileInput.value = ''; } catch (e) { /* ignore */ }
	}

	const sizeInput = document.getElementById('size');
	if (sizeInput) {
		sizeInput.value = '';
	}

	if (isExisting === true && fileId != null) {
		const del = document.getElementById('deleteFileId');
		if (del) del.value = fileId;
		const fup = document.getElementById('fileUploadId');
		if (fup) fup.value = '';
	} else if (isExisting === 'true' && fileId !== 'null' && fileId !== '') {
		const del = document.getElementById('deleteFileId');
		if (del) del.value = fileId;
		const fup = document.getElementById('fileUploadId');
		if (fup) fup.value = '';
	}
	// clear any global preview target flag
	if (window.filePreviewTarget) delete window.filePreviewTarget;
};

document.addEventListener('DOMContentLoaded', initFileInput);

function initFileInput() {
	const fileInput = document.getElementById('myFile');
	if (!fileInput) {
		console.error("Critical Error: File input element with ID 'myFile' not found.");
		return;
	}
	// Main Attach-files control: can pick several files -> accumulate into LeaveFiles.pending
	// (doesn't overwrite what's already attached). window.__lfAddFilesCallback lets the inline
	// "attach file" control (submitAfterFile, further down) know when its
	// forwarded file is done.
	fileInput.addEventListener('change', function (event) {
		var cb = window.__lfAddFilesCallback;
		window.__lfAddFilesCallback = null;
		$('#alert_evidence').text(''); // แนบไฟล์แล้ว ซ่อนข้อความเตือน
		lfAddFiles(event.target.files, cb);
	});
}

/* ---------- ไฟล์แนบตอน Approved: เลือกไฟล์ → ดูก่อน → กด Submit ถึงส่ง ---------- */
function toggleAfterFileSubmit() {
	var input = document.getElementById('afterFile');
	var hasFile = !!(input && input.files && input.files.length > 0);
	$('#afterFileSubmitBtn').toggleClass('d-none', !hasFile);
}

function previewAfterFile(input) {
	const container = document.getElementById('modalFilePreviewName');
	if (!container) return;
	if (input.files && input.files[0]) {
		const file = input.files[0];

		if (lfIsHeic(file)) {
			input.value = '';
			container.innerHTML = '';
			toggleAfterFileSubmit();
			Swal.fire({
				icon: 'error',
				title: 'ไม่รองรับไฟล์ HEIC',
				html: 'ไม่รองรับไฟล์นามสกุล .heic กรุณาแปลงก่อนแนบไฟล์'
					+ '<br><br><span class="text-muted fs-7">ไฟล์ที่รองรับ: PNG, JPG, JPEG, GIF, WEBP, PDF, ZIP</span>',
				confirmButtonText: 'รับทราบ'
			});
			return;
		}

		if (LF_FORBIDDEN.test(file.name)) {
			input.value = '';
			container.innerHTML = '';
			toggleAfterFileSubmit();
			Swal.fire({
				icon: 'error',
				title: 'Invalid file name',
				text: 'File name contains invalid characters: ' + file.name,
				confirmButtonText: 'OK'
			});
			return;
		}

		const tempUrl = URL.createObjectURL(file);
		renderSingleFilePreview(file.name, tempUrl, false, null, 'modalFilePreviewName', 'afterFile');
		$('#removeFileBtn_modalFilePreviewName').on('click', toggleAfterFileSubmit);
	} else {
		container.innerHTML = '';
	}
	toggleAfterFileSubmit();
}

function clearAfterFile() {
	const input = document.getElementById('afterFile');
	if (input) input.value = '';
	removeSingleFile(false, null, 'modalFilePreviewName', 'afterFile');
	toggleAfterFileSubmit();
}

function submitAfterFile() {
	const input = document.getElementById('afterFile');
	if (!input.files || input.files.length === 0) return;
	// เช็คขนาด/บีบอัดก่อน ผ่านแล้วค่อยส่ง
	window.__lfAddFilesCallback = function (success) {
		if (!success) return;
		clearAfterFile();
		doSubmit();
	};
	handleAfterFileSelect(input);
}
</script>

<script>
/* ---------- ไฟล์แนบ: แนบไฟล์ตอน Approved ---------- */
function handleAfterFileSelect(input) {
	const file = input.files[0];
	if (!file) return;
	const forbiddenChars = /[\/:*?"<>|]/;
	if (forbiddenChars.test(file.name)) {
		alert("File name contains invalid characters.");
		input.value = '';
		return;
	}

	// Forward the chosen file to the existing #myFile input so existing handlers run
	try {
		// render into the afterFile preview container
		window.filePreviewTarget = 'modalFilePreviewName';
		const dataTransfer = new DataTransfer();
		dataTransfer.items.add(file);
		const myFile = document.getElementById('myFile');
		if (myFile) {
			myFile.files = dataTransfer.files;
			const evt = new Event('change', { bubbles: true });
			myFile.dispatchEvent(evt);
			// clear the afterFile input so the form doesn't submit both
			try { input.value = ''; } catch (e) { /* ignore */ }
			return;
		}
	} catch (err) {
		console.warn('Forward to #myFile failed, fallback to direct preview', err);
	}

	// Fallback: render preview directly and set hidden fields
	const tempUrl = URL.createObjectURL(file);
	renderSingleFilePreview(file.name, tempUrl, false, null, 'modalFilePreviewName', 'afterFile');

	var fSExt = ['Bytes', 'KB', 'MB', 'GB'];
	var fSize = file.size;
	var i = 0;
	while (fSize > 900) { fSize /= 1024; i++; }
	var size_n = (Math.round(fSize * 100) / 100);
	var sizeInput = document.getElementById('size');
	if (sizeInput) sizeInput.value = size_n + ' ' + fSExt[i];
	var deleteInput = document.getElementById('deleteFileId');
	if (deleteInput) deleteInput.value = '';
	var fileIdInput = document.getElementById('fileUploadId');
	if (fileIdInput) fileIdInput.value = '';
}
</script>

<script>
/* ---------- ไฟล์แนบ: หลายไฟล์ ---------- */
window.LeaveFiles = window.LeaveFiles || { pending: [], existing: [], deleted: [], loading: [] };
var LF_LOADING_SEQ = 0;

var LF_FORBIDDEN = /[\/:*?"<>|]/;
var LF_IMG_LIMIT = 500 * 1024;
var LF_TOTAL_LIMIT = 2 * 1024 * 1024;

function getFileIconPath(fileName) {
	var ext = fileName.split('.').pop().toLowerCase();
	switch (ext) {
		case 'pdf': return 'assets/media/svg/files/pdf.svg';
		case 'doc': case 'docx': return 'assets/media/svg/files/doc.svg';
		case 'xls': case 'xlsx': return 'assets/media/svg/files/xls.svg';
		case 'png': case 'jpg': case 'jpeg': case 'gif': case 'webp':
			return 'assets/media/svg/files/blank-image.svg';
		case 'zip': return 'assets/media/svg/files/zip.svg';
		default: return 'assets/media/svg/files/folder-document.svg';
	}
}

function lfLoadExisting(list) {
	LeaveFiles.existing = [];
	LeaveFiles.deleted = [];
	if (list && list.length) {
		for (var i = 0; i < list.length; i++) {
			var f = list[i];
			if (!f || f.fileId == null) continue;
			LeaveFiles.existing.push({ fileId: f.fileId, name: (f.name || 'file'), type: (f.type || '') });
		}
	}
}

function lfMakeItem(name, url, onRemove, disableTrash) {
	var wrapper = document.createElement('div');
	wrapper.className = 'd-flex w-100 justify-content-between align-items-center p-2 border border-gray-300 rounded bg-white';

	var leftGroup = document.createElement('div');
	leftGroup.className = 'd-flex align-items-center overflow-hidden me-4';

	var icon = document.createElement('img');
	icon.src = getFileIconPath(name);
	icon.className = 'w-25px h-25px me-3 flex-shrink-0';
	icon.alt = 'icon';

	var link = document.createElement('a');
	link.href = url || '#';
	link.target = '_blank';
	link.className = 'text-gray-800 fw-medium text-hover-primary text-truncate';
	link.textContent = name;
	link.style.maxWidth = '250px';

	leftGroup.appendChild(icon);
	leftGroup.appendChild(link);

	var removeBtn = document.createElement('span');
	removeBtn.className = 'btn btn-icon btn-sm btn-light-danger';
	var trashIcon = document.createElement('i');
	trashIcon.className = 'ki-duotone ki-trash fs-3';
	trashIcon.innerHTML = '<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span>';
	removeBtn.appendChild(trashIcon);
	if (disableTrash) {
		removeBtn.style.opacity = '0.5';
		removeBtn.style.pointerEvents = 'none';
	} else {
		removeBtn.classList.add('cursor-pointer');
		removeBtn.onclick = onRemove;
	}

	wrapper.appendChild(leftGroup);
	wrapper.appendChild(removeBtn);
	return wrapper;
}

function lfMakeLoadingItem(name) {
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

function lfRemoveLoading(loadingId) {
	LeaveFiles.loading = LeaveFiles.loading.filter(function (l) { return l.id !== loadingId; });
}

function lfUpdateSubmitState() {
	var hasLoading = LeaveFiles.loading.length > 0;
	$('#submitBtn')
		.prop('disabled', hasLoading)
		.toggleClass('disabled', hasLoading)
		.attr('title', hasLoading ? 'กำลังประมวลผลไฟล์แนบ กรุณารอสักครู่' : '');
}

function lfPaint(containerId, opts) {
	var c = document.getElementById(containerId);
	if (!c) return;
	opts = opts || {};
	c.innerHTML = '';
	for (var i = 0; i < LeaveFiles.existing.length; i++) {
		(function (ex) {
			if (LeaveFiles.deleted.indexOf(ex.fileId) !== -1) return;
			c.appendChild(lfMakeItem(ex.name + (ex.type || ''), 'line_preview_File?id=' + ex.fileId, function () {
				LeaveFiles.deleted.push(ex.fileId);
				lfSyncInput();
				lfRenderAll();
			}, !!opts.readonly));
		})(LeaveFiles.existing[i]);
	}
	for (var j = 0; j < LeaveFiles.pending.length; j++) {
		(function (idx, file) {
			c.appendChild(lfMakeItem(file.name, URL.createObjectURL(file), function () {
				LeaveFiles.pending.splice(idx, 1);
				lfSyncInput();
				lfRenderAll();
			}, !!opts.readonly));
		})(j, LeaveFiles.pending[j]);
	}
	if (!opts.readonly) {
		for (var k = 0; k < LeaveFiles.loading.length; k++) {
			c.appendChild(lfMakeLoadingItem(LeaveFiles.loading[k].name));
		}
	}
	if (!c.children.length && opts.emptyText) {
		c.innerHTML = '<div class="text-muted fs-6">' + opts.emptyText + '</div>';
	}

	lfUpdateSubmitState();
}

function lfRenderAll() {
	lfPaint('filePreviewContainer', {});
}

function lfRenderExistingReadonly(containerId) {
	lfPaint(containerId, { readonly: true });
}

function lfDup(file) {
	return LeaveFiles.pending.some(function (f) { return f.name === file.name && f.size === file.size; });
}

function lfCurrentTotalSize() {
	var total = 0;
	LeaveFiles.pending.forEach(function (f) { total += f.size; });
	return total;
}

function lfIsHeic(file) {
	var name = (file.name || '').toLowerCase();
	return name.endsWith('.heic') || name.endsWith('.heif')
		|| file.type === 'image/heic' || file.type === 'image/heif';
}

function lfCompressIfNeeded(file, loadingId, onDone) {
	if (file.type && file.type.indexOf('image/') === 0 && file.size > LF_IMG_LIMIT && typeof Compressor !== 'undefined') {
		new Compressor(file, {
			quality: 0.8, maxWidth: 1024, maxHeight: 1024,
			success: function (result) {
				var compressed = new File([result], file.name, { type: result.type, lastModified: Date.now() });
				lfTryAddFile(compressed, loadingId, onDone);
			},
			error: function (err) {
				console.error('resize error:', err && err.message);
				lfTryAddFile(file, loadingId, onDone);
			}
		});
	} else {
		lfTryAddFile(file, loadingId, onDone);
	}
}

function lfProcessFile(file, loadingId, onDone) {
	if (lfIsHeic(file)) {
		lfRemoveLoading(loadingId);
		lfRenderAll();
		Swal.fire({
			icon: 'error',
			title: 'ไม่รองรับไฟล์ HEIC',
			html: 'ไม่รองรับไฟล์นามสกุล .heic กรุณาแปลงก่อนแนบไฟล์'
				+ '<br><br><span class="text-muted fs-7">ไฟล์ที่รองรับ: PNG, JPG, JPEG, GIF, WEBP, PDF, ZIP</span>',
			confirmButtonText: 'รับทราบ'
		});
		if (onDone) onDone(false);
		return;
	}
	lfCompressIfNeeded(file, loadingId, onDone);
}

function lfTryAddFile(file, loadingId, onDone) {
	lfRemoveLoading(loadingId);
	var currentTotal = lfCurrentTotalSize();
	if (currentTotal + file.size > LF_TOTAL_LIMIT) {
		Swal.fire({
			icon: 'warning',
			title: 'ไฟล์มีขนาดเกินกำหนด',
			text: 'ไม่สามารถแนบไฟล์ "' + file.name + '" ได้ เนื่องจากขนาดไฟล์รวมเกินขนาดสูงสุดที่กำหนดไว้',
			confirmButtonText: 'รับทราบ'
		});
		lfRenderAll();
		if (onDone) onDone(false);
		return;
	}
	LeaveFiles.pending.push(file);
	lfSyncInput();
	lfRenderAll();
	if (onDone) onDone(true);
}

function lfAddFiles(fileList, onDone) {
	if (!fileList || !fileList.length) {
		if (onDone) onDone(false);
		return;
	}

	Array.prototype.slice.call(fileList).forEach(function (file) {
		if (LF_FORBIDDEN.test(file.name)) {
			Swal.fire({
				icon: 'error',
				title: 'Invalid file name',
				text: 'File name contains invalid characters: ' + file.name,
				confirmButtonText: 'OK'
			});
			if (onDone) onDone(false);
			return;
		}
		if (lfDup(file)) {
			if (onDone) onDone(true);
			return;
		}

		var loadingId = ++LF_LOADING_SEQ;
		LeaveFiles.loading.push({ id: loadingId, name: file.name });
		lfRenderAll();

		lfProcessFile(file, loadingId, onDone);
	});
}

function lfSyncInput() {
	var myFile = document.getElementById('myFile');
	if (myFile) {
		try {
			var dt = new DataTransfer();
			LeaveFiles.pending.forEach(function (f) { dt.items.add(f); });
			myFile.files = dt.files;
		} catch (e) { console.warn('lfSyncInput DataTransfer failed', e); }
	}
	var del = document.getElementById('deleteFileId');
	if (del) del.value = LeaveFiles.deleted.join(',');
	var sz = document.getElementById('size');
	if (sz) sz.value = LeaveFiles.pending.length ? (LeaveFiles.pending.length + ' file(s)') : '';
}
</script>
