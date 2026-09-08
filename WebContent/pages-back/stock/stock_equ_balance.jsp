<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%--
  Stock - Equipment : Stock Balance

  ต่างจาก stock_cons_balance.jsp ตรงที่ยอดคงเหลือของ Equipment คือ "จำนวนเครื่องจริง"
  ในตาราง equipment ที่ผูก product_id ไว้ ไม่ได้มาจากตาราง stock / good_receipt
  จึงไม่มี Add Stock / History IN-OUT แต่แสดงเป็นรายการเครื่องแทน

  attribute จาก ProductAction.showEquipmentBalancePage():
    product      : Product (catalog item ที่กำลังดู)
    groups       : List<Map> {label, productId, total, retired, rows:List<Equipment>}
                   1 กลุ่มต่อ 1 sub product (เครื่องผูกกับ sub product เป็นหลัก 25/08/2026)
                   บวกกลุ่มของตัวแม่เองถ้ามีเครื่องผูกตรงแบบเก่า หรือยังไม่มี sub product เลย
                   ใช้ทำแถบสรุป All + ปุ่มต่อ sub product (data-group=g.productId) แทนปุ่ม Available/Borrowed เดิม
    totalOnHand      : จำนวนเครื่องที่นับเป็นของคงเหลือ (รวมทุกกลุ่ม)
    totalAvailable   : จำนวนเครื่อง status Available (รวมทุกกลุ่ม) - action ยังส่งมาให้ แต่หน้านี้ไม่ได้ใช้แสดงแล้ว
    totalBorrowed    : จำนวนเครื่อง status Borrowed (รวมทุกกลุ่ม) - action ยังส่งมาให้ แต่หน้านี้ไม่ได้ใช้แสดงแล้ว
    totalRetired     : จำนวนเครื่องที่ปลดระวาง/บริจาคไปแล้ว (รวมทุกกลุ่ม) - action ยังส่งมาให้ แต่หน้านี้ไม่ได้ใช้แสดงแล้ว
--%>

