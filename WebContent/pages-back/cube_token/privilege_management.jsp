<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.css"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/assets/css/style.bundle.css"
	rel="stylesheet" />
<style>
/* Header */
#itemTable thead th {
	font-weight: 600 !important;
	text-transform: uppercase;
	white-space: nowrap;
	vertical-align: middle;
}

#itemTable thead th .dt-column-header {
	display: inline-flex !important;
	flex-direction: row !important;
	align-items: center !important;
}

#itemTable thead th .dt-column-order {
	margin: 0 !important;
}
</style>
</head>
<body>
	<div class="d-flex flex-column flex-column-fluid">
		<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
			<div id="kt_app_toolbar_container"
				class="app-container container-fluid d-flex flex-stack">
				<div
					class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
					<h1
						class="page-heading d-flex text-gray-700 fw-semibold flex-column justify-content-center my-0">
						Privilege Management</h1>
					<ul
						class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
						<li class="breadcrumb-item text-muted"><a
							href="${pageContext.request.contextPath}/check_in_out"
							class="text-muted text-hover-primary">Home</a></li>
						<li class="breadcrumb-item"><span
							class="bullet bg-gray-500 w-5px h-2px"></span></li>
						<li class="breadcrumb-item text-muted"><a href="#"
							class="text-muted text-hover-primary">Cube Token Privilege</a></li>

						<li class="breadcrumb-item"><span
							class="bullet bg-gray-500 w-5px h-2px"></span></li>
						<li class="breadcrumb-item text-muted"><a
							href="${pageContext.request.contextPath}/privilegeMangementPage"
							class="text-muted text-hover-primary">Privilege Management</a></li>
					</ul>
				</div>
			</div>
		</div>

		<div id="kt_app_content" class="app-content flex-column-fluid ">
			<div id="kt_app_content_container"
				class="app-container container-fluid">

				<!--begin::Item List Card-->
				<div class="card card-flush">

					<!--begin::Card Header-->
					<div class="card-header pt-5">

						<!--begin::Card title-->
						<div class="card-title">
							<h3 class="fw-semibold text-gray-900">Item List</h3>
						</div>
						<!--end::Card title-->

						<!--begin::Card toolbar-->
						<div class="card-toolbar">
							<a href="createRewardItem" class="btn btn-success"> <i
								class="ki-duotone ki-plus fs-3"> <span class="path1"></span>
									<span class="path2"></span>
							</i> Create
							</a>
						</div>
						<!--end::Card toolbar-->

					</div>
					<!--end::Card Header-->


					<!--begin::Card Body-->
					<div class="card-body pt-5">

						<!--begin::Table-->
						<div class="table-responsive">

							<table class="table table-row-dashed align-middle gs-0 gy-4"
								id="itemTable">

								<!--begin::Table head-->
								<thead>
									<tr class="fw-bold fs-7 text-uppercase text-gray-500">
										<th class="text-center w-100px">#</th>
										<th class="w-150px">Item</th>
										<th style="min-width: 130px">Item Name</th>
										<th style="min-width: 160px">Detail</th>
										<th style="min-width: 100px">Token</th>
										<th style="min-width: 100px">Add Cash</th>
										<th style="min-width: 100px">Quantity</th>
										<th style="min-width: 205px">Effective Date</th>
										<th class="text-center w-100px">Active</th>
										<th class="text-end w-100px pe-4">Action</th>
									</tr>
								</thead>
								<!--end::Table head-->


								<!--begin::Table body-->
								<jsp:include page="/pages-back/cube_token/itemTableBody.jsp" />
								<!--end::Table body-->

							</table>
						</div>
						<!--end::Table-->


					</div>
					<!--end::Card Body-->

				</div>
				<!--end::Item List Card-->


			</div>
		</div>
	</div>

	<script>
		$(document).ready(function() {
			$("#itemTable").DataTable({

			    columnDefs: [
			        {
			            targets: [1, 8, 9],
			            orderable: false
			        }
			    ]
			});
			
			toastr.options = {
					  "closeButton": false,
					  "debug": false,
					  "newestOnTop": true,
					  "progressBar": true,
					  "positionClass": "toastr-top-right",
					  "preventDuplicates": false,
					  "onclick": null,
					  "showDuration": "300",
					  "hideDuration": "1000",
					  "timeOut": "5000",
					  "extendedTimeOut": "1000",
					  "showEasing": "swing",
					  "hideEasing": "linear",
					  "showMethod": "fadeIn",
					  "hideMethod": "fadeOut"
			};
			
			$(document).on("change", ".active-input", function () {

                const itemId = $(this).data("item-id");
                const activeFlag = $(this).is(":checked") ? "Y" : "N";

                $.ajax({
                    url: "updateRewardItemActiveFlag",
                    type: "POST",
                    data: {
                        itemId: itemId,
                        activeFlag: activeFlag
                    },
                    success: function (response) {

                        if (!response.success) {

                            toastr.error(response.message || "Unable to update reward item.");
                            
                            return;
                        }
                        
                        const isActive = response.data.activeFlag;
                        
                        $("input.active-input[data-item-id='" + itemId + "']").prop("checked", isActive);
                        
                        toastr.success(response.message || "Reward item updated successfully.");
                    },
                    error: function (xhr) {

                        let message =
                            "Unable to update reward item.";

                        if (
                            xhr.responseJSON
                            && xhr.responseJSON.message
                        ) {
                            message =
                                xhr.responseJSON.message;
                        }

                        toastr.error(message);
                    }
                });

            });
			
		});
		
		function reloadItemTable() {

		    $.ajax({
		        url: "reloadRewardItemTable",
		        type: "GET",

		        success: function (html) {

		            const table =
		                $("#itemTable").DataTable();

		            table.destroy();

		            $("#itemTable tbody").replaceWith(html);

		            $("#itemTable").DataTable();

		            Swal.fire({
		                title: "Deleted!",
		                text: "Reward item deleted successfully.",
		                icon: "success",
		                timer: 1200,
		                showConfirmButton: false
		            });
		        },

		        error: function () {

		            Swal.fire({
		                title: "Error!",
		                text: "Unable to reload item list.",
		                icon: "error"
		            });
		        }
		    });
		}
		
		$(document).on("click", ".deleteItemBtn", function () {

		    const itemId = $(this).data("item-id");

		    Swal.fire({
		        title: "Delete Reward Item?",
		        text: "Are you sure you want to delete this item?",
		        icon: "warning",
		        showCancelButton: true,
		        confirmButtonText: "Yes, Delete",
		        cancelButtonText: "Cancel",
		        buttonsStyling: false,
		        customClass: {
		            confirmButton: "btn btn btn-danger px-3",
		            cancelButton: "btn btn-light"
		        },
		        focusConfirm: false,
		        focusCancel: false,
		        reverseButtons: true
		    }).then(function (result) {

		        if (!result.isConfirmed) {
		            return;
		        }

		        Swal.fire({
		            title: "Deleting...",
		            text: "Please wait.",
		            allowOutsideClick: false,
		            allowEscapeKey: false,
		            didOpen: function () {
		                Swal.showLoading();
		            }
		        });

		        $.ajax({
		            url: "deleteRewardItem",
		            type: "POST",
		            data: {
		                itemId: itemId
		            },
		            success: function (response) {

		                if (!response.success) {

		                    Swal.fire({
		                        title: "Unable to Delete",
		                        text: response.message
		                            || "Unable to delete reward item.",
		                        icon: "error",
		                        buttonsStyling: false,
		                        customClass: {
		                            confirmButton: "btn btn-primary"
		                        }
		                    });

		                    return;
		                }

		                reloadItemTable();

		            },
		            error: function (xhr) {

		                let message =
		                    "Unable to delete reward item.";

		                if (
		                    xhr.responseJSON
		                    && xhr.responseJSON.message
		                ) {
		                    message =
		                        xhr.responseJSON.message;
		                }

		                Swal.fire({
		                    title: "Error!",
		                    text: message,
		                    icon: "error",
		                    buttonsStyling: false,
		                    customClass: {
		                        confirmButton: "btn btn-primary"
		                    }
		                });
		            }
		        });

		    });

		});
	</script>
</body>
</html>