<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%--
  Stock By Product - UI mockup เท่านั้น (ยังไม่ต่อ backend จริง)
  หมายเหตุ: ทุกแถวในตาราง + การ์ดสรุปด้านบนเป็น static demo data พิมพ์ไว้ตรงๆ ในไฟล์นี้
  ไม่ได้ผูกกับ ${...} จาก Action เลย - รอ requirement เรื่องคอลัมน์/filter นิ่งก่อนค่อยต่อจริง
  (ProductAction.showStockByProductPage() ตอนนี้แค่เช็ค session แล้ว return SUCCESS เฉยๆ)

  แนวทางที่คาดว่าจะต้องต่อจริงภายหลัง (ดู skill product-module):
    - On Hand ของ type '1' (Equipment) นับจากตาราง equipment ไม่ใช่ stock
    - On Hand ของ type '2','3' นับจากตาราง stock (reconcile ล่าสุดต่อ product/warehouse)
    - ต้องกัน EquipmentDAO.RETIRED_STATUSES ออกจากยอด Equipment เหมือนหน้า stock_equ_balance
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
                        <li class="breadcrumb-item text-muted fw-medium fs-7"><a href="${pageContext.request.contextPath}/stock_cons_list" class="text-muted text-hover-primary">Product</a></li>
                        <li class="breadcrumb-item"><span class="bullet bg-gray-500 fw-medium fs-7 w-5px h-2px"></span></li>
                        <li class="breadcrumb-item text-muted fw-medium fs-7">Stock By Product</li>
                    </ul>
                </div>
            </div>
        </div>

        <div id="kt_app_content" class="app-content flex-column-fluid">
            <div id="kt_app_content_container" class="app-container container-fluid">

                <%-- ---- การ์ดสรุปด้านบน (mockup - เลขนิ่งๆ ไม่ได้คำนวณจริง) ---- --%>
                <div class="row g-4 mb-6">
                    <div class="col-12 col-md-4">
                        <div class="card card-bordered h-100">
                            <div class="card-body d-flex align-items-center gap-3 py-4 px-5">
                                <i class="ki-duotone ki-abstract-26 fs-2x text-primary"><span class="path1"></span><span class="path2"></span></i>
                                <span class="text-gray-600 fw-semibold fs-6">Total Products</span>
                                <span class="text-gray-900 fw-bold fs-4 ms-auto">12 <span class="fs-7 fw-semibold text-gray-500">items</span></span>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-md-4">
                        <div class="card card-bordered h-100">
                            <div class="card-body d-flex align-items-center gap-3 py-4 px-5">
                                <i class="ki-duotone ki-package fs-2x text-success"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i>
                                <span class="text-gray-600 fw-semibold fs-6">Total On Hand</span>
                                <span class="text-gray-900 fw-bold fs-4 ms-auto">612 <span class="fs-7 fw-semibold text-gray-500">units</span></span>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-md-4">
                        <div class="card card-bordered h-100">
                            <div class="card-body d-flex align-items-center gap-3 py-4 px-5">
                                <i class="ki-duotone ki-home-2 fs-2x text-warning"><span class="path1"></span><span class="path2"></span></i>
                                <span class="text-gray-600 fw-semibold fs-6">Warehouses</span>
                                <span class="text-gray-900 fw-bold fs-4 ms-auto">6 <span class="fs-7 fw-semibold text-gray-500">locations</span></span>
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

                            <%-- ---- การ์ด filter ตาม type (mockup - ตัวเลขไม่ได้นับจากตารางจริง) ---- --%>
                            <div class="row g-4 mb-6">
                                <div class="col-12 col-md-4">
                                    <div class="card card-bordered h-100 cursor-pointer type-filter-card" data-type="1">
                                        <div class="card-body d-flex align-items-center gap-3 py-4 px-5">
                                            <i class="ki-duotone ki-laptop fs-2x text-primary"><span class="path1"></span><span class="path2"></span></i>
                                            <span class="text-gray-600 fw-semibold fs-6">Equipment</span>
                                            <span class="text-gray-900 fw-bold fs-4 ms-auto">7 <span class="fs-7 fw-semibold text-gray-500">items</span></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12 col-md-4">
                                    <div class="card card-bordered h-100 cursor-pointer type-filter-card" data-type="2">
                                        <div class="card-body d-flex align-items-center gap-3 py-4 px-5">
                                            <i class="ki-duotone ki-element-11 fs-2x text-warning"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i>
                                            <span class="text-gray-600 fw-semibold fs-6">Consumables</span>
                                            <span class="text-gray-900 fw-bold fs-4 ms-auto">4 <span class="fs-7 fw-semibold text-gray-500">items</span></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12 col-md-4">
                                    <div class="card card-bordered h-100 cursor-pointer type-filter-card" data-type="3">
                                        <div class="card-body d-flex align-items-center gap-3 py-4 px-5">
                                            <i class="ki-duotone ki-award fs-2x text-success"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i>
                                            <span class="text-gray-600 fw-semibold fs-6">Accessories</span>
                                            <span class="text-gray-900 fw-bold fs-4 ms-auto">1 <span class="fs-7 fw-semibold text-gray-500">items</span></span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <%-- ============================================================
                                 ตารางด้านล่างทั้งหมดเป็น static demo data (พิมพ์ตรงๆ ไม่ใช่ c:forEach
                                 จาก backend) ใช้ชื่อสินค้าจริงจากระบบเพื่อให้ดูสมจริง แต่ตัวเลขยอด
                                 เป็นค่าจำลองล้วนๆ
                                 ============================================================ --%>
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
                                    <tr data-type="1">
                                        <td class="text-gray-900 fw-bold">1</td>
                                        <td><i class="ki-duotone ki-laptop fs-2 text-primary me-2"><span class="path1"></span><span class="path2"></span></i>Equipment</td>
                                        <td class="text-gray-900 fw-normal">Computer</td>
                                        <td class="text-gray-700">เครื่อง</td>
                                        <td class="text-end fw-bold">261</td>
                                        <td class="text-center"><span class="badge badge-light-primary fw-semibold">3 คลัง</span></td>
                                        <td class="text-end"><a href="stock_equ_balance?productId=19" class="btn btn-icon btn-sm btn-light-primary" title="View"><i class="ki-duotone ki-eye fs-3"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i></a></td>
                                    </tr>
                                    <tr data-type="1">
                                        <td class="text-gray-900 fw-bold">2</td>
                                        <td><i class="ki-duotone ki-laptop fs-2 text-primary me-2"><span class="path1"></span><span class="path2"></span></i>Equipment</td>
                                        <td class="text-gray-900 fw-normal">instument</td>
                                        <td class="text-gray-700">เครื่อง</td>
                                        <td class="text-end fw-bold">31</td>
                                        <td class="text-center"><span class="badge badge-light-primary fw-semibold">2 คลัง</span></td>
                                        <td class="text-end"><a href="#" class="btn btn-icon btn-sm btn-light-primary" title="View"><i class="ki-duotone ki-eye fs-3"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i></a></td>
                                    </tr>
                                    <tr data-type="1">
                                        <td class="text-gray-900 fw-bold">3</td>
                                        <td><i class="ki-duotone ki-laptop fs-2 text-primary me-2"><span class="path1"></span><span class="path2"></span></i>Equipment</td>
                                        <td class="text-gray-900 fw-normal">Software License (L)</td>
                                        <td class="text-gray-700">license</td>
                                        <td class="text-end fw-bold">23</td>
                                        <td class="text-center"><span class="badge badge-light-primary fw-semibold">1 คลัง</span></td>
                                        <td class="text-end"><a href="#" class="btn btn-icon btn-sm btn-light-primary" title="View"><i class="ki-duotone ki-eye fs-3"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i></a></td>
                                    </tr>
                                    <tr data-type="1">
                                        <td class="text-gray-900 fw-bold">4</td>
                                        <td><i class="ki-duotone ki-laptop fs-2 text-primary me-2"><span class="path1"></span><span class="path2"></span></i>Equipment</td>
                                        <td class="text-gray-900 fw-normal">Mobile</td>
                                        <td class="text-gray-700">เครื่อง</td>
                                        <td class="text-end fw-bold">8</td>
                                        <td class="text-center"><span class="badge badge-light-primary fw-semibold">2 คลัง</span></td>
                                        <td class="text-end"><a href="#" class="btn btn-icon btn-sm btn-light-primary" title="View"><i class="ki-duotone ki-eye fs-3"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i></a></td>
                                    </tr>
                                    <tr data-type="1">
                                        <td class="text-gray-900 fw-bold">5</td>
                                        <td><i class="ki-duotone ki-laptop fs-2 text-primary me-2"><span class="path1"></span><span class="path2"></span></i>Equipment</td>
                                        <td class="text-gray-900 fw-normal">Pocket WIFI</td>
                                        <td class="text-gray-700">เครื่อง</td>
                                        <td class="text-end fw-bold">5</td>
                                        <td class="text-center"><span class="badge badge-light-primary fw-semibold">1 คลัง</span></td>
                                        <td class="text-end"><a href="#" class="btn btn-icon btn-sm btn-light-primary" title="View"><i class="ki-duotone ki-eye fs-3"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i></a></td>
                                    </tr>
                                    <tr data-type="1">
                                        <td class="text-gray-900 fw-bold">6</td>
                                        <td><i class="ki-duotone ki-laptop fs-2 text-primary me-2"><span class="path1"></span><span class="path2"></span></i>Equipment</td>
                                        <td class="text-gray-900 fw-normal">Other</td>
                                        <td class="text-gray-700">เครื่อง</td>
                                        <td class="text-end fw-bold">7</td>
                                        <td class="text-center"><span class="badge badge-light-primary fw-semibold">1 คลัง</span></td>
                                        <td class="text-end"><a href="#" class="btn btn-icon btn-sm btn-light-primary" title="View"><i class="ki-duotone ki-eye fs-3"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i></a></td>
                                    </tr>
                                    <tr data-type="1">
                                        <td class="text-gray-900 fw-bold">7</td>
                                        <td><i class="ki-duotone ki-laptop fs-2 text-primary me-2"><span class="path1"></span><span class="path2"></span></i>Equipment</td>
                                        <td class="text-gray-900 fw-normal">Software License (sl)</td>
                                        <td class="text-gray-700">license</td>
                                        <td class="text-end fw-bold">3</td>
                                        <td class="text-center"><span class="badge badge-light-primary fw-semibold">1 คลัง</span></td>
                                        <td class="text-end"><a href="#" class="btn btn-icon btn-sm btn-light-primary" title="View"><i class="ki-duotone ki-eye fs-3"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i></a></td>
                                    </tr>
                                    <tr data-type="2">
                                        <td class="text-gray-900 fw-bold">8</td>
                                        <td><i class="ki-duotone ki-element-11 fs-2 text-warning me-2"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i>Consumables</td>
                                        <td class="text-gray-900 fw-normal">เสื้อบริษัท 2026 (สีดำ)</td>
                                        <td class="text-gray-700">ตัว</td>
                                        <td class="text-end fw-bold">184</td>
                                        <td class="text-center"><span class="badge badge-light-primary fw-semibold">2 คลัง</span></td>
                                        <td class="text-end"><a href="stock_cons_balance?productId=1" class="btn btn-icon btn-sm btn-light-primary" title="View"><i class="ki-duotone ki-eye fs-3"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i></a></td>
                                    </tr>
                                    <tr data-type="2">
                                        <td class="text-gray-900 fw-bold">9</td>
                                        <td><i class="ki-duotone ki-element-11 fs-2 text-warning me-2"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i>Consumables</td>
                                        <td class="text-gray-900 fw-normal">ถุงขยะสีดำ</td>
                                        <td class="text-gray-700">ใบ</td>
                                        <td class="text-end fw-bold">75</td>
                                        <td class="text-center"><span class="badge badge-light-primary fw-semibold">3 คลัง</span></td>
                                        <td class="text-end"><a href="#" class="btn btn-icon btn-sm btn-light-primary" title="View"><i class="ki-duotone ki-eye fs-3"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i></a></td>
                                    </tr>
                                    <tr data-type="2">
                                        <td class="text-gray-900 fw-bold">10</td>
                                        <td><i class="ki-duotone ki-element-11 fs-2 text-warning me-2"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i>Consumables</td>
                                        <td class="text-gray-900 fw-normal">กระดาษ A4 Double A</td>
                                        <td class="text-gray-700">รีม</td>
                                        <td class="text-end fw-bold">42</td>
                                        <td class="text-center"><span class="badge badge-light-primary fw-semibold">1 คลัง</span></td>
                                        <td class="text-end"><a href="#" class="btn btn-icon btn-sm btn-light-primary" title="View"><i class="ki-duotone ki-eye fs-3"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i></a></td>
                                    </tr>
                                    <tr data-type="2">
                                        <td class="text-gray-900 fw-bold">11</td>
                                        <td><i class="ki-duotone ki-element-11 fs-2 text-warning me-2"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i>Consumables</td>
                                        <td class="text-gray-900 fw-normal">ถ่านพานาโซนิค</td>
                                        <td class="text-gray-700">ก้อน</td>
                                        <td class="text-end fw-bold">120</td>
                                        <td class="text-center"><span class="badge badge-light-primary fw-semibold">2 คลัง</span></td>
                                        <td class="text-end"><a href="#" class="btn btn-icon btn-sm btn-light-primary" title="View"><i class="ki-duotone ki-eye fs-3"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i></a></td>
                                    </tr>
                                    <tr data-type="3">
                                        <td class="text-gray-900 fw-bold">12</td>
                                        <td><i class="ki-duotone ki-award fs-2 text-success me-2"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i>Accessories</td>
                                        <td class="text-gray-900 fw-normal">ริบบิ้นสีแดง</td>
                                        <td class="text-gray-700">ม้วน</td>
                                        <td class="text-end fw-bold">18</td>
                                        <td class="text-center"><span class="badge badge-light-primary fw-semibold">1 คลัง</span></td>
                                        <td class="text-end"><a href="#" class="btn btn-icon btn-sm btn-light-primary" title="View"><i class="ki-duotone ki-eye fs-3"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i></a></td>
                                    </tr>
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
