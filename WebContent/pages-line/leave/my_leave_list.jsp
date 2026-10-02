<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:setLocale value="en_US" />
<fmt:setTimeZone value="Asia/Bangkok" />

<%-- =====================================================================
     OLD: desktop My Leave list (disabled, kept for reference)
     ===================================================================== --%>
<%--
<!--begin::Main-->
<div class="app-main flex-column flex-row-fluid">
	<div class="d-flex flex-column flex-column-fluid">
		<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
			<div id="kt_app_toolbar_container" class="app-container container-fluid d-flex flex-stack">
				<!--begin::Page title-->
				<div class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
					<h1 class="page-heading d-flex text-gray-900 fw-bold fs-3 flex-column justify-content-center my-0">My Leave</h1>
					<ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
						<li class="breadcrumb-item text-muted"><a href="demo_dashboard" class="text-muted text-hover-primary">Home</a></li>
						<li class="breadcrumb-item"><span class="bullet bg-gray-500 w-5px h-2px"></span></li>
						<li class="breadcrumb-item text-muted">My Leave</li>
					</ul>
				</div>
				<!--end::Page title-->
			</div>
		</div>

		<!--begin::Content-->
		<div id="kt_app_content" class="app-content flex-column-fluid">
			<!--begin::Content container-->
			<div id="kt_app_content_container" class="app-container container-fluid">
				<!-- DDL -->
				<div class="d-flex flex-row">
					<div class="flex-row-fluid mb-5">
						<!--begin::Filter-->
						<form action="new_searchfromto" method="POST" id="searchForm">
							<div class="card card-flush bgi-no-repeat bgi-size-contain bgi-position-x-center border-0 mb-5 mb-xl-10">
								<div class="card-body">
									<div class="row g-5">
										<!-- Leave Type -->
										<div class="col-12 col-xs-4 col-md-4">
											<div class="mb-5">
												<select class="form-select" data-placeholder="All Leave Type" name="type" onchange="this.form.submit()">
													<option value="allType" <c:if test="${leaveType == 'allType'}"><c:out value="selected=selected"/></c:if>>All Leave Type</option>
													<c:forEach var="leavetype" items="${leavetypelistChoice}">
														<option value="${leavetype.leaveTypeId}"
															<c:if test="${leaveType == leavetype.leaveTypeId}">
																<c:out value="selected=selected"/>
															</c:if>>${leavetype.leaveTypeName}
														</option>
													</c:forEach>
												</select>
											</div>
										</div>
										<!-- Status -->
										<div class="col-12 col-xs-4 col-md-4">
											<div class="mb-5">
												<select class="form-select" data-placeholder="All Status" name="appr" id="appr" onchange="this.form.submit()">
													<option value="4" id="All1"
														<c:if test="${ appr == 4 }">
															<c:out value="selected=selected"/>
														</c:if>>All Status</option>
													<option value="0" <c:if test="${ appr == 0 }">
															<c:out value="selected=selected"/>
														</c:if>>Waiting for approve</option>
													<option value="1" <c:if test="${ appr == 1 }">
															<c:out value="selected=selected"/>
														</c:if>>Approve
													</option>
													<option value="2" <c:if test="${ appr == 2 }">
															<c:out value="selected=selected"/>
														</c:if>>Reject
													</option>
													<option value="3" <c:if test="${ appr == 3 }">
															<c:out value="selected=selected"/>
														</c:if>>Cancel
													</option>
												</select>
											</div>
										</div>
										<!-- Date Range -->
										<div class="col-12 col-xs-4 col-md-4">
											<div class="mb-5">
												<!-- <label class="form-label">Date Range</label> -->
												<input id="kt_daterangepicker" class="form-control" placeholder="Pick date range" autocomplete="off"/>
												<input type="hidden" name="startdate" id="startdate">
												<input type="hidden" name="enddate" id="enddate">
											</div>
										</div>
									</div>
								</div>
							</div>
						</form>
						<!--end::Filter-->
					</div>
				</div>
				<!-- DDL -->

				<!-- Summary Leave -->
				<div class="d-flex flex-row">
					<div class="flex-row-fluid mb-5">
						<div class="card card-flush bgi-no-repeat bgi-size-contain bgi-position-x-center border-0 mb-5 mb-xl-10">
							<div class="card-body">
								<div class="row g-5">
									<!-- ลาพักร้อน -->
								--%>
								<%-- 	<div class="col-6 col-xs-4 col-sm-4 col-md-4 col-xl-3">
										<div class="d-flex align-items-center">
											<div class="symbol symbol-50px me-4">
												<span class="symbol-label bg-light-success">
													<i class="ki-duotone ki-airplane fs-2x text-success">
														<span class="path1"></span><span class="path2"></span>
													</i>
												</span>
											</div>
											<div class="d-flex flex-column">
												<div class="d-flex align-items-center">
													<span class="fs-2 fw-bold text-dark">
														<fmt:formatNumber type="number" pattern="#.##" value="${leave_1}"/>/<fmt:formatNumber type="number" pattern="#.##" value="${quota_1-3}"/>
													</span>
													<c:if test="${LeaveWAnumT1.doubleValue() > 0}">
														<span class="badge badge-sm badge-warning ms-1">
															<fmt:formatNumber type="number" pattern="#.##" value="${LeaveWAnumT1}"/>
														</span>
													</c:if>
												</div>
												<span class="text-muted fs-5">${type_1}</span>
											</div>	
										</div>
									</div>	 --%>
