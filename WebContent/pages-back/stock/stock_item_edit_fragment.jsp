<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%--
  หน้า Settings ของ catalog item หนึ่งตัว - ใช้ร่วมกันระหว่าง Consumables กับ Equipment
  เพราะทั้งสองอ่าน/เขียนตาราง product + unit_of_measure ชุดเดียวกัน

  urlPrefix ('stock_cons' / 'stock_equ') ดูจาก product.productType ไม่ใช่จาก URL ที่เข้ามา
  เพื่อให้ปุ่ม Stock Balance ชี้ถูกหน้าเสมอ แม้จะถูก redirect มาลงผิดทาง
  (เช่น สร้าง item type Equipment จากหน้า stock_cons_add แล้วถูกส่งมาที่ stock_cons_edit)

  action ที่ตอบ JSON (stock_cons_update / stock_cons_sub_active_update / *_reorder)
  ใช้ตัวเดียวกันทั้งสองฝั่งได้เลย เพราะไม่มี redirect
--%>
<c:set var="isEquipment" value="${product.productType eq '1'}" />
<c:set var="urlPrefix" value="${isEquipment ? 'stock_equ' : 'stock_cons'}" />
<c:set var="pageTitle" value="${isEquipment ? 'Stock - Equipment' : 'Stock - Consumables'}" />

