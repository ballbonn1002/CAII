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
<title>Timesheet</title>

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

<!-- flatpickr  -->
<script
	src="https://cdn.jsdelivr.net/npm/flatpickr/dist/plugins/monthSelect/index.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/plugins/monthSelect/style.css">

<style type="text/css">
.ps-12 {
	padding-left: 3rem !important;
}

.search-icon {
	position: absolute;
	top: 50%;
	left: 14px;
	transform: translateY(-70%);
	z-index: 10;
	pointer-events: none;
}

.dot {
	display: inline-block;
	width: 10px;
	height: 10px;
	border-radius: 50%;
	margin-right: 8px;
}

.dot-sunday {
	background: #dc3545;
}

.dot-monday {
	background: #ffc107;
}

.dot-tuesday {
	background: #ff6b81;
}

.dot-wednesday {
	background: #28a745;
}

.dot-thursday {
	background: #fd7e14;
}

.dot-friday {
	background: #007bff;
}

.dot-saturday {
	background: #6f42c1;
}

.bg-weekend {
	background: #e1e5ec;
}

.bg-holiday {
	background: #eef4fb;
}
</style>
</head>
<body>
	<div class="app-main flex-column app-container container-xxl">
		<div class="page-title py-3">
			<h1 class="page-heading text-gray-900 fw-bold fs-3">Time Sheet</h1>
			<ul
				class="list-unstyled d-inline-flex gap-2 text-muted fs-7 fw-medium">
				<li class="">Home</li>
				<li class="">-</li>
				<li class="">Cube Management</li>
			</ul>
		</div>
		<div class="app-content">
			<div class="card mb-5">
				<div class="card-body">
					<form id="timeSheetForm" class="d-flex gap-10 w-100 mb-5 mb-lg-0"
						action="timeSheetSearch	" method="post">
						<div class="position-relative w-100">
							<i class="ki-duotone ki-magnifier search-icon fs-3"> <span
								class="path1"></span> <span class="path2"></span>
							</i> <select class="form-select ps-11" id="userSelect"
								name="userSelect" ${roleUser != 'admin' ? 'disabled':''}>
								<optgroup label="Enable">
									<c:forEach var="u" items="${userEnable}">
										<c:choose>
											<c:when test="${not empty idUserSelected}">
												<option value="${u.id}"
													${u.id == idUserSelected ? 'selected' : ''}>
													${u.employeeId}-${u.name}-${u.nameEN}</option>
											</c:when>
											<c:otherwise>
												<option value="${u.id}" ${u.id == user.id ? 'selected' : ''}>
													${u.employeeId}-${u.name}-${u.nameEN}</option>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</optgroup>
								<optgroup label="Disable">
									<c:forEach var="u" items="${userDisable}">
										<option value="${u.id}" ${u.id == user.id ? 'selected' : ''}>
											${u.employeeId}-${u.name}-${u.nameEN}</option>
									</c:forEach>
								</optgroup>
							</select>
						</div>
						<div class="input-group w-50">
							<span class="input-group-text bg-transparent"><i
								class="ki-duotone ki-calendar-8 fs-3"> <span class="path1"></span>
									<span class="path2"></span> <span class="path3"></span> <span
									class="path4"></span> <span class="path5"></span> <span
									class="path6"></span>
							</i> </span> <input type="text" class="form-control border-start-0"
								id="date" name="searchDate" value="${searchDate}" />
						</div>
					</form>
				</div>
			</div>
			<div class="card">
				<div class="card-header pt-7 border-0">
					<h3 class="fw-bold text-gray-900 fs-3">Time Sheet</h3>
					<div class="action-right">
						<a class="btn btn-sm"
							href="upload/template/Timesheet_Template2022.xlsx"
							style="background-color: #8E44AD; color: white;"> Template </a> <label
							class="btn btn-sm" for="myFile"
							style="width: 80px; background-color: #E7505A; color: white; display: inline-block; cursor: pointer;">
							Import <input class="fileinput fileinput-new"
							data-provides="fileinput" type="file"
							accept="application/vnd.ms-excel, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
							name="fileUpload" id="myFile" style="display: none;" />
						</label> <a class="btn btn-sm"
							href="timeSheetExport?date=${searchDate}&userId=${not empty searchUserId ? searchUserId : user.id}"
							title="Print" style="background-color: #26C281; color: white;">Export</a>
					</div>
				</div>
				<div class="card-body pb-0">
					<div class="table-responsive">
						<table class="table table-bordered fs-6 gy-5 ">
							<thead class="text-gray-500 fw-bold fs-7">
								<tr class="text-center">
									<th>วันที่ทำงาน</th>
									<th colspan="2">ช่วงที่1</th>
									<th colspan="2">ช่วงที่2(OT)</th>
									<th colspan="2">รวมเวลา</th>
									<th>Project</th>
									<th>Description</th>
									<th>Time Spent</th>
									<th>ACTION</th>
								</tr>
								<tr class="text-center">
									<th class="text-center">วันที่</th>
									<th>เข้า</th>
									<th>ออก</th>
									<th>เข้า</th>
									<th>ออก</th>
									<th>รวม</th>
									<th>OT</th>
									<th></th>
									<th></th>
									<th></th>
									<th></th>

								</tr>
							</thead>
							<tbody>
								<c:forEach var="d" items="${dateList}">
									<c:set var="holiday" value="${holidayMap[d.date]}" />
									<c:set var="leave" value="${leaveMap[d.date]}" />
									<c:set var="timeSheetList" value="${timeSheetMap[d.date]}" />

									<c:choose>
										<c:when test="${not empty timeSheetList}">
											<c:forEach var="ts" items="${timeSheetList}" varStatus="loop">
												<tr
													class="border-bottom fs-6 fw-normal align-middle text-center ${d.cssClass =='dot-sunday' || d.cssClass =='dot-saturday' ? 'bg-weekend' :''}
										${holiday != null || leave != null ? 'bg-holiday' : ''}">
													<c:if test="${loop.first}">
														<td rowspan="${fn:length(timeSheetList)}"
															class="text-center"><span class="dot ${d.cssClass}"></span>
															${d.date}</td>
													</c:if>
													<td><span class="time-start-text-${ts.id}"> <fmt:formatDate
																value="${ts.time_check_in}" pattern="HH:mm" />
													</span> <input type="text"
														class="form-control py-4 d-none time-picker"
														id="input-start-time-${ts.id}" name="start-time" /></td>
													<td><span class="time-end-text-${ts.id} "><fmt:formatDate
																value="${ts.time_check_out}" pattern="HH:mm" /></span> <input
														type="text" class="form-control py-4 d-none time-picker"
														id="input-end-time-${ts.id}" name="end-time" /></td>
													<td><span class="OT-time-start-text-${ts.id}">
															<fmt:formatDate value="${ts.OT_time_start}"
																pattern="HH:mm" />
													</span> <input type="text"
														class="form-control py-4 d-none time-picker"
														id="input-start-overtime-${ts.id}" name="start-overtime" /></td>

													<td><span class="OT-time-end-text-${ts.id}"> <fmt:formatDate
																value="${ts.OT_time_end}" pattern="HH:mm" />
													</span><input type="text"
														class="form-control py-4 d-none time-picker"
														id="input-end-overtime-${ts.id}" name="end-overtime" /></td>
													<td><span class="total-time-text-${ts.id}">${ts.total_time}</span></td>
													<td><span class="total-time-OT-text-${ts.id}">${ts.total_time_OT}</span></td>
													<c:choose>
														<c:when test="${ts.time_check_in != null }">
															<td><span class="project-text-${ts.id} d-block">${ts.project}</span><span
																class="summary-text-${ts.id}">${ts.summary}</span><input
																type="text" name="project" id="input-project-${ts.id}"
																class="form-control py-4 d-none mb-2"
																value="${ts.project}"> <input type="text"
																name="summary" id="input-summary-${ts.id}"
																class="form-control py-4 d-none" value="${ts.summary}"></td>
														</c:when>
														<c:when test="${holiday != null}">
															<td>${holiday.head}</td>
														</c:when>
														<c:when test="${leave != null}">
															<td>${leave.description}</td>
														</c:when>
														<c:otherwise>
															<td></td>
														</c:otherwise>
													</c:choose>
													<td><span class="description-text-${ts.id}">${ts.description}</span><input
														type="text" name="description"
														id="input-description-${ts.id}"
														class="form-control py-4 d-none" value="${ts.description}"></td>
													<td><fmt:formatDate value="${ts.timespent}"
															pattern="HH:mm" /></td>
													<c:choose>
														<c:when test="${holiday == null && leave == null}">
															<td class="fs-6 fw-normal"><fmt:parseDate
																	value="${d.date}" pattern="dd/MM/yyyy" var="parsedDate" />
																<div class="d-flex gap-2 justify-content-center">
																	<a href="addTimeSheet?date=${d.date}"
																		class="btn btn-icon btn-light-primary btn-sm"><i
																		class="bi bi-plus fs-1"></i> </a>
																	<perm:permission object="timesheet.edit">
																		<button class="btn btn-icon  btn-light-primary btn-sm"
																			onclick="onChangeToEditMode(${ts.id}, '<fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd"/>')">
																			<i class="ki-duotone ki-pencil fs-5"> <span
																				class="path1"></span> <span class="path2"></span>
																			</i>
																		</button>
																		<button class="btn btn-icon btn-light-danger btn-sm"
																			onclick="onDelete(${ts.id})">
																			<i class="ki-duotone ki-trash fs-5"> <span
																				class="path1"></span><span class="path2"></span> <span
																				class="path3"></span><span class="path4"></span> <span
																				class="path5"></span>
																			</i>
																		</button>
																	</perm:permission>


																</div></td>
														</c:when>
														<c:otherwise>
															<td></td>
														</c:otherwise>
													</c:choose>
												</tr>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<tr
												class="border-bottom fs-6 fw-normal align-middle text-center ${d.cssClass =='dot-sunday' || d.cssClass =='dot-saturday' ? 'bg-weekend' :''}
										${holiday != null || leave != null ? 'bg-holiday' : ''}">
												<td class="text-center"><span class="dot ${d.cssClass}"></span>
													${d.date}</td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<c:choose>
													<c:when test="${holiday != null}">
														<td>${holiday.head}</td>
													</c:when>
													<c:when test="${leave != null}">
														<td>${leave.description}</td>
													</c:when>
													<c:otherwise>
														<td></td>
													</c:otherwise>
												</c:choose>
												<td></td>
												<td></td>
												<c:choose>
													<c:when test="${holiday == null && leave == null}">
														<td class="text-center"><a
															href="addTimeSheet?date=${d.date}"
															class="btn btn-icon btn-light-primary btn-sm"> <i
																class="bi bi-plus fs-1"></i>
														</a></td>
													</c:when>
													<c:otherwise>
														<td></td>
													</c:otherwise>
												</c:choose>
											</tr>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>

			<!-- Summary -->
			<div class="card mt-5">
				<div class="card-body">
					<div class="table-responsive">
						<table class="table table-striped table-bordered fs-6 gy-5 ">
							<thead class="text-gray-500 fw-bold fs-7">
								<tr class="text-center">
									<th>สรุปเวลา</th>
									<th>ทำงานทั้งหมด</th>
									<th>(สาย + ออกก่อน) หัก 60 นาที</th>
									<th>ขาดงาน</th>
									<th>ลางาน</th>
									<th>ล่วงเวลาทั้งหมด</th>
									<th>จำนวนชั่วโมงการบริการส่วนเพิ่ม x1</th>
									<th>จำนวนชั่วโมงการบริการส่วนเพิ่ม x1.5</th>
									<th>จำนวนชั่วโมงการบริการส่วนเพิ่ม x3</th>
								</tr>
							</thead>
							<tbody>
								<tr
									class="border-bottom fs-6 fw-normal text-center align-middle">
									<td>วัน</td>
									<td>${total_work}</td>
									<td>${total_late}</td>
									<td>${total_absent}</td>
									<td>${total_leave}</td>
									<td>${total_OT}</td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								<tr
									class="border-bottom fs-6 fw-normal text-center align-middle">
									<td class="px-4">ชั่วโมง(นาที/60*100)</td>
									<%-- <td><fmt:formatDate value="${0}" pattern="HH:mm" /></td>
									<td><fmt:formatDate value="${0}" pattern="HH:mm" /></td>
									<td><fmt:formatDate value="${0}" pattern="HH:mm" /></td>
									<td><fmt:formatDate value="${0}" pattern="HH:mm" /></td>
									<td><fmt:formatDate value="${0}" pattern="HH:mm" /></td>
									<td><fmt:formatDate value="${0}" pattern="HH:mm" /></td>
									<td><fmt:formatDate value="${0}" pattern="HH:mm" /></td>
									<td><fmt:formatDate value="${0}" pattern="HH:mm" /></td> --%>

									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
							</tbody>
						</table>
					</div>

				</div>


			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(function() {
			$('#userSelect').select2({
				width: '100%',
			});

			$('#userSelect, #date').on('change', function() {
				$('#timeSheetForm').submit();
			});

			const fpOpts = {
				plugins : [ new monthSelectPlugin({
					shorthand : true, // Jan, Feb
					dateFormat : "m-Y", // format ที่ส่งไป server
					altFormat : "F Y" // format ที่แสดงผล เช่น February 2026
				}) ],
				altInput : true,
				allowInput : true,
				disableMobile : true,
				defaultDate : $('#date').val() || "today"
			};

			const fpStart = flatpickr("#date", fpOpts);	
			
		    flatpickr(
			    	   ".time-picker",
			    	    {
			    	        enableTime: true,
			    	        noCalendar: true,
			    	        dateFormat: "H:i",
			    	        time_24hr: true,
			    	        allowInput: true,
			    	        defaultDate: "00:00"
			    	    }
			    );
			

		})
		function formatTime(dateString){
    if(!dateString) return "";

    const d = new Date(dateString);

    let h = d.getHours().toString().padStart(2,'0');
    let m = d.getMinutes().toString().padStart(2,'0');

    return h + ":" + m;
}
		
			const onDelete = (id) => {
				 Swal.fire({
			          title: 'Are you sure?',
			          text: "This time sheet will be deleted.",
			          icon: 'warning',
			          showCancelButton: true,
			          confirmButtonColor: '#3085d6',
			          cancelButtonColor: '#d33',
			          confirmButtonText: 'Yes, delete it!'
				 }).then((result) =>{
					 if(result.isConfirmed){
						 window.location.href = "deleteTimeSheet?timeSheetId=" + id;
					 }
				 })
			}
			
			const onChangeToEditMode = (id,dateTime) => {
				let timeStartTag = $('.time-start-text-'+id);
				let timeEndTag = $('.time-end-text-'+id);
				let overtimeStartTag = $('.OT-time-start-text-'+id);
				let overtimeEndTag = $('.OT-time-end-text-'+id);
				let projectTag = $('.project-text-'+id);
				let descriptionTag = $('.description-text-'+id);
				let summaryTag = $('.summary-text-'+id);
				let totalTimeTag = $('.total-time-text-'+id);
				let totalOvertimeTag = $('.total-time-OT-text-'+id);
				
			    let inputStart = $('#input-start-time-' + id);
			    let inputEnd = $('#input-end-time-' + id);
			    let inputStartOT = $('#input-start-overtime-' + id);
			    let inputEndOT = $('#input-end-overtime-' + id);
			    let inputDescription = $('#input-description-' + id);
			    let inputProject = $('#input-project-' + id);
			    let inputSummary = $('#input-summary-' + id);
			    
		
			    
			    
			 // เช็คว่าอยู่ใน edit mode ไหม
			    if (!inputStart.hasClass('d-none')) {

			        // 🔹 กลับสู่ normal mode
			        timeStartTag.show();
			        timeEndTag.show();
			        overtimeStartTag.show();
			        overtimeEndTag.show();
			        descriptionTag.show();
			        projectTag.show();
			        projectTag.addClass('d-block');
			        summaryTag.show();

			        inputStart.addClass('d-none');
			        inputEnd.addClass('d-none');
			        inputStartOT.addClass('d-none');
			        inputEndOT.addClass('d-none');
			        inputDescription.addClass('d-none');
			        inputProject.addClass('d-none');
			        inputSummary.addClass('d-none');
			        
			        $.ajax({
						type : "POST",
						url : "updateTimeSheet",
						data : {
							timeSheetId : id,
							startTime: inputStart.val(),
							endTime:inputEnd.val(),
							startOvertime: inputStartOT.val(),
							endOvertime: inputEndOT.val(),
							description: inputDescription.val().trim(),
							project: inputProject.val().trim(),
							summary:inputSummary.val().trim(),
							date:dateTime

						},
						dataType : "json",
						success : function(res) {
								Swal.fire({
									  title: "Success",
									  text: "time sheet update success!",
									  icon: "success"
									});
								timeStartTag.text(formatTime(res.newTimeSheet.timeCheckIn));
								timeEndTag.text(formatTime(res.newTimeSheet.timeCheckOut));
								overtimeStartTag.text(formatTime(res.newTimeSheet.OT_time_start));
								overtimeEndTag.text(formatTime(res.newTimeSheet.OT_time_end));
							    descriptionTag.text(res.newTimeSheet.description);
							    projectTag.text(res.newTimeSheet.project);
							    summaryTag.text(res.newTimeSheet.summary);
							    totalTimeTag.text(res.total_time);
							    totalOvertimeTag.text(res.total_time_OT);
			
						},
						error : function(err) {
							console.log(err);
							Swal.fire({
								  title: "Error",
								  text: "time sheet update fail!",
								  icon: "error"
								});
						}
					});
			        
			    } else {

			        // 🔹 เข้า edit mode
			        let timeStart = timeStartTag.text().trim();
			        let timeEnd = timeEndTag.text().trim();
			        let timeStartOT = overtimeStartTag.text().trim();
			        let timeEndOT = overtimeEndTag.text().trim();

			        timeStartTag.hide();
			        timeEndTag.hide();
			        overtimeStartTag.hide();
			        overtimeEndTag.hide();
			        descriptionTag.hide();
			        projectTag.hide();
			        projectTag.removeClass('d-block');
			        summaryTag.hide();
			        
			        inputStart.val(timeStart).removeClass('d-none');
			        inputEnd.val(timeEnd).removeClass('d-none');
			        inputStartOT.val(timeStartOT).removeClass('d-none');
			        inputEndOT.val(timeEndOT).removeClass('d-none');
			        inputDescription.removeClass('d-none');
			        inputProject.removeClass('d-none');
			        inputSummary.removeClass('d-none');
			    }
			};			
		
	</script>
</body>
</html>