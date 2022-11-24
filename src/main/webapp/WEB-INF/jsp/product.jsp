<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="zh-Hant-TW">
	<head>
    	<meta name="viewport" content="width=device-width" />
	    <title>商品資料管理</title>
	
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
		                <span class="title-text" id="showtitle">商品資料管理</span>
		            </div>
					<!-- 搜尋bar -->
		            <form id="myForm" name="myForm" method="GET" action="<%=request.getContextPath()%>/product">
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
			                    	&nbsp;&nbsp;&nbsp;
			                        <label>
			                            <span class="text" >是否啟用：</span>
			                            <select id="enabled" name="enabled">
										    <option value="" selected></option>
										    <option value="0">未啟用</option>
										    <option value="1">啟用</option>
										</select>                  
			                        </label>
			                    </div>
			                </div>
			                
			                <div class="search-block-line btnventer">
			                    <div class="btn searchbtn newbtn-gray" onclick="doClear(0);">清除</div>
			                    &nbsp;&nbsp;
			                    <div class="btn searchbtn newbtn-yellow" onclick="doquery(1);">搜尋</div>
			                    &nbsp;&nbsp;
			                    <div class="btn searchbtn newbtn-blue" onclick="doSaveModal();">新增</div>
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
											<th width=15%>商品名稱</th>
											<th width=8%>單價</th>
											<th width=8%>成本</th>
											<th width=8%>庫存</th>
											<th width=5%>單位</th>
											<th width=10%>分頖</th>
											<th width=10%>圖片位置</th>
											<th width=10%>建立日期</th>
											<th width=8%>狀態</th>
											<th width=10%>編輯</th>
										</tr>
									</thead>
									<tbody id="productBody">
										<c:forEach varStatus="status" var="product" items="${ products }">
											<tr>
												<td>${ product.id }</td>
												<td>${ product.name }</td>
												<td>${ product.price }</td>
												<td>${ product.cost }</td>
												<td>${ product.stock }</td>
												<td>${ product.unit }</td>
												<td>${ product.classify }</td>
												<td>${ product.image }</td>
												<td>
													<fmt:formatDate value="${ product.createtime }" pattern="yyyy-MM-dd"/>
												</td>
												<td>${ product.enabled }</td>
												<td><a href="javascript:doUpdateModal(${ status.index })" class="btn searchbtn btn-success">編輯</a></td>
											</tr>
										</c:forEach>
										<c:if test="${ totalPage > 1 }">
											<td colspan="11">
												<div id="pageDiv">${ showPage }</div>
											</td>
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
						                            <input type="text" class="modal-readonly" id="updateId" name="id" readonly="readonly">
						                        </label>
							                </div>
							                <div class="search-block-line">
						                        <label>
						                            <span class="text">商品名稱：</span>
						                            <input type="text" id="updateName" name="name">
						                        </label>
							                </div>
							                <div class="search-block-line">
						                        <label>
						                            <span class="text">單　　價：</span>
						                            <input type="text" id="updatePrice" name=price>
						                        </label>
							                </div>
							                <div class="search-block-line">
						                        <label>
						                            <span class="text">成　　本：</span>
						                            <input type="text" id="updateCost" name="cost">
						                        </label>
							                </div>
							                <div class="search-block-line" id="updatePwdDvi">
						                        <label>
						                            <span class="text">庫　　存：</span>
						                            <input type="text" id="updateStock" name="stock">
						                        </label>
							                </div>
							                <div class="search-block-line">
						                        <label>
						                            <span class="text">單　　位：</span>
						                            <select id="updateUnit" name="unit">
														<option value="個" selected>個</option>
													    <option value="瓶">瓶</option>
													    <option value="隻">隻</option>
													</select>  	
						                        </label>
							                </div>
							                <div class="search-block-line" id="updatePwdDvi">
						                        <label>
						                            <span class="text">分　　類：</span>
						                            <input type="text" id="updateClassify" name="classify">
						                        </label>
							                </div>
							                <div class="search-block-line" id="updatePwdDvi">
						                        <div>
						                       		<span class="text">圖片位置：</span>
						                        	<label>
							                            <input type="file" id="updateimage">
							                            <input type="text" class="modal-readonly" id="imageName" name="image" readonly="readonly">
						                        	</label>
						                        	<div class="btn btn-warning" id="imagebtn" onclick="doChangeImage();">更換圖片</div>
						                        </div>
							                </div>
							                <div class="search-block-line">
						                        <label>
						                            <span class="text">是否啟用：</span>
						                            <select id="updateEnabled" name="enabled">
													    <option value="0">未啟用</option>
													    <option value="1" selected>啟用</option>
													</select>  		                            
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
									<button type="button" id="showdelete" class="btn modal-delete-btn" onclick="doDeleteConfirm();">刪除</button>
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
	
		<script src="<%=request.getContextPath()%>/component/jQuery/jquery-3.6.0.min.js"></script>
	    <script src="<%=request.getContextPath()%>/component/jQuery-UI/jquery-ui-1.12.1.min.js"></script>
	    <script src="<%=request.getContextPath()%>/component/Bootstrap/bootstrap.bundle.min.js"></script>
	    <script src="<%=request.getContextPath()%>/component/overlayScrollbars/jquery.overlayScrollbars.min.js"></script>
	    <script src="<%=request.getContextPath()%>/component/AdminLTE/adminlte-3.1.0.min.js"></script>
	    <script src="<%=request.getContextPath()%>/component/js/all.js"></script>
		<script src="<%=request.getContextPath()%>/component/js/util.js"></script>
			
		<script>
		    document.getElementById(${ selectFunction }).innerHTML = '<i class="fa-solid fa-circle nav-icon"></i>';
		    document.getElementById("selectSize").value = '${ selectSize }';
		    
		    function dosave() {
				const id = document.getElementById("updateId").value;
				let touploadFile = 0;
				if (document.getElementById("updateimage").style.display == 'none') {
					touploadFile = 1;
				}
				if(touploadFile == 0) {
					const fileResp = uploadFile();
					if(fileResp == false) {
						return false;
					} else {
						console.log(document.getElementById("deleteModalTitle").innerHTML);
						if(document.getElementById("deleteModalTitle").innerHTML == '錯誤') {
							document.getElementById("deleteModalBut").style.display = 'none';
			        		$('#deleteModal').modal('show');
						} 
					}
				}
				
				//console.log(array1.shift());
				if(id != '' || checkData()){
					let methodType = 'POST';
					let formArray = $("#updateForm").serializeArray();
					if(id == '') {
						formArray.shift();
						methodType = 'POST';
					} else {
						methodType = 'PUT';
					}
					$.ajax({
	                    url: '<%=request.getContextPath()%>/product',
	                    type: methodType,
	                    dataType: "json",
	        		    contentType:"application/json; charset=utf-8",
	                    data: JSON.stringify(objectifyForm(formArray)),
	                    success: function(data) {
	                    	//console.log(data);
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

			function dodelete() {
				const id = document.getElementById("updateId").value;
				let deleteid = "deleteid=" + id ;
				//console.log(deleteid);
				$.ajax({
                       url: '<%=request.getContextPath()%>/product?' + deleteid,
                       type: 'DELETE',
                       success: function(data) {
	                       showMsg("刪除結果", "刪除成功");
	                       doClear(0);
                       },
                       error: function(error) {
                    	   showMsg("錯誤", error);
                    	   doClear(0);
                       }
                   })
			}
			
			//清除查詢資料
			function doClear(num) {
				document.getElementById("id").value = null;
				document.getElementById("name").value = null;
				document.getElementById("enabled").value = null;
				document.getElementById("updateId").value = null;
				document.getElementById("updateName").value = null;
				document.getElementById("updatePrice").value = null;
				document.getElementById("updateCost").value = null;
				document.getElementById("updateStock").value = null;
				document.getElementById("updateUnit").value = null;
				document.getElementById("updateClassify").value = null;
				document.getElementById("updateimage").value = null;
				document.getElementById("updateName").value = null;
				if(num == 0) {
					const old_tbody = document.getElementById("productBody")
			    	const new_tbody = document.createElement('tbody');
					if(old_tbody != null) {
						old_tbody.parentNode.replaceChild(new_tbody, old_tbody);
					}
				}
				
			}
			
			function doSaveModal() {
				doClear(0);
				document.getElementById("error").innerHTML = "";
				document.getElementById("updateModalTitle").innerHTML = '新增商品資料';
				document.getElementById("updateIdDvi").style.display = 'none';
        		document.getElementById("showdelete").style.display = 'none';
        		document.getElementById("imageName").style.display = 'none';
        		document.getElementById("imagebtn").style.display = 'none';
        		document.getElementById("updateimage").style.display = 'block';
        		$('#updateModal').modal('show');
			}
			
			function doUpdateModal(index) {
				doClear(1);
				var member = document.getElementById("productTable").rows[index+1];
				document.getElementById("error").innerHTML = "";
				document.getElementById("updateModalTitle").innerHTML = '編輯商品資料';
				document.getElementById("updateIdDvi").style.display = 'block';
        		document.getElementById("showdelete").style.display = 'block';
        		document.getElementById("imageName").style.display = 'block';
        		document.getElementById("imagebtn").style.display = 'inline-block';
        		document.getElementById("updateimage").style.display = 'none';
        		
        		document.getElementById("updateId").value = member.cells[0].innerHTML;
        		document.getElementById("updateName").value = member.cells[1].innerHTML;
        		document.getElementById("updatePrice").value = member.cells[2].innerHTML;
        		document.getElementById("updateCost").value = member.cells[3].innerHTML;
        		document.getElementById("updateStock").value = member.cells[4].innerHTML;
        		document.getElementById("updateUnit").value = member.cells[5].innerHTML;
        		document.getElementById("updateClassify").value = member.cells[6].innerHTML;
        		document.getElementById("imageName").value = member.cells[7].innerHTML;
        		
        		let enable;
        		const isEnabled = member.cells[9].innerHTML;
        		if( isEnabled =="啟用") {
        			enable = 1;
        		} else {
        			enable = 0;
        		}
        		document.getElementById("updateEnabled").value = enable;
        		//console.log(table);
        		$('#updateModal').modal('show');
			}
			
			function checkData() {
				if (document.getElementById("updateName").value == '') {
					showMsg("錯誤", "商品名稱不能為空白")
					return false;
				}
				return true;
			}
			
			function setvalue() {
				let checkvalue = document.getElementById("updateEnabled").value;
				document.getElementById("updateEnabled").value = checkvalue == 0 ? 1 : 0;
			}

			function showMsg(title, msg) {
				document.getElementById("myModalLabel").innerHTML = title;
				document.getElementById("myModalBoby").innerHTML = msg;
				document.getElementById("btnModal").click();
			}
			
			function doDeleteConfirm() {
				document.getElementById("deleteModalTitle").innerHTML = '刪除資料';
        		document.getElementById("deleteModalBoby").innerHTML = '是否確認刪除';
        		document.getElementById("deleteModalBut").style.display = 'block';
        		$('#deleteModal').modal('show');
			}
			
			function doConfirm(title, msg) {
				document.getElementById("deleteModalTitle").innerHTML = title;
        		document.getElementById("deleteModalBoby").innerHTML = msg;
        		document.getElementById("deleteModalBut").style.display = 'none';
        		$('#deleteModal').modal('show');
			}
			
			function uploadFile() {
				const selectedFile = document.getElementById('updateimage').files[0];
				if (selectedFile == undefined) {
					doConfirm("錯誤", "尚未選擇檔案");
					return false;
			    }
				
				let extname = selectedFile.name.substring(selectedFile.name.lastIndexOf(".")+1).toLowerCase();
				document.getElementById("imageName").value = selectedFile.name;
				if(extname != 'jpg' && extname != 'png' ) {
					doConfirm("錯誤", "只可上傳JPG,PNG檔案");
					return false;
				}
				
				let filterData = new FormData(); 
				filterData.append("uploadFile", selectedFile);
				fetch('<%=request.getContextPath()%>/uploadFile', {
					  method: 'POST',
					  body: filterData,
					})
					.then((response) => {
						return response.json();
				    })
				    .then((resp) => {
				    	if (resp.result == false) {
				    		document.getElementById("deleteModalTitle").innerHTML = '錯誤';
			        		document.getElementById("deleteModalBoby").innerHTML = resp.message;
				    	} else {
				    		document.getElementById("deleteModalTitle").innerHTML = '';
			        		document.getElementById("deleteModalBoby").innerHTML = '';
				    	}
				    })
				return true;
			}
			
			function doChangeImage() {
				document.getElementById("imageName").style.display = 'none';
        		document.getElementById("imagebtn").style.display = 'none';
        		document.getElementById("updateimage").style.display = 'block';
			}
			
		</script>
	</body>
</html>