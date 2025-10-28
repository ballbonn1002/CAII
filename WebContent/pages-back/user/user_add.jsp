<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script src="js/app-ajax.js" type="text/javascript"></script>
<!-- <script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script> -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.9.2/jquery-ui.js"></script>
<script
	src="../assets/global/plugins/bootstrap-sweetalert/sweetalert.min.js"
	type="text/javascript"></script>
<script src="../assets/pages/scripts/ui-sweetalert.min.js" type="text/javascript"></script>
<link
	href="../assets/global/plugins/bootstrap-sweetalert/sweetalert.css"
	rel="stylesheet" type="text/css" />
	
<style>
.error{
	border-color: #d71b29;
} 
.input-label{
	margin-bottom: 5px;
}
</style>
<div class="portlet light bordered">

	<div class="portlet-title">
		<div class="caption">
			<i class="icon-user font-red"></i> <span
				class="caption-subject font-red sbold uppercase">USER Add</span>
		</div>
		<div class="actions">
			<a class="btn btn-circle btn-icon-only btn-default fullscreen"
				href="javascript:;" data-original-title="" title=""> </a>
		</div>
	</div>
	<div class="portlet-body form">
		<div class="portlet-title">
			<div class="tools">
				<a href="javascript:;" class="collapse" data-original-title=""
					title=""> </a> <a href="#portlet-config" data-toggle="modal"
					class="config" data-original-title="" title=""> </a> <a
					href="javascript:;" class="reload" data-original-title="" title="">
				</a> <a href="javascript:;" class="remove" data-original-title=""
					title=""> </a>
			</div>
		</div>
		<div class="portlet-body" style="margin-right: 2%; margin-left: 2%;">
			<!-- BEGIN FORM-->
			<form action="user-perform-add" class="needs-validation"
				autocomplete="off" method="post">
				<div class="row">
					<div class="form-group col-lg-12">
						<div class="input-label col-lg-12">Login :<span class="required">*</span></div>
						<div class="col-lg-6" >
							<input type="text" name="user.id" id="userid" class="form-control userinfo"
								maxlength="32"></div>
						<div class="col-lg-2" >
							<input type="button" value="Check available!" class="btn btn-sm blue-soft"
								onclick="ajaxCall();"></div>
					</div>
				</div>
				<div class="row">
					<div class="form-group col-lg-6">
						<div class="input-label col-lg-6">E-Mail :<span class="required">*</span></div>
						<div class="col-lg-12">
							<input type="email" name="user.email" class="form-control userinfo"
								maxlength="50" placeholder="">
						</div>
					</div>
					<div class="form-group col-lg-6">
						<div class="input-label col-lg-6">Phone Number :<span class="required">*</span></div>
						<div class="col-lg-12">
							<input type="text" name="user.phone_num" id="phone" pattern="[0-9]{10}"
								maxlength="10" class="form-control userinfo">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="form-group col-lg-6">
						<div class="input-label col-lg-5">Title Name TH : <span class="required">*</span></div>
						<div class="col-lg-12">
							<select class="bs-select form-control userinfo" name="user.titleNameTH" id="titleNameTH">
								<option value="" selected disabled >Select ...</option>
								<option value="นาย">นาย</option>
								<option value="นาง">นาง</option>
								<option value="นางสาว">นางสาว</option>
							</select>
						</div>
					</div>
					<div class="form-group col-lg-6">
						<div class="input-label col-lg-5">Name TH : <span class="required">*</span></div>
						<div class="col-lg-12">
							<input type="text" id="name" name="user.name" class="form-control userinfo"
								maxlength="190">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="form-group col-lg-6">
						<div class="input-label col-lg-5">Title Name EN : <span class="required">*</span></div>
						<div class="col-lg-12">
							<select class="bs-select form-control userinfo" name="user.titleNameEN" id="titleNameEN">
								<option value="" selected disabled >Select ...</option>
								<option value="Mr.">Mr.</option>
								<option value="Mrs.">Mrs.</option>
								<option value="Ms.">Miss/Ms.</option>
							</select>
						</div>
					</div>
					<div class="form-group col-lg-6">
						<div class="input-label col-lg-5">Name EN : <span class="required">*</span></div>
						<div class="col-lg-12">
							<input type="text" id="nameEN" name="user.nameEN" class="form-control userinfo" 
								maxlength="190">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="form-group col-lg-6">
						<div class="input-label col-lg-5">Nick Name TH :</div>
						<div class="col-lg-12">
							<input type="text" id="nickName" name="user.nickName" class="form-control"
								maxlength="32">
						</div>
					</div>
					<div class="form-group col-lg-6">
						<div class="input-label col-lg-5">Nick Name EN :</div>
						<div class="col-lg-12">
							<input type="text" id="nickNameEN" name="user.nickNameEN" class="form-control" 
								maxlength="32">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="form-group col-lg-6">
						<div class="input-label col-lg-5">Gender : <span class="required">*</span></div>
						<div class="col-lg-10">
							<div class="md-radio-inline">
								<div class="md-radio has-success col-lg-3">
									<input class="userinfo gender" type="radio" id="genderM" name="user.gender" value="M">
									<label for="genderM" style="color: #333;">
										<span class="inc"></span><span class="check" style="background: #26C281;"></span>
										<span class="box" style="border-color: #26C281;"></span> Male
									</label>
								</div>
								<div class="md-radio has-success col-lg-3">
									<input class="userinfo gender" type="radio" id="genderF" name="user.gender" value="F">
									<label for="genderF" style="color: #333;">
										<span class="inc"></span><span class="check" style="background: #26C281;"></span>
										<span class="box" style="border-color: #26C281;"></span> Female
									</label>
								</div>
							</div>
							<div id="invalid" class="text-danger" style="display:none;"><i 
								class="fa fa-close"></i><small> required this field. </small></div>
						</div>
						
					</div>
					<div class="form-group col-lg-6">
						<div class="input-label col-lg-5">Address :</div>
						<div class="col-lg-12">
							<textarea class="form-control" rows="2" maxlength="255"
								placeholder="Please add your address " name="user.address"></textarea>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="form-group col-lg-6">
						<div class="input-label col-lg-5">Role : <span class="required">*</span></div>
						<div class="col-lg-12">
							<select class="form-control userinfo" name="user.roleId">
								<option value="" selected disabled >Select ...</option>
								<c:forEach var="role" items="${roleList}" varStatus="status">
									<option value="${role.id}">${role.id}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="form-group col-lg-6">
						<div class="input-label col-lg-5">Start Working Date : <span class="required">*</span></div>
						<div class="col-lg-12">
							<input class="form-control form-control-inline date-picker userinfo"
								type="text" data-date-format="dd-mm-yyyy" value=""
								id="startDate" name="startDate">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="form-group col-lg-6">
						<div class="input-label col-lg-5">Department : <span class="required">*</span></div>
						<div class="col-lg-12">
							<select class="bs-select form-control userinfo" name="user.departmentId">
								<option value="" selected disabled >Select ...</option>
								<c:forEach var="department" items="${departmentList}">
									<option value="${department.id}" <c:if test="true">  </c:if>>${department.id}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="form-group col-lg-6">
						<div class="input-label col-lg-5">Position : <span class="required">*</span></div>
						<div class="col-lg-12">
							<select class="bs-select form-control userinfo" name="user.positionId">
								<option value="" selected disabled >Select ...</option>
								<option value="none">None</option>
								<c:forEach var="position" items="${positionList}">
									<option value="${position.position_id}"<c:if test="true"> </c:if>>${position.name}</option>
								</c:forEach>
							</select>
						</div>
					</div>
				</div>
				
				<div class="form-group form-lg-line-input ">
					<div class="caption col-md-4"style="margin-top: 3px;">
						<input class="form-control form-control-inline  date-picker"
							type="hidden" data-date-format="dd-mm-yyyy" value=""
							name="startDate">
						<input type="hidden" name="user.leaveQuota4" class="form-control"
							value="0">
					</div>
				</div>
					
				<div class="form-actions action right">
					<div class="row ">
						<div class="col-md-12" style="text-align: center;">
							<button type="submit" class="btn blue-soft" id="submit">
								<i class="fa fa-save"></i>&nbsp;Save
							</button>
							<button type="reset" class="btn red-intense" onclick="back()">
								<i class="fa fa-close"></i>&nbsp;Cancel
							</button>
						</div>
					</div>
				</div>
			</form>
			<!-- END FORM -->
		</div>
	</div>
