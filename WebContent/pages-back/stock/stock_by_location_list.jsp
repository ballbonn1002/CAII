<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%--
  Stock By Location - แสดงเป็น tree ต้นไม้ของ warehouse จริง (โครง expand/collapse อ้างจาก
  pages-back/warehouse/warehouse_list.jsp) ข้อมูลมาจาก ProductAction.showStockByLocationPage() ทั้งหมด:
    - locationNodes         : List<Map> {id, parentId, type, name, productCount, onHand} แบบ flat list
                               (parentId="0" = คลังราก) type "warehouse" = คลังจริง, type "product" = รายการ
                               สินค้า 1 ตัวในคลังใบล่าสุดนั้น (ไม่มีลูกของตัวเอง ใช้กลไก expand เดียวกัน)
    - totalLocations         : จำนวนคลัง "ใบล่าสุด" ทั้งหมด (คลังที่ไม่มีลูกแล้ว)
    - totalOnHand            : ผลรวม onHand ของทุกคลังราก (roll-up มาแล้ว ไม่บวกซ้ำ)
    - totalDistinctProducts  : จำนวน product ตัวแม่ที่ต่างกันซึ่งมียอดอยู่ในคลังใดคลังหนึ่ง
    - totalBorrowed          : จำนวนเครื่อง equipment ที่ถูกยืมอยู่ (status = B) - ไม่รวมอยู่ใน totalOnHand/
                               totalDistinctProducts ข้างบน เพราะของไม่ได้อยู่ในคลังจริงแล้ว
  node ประเภท "borrow_root"/"borrow_type"/"borrow_unit"/"borrow_item" คือกลุ่ม "Borrowing" ท้าย tree (เฉพาะมุมมองทั้งบริษัท
  selectedWarehouseId ว่าง) โครง 4 ระดับ: Borrowing -> product_type (มีแค่ "Equipment" เสมอ เพราะมีแต่ type นี้ที่ยืมได้
  จริงในระบบตอนนี้) -> เครื่องจริงแต่ละเครื่อง (ป้ายชื่อ "item no ชื่อสินค้า") -> ผู้ยืม + วันที่ยืม (ใบล่าสุด)
  id ของ node กลุ่มนี้เป็น string ไม่ใช่ตัวเลข ไม่ชนกับ id คลัง - ดู ProductAction.buildBorrowingNodes()
--%>

<style>
.stock-loc-toggle i {
    display: inline-block;
    transition: transform .2s ease;
}
.stock-loc-toggle i.expanded {
    transform: rotate(90deg);
}
</style>

