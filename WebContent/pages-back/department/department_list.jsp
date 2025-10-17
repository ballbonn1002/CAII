<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />


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
/* Light Mode */
[data-bs-theme="light"] #kt_table.table.table-striped > tbody > tr:nth-of-type(odd) > * {
  background-color: #FBFBFB !important;
  box-shadow: none !important;
}
[data-bs-theme="light"] #kt_table.table-hover tbody tr:hover > *,
[data-bs-theme="light"] #kt_table.table-hover tbody tr:hover > td,
[data-bs-theme="light"] #kt_table.table-hover tbody tr:hover > th,
[data-bs-theme="light"] #kt_table.table.table-hover > tbody > tr:hover > *,
[data-bs-theme="light"] #kt_table.dataTable > tbody > tr:hover > * {
  background-color: #F9F9F9 !important;
  box-shadow: none !important;
  transition: background-color .15s ease-in-out;
}

/* Dark Mode */
[data-bs-theme="dark"] #kt_table.table.table-striped > tbody > tr:nth-of-type(odd) > * {
  background-color: #191B20 !important;
  box-shadow: none !important;
}
[data-bs-theme="dark"] #kt_table.table.table-striped > tbody > tr:nth-of-type(even) > * {
  background-color: #15171C !important;
  box-shadow: none !important;
}
[data-bs-theme="dark"] #kt_table.table-hover tbody tr:hover > *,
[data-bs-theme="dark"] #kt_table.table-hover tbody tr:hover > td,
[data-bs-theme="dark"] #kt_table.table-hover tbody tr:hover > th,
[data-bs-theme="dark"] #kt_table.table.table-hover > tbody > tr:hover > *,
[data-bs-theme="dark"] #kt_table.dataTable > tbody > tr:hover > * {
  background-color: #1B1C22 !important;
  box-shadow: none !important;
  transition: background-color .15s ease-in-out;
}
</style>
</head>
<body>
	<!--begin::Main-->
	<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
		<div class="d-flex flex-column flex-column-fluid">
			<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
				<div id="kt_app_toolbar_container"
					class="app-container container-xxl d-flex flex-stack">
					<div
						class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
						<h1
							class="page-heading d-flex text-gray-900 fw-bold fs-3 flex-column justify-content-center my-0">Department</h1>
						<ul
							class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
							<li class="breadcrumb-item text-muted"><a
								href="${pageContext.request.contextPath}/demo_dashboard"
								class="text-muted text-hover-primary">Home</a></li>
							<li class="breadcrumb-item"><span
								class="bullet bg-gray-500 w-5px h-2px"></span></li>
							<li class="breadcrumb-item text-muted">Master</li>
						</ul>
					</div>
				</div>
			</div>

			<div id="kt_app_content" class="app-content flex-column-fluid">
				<div id="kt_app_content_container"
					class="app-container container-xxl">
					<!--begin::Card-->
					<div class="card">
						<div class="card-header border-0 pt-6 mb-6 align-items-start">
							<div class="card-title">
								<h1 class="page-heading d-flex text-gray-900 fw-bold fs-3 my-0">Department
									List</h1>
							</div>

							<div class="card-toolbar d-flex flex-column align-items-end">
								<div class="d-flex mb-3">
									<button type="button" class="btn btn-primary"
										onclick="addDept()">New</button>
									<a href="javascript:;" title=""> </a>
								</div>
							</div>
						</div>
						<div class="card-body pt-0">
							<div class="table-responsive">
								<table
								class="table table-striped table-hover align-middle table-row-bordered fs-6 gy-5"
								id="kt_table"
								style="min-width: 1200px;">
									<thead>
										<tr 
											class="text-start text-gray-500 fw-bold fs-7 text-uppercase gs-0 border-bottom border-gray-200">
											<th style="width: 120px; padding-left: 40px;"
												class="text-start">#</th>
											<th style="width: 350px; text-align: left;">Department ID</th>
											<th style="width: 350px; text-align: left;">Department Name</th>
											<th style="width: 350px; text-align: left;">Description</th>
											<th style="width: 350px; text-align: left;">Prefix ID</th>
											<th style="width: 120px;" class="text-end pe-5">Actions</th>
										</tr>
									</thead>
									<tbody class="fw-semibold text-gray-600">
										<c:forEach var="d" items="${departmentList}" varStatus="st">
											<tr class="align-middle border-bottom border-gray-200">
												<td style="padding-left: 40px;"
													class="fw-bold text-gray-800 text-start text-nowrap">
												</td>
												<td class="text-gray-900">${d.id}</td>
												<td class="text-gray-600">${d.name}</td>

												<td class="text-gray-600"
													style="white-space: normal; max-width: 420px; word-wrap: break-word;">
													${d.description}</td>

												<td class="text-gray-600">${d.prefix_id}</td>

												<td class="text-end text-nowrap pe-5" style="width: 140px;">
													<div
														class="d-inline-flex align-items-center justify-content-end gap-2">
														<!-- Edit -->
														<button type="button" class="btn btn-icon btn-sm btn-light-primary"
															aria-label="Edit"
															onclick="window.location.href='${pageContext.request.contextPath}/editDepartment?id=${d.id}'">
															<i class="ki-duotone ki-pencil fs-5"> 
															<span class="path1"></span><span class="path2"></span>
															</i>
														</button>

														<!-- Delete -->
														<button type="button"
															class="btn btn-icon btn-sm btn-delete-dept btn-light-danger"
															data-id="${d.id}" aria-label="Delete">
															<i class="ki-duotone ki-trash fs-5"> <span
																class="path1"></span><span class="path2"></span><span
																class="path3"></span> <span class="path4"></span><span
																class="path5"></span>
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
					<!--end::Card-->
				</div>
			</div>
		</div>
	</div>
	<!--end::Main-->

	<script>
  function addDept() {
    window.location.href = "${pageContext.request.contextPath}/department_add";
  }
