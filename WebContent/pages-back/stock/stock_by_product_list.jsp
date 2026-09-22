<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%--
  Stock By Product - สรุปยอดคงเหลือรวม (ตัวแม่ + sub product) ต่อ 1 catalog item
  ข้อมูลมาจาก ProductAction.showStockByProductPage() ทั้งหมด:
    - products      : ${products} จาก ProductDAO.findAllWithSubProducts() + on_hand/warehouse_count ที่คำนวณเพิ่ม
    - typeCounts     : จำนวน item ต่อ type (เหมือนหน้า Product List)
    - totalOnHand    : ผลรวม on_hand ของทุก item
    - totalWarehouses: จำนวนคลังทั้งหมดในระบบ (ตาราง warehouse)

  On Hand: type 1 (Equipment) = จำนวนเครื่องจริง / type 2,3,4 = stock.reconcile ล่าสุดรวมทุก sub product
  Warehouses: จำนวนคลัง (2,3,4) หรือ location (1) ที่ "มียอดคงเหลือจริง" ไม่ใช่จำนวนคลังทั้งหมด
--%>

<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
    <div class="d-flex flex-column flex-column-fluid">
        <div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
            <div id="kt_app_toolbar_container" class="app-container container-fluid d-flex flex-stack">
                <div class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
                    <h1 class="page-heading d-flex text-gray-700 fw-semibold my-0">Stock By Product</h1>
                    <ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
                        <li class="breadcrumb-item text-muted"><a href="${pageContext.request.contextPath}/check_in_out" class="text-muted text-hover-primary fw-medium fs-7">Home</a></li>
                        <li class="breadcrumb-item"><span class="bullet bg-gray-500 fw-medium fs-7 w-5px h-2px"></span></li>
                        <li class="breadcrumb-item text-muted fw-medium fs-7"><a href="${pageContext.request.contextPath}/product_list" class="text-muted text-hover-primary">Product</a></li>
                        <li class="breadcrumb-item"><span class="bullet bg-gray-500 fw-medium fs-7 w-5px h-2px"></span></li>
                        <li class="breadcrumb-item text-muted fw-medium fs-7">Stock By Product</li>
                    </ul>
                </div>
            </div>
        </div>

        <div id="kt_app_content" class="app-content flex-column-fluid">
            <div id="kt_app_content_container" class="app-container container-fluid">

                <%-- ---- การ์ดสรุปด้านบน ---- --%>
                <div class="row g-4 mb-6">
                    <div class="col-12 col-md-4">
                        <div class="card card-bordered h-100">
                            <div class="card-body d-flex align-items-center gap-3 py-4 px-5">
                                <i class="ki-duotone ki-abstract-26 fs-2x text-primary"><span class="path1"></span><span class="path2"></span></i>
                                <span class="text-gray-600 fw-semibold fs-6">Total Products</span>
                                <span class="text-gray-900 fw-bold fs-4 ms-auto">${fn:length(products)} <span class="fs-7 fw-semibold text-gray-500">items</span></span>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-md-4">
                        <div class="card card-bordered h-100">
                            <div class="card-body d-flex align-items-center gap-3 py-4 px-5">
                                <i class="ki-duotone ki-package fs-2x text-success"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i>
                                <span class="text-gray-600 fw-semibold fs-6">Total On Hand</span>
                                <span class="text-gray-900 fw-bold fs-4 ms-auto">${empty totalOnHand ? 0 : totalOnHand} <span class="fs-7 fw-semibold text-gray-500">units</span></span>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-md-4">
                        <div class="card card-bordered h-100">
                            <div class="card-body d-flex align-items-center gap-3 py-4 px-5">
                                <i class="ki-duotone ki-home-2 fs-2x text-warning"><span class="path1"></span><span class="path2"></span></i>
                                <span class="text-gray-600 fw-semibold fs-6">Warehouses</span>
                                <span class="text-gray-900 fw-bold fs-4 ms-auto">${empty totalWarehouses ? 0 : totalWarehouses} <span class="fs-7 fw-semibold text-gray-500">locations</span></span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card">
                    <div class="card-border-radius">
                        <div class="card-body">

                            <div class="d-flex align-items-center justify-content-between flex-wrap gap-3 mb-6">
                                <h3 class="page-heading text-gray-900 fw-bold mb-0">Stock Summary</h3>
                            </div>

                            <div class="d-flex align-items-center position-relative mb-6">
                                <i class="ki-duotone ki-magnifier fs-3 position-absolute ms-5"><span class="path1"></span><span class="path2"></span></i>
                                <input type="text" id="searchInput" class="form-control form-control-solid ps-14 text-gray-700" placeholder="Search" />
                            </div>

                            <%-- ---- การ์ด filter ตาม type - จำนวนนับจาก backend (${typeCounts}) ไม่ใช่จาก DOM ---- --%>
                            <div class="row g-4 mb-6">
                                <div class="col-12 col-md-3">
                                    <div class="card card-bordered h-100 cursor-pointer type-filter-card" data-type="1">
                                        <div class="card-body d-flex align-items-center gap-3 py-4 px-5">
                                            <i class="ki-duotone ki-laptop fs-2x text-primary"><span class="path1"></span><span class="path2"></span></i>
                                            <span class="text-gray-600 fw-semibold fs-6">Equipment</span>
                                            <span class="text-gray-900 fw-bold fs-4 ms-auto">${empty typeCounts['1'] ? 0 : typeCounts['1']} <span class="fs-7 fw-semibold text-gray-500">items</span></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12 col-md-3">
                                    <div class="card card-bordered h-100 cursor-pointer type-filter-card" data-type="2">
                                        <div class="card-body d-flex align-items-center gap-3 py-4 px-5">
                                            <i class="ki-duotone ki-element-11 fs-2x text-warning"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i>
                                            <span class="text-gray-600 fw-semibold fs-6">Consumables</span>
                                            <span class="text-gray-900 fw-bold fs-4 ms-auto">${empty typeCounts['2'] ? 0 : typeCounts['2']} <span class="fs-7 fw-semibold text-gray-500">items</span></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12 col-md-3">
                                    <div class="card card-bordered h-100 cursor-pointer type-filter-card" data-type="3">
                                        <div class="card-body d-flex align-items-center gap-3 py-4 px-5">
                                            <i class="ki-duotone ki-medal-star fs-2x text-success"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i>
                                            <span class="text-gray-600 fw-semibold fs-6">Accessories</span>
                                            <span class="text-gray-900 fw-bold fs-4 ms-auto">${empty typeCounts['3'] ? 0 : typeCounts['3']} <span class="fs-7 fw-semibold text-gray-500">items</span></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12 col-md-3">
                                    <div class="card card-bordered h-100 cursor-pointer type-filter-card" data-type="4">
                                        <div class="card-body d-flex align-items-center gap-3 py-4 px-5">
                                            <i class="ki-duotone ki-parcel fs-2x text-info"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i>
                                            <span class="text-gray-600 fw-semibold fs-6">Office Supplies</span>
                                            <span class="text-gray-900 fw-bold fs-4 ms-auto">${empty typeCounts['4'] ? 0 : typeCounts['4']} <span class="fs-7 fw-semibold text-gray-500">items</span></span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <table id="stockByProductTable" class="table align-middle fs-6 mb-0">
                                <thead class="fs-7 text-gray-500 text-uppercase">
                                    <tr class="fw-semibold">
                                        <th class="min-w-50px text-nowrap">#</th>
                                        <th class="min-w-150px text-nowrap">Type</th>
                                        <th class="min-w-250px text-nowrap">Product Name</th>
                                        <th class="min-w-120px text-nowrap">Unit</th>
                                        <th class="min-w-120px text-nowrap text-end">On Hand</th>
                                        <th class="min-w-150px text-nowrap text-center">Warehouses</th>
                                        <th class="min-w-120px text-nowrap text-end">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="product" items="${products}" varStatus="st">
                                        <tr data-type="${fn:escapeXml(product.product_type)}">
                                            <td class="text-gray-900 fw-bold">${st.index + 1}</td>
                                            <td class="text-gray-700 fw-normal">
                                                <div class="d-flex align-items-center gap-2">
                                                    <c:choose>
                                                        <c:when test="${product.product_type eq '1'}">
                                                            <i class="ki-duotone ki-laptop fs-2 text-primary"><span class="path1"></span><span class="path2"></span></i>
                                                            <span>Equipment</span>
                                                        </c:when>
                                                        <c:when test="${product.product_type eq '2'}">
                                                            <i class="ki-duotone ki-element-11 fs-2 text-warning"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i>
                                                            <span>Consumables</span>
                                                        </c:when>
                                                        <c:when test="${product.product_type eq '3'}">
                                                            <i class="ki-duotone ki-medal-star fs-2 text-success"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i>
                                                            <span>Accessories</span>
                                                        </c:when>
                                                        <c:when test="${product.product_type eq '4'}">
                                                            <i class="ki-duotone ki-parcel fs-2 text-info"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i>
                                                            <span>Office Supplies</span>
                                                        </c:when>
                                                        <c:otherwise><span class="text-muted">-</span></c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </td>
                                            <td class="text-gray-900 fw-normal">${fn:escapeXml(product.product_name)}</td>
                                            <td class="text-gray-700">${not empty product.unit_name ? fn:escapeXml(product.unit_name) : '-'}</td>
                                            <td class="text-end fw-bold">${product.on_hand}</td>
                                            <td class="text-center">
                                                <c:choose>
                                                    <c:when test="${product.warehouse_count > 0}">
                                                        <span class="badge badge-light-primary fw-semibold">${product.warehouse_count} คลัง</span>
                                                    </c:when>
                                                    <c:otherwise><span class="text-muted">-</span></c:otherwise>
                                                </c:choose>
                                            </td>
                                            <c:set var="viewUrl" value="${product.product_type eq '1' ? 'stock_equ_balance' : 'stock_balance'}" />
                                            <td class="text-end">
                                                <a href="${viewUrl}?productId=${product.product_id}" class="btn btn-icon btn-sm btn-light-primary" title="View">
                                                    <i class="ki-duotone ki-eye fs-3"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i>
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

