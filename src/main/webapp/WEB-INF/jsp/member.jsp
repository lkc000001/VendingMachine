<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="zh-Hant-TW">
	<head>
    	<meta name="viewport" content="width=device-width" />
	    <title>會員資料管理</title>
	
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
		                <span class="title-text" id="showtitle">會員資料管理</span>
		            </div>
					<!-- 搜尋bar -->
		            <form id="myForm" name="myForm" method="GET" action="<%=request.getContextPath()%>/member">
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
			                            <span class="text" >帳　　號：</span>
			                            <input type="text" id="account" name="account">
			                        </label>
			                    </div>
			                </div>
			                <div class="search-block-line">
			                    <div>
			                        <label>
			                            <span class="text" >姓　　名：</span>
			                            <input type="text" id="name" name="name">     
			                        </label>
			                        &nbsp;&nbsp;&nbsp;
			                        <label>
			                            <span class="text" >權　　限：</span>
			                            <select id="role" name="role">
										    <option value="" selected></option>
										    <option value="1">使用者</option>
										    <option value="8">系統人員</option>
										    <option value="9">系統管理員</option>
										</select>         
			                        </label>
			                    </div>
			                </div>
			                <div class="search-block-line">
			                    <div>
			                        <label>
			                            <span class="text" >是否啟用:</span>
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
									<label class="fs-20">會員清單</label>
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
								<table class="pure-table pure-table-bordered " id="memberTable">
									<thead>
										<tr>
											<th width=10%>ID</th>
											<th width=20%>帳號</th>
											<th width=20%>姓名</th>
											<th width=20%>權限</th>
											<th width=20%>建立日期</th>
											<th width=10%>狀態</th>
											<th width=10%>編輯</th>
										</tr>
									</thead>
									<tbody id="memberBody">
										<c:forEach varStatus="status" var="member" items="${ members }">
											<tr>
												<td>${ member.id } </td>
												<td>${ member.account }</td>
												<td>${ member.name }</td>
												<td>${ member.role }</td>
												<td>
													<fmt:formatDate value="${ member.createtime }" pattern="yyyy-MM-dd"/>
												</td>
												<td>${ member.enabled }</td>
												<td><a href="javascript:doUpdateModal(${ status.index })" class="btn searchbtn btn-success">編輯</a></td>
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
						                            <input type="text" class="modal-readonly" id="updateId" name="id" readonly="readonly">
						                        </label>
							                </div>
							                <div class="search-block-line">
						                        <label>
						                            <span class="text">帳　　號：</span>
						                            <input type="text" class="modal-readonly" id="updateAccount" name="account" readonly="readonly">
						                        </label>
							                </div>
							                <div class="search-block-line" id="updatePwdDvi">
						                        <label>
						                            <span class="text">密　　碼：</span>
						                            <input type="text" id="updatePwd" name="pwd">
						                        </label>
							                </div>
							                <div class="search-block-line">
						                        <label>
						                            <span class="text">姓　　名：</span>
						                            <input type="text" id="updateName" name="name">
						                        </label>
							                </div>
							                <div class="search-block-line">
							                	<label>
								                    <span class="text" >權　　限：</span>
						                            <select id="updateRole" name="role">
													    <option value="1">使用者</option>
													    <option value="8">系統人員</option>
													    <option value="9">系統管理員</option>
													</select>  
												</label>
							                </div>
							                 
							                <div class="search-block-line">
						                        <label>
						                            <span class="text">是否啟用：</span>
						                            <select id="updateEnabled" name="enabled">
													    <option value="0">未啟用</option>
													    <option value="1">啟用</option>
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
	                    url: '<%=request.getContextPath()%>/member',
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
                    url: '<%=request.getContextPath()%>/member?' + deleteid,
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
				document.getElementById("account").value = null;
				document.getElementById("name").value = null;
				document.getElementById("enabled").value = null;
				document.getElementById("updateId").value = null;
				document.getElementById("updateAccount").value = null;
				document.getElementById("updatePwd").value = null;
				document.getElementById("updateName").value = null;
				document.getElementById("updateEnabled").value = 1;
				document.getElementById("updateRole").value = 1;
				if(num == 0) {
					const old_tbody = document.getElementById("memberBody")
			    	const new_tbody = document.createElement('tbody');
					if(old_tbody != null) {
						old_tbody.parentNode.replaceChild(new_tbody, old_tbody)
					}
				}
				
			}
			
			function doSaveModal() {
				doClear(0);
				document.getElementById("error").innerHTML = "";
				document.getElementById("updateModalTitle").innerHTML = '新增會員資料';
				document.getElementById("updateIdDvi").style.display = 'none';
				document.getElementById("updateAccount").className = '';
        		document.getElementById("updateAccount").readOnly = false;
        		document.getElementById("showdelete").style.display = 'none';
        		document.getElementById("updatePwdDvi").style.display = 'block';
        		$('#updateModal').modal('show');
			}
			
			function doUpdateModal(index) {
				doClear(1);
				var member = document.getElementById("memberTable").rows[index+1];
				document.getElementById("error").innerHTML = "";
				document.getElementById("updateModalTitle").innerHTML = '編輯會員資料';
				document.getElementById("updateIdDvi").style.display = 'block';
				document.getElementById("updateAccount").className = 'modal-readonly';
        		document.getElementById("updateAccount").readOnly = true;
        		document.getElementById("showdelete").style.display = 'block';
        		document.getElementById("updatePwdDvi").style.display = 'none';
        		document.getElementById("updateId").value = member.cells[0].innerHTML;
        		document.getElementById("updateAccount").value = member.cells[1].innerHTML;
        		document.getElementById("updateName").value = member.cells[2].innerHTML;
        		console.log(member.cells[3].innerHTML);
        		switch (member.cells[3].innerHTML) {
        		case "使用者":
        			document.getElementById("updateRole").value = 1;
        			break;
        		case "系統人員":
        			document.getElementById("updateRole").value = 8;
        			break;
        		case "系統管理員":
        			document.getElementById("updateRole").value = 9;
        			break;
        		}
        		if( member.cells[5].innerHTML =="啟用") {
        			document.getElementById("updateEnabled").value = 1;
        		} else {
        			document.getElementById("updateEnabled").value = 0;
        		}

        		
        		$('#updateModal').modal('show');
			}
			
			function checkData() {
				if (document.getElementById("updateAccount").value == '') {
					showMsg("錯誤", "帳號不能為空白")
					return false;
				}
				if (document.getElementById("updatePwd").value == '') {
					showMsg("錯誤", "密碼不能為空白")
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
        		$('#deleteModal').modal('show');
			}
		</script>
	</body>
</html>