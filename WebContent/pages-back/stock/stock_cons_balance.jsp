<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%--
  Stock - Consumables : Stock Balance
  ข้อมูลมาจาก ProductAction.showStockBalancePage() ทั้งหมด (Equipment จะถูก reject ตั้งแต่ action):
    - product        : Product (ชื่อ/รหัสสินค้าที่กำลังดู)
    - subProducts    : List<Product> เรียงตาม sequence
    - warehouses     : List<Warehouse> ใช้เติม dropdown ใน modal Add Stock
    - units          : List<UnitOfMeasure> เรียงตาม sequence (ตัวแรก = unit หลัก)
    - sizeSummaries  : List<Map> {key, label, amount}  -> ปุ่มกรองไซซ์ + ยอดรวม (ตัวแรก key="ALL")
    - balances       : List<Map> {key, label, total, rows:[{warehouse, amount}]}  -> ตารางยอดคงเหลือ group ตามไซซ์
    - historiesIn    : List<Map> {amount, unit, user, warehouse, date, doc_no, details:[{size, amount}]}
    - historiesOut   : ยังไม่มีแหล่งข้อมูลฝั่งเบิกออก - action ส่ง list ว่างมาก่อน (ดู TODO ในแท็บ OUT)
--%>

<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
    <div class="d-flex flex-column flex-column-fluid">
        <div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
            <div id="kt_app_toolbar_container" class="app-container container-fluid d-flex flex-stack">
                <div class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
                    <h1 class="page-heading d-flex text-gray-700 fw-semibold my-0">Stock - Consumables</h1>
                    <ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
                        <li class="breadcrumb-item text-muted"><a href="${pageContext.request.contextPath}/check_in_out" class="text-muted text-hover-primary fw-medium fs-7">Home</a></li>
                        <li class="breadcrumb-item"><span class="bullet bg-gray-500 fw-medium fs-7 w-5px h-2px"></span></li>
                        <li class="breadcrumb-item text-muted fw-medium fs-7">Product</li>
                    </ul>
                </div>

                <div class="d-flex align-items-center gap-3">
                    <a href="stock_cons_edit?productId=${product.productId}" class="btn btn-light d-inline-flex align-items-center px-5 py-3">
                        <i class="ki-duotone ki-setting-2 fs-3 me-2 text-gray-500"><span class="path1"></span><span class="path2"></span></i>
                        <span class="fw-semibold text-gray-700">Product</span>
                    </a>
                    <a href="stock_cons_balance?productId=${product.productId}" class="btn btn-light-primary d-inline-flex align-items-center px-5 py-3 active">
                        <i class="ki-duotone ki-cube-2 fs-3 me-2"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i>
                        <span class="fw-semibold">Stock Balance</span>
                    </a>
                </div>
            </div>
        </div>

        <div id="kt_app_content" class="app-content flex-column-fluid">
            <div id="kt_app_content_container" class="app-container container-fluid">

                <%-- ============ Stock Balance ============ --%>
                <div class="card mb-8">
                    <div class="card-border-radius">
                        <div class="card-header border-0 pt-6 d-flex align-items-center justify-content-between flex-wrap gap-3">
                            <h3 class="page-heading text-gray-900 fw-bold mb-0">Stock Balance</h3>
                            <div class="d-flex align-items-center flex-wrap gap-3">
                                <%-- TODO: ผูก date range picker ของโปรเจกต์ (flatpickr/daterangepicker) ตอนต่อ backend --%>
                                <div class="position-relative">
                                    <input type="text" id="balanceDateRange" readonly
                                           class="form-control form-control-solid ps-4 pe-12 text-gray-700"
                                           style="min-width: 260px;"
                                           value="1 Jan 2026 - 31 Dec 2026" />
                                    <i class="ki-duotone ki-calendar-8 fs-2 position-absolute end-0 top-50 translate-middle-y me-4 text-gray-500">
                                        <span class="path1"></span><span class="path2"></span><span class="path3"></span>
                                        <span class="path4"></span><span class="path5"></span><span class="path6"></span>
                                    </i>
                                </div>
                                <button type="button" class="btn btn-success d-inline-flex align-items-center px-6 py-3"
                                        data-bs-toggle="modal" data-bs-target="#addStockModal">
                                    <i class="ki-duotone ki-plus fs-3 me-2"><span class="path1"></span><span class="path2"></span></i>
                                    <span class="fw-bold">Add Stock</span>
                                </button>
                            </div>
                        </div>

                        <div class="card-body">
                            <%-- ---- ปุ่มกรองไซซ์ + ยอดรวม ---- --%>
                            <div class="d-flex flex-wrap justify-content-center gap-6 gap-lg-10 mb-8">
                                <c:forEach var="s" items="${sizeSummaries}" varStatus="ss">
                                    <div class="text-center">
                                        <button type="button"
                                                class="btn ${ss.first ? 'btn-light-success' : 'btn-light-primary'} fw-bold fs-5 px-6 py-3 size-filter${ss.first ? ' active' : ''}"
                                                data-size="${fn:escapeXml(s.key)}">${fn:escapeXml(s.label)}</button>
                                        <div class="fw-bold fs-4 text-gray-900 mt-3">${fn:escapeXml(s.amount)}</div>
                                    </div>
                                </c:forEach>
                            </div>

                            <%-- ---- ตารางยอดคงเหลือ (group ตามไซซ์ กดขยายดูแยกคลัง) ---- --%>
                            <div class="table-responsive">
                                <table class="table align-middle fs-6 mb-0" id="balanceTable">
                                    <thead class="fs-7 text-gray-500 text-uppercase">
                                        <tr class="fw-semibold">
                                            <th class="min-w-150px text-nowrap text-center">Sub Product</th>
                                            <th class="min-w-250px text-nowrap">Warehouse</th>
                                            <th class="min-w-120px text-nowrap text-end">Amount</th>
                                            <th class="w-60px"></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="g" items="${balances}" varStatus="gs">
                                            <%-- หัวกลุ่มไซซ์ (กดขยาย/ยุบดูแยกคลัง) กลุ่มแรกเปิดไว้ ที่เหลือยุบ --%>
                                            <tr class="balance-total bg-light-primary${gs.first ? '' : ' collapsed'}" data-group="${fn:escapeXml(g.key)}">
                                                <td class="text-gray-900 fw-bold text-center">${fn:escapeXml(g.label)}</td>
                                                <td class="text-gray-900 fw-bold">Total</td>
                                                <td class="text-gray-900 fw-bold text-end">${fn:escapeXml(g.total)}</td>
                                                <td class="text-end">
                                                    <button type="button" class="btn btn-icon btn-sm btn-active-light-primary balance-toggle" data-group="${fn:escapeXml(g.key)}">
                                                        <i class="ki-duotone ${gs.first ? 'ki-up' : 'ki-down'} fs-3"><span class="path1"></span><span class="path2"></span></i>
                                                    </button>
                                                </td>
                                            </tr>
                                            <c:forEach var="r" items="${g.rows}">
                                                <tr class="balance-detail${gs.first ? '' : ' d-none'}" data-group="${fn:escapeXml(g.key)}">
                                                    <td class="text-gray-700 text-center">${fn:escapeXml(g.label)}</td>
                                                    <td class="text-gray-700">${fn:escapeXml(r.warehouse)}</td>
                                                    <td class="text-gray-700 text-end">${fn:escapeXml(r.amount)}</td>
                                                    <td></td>
                                                </tr>
                                            </c:forEach>
                                        </c:forEach>
                                        <c:if test="${empty balances}">
                                            <tr><td colspan="4" class="text-center text-muted py-10">ไม่มีข้อมูลยอดคงเหลือ</td></tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>

                            <%-- footer: length + pagination (static ตาม mockup, รอ backend ทำ paging จริง) --%>
                            <div class="row align-items-center mt-6">
                                <div class="col-sm-auto mb-2 mb-sm-0">
                                    <select class="form-select form-select-sm w-100px" disabled>
                                        <option>100</option>
                                    </select>
                                </div>
                                <div class="col-sm d-flex justify-content-sm-end">
                                    <ul class="pagination mb-0">
                                        <li class="page-item previous disabled"><a href="#" class="page-link"><i class="ki-duotone ki-left fs-4"></i></a></li>
                                        <li class="page-item active"><a href="#" class="page-link">1</a></li>
                                        <li class="page-item"><a href="#" class="page-link">2</a></li>
                                        <li class="page-item"><a href="#" class="page-link">3</a></li>
                                        <li class="page-item"><a href="#" class="page-link">...</a></li>
                                        <li class="page-item"><a href="#" class="page-link">5</a></li>
                                        <li class="page-item"><a href="#" class="page-link">6</a></li>
                                        <li class="page-item next"><a href="#" class="page-link"><i class="ki-duotone ki-right fs-4"></i></a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <%-- ============ History Stock ============ --%>
                <div class="card">
                    <div class="card-border-radius">
                        <div class="card-header border-0 pt-6 d-flex align-items-center justify-content-between flex-wrap gap-3">
                            <h3 class="page-heading text-gray-900 fw-bold mb-0 text-uppercase">History Stock</h3>
                            <div class="btn-group" role="group" aria-label="History direction">
                                <button type="button" class="btn btn-sm btn-active-light-primary active d-inline-flex align-items-center history-tab" data-dir="IN">
                                    <span class="fw-semibold me-2">IN</span>
                                    <i class="ki-duotone ki-entrance-right fs-4 text-success"><span class="path1"></span><span class="path2"></span></i>
                                </button>
                                <button type="button" class="btn btn-sm btn-active-light-primary d-inline-flex align-items-center history-tab" data-dir="OUT">
                                    <span class="fw-semibold me-2">OUT</span>
                                    <i class="ki-duotone ki-entrance-left fs-4 text-gray-500"><span class="path1"></span><span class="path2"></span></i>
                                </button>
                            </div>
                        </div>

                        <div class="card-body">
                            <div class="d-flex justify-content-end mb-6">
                                <div class="position-relative">
                                    <input type="text" id="historyDateRange" readonly
                                           class="form-control form-control-solid ps-4 pe-12 text-gray-700"
                                           style="min-width: 260px;"
                                           value="1 Jan 2026 - 31 Dec 2026" />
                                    <i class="ki-duotone ki-calendar-8 fs-2 position-absolute end-0 top-50 translate-middle-y me-4 text-gray-500">
                                        <span class="path1"></span><span class="path2"></span><span class="path3"></span>
                                        <span class="path4"></span><span class="path5"></span><span class="path6"></span>
                                    </i>
                                </div>
                            </div>

                            <%-- ---- IN ---- --%>
                            <div id="historyIn" class="history-pane">
                                <c:forEach var="h" items="${historiesIn}">
                                    <div class="border-bottom pb-6 mb-6">
                                        <div class="d-flex align-items-center justify-content-between flex-wrap gap-3 mb-4">
                                            <div class="d-flex align-items-center gap-3">
                                                <span class="badge badge-light-success fw-bold d-inline-flex align-items-center">
                                                    IN <i class="ki-duotone ki-entrance-right fs-5 ms-1"><span class="path1"></span><span class="path2"></span></i>
                                                </span>
                                                <span class="fw-bold fs-3 text-gray-900">${fn:escapeXml(h.amount)} <span class="fs-6 fw-normal text-gray-600">${fn:escapeXml(h.unit)}</span></span>
                                            </div>
                                            <div class="d-flex align-items-center gap-6 flex-wrap text-gray-600 fs-7">
                                                <c:if test="${not empty h.user}">
                                                    <span class="d-inline-flex align-items-center"><i class="ki-duotone ki-user fs-5 me-2 text-gray-500"><span class="path1"></span><span class="path2"></span></i>${fn:escapeXml(h.user)}</span>
                                                </c:if>
                                                <c:if test="${not empty h.warehouse}">
                                                    <span class="d-inline-flex align-items-center"><i class="ki-duotone ki-home-2 fs-5 me-2 text-gray-500"><span class="path1"></span><span class="path2"></span></i>${fn:escapeXml(h.warehouse)}</span>
                                                </c:if>
                                                <span class="d-inline-flex align-items-center"><i class="ki-duotone ki-calendar fs-5 me-2 text-gray-500"><span class="path1"></span><span class="path2"></span></i>${fn:escapeXml(h.date)}</span>
                                                <c:if test="${not empty h.doc_no}">
                                                    <span class="d-inline-flex align-items-center"><i class="ki-duotone ki-document fs-5 me-2 text-gray-500"><span class="path1"></span><span class="path2"></span></i><span class="badge badge-light-primary fw-bold">${fn:escapeXml(h.doc_no)}</span></span>
                                                </c:if>
                                            </div>
                                        </div>
                                        <c:if test="${not empty h.details}">
                                            <div class="d-flex flex-wrap gap-3">
                                                <c:forEach var="d" items="${h.details}">
                                                    <span class="badge badge-light border fs-7 py-2 px-3"><span class="fw-bold text-gray-900 me-2">${fn:escapeXml(d.size)}</span><span class="text-gray-600">${fn:escapeXml(d.amount)}</span></span>
                                                </c:forEach>
                                            </div>
                                        </c:if>
                                    </div>
                                </c:forEach>
                                <c:if test="${empty historiesIn}">
                                    <div class="text-center text-muted py-10">ยังไม่มีรายการรับเข้า</div>
                                </c:if>
                            </div>

                            <%-- ---- OUT (ซ่อนไว้ก่อน สลับด้วยปุ่ม IN/OUT) ---- --%>
                            <div id="historyOut" class="history-pane d-none">
                                <%-- TODO: <c:forEach var="h" items="${historiesOut}"> --%>
                                <div class="text-center text-muted py-10">ยังไม่มีรายการเบิกออก</div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>

