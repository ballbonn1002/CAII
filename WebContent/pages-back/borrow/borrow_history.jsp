<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<fmt:setLocale value="en_US" />

<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />

<link
	href="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.css"
	rel="stylesheet" type="text/css" />
<script
	src="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.js"></script>

<link
	href="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.css"
	rel="stylesheet" type="text/css" />
<script
	src="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.js"></script>

<style>
/* Light Mode */
[data-bs-theme="light"] #kt_table.table.table-striped>tbody>tr:nth-of-type(odd)>* {
	background-color: #FBFBFB !important;
	box-shadow: none !important;
}

[data-bs-theme="light"] #kt_table.table-hover tbody tr:hover>*,
[data-bs-theme="light"] #kt_table.table-hover tbody tr:hover>td,
[data-bs-theme="light"] #kt_table.table-hover tbody tr:hover>th,
[data-bs-theme="light"] #kt_table.table.table-hover>tbody>tr:hover>*,
[data-bs-theme="light"] #kt_table.dataTable>tbody>tr:hover>* {
	background-color: #F9F9F9 !important;
	box-shadow: none !important;
	transition: background-color .15s ease-in-out;
}

/* Dark Mode */
[data-bs-theme="dark"] #kt_table.table.table-striped>tbody>tr:nth-of-type(odd)>* {
	background-color: #191B20 !important;
	box-shadow: none !important;
}

[data-bs-theme="dark"] #kt_table.table.table-striped>tbody>tr:nth-of-type(even)>* {
	background-color: #15171C !important;
	box-shadow: none !important;
}

[data-bs-theme="dark"] #kt_table.table-hover tbody tr:hover>*,
[data-bs-theme="dark"] #kt_table.table-hover tbody tr:hover>td,
[data-bs-theme="dark"] #kt_table.table-hover tbody tr:hover>th,
[data-bs-theme="dark"] #kt_table.table.table-hover>tbody>tr:hover>*,
[data-bs-theme="dark"] #kt_table.dataTable>tbody>tr:hover>* {
	background-color: #1B1C22 !important;
	box-shadow: none !important;
	transition: background-color .15s ease-in-out;
}

/* Status input-group (สูงเท่าช่อง Search) */
.status-group {
	height: 55px;
}
.status-group .input-group-text {
	background-color: var(--bs-gray-100);
	border-color: var(--bs-gray-300);
	color: var(--bs-gray-700);
	padding: 0 1.25rem;
	border-top-left-radius: .625rem;
	border-bottom-left-radius: .625rem;
}
.status-group .form-select {
	height: 55px;
	border-color: var(--bs-gray-300);
	background-color: var(--bs-body-bg);
	padding-left: 1.25rem;
	border-top-right-radius: .625rem;
	border-bottom-right-radius: .625rem;
}

/* คอลัมน์ # : ชิดซ้าย + เว้นระยะจาก User (แบบหน้า Contact) */
#kt_table th:nth-child(1),
#kt_table td:nth-child(1) {
	width: 70px;
	text-align: left !important;
	padding-left: 16px !important;
}

/* กันคอลัมน์อื่นที่ DataTables มองเป็นตัวเลขไม่ให้ชิดขวา */
#kt_table th.dt-type-numeric,
#kt_table td.dt-type-numeric {
	text-align: left !important;
}

