<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="s" uri="/struts-tags" %>

		<style>
			#kt_scrolltop {
				display: none !important;
			}
		</style>

		<div class="d-flex flex-column flex-column-fluid">
			<!-- Toolbar -->
			<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
				<div id="kt_app_toolbar_container" class="app-container container-fluid d-flex flex-stack">
					<div class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
						<h2
							class="page-heading d-flex text-gray-700 fw-semibold flex-column justify-content-center my-0">
							Help &amp; Support</h2>
						<ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
							<li class="breadcrumb-item text-muted">Home</li>
						</ul>
					</div>
				</div>
			</div>

			<!-- Content -->
			<div id="kt_app_content" class="app-content flex-column-fluid">
				<div id="kt_app_content_container" class="app-container container-fluid">
					<form action="help_support_save" method="post" enctype="multipart/form-data" id="addSupportForm"
						onsubmit="return validateForm()">

						<jsp:include page="help_support_guide_fragment.jsp" />

						<div class="card mb-5">
							<div class="card-header border-0 pt-6">
								<div class="card-title">
									<h3 class="fw-bold text-dark m-0">Issue</h3>
								</div>
							</div>

							<div class="card-body pt-0">
								<!-- Requester -->
								<div class="mb-8">
									<div class="position-relative">
										<i
											class="ki-duotone ki-magnifier fs-2 text-gray-500 position-absolute top-50 translate-middle-y ms-4"><span
												class="path1"></span><span class="path2"></span></i> <input type="text"
											class="form-control form-control-solid ps-12 bg-light-gray text-gray-600"
											value="<s:property value='#request.userMap[#session.onlineUser.id]'/>"
											readonly />
									</div>
								</div>

								<div class="row g-5 mb-8">
									<div class="col-lg-4">
										<label
											class="required form-label fs-7 fw-bold text-gray-800">Categorized:</label>
										<select class="form-select" name="categorized" data-control="select2"
											data-hide-search="true">
											<option value="1" selected>Technical Issue</option>
											<option value="2">Inquiry / Question</option>
											<option value="3">Feature Request</option>
										</select>
									</div>
									<div class="col-lg-4">
										<label class="required form-label fs-7 fw-bold text-gray-800">Menu</label>
										<select class="form-select" name="supportMenuId" data-control="select2"
											data-hide-search="true">
											<s:iterator value="#request.menuList">
												<option value="<s:property value='supportMenuId'/>">
													<s:property value='menuName' />
												</option>
											</s:iterator>
										</select>
									</div>
								</div>

								<div class="mb-8">
									<label class="required form-label fs-7 fw-bold text-gray-800">Message</label>
									<textarea class="form-control" name="description" id="description" rows="5"
										placeholder="Please describe your issue here..."></textarea>
								</div>

								<div class="mb-8">
									<div class="d-flex flex-column">
										<label for="fileInput" id="lbFile"
											class="btn btn-primary w-150px mb-2 d-inline-flex align-items-center justify-content-center gap-2"
											style="height: 40px;"> Attach files <input type="file" name="files"
												id="fileInput" multiple style="display: none;"
												accept="image/png, image/jpeg, application/pdf"
												onchange="updateFileList(this)" />
										</label>

										<div id="filePreviewContainer" class="mt-4" style="max-width: 400px;"></div>
									</div>
									<script>
										const accumulatedFiles = new DataTransfer();

										// 1. เพิ่มฟังก์ชันบีบอัดรูปภาพ
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
																const newFile = new File([blob], file.name, {
																	type: file.type,
																	lastModified: Date.now()
																});
																resolve(newFile);
															} else {
																resolve(file);
															}
														}, file.type, quality);
													};
													img.onerror = error => reject(error);
												};
												reader.onerror = error => reject(error);
											});
										}

										function validateForm() {
											const description = document.getElementById('description').value.trim();
											if (description === "") {
												Swal.fire({
													text: "Please enter your message.",
													icon: "warning",
													buttonsStyling: false,
													confirmButtonText: "Ok, got it!",
													customClass: {
														confirmButton: "btn btn-primary"
													}
												});
												return false;
											}

											// 2. เพิ่มการเช็คขนาดไฟล์รวมไม่เกิน 2MB
											const MAX_MB = 2;
											const MAX_BYTES = MAX_MB * 1024 * 1024;
											let totalSize = 0;

											for (let i = 0; i < accumulatedFiles.files.length; i++) {
												totalSize += accumulatedFiles.files[i].size;
											}

											if (totalSize > MAX_BYTES) {
												Swal.fire({
													text: `Total file size exceeds the ${MAX_MB}MB limit. Please remove some files or use smaller PDFs.`,
													icon: "error",
													buttonsStyling: false,
													confirmButtonText: "Understood",
													customClass: { confirmButton: "btn btn-danger" }
												});
												return false;
											}

											return true;
										}

										// เปลี่ยนเป็น async function (ส่วนนี้ของคุณเขียนมาถูกต้องแล้วครับ)
										async function updateFileList(input) {
											// แสดง Loading กัน user กดยกเลิกกลางคันระหว่างบีบอัด
											Swal.fire({
												text: "Compressing images...",
												allowOutsideClick: false,
												didOpen: () => { Swal.showLoading(); }
											});

											for (let i = 0; i < input.files.length; i++) {
												let newFile = input.files[i];

												// เรียกใช้ฟังก์ชันบีบอัดไฟล์รูปภาพ
												try {
													newFile = await compressImage(newFile, 1280, 1280, 0.8);
												} catch (e) {
													console.error("Compression failed for", newFile.name, e);
												}

												// Merge newly selected files (เช็คซ้ำโดยใช้แค่ชื่อ เพราะ size รูปที่ถูกบีบอัดจะเปลี่ยนไป)
												let isDuplicate = false;
												for (let j = 0; j < accumulatedFiles.items.length; j++) {
													if (accumulatedFiles.files[j].name === newFile.name) {
														isDuplicate = true;
														break;
													}
												}
												if (!isDuplicate) {
													accumulatedFiles.items.add(newFile);
												}
											}

											// Write merged list back into the real input
											document.getElementById('fileInput').files = accumulatedFiles.files;
											renderPreview();

											// ปิด Loading
											Swal.close();
										}

										function renderPreview() {
											const container = document.getElementById('filePreviewContainer');
											container.innerHTML = '';

											for (let i = 0; i < accumulatedFiles.files.length; i++) {
												const file = accumulatedFiles.files[i];
												const fileName = file.name;
												const fileExtension = fileName.split('.').pop().toLowerCase();
												const isImage = ["png", "jpg", "jpeg"].includes(fileExtension);

												const fileWrapper = document.createElement('div');
												fileWrapper.className = 'd-flex justify-content-between align-items-center p-2 border rounded bg-light mb-2';

												const leftGroup = document.createElement('div');
												leftGroup.className = 'd-flex align-items-center overflow-hidden';

												if (isImage) {
													const imgPreview = document.createElement('img');
													imgPreview.src = URL.createObjectURL(file);
													imgPreview.className = 'w-40px h-40px rounded me-3 object-fit-cover';
													imgPreview.onload = function () {
														URL.revokeObjectURL(this.src);
													};
													leftGroup.appendChild(imgPreview);
												} else {
													const icon = document.createElement('i');
													icon.className = 'ki-duotone ki-file-pdf fs-2 me-3 text-primary';
													icon.innerHTML = '<span class="path1"></span><span class="path2"></span>';
													leftGroup.appendChild(icon);
												}

												const label = document.createElement('span');
												label.className = 'text-gray-800 fw-medium text-truncate';
												label.textContent = fileName;
												label.style.maxWidth = '250px';
												leftGroup.appendChild(label);

												// Remove button — capture index via IIFE closure
												const removeBtn = document.createElement('span');
												removeBtn.className = 'btn btn-icon btn-sm btn-light-danger cursor-pointer';
												removeBtn.onclick = (function (idx) {
													return function () {
														accumulatedFiles.items.remove(idx);
														document.getElementById('fileInput').files = accumulatedFiles.files;
														renderPreview();
													};
												})(i);

												const crossIcon = document.createElement('i');
												crossIcon.className = 'ki-duotone ki-cross fs-2';
												crossIcon.innerHTML = '<span class="path1"></span><span class="path2"></span>';
												removeBtn.appendChild(crossIcon);

												fileWrapper.appendChild(leftGroup);
												fileWrapper.appendChild(removeBtn);
												container.appendChild(fileWrapper);
											}
										}
									</script>
								</div>
							</div>

							<div class="card-footer d-flex justify-content-between align-items-center py-6 px-9">
								<a href="help_support"
									class="btn btn-light btn-active-light-primary px-8 d-flex align-items-center fw-bold">
									<i class="ki-duotone ki-arrow-left fs-2 me-2"><span class="path1"></span><span
											class="path2"></span></i> Back
								</a>
								<button type="submit" class="btn btn-primary px-10 fw-bold">Submit
									Request</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>