<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<fmt:setLocale value="en_US" />


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />

<link
	href="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.css"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/assets/css/style.bundle.css"
	rel="stylesheet" />
<script
	src="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.js"></script>
<script
	src="${pageContext.request.contextPath}/assets/js/scripts.bundle.js"></script>

<link
	href="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.css"
	rel="stylesheet" type="text/css" />
<script
	src="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.js"></script>

<link rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />

<script src="https://cdn.jsdelivr.net/npm/moment@2.29.4/moment.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>

<style type="text/css">
[data-bs-theme="light"] #myTable.table.table-striped > tbody > tr:nth-of-type(odd) > * {
    background-color: #FBFBFB !important; 
    box-shadow: none !important;
  }
 [data-bs-theme="dark"] #myTable.table.table-striped > tbody > tr:nth-of-type(odd) > * {
    background-color: #191B20 !important; 
    box-shadow: none !important;
  }

#myTable thead th {
	white-space: nowrap !important;
	position: relative !important;
	padding-right: 35px !important;
	cursor: pointer;
}

#myTable thead th.sorting:after, #myTable thead th.sorting_asc:after,
	#myTable thead th.sorting_desc:after, #myTable thead th.sorting:before,
	#myTable thead th.sorting_asc:before, #myTable thead th.sorting_desc:before
	{
	position: absolute !important;
	top: 10px !important;
	right: 10px !important;
	display: block !important;
	opacity: 0.5;
}

#myTable thead th.sorting:before {
	margin-top: -6px;
}

#myTable thead th.sorting:after {
	margin-top: 4px;
}

#myTable thead th:first-child, th:last-child {
    padding-right: 0 !important;
}

#myTable thead th:last-child {
    text-align: right !important;
    padding-right: 0 !important;
}

.daterangepicker {
    padding-bottom: 0 !important;
}

