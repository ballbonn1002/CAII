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
.carousel {
	overflow-x: auto;
	display: flex;
	scrollbar-width: none;
	-ms-overflow-style: none;
	scroll-behavior: smooth;
	cursor: grab;
	user-select: none;
	max-width: 600px;
	scrollbar-width: none;
}

.carousel:active {
	cursor: grabbing;
}

.carousel img {
	pointer-events: none;
	user-select: none;
}

.carousel::-webkit-scrollbar {
	display: none;
}

.responsive-button {
	padding: 0.775rem 1.5rem !important;
	font-size: 1.1rem !important;
	border-radius: 0.475rem !important;
	/* Light theme */
	background-color: var(--bs-white) !important;
	color: var(--bs-primary) !important;
	border: 1px solid var(--bs-primary-border-subtle) !important;
	transition: background-color 0.2s ease-in-out, color 0.2s ease-in-out,
		border-color 0.2s ease-in-out, box-shadow 0.2s ease-in-out !important;
}

/* Icon */
.responsive-button i {
	color: var(--bs-primary) !important;
	transition: color 0.2s ease-in-out !important;
}

/* Hover */
.responsive-button:hover {
	background-color: var(--bs-primary) !important;
	color: var(--bs-white) !important;
	border-color: var(--bs-primary) !important;
}

.responsive-button:hover i {
	color: var(--bs-white) !important;
}

[data-bs-theme="dark"] .responsive-button {
	background-color: transparent !important;
	color: var(--bs-primary) !important;
	border-color: var(--bs-primary) !important;
}

[data-bs-theme="dark"] .responsive-button i {
	color: var(--bs-primary) !important;
}

[data-bs-theme="dark"] .responsive-button:hover {
	background-color: var(--bs-primary) !important;
	color: var(--bs-white) !important;
	border-color: var(--bs-primary) !important;
}

[data-bs-theme="dark"] .responsive-button:hover i {
	color: var(--bs-white) !important;
}

.image-cover {
	object-fit: cover;
	height: clamp(160px, 20vw, 313px);
}

.image-cover[id="redeemItemImage"] {
	object-fit: cover;
	height: clamp(250px, 30vw, 100%);
}

.redeem-image-container {
	height: 300px;
	overflow: hidden;
}

.bg-dark-light {
	background-color: var(--bs-dark-light) !important;
}

.redeem-btn {
	position: relative;
	overflow: hidden;
	background-color: var(--bs-light) !important;
	border: 1px solid var(--bs-primary-border-subtle) !important;
	color: var(--bs-primary) !important;
	transition: background-color 0.25s ease, color 0.25s ease;
}

.redeem-btn[disabled] {
	background-color: var(--bs-gray-200) !important;
	border: 1px solid var(--bs-gray-200) !important;
	color: var(--bs-text-muted) !important;
}

.redeem-btn .ki-parcel {
	position: absolute;
	top: 50%;
	left: 50%;
	opacity: 0 !important;
	color: var(--bs-white) !important;
	transform: translate(-50%, -50%) translateX(-35px);
	transition: opacity 0.4s ease, transform 0.5s
		cubic-bezier(0.22, 1, 0.36, 1) !important;
}

.redeem-text {
	display: inline-block;
	transform: translateX(0);
	transition: transform 0.5s cubic-bezier(0.22, 1, 0.36, 1);
}

.redeem-btn:hover {
	background-color: var(--bs-primary) !important;
	color: var(--bs-white) !important;
}

.redeem-btn:hover .ki-parcel {
	opacity: 1 !important;
	transform: translate(-50%, -50%) translateX(-50px);
}

.redeem-btn:hover .redeem-text {
	transform: translateX(12px);
}

.details-truncate {
	display: -webkit-box;
	-webkit-box-orient: vertical;
	-webkit-line-clamp: 2;
	overflow: hidden;
}

.image-carousel {
	width: 70px !important;
	min-width: 70px !important;
	max-width: 70px !important;
	flex: 0 0 70px !important;
}

.image-carousel.active {
	border-color: var(--bs-dark) !important;
}

.effective-date {
	background: rgba(0, 0, 0, 0.15);
	transition: background 0.4s cubic-bezier(0.22, 1, 0.36, 1);
}

.item-card:hover .effective-date {
	background: rgba(0, 0, 0, 0.5);
}

.badge-gray-500 {
	background-color: rgba(219, 223, 233, 1) !important;
	color: var(--bs-text-muted) !important;
}

