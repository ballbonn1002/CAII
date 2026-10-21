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
                        <li class="breadcrumb-item text-muted fw-medium fs-7"><a href="${pageContext.request.contextPath}/product_list" class="text-muted text-hover-primary">Product</a></li>
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
                                <a href="product_add" class="btn btn-success d-inline-flex align-items-center px-6 py-3">
                                    <i class="ki-duotone ki-plus fs-3 me-2"><span class="path1"></span><span class="path2"></span></i>
                                    <span class="fw-bold">Create</span>
                                </a>
                            </div>

                            <div class="d-flex align-items-center gap-3 mb-6">
                                <div class="d-flex align-items-center position-relative flex-grow-1">
                                    <i class="ki-duotone ki-magnifier fs-3 position-absolute ms-5"><span class="path1"></span><span class="path2"></span></i>
                                    <input type="text" id="searchInput" class="form-control form-control-solid ps-14 text-gray-700" placeholder="Search" />
                                </div>
                                <%-- สแกนบาร์โค้ด/QR ด้วยกล้อง แล้วเติมค่าลงช่องค้นหา (modal #barcodeScanModal ด้านล่าง) --%>
                                <button type="button" id="btnScanBarcode" class="btn btn-light-primary btn-icon"
                                        data-bs-toggle="modal" data-bs-target="#barcodeScanModal" title="Scan Barcode / QR" aria-label="Scan Barcode / QR">
                                    <i class="ki-duotone ki-scan-barcode fs-2"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span><span class="path7"></span><span class="path8"></span></i>
                                </button>
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

                            <%-- filter ย่อยตาม Equipment Type - โชว์เฉพาะตอนเลือกการ์ด Equipment (data-type="1")
                                 คุมด้วย JS (#equipmentTypeFilterWrap) ไม่ต้องพึ่ง JSTL เพราะขึ้นกับการคลิกฝั่ง client
                                 dropdown checkbox เลือกได้หลายตัว (pattern เดียวกับ filter "Type" ใน equipment_list.jsp)
                                 checkbox list ใช้ JSTL loop ตรงๆ เพราะ ${equipmentTypes} มีอยู่แล้วในฝั่ง server --%>
                            <div id="equipmentTypeFilterWrap" class="d-flex align-items-center gap-3 mb-6 d-none">
                                <label class="form-label fw-semibold text-gray-700 mb-0">Equipment Type</label>
                                <div class="dropdown">
                                    <button class="btn btn-white border border-gray-300 rounded-3 d-flex justify-content-between align-items-center gap-3 px-4 py-3" type="button" data-bs-toggle="dropdown" style="min-width: 250px;">
                                        <span id="equipmentTypeFilterBtnText">All</span>
                                        <i class="ki-duotone ki-down fs-4"><span class="path1"></span><span class="path2"></span></i>
                                    </button>
                                    <div class="dropdown-menu dropdown-menu-end p-4 shadow rounded-4" style="min-width: 254px;">
                                        <div class="mb-4" id="equipmentTypeFilterContainer">
                                            <c:forEach var="eqType" items="${equipmentTypes}">
                                                <label class="form-check form-check-custom form-check-solid mb-3">
                                                    <input class="form-check-input filter-equipment-type" type="checkbox" value="${fn:escapeXml(eqType.typeID)}">
                                                    <span class="form-check-label text-gray-600 fw-normal menu-heading">${fn:escapeXml(eqType.description)}</span>
                                                </label>
                                            </c:forEach>
                                        </div>
                                        <div class="d-flex justify-content-between pt-3 border-top">
                                            <button type="button" class="btn btn-light btn-equipment-type-deselect-all">Deselect All</button>
                                            <button type="button" class="btn btn-primary btn-equipment-type-select-all">Select All</button>
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
                                        <tr data-type="${fn:escapeXml(product.product_type)}"
                                            data-equipment-type="${fn:escapeXml(product.equipment_type)}">
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
                                                    <%-- รูปภาพหลักของสินค้า (ถ้ามี) - เสริมข้างไอคอนประเภทสินค้า ไม่แทนที่ --%>
                                                    <c:if test="${not empty product.image_path}">
                                                        <img src="${pageContext.request.contextPath}${fn:escapeXml(product.image_path)}"
                                                             class="w-25px h-25px rounded ms-2" alt="" />
                                                    </c:if>
                                                </div>
                                            </td>
                                            <%-- ซ่อน product_no ไว้ในเซลล์นี้เพื่อให้ DataTables global search (#searchInput)
                                                 หา Item ID เจอด้วย - ของเดิมมีแค่ product_name ในตาราง ทำให้เสิร์ช Item ID ไม่เจอเลย --%>
                                            <td class="text-gray-900 fw-normal">
                                                ${fn:escapeXml(product.product_name)}
                                                <span class="d-none">${fn:escapeXml(product.product_no)}</span>
                                            </td>
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
                                            <c:set var="editUrl" value="${product.product_type eq '1' ? 'stock_equ_edit' : 'product_edit'}" />
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

<%-- ============ Modal: สแกนบาร์โค้ด / QR code ด้วยกล้อง (html5-qrcode เก็บไว้ในโปรเจกต์ ไม่พึ่ง CDN) ============
     กล้องเปิดได้เฉพาะหน้าที่เข้าผ่าน HTTPS หรือ localhost เท่านั้น (ข้อกำหนดของเบราว์เซอร์) --%>
<div class="modal fade" id="barcodeScanModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title fw-bold text-gray-900">Scan Barcode / QR Code</h3>
                <button type="button" class="btn btn-icon btn-sm btn-active-light-primary" data-bs-dismiss="modal" aria-label="Close">
                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                </button>
            </div>
            <div class="modal-body">
                <div id="barcodeScanReader" class="w-100 rounded overflow-hidden"></div>
                <div id="barcodeScanError" class="alert alert-danger d-none mt-4 mb-0"></div>
                <div class="text-gray-600 fs-7 mt-4">เล็งกล้องไปที่บาร์โค้ดหรือ QR code ของสินค้า ระบบจะเติมค่าลงช่องค้นหาให้อัตโนมัติ</div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/assets/plugins/custom/html5-qrcode/html5-qrcode.min.js"></script>
<script>
    $(document).ready(function () {
        // จำนวนต่อ type render มาจาก backend (typeCounts) แล้ว ไม่ต้องนับจาก DOM

        // custom filter ตาม type ที่เลือกจากการ์ด ('' = แสดงทั้งหมด)
        // + filter ย่อยตาม equipment_type (มีผลเฉพาะตอน selectedType === '1' เท่านั้น)
        var selectedType = '';
        // Equipment Type ตอนนี้เลือกได้หลายตัว (dropdown checkbox) เก็บเป็น array ของ value ที่ติ๊กไว้
        var selectedEquipmentTypes = [];
        $.fn.dataTable.ext.search.push(function (settings, data, dataIndex) {
            if (settings.nTable.id !== 'stockConsTable') { return true; }
            var tr = settings.aoData[dataIndex].nTr;

            if (selectedType && String($(tr).data('type')) !== selectedType) { return false; }
            if (selectedType === '1' && selectedEquipmentTypes.length > 0
                && selectedEquipmentTypes.indexOf(String($(tr).data('equipmentType'))) === -1) { return false; }

            return true;
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

        // ==================== สแกนบาร์โค้ด / QR ด้วยกล้อง -> เติมช่องค้นหา ====================
        var barcodeScanner = null;
        var barcodeScanHandled = false;

        function showScanError(msg) {
            $('#barcodeScanError').text(msg).removeClass('d-none');
        }

        function stopBarcodeScanner() {
            if (!barcodeScanner) { return; }
            var scanner = barcodeScanner;
            barcodeScanner = null;
            // stop() ตอนกล้องยังไม่เริ่ม/เริ่มไม่สำเร็จจะ reject - ไม่ต้องสนใจ
            scanner.stop().then(function () { scanner.clear(); }).catch(function () {});
        }

        function onBarcodeScanned(text) {
            if (barcodeScanHandled) { return; }   // callback ถูกเรียกซ้ำทุกเฟรมที่เห็นโค้ด รับแค่ครั้งแรก
            barcodeScanHandled = true;
            var value = $.trim(text);
            $('#searchInput').val(value);
            table.search(value).draw();
            $('#barcodeScanModal').modal('hide');

            if (table.rows({ search: 'applied' }).count() === 0 && window.Swal) {
                Swal.fire({ icon: 'info', title: 'ไม่พบสินค้าที่ตรงกับค่าที่สแกน',
                            text: 'ลองตรวจสอบตัวกรองประเภทสินค้า หรือค่าที่สแกนได้: ' + value });
            }
        }

        $('#barcodeScanModal').on('shown.bs.modal', function () {
            barcodeScanHandled = false;
            $('#barcodeScanError').addClass('d-none').text('');

            if (!window.isSecureContext) {
                showScanError('เปิดกล้องไม่ได้: ต้องเข้าเว็บผ่าน HTTPS หรือ localhost เท่านั้น');
                return;
            }
            if (typeof Html5Qrcode === 'undefined') {
                showScanError('โหลดตัวสแกนไม่สำเร็จ กรุณารีเฟรชหน้าแล้วลองใหม่');
                return;
            }

            barcodeScanner = new Html5Qrcode('barcodeScanReader');
            barcodeScanner.start({ facingMode: 'environment' }, { fps: 10 }, onBarcodeScanned, function () {})
                .catch(function (err) {
                    var name = (err && err.name) ? err.name : '';
                    if (name === 'NotAllowedError' || String(err).indexOf('Permission') !== -1) {
                        showScanError('ไม่ได้รับอนุญาตให้ใช้กล้อง กรุณาอนุญาตในเบราว์เซอร์แล้วลองใหม่');
                    } else if (name === 'NotFoundError' || String(err).indexOf('NotFound') !== -1) {
                        showScanError('ไม่พบกล้องในอุปกรณ์นี้');
                    } else {
                        showScanError('เปิดกล้องไม่สำเร็จ: ' + err);
                    }
                    barcodeScanner = null;
                });
        });

        $('#barcodeScanModal').on('hide.bs.modal', stopBarcodeScanner);

        // กดการ์ด type เพื่อ filter (กดซ้ำ = ยกเลิก filter)
        // สลับออกจาก Equipment (หรือยกเลิก filter) ทุกครั้งต้องล้างค่า Equipment Type filter ด้วย
        // ไม่งั้นจะค้างเป็นตัวกรองที่มองไม่เห็น (dropdown ซ่อนอยู่แต่ค่ายังเลือกไว้)
        var $equipmentTypeFilterWrap = $('#equipmentTypeFilterWrap');
        var $equipmentTypeFilterContainer = $('#equipmentTypeFilterContainer');
        var $equipmentTypeFilterBtnText = $('#equipmentTypeFilterBtnText');

        function toggleEquipmentTypeFilter(isEquipment) {
            $equipmentTypeFilterWrap.toggleClass('d-none', !isEquipment);
            if (!isEquipment) {
                selectedEquipmentTypes = [];
                $equipmentTypeFilterContainer.find('input[type="checkbox"]').prop('checked', false);
                $equipmentTypeFilterBtnText.text('All');
            }
        }

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
            toggleEquipmentTypeFilter(selectedType === '1');
            table.draw();
        });

        // อ่าน checkbox ที่ติ๊กไว้ทั้งหมด -> selectedEquipmentTypes + อัปเดตข้อความบนปุ่ม dropdown
        // (pattern เดียวกับ updateFilter ของ equipment_list.jsp แต่ไม่มีคอลัมน์ DataTables ให้ search
        // เพราะ equipment_type ไม่ได้แสดงเป็นคอลัมน์ในตารางนี้ - ใช้ custom search ข้างบนกรองแทน)
        function updateEquipmentTypeFilter() {
            var checked = $equipmentTypeFilterContainer.find('input[type="checkbox"]:checked');
            var labels = [];
            selectedEquipmentTypes = [];

            checked.each(function () {
                selectedEquipmentTypes.push(String($(this).val()));
                labels.push($(this).siblings('span').text().trim());
            });

            if (selectedEquipmentTypes.length === 0) {
                $equipmentTypeFilterBtnText.text('All');
            } else {
                $equipmentTypeFilterBtnText.text(labels.length <= 2 ? labels.join(', ') : labels.length + ' Selected');
            }

            table.draw();
        }

        $equipmentTypeFilterContainer.on('change', '.filter-equipment-type', updateEquipmentTypeFilter);

        $('.btn-equipment-type-select-all').on('click', function (e) {
            e.stopPropagation();
            $equipmentTypeFilterContainer.find('input[type="checkbox"]').prop('checked', true);
            updateEquipmentTypeFilter();
        });

        $('.btn-equipment-type-deselect-all').on('click', function (e) {
            e.stopPropagation();
            $equipmentTypeFilterContainer.find('input[type="checkbox"]').prop('checked', false);
            updateEquipmentTypeFilter();
        });

        // กันไม่ให้ dropdown ปิดเวลาคลิกพื้นที่ว่างในเมนู (ติ๊ก checkbox / กดปุ่ม select all)
        $equipmentTypeFilterWrap.find('.dropdown-menu').on('click', function (e) { e.stopPropagation(); });

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
            toggleFlag($(this), 'product_active_update', 'active');
        });

        $('#stockConsTable').on('change', '.js-subactive-toggle', function () {
            toggleFlag($(this), 'product_sub_active_update', 'subProductActive');
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
                    url: CONTEXT + '/product_delete',
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
