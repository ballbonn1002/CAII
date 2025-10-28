<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />

  <c:set var="contextPath" value="${pageContext.request.contextPath}" />
  <link  href="${contextPath}/assets/plugins/global/plugins.bundle.css" rel="stylesheet" type="text/css" />
  <script src="${contextPath}/assets/plugins/global/plugins.bundle.js"></script>

  <!-- SweetAlert -->
  <link  rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>

  <style>
    .form-icon-left { position: relative; }
    .form-icon-left .ki-duotone { position: absolute; left: .9rem; top: 50%; transform: translateY(-50%); }
    .form-icon-left input { padding-left: 2.5rem; }
    .flatpickr-input[readonly] { background-color: #fff; }
  </style>
</head>
<body>
  <div class="app-main flex-column flex-row-fluid" id="kt_app_main">
    <div class="d-flex flex-column flex-column-fluid">

      <!-- Toolbar -->
      <div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
        <div id="kt_app_toolbar_container" class="app-container container-xxl d-flex flex-stack">
          <div class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
            <h1 class="page-heading d-flex text-gray-900 fw-bold fs-3 my-0">Edit Holiday</h1>
            <ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
              <li class="breadcrumb-item text-muted">
                <a href="${contextPath}/demo_dashboard" class="text-muted text-hover-primary">Home</a>
              </li>
              <li class="breadcrumb-item"><span class="bullet bg-gray-500 w-5px h-2px"></span></li>
              <li class="breadcrumb-item text-muted">Master</li>
              <li class="breadcrumb-item"><span class="bullet bg-gray-500 w-5px h-2px"></span></li>
              <li class="breadcrumb-item text-muted">Holiday</li>
            </ul>
          </div>
        </div>
      </div>

      <!-- Content -->
      <div id="kt_app_content" class="app-content flex-column-fluid">
        <div id="kt_app_content_container" class="app-container container-xxl">

          <div class="card">
            <div class="card-header border-0 pt-7">
              <div class="card-title"><h2 class="mb-0">Holiday Application Form</h2></div>
            </div>

            <form id="holidayForm"
                  action="${contextPath}/UpdateHoliday"
                  method="POST"
                  onsubmit="return myVal_form()"
                  novalidate>

              <div class="card-body">
                <input type="hidden" name="id_date"   value="${holidayrecord.id_date}" />
                <input type="hidden" id="flag_form"   value="${flag_form}"/>

                <!-- เตรียมค่าวันที่รูปแบบ dd-MM-yyyy -->
                <c:set var="start_dmy"><fmt:formatDate value="${holidayrecord.start_date}" pattern="dd-MM-yyyy"/></c:set>
                <c:set var="end_dmy"><fmt:formatDate   value="${holidayrecord.end_date}"   pattern="dd-MM-yyyy"/></c:set>

                <div class="row g-5 mb-5">
                  <!-- Start Date -->
                  <div class="col-md-6">
                    <label for="date_s" class="form-label fw-semibold">
                      Start Date <span class="text-danger">*</span>
                    </label>
                    <div class="form-icon-left">
                      <i class="ki-duotone ki-calendar-8 text-gray-500">
                        <span class="path1"></span><span class="path2"></span><span class="path3"></span>
                        <span class="path4"></span><span class="path5"></span><span class="path6"></span>
                      </i>
                      <input type="text"
                             id="date_s"
                             name="Date-Start"
                             class="form-control"
                             placeholder="1 Jan 2025"
                             autocomplete="off"
                             required
                             value="${start_dmy}" />
                    </div>
                  </div>

                  <!-- End Date -->
                  <div class="col-md-6">
                    <label for="date_e" class="form-label fw-semibold">
                      End Date <span class="text-danger">*</span>
                    </label>
                    <div class="form-icon-left">
                      <i class="ki-duotone ki-calendar-8 text-gray-500">
                        <span class="path1"></span><span class="path2"></span><span class="path3"></span>
                        <span class="path4"></span><span class="path5"></span><span class="path6"></span>
                      </i>
                      <input type="text"
                             id="date_e"
                             name="Date-End"
                             class="form-control"
                             placeholder="1 Jan 2025"
                             autocomplete="off"
                             required
                             value="${end_dmy}" />
                    </div>
                  </div>
                </div>

                <!-- Holiday Name -->
                <div class="mb-5">
                  <label for="nameid" class="form-label fw-semibold">
                    Holiday Name <span class="text-danger">*</span>
                  </label>
                  <input id="nameid"
                         name="name"
                         type="text"
                         class="form-control"
                         maxlength="240"
                         pattern="[^'\"]*"
                         title="ห้ามใช้อักขระ ' และ &quot;"
                         placeholder="Holiday name"
                         required
                         onkeyup="check_char(this)"
                         value="<c:out value='${holidayrecord.head}'/>" />
                </div>

                <!-- Description -->
                <div class="mb-1">
                  <label for="demo2" class="form-label fw-semibold">Description</label>
                  <textarea id="demo2"
                            name="description"
                            rows="4"
                            maxlength="1024"
                            class="form-control"
                            placeholder="Optional details..."
                            style="word-break: break-word; white-space: normal;"
                            onkeyup="check_char(this)"><c:out value="${holidayrecord.description}"/></textarea>
                </div>

                <input type="hidden" id="demo3" />
              </div>

              <div class="separator my-0"></div>

              <div class="card-footer">
                <div class="d-flex justify-content-end gap-3">
                  <button type="button"
                          class="btn btn-light d-inline-flex align-items-center justify-content-center"
                          onclick="onCancel()">Cancel</button>
                  <button type="submit" class="btn btn-success" id="btnUpdate">
                    Save
                  </button>
                </div>
              </div>
            </form>
          </div>

        </div>
      </div>
    </div>
    <div id="kt_app_footer" class="app-footer"></div>
  </div>

  <script>
    function check_char(elm) {
      if (elm.value.match(/['"]/) && elm.value.length > 0) {
        swal({ title: "ERROR", text: "ห้ามใส่อักขระพิเศษ", type: "error" }, function(){});
      }
    }

    // Cancel → กลับหน้า list เสมอ (ตัด holiday_calendar ออกเรียบร้อย)
    function onCancel() {
      document.location = '<c:url value="/holiday_list"/>';
    }

    // Validate ก่อน submit
    function myVal_form() {
      var el  = document.getElementById("demo2");
      var val = el.value.replace(/\s/g, "");
      document.getElementById("demo3").value = val;

      const sVal = document.getElementById("date_s").value;
      const eVal = document.getElementById("date_e").value || sVal;

      if (!sVal) {
        swal('Please!', 'กรุณาเลือก Start Date', 'warning');
        return false;
      }

      const toISO = (dmy) => { const [dd, mm, yy] = dmy.split('-'); return new Date(+yy, mm - 1, +dd); };
      const sd = toISO(sVal);
      const ed = toISO(eVal);

      if (sd.getTime() > ed.getTime()) {
        swal('Please!', 'Start Date ต้องไม่มากกว่า End Date', 'warning');
        return false;
      }
      return true;
    }

    // ===== flatpickr =====
    const fpOpts = {
      dateFormat: "d-m-Y",
      altInput: true,
      altFormat: "j M Y",
      allowInput: true,
      disableMobile: true
    };
    const fpStart = window.flatpickr ? flatpickr("#date_s", fpOpts) : null;
    const fpEnd   = window.flatpickr ? flatpickr("#date_e", fpOpts) : null;

    (function boot(){
      const s = document.getElementById("date_s").value;
      const e = document.getElementById("date_e").value;
      if (fpStart && s) fpStart.setDate(s, true, "d-m-Y");
      if (fpEnd   && e) fpEnd.setDate(e, true, "d-m-Y");

      var flagDup = "${flag}";
      if (flagDup == 1) {
        swal('Please!', 'Check Date Duplicate', 'warning');
      }
    })();
  </script>
</body>
</html>
