<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%--
  หน้า Settings ของ catalog item หนึ่งตัว - ใช้ร่วมกันระหว่าง Consumables กับ Equipment
  เพราะทั้งสองอ่าน/เขียนตาราง product + unit_of_measure ชุดเดียวกัน

  urlPrefix ('product' / 'stock_equ') ดูจาก product.productType ไม่ใช่จาก URL ที่เข้ามา
  เพื่อให้ปุ่ม _edit/_uom_*/_sub_* ชี้ถูกหน้าเสมอ แม้จะถูก redirect มาลงผิดทาง
  (เช่น สร้าง item type Equipment จากหน้า product_add แล้วถูกส่งมาที่ product_edit)

  balanceUrl แยกออกมาต่างหากจาก urlPrefix เพราะฝั่ง Consumables action ของหน้า Stock Balance
  ชื่อ "stock_balance" (ไม่ใช่ "product_balance") ในขณะที่ฝั่ง Equipment ยังเป็น "stock_equ_balance" อยู่
  - prefix เดียวกันแทนไม่ได้เหมือน _edit/_uom_*/_sub_* จึงต้องมีตัวแปรของตัวเอง

  action ที่ตอบ JSON (product_update / product_sub_active_update / *_reorder)
  ใช้ตัวเดียวกันทั้งสองฝั่งได้เลย เพราะไม่มี redirect
--%>
<c:set var="isEquipment" value="${product.productType eq '1'}" />
<c:set var="urlPrefix" value="${isEquipment ? 'stock_equ' : 'product'}" />
<c:set var="balanceUrl" value="${isEquipment ? 'stock_equ_balance' : 'stock_balance'}" />
<c:set var="pageTitle" value="${isEquipment ? 'Stock - Equipment' : 'Stock - Consumables'}" />

