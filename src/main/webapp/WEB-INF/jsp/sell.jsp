<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="zh-Hant-TW">
	<head>
    	<meta name="viewport" content="width=device-width" />
	    <title>商品首頁</title>
	
	    <link href="<%=request.getContextPath()%>/component/jQuery-UI/jquery-ui-1.12.1.min.css" rel="stylesheet" />
	    <link href="<%=request.getContextPath()%>/component/jQuery-UI/jquery-ui.theme-1.12.1.min.css" rel="stylesheet" />
	    <link href="<%=request.getContextPath()%>/component/Font-Awesome/css/all.css" rel="stylesheet" />
	    <link href="<%=request.getContextPath()%>/component/Bootstrap/bootstrap.min.css" rel="stylesheet" />
	    <link href="<%=request.getContextPath()%>/component/overlayScrollbars/OverlayScrollbars.min.css" rel="stylesheet" />
	    <link href="<%=request.getContextPath()%>/component/AdminLTE/adminlte-3.1.0.min.css" rel="stylesheet" />
	    <link href="<%=request.getContextPath()%>/component/css/style.css" rel="stylesheet" >
	    <link href="<%=request.getContextPath()%>/component/css/jsgrid.min.css" />
	    
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
					<!-- 搜尋bar -->
		            <form id="myForm" name="myForm" action="<%=request.getContextPath()%>/sell">
			            <input type="hidden" id="state" name="state" value="query">
			            <input type="hidden" id="pageIndex" name="pageIndex">     
			            <div class="search-block">
			                <div class="search-block-line">
			                    <div>
			                    	<label>
			                            <span class="text" >商品名稱：</span>
			                            <input type="text" id="name" name="name">     
			                        </label>
			                    	&nbsp;&nbsp;&nbsp;
			                    	<label>
			                            <span class="text" >分　　類：</span>
			                            <input type="text" id="classify" name="classify">     
			                        </label>
			                    </div>
			                    <div class="search-block-line btnventer">
				                    <div class="btn searchbtn newbtn-yellow" onclick="doquery(1);">搜尋</div>
			                	</div>
			                </div>
			            </div>
		            </form>
		            <div>
						<form class="pure-form">
							<table class="pure-table pure-table-bordered " id="productTable">
								<tr>
									<td colspan="3">
										<span class="text" >購物車數量：</span>
			                            <input type="text" id="shoppingCartNumber" value="0" readonly="readonly">     
									</td>
								</tr>
								<c:forEach varStatus="status" var="product" items="${ products }">
									<c:if test="${ status.index % 3 == 0}">
										<tr>
									</c:if>
									<td width="25%" height="20%">	
										<c:if test="${ product.id != null}">
											<span class="sellTitleText" >${ product.name }</span>						
											<span class="sellTitleAmountText" >${ product.price } 元 / ${ product.unit } </span>		
											
											<img class="sellImg" border="0" src="${ product.image }">						
											<br/>
											<font face="微軟正黑體" size="3">
												<input type="hidden" name="goodsID" value="1">
												購買<input type="number" id="buyQuantity${ product.id }" min="0" max="30" size="5" value="0">${ product.unit }	
												<div class="btn newbtn-yellow" onclick="doShoppingCart(${ product.id }, ${ product.stock });">加入購物車</div>
												<br><p style="color: red;">(庫存 ${ product.stock } ${ product.unit })</p>
											</font>	
										</c:if>	
									</td>	
									<c:if test="${ (status.index + 1) % 3 == 0}">
										</tr>
									</c:if>			
								</c:forEach>
								<c:if test="${ totalPage > 1 }">
									<tr>
										<td colspan="3">
											<div id="pageDiv">${ showPage }</div>
										</td>
									</tr>
								</c:if>
							</table>
						</form>
		            </div>
		        </div>
		    </div>
		
			<div class="modal fade" id="headerLoginModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title" id="headerLoginTitle"></h4>
						</div>
						<div class="wordWrap modal-body">
							<form id="headerLoginForm" name="headerLoginForm">
					            <div class="search-block">
					            	<div class="search-block-line controlhidden">
				                        <label>
				                            <label for="name">使用者名稱：</label>
					                <input type="text" id="account" name="account">
				                        </label>
					                </div>
					                <div class="search-block-line">
				                        <label>
				                            <label for="pwd">使用者密碼：</label>
					                		<input type="password" id="pwd" name="pwd" maxlength="20">
				                        </label>
					                </div>
					            </div>
							</form>
							<div class="error" id="headerError"><br><br></div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn newbtn-gray" data-bs-dismiss="modal">關閉</button>
							&nbsp;
							<button type="button" class="btn newbtn-gray" onclick="doClear();">清除</button>
							&nbsp;&nbsp;
							<button type="button" class="btn newbtn-yellow" onclick="doLogin();">登入</button>
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
	
		<script src="<c:url value="/component/jQuery/jquery-3.6.0.min.js"/>"></script>
		<script src="<c:url value="/component/jQuery-UI/jquery-ui-1.12.1.min.js"/>"></script>
		<script src="<c:url value="/component/Bootstrap/bootstrap.bundle.min.js"/>"></script>
		<script src="<c:url value="/component/overlayScrollbars/jquery.overlayScrollbars.min.js"/>"></script>
		<script src="<c:url value="/component/AdminLTE/adminlte-3.1.0.min.js"/>"></script>
		<script src="<c:url value="/component/js/all.js"/>"></script>
		<script src="<c:url value="/component/js/util.js"/>"></script>
		
		<script>
		    document.getElementById(${ selectFunction }).innerHTML = '<i class="fa-solid fa-circle nav-icon"></i>';
			//查詢資料
			function doquery(pageIndex) {
				document.getElementById("pageIndex").value = pageIndex;
				document.getElementById("state").value = "query";
				document.myForm.submit();
			}

			function doShoppingCart(id, stock) {
				if(role != 9 && role != 8 && role != 1) {
					document.getElementById("headerError").innerHTML = "你尚未登入<BR>請先登入";
					doShowLogin();
					return false;
				}
				
				let buyQuantity = document.getElementById("buyQuantity" + id).value;
				if (parseInt(buyQuantity) <= 0) {
					showMsg("錯誤", "購買數量不能小於1")
					return false;
				}
				
				if (parseInt(buyQuantity) > parseInt(stock)) {
					showMsg("錯誤", "購買數量不能大於庫存數量")
					return false;
				}
				
				var requDate = {"productId":id, "buyQuantity": $('#buyQuantity'+id).val()}
				
				$.ajax({
                    url: '<%=request.getContextPath()%>/addShoppingCart',
                    type: "POST",
                    dataType: "json",
        		    contentType:"application/json; charset=utf-8",
                    data: JSON.stringify(requDate) ,
                    success: function(data) {
                    	//console.log(data);
                    	if(data.result == true) {
                    		document.getElementById("shoppingCartNumber").value = data.data;
                    		showMsg("", data.message);
                    	} else {
                    		showMsg("錯誤", data.message);
                    	}
                    },
                    error: function(error) {
                    	let msg = showMsg("錯誤", error.responseJSON.message);
                    }
                })
			}
			
			//顯示MSG,按關閉或空白地方可離開
			function showMsg(title, msg) {
				document.getElementById("myModalLabel").innerHTML = title;
				document.getElementById("myModalBoby").innerHTML = msg;
				document.getElementById("btnModal").click();
			}
			
			//顯示MSG,按關閉可離開
			function doConfirm(title, msg) {
				document.getElementById("deleteModalTitle").innerHTML = title;
        		document.getElementById("deleteModalBoby").innerHTML = msg;
        		document.getElementById("deleteModalBut").style.display = 'none';
        		$('#deleteModal').modal('show');
			}
			
			//登入認證
		   	function doLogin() {
				if (checkData()) {
					let url = '<%=request.getContextPath()%>/login';
					let data = objectifyForm($("#headerLoginForm").serializeArray());
					queryajax(url, 'POST', data, 1);
				 }
		   	}
		   	
		   	//清除查詢資料
			function doClear() {
				document.getElementById("account").value = null;
				document.getElementById("pwd").value = null;
				document.getElementById("headerError").value = null;
			}
		   	
			//檢查欄位是否為空白
			function checkData() {
				if (document.getElementById("account").value == '') {
					document.getElementById("headerError").innerHTML = "帳號不能為空白 <br> &nbsp;";
					return false;
				}
				
				if (document.getElementById("pwd").value == '') {
					document.getElementById("headerError").innerHTML = "密碼不能為空白 <br> &nbsp;";
					return false;
				}
				return true;
			}
			
			function queryajax(apiUrl, methodType, requData, func) {
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
					    		document.getElementById("headerError").innerHTML = data.message;
					    	} else {
					    		if(func == 1) {
					    			window.location.href="<%=request.getContextPath()%>/sell";
					    		}
					    	}
					    },
					    error: function (error) {
					    	document.getElementById("headerError").innerHTML = error;
					   	}
					});
			}
			
			//顯示登入介面
			function doShowLogin() {
				$('#headerLoginModal').modal('show');
			}
		</script>
	</body>
</html>