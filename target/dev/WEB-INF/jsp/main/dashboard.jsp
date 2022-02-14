<%--
  - Author: 양기화(梁起華 Yang, Ki Hwa)
  - Date: 2019-05-23
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
  - Description: 데시보드
  - accumulate(acc) : 누계/누적
  --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.vertexid.spring.utils.SessionUtils"%>
<%@page import="com.vertexid.viself.hr.SysLoginVO"%>
<%@page import="com.vertexid.commons.utils.StringUtil"%>


<%
	SysLoginVO loginUser 	=     (SysLoginVO) SessionUtils.getLoginVO();
	String siteLocale			= loginUser.getSiteLocale();
	String capitalizeSiteLocale = StringUtil.capitalize(siteLocale.toLowerCase());// ko >> Ko
%>
<%--
--%>
    <div class="row mt" id="dashboardStat">
    <!-- SERVER STATUS PANELS -->
      <div class="col-md-4 col-sm-4 mb">
        <div class="white-panel pn_top donut-chart">
        <input type="hidden" id="regDeptCd" value="<%=loginUser.getDeptCd()%>">
          <div class="white-header">
          <div>
            <h5 class="title_1" style="float:left;"><i class="fa fa-signal"></i> 당해년도 연간계획/실적 </h5>
            	<h6 style="float: right; margin:20px 25px 0 0;">(단위 : 억)</h6>
          </div>
          </div>
		  <table class="table-bordered" id="currYearTbl">
		    <thead>
			  <tr>
			    <th style="width:27%" data-opt='{"align":"center"}' data-term="L.연간계획"></th>
				<th style="width:27%" data-opt='{"align":"center"}' data-term="L.승인금액"></th>
				<th style="width:27%" data-opt='{"align":"center"}' data-term="L.누계실적"></th>
				<th style="width:19%" data-opt='{"align":"center"}' data-term="L.진도율"></th>
			  </tr>
			</thead>
			<tbody id="currYearTblBody">
			  <tr>
			    <td class="text-right"><span class="yearInv" style="text-align:right;font-weight:bold;font-size:14px;"></span>&nbsp;</td>
				<td class="text-right"><span class="apprAmt"  style="text-align:right;font-weight:bold;font-size:14px;"></span>&nbsp;</td>
				<td class="text-right"><span class="accPerform" style="text-align:right;font-weight:bold;font-size:14px;"></span>&nbsp;</td>
				<td class="text-right"><span class="progressPer" style="text-align:right;font-weight:bold;font-size:14px;"></span>&nbsp;</td>
			  </tr>
			</tbody>
		  </table>
 		  <!------ /TABLE ------>
        </div>
        <!-- /grey-panel -->
      </div>
      <!-- /col-md-4-->
      <div class="col-md-4 col-sm-4 mb">
        <div class="white-panel pn_top">
          <div class="white-header">
            <h5 class="title_2" style="width:145px; float:left;"><i class="fa fa-signal"></i> 당월 계획/실적</h5>