/* ข้อความ "ไม่พบข้อมูล" อยู่ตรงกลาง */
#kt_table td.dt-empty {
	text-align: center !important;
	padding-left: 0 !important;
	padding-top: 2.5rem !important;
	padding-bottom: 2.5rem !important;
	color: var(--bs-gray-500);
}
</style>
</head>
<body>
<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
  <div class="d-flex flex-column flex-column-fluid">

    <!-- Toolbar -->
    <div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
      <div id="kt_app_toolbar_container"
           class="app-container container-fluid d-flex align-items-center justify-content-between">
        <div class="page-title d-flex flex-column flex-wrap me-3 align-items-start">
          <h1 class="page-heading fw-semibold my-0" style="color: #4B5675;">Borrowing History</h1>
          <ul class="breadcrumb breadcrumb-separatorless fw-medium fs-7 my-0 pt-1">
            <li class="breadcrumb-item text-muted">
              <a href="${pageContext.request.contextPath}/demo_dashboard" class="text-muted text-hover-primary">Home</a>
            </li>
          </ul>
        </div>
        <a id="btnExport" href="#" class="btn btn-light">
          <i class="ki-duotone ki-file-down fs-2 text-success"><span class="path1"></span><span class="path2"></span></i>
          Download Excel
        </a>
      </div>
    </div>

    <!-- Content -->
    <div id="kt_app_content" class="app-content flex-column-fluid">
      <div id="kt_app_content_container" class="app-container container-fluid">

        <!-- Filter -->
        <div class="card mb-8">
          <div class="card-body">
            <form id="filterForm" action="borrow_history" method="get" class="row g-4 align-items-center">

              <!-- Search -->
              <div class="col-md-9">
                <div class="d-flex align-items-center border border-gray-300 rounded-3 px-4 py-2 gap-3 h-55px bg-body w-100">
                  <i class="ki-duotone ki-magnifier fs-4 text-gray-500">
                    <span class="path1"></span><span class="path2"></span>
                  </i>
                  <input type="text" id="keyword" name="keyword"
                         class="form-control border-0 bg-transparent ps-0 w-100"
                         placeholder="Search" autocomplete="off" />
                </div>
              </div>

              <!-- Status -->
              <div class="col-md-3">
                <div class="input-group status-group">
                  <span class="input-group-text">Status</span>
                  <select id="status" name="status" class="form-select">
                    <option value="ALL">All</option>
                    <option value="B">Borrowing</option>
                    <option value="W">Wait for Approve</option>
                    <option value="T">Waiting for Return</option>
                    <option value="R">Returned</option>
                  </select>
                </div>
              </div>

            </form>
          </div>
        </div>

        <!-- Summary -->
        <div class="d-flex align-items-center gap-4 mb-6">
          <span class="fs-3 fw-bold"><span id="empCount">0</span> Employees</span>
          <span class="fs-3 fw-bold"><span id="itemCount">0</span> Items Borrows</span>
          <span class="text-gray-500 fs-7">by Recent User &darr;</span>
        </div>

        <!-- Type Box + Table -->
        <div class="card">
          <div class="card-border-radius">
            <div class="card-body">

              <!-- Type Box -->
              <div class="border border-dashed border-gray-400 rounded-3 px-7 py-6 mb-8 bg-transparent">
                <div class="d-flex flex-column">
                  <div class="fs-4 text-gray-800 fw-bold mb-4">Type</div>
                  <div class="d-flex flex-wrap align-items-center gap-9">
                    <div class="d-inline-flex align-items-center me-10 mb-2">
                      <i class="ki-solid ki-laptop fs-1 text-gray-500 me-3"></i>
                      <span class="fs-6 fw-normal text-gray-900">Computer</span>
                    </div>
                    <div class="d-inline-flex align-items-center me-10 mb-2">
                      <i class="ki-solid ki-keyboard fs-1 text-gray-500 me-3"></i>
                      <span class="fs-6 fw-normal text-gray-900">Instrument</span>
                    </div>
                    <div class="d-inline-flex align-items-center me-10 mb-2">
                      <i class="ki-solid ki-verify fs-1 text-gray-500 me-3"></i>
                      <span class="fs-6 fw-normal text-gray-900">Software License</span>
                    </div>
                    <div class="d-inline-flex align-items-center me-10 mb-2">
                      <i class="ki-solid ki-phone fs-1 text-gray-500 me-3"></i>
                      <span class="fs-6 fw-normal text-gray-900">Mobile</span>
                    </div>
                    <div class="d-inline-flex align-items-center me-10 mb-2">
                      <i class="ki-solid ki-dots-square fs-1 text-gray-500 me-3"></i>
                      <span class="fs-6 fw-normal text-gray-900">Other</span>
                    </div>
                    <div class="d-inline-flex align-items-center me-10 mb-2">
                      <i class="ki-solid ki-wifi-square fs-1 text-gray-500 me-3"></i>
                      <span class="fs-6 fw-normal text-gray-900">Pocket WIFI</span>
                    </div>
                  </div>
                </div>
              </div>

              <!-- Table -->
              <div class="table-responsive">
                                <table class="table table-striped table-hover align-middle table-row-bordered fs-6 gy-4" id="kt_table">
                  <thead>
                      <tr class="text-gray-500 fw-bold fs-7 text-uppercase text-nowrap">
                      <th class="w-50px">#</th>
                      <th class="min-w-250px">User</th>
                      <th class="min-w-100px">Borrow ID</th>
                      <th class="w-80px text-center">Type</th>
                      <th class="min-w-250px w-30">Item No / Equipment</th>
                      <th class="min-w-125px">Borrow Date</th>
                      <th class="w-80px text-center">Status</th>
                      <th class="text-center min-w-100px">Actions</th>
                    </tr>
                  </thead>
                  <tbody id="historyBody"></tbody>
                </table>
              </div>

            </div> 
          </div>   
        </div>    

      </div> 
    </div>   

  </div> 
