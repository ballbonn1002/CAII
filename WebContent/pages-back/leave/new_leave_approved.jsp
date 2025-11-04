<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="perm" uri="/WEB-INF/tlds/permission.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:setLocale value="en_US" />
<fmt:setTimeZone value="Asia/Bangkok" />

<c:set var="user_role" value="${user_role}"/> 
<fmt:formatDate type="date" value="${startdate}" pattern="dd-MM-yyyy" var="sd"/>
<fmt:formatDate type="date" value="${enddate}" pattern="dd-MM-yyyy" var="ed"/>

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
					<h1 class="page-heading d-flex text-gray-900 fw-bold fs-3 flex-column justify-content-center my-0">Leave Approve</h1>
					<!--end::Title-->
					<!--begin::Breadcrumb-->
					<ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
						<li class="breadcrumb-item text-muted"><a href="demo_dashboard" class="text-muted text-hover-primary">Home</a></li>
						<li class="breadcrumb-item"><span class="bullet bg-gray-500 w-5px h-2px"></span></li>
						<li class="breadcrumb-item text-muted">Leave Approve</li>
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
			<div id="kt_app_content_container" class="app-container container-fluid">

				<!-- DDL -->
				<div class="d-flex flex-row">
					<div class="flex-row-fluid mb-5">
						<form action="new_search_leave_approved" method="POST" id="searchForm">
							<div class="card card-flush bgi-no-repeat bgi-size-contain bgi-position-x-center border-0 mb-5 mb-xl-10">
								<div class="card-body">
								
									<div class="row g-5">
										<!-- Employee -->
										<div class="col-md-2">
											<div class="mb-5">
												<select class="form-select" id="name1" name="name1" >
													<perm:permission object="leave.viewall">
														<option value="All" id="All"
															<c:if test="${userSelect != null && userSelect == 'All'}"> selected </c:if>>All Employee</option>
													</perm:permission>
														<option value="All2"
															<c:if test="${userSelect != null && userSelect == 'All2'}"> selected </c:if>>All Manage</option>
												</select>
											</div>
										</div>
										
										<div class="col-md-10">
											<div class="mb-5">
												<select class="form-select" id="name2" name="name2" onchange="this.form.submit()"></select>
											</div>
										</div>
										<!-- Employee -->
									</div>
									
									<div class="row g-5">
										<!-- Leave Type -->
										<div class="col-md-4">
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
										<div class="col-md-4">
											<div class="mb-5">
												<!-- <label class="form-label">Status</label> -->
												<select class="form-select" data-placeholder="All Status" name="appr" id="appr" onchange="this.form.submit()">
													<option value="4" id="All1"
														<c:if test="${ appr == 4 }">
															<c:out value="selected=selected"/>
														</c:if>>All Status</option>
													<option value="0" <c:if test="${ appr == 0 }">
															<c:out value="selected=selected"/>
														</c:if>>Waiting
														for approve</option>
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
										<div class="col-md-4">
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
													<fmt:formatNumber type="number" pattern="#.##" value="${LeavenumT1}"/>
												</span>
												<span class="text-muted fs-7">
												${type_1}
												</span>
												<span class="text-muted fs-7">
												WA: <fmt:formatNumber type="number" pattern="#.###" value="${LeaveWAnumT1}"/>d
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
													<fmt:formatNumber type="number" pattern="#.##" value="${LeavenumT2}"/>
												</span>
												<span class="text-muted fs-7">
												${type_2}
												</span>
												<span class="text-muted fs-7">
												WA: <fmt:formatNumber type="number" pattern="#.###" value="${LeaveWAnumT2}"/>d
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
													<fmt:formatNumber type="number" pattern="#.##" value="${LeavenumT6}"/>
													<c:if test="${quota_4 != null || quota_4 != 0.0 || quota_4 != ''} ">
														/<fmt:formatNumber type="number" pattern="#" value="${quota_4}"/>
													</c:if>
												</span>
												<span class="text-muted fs-7">
												${type_6}
												</span>
												<span class="text-muted fs-7">
												WA: <fmt:formatNumber type="number" pattern="#.###" value="${LeaveWAnumT6}"/>d
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
													<fmt:formatNumber type="number" pattern="#.##" value="${LeavenumT3}"/>
													<c:if test="${quota_3 != null || quota_3 != 0.0 || quota_3 != ''} ">
														/<fmt:formatNumber type="number" pattern="#" value="${quota_3}"/>
													</c:if>
												</span>
												<span class="text-muted fs-7">
												${type_3}
												</span>
												<span class="text-muted fs-7">
												WA: <fmt:formatNumber type="number" pattern="#.###" value="${LeaveWAnumT3}"/>d
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
													<fmt:formatNumber type="number" pattern="#.##" value="${LeavenumT4}"/>
												</span>
												<span class="text-muted fs-7">
													${type_4}
												</span>
												<span class="text-muted fs-7">
												WA: <fmt:formatNumber type="number" pattern="#.###" value="${LeaveWAnumT4}"/>d
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
													<fmt:formatNumber type="number" pattern="#.##" value="${LeavenumT5}"/>
												</span>
												<span class="text-muted fs-7">
													${type_5}
												</span>
												<span class="text-muted fs-7">
												WA: <fmt:formatNumber type="number" pattern="#.###" value="${LeaveWAnumT5}"/>d
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
													<fmt:formatNumber type="number" pattern="#.##" value="${LeavenumT7}"/>
												</span>
												<span class="text-muted fs-7">
												${type_7}
												</span>
												<span class="text-muted fs-7">
												WA: <fmt:formatNumber type="number" pattern="#.###" value="${LeaveWAnumT7}"/>d
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


				<!-- Recent Update -->
				<div class="d-flex flex-wrap flex-stack pb-7">
					<!--begin::Title-->
					<div class="d-flex flex-wrap align-items-center my-1">
						<h3 class="fw-bold me-5 my-1">
							${fn:length(leaveList)} Items Found <span class="text-gray-500 fs-6">by Recent Updates ↓</span>
						</h3>
					</div>
					<!--end::Title-->

					<!--begin::Btn Create-->
					<div class="d-flex flex-wrap my-1">
						<a href="javascript:void(0)" class="btn btn-success btn-lg" onclick="add()">
							<i class="ki-duotone ki-plus"></i>
							Create
						</a>
					</div>
					<!--end::Btn Create-->
					<!--begin::Btn Export Excel-->
					<!-- <div class="d-flex flex-wrap my-1">
						<a href="javascript:void(0)" class="btn btn-success btn-lg" onclick="add()">
							<i class="ki-duotone ki-plus"></i>
							Export to Excel
						</a>
					</div> -->
					<!--end::Btn Export Excel-->
				</div>
				<!-- Recent Update -->


				<!--begin::Leave List-->
				<div class="d-flex flex-row">
					<div class="flex-row-fluid mb-5">
						<c:forEach var="leave" items="${leaveList}" varStatus="status">
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
											</c:if>

										<span class="fw-semibold" style="font-weight: 1000 !important;">${leave.leave_type_name}</span>
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
													<a data-note="btn edit" href="NewLeaveEdit?id=${leave.leave_id}&la=1" title="Edit" class="btn btn-icon btn-sm btn-light-primary">
														<i class="ki-duotone ki-pencil fs-5">
															<span class="path1"></span>
															<span class="path2"></span>
														</i>
													</a>
													<a data-note="btn delete" onclick="changStatus(${leave.leave_id});" title="Delete" class="btn btn-icon btn-sm btn-light-danger">
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
													<a data-note="btn edit" class="btn btn-icon btn-sm btn-light-secondary disabled">
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
								<div class="card-header fs-6">

									<div class="d-flex align-items-center mb-2">
										<div class="d-flex flex-wrap align-items-center gap-3">
											<div class="fw-bold text-dark">${leave.name}</div>

											<div class="d-flex align-items-center">
												<i class="ki-duotone ki-calendar-2 fs-5">
													<span class="path1"></span>
													<span class="path2"></span>
													<span class="path3"></span>
													<span class="path4"></span>
													<span class="path5"></span>
												</i>
												<fmt:formatDate value="${leave.start_date}" type="date" pattern="d MMM yyyy"></fmt:formatDate> - <fmt:formatDate value="${leave.end_date}" type="date" pattern="d MMM yyyy"></fmt:formatDate>
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
	<!--end::Content wrapper-->

