<%--
  - Author: Yang, Ki Hwa
  - Date: 2018-05-24
  -
  - Copyright 2018 Yang, Ki Hwa
  -
  - Licensed under the Apache License, Version 2.0 (the "License");
  - you may not use this file except in compliance with the License.
  - You may obtain a copy of the License at
  -
  - http://www.apache.org/licenses/LICENSE-2.0
  -
  - Unless required by applicable law or agreed to in writing, software
  - distributed under the License is distributed on an "AS IS" BASIS,
  - WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  - See the License for the specific language governing permissions and
  - limitations under the License.
  -
  - @(#)
  - Description: include용 CSS link
  --%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@include file="/WEB-INF/tiles/include/includeTagLibs.jsp"%>
<!-- CSS LINK -->

<!--  jQuery - UI  -->
<link rel="stylesheet" type="text/css" href="<c:url value='/js/vendor/jquery-ui/1.12.1/themes/base/jquery-ui.css'/>" />

<!--  bootstrap 4.0 -->
<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/js/vendor/bootstrap/css/bootstrap.min.css'/>" /> --%>

<!--  fontawesome  -->
<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/js/vendor/fontawesome/css/all.css'/>" /> --%>

<!--  dashio css  bootstrap 3, font-awesome -->
<link rel="stylesheet" type="text/css" href="<c:url value='/js/vendor/dashio/1.0.0/css/bootstrap.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/js/vendor/dashio/1.0.0/lib/font-awesome/css/font-awesome.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/js/vendor/dashio/1.0.0/css/style-responsive.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/js/vendor/dashio/1.0.0/css/style.css'/>" />
<link rel="icon" href="<c:url value='/js/vendor/dashio/1.0.0/img/favicon.png'/>">

<!-- easy-ui css -->
<link rel="stylesheet" type="text/css" href="<c:url value='/js/vendor/jquery-easyui/1.9.14/themes/metro-gray/easyui.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/js/vendor/jquery-easyui/1.9.14/themes/icon.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/js/vendor/jquery-easyui/1.9.14/themes/color.css'/>" />

<!-- application css -->
<%-- <link rel="stylesheet" href="<c:url value='/css/style.default.css'/>"> --%>
<%-- <link rel="stylesheet" href="<c:url value='/css/default.css'/>"> --%>
<!-- add css -->
<%-- <link rel="stylesheet" href="<c:url value="/css/jayu-ext.css"/>"> --%>
