<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/permission.tld" prefix="perm"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PR - Purchase Requisition</title>

<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

<link href="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.js"></script>

<link href="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.js"></script>

<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style type="text/css">
.ps-12 {
	padding-left: 3rem !important;
}

.search-icon {
	position: absolute;
	top: 50%;
	left: 14px;
	transform: translateY(-50%);
	z-index: 10;
	pointer-events: none;
}

/* Status summary numbers */
.summary-num {
	font-size: 1.75rem;
	font-weight: 700;
	line-height: 1;
}

/* Custom status colors that are not part of default Bootstrap */
.badge-inprogress {
	background: #17C3E6;
	color: #fff;
}

.badge-return {
	background: #7239EA;
	color: #fff;
}

.status-summary .badge {
	font-size: .8rem;
	padding: .45rem .65rem;
}

.count-badge {
	min-width: 24px;
}

/* DataTables Select Length Style Customization */
.dataTables_length select {
	display: inline-block;
	width: auto;
	padding: 0.375rem 2.25rem 0.375rem 0.75rem;
	font-size: 0.875rem;
	font-weight: 500;
	line-height: 1.5;
	border-radius: 0.475rem;
	background-position: right 0.75rem center;
	background-size: 16px 12px;
	background-repeat: no-repeat;
	appearance: none;
	-webkit-appearance: none;
	-moz-appearance: none;
}
[data-bs-theme="light"] .dataTables_length select {
	background-color: #F9F9F9 !important;
	color: #181C32 !important;
	border-radius: 0.475rem !important;
}
[data-bs-theme="dark"] .dataTables_length select {
	background-color: #1B1C22 !important;
	color: #92929F !important;
	border: 1px solid #323248 !important;
	border-radius: 0.475rem !important;
}
[data-bs-theme="dark"] .swal2-popup {
	background-color: #1E1E2D !important;
	color: #FFFFFF !important;
	border: 1px solid #323248;
}
[data-bs-theme="dark"] .swal2-title {
	color: #FFFFFF !important;
}
[data-bs-theme="dark"] .swal2-html-container {
	color: #A1A5B7 !important;
}

.status-grid {
    display: grid;
    grid-template-columns: repeat(4, max-content);
    gap: 1.25rem 2.5rem; 
    justify-content: center;
}

.status-box {
    display: flex;
    align-items: center;
    justify-content: center; 
    gap: 0.75rem; 
    padding: 1.5rem; 
    border-radius: 0.475rem;
    border: 0.1rem solid transparent; 
    cursor: pointer;
    transition: all 0.2s ease-in-out;
}

.status-box:hover {
	background-color: rgba(0, 0, 0, 0.02);
}

