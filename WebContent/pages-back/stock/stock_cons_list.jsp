<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
    <div class="d-flex flex-column flex-column-fluid">
        <div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
            <div id="kt_app_toolbar_container" class="app-container container-fluid d-flex flex-stack">
                <div class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
                    <h1 class="page-heading d-flex text-gray-700 fw-semibold my-0">Stock - Consumables</h1>
                    <ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
                        <li class="breadcrumb-item text-muted"><a href="${pageContext.request.contextPath}/check_in_out" class="text-muted text-hover-primary fw-medium fs-7">Home</a></li>
                        <li class="breadcrumb-item"><span class="bullet bg-gray-500 fw-medium fs-7 w-5px h-2px"></span></li>
                        <li class="breadcrumb-item text-muted fw-medium fs-7"><a href="${pageContext.request.contextPath}/stock/stock_cons_list" class="text-muted text-hover-primary">Product</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <div id="kt_app_content" class="app-content flex-column-fluid">
            <div id="kt_app_content_container" class="app-container container-fluid">

                <div class="card">
                    <div class="card-border-radius">
                        <div class="card-body">

                            <div class="d-flex align-items-center justify-content-between flex-wrap gap-3 mb-6">
                                <h3 class="page-heading text-gray-900 fw-bold mb-0">Consumables List</h3>
                                <a href="stock_cons_add" class="btn btn-success d-inline-flex align-items-center px-6 py-3">
                                    <i class="ki-duotone ki-plus fs-3 me-2"><span class="path1"></span><span class="path2"></span></i>
                                    <span class="fw-bold">Create</span>
                                </a>
                            </div>

                            <div class="d-flex align-items-center position-relative mb-6">
                                <i class="ki-duotone ki-magnifier fs-3 position-absolute ms-5"><span class="path1"></span><span class="path2"></span></i>
                                <input type="text" id="searchInput" class="form-control form-control-solid ps-14 text-gray-700" placeholder="Search" />
                            </div>

                            <div class="d-flex align-items-center gap-2 mb-4">
                                <i class="ki-duotone ki-element-11 fs-2 text-warning">
                                    <span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span>
                                </i>
                                <span class="text-gray-500 fw-semibold fs-6">Consumables</span>
                                <span class="text-gray-900 fw-bold fs-5"><span id="currentTotalRows">${fn:length(products)}</span> items</span>
                            </div>

                            <table id="stockConsTable" class="table align-middle fs-6 mb-0">
                                <thead class="fs-7 text-gray-500 text-uppercase">
                                    <tr class="fw-semibold">
                                        <th class="min-w-50px text-nowrap">#</th>
                                        <th class="min-w-250px text-nowrap">Product Name</th>
                                        <th class="min-w-300px text-nowrap">Sub Product</th>
                                        <th class="min-w-100px text-nowrap text-end">Quantity</th>
                                        <th class="min-w-100px text-nowrap">Unit</th>
                                        <th class="min-w-120px text-nowrap text-end">Action</th>
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
                                                            <span class="badge badge-primary fs-7 fw-semibold py-2 px-3 me-2 mb-1">${fn:escapeXml(sub)}</span>
                                                        </c:forEach>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">-</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="text-gray-900 fw-normal text-end">
                                                <c:choose>
                                                    <c:when test="${not empty product.quantity}">${fn:escapeXml(product.quantity)}</c:when>
                                                    <c:otherwise><span class="text-muted">-</span></c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="text-gray-700 fw-normal">
                                                <c:choose>
                                                    <c:when test="${not empty product.unit_name}">${fn:escapeXml(product.unit_name)}</c:when>
                                                    <c:otherwise><span class="text-muted">-</span></c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="text-end text-nowrap">
                                                <a href="stock_cons_edit?productId=${product.product_id}" class="btn btn-icon btn-sm btn-light-primary me-1" title="Edit">
                                                    <i class="ki-duotone ki-pencil fs-3"><span class="path1"></span><span class="path2"></span></i>
                                                </a>
                                                <button type="button"
                                                        class="btn btn-icon btn-sm btn-light-danger btn-delete-product"
                                                        data-id="${product.product_id}"
                                                        data-name="${fn:escapeXml(product.product_name)}"
                                                        title="Delete">
                                                    <i class="ki-duotone ki-trash fs-3">
                                                        <span class="path1"></span><span class="path2"></span>
                                                        <span class="path3"></span><span class="path4"></span><span class="path5"></span>
                                                    </i>
                                                </button>
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

<script>
    $(document).ready(function () {
        var table = $('#stockConsTable').DataTable({
            dom: "<'table-responsive'tr>" +
                 "<'row align-items-center mt-6'<'col-sm-auto mb-2 mb-sm-0'l><'col-sm d-flex justify-content-sm-end'p>>",
            pageLength: 100,
            lengthMenu: [10, 20, 50, 100],
            info: false,
            ordering: true,
            autoWidth: false,
            language: { lengthMenu: '_MENU_' },
            columnDefs: [
                { targets: 0, orderable: false },
                { targets: 5, orderable: false }
            ]
        });

        table.on('draw', function () {
            $('#currentTotalRows').text(table.page.info().recordsDisplay);
        });

        $('#searchInput').on('keyup', function () {
            table.search(this.value).draw();
        });

        // TODO: stock_cons_delete - ยังไม่เปิดใช้ (action ยังไม่มีใน actionback.xml)
        // ใช้ POST ไม่ใช่ GET เพราะ prefetch/crawler ยิง URL แล้วลบข้อมูลได้
        /*
        $('#stockConsTable').on('click', '.btn-delete-product', function () {
            var id = $(this).data('id');
            var name = $(this).data('name') || '';
            if (!id) { return; }
            if (!confirm('ต้องการลบรายการ "' + name + '" ใช่หรือไม่?')) { return; }

            $('<form>', { method: 'POST', action: 'stock_cons_delete' })
                .append($('<input>', { type: 'hidden', name: 'productId', value: id }))
                .appendTo('body')
                .submit();
        });
        */
    });
</script>
