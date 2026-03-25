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


<!-- Data Table -->
<link
	href="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.css"
	rel="stylesheet" type="text/css" />
<script
	src="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.js"></script>


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
		<div
			class="page-title d-flex justify-content-between align-items-center py-3">
			<div>
				<h1 class="page-heading text-gray-900 fw-bold fs-3">Daily
					Monitor</h1>
				<ul
					class="list-unstyled d-inline-flex gap-2 text-muted fs-7 fw-medium">
					<li class="">Home</li>
					<li class="">-</li>
					<li class="">Admin Management</li>
				</ul>
			</div>
			<a class="btn"
				href="exportDailyMonitor?searchDate=${searchDate}&&jobSiteSelect=${idJobSiteSelected}&&statusSelect=${statusSelected}&&userSelect=${idUserSelected}"
				style="background: #F9F9F9"><i class="bi bi-filetype-xml fs-2" style="color: #50BEE8"></i> 
				Download Excel</a>
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
									<option value="OnTime"
										${'OnTime' == statusSelected ? 'selected' : ''}>On
										Time</option>
									<option value="Late"
										${'Late' == statusSelected ? 'selected' : ''}>Late</option>
									<option value="Early Out"
										${'Early Out' == statusSelected ? 'selected' : ''}>Early
										Out</option>
									<option value="Unfinished Work"
										${'Unfinished Work' == statusSelected ? 'selected' : ''}>Unfinished
										Work</option>
									<option value="Leave"
										${'Leave' == statusSelected ? 'selected' : ''}>Leave</option>
									<option value="Incomplete"
										${'Incomplete' == statusSelected ? 'selected' : ''}>Incomplete</option>
									<option value="ลาป่วย"
										${'ลาป่วย' == statusSelected ? 'selected' : ''}>Sick
										Leave</option>
									<option value="Absent/Error"
										${'Absent/Error' == statusSelected ? 'selected' : ''}>No
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
											<c:when
												test="${not empty idUserSelected && idUserSelected != 'all'}">
												<option value="${u.id}"
													${u.id == idUserSelected ? 'selected' : ''}>
													${u.employee_id} - ${u.name_en} - ${u.name} -
													${u.department_id}</option>
											</c:when>
											<c:otherwise>
												<option value="${u.id}">${u.employee_id}-
													${u.name_en} - ${u.name} - ${u.department_id}</option>
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
						<div class="w-100 d-flex gap-10">
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
					<div class="card-header px-0 pb-5 align-items-center">
						<h3 class="fw-bold m-0">${dailyWorkUser.size()}
							Items Found <span class="fs-6" style="color: #99A1B7">by
								All Employee ↓</span>
						</h3>

						<div class="d-flex gap-10">
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
							<h1 class="fw-bold text-primary m-0">
								<fmt:formatDate value="${searchDate}" pattern="dd MMMM yyyy" />
							</h1>
						</div>
					</div>
				</div>
				<div class="table-responsive">
					<table class="table fs-6 gy-5" id="table">
						<thead class="text-gray-500 fw-bold fs-7 ">
							<tr class="text-start border-bottom">
								<th class="text-center">#</th>
								<th>EMP ID</th>
								<th>NAME</th>
								<th>JOB SITE</th>
								<th>POSITION</th>
								<th>CHECK-IN</th>
								<th>CHECK-OUT</th>
								<th>WORKING (HRS)</th>
								<th>STATUS</th>
							</tr>
						</thead>
						<tbody>

							<c:forEach var="u" items="${dailyWorkUser}" varStatus="loop">
								<c:set var="w" value="${workHoursMap[fn:toLowerCase(u.userId)]}" />
								<c:set var="jobSiteList" value="${jobSiteMap[u.userId]}" />
								<tr class="border-bottom fs-6 fw-normal align-middle text-start">
									<td class="text-center">${loop.index + 1}</td>
									<td>${u.empId}</td>
									<td>
										<div class="d-flex flex-column">
											<span>${u.nameEn}</span> <span style="color: #78829D">${u.name}</span>
										</div>
									</td>
									<td>
										<div class="d-flex flex-column gap-2">
											<c:forEach var="j" items="${jobSiteList}">
												<span class="badge bg-primary text-white"
													style="width: fit-content;">${j.name_site}</span>
											</c:forEach>
										</div>
									</td>
									<td><span style="color: #78829D">${u.position}</span></td>
									<td class="fw-bold">
										<div class="d-flex flex-column gap-2">
											<c:forEach var="work" items="${w['1']}">
												<div class="d-flex flex-column gap-2">
													<div class="d-flex gap-5">
														<c:choose>
															<c:when test="${fn:trim(work.work_type) eq '1'}">
																<i class="ki-duotone ki-delivery-door fs-2"
																	style="color: #1B84FF"> <span class="path1"></span>
																	<span class="path2"></span> <span class="path3"></span>
																	<span class="path4"></span>
																</i>
															</c:when>
															<c:when test="${fn:trim(work.work_type) eq '2'}">
																<i class="ki-duotone ki-home fs-2"
																	style="color: #20C997"></i>
															</c:when>
															<c:when test="${fn:trim(work.work_type) eq '3'}">
																<i class="ki-duotone ki-cube-2 fs-2"
																	style="color: #DC3545"> <span class="path1"></span>
																	<span class="path2"></span> <span class="path3"></span>
																</i>
															</c:when>
														</c:choose>
														<fmt:formatDate value="${work.work_hours_time_work}"
															pattern="HH:mm" />
													</div>
													<c:if test="${not empty work.description}">
														<span class="d-flex gap-3 align-items-start fw-normal">
															<i class="ki-duotone ki-message-text-2 fs-2"> <span
																class="path1"></span> <span class="path2"></span> <span
																class="path3"></span>
														</i> ${work.description}
														</span>
													</c:if>
												</div>
											</c:forEach>
										</div>
									</td>

									<td class="fw-bold">
										<div class="d-flex flex-column gap-2">
											<c:forEach var="work" items="${w['2']}">
												<div class="d-flex flex-column gap-2">
													<div class="d-flex gap-5">
														<c:choose>
															<c:when test="${fn:trim(work.work_type) eq '1'}">
																<i class="ki-duotone ki-delivery-door fs-2"
																	style="color: #1B84FF"> <span class="path1"></span>
																	<span class="path2"></span> <span class="path3"></span>
																	<span class="path4"></span>
																</i>
															</c:when>
															<c:when test="${fn:trim(work.work_type) eq '2'}">
																<i class="ki-duotone ki-home fs-2"
																	style="color: #20C997"></i>
															</c:when>
															<c:when test="${fn:trim(work.work_type) eq '3'}">
																<i class="ki-duotone ki-cube-2 fs-2"
																	style="color: #DC3545"> <span class="path1"></span>
																	<span class="path2"></span> <span class="path3"></span>
																</i>
															</c:when>
														</c:choose>
														<fmt:formatDate value="${work.work_hours_time_work}"
															pattern="HH:mm" />
													</div>
													<c:if test="${not empty work.description}">
														<span class="d-flex gap-3 align-items-start fw-normal">
															<i class="ki-duotone ki-message-text-2 fs-2"> <span
																class="path1"></span> <span class="path2"></span> <span
																class="path3"></span>
														</i> ${work.description}
														</span>
													</c:if>
												</div>
											</c:forEach>
										</div>
									</td>
									<td class="fw-bold">${u.workingHours}</td>

									<td>
										<div class="d-flex flex-column gap-2">
											<c:if test="${u.status == 'OnTime'}">
												<span class="badge bg-success text-white"
													style="width: fit-content;">Ontime</span>
											</c:if>
											<c:if test="${u.status  == 'Late'}">
												<span class="badge bg-warning  text-white"
													style="width: fit-content;">Late</span>
											</c:if>
											<c:if test="${u.status  == 'Early Out'}">
												<span class="badge  bg-warning  text-white"
													style="width: fit-content;">Early Out</span>
											</c:if>
											<c:if test="${u.status  == 'Unfinished Work'}">
												<span class="badge  bg-warning  text-white"
													style="width: fit-content;">Unfinished Work</span>
											</c:if>
											<c:if test="${u.status  == 'Incomplete'}">
												<span class="badge bg-dark text-white"
													style="width: fit-content;">Incomplete</span>
											</c:if>
											<c:if
												test="${u.status  == 'Absent/Error' && empty u.leaveType }">
												<span class="badge bg-danger text-white"
													style="width: fit-content;">No Record</span>
											</c:if>
											<c:if test="${u.leaveType  == 'ลาป่วย'}">
												<div class="d-flex gap-2">
													<span class="badge text-white" style="background: #6F42C1">Sick
														Leave <c:if test="${fn:trim(u.leaveStatus) eq '0' }">
															<i class="fa fa-hourglass-end ps-1"></i>
														</c:if>
													</span> <i class="ki-duotone ki-document fs-2 leave-doc"
														data-leaveid="${u.leaveId}" style="color: #1B84FF"> <span
														class="path1"></span> <span class="path2"></span>
													</i>
												</div>
											</c:if>
											<c:if
												test="${u.leaveType  == 'ลากิจ' || u.leaveType == 'ลาพักร้อน' || u.leaveType == 'ลาพักร้อนที่เหลือจากปีก่อน'}">
												<div class="d-flex gap-2">

													<span class="badge bg-primary text-white">Leave <c:if
															test="${fn:trim(u.leaveStatus)  eq '0' }">
															<i class="fa fa-hourglass-end ps-1"></i>
														</c:if>

													</span> <i class="ki-duotone ki-document fs-2 leave-doc"
														data-leaveid="${u.leaveId}" style="color: #1B84FF"> <span
														class="path1"></span> <span class="path2"></span>
													</i>
												</div>
											</c:if>
										</div>
									</td>
								</tr>
							</c:forEach>
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

			$('#table thead').on('click', 'th', function() {
				let isActive = $(this).hasClass('d-flex');

				$('#table thead th').removeClass('d-flex');

				if (!isActive) {
					$(this).addClass('d-flex');
				}
			});

			// --------------------- Data table ---------------	---------
			const table = $('#table').DataTable({
				scrollCollapse : true,
				autoWidth : false,
				responsive : true,
				language : {
					emptyTable : "No Data"
				},

				searching : false,
				info : false,
				paging : false,

				columnDefs : [ {
					orderable : true,
					targets : "_all"
				} ],

				order : []
			});

			table.on('order.dt', function() {
				let order = table.order();

				$('#table thead th').removeClass('d-flex');

				if (order.length > 0) {
					let colIndex = order[0][0];
					$('#table thead th').eq(colIndex).addClass('d-flex');
				}
			});

			// --------------------- Data table ---------------	---------

			// --------------------- Leave Modal ---------------	---------

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