<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
    <div class="d-flex flex-column flex-column-fluid">
        <div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
            <div id="kt_app_toolbar_container" class="app-container container-fluid d-flex flex-stack">
                <div class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
                    <h1 class="page-heading d-flex text-gray-700 fw-semibold my-0">Consumables Stock</h1>
                    <ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
                        <li class="breadcrumb-item text-muted"><a href="${pageContext.request.contextPath}/demo_dashboard" class="text-muted text-hover-primary fw-medium fs-7">Home</a></li>
                        <li class="breadcrumb-item"><span class="bullet bg-gray-500 fw-medium fs-7 w-5px h-2px"></span></li>
                        <li class="breadcrumb-item text-muted fw-medium fs-7">Stock</li>
                    </ul>
                </div>
            </div>
        </div>

        <div id="kt_app_content" class="app-content flex-column-fluid">
            <div id="kt_app_content_container" class="app-container container-fluid">

                <div class="d-flex align-items-center justify-content-between mt-2 mb-6">
                    <div class="d-flex align-items-baseline gap-1">
                        <h3 class="page-heading text-gray-900 fw-bold mb-0">
                            <span id="currentTotalRows">${fn:length(products)}</span> Items Found
                        </h3>
                    </div>
                    <a href="stock_cons_add" class="btn btn-success d-inline-flex align-items-center px-6 py-3">
                        <i class="ki-duotone ki-plus fs-3 me-2"><span class="path1"></span><span class="path2"></span></i>
                        <span class="fw-bold">Create</span>
                    </a>
                </div>

                <div class="card">
                    <div class="card-border-radius">
                        <div class="card-body">
                            <div class="d-flex align-items-center position-relative mb-6" style="max-width: 400px;">
                                <i class="ki-duotone ki-magnifier fs-3 position-absolute ms-5"><span class="path1"></span><span class="path2"></span></i>
                                <input type="text" id="searchInput" class="form-control form-solid ps-14 text-gray-700" placeholder="Search" />
                            </div>

                            <div class="table-responsive">
                                <table id="stockConsTable" class="table align-middle fs-6 mb-0">
                                    <thead class="fs-7 text-gray-500 text-uppercase">
                                        <tr class="fw-semibold">
                                            <th class="min-w-60px text-nowrap">No</th>
                                            <th class="min-w-250px text-nowrap">Product</th>
                                            <th class="min-w-300px text-nowrap">Sub Products</th>
                                            <th class="min-w-120px text-nowrap">Unit</th>
                                            <th class="min-w-120px text-end">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="product" items="${products}" varStatus="st">
                                            <tr>
                                                <td class="text-gray-900 fw-bold">${st.index + 1}</td>
                                                <td class="text-gray-900 fw-normal">${fn:escapeXml(product.product_name)}</td>
                                                <td class="text-gray-700 fw-normal">
                                                    <c:choose>
                                                        <c:when test="${not empty product.sub_products}">
                                                            <c:forEach var="sub" items="${fn:split(product.sub_products, ',')}">
                                                                <span class="badge badge-light-primary fs-7 py-2 me-2 mb-1">${fn:escapeXml(sub)}</span>
                                                            </c:forEach>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-muted">-</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="text-gray-700 fw-normal">
                                                    <c:choose>
                                                        <c:when test="${not empty product.unit_name}">${fn:escapeXml(product.unit_name)}</c:when>
                                                        <c:otherwise><span class="text-muted">-</span></c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="text-end">
                                                    <a href="stock_cons_balance?id=${product.product_id}" class="btn btn-icon btn-sm btn-light-info mb-1 fs-3" title="Balance">
                                                        <i class="ki-duotone ki-document fs-1"><span class="path1"></span><span class="path2"></span></i>
                                                    </a>
                                                    <a href="stock_cons_edit?id=${product.product_id}" class="btn btn-icon btn-sm btn-light-primary mb-1 fs-3" title="Edit">
                                                        <i class="ki-duotone ki-pencil fs-1"><span class="path1"></span><span class="path2"></span></i>
                                                    </a>
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
</div>

<script>
    $(document).ready(function () {
        var table = $('#stockConsTable').DataTable({
            pageLength: 20,
            lengthMenu: [20, 50, 100],
            info: false,
            ordering: true,
            autoWidth: false,
            columnDefs: [{ targets: 4, orderable: false }]
        });

        table.on('draw', function () {
            $('#currentTotalRows').text(table.page.info().recordsDisplay);
        });

        $('#searchInput').on('keyup', function () { table.search(this.value).draw(); });
    });
</script>