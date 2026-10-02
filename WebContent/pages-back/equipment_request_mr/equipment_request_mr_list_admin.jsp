<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/permission.tld" prefix="perm"%>
<fmt:setLocale value="en_US" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link href="assets/plugins/global/plugins.bundle.css" rel="stylesheet" type="text/css"/>

<script
	src="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.js"></script>
<script
	src="${pageContext.request.contextPath}/assets/js/scripts.bundle.js"></script>
<link
	href="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.css"
	rel="stylesheet" type="text/css" />
<script
	src="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.js"></script>

<style type="text/css">
[data-bs-theme="light"] #equipmentRequestMrList.table.table-striped > tbody > tr:nth-of-type(odd) > * {
    background-color: #FBFBFB !important; 
    box-shadow: none !important;
  }
 [data-bs-theme="dark"] #equipmentRequestMrList.table.table-striped > tbody > tr:nth-of-type(odd) > * {
    background-color: #191B20 !important; 
    box-shadow: none !important;
  }

#equipmentRequestMrList thead th.sorting:after, #equipmentRequestMrList thead th.sorting_asc:after,
#equipmentRequestMrList thead th.sorting_desc:after, #equipmentRequestMrList thead th.sorting:before,	
#equipmentRequestMrList thead th.sorting_asc:before, #equipmentRequestMrList thead th.sorting_desc:before
	{
	position: absolute !important;
	top: 10px !important;
	right: 10px !important;
	display: block !important;
	opacity: 0.5;
}

#equipmentRequestMrList thead th.sorting:before {
	margin-top: -6px;
}

#equipmentRequestMrList thead th.sorting:after {
	margin-top: 4px;
}

</style>


