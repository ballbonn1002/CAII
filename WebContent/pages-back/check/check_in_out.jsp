<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<style>
.btn-check:checked+label span {
	color: #fff !important;
}

.form-check.form-check-info .form-check-input:checked {
	background-color: var(--bs-info);
}

.min-w-170px {
	min-width: 170px !important;
}

#imgPreview,
#displayMode img {
    max-height: 80px;
    width: auto;
    object-fit: contain;
}
</style>

<!--begin::Main-->
<fmt:setLocale value="en_US" />
<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
	<!--begin::Content wrapper-->
	<div class="d-flex flex-column flex-column-fluid">
		<!--begin::Toolbar-->
		<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
			<div id="kt_app_toolbar_container"
				class="app-container container-fluid d-flex flex-stack">
				<!--begin::Page title-->
				<div
					class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
					<h1
						class="page-heading d-flex text-gray-700 fw-semibold flex-column justify-content-center my-0">Check
						In / Check Out</h1>
					<ul
						class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
						<li class="breadcrumb-item text-muted">Home</li>
						<li class="breadcrumb-item"><span
							class="bullet bg-gray-500 w-5px h-2px"></span></li>
						<li class="breadcrumb-item text-muted">Check In / Check Out</li>
					</ul>
				</div>
				<!--end::Page title-->

				<!--begin::Retroactively-->
				<div class="d-flex flex-column">
					<a href="retroactive"
						class="btn btn-sm btn-flex btn-secondary min-h-45px min-w-45px min-w-md-170px px-0 px-md-10 py-4 justify-content-center align-items-center">

						<i class="ki-duotone ki-calendar-edit text-muted fs-1 p-0 m-0">
							<span class="path1"></span> <span class="path2"></span> <span
							class="path3"></span>
					</i> <span
						class="fw-medium fs-6 text-inverse-secondary d-none d-md-inline ms-md-2">ลงเวลาย้อนหลัง
							คลิก</span>
					</a>
				</div>
				<!--end::Retroactively-->

			</div>
		</div>
		<!--end::Toolbar-->
		<!--begin::Content-->
		<div id="kt_app_content" class="app-content flex-column-fluid">
			<div id="kt_app_content_container"
				class="app-container container-xxl">
				<!--begin::Row-->
				<div class="row gx-5 gx-xl-10 mb-xl-10">
					<!--begin::Col-->
					<div class="col-xl-8 col-lg-8 col-md-8 col-sm-12 col-12 mb-10">
						<div class="card card-flush h-auto mb-5 mb-xl-10">
							<!--begin::Header-->
							<div
								class="card-header pt-5 d-flex justify-content-between align-items-center">
								<div class="card-title col-lg-12 col-md-12 col-sm-12 col-12">
									<div class="d-flex flex-column w-100">

										<div class="d-flex align-items-center mb-1">

											<span
												class="fw-medium text-gray-900 me-4 d-flex align-items-center">
												Work Hours </span> <span
												class="text-primary pe-2 fw-bold fs-5 d-flex align-items-center">
												${user.workTimeStart} - ${user.workTimeEnd} </span>

											<div class="ms-auto d-flex gap-2 align-items-center">
												<c:choose>
													<c:when test="${not empty jobsiteList}">
														<c:forEach var="site" items="${jobsiteList}">
															<span
																class="text-white fw-semibold fs-7 bg-primary px-2 py-1 rounded">
																<c:out value="${site['name_site']}" />
															</span>
														</c:forEach>
													</c:when>
													<c:otherwise>
														<span
															class="text-white fw-semibold fs-7 bg-primary px-2 py-1 rounded">
															None </span>
													</c:otherwise>
												</c:choose>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!--end::Header-->
							<!--begin::Card body-->
							<div class="card-body d-flex flex-column">
								<div class="px-13">
									<!-- Real-Time Clock -->
									<div class="d-flex flex-center align-items-baseline mb-5">
										<span id="clock"
											class=" fw-semibold text-gray-900 text-center"
											style="font-size: 52px;"></span> <span id="clock-second"
											class="fs-2x fw-semibold text-gray-500"></span>
									</div>
									<!-- Date -->
									<div id="date"
										class="fs-2x fw-normal text-gray-900 text-center mb-5"></div>

									<!-- Check Type -->
									<div class="row py-7 mb-5 gx-10">
										<div class="col-6">
											<input type="radio" class="btn-check" name="checkType"
												id="checkType1" value="1"> <label for="checkType1"
												class="btn bg-light h-150px btn-active-success d-flex flex-column justify-content-center align-items-center py-7">
												<i class="ki-duotone ki-time fs-2hx mb-5"> <span
													class="path1"></span> <span class="path2"></span>
											</i> <span class="fs-2 fw-medium text-muted">Check-In</span>
											</label>
										</div>
										<div class="col-6">
											<input type="radio" class="btn-check" name="checkType"
												id="checkType2" value="2"> <label for="checkType2"
												class="btn bg-light h-150px btn-active-info d-flex flex-column justify-content-center align-items-center py-7">
												<i class="ki-duotone ki-time fs-2hx mb-5"> <span
													class="path1"></span> <span class="path2"></span>
											</i> <span class="fs-2 fw-medium text-muted">Check-Out</span>
											</label>
										</div>
									</div>
									<div class="d-flex mb-7">
										<label class="fw-bold text-gray-800 required"> Your
											Work Location</label>
									</div>
									<div class="row align-items-center mb-5">
										<div class="col-md-4 col-sm-12 col-12 py-2 mb-3">
											<div
												class="form-check form-check-custom form-check-primary form-check-solid form-check-md">
												<input name="workType" class="form-check-input me-2"
													id="workType1" type="radio" value="1"
													<c:if test="${user.workType == 1}">checked</c:if>>
												<i class="ki-duotone ki-delivery-door fs-1 ms-1 text-primary"> <span
													class="path1"></span> <span class="path2"></span> <span
													class="path3"></span><span class="path4"></span>
												</i> <label for="workType1"
													class="form-check-label fs-6 fw-normal text-gray-800">On-Site</label>
											</div>
										</div>
										<div class="col-md-4 col-sm-12 col-12 py-2 mb-3">
											<div
												class="form-check form-check-custom form-check-primary form-check-solid form-check-md">
												<input name="workType" class="form-check-input pe-2 me-2"
													id="workType2" type="radio" value="2"
													<c:if test="${user.workType == 2}">checked</c:if>>
												<i class="ki-duotone ki-home fs-1 ms-1 text-success">
												</i> <label for="workType2"
													class="form-check-label fs-6 fw-normal text-gray-800">WFH</label>
											</div>
										</div>
										
										<div class="col-md-4 col-sm-12 col-12 py-2">
											<div
												class="form-check form-check-custom form-check-primary form-check-solid form-check-md">
												<input name="workType" class="form-check-input pe-2 me-2"
													id="workType3" type="radio" value="3"
													<c:if test="${user.workType == 3}">checked</c:if>>
												<i class="ki-duotone ki-cube-2 fs-1 ms-1 text-danger">
													<span class="path1"></span> <span class="path2"></span><span class="path3"></span>
												</i> <label for="workType3"
													class="form-check-label fs-6 fw-normal text-gray-800">Head Office</label>
											</div>
										</div>
									</div>
									<div class="d-flex">
										<button id="submitBtn"
											class="btn btn-lg btn-primary w-100 text-center fw-medium">Accept</button>
									</div>
								</div>
							</div>
							<!--end::Card body-->
						</div>
						
						<div class="card card-flush h-auto mb-5 mb-xl-10">
						    <div class="card-header pt-5 mb-2">
						        <div class="card-title d-flex flex-column">
						            <span class="fs-2 fw-medium text-gray-900 me-2 lh-1 mb-2">Last Update</span> 
						            <span class="text-muted fw-medium pt-1 fs-7">Check In / Check Out</span>
						        </div>
						        <div class="d-flex flex-column">
						            <a class="btn btn-sm btn-icon btn-secondary w-40px h-40px d-flex" href="Calendar_Checklist"> 
						                <i class="ki-duotone ki-calendar-tick fs-1 text-muted">
						                    <span class="path1"></span><span class="path2"></span><span class="path3"></span>
						                    <span class="path4"></span><span class="path5"></span><span class="path6"></span>
						                </i>
						            </a>
						        </div>
						    </div>
						    <div class="card-body pt-2 pb-4 flex-wrap">
						        <div class="tab-content mb-2 px-0">
						            <div class="tab-pane fade show active">
						            <div class="d-flex flex-column flex-md-row ">
						             <span class="fs-4 fw-medium text-gray-900 min-w-80px mb-4 mb-md-0">Today</span>
						             <%-- <c:set var="leaveTodayBlock">
										<c:forEach var="leave" items="${leaveToday}">
										
										    <c:set var="leaveTitle" value="${leave.leave_type_name}" />
										
										    <c:choose>
										        <c:when test="${fn:contains(leaveTitle,'ลาป่วย')}">
										            <div class="badge badge-info fw-semibold w-170px text-wrap">
										                ${leaveTitle}
										
										                <c:choose>
														    <c:when test="${leave.half_day eq '0'}">: เต็มวัน</c:when>
														    <c:when test="${leave.half_day eq '1'}">: ช่วงเช้า</c:when>
														    <c:when test="${leave.half_day eq '2'}">: ช่วงบ่าย</c:when>
														    <c:otherwise>: เลือกช่วงเวลา</c:otherwise>
														</c:choose>
										
										                <br>
										                ${leave.description}
										            </div>
										        </c:when>
										
										        <c:otherwise>
										            <div class="badge badge-primary fw-semibold w-170px text-wrap">
										                ${leaveTitle}
										
										                <c:choose>
										                   	<c:when test="${leave.half_day eq '0'}">: เต็มวัน</c:when>
														    <c:when test="${leave.half_day eq '1'}">: ช่วงเช้า</c:when>
														    <c:when test="${leave.half_day eq '2'}">: ช่วงบ่าย</c:when>
														    <c:otherwise>: เลือกช่วงเวลา</c:otherwise>
														</c:choose>
										
										                <br>
										                ${leave.description}
										            </div>
										        </c:otherwise>
										
										    </c:choose>
										
										</c:forEach>
										</c:set>
										<c:if test="${not empty leaveToday}">
						                    <div class="d-flex align-items-center mb-4 mb-md-0 min-w-250px">
						                        <span class="bullet bullet-vertical bg-success min-h-25px me-4 rounded-0"></span>
						                        <div class="d-flex align-items-center flex-wrap text-gray-900">
						                            <span class="fs-6 fw-bold text-success min-w-30px me-4">IN</span>
						                            <c:forEach var="leave" items="${leaveToday}">
													    <c:if test="${leave.half_day  eq '1'}">
													        <div class="badge badge-primary fw-semibold w-170px text-wrap">
													            ${leave.leave_type_name} : ช่วงเช้า
													            <br>
													            ${leave.description}
													        </div>
													    </c:if>
													</c:forEach>
						                            <div class="d-flex align-items-center min-w-170px">
						                                <c:if test="${not empty todaycheckin[0].work_hours_time_work}">
						                                    <span class="fs-2 me-4 fw-medium"><fmt:formatDate value="${todaycheckin[0].work_hours_time_work}" pattern="HH:mm"/></span>
						                                    <span class="fs-6 me-4 fw-medium"><fmt:formatDate value="${todaycheckin[0].work_hours_time_work}" pattern="dd MMM yyyy"/></span>
						                                </c:if>
						                            </div>
						                            <div class="min-w-40px d-flex justify-content-center">
						                                <c:choose>
						                                    <c:when test="${todaycheckin[0].work_type.toString() eq '1'}"><i class="ki-duotone ki-delivery-door fs-1 text-primary"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i></c:when>
						                                    <c:when test="${todaycheckin[0].work_type.toString() eq '2'}"><i class="ki-duotone ki-home fs-1 text-success"></i></c:when>
						                                    <c:when test="${todaycheckin[0].work_type.toString() eq '3'}"><i class="ki-duotone ki-cube-2 fs-1 text-danger"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i></c:when>
						                                </c:choose>
						                            </div>
						                        </div>
						                    </div>
						
						                    <div class="d-flex align-items-center ms-md-3">
						                        <span class="bullet bullet-vertical bg-info min-h-25px me-4 rounded-0"></span>
						                        <div class="d-flex align-items-center flex-wrap text-gray-900">
						                            <span class="fs-6 fw-bold text-info min-w-30px me-4">OUT</span>
						                            <c:forEach var="leave" items="${leaveToday}">
													    <c:if test="${leave.half_day  eq '2'}">
													        <div class="badge badge-primary fw-semibold w-170px text-wrap">
													            ${leave.leave_type_name} : ช่วงบ่าย
													            <br>
													            ${leave.description}
													        </div>
													    </c:if>
													</c:forEach>
						                            <div class="d-flex align-items-center min-w-170px">
						                                <c:if test="${not empty todaycheckout[0].work_hours_time_work}">
						                                    <span class="fs-2 me-4 fw-medium"><fmt:formatDate value="${todaycheckout[0].work_hours_time_work}" pattern="HH:mm"/></span>
						                                    <span class="fs-6 me-4 fw-medium"><fmt:formatDate value="${todaycheckout[0].work_hours_time_work}" pattern="dd MMM yyyy"/></span>
						                                </c:if>
						                            </div>
						                            <div class="min-w-40px d-flex justify-content-center">
						                                <c:choose>
						                                    <c:when test="${todaycheckout[0].work_type.toString() eq '1'}"><i class="ki-duotone ki-delivery-door fs-1 text-primary"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i></c:when>
						                                    <c:when test="${todaycheckout[0].work_type.toString() eq '2'}"><i class="ki-duotone ki-home fs-1 text-success"></i></c:when>
						                                    <c:when test="${todaycheckout[0].work_type.toString() eq '3'}"><i class="ki-duotone ki-cube-2 fs-1 text-danger"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i></c:when>
						                                </c:choose>
						                            </div>
						                        </div>
						                    </div>
						                    </c:if> --%>
						                   
						                    <!-- ตรวจประเภทการลา Today -->
						                    <c:set var="hasFullLeave" value="false"/>
											<c:set var="isMorningLeave" value="false"/>
											<c:set var="isAfternoonLeave" value="false"/>
											
											<c:forEach var="leave" items="${leaveToday}">
											    <c:if test="${fn:trim(leave.half_day) eq '0'}">
											        <c:set var="hasFullLeave" value="true"/>
											    </c:if>
											
											    <c:if test="${fn:trim(leave.half_day) eq '1'}">
											        <c:set var="isMorningLeave" value="true"/>
											    </c:if>
											
											    <c:if test="${fn:trim(leave.half_day) eq '2'}">
											        <c:set var="isAfternoonLeave" value="true"/>
											    </c:if>
											</c:forEach>
											
											<c:if test="${empty leaveToday}">
										
											<!-- IN -->
											<div class="d-flex align-items-center mb-4 mb-md-0 min-w-250px">
						                        <span class="bullet bullet-vertical bg-success min-h-25px me-4 rounded-0"></span>
						                        <div class="d-flex align-items-center text-gray-900">
						                            <span class="fs-6 fw-bold text-success min-w-30px me-4">IN</span> 
											        
						                            <div class="d-flex align-items-center min-w-170px">
						                                <c:if test="${not empty todaycheckin[0].work_hours_time_work}">
						                                    <span class="fs-2 me-4 fw-medium"><fmt:formatDate value="${todaycheckin[0].work_hours_time_work}" pattern="HH:mm"/></span>
						                                    <span class="fs-6 me-4 fw-medium"><fmt:formatDate value="${todaycheckin[0].work_hours_time_work}" pattern="dd MMM yyyy"/></span>
						                                </c:if>
						                            </div>
						                            <div class="min-w-40px d-flex justify-content-center">
						                                <c:choose>
						                                    <c:when test="${todaycheckin[0].work_type.toString() eq '1'}"><i class="ki-duotone ki-delivery-door fs-1 text-primary"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i></c:when>
						                                    <c:when test="${todaycheckin[0].work_type.toString() eq '2'}"><i class="ki-duotone ki-home fs-1 text-success"></i></c:when>
						                                    <c:when test="${todaycheckin[0].work_type.toString() eq '3'}"><i class="ki-duotone ki-cube-2 fs-1 text-danger"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i></c:when>
						                                </c:choose>
						                            </div>
						                            
						                        </div>
						                    </div>
											
											<!-- OUT -->
											<div class="d-flex align-items-center ms-md-3">
						                        <span class="bullet bullet-vertical bg-info min-h-25px me-4 rounded-0"></span>
						                        <div class="d-flex align-items-center text-gray-900">
						                            <span class="fs-6 fw-bold text-info min-w-30px me-4">OUT</span>
											 
											            <div class="d-flex align-items-center min-w-170px"> 
													          <!-- ไม่ลาช่วงบ่าย --> 
												                <c:if test="${not empty todaycheckout[0].work_hours_time_work}">
												                    <span class="fs-2 me-4 fw-medium">
												                        <fmt:formatDate value="${todaycheckout[0].work_hours_time_work}" pattern="HH:mm"/>
												                    </span>
												
												                    <span class="fs-6 me-4 fw-medium">
												                        <fmt:formatDate value="${todaycheckout[0].work_hours_time_work}" pattern="dd MMM yyyy"/>
												                    </span>
												                </c:if>
											            </div>
															 
													            <div class="min-w-40px d-flex justify-content-center">
																	<c:choose>
									                                    <c:when test="${todaycheckout[0].work_type.toString() eq '1'}"><i class="ki-duotone ki-delivery-door fs-1 text-primary"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i></c:when>
									                                    <c:when test="${todaycheckout[0].work_type.toString() eq '2'}"><i class="ki-duotone ki-home fs-1 text-success"></i></c:when>
									                                    <c:when test="${todaycheckout[0].work_type.toString() eq '3'}"><i class="ki-duotone ki-cube-2 fs-1 text-danger"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i></c:when>
									                                </c:choose>
													            </div>
											    </div>
											
											</div>
											
											
											</c:if>
											
											<c:if test="${not empty leaveToday}">
											<c:if test="${hasFullLeave}">
											    <c:forEach var="leave" items="${leaveToday}">
											        <c:if test="${fn:trim(leave.half_day) eq '0'}">
													    <c:set var="leaveTitle" value="${leave.leave_type_name}" />
													    <c:choose>
													        <c:when test="${fn:contains(leaveTitle,'ลาป่วย')}">
													         <div class="d-flex align-items-center">
													            <div class="badge badge-info fw-semibold w-md-170px text-wrap fs-7">
													                ${leave.leave_type_name} : เต็มวัน  
													                <c:if test="${leave.leave_status_id.toString() eq '0'}">
														                <i class="ki-duotone ki-watch ms-2 text-warning">
														                	<span class="path1"></span><span class="path2"></span>
														                </i>
													                </c:if>
													            </div>
													             </div>
													        </c:when>
													
													        <c:otherwise>
													         <div class="d-flex align-items-center">
													            <div class="badge badge-primary fw-semibold w-md-170px text-wrap fs-7">
													                ${leave.leave_type_name} : เต็มวัน
													                <c:if test="${leave.leave_status_id.toString() eq '0'}">
														                <i class="ki-duotone ki-watch  ms-2 text-warning">
														                	<span class="path1"></span><span class="path2"></span>
														                </i>
													                </c:if>
													            </div>
													             </div>
													        </c:otherwise>
													
													    </c:choose>
											
											        </c:if>
											    </c:forEach>
											</c:if>
											<!-- ลาไม่เต็มวัน -->
											<c:if test="${not hasFullLeave and not empty leaveToday}">
											
											<!-- IN -->
											<div class="d-flex align-items-center mb-4 mb-md-0 min-w-250px">
						                        <span class="bullet bullet-vertical bg-success min-h-25px me-4 rounded-0"></span>
						                        <div class="d-flex align-items-center text-gray-900">
						                            <span class="fs-6 fw-bold text-success min-w-30px me-4">IN</span> 
											        
						                            <div class="d-flex align-items-center min-w-170px">
						                                <c:if test="${not empty todaycheckin[0].work_hours_time_work}">
						                                    <span class="fs-2 me-4 fw-medium"><fmt:formatDate value="${todaycheckin[0].work_hours_time_work}" pattern="HH:mm"/></span>
						                                    <span class="fs-6 me-4 fw-medium"><fmt:formatDate value="${todaycheckin[0].work_hours_time_work}" pattern="dd MMM yyyy"/></span>
						                                </c:if>
						                            </div>
						                            <div class="min-w-40px d-flex justify-content-center">
						                                <c:choose>
						                                    <c:when test="${todaycheckin[0].work_type.toString() eq '1'}"><i class="ki-duotone ki-delivery-door fs-1 text-primary"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i></c:when>
						                                    <c:when test="${todaycheckin[0].work_type.toString() eq '2'}"><i class="ki-duotone ki-home fs-1 text-success"></i></c:when>
						                                    <c:when test="${todaycheckin[0].work_type.toString() eq '3'}"><i class="ki-duotone ki-cube-2 fs-1 text-danger"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i></c:when>
						                                </c:choose>
						                            </div>
						                            
						                        </div>
						                    </div>
											
											<!-- OUT -->
											<div class="d-flex align-items-center ms-md-3">
						                        <span class="bullet bullet-vertical bg-info min-h-25px me-4 rounded-0"></span>
						                        <div class="d-flex align-items-center text-gray-900">
						                            <span class="fs-6 fw-bold text-info min-w-30px me-4">OUT</span>
											 
											            <div class="d-flex align-items-center min-w-170px"> 
													          <!-- ไม่ลาช่วงบ่าย --> 
												                <c:if test="${not empty todaycheckout[0].work_hours_time_work}">
												                    <span class="fs-2 me-4 fw-medium">
												                        <fmt:formatDate value="${todaycheckout[0].work_hours_time_work}" pattern="HH:mm"/>
												                    </span>
												
												                    <span class="fs-6 me-4 fw-medium">
												                        <fmt:formatDate value="${todaycheckout[0].work_hours_time_work}" pattern="dd MMM yyyy"/>
												                    </span>
												                </c:if>
											            </div>
															 
													            <div class="min-w-40px d-flex justify-content-center">
																	<c:choose>
									                                    <c:when test="${todaycheckout[0].work_type.toString() eq '1'}"><i class="ki-duotone ki-delivery-door fs-1 text-primary"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i></c:when>
									                                    <c:when test="${todaycheckout[0].work_type.toString() eq '2'}"><i class="ki-duotone ki-home fs-1 text-success"></i></c:when>
									                                    <c:when test="${todaycheckout[0].work_type.toString() eq '3'}"><i class="ki-duotone ki-cube-2 fs-1 text-danger"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i></c:when>
									                                </c:choose>
													            </div>
											    </div>
											
											</div>
											
											
											</c:if>
											
											</c:if>
											
						                </div>
						                <c:if test="${not hasFullLeave}">
									<div class="d-flex mt-4">
									<span class="min-w-md-80px"></span>
											<c:forEach var="leave" items="${leaveToday}">
										
										    <c:set var="leaveTitle" value="${leave.leave_type_name}" />
										
										    <c:choose>
										        <c:when test="${fn:contains(leaveTitle,'ลาป่วย')}">
										            <div class="badge badge-info fw-semibold w-md-170px text-wrap fs-7">
										                ${leaveTitle}
										                <c:choose>
														    <c:when test="${fn:trim(leave.half_day) eq '0'}">: เต็มวัน</c:when>
														    <c:when test="${fn:trim(leave.half_day) eq '1'}">: ช่วงเช้า</c:when>
														    <c:when test="${fn:trim(leave.half_day) eq '2'}">: ช่วงบ่าย</c:when>
														    <c:otherwise>: เลือกช่วงเวลา</c:otherwise>
														</c:choose>
														<c:if test="${leave.leave_status_id.toString() eq '0'}">
															 <i class="ki-duotone ki-watch ms-2 text-warning">
															   <span class="path1"></span><span class="path2"></span>
															 </i>
														</c:if>
														     
										            </div>
										        </c:when>
										
										        <c:otherwise>
										            <div class="badge badge-primary fw-semibold w-md-170px text-wrap fs-7">
										                ${leaveTitle}
														<c:choose>
														    <c:when test="${fn:trim(leave.half_day) eq '0'}">: เต็มวัน</c:when>
														    <c:when test="${fn:trim(leave.half_day) eq '1'}">: ช่วงเช้า</c:when>
														    <c:when test="${fn:trim(leave.half_day) eq '2'}">: ช่วงบ่าย</c:when>
														    <c:otherwise>: เลือกช่วงเวลา</c:otherwise>
														</c:choose>
														<c:if test="${leave.leave_status_id.toString() eq '0'}">
															 <i class="ki-duotone ki-watch ms-2 text-warning">
															   <span class="path1"></span><span class="path2"></span>
															 </i>
														</c:if>
										            </div>
										        </c:otherwise>
										
										    </c:choose>
										
										</c:forEach>
											</div>
											</c:if>
											<div class="border-bottom pb-4 mb-4"></div>
											
						                <div class="d-flex flex-column flex-md-row mb-6">
						                    <span class="fs-4 fw-medium text-gray-900 min-w-80px mb-4 mb-md-0">${lastWorkDayName}</span>
											
											<!-- ตรวจประเภทการลา Lastday -->
											<c:set var="hasFullLeaveLastday" value="false"/>
											<c:set var="isMorningLeaveLastday" value="false"/>
											<c:set var="isAfternoonLeaveLastday" value="false"/>
											
											<c:forEach var="leaveLastday" items="${leaveLastday}">
											    <c:if test="${fn:trim(leaveLastday.half_day) eq '0'}">
											        <c:set var="hasFullLeaveLastday" value="true"/>
											    </c:if>
											
											    <c:if test="${fn:trim(leaveLastday.half_day) eq '1'}">
											        <c:set var="isMorningLeaveLastday" value="true"/>
											    </c:if>
											
											    <c:if test="${fn:trim(leaveLastday.half_day) eq '2'}">
											        <c:set var="isAfternoonLeaveLastday" value="true"/>
											    </c:if>
											</c:forEach>
											
											<c:if test="${empty leaveLastday}">
										
											<!-- IN -->
											<div class="d-flex align-items-center mb-4 mb-md-0 min-w-250px">
						                        <span class="bullet bullet-vertical bg-success min-h-25px me-4 rounded-0"></span>
						                        <div class="d-flex align-items-center text-gray-900">
						                            <span class="fs-6 fw-bold text-success min-w-30px me-4">IN</span> 
											        
						                            <div class="d-flex align-items-center min-w-170px">
						                                <c:if test="${not empty lastcheckin[0].work_hours_time_work}">
						                                    <span class="fs-2 me-4 fw-medium"><fmt:formatDate value="${lastcheckin[0].work_hours_time_work}" pattern="HH:mm"/></span>
						                                    <span class="fs-6 me-4 fw-medium"><fmt:formatDate value="${lastcheckin[0].work_hours_time_work}" pattern="dd MMM yyyy"/></span>
						                                </c:if>
						                            </div>
						                            <div class="min-w-40px d-flex justify-content-center">
						                                <c:choose>
						                                    <c:when test="${lastcheckin[0].work_type.toString() eq '1'}"><i class="ki-duotone ki-delivery-door fs-1 text-primary"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i></c:when>
						                                    <c:when test="${lastcheckin[0].work_type.toString() eq '2'}"><i class="ki-duotone ki-home fs-1 text-success"></i></c:when>
						                                    <c:when test="${lastcheckin[0].work_type.toString() eq '3'}"><i class="ki-duotone ki-cube-2 fs-1 text-danger"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i></c:when>
						                                </c:choose>
						                            </div>
						                            
						                        </div>
						                    </div>
											
											<!-- OUT -->
											<div class="d-flex align-items-center ms-md-3">
						                        <span class="bullet bullet-vertical bg-info min-h-25px me-4 rounded-0"></span>
						                        <div class="d-flex align-items-center text-gray-900">
						                            <span class="fs-6 fw-bold text-info min-w-30px me-4">OUT</span>
											 
											            <div class="d-flex align-items-center min-w-170px"> 
													          <!-- ไม่ลาช่วงบ่าย --> 
												                <c:if test="${not empty lastcheckout[0].work_hours_time_work}">
												                    <span class="fs-2 me-4 fw-medium">
												                        <fmt:formatDate value="${lastcheckout[0].work_hours_time_work}" pattern="HH:mm"/>
												                    </span>
												
												                    <span class="fs-6 me-4 fw-medium">
												                        <fmt:formatDate value="${lastcheckout[0].work_hours_time_work}" pattern="dd MMM yyyy"/>
												                    </span>
												                </c:if>
											            </div>
															 
													            <div class="min-w-40px d-flex justify-content-center">
																	<c:choose>
									                                    <c:when test="${lastcheckout[0].work_type.toString() eq '1'}"><i class="ki-duotone ki-delivery-door fs-1 text-primary"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i></c:when>
									                                    <c:when test="${lastcheckout[0].work_type.toString() eq '2'}"><i class="ki-duotone ki-home fs-1 text-success"></i></c:when>
									                                    <c:when test="${lastcheckout[0].work_type.toString() eq '3'}"><i class="ki-duotone ki-cube-2 fs-1 text-danger"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i></c:when>
									                                </c:choose>
													            </div>
											    </div>
											
											</div>
											
											
											</c:if>
											
											<c:if test="${not empty leaveLastday}">
											<c:if test="${hasFullLeaveLastday}">
											    <c:forEach var="leaveLastday" items="${leaveLastday}">
											        <c:if test="${fn:trim(leaveLastday.half_day) eq '0'}">
													    <c:set var="leaveTitle" value="${leaveLastday.leave_type_name}" />
													    <c:choose>
													        <c:when test="${fn:contains(leaveTitle,'ลาป่วย')}">
													        <div class="d-flex align-items-center ">
													            <div class="badge badge-info fw-semibold w-md-170px text-wrap fs-7">
													                ${leaveLastday.leave_type_name} : เต็มวัน
													                <c:if test="${leaveLastday.leave_status_id.toString() eq '0'}">
															                <i class="ki-duotone ki-watch  ms-2 text-warning">
															                	<span class="path1"></span><span class="path2"></span>
															                </i>
														         </c:if>
													            </div>
													            </div>
													        </c:when>
													
													        <c:otherwise>
													        <div class="d-flex align-items-center">
													            <div class="badge badge-primary fw-semibold w-md-170px text-wrap fs-7">
													                ${leaveLastday.leave_type_name} : เต็มวัน
													                <c:if test="${leaveLastday.leave_status_id.toString() eq '0'}">
															                <i class="ki-duotone ki-watch  ms-2 text-warning">
															                	<span class="path1"></span><span class="path2"></span>
															                </i>
														         </c:if>
													            </div>
													            </div>
													        </c:otherwise>
													
													    </c:choose>
											
											        </c:if>
											    </c:forEach>
											</c:if>
											<!-- ลาไม่เต็มวัน -->
											<c:if test="${not hasFullLeaveLastday and not hasFullLeaveLastday}">
											
											<!-- IN -->
											<div class="d-flex align-items-center mb-4 mb-md-0 min-w-250px">
						                        <span class="bullet bullet-vertical bg-success min-h-25px me-4 rounded-0"></span>
						                        <div class="d-flex align-items-center text-gray-900">
						                            <span class="fs-6 fw-bold text-success min-w-30px me-4">IN</span> 
											        <div class="d-flex align-items-center min-w-170px">
						                                <c:if test="${not empty lastcheckin[0].work_hours_time_work}">
						                                    <span class="fs-2 me-4 fw-medium"><fmt:formatDate value="${lastcheckin[0].work_hours_time_work}" pattern="HH:mm"/></span>
						                                    <span class="fs-6 me-4 fw-medium"><fmt:formatDate value="${lastcheckin[0].work_hours_time_work}" pattern="dd MMM yyyy"/></span>
						                                </c:if>
						                            </div>
						                            <div class="min-w-40px d-flex justify-content-center">
						                                <c:choose>
						                                    <c:when test="${lastcheckin[0].work_type.toString() eq '1'}"><i class="ki-duotone ki-delivery-door fs-1 text-primary"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i></c:when>
						                                    <c:when test="${lastcheckin[0].work_type.toString() eq '2'}"><i class="ki-duotone ki-home fs-1 text-success"></i></c:when>
						                                    <c:when test="${lastcheckin[0].work_type.toString() eq '3'}"><i class="ki-duotone ki-cube-2 fs-1 text-danger"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i></c:when>
						                                </c:choose>
						                            </div>
						                        </div>
						                    </div>
											
											<!-- OUT -->
											<div class="d-flex align-items-center ms-md-3">
						                        <span class="bullet bullet-vertical bg-info min-h-25px me-4 rounded-0"></span>
						                        <div class="d-flex align-items-center text-gray-900">
						                            <span class="fs-6 fw-bold text-info min-w-30px me-4">OUT</span>
													 <div class="d-flex align-items-center min-w-170px">
								                                <c:if test="${not empty lastcheckout[0].work_hours_time_work}">
								                                    <span class="fs-2 me-4 fw-medium"><fmt:formatDate value="${lastcheckout[0].work_hours_time_work}" pattern="HH:mm"/></span>
								                                    <span class="fs-6 fw-medium text-muted"><fmt:formatDate value="${lastcheckout[0].work_hours_time_work}" pattern="dd MMM yyyy"/></span>
								                                </c:if>
								                            </div>
								                            <div class="min-w-40px d-flex justify-content-center">
								                                <c:choose>
								                                    <c:when test="${lastcheckout[0].work_type.toString() eq '1'}"><i class="ki-duotone ki-delivery-door fs-1 text-primary"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i></c:when>
								                                    <c:when test="${lastcheckout[0].work_type.toString() eq '2'}"><i class="ki-duotone ki-home fs-1 text-success"></i></c:when>
								                                    <c:when test="${lastcheckout[0].work_type.toString() eq '3'}"><i class="ki-duotone ki-cube-2 fs-1 text-danger"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i></c:when>
								                                </c:choose>
								                     </div>
											    </div>
											
											</div>
											
											
											</c:if>
											
											</c:if>
											
											
						                </div>
						                <c:if test="${not hasFullLeaveLastday}">
									<div class="d-flex mt-4">
									<span class="min-w-md-80px"></span>
											<c:forEach var="leaveLastday" items="${leaveLastday}">
										
										    <c:set var="leaveTitle" value="${leaveLastday.leave_type_name}" />
										
										    <c:choose>
										        <c:when test="${fn:contains(leaveTitle,'ลาป่วย')}">
										            <div class="badge badge-info fw-semibold w-md-170px text-wrap fs-7">
										                ${leaveTitle}
										
										                <c:choose>
										                   <c:when test="${fn:trim(leaveLastday.half_day) eq '0'}"> : เต็มวัน</c:when>
														    <c:when test="${fn:trim(leaveLastday.half_day) eq '1'}">: ช่วงเช้า</c:when>
														    <c:when test="${fn:trim(leaveLastday.half_day) eq '2'}">: ช่วงบ่าย</c:when>
														    <c:otherwise>: เลือกช่วงเวลา</c:otherwise>
														</c:choose>
														<c:if test="${leaveLastday.leave_status_id.toString() eq '0'}">
															   <i class="ki-duotone ki-watch  ms-2 text-warning">
															    	<span class="path1"></span><span class="path2"></span>
															    </i>
														</c:if>
										
										            </div>
										        </c:when>
										
										        <c:otherwise>
										            <div class="badge badge-primary fw-semibold w-md-170px text-wrap fs-7">
										                ${leaveTitle}
										
										                <c:choose>
										                   <c:when test="${fn:trim(leaveLastday.half_day) eq '0'}"> : เต็มวัน</c:when>
														    <c:when test="${fn:trim(leaveLastday.half_day) eq '1'}">: ช่วงเช้า</c:when>
														    <c:when test="${fn:trim(leaveLastday.half_day) eq '2'}">: ช่วงบ่าย</c:when>
														    <c:otherwise>: เลือกช่วงเวลา</c:otherwise>
														</c:choose>
														<c:if test="${leaveLastday.leave_status_id.toString() eq '0'}">
															   <i class="ki-duotone ki-watch ms-2 text-warning">
															    	<span class="path1"></span><span class="path2"></span>
															    </i>
														</c:if>
										            </div>
										        </c:otherwise>
										
										    </c:choose>
										
										</c:forEach>
											</div>
											</c:if>
						
						            </div>
						        </div>
						    </div>
						</div>
						<!-- end:Last Update -->

						<!-- begin:Your Location -->
						<div class="card card-flush h-auto mb-5 mb-xl-10">
							<div class="accordion" id="kt_accordion_1">
								<div class="accordion-item">
									<h2 class="accordion-header" id="kt_accordion_1_header_1">
										<button class="accordion-button lh-1" type="button"
											data-bs-toggle="collapse"
											data-bs-target="#kt_accordion_1_body_1" aria-expanded="true"
											aria-controls="kt_accordion_1_body_1">
											<span class="fs-2 fw-medium mt-3">Your Location</span>
										</button>
									</h2>
									<div id="kt_accordion_1_body_1"
										class="accordion-collapse collapse show"
										aria-labelledby="kt_accordion_1_header_1"
										data-bs-parent="#kt_accordion_1">
										<div class="accordion-body">
											<div id="map" style="width: 100%; height: 350px;"></div>
											<input type="hidden" id="x" class="latitude" name="latitude">
											<input type="hidden" id="y" class="longitude"
												name="longitude">
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- end:Your Location -->

					</div>
					<!--end::Col-->
					<!--begin::Last Check-->
					<div class="col-xl-4 col-lg-4 col-md-4 col-sm-12 col-12 mb-10">
						<div class="card card-flush h-auto mb-5 mb-xl-10">
							<div class="card-header pt-5">
								<div class="card-title col-lg-12 d-flex flex-column">
									<span class="fs-2 fw-bold text-gray-900 me-2 lh-1">
										Holiday</span>
								</div>
							</div>
							<div class="card-body pt-2 pb-4 px-0">
								<div class="tab-content mb-2 px-9">
									<c:if test="${not empty holidayList}">
										<div class="tab-pane fade show active"
											id="kt_timeline_widget_3_tab_content_4">
											<c:forEach var="hld" items="${holidayList}">
												<div class="d-flex align-items-center mb-6">
													<fmt:formatDate value="${hld.start_date}" pattern="u"
														var="day" />
													<span data-kt-element="bullet"
														class="dayofWeek bullet bullet-vertical d-flex align-items-center min-h-40px mh-100 me-4
													<c:if test="${day == '1'}"> bg-yellow</c:if>
													<c:if test="${day == '2'}"> bg-pink</c:if>
													<c:if test="${day == '3'}"> bg-success</c:if>
													<c:if test="${day == '4'}"> bg-orange</c:if>
													<c:if test="${day == '5'}"> bg-primary</c:if>"></span>
													<div class="flex-grow-1 me-5">
														<div class="text-grey fw-medium fs-3">${hld.head}</div>
														<div class="text-grey fw-medium fs-6">
															<fmt:formatDate value="${hld.start_date}"
																pattern="E, dd MMM" />
															<c:if test="${hld.start_date != hld.end_date}">
																- <fmt:formatDate value="${hld.end_date}"
																	pattern="E, dd MMM" />
															</c:if>
														</div>
													</div>
													<jsp:useBean id="now" class="java.util.Date" />
													<fmt:formatDate var="todayStr" value="${now}"
														pattern="yyyy-MM-dd" />
													<fmt:formatDate var="holidayStr" value="${hld.start_date}"
														pattern="yyyy-MM-dd" />
													<c:if test="${holidayStr eq todayStr}">
														<span class="badge badge-light-danger">Today</span>
													</c:if>
												</div>
											</c:forEach>
										</div>
									</c:if>
									<c:if test="${empty holidayList}">
										<div class="tab-pane fade show active"
											id="kt_timeline_widget_3_tab_content_4">
											<div class="d-flex align-items-center mb-6">
												<span class="fs-4 fw-semibold text-danger">No
													holidays</span>
											</div>
										</div>
									</c:if>
								</div>
							</div>
						</div>

						<!--begin::Announcement-->
						<c:if test="${not empty announcementList}">

							<jsp:useBean id="nowDateForCheck" class="java.util.Date" />
							<fmt:formatDate var="todayStr" value="${nowDateForCheck}"
								pattern="yyyy-MM-dd" />

							<c:set var="headerShown" value="false" />

							<c:forEach var="ann" items="${announcementList}">

								<fmt:formatDate var="annDateStr"
									value="${ann.announcement_date}" pattern="yyyy-MM-dd" />

								<c:if
									test="${fn:trim(ann.highlight) eq '1' and ann.status ne '0' and annDateStr <= todayStr}">

									<c:if test="${not headerShown}">
										<div class="d-flex align-items-center mb-6">
											<i class="ki-duotone ki-information text-danger"
												style="font-size: 32px;"> <span class="path1"></span> <span
												class="path2"></span> <span class="path3"></span>
											</i>
											<h2 class="fw-bold text-danger mb-0 ms-3">Announcement</h2>
										</div>
										<c:set var="headerShown" value="true" />
									</c:if>

									<div
										class="card hover-elevate-up shadow-sm parent-hover position-relative mb-10"
										style="cursor: pointer; margin: 0 auto;"
										onclick="window.location.href='${pageContext.request.contextPath}/announcementRead?id=${ann.announcementId}'">

										<div
											style="display: flex; justify-content: flex-end; gap: 6px; position: absolute; top: 20px !important; right: 20px; z-index: 2;">
											<span class="badge fw-semibold text-white bg-primary"
												style="height: 26px;">New</span>
										</div>

										<div class="card-header p-0 border-0 h-250px">
											<c:choose>
												<c:when
													test="${not empty ann.fileUpload and not empty ann.fileUpload.path}">
													<img src="${ann.fileUpload.path}" alt="${ann.topic}"
														class="image-box w-100 h-100 rounded-top d-block"
														style="object-fit: cover; object-position: top;">
												</c:when>
												<c:otherwise>
													<div
														class="d-flex align-items-center justify-content-center bg-light w-100 h-250px rounded-top">
														<span class="text-gray-400 fs-7">No Image</span>
													</div>
												</c:otherwise>
											</c:choose>
										</div>
										<div
											class="card-body p-9 d-flex flex-column justify-content-center"
											style="min-height: 140px;">
											<div class="fs-6 fw-bold text-gray-800 mb-5 lh-bases">${ann.topic}</div>

											<div class="d-flex align-items-center gap-4">
												<span
													class="d-flex align-items-center fs-7 fw-medium text-gray-800 me-1">
													<i class="ki-duotone ki-calendar-2 me-2 text-muted fs-1">
														<span class="path1"></span><span class="path2"></span><span
														class="path3"></span> <span class="path4"></span><span
														class="path5"></span>
												</i> <fmt:formatDate value="${ann.announcement_date}"
														pattern="dd MMM yyyy" />
												</span> <span
													class="d-flex align-items-center fs-7 fw-medium text-gray-800">
													<i class="ki-duotone ki-eye me-2 text-muted fs-1"> <span
														class="path1"></span><span class="path2"></span><span
														class="path3"></span>
												</i> ${empty ann.readcount ? 0 : ann.readcount} Views
												</span>
											</div>
										</div>
									</div>

								</c:if>
							</c:forEach>
						</c:if>
					</div>
					<!--end::Last Check-->

				</div>
				<!--end::Row-->
			</div>
		</div>
		<!--end::Content-->
	</div>
	<!--end::Content wrapper-->
	<!--begin::Page loader-->
	<!--end::Page loader-->
