<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="entity.Member" %>  
<%
    Member member = (Member)session.getAttribute("member"); 
  	Long userid = 0L;
  	String account = "";
  	String name = "";
  	String role = "0";
  	String showRole = "";
  	
  	if (member != null) {
  		userid = member.getId();
  		account = member.getAccount();
  		name = member.getName();
  		role = member.getRole();
  		switch (role) {
		case "1":
			showRole = "使用者";
			break;
		case "8":
			showRole = "系統人員";
			break;
		case "9":
			showRole = "系統管理員";
			break;
		default:
			showRole = "遊客";
		}
  	} else {
  		showRole = "遊客";
  	}
  	
  	
%>
<!-- 靠左功能區 -->
<ul class="navbar-nav">
    <li class="nav-item">
        <a class="nav-link" data-widget="pushmenu" data-enable-remember="true" href="#" role="button"><i class="fas fa-bars"></i></a>
    </li>
    <li class="nav-item d-none d-sm-inline-block">
        <a href="" target="_self" class="nav-link nav-title">系統</a>
    </li>
</ul>

<!-- 靠右功能區 -->
<div class="navbar-nav ml-auto">
    <div class="member-block">
        <div class="member">
            <div class="name">姓名：<span><%=name %></span></div>
            <div class="membericon"><i class="fa-solid fa-circle-chevron-down"></i></div>
        </div>   
        <div class="Competence" id="Competence">
            <div>
                <div class="Competence-line">ID：<%=userid %></div>
                <div class="Competence-line">帳號：<%=account %></div>
                <div class="Competence-line">姓名：<%=name %></div>
				<div class="Competence-line">角色：<%=showRole %></div>
				<input type="hidden" id="memberRole" value="<%=role %>">    
				
                <a href="<%=request.getContextPath()%>/logout" class=" btn newbtn-gary Competence-btn" id="headerLogout">登出</a>
                <a href="#" onclick="doShowLogin();" class=" btn newbtn-gary Competence-btn" id="headerLogin">登入</a>
            </div>
        </div>    
    </div>
</div>