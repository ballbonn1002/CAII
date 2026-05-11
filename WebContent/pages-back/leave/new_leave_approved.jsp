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
										<!-- All Employee -->
										<div class="col-md-2">
											<div class="mb-5">
												<select class="form-select" id="name1" name="name1" onchange="this.form.submit()">
													<perm:permission object="leave.viewall">
														<option value="All" id="All"
															<c:if test="${userSelect != null && userSelect == 'All'}"> selected </c:if>>All Employee</option>
													</perm:permission>
														<option value="All2"
															<c:if test="${userSelect != null && userSelect == 'All2'}"> selected </c:if>>All Manage</option>
												</select>
											</div>
										</div>
										<!-- All Employee -->

										<!-- Select Employee -->
										<div class="col-md-10">
											<div class="mb-5">
												<select class="form-select" id="name2" name="name2" onchange="this.form.submit()">
													
												</select>
											</div>
										</div>
										<!-- Select Employee -->
									</div>
									
									<div class="row g-5">
										<!-- Leave Type -->
										<div class="col-md-4">
											<div class="mb-5">
												<select class="form-select" data-placeholder="All Leave Type" id="leaveType" name="type" onchange="this.form.submit()">
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
										<!-- Leave Type -->

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
										<!-- Status -->

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
								<!--	<div class="col-6 col-md-4 col-xl-3">
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
												<div class="d-flex align-items-center">
													<span class="fs-2 fw-bold text-dark">
														<fmt:formatNumber type="number" pattern="#.##" value="${LeavenumT1}"/><c:if test="${userSelect2 != null}">/<fmt:formatNumber type="number" pattern="#.##" value="${quota_1 - 3}"/></c:if>
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
									</div>	-->

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
												<div class="d-flex align-items-center">
													<span class="fs-2 fw-bold text-dark">
														<fmt:formatNumber type="number" pattern="#.##" value="${LeavenumT1}"/>+<fmt:formatNumber type="number" pattern="#.##" value="${LeavenumT2}"/>
														<c:if test="${userSelect2 != null}">/<fmt:formatNumber type="number" pattern="#.##" value="${quota_1+quota_2}"/></c:if>
														<c:if test="${userSelect2 == null}"></c:if>
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
													 <span class="path1"></span>
													 <span class="path2"></span>
													 <span class="path3"></span>
													</i>
												</span>
											</div>
											<div class="d-flex flex-column">
												<div class="d-flex align-items-center">
													<span class="fs-2 fw-bold text-dark">
														<fmt:formatNumber type="number" pattern="#.##" value="${LeavenumT6}"/><c:if test="${userSelect2 != null}">/<fmt:formatNumber type="number" pattern="#.##" value="${quota_4}"/></c:if>
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
														<span class="path1"></span>
														<span class="path2"></span>
													</i>
												</span>
											</div>
											<div class="d-flex flex-column">
												<div class="d-flex align-items-center">
													<span class="fs-2 fw-bold text-dark">
														<fmt:formatNumber type="number" pattern="#.##" value="${LeavenumT3}"/>
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
														<fmt:formatNumber type="number" pattern="#.##" value="${LeavenumT4}"/>
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
														<fmt:formatNumber type="number" pattern="#.##" value="${LeavenumT5}"/>
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
														<fmt:formatNumber type="number" pattern="#.##" value="${LeavenumT7}"/>
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
							${fn:length(leaveList)} Items Found <span class="text-gray-500 fs-6">by Recent Updates ↓</span>
						</h3>
					</div>
					<!--end::Title-->
					<div class="d-flex align-items-center gap-3">
						<!--begin::Btn Create-->
						<div class="d-flex flex-wrap my-1">
							<a href="javascript:void(0)" class="btn btn-success btn-lg" onclick="add()">
								<i class="ki-duotone ki-plus fs-2"></i>
								Create
							</a>
						</div>
						<!--end::Btn Create-->
						<!--begin::Btn export to excel-->
						<div class="d-flex flex-wrap my-1">
							<button type="button" class="btn btn-primary btn-lg" id="exportExcel" onclick="exportDataToExcel()">
						        <i class="ki-duotone ki-file-right fs-2">
									<span class="path1"></span>
									<span class="path2"></span>
								</i>
						        &nbsp;Export to excel
						    </button>
						</div>
						<!--end::Btn export to excel-->
					</div>
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
											<!-- ลาพักร้อน -->
											<c:if test="${leave.leave_type_id.toString() == '1'}">
												<div class="symbol symbol-md-35px symbol-30px me-4">
													<span class="symbol-label bg-light-success">
														<i class="ki-duotone ki-airplane fs-2x text-success">
															<span class="path1"></span>
															<span class="path2"></span>
														</i>
													</span>
												</div>
												<span class="badge badge-light-success fs-4">${leave.leave_type_name}</span>
											</c:if>
											<!-- ลากิจ -->
											<c:if test="${leave.leave_type_id.toString() == '2'}">
												<div class="symbol symbol-md-35px symbol-30px me-4">
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
											<!-- ลาป่วย -->
											<c:if test="${leave.leave_type_id.toString() == '3'}">
												<div class="symbol symbol-md-35px symbol-30px me-4">
													<span class="symbol-label bg-light-info">
														<i class="ki-duotone ki-pulse fs-2x text-info">
															<span class="path1"></span>
															<span class="path2"></span>
														</i>
													</span>
												</div>
												<span class="badge badge-light-info fs-4">${leave.leave_type_name}</span>
											</c:if>
											<!-- ขาดงาน -->
											<c:if test="${leave.leave_type_id.toString() == '4'}">
												<div class="symbol symbol-md-35px symbol-30px me-4">
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
											<!-- ลาโดยไม่รับค่าจ้าง -->
											<c:if test="${leave.leave_type_id.toString() == '5'}">
												<div class="symbol symbol-md-35px symbol-30px me-4">
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
											<!-- ลาพักร้อนที่เหลือจากปีก่อน -->
											<c:if test="${leave.leave_type_id.toString() == '6'}">
												<div class="symbol symbol-md-35px symbol-30px me-4">
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
											<!-- ลาอื่นๆ -->
											<c:if test="${leave.leave_type_id.toString() == '7'}">
												<div class="symbol symbol-md-35px symbol-30px me-4">
													<span class="symbol-label" style="background-color: #4B5675;">
														<i class="ki-duotone ki-abstract-12 fs-2x" style="color: #FFFFFF;">
															<span class="path1"></span>
															<span class="path2"></span>
														</i>
													</span>
												</div>
												<span class="badge badge-light-dark fs-4">${leave.leave_type_name}</span>
											</c:if>
											<!-- ลาโดยไม่รับค่าจ้าง -->
											<c:if test="${leave.leave_type_id.toString() == '9'}">
												<div class="symbol symbol-md-35px symbol-30px me-4">
													<span class="symbol-label" style="background-color: #4B5675;">
														<i class="ki-duotone ki-abstract-12 fs-2x" style="color: #FFFFFF;">
															<span class="path1"></span>
															<span class="path2"></span>
														</i>
													</span>
												</div>
												<span class="badge badge-light-dark fs-4">${leave.leave_type_name}</span>
											</c:if>
										<%-- <span class="fw-semibold" style="font-weight: 1000 !important;">${leave.leave_type_name}</span> --%>
									</div>

									<!-- Btn Info, Edit, Delete -->
									<div class="card-toolbar">
										<div class="d-inline-flex align-items-center justify-content-end gap-2">
											<!-- Btn Info -->
											<a href="javascript:void(0)" class="btn btn-icon btn-sm btn-light-info" onclick="leaveApproveStatus(${leave.leave_id})">
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
													<a data-note="btn edit" href="NewLeaveEdit?id=${leave.leave_id}&la=1" title="Edit" class="btn btn-icon btn-sm btn-light-primary">
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

