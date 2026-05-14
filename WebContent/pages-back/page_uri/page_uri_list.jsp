<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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

<link
	href="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.css"
	rel="stylesheet" type="text/css" />
<script
	src="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.js"></script>

<style>
/*Light Mode*/
[data-bs-theme="light"] #kt_table.table.table-striped>tbody>tr:nth-of-type(odd)>*
	{
	background-color: #FBFBFB !important;
	box-shadow: none !important;
}

[data-bs-theme="light"] #kt_table.table-hover tbody tr:hover>*, [data-bs-theme="light"] #kt_table.table-hover tbody tr:hover>td,
	[data-bs-theme="light"] #kt_table.table-hover tbody tr:hover>th, [data-bs-theme="light"] #kt_table.table.table-hover>tbody>tr:hover>*,
	[data-bs-theme="light"] #kt_table.dataTable>tbody>tr:hover>* {
	background-color: #F9F9F9 !important; /* hover */
	box-shadow: none !important;
	transition: background-color 0.15s ease-in-out;
}

/*Dark Mode*/
[data-bs-theme="dark"] #kt_table.table.table-striped>tbody>tr:nth-of-type(odd)>*
	{
	background-color: #191B20 !important; /* odd */
	box-shadow: none !important;
}

[data-bs-theme="dark"] #kt_table.table.table-striped>tbody>tr:nth-of-type(even)>*
	{
	background-color: #15171C !important; /* even */
	box-shadow: none !important;
}

[data-bs-theme="dark"] #kt_table.table-hover tbody tr:hover>*, [data-bs-theme="dark"] #kt_table.table-hover tbody tr:hover>td,
	[data-bs-theme="dark"] #kt_table.table-hover tbody tr:hover>th, [data-bs-theme="dark"] #kt_table.table.table-hover>tbody>tr:hover>*,
	[data-bs-theme="dark"] #kt_table.dataTable>tbody>tr:hover>* {
	background-color: #1B1C22 !important; /* hover */
	box-shadow: none !important;
	transition: background-color 0.15s ease-in-out;
}
</style>

</head>
<body>
	<!--begin::Main-->
	<div class="d-flex flex-column flex-column-fluid">
		<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
			<div id="kt_app_toolbar_container"
				class="app-container container-fluid d-flex flex-stack">
				<div
					class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
					<h1
						class="page-heading d-flex text-gray-700 fw-semibold flex-column justify-content-center my-0">
						Page URI</h1>
					<ul
						class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
						<li class="breadcrumb-item text-muted"><a
							href="${pageContext.request.contextPath}/demo_dashboard"
							class="text-muted text-hover-primary">Home</a></li>
						<li class="breadcrumb-item"><span class="bullet bg-gray-500 w-5px h-2px"></span></li>
						<li class="breadcrumb-item text-muted">CMS</li>
					</ul>
				</div>
			</div>
		</div>

		<div id="kt_app_content" class="app-content flex-column-fluid">
			<div id="kt_app_content_container"
				class="app-container container-fluid">

				<!--begin::Card-->
				<div class="card">
					<div class="card-header border-0 px-9 pt-7 d-flex align-items-center justify-content-between">
						<div class="card-title">
							<h3 class="fw-semibold text-gray-900">Page URI</h3>
						</div>

						<button type="button" class="btn btn-success d-flex align-items-center" onclick="addPageUri()">
							<i class="ki-outline ki-plus fs-2 me-1"></i> Create
						</button>
					</div>

					<div class="card-body table-responsive pt-0">
						
						<!-- Search -->
						<div class="w-100 position-relative my-5">
							<i class="ki-duotone ki-magnifier fs-3 position-absolute ms-4 top-50 translate-middle-y">
								<span class="path1"></span>
								<span class="path2"></span>
							</i>
							<input type="text" data-kt-table-filter="search" class="form-control form-control-solid w-100 ps-12" placeholder="Search..." />
						</div>

							<table
								class="table table-striped table-hover table-row-bordered fs-6 gy-5"
								id="kt_table">
								<thead>
									<tr class="text-gray-500 fw-bold fs-7 text-uppercase gs-0 border-bottom border-gray-200">
										<th class="text-center" style="width: 80px; padding-left: 10px;">ID</th>
										<th style="width: 200px; text-align: left;">PAGE URI</th>
										<th style="width: 200px; text-align: left;">FORWARD TO</th>
										<th style="width: 150px; text-align: left;">MODEL - ID</th>
										<th style="width: 250px; text-align: left;">TITLE</th>
										<th style="width: 250px; text-align: left;">META</th>
										<th class="text-end" style="width: 100px;">ACTION</th>
									</tr>
								</thead>
								<tbody class="fw-semibold text-gray-600">
									<c:forEach var="uri" items="${pageUriList}" varStatus="st">
										<tr class="align-middle border-bottom border-gray-200">
											<td class="text-center fw-bold text-gray-900">${st.count}</td>
											<td class="text-gray-900">${uri.pageUriId}</td>
											<td class="text-gray-600">${uri.forwardTo}</td>
											<td class="text-gray-600">${uri.model} - ${uri.modelId}</td>
											<td class="text-gray-600">${uri.pageUriTitle}</td>
											<td class="text-gray-600">${uri.meta}</td>

											<!-- Actions -->
											<td class="text-end text-nowrap pe-5">
												<div
													class="d-inline-flex align-items-center justify-content-end gap-2">
													<!-- Edit -->
													<button type="button"
														class="btn btn-icon btn-sm btn-light-primary"
														aria-label="Edit"
														onclick="window.location.href='${pageContext.request.contextPath}/editPageUri.action?pageUriId=${uri.pageUriId}'">
														<i class="ki-duotone ki-pencil fs-5"> <span
															class="path1"></span><span class="path2"></span>
														</i>
													</button>

													<!-- Delete -->
													<button type="button"
														class="btn btn-icon btn-sm btn-delete-page-uri btn-light-danger"
														data-id="${uri.pageUriId}" aria-label="Delete">
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
					<!--end::Card-->
				</div>
			</div>
		</div>
	</div>
	<!--end::Main-->

	<script>
    function addPageUri() {
      window.location.href = "${pageContext.request.contextPath}/page_uri_add";
    }
  </script>

	<!-- SweetAlert2 delete confirm -->
	<script>
    document.querySelectorAll('.btn-delete-page-uri').forEach(function(btn) {
      btn.addEventListener('click', function() {
        var id = this.getAttribute('data-id');
        Swal.fire({
          title: 'Are you sure?!',
          text: "Are you sure you want to delete this page URL?",
          icon: 'warning',
          showCancelButton: true,
          confirmButtonText: 'Yes, delete it!',
          cancelButtonText: 'Cancel',
          buttonsStyling: false,
          customClass: {
              confirmButton: "btn btn-danger",
              cancelButton: "btn btn-secondary"
          }
        }).then((result) => {
          if (result.isConfirmed) {
            window.location.href = '${pageContext.request.contextPath}/page_uri_delete?pageUriId=' + encodeURIComponent(id);
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
    //scrollX: true,
    scrollCollapse: true,
    autoWidth: false,
    responsive: false,

    searching: true,
    pageLength: 25,
    lengthMenu: [25, 50, 100],
    columnDefs: [
      { orderable: false, targets: [6] },
      { orderable: true,  targets: [0, 1, 2, 3, 4, 5] }
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

  // Handle Search Input
  $('[data-kt-table-filter="search"]').on('keyup', function () {
    dt.search(this.value).draw();
  });

  dt.columns.adjust();
  $(window).on('resize', () => dt.columns.adjust());
});
</script>

</body>
</html>