</div>   

<script>
  var CTX = "${pageContext.request.contextPath}";
  var historyList    = ${empty history ? '[]' : history};
  var selectedStatus = "${selectedStatus}";

  function esc(s) { return $('<div>').text(s == null ? '' : s).html(); }

  function getTypeIcon(type) {
    switch ((type || '').toLowerCase()) {
      case 'c':   return '<i class="ki-solid ki-laptop fs-1 text-gray-500"></i>';
      case 'in':  return '<i class="ki-solid ki-keyboard fs-1 text-gray-500"></i>';
      case 'l': case 'sl': return '<i class="ki-solid ki-verify fs-1 text-gray-500"></i>';
      case 'mob': return '<i class="ki-solid ki-phone fs-1 text-gray-500"></i>';
      case 'p':   return '<i class="ki-solid ki-wifi-square fs-1 text-gray-500"></i>';
      default:    return '<i class="ki-solid ki-dots-square fs-1 text-gray-500"></i>';
    }
  }

  function getStatusBadge(s) {
    var cls   = { B: 'badge-warning', W: 'badge-light', T: 'badge-info', R: 'badge-success' };
    var title = { B: 'Borrowing', W: 'Wait for Approve', T: 'Waiting for Return', R: 'Returned' };
    s = (s || '').toUpperCase();
    return '<span class="badge ' + (cls[s] || 'badge-light') + '" title="' + (title[s] || '') + '">' + (s || '-') + '</span>';
  }

  function renderTable(data) {
    var $tb = $('#historyBody').empty();
    var blank = CTX + '/assets/media/avatars/blank.png';
/* 
    if (!data.length) {
        $tb.append('<tr><td colspan="8" class="text-center text-gray-500 py-10">No data</td></tr>');
      } */
    data.forEach(function (r, i) {
      var img  = r.user_image ? CTX + r.user_image : blank;
      var site = r.site_name ? '<span class="badge badge-primary mt-1">' + esc(r.site_name) + '</span>' : '';
      $tb.append(
        '<tr>' +
          '<td class="fw-bold">' + (i + 1) + '</td>' +
          '<td><div class="d-flex align-items-center">' +
          getAvatar(r) +
            '<div><div class="text-gray-900">' + esc(r.employee_id) + ' - ' + esc(r.name_en || r.name) + '</div>' + site + '</div>' +
          '</div></td>' +
          '<td class="text-nowrap" data-order="' + Number(r.borrow_id) + '">#' + esc(r.borrow_id) + '</td>' +
          '<td class="text-center">' + getTypeIcon(r.type) + '</td>' +
          '<td><div class="text-gray-900">' + esc(r.item_no) + '</div><div class="text-gray-700 mt-2">' + esc(r.equipment_name) + '</div></td>' +
          '<td class="text-nowrap">' + esc(r.borrow_date) + '</td>' +
          '<td class="text-center">' + getStatusBadge(r.status) + '</td>' +
          '<td class="text-center">' +
          '<div class="d-flex justify-content-center gap-2 flex-nowrap">' +
            '<a href="borrow_edit?id=' + r.borrow_id + '" class="btn btn-icon btn-sm btn-light-primary" title="Detail">' +
              '<i class="ki-duotone ki-document fs-3"><span class="path1"></span><span class="path2"></span></i></a>' +
            '<a href="borrowReport?borrowId=' + r.borrow_id + '" target="_blank" class="btn btn-icon btn-sm btn-light-success" title="Print">' +
              '<i class="ki-duotone ki-printer fs-3"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i></a>' +
          '</div>' +
        '</td>' +
        '</tr>'
      );
    });

    var emp = {};
    data.forEach(function (r) { emp[r.user_id] = true; });
    $('#empCount').text(Object.keys(emp).length);
    $('#itemCount').text(data.length);
  }

  $(document).ready(function () {
    // ค่า Status ที่เลือกไว้
    $('#status').val(selectedStatus || 'ALL');

    // เปลี่ยน Status → โหลดข้อมูลใหม่จาก server
    $('#status').on('change', function () { $('#filterForm').submit(); });

    // กด Enter ในช่อง Search ไม่ต้อง reload หน้า
    $('#filterForm').on('submit', function (e) {
      if (document.activeElement && document.activeElement.id === 'keyword') e.preventDefault();
    });

    // สร้างแถว
    renderTable(historyList);
    // เก็บหัวคอลัมน์เดิมไว้ก่อนเปิด DataTables (แบบ borrow_list.jsp)
    const originalThHtml = $('#kt_table thead th').map(function () {
      return $(this).html();
    }).get();

    // สร้าง DataTable (ตั้งค่าแบบ borrow_list.jsp)
    var table = $('#kt_table').DataTable({
      pageLength: 10,
      lengthMenu: [10, 20, 50, 100],
      ordering: true,
      searching: true,
      info: false,
      autoWidth: false,
      pagingType: "simple_numbers",
      columnDefs: [
        { orderable: true,  targets: [1, 2, 3, 4, 5, 6] },
        { orderable: false, targets: [1, 7] }   // # และ ACTIONS
      ],
      order: [],
      headerCallback: function (thead) {
        $(thead).find('th').each(function (i) {
          if ($(this).find('.th-inline').length) return;

          const html = originalThHtml[i] || $(this).html();
          $(this).empty().append(
            $('<span class="th-inline" style="display:inline-flex;align-items:center;gap:6px;white-space:nowrap;"/>')
              .append($('<span class="th-text"/>').html(html))
          );
        });
      },
      dom: "<'row'<'col-12'tr>>" +
           "<'row mt-3'<'col-sm-6 d-flex align-items-center'l>" +
           "<'col-sm-6 d-flex justify-content-end'p>>",
      language: {
        lengthMenu: "_MENU_",
        paginate: { first: "«", last: "»", next: ">", previous: "<" },
        zeroRecords: "ไม่พบข้อมูล",
        emptyTable: "ไม่พบข้อมูล"
      }
    });

    // ตัวเลข Employees / Items อัปเดตทุกครั้งที่ค้นหา/เปลี่ยนหน้า
    table.on('draw', function () {
      var rows = table.rows({ search: 'applied' }).nodes().toArray();
      var emp = {};
      rows.forEach(function (tr) { emp[tr.getAttribute('data-user')] = true; });
      $('#empCount').text(Object.keys(emp).length);
      $('#itemCount').text(rows.length);
    });

    // ช่อง Search → ให้ DataTables กรอง
    $('#keyword').on('input', function () {
      table.search(this.value).draw();
    });

    // Download Excel
    $('#btnExport').on('click', function (e) {
      e.preventDefault();
      window.location = 'exportBorrowHistory?status=' + encodeURIComponent($('#status').val());
    });
  });
  
  // รูปโปรไฟล์: มีรูปใช้รูป, ไม่มีรูป/โหลดไม่ได้ → วงกลมตัวอักษรแรกของชื่อ
    var AVATAR_COLORS = ['primary'];

  function getAvatar(r) {
    var name    = r.name_en || r.name || r.employee_id || '?';
    var initial = String(name).trim().charAt(0).toUpperCase();

    // เลือกสีจากชื่อ (ชื่อเดียวกันได้สีเดิมเสมอ)
    var sum = 0;
    for (var k = 0; k < name.length; k++) sum += name.charCodeAt(k);
    var color = AVATAR_COLORS[sum % AVATAR_COLORS.length];

    var label = '<div class="symbol-label fs-5 fw-bold bg-light-' + color + ' text-' + color +
                (r.user_image ? ' d-none' : '') + '">' + esc(initial) + '</div>';

    var image = r.user_image
      ? '<img src="' + CTX + esc(r.user_image) + '" alt="" ' +
        'onerror="this.nextElementSibling.classList.remove(\'d-none\'); this.remove();">'
      : '';

    return '<div class="symbol symbol-40px symbol-circle me-3 flex-shrink-0">' + image + label + '</div>';
  }
</script>
</body>
</html>