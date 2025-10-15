<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%
    String yearParam = request.getParameter("year");
%>

<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <link href="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.css" rel="stylesheet" type="text/css" />
    <script src="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.js"></script>

    <link href="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.css" rel="stylesheet" type="text/css" />
    <script src="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.js"></script>

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
            transition: background-color 0.15s ease-in-out;
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
            transition: background-color 0.15s ease-in-out;
        }
    </style>
</head>

<body>
    <!--begin::Main-->
    <div class="app-main flex-column flex-row-fluid" id="kt_app_main">
        <!--begin::Content wrapper-->
        <div class="d-flex flex-column flex-column-fluid">

            <div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
                <div id="kt_app_toolbar_container" class="app-container container-xxl d-flex flex-stack">
                    <!--begin::Page title-->
                    <div class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
                        <h1 class="page-heading d-flex text-gray-900 fw-bold fs-3 flex-column justify-content-center my-0">
                            Holiday
                        </h1>
                        <ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
                            <li class="breadcrumb-item text-muted">
                                <a href="${pageContext.request.contextPath}/demo_dashboard" class="text-muted text-hover-primary">Home</a>
                            </li>
                            <li class="breadcrumb-item"><span class="bullet bg-gray-500 w-5px h-2px"></span></li>
                            <li class="breadcrumb-item text-muted">Holiday</li>
                        </ul>
                    </div>
                    <!--end::Page title-->
                </div>
            </div>

            <!--begin::Content-->
            <div id="kt_app_content" class="app-content flex-column-fluid">
                <div id="kt_app_content_container" class="app-container container-xxl">

                    <!--begin::Card-->
                    <div class="card">
                        <div class="card-header border-0 pt-6 mb-6 align-items-start">
                            <div class="card-title">
                                <h1 class="page-heading d-flex text-gray-900 fw-bold fs-3 my-0">Holiday List</h1>
                            </div>

                            <div class="card-toolbar d-flex flex-column align-items-end">
                                <!-- Buttons row -->
                                <div class="d-flex mb-3">
                                    <a class="btn btn-light-primary me-3 fw-semibold"
                                       href="<c:url value='/upload/template/holiday_template.xlsx'/>">
                                        Template
                                    </a>

                                    <form id="upload_form"
                                          action="${pageContext.request.contextPath}/upload_holiday"
                                          method="post"
                                          enctype="multipart/form-data"
                                          class="d-inline">
                                        <label class="btn btn-light-info me-3 fw-semibold mb-0" for="importFile">
                                            Import
                                            <input id="importFile"
                                                   type="file"
                                                   name="fileUpload"
                                                   accept="application/vnd.ms-excel, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
                                                   style="display: none;">
                                        </label>
                                    </form>

                                    <button type="button" class="btn btn-primary" onclick="add()">New</button>
                                </div>
                            </div>
                        </div>

                        <div class="card-body pt-0">
                            <!-- Year filter -->
                            <div class="d-flex justify-content-end mb-7">
                                <form class="w-150px position-relative" onsubmit="return false;">
                                    <i class="ki-duotone ki-calendar-8 position-absolute top-50 translate-middle-y ms-3 text-gray-500 pe-none">
                                        <span class="path1"></span><span class="path2"></span>
                                        <span class="path3"></span><span class="path4"></span>
                                        <span class="path5"></span><span class="path6"></span>
                                    </i>
                                    <select id="filterYear" class="form-select ps-10" aria-label="Select year">
                                        <option value="all" <c:if test="${isAll}">selected</c:if>>All</option>
                                        <c:forEach var="holiday_year" items="${holidayList_year}">
                                            <option value="${holiday_year}"
                                                <c:if test="${!isAll && ((not empty selectedYear && selectedYear == holiday_year))}">selected</c:if>>
                                                ${holiday_year}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </form>
                            </div>

                            <!--begin::Table-->
                            <div class="table-responsive">
                                <table class="table table-striped table-hover align-middle table-row-bordered fs-6 gy-5"
                                       id="kt_table" style="min-width: 1200px;">
                                    <thead>
                                        <tr class="text-start text-gray-500 fw-bold fs-7 text-uppercase gs-0 border-bottom border-gray-200">
                                            <th style="width: 120px; padding-left: 40px;" class="text-start">#</th>
                                            <th style="width: 350px;">Start Date</th>
                                            <th style="width: 350px;">End Date</th>
                                            <th style="width: 350px;">Name</th>
                                            <th style="width: 250px;">Description</th>
                                            <th style="width: 120px;" class="text-end pe-5">Actions</th>
                                        </tr>
                                    </thead>

                                    <tbody class="fw-semibold text-gray-600">
                                        <c:forEach var="holiday" items="${holidayList}" varStatus="st">
                                            <tr class="align-middle border-bottom border-gray-200">
                                                <td class="fw-bold text-gray-800 text-start text-nowrap ps-5">${st.count}</td>

                                                <c:choose>
                                                    <c:when test="${not empty holiday.end_date and holiday.end_date ne holiday.start_date}">
                                                        <td class="text-gray-900">
                                                            <fmt:formatDate value="${holiday.start_date}" pattern="d MMM yyyy" />
                                                        </td>
                                                        <td class="text-gray-900">
                                                            <fmt:formatDate value="${holiday.end_date}" pattern="d MMM yyyy" />
                                                        </td>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <td class="text-gray-900">
                                                            <fmt:formatDate value="${holiday.start_date}" pattern="d MMM yyyy" />
                                                        </td>
                                                        <td class="text-gray-900"></td>
                                                    </c:otherwise>
                                                </c:choose>

                                                <td class="text-gray-900">${holiday.head}</td>
                                                <td class="text-gray-900" style="white-space: normal; max-width: 280px; word-wrap: break-word;">
                                                    ${holiday.description}
                                                </td>

                                                <td class="text-end text-nowrap pe-5" style="width: 120px;">
                                                    <div class="d-inline-flex align-items-center justify-content-end gap-2">
                                                        <!-- Edit -->
                                                        <button type="button" class="btn btn-icon btn-sm btn-light-primary"
                                                                aria-label="Edit"
                                                                onclick="window.location.href='${pageContext.request.contextPath}/holiday_edit?id=${holiday.id_date}&flag=1'">
                                                            <i class="ki-duotone ki-pencil fs-5">
                                                                <span class="path1"></span><span class="path2"></span>
                                                            </i>
                                                        </button>

                                                        <!-- Delete -->
                                                        <button type="button" class="btn btn-icon btn-sm btn-delete-holiday btn-light-danger"
                                                                data-id="${holiday.id_date}" aria-label="Delete">
                                                            <i class="ki-duotone ki-trash fs-5">
                                                                <span class="path1"></span><span class="path2"></span>
                                                                <span class="path3"></span><span class="path4"></span>
                                                                <span class="path5"></span>
                                                            </i>
                                                        </button>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
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

    <!--begin::Scripts-->
    <script>
        function add() {
            var today = moment().format('DD-MM-YYYY');
            window.location.href = "${pageContext.request.contextPath}/holiday_add?flag=1&date_cal=" + encodeURIComponent(today) + "&flag=1";
        }
    </script>

    <script>
        document.querySelectorAll('.btn-delete-holiday').forEach(function (button) {
            button.addEventListener('click', function () {
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
                        window.location.href = '${pageContext.request.contextPath}/DeleteHoliday?id=' + encodeURIComponent(holidayId);
                    }
                });
            });
        });
    </script>

    <script>
        (function () {
            var sel = document.getElementById('filterYear');
            var base = '${pageContext.request.contextPath}/holiday_list';
            sel.addEventListener('change', function () {
                var y = this.value;
                if (!y || y === 'all') {
                    window.location.href = base + '?year=all';
                } else {
                    window.location.href = base + '?year=' + encodeURIComponent(y);
                }
            });
        })();
    </script>

    <script>
        $(document).ready(function () {
            $('#kt_table').DataTable({
                scrollX: true,
                searching: false,
                paging: false,
                info: false,
                ordering: false,
                responsive: false,
                autoWidth: false
            });
        });
    </script>

    <script>
        document.getElementById('importFile').addEventListener('change', function () {
            if (this.files && this.files.length) {
                document.getElementById('upload_form').submit();
            }
        });
    </script>
    <!--end::Scripts-->
</body>
</html>
