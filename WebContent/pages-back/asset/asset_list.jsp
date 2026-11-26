<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%--
  หน้ารายการ Assets (AssetAction.assetList) - ข้อมูลทั้งหมดมาจาก Action (assetRows ฯลฯ) ไม่มี mock
  กรองด้วย DataTables ฝั่ง client: ค้นหา + สถานะ / ที่อยู่ / รุ่น (ตรงทั้งคำ)
  ยอดสรุปตามสถานะคำนวณฝั่ง server (statusCounts) ไม่ได้นับจาก DOM
  ย้ายที่: ติ๊กเลือกหลายชิ้นหรือกดปุ่มรายแถว -> asset_move_modal.jsp / ชิ้นที่เคยย้ายแล้ว (r.moved) ปุ่มลบถูกปิด
--%>
<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
    <div class="d-flex flex-column flex-column-fluid">
        <div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
            <div id="kt_app_toolbar_container" class="app-container container-fluid d-flex flex-stack">
                <div class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
                    <h1 class="page-heading d-flex text-gray-700 fw-semibold my-0">Assets</h1>
                    <ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
                        <li class="breadcrumb-item text-muted"><a href="${pageContext.request.contextPath}/demo_dashboard" class="text-muted text-hover-primary fw-medium fs-7">Home</a></li>
                        <li class="breadcrumb-item"><span class="bullet bg-gray-500 fw-medium fs-7 w-5px h-2px"></span></li>
                        <li class="breadcrumb-item text-muted fw-medium fs-7">Assets</li>
                    </ul>
                </div>
            </div>
        </div>

        <div id="kt_app_content" class="app-content flex-column-fluid">
            <div id="kt_app_content_container" class="app-container container-fluid">

                <c:if test="${not empty flash}">
                    <div class="alert alert-${flash.type == 'success' ? 'success' : 'danger'} d-flex align-items-center mb-6" role="alert">
                        <div class="fs-6"><c:out value="${flash.message}" /></div>
                    </div>
                </c:if>

                <%-- ค้นหา + ตัวกรอง --%>
                <div class="card mb-6">
                    <div class="card-body">
                        <div class="row g-4 align-items-end">
                            <div class="col-12 col-lg-4">
                                <label for="assetSearch" class="form-label fw-semibold text-gray-700">ค้นหา</label>
                                <div class="d-flex align-items-center position-relative">
                                    <i class="ki-duotone ki-magnifier fs-3 position-absolute ms-4"><span class="path1"></span><span class="path2"></span></i>
                                    <input type="text" id="assetSearch" class="form-control form-control-solid ps-12" placeholder="Item No., ชื่อ, Serial" autocomplete="off" />
                                </div>
                            </div>
                            <div class="col-12 col-md-4 col-lg-2">
                                <label for="filterStatus" class="form-label fw-semibold text-gray-700">สถานะ</label>
                                <select id="filterStatus" class="form-select form-select-solid">
                                    <option value="">ทั้งหมด</option>
                                    <c:forEach var="s" items="${statusLabels}">
                                        <option value="${fn:escapeXml(s.value)}"><c:out value="${s.value}" /></option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-12 col-md-4 col-lg-3">
                                <label for="filterLocation" class="form-label fw-semibold text-gray-700">ที่อยู่</label>
                                <select id="filterLocation" class="form-select form-select-solid" data-control="select2" data-hide-search="false">
                                    <option value="">ทั้งหมด</option>
                                    <c:forEach var="loc" items="${locationOptions}">
                                        <option value="${fn:escapeXml(loc)}"><c:out value="${loc}" /></option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-12 col-md-4 col-lg-3">
                                <label for="filterModel" class="form-label fw-semibold text-gray-700">รุ่น</label>
                                <select id="filterModel" class="form-select form-select-solid" data-control="select2" data-hide-search="false">
                                    <option value="">ทั้งหมด</option>
                                    <c:forEach var="m" items="${modelOptions}">
                                        <option value="${fn:escapeXml(m)}"><c:out value="${m}" /></option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>

                <%-- สรุปตามสถานะ --%>
                <div class="row g-4 mb-6">
                    <div class="col-6 col-md-3">
                        <div class="card h-100">
                            <div class="card-body py-5">
                                <div class="text-gray-600 fs-7 fw-semibold mb-1">ทั้งหมด</div>
                                <div class="fs-2 fw-bold text-gray-900"><c:out value="${assetTotal}" /></div>
                            </div>
                        </div>
                    </div>
                    <c:forEach var="sc" items="${statusCounts}">
                        <div class="col-6 col-md-3">
                            <div class="card h-100">
                                <div class="card-body py-5">
                                    <div class="mb-1"><span class="badge badge-light-${statusColors[sc.key]}"><c:out value="${statusLabels[sc.key]}" /></span></div>
                                    <div class="fs-2 fw-bold text-gray-900"><c:out value="${sc.value}" /></div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <div class="d-flex flex-wrap align-items-center justify-content-between gap-3 mb-6">
                    <h3 class="text-gray-900 fw-bold mb-0"><span id="assetShownCount"><c:out value="${assetTotal}" /></span> รายการ</h3>
                    <div class="d-flex flex-wrap align-items-center gap-3">
                        <%-- ย้ายที่หลายชิ้น: ติ๊กเลือกในตารางก่อน (ปุ่มเปิดเมื่อมีชิ้นที่เลือก) --%>
                        <button type="button" id="assetMoveSelected" class="btn btn-light-primary d-inline-flex align-items-center" disabled>
                            <i class="ki-duotone ki-arrow-right-left fs-3 me-2"><span class="path1"></span><span class="path2"></span></i>
                            <span class="fw-bold">ย้ายที่ (<span id="assetSelectedCount">0</span>)</span>
                        </button>
                        <a href="${pageContext.request.contextPath}/asset_add" class="btn btn-success d-inline-flex align-items-center">
                            <i class="ki-duotone ki-plus fs-3 me-2"><span class="path1"></span><span class="path2"></span></i>
                            <span class="fw-bold">Create</span>
                        </a>
                    </div>
                </div>

                <div class="card">
                    <div class="card-body">
                        <div class="table-responsive">
                            <table id="assetTable" class="table align-middle table-row-dashed fs-6 gy-4 mb-0">
                                <thead>
                                    <tr class="text-start text-gray-500 fw-bold fs-7 text-uppercase">
                                        <th class="w-30px">
                                            <div class="form-check form-check-sm form-check-custom form-check-solid">
                                                <input class="form-check-input" type="checkbox" id="assetCheckAll" aria-label="เลือกทั้งหมดที่แสดงอยู่" />
                                            </div>
                                        </th>
                                        <th class="min-w-250px">Asset</th>
                                        <th class="min-w-150px">รุ่น</th>
                                        <th class="min-w-200px">ที่อยู่</th>
                                        <th class="min-w-100px">สถานะ</th>
                                        <th class="min-w-120px">อัปเดต</th>
                                        <th class="min-w-100px text-end">Actions</th>
                                    </tr>
                                </thead>
                                <tbody class="text-gray-700">
                                    <c:forEach var="r" items="${assetRows}">
                                        <tr>
                                            <td>
                                                <div class="form-check form-check-sm form-check-custom form-check-solid">
                                                    <input class="form-check-input js-asset-check" type="checkbox" value="${r.assetId}"
                                                           data-label="${fn:escapeXml(r.itemNo)}" aria-label="เลือก ${fn:escapeXml(r.itemNo)}" />
                                                </div>
                                            </td>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <div class="symbol symbol-50px me-4">
                                                        <c:choose>
                                                            <c:when test="${not empty r.image}">
                                                                <img src="${pageContext.request.contextPath}${fn:escapeXml(r.image)}" alt="" class="object-fit-cover" />
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="symbol-label bg-light">
                                                                    <i class="ki-duotone ki-cube-2 fs-2 text-gray-500"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i>
                                                                </span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <div class="d-flex flex-column">
                                                        <a href="${pageContext.request.contextPath}/asset_edit?id=${r.assetId}" class="text-gray-900 text-hover-primary fw-bold"><c:out value="${r.name}" /></a>
                                                        <span class="text-gray-600 fs-7">
                                                            <c:out value="${r.itemNo}" />
                                                            <c:if test="${not empty r.serialNo}"> · SN: <c:out value="${r.serialNo}" /></c:if>
                                                        </span>
                                                    </div>
                                                </div>
                                            </td>
                                            <td><c:out value="${r.model}" /></td>
                                            <td><c:out value="${r.location}" /></td>
                                            <td data-search="${fn:escapeXml(r.statusLabel)}">
                                                <span class="badge badge-light-${r.statusColor}"><c:out value="${r.statusLabel}" /></span>
                                            </td>
                                            <td data-order="${r.updatedSort}"><c:out value="${r.updated}" /></td>
                                            <td class="text-end text-nowrap">
                                                <a href="${pageContext.request.contextPath}/asset_edit?id=${r.assetId}" class="btn btn-sm btn-icon btn-light-primary" title="แก้ไข">
                                                    <i class="ki-duotone ki-pencil fs-4"><span class="path1"></span><span class="path2"></span></i>
                                                </a>
                                                <button type="button" class="btn btn-sm btn-icon btn-light-info js-asset-move" title="ย้ายที่"
                                                        data-id="${r.assetId}" data-label="${fn:escapeXml(r.itemNo)} ${fn:escapeXml(r.name)}">
                                                    <i class="ki-duotone ki-arrow-right-left fs-4"><span class="path1"></span><span class="path2"></span></i>
                                                </button>
                                                <c:choose>
                                                    <c:when test="${r.moved}">
                                                        <%-- เคยย้ายที่แล้ว: ลบไม่ได้ (เก็บประวัติไว้) ให้เปลี่ยนสถานะแทน --%>
                                                        <span class="d-inline-block" title="เคยย้ายที่แล้ว ลบไม่ได้ ให้เปลี่ยนสถานะแทน">
                                                            <button type="button" class="btn btn-sm btn-icon btn-light-danger" disabled>
                                                                <i class="ki-duotone ki-trash fs-4"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i>
                                                            </button>
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button type="button" class="btn btn-sm btn-icon btn-light-danger js-asset-delete" title="ลบ"
                                                                data-id="${r.assetId}" data-label="${fn:escapeXml(r.itemNo)} ${fn:escapeXml(r.name)}">
                                                            <i class="ki-duotone ki-trash fs-4"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i>
                                                        </button>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <%-- ฟอร์มลบ (POST) ใช้ร่วมกันทุกแถว --%>
                <form id="assetDeleteForm" method="post" action="${pageContext.request.contextPath}/asset_delete" class="d-none">
                    <input type="hidden" name="assetId" id="assetDeleteId" value="" />
                </form>

            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        var COL_LOCATION = 3, COL_MODEL = 2, COL_STATUS = 4;

        var table = $('#assetTable').DataTable({
            order: [[5, 'desc']],
            pageLength: 25,
            dom: "<'table-responsive'tr><'row'<'col-12 col-md-5 d-flex align-items-center'i><'col-12 col-md-7 d-flex align-items-center justify-content-center justify-content-md-end'p>>",
            columnDefs: [{ orderable: false, targets: [0, 6] }],
            language: { emptyTable: 'ยังไม่มี Asset', zeroRecords: 'ไม่พบรายการที่ตรงกับตัวกรอง' }
        });

        // ค้นหาตรงทั้งคำ (กัน "ห้อง 1" ไปเจอ "ห้อง 10")
        function exact(value) {
            return value ? '^' + $.fn.dataTable.util.escapeRegex(value) + '$' : '';
        }

        function updateCount() {
            $('#assetShownCount').text(table.rows({ search: 'applied' }).count());
        }

        $('#assetSearch').on('input', function () {
            table.search($(this).val()).draw();
        });
        $('#filterStatus').on('change', function () {
            table.column(COL_STATUS).search(exact($(this).val()), true, false).draw();
        });
        $('#filterLocation').on('change', function () {
            table.column(COL_LOCATION).search(exact($(this).val()), true, false).draw();
        });
        $('#filterModel').on('change', function () {
            table.column(COL_MODEL).search(exact($(this).val()), true, false).draw();
        });
        table.on('draw', updateCount);

        // ---- เลือกหลายชิ้นเพื่อย้ายที่ (จำชิ้นที่ติ๊กไว้ข้ามหน้า/ข้ามตัวกรอง) ----
        var selected = {};
        function selectedIds() {
            return Object.keys(selected);
        }
        function refreshSelection() {
            var n = selectedIds().length;
            $('#assetSelectedCount').text(n);
            $('#assetMoveSelected').prop('disabled', n === 0);
        }
        table.on('draw', function () {
            $('.js-asset-check').each(function () {
                $(this).prop('checked', !!selected[$(this).val()]);
            });
        });
        $(document).on('change', '.js-asset-check', function () {
            if (this.checked) {
                selected[$(this).val()] = true;
            } else {
                delete selected[$(this).val()];
            }
            refreshSelection();
        });
        // ติ๊กทั้งหมด = ทุกชิ้นที่ผ่านตัวกรองอยู่ (ทุกหน้า) ไม่ใช่แค่หน้าที่เห็น
        $('#assetCheckAll').on('change', function () {
            var on = this.checked;
            table.rows({ search: 'applied' }).nodes().to$().find('.js-asset-check').each(function () {
                $(this).prop('checked', on);
                if (on) {
                    selected[$(this).val()] = true;
                } else {
                    delete selected[$(this).val()];
                }
            });
            refreshSelection();
        });
        $('#assetMoveSelected').on('click', function () {
            var ids = selectedIds();
            AssetMove.open(ids, 'ย้ายที่ ' + ids.length + ' รายการที่เลือก');
        });
        $(document).on('click', '.js-asset-move', function () {
            AssetMove.open([$(this).attr('data-id')], 'ย้ายที่ ' + ($(this).attr('data-label') || ''));
        });

        // ลบ: ยืนยันก่อน แล้วส่งฟอร์ม POST
        $(document).on('click', '.js-asset-delete', function () {
            var id = $(this).attr('data-id');
            var label = $(this).attr('data-label') || '';
            Swal.fire({
                text: 'ลบ ' + label + ' ใช่ไหม? ลบแล้วกู้คืนไม่ได้',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'ลบ',
                cancelButtonText: 'ยกเลิก',
                buttonsStyling: false,
                customClass: { confirmButton: 'btn btn-danger', cancelButton: 'btn btn-light' }
            }).then(function (result) {
                if (result.isConfirmed) {
                    $('#assetDeleteId').val(id);
                    $('#assetDeleteForm').trigger('submit');
                }
            });
        });
    });
</script>

<%-- หน้าต่างย้ายที่ (ใช้ร่วมกับหน้าแก้ไข) --%>
<jsp:include page="/pages-back/asset/asset_move_modal.jsp" />