.daterangepicker .drp-calendar {
    margin-bottom: 0 !important;
}
.daterangepicker .ranges {
    display: none;
}
</style>
</head>
<body class="app-default">
	<div class="app-main flex-column flex-row-fluid">
		<div class="d-flex flex-column flex-column-fluid">
			<!-- Header -->
			<div class="app-toolbar py-3 py-lg-6">
				<div class="app-container container-fluid d-flex flex-stack">
					<div
						class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
						<h1
							class="page-heading d-flex text-gray-700 fw-semibold flex-column justify-content-center my-0">
							Page URL</h1>

						<ul
							class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
							<li class="breadcrumb-item text-muted"><a
								href="${pageContext.request.contextPath}/demo_dashboard"
								class="text-muted text-hover-primary">Home</a></li>
							<li class="breadcrumb-item"><span
								class="bullet bg-gray-500 w-5px h-2px"></span></li>
							<li class="breadcrumb-item text-muted"><a
								class="text-muted text-hover-primary">CMS</a></li>
						</ul>
					</div>
				</div>
			</div>

			<div class="app-content flex-column-fluid">
				<div class="app-container container-fluid">
					<div class="card mb-10">

						<div class="card-body filter-card px-10 py-9 rounded-3">
							<!-- Search -->
							<div class="col-md-12 position-relative">
								<i
									class="ki-duotone ki-magnifier fs-3 position-absolute ms-5 top-50 translate-middle-y"><span
									class="path1"></span><span class="path2"></span></i> <input
									type="text" class="form-control form-solid ps-14"
									id="tableSearch" placeholder="Search">
							</div>
							<%-- <div class="filter-divider border-bottom my-6 mt-8 "></div>
							<!-- Filter -->
							<div id="filterFields" class="filter-fields">
								<div class="row g-3">
									<div class="col-12 col-md-4">
										<label for="statusSelect" class="form-label mb-1">Status:</label>
										<select id="statusFilter" class="form-select" name="articleStatus" data-control="select2"
											data-placeholder="All Status">
											<option value="ALL">All Status</option>
											<option value="Active">Active</option>
											<option value="Draft">Draft</option>
											<option value="Pending">Pending</option>
										</select>
									</div>
									<div class="col-12 col-md-4">
										<label for="birthdaysSelect" class="form-label mb-1">Type:</label>
										<select id="typeFilter" class="form-select" name="articleType" data-control="select2"
											data-placeholder="All Type" >
											<option value="ALL">All Type</option>
											<c:forEach var="item" items="${articleTypeList}">
												<option value="${item.name}">${item.name}</option>
											</c:forEach>

										</select>
									</div>
									<!-- Date Range -->
									<div class="col-12 col-md-4">
										<div class="mb-5">
											<label for="publicDate" class="form-label mb-1">Public
												Date:</label>
												 <input class="form-control" placeholder="Public Date" id="dateFilterTop"/> 
												<form id="dateFilterForm" method="post" action="article_feed">
												    <input type="hidden" name="startDate" id="startDateInput">
												    <input type="hidden" name="endDate" id="endDateInput">
												</form>
												
										</div>
									</div>
								</div>

							</div> --%>
						</div>
					</div>


					<!-- <div class="fs-7 fw-medium text-muted mb-4">Showing 18 of 100
						items</div> -->

					<div id="tableViewContainer" class="card table-responsive">
						<div class="card-header border-0 px-9 pt-7 d-flex align-items-center justify-content-between">
							
							<div class="card-title">
								<h3 class="fw-semibold text-gray-900">Page URL</h3>
							</div>

							<a class="btn btn-lg btn-success fw-medium text-white px-6 py-4"
								href="/page_uri_add"><i class="ki-outline ki-plus fs-3 me-1"></i>Create</a>
							
						</div>
							<div class="card-body table-responsive">
										
								<table id="myTable"
									class="table table-striped table-row-dashed table-hover fs-6 gy-5 gx-5 gs-5 mb-0 dataTable text-start">
									<thead>
										<tr
											class="text-gray-500 fw-bold fs-7 text-uppercase gs-0">
											<th class="w-75px text-center ">#</th>
											<th class="w-150px text-start">Page URL</th>
											<th class="w-150px">Forward To</th>
											<th class="w-150px">Mode ID</th>
											<th class="w-250px">Title</th>
											<th class="w-250px">Meta</th>
											<th class="w-150px text-end">Action</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="pageUrl" items="${pageUriList}" varStatus="">
											<tr>
												<td class="fw-bold text-gray-800 text-center row-number "></td>
												<td class="fs-6 fw-normal text-gray-900">${empty pageUrl.pageUriId ? '-' : pageUrl.pageUriId}</td>
												<td class="fs-6 fw-normal text-gray-900">${empty pageUrl.forwardTo ? '-' : pageUrl.forwardTo}</td>
												<td class="fs-6 fw-normal text-gray-900">${empty pageUrl.model ? '' : pageUrl.model} ${not empty pageUrl.modelId ? '- ' : '-'}${pageUrl.modelId }</td>
												<td class="fs-6 fw-normal text-gray-900">${empty pageUrl.pageUriTitle ? '-' : pageUrl.pageUriTitle}</td>
												<td class="fs-6 fw-normal text-gray-900">${empty pageUrl.meta ? '-' :pageUrl.meta}</td>
												<td>
													<div class="d-flex justify-content-end align-items-center gap-2">
														<%-- <a href="article_preview?articleId=${pageUrl.pageUriId}"
															class="btn btn-icon btn-light-info btn-sm me-2"
															title="View"> <i class="ki-duotone ki-eye fs-2"><span
																class="path1"></span><span class="path2"></span><span
																class="path3"></span></i>
														</a> --%> <a href="page_uri_edit?pageUriId=${pageUrl.pageUriId}"
															class="btn btn-icon btn-light-primary btn-sm me-2"
															title="Edit"> <i class="ki-duotone ki-pencil fs-2"><span
																class="path1"></span><span class="path2"></span></i>
														</a> <a href="page_uri_perform_delete?pageUriId=${pageUrl.pageUriId}&forwardTo=${pageUrl.forwardTo}" onclick="return confirmDelete(this.href);"
															class="btn btn-icon btn-light-danger btn-sm" title="Delete">
															<i class="ki-duotone ki-trash fs-2"><span
																class="path1"></span><span class="path2"></span><span
																class="path3"></span><span class="path4"></span><span
																class="path5"></span></i>
														</a>
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

	<script type="text/javascript">
	
		document.addEventListener("DOMContentLoaded", function () {
			var table = $('#myTable').DataTable({
				pageLength : 10,
				lengthMenu : [ 10, 20, 50, 100 ],
				ordering : true,
				searching : true,
				autoWidth : false,
				info: false,
				columnDefs : [ {
						orderable : false,
						targets : [ 5 ]
				}, {
					orderable : true,
					targets : [ 0, 1, 2, 3, 4 ]
				} ],
				order : [],
				headerCallback : function(thead) {
					$(thead).find('th').each(
							function() {
								if ($(this).find('.th-wrapper').length === 0) {
									$(this).wrapInner(
											'<span class="th-wrapper" style="display:inline-flex; align-items:center; white-space:nowrap; pointer-events:none;"></span>');
									}
								});
					},
					
			});
							
			//search
			$('#tableSearch').on('keyup', function() {
				table.search(this.value).draw();
		    });

			$(document).ready(function() {
				$('[data-kt-select2="true"]').select2({
					closeOnSelect : false
					});
			});

			//running number
			function runNumber() {
				const info = table.page.info();
				table.column(0, {
					page : 'current'
						}).nodes().each(function(cell, i) {
							cell.innerHTML = info.start + i + 1;
							});
				}
			
			table.on('draw.dt order.dt search.dt', runNumber);
			runNumber();	
	});
		
		
	</script>
	

	<script>
	function confirmDelete(url){
		
	    Swal.fire({
	        title: "Are you sure?!",
	        text: "Are you sure you want to delete this page url?",
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
	            window.location.href = url;
	        }
	    });
	    return false;
	}
	</script>


</body>
</html>