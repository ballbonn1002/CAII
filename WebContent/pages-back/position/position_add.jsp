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
          <h1 class="page-heading text-gray-900 fw-bold fs-2 my-0">Add Position</h1>
          <ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 pt-1">
            <li class="breadcrumb-item text-muted">Home</li>
            <li class="breadcrumb-item"><span class="bullet bg-gray-400 w-5px h-2px"></span></li>
            <li class="breadcrumb-item text-muted">Master</li>
            <li class="breadcrumb-item"><span class="bullet bg-gray-400 w-5px h-2px"></span></li>
            <li class="breadcrumb-item text-muted">Position List</li>
          </ul>
        </div>
      </div>
    </div>

    <!-- Content -->
    <div id="kt_app_content" class="app-content flex-column-fluid">
      <div class="app-container container-xxl">

        <!-- Card -->
        <div class="card shadow-sm">
          <div class="card-header border-0 pt-7">
            <div class="card-title">
              <h2 class="mb-0">Position</h2>
            </div>
          </div>

          <c:set var="selectedDeptId" value="${not empty form.departmentId ? form.departmentId : param.departmentId}" />

          <form action="${pageContext.request.contextPath}/savePosition.action" method="post" class="form" autocomplete="off">
            <div class="card-body p-10">

              <c:if test="${not empty error}">
                <div class="alert alert-danger mb-7" role="alert">${error}</div>
              </c:if>

              <div class="row g-5">

                <!-- Position ID -->
                <div class="col-12 col-md-12 col-xl-12">
                  <div class="mb-7">
                    <label class="form-label fw-semibold">Position ID <span class="required"></span></label>
                    <input
                      type="text"
                      name="positionId"
                      maxlength="20"
                      required
                      class="form-control form-control-lg"
                      value="${not empty form.positionId ? form.positionId : param.positionId}" />
                    <div class="invalid-feedback" style="display:none;"></div>
                  </div>
                </div>

                <!-- Position Name -->
                <div class="col-12 col-md-12 col-xl-12">
                  <div class="mb-7">
                    <label class="form-label fw-semibold">Position Name <span class="required"></span></label>
                    <input
                      type="text"
                      name="name"
                      required
                      class="form-control form-control-lg"
                      value="${not empty form.name ? form.name : param.name}" />
                  </div>
                </div>

                <!-- Department ID -->
                <div class="col-12 col-md-12 col-xl-12">
                  <div class="mb-7">
                    <label class="form-label fw-semibold">Department ID <span class="required"></span></label>
                    <select class="form-select form-select-lg" name="departmentId" required>
                      <c:forEach var="department" items="${departmentList}">
                        <option value="${department.id}"
                          <c:if test="${selectedDeptId == department.id}">selected</c:if>>
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
                    <textarea
                      name="description"
                      rows="3"
                      class="form-control form-control-lg"
                    >${not empty form.description ? form.description : param.description}</textarea>
                  </div>
                </div>

              </div>
              <!-- /row -->

              <input type="hidden" name="date" id="date" value="" />
              <input type="hidden" name="time" id="time" value="" />
            </div>

            <!-- Actions -->
            <div class="card-footer d-flex justify-content-end gap-3 p-8">
              <a href="${pageContext.request.contextPath}/position_list.action" class="btn btn-light px-8">Cancel</a>
              <button type="submit" class="btn btn-success px-8">Save</button>
            </div>
          </form>
        </div>
        <!-- /Card -->

      </div>
    </div>
    <!-- /Content -->

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

<!-- Validate + Duplicate-check Position ID (โค้ดเดิม) -->
<script>
document.addEventListener("DOMContentLoaded", function () {
  const form    = document.querySelector("form");
  const idInput = document.querySelector('input[name="positionId"]');
  const ctx     = "${pageContext.request.contextPath}";

  // A–Z, a–z, 0–9, _ และ - (สูงสุด 20 ตัว)
  const idPattern = /^[A-Za-z0-9_-]{1,20}$/;

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
  const idErr = ensureErrorNode(idInput);

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

  function validateIdPattern() {
    const v = (idInput.value || '').trim();
    if (v.length === 0) { setError(idInput, idErr, null); return false; }
    if (!idPattern.test(v)) {
      setError(idInput, idErr, 'Position ID can include only A–Z, a–z, 0–9, _ or -.');
      return false;
    }
    setError(idInput, idErr, null);
    return true;
  }


  let lastChecked = { id: null, status: null }; 
  let reqSeq = 0; 
  let debounceTimer = null;

  async function checkDuplicate(force = false) {
    const id = (idInput.value || '').trim();
    if (!id || !idPattern.test(id)) return true;

    if (!force && lastChecked.id === id && lastChecked.status !== null) {
      if (lastChecked.status === 'duplicate') {
        setError(idInput, idErr, 'Position ID is already in use.');
        return false;
      } else {
        setError(idInput, idErr, null);
        return true;
      }
    }

    const url = ctx + "/checkDuplicatePositionId.action?positionId=" + encodeURIComponent(id);
    const mySeq = ++reqSeq;

    try {
      const resp = await fetch(url, { method: "GET", cache: "no-store" });
      if (!resp.ok) {
        lastChecked = { id: null, status: null };
        return true;
      }
      const text = (await resp.text()).trim();

      if (mySeq !== reqSeq) return true;

      if (text === 'duplicate') {
        lastChecked = { id, status: 'duplicate' };
        setError(idInput, idErr, 'Position ID is already in use.');
        return false;
      } else {
        lastChecked = { id, status: 'ok' };
        if (idPattern.test(id)) setError(idInput, idErr, null);
        return true;
      }
    } catch (e) {
      console.error('dup-check failed', e);
      lastChecked = { id: null, status: null };
      return true;
    }
  }

  idInput.addEventListener('input', () => {
    const valid = validateIdPattern();

    lastChecked = { id: null, status: null };

    clearTimeout(debounceTimer);
    if (valid) {
      debounceTimer = setTimeout(() => { checkDuplicate(false); }, 400);
    }
  });

  idInput.addEventListener('blur', async () => {
    if (validateIdPattern()) {
      await checkDuplicate(true);
    }
  });

  form.addEventListener('submit', async (e) => {
    const okId  = validateIdPattern();
    let okDup   = true;
    if (okId) okDup = await checkDuplicate(true);

    if (!okId || !okDup) {
      e.preventDefault();
    }
  });
});
</script>

</body>
</html>