<script>
    $(document).ready(function () {
        var selectedType = '';
        $.fn.dataTable.ext.search.push(function (settings, data, dataIndex) {
            if (settings.nTable.id !== 'stockByProductTable') { return true; }
            if (!selectedType) { return true; }
            var tr = settings.aoData[dataIndex].nTr;
            return String($(tr).data('type')) === selectedType;
        });

        var table = $('#stockByProductTable').DataTable({
            dom: "<'table-responsive'tr>" +
                 "<'row align-items-center mt-6'<'col-sm-auto mb-2 mb-sm-0'l><'col-sm d-flex justify-content-sm-end'p>>",
            pageLength: 100,
            lengthMenu: [10, 20, 50, 100],
            info: false,
            ordering: true,
            autoWidth: false,
            language: { lengthMenu: '_MENU_' },
            columnDefs: [
                { targets: [0, 5, 6], orderable: false }
            ]
        });

        $('#searchInput').on('keyup', function () {
            table.search(this.value).draw();
        });

        $('.type-filter-card').on('click', function () {
            var t = String($(this).data('type'));
            if (selectedType === t) {
                selectedType = '';
                $(this).removeClass('active border-primary bg-light-primary');
            } else {
                selectedType = t;
                $('.type-filter-card').removeClass('active border-primary bg-light-primary');
                $(this).addClass('active border-primary bg-light-primary');
            }
            table.draw();
        });
    });
</script>
