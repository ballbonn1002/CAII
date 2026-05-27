<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/permission.tld" prefix="perm"%>
<link
	href="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.css"
	rel="stylesheet" type="text/css" />
<script
	src="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.js"></script>
<link
	href="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.css"
	rel="stylesheet" type="text/css" />
<script
	src="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.js"></script>

<style>
/*Light Mode*/
[data-bs-theme="light"] #fm_table.table.table-striped>tbody>tr:nth-of-type(odd)>*
	{
	background-color: #FBFBFB !important;
	box-shadow: none !important;
}

[data-bs-theme="light"] #fm_table.table-hover tbody tr:hover>*, [data-bs-theme="light"] #fm_table.table-hover tbody tr:hover>td,
	[data-bs-theme="light"] #fm_table.table-hover tbody tr:hover>th, [data-bs-theme="light"] #fm_table.table.table-hover>tbody>tr:hover>*,
	[data-bs-theme="light"] #fm_table.dataTable>tbody>tr:hover>* {
	background-color: #F9F9F9 !important; /* hover */
	box-shadow: none !important;
	transition: background-color 0.15s ease-in-out;
}

/*Dark Mode*/
[data-bs-theme="dark"] #fm_table.table.table-striped>tbody>tr:nth-of-type(odd)>*
	{
	background-color: #191B20 !important; /* odd */
	box-shadow: none !important;
}

[data-bs-theme="dark"] #fm_table.table.table-striped>tbody>tr:nth-of-type(even)>*
	{
	background-color: #15171C !important; /* even */
	box-shadow: none !important;
}

[data-bs-theme="dark"] #fm_table.table-hover tbody tr:hover>*, [data-bs-theme="dark"] #fm_table.table-hover tbody tr:hover>td,
	[data-bs-theme="dark"] #fm_table.table-hover tbody tr:hover>th, [data-bs-theme="dark"] #fm_table.table.table-hover>tbody>tr:hover>*,
	[data-bs-theme="dark"] #fm_table.dataTable>tbody>tr:hover>* {
	background-color: #1B1C22 !important; /* hover */
	box-shadow: none !important;
	transition: background-color 0.15s ease-in-out;
}
</style>