</head>
<body class="app-default">
	<div class="app-main flex-column flex-row-fluid">
		<div class="d-flex flex-column flex-column-fluid">
			<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
				<div id="kt_app_toolbar_container" class="app-container container-fluid d-flex flex-stack">
					<div class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
						<h1 class="page-heading d-flex text-gray-700 fw-semibold flex-column justify-content-center my-0">
							MR - Material Request</h1>
						<ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
							<li class="breadcrumb-item text-muted"><a
								class="text-muted text-hover-primary">Home</a>
							</li>
							<li class="breadcrumb-item"><span
								class="bullet bg-gray-500 w-5px h-2px"></span>
							</li>
							<li class="breadcrumb-item text-muted"><a
								class="text-muted text-hover-primary">Product</a>
							</li>
						</ul>
					</div>
				</div>
			</div>

			<div id="kt_app_content" class="app-content flex-column-fluid">
				<div id="kt_app_content_container" class="app-container container-fluid">
					<form action="" method="post" id="filterForm">
						<div class="card mb-10">
							<div class="card-body filter-card px-10 py-9 rounded-3">
								<div class="row g-5">
									<div class="col-md-9 position-relative">
										<!-- Search -->
										<i class="ki-duotone ki-magnifier fs-3 position-absolute ms-5 top-50 translate-middle-y">
											<span class="path1"></span><span class="path2"></span></i> <input
											type="text" class="form-control form-solid ps-14"
											id="tableSearch" placeholder="All">
									</div>
									<div class="col-md-3">
										<div class="position-relative d-flex align-items-center">
									        <i class="ki-duotone ki-calendar-8 position-absolute ms-4 mb-1 text-gray-500 fs-2">
									            <span class="path1"></span>
									            <span class="path2"></span>
									            <span class="path3"></span>
									            <span class="path4"></span>
									            <span class="path5"></span>
									            <span class="path6"></span>
									        </i>
									        <input class="form-control ps-12"
									               id="kt_daterangepicker_2" placeholder="Select date"/>
									    </div>
									</div>
								</div>
							</div>
						</div>
					</form>
					<div class="card mb-10">
						<div class="card-header border-0 px-9 pt-7 d-flex align-items-center justify-content-between">
							<div class="card-title">
								<h3 class="fw-semibold text-gray-900">Equipment Request  List</h3>
							</div>
							<a class="btn btn-lg btn-success fw-medium text-white px-6 py-4"
								href="/equipment_request_mr_add"><i class="ki-outline ki-plus fs-3 me-1"></i>Create</a>
						</div>
						<div class="card-body filter-card px-10 py-9 rounded-3">
							<!-- Summary MR -->
							<div class="d-flex flex-row justify-content-center mb-10">
								<div class="d-flex flex-wrap justify-content-center align-items-center mt-10 mx-5 fs-6 fw-bold gap-12">

									<!-- All -->
									<div class="d-flex align-items-center justify-content-center summary-card border border-1 border-primary rounded-3 px-6 py-5 min-w-150px"
										data-status="All"
										data-border-color="border-primary"
										style="cursor: pointer;">
										<span class="fs-2hx me-2 text-primary summary-count" id="summaryMRAll">
											${mrSummaryTotal}
										</span>
										<span class="badge badge-primary fs-7">All</span>
									</div>

									<c:forEach var="st" items="${mrStatuses}">
										<c:set var="stColor" value="${mrStatusColors[st.statusCode]}" />
										<div class="d-flex align-items-center justify-content-center summary-card border border-1 border-transparent rounded-3 px-6 py-5 min-w-150px"
											data-status="${st.statusCode}"
											data-border-color="${stColor == 'secondary' ? 'border-gray-400' : 'border-'.concat(stColor)}"
											style="cursor: pointer;">
											<span class="fs-2hx me-2 summary-count ${stColor == 'secondary' ? 'text-gray-600' : 'text-'.concat(stColor)}">
												${mrSummary[st.statusCode]}
											</span>
											<span class="badge badge-${stColor} fs-7">
												${mrStatusNames[st.statusCode]}
											</span>
										</div>
									</c:forEach>

								</div>
							</div>

							<div class="table-responsive ">
								<table id="equipmentRequestMrList"
										class="table table-striped gy-7 gs-7 table-hover border-gray-300 table-row-bordered table-row-gray-200 ">
									<thead class="border-bottom-1 text-uppercase">
										<tr class="fs-7 fw-bold text-gray-500">
											<th class="min-w-50px text-center">#</th>
											<th class="min-w-100px">MR ID</th>
											<th class="min-w-130px">Category</th>
											<th class="min-w-150px">Product Name</th>
											<th class="min-w-130px">Quantity / Unit</th>
											<th class="min-w-225px">Request By</th>
											<th class="min-w-130px text-end px-3">Status</th>
											<th class="min-w-130px text-end px-3">Actions</th>
										</tr>
									</thead>

									<tbody>
									<c:forEach var="mrItem" items="${mrList}">
										<tr class="align-middle">
											<td class="text-gray-900 fs-6 fw-normal text-center row-number"></td>
											<td class="text-gray-900 fs-6 fw-normal text-start">
												<c:out value="${mrItem.mr_id}" />
											</td> 
											<td class="text-gray-900 fs-6 fw-normal text-start">
												<c:choose>
													<c:when test="${mrItem.product_type == '1'}">
														<div class="symbol symbol-40px d-flex align-items-center">
															<i class="ki-duotone ki-monitor-mobile fs-2 text-primary me-2">
																<span class="path1"></span><span class="path2"></span>
															</i> Equipment
														</div> 
													</c:when>
													<c:when test="${mrItem.product_type == '2'}">
														<div class="symbol symbol-40px d-flex align-items-center">
															<i class="ki-duotone ki-lots-shopping fs-2 text-orange me-2">
																<span class="path1"></span><span class="path2"></span>
																<span class="path3"></span><span class="path4"></span>
																<span class="path5"></span><span class="path6"></span>
																<span class="path7"></span><span class="path8"></span>
															</i>Consumables
														</div>
													</c:when>
													<c:when test="${mrItem.product_type == '3'}">
														<div class="symbol symbol-40px d-flex align-items-center me-2">
															<i class="ki-duotone ki-medal-star fs-2 text-teal">
																<span class="path1"></span><span class="path2"></span>
																<span class="path3"></span><span class="path4"></span>
															</i>Accessory
														</div>
													</c:when>
													<c:when test="${mrItem.product_type == '4'}">
														<div class="symbol symbol-40px d-flex align-items-center me-2">
															<i class="ki-duotone ki-parcel fs-2 text-success">
																<span class="path1"></span><span class="path2"></span>
																<span class="path3"></span><span class="path4"></span>
																<span class="path5"></span>
															</i>Office Supplies
														</div>
													</c:when>
													<c:otherwise></c:otherwise>
												</c:choose>
											</td>
											<td class="text-gray-900 fs-6 fw-normal text-start">
												<c:choose>
													<c:when test="${not empty mrItem.product_name}">
														<c:out value="${mrItem.product_name}" />
													</c:when>
													<c:otherwise>-</c:otherwise>
												</c:choose>
											</td>
											<td class="text-gray-900 fs-6 fw-normal text-start">
												<fmt:formatNumber value="${mrItem.amount}" maxFractionDigits="2" />
												<c:if test="${not empty mrItem.unit_name}"> <c:out value="${mrItem.unit_name}" /></c:if>
											</td>
											
											<c:set var="reqDt" value="${not empty mrItem.request_date ? mrItem.request_date : mrItem.time_create}" />
											<td class="text-gray-900 fs-6 fw-normal text-start"
												data-date="<c:if test='${not empty reqDt}'><fmt:formatDate value='${reqDt}' pattern='yyyy-MM-dd' /></c:if>">
												<div class="d-flex align-items-center">
													<div class="symbol symbol-45px symbol-circle me-5 flex-shrink-0">
														<c:choose>
															<c:when test="${not empty mrItem.requestUserPath}">
																<img src="${pageContext.request.contextPath}${mrItem.requestUserPath}"
																	alt="<c:out value='${mrItem.requestUserName}' />" class="object-fit-cover" />
															</c:when>
															<c:otherwise>
																<span class="symbol-label bg-light-primary text-primary fw-bold fs-4">
																	<c:out value="${empty mrItem.requestUserName ? '?' : fn:toUpperCase(fn:substring(mrItem.requestUserName, 0, 1))}" />
																</span>
															</c:otherwise>
														</c:choose>
													</div>

													<div class="d-flex flex-column">
														<span class="text-gray-900 fs-6 fw-normal mb-3">
															<c:out value="${mrItem.requestUserName}" />
														</span>
														<span class="text-gray-900 fs-6 fw-normal">
															<c:if test="${not empty reqDt}">
																<fmt:formatDate value="${reqDt}" pattern="dd MMM yyyy, HH:mm" />
															</c:if>
														</span>
													</div>
												</div>
											</td>
											<td class="text-gray-900 fs-6 fw-normal text-end px-3" data-code="${mrItem.status_code}">
												<span class="badge badge-lg badge-${mrItem.status_color} fw-semibold fs-7 ${mrItem.status_color == 'secondary' ? 'text-dark' : 'text-white'}">
													${mrItem.status_name}
												</span>
											</td>
											<td class="text-end px-3">
												<div class="d-flex justify-content-end gap-2">
													<button type="button" data-note="btn edit" data-id="${fn:escapeXml(mrItem.mr_id)}" onclick="goToEditPage(this.dataset.id)" title="Edit"
														class="btn btn-icon btn-sm btn-light-info">
														<i class="ki-duotone ki-document btn-info fs-5">
															<span class="path1"></span>
															<span class="path2"></span>
															<span class="path3"></span>
															<span class="path4"></span>
															<span class="path5"></span>
															<span class="path6"></span>
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