</div>
<!--end:::Main-->

<!--begin::Modal - Leave Detail-->
<div class="modal fade" id="leaveDetailModal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">

			<!--begin::Header-->
			<div class="modal-header">
				<h2 class="modal-title">Leave</h2>
				<div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
					<i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
				</div>
			</div>
			<!--end::Header-->

			<!--begin::Body-->
			<div class="modal-body">
				<div class="row gx-5 gy-4">
					<!-- Left -->
					<div class="col-md-7">
						<div class="d-flex align-items-center mb-3 fs-5">
							<a href="#" class="fw-bold text-primary me-5">#<span id="leaveid"></span></a>
							<span class="fw-semibold text-dark me-5" id="leavetype"></span>
							<span class="badge badge-light-primary fs-7 fw-semibold" id="noday"></span>
						</div>

						<div class="d-flex align-items-center text-gray-700 mb-2 fs-6">
							<i class="ki-duotone ki-calendar-8 fs-5 me-2 text-gray-500"><span class="path1"></span><span class="path2"></span></i>
							<span id="sdate"></span> - <span id="edate"></span>
						</div>

						<div class="d-flex align-items-center text-gray-700 mb-2 fs-6">
							<i class="ki-duotone ki-minus fs-5 me-2 text-gray-500"><span class="path1"></span><span class="path2"></span></i>
							<span id="desc"></span>
						</div>

						<span id="leavestatus" class="badge badge-lg mt-3 fs-7 fw-semibold"></span>
					</div>

					<!-- Right -->
					<div class="col-md-5">
						<div class="fw-semibold text-dark mb-2 fs-5" id="userid"></div>

						<div class="d-flex align-items-center text-gray-700 mb-2 fs-6">
							<i class="ki-duotone ki-time fs-5 me-2 text-gray-500"><span class="path1"></span><span class="path2"></span></i>
							<span id="stime"></span> - <span id="etime"></span>
						</div>

						<div class="d-flex align-items-center text-gray-700 mb-2 fs-6">
							<i class="ki-duotone ki-file fs-5 me-2 text-gray-500"><span class="path1"></span><span class="path2"></span></i>
							<a id="file" href="#" target="_blank" class="text-primary text-hover-underline"></a>
							<div class="text-muted fs-8">
								Request date: <span id="timecreate"></span>
							</div>
						</div>

					</div>
				</div>

				<!-- Approver Info -->
				<div id="status_panel" class="mt-5" style="display: none;">
					<h3 class="text-info fw-semibold mb-3" id="status_title"></h3>
					<div class="row gx-5 gy-3 fs-6" id="approved_detail">
						<div class="col-md-4">
							<i class="ki-duotone ki-user fs-5 me-2 text-gray-500"><span class="path1"></span><span class="path2"></span></i>
							<span id="approver"></span>
						</div>
						<div class="col-md-4">
							<i class="ki-duotone ki-calendar-8 fs-5 me-2 text-gray-500"><span class="path1"></span><span class="path2"></span></i>
							<span id="timeupdate"></span>
						</div>
						<div class="col-md-4">
							<i class="ki-duotone ki-message-text fs-5 me-2 text-gray-500"><span class="path1"></span><span class="path2"></span></i>
							<span id="reason_s"></span>
						</div>
					</div>
				</div>
			</div>
			<!--end::Body-->

			<!--begin::Footer-->
			<div class="modal-footer">
				<button type="button" class="btn btn-lg btn-light" data-bs-dismiss="modal">Close</button>
			</div>
			<!--end::Footer-->
		</div>
	</div>
