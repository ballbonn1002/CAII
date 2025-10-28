<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
// ป้องกัน NullPointer ถ้าไม่มี param.year
String yearParam = request.getParameter("year");
%>
<html>
<head>
<meta charset="UTF-8" />
<title>User Profile</title>

<!-- Metronic core -->
<!-- 1) Core CSS ของปลั๊กอิน -->
<link
	href="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.css"
	rel="stylesheet" />

<!-- 2) CSS หลักของธีม (มี KeenIcons อยู่ในนี้) -->
<link
	href="${pageContext.request.contextPath}/assets/css/style.bundle.css"
	rel="stylesheet" />

<!-- 3) Core JS ของปลั๊กอิน (Bootstrap, menus, ฯลฯ) -->
<script
	src="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.js"></script>

<!-- 4) JS หลักของธีม (จำเป็นต่อพวกเมนู/tooltip ของ Metronic) -->
<script
	src="${pageContext.request.contextPath}/assets/js/scripts.bundle.js"></script>


<!-- DataTables (Metronic bundle) -->
<link
	href="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.css"
	rel="stylesheet" type="text/css" />
<script
	src="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.js"></script>
<style type="text/css">
/* ========== Layout / Table ========== */
.app-container.container-xxl { max-width: 1280px; }

.card-footer { border-top: 0 !important; background: transparent !important; margin-top: 0; }
.table { border-bottom: 0 !important; }

/* ========== Pagination ========== */
#tablePagination .pagination { margin: 0; gap: .25rem; }
#tablePagination .page-link{
  border: 0; background: transparent; color: var(--bs-gray-500); font-weight: 600;
  min-width: 2rem; height: 2rem; padding: 0 .5rem; display: inline-flex; align-items: center;
  justify-content: center; border-radius: .5rem;
}
#tablePagination .page-item.active .page-link { background: var(--bs-primary); color: #fff; }
#tablePagination .page-item.disabled .page-link { opacity: .45; cursor: default; }
#tablePagination .page-link:hover { background: rgba(var(--bs-primary-rgb), .08); color: var(--bs-primary); }

