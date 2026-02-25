<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<style>
#kt_table_overtime {
	opacity: 0;
	transition: opacity 0.3s ease-in-out;
}

#kt_table_overtime.dt-loaded {
	opacity: 1;
}
</style>

<fmt:setLocale value="en_US" />
<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
	<div class="d-flex flex-column flex-column-fluid">
		<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
			<div id="kt_app_toolbar_container"
				class="app-container container-fluid d-flex flex-stack">
				<div
					class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
					<h1
						class="page-heading d-flex text-gray-700 fw-semibold flex-column justify-content-center my-0">Overtime
						Approve</h1>
					<ul
						class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
						<li class="breadcrumb-item text-muted">Home</li>
						<li class="breadcrumb-item"><span
							class="bullet bg-gray-500 w-5px h-2px"></span></li>
						<li class="breadcrumb-item text-muted">Admin Management</li>
					</ul>
				</div>
			</div>
		</div>

		<div id="kt_app_content" class="app-content flex-column-fluid">
			<div id="kt_app_content_container"
				class="app-container container-xxl">

				<div class="card mb-8">
					<div class="card-header border-0 my-3">
						<div class="card-title d-flex align-items-center gap-4 w-100 mb-0">
							<div class="position-relative w-100 flex-grow-1">
								<select id="employeeFilter"
									class="form-select form-select-lg h-55px py-3 fw-medium text-gray-700"
									data-placeholder="All" data-allow-clear="true">
									<option value=""></option>
								</select>
							</div>

							<div class="position-relative w-100 w-md-325px">
								<i
									class="ki-duotone ki-calendar-8 w-20px h-20px d-inline-block text-gray-500 position-absolute top-50 start-0 translate-middle-y ms-4"
									style="font-size: 20px; line-height: 20px;"> <span
									class="path1"></span><span class="path2"></span><span
									class="path3"></span> <span class="path4"></span><span
									class="path5"></span><span class="path6"></span>
								</i> <input type="text"
									class="form-control ps-14 h-55px cursor-pointer fw-medium text-gray-700"
									id="overtimeRangePicker" placeholder="Select date range"
									readonly />
							</div>
						</div>
					</div>
				</div>

				<div class="card">
					<div
						class="card-header border-bottom align-items-center min-h-60px">

						<div class="card-title">
							<h3
								class="page-heading d-flex align-items-center text-gray-900 fw-semibold my-0">
								Approve</h3>
						</div>

						<div class="card-toolbar m-0">
							<ul
								class="nav nav-stretch nav-line-tabs nav-line-tabs-2x border-transparent fs-6 fw-bold"
								id="statusTabs">
								<li class="nav-item"><a
									class="nav-link text-active-primary px-3 py-6 active" href="#"
									data-status="Wait for approve">Waiting</a></li>
								<li class="nav-item"><a
									class="nav-link text-active-primary px-3 py-6" href="#"
									data-status="Approved">Approved</a></li>
								<li class="nav-item"><a
									class="nav-link text-active-primary px-3 py-6" href="#"
									data-status="Rejected">Rejected</a></li>
							</ul>
						</div>

					</div>
					<div class="card-body py-4">
						<div class="table-responsive">
							<table
								class="table table-striped table-hover align-middle table-row-bordered"
								id="kt_table_overtime">
								<thead>
									<tr
										class="text-start text-gray-500 fw-bold fs-7 text-uppercase gs-0 border-bottom border-gray-200">
										<th class="min-w-100px w-100px text-center">#</th>
										<th>Name</th>
										<th>Start Date OT</th>
										<th>End Date OT</th>
										<th style="text-transform: none !important;">Actual (Hr)</th>
										<th class="min-w-150px w-150px">Status</th>
										<th class="text-end pe-5 min-w-100px w-100px">Actions</th>
									</tr>
								</thead>
								<tbody class="text-gray-900 fw-normal fs-6">
									<c:forEach var="ot" items="${overtimeList}" varStatus="vs">

										<fmt:formatNumber value="${ot.req_hours}" pattern="0.00"
											var="formattedReq" />
										<c:set var="displayReqHours"
											value="${fn:replace(formattedReq, '.', ':')}" />

										<c:set var="thaiName" value="${ot.user_id}" />
										<c:forEach var="u" items="${userList}">
											<c:if test="${u.id == ot.user_id}">
												<c:set var="thaiName" value="${u.name}" />
											</c:if>
										</c:forEach>

										<tr>
											<td class="text-center px-0 text-gray-900 fw-bold fs-7"></td>

											<td>${thaiName}</td>

											<td class="text-gray-900 fw-normal fs-6"><fmt:formatDate
													value="${ot.start_time}" pattern="d MMM yyyy, H:mm" /></td>

											<td class="text-gray-900 fw-normal fs-6"><fmt:formatDate
													value="${ot.end_time}" pattern="d MMM yyyy, H:mm" /></td>

											<td>
												<div class="d-flex align-items-center">
													<fmt:formatNumber value="${ot.appr_hours}" pattern="0.00"
														var="formattedAppr" />
													<c:set var="displayApprHours"
														value="${fn:replace(formattedAppr, '.', ':')}" />

													<c:choose>
														<c:when test="${ot.status_name eq 'Approved'}">
															<span
																class="badge badge-lg badge-light-${ot.status_color} fw-bold fs-7 h-25px">
																${displayApprHours} </span>
														</c:when>
														<c:otherwise>
															<span
																class="badge badge-lg badge-light-primary fw-bold fs-7 h-25px">
																${displayApprHours} </span>
														</c:otherwise>
													</c:choose>

													<c:if
														test="${ot.status_name eq 'Approved' and not empty ot.type_of_ot}">
														<fmt:formatNumber value="${ot.type_of_ot}" pattern="#.#"
															var="otTypeDisplay" />
														<span
															class="badge badge-lg badge-primary fw-bold fs-7 h-25px ms-2">
															${otTypeDisplay} X </span>
													</c:if>
												</div>
											</td>

											<td>
												<div class="d-flex flex-column align-items-start">
													<span
														class="badge badge-lg badge-light-${ot.status_color} fw-bold px-4 py-3 mb-1">
														${ot.status_name} </span>

													<c:if test="${not empty ot.description_appr}">
														<span class="fw-normal fs-6 text-gray-900 mt-2"
															style="display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;"
															title="<c:out value='${ot.description_appr}'/>"> <c:out
																value="${ot.description_appr}" />
														</span>
													</c:if>
												</div>
											</td>

											<td class="text-end pe-5"><a
												href="${pageContext.request.contextPath}/overtime_approve_form?ot_id=${ot.ot_id}"
												class="btn btn-icon btn-sm btn-light-info bg-info-subtle">
													<i class="ki-duotone ki-document fs-2"> <span
														class="path1"></span><span class="path2"></span>
												</i>
											</a></td>
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