</div>
<!-- <script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script> -->
<script>
$(document).ready(function() {
	if ($('#name') != '') {
		$('#name').val(" ");
	}
	if ($('#pass') != '') {
		$('#pass').val("");
	}
	var value = "${flag}";
	if (value == 1) {
		swal('Please!', 'Check Username Duplicate', 'warning');		
	}
	
	$('#startDate').datepicker();
	$("form").submit(function( event ) {
		var inputs = document.getElementsByClassName('userinfo');
		for (var i=0; i<inputs.length; i++){
			 if(inputs[i].value.length === 0) {
				event.preventDefault();
				inputs[i].classList.add("error");
			} else {
				inputs[i].classList.remove("error");
	        }
		}
		checkGender();

	    $(".userinfo").blur(function() {
	    	var inputs = document.getElementsByClassName('userinfo');
	    	for (var i=0; i<inputs.length; i++){
	    		if(inputs[i].value.length === 0) {
	    			inputs[i].classList.add("error");
	    		} else {
	    			inputs[i].classList.remove("error");
	    		}
	    		checkGender();
	    	}
	    });	
    }); 
	
	$('#name, #nickName').on('keypress', function(e){
		var thaiPattern = /^[\u0E00-\u0E7F\s]+$/; // เช็คเฉพาะภาษาไทย
	    if(thaiPattern.test(event.key)){
	    	return true;
	    }else{
	    	return false;
	    }
	});
	$('#nameEN, #nickNameEN').on('keypress', function(e){
		var englishPattern = /^[a-zA-Z\s]*$/; // เช็คเฉพาะภาษาอังกฤษ
		if(englishPattern.test(event.key)){
			return true;
		}else{
			return false;
		}
	});
});
$('select[name="user.titleNameTH"], select[name="user.titleNameEN"]').on('change', function(){
	var value = $(this).val();
	if(value == 'นาย' || value == 'Mr.'){
		$('select[name="user.titleNameTH"] option[value="นาง"]').hide();
		$('select[name="user.titleNameEN"] option[value="Mrs."]').hide();
		$('select[name="user.titleNameTH"] option[value="นางสาว"]').hide();
		$('select[name="user.titleNameEN"] option[value="Ms."]').hide();
		$('input[name="user.gender"][value="M"]').prop('checked', true);
	}else if(value == 'นาง' || value == 'Mrs.'){
		$('select[name="user.titleNameTH"] option[value="นาย"]').hide();
		$('select[name="user.titleNameEN"] option[value="Mr."]').hide();
		$('select[name="user.titleNameTH"] option[value="นางสาว"]').hide();
		$('select[name="user.titleNameEN"] option[value="Ms."]').hide();
		$('input[name="user.gender"][value="F"]').prop('checked', true);
	}else{
		$('select[name="user.titleNameTH"] option[value="นาย"]').hide();
		$('select[name="user.titleNameEN"] option[value="Mr."]').hide();
		$('select[name="user.titleNameTH"] option[value="นาง"]').hide();
		$('select[name="user.titleNameEN"] option[value="Mrs."]').hide();
		$('input[name="user.gender"][value="F"]').prop('checked', true);
	}
    
});
$('input[type=radio][name="user.gender"]').on('change', function(){
	var value = $(this).val();
	if(value == 'M'){
		$('select[name="user.titleNameTH"] option[value="นาง"]').hide();
		$('select[name="user.titleNameTH"] option[value="นางสาว"]').hide();
		$('select[name="user.titleNameEN"] option[value="Mrs."]').hide();
		$('select[name="user.titleNameEN"] option[value="Ms."]').hide();
		$('select[name="user.titleNameTH"] option[value="นาย"]').show();
		$('select[name="user.titleNameEN"] option[value="Mr."]').show();
	}else{
		$('select[name="user.titleNameTH"] option[value="นาย"]').hide();
		$('select[name="user.titleNameEN"] option[value="Mr."]').hide();
		$('select[name="user.titleNameTH"] option[value="นาง"]').show();
		$('select[name="user.titleNameTH"] option[value="นางสาว"]').show();
		$('select[name="user.titleNameEN"] option[value="Mrs."]').show();
		$('select[name="user.titleNameEN"] option[value="Ms."]').show();
	}
});

