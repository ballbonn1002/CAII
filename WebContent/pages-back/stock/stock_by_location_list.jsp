<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%--
  Stock By Location - UI mockup เท่านั้น (ยังไม่ต่อ backend จริง)
  หมายเหตุ: หัวกลุ่ม + แถวรายการทั้งหมดเป็น static demo data พิมพ์ตรงๆ ในไฟล์นี้
  ไม่ได้ผูกกับ ${...} จาก Action เลย (ProductAction.showStockByLocationPage() ตอนนี้แค่เช็ค
  session แล้ว return SUCCESS เฉยๆ)

  โครงสร้าง warehouse จริงเป็น tree (parent/child อ้างกันเอง) - ตัวอย่างชื่อคลัง/breadcrumb
  ที่ใช้ในไฟล์นี้อ้างจากข้อมูลจริงในตาราง warehouse ตอนที่ทำ mockup:
    Cube ITF สีลม > ห้องเก็บของ > ตู้ 1 > ชั้นที่ 1/2/3
    Cube ITF สีลม > ห้อง HR > ตู้ 1/2/3
    AIS (ไม่มีลูก)
  แนวทางที่คาดว่าจะต้องต่อจริงภายหลัง: สต็อกควรผูกกับ warehouse "ใบล่าสุด" ของ tree
  (ที่ไม่มีลูกแล้ว) เท่านั้น ไม่ใช่ทุกระดับ ไม่งั้นยอดจะนับซ้ำซ้อนกันได้ระหว่างชั้น
--%>

