<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<style>
.color-sun {
	color: var(--bs-red) !important;
}

.color-mon {
	color: var(--bs-yellow) !important;
}

.color-tue {
	color: var(--bs-pink) !important;
}

.color-wed {
	color: var(--bs-green) !important;
}

.color-thu {
	color: var(--bs-orange) !important;
}

.color-fri {
	color: var(--bs-blue) !important;
}

.color-sat {
	color: var(--bs-purple) !important;
}
</style>

<script>
	var overtimeDetails = {};
</script>

<fmt:setLocale value="en_US" />
<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
	<div class="d-flex flex-column flex-column-fluid">
		<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
			<div id="kt_app_toolbar_container"
				class="app-container container-fluid d-flex flex-stack">
				<div
					class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
					<h1
						class="page-heading d-flex text-gray-700 fw-semibold flex-column justify-content-center my-0">Overtime
						Request</h1>
					<ul
						class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
						<li class="breadcrumb-item text-muted">Home</li>
						<li class="breadcrumb-item"><span
							class="bullet bg-gray-500 w-5px h-2px"></span></li>
						<li class="breadcrumb-item text-muted">Cube Management</li>
					</ul>
				</div>
				<div class="d-flex mb-3">
					<button type="button"
						class="btn btn-success btn-flex h-45px fw-medium"
						onclick="addOvertime()">
						<i class="ki-duotone ki-plus fs-2"></i> <span>Create</span>
					</button>
				</div>
			</div>
		</div>
		<div id="kt_app_content" class="app-content flex-column-fluid">
			<div id="kt_app_content_container"
				class="app-container container-xxl">
				<div class="card">
					<div class="card-header border-0 pt-6 align-items-start">
						<div class="card-title pt-3">
							<h3 class="page-heading d-flex text-gray-900 fw-semibold my-0">Overtime
								Request</h3>
						</div>
					</div>

					<div class="card-body pt-0">
						<div
							class="d-flex flex-column flex-md-row align-items-md-center justify-content-end gap-4 mb-6">
							<div class="d-flex flex-column">
								<div class="position-relative w-300px">
									<i
										class="ki-duotone ki-calendar-8 w-20px h-20px d-inline-block text-gray-500 position-absolute top-50 start-0 translate-middle-y ms-4"
										style="font-size: 20px; line-height: 20px;"> <span
										class="path1"></span><span class="path2"></span><span
										class="path3"></span> <span class="path4"></span><span
										class="path5"></span><span class="path6"></span>
									</i> <input type="text"
										class="form-control ps-14 h-55px cursor-pointer fw-medium text-gray-700"
										id="overtimeRangePicker" placeholder="Select date range"
										readonly />
								</div>
							</div>
						</div>

						<div class="table-responsive">
							<table
								class="table table-striped table-hover align-middle table-row-bordered"
								id="kt_table">
								<thead>
									<tr
										class="text-start text-gray-500 fw-bold fs-7 text-uppercase gs-0 border-bottom border-gray-200"
										style="height: 39px;">
										<th class="min-w-100px w-100px text-center">#</th>
										<th>Start Date OT</th>
										<th>End Date OT</th>
										<th style="text-transform: none !important;">Actual (Hr)</th>
										<th class="min-w-150px w-150px">Status</th>
										<th class="text-end pe-5 min-w-150px w-150px">Actions</th>
									</tr>
								</thead>
								<tbody>
									<c:set var="displayName" value="" />
									<c:if test="${not empty sessionScope.onlineUser.employeeId}">
										<c:set var="displayName"
											value="${sessionScope.onlineUser.employeeId}" />
									</c:if>
									<c:if test="${not empty sessionScope.onlineUser.nameEN}">
										<c:if test="${not empty displayName}">
											<c:set var="displayName" value="${displayName} - " />
										</c:if>
										<c:set var="displayName"
											value="${displayName}${sessionScope.onlineUser.nameEN}" />
									</c:if>
									<c:if test="${not empty sessionScope.onlineUser.name}">
										<c:if test="${not empty displayName}">
											<c:set var="displayName" value="${displayName} - " />
										</c:if>
										<c:set var="displayName"
											value="${displayName}${sessionScope.onlineUser.name}" />
									</c:if>

									<%-- เพิ่ม role --%>
									<c:if test="${not empty sessionScope.onlineUser.roleId}">
										<c:set var="displayName"
											value="${displayName} - ${sessionScope.onlineUser.roleId}" />
									</c:if>
									<c:forEach var="ot" items="${overtimeList}" varStatus="vs">
										<fmt:formatNumber value="${ot.req_hours}" pattern="0.00"
											var="formattedReq" />
										<c:set var="displayReqHours"
											value="${fn:replace(formattedReq, '.', ':')}" />
										<c:set var="approverDisplay" value="" />

										<c:forEach var="u" items="${userList}">
											<c:if test="${u.user_id == ot.approver_id}">
												<%-- ประกอบชื่อ: employeeId - nameEN --%>
												<c:set var="approverDisplay"
													value="${u.employee_id} - ${u.name_en}" />
											</c:if>
										</c:forEach>
										<script>
											overtimeDetails['${ot.ot_id}'] = {
												userName : '${fn:escapeXml(displayName)}',
												startDateTime : '<fmt:formatDate value="${ot.start_time}" pattern="yyyy-MM-dd HH:mm" />',
												endDateTime : '<fmt:formatDate value="${ot.end_time}" pattern="yyyy-MM-dd HH:mm" />',
												hours : '${ot.req_hours}',
												desc : '<c:out value="${ot.description}" escapeXml="true" />',
												status : '${ot.status_name}',
												color : '${ot.status_color}',
												approver : '${fn:escapeXml(ot.approver_employee_id)} - ${fn:escapeXml(ot.approver_name)}',
												approveTime : '<fmt:formatDate value="${ot.approve_time}" pattern="dd MMM yyyy, HH:mm" />',
												apprHours : '${ot.appr_hours}',
												typeOfOt : '${ot.type_of_ot}',
												descAppr : '<c:out value="${ot.description_appr}" escapeXml="true" />'
											};
										</script>
										<tr>
											<td class="text-center px-0 text-gray-900 fw-bold fs-7">${vs.count}</td>

											<td class="text-gray-900 fw-normal fs-6"><fmt:formatDate
													value="${ot.end_time}" pattern="d MMM yyyy, H:mm" /></td>

											<td class="text-gray-900 fw-normal fs-6"><fmt:formatDate
													value="${ot.start_time}" pattern="d MMM yyyy, H:mm" /></td>

											<td><span
												class="badge badge-lg badge-light-${ot.status_color} fw-bold fs-7 h-25px">
													${displayReqHours} </span></td>

											<td>
												<div class="d-flex flex-column align-items-start">
													<span
														class="badge badge-lg badge-light-${ot.status_color} fw-bold px-4 py-3">
														${ot.status_name} </span>

													<c:if test="${not empty ot.description_appr}">
														<span class="fw-normal fs-6 text-gray-900 mt-2"
															style="display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;"
															title="<c:out value='${ot.description_appr}'/>"> <c:out
																value="${ot.description_appr}" />
														</span>
													</c:if>
												</div>
											</td>

											<td class="text-end pe-5">
												<div class="d-flex justify-content-end gap-3">
													<button type="button"
														class="btn btn-icon btn-sm btn-light-info bg-info-subtle"
														onclick="openDetail('${ot.ot_id}')">
														<i class="ki-duotone ki-document fs-1"> <span
															class="path1"></span><span class="path2"></span>
														</i>
													</button>

													<button type="button"
														class="btn btn-icon btn-sm w-35px h-35px ${ot.status eq 'W' ? 'btn-light-primary' : 'btn-light text-muted'}"
														onclick="window.location.href='${pageContext.request.contextPath}/overtime_request_edit?id=${ot.ot_id}'"
														${ot.status eq 'W' ? '' : 'disabled'}>
														<i class="ki-duotone ki-pencil fs-1"> <span
															class="path1"></span><span class="path2"></span>
														</i>
													</button>

													<button type="button"
														class="btn btn-icon btn-sm w-35px h-35px ${ot.status eq 'W' ? 'btn-light-danger' : 'btn-light text-muted'}"
														onclick="deleteOT('${ot.ot_id}')"
														${ot.status eq 'W' ? '' : 'disabled'}>
														<i class="ki-duotone ki-trash fs-1"> <span
															class="path1"></span><span class="path2"></span> <span
															class="path3"></span><span class="path4"></span> <span
															class="path5"></span>
														</i>
													</button>
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
		</div>
	</div>