<div class="app-main flex-column flex-row-fluid">
	<fmt:setLocale value="en_US" />
	<div class="d-flex flex-column flex-column-fluid">
		<!-- Toolbar -->
		<div class="app-toolbar py-5 py-lg-6">
			<div class="app-container container-fluid d-flex flex-stack">
				<div
					class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
					<h1
						class="page-heading d-flex text-gray-900 fw-semibold fs-3 flex-column justify-content-center my-0">
						File Management</h1>
					<ul
						class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
						<li class="breadcrumb-item text-muted"><a
							href="demo_dashboard" class="text-muted text-hover-primary">Home</a>
						</li>
						<li class="breadcrumb-item"><span
							class="bullet bg-gray-500 w-5px h-2px"></span></li>
						<li class="breadcrumb-item text-muted">Cube Management</li>
					</ul>
				</div>
				<!-- All Files / My Files buttons -->
				<perm:permission object="file.viewall">
					<div class="d-flex align-items-center flex-wrap gap-3 mt-3 mt-md-0">
						<c:choose>
							<c:when test="${mode == 'my'}">
								<button type="button"
									class="btn btn-light-info border border-info h-40px fw-bold px-5"
									onclick="switchMode('all')">All Files</button>
								<button type="button"
									class="btn btn-primary h-40px fw-bold px-5"
									onclick="switchMode('my')">My Files</button>
							</c:when>
							<c:otherwise>
								<button type="button"
									class="btn btn-info h-40px fw-bold px-5"
									onclick="switchMode('all')">All Files</button>
								<button type="button"
									class="btn btn-light-primary border border-primary h-40px fw-bold px-5"
									onclick="switchMode('my')">My Files</button>
							</c:otherwise>
						</c:choose>
					</div>
				</perm:permission>
			</div>
		</div>
		<!-- end::Toolbar -->

		<div class="app-content flex-column-fluid">
			<div class="app-container container-fluid">

				<!-- Main Card -->
				<div class="card">
					<!-- Card Header: Title + Upload -->
					<div class="card-header align-items-center py-5 gap-2 gap-md-5"
						style="border-bottom: none;">
						<div class="card-title">
							<h3 class="fw-bold text-gray-800 mb-0">
								<c:choose>
									<c:when test="${mode == 'my'}">My Files</c:when>
									<c:otherwise>All File</c:otherwise>
								</c:choose>
							</h3>
						</div>
						<div class="card-toolbar">
							<button type="button"
								class="btn btn-success h-40px fw-bold px-5"
								data-bs-toggle="modal" data-bs-target="#uploadModal">
								Upload
							</button>
						</div>
					</div>

					<!-- Search & Filter Row -->
					<div class="card-body pt-0 pb-5">
						<div class="row g-4 mb-4">
							<!-- User Info -->
							<div class="col-12 col-md-8">
								<div class="input-group flex-nowrap">
									<span class="input-group-text bg-transparent border-end-0 h-45px">
										<i class="ki-outline ki-magnifier fs-3"></i>
									</span>
									<div class="flex-grow-1">
									<c:choose>
										<c:when test="${mode == 'my'}">
											<select class="form-select rounded-start-0 border-start-0 h-45px text-truncate" data-control="select2" id="searchUser" style="width: 100%;" disabled>
												<c:set var="displayText" value="" />
												<c:if test="${not empty onlineUser.employeeId}">
													<c:set var="displayText" value="${onlineUser.employeeId}" />
												</c:if>
												<c:if test="${not empty onlineUser.nameEN}">
													<c:set var="displayText" value="${displayText}${not empty displayText ? ' - ' : ''}${onlineUser.nameEN}" />
												</c:if>
												<c:if test="${not empty onlineUser.name}">
													<c:set var="displayText" value="${displayText}${not empty displayText ? ' - ' : ''}${onlineUser.name}" />
												</c:if>
												<c:if test="${empty displayText}">
													<c:set var="displayText" value="${onlineUser.id}" />
												</c:if>
												<option value="${onlineUser.id}" selected>${displayText}</option>
											</select>
										</c:when>
										<c:otherwise>
											<select class="form-select rounded-start-0 border-start-0 h-45px text-truncate" data-control="select2" id="searchUser" data-placeholder="All" data-allow-clear="true" style="width: 100%;">
												<option></option>
												<option value="all_users" <c:if test="${searchUser == 'all_users' || empty searchUser}">selected</c:if>>All</option>
												<optgroup label="Enable">
													<c:forEach var="u" items="${userList}">
														<c:if test="${u.enable == '1' && u.flagSearch == '1'}">
															<c:set var="displayText" value="" />
															<c:if test="${not empty u.employeeId}">
																<c:set var="displayText" value="${u.employeeId}" />
															</c:if>
															<c:if test="${not empty u.nameEN}">
																<c:set var="displayText" value="${displayText}${not empty displayText ? ' - ' : ''}${u.nameEN}" />
															</c:if>
															<c:if test="${not empty u.name}">
																<c:set var="displayText" value="${displayText}${not empty displayText ? ' - ' : ''}${u.name}" />
															</c:if>
															<c:if test="${empty displayText}">
																<c:set var="displayText" value="${u.id}" />
															</c:if>
															<option value="${u.id}" <c:if test="${searchUser == u.id}">selected</c:if>>${displayText}</option>
														</c:if>
													</c:forEach>
												</optgroup>
												<optgroup label="Disable">
													<c:forEach var="u" items="${userList}">
														<c:if test="${u.enable == '0' && u.flagSearch == '1'}">
															<c:set var="displayText" value="" />
															<c:if test="${not empty u.employeeId}">
																<c:set var="displayText" value="${u.employeeId}" />
															</c:if>
															<c:if test="${not empty u.nameEN}">
																<c:set var="displayText" value="${displayText}${not empty displayText ? ' - ' : ''}${u.nameEN}" />
															</c:if>
															<c:if test="${not empty u.name}">
																<c:set var="displayText" value="${displayText}${not empty displayText ? ' - ' : ''}${u.name}" />
															</c:if>
															<c:if test="${empty displayText}">
																<c:set var="displayText" value="${u.id}" />
															</c:if>
															<option value="${u.id}" <c:if test="${searchUser == u.id}">selected</c:if>>${displayText}</option>
														</c:if>
													</c:forEach>
												</optgroup>
											</select>
										</c:otherwise>
									</c:choose>
									</div>
								</div>
							</div>
							<!-- Date Range Picker -->
							<div class="col-12 col-md-4">
								<div class="position-relative">
									<i class="ki-duotone ki-calendar-8 fs-2 text-gray-500 position-absolute top-50 translate-middle-y ms-4">
										<span class="path1"></span><span class="path2"></span>
										<span class="path3"></span><span class="path4"></span>
										<span class="path5"></span><span class="path6"></span>
									</i> <input type="text" class="form-control ps-12" placeholder="Pick date range" id="kt_daterangepicker_fm" readonly />
								</div>
							</div>
						</div>
						
						<div class="row g-4">
							<!-- Search -->
							<div class="col-12 col-md-5">
								<div class="position-relative">
									<i class="ki-duotone ki-magnifier fs-3 text-gray-500 position-absolute top-50 translate-middle-y ms-4">
										<span class="path1"></span><span class="path2"></span>
									</i> <input type="text" class="form-control ps-12" id="fmKeyword" placeholder="Search" data-kt-table-filter="search" value="${keyword}" />
								</div>
							</div>
							<!-- Page Filter -->
							<div class="col-12 col-md-5">
								<select class="form-select" id="modelFilter" data-control="select2" data-hide-search="true">
									<option value="">All Page</option>
									<!-- Options will be populated by JS -->
								</select>
							</div>
							<div class="col-12 col-md-2">
								<button type="button" class="btn btn-primary w-100" onclick="reloadList()">Search</button>
							</div>
						</div>
					</div>

					<!-- File Table -->
					<div class="card-body py-0">
						<div class="table-responsive">
							<table id="fm_table"
								class="table table-striped table-hover table-row-bordered table-row-gray-200 align-middle gs-4 gy-4 mb-0"
								style="opacity: 0; transition: opacity 0.15s ease-in-out;">
								<thead>
									<tr class="fw-bold text-muted text-uppercase">
										<th class="ps-6 w-60px rounded-start">#</th>
										<th class="min-w-250px">FILE NAME</th>
										<th class="min-w-80px">PAGE</th>
										<th class="min-w-70px">PAGE ID</th>
										<th class="min-w-220px" style="padding-left: 6.0rem !important;">BY</th>
										<th class="min-w-80px text-center">TYPE</th>
										<th class="min-w-100px text-end pe-10">SIZE</th>
										<th class="w-80px text-center rounded-end">ACTION</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="f" items="${fileList}" varStatus="st">
										<tr>
													<td class="ps-6 text-gray-600 fw-semibold">
														${st.count}</td>
													<td>
														<div class="text-truncate" style="max-width: 320px;">
															<c:set var="fileLink" value="${f.path}" />
															<c:if test="${not fn:startsWith(fileLink, 'http')}">
																<c:set var="fileLink" value="${pageContext.request.contextPath}${fn:startsWith(fileLink, '/') ? '' : '/'}${fileLink}" />
															</c:if>
															<a href="${fileLink}" target="_blank"
																class="text-gray-800 text-hover-primary fw-semibold"
																title="${f.name}${f.type}">${f.name}${f.type}</a>
														</div>
													</td>
													<td class="text-gray-800" style="text-transform: capitalize;">${not empty f.page ? f.page : 'Other'}</td>
													<td class="text-gray-800">${not empty f.pageId ? f.pageId : '-'}</td>
													<td class="text-gray-800 fw-bold text-nowrap" style="padding-left: 6.0rem !important;">
														<c:set var="uploaderName" value="${userMap[f.userId] != null ? (not empty userMap[f.userId].nameEN ? userMap[f.userId].nameEN : userMap[f.userId].name) : f.userId}" />
														${uploaderName}<br>
														<span class="text-gray-600 fw-normal fs-7"><fmt:formatDate
															value="${f.timeCreate}" pattern="d MMM yyyy , H:mm" /></span>
													</td>
													<td class="text-gray-600 text-center">${f.type}</td>
													<td class="text-gray-600 text-end pe-10" data-order="${not empty f.size ? f.size : '0'}">
														<c:choose>
															<c:when test="${empty f.size or f.size == '0'}">-</c:when>
															<c:otherwise><span class="file-size-bytes" data-bytes="${f.size}"></span></c:otherwise>
														</c:choose>
													</td>
													<td class="text-center">
														<c:if test="${f.userId == onlineUser.id or onlineUser.roleId == '1'}">
															<button type="button"
																class="btn btn-sm btn-icon btn-light-danger"
																onclick="confirmDelete(${f.fileId}, '${f.page}')">
																<i class="ki-duotone ki-trash fs-4"><span
																	class="path1"></span><span class="path2"></span><span
																	class="path3"></span><span class="path4"></span><span
																	class="path5"></span></i>
															</button>
														</c:if>
													</td>
												</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>

				</div>
				<!-- end Main Card -->

			</div>
		</div>
	</div>
