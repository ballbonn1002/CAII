<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<fmt:setLocale value="en_US" />

<input type="hidden" id="hasSignature" value="${hasSignature}" />
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
                                    <div class="card-title m-0 m-0 d-flex justify-content-between align-items-center w-100">
                                        <div class="d-flex align-items-center flex-wrap gap-4">
                                            <h3 class="fw-semibold m-0 text-gray-900">Equipment</h3>
                                            <%-- ข้อมูลที่เข้ารหัสใน QR = ลิงก์หน้าผลสแกน (qrLink จาก EquipmentAction.eEdit ใช้ equipment_id ที่ไม่เปลี่ยน)
                                                 Label ใต้ QR = "Item No. : ชื่อ" (ไม่มี Item No. ใช้ equipment_id แทน)
                                                 แก้ไขเป็นค่าอื่นได้ในช่อง input ของ modal - type="button" กันไม่ให้ submit ฟอร์ม --%>
                                            <c:choose>
                                                <c:when test="${not empty fn:trim(equipmentbyId.itemNo)}"><c:set var="qrLabelDefault" value="${fn:trim(equipmentbyId.itemNo)} : ${fn:trim(equipmentbyId.name)}" /></c:when>
                                                <c:otherwise><c:set var="qrLabelDefault" value="${equipmentbyId.equipmentId} : ${fn:trim(equipmentbyId.name)}" /></c:otherwise>
                                            </c:choose>
                                            <button type="button" id="btnOpenQrModal" class="btn btn-sm btn-light-primary"
                                                    data-qr-value="${fn:escapeXml(qrLink)}"
                                                    data-qr-label="${fn:escapeXml(fn:trim(qrLabelDefault))}"
                                                    data-qr-configured="${qrLinkConfigured}">
                                                <i class="bi bi-qr-code-scan me-2"></i>Generate QR Code
                                            </button>
                                        </div>

                                        <span class="fs-6">Create By : ${userCreate.name}, <fmt:formatDate value='${userCreate.time_create}' pattern='d MMM YYYY HH:mm' /> </span>
                                    </div>
                                </div>

                                <div class="card-body pt-8">
                                    <div class="row">
                                        <div class="col-lg-6 mb-8">
                                            <label class="d-block fw-medium form-label mb-3">Item Picture</label>
                                            <div class="d-flex flex-column align-items-start">
                                                <div id="errorMsg" class="text-center text-danger mb-3"></div>
                                                <c:set var="imageSrc" value="" />
                                                <c:if test="${not empty equipmentbyId.image}">
                                                    <c:set var="imageSrc" value="${pageContext.request.contextPath}${equipmentbyId.image}" />
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
                                        <div class="col-12">
                                            <label class="form-label fw-medium text-gray-800" for="productSelect">
                                                Reference Product
                                                <span class="text-muted fw-normal">(Equipment Catalog)</span>
                                            </label>
                                            <%-- อ้างอิงไปตาราง product (product_type = '1' Equipment) - ไม่บังคับเลือก
                                                 ดึงรายการผ่าน action ที่มีอยู่แล้ว get_items_catalog (PurchaseOrderAction.getItemsCatalog) --%>
                                            <select class="form-select" name="productId" id="productSelect" data-control="select2" data-placeholder="Select Product">
                                                <option></option>
                                            </select>
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
                                        
                                        <div class="py-5">
                                        	<span>Create By : ${userCreate.name}, <fmt:formatDate value='${userCreate.time_create}' pattern='d MMM YYYY HH:mm' /> </span>
                                        </div>
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
	                                        <c:choose>
													<c:when test="${borrowlistwithUser[0].status == 'B'
																 and not empty borrowlistwithUser[0].user_delivery
																 and empty borrowlistwithUser[0].user_receive
																 and empty borrowlistwithUser[0].user_return
																 and empty borrowlistwithUser[0].user_return_receive}">
														<button type="button" class="btn btn-sm btn-secondary" disabled>
															Waiting to Receive
														</button>
													</c:when>
													
													<c:when test="${borrowlistwithUser[0].status == 'B'
																 and not empty borrowlistwithUser[0].user_delivery
																 and not empty borrowlistwithUser[0].user_receive
																 and empty borrowlistwithUser[0].user_return
																 and empty borrowlistwithUser[0].user_return_receive}">
														<button type="button" class="btn btn-sm btn-warning btn-request-return">
															Request for Return
														</button>
													</c:when>
													
													<c:when test="${borrowlistwithUser[0].status == 'T'
																 and not empty borrowlistwithUser[0].user_delivery
																 and not empty borrowlistwithUser[0].user_receive
																 and empty borrowlistwithUser[0].user_return
																 and empty borrowlistwithUser[0].user_return_receive}">
														<button type="button" class="btn btn-sm btn-secondary" disabled>
																Waiting for Return
														</button>
													</c:when>
													
													<c:when test="${borrowlistwithUser[0].status == 'T'
																 and not empty borrowlistwithUser[0].user_delivery
																 and not empty borrowlistwithUser[0].user_receive
																 and not empty borrowlistwithUser[0].user_return
																 and empty borrowlistwithUser[0].user_return_receive}">
														<button type="button" class="btn btn-sm btn-success" data-bs-toggle="modal" data-bs-target="#modal_return_action">
															Confirm Received
														</button>
													</c:when>
													
													<c:otherwise></c:otherwise>
												
												</c:choose>
                                        </c:if>
                                    </div>
                                </div>

                                <div class="card-body pt-0 mt-6">
                                    <c:choose>
                                        <c:when test="${not empty borrowlistwithUser}">
                                            <div class="timeline timeline-border-dashed">
                                                <c:forEach var="borrow" items="${borrowlistwithUser}">
                                                    <c:set var="isReturned" value="${borrow.status == 'R'}" />
                                                    <c:if test="${borrow.status == 'R'}">
                                                        <div class="timeline-item">
                                                            <div class="timeline-line"></div>
                                                            <div class="timeline-icon">
                                                                <i class="ki-duotone ki-cd fs-2 text-success"><span class="path1"></span><span class="path2"></span></i>
                                                            </div>
                                                            <div class="timeline-content mb-5 mt-n1">
                                                                <div class="mb-2"><span class="badge badge-success fw-bold fs-7">Returned</span> 
                                                                	<c:if test="${isReturned}">
	                                                                	<a href="${pageContext.request.contextPath}/borrowReport?borrowId=${borrow.borrow_id}" target="_blank" class="badge badge-light-success ms-3" title="Borrow Report">
																		    Print <i class="ki-duotone ki-printer fs-3 ms-2 text-success">
																			    <span class="path1"></span>
																			    <span class="path2"></span>
																			    <span class="path3"></span>
																			    <span class="path4"></span>
																			    <span class="path5"></span>
																		    </i>
																	    </a>
																    </c:if>
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
                                                                    
                                                                        <c:choose>
                                                                            <c:when test="${not empty borrow.date_end}">
                                                                                <fmt:setLocale value="en_US" />
                                                                                <fmt:formatDate value="${borrow.date_end}" pattern="d MMMM yyyy, HH:mm" />
                                                                            </c:when>
                                                                            <c:when test="${not empty borrow.time_return}">
																		        <fmt:setLocale value="en_US" />
																		        <fmt:formatDate value="${borrow.time_return}"
																		            pattern="d MMMM yyyy, HH:mm" />
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
                                                                <c:if test="${borrow.status != 'R'}">
                                                                	<a href="${pageContext.request.contextPath}/borrowReport?borrowId=${borrow.borrow_id}" target="_blank" class="badge badge-light-success ms-3" title="Borrow Report">
																	    Print <i class="ki-duotone ki-printer fs-3 ms-2 text-success">
																		    <span class="path1"></span>
																		    <span class="path2"></span>
																		    <span class="path3"></span>
																		    <span class="path4"></span>
																		    <span class="path5"></span>
																	    </i>
																    </a>
																 </c:if>
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
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header border-0 px-6 pt-5 pb-0 align-items-center">
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
                            <span class="fs-5 fw-bold text-gray-800 me-3">Borrow ID:</span>
                            <span class="fs-5 fw-bold text-primary">${borrowlistwithUser[0].borrow_id}</span>
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
                    <button type="button" id="btn_confirm_return_edit" class="btn btn-success fw-bold">
                       Confirm Received
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<%-- ============ Modal: Generate QR Code (qrcode.js เก็บไว้ในโปรเจกต์ ไม่พึ่ง CDN)
     อยู่นอก <form> และ input ไม่มี attribute name จึงไม่ถูกส่งไปกับฟอร์ม Save
     - Label = ข้อความที่แสดงใต้ QR (ว่าง = ไม่แสดง) / ข้อมูลที่เข้ารหัส = เนื้อหาใน QR จริง ============ --%>
