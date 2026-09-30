<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/permission.tld" prefix="perm"%>

<fmt:setLocale value="en_US" />
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
#redeemTable thead th {
	text-transform: uppercase;
	white-space: nowrap;
	vertical-align: middle;
}

#redeemTable thead th .dt-column-header {
	display: inline-flex !important;
	flex-direction: row !important;
	align-items: center !important;
}

#redeemTable thead th .dt-column-order {
	margin: 0 !important;
}

.carousel {
	overflow-x: auto;
	display: flex;
	scrollbar-width: none;
	-ms-overflow-style: none;
	scroll-behavior: smooth;
	cursor: grab;
	user-select: none;
	max-width: 90%;
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

.border-light-info {
	border-color: var(--bs-info-bg-subtle) !important;
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
						Redeem Detail</h1>
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
							href="${pageContext.request.contextPath}/editRedeem?id=${redeem.userRedeemId}"
							class="text-muted text-hover-primary">Redeem History</a></li>

					</ul>
				</div>

				<div class="d-flex align-items-center justify-content-center">
					<span class="badge badge-lg py-4 px-4" id="statusBadge"></span>
				</div>
			</div>

		</div>

		<div id="kt_app_content" class="app-content flex-column-fluid ">
			<div id="kt_app_content_container"
				class="app-container container-fluid">



				<div class="row g-10">
					<div class="col-12 col-md-8">
						<div class="card card-flush">
							<div class="card-header mb-0 pb-0">
								<div class="card-title">


									<div>
										<h3 class="fw-semibold text-gray-900">Redeem</h3>
										<div class="fw-medium text-muted fs-7 mt-1">รูปภาพเพื่อประกอบการโฆษณาเท่านั้น</div>
									</div>
								</div>




							</div>

							<div class="card-body">
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
								<div class="carousel gap-2 p-2 mt-6 mx-auto"
									id="carouselContainer"></div>
								<div class="mt-8">
									<h2 class="fs-2 fw-semibold text-gray-800">
										${item.itemName}</h2>
									<div class="fw-bold fs-5 text-primary mt-6">Detail</div>
									<div class="mt-6 fw-normal fs-5 text-gray-800 lh-lg"
										id="itemDetails">${item.details}</div>
								</div>

								<c:if test="${!canEditRedeem || isOwner}">
									<div
										class="d-inline-flex align-items-center gap-2 py-2 px-3 rounded border border-light-info bg-light-info mt-7">
										<i class="ki-duotone ki-information-3 fs-1 text-info"> <span
											class="path1"></span> <span class="path2"></span> <span
											class="path3"></span>
										</i>
										<div class="fs-6 fw-medium text-info">หากต้องการยกเลิกการแลกของรางวัล
											กรุณาติดต่อฝ่าย HR</div>
									</div>
								</c:if>
							</div>


						</div>

						<div class="card card-flush mt-8" id="signatureCard">
							<div class="card-header">
								<h3 class="card-title">Signature</h3>
							</div>
							<div class="card-body" id="signatureCardBody"></div>
						</div>
					</div>
					<div class="col-12 col-md-4">

						<div class="row g-6">
							<div class="col-12">
								<div class="card card-flush">
									<div class="card-header">
										<h3 class="card-title">Redeem Request - Detail</h3>
									</div>

									<div class="card-body pt-3" id="requestDetailContainer"></div>
								</div>
							</div>
							<div class="col-12">
								<div class="card card-flush">
									<div class="card-header">
										<h3 class="card-title">Request log</h3>
									</div>

									<div class="card-body pt-3">
										<div class="timeline timeline-border-dashed"
											id="redeemLogContainer"></div>
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="modal modal-lg fade" tabindex="-1" id="deliveryModal">
						<div class="modal-dialog modal-dialog-centered">
							<div class="modal-content">
								<div class="modal-header border-0">
									<h3 class="modal-title">Confirm Deliver</h3>

									<!--begin::Close-->
									<div class="btn btn-icon btn-sm btn-active-light-primary ms-2"
										data-bs-dismiss="modal" aria-label="Close">
										<i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span
											class="path2"></span></i>
									</div>
									<!--end::Close-->
								</div>

								<div class="modal-body">
									<div class="row g-md-6 g-3">
										<div class="col-12 col-md-6">
											<div class="d-flex align-items-center gap-2">

												<%-- Avatar --%>
												<div class="symbol symbol-40px symbol-circle flex-shrink-0">
													<c:choose>
														<c:when test="${not empty user.path}">
															<div class="symbol-label p-0 overflow-hidden">
																<img
																	src="${pageContext.request.contextPath}${user.path}"
																	class="w-100 h-100" style="object-fit: cover;"
																	alt="${user.nameEN}" />
															</div>
														</c:when>

														<c:otherwise>
															<div
																class="symbol-label bg-light-primary text-primary fw-bold fs-3">
																<c:choose>
																	<c:when test="${not empty user.nameEN}">
										                                ${user.nameEN.substring(0, 1).toUpperCase()}
										                            </c:when>
																	<c:when test="${not empty user.name}">
										                                ${user.name.substring(0, 1)}
										                            </c:when>
																	<c:otherwise>?</c:otherwise>
																</c:choose>
															</div>
														</c:otherwise>
													</c:choose>
												</div>

												<%-- User information --%>
												<div class="fs-6 text-gray-900 lh-sm ">
													${user.employeeId} - ${user.name}</div>

											</div>
										</div>

										<div class="col-12 col-md-6 d-flex align-items-center">
											<div class="d-flex align-items-center gap-3">
												<i class="ki-duotone ki-calendar-2 fs-1"> <span
													class="path1"></span> <span class="path2"></span> <span
													class="path3"></span> <span class="path4"></span> <span
													class="path5"></span>
												</i>
												<div class="fs-6 text-gray-800">
													<fmt:formatDate value="${redeem.timeCreate}"
														pattern="dd MMM yyyy , H:mm" />
												</div>
											</div>
										</div>

										<div class="col-12 col-md-6 ">
											<div
												class="d-flex align-items-center gap-3 productTypeContainer"></div>
										</div>

										<div class="col-12 col-md-6">
											<div class="d-flex align-items-center gap-3">
												<i class="ki-duotone ki-parcel fs-1"> <span
													class="path1"></span> <span class="path2"></span> <span
													class="path3"></span> <span class="path4"></span> <span
													class="path5"></span>
												</i>
												<div class="fs-5 text-gray-900">${item.itemName}</div>
											</div>
										</div>
									</div>

									<div class="separator separator-dashed my-14 border-gray-300 "></div>

									<div>
										<label for="reason" class="form-label fw-medium">Remark
											(Optional)</label>
										<textarea class="form-control" id="remark" rows="3"
											placeholder="Enter delivery notes..."></textarea>
									</div>

									<div
										class="d-flex align-items-center gap-2 py-2 px-3 rounded border border-light-info bg-light-info mt-8">
										<i class="ki-duotone ki-information-3 fs-1 text-info"> <span
											class="path1"></span> <span class="path2"></span> <span
											class="path3"></span>
										</i>
										<div class="fs-6 fw-medium text-info">หมายเหตุนึ้จะปรากฏในเอกสาร PDF ใบรับมอบของรางวัล หลังจากทำรายการเสร็จสิ้น</div>
									</div>

								</div>

								<div class="modal-footer border-0">
									<button type="button" class="btn btn-light"
										data-bs-dismiss="modal">Close</button>
									<button type="button" class="btn btn-cyan ms-2"
										data-redeem-id="${redeem.userRedeemId}" id="confirmDeliverBtn">Confirm
										Delivery</button>
								</div>
							</div>
						</div>
					</div>

					<div class="modal modal-lg fade" tabindex="-1"
						id="cancelRequestModal">
						<div class="modal-dialog modal-dialog-centered">
							<div class="modal-content">
								<div class="modal-header border-0">
									<h3 class="modal-title">Cancel Redeem Request</h3>

									<!--begin::Close-->
									<div class="btn btn-icon btn-sm btn-active-light-primary ms-2"
										data-bs-dismiss="modal" aria-label="Close">
										<i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span
											class="path2"></span></i>
									</div>
									<!--end::Close-->
								</div>

								<div class="modal-body">

									<div class="row g-md-6 g-3">
										<div class="col-12 col-md-6">
											<div class="d-flex align-items-center gap-2">

												<%-- Avatar --%>
												<div class="symbol symbol-40px symbol-circle flex-shrink-0">
													<c:choose>
														<c:when test="${not empty user.path}">
															<div class="symbol-label p-0 overflow-hidden">
																<img
																	src="${pageContext.request.contextPath}${user.path}"
																	class="w-100 h-100" style="object-fit: cover;"
																	alt="${user.nameEN}" />
															</div>
														</c:when>

														<c:otherwise>
															<div
																class="symbol-label bg-light-primary text-primary fw-bold fs-3">
																<c:choose>
																	<c:when test="${not empty user.nameEN}">
										                                ${user.nameEN.substring(0, 1).toUpperCase()}
										                            </c:when>
																	<c:when test="${not empty user.name}">
										                                ${user.name.substring(0, 1)}
										                            </c:when>
																	<c:otherwise>?</c:otherwise>
																</c:choose>
															</div>
														</c:otherwise>
													</c:choose>
												</div>

												<%-- User information --%>
												<div class="fs-6 text-gray-900 lh-sm ">
													${user.employeeId} - ${user.name}</div>

											</div>
										</div>

										<div class="col-12 col-md-6 d-flex align-items-center">
											<div class="d-flex align-items-center gap-3">
												<i class="ki-duotone ki-calendar-2 fs-1"> <span
													class="path1"></span> <span class="path2"></span> <span
													class="path3"></span> <span class="path4"></span> <span
													class="path5"></span>
												</i>
												<div class="fs-6 text-gray-800">
													<fmt:formatDate value="${redeem.timeCreate}"
														pattern="dd MMM yyyy , H:mm" />
												</div>
											</div>
										</div>

										<div class="col-12 col-md-6 ">
											<div
												class="d-flex align-items-center gap-3 productTypeContainer"></div>
										</div>

										<div class="col-12 col-md-6">
											<div class="d-flex align-items-center gap-3">
												<i class="ki-duotone ki-parcel fs-1"> <span
													class="path1"></span> <span class="path2"></span> <span
													class="path3"></span> <span class="path4"></span> <span
													class="path5"></span>
												</i>
												<div class="fs-5 text-gray-900">${item.itemName}</div>
											</div>
										</div>
									</div>

									<div class="separator separator-dashed my-14 border-gray-300 "></div>

									<div>
										<label for="reason" class="required form-label fw-medium">Reason</label>
										<textarea class="form-control" id="reason" rows="3"
											placeholder="Enter the reason for cancelling this request..."></textarea>
									</div>

								</div>

								<div class="modal-footer border-0">
									<button type="button" class="btn btn-light"
										data-bs-dismiss="modal">Close</button>
									<button type="button" class="btn btn-dark ms-2"
										data-redeem_id="${redeem.userRedeemId}" id="confirmCancelBtn">Confirm
										Cancel</button>
								</div>
							</div>
						</div>
					</div>

					<div class="d-flex align-items-center justify-content-between mt-8">
						<a href="privilegeHistoryManagement" class="btn btn-bg-light">Back</a>
						<div class="action-btn-group d-flex align-items-center gap-5"></div>
					</div>

				</div>

			</div>
		</div>
	</div>

	<script
		src="${pageContext.request.contextPath}/assets/js/custom/utilities/attachFile/attcahfile.js"></script>
	<script>
	
		let carouselImagePaths = [];
	    let currentImageIndex = 0;
	    
	    let isDragging = false;
	    let dragStartX = 0;
	    let scrollStartLeft = 0;
	    
	    const item = ${itemJSON};
	    const product = ${productJSON};
	    const redeem = ${redeemJSON};
    	const statusMap = ${statusMapJSON};
    	const user = ${userJSON};
    	
	    const nextStatus = {
		    "1" : "2", // pending -> approved
		    "2" : "3", // approved -> receivedF
		    "3" : "4" // received -> completed
	    }
	    
	    let signaturePreviewUrl = null;
	    const canEditRedeem = ${canEditRedeem == true};
	    const isOwner = ${isOwner == true};
	
		$(document).ready(function() {

			if (canEditRedeem) {
                statusMap["3"].statusName = "Waiting for receive";
            } 

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
			
			$(document).on("click", "#actionBtn", updateRedeemStatus);
			
			$("#itemDetails").html(escapeHtml(item.details).replace(/\r\n/g, "<br>").replace(/\n/g, "<br>"));
			$("#statusBadge").addClass(`badge-\${statusMap[redeem.redeemStatus].color}`).text(statusMap[redeem.redeemStatus].statusName);
			
			renderProductType(product, $(".productTypeContainer"));
			
			$(document).on("click", "#cancelBtn", function () {

			    const redeemId = $(this).data("redeem-id");

			    if (!redeemId) {
		            console.log(redeemId);	
			        console.error("Missing redeemId.");
			        return;
			    }

			    $("#reason").val("");

			    $("#confirmCancelBtn").data("redeem-id", redeemId);

			    // เปิด Bootstrap Modal
			    const cancelModal = new bootstrap.Modal(
			        document.getElementById("cancelRequestModal")
			    );

			    cancelModal.show();
			});
			
			$(document).on("click", "#confirmCancelBtn", function () {

				const redeemId = $(this).data("redeem-id");
				const reason = $("#reason").val().trim();
				
				cancelRedeemRequest(redeemId, reason);
			
			});
			
			$("#confirmDeliverBtn").on("click", function () {
			    const remark = $("#remark").val().trim();
			    const redeemId = $(this).data("redeem-id");

			    deliverRedeemRequest(redeemId, remark);
			});
			
			$(document).on("change", "#signatureInput", function () {
			    const file = this.files && this.files[0];

			    if (!file) {
			        return;
			    }

			    // Validate file type
			    const allowedTypes = ["image/png", "image/jpeg"];

			    if (!allowedTypes.includes(file.type)) {
			        Swal.fire({
			            icon: "warning",
			            title: "Invalid file type",
			            text: "Please select a PNG, JPG, or JPEG image."
			        });

			        this.value = "";
			        return;
			    }

			    // Release previous preview URL
			    if (signaturePreviewUrl) {
			        URL.revokeObjectURL(signaturePreviewUrl);
			    }

			    // Create preview URL
			    signaturePreviewUrl = URL.createObjectURL(file);

			    $("#signaturePreview").attr("src", signaturePreviewUrl);

			    $("#signatureUploadArea").addClass("d-none");
			    $("#signaturePreviewContainer").removeClass("d-none");

			    // ยังไม่เปิดปุ่ม Complete จนกว่าจะบันทึก Signature สำเร็จ
			    $("#actionBtn").prop("disabled", false);
			});

			$(document).on("click", "#removeSignatureBtn", function () {
			    const input = document.getElementById("signatureInput");

			    // Clear selected file
			    input.value = "";

			    // Release preview URL
			    if (signaturePreviewUrl) {
			        URL.revokeObjectURL(signaturePreviewUrl);
			        signaturePreviewUrl = null;
			    }

			    $("#signaturePreview").attr("src", "");
			    $("#signaturePreviewContainer").addClass("d-none");
			    $("#signatureUploadArea").removeClass("d-none");

			    // ยังไม่มี Signature จึงไม่ให้ Complete
			    $("#actionBtn").prop("disabled", true);
			});
			
			renderRequestDetails(product);
			renderRedeemStatusLog(redeem);
			renderActionButton();
			renderCarouselImages(item);
			renderSignatureCard();
			
			
		});

		async function compressImage(file, maxWidth = 1280, maxHeight = 1280, quality = 0.8) {
			if (!file.type.match(/image\/(jpeg|jpg|png)/)) {
				return file;
			}

			return new Promise((resolve, reject) => {
				const reader = new FileReader();
				reader.readAsDataURL(file);
				reader.onload = event => {
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

						const canvas = document.createElement('canvas');
						canvas.width = width;
						canvas.height = height;
						const ctx = canvas.getContext('2d');
						ctx.drawImage(img, 0, 0, width, height);

						canvas.toBlob((blob) => {
							if (blob) {
								const newFileName = file.name.replace(/\.[^/.]+$/, ".jpg");
								const newFile = new File([blob], newFileName, {
									type: 'image/jpeg',
									lastModified: Date.now()
								});
								resolve(newFile);
							} else {
								resolve(file);
							}
						}, 'image/jpeg', quality);
					};
					img.onerror = error => reject(error);
				};
				reader.onerror = error => reject(error);
			});
		}
		
		
		function renderSignatureCard() {
		    const $card = $("#signatureCard");
		    const $body = $("#signatureCardBody");
		
		    // Reset card
		    $card.addClass("d-none");
		    $body.empty();
		
		    const currentStatus = String(redeem.redeemStatus);
		    let signaturePath = null;
		    let canUploadSignature = false;
		
		    // ตรวจสอบสถานะและสิทธิ์
		    if (currentStatus === "3") {
		        // Received: เฉพาะเจ้าของคำขอเท่านั้นที่อัปโหลด Signature ได้
		        if (!isOwner) {
		            return;
		        }
		
		        signaturePath = user?.signaturePath || null;
		        canUploadSignature = true;
		
		    } else if (currentStatus === "4") {
		        // Completed: แสดง Signature ที่บันทึกไว้ในคำขอนี้
		        signaturePath = redeem.signaturePath || null;
		
		        // ถ้ายังไม่มี Signature ในคำขอที่ Completed แล้ว ไม่ต้องแสดง Card
		        if (!signaturePath) {
		            return;
		        }
		
		    } else {
		        // สถานะอื่นไม่ต้องแสดง Signature Card
		        return;
		    }
		
		    const formattedDate = redeem.timeReceive
		        ? new Date(redeem.timeReceive).toLocaleString("en-GB", {
		            day: "2-digit",
		            month: "short",
		            year: "numeric",
		            hour: "2-digit",
		            minute: "2-digit",
		            hour12: false
		        })
		        : "";
		
		    // กรณีมี Signature ให้แสดงรูป
		    if (signaturePath) {
		        $body.html(`
		            <div class="row gx-5">
		                <div class="col-12 col-md-6">
		                    <div class="d-flex align-items-center justify-content-center">
		                        <img
		                            src="${pageContext.request.contextPath}\${signaturePath}"
		                            alt="User Signature"
		                            class="img-fluid"
		                            style="max-height: 200px; object-fit: contain;"
		                        >
		                    </div>
		                </div>
		
		                <div class="col-12 col-md-6">
		                    <div class="d-flex align-items-center justify-content-center h-100">
		                        <div class="text-center">
		                            <div class="text-primary fw-medium fs-4 mb-3">
		                                ชื่อ ผู้รับ
		                            </div>
		
		                            <div class="fw-medium text-gray-900 mb-2">
		                                \${escapeHtml(user.name || "")}
		                            </div>
		
		                            <div class="fw-medium text-gray-900">
		                                \${formattedDate}
		                            </div>
		                        </div>
		                    </div>
		                </div>
		            </div>
		        `);
		
		        $card.removeClass("d-none");
		        return;
		    }
		
		    // สถานะ Received และเจ้าของคำขอยังไม่มี Signature
		    if (canUploadSignature) {
		        $body.html(`
		            <div class="row gx-5 align-items-center">
		
		                <!-- Signature Upload / Preview -->
		                <div class="col-12 col-md-6">
		                    <div class="d-flex flex-column align-items-center gap-3">
		                        <div class="position-relative w-100">
		
		                            <!-- Upload Area -->
		                            <label
		                                for="signatureInput"
		                                id="signatureUploadArea"
		                                class="d-flex flex-column align-items-center
		                                       justify-content-center border border-dashed
		                                       border-gray-400 rounded-3 p-8 text-center w-100"
		                                style="height: 200px; cursor: pointer;"
		                            >
		                                <i class="ki-duotone ki-cloud-add fs-2x">
		                                    <span class="path1"></span>
		                                    <span class="path2"></span>
		                                </i>
		
		                                <span class="text-gray-500 fs-8 mt-2">
		                                    Click to upload Signature
		                                </span>
		                            </label>
		
		                            <!-- Image Preview -->
		                            <div
		                                id="signaturePreviewContainer"
		                                class="position-relative d-none border border-gray-300 rounded-3 w-100"
		                                style="height: 200px;"
		                            >
		                                <img
		                                    id="signaturePreview"
		                                    src=""
		                                    alt="Signature Preview"
		                                    class="w-100 h-100 rounded-3"
		                                    style="object-fit: contain;"
		                                >
		
		                                <!-- Cancel Preview -->
		                                <button
		                                    type="button"
		                                    id="removeSignatureBtn"
		                                    class="btn btn-icon btn-sm btn-light
		                                           position-absolute rounded-circle shadow-sm"
		                                    style="top: 8px; right: 8px; z-index: 2;"
		                                    aria-label="Remove signature"
		                                    title="Remove signature"
		                                >
		                                    <i class="ki-duotone ki-cross fs-2">
		                                        <span class="path1"></span>
		                                        <span class="path2"></span>
		                                    </i>
		                                </button>
		                            </div>
		
		                            <input
		                                type="file"
		                                id="signatureInput"
		                                accept=".png,.jpg,.jpeg,image/png,image/jpeg"
		                                class="d-none"
		                            >
		                        </div>
		
		                        <div class="text-gray-500 fs-8 text-center">
		                            Allowed: png, jpg, jpeg
		                        </div>
		                    </div>
		                </div>
		
		                <!-- User Information -->
		                <div class="col-12 col-md-6">
		                    <div class="d-flex flex-column align-items-center
		                                justify-content-center text-center">
		
		                        <div class="text-primary mb-3 fw-medium fs-4">
		                            ชื่อ ผู้รับ
		                        </div>
		
		                        <div class="fw-medium text-gray-900 mb-2">
		                            \${escapeHtml(user.name || "")}
		                        </div>
		
		                        <div class="fw-medium text-gray-900">
		                            \${formattedDate}
		                        </div>
		                    </div>
		                </div>
		
		            </div>
		        `);
		
		        // ต้องเลือก Signature ก่อนจึงจะกด Complete ได้
		        $("#actionBtn").prop("disabled", true);
		
		        $card.removeClass("d-none");
		    }
		}

		
		function renderProductType(product, $container) {


	    	if (product) {

            	let iconClass = "d-none";
            	let productTypeText = "N/A";
            	
            	switch (product.productType) {

	            	case "1": 
	            		iconClass = "ki-laptop text-primary";
	            		productTypeText = "Equipment";	
	            		break;
	            	case "2":
	            		iconClass = "ki-element-11 text-warning";
	            		productTypeText = "Consumables";	
	            		break;
	            	case "3":
	            		iconClass = "ki-medal-start text-success";
	            		productTypeText = "Accessories";	
	            		break;
	            		
	            	case "4":
	            		iconClass = "ki-parcel text-info";
	            		productTypeText = "Office Supplies";	
	            		break;
	            		
	            	default:
	            		iconClass = "d-none";
            	}
            	
            	$container.append(`
           				<i class="ki-duotone fs-1 \${iconClass}"> <span class="path1"></span>
           					<span class="path2"></span>
           					<span class="path3"></span>
           					<span class="path4"></span>
           					<span class="path5"></span>
           					<span class="path6"></span>
           				</i>
           				<div class="fs-6 text-gray-900">
           					\${productTypeText} - \${product.productNo} - \${product.productName}
           				</div>
            	`);
            }
	    }

		function renderRedeemStatusLog(redeem) {

			if (!redeem || !redeem.statusLog) {
                return;
            }
			
			try {

				const statusLogs = JSON.parse(redeem.statusLog);
				
				const $redeemLogContainer = $("#redeemLogContainer");
				$redeemLogContainer.empty();
				
				 statusLogs.sort((a, b) =>
		            new Date(b.timeUpdate) - new Date(a.timeUpdate)
		        );
				
				statusLogs.forEach((log, index) => {

					console.log(log)

					const statusCode = log.status;
					const statusInfo  = statusMap[statusCode] || null;
					
					if (!statusInfo) return;
					
					const color = statusInfo.color || "gray-500";
					const statusName = statusInfo.statusName || "N/A";
					
					const date = new Date(log.timeUpdate);
					
					const formattedDate = date.toLocaleString("en-GB", {
	                    day: "2-digit",
	                    month: "short",
	                    year: "numeric",
	                    hour: "2-digit",
	                    minute: "2-digit",
	                    hour12: false
	                });
					
					$redeemLogContainer.append(`
							<div class="timeline-item">
							 	\${index !== statusLogs.length - 1
			                        ? `<div class="timeline-line"></div>`
			                        : ""
			                    }
					
								<div class="timeline-icon">
		                            <i class="ki-duotone ki-cd fs-2 text-\${color}" data-status-type="icon">
		                                <span class="path1"></span><span class="path2"></span>
		                            </i>
		                        </div>
		                        <div class="timeline-content \${index !== statusLogs.length - 1 ? 'mb-12 mb-md-16' : 'mb-4'}">
		                        	<div>
				                        <span class="badge badge-lg badge-\${color} py-2" data-status-type="badge">
			                                \${statusName}
			                            </span>
		                            </div>
		                            <div class="d-flex align-items-center gap-3 mt-5">
			                            <i class="ki-duotone ki-user fs-2">
				                            <span class="path1"></span>
				                            <span class="path2"></span>
			                           </i>
			                           <div class="fw-semibold fs-5 text-gray-800">\${log.displayName}</div>
		                            </div>
		                            
		                           <div class="d-flex align-items-center gap-3 mt-5">
			                           <i class="ki-duotone ki-calendar fs-2">
				                            <span class="path1"></span>
				                            <span class="path2"></span>
			                           </i>
			                           <div class="fw-semibold fs-6 text-gray-800">\${formattedDate}</div>
		                            </div>
		                            
		                            \${log.reason ? `

		                            		<div class="d-flex align-items-center gap-3 mt-5">
			                            		<i class="ki-duotone ki-message-text fs-2">
				                            		 <span class="path1"></span>
				                            		 <span class="path2"></span>
				                            		 <span class="path3"></span>
			                            		</i>
					                           <div class="fw-semibold fs-5 text-gray-800">\${log.reason}</div>
				                            </div>
		                            		
		                            		` : ``}
		                            
		                        </div>
		                        
							</div>
					`)
					
					
				
				});
			} catch (e) {

				console.error("Error parsing statusLog:", e);
				
			}
		
		}
		
		function renderRequestDetails() {

			const $container = $("#requestDetailContainer");
            $container.empty();
            
            if (product) {

            	$container.append(`<div class="separator separator-dashed border-2 border-gray-300"></div>`);
            	
            	let iconClass = "d-none";
            	let productTypeText = "N/A";
            	
            	switch (product.productType) {

	            	case "1": 
	            		iconClass = "ki-laptop text-primary";
	            		productTypeText = "Equipment";	
	            		break;
	            	case "2":
	            		iconClass = "ki-element-11 text-warning";
	            		productTypeText = "Consumables";	
	            		break;
	            	case "3":
	            		iconClass = "ki-medal-start text-success";
	            		productTypeText = "Accessories";	
	            		break;
	            		
	            	case "4":
	            		iconClass = "ki-parcel text-info";
	            		productTypeText = "Office Supplies";	
	            		break;
	            		
	            	default:
	            		iconClass = "d-none";
            	
            	}
            	
            	$container.append(`
           			<div class="d-flex align-items-center gap-3 my-8">
           				<i class="ki-duotone fs-2x \${iconClass}"> <span class="path1"></span>
           					<span class="path2"></span>
           					<span class="path3"></span>
           					<span class="path4"></span>
           					<span class="path5"></span>
           					<span class="path6"></span>
           				</i>
           				<div class="fs-6 text-gray-900">
           					\${productTypeText} - \${product.productNo} - \${product.productName}
           				</div>
           			</div>
           			
           			<div class="separator separator-dashed border-2 border-gray-300"></div>
            	`);
            }
            
            $container.append(`
            	<div class="d-flex align-items-center gap-3 my-8">
            		<div class="fw-semibold fs-5 text-primary">ระยะเวลาการแลก:</div>
            		<div class="fs-5 text-gray-800">
            			\${formatDate(item.startDate)} - \${formatDate(item.endDate)}
            		</div>
            	</div>	
            	
            	<div class="separator separator-dashed border-2 border-gray-300"></div>
            	
            	<div class="d-flex align-items-center justify-content-between w-100 mt-8 mb-6">
            		<div class="fs-6 text-gray-700">ใช้แลกของรางวัล</div>
            		<div class="d-flex align-items-center gap-3">
	            		<i class="ki-duotone ki-cube-2 fs-1 text-primary">
	            		 <span class="path1"></span>
	            		 <span class="path2"></span>
	            		 <span class="path3"></span>
	            		</i>
            			<div class="fw-bold fs-3 text-gray-800">\${parseInt(${redeem.token})}</div>
            		</div>
            	</div>
            	
            	<div class="d-flex align-items-center justify-content-between w-100 ">
        		<div class="fs-6 text-gray-700">+ เพิ่มเงิน</div>
        		<div class="d-flex align-items-center gap-3">
	        		<i class="ki-duotone ki-text-bold fs-1">
	        		 <span class="path1"></span>
	        		 <span class="path2"></span>
	        		 <span class="path3"></span>
	        		</i>
        			<div class="fw-bold fs-3 text-gray-800">&#3647; \${parseInt(${redeem.cash})}</div>
        		</div>
        	</div>
            `)
            
            if (!canEditRedeem || isOwner) {

            	$container.append(`
            		<div class="d-flex align-items-center gap-2 py-2 px-3 rounded border border-light-info bg-light-info mt-8">
            			<i class="ki-duotone ki-information-3 fs-1 text-info">
            			 <span class="path1"></span>
            			 <span class="path2"></span>
            			 <span class="path3"></span>
            			</i>
            			<div class="fs-6 fw-medium text-info">หากต้องการยกเลิกการแลกของรางวัล กรุณาติดต่อฝ่าย HR</div>
            		</div>
            	`);
            	
            	
            	
            }
			
		}
		
		function renderActionButton() {

		    const $actionBtnGroup = $(".action-btn-group");
		    $actionBtnGroup.empty();

		    const currentStatus = redeem.redeemStatus;
		    const nextStatusCode = nextStatus[currentStatus];

		    if (!nextStatusCode) {
		        return;
		    }

		    // Pending -> Approved
		    if (currentStatus === "1") {

		        if (!canEditRedeem) {
		            return;
		        }

		        $actionBtnGroup.append(`
		            <button type="button"
		                    class="btn btn-dark"
		                    id="cancelBtn"
		                    data-redeem-id="\${redeem.userRedeemId}">
		                Cancel
		            </button>

		            <button type="button"
		                    class="btn btn-\${statusMap["2"].color}"
		                    id="actionBtn"
		                    data-redeem-id="\${redeem.userRedeemId}"
		                    data-next-status="2">
		                Approve
		            </button>
		        `);

		        return;
		    }

		    // Approved -> Received
		    if (currentStatus === "2") {

		    	if (!canEditRedeem) {
                    return;
                }

		        $actionBtnGroup.append(`
	                <button type="button"
	                        class="btn btn-dark"
	                        id="cancelBtn"
	                        data-redeem-id="\${redeem.userRedeemId}">
	                    Cancel
	                </button>

		            <button type="button"
		                    class="btn btn-\${statusMap["3"].color}"
		                    id="actionBtn"
		                    data-redeem-id="\${redeem.userRedeemId}"
		                    data-next-status="3">
		                Deliver
		            </button>
		        `);

		        return;
		    }

		    // Received -> Completed
		    if (isOwner && currentStatus === "3") {

		        $actionBtnGroup.append(`
		            <button type="button"
		                    class="btn btn-cyan"
		                    id="actionBtn"
		                    data-redeem-id="\${redeem.userRedeemId}"
		                    data-next-status="4">
		                Receive
		            </button>
		        `);

		        return;
		    }
		}
		
		function deliverRedeemRequest(redeemId, remark) {
		    if (!redeemId) {
		        console.error("Missing redeemId.");
		        return;
		    }

		    Swal.fire({
		        title: "Confirm Delivery",
		        text: "Are you sure you want to update the redeem status to Delivered?",
		        icon: "question",
		        showCancelButton: true,
		        confirmButtonText: "Confirm",
		        cancelButtonText: "Cancel",
		        buttonsStyling: false,
		        reverseButtons: true,
		        customClass: {
		            confirmButton: "btn btn-primary",
		            cancelButton: "btn btn-light"
		        }
		    }).then((result) => {
		        if (!result.isConfirmed) {
		            return;
		        }

		        // Show loading
		        Swal.fire({
		            title: "Updating...",
		            text: "Please wait while the redeem status is being updated.",
		            allowOutsideClick: false,
		            allowEscapeKey: false,
		            showConfirmButton: false,
		            didOpen: () => {
		                Swal.showLoading();
		            }
		        });

		        $.ajax({
		            url: "updateRedeemStatus",
		            type: "POST",
		            data: {
		                redeemId: redeemId,
		                statusCode: "3",
		                reason: remark
		            },
		            success: function (response) {
		                Swal.fire({
		                    title: "Success",
		                    text: "Redeem status updated successfully.",
		                    icon: "success",
		                    confirmButtonText: "OK",
		                    buttonsStyling: false,
		                    customClass: {
		                        confirmButton: "btn btn-success"
		                    }
		                }).then((result) => {
		                    if (result.isConfirmed) {
		                        const modalElement =
		                            document.getElementById("deliveryModal");

		                        const modal =
		                            bootstrap.Modal.getOrCreateInstance(modalElement);

		                        modal.hide();
		                        location.reload();
		                    }
		                });
		            },
		            error: function (xhr) {
		                let message = "Unable to update redeem status.";

		                try {
		                    const response = JSON.parse(xhr.responseText);
		                    if (response.message) {
		                        message = response.message;
		                    }
		                } catch (e) {
		                    console.error("Unable to parse error response:", e);
		                }

		                Swal.fire({
		                    title: "Error",
		                    text: message,
		                    icon: "error",
		                    confirmButtonText: "OK",
		                    buttonsStyling: false,
		                    customClass: {
		                        confirmButton: "btn btn-danger"
		                    }
		                });
		            }
		        });
		    });
		}
		

		function cancelRedeemRequest(redeemId, reason) {
		    if (!redeemId) {
		        console.error("Missing redeemId.");
		        return;
		    }

		    if (!reason) {
		        console.error("Missing reason.");
		        return;
		    }

		    // Confirm before canceling
		    Swal.fire({
		        title: "Cancel Redeem Request",
		        text: "Are you sure you want to cancel this redeem request?",
		        icon: "warning",
		        showCancelButton: true,
		        confirmButtonText: "Yes, cancel it",
		        cancelButtonText: "No, keep it",
		        buttonsStyling: false,
		        reverseButtons: true,
		        customClass: {
		            confirmButton: "btn btn-danger",
		            cancelButton: "btn btn-light"
		        }
		    }).then((result) => {
		        if (!result.isConfirmed) {
		            return;
		        }

		        // Show loading while waiting for AJAX
		        Swal.fire({
		            title: "Canceling...",
		            text: "Please wait while the redeem request is being canceled.",
		            allowOutsideClick: false,
		            allowEscapeKey: false,
		            showConfirmButton: false,
		            didOpen: () => {
		                Swal.showLoading();
		            }
		        });

		        $.ajax({
		            url: "cancelRedeemRequest",
		            type: "POST",
		            data: {
		                redeemId: redeemId,
		                statusCode: "5",
		                reason: reason
		            },

		            success: function (response) {
		                Swal.fire({
		                    title: "Success",
		                    text: "Redeem request canceled successfully.",
		                    icon: "success",
		                    confirmButtonText: "OK",
		                    buttonsStyling: false,
		                    customClass: {
		                        confirmButton: "btn btn-success"
		                    }
		                }).then((result) => {
		                    if (result.isConfirmed) {
		                        location.reload();
		                    }
		                });
		            },

		            error: function (xhr) {
		                let message = "Unable to cancel redeem request.";

		                try {
		                    const response = JSON.parse(xhr.responseText);
		                    if (response.message) {
		                        message = response.message;
		                    }
		                } catch (e) {
		                    console.error("Unable to parse error response:", e);
		                }

		                Swal.fire({
		                    title: "Error",
		                    text: message,
		                    icon: "error",
		                    confirmButtonText: "OK",
		                    buttonsStyling: false,
		                    customClass: {
		                        confirmButton: "btn btn-danger"
		                    }
		                });
		            }
		        });
		    });
		}

		
		function updateRedeemStatus(reason) {

		    const $actionBtn = $(this);
		    const redeemId = $actionBtn.data("redeem-id");
		    const nextStatus = $actionBtn.data("next-status");

		    if (!redeemId) {
		        console.error("Missing redeemId.");
		        return;
		    }

		    if (!nextStatus) {
		        console.error("Missing nextStatus.");
		        return;
		    }
		    
		 // แนบ Signature เฉพาะ Received (3) -> Completed (4)
		    const isCompleting = String(redeem.redeemStatus) === "3"
		        && String(nextStatus) === "4";
		 
		    const isDelivering = String(redeem.redeemStatus) === "2"
		        && String(nextStatus) === "3";
		    
		 // ถ้าเป็นการ Deliver ให้เปิด Modal แทน
		    if (isDelivering) {
		        const modalElement = document.getElementById("deliveryModal");
		        const modal = bootstrap.Modal.getOrCreateInstance(modalElement);
		        modal.show();
		        return;
		    }


		    let signatureFile = null;

		    if (isCompleting) {
		        const input = document.getElementById("signatureInput");
		        signatureFile = input?.files?.[0];

		        if (!signatureFile && !user?.signaturePath) {
		            Swal.fire({
		                title: "Signature Required",
		                text: "Please upload your signature before completing the request.",
		                icon: "warning",
		                confirmButtonText: "OK",
		                buttonsStyling: false,
		                customClass: {
		                    confirmButton: "btn btn-primary"
		                }
		            });
		            return;
		        }
		    }

		    Swal.fire({
		        title: "Confirm Status Change",
		        text: "Are you sure you want to change the redeem status?",
		        icon: "question",
		        showCancelButton: true,
		        confirmButtonText: "Confirm",
		        reverseButtons: true,
		        cancelButtonText: "Cancel",
		        buttonsStyling: false,
		        customClass: {
		            confirmButton: "btn btn-primary",
		            cancelButton: "btn btn-light"
		        }
		    }).then((result) => {

		        if (!result.isConfirmed) {
		            return;
		        }

		        // Show loading
		        Swal.fire({
		            title: "Updating...",
		            text: "Please wait while the redeem status is being updated.",
		            allowOutsideClick: false,
		            allowEscapeKey: false,
		            showConfirmButton: false,
		            didOpen: () => {
		                Swal.showLoading();
		            }
		        });
		        
		        const formData = new FormData();
		        formData.append("redeemId", redeemId);
		        formData.append("statusCode", nextStatus);

		        if (isCompleting && signatureFile) {
		            formData.append("signature", signatureFile);
		        }
		        
		        $.ajax({
		            url: "updateRedeemStatus",
		            type: "POST",
		            data: formData,
		            processData: false,
		            contentType: false,
		            
		            success: function (response) {

		                Swal.close();

		                Swal.fire({
		                    title: "Success",
		                    text: "Redeem status updated successfully.",
		                    icon: "success",
		                    confirmButtonText: "OK",
		                    buttonsStyling: false,
		                    customClass: {
		                        confirmButton: "btn btn-success"
		                    }
		                }).then(() => {

		                    // Reload page
		                    location.reload();

		                });
		            },

		            error: function (xhr) {

		                Swal.close();

		                let message = "Unable to update redeem status.";

		                try {
		                    const response = JSON.parse(xhr.responseText);

		                    if (response.message) {
		                        message = response.message;
		                    }
		                } catch (e) {
		                    console.error("Unable to parse error response:", e);
		                }

		                Swal.fire({
		                    title: "Error",
		                    text: message,
		                    icon: "error",
		                    confirmButtonText: "OK",
		                    buttonsStyling: false,
		                    customClass: {
		                        confirmButton: "btn btn-danger"
		                    }
		                });

		            }
		        });

		    });
		}
		
		function formatDate(timestamp) {
	        const date = new Date(timestamp);

	        const day = date.getDate();
	        const month = date.toLocaleString("en-US", { month: "short" });
	        const year = String(date.getFullYear()).slice(-2);

	        return `\${day} \${month} \${year}`;
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
	</script>
</body>
</html>