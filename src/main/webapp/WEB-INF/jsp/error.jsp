<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
	<head>
	    <meta name="viewport" content="width=device-width" />
	    <title>ERROR</title>
	
	    <link href="<%=request.getContextPath()%>/component/jQuery-UI/jquery-ui-1.12.1.min.css" rel="stylesheet" />
	    <link href="<%=request.getContextPath()%>/component/jQuery-UI/jquery-ui.theme-1.12.1.min.css" rel="stylesheet" />
	    <link href="<%=request.getContextPath()%>/component/Font-Awesome/css/all.css" rel="stylesheet" />
	    <link href="<%=request.getContextPath()%>/component/Bootstrap/bootstrap.min.css" rel="stylesheet" />
	    <link href="<%=request.getContextPath()%>/component/overlayScrollbars/OverlayScrollbars.min.css" rel="stylesheet" />
	    <link href="<%=request.getContextPath()%>/component/AdminLTE/adminlte-3.1.0.min.css" rel="stylesheet" />
	    <link href="<%=request.getContextPath()%>/component/css/style.css" rel="stylesheet" >
	
	</head>
	<body class="sidebar-mini layout-fixed layout-navbar-fixed layout-footer-fixed sidebar-collapseX" style="height: auto;">
		<div class="wrapper">
		     <!-- Header -->
	        <nav class="main-header navbar navbar-expand navbar-white navbar-light">
	            <%@ include file="header.jsp" %>
	        </nav>
	
	        <!-- 主選單 -->
	        <aside class="main-sidebar sidebar-dark-primary elevation-4">
	           <%@ include file="navBar.jsp" %>
	        </aside>
	
		    <div class="content-wrapper">
			    <div class="main-content">
			    	<div class="main-title">
						<!-- <span class="red-block"></span> -->
						<span class="title-text">ERROR</span>
		             </div>
					<div class="errorMsg" id="errorMsg">${ loginMessage }</div>
					
					<div class="pagebtn">
						<div id = "returnbtn" class="btn newbtn-gray" onclick="doreturn();">確認</div>
					</div>
			
				</div>
			</div>
		    <!-- 頁尾 -->
	        <footer class="main-footer">
	           <%@ include file="footer.jsp" %>
	        </footer>
	    </div>
	    
	    <script src="<%=request.getContextPath()%>/component/jQuery/jquery-3.6.0.min.js"></script>
	    <script src="<%=request.getContextPath()%>/component/jQuery-UI/jquery-ui-1.12.1.min.js"></script>
	    <script src="<%=request.getContextPath()%>/component/Bootstrap/bootstrap.bundle.min.js"></script>
	    <script src="<%=request.getContextPath()%>/component/overlayScrollbars/jquery.overlayScrollbars.min.js"></script>
	    <script src="<%=request.getContextPath()%>/component/AdminLTE/adminlte-3.1.0.min.js"></script>
	    <script src="<%=request.getContextPath()%>/component/js/all.js"></script>
		<script src="<%=request.getContextPath()%>/component/js/util.js"></script>
	    
		<script language="JavaScript" type="text/JavaScript">
			var isLogin = '${ isLogin }';
			if(isLogin == 'true') {
				window.setTimeout("window.location.href = '<%=request.getContextPath()%>/sell'" , 3000);
			} else {
				window.setTimeout("window.location.href = '<%=request.getContextPath()%>/login'" , 3000);
			}
				
			//回上一頁
			function doreturn() {
				if(isLogin == 'true') {
					window.location.href = '<%=request.getContextPath()%>/sell';
				} else {
					window.location.href = '<%=request.getContextPath()%>/login';
				}
			}
			
		</script>
	</body>
</html>