<jsp:include page="/pages-back/common/leave_modal.jsp">
	<jsp:param name="showApproverInfo" value="true"/>
	<jsp:param name="showApprovePanel" value="true"/>
	<jsp:param name="showApproveButton" value="true"/>
</jsp:include>

<script>
$(document).ready(function(){
	var userSelect =  '${userSelect}';
	var userSelect2 =  '${userSelect2}';
	var role_authorized = '${role_authorized}';
	
	var value = null;
	console.log("userS = " + '${userS}');
	console.log("logonUser = " + '${logonUser}');
	//var user_login = '${userS}';
	var user_login = '${logonUser}';

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
	
 	//if(userSelect2 == null || userSelect2 == ""){
	 	$("#name2").select2({
		    placeholder: "Select Employee",
		    allowClear: true,
		});
	//}

 	$("#leaveType, #appr").select2({
        /*placeholder: function() {
            return $(this).data('placeholder');
        },*/
        allowClear: true,
        width: '100%',
        //minimumResultsForSearch: Infinity	//disable search
    });

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
			let option = '<option></option>';
			let enableGroup = '<optgroup label="Enable">';
			let disableGroup = '<optgroup label="Disable">';

			for (var i = 0; i < obj.length; i++) {

				var string1 = obj[i].id ? obj[i].id.toLowerCase() : "";
				var string2 = userSelect2 ? userSelect2.toLowerCase() : "";
				var txt = (string1 === string2) ? "selected" : "";

				var employeeId = obj[i].employee_id ? obj[i].employee_id : "";
				var name = obj[i].name ? obj[i].name : "";
				var nameEn = obj[i].name_en ? obj[i].name_en : "";

				var displayText = '';
				if (employeeId) {
					displayText += employeeId;
				}
				if (nameEn) {
					displayText += (displayText ? ' - ' : '') + nameEn;
				}
				if (name) {
					displayText += (displayText ? ' - ' : '') + name;
				}
				var optionHtml = '<option value="'+obj[i].id+'" '+txt+'>'+displayText+'</option>';

				//แยก enable/disable
				if (obj[i].enable == 1) {
					enableGroup += optionHtml;
				} else {
					disableGroup += optionHtml;
				}
			}

			enableGroup += '</optgroup>';
			disableGroup += '</optgroup>';
			select.innerHTML = option + enableGroup + disableGroup;
			
			var selectElem = $('#name2');
		    var originalOnChange = selectElem.attr('onchange');
		    selectElem.removeAttr('onchange');
		    selectElem.html(option + enableGroup + disableGroup);

		    if (userSelect2) {
		        selectElem.val(userSelect2);
		    }

		    selectElem.trigger('change');
		    
		    if (originalOnChange) {
		        selectElem.attr('onchange', originalOnChange);
		    }
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
		/* var start = moment("2025-01-01", "YYYY-MM-DD");
		var end = moment("2025-12-31", "YYYY-MM-DD"); */
		var start = moment("<fmt:formatDate value='${startdate}' pattern='dd-MM-yyyy'/>", "DD-MM-YYYY");
		var end = moment("<fmt:formatDate value='${enddate}' pattern='dd-MM-yyyy'/>", "DD-MM-YYYY");

		/* $("#kt_daterangepicker").daterangepicker({
			startDate: start,
			endDate: end,
			locale: {
				format: "DD MMM YYYY"
			}
		}, function (start, end) {
			$("#startdate").val(start.format("DD-MM-YYYY"));
			$("#enddate").val(end.format("DD-MM-YYYY"));

			// auto-submit form
			$("#searchForm").submit();
		}); */
		$("#kt_daterangepicker").daterangepicker({
	        startDate: start,
	        endDate: end,
			locale: {
				format: "DD MMM YYYY",
				monthNames: [
				  "January", "February", "March", "April", "May", "June",
				  "July", "August", "September", "October", "November", "December"
				],
	        },
	        showDropdowns: true,     // มี dropdown เดือน/ปี
	        autoApply: true,
	        linkedCalendars: false,  // เดือนซ้าย ขวาอิสระ ไม่ fix
	        alwaysShowCalendars: true,
	        opens: 'center'
		}, function (start, end) {
			$("#startdate").val(start.format("DD-MM-YYYY"));
			$("#enddate").val(end.format("DD-MM-YYYY"));
			$("#searchForm").submit();
		});

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
function setModalViewMode(isWaiting) {
	if (isWaiting) {
		//CASE: Wait for Approving
		$('#status_panel').hide();
		$("#change_panel").show();
		$("#btn_reject").show();
		$("#btn_approve").show();
	} else {
		//CASE: Approved / Reject / Cancel
		$('#status_panel').show();
		$('#approved_detail').show();
		$("#change_panel").hide();
		$("#btn_reject").hide();
		$("#btn_approve").hide();
	}
}
/* 
function leaveStatus(id) {
	const modal = new bootstrap.Modal(document.getElementById('leaveDetailModal'));
	modal.show();

	console.log(id);
	$.ajax({
		url: "new_modalLeaveStatus",
		method: "POST",
		data: {
			leaveId: id
		},
		success: function (data) {
			var obj = JSON.parse(data);
			console.log(obj);

			$('#leaveid').html(obj.leave_id);
			$('#employeeId').html(obj.employeeId + " ");
			$('#username').html(obj.name);
			$('#stime').html(obj.start_time);
			$('#etime').html(obj.end_time);
			$('#desc').html(obj.description);
			$('#ucEmpId').html(obj.ucEmpId);
			$('#ucName').html(obj.ucName);
			if(obj.leave_file_name == null){
				$('#file').html("-");
			}else{
				$('#file').html(obj.leave_file_name + obj.leave_file_type).attr('href', 'preview_File?id=' + obj.leave_file_id).attr('target', '_blank');
			}
			// leave type name
			if (obj.leave_type_id == 1) {
				$('#leavetype').html("ลาพักร้อน");
			}
			if (obj.leave_type_id == 2) {
				$('#leavetype').html("ลากิจ");
			}
			if (obj.leave_type_id == 3) {
				$('#leavetype').html("ลาป่วย");
			}
			if (obj.leave_type_id == 4) {
				$('#leavetype').html("ขาดงาน");
			}
			if (obj.leave_type_id == 5) {
				$('#leavetype').html("ลาโดยไม่รับค่าจ้าง");
			}
			if (obj.leave_type_id == 6) {
				$('#leavetype').html("ลาพักร้อนที่เหลือจากปีก่อน");
			}
			if (obj.leave_type_id == 7) {
				$('#leavetype').html("ลาอื่นๆ");
			}
			if (obj.leave_type_id == 9) {
				$('#leavetype').html("อื่นๆ");
			}

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

			$("#appr_reason").val("");

			// leave status
			if (obj.leave_status_id == '0') {
				//CASE: Wait for Approving
				$('#leavestatus').html("Wait for Approving").removeClass().addClass('badge badge-light-warning');
				$('#status_title_action').html("Approver").removeClass('text-danger').addClass('text-dark');

				setModalViewMode(true);

				$("#btn_reject").attr("onclick", "sentData(" + obj.leave_id + ", 2)");
				$("#btn_approve").attr("onclick", "sentData(" + obj.leave_id + ", 1)");

			} else {
				//CASE: Approved / Reject / Cancel

				setModalViewMode(false);
				//$('#approver').html(obj.user_update);
				$('#aprEmpId').html(obj.aprEmpId + " ");
				$('#aprName').html(obj.aprName + " - ");
				$('#aprRole').html(obj.aprRole);
				$('#timeupdate').html(moment(obj.time_update).format("D MMM YYYY"));
				$('#reason_s').html(obj.reason);

				if (obj.leave_status_id == '1') {
					// Approved
					$('#leavestatus').html("Approved").removeClass().addClass('badge badge-light-success');
					$('#status_title').html("Approver").removeClass('text-danger').addClass('text-primary');

				} else if (obj.leave_status_id == '2') {
					// Reject
					$('#leavestatus').html("Reject").removeClass().addClass('badge badge-light-danger');
					$('#status_title').html("Approver").removeClass('text-danger').addClass('text-primary');

				} else if (obj.leave_status_id == '3') {
					// Cancel
					$('#leavestatus').html("Cancel").removeClass().addClass('badge badge-light-dark');
					$('#status_title').html("Cancel").removeClass('text-primary').addClass('text-danger');
				}
			}
		},
		error: function () {
			alert("Error retrieving leave detail.");
		}
	});
} */
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
                    url: "Leave_inListStatusToCancel",
                    type: "POST",
                    data: {
                        leave_id: id,
                        reason: val
                    },
                    success: function(response) {
                        window.location.reload(true);
                    },
                    error: function() {
                        Swal.fire("Error", "Unable to cancel leave. Please try again.", "error");
                    }
                });
            }
        }

        if (result.isDismissed) {
            return false;
        }
    });
}

