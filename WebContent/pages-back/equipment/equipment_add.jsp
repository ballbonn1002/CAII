<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="en_US" />

<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
  <div class="d-flex flex-column flex-column-fluid">
    <div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
      <div
        id="kt_app_toolbar_container"
        class="app-container container-fluid d-flex flex-stack"
      >
        <div
          class="page-title d-flex flex-column justify-content-center flex-wrap me-3"
        >
          <h1 class="page-heading d-flex text-gray-700 fw-semibold my-0">
            Add Equipment
          </h1>
          <ul
            class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1"
          >
            <li class="breadcrumb-item text-muted">
              <a
                href="${pageContext.request.contextPath}/demo_dashboard"
                class="text-muted text-hover-primary fw-medium fs-7"
                >Home</a
              >
            </li>
            <li class="breadcrumb-item">
              <span
                class="bullet bg-gray-500 fw-medium fs-7 w-5px h-2px"
              ></span>
            </li>
            <li class="breadcrumb-item text-muted fw-medium fs-7">Borrow</li>
            <li class="breadcrumb-item">
              <span
                class="bullet bg-gray-500 fw-medium fs-7 w-5px h-2px"
              ></span>
            </li>
            <li class="breadcrumb-item text-muted fw-medium fs-7">Equipment</li>
          </ul>
        </div>
      </div>
    </div>

    <div id="kt_app_content" class="app-content flex-column-fluid">
      <div id="kt_app_content_container" class="app-container container-fluid">
        <form
          action="/equipment_save.action"
          method="post"
          enctype="multipart/form-data"
          id="kt_equipment_add_form"
        >
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
                      <label class="d-block fw-semibold fs-6 mb-3"
                        >Item Picture</label
                      >
                      <div class="d-flex flex-column align-items-start">
                        <div
                          id="errorMsg"
                          class="text-center text-danger mb-3"
                        ></div>
                        <c:set var="imageSrc" value="" />
                        <c:if test="${not empty equipmentbyId.image}">
                          <c:set
                            var="imageSrc"
                            value="${pageContext.request.contextPath}/${equipmentbyId.image}"
                          />
                        </c:if>

                        <div
                          class="border rounded-3 bg-light d-flex align-items-center justify-content-center mb-1"
                          style="width: 200px; height: 200px; overflow: hidden"
                        >
                          <img
                            id="itemImagePreview"
                            src="${imageSrc}"
                            style="max-width:100%; max-height:100%; object-fit:contain; ${empty equipmentbyId.image ? 'display:none;' : ''}"
                          />
                          <span
                            id="itemImagePlaceholder"
                            class="text-muted fs-7 ${empty equipmentbyId.image ? '' : 'd-none'}"
                          >
                            No image selected
                          </span>
                        </div>

                        <input
                          type="file"
                          id="itemImageInput"
                          name="image"
                          accept="image/*"
                          class="d-none"
                        />
                        <button
                          type="button"
                          id="itemImageSelectBtn"
                          class="btn btn-light mt-1 fs-7"
                        >
                          <i class="ki-duotone ki-picture fs-2 text-gray-700">
                            <span class="path1"></span
                            ><span class="path2"></span>
                          </i>
                          Select Image
                        </button>
                      </div>
                    </div>

                    <div class="col-lg-6 mb-8">
                      <div class="mb-7">
                        <label class="required form-label">Type</label>
                        <select
                          class="form-select"
                          name="type"
                          id="typeSelect"
                          data-control="select2"
                          data-placeholder="Select Type"
                          required
                        >
                          <option></option>
                        </select>
                      </div>

                      <div class="mb-7">
                        <label class="required form-label">Status</label>
                        <select
                          class="form-select"
                          id="statusSelect"
                          name="status"
                          data-control="select2"
                          data-placeholder="Select Status"
                          required
                        >
                          <option></option>
                        </select>
                      </div>

                      <div class="mb-0">
                        <label class="form-label fw-medium">
                          Specify a note when changing status (optional)
                        </label>
                        <textarea
                          class="form-control"
                          name="statusChange"
                          rows="2"
                          placeholder="Enter maintenance or repair notes..."
                        ></textarea>
                      </div>
                    </div>
                  </div>

                  <div class="row g-5 mb-5">
                    <div class="col-md-6">
                      <label class="required form-label">Item Name</label>
                      <input
                        type="text"
                        name="name"
                        class="form-control"
                        placeholder="Item name"
                        value="${equipmentbyId.name}"
                        required
                      />
                    </div>
                    <div class="col-md-6">
                      <label class="required form-label">Item No.</label>
                      <input
                        type="text"
                        id="itemNoInput"
                        name="itemNo"
                        class="form-control"
                        placeholder="Item No."
                        value="${equipmentbyId.itemNo}"
                        required
                        oninput="
                          this.classList.remove('is-invalid');
                          $('#itemNoFeedback').hide();
                          $('button[type=submit]').prop('disabled', false);
                        "
                      />
                      <div
                        id="itemNoFeedback"
                        class="invalid-feedback"
                        style="
                          display: none;
                          color: #dc3545;
                          margin-top: 0.5rem;
                          font-size: 0.875em;
                        "
                      >
                        This item No. already exists in the system.
                      </div>
                    </div>
                  </div>

                  <div class="row g-5 mb-5">
                    <div class="col-md-6">
                      <label class="required form-label">Serial No.</label>
                      <input
                        type="text"
                        name="serialNo"
                        class="form-control"
                        placeholder="Serial No."
                        value="${equipmentbyId.serialNo}"
                        required
                      />
                    </div>
                    <div class="col-md-6">
                      <label class="required form-label">Amount</label>
                      <input
                        type="number"
                        name="amount"
                        class="form-control"
                        placeholder="1"
                        value="${equipmentbyId.amount}"
                        min="0"
                        oninput="
                          this.value =
                            this.value === '' ? '' : Math.abs(this.value)
                        "
                        required
                      />
                    </div>
                  </div>

                  <div class="row g-5">
                    <div class="col-md-6">
                      <label class="form-label">Date of Purchase</label>
                      <fmt:formatDate value="${equipmentbyId.timeCreate}" pattern="dd-MMM-yyyy" var="fmtDatePurchase" />
                      <div class="position-relative d-flex align-items-center">
                        <span
                          class="svg-icon svg-icon-2 position-absolute mx-4"
                        >
                          <i class="ki-duotone ki-calendar-8 fs-2">
                            <span class="path1"></span
                            ><span class="path2"></span
                            ><span class="path3"></span
                            ><span class="path4"></span
                            ><span class="path5"></span
                            ><span class="path6"></span
                          ></i>
                        </span>
                        <input
                          class="form-control ps-12"
                          placeholder="Select date"
                          id="kt_datepicker_1"
                          name="datePurchase"
                          value="${fmtDatePurchase}"
                          autocomplete="off"
                        />
                      </div>
                    </div>
                    <div class="col-md-6">
                      <label class="form-label">Detail</label>
                      <input
                        type="text"
                        name="detail"
                        class="form-control"
                        placeholder="Detail"
                        value="${equipmentbyId.detail}"
                      />
                    </div>
                  </div>
                </div>
              </div>

              <div class="card shadow-sm mb-5 mb-xl-10">
                <div class="card-header fs-4">
                  <div class="card-title m-0">
                    <h3 class="fw-bold m-0">More Detail</h3>
                  </div>
                </div>
                <div class="card-body pt-6">
                  <div class="row g-5 mb-5">
                    <div class="col-md-6">
                      <label class="form-label">Windows</label>
                      <input
                        type="text"
                        name="windows"
                        class="form-control"
                        value="${equipmentbyId.windows}"
                        placeholder="Windows version"
                      />
                    </div>
                    <div class="col-md-6">
                      <label class="form-label">CPU</label>
                      <input
                        type="text"
                        name="process"
                        class="form-control"
                        value="${equipmentbyId.process}"
                        placeholder="CPU"
                      />
                    </div>
                  </div>

                  <div class="row g-5 mb-5">
                    <div class="col-md-6">
                      <label class="form-label">Ram</label>
                      <input
                        type="text"
                        name="ram"
                        class="form-control"
                        value="${equipmentbyId.ram}"
                        placeholder="Ram (GB)"
                      />
                    </div>
                    <div class="col-md-6">
                      <label class="form-label">Storage</label>
                      <input
                        type="text"
                        name="hdd"
                        class="form-control"
                        value="${equipmentbyId.hdd}"
                        placeholder="Storage (GB)"
                      />
                    </div>
                  </div>

                  <div class="row g-5 mb-5">
                    <div class="col-md-6">
                      <label class="form-label">Battery</label>
                      <input
                        type="text"
                        name="battery"
                        class="form-control"
                        value="${equipmentbyId.battery}"
                        placeholder="Battery (kWh)"
                      />
                    </div>
                    <div class="col-md-6">
                      <label class="form-label">WIFI Address</label>
                      <input
                        type="text"
                        name="wifiaddress"
                        class="form-control"
                        value="${equipmentbyId.wifiaddress}"
                        placeholder="WIFI address"
                      />
                    </div>
                  </div>

                  <div class="row g-5">
                    <div class="col-md-6">
                      <label class="form-label">LAN Address</label>
                      <input
                        type="text"
                        name="lanaddress"
                        class="form-control"
                        value="${equipmentbyId.lanaddress}"
                        placeholder="LAN address"
                      />
                    </div>
                    <div class="col-md-6">
                      <label class="form-label">Display</label>
                      <input
                        type="text"
                        name="display"
                        class="form-control"
                        value="${equipmentbyId.display}"
                        placeholder="Display (inches)"
                      />
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
                    <h3 class="fw-bold m-0">Status log</h3>
                  </div>
                  <div class="card-toolbar">
                    <div
                      class="btn btn-sm btn-icon btn-active-light-primary"
                      data-bs-toggle="collapse"
                      data-bs-target="#kt_status_log_collapse"
                    >
                      <i class="bi bi-chevron-down"></i>
                    </div>
                  </div>
                </div>
                <div class="collapse show" id="kt_status_log_collapse">
                  <div class="card-body pt-0 pb-5">
                    <div
                      class="d-flex flex-column align-items-center justify-content-center py-10"
                    >
                      <i class="ki-duotone ki-cube-2 fs-3x text-gray-500 mb-4">
                        <span class="path1"></span><span class="path2"></span
                        ><span class="path3"></span>
                      </i>
                      <span class="text-gray-800 fw-semibold fs-5"
                        >No data</span
                      >
                    </div>
                  </div>
                </div>
              </div>

              <div class="card shadow-sm mb-5 mb-xl-10">
                <div class="card-header fs-4">
                  <h3 class="card-title fw-bold m-0">Usage History</h3>
                </div>
                <div class="card-body pt-0 pb-5">
                  <div
                    class="d-flex flex-column align-items-center justify-content-center py-10"
                  >
                    <i class="ki-duotone ki-cube-2 fs-3x text-gray-500 mb-4">
                      <span class="path1"></span><span class="path2"></span
                      ><span class="path3"></span>
                    </i>
                    <span class="text-gray-800 fw-semibold fs-5">No data</span>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<script>
  $(document).ready(function () {
    // Initialization Data
    // รับค่าจาก Java requestScope
    /* var typeList = ${requestScope.type != null ? requestScope.type : '[]'};
		var statusList = ${requestScope.status != null ? requestScope.status : '[]'};

        try {
            if (rawType) typeList = JSON.parse(rawType);
            if (rawStatus) statusList = JSON.parse(rawStatus);
        } catch (e) { console.error("JSON Parse Error:", e); }
 */
    var rawType = '${requestScope.type != null ? requestScope.type : "[]"}';
    var rawStatus =
      '${requestScope.status != null ? requestScope.status : "[]"}';

    var typeList = [];
    var statusList = [];

    try {
      typeList = JSON.parse(rawType);
      statusList = JSON.parse(rawStatus);
    } catch (e) {
      console.error("JSON Parse Error:", e);
    }
    // Populate Dropdowns

    // TYPE Select
    var $typeSelect = $("#typeSelect");
    var typeOptions = "<option></option>";
    if (typeList.length > 0) {
      $.each(typeList, function (index, item) {
        var id = item.TypeID || item.typeID || item.type;
        var desc = item.description;
        typeOptions += '<option value="' + id + '">' + desc + "</option>";
      });
    }
    $typeSelect.html(typeOptions);

    // STATUS Select
    var $statusSelect = $("#statusSelect");
    var statusOptions = "<option></option>";
    if (statusList.length > 0) {
      $.each(statusList, function (index, item) {
        var id = item.statusId;
        var desc = item.description;
        statusOptions += '<option value="' + id + '">' + desc + "</option>";
      });
    }
    $statusSelect.html(statusOptions);

    // Init Select2
    $("#typeSelect, #statusSelect").select2({
      minimumResultsForSearch: Infinity,
    });

    // Init Components
    $("#kt_datepicker_1").flatpickr({
      dateFormat: "d-M-Y",
      altInput: true,
      altFormat: "j M Y",
    });

    // เช็ค Duplicate Item No
    $("#itemNoInput").on("blur", function () {
      var itemNoVal = $(this).val().trim();
      var $input = $(this);
      var $feedback = $("#itemNoFeedback");
      var $btnSave = $('button[type="submit"]');

      if (itemNoVal === "") return;

      $.ajax({
        url: "check_item_no",
        method: "POST",
        data: { itemNo: itemNoVal },
        dataType: "json",
        success: function (response) {
          if (response.message === "used") {
            $input.removeClass("border-success");
            $input.addClass("is-invalid");

            $feedback
              .text(
                "This item No. already exists in the system. (Used by: " +
                  response.name +
                  ")",
              )
              .show();
            $btnSave.prop("disabled", true);
          } else {
            $input.removeClass("is-invalid");
            $input.addClass("border-success");
            $feedback.hide();
            $btnSave.prop("disabled", false);
          }
        },
        error: function () {
          console.error("Error checking item no.");
        },
      });
    });
  });

  // Image Preview Logic
  document.addEventListener("DOMContentLoaded", function () {
    const fileInput = document.getElementById("itemImageInput");
    const previewImg = document.getElementById("itemImagePreview");
    const placeholder = document.getElementById("itemImagePlaceholder");
    const selectBtn = document.getElementById("itemImageSelectBtn");
    const errorMsg = document.getElementById("errorMsg");

    if (!fileInput || !previewImg || !selectBtn) return;

    // ปุ่มเลือกไฟล์
    selectBtn.addEventListener("click", function () {
      fileInput.click();
    });

    // เมื่อเลือกรูป
    fileInput.addEventListener("change", async function (e) {
      const file = e.target.files[0];

      if (!file) return;

      errorMsg.textContent = "";

      if (!file.type.startsWith("image/")) {
        errorMsg.textContent = "Please select an image file.";
        fileInput.value = "";
        return;
      }

      // Preview รูป
      const reader = new FileReader();

      reader.onload = function (ev) {
        previewImg.src = ev.target.result;
        previewImg.style.display = "block";

        if (placeholder) {
          placeholder.classList.add("d-none");
        }
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

  async function compressImage(
    file,
    maxWidth = 1280,
    maxHeight = 1280,
    quality = 0.8,
  ) {
    if (!file.type.match(/image\/(jpeg|jpg|png)/)) {
      return file;
    }

    return new Promise((resolve, reject) => {
      const reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = (event) => {
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

          const canvas = document.createElement("canvas");
          canvas.width = width;
          canvas.height = height;
          const ctx = canvas.getContext("2d");
          ctx.drawImage(img, 0, 0, width, height);

          canvas.toBlob(
            (blob) => {
              if (blob) {
                const newFileName = file.name.replace(/\.[^/.]+$/, ".jpg");
                const newFile = new File([blob], newFileName, {
                  type: "image/jpeg",
                  lastModified: Date.now(),
                });
                resolve(newFile);
              } else {
                resolve(file);
              }
            },
            "image/jpeg",
            quality,
          );
        };
        img.onerror = (error) => reject(error);
      };
      reader.onerror = (error) => reject(error);
    });
  }
</script>