<%--

									<!-- ลาพักร้อน + ลากิจ -->
									<div class="col-6 col-xs-4 col-sm-4 col-md-4 col-xl-3">
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
									<div class="col-6 col-xs-4 col-sm-4 col-md-4 col-xl-3">
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
												<div class="d-flex align-items-center">
													<span class="fs-2 fw-bold text-dark">
														<fmt:formatNumber type="number" pattern="#.##" value="${leave_6}"/>
														<c:if test="${quotaLastYear.doubleValue() > 0}">
															/<fmt:formatNumber type="number" pattern="#.##" value="${quotaLastYear}"/>
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
									<div class="col-6 col-xs-4 col-sm-4 col-md-4 col-xl-3">
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
									<div class="col-6 col-xs-4 col-sm-4 col-md-4 col-xl-3">
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
									<div class="col-6 col-xs-4 col-sm-4 col-md-4 col-xl-3">
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
									<div class="col-6 col-xs-4 col-sm-4 col-md-4 col-xl-3">
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


				<!-- Recent Update -->
				<div class="d-flex flex-wrap flex-stack pb-7">
					<!--begin::Title-->
					<div class="d-flex flex-wrap align-items-center my-1">
						<h3 class="fw-bold me-5 my-1">
							${fn:length(leavelist)} Items Found <span class="text-gray-500 fs-6">by Recent Updates ↓</span>
						</h3>
					</div>
					<!--end::Title-->

					<!--begin::Controls-->
					<div class="d-flex flex-wrap my-1">
						<a href="javascript:void(0)" class="btn btn-success btn-lg" onclick="add()">
							<i class="ki-duotone ki-plus"></i>
							Create
						</a>
					</div>
					<!--end::Controls-->
				</div>
				<!-- Recent Update -->


				<!--begin::Leave List-->
				<div class="d-flex flex-row">
					<div class="flex-row-fluid mb-5">
						<c:forEach var="leave" items="${leavelist}" varStatus="status">
							<!--begin::Leave Each 1-->
							<div class="card shadow-sm mb-5 mb-xl-10">

								<!--begin::Header -->
								<div class="card-header fs-4">
									<!-- ID , Title -->
									<div class="d-flex align-items-center mb-2 gap-2">
										<span class="fw-bold me-2 text-primary">#${leave.leave_id}</span>
											<c:if test="${leave.leave_type_id.toString() == '1'}">
												<div class="symbol symbol-35px me-4">
													<span class="symbol-label bg-light-success">
														<i class="ki-duotone ki-airplane fs-2x text-success">
															<span class="path1"></span>
															<span class="path2"></span>
														</i>
													</span>
												</div>
												<span class="badge badge-light-success fs-4">${leave.leave_type_name}</span>
											</c:if>
											<c:if test="${leave.leave_type_id.toString() == '2'}">
												<div class="symbol symbol-35px me-4">
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
												<span class="badge badge-light-primary fs-4">${leave.leave_type_name}</span>
											</c:if>
											<c:if test="${leave.leave_type_id.toString() == '3'}">
												<div class="symbol symbol-35px me-4">
													<span class="symbol-label bg-light-info">
														<i class="ki-duotone ki-pulse fs-2x text-info">
															<span class="path1"></span>
															<span class="path2"></span>
														</i>
													</span>
												</div>
												<span class="badge badge-light-info fs-4">${leave.leave_type_name}</span>
											</c:if>
											<c:if test="${leave.leave_type_id.toString() == '4'}">
												<div class="symbol symbol-35px me-4">
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
												<span class="badge badge-light-danger fs-4">${leave.leave_type_name}</span>
											</c:if>
											<c:if test="${leave.leave_type_id.toString() == '5'}">
												<div class="symbol symbol-35px me-4">
													<span class="symbol-label bg-light-dark">
														<i class="ki-duotone ki-brifecase-cros fs-2x text-dark">
															<span class="path1"></span>
															<span class="path2"></span>
															<span class="path3"></span>
														</i>												
													</span>
												</div>
												<span class="badge badge-light-dark fs-4">${leave.leave_type_name}</span>
											</c:if>
											<c:if test="${leave.leave_type_id.toString() == '6'}">
												<div class="symbol symbol-35px me-4">
													<span class="symbol-label bg-light-warning">
														<i class="ki-duotone ki-timer fs-2x text-warning">
															<span class="path1"></span>
															<span class="path2"></span>
															<span class="path3"></span>
														</i>
													</span>
												</div>
												<span class="badge badge-light-warning fs-4">${leave.leave_type_name}</span>
											</c:if>
											<c:if test="${leave.leave_type_id.toString() == '7'}">
												<div class="symbol symbol-35px me-4">
													<span class="symbol-label" style="background-color: #4B5675;">
														<i class="ki-duotone ki-abstract-12 fs-2x" style="color: #FFFFFF;">
															<span class="path1"></span>
															<span class="path2"></span>
														</i>
													</span>
												</div>
												<span class="badge badge-light-dark fs-4">${leave.leave_type_name}</span>
											</c:if>
									</div>

									<!-- Btn Info, Edit, Delete -->
									<div class="card-toolbar">
										<div class="d-inline-flex align-items-center justify-content-end gap-2">
											<!-- Btn Info -->
											<a href="javascript:void(0)" class="btn btn-icon btn-sm btn-light-info" onclick="leaveStatus(${leave.leave_id})">
												<i class="ki-duotone ki-document fs-5">
													<span class="path1"></span>
													<span class="path2"></span>
												</i>
											</a>
											<!-- Btn Edit, Delete -->
											<c:choose>
												<c:when test="${leave.leave_status_id.toString() == 0}">
													<a data-note="btn edit" href="line_NewLeaveEdit?id=${leave.leave_id}" title="Edit" class="btn btn-icon btn-sm btn-light-primary">
														<i class="ki-duotone ki-pencil fs-5">
															<span class="path1"></span>
															<span class="path2"></span>
														</i>
													</a>
													<a data-note="btn delete" onclick="changeStatus(${leave.leave_id});" title="Delete" class="btn btn-icon btn-sm btn-light-danger">
														<i class="ki-duotone ki-trash fs-5">
															<span class="path1"></span>
															<span class="path2"></span>
															<span class="path3"></span>
															<span class="path4"></span>
															<span class="path5"></span>
														</i>
													</a>
												</c:when>
												<c:when test="${leave.leave_status_id.toString() != 0}">
													<a data-note="btn edit" href="line_NewLeaveEdit?id=${leave.leave_id}" title="Edit" class="btn btn-icon btn-sm btn-light-primary">
														<i class="ki-duotone ki-pencil fs-5">
															<span class="path1"></span>
															<span class="path2"></span>
														</i>
													</a>
													<a data-note="btn delete" class="btn btn-icon btn-sm btn-light-secondary disabled">
														<i class="ki-duotone ki-trash fs-5">
															<span class="path1"></span>
															<span class="path2"></span>
															<span class="path3"></span>
															<span class="path4"></span>
															<span class="path5"></span>
														</i>
													</a>
												</c:when>
											</c:choose>
										</div>
									</div>
								</div>
								<!--end::Header -->

								<!--begin::Footer -->
								<div class="card-header fs-5">
									<div class="d-flex align-items-center mt-3 mb-2">
										<div class="d-flex flex-wrap align-items-center gap-3 row-gap-1">
											<div class="fw-bold fs-6 text-dark">${leave.name}</div>
											<div class="d-flex align-items-center">
												<i class="ki-duotone ki-calendar-2 fs-5">
													<span class="path1"></span>
													<span class="path2"></span>
													<span class="path3"></span>
													<span class="path4"></span>
													<span class="path5"></span>
												</i>
												<span class="fs-6"><fmt:formatDate value="${leave.start_date}" type="date" pattern="d MMM yyyy"></fmt:formatDate> - <fmt:formatDate value="${leave.end_date}" type="date" pattern="d MMM yyyy"></fmt:formatDate></span>
												<span class="badge badge-light-primary badge-lg ms-2">
												<fmt:formatNumber type="number" pattern="#.###" value="${leave.no_day}"/> day
												</span>
											</div>

											<div class="d-flex align-items-center">
												<i class="ki-duotone ki-calendar-8 fs-5">
													<span class="path1"></span>
													<span class="path2"></span>
													<span class="path3"></span>
													<span class="path4"></span>
													<span class="path5"></span>
												</i>
												<c:if test="${leave.half_day != null}">
													<i class="fa fa-clock-o iconbtn"></i>&nbsp;
													<c:if test="${leave.half_day.toString() == 0}"><span>เต็มวัน</span></c:if>
													<c:if test="${leave.half_day.toString() == 1}"><span>ช่วงเช้า</span></c:if>
													<c:if test="${leave.half_day.toString() == 2}"><span>ช่วงบ่าย</span></c:if>
													<c:if test="${leave.half_day.toString() == 3}"><span>ช่วงเวลา</span></c:if>
												</c:if>
											</div>

											<div class="d-flex align-items-center">
												<i class="ki-duotone ki-time fs-5">
													<span class="path1"></span>
													<span class="path2"></span>
													<span class="path3"></span>
													<span class="path4"></span>
													<span class="path5"></span>
												</i>
												${leave.start_time} - ${leave.end_time}
											</div>
											
											<c:if test="${not empty leave.leave_file}">
											    <div class="d-flex align-items-center">
											        <i class="ki-duotone ki-document me-2">
											            <span class="path1"></span>
											            <span class="path2"></span>
											        </i>
											
											        <a href="line_preview_File?id=${leave.leave_file}"
											           target="_blank"
											           class="text-primary text-hover-underline">
											            ${leave.file_name}${leave.type}
											        </a>
											    </div>
											</c:if>
										</div>
									</div>

									<div class="card-toolbar">
										<div class="d-inline-flex align-items-center justify-content-end gap-2">

											<span class="text-muted fs-7">
												Request Date: <fmt:formatDate value="${leave.time_create}" type="date" pattern="d MMM yyyy" />
											</span>

											<c:if test="${leave.leave_status_id.toString() == '0'}">
												<span class="badge badge-light-warning badge-lg ms-2">Wait for approve</span>
											</c:if>
											<c:if test="${leave.leave_status_id.toString() == '1'}">
												<span class="badge badge-light-success badge-lg ms-2">Approved</span>
											</c:if>
											<c:if test="${leave.leave_status_id.toString() == '2'}">
												<span class="badge badge-light-danger badge-lg ms-2">Reject</span>
											</c:if>
											<c:if test="${leave.leave_status_id.toString() == '3'}">
												<span class="badge badge-light-dark badge-lg ms-2">Cancel</span>
											</c:if>

										</div>
									</div>

								</div>
								<!--end::Footer -->

							</div>
							<!--begin::Leave Each 1-->
						</c:forEach>
					</div>
				</div>
				<!--end::Leave List-->

			</div>
			<!--end::Content container-->

		</div>
		<!--end::Content-->

	</div>
