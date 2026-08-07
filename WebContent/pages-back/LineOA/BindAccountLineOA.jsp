<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/permission.tld" prefix="perm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
	<script charset="utf-8" src="https://static.line-scdn.net/liff/edge/versions/2.22.3/sdk.js"></script>
</head>
<body>
	<div style="text-align: center; margin-top: 50px;">
        <h2>ข้อมูลผู้ใช้งาน LINE</h2>
        <img id="user-picture" src="" alt="Profile Picture" style="width:100px; border-radius:50%; display:none;" />
        <h3 id="user-name">กำลังเชื่อมต่อระบบ...</h3>
        <p id="user-status"></p>
        <p id="user-id" style="color: gray; font-size: 12px;"></p>
    </div>
	<div>
		<form id="lineLiffLoginForm" action="lineLiffLogin" method="POST">
			<input type="hidden" id="lineUserId" name="lineUserId">
			<input type="hidden" id="typeAction" name="typeAction">
		</form>
	</div>
</body>
<script>
	liff.init({
	    liffId: "2010626368-KRvpzgeB",
	}).then(() => {
		
	    if (!liff.isLoggedIn()) {
	        liff.login();
	    } else {
	    	liff.getProfile().then(profile => {
	    		let params = new URLSearchParams(document.location.search);
	    		let typeValue = params.get("type");
	    		document.getElementById('typeAction').value = typeValue;
                document.getElementById('lineUserId').value = profile.userId;
                document.getElementById('lineLiffLoginForm').submit();
            });
	    }
	}).catch((err) => {
	    console.error("LIFF Initialization failed", err);
	});
</script>
</html>