</div>
<!--end::Modal - Leave Detail-->

<<script>
$(document).ready(function(){
	var userSelect =  '${userSelect}';
	var userSelect2 =  '${userSelect2}';
	var role_authorized = '${role_authorized}';
	
	var value = null;
	var user_login = '${userS}';

	console.log(userSelect);
	console.log(userSelect2);

	console.log(role_authorized);
	if(role_authorized == "1"){
		value = "All";
		CreateListUsers(value, user_login, userSelect2);
	}else if(role_authorized == "0"){
		value = "All2";
		CreateListUsers(value, user_login, userSelect2);
	}
	
 	if(userSelect2 == null || userSelect2 == ""){
	 	$("#name2").select2({
		    placeholder: "Select Employee",
		    allowClear: true,
		});
	}
	
	$('#name1').on('change', function() {
		console.log("name1 change");
		console.log($(this).val());
		var value = $(this).val();
		CreateListUsers(value, user_login, userSelect2);
	});
	
});

function CreateListUsers(value, user_login, userSelect2) {
	const select = document.getElementById('name2');
	$.ajax({
		url: "CreateListUsers",
		method: "POST",
		type: "JSON",
		data: {
			"select_list": value,
			"user_login": user_login
		},
		success: function(data) {
			var obj = JSON.parse(data);
			console.log(obj);
			let option = '<option></option>';
			
			for (var i = 0; i < obj.length; i++) {
				var string1 = obj[i].id ? obj[i].id.toLowerCase() : "";
				if (userSelect2 != null) {
					var string2 = userSelect2.toLowerCase();
				}
				var txt = null;
				if (string1 === string2) {
					txt = "selected";
				}
				
				var employeeId = obj[i].employee_id ? obj[i].employee_id : "";
				var name = obj[i].name ? obj[i].name : "";
				var nameEn = obj[i].name_en ? obj[i].name_en : "";
				
				var displayText = '';
				if (employeeId) {
					displayText += employeeId;
				}
				if (name) {
					displayText += (displayText ? ' - ' : '') + name;
				}
				if (nameEn) {
					displayText += (displayText ? ' - ' : '') + nameEn;
				}
				
				option += '<option value="'+obj[i].id+'" id="'+obj[i].id+'" '+txt+'>'+displayText+'</option>';
			}
			select.innerHTML = option;
		}
	});
}
</script>