</div>

<!-- Modal -->
<div class="modal fade" id="viewOvertimeModal" tabindex="-1"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered modal-lg">
		<div class="modal-content border-0">
			<div
				class="modal-header border-0 mb-12 d-flex justify-content-between align-items-center">
				<div class="m-0">
					<h1 class="mb-0">Overtime Detail</h1>
				</div>

				<div class="btn btn-icon btn-sm btn-active-light-danger ms-2"
					data-bs-dismiss="modal" aria-label="Close">
					<i class="ki-duotone ki-cross fs-1"> <span class="path1"></span><span
						class="path2"></span>
					</i>
				</div>
			</div>
			<div class="modal-body mx-3 pt-0 pb-15">
				<div class="d-flex align-items-center mb-8">
					<i class="ki-duotone ki-user-square fs-2 text-gray-500 me-4"><span
						class="path1"></span><span class="path2"></span> <span
						class="path3"><span class="path4"></span></span></i>
					<div class="fw-medium fs-5 text-gray-900" id="modalUserName"></div>
				</div>

				<div class="row mb-8">
					<div class="col-12 col-md-6 d-flex align-items-center mb-3 mb-md-0">
						<i class="ki-duotone ki-calendar-2 fs-2 text-gray-500 me-3"> <span
							class="path1"></span><span class="path2"></span><span
							class="path3"></span> <span class="path4"></span><span
							class="path5"></span><span class="path6"></span>
						</i>
						<div
							class="d-flex align-items-center fw-medium fs-5 text-gray-800">
							<span id="modalStartDay"></span> <span id="modalStartDateTime"></span>
						</div>
					</div>

					<div class="col-12 col-md-6 d-flex align-items-center mb-3 mb-md-0">
						<i class="ki-duotone ki-calendar-2 fs-2 text-gray-500 me-3"> <span
							class="path1"></span><span class="path2"></span><span
							class="path3"></span> <span class="path4"></span><span
							class="path5"></span><span class="path6"></span>
						</i>
						<div
							class="d-flex align-items-center fw-medium fs-5 text-gray-800">
							<span id="modalEndDay"></span> <span id="modalEndDateTime"></span>
						</div>
					</div>
				</div>

				<div class="row mb-8">
					<div class="col-12 col-md-6 d-flex align-items-start mb-3 mb-md-0">
						<span id="modalHours"
							class="badge badge-lg badge-light-primary fw-semibold h-25px px-4 d-inline-flex align-items-center justify-content-center">
						</span>
					</div>

					<div class="col-12 col-md-6 d-flex align-items-start">
						<i class="ki-duotone ki-document fs-2 text-gray-500 me-3"> <span
							class="path1"></span><span class="path2"></span>
						</i>
						<div class="flex-grow-1 mt-0">
							<span id="modalDesc" class="fw-normal fs-6"
								style="color: #333333; white-space: pre-wrap; word-break: break-word; line-height: 1.5;">
							</span>
						</div>
					</div>
				</div>

				<div class="separator separator-dashed my-10"></div>
				<h3 id="modalStatusTitle" class="fw-bold mb-10"></h3>
				<div id="approverSection">
					<div class="row mb-8">
						<div
							class="col-12 col-md-6 d-flex align-items-center mb-3 mb-md-0">
							<i class="ki-duotone ki-user-tick fs-2 text-gray-500 me-3"> <span
								class="path1"></span><span class="path2"></span><span
								class="path3"></span>
							</i> <span id="modalApprover" class="fw-medium text-gray-800"></span>
						</div>

						<div class="col-12 col-md-6 d-flex align-items-center">
							<i class="ki-duotone ki-calendar-2 fs-2 text-gray-500 me-3">
								<span class="path1"></span><span class="path2"></span><span
								class="path3"></span> <span class="path4"></span><span
								class="path5"></span>
							</i> <span id="modalApproveDay"></span> <span id="modalApproveTime"
								class="fw-medium text-gray-800 fs-6"></span>
						</div>
					</div>
					<div class="row mb-8">
						<div class="col-12 col-md-6 d-flex align-items-start mb-3 mb-md-0">
							<span id="modalApprHours"
								class="badge badge-lg badge-light-success fw-semibold h-25px d-inline-flex align-items-center justify-content-center me-3"></span>
							<span id="modalTypeOT"
								class="badge badge-lg badge-primary fw-semibold h-25px d-inline-flex align-items-center justify-content-center"></span>
						</div>

						<div class="col-12 col-md-6 d-flex align-items-start">
							<i class="ki-duotone ki-document fs-2 text-gray-500 me-3"> <span
								class="path1"></span><span class="path2"></span>
							</i>
							<div class="flex-grow-1 mt-0">
								<span id="modalDescAppr" class="fw-normal fs-6"
									style="color: #333333; white-space: pre-wrap; word-break: break-word; line-height: 1.5;">
								</span>
							</div>
						</div>
					</div>
				</div>

				<div class="d-flex justify-content-end mt-20">
					<button type="button" class="btn btn-light fw-medium px-9 h-45px"
						data-bs-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Modal -->

