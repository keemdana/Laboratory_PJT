<%--
  - Author(s): Yang, Ki Hwa
  - Date: 2021-01-22(022)
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
  - Description:
  -     HTML5 기반의 에러 페이지 템플릿
  --%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@include file="/WEB-INF/tiles/include/includeTagLibs.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- meta info -->
    <%@include file="/WEB-INF/tiles/include/metaInfo.jsp"%>
    <!-- style links -->
    <%@include file="/WEB-INF/tiles/include/cssLink.jsp"%>
</head>
<body class="error-bg-wrap">
<tiles:insertAttribute name="page.body"/>
<!-- js links -->
<%@include file="/WEB-INF/tiles/include/jsLink.jsp"%>
</body>
</html>