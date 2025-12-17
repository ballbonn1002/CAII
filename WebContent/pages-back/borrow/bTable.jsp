<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!--
  ไม่ต้อง include CSS / JS เพิ่ม เพราะหน้า admin_edit_userprofile.jsp
  โหลด Metronic 8 (plugins.bundle.js, style.bundle.css) อยู่แล้ว
-->

<div class="card mb-5">
    <!-- Header -->
    <div class="card-header">
        <h3 class="card-title fw-bold m-0">Borrow List</h3>
        <div class="card-toolbar">
            <a href="eBorrow" class="btn btn-primary btn-md fw-semibold">
                <span class="me-1">+</span>Add New
            </a>
        </div>
    </div>

    <!-- Body -->
    <div class="card-body pt-4 pb-4">
        <div class="table-responsive">
            <table class="table table-striped align-middle table-row-dashed fs-6 gy-3 gs-7">
                <thead>
                    <tr class="text-gray-500 fw-semibold fs-7">
                        <th class="min-w-150px">Date Create</th>
                        <th class="min-w-110px">Item No</th>
                        <th class="min-w-200px">Equipment</th>
                        <th class="min-w-140px">Location</th>
                        <th class="min-w-120px">Status</th>
                        <th class="min-w-90px text-end">Action</th>
                    </tr>
                </thead>
                <tbody id="borrow-list-body">
                    <!-- rows will be rendered by JavaScript -->
                </tbody>
            </table>
        </div>
    </div>
</div>

<script type="text/javascript">
    (function($) {
        $(function() {

            // ---------- ดึงข้อมูลจาก Server ----------
            // ที่ UserAction.openEdit ใส่มาให้แบบ Gson().toJson(...)
            // ถ้า null/ไม่มี → ใช้ [] แทน
            var equipments = ${empty equipments ? '[]' : equipments};
            var borrows    = ${empty borrows    ? '[]' : borrows};

            console.log("equipments from bTable:", equipments);
            console.log("borrows from bTable:", borrows);

            var $tbody = $("#borrow-list-body");

            if (!borrows || borrows.length === 0) {
                $tbody.append(
                    '<tr>' +
                        '<td colspan="6" class="text-center text-muted py-10">' +
                            'No borrow record found.' +
                        '</td>' +
                    '</tr>'
                );
                return;
            }

            // ---------- สร้าง map หา equipment ตาม equipmentId ----------
            var equipmentMap = {};
            if (equipments && equipments.length) {
                $.each(equipments, function(_, e) {
                    if (e && e.equipmentId != null) {
                        equipmentMap[e.equipmentId] = e;
                    }
                });
            }

            // ---------- helper แปลงสถานะเป็น badge ของ Metronic ----------
            function renderStatus(statusCode) {
                var label = statusCode || '-';
                var badgeClass = "badge badge-light-secondary";

                if (statusCode === "W") {
                    label = "Waiting";
                    badgeClass = "badge badge-info";
                } else if (statusCode === "B") {
                    label = "Borrowing";
                    badgeClass = "badge badge-warning";
                } else if (statusCode === "R") {
                    label = "Returned";
                    badgeClass = "badge badge-success";
                } else if (statusCode === "C") {
                    label = "Cancel";
                    badgeClass = "badge badge-light-danger";
                }

                return '<span class="' + badgeClass + ' fw-semibold px-4 py-2">' +
                            label +
                       '</span>';
            }

            // ---------- helper แปลงวันที่/เวลา ----------
            function formatDateTime(raw) {
                var result = { date: "-", time: "-" };

                if (!raw) {
                    return result;
                }

                var d = new Date(raw);
                if (isNaN(d.getTime())) {
                    return result;
                }

                result.date = d.toLocaleDateString("en-GB", {
                    day: "numeric",
                    month: "short",
                    year: "numeric"
                });

                result.time = d.toLocaleTimeString("en-GB", {
                    hour: "2-digit",
                    minute: "2-digit",
                    second: "2-digit"
                });

                return result;
            }

            // ---------- วาดแต่ละแถว ----------
            $.each(borrows, function(_, b) {
                var eq = equipmentMap[b.equipmentId] || {};

                // ใช้ timeCreate ถ้ามี ถ้าไม่มี ใช้ dateStart แทน
                var rawTime = b.timeCreate || b.dateStart;
                var dt = formatDateTime(rawTime);

                var itemNo   = eq.itemNo || "-";
                var eqName   = eq.name   || "-";
                var location = b.location || "-";

                var statusHtml = renderStatus(b.status);

                // ปุ่ม Action (เน้นปุ่มแก้ไขตัวเดียวเหมือนใน mockup)
                var actionHtml =
                    '<a href="eBorrowEdit?id=' + b.borrowId + '" ' +
                       'class="btn btn-icon btn-light-primary btn-sm" ' +
                       'title="Edit">' +
                        '<i class="ki-duotone ki-pencil"><span class="path1"></span><span class="path2"></span></i>' +
                    '</a>';

                // สร้าง <tr>
                var rowHtml =
                    '<tr>' +
                        '<td>' +
                            '<div class="d-flex flex-column">' +
                                '<span class="fw-semibold text-gray-900">' + dt.date + '</span>' +
                                '<span class="fs-7 text-muted mt-1">' + dt.time + '</span>' +
                            '</div>' +
                        '</td>' +
                        '<td class="fw-semibold text-gray-900">' + itemNo + '</td>' +
                        '<td>' + eqName + '</td>' +
                        '<td>' + location + '</td>' +
                        '<td>' + statusHtml + '</td>' +
                        '<td class="text-end">' + actionHtml + '</td>' +
                    '</tr>';

                $tbody.append(rowHtml);
            });

        });
    })(jQuery);
</script>