<script>
	function addOvertime() {
		window.location.href = "${pageContext.request.contextPath}/overtime_request_add";
	}

	// FILTERING & DATE PICKER
	document.addEventListener("DOMContentLoaded", function() {
		const url = new URL(window.location.href);

		const currentYear = moment().year();
		const defaultStart = moment().year(currentYear).startOf('year').format(
				'YYYY-MM-DD');
		const defaultEnd = moment().year(currentYear).endOf('year').format(
				'YYYY-MM-DD');
		const savedDateRange = url.searchParams.get("dateRange");

		function updateFilters(dateStr) {
			url.searchParams.set("dateRange", dateStr);
			window.location.href = url.toString();
		}

		const fp = flatpickr("#overtimeRangePicker", {
			mode : "range",
			dateFormat : "Y-m-d",
			altInput : true,
			altFormat : "j M Y",
			locale : {
				rangeSeparator : " - "
			},
			defaultDate : savedDateRange ? savedDateRange.split(" - ") : [
					defaultStart, defaultEnd ],
			onClose : function(selectedDates, dateStr) {
				if (selectedDates.length === 2) {
					updateFilters(dateStr);
				}
			}
		});
	});

	// DATA TABLE CONFIGURATION
	$(document).ready(function() {
		$('#kt_table').DataTable({
			paging : true,
			lengthChange : true,
			lengthMenu : [ [ 10, 25, 50, -1 ], [ 10, 25, 50, "All" ] ],
			searching : false,
			info : false,
			autoWidth : false,
			order : [],
			language : {
				emptyTable : "No Overtime Request",
			},
			columnDefs : [ {
				targets : 0,
				orderable : true,
				className : "text-center align-middle px-0"
			}, {
				targets : [ 1, 2, 3, 4, 5 ],
				orderable : false,
				className : "align-middle"
			} ]
		});
	});

	// DELETE CONFIRMATION
	function deleteOT(otId) {
		Swal
				.fire({
					text : "Are you sure you want to delete this record?",
					icon : "warning",
					showCancelButton : true,
					buttonsStyling : false,
					confirmButtonText : "Yes, delete it!",
					cancelButtonText : "No, cancel",
					customClass : {
						confirmButton : "btn fw-bold btn-danger",
						cancelButton : "btn fw-bold btn-light"
					}
				})
				.then(
						function(result) {
							if (result.value) {
								window.location.href = "${pageContext.request.contextPath}/overtime_request_delete?id="
										+ otId;
							}
						});
	}

	const dayClasses = {
		'Sun' : 'color-sun',
		'Mon' : 'color-mon',
		'Tue' : 'color-tue',
		'Wed' : 'color-wed',
		'Thu' : 'color-thu',
		'Fri' : 'color-fri',
		'Sat' : 'color-sat'
	};

	// VIEW DETAIL MODAL
	function openDetail(id) {
		var data = overtimeDetails[id];
		if (!data)
			return;

		$('#modalUserName').text(data.userName);

		let startMoment = moment(data.startDateTime, "YYYY-MM-DD HH:mm");
		let endMoment = moment(data.endDateTime, "YYYY-MM-DD HH:mm");

		let startDay = startMoment.format('ddd');
		let startText = startMoment.format('D MMM YYYY, H:mm');

		let endDay = endMoment.format('ddd');
		let endText = endMoment.format('D MMM YYYY, H:mm');

		$('#modalStartDay').text(startDay).attr('class',
				'me-2 fs-6 fw-medium ' + dayClasses[startDay]);
		$('#modalStartDateTime').text(startText).attr('class',
				'fs-6 fw-medium text-gray-800');

		$('#modalEndDay').text(endDay).attr('class',
				'me-2 fs-6 fw-medium ' + dayClasses[endDay]);
		$('#modalEndDateTime').text(endText).attr('class',
				'fs-6 fw-medium text-gray-800');

		$('#modalHours').text(data.hours + ' Hrs');
		$('#modalDesc').text(data.desc ? data.desc : "-");

		var statusTitle = $('#modalStatusTitle');
		statusTitle.text(data.status);
		statusTitle.attr('class', 'fw-bold mb-10 text-'
				+ (data.color === 'info' ? 'primary' : data.color));

		var approverText = data.approver && data.approver.trim() !== ''
				&& data.approver.trim() !== '-' ? data.approver : '-';
		$('#modalApprover').text(approverText);

		if (data.status === 'Wait for approve' || data.status === 'W') {

			$('#approverSection').hide();

		} else {

			if (data.approveTime && data.approveTime.trim() !== ''
					&& data.approveTime !== '-') {
				let apprMoment = moment(data.approveTime, "DD MMM YYYY, HH:mm");
				let apprDay = apprMoment.format('ddd');
				$('#modalApproveDay').text(apprDay).attr('class',
						'me-2 fs-6 fw-medium ' + dayClasses[apprDay]).show();
				$('#modalApproveTime').text(data.approveTime).attr('class',
						'fs-6 fw-medium text-gray-800');
			} else {
				$('#modalApproveDay').hide();
				$('#modalApproveTime').text('-').attr('class',
						'fs-6 fw-medium text-gray-800');
			}

			if (data.apprHours && parseFloat(data.apprHours) > 0) {
				let totalDecimalHours = parseFloat(data.apprHours);
				let h = Math.floor(totalDecimalHours);
				let m = Math.round((totalDecimalHours - h) * 60);
				let formattedTime = h + ':' + String(m).padStart(2, '0');

				let dynamicClass = 'badge badge-lg fw-semibold h-25px d-inline-flex align-items-center justify-content-center me-3 badge-light-'
						+ data.color + ' text-' + data.color;

				$('#modalApprHours').text(formattedTime + ' Hrs').attr('class',
						dynamicClass).show();
			} else {
				$('#modalApprHours').hide();
			}

			if (data.typeOfOt && data.typeOfOt.trim() !== '') {
				let otRate = parseFloat(data.typeOfOt);
				$('#modalTypeOT').text(otRate + 'X').show();
			} else {
				$('#modalTypeOT').hide();
			}

			if (data.descAppr && data.descAppr.trim() !== '') {
				$('#modalDescAppr').text(data.descAppr);
			} else {
				$('#modalDescAppr').text("-");
			}

			$('#approverSection').show();
		}

		$('#viewOvertimeModal').modal('show');

	}
</script>