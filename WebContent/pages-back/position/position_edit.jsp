<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>

<%
    java.util.Date now = new java.util.Date();
%>
<fmt:formatDate var="today" value="${now}" pattern="dd-MM-yyyy"/>
<fmt:formatDate var="nowTime" value="${now}" pattern="HH:mm"/>

<c:set var="pos" value="${empty position ? positionList : position}" />

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />

  <link href="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.css" rel="stylesheet" type="text/css" />
  <script src="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.js"></script>
</head>

<body class="app-blank">

<!--begin::Main-->
<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
  <div class="d-flex flex-column flex-column-fluid">

    <div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
      <div id="kt_app_toolbar_container" class="app-container container-xxl d-flex flex-stack">
        <div class="page-title d-flex flex-column justify-content-center">
          <h1 class="page-heading text-gray-900 fw-bold fs-2 my-0">Edit Position</h1>
          <ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 pt-1">
            <li class="breadcrumb-item text-muted">Home</li>
            <li class="breadcrumb-item"><span class="bullet bg-gray-400 w-5px h-2px"></span></li>
            <li class="breadcrumb-item text-muted">Master</li>
            <li class="breadcrumb-item"><span class="bullet bg-gray-400 w-5px h-2px"></span></li>
            <li class="breadcrumb-item text-muted">Position</li>
          </ul>
        </div>
      </div>
    </div>

    <!--begin::Content-->
    <div id="kt_app_content" class="app-content flex-column-fluid">
      <div class="app-container container-xxl">

        <!--begin::Card-->
        <div class="card shadow-sm">
          <div class="card-header border-0 pt-7">
            <div class="card-title">
              <h2 class="mb-0">Position</h2>
            </div>
          </div>

          <form action="${pageContext.request.contextPath}/updatePosition" method="POST" class="form" autocomplete="off">
            <div class="card-body p-10">


              <div class="row">

                <!-- Position ID (read-only) -->
                <div class="col-12 col-md-12 col-xl-12">
                  <div class="mb-7">
                    <label class="form-label fw-semibold">Position ID <span class="required"></span></label>
                    <input type="text"
                           class="form-control form-control-lg"
                           value="${pos.positionId}"
                           readonly
                           disabled />

                    <input type="hidden" name="positionId" value="${pos.positionId}" />
                  </div>
                </div>

                <!-- Position Name -->
                <div class="col-12 col-md-12 col-xl-12">
                  <div class="mb-7">
                    <label class="form-label fw-semibold">Position Name <span class="required"></span></label>
                    <input type="text"
                           name="name"
                           required
                           class="form-control form-control-lg"
                           value="${pos.name}" />
                  </div>
                </div>

                <!-- Department ID -->
                <div class="col-12 col-md-12 col-xl-12">
                  <div class="mb-7">
                    <label class="form-label fw-semibold">Department ID <span class="required"></span></label>
                    <select class="form-select form-select-lg" name="departmentId" required>
                      <c:forEach var="department" items="${departmentList}">
                        <option value="${department.id}"
                          <c:if test="${department.id == pos.departmentId}">selected</c:if>>
                          ${department.id}
                        </option>
                      </c:forEach>
                    </select>
                  </div>
                </div>

                <!-- Description -->
                <div class="col-12 col-md-12 col-xl-12">
                  <div class="mb-0">
                    <label class="form-label fw-semibold">Description</label>
                    <textarea name="description" rows="4" class="form-control form-control-lg">${pos.description}</textarea>
                  </div>
                </div>

              </div>
              <!-- /row -->

              <input type="hidden" name="date" value="${today}" />
              <input type="hidden" name="time" value="${nowTime}" />
            </div>

            <!-- Actions -->
            <div class="card-footer d-flex justify-content-end gap-3 p-8">
              <a href="position_list" class="btn btn-light px-8">Cancel</a>
              <button type="submit" class="btn btn-success px-8">Save</button>
            </div>
          </form>
        </div>
        <!--end::Card-->
      </div>
    </div>
    <!--end::Content-->
  </div>
</div>
<!--end::Main-->
</body>
</html>
