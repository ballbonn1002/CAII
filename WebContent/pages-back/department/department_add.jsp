<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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
            <h1 class="page-heading text-gray-900 fw-bold fs-2 my-0">Add Department</h1>
            <ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 pt-1">
              <li class="breadcrumb-item text-muted">Home</li>
              <li class="breadcrumb-item"><span class="bullet bg-gray-400 w-5px h-2px"></span></li>
              <li class="breadcrumb-item text-muted">Master</li>
              <li class="breadcrumb-item"><span class="bullet bg-gray-400 w-5px h-2px"></span></li>
              <li class="breadcrumb-item text-muted">Department List</li>
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

            <form action="${pageContext.request.contextPath}/saveDepart.action" method="post" class="form" autocomplete="off">
              <div class="card-body p-10">

                <c:if test="${not empty error}">
                  <div class="alert alert-danger mb-7" role="alert">${error}</div>
                </c:if>

                <div class="row g-5">

                  <!-- Department ID -->
                  <div class="col-12 col-md-12 col-xl-12">
                    <div class="mb-7">
                      <label class="form-label fw-semibold">Department ID <span class="required"></span></label>
                      <input type="text" name="ID" required maxlength="20" class="form-control form-control-lg" />
                      <div class="invalid-feedback" style="display:none;"></div>
                    </div>
                  </div>

                  <!-- Department Name -->
                  <div class="col-12 col-md-12 col-xl-12">
                    <div class="mb-7">
                      <label class="form-label fw-semibold">Department Name <span class="required"></span></label>
                      <input type="text" name="name" required class="form-control form-control-lg" />
                    </div>
                  </div>
                  
                    <!-- Description -->
                  <div class="col-12 col-md-12 col-xl-12">
                    <div class="mb-7">
                      <label class="form-label fw-semibold">Description</label>
                      <textarea name="deptdes" rows="3" class="form-control form-control-lg"></textarea>
                    </div>
                  </div>

                  <!-- Prefix ID -->
                  <div class="col-12 col-md-12 col-xl-12">
                    <div class="mb-0">
                      <label class="form-label fw-semibold">Prefix ID</label>
                      <input type="text" name="deptpre" class="form-control form-control-lg" />
                    </div>
                  </div>

                </div>
                <!-- /row -->

                <input type="hidden" id="date" name="date" value="" />
                <input type="hidden" id="time" name="time" value="" />
              </div>

              <div class="card-footer d-flex justify-content-end gap-3 p-8">
                <a href="${pageContext.request.contextPath}/department_list.action" class="btn btn-light px-8">Cancel</a>
                <button type="submit" class="btn btn-success px-8">Save</button>
              </div>
            </form>
          </div>
          <!--end::Card-->

        </div>
      </div>

    </div>
  </div>
  <!--end::Main-->

  <script>
  document.addEventListener('DOMContentLoaded', function () {
    const d = new Date();
    const dd = String(d.getDate()).padStart(2,'0');
    const mm = String(d.getMonth() + 1).padStart(2,'0');
    const yyyy = d.getFullYear();
    document.getElementById('date').value = `${dd}-${mm}-${yyyy}`;

    const hh = String(d.getHours()).padStart(2,'0');
    const mi = String(d.getMinutes()).padStart(2,'0');
    document.getElementById('time').value = `${hh}:${mi}`;
  });
  </script>

  <!-- Validate + Duplicate-check -->
  <script>
  document.addEventListener("DOMContentLoaded", function () {
    const form        = document.querySelector("form");
    const deptIdInput = document.querySelector('input[name="ID"]');
    const prefixInput = document.querySelector('input[name="deptpre"]');
    const ctx         = "${pageContext.request.contextPath}";

    const idPattern  = /^[A-Za-z0-9_-]{1,20}$/;
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
    const idErr  = ensureErrorNode(deptIdInput);
    const preErr = ensureErrorNode(prefixInput);

    function setError(input, node, message) {
      if (message) {
        input.classList.add('is-invalid');
        node.textContent = message;
        node.style.display = 'block';
      } else {
        input.classList.remove('is-invalid');
        node.style.display = 'none';
        node.textContent = '';
      }
    }

    function validateDeptIdPattern() {
      const v = (deptIdInput.value || '').trim();
      if (v.length === 0) { setError(deptIdInput, idErr, null); return false; }
      if (!idPattern.test(v)) {
        setError(deptIdInput, idErr, 'Department ID can include only A–Z, a–z, 0–9, _ or -.');
        return false;
      }
      setError(deptIdInput, idErr, null);
      return true;
    }

    function validatePrefixOptional() {
      const v = (prefixInput.value || '').trim();
      if (v.length === 0) { setError(prefixInput, preErr, null); return true; }
      if (!prePattern.test(v)) {
        setError(prefixInput, preErr, 'Prefix ID can include only A–Z, a–z, 0–9, _ or -.');
        return false;
      }
      setError(prefixInput, preErr, null);
      return true;
    }

    let lastChecked = { id: null, status: null };
    let reqSeq = 0, debounceTimer = null;

    async function checkDeptIdDuplicate(force = false) {
      const id = (deptIdInput.value || '').trim();
      if (!id || !idPattern.test(id)) return true;

      if (!force && lastChecked.id === id && lastChecked.status !== null) {
        const ok = (lastChecked.status === 'ok');
        setError(deptIdInput, idErr, ok ? null : 'Department ID is already in use.');
        return ok;
      }

      const url = ctx + "/checkDuplicateDepartmentId.action?departmentId=" + encodeURIComponent(id);
      const mySeq = ++reqSeq;
      try {
        const resp = await fetch(url, { method: "GET", cache: "no-store" });
        const text = (await resp.text()).trim();
        if (mySeq !== reqSeq) return true;

        if (text === 'duplicate') {
          lastChecked = { id, status: 'duplicate' };
          setError(deptIdInput, idErr, 'Department ID is already in use.');
          return false;
        } else {
          lastChecked = { id, status: 'ok' };
          if (idPattern.test(id)) setError(deptIdInput, idErr, null);
          return true;
        }
      } catch (e) {
        console.error('dup-check failed', e);
        lastChecked = { id: null, status: null };
        return true;
      }
    }

    deptIdInput.addEventListener('input', () => {
      const valid = validateDeptIdPattern();
      lastChecked = { id: null, status: null };
      clearTimeout(debounceTimer);
      if (valid) debounceTimer = setTimeout(() => { checkDeptIdDuplicate(false); }, 400);
    });

    deptIdInput.addEventListener('blur', async () => {
      if (validateDeptIdPattern()) await checkDeptIdDuplicate(true);
    });

    prefixInput.addEventListener('input',  validatePrefixOptional);
    prefixInput.addEventListener('blur',   validatePrefixOptional);

    form.addEventListener('submit', async (e) => {
      const okId  = validateDeptIdPattern();
      const okPre = validatePrefixOptional();
      let okDup   = true;
      if (okId) okDup = await checkDeptIdDuplicate(true);
      if (!okId || !okPre || !okDup) e.preventDefault();
    });
  });
  </script>

</body>
</html>
