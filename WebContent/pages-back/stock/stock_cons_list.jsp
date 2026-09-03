<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
    <div class="d-flex flex-column flex-column-fluid">
        <div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
            <div id="kt_app_toolbar_container" class="app-container container-fluid d-flex flex-stack">
                <div class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
                    <h1 class="page-heading d-flex text-gray-700 fw-semibold my-0">Product</h1>
                    <ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
                        <li class="breadcrumb-item text-muted"><a href="${pageContext.request.contextPath}/check_in_out" class="text-muted text-hover-primary fw-medium fs-7">Home</a></li>
                        <li class="breadcrumb-item"><span class="bullet bg-gray-500 fw-medium fs-7 w-5px h-2px"></span></li>
                        <li class="breadcrumb-item text-muted fw-medium fs-7"><a href="${pageContext.request.contextPath}/stock_cons_list" class="text-muted text-hover-primary">Product</a></li>
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
                                <h3 class="page-heading text-gray-900 fw-bold mb-0">Product List</h3>
                                <a href="stock_cons_add" class="btn btn-success d-inline-flex align-items-center px-6 py-3">
                                    <i class="ki-duotone ki-plus fs-3 me-2"><span class="path1"></span><span class="path2"></span></i>
                                    <span class="fw-bold">Create</span>
                                </a>
                            </div>

                            <div class="d-flex align-items-center position-relative mb-6">
                                <i class="ki-duotone ki-magnifier fs-3 position-absolute ms-5"><span class="path1"></span><span class="path2"></span></i>
                                <input type="text" id="searchInput" class="form-control form-control-solid ps-14 text-gray-700" placeholder="Search" />
                            </div>

                            <%-- การ์ดสรุป/filter ตาม type - กดเพื่อกรองตาราง (กดซ้ำ = ยกเลิก)
                                 จำนวนนับมาจาก backend (${typeCounts}) ไม่ใช่จาก DOM
                                 เพราะ DataTables จะเหลือแถวแค่หน้าปัจจุบัน --%>
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

                            <table id="stockConsTable" class="table align-middle fs-6 mb-0">
                                <thead class="fs-7 text-gray-500 text-uppercase">
                                    <tr class="fw-semibold">
                                        <th class="min-w-50px text-nowrap">#</th>
                                        <th class="min-w-150px text-nowrap">Type</th>
                                        <th class="min-w-250px text-nowrap">Product Name</th>
                                        <th class="min-w-300px text-nowrap">Sub Product</th>
                                        <th class="min-w-120px text-nowrap text-center">Catalog MR</th>
                                        <th class="min-w-150px text-nowrap text-center">Select Subproduct</th>
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
                                            <td class="text-gray-700 fw-normal">
                                                <c:choose>
                                                    <c:when test="${not empty product.sub_products}">
                                                        <c:forEach var="sub" items="${fn:split(product.sub_products, ',')}">
                                                            <span class="badge badge-primary fs-7 fw-semibold py-2 px-3 me-2 mb-1">${fn:escapeXml(sub)}</span>
                                                        </c:forEach>
                                                    </c:when>
                                                    <%-- Equipment ที่ยังไม่ได้แตก sub product: โชว์จำนวนเครื่องจริงที่ผูกอยู่แทน
                                                         จะได้ไม่เห็นเป็นขีดว่างทั้งที่มีเครื่องอยู่หลังบ้าน --%>
                                                    <c:when test="${product.product_type eq '1' and product.equipment_qty > 0}">
                                                        <span class="badge badge-light-primary fs-7 fw-semibold py-2 px-3">
                                                            ${product.equipment_qty} เครื่อง
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">-</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <%-- Catalog MR ผูกกับคอลัมน์ active - กดติ๊กเซฟทันที (AJAX) --%>
                                            <td class="text-center">
                                                <div class="form-check form-check-custom form-check-solid d-inline-flex">
                                                    <input class="form-check-input js-active-toggle" type="checkbox"
                                                           data-id="${product.product_id}"
                                                           <c:if test="${product.active eq '1'}">checked</c:if> />
                                                </div>
                                            </td>
                                            <%-- Select Subproduct ผูกกับคอลัมน์ sub_product_active - กดติ๊กเซฟทันที (AJAX) --%>
                                            <td class="text-center">
                                                <div class="form-check form-check-custom form-check-solid d-inline-flex">
                                                    <input class="form-check-input js-subactive-toggle" type="checkbox"
                                                           data-id="${product.product_id}"
                                                           <c:if test="${product.sub_product_active eq '1'}">checked</c:if> />
                                                </div>
                                            </td>
                                            <%-- Equipment ไปหน้า settings คนละตัวเพราะ Stock Balance คิดจากเครื่องจริง
                                                 ไม่ได้คิดจากตาราง stock เหมือน Consumables/Accessory --%>
                                            <c:set var="editUrl" value="${product.product_type eq '1' ? 'stock_equ_edit' : 'stock_cons_edit'}" />
                                            <td class="text-end text-nowrap">
                                                <a href="${editUrl}?productId=${product.product_id}" class="btn btn-icon btn-sm btn-light-primary me-1" title="Edit">
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
        // จำนวนต่อ type render มาจาก backend (typeCounts) แล้ว ไม่ต้องนับจาก DOM

        // custom filter ตาม type ที่เลือกจากการ์ด ('' = แสดงทั้งหมด)
        var selectedType = '';
        $.fn.dataTable.ext.search.push(function (settings, data, dataIndex) {
            if (settings.nTable.id !== 'stockConsTable') { return true; }
            if (!selectedType) { return true; }
            var tr = settings.aoData[dataIndex].nTr;
            return String($(tr).data('type')) === selectedType;
        });

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
                { targets: [0, 4, 5, 6], orderable: false }
            ]
        });

        $('#searchInput').on('keyup', function () {
            table.search(this.value).draw();
        });

        // กดการ์ด type เพื่อ filter (กดซ้ำ = ยกเลิก filter)
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

        // ---- กดติ๊ก Catalog MR / Select Subproduct แล้วเซฟทันที (AJAX) ----
        var CONTEXT = '${pageContext.request.contextPath}';

        function toggleFlag($cb, url, valueKey) {
            var id = $cb.data('id');
            var checked = $cb.is(':checked');
            if (!id) { return; }
            $cb.prop('disabled', true);

            var payload = { productId: id };
            payload[valueKey] = checked ? '1' : '0';

            $.ajax({
                url: CONTEXT + '/' + url,
                type: 'POST',
                dataType: 'json',
                data: payload,
                success: function (res) {
                    if (!res || res.success !== true) {
                        $cb.prop('checked', !checked); // rollback
                        if (window.Swal) { Swal.fire('Error', 'บันทึกไม่สำเร็จ', 'error'); }
                        else { alert('บันทึกไม่สำเร็จ'); }
                    } else if (window.Swal) {
                        Swal.fire({ toast: true, position: 'top-end', icon: 'success',
                            title: 'บันทึกแล้ว', showConfirmButton: false, timer: 1200 });
                    }
                },
                error: function () {
                    $cb.prop('checked', !checked); // rollback เมื่อเซิร์ฟเวอร์/เน็ตพลาด
                    if (window.Swal) { Swal.fire('Error', 'บันทึกไม่สำเร็จ', 'error'); }
                    else { alert('บันทึกไม่สำเร็จ'); }
                },
                complete: function () {
                    $cb.prop('disabled', false);
                }
            });
        }

        $('#stockConsTable').on('change', '.js-active-toggle', function () {
            toggleFlag($(this), 'stock_cons_active_update', 'active');
        });

        $('#stockConsTable').on('change', '.js-subactive-toggle', function () {
            toggleFlag($(this), 'stock_cons_sub_active_update', 'subProductActive');
        });

        // ---- ลบ product (AJAX) - ตอบ JSON แทน redirect เพื่อโชว์เหตุผลตอนลบไม่ได้ ----
        // ใช้ POST ไม่ใช่ GET เพราะ prefetch/crawler ยิง URL แล้วลบข้อมูลได้
        $('#stockConsTable').on('click', '.btn-delete-product', function () {
            var $btn = $(this);
            var $row = $btn.closest('tr');
            var id = $btn.data('id');
            var name = $btn.data('name') || '';
            if (!id) { return; }

            function doDelete(confirmed) {
                if (!confirmed) { return; }
                $btn.prop('disabled', true);

                $.ajax({
                    url: CONTEXT + '/stock_cons_delete',
                    type: 'POST',
                    dataType: 'json',
                    data: { productId: id },
                    success: function (res) {
                        if (res && res.success === true) {
                            if (window.Swal) {
                                Swal.fire({ toast: true, position: 'top-end', icon: 'success',
                                    title: res.message || 'ลบข้อมูลสำเร็จ', showConfirmButton: false, timer: 1500 });
                            }
                            // ลบแถวออกจาก DataTables โดยไม่ต้อง reload ทั้งหน้า
                            table.row($row).remove().draw(false);
                        } else {
                            // เคสหลักที่ต้องรองรับ: มีการเรียกใช้งานอยู่ที่อื่น (mr / stock / good receipt / equipment)
                            var msg = (res && res.message) ? res.message : 'ลบไม่สำเร็จ';
                            if (window.Swal) { Swal.fire('ลบไม่สำเร็จ', msg, 'warning'); }
                            else { alert(msg); }
                            $btn.prop('disabled', false);
                        }
                    },
                    error: function () {
                        if (window.Swal) { Swal.fire('Error', 'ลบไม่สำเร็จ กรุณาลองใหม่', 'error'); }
                        else { alert('ลบไม่สำเร็จ กรุณาลองใหม่'); }
                        $btn.prop('disabled', false);
                    }
                });
            }

            if (window.Swal) {
                Swal.fire({
                    title: 'ต้องการลบรายการ "' + name + '" ใช่หรือไม่?',
                    icon: 'question',
                    showCancelButton: true,
                    confirmButtonText: 'ลบ',
                    cancelButtonText: 'ยกเลิก',
                    reverseButtons: true
                }).then(function (result) {
                    doDelete(result.isConfirmed);
                });
            } else {
                doDelete(confirm('ต้องการลบรายการ "' + name + '" ใช่หรือไม่?'));
            }
        });
    });
</script>
