<%--
  - Author: Yang, Ki Hwa
  - Date: 2018-05-24
  -
  - Copyright (c) 2021 Vertex ID., KOREA
  - All rights reserved.
  -
  - This software is the confidential
  - and proprietary information of emFrontier.com ("Confidential Information").
  - You shall not disclose such Confidential Information
  - and shall use it only in accordance with
  - the terms of the license agreement you entered into
  - with Vertex ID. Networks
  -
  - @(#)
  - Description: HTML5 기반의 로그인 페이지 템플릿
  --%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@include file="/WEB-INF/tiles/include/includeTagLibs.jsp"%>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <!-- meta info -->
        <%@include file="/WEB-INF/tiles/include/metaInfo.jsp"%>
        <!-- style links -->
        <%@include file="/WEB-INF/tiles/include/cssLink.jsp"%>
        <!-- js links -->
        <%@include file="/WEB-INF/tiles/include/jsLink.jsp"%>
        <%@include file="/WEB-INF/tiles/include/jsRsaLink.jsp"%>
    </head>
    <body>
    	<%-- <div class="wrap_div">
    		<jsp:include page='/WEB-INF/jsp/viself/menu/menu.top.jsp' flush='false' />
    	</div> --%>
   		<tiles:insertAttribute name="page.body"/>
    	<!-- <div class="div_center_tem">
        	<div style="padding:30px 40px 50px 40px; margin:0px auto; width:1280px; background:#ffffff; border:1px solid #d7d7d7;">
        	</div>
        </div> -->
    </body>
</html>
