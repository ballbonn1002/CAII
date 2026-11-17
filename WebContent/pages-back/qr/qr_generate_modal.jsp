<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%--
  หน้าต่าง Generate QR Code ที่ใช้ร่วมกันหลายหน้า (Equipment, สินค้า, ที่เก็บ) - include ด้วย
      <jsp:include page="/pages-back/qr/qr_generate_modal.jsp" />
  แล้วทำปุ่มที่มี class "js-qr-generate" (type="button" กันไม่ให้ submit ฟอร์ม) พร้อม attribute
      data-qr-value      = ข้อมูลที่เข้ารหัสใน QR (ลิงก์หน้าผลสแกน เช่น https://โดเมน/qr?c=P12)
      data-qr-label      = ข้อความใต้ QR (แก้ได้ในหน้าต่าง ว่าง = ไม่แสดง)
      data-qr-configured = true/false ตั้งค่า qr.base.url แล้วหรือยัง (false = แสดงคำเตือนสีเหลือง)
  ใช้ event แบบ delegate จึงรองรับปุ่มที่สร้างทีหลังด้วย JS (เช่นแถวของตารางที่ render เอง)
  qrcode.js เก็บไว้ในโปรเจกต์ ไม่พึ่ง CDN / modal อยู่นอก <form> และ input ไม่มี name จึงไม่ถูกส่งไปกับฟอร์ม

--%>
<div class="modal fade" id="qrGenerateModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title fw-bold text-gray-900">Generate QR Code</h3>
                <button type="button" class="btn btn-icon btn-sm btn-active-light-primary" data-bs-dismiss="modal" aria-label="Close">
                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                </button>
            </div>
            <div class="modal-body">
                <div class="mb-5">
                    <label class="form-label fw-semibold text-gray-700" for="qrLabelInput">Label ใต้ QR Code</label>
                    <input type="text" id="qrLabelInput" class="form-control form-control-solid" maxlength="100" autocomplete="off" />
                </div>
                <div class="mb-5">
                    <label class="form-label fw-semibold text-gray-700" for="qrGenerateInput">ข้อมูลที่จะเข้ารหัสใน QR</label>
                    <input type="text" id="qrGenerateInput" class="form-control form-control-solid" maxlength="500" autocomplete="off" />
                    <%-- เตือนเมื่อยังไม่ตั้งค่า qr.base.url (ลิงก์ชี้ไปเครื่องที่เปิดอยู่ เช่น localhost) --%>
                    <div id="qrLinkNotConfigured" class="form-text text-warning d-none">ยังไม่ได้ตั้งค่าโดเมนของลิงก์ QR (qr.base.url) ลิงก์นี้ชี้ไปที่เครื่องที่เปิดอยู่ ใช้ทดสอบได้ แต่อย่าพิมพ์ป้ายจริง</div>
                </div>
                <div class="text-center">
                    <div id="qrGenerateCanvas" class="d-inline-block p-4 bg-white rounded border"></div>
                    <div id="qrLabelPreview" class="fw-semibold text-gray-800 text-center mt-3"></div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-light-primary" id="btnQrPrint">
                    <i class="ki-duotone ki-printer fs-3 me-1"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i>
                    Print
                </button>
                <button type="button" class="btn btn-primary" id="btnQrDownload">
                    <i class="ki-duotone ki-exit-down fs-3 me-1"><span class="path1"></span><span class="path2"></span></i>
                    Download
                </button>
            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/assets/plugins/custom/qrcode/qrcode.min.js"></script>
<script>
    /* qrcodejs วาดเป็น <canvas> ใน #qrGenerateCanvas (ไว้ preview สดๆ ตอนพิมพ์แก้ข้อความ)
       Print/Download ไม่ได้ใช้ canvas นั้นตรงๆ แต่ "ประกอบใหม่" ผ่าน buildPrintableQrCanvas() เพราะ
         1) ขอบขาวรอบโค้ด (quiet zone) บนหน้าจอเป็นแค่ CSS ไม่ได้อยู่ในพิกเซลของ canvas ต้องวาดเพิ่มเอง
            (มาตรฐาน QR ต้องมีขอบขาวอย่างน้อย 4 module ไม่งั้นสแกนเนอร์บางรุ่นอ่านไม่ออกตอนพิมพ์ติดขอบป้าย)
         2) ใส่ label กำกับใต้รูป เผื่อโค้ดลบเลือน ยังอ่านด้วยตาได้ (label ว่าง = ไม่เว้นที่ caption) */
    $(document).ready(function () {
        var qrGenerateInstance = null;

        function showQrError(msg) {
            if (window.Swal) { Swal.fire('Error', msg || 'เกิดข้อผิดพลาด', 'error'); }
            else { alert(msg || 'เกิดข้อผิดพลาด'); }
        }

        function renderQrPreview(text) {
            var $box = $('#qrGenerateCanvas');
            $box.empty();
            qrGenerateInstance = null;
            var value = $.trim(text);
            if (!value || typeof QRCode === 'undefined') {
                return;
            }
            qrGenerateInstance = new QRCode($box.get(0), {
                text: value,
                width: 220,
                height: 220,
                // H = กู้คืนได้ ~30% เผื่อป้ายเปื้อน/รอยขีดข่วน/แปะโค้ง
                correctLevel: QRCode.CorrectLevel.H
            });
        }

        // label ใต้ QR ในหน้าต่าง - ใช้ .text() เท่านั้น กัน HTML จากช่อง input หลุดเข้า DOM
        function renderQrLabelPreview() {
            $('#qrLabelPreview').text($.trim($('#qrLabelInput').val()));
        }

        // ประกอบ canvas สำหรับ Print/Download: เพิ่มขอบขาวจริงรอบโค้ด + label ใต้รูป (คืน null ถ้ายังไม่มี QR)
        function buildPrintableQrCanvas() {
            var $srcCanvas = $('#qrGenerateCanvas canvas');
            if ($srcCanvas.length === 0) {
                return null;
            }
            var srcCanvas = $srcCanvas.get(0);

            // moduleCount อ่านจาก internal ของ qrcodejs (fallback 25 เผื่อ library เปลี่ยน structure)
            var moduleCount = (qrGenerateInstance && qrGenerateInstance._oQRCode && qrGenerateInstance._oQRCode.moduleCount)
                ? qrGenerateInstance._oQRCode.moduleCount : 25;
            var cellSize = srcCanvas.width / moduleCount;
            var quietZone = Math.round(cellSize * 4);

            var captionText = $.trim($('#qrLabelInput').val());
            var captionHeight = captionText ? 36 : 0;

            var outCanvas = document.createElement('canvas');
            outCanvas.width = srcCanvas.width + quietZone * 2;
            outCanvas.height = srcCanvas.height + quietZone * 2 + captionHeight;

            var ctx = outCanvas.getContext('2d');
            ctx.fillStyle = '#ffffff';
            ctx.fillRect(0, 0, outCanvas.width, outCanvas.height);
            ctx.drawImage(srcCanvas, quietZone, quietZone);

            if (captionText) {
                ctx.fillStyle = '#000000';
                ctx.textAlign = 'center';
                ctx.textBaseline = 'middle';
                // ลดขนาดฟอนต์ลงเรื่อยๆ ถ้าข้อความยาวเกินความกว้างโค้ด (กันล้นตอนพิมพ์)
                var fontSize = 16;
                var maxTextWidth = outCanvas.width - quietZone;
                do {
                    ctx.font = fontSize + 'px Arial, sans-serif';
                    fontSize -= 1;
                } while (ctx.measureText(captionText).width > maxTextWidth && fontSize >= 9);
                ctx.fillText(captionText, outCanvas.width / 2, quietZone * 2 + srcCanvas.height + captionHeight / 2);
            }

            return outCanvas;
        }

        // เปิดทุกครั้งรีเซ็ตเป็นค่าตั้งต้นของปุ่มที่กด (ข้อมูล = ลิงก์หน้าผลสแกน, label = ชื่อรายการ)
        $(document).on('click', '.js-qr-generate', function () {
            var defaultValue = $(this).attr('data-qr-value');
            var defaultLabel = $(this).attr('data-qr-label');
            $('#qrLabelInput').val(defaultLabel != null ? String(defaultLabel) : '');
            $('#qrGenerateInput').val(defaultValue != null ? String(defaultValue) : '');
            $('#qrLinkNotConfigured').toggleClass('d-none', $(this).attr('data-qr-configured') === 'true');
            renderQrLabelPreview();
            $('#qrGenerateModal').modal('show');
        });

        // modal เปิดเสร็จ generate QR จากช่องข้อมูลทันที
        $('#qrGenerateModal').on('shown.bs.modal', function () {
            renderQrPreview($('#qrGenerateInput').val());
            renderQrLabelPreview();
            $('#qrGenerateInput').trigger('focus').trigger('select');
        });

        // แก้ข้อมูลที่เข้ารหัส -> render QR ใหม่ / แก้ label -> อัปเดตข้อความใต้ QR อย่างเดียว
        $('#qrGenerateInput').on('input', function () {
            renderQrPreview($(this).val());
        });
        $('#qrLabelInput').on('input', function () {
            renderQrLabelPreview();
        });

        $('#btnQrDownload').on('click', function () {
            var canvas = buildPrintableQrCanvas();
            if (!canvas) {
                showQrError('ยังไม่มี QR ให้ดาวน์โหลด กรุณากรอกข้อมูลก่อน');
                return;
            }
            // ตั้งชื่อไฟล์ตาม label (ว่างใช้ข้อมูลที่เข้ารหัส ว่างทั้งคู่ใช้ "qrcode") ตัดอักขระที่ตั้งชื่อไฟล์ไม่ได้ออก
            var rawName = $.trim($('#qrLabelInput').val());
            if (!rawName) {
                rawName = $.trim($('#qrGenerateInput').val());
            }
            rawName = rawName.replace(/[\\/:*?"<>|]+/g, '_');
            var link = document.createElement('a');
            link.download = (rawName ? 'qrcode_' + rawName : 'qrcode') + '.png';
            link.href = canvas.toDataURL('image/png');
            link.click();
        });

        $('#btnQrPrint').on('click', function () {
            var canvas = buildPrintableQrCanvas();
            if (!canvas) {
                showQrError('ยังไม่มี QR ให้พิมพ์ กรุณากรอกข้อมูลก่อน');
                return;
            }
            var dataUrl = canvas.toDataURL('image/png');
            var printWin = window.open('', '_blank');
            if (!printWin) {
                showQrError('เบราว์เซอร์บล็อกหน้าต่างพิมพ์ กรุณาอนุญาต popup แล้วลองใหม่');
                return;
            }
            // width อย่างเดียว (ไม่ fix height) ให้สัดส่วนรูปถูกต้องเสมอ แม้มี label ใต้ภาพ
            printWin.document.write('<img src="' + dataUrl + '" style="width:300px;" onload="window.print();window.close();" />');
            printWin.document.close();
        });
    });
</script>