</div>
<!--end:::Main-->
<!--begin:::Modal-->
<!-- popup announcement -->
<%-- <div class="modal fade" id="announcementModal" data-bs-backdrop="static"
	data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered modal-lg">
		<div class="modal-content shadow-lg">

			<div class="modal-header border-0">
				<h5
					class="modal-title text-primary fw-bold d-flex align-items-center">
					<i class="ki-duotone ki-notification-on fs-1 me-2 text-danger"><span
						class="path1"></span><span class="path2"></span><span
						class="path3"></span><span class="path4"></span><span
						class="path5"></span></i> ประกาศข่าวสาร
				</h5>
				<div class="btn btn-icon btn-sm btn-active-light-danger ms-2"
					data-bs-dismiss="modal" aria-label="Close">
					<i class="ki-duotone ki-cross fs-1 text-danger"> <span
						class="path1"></span><span class="path2"></span>
					</i>
				</div>
			</div>

			<div class="modal-body py-2">
				<div id="announcementCarousel" class="carousel slide"
					data-bs-ride="false">

					<div class="carousel-inner">
						<c:set var="first" value="true" />
						<c:forEach var="ann" items="${announcementList}">
							<fmt:formatDate var="annDateStr" value="${ann.announcement_date}"
								pattern="yyyy-MM-dd" />

							<c:if
								test="${fn:trim(ann.highlight) eq '1' and ann.status ne '0' and annDateStr <= todayStr}">
								<div class="carousel-item ${first ? 'active' : ''}">
									<div class="text-center px-4">

										<div class="mb-5 position-relative overflow-hidden rounded-3">
											<c:choose>
												<c:when
													test="${not empty ann.fileUpload and not empty ann.fileUpload.path}">
													<img src="${ann.fileUpload.path}"
														class="mw-100 h-auto rounded-3 shadow-sm border"
														style="max-height: 55vh; object-fit: contain;">
												</c:when>
												<c:otherwise>
													<div
														class="w-100 d-flex align-items-center justify-content-center bg-light text-muted rounded-3"
														style="min-height: 300px;">
														<i class="ki-duotone ki-picture fs-3x"><span
															class="path1"></span><span class="path2"></span></i>
													</div>
												</c:otherwise>
											</c:choose>
										</div>

										<h3 class="fw-bolder text-gray-900 mb-2">${ann.topic}</h3>

										<p
											class="text-muted fs-6 mb-4 d-flex align-items-center justify-content-center">

											<i class="ki-duotone ki-calendar-2 me-2 text-primary fs-2">
												<span class="path1"></span><span class="path2"></span>
											</i>

											<fmt:formatDate value="${ann.announcement_date}"
												pattern="dd MMM yyyy" />
										</p>

										<a href="announcementRead?id=${ann.announcementId}"
											class="btn btn-outline btn-outline-dashed btn-outline-primary btn-active-light-primary">
											อ่านรายละเอียดเพิ่มเติม <i
											class="ki-duotone ki-arrow-right ms-2"><span
												class="path1"></span><span class="path2"></span></i>
										</a>

									</div>
								</div>
								<c:set var="first" value="false" />
							</c:if>
						</c:forEach>
					</div>

					<div
						class="carousel-indicators position-relative d-flex justify-content-center m-0 mt-2">
						<c:set var="idx" value="0" />
						<c:forEach var="ann" items="${announcementList}">
							<fmt:formatDate var="annDateStr" value="${ann.announcement_date}"
								pattern="yyyy-MM-dd" />
							<c:if
								test="${fn:trim(ann.highlight) eq '1' and ann.status ne '0' and annDateStr <= todayStr}">
								<button type="button" data-bs-target="#announcementCarousel"
									data-bs-slide-to="${idx}"
									class="${idx == 0 ? 'active' : ''} bg-primary w-10px h-10px rounded-circle mx-1"
									aria-current="${idx == 0 ? 'true' : 'false'}"></button>
								<c:set var="idx" value="${idx + 1}" />
							</c:if>
						</c:forEach>
					</div>

					<button class="carousel-control-prev" type="button"
						data-bs-target="#announcementCarousel" data-bs-slide="prev"
						style="width: 15%; opacity: 1; position: absolute; top: 50%; transform: translateY(-50%); z-index: 5;">
						<span
							class="btn btn-icon btn-light-primary shadow-sm rounded-circle"
							style="width: 45px; height: 45px;"> <i
							class="ki-duotone ki-left fs-1"><span class="path1"></span><span
								class="path2"></span></i>
						</span>
					</button>

					<button class="carousel-control-next" type="button"
						data-bs-target="#announcementCarousel" data-bs-slide="next"
						style="width: 15%; opacity: 1; position: absolute; top: 50%; transform: translateY(-50%); z-index: 5;">
						<span
							class="btn btn-icon btn-light-primary shadow-sm rounded-circle"
							style="width: 45px; height: 45px;"> <i
							class="ki-duotone ki-right fs-1"><span class="path1"></span><span
								class="path2"></span></i>
						</span>
					</button>
				</div>
			</div>

			<div class="modal-footer border-0 pt-0">
				<button type="button" class="btn btn-primary w-100 py-3 fw-bold"
					id="btnAcknowledge">รับทราบ</button>
			</div>

		</div>
	</div>