<div class="modal fade" id="qrGenerateModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title fw-bold text-gray-900">Generate QR Code</h3>
                <button type="button" class="btn btn-icon btn-sm btn-active-light-primary" data-bs-dismiss="modal" aria-label="Close">
                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                </button>
            </div>
            <div class="modal-body">
                <div class="mb-5">
                    <label class="form-label fw-semibold text-gray-700" for="qrLabelInput">Label ใต้ QR Code</label>
                    <input type="text" id="qrLabelInput" class="form-control form-control-solid" maxlength="100" autocomplete="off" />
                </div>
                <div class="mb-5">
                    <label class="form-label fw-semibold text-gray-700" for="qrGenerateInput">ข้อมูลที่จะเข้ารหัสใน QR</label>
                    <input type="text" id="qrGenerateInput" class="form-control form-control-solid" maxlength="500" autocomplete="off" />
                    <%-- เตือนเมื่อยังไม่ตั้งค่า qr.base.url (ลิงก์ชี้ไปเครื่องที่เปิดอยู่ เช่น localhost) --%>
                    <div id="qrLinkNotConfigured" class="form-text text-warning d-none">ยังไม่ได้ตั้งค่าโดเมนของลิงก์ QR (qr.base.url) ลิงก์นี้ชี้ไปที่เครื่องที่เปิดอยู่ ใช้ทดสอบได้ แต่อย่าพิมพ์ป้ายจริง</div>
                </div>
                <div class="text-center">
                    <div id="qrGenerateCanvas" class="d-inline-block p-4 bg-white rounded border"></div>
                    <div id="qrLabelPreview" class="fw-semibold text-gray-800 text-center mt-3"></div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-light-primary" id="btnQrPrint">
                    <i class="ki-duotone ki-printer fs-3 me-1"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i>
                    Print
                </button>
                <button type="button" class="btn btn-primary" id="btnQrDownload">
                    <i class="ki-duotone ki-exit-down fs-3 me-1"><span class="path1"></span><span class="path2"></span></i>
                    Download
                </button>
            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/assets/plugins/custom/qrcode/qrcode.min.js"></script>