</div>

<!-- Upload Modal -->
<div class="modal fade" id="uploadModal" tabindex="-1"
	aria-labelledby="uploadModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<form id="uploadForm"
				action="${pageContext.request.contextPath}/file_management_upload"
				method="post" enctype="multipart/form-data">
				<div class="modal-header border-0 pt-8 pb-4">
					<h3 class="modal-title fw-bold text-gray-800 ms-3" id="uploadModalLabel">Upload file</h3>
					<div class="btn btn-icon btn-sm btn-active-light-primary ms-2 me-3" data-bs-dismiss="modal" aria-label="Close">
						<i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
					</div>
				</div>
				<div class="modal-body py-10 px-10">
					<label class="btn btn-primary btn-sm px-6 mb-6" for="uploadFileInput" id="btnSelectFile">
						Select files
					</label> 
					<input type="file" id="uploadFileInput" name="fileUpload"
						class="d-none" accept="*/*" onchange="handleFileSelect(this)" />
					
					<div id="filePreviewArea" class="mb-6" style="display: none;"></div>

					<div class="form-check form-check-custom form-check-solid form-check-sm mt-4">
						<input class="form-check-input" type="checkbox" value="1" name="compressFile" id="compressCheck" checked="checked" />
						<label class="form-check-label text-gray-700 fs-7 ms-3" for="compressCheck">
							Compress file
						</label>
					</div>
				</div>
				<div class="modal-footer border-0 pt-4 pb-8 pe-10">
					<button type="button" class="btn btn-light"
						data-bs-dismiss="modal">Close</button>
					<button type="submit" class="btn btn-success fw-bold"
						id="btnUpload" disabled>Upload</button>
				</div>
			</form>
		</div>
	</div>