</div> --%>
<!--end:::Modal-->
<!-- Popup Notification -->
<c:if test="${hasNotification}">
<div class="modal fade" id="notificationModal" data-bs-backdrop="static"
	data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered modal-lg">
		<div class="modal-content shadow-lg">

			<div class="modal-header border-0">
				<h2 class="modal-title text-gray-900 fw-weight d-flex align-items-center">
					Notification
				</h2>
				<div class="btn btn-icon btn-sm btn-active-light-danger ms-2"
					data-bs-dismiss="modal" aria-label="Close">
					<i class="ki-duotone ki-cross fs-1 text-muted"> <span
						class="path1"></span><span class="path2"></span>
					</i>
				</div>
			</div>

			<div class="modal-body py-7 px-5">
				<div class="d-flex flex-column gap-6 p-7">
					<h1 class="text-gray-900 fw-weight">ตรวจพบอุปกรณ์รอตอบรับ</h1>
				
					<div class="d-flex flex-column gap-6 p-7 border-gray-400 border-dashed rounded-2 p-7">
						<span class="fs-4 fw-semibold text-gray-800">Signature</span>
						<c:if test="${empty imgPathSignature}">
							<span class="fs-6 text-danger">กรุณาอัปโหลดลายเซ็น เพื่อนำไปใช้ประกอบเอกสารรับอุปกรณ์ </span>
						</c:if>
						
						
						<form id="signatureForm" method="post" action="update_signature?redirectPage=check_in_out" enctype="multipart/form-data">
						          <div id="errorMsg" class="text-start text-danger mb-3"></div> 
						        <div class="d-flex align-items-center justify-content-between">
						              
						                    <c:choose>
						                        <c:when test="${not empty imgPathSignature}">
						                            <div id="displayMode">
						                                <img src="${imgPathSignature}"  class="" />
						                                 <p id="signatureFileName" class="text-gray-700 fs-5 fw-normal mt-2 mb-0">${signatureFileName}</p>
						                            </div>
						                        </c:when>
						                        
						                        <c:otherwise>
						                            <div id="emptyMode" class="d-flex align-items-center gap-4">
						                                <i class="ki-duotone ki-picture fs-2"><span class="path1"></span><span class="path2"></span></i>
						                                <span class="fs-6 text-muted fw-medium">Allowed file types: png, jpg, jpeg.</span>
						                            </div>
						                        </c:otherwise>
						                    </c:choose>
						
						                    <div id="previewMode" class="d-none">
						                        <div class="symbol symbol-100px position-relative">
						                            <img id="imgPreview" src="" alt="Preview"  class="rounded border" />
						                            <label class="btn btn-icon btn-circle btn-color-muted btn-active-color-primary w-25px h-25px bg-body shadow position-absolute translate-middle top-0 start-100" 
						                                   data-bs-toggle="tooltip" title="Change">
						                                <i class="ki-duotone ki-pencil fs-7"><span class="path1"></span><span class="path2"></span></i>
						                                <input type="file" id="signatureInputFile" name="fileUpload" accept=".png, .jpg, .jpeg" class="d-none" />
						                            </label>
						                            <span id="btnCancelPreview" class="btn btn-icon btn-circle btn-color-muted btn-active-color-primary w-25px h-25px bg-body shadow position-absolute translate-middle top-100 start-100" 
						                                  data-bs-toggle="tooltip" title="Cancel">
						                                <i class="ki-outline ki-cross fs-4"></i>
						                            </span>
						                        </div>
						                       <div id="fileNameDisplay" class="text-gray-700 fs-5 fw-normal mt-1"></div>
						                    </div>
						       
						
						                <div class="d-flex gap-2 align-items-center">
						                 	<%-- <c:if test="${not empty imgPathSignature}">
								                <a href="signature_perform_delete?userId=${user.id}" onclick="return confirmDelete(this.href, 'check_in_out');"
													class="btn btn-icon btn-light-danger btn-sm" title="Delete">
													<i class="ki-duotone ki-trash fs-2"><span
														class="path1"></span><span class="path2"></span><span
														class="path3"></span><span class="path4"></span><span
														class="path5"></span></i>
												</a>
											</c:if> --%>
						                    <button type="button" id="mainActionBtn" class="btn btn-primary">Upload</button>
						                </div>
						                <input type="hidden" id="hasSignature" value="${not empty imgPathSignature}" />
						            </div>
						      
						    </form>
					</div>
					
				<c:forEach var="item" items="${borrowList}">
					<c:if test="${item.status eq 'B' 
									and not empty item.user_delivery
							        and empty item.user_receive
							        and empty item.user_return
							        and empty item.user_return_receive}">
						<!-- <div class="d-flex align-items-center justify-content-between border border-warning rounded-2 p-6 "> -->
						<div class="d-flex flex-column flex-md-row align-items-start align-items-md-center justify-content-between border border-warning rounded-2 p-6 gap-4">
							<div class="d-flex gap-5 align-items-center ">
								<div class="d-flex flex-wrap align-items-center gap-9">
									<div class="d-flex flex-column align-items-center border rounded p-4 text-center min-w-125px">
									
										<c:choose>
										    <c:when test="${item.type eq 'c'}">
										        <i class="ki-duotone ki-laptop fs-1 text-dark">
													<span class="path1"></span>
				 									<span class="path2"></span>
												</i> <span class="fs-6 fw-normal text-gray-900 mt-3">Computer</span>
										    </c:when>
										
										    <c:when test="${item.type eq 'in'}">
										        <i class="ki-duotone ki-keyboard fs-1 text-dark">
										        	<span class="path1"></span>
													<span class="path2"></span>
												 </i>
										        <span class="fs-6 fw-normal text-gray-900 mt-3">Instrument</span>
										    </c:when>
										
										    <c:when test="${item.type eq 'L'}">
										        <i class="ki-duotone ki-verify fs-1 text-dark">
										        	<span class="path1"></span>
													<span class="path2"></span>
												 </i>
										        <span class="fs-6 fw-normal text-gray-900 mt-3">Software License</span>
										    </c:when>
										
										    <c:when test="${item.type eq 'Mob'}">
										        <i class="ki-duotone ki-phone fs-1 text-dark">
										        	<span class="path1"></span>
													<span class="path2"></span>
												 </i>
										        <span class="fs-6 fw-normal text-gray-900 mt-3">Mobile</span>
										    </c:when>
										
										    <c:when test="${item.type eq 'p'}">
										        <i class="ki-duotone ki-wifi-square fs-1 text-dark">
										        	<span class="path1"></span>
													<span class="path2"></span>
													<span class="path3"></span>
													<span class="path4"></span>
												 </i>
										        <span class="fs-6 fw-normal text-gray-900 mt-3">Pocket WIFI</span>
										    </c:when>
										
										    <c:when test="${item.type eq 'sl'}">
										        <i class="ki-duotone ki-verify fs-1 text-dark"></i>
										        <span class="fs-6 fw-normal text-gray-900 mt-3">SIM / Service</span>
										    </c:when>
										
										    <c:otherwise>
										        <i class="ki-duotone ki-dots-square fs-1 text-dark">
										        	<span class="path1"></span>
													<span class="path2"></span>
													<span class="path3"></span>
													<span class="path4"></span>
												 </i>
										        <span class="fs-6 fw-normal text-gray-900 mt-3">Other</span>
										    </c:otherwise>
										
										</c:choose>
										
									</div>
								</div>
								<div class="d-flex flex-column justify-content-between min-h-80px">
									<div class=" ">
										<span class="fs-6 text-gray-900 me-1">${item.item_no}</span> <span class="fs-6 text-gray-900">${item.name}</span>
									</div>
									
									<div class="">
										<span class="fs-6 text-gray-900 me-1">ส่งมอบ :</span> <span class="fs-6 text-gray-900  me-3">
										<fmt:formatDate value="${item.time_delivery}" pattern="dd MMM yyyy" />
										</span>
									</div>
								</div>
							</div>
							
							<button type="button" class="btn btn-success btnReceived w-100 w-md-auto" data-id="${item.borrow_id}" 
								<c:if test="${empty imgPathSignature}">disabled</c:if>
    						>Received</button>
						</div>
						</c:if>
						
						<c:if test="${item.status eq 'T' 
									and not empty item.user_delivery
							        and not empty item.user_receive
							        and empty item.user_return
							        and empty item.user_return_receive}">
						<!-- <div class="d-flex align-items-center justify-content-between border border-warning rounded-2 p-6 "> -->
						<div class="d-flex flex-column flex-md-row align-items-start align-items-md-center justify-content-between border border-warning rounded-2 p-6 gap-4">
							<div class="d-flex gap-5 align-items-center ">
								<div class="d-flex flex-wrap align-items-center gap-9">
									<div class="d-flex flex-column align-items-center border rounded p-4 text-center min-w-125px">
									
										<c:choose>
										    <c:when test="${item.type eq 'c'}">
										        <i class="ki-duotone ki-laptop fs-1 text-dark">
													<span class="path1"></span>
				 									<span class="path2"></span>
												</i> <span class="fs-6 fw-normal text-gray-900 mt-3">Computer</span>
										    </c:when>
										
										    <c:when test="${item.type eq 'in'}">
										        <i class="ki-duotone ki-keyboard fs-1 text-dark">
										        	<span class="path1"></span>
													<span class="path2"></span>
												 </i>
										        <span class="fs-6 fw-normal text-gray-900 mt-3">Instrument</span>
										    </c:when>
										
										    <c:when test="${item.type eq 'L'}">
										        <i class="ki-duotone ki-verify fs-1 text-dark">
										        	<span class="path1"></span>
													<span class="path2"></span>
												 </i>
										        <span class="fs-6 fw-normal text-gray-900 mt-3">Software License</span>
										    </c:when>
										
										    <c:when test="${item.type eq 'Mob'}">
										        <i class="ki-duotone ki-phone fs-1 text-dark">
										        	<span class="path1"></span>
													<span class="path2"></span>
												 </i>
										        <span class="fs-6 fw-normal text-gray-900 mt-3">Mobile</span>
										    </c:when>
										
										    <c:when test="${item.type eq 'p'}">
										        <i class="ki-duotone ki-wifi-square fs-1 text-dark">
										        	<span class="path1"></span>
													<span class="path2"></span>
													<span class="path3"></span>
													<span class="path4"></span>
												 </i>
										        <span class="fs-6 fw-normal text-gray-900 mt-3">Pocket WIFI</span>
										    </c:when>
										
										    <c:when test="${item.type eq 'sl'}">
										        <i class="ki-duotone ki-verify fs-1 text-dark"></i>
										        <span class="fs-6 fw-normal text-gray-900 mt-3">SIM / Service</span>
										    </c:when>
										
										    <c:otherwise>
										        <i class="ki-duotone ki-dots-square fs-1 text-dark">
										        	<span class="path1"></span>
													<span class="path2"></span>
													<span class="path3"></span>
													<span class="path4"></span>
												 </i>
										        <span class="fs-6 fw-normal text-gray-900 mt-3">Other</span>
										    </c:otherwise>
										
										</c:choose>
										
									</div>
								</div>
								<div class="d-flex flex-column justify-content-between min-h-80px">
									<div class=" ">
										<span class="fs-6 text-gray-900 me-1">${item.item_no}</span> <span class="fs-6 text-gray-900">${item.name}</span>
									</div>
									
									<div class="">
										<span class="fs-6 text-gray-900 me-1">ขอคืน :</span> <span class="fs-6 text-gray-900  me-3">
										<fmt:formatDate value="${item.time_update}" pattern="dd MMM yyyy" />
										</span>
									</div>
								</div>
							</div>
							
							 <button type="button" class="btn btn-success btnReturn w-100 w-md-auto" data-id="${item.borrow_id}" 
								<c:if test="${empty imgPathSignature}">disabled</c:if>
    						>Return</button>
						</div>
						</c:if>
					</c:forEach>
				</div>
				
				
				
			</div>

			<div class="modal-footer border-0 pt-0 justify-content-end">
				<%-- <a href="${pageContext.request.contextPath}/borrow_list" class="btn btn-light me-3">Cancel</a> --%>
				<button type="button" class="btn btn-light me-3" data-bs-dismiss="modal">
					<span class="indicator-label">Cancel</span>
				</button>
				<button type="button" class="btn btn-primary"  onclick="window.open('${pageContext.request.contextPath}/my_profile', '_blank')"
					id="">Go to My Borrow</button>
			</div>

		</div>
	</div>
