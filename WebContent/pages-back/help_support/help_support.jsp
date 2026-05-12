<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="perm" uri="/WEB-INF/tlds/permission.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:setLocale value="en_US" />

<style>
/* แสดงลูกศรเรียงลำดับเฉพาะคอลัมน์ที่อนุญาต */
#kt_support_table thead th.sorting::before, #kt_support_table thead th.sorting::after
	{
	opacity: 0.3 !important;
}

/* จัดแนวกล่อง dropdown เลือกจำนวน record */
.dataTables_wrapper .dataTables_length {
	margin: 0 !important;
}

.dataTables_wrapper .dataTables_length label {
	margin: 0 !important;
	padding: 0 !important;
}

#kt_scrolltop {
	display: none !important;
}
</style>
<perm:permission object="helpsupport.view">
	<div class="d-flex flex-column flex-column-fluid">
		<!-- Toolbar -->
		<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
			<div id="kt_app_toolbar_container"
				class="app-container container-fluid d-flex flex-stack">
				<div
					class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
					<h2
						class="page-heading d-flex text-gray-700 fw-semibold flex-column justify-content-center my-0">
						Help & Support</h2>
					<ul
						class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
						<li class="breadcrumb-item text-muted">Home</li>
					</ul>
				</div>
				<div class="d-flex align-items-center gap-2 gap-lg-3">
					<a href="${pageContext.request.contextPath}/help_support_add"
						class="btn btn-success"><i class="fa fa-plus pe-2"></i> Create</a>
				</div>
			</div>
		</div>

		<!-- Content -->
		<div class="app-content flex-column-fluid">
			<div class="app-container container-fluid">
				<!-- Card -->
				<div class="card">
					<div class="card-header border-0 pt-6 px-10 mb-5">
						<h3 class="card-title text-gray-800 fw-semibold fs-4">My
							Requests</h3>
					</div>
					<div class="card-body pt-0 px-10">
						<form id="filterForm" action="help_support" method="get">
							<!-- Filter Row -->
							<!-- Filter Row 1 -->
							<div class="row g-5 mb-5 align-items-center">
								<div class="col-md-9">
									<div class="input-group flex-nowrap">
										<span
											class="input-group-text bg-transparent border-end-0 h-45px">
											<i class="ki-duotone ki-magnifier fs-3"><span
												class="path1"></span><span class="path2"></span></i>
										</span>
										<div class="flex-grow-1">
											<select name="searchText" id="userSelect"
												class="form-select rounded-start-0 border-start-0 h-45px"
												data-control="select2" data-placeholder="Search"
												data-allow-clear="true">
												<option></option>
												<option value="">All</option>
												<optgroup label="Enable">
													<c:forEach var="user" items="${userList}">
														<c:if
															test="${user.enable == 1 && user.flag_search == '1'}">
															<c:set var="displayText" value="" />
															<!-- ถ้ามี employee_id -->
															<c:if test="${not empty user.employee_id}">
																<c:set var="displayText" value="${user.employee_id}" />
															</c:if>
															<!-- name_en -->
															<c:if test="${not empty user.name_en}">
																<c:set var="displayText"
																	value="${displayText}${not empty displayText ? ' - ' : ''}${user.name_en}" />
															</c:if>
															<!-- name -->
															<c:if test="${not empty user.name}">
																<c:set var="displayText"
																	value="${displayText}${not empty displayText ? ' - ' : ''}${user.name}" />
															</c:if>
															<option value="${fn:trim(user.id)}"
																${searchText eq fn:trim(user.id) ? 'selected' : '' }>${displayText}</option>
														</c:if>
													</c:forEach>
												</optgroup>
												<optgroup label="Disable">
													<c:forEach var="user" items="${userList}">
														<c:if
															test="${user.enable == 0 && user.flag_search == '1'}">
															<c:set var="displayText" value="" />
															<!-- ถ้ามี employee_id -->
															<c:if test="${not empty user.employee_id}">
																<c:set var="displayText" value="${user.employee_id}" />
															</c:if>
															<!-- name_en -->
															<c:if test="${not empty user.name_en}">
																<c:set var="displayText"
																	value="${displayText}${not empty displayText ? ' - ' : ''}${user.name_en}" />
															</c:if>
															<!-- name -->
															<c:if test="${not empty user.name}">
																<c:set var="displayText"
																	value="${displayText}${not empty displayText ? ' - ' : ''}${user.name}" />
															</c:if>
															<option value="${fn:trim(user.id)}"
																${searchText eq fn:trim(user.id) ? 'selected' : '' }>${displayText}</option>
														</c:if>
													</c:forEach>
												</optgroup>
											</select>
										</div>
									</div>
								</div>
								<div class="col-md-3">
									<div class="position-relative w-100">
										<i
											class="ki-duotone ki-calendar-8 w-20px h-20px d-inline-block text-gray-500 position-absolute top-50 start-0 translate-middle-y ms-4"
											style="font-size: 20px; line-height: 20px;"> <span
											class="path1"></span><span class="path2"></span><span
											class="path3"></span> <span class="path4"></span><span
											class="path5"></span><span class="path6"></span>
										</i> <input type="text"
											class="form-control ps-14 h-45px cursor-pointer fw-medium text-gray-700 bg-white"
											id="supportRangePicker" placeholder="Select date range"
											readonly autocomplete="off" /> <input type="hidden"
											name="startDate" id="startDate" value="${startDate}">
										<input type="hidden" name="endDate" id="endDate"
											value="${endDate}">
									</div>
								</div>
							</div>

							<!-- Filter Row 2 -->
							<div class="row g-5 mb-10 align-items-end">
								<div class="col-lg">
									<label class="form-label fs-7 fw-semibold text-gray-800">Status:</label>
									<div class="dropdown">
										<button
											class="form-select form-select-solid text-start bg-white border border-gray-300"
											type="button" data-bs-toggle="dropdown" aria-expanded="false"
											data-bs-auto-close="outside">
											<span id="statusLabel"
												class="text-gray-700 fw-semibold d-inline-block text-truncate"
												style="max-width: 150px;">All Status</span>
										</button>
										<div class="dropdown-menu p-5 shadow rounded"
											style="min-width: 300px;">
											<div class="d-flex flex-column gap-3 mb-4">
												<div class="form-check form-check-custom form-check-solid">
													<input class="form-check-input status-checkbox"
														name="status" type="checkbox" value="New"
														id="chk-status-1"
														<s:if
																		test="#request.selectedStatus == null || #request.selectedStatus.contains('New')">checked
																	</s:if> />
													<label
														class="form-check-label text-gray-800 fw-semibold cursor-pointer"
														for="chk-status-1"> New </label>
												</div>
												<div class="form-check form-check-custom form-check-solid">
													<input class="form-check-input status-checkbox"
														name="status" type="checkbox" value="In Progress"
														id="chk-status-2"
														<s:if
																		test="#request.selectedStatus == null || #request.selectedStatus.contains('In Progress')">checked
																	</s:if> />
													<label
														class="form-check-label text-gray-800 fw-semibold cursor-pointer"
														for="chk-status-2"> In Progress </label>
												</div>
												<div class="form-check form-check-custom form-check-solid">
													<input class="form-check-input status-checkbox"
														name="status" type="checkbox" value="Resolved"
														id="chk-status-3"
														<s:if
																		test="#request.selectedStatus == null || #request.selectedStatus.contains('Resolved')">checked
																	</s:if> />
													<label
														class="form-check-label text-gray-800 fw-semibold cursor-pointer"
														for="chk-status-3"> Resolved </label>
												</div>
												<div class="form-check form-check-custom form-check-solid">
													<input class="form-check-input status-checkbox"
														name="status" type="checkbox" value="Closed"
														id="chk-status-4"
														<s:if
																		test="#request.selectedStatus == null || #request.selectedStatus.contains('Closed')">checked
																	</s:if> />
													<label
														class="form-check-label text-gray-800 fw-semibold cursor-pointer"
														for="chk-status-4"> Closed </label>
												</div>
											</div>
											<div class="separator mb-4 border-gray-200"></div>
											<div class="d-flex gap-2">
												<button type="button"
													class="btn btn-light btn-sm flex-fill fw-semibold deselect-all-status">Deselect
													All</button>
												<button type="button"
													class="btn btn-primary btn-sm flex-fill fw-semibold select-all-status">Select
													All</button>
											</div>
										</div>
									</div>
								</div>
								<div class="col-lg">
									<label class="form-label fs-7 fw-semibold text-gray-800">Categorized:</label>
									<div class="dropdown">
										<button
											class="form-select form-select-solid text-start bg-white border border-gray-300"
											type="button" data-bs-toggle="dropdown" aria-expanded="false"
											data-bs-auto-close="outside">
											<span id="categorizedLabel"
												class="text-gray-700 fw-semibold d-inline-block text-truncate"
												style="max-width: 150px;">All Type</span>
										</button>
										<div class="dropdown-menu p-5 shadow rounded"
											style="min-width: 300px;">
											<div class="d-flex flex-column gap-3 mb-4">
												<div class="form-check form-check-custom form-check-solid">
													<input class="form-check-input categorized-checkbox"
														name="categorized" type="checkbox" value="Technical Issue"
														id="chk-cat-1"
														<s:if
																		test="#request.selectedCategorized == null || #request.selectedCategorized.contains('Technical Issue')">checked
																	</s:if> />
													<label
														class="form-check-label text-gray-800 fw-semibold cursor-pointer"
														for="chk-cat-1"> Technical Issue </label>
												</div>
												<div class="form-check form-check-custom form-check-solid">
													<input class="form-check-input categorized-checkbox"
														name="categorized" type="checkbox"
														value="Inquiry / Question" id="chk-cat-2"
														<s:if
																		test="#request.selectedCategorized == null || #request.selectedCategorized.contains('Inquiry / Question')">checked
																	</s:if> />
													<label
														class="form-check-label text-gray-800 fw-semibold cursor-pointer"
														for="chk-cat-2"> Inquiry / Question </label>
												</div>
												<div class="form-check form-check-custom form-check-solid">
													<input class="form-check-input categorized-checkbox"
														name="categorized" type="checkbox" value="Feature Request"
														id="chk-cat-3"
														<s:if
																		test="#request.selectedCategorized == null || #request.selectedCategorized.contains('Feature Request')">checked
																	</s:if> />
													<label
														class="form-check-label text-gray-800 fw-semibold cursor-pointer"
														for="chk-cat-3"> Feature Request </label>
												</div>
											</div>
											<div class="separator mb-4 border-gray-200"></div>
											<div class="d-flex gap-2">
												<button type="button"
													class="btn btn-light btn-sm flex-fill fw-semibold deselect-all-categorized">Deselect
													All</button>
												<button type="button"
													class="btn btn-primary btn-sm flex-fill fw-semibold select-all-categorized">Select
													All</button>
											</div>
										</div>
									</div>
								</div>
								<div class="col-lg">
									<label class="form-label fs-7 fw-semibold text-gray-800">Menu</label>
									<div class="dropdown">
										<button
											class="form-select form-select-solid text-start bg-white border border-gray-300"
											type="button" data-bs-toggle="dropdown" aria-expanded="false"
											data-bs-auto-close="outside">
											<span id="menuLabel"
												class="text-gray-700 fw-semibold d-inline-block text-truncate"
												style="max-width: 150px;">All Menu</span>
										</button>
										<div class="dropdown-menu p-5 shadow rounded"
											style="min-width: 300px;">
											<div class="d-flex flex-column gap-3 mb-4">
												<s:iterator value="#request.menuList" status="stat">
													<div class="form-check form-check-custom form-check-solid">
														<input class="form-check-input menu-checkbox"
															name="supportMenuId" type="checkbox"
															value="<s:property value='supportMenuId'/>"
															id="chk-menu-<s:property value='#stat.index'/>"
															<s:if
																			test="#request.selectedSupportMenuId == null || #request.selectedSupportMenuId.contains(supportMenuId.toString())">checked
																		</s:if> />
														<label
															class="form-check-label text-gray-800 fw-semibold cursor-pointer"
															for="chk-menu-<s:property value='#stat.index'/>">
															<s:property value="menuName" />
														</label>
													</div>
												</s:iterator>
											</div>
											<div class="separator mb-4 border-gray-200"></div>
											<div class="d-flex gap-2">
												<button type="button"
													class="btn btn-light btn-sm flex-fill fw-semibold deselect-all-menu">Deselect
													All</button>
												<button type="button"
													class="btn btn-primary btn-sm flex-fill fw-semibold select-all-menu">Select
													All</button>
											</div>
										</div>
									</div>
								</div>
								<div class="col-lg-auto">
									<button type="submit"
										class="btn btn-primary text-nowrap justify-content-center">Search</button>
								</div>
							</div>
						</form>

						<!-- Statistics -->
						<div
							class="mb-5 border border-dashed border-gray-300 rounded-3 py-8 px-5">
							<div class="d-flex justify-content-evenly flex-wrap gap-5">
								<div class="text-center" style="max-width: 250px;">
									<div
										class="d-flex align-items-center justify-content-center mb-3">
										<div class="fs-2hx fw-bolder text-warning me-6">
											${countPending !=
															null ?
															countPending : 0}</div>
										<div class="badge badge-light-warning fw-bold fs-7 px-2 py-2">
											New</div>
									</div>
									<div class="text-gray-900 fs-6">
										รายการส่งสำเร็จ<br />อยู่ระหว่างรอเจ้าหน้าที่รับเรื่อง
									</div>
								</div>
								<div class="text-center" style="max-width: 250px;">
									<div
										class="d-flex align-items-center justify-content-center mb-3">
										<div class="fs-2hx fw-bolder text-primary me-6">
											${countInProgress !=
															null ? countInProgress : 0}</div>
										<div class="badge badge-light-primary fw-bold fs-7 px-2 py-2">
											In Progress</div>
									</div>
									<div class="text-gray-900 fs-6">
										เจ้าหน้าที่กำลังตรวจสอบ<br />หรือแก้ไขปัญหาของท่าน
									</div>
								</div>
								<div class="text-center" style="max-width: 250px;">
									<div
										class="d-flex align-items-center justify-content-center mb-3">
										<div class="fs-2hx fw-bolder text-success me-6">
											${countResolved !=
															null
															? countResolved : 0}</div>
										<div class="badge badge-light-success fw-bold fs-7 px-2 py-2">
											Resolved</div>
									</div>
									<div class="text-gray-900 fs-6">
										ดำเนินการเรียบร้อยแล้ว<br />โปรดตรวจสอบและยืนยันการปิดงาน
									</div>
								</div>
								<div class="text-center" style="max-width: 250px;">
									<div
										class="d-flex align-items-center justify-content-center mb-3">
										<div class="fs-2hx fw-bolder text-dark me-6">${countClosed
															!= null ?
															countClosed : 0}</div>
										<div
											class="badge badge-light-dark fw-bold text-dark fs-7 px-2 py-2">
											Closed</div>
									</div>
									<div class="text-gray-900 fs-6">
										รายการเสร็จสมบูรณ์<br />และถูกจัดเก็บเข้าประวัติแล้ว
									</div>
								</div>
							</div>
						</div>

						<!-- Warning Note Box -->
						<div class="border border-danger rounded p-4 mb-10 text-center">
							<span class="text-gray-800"><span
								class="text-danger fw-bold">หมายเหตุ :</span> หากอยู่ในสถานะ <span
								class="badge badge-light-success fw-bold mx-1">Resolved</span>
								และไม่ได้รับการยืนยันภายใน 5 วันจะปรับสถานะเป็น <span
								class="badge badge-light-danger fw-bold mx-1">Closed</span>
								อัตโนมัติ หากมีปัญหาเพิ่มกรุณาสร้างรายการเข้ามาในระบบอีกครั้ง</span>
						</div>

						<!-- Table -->
						<div class="table-responsive">
							<table id="kt_support_table"
								class="table table-striped align-middle table-row-dashed fs-6 gy-5">
								<thead>
									<tr
										class="text-start text-gray-600 fw-bold fs-7 text-uppercase text-nowrap">
										<th class="min-w-50px ps-9 pe-2">ID</th>
										<th class="min-w-100px pe-2">REQUESTS</th>
										<th class="min-w-100px pe-2">CATEGORIZED</th>
										<th class="min-w-100px pe-2">MENU</th>
										<th class="min-w-165px pe-2">MESSAGE</th>
										<th class="min-w-60px pe-2">STATUS</th>
										<th class="min-w-75px pe-9">ACTION</th>
									</tr>
								</thead>
								<tbody class="text-gray-600 fw-normal fs-6">
									<s:iterator value="#request.supportList">
										<tr>
											<td class="text-gray-800 fw-bold align-middle ps-9"><s:property
													value="supportId" /></td>
											<td class="text-gray-800 align-middle fs-6"
												data-order='<fmt:formatDate value="${timeCreate}" pattern="yyyyMMddHHmmss" />'>
												<div>
													<s:property
														value="userCreate != null ? (#request.userMap[userCreate.trim()] != null ? #request.userMap[userCreate.trim()] : userCreate) : ''" />
												</div>
												<div class="text-gray-800">
													<fmt:formatDate value="${timeCreate}"
														pattern="d MMM yyyy , H:mm" />
												</div>
											</td>
											<td class="align-middle">
												<div class="d-flex align-items-center">
													<s:if test="categorized == 'Technical Issue'">
														<i
															class="ki-duotone ki-information-5 fs-1 text-danger me-3"><span
															class="path1"></span><span class="path2"></span><span
															class="path3"></span></i>
													</s:if>
													<s:elseif test="categorized == 'Inquiry / Question'">
														<i class="ki-duotone ki-question-2 fs-1 me-3"
															style="color: #A11EBA;"><span class="path1"></span><span
															class="path2"></span><span class="path3"></span></i>
													</s:elseif>
													<s:else>
														<i class="ki-duotone ki-like-tag fs-1 text-primary me-3"><span
															class="path1"></span><span class="path2"></span><span
															class="path3"></span></i>
													</s:else>
													<span class="text-gray-800"> <s:property
															value="categorized" />
													</span>
												</div>
											</td>
											<td class="text-gray-800 align-middle"><s:if
													test="supportMenuId != null && #request.menuMap[supportMenuId] != null">
													<s:property value="#request.menuMap[supportMenuId]" />
												</s:if> <s:else>
													<span class="text-muted"> <s:property
															value="supportMenuId" />
													</span>
												</s:else></td>
											<td class="text-gray-800 align-middle">
												<div class="text-truncate" style="max-width: 250px;"
													title="<s:property value='#request.messageMap[supportId]'/>">
													<s:property value="#request.messageMap[supportId]" />
												</div>
											</td>

											<s:set var="sortOrder" value="4" />
											<s:if test="status == 'Pending' || status == 'New'">
												<s:set var="sortOrder" value="1" />
											</s:if>
											<s:elseif test="status == 'In Progress'">
												<s:set var="sortOrder" value="2" />
											</s:elseif>
											<s:elseif test="status == 'Resolved'">
												<s:set var="sortOrder" value="3" />
											</s:elseif>

											<td class="align-middle"
												data-order="<s:property value='#sortOrder'/>"><s:if
													test="status == 'Pending' || status == 'New'">
													<span
														class="badge badge-light-warning fw-bold fs-7 px-2 py-2">New</span>
												</s:if> <s:elseif test="status == 'In Progress'">
													<span
														class="badge badge-light-primary fw-bold fs-7 px-2 py-2">In
														Progress</span>
												</s:elseif> <s:elseif test="status == 'Resolved'">
													<span
														class="badge badge-light-success fw-bold fs-7 px-2 py-2">Resolved</span>
												</s:elseif> <s:else>
													<span
														class="badge badge-light-dark text-dark fw-bold fs-7 px-2 py-2">Closed</span>
												</s:else></td>
											<td class="text-end align-middle pe-9 text-nowrap"><a
												href="help_support_edit?supportId=<s:property value='supportId'/>"
												class="btn btn-icon btn-light-primary btn-sm me-1"> <i
													class="ki-duotone ki-document fs-4"><span class="path1"></span><span
														class="path2"></span><span class="path3"></span><span
														class="path4"></span><span class="path5"></span></i>
											</a> <s:if
													test="status == 'New' && ( (userCreate != null && userCreate.trim() == #session.onlineUser.id) || (#session.userAuthority != null && #session.userAuthority.contains('helpsupport.manage')) )">
													<button type="button"
														onclick="confirmDelete('<s:property value="
																		supportId" />')"
														class="btn btn-icon btn-light-danger btn-sm">
														<i class="ki-duotone ki-trash fs-4"><span
															class="path1"></span><span class="path2"></span><span
															class="path3"></span><span class="path4"></span><span
															class="path5"></span></i>
													</button>
												</s:if> <s:else>
													<button type="button" disabled class="btn btn-icon btn-sm"
														style="background-color: #f1f1f4; cursor: not-allowed;"
														title="ไม่สามารถลบได้">
														<i class="ki-duotone ki-trash fs-4 text-gray-400"><span
															class="path1"></span><span class="path2"></span><span
															class="path3"></span><span class="path4"></span><span
															class="path5"></span></i>
													</button>
												</s:else></td>
										</tr>
									</s:iterator>
								</tbody>
							</table>
						</div>

						<!-- Pagination is handled by DataTables automatically -->
					</div>
					<!-- End of card-body -->
				</div>
				<!-- End of card -->
			</div>
			<!-- End of app-container -->
		</div>
		<!-- End of app-content -->
	</div>
	<!-- End of flex-column -->
	<script
		src="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.js"></script>
	<script>
