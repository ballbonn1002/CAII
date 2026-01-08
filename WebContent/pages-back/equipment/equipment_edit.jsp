<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
    <div class="d-flex flex-column flex-column-fluid">
        
        <div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
            <div id="kt_app_toolbar_container" class="app-container container-fluid d-flex flex-stack">
                <div class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
                    <h1 class="page-heading d-flex text-gray-700 fw-semibold my-0">Equipment Detail</h1>
                    <ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
                        <li class="breadcrumb-item text-muted">
                            <a href="${pageContext.request.contextPath}/demo_dashboard" class="text-muted text-hover-primary fw-medium fs-7">Home</a>
                        </li>
                        <li class="breadcrumb-item"><span class="bullet bg-gray-500 fw-medium fs-7 w-5px h-2px"></span></li>
                        <li class="breadcrumb-item text-muted fw-medium fs-7">Borrow</li>
                        <li class="breadcrumb-item"><span class="bullet bg-gray-500 fw-medium fs-7 w-5px h-2px"></span></li>
                        <li class="breadcrumb-item text-muted fw-medium fs-7">Equipment</li>
                    </ul>
                </div>
            </div>
        </div>

        <div id="kt_app_content" class="app-content flex-column-fluid">
            <div id="kt_app_content_container" class="app-container container-fluid">

                <form action="/equipment_update.action" method="post" enctype="multipart/form-data" id="kt_equipment_edit_form">
                    <input type="hidden" name="id" value="${equipmentbyId.equipmentId}" />
                    <input type="hidden" name="id_s" value="${equipmentbyId.equipmentId}" />

                    <div class="row g-5 g-xl-10">
                        <div class="col-xl-8">

                            <div class="card shadow-sm mb-5 mb-xl-10">
                                <div class="card-header fs-4">
                                    <div class="card-title m-0">
                                        <h3 class="fw-semibold m-0 text-gray-900">Equipment</h3>
                                    </div>
                                </div>

                                <div class="card-body pt-8">
                                    <div class="row">
                                        <div class="col-lg-6 mb-8">
                                            <label class="d-block fw-medium form-label mb-3">Item Picture</label>
                                            <div class="d-flex flex-column align-items-start">
                                                
                                                <c:set var="imageSrc" value="" />
                                                <c:if test="${not empty equipmentbyId.image}">
                                                    <c:set var="imageSrc" value="${pageContext.request.contextPath}/${equipmentbyId.image}" />
                                                </c:if>

                                                <div class="border rounded-3 bg-light d-flex align-items-center justify-content-center mb-1" style="width: 200px; height: 200px; overflow: hidden;">
                                                    <img id="itemImagePreview" src="${imageSrc}" style="max-width:100%; max-height:100%; object-fit:contain; ${empty equipmentbyId.image ? 'display:none;' : ''}">
                                                    <span id="itemImagePlaceholder" class="text-muted fs-7 ${empty equipmentbyId.image ? '' : 'd-none'}">
                                                        No image selected
                                                    </span>
                                                </div>

                                                <input type="file" id="itemImageInput" name="image" accept="image/*" class="d-none" />
                                                <button type="button" id="itemImageSelectBtn" class="btn btn-light mt-1 fs-7">
                                                    <i class="ki-duotone ki-picture fs-2 text-gray-700">
                                                        <span class="path1"></span><span class="path2"></span>
                                                    </i>
                                                    Select Image
                                                </button>
                                            </div>
                                        </div>

                                        <div class="col-lg-6 mb-8">
                                            <div class="mb-7">
                                                <label class="required form-label fw-medium text-gray-800">Type</label>
                                                <select class="form-select" name="type" id="typeSelect" data-control="select2" data-placeholder="Select Type">
                                                    <option></option>
                                                </select>
                                            </div>

                                            <div class="mb-7">
                                                <label class="required form-label fw-medium text-gray-800">Status</label>
                                                <select class="form-select" id="statusSelect" name="status" data-control="select2" data-placeholder="Select Status">
                                                    <option></option>
                                                </select>
                                            </div>

                                            <div class="mb-0">
                                                <label class="form-label fw-medium text-gray-800">
                                                    Specify a note when changing status (optional)
                                                </label>
                                                <textarea class="form-control" name="statusChange" rows="2" placeholder="Enter maintenance or repair notes..."></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row g-5 mb-5">
                                        <div class="col-md-6">
                                            <label class="required form-label fw-medium text-gray-800">Item Name</label>
                                            <input type="text" name="name" class="form-control" placeholder="Item name" value="${equipmentbyId.name}" />
                                        </div>
                                        <div class="col-md-6">
                                            <label class="required form-label fw-medium text-gray-800">Item No.</label>
                                            <input type="text" id="itemNo" name="itemNo" class="form-control" 
                                                   placeholder="Item No." value="${equipmentbyId.itemNo}" required 
                                                   oninput="this.classList.remove('is-invalid'); $('#itemNoFeedback').hide(); $('button[type=submit]').prop('disabled', false);"/>
                                            <div id="itemNoFeedback" class="invalid-feedback" style="display:none; color: #dc3545; margin-top: 0.5rem; font-size: 0.875em;">
                                                This item No. already exists in the system.
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row g-5 mb-5">
                                        <div class="col-md-6">
                                            <label class="required form-label fw-medium text-gray-800">Serial No.</label>
                                            <input type="text" name="serialNo" class="form-control" placeholder="Serial No." value="${equipmentbyId.serialNo}" />
                                        </div>
                                        <div class="col-md-6">
                                            <label class="required form-label fw-medium text-gray-800">Amount</label>
                                            <input type="number" name="amount" class="form-control" placeholder="1" value="${equipmentbyId.amount}" min="0" 
                                                   oninput="this.value = !!this.value && Math.abs(this.value) >= 0 ? Math.abs(this.value) : null" required/>
                                        </div>
                                    </div>

                                    <div class="row g-5">
                                        <div class="col-md-6">
                                            <label class="form-label fw-medium text-gray-800">Date of Purchase</label>
                                            <fmt:setLocale value="en_US" />
                                            <fmt:formatDate value="${equipmentbyId.timeCreate}" pattern="dd MMM yyyy" var="fmtDatePurchase" />
                                            <div class="position-relative d-flex align-items-center">
                                                <span class="svg-icon svg-icon-2 position-absolute mx-4">
                                                   <i class="ki-duotone ki-calendar-8 fs-2">
                                                    <span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span></i>
                                                </span>
                                                <input class="form-control ps-12" placeholder="Select date" id="kt_datepicker_1" name="datePurchase" value="${fmtDatePurchase}" autocomplete="off" />
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label fw-medium text-gray-800">Detail</label>
                                            <input type="text" name="detail" class="form-control" placeholder="Detail" value="${equipmentbyId.detail}" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="card shadow-sm mb-5 mb-xl-10">
                                <div class="card-header fs-4">
                                    <div class="card-title m-0">
                                        <h3 class="fw-semibold text-gray-900 m-0">More Detail</h3>
                                    </div>
                                </div>
                                <div class="card-body pt-6">
                                    <div class="row g-5 mb-5">
                                        <div class="col-md-6">
                                            <label class="form-label fw-medium text-gray-800">Windows</label>
                                            <input type="text" name="windows" class="form-control" value="${equipmentbyId.windows}" placeholder="Windows version" />
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label fw-medium text-gray-800">CPU</label>
                                            <input type="text" name="process" class="form-control" value="${equipmentbyId.process}" placeholder="CPU" />
                                        </div>
                                    </div>

                                    <div class="row g-5 mb-5">
                                        <div class="col-md-6">
                                            <label class="form-label fw-medium text-gray-800">Ram</label>
                                            <input type="text" name="ram" class="form-control" value="${equipmentbyId.ram}" placeholder="Ram (GB)" />
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label fw-medium text-gray-800">Storage</label>
                                            <input type="text" name="hdd" class="form-control" value="${equipmentbyId.hdd}" placeholder="Storage (GB)" />
                                        </div>
                                    </div>

                                    <div class="row g-5 mb-5">
                                        <div class="col-md-6">
                                            <label class="form-label fw-medium text-gray-800">Battery</label>
                                            <input type="text" name="battery" class="form-control" value="${equipmentbyId.battery}" placeholder="Battery (kWh)" />
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label fw-medium text-gray-800">WIFI Address</label>
                                            <input type="text" name="wifiaddress" class="form-control" value="${equipmentbyId.wifiaddress}" placeholder="WIFI address" />
                                        </div>
                                    </div>

                                    <div class="row g-5">
                                        <div class="col-md-6">
                                            <label class="form-label fw-medium text-gray-800">LAN Address</label>
                                            <input type="text" name="lanaddress" class="form-control" value="${equipmentbyId.lanaddress}" placeholder="LAN address" />
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label fw-medium text-gray-800">Display</label>
                                            <input type="text" name="display" class="form-control" value="${equipmentbyId.display}" placeholder="Display (inches)" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="d-flex justify-content-end pt-3">
                                <a href="equipment_list" class="btn btn-light me-3">Cancel</a>
                                <button type="submit" class="btn btn-success">Save</button>
                            </div>
                        </div>

                        <div class="col-xl-4">
                            
                            <div class="card shadow-sm mb-5 mb-xl-10">
                                <div class="card-header fs-4">
                                    <div class="card-title">
                                        <h3 class="fw-semibold m-0 bs-gray-900">Status log</h3>
                                    </div>
                                    <div class="card-toolbar">
                                        <div class="btn btn-sm btn-icon btn-active-light-primary" data-bs-toggle="collapse" data-bs-target="#kt_status_log_collapse">
                                            <i class="bi bi-chevron-down"></i>
                                        </div>
                                    </div>
                                </div>
                                <div class="collapse show" id="kt_status_log_collapse">
                                    <div class="card-body pt-0 pb-0">
                                        <c:choose>
                                            <c:when test="${not empty statusLogList}">
                                                <div class="timeline timeline-border-dashed">
                                                    <c:forEach var="log" items="${statusLogList}">
                                                        <div class="timeline-item mt-6">
                                                            <div class="timeline-icon">
                                                                <i class="ki-duotone ki-cd fs-2 text-gray-500" data-status-id="${log.status}" data-status-type="icon">
                                                                    <span class="path1"></span><span class="path2"></span>
                                                                </i>
                                                            </div>
                                                            <div class="timeline-content mb-5 mt-n1">
                                                                <div class="pe-3 mb-1">
                                                                    <div class="fs-6 fw-bold text-gray-800 mb-1">
                                                                        <span class="badge badge-light fw-bold fs-7" data-status-id="${log.status}" data-status-type="badge">
                                                                            ${log.status}
                                                                        </span>
                                                                    </div>
                                                                    <div class="d-flex align-items-center mt-1 fs-6">
                                                                        <div class="d-flex align-items-center mt-2 fs-7 text-muted">
                                                                            <i class="ki-duotone ki-calendar fs-4 text-gray-700 me-3">
                                                                                <span class="path1"></span><span class="path2"></span>
                                                                            </i>
                                                                            <div class="fs-5 fw-semibold text-gray-800">
                                                                                <c:set var="parsedDate" value="" />
                                                                                <c:catch var="errorNewFormat">
                                                                                    <fmt:parseDate value="${log.timeUpdate}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedDate" parseLocale="en_US" />
                                                                                </c:catch>
                                                                                <c:if test="${not empty errorNewFormat or empty parsedDate}">
                                                                                    <c:catch var="errorOldFormat">
                                                                                        <fmt:parseDate value="${log.timeUpdate}" pattern="dd-MM-yyyy" var="parsedDate" parseLocale="en_US" />
                                                                                    </c:catch>
                                                                                </c:if>
                                                                                <fmt:setLocale value="en_US" />
                                                                                <c:choose>
                                                                                    <c:when test="${not empty parsedDate}">
                                                                                        <fmt:formatDate value="${parsedDate}" pattern="d MMMM yyyy, HH:mm" />
                                                                                    </c:when>
                                                                                    <c:otherwise>${log.timeUpdate}</c:otherwise>
                                                                                </c:choose>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <c:if test="${not empty log.statusChange}">
                                                                        <div class="d-flex align-items-center mt-2 fs-7 text-muted">
                                                                            <i class="ki-duotone ki-message-text fs-4 text-gray-700 me-3">
                                                                                <span class="path1"></span><span class="path2"></span><span class="path3"></span>
                                                                            </i>
                                                                            <div class="fs-5 fw-semibold text-gray-800">
                                                                                ${log.statusChange}
                                                                            </div>
                                                                        </div>
                                                                    </c:if>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="separator separator-dashed border-gray-300 mb-6"></div>
                                                    </c:forEach>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="d-flex flex-column align-items-center justify-content-center py-10">
                                                    <i class="ki-duotone ki-cube-2 fs-3x text-gray-500 mb-4">
                                                        <span class="path1"></span><span class="path2"></span><span class="path3"></span>
                                                    </i>
                                                    <span class="text-gray-800 fw-semibold fs-5">No data</span>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>

                            <div class="card shadow-sm mb-5 mb-xl-10">
                                <div class="card-header fs-4">
                                    <div class="card-title">
                                        <h3 class="fw-semibold m-0 bs-gray-900">Usage History</h3>
                                    </div>
                                    <div class="card-toolbar">
                                        <c:if test="${not empty borrowlistwithUser}">
                                            <c:if test="${borrowlistwithUser[0].status == 'B'}">
                                                <button type="button" class="btn btn-sm btn-warning" data-bs-toggle="modal" data-bs-target="#modal_return_action">
                                                    Request for Return
                                                </button>
                                            </c:if>
                                        </c:if>
                                    </div>
                                </div>

                                <div class="card-body pt-0 mt-6">
                                    <c:choose>
                                        <c:when test="${not empty borrowlistwithUser}">
                                            <div class="timeline timeline-border-dashed">
                                                <c:forEach var="borrow" items="${borrowlistwithUser}">
                                                    
                                                    <c:if test="${borrow.status == 'R'}">
                                                        <div class="timeline-item">
                                                            <div class="timeline-line"></div>
                                                            <div class="timeline-icon">
                                                                <i class="ki-duotone ki-cd fs-2 text-success"><span class="path1"></span><span class="path2"></span></i>
                                                            </div>
                                                            <div class="timeline-content mb-5 mt-n1">
                                                                <div class="mb-2"><span class="badge badge-success fw-bold fs-7">Returned</span></div>
                                                                <div class="d-flex align-items-center mt-4 mb-2">
                                                                    <i class="ki-duotone ki-user fs-4 text-gray-700 me-3"><span class="path1"></span><span class="path2"></span></i>
                                                                    <div class="fs-5 fw-semibold text-gray-800">
                                                                        <c:if test="${not empty borrow.employee_id}">${borrow.employee_id} - </c:if>${borrow.name}
                                                                        <c:if test="${not empty borrow.name_en}"> - ${borrow.name_en}</c:if>
                                                                    </div>
                                                                </div>
                                                                <div class="d-flex align-items-center mt-4 fs-7 text-muted">
                                                                    <i class="ki-duotone ki-calendar fs-4 text-gray-700 me-3"><span class="path1"></span><span class="path2"></span></i>
                                                                    <div class="fs-5 fw-semibold text-gray-800">
                                                                        <c:choose>
                                                                            <c:when test="${not empty borrow.date_end}">
                                                                                <fmt:setLocale value="en_US" />
                                                                                <fmt:formatDate value="${borrow.date_end}" pattern="d MMMM yyyy, HH:mm" />
                                                                            </c:when>
                                                                            <c:otherwise>Unknown Return Date</c:otherwise>
                                                                        </c:choose>
                                                                    </div>
                                                                </div>
                                                                <c:if test="${not empty borrow.location}">
                                                                    <div class="d-flex align-items-center mt-4 mb-2 fs-7 text-muted">
                                                                        <i class="ki-duotone ki-geolocation fs-2 me-3"><span class="path1"></span><span class="path2"></span></i>
                                                                        <div class="fs-5 fw-semibold text-gray-800">${borrow.location}</div>
                                                                    </div>
                                                                </c:if>
                                                            </div>
                                                        </div>
                                                    </c:if>

                                                    <div class="timeline-item">
                                                        <div class="timeline-icon">
                                                            <i class="ki-duotone ki-cd fs-2 text-warning"><span class="path1"></span><span class="path2"></span></i>
                                                        </div>
                                                        <div class="timeline-content mb-0 mt-n1">
                                                            <div class="mb-2">
                                                                <span class="badge badge-warning fw-bold fs-7">${borrow.status == 'B' ? 'Borrowing' : 'Borrowed'}</span>
                                                            </div>
                                                            <div class="d-flex align-items-center mt-4 mb-2">
                                                                <i class="ki-duotone ki-user fs-4 text-gray-700 me-3"><span class="path1"></span><span class="path2"></span></i>
                                                                <div class="fs-5 fw-semibold text-gray-800">
                                                                    <c:if test="${not empty borrow.employee_id}">${borrow.employee_id} - </c:if>${borrow.name}
                                                                    <c:if test="${not empty borrow.name_en}"> - ${borrow.name_en}</c:if>
                                                                </div>
                                                            </div>
                                                            <div class="d-flex align-items-center mt-4 fs-7 text-muted">
                                                                <i class="ki-duotone ki-calendar fs-4 text-gray-700 me-3"><span class="path1"></span><span class="path2"></span></i>
                                                                <div class="fs-5 fw-semibold text-gray-800">
                                                                    <fmt:setLocale value="en_US" />
                                                                    <fmt:formatDate value="${borrow.date_start}" pattern="d MMMM yyyy, HH:mm" />
                                                                </div>
                                                            </div>
                                                            <c:if test="${not empty borrow.location}">
                                                                <div class="d-flex align-items-center mt-4 fs-7 text-muted">
                                                                    <i class="ki-duotone ki-geolocation fs-4 text-gray-700 me-3"><span class="path1"></span><span class="path2"></span></i>
                                                                    <div class="fs-5 fw-semibold text-gray-800">${borrow.location}</div>
                                                                </div>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                    <div class="separator separator-dashed border-gray-300 my-5"></div>
                                                </c:forEach>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="d-flex flex-column align-items-center justify-content-center py-10">
                                                <i class="ki-duotone ki-cube-2 fs-3x text-gray-500 mb-4">
                                                    <span class="path1"></span><span class="path2"></span><span class="path3"></span>
                                                </i>
                                                <span class="text-gray-800 fw-semibold fs-5">No data</span>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modal_return_action" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered mw-700px">
        <div class="modal-content">
            <div class="modal-header pb-0 border-0 justify-content-between">
                <h2 class="fw-bold m-0 text-gray-800 ps-4 pt-4">Request for Return Equipment</h2>
                <div class="btn btn-sm btn-icon btn-active-color-primary" data-bs-dismiss="modal">
                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                </div>
            </div>

            <div class="modal-body scroll-y px-10 px-lg-8 pt-5 pb-15">
                <div class="rounded p-6 mb-8">
                    <div class="row g-5 mb-6">
                        <div class="col-md-6 d-flex align-items-center gap-3">
                            <span class="fs-5 fw-bold text-primary">ID: ${equipmentbyId.itemNo}</span>
                            <span class="badge badge-primary fs-7 fw-bold px-3 py-2">Borrowed</span>
                        </div>
                        <div class="col-md-6 d-flex align-items-center gap-2">
                            <i id="modal_equipment_icon" class="ki-solid ki-dots-square fs-1 me-2 text-gray-500"></i>
                            <span class="fs-5 fw-bold text-gray-800">${equipmentbyId.name}</span>
                        </div>
                    </div>

                    <div class="row g-5 mb-5">
                        <div class="col-md-6">
                            <span class="text-gray-700 fw-normal fs-5 me-2">Serial No:</span>
                            <span class="text-gray-800 fw-normal fs-5">${equipmentbyId.serialNo}</span>
                        </div>
                        <div class="col-md-6">
                            <span class="text-gray-700 fw-normal fs-5 me-2">Amount:</span>
                            <span class="text-gray-800 fw-normal fs-5">${equipmentbyId.amount}</span>
                        </div>
                        <div class="col-md-6">
                            <span class="text-gray-700 fw-normal fs-5 me-2">Detail:</span>
                            <span class="text-gray-800 fw-normal fs-5">${equipmentbyId.detail}</span>
                        </div>
                        <div class="col-md-6">
                            <span class="text-gray-700 fw-normal fs-5 me-2">Date of Purchase:</span>
                            <span class="text-gray-800 fw-normal fs-5">
                                <fmt:setLocale value="en_US" />
                                <fmt:formatDate value="${equipmentbyId.timeCreate}" pattern="dd MMM yyyy" />
                            </span>
                        </div>
                    </div>

                    <div class="mb-0">
                        <a href="#" class="text-primary text-hover-primary fw-normal fs-5 mb-3 rotate collapsible collapsed" data-bs-toggle="collapse" data-bs-target="#kt_view_equipment_more_details_edit">
                            More Detail 
                            <span class="d-flex flex-center rotate-n180 ms-2">
                                <i class="ki-duotone ki-down fs-5"><span class="path1"></span><span class="path2"></span></i>
                            </span>
                        </a>

                        <div id="kt_view_equipment_more_details_edit" class="collapse">
                            <div class="row g-5 pt-2">
                                <div class="col-md-6">
                                    <span class="text-gray-700 fw-normal fs-5 me-2">Windows</span>
                                    <span class="fw-normal fs-5 text-gray-800">${not empty equipmentbyId.windows ? equipmentbyId.windows : '-'}</span>
                                </div>
                                <div class="col-md-6">
                                    <span class="text-gray-700 fw-normal fs-5 me-2">CPU</span>
                                    <span class="fw-normal fs-5 text-gray-800">${not empty equipmentbyId.process ? equipmentbyId.process : '-'}</span>
                                </div>
                                <div class="col-md-6">
                                    <span class="text-gray-700 fw-normal fs-5 me-2">Ram</span>
                                    <span class="fw-normal fs-5 text-gray-800">${not empty equipmentbyId.ram ? equipmentbyId.ram : '-'}</span>
                                </div>
                                <div class="col-md-6">
                                    <span class="text-gray-700 fw-normal fs-5 me-2">Storage</span>
                                    <span class="fw-normal fs-5 text-gray-800">${not empty equipmentbyId.hdd ? equipmentbyId.hdd : '-'}</span>
                                </div>
                                <div class="col-md-6">
                                    <span class="text-gray-700 fw-normal fs-5 me-2">Battery</span>
                                    <span class="fw-normal fs-5 text-gray-800">${not empty equipmentbyId.battery ? equipmentbyId.battery : '-'}</span>
                                </div>
                                <div class="col-md-6">
                                    <span class="text-gray-700 fw-normal fs-5 me-2">Display</span>
                                    <span class="fw-normal fs-5 text-gray-800">${not empty equipmentbyId.display ? equipmentbyId.display : '-'}</span>
                                </div>
                                <div class="col-md-6">
                                    <span class="text-gray-700 fw-normal fs-5 me-2">WIFI Address</span>
                                    <span class="fw-normal fs-5 text-gray-800">${not empty equipmentbyId.wifiaddress ? equipmentbyId.wifiaddress : '-'}</span>
                                </div>
                                <div class="col-md-6">
                                    <span class="text-gray-700 fw-normal fs-5 me-2">LAN Address</span>
                                    <span class="fw-normal fs-5 text-gray-800">${not empty equipmentbyId.lanaddress ? equipmentbyId.lanaddress : '-'}</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="view_borrow_section">
                        <div class="separator separator-dashed border-gray-300 my-10"></div>
                        <div class="d-flex align-items-center mb-5">
                            <span class="fs-5 fw-bold text-gray-800 me-3">Borrow ID</span>
                            <span class="fs-5 fw-bold text-primary">ID: ${equipmentbyId.itemNo}</span>
                        </div>
                        <div class="row g-5 mb-5" id="view_borrow_detailed_info">
                            <div class="col-12">
                                <div class="d-flex flex-wrap align-items-center">
                                    <span class="text-gray-700 fw-normal fs-5 me-2">Borrow by:</span>
                                    <span class="fs-5 text-gray-800 fw-medium">
                                        <c:if test="${not empty borrowlistwithUser[0].employee_id}">${borrowlistwithUser[0].employee_id} - </c:if>
                                        ${borrowlistwithUser[0].name}
                                        <c:if test="${not empty borrowlistwithUser[0].name_en}"> - ${borrowlistwithUser[0].name_en}</c:if>
                                    </span>
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="d-flex align-items-center">
                                    <span class="text-gray-700 fw-normal fs-5 me-2">Location:</span>
                                    <span class="text-gray-800 fw-normal fs-5">${borrowlistwithUser[0].location}</span>
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="d-flex align-items-center">
                                    <span class="text-gray-700 fw-normal fs-5 me-2">Borrow Date:</span>
                                    <span class="text-gray-800 fw-normal fs-5">
                                        <fmt:formatDate value="${borrowlistwithUser[0].date_start}" pattern="dd MMM yyyy, HH:mm" /> - None
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="edit_return_section" class="mt-5">
                        <div class="separator separator-dashed border-gray-300 my-10"></div>
                        <div class="mb-3">
                            <label class="fw-bold mb-2 text-primary fs-5">Approver</label>
                            <div class="form-label fw-medium text-gray-800 mb-2">Specify a note when changing status (optional)</div>
                            <textarea id="edit_return_note" class="form-control" rows="3" placeholder="Enter maintenance or repair notes..."></textarea>
                        </div>
                    </div>
                </div>

                <div class="d-flex justify-content-end align-items-center gap-3">
                    <button type="button" class="btn btn-light fw-bold" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" id="btn_confirm_return_edit" class="btn btn-warning fw-bold">
                        Request for Return
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Image Preview Logic
    document.addEventListener('DOMContentLoaded', function () {
        const fileInput   = document.getElementById('itemImageInput');
        const previewImg  = document.getElementById('itemImagePreview');
        const placeholder = document.getElementById('itemImagePlaceholder');
        const selectBtn   = document.getElementById('itemImageSelectBtn');

        if (!fileInput || !previewImg || !selectBtn) return;

        selectBtn.addEventListener('click', function () { fileInput.click(); });

        fileInput.addEventListener('change', function (e) {
            const file = e.target.files[0];
            if (!file) return;

            const reader = new FileReader();
            reader.onload = function (ev) {
                previewImg.src = ev.target.result;
                previewImg.style.display = 'block';
                if (placeholder) placeholder.classList.add('d-none');
            };
            reader.readAsDataURL(file);
        });
    });

    // Main Logic & Modal
    $(document).ready(function() {
        
        // Initialization Data
        var typeList = ${type != null ? type : '[]'};
		var statusList = ${status != null ? status : '[]'};
        var savedTypeID = "${equipmentbyId.type}";
        var savedStatusID = "${equipmentbyId.status}";

        try {
            if (rawType) typeList = JSON.parse(rawType);
            if (rawStatus) statusList = JSON.parse(rawStatus);
        } catch (e) { console.error("Error parsing JSON", e); }
        
     // Update Icon Type
        if (typeList && typeList.length > 0) {
            var foundType = typeList.find(function(item) {
                var tId = item.TypeID || item.typeID || item.type; 
                return tId == savedTypeID;
            });

            if (foundType) {
                var iconClass = foundType.typeText; 
                
                if (iconClass) {
                    $('#modal_equipment_icon').attr('class', iconClass + ' fs-1 me-2 text-gray-500');
                }
            }
        }
        
        // Status Log & Badge Logic
        var STATUS_MAP = {};
        
        // Create Map
        if(statusList && statusList.length > 0){
            $.each(statusList, function(i, item) {
                var id = item.statusId || item.statusID || item.status; 
                STATUS_MAP[id] = item;
            });
        }
        
        // Update Badges
        $('[data-status-type="badge"]').each(function() {
            var id = $(this).attr('data-status-id');
            var config = STATUS_MAP[id];
            
            // Reset class
            $(this).removeClass(function(index, className) {
                return (className.match(/(^|\s)badge-\S+/g) || []).join(' ');
            }).addClass('badge-light');

            if(config) {
                var color = config.color2 || 'secondary';
                $(this).addClass('badge-' + color);
                $(this).text(config.description || id);
            }
        });

        // Update Status Badges
        $('[data-status-type="icon"]').each(function() {
            var id = $(this).attr('data-status-id');
            var config = STATUS_MAP[id];
            
            $(this).removeClass(function(index, className) {
                return (className.match(/(^|\s)text-\S+/g) || []).join(' ');
            });

            if(config && config.color2) {
                var colorToUse = config.color2;
                if (config.description === 'Disabled' || colorToUse === 'secondary') {
                    colorToUse = 'gray-500';
                }
                $(this).addClass('text-' + colorToUse);
            } else {
                $(this).addClass('text-gray-500');
            }
        });

        // Populate Selects
        var $typeSelect = $('#typeSelect');
        var typeOptions = '<option></option>';
        $.each(typeList, function(index, item) {
            var id = item.TypeID || item.typeID || item.type;
            var desc = item.description;
            var isSelected = (id == savedTypeID) ? 'selected' : ''; 
            typeOptions += '<option value="' + id + '" ' + isSelected + '>' + desc + '</option>';
        });
        $typeSelect.html(typeOptions);

        var $statusSelect = $('#statusSelect');
        var statusOptions = '<option></option>';
        $.each(statusList, function(index, item) {
            var id = item.statusId || item.statusID || item.status;
            var desc = item.description;
            var isSelected = (id == savedStatusID) ? 'selected' : '';
            statusOptions += '<option value="' + id + '" ' + isSelected + '>' + desc + '</option>';
        });
        $statusSelect.html(statusOptions);

        // Init Components
        $('#typeSelect, #statusSelect').select2({ minimumResultsForSearch: Infinity });
        $("#kt_datepicker_1").flatpickr({ dateFormat: "d M Y" });

        // Toggle More Detail
        var moreDetailCollapse = document.getElementById('kt_view_equipment_more_details_edit');
        if (moreDetailCollapse) {
            moreDetailCollapse.addEventListener('show.bs.collapse', function () {
                $('#view_borrow_detailed_info').slideUp();
            });
            moreDetailCollapse.addEventListener('hide.bs.collapse', function () {
                $('#view_borrow_detailed_info').slideDown();
            });
        }
        
        // Modal: Return Action
        $('#modal_return_action').on('show.bs.modal', function () {
            $('#edit_return_note').val('');
            $('#btn_confirm_return_edit').prop('disabled', false).text('Request for Return');
        });

        $('#btn_confirm_return_edit').click(function() {
            var note = $('#edit_return_note').val();
            var eqId = '${equipmentbyId.equipmentId}';
            var borrowId = '${not empty borrowlistwithUser ? borrowlistwithUser[0].borrow_id : ""}'; 
            
            var btn = $(this);
            var originalText = btn.text();

            btn.prop('disabled', true).text('Processing...');

            $.post('equipment_return', { 
                equipmentId: eqId, 
                borrowId: borrowId,
                note: note
            }, function(res) {
                if(res === 'success') {
                    location.reload();
                } else {
                    alert('Error returning item.');
                    btn.prop('disabled', false).text(originalText);
                }
            });
        });
        
     	// เช็ค Duplicate Item No
     	var originalItemNo = $('#itemNo').val().trim();
        $('#itemNo').on('blur', function() {
            var itemNoVal = $(this).val().trim();
            var $input = $(this);
            var $feedback = $('#itemNoFeedback');
            var $btnSave = $('button[type="submit"]');

            if(itemNoVal === "") return;
            if (itemNoVal === originalItemNo) {
                $input.removeClass('is-invalid');
                $feedback.hide();
                $btnSave.prop('disabled', false);
                return;
            }
            
            $.ajax({
                url: 'check_item_no', 
                method: 'POST',
                data: { itemNo: itemNoVal },
                dataType: 'json',
                success: function(response) {

                    if (response.message === 'used') {
                        $input.removeClass('border-success'); 
                        $input.addClass('is-invalid'); 
                        
                        $feedback.text('This item No. already exists in the system. (Used by: ' + response.name + ')').show();
                        $btnSave.prop('disabled', true);
                    } else {
                        $input.removeClass('is-invalid'); 
                        $input.addClass('border-success');
                        $feedback.hide();
                        $btnSave.prop('disabled', false);
                    }
                },
                error: function() { console.error("Error checking item no."); }
            });
        });
    
    });
</script>