<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
    <div class="d-flex flex-column flex-column-fluid">
        <div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
            <div id="kt_app_toolbar_container" class="app-container container-fluid d-flex flex-stack">
                <div class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
                    <h1 class="page-heading d-flex text-gray-700 fw-semibold my-0">${fn:escapeXml(pageTitle)}</h1>
                    <ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
                        <li class="breadcrumb-item text-muted"><a href="${pageContext.request.contextPath}/check_in_out" class="text-muted text-hover-primary fw-medium fs-7">Home</a></li>
                        <li class="breadcrumb-item"><span class="bullet bg-gray-500 fw-medium fs-7 w-5px h-2px"></span></li>
                        <li class="breadcrumb-item text-muted fw-medium fs-7"><a href="${pageContext.request.contextPath}/product_list" class="text-muted text-hover-primary">Product</a></li>
                    </ul>
                </div>

                <div class="d-flex align-items-center gap-3">
                    <a href="${urlPrefix}_edit?productId=${product.productId}" class="btn btn-light-primary d-inline-flex align-items-center px-5 py-3 active">
                        <i class="ki-duotone ki-setting-2 fs-3 me-2"><span class="path1"></span><span class="path2"></span></i>
                        <span class="fw-semibold">Product</span>
                    </a>
                    <!-- <a href="${pageContext.request.contextPath}/stock_by_product_list" class="btn btn-light d-inline-flex align-items-center px-5 py-3">
                        <i class="ki-duotone ki-barcode fs-3 me-2 text-gray-500">
                            <span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span>
                            <span class="path5"></span><span class="path6"></span><span class="path7"></span><span class="path8"></span>
                        </i>
                        <span class="fw-semibold text-gray-700">Stock By Product</span>
                    </a> -->
                    <!-- <a href="${pageContext.request.contextPath}/stock_by_location_list" class="btn btn-light d-inline-flex align-items-center px-5 py-3">
                        <i class="ki-duotone ki-home-2 fs-3 me-2 text-gray-500"><span class="path1"></span><span class="path2"></span></i>
                        <span class="fw-semibold text-gray-700">Stock By Location</span>
                    </a> -->
                    <a href="${balanceUrl}?productId=${product.productId}" class="btn btn-light d-inline-flex align-items-center px-5 py-3">
                        <i class="ki-duotone ki-cube-2 fs-3 me-2 text-gray-500"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i>
                        <span class="fw-semibold text-gray-700">Stock Balance</span>
                    </a>
                </div>
            </div>
        </div>

        <div id="kt_app_content" class="app-content flex-column-fluid">
            <div id="kt_app_content_container" class="app-container container-fluid">

                <%-- ============ Product Detail ============ --%>
                <form id="stockConsEditForm" method="POST" action="product_update" enctype="multipart/form-data">
                    <input type="hidden" name="productId" value="${product.productId}" />

                    <div class="row g-5 g-xl-10">
                        <div class="col-xl-8">
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
                                                       value="${fn:escapeXml(product.productNo)}" autocomplete="off" />
                                                <div class="invalid-feedback" id="productNoFeedback"></div>
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
                                                            <option value="4" <c:if test="${product.productType eq '4'}">selected</c:if>>Office Supplies</option>
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
                                                        <option value="${fn:escapeXml(eqType.typeID)}"
                                                            <c:if test="${eqType.typeID eq product.equipmentType}">selected</c:if>>${fn:escapeXml(eqType.description)}</option>
                                                    </c:forEach>
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
                                </div>
                            </div>

                            <%-- footer จะแสดงเมื่อผู้ใช้แก้ไขค่าในช่อง input เท่านั้น (ดู JS: toggle .d-none/.d-flex)
                                 ย้ายไปอยู่เป็น col-12 แยกต่างหากท้าย row แล้ว (ดูด้านล่าง หลัง col-xl-4)
                                 เพราะเดิมเป็นลูกตรงของ row โดยไม่มี col-* ห่อ ทำให้โดน negative margin ของ Bootstrap
                                 row ดึงเยื้องไม่ตรงแนวกับการ์ดด้านบน - เก็บโค้ดสำรองไว้เผื่อดึงกลับมาใช้ --%>
                            <!-- <div id="stockConsEditFooter" class="d-none justify-content-end gap-3 mt-3 pt-6 border-top border-gray-300">
                                <button type="button" id="stockConsEditCancel" class="btn btn-light px-6 py-3 fw-bold">Cancel</button>
                                <button type="submit" class="btn btn-success px-8 py-3 fw-bold">Save</button>
                            </div> -->
                        </div>

                        <div class="col-xl-4">
                            <%-- ============ Product Image ============
                                 การ์ดแยกต่างหาก สไตล์เดียวกับการ์ด "Cover Photo" ใน announcement_add.jsp
                                 (card-header/card-body ตรงกลาง/card-footer) ยังอยู่ใน form เดิม เพราะ productImage
                                 ต้อง submit ไปพร้อมกับ Product Detail ทีเดียว --%>
                            <div class="card mb-8">
                                <div class="card-header pt-5 flex-column align-items-start">
                                    <h3 class="card-title fw-semibold text-gray-900 mb-1">Product Image</h3>
                                </div>
                                <div id="productImageErrorMsg" class="text-center text-danger"></div>
                                <div class="pb-5 text-center">
                                    <%-- Cover Photo pattern เดียวกับ announcement_add.jsp - image-input widget ของ Metronic
                                         preload รูปเดิมจาก product.fileUpload (Hibernate join อัตโนมัติผ่าน Product.fileUpload) --%>
                                    <div class="image-input image-input-outline"
                                         data-kt-image-input="true"
                                         style="background-image: url('${pageContext.request.contextPath}${not empty product.fileUpload.path ? product.fileUpload.path : '/assets/media/svg/avatars/blank.svg'}')">
                                        <div class="image-input-wrapper w-125px h-125px"
                                             style="background-image: url('${pageContext.request.contextPath}${not empty product.fileUpload.path ? product.fileUpload.path : '/assets/media/svg/avatars/blank.svg'}')"></div>

                                        <label class="btn btn-icon btn-circle btn-color-muted btn-active-color-primary w-25px h-25px bg-body shadow"
                                               data-kt-image-input-action="change" data-bs-toggle="tooltip"
                                               data-bs-dismiss="click" title="Change image">
                                            <i class="ki-duotone ki-pencil fs-6"><span class="path1"></span><span class="path2"></span></i>
                                            <input id="productImageInput" type="file" name="productImage" accept=".png, .jpg, .jpeg" />
                                        </label>

                                        <span class="btn btn-icon btn-circle btn-color-muted btn-active-color-primary w-25px h-25px bg-body shadow"
                                              data-kt-image-input-action="cancel" data-bs-toggle="tooltip"
                                              data-bs-dismiss="click" title="Cancel image">
                                            <i class="ki-outline ki-cross fs-3"></i>
                                        </span>
                                    </div>
                                </div>
                                <div class="card-footer pt-0">
                                    <span class="d-block fw-medium text-muted text-center">Allowed file types: png, jpg, jpeg. Max 2MB.</span>
                                </div>
                            </div>
                        </div>

                        <div class="col-12">
                            <div id="stockConsEditFooter" class="d-none justify-content-end gap-3 mt-3 pt-6">
                                <button type="button" id="stockConsEditCancel" class="btn btn-light px-6 py-3 fw-bold">Cancel</button>
                                <button type="submit" class="btn btn-success px-8 py-3 fw-bold">Save</button>
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

                <%-- ============ Sub product (รวมกับ Equipment เข้าการ์ดเดียว 25/08/2026) ============
                     ใช้ร่วมกันทุก Item Type - สำหรับ Equipment ตารางนี้ "adaptive" ตามว่ามี sub product
                     หรือยัง (ดู ProductAction.showStockEditPage() / buildEquipmentGroupsForCatalog()):
                       - มี sub product      -> ตาราง sub product ปกติ + คอลัมน์ Equipment (badge/expand/link)
                                                 บวกแถวท้าย "ไม่ระบุ sub" สำหรับเครื่องที่ยังผูกกับตัวแม่ตรงๆ
                       - ไม่มี sub product   -> ถ้ามีเครื่องผูกกับตัวแม่ตรงๆ (ข้อมูลเก่า) โชว์ตาราง equipment
                                                 ตรงๆ แทน / ถ้าไม่มีเลยโชว่ข้อความชวนสร้าง sub product ก่อน
                     Equipment column ใช้ DataTables เฉพาะ child-row API (ordering/paging/searching ปิดหมด
                     dom:'t') เพื่อไม่ชนกับ SortableJS ที่คุมการลากจัดลำดับ #subTableBody อยู่ --%>
                <div class="card">
                    <div class="card-border-radius">
                        <div class="card-header border-0 pt-6 d-flex align-items-center justify-content-between">
                            <h3 class="page-heading text-gray-900 fw-bold mb-0">Sub product</h3>
                            <%-- ผูกกับ product.sub_product_active - บันทึกทันทีผ่าน AJAX (product_sub_active_update) --%>
                            <div class="form-check form-switch form-check-custom form-check-solid">
                                <input class="form-check-input h-25px w-45px" type="checkbox" id="subProductActiveToggle"
                                       data-product-id="${product.productId}"
                                       <c:if test="${product.subProductActive eq '1'}">checked</c:if> />
                                <label class="form-check-label fw-semibold text-gray-700" for="subProductActiveToggle">Active</label>
                            </div>
                        </div>
                        <div class="separator"></div>

                        <div class="card-body">
                            <c:choose>
                                <%-- Equipment, ไม่มี sub product เลย, ไม่มีเครื่องผูกกับตัวแม่ตรงๆ ด้วย = ว่างเปล่าจริงๆ --%>
                                <c:when test="${isEquipment and empty subProducts and parentEquipmentCount == 0}">
                                    <div class="text-center text-muted py-10">
                                        <div class="mb-4">ยังไม่มี sub product - สร้าง sub product ก่อน หรือผูกเครื่องเข้า item นี้ตรงๆ ก็ได้</div>
                                        <div class="d-flex flex-wrap justify-content-center gap-3">
                                            <button type="button" class="btn btn-success d-inline-flex align-items-center px-6 py-3"
                                                    data-bs-toggle="modal" data-bs-target="#subCreateModal">
                                                <i class="ki-duotone ki-plus fs-3 me-2"><span class="path1"></span><span class="path2"></span></i>
                                                <span class="fw-bold">Create Sub product</span>
                                            </button>
                                            <button type="button" class="btn btn-success d-inline-flex align-items-center px-6 py-3 sub-equ-add"
                                                    data-target-id="${product.productId}" data-target-name="${fn:escapeXml(product.productName)}"
                                                    data-bs-toggle="modal" data-bs-target="#equipmentPickerModal">
                                                <i class="ki-duotone ki-plus fs-3 me-2"><span class="path1"></span><span class="path2"></span></i>
                                                <span class="fw-bold">Add Equipment</span>
                                            </button>
                                        </div>
                                    </div>
                                </c:when>

                                <%-- Equipment, ไม่มี sub product แต่มีเครื่องผูกกับตัวแม่ตรงๆ อยู่ (ข้อมูลเก่า) - โชว์ตาราง equipment ตรงๆ --%>
                                <c:when test="${isEquipment and empty subProducts}">
                                    <c:set var="parentGroup" value="${equipmentDetailByProductId[product.productId]}" />
                                    <div class="d-flex justify-content-end mb-6">
                                        <button type="button" class="btn btn-success d-inline-flex align-items-center px-6 py-3 sub-equ-add"
                                                data-target-id="${product.productId}" data-target-name="${fn:escapeXml(product.productName)}"
                                                data-bs-toggle="modal" data-bs-target="#equipmentPickerModal">
                                            <i class="ki-duotone ki-plus fs-3 me-2"><span class="path1"></span><span class="path2"></span></i>
                                            <span class="fw-bold">Add Equipment</span>
                                        </button>
                                    </div>
                                    <table id="equipmentFlatTable" class="table align-middle fs-6 mb-0">
                                        <thead class="fs-7 text-gray-500 text-uppercase">
                                            <tr class="fw-semibold">
                                                <th class="min-w-150px text-nowrap">Item ID</th>
                                                <th class="min-w-250px text-nowrap">ชื่อเครื่อง</th>
                                                <th class="min-w-180px text-nowrap">Serial No</th>
                                                <th class="min-w-120px text-nowrap text-center">Status</th>
                                                <th class="min-w-180px text-nowrap">Location</th>
                                                <th class="min-w-80px text-nowrap text-end">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="equip" items="${parentGroup.rows}">
                                                <c:set var="equipLabel">
                                                    <c:choose>
                                                        <c:when test="${not empty fn:trim(equip.itemNo)}">${fn:escapeXml(equip.itemNo)}</c:when>
                                                        <c:when test="${not empty fn:trim(equip.name)}">${fn:escapeXml(equip.name)}</c:when>
                                                        <c:otherwise>#${equip.equipmentId}</c:otherwise>
                                                    </c:choose>
                                                </c:set>
                                                <tr>
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
                                                    <td class="text-gray-700 fw-normal">
                                                        <c:choose>
                                                            <c:when test="${not empty equip.location}">${fn:escapeXml(equip.location)}</c:when>
                                                            <c:otherwise><span class="text-muted">-</span></c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td class="text-end">
                                                        <button type="button" class="btn btn-icon btn-sm btn-light-danger btn-unlink-equipment"
                                                                data-id="${equip.equipmentId}"
                                                                data-name="${fn:trim(equipLabel)}"
                                                                data-target-id="${product.productId}"
                                                                title="เอาออกจาก item นี้">
                                                            <i class="ki-duotone ki-cross-circle fs-3"><span class="path1"></span><span class="path2"></span></i>
                                                        </button>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </c:when>

                                <%-- ปกติ: ตาราง sub product (ทุก Item Type) + คอลัมน์ Equipment ถ้าเป็น Equipment --%>
                                <c:otherwise>
                                    <div class="d-flex justify-content-end mb-6">
                                        <button type="button" class="btn btn-success d-inline-flex align-items-center px-6 py-3"
                                                data-bs-toggle="modal" data-bs-target="#subCreateModal">
                                            <i class="ki-duotone ki-plus fs-3 me-2"><span class="path1"></span><span class="path2"></span></i>
                                            <span class="fw-bold">Create</span>
                                        </button>
                                    </div>

                                    <%-- มี sub product แล้วแต่ยังไม่มีเครื่องผูกที่ไหนเลย (รวมตัวแม่) - เตือน + ปุ่ม Link ตรงตัวแม่ --%>
                                    <c:if test="${isEquipment and totalEquipmentCount == 0}">
                                        <div class="alert alert-warning d-flex align-items-center justify-content-between flex-wrap gap-3 mb-6">
                                            <span class="fw-semibold">ยังไม่มีเครื่องใน item นี้</span>
                                            <button type="button" class="btn btn-sm btn-warning sub-equ-add"
                                                    data-target-id="${product.productId}" data-target-name="${fn:escapeXml(product.productName)}"
                                                    data-bs-toggle="modal" data-bs-target="#equipmentPickerModal">
                                                Link Equipment
                                            </button>
                                        </div>
                                    </c:if>

                                    <div class="table-responsive">
                                        <table id="subProductTable" class="table align-middle fs-6 mb-0">
                                            <thead class="fs-7 text-gray-500 text-uppercase">
                                                <tr class="fw-semibold">
                                                    <th class="w-40px"></th>
                                                    <th class="min-w-100px text-nowrap">Sequence</th>
                                                    <th class="min-w-250px text-nowrap">Sub Product ID</th>
                                                    <th class="min-w-200px text-nowrap">Sub Product Name</th>
                                                    <th class="min-w-250px text-nowrap">Description</th>
                                                    <c:if test="${isEquipment}"><th class="min-w-150px text-nowrap text-center">Equipment</th></c:if>
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
                                                        <c:if test="${isEquipment}">
                                                            <c:set var="subCount" value="${empty equipmentCounts[sub.productId] ? 0 : equipmentCounts[sub.productId]}" />
                                                            <c:set var="subGroup" value="${equipmentDetailByProductId[sub.productId]}" />
                                                            <%-- child-row content: mini ตาราง serial/status ของเครื่องใน sub นี้ escape ทั้งก้อนเก็บไว้ใน data attribute
                                                                 ให้ browser decode คืนตอน parse HTML แล้ว JS ค่อยส่งให้ DataTables row.child() แสดงตอนกด badge --%>
                                                            <c:set var="childHtml">
                                                                <div class="p-4">
                                                                    <table class="table table-sm align-middle fs-7 mb-0">
                                                                        <thead class="text-gray-500 text-uppercase">
                                                                            <tr>
                                                                                <th>Item ID</th>
                                                                                <th>ชื่อเครื่อง</th>
                                                                                <th>Serial No</th>
                                                                                <th class="text-center">Status</th>
                                                                                <th>Location</th>
                                                                                <th class="text-end">Action</th>
                                                                            </tr>
                                                                        </thead>
                                                                        <tbody>
                                                                            <c:forEach var="equip" items="${subGroup.rows}">
                                                                                <c:set var="equipLabel">
                                                                                    <c:choose>
                                                                                        <c:when test="${not empty fn:trim(equip.itemNo)}">${fn:escapeXml(equip.itemNo)}</c:when>
                                                                                        <c:when test="${not empty fn:trim(equip.name)}">${fn:escapeXml(equip.name)}</c:when>
                                                                                        <c:otherwise>#${equip.equipmentId}</c:otherwise>
                                                                                    </c:choose>
                                                                                </c:set>
                                                                                <tr>
                                                                                    <td class="text-gray-900 fw-bold">
                                                                                        <c:choose>
                                                                                            <c:when test="${not empty fn:trim(equip.itemNo)}">${fn:escapeXml(equip.itemNo)}</c:when>
                                                                                            <c:otherwise><span class="text-muted">#${equip.equipmentId}</span></c:otherwise>
                                                                                        </c:choose>
                                                                                    </td>
                                                                                    <td class="text-gray-700">
                                                                                        <c:choose>
                                                                                            <c:when test="${not empty fn:trim(equip.name)}">${fn:escapeXml(equip.name)}</c:when>
                                                                                            <c:otherwise><span class="text-muted">(ไม่ระบุชื่อ)</span></c:otherwise>
                                                                                        </c:choose>
                                                                                    </td>
                                                                                    <td class="text-gray-700">
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
                                                                                    <td class="text-gray-700">
                                                                                        <c:choose>
                                                                                            <c:when test="${not empty equip.location}">${fn:escapeXml(equip.location)}</c:when>
                                                                                            <c:otherwise><span class="text-muted">-</span></c:otherwise>
                                                                                        </c:choose>
                                                                                    </td>
                                                                                    <td class="text-end">
                                                                                        <button type="button" class="btn btn-icon btn-sm btn-light-danger btn-unlink-equipment"
                                                                                                data-id="${equip.equipmentId}"
                                                                                                data-name="${fn:trim(equipLabel)}"
                                                                                                data-target-id="${sub.productId}"
                                                                                                title="เอาออกจาก sub product นี้">
                                                                                            <i class="ki-duotone ki-cross-circle fs-3"><span class="path1"></span><span class="path2"></span></i>
                                                                                        </button>
                                                                                    </td>
                                                                                </tr>
                                                                            </c:forEach>
                                                                            <c:if test="${empty subGroup.rows}">
                                                                                <tr><td colspan="6" class="text-center text-muted py-4">ยังไม่มีเครื่องผูกกับ sub product นี้</td></tr>
                                                                            </c:if>
                                                                        </tbody>
                                                                    </table>
                                                                </div>
                                                            </c:set>
                                                            <td class="text-center">
                                                                <span class="badge badge-primary fw-bold equ-count-badge" role="button"
                                                                      data-child-html="${fn:escapeXml(childHtml)}">${subCount} เครื่อง</span>
                                                                <button type="button" class="btn btn-icon btn-sm btn-active-light-success sub-equ-add ms-1"
                                                                        data-target-id="${sub.productId}" data-target-name="${fn:escapeXml(sub.productName)}"
                                                                        data-bs-toggle="modal" data-bs-target="#equipmentPickerModal" title="Link Equipment">
                                                                    <i class="ki-duotone ki-plus fs-3"><span class="path1"></span><span class="path2"></span></i>
                                                                </button>
                                                            </td>
                                                        </c:if>
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

                                                <%-- แถวพิเศษ "ไม่ระบุ sub" - เครื่องที่ยังผูกกับตัวแม่ตรงๆ ไม่ได้อยู่ใต้ sub product ไหนเลย
                                                     ไม่ใช่ sub product จริง จึงไม่มีปุ่ม Edit/Delete และไม่ให้ลาก reorder (ดู JS: initSortable filter) --%>
                                                <c:if test="${isEquipment and parentEquipmentCount > 0}">
                                                    <c:set var="parentGroup" value="${equipmentDetailByProductId[product.productId]}" />
                                                    <c:set var="parentChildHtml">
                                                        <div class="p-4">
                                                            <table class="table table-sm align-middle fs-7 mb-0">
                                                                <thead class="text-gray-500 text-uppercase">
                                                                    <tr>
                                                                        <th>Item ID</th>
                                                                        <th>ชื่อเครื่อง</th>
                                                                        <th>Serial No</th>
                                                                        <th class="text-center">Status</th>
                                                                        <th>Location</th>
                                                                        <th class="text-end">Action</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <c:forEach var="equip" items="${parentGroup.rows}">
                                                                        <c:set var="equipLabel">
                                                                            <c:choose>
                                                                                <c:when test="${not empty fn:trim(equip.itemNo)}">${fn:escapeXml(equip.itemNo)}</c:when>
                                                                                <c:when test="${not empty fn:trim(equip.name)}">${fn:escapeXml(equip.name)}</c:when>
                                                                                <c:otherwise>#${equip.equipmentId}</c:otherwise>
                                                                            </c:choose>
                                                                        </c:set>
                                                                        <tr>
                                                                            <td class="text-gray-900 fw-bold">
                                                                                <c:choose>
                                                                                    <c:when test="${not empty fn:trim(equip.itemNo)}">${fn:escapeXml(equip.itemNo)}</c:when>
                                                                                    <c:otherwise><span class="text-muted">#${equip.equipmentId}</span></c:otherwise>
                                                                                </c:choose>
                                                                            </td>
                                                                            <td class="text-gray-700">
                                                                                <c:choose>
                                                                                    <c:when test="${not empty fn:trim(equip.name)}">${fn:escapeXml(equip.name)}</c:when>
                                                                                    <c:otherwise><span class="text-muted">(ไม่ระบุชื่อ)</span></c:otherwise>
                                                                                </c:choose>
                                                                            </td>
                                                                            <td class="text-gray-700">
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
                                                                            <td class="text-gray-700">
                                                                                <c:choose>
                                                                                    <c:when test="${not empty equip.location}">${fn:escapeXml(equip.location)}</c:when>
                                                                                    <c:otherwise><span class="text-muted">-</span></c:otherwise>
                                                                                </c:choose>
                                                                            </td>
                                                                            <td class="text-end">
                                                                                <button type="button" class="btn btn-icon btn-sm btn-light-danger btn-unlink-equipment"
                                                                                        data-id="${equip.equipmentId}"
                                                                                        data-name="${fn:trim(equipLabel)}"
                                                                                        data-target-id="${product.productId}"
                                                                                        title="เอาออกจาก item นี้">
                                                                                    <i class="ki-duotone ki-cross-circle fs-3"><span class="path1"></span><span class="path2"></span></i>
                                                                                </button>
                                                                            </td>
                                                                        </tr>
                                                                    </c:forEach>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </c:set>
                                                    <tr class="equ-unassigned-row" data-id="">
                                                        <td></td>
                                                        <td class="text-muted">-</td>
                                                        <td class="text-muted">-</td>
                                                        <td class="text-gray-500 fst-italic">(ไม่ระบุ sub product)</td>
                                                        <td class="text-muted">-</td>
                                                        <td class="text-center">
                                                            <span class="badge badge-secondary fw-bold equ-count-badge" role="button"
                                                                  data-child-html="${fn:escapeXml(parentChildHtml)}">${parentEquipmentCount} เครื่อง</span>
                                                            <button type="button" class="btn btn-icon btn-sm btn-active-light-success sub-equ-add ms-1"
                                                                    data-target-id="${product.productId}" data-target-name="${fn:escapeXml(product.productName)}"
                                                                    data-bs-toggle="modal" data-bs-target="#equipmentPickerModal" title="Link Equipment">
                                                                <i class="ki-duotone ki-plus fs-3"><span class="path1"></span><span class="path2"></span></i>
                                                            </button>
                                                        </td>
                                                        <td></td>
                                                    </tr>
                                                </c:if>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <%-- ปุ่ม Back กลับไปหน้ารายการ Product --%>
                <div class="d-flex justify-content-start mt-8">
                    <a href="product_list" class="btn btn-light d-inline-flex align-items-center px-6 py-3">
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
                            <label class="form-label fw-semibold text-gray-700" for="uomUnitNameSelect">
                                Unit Name <span class="text-danger">*</span>
                            </label>
                            <%-- เลือกจากชื่อหน่วยที่มีอยู่แล้ว (กันตั้งชื่อซ้ำ) หรือกด "+ พิมพ์ชื่อใหม่" เพื่อพิมพ์เอง
                                 select/input ทั้งสองไม่มี name ของตัวเอง (เจตนา - เคยลอง disabled สลับกันแทน
                                 แต่พอ disable select ตัวเองแล้วกลับมาเลือกใหม่ไม่ได้อีกเลย) ค่าจริงที่ submit
                                 มาจาก hidden ด้านล่าง ซึ่ง JS sync ให้ตอน submit ฟอร์ม (ดู .on('submit', ...)) --%>
                            <select id="uomUnitNameSelect" required class="form-select text-gray-700">
                                <option value="">- เลือก Unit Name -</option>
                                <c:forEach var="uName" items="${allUnitNames}">
                                    <option value="${fn:escapeXml(uName)}">${fn:escapeXml(uName)}</option>
                                </c:forEach>
                                <option value="__new__">+ พิมพ์ชื่อใหม่</option>
                            </select>
                            <input type="text" id="uomUnitNameInput" maxlength="100"
                                   class="form-control text-gray-700 mt-2 d-none"
                                   placeholder="พิมพ์ชื่อหน่วยใหม่" />
                            <input type="hidden" name="unitName" id="uomUnitNameHidden" />
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
                            <label class="form-label fw-semibold text-gray-700" for="editUomUnitNameSelect">
                                Unit Name <span class="text-danger">*</span>
                            </label>
                            <select id="editUomUnitNameSelect" required class="form-select text-gray-700">
                                <option value="">- เลือก Unit Name -</option>
                                <c:forEach var="uName" items="${allUnitNames}">
                                    <option value="${fn:escapeXml(uName)}">${fn:escapeXml(uName)}</option>
                                </c:forEach>
                                <option value="__new__">+ พิมพ์ชื่อใหม่</option>
                            </select>
                            <input type="text" id="editUomUnitNameInput" maxlength="100"
                                   class="form-control text-gray-700 mt-2 d-none"
                                   placeholder="พิมพ์ชื่อหน่วยใหม่" />
                            <input type="hidden" name="unitName" id="editUomUnitNameHidden" />
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