</div>
</c:if>
<script>
let serverTimeOffset = 0;

$(document).ready(function() {
	const now = new Date();
	const hour = now.getHours();
	const minute = now.getMinutes();
	const currentTime = hour + (minute / 60);
// Set check type button by time
	$("input[name='mdCheckType']").prop("checked", false);
	if (currentTime >= 0 && currentTime <= 12) {
		$("#checkType1").prop("checked", true);
		$("#mdCheckin").prop("checked", true);
		console.log("Auto selected: Check-In");
	} else if (currentTime > 12 && currentTime < 24) {
	    $("#checkType2").prop("checked", true);
	    $("#mdCheckout").prop("checked", true);
	    console.log("Auto selected: Check-Out");
	  } else {
	    console.log("not selecting any option");
	  }
	
	//syncServerTime();
	//setInterval(updateClock, 1000);
	updateClock(); // เรียกทำงานครั้งแรกทันทีตอนหน้าเว็บโหลดเสร็จ
    setInterval(updateClock, 1000); // สั่งให้อัปเดตซ้ำทุกๆ 1,000 มิลลิวินาที (1 วินาที)
	setTimeout(showNotificationModal, 1500);
});

// Modal Announcement
/* function showAnnouncements() {
    const modalElement = document.getElementById('announcementModal');

    if (modalElement && $(modalElement).find('.carousel-item').length > 0) {
        const annModal = new bootstrap.Modal(modalElement);
        annModal.show();

        const carouselItems = $(modalElement).find('.carousel-item');
        if (carouselItems.length === 1) {
            $(modalElement).find('.carousel-control-prev, .carousel-control-next').hide();
            $(modalElement).find('.carousel-indicators').hide();
        } else {
            $(modalElement).find('.carousel-control-prev, .carousel-control-next').show();
            $(modalElement).find('.carousel-indicators').show();
        }

        $("#btnAcknowledge").off("click").on("click", function() {
            annModal.hide();
            console.log("Announcement acknowledged.");
        });
    } else {
        console.log("No highlighted announcements to show.");
    }
}

setTimeout(showAnnouncements, 1500);
 */
 
