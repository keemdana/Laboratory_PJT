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
  - Description: include용 JS Link
  --%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@include file="/WEB-INF/tiles/include/includeTagLibs.jsp"%>
<!-- base js lib -->

<!-- HTML5 Boilerplate v 6.1.0 -->
<!-- jqeury -->
<script type="text/javascript" src="<c:url value='/js/vendor/jquery/3.5.1/jquery-3.5.1.min.js'/>"></script>

<!-- bootstrap 4 -->

<!-- fontawesome -->
<script type="text/javascript" src="<c:url value='/js/vendor/fontawesome/js/fontawesome_all.min.js'/>"></script>

<!-- dashio JS 순서변경에 주의 !!-->
<script type="text/javascript" src="<c:url value='/js/vendor/dashio/1.0.0/js/jquery.backstretch.min.js'/>"></script>

<!-- UI Library -->

<!-- bootstrap-treeview -->

<!-- js Storage -->
<script type="text/javascript" src="<c:url value='/js/vendor/js-storage/1.0.4/js.storage.js'/>"></script>

<!-- easy-ui -->
<script type="text/javascript" src="<c:url value='/js/vendor/jquery-easyui/1.9.14/jquery.easyui.min.js'/>"></script>

<!-- application global -->
<script type="text/javascript" src="<c:url value='/js/vendor/paragon/plugin/jquery.js'/>"></script>

<!-- [주의!] 아래는 순서 준수!! -->
<%-- 공통 스크립트 --%>
<script type="text/javascript" src="<c:url value='/js/vendor/paragon/paragonCmm.js'/>"></script>