.status-box.active-all { border-color: #009ef7; }
.status-box.active-draft { border-color: #e4e6ef; }
.status-box.active-pending { border-color: #ffc700; }
.status-box.active-approved { border-color: #50cd89; }
.status-box.active-inprogress { border-color: #17C3E6; }
.status-box.active-return { border-color: #7239EA; }
.status-box.active-rejected { border-color: #f1416c; }
.status-box.active-closed { border-color: #181c32; }
</style>
</head>
<body>
	<div class="app-main flex-column app-container container-xxl">
		<div class="page-title d-flex justify-content-between align-items-center py-3">
			<div>
				<h1 class="page-heading text-gray-900 fw-bold fs-3">PR - Purchase Requisition</h1>
				<ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
                    <li class="breadcrumb-item text-muted"><a href="${pageContext.request.contextPath}/demo_dashboard" class="text-muted text-hover-primary">Home</a></li>
                    <li class="breadcrumb-item"><span class="bullet bg-gray-500 w-5px h-2px"></span></li>
                    <li class="breadcrumb-item text-muted"><a class="text-muted text-hover-primary">Product</a></li>
                </ul>
			</div>
		</div>
		<div class="app-content">

			<div class="card mb-5">
				<div class="card-body">
					<form id="prForm" class="w-100" action="purchaseRequisitionSearch" method="post">
						<div class="d-flex gap-5">
							<div class="position-relative w-100">
								<i class="ki-duotone ki-magnifier search-icon fs-3"> 
									<span class="path1"></span> <span class="path2"></span>
								</i> 
								<input type="text" class="form-control ps-12" id="search" name="search" placeholder="Search" value="${search}" />
							</div>
							<div class="position-relative" style="min-width: 320px;">
								<div class="input-group">
									<span class="input-group-text bg-transparent">
										<i class="ki-duotone ki-calendar-8 fs-3"> 
											<span class="path1"></span> <span class="path2"></span> 
											<span class="path3"></span> <span class="path4"></span> 
											<span class="path5"></span> <span class="path6"></span>
										</i> 
									</span> 
									<input type="text" class="form-control border-start-0" id="dateRange" name="searchDateRange" value="${searchDateRange}" />
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>

			<div class="card">
				<div class="card-header pt-7 border-0 d-flex justify-content-between align-items-center">
					<h3 class="fw-bold text-gray-900 fs-3">PR - Purchase Requisition</h3>
					<a href="${pageContext.request.contextPath}/purchase_requisition_create" class="btn btn-md btn-success ">
                        <i class="ki-duotone ki-plus fs-2"></i> Create
                    </a>
				</div>
	
				<div class="card-body pb-0">
				    <div class="status-grid mb-5">
				        
				        <div class="status-box active-all" data-status="" data-active="active-all">
				            <span class="summary-num text-primary">13</span>
				            <span class="badge bg-primary text-white p-2.5 pt-2 pb-2">All</span>
				        </div>
				        
				        <div class="status-box" data-status="Draft" data-active="active-draft">
				            <span class="summary-num text-gray-800">13</span> 
				            <span class="badge bg-light text-black-700 fw-semibold p-2.5 pt-2 pb-2">Draft</span>
				        </div>
				        
				        <div class="status-box" data-status="Pending" data-active="active-pending">
				            <span class="summary-num text-warning">13</span> 
				            <span class="badge bg-warning text-white p-2.5 pt-2 pb-2">Pending</span>
				        </div>
				        
				        <div class="status-box" data-status="Approved" data-active="active-approved">
				            <span class="summary-num text-success">13</span> 
				            <span class="badge bg-success text-white p-2.5 pt-2 pb-2">Approved</span>
				        </div>
				        
				        <div class="status-box" data-status="In-Progress" data-active="active-inprogress">
				            <span class="summary-num" style="color: #17C3E6">13</span>
				            <span class="badge badge-inprogress p-2.5 pt-2 pb-2">In-Progress</span>
				        </div>
				        
				        <div class="status-box" data-status="Return" data-active="active-return">
				            <span class="summary-num" style="color: #7239EA">13</span>
				            <span class="badge badge-return p-2.5 pt-2 pb-2">Return</span>
				        </div>
				        
				        <div class="status-box" data-status="Rejected" data-active="active-rejected">
				            <span class="summary-num text-danger">13</span> 
				            <span class="badge bg-danger text-white p-2.5 pt-2 pb-2">Rejected</span>
				        </div>
				        
				        <div class="status-box" data-status="Closed" data-active="active-closed">
				            <span class="summary-num text-gray-900">13</span> 
				            <span class="badge bg-dark text-white p-2.5 pt-2 pb-2">Closed</span>
				        </div>
				        
				    </div>
				</div>

				<div class="table-responsive">
					<table class="table fs-6 gy-5" id="table">
						<thead class="text-gray-500 fw-bold fs-7">                
                            <tr class="text-start text-gray-500 fw-bold fs-7 text-uppercase gs-0 border-bottom border-gray-200">
                                <th style="width: 4%; text-align: left; padding-left: 3.5%">#</th>
                                <th style="width: 10%; text-align: center">PR ID</th>
                                <th style="width: 10%; text-align: center">MR ID</th>
                                <th style="width: 28%; text-align: center">REQUEST NAME</th>
                                <th style="width: 18%; text-align: center">REQUEST DATE</th>
                                <th style="width: 10%; text-align: center">PRODUCT ITEM</th>
                                <th style="width: 10%; text-align: center">STATUS</th>
                                <th style="width: 10%; text-align: center">ACTION</th>
                            </tr>
                        </thead>
						<tbody>
							<c:forEach var="pr" items="${prList}" varStatus="loop">
								<tr class="border-bottom fs-6 fw-normal align-middle text-start">
									<td class="text-center"></td>
									<td class="fw-bold">${pr.prId}</td>
									<td>
										<c:choose>
											<c:when test="${not empty pr.mrIds}">
												<div class="d-flex flex-column">
													<c:forEach var="mr" items="${pr.mrIds}">
														<span>${mr}</span>
													</c:forEach>
												</div>
											</c:when>
											<c:otherwise>
												<span class="text-gray-500">-</span>
											</c:otherwise>
										</c:choose>
									</td>
									<td>${pr.requestName}</td>
									<td>
										<fmt:formatDate value="${pr.requestDate}" pattern="d MMM yyyy, HH:mm" />
									</td>
									<td class="text-center">${pr.productItem}</td>
									<td class="text-center">
										<div class="d-flex align-items-center justify-content-center gap-2">
											<c:if test="${pr.status == 'Draft'}">
												<span class="text-gray-700 fw-semibold">Draft</span>
											</c:if>
											<c:if test="${pr.status == 'Pending'}">
												<span class="badge bg-warning text-white">Pending</span>
											</c:if>
											<c:if test="${pr.status == 'Approved'}">
												<span class="badge bg-success text-white">Approved</span>
											</c:if>
											<c:if test="${pr.status == 'Return'}">
												<span class="badge badge-return">Return</span>
											</c:if>
											<c:if test="${pr.status == 'Rejected'}">
												<span class="badge bg-danger text-white">Rejected</span>
											</c:if>
											<c:if test="${pr.status == 'Closed'}">
												<span class="badge bg-dark text-white">Closed</span>
											</c:if>
											<c:if test="${pr.status == 'In-Progress'}">
												<c:if test="${not empty pr.progressCount}">
													<span class="badge badge-inprogress count-badge text-center">${pr.progressCount}</span>
												</c:if>
												<span class="badge badge-inprogress">In-Progress</span>
											</c:if>
										</div>
									</td>
									<td class="text-center">
										<div class="d-flex align-items-center justify-content-center gap-2">
											<a href="purchase_requisition_detail?id=${pr.prId}" class="btn btn-sm btn-icon btn-light-primary">
												<i class="ki-duotone ki-pencil fs-4"> <span class="path1"></span><span class="path2"></span></i>
											</a>
											<a href="javascript:void(0);" onclick="deletePR('${pr.prId}')" class="btn btn-sm btn-icon btn-light-danger"> 
												<i class="ki-duotone ki-trash fs-4">
													<span class="path1"></span> <span class="path2"></span> 
													<span class="path3"></span> <span class="path4"></span> 
													<span class="path5"></span>
												</i>
											</a>
										</div>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>

				<div class="card-footer id="table-footer-container" style="display: none;"></div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		$(function() {
			flatpickr("#dateRange", {
				mode : "range",
				dateFormat : "Y-m-d",
				altInput : true,
				altFormat : "d M Y",
				allowInput : true
			});

			$.fn.dataTable.ext.errMode = 'none';

			const table = $('#table').DataTable({
				scrollCollapse : true,
				autoWidth : false,
				responsive : true,
				language : {
					emptyTable : "No Data"
				},
				searching : true,            
				info : false,
				paging : true,               
				pageLength : 25,             
				lengthMenu : [10, 25, 50, 100], 
				columnDefs : [ {
					orderable : true,
					targets : [0, 1, 2, 3, 4, 5, 6]
				}, {
					orderable : false,
					targets : [ 7 ]
				} ],
				order : [],
				dom:
                    "t" +
                    "<'row card-footer d-flex justify-content-between align-items-center flex-wrap gap-3'" +
                    "<'col-sm-12 col-md-5 d-flex align-items-center justify-content-center justify-content-md-start'l>" +
                    "<'col-sm-12 col-md-7 d-flex align-items-center justify-content-center justify-content-md-end'p>" +
                    ">"
			});

			$('.dataTables_length select').addClass('form-select form-select-sm form-select-solid');

			function renumber() {
				const info = table.page.info();
				table.column(0, { search:'applied', order:'applied', page:'current' })
				.nodes().each(function (cell, i) { 
					cell.textContent = info.start + i + 1; 
				});
			}

			table.on('draw.dt order.dt search.dt', renumber);
			renumber();

			$('.status-box').on('click', function() {
				$('.status-box').removeClass('active-all active-draft active-pending active-approved active-inprogress active-return active-rejected active-closed');
				
				const activeClass = $(this).data('active');
				$(this).addClass(activeClass);
				
				const statusText = $(this).data('status');
				table.column(6).search(statusText).draw();
			});

			table.columns.adjust();
			$(window).on('resize', () => table.columns.adjust());

			let searchTimer;
			$('#search').on('keyup', function() {
				clearTimeout(searchTimer);
				searchTimer = setTimeout(function() {
					$('#prForm').submit();
				}, 500);
			});
		});

		function deletePR(prId) { 
			Swal.fire({
				title: 'Confirm Deletion',
				text: "Are you sure you want to delete " + prId + " ?",
				icon: 'warning',
				showCancelButton: true,
				customClass: { confirmButton: "btn btn-danger", cancelButton: "btn btn-secondary" },
				reverseButtons: true,
				confirmButtonText: 'Yes, delete it!',
				cancelButtonText: 'Cancel'
			}).then((result) => {
				if (result.isConfirmed) {
					window.location.href = "${pageContext.request.contextPath}/purchase_requisition_delete?id=" + prId; 
				}
			});
		}
	</script>
</body>
</html>