<script>
    // Image Preview Logic
    document.addEventListener('DOMContentLoaded', function () {
        const fileInput   = document.getElementById('itemImageInput');
        const previewImg  = document.getElementById('itemImagePreview');
        const placeholder = document.getElementById('itemImagePlaceholder');
        const selectBtn   = document.getElementById('itemImageSelectBtn');
        const errorMsg = document.getElementById('errorMsg');

        if (!fileInput || !previewImg || !selectBtn) return;

        selectBtn.addEventListener('click', function () { fileInput.click(); });

        fileInput.addEventListener('change', async function (e) {
            const file = e.target.files[0];
            if (!file) return;
            errorMsg.textContent = "";
            
            if (!file.type.startsWith('image/')) {
                errorMsg.textContent = "Please select an image file.";
                fileInput.value = "";
                return;
            }
            

            
            const reader = new FileReader();
            reader.onload = function (ev) {
                previewImg.src = ev.target.result;
                previewImg.style.display = 'block';
                if (placeholder) placeholder.classList.add('d-none');
            };
            reader.readAsDataURL(file);
            
         // Compress รูปถ้าเกิน 500KB
            const limitSize = 500 * 1024;

            if (file.size > limitSize) {
                try {
                    const compressedFile = await compressImage(file, 1280, 1280, 0.8);
                    const dataTransfer = new DataTransfer();
                    dataTransfer.items.add(compressedFile);
                    fileInput.files = dataTransfer.files;
                } catch (error) {
                    console.error("Compress Error:", error);
                }
            }
        });
    });

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

    // Main Logic & Modal
    $(document).ready(function() {
        
        // Initialization Data
        var typeList = ${type != null ? type : '[]'};
		var statusList = ${status != null ? status : '[]'};
        var savedTypeID = "${equipmentbyId.type}";
        var savedStatusID = "${equipmentbyId.status}";
        var savedProductId = "${equipmentbyId.productId}";

        /* try {
            if (rawType) typeList = JSON.parse(rawType);
            if (rawStatus) statusList = JSON.parse(rawStatus);
        } catch (e) { console.error("Error parsing JSON", e); } */
        var rawType = '${requestScope.type != null ? requestScope.type : "[]"}';
        var rawStatus = '${requestScope.status != null ? requestScope.status : "[]"}';

        var typeList = [];
        var statusList = [];

        try {
            typeList = JSON.parse(rawType);
            statusList = JSON.parse(rawStatus);
        } catch (e) {
            console.error("Error parsing JSON", e);
        }
        
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
        $('#productSelect').select2({ placeholder: 'Select Product', allowClear: true });

        // ---- Reference Product (Equipment Catalog) ----
        // ใช้ endpoint เดิม get_items_catalog (PurchaseOrderAction.getItemsCatalog) แทนการทำ action ใหม่
        // includeSubProducts: true = ดึงทั้ง product ตัวแม่และ sub product มาให้เลือกด้วย
        // (ต่างจากหน้า Purchase Order ที่ไม่ส่ง flag นี้ จึงยังได้เฉพาะตัวแม่เหมือนเดิม)
        $.ajax({
            url: 'get_items_catalog',
            type: 'POST',
            dataType: 'json',
            data: { itemsType: 'equipment', includeSubProducts: 'true' },
            success: function (resp) {
                var data = resp.data;
                var list = (data && data.productList) || [];
                var options = '<option></option>';
                $.each(list, function (index, item) {
                    var isSelected = (String(item.id) === savedProductId) ? 'selected' : '';
                    options += '<option value="' + item.id + '" ' + isSelected + '>' + item.name + '</option>';
                });
                $('#productSelect').html(options).trigger('change');
            },
            error: function () {
                console.error('Error loading product catalog.');
            }
        });
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
        
     // ----- Request for Return -----
		$('.btn-request-return').on('click',function(e){
			e.preventDefault();
			
			Swal.fire({
				title: 'Confirm Request for Return?',
		        text: 'Are you sure you want to request return for this item?',
		        icon: 'question',
		        showCancelButton: true,
		        confirmButtonText: 'Yes, Request Return',
		        cancelButtonText: "Cancel",
		        buttonsStyling: false,
		        customClass: {
		            confirmButton: "btn btn-success",
		            cancelButton: "btn btn-secondary"
		        }
		    }).then((result) => {
		        if (result.isConfirmed) {
		        	const borrowId = '${not empty borrowlistwithUser ? borrowlistwithUser[0].borrow_id : ""}';
		        	
		        	fetch("${pageContext.request.contextPath}/request_return.action", {
		        	    method: "POST",
		        	    headers: {
		        	        "Content-Type": "application/x-www-form-urlencoded"
		        	    },
		        	    body: "id=" + encodeURIComponent(borrowId)
		        	})
		        	.then(response => response.text())
		        	.then(data => {
		        	    location.reload();
		        	})
		        	.catch(error => {
		        	    console.error(error);

		        	    Swal.fire({
		        	        icon: "error",
		        	        title: "Error",
		        	        text: "Failed to deliver equipment"
		        	    });

		        	});
		        }
		    });
		})
		
        // Modal: Return Action
        $('#modal_return_action').on('show.bs.modal', function () {
            $('#edit_return_note').val('');
            $('#btn_confirm_return_edit').prop('disabled', false).text('Confirm Received');
        });

        $('#btn_confirm_return_edit').click(function() {
        	if (!checkSignatureBeforeAction()) {
				return;
			}
        	var CTX = "${pageContext.request.contextPath}";
            var note = $('#edit_return_note').val();
            var eqId = '${equipmentbyId.equipmentId}';
            var borrowId = '${not empty borrowlistwithUser ? borrowlistwithUser[0].borrow_id : ""}'; 
            
            var btn = $(this);
            var originalText = btn.text();

            btn.prop('disabled', true).text('Processing...');

            /* $.post('equipment_return', { 
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
            }); */
            Swal.fire({
    	    	title: "Confirm Received?",
    	        text: "Have you return received this equipment?",
    	        icon: "question",
    	        showCancelButton: true,
    	        confirmButtonText: "Yes, received it",
    	        cancelButtonText: 'Cancel',
    	        buttonsStyling: false,
    	        customClass: {
    	            confirmButton: "btn btn-warning",
    	            cancelButton: "btn btn-secondary"
    	        }
    	    }).then((result) => {
    	        if (result.isConfirmed) {
    	            $.ajax({
    	                url: CTX + "/equipment_return",
    	                type: "POST",
    	                data: {
    	                	equipmentId: eqId, 
    	                    borrowId: borrowId,
    	                    note: note
    	                },
    	                success: function(res) {
    	                    res = $.trim(res);
    	                    if (res === 'success') {

    	                        Swal.fire({
    	                        	icon: 'success',
    	                            title: 'Success!',
    	                            text: 'Return request submitted successfully!'
    	                        }).then(() => {
    	                            var modal = bootstrap.Modal.getInstance(
    	                                document.getElementById('kt_modal_view_equipment')
    	                            );

    	                            if (modal) {
    	                                modal.hide();
    	                            }

    	                            window.open(CTX + "/borrowReport?borrowId=" + borrowId, "_blank");
    	                            location.reload();
    	                        });

    	                    } else if (res === 'login') {
    	                        window.location.href = 'index.jsp';
    	                    } else {

    	                        Swal.fire('Error!', 'Error returning item.','error');

    	                        btnConfirmReceived
    	                            .prop('disabled', false)
    	                            .text(originalText);
    	                    }
    	                },
    	                error: function(xhr) {
    	                    console.error("HTTP", xhr.status, xhr.responseText);
    	                    Swal.fire('Error!', 'Failed to submit return request.', 'error');
    	                }
    	            });
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
    
    function checkSignatureBeforeAction() {
		const hasSignature = $('#hasSignature').val() === 'true';
	    
	    if (!hasSignature) {
	        Swal.fire({
	            title: "Signature Required!",
	            text: "Please upload your signature before continuing.",
	            icon: "warning",
	            confirmButtonText: "Go to My Profile",
	            showCancelButton: true,
	            cancelButtonText: "Cancel",
	            buttonsStyling: false,
	            customClass: {
	                confirmButton: "btn btn-warning",
	                cancelButton: "btn btn-secondary"
	            }
	        }).then((result) => {
	            if (result.isConfirmed) {
	            	window.open("/my_profile", "_blank");
	            }
	        });
	        return false;
	    }
	    return true;
	}
</script>

<%-- ==================== Generate QR Code: ปุ่มที่หัวการ์ด Equipment เปิด modal พรีวิว QR ของ item นี้ ====================
     qrcodejs วาดเป็น <canvas> ใน #qrGenerateCanvas (ไว้ preview สดๆ ตอนพิมพ์แก้ข้อความ)
     แต่ Print/Download ไม่ได้ใช้ canvas นั้นตรงๆ - ต้อง "ประกอบใหม่" ผ่าน buildPrintableQrCanvas() ก่อนเสมอ เพราะ:
       1) ขอบขาวรอบโค้ด (Quiet Zone) ที่เห็นในหน้าจอเป็นแค่ CSS ของ div ที่ห่อ canvas ไว้ (p-4 bg-white)
          ไม่ได้อยู่ในพิกเซลของ canvas จริง - canvas.toDataURL() จะไม่มีขอบขาวด้วย ถ้าไม่วาดเพิ่มเอง
          (QR มาตรฐานต้องมีขอบขาวอย่างน้อย 4 module รอบโค้ด ไม่งั้นสแกนเนอร์บางรุ่นอ่านไม่ออกตอนพิมพ์ติดขอบป้าย/กระดาษ)
       2) ใส่ label กำกับไว้ใต้รูปด้วย (pattern มาตรฐานของป้าย asset tag) เผื่อโค้ดลบเลือน/สแกนไม่ออก ยังอ่านด้วยตาได้
          label ว่าง = ไม่เว้นที่ caption --%>
<script>
    $(document).ready(function () {
        var qrGenerateInstance = null;

        function showQrError(msg) {
            Swal.fire('Error', msg || 'เกิดข้อผิดพลาด', 'error');
        }

        function renderQrPreview(text) {
            var $box = $('#qrGenerateCanvas');
            $box.empty();
            qrGenerateInstance = null;
            var value = $.trim(text);
            if (!value || typeof QRCode === 'undefined') {
                return;
            }
            qrGenerateInstance = new QRCode($box.get(0), {
                text: value,
                width: 220,
                height: 220,
                // H = กู้คืนได้ ~30% เผื่อป้ายเปื้อน/รอยขีดข่วน/แปะโค้ง (ข้อมูลที่เข้ารหัสสั้นอยู่แล้วไม่กระทบขนาดโค้ดมาก)
                correctLevel: QRCode.CorrectLevel.H
            });
        }

        // label ใต้ QR ในหน้าต่าง - ใช้ .text() เท่านั้น กัน HTML จากช่อง input หลุดเข้า DOM
        function renderQrLabelPreview() {
            $('#qrLabelPreview').text($.trim($('#qrLabelInput').val()));
        }

        // ประกอบ canvas สำหรับ Print/Download: เพิ่มขอบขาว (quiet zone) จริงรอบโค้ด + label กำกับใต้รูป
        // คืนค่า null ถ้ายังไม่มี QR ให้ประกอบ (เช่น ช่องข้อมูลว่าง)
        function buildPrintableQrCanvas() {
            var $srcCanvas = $('#qrGenerateCanvas canvas');
            if ($srcCanvas.length === 0) {
                return null;
            }
            var srcCanvas = $srcCanvas.get(0);

            // moduleCount อ่านจาก internal ของ qrcodejs (fallback 25 เผื่อ library เปลี่ยน structure ในอนาคต)
            var moduleCount = (qrGenerateInstance && qrGenerateInstance._oQRCode && qrGenerateInstance._oQRCode.moduleCount)
                ? qrGenerateInstance._oQRCode.moduleCount : 25;
            var cellSize = srcCanvas.width / moduleCount;
            var quietZone = Math.round(cellSize * 4); // มาตรฐาน QR: ขอบขาวอย่างน้อย 4 module

            var captionText = $.trim($('#qrLabelInput').val());
            var captionHeight = captionText ? 36 : 0;

            var outCanvas = document.createElement('canvas');
            outCanvas.width = srcCanvas.width + quietZone * 2;
            outCanvas.height = srcCanvas.height + quietZone * 2 + captionHeight;

            var ctx = outCanvas.getContext('2d');
            ctx.fillStyle = '#ffffff';
            ctx.fillRect(0, 0, outCanvas.width, outCanvas.height);
            ctx.drawImage(srcCanvas, quietZone, quietZone);

            if (captionText) {
                ctx.fillStyle = '#000000';
                ctx.textAlign = 'center';
                ctx.textBaseline = 'middle';
                // ลดขนาดฟอนต์ลงเรื่อยๆ ถ้าข้อความยาวเกินความกว้างโค้ด (กันล้นจอตอนพิมพ์)
                var fontSize = 16;
                var maxTextWidth = outCanvas.width - quietZone;
                do {
                    ctx.font = fontSize + 'px Arial, sans-serif';
                    fontSize -= 1;
                } while (ctx.measureText(captionText).width > maxTextWidth && fontSize >= 9);
                ctx.fillText(captionText, outCanvas.width / 2, quietZone * 2 + srcCanvas.height + captionHeight / 2);
            }

            return outCanvas;
        }

        // เปิด modal ทุกครั้งรีเซ็ตเป็นค่าตั้งต้นของ item นี้ (ข้อมูล = ลิงก์หน้าผลสแกน, label = ชื่อ + Item No.)
        $('#btnOpenQrModal').on('click', function () {
            var defaultValue = $(this).attr('data-qr-value');
            var defaultLabel = $(this).attr('data-qr-label');
            $('#qrLabelInput').val(defaultLabel != null ? String(defaultLabel) : '');
            $('#qrGenerateInput').val(defaultValue != null ? String(defaultValue) : '');
            $('#qrLinkNotConfigured').toggleClass('d-none', $(this).attr('data-qr-configured') === 'true');
            renderQrLabelPreview();
            $('#qrGenerateModal').modal('show');
        });

        // modal เปิดเสร็จ generate QR จากช่องข้อมูลทันที
        $('#qrGenerateModal').on('shown.bs.modal', function () {
            renderQrPreview($('#qrGenerateInput').val());
            renderQrLabelPreview();
            $('#qrGenerateInput').trigger('focus').trigger('select');
        });

        // แก้ข้อมูลที่เข้ารหัส -> render QR ใหม่ / แก้ label -> อัปเดตข้อความใต้ QR อย่างเดียว
        $('#qrGenerateInput').on('input', function () {
            renderQrPreview($(this).val());
        });
        $('#qrLabelInput').on('input', function () {
            renderQrLabelPreview();
        });

        $('#btnQrDownload').on('click', function () {
            var canvas = buildPrintableQrCanvas();
            if (!canvas) {
                showQrError('ยังไม่มี QR ให้ดาวน์โหลด กรุณากรอกข้อมูลก่อน');
                return;
            }
            // ตั้งชื่อไฟล์ตาม label (ว่างใช้ข้อมูลที่เข้ารหัส ว่างทั้งคู่ใช้ "qrcode") ตัดอักขระที่ตั้งชื่อไฟล์ไม่ได้ออก
            var rawName = $.trim($('#qrLabelInput').val());
            if (!rawName) {
                rawName = $.trim($('#qrGenerateInput').val());
            }
            rawName = rawName.replace(/[\\/:*?"<>|]+/g, '_');
            var link = document.createElement('a');
            link.download = (rawName ? 'qrcode_' + rawName : 'qrcode') + '.png';
            link.href = canvas.toDataURL('image/png');
            link.click();
        });

        $('#btnQrPrint').on('click', function () {
            var canvas = buildPrintableQrCanvas();
            if (!canvas) {
                showQrError('ยังไม่มี QR ให้พิมพ์ กรุณากรอกข้อมูลก่อน');
                return;
            }
            var dataUrl = canvas.toDataURL('image/png');
            var printWin = window.open('', '_blank');
            if (!printWin) {
                showQrError('เบราว์เซอร์บล็อกหน้าต่างพิมพ์ กรุณาอนุญาต popup แล้วลองใหม่');
                return;
            }
            // width อย่างเดียว (ไม่ fix height) ให้สัดส่วนรูปถูกต้องเสมอ แม้มี label ใต้ภาพทำให้ภาพไม่เป็นสี่เหลี่ยมจัตุรัส
            printWin.document.write('<img src="' + dataUrl + '" style="width:300px;" onload="window.print();window.close();" />');
            printWin.document.close();
        });
    });
</script>
