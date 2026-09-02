<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
    <div class="d-flex flex-column flex-column-fluid">
        <div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
            <div id="kt_app_toolbar_container" class="app-container container-fluid d-flex flex-stack">
                <div class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
                    <h1 class="page-heading d-flex text-gray-700 fw-semibold my-0">Stock - Consumables</h1>
                    <ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
                        <li class="breadcrumb-item text-muted"><a href="${pageContext.request.contextPath}/demo_dashboard" class="text-muted text-hover-primary fw-medium fs-7">Home</a></li>
                        <li class="breadcrumb-item"><span class="bullet bg-gray-500 fw-medium fs-7 w-5px h-2px"></span></li>
                        <li class="breadcrumb-item text-muted fw-medium fs-7">Product</li>
                    </ul>
                </div>
            </div>
        </div>

        <div id="kt_app_content" class="app-content flex-column-fluid">
            <div id="kt_app_content_container" class="app-container container-fluid">

                <form id="stockConsAddForm" method="POST" action="stock_cons_save">
                    <div class="card">
                        <div class="card-border-radius">
                            <div class="card-body">
                                <h3 class="page-heading text-gray-900 fw-bold mb-8">Product Detail</h3>

                                <div class="row g-6">
                                    <div class="col-12 col-lg-6">
                                        <label class="form-label fw-semibold text-gray-700" for="productNo">
                                            Item ID <span class="text-danger">*</span>
                                        </label>
                                        <input type="text" id="productNo" name="productNo" required maxlength="100"
                                               class="form-control text-gray-700"
                                               value="${fn:escapeXml(param.productNo)}"
                                               placeholder="Item-C01" autocomplete="off" />
                                        <div class="invalid-feedback" id="productNoFeedback"></div>
                                    </div>

                                    <div class="col-12 col-lg-6">
                                        <label class="form-label fw-semibold text-gray-700" for="productName">
                                            Item Name <span class="text-danger">*</span>
                                        </label>
                                        <input type="text" id="productName" name="productName" required maxlength="255"
                                               class="form-control text-gray-700"
                                               value="${fn:escapeXml(param.productName)}" />
                                    </div>

                                    <div class="col-12 col-lg-6">
                                        <label class="form-label fw-semibold text-gray-700" for="productType">
                                            Item Type <span class="text-danger">*</span>
                                        </label>
                                        <%-- product_type: 1=Equipment, 2=Consumable, 3=Accessories, 4=Office Supplies (ดู skill product-module) --%>
                                        <select id="productType" name="productType" required class="form-select text-gray-700">
                                            <c:choose>
                                                <c:when test="${not empty productTypes}">
                                                    <c:forEach var="type" items="${productTypes}">
                                                        <option value="${fn:escapeXml(type.product_type)}"
                                                            <c:if test="${type.product_type eq '2'}">selected</c:if>>
                                                            ${fn:escapeXml(type.product_type_name)}
                                                        </option>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <%-- TODO: ยังไม่มีตาราง master ของ product_type --%>
                                                    <option value="1">Equipment</option>
                                                    <option value="2" selected>Consumable</option>
                                                    <option value="3">Accessories</option>
                                                    <option value="4">Office Supplies</option>
                                                </c:otherwise>
                                            </c:choose>
                                        </select>
                                    </div>

                                    <%-- แสดงเฉพาะตอน Item Type = Equipment (value '1') - คุมด้วย JS ด้านล่าง (#toggleEquipmentType) --%>
                                    <div class="col-12 col-lg-6 d-none" id="equipmentTypeWrap">
                                        <label class="form-label fw-semibold text-gray-700" for="equipmentType">
                                            Equipment Type <span class="text-danger">*</span>
                                        </label>
                                        <%-- ดึงจากตาราง equipment_type ผ่าน EquipmentTypeDAO.getall() --%>
                                        <select id="equipmentType" name="equipmentType" class="form-select text-gray-700">
                                            <option value="">- เลือก Equipment Type -</option>
                                            <c:forEach var="eqType" items="${equipmentTypes}">
                                                <option value="${fn:escapeXml(eqType.typeID)}">${fn:escapeXml(eqType.description)}</option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <div class="col-12 col-lg-6">
                                        <label class="form-label fw-semibold text-gray-700" for="icon">Product Icon</label>
                                        <%-- TODO: ตอนนี้เป็น frontend เปล่าๆ ยังไม่ผูก backend (ถอดออกชั่วคราวตาม requirement ใหม่)
                                             รายชื่อไอคอนด้านล่าง hardcode ไว้ในหน้านี้เอง ไม่ได้ผูกกับคอลัมน์ product.icon/DAO/Action ใดๆ --%>
                                        <select id="icon" name="icon" class="form-select text-gray-700" data-control="select2" data-placeholder="Select or Search Icon...">
                                            <option></option>
                                        </select>
                                    </div>

                                    <div class="col-12">
                                        <label class="form-label fw-semibold text-gray-700" for="description">Description</label>
                                        <input type="text" id="description" name="description" maxlength="255"
                                               class="form-control text-gray-700"
                                               value="${fn:escapeXml(param.description)}" />
                                    </div>
                                </div>
                            </div>

                            <div class="card-footer d-flex justify-content-end gap-3 py-6">
                                <a href="stock_cons_list" class="btn btn-light px-6 py-3 fw-bold">Cancel</a>
                                <button type="submit" class="btn btn-success px-8 py-3 fw-bold">Save</button>
                            </div>
                        </div>
                    </div>
                </form>

            </div>
        </div>
    </div>
</div>

<script>
    var CONTEXT = '${pageContext.request.contextPath}';

    // TODO: frontend เปล่าๆ ก่อน - รายชื่อไฟล์ hardcode ไว้ตรงนี้ชั่วคราว (ยังไม่ได้สแกนจาก backend/DB)
    // ไฟล์จริงอยู่ใน assets/media/product-icons/ (มี placeholder แค่ box.svg, tag.svg ตอนนี้)
    var productIconOptions = [
        { id: 'box.svg', text: 'box.svg' },
        { id: 'tag.svg', text: 'tag.svg' }
    ];

    $(document).ready(function () {
        // ---- Product Icon picker (Select2 + รูปพรีวิว) ----
        function formatProductIcon(opt) {
            if (!opt.id) { return opt.text; }
            // ตั้งใจใช้ string concatenation แทน JS template literal เพราะไฟล์นี้เป็น .jsp
            // (dollar-brace แบบ JS interpolation ในไฟล์ .jsp จะถูก JSP EL ตีความ/กลืนหายไปก่อนถึงมือ browser)
            return '<span class="d-flex align-items-center">'
                + '<img src="' + CONTEXT + '/assets/media/product-icons/' + opt.id + '" class="w-20px h-20px me-2" />'
                + '<span>' + opt.text + '</span>'
                + '</span>';
        }

        $('#icon').select2({
            data: productIconOptions,
            placeholder: 'Select or Search Icon...',
            allowClear: true,
            minimumInputLength: 0,
            escapeMarkup: function (markup) { return markup; },
            templateResult: formatProductIcon,
            templateSelection: formatProductIcon
        });


        // กันกด Save ซ้ำระหว่างรอ response
        $('#stockConsAddForm').on('submit', function (e) {
            if ($('#productNo').hasClass('is-invalid')) {
                e.preventDefault();
                $('#productNo').trigger('focus');
                return;
            }
            $(this).find('button[type="submit"]')
                   .prop('disabled', true)
                   .attr('data-kt-indicator', 'on');
        });

        // ---- เช็ค Item ID ซ้ำ ทุกครั้งที่พิมพ์ (keyup) - debounce กันยิง request ถี่เกินไป ----
        var productNoCheckTimer = null;
        var productNoCheckSeq = 0;
        $('#productNo').on('keyup', function () {
            var $input = $(this);
            var val = $input.val().trim();
            var $feedback = $('#productNoFeedback');
            clearTimeout(productNoCheckTimer);

            if (!val) {
                $input.removeClass('is-invalid')[0].setCustomValidity('');
                $feedback.text('');
                return;
            }

            productNoCheckTimer = setTimeout(function () {
                var seq = ++productNoCheckSeq;
                $.ajax({
                    url: CONTEXT + '/stock_cons_check_duplicate',
                    type: 'GET',
                    dataType: 'json',
                    data: { productNo: val },
                    success: function (res) {
                        if (seq !== productNoCheckSeq) { return; } // ผลลัพธ์เก่ามาช้า ไม่ต้องสนใจ
                        if (res && res.success === false) {
                            $input.addClass('is-invalid');
                            $input[0].setCustomValidity('duplicate');
                            $feedback.text(res.message || 'Item ID นี้มีอยู่แล้ว');
                        } else {
                            $input.removeClass('is-invalid');
                            $input[0].setCustomValidity('');
                            $feedback.text('');
                        }
                    }
                });
            }, 400);
        });

        // ---- แสดง/ซ่อน Equipment Type ตาม Item Type ----
        // product_type '1' = Equipment เท่านั้นที่ต้องเลือก Equipment Type ต่อ
        function toggleEquipmentType() {
            var isEquipment = $('#productType').val() === '1';
            $('#equipmentTypeWrap').toggleClass('d-none', !isEquipment);
            // ไม่ให้ required ค้างตอนซ่อน ไม่งั้น browser จะ block submit เงียบๆ
            $('#equipmentType').prop('required', isEquipment);
            if (!isEquipment) {
                $('#equipmentType').val('');
            }
        }

        $('#productType').on('change', toggleEquipmentType);
        toggleEquipmentType(); // เผื่อ browser จำค่า select เดิมไว้ตอน refresh
    });
</script>