<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
    <div class="d-flex flex-column flex-column-fluid">
        <div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
            <div id="kt_app_toolbar_container" class="app-container container-fluid d-flex flex-stack">
                <div class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
                    <h1 class="page-heading d-flex text-gray-700 fw-semibold my-0">
                        <c:choose>
                            <c:when test="${not empty selectedWarehouseId && not empty locationBreadcrumb}">
                                ${fn:escapeXml(locationBreadcrumb[fn:length(locationBreadcrumb)-1].name)}
                            </c:when>
                            <c:otherwise>Stock By Location</c:otherwise>
                        </c:choose>
                    </h1>
                    <ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
                        <li class="breadcrumb-item text-muted"><a href="${pageContext.request.contextPath}/check_in_out" class="text-muted text-hover-primary fw-medium fs-7">Home</a></li>
                        <li class="breadcrumb-item"><span class="bullet bg-gray-500 fw-medium fs-7 w-5px h-2px"></span></li>
                        <li class="breadcrumb-item text-muted fw-medium fs-7"><a href="${pageContext.request.contextPath}/product_list" class="text-muted text-hover-primary">Product</a></li>
                        <li class="breadcrumb-item"><span class="bullet bg-gray-500 fw-medium fs-7 w-5px h-2px"></span></li>
                        <c:choose>
                            <c:when test="${not empty selectedWarehouseId}">
                                <li class="breadcrumb-item text-muted fw-medium fs-7">
                                    <a href="${pageContext.request.contextPath}/stock_by_location_list" class="text-muted text-hover-primary">Stock By Location</a>
                                </li>
                                <c:forEach items="${locationBreadcrumb}" var="crumb" varStatus="cs">
                                    <li class="breadcrumb-item"><span class="bullet bg-gray-500 fw-medium fs-7 w-5px h-2px"></span></li>
                                    <li class="breadcrumb-item text-muted fw-medium fs-7">
                                        <c:if test="${!cs.last}">
                                            <a href="${pageContext.request.contextPath}/stock_by_location_list?rootId=${crumb.id}" class="text-muted text-hover-primary">${fn:escapeXml(crumb.name)}</a>
                                        </c:if>
                                        <c:if test="${cs.last}">${fn:escapeXml(crumb.name)}</c:if>
                                    </li>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <li class="breadcrumb-item text-muted fw-medium fs-7">Stock By Location</li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </div>
            </div>
        </div>

        <div id="kt_app_content" class="app-content flex-column-fluid">
            <div id="kt_app_content_container" class="app-container container-fluid">

                <%-- ---- การ์ดสรุปด้านบน ---- --%>
                <div class="row g-4 mb-6">
                    <div class="col-12 col-sm-6 col-lg-3">
                        <div class="card card-bordered h-100">
                            <div class="card-body d-flex align-items-center gap-3 py-4 px-5">
                                <i class="ki-duotone ki-home-3 fs-2x text-primary"><span class="path1"></span><span class="path2"></span></i>
                                <span class="text-gray-600 fw-semibold fs-6">Locations</span>
                                <span class="text-gray-900 fw-bold fs-4 ms-auto">${empty totalLocations ? 0 : totalLocations} <span class="fs-7 fw-semibold text-gray-500">locations</span></span>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-sm-6 col-lg-3">
                        <div class="card card-bordered h-100">
                            <div class="card-body d-flex align-items-center gap-3 py-4 px-5">
                                <i class="ki-duotone ki-package fs-2x text-success"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i>
                                <span class="text-gray-600 fw-semibold fs-6">Total On Hand</span>
                                <span class="text-gray-900 fw-bold fs-4 ms-auto">${empty totalOnHand ? 0 : totalOnHand} <span class="fs-7 fw-semibold text-gray-500">units</span></span>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-sm-6 col-lg-3">
                        <div class="card card-bordered h-100">
                            <div class="card-body d-flex align-items-center gap-3 py-4 px-5">
                                <i class="ki-duotone ki-abstract-26 fs-2x text-warning"><span class="path1"></span><span class="path2"></span></i>
                                <span class="text-gray-600 fw-semibold fs-6">Distinct Products</span>
                                <span class="text-gray-900 fw-bold fs-4 ms-auto">${empty totalDistinctProducts ? 0 : totalDistinctProducts} <span class="fs-7 fw-semibold text-gray-500">items</span></span>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-sm-6 col-lg-3">
                        <div class="card card-bordered h-100">
                            <div class="card-body d-flex align-items-center gap-3 py-4 px-5">
                                <i class="ki-duotone ki-profile-user fs-2x text-info"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i>
                                <span class="text-gray-600 fw-semibold fs-6">Borrowing</span>
                                <span class="text-gray-900 fw-bold fs-4 ms-auto">${empty totalBorrowed ? 0 : totalBorrowed} <span class="fs-7 fw-semibold text-gray-500">units</span></span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card card-flush">
                    <div class="card-header mt-2">
                        <div class="card-title">
                            <h3 class="fw-semibold text-gray-900 mb-0">
                                <c:choose>
                                    <c:when test="${not empty selectedWarehouseId && not empty locationBreadcrumb}">
                                        ${fn:escapeXml(locationBreadcrumb[fn:length(locationBreadcrumb)-1].name)}
                                    </c:when>
                                    <c:otherwise>Stock By Location</c:otherwise>
                                </c:choose>
                            </h3>
                        </div>
                        <div class="card-toolbar">
                            <div class="d-flex align-items-center position-relative">
                                <i class="ki-duotone ki-magnifier fs-3 position-absolute ms-4"><span class="path1"></span><span class="path2"></span></i>
                                <input type="text" id="locationSearch" class="form-control form-control-solid ps-12 text-gray-700"
                                       style="min-width: 280px;" placeholder="ค้นหาคลัง / ชื่อสินค้า" />
                            </div>
                        </div>
                    </div>

                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty locationNodes}">
                                <div class="text-center text-muted py-10">ยังไม่มีข้อมูลคลังในระบบ</div>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table table-striped align-middle fs-6 mb-0" id="locationTable">
                                        <thead>
                                            <tr class="text-gray-500 fs-7 fw-semibold text-uppercase">
                                                <th class="ps-6 min-w-300px">Location</th>
                                                <th class="text-end min-w-120px">Products</th>
                                                <th class="text-end min-w-120px pe-6">On Hand</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%-- แถวถูก render ทั้งหมดด้วย JS จาก locationList ด้านล่าง (เหมือน warehouse_list.jsp) --%>
                                        </tbody>
                                    </table>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    const locationList = [
        <c:forEach items="${locationNodes}" var="node" varStatus="s">
        {
            id: "${node.id}",
            parentId: "${node.parentId}",
            type: "${node.type}",
            name: "${fn:escapeXml(node.name)}",
            productCount: ${node.productCount},
            onHand: "${node.onHand}"
        }<c:if test="${!s.last}">,</c:if>
        </c:forEach>
    ];

    var CONTEXT = '${pageContext.request.contextPath}';

    // rootId ของคลังที่กำลังดู (scoped view) - ว่าง = มุมมองทั้งบริษัท
    // backend กรอง locationList มาให้แล้ว ตัวแปรนี้ไว้เผื่อใช้เทียบ ไม่ต้องคำนวณ tree ซ้ำ
    var SELECTED_ROOT_ID = '${selectedWarehouseId}';

    const locationState = { tree: [], map: {}, expanded: new Set() };

    function initLocationTree(data) {
        locationState.tree = buildLocationTree(data);
        // โหมดเข้าดูคลังเดียว (SELECTED_ROOT_ID ไม่ว่าง) กางทุกชั้นในสายให้อัตโนมัติ ผู้ใช้จะได้เห็นสินค้าทันที
        // ไม่ต้องไล่กดทีละชั้น - โหมดทั้งบริษัท (SELECTED_ROOT_ID ว่าง) ไม่แตะ ทำงานเหมือนเดิม (ปิดไว้ก่อน)
        if (SELECTED_ROOT_ID) {
            Object.keys(locationState.map).forEach(id => {
                if (locationState.map[id].children.length) {
                    locationState.expanded.add(id);
                }
            });
        }
        renderLocationTree();
    }

    function buildLocationTree(data) {
        const map = {};
        const roots = [];

        data.forEach(item => {
            map[item.id] = { ...item, children: [] };
        });

        data.forEach(item => {
            if (item.parentId === "0") {
                roots.push(map[item.id]);
            } else if (map[item.parentId]) {
                map[item.parentId].children.push(map[item.id]);
            } else {
                // ไม่พบ parent ใน data - ปกติเกิดตอนโหมด scoped (เลือกดูคลังเดียว) เพราะ backend กรอง
                // node เหลือแค่ในสายของคลังที่เลือก คลังที่เลือกเองเลยหา parent ไม่เจอ (ถูกกรองออกไปแล้ว)
                // ต้องเซ็ต parentId เป็น "0" ด้วย ไม่ใช่แค่ดันเข้า roots เฉยๆ ไม่งั้น isLocationVisible()
                // จะยังอิง parentId เดิมที่หา parent ไม่เจอ ทำให้แถวนี้ (และลูกทั้งหมด) ถูกซ่อนด้วย d-none
                map[item.id].parentId = "0";
                roots.push(map[item.id]);
            }
        });

        locationState.map = map;
        return roots;
    }

    function renderLocationTree() {
        $("#locationTable tbody").html(renderLocationNodes(locationState.tree, 0));
    }

    function renderLocationNodes(nodes, level) {
        let html = "";
        nodes.forEach(node => {
            html += renderLocationRow(node, level, false);
            if (node.children.length) {
                html += renderLocationNodes(node.children, level + 1);
            }
        });
        return html;
    }

    function isLocationVisible(node) {
        if (node.parentId === "0") {
            return true;
        }
        let current = node;
        while (current.parentId !== "0") {
            if (!locationState.expanded.has(current.parentId)) {
                return false;
            }
            current = locationState.map[current.parentId];
            if (!current) {
                return false;
            }
        }
        return true;
    }

    function getLocationLevel(node) {
        let level = 0;
        let current = node;
        while (current.parentId !== "0" && locationState.map[current.parentId]) {
            level++;
            current = locationState.map[current.parentId];
        }
        return level;
    }

    function renderLocationRow(node, level, forceVisible) {
        const hasChildren = node.children.length > 0;
        const visible = forceVisible || isLocationVisible(node);
        const expanded = locationState.expanded.has(node.id);
        // "product" (สินค้าในคลังใบล่าสุด) และ "borrow_item" (เครื่องที่ถูกยืม - ป้ายชื่อเป็นผู้ยืม) เป็นใบเดี่ยวเหมือนกัน - ไม่มีลูก
        const isLeafItem = node.type === "product" || node.type === "borrow_item";
        // เฉพาะ node ราก "Borrowing" ใช้ไอคอนคนแยกให้เด่น ส่วน "borrow_product" (กลุ่มตามสินค้า) ใช้ไอคอนโฟลเดอร์เหมือนคลัง
        const isBorrowRoot = node.type === "borrow_root";

        const icon = isLeafItem
            ? '<i class="ki-duotone ki-parcel fs-4 text-muted me-4"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i>'
            : isBorrowRoot
                ? '<i class="ki-duotone ki-profile-user fs-2x me-5"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i>'
                : '<i class="ki-duotone ki-folder fs-2x me-5"><span class="path1"></span><span class="path2"></span></i>';

        const toggle = hasChildren
            ? '<span class="stock-loc-toggle me-3 cursor-pointer"><i class="ki-duotone ki-right fs-5 ' + (expanded ? "expanded" : "") + '"></i></span>'
            : '<span style="width:22px;display:inline-block;"></span>';

        const nameClass = isLeafItem ? "text-gray-700" : "text-gray-900 fw-bold";

        // หมายเหตุ: ตั้งใจใช้ string concatenation แทน JS template literal (backtick) ตรงนี้
        // เพราะ dollar-brace แบบ JS interpolation ในไฟล์ .jsp จะถูก JSP EL ตีความ/กลืนหายไปก่อนถึงมือ browser
        return ""
            + '<tr class="' + (visible ? "" : "d-none") + '" data-id="' + node.id + '" data-parent="' + node.parentId + '" data-type="' + node.type + '">'
            +     '<td class="ps-6">'
            +         '<div class="d-flex align-items-center" style="padding-left:' + (level * 32) + 'px">'
            +             toggle + icon + '<span class="' + nameClass + '">' + node.name + '</span>'
            +         '</div>'
            +     '</td>'
            +     '<td class="text-end">' + (isLeafItem ? "" : node.productCount) + '</td>'
            +     '<td class="text-end fw-bold pe-6">' + node.onHand + '</td>'
            + '</tr>';
    }

    function toggleLocationChildren(parentId, show) {
        $('#locationTable tr[data-parent="' + parentId + '"]').each(function () {
            const row = $(this);
            const childId = row.attr("data-id");

            if (show) {
                row.removeClass("d-none");
                if (locationState.expanded.has(childId)) {
                    toggleLocationChildren(childId, true);
                }
            } else {
                toggleLocationChildren(childId, false);
                row.addClass("d-none");
            }
        });
    }

    $(document).on("click", "#locationTable .stock-loc-toggle", function (e) {
        // กัน event ลามไปโดน handler ของ tr ด้านล่าง (ไม่งั้นกดลูกศร expand จะเผลอ navigate ไปด้วย)
        e.stopPropagation();

        const row = $(this).closest("tr");
        const id = row.attr("data-id");
        const icon = $(this).find("i");

        if (locationState.expanded.has(id)) {
            locationState.expanded.delete(id);
            icon.removeClass("expanded");
            toggleLocationChildren(id, false);
        } else {
            locationState.expanded.add(id);
            icon.addClass("expanded");
            toggleLocationChildren(id, true);
        }
    });

    // คลิกแถวคลัง (ไม่ใช่แถว product) เพื่อเข้าไปดูลิสต์ scoped เฉพาะคลังนั้น
    $(document).on("click", '#locationTable tr[data-type="warehouse"]', function () {
        const id = $(this).attr("data-id");
        if (!id) { return; }
        window.location.href = CONTEXT + '/stock_by_location_list?rootId=' + id;
    });

    // ---- ค้นหาข้ามทั้ง tree (ชื่อคลังหรือชื่อสินค้า) - โหมดค้นหาแสดงทุกแถวที่ตรงแบบแบนราบ ไม่สนสถานะ expand ----
    $("#locationSearch").on("keyup", function () {
        const keyword = $.trim($(this).val()).toLowerCase();

        if (!keyword) {
            renderLocationTree();
            return;
        }

        let html = "";
        Object.keys(locationState.map).forEach(id => {
            const node = locationState.map[id];
            if (node.name.toLowerCase().indexOf(keyword) !== -1) {
                html += renderLocationRow(node, getLocationLevel(node), true);
            }
        });
        $("#locationTable tbody").html(html || '<tr><td colspan="3" class="text-center text-muted py-6">ไม่พบรายการที่ค้นหา</td></tr>');
    });

    $(document).ready(function () {
        initLocationTree(locationList);
    });
</script>