//Modal Notification
function showNotificationModal() {
	 try {
	     const modalElement = document.getElementById('notificationModal');
	     if (!modalElement) {
	         return;
	     }
	     const annModal = new bootstrap.Modal(modalElement);
	     annModal.show();
	 } catch (e) {
		 console.error("showNotificationModal error:", e);
	 }
 }

function updateClock() {
    let currentTime = new Date(); 
    
    let hours = currentTime.getHours();
    let minutes = currentTime.getMinutes();
    
    if (hours > 18 || (hours === 18 && minutes >= 30)) {
        $("#clock").text("18:30");
        $("#clock-second").text(":00");
    } 
    else {
        let showHours = hours.toString().padStart(2, '0');
        let showMinutes = minutes.toString().padStart(2, '0');
        let showSeconds = currentTime.getSeconds().toString().padStart(2, '0');
        
        $("#clock").text(showHours + ":" + showMinutes);
        $("#clock-second").text(":" + showSeconds);
    }
    
    let options = { day: '2-digit', month: 'short', year: 'numeric' };
    let dateStr = currentTime.toLocaleDateString('en-GB', options).replace(/,/g, '');
    $("#date").text(dateStr);
}

$("#submitBtn").click(function() {
	const userId = "${logonUser}";
	const workType = $("input[name='workType']:checked").val();
	const checkType = $("input[name='checkType']:checked").val();
	const lat = $("input[name='latitude']").val();
	const lng = $("input[name='longitude']").val();
	console.log(userId + "/" + workType + "/" + checkType);
	saveCheckInOut(userId, workType, checkType, "normal", null, null, null, lat, lng);
});