<%-- ============ Modal: Add Equipment (เลือกเครื่องที่ยังไม่ผูก catalog ไหนเลย) ============
     ต่างจาก modal อื่นในไฟล์นี้ - ไม่ใช่ <form> submit ปกติ เพราะบันทึกเป็น AJAX ตรง
     (ปุ่ม Save อยู่ใน modal-footer เป็น type="button" ไม่ใช่ type="submit") --%>
<c:if test="${isEquipment}">
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
</c:if>

<%-- ทั้งสอง modal นี้เปิดจากปุ่มใน Sub product card ด้านบน (ใช้ร่วมกันทุก Item Type รวม Equipment) --%>
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
                                   class="form-control text-gray-700" autocomplete="off" />
                            <div class="invalid-feedback" id="subProductNoFeedback"></div>
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
                                   class="form-control text-gray-700" autocomplete="off" />
                            <div class="invalid-feedback" id="editSubProductNoFeedback"></div>
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

<script src="https://cdn.jsdelivr.net/npm/sortablejs@latest/Sortable.min.js"></script>
<script>
    $(document).ready(function () {
        // NOTE: ตาราง UOM / Sub product ไม่ใช้ DataTables เพราะชนกับ SortableJS (การจัดลำดับแถว)
        //       ยกเว้น #subProductTable ตอนเป็น Equipment ที่ init DataTables แบบปิด ordering/paging/
        //       searching หมด (dom:'t') ใช้แค่ child-row API จึงไม่ชนกับ SortableJS (ดูท้ายไฟล์)

        var CONTEXT = '${pageContext.request.contextPath}';
        var PRODUCT_ID = '${product.productId}';
        // prefix ของ action ที่ต้อง redirect กลับหน้านี้ (stock_cons / stock_equ)
        var URL_PREFIX = '${urlPrefix}';
        var IS_EQUIPMENT = ${isEquipment};

        // Image compression logic - คัดลอกจาก announcement_add.jsp ตรงๆ (vanilla JS ไม่มี dependency พิเศษ)
        async function compressImage(file, maxWidth = 1280, maxHeight = 1280, quality = 0.8) {
            if (!file.type.match(/image\/(jpeg|jpg|png)/)) {
                return file;
            }

            return new Promise((resolve, reject) => {
                const reader = new FileReader();
                reader.readAsDataURL(file);
                reader.onload = event => {
                    const img = new Image();
                    img.src = event.target.result;
                    img.onload = () => {
                        let width = img.width;
                        let height = img.height;

                        if (width > maxWidth || height > maxHeight) {
                            const ratio = Math.min(maxWidth / width, maxHeight / height);
                            width = width * ratio;
                            height = height * ratio;
                        }

                        const canvas = document.createElement('canvas');
                        canvas.width = width;
                        canvas.height = height;
                        const ctx = canvas.getContext('2d');
                        ctx.drawImage(img, 0, 0, width, height);

                        canvas.toBlob((blob) => {
                            if (blob) {
                                const newFileName = file.name.replace(/\.[^/.]+$/, ".jpg");
                                const newFile = new File([blob], newFileName, {
                                    type: 'image/jpeg',
                                    lastModified: Date.now()
                                });
                                resolve(newFile);
                            } else {
                                resolve(file);
                            }
                        }, 'image/jpeg', quality);
                    };
                    img.onerror = error => reject(error);
                };
                reader.onerror = error => reject(error);
            });
        }

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

        // ---- แสดง/ซ่อน Equipment Type ตาม Item Type (เหมือนหน้า product_add.jsp) ----
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
        toggleEquipmentType(); // ตั้งค่าเริ่มต้นตาม productType ปัจจุบันของ item นี้

        // ---- Unit Name picker (select จากชื่อเดิม + พิมพ์ชื่อใหม่ได้) ในทั้ง modal Create/Edit UOM ----
        // select เปิดใช้งานตลอด ไม่ disable อีกต่อไป (เคย disable ตอนเลือก "+ พิมพ์ชื่อใหม่" แล้วกลับมา
        // เลือกจาก dropdown ไม่ได้อีกเลย ต้อง refresh หน้าเท่านั้น) - สลับแค่โชว์/ซ่อนช่อง input เฉยๆ
        // ค่าที่จะ submit จริงมาจาก hidden field แยกต่างหาก sync ให้ตอน submit ฟอร์ม (ดูด้านล่าง)
        function bindUnitNamePicker(selectId, inputId) {
            var $select = $('#' + selectId);
            var $input = $('#' + inputId);
            $select.on('change', function () {
                var isNew = $select.val() === '__new__';
                $input.toggleClass('d-none', !isNew);
                if (isNew) { $input.trigger('focus'); }
                // ไม่ล้างค่าที่เคยพิมพ์ไว้ตอนสลับกลับไป dropdown - เผื่อผู้ใช้สลับไปมาแล้วอยากได้ค่าเดิมคืน
            });
        }
        bindUnitNamePicker('uomUnitNameSelect', 'uomUnitNameInput');
        bindUnitNamePicker('editUomUnitNameSelect', 'editUomUnitNameInput');

        /**
         * ตั้งค่า Unit Name ให้ picker คู่หนึ่ง (select+input) - ใช้ตอนเปิด modal Edit
         * ถ้าชื่อนี้มีอยู่ใน dropdown อยู่แล้วก็เลือกให้เลย ถ้าไม่เจอ (เคสแปลกๆ ที่ข้อมูลเก่าไม่ตรงกับ
         * distinct list) ให้ fallback ไปโหมด "+ พิมพ์ชื่อใหม่" แล้วใส่ค่าเดิมไว้ในช่อง input แทน
         */
        function setUnitNameValue(selectId, inputId, value) {
            var $select = $('#' + selectId);
            var $input = $('#' + inputId);
            var found = $select.find('option[value="' + $.escapeSelector(value || '') + '"]').length > 0;

            if (found) {
                $select.val(value);
                $input.addClass('d-none').val('');
            } else {
                $select.val('__new__');
                $input.removeClass('d-none').val(value || '');
            }
        }

        /**
         * sync ค่าจาก select/input ไปลง hidden field ก่อน submit จริง - เรียกจาก submit handler ด้านล่าง
         * คืน false ถ้าค่าว่าง (ให้ caller preventDefault + แจ้งเตือนเอง)
         */
        function syncUnitNameHidden(selectId, inputId, hiddenId) {
            var $select = $('#' + selectId);
            var $input = $('#' + inputId);
            var $hidden = $('#' + hiddenId);
            var isNew = $select.val() === '__new__';
            var value = isNew ? $input.val().trim() : $select.val();

            $hidden.val(value);
            if (!value) {
                notifyError(isNew ? 'กรุณาพิมพ์ชื่อหน่วยใหม่' : 'กรุณาเลือก Unit Name');
                (isNew ? $input : $select).trigger('focus');
                return false;
            }
            return true;
        }

        // ---- แสดงปุ่ม Cancel/Save เฉพาะเมื่อมีการแก้ไขค่าในฟอร์ม Product Detail ----
        var $editForm = $('#stockConsEditForm');
        var $editFooter = $('#stockConsEditFooter');

        // เก็บค่าตั้งต้นของทุก field ไว้เทียบว่ามีการแก้จริงไหม (กันกรณีพิมพ์แล้วลบกลับเป็นค่าเดิม)
        var initialState = $editForm.serialize();

        // $.fn.serialize() ไม่รวม <input type="file"> เลย (ทั้ง jQuery และ HTML form serialization
        // มาตรฐานข้าม file input เสมอ) เทียบ serialize() อย่างเดียวจึงไม่มีทางเห็นว่ารูปถูกเปลี่ยน
        // ต้องมี flag แยกมาช่วยเช็ค dirty
        var imageDirty = false;
        // ตัว .image-input (outer) และ .image-input-wrapper (inner) ต้อง sync background-image คู่กันเสมอ
        // (ดู HTML - ทั้งสอง element ตั้ง style เดียวกันไว้ตอน render หน้า)
        var $productImageEls = $editForm.find('.image-input, .image-input-wrapper');
        var initialImageBg = $productImageEls.first().css('background-image');

        function refreshEditFooter() {
            var dirty = imageDirty || ($editForm.serialize() !== initialState);
            $editFooter.toggleClass('d-none', !dirty).toggleClass('d-flex', dirty);
        }

        $editForm.on('input change', 'input, select, textarea', refreshEditFooter);

        // ---- Product Image: compress ก่อนแนบไฟล์ (maxSize 2MB เหมือนหน้า product_add.jsp) ----
        var productImageInput = document.getElementById('productImageInput');
        productImageInput.addEventListener('change', async function () {
            const file = this.files[0];
            const maxSize = 2 * 1024 * 1024;
            const errorMsg = document.getElementById('productImageErrorMsg');

            if (!file) { return; }

            const compressed = await compressImage(file);

            if (compressed.size > maxSize) {
                errorMsg.textContent = 'Image must be smaller than 2MB.';
                this.value = '';
                imageDirty = false;
            } else {
                errorMsg.textContent = '';
                const dataTransfer = new DataTransfer();
                dataTransfer.items.add(compressed);
                this.files = dataTransfer.files;
                imageDirty = true;
            }
            refreshEditFooter();
        });

        // ปุ่ม "x" เล็กๆ ของตัว image-input widget เอง (Metronic) - ล้างไฟล์ที่เพิ่งเลือกกลับเป็นค่าเดิม
        $editForm.find('[data-kt-image-input-action="cancel"]').on('click', function () {
            imageDirty = false;
            document.getElementById('productImageErrorMsg').textContent = '';
            refreshEditFooter();
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
            // form reset() ล้างค่า <input type="file"> ให้เองแล้ว แต่ preview (background-image ที่ตั้งผ่าน JS)
            // ไม่ได้ตามไปด้วย - ต้องคืนรูปเดิมเองด้วย
            $productImageEls.css('background-image', initialImageBg);
            imageDirty = false;
            document.getElementById('productImageErrorMsg').textContent = '';
            refreshEditFooter();
        });

        // กันกด Save ซ้ำระหว่างรอ response (เฉพาะ modal ที่ยัง submit แบบ redirect ปกติ)
        // uomCreateForm/uomEditForm ต้อง sync ค่า Unit Name (select/input) ลง hidden field ก่อนด้วย -
        // ถ้า sync ไม่ผ่าน (ค่าว่าง) ให้ preventDefault + return ออกเลย ไม่ต้องไป disable ปุ่ม Save
        $('#uomCreateForm, #uomEditForm, #subCreateForm, #subEditForm').on('submit', function (e) {
            var $form = $(this);

            if ($form.is('#uomCreateForm')) {
                if (!syncUnitNameHidden('uomUnitNameSelect', 'uomUnitNameInput', 'uomUnitNameHidden')) {
                    e.preventDefault();
                    return;
                }
            } else if ($form.is('#uomEditForm')) {
                if (!syncUnitNameHidden('editUomUnitNameSelect', 'editUomUnitNameInput', 'editUomUnitNameHidden')) {
                    e.preventDefault();
                    return;
                }
            }

            $form.find('button[type="submit"]')
                 .prop('disabled', true)
                 .attr('data-kt-indicator', 'on');
        });

        // ---- เช็ค Item ID / Sub Product ID ซ้ำ ทุกครั้งที่พิมพ์ (keyup) - debounce กันยิง request ถี่เกินไป
        //      getExcludeId เป็น function เพราะ id ที่จะ exclude (เช่น editSubProductId) อ่านค่าตอนพิมพ์ ไม่ใช่ตอน bind ----
        function bindProductNoDuplicateCheck(inputSelector, feedbackSelector, getExcludeId) {
            var timer = null;
            var seqCounter = 0;
            $(inputSelector).on('keyup', function () {
                var $input = $(this);
                var val = $input.val().trim();
                var $feedback = $(feedbackSelector);
                clearTimeout(timer);

                if (!val) {
                    $input.removeClass('is-invalid')[0].setCustomValidity('');
                    $feedback.text('');
                    return;
                }

                timer = setTimeout(function () {
                    var seq = ++seqCounter;
                    var params = { productNo: val };
                    var excludeId = getExcludeId ? getExcludeId() : null;
                    if (excludeId) { params.productId = excludeId; }
                    $.ajax({
                        url: CONTEXT + '/product_check_duplicate',
                        type: 'GET',
                        dataType: 'json',
                        data: params,
                        success: function (res) {
                            if (seq !== seqCounter) { return; } // ผลลัพธ์เก่ามาช้า ไม่ต้องสนใจ
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
        }

        bindProductNoDuplicateCheck('#productNo', '#productNoFeedback', function () { return PRODUCT_ID; });
        bindProductNoDuplicateCheck('#subProductNo', '#subProductNoFeedback', null);
        bindProductNoDuplicateCheck('#editSubProductNo', '#editSubProductNoFeedback', function () { return $('#editSubProductId').val(); });

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
                url: CONTEXT + '/product_update',
                type: 'POST',
                dataType: 'json',
                // $editForm.serialize() ไม่ส่งไฟล์ - ต้องใช้ FormData ถึงจะอัปโหลดรูปได้จริง
                data: new FormData(formEl),
                processData: false,
                contentType: false,
                success: function (res) {
                    if (res && res.success === true) {
                        // มีรูปใหม่ - อัปเดต preview ทันทีโดยไม่ reload หน้า
                        if (res.imagePath) {
                            var newBg = "url('" + CONTEXT + res.imagePath + "')";
                            $productImageEls.css('background-image', newBg);
                            // ตั้งเป็น baseline ใหม่ ไม่งั้นกด Cancel ครั้งถัดไปจะดันย้อนกลับไปรูปเก่าก่อนหน้านี้
                            initialImageBg = newBg;
                        }
                        // ตั้งค่าตั้งต้นใหม่ = ค่าปัจจุบัน แล้วซ่อน footer (ไม่ dirty อีก)
                        initialState = $editForm.serialize();
                        imageDirty = false;
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

        // ==================== Equipment: DataTables ใช้เฉพาะ child-row API (กด badge เพื่อดู serial/status) ====================
        // ปิด ordering/paging/searching หมด (dom:'t') และไม่เรียก .draw() ที่ไหนเลยในไฟล์นี้ - กันชนกับ
        // SortableJS ที่คุมการลากจัดลำดับ #subTableBody อยู่ (initSortable ท้ายไฟล์อัปเดตแค่ text/attr ไม่ draw)
        var subEquTable = null;
        if (IS_EQUIPMENT && $('#subProductTable').length) {
            subEquTable = $('#subProductTable').DataTable({
                ordering: false,
                paging: false,
                info: false,
                searching: false,
                dom: 't'
            });
        }

        $('#subProductTable').on('click', '.equ-count-badge', function () {
            if (!subEquTable) { return; }
            var $badge = $(this);
            var tr = $badge.closest('tr');
            var row = subEquTable.row(tr);

            if (row.child.isShown()) {
                row.child.hide();
                tr.removeClass('shown');
            } else {
                row.child($badge.data('child-html') || '').show();
                tr.addClass('shown');
            }
        });

        // ==================== Equipment: จำ sub product/ตัวแม่เป้าหมายไว้ก่อนเปิด popup Add/Link Equipment ====================
        // ปุ่มนี้อยู่ได้หลายที่ (หัวตาราง, ต่อแถว sub product, แถว "ไม่ระบุ sub", แบนเนอร์เตือน) ใช้ class เดียวกันหมด
        var currentEquipmentTargetId = null;
        $(document).on('click', '.sub-equ-add', function () {
            currentEquipmentTargetId = $(this).data('target-id');
            var targetName = $(this).data('target-name') || '';
            $('#equipmentPickerModalTitle').text('เลือกเครื่องเพื่อเพิ่มเข้า "' + targetName + '"');
        });

        // ==================== Equipment: unlink ปุ่มเอาเครื่องออกจาก sub product / ตัวแม่ ====================
        // delegate ที่ document เพราะปุ่มบางส่วนอยู่ใน DataTables child-row ที่ inject เข้ามาทีหลัง
        $(document).on('click', '.btn-unlink-equipment', function () {
            var $btn = $(this);
            var id = $btn.data('id');
            var name = $btn.data('name') || '';
            var targetId = $btn.data('target-id');
            if (!id || !targetId) { return; }

            function doUnlink() {
                $btn.prop('disabled', true);
                $.ajax({
                    url: CONTEXT + '/stock_equ_unlink_save',
                    type: 'POST',
                    dataType: 'json',
                    data: { productId: targetId, equipmentIds: id },
                    success: function (res) {
                        if (res && res.success === true) {
                            if (window.Swal) {
                                Swal.fire({ icon: 'success', title: 'สำเร็จ', text: res.message || 'เอาเครื่องออกแล้ว' })
                                    .then(function () { window.location.reload(); });
                            } else {
                                alert(res.message || 'เอาเครื่องออกแล้ว');
                                window.location.reload();
                            }
                        } else {
                            notifyError(res && res.message ? res.message : 'เอาเครื่องออกไม่สำเร็จ');
                            $btn.prop('disabled', false);
                        }
                    },
                    error: function () {
                        notifyError('เอาเครื่องออกไม่สำเร็จ กรุณาลองใหม่');
                        $btn.prop('disabled', false);
                    }
                });
            }

            if (window.Swal) {
                Swal.fire({
                    title: 'เอาเครื่อง "' + name + '" ออกจาก sub product นี้?',
                    text: 'เครื่องจะยังอยู่ในระบบ แต่ไม่ผูกกับ sub product นี้แล้ว',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonText: 'เอาออก',
                    cancelButtonText: 'ยกเลิก',
                    reverseButtons: true
                }).then(function (result) {
                    if (result.isConfirmed) { doUnlink(); }
                });
            } else if (confirm('ต้องการเอาเครื่อง "' + name + '" ออกจาก sub product นี้ใช่หรือไม่?')) {
                doUnlink();
            }
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

        // กด Save ใน popup - บันทึกลง DB ทันทีแบบ AJAX แล้วรีโหลดหน้าให้ตาราง Sub product / Equipment
        // กับรายการใน popup (ที่เหลือแค่เครื่องว่างจริง) อัปเดตพร้อมกันทั้งคู่
        // productId ที่ผูกคือ sub product หรือตัวแม่เป้าหมาย (currentEquipmentTargetId)
        $('#btnEquipmentPickerSave').on('click', function () {
            var ids = $('.equipment-pick-checkbox:checked').map(function () { return $(this).val(); }).get();
            if (ids.length === 0) {
                if (window.Swal) { Swal.fire('กรุณาเลือกรายการ', 'เลือกอย่างน้อย 1 เครื่อง', 'warning'); }
                else { alert('กรุณาเลือกอย่างน้อย 1 เครื่อง'); }
                return;
            }
            if (!currentEquipmentTargetId) {
                notifyError('ไม่พบ sub product เป้าหมาย กรุณาปิดหน้าต่างแล้วกด Add Equipment ใหม่');
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

        // ==================== Sub product active toggle (AJAX) ====================
        $('#subProductActiveToggle').on('change', function () {
            var $toggle = $(this);
            var checked = $toggle.is(':checked');
            $toggle.prop('disabled', true);

            $.ajax({
                url: CONTEXT + '/product_sub_active_update',
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
            setUnitNameValue('editUomUnitNameSelect', 'editUomUnitNameInput', $row.data('unit-name'));
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

        // excludeSelector: กันแถวพิเศษที่ไม่ใช่แถวจัดลำดับจริง (เช่น .equ-unassigned-row "ไม่ระบุ sub")
        // ไม่ให้ลากได้และไม่ถูกนับเข้า ids ที่ส่งไป backend - ดันกลับไปท้ายสุดเสมอหลังบันทึกสำเร็จ
        function initSortable(tbodyId, handleClass, reorderUrl, extraData, excludeSelector) {
            var el = document.getElementById(tbodyId);
            if (!el || typeof Sortable === 'undefined') { return; }

            Sortable.create(el, {
                handle: handleClass,
                animation: 150,
                ghostClass: 'bg-light-primary',
                filter: excludeSelector || undefined,
                preventOnFilter: true,
                onEnd: function (evt) {
                    // ไม่ได้ขยับตำแหน่งจริง -> ไม่ต้องทำอะไร
                    if (evt.oldIndex === evt.newIndex) { return; }

                    var $rows = $('#' + tbodyId + ' tr');
                    if (excludeSelector) { $rows = $rows.not(excludeSelector); }

                    var ids = [];
                    $rows.each(function () {
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
                                    $rows.each(function (index) {
                                        $(this).find('.uom-seq, .sub-seq').text(index);
                                        $(this).attr('data-sequence', index);
                                    });
                                    // เผื่อแถวพิเศษหลุดตำแหน่งจากการลากของแถวอื่นรอบๆ - ดันกลับไปท้ายสุดเสมอ
                                    if (excludeSelector) {
                                        $('#' + tbodyId).append($('#' + tbodyId + ' ' + excludeSelector));
                                    }
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

        initSortable('uomTableBody', '.uom-drag-handle', 'product_uom_reorder', { productId: PRODUCT_ID });
        initSortable('subTableBody', '.sub-drag-handle', 'product_sub_reorder', { parentProductId: PRODUCT_ID }, '.equ-unassigned-row');
    });
</script>
