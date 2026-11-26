<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%--
  การ์ด Assets ในหน้าแก้ไข Product ประเภท 4 (include จาก stock_item_edit_fragment.jsp)
  ข้อมูลมาจาก ProductAction.putAssetAttributes():
    assetsEnabled  : มีสิทธิ์ assetlist.view (ไม่มี = ไม่แสดงการ์ดเลย)
    assetTargets   : รุ่นที่ผูกได้ (ตัวแม่ + sub product)  {id, name, isParent}
    linkedAssets   : Asset ที่ผูกกับรุ่นของ Product นี้
    unlinkedAssets : Asset ที่ยังไม่มีรุ่น (ตัวเลือกใน Link Assets)
  ผูก / เอาออก ยิง AJAX ไปที่ asset_link_save / asset_unlink_save (AssetAction) แล้วโหลดหน้าใหม่
--%>
<c:if test="${assetsEnabled}">
<div class="card mt-6" id="productAssetsCard">
    <div class="card-header">
        <div class="card-title">
            <h3 class="fw-bold text-gray-900 mb-0">Assets <span class="badge badge-light-primary ms-2"><c:out value="${fn:length(linkedAssets)}" /></span></h3>
        </div>
        <div class="card-toolbar gap-3">
            <a href="${pageContext.request.contextPath}/asset_add" class="btn btn-light d-inline-flex align-items-center">
                <i class="ki-duotone ki-plus fs-3 me-1"><span class="path1"></span><span class="path2"></span></i>
                <span class="fw-semibold">สร้าง Asset ใหม่</span>
            </a>
            <button type="button" class="btn btn-success d-inline-flex align-items-center" data-bs-toggle="modal" data-bs-target="#assetLinkModal">
                <i class="ki-duotone ki-link fs-3 me-1"><span class="path1"></span><span class="path2"></span></i>
                <span class="fw-bold">Link Assets</span>
            </button>
        </div>
    </div>
    <div class="card-body">
        <c:choose>
            <c:when test="${empty linkedAssets}">
                <div class="text-gray-600 py-5">ยังไม่มี Asset ผูกกับ Product นี้ กด Link Assets เพื่อเลือก Asset ที่ยังไม่มีรุ่น</div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table align-middle table-row-dashed fs-6 gy-4 mb-0">
                        <thead>
                            <tr class="text-start text-gray-500 fw-bold fs-7 text-uppercase">
                                <th class="min-w-200px">Asset</th>
                                <th class="min-w-150px">รุ่น</th>
                                <th class="min-w-120px">Serial</th>
                                <th class="min-w-200px">ที่อยู่</th>
                                <th class="min-w-100px">สถานะ</th>
                                <th class="min-w-80px text-end">Action</th>
                            </tr>
                        </thead>
                        <tbody class="text-gray-700">
                            <c:forEach var="a" items="${linkedAssets}">
                                <tr>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/asset_edit?id=${a.assetId}" class="text-gray-900 text-hover-primary fw-bold"><c:out value="${a.itemNo}" /></a>
                                        <div class="text-gray-600 fs-7"><c:out value="${a.name}" /></div>
                                    </td>
                                    <td><c:out value="${a.model}" /></td>
                                    <td><c:out value="${empty a.serialNo ? '-' : a.serialNo}" /></td>
                                    <td><c:out value="${a.location}" /></td>
                                    <td><span class="badge badge-light-${a.statusColor}"><c:out value="${a.statusLabel}" /></span></td>
                                    <td class="text-end">
                                        <button type="button" class="btn btn-sm btn-icon btn-light-danger js-asset-unlink" title="เอาออกจากรุ่น"
                                                data-id="${a.assetId}" data-product-id="${a.productId}"
                                                data-label="${fn:escapeXml(a.itemNo)} ${fn:escapeXml(a.name)}">
                                            <i class="ki-duotone ki-cross fs-3"><span class="path1"></span><span class="path2"></span></i>
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<%-- Modal: เลือก Asset ที่ยังไม่มีรุ่น มาผูกกับรุ่นที่เลือก (บันทึกด้วย AJAX ปุ่ม Save เป็น type="button") --%>
<div class="modal fade" id="assetLinkModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title fw-bold text-gray-900">Link Assets</h3>
                <button type="button" class="btn btn-icon btn-sm btn-active-light-primary" data-bs-dismiss="modal" aria-label="Close">
                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                </button>
            </div>
            <div class="modal-body">
                <div class="row g-4 mb-6">
                    <div class="col-12 col-md-4">
                        <label for="assetLinkTarget" class="form-label fw-semibold text-gray-700">ผูกเข้ากับรุ่น</label>
                        <select id="assetLinkTarget" class="form-select form-select-solid">
                            <c:forEach var="t" items="${assetTargets}">
                                <option value="${t.id}"><c:out value="${t.name}" /><c:if test="${t.isParent}"> (ตัวแม่)</c:if></option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-12 col-md-5">
                        <label for="assetLinkSearch" class="form-label fw-semibold text-gray-700">ค้นหา</label>
                        <input type="text" id="assetLinkSearch" class="form-control form-control-solid" placeholder="Item No., ชื่อ, Serial" autocomplete="off" />
                    </div>
                    <div class="col-12 col-md-3">
                        <label for="assetLinkStatus" class="form-label fw-semibold text-gray-700">สถานะ</label>
                        <select id="assetLinkStatus" class="form-select form-select-solid">
                            <option value="">ทั้งหมด</option>
                        </select>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table align-middle table-row-dashed fs-6 gy-3 mb-0" id="assetLinkTable">
                        <thead>
                            <tr class="text-start text-gray-500 fw-bold fs-7 text-uppercase">
                                <th class="w-40px"></th>
                                <th class="min-w-200px">Asset</th>
                                <th class="min-w-120px">Serial</th>
                                <th class="min-w-200px">ที่อยู่</th>
                                <th class="min-w-100px">สถานะ</th>
                            </tr>
                        </thead>
                        <tbody class="text-gray-700">
                            <c:forEach var="a" items="${unlinkedAssets}">
                                <tr class="js-asset-pick-row" data-status="${fn:escapeXml(a.statusLabel)}"
                                    data-search="${fn:escapeXml(fn:toLowerCase(a.itemNo))} ${fn:escapeXml(fn:toLowerCase(a.name))} ${fn:escapeXml(fn:toLowerCase(a.serialNo))}">
                                    <td>
                                        <div class="form-check form-check-custom form-check-solid">
                                            <input class="form-check-input js-asset-pick" type="checkbox" value="${a.assetId}" />
                                        </div>
                                    </td>
                                    <td>
                                        <span class="fw-bold text-gray-900"><c:out value="${a.itemNo}" /></span>
                                        <div class="text-gray-600 fs-7"><c:out value="${a.name}" /></div>
                                    </td>
                                    <td><c:out value="${empty a.serialNo ? '-' : a.serialNo}" /></td>
                                    <td><c:out value="${a.location}" /></td>
                                    <td><span class="badge badge-light-${a.statusColor}"><c:out value="${a.statusLabel}" /></span></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div id="assetLinkEmpty" class="text-gray-600 py-5 <c:if test="${not empty unlinkedAssets}">d-none</c:if>">
                    ไม่มี Asset ที่ยังไม่มีรุ่น ถ้าต้องการย้ายรุ่น ให้เอาออกจากรุ่นเดิมก่อน
                </div>
            </div>
            <div class="modal-footer justify-content-between">
                <span class="text-gray-600">เลือกแล้ว <span id="assetLinkSelected">0</span> รายการ</span>
                <div class="d-flex gap-3">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">ยกเลิก</button>
                    <button type="button" class="btn btn-primary" id="assetLinkSave" disabled>Save</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        var CTX = '${pageContext.request.contextPath}';

        function fail(message) {
            Swal.fire({ text: message || 'เกิดข้อผิดพลาด', icon: 'error', buttonsStyling: false, customClass: { confirmButton: 'btn btn-primary' } });
        }
        function done(message) {
            Swal.fire({ text: message, icon: 'success', buttonsStyling: false, customClass: { confirmButton: 'btn btn-primary' } })
                .then(function () { window.location.reload(); });
        }

        // ตัวกรองสถานะ: เอาค่าที่มีอยู่จริงในตารางมาเป็นตัวเลือก (ไม่ต้องเขียนชื่อสถานะซ้ำในหน้านี้)
        var seen = {};
        $('.js-asset-pick-row').each(function () {
            var s = $(this).attr('data-status');
            if (s && !seen[s]) {
                seen[s] = true;
                $('#assetLinkStatus').append($('<option>').val(s).text(s));
            }
        });

        function refreshSelected() {
            var n = $('.js-asset-pick:checked').length;
            $('#assetLinkSelected').text(n);
            $('#assetLinkSave').prop('disabled', n === 0);
        }

        function applyFilter() {
            var q = $.trim($('#assetLinkSearch').val() || '').toLowerCase();
            var st = $('#assetLinkStatus').val();
            $('.js-asset-pick-row').each(function () {
                var $row = $(this);
                var okText = !q || ($row.attr('data-search') || '').indexOf(q) !== -1;
                var okStatus = !st || $row.attr('data-status') === st;
                var show = okText && okStatus;
                $row.toggleClass('d-none', !show);
                // ซ่อนแถวแล้วต้องไม่ถูกบันทึกไปด้วย
                if (!show) {
                    $row.find('.js-asset-pick').prop('checked', false);
                }
            });
            refreshSelected();
        }

        $('#assetLinkSearch').on('input', applyFilter);
        $('#assetLinkStatus').on('change', applyFilter);
        $(document).on('change', '.js-asset-pick', refreshSelected);

        $('#assetLinkModal').on('hidden.bs.modal', function () {
            $('.js-asset-pick').prop('checked', false);
            $('#assetLinkSearch').val('');
            $('#assetLinkStatus').val('');
            applyFilter();
        });

        $('#assetLinkSave').on('click', function () {
            var ids = [];
            $('.js-asset-pick:checked').each(function () { ids.push($(this).val()); });
            var target = $('#assetLinkTarget').val();
            if (!ids.length || !target) {
                return;
            }
            var $btn = $(this).prop('disabled', true);
            $.ajax({
                url: CTX + '/asset_link_save',
                type: 'POST',
                dataType: 'json',
                data: { productId: target, assetIds: ids.join(',') },
                success: function (res) {
                    if (res && res.success === true) {
                        done(res.message || 'ผูก Asset แล้ว');
                    } else {
                        fail(res && res.message);
                        $btn.prop('disabled', false);
                    }
                },
                error: function () {
                    fail('ผูก Asset ไม่สำเร็จ กรุณาลองใหม่');
                    $btn.prop('disabled', false);
                }
            });
        });

        // เอาออกจากรุ่น: ยืนยันก่อน Asset ไม่ถูกลบ แค่กลับไปเป็นชิ้นที่ยังไม่มีรุ่น
        $(document).on('click', '.js-asset-unlink', function () {
            var $btn = $(this);
            var id = $btn.attr('data-id');
            var productId = $btn.attr('data-product-id');
            var label = $btn.attr('data-label') || '';
            Swal.fire({
                text: 'เอา ' + label + ' ออกจากรุ่นนี้ใช่ไหม? Asset จะยังอยู่ในระบบ แค่ไม่มีรุ่น',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'เอาออก',
                cancelButtonText: 'ยกเลิก',
                buttonsStyling: false,
                customClass: { confirmButton: 'btn btn-danger', cancelButton: 'btn btn-light' }
            }).then(function (result) {
                if (!result.isConfirmed) {
                    return;
                }
                $btn.prop('disabled', true);
                $.ajax({
                    url: CTX + '/asset_unlink_save',
                    type: 'POST',
                    dataType: 'json',
                    data: { productId: productId, assetIds: id },
                    success: function (res) {
                        if (res && res.success === true) {
                            done(res.message || 'เอา Asset ออกแล้ว');
                        } else {
                            fail(res && res.message);
                            $btn.prop('disabled', false);
                        }
                    },
                    error: function () {
                        fail('เอาออกไม่สำเร็จ กรุณาลองใหม่');
                        $btn.prop('disabled', false);
                    }
                });
            });
        });
    });
</script>
</c:if>