<%-- ============ Modal: Add Stock (รับเข้าสต็อก / IN) ============ --%>
<div class="modal fade" id="addStockModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered mw-650px">
        <div class="modal-content">
            <form id="addStockForm" method="POST" action="stock_cons_stock_add" class="form">
                <input type="hidden" name="productId" value="${product.productId}" />

                <div class="modal-header">
                    <h3 class="modal-title fw-bold text-gray-900">Add Stock</h3>
                    <button type="button" class="btn btn-icon btn-sm btn-active-light-primary" data-bs-dismiss="modal" aria-label="Close">
                        <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                    </button>
                </div>

                <div class="modal-body">
                    <div class="row g-5 mb-2">
                        <div class="col-12 col-md-6">
                            <label class="form-label fw-semibold text-gray-700" for="addStockWarehouse">
                                Warehouse <span class="text-danger">*</span>
                            </label>
                            <%-- options เติมด้วย JS ให้เรียงแบบ tree (DFS + indent ตามลำดับชั้น) ดู fillWarehouseTree() --%>
                            <select id="addStockWarehouse" name="warehouseId" required class="form-select text-gray-700">
                                <option value="">- เลือกคลัง -</option>
                            </select>
                        </div>
                        <div class="col-12 col-md-6">
                            <label class="form-label fw-semibold text-gray-700" for="addStockRef">Reference No.</label>
                            <input type="text" id="addStockRef" name="refNo" maxlength="100"
                                   class="form-control text-gray-700" placeholder="เช่น QR001" />
                        </div>
                        <div class="col-12 col-md-6">
                            <label class="form-label fw-semibold text-gray-700" for="addStockDate">Date</label>
                            <input type="text" id="addStockDate" name="receiveDate"
                                   class="form-control text-gray-700" placeholder="Select date" />
                        </div>
                        <div class="col-12 col-md-6">
                            <label class="form-label fw-semibold text-gray-700" for="addStockUnit">
                                Unit <span class="text-danger">*</span>
                            </label>
                            <%-- ตัวเลือก unit ดึงจาก DB ตาม product (attribute units) เรียงตาม sequence (ตัวแรก = unit หลัก) --%>
                            <select id="addStockUnit" name="unitId" required class="form-select text-gray-700">
                                <option value="">- เลือกหน่วยนับ -</option>
                                <c:forEach var="u" items="${units}" varStatus="us">
                                    <option value="${u.unitId}" ${us.first ? 'selected' : ''}>${fn:escapeXml(u.unitName)}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="separator my-6"></div>

                    <label class="form-label fw-semibold text-gray-700 mb-4">จำนวนรับเข้า (แยกตาม Sub product)</label>
                    <c:choose>
                        <c:when test="${not empty subProducts}">
                            <div class="row g-4">
                                <c:forEach var="sub" items="${subProducts}">
                                    <div class="col-12 col-md-6">
                                        <div class="input-group">
                                            <span class="input-group-text fw-semibold text-gray-700" style="min-width: 80px;">
                                                ${fn:escapeXml(sub.productName)}
                                            </span>
                                            <%-- name = amount_<subProductId> ให้ backend map เข้ากับ sub product ได้ --%>
                                            <input type="number" min="0" step="1" value="0"
                                                   name="amount_${sub.productId}"
                                                   class="form-control text-gray-700" />
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <%-- ไม่มี sub product - รับเข้าเป็นบรรทัดเดียวผูกกับตัวแม่โดยตรง (ดู stockConsStockAdd) --%>
                            <div class="row g-4">
                                <div class="col-12 col-md-6">
                                    <div class="input-group">
                                        <span class="input-group-text fw-semibold text-gray-700" style="min-width: 80px;">
                                            ${fn:escapeXml(product.productName)}
                                        </span>
                                        <input type="number" min="0" step="1" value="0"
                                               name="amount_${product.productId}"
                                               class="form-control text-gray-700" />
                                    </div>
                                </div>
                            </div>
                            <div class="text-muted fs-7 mt-2">ยังไม่มี sub product - เพิ่มได้ที่หน้า Settings</div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-success">Save</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {

        // กันกด Save ซ้ำระหว่างรอ response
        $('#addStockForm').on('submit', function () {
            $(this).find('button[type="submit"]')
                   .prop('disabled', true)
                   .attr('data-kt-indicator', 'on');
        });

        // ---- datepicker ของ addStockDate ใช้แพทเทิร์นเดียวกับหน้าอื่นในโปรเจกต์ (เช่น equipment_add.jsp) ----
        // dateFormat = ค่าที่ submit จริง, altFormat = ค่าที่โชว์ให้ผู้ใช้เห็น (1 Jan 2026)
        if (typeof flatpickr !== 'undefined') {
            $('#addStockDate').flatpickr({
                dateFormat: 'Y-m-d',
                altInput: true,
                altFormat: 'j M Y'
            });
        }

        // ---- เติม dropdown Warehouse แบบ tree (อ้างอิงโครงสร้างจากหน้า warehouse_list) ----
        var warehouseData = [
            <c:forEach items="${warehouses}" var="wh" varStatus="s">
            { id: ${wh.warehouseId}, parentId: ${empty wh.parent ? 0 : wh.parent}, name: "${fn:escapeXml(wh.warehouseName)}" }<c:if test="${!s.last}">,</c:if>
            </c:forEach>
        ];

        (function fillWarehouseTree() {
            var $sel = $('#addStockWarehouse');
            if (!$sel.length || !warehouseData.length) { return; }

            // สร้าง map + tree (parentId = 0 หรือหา parent ไม่เจอ = root)
            var map = {}, roots = [];
            warehouseData.forEach(function (w) { map[w.id] = { id: w.id, parentId: w.parentId, name: w.name, children: [] }; });
            warehouseData.forEach(function (w) {
                if (w.parentId === 0 || !map[w.parentId]) { roots.push(map[w.id]); }
                else { map[w.parentId].children.push(map[w.id]); }
            });

            // เดินแบบ DFS แล้ว indent ตามระดับชั้น (option ใน select ทำ expand ไม่ได้ ใช้เยื้องแทน)
            function walk(nodes, level) {
                nodes.forEach(function (n) {
                    var indent = new Array(level + 1).join('    ');
                    var prefix = level > 0 ? (indent + '└ ') : ''; // └
                    $sel.append($('<option>', { value: n.id, text: prefix + n.name }));
                    if (n.children.length) { walk(n.children, level + 1); }
                });
            }
            walk(roots, 0);
        })();

        // ---- กรองตารางยอดคงเหลือตามไซซ์ ----
        $('.size-filter').on('click', function () {
            var size = $(this).data('size');
            $('.size-filter').removeClass('active');
            $(this).addClass('active');

            if (size === 'ALL') {
                // แสดงทุกกลุ่ม แต่คง state ขยาย/ยุบเดิมของแต่ละกลุ่มไว้
                $('#balanceTable .balance-total').removeClass('d-none');
                $('#balanceTable .balance-total').each(function () {
                    var g = $(this).data('group');
                    var collapsed = $(this).hasClass('collapsed');
                    $('#balanceTable .balance-detail[data-group="' + g + '"]').toggleClass('d-none', collapsed);
                });
            } else {
                $('#balanceTable .balance-total').addClass('d-none');
                $('#balanceTable .balance-detail').addClass('d-none');
                $('#balanceTable .balance-total[data-group="' + size + '"]').removeClass('d-none');
                // เปิดรายละเอียดของไซซ์ที่เลือกให้เห็นเลย
                var $total = $('#balanceTable .balance-total[data-group="' + size + '"]');
                $total.removeClass('collapsed');
                setToggleIcon($total, true);
                $('#balanceTable .balance-detail[data-group="' + size + '"]').removeClass('d-none');
            }
        });

        // ---- ขยาย/ยุบ รายละเอียดคลังของแต่ละไซซ์ ----
        $('#balanceTable').on('click', '.balance-toggle', function () {
            var group = $(this).data('group');
            var $total = $('#balanceTable .balance-total[data-group="' + group + '"]');
            var willOpen = $total.hasClass('collapsed');

            $total.toggleClass('collapsed', !willOpen);
            $('#balanceTable .balance-detail[data-group="' + group + '"]').toggleClass('d-none', !willOpen);
            setToggleIcon($total, willOpen);
        });

        function setToggleIcon($totalRow, isOpen) {
            var $icon = $totalRow.find('.balance-toggle .ki-duotone');
            $icon.removeClass('ki-up ki-down').addClass(isOpen ? 'ki-up' : 'ki-down');
        }

        // ---- สลับ IN / OUT ----
        $('.history-tab').on('click', function () {
            var dir = $(this).data('dir');
            $('.history-tab').removeClass('active');
            $(this).addClass('active');
            $('.history-pane').addClass('d-none');
            $(dir === 'IN' ? '#historyIn' : '#historyOut').removeClass('d-none');
        });

        // TODO: init date range picker ของโปรเจกต์กับ #balanceDateRange / #historyDateRange ตอนต่อ backend
    });
</script>
