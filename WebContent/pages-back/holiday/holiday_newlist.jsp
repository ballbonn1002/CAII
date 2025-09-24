<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
    // ป้องกัน NullPointer ถ้าไม่มี param.year
    String yearParam = request.getParameter("year");
%>
<html>
<head>
<meta charset="UTF-8" />
<title>Holiday List</title>

<!-- Metronic core -->
<link
	href="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.css"
	rel="stylesheet" type="text/css" />
<script
	src="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.js"></script>

<!-- DataTables (Metronic bundle) -->
<link
	href="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.css"
	rel="stylesheet" type="text/css" />
<script
	src="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.js"></script>

</head>
<body>
	<!--begin::Main-->
	<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
		<!--begin::Content wrapper-->
		<div class="d-flex flex-column flex-column-fluid">
			<!--begin::Toolbar-->
			<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
				<div id="kt_app_toolbar_container"
					class="app-container container-xxl d-flex flex-stack">
					<!--begin::Page title-->
					<div
						class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
						<h1
							class="page-heading d-flex text-gray-900 fw-bold fs-3 flex-column justify-content-center my-0">Holiday</h1>
						<ul
							class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
							<li class="breadcrumb-item text-muted"><a
								href="${pageContext.request.contextPath}/demo_dashboard"
								class="text-muted text-hover-primary">Home</a></li>
							<li class="breadcrumb-item"><span
								class="bullet bg-gray-500 w-5px h-2px"></span></li>
							<li class="breadcrumb-item text-muted">Holiday</li>
						</ul>
					</div>
					<!--end::Page title-->
				</div>
			</div>
			<!--end::Toolbar-->

			<!--begin::Content-->
			<div id="kt_app_content" class="app-content flex-column-fluid">
				<div id="kt_app_content_container"
					class="app-container container-xxl">
					<!--begin::Card-->
					<div class="card">
						<div class="card-header border-0 pt-6 mb-6 align-items-start">
							<div class="card-title">
								<h1 class="page-heading d-flex text-gray-900 fw-bold fs-3 my-0">Holiday
									List</h1>
							</div>

							<div class="card-toolbar d-flex flex-column align-items-end">
								<!-- Buttons row -->
								<div class="d-flex mb-3">
<!--  								<button type="button" class="btn btn-light-primary me-3"
										data-kt-menu-trigger="click"
										data-kt-menu-placement="bottom-end">Template</button>

									<button type="button" class="btn me-3 text-info fw-semibold"
										style="background-color: #E3D7FB;" data-bs-toggle="modal"
										data-bs-target="#kt_customers_export_modal">Import</button>
-->	
									<button type="button" class="btn btn-primary" onclick="add()">New</button>
									<a href="javascript:;" title=""> </a>
								</div>


							</div>
						</div>

						<div class="card-body pt-0">
							<!-- Year filter -->
							<div class="d-flex justify-content-end mb-7">
								<!-- Year filter -->
								<form class="w-150px position-relative" onsubmit="return false;">
									<i
										class="ki-duotone ki-calendar-8 position-absolute top-50 translate-middle-y ms-3 text-gray-500 pe-none">
										<span class="path1"></span><span class="path2"></span><span
										class="path3"></span> <span class="path4"></span><span
										class="path5"></span><span class="path6"></span>
									</i> 
<select id="filterYear" class="form-select ps-10" aria-label="Select year">
  <option value="all" <c:if test="${isAll}">selected</c:if>>All</option>
  <c:forEach var="holiday_year" items="${holidayList_year}">
    <option value="${holiday_year}"
      <c:if test="${
        !isAll && (
          (not empty selectedYear && selectedYear == holiday_year)
        )
      }">selected</c:if>>
      ${holiday_year}
    </option>
  </c:forEach>
