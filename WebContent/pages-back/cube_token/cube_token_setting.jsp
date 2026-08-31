<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.css"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/assets/css/style.bundle.css"
	rel="stylesheet" />
<style>
.border.border-gray-300 {
	border: 1px solid var(--bs-gray-300) !important;
}

.setting-input {
	max-width: 100px !important;
	background-color: var(--bs-light-light) !important;
}

.date-select-wrapper {
	width: 100px;
	min-width: 0;
}

.date-select-wrapper .select2-container {
	width: 100% !important;
}

input[type="checkbox"]:hover {
    cursor: pointer;
}
</style>
</head>
<body>
	<div class="d-flex flex-column flex-column-fluid">
		<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
			<div id="kt_app_toolbar_container"
				class="app-container container-fluid d-flex flex-stack">
				<div
					class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
					<h1
						class="page-heading d-flex text-gray-700 fw-semibold flex-column justify-content-center my-0">
						Cube Token Setting</h1>
					<ul
						class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
						<li class="breadcrumb-item text-muted"><a
							href="${pageContext.request.contextPath}/check_in_out"
							class="text-muted text-hover-primary">Home</a></li>
						<li class="breadcrumb-item"><span
							class="bullet bg-gray-500 w-5px h-2px"></span></li>
						<li class="breadcrumb-item text-muted"><a
							href="${pageContext.request.contextPath}/tokenSettings"
							class="text-muted text-hover-primary">Cube Token Setting</a></li>
					</ul>
				</div>
			</div>
		</div>

		<div id="kt_app_content" class="app-content flex-column-fluid ">
			<div id="kt_app_content_container"
				class="app-container container-fluid">
				<div class="card card-flush">
					<div class="card-header mt-2">
						<div class="card-title mt-6 d-flex flex-column gap-1">
							<h3 class="fw-medium text-info">Get Token Apply</h3>
							<span class="fs-5 text-gray-700">เงื่อนไขการให้ <span
								class="text-danger">คิวบ์แต้มบุญ</span></span>
						</div>
					</div>

					<div class="card-body ">
						<div class="row g-6">

							<!-- Employee Status -->
							<div class="col-md-6">
								<div class="border rounded px-8 py-7 h-100">
									<span class="text-gray-900 fw-semibold fs-3"> Employee
										Status </span>

									<div class="d-flex flex-wrap gap-10 mt-6">

										<label class="form-check form-check-custom form-check-solid">
											<input class="form-check-input" type="checkbox"
											onchange="updateTokenSetting(
													        'filter',
													        ${tokenSettingPageData.filter.employee_status.active.id},
													        'active',
													        this.checked ? 'Active' : 'Disable'
													    )"
											<c:if test="${tokenSettingPageData.filter.employee_status.active.active}">
								                checked
								            </c:if>>
											<span class="form-check-label ms-2 fs-6 text-gray-800">
												Active </span>
										</label> <label class="form-check form-check-custom form-check-solid">
											<input class="form-check-input" type="checkbox"
											onchange="updateTokenSetting(
													        'filter',
													        ${tokenSettingPageData.filter.employee_status.probation.id},
													        'active',
													        this.checked ? 'Active' : 'Disable'
													    )"
											<c:if test="${tokenSettingPageData.filter.employee_status.probation.active}">
								                checked
								            </c:if>>
											<span class="form-check-label ms-2 fs-6 text-gray-800">
												Probation </span>
										</label> <label class="form-check form-check-custom form-check-solid">
											<input class="form-check-input" type="checkbox"
											onchange="updateTokenSetting(
													        'filter',
													        ${tokenSettingPageData.filter.employee_status.excluded.id},
													        'active',
													        this.checked ? 'Active' : 'Disable'
													    )"
											<c:if test="${tokenSettingPageData.filter.employee_status.excluded.active}">
								                checked
								            </c:if>>
											<span class="form-check-label ms-2 fs-6 text-gray-800">
												Excluded </span>
										</label> <label class="form-check form-check-custom form-check-solid">
											<input class="form-check-input" type="checkbox"
											onchange="updateTokenSetting(
													        'filter',
													        ${tokenSettingPageData.filter.employee_status.intern.id},
													        'active',
													        this.checked ? 'Active' : 'Disable'
													    )"
											<c:if test="${tokenSettingPageData.filter.employee_status.intern.active}">
								                checked
								            </c:if>>
											<span class="form-check-label ms-2 fs-6 text-gray-800">
												Intern </span>
										</label>

									</div>
								</div>
							</div>

							<!-- System Status -->
							<div class="col-md-6">
								<div class="border rounded px-8 py-7 h-100">

									<span class="text-gray-900 fw-semibold fs-3"> System
										Status </span>

									<div class="d-flex flex-wrap align-items-center gap-8 mt-6">

										<label
											class="form-check form-check-custom form-check-solid mb-0">
											<input class="form-check-input" type="checkbox"
											onchange="updateTokenSetting(
													        'filter',
													        ${tokenSettingPageData.filter.system_status.enable.id},
													        'active',
													        this.checked ? 'Active' : 'Disable'
													    )"
											<c:if test="${tokenSettingPageData.filter.system_status.enable.active}">
								                checked
								            </c:if>>
											<span class="form-check-label ms-2 fs-6 text-gray-800">
												Enable </span>
										</label> <label
											class="form-check form-check-custom form-check-solid mb-0">
											<input class="form-check-input" type="checkbox"
											onchange="updateTokenSetting(
													        'filter',
													        ${tokenSettingPageData.filter.system_status.disable.id},
													        'active',
													        this.checked ? 'Active' : 'Disable'
													    )"
											<c:if test="${tokenSettingPageData.filter.system_status.disable.active}">
								                checked
								            </c:if>>
											<span class="form-check-label ms-2 fs-6 text-gray-800">
												Disable </span>
										</label>

									</div>

								</div>
							</div>

						</div>
					</div>
				</div>

				<div class="card card-flush mt-10">
					<div class="card-header mt-2">
						<div class="card-title mt-6 d-flex flex-column gap-1">
							<h3 class="fw-medium text-success">Get Token</h3>
							<span class="fs-5 text-gray-700">ตั้งค่าวันที่และจำนวน <span
								class="text-danger">คิวบ์แต้มบุญ </span>ที่ต้องการให้รายเดือน
							</span>
						</div>

						<div class="card-toolbar">
							<div
								class="form-check form-switch form-check-custom form-check-solid">
								<input
									class="form-check-input h-20px w-30px h-md-25px w-md-40px"
									type="checkbox"
									onchange="updateTokenSetting(
											        'action',
											        1,
											        'active',
											        this.checked ? 'Y' : 'N'
											    )"
									<c:if test="${tokenSettingPageData.giftSetting.active}">checked</c:if> />
							</div>
						</div>
					</div>

					<div class="card-body ">
						<div class="row g-6">
							<div class="col-12 col-sm-6 col-lg-6 col-xl-3 ">

								<div
									class="bg-light
							                    rounded p-8
							                    border border-gray-300
							                    h-100
							                    d-flex flex-column">

									<!-- Header -->
									<div class="d-flex justify-content-between align-items-center"
										style="min-height: 30px;">

										<div class="d-flex flex-column gap-1">
											<span class="text-body fw-semibold small"> Select a
												give day (1-31)</span> <span class="text-gray-700">กำหนดวันแจกรายเดือน</span>
										</div>

									</div>
									<!-- Content -->
									<div
										class="d-flex justify-content-between
							                        align-items-center
							                        mt-auto pt-8 gap-5">

										<!-- Icon -->
										<div class="d-flex flex-shrink-0 align-items-center">

											<i class="ki-duotone ki-calendar-8 fs-7x fs-md-4x"> <span
												class="path1"></span> <span class="path2"></span> <span
												class="path3"></span> <span class="path4"></span> <span
												class="path5"></span> <span class="path6"></span>
											</i>

										</div>


										<!-- Date -->
										<div class="date-select-wrapper">
											<select
												class="form-select setting-input form-select-solid form-select-lg"
												data-control="select2" data-width="100%"
												onchange="updateTokenSetting('activate_date', null, null, this.value)"
												>

												<c:forEach var="day" begin="1" end="31">
													<option value="${day}"
														<c:if test="${day == tokenSettingPageData.activate_date}">
										                    selected
										                </c:if>>
														${day}</option>
												</c:forEach>

											</select>
										</div>


									</div>

								</div>

							</div>

							<c:forEach var="setting"
								items="${tokenSettingPageData.giftSetting.data}">
								<div class="col-12 col-sm-6 col-lg-6 col-xl-3">

									<div
										class="bg-light-${setting.style}
							                    rounded p-8
							                    border border-${setting.style}-subtle
							                    h-100
							                    d-flex flex-column">

										<!-- Header -->
										<div class="d-flex justify-content-between align-items-center"
											style="min-height: 30px;">

											<div class="d-flex flex-column gap-1">
												<span class="text-body fw-semibold small">
													${setting.name_en}</span> <span class="text-gray-700">${setting.name_th }</span>
											</div>

											<div
												class="form-check form-check-custom
							                            form-check-success form-check-solid">

												<input class="form-check-input" type="checkbox"
													value="${setting.id}"
													onchange="updateTokenSetting(
														        'gift',
														        ${setting.id},
														        'active',
														        this.checked ? 'Y' : 'N'
														    )"
													<c:if test="${setting.active}">checked</c:if> />

											</div>

										</div>
										<!-- Content -->
										<div
											class="d-flex justify-content-between
							                        align-items-center
							                        mt-auto pt-8 gap-5">

											<!-- Icon -->
											<div class="d-flex align-items-center">

												<i
													class="ki-duotone ${setting.icon}
						                              fs-7x fs-md-4x text-${setting.style}">
													<span class="path1"></span> <span class="path2"></span> <span
													class="path3"></span> <span class="path4"></span> <span
													class="path5"></span> <span class="path6"></span>
												</i>

											</div>


											<!-- Point -->
											<input type="number"
												class="form-control form-control-solid form-control-lg setting-input"
												placeholder="0" value="${setting.point}"
												onblur="updateTokenSetting(
												        'gift',
												        ${setting.id},
												        'point',
												        this.value
												    )" />

										</div>

									</div>

								</div>

							</c:forEach>

						</div>
					</div>


				</div>

				<div class="card card-flush mt-10">
					<div class="card-header mt-2">
						<div class="card-title mt-6 d-flex flex-column gap-1">
							<h3 class="fw-medium text-danger">Deduction Rate</h3>
							<span class="fs-5 text-gray-700">ตั้งค่าจำนวนการหัก <span
								class="text-danger">คิวบ์แต้มบุญ</span> ตามประเภทของกิจกรรม
							</span>
						</div>

						<div class="card-toolbar">
							<div
								class="form-check form-switch form-check-custom form-check-solid">
								<input
									class="form-check-input h-20px w-30px h-md-25px w-md-40px"
									type="checkbox"
									onchange="updateTokenSetting(
											        'action',
											        2,
											        'active',
											        this.checked ? 'Y' : 'N'
											    )"
									<c:if test="${tokenSettingPageData.deductSetting.active}">checked</c:if> />
							</div>
						</div>
					</div>

					<div class="card-body ">
						<div class="row g-6">
							<c:forEach var="setting"
								items="${tokenSettingPageData.deductSetting.data}">
								<!-- <div class="col-12 col-sm-6 col-lg-6 col-xl-3"> -->
								<div class="col-12 col-sm-6 col-lg-4 col-xl">

									<div
										class="bg-light-${setting.style}
							                    rounded p-8
							                    border border-${setting.style}-subtle
							                    h-100
							                    d-flex flex-column">

										<!-- Header -->
										<div class="d-flex justify-content-between align-items-center"
											style="min-height: 30px;">

											<div class="d-flex flex-column gap-1">
												<span class="text-body fw-semibold small">
													${setting.name_en}</span> <span class="text-gray-700">${setting.name_th }</span>
											</div>

											<div
												class="form-check form-check-custom
							                            form-check-success form-check-solid">

												<input class="form-check-input" type="checkbox"
													value="${setting.id}"
													onchange="updateTokenSetting(
														        'deduct',
														        ${setting.id},
														        'active',
														        this.checked ? 'Y' : 'N'
														    )"
													<c:if test="${setting.active}">checked</c:if> />

											</div>

										</div>
										<!-- Content -->
										<div
											class="d-flex justify-content-between
							                        align-items-center
							                        mt-auto pt-8 gap-5">

											<!-- Icon -->
											<div class="d-flex align-items-center">

												<i
													class="ki-duotone ${setting.icon}
						                              fs-7x fs-md-4x text-${setting.style}">
													<span class="path1"></span> <span class="path2"></span> <span
													class="path3"></span> <span class="path4"></span> <span
													class="path5"></span> <span class="path6"></span>
												</i>

											</div>


											<!-- Point -->
											<input type="number"
												class="form-control form-control-solid form-control-lg setting-input"
												placeholder="0" value="${setting.point}"
												onblur="updateTokenSetting(
													        'deduct',
													        ${setting.id},
													        'point',
													        this.value
													    )"
												data-id="${setting.id}" />

										</div>

									</div>

								</div>

							</c:forEach>
						</div>
					</div>
				</div>


			</div>
		</div>
	</div>

	<script>
		toastr.options = {
				  "closeButton": false,
				  "debug": false,
				  "newestOnTop": true,
				  "progressBar": true,
				  "positionClass": "toastr-top-right",
				  "preventDuplicates": false,
				  "onclick": null,
				  "showDuration": "300",
				  "hideDuration": "1000",
				  "timeOut": "5000",
				  "extendedTimeOut": "1000",
				  "showEasing": "swing",
				  "hideEasing": "linear",
				  "showMethod": "fadeIn",
				  "hideMethod": "fadeOut"
				};

		function updateTokenSetting(target, id, field, value) {

			$.ajax({
				url : "updateTokenSetting",
				type : "POST",
				dataType : "json",

				data : {
					target : target,
					id : id,
					field : field,
					value : value
				},

				success : function(res) {

					 if (res.success) {
			                toastr.success(
			                    res.message || "Setting updated successfully."
			                );
			            } else {
			                toastr.error(
			                    res.message || "Failed to update setting."
			                );
			            }
				},

				error: function(xhr) {

		            let message = "An error occurred while updating the setting.";

		            if (xhr.responseJSON && xhr.responseJSON.message) {
		                message = xhr.responseJSON.message;
		            }

		            toastr.error(message);
		        }
			});
		}
	</script>
</body>
</html>