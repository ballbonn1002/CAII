<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  
  <link href="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.css" rel="stylesheet" type="text/css" />
  <link href="${pageContext.request.contextPath}/assets/css/style.bundle.css" rel="stylesheet" type="text/css" />
  <script src="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.js"></script>
</head>

<body class="app-blank">
<!--begin::Main-->
<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
  <div class="d-flex flex-column flex-column-fluid">

    <!-- Toolbar -->
    <div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
      <div id="kt_app_toolbar_container" class="app-container container-fluid d-flex flex-stack text-start">
        <div class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
          <h1 class="page-heading d-flex text-gray-700 fw-semibold flex-column justify-content-center my-0">
            NEW Page URI</h1>
          <ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 pt-1">
            <li class="breadcrumb-item text-muted">Home</li>
            <li class="breadcrumb-item"><span class="bullet bg-gray-400 w-5px h-2px"></span></li>
            <li class="breadcrumb-item text-muted">CMS</li>
            <li class="breadcrumb-item"><span class="bullet bg-gray-400 w-5px h-2px"></span></li>
            <li class="breadcrumb-item text-muted">Page URI</li>
          </ul>
        </div>
      </div>
    </div>

    <!-- Content -->
    <div id="kt_app_content" class="app-content flex-column-fluid">
      <div class="app-container container-fluid">

        <!-- Card -->
        <div class="card mb-10">
          <div class="card-header border-bottom d-flex align-items-center pt-6 pb-6">
            <div class="card-title">
              <h3 class="fw-semibold text-gray-900 mb-0">Page URL Detail</h3>
            </div>
          </div>

          <form action="${pageContext.request.contextPath}/savePageUri.action" method="post" class="form" autocomplete="off" onsubmit="return validateForm(event);">
            <div class="card-body p-10">

              <!-- Row 1 -->
              <div class="row mb-7">
                <div class="col-lg-12">
                  <label class="required form-label fw-semibold">Page URL</label>
                  <input type="text" name="pageUriId" id="pageUriId" class="form-control form-control-lg" required />
                  <div class="invalid-feedback d-none" id="pageUriIdFeedback">This Page URL is already in use.</div>
                </div>
              </div>

              <!-- Row 2 -->
              <div class="row mb-7">
                <div class="col-lg-4">
                  <label class="required form-label fw-semibold">Forward to</label>
                  <input type="text" name="forwardTo" id="forwardTo" class="form-control form-control-lg" required />
                  <div class="invalid-feedback d-none" id="forwardToFeedback">This Forward to is already in use.</div>
                </div>
                <div class="col-lg-4">
                  <label class="form-label fw-semibold">Model</label>
                  <input type="text" name="model" class="form-control form-control-lg" />
                </div>
                <div class="col-lg-4">
                  <label class="form-label fw-semibold">Model ID</label>
                  <input type="text" name="modelId" class="form-control form-control-lg" />
                </div>
              </div>

              <!-- Row 3 -->
              <div class="row mb-7">
                <div class="col-lg-12">
                  <label class="form-label fw-semibold">Title</label>
                  <input type="text" name="pageUriTitle" class="form-control form-control-lg" />
                </div>
              </div>

              <!-- Row 4 -->
              <div class="row mb-7">
                <div class="col-lg-12">
                  <label class="form-label fw-semibold">Meta</label>
                  <textarea name="meta" rows="3" class="form-control form-control-lg"></textarea>
                </div>
              </div>

              <!-- Row 5 -->
              <div class="row mb-7">
                <div class="col-lg-12">
                  <label class="form-label fw-semibold">Description</label>
                  <textarea name="pageUriDescription" rows="5" class="form-control form-control-lg"></textarea>
                </div>
              </div>

            </div>

            <!-- Actions -->
            <div class="card-footer d-flex justify-content-between p-10">
              <a href="${pageContext.request.contextPath}/page_uri_list.action" class="btn btn-light">
                <i class="ki-duotone ki-arrow-left"><span class="path1"></span><span class="path2"></span></i>
                Back
              </a>
              <button type="submit" class="btn btn-success">Submit</button>
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
function validateForm(e) {
    e.preventDefault();
    var ft = document.getElementById("forwardTo");
    var pid = document.getElementById("pageUriId");
    var form = e.target;
    
    // Ajax call to check duplicate forward to and page url
    $.ajax({
        url: "${pageContext.request.contextPath}/checkDuplicateForwardTo.action",
        type: "POST",
        data: {
            forwardTo: ft.value,
            pageUriId: pid.value
        },
        success: function(response) {
            let hasError = false;
            
            if(response.isDuplicateUrl) {
                pid.classList.add("is-invalid");
                document.getElementById("pageUriIdFeedback").classList.remove("d-none");
                hasError = true;
            } else {
                pid.classList.remove("is-invalid");
                document.getElementById("pageUriIdFeedback").classList.add("d-none");
            }

            if(response.isDuplicate) {
                ft.classList.add("is-invalid");
                document.getElementById("forwardToFeedback").classList.remove("d-none");
                hasError = true;
            } else {
                ft.classList.remove("is-invalid");
                document.getElementById("forwardToFeedback").classList.add("d-none");
            }
            
            if(hasError) {
                Swal.fire({
                    text: 'Forward to is already in use. Please check your inputs.',
                    icon: 'error',
                    buttonsStyling: false,
                    confirmButtonText: 'Ok, got it!',
                    customClass: { confirmButton: 'btn fw-bold btn-primary' }
                });
            } else {
                form.submit();
            }
        },
        error: function() {
            Swal.fire({
                text: 'Network error occurred while validating. Please try again.',
                icon: 'error',
                buttonsStyling: false,
                confirmButtonText: 'Ok',
                customClass: { confirmButton: 'btn fw-bold btn-primary' }
            });
        }
    });

    return false;
}

function checkDuplicateRealtime() {
    var ft = document.getElementById("forwardTo").value;
    var pid = document.getElementById("pageUriId").value;
    
    if(!pid && !ft) return;

    $.ajax({
        url: "${pageContext.request.contextPath}/checkDuplicateForwardTo.action",
        type: "POST",
        data: {
            forwardTo: ft,
            pageUriId: pid
        },
        success: function(response) {
            var pidEl = document.getElementById("pageUriId");
            if(response.isDuplicateUrl && pid) {
                pidEl.classList.add("is-invalid");
                document.getElementById("pageUriIdFeedback").classList.remove("d-none");
            } else {
                pidEl.classList.remove("is-invalid");
                document.getElementById("pageUriIdFeedback").classList.add("d-none");
            }

            var ftEl = document.getElementById("forwardTo");
            if(response.isDuplicate && ft) {
                ftEl.classList.add("is-invalid");
                document.getElementById("forwardToFeedback").classList.remove("d-none");
            } else {
                ftEl.classList.remove("is-invalid");
                document.getElementById("forwardToFeedback").classList.add("d-none");
            }
        }
    });
}

// Check duplicates on blur
document.getElementById("forwardTo").addEventListener("blur", checkDuplicateRealtime);
document.getElementById("pageUriId").addEventListener("blur", checkDuplicateRealtime);

// Remove invalid class on typing
document.getElementById("forwardTo").addEventListener("input", function() {
    this.classList.remove("is-invalid");
    document.getElementById("forwardToFeedback").classList.add("d-none");
});

document.getElementById("pageUriId").addEventListener("input", function() {
    this.classList.remove("is-invalid");
    document.getElementById("pageUriIdFeedback").classList.add("d-none");
});
</script>

</body>
</html>