<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
    <div class="d-flex flex-column flex-column-fluid">
        <div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
            <div id="kt_app_toolbar_container" class="app-container container-fluid d-flex flex-stack">
                <div class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
                    <h1 class="page-heading d-flex text-gray-700 fw-semibold my-0">${fn:escapeXml(pageTitle)}</h1>
                    <ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
                        <li class="breadcrumb-item text-muted"><a href="${pageContext.request.contextPath}/demo_dashboard" class="text-muted text-hover-primary fw-medium fs-7">Home</a></li>
                        <li class="breadcrumb-item"><span class="bullet bg-gray-500 fw-medium fs-7 w-5px h-2px"></span></li>
                        <li class="breadcrumb-item text-muted fw-medium fs-7"><a href="${pageContext.request.contextPath}/stock_cons_list" class="text-muted text-hover-primary">Product</a></li>
                    </ul>
                </div>

                <div class="d-flex align-items-center gap-3">
                    <a href="${urlPrefix}_balance?productId=${product.productId}" class="btn btn-light d-inline-flex align-items-center px-5 py-3">
                        <i class="ki-duotone ki-package fs-3 me-2 text-gray-500"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i>
                        <span class="fw-semibold text-gray-700">Stock Balance</span>
                    </a>
                    <a href="${urlPrefix}_edit?productId=${product.productId}" class="btn btn-light-primary d-inline-flex align-items-center px-5 py-3 active">
                        <i class="ki-duotone ki-setting-2 fs-3 me-2"><span class="path1"></span><span class="path2"></span></i>
                        <span class="fw-semibold">Settings</span>
                    </a>
                </div>
            </div>
        </div>

        <div id="kt_app_content" class="app-content flex-column-fluid">
            <div id="kt_app_content_container" class="app-container container-fluid">

                <%-- ============ Product Detail ============ --%>
                <form id="stockConsEditForm" method="POST" action="stock_cons_update">
                    <input type="hidden" name="productId" value="${product.productId}" />

                    <div class="card mb-8">
                        <div class="card-border-radius">
                            <div class="card-body">
                                <div class="d-flex align-items-center justify-content-between flex-wrap gap-3 mb-8">
                                    <h3 class="page-heading text-gray-900 fw-bold mb-0">Product Detail</h3>
                                    <div class="form-check form-switch form-check-custom form-check-solid">
                                        <%-- hidden ถือค่าจริงที่ส่งไป backend (checkbox ที่ไม่ติ๊กจะไม่ถูกส่ง) --%>
                                        <input type="hidden" name="active" id="activeValue"
                                               value="${product.active eq '1' ? '1' : '0'}" />
                                        <input class="form-check-input h-25px w-45px" type="checkbox" id="activeToggle"
                                               <c:if test="${product.active eq '1'}">checked</c:if> />
                                        <label class="form-check-label fw-semibold text-gray-700" for="activeToggle">Active</label>
                                    </div>
                                </div>

                                <div class="row g-6">
                                    <div class="col-12 col-lg-6">
                                        <label class="form-label fw-semibold text-gray-700" for="productNo">
                                            Item ID <span class="text-danger">*</span>
                                        </label>
                                        <input type="text" id="productNo" name="productNo" required maxlength="100"
                                               class="form-control text-gray-700"
                                               value="${fn:escapeXml(product.productNo)}" />
                                    </div>

                                    <div class="col-12 col-lg-6">
                                        <label class="form-label fw-semibold text-gray-700" for="productName">
                                            Item Name <span class="text-danger">*</span>
                                        </label>
                                        <input type="text" id="productName" name="productName" required maxlength="255"
                                               class="form-control text-gray-700"
                                               value="${fn:escapeXml(product.productName)}" />
                                    </div>

                                    <div class="col-12 col-lg-6">
                                        <label class="form-label fw-semibold text-gray-700" for="productType">
                                            Item Type <span class="text-danger">*</span>
                                        </label>
                                        <select id="productType" name="productType" required class="form-select text-gray-700">
                                            <c:choose>
                                                <c:when test="${not empty productTypes}">
                                                    <c:forEach var="type" items="${productTypes}">
                                                        <option value="${fn:escapeXml(type.product_type)}"
                                                            <c:if test="${type.product_type eq product.productType}">selected</c:if>>
                                                            ${fn:escapeXml(type.product_type_name)}
                                                        </option>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <%-- TODO: ยังไม่มีตาราง master ของ product_type --%>
                                                    <option value="1" <c:if test="${product.productType eq '1'}">selected</c:if>>Equipment</option>
                                                    <option value="2" <c:if test="${product.productType eq '2'}">selected</c:if>>Consumables</option>
                                                    <option value="3" <c:if test="${product.productType eq '3'}">selected</c:if>>Accessories</option>
                                                </c:otherwise>
                                            </c:choose>
                                        </select>
                                    </div>

                                    <div class="col-12 col-lg-6">
                                        <label class="form-label fw-semibold text-gray-700" for="description">Description</label>
                                        <input type="text" id="description" name="description" maxlength="255"
                                               class="form-control text-gray-700"
                                               value="${fn:escapeXml(product.description)}" />
                                    </div>
                                </div>
                            </div>

                            <%-- footer จะแสดงเมื่อผู้ใช้แก้ไขค่าในช่อง input เท่านั้น (ดู JS: toggle .d-none) --%>
                            <div id="stockConsEditFooter" class="card-footer d-none justify-content-end gap-3 py-6">
                                <button type="button" id="stockConsEditCancel" class="btn btn-light px-6 py-3 fw-bold">Cancel</button>
                                <button type="submit" class="btn btn-success px-8 py-3 fw-bold">Save</button>
                            </div>
                        </div>
                    </div>

                    <%-- ============ Equipment Detail (เฉพาะ Item Type = Equipment) ============
                         นี่คือสเปค "ระดับรุ่น" (product.spec_ram/spec_ssd/...) ไม่ใช่สเปครายเครื่องจริง
                         ที่มี serial (equipment.ram/hdd/process/windows ในหน้า equipment_edit.jsp)
                         อยู่ในฟอร์มเดียวกับ Product Detail เพื่อบันทึกพร้อมกัน (stock_cons_update)
                         แสดง/ซ่อนตาม Item Type แบบ realtime ด้วย JS (#toggleEquipmentDetail) --%>
                    <div class="card mb-8 ${isEquipment ? '' : 'd-none'}" id="equipmentDetailWrap">
                        <div class="card-border-radius">
                            <div class="card-header border-0 pt-6 d-flex align-items-center justify-content-between">
                                <h3 class="page-heading text-gray-900 fw-bold mb-0">Equipment Detail</h3>
                                <div class="card-toolbar">
                                    <div class="btn btn-sm btn-icon btn-active-light-primary" data-bs-toggle="collapse" data-bs-target="#equipmentDetailBody" aria-expanded="true">
                                        <i class="ki-duotone ki-down fs-2" id="equipmentDetailChevron"><span class="path1"></span><span class="path2"></span></i>
                                    </div>
                                </div>
                            </div>
                            <div class="separator"></div>

                            <div class="collapse show" id="equipmentDetailBody">
                                <div class="card-body">
                                    <div class="row g-6">
                                        <div class="col-12 col-lg-6">
                                            <label class="form-label fw-semibold text-gray-700" for="specRam">Ram</label>
                                            <input type="text" id="specRam" name="specRam" maxlength="100"
                                                   class="form-control text-gray-700" placeholder="เช่น 16GB"
                                                   value="${fn:escapeXml(product.specRam)}" />
                                        </div>
                                        <div class="col-12 col-lg-6">
                                            <label class="form-label fw-semibold text-gray-700" for="specSsd">SSD</label>
                                            <input type="text" id="specSsd" name="specSsd" maxlength="100"
                                                   class="form-control text-gray-700" placeholder="เช่น 512GB"
                                                   value="${fn:escapeXml(product.specSsd)}" />
                                        </div>
                                        <div class="col-12 col-lg-6">
                                            <label class="form-label fw-semibold text-gray-700" for="specProcess">Process (CPU)</label>
                                            <input type="text" id="specProcess" name="specProcess" maxlength="100"
                                                   class="form-control text-gray-700" placeholder="เช่น Intel Core i5"
                                                   value="${fn:escapeXml(product.specProcess)}" />
                                        </div>
                                        <div class="col-12 col-lg-6">
                                            <label class="form-label fw-semibold text-gray-700" for="specWindows">Windows</label>
                                            <input type="text" id="specWindows" name="specWindows" maxlength="100"
                                                   class="form-control text-gray-700" placeholder="เช่น Windows 11 Pro"
                                                   value="${fn:escapeXml(product.specWindows)}" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>

                <%-- ============ Unit of Measure (UOM) ============ --%>
                <div class="card mb-8">
                    <div class="card-border-radius">
                        <div class="card-header border-0 pt-6">
                            <h3 class="page-heading text-gray-900 fw-bold mb-0">Unit of Measure (UOM)</h3>
                        </div>
                        <div class="separator"></div>

                        <div class="card-body">
                            <div class="d-flex justify-content-end mb-6">
                                <button type="button" class="btn btn-success d-inline-flex align-items-center px-6 py-3"
                                        data-bs-toggle="modal" data-bs-target="#uomCreateModal">
                                    <i class="ki-duotone ki-plus fs-3 me-2"><span class="path1"></span><span class="path2"></span></i>
                                    <span class="fw-bold">Create</span>
                                </button>
                            </div>

                            <table id="uomTable" class="table align-middle fs-6 mb-0">
                                <thead class="fs-7 text-gray-500 text-uppercase">
                                    <tr class="fw-semibold">
                                        <th class="min-w-120px text-nowrap">Sequence</th>
                                        <th class="min-w-200px text-nowrap">Unit Name</th>
                                        <th class="min-w-150px text-nowrap">Conversion Rate</th>
                                        <th class="min-w-250px text-nowrap">Description</th>
                                        <th class="min-w-120px text-nowrap text-end">Action</th>
                                    </tr>
                                </thead>
                                <tbody id="uomTableBody">
                                    <c:forEach var="uom" items="${units}">
                                        <tr data-id="${uom.unitId}"
                                            data-sequence="${fn:escapeXml(uom.sequence)}"
                                            data-unit-name="${fn:escapeXml(uom.unitName)}"
                                            data-conversion-rate="${fn:escapeXml(uom.conversionRate)}"
                                            data-description="${fn:escapeXml(uom.description)}">
                                            <td class="text-gray-900 fw-bold">
                                                <i class="ki-duotone ki-maximize fs-4 text-gray-400 me-3 uom-drag-handle" style="cursor: grab;"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i>
                                                <span class="uom-seq">${fn:escapeXml(uom.sequence)}</span>
                                            </td>
                                            <td class="text-gray-700 fw-normal">${fn:escapeXml(uom.unitName)}</td>
                                            <td class="text-gray-700 fw-normal">
                                                <c:choose>
                                                    <c:when test="${not empty uom.conversionRate}">${fn:escapeXml(uom.conversionRate)}</c:when>
                                                    <c:otherwise><span class="text-muted">-</span></c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="text-gray-700 fw-normal">
                                                <c:choose>
                                                    <c:when test="${not empty uom.description}">${fn:escapeXml(uom.description)}</c:when>
                                                    <c:otherwise><span class="text-muted">-</span></c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="text-end text-nowrap">
                                                <button type="button" class="btn btn-icon btn-sm btn-light-primary me-1 btn-edit-uom" title="Edit">
                                                    <i class="ki-duotone ki-pencil fs-3"><span class="path1"></span><span class="path2"></span></i>
                                                </button>
                                                <button type="button" class="btn btn-icon btn-sm btn-light-danger btn-delete-uom"
                                                        data-id="${uom.unitId}" data-name="${fn:escapeXml(uom.unitName)}" title="Delete">
                                                    <i class="ki-duotone ki-trash fs-3">
                                                        <span class="path1"></span><span class="path2"></span>
                                                        <span class="path3"></span><span class="path4"></span><span class="path5"></span>
                                                    </i>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <%-- Sub product card ซ่อนทั้งใบสำหรับ Equipment - รายละเอียดรายเครื่องเก็บที่ตาราง equipment แทน --%>
                <c:if test="${not isEquipment}">
                <%-- ============ Sub product ============ --%>
                <div class="card">
                    <div class="card-border-radius">
                        <div class="card-header border-0 pt-6 d-flex align-items-center justify-content-between">
                            <h3 class="page-heading text-gray-900 fw-bold mb-0">Sub product</h3>
                            <%-- ผูกกับ product.sub_product_active - บันทึกทันทีผ่าน AJAX (stock_cons_sub_active_update) --%>
                            <div class="form-check form-switch form-check-custom form-check-solid">
                                <input class="form-check-input h-25px w-45px" type="checkbox" id="subProductActiveToggle"
                                       data-product-id="${product.productId}"
                                       <c:if test="${product.subProductActive eq '1'}">checked</c:if> />
                                <label class="form-check-label fw-semibold text-gray-700" for="subProductActiveToggle">Active</label>
                            </div>
                        </div>
                        <div class="separator"></div>

                        <div class="card-body">
                            <div class="d-flex justify-content-end mb-6">
                                <button type="button" class="btn btn-success d-inline-flex align-items-center px-6 py-3"
                                        data-bs-toggle="modal" data-bs-target="#subCreateModal">
                                    <i class="ki-duotone ki-plus fs-3 me-2"><span class="path1"></span><span class="path2"></span></i>
                                    <span class="fw-bold">Create</span>
                                </button>
                            </div>

                            <table id="subProductTable" class="table align-middle fs-6 mb-0">
                                <thead class="fs-7 text-gray-500 text-uppercase">
                                    <tr class="fw-semibold">
                                        <th class="w-40px"></th>
                                        <th class="min-w-100px text-nowrap">Sequence</th>
                                        <th class="min-w-250px text-nowrap">Sub Product ID</th>
                                        <th class="min-w-200px text-nowrap">Sub Product Name</th>
                                        <th class="min-w-250px text-nowrap">Description</th>
                                        <th class="min-w-120px text-nowrap text-end">Action</th>
                                    </tr>
                                </thead>
                                <tbody id="subTableBody">
                                    <c:forEach var="sub" items="${subProducts}">
                                        <tr data-id="${sub.productId}"
                                            data-product-no="${fn:escapeXml(sub.productNo)}"
                                            data-product-name="${fn:escapeXml(sub.productName)}"
                                            data-description="${fn:escapeXml(sub.description)}">
                                            <td class="text-center">
                                                <i class="ki-duotone ki-maximize fs-4 text-gray-400 sub-drag-handle" style="cursor: grab;"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i>
                                            </td>
                                            <td class="text-gray-900 fw-bold"><span class="sub-seq">${fn:escapeXml(sub.sequence)}</span></td>
                                            <td class="text-gray-900 fw-bold">${fn:escapeXml(sub.productNo)}</td>
                                            <td class="text-gray-700 fw-normal">${fn:escapeXml(sub.productName)}</td>
                                            <td class="text-gray-700 fw-normal">
                                                <c:choose>
                                                    <c:when test="${not empty sub.description}">${fn:escapeXml(sub.description)}</c:when>
                                                    <c:otherwise><span class="text-muted">-</span></c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="text-end text-nowrap">
                                                <button type="button" class="btn btn-icon btn-sm btn-light-primary me-1 btn-edit-sub" title="Edit">
                                                    <i class="ki-duotone ki-pencil fs-3"><span class="path1"></span><span class="path2"></span></i>
                                                </button>
                                                <button type="button" class="btn btn-icon btn-sm btn-light-danger btn-delete-sub"
                                                        data-id="${sub.productId}" data-name="${fn:escapeXml(sub.productName)}" title="Delete">
                                                    <i class="ki-duotone ki-trash fs-3">
                                                        <span class="path1"></span><span class="path2"></span>
                                                        <span class="path3"></span><span class="path4"></span><span class="path5"></span>
                                                    </i>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                </c:if>

                <%-- ปุ่ม Back กลับไปหน้ารายการ Product --%>
                <div class="d-flex justify-content-start mt-8">
                    <a href="stock_cons_list" class="btn btn-light d-inline-flex align-items-center px-6 py-3">
                        <i class="ki-duotone ki-arrow-left fs-3 me-2"><span class="path1"></span><span class="path2"></span></i>
                        <span class="fw-bold text-gray-700">Back</span>
                    </a>
                </div>

            </div>
        </div>
    </div>
</div>

<%-- ============ Modal: Create Unit of Measure ============ --%>
<div class="modal fade" id="uomCreateModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered mw-600px">
        <div class="modal-content">
            <form id="uomCreateForm" method="POST" action="${urlPrefix}_uom_add" class="form">
                <input type="hidden" name="productId" value="${product.productId}" />

                <div class="modal-header">
                    <h3 class="modal-title fw-bold text-gray-900">Create Unit of Measure</h3>
                    <button type="button" class="btn btn-icon btn-sm btn-active-light-primary" data-bs-dismiss="modal" aria-label="Close">
                        <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                    </button>
                </div>

                <div class="modal-body">
                    <div class="row g-5">
                        <div class="col-12 col-md-6">
                            <label class="form-label fw-semibold text-gray-700" for="uomSequence">
                                Sequence <span class="text-danger">*</span>
                            </label>
                            <input type="number" min="0" step="1" id="uomSequence" name="sequence" required
                                   class="form-control text-gray-700" placeholder="0" />
                        </div>
                        <div class="col-12 col-md-6">
                            <label class="form-label fw-semibold text-gray-700" for="uomUnitName">
                                Unit Name <span class="text-danger">*</span>
                            </label>
                            <input type="text" id="uomUnitName" name="unitName" required maxlength="100"
                                   class="form-control text-gray-700" />
                        </div>
                        <div class="col-12 col-md-6">
                            <label class="form-label fw-semibold text-gray-700" for="uomConversionRate">
                                Conversion Rate <span class="text-danger">*</span>
                            </label>
                            <input type="number" min="1" step="1" value="1" id="uomConversionRate" name="conversionRate" required
                                   class="form-control text-gray-700" />
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-semibold text-gray-700" for="uomDescription">Description</label>
                            <input type="text" id="uomDescription" name="description" maxlength="255"
                                   class="form-control text-gray-700" />
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-success">Save</button>
                </div>
            </form>
        </div>
    </div>
</div>

<%-- ============ Modal: Edit Unit of Measure ============ --%>
<div class="modal fade" id="uomEditModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered mw-600px">
        <div class="modal-content">
            <form id="uomEditForm" method="POST" action="${urlPrefix}_uom_edit" class="form">
                <input type="hidden" name="productId" value="${product.productId}" />
                <input type="hidden" name="unitId" id="editUomUnitId" />

                <div class="modal-header">
                    <h3 class="modal-title fw-bold text-gray-900">Edit Unit of Measure</h3>
                    <button type="button" class="btn btn-icon btn-sm btn-active-light-primary" data-bs-dismiss="modal" aria-label="Close">
                        <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                    </button>
                </div>

                <div class="modal-body">
                    <div class="row g-5">
                        <div class="col-12 col-md-6">
                            <label class="form-label fw-semibold text-gray-700" for="editUomSequence">
                                Sequence <span class="text-danger">*</span>
                            </label>
                            <input type="number" min="0" step="1" id="editUomSequence" name="sequence" required
                                   class="form-control text-gray-700" />
                        </div>
                        <div class="col-12 col-md-6">
                            <label class="form-label fw-semibold text-gray-700" for="editUomUnitName">
                                Unit Name <span class="text-danger">*</span>
                            </label>
                            <input type="text" id="editUomUnitName" name="unitName" required maxlength="100"
                                   class="form-control text-gray-700" />
                        </div>
                        <div class="col-12 col-md-6">
                            <label class="form-label fw-semibold text-gray-700" for="editUomConversionRate">
                                Conversion Rate <span class="text-danger">*</span>
                            </label>
                            <input type="number" min="1" step="1" id="editUomConversionRate" name="conversionRate" required
                                   class="form-control text-gray-700" />
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-semibold text-gray-700" for="editUomDescription">Description</label>
                            <input type="text" id="editUomDescription" name="description" maxlength="255"
                                   class="form-control text-gray-700" />
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-success">Save</button>
                </div>
            </form>
        </div>
    </div>
</div>

<c:if test="${not isEquipment}">
<%-- ทั้งสอง modal นี้เปิดจากปุ่มใน Sub product card ด้านบน ซ่อนคู่กันตามเงื่อนไขเดียวกัน --%>
<%-- ============ Modal: Create Sub product ============ --%>
<div class="modal fade" id="subCreateModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered mw-600px">
        <div class="modal-content">
            <form id="subCreateForm" method="POST" action="${urlPrefix}_sub_add" class="form">
                <%-- parentProductId คือ product ตัวแม่ที่กำลังแก้ไขอยู่ --%>
                <input type="hidden" name="parentProductId" value="${product.productId}" />

                <div class="modal-header">
                    <h3 class="modal-title fw-bold text-gray-900">Create Sub product</h3>
                    <button type="button" class="btn btn-icon btn-sm btn-active-light-primary" data-bs-dismiss="modal" aria-label="Close">
                        <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                    </button>
                </div>

                <div class="modal-body">
                    <div class="row g-5">
                        <div class="col-12 col-md-6">
                            <label class="form-label fw-semibold text-gray-700" for="subProductNo">
                                Sub Product ID <span class="text-danger">*</span>
                            </label>
                            <input type="text" id="subProductNo" name="productNo" required maxlength="100"
                                   class="form-control text-gray-700" />
                        </div>
                        <div class="col-12 col-md-6">
                            <label class="form-label fw-semibold text-gray-700" for="subProductName">
                                Sub Product Name <span class="text-danger">*</span>
                            </label>
                            <input type="text" id="subProductName" name="productName" required maxlength="255"
                                   class="form-control text-gray-700" />
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-semibold text-gray-700" for="subDescription">Description</label>
                            <input type="text" id="subDescription" name="description" maxlength="255"
                                   class="form-control text-gray-700" />
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-success">Save</button>
                </div>
            </form>
        </div>
    </div>
</div>

<%-- ============ Modal: Edit Sub product ============ --%>
<div class="modal fade" id="subEditModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered mw-600px">
        <div class="modal-content">
            <form id="subEditForm" method="POST" action="${urlPrefix}_sub_edit" class="form">
                <input type="hidden" name="parentProductId" value="${product.productId}" />
                <input type="hidden" name="subProductId" id="editSubProductId" />

                <div class="modal-header">
                    <h3 class="modal-title fw-bold text-gray-900">Edit Sub product</h3>
                    <button type="button" class="btn btn-icon btn-sm btn-active-light-primary" data-bs-dismiss="modal" aria-label="Close">
                        <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                    </button>
                </div>

                <div class="modal-body">
                    <div class="row g-5">
                        <div class="col-12 col-md-6">
                            <label class="form-label fw-semibold text-gray-700" for="editSubProductNo">
                                Sub Product ID <span class="text-danger">*</span>
                            </label>
                            <input type="text" id="editSubProductNo" name="productNo" required maxlength="100"
                                   class="form-control text-gray-700" />
                        </div>
                        <div class="col-12 col-md-6">
                            <label class="form-label fw-semibold text-gray-700" for="editSubProductName">
                                Sub Product Name <span class="text-danger">*</span>
                            </label>
                            <input type="text" id="editSubProductName" name="productName" required maxlength="255"
                                   class="form-control text-gray-700" />
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-semibold text-gray-700" for="editSubDescription">Description</label>
                            <input type="text" id="editSubDescription" name="description" maxlength="255"
                                   class="form-control text-gray-700" />
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-success">Save</button>
                </div>
            </form>
        </div>
    </div>
</div>
</c:if>

<script src="https://cdn.jsdelivr.net/npm/sortablejs@latest/Sortable.min.js"></script>
<script>
    $(document).ready(function () {
        // NOTE: ตาราง UOM / Sub product ไม่ใช้ DataTables เพราะชนกับ SortableJS (การจัดลำดับแถว)
        //       ทั้งสองเป็นตารางลูกที่มีไม่กี่แถว จึงไม่จำเป็นต้องมี paging/search

        var CONTEXT = '${pageContext.request.contextPath}';
        var PRODUCT_ID = '${product.productId}';
        // prefix ของ action ที่ต้อง redirect กลับหน้านี้ (stock_cons / stock_equ)
        var URL_PREFIX = '${urlPrefix}';

        function notifyError(msg) {
            if (window.Swal) {
                Swal.fire('Error', msg || 'เกิดข้อผิดพลาด', 'error');
            } else {
                alert(msg || 'เกิดข้อผิดพลาด');
            }
        }

        // ยิงฟอร์ม POST แบบ dynamic (ใช้กับ delete) - POST กัน prefetch/crawler ลบข้อมูล
        function submitPost(action, params) {
            var $form = $('<form>', { method: 'POST', action: action }).appendTo('body');
            $.each(params, function (key, value) {
                $form.append($('<input>', { type: 'hidden', name: key, value: value }));
            });
            $form.submit();
        }

        // ---- แสดงปุ่ม Cancel/Save เฉพาะเมื่อมีการแก้ไขค่าในฟอร์ม Product Detail ----
        var $editForm = $('#stockConsEditForm');
        var $editFooter = $('#stockConsEditFooter');

        // ---- Equipment Detail: แสดง/ซ่อนตาม Item Type แบบ realtime (เหมือน stock_cons_add.jsp) ----
        // ต้อง sync ก่อนจับ initialState ด้านล่าง ไม่งั้นถ้าเปิดหน้ามาด้วย type ที่ไม่ใช่ Equipment
        // แต่ DB ยังมีค่า spec ค้างอยู่ (เช่น เคยเป็น Equipment มาก่อนแล้วเปลี่ยน type) การ clear ค่า
        // ตรงนี้จะไปเกิด "หลัง" initialState ถูกจับไปแล้ว ทำให้ปุ่ม Cancel/Save โผล่มาเองทั้งที่ผู้ใช้ยังไม่ได้แก้อะไร
        function toggleEquipmentDetail() {
            var isEquipmentNow = $('#productType').val() === '1';
            $('#equipmentDetailWrap').toggleClass('d-none', !isEquipmentNow);
            if (!isEquipmentNow) {
                // เคลียร์ค่าเมื่อสลับออกจาก Equipment กันสเปคเก่าติดไปกับ item type อื่นโดยไม่ตั้งใจ
                $('#specRam, #specSsd, #specProcess, #specWindows').val('');
            }
        }
        toggleEquipmentDetail(); // sync สถานะเริ่มต้นเผื่อ browser จำค่า select เดิมไว้ตอน refresh

        // เก็บค่าตั้งต้นของทุก field ไว้เทียบว่ามีการแก้จริงไหม (กันกรณีพิมพ์แล้วลบกลับเป็นค่าเดิม)
        var initialState = $editForm.serialize();

        function refreshEditFooter() {
            var dirty = $editForm.serialize() !== initialState;
            $editFooter.toggleClass('d-none', !dirty).toggleClass('d-flex', dirty);
        }

        $editForm.on('input change', 'input, select, textarea', refreshEditFooter);

        // refreshEditFooter ถูกเรียกอยู่แล้วจาก delegated 'change' handler ด้านบน ไม่ต้องผูกซ้ำที่นี่
        $('#productType').on('change', toggleEquipmentDetail);

        // ---- Equipment Detail: สลับไอคอนตอนกดย่อ/ขยาย ----
        $('#equipmentDetailBody').on('show.bs.collapse', function () {
            $('#equipmentDetailChevron').removeClass('ki-down').addClass('ki-up');
        });
        $('#equipmentDetailBody').on('hide.bs.collapse', function () {
            $('#equipmentDetailChevron').removeClass('ki-up').addClass('ki-down');
        });

        // toggle Active: sync ค่าเข้า hidden ก่อน แล้วค่อยเช็ค dirty (serialize อ่านจาก hidden)
        $('#activeToggle').on('change', function () {
            $('#activeValue').val(this.checked ? '1' : '0');
            refreshEditFooter();
        });

        // กดCancel: คืนค่าเดิมทั้งฟอร์มแล้วซ่อน footer (ไม่ต้องโหลดหน้าใหม่)
        $('#stockConsEditCancel').on('click', function () {
            $editForm[0].reset();
            // reset คืนค่า checkbox แต่ไม่คืน hidden -> sync ตามสถานะ checkbox หลัง reset
            $('#activeValue').val($('#activeToggle').is(':checked') ? '1' : '0');
            // reset คืนค่า <select> ให้แล้ว แต่ .d-none ของการ์ด Equipment Detail เป็น class ที่ตั้งเอง
            // ต้อง sync ใหม่เอง ไม่งั้นถ้าเพิ่งสลับ Item Type ค้างไว้ การ์ดจะไม่โผล่กลับมาตามค่าที่ reset แล้ว
            toggleEquipmentDetail();
            refreshEditFooter();
        });

        // กันกด Save ซ้ำระหว่างรอ response (เฉพาะ modal ที่ยัง submit แบบ redirect ปกติ)
        $('#uomCreateForm, #uomEditForm, #subCreateForm, #subEditForm').on('submit', function () {
            $(this).find('button[type="submit"]')
                   .prop('disabled', true)
                   .attr('data-kt-indicator', 'on');
        });

        // ---- บันทึก Product Detail แบบ AJAX เพื่อโชว์ SweetAlert โดยไม่ reload ----
        $editForm.on('submit', function (e) {
            e.preventDefault();
            var formEl = this;
            // เคารพ required/validity ฝั่ง client ก่อน
            if (formEl.checkValidity && !formEl.checkValidity()) {
                if (formEl.reportValidity) { formEl.reportValidity(); }
                return;
            }
            var $btn = $editForm.find('button[type="submit"]');
            $btn.prop('disabled', true).attr('data-kt-indicator', 'on');

            $.ajax({
                url: CONTEXT + '/stock_cons_update',
                type: 'POST',
                dataType: 'json',
                data: $editForm.serialize(),
                success: function (res) {
                    if (res && res.success === true) {
                        // ตั้งค่าตั้งต้นใหม่ = ค่าปัจจุบัน แล้วซ่อน footer (ไม่ dirty อีก)
                        initialState = $editForm.serialize();
                        refreshEditFooter();
                        notifySuccess('อัพเดทข้อมูลสำเร็จแล้ว');
                    } else {
                        notifyError(res && res.message ? res.message : 'อัพเดทข้อมูลไม่สำเร็จ');
                    }
                },
                error: function () {
                    notifyError('อัพเดทข้อมูลไม่สำเร็จ');
                },
                complete: function () {
                    $btn.prop('disabled', false).removeAttr('data-kt-indicator');
                }
            });
        });

        // ==================== Sub product active toggle (AJAX) ====================
        $('#subProductActiveToggle').on('change', function () {
            var $toggle = $(this);
            var checked = $toggle.is(':checked');
            $toggle.prop('disabled', true);

            $.ajax({
                url: CONTEXT + '/stock_cons_sub_active_update',
                type: 'POST',
                dataType: 'json',
                data: { productId: PRODUCT_ID, subProductActive: checked ? '1' : '0' },
                success: function (res) {
                    if (!res || res.success !== true) {
                        $toggle.prop('checked', !checked); // rollback
                        notifyError(res && res.message ? res.message : 'บันทึกสถานะไม่สำเร็จ');
                    }
                },
                error: function () {
                    $toggle.prop('checked', !checked); // rollback เมื่อเน็ต/เซิร์ฟเวอร์พลาด
                    notifyError('บันทึกสถานะไม่สำเร็จ');
                },
                complete: function () {
                    $toggle.prop('disabled', false);
                }
            });
        });

        // ==================== UOM: edit / delete ====================
        $('#uomTableBody').on('click', '.btn-edit-uom', function () {
            var $row = $(this).closest('tr');
            $('#editUomUnitId').val($row.data('id'));
            $('#editUomSequence').val($row.data('sequence'));
            $('#editUomUnitName').val($row.data('unit-name'));
            $('#editUomConversionRate').val($row.data('conversion-rate'));
            $('#editUomDescription').val($row.data('description'));
            bootstrap.Modal.getOrCreateInstance(document.getElementById('uomEditModal')).show();
        });

        $('#uomTableBody').on('click', '.btn-delete-uom', function () {
            var name = $(this).data('name') || '';
            var id = $(this).data('id');
            if (!id) { return; }
            if (!confirm('ต้องการลบหน่วย "' + name + '" ใช่หรือไม่?')) { return; }
            submitPost(URL_PREFIX + '_uom_delete', { unitId: id, productId: PRODUCT_ID });
        });

        // ==================== Sub product: edit / delete ====================
        $('#subTableBody').on('click', '.btn-edit-sub', function () {
            var $row = $(this).closest('tr');
            $('#editSubProductId').val($row.data('id'));
            $('#editSubProductNo').val($row.data('product-no'));
            $('#editSubProductName').val($row.data('product-name'));
            $('#editSubDescription').val($row.data('description'));
            bootstrap.Modal.getOrCreateInstance(document.getElementById('subEditModal')).show();
        });

        $('#subTableBody').on('click', '.btn-delete-sub', function () {
            var name = $(this).data('name') || '';
            var id = $(this).data('id');
            if (!id) { return; }
            if (!confirm('ต้องการลบ sub product "' + name + '" ใช่หรือไม่?')) { return; }
            submitPost(URL_PREFIX + '_sub_delete', { subProductId: id, parentProductId: PRODUCT_ID });
        });

        // ==================== Reorder ด้วย SortableJS ====================
        // ส่งลำดับ id (คั่น comma) ไป backend แล้ว backend รัน sequence ใหม่ 0..n
        // toast แจ้งผลสำเร็จมุมขวาบน (ถ้าไม่มี Swal ก็ข้ามไปเงียบๆ)
        function notifySuccess(msg) {
            if (window.Swal) {
                Swal.fire({
                    toast: true,
                    position: 'top-end',
                    icon: 'success',
                    title: msg || 'บันทึกลำดับใหม่แล้ว',
                    showConfirmButton: false,
                    timer: 1800,
                    timerProgressBar: true
                });
            }
        }

        function initSortable(tbodyId, handleClass, reorderUrl, extraData) {
            var el = document.getElementById(tbodyId);
            if (!el || typeof Sortable === 'undefined') { return; }

            Sortable.create(el, {
                handle: handleClass,
                animation: 150,
                ghostClass: 'bg-light-primary',
                onEnd: function (evt) {
                    // ไม่ได้ขยับตำแหน่งจริง -> ไม่ต้องทำอะไร
                    if (evt.oldIndex === evt.newIndex) { return; }

                    var ids = [];
                    $('#' + tbodyId + ' tr').each(function () {
                        ids.push($(this).data('id'));
                    });

                    var saveOrder = function () {
                        $.ajax({
                            url: CONTEXT + '/' + reorderUrl,
                            type: 'POST',
                            dataType: 'json',
                            data: $.extend({ orderedIds: ids.join(',') }, extraData),
                            success: function (res) {
                                if (res && res.success === true) {
                                    // อัปเดตเลข sequence ที่โชว์ (UOM ใช้ .uom-seq, Sub product ใช้ .sub-seq)
                                    $('#' + tbodyId + ' tr').each(function (index) {
                                        $(this).find('.uom-seq, .sub-seq').text(index);
                                        $(this).attr('data-sequence', index);
                                    });
                                    notifySuccess('เปลี่ยนตำแหน่งเรียบร้อยแล้ว');
                                } else {
                                    notifyError('จัดลำดับไม่สำเร็จ');
                                    window.location.reload();
                                }
                            },
                            error: function () {
                                notifyError('จัดลำดับไม่สำเร็จ');
                                window.location.reload();
                            }
                        });
                    };

                    // ยืนยันก่อนบันทึก - ถ้ายกเลิกให้คืนลำดับเดิม (reload)
                    if (window.Swal) {
                        Swal.fire({
                            title: 'ยืนยันการเปลี่ยนตำแหน่ง?',
                            text: 'ระบบจะบันทึกลำดับใหม่ของรายการนี้',
                            icon: 'question',
                            showCancelButton: true,
                            confirmButtonText: 'ยืนยัน',
                            cancelButtonText: 'ยกเลิก',
                            reverseButtons: true
                        }).then(function (result) {
                            if (result.isConfirmed) {
                                saveOrder();
                            } else {
                                window.location.reload();
                            }
                        });
                    } else {
                        if (confirm('ยืนยันการเปลี่ยนตำแหน่ง?')) {
                            saveOrder();
                        } else {
                            window.location.reload();
                        }
                    }
                }
            });
        }

        initSortable('uomTableBody', '.uom-drag-handle', 'stock_cons_uom_reorder', { productId: PRODUCT_ID });
        initSortable('subTableBody', '.sub-drag-handle', 'stock_cons_sub_reorder', { parentProductId: PRODUCT_ID });
    });
</script>