$('#userid').hover(function() {
	$(this).val($.trim($(this).val().toLowerCase()));
});
$('#userid').keypress(function(e) {
	if ((event.charCode >= 65 && event.charCode <= 90) || // A-Z
            (event.charCode >= 97 && event.charCode <= 122) ||  // a-z
            (event.key == '.')){
            return true;
    }else{
    	return false;
    }
});

$('input[name="user.email"]').keypress(function(e){
	var allowedCharacters = /[a-zA-Z0-9@._-]/;
	if(!allowedCharacters.test(event.key)){
		event.preventDefault();
	}
});

$('input[name="user.phone_num"]').keypress(function(e) {
	if ((event.charCode >= 48 && event.charCode <= 57)){
		return true;
	}else{
		return false;
	}
});

$('#name, #nameEN, #nickName, #nickNameEN').blur(function() {
	var trimmed = $.trim($(this).val());
	var cleaned = trimmed.replace(/\s+/g, ' ');
	$(this).val(cleaned);
});

function ajaxCall() {
	var user = $('#userid').val();
	if(user != ""){
	$.ajax({
		url : "user_noti",
		method : "POST",
		type : "JSON",
		data : {
			"user.id" : user
		},
		success : function(data) {
			console.log(data);
			if (data.toString().indexOf("1") != -1) {
				swal('This id already exist,', 'Please change your id!', 'error');
			} else {
				swal('Pass', 'You can use this id', 'success');
			}
		}
	});
	} else {swal('Please!', 'Input your username for create account', 'error');
	}
};
</script>
<script type="text/javascript">
function user_noti() {
	alert($('#test').val());

}
function back(){
	document.location ="user-list";
}
function checkGender(){
	var genderM = document.getElementById('genderM');
	var genderF = document.getElementById('genderF');
	if(genderM.checked){
		document.getElementById("invalid").style.display = "none";
	}
	else if(genderF.checked){
		document.getElementById("invalid").style.display = "none";
	} else {
		document.getElementById("invalid").style.display = "block";
	}
}
</script>





