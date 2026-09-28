<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Contact Detail</title>

<!-- Metronic core -->
<link
	href="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.css"
	rel="stylesheet"
	type="text/css" />

<script
	src="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.js">
</script>

<!-- SweetAlert -->
<link
	rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css">

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js">
</script>
</head>

<body>

	<div class="app-main flex-column px-16">

		<!-- Toolbar -->
		<div class="page-title">

			<h1 class="page-heading text-gray-700 fw-semibold">
				Contact Detail
			</h1>

			<ul
				class="list-unstyled d-inline-flex gap-2 text-muted fs-7 fw-medium">

				<li>Dashboard</li>
				<li>-</li>
				<li>Contact</li>

			</ul>

		</div>


		<!-- Contact Form -->
		<form id="contactForm" method="post" enctype="multipart/form-data"
			action="${pageContext.request.contextPath}/contact_save.action">
			<input type="hidden" name="contact.companyContactId"
				value="<c:out value="${contact.companyContactId}" />">
			<input type="hidden" id="contact_is_active"
				name="contact.isActive"
				value="<c:out value="${empty contact.isActive ? '1' : contact.isActive}" />">
			<input type="hidden" id="contact_company_address_id"
				name="contact.companyAddressId"
				value="<c:out value="${contact.companyAddressId}" />">
			<input type="hidden" id="hidden_freelancer_address"
				name="freelancerAddress" value="">
			<input type="hidden" id="hidden_freelancer_google_map"
				name="freelancerGoogleMap" value="">
			<input type="hidden" id="hidden_freelancer_address_name"
                name="freelancerAddressName" value="">
			<input type="hidden" id="contact_freelancer_company_id"
				name="freelancerRealCompanyId"
				value="<c:out value="${isFreelancerContact ? contact.companyId : ''}" />">
			<input type="hidden" id="contact_profile_image"
               name="existingProfileImagePath"
               value="<c:out value="${profileImage}" />">
			<input type="hidden" id="remove_profile_image"
				name="removeProfileImage" value="">
				
				
			

			<div class="row g-8"> 

				<!-- Personal Information -->
				<div class="col-xl-8">

					<div class="card shadow-sm">

						<div
							class="card-header d-flex justify-content-between align-items-center">

							<h3 class="card-title fw-semibold text-gray-900">
								Personal Information
							</h3>

							<div class="d-flex align-items-center gap-3">

								<span class="text-gray-700 fw-medium">
									Active
								</span>

								<div
									class="form-check form-switch form-check-custom form-check-success">

									<input class="form-check-input h-20px w-35px js-toggle-enable"
										type="checkbox" id="active_weerawat.p"
										data-userid="weerawat.p" data-enable="1"
										${empty contact.companyContactId or contact.isActive eq '1' ? 'checked' : ''}>
								</div>																					

							</div>

						</div>
					
					


						<div class="card-body">

							<!-- Profile Image -->
							<div class="text-center mb-10">

								<div
									class="symbol symbol-150px symbol-square position-relative mx-auto">

										<img
										id="profile_preview"
										style="width:150px; height:150px; object-fit:cover; object-position: center top;"
										src="<c:choose><c:when test="${not empty profileImage}">${pageContext.request.contextPath}${profileImage}
										</c:when><c:otherwise>${pageContext.request.contextPath}/assets/media/avatars/blank.png</c:otherwise></c:choose>"
										alt="Profile">

									<label
										for="profile_image"
										class="btn btn-icon btn-circle btn-active-color-primary w-30px h-30px bg-body shadow position-absolute top-0 end-0">

										<i class="ki-duotone ki-pencil fs-4">
											<span class="path1"></span>
											<span class="path2"></span>
										</i>

									</label>


									<button
										type="button"
										id="remove_profile"
										class="btn btn-icon btn-circle btn-active-color-danger w-30px h-30px bg-body shadow position-absolute bottom-0 end-0">

										<i class="ki-duotone ki-cross fs-4">
											<span class="path1"></span>
											<span class="path2"></span>
										</i>

									</button>


									<input
										type="file"
										id="profile_image"
										name="profileImage"
										accept=".png,.jpg,.jpeg"
										class="d-none">

								</div>

								<div class="text-muted fs-7 mt-3">
									Allowed file types: png, jpg, jpeg.
								</div>

							</div>


							<!-- Thai Name -->
							<div class="row g-5 mb-5">

								<div class="col-md-3">

									<label
										for="title_th"
										class="required form-label fw-medium">

										คำนำหน้า

									</label>

									<select
										id="title_th"
										name="contact.titleNameTh"
										class="form-select py-4">

										<option value="">เลือก</option>
										<option value="นาย"
											${contact.titleNameTh eq 'นาย' ? 'selected' : ''}>นาย</option>
										<option value="นาง"
											${contact.titleNameTh eq 'นาง' ? 'selected' : ''}>นาง</option>
										<option value="นางสาว"
											${contact.titleNameTh eq 'นางสาว' ? 'selected' : ''}>นางสาว</option>

									</select>

								</div>


								<div class="col-md-9">

									<label
										for="full_name_th"
										class="required form-label fw-medium">

										ชื่อ สกุล

									</label>

									<input
										type="text"
										id="full_name_th"
										name="contact.contactNameTh"
										class="form-control py-4"
										value="<c:out value="${contact.contactNameTh}" />"
										placeholder="ชื่อและนามสกุล">

								</div>

							</div>


							<!-- English Name -->
							<div class="row g-5 mb-5">

								<div class="col-md-3">

									<label
										for="title_en"
										class="required form-label fw-medium">

										Title Name

									</label>

									<select
										id="title_en"
										name="contact.titleNameEn"
										class="form-select py-4">

										<option value="">Select</option>
										<option value="Mr."
											${contact.titleNameEn eq 'Mr.' ? 'selected' : ''}>Mr.</option>
										<option value="Mrs."
											${contact.titleNameEn eq 'Mrs.' ? 'selected' : ''}>Mrs.</option>
										<option value="Ms."
											${contact.titleNameEn eq 'Ms.' ? 'selected' : ''}>Ms.</option>

									</select>

								</div>


								<div class="col-md-9">

									<label
										for="full_name_en"
										class="required form-label fw-medium">

										Full Name EN

									</label>

									<input
										type="text"
										id="full_name_en"
										name="contact.contactName"
										class="form-control py-4"
										value="<c:out value="${contact.contactName}" />"
										placeholder="Full Name EN">

								</div>

							</div>


							<!-- Position -->
							<div class="mb-5">

								<label
									for="position"
									class="required form-label fw-medium">

									Position

								</label>

								<input
									type="text"
									id="position"
									name="contact.position"
									class="form-control py-4"
									value="<c:out value="${contact.position}" />"
									placeholder="Position">

							</div>


							<!-- Phone and Email -->
							<div class="row g-5">

								<div class="col-md-6">

									<label
										for="phone"
										class="required form-label fw-medium">

										Phone Number

									</label>

									<input
										type="text"
										id="phone"
										name="contact.phone"
										class="form-control py-4"
										value="<c:out value="${contact.phone}" />"
										placeholder="Phone Number">

								</div>


								<div class="col-md-6">

									<label
										for="email"
										class="required form-label fw-medium">

										E-Mail

									</label>

									<input
										type="email"
										id="email"
										name="contact.email"
										class="form-control py-4"
										value="<c:out value="${contact.email}" />"
										placeholder="E-Mail">

								</div>

							</div>

						</div>

					</div>

				</div>
				
				


				<!-- Company Information -->
				<div class="col-xl-4">

					<div class="card shadow-sm">

						<div class="card-header">
							<h3 class="card-title fw-semibold text-gray-900">Company
								Information</h3>
						</div>

						<div class="card-body">

							<!-- Company Logo -->
							<div class="text-center mb-7">

								<div class="image-input image-input-empty image-input-outline"
									data-kt-image-input="true">

										<div id="company_logo_preview"
										class="image-input-wrapper w-100px h-100px d-flex align-items-center justify-content-center">

										<c:choose>
											<c:when test="${not empty companyLogoPath}">
												<img src="${pageContext.request.contextPath}${companyLogoPath}"
													class="w-100 h-100 object-fit-cover rounded" alt="Company Logo">
											</c:when>
											<c:otherwise>
												<i class="ki-duotone ki-picture fs-5x text-gray-300"> <span
													class="path1"></span> <span class="path2"></span>
												</i>
											</c:otherwise>
										</c:choose>

									</div>

									<label
										class="btn btn-icon btn-circle btn-active-color-primary w-25px h-25px bg-body shadow"
										data-kt-image-input-action="change" data-bs-toggle="tooltip"
										title="Change logo"> <i
										class="ki-duotone ki-pencil fs-7"> <span class="path1"></span>
											<span class="path2"></span>
									</i> <input type="file" id="company_logo" name="companyLogo"
										accept=".png,.jpg,.jpeg">

									</label> <span id="remove_company_logo"
										class="btn btn-icon btn-circle btn-active-color-primary w-25px h-25px bg-body shadow"
										data-kt-image-input-action="remove" data-bs-toggle="tooltip"
										title="Remove logo"> <i
										class="ki-duotone ki-cross fs-2"> <span class="path1"></span>
											<span class="path2"></span>
									</i>

									</span>

								</div>

								<div class="form-text mt-3">Allowed file types: png, jpg, jpeg.</div>

							</div>


							<!-- Company -->
							
                            <div class="mb-7">
                           <label class="form-label fw-medium"> Company </label>
                            <select id="company_id" name="contact.companyId"
                                   class="form-select py-4" data-control="select2">
                             <option value="" data-tax="">Select </option> 
                              <c:forEach items="${companyList}" var="companyList">
                               <c:set var="optCompanyId">${companyList.company_id}</c:set>
                                 <option value="${companyList.company_id}"
                                    data-tax="${companyList.tax_number}"
                                    data-logo="${companyList.file_path}"
                                    ${contact.companyId eq optCompanyId ? 'selected' : ''}>
                                    ${companyList.company_en}
                                  </option>
                                </c:forEach>
                                           <option value="freelancer" data-tax="" ${contact.companyId eq 'freelancer' ? 'selected' : ''}>Freelancer </option>
                                            
                                            
                               </select>
                               </div>

							<!-- Company Detail -->
							<div id="company_detail" style="display: none;">
								

								<!-- Tax -->
								<div class="mb-7">
									<label class="fw-semibold">Tax ID :</label> <span
										id="company_tax"></span>
								</div>

								<!-- Location -->
								<div class="mb-7">

									<label class="form-label fw-medium"> Location </label> <select
										id="company_location_id" class="form-select py-4">

									</select>

								</div>

								<!-- Address -->
                                <div class="d-flex align-items-center mb-7">
	                             <i class="ki-duotone ki-map fs-2x text-gray-400 me-4 mt-1"> 
	                             <span class="path1"></span> <span class="path2"></span><span class="path3"></span>
	                             </i> <span id="selected_company_address"></span>
	                             </div>

                                  <!-- Google Map -->
                                 <div id="selected_company_map_row" class="d-flex align-items-center mb-7">
                                 <i class="ki-duotone ki-geolocation fs-2x text-gray-400 me-4 mt-1"> 
                                 <span class="path1"></span> <span class="path2"></span>
                                 </i> <a id="selected_company_map" href="" target="_blank"> </a>
                                 </div>
                                   </div>
							

							<!-- ข้อมูลสำหรับ Freelancer -->
							<div id="freelancer_section" style="display: none;">

																<!-- Company Name EN -->
								<div class="mb-7">

									<label for="company_name_en" class="form-label fw-medium required">
										Company Name EN </label>

									<input type="text" id="company_name_en"
										name="freelancerCompanyNameEn" class="form-control py-4"
										value="<c:out value="${freelancerCompanySharedInfo.companyEn}" />"
										placeholder="Company Name EN">

								</div>


								<!-- Company Name TH -->
								<div class="mb-7">
								<label for="company_name_th" class="form-label fw-medium">
                                Company Name TH </label> <input type="text" id="company_name_th"
                                name="freelancerCompanyNameTh" class="form-control py-4"
                                value="<c:out value="${freelancerCompanySharedInfo.companyTh}" />"
                                placeholder="Company Name TH">

									
								</div>


								<!-- Location -->
								<div class="mb-7">

									<label for="location_name"
										class="form-label fw-medium required"> Location </label>

									<div class="input-group">

										<input type="text" id="location_name"
											class="form-control py-4"
											value="<c:out value="${freelancerAddressInfo.addressName}" />"
											placeholder="Location">

										<button type="button" id="select_location_btn"
											class="btn btn-primary">

											<i class="ki-duotone ki-pencil fs-2"> <span class="path1"></span>
												<span class="path2"></span>
											</i>

										</button>

									</div>

								</div>
								
								
								 <!-- Address -->
                             <div class="d-flex align-items-center mb-7">
                              <i class="ki-duotone ki-map fs-2x text-gray-400 me-4 mt-1">
	                            <span class="path1"></span> <span class="path2"></span><span class="path3"></span> </i>
                                     <div id="freelancer_address" class="text-gray-700 lh-lg">
                                        <c:out value="${freelancerAddressInfo.address}" />
                                      </div>
                                         </div>
	                                    
	                            <!-- Google Maps Link -->
													<div id="company_map_row" class="d-flex align-items-center mb-7">
						  <i class="ki-duotone ki-geolocation fs-2x text-gray-400 me-4 mt-1">							    <span class="path1"></span> 
							    <span class="path2"></span>
                                 </i> 
                                 <a id="company_map_link" href="<c:out value="${freelancerAddressInfo.googleMap}" />" target="_blank"
                                 class="text-gray-700 text-hover-primary text-break">
                                 <c:out value="${freelancerAddressInfo.googleMap}" />
                                   </a>
                                </div>                                                   

							</div> 

						</div>

					</div>

				</div>

				<!-- Footer Buttons -->
			<div
				class="d-flex justify-content-end align-items-center gap-3 mt-8 mb-10">

				<button
					type="button"
					id="close_btn"
					class="btn btn-light">

					Close

				</button>

				<button
					type="submit"
					id="save_btn"
					class="btn btn-success">

					Save

				</button>

			</div>

				</form>

	   </div>
	

	<!-- Customer Address Modal -->
	<div
		class="modal fade"
		id="customerAddressModal"
		tabindex="-1"
		aria-labelledby="customerAddressModalLabel"
		aria-hidden="true">

		<div class="modal-dialog modal-dialog-centered modal-lg">

			<div class="modal-content">

				<div class="modal-header border-bottom  ">

					<h3
						id="customerAddressModalLabel"
						class="modal-title fw-semibold text-gray-900">
						Customer Address
					</h3>

					<button
						type="button"
						class="btn btn-sm btn-icon btn-active-color-primary"
						data-bs-dismiss="modal"
						aria-label="Close">

						<i class="ki-duotone ki-cross fs-2">
							<span class="path1"></span>
							<span class="path2"></span>
						</i>

					</button>

				</div>

				<div class="modal-body p-8">

					<div class="mb-5">

						<label
							for="modal_address_name"
							class="required form-label fw-medium">
							Address Name
						</label>

						<input
							type="text"
							id="modal_address_name"
							class="form-control"
							placeholder="Address Name">

					</div>

					<div class="mb-5">

						<label
							for="modal_address"
							class="required form-label fw-medium">
							Address
						</label>

						<textarea
							id="modal_address"
							class="form-control"
							rows="4"
							placeholder="Address"></textarea>

					</div>

					<div>

						<label
							for="modal_google_map"
							class="form-label fw-medium">
							Google Map URL
						</label>

						<input
							type="url"
							id="modal_google_map"
							class="form-control"
							placeholder="https://maps.app.goo.gl/...">

					</div>

				</div>

				<div class="modal-footer border-0">

					<button
						type="button"
						class="btn btn-light"
						data-bs-dismiss="modal">
						Close
					</button>

					<button
						type="button"
						id="save_customer_address"
						class="btn btn-success">
						Save
					</button>

				</div>

			</div>

		</div>

	</div>
	

	<script type="text/javascript">

	$(document).ready(function () {

		const contextPath = "${pageContext.request.contextPath}";
        
		let currentAddresses = [];
		let freelancerOriginalData = null;

		function loadCompanyAddresses(companyId, preselectAddressId) {

		    if (!companyId || companyId === "freelancer") {
		        currentAddresses = [];
		        $("#company_location_id").empty();
		        return;
		    }

		    $.ajax({
		        url: contextPath + "/contact_address_list.action",
		        method: "GET",
		        data: { companyId: companyId },
		        dataType: "json"
		    }).done(function (response) {

		        currentAddresses = response || [];
		        $("#company_location_id").empty();

		        $.each(currentAddresses, function (index, addr) {
		            $("#company_location_id").append(
		                $("<option>", { value: addr.address_id, text: addr.address_name })
		            );
		        });

		        let selected = null;

		        if (preselectAddressId) {
		            selected = currentAddresses.find(function (item) {
		                return String(item.address_id) === String(preselectAddressId);
		            });
		        }

		        if (!selected) {
		            selected = currentAddresses[0];
		        }

		        if (selected) {
		            $("#company_location_id").val(selected.address_id);
		            showLocation(selected.address_id);
		        }

		    }).fail(function () {
		        currentAddresses = [];
		        $("#company_location_id").empty();
		        swal("Error", "ไม่สามารถโหลดที่อยู่บริษัทได้", "error");
		    });
		}

		function showLocation(addressId) {

		    const location = currentAddresses.find(function (item) {
		        return String(item.address_id) === String(addressId);
		    });

		    if (!location) {
		        $("#selected_company_address").text("-");
		        $("#selected_company_map").attr("href", "#").text("-");
		        updateSelectedCompanyMapVisibility();
		        return;
		    }

		    $("#selected_company_address").text(location.address);
		    $("#selected_company_map")
		        .attr("href", location.google_map || "#")
		        .text(location.google_map || "-");
		    updateSelectedCompanyMapVisibility();
		}

		/*
		 * แสดงตัวอย่างรูป Profile
		 */
		$("#profile_image").on("change", function () {

			const file = this.files[0];

			if (!file) {
				return;
			}

			// เลือกไฟล์ใหม่แล้ว ยกเลิกสถานะ Remove ที่อาจตั้งไว้ก่อนหน้า
			$("#remove_profile_image").val("");

			const reader = new FileReader();

			reader.onload = function (event) {

				$("#profile_preview").attr(
					"src",
					event.target.result
				);

			};

			reader.readAsDataURL(file);

		});


		/*
		 * ลบรูป Profile
		 */
		$("#remove_profile").on("click", function () {

			$("#profile_image").val("");

			// แจ้ง Backend ว่าผู้ใช้ต้องการลบรูป Profile เดิมตอน Save
			$("#remove_profile_image").val("Y");

			$("#profile_preview").attr(
				"src",
				contextPath + "/assets/media/avatars/blank.png"
			);

		});


		/*
		 * ปุ่ม Close
		 */
		$("#close_btn").on("click", function () {

			window.location.href =
				contextPath + "/contact.action";

		});


		/*
		 * แสดงข้อมูลบริษัท (โชว์ panel เปล่า ไม่ auto-fill)
		 */
		function showCompanyDetail(companyId) {

			if (companyId === "freelancer") {
				$("#company_detail").hide();
				$("#freelancer_section").stop(true, true).slideDown();
				return;
			}

			$("#freelancer_section").stop(true, true).slideUp();

			if (!companyId) {
				$("#company_detail").hide();
				$("#company_logo").val("");
				$("#company_logo_preview").html(
					'<i class="ki-duotone ki-picture fs-5x text-gray-300">' +
						'<span class="path1"></span><span class="path2"></span>' +
					'</i>'
				);
				return;
			}
			$("#company_detail").show();

			const hasPendingLogoFile =
				$("#company_logo")[0] &&
				$("#company_logo")[0].files &&
				$("#company_logo")[0].files.length > 0;

			if (!hasPendingLogoFile) {
				const logoPath = $("#company_id option:selected").data("logo");
				if (logoPath) {
					$("#company_logo_preview").html(
						'<img src="' + contextPath + logoPath + '"' +
						' class="w-100 h-100 object-fit-cover rounded"' +
						' alt="Company Logo">'
					);
				} else {
					$("#company_logo_preview").html(
						'<i class="ki-duotone ki-picture fs-5x text-gray-300">' +
							'<span class="path1"></span><span class="path2"></span>' +
						'</i>'
					);
				}
			}

			$("#company_tax").text("");

			$("#company_detail_logo").attr("src", "");
			$("#company_tax").text("");
			$("#company_location_id").empty();
			$("#selected_company_address").text("");
			$("#selected_company_map").attr("href", "#").text("");

		}
		//Company
				function updateSelectedCompanyMapVisibility() {
			const mapHref = ($("#selected_company_map").attr("href") || "").trim();
			const row = document.getElementById("selected_company_map_row");
			if (!row) return;
			if (!mapHref || mapHref === "#") {
				row.style.setProperty("display", "none", "important");
			} else {
				row.style.setProperty("display", "flex", "important");
			}
		}
		
		
		//Freelanc
				function updateMapLinkVisibility() {
			const mapHref = ($("#company_map_link").attr("href") || "").trim();
			const row = document.getElementById("company_map_row");
			if (!row) return;
			if (!mapHref || mapHref === "#") {
				row.style.setProperty("display", "none", "important");
			} else {
				row.style.setProperty("display", "flex", "important");
			}
		}

		/*
		 * เปลี่ยนบริษัท
		 */
		 $("#company_id").on("change", function () {

			    const companyId = $(this).val();
			    const taxNumber = $(this).find("option:selected").data("tax");

			    showCompanyDetail(companyId);
			    loadCompanyAddresses(companyId);

			    if (companyId !== "freelancer") {
			        $("#company_name_en").val("");
			        $("#company_name_th").val("");
			        $("#freelancer_address").text("");
			        $("#company_map_link").attr("href", "#").text("");
			        updateMapLinkVisibility();
			        $("#company_tax").text(taxNumber || "-");
			    } else {

			        if (freelancerOriginalData) {

			            // กลับมาเลือก Freelancer ตัวเดิมที่กำลังแก้ไขอยู่ คืนข้อมูลเดิมกลับมา ไม่เคลียร์ทิ้ง
			            $("#company_name_en").val(freelancerOriginalData.companyNameEn);
			            $("#company_name_th").val(freelancerOriginalData.companyNameTh);
			            $("#location_name").val(freelancerOriginalData.locationName);
			            $("#freelancer_address").text(freelancerOriginalData.addressText);
			            $("#company_map_link").attr("href", freelancerOriginalData.mapHref).text(freelancerOriginalData.mapText);
			            updateMapLinkVisibility();

			            $("#company_logo").val("");
			            $("#company_logo_preview").html(freelancerOriginalData.logoHtml);

			        } else {

			            // เลือก Freelancer สดใหม่ ไม่เคยมีข้อมูลเดิม เคลียร์ฟอร์มว่างตามปกติ
			            $("#company_name_en").val("");
			            $("#company_name_th").val("");
			            $("#location_name").val("");
			            $("#freelancer_address").text("");
			            $("#company_map_link").attr("href", "").text("");
			            const freshMapRow = document.getElementById("company_map_row");
			            if (freshMapRow) { freshMapRow.style.setProperty("display", "flex", "important"); }

			            $("#company_logo").val("");
			            $("#company_logo_preview").html(
			                '<i class="ki-duotone ki-picture fs-5x text-gray-300">' +
			                    '<span class="path1"></span><span class="path2"></span>' +
			                '</i>'
			            );

			        }
			    }
			});


		/*
		 * เปลี่ยน Location
		 */
		$("#company_location_id").on("change", function () {
			showLocation($(this).val());
		});


		/*
		 * แสดงตัวอย่าง Company Logo ของ Freelancer
		 */
		$("#company_logo").on("change", function () {

			const file = this.files[0];

			if (!file) {
				return;
			}

			const allowedTypes = [
				"image/png",
				"image/jpeg"
			];

			if (!allowedTypes.includes(file.type)) {

				swal(
					"Error",
					"รองรับเฉพาะไฟล์ png, jpg และ jpeg",
					"error"
				);

				$(this).val("");

				return;
			}

			const reader = new FileReader();

			reader.onload = function (event) {

				$("#company_logo_preview").html(
					'<img src="' + event.target.result + '"' +
					' class="w-100 h-100 object-fit-cover rounded"' +
					' alt="Company Logo">'
				);

			};

			reader.readAsDataURL(file);

		});


		/*
		 * ลบ Company Logo
		 */
		$("#remove_company_logo").on("click", function () {

			$("#company_logo").val("");

			$("#company_logo_preview").html(
				'<i class="ki-duotone ki-picture fs-5x text-gray-300">' +
					'<span class="path1"></span>' +
					'<span class="path2"></span>' +
				'</i>'
			);

		});


		/*
		 * เปิด Customer Address Modal
		 */
		 $("#select_location_btn").on("click", function () {

			    $("#modal_address_name").val(
				        $("#location_name").val()
				    );

			    $("#modal_address").val(
			        $("#freelancer_address").text().trim()
			    );

			    $("#modal_google_map").val(
			        $("#company_map_link").attr("href") || ""
			    );

			    const modalElement =
			        document.getElementById("customerAddressModal");

			    const customerAddressModal =
			        bootstrap.Modal.getOrCreateInstance(modalElement);

			    customerAddressModal.show();

			});

		/*
		 * บันทึก Customer Address กลับหน้า Contact Detail
		 */
		$("#save_customer_address").on("click", function () {

			const addressName =
				$("#modal_address_name").val().trim();

			const address =
				$("#modal_address").val().trim();

			const googleMap =
				$("#modal_google_map").val().trim();

			if (!addressName || !address) {

				swal(
					"Error",
					"กรุณากรอกข้อมูล Customer Address ให้ครบ",
					"error"
				);

				return;
			}

			/* $("#company_name_en").val(addressName); */
			$("#location_name").val(addressName);
			$("#freelancer_address").text(address);
			$("#company_map_link")
			.attr("href", googleMap)
			.text(googleMap);
		updateMapLinkVisibility();

			const modalElement =
				document.getElementById("customerAddressModal");

			const customerAddressModal =
				bootstrap.Modal.getInstance(modalElement);

			if (customerAddressModal) {
				customerAddressModal.hide();
			}

		});


		/*
		 * Submit Form
		 */
		$("#contactForm").on("submit", function (event) {

			event.preventDefault();

			const titleTh = $("#title_th").val();
			const fullNameTh = $("#full_name_th").val().trim();
			const titleEn = $("#title_en").val();
			const fullNameEn = $("#full_name_en").val().trim();
			const position = $("#position").val().trim();
			const phone = $("#phone").val().trim();
			const email = $("#email").val().trim();
			const companyId = $("#company_id").val();

			if (
				!titleTh ||
				!fullNameTh ||
				!titleEn ||
				!fullNameEn ||
				!position ||
				!phone ||
				!email ||
				!companyId
			) {

				swal(
					"Error",
					"กรุณากรอกข้อมูลที่จำเป็นให้ครบ",
					"error"
				);

				return;
			}

			/*
			 * เตรียมข้อมูลก่อน Submit
			 */
			if (companyId === "freelancer") {
				
			    $("#hidden_freelancer_address_name").val(
			            $("#location_name").val().trim()
			        );

				$("#hidden_freelancer_address").val(
					$("#freelancer_address").text().trim()
				);
				$("#hidden_freelancer_google_map").val(
					$("#company_map_link").attr("href") || ""
				);

			} else {
				$("#contact_company_address_id").val(
					$("#company_location_id").val() || ""
				);
			}

			$("#contact_is_active").val(
				$(".js-toggle-enable").is(":checked") ? "1" : "0"
			);

			if (companyId === "freelancer") {

				$("#hidden_freelancer_address").val(
					$("#freelancer_address").text().trim()
				);
				$("#hidden_freelancer_google_map").val(
					$("#company_map_link").attr("href") || ""
				);

			} else {
				$("#contact_company_address_id").val(
					$("#company_location_id").val() || ""
				);
			}

			$("#contact_is_active").val(
				$(".js-toggle-enable").is(":checked") ? "1" : "0"
			);

			HTMLFormElement.prototype.submit.call(this);

		});
		
		
		/*
		 * หน้า Edit หรือมีค่าบริษัทอยู่แล้ว
		 */
		const initialCompanyId = $("#company_id").val();
		const initialCompanyAddressId = $("#contact_company_address_id").val();
		const initialTaxNumber = $("#company_id option:selected").data("tax");
		const isFreelancerContactInit = ${isFreelancerContact ? true : false};

		if (isFreelancerContactInit) {

		   
		    const savedCompanyNameEn = $("#company_name_en").val();
		    const savedCompanyNameTh = $("#company_name_th").val();
		    const savedLocationName  = $("#location_name").val();
		    const savedAddressText   = $("#freelancer_address").text();
		    const savedMapHref       = $("#company_map_link").attr("href");
		    const savedMapText       = $("#company_map_link").text();

		    freelancerOriginalData = {
		        companyNameEn: savedCompanyNameEn,
		        companyNameTh: savedCompanyNameTh,
		        locationName:  savedLocationName,
		        addressText:   savedAddressText,
		        mapHref:       savedMapHref,
		        mapText:       savedMapText
		    };
				   
		    $("#company_id").val("freelancer").trigger("change");	
		    $("#company_name_en").val(savedCompanyNameEn);
		    $("#company_name_th").val(savedCompanyNameTh);
		    $("#location_name").val(savedLocationName);
		    $("#freelancer_address").text(savedAddressText);
		    $("#company_map_link").attr("href", savedMapHref).text(savedMapText);
		    updateMapLinkVisibility();

		} else {
		    showCompanyDetail(initialCompanyId);

		    if (initialCompanyId && initialCompanyId !== "freelancer") {
		        $("#company_tax").text(initialTaxNumber || "-");
		        loadCompanyAddresses(initialCompanyId, initialCompanyAddressId);
		    }

		}
		});
</script>

</body>
</html> 