</script>
	<!-- Delete confirm -->
	<script>
  document.querySelectorAll('.btn-delete-dept').forEach(function(btn){
    btn.addEventListener('click', function(){
      var deptId = this.getAttribute('data-id');
      Swal.fire({
        title: 'Are you sure?',
        text: "You will be deleting this id!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, delete it!'
      }).then((result) => {
        if(result.isConfirmed){
          window.location.href = '${pageContext.request.contextPath}/deleteDepartment?id=' + encodeURIComponent(deptId);
        }
      });
    });
  });
</script>

<script>
$(function () {
  $('#dt-no-pseudo, #dt-inline-fix, #dt-inline-style').remove();
  const css = `
    #kt_table.dataTable thead th {
      white-space: nowrap;
      position: relative;
      padding-right: 16px;
    }
    #kt_table.dataTable thead th::before,
    #kt_table.dataTable thead th::after {
      top: 50% !important;
      transform: translateY(-50%) !important;
    }
  `;
  $('<style id="dt-inline-style">').text(css).appendTo('head');

  const originalThHtml = $('#kt_table thead th').map(function () {
    return $(this).html();
  }).get();

  const dt = $('#kt_table').DataTable({
    scrollX: true,
    scrollCollapse: true,
    autoWidth: false,
    responsive: false,

    searching: false,
    pageLength: 25,
    lengthMenu: [25, 50, 100],
    columnDefs: [
      { orderable: false, targets: [0, 5] },
      { orderable: true,  targets: [1, 2, 3, 4] }
    ],
    order: [],
    headerCallback: function (thead) {
      $(thead).find('th').each(function (i) {

        if ($(this).find('.th-inline').length) return;

        const html = originalThHtml[i] || $(this).html();
        $(this).empty().append(
          $('<span class="th-inline" style="display:inline-flex;align-items:center;gap:6px;white-space:nowrap;"/>')
            .append($('<span class="th-text"/>').html(html))
        );
      });
    },
    dom:
      "t" +
      "<'row mt-5'" +
        "<'col-sm-12 col-md-5 d-flex align-items-center justify-content-center justify-content-md-start'l>" +
        "<'col-sm-12 col-md-7 d-flex align-items-center justify-content-center justify-content-md-end'p>" +
      ">"
  });


  function renumber() {
    const info = dt.page.info();
    dt.column(0, { search:'applied', order:'applied', page:'current' })
      .nodes().each(function (cell, i) { cell.textContent = info.start + i + 1; });
  }

  dt.on('draw.dt order.dt search.dt', renumber);
  renumber();

  dt.columns.adjust();
  $(window).on('resize', () => dt.columns.adjust());
});
</script>

</body>
</html>