// ประกาศตัวแปร table ไว้ด้านนอก
var table;

// สร้าง Function สำหรับ Initial DataTables
function initDataTable() {
    return $('#kt_support_table').DataTable({
        "pageLength": 10,
        "lengthMenu": [
            [10, 25, 50, -1],
            [10, 25, 50, "All"]
        ],
        "language": {
            "lengthMenu": "_MENU_",
        },
        "order": [[5, 'asc']], // เรียงตาม Status เป็นอันดับแรก
        "columnDefs": [{
            "orderable": false,
            "targets": [6] // ปิดเรียงลำดับคอลัมน์ ACTION
        }],
        "dom": "<'row'<'col-sm-12 table-responsive'tr>>" +
               "<'row align-items-center mt-5'<'col-sm-12 col-md-5 d-flex align-items-center justify-content-center justify-content-md-start gap-3'l><'col-sm-12 col-md-7 d-flex align-items-center justify-content-center justify-content-md-end'p>>"
    });
}

$(document).ready(function () {
    // 1. เรียกใช้งานตอนโหลดหน้าครั้งแรก
    table = initDataTable();

    // 2. ดักจับการ Submit ของฟอร์ม (เมื่อกดปุ่ม Search)
    $('#filterForm').on('submit', function (e) {
        e.preventDefault(); // ป้องกันการเปลี่ยนหน้า

        var form = $(this);
        var submitBtn = form.find('button[type="submit"]');
        
        // ปิดปุ่มชั่วคราวกันกดรัวๆ
        submitBtn.prop('disabled', true).text('Search');

        $.ajax({
            url: form.attr('action'),
            type: form.attr('method'),
            data: form.serialize(),
            success: function (response) {
                // แปลงผลลัพธ์เป็น HTML
                var responseHtml = $($.parseHTML(response));

                // ดึงเฉพาะข้อมูล <tbody> ของตารางมาอัปเดต
                var newTableBody = responseHtml.find('#kt_support_table tbody').html();
                
                table.destroy(); // คืนค่า DataTables กลับเป็นตารางปกติก่อน
                $('#kt_support_table tbody').html(newTableBody); // แทนที่ข้อมูลในตาราง
                table = initDataTable(); // Initial DataTables ใหม่อีกครั้ง
            },
            error: function () {
                Swal.fire({
                    text: "เกิดข้อผิดพลาดในการดึงข้อมูล",
                    icon: "error",
                    buttonsStyling: false,
                    confirmButtonText: "Ok",
                    customClass: { confirmButton: "btn fw-bold btn-primary" }
                });
            },
            complete: function() {
                // เปิดปุ่มให้กดได้ปกติ
                submitBtn.prop('disabled', false).text('Search');
            }
        });
    });

									// --- Filter Labels Update Logic ---
									function updateLabel(checkboxClass, labelId, defaultText) {
										var selected = [];
										$(checkboxClass + ':checked').each(function () {
											selected.push($(this).next('label').text().trim());
										});
										var labelText = selected.length > 0 ? selected.join(', ') : defaultText;
										$(labelId).text(labelText).attr('title', labelText);
									}

									function updateAllLabels() {
										updateLabel('.status-checkbox', '#statusLabel', 'All Status');
										updateLabel('.categorized-checkbox', '#categorizedLabel', 'All Type');
										updateLabel('.menu-checkbox', '#menuLabel', 'All Menu');
									}

									// Listen for changes
									$('.status-checkbox, .categorized-checkbox, .menu-checkbox').on('change', updateAllLabels);

									// Initial call on page load
									updateAllLabels();

									// Bind Select All / Deselect All to update labels too
									$('.select-all-status, .deselect-all-status, .select-all-categorized, .deselect-all-categorized, .select-all-menu, .deselect-all-menu').on('click', function() {
										setTimeout(updateAllLabels, 50); // Small delay to ensure prop('checked') is updated
									});
									// ----------------------------------

									// Any basic UI initialization can go here if required by the template

									// Select All / Deselect All for Status
									$('.select-all-status').click(function (e) {
										e.stopPropagation();
										$('.status-checkbox').prop('checked', true);
									});
									$('.deselect-all-status').click(function (e) {
										e.stopPropagation();
										$('.status-checkbox').prop('checked', false);
									});

									// Select All / Deselect All for Categorized
									$('.select-all-categorized').click(function (e) {
										e.stopPropagation();
										$('.categorized-checkbox').prop('checked', true);
									});
									$('.deselect-all-categorized').click(function (e) {
										e.stopPropagation();
										$('.categorized-checkbox').prop('checked', false);
									});

									// Select All / Deselect All for Menu
									$('.select-all-menu').click(function (e) {
										e.stopPropagation();
										$('.menu-checkbox').prop('checked', true);
									});
									$('.deselect-all-menu').click(function (e) {
										e.stopPropagation();
										$('.menu-checkbox').prop('checked', false);
									});

									// Date Range Picker using flatpickr (Single Window Range)
									var startVal = "${startDate}";
									var endVal = "${endDate}";
									
									var defaultDateArr = [];
									if (startVal && endVal) {
										var s = moment(startVal, "DD-MM-YYYY");
										var e = moment(endVal, "DD-MM-YYYY");
										if (s.isValid() && e.isValid()) {
											defaultDateArr = [s.toDate(), e.toDate()];
										}
									}

									flatpickr("#supportRangePicker", {
										mode: "range",
										dateFormat: "d M Y",
										defaultDate: defaultDateArr,
										onReady: function(selectedDates, dateStr, instance) {
											var wrapper = instance.currentYearElement.parentNode;
											var monthHeader = wrapper.parentNode;
											
											var select = document.createElement("select");
											select.className = "flatpickr-monthDropdown-months";
											select.style.width = "auto";
											select.style.marginLeft = "5px";
											select.style.display = "inline-block";
											select.style.backgroundColor = "transparent";
											select.style.border = "none";
											select.style.cursor = "pointer";
											
											var currentYear = new Date().getFullYear();
											for (var i = currentYear; i >= currentYear - 30; i--) {
												var option = document.createElement("option");
												option.value = i;
												option.text = i;
												select.appendChild(option);
											}
											
											select.value = instance.currentYear;
											
											select.addEventListener("change", function(e) {
												instance.changeYear(parseInt(e.target.value));
											});
											
											wrapper.style.display = "none";
											monthHeader.appendChild(select);
											instance.yearSelectDropdown = select;

											// Add Apply/Clear buttons
											var btnContainer = document.createElement("div");
											btnContainer.className = "d-flex justify-content-between px-4 py-3 border-top mt-2";
											
											var clearBtn = document.createElement("button");
											clearBtn.type = "button";
											clearBtn.className = "btn btn-sm btn-light fw-bold px-5";
											clearBtn.innerHTML = "Clear";
											
											var applyBtn = document.createElement("button");
											applyBtn.type = "button";
											applyBtn.className = "btn btn-sm btn-primary fw-bold px-5";
											applyBtn.innerHTML = "Apply";
											
											clearBtn.addEventListener("click", function(e) {
												e.preventDefault();
												instance.clear();
												instance.close();
											});
											
											applyBtn.addEventListener("click", function(e) {
												e.preventDefault();
												instance.close();
											});
											
											btnContainer.appendChild(clearBtn);
											btnContainer.appendChild(applyBtn);
											
											instance.calendarContainer.appendChild(btnContainer);
										},
										onYearChange: function(selectedDates, dateStr, instance) {
											if (instance.yearSelectDropdown) {
												instance.yearSelectDropdown.value = instance.currentYear;
											}
										},
										onClose: function(selectedDates, dateStr, instance) {
											if (selectedDates.length === 2) {
												var s = moment(selectedDates[0]).format('DD-MM-YYYY');
												var e = moment(selectedDates[1]).format('DD-MM-YYYY');
												$("#startDate").val(s);
												$("#endDate").val(e);
												$("#filterForm").submit();
											} else if (selectedDates.length === 0) {
												$("#startDate").val("");
												$("#endDate").val("");
												$("#filterForm").submit();
											}
										}
									});

								});

						function confirmDelete(id) {
							Swal.fire({
								text: "Are you sure you want to delete this request?",
								icon: "warning",
								showCancelButton: true,
								buttonsStyling: false,
								confirmButtonText: "Yes, delete!",
								cancelButtonText: "No, cancel",
								customClass: {
									confirmButton: "btn fw-bold btn-danger",
									cancelButton: "btn fw-bold btn-active-light-primary"
								}
							}).then(function (result) {
								if (result.value) {
									window.location.href = "help_support_delete?supportId=" + id;
								}
							});
						}
					</script>
</perm:permission>