<!--             <div style="width:50px; float:left; margin:12px 0 -11px 145px; ">
 -->
            <div style="width:50px; float:left; margin: 12px 0 0 0;">
		      <select name="month" id="dashboardMonth" data-type="search"></select>
	        </div>
		      <h6 style="float: right; margin:20px 25px 0 0;">(단위 : 억)</h6>
          </div>
          <!------ TABLE ------>
		  <table class="table-bordered" id="table-bordered">
		    <thead>
		      <tr>
			    <th style="width:35%" data-opt='{"align":"center"}' data-term="L.해당월계획"></th>
			    <th style="width:35%" data-opt='{"align":"center"}' data-term="L.해당월실적"></th>
			    <th style="width:30%" data-opt='{"align":"center"}' data-term="L.집행율"></th>
		      </tr>
		    </thead>
		    <tbody id="currMonthTblBody">
		      <tr>
			    <td class="text-right"><span class="currMonthInv" data-curr-month-inv="" style="text-align:right;font-weight:bold;font-size:14px;"></span>&nbsp;</td>
			    <td class="text-right"><span class="currMonthPerform" data-curr-month-perform="" style="text-align:right;font-weight:bold;font-size:14px;"></span>&nbsp;</td>
			    <td class="text-right"><span class="monthExecutePer" data-month-execute-per="" style="text-align:right;font-weight:bold;font-size:14px;"></span>&nbsp;</td>
		      </tr>
		    </tbody>
	      </table>
          <!------ /TABLE ------>
        </div>
        <!--  /darkblue panel -->
      </div>
      <!-- /col-md-4 -->
      <div class="col-md-4 col-sm-4 mb">
      <!-- REVENUE PANEL -->
        <div class="white-panel pn_top">
          <div class="white-header">
          	<div>
            <h5 class="title_3" style="float:left;"><i class="fa fa-signal"></i> 당월 누적계획/실적</h5>
            <h6 style="float: right; margin:20px 25px 0 0;">(단위 : 억)</h6>
          	</div>
          </div>
	      <table class="table-bordered" id="accCurrTbl">
		    <thead>
		      <tr>
			    <th style="width:35%" data-opt='{"align":"center"}' data-term="누계계획"></th>
			    <th style="width:35%" data-opt='{"align":"center"}' data-term="L.누계실적"></th>
			    <th style="width:30%" data-opt='{"align":"center"}' data-term="집행율"></th>
		      </tr>
		    </thead>
		    <tbody id="accCurrTblBody">
		      <tr>
			    <td class="text-right"><span class="accCurrInv" data-acc-curr-inv="" style="text-align:right;font-weight:bold;font-size:14px;"></span>&nbsp;</td>
			    <td class="text-right"><span class="accCurrPerform" data-acc-curr-perform="" style="text-align:right;font-weight:bold;font-size:14px;"></span>&nbsp;</td>
			    <td class="text-right"><span class="executePer" data-execute-per="" style="text-align:right;font-weight:bold;font-size:14px;"></span>&nbsp;</td>
		      </tr>
		    </tbody>
	      </table>
          <!------ /TABLE ------>
        </div>
      </div>
      <!-- /col-md-4 -->
    </div>
    <!-- /row -->
    <div class="row" id="dashboardChart">
    <!-- WEATHER PANEL -->
      <div class="col-md-8 mb">
        <div class="white-panel pn">
        <!----------------------------->
        	<div class="white-header">
        	<div>
        	<h5 class="chart_t" style="width:200px; float:left;"> <i class="fa fa-bar-chart-o"></i> 당해년도 계획/실적 </h5>
			<h6 style="float: right; margin:20px 20px 0 0;">(단위 : 억)</h6>
	          </div>
	          <div class="col-lg-12 main-chart">
	          <!--CUSTOM CHART START -->
					<div id="chartContainer" style="width:100%; height:100%">
					</div>
	            <!--custom chart end-->
          	</div>
          </div>
          <!----------------------------->
        </div>
      </div>
      <!-- /col-md-4-->
<%--공지사항 DIV 시작 --%>
      <div class="col-md-4 mb">
        <div class="white-panel pn">
          <div class="white-header">
          	<%-- ##### 공지사항 주석처리 함(20210821) #####
            <h5 class="notice_t"><i class="fa fa-bell-o"></i> 공지사항</h5>
            <div class="notice_more"><a href="javascript:void(0);" onClick="main.movePage('/paragon/bbs/bbsList',{})">더보기</a></div>
            <table class="main_notice table" id="boardTbl">
              <thead>
                <tr data-opt='{"onClick":"dashBoard.goBoardView(\"@{bbsUid}\")"}'>
                  <th style="width:70%" hidden="true" data-opt='{"align":"left","col":"bbsTit","formater":"dashBoard.getNoticeIco"}'></th>
                  <th style="width:30%" hidden="true" data-opt='{"align":"center","col":"bbsRegDte"}'></th>
                </tr>
              </thead>
              <tbody id="boardTblBody">
              </tbody>
            </table>
             --%>
            <h5 class="service_t" style="width:200px; float:left;"> <i class="fa fa-forward"></i> 바로가기 </h5>
            <div class="serviceQuick">
            	<div class="serviceQuick_1">
	            	<ul>
		            	<li class="b1" onclick="main.movePage('/ims/sim/simList',{})"><span class="area">투자 심의요청</span></li>
		            	<li class="b2" onclick="main.movePage('/ims/draft/draft-exec-n-budget',{})"><span class="area">시행/예산 품의요청</span></li>
		             </ul>
	            </div>
            	<div class="serviceQuick_2">
	            	<ul>
	            		<li class="b3" onclick="main.movePage('/ims/draft/draft-change-n-cancel',{})"><span class="area">조정/취소 품의요청</span></li>
		                <li class="b4" onclick="main.movePage('/ims/draft/draft-compeltion-report',{})"><span class="area">완료보고 요청</span></li>
	                 </ul>
	            </div>
            </div>

