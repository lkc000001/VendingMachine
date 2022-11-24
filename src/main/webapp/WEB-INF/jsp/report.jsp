<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="zh-Hant-TW">
	<head>
    	<meta name="viewport" content="width=device-width" />
	    <title>銷售報表</title>
	
	    <link href="<%=request.getContextPath()%>/component/jQuery-UI/jquery-ui-1.12.1.min.css" rel="stylesheet" />
	    <link href="<%=request.getContextPath()%>/component/jQuery-UI/jquery-ui.theme-1.12.1.min.css" rel="stylesheet" />
	    <link href="<%=request.getContextPath()%>/component/jQuery/DateTimePicker/jquery.datetimepicker-2.5.20.min.css" rel="stylesheet" />
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
		                <span class="title-text" id="showtitle">銷售報表</span>
		            </div>
					<!-- 搜尋bar -->
		            <form id="myForm" name="myForm" method="GET" action="<%=request.getContextPath()%>/report" >
		            	<input type="hidden" id="state" name="state" value="query">
			            <input type="hidden" id="pageIndex" name="pageIndex"> 
			            <input type="hidden" id="pageSize" name="pageSize"> 
			            <div class="search-block">
			                <div class="search-block-line">
			                    <div>
			                    	<label>
			                            <span class="text" >產品編號：</span>
			                            <input type="text" id="productId" name="productId">
			                        </label>
			                    	&nbsp;&nbsp;&nbsp;
			                    	<label>
			                            <span class="text" >會員編號：</span>
			                            <input type="text" id="memberId" name="memberId">
			                        </label>
			                    </div>
			                </div>
			                <div class="search-block-line">
			                    <div>
			                        <label>
			                            <span class="text" >搜尋日期：</span>
			                            <input class="queryDate-width" type="text" id="startDate" name="startDate">
			                        	~
			                        	<input class="queryDate-width" type="text" id="endDate" name="endDate">
			                        </label>
			                    </div>
			                </div>
			                <div class="search-block-line btnventer">
			                    <div class="btn searchbtn newbtn-gray" onclick="doClear(0);">清除</div>
			                    &nbsp;&nbsp;
			                    <div class="btn searchbtn newbtn-yellow" onclick="doquery(1);">搜尋</div>
			                </div>
			            </div>
		            </form>
		            <div>
						<form class="pure-form">
							<fieldset>
								<div class="mb-1">
									<label class="fs-20">商品清單</label>
									<div class="showright">
										顯示筆數： 
										<select id="selectSize" onchange="doquery(1);">
											<option value="10" selected>10</option>
											<option value="25">25</option>
											<option value="50">50</option>
											<option value="100">100</option>
										</select>
									</div>
								</div>
								<table class="pure-table pure-table-bordered " id="shoppingCartTable">
									<c:if test="${fn:length(shoppingCarts) == 0 }">
										<thead>
										<tr>
											<td> 無購買清單 </td>
										</tr>
										</thead>
									</c:if>
									<c:if test="${fn:length(shoppingCarts) > 0 }">
										<thead>
											<tr>
												<th width=10%>訂單編號</th>
												<th width=8%>商品ID</th>
												<th width=24%>商品名稱</th>
												<th width=10%>數量</th>
												<th width=10%>單價</th>
												<th width=10%>金額</th>
												<th width=20%>購買日期</th>
											</tr>
										</thead>
										<tbody id="shoppingCartBody">
											<c:forEach varStatus="status" var="shoppingList" items="${ shoppingCarts }">		
												<tr>
													<td>${ shoppingList.orderId }</td>
													<td>${ shoppingList.productId }</td>
													<td>${ shoppingList.productName }</td>
													<td>${ shoppingList.buyQuantity }</td>
													<td>${ shoppingList.productPrice }</td>
													<td>${ shoppingList.total }</td>
													<td>
														<fmt:formatDate value="${ shoppingList.createtime }" pattern="yyyy-MM-dd HH:mm:ss"/>
													</td>
												</tr>
											</c:forEach>
											<tr>
											<c:if test="${ totalPage > 1 }">
												<td colspan="7">
													<div id="pageDiv">${ showPage }</div>
												</td>
											</c:if>
										</tr>
										</tbody>
									</c:if>
									
								</table>
							</fieldset>
						</form>
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
	    <script src="<%=request.getContextPath()%>/component/jQuery/DateTimePicker/jquery.datetimepicker-2.5.20.min.js"></script>
	    <script src="<%=request.getContextPath()%>/component/Bootstrap/bootstrap.bundle.min.js"></script>
	    <script src="<%=request.getContextPath()%>/component/overlayScrollbars/jquery.overlayScrollbars.min.js"></script>
	    <script src="<%=request.getContextPath()%>/component/AdminLTE/adminlte-3.1.0.min.js"></script>
	    <script src="<%=request.getContextPath()%>/component/js/all.js"></script>
		<script src="<%=request.getContextPath()%>/component/js/util.js"></script>
			
		<script>
		    document.getElementById(${ selectFunction }).innerHTML = '<i class="fa-solid fa-circle nav-icon"></i>';
		    document.getElementById("selectSize").value = '${ selectSize }';

		    $('#startDate').datetimepicker({
		    	timepicker:false,
		    	format:'Y/m/d',
		    	mask:true,
		    });
		    

		    $('#endDate').datetimepicker({
		    	timepicker:false,
		    	format:'Y/m/d',
		    	mask:true,
		    });
		    
			//查詢資料
			function doquery(pageIndex) {
				var radios = document.getElementsByName('reportModel');
			    for (var radio of radios)
			    {
			        if (radio.checked) {
			        	
			        }
			    }
			    document.getElementById("pageIndex").value = pageIndex;
				document.getElementById("pageSize").value = document.getElementById("selectSize").value;
				document.getElementById("state").value = "query";
				document.myForm.submit();
			}

			//清除查詢資料
			function doClear(num) {
				document.getElementById("productId").value = null;
				document.getElementById("memberId").value = null;
				document.getElementById("startDate").value = null;
				document.getElementById("endDate").value = null;
				if(num == 0) {
					const old_tbody = document.getElementById("shoppingCartBody")
			    	const new_tbody = document.createElement('tbody');
					if(old_tbody != null) {
						old_tbody.parentNode.replaceChild(new_tbody, old_tbody)
					}
				}
				
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
		</script>
	</body>
</html>