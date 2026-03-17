<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Time Sheet</title>

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
	transform: translateY(-60%);
	z-index: 10;
	pointer-events: none;
}
</style>

</head>
<body>
	<div class="app-main flex-column app-container container-xxl">
		<div class="page-title py-3">
			<h1 class="page-heading fw-bold text-gray-900 fs-3">Time Sheet</h1>
			<ul
				class="list-unstyled d-inline-flex gap-2 text-muted fs-7 fw-medium">
				<li class="">Home</li>
				<li class="">-</li>
				<li class="">Cube Management</li>
				<li class="">-</li>
				<li class="">Time Sheet</li>
			</ul>
		</div>

		<div class="app-content">
			<div class="card">
				<div class="card-header pt-7 border-0">
					<h3 class="fw-bold text-gray-900 fs-3">Time Sheet Form</h3>
				</div>
				<form id="timeSheetForm" method="post" action="saveTimeSheet">
					<div class="card-body pb-0">
						<!-- General  -->
						<%-- 		<div class="mb-7">
							<label for="user" class="form-label text-gray-800 fw-medium">
								User </label> <select class="form-select h-100" id="userSelect"
								name="userSelect" ${roleUser != 'admin' ? 'disabled':''}>
								<optgroup label="Enable">
									<c:forEach var="u" items="${userEnable}">
										<option value="${u.id}" ${u.id == user.id ? 'selected' : ''}>
											${u.employeeId}-${u.name}-${u.nameEN}</option>
									</c:forEach>
								</optgroup>
								<optgroup label="Disable">
									<c:forEach var="u" items="${userDisable}">
										<option value="${u.id}" ${u.id == user.id ? 'selected' : ''}>
											${u.employeeId}-${u.name}-${u.nameEN}</option>
									</c:forEach>
								</optgroup>
							</select>
						</div> --%>

						<div class="position-relative w-100 mb-7">
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

						<!-- Date / Start / End / Time  -->
						<div class="input-group justify-content-between mb-7">
							<div class="w-50">
								<label for="date" class="form-label text-gray-800 fw-medium">
									Date</label>
								<div class="input-group">
									<span class="input-group-text bg-transparent"><i
										class="ki-duotone ki-calendar-8 fs-3"> <span class="path1"></span>
											<span class="path2"></span> <span class="path3"></span> <span
											class="path4"></span> <span class="path5"></span> <span
											class="path6"></span>
									</i> </span> <input type="text" class="form-control border-start-0 py-4"
										id="input-date" name="searchDate" value="${date}" />
								</div>
							</div>

							<div>
								<label for="start-time"
									class="form-label text-gray-800 fw-medium">From </label>
								<div class="input-group gap-2 align-items-center">
									<input type="text" class="form-control py-4"
										id="input-start-time" name="start-time" />
								</div>
							</div>
							<div>
								<label for="end-time" class="form-label text-gray-800 fw-medium">To
								</label>
								<div class="input-group gap-2 align-items-center">
									<input type="text" class="form-control py-4"
										id="input-end-time" name="end-time" />
								</div>
							</div>
						</div>
						<!-- Date / Start / End / Time  -->

						<div class="mb-7">
							<label for="team" class="form-label text-gray-800 fw-medium">Team</label>
							<input type="text" class="form-control py-4" id="input-team"
								name="team">
						</div>
						<!-- General  -->

						<!-- Task  -->
						<h3 class="my-15 fw-bold text-gray-900 fs-3">Task</h3>
						<div class="mb-7">
							<label class="form-label text-gray-800 fw-medium">
								Project </label>

							<!-- ช่องที่ user พิมพ์ -->
							<input class="form-control" list="projectList" id="input-project">

							<!-- ช่องที่ส่งไป backend -->
							<input type="hidden" name="projectSelect" id="projectIdHidden">
							<input type="hidden" name="projectName" id="projectIdHiddenName">

							<datalist id="projectList">
								<c:forEach var="p" items="${projectList}">
									<!-- เก็บ id ไว้ใน data-id -->
									<option value="${p.project_name}" data-id="${p.project_id}"
										data-name="${p.project_name}"></option>
								</c:forEach>
							</datalist>
						</div>
						<div class="mb-7">
							<label for="function" class="form-label text-gray-800 fw-medium">Function</label>
							<input class="form-control py-4" id="input-function"
								list="functionList"> <input type="hidden"
								name="function" id="functionIdHidden"> <input
								type="hidden" name="functionName" id="functionIdHiddenName">
							<datalist id="functionList"></datalist>
						</div>
						<div class="mb-7">
							<label for="task-description"
								class="form-label text-gray-800 fw-medium">Task
								Description</label>
							<textarea class="form-control py-4" id="input-task-description"
								name="task-description"></textarea>
						</div>
						<label for="time-spent" class="form-label text-gray-800 fw-medium">Time
							Spent Hour </label>
						<div class="input-group gap-2 align-items-center w-25 mb-7">
							<input type="text" class="form-control py-4"
								id="input-time-spent" name="time-spent" placeholder="0h 0mm" />
						</div>
						<!-- Task  -->

						<!-- Overtime  -->
						<div class="form-check my-15">
							<input class="form-check-input" type="checkbox"
								id="input-check-overtime"> <label class="form-label"
								for="check-overtime">Check Overtime</label>
						</div>
						<div id="overtime-container">
							<div class="d-flex gap-10 mb-7">
								<div class="input-group gap-2 align-items-center">
									<label for="start-overtime"
										class="form-label text-gray-800 fw-medium">Start
										Overtime: </label> <input type="text" class="form-control py-4"
										id="input-start-overtime" name="start-overtime" />
								</div>
								<div class="input-group gap-2 align-items-center">
									<label for="end-overtime"
										class="form-label text-gray-800 fw-medium">End
										Overtime: </label> <input type="text" class="form-control py-4"
										id="input-end-overtime" name="end-overtime" />
								</div>
							</div>

							<div class="mb-7">
								<label for="overtime-description"
									class="form-label text-gray-800 fw-medium">Overtime
									Description</label>
								<textarea class="form-control py-4"
									id="input-overtime-description" name="overtime-description"></textarea>
							</div>
						</div>
						<!-- Overtime  -->
					</div>
					<div class="card-footer d-flex justify-content-end gap-3">
						<a href="timeSheet" class="btn btn-bg-secondary px-8 fw-medium">Cancel</a>
						<button class="btn btn-bg-success px-8 fw-medium text-white"
							type="submit">Save</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		$(function() {
			$('#userSelect').select2({
				width : '100%'

			});

			flatpickr("#input-date", {
				dateFormat : "d-m-Y",
				altInput : true,
				altFormat : "j M Y",
				allowInput : true,
				disableMobile : true,
			});

			flatpickr(
					"#input-start-time,#input-end-time,#input-start-overtime, #input-end-overtime",
					{
						enableTime : true,
						noCalendar : true,
						dateFormat : "H:i",
						time_24hr : true,
						allowInput : true,
						defaultDate : "00:00"
					});

			const checkbox = $("#input-check-overtime");
			const container = $("#overtime-container");

			container.hide();
			$("#input-start-overtime").prop("disabled", true);
			$("#input-end-overtime").prop("disabled", true);

			checkbox.on("change", function() {
				if (this.checked) {
					container.slideDown(300);
					$("#input-start-overtime").prop("disabled", false);
					$("#input-end-overtime").prop("disabled", false);

				} else {
					container.slideUp(300);
					$("#input-start-overtime").prop("disabled", true);
					$("#input-end-overtime").prop("disabled", true);
				}
			});

			$('#input-function').on('change', function() {

				let inputValue = $(this).val();
				let functionId = null;
				let functionName = null;

				$('#functionList option').each(function() {
					if ($(this).val() === inputValue) {
						functionId = $(this).data('id');
						functionName = $(this).data('name');
					}
				});
				if (!functionId) {
					functionId = "newFunction"
					functionName = $(this).val();
				}

				$('#functionIdHidden').val(functionId);
				$('#functionIdHiddenName').val(functionName);

			});

			// get function
			$('#input-project')
					.on(
							'change',
							function() {

								let inputValue = $(this).val();
								let projectId = null;
								let projectName = null;

								$('#projectList option').each(function() {
									if ($(this).val() === inputValue) {
										projectId = $(this).data('id');
										projectName = $(this).data('name')
									}
								});
								if (!projectId) {
									projectId = "newProject";
									projectName = $(this).val();
								}
								$('#projectIdHidden').val(projectId);
								$('#projectIdHiddenName').val(projectName);

								$
										.ajax({
											type : "GET",
											url : "getFunctionOfProject",
											data : {
												projectId : projectId
											},
											dataType : "json",
											success : function(res) {
												console.log(res)
												let dataList = $('#functionList');
												dataList.empty();
												if (res && res.length > 0) {
													$
															.each(
																	res,
																	function(
																			index,
																			item) {
																		dataList
																				.append('<option value="' + item.function_name + '" data-id="' + item.function_id + '" data-name"'+item.function_name+ '"/>');
																	});

												}

											},
											error : function(err) {
												console.log(err);
												alert("โหลดข้อมูล function ไม่สำเร็จ");
											}
										});
							})

		})
	</script>
</body>
</html>