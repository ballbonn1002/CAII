<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%--
  หน้าต่าง "ย้ายที่" Asset (ใช้ร่วมกันในหน้ารายการ asset_list และหน้าแก้ไข asset_edit)
  ต้องมี ${warehouseOptions} (id, path) จาก AssetAction
  เปิดด้วย JS: AssetMove.open(['1','2'], 'ข้อความบอกว่าย้ายอะไร')  ส่งไป asset_move_save แล้วโหลดหน้าใหม่
--%>
<div class="modal fade" id="assetMoveModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title fw-bold text-gray-900">ย้ายที่</h3>
                <button type="button" class="btn btn-icon btn-sm btn-active-light-primary" data-bs-dismiss="modal" aria-label="Close">
                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                </button>
            </div>
            <div class="modal-body">
                <div id="assetMoveWhat" class="text-gray-700 fw-semibold mb-5"></div>
                <div class="mb-5">
                    <label for="assetMoveTo" class="form-label fw-semibold text-gray-700 required">ย้ายไปที่</label>
                    <select id="assetMoveTo" class="form-select form-select-solid"
                            data-control="select2" data-placeholder="เลือกที่อยู่ใหม่" data-dropdown-parent="#assetMoveModal">
                        <option value=""></option>
                        <c:forEach var="w" items="${warehouseOptions}">
                            <option value="${w.id}"><c:out value="${w.path}" /></option>
                        </c:forEach>
                    </select>
                </div>
                <div>
                    <label for="assetMoveNote" class="form-label fw-semibold text-gray-700">หมายเหตุ</label>
                    <textarea id="assetMoveNote" class="form-control form-control-solid" rows="2" maxlength="500" placeholder="เช่น ย้ายไปใช้ที่ห้องประชุมใหม่"></textarea>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">ยกเลิก</button>
                <button type="button" id="assetMoveConfirm" class="btn btn-primary">ย้ายที่</button>
            </div>
        </div>
    </div>
</div>

<script>
    // เรียกใช้จากหน้าที่ include ไฟล์นี้: AssetMove.open(รายการ id, ข้อความ)
    var AssetMove = (function () {
        var CTX = '${pageContext.request.contextPath}';
        var pendingIds = [];

        function fail(message) {
            Swal.fire({ text: message || 'เกิดข้อผิดพลาด', icon: 'error', buttonsStyling: false, customClass: { confirmButton: 'btn btn-primary' } });
        }

        function open(ids, what) {
            if (!ids || !ids.length) {
                return;
            }
            pendingIds = ids;
            $('#assetMoveWhat').text(what || '');
            $('#assetMoveTo').val('').trigger('change');
            $('#assetMoveNote').val('');
            bootstrap.Modal.getOrCreateInstance(document.getElementById('assetMoveModal')).show();
        }

        $(document).on('click', '#assetMoveConfirm', function () {
            var to = $('#assetMoveTo').val();
            if (!to) {
                fail('กรุณาเลือกที่อยู่ใหม่');
                return;
            }
            var $btn = $(this).prop('disabled', true);
            $.ajax({
                url: CTX + '/asset_move_save',
                type: 'POST',
                dataType: 'json',
                data: { assetIds: pendingIds.join(','), warehouseId: to, note: $('#assetMoveNote').val() },
                success: function (res) {
                    if (res && res.success === true) {
                        bootstrap.Modal.getOrCreateInstance(document.getElementById('assetMoveModal')).hide();
                        Swal.fire({ text: res.message || 'ย้ายที่แล้ว', icon: 'success', buttonsStyling: false, customClass: { confirmButton: 'btn btn-primary' } })
                            .then(function () { window.location.reload(); });
                    } else {
                        fail(res && res.message);
                        $btn.prop('disabled', false);
                    }
                },
                error: function () {
                    fail('ย้ายที่ไม่สำเร็จ กรุณาลองใหม่');
                    $btn.prop('disabled', false);
                }
            });
        });

        return { open: open };
    })();
</script>
