<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <!--  
	    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
	   -->
	    <link href="<c:url value="/component/Bootstrap/bootstrap.min.css" />"  rel="stylesheet" type="text/css" />
		<link href="<c:url value="/component/css/normalize.css" />"  rel="stylesheet" type="text/css" />
		<link href="<c:url value="/component/css/style.css" />"  rel="stylesheet" type="text/css" />
		<link href="<c:url value="/component/css/login.css" />"  rel="stylesheet" type="text/css" />
		
	    <title>登入畫面</title>
	</head>
	<body>
		<div class="whitebg">
	        <div class="logo">
	            <img src="<c:url value="/component/image/logo.jpg" />">
	        </div>
	        <div class="s-title">
	            <span class="s-txt">生活用品販賣機登入系統</span>
	        </div>
	        <form id="loginForm" name="loginForm" method="POST" action="<%=request.getContextPath()%>/login">
		        <div id="inputdiv">
		            <div class="inputblock">
		                <label for="name">使用者名稱：</label>
		                <input type="text" id="account" name="account">
		            </div>

		            <div class="inputblock">
		                <label for="pwd">使用者密碼：</label>
		                <input type="password" id="pwd" name="pwd" maxlength="20">
		            </div>
	    		</div>
	
				<div class="error" id="error">
	            	<br>
	            	<br>
	            </div>
				
	            <div id="btndiv" class="loginbtn">
	                <a  class="btn lg newbtn-gray" onclick="doClear();">清除</a>
					&nbsp;
	                <a class="btn lg newbtn-yellow" onclick="doLogin();">登入</a>
	            </div>
	        </form>
	    </div>
	     <!-- 
	    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>	
		 -->
		<script src="<c:url value="/component/Bootstrap/bootstrap.bundle.min.js" />" ></script>
		<script src="<c:url value="/component/jQuery/jquery-3.6.0.min.js" />" ></script>
		<script src="<c:url value="/component/jQuery-UI/jquery-ui-1.12.1.min.js" />" ></script>
		<script src="<c:url value="/component/js/util.js" />" ></script> 
	    <script>
	    	//登入認證
	    	function doLogin() {
	    		//document.getElementById("loginForm").submit();
				if (checkData()) {
					let url = '<%=request.getContextPath()%>/login';
					let data = objectifyForm($("#loginForm").serializeArray());
					queryajax(url, 'POST', data);
				 }
	    	}
	    	
	    	//清除查詢資料
			function doClear() {
				document.getElementById("account").value = null;
				document.getElementById("pwd").value = null;
			}
	    	
			//檢查欄位是否為空白
			function checkData() {
				if (document.getElementById("account").value == '') {
					document.getElementById("error").innerHTML = "帳號不能為空白 <br> &nbsp;";
					return false;
				}
				
				if (document.getElementById("pwd").value == '') {
					document.getElementById("error").innerHTML = "密碼不能為空白 <br> &nbsp;";
					return false;
				}
				return true;
			}
			
			function queryajax(apiUrl, methodType, requData) {
				return $.ajax({
					    type: methodType,
					    url: apiUrl,
					    dataType: "json",
					    contentType: "application/json; charset=utf-8",
					    data: JSON.stringify(requData),
					    cache:false,
					    success: function (data){
					    	//console.log('data')
					    	if(data.result == false) {
					    		document.getElementById("error").innerHTML = data.message;
					    	} else {
					    		window.location.href="<%=request.getContextPath()%>/sell";
					    	}
					    },
					    error: function (error) {
					    	document.getElementById("error").innerHTML = error;
					   	}
					});
			}
			
		</script>
	</body>
</html>