</select>

								</form>
							</div>


							<!--begin::Table-->
							<table
								class="table table-striped table-hover align-middle table-row-bordered fs-6 gy-5"
								id="kt_customers_table"
								style="table-layout: fixed; width: 100%;">
								<thead>
									<tr
										class="text-start text-gray-500 fw-bold fs-7 text-uppercase gs-0">
										<th style="width: 60px;" class="ps-4 text-start">#</th>

										<th class="min-w-125px">Start Date</th>
										<th class="min-w-125px">End Date</th>
										<th class="min-w-125px">Name</th>
										<th class="min-w-125px">Description</th>
										<th class="text-end min-w-70px">Actions</th>
									</tr>
								</thead>

								<tbody class="fw-semibold text-gray-600">
									<c:forEach var="holiday" items="${holidayList}" varStatus="st">
										<tr class="align-middle">
											<td class="ps-4 fw-bold text-gray-800 text-start text-nowrap">${st.count}</td>
											<c:choose>
												<c:when
													test="${not empty holiday.end_date and holiday.end_date ne holiday.start_date}">
													<td class="text-gray-900"><fmt:formatDate
															value="${holiday.start_date}" pattern="d MMM yyyy" /></td>
													<td class="text-gray-900"><fmt:formatDate
															value="${holiday.end_date}" pattern="d MMM yyyy" /></td>
												</c:when>
												<c:otherwise>
													<td class="text-gray-900"><fmt:formatDate
															value="${holiday.start_date}" pattern="d MMM yyyy" /></td>
													<td class="text-gray-900"></td>
												</c:otherwise>
											</c:choose>

											<!-- Name -->
											<td class="text-gray-900">${holiday.head}</td>

											<!-- Description -->
											<td class="text-gray-900"
												style="white-space: normal; max-width: 280px; word-wrap: break-word;">
												${holiday.description}</td>

											<!-- Actions -->
											<td class="text-end text-nowrap pe-5" style="width: 120px;">
												<div
													class="d-inline-flex align-items-center justify-content-end gap-2">
													<!-- Edit -->
													<button type="button" class="btn btn-icon btn-sm"
														aria-label="Edit"
														style="background-color: #D1E6FF; border-color: #D1E6FF;"
														onclick="window.location.href='${pageContext.request.contextPath}/holiday_edit?id=${holiday.id_date}&flag=1'">
														<i class="ki-duotone ki-pencil fs-5"
															style="color: var(--bs-primary);"> <span
															class="path1"></span><span class="path2"></span>
														</i>
													</button>

													<!-- Delete -->
													<button type="button"
														class="btn btn-icon btn-sm btn-delete-holiday"
														data-id="${holiday.id_date}" aria-label="Delete"
														style="background-color: #FED4DE; border-color: #FED4DE;">
														<i class="ki-duotone ki-trash fs-5"
															style="color: var(--bs-danger);"> <span class="path1"></span><span
															class="path2"></span><span class="path3"></span> <span
															class="path4"></span><span class="path5"></span>
														</i>
													</button>
												</div>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<!--end::Table-->
						</div>
					</div>
					<!--end::Card-->
				</div>
			</div>
			<!--end::Content-->
		</div>
		<!--end::Content wrapper-->
	</div>
	<!--end::Main-->

	<script>
        function add() {

            var today = moment().format('DD-MM-YYYY');
            window.location.href = "${pageContext.request.contextPath}/holiday_add?flag=1&date_cal=" + encodeURIComponent(today) + "&flag=1";
        }
    </script>

	<script>
  document.querySelectorAll('.btn-delete-holiday').forEach(function(button) {
    button.addEventListener('click', function() {
      var holidayId = this.getAttribute('data-id');
      Swal.fire({
        title: 'Are you sure?',
        text: "You won't be able to revert this!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, delete it!'
      }).then((result) => {
        if (result.isConfirmed) {
          window.location.href =
            '${pageContext.request.contextPath}/DeleteHoliday?id=' + encodeURIComponent(holidayId);
        }
      });
    });
  });
</script>


	<script>
        // ===== Year Filter redirect =====
        (function () {
            var sel  = document.getElementById('filterYear');
            var base = '${pageContext.request.contextPath}/holiday_list';
            sel.addEventListener('change', function () {
                var y = this.value;
                if (!y || y === 'all') {
                    window.location.href = base;
                } else {

                    window.location.href = base + '?year=' + encodeURIComponent(y);
                }
            });
        })();
    </script>

	<script>
        $(document).ready(function () {
            $('#kt_customers_table').DataTable({
                searching: false,
                pageLength: 25,
                lengthMenu: [25, 50, 100],
                ordering: false,
                responsive: false,
                columnDefs: [
                    { orderable: false, targets: [0, 5] }
                ],
                dom:
                  "t" +
                  "<'row mt-5'" +
                    "<'col-sm-12 col-md-5 d-flex align-items-center justify-content-center justify-content-md-start'l>" +
                    "<'col-sm-12 col-md-7 d-flex align-items-center justify-content-center justify-content-md-end'p>" +
                  ">"
            });
        });
    </script>
</body>
</html>
