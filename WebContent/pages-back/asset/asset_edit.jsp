<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%--
  หน้าเพิ่ม / แก้ไข Asset (AssetAction.assetAdd / assetEdit / assetSave ตอนข้อมูลไม่ผ่าน)
  - Item No. ระบบสร้างให้ตอนบันทึกครั้งแรก (nextItemNo = ตัวอย่างเลขที่จะได้) แก้ไม่ได้
  - ที่อยู่เลือกได้เฉพาะตอนสร้าง หรือชิ้นที่ยังไม่เคยระบุ (canSetLocation) นอกนั้นเปลี่ยนผ่านปุ่ม "ย้ายที่" (asset_move_modal.jsp) และมีประวัติการย้ายด้านล่าง
  - ชิ้นที่เคยย้ายที่แล้ว (hasMoves) ลบไม่ได้ ให้เปลี่ยนสถานะแทน
  - รุ่น = Product ประเภท Assets (type 4) ไม่บังคับ
--%>
<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
    <div class="d-flex flex-column flex-column-fluid">
        <div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
            <div id="kt_app_toolbar_container" class="app-container container-fluid d-flex flex-stack">
                <div class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
                    <h1 class="page-heading d-flex text-gray-700 fw-semibold my-0">
                        <c:choose>
                            <c:when test="${isNew}">เพิ่ม Asset</c:when>
                            <c:otherwise>แก้ไข Asset</c:otherwise>
                        </c:choose>
                    </h1>
                    <ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
                        <li class="breadcrumb-item text-muted"><a href="${pageContext.request.contextPath}/demo_dashboard" class="text-muted text-hover-primary fw-medium fs-7">Home</a></li>
                        <li class="breadcrumb-item"><span class="bullet bg-gray-500 fw-medium fs-7 w-5px h-2px"></span></li>
                        <li class="breadcrumb-item text-muted"><a href="${pageContext.request.contextPath}/asset_list" class="text-muted text-hover-primary fw-medium fs-7">Assets</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <div id="kt_app_content" class="app-content flex-column-fluid">
            <div id="kt_app_content_container" class="app-container container-fluid">

                <c:if test="${not empty formError}">
                    <div class="alert alert-danger d-flex align-items-center mb-6" role="alert">
                        <div class="fs-6"><c:out value="${formError}" /></div>
                    </div>
                </c:if>

                <form id="assetForm" method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/asset_save">
                    <input type="hidden" name="assetId" value="${asset.assetId}" />

                    <div class="row g-6">
                        <%-- รูป --%>
                        <div class="col-12 col-lg-4">
                            <div class="card h-100">
                                <div class="card-body">
                                    <div class="fw-semibold fs-6 mb-4">รูป</div>
                                    <div class="d-flex flex-column align-items-center">
                                        <div class="border rounded-3 bg-light d-flex align-items-center justify-content-center w-100 h-250px overflow-hidden mb-4">
                                            <img id="assetImagePreview" alt=""
                                                 <c:if test="${not empty asset.image}">src="${pageContext.request.contextPath}${fn:escapeXml(asset.image)}"</c:if>
                                                 class="mw-100 mh-100 object-fit-contain ${empty asset.image ? 'd-none' : ''}" />
                                            <span id="assetImagePlaceholder" class="text-gray-500 fs-7 ${empty asset.image ? '' : 'd-none'}">ยังไม่มีรูป</span>
                                        </div>
                                        <input type="file" id="assetImageInput" name="image" accept="image/png,image/jpeg,image/gif,image/webp" class="d-none" />
                                        <button type="button" id="assetImageSelect" class="btn btn-light">
                                            <i class="ki-duotone ki-picture fs-3 me-1"><span class="path1"></span><span class="path2"></span></i>
                                            เลือกรูป
                                        </button>
                                        <div class="form-text text-center">jpg, png, gif หรือ webp</div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <%-- ข้อมูล --%>
                        <div class="col-12 col-lg-8">
                            <div class="card">
                                <div class="card-body">
                                    <div class="row g-5">
                                        <div class="col-12 col-md-6">
                                            <label class="form-label fw-semibold text-gray-700">Item No.</label>
                                            <c:choose>
                                                <c:when test="${isNew}">
                                                    <input type="text" class="form-control form-control-solid" value="${fn:escapeXml(nextItemNo)}" disabled />
                                                    <div class="form-text">ระบบสร้างให้อัตโนมัติตอนบันทึก</div>
                                                </c:when>
                                                <c:otherwise>
                                                    <input type="text" class="form-control form-control-solid" value="${fn:escapeXml(asset.itemNo)}" disabled />
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <label for="assetStatus" class="form-label fw-semibold text-gray-700 required">สถานะ</label>
                                            <select id="assetStatus" name="status" class="form-select form-select-solid" required>
                                                <c:forEach var="s" items="${statusLabels}">
                                                    <option value="${s.key}" ${asset.status == s.key ? 'selected' : ''}><c:out value="${s.value}" /></option>
                                                </c:forEach>
                                            </select>
                                        </div>

                                        <div class="col-12">
                                            <label for="assetName" class="form-label fw-semibold text-gray-700 required">ชื่อ</label>
                                            <input type="text" id="assetName" name="name" class="form-control form-control-solid" maxlength="255" required
                                                   value="${fn:escapeXml(asset.name)}" placeholder="เช่น โต๊ะทำงาน 120 ซม." />
                                        </div>

                                        <div class="col-12 col-md-6">
                                            <label for="assetProduct" class="form-label fw-semibold text-gray-700">รุ่น (Product)</label>
                                            <select id="assetProduct" name="productId" class="form-select form-select-solid"
                                                    data-control="select2" data-placeholder="ไม่ระบุรุ่น" data-allow-clear="true">
                                                <option value=""></option>
                                                <c:forEach var="p" items="${productOptions}">
                                                    <option value="${p.id}" ${asset.productId == p.id ? 'selected' : ''}><c:out value="${p.name}" /></option>
                                                </c:forEach>
                                            </select>
                                            <div class="form-text">รุ่นจากเมนู Product ประเภท Assets</div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <label for="assetSerial" class="form-label fw-semibold text-gray-700">Serial</label>
                                            <input type="text" id="assetSerial" name="serialNo" class="form-control form-control-solid" maxlength="100"
                                                   value="${fn:escapeXml(asset.serialNo)}" />
                                        </div>

                                        <div class="col-12">
                                            <label for="assetWarehouse" class="form-label fw-semibold text-gray-700">ที่อยู่</label>
                                            <c:choose>
                                                <c:when test="${canSetLocation}">
                                                    <select id="assetWarehouse" name="warehouseId" class="form-select form-select-solid"
                                                            data-control="select2" data-placeholder="ไม่ระบุที่อยู่" data-allow-clear="true">
                                                        <option value=""></option>
                                                        <c:forEach var="w" items="${warehouseOptions}">
                                                            <option value="${w.id}" ${asset.warehouseId == w.id ? 'selected' : ''}><c:out value="${w.path}" /></option>
                                                        </c:forEach>
                                                    </select>
                                                    <div class="form-text">หลังบันทึกแล้ว การเปลี่ยนที่อยู่ต้องทำผ่านปุ่ม "ย้ายที่" เพื่อเก็บประวัติ</div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="input-group">
                                                        <input type="text" id="assetWarehouse" class="form-control form-control-solid" value="${fn:escapeXml(currentLocation)}" disabled />
                                                        <button type="button" id="assetMoveBtn" class="btn btn-light-primary"
                                                                data-id="${asset.assetId}" data-label="${fn:escapeXml(asset.itemNo)} ${fn:escapeXml(asset.name)}">
                                                            <i class="ki-duotone ki-arrow-right-left fs-3 me-1"><span class="path1"></span><span class="path2"></span></i>ย้ายที่
                                                        </button>
                                                    </div>
                                                    <div class="form-text">เปลี่ยนที่อยู่ผ่านปุ่ม "ย้ายที่" เท่านั้น เพื่อเก็บประวัติการย้าย</div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>

                                        <div class="col-12 col-md-6">
                                            <label for="assetPurchaseDate" class="form-label fw-semibold text-gray-700">วันที่ซื้อ</label>
                                            <input type="date" id="assetPurchaseDate" name="purchaseDate" class="form-control form-control-solid"
                                                   value="${fn:escapeXml(formPurchaseDate)}" />
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <label for="assetPrice" class="form-label fw-semibold text-gray-700">ราคา (บาท)</label>
                                            <input type="number" id="assetPrice" name="price" class="form-control form-control-solid" min="0" step="0.01"
                                                   value="${fn:escapeXml(formPrice)}" />
                                        </div>

                                        <div class="col-12">
                                            <label for="assetNote" class="form-label fw-semibold text-gray-700">หมายเหตุ</label>
                                            <textarea id="assetNote" name="note" class="form-control form-control-solid" rows="3" maxlength="1000"><c:out value="${asset.note}" /></textarea>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-footer d-flex flex-wrap justify-content-between gap-3">
                                    <div class="d-flex flex-wrap gap-3">
                                        <c:if test="${not isNew}">
                                            <c:choose>
                                                <c:when test="${hasMoves}">
                                                    <%-- เคยย้ายที่แล้ว: ลบไม่ได้ (เก็บประวัติไว้) ให้เปลี่ยนสถานะแทน --%>
                                                    <span class="d-inline-block" title="เคยย้ายที่แล้ว ลบไม่ได้ ให้เปลี่ยนสถานะแทน เช่น ชำรุด">
                                                        <button type="button" class="btn btn-light-danger" disabled>ลบ</button>
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <button type="button" id="assetDeleteBtn" class="btn btn-light-danger"
                                                            data-label="${fn:escapeXml(asset.itemNo)} ${fn:escapeXml(asset.name)}">ลบ</button>
                                                </c:otherwise>
                                            </c:choose>
                                            <%-- Generate QR: ลิงก์ ?c=A<asset_id> (ตัวเดียวกับที่หน้าสแกนอ่าน) label เริ่มต้น = Item No. : ชื่อ --%>
                                            <c:if test="${not empty qrLink}">
                                                <button type="button" class="btn btn-light-primary js-qr-generate"
                                                        data-qr-value="${fn:escapeXml(qrLink)}"
                                                        data-qr-label="${fn:escapeXml(asset.itemNo)} : ${fn:escapeXml(asset.name)}"
                                                        data-qr-configured="${qrLinkConfigured}">
                                                    <i class="ki-duotone ki-scan-barcode me-2"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span><span class="path7"></span><span class="path8"></span></i>Generate QR Code
                                                </button>
                                            </c:if>
                                        </c:if>
                                    </div>
                                    <div class="d-flex gap-3">
                                        <a href="${pageContext.request.contextPath}/asset_list" class="btn btn-light">ยกเลิก</a>
                                        <button type="submit" class="btn btn-primary">บันทึก</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>

                <%-- ประวัติการย้ายที่ (ล่าสุดก่อน) --%>
                <c:if test="${not isNew}">
                    <div class="card mt-6">
                        <div class="card-header">
                            <h3 class="card-title fw-bold text-gray-900">ประวัติการย้ายที่ <span class="badge badge-light ms-3"><c:out value="${fn:length(moveHistory)}" /></span></h3>
                        </div>
                        <div class="card-body">
                            <c:choose>
                                <c:when test="${hasMoves}">
                                    <div class="table-responsive">
                                        <table class="table align-middle table-row-dashed fs-6 gy-3 mb-0">
                                            <thead>
                                                <tr class="text-start text-gray-500 fw-bold fs-7 text-uppercase">
                                                    <th class="min-w-150px">วันเวลา</th>
                                                    <th class="min-w-200px">จาก</th>
                                                    <th class="min-w-200px">ไปที่</th>
                                                    <th class="min-w-125px">ผู้ย้าย</th>
                                                    <th class="min-w-150px">หมายเหตุ</th>
                                                </tr>
                                            </thead>
                                            <tbody class="text-gray-700">
                                                <c:forEach var="m" items="${moveHistory}">
                                                    <tr>
                                                        <td class="text-nowrap"><c:out value="${m.movedAt}" /></td>
                                                        <td><c:out value="${m.from}" /></td>
                                                        <td class="fw-semibold"><c:out value="${m.to}" /></td>
                                                        <td><c:out value="${m.by}" /></td>
                                                        <td><c:out value="${m.note}" /></td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="text-gray-600">ยังไม่เคยย้ายที่</div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:if>

                <c:if test="${not isNew}">
                    <form id="assetDeleteForm" method="post" action="${pageContext.request.contextPath}/asset_delete" class="d-none">
                        <input type="hidden" name="assetId" value="${asset.assetId}" />
                    </form>
                </c:if>

            </div>
        </div>
    </div>