</body>
<script type="text/javascript">
	const ctx = "${pageContext.request.contextPath}";
	const TRASH_ICON_HTML = '<i class="ki-duotone ki-trash fs-1">' +
		'<span class="path1"></span><span class="path2"></span>' +
		'<span class="path3"></span><span class="path4"></span></i>';

	function goToEditPage(mrId) {
		window.location.href = ctx + '/equipment_request_mr_approve?mrId=' + encodeURIComponent(mrId);
	}

	// Delete (Cancel) 
	document.addEventListener('click', function (e) {
		const btn = e.target.closest('.btn-delete-mr');
		if (!btn || btn.disabled) return;

		const mrId = btn.getAttribute('data-id');
		if (!mrId) return;

		Swal.fire({
			title: 'ลบรายการนี้?',
			html: 'MR <strong>#' + $('<div>').text(mrId).html() + '</strong> จะถูกเปลี่ยนสถานะเป็น Cancel',
			icon: 'warning',
			showCancelButton: true,
			confirmButtonText: 'ลบ',
			cancelButtonText: 'ยกเลิก',
			confirmButtonColor: '#F64E60',
			reverseButtons: true
		}).then(function (result) {
			if (!result.isConfirmed) return;

			btn.disabled = true;
			btn.innerHTML = '<span class="spinner-border spinner-border-sm"></span>';

			$.ajax({
				url: ctx + '/delete_mr',
				type: 'POST',
				dataType: 'json',
				data: { mrId: mrId },
				success: function (resp) {
					if (resp.data && resp.data.success) {
						Swal.fire({
							icon: 'success',
							title: 'ลบแล้ว',
							text: 'MR #' + mrId + ' ถูกยกเลิกเรียบร้อย',
							timer: 1500,
							showConfirmButton: false
						}).then(function () { 
							window.location.reload();
						});
					} else {
						btn.disabled = false;
						btn.innerHTML = TRASH_ICON_HTML;
						Swal.fire('Error', 'ไม่สามารถลบ MR นี้ได้ (ลบได้เฉพาะ MR ของตัวเองที่ยังเป็น Draft)', 'error');
					}
				},
				error: function () {
					btn.disabled = false;
					btn.innerHTML = TRASH_ICON_HTML;
					Swal.fire('Error', 'เกิดข้อผิดพลาดในการลบ', 'error');
				}
			});
		});
	});

	document.addEventListener("DOMContentLoaded", function () {
		var COL_REQUEST_DATE = 5; 
		var COL_STATUS = 6;
		var dateFrom = null;
		var dateTo = null;

		// ค่าเริ่มต้น
		var defaultStart = moment().startOf("year");
		var defaultEnd = moment().endOf("year");

		var $datePicker = $("#kt_daterangepicker_2");
		$datePicker.daterangepicker({
		    startDate: defaultStart,
		    endDate: defaultEnd,
		    autoUpdateInput: false,
		    locale: {
		        format: "D MMM YYYY",
		        cancelLabel: "Show all"
		    }
		});

		// ตั้งช่วงวันที่ที่กรอง + ข้อความใน input 
		function setDateRange(start, end) {
			dateFrom = start.format('YYYY-MM-DD');
			dateTo = end.format('YYYY-MM-DD');
			$datePicker.val(start.clone().locale('en').format('D MMM YYYY') + ' - ' + end.clone().locale('en').format('D MMM YYYY'));
		}

		var table = $('#equipmentRequestMrList').DataTable({
			pageLength : 25,
			lengthMenu : [ 25, 50, 100 ],
			ordering : true,
			searching : true,
			autoWidth : false,
			info: false,
			language: {
			    zeroRecords: "No data found",
			    emptyTable: "No data available in table"
			},
			columnDefs : [ {
				orderable : false,
				targets : [ 7 ]
			}, {
				orderable : true,
				targets : [ 0, 1, 2, 3, 4, 5, 6 ]
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
			}
		});

		//search
		$('#tableSearch').on('keyup', function() {
			table.search(this.value).draw();
	    });

		function passDateRange(rowDate) {
			if (dateFrom === null || dateTo === null) {
				return true;
			}
			if (!rowDate) {
				return false;
			}
			return rowDate >= dateFrom && rowDate <= dateTo;
		}

		function rowDateOf(tdNode) {
			return String($(tdNode).attr('data-date') || '').trim();
		}

		/* ---- Summary Card Filter ---- */
		var selectedStatusCode = null;
		$.fn.dataTable.ext.search.push(function(settings, searchData, dataIndex) {
			if (settings.nTable.id !== 'equipmentRequestMrList') {
				return true;
			}
			var cells = settings.aoData[dataIndex].anCells;
			if (!passDateRange(rowDateOf(cells[COL_REQUEST_DATE]))) {
				return false;
			}
			if (selectedStatusCode === null) {
				return true;
			}
			var cellCode = $(cells[COL_STATUS]).data('code');
			return String(cellCode) === String(selectedStatusCode);
		});

		$datePicker.on('apply.daterangepicker', function(ev, picker) {
			setDateRange(picker.startDate, picker.endDate);
			table.draw();
		});

		// ปุ่ม Show all ยกเลิกตัวกรองวันที่ แสดงทุกแถว
		$datePicker.on('cancel.daterangepicker', function() {
			dateFrom = null;
			dateTo = null;
			$(this).val('');
			table.draw();
		});

		// ตัวเลขบน card
		function updateSummaryCounts() {
			var counts = {};
			var total = 0;
			table.rows().nodes().each(function(tr) {
				var cells = tr.cells;
				if (!passDateRange(rowDateOf(cells[COL_REQUEST_DATE]))) {
					return;
				}
				total++;
				var code = String($(cells[COL_STATUS]).data('code'));
				counts[code] = (counts[code] || 0) + 1;
			});
			$('.summary-card').each(function() {
				var status = String($(this).data('status'));
				var n = (status === 'All') ? total : (counts[status] || 0);
				$(this).find('.summary-count').text(n);
			});
		}

		$('.summary-card').on('click', function() {
		    $('.summary-card').each(function() {
		        var colorClass = $(this).data('border-color');
		        $(this).removeClass(colorClass).addClass('border-transparent');
		    });

		    var activeColor = $(this).data('border-color');
		    $(this).removeClass('border-transparent').addClass(activeColor);

		    var status = $(this).data('status');
		    selectedStatusCode = (status === "All") ? null : status;
		    table.draw();
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
		table.on('draw.dt', updateSummaryCounts);

		setDateRange(defaultStart, defaultEnd);
		table.draw();
		updateSummaryCounts();
	});
</script>
</html>