<script>
	/* $("#kt_daterangepicker").daterangepicker({
		startDate : moment().startOf("year"),
		endDate : moment().endOf("year"),
		locale : {
			format : "DD MMM YYYY"
		}
	}); */

	$(document).ready(function () {
		// กำหนดค่าเริ่มต้น
		/* var start = moment("2025-01-01", "YYYY-MM-DD");
		var end = moment("2025-12-31", "YYYY-MM-DD"); */
		var start = moment("<fmt:formatDate value='${startdate}' pattern='dd-MM-yyyy'/>", "DD-MM-YYYY");
		var end = moment("<fmt:formatDate value='${enddate}' pattern='dd-MM-yyyy'/>", "DD-MM-YYYY");

		// สร้าง Date Range Picker
		/* $("#kt_daterangepicker").daterangepicker({
			startDate: start,
			endDate: end,
			locale: {
				format: "DD MMM YYYY"
			}
		}, function (start, end) {
			// อัปเดต hidden input ทุกครั้งที่เลือกช่วงวันใหม่
			$("#startdate").val(start.format("DD-MM-YYYY"));
			$("#enddate").val(end.format("DD-MM-YYYY"));

			// auto-submit form
			$("#searchForm").submit();
		}); */
		$("#kt_daterangepicker").daterangepicker({
	        startDate: start,
	        endDate: end,
			locale: {
				format: "DD MMM YYYY",  // รูปแบบวันที่
				monthNames: [
				  "January", "February", "March", "April", "May", "June",
				  "July", "August", "September", "October", "November", "December"
				],  // กำหนดชื่อเดือนเต็ม
	        },
	        showDropdowns: true,     // มี dropdown เดือน/ปี
	        autoApply: true,  // ยืนยันโดยอัตโนมัติเมื่อเลือกวันที่
	        linkedCalendars: false,  // เดือนซ้าย-ขวาอิสระ ไม่ fix
	        alwaysShowCalendars: true,
	        opens: 'center'
		}, function (start, end) {
			// อัปเดต hidden input ทุกครั้งที่เลือกช่วงวันใหม่
			$("#startdate").val(start.format("DD-MM-YYYY"));
			$("#enddate").val(end.format("DD-MM-YYYY"));

			// auto-submit form
			$("#searchForm").submit();
		});

		// ตั้งค่าเริ่มต้นตอนโหลด
		$("#startdate").val(start.format("DD-MM-YYYY"));
		$("#enddate").val(end.format("DD-MM-YYYY"));


	    /* $('#kt_daterangepicker_single').daterangepicker({
	        startDate: moment().startOf('year'),
	        endDate: moment().endOf('year'),
	        locale: {
	            format: 'DD MMM YYYY'
	        },
	        singleDatePicker: false,    // false = ใช้ช่วงวัน (range)
	        showDropdowns: true,        // เพิ่ม dropdown เดือน/ปี
	        linkedCalendars: false,     // ทำให้แต่ละปฏิทินอิสระ
	        alwaysShowCalendars: true,  // คงแสดงปฏิทินไว้
	        opens: 'center'             // เปิดกลางหน้าจอ
	    }, function(start, end) {
	        console.log("Selected range: " + start.format("DD MMM YYYY") + " - " + end.format("DD MMM YYYY"));
	    }); */

/* 	    $('#kt_daterangepicker_dual').daterangepicker({
	        startDate: moment().startOf('year'),
	        endDate: moment().endOf('year'),
	        locale: {
	            format: 'DD MMM YYYY'
	        },
	        showDropdowns: true,     // มี dropdown เดือน/ปี
	        linkedCalendars: false,  // เดือนซ้าย-ขวาอิสระ ไม่ fix
	        alwaysShowCalendars: true,
	        opens: 'center'
	    }, function(start, end) {
	        console.log("Selected range: " + start.format("DD MMM YYYY") + " - " + end.format("DD MMM YYYY"));
	    });
 */		
	});
	