<!-- ---------------------- -->
          </div>
        </div>
        <!-- /Message Panel-->
      </div>
      <!-- /col-md-8  -->
    </div>
<%-- Todo 시작 --%>
    <div class="row" id="dashboardTodo">
    <!-- TWITTER PANEL -->
      <div class="col-md-12 mb">
        <div class="white-panel pn-todo">
        <!----------------------------------->
          <ul class="nav nav-tabs">
            <li class="active"><a href="#todo" data-toggle="tab"><i class="fa fa-edit"></i> To Do</a></li>
          </ul>
          <div class="tab-content">
            <div class="tab-pane fade in active" id="todo">
            <!---- TO DO 테이블 ----->
              <table class="table table-bordered table-striped" id="todoTbl">
                <thead>
                  <tr data-opt='{"onClick":"dashBoard.goView(\"@{solMasUid}\",\"@{stuLangCd}\",\"@{stuDtl}\")"}'>
                    <th style="width:3%" data-opt='{"align":"center","col":"ROWSEQ"}'>No.</th>
                    <th style="width:10%" data-opt='{"align":"center","col":"docNmLangCd", "formatter": "paragonCmm.getLang"}' data-term="L.유형"></th>
                    <th style="width:*" data-opt='{"align":"left","col":"title"}' data-term="L.제목"></th>
                    <th style="width:12%"   data-opt='{"align":"center","col":"reqDeptNm"}' data-term="L.담당부서"></th>
                    <th style="width:13%"   data-opt='{"align":"center","col":"regUserNm"}' data-term="L.상신자"></th>
                    <th style="width:8%"   data-opt='{"align":"center","col":"regDte"}' data-term="L.상신일자"></th>
                    <th style="width:8%"   data-opt='{"align":"center","col":"compDte"}' data-term="L.결재일자"></th>
                    <th style="width:8%"   data-opt='{"align":"center","col":"rewDte"}' data-term="L.검토일자"></th>
                    <th style="width:8%" data-opt='{"align":"center","col":"procLangCd"}' data-term="L.상태"></th>
                  </tr>
                </thead>
                <tbody id="todoTblBody">
                </tbody>
              </table>
              <%-- 페이지 목록 --%>
			  <div class="pagelist" id="todoTblPage"></div>
              <!---- /TO DO 테이블 ----->
            </div>
          <div class="tab-pane fade" id="test">Test area</div>
          </div>
          <!----------------------------------->
        </div>
      </div>
      <!-- / TWITTER PANEL -->
    </div>
    <!-- /row -->


  <!-- js placed at the end of the document so the pages load faster -->
<%--   <script src="<c:url value='/lib/jquery/jquery.min.js'/>"></script> --%>
<%--   <script src="<c:url value='/js/vendor/dashio/js/chart-master/Chart.js'/>"></script> --%>

<%--   <script src="<c:url value='/lib/bootstrap/js/bootstrap.min.js'/>"></script>
  <script class="include" type="text/javascript" src="<c:url value='/lib/jquery.dcjqaccordion.2.7.js'/>"></script>
  <script src="<c:url value='/lib/jquery.scrollTo.min.js'/>"></script>
  <script src="<c:url value='/lib/jquery.nicescroll.js'/>" type="text/javascript"></script>
  <script src="<c:url value='/lib/jquery.sparkline.js'/>"></script>
  <!--common script for all pages-->
  <script src="<c:url value='/lib/common-scripts.js'/>"></script>
  <script type="text/javascript" src="<c:url value='/lib/gritter/js/jquery.gritter.js'/>"></script>
  <script type="text/javascript" src="<c:url value='/lib/gritter-conf.js'/>"></script>
 --%>
<link rel="stylesheet" href="<c:url value='/js/vendor/jqwidgets/12.0.1/styles/jqx.base.css'/>" type="text/css" />
<script src="<c:url value='/js/module/main/dashboard.js?ver=23000042'/>"></script>
