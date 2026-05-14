<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<style>
/* หมุนลูกศรเมื่อพับ/กาง */
.card-header .fa-chevron-up {
	transition: transform 0.3s ease;
}

.card-header.collapsed .fa-chevron-up {
	transform: rotate(180deg);
}
</style>

<%
// ใช้ Scriptlet ดึงค่าเพื่อให้มั่นใจว่าได้ค่าจาก jsp:param แน่นอน
String isCollapsedParam = request.getParameter("isCollapsed");
boolean isCollapsed = "true".equals(isCollapsedParam);
request.setAttribute("guideCollapsed", isCollapsed);
%>

<div class="card mb-5">
	<div
		class="card-header cursor-pointer <s:if test='#request.guideCollapsed'>collapsed</s:if>"
		data-bs-toggle="collapse" data-bs-target="#kt_guide_collapse">
		<div class="card-title m-0">
			<h3 class="fw-bold m-0 text-dark">Help & Support Guide</h3>
		</div>
		<div class="card-toolbar">
			<i class="fa fa-chevron-up text-gray-500 fs-4"></i>
		</div>
	</div>

	<div id="kt_guide_collapse"
		class="collapse <s:if test='!#request.guideCollapsed'>show</s:if>">
		<div class="card-body">
			<p class="fs-6 fw-semibold text-gray-700 mb-6">
				<span class="text-dark fw-bold">Categorized:</span>
				เพื่อให้ตรวจสอบและแก้ไขปัญหาให้ท่านได้อย่างรวดเร็ว
				กรุณาเลือกประเภทรายการที่ตรงกับความต้องการของท่าน
			</p>

			<div class="row g-5 mb-10">
				<div class="col-md-4">
					<div class="border rounded p-6 h-100"
						style="border-color: #F1416C !important;">
						<div class="d-flex align-items-center mb-4">
							<div class="symbol symbol-120px me-3">
								<i class="ki-duotone ki-information-5 fs-3hx text-danger"><span
									class="path1"></span><span class="path2"></span><span
									class="path3"></span></i>
							</div>
							<div>
								<h4 class="text-danger fw-bolder m-0 fs-5">Technical Issue</h4>
								<span class="text-gray-500 fw-semibold fs-7">(ปัญหาการใช้งานระบบ)</span>
							</div>
						</div>
						<div class="fs-6 text-gray-800 mb-4 fw-normal">
							"ใช้เมื่อระบบทำงานผิดปกติ หรือมีข้อผิดพลาด (Error)"<br>
							เลือกหัวข้อนี้หากท่านไม่สามารถทำรายการได้ตามปกติ เช่น:
							<ul class="mt-2 mb-0 text-gray-700">
								<li>กดปุ่มแล้วไม่มีอะไรเกิดขึ้น หรือระบบค้าง</li>
								<li>หน้าจอขึ้นข้อความ Error สีแดง หรือหน้าจอขาว (Blank
									Page)</li>
								<li>ข้อมูลแสดงผลไม่ถูกต้อง (เช่น ลงเวลาแล้วแต่เวลาไม่ขึ้น)</li>
							</ul>
						</div>
						<div class="fs-7 text-gray-600 italic">คำแนะนำ:
							หากแนบภาพหน้าจอ (Screenshot) ที่พบปัญหามาด้วย
							จะช่วยให้แก้ไขได้เร็วขึ้นมากค่ะ</div>
					</div>
				</div>

				<div class="col-md-4">
					<div class="border rounded p-6 h-100"
						style="border-color: #A11EBA !important;">
						<div class="d-flex align-items-center mb-4">
							<div class="symbol symbol-120px me-3">
								<i class="ki-duotone ki-question-2 fs-3hx"
									style="color: #A11EBA;"><span class="path1"></span><span
									class="path2"></span><span class="path3"></span></i>
							</div>
							<div>
								<h4 class="fw-bolder m-0 fs-5" style="color: #A11EBA;">Inquiry
									/ Question</h4>
								<span class="text-gray-500 fw-semibold fs-7">(สอบถามข้อมูล/วิธีใช้งาน)</span>
							</div>
						</div>
						<div class="fs-6 text-gray-800 mb-4 fw-normal">
							"ใช้เมื่อต้องการความช่วยเหลือ หรือมีข้อสงสัยเกี่ยวกับการใช้งาน"<br>
							เลือกหัวข้อนี้หากระบบทำงานปกติ<br>
							แต่ท่านต้องการคำแนะนำเพิ่มเติม เช่น:
							<ul class="mt-2 mb-0 text-gray-700">
								<li>ลืมรหัสผ่าน หรือเข้าใช้งานไม่ได้</li>
								<li>หาเมนูที่ต้องการไม่เจอ (เช่น หาปุ่มลาป่วยไม่เจอ)</li>
								<li>ต้องการสอบถามขั้นตอนการส่งเอกสารผ่านระบบ</li>
							</ul>
						</div>
						<div class="fs-7 text-gray-600 italic">คำแนะนำ:
							ระบุคำถามที่ท่านต้องการทราบให้ชัดเจน
							เพื่อให้เจ้าหน้าที่ตอบกลับได้ตรงประเด็นค่ะ</div>
					</div>
				</div>

				<div class="col-md-4">
					<div class="border rounded p-6 h-100"
						style="border-color: #009EF7 !important;">
						<div class="d-flex align-items-center mb-4">
							<div class="symbol symbol-120px me-3">
								<i class="ki-duotone ki-like-tag fs-3hx text-primary"><span
									class="path1"></span><span class="path2"></span><span
									class="path3"></span></i>
							</div>
							<div>
								<h4 class="text-primary fw-bolder m-0 fs-5">Feature Request</h4>
								<span class="text-gray-500 fw-semibold fs-7">(ข้อเสนอแนะเพื่อพัฒนา)</span>
							</div>
						</div>
						<div class="fs-6 text-gray-800 mb-4 fw-normal">
							"ใช้เมื่อท่านมีไอเดียที่อยากให้ระบบทำงานได้ดีขึ้น หรือสะดวกขึ้น"<br>
							เลือกหัวข้อนี้สำหรับสิ่งที่ระบบปัจจุบันยังไม่มี
							แต่ท่านอยากให้มีในอนาคต เช่น:
							<ul class="mt-2 mb-0 text-gray-700">
								<li>อยากให้มีปุ่มสรุปยอดวันลาคงเหลือแสดงในหน้าแรก</li>
								<li>อยากให้สามารถ Export รายงานเป็นไฟล์ Excel ได้</li>
								<li>อยากให้มีโหมดถนอมสายตา (Dark Mode)</li>
							</ul>
						</div>
						<div class="fs-7 text-gray-600 italic">คำแนะนำ:
							ทุกไอเดียของท่านมีค่า เราจะเก็บข้อมูลไว้เพื่อวางแผนพัฒนาใน
							Version ถัดไปค่ะ</div>
					</div>
				</div>
			</div>

			<div
				class="d-flex align-items-center flex-wrap mb-5 fs-6 text-gray-800">
				<span class="me-2"><span class="fw-bolder">Status </span>
					หากอยู่ในสถานะ <span class="badge badge-light-success fw-bold mx-1">Resolved</span>
					และไม่ได้รับการยืนยันภายใน 5 วันจะปรับสถานะเป็น <span
					class="badge badge-light-danger fw-bold mx-1">Closed</span>
					อัตโนมัติ หากมีปัญหาเพิ่มกรุณาสร้างรายการเข้ามาในระบบอีกครั้ง</span>
			</div>

			<div class="border border-dashed border-gray-300 rounded p-8">
				<div class="row text-center align-items-start">
					<div class="col-3">
						<span
							class="badge badge-light-warning px-3 py-2 mb-3 fs-7 fw-bold">New</span>
						<div class="fs-7 text-gray-600 fw-semibold">
							รายการส่งสำเร็จ<br>อยู่ระหว่างรอเจ้าหน้าที่รับเรื่อง
						</div>
					</div>
					<div class="col-3">
						<span
							class="badge badge-light-primary px-3 py-2 mb-3 fs-7 fw-bold">In
							Progress</span>
						<div class="fs-7 text-gray-600 fw-semibold">
							เจ้าหน้าที่กำลังตรวจสอบ<br>หรือแก้ไขปัญหาของท่าน
						</div>
					</div>
					<div class="col-3">
						<span
							class="badge badge-light-success px-3 py-2 mb-3 fs-7 fw-bold">Resolved</span>
						<div class="fs-7 text-gray-600 fw-semibold">
							ดำเนินการเรียบร้อยแล้ว<br>โปรดตรวจสอบและยืนยันการปิดงาน
						</div>
					</div>
					<div class="col-3">
						<span
							class="badge bg-light text-gray-700 border px-3 py-2 mb-3 fs-7 fw-bold">Closed</span>
						<div class="fs-7 text-gray-600 fw-semibold">
							รายการเสร็จสมบูรณ์<br>และถูกจัดเก็บเข้าประวัติแล้ว
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>