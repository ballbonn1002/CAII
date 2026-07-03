<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />

<link
	href="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.css"
	rel="stylesheet" type="text/css" />
<script
	src="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.js"></script>
<script
	src="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.js"></script>

<style>
.cursor-default {
	cursor: default !important;
}
</style>
</head>
<body>
	
	<!-- VERSION CHECK -->
	<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
		<div class="d-flex flex-column flex-column-fluid">

			<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
				<div id="kt_app_toolbar_container"
					class="app-container container-xxl d-flex flex-stack">
					<div class="page-title d-flex flex-column justify-content-center">
						<h1 class="page-heading text-gray-900 fw-semibold my-0">My
							Job Site</h1>
						<ul
							class="breadcrumb breadcrumb-separatorless fw-medium fs-7 text-muted pt-1">
							<li class="breadcrumb-item text-muted">Home</li>
							<li class="breadcrumb-item"><span class="bullet w-5px h-2px"></span>
							</li>
							<li class="breadcrumb-item">Cube Management</li>
						</ul>
					</div>
				</div>
			</div>

	
			<div id="kt_app_content" class="app-content flex-column-fluid">
				<div id="kt_app_content_container"
					class="app-container container-xxl">

					<!-- START CARD USER -->
					<div class="card mb-5 mb-xl-10">
						<div class="card-header border-0 pt-6 pb-6 align-items-stretch">

							<div
								class="card-title d-flex flex-column justify-content-between"
								style="margin: 0 !important;">

								<h3 class="page-heading text-gray-900 fw-medium fs-4 mb-7">
									<c:set var="headerDisplay" value="" />

									<c:if test="${not empty userData.employeeId}">
										<c:set var="headerDisplay"
											value="${fn:trim(userData.employeeId)}" />
									</c:if>

									<c:if test="${not empty userData.nameEN}">
										<c:if test="${not empty headerDisplay}">
											<c:set var="headerDisplay" value="${headerDisplay} - " />
										</c:if>
										<c:set var="headerDisplay"
											value="${headerDisplay}${fn:trim(userData.nameEN)}" />
									</c:if>

									<c:if test="${not empty userData.name}">
										<c:set var="isDup" value="false" />
										<c:if test="${not empty userData.nameEN}">
											<c:if
												test="${fn:toUpperCase(fn:trim(userData.name)) == fn:toUpperCase(fn:trim(userData.nameEN))}">
												<c:set var="isDup" value="true" />
											</c:if>
										</c:if>

										<c:if test="${not isDup}">
											<c:if test="${not empty headerDisplay}">
												<c:set var="headerDisplay" value="${headerDisplay} - " />
											</c:if>
											<c:set var="headerDisplay"
												value="${headerDisplay}${fn:trim(userData.name)}" />
										</c:if>
									</c:if>

									<c:if test="${not empty userData.roleId}">
										<c:if test="${not empty headerDisplay}">
											<c:set var="headerDisplay" value="${headerDisplay} - " />
										</c:if>
										<c:set var="headerDisplay"
											value="${headerDisplay}${fn:trim(userData.roleId)}" />
									</c:if>

									${headerDisplay}
								</h3>

								<div class="d-flex flex-wrap gap-2 mb-2" style="height: 26px;">
									<c:forEach var="s" items="${siteList}">
										<span
											class="badge badge-lg badge-primary d-inline-flex align-items-center justify-content-center">
											${s['name_site']} </span>
									</c:forEach>
								</div>
							</div>

							<!-- START DATE -->
							<div class="card-toolbar d-flex flex-column align-items-end">
								<div class="d-flex flex-column">
									<span class="fw-medium text-gray-800 mb-2">Date</span>
									<div class="position-relative w-300px ">
										<i
											class="ki-duotone ki-calendar-8 w-20px h-20px d-inline-block text-gray-500 position-absolute top-50 start-0 translate-middle-y ms-4 "
											style="font-size: 20px; line-height: 20px;"> <span
											class="path1"></span> <span class="path2"></span> <span
											class="path3"></span> <span class="path4"></span> <span
											class="path5"></span> <span class="path6"></span>
										</i> <input type="text"
											class="form-control ps-14 h-55px cursor-default"
											id="jobsiteDatePicker" name="date" placeholder="Select date" />
									</div>
								</div>
							</div>
							<!-- END DATE -->
						</div>
					</div>
					<!-- END CARD USER -->

					<!-- START LOOP NAME SITE -->
					<c:forEach var="site" items="${siteList}">
						<div class="card mb-5 mb-xl-8">
							<div class="card-header border-0 pt-6 align-items-start">
								<div class="card-title pt-3">
									<h3 class="page-heading d-flex text-gray-900 fw-semibold my-0">
										${site['name_site']}</h3>
								</div>
							</div>

							<div class="card-body py-4 px-5">
								<table
									class="table align-middle table-striped table-hover table-row-bordered fs-6 table-jobsite">
									<thead>
										<tr
											class="text-start text-muted fw-bold fs-7 h-39px text-gray-500 text-uppercase gs-0"
											style="height: 39px;">
											<th style="width: 75px; min-width: 75px;" class="text-center">#</th>
											<th>Name</th>
											<th class="min-w-150px w-150px">Check-In</th>
											<th class="min-w-150px w-150px">Check-Out</th>
											<th style="width: 120px;">Status</th>
										</tr>
									</thead>

									<tbody>
										<c:set var="siteIdKey" value="${site['id_sitejob']}${''}" />
										<c:set var="members" value="${teamBySite[siteIdKey]}" />

										<c:forEach var="t" items="${members}" varStatus="st">
											<tr style="height: 52px;">
												<!-- Column 1: Row Number -->
												<td class="fw-bold fs-7 text-gray-900 text-center px-0">${st.count}</td>

												<td class="fw-normal fs-6 text-gray-900"><c:set
														var="displayTeam" value="" /> <c:if
														test="${not empty t.employee_id}">
														<c:set var="displayTeam" value="${t.employee_id}" />
													</c:if> <c:if test="${not empty t.name_en}">
														<c:if test="${not empty displayTeam}">
															<c:set var="displayTeam" value="${displayTeam} - " />
														</c:if>
														<c:set var="displayTeam"
															value="${displayTeam}${t.name_en}" />
													</c:if> <c:if test="${not empty t.name}">
														<c:set var="upperTH"
															value="${fn:toUpperCase(fn:trim(t.name))}" />
														<c:set var="upperEN"
															value="${fn:toUpperCase(fn:trim(t.name_en))}" />
														<c:if test="${upperTH != upperEN}">
															<c:if test="${not empty displayTeam}">
																<c:set var="displayTeam" value="${displayTeam} - " />
															</c:if>
															<c:set var="displayTeam" value="${displayTeam}${t.name}" />
														</c:if>
													</c:if> ${displayTeam}</td>

												<c:set var="isLeaveStatus"
													value="${t.status == 'WAITING' || 
			                                                 t.status == 'ANNUAL_LEAVE' || 
			                                                 t.status == 'BUSINESS_LEAVE' || 
			                                                 t.status == 'SICK_LEAVE' || 
			                                                 t.status == 'ABSENT' || 
			                                                 t.status == 'WITHOUT_PAY' || 
			                                                 t.status == 'ANNUAL_LEAVE_REMAINING' || 
			                                                 t.status == 'OTHER_LEAVE' || 
			                                                 t.status == 'OTHERS'}" />

												<td class="fw-bold fs-6 text-gray-800"><c:if
														test="${!isLeaveStatus && not empty t.check_in}">
														<div class="d-flex align-items-center">

															<c:choose>
																<c:when test="${t.check_in_type == '1'}">
																	<i class="ki-duotone ki-map text-primary me-2"
																		style="font-size: 20px;"> <span class="path1"></span><span
																		class="path2"></span><span class="path3"></span>
																	</i>
																</c:when>
																<c:when test="${t.check_in_type == '2'}">
																	<i class="ki-duotone ki-home-2 text-success me-2"
																		style="font-size: 20px;"> <span class="path1"></span><span
																		class="path2"></span>
																	</i>
																</c:when>
																<c:otherwise>
																	<i class="ki-duotone ki-cube-2 text-danger me-2"
																		style="font-size: 20px;"> <span class="path1"></span><span
																		class="path2"></span><span class="path3"></span>
																	</i>
																</c:otherwise>
															</c:choose>
															<span>${t.check_in}</span>
														</div>
													</c:if></td>

												<!-- Column 4: Check Out -->
												<td class="fw-bold fs-6 text-gray-800"><c:if
														test="${!isLeaveStatus && not empty t.check_out}">
														<div class="d-flex align-items-center">

															<c:choose>
																<c:when test="${t.check_out_type == '1'}">
																	<i class="ki-duotone ki-map text-primary me-2"
																		style="font-size: 20px;"> <span class="path1"></span><span
																		class="path2"></span><span class="path3"></span>
																	</i>
																</c:when>
																<c:when test="${t.check_out_type == '2'}">
																	<i class="ki-duotone ki-home-2 text-success me-2"
																		style="font-size: 20px;"> <span class="path1"></span><span
																		class="path2"></span>
																	</i>
																</c:when>
																<c:otherwise>
																	<i class="ki-duotone ki-cube-2 text-danger me-2"
																		style="font-size: 20px;"> <span class="path1"></span><span
																		class="path2"></span><span class="path3"></span>
																	</i>
																</c:otherwise>
															</c:choose>
															<span>${t.check_out}</span>
														</div>
													</c:if></td>

												<c:set var="statusIcon" value="" />
												<c:set var="badgeClass" value="badge-primary" />
												<c:set var="statusText" value="${t.status}" />
												
												<%-- <div style="background: yellow; color: black; padding: 5px; margin-bottom: 10px;">
												    Data for DEBUG -> Status: [${t.status}], Leave Desc: [${t.leave_desc}], approve status: [${t}]
												</div> --%>
												
												<c:set var="halfDayText" value="" />
													<c:if test="${not empty t.halfDay}">
													    <c:choose>
													        <c:when test="${t.halfDay == '0'}">
													            <c:set var="halfDayText" value=" : เต็มวัน" />
													        </c:when>
													        <c:when test="${t.halfDay == '1'}">
													            <c:set var="halfDayText" value=" : ช่วงเช้า" />
													        </c:when>
													        <c:when test="${t.halfDay == '2'}">
													            <c:set var="halfDayText" value=" : ช่วงบ่าย" />
													        </c:when>
													    </c:choose>
													</c:if>

												<c:choose>
													<c:when test="${t.status == 'ONTIME'}">
														<c:set var="badgeClass" value="badge-success" />
														<c:set var="statusText" value="Ontime" />
													</c:when>
													<c:when test="${t.status == 'LATE'}">
														<c:set var="badgeClass" value="badge-warning" />
														<c:set var="statusText" value="Late" />
													</c:when>
													<c:when test="${t.status == 'EARLY_OUT'}">
														<c:set var="badgeClass" value="badge-warning" />
														<c:set var="statusText" value="Early Out" />
													</c:when>
													<c:when test="${t.status == 'UNFINISHED_WORK'}">
														<c:set var="badgeClass" value="badge-warning" />
														<c:set var="statusText" value="Unfinished Work" />
													</c:when>
													<c:when test="${t.status == 'INCOMPLETE'}">
														<c:set var="badgeClass"
															value="badge bg-gray-800 text-white" />
														<c:set var="statusText" value="Incomplete" />
													</c:when>
													<c:when test="${t.status == 'NO_RECORD'}">
														<c:set var="badgeClass" value="badge-danger" />
														<c:set var="statusText" value="No Record" />
													</c:when>
													
													<%--  Approved Leaves --%>
													<c:when test="${t.status == 'SICK_LEAVE'}">
												        <c:set var="badgeClass" value="badge bg-purple text-white" />
												        <c:set var="statusText" value="ลาป่วย ${halfDayText}" />
												    </c:when>
												    <c:when test="${t.status == 'ANNUAL_LEAVE'}">
												        <c:set var="badgeClass" value="badge-primary" />
												        <c:set var="statusText" value="ลาพักร้อน ${halfDayText}" />
												    </c:when>
												    <c:when test="${t.status == 'BUSINESS_LEAVE'}">
												        <c:set var="badgeClass" value="badge-primary" />
												        <c:set var="statusText" value="ลากิจ ${halfDayText}" />
												    </c:when>
												    <c:when test="${t.status == 'OTHER_LEAVE' || t.status == 'OTHERS' || t.status == 'ANNUAL_LEAVE_REMAINING'}">
												        <c:set var="badgeClass" value="badge-primary" />
												        <c:set var="statusText" value="ลาอื่นๆ ${halfDayText}" />
												    </c:when>
													
												    <%-- Waiting Approved Leaves --%>
												    <c:when test="${t.status == 'WAITING'}">
												        <c:set var="statusIcon" value="ki-duotone ki-watch" />
												        <c:choose>
												            <c:when test="${fn:contains(t.leave_desc, 'ลาป่วย')}">
												                <c:set var="badgeClass" value="badge bg-purple text-white" />
												                <c:set var="statusText" value="ลาป่วย ${halfDayText}" />
												            </c:when>
												            <c:when test="${fn:contains(t.leave_desc, 'ลากิจ')}">
												                <c:set var="badgeClass" value="badge-primary" />
												                <c:set var="statusText" value="ลากิจ ${halfDayText}" />
												            </c:when>
												            <c:when test="${fn:contains(t.leave_desc, 'ลาพักร้อน')}">
												                <c:set var="badgeClass" value="badge-primary" />
												                <c:set var="statusText" value="ลาพักร้อน ${halfDayText}" />
												            </c:when>
												            <c:otherwise>
												                <c:set var="badgeClass" value="badge-primary" />
												                <c:set var="statusText" value="ลาอื่นๆ ${halfDayText}" />
												            </c:otherwise>
												        </c:choose>
												    </c:when>
												</c:choose>

												<td><span class="badge ${badgeClass} badge-lg"
													style="height: 26px;"> ${statusText} &nbsp;
														<c:if
															test="${not empty statusIcon}">
															<i class="${statusIcon} text-warning me-2"
																style="font-size: 16px;"> <span class="path1"></span>
																<span class="path2"></span>
															</i>
														</c:if>
												</span></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</c:forEach>
				</div>
				<!-- END LOOP NAME SITE -->
			</div>

		</div>
	</div>

	<!-- DATE -->
	<script>
		document.addEventListener("DOMContentLoaded", function() {
			const url = new URL(window.location.href);

			flatpickr("#jobsiteDatePicker", {
				dateFormat : "Y-m-d",

				altInput : true,

				altFormat : "j M Y",

				defaultDate : url.searchParams.get("date") || "today",
				maxDate : "today",
				allowInput : false,

				onChange : function(selectedDates, dateStr) {
					url.searchParams.set("date", dateStr);
					window.location.href = url.toString();
				}
			});
		});
	</script>

	<!-- DATA TABLE -->
	<script>
		$(document).ready(function() {
			$('.table-jobsite').DataTable({
				paging : true,
				lengthChange : true,
				lengthMenu : [ [ 10, 25, 50, -1 ], [ 10, 25, 50, "All" ] ],
				searching : false,
				info : false,
				autoWidth : false,
				order : [],

				language : {
					emptyTable : "No employee",
				},

				columnDefs : [ {
					targets : [ 0, 2, 3, 4 ],
					orderable : false
				}, {
					targets : 1,
					orderable : true
				} ],
			});
		});
	</script>

</body>
</html>