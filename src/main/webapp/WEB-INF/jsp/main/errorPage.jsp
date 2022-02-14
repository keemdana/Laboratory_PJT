<%--
  - Author: Yang, Ki Hwa
  - Date: 2019-12-13
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
  - Description: 에러페이지
  --%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@include file="/WEB-INF/tiles/include/includeTagLibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <!-- meta info -->
    <%@include file="/WEB-INF/tiles/include/metaInfo.jsp"%>

    <!-- style links -->
    <%@include file="/WEB-INF/tiles/include/cssLink.jsp"%>
    <!-- error css -->
    <link rel="stylesheet" href="<c:url value='/css/error.css'/>">
</head>
<body>
<%--<section>
    <div class="container-fluid">
        <div class="row">
            <div class="col d-table">
                <div class="text-center d-table-cell align-middle">
                    <h2 class="font-weight-bold mb-4">Hmm...</h2>
                    <p>looks like something went wrong. </p>
                    <p>Don't worry, please go to our homepage. </p>
                    <a class="btn btn-warning mt-4" href="<c:url value='/'/>">Homepage</a>
                </div>
            </div>
        </div>
    </div>
</section>--%>
<div class="text-center">

    <h1>:( 어이쿠  <span class="errorcode"> Oops!!</span></h1>

    <p class="output"><small><em>All those moments will be lost in time, like tears in rain.</em></small></p>
    <br>
    <p class="output">Hmm...</p>
    <p class="output">If you're approaching it normally, something might seem wrong.</p>
    <p class="output">Don't worry, if you have approached normally, please go to <a href="/">our homepage.</a></p>
    <p class="output">Good luck.</p>
    <p><small></small><small>_____________________________________________________________________________________<br> VERTEX ID.</small></p>
    <c:if test="${opertionType ne 'PROD'}">
        <br>
        <p class="output"><small>
            <c:out value="${requestScope['javax.servlet.error.message']}"/>
        </small></p>
    </c:if>
</div>
</body>
</html>
