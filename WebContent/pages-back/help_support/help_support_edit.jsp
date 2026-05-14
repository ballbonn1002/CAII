<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="s" uri="/struts-tags" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="perm" uri="/WEB-INF/tlds/permission.tld" %>
                <fmt:setLocale value="en" scope="page" />

                <style>
                    #kt_scrolltop {
                        display: none !important;
                    }
                </style>

                <div class="d-flex flex-column flex-column-fluid">
                    <!-- Toolbar -->
                    <div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
                        <div id="kt_app_toolbar_container" class="app-container container-fluid d-flex flex-stack">
                            <div class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
                                <h2
                                    class="page-heading d-flex text-gray-700 fw-semibold flex-column justify-content-center my-0">
                                    Help & Support</h2>
                                <ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
                                    <li class="breadcrumb-item text-muted">Home</li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <!-- Content -->
                    <div class="app-content flex-column-fluid">
                        <div class="app-container container-fluid">

                            <!-- Header with Title and Status -->
                            <div class="d-flex align-items-start justify-content-between mb-12">
                                <div class="d-flex align-items-start gap-4">
                                    <!-- Icon -->
                                    <div class="d-flex align-items-center justify-content-center mt-1">
                                        <s:if test="#request.support.categorized == '1'.toString()">
                                            <i class="ki-duotone ki-information-5 text-danger" style="font-size: 40px;"><span
                                                    class="path1"></span><span class="path2"></span><span
                                                    class="path3"></span></i>
                                        </s:if>
                                        <s:elseif test="#request.support.categorized == '2'.toString()">
                                            <i class="ki-duotone ki-question-2" style="font-size: 40px; color: #A11EBA;"><span
                                                    class="path1"></span><span class="path2"></span><span
                                                    class="path3"></span></i>
                                        </s:elseif>
                                        <s:else>
                                            <i class="ki-duotone ki-like-tag text-primary" style="font-size: 40px;"><span
                                                    class="path1"></span><span class="path2"></span><span
                                                    class="path3"></span></i>
                                        </s:else>
                                    </div>
                                    <!-- Title and Details -->
                                    <div class="d-flex flex-column">
                                        <div class="d-flex align-items-center gap-2 mb-1">
                                            <span class="fw-bold fs-3
                                <s:if test=" #request.support.categorized=='1'.toString()">text-danger</s:if>
                                <s:elseif test=" #request.support.categorized=='2'.toString()"></s:elseif>
                                <s:else>text-primary</s:else>" <s:if
                                                test="#request.support.categorized == '2'.toString()">style="color:
                                                #A11EBA;"</s:if>>
                                                <s:property value="#request.categoryMap[#request.support.categorized]" />
                                            </span> <span class="text-muted fs-5 text-gray-800">
                                                <s:property
                                                    value="#request.support.categorized == '1'.toString() ? '(ปัญหาการใช้งานระบบ)' : (#request.support.categorized == '2'.toString() ? '(สอบถามข้อมูล)' : '(ข้อเสนอแนะ)')" />
                                            </span>
                                        </div>
                                        <div class="d-flex align-items-center">
                                            <span class="badge badge-primary fw-bold fs-3 px-3 py-1">
                                                <s:property
                                                    value="#request.menuMap[#request.support.supportMenuId.toString()]" />
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <!-- Ticket ID and Status -->
                                <div class="d-flex align-items-center gap-4">
                                    <div class="text-primary fw-bold fs-2hx">
                                        #
                                        <s:property value="#request.support.supportId" />
                                    </div>
                                    <s:if
                                        test="#request.support.status == 'New' || #request.support.status == 'Pending'">
                                        <span class="badge badge-light-warning fw-bold fs-6 px-5 py-3">New</span>
                                    </s:if>
                                    <s:elseif test="#request.support.status == 'In Progress'">
                                        <span class="badge badge-light-primary fw-bold fs-6 px-5 py-3">In
                                            Progress</span>
                                    </s:elseif>
                                    <s:elseif test="#request.support.status == 'Resolved'">
                                        <span class="badge badge-light-success fw-bold fs-6 px-5 py-3">Resolved</span>
                                    </s:elseif>
                                    <s:else>
                                        <span
                                            class="badge badge-light-dark text-dark fw-bold fs-6 px-5 py-3">Closed</span>
                                    </s:else>
                                </div>
                            </div>

                            <!-- Guide Fragment -->
                            <jsp:include page="help_support_guide_fragment.jsp">
                                <jsp:param name="isCollapsed" value="true" />
                            </jsp:include>

                            <!-- Message History -->
                            <s:iterator value="#request.supportDetails" var="detail" status="stat">
                                <div class="card border-0 mb-5 shadow-sm">
                                    <div class="card-body p-8">
                                        <div class="d-flex align-items-center justify-content-between mb-6">
                                            <div class="d-flex align-items-center gap-3">
                                                <div class="text-gray-800 fs-6">
                                                    Requested by : <span class="text-gray-800 fw-bold">
                                                        <s:property
                                                            value="userCreate != null ? (#request.userMap[userCreate.trim()] != null ? #request.userMap[userCreate.trim()] : userCreate) : ''" />
                                                    </span> ,
                                                    <fmt:formatDate value="${detail.timeCreate}"
                                                        pattern="d MMM yyyy HH:mm" />
                                                </div>
                                                <s:if test="status == 'New' || status == 'Pending'">
                                                    <span
                                                        class="badge badge-light-warning fw-bold fs-8 px-3 py-1">New</span>
                                                </s:if>
                                                <s:elseif test="status == 'In Progress'">
                                                    <span class="badge badge-light-primary fw-bold fs-8 px-3 py-1">In
                                                        Progress</span>
                                                </s:elseif>
                                                <s:elseif test="status == 'Resolved'">
                                                    <span
                                                        class="badge badge-light-success fw-bold fs-8 px-3 py-1">Resolved</span>
                                                </s:elseif>
                                                <s:else>
                                                    <span
                                                        class="badge badge-light-dark text-dark fw-bold fs-8 px-3 py-1">Closed</span>
                                                </s:else>
                                            </div>
                                            <s:if
                                                test="#stat.last && status != 'Closed' && userCreate != null && userCreate.trim() == #session.onlineUser.id">
                                                <s:set var="lastDetailFiles"
                                                    value="#request.detailFilesMap[supportDetailId]" scope="request" />
                                                <button type="button"
                                                    class="btn btn-icon btn-sm btn-light-primary w-35px h-35px rounded"
                                                    data-bs-toggle="modal" data-bs-target="#editTicketModal">
                                                    <i class="ki-duotone ki-pencil fs-4"><span
                                                            class="path1"></span><span class="path2"></span></i>
                                                </button>
                                            </s:if>
                                        </div>
                                        <div class="d-flex align-items-start gap-4">
                                            <i class="ki-duotone ki-messages fs-2x text-gray-400 mt-1"> <span
                                                    class="path1"></span><span class="path2"></span><span
                                                    class="path3"></span><span class="path4"></span><span
                                                    class="path5"></span>
                                            </i>
                                            <div class="text-gray-800 fs-5 fw-normal" style="white-space: pre-wrap;"><s:property value="message" /></div>
                                        </div>

                                        <s:set var="detailFiles" value="#request.detailFilesMap[supportDetailId]" />
                                        <s:if test="%{#detailFiles != null && !#detailFiles.isEmpty()}">
                                            <div class="mt-8">
                                                <div class="d-flex flex-wrap gap-6">
                                                    <s:iterator value="#detailFiles" var="file">
                                                        <a href="${pageContext.request.contextPath}/upload/support/<s:property value='name'/>"
                                                            target="_blank"
                                                            class="position-relative d-inline-block border border-gray-200 rounded bg-white p-2 text-decoration-none shadow-sm text-hover-primary transition-all"
                                                            style="width: 220px; height: 160px;">
                                                            <s:if
                                                                test="type == 'png' || type == 'jpg' || type == 'jpeg'">
                                                                <img src="${pageContext.request.contextPath}/upload/support/<s:property value='name'/>"
                                                                    class="w-100 h-100 rounded object-fit-cover" />
                                                                <span
                                                                    class="position-absolute top-100 start-100 translate-middle bg-white rounded-circle shadow d-flex align-items-center justify-content-center"
                                                                    style="width: 28px; height: 28px; border: 1px solid #f1f1f4;">
                                                                    <i
                                                                        class="ki-duotone ki-arrow-up-right fs-6 text-gray-600"><span
                                                                            class="path1"></span><span
                                                                            class="path2"></span></i>
                                                                </span>
                                                            </s:if>
                                                            <s:elseif test="type == 'pdf'">
                                                                <div
                                                                    class="w-100 h-100 d-flex flex-column align-items-center justify-content-center bg-light rounded">
                                                                    <i
                                                                        class="ki-duotone ki-file-pdf fs-3x text-danger mb-3"><span
                                                                            class="path1"></span><span
                                                                            class="path2"></span></i> <span
                                                                        class="text-gray-800 fw-medium text-truncate w-100 text-center px-3"
                                                                        style="font-size: 0.85rem;"
                                                                        title="<s:property value='name'/>">
                                                                        <s:property value="name" />
                                                                    </span>
                                                                </div>
                                                            </s:elseif>
                                                            <s:else>
                                                                <div
                                                                    class="w-100 h-100 d-flex flex-column align-items-center justify-content-center bg-light rounded">
                                                                    <i class="fa fa-file fs-3x text-primary mb-3"></i>
                                                                    <span
                                                                        class="text-gray-800 fw-medium text-truncate w-100 text-center px-3"
                                                                        style="font-size: 0.85rem;"
                                                                        title="<s:property value='name'/>">
                                                                        <s:property value="name" />
                                                                    </span>
                                                                </div>
                                                            </s:else>
                                                        </a>
                                                    </s:iterator>
                                                </div>
                                            </div>
                                        </s:if>
                                    </div>
                                </div>
                            </s:iterator>

                            <!-- Update Section (Form) -->
                            <form action="help_support_admin_reply" method="post" id="updateStatusForm">
                                <input type="hidden" name="supportId" value="<s:property value='supportId'/>" /> <input
                                    type="hidden" name="newStatus" id="statusInput" value="" />

                                <!-- Footer Buttons -->
                                <div class="d-flex justify-content-between align-items-center mt-8 pb-8">
                                    <a href="help_support"
                                        class="btn btn-light btn-active-light-primary px-8 d-flex align-items-center fw-bold">
                                        <i class="ki-duotone ki-arrow-left fs-2 me-2"><span class="path1"></span><span
                                                class="path2"></span></i> Back
                                    </a>
                                    <div class="d-flex gap-3">

                                        <%--=====เจ้าของโพสต์=====--%>
                                            <s:if
                                                test="#request.support.userCreate != null && #request.support.userCreate.trim() == #session.onlineUser.id">
                                                <s:if test="#request.support.status == 'Resolved'">
                                                    <button type="button" class="btn btn-primary px-6 fw-bold"
                                                        onclick="$('#statusInput').val('In Progress'); $('#updateStatusForm').submit();">Re-Open</button>
                                                    <button type="button" class="btn btn-dark px-6 fw-bold"
                                                        onclick="$('#statusInput').val('Closed'); $('#updateStatusForm').submit();">Closed</button>
                                                </s:if>
                                            </s:if>

                                            <%--=====Admin: แสดงปุ่มตามสถานะ (ยกเว้น Resolved และ Closed)=====--%>
                                                <perm:permission object="helpsupport.manage">
                                                    <s:if
                                                        test="#request.support.status == 'New' || #request.support.status == 'Pending'">
                                                        <button type="button" class="btn btn-dark px-6 fw-bold"
                                                            onclick="openAdminReply('Closed')">Closed</button>
                                                        <button type="button" class="btn btn-primary px-6 fw-bold"
                                                            onclick="openAdminReply('In Progress')">In Progress</button>
                                                    </s:if>
                                                    <s:elseif test="#request.support.status == 'In Progress'">
                                                        <button type="button" class="btn btn-success px-6 fw-bold"
                                                            onclick="openAdminReply('Resolved')">Resolved</button>
                                                    </s:elseif>
                                                    <%-- Resolved และ Closed: ไม่มีปุ่มสำหรับ Admin --%>
                                                </perm:permission>

                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Admin Reply Modal -->
                <div class="modal fade" id="adminReplyModal" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered mw-700px">
                        <div class="modal-content rounded">
                            <form action="help_support_admin_reply" method="post" enctype="multipart/form-data"
                                id="adminReplyForm" onsubmit="return validateAdminReplyForm()">
                                <input type="hidden" name="supportId" value="<s:property value='supportId'/>" /> <input
                                    type="hidden" name="newStatus" id="adminNewStatus" value="" />

                                <div class="modal-header pb-0 border-0 justify-content-between">
                                    <h2 class="fw-bold fs-2 m-0 mt-2" id="adminReplyTitle">Admin
                                        Reply</h2>
                                    <div class="btn btn-sm btn-icon btn-color-gray-500 btn-active-color-danger" data-bs-dismiss="modal">
                                        <i class="ki-duotone ki-cross fs-2x"><span class="path1"></span><span
                                                class="path2"></span></i>
                                    </div>
                                </div>

                                <div class="modal-body scroll-y px-10 px-lg-15 pt-6 pb-10">
                                    <div class="alert d-flex align-items-center gap-3 mb-8" id="adminReplyAlert"
                                        style="border-radius: 10px;">
                                        <span class="fw-semibold fs-6" id="adminReplyAlertText"></span>
                                    </div>

                                    <div class="d-flex flex-column mb-8">
                                        <label class="fs-6 fw-semibold mb-2">Message <span
                                                class="text-muted fs-7"></span></label>
                                        <textarea class="form-control" rows="6" name="adminMessage" id="adminMessage"
                                            placeholder="Leave a note for the requester..."></textarea>
                                    </div>

                                    <div class="mb-4">
                                        <div class="d-flex flex-column">
                                            <label for="adminFileInput"
                                                class="btn btn-primary w-150px mb-2 d-inline-flex align-items-center justify-content-center gap-2"
                                                style="height: 40px;"> Attach files <input type="file" name="files"
                                                    id="adminFileInput" multiple style="display: none;"
                                                    accept="image/png, image/jpeg, application/pdf"
                                                    onchange="updateAdminFileList(this)" />
                                            </label>
                                            <div id="adminFilePreviewContainer" class="mt-3" style="max-width: 400px;">
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="modal-footer flex-center justify-content-between p-8 border-0">
                                    <button type="button"
                                        class="btn btn-light btn-active-light-primary px-8 d-flex align-items-center fw-bold"
                                        data-bs-dismiss="modal">
                                        <i class="ki-duotone ki-arrow-left fs-2 me-2"><span class="path1"></span><span
                                                class="path2"></span></i> Cancel
                                    </button>
                                    <button type="submit" class="btn px-8 fw-bold"
                                        id="adminReplySubmitBtn">Confirm</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Edit Ticket Modal -->
                <div class="modal fade" id="editTicketModal" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered mw-900px">
                        <div class="modal-content rounded">
                            <form action="help_support_update" method="post" enctype="multipart/form-data"
                                id="editTicketForm" onsubmit="return validateEditForm()">
                                <input type="hidden" name="supportId" value="<s:property value='supportId'/>" />

                                <div class="modal-header pb-10 border-0 justify-content-between align-items-center">
                                    <h2 class="fw-bold fs-2 m-0">Edit Ticket</h2>
                                    <div class="btn btn-sm btn-icon btn-color-gray-500 btn-active-color-danger" data-bs-dismiss="modal">
                                        <i class="ki-duotone ki-cross fs-2x"><span class="path1"></span><span
                                                class="path2"></span></i>
                                    </div>
                                </div>

                                <div class="modal-body scroll-y px-10 px-lg-15 pt-0 pb-15">
                                    <div class="mb-10">
                                        <label class="required fs-6 fw-semibold mb-2">Categorized:</label>
                                        <select class="form-select" data-control="select2" data-hide-search="true"
                                            name="categorized" <s:if test="#request.support.status != 'New'">disabled
                                            </s:if>>
                                            <option value="1" <s:if
                                                test="support.categorized == '1'.toString()">selected</s:if>
                                                >Technical
                                                Issue</option>
                                            <option value="2" <s:if
                                                test="support.categorized == '2'.toString()">selected</s:if>
                                                >Inquiry
                                                / Question</option>
                                            <option value="3" <s:if
                                                test="support.categorized == '3'.toString()">selected</s:if>>Feature
                                                Request</option>
                                        </select>
                                        <s:if test="#request.support.status != 'New'">
                                            <input type="hidden" name="categorized"
                                                value="<s:property value='#request.support.categorized'/>" />
                                        </s:if>
                                    </div>

                                    <div class="row g-9 mb-10">
                                        <div class="col-md-6">
                                            <label class="required fs-6 fw-semibold mb-2">Menu</label> <select
                                                class="form-select" data-control="select2" data-hide-search="true"
                                                name="supportMenuId" <s:if
                                                test="#request.support.status != 'New'">disabled</s:if>>
                                                <s:iterator value="#request.menuList">
                                                    <option value="<s:property value='supportMenuId'/>" <s:if
                                                        test="supportMenuId == support.supportMenuId">selected</s:if>>
                                                        <s:property value='menuName' />
                                                    </option>
                                                </s:iterator>
                                            </select>
                                            <s:if test="#request.support.status != 'New'">
                                                <input type="hidden" name="supportMenuId"
                                                    value="<s:property value='#request.support.supportMenuId'/>" />
                                            </s:if>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="required fs-6 fw-semibold mb-2">Issue Date</label>
                                            <div class="position-relative d-flex align-items-center">
                                                <i class="ki-duotone ki-calendar-8 position-absolute ms-4 mb-1 fs-2"><span
                                                        class="path1"></span><span class="path2"></span><span
                                                        class="path3"></span><span class="path4"></span><span
                                                        class="path5"></span><span class="path6"></span></i> 
                                                    <input
                                                    class="form-control ps-12" name="issueDate" type="text"
                                                    value="<fmt:formatDate value='${requestScope.support.issueDate}' pattern='d MMM yyyy'/>"
                                                    readonly style="background-color: #f5f8fa; cursor: not-allowed;" />
                                            </div>
                                        </div>
                                    </div>

                                    <div class="d-flex flex-column mb-10">
                                        <label class="d-flex align-items-center fs-6 fw-semibold mb-2">
                                            <span>message</span>
                                        </label>
                                        <textarea class="form-control" rows="8" name="description" id="editDescription"
                                            placeholder="Please describe your issue here..."><s:iterator value="#request.supportDetails" status="stat"><s:if test="#stat.last"><s:property value="message" /></s:if></s:iterator></textarea>
                                    </div>

                                    <s:if
                                        test="%{#request.lastDetailFiles != null && !#request.lastDetailFiles.isEmpty()}">
                                        <div class="mb-10" id="existingFilesSection">
                                            <label class="form-label fs-6 fw-bold text-gray-800 mb-4">Attached
                                                Files</label>
                                            <div class="d-flex flex-wrap gap-4" id="existingFilesContainer">
                                                <s:iterator value="#request.lastDetailFiles" var="file">
                                                    <div class="position-relative d-inline-block border border-gray-200 rounded bg-white p-2 existing-file-card"
                                                        style="width: 120px; height: 90px;"
                                                        data-file-id="<s:property value='fileId'/>">
                                                        <s:if test="type == 'png' || type == 'jpg' || type == 'jpeg'">
                                                            <img src="${pageContext.request.contextPath}/upload/support/<s:property value='name'/>"
                                                                class="w-100 h-100 rounded object-fit-cover" />
                                                        </s:if>
                                                        <s:elseif test="type == 'pdf'">
                                                            <div
                                                                class="w-100 h-100 d-flex flex-column align-items-center justify-content-center bg-light rounded">
                                                                <i class="ki-duotone ki-file-pdf fs-1 text-danger"></i>
                                                                <span class="text-gray-600 fw-bold mt-1"
                                                                    style="font-size: 0.6rem;">PDF</span>
                                                            </div>
                                                        </s:elseif>
                                                        <s:else>
                                                            <div
                                                                class="w-100 h-100 d-flex align-items-center justify-content-center bg-light rounded">
                                                                <i class="fa fa-file fs-1 text-primary"></i>
                                                            </div>
                                                        </s:else>
                                                        <!-- Delete overlay button -->
                                                        <button type="button"
                                                            class="position-absolute top-0 end-0 btn btn-icon btn-xs btn-danger m-1 p-1"
                                                            style="width: 20px; height: 20px;"
                                                            data-file-id="<s:property value='fileId'/>"
                                                            onclick="removeExistingFile(this, event)">
                                                            <i class="ki-duotone ki-cross fs-4"><span
                                                                    class="path1"></span><span class="path2"></span></i>
                                                        </button>
                                                    </div>
                                                </s:iterator>
                                            </div>
                                            <!-- Hidden inputs for file IDs to delete will be injected here by JS -->
                                            <div id="deleteFileInputs"></div>
                                        </div>
                                    </s:if>

                                    <div class="mb-8">
                                        <div class="d-flex flex-column">
                                            <label for="editFileInput"
                                                class="btn btn-primary w-150px mb-2 d-inline-flex align-items-center justify-content-center gap-2"
                                                style="height: 40px;"> Attach files <input type="file" name="files"
                                                    id="editFileInput" multiple style="display: none;"
                                                    accept="image/png, image/jpeg, application/pdf"
                                                    onchange="updateEditFileList(this)" />
                                            </label>
                                            <div id="editFilePreviewContainer" class="mt-4" style="max-width: 400px;">
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="modal-footer flex-center justify-content-between p-10 border-0">
                                    <button type="button"
                                        class="btn btn-light btn-active-light-primary px-8 d-flex align-items-center fw-bold"
                                        data-bs-dismiss="modal">
                                        <i class="ki-duotone ki-arrow-left fs-2 me-2"><span class="path1"></span><span
                                                class="path2"></span></i> Back
                                    </button>
                                    <button type="submit" class="btn btn-primary px-8 fw-bold">Submit</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <script>
                    // ==========================================
                    // 1. ฟังก์ชันส่วนกลาง
                    // ==========================================
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
                                            const newFile = new File([blob], file.name, {
                                                type: file.type,
                                                lastModified: Date.now()
                                            });
                                            resolve(newFile);
                                        } else {
                                            resolve(file);
                                        }
                                    }, file.type, quality);
                                };
                                img.onerror = error => reject(error);
                            };
                            reader.onerror = error => reject(error);
                        });
                    }

                    function removeExistingFile(btn, event) {
                        if (event) {
                            event.preventDefault();
                            event.stopPropagation();
                        }
                        const fileId = $(btn).data('file-id');
                        $(btn).closest('.existing-file-card').remove();
                        const hiddenInput = $('<input>').attr({
                            type: 'hidden',
                            name: 'deleteFileIds',
                            value: fileId
                        });
                        $('#deleteFileInputs').append(hiddenInput);
                    }

                    // ==========================================
                    // 2. ส่วนของฟอร์ม Edit Ticket (ของ User)
                    // ==========================================
                    const editAccumulatedFiles = new DataTransfer();

                    document.getElementById('editTicketModal').addEventListener('show.bs.modal', function () {
                        editAccumulatedFiles.items.clear();
                        document.getElementById('editFileInput').value = '';
                        document.getElementById('editFilePreviewContainer').innerHTML = '';
                        const deleteDiv = document.getElementById('deleteFileInputs');
                        if (deleteDiv) deleteDiv.innerHTML = '';
                        document.querySelectorAll('.existing-file-card').forEach(el => el.style.display = '');
                    });

                    // แก้ไข: เติม async และเปลี่ยนชื่อตัวแปรให้ตรงกับ editAccumulatedFiles
                    async function updateEditFileList(input) {
                        Swal.fire({
                            text: "Compressing images...",
                            allowOutsideClick: false,
                            didOpen: () => { Swal.showLoading(); }
                        });

                        for (let i = 0; i < input.files.length; i++) {
                            let newFile = input.files[i];

                            try {
                                newFile = await compressImage(newFile, 1280, 1280, 0.8);
                            } catch (e) {
                                console.error("Compression failed for", newFile.name, e);
                            }

                            let isDuplicate = false;
                            for (let j = 0; j < editAccumulatedFiles.items.length; j++) {
                                if (editAccumulatedFiles.files[j].name === newFile.name) {
                                    isDuplicate = true;
                                    break;
                                }
                            }
                            if (!isDuplicate) {
                                editAccumulatedFiles.items.add(newFile);
                            }
                        }

                        document.getElementById('editFileInput').files = editAccumulatedFiles.files;
                        renderEditPreview();
                        Swal.close();
                    }

                    function renderEditPreview() {
                        const container = document.getElementById('editFilePreviewContainer');
                        container.innerHTML = '';

                        for (let i = 0; i < editAccumulatedFiles.files.length; i++) {
                            const file = editAccumulatedFiles.files[i];
                            const fileName = file.name;
                            const fileExtension = fileName.split('.').pop().toLowerCase();
                            const isImage = ['png', 'jpg', 'jpeg'].includes(fileExtension);

                            const fileWrapper = document.createElement('div');
                            fileWrapper.className = 'd-flex justify-content-between align-items-center p-2 border rounded bg-light mb-2';

                            const leftGroup = document.createElement('div');
                            leftGroup.className = 'd-flex align-items-center overflow-hidden';

                            if (isImage) {
                                const imgPreview = document.createElement('img');
                                imgPreview.src = URL.createObjectURL(file);
                                imgPreview.className = 'w-40px h-40px rounded me-3 object-fit-cover';
                                imgPreview.onload = function () { URL.revokeObjectURL(this.src); };
                                leftGroup.appendChild(imgPreview);
                            } else {
                                const icon = document.createElement('i');
                                icon.className = 'ki-duotone ki-file-pdf fs-2 me-3 text-primary';
                                icon.innerHTML = '<span class="path1"></span><span class="path2"></span>';
                                leftGroup.appendChild(icon);
                            }

                            const label = document.createElement('span');
                            label.className = 'text-gray-800 fw-medium text-truncate';
                            label.textContent = fileName;
                            label.style.maxWidth = '250px';
                            leftGroup.appendChild(label);

                            const removeBtn = document.createElement('span');
                            removeBtn.className = 'btn btn-icon btn-sm btn-light-danger cursor-pointer';
                            removeBtn.onclick = (function (idx) {
                                return function () {
                                    editAccumulatedFiles.items.remove(idx);
                                    document.getElementById('editFileInput').files = editAccumulatedFiles.files;
                                    renderEditPreview();
                                };
                            })(i);

                            const crossIcon = document.createElement('i');
                            crossIcon.className = 'ki-duotone ki-cross fs-2';
                            crossIcon.innerHTML = '<span class="path1"></span><span class="path2"></span>';
                            removeBtn.appendChild(crossIcon);

                            fileWrapper.appendChild(leftGroup);
                            fileWrapper.appendChild(removeBtn);
                            container.appendChild(fileWrapper);
                        }
                    }

                    function validateEditForm() {
                        const description = document.getElementById('editDescription').value.trim();
                        if (description === "") {
                            Swal.fire({
                                text: "Please enter your message.",
                                icon: "warning",
                                buttonsStyling: false,
                                confirmButtonText: "Ok, got it!",
                                customClass: { confirmButton: "btn btn-primary" }
                            });
                            return false;
                        }

                        // เพิ่มการเช็ค 2MB สำหรับหน้า Edit
                        const MAX_BYTES = 2 * 1024 * 1024;
                        let totalSize = 0;
                        for (let i = 0; i < editAccumulatedFiles.files.length; i++) {
                            totalSize += editAccumulatedFiles.files[i].size;
                        }
                        if (totalSize > MAX_BYTES) {
                            Swal.fire({
                                text: "Total file size exceeds the 2MB limit. Please remove some files or use smaller PDFs.",
                                icon: "error",
                                buttonsStyling: false,
                                confirmButtonText: "Understood",
                                customClass: { confirmButton: "btn btn-danger" }
                            });
                            return false;
                        }
                        return true;
                    }

                    // ==========================================
                    // 3. ส่วนของฟอร์ม Admin Reply (ของ Admin)
                    // ==========================================
                    function openAdminReply(mode) {
                        const title = document.getElementById('adminReplyTitle');
                        const alertEl = document.getElementById('adminReplyAlert');
                        const alertText = document.getElementById('adminReplyAlertText');
                        const submitBtn = document.getElementById('adminReplySubmitBtn');

                        document.getElementById('adminFilePreviewContainer').innerHTML = '';
                        document.getElementById('adminFileInput').value = '';

                        if (mode === 'Resolved') {
                            document.getElementById('adminNewStatus').value = 'Resolved';
                            title.textContent = 'Mark as Resolved';
                            alertEl.className = 'alert d-flex align-items-center gap-3 mb-8 border border-dashed border-success';
                            alertText.innerHTML = 'คุณกำลังจะปรับสถานะเป็น <span class="badge badge-light-success fw-bold fs-8 px-3 py-1">Resolved</span> กรุณาระบุข้อความสรุปการแก้ไข (ถ้ามี)';
                            submitBtn.className = 'btn btn-success px-8 fw-bold';
                            submitBtn.textContent = 'Confirm';
                        } else if (mode === 'Closed') {
                            document.getElementById('adminNewStatus').value = 'Closed';
                            title.textContent = 'Close Ticket';
                            alertEl.className = 'alert d-flex align-items-center gap-3 mb-8 border border-dashed border-dark';
                            alertText.innerHTML = 'คุณกำลังจะปรับสถานะเป็น <span class="badge badge-light-dark text-dark fw-bold fs-8 px-3 py-1">Closed</span> กรุณาระบุข้อความ';
                            submitBtn.className = 'btn btn-dark px-8 fw-bold';
                            submitBtn.textContent = 'Confirm';
                        } else if (mode === 'In Progress') {
                            document.getElementById('adminNewStatus').value = 'In Progress';
                            title.textContent = 'Set In Progress';
                            alertEl.className = 'alert d-flex align-items-center gap-3 mb-8 border border-dashed border-primary';
                            alertText.innerHTML = 'คุณกำลังจะปรับสถานะเป็น <span class="badge badge-light-primary fw-bold fs-8 px-3 py-1">In Progress</span> กรุณาระบุข้อความ';
                            submitBtn.className = 'btn btn-primary px-8 fw-bold';
                            submitBtn.textContent = 'Confirm';
                        }

                        var modal = new bootstrap.Modal(document.getElementById('adminReplyModal'));
                        modal.show();
                    }

                    const adminAccumulatedFiles = new DataTransfer();

                    document.getElementById('adminReplyModal').addEventListener('show.bs.modal', function () {
                        adminAccumulatedFiles.items.clear();
                        document.getElementById('adminFileInput').value = '';
                        document.getElementById('adminFilePreviewContainer').innerHTML = '';
                    });

                    // แก้ไข: เติม async และเปลี่ยนชื่อตัวแปรให้ตรงกับ adminAccumulatedFiles
                    async function updateAdminFileList(input) {
                        Swal.fire({
                            text: "Compressing images...",
                            allowOutsideClick: false,
                            didOpen: () => { Swal.showLoading(); }
                        });

                        for (let i = 0; i < input.files.length; i++) {
                            let newFile = input.files[i];

                            try {
                                newFile = await compressImage(newFile, 1280, 1280, 0.8);
                            } catch (e) {
                                console.error("Compression failed for", newFile.name, e);
                            }

                            let isDuplicate = false;
                            for (let j = 0; j < adminAccumulatedFiles.items.length; j++) {
                                if (adminAccumulatedFiles.files[j].name === newFile.name) {
                                    isDuplicate = true;
                                    break;
                                }
                            }
                            if (!isDuplicate) {
                                adminAccumulatedFiles.items.add(newFile);
                            }
                        }

                        document.getElementById('adminFileInput').files = adminAccumulatedFiles.files;
                        renderAdminPreview();
                        Swal.close();
                    }

                    function renderAdminPreview() {
                        const container = document.getElementById('adminFilePreviewContainer');
                        container.innerHTML = '';

                        for (let i = 0; i < adminAccumulatedFiles.files.length; i++) {
                            const file = adminAccumulatedFiles.files[i];
                            const fileName = file.name;
                            const fileExtension = fileName.split('.').pop().toLowerCase();
                            const isImage = ["png", "jpg", "jpeg"].includes(fileExtension);

                            const fileWrapper = document.createElement('div');
                            fileWrapper.className = 'd-flex justify-content-between align-items-center p-2 border rounded bg-light mb-2';

                            const leftGroup = document.createElement('div');
                            leftGroup.className = 'd-flex align-items-center overflow-hidden';

                            if (isImage) {
                                const imgPreview = document.createElement('img');
                                imgPreview.src = URL.createObjectURL(file);
                                imgPreview.className = 'w-40px h-40px rounded me-3 object-fit-cover';
                                imgPreview.onload = function () { URL.revokeObjectURL(this.src); };
                                leftGroup.appendChild(imgPreview);
                            } else {
                                const icon = document.createElement('i');
                                icon.className = (fileExtension === 'pdf' ? 'ki-duotone ki-file-pdf' : 'fa fa-file') + ' fs-2 me-3 text-primary';
                                if (fileExtension === 'pdf') icon.innerHTML = '<span class="path1"></span><span class="path2"></span>';
                                leftGroup.appendChild(icon);
                            }

                            const link = document.createElement('span');
                            link.className = 'text-gray-800 fw-medium text-truncate';
                            link.textContent = fileName;
                            link.style.maxWidth = '250px';
                            leftGroup.appendChild(link);

                            const removeBtn = document.createElement('span');
                            removeBtn.className = 'btn btn-icon btn-sm btn-light-danger cursor-pointer';
                            removeBtn.onclick = (function (idx) {
                                return function () {
                                    adminAccumulatedFiles.items.remove(idx);
                                    document.getElementById('adminFileInput').files = adminAccumulatedFiles.files;
                                    renderAdminPreview();
                                };
                            })(i);

                            const crossIcon = document.createElement('i');
                            crossIcon.className = 'ki-duotone ki-cross fs-2';
                            crossIcon.innerHTML = '<span class="path1"></span><span class="path2"></span>';
                            removeBtn.appendChild(crossIcon);

                            fileWrapper.appendChild(leftGroup);
                            fileWrapper.appendChild(removeBtn);
                            container.appendChild(fileWrapper);
                        }
                    }

                    function validateAdminReplyForm() {
                        const message = document.getElementById('adminMessage').value.trim();
                        if (message === "") {
                            Swal.fire({
                                text: "Please enter your message.",
                                icon: "warning",
                                buttonsStyling: false,
                                confirmButtonText: "Ok, got it!",
                                customClass: { confirmButton: "btn btn-primary" }
                            });
                            return false;
                        }

                        // เพิ่มการเช็ค 2MB สำหรับหน้า Admin Reply
                        const MAX_BYTES = 2 * 1024 * 1024;
                        let totalSize = 0;
                        for (let i = 0; i < adminAccumulatedFiles.files.length; i++) {
                            totalSize += adminAccumulatedFiles.files[i].size;
                        }
                        if (totalSize > MAX_BYTES) {
                            Swal.fire({
                                text: "Total file size exceeds the 2MB limit. Please remove some files or use smaller PDFs.",
                                icon: "error",
                                buttonsStyling: false,
                                confirmButtonText: "Understood",
                                customClass: { confirmButton: "btn btn-danger" }
                            });
                            return false;
                        }
                        return true;
                    }
                </script>