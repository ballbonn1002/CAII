<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<fmt:setLocale value="en_US" />

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />

    <link
      href="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.css"
      rel="stylesheet"
    />
    <link
      href="${pageContext.request.contextPath}/assets/css/style.bundle.css"
      rel="stylesheet"
    />

    <script src="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/scripts.bundle.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/custom/utilities/attachFile/attcahfile.js"></script>

    <style>
      /* ======= Signature Box ======= */
      .sig-box {
        width: 100%;
        height: 200px;
        border-radius: 10px;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        position: relative;
        overflow: hidden;
      }

      .sig-box.locked {
        border: 2px solid #e4e6ef;
        background: #f9f9f9;
        cursor: default;
      }

      .sig-box.uploadable {
        border: 2px dashed #c9d0e0;
        background: #fafafa;
        cursor: pointer;
      }

      .sig-box.uploadable:hover {
        border-color: #009ef7;
        background: #f0faff;
      }

      .sig-lock-badge {
        position: absolute;
        top: 6px;
        right: 8px;
        font-size: 0.7rem;
        color: #a1a5b7;
        display: flex;
        align-items: center;
        gap: 3px;
      }
    </style>
  </head>
  <body class="app-default">
    <input
      type="hidden"
      id="hasSignature"
      value="${not empty imgPathSignature}"
    />
    <div class="app-main flex-column flex-row-fluid">
      <div class="d-flex flex-column flex-column-fluid">
        <div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
          <div
            id="kt_app_toolbar_container"
            class="app-container container-fluid d-flex flex-stack"
          >
            <div
              class="page-title d-flex flex-column justify-content-center flex-wrap me-3"
            >
              <h1
                class="page-heading d-flex text-gray-700 fw-semibold flex-column justify-content-center my-0"
              >
                Equipment Request
              </h1>
              <ul
                class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1"
              >
                <li class="breadcrumb-item text-muted">
                  <a class="text-muted text-hover-primary">Home</a>
                </li>
                <li class="breadcrumb-item">
                  <span class="bullet bg-gray-500 w-5px h-2px"></span>
                </li>
                <li class="breadcrumb-item text-muted">
                  <a class="text-muted text-hover-primary">Product</a>
                </li>
              </ul>
            </div>

            <div class="d-flex align-items-center gap-2">
              <span class="badge badge-lg bg-secondary fw-semibold fs-7 p-4">
                <c:out
                  value="${empty draftStatus ? 'Draft' : draftStatus.statusName}"
                />
              </span>
            </div>
          </div>
        </div>

        <div id="kt_app_content" class="app-content flex-column-fluid">
          <div
            id="kt_app_content_container"
            class="app-container container-fluid"
          >
            <!-- From Equipment Request -->
            <div class="card mb-10">
              <div
                class="card-header border-bottom px-9 pt-7 d-flex align-items-center"
              >
                <div class="card-title">
                  <h3 class="fw-semibold text-gray-900">
                    From Equipment Request
                  </h3>
                </div>
              </div>
              <div class="card-body px-9 py-9">
                <div class="row g-8">
                  <div class="col-12">
                    <label class="required fw-medium text-gray-800 mb-3"
                      >Employee Name</label
                    >
                    <input
                      type="text"
                      class="form-control form-control-solid border border-gray-300"
                      readonly
                      value="${fn:escapeXml(loginUser.employeeId)} - ${fn:escapeXml(loginUser.nameEN)}"
                    />
                  </div>

                  <div class="col-lg-4 col-md-4 col-12">
                    <div
                      class="d-flex justify-content-between align-items-center mb-2"
                    >
                      <label class="required fw-medium text-gray-800"
                        >Item</label
                      >
                      <span
                        id="itemTypeBox"
                        class="d-none align-items-center gap-2 fw-medium text-gray-800"
                      >
                        <div id="itemTypeIcon" class="symbol symbol-30px"></div>
                        <span id="itemTypeLabel"></span>
                      </span>
                    </div>
                    <select
                      id="mr_item"
                      class="form-select"
                      data-control="select2"
                      data-placeholder="Select item"
                    >
                      <option value=""></option>
                      <c:forEach var="it" items="${mainItemList}">
                        <option
                          value="${it.product_id}"
                          data-type="${it.product_type}"
                        >
                          <c:out value="${it.product_name}" />
                        </option>
                      </c:forEach>
                    </select>
                  </div>

                  <div class="col-lg-4 col-md-4 col-12">
                    <label
                      class="required fw-medium text-gray-800 mb-3"
                      id="subItemLabel"
                      >Sub item</label
                    >
                    <select
                      id="mr_sub_item"
                      class="form-select border border-gray-300"
                      data-control="select2"
                      data-placeholder="No data"
                      disabled
                    >
                      <option value="">No data</option>
                    </select>
                  </div>

                  <div class="col-lg-4 col-md-4 col-12">
                    <label class="required fw-medium text-gray-800 mb-3"
                      >Quantity</label
                    >
                    <div class="input-group">
                      <input
                        type="number"
                        id="mr_amount"
                        class="form-control"
                        min="1"
                        step="1"
                        inputmode="numeric"
                        pattern="[0-9]*"
                        value="1"
                      />
                      <span class="input-group-text px-8" id="mr_unit_label"
                        >-</span
                      >
                    </div>
                  </div>

                  <div class="col-lg-6 col-12">
                    <label class="fw-medium text-gray-800 mb-3"
                      >Description</label
                    >
                    <textarea
                      class="form-control"
                      id="mr_description"
                      rows="3"
                    ></textarea>
                  </div>

                  <div class="col-lg-6 col-12">
                    <label class="fw-medium text-gray-800 mb-3"
                      >URL Reference</label
                    >
                    <textarea
                      class="form-control"
                      id="mr_url_ref"
                      rows="3"
                    ></textarea>
                  </div>

                  <div class="col-12">
                    <label
                      for="myFile"
                      class="btn btn-lg btn-primary fw-medium px-6"
                    >
                      Attach Files
                      <input
                        type="file"
                        id="myFile"
                        name="files"
                        multiple
                        style="display: none"
                        accept="image/*,application/pdf,application/zip,application/x-zip-compressed,application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document"
                      />
                    </label>
                    <div
                      id="attachFileList"
                      class="d-flex flex-wrap align-items-center gap-6 mt-4"
                    ></div>
                    <div id="errorMsgAF" class="text-danger fs-8 mt-1"></div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Signature -->
            <div class="card mb-10">
              <div
                class="card-header border-0 px-9 pt-7 d-flex align-items-center justify-content-between"
              >
                <div class="card-title">
                  <h3 class="fw-semibold text-gray-900">Signature</h3>
                </div>
              </div>
              <form
                id="signatureForm"
                method="post"
                action="update_signature"
                enctype="multipart/form-data"
              >
                <div class="card-body filter-card px-10 py-9 rounded-3 row g-5">
                  <div class="col-md-6 col-12">
                    <div class="d-flex flex-column align-items-center gap-2">
                      <c:choose>
                        <c:when test="${not empty imgPathSignature}">
                          <div class="sig-box locked">
                            <img
                              src="${pageContext.request.contextPath}${imgPathSignature}"
                              style="
                                max-height: 150px;
                                max-width: 360px;
                                object-fit: contain;
                              "
                            />
                            <div class="sig-lock-badge">
                              <i class="ki-duotone ki-lock fs-7">
                                <span class="path1"></span
                                ><span class="path2"></span>
                              </i>
                              Signature on file
                            </div>
                          </div>
                        </c:when>
                        <c:otherwise>
                          <div
                            class="sig-box uploadable"
                            id="uploadSignatureBox"
                          >
                            <img
                              id="signaturePreview"
                              style="
                                max-height: 150px;
                                max-width: 360px;
                                object-fit: contain;
                                display: none;
                              "
                            />
                            <div
                              id="uploadPlaceholder"
                              class="d-flex flex-column align-items-center"
                            >
                              <i
                                class="ki-duotone ki-cloud-add fs-2x text-muted"
                              >
                                <span class="path1"></span
                                ><span class="path2"></span>
                              </i>
                              <span class="text-muted fs-8 mt-2"
                                >Click to upload Signature</span
                              >
                            </div>
                          </div>
                          <input
                            type="file"
                            id="signatureFileInput"
                            name="fileUpload"
                            accept="image/png,image/jpeg"
                            class="d-none"
                          />
                          <span class="text-muted fs-8"
                            >Allowed: png, jpg, jpeg</span
                          >
                        </c:otherwise>
                      </c:choose>
                    </div>
                  </div>

                  <div class="col-md-6 col-12">
                    <div
                      class="border border-gray-300 rounded-3 h-100 d-flex flex-column align-items-center justify-content-center text-center py-8"
                      id="receiverCard1"
                    >
                      <div
                        class="receiver-box d-flex flex-fill flex-column align-items-center justify-content-center gap-2"
                        id="receiverBox1"
                      >
                        <span class="text-muted fs-7" id="receiverLabel1"
                          >คลิก เพื่อยืนยันผู้รับเงิน</span
                        >
                        <div
                          id="receiverPreview1"
                          style="
                            min-height: 44px;
                            display: flex;
                            flex-direction: column;
                            align-items: center;
                          "
                        ></div>
                        <button
                          type="button"
                          class="btn btn-primary btn-sm px-5"
                          id="receiverBtn1"
                          onclick="confirmReceiver(1)"
                        >
                          ลงชื่อ ผู้ขอเบิก
                        </button>
                      </div>
                    </div>
                  </div>
                </div>
              </form>
            </div>

            <div class="d-flex justify-content-between mb-10">
              <button
                type="button"
                id="backFormBtn"
                onclick="goBackToList()"
                class="btn btn-lg btn-light fw-medium text-light-inverse px-6 py-4 me-4 border"
              >
                Back
              </button>
              <div class="d-flex">
                <button
                  type="button"
                  id="saveDraftBtn"
                  onclick="saveMr('1')"
                  class="btn btn-lg btn-cyan text-white fw-medium px-6 py-4 me-4"
                >
                  Save Draft
                </button>
                <button
                  type="button"
                  id="submitMrBtn"
                  onclick="submitMr()"
                  class="btn btn-success text-white fw-medium px-6 py-4"
                >
                  Submit MR
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </body>
  <script type="text/javascript">
    const ctx = "${pageContext.request.contextPath}";
    const currentUserDisplay =
      "${fn:escapeXml(loginUser.employeeId)} - ${fn:escapeXml(loginUser.nameEN)}";
    const ITEM_TYPE_LABELS = {
      1: "Equipment",
      2: "Consumables",
      3: "Accessory",
      4: "Office supplies",
    };

    var requesterSign = null;
    var confirmed1 = false;
    var hasSubItems = false;

    // --- Item / Sub item / Unit ---
    const ITEM_TYPE_MAP = {
      1: {
        label: "Equipment",
        color: "text-primary",
        icon: '<i class="ki-duotone ki-monitor-mobile fs-2 text-primary"><span class="path1"></span><span class="path2"></span></i>',
      },
      2: {
        label: "Consumables",
        color: "text-orange",
        icon: '<i class="ki-duotone ki-lots-shopping fs-2 text-orange"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span><span class="path7"></span><span class="path8"></span></i>',
      },
      3: {
        label: "Accessory",
        color: "text-teal",
        icon: '<i class="ki-duotone ki-medal-star fs-2 text-teal"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i>',
      },
      4: {
        label: "Office supplies",
        color: "text-success",
        icon: '<i class="ki-duotone ki-parcel fs-2 text-success"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i>',
      },
    };

    function updateItemTypeBox(type) {
      var info = ITEM_TYPE_MAP[String(type)];
      if (info) {
        $("#itemTypeIcon").html(info.icon);
        $("#itemTypeLabel").text(info.label);
        $("#itemTypeBox").removeClass("d-none").addClass("d-flex");
      } else {
        $("#itemTypeBox").removeClass("d-flex").addClass("d-none");
      }
    }

    $("#mr_item").on("change", function () {
      var productId = $(this).val();
      var type = $(this).find("option:selected").data("type");

      updateItemTypeBox(type);

      loadSubItems(productId);
      loadUnit();
    });

    $("#mr_sub_item").on("change", function () {
      loadUnit();
    });

    // Quantity: บังคับจำนวนเต็มบวก
    $("#mr_amount").on("keydown", function (e) {
      if (
        e.key === "." ||
        e.key === "," ||
        e.key === "e" ||
        e.key === "E" ||
        e.key === "-" ||
        e.key === "+"
      ) {
        e.preventDefault();
      }
    });

    // กัน paste ทศนิยม / spinner ที่ให้ค่าทศนิยม
    $("#mr_amount").on("input", function () {
      var val = $(this).val();
      if (val === "") return;
      var num = parseFloat(val);
      if (!isNaN(num)) {
        var intVal = Math.floor(Math.abs(num));
        if (String(intVal) !== val) {
          $(this).val(intVal);
        }
      }
    });

    // --- กันข้อมูลฟอร์มหายตอน refresh (sessionStorage, เก็บเฉพาะ text field ) ---
    const MR_DRAFT_KEY = "mr_draft_form";
    var pendingSubItemId = null;
    var saveFormTimer = null;

    function saveFormToSession() {
      try {
        var data = {
          productId: $("#mr_item").val() || "",
          // ระหว่างรอ sub item โหลดหลัง restore ให้คงค่าที่รออยู่ไว้ ไม่ให้ค่าว่างเขียนทับ
          subProductId:
            pendingSubItemId !== null
              ? pendingSubItemId
              : $("#mr_sub_item").val() || "",
          amount: $("#mr_amount").val() || "",
          description: $("#mr_description").val() || "",
          urlRef: $("#mr_url_ref").val() || "",
          sign: requesterSign,
        };
        sessionStorage.setItem(MR_DRAFT_KEY, JSON.stringify(data));
      } catch (e) {
        console.error("save MR draft failed", e);
      }
    }

    function scheduleSaveForm() {
      clearTimeout(saveFormTimer);
      saveFormTimer = setTimeout(saveFormToSession, 500);
    }

    function clearFormSession() {
      clearTimeout(saveFormTimer);
      try {
        sessionStorage.removeItem(MR_DRAFT_KEY);
      } catch (e) {}
    }

    function restoreFormFromSession() {
      var data = null;
      try {
        data = JSON.parse(sessionStorage.getItem(MR_DRAFT_KEY) || "null");
      } catch (e) {
        data = null;
      }
      if (!data) return false;

      $("#mr_amount").val(data.amount || "1");
      $("#mr_description").val(data.description || "");
      $("#mr_url_ref").val(data.urlRef || "");

      if (data.sign) {
        confirmReceiver(1);
        requesterSign = data.sign; // คืนเวลาเดิม ไม่ใช้เวลาปัจจุบัน
        $("#receiverPreview1 span")
          .last()
          .text(data.sign.displayAt || "");
      }

      var $item = $("#mr_item");
      if (
        data.productId &&
        $item.find('option[value="' + data.productId + '"]').length
      ) {
        pendingSubItemId = data.subProductId || null;
        $item.val(data.productId).trigger("change");
        return true;
      }
      return false; // item เดิมไม่มีในลิสต์แล้ว ใช้ auto-select ตัวแรก
    }

    function goBackToList() {
      clearFormSession();
      location.href = "equipment_request_mr_list";
    }

    $("#mr_item, #mr_sub_item").on("change", scheduleSaveForm);
    $("#mr_amount, #mr_description, #mr_url_ref").on("input", scheduleSaveForm);

    // หน้า create: restore จาก sessionStorage ก่อน ถ้าไม่มีค่อย auto-select Item ตัวแรก
    document.addEventListener("DOMContentLoaded", function () {
      if (restoreFormFromSession()) return;
      var $item = $("#mr_item");
      if ($item.val()) return;
      var firstVal = $item
        .find("option")
        .filter(function () {
          return this.value !== "";
        })
        .first()
        .val();
      if (firstVal) {
        $item.val(firstVal).trigger("change");
      }
    });

    function refreshSubItemSelect2(placeholderText) {
      var $sub = $("#mr_sub_item");
      if ($sub.hasClass("select2-hidden-accessible")) {
        $sub.select2("destroy");
      }
      $sub.select2({
        placeholder: placeholderText,
        dropdownParent: $sub.closest(".col-lg-4"),
      });
    }

    function loadSubItems(productId) {
      var $sub = $("#mr_sub_item");
      $sub
        .empty()
        .append('<option value="">No data</option>')
        .prop("disabled", true)
        .addClass("form-select-solid");
      refreshSubItemSelect2("No data"); //ตอนยังไม่มีข้อมูล
      hasSubItems = false;
      if (!productId) return;

      $.ajax({
        url: ctx + "/get_mr_sub_item",
        type: "POST",
        dataType: "json",
        data: { productId: productId },
        success: function (resp) {
          var list = (resp.data && resp.data.subItemList) || [];
          var restoreId = pendingSubItemId;
          pendingSubItemId = null;
          if (list.length === 0) return;

          hasSubItems = true;
          $sub.empty().append('<option value="">No data</option>');
          list.forEach(function (item) {
            $sub.append($("<option>").val(item.id).text(item.name));
          });
          $sub.prop("disabled", false).removeClass("form-select-solid");

          var hasRestore =
            restoreId &&
            list.some(function (it) {
              return String(it.id) === String(restoreId);
            });
          $sub.val(hasRestore ? restoreId : list[0].id);
          refreshSubItemSelect2("No data"); // ตอนมีข้อมูลให้เลือก
          loadUnit();
        },
        error: function () {
          pendingSubItemId = null;
          Swal.fire("Error", "ไม่สามารถโหลด Sub item ได้", "error");
        },
      });
    }

    // ใช้ product_id ตัวที่เลือกล่างสุด (sub item ถ้ามี) ไปหาหน่วยเล็กสุด
    function loadUnit() {
      var productId = $("#mr_item").val();
      var subProductId = $("#mr_sub_item").val();
      $("#mr_unit_label").text("-");
      if (!productId) return;

      $.ajax({
        url: ctx + "/get_mr_unit",
        type: "POST",
        dataType: "json",
        data: { productId: productId, subProductId: subProductId || "" },
        success: function (resp) {
          var unitName = resp.data && resp.data.unitName;
          $("#mr_unit_label").text(unitName || "-");
        },
      });
    }

    // --- Multi-file Attach ---
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
            canvas.getContext("2d").drawImage(img, 0, 0, width, height);
            canvas.toBlob(
              (blob) => {
                if (blob) {
                  const newFileName = file.name.replace(/\.[^/.]+$/, ".jpg");
                  resolve(
                    new File([blob], newFileName, {
                      type: "image/jpeg",
                      lastModified: Date.now(),
                    }),
                  );
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

    var selectedFiles = [];

    function getFileIconPath(fileName) {
      var ext = fileName.split(".").pop().toLowerCase();
      switch (ext) {
        case "pdf":
          return ctx + "/assets/media/svg/files/pdf.svg";
        case "doc":
        case "docx":
          return ctx + "/assets/media/svg/files/doc.svg";
        case "png":
        case "jpg":
        case "jpeg":
        case "gif":
        case "webp":
          return ctx + "/assets/media/svg/files/blank-image.svg";
        default:
          return ctx + "/assets/media/svg/files/folder-document.svg";
      }
    }

    async function processFiles(fileListInput) {
      var maxSize = 5 * 1024 * 1024;
      var oversizedFiles = [];
      var errorMsgAF = document.getElementById("errorMsgAF");

      for (let i = 0; i < fileListInput.length; i++) {
        const file = fileListInput[i];
        const existing = selectedFiles.find(
          (f) => f.name === file.name && f.size === file.size,
        );
        if (existing) continue;

        if (file.type.match(/image\/(jpeg|jpg|png)/)) {
          selectedFiles.push(await compressImage(file));
        } else if (file.size > maxSize) {
          oversizedFiles.push(file.name);
        } else {
          selectedFiles.push(file);
        }
      }
      if (errorMsgAF) {
        errorMsgAF.innerHTML =
          oversizedFiles.length > 0
            ? "Files exceed 5MB: <strong>" +
              oversizedFiles.join(", ") +
              "</strong>"
            : "";
      }
      renderNewFileList();
      updateInputFiles();
    }

    function renderNewFileList() {
      var fileListDiv = document.getElementById("attachFileList");
      if (!fileListDiv) return;
      fileListDiv.innerHTML = "";

      selectedFiles.forEach(function (file) {
        const fileName = file.name;
        const lastDotIndex = fileName.lastIndexOf(".");
        const nameOnly =
          lastDotIndex > -1 ? fileName.substring(0, lastDotIndex) : fileName;
        const fileExt =
          lastDotIndex > -1 ? fileName.substring(lastDotIndex) : "";

        const item = document.createElement("div");
        item.className = "d-flex align-items-center";

        const icon = document.createElement("img");
        icon.src = getFileIconPath(fileName);
        icon.className = "w-25px h-25px me-3";
        icon.alt = "icon";

        const name = document.createElement("span");
        name.className = "fs-6 fw-medium text-gray-800 text-truncate";
        name.style.maxWidth = "220px";
        name.title = fileName;
        name.textContent = nameOnly + " " + fileExt;

        const del = document.createElement("span");
        del.className = "badge badge-light-danger bg-hover cursor-pointer ms-3";
        del.innerHTML =
          '<i class="ki-duotone ki-trash text-danger fs-2">' +
          '<span class="path1"></span><span class="path2"></span>' +
          '<span class="path3"></span><span class="path4"></span><span class="path5"></span></i>';
        del.addEventListener("click", function () {
          selectedFiles = selectedFiles.filter((f) => f.name !== fileName);
          renderNewFileList();
          updateInputFiles();
        });

        item.appendChild(icon);
        item.appendChild(name);
        item.appendChild(del);
        fileListDiv.appendChild(item);
      });
    }

    function updateInputFiles() {
      var inputFile = document.getElementById("myFile");
      if (!inputFile) return;
      var dataTransfer = new DataTransfer();
      selectedFiles.forEach((file) => dataTransfer.items.add(file));
      inputFile.files = dataTransfer.files;
    }

    (function initAttach() {
      var input = document.getElementById("myFile");
      if (input)
        input.addEventListener("change", function (event) {
          processFiles(event.target.files);
        });
    })();

    // --- Signature Upload ---
    (function initSignatureUpload() {
      const uploadBox = document.getElementById("uploadSignatureBox");
      const fileInput = document.getElementById("signatureFileInput");
      const previewImg = document.getElementById("signaturePreview");
      const placeholder = document.getElementById("uploadPlaceholder");
      const signatureForm = document.getElementById("signatureForm");

      if (!uploadBox || !fileInput) return;

      uploadBox.addEventListener("click", function () {
        fileInput.click();
      });

      fileInput.addEventListener("change", async function () {
        const file = this.files[0];
        if (!file) return;

        if (!file.type.match(/image\/(jpeg|jpg|png)/)) {
          Swal.fire(
            "Invalid file",
            "กรุณาเลือกไฟล์รูปภาพ (jpg, jpeg, png)",
            "error",
          );
          fileInput.value = "";
          return;
        }
        if (file.size > 5 * 1024 * 1024) {
          Swal.fire("File too large", "ขนาดไฟล์ต้องไม่เกิน 5MB", "error");
          fileInput.value = "";
          return;
        }

        let finalFile;
        try {
          finalFile = await processAndRemoveWhiteBg(file);
        } catch (e) {
          finalFile = file;
        }

        const dt = new DataTransfer();
        dt.items.add(finalFile);
        fileInput.files = dt.files;

        const reader = new FileReader();
        reader.onload = function (e) {
          previewImg.src = e.target.result;
          previewImg.style.display = "block";
          if (placeholder) placeholder.style.display = "none";
        };
        reader.readAsDataURL(finalFile);

        fetch(ctx + "/update_signature", {
          method: "POST",
          body: new FormData(signatureForm),
        })
          .then((res) => {
            if (!res.ok) throw new Error("Upload failed");
            return res.text();
          })
          .then(() => {
            Swal.fire({
              title: "Save Success",
              text: "Signature has been successfully recorded.",
              icon: "success",
              timer: 1200,
              showConfirmButton: false,
            }).then(() => {
              saveFormToSession();
              location.reload();
            });
          })
          .catch((err) => {
            console.error(err);
            previewImg.style.display = "none";
            if (placeholder) placeholder.style.display = "flex";
            fileInput.value = "";
          });
      });
    })();

    // --- ลงชื่อ ผู้ขอเบิก ---
    function confirmReceiver(slot) {
      const now = new Date();
      const pad = (n) => String(n).padStart(2, "0");
      const months = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];

      const timestamp = now.getFullYear() + "-" + pad(now.getMonth() + 1) + "-" + pad(now.getDate()) +
        " " + pad(now.getHours()) + ":" + pad(now.getMinutes()) + ":" + pad(now.getSeconds());
      const displayTimestamp = now.getDate() + " " +months[now.getMonth()] + " " + now.getFullYear() + ", " +
        pad(now.getHours()) + ":" + pad(now.getMinutes());

      requesterSign = { userName: currentUserDisplay, requestAt: timestamp, displayAt: displayTimestamp};

      const labelEl = document.getElementById("receiverLabel" + slot);
      if (labelEl) labelEl.style.display = "none";

      const preview = document.getElementById("receiverPreview" + slot);
      preview.innerHTML = "";
      const nameEl = document.createElement("span");
      nameEl.className = "fw-semibold text-dark fs-7";
      nameEl.textContent = requesterSign.userName;
      const timeEl = document.createElement("span");
      timeEl.className = "text-muted fs-8 mt-1";
      timeEl.textContent = displayTimestamp;
      preview.appendChild(nameEl);
      preview.appendChild(timeEl);

      const btn = document.getElementById("receiverBtn" + slot);
      btn.textContent = "✓ ยืนยันแล้ว";
      btn.className = "btn btn-success btn-sm px-5";
      btn.disabled = true;

      const card = document.getElementById("receiverCard" + slot);
      if (card) {
        card.classList.remove("border-gray-300");
        card.classList.add("border-success", "bg-light-success");
      }

      if (slot === 1) {
        confirmed1 = true;
        scheduleSaveForm();
      }
    }

    // --- Save / Submit ---
    function validateMrForm(isSubmit) {
      let errors = [];
      if (!$("#mr_item").val()) errors.push("Item");
      if (hasSubItems && !$("#mr_sub_item").val()) errors.push("Sub item");
      const qty = Number($("#mr_amount").val());
      if (!qty || qty <= 0 || !Number.isInteger(qty)) errors.push("Quantity");

      if (isSubmit) {
        if ($("#hasSignature").val() !== "true")
          errors.push("ลายเซ็น (Signature)");
        if (!confirmed1) errors.push("ลงชื่อ ผู้ขอเบิก");
      }
      return errors;
    }

    function submitMr() {
      const errors = validateMrForm(true);
      if (errors.length > 0) {
        Swal.fire({
          title: "Please complete the form!",
          html:
            "Please fill in the following fields:<br><strong>" +
            errors.join(", ") +
            "</strong>",
          icon: "error",
          confirmButtonText: "OK",
        });
        return;
      }

      Swal.fire({
        title: "Are you sure?!",
        text: "Do you want to submit this request?",
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "Submit",
        cancelButtonText: "Close",
        buttonsStyling: false,
        customClass: {
          confirmButton: "btn btn-success",
          cancelButton: "btn btn-secondary",
        },
      }).then((result) => {
        if (result.isConfirmed) saveMr("2");
      });
    }

    function saveMr(status) {
      if (status === "1") {
        const errors = validateMrForm(false);
        if (errors.length > 0) {
          Swal.fire({
            title: "Please complete the form!",
            html:
              "Please fill in the following fields:<br><strong>" +
              errors.join(", ") +
              "</strong>",
            icon: "error",
            confirmButtonText: "OK",
          });
          return;
        }
      }

      const payload = {
        productId: $("#mr_item").val() || "",
        subProductId: $("#mr_sub_item").val() || "",
        amount: $("#mr_amount").val() || "",
        description: $("#mr_description").val().trim(),
        urlRef: $("#mr_url_ref").val().trim(),
        status: status,
        signDate: requesterSign ? requesterSign.requestAt : "",
      };

      const fd = new FormData();
      Object.keys(payload).forEach(function (k) {
        fd.append(k, payload[k]);
      });
      selectedFiles.forEach(function (file) {
        fd.append("files", file, file.name);
      });

      $("#saveDraftBtn, #submitMrBtn").prop("disabled", true);

      $.ajax({
        url: ctx + "/save_mr",
        type: "POST",
        dataType: "json",
        data: fd,
        processData: false,
        contentType: false,
        success: function (resp) {
          if (resp.data && resp.data.mrId) {
            clearFormSession();
            Swal.fire({
              title: "Success!",
              text:
                (status === "2"
                  ? "MR submitted successfully! "
                  : "MR saved draft successfully! ") + resp.data.mrId,
              icon: "success",
            }).then(() => {
              window.location.href = ctx + "/equipment_request_mr_list";
            });
          } else {
            Swal.fire("Error", "ไม่สามารถบันทึก MR ได้", "error");
          }
        },
        error: function () {
          Swal.fire("Error", "เกิดข้อผิดพลาดในการบันทึก", "error");
        },
        complete: function () {
          $("#saveDraftBtn, #submitMrBtn").prop("disabled", false);
        },
      });
    }
  </script>
</html>