/* Mobile */
@media ( max-width : 767.98px) {
	.responsive-button {
		padding: 0.7rem 1rem !important;
		font-size: 0.95rem !important;
		border-radius: 0.425rem !important;
		font-weight: 500 !important;
		line-height: 1.5 !important;
	}
	.redeem-btn:hover .ki-parcel {
		opacity: 1 !important;
		transform: translate(-50%, -50%) translateX(-40px);
	}
	.border-end-dashed {
		border-right: 0 !important;
	}
}

/* Tablet */
@media ( min-width : 768px) and (max-width: 991.98px) {
	.redeem-btn:hover .ki-parcel {
		transform: translate(-50%, -50%) translateX(-45px);
	}
}
</style>
</head>
<body>
	<div class="d-flex flex-column flex-column-fluid">
		<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
			<div id="kt_app_toolbar_container"
				class="app-container container-fluid d-flex flex-stack">
				<div class="d-flex justify-content-between align-items-center w-100">

					<div
						class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
						<h1
							class="page-heading d-flex text-gray-700 fw-semibold flex-column justify-content-center my-0">
							Privilege</h1>
						<ul
							class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
							<li class="breadcrumb-item text-muted"><a
								href="${pageContext.request.contextPath}/check_in_out"
								class="text-muted text-hover-primary">Home</a></li>
							<li class="breadcrumb-item"><span
								class="bullet bg-gray-500 w-5px h-2px"></span></li>
							<li class="breadcrumb-item text-muted"><a href="#"
								class="text-muted text-hover-primary">Cube Token Management</a></li>

							<li class="breadcrumb-item"><span
								class="bullet bg-gray-500 w-5px h-2px"></span></li>
							<li class="breadcrumb-item text-muted"><a
								href="${pageContext.request.contextPath}/privilegePage"
								class="text-muted text-hover-primary">Privilege</a></li>
						</ul>
					</div>

					<div class="d-flex align-items-center justify-content-end">
						<button
							class="d-flex align-items-center justify-content-start gap-3 btn responsive-button"
							type="button">
							<i class="ki-duotone ki-handcart fs-1"></i> <span class="fs-6">
								Privilege History </span>

						</button>
					</div>
				</div>

			</div>
		</div>

		<div id="kt_app_content" class="app-content flex-column-fluid ">
			<div id="kt_app_content_container"
				class="app-container container-fluid">

				<div class="card">
					<div class="card-body">
						<div class="row g-6">

							<!-- Search -->
							<div class="col-12 col-md-9">
								<div class="position-relative">
									<i
										class="ki-duotone ki-magnifier fs-5 position-absolute top-50 translate-middle-y ms-4 text-gray-500">
										<span class="path1"></span> <span class="path2"></span>
									</i> <input type="text" id="searchInput"
										class="form-control form-control-lg ps-12"
										placeholder="Search" />
								</div>
							</div>

							<!-- Filter -->
							<div class="col-12 col-md-3">
								<select id="filterSelect" class="form-select form-select-lg"
									data-control="select2" data-hide-search="true">
									<option value="all">All Item</option>
									<option value="available">Available</option>
									<option value="redeemable">Can Redeem</option>
									<option value="favorite">Favorites</option>
								</select>
							</div>

						</div>
					</div>
				</div>


				<div class="d-flex align-items-center justify-content-between mt-10">
					<h3 class="fw-semibold text-gray-900">
						Item List (<span id="itemCount">0</span>)
					</h3>
				</div>

				<div
					class="row row-cols-2 row-cols-md-3 row-cols-xl-4 g-4 g-md-6 mt-4 card-container">
					<!-- item card will be rendered here -->
				</div>

				<div class="modal fade" tabindex="-1" id="redeemModal">
					<div class="modal-dialog modal-lg modal-dialog-centered">
						<div class="modal-content">
							<div class="modal-header border-bottom-0">
								<h2 class="modal-title fw-bold text-gray-900">แลกของรางวัล</h2>

								<!--begin::Close-->
								<div class="btn btn-icon btn-sm btn-active-light-primary ms-2"
									data-bs-dismiss="modal" aria-label="Close">
									<i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span
										class="path2"></span></i>
								</div>
								<!--end::Close-->
							</div>

							<div class="modal-body">
								<div class="row g-6 ">
									<div class="col-12 col-md-7">
										<div class="d-flex align-items-center justify-content-center">

											<input type="hidden" id="itemId" />

											<button type="button" class="btn btn-icon rounded"
												id="prevImageBtn">
												<i class="ki-duotone ki-left-square fs-4x fs-md-2x"> <span
													class="path1"></span> <span class="path2"></span>
												</i>
											</button>


											<div
												class="flex-grow-1 d-flex justify-content-center align-items-center redeem-image-container">
												<img class="image-cover lozad" id="redeemItemImage" />
											</div>


											<button type="button" class="btn btn-icon rounded"
												id="nextImageBtn">
												<i class="ki-duotone ki-right-square fs-4x fs-md-2x"> <span
													class="path1"></span> <span class="path2"></span>
												</i>
											</button>
										</div>
										<div class="carousel gap-2 p-2 mt-6" id="carouselContainer">
										</div>

									</div>
									<div class="col-12 col-md-5">

										<div class="card p-6 w-100">
											<div class="fw-semibold fs-2 text-gray-800 mb-6"
												id="redeemItemName"></div>
											<div class="mb-6">
												<span class="badge badge-lg badge-light-success py-2"
													id="redeemItemQuantity"></span>
											</div>
											<div class="mb-6">
												<div class="d-flex align-items-center gap-4 mb-6">
													<i class="ki-duotone ki-laptop fs-2x"> <span
														class="path1"></span> <span class="path2"></span>
													</i>
													<div class="fw-bold fs-5 text-gray-800">Detail</div>
												</div>
												<div class="fw-normal fs-5 text-gray-800 lh-lg scroll"
													style="height: 150px;" id="redeemItemDetails"></div>
											</div>
											<div
												class="d-flex align-items-center flex-wrap fw-normal fs-5 text-primary">
												<span class="me-1">ระยะเวลาการแลก : </span> <span
													class="text-gray-800" id="effectiveDate"></span>
											</div>
										</div>
									</div>
								</div>

								<div class="card p-6 mt-7">
									<div class="row g-10">
										<div
											class="col-12 col-md-6 border-end-dashed border-gray-300 pe-7">
											<div
												class="d-flex flex-column align-items-center justify-content-center h-100">
												<div
													class="d-flex justify-content-between align-items-center w-100">
													<div class="text-gray-700 fs-6">ใช้แลกของรางวัล</div>
													<div class="d-flex align-items-center gap-2">
														<i class="ki-duotone ki-cube-2 fs-2x text-primary"> <span
															class="path1"></span> <span class="path2"></span> <span
															class="path3"></span>
														</i>
														<div class="fw-bold fs-3 text-gray-800"
															id="redeemTokenAmount"></div>
													</div>
												</div>

												<div
													class="d-flex justify-content-between align-items-center mt-6 w-100">
													<div class="text-gray-700 fs-6">+ เพิ่มเงิน</div>
													<div class="d-flex align-items-center gap-3">
														<i class="ki-duotone ki-text-bold fs-2x"> <span
															class="path1"></span> <span class="path2"></span> <span
															class="path3"></span>
														</i>
														<div class="fw-bold fs-3 text-gray-800">
															&#3647;<span id="redeemExtraCash"></span>
														</div>
													</div>
												</div>
											</div>


										</div>
										<div class="col-12 col-md-6">
											<div
												class="d-flex flex-column gap-8 justify-content-center w-100 px-md-4">
												<div class="fw-bold fs-5 text-gray-800">สรุปยอดหลังการแลก</div>
												<div
													class="d-flex align-items-center justify-content-between">
													<div class="fs-5 text-gray-600">แต้มที่มีอยู่:</div>
													<div class="fw-medium fs-5 user-current-balance"></div>
												</div>
												<div
													class="d-flex align-items-center justify-content-between">
													<div class="fs-5 text-gray-600">แต้มที่ใช้แลก:</div>
													<div class="fw-medium fs-5 text-danger redeem-token-amount">
													</div>
												</div>
												<div
													class="d-flex align-items-center justify-content-between">
													<div class="fs-5 text-gray-600">แต้มคงเหลือ:</div>
													<div class="fw-medium fs-5" id="remainingBalance"></div>
												</div>

												<div
													class="d-flex align-items-center gap-2 bg-light-danger rounded border border-danger py-2 px-3 mt-4"
													id="insufficientBalanceWarning">
													<i class="ki-duotone ki-information-3 fs-1 text-danger">
														<span class="path1"></span> <span class="path2"></span> <span
														class="path3"></span>
													</i>
													<div class="fw-medium fs-7 text-gray-700">ขออภัย
														แต้มของคุณไม่เพียงพอในการแลกสินค้าชินนี้</div>
												</div>
											</div>
										</div>
									</div>
								</div>

							</div>

							<div class="modal-footer border-top-0">
								<div class="d-flex justify-content-end ">
									<button type="button" class="btn btn-light me-3"
										data-bs-dismiss="modal">ยกเลิก</button>
									<button type="button" class="btn btn-success"
										id="modalRedeemBtn">ยืนยันการแลก</button>

								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
    let rewardItems = {};
    let userCurrentBalance = 0;
    const favoriteTimers = {};
    
    
    $(document).ready(function() {
		const currentYear  = new Date().getFullYear();
		loadUserInfo(currentYear);
		
		$(document).on("click", ".item-card", function() {
			const itemId = $(this).data("item-id");
			openRedeemModal(itemId);
	    })
	    
	    $(document).on("click", ".favorite-icon", toggleFavorite);
		
		$("#searchInput").on("input", function () {
		    filterRewardItems();
		});
		
		$("#filterSelect").on("change", function () {
		    filterRewardItems();
		});
		
		$(document).on("click", "#prevImageBtn", function () {

		    if (currentImageIndex > 0) {
		        showCarouselImage(currentImageIndex - 1);
		    }

		});
		
		$(document).on("click", "#nextImageBtn", function () {

		    if (currentImageIndex < carouselImagePaths.length - 1) {
		        showCarouselImage(currentImageIndex + 1);
		    }

		});
		
		$("#carouselContainer").on("mousedown", function (e) {

		    isDragging = true;

		    dragStartX = e.pageX;
		    scrollStartLeft = this.scrollLeft;

		    $(this).css("cursor", "grabbing");
		});

		$(document).on("mousemove", function (e) {

		    if (!isDragging) {
		        return;
		    }

		    const carousel = $("#carouselContainer")[0];

		    const walk = e.pageX - dragStartX;

		    carousel.scrollLeft = scrollStartLeft - walk;
		});

		$(document).on("mouseup", function () {

		    if (!isDragging) {
		        return;
		    }

		    isDragging = false;

		    $("#carouselContainer").css("cursor", "grab");
		});
		
		$("#modalRedeemBtn").on("click", submitRedeem)
    });
    
    function submitRedeem() {

        const itemId = $("#itemId").val();

        // Confirm before redeem
        Swal.fire({
            icon: "question",
            title: "Confirm Redemption",
            text: "Are you sure you want to redeem this reward?",
            showCancelButton: true,
            confirmButtonText: "Yes, Redeem",
            cancelButtonText: "Cancel",
            allowOutsideClick: false,
            allowEscapeKey: false,
            buttonsStyling: false,
	        customClass: {
	            confirmButton: "btn btn btn-success px-3",
	            cancelButton: "btn btn-light"
	        },
	        focusConfirm: false,
	        focusCancel: false,
	        reverseButtons: true
        }).then(function (result) {

            if (!result.isConfirmed) {
                return;
            }

            // Show loading while waiting for AJAX
            Swal.fire({
                title: "Redeeming Reward",
                text: "Please wait...",
                allowOutsideClick: false,
                allowEscapeKey: false,
                showConfirmButton: false,
                didOpen: function () {
                    Swal.showLoading();
                }
            });

            $.ajax({
                url: "${pageContext.request.contextPath}/redeemRewardItem",
                type: "POST",
                data: {
                    itemId: itemId
                },
                dataType: "json",

                success: function (response) {

                    if (response.success) {

                        Swal.fire({
                            icon: "success",
                            title: "Redemption Successful",
                            text: response.message || "You have successfully redeemed the reward.",
                            confirmButtonText: "OK",
                            buttonsStyling: false,
                            allowOutsideClick: false,
                            allowEscapeKey: false,
                            customClass: {
	                            confirmButton: "btn btn-success"
	                        }
                        }).then(function (result) {

                            if (result.isConfirmed) {
                                $("#redeemModal").modal("hide");
                                loadUserInfo();
                            }

                        });

                    } else {

                        Swal.fire({
                            icon: "error",
                            title: "Redemption Failed",
                            text: response.message || "Unable to redeem the reward.",
                            confirmButtonText: "OK",
                            allowOutsideClick: false,
                            allowEscapeKey: false,
                            buttonsStyling: false,
	                        customClass: {
	                            confirmButton: "btn btn-light"
	                        }
                        });
                        
                        console.error("Error response:", response);

                    }
                },

                error: function (xhr, status, error) {

                    console.error("Error redeeming item:", error);

                    let message = "An error occurred while redeeming the reward.";

                    if (xhr.responseJSON && xhr.responseJSON.message) {
                        message = xhr.responseJSON.message;
                    }

                    Swal.fire({
	                    title: "Error!",
	                    text: message,
	                    icon: "error",
	                    confirmButtonText: "OK",
	                    buttonsStyling: false,
	                    customClass: {
	                        confirmButton: "btn btn-light"
	                    }
	                });

                }
            });

        });
    }

    function escapeHtml(value) {
        if (value == null) return "";

        return String(value)
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#039;");
    }
    
    function loadUserInfo() {
        $.ajax({
            url: "${pageContext.request.contextPath}/getUserAccumelatedToken",
            type: "GET",
            dataType: "json",
            success: function(response) {
                if (response.success) {
                    userCurrentBalance = Number(response.data);
                    loadRewardItems();
                } else {
                    console.error("Invalid user info response:", response);
                }
            },
            error: function(xhr, status, error) {
                console.error("Error loading user info:", error);
            }
        });
    }

    function loadRewardItems() {

    	const $container = $(".card-container");
    	
    	// แสดง Loading
        $container.html(`
            <div class="w-100 d-flex justify-content-center align-items-center" style="height: 400px;">
                <div class="d-flex flex-column align-items-center gap-3">
                    <div
                        class="spinner-border text-primary"
                        role="status"
                        style="width: 3rem; height: 3rem;">
                        <span class="visually-hidden">Loading...</span>
                    </div>

                    <span class="text-gray-600 fw-semibold">
                        Loading...
                    </span>
                </div>
            </div>
        `);

        $.ajax({
            url: "${pageContext.request.contextPath}/getRewardItemList",
            type: "GET",
            dataType: "json",

            success: function(response) {

                const items = Array.isArray(response)
                    ? response
                    : response.data;

                if (!Array.isArray(items)) {
                    console.error("Invalid reward item response:", response);
                    
                    $container.html(`
                            <div class="d-flex align-items-center justify-content-center text-center w-100" style="height: 400px;">
                                <div class="d-flex flex-column align-items-center gap-3">

                                    <i class="ki-duotone ki-information-5 fs-5tx fs-md-3x text-danger">
                                        <span class="path1"></span>
                                        <span class="path2"></span>
                                        <span class="path3"></span>
                                    </i>

                                    <span class="text-danger fw-semibold">
                                        Failed to load reward items.
                                    </span>

                                </div>
                            </div>
                        `);
                    return;
                }
                

                $container.empty();
                
                $("#itemCount").text(items.length);
                
                if (items.length === 0) {
	                $(".card-container").append(`
	                    <div class="reward-no-result w-100">
	                        <div class="d-flex flex-column align-items-center justify-content-center text-center py-20">
	                            <i class="ki-duotone ki-magnifier fs-5tx text-gray-400">
	                                <span class="path1"></span>
	                                <span class="path2"></span>
	                            </i>
	
	                            <div class="fw-bold fs-3 text-gray-700 mt-5">
	                                No items found
	                            </div>
	
	                            <div class="text-gray-500 fs-6 mt-2">
	                            	There are currently no rewards available.
	                            </div>
	                        </div>
	                    </div>
	                `);
	                
	                return;
                }
                
                rewardItems = {};
                items.forEach(function(item) {

                	rewardItems[item.itemId] = item;

                    const itemId = escapeHtml(item.itemId);
                    const itemName = escapeHtml(item.itemName);
                    const details = escapeHtml(item.details).replace(/\r\n/g, "<br>").replace(/\n/g, "<br>");
                    const quantity = Number(item.quantity) || 0;
                    const token = Number(item.token) || 0;
                    const effectiveDate = `\${formatDate(item.startDate)} - \${formatDate(item.endDate)}`; 
                    const addedMoney = Number(item.addedMoney) || 0;
                    const isFavorite = Boolean(item.isFavorite);
                    

                    const coverPath =
                        "${pageContext.request.contextPath}" +
                        (item.coverPath || "");

                    const soldOut = quantity <= 0;
                    const isDisabled = soldOut || userCurrentBalance < token;

                    const html = `
                        <div class="col">

                            <!--begin::Card-->
                            <div class="card card-px-0 h-100 cursor-pointer item-card" data-item-id="\${itemId}">

                                <!--begin::Image-->
                                <div class="position-relative image-container">

                                    <div
                                        class="position-relative overflow-hidden bg-dark-light rounded-top">

                                        <img
                                            src="\${coverPath}"
                                            class="w-100 image-cover lozad"
                                            alt="\${itemName}">

                                        \${soldOut ? `
                                        <div
                                            class="position-absolute translate-middle top-50 start-50 w-100">

                                            <div
                                                class="d-flex justify-content-center align-items-center bg-danger text-white text-uppercase fw-bold fs-2 py-2">

                                                sold out

                                            </div>

                                        </div>
                                        ` : ""}
                                    </div>

                                    <!--begin::Stock-->
                                    <div
                                        class="d-flex w-100 justify-content-between position-absolute top-0 start-0 mt-3 ms-3 p-0">

                                        <div>

                                            <span
                                                class="badge badge-lg \${soldOut ? 'badge-gray-500' : 'badge-primary'} fw-normal fs-7 py-2 px-3" style="border: 1px solid rgba(241, 241, 244, 1);">

                                                \${quantity} ชิ้น

                                            </span>

                                        </div>
                                        <!--end::Stock-->

                                        <!--begin::Favorite-->
                                        <div
                                            class="cursor-pointer ps-6 favorite-icon position-relative"
                                            data-item-id="\${itemId}"> 

                                            <i class="position-absolute end-25 top-50 mt-4 me-2 me-md-4 translate-middle \${isFavorite ? 'ki-solid' : 'ki-outline' } ki-heart fs-3x fs-md-1 \${isFavorite ? 'text-danger' : ''}">

                                                <span class="path1"></span>
                                                <span class="path2"></span>

                                            </i>

                                        </div>
                                        <!--end::Favorite-->

                                    </div>
                                    
                                    <div class="effective-date position-absolute translate-middle-x bottom-0 start-50 w-100 d-flex align-items-center justify-content-center text-center p-4">
	                                	<div class="fs-7 text-white fw-normal">\${effectiveDate}</div>
	                                </div>
                                    
                                </div>
                                <!--end::Image-->
 

                                <!--begin::Card body-->
                                <div class="card-body d-flex flex-column p-6">

                                    <!--begin::Title-->
                                    <div class="mb-2">
                                        <div
                                            class="fw-bold fs-4 text-gray-700 text-truncate item-name">

                                            \${itemName}

                                        </div>

                                        <div
                                            class="fw-bold fs-6 text-gray-600 details-truncate mt-2">

                                            \${details}

                                        </div>

                                    </div>
                                    <!--end::Title-->


                                    <!--begin::Price-->
                                    <div class="mt-auto pt-10">

                                        <div
                                            class="d-flex align-items-center justify-content-between">

                                            <!-- Token -->
                                            <div
                                                class="d-flex align-items-center gap-2">

                                                <i
                                                    class="ki-duotone ki-cube-2 fs-2x text-primary">

                                                    <span class="path1"></span>
                                                    <span class="path2"></span>
                                                    <span class="path3"></span>

                                                </i>

                                                <span
                                                    class="fw-bold fs-3 text-primary">

                                                    \${token.toLocaleString()}

                                                </span>

                                            </div>


                                            <!-- Additional -->
                                            <div
                                                class="fw-medium fs-5 text-gray-700">

                                                + ฿ \${addedMoney.toLocaleString()}

                                            </div>

                                        </div>

                                    </div>
                                    <!--end::Price-->


                                    <!--begin::Button-->
                                    <div class="pt-6">

                                        <button
                                            type="button"
                                            data-item-id="\${itemId}"
                                            onClick="openRedeemModal(\${itemId})" \${isDisabled ? 'disabled' : ''}
                                            class="btn btn-icon w-100 fw-semibold p-1 redeem-btn"> 

                                            <i
                                                class="ki-duotone ki-parcel fs-2x text-primary position-absolute">

                                                <span class="path1"></span>
                                                <span class="path2"></span>
                                                <span class="path3"></span>
                                                <span class="path4"></span>
                                                <span class="path5"></span>

                                            </i>

                                            <span class="redeem-text">
                                                แลกของรางวัล
                                            </span>

                                        </button>

                                    </div>
                                    <!--end::Button-->

                                </div>
                                <!--end::Card body-->

                            </div>
                            <!--end::Card-->

                        </div>
                    `;

                    $container.append(html);
                });
            },

            error: function(xhr, status, error) {
                console.error("Error loading reward items:", error);
                
                // แสดง Error แทน Loading
                $container.html(`
                    <div class="d-flex align-items-center justify-content-center text-center w-100" style="height: 400px;">
                        <div class="d-flex flex-column align-items-center gap-3">

                            <i class="ki-duotone ki-information-5 fs-5tx fs-md-3x text-danger">
                                <span class="path1"></span>
                                <span class="path2"></span>
                                <span class="path3"></span>
                            </i>

                            <span class="text-danger fw-semibold">
                                Failed to load reward items.
                            </span>

                        </div>
                    </div>
                `);
            }
        });
	
    
    }
    
    function filterRewardItems() {
        const searchText = $("#searchInput").val().trim().toLowerCase();
        const filter = $("#filterSelect").val();

        let visibleCount = 0;

        $(".card-container .item-card").each(function () {
            const $card = $(this);
            const itemId = $card.data("item-id");
            const item = rewardItems[itemId];

            if (!item) {
                $card.closest(".col").hide();
                return;
            }

            const itemName = String(item.itemName || "").toLowerCase();
            const details = String(item.details || "").toLowerCase();

            // =========================
            // Search
            // =========================
            const matchesSearch =
                !searchText ||
                itemName.includes(searchText) ||
                details.includes(searchText);

            // =========================
            // Filter
            // =========================
            let matchesFilter = true;

            const quantity = Number(item.quantity) || 0;
            const token = Number(item.token) || 0;
            const isFavorite = Number(item.isFavorite) === 1;
            
            if (filter === "available") {
                matchesFilter = quantity > 0;
            }

            if (filter === "redeemable") {
                matchesFilter =
                    quantity > 0 &&
                    userCurrentBalance >= token;
            }

            if (filter === "favorite") {
                matchesFilter = isFavorite;
            }

            // =========================
            // Show / Hide
            // =========================
            const visible = matchesSearch && matchesFilter;

            $card.closest(".col").toggle(visible);

            if (visible) {
                visibleCount++;
            }
        });

        // =========================
        // Item count
        // =========================
        $("#itemCount").text(visibleCount);

        // =========================
        // No result message
        // =========================
        $(".reward-no-result").remove();

        if (visibleCount === 0) {
            $(".card-container").append(`
                <div class="reward-no-result w-100">
                    <div class="d-flex flex-column align-items-center justify-content-center text-center py-20">
                        <i class="ki-duotone ki-magnifier fs-5tx text-gray-400">
                            <span class="path1"></span>
                            <span class="path2"></span>
                        </i>

                        <div class="fw-bold fs-3 text-gray-700 mt-5">
                            No items found
                        </div>

                        <div class="text-gray-500 fs-6 mt-2">
                            Try changing your search or filter.
                        </div>
                    </div>
                </div>
            `);
        }
    }
    
    function formatDate(timestamp) {
        const date = new Date(timestamp);

        const day = date.getDate();
        const month = date.toLocaleString("en-US", { month: "short" });
        const year = String(date.getFullYear()).slice(-2);

        return `\${day} \${month} \${year}`;
    }
    
    function toggleFavorite(event) {

        event.stopPropagation();

        const $favorite = $(this);
        const itemId = $favorite.data("item-id");
        const $icon = $favorite.find("i");

        // เปลี่ยน UI ทันที
        const isFavorite = $icon.hasClass("ki-solid");

        if (isFavorite) {

            // Unfavorite
            $icon
                .removeClass("ki-solid text-danger")
                .addClass("ki-outline");

        } else {

            // Favorite
            $icon
                .removeClass("ki-outline")
                .addClass("ki-solid text-danger");
        }

        // ยกเลิก timer เดิมของ item นี้
        clearTimeout(favoriteTimers[itemId]);

        // รอให้หยุดกดก่อนค่อยส่ง AJAX
        favoriteTimers[itemId] = setTimeout(function() {

            $.ajax({

                url: "${pageContext.request.contextPath}/toggleFavorite",

                type: "POST",

                data: {
                    itemId: itemId
                },

                dataType: "json",

                success: function(response) {

                    if (!response.success) {

                        console.error(
                            response.message || "Failed to toggle favorite."
                        );
                        
                        const isFavorite = response.data;

                        // Update local data
                        if (rewardItems[itemId]) {
                            rewardItems[itemId].isFavorite = isFavorite;
                        }

                        const $icon = $favorite.find("i");

                        // ถ้า backend fail ให้ย้อน UI กลับ
                        if (isFavorite) {
                            $icon
                                .removeClass("ki-outline")
                                .addClass("ki-solid text-danger");
                        } else {
                            $icon
                                .removeClass("ki-solid text-danger")
                                .addClass("ki-outline");
                        }

                        return;
                    }
                },

                error: function(xhr, status, error) {

                    console.error(
                        "Toggle favorite error:",
                        error
                    );

                    // AJAX fail → rollback UI
                    if (isFavorite) {
                        $icon
                            .removeClass("ki-outline")
                            .addClass("ki-solid text-danger");
                    } else {
                        $icon
                            .removeClass("ki-solid text-danger")
                            .addClass("ki-outline");
                    }
                }

            });

        }, 500);
    }
    
    let carouselImagePaths = [];
    let currentImageIndex = 0;
    
    let isDragging = false;
    let dragStartX = 0;
    let scrollStartLeft = 0;
    
    function renderThumbnails() {

        const $carouselContainer = $("#carouselContainer");
        $carouselContainer.empty();

        const totalImages = carouselImagePaths.length;

        if (carouselImagePaths.length === 0) {
            return;
        }

        carouselImagePaths.forEach((imagePath, index) => {

            const $imageDiv = $(`
                <div
                    class="border-gray-300 border rounded cursor-pointer image-carousel  \${index === currentImageIndex ? 'active' : ''}"
                    style="width: 70px; height: 70px">

                    <img
                        width="70"
                        height="70"
                        src="\${imagePath}"
                        style="width: 100%; height: 100%; object-fit: cover;"
                        class="rounded lozad" />

                </div>
            `);

            $imageDiv.on("click", function () {

            	currentImageIndex = index; 
            	
                $("#redeemItemImage").attr(
                    "src",
                    carouselImagePaths[index]
                );

                renderThumbnails();
                updateCarouselButtons();
            });

            $carouselContainer.append($imageDiv);
        });
    }
    
    function renderCarouselImages(item) {

        const $carouselContainer = $("#carouselContainer");
        const $redeemItemImage = $("#redeemItemImage");

        $carouselContainer.empty();

        const contextPath = "${pageContext.request.contextPath}";

        const coverPath = contextPath + (item.coverPath || "");

        let imgPaths = [];

        if (Array.isArray(item.imgPath)) {
            imgPaths = item.imgPath;
        } else if (item.imgPath) {
            try {
                imgPaths = JSON.parse(item.imgPath);
            } catch (e) {
                console.error("Invalid imgPath:", item.imgPath);
            }
        }

        // เก็บรูปทั้งหมดไว้ให้ปุ่มลูกศรใช้
        carouselImagePaths = [
            coverPath,
            ...imgPaths.map(image => contextPath + image)
        ];

        // เริ่มต้นที่ Cover
        currentImageIndex = 0;

        $redeemItemImage.attr("src", carouselImagePaths[currentImageIndex]);

        renderThumbnails();
        updateCarouselButtons()

        
    }
    
    function showCarouselImage(index) {

        if (carouselImagePaths.length === 0) {
            return;
        }

        currentImageIndex = index;

        $("#redeemItemImage").attr(
            "src",
            carouselImagePaths[currentImageIndex]
        );

        renderThumbnails();

        updateCarouselButtons();
    }
    
    function updateCarouselButtons() {

        const totalImages = carouselImagePaths.length;

        $("#prevImageBtn").prop(
            "disabled",
            currentImageIndex <= 0
        );

        $("#nextImageBtn").prop(
            "disabled",
            currentImageIndex >= totalImages - 1
        );
    }
    
    function openRedeemModal(itemId) {

        const item = rewardItems[itemId];
        
        if (!item) {
            console.error("Item not found:", itemId);
            return;
        }
        
        renderCarouselImages(item);

        // Populate modal with item details
        $("#itemId").val(item.itemId);
        $("#redeemItemName").text(item.itemName);
        $("#redeemItemQuantity").text(`คงเหลือ \${item.quantity} ชิ้น`);
        $("#effectiveDate").text(`\${formatDate(item.startDate)} - \${formatDate(item.endDate)}`);
        $(".user-current-balance").text(userCurrentBalance.toLocaleString());
        $("#redeemTokenAmount").text(item.token.toLocaleString());
        $(".redeem-token-amount").text("-" + item.token.toLocaleString());
        $("#redeemItemDetails").html(item.details.replace(/\r\n/g, "<br>").replace(/\n/g, "<br>"));
        $("#redeemExtraCash").text(item.addedMoney.toLocaleString());
        
        const remainingBalance = userCurrentBalance - item.token;
        const isNegativeBalance = remainingBalance < 0;
        
		if (isNegativeBalance) {
            $("#remainingBalance").addClass("text-danger").removeClass("text-success");
            $("#insufficientBalanceWarning").removeClass("d-none");
            $("#modalRedeemBtn").prop("disabled", true);
        } else {
            $("#remainingBalance").addClass("text-success").removeClass("text-danger");
            $("#insufficientBalanceWarning").addClass("d-none");
            $("#modalRedeemBtn").prop("disabled", false);
        }
        
        $("#remainingBalance").text(`\${remainingBalance.toLocaleString()}`);
        
        
        // Show the modal
        $("#redeemModal").modal("show");
    }
    
    
	
	</script>

</body>
</html>