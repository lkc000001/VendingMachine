<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="zh-Hant-TW">
	<head>
    	<meta name="viewport" content="width=device-width" />
	    <title>購物車</title>
	
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
		                <span class="title-text" id="showtitle">購物車</span>
		            </div>
					<!-- 搜尋bar -->
		            <form id="myForm" name="myForm">
		            	<input type="hidden" id="deleteIndex">
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
			                    	<label>
				                    	<span class="text" >姓　　名：</span>
				                        <input class="modal-readonly" type="text" id="name" name="name" readonly="readonly" value="${ member.name }">   
			                    	</label>
			                    	&nbsp;&nbsp;&nbsp;
			                    	<label>
				                        <span class="text" >錢包餘額：</span>
				                        <input class="modal-readonly" type="text" id="wallet" name="wallet" readonly="readonly" value="${ totalAmount }">   
			                   		</label>
			                    </div>
			                </div>
			                <div class="search-block-line btnventer">
			                	<div class="btn searchbtn btn-success" onclick="doAmount();">儲值</div>
			                    &nbsp;&nbsp;
			                    <div class="btn searchbtn newbtn-blue" id="checkout" onclick="doSave();">結帳</div>
			                </div>
			            </div>
		            </form>
		            <div>
						<form class="pure-form">
							<fieldset>
								<legend>商品清單</legend>
								<table class="pure-table pure-table-bordered " id="shoppingCartTable">
									<c:if test="${fn:length(shoppingCarts) == 0 }">
										<thead>
										<tr>
											<td> 你尚未選購任何商品 </td>
										</tr>
										</thead>
									</c:if>
									<c:if test="${fn:length(shoppingCarts) > 0 }">
									<thead>
										<tr>
											<th width=6%>項次</th>
											<th width=10%>圖片</th>
											<th width=8%>商品ID</th>
											<th width=24%>商品名稱</th>
											<th width=10%>數量</th>
											<th width=10%>單價</th>
											<th width=10%>金額</th>
											<th width=10%>修改數量</th>
											<th width=10%>取消</th>
											<th class="controlhidden"></th>
										</tr>
									</thead>
									<tbody id="productBody">
										<c:forEach varStatus="status" var="shoppingCart" items="${ shoppingCarts }">
											<tr>
												<td>${ status.index + 1 }</td>
												<td><img class="sellImg" border="0" src="<%=request.getContextPath()%>/DrinksImage/${ shoppingCart.productImage }">	</td>
												<td>${ shoppingCart.productId }</td>
												<td>${ shoppingCart.productName }</td>
												<td>${ shoppingCart.buyQuantity }</td>
												<td>${ shoppingCart.productPrice }</td>
												<td>${ shoppingCart.total }</td>
												<td><a href="javascript:doUpdateConfirm(${ status.index })" class="btn shoppingbtn btn-warning">修改數量</a></td>
												<td><a href="javascript:doDeleteConfirm(${ status.index })" class="btn shoppingbtn btn-danger">取消</a></td>
												<td class="controlhidden">${ shoppingCart.productStock }</td>
											</tr>
										</c:forEach>
										<tr>
											<td colspan="6"> <div class="showright">總價 </div></td>
											<td colspan="3"> ${ totalSum } </td>
										</tr>
									</tbody>
									</c:if>
								</table>
							</fieldset>
						</form>
		            </div>
		        </div>
		    </div>
		
		<div class="modal fade" id="updateModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title" id="UpdateModalTitle"></h4>
						</div>
						<div class="wordWrap modal-body">
							<form>
					            <div class="search-block">
					            	<div class="search-block-line">
				                        <label>
				                            <label for="name">項　　次：</label>
					                		<input type="text" id="updateIndex" class="modal-readonly" readonly="readonly">
				                        </label>
					                </div>
					                <div class="search-block-line">
				                        <label>
				                            <label for="name">商品名稱：</label>
					                		<input type="text" id="updateName" class="modal-readonly" readonly="readonly">
				                        </label>
					                </div>
					                <div class="search-block-line">
				                        <label>
				                            <label for="name">庫　　存：</label>
					                		<input type="text" id="updateStock" class="modal-readonly" readonly="readonly">
				                        </label>
					                </div>
					                <div class="search-block-line">
				                        <label>
				                            <label for="pwd">修改數量：</label>
					                		<input type="number" id="updateBuyQuantity" min="0" max="30" size="5">
				                        </label>
					                </div>
					            </div>
							</form>
							<div class="error" id="headerError"><br><br></div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn newbtn-gray" data-bs-dismiss="modal">關閉</button>
							&nbsp;&nbsp;
							<button type="button" class="btn newbtn-yellow" onclick="doUpdateBuyQty();">修改</button>
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
			let shoppingCartsLength = ${ fn:length(shoppingCarts) };
			let totalError = ${ totalError };
			//console.log(totalError);
			//沒有訂購項目或錢包餘額不足時,不可按結帳
			if(shoppingCartsLength == '0' || totalError != 'null') {
				document.getElementById("checkout").className = " btn searchbtn checkoutBtn ";
			}
			//錢包餘額不足時顯示錯誤
			if(totalError != 'null') {
				showMsg('', totalError)
			}
			
			//結帳
		    function doSave() {
				$.ajax({
                   url: '<%=request.getContextPath()%>/shoppingCart',
                   type: "POST",
                   dataType: "json",
                   success: function(data) {
	                   if(data.result == true) {
	                	   	window.location.reload();
	                	   	showUpdateMsg('', data.message)
	                   } else {
	                   		showMsg("錯誤", data.message);
	                   }
                   },
                   error: function(error) {
                   	let msg = showMsg("錯誤", error.responseJSON.message);
                   }
               })
			}
			
		  	//顯示修改介面
			function doUpdateConfirm(index) {
				let product = document.getElementById("shoppingCartTable").rows[index+1];
				document.getElementById("updateIndex").value = index + 1;
				document.getElementById("updateName").value = product.cells[3].innerHTML;
				document.getElementById("updateStock").value = product.cells[9].innerHTML;
				document.getElementById("updateBuyQuantity").value = product.cells[4].innerHTML;
        		$('#updateModal').modal('show');
			}
			
			//修改數量
		    function doUpdateBuyQty() {
		    	if(doConfirm()) {
			    	let index = document.getElementById("updateIndex").value - 1;
			    	let updateIndex = "updateIndex=" +  index ;
			    	let buyQty = "&buyQty=" + document.getElementById("updateBuyQuantity").value;
			    	
			    	$.ajax({
	                    url: '<%=request.getContextPath()%>/addShoppingCart?' + updateIndex + buyQty,
	                    type: "PUT",
	                    dataType: "json",
	                    success: function(data) {
	                    	if(data.result == true) {
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
		    
		  	//刪除時確認
			function doDeleteConfirm(index) {
				document.getElementById("deleteIndex").value = index;
				let deleteProduct = '確認是否取消訂購: ' + document.getElementById("shoppingCartTable").rows[index+1].cells[3].innerHTML;
				document.getElementById("deleteModalTitle").innerHTML = '取消訂購商品';
        		document.getElementById("deleteModalBoby").innerHTML = deleteProduct;
        		document.getElementById("deleteModalBut").style.display = 'block';
        		$('#deleteModal').modal('show');
			}
		  
			//取消
			function dodelete() {
				const id = document.getElementById("deleteIndex").value;
				let deleteid = "deleteid=" + id ;
				$.ajax({
                    url: '<%=request.getContextPath()%>/shoppingCart?' + deleteid,
                    type: 'DELETE',
                    success: function(data) {
                    	window.location.reload();
                    },
                    error: function(error) {
                 	   showMsg("錯誤", error);
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
			function showUpdateMsg(title, msg) {
				document.getElementById("deleteModalTitle").innerHTML = title;
        		document.getElementById("deleteModalBoby").innerHTML = msg;
        		document.getElementById("deleteModalBut").style.display = 'none';
        		$('#deleteModal').modal('show');
			}
			
			//修改數量確認
			function doConfirm() {
				if (document.getElementById("updateBuyQuantity").value <= '0') {
					showUpdateMsg("錯誤", "購買數量不能小於1")
					return false;
				}
				
				let buyQuantity = document.getElementById("updateBuyQuantity").value;
				let updateStock = document.getElementById("updateStock").value;
				if (parseInt(buyQuantity) > parseInt(updateStock)) {
					showUpdateMsg("錯誤", "購買數量不能大於庫存數量")
					return false;
				}
				
				return true;
			}
			
			//轉至儲值頁面
			function doAmount(){
				window.location.href="<%=request.getContextPath()%>/wallet";
			}
			
		</script>
	</body>
</html>