</div>

<%-- หน้าต่าง Generate QR Code ตัวกลางที่ใช้ร่วมกับ Equipment / สินค้า / ที่เก็บ --%>
<jsp:include page="/pages-back/qr/qr_generate_modal.jsp" />

<%-- หน้าต่างย้ายที่ (ใช้ร่วมกับหน้ารายการ) --%>
<c:if test="${not isNew}">
    <jsp:include page="/pages-back/asset/asset_move_modal.jsp" />
</c:if>

<script>
    $(document).ready(function () {
        // เลือกรูป -> พรีวิวทันที (ยังไม่อัปโหลดจนกว่าจะกดบันทึก)
        $('#assetImageSelect').on('click', function () {
            $('#assetImageInput').trigger('click');
        });
        $('#assetImageInput').on('change', function () {
            var file = this.files && this.files[0];
            if (!file) {
                return;
            }
            if (!/^image\//.test(file.type)) {
                Swal.fire({ text: 'กรุณาเลือกไฟล์รูป', icon: 'error', buttonsStyling: false, customClass: { confirmButton: 'btn btn-primary' } });
                $(this).val('');
                return;
            }
            var reader = new FileReader();
            reader.onload = function (e) {
                $('#assetImagePreview').attr('src', e.target.result).removeClass('d-none');
                $('#assetImagePlaceholder').addClass('d-none');
            };
            reader.readAsDataURL(file);
        });

        // ย้ายที่: เปิดหน้าต่างกลาง ส่งสำเร็จแล้วโหลดหน้าใหม่ (ที่อยู่ + ประวัติอัปเดต)
        $('#assetMoveBtn').on('click', function () {
            AssetMove.open([$(this).attr('data-id')], 'ย้ายที่ ' + ($(this).attr('data-label') || ''));
        });

        // ลบ: ยืนยันก่อน
        $('#assetDeleteBtn').on('click', function () {
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
                    $('#assetDeleteForm').trigger('submit');
                }
            });
        });
    });
</script>
