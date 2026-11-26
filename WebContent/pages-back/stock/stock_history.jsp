<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%--
  Stock - Consumables : Stock History (ประวัติรับเข้า/เบิกออกของสินค้า 1 ตัว)
  ข้อมูลมาจาก ProductAction.showStockHistoryPage() ทั้งหมด (รองรับทั้ง Consumables/Accessories/Assets และ Equipment):
    - product        : Product (ชื่อ/รหัสสินค้าที่กำลังดู)
    - isEquipmentHistory : true = Equipment (historiesIn มี name, amount, unit, user, date, refNo, productTypeLabel, equipmentType, items[])
    - historiesIn    : List<Map> {amount, unit, user, warehouse, date, doc_no, details:[{size, amount}]}
    - historiesOut   : ยังไม่มีแหล่งข้อมูลฝั่งเบิกออก - action ส่ง list ว่างมาก่อน (ดู TODO ในแท็บ OUT)
  แยกออกมาจากหน้า Stock Balance (stock_balance.jsp) ตามที่ทีมขอให้เป็นปุ่มและหน้าของตัวเอง
--%>

<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
    <c:set var="isEquipment" value="${isEquipmentHistory}" />
    <%-- Equipment ใช้หน้า stock_equ_* คนละชุดกับ Consumables (ดู stock_item_edit_fragment.jsp) --%>
    <c:set var="urlPrefix" value="${isEquipment ? 'stock_equ' : 'product'}" />
    <c:set var="balanceUrl" value="${isEquipment ? 'stock_equ_balance' : 'stock_balance'}" />
    <div class="d-flex flex-column flex-column-fluid">
        <div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
            <div id="kt_app_toolbar_container" class="app-container container-fluid d-flex flex-stack">
                <div class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
                    <h1 class="page-heading d-flex text-gray-700 fw-semibold my-0">Stock - History</h1>
                    <ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
                        <li class="breadcrumb-item text-muted"><a href="${pageContext.request.contextPath}/check_in_out" class="text-muted text-hover-primary fw-medium fs-7">Home</a></li>
                        <li class="breadcrumb-item"><span class="bullet bg-gray-500 fw-medium fs-7 w-5px h-2px"></span></li>
                        <li class="breadcrumb-item text-muted fw-medium fs-7">Product</li>
                    </ul>
                </div>

                <div class="d-flex align-items-center flex-wrap gap-3">
                    <a href="${urlPrefix}_edit?productId=${product.productId}" class="btn btn-light d-inline-flex align-items-center px-5 py-3">
                        <i class="ki-duotone ki-setting-2 fs-3 me-2 text-gray-500"><span class="path1"></span><span class="path2"></span></i>
                        <span class="fw-semibold text-gray-700">Product</span>
                    </a>
                    <a href="${balanceUrl}?productId=${product.productId}" class="btn btn-light d-inline-flex align-items-center px-5 py-3">
                        <i class="ki-duotone ki-cube-2 fs-3 me-2 text-gray-500"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i>
                        <span class="fw-semibold text-gray-700">Stock Balance</span>
                    </a>
                    <a href="stock_history?productId=${product.productId}" class="btn btn-light-primary d-inline-flex align-items-center px-5 py-3 active">
                        <i class="ki-duotone ki-time fs-3 me-2"><span class="path1"></span><span class="path2"></span></i>
                        <span class="fw-semibold">History Stock</span>
                    </a>
                </div>
            </div>
        </div>

        <div id="kt_app_content" class="app-content flex-column-fluid">
            <div id="kt_app_content_container" class="app-container container-fluid">

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
                                <%-- TODO: ผูก date range picker ของโปรเจกต์ (flatpickr/daterangepicker) ตอนต่อ backend --%>
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
                                <%-- Equipment: บล็อกละ 1 ชุดเครื่องที่เพิ่มพร้อมกัน (ชื่อ + จำนวน / ผู้บันทึก / เวลา / เลขอ้างอิง / ประเภท / Item No.) --%>
                                <c:if test="${isEquipmentHistory}">
                                    <c:forEach var="h" items="${historiesIn}">
                                        <div class="border-bottom pb-6 mb-6">
                                            <div class="d-flex align-items-center justify-content-between flex-wrap gap-3 mb-4">
                                                <div class="d-flex align-items-center flex-wrap gap-3">
                                                    <span class="badge badge-light-success fw-bold d-inline-flex align-items-center">
                                                        IN <i class="ki-duotone ki-entrance-right fs-5 ms-1"><span class="path1"></span><span class="path2"></span></i>
                                                    </span>
                                                    <span class="border rounded d-inline-flex align-items-center flex-wrap gap-4 px-5 py-3">
                                                        <span class="fw-bold fs-4 text-gray-900">${fn:escapeXml(h.name)}</span>
                                                        <span class="fs-6 text-gray-600">${fn:escapeXml(h.amount)} ${fn:escapeXml(h.unit)}</span>
                                                    </span>
                                                </div>
                                                <div class="d-flex align-items-center gap-6 flex-wrap text-gray-600 fs-7">
                                                    <c:if test="${not empty h.user}">
                                                        <span class="d-inline-flex align-items-center"><i class="ki-duotone ki-user fs-5 me-2 text-gray-500"><span class="path1"></span><span class="path2"></span></i>${fn:escapeXml(h.user)}</span>
                                                    </c:if>
                                                    <span class="d-inline-flex align-items-center"><i class="ki-duotone ki-calendar fs-5 me-2 text-gray-500"><span class="path1"></span><span class="path2"></span></i>${fn:escapeXml(h.date)}</span>
                                                    <%-- เลขอ้างอิง: ตอนนี้ยังว่าง (ซ่อน) เมื่อมีใบรับเข้าของ Equipment จะขึ้นเอง --%>
                                                    <c:if test="${not empty h.refNo}">
                                                        <span class="d-inline-flex align-items-center"><i class="ki-duotone ki-document fs-5 me-2 text-gray-500"><span class="path1"></span><span class="path2"></span></i><span class="badge badge-light-primary fw-bold">${fn:escapeXml(h.refNo)}</span></span>
                                                    </c:if>
                                                </div>
                                            </div>
                                            <div class="d-flex align-items-center flex-wrap gap-3 text-gray-700 fs-7 mb-4">
                                                <span class="d-inline-flex align-items-center"><i class="ki-duotone ki-devices fs-3 me-2 text-primary"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i>${fn:escapeXml(h.productTypeLabel)}</span>
                                                <c:if test="${not empty h.equipmentType}">
                                                    <span class="bullet bullet-dot bg-gray-400"></span>
                                                    <span class="d-inline-flex align-items-center"><i class="ki-duotone ki-laptop fs-3 me-2 text-gray-600"><span class="path1"></span><span class="path2"></span></i>${fn:escapeXml(h.equipmentType)}</span>
                                                </c:if>
                                            </div>
                                            <c:if test="${not empty h.items}">
                                                <div class="d-flex flex-wrap gap-3">
                                                    <c:forEach var="it" items="${h.items}">
                                                        <span class="badge badge-light-primary fw-bold fs-7 py-2 px-3">${fn:escapeXml(it)}</span>
                                                    </c:forEach>
                                                </div>
                                            </c:if>
                                        </div>
                                    </c:forEach>
                                </c:if>

                                <%-- Consumables / Accessories / Assets: บล็อกเดิมต่อ 1 ครั้งที่ Add Stock --%>
                                <c:if test="${not isEquipmentHistory}">
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
                                </c:if>
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

<script>
    $(document).ready(function () {

        // ---- สลับ IN / OUT ----
        $('.history-tab').on('click', function () {
            var dir = $(this).data('dir');
            $('.history-tab').removeClass('active');
            $(this).addClass('active');
            $('.history-pane').addClass('d-none');
            $(dir === 'IN' ? '#historyIn' : '#historyOut').removeClass('d-none');
        });

        // TODO: init date range picker ของโปรเจกต์กับ #historyDateRange ตอนต่อ backend
    });
</script>
