<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!-- 選單區 -->
<div class="main-sidebar sidebar os-host os-theme-light os-host-overflow os-host-overflow-y os-host-resize-disabled os-host-transition os-host-scrollbar-horizontal-hidden">
	<!-- 企業標誌 Logo -->
	<div href="#" class="brand-link elevation-2 navbarLogo">
	    <img src="<%=request.getContextPath()%>/component/image/logo.jpg" class=" elevation-3 logoimg"/>
	</div>

    
    <div class="os-resize-observer-host observed">
        <div class="os-resize-observer" style="left: 0px; right: auto;"></div>
    </div>
    <div class="os-size-auto-observer observed" style="height: calc(100% + 1px); float: left;">
        <div class="os-resize-observer"></div>
    </div>
    <div class="os-content-glue" style="margin: 0px -8px; width:30px;"></div>

    <!-- 選單資訊 -->
    <nav class="mt-2 nav-collapse-hide-child">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false" id="listHtml">
            <li class="nav-item menu-is-opening menu-open">
	            <a href="#" class="nav-link main">
	            <i class="nav-icon fa-solid fa-magnifying-glass"></i>
	            <p>會員<i class="right fa-solid fa-plus"></i></p></a>
            	<ul class="nav nav-treeview">
            		<li class="nav-item">
            			<a href="<%=request.getContextPath()%>/sell" class="nav-link">
	            			<span class="navlisticon" id="selectSell"></span>
	            			<p>商品首頁</p>
	            		</a>
	            	</li>
	            	<li class="nav-item" id="shoppingCartLi">
            			<a href="<%=request.getContextPath()%>/shoppingCart" class="nav-link">
	            			<span class="navlisticon" id="selectShoppingCart"></span>
	            			<p>購物車</p>
	            		</a>
	            	</li>
	            	<li class="nav-item" id="walletLi">
            			<a href="<%=request.getContextPath()%>/wallet" class="nav-link">
	            			<span class="navlisticon" id="selectWallet"></span>
	            			<p>電子錢包</p>
	            		</a>
	            	</li>
	            	<li class="nav-item" id="shoppingListLi">
            			<a href="<%=request.getContextPath()%>/shoppingList" class="nav-link">
	            			<span class="navlisticon" id="selectShoppingList"></span>
	            			<p>購買清單</p>
	            		</a>
	            	</li>
	            </ul>
			</li>
			<li class="nav-item menu-is-opening menu-open" id="systemLi">
	            <a href="#" class="nav-link main">
	            <i class="nav-icon fa-solid fa-magnifying-glass"></i>
	            <p>管理<i class="right fa-solid fa-plus"></i></p></a>
            	<ul class="nav nav-treeview">
            		<li class="nav-item">
            			<a href="<%=request.getContextPath()%>/member" class="nav-link">
	            			<span class="navlisticon" id="selectMember"></span>
	            			<p>會員資料</p>
	            		</a>
	            	</li>
	            	<li class="nav-item">
            			<a href="<%=request.getContextPath()%>/product" class="nav-link">
	            			<span class="navlisticon" id="selectProduct"></span>
	            			<p>商品管理</p>
	            		</a>
	            	</li>
	            	<li class="nav-item">
            			<a href="<%=request.getContextPath()%>/stock" class="nav-link">
	            			<span class="navlisticon" id="selectStock"></span>
	            			<p>庫存管理</p>
	            		</a>
	            	</li>
	            	<li class="nav-item">
            			<a href="<%=request.getContextPath()%>/report" class="nav-link">
	            			<span class="navlisticon" id="selectReport"></span>
	            			<p>銷售報表</p>
	            		</a>
	            	</li>
	            </ul>
			</li>
        </ul>
    </nav>

    <!-- 選單的捲軸列 -->
    <div class="os-scrollbar os-scrollbar-horizontal os-scrollbar-unusable os-scrollbar-auto-hidden">
        <div class="os-scrollbar-track">
            <div class="os-scrollbar-handle" style="width: 100%; transform: translate(0px);"></div>
        </div>
    </div>
    <div class="os-scrollbar os-scrollbar-vertical os-scrollbar-auto-hidden">
        <div class="os-scrollbar-track">
            <div class="os-scrollbar-handle" style="height: 47.9359%; transform: translate(0px);"></div>
        </div>
    </div>
    <div class="os-scrollbar-corner"></div>
</div>

<script>
	var role = document.getElementById("memberRole").value;
	if (role == 9 || role == 8) {
		document.getElementById("systemLi").style.display = 'block';
		document.getElementById("headerLogin").style.display = 'none';
	} else {
		if(role != 1) {
			document.getElementById("shoppingCartLi").style.display = 'none';
			document.getElementById("walletLi").style.display = 'none';
			document.getElementById("headerLogin").style.display = 'block';
			document.getElementById("headerLogout").style.display = 'none';
			document.getElementById("systemLi").style.display = 'none';
			document.getElementById("shoppingListLi").style.display = 'none';
		} else {
			document.getElementById("systemLi").style.display = 'none';
			document.getElementById("headerLogin").style.display = 'none';
		}
	}
	
	
</script>