function saveCheckInOut(userId, workType, checkType, mode, selectDate, selectTime, reason, lat, lng){
	console.log(userId+"|"+workType+"|"+checkType+"|"+mode+"|"+selectDate+"|"+selectTime+"|"+reason);
	toastr.options = {
		"closeButton": false,
		"debug": false,
		"newestOnTop": false,
		"progressBar": false,
		"positionClass": "toastr-top-right",
		"preventDuplicates": false,
		"onclick": null,
		"showDuration": "300",
		"hideDuration": "1000",
		"timeOut": "2000",
		"extendedTimeOut": "1000",
		"showEasing": "swing",
		"hideEasing": "linear",
		"showMethod": "fadeIn",
		"hideMethod": "fadeOut"
	};
	
	const data = {
			"userId": userId,
			"workType": workType,
			"checkType": checkType,
			"mode": mode,
			"reason": "",
			"latitude": lat,
			"longitude": lng,
	};
	
	var loadingEl = $("<div>")
		.attr("id", "page-loader")
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
	
	let targetUrl = "";
	if(checkType === "1"){
		targetUrl = "saveCheckIn";
	} else if(checkType === "2") {
		targetUrl = "saveCheckOut"
	}
	
	$.ajax({
	    url: targetUrl,
	    type: "POST",
	    dataType: "json",
	    data: data,
	    success: function (res) {
	    	console.log(res);
	      	let type = res.type === "1" ? "Check-in" : "Check-out";
	      	if(res.status === "success"){
	      		toastr.success(type + " : " + res.time, "Saved successfully!");
	      		setTimeout(function() {
	    			location.reload();
	    		}, 2000);
	      	} else {
	      		$("#page-loader").remove();
	      		toastr.options.timeOut = "5000";
	      		toastr.options.extendedTimeOut = "5000";
	      		toastr.error(res.message || "Failed to record your attendance. Please try again.");
	      	}
	      $("#retroModal").modal("hide");
	    },
	    error: function (xhr, status, error) {
	    	$("#page-loader").remove();
	    	toastr.error("Error saving data: " + error);
	    }
	  });
}
</script>
<script>
var map, infoWindow, marker;
function initMap() {
	map = new google.maps.Map(document.getElementById('map'), {
		center : {
			lat : -34.397,
			lng : 150.644
		},
		zoom : 16
	});
	var latEl = document.querySelector('.latitude');
	var longEl = document.querySelector('.longitude');
	infoWindow = new google.maps.InfoWindow;
	marker = new google.maps.Marker;
	if (navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(function(position) {
			var pos = {
				lat : position.coords.latitude,
				lng : position.coords.longitude
			};
			x = pos.lat;	y = pos.lng;

			marker.setPosition(pos),
			marker.setMap(map),
			marker.setDraggable(false);

			infoWindow.setContent('Current Position');
			infoWindow.open(map,marker);
			map.setCenter(pos);
			adddata();
			google.maps.event.addListener(marker, "dragend", function(event) {
				var lati, lngti, address;
				console.log('i am dragged');
				lati = marker.getPosition().lat();
				lngti = marker.getPosition().lng();
				var geocoder = new google.maps.Geocoder();
				geocoder.geocode({
					latLng : marker.getPosition()
				},
				function(result, status) {
					if ('OK' === status) { // This line can also be written like if ( status == google.maps.GeocoderStatus.OK ) {
						address = result[0].formatted_address;
						resultArray = result[0].address_components;
						// Get the city and set the city input value to the one selected
							
						latEl.value = lati;
						longEl.value = lngti;
					} else {
						console.log('Geocode was not successful for the following reason: ' + status);
					}
					if (infoWindow) {
						infoWindow.close();
					}
					/* Creates the info Window at the top of the marker */
					infoWindow = new google.maps.InfoWindow({
						content : address
					});
					infoWindow.open(map, marker);
				});
			});
		},
		function() {
			handleLocationError(true, infoWindow, map.getCenter());
		});
	} else {
		// Browser doesn't support Geolocation
		handleLocationError(false, infoWindow, map.getCenter());
	}
}
function adddata() {
	$(document).ready(function() {
		document.getElementById("x").value = x;
	});

	$(document).ready(function() {
		document.getElementById("y").value = y;
	});
	
	$.ajax({
		url: "saveLocationToSession",
		type: "POST",
		data: {
			latitude: x,
			longitude: y
		}
	});
}
function handleLocationError(browserHasGeolocation, infoWindow, pos) {
	infoWindow.setPosition(pos);
	infoWindow.setContent(browserHasGeolocation ? 'Error: The Geolocation service failed.' 
			: 'Error: Your browser doesn\'t support geolocation.');
	infoWindow.open(map);
}
</script>
<script async defer
	src="https://maps.googleapis.com/maps/api/js?key=${GOOGLE_API_KEY}&callback=initMap">
