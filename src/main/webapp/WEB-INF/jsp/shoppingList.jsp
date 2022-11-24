<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="zh-Hant-TW">
	<head>
    	<meta name="viewport" content="width=device-width" />
	    <title>購買清單</title>
	
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
		                <span class="title-text" id="showtitle">購買清單</span>
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
			            </div>
		            </form>
		            <div>
						<form class="pure-form">
							<fieldset>
								<legend>購買清單</legend>
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
										<tbody id="productBody">
											<c:forEach varStatus="status" var="orderId" items="${ groupByOrderId }">
												<c:set var="num" value="1" />
												<c:forEach varStatus="status" var="shoppingList" items="${ orderId.value }">
													<c:set var="len" value="${ orderId.value }" />
													<tr>
													<c:if test="${num == 1 }">
														<td rowspan="${fn:length(len)}">${ orderId.key }</td>
													</c:if>
														<td>${ shoppingList.productId }</td>
														<td>${ shoppingList.productName }</td>
														<td>${ shoppingList.buyQuantity }</td>
														<td>${ shoppingList.productPrice }</td>
														<td>${ shoppingList.total }</td>
														<td>
															<fmt:formatDate value="${ shoppingList.createtime }" pattern="yyyy-MM-dd HH:mm:ss"/>
														</td>
													</tr>
													<c:set var="num" value="2" />
												</c:forEach>
											</c:forEach>
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
		</script>
	</body>
</html>