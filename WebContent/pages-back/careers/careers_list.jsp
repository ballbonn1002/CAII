<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/tlds/permission.tld" prefix="perm"%>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link href="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.css" rel="stylesheet" type="text/css" />
        <script src="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.js"></script>

        <link href="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.css" rel="stylesheet" type="text/css" />
        <script src="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.js"></script>

        <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <style>
            /* ==========================================
               Light Mode
               ========================================== */
            [data-bs-theme="light"] #jobCareersListTable.table.table-striped > tbody > tr:nth-of-type(odd) > * {
                background-color: #FBFBFB !important;
                box-shadow: none !important;
            }
            [data-bs-theme="light"] #jobCareersListTable.table-hover tbody tr:hover > *,
            [data-bs-theme="light"] #jobCareersListTable.table-hover tbody tr:hover > td,
            [data-bs-theme="light"] #jobCareersListTable.table-hover tbody tr:hover > th,
            [data-bs-theme="light"] #jobCareersListTable.table.table-hover > tbody > tr:hover > *,
            [data-bs-theme="light"] #jobCareersListTable.dataTable > tbody > tr:hover > * {
                background-color: #F9F9F9 !important;
                box-shadow: none !important;
                transition: background-color .15s ease-in-out;
            }
            
            /* ==========================================
               Dark Mode
               ========================================== */
            [data-bs-theme="dark"] #jobCareersListTable.table.table-striped > tbody > tr:nth-of-type(odd) > * {
                background-color: #191B20 !important;
                box-shadow: none !important;
            }
            [data-bs-theme="dark"] #jobCareersListTable.table.table-striped > tbody > tr:nth-of-type(even) > * {
                background-color: #15171C !important;
                box-shadow: none !important;
            }
            [data-bs-theme="dark"] #jobCareersListTable.table-hover tbody tr:hover > *,
            [data-bs-theme="dark"] #jobCareersListTable.table-hover tbody tr:hover > td,
            [data-bs-theme="dark"] #jobCareersListTable.table-hover tbody tr:hover > th,
            [data-bs-theme="dark"] #jobCareersListTable.table.table-hover > tbody > tr:hover > *,
            [data-bs-theme="dark"] #jobCareersListTable.dataTable > tbody > tr:hover > * {
                background-color: #1B1C22 !important;
                box-shadow: none !important;
                transition: background-color .15s ease-in-out;
            }
            
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

            /* ==========================================
               Dark Mode SweetAlert2 
               ========================================== */
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
            
            /* ==========================================
               Dark Mode Pagination
               ========================================== */
            [data-bs-theme="dark"] .dataTables_wrapper .dataTables_paginate .paginate_button {
                color: #A1A5B7 !important;
            }
            [data-bs-theme="dark"] .dataTables_wrapper .dataTables_paginate .paginate_button.current, 
            [data-bs-theme="dark"] .dataTables_wrapper .dataTables_paginate .paginate_button.current:hover {
                background-color: #323248 !important;
                border-color: #323248 !important;
                color: #FFFFFF !important;
            }
            [data-bs-theme="dark"] .dataTables_wrapper .dataTables_paginate .paginate_button:hover {
                background-color: #2B2B40 !important;
                color: #FFFFFF !important;
            }
        </style>
    </head>
    <body>
    <perm:permission object="careers.view">
        <div class="app-main flex-column flex-row-fluid" id="kt_app_main">
            <div class="d-flex flex-column flex-column-fluid">

                <div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
                    <div id="kt_app_toolbar_container" class="app-container container-xxl d-flex flex-stack">
                        <div class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
                            <h1 class="page-heading d-flex text-gray-700 fw-semibold flex-column justify-content-center my-0">Careers</h1>
                            <ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
                                <li class="breadcrumb-item text-muted"><a href="${pageContext.request.contextPath}/demo_dashboard" class="text-muted text-hover-primary">Home</a></li>
                                <li class="breadcrumb-item"><span class="bullet bg-gray-500 w-5px h-2px"></span></li>
                                <li class="breadcrumb-item text-muted"><a class="text-muted text-hover-primary">CMS</a></li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div id="kt_app_content" class="app-content flex-column-fluid">
                    <div id="kt_app_content_container" class="app-container container-xxl">
                        <div class="card">
                            <div class="card-header border-0 pt-6 mb-6 d-flex flex-stack">
                                <div class="card-title my-0">
                                    <h1 class="page-heading d-flex text-gray-900 fw-bold fs-3 my-0">Careers</h1>
                                </div>
                                    <div class="card-toolbar my-0">
                                        <a href="${pageContext.request.contextPath}/career_create" class="btn btn-md btn-success ">
                                            <i class="ki-duotone ki-plus fs-2"></i> Create
                                        </a>
                                    </div>
                            </div>
                            <div class="card-body pt-0">
                                <div class="table-responsive">
                                    <table class="table table-striped table-hover align-middle table-row-bordered fs-6 gy-5" id="jobCareersListTable">
                                        <thead>                
                                            <tr class="text-start text-gray-500 fw-bold fs-7 text-uppercase gs-0 border-bottom border-gray-200">
                                                <th style="width: 15%; padding-left: 5%;" class="text-start">ID</th>
                                                <th style="width: 35%; text-align: center;">Position Name</th>
                                                <th style="width: 35%; text-align: center;">Start Date - End Date</th>
                                                <th style="width: 15%; text-align: center; padding-left:2.5%">Actions</th> 
                                            </tr>
                                        </thead>
                                        <tbody class="fw-semibold text-gray-600">
                                            <c:forEach var="job" items="${jobList}" varStatus="st">
                                                <tr class="align-middle border-bottom border-gray-200">
                                                    <td style="padding-left: 5%;" class="fw-bold text-gray-800 text-start text-nowrap" data-order="${job.name}"></td>
                                                    <td class="text-gray-900 text-center">${job.position}</td>
                                                    <td class="text-gray-600 text-center">
                                                        <fmt:formatDate value="${job.startDate}" pattern="dd MMM yyyy" /> -
                                                        <fmt:formatDate value="${job.endDate}" pattern="dd MMM yyyy" />
                                                    </td>
                                                    <perm:permission object="careers.view">
                                                        <td class="text-center text-nowrap">
                                                            <a href="${pageContext.request.contextPath}/career_edit?id=${job.jobId}" class="btn btn-icon btn-light-primary btn-sm me-2" title="Edit">
                                                                <i class="ki-duotone ki-pencil fs-4"><span class="path1"></span><span class="path2"></span></i>
                                                            </a>
                                                            <a href="javascript:void(0);" onclick="deleteJob('${job.jobId}')" class="btn btn-icon btn-light-danger btn-sm" title="Delete">
                                                                <i class="ki-duotone ki-trash fs-4"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i>
                                                            </a>
                                                        </td>
                                                    </perm:permission>
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
            $(function () {
                if ($('#jobCareersListTable').data('initialized')) {
                    return;
                }
                $('#jobCareersListTable').data('initialized', true);
                
                $.fn.dataTable.ext.errMode = 'none';
                
                $('#dt-no-pseudo, #dt-inline-fix, #dt-inline-style').remove();
                const css = `
                #jobCareersListTable.dataTable thead th {
                    white-space: nowrap;
                    position: relative;
                    padding-right: 16px;
                }
                #jobCareersListTable.dataTable thead th::before,
                #jobCareersListTable.dataTable thead th::after {
                    top: 50% !important;
                    transform: translateY(-50%) !important;
                }
                `;
                $('<style id="dt-inline-style">').text(css).appendTo('head');
                
                const originalThHtml = $('#jobCareersListTable thead th').map(function () {
                    return $(this).html();
                }).get();
                
                const dt = $('#jobCareersListTable').DataTable({
                    scrollCollapse: true,
                    autoWidth: true,
                    responsive: false,
                    searching: false,
                    pageLength: 50,
                    lengthMenu: [5, 10, 25, 50],
                    columnDefs: [
                        { orderable: true, targets: [0, 1, 2] }, 
                        { orderable: false, targets: [3] }
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
                
                $('.dataTables_length select').addClass('form-select form-select-sm form-select-solid');
                
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

            function deleteJob(jobId) { 
			    Swal.fire({
			        title: 'Confirm Deletion',
			        text: "Are you sure you want to delete this?",
			        icon: 'warning',
			        showCancelButton: true,
	                customClass: { confirmButton: "btn btn-danger", cancelButton: "btn btn-secondary" },
			        reverseButtons: true,
			        confirmButtonText: 'Yes, delete it!',
			        cancelButtonText: 'Cancel'
			    }).then((result) => {
			        if (result.isConfirmed) {
			            window.location.href = "career_delete?id=" + jobId; 
			        }
			    });
			}

        </script>
    </perm:permission>
    </body>
</html>