<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%--
  หน้าผลการสแกน QR (ข้อมูลมาจาก QrService.qrView())
    qrState : full = ผู้มีสิทธิ์ stock.qr.view เห็นข้อมูลเต็ม
              limited = login แล้วแต่ไม่มีสิทธิ์ เห็นแค่ชื่อ Item No. ประเภท (ข้อมูลอื่นไม่ถูกส่งมาที่หน้านี้เลย)
              notfound = รหัสผิด หรือของถูกลบ
  รอบแรกรองรับเฉพาะ Equipment
--%>
<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
    <div class="d-flex flex-column flex-column-fluid">
        <div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
            <div id="kt_app_toolbar_container" class="app-container container-fluid d-flex flex-stack">
                <div class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
                    <h1 class="page-heading d-flex text-gray-700 fw-semibold my-0">ผลการสแกน QR</h1>
                    <ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
                        <li class="breadcrumb-item text-muted"><a href="${pageContext.request.contextPath}/demo_dashboard" class="text-muted text-hover-primary fw-medium fs-7">Home</a></li>
                        <li class="breadcrumb-item"><span class="bullet bg-gray-500 fw-medium fs-7 w-5px h-2px"></span></li>
                        <li class="breadcrumb-item text-muted fw-medium fs-7">Stock</li>
                        <li class="breadcrumb-item"><span class="bullet bg-gray-500 fw-medium fs-7 w-5px h-2px"></span></li>
                        <li class="breadcrumb-item text-muted fw-medium fs-7">สแกน QR</li>
                    </ul>
                </div>
            </div>
        </div>

        <div id="kt_app_content" class="app-content flex-column-fluid">
            <div id="kt_app_content_container" class="app-container container-fluid">
                <div class="row">
                    <div class="col-12 col-md-10 col-lg-6 mx-auto">

                        <c:choose>
                            <%-- ไม่พบรายการ: ไม่ใช้หน้า error เพื่อไม่ให้ดูเหมือนระบบพัง --%>
                            <c:when test="${qrState == 'notfound' or empty qrState}">
                                <div class="card">
                                    <div class="card-body text-center py-15">
                                        <div class="fs-2 fw-bold text-gray-800 mb-3">ไม่พบรายการ</div>
                                        <div class="text-gray-600 mb-8">QR นี้อาจไม่ถูกต้อง หรือรายการถูกลบไปแล้ว</div>
                                        <a href="${pageContext.request.contextPath}/demo_dashboard" class="btn btn-light">กลับหน้าหลัก</a>
                                    </div>
                                </div>
                            </c:when>

                            <%-- login แล้วแต่ไม่มีสิทธิ์: แสดงแบบจำกัดข้อมูล --%>
                            <c:when test="${qrState == 'limited'}">
                                <div class="card mb-6">
                                    <div class="card-body">
                                        <div class="fs-3 fw-bold text-gray-900 mb-1"><c:out value="${qrName}" /></div>
                                        <div class="text-gray-600 mb-6"><c:out value="${qrItemNo}" /> · <c:out value="${qrTypeLabel}" /></div>
                                        <table class="table table-borderless align-middle fs-6 mb-0">
                                            <tbody>
                                                <tr>
                                                    <td class="text-gray-600 ps-0">ชื่อ</td>
                                                    <td class="text-end fw-semibold pe-0"><c:out value="${qrName}" /></td>
                                                </tr>
                                                <tr>
                                                    <td class="text-gray-600 ps-0">Item No.</td>
                                                    <td class="text-end fw-semibold pe-0"><c:out value="${qrItemNo}" /></td>
                                                </tr>
                                                <tr>
                                                    <td class="text-gray-600 ps-0">ประเภท</td>
                                                    <td class="text-end fw-semibold pe-0"><c:out value="${qrTypeLabel}" /></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="alert alert-primary d-flex align-items-start mb-6" role="alert">
                                    <div class="fs-6">ข้อมูลอื่น เช่น สถานะ ที่เก็บ และยอดคงเหลือ ดูได้เฉพาะผู้ดูแล</div>
                                </div>
                                <a href="${pageContext.request.contextPath}/demo_dashboard" class="btn btn-light w-100">กลับหน้าหลัก</a>
                            </c:when>

                            <%-- ผู้มีสิทธิ์: ข้อมูลเต็ม --%>
                            <c:otherwise>
                                <div class="card mb-6">
                                    <div class="card-body">
                                        <div class="fs-3 fw-bold text-gray-900 mb-1"><c:out value="${qrName}" /></div>
                                        <div class="text-gray-600 mb-4"><c:out value="${qrItemNo}" /> · <c:out value="${qrTypeLabel}" /></div>

                                        <%-- สีป้ายตามที่ตั้งไว้ในตาราง equipment_status (color_2) เหมือนหน้า Equipment List --%>
                                        <span class="badge badge-${qrStatusColor} fs-7 mb-2"><c:out value="${qrStatusText}" /></span>
                                        <c:if test="${qrRetired}">
                                            <div class="alert alert-warning mt-3 mb-0" role="alert">
                                                <div class="fs-6">เครื่องนี้ปลดระวางแล้ว</div>
                                            </div>
                                        </c:if>

                                        <div class="separator separator-dashed my-5"></div>

                                        <table class="table table-borderless align-middle fs-6 mb-0">
                                            <tbody>
                                                <tr>
                                                    <td class="text-gray-600 ps-0">Serial No.</td>
                                                    <td class="text-end fw-semibold pe-0"><c:out value="${empty qrSerialNo ? '-' : qrSerialNo}" /></td>
                                                </tr>
                                                <c:if test="${qrStatusCode == 'B'}">
                                                    <tr>
                                                        <td class="text-gray-600 ps-0">ผู้ยืม</td>
                                                        <td class="text-end fw-semibold pe-0"><c:out value="${empty qrBorrower ? '-' : qrBorrower}" /></td>
                                                    </tr>
                                                    <c:if test="${not empty qrBorrowDate}">
                                                        <tr>
                                                            <td class="text-gray-600 ps-0">ยืมเมื่อ</td>
                                                            <td class="text-end fw-semibold pe-0"><c:out value="${qrBorrowDate}" /></td>
                                                        </tr>
                                                    </c:if>
                                                </c:if>
                                                <tr>
                                                    <td class="text-gray-600 ps-0">อยู่ที่</td>
                                                    <td class="text-end fw-semibold pe-0"><c:out value="${qrLocation}" /></td>
                                                </tr>
                                                <tr>
                                                    <td class="text-gray-600 ps-0">รุ่น (catalog)</td>
                                                    <td class="text-end fw-semibold pe-0"><c:out value="${qrCatalog}" /></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>

                                <div class="fs-6 fw-bold text-gray-600 mb-3">ทำอะไรต่อ</div>
                                <div class="d-grid gap-3">
                                    <%-- ปุ่มพาไปหน้าเดิมของระบบ ซึ่งเช็คสิทธิ์ของหน้านั้นเองตามปกติ --%>
                                    <c:if test="${not qrRetired and qrStatusCode == 'A'}">
                                        <a href="${pageContext.request.contextPath}/borrow_add?id=${qrEquipmentId}" class="btn btn-primary btn-lg">ขอยืม</a>
                                    </c:if>
                                    <c:if test="${not qrRetired and qrStatusCode == 'B'}">
                                        <c:choose>
                                            <c:when test="${not empty qrBorrowId}"><a href="${pageContext.request.contextPath}/borrow_edit?id=${qrBorrowId}" class="btn btn-primary btn-lg">ไปหน้ารับคืน</a></c:when>
                                            <c:otherwise><a href="${pageContext.request.contextPath}/borrow_list" class="btn btn-primary btn-lg">ไปหน้ารับคืน</a></c:otherwise>
                                        </c:choose>
                                    </c:if>
                                    <a href="${pageContext.request.contextPath}/equipment_edit?id=${qrEquipmentId}" class="btn btn-light btn-lg">ดูรายละเอียดเต็ม</a>
                                </div>
                            </c:otherwise>
                        </c:choose>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