function sentData(id, value) {
	console.log("sentdata: " + id);
	var $apprReason = $("#appr_reason");
	var apprReasonTxt = $("#appr_reason").val().trim();
	var apprReasonEl = $(".invalid-feedback");
	let valid = true;

	if (value == 2) {
		if(!apprReasonTxt){
			console.log("Empty or just spaces");
			apprReasonEl.text("Please provide a reason.").show();
			$apprReason.addClass("is-invalid");
			return false;
		} else if(apprReasonTxt.length < 10){
			console.log("Too short");
			apprReasonEl.text("Reason must be at least 10 characters long.").show();
			$apprReason.addClass("is-invalid");
			return false;
		} else {
			apprReasonEl.hide();
			$apprReason.removeClass("is-invalid");
		}
	}
	var loadingEl = $("<div>").attr("id", "page-loader")
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
		url: "Leave_inListUpdateStatus",
		type: "POST",
		data: {
			"leave_id": id,
			"status": value,
			"reason": apprReasonTxt
		}
	}).done(function () {
		location.reload();
	});
}
</script>


<script>
	function add() {
		document.location = "NewLeaveAdd?la=1";
	}
	
	function exportDataToExcel() {
		var name1 = document.getElementById("name1") ? document.getElementById("name1").value : "";
		var name2 = document.getElementById("name2") ? document.getElementById("name2").value : "";
		var appr = document.getElementById("leaveApproveStatus") ? document.getElementById("leaveApproveStatus").value : "";
		var leaveType = document.getElementById("leaveType") ? document.getElementById("leaveType").value : "";
		
		var sd = document.getElementById("startdate") ? document.getElementById("startdate").value : "";
		var ed = document.getElementById("enddate") ? document.getElementById("enddate").value : "";
		
		var exportUrl = "LeaveApproveExcelExport?name1=" + encodeURIComponent(name1) +
						"&name2=" + encodeURIComponent(name2) +
						"&startdate=" + encodeURIComponent(sd) +
						"&enddate=" + encodeURIComponent(ed) +
						"&appr=" + encodeURIComponent(appr) +
						"&leaveType=" + encodeURIComponent(leaveType);
		window.location.href = exportUrl;
	}
</script>