/* ========== Notes (Birthday / Anniversary) ========== */
.anniv-note, .bday-note { color: #e35d6a; font-weight: 600; font-size: .85rem; margin-top: .15rem; }

/* ========== Filter/Search card & controls ========== */
.filter-card { margin-bottom: 1.5rem; }        /* ใช้ตัวเดียวพอ */
.tools-row { margin-top: .25rem !important; }  /* ถ้ามีใช้งาน */
.user-search-wrap .search-icon { left: .9rem; }

.btn-filter-pill{
  background: var(--bs-primary-bg-subtle); color: var(--bs-primary);
  border: 0; border-radius: .75rem; height: 48px; width: 48px;
  display: inline-flex; align-items: center; justify-content: center;
}
.btn-filter-pill:hover { filter: brightness(.98); }
.btn-filter-pill.active{ background: var(--bs-primary); color: #fff; }
[data-theme="dark"] .btn-filter-pill.active{ background: var(--bs-primary); color: #fff; }

/* ========== Select2 (Bootstrap-5 skin) ========== */
.select2-container--bootstrap-5 .select2-selection--single{
  height: 48px; border-radius: .65rem;
  padding: .7rem 2.6rem .7rem .9rem;   /* เผื่อพื้นที่ปุ่ม x ด้านขวา */
}
/* ซ่อนลูกศร dropdown เพื่อไม่ชนปุ่ม clear */
.select2-container--bootstrap-5 .select2-selection__arrow{ display: none !important; }
/* ปุ่ม clear (x) */
.select2-container--bootstrap-5 .select2-selection__clear{
  position: absolute; right: .7rem; top: 50%; transform: translateY(-50%);
  margin: 0; opacity: .75;
}
.select2-container--bootstrap-5 .select2-selection__clear:hover{ opacity: 1; }
/* option highlight */
.select2-container--bootstrap-5 .select2-results__option--highlighted{
  background: var(--bs-primary-bg-subtle); color: var(--bs-primary);
}
/* ให้ dropdown ลอยเหนือการ์ด */
.select2-container.select2-container--open{ z-index: 1061; }

/* --- Dark theme (อ่านง่าย) --- */
[data-theme="dark"] .select2-container--bootstrap-5 .select2-selection--single{
  background-color: var(--bs-gray-900); border-color: var(--bs-gray-700); color: var(--bs-gray-200);
}
[data-theme="dark"] .select2-container--bootstrap-5 .select2-selection__rendered{ color: var(--bs-gray-200); }
[data-theme="dark"] .select2-container--bootstrap-5 .select2-dropdown{
  background-color: var(--bs-gray-900); border-color: var(--bs-gray-700);
}
[data-theme="dark"] .select2-container--bootstrap-5 .select2-search__field{
  background-color: var(--bs-gray-900); color: var(--bs-gray-200); border-color: var(--bs-gray-700);
}
[data-theme="dark"] .select2-container--bootstrap-5 .select2-results__option{ color: var(--bs-gray-200); }
[data-theme="dark"] .select2-container--bootstrap-5 .select2-results__option--highlighted{
  background: var(--bs-primary-bg-subtle); color: var(--bs-primary);
}

/* ========== Period column (2 บรรทัด) ========== */
.period-dates{ font-weight: 600; line-height: 1.2; }
.period-len{ color: var(--bs-gray-600); margin-top: .25rem; }
[data-theme="dark"] .period-len{ color: var(--bs-gray-500); }

/* ===== Select2: ปรับช่องค้นหาให้มีไอคอน + อ่านง่าย ===== */

/* ขนาดตัวอักษรและคอนทราสต์ของรายการ */
.select2-container--bootstrap-5 .select2-results__option{
  font-size: .95rem;
  color: var(--bs-gray-800);
}
.select2-container--bootstrap-5 .select2-results__option[aria-selected="true"]{
  background: var(--bs-primary-bg-subtle);
  color: var(--bs-primary);
}
.select2-container--bootstrap-5 .select2-results__option--highlighted{
  background: var(--bs-primary);
  color: #fff;
}

/* ปรับ label ของ optgroup ให้อ่านง่าย */
.select2-container--bootstrap-5 .select2-results__group{
  color: var(--bs-gray-600);
  font-weight: 700;
  padding: .35rem .75rem;
}

/* ช่องค้นหาใน dropdown: ใส่ไอคอนแว่นขยาย + ระยะห่าง */
.select2-container--bootstrap-5 .select2-search--dropdown{
  position: relative;
  padding: .5rem .5rem 0 .5rem;
}
.select2-container--bootstrap-5 .select2-search--dropdown::before{
  content: "";
  position: absolute;
  left: 1rem;
  top: .95rem;
  width: 1rem; height: 1rem;
  background-repeat: no-repeat;
  background-size: 100% 100%;
  filter: opacity(.65);
  /* inline SVG ไอคอนแว่น */
  background-image: url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'><path fill='%2399A1B7' d='M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.867-3.834zM12 6.5a5.5 5.5 0 1 1-11 0a5.5 5.5 0 0 1 11 0z'/></svg>");
}
.select2-container--bootstrap-5 .select2-search--dropdown .select2-search__field{
  padding-left: 2.25rem;   /* เว้นที่ให้ไอคอน */
  height: 40px;
  border-radius: .5rem;
}

/* ทำให้ค่าในแถบเลือก (selection) คอนทราสต์ชัด */
.select2-container--bootstrap-5 .select2-selection--single .select2-selection__rendered{
  color: var(--bs-gray-900);
  font-weight: 600;
}

/* ซ่อน arrow เพื่อไม่ชนปุ่ม clear */
.select2-container--bootstrap-5 .select2-selection__arrow{ display:none !important; }

/* ===== โหมดมืด (ครอบคลุม html/body ที่ตั้ง data-theme) ===== */
html[data-theme="dark"] .select2-container--bootstrap-5 .select2-dropdown,
body[data-theme="dark"] .select2-container--bootstrap-5 .select2-dropdown{
  background-color: var(--bs-gray-900);
  border-color: var(--bs-gray-700);
}
html[data-theme="dark"] .select2-container--bootstrap-5 .select2-search__field,
body[data-theme="dark"] .select2-container--bootstrap-5 .select2-search__field{
  background-color: var(--bs-gray-900);
  color: var(--bs-gray-100);
  border-color: var(--bs-gray-700);
}
html[data-theme="dark"] .select2-container--bootstrap-5 .select2-results__option,
body[data-theme="dark"] .select2-container--bootstrap-5 .select2-results__option{
  color: var(--bs-gray-100);
}
html[data-theme="dark"] .select2-container--bootstrap-5 .select2-results__group,
body[data-theme="dark"] .select2-container--bootstrap-5 .select2-results__group{
  color: var(--bs-gray-400);
}
html[data-theme="dark"] .select2-container--bootstrap-5 .select2-selection--single .select2-selection__rendered,
body[data-theme="dark"] .select2-container--bootstrap-5 .select2-selection--single .select2-selection__rendered{
  color: var(--bs-gray-100);
}
</style>

</head>

<body>
	<!--begin::Main-->
	<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
		<!--begin::Content wrapper-->
		<div class="d-flex flex-column flex-column-fluid">
			<!--begin::Toolbar-->
			<div id="kt_app_toolbar" class="app-toolbar py-2 py-lg-3">
				<div id="kt_app_toolbar_container"
					class="app-container container-xxl d-flex align-items-center justify-content-between">

					<!--begin::Page title-->
					<div class="page-title d-flex flex-column justify-content-center">
						<h1 class="page-heading d-flex text-gray-900 fw-bold fs-3 my-0">Employee
							Profile</h1>
						<ul
							class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
							<li class="breadcrumb-item text-muted"><a
								href="${pageContext.request.contextPath}/demo_dashboard"
								class="text-muted text-hover-primary">Home</a></li>
							<li class="breadcrumb-item"><span
								class="bullet bg-gray-500 w-5px h-2px"></span></li>
							<li class="breadcrumb-item text-muted">Admin Management</li>
						</ul>
					</div>
					<!--end::Page title-->

					<!--begin::Actions (grouped, tighter spacing)-->
					<div class="d-flex align-items-center gap-2 ms-auto">
						<button type="button"
							class="btn btn-light-primary btn-sm px-3 py-2">
							<i class="ki-outline ki-printer fs-3 me-1"></i> Print
						</button>
						<button type="button" class="btn btn-success btn-sm px-3 py-2"
							onclick="addUser()">
							<i class="ki-outline ki-plus fs-3 me-1"></i> Create
						</button>
					</div>
					<!--end::Actions-->
				</div>
			</div>

			<!--end::Toolbar-->

			<!--begin::Content-->
			<div id="kt_app_content" class="app-content flex-column-fluid">
				<div id="kt_app_content_container"
					class="app-container container-xxl">
					<!--begin::Card-->
					<div class="card mb-5">
						<div class="card-body p-4">
							<!-- แถวบน: Search (เต็มความกว้าง) + ไอคอนฟิลเตอร์ด้านขวา -->
							<div class="filter-card p-4 mb-4">
								<!-- แถวบน: Search + ปุ่มกรอง -->
								<div class="d-flex align-items-center gap-3">
									<div class="user-search-wrap position-relative flex-grow-1">
										<i
											class="ki-outline ki-magnifier fs-2 text-gray-500 position-absolute top-50 translate-middle-y search-icon"></i>
										<select id="name2" class="form-select form-select-solid ps-12"
											data-placeholder="All" data-allow-clear="true">
											<option></option>
											<option value="All" selected>All</option>
											<!-- optgroup Enable / Disable เดิมของคุณคงไว้ตามที่มี -->
											<optgroup label="Enable">
												<c:forEach var="user" items="${cubesoftUser}">
													<c:if test="${user.enable == 1 && user.flag_search == '1'}">
														<c:set var="displayText" value="" />
														<c:if test="${not empty user.employee_id}">
															<c:set var="displayText"
																value="${displayText}${user.employee_id}" />
														</c:if>
														<c:if test="${not empty user.name}">
															<c:set var="displayText"
																value="${displayText}${not empty displayText ? ' - ' : ''}${user.name}" />
														</c:if>
														<c:if test="${not empty user.name_en}">
															<c:set var="displayText"
																value="${displayText}${not empty displayText ? ' - ' : ''}${user.name_en}" />
														</c:if>
														<option
															value="<c:out value='${user.id != null ? fn:trim(user.id) : ""}'/>">${displayText}</option>
													</c:if>
												</c:forEach>
											</optgroup>
											<optgroup label="Disable">
												<c:forEach var="user" items="${cubesoftUser}">
													<c:if test="${user.enable == 0 && user.flag_search == '1'}">
														<c:set var="displayText" value="" />
														<c:if test="${not empty user.employee_id}">
															<c:set var="displayText"
																value="${displayText}${user.employee_id}" />
														</c:if>
														<c:if test="${not empty user.name}">
															<c:set var="displayText"
																value="${displayText}${not empty displayText ? ' - ' : ''}${user.name}" />
														</c:if>
														<c:if test="${not empty user.name_en}">
															<c:set var="displayText"
																value="${displayText}${not empty displayText ? ' - ' : ''}${user.name_en}" />
														</c:if>
														<option
															value="<c:out value='${user.id != null ? fn:trim(user.id) : ""}'/>">${displayText}</option>
													</c:if>
												</c:forEach>
											</optgroup>
										</select>
									</div>

									<!-- ปุ่มแสดง/ซ่อนฟิลเตอร์ -->
									<button type="button" id="btnToggleFilters"
										class="btn btn-filter-pill" aria-expanded="false"
										aria-controls="filterFields">
										<i class="ki-outline ki-filter fs-2"></i>
									</button>
								</div>

								<!-- เส้นคั่น: โชว์เมื่อเปิดฟิลเตอร์เท่านั้น -->
								<div class="filter-divider border-bottom my-3 d-none"></div>

								<!-- ฟิลด์กรอง: ซ่อนตอนแรก -->
								<div id="filterFields" class="filter-fields d-none">
									<div class="row g-3">
										<div class="col-12 col-md-4">
											<label for="statusSelect" class="form-label mb-1">Status:</label>
											<select id="statusSelect"
												class="form-select form-select-solid"
												data-allow-clear="true" data-placeholder="All Status">
												<option value="">All Status</option>
												<option value="1">Active</option>
												<option value="2">Non active</option>
												<option value="3">All Users</option>
											</select>
										</div>
										<div class="col-12 col-md-4">
											<label for="birthdaysSelect" class="form-label mb-1">Birthdays:</label>
											<select id="birthdaysSelect"
												class="form-select form-select-solid"
												data-allow-clear="true" data-placeholder="Select">
												<option value="">Select</option>
												<option value="1">This Month</option>
												<option value="2">This Week</option>
												<option value="3">All Users</option>
											</select>
										</div>
										<div class="col-12 col-md-4">
											<label for="anniversariesSelect" class="form-label mb-1">Anniversaries:</label>
											<select id="anniversariesSelect"
												class="form-select form-select-solid"
												data-allow-clear="true" data-placeholder="Select">
												<option value="">Select</option>
												<option value="1">This Month</option>
												<option value="2">This Week</option>
												<option value="3">All Users</option>
											</select>
										</div>
									</div>
								</div>
							</div>

						</div>

					</div>
					<!-- End card -->


					<!-- Buttons + EmployeeID filter row -->
					<!-- Tools row -->
					<div
						class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-4 pt-5 mb-5 fs-7">

						<!-- LEFT: Showing ... -->
						<div id="dt_showing" class="text-muted fs-7 mb-2 mb-md-0">
							<!-- Showing X of Y users -->
						</div>

						<!-- RIGHT: controls -->
						<div class="d-flex align-items-center gap-3 ">

							<!-- Toggle Table/Grid -->
							<div class="d-flex align-items-center gap-2 me-1">
								<button id="btnTableView"
									class="btn btn-icon btn-active-light-primary btn-color-primary active"
									title="Table View">
									<i class="ki-outline ki-row-horizontal fs-2"></i>
								</button>

								<button id="btnGridView"
									class="btn btn-icon btn-active-light-primary btn-color-secondary"
									title="Grid View">
									<i class="ki-outline ki-element-4 fs-2"></i>
								</button>
							</div>

							<!-- Sort dropdown -->
							<div class="w-225px w-md-250px">
								<select id="sortSelect" class="form-select form-select-solid"
									data-placeholder="Sort by: Employee ID">
									<option value="Alluser">All User</option>
									<option value="empid-asc">User ID: Lowest</option>
									<option value="empid-desc">User ID: Highest</option>
									<option value="name-asc">Name: A–Z</option>
									<option value="name-desc">Name: Z–A</option>
									<option value="site-asc">Job Site: A–Z</option>
									<option value="site-desc">Job Site: Z–A</option>
									<option value="period-asc">Period: Shortest</option>
									<option value="period-desc">Period: Longest</option>
									<option value="startdate-desc">Start Date: Newest</option>
									<option value="startdate-asc">Start Date: Oldest</option>
									<option value="birth-young">Birth Date: Youngest</option>
									<option value="birth-old">Birth Date: Oldest</option>
								</select>
							</div>

							<!-- (ถ้ามี) คอนโทรลอื่น ๆ ต่อท้ายได้ -->
						</div>
					</div>

					<div class="card">
						<div class="card-body border-0 pt-6 mb-6 align-items-start">
							<div class="table-responsive">
								<!--begin::Table-->
								<table id="myTable"
									class="table table-row-dashed align-middle table-hover fs-6 gy-5 gx-5 mb-0">
									<thead>
										<tr
											class="text-start text-gray-500 fw-bold fs-7 text-uppercase gs-0">
											<th class="min-w-90px">User ID</th>
											<th class="min-w-220px">Name</th>
											<th class="min-w-160px">Job Site</th>
											<th class="min-w-120px">Position</th>
											<th class="min-w-120px">Period</th>
											<th class="text-end min-w-90px">Active</th>
											<th class="text-end min-w-120px">Actions</th>
										</tr>
									</thead>

									<tbody>
										<c:forEach var="user" items="${cubesoftUser}" varStatus="st">
											<c:set var="uid"
												value="${user.id != null ? fn:trim(user.id) : ''}" />

											<tr data-user-id="${uid}"
												data-birth="<fmt:formatDate value='${user.birth_date}' pattern='yyyy-MM-dd'/>">
												<!-- USER ID -->
												<td class="fw-bold text-gray-800"
													data-order="${user.employee_id}">${not empty user.employee_id ? user.employee_id : '-'}
												</td>

												<!-- NAME: EN + TH (บรรทัดรองสีอ่อน) -->
												<td>
													<div class="fw-semibold text-gray-900">
														<c:choose>
															<c:when test="${not empty user.name_en}">
																<a href="user-edit?userId=${user.id}"
																	class="text-gray-900 text-hover-primary">
																	${user.name_en} </a>
															</c:when>
															<c:otherwise>-</c:otherwise>
														</c:choose>
													</div>
													<div class="text-muted fs-8">${not empty user.name ? user.name : ''}
													</div>
												</td>

												<!-- JOB SITE: badge สีน้ำเงิน / ฟ้าอ่อน -->
												<td>
													<div class="d-flex flex-column gap-1">
														<c:choose>
															<c:when test="${not empty user.job_site}">
																<c:forEach var="site" items="${user.job_site}">
																	<span class="badge badge-light-primary fw-semibold">${site.name_site}</span>
																</c:forEach>
															</c:when>
															<c:otherwise>
																<span class="badge badge-light">None</span>
															</c:otherwise>
														</c:choose>
														<!-- ถ้ามีสถานะ in-house แยก badge ฟ้าอ่อน -->
														<c:if test="${not empty user.inhouse && user.inhouse}">
															<span class="badge badge-light-info fw-semibold">In-house</span>
														</c:if>
													</div>
												</td>

												<!-- POSITION -->
												<td class="text-gray-800">${not empty user.position_id ? user.position_id : '-'}
												</td>

												<!-- PERIOD: คำนวณจาก start/end -->
												<td class="text-gray-800"><span class="period-text"
													data-start="<fmt:formatDate value='${user.start_date}' pattern='yyyy-MM-dd'/>"
													data-end="<fmt:formatDate value='${user.end_date}'   pattern='yyyy-MM-dd'/>">-</span>
												</td>

												<!-- ACTIVE: สวิตช์ Metronic -->
												<td class="text-end" data-order="${user.enable}">
													<div
														class="form-check form-switch form-check-custom form-check-solid d-inline-flex justify-content-end">
														<input
															class="form-check-input h-20px w-35px js-toggle-enable"
															type="checkbox" id="active_${uid}" data-userid="${uid}"
															data-enable="${user.enable}"
															<c:if test="${user.enable == 1}">checked</c:if> />

													</div>
												</td>

												<!-- ACTIONS: ปุ่มฟ้า/ชมพู -->
												<td class="text-end"><a
													href="user-edit?userId=${user.id}"
													class="btn btn-icon btn-light-primary btn-sm me-2"
													title="Edit"> <i class="ki-outline ki-pencil fs-5"></i>
												</a>
													<button type="button"
														class="btn btn-icon btn-light-danger btn-sm btn-delete-user"
														data-id="${uid}" title="Delete">
														<i class="ki-outline ki-trash fs-5"></i>
													</button></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								<!--end::Table-->
							</div>
						</div>
						<div class="card-footer d-flex align-items-center gap-3 px-5 py-3">
							<select id="rowsPerPage"
								class="form-select form-select-sm w-75px">
								<option value="10" selected>10</option>
								<option value="20">20</option>
								<option value="50">50</option>
								<option value="100">100</option>
							</select>
							<div id="tablePagination" class="ms-auto"></div>
						</div>
					</div>
					<!--end::Card-->
				</div>
			</div>
		</div>
		<!--end::Content wrapper-->
	</div>
	<!--end::Main-->
	<script>
/* =================== User List: Table + Pagination + Filters (Clean One-File) =================== */
(function () {
  /* ---------- Config & State ---------- */
  var tableSelector = '#myTable';
  var paginationSelector = '#tablePagination';
  var rowsPerPageSelector = '#rowsPerPage';

  var tableItemsPerPage = 20;
  var currentPage = 1;

  var activeFilters  = { status: '', birthdays: '', anniversaries: '' };

  /* ---------- Helpers: Rows ---------- */
  function $rowsAll(){ return $(tableSelector + ' tbody tr'); }
  function rowPassesFilters($tr){
    if ($tr.attr('data-filtered') === '0') return false;

    // Status
    var st = (activeFilters.status || '');
    if (st === '3') st = ''; // All
    if (st !== '') {
      // อ่าน enable จาก td[data-order] หรือ checkbox
      var enabled = (function(){
        var $td = $tr.find('td[data-order]').last();
        if ($td.length) {
          var raw = String($td.attr('data-order') || '').trim().toLowerCase();
          if (raw === '1' || raw === 'true')  return true;
          if (raw === '0' || raw === 'false') return false;
        }
        var $cb = $tr.find('.form-check-input[type="checkbox"]').first();
        return $cb.length ? $cb.prop('checked') : null;
      })();
      if (enabled !== null) {
        if (st === '1' && !enabled) return false; // Active only
        if (st === '2' &&  enabled) return false; // Non active only
      }
    }

    // Anniversary
    var an = String(activeFilters.anniversaries || '');
    if (an === '1' && $tr.attr('data-anniv-thismonth') !== '1') return false;
    if (an === '2' && $tr.attr('data-anniv-thisweek')  !== '1') return false;

    // Birthday
    var bd = String(activeFilters.birthdays || '');
    if (bd === '1' && $tr.attr('data-bday-thismonth') !== '1') return false;
    if (bd === '2' && $tr.attr('data-bday-thisweek')  !== '1') return false;

    return true;
  }
  function $rowsEligible(){
    return $rowsAll().filter(function(){ return rowPassesFilters($(this)); });
  }

  /* ===== Date helpers (Birthday/Anniversary) ===== */
  function toDateYmd(iso) {
    if (!iso) return null;
    var m = String(iso).trim().match(/^(\d{4})-(\d{2})-(\d{2})/);
    if (!m) return null;
    return new Date(+m[1], +m[2]-1, +m[3]);
  }
  function asUTCDate(d){ return new Date(Date.UTC(d.getFullYear(), d.getMonth(), d.getDate())); }
  function daysBetween(a,b){ return Math.round((asUTCDate(b) - asUTCDate(a)) / 86400000); }
  function startOfWeekMonday(d){
    var t = new Date(d.getFullYear(), d.getMonth(), d.getDate());
    var dow = (t.getDay() + 6) % 7; // Mon=0
    t.setDate(t.getDate() - dow);
    return t;
  }
  function clampFeb29(year, month, day){
    if (month === 1 && day === 29) {
      var d = new Date(year, 1, 29);
      if (d.getMonth() !== 1) return new Date(year, 1, 28);
    }
    return new Date(year, month, day);
  }
  function computeNextOccurrence(baseDate, today) {
    today = today || new Date();
    var thisYear = today.getFullYear();
    var next = clampFeb29(thisYear, baseDate.getMonth(), baseDate.getDate());
    if (daysBetween(today, next) < 0) next = clampFeb29(thisYear + 1, baseDate.getMonth(), baseDate.getDate());
    var ws = startOfWeekMonday(today);
    var we = new Date(ws.getFullYear(), ws.getMonth(), ws.getDate() + 6);
    return {
      nextDate: next,
      daysLeft: Math.max(0, daysBetween(today, next)),
      inThisMonth: next.getMonth() === today.getMonth(),
      inThisWeek:  (asUTCDate(next) >= asUTCDate(ws)) && (asUTCDate(next) <= asUTCDate(we))
    };
  }

  /* ---------- Anniversary annotate + notes ---------- */
  function annotateAnniversaries(){
    const today = new Date();
    $rowsAll().each(function(){
      const $tr = $(this);
      const startISO = ($tr.find('.period-text').attr('data-start') || '').trim();
      const start = toDateYmd(startISO);
      if (!start){
        $tr.attr({'data-anniv-years':'','data-anniv-days':'','data-anniv-thismonth':'0','data-anniv-thisweek':'0','data-anniv-text':''});
        return;
      }
      const info = computeNextOccurrence(start, today);
      const years = info.nextDate.getFullYear() - start.getFullYear();
      var yearLabel = (years === 1 ? '1 Year Anniversary' : (years + ' Year Anniversary'));
      var dayStr = (info.daysLeft === 0) ? 'today' : (info.daysLeft === 1 ? 'in 1 day' : ('in ' + info.daysLeft + ' days'));
      $tr.attr({
        'data-anniv-years': years,
        'data-anniv-days' : info.daysLeft,
        'data-anniv-thismonth': info.inThisMonth ? '1' : '0',
        'data-anniv-thisweek' : info.inThisWeek  ? '1' : '0',
        'data-anniv-text'     : yearLabel + ' ' + dayStr
      });
    });
  }
  function syncAnniversaryNotes(){
    const mode = String(activeFilters.anniversaries || '');
    $rowsAll().each(function(){
      const $tr = $(this);
      const mm = $tr.attr('data-anniv-thismonth') === '1';
      const ww = $tr.attr('data-anniv-thisweek')  === '1';
      const text = $tr.attr('data-anniv-text') || '';
      const $name = $tr.children().eq(1);
      let $note = $name.find('.anniv-note');
      let show = (mode === '1') ? mm : (mode === '2') ? ww : false;
      if (show && text){
        if (!$note.length) $note = $('<div class="anniv-note"></div>').appendTo($name);
        $note.text(text).show();
      } else { if ($note.length) $note.remove(); }
    });
  }

  /* ---------- Birthday annotate + notes ---------- */
  function getBirthFromRow($tr){
    var iso = ($tr.attr('data-birth') || $tr.attr('data-dob') || $tr.attr('data-birthday') || '').trim();
    if (!iso){
      var alt = $tr.find('[data-birth],[data-dob],[data-birthday]').first();
      if (alt.length) iso = (alt.attr('data-birth') || alt.attr('data-dob') || alt.attr('data-birthday') || '').trim();
    }
    return toDateYmd(iso);
  }
  function annotateBirthdays(){
    const today = new Date();
    $rowsAll().each(function(){
      const $tr = $(this);
      const dob = getBirthFromRow($tr);
      if (!dob){
        $tr.attr({'data-bday-days':'','data-bday-thismonth':'0','data-bday-thisweek':'0','data-bday-text':''});
        return;
      }
      const info = computeNextOccurrence(dob, today);
      var msg = (info.daysLeft===0) ? 'Birthday today'
              : (info.daysLeft===1) ? 'Birthday in 1 day'
              : 'Birthday in ' + info.daysLeft + ' days';
      $tr.attr({
        'data-bday-days'     : info.daysLeft,
        'data-bday-thismonth': info.inThisMonth ? '1' : '0',
        'data-bday-thisweek' : info.inThisWeek  ? '1' : '0',
        'data-bday-text'     : msg
      });
    });
  }
  function syncBirthdayNotes(){
    const mode = String(activeFilters.birthdays || '');
    $rowsAll().each(function(){
      const $tr = $(this);
      const mm = $tr.attr('data-bday-thismonth') === '1';
      const ww = $tr.attr('data-bday-thisweek')  === '1';
      const text = $tr.attr('data-bday-text') || '';
      const $name = $tr.children().eq(1);
      let $note = $name.find('.bday-note');
      let show = (mode === '1') ? mm : (mode === '2') ? ww : false;
      if (show && text){
        if (!$note.length) $note = $('<div class="bday-note"></div>').appendTo($name);
        $note.text(text).show();
      } else { if ($note.length) $note.remove(); }
    });
  }

  /* ---------- Period column (2 lines) ---------- */
  function toISODateOnly(s){
    if (!s) return null;
    const m = String(s).trim().match(/^(\d{4}-\d{2}-\d{2})/);
    const iso = m ? m[1] : s;
    const d = new Date(iso);
    return isNaN(d) ? null : d;
  }
  function fmtDateDMY(iso){
    const d = toISODateOnly(iso);
    if(!d) return null;
    return d.toLocaleDateString('en-GB', { day:'2-digit', month:'short', year:'numeric' }).replace(/ /g,' ');
  }
  function periodLengthLabel(sISO, eISO){
    const s = toISODateOnly(sISO);
    if(!s) return '-';
    const e = eISO ? toISODateOnly(eISO) : new Date();
    if(!e) return '-';
    let y = e.getFullYear() - s.getFullYear();
    let m = e.getMonth() - s.getMonth();
    let d = e.getDate() - s.getDate();
    if (d < 0){ m--; d += new Date(e.getFullYear(), e.getMonth(), 0).getDate(); }
    if (m < 0){ y--; m += 12; }
    const parts = [];
    if (y > 0) parts.push(y + 'y');
    if (m > 0) parts.push(m + 'm');
    if (!parts.length && d >= 0) parts.push(d + 'd');
    return parts.join(' ');
  }
  function renderPeriods(){
    document.querySelectorAll('.period-text').forEach(function(el){
      const sISO = el.getAttribute('data-start');
      const eISO = el.getAttribute('data-end');
      const sTxt = fmtDateDMY(sISO);
      const eTxt = fmtDateDMY(eISO);
      const len  = periodLengthLabel(sISO, eISO);
      if (sTxt){
        const top = eTxt ? (sTxt + ' to ' + eTxt) : sTxt;
        el.innerHTML =
          '<div class="period-dates">' + top + '</div>' +
          '<div class="period-len">' + (len || '-') + '</div>';
      } else {
        el.textContent = '-';
      }
    });
  }

  /* ---------- Showing summary ---------- */
  function updateShowingText(){
    var totalAll = $rowsAll().length;
    var totalEligible = $rowsEligible().length;
    var badges = [];
    if (activeFilters.status === '1') badges.push('Status: Active');
    if (activeFilters.status === '2') badges.push('Status: Non active');
    if (String(activeFilters.anniversaries) === '1') badges.push('Anniversary month');
    if (String(activeFilters.anniversaries) === '2') badges.push('Anniversary week');
    if (String(activeFilters.birthdays) === '1') badges.push('Birthday month');
    if (String(activeFilters.birthdays) === '2') badges.push('Birthday week');
    var base = 'Employee ' + totalEligible + ' of ' + totalAll + ' users';
    var desc = badges.length ? ' • Filtered by: ' + badges.join(', ') : '';
    $('#dt_showing').text(base + desc);
  }

  /* ---------- Pagination ---------- */
  function renderTablePagination(totalPages){
    var $nav = $(paginationSelector);
    if (!totalPages || totalPages < 1){ $nav.html(''); return; }
    var html = '<ul class="pagination pagination-sm align-items-center">';
    html += '<li class="page-item ' + (currentPage===1?'disabled':'') + '">';
    html += '<a href="#" class="page-link" data-page="'+(currentPage-1)+'"><i class="ki-outline ki-left"></i></a></li>';

    var windowSize = 5;
    var startPage = Math.max(1, currentPage - 2);
    var endPage   = Math.min(totalPages, startPage + windowSize - 1);
    startPage = Math.max(1, Math.min(startPage, totalPages - windowSize + 1));

    if (startPage > 1){
      html += '<li class="page-item"><a class="page-link" data-page="1" href="#">1</a></li>';
      if (startPage > 2) html += '<li class="page-item ellipsis"><span class="page-link">...</span></li>';
    }
    for (var i=startPage;i<=endPage;i++){
      html += '<li class="page-item '+(i===currentPage?'active':'')+'">';
      html += '<a href="#" class="page-link" data-page="'+i+'">'+i+'</a></li>';
    }
    if (endPage < totalPages){
      if (endPage < totalPages - 1) html += '<li class="page-item ellipsis"><span class="page-link">...</span></li>';
      html += '<li class="page-item"><a class="page-link" data-page="'+totalPages+'" href="#">'+totalPages+'</a></li>';
    }
    html += '<li class="page-item ' + (currentPage===totalPages?'disabled':'') + '">';
    html += '<a href="#" class="page-link" data-page="'+(currentPage+1)+'"><i class="ki-outline ki-right"></i></a></li>';
    html += '</ul>';
    $nav.html(html);
  }

  function showTablePage(page) {
    const $all = $rowsAll();
    const $eligible = $rowsEligible();
    const totalEligible = $eligible.length;
    const totalPages = Math.max(1, Math.ceil(totalEligible / tableItemsPerPage));
    currentPage = Math.min(Math.max(page, 1), totalPages);

    const start = (currentPage - 1) * tableItemsPerPage;
    const end   = start + tableItemsPerPage;

    $all.hide();
    $eligible.slice(start, end).show();

    renderTablePagination(totalPages);
    renderPeriods();
    syncAnniversaryNotes();
    syncBirthdayNotes();
    updateShowingText();
  }

  /* ---------- Jump to specific user / Reset ---------- */
  function showOnlyUserWithReset(id) {
    id = (id || '').trim();
    const $all = $rowsAll();
    if (!id || id.toLowerCase() === 'all'){
      $all.attr('data-filtered','1');
    } else {
      $all.each(function () {
        const match = String($(this).attr('data-user-id') || '').trim() === id;
        $(this).attr('data-filtered', match ? '1' : '0');
      });
    }
    showTablePage(1);
  }
  function showAllUsers(){
    $rowsAll().attr('data-filtered','1');
    activeFilters = { status:'', birthdays:'', anniversaries:'' };
    $('#statusSelect').val('3').trigger('change.select2'); // All
    $('#birthdaysSelect').val('').trigger('change.select2');
    $('#anniversariesSelect').val('').trigger('change.select2');
    showTablePage(1);
  }

  /* ---------- Sorting (no DOM reorder; respect filtered order) ---------- */
  (function(){
    var currentSort = 'empid-asc';
    var sortedCache = null;

    function textOf($tr, idx){
      return ($tr.children().eq(idx).text() || '').replace(/\u00A0/g,' ').trim();
    }
    function empIdKey($tr){
      var raw = textOf($tr,0);
      var num = parseInt((raw.match(/\d+/)||[''])[0],10);
      if(isNaN(num)) num = -1;
      return {raw: raw.toLowerCase(), num: num};
    }
    function nameKey($tr){
      var primary = $tr.find('td:nth-child(2) .fw-semibold').text().trim();
      var fallback = $tr.find('td:nth-child(2) .text-muted').text().trim();
      return (primary || fallback || '').toLowerCase();
    }
    function siteKey($tr){
      return ($tr.find('td:nth-child(3) .badge').first().text().trim() || '').toLowerCase();
    }
    function toMsStart($tr){
      var el = $tr.find('.period-text')[0]; if(!el) return 0;
      var d = toISODateOnly(el.getAttribute('data-start')||''); return d?d.getTime():0;
    }
    function periodDays($tr){
      var el = $tr.find('.period-text')[0]; if(!el) return 0;
      var s = toISODateOnly(el.getAttribute('data-start')||'');
      var e = el.getAttribute('data-end') ? toISODateOnly(el.getAttribute('data-end')) : new Date();
      return (s && e) ? Math.round((e-s)/86400000) : 0;
    }
    function birthMs($tr){
      var d = getBirthFromRow($tr); return d?d.getTime():0;
    }
    function cmp(a,b){ return a<b?-1:(a>b?1:0); }

    function sortRows(mode){
      currentSort = mode || currentSort;
      var rows = $rowsAll().get();

      rows.sort(function(ra, rb){
        var $a=$(ra), $b=$(rb);
        switch(currentSort){
          case 'empid-asc':  { var ka=empIdKey($a), kb=empIdKey($b);
            return ka.num!==kb.num ? ka.num-kb.num : cmp(ka.raw,kb.raw); }
          case 'empid-desc': { var ka=empIdKey($a), kb=empIdKey($b);
            return ka.num!==kb.num ? kb.num-ka.num : cmp(kb.raw,ka.raw); }
          case 'name-asc':   return cmp(nameKey($a), nameKey($b));
          case 'name-desc':  return cmp(nameKey($b), nameKey($a));
          case 'site-asc':   return cmp(siteKey($a), siteKey($b));
          case 'site-desc':  return cmp(siteKey($b), siteKey($a));
          case 'period-asc': return periodDays($a) - periodDays($b);
          case 'period-desc':return periodDays($b) - periodDays($a);
          case 'startdate-asc':  return toMsStart($a) - toMsStart($b);
          case 'startdate-desc': return toMsStart($b) - toMsStart($a);
          case 'birth-young':    return birthMs($b) - birthMs($a); // young first
          case 'birth-old':      return birthMs($a) - birthMs($b); // old first
          default: return 0;
        }
      });

      // cache ลำดับไว้สำหรับ paginate ตามลำดับล่าสุด
      sortedCache = rows;

      // override showTablePage ให้ใช้ cache order + filter
      showTablePage = function(page){
        var $all = $($rowsAll()); // ใช้ NodeList สดเพื่อ hide()
        $all.hide();

        var eligible = [];
        $(sortedCache).each(function(){
          var $tr = $(this);
          if (rowPassesFilters($tr)) eligible.push(this);
        });

        var totalEligible = eligible.length;
        var totalPages = Math.max(1, Math.ceil(totalEligible / tableItemsPerPage));
        currentPage = Math.min(Math.max(page, 1), totalPages);
        var start = (currentPage - 1) * tableItemsPerPage;
        var end   = start + tableItemsPerPage;

        $(eligible.slice(start,end)).show();

        renderTablePagination(totalPages);
        renderPeriods();
        syncAnniversaryNotes();
        syncBirthdayNotes();
        updateShowingText();
      };

      showTablePage(1);
    }

    $(function(){
      $('#sortSelect').on('change', function(){ sortRows(this.value); });
      // default
      sortRows($('#sortSelect').val() || 'empid-asc');
    });
  })();

  /* ---------- Events ---------- */
  // Pagination click
  $(document).on('click', paginationSelector + ' .page-link', function(e){
    e.preventDefault();
    var page = parseInt($(this).data('page'), 10);
    if (!isNaN(page)) showTablePage(page);
  });

  // Rows per page
  $(rowsPerPageSelector).on('change', function(){
    var v = parseInt($(this).val(), 10);
    if (!isNaN(v) && v > 0) tableItemsPerPage = v;
    showTablePage(1);
  });

  // Toggle enable (AJAX)
  $(document).on('change', '.form-check-input', function(){
    const $cb   = $(this);
    const id    = $cb.data('userid');
    const next  = $cb.prop('checked') ? 1 : 0;
    const prev  = String($cb.data('enable')) === '1' ? 1 : 0;
    $cb.prop('disabled', true);
    $.ajax({
      type: 'POST',
      url: '${pageContext.request.contextPath}/update-user-status',
      dataType: 'json',
      data: { enable: next, userid: id },
      success: function(res){
        const enabled = String(res.enable) === '1';
        $cb.prop('checked', enabled).attr('data-enable', enabled ? 1 : 0);
        $cb.closest('td').attr('data-order', enabled ? 1 : 0);
        if (window.toastr) (enabled ? toastr.success : toastr.warning)(res.id + (enabled?' enable success':' disable success'));
      },
      error: function(){
        $cb.prop('checked', prev === 1);
        if (window.toastr) toastr.error('อัปเดตสถานะไม่สำเร็จ');
      },
      complete: function(){ $cb.prop('disabled', false); }
    });
  });

  /* ---------- Search (#name2) ---------- */
  function searchBySelectValue(user_id) {
    // คุณยังคงยิง AJAX ได้ตามเดิม ถ้าไม่ต้องการก็เรียก showOnlyUserWithReset ได้เลย
    if (!user_id || user_id === 'All') { showAllUsers(); return; }
    $.ajax({
      url: "search-User",
      type: "POST",
      dataType: "json",
      data: { "user_id": user_id },
      success: function (data) {
        const selectedId = String((data && (data.id || data.user_id)) || user_id).trim();
        showOnlyUserWithReset(selectedId);
      },
      error: function () {
        // fallback: กรองจากค่าที่เลือก
        showOnlyUserWithReset(user_id);
      }
    });
  }

  // DOM-based check (ไม่พึ่ง DataTables)
  window.checkUserExistsInTable = function(userId){
    userId = (userId || '').toString().trim();
    var exists = false;
    $rowsAll().each(function(){
      if (String($(this).attr('data-user-id')||'').trim() === userId){ exists = true; return false; }
    });
    return exists;
  };

  // Init Select2 + filter panel toggle
  $(function () {
    function initSel($el, noSearch){
      if(!$el.length) return;
      $el.select2({
        theme: 'bootstrap-5',
        width: '100%',
        placeholder: $el.data('placeholder') || 'Select',
        allowClear: true,
        minimumResultsForSearch: noSearch ? Infinity : 0
      });
    }
    initSel($('#name2'), false);
    initSel($('#statusSelect'), true);
    initSel($('#birthdaysSelect'), true);
    initSel($('#anniversariesSelect'), true);

    // Toggle inline filters panel
    const $btn = $('#btnToggleFilters');
    const $fields = $('#filterFields');
    const $divider = $('.filter-divider');
    function setFiltersOpen(open){
      $btn.toggleClass('active', open).attr('aria-expanded', open);
      if(open){
        $divider.removeClass('d-none');
        $fields.stop(true,true).slideDown(150, function(){ $(this).removeClass('d-none'); });
      }else{
        $fields.stop(true,true).slideUp(150, function(){ $(this).addClass('d-none'); });
        $divider.addClass('d-none');
      }
    }
    setFiltersOpen(false);
    $btn.on('click', function(e){ e.preventDefault(); setFiltersOpen(!$btn.hasClass('active')); });

    // ฟิลเตอร์ทำงานทันที
    $('#statusSelect').on('change', function(){
      var v = ($(this).val() || '');
      activeFilters.status = (v === '3') ? '' : v;
      showTablePage(1);
    });
    $('#birthdaysSelect').on('change', function(){
      activeFilters.birthdays = ($(this).val() || '');
      showTablePage(1);
    });
    $('#anniversariesSelect').on('change', function(){
      activeFilters.anniversaries = ($(this).val() || '');
      showTablePage(1);
    });

    // Search select
    $("#name2").on("change select2:select", function () {
      const user_id = ($(this).val() || '').toString().trim();
      searchBySelectValue(user_id);
    });
    $("#name2").on("select2:clear", function(){ showAllUsers(); });
  });

  /* ---------- Initial Render ---------- */
  $(function () {
    var $rpp = $(rowsPerPageSelector);
    if ($rpp.length) {
      var initial = parseInt($rpp.val(), 10);
      if (!isNaN(initial) && initial > 0) tableItemsPerPage = initial;
    }
    $rowsAll().attr('data-filtered', '1');

    annotateAnniversaries();
    annotateBirthdays();

    showTablePage(1);

    // sync data-enable flag
    $('.form-check-input[type="checkbox"]').each(function(){
      if (!$(this).data('enable')) $(this).attr('data-enable', $(this).prop('checked') ? 1 : 0);
    });
  });

  // manual debug hook
  window.__renderPaginationNow = function(){ try { showTablePage(1); } catch(e){ console.error(e); } };
  
  $(function(){
	  var $s = $('#name2');
	  if(!$s.length) return;

	  // หากเคย init แล้ว ให้ destroy ก่อน
	  try { if ($s.hasClass('select2-hidden-accessible')) $s.select2('destroy'); } catch(e){}

	  // ใช้ dropdownParent ที่ครอบด้วย data-theme เพื่อให้ CSS ธีมทำงานชัวร์
	  var $dp = $('#kt_app_content_container');
	  if(!$dp.length) $dp = $(document.body);

	  $s.select2({
	    theme: 'bootstrap-5',
	    width: '100%',
	    placeholder: $s.data('placeholder') || 'All',
	    allowClear: true,
	    minimumResultsForSearch: 0,
	    dropdownParent: $dp
	  });

	  // helper: ใส่/ถอดคลาส is-picked เมื่อมีค่าและไม่ใช่ 'All'
	  function refreshPickedClass(){
	    var hasVal = ($s.val() && $s.val() !== 'All');
	    var $ctn = $s.next('.select2-container');
	    $ctn.toggleClass('is-picked', !!hasVal);
	  }

	  // ครั้งแรก + ทุกครั้งที่เปลี่ยนค่า/ล้างค่า
	  refreshPickedClass();
	  $s.on('change select2:select select2:clear', refreshPickedClass);
	});
})();
</script>




</body>
</html>