<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
    <div class="d-flex flex-column flex-column-fluid">
        <div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
            <div id="kt_app_toolbar_container" class="app-container container-fluid d-flex flex-stack">
                <div class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
                    <h1 class="page-heading d-flex text-gray-700 fw-semibold my-0">Stock By Location</h1>
                    <ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
                        <li class="breadcrumb-item text-muted"><a href="${pageContext.request.contextPath}/check_in_out" class="text-muted text-hover-primary fw-medium fs-7">Home</a></li>
                        <li class="breadcrumb-item"><span class="bullet bg-gray-500 fw-medium fs-7 w-5px h-2px"></span></li>
                        <li class="breadcrumb-item text-muted fw-medium fs-7"><a href="${pageContext.request.contextPath}/stock_cons_list" class="text-muted text-hover-primary">Product</a></li>
                        <li class="breadcrumb-item"><span class="bullet bg-gray-500 fw-medium fs-7 w-5px h-2px"></span></li>
                        <li class="breadcrumb-item text-muted fw-medium fs-7">Stock By Location</li>
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
                                <i class="ki-duotone ki-home-3 fs-2x text-primary"><span class="path1"></span><span class="path2"></span></i>
                                <span class="text-gray-600 fw-semibold fs-6">Locations</span>
                                <span class="text-gray-900 fw-bold fs-4 ms-auto">7 <span class="fs-7 fw-semibold text-gray-500">locations</span></span>
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
                                <i class="ki-duotone ki-abstract-26 fs-2x text-warning"><span class="path1"></span><span class="path2"></span></i>
                                <span class="text-gray-600 fw-semibold fs-6">Distinct Products</span>
                                <span class="text-gray-900 fw-bold fs-4 ms-auto">12 <span class="fs-7 fw-semibold text-gray-500">items</span></span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card">
                    <div class="card-border-radius">
                        <div class="card-header border-0 pt-6 d-flex align-items-center justify-content-between flex-wrap gap-3">
                            <h3 class="page-heading text-gray-900 fw-bold mb-0">Stock By Location</h3>
                            <div class="d-flex align-items-center position-relative">
                                <i class="ki-duotone ki-magnifier fs-3 position-absolute ms-4"><span class="path1"></span><span class="path2"></span></i>
                                <input type="text" id="locationSearch" class="form-control form-control-solid ps-12 text-gray-700"
                                       style="min-width: 280px;" placeholder="ค้นหาคลัง / ชื่อสินค้า" />
                            </div>
                        </div>
                        <div class="separator"></div>

                        <div class="card-body">
                            <%-- ============================================================
                                 หัวกลุ่ม = 1 คลังปลายทาง (ใบล่าสุดของ tree warehouse) แสดง path
                                 เต็มเป็น breadcrumb ให้เห็นลำดับชั้น กดขยาย/ยุบดูรายการสินค้าได้
                                 ทั้งหมดเป็น static demo data ============================================================ --%>
                            <div class="table-responsive">
                                <table class="table align-middle fs-6 mb-0" id="locationTable">
                                    <thead class="fs-7 text-gray-500 text-uppercase">
                                        <tr class="fw-semibold">
                                            <th class="min-w-350px text-nowrap">Location</th>
                                            <th class="min-w-120px text-nowrap text-end">Products</th>
                                            <th class="min-w-120px text-nowrap text-end">On Hand</th>
                                            <th class="w-60px"></th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                        <%-- ---- กลุ่ม 1: Cube ITF สีลม / ห้องเก็บของ / ตู้ 1 / ชั้นที่ 1 (เปิดไว้เป็นตัวอย่าง) ---- --%>
                                        <tr class="loc-total bg-light-primary" data-group="g1">
                                            <td class="text-gray-900 fw-bold">
                                                <span class="text-muted fs-7 fw-normal">Cube ITF สีลม / ห้องเก็บของ / ตู้ 1 /</span> ชั้นที่ 1
                                            </td>
                                            <td class="text-end">3</td>
                                            <td class="text-end fw-bold">96</td>
                                            <td class="text-end">
                                                <button type="button" class="btn btn-icon btn-sm btn-active-light-primary loc-toggle" data-group="g1">
                                                    <i class="ki-duotone ki-up fs-3"><span class="path1"></span><span class="path2"></span></i>
                                                </button>
                                            </td>
                                        </tr>
                                        <tr class="loc-detail" data-group="g1">
                                            <td class="ps-10 text-gray-700">เสื้อบริษัท 2026 (สีดำ)</td>
                                            <td></td>
                                            <td class="text-end text-gray-700">64</td>
                                            <td></td>
                                        </tr>
                                        <tr class="loc-detail" data-group="g1">
                                            <td class="ps-10 text-gray-700">กระดาษ A4 Double A</td>
                                            <td></td>
                                            <td class="text-end text-gray-700">22</td>
                                            <td></td>
                                        </tr>
                                        <tr class="loc-detail" data-group="g1">
                                            <td class="ps-10 text-gray-700">ริบบิ้นสีแดง</td>
                                            <td></td>
                                            <td class="text-end text-gray-700">10</td>
                                            <td></td>
                                        </tr>

                                        <%-- ---- กลุ่ม 2: Cube ITF สีลม / ห้องเก็บของ / ตู้ 1 / ชั้นที่ 2 ---- --%>
                                        <tr class="loc-total bg-light-primary collapsed" data-group="g2">
                                            <td class="text-gray-900 fw-bold">
                                                <span class="text-muted fs-7 fw-normal">Cube ITF สีลม / ห้องเก็บของ / ตู้ 1 /</span> ชั้นที่ 2
                                            </td>
                                            <td class="text-end">2</td>
                                            <td class="text-end fw-bold">150</td>
                                            <td class="text-end">
                                                <button type="button" class="btn btn-icon btn-sm btn-active-light-primary loc-toggle" data-group="g2">
                                                    <i class="ki-duotone ki-down fs-3"><span class="path1"></span><span class="path2"></span></i>
                                                </button>
                                            </td>
                                        </tr>
                                        <tr class="loc-detail d-none" data-group="g2">
                                            <td class="ps-10 text-gray-700">ถุงขยะสีดำ</td>
                                            <td></td>
                                            <td class="text-end text-gray-700">75</td>
                                            <td></td>
                                        </tr>
                                        <tr class="loc-detail d-none" data-group="g2">
                                            <td class="ps-10 text-gray-700">ถ่านพานาโซนิค</td>
                                            <td></td>
                                            <td class="text-end text-gray-700">75</td>
                                            <td></td>
                                        </tr>

                                        <%-- ---- กลุ่ม 3: Cube ITF สีลม / ห้องเก็บของ / ตู้ 1 / ชั้นที่ 3 (ว่าง) ---- --%>
                                        <tr class="loc-total bg-light-primary collapsed" data-group="g3">
                                            <td class="text-gray-900 fw-bold">
                                                <span class="text-muted fs-7 fw-normal">Cube ITF สีลม / ห้องเก็บของ / ตู้ 1 /</span> ชั้นที่ 3
                                            </td>
                                            <td class="text-end">0</td>
                                            <td class="text-end fw-bold">0</td>
                                            <td class="text-end">
                                                <button type="button" class="btn btn-icon btn-sm btn-active-light-primary loc-toggle" data-group="g3">
                                                    <i class="ki-duotone ki-down fs-3"><span class="path1"></span><span class="path2"></span></i>
                                                </button>
                                            </td>
                                        </tr>
                                        <tr class="loc-detail d-none" data-group="g3">
                                            <td colspan="4" class="ps-10 text-center text-muted py-4">ยังไม่มีสินค้าในคลังนี้</td>
                                        </tr>

                                        <%-- ---- กลุ่ม 4: Cube ITF สีลม / ห้อง HR / ตู้ 1 ---- --%>
                                        <tr class="loc-total bg-light-primary collapsed" data-group="g4">
                                            <td class="text-gray-900 fw-bold">
                                                <span class="text-muted fs-7 fw-normal">Cube ITF สีลม / ห้อง HR /</span> ตู้ 1
                                            </td>
                                            <td class="text-end">1</td>
                                            <td class="text-end fw-bold">40</td>
                                            <td class="text-end">
                                                <button type="button" class="btn btn-icon btn-sm btn-active-light-primary loc-toggle" data-group="g4">
                                                    <i class="ki-duotone ki-down fs-3"><span class="path1"></span><span class="path2"></span></i>
                                                </button>
                                            </td>
                                        </tr>
                                        <tr class="loc-detail d-none" data-group="g4">
                                            <td class="ps-10 text-gray-700">เสื้อบริษัท 2026 (สีดำ)</td>
                                            <td></td>
                                            <td class="text-end text-gray-700">40</td>
                                            <td></td>
                                        </tr>

                                        <%-- ---- กลุ่ม 5: Cube ITF สีลม / ห้อง HR / ตู้ 2 ---- --%>
                                        <tr class="loc-total bg-light-primary collapsed" data-group="g5">
                                            <td class="text-gray-900 fw-bold">
                                                <span class="text-muted fs-7 fw-normal">Cube ITF สีลม / ห้อง HR /</span> ตู้ 2
                                            </td>
                                            <td class="text-end">2</td>
                                            <td class="text-end fw-bold">65</td>
                                            <td class="text-end">
                                                <button type="button" class="btn btn-icon btn-sm btn-active-light-primary loc-toggle" data-group="g5">
                                                    <i class="ki-duotone ki-down fs-3"><span class="path1"></span><span class="path2"></span></i>
                                                </button>
                                            </td>
                                        </tr>
                                        <tr class="loc-detail d-none" data-group="g5">
                                            <td class="ps-10 text-gray-700">กระดาษ A4 Double A</td>
                                            <td></td>
                                            <td class="text-end text-gray-700">20</td>
                                            <td></td>
                                        </tr>
                                        <tr class="loc-detail d-none" data-group="g5">
                                            <td class="ps-10 text-gray-700">ถ่านพานาโซนิค</td>
                                            <td></td>
                                            <td class="text-end text-gray-700">45</td>
                                            <td></td>
                                        </tr>

                                        <%-- ---- กลุ่ม 6: Cube ITF สีลม / ห้อง HR / ตู้ 3 ---- --%>
                                        <tr class="loc-total bg-light-primary collapsed" data-group="g6">
                                            <td class="text-gray-900 fw-bold">
                                                <span class="text-muted fs-7 fw-normal">Cube ITF สีลม / ห้อง HR /</span> ตู้ 3
                                            </td>
                                            <td class="text-end">1</td>
                                            <td class="text-end fw-bold">36</td>
                                            <td class="text-end">
                                                <button type="button" class="btn btn-icon btn-sm btn-active-light-primary loc-toggle" data-group="g6">
                                                    <i class="ki-duotone ki-down fs-3"><span class="path1"></span><span class="path2"></span></i>
                                                </button>
                                            </td>
                                        </tr>
                                        <tr class="loc-detail d-none" data-group="g6">
                                            <td class="ps-10 text-gray-700">ถุงขยะสีดำ</td>
                                            <td></td>
                                            <td class="text-end text-gray-700">36</td>
                                            <td></td>
                                        </tr>

                                        <%-- ---- กลุ่ม 7: AIS (ไม่มี sub-location) ---- --%>
                                        <tr class="loc-total bg-light-primary collapsed" data-group="g7">
                                            <td class="text-gray-900 fw-bold">AIS</td>
                                            <td class="text-end">7</td>
                                            <td class="text-end fw-bold">225</td>
                                            <td class="text-end">
                                                <button type="button" class="btn btn-icon btn-sm btn-active-light-primary loc-toggle" data-group="g7">
                                                    <i class="ki-duotone ki-down fs-3"><span class="path1"></span><span class="path2"></span></i>
                                                </button>
                                            </td>
                                        </tr>
                                        <tr class="loc-detail d-none" data-group="g7">
                                            <td class="ps-10 text-gray-700">Computer</td>
                                            <td></td>
                                            <td class="text-end text-gray-700">150</td>
                                            <td></td>
                                        </tr>
                                        <tr class="loc-detail d-none" data-group="g7">
                                            <td class="ps-10 text-gray-700">instument</td>
                                            <td></td>
                                            <td class="text-end text-gray-700">20</td>
                                            <td></td>
                                        </tr>
                                        <tr class="loc-detail d-none" data-group="g7">
                                            <td class="ps-10 text-gray-700">Mobile</td>
                                            <td></td>
                                            <td class="text-end text-gray-700">8</td>
                                            <td></td>
                                        </tr>
                                        <tr class="loc-detail d-none" data-group="g7">
                                            <td class="ps-10 text-gray-700">อื่นๆ (4 รายการ)</td>
                                            <td></td>
                                            <td class="text-end text-gray-700">47</td>
                                            <td></td>
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
</div>