<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
    <div class="d-flex flex-column flex-column-fluid">
        <div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
            <div id="kt_app_toolbar_container" class="app-container container-fluid d-flex flex-stack">
                <div class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
                    <h1 class="page-heading d-flex text-gray-700 fw-semibold my-0">Stock - Equipment</h1>
                    <ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
                        <li class="breadcrumb-item text-muted"><a href="${pageContext.request.contextPath}/check_in_out" class="text-muted text-hover-primary fw-medium fs-7">Home</a></li>
                        <li class="breadcrumb-item"><span class="bullet bg-gray-500 fw-medium fs-7 w-5px h-2px"></span></li>
                        <li class="breadcrumb-item text-muted fw-medium fs-7"><a href="${pageContext.request.contextPath}/stock_cons_list" class="text-muted text-hover-primary">Product</a></li>
                    </ul>
                </div>

                <div class="d-flex align-items-center gap-3">
                    <a href="stock_equ_edit?productId=${product.productId}" class="btn btn-light d-inline-flex align-items-center px-5 py-3">
                        <i class="ki-duotone ki-setting-2 fs-3 me-2 text-gray-500"><span class="path1"></span><span class="path2"></span></i>
                        <span class="fw-semibold text-gray-700">Product</span>
                    </a>
                    <a href="stock_equ_balance?productId=${product.productId}" class="btn btn-light-primary d-inline-flex align-items-center px-5 py-3 active">
                        <i class="ki-duotone ki-cube-2 fs-3 me-2"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i>
                        <span class="fw-semibold">Stock Balance</span>
                    </a>
                </div>
            </div>
        </div>

        <div id="kt_app_content" class="app-content flex-column-fluid">
            <div id="kt_app_content_container" class="app-container container-fluid">

                <div class="card mb-8">
                    <div class="card-border-radius">
                        <div class="card-header border-0 pt-6 d-flex align-items-center justify-content-between flex-wrap gap-3">
                            <div>
                                <h3 class="page-heading text-gray-900 fw-bold mb-1">Stock Balance</h3>
                                <span class="text-gray-500 fs-7">${fn:escapeXml(product.productName)}</span>
                            </div>
                        </div>

                        <div class="card-body">
                            <%-- ---- แถบสรุป All / sub product - กดกรองตารางด้านล่าง (กดซ้ำ = ยกเลิก) ----
                                 ยอดคำนวณฝั่ง server จาก showEquipmentBalancePage() (totalOnHand/groups[].total)
                                 ไม่นับ equipment ที่ปลดระวางแล้ว (ดู EquipmentDAO.RETIRED_STATUSES) --%>
                            <div class="d-flex flex-wrap justify-content-center gap-6 gap-lg-10 mb-8">
                                <div class="text-center">
                                    <button type="button" class="btn btn-light-success fw-bold fs-5 px-6 py-3 equ-group-filter active" data-group="ALL">All</button>
                                    <div class="fw-bold fs-4 text-gray-900 mt-3">${totalOnHand}</div>
                                </div>
                                <c:forEach var="g" items="${groups}">
                                    <div class="text-center">
                                        <button type="button" class="btn btn-light-primary fw-bold fs-5 px-6 py-3 equ-group-filter" data-group="${g.productId}">${fn:escapeXml(g.label)}</button>
                                        <div class="fw-bold fs-4 text-gray-900 mt-3">${g.total}</div>
                                    </div>
                                </c:forEach>
                            </div>

                            <div class="d-flex flex-wrap align-items-center gap-3 mb-6">
                                <div class="d-flex align-items-center position-relative flex-grow-1" style="min-width: 240px;">
                                    <i class="ki-duotone ki-magnifier fs-3 position-absolute ms-5"><span class="path1"></span><span class="path2"></span></i>
                                    <input type="text" id="equipmentSearch" class="form-control form-control-solid ps-14 text-gray-700"
                                           placeholder="ค้นหา Item ID / Serial No / ชื่อเครื่อง / ที่ตั้ง" />
                                </div>

                                <%-- Checkbox dropdown filter ตาม status (เลือกได้หลายค่าพร้อมกัน) - default ติ๊ก Available (A) + Borrowed (B)
                                     รายชื่อ status ดึงจาก request attribute equipmentStatusList (ProductAction.showEquipmentBalancePage)
                                     ไม่ใช้ DataTables filter เพราะหน้านี้ไม่ได้ใช้ DataTables --%>
                                <div class="dropdown" style="min-width: 220px;">
                                    <button class="btn btn-white border border-gray-300 rounded-3 d-flex justify-content-between align-items-center w-100 px-4 py-3"
                                            type="button" data-bs-toggle="dropdown" id="equipmentStatusFilterBtn">
                                        <span>All Status</span>
                                        <i class="ki-duotone ki-down fs-4"><span class="path1"></span><span class="path2"></span></i>
                                    </button>
                                    <div class="dropdown-menu dropdown-menu-end p-4 shadow rounded-4" id="equipmentStatusFilterMenu" style="min-width: 254px;">
                                        <div class="mb-4" id="statusFilterContainer"></div>
                                        <div class="d-flex justify-content-between pt-3 border-top">
                                            <button type="button" class="btn btn-light" id="equipmentStatusDeselectAll">Deselect All</button>
                                            <button type="button" class="btn btn-primary" id="equipmentStatusSelectAll">Select All</button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="table-responsive">
                                <table class="table align-middle fs-6 mb-0" id="equipmentBalanceTable">
                                    <thead class="fs-7 text-gray-500 text-uppercase">
                                        <tr class="fw-semibold">
                                            <th class="min-w-150px text-nowrap">Item ID</th>
                                            <th class="min-w-250px text-nowrap">ชื่อเครื่อง</th>
                                            <th class="min-w-180px text-nowrap">Serial No</th>
                                            <th class="min-w-120px text-nowrap text-center">Status</th>
                                            <th class="min-w-180px text-nowrap">ที่ตั้ง</th>
                                            <th class="w-60px"></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="g" items="${groups}" varStatus="gs">
                                            <%-- หัวกลุ่ม = ตัว catalog เอง (Equipment ไม่มี sub product แล้ว เครื่องทุกตัวรวมอยู่กลุ่มเดียว) กดขยาย/ยุบได้ --%>
                                            <tr class="equ-total bg-light-primary${gs.first ? '' : ' collapsed'}" data-group="${g.productId}">
                                                <td class="text-gray-900 fw-bold" colspan="3">${fn:escapeXml(g.label)}</td>
                                                <td class="text-center">
                                                    <span class="badge badge-primary fw-bold">${g.total} เครื่อง</span>
                                                </td>
                                                <td class="text-gray-500 fs-7">
                                                    <c:if test="${g.retired > 0}">ปลดระวางแล้ว ${g.retired}</c:if>
                                                </td>
                                                <td class="text-end">
                                                    <button type="button" class="btn btn-icon btn-sm btn-active-light-primary equ-toggle" data-group="${g.productId}">
                                                        <i class="ki-duotone ${gs.first ? 'ki-up' : 'ki-down'} fs-3"><span class="path1"></span><span class="path2"></span></i>
                                                    </button>
                                                </td>
                                            </tr>

                                            <%-- เครื่องที่ปลดระวางแล้วยังโชว์อยู่ แต่ทำให้จางลงและไม่ถูกนับในยอด
                                                 flag e.retired คำนวณมาจาก action แล้ว (อิง EquipmentDAO.RETIRED_STATUSES) --%>
                                            <c:forEach var="e" items="${g.rows}">
                                                <tr class="equ-detail${gs.first ? '' : ' d-none'}${e.retired ? ' opacity-50' : ''}" data-group="${g.productId}" data-status="${fn:escapeXml(e.status)}">
                                                    <%-- ข้อมูลเก่าบางแถว item_no / name ว่าง (8 และ 13 แถว ณ 10/08/2026)
                                                         โชว์ #equipment_id แทนจะได้ยังอ้างอิงเครื่องได้ --%>
                                                    <td class="text-gray-900 fw-bold">
                                                        <c:choose>
                                                            <c:when test="${not empty fn:trim(e.itemNo)}">${fn:escapeXml(e.itemNo)}</c:when>
                                                            <c:otherwise><span class="text-muted">#${e.equipmentId}</span></c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td class="text-gray-700">
                                                        <c:choose>
                                                            <c:when test="${not empty fn:trim(e.name)}">${fn:escapeXml(e.name)}</c:when>
                                                            <c:otherwise><span class="text-muted">(ไม่ระบุชื่อ)</span></c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td class="text-gray-700">
                                                        <c:choose>
                                                            <c:when test="${not empty e.serialNo}">${fn:escapeXml(e.serialNo)}</c:when>
                                                            <c:otherwise><span class="text-muted">-</span></c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td class="text-center">
                                                        <span class="badge fw-semibold ${e.retired ? 'badge-light-danger' : 'badge-light-success'}">
                                                            <c:choose>
                                                                <c:when test="${not empty e.status}">${fn:escapeXml(e.status)}</c:when>
                                                                <c:otherwise>-</c:otherwise>
                                                            </c:choose>
                                                        </span>
                                                    </td>
                                                    <td class="text-gray-700">
                                                        <c:choose>
                                                            <c:when test="${not empty e.location}">${fn:escapeXml(e.location)}</c:when>
                                                            <c:otherwise><span class="text-muted">-</span></c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td></td>
                                                </tr>
                                            </c:forEach>

                                            <c:if test="${empty g.rows}">
                                                <tr class="equ-detail${gs.first ? '' : ' d-none'}" data-group="${g.productId}">
                                                    <td colspan="6" class="text-center text-muted py-6">ยังไม่มีเครื่องในกลุ่มนี้</td>
                                                </tr>
                                            </c:if>
                                        </c:forEach>

                                        <c:if test="${empty groups}">
                                            <tr>
                                                <td colspan="6" class="text-center text-muted py-10">
                                                    ยังไม่มีเครื่องผูกกับ item นี้ - ตรวจสอบว่ารัน migration ผูก equipment.product_id แล้วหรือยัง
                                                </td>
                                            </tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="d-flex justify-content-start">
                    <a href="stock_cons_list" class="btn btn-light d-inline-flex align-items-center px-6 py-3">
                        <i class="ki-duotone ki-arrow-left fs-3 me-2"><span class="path1"></span><span class="path2"></span></i>
                        <span class="fw-bold text-gray-700">Back</span>
                    </a>
                </div>

            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        // ---- ขยาย/ยุบ รายการเครื่องของแต่ละกลุ่ม ----
        $('#equipmentBalanceTable').on('click', '.equ-toggle', function () {
            var group = $(this).data('group');
            var $total = $('#equipmentBalanceTable .equ-total[data-group="' + group + '"]');
            var willOpen = $total.hasClass('collapsed');

            $total.toggleClass('collapsed', !willOpen);
            $('#equipmentBalanceTable .equ-detail[data-group="' + group + '"]').toggleClass('d-none', !willOpen);

            var $icon = $total.find('.equ-toggle .ki-duotone');
            $icon.removeClass('ki-up ki-down').addClass(willOpen ? 'ki-up' : 'ki-down');
        });

        // ==================== Filter: Status (checkbox dropdown, multi-select) ====================
        // pattern เดียวกับ dbStatusList ใน equipment_list.jsp - ข้อมูลถูกดึงมาครบทุก status อยู่แล้ว
        // จาก EquipmentDAO.findByProductIds() ฝั่งนี้แค่กรองที่ DOM
        var dbStatusList = ${equipmentStatusList != null ? equipmentStatusList : '[]'};
        var selectedStatuses = [];

        (function buildStatusFilter() {
            var html = '';
            $.each(dbStatusList, function (i, st) {
                // default: ติ๊ก Available (A) และ Borrowed (B) ไว้ตั้งแต่โหลดหน้า
                var checked = (st.statusId === 'A' || st.statusId === 'B') ? ' checked' : '';
                html += '<label class="form-check form-check-custom form-check-solid mb-3">'
                    + '<input class="form-check-input filter-status" type="checkbox" value="' + st.statusId + '"' + checked + '>'
                    + '<span class="form-check-label text-gray-600 fw-normal">'
                    + (st.description || st.statusId)
                    + '</span></label>';
            });
            $('#statusFilterContainer').html(html);
            selectedStatuses = readSelectedStatuses();
            updateStatusFilterLabel();
        })();

        function readSelectedStatuses() {
            var vals = [];
            $('#statusFilterContainer input[type="checkbox"]:checked').each(function () {
                vals.push($(this).val());
            });
            return vals;
        }

        function updateStatusFilterLabel() {
            var $label = $('#equipmentStatusFilterBtn span').first();
            var total = $('#statusFilterContainer input[type="checkbox"]').length;
            if (selectedStatuses.length === 0 || selectedStatuses.length === total) {
                $label.text('All Status');
                return;
            }
            if (selectedStatuses.length <= 2) {
                var labels = [];
                $('#statusFilterContainer input[type="checkbox"]:checked').each(function () {
                    labels.push($(this).parent().find('span').text().trim());
                });
                $label.text(labels.join(', '));
            } else {
                $label.text(selectedStatuses.length + ' Selected');
            }
        }

        // กันไม่ให้ dropdown ปิดตอนคลิกข้างในเมนู (ติ๊ก checkbox / กด Select-Deselect All)
        $('#equipmentStatusFilterMenu').on('click', function (e) {
            e.stopPropagation();
        });

        $('#statusFilterContainer').on('change', '.filter-status', function () {
            selectedStatuses = readSelectedStatuses();
            updateStatusFilterLabel();
            applyEquipmentFilters();
        });

        $('#equipmentStatusSelectAll').on('click', function () {
            $('#statusFilterContainer input[type="checkbox"]').prop('checked', true);
            selectedStatuses = readSelectedStatuses();
            updateStatusFilterLabel();
            applyEquipmentFilters();
        });

        $('#equipmentStatusDeselectAll').on('click', function () {
            $('#statusFilterContainer input[type="checkbox"]').prop('checked', false);
            selectedStatuses = [];
            updateStatusFilterLabel();
            applyEquipmentFilters();
        });

        // ---- ค้นหา + กรองกลุ่ม (All / sub product) + กรอง status ข้ามทุกกลุ่มพร้อมกัน ----
        // ไม่ใช้ DataTables เพราะตารางมีแถวหัวกลุ่มปนอยู่ ซึ่ง DataTables จะ sort/paging รวมไปด้วย
        var selectedGroup = 'ALL';

        function applyEquipmentFilters() {
            var keyword = $.trim($('#equipmentSearch').val()).toLowerCase();
            var totalStatusCount = $('#statusFilterContainer input[type="checkbox"]').length;
            // selectedStatuses ว่าง หรือติ๊กครบทุก status = ไม่ได้กรอง (เหมือน DataTables regex ว่าง = แสดงทุกแถว)
            var statusFiltering = selectedStatuses.length > 0 && selectedStatuses.length < totalStatusCount;
            var filtering = !!keyword || selectedGroup !== 'ALL' || statusFiltering;

            if (!filtering) {
                // ไม่มีตัวกรองเลย - คืนสถานะขยาย/ยุบเดิมของแต่ละกลุ่ม
                $('#equipmentBalanceTable .equ-total').removeClass('d-none').each(function () {
                    var group = $(this).data('group');
                    var collapsed = $(this).hasClass('collapsed');
                    $('#equipmentBalanceTable .equ-detail[data-group="' + group + '"]').toggleClass('d-none', collapsed);
                });
                return;
            }

            // ระหว่างกรอง: ซ่อนแถวที่ไม่ตรงเงื่อนไข (กลุ่ม + คำค้นหา + status) แล้วกางทุกกลุ่มที่ยังเหลือแถวให้เห็นเลย
            // (ไม่สนสถานะ collapsed เดิมของกลุ่มนั้น)
            $('#equipmentBalanceTable .equ-detail').each(function () {
                var $row = $(this);
                var matchesGroup = selectedGroup === 'ALL' || $row.data('group') === selectedGroup;
                var matchesKeyword = !keyword || $row.text().toLowerCase().indexOf(keyword) !== -1;
                var matchesStatus = selectedStatuses.length === 0 || selectedStatuses.indexOf(String($row.data('status'))) !== -1;
                $row.toggleClass('d-none', !(matchesGroup && matchesKeyword && matchesStatus));
            });
            $('#equipmentBalanceTable .equ-total').each(function () {
                var group = $(this).data('group');
                var matchesGroup = selectedGroup === 'ALL' || group === selectedGroup;
                var visible = matchesGroup
                        && $('#equipmentBalanceTable .equ-detail[data-group="' + group + '"]').not('.d-none').length > 0;
                $(this).toggleClass('d-none', !visible);
            });
        }

        $('#equipmentSearch').on('keyup', applyEquipmentFilters);

        $('.equ-group-filter').on('click', function () {
            var group = $(this).data('group');
            selectedGroup = (selectedGroup === group) ? 'ALL' : group; // กดซ้ำ = ยกเลิก filter
            $('.equ-group-filter').removeClass('active');
            $('.equ-group-filter[data-group="' + selectedGroup + '"]').addClass('active');
            applyEquipmentFilters();
        });

        // ---- เรียกครั้งแรกตอนโหลดหน้า ให้ default filter status (A+B) มีผลทันที ----
        applyEquipmentFilters();
    });
</script>
