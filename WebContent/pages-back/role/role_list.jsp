<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="perm" uri="/WEB-INF/tlds/permission.tld"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:setLocale value="en_US" />
<fmt:setTimeZone value="Asia/Bangkok" />

<style>
  /*Light Mode*/
  [data-bs-theme="light"] #kt_table.table.table-striped > tbody > tr:nth-of-type(odd) > * {
    background-color: #FBFBFB !important;
    box-shadow: none !important;
  }
  [data-bs-theme="light"] #kt_table.table-hover tbody tr:hover > *,
  [data-bs-theme="light"] #kt_table.table.table-hover > tbody > tr:hover > *,
  [data-bs-theme="light"] #kt_table.dataTable > tbody > tr:hover > * {
    background-color: #F9F9F9 !important; /* hover */
    box-shadow: none !important;
    transition: background-color 0.15s ease-in-out;
  }

  /*Dark Mode*/
  [data-bs-theme="dark"] #kt_table.table.table-striped > tbody > tr:nth-of-type(odd) > * {
    background-color: #191B20 !important; /* odd */
    box-shadow: none !important;
  }
  [data-bs-theme="dark"] #kt_table.table.table-striped > tbody > tr:nth-of-type(even) > * {
    background-color: #15171C !important; /* even */
    box-shadow: none !important;
  }
  [data-bs-theme="dark"] #kt_table.table-hover tbody tr:hover > *,
  [data-bs-theme="dark"] #kt_table.table.table-hover > tbody > tr:hover > *,
  [data-bs-theme="dark"] #kt_table.dataTable > tbody > tr:hover > * {
    background-color: #1B1C22 !important; /* hover */
    box-shadow: none !important;
    transition: background-color 0.15s ease-in-out;
  }
</style>

