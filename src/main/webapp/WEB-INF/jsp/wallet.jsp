<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="zh-Hant-TW">
	<head>
    	<meta name="viewport" content="width=device-width" />
	    <title>電子錢包</title>
	
	    <link href="<%=request.getContextPath()%>/component/jQuery-UI/jquery-ui-1.12.1.min.css" rel="stylesheet" />
	    <link href="<%=request.getContextPath()%>/component/jQuery-UI/jquery-ui.theme-1.12.1.min.css" rel="stylesheet" />
	    <link href="<%=request.getContextPath()%>/component/Font-Awesome/css/all.css" rel="stylesheet" />
	    <link href="<%=request.getContextPath()%>/component/Bootstrap/bootstrap.min.css" rel="stylesheet" />
	    <link href="<%=request.getContextPath()%>/component/overlayScrollbars/OverlayScrollbars.min.css" rel="stylesheet" />
	    <link href="<%=request.getContextPath()%>/component/AdminLTE/adminlte-3.1.0.min.css" rel="stylesheet" />
	    <link href="<%=request.getContextPath()%>/component/css/style.css" rel="stylesheet" >
		<link rel="stylesheet" href="https://unpkg.com/purecss@2.0.6/build/pure-min.css">
	</head>
	<body class="sidebar-mini layout-fixed layout-navbar-fixed layout-footer-fixed sidebar-collapseX sidebar-collapse" style="height: auto;">
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
		                <span class="title-text" id="showtitle">電子錢包</span>
		            </div>
					<!-- 搜尋bar -->
		            <form id="myForm" name="myForm">
			            <input type="hidden" id="state" name="state" value="query">
			            <div class="search-block">
			                <div class="search-block-line">
			                    <div>
			                    	<label>
			                            <span class="text" >會員編號：</span>
			                            <input class="modal-readonly" type="text" id="id" name="id" readonly="readonly" value="${ member.id }">
			                        </label>
			                    	&nbsp;&nbsp;&nbsp;
			                    	<label>
			                            <span class="text" >會員帳號：</span>
			                            <input class="modal-readonly" type="text" id="account" name="account" readonly="readonly" value="${ member.account }">     
			                        </label>
			                    </div>
			                </div>
			                <div class="search-block-line">
			                    <div>
			                    	<span class="text" >姓　　名：</span>
			                        <input class="modal-readonly" type="text" id="name" name="name" readonly="readonly" value="${ member.name }">   
			                    	&nbsp;&nbsp;&nbsp;
			                        <span class="text" >錢包餘額：</span>
			                        <input class="modal-readonly" type="text" id="wallet" name="wallet" readonly="readonly" value="${ totalAmount }">   
			                    </div>
			                    <div class="search-block-line btnventer">
				                    <div class="btn searchbtn newbtn-blue" onclick="doAmount();">儲值</div>
				                </div>
			                </div>
			            </div>
		            </form>
		            <div>
						<form class="pure-form">
							<fieldset>
								<legend>儲值記錄</legend>
								<table class="pure-table pure-table-bordered " id="shoppingCartTable">
									<thead>
										<tr>
											<th width=5%>項次</th>
											<th width=15%>儲值日期</th>
											<th width=10%>儲值金額</th>
										</tr>
									</thead>
									<tbody id="productBody">
										<c:forEach varStatus="status" var="wallet" items="${ wallets }">
											<tr>
												<td>${ status.index + 1 }</td>
												<td>
													<fmt:formatDate value="${ wallet.createtime }" pattern="yyyy-MM-dd"/>
												</td>
												<td>${ wallet.amount }</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</fieldset>
						</form>
		            </div>
		
					<div class="modal fade" id="updateModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h4 class="modal-title" id="updateModalTitle"></h4>
								</div>
								<div class="wordWrap modal-body" id="addDataDiv">
									<form id="updateForm" name="updateForm" method="POST" action="#">
							            <div class="search-block">
							            	<div class="search-block-line controlhidden" id="updateIdDvi" >
						                        <label>
						                            <span class="text" >會員編號：</span>
						                            <input type="text" class="modal-readonly" id="updateId" name="memberId" readonly="readonly" value="${ member.id }">
						                        </label>
							                </div>
							                <div class="search-block-line">
						                        <label>
						                            <span class="text">儲值金額：</span>
						                            <input type="number" id="amount" name="amount">
						                        </label>
							                </div>
							            </div>
									</form>
									<div class="error" id="error"></div>
								</div>
								<div class="wordWrap modal-body controlhidden" id="deleteConfirmDiv">
									<h4 id="deleteConfirmBoby"></h4>
								</div>
								<div class="modal-footer">
								 	<button type="button" class="btn newbtn-gray" data-bs-dismiss="modal">關閉</button>
								 	&nbsp;&nbsp;
									<button type="button" id="saveConfirmbtn" class="btn btn-primary" onclick="doSaveAmount();">儲值</button>
									
								</div>
							</div>
						</div>
					</div>
			
		        </div>
		    </div>
		
			<%@ include file="util.jsp" %>
			
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
			
		<script>
		    document.getElementById(${ selectFunction }).innerHTML = '<i class="fa-solid fa-circle nav-icon"></i>';
			
		    function doSaveAmount() {
				if(checkData()){
					let formArray = $("#updateForm").serializeArray();
					$.ajax({
	                    url: '<%=request.getContextPath()%>/wallet',
	                    type: 'POST',
	                    dataType: "json",
	        		    contentType:"application/json; charset=utf-8",
	                    data: JSON.stringify(objectifyForm(formArray)),
	                    success: function(data) {
	                    	if(data.result == true) {
	                    		showMsg("", data.message);
	                    		window.location.reload();
	                    	} else {
	                    		showMsg("錯誤", data.message);
	                    	}
	                    },
	                    error: function(error) {
	                    	let msg = showMsg("錯誤", error.responseJSON.message);
	                    }
	                })
				}
			}

		    function doAmount() {
				document.getElementById("error").innerHTML = "";
				document.getElementById("updateModalTitle").innerHTML = '儲值';
        		$('#updateModal').modal('show');
			}

			function showMsg(title, msg) {
				document.getElementById("myModalLabel").innerHTML = title;
				document.getElementById("myModalBoby").innerHTML = msg;
				document.getElementById("btnModal").click();
			}
			
			function doConfirm(title, msg) {
				document.getElementById("deleteModalTitle").innerHTML = title;
        		document.getElementById("deleteModalBoby").innerHTML = msg;
        		document.getElementById("deleteModalBut").style.display = 'none';
        		$('#deleteModal').modal('show');
			}

			function checkData() {
				if ($('#amount').val() <= 0) {
					doConfirm("錯誤", "儲值金額需大於0")
					return false;
				}
				return true;
			}
			
		</script>
	</body>
</html>