<script>
    $(document).ready(function () {
        // ---- ขยาย/ยุบ รายการสินค้าของแต่ละคลัง ----
        $('#locationTable').on('click', '.loc-toggle', function () {
            var group = $(this).data('group');
            var $total = $('#locationTable .loc-total[data-group="' + group + '"]');
            var willOpen = $total.hasClass('collapsed');

            $total.toggleClass('collapsed', !willOpen);
            $('#locationTable .loc-detail[data-group="' + group + '"]').toggleClass('d-none', !willOpen);

            var $icon = $total.find('.loc-toggle .ki-duotone');
            $icon.removeClass('ki-up ki-down').addClass(willOpen ? 'ki-up' : 'ki-down');
        });

        // ---- ค้นหาข้ามทุกคลัง (ชื่อคลังหรือชื่อสินค้า) ----
        $('#locationSearch').on('keyup', function () {
            var keyword = $.trim($(this).val()).toLowerCase();

            if (!keyword) {
                $('#locationTable .loc-total').removeClass('d-none').each(function () {
                    var group = $(this).data('group');
                    var collapsed = $(this).hasClass('collapsed');
                    $('#locationTable .loc-detail[data-group="' + group + '"]').toggleClass('d-none', collapsed);
                });
                return;
            }

            $('#locationTable .loc-total').each(function () {
                var group = $(this).data('group');
                var $total = $(this);
                var $details = $('#locationTable .loc-detail[data-group="' + group + '"]');
                var matchesLocation = $total.text().toLowerCase().indexOf(keyword) !== -1;

                $details.each(function () {
                    var matched = matchesLocation || $(this).text().toLowerCase().indexOf(keyword) !== -1;
                    $(this).toggleClass('d-none', !matched);
                });

                var visible = matchesLocation || $details.not('.d-none').length > 0;
                $total.toggleClass('d-none', !visible);
            });
        });
    });
</script>
