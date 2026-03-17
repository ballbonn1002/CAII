<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/permission.tld" prefix="perm"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Daily Monitor</title>

<!-- Select2  -->
<link
	href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css"
	rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

<!-- Metronic core -->
<link
	href="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.css"
	rel="stylesheet" type="text/css" />
<script
	src="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.js"></script>


<style type="text/css">
.ps-12 {
	padding-left: 3rem !important;
}

.search-icon {
	position: absolute;
	top: 50%;
	left: 14px;
	transform: translateY(-50%);
	z-index: 10;
	pointer-events: none;
}
</style>
</head>
<body>
	<div class="app-main flex-column app-container container-xxl">
		<div class="page-title py-3">
			<h1 class="page-heading text-gray-900 fw-bold fs-3">Daily
				Monitor</h1>
			<ul
				class="list-unstyled d-inline-flex gap-2 text-muted fs-7 fw-medium">
				<li class="">Home</li>
				<li class="">-</li>
				<li class="">Admin Management</li>
			</ul>
		</div>
		<div class="app-content">
			<div class="card mb-5">
				<div class="card-body">
					<form id="dailyMonitorForm" class="w-100 mb-5 mb-lg-0"
						action="dailyMonitorSearch" method="post">
						<div class="d-flex gap-10 mb-10">
							<div class="w-100">
								<label class="form-label">Job Site</label> <select
									class="form-select" id="jobSiteSelect" name="jobSiteSelect">
									<option value="all">All</option>
									<c:forEach var="j" items="${jobSiteList}">
										<c:choose>
											<c:when
												test="${not empty idJobSiteSelected && idJobSiteSelected != 'all'}">
												<option value="${j.id_sitejob}"
													${j.id_sitejob == idJobSiteSelected ? 'selected' : ''}>${j.name_site}</option>
											</c:when>
											<c:otherwise>
												<option value="${j.id_sitejob}">${j.name_site }</option>
											</c:otherwise>
										</c:choose>

									</c:forEach>
								</select>
							</div>
							<div class="w-100">
								<label class="form-label">Status</label> <select
									class="form-select" id="statusSelect" name="statusSelect">
									<option value="all">All Status</option>
									<option value="ONTIME"
										${'ONTIME' == statusSelected ? 'selected' : ''}>On
										Time</option>
									<option value="LATE"
										${'LATE' == statusSelected ? 'selected' : ''}>Late</option>
									<option value="EARLY_OUT"
										${'EARLY_OUT' == statusSelected ? 'selected' : ''}>Early
										Out</option>
									<option value="UNFINISHIED_WORK"
										${'UNFINISHIED_WORK' == statusSelected ? 'selected' : ''}>Unfinished
										Work</option>
									<option value="LEAVE"
										${'LEAVE' == statusSelected ? 'selected' : ''}>Leave</option>
									<option value="INCOMPLETE"
										${'INCOMPLETE' == statusSelected ? 'selected' : ''}>Incomplete</option>
									<option value="SICK_LEAVE"
										${'SICK_LEAVE' == statusSelected ? 'selected' : ''}>Sick
										Leave</option>
									<option value="NO_RECORD"
										${'NO_RECORD' == statusSelected ? 'selected' : ''}>No
										Record</option>
								</select>
							</div>
							<div class="w-100">
								<label class="form-label">Date</label>
								<div class="input-group">
									<span class="input-group-text bg-transparent"><i
										class="ki-duotone ki-calendar-8 fs-3"> <span class="path1"></span>
											<span class="path2"></span> <span class="path3"></span> <span
											class="path4"></span> <span class="path5"></span> <span
											class="path6"></span>
									</i> </span> <input type="text" class="form-control border-start-0"
										id="date" name="searchDate" value="${searchDate}" />
								</div>
							</div>
						</div>
						<div class="d-flex gap-5">
							<div class="position-relative w-100">
								<i class="ki-duotone ki-magnifier search-icon fs-3"> <span
									class="path1"></span> <span class="path2"></span>
								</i> <select class="form-select ps-15" id="userSelect"
									name="userSelect" ${user.roleId != 'admin' ? 'disabled':''}>
									<option value="all">All Employee</option>
									<c:forEach var="u" items="${userEnable}">
										<c:choose>
											<c:when test="${not empty idUserSelected}">
												<option value="${u.id}"
													${u.id == idUserSelected ? 'selected' : ''}>
													${u.employeeId} - ${u.nameEN} - ${u.name} -
													${u.departmentId}</option>
											</c:when>
											<c:otherwise>
												<option value="${u.id}">${u.employeeId}-
													${u.nameEN} - ${u.name} - ${u.departmentId}</option>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</select>
							</div>
							<button class="btn btn-primary" type="submit">Search</button>
						</div>
					</form>
				</div>
			</div>
			<div class="card">
				<div class="card-header pt-7 border-0">
					<h3 class="fw-bold text-gray-900 fs-3">Daily Monitor</h3>
				</div>
				<div class="card-body pb-0">
					<div class="card-header align-items-start mb-5 py-7 border">
						<div class="d-flex align-items-center gap-10">
							<span class="fs-2hx">${userList.size()}</span> <span
								class="badge text-white" style="background: #198754">All
								Employee</span>
						</div>
						<div class="d-flex gap-10">
							<div class="w-100 d-flex flex-column gap-10">
								<div class="d-flex align-items-center gap-10">
									<span class="fs-2hx">${total_ontime}</span> <span
										class="badge bg-success text-white">Ontime</span>
								</div>
								<div class="d-flex align-items-center gap-10">
									<span class="fs-2hx">${total_late + total_early_out + total_unfinished_work }</span>
									<div class="">
										<span class="badge bg-warning  text-white">Late</span> <span
											class="badge bg-warning  text-white">Early Out</span> <span
											class="badge bg-warning text-white">Unfinished Work</span>
									</div>
								</div>
							</div>
							<div class="w-100 d-flex flex-column gap-10">
								<div class="d-flex align-items-center gap-10">
									<span class="fs-2hx">${total_leave}</span> <span
										class="badge bg-primary text-white">Leave</span>
								</div>
								<div class="d-flex align-items-center gap-10">
									<span class="fs-2hx">${total_incomplete}</span> <span
										class="badge bg-dark text-white">Incomplete</span>
								</div>
							</div>

							<div class="w-100 d-flex flex-column gap-10">
								<div class="d-flex align-items-center gap-10">
									<span class="fs-2hx">${total_sick_leave }</span> <span
										class="badge text-white" style="background: #6F42C1">Sick
										Leave</span>
								</div>
								<div class="d-flex align-items-center gap-10">
									<span class="fs-2hx">${total_no_record}</span> <span
										class="badge bg-danger text-white">No Record</span>
								</div>
							</div>
						</div>
					</div>
					<div class="card-header px-0 align-items-center">
						<h1 class="fw-bold text-primary">
							<fmt:formatDate value="${searchDate}" pattern="dd MMMM yyyy" />
						</h1>
						<div class="d-flex gap-15">
							<div class="d-flex align-items-center gap-3">
								<i class="ki-duotone ki-delivery-door fs-2"
									style="color: #1B84FF"> <span class="path1"></span> <span
									class="path2"></span> <span class="path3"></span> <span
									class="path4"></span>
								</i> <span>Onsite</span>
							</div>
							<div class="d-flex align-items-center gap-3">
								<i class="ki-duotone ki-home fs-2" style="color: #20C997"></i> <span>WFH</span>
							</div>
							<div class="d-flex align-items-center gap-3">
								<i class="ki-duotone ki-cube-2 fs-2" style="color: #DC3545">
									<span class="path1"></span> <span class="path2"></span> <span
									class="path3"></span>
								</i><span>Head Office</span>
							</div>
						</div>
					</div>
				</div>
				<div class="table-responsive">
					<table class="table fs-6 gy-5">
						<thead class="text-gray-500 fw-bold fs-7 ">
							<tr class="text-start border-bottom">
								<th class="text-center" style="width: 60px">#</th>
								<th>EM ID</th>
								<th>NAME</th>
								<th>JOB SITE</th>
								<th>CHECK-IN</th>
								<th>CHECK-OUT</th>
								<th>WORKING (HRS)</th>
								<th>STATUS</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty userList}">
									<c:forEach var="u" items="${userList}" varStatus="loop">
										<c:set var="w" value="${workHoursMap[u.id]}" />
										<c:set var="j" value="${jobSiteMap[u.id]}" />
										<c:set var="s" value="${dailyStatusMap[u.id]}" />
										<c:set var="leaveId" value="${leaveMap[u.id]}" />
										<tr
											class="border-bottom fs-6 fw-normal align-middle text-start">
											<td class="text-center">${loop.index + 1}</td>
											<td>${u.employeeId}</td>
											<td>
												<div class="d-flex flex-column">
													<span>${u.nameEN}</span> <span style="color: #78829D">${u.name}</span>
												</div>
											</td>
											<td>
												<div class="d-flex flex-column">
													<span style="color: #78829D">${u.departmentId}</span><span
														class="badge bg-primary text-white"
														style="width: fit-content;">${j.name_site}</span>
												</div>
											</td>
											<td class="fw-bold">
												<div class="d-flex flex-column gap-3">
													<div class="d-flex gap-5">
														<c:if test="${not empty s}">
															<c:choose>
																<c:when test="${w['1'].work_type == 1}">
																	<i class="ki-duotone ki-delivery-door fs-2"
																		style="color: #1B84FF"> <span class="path1"></span>
																		<span class="path2"></span> <span class="path3"></span>
																		<span class="path4"></span>
																	</i>
																</c:when>
																<c:when test="${w['1'].work_type == 2}">
																	<i class="ki-duotone ki-home fs-2"
																		style="color: #20C997"></i>
																</c:when>
																<c:when test="${w['1'].work_type == 3}">
																	<i class="ki-duotone ki-cube-2 fs-2"
																		style="color: #DC3545"> <span class="path1"></span>
																		<span class="path2"></span> <span class="path3"></span>
																	</i>
																</c:when>
															</c:choose>
														</c:if>
														<span>${s.check_in}</span>
													</div>
													<c:if test="${not empty w['1'].description }">
														<span class="d-flex gap-3 align-items-start fw-normal">
															<i class="ki-duotone ki-message-text-2 fs-2"> <span
																class="path1"></span> <span class="path2"></span> <span
																class="path3"></span>
														</i> ${w['1'].description}
														</span>
													</c:if>
												</div>
											</td>

											<td class="fw-bold">
												<div class="d-flex flex-column gap-3">
													<div class="d-flex gap-3">
														<c:if test="${not empty s}">
															<c:choose>
																<c:when test="${w['2'].work_type == 1}">
																	<i class="ki-duotone ki-delivery-door fs-2"
																		style="color: #1B84FF"> <span class="path1"></span>
																		<span class="path2"></span> <span class="path3"></span>
																		<span class="path4"></span>
																	</i>
																</c:when>
																<c:when test="${w['2'].work_type == 2}">
																	<i class="ki-duotone ki-home fs-2"
																		style="color: #20C997"></i>
																</c:when>
																<c:when test="${w['2'].work_type == 3}">
																	<i class="ki-duotone ki-cube-2 fs-2"
																		style="color: #DC3545"> <span class="path1"></span>
																		<span class="path2"></span> <span class="path3"></span>
																	</i>
																</c:when>
															</c:choose>
														</c:if>
														<span>${s.check_out}</span>
													</div>

													<c:if test="${not empty w['2'].description }">
														<span class="d-flex gap-3 align-items-start fw-normal">
															<i class="ki-duotone ki-message-text-2 fs-2"> <span
																class="path1"></span> <span class="path2"></span> <span
																class="path3"></span>
														</i> ${w['2'].description}
														</span>
													</c:if>
												</div>
											</td>
											<td class="fw-bold">${s.workinghours_format}</td>

											<td>
												<div class="d-flex flex-column gap-5">

													<c:if test="${s.status == 'ONTIME'}">
														<span class="badge bg-success text-white"
															style="width: fit-content;">Ontime</span>
													</c:if>
													<c:if test="${s.status  == 'LATE'}">
														<span class="badge bg-warning  text-white"
															style="width: fit-content;">Late</span>
													</c:if>
													<c:if test="${s.status  == 'EARLY_OUT'}">
														<span class="badge  bg-warning  text-white"
															style="width: fit-content;">Early Out</span>
													</c:if>
													<c:if test="${s.status  == 'UNFINISHED_WORK'}">
														<span class="badge  bg-warning  text-white"
															style="width: fit-content;">Unfinished Work</span>
													</c:if>
													<c:if test="${s.status  == 'INCOMPLETE'}">
														<span class="badge bg-dark text-white"
															style="width: fit-content;">Incomplete</span>
													</c:if>
													<c:if test="${s.status  == 'NO_RECORD'}">
														<span class="badge bg-danger text-white"
															style="width: fit-content;">No Record</span>
													</c:if>
													<c:if test="${s.leave_status  == 'SICK_LEAVE'}">
														<div class="d-flex gap-2">
															<span class="badge text-white"
																style="background: #6F42C1">Sick Leave</span> <i
																class="ki-duotone ki-document fs-2 leave-doc"
																data-leaveid="${leaveId}" style="color: #1B84FF"> <span
																class="path1"></span> <span class="path2"></span>
															</i>
														</div>
													</c:if>
													<c:if
														test="${s.leave_status  == 'BUSINESS_LEAVE' || s.leave_status  == 'ANNUAL_LEAVE' || s.leave_status  == 'ANNUAL_LEAVE_REMAINING'}">
														<div class="d-flex gap-2">
															<span class="badge bg-primary text-white">Leave</span> <i
																class="ki-duotone ki-document fs-2 leave-doc"
																data-leaveid="${leaveId}" style="color: #1B84FF"> <span
																class="path1"></span> <span class="path2"></span>
															</i>
														</div>
													</c:if>
												</div>
											</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr class="fs-6 fw-normal align-middle">
										<td colspan="8" class="text-center ">No Data</td>
									</tr>
								</c:otherwise>
							</c:choose>

						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<!-- Leave Modal -->
	<div class="modal fade" id="leavemodal" tabindex="-1">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h2 class="modal-title fw-bold">Leave</h2>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="row mb-5 fs-5 fw-semibold">
						<div class="col-md-6">
							<div class="d-flex align-items-center ">
								<span class="text-primary me-4">#<span id="leaveid"></span></span>
								<span id="leavetype" class="fw-medium me-4"></span> <i
									class="fa fa-circle text-gray-400 me-4" style="font-size: 8px;"></i>
								<span id="noday" class="badge badge-light-primary"></span>
							</div>
						</div>
						<div class="col-md-6">
							<span id="userid"></span>
						</div>
					</div>

					<div class="row mb-5 fs-6 fw-medium">
						<div class="col-md-6">
							<div class="d-flex align-items-center mb-2">
								<i class="ki-duotone ki-calendar-2 fs-2 me-2"> <span
									class="path1"></span> <span class="path2"></span>
								</i> <span><span id="sdate"></span> - <span id="edate"></span></span>
							</div>
						</div>
						<div class="col-md-6">
							<div class="d-flex align-items-center mb-2">
								<i class="ki-duotone ki-time fs-2 me-2"> <span class="path1"></span>
									<span class="path2"></span>
								</i> <span><span id="stime"></span> - <span id="etime"></span></span>
							</div>
						</div>
					</div>

					<div class="row mb-5 fs-6 fw-medium">
						<div class="col-md-6">
							<div class="d-flex align-items-center mb-2">
								<i class="ki-duotone ki-message-text fs-2 me-2"> <span
									class="path1"></span> <span class="path2"></span>
								</i> <span id="desc"></span>
							</div>
						</div>
						<div class="col-md-6">
							<div class="d-flex align-items-center mb-2">
								<i class="ki-duotone ki-document fs-2 me-2"> <span
									class="path1"></span> <span class="path2"></span>
								</i> <a id="file"
									class="text-hover-primary text-truncate flex-grow-1 min-w-0"
									style="max-width: 100%;"></a>
							</div>
						</div>
					</div>

					<div class="row mb-5 fs-6 fw-medium">
						<div class="col-md-6">
							<span id="leavestatus"></span>
						</div>
						<div class="col-md-6 fs-8 text-gray-500">
							<span>Request Date: <span id="timecreate"></span></span>
						</div>
					</div>

					<div id="approveDetail" class="row mb-5 fs-6 fw-medium d-none">
						<hr>
						<div class="row mb-5 fw-semibold">
							<h3 class="text-primary">Approver</h3>
						</div>

						<div class="row mb-5 fs-6 fw-medium">
							<div class="col-md-6">
								<i class="ki-duotone ki-user fs-2 me-2"> <span class="path1"></span>
									<span class="path2"></span>
								</i><span id="approveUser"></span>
							</div>
							<div class="col-md-6">
								<i class="ki-duotone ki-calendar-2 fs-2 me-2"> <span
									class="path1"></span> <span class="path2"></span>
								</i><span id="timeUpdate"></span>
							</div>
						</div>

						<div class="row mb-5 fs-6 fw-medium">
							<div class="col-md-6">
								<i class="ki-duotone ki-document fs-2 me-2"> <span
									class="path1"></span> <span class="path2"></span>
								</i>No description
							</div>
						</div>
					</div>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
					<perm:permission object="leave.approve">
						<a href="#" class="btn btn-primary" id="btn_edit_leave"> <i
							class="fa fa-edit"></i> Edit
						</a>
					</perm:permission>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(function() {
			$('#userSelect,#statusSelect,#jobSiteSelect').select2({
				width : '100%',
			});

			flatpickr("#date", {
				dateFormat : "Y-m-d", // format ที่ส่ง server
				altInput : true,
				altFormat : "d F Y",
				allowInput : true
			});

			// --------------------- Leave Modal ------------------------

			$('.leave-doc')
					.on(
							"click",
							function() {
								$("#leavemodal").modal("show");
								let leaveId = $(this).data("leaveid");
								console.log(leaveId);
								$
										.ajax({
											url : "new_modalLeaveStatus",
											method : "POST",
											data : "leaveId=" + leaveId,
											success : function(data) {
												var obj = JSON.parse(data);

												$('#leaveid')
														.html(obj.leave_id);
												$('#userid').html(obj.name);
												$('#stime')
														.html(obj.start_time);
												$('#etime').html(obj.end_time);
												$('#desc')
														.html(obj.description);

												if (obj.leave_file_id == null
														|| obj.leave_file_id == "") {
													$('#file').html("No file");
												} else {
													$('#file')
															.html(
																	obj.leave_file_name
																			+ obj.leave_file_type);
													$('#file')
															.attr(
																	'href',
																	'preview_File?id='
																			+ obj.leave_file_id);
													$('#file').attr('target',
															'_blank');
												}

												$('#btn_edit_leave')
														.attr(
																{
																	href : 'NewLeaveEdit?id='
																			+ obj.leave_id
																			+ '&la=1',
																	target : '_blank'
																});

												// Set leave type
												var leaveTypeMap = {
													1 : "ลาพักร้อน",
													2 : "ลากิจ",
													3 : "ลาป่วย",
													4 : "ขาดงาน",
													5 : "ลาโดยไม่รับค่าจ้าง",
													6 : "ลาพักร้อนที่เหลือจากปีก่อน",
													7 : "ลาอื่นๆ",
													9 : "อื่นๆ"
												};
												$('#leavetype')
														.html(
																leaveTypeMap[obj.leave_type_id]
																		|| "");

												var startdate = (obj.start_date)
														.split(",");
												var sdate = moment(startdate[0])
														.format("D MMM YYYY");
												$('#sdate').html(sdate);

												var enddate = (obj.end_date)
														.split(",");
												var edate = moment(enddate[0])
														.format("D MMM YYYY");
												$('#edate').html(edate);

												$('#noday').html(
														obj.no_day + " Day");

												var timecreate = (obj.time_create)
														.split(",");
												var tcreate = moment(
														timecreate[0]).format(
														"D MMM YYYY");
												$('#timecreate').html(tcreate);

												$('#approveDetail').addClass(
														'd-none');
												$('#approveText').html("");

												// Set status with new theme classes
												switch (obj.leave_status_id) {
												case '0':
													$('#leavestatus')
															.html(
																	"Wait for Approving")
															.removeClass()
															.addClass(
																	"badge badge-light-warning");
													break;
												case '1':
													$('#leavestatus')
															.html("Approved")
															.removeClass()
															.addClass(
																	"badge badge-light-success");
													$('#approveUser').html(
															obj.appr_user_id);
													$('#timeUpdate').html(
															obj.time_update);
													//$('#detail').html(obj.dddd);
													$('#approveDetail')
															.removeClass(
																	'd-none');
													break;
												case '2':
													$('#leavestatus')
															.html("Reject")
															.removeClass()
															.addClass(
																	"badge badge-light-danger");
													$('#approveUser').html(
															obj.appr_user_id);
													$('#timeUpdate').html(
															obj.time_update);
													//$('#detail').html(obj.dddd);
													$('#approveDetail')
															.removeClass(
																	'd-none');
													break;
												case '3':
													$('#leavestatus')
															.html("Cancel")
															.removeClass()
															.addClass(
																	"badge badge-light-secondary");
													break;
												}
											}
										});

							})
			// --------------------- END of Leave Modal -----------------------

		})
	</script>
</body>
</html>