<div class="app-main flex-column flex-row-fluid">
	<div class="d-flex flex-column flex-column-fluid">

		<!--Breadcrumb-->
		<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
			<div id="kt_app_toolbar_container" class="app-container container-fluid d-flex flex-stack">
				<div class="page-title d-flex flex-column justify-content-center flex-wrap me-3">

					<!--Title-->
					<h1 class="page-heading d-flex text-gray-900 fw-bold fs-3 flex-column justify-content-center my-0">Role Management</h1>
					<!--Title-->

					<ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
						<li class="breadcrumb-item text-muted"><a href="demo_dashboard" class="text-muted text-hover-primary">Home</a></li>
						<li class="breadcrumb-item"><span class="bullet bg-gray-500 w-5px h-2px"></span></li>
						<li class="breadcrumb-item text-muted">Authority</li>
					</ul>

				</div>
				
						<!--Btn Create-->
						<perm:permission object="role.edit">
							<div class="d-flex flex-wrap my-1">
								<a href="javascript:void(0)" class="btn btn-primary btn-lg" onclick="document.location = 'role-list-setting';">
								    <i class="ki-duotone ki-plus"></i>
								    Setting
								</a>
							</div>
						</perm:permission>
						<!--Btn Create-->
				
			</div>
		</div>
		<!--Breadcrumb-->

		<div id="kt_app_content" class="app-content flex-column-fluid">
			<div id="kt_app_content_container" class="app-container container-fluid">
				<div class="card">

					<!--Header-->
					<div class="card-header border-0 pt-6 mb-6 align-items-start">

						<div class="card-title">
							<h1 class="page-heading d-flex text-gray-900 fw-bold fs-3 my-0">Role Management</h1>
						</div>

						<!--Btn Create-->
						<perm:permission object="role.edit">
							<div class="d-flex flex-wrap my-1">
								<a href="javascript:void(0)" class="btn btn-success btn-lg" onclick="document.location = 'role-add';">
								    <i class="ki-duotone ki-plus"></i>
								    Create
								</a>
							</div>
						</perm:permission>
						<!--Btn Create-->

					</div>
					<!--Header-->

					<!--Table Listing-->
					<div class="card-body pt-0">
						<div class="table-responsive">
							<table class="table table-striped table-hover table-row-bordered fs-6 gy-5" id="kt_table" style="min-width: 1200px;">
								<thead>
									<tr class="text-start text-gray-500 fw-bold fs-7 text-uppercase gs-0 border-bottom border-gray-200">
										<th style="width: 120px; padding-left: 40px;" class="text-start">#</th>
										<th style="width: 350px; text-align: left;">Role ID</th>
										<th style="width: 350px; text-align: left;">Role Name</th>
										<th style="width: 250px; text-align: left;">Description</th>
										<th style="width: 120px;" class="text-end pe-5">Actions</th>
									</tr>
								</thead>
								<tbody class="fw-semibold text-gray-600">
									<c:forEach var="role" items="${roleList}" varStatus="status">
										<tr class="align-middle border-bottom border-gray-200">
											<td style="padding-left: 40px;" class="fw-bold text-gray-800 text-start text-nowrap">${status.count}</td>
											<td class="text-gray-900">${role.id}</td>
											<td class="text-gray-600">${role.name}</td>
											<td class="text-gray-600" style="white-space: normal; max-width: 360px; word-wrap: break-word;">${role.description}</td>

											<!-- Actions -->
											<td class="text-end text-nowrap pe-5" style="width: 120px;">
												<div class="d-inline-flex align-items-center justify-content-end gap-2">
													<!-- Edit -->
													<button type="button" class="btn btn-icon btn-sm btn-light-primary" aria-label="Edit"
														onclick="window.location.href='role-edit?roleId=${role.id}'">
														<i class="ki-duotone ki-pencil fs-5">
															<span class="path1"></span>
															<span class="path2"></span>
														</i>
													</button>

													<!-- Delete -->
													<%-- <perm:permission object="role.edit">
															<button type="button" class="btn btn-icon btn-sm btn-light-danger btn-delete-role" data-id="${role.id}" aria-label="Delete">
																<i class="ki-duotone ki-trash fs-5">
														            <span class="path1"></span>
														            <span class="path2"></span>
														            <span class="path3"></span>
														            <span class="path4"></span>
														            <span class="path5"></span>
																</i>
															</button>
														</perm:permission> --%>

													<perm:permission object="role.edit">
														<button type="button" class="btn btn-icon btn-sm btn-light-danger btn-delete-role" data-id="${role.id}" data-bs-toggle="modal"
															data-bs-target="#modal_delete_role" aria-label="Delete">
															<i class="ki-duotone ki-trash fs-5">
																<span class="path1"></span>
																<span class="path2"></span>
																<span class="path3"></span>
																<span class="path4"></span>
																<span class="path5"></span>
															</i>
														</button>
													</perm:permission>

												</div>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>

						</div>
					</div>
					<!--Table Listing-->
					
				</div>
			</div>
		</div>
	</div>
</div>

<!--Modal-->
<div class="modal fade" tabindex="-1" id="modal_delete_role">
	<div class="modal-dialog">
		<form id="deleteRoleForm" action="role-delete" method="get" class="modal-content">
			<div class="modal-body py-15 px-lg-17">
				<div class="mb-10 text-center">
					<i class="ki-duotone ki-information text-danger" style="font-size: 200px">
						<span class="path1"></span>
						<span class="path2"></span>
						<span class="path3"></span>
					</i>        
				</div>

				<div class="text-center mb-13">
					<h2 class="text-dark fw-bold mb-10 fs-1">Confirm Delete ?</h2>
					<div class="fw-semibold fs-5">
						<div>Are you sure you want to delete it?</div>
						<div>Once the data is deleted, it cannot be recovered.</div>
					</div>
					<input type="hidden" name="id" id="hiddenRoleId" />
				</div>

				<div class="d-flex flex-center">
					<button type="button" class="btn btn-light me-3" data-bs-dismiss="modal">Cancel</button>
					<button type="submit" class="btn btn-danger">Delete</button>
				</div>
			</div>
		</form>
	</div>
</div>
<!--Modal-->

