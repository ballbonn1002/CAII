<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%--
  Stock - Equipment : Stock Balance

  ต่างจาก stock_balance.jsp ตรงที่ยอดคงเหลือของ Equipment คือ "จำนวนเครื่องจริง"
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
                        <li class="breadcrumb-item text-muted fw-medium fs-7"><a href="${pageContext.request.contextPath}/product_list" class="text-muted text-hover-primary">Product</a></li>
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
                                                    <button type="button" class="btn btn-icon btn-sm btn-active-light-success sub-equ-add ms-1"
                                                            data-target-id="${g.productId}" data-target-name="${fn:escapeXml(g.label)}"
                                                            data-bs-toggle="modal" data-bs-target="#equipmentPickerModal" title="Link Equipment">
                                                        <i class="ki-duotone ki-plus fs-3"><span class="path1"></span><span class="path2"></span></i>
                                                    </button>
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
                                                <tr class="equ-detail${gs.first ? '' : ' d-none'}${e.retired ? ' opacity-50' : ''}" data-group="${g.productId}" data-status="${fn:escapeXml(e.status)}"
                                                    data-equipment-id="${e.equipmentId}" data-warehouse-id="${e.warehouseId}"
                                                    data-location="${fn:escapeXml(e.location)}">
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
                                                    <%-- Status: server ใส่รหัสย่อไว้เป็น fallback ก่อน - JS (renderEquipmentRows) แทนด้วย description เต็ม
                                                         + สี badge-<color2> จาก equipmentStatusList  (data-status ของ tr ยังเป็นรหัสย่อเหมือนเดิมให้ filter ใช้) --%>
                                                    <td class="text-center">
                                                        <span class="badge fw-semibold badge-secondary equ-status-badge">
                                                            <c:choose>
                                                                <c:when test="${not empty e.status}">${fn:escapeXml(e.status)}</c:when>
                                                                <c:otherwise>-</c:otherwise>
                                                            </c:choose>
                                                        </span>
                                                    </td>
                                                    <%-- ที่ตั้ง: status A -> warehouse (แก้ไขได้) / status B -> ชื่อผู้ยืม + ปุ่มดูข้อมูลการยืม (JS เติมให้)
                                                         status อื่นคงค่า location เดิมไว้ตามที่ server แสดง --%>
                                                    <td class="text-gray-700 equ-location-cell">
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
                    <a href="product_list" class="btn btn-light d-inline-flex align-items-center px-6 py-3">
                        <i class="ki-duotone ki-arrow-left fs-3 me-2"><span class="path1"></span><span class="path2"></span></i>
                        <span class="fw-bold text-gray-700">Back</span>
                    </a>
                </div>

            </div>
        </div>
    </div>
</div>

