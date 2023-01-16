<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="zh-Hant-TW">
	<head>
    	<meta name="viewport" content="width=device-width" />
	    <title>庫存管理</title>
	   <%@ include file="utilcss.jsp" %>
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
		                <span class="title-text" id="showtitle">庫存管理</span>
		            </div>
					<!-- 搜尋bar -->
		            <form id="myForm" name="myForm" method="GET" action="<%=request.getContextPath()%>/stock">
			            <input type="hidden" id="state" name="state" value="query">
			            <input type="hidden" id="pageIndex" name="pageIndex"> 
			            <input type="hidden" id="pageSize" name="pageSize"> 
			            <div class="search-block">
			                <div class="search-block-line">
			                    <div>
			                    	<label>
			                            <span class="text" >　　　ID：</span>
			                            <input type="text" id="id" name="id">
			                        </label>
			                    	&nbsp;&nbsp;&nbsp;
			                    	<label>
			                            <span class="text" >商品名稱：</span>
			                            <input type="text" id="name" name="name">     
			                        </label>
			                    </div>
			                </div>
			                <div class="search-block-line">
			                    <div>
			                    	<label>
			                            <span class="text" >分　　類：</span>
			                            <input type="text" id="classify" name="classify">     
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
								<table class="pure-table pure-table-bordered " id="productTable">
									<thead>
										<tr>
											<th width=5%>ID</th>
											<th width=25%>商品名稱</th>
											<th width=8%>成本</th>
											<th width=8%>庫存</th>
											<th width=8%>單位</th>
											<th width=10%>分頖</th>
											<th width=10%>採購</th>
										</tr>
									</thead>
									<tbody id="productBody">
										<c:forEach varStatus="status" var="product" items="${ products }">
											<tr>
												<td>${ product.id }</td>
												<td>${ product.name }</td>
												<td>${ product.cost }</td>
												<td>${ product.stock }</td>
												<td>${ product.unit }</td>
												<td>${ product.classify }</td>
												<td><a href="javascript:doUpdateModal(${ status.index })" class="btn searchbtn btn-success">採購</a></td>
											</tr>
										</c:forEach>
										<c:if test="${ totalPage > 1 }">
											<tr>
												<td colspan="11">
													<div id="pageDiv">${ showPage }</div>
												</td>
											</tr>
										</c:if>
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
						                            <span class="text" >　　　ID：</span>
						                            <input type="text"  id="updateId" name="productId" class="modal-readonly" readonly="readonly">
						                        </label>
							                </div>
							                <div class="search-block-line">
						                        <label>
						                            <span class="text">商品名稱：</span>
						                            <input type="text" id="updateName" name="name" class="modal-readonly" readonly="readonly">
						                        </label>
							                </div>
							                <div class="search-block-line" id="updatePwdDvi">
						                        <label>
						                            <span class="text">庫　　存：</span>
						                            <input type="text" id="updateStock" name="stock" class="modal-readonly" readonly="readonly">
						                        </label>
							                </div>
							                <div class="search-block-line">
						                        <label>
						                            <span class="text">單　　位：</span>
						                            <select id="updateUnit" name="unit" class="modal-readonly" readonly="readonly">
														<option value="個" selected>個</option>
													    <option value="瓶">瓶</option>
													    <option value="隻">隻</option>
													</select>  	
						                        </label>
							                </div>
							                <div class="search-block-line" id="updatePwdDvi">
						                        <label>
						                            <span class="text">分　　類：</span>
						                            <input type="text" id="updateClassify" name="classify" class="modal-readonly" readonly="readonly">
						                        </label>
							                </div>
							                <div class="search-block-line">
						                        <label>
						                            <span class="text">成　　本：</span>
						                            <input type="number" id="updateCost" name="productCost">
						                        </label>
							                </div>
							                <div class="search-block-line">
						                        <label>
						                            <span class="text">採購數量：</span>
						                            <input type="number" id="purchaseQuantity" name="quantity">
						                        </label>
							                </div>
							                
							            </div>
									</form>
									<div class="error" id="error"></div>
								</div>
								
								<div class="modal-footer">
								 	<button type="button" class="btn newbtn-gray" data-bs-dismiss="modal">關閉</button>
								 	&nbsp;&nbsp;
									<button type="button" id="saveConfirmbtn" class="btn btn-primary" onclick="dosave();">儲存</button>
									
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
	
		<%@ include file="utilts.jsp" %>
			
		<script>
		    document.getElementById(${ selectFunction }).innerHTML = '<i class="fa-solid fa-circle nav-icon"></i>';
		    document.getElementById("selectSize").value = '${ selectSize }';
		    
		    function dosave() {
				//console.log(array1.shift());
				if(checkData()){
					let formArray = $("#updateForm").serializeArray();
					$.ajax({
	                    url: '<%=request.getContextPath()%>/stock',
	                    type: "POST",
	                    dataType: "json",
	        		    contentType:"application/json; charset=utf-8",
	                    data: JSON.stringify(objectifyForm(formArray)),
	                    success: function(data) {
	                    	if(data.result == true) {
	                    		showMsg("", data.message);
	                    		doClear(0);
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

			//查詢資料
			function doquery(pageIndex) {
				document.getElementById("pageIndex").value = pageIndex;
				document.getElementById("pageSize").value = document.getElementById("selectSize").value;
				document.getElementById("state").value = "query";
				document.myForm.submit();
			}

			//清除查詢資料
			function doClear(num) {
				document.getElementById("id").value = null;
				document.getElementById("name").value = null;
				document.getElementById("classify").value = null;
				document.getElementById("updateId").value = null;
				document.getElementById("updateCost").value = null;
				document.getElementById("updateStock").value = null;
				document.getElementById("updateUnit").value = null;
				document.getElementById("updateClassify").value = null;
				document.getElementById("updateName").value = null;
				document.getElementById("purchaseQuantity").value = null;
				if(num == 0) {
					const old_tbody = document.getElementById("productBody")
			    	const new_tbody = document.createElement('tbody');
					if(old_tbody != null) {
						old_tbody.parentNode.replaceChild(new_tbody, old_tbody);
					}
				}
				
			}
			
			function doUpdateModal(index) {
				doClear(1);
				var member = document.getElementById("productTable").rows[index+1];
				document.getElementById("error").innerHTML = "";
				document.getElementById("updateModalTitle").innerHTML = '編輯商品資料';
        		
        		document.getElementById("updateId").value = member.cells[0].innerHTML;
        		document.getElementById("updateName").value = member.cells[1].innerHTML;
        		document.getElementById("updateCost").value = member.cells[2].innerHTML;
        		document.getElementById("updateStock").value = member.cells[3].innerHTML;
        		document.getElementById("updateUnit").value = member.cells[4].innerHTML;
        		document.getElementById("updateClassify").value = member.cells[5].innerHTML;

        		$('#updateModal').modal('show');
			}
			
			function checkData() {
				let cost = document.getElementById("updateCost").value;
				let stock = document.getElementById("purchaseQuantity").value;

				if (cost =='' || parseInt(cost) < 0) {
					doConfirm("錯誤", "成本不能小於0")
					return false;
				}
				if (stock =='' || parseInt(stock) <= 0) {
					doConfirm("錯誤", "採購數量不能小於1")
					return false;
				}
				return true;
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