<!--Modal-->
<%-- <div class="modal fade" tabindex="-1" id="modal_delete_role">
	<div class="modal-dialog">
		<form id="deleteRoleForm" action="role-delete" method="get" class="modal-content">
			<div class="modal-header position-relative">
				<h3 class="modal-title w-100 text-center">Confirm Delete Role?</h3>
				<div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
					<i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
				</div>
			</div>

			<div class="modal-body">
				<div class="text-center mb-5">
					<p class="text-danger fw-bold fs-4">Warning: User may using this role!</p>
					<div class="text-gray-600">
						<c:forEach var="user" items="${userlist}" varStatus="Count">
							<div>${Count.count}.${user.userId}</div>
						</c:forEach>
					</div>
					<p class="mt-5 text-gray-500">Are you sure you want to delete this role?</p>
				</div>

				<div class="mb-0 text-center">
					<img src="assets/media/illustrations/sigma-1/4.png" class="mw-100 mh-200px" alt="" />
				</div>

				<input type="hidden" name="id" id="hiddenRoleId" />
			</div>

			<div class="modal-footer justify-content-center gap-3">
				<button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
				<button type="submit" class="btn btn-danger">Confirm Delete</button>
			</div>
		</form>
	</div>
</div> --%>
<!--Modal-->

<%-- <div class="portlet light bordered">
	<div class="portlet-title">
		<perm:permission object="role.edit">
			<div class="actions right">
				<button type="button" id="addRole" class="btn green-meadow"
					onclick="add()">
					<i class="fa fa-plus"></i>&nbsp;Add Role
				</button>
				<a class="btn btn-circle btn-icon-only btn-default fullscreen"
					href="javascript:;" data-original-title="" title=""> </a>
			</div>
		</perm:permission>
	</div>
	<div class="portlet-body  flip-scroll">

		<div class="table-scrollable">
			<table
				class="table table-striped table-condensed flip-content table-hover text-center">
				<thead >
					<tr class="text-center" style="background-color:rgb(59, 63, 81);color:white">
						<th height="41"><center>#</center></th>
						<th height="41"><center>Role ID</center></th>
						<th height="41"><center>Name</center></th>
						<th height="41"><center>Description</center></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="role" items="${roleList}" varStatus="status">
						<tr>
							<td>${status.count}</td>
							<td style="word-break: break-all; white-space: normal;"><a
								href="role-edit?roleId=${role.id}">${role.id}</a></td>
							<td style="word-break: break-all; white-space: normal;">${role.name}</td>
							<td style="word-break: break-all; white-space: normal;text-align:left;">${role.description}</td>
						</tr>
					</c:forEach>

				</tbody>
			</table>
		</div>
	</div>
</div> --%>

<!-- END FORM-->

<script>
	$(document).ready(function() {

		// ----------------------------------------------------------------------
		// ผูก Event Click เข้ากับปุ่ม Delete ทุกปุ่มที่มีคลาส 'btn-delete-role'
		// ----------------------------------------------------------------------

		// โค้ดนี้จะทำงานได้ หลังจากคุณแก้ไข HTML ของปุ่ม Delete โดยเพิ่มคลาส
		// 'btn-delete-role' เข้าไปในปุ่ม Delete ทุกปุ่ม (ตามที่ได้แนะนำไปก่อนหน้า)
		/* $('.btn-delete-role').click(function() {
		    
		    // ดึงค่า Role ID ที่จะลบจาก Attribute "data-id" ของปุ่มที่ถูกคลิก
		    var roleIdToDelete = $(this).data('id');
		    
		    // 3. แสดง SweetAlert Pop-up
		    swal(
		        {
		            html : true,
		            title : "User may using this role!",
		            // ดึงรายการผู้ใช้มาแสดง
		            // ข้อมูล ${userlist} ต้องมีการส่งมาจาก Action Class (Struts 2)
		            text : "<c:forEach var="user" items="${userlist}" varStatus="Count"><span>${Count.count}.${user.userId}<br></span></c:forEach>"+
		            '<br>delete this role?',
		            type : "warning",
		            showCancelButton : true,
		            confirmButtonClass : 'btn-danger',
		            confirmButtonText : 'YES'
		        }, 
		        // 4. Callback Function: ทำงานเมื่อผู้ใช้กดปุ่มใน Pop-up
		        function(isConfirm) { 
		            if (isConfirm) {
		                // ถ้าผู้ใช้กดยืนยัน (YES)
		                // ส่ง Browser ไปยัง URL Action 'role-delete' พร้อมแนบ Role ID
		                document.location = "role-delete?id=" + roleIdToDelete;
		            }
		        }
		    );
		}); */

		// ----------------------------------------------------------------------
		// ผูก Event Click สำหรับปุ่ม Add Role (ถ้ามี ID 'addRole')
		// ----------------------------------------------------------------------
		/* $('#addRole').click(function() {
		    document.location = "role-add";
		}); */

		// ลบ Event ของปุ่ม #save ออกจากหน้ารายการ (role_list)
		// ถ้าคุณมีปุ่มที่ใช้ ID #save ในหน้านี้และต้องการให้ทำงาน
		/*
		$('#save').click(function() {
		    location.reload();
		});
		 */

		$('.btn-delete-role').on('click', function() {
			// ดึงค่า ID จากปุ่มที่คลิก
			var roleId = $(this).data('id');

			// นำ ID ไปใส่ใน hidden input ของฟอร์มใน Modal
			$('#hiddenRoleId').val(roleId);
		});

	});