<%-- ============ Modal: Link Equipment (เลือกเครื่องที่ยังไม่ผูก catalog ไหนเลย) ============
     ก็อปมาจาก stock_item_edit_fragment.jsp (modal #equipmentPickerModal) - ใช้ endpoint stock_equ_link_save เดิม
     ไม่มี unlink ที่หน้านี้ (มีแค่ list ไม่มีฟอร์มแก้ไข) --%>
<div class="modal fade" id="equipmentPickerModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title fw-bold text-gray-900" id="equipmentPickerModalTitle">เลือกเครื่องเพื่อเพิ่มเข้า Item นี้</h3>
                <button type="button" class="btn btn-icon btn-sm btn-active-light-primary" data-bs-dismiss="modal" aria-label="Close">
                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                </button>
            </div>

            <div class="modal-body">
                <div class="d-flex align-items-center position-relative mb-6">
                    <i class="ki-duotone ki-magnifier fs-3 position-absolute ms-5"><span class="path1"></span><span class="path2"></span></i>
                    <input type="text" id="equipmentPickerSearch" class="form-control form-control-solid ps-14 text-gray-700"
                           placeholder="ค้นหา Item ID / ชื่อเครื่อง / Serial No" />
                </div>

                <table id="equipmentPickerTable" class="table align-middle fs-6 mb-0">
                    <thead class="fs-7 text-gray-500 text-uppercase">
                        <tr class="fw-semibold">
                            <th class="w-40px"></th>
                            <th class="min-w-150px text-nowrap">Item ID</th>
                            <th class="min-w-250px text-nowrap">ชื่อเครื่อง</th>
                            <th class="min-w-180px text-nowrap">Serial No</th>
                            <th class="min-w-120px text-nowrap text-center">Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="equip" items="${unlinkedEquipment}">
                            <tr>
                                <td class="text-center">
                                    <div class="form-check form-check-custom form-check-solid d-inline-flex">
                                        <input class="form-check-input equipment-pick-checkbox" type="checkbox" value="${equip.equipmentId}" />
                                    </div>
                                </td>
                                <td class="text-gray-900 fw-bold">
                                    <c:choose>
                                        <c:when test="${not empty fn:trim(equip.itemNo)}">${fn:escapeXml(equip.itemNo)}</c:when>
                                        <c:otherwise><span class="text-muted">#${equip.equipmentId}</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-gray-700 fw-normal">
                                    <c:choose>
                                        <c:when test="${not empty fn:trim(equip.name)}">${fn:escapeXml(equip.name)}</c:when>
                                        <c:otherwise><span class="text-muted">(ไม่ระบุชื่อ)</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-gray-700 fw-normal">
                                    <c:choose>
                                        <c:when test="${not empty equip.serialNo}">${fn:escapeXml(equip.serialNo)}</c:when>
                                        <c:otherwise><span class="text-muted">-</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${not empty equip.status}"><span class="badge badge-light-primary fw-semibold">${fn:escapeXml(equip.status)}</span></c:when>
                                        <c:otherwise><span class="text-muted">-</span></c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <%-- ตอนตารางว่าง ปล่อยให้ DataTables โชว์ข้อความเอง (language.emptyTable ด้านล่าง)
                     ไม่ใส่ div ซ้ำตรงนี้ ไม่งั้นจะขึ้นข้อความซ้อนกัน 2 อัน --%>
            </div>

            <div class="modal-footer d-flex justify-content-between align-items-center">
                <span class="text-gray-600 fs-7"><span id="equipmentPickerSelectedCount">0</span> รายการที่เลือก</span>
                <div class="d-flex gap-3">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" id="btnEquipmentPickerSave" class="btn btn-success">Save</button>
                </div>
            </div>
        </div>
    </div>
</div>

<%-- ============ Modal: เลือก Warehouse ของเครื่อง (เฉพาะ status Available) ============
     ตัวเลือก = warehouse ระดับบนสุด (parent = 0) จาก warehouseList + "ไม่ระบุ" - บันทึกแบบ AJAX ไปที่ stock_equ_warehouse_save --%>
<div class="modal fade" id="equipmentWarehouseModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered mw-500px">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title fw-bold text-gray-900" id="equipmentWarehouseModalTitle">เลือก Warehouse</h3>
                <button type="button" class="btn btn-icon btn-sm btn-active-light-primary" data-bs-dismiss="modal" aria-label="Close">
                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                </button>
            </div>
            <div class="modal-body">
                <label class="form-label fw-bold" for="equipmentWarehouseSelect">Warehouse</label>
                <select id="equipmentWarehouseSelect" class="form-select"></select>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                <button type="button" id="btnEquipmentWarehouseSave" class="btn btn-success">Save</button>
            </div>
        </div>
    </div>
</div>

<%-- ============ Modal: ข้อมูลการยืม (ดูอย่างเดียว) - เฉพาะส่วน Borrow ตาม equipment_list.jsp (openViewModal) ============ --%>
<div class="modal fade" id="equipmentBorrowViewModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header border-0 px-6 pt-5 pb-0 align-items-center">
                <h2 class="fw-bold m-0 text-gray-800 ps-4 pt-1">Borrow Detail</h2>
                <div class="btn btn-sm btn-icon btn-active-color-primary" data-bs-dismiss="modal">
                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                </div>
            </div>
            <div class="modal-body px-10 pt-5 pb-10">
                <div class="rounded p-6">
                    <div class="row g-5 mb-5">
                        <div class="col-md-6 d-flex align-items-center gap-3">
                            <span class="fs-5 fw-bold text-primary" id="borrowView_itemNo">-</span>
                            <span class="badge" id="borrowView_statusBadge">-</span>
                        </div>
                        <div class="col-md-6 d-flex align-items-center gap-2">
                            <span class="fs-5 fw-bold text-gray-800" id="borrowView_name">-</span>
                        </div>
                        <div class="col-12 d-flex align-items-start gap-2">
                            <span class="text-gray-700 fw-normal fs-5">Serial No:</span>
                            <span class="text-gray-800 fw-normal fs-5" id="borrowView_serial">-</span>
                        </div>
                    </div>

                    <div class="separator separator-dashed border-gray-300 my-8"></div>

                    <div class="d-flex align-items-center mb-5">
                        <span class="fs-5 fw-bold text-gray-800 me-3">Borrow ID:</span>
                        <span class="fs-5 fw-bold text-primary" id="borrowView_borrowId">-</span>
                    </div>
                    <div class="row g-5">
                        <div class="col-12 d-flex flex-wrap align-items-center">
                            <span class="text-gray-700 fw-normal fs-5 me-2">Borrow by:</span>
                            <span class="fs-5 text-gray-800 fw-medium" id="borrowView_borrower">-</span>
                        </div>
                        <div class="col-12 d-flex align-items-center">
                            <span class="text-gray-700 fw-normal fs-5 me-2">Location:</span>
                            <span class="text-gray-800 fw-normal fs-5" id="borrowView_location">-</span>
                        </div>
                        <div class="col-12 d-flex align-items-center">
                            <span class="text-gray-700 fw-normal fs-5 me-2">Borrow Date:</span>
                            <span class="text-gray-800 fw-normal fs-5" id="borrowView_date">-</span>
                        </div>
                    </div>
                </div>
                <div class="d-flex justify-content-end mt-6">
                    <button type="button" class="btn btn-light fw-bold" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    var CONTEXT = '${pageContext.request.contextPath}';
    function notifyError(msg) {
        if (window.Swal) { Swal.fire('Error', msg || 'เกิดข้อผิดพลาด', 'error'); }
        else { alert(msg || 'เกิดข้อผิดพลาด'); }
    }

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

        // ==================== คอลัมน์ Status (คำเต็ม) + ที่ตั้ง (A = Warehouse, B = ผู้ยืม) ====================
        // ข้อมูลทั้งหมดมาจาก ProductAction.showEquipmentBalancePage() (equipmentStatusList / borrows / userList / warehouseList)
        // ค่าที่ประกอบเป็น HTML ต้องผ่าน escapeHtml() เสมอ
        var borrows = ${borrows != null ? borrows : '[]'};
        var users = ${userList != null ? userList : '[]'};
        var warehouseList = ${warehouseList != null ? warehouseList : '[]'};

        function escapeHtml(s) {
            return String(s == null ? '' : s)
                .replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;')
                .replace(/"/g, '&quot;').replace(/'/g, "&#39;");
        }

        // statusId -> {cls, label} (สี badge = badge-<color2> เหมือน equipment_list.jsp ไม่มีให้ใช้ badge-secondary)
        var statusConfig = {};
        $.each(dbStatusList || [], function (i, st) {
            statusConfig[st.statusId] = {
                cls: st.color2 ? ('badge-' + st.color2) : 'badge-secondary',
                label: st.description || st.statusId
            };
        });

        // user id -> ชื่อที่ใช้โชว์ (name_en > name > id) เหมือน userById ใน equipment_list.jsp
        var userById = {};
        $.each(users || [], function (i, u) {
            var key = String(u.id || '').trim().toLowerCase();
            userById[key] = (u.name_en && String(u.name_en).trim() !== '') ? u.name_en : (u.name || u.id);
        });

        // equipmentId -> borrow ล่าสุด (borrowId มากสุด) เหมือน lastBorrowByEqId ใน equipment_list.jsp
        var lastBorrowByEqId = {};
        $.each(borrows || [], function (i, b) {
            var eqId = String(b.equipmentId);
            if (!lastBorrowByEqId[eqId] || b.borrowId > lastBorrowByEqId[eqId].borrowId) {
                lastBorrowByEqId[eqId] = b;
            }
        });

        var warehouseNameById = {};
        $.each(warehouseList || [], function (i, w) {
            warehouseNameById[String(w.warehouseId)] = w.warehouseName || ('#' + w.warehouseId);
        });

        function formatDateTime(dateStr) {
            if (!dateStr) return '-';
            var d = new Date(dateStr);
            if (isNaN(d.getTime())) return dateStr;
            return d.getDate() + ' ' + d.toLocaleString('en-GB', { month: 'short' }) + ' ' + d.getFullYear()
                + ', ' + ('0' + d.getHours()).slice(-2) + ':' + ('0' + d.getMinutes()).slice(-2);
        }

        function borrowerName(borrow) {
            var raw = String(borrow.userBorrowid || '').trim();
            return userById[raw.toLowerCase()] || raw || '-';
        }

        function renderStatusBadge($row) {
            var status = String($row.attr('data-status') || '').trim();
            if (!status) { return; }
            var cfg = statusConfig[status];
            $row.find('.equ-status-badge')
                .attr('class', 'badge fw-semibold equ-status-badge ' + (cfg ? cfg.cls : 'badge-secondary'))
                .text(cfg ? cfg.label : status);
        }

        function renderLocationCell($row) {
            var status = String($row.attr('data-status') || '').trim();
            var eqId = String($row.attr('data-equipment-id') || '');
            var $cell = $row.find('.equ-location-cell');

            if (status === 'B') {
                var borrow = lastBorrowByEqId[eqId];
                if (!borrow) {
                    $cell.html('<span class="text-muted">-</span>');
                    return;
                }
                $cell.html('<span class="text-gray-900">' + escapeHtml(borrowerName(borrow)) + '</span>'
                    + '<button type="button" class="btn btn-icon btn-sm btn-light-info ms-2 btn-equ-borrow-view"'
                    + ' data-bs-toggle="modal" data-bs-target="#equipmentBorrowViewModal" title="Borrow Detail">'
                    + '<i class="ki-duotone ki-document fs-3"><span class="path1"></span><span class="path2"></span></i></button>');
            } else if (status === 'A') {
                var whId = String($row.attr('data-warehouse-id') || '');
                var whName = whId ? warehouseNameById[whId] : null;
                $cell.html((whName ? '<span class="text-gray-700">' + escapeHtml(whName) + '</span>' : '<span class="text-muted">-</span>')
                    + '<button type="button" class="btn btn-icon btn-sm btn-light-primary ms-2 btn-equ-warehouse"'
                    + ' data-bs-toggle="modal" data-bs-target="#equipmentWarehouseModal"'
                    + ' title="' + (whName ? 'แก้ไข Warehouse' : 'ระบุ Warehouse') + '">'
                    + '<i class="ki-duotone ' + (whName ? 'ki-pencil' : 'ki-plus') + ' fs-3"><span class="path1"></span><span class="path2"></span></i></button>');
            }
            // status อื่น: คงค่า location เดิมที่ server แสดงไว้ (ไม่มีปุ่มแก้ไข)
        }

        function renderEquipmentRows() {
            $('#equipmentBalanceTable .equ-detail[data-equipment-id]').each(function () {
                renderStatusBadge($(this));
                renderLocationCell($(this));
            });
        }

        // ---- modal ข้อมูลการยืม (ดูอย่างเดียว) ----
        $('#equipmentBalanceTable').on('click', '.btn-equ-borrow-view', function () {
            var $row = $(this).closest('tr');
            var eqId = String($row.attr('data-equipment-id') || '');
            var borrow = lastBorrowByEqId[eqId];
            var $tds = $row.children('td');
            var status = String($row.attr('data-status') || '').trim();
            var cfg = statusConfig[status];

            $('#borrowView_itemNo').text('ID: ' + ($tds.eq(0).text().trim() || '-'));
            $('#borrowView_name').text($tds.eq(1).text().trim() || '-');
            $('#borrowView_serial').text($tds.eq(2).text().trim() || '-');
            $('#borrowView_statusBadge')
                .attr('class', 'badge badge-lg fw-semibold py-2 ' + (cfg ? cfg.cls : 'badge-secondary'))
                .text(cfg ? cfg.label : (status || '-'));

            if (!borrow) {
                $('#borrowView_borrowId, #borrowView_borrower, #borrowView_location, #borrowView_date').text('-');
                return;
            }

            var borrowerStr;
            var borrowerId = String(borrow.userBorrowid || '').trim().toLowerCase();
            var u = null;
            $.each(users || [], function (i, x) {
                if (String(x.id || '').trim().toLowerCase() === borrowerId) { u = x; return false; }
            });
            if (u) {
                var parts = [];
                var empId = u.employee_id || u.employeeId;
                var enName = u.name_en || u.nameEn || u.nick_name;
                if (empId) parts.push(empId);
                if (u.name) parts.push(u.name);
                if (enName) parts.push(enName);
                borrowerStr = parts.length ? parts.join('   -   ') : '-';
            } else {
                borrowerStr = (borrow.userBorrowid || '-') + ' (Unknown User)';
            }

            $('#borrowView_borrowId').text(borrow.borrowId || '-');
            $('#borrowView_borrower').text(borrowerStr);
            $('#borrowView_location').text(borrow.location || $row.attr('data-location') || '-');
            $('#borrowView_date').text(formatDateTime(borrow.dateStart) + ' - ' + (borrow.dateEnd ? formatDateTime(borrow.dateEnd) : 'None'));
        });

        // ---- modal เลือก Warehouse (บันทึกทันทีด้วย AJAX แล้วอัปเดตเฉพาะเซลล์ ไม่ reload เพื่อไม่ให้ filter/search รีเซ็ต) ----
        var $warehouseSelect = $('#equipmentWarehouseSelect');
        $warehouseSelect.append($('<option>').val('').text('ไม่ระบุ'));
        $.each(warehouseList || [], function (i, w) {
            $warehouseSelect.append($('<option>').val(String(w.warehouseId)).text(w.warehouseName || ('#' + w.warehouseId)));
        });

        var currentWarehouseEquipmentId = null;
        $('#equipmentBalanceTable').on('click', '.btn-equ-warehouse', function () {
            var $row = $(this).closest('tr');
            currentWarehouseEquipmentId = String($row.attr('data-equipment-id') || '');
            $('#equipmentWarehouseModalTitle').text('เลือก Warehouse - ' + ($row.children('td').eq(0).text().trim() || ''));
            $warehouseSelect.val($row.attr('data-warehouse-id') || '');
            if ($warehouseSelect.val() === null) { $warehouseSelect.val(''); }
        });

        $('#equipmentWarehouseModal').on('hidden.bs.modal', function () {
            currentWarehouseEquipmentId = null;
        });

        $('#btnEquipmentWarehouseSave').on('click', function () {
            if (!currentWarehouseEquipmentId) {
                notifyError('ไม่พบเครื่องเป้าหมาย กรุณาปิดหน้าต่างแล้วลองใหม่');
                return;
            }
            var eqId = currentWarehouseEquipmentId;
            var whId = $warehouseSelect.val() || '';
            var $btn = $(this);
            $btn.prop('disabled', true);

            $.ajax({
                url: CONTEXT + '/stock_equ_warehouse_save',
                type: 'POST',
                dataType: 'json',
                data: { equipmentId: eqId, warehouseId: whId },
                success: function (res) {
                    if (res && res.success === true) {
                        var $row = $('#equipmentBalanceTable .equ-detail').filter(function () {
                            return String($(this).attr('data-equipment-id')) === eqId;
                        });
                        $row.attr('data-warehouse-id', whId);
                        renderLocationCell($row);
                        applyEquipmentFilters();
                        $('#equipmentWarehouseModal').modal('hide');
                        if (window.Swal) {
                            Swal.fire({ icon: 'success', title: 'บันทึกสำเร็จ', timer: 1500, showConfirmButton: false });
                        }
                    } else {
                        notifyError(res && res.message ? res.message : 'บันทึกไม่สำเร็จ');
                    }
                },
                error: function () {
                    notifyError('บันทึกไม่สำเร็จ กรุณาลองใหม่');
                },
                complete: function () {
                    $btn.prop('disabled', false);
                }
            });
        });

        // ---- เรียกครั้งแรกตอนโหลดหน้า: เติม Status/ที่ตั้ง แล้วให้ default filter status (A+B) มีผลทันที ----
        renderEquipmentRows();
        applyEquipmentFilters();

        // ==================== Equipment: จำ sub product/ตัวแม่เป้าหมายไว้ก่อนเปิด popup Link Equipment ====================
        var currentEquipmentTargetId = null;
        $(document).on('click', '.sub-equ-add', function () {
            currentEquipmentTargetId = $(this).data('target-id');
            var targetName = $(this).data('target-name') || '';
            $('#equipmentPickerModalTitle').text('เลือกเครื่องเพื่อเพิ่มเข้า "' + targetName + '"');
        });

        // ==================== Equipment: popup เลือกเครื่องมาผูกกับ catalog ====================
        // DataTables คำนวณความกว้างคอลัมน์ผิดถ้า init ตอน modal ยังซ่อนอยู่ (display:none)
        // จึงต้อง init ตอน modal โชว์แล้วเท่านั้น (shown.bs.modal) และ init ครั้งเดียวพอ
        $('#equipmentPickerModal').on('shown.bs.modal', function () {
            if (!$.fn.dataTable.isDataTable('#equipmentPickerTable')) {
                $('#equipmentPickerTable').DataTable({
                    dom: "<'table-responsive'tr>" +
                         "<'row align-items-center mt-6'<'col-sm-auto mb-2 mb-sm-0'l><'col-sm d-flex justify-content-sm-end'p>>",
                    pageLength: 10,
                    lengthMenu: [10, 20, 50, 100],
                    info: false,
                    ordering: true,
                    autoWidth: false,
                    language: {
                        lengthMenu: '_MENU_',
                        emptyTable: 'ไม่มีเครื่องว่างให้เลือก - เครื่องทั้งหมดถูกผูกกับ catalog อื่นแล้ว'
                    },
                    columnDefs: [{ targets: 0, orderable: false }]
                });
            }
        });

        $('#equipmentPickerSearch').on('keyup', function () {
            if ($.fn.dataTable.isDataTable('#equipmentPickerTable')) {
                $('#equipmentPickerTable').DataTable().search(this.value).draw();
            }
        });

        // นับจำนวนที่ติ๊กไว้ - checkbox render มาจาก server ตั้งแต่โหลดหน้า (delegate กันเหนียว)
        $('#equipmentPickerTable').on('change', '.equipment-pick-checkbox', function () {
            $('#equipmentPickerSelectedCount').text($('.equipment-pick-checkbox:checked').length);
        });

        // ปิด modal แล้วเคลียร์สถานะ กันเลือกค้างจากรอบก่อนโผล่มาอีกตอนเปิดใหม่
        $('#equipmentPickerModal').on('hidden.bs.modal', function () {
            $('.equipment-pick-checkbox').prop('checked', false);
            $('#equipmentPickerSelectedCount').text('0');
            $('#equipmentPickerSearch').val('');
            currentEquipmentTargetId = null;
            if ($.fn.dataTable.isDataTable('#equipmentPickerTable')) {
                $('#equipmentPickerTable').DataTable().search('').draw();
            }
        });

        // กด Save ใน popup - บันทึกลง DB ทันทีแบบ AJAX แล้วรีโหลดหน้า (filter/search บนหน้านี้จะรีเซ็ตหลัง reload
        // เหมือนพฤติกรรมเดิมของหน้า edit ถือว่ายอมรับได้)
        $('#btnEquipmentPickerSave').on('click', function () {
            var ids = $('.equipment-pick-checkbox:checked').map(function () { return $(this).val(); }).get();
            if (ids.length === 0) {
                if (window.Swal) { Swal.fire('กรุณาเลือกรายการ', 'เลือกอย่างน้อย 1 เครื่อง', 'warning'); }
                else { alert('กรุณาเลือกอย่างน้อย 1 เครื่อง'); }
                return;
            }
            if (!currentEquipmentTargetId) {
                notifyError('ไม่พบ sub product เป้าหมาย กรุณาปิดหน้าต่างแล้วกด Link Equipment ใหม่');
                return;
            }

            var $btn = $(this);
            $btn.prop('disabled', true).attr('data-kt-indicator', 'on');

            $.ajax({
                url: CONTEXT + '/stock_equ_link_save',
                type: 'POST',
                dataType: 'json',
                data: { productId: currentEquipmentTargetId, equipmentIds: ids.join(',') },
                success: function (res) {
                    if (res && res.success === true) {
                        if (window.Swal) {
                            Swal.fire({ icon: 'success', title: 'บันทึกสำเร็จ', text: res.message || 'เพิ่มเครื่องสำเร็จ' })
                                .then(function () { window.location.reload(); });
                        } else {
                            alert(res.message || 'บันทึกสำเร็จ');
                            window.location.reload();
                        }
                    } else {
                        notifyError(res && res.message ? res.message : 'บันทึกไม่สำเร็จ');
                    }
                },
                error: function () {
                    notifyError('บันทึกไม่สำเร็จ กรุณาลองใหม่');
                },
                complete: function () {
                    $btn.prop('disabled', false).removeAttr('data-kt-indicator');
                }
            });
        });
    });
</script>