<script>
$(document).ready(function () {
    const url = new URL(window.location.href);

    var userList = [
        <c:forEach var="u" items="${userList}">
            <c:if test="${u.enable ne '0'}">
                <c:set var="displayName" value="" />
                <c:if test="${not empty u.employeeId}">
                    <c:set var="displayName" value="${u.employeeId}" />
                </c:if>
                <c:if test="${not empty u.nameEN}">
                    <c:set var="displayName" value="${not empty displayName ? displayName.concat(' - ') : ''}${u.nameEN}" />
                </c:if>
                <c:if test="${not empty u.name}">
                    <c:set var="displayName" value="${not empty displayName ? displayName.concat(' - ') : ''}${u.name}" />
                </c:if>
                <c:if test="${not empty u.roleId}">
                    <c:set var="displayName" value="${displayName} - ${u.roleId}" />
                </c:if>
                {
                    id: "${u.id}",
                    displayName: "${fn:escapeXml(displayName)}"
                },
            </c:if>
        </c:forEach>
    ];

    userList.sort(function(a, b) {
        var nameA = (a.displayName || "").trim().toUpperCase();
        var nameB = (b.displayName || "").trim().toUpperCase();
        return nameA.localeCompare(nameB, 'en', { sensitivity: 'base' });
    });

    var $select = $('#employeeFilter');
    $select.empty();
    $select.append(new Option("All", "", false, false));

    userList.forEach(function(u) {
        $select.append(new Option(u.displayName, u.id, false, false));
    });

    $select.select2({
        placeholder: 'All',
        allowClear: true,
        width: '100%',
        matcher: function(params, data) {
            if ($.trim(params.term) === '') return data;
            if (typeof data.text === 'undefined') return null;
            
            var text = data.text.toUpperCase();
            var term = params.term.toUpperCase();
            var terms = term.split(' ').filter(function(t) { return t.length > 0; });
            var match = terms.every(function(t) { return text.indexOf(t) > -1; });
            return match ? data : null;
        }
    });

    // Date Range Picker 
    const savedUserId = url.searchParams.get("userId");
    const savedDateRange = url.searchParams.get("dateRange");

    const currentYear = new Date().getFullYear();
    const defaultStartDate = currentYear + "-01-01";
    const defaultEndDate = currentYear + "-12-31";

    if (savedUserId) {
        $select.val(savedUserId).trigger('change.select2');
    }

    function updateFilters(userIdVal, dateStr) {
        if (userIdVal) {
            url.searchParams.set("userId", userIdVal);
        } else {
            url.searchParams.delete("userId");
        }
        
        if (dateStr) {
            url.searchParams.set("dateRange", dateStr);
        } else {
            url.searchParams.delete("dateRange");
        }
        
        window.location.href = url.toString();
    }

    const fp = flatpickr("#overtimeRangePicker", {
        mode: "range",
        dateFormat: "Y-m-d",
        altInput: true,
        altFormat: "j M Y",
        defaultDate: (savedDateRange && savedDateRange.indexOf(" - ") > -1) 
                        ? savedDateRange.split(" - ") 
                        : [defaultStartDate, defaultEndDate],
        onClose: function(selectedDates, dateStr, instance) {
            if (selectedDates.length === 2) {
                var start = instance.formatDate(selectedDates[0], "Y-m-d");
                var end = instance.formatDate(selectedDates[1], "Y-m-d");
                var rangeStr = start + " - " + end;
                
                if (rangeStr !== savedDateRange) {
                    updateFilters($select.val(), rangeStr);
                }
            } else if (selectedDates.length === 0) {
                if (savedDateRange) {
                    updateFilters($select.val(), "");
                }
            }
        }
    });

    $select.on('change', function() {
        if ($(this).val() !== (savedUserId || "")) {
            let rangeStr = "";
            if (fp && fp.selectedDates.length === 2) {
                rangeStr = fp.formatDate(fp.selectedDates[0], "Y-m-d") + " - " + fp.formatDate(fp.selectedDates[1], "Y-m-d");
            }
            updateFilters($(this).val(), rangeStr);
        }
    });

	 // Data Table
	 var table = $('#kt_table_overtime').DataTable({
	     paging: true,
	     lengthChange: true,
	     lengthMenu: [ [10, 25, 50, -1], [10, 25, 50, "All"] ],
	     searching: true, 
	     info: false,
	     autoWidth: false,
	     order: [],
	     stateSave: false, 
	     language: {
	         emptyTable: "No Overtime Request",
	         loadingRecords: "Loading..." 
	     },
	     columnDefs: [
	         {
	             targets: 0,
	             orderable: true,
	             className: "text-center align-middle px-0"
	         },
	         {
	             targets: [1, 2, 3, 4, 5, 6],
	             orderable: false,
	             className: "align-middle"
	         }
	     ],
	     preDrawCallback: function(settings) {
	         if (!table || settings.iInitDisplayStart === 0) {
	             $('#kt_table_overtime').css('opacity', '0');
	         }
	     },
	     initComplete: function(settings, json) {
	         $('#kt_table_overtime').css({
	             'opacity': '1',
	             'transition': 'opacity 0.3s ease-in-out'
	         });
	     }
	 });
 
   table.on('order.dt search.dt', function () {
	    table.column(0, {search:'applied', order:'applied'}).nodes().each(function (cell, i) {
	        cell.innerHTML = i + 1;
	    });
	}).draw();

    // กรอง Status
    $('#statusTabs .nav-link').on('click', function(e) {
        e.preventDefault(); 
        
        $('#statusTabs .nav-link').removeClass('active');
        $(this).addClass('active');

        var statusKeyword = $(this).attr('data-status');
        table.column(5).search(statusKeyword, true, false).draw();
    });

    $('#statusTabs .nav-link.active').trigger('click');
});
</script>