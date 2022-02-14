<%--
  - Author: Yang, Ki Hwa
  - Date: 2019-11-05
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
  - Description: HTML5 기반의 내부페이지용 템플릿
  --%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@include file="/WEB-INF/tiles/include/includeTagLibs.jsp"%>
<c:set var="module" scope="request"><tiles:getAsString name="module" /></c:set>
<tiles:insertAttribute name="page.body"/>
<%-- javascript 에서 동적으로 로딩 --%>
<%--<c:set var="pagePath" scope="request"><tiles:getAsString name="page.path" /></c:set>
<c:if test="${not empty pagePath}">
    <!-- page js -->
    <script type="text/javascript" src="/js/${pagePath}.js"></script>
</c:if>
--%>
