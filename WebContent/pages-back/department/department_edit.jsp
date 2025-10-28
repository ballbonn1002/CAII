<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%
    java.util.Date now = new java.util.Date();
%>

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
            <h1 class="page-heading text-gray-900 fw-bold fs-2 my-0">Edit Department</h1>
            <ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 pt-1">
              <li class="breadcrumb-item text-muted">Home</li>
              <li class="breadcrumb-item"><span class="bullet bg-gray-400 w-5px h-2px"></span></li>
              <li class="breadcrumb-item text-muted">Master</li>
              <li class="breadcrumb-item"><span class="bullet bg-gray-400 w-5px h-2px"></span></li>
              <li class="breadcrumb-item text-muted">Department</li>
            </ul>
          </div>
        </div>
      </div>

      <!-- Content -->
      <div id="kt_app_content" class="app-content flex-column-fluid">
        <div class="app-container container-xxl">

          <!--begin::Card-->
          <div class="card shadow-sm">
            <div class="card-header border-0 pt-7">
              <div class="card-title">
                <h2 class="mb-0">Department</h2>
              </div>
            </div>


            <form action="${pageContext.request.contextPath}/updateDepart.action" method="post" class="form" autocomplete="off">
              <div class="card-body p-10">


                <c:if test="${not empty error}">
                  <div class="alert alert-danger mb-7" role="alert">${error}</div>
                </c:if>

                <div class="row">


                  <div class="col-12 col-md-12 col-xl-12">
                    <div class="mb-7">
                      <label class="form-label fw-semibold">Department ID</label>
                      <input type="text" class="form-control form-control-lg" value="${department.id}" readonly disabled />
                    </div>
                  </div>


                  <input type="hidden" name="departmentId" value="${department.id}" />

                  <!-- Name -->
                  <div class="col-12 col-md-12 col-xl-12">
                    <div class="mb-7">
                      <label class="form-label fw-semibold">Department Name <span class="required"></span></label>
                      <input type="text" name="name" class="form-control form-control-lg" maxlength="240"
                             value="${department.name}" required />
                    </div>
                  </div>

                  <!-- Description -->
                  <div class="col-12 col-md-12 col-xl-12">
                    <div class="mb-7">
                      <label class="form-label fw-semibold">Description</label>
                      <textarea name="description" rows="4" class="form-control form-control-lg">${department.description}</textarea>
                    </div>
                  </div>

                  <!-- Prefix ID -->
                  <div class="col-12 col-md-12 col-xl-12">
                    <div class="mb-0">
                      <label class="form-label fw-semibold">Prefix ID</label>
   
                      <input type="text" name="deptpre" class="form-control form-control-lg" value="${department.prefixId}" />
                      <div class="invalid-feedback" style="display:none;"></div>
                    </div>
                  </div>

                </div>
                <!-- /row -->

                <input type="hidden" name="date" id="date" value="<fmt:formatDate value='${now}' pattern='dd-MM-yyyy'/>" />
                <input type="hidden" name="time" id="time" value="${time}" />
              </div>

              <!-- Actions -->
              <div class="card-footer d-flex justify-content-end gap-3 p-8">
                <a href="${pageContext.request.contextPath}/department_list.action" class="btn btn-light px-8">Cancel</a>
                <button type="submit" class="btn btn-success px-8">Save</button>
              </div>
            </form>
          </div>
          <!--end::Card-->

        </div>
      </div>
      <!-- END Content -->

    </div>
  </div>
  <!--end::Main-->


  <script>
  document.addEventListener('DOMContentLoaded', function () {
    var t = document.getElementById('time');
    if (t && (!t.value || t.value.trim() === '')) {
      var now = new Date();
      var hh = String(now.getHours()).padStart(2,'0');
      var mm = String(now.getMinutes()).padStart(2,'0');
      t.value = hh + ':' + mm;
    }
  });
  </script>

  <script>
  document.addEventListener('DOMContentLoaded', function () {

    const form = document.querySelector('form[action$="/updateDepart.action"]') || document.querySelector('form');
    const prefixInput = document.querySelector('input[name="deptpre"]');
    if (!form || !prefixInput) return;

    const prePattern = /^[A-Za-z0-9_-]+$/;


    function ensureErrorNode(input) {
      let node = input.parentNode.querySelector('.invalid-feedback');
      if (!node) {
        node = document.createElement('div');
        node.className = 'invalid-feedback';
        node.style.display = 'none';
        input.parentNode.appendChild(node);
      }
      return node;
    }
    const preErr = ensureErrorNode(prefixInput);

    function setError(input, node, message) {
      if (message) {
        input.classList.add('is-invalid');
        node.textContent = message;
        node.style.display = 'block';
      } else {
        input.classList.remove('is-invalid');
        node.textContent = '';
        node.style.display = 'none';
      }
    }

    function validatePrefixOptional() {
      const v = (prefixInput.value || '').trim();
      if (v.length === 0) { 
        setError(prefixInput, preErr, null);
        return true;
      }
      if (!prePattern.test(v)) {
        setError(prefixInput, preErr, 'Prefix ID can include only A–Z, a–z, 0–9, _ or -.');
        return false;
      }
      setError(prefixInput, preErr, null);
      return true;
    }

    prefixInput.addEventListener('keypress', function (e) {
      if (e.key === ' ') e.preventDefault();
    });

    prefixInput.addEventListener('input', validatePrefixOptional);
    prefixInput.addEventListener('blur',  validatePrefixOptional);

    form.addEventListener('submit', function (e) {
      if (!validatePrefixOptional()) e.preventDefault();
    });
  });
  </script>

</body>
</html>
