<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- ฟังก์ชันแนบไฟล์ที่ใช้ร่วมกัน: Leave Add/Edit, Travel Add, Travel Edit --%>
<script>
var LIFF_FILE_FORBIDDEN = /[\/:*?"<>|]/;
var LIFF_FILE_IMAGE_LIMIT = 500 * 1024;
var LIFF_FILE_TOTAL_LIMIT = 2 * 1024 * 1024;

function liffFileSourceKey(file) {
	return file.name + '|' + file.size;
}

function liffIsDuplicateFile(file, pendingFiles, loadingFiles) {
	var key = liffFileSourceKey(file);
	return pendingFiles.some(function (f) { return f.sourceKey === key; })
		|| loadingFiles.some(function (l) { return l.sourceKey === key; });
}

function liffFileUniqueName(fileName, usedNames) {
	if (usedNames.indexOf(fileName.toLowerCase()) === -1) return fileName;
	var dot = fileName.lastIndexOf('.');
	var base = (dot > 0) ? fileName.substring(0, dot) : fileName;
	var ext = (dot > 0) ? fileName.substring(dot) : '';
	var n = 2;
	while (usedNames.indexOf((base + ' (' + n + ')' + ext).toLowerCase()) !== -1) n++;
	return base + ' (' + n + ')' + ext;
}

function liffFileWithUniqueName(file, usedNames) {
	var name = liffFileUniqueName(file.name, usedNames);
	if (name === file.name) return file;
	var renamed = new File([file], name, { type: file.type, lastModified: file.lastModified });
	renamed.sourceKey = file.sourceKey;
	return renamed;
}

function liffIsHeicFile(file) {
	var name = (file.name || '').toLowerCase();
	return name.endsWith('.heic') || name.endsWith('.heif')
		|| file.type === 'image/heic' || file.type === 'image/heif';
}

function liffFileAlertHeic(supportedText) {
	Swal.fire({
		icon: 'error',
		title: 'ไม่รองรับไฟล์ HEIC',
		html: 'ไม่รองรับไฟล์นามสกุล .heic กรุณาแปลงก่อนแนบไฟล์'
			+ '<br><br><span class="text-muted fs-7">ไฟล์ที่รองรับ: ' + supportedText + '</span>',
		confirmButtonText: 'รับทราบ',
		buttonsStyling: false,
		customClass: { confirmButton: "btn btn-primary" }
	});
}

function liffFileAlertBadName(fileName) {
	Swal.fire({
		icon: 'error',
		title: 'Invalid file name',
		text: 'File name contains invalid characters: ' + fileName,
		confirmButtonText: 'OK',
		buttonsStyling: false,
		customClass: { confirmButton: "btn btn-primary" }
	});
}

function liffFileAlertTooBig(fileName) {
	Swal.fire({
		icon: 'warning',
		title: 'ไฟล์มีขนาดเกินกำหนด',
		text: 'ไม่สามารถแนบไฟล์ "' + fileName + '" ได้ เนื่องจากขนาดไฟล์รวมเกินขนาดสูงสุดที่กำหนดไว้',
		confirmButtonText: 'รับทราบ',
		buttonsStyling: false,
		customClass: { confirmButton: "btn btn-primary" }
	});
}

function liffFileMakeLoadingItem(name) {
	var wrapper = document.createElement('div');
	wrapper.className = 'd-flex w-100 align-items-center p-2 border border-gray-300 rounded bg-white';

	var spinner = document.createElement('span');
	spinner.className = 'spinner-border spinner-border-sm text-primary me-3 flex-shrink-0';
	spinner.setAttribute('role', 'status');

	var label = document.createElement('span');
	label.className = 'text-gray-600 fs-6 text-truncate';
	label.textContent = 'กำลังประมวลผล ' + name + '...';
	label.style.maxWidth = '250px';

	wrapper.appendChild(spinner);
	wrapper.appendChild(label);
	return wrapper;
}

function liffFileCompressImage(file, done) {
	if (file.type && file.type.indexOf('image/') === 0 && file.size > LIFF_FILE_IMAGE_LIMIT && typeof Compressor !== 'undefined') {
		new Compressor(file, {
			quality: 0.8, maxWidth: 1024, maxHeight: 1024,
			success: function (result) {
				var compressed = new File([result], file.name, { type: result.type, lastModified: Date.now() });
				compressed.sourceKey = file.sourceKey;
				done(compressed);
			},
			error: function (err) {
				done(file, err);
			}
		});
	} else {
		done(file);
	}
}
</script>
