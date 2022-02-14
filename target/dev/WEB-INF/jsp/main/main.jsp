<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.vertexid.spring.utils.SessionUtils"%>
<%@page import="com.vertexid.commons.utils.CommonConstants"%>
<%@page import="com.vertexid.viself.hr.SysLoginVO"%>
<%@ page import="com.vertexid.viself.hr.SysLoginVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
SysLoginVO loginUser = (SysLoginVO)SessionUtils.getLoginVO();
if(loginUser == null){
	loginUser = new SysLoginVO();
}
String siteLocale = loginUser.getSiteLocale();
%>
<input type="hidden" id="loginEmail" value="<%=loginUser.getEmail() %>" />
<form name="menuForm"  method="post" style="margin:0; padding:0;">
<div id="menuForm" >
</div>
</form>
    <!-- **********************************************************************************************************************************************************
        TOP BAR CONTENT & NOTIFICATIONS
        *********************************************************************************************************************************************************** -->
    <!--header start-->
    <header class="header black-bg">
      <div class="sidebar-toggle-box">
        <div class="fa fa-bars tooltips" data-placement="right" data-original-title="Toggle Navigation"></div>
      </div>
      <!--logo start-->
      <a href="/main/main" class="logo">
          <%--
          <img src="/js/vendor/dashio/img/main_top_logo.png">
          <div style="color:#93d1ff; font-weight:bold; padding:10px 0 0 0; font-size:18px; font-weight:bold; position:absolute; top:19px; left:200px;">Paragon 시스템</div>
          --%>
          Paragon System
      </a>
      <!--logo end-->
      <div class="top-menu">
      	<ul class="nav pull-right top-menu">
          <li style="padding:20px 10px 0 0;"><span style="color:#39C; font-weight:bold;"><%=loginUser.getNmKo()%></span> <span data-term="L.로그인_하셨습니다"></span></li>
<%--          <li style="margin:15px 10px 0 0; cursor:pointer;"><a class="dropdown" title="change password" id="mainChPwdBtn"><i class="fa fa-lock"></i></a></li>--%>
          <li><a class="logout" href="/logout" id="logout"><i class="fa fa-lock" aria-hidden="true"></i> Logout</a></li>
        </ul>
      </div>
    </header>
    <!--header end-->
    <!-- **********************************************************************************************************************************************************
        MAIN SIDEBAR MENU
        *********************************************************************************************************************************************************** -->
    <!--sidebar start-->
    <aside>
      <div id="sidebar" class="nav-collapse">
        <!-- sidebar menu start-->
        <ul class="sidebar-menu" id="nav-accordion">
		  <h5 class="centered" ><i class="fa fa-user-md"></i> <%=loginUser.getDspNmKo()%></h5>
<%--          <li class="mt">--%>
<%--            <a href="javascript:void(0);" onClick="main.movePage('/main/dashboard',{})" class="active">--%>
<%--              <i class="fa fa-home"></i>--%>
<%--              <span style="font-family:'Ruda';">Dashboard</span>--%>
<%--              </a>--%>
<%--          </li>--%>

        </ul>
        <!-- sidebar menu end-->
      </div>
    </aside>
    <!--sidebar end-->
    <!-- **********************************************************************************************************************************************************
        MAIN CONTENT
        *********************************************************************************************************************************************************** -->
    <!--main content start-->
    <section id="main-content">
    	 <section class="wrapper" id="contentBody">

		</section>
      <!-- /wrapper -->
    </section>
    <!-- /MAIN CONTENT -->
    <!--main content end-->
    <!--footer start-->
    <footer class="site-footer navbar-fixed-bottom">
      <div class="text-center">
        <p>
        <%if(loginUser.isUserAuth("CMM_SYS")){ %>
         	<button type="button" title="Service Desk" id="vertexIdServiceDesk" class="btn btn-theme02 btn-xs" ><i class="fa fa-headset"> Vertex ID. SERVICE DESK</i></button>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <%} %>
          &copy; Copyright Vertex ID. All rights Reserved
        </p>

        <a href="#main-content" class="go-top">
          <i class="fa fa-angle-up"></i>
          </a>
      </div>
    </footer>
    <!--footer end-->
    <!--footer start-->
    <%-- <footer class="site-footer">
      <div class="text-right" style="padding-right: 15px;">
        <p>
        <%if(loginUser.isUserAuth("CMM_SYS")){ %>
         	<button type="button" title="Service Desk" id="vertexIdServiceDesk" class="btn btn-theme02 btn-xs" ><i class="fa fa-headset"> Vertex ID. SERVICE DESK</i></button>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <%} %>
          &copy; Copyrights <strong>VertexId</strong>. All Rights Reserved
        </p>
      </div>
    </footer> --%>
    <!--footer end-->
<script src="<c:url value='/js/module/main/main.js'/>"></script>