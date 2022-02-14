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
    <body style="margin:0;padding:0;text-align:left;background: #ffffff;" onload="window.focus();">
    	<div class="popup_content_body">
       		<tiles:insertAttribute name="page.body"/>
        </div>
    </body>
</html>