</script>

<!-- DataTable -->
<script>
/* $(function () {
  // ลบ style ที่อาจจะติดมา
  $('#dt-no-pseudo, #dt-inline-fix, #dt-inline-style').remove();
  
  // สร้าง CSS สำหรับจัดหัวตารางให้สวยงาม
  const css = `
    #kt_table.dataTable thead th {
      white-space: nowrap;
      position: relative;
      padding-right: 16px;
    }
    #kt_table.dataTable thead th::before,
    #kt_table.dataTable thead th::after {
      top: 50% !important;
      transform: translateY(-50%) !important;
    }
  `;
  $('<style id="dt-inline-style">').text(css).appendTo('head');

  // เก็บ HTML เดิมของหัวตารางไว้
  const originalThHtml = $('#kt_table thead th').map(function () {
    return $(this).html();
  }).get();

  // เริ่มต้น DataTables
  const dt = $('#kt_table').DataTable({
    scrollX: true,
    scrollCollapse: true,
    autoWidth: false,
    responsive: false,

    searching: false, // ปิด Search box (ถ้าต้องการเปิดให้แก้เป็น true)
    pageLength: 25,
    lengthMenu: [25, 50, 100],
    
    // กำหนดคอลัมน์ที่จะให้ Sort หรือไม่ให้ Sort
    columnDefs: [
      { orderable: false, targets: [0, 4] }, // ห้าม Sort: Column 0 (#) และ 4 (Actions)
      { orderable: true,  targets: [1, 2, 3] } // ให้ Sort: ID, Name, Description
    ],
    order: [], // ไม่ต้อง Sort เริ่มต้น (หรือใส่ [1, 'asc'] ถ้าต้องการ)
    
    // จัดการส่วนแสดงผลหัวตาราง
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
    // กำหนด Layout ของตารางและ Pagination
    dom:
      "t" +
      "<'row mt-5'" +
        "<'col-sm-12 col-md-5 d-flex align-items-center justify-content-center justify-content-md-start'l>" +
        "<'col-sm-12 col-md-7 d-flex align-items-center justify-content-center justify-content-md-end'p>" +
      ">"
  });

  // ฟังก์ชันรันเลขบรรทัดใหม่ (Column #) เมื่อมีการเปลี่ยนหน้าหรือ Sort
  function renumber() {
    const info = dt.page.info();
    dt.column(0, { search:'applied', order:'applied', page:'current' })
      .nodes().each(function (cell, i) { 
          cell.textContent = info.start + i + 1; 
      });
  }

  // ผูก Event ให้รันเลขใหม่
  dt.on('draw.dt order.dt search.dt', renumber);
  renumber();

  // ปรับขนาดคอลัมน์เมื่อโหลดหรือ Resize จอ
  dt.columns.adjust();
  $(window).on('resize', () => dt.columns.adjust());
}); */
</script>
<!-- DataTable -->

<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script> -->

<!-- <link
	href="../assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.css"
	rel="stylesheet" type="text/css" />
<script src="../assets/global/plugins/jquery.min.js"
	type="text/javascript"></script>
<script
	src="../assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.js"
	type="text/javascript"></script>
<script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
<script
	src="../assets/global/plugins/bootstrap-sweetalert/sweetalert.min.js"
	type="text/javascript"></script>
<script src="../assets/pages/scripts/ui-sweetalert.min.js"
	type="text/javascript"></script>
<link
	href="../assets/global/plugins/bootstrap-sweetalert/sweetalert.css"
	rel="stylesheet" type="text/css" /> -->
<!-- SweetAlert -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