</script>
<script>
var inactivityTime = function () {
    var time;
    const TIMEOUT_PERIOD = 1800000;	// 30 * minutes * 1000

    function resetTimer() {
        clearTimeout(time);
        time = setTimeout(logout, TIMEOUT_PERIOD);
    }

    function logout() {
        window.location.href = 'signout.action';
    }

    // --- Events for Desktop ---
    document.onmousemove = resetTimer;
    document.onkeypress = resetTimer;
    document.onclick = resetTimer;
    // --- Events for Mobile ---
    document.ontouchstart = resetTimer; 
    document.ontouchmove = resetTimer;
    // --- Event for Scroll ---
    window.onscroll = resetTimer; 

    resetTimer();
};

window.onload = function() {
    inactivityTime();
};
</script>

<script>
	const fileInput = document.getElementById("signatureInputFile");
	const mainBtn = document.getElementById("mainActionBtn");
	const btnCancel = document.getElementById("btnCancelPreview");

	const displayMode = document.getElementById("displayMode");
	const emptyMode = document.getElementById("emptyMode");
	const previewMode = document.getElementById("previewMode");
	const imgPreview = document.getElementById("imgPreview");
	const fileNameDisplay = document.getElementById("fileNameDisplay");

	// upload / save
	if (mainBtn) {
		mainBtn.addEventListener("click", function () {
	
		    if (mainBtn.innerText.trim() === "Upload") {
	
		        if (fileInput) {
		            fileInput.click();
		        }
	
		    } else {
	
		        Swal.fire({
		            title: "Are you sure?!",
		            text: "Do you want to save the changes?",
		            icon: "warning",
		            showCancelButton: true,
		            confirmButtonText: "Save",
		            cancelButtonText: "Close",
		            buttonsStyling: false,
		            customClass: {
		                confirmButton: "btn btn-success",
		                cancelButton: "btn btn-secondary"
		            }
		        }).then((result) => {
	
		            if (result.isConfirmed) {
		                document.getElementById("signatureForm").submit();
		            }
	
		        });
		    }
		});
	}

	// preview image
	if (fileInput) {	    
	    fileInput.addEventListener("change", async function () { 	
	        let file = this.files[0];
	        const maxSize = 2 * 1024 * 1024;
	        const errorMsg = document.getElementById("errorMsg");

	        if (!file) return;

	        const originalText = mainBtn ? mainBtn.innerText : 'Upload';
	        if (mainBtn) {
	            mainBtn.disabled = true;
	            mainBtn.innerHTML = '<span class="spinner-border spinner-border-sm align-middle me-2"></span>Compressing...';
	        }

	        try {
	            const compressedFile = await compressImage(file, 1280, 1280, 0.8);
	            const dt = new DataTransfer();
	            dt.items.add(compressedFile);
	            this.files = dt.files;
	            file = this.files[0];
	        } catch (error) {
	            console.error("Compression failed", error);
	        }

	        if (mainBtn) {
	            mainBtn.disabled = false;
	            mainBtn.innerHTML = originalText;
	        }

	        if (file.size > maxSize) {
	            errorMsg.textContent = "Image must be smaller than 2MB.";
	            this.value = "";
	            return;
	        } else {
	            errorMsg.textContent = "";
	  
	            const reader = new FileReader();
	            reader.onload = function (e) {
	                imgPreview.src = e.target.result;
	                fileNameDisplay.innerText = file.name;

	                if (displayMode) displayMode.classList.add("d-none");
	                if (emptyMode) emptyMode.classList.add("d-none");
	                previewMode.classList.remove("d-none");

	                mainBtn.innerText = "Save";
	                mainBtn.classList.replace("btn-primary", "btn-success");
	            };
	            reader.readAsDataURL(file);
	        }
	    });
	}

	// cancel preview
	if (btnCancel) {

	    btnCancel.addEventListener("click", function () {

	        fileInput.value = "";

	        previewMode.classList.add("d-none");

	        if (displayMode) {
	            displayMode.classList.remove("d-none");
	        } else if (emptyMode) {
	            emptyMode.classList.remove("d-none");
	        }

	        mainBtn.innerText = "Upload";

	        mainBtn.classList.remove("btn-success");
	        mainBtn.classList.add("btn-primary");
	    });
	}

	// delete
	/* function confirmDelete(url, redirectPage) {

	    Swal.fire({
	        title: "Are you sure?!",
	        text: "Are you sure you want to delete this signature?",
	        icon: "warning",
	        showCancelButton: true,
	        confirmButtonText: "Yes, delete it!",
	        cancelButtonText: "Cancel",
	        buttonsStyling: false,
	        customClass: {
	            confirmButton: "btn btn-danger",
	            cancelButton: "btn btn-secondary"
	        }

	    }).then((result) => {

	        if (result.isConfirmed) {

	            window.location.href =
	                url + "&redirectPage=" + redirectPage;

	        }

	    });

	    return false;
	} */
	
	//----- Received -----
	$(document).on('click', '.btnReceived',function(e){
		e.preventDefault();

		const borrowId = $(this).data('id');

		Swal.fire({
	        title: "Are you sure?!",
	        text: "Have you received this equipment?",
	        icon: "question",
	        showCancelButton: true,
	        confirmButtonText: "Yes, received it",
	        cancelButtonText: "Cancel",
	        buttonsStyling: false,
	        customClass: {
	            confirmButton: "btn btn-success",
	            cancelButton: "btn btn-secondary"
	        }
	    }).then((result) => {
	        if (result.isConfirmed) {
	        	fetch("received_equipment.action", {
	        	    method: "POST",
	        	    headers: {
	        	        "Content-Type": "application/x-www-form-urlencoded"
	        	    },
	        	    body: "id=" + encodeURIComponent(borrowId)
	        	})
	        	.then(response => response.text())
	        	.then(data => {
	        	    location.reload();
	        	})
	        	.catch(error => {
	        	    console.error(error);
	        	    Swal.fire({
	        	        icon: "error",
	        	        title: "Error",
	        	        text: "Failed to received equipment"
	        	    });
	        	});

	        	}
	        	});

	})

	        	//----- Return -----

	        	$(document).on('click', '.btnReturn', function(e) {

	        	    e.preventDefault();

	        	    const borrowId = $(this).data('id');

	        	    Swal.fire({
	        	        title: "Confirm Return?",
	        	        text: "Confirm that you have returned this equipment.",
	        	        icon: "question",
	        	        showCancelButton: true,
	        	        confirmButtonText: "Yes, returned",
	        	        cancelButtonText: "Cancel",
	        	        buttonsStyling: false,
	        	        customClass: {
	        	            confirmButton: "btn btn-success",
	        	            cancelButton: "btn btn-secondary"
	        	        }
	        	    }).then((result) => {

	        	        if (result.isConfirmed) {

	        	            fetch("return_equipment.action", {
	        	                method: "POST",
	        	                headers: {
	        	                    "Content-Type": "application/x-www-form-urlencoded"
	        	                },
	        	                body: "id=" + encodeURIComponent(borrowId)
	        	            })
	        	            .then(response => response.text())
	        	            .then(data => {
	        	                location.reload();
	        	            })
	        	            .catch(error => {
	        	                console.error(error);

	        	                Swal.fire({
	        	                    icon: "error",
	        	                    title: "Error",
	        	                    text: "Failed to return equipment"
	        	                });
	        	            });

	        	        }

	        	    });

	        	})

</script>