</script>
<script>
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
			$('#userid').html(obj.user_id);
			$('#stime').html(obj.start_time);
			$('#etime').html(obj.end_time);
			$('#desc').html(obj.description);
			$('#file')
				.html(obj.leave_file_name + obj.leave_file_type)
				.attr('href', 'preview_File?id=' + obj.leave_file_id)
				.attr('target', '_blank');

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

			var timecreate = (obj.time_create).split(",");
			var tcreate = moment(timecreate[0]).format("D MMM YYYY");
			$('#timecreate').html(tcreate);

	      // leave status
			if (obj.leave_status_id == '0') {
				$('#leavestatus')
					.html("Wait for Approving")
					.removeClass()
					.addClass('badge badge-light-warning');
				$('#status_panel').hide();
				$('#status_title').html("Approver")
					.removeClass('text-danger')
					.addClass('text-info');
			}
			else if (obj.leave_status_id == '1') {
				$('#leavestatus')
					.html("Approved")
					.removeClass()
					.addClass('badge badge-light-success');
				$('#status_title')
					.html("Approver")
					.removeClass('text-danger')
					.addClass('text-info');
				$('#status_panel').show();
				$('#approved_detail').show();
				$('#approver').html(obj.user_update);
				$('#timeupdate').html(moment(obj.time_update).format("D MMM YYYY"));
				$('#reason_s').html(obj.reason);
			}
			else if (obj.leave_status_id == '2') {
				$('#leavestatus')
					.html("Reject")
					.removeClass()
					.addClass('badge badge-light-danger');
				$('#status_title')
					.html("Approver")
					.removeClass('text-danger')
					.addClass('text-info');
				$('#status_panel').show();
				$('#approved_detail').show();
				$('#approver').html(obj.user_update);
				$('#timeupdate').html(moment(obj.time_update).format("D MMM YYYY"));
				$('#reason_s').html(obj.reason);
			}
			else if (obj.leave_status_id == '3') {
				$('#leavestatus')
					.html("Cancel")
					.removeClass()
					.addClass('badge badge-light-dark');
				$('#status_title')
					.html("Cancel")
					.removeClass('text-info')
					.addClass('text-danger');
				$('#status_panel').show();
				$('#approved_detail').show();
				$('#approver').html(obj.user_update);
				$('#timeupdate').html(moment(obj.time_update).format("D MMM YYYY"));
				$('#reason_s').html(obj.reason);
			}
		},
		error: function () {
			alert("Error retrieving leave detail.");
		}
	});
}
</script>
<script>
function changStatus(id) {
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

        // ฟังก์ชันตรวจสอบก่อนกด "Confirm"
        preConfirm: () => {
            const val = document.getElementById('text').value.trim();
            if (!val) {
                Swal.showValidationMessage("Please enter a reason.");
                return false;
            }
            return val;
        }
    }).then((result) => {
        // ถ้ากดยืนยัน (เหมือน if(inputValue == true))
        if (result.isConfirmed) {
            const val = result.value;

            if (val.length !== 0) {
                $.ajax({
                    url: "Leave_inListStatusToCancel",
                    type: "POST",
                    data: {
                        leave_id: id,
                        reason: val
                    },
                    success: function(response) {
                        window.location.reload(true); // reload หน้าทันทีเหมือนโค้ดเดิม
                    },
                    error: function() {
                        Swal.fire("Error", "Unable to cancel leave. Please try again.", "error");
                    }
                });
            }
        }

        // ถ้ากด Cancel (เหมือน if(inputValue == false))
        if (result.isDismissed) {
            return false;
        }
    });
}
</script>


<script>
	function add() {
		document.location = "NewLeaveAdd?la=1";
	}
</script>