</div>

<!-- Hidden delete form -->
<form id="deleteForm"
	action="${pageContext.request.contextPath}/file_management_delete"
	method="post">
	<input type="hidden" id="deleteFileId" name="fileId" value="" />
</form>

<script>
var contextPath = '${pageContext.request.contextPath}';
var currentMode = '${mode}';
if (!currentMode) currentMode = 'my';

// Date range picker - restore from server if available
var serverStartDate = '${startDateStr}';
var serverEndDate = '${endDateStr}';
var fmStart = (serverStartDate && serverStartDate.length > 0) ? moment(serverStartDate, 'YYYY-MM-DD') : moment().startOf('year');
var fmEnd = (serverEndDate && serverEndDate.length > 0) ? moment(serverEndDate, 'YYYY-MM-DD') : moment().endOf('year');

function fmCb(start, end) {
	$('#kt_daterangepicker_fm').val(start.format('D MMM YYYY') + ' - ' + end.format('D MMM YYYY'));
}

$(document).ready(function() {
	// (Automatic reload when user changes disabled to reduce server load)

	$('#kt_daterangepicker_fm').daterangepicker({
		startDate : fmStart,
		endDate : fmEnd,
		showDropdowns: true,
		locale : { format : 'D MMM YYYY' },
		ranges : {
			'Today' : [ moment(), moment() ],
			'Yesterday' : [ moment().subtract(1, 'days'), moment().subtract(1, 'days') ],
			'Last 7 Days' : [ moment().subtract(6, 'days'), moment() ],
			'Last 30 Days' : [ moment().subtract(29, 'days'), moment() ],
			'This Month' : [ moment().startOf('month'), moment().endOf('month') ],
			'Last Month' : [ moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month') ],
			'This Year' : [ moment().startOf('year'), moment().endOf('year') ],
			'Last Year' : [ moment().subtract(1, 'year').startOf('year'), moment().subtract(1, 'year').endOf('year') ]
		}
	}, fmCb);
	fmCb(fmStart, fmEnd);

	// Parse sizes to bytes and set data-order on TD elements for correct numerical sorting
	function parseToBytes(val) {
		if (!val) return 0;
		val = val.toString().trim();
		if (val === '' || val === '0' || val === '-') return 0;
		if (!isNaN(val)) {
			return parseFloat(val);
		}
		var match = val.match(/^([\d.,]+)\s*([a-zA-Z]+)?$/);
		if (match) {
			var num = parseFloat(match[1].replace(/,/g, ''));
			var unit = match[2] ? match[2].toUpperCase() : '';
			if (unit === 'KB') return num * 1024;
			if (unit === 'MB') return num * 1024 * 1024;
			if (unit === 'GB') return num * 1024 * 1024 * 1024;
			if (unit === 'TB') return num * 1024 * 1024 * 1024 * 1024;
			if (unit === 'B') return num;
			return num;
		}
		return 0;
	}

	$('#fm_table tbody tr').each(function() {
		var sizeTd = $(this).find('td').eq(6); // 7th column (0-indexed 6) is SIZE
		if (sizeTd.length) {
			var rawVal = sizeTd.attr('data-order');
			var bytes = parseToBytes(rawVal);
			sizeTd.attr('data-order', bytes);
		}
	});

	// DataTable init
	var fmDt = $('#fm_table').DataTable({
		searching: true,
		pageLength: 100,
		lengthMenu: [50, 100, 200],
		ordering: true,
		order: [],
		autoWidth: false,
		columnDefs: [
			{ orderable: false, targets: [0, 7] }
		],
		dom:
			"t" +
			"<'row mt-5'" +
				"<'col-sm-12 col-md-5 d-flex align-items-center justify-content-center justify-content-md-start'l>" +
				"<'col-sm-12 col-md-7 d-flex align-items-center justify-content-center justify-content-md-end'p>" +
			">",
		initComplete: function() {
			$('#fm_table').css('opacity', '1');
		}
	});

	// Populate Page Dropdown from DataTable column
	fmDt.column(2).data().unique().sort().each(function(d, j) {
		var val = d ? d.trim() : '';
		if(val && val !== 'Other' && !$('#modelFilter option[value="' + val + '"]').length) {
			$('#modelFilter').append('<option value="' + val + '">' + val + '</option>');
		}
	});

	// Restore Model and Keyword Filters from URL and apply on load
	var urlParams = new URLSearchParams(window.location.search);
	var searchModel = urlParams.get('searchModel');
	var keyword = urlParams.get('keyword');

	if (searchModel) {
		$('#modelFilter').val(searchModel).trigger('change.select2');
		var val = $.fn.dataTable.util.escapeRegex(searchModel);
		fmDt.column(2).search(val ? '^' + val + '$' : '', true, false);
	}
	if (keyword) {
		$('#fmKeyword').val(keyword);
		fmDt.search(keyword);
	}
	if (searchModel || keyword) {
		fmDt.draw();
	}

	$('#uploadModal').on('hidden.bs.modal', function() {
		clearFile();
	});

	// Convert file sizes from bytes to KB, or display directly if already formatted
	$('.file-size-bytes').each(function() {
		var val = $(this).data('bytes');
		if (val && typeof val === 'string' && (val.indexOf(' ') !== -1 || val.indexOf('B') !== -1 || val.indexOf('KB') !== -1 || val.indexOf('MB') !== -1 || val.indexOf('GB') !== -1)) {
			$(this).text(val);
		} else {
			var bytes = parseInt(val, 10);
			if (!isNaN(bytes) && bytes > 0) {
				$(this).text((bytes / 1024).toFixed(2) + ' KB');
			} else {
				$(this).text('-');
			}
		}
	});
});

function switchMode(mode) {
	currentMode = mode;
	var picker = $('#kt_daterangepicker_fm').data('daterangepicker');
	var startDate = picker ? picker.startDate.format('YYYY-MM-DD') : '';
	var endDate = picker ? picker.endDate.format('YYYY-MM-DD') : '';
	
	var url = contextPath + '/file_management?mode=' + mode;
	if (picker) {
		url += '&startDate=' + startDate + '&endDate=' + endDate;
	}
	if (mode === 'all') {
		url += '&searchUser=all_users';
	}
	window.location.href = url;
}

function reloadList() {
	var picker = $('#kt_daterangepicker_fm').data('daterangepicker');
	if (!picker) return;
	var startDate = picker.startDate.format('YYYY-MM-DD');
	var endDate = picker.endDate.format('YYYY-MM-DD');
	var searchUser = $('#searchUser').val();
	var searchModel = $('#modelFilter').val() || '';
	var fmKeyword = $('#fmKeyword').val() || '';
	var url = contextPath + '/file_management'
		+ '?startDate=' + startDate
		+ '&endDate=' + endDate
		+ '&mode=' + currentMode
		+ '&searchUser=' + searchUser
		+ '&searchModel=' + searchModel
		+ '&keyword=' + encodeURIComponent(fmKeyword);
	window.location.href = url;
}

function handleFileSelect(input) {
	var file = input.files[0];
	if (!file) {
		clearFile();
		return;
	}
	
	document.getElementById('btnSelectFile').innerText = 'Attach files';
	
	var previewArea = document.getElementById('filePreviewArea');
	previewArea.style.display = 'block';
	
	// Check if file is image
	if (file.type.match('image.*')) {
		var reader = new FileReader();
		reader.onload = function(e) {
			previewArea.innerHTML = '<div class="position-relative d-inline-block mt-2 mb-2">'
				+ '<img src="' + e.target.result + '" class="rounded" style="max-height: 150px; max-width: 100%;" />'
				+ '<button type="button" class="btn btn-icon btn-circle btn-color-muted btn-active-color-primary w-25px h-25px bg-body shadow" '
				+ 'style="position:absolute; top:-10px; right:-10px;" onclick="document.getElementById(\'uploadFileInput\').click();">'
				+ '<i class="ki-duotone ki-pencil fs-7"><span class="path1"></span><span class="path2"></span></i></button>'
				+ '<button type="button" class="btn btn-icon btn-circle btn-color-muted btn-active-color-danger w-25px h-25px bg-body shadow" '
				+ 'style="position:absolute; bottom:-10px; right:-10px;" onclick="clearFile()">'
				+ '<i class="ki-duotone ki-cross fs-3"><span class="path1"></span><span class="path2"></span></i></button>'
				+ '</div>';
		};
		reader.readAsDataURL(file);
	} else {
		// Non-image file view
		previewArea.innerHTML = '<div class="d-flex align-items-center border border-gray-300 rounded p-4">'
			+ '<span class="fw-semibold text-gray-800 me-auto fs-6">' + file.name + '</span>'
			+ '<button type="button" class="btn btn-icon btn-sm btn-light-danger ms-3" onclick="clearFile()">'
			+ '<i class="ki-duotone ki-trash fs-2"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i>'
			+ '</button></div>';
	}
	
	document.getElementById('btnUpload').disabled = false;
}

function clearFile() {
	document.getElementById('uploadFileInput').value = '';
	document.getElementById('btnSelectFile').innerText = 'Select files';
	var previewArea = document.getElementById('filePreviewArea');
	previewArea.style.display = 'none';
	previewArea.innerHTML = '';
	document.getElementById('btnUpload').disabled = true;
}

function confirmDelete(fileId, page) {
	var pageLower = page ? page.trim().toLowerCase() : '';
	if (pageLower !== 'file_management') {
		var pageNameThai = page;
		if (pageLower === '' || pageLower === 'other') {
			pageNameThai = 'เนื้อหาอื่น ๆ (Other)';
		} else if (pageLower === 'announcement' || pageLower === 'announcementfiles') {
			pageNameThai = 'Announcement (ข่าวประกาศ)';
		} else if (pageLower === 'leave') {
			pageNameThai = 'Leave (ระบบลางาน)';
		} else if (pageLower === 'borrow') {
			pageNameThai = 'Borrow (ระบบยืม-คืน)';
		} else if (pageLower === 'article') {
			pageNameThai = 'Article (บทความ)';
		} else if (pageLower === 'equipment') {
			pageNameThai = 'Equipment (ระบบอุปกรณ์)';
		} else if (pageLower === 'user') {
			pageNameThai = 'User (ข้อมูลผู้ใช้)';
		} else if (pageLower === 'user_signature') {
			pageNameThai = 'User Signature (ลายเซ็นผู้ใช้)';
		} else if (pageLower === 'support_detail') {
			pageNameThai = 'Support Detail (รายละเอียดสนับสนุน)';
		} else {
			pageNameThai = page.charAt(0).toUpperCase() + page.slice(1);
		}

		Swal.fire({
			title : 'ไม่สามารถลบไฟล์ได้!',
			text : 'ไฟล์นี้เป็นไฟล์ประกอบของหน้า "' + pageNameThai + '" กรุณาไปที่หน้าเพจดังกล่าวเพื่อตรวจสอบและทำการลบไฟล์แทนครับ',
			icon : 'warning',
			confirmButtonText : 'ตกลง',
			confirmButtonColor : '#3085d6'
		});
		return;
	}

	Swal.fire({
		title : 'Are you sure?',
		text : 'This file will be permanently deleted.',
		icon : 'warning',
		showCancelButton : true,
		confirmButtonColor : '#d33',
		cancelButtonColor : '#aaa',
		confirmButtonText : 'Delete',
		cancelButtonText : 'Cancel'
	}).then(function(result) {
		if (result.isConfirmed) {
			document.getElementById('deleteFileId').value = fileId;
			document.getElementById('deleteForm').submit();
		}
	});
}
</script>