</div>
<!--end:::Main-->
--%>
<!-- ===== END: old desktop-clone content (commented out) ===== -->

<%-- =====================================================================
     NEW: LINE LIFF
     ===================================================================== --%>
<style>
.liff-shell {
	--liff-gutter: 1.5rem;
	--liff-bullet-w: 3px;
	width: calc(100% - 32px); max-width: 393px; margin: 0 auto;
	padding-bottom: 80px; /* เว้นที่ให้ปุ่ม + */
}
.liff-sort-btn { display: inline-flex; align-items: center; gap: 6px; font-size: 13px; font-weight: 600; color: var(--bs-gray-700); border: 1px solid #E4E6EF; border-radius: 8px; padding: 6px 12px; background-color: #F8F9FB; }
.liff-sort-btn:hover, .liff-sort-btn:focus { border-color: var(--bs-primary); }
.liff-sort-btn .spinner-border { width: 12px; height: 12px; border-width: 2px; }
.liff-skel { display: inline-block; height: 12px; border-radius: 6px; flex: none; background: linear-gradient(90deg, #F1F1F4 25%, #E4E6EF 37%, #F1F1F4 63%); background-size: 400% 100%; animation: liffShimmer 1.2s ease-in-out infinite; }
.liff-skel-box { width: 35px; height: 35px; border-radius: .475rem; }
.liff-skel-row { display: flex; align-items: center; gap: .5rem; min-height: 20px; }
.liff-skel-dot { width: 14px; height: 14px; border-radius: 50%; }
@keyframes liffShimmer { 0% { background-position: 100% 50%; } 100% { background-position: 0 50%; } }
@media (prefers-reduced-motion: reduce) { .liff-skel { animation: none; } }
#yearFilterBtn { font-size: 13px; font-weight: 600; color: var(--bs-gray-700); border: 1px solid #E4E6EF; border-radius: 8px; padding: 6px 16px; background-color: #F8F9FB; }
#yearFilterBtn:hover, #yearFilterBtn:focus, #yearFilterBtn:active { background-color: #F8F9FB; border-color: var(--bs-primary); box-shadow: none; }
#yearFilterBtn::after { vertical-align: 1px; }
.dropdown-menu[aria-labelledby="yearFilterBtn"] { min-width: 92px; border-radius: 10px; border: 1px solid #E4E6EF; box-shadow: 0 4px 20px rgba(0,0,0,.08); padding: 6px; max-height: 260px; overflow-y: auto; }
.dropdown-menu[aria-labelledby="yearFilterBtn"] .dropdown-item { font-size: 13px; font-weight: 500; border-radius: 6px; padding: 8px 12px; }
.dropdown-menu[aria-labelledby="yearFilterBtn"] .dropdown-item.active, .dropdown-menu[aria-labelledby="yearFilterBtn"] .dropdown-item:active { background-color: var(--bs-primary); color: #fff; }
.card-header .bg-info-subtle:hover { background-color: var(--bs-info) !important; }
.card-header .bg-info-subtle:hover i { color: var(--bs-info-inverse) !important; }
.card-header .bg-primary-subtle:hover { background-color: var(--bs-primary) !important; }
.card-header .bg-primary-subtle:hover i { color: var(--bs-primary-inverse) !important; }
.card-header .bg-danger-subtle:hover { background-color: var(--bs-danger) !important; }
.card-header .bg-danger-subtle:hover i { color: var(--bs-danger-inverse) !important; }
.leave-summary-pager { display: flex; overflow-x: auto; scroll-snap-type: x mandatory; -webkit-overflow-scrolling: touch; scrollbar-width: none; }
.leave-summary-pager::-webkit-scrollbar { display: none; }
.leave-summary-page { flex: 0 0 100%; scroll-snap-align: start; min-width: 0; }
.leave-summary-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 28px; }
.leave-summary-item { display: flex; align-items: center; gap: 15px; min-width: 0; overflow: hidden; padding-right: 13px; }
.leave-summary-item .d-flex.flex-column { min-width: 0; overflow: hidden; gap: 4px; }
.leave-summary-item .text-gray-600 { display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; }
.leave-summary-dots { display: flex; justify-content: center; gap: 6px; margin-top: 19.5px; }
.leave-summary-dots span { width: 6px; height: 6px; border-radius: 50%; background: #D9D9E3; transition: background .2s; }
.leave-summary-dots span.active { background: #1B84FF; }
.leave-status-badge { display: inline-flex; align-items: center; justify-content: center; gap: 10px; min-width: 26px; height: 26px; padding: 4.23px 6.5px; border-radius: 5.52px; }
.liff-fab {
	position: fixed;
	right: max(16px, calc((100vw - 393px) / 2 + 16px)); /* ชิดขวา .liff-shell */
	bottom: calc(90px + 16px + env(safe-area-inset-bottom)); /* ลอยเหนือ .liff-nav */
	width: 56px; height: 56px;
	border-radius: 16px;
	background: var(--bs-success);
	display: flex; align-items: center; justify-content: center;
	box-shadow: 0 4px 16px rgba(0,0,0,.2);
	z-index: 100;
}
</style>

<div class="liff-shell">

	<div id="liffLoadingOverlay" class="liff-loading-overlay">
		<div class="spinner-border text-primary" role="status"><span class="visually-hidden">Loading...</span></div>
	</div>

	<c:set var="currentYearInt"><%= java.time.Year.now().getValue() %></c:set>
	<c:set var="startYearInt" value="${currentYearInt - 1}" />
	<fmt:formatDate value="${startdate}" pattern="yyyy" var="selectedYear"/>
	<div class="d-flex justify-content-between align-items-center mb-6 pt-6">
		<h1 class="liff-page-title text-gray-700 mb-0">My Leave</h1>
		<div class="dropdown">
			<button class="btn btn-sm dropdown-toggle" type="button" id="yearFilterBtn" data-bs-toggle="dropdown" aria-expanded="false">
				${selectedYear}
			</button>
			<ul class="dropdown-menu dropdown-menu-end" aria-labelledby="yearFilterBtn">
				<c:forEach var="i" begin="0" end="${currentYearInt - startYearInt}">
					<c:set var="y" value="${currentYearInt - i}"/>
					<li><a class="dropdown-item ${selectedYear == y ? 'active' : ''}" href="javascript:void(0)" onclick="filterByYear(${y})">${y}</a></li>
				</c:forEach>
			</ul>
		</div>
	</div>

	<a href="javascript:void(0)" class="liff-fab" onclick="add()" aria-label="Add">
		<i class="ki-duotone ki-plus" style="color:#FFFFFF; font-size:1.75rem;"></i>
	</a>

	<!-- Summary Leave -->
	<div class="mb-6">
		<div class="card card-bordered">
			<div class="card-body" style="padding:29.25px;">
				<div class="leave-summary-pager" id="leaveSummaryPager">
					<div class="leave-summary-item">
						<span class="symbol symbol-50px">
							<span class="symbol-label bg-success-subtle">
								<i class="ki-duotone ki-airplane text-success" style="font-size:1.75rem;">
									<span class="path1"></span><span class="path2"></span>
								</i>
							</span>
						</span>
						<div class="d-flex flex-column">
							<span class="fw-bold text-gray-800" style="font-size:15.88px; line-height:1.21;">
								<fmt:formatNumber type="number" pattern="#.##" value="${leave_1}"/>/<fmt:formatNumber type="number" pattern="#.##" value="${quota_1}"/>
								<c:set var="leaveWA1" value="${empty LeaveWAnumT1 ? 0 : LeaveWAnumT1}" />
								<c:if test="${leaveWA1 > 0}">
									<span class="badge badge-sm badge-warning"><fmt:formatNumber type="number" pattern="#.##" value="${leaveWA1}"/></span>
								</c:if>
							</span>
							<span class="text-gray-600" style="font-size:12.35px; line-height:1.21;">${type_1}</span>
						</div>
					</div>

					<div class="leave-summary-item">
						<span class="symbol symbol-50px">
							<span class="symbol-label bg-primary-subtle">
								<i class="ki-duotone ki-car-2 text-primary" style="font-size:1.75rem;">
									<span class="path1"></span><span class="path2"></span><span class="path3"></span>
									<span class="path4"></span><span class="path5"></span><span class="path6"></span>
								</i>
							</span>
						</span>
						<div class="d-flex flex-column">
							<span class="fw-bold text-gray-800" style="font-size:15.88px; line-height:1.21;">
								<fmt:formatNumber type="number" pattern="#.##" value="${leave_2}"/>/<fmt:formatNumber type="number" pattern="#.##" value="${quota_2}"/>
								<c:set var="leaveWA2" value="${empty LeaveWAnumT2 ? 0 : LeaveWAnumT2}" />
								<c:if test="${leaveWA2 > 0}">
									<span class="badge badge-sm badge-warning"><fmt:formatNumber type="number" pattern="#.##" value="${leaveWA2}"/></span>
								</c:if>
							</span>
							<span class="text-gray-600" style="font-size:12.35px; line-height:1.21;">${type_2}</span>
						</div>
					</div>

					<!-- LIFF ยกเลิกการลาประเภทนี้ (type 6 ลาพักร้อนที่เหลือจากปีก่อน) -->
					<!-- <div class="leave-summary-item">
						<span class="symbol symbol-50px">
							<span class="symbol-label bg-light-warning">
								<i class="ki-duotone ki-timer text-warning" style="font-size:1.75rem;">
									<span class="path1"></span><span class="path2"></span><span class="path3"></span>
								</i>
							</span>
						</span>
						<div class="d-flex flex-column">
							<span class="fw-bold text-gray-800" style="font-size:15.88px; line-height:1.21;">
								<fmt:formatNumber type="number" pattern="#.##" value="${leave_6}"/>
								<c:if test="${quotaLastYear.doubleValue() > 0}">/<fmt:formatNumber type="number" pattern="#.##" value="${quotaLastYear}"/></c:if>
								<c:if test="${LeaveWAnumT6.doubleValue() > 0}">
									<span class="badge badge-sm badge-warning"><fmt:formatNumber type="number" pattern="#.##" value="${LeaveWAnumT6}"/></span>
								</c:if>
							</span>
							<span class="text-gray-600" style="font-size:12.35px; line-height:1.21;">${type_6}</span>
						</div>
					</div> -->

					<div class="leave-summary-item">
						<span class="symbol symbol-50px">
							<span class="symbol-label bg-light-info">
								<i class="ki-duotone ki-pulse text-info" style="font-size:1.75rem;">
									<span class="path1"></span><span class="path2"></span>
								</i>
							</span>
						</span>
						<div class="d-flex flex-column">
							<span class="fw-bold text-gray-800" style="font-size:15.88px; line-height:1.21;">
								<fmt:formatNumber type="number" pattern="#.##" value="${leave_3}"/>
								<c:if test="${LeaveWAnumT3.doubleValue() > 0}">
									<span class="badge badge-sm badge-warning"><fmt:formatNumber type="number" pattern="#.##" value="${LeaveWAnumT3}"/></span>
								</c:if>
							</span>
							<span class="text-gray-600" style="font-size:12.35px; line-height:1.21;">${type_3}</span>
						</div>
					</div>

					<div class="leave-summary-item">
						<span class="symbol symbol-50px">
							<span class="symbol-label bg-light-danger">
								<i class="ki-duotone ki-calendar-remove text-danger" style="font-size:1.75rem;">
									<span class="path1"></span><span class="path2"></span><span class="path3"></span>
									<span class="path4"></span><span class="path5"></span><span class="path6"></span>
								</i>
							</span>
						</span>
						<div class="d-flex flex-column">
							<span class="fw-bold text-gray-800" style="font-size:15.88px; line-height:1.21;">
								<fmt:formatNumber type="number" pattern="#.##" value="${leave_4}"/>
								<c:if test="${LeaveWAnumT4.doubleValue() > 0}">
									<span class="badge badge-sm badge-warning"><fmt:formatNumber type="number" pattern="#.##" value="${LeaveWAnumT4}"/></span>
								</c:if>
							</span>
							<span class="text-gray-600" style="font-size:12.35px; line-height:1.21;">${type_4}</span>
						</div>
					</div>

					<div class="leave-summary-item">
						<span class="symbol symbol-50px">
							<span class="symbol-label bg-light-dark">
								<i class="ki-duotone ki-brifecase-cros text-dark" style="font-size:1.75rem;">
									<span class="path1"></span><span class="path2"></span><span class="path3"></span>
								</i>
							</span>
						</span>
						<div class="d-flex flex-column">
							<span class="fw-bold text-gray-800" style="font-size:15.88px; line-height:1.21;">
								<fmt:formatNumber type="number" pattern="#.##" value="${leave_5}"/>
								<c:if test="${LeaveWAnumT5.doubleValue() > 0}">
									<span class="badge badge-sm badge-warning"><fmt:formatNumber type="number" pattern="#.##" value="${LeaveWAnumT5}"/></span>
								</c:if>
							</span>
							<span class="text-gray-600" style="font-size:12.35px; line-height:1.21;">${type_5}</span>
						</div>
					</div>

					<div class="leave-summary-item">
						<span class="symbol symbol-50px">
							<span class="symbol-label" style="background-color: #4B5675;">
								<i class="ki-duotone ki-abstract-12 " style="color:#FFFFFF; font-size:1.75rem;">
									<span class="path1"></span><span class="path2"></span>
								</i>
							</span>
						</span>
						<div class="d-flex flex-column">
							<span class="fw-bold text-gray-800" style="font-size:15.88px; line-height:1.21;">
								<fmt:formatNumber type="number" pattern="#.##" value="${leave_7}"/>
								<c:if test="${LeaveWAnumT7.doubleValue() > 0}">
									<span class="badge badge-sm badge-warning"><fmt:formatNumber type="number" pattern="#.##" value="${LeaveWAnumT7}"/></span>
								</c:if>
							</span>
							<span class="text-gray-600" style="font-size:12.35px; line-height:1.21;">${type_7}</span>
						</div>
					</div>
				</div>
				<div class="leave-summary-dots" id="leaveSummaryDots"></div>
			</div>
		</div>
	</div>

	<!-- Leave List -->
	<div class="d-flex align-items-center justify-content-between mt-2 mb-4">
		<span class="fw-bold text-gray-900" style="font-size:16px; line-height:1;">${fn:length(leavelist)} Items Found</span>
		<c:set var="isLatestStatus" value="${param.sort == 'latest_status'}" />
		<button type="button" id="sortToggleBtn" class="liff-sort-btn" onclick="toggleSort()" aria-pressed="${isLatestStatus}">
			<span>${isLatestStatus ? 'Latest Status' : 'Leave Date'}</span><span class="liff-sort-icon">↓</span>
		</button>
	</div>

	<div id="leaveList">
		<c:forEach var="leave" items="${leavelist}" varStatus="status">

			<div class="card card-bordered mb-3">
				<div class="card-header" style="padding:16px; min-height:auto; flex-wrap:nowrap;">
					<div class="d-flex align-items-center gap-2" style="min-width:0; overflow:hidden;">
						<span class="fw-bold text-primary fs-4" style="flex:none; line-height:1; letter-spacing:0;">#${leave.leave_id}</span>
						<span class="fs-4 fw-bold text-gray-800" style="line-height:1.4; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;">${leave.leave_type_name}</span>
					</div>
					<div class="d-inline-flex align-items-center" style="gap:10px; flex:none;">
						<a href="javascript:void(0)" class="btn btn-icon btn-sm bg-info-subtle" onclick="leaveStatus(${leave.leave_id})">
							<i class="ki-duotone ki-document text-info" style="font-size:1.45rem;"><span class="path1"></span><span class="path2"></span></i>
						</a>
						<a data-note="btn edit" href="line_NewLeaveEdit?id=${leave.leave_id}" title="Edit" class="btn btn-icon btn-sm bg-primary-subtle">
							<i class="ki-duotone ki-pencil text-primary" style="font-size:1.45rem;"><span class="path1"></span><span class="path2"></span></i>
						</a>
						<c:choose>
							<c:when test="${leave.leave_status_id.toString() == 0}">
								<a data-note="btn delete" onclick="changeStatus(${leave.leave_id});" title="Delete" class="btn btn-icon btn-sm bg-danger-subtle">
									<i class="ki-duotone ki-trash text-danger" style="font-size:1.45rem;"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i>
								</a>
							</c:when>
							<c:when test="${leave.leave_status_id.toString() != 0}">
								<a data-note="btn delete" class="btn btn-icon btn-sm btn-light-secondary disabled">
									<i class="ki-duotone ki-trash" style="font-size:1.45rem;"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i>
								</a>
							</c:when>
						</c:choose>
					</div>
				</div>
				<div class="card-body" style="padding:16px;">

					<div class="fw-bold fs-6 text-dark mb-3">${fn:escapeXml(leave.name)}</div>

					<div class="d-flex align-items-center gap-1 fs-7 text-gray-600 mb-3">
						<i class="ki-duotone ki-calendar-2 fs-6"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i>
						<span><fmt:formatDate value="${leave.start_date}" type="date" pattern="d MMM yyyy"/> - <fmt:formatDate value="${leave.end_date}" type="date" pattern="d MMM yyyy"/></span>
						<span class="badge badge-light-primary fs-8 ms-1"><fmt:formatNumber type="number" pattern="#.###" value="${leave.no_day}"/> day</span>
					</div>

					<div class="d-flex flex-column gap-2 fs-7 text-gray-600 mb-3">
						<c:if test="${leave.half_day != null}">
							<div class="d-inline-flex align-items-center gap-1">
								<i class="ki-duotone ki-calendar-8 fs-6"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span></i>
								<c:if test="${leave.half_day.toString() == 0}">เต็มวัน</c:if>
								<c:if test="${leave.half_day.toString() == 1}">ช่วงเช้า</c:if>
								<c:if test="${leave.half_day.toString() == 2}">ช่วงบ่าย</c:if>
								<c:if test="${leave.half_day.toString() == 3}">ช่วงเวลา</c:if>
							</div>
						</c:if>
						<div class="d-inline-flex align-items-center gap-1">
							<i class="ki-duotone ki-time fs-6"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i>
							${leave.start_time} - ${leave.end_time}
						</div>
					</div>

					<c:if test="${not empty leave.leave_file}">
						<div class="d-flex align-items-center gap-1 fs-7 mb-1">
							<i class="ki-duotone ki-document"><span class="path1"></span><span class="path2"></span></i>
							<a href="line_preview_File?id=${leave.leave_file}" target="_blank" class="text-primary text-hover-underline">${fn:escapeXml(leave.file_name)}${fn:escapeXml(leave.type)}</a>
						</div>
					</c:if>

					<div class="d-flex align-items-center justify-content-between">
						<span class="fs-8 text-muted">Request Date: <fmt:formatDate value="${leave.time_create}" type="date" pattern="d MMM yyyy"/></span>
						<c:if test="${leave.leave_status_id.toString() == '0'}"><span class="badge badge-light-warning leave-status-badge fs-8">Wait for approve</span></c:if>
						<c:if test="${leave.leave_status_id.toString() == '1'}"><span class="badge badge-light-success leave-status-badge fs-8">Approved</span></c:if>
						<c:if test="${leave.leave_status_id.toString() == '2'}"><span class="badge badge-light-danger leave-status-badge fs-8">Reject</span></c:if>
						<c:if test="${leave.leave_status_id.toString() == '3'}"><span class="badge badge-light-dark leave-status-badge fs-8">Cancel</span></c:if>
					</div>

				</div>
			</div>
		</c:forEach>

		<c:if test="${empty leavelist}">
			<div class="text-center py-10">
				<div class="d-inline-flex align-items-center justify-content-center mb-4" style="width:88px; height:88px; border-radius:50%; background:#EFF3FA;">
					<i class="ki-duotone ki-calendar-search text-primary" style="font-size:2.5rem;">
						<span class="path1"></span><span class="path2"></span><span class="path3"></span>
						<span class="path4"></span><span class="path5"></span><span class="path6"></span>
					</i>
				</div>
				<div class="fs-6 fw-semibold text-gray-800 mb-1">No leave records found</div>
				<div class="fs-8 text-muted">ยังไม่มีข้อมูลการลาในช่วงเวลานี้</div>
			</div>
		</c:if>
	</div>

</div>

<%-- ===== OLD: modal ที่ใช้ร่วมกับ desktop (disabled, kept for reference) =====
<jsp:include page="/pages-back/common/leave_modal.jsp">
    <jsp:param name="showApproverInfo" value="true"/>
</jsp:include>
--%>
<%-- ===== OLD: leaveStatus() ของ desktop (disabled, kept for reference) ===== --%>
<!-- <script>
function leaveStatus(id) {
	const modal = new bootstrap.Modal(document.getElementById('leaveDetailModal'));
	modal.show();

	console.log(id);

	$.ajax({
		url: "new_modalLeaveStatus",
		method: "POST",
		data: { leaveId: id },
		success: function (data) {
			var obj = JSON.parse(data);
			console.log(obj);

			$('#leaveid').html(obj.leave_id);
			$('#employeeId').html(obj.employeeId + " ");
			$('#username').html(obj.name);
			//$('#userid').html(obj.user_id);
			$('#stime').html(obj.start_time);
			$('#etime').html(obj.end_time);
			$('#desc').html(obj.description);
			$('#ucEmpId').html(obj.ucEmpId);
			$('#ucName').html(obj.ucName);
			
			// validate file name is empty
			if (obj.leave_file_name && obj.leave_file_name !== "null") {
			    $('#file')
			        .html(obj.leave_file_name + (obj.leave_file_type || ''))
			        .attr('href', 'preview_File?id=' + obj.leave_file_id)
			        .attr('target', '_blank')
			        .show();
			} else {
			    $('#file')
			        .html('No file attached')
			        .removeAttr('href')
			        .removeAttr('target')
			        .removeClass('text-primary text-hover-underline');
			}

	      // leave type name
			if (obj.leave_type_id == 1) { $('#leavetype').html("ลาพักร้อน"); }
			if (obj.leave_type_id == 2) { $('#leavetype').html("ลากิจ"); }
			if (obj.leave_type_id == 3) { $('#leavetype').html("ลาป่วย"); }
			if (obj.leave_type_id == 4) { $('#leavetype').html("ขาดงาน"); }
			if (obj.leave_type_id == 5) { $('#leavetype').html("ลาโดยไม่รับค่าจ้าง"); }
			if (obj.leave_type_id == 6) { $('#leavetype').html("ลาพักร้อนที่เหลือจากปีก่อน"); }
			if (obj.leave_type_id == 7) { $('#leavetype').html("ลาอื่นๆ"); }
			if (obj.leave_type_id == 9) { $('#leavetype').html("อื่นๆ"); }

	      // date formatting
			var startdate = (obj.start_date).split(",");
			var sdate = moment(startdate[0]).format("D MMM YYYY");
			$('#sdate').html(sdate);

			var enddate = (obj.end_date).split(",");
			var edate = moment(enddate[0]).format("D MMM YYYY");
			$('#edate').html(edate);

			$('#noday').html(obj.no_day + " Day");

			//var timecreate = (obj.time_create).split(",");
			//var tcreate = moment(timecreate[0]).format("D MMM YYYY");
			$('#timecreate').html(obj.time_create.replace(",", " "));

	      // leave status
			if (obj.leave_status_id == '0') {//Wait for Approving
				$('#leavestatus')
					.html("Wait for Approving")
					.removeClass()
					.addClass('badge badge-light-warning');
				$('#status_panel').hide();
				$('#status_title').html("Approver")
					.removeClass('text-danger')
					.addClass('text-primary');
			}
			else if (obj.leave_status_id == '1') {//Approved
				$('#leavestatus')
					.html("Approved")
					.removeClass()
					.addClass('badge badge-light-success');
				$('#status_title')
					.html("Approver")
					.removeClass('text-danger')
					.addClass('text-primary');
				$('#status_panel').show();
				$('#approved_detail').show();
				//$('#approver').html(obj.user_update);
				$('#aprEmpId').html(obj.aprEmpId + " ");
				$('#aprName').html(obj.aprName + " - ");
				$('#aprRole').html(obj.aprRole);
				$('#timeupdate').html(moment(obj.time_update).format("D MMM YYYY, HH:mm"));
				$('#reason_s').html(obj.reason);
			}
			else if (obj.leave_status_id == '2') {//Reject
				$('#leavestatus')
					.html("Reject")
					.removeClass()
					.addClass('badge badge-light-danger');
				$('#status_title')
					.html("Approver")
					.removeClass('text-danger')
					.addClass('text-primary');
				$('#status_panel').show();
				$('#approved_detail').show();
				//$('#approver').html(obj.user_update);
				$('#aprEmpId').html(obj.aprEmpId + " ");
				$('#aprName').html(obj.aprName + " - ");
				$('#aprRole').html(obj.aprRole);
				$('#timeupdate').html(moment(obj.time_update).format("D MMM YYYY, HH:mm"));
				$('#reason_s').html(obj.reason);
			}
			else if (obj.leave_status_id == '3') {//Cancel
				$('#leavestatus')
					.html("Cancel")
					.removeClass()
					.addClass('badge badge-light-dark');
				$('#status_title')
					.html("Cancel")
					.removeClass('text-primary')
					.addClass('text-danger');
				$('#status_panel').show();
				$('#approved_detail').show();
				//$('#approver').html(obj.user_update);
				$('#aprEmpId').html(obj.aprEmpId + " ");
				$('#aprName').html(obj.aprName + " - ");
				$('#aprRole').html(obj.aprRole);
				$('#timeupdate').html(moment(obj.time_update).format("D MMM YYYY, HH:mm"));
				$('#reason_s').html(obj.reason);
			}
		},
		error: function () {
			alert("Error retrieving leave detail.");
		}
	});
}
</script>  -->

<%-- ===== NEW: modal รายละเอียดใบลา LIFF (ตัวกลาง) ===== --%>
<jsp:include page="/pages-line/common/leave_modal.jsp">
	<jsp:param name="showDescFiles" value="true"/>
</jsp:include>

<%-- ===== NEW: script หน้า My Leave ===== --%>
<script>
/* ---------- ไปหน้าอื่น + spinner ---------- */
	function filterByYear(year) {
		const sort = new URLSearchParams(window.location.search).get('sort');
		document.getElementById('liffLoadingOverlay').style.display = 'flex';
		window.location.href = 'line_new_myleave_list?Id=${onlineUser.id}&startdate=01-01-' + year + '&enddate=31-12-' + year
			+ (sort ? '&sort=' + sort : '');
	}

	function toggleSort() {
		const params = new URLSearchParams(window.location.search);
		if (params.has('sort')) {
			params.delete('sort');
		} else {
			params.set('sort', 'latest_status');
		}
		showSortLoading();
		window.location.href = 'line_new_myleave_list?' + params.toString();
	}

	function showSortLoading() {
		const btn = document.getElementById('sortToggleBtn');
		btn.disabled = true;
		btn.querySelector('.liff-sort-icon').innerHTML = '<span class="spinner-border text-primary" role="status"></span>';
		$('#leaveList').addClass('d-none');
		// skeleton loading
		const bar = (w, h) => '<span class="liff-skel" style="width:' + w + '; height:' + (h || 12) + 'px;"></span>';
		const row = (w) => '<div class="liff-skel-row"><span class="liff-skel liff-skel-dot"></span>' + bar(w) + '</div>';
		const skel = '<div class="card card-bordered mb-3">'
			+ '<div class="card-header" style="padding:16px; min-height:auto; flex-wrap:nowrap;">'
			+ '<div class="d-flex align-items-center gap-2">' + bar('56px', 20) + bar('88px', 20) + '</div>'
			+ '<div class="d-inline-flex align-items-center" style="gap:10px;">'
			+ '<span class="liff-skel liff-skel-box"></span><span class="liff-skel liff-skel-box"></span><span class="liff-skel liff-skel-box"></span></div>'
			+ '</div>'
			+ '<div class="card-body d-flex flex-column gap-3" style="padding:16px;">'
			+ bar('55%', 16)
			+ '<div class="liff-skel-row"><span class="liff-skel liff-skel-dot"></span>' + bar('150px') + bar('40px', 18) + '</div>'
			+ row('60px') + row('90px')
			+ '<div class="d-flex align-items-center justify-content-between">' + bar('130px', 10) + bar('90px', 26) + '</div>'
			+ '</div></div>';
		$('#leaveList').before('<div id="sortSkeleton">' + skel + skel + skel + '</div>');
	}

	function hideSortLoading() {
		const btn = document.getElementById('sortToggleBtn');
		btn.disabled = false;
		btn.querySelector('.liff-sort-icon').textContent = '↓';
		$('#sortSkeleton').remove();
		$('#leaveList').removeClass('d-none');
	}

	function add() {
		document.getElementById('liffLoadingOverlay').style.display = 'flex';
		document.location = "line_NewLeaveAdd";
	}

	$(document).on('click', 'a[href^="line_NewLeaveEdit"]', function() {
		document.getElementById('liffLoadingOverlay').style.display = 'flex';
	});
	// กด Back กลับมา (bfcache) ซ่อน spinner / skeleton
	window.addEventListener('pageshow', function(e) {
		if (!e.persisted) return;
		document.getElementById('liffLoadingOverlay').style.display = 'none';
		hideSortLoading();
	});
</script>

<script>
/* ---------- Summary pager ---------- */
	(function () {
		var pager = document.getElementById('leaveSummaryPager');
		var dots = document.getElementById('leaveSummaryDots');
		if (!pager || !dots) return;
		var items = Array.prototype.slice.call(pager.querySelectorAll('.leave-summary-item'));
		if (items.length === 0) return;

		var pageCount = Math.ceil(items.length / 4);
		var pages = [];
		for (var p = 0; p < pageCount; p++) {
			var pageEl = document.createElement('div');
			pageEl.className = 'leave-summary-page';
			var gridEl = document.createElement('div');
			gridEl.className = 'leave-summary-grid';
			items.slice(p * 4, p * 4 + 4).forEach(function (item) { gridEl.appendChild(item); });
			pageEl.appendChild(gridEl);
			pages.push(pageEl);
		}
		pager.innerHTML = '';
		pages.forEach(function (pageEl) { pager.appendChild(pageEl); });

		dots.innerHTML = '';
		for (var i = 0; i < pageCount; i++) {
			var dot = document.createElement('span');
			if (i === 0) dot.className = 'active';
			dots.appendChild(dot);
		}
		if (pageCount <= 1) { dots.hidden = true; return; }

		var dotEls = dots.querySelectorAll('span');
		pager.addEventListener('scroll', function () {
			var page = Math.round(pager.scrollLeft / pager.clientWidth);
			dotEls.forEach(function (dot, i) {
				dot.classList.toggle('active', i === page);
			});
		}, { passive: true });
	})();
</script>

<script>
/* ---------- toast ---------- */
// ?saved=add / edit มาจาก doSubmit() หน้า Add/Edit
$(function () {
	const params = new URLSearchParams(window.location.search);
	const saved = params.get('saved');
	if (saved === 'add') {
		liffToastSuccess("Your leave request has been submitted.", "Saved successfully!");
	} else if (saved === 'edit') {
		liffToastSuccess("Your leave request has been updated.", "Updated successfully!");
	}
	if (saved) {
		params.delete('saved'); // เอาออกจาก URL กัน refresh แล้วขึ้นซ้ำ
		const qs = params.toString();
		history.replaceState(null, '', window.location.pathname + (qs ? '?' + qs : ''));
	}
});

/* ---------- ยกเลิกใบลา ---------- */
// ได้ HTTP 200 ทั้งสำเร็จ/ไม่สำเร็จ เช็กจากหน้าที่ได้กลับมา
function isCancelSuccess(html) {
	return typeof html === 'string' && html.indexOf('id="leaveDetailModal"') !== -1;
}

function changeStatus(id) {
    Swal.fire({
        title: "Are you sure?",
        html: `
            <p>You want to cancel this leave!</p>
            <span class="col-lg-12 d-block text-start">
                Please enter a reason.<span style="color:red;">*</span>
            </span>
            <textarea id="text" rows="4" class="form-control mt-2" placeholder="Enter reason..."></textarea>
        `,
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "Cancel Leave",
        cancelButtonText: "Close",
        customClass: {
            confirmButton: "btn btn-danger",
            cancelButton: "btn btn-light"
        },
        buttonsStyling: false,
        focusConfirm: false,

        preConfirm: () => {
            const val = document.getElementById('text').value.trim();
            if (!val) {
                Swal.showValidationMessage("Please enter a reason.");
                return false;
            }
            return val;
        }
    }).then((result) => {
        if (result.isConfirmed) {
            const val = result.value;

            if (val.length !== 0) {
                $.ajax({
                    url: "line_Leave_inListStatusToCancel",
                    type: "POST",
                    data: {
                        leave_id: id,
                        reason: val
                    },
                    success: function(response) {
                        if (!isCancelSuccess(response)) {
                            liffToastError("Unable to cancel leave. Please try again.", "Cancel failed");
                            return;
                        }
                        liffToastSuccess("Your leave has been cancelled.", "Cancelled successfully!");
                        setTimeout(function () {
                            window.location.reload(true);
                        }, 2000);
                    },
                    error: function() {
                        liffToastError("Unable to cancel leave. Please try again.", "Cancel failed");
                    }
                });
            }
        }

        if (result.isDismissed) {
            return false;
        }
    });
}
</script>

<script>
	// เปิดจาก notification (?leaveId=) ให้เปิด modal
	$(function () {
		var leaveId = new URLSearchParams(window.location.search).get("leaveId");
		if (leaveId && typeof leaveStatus === "function") {
			leaveStatus(leaveId);
		}
	});
</script>
