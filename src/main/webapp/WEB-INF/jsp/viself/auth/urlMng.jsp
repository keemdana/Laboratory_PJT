<%--
  - Author(s): Yang, Ki Hwa
  - Date: 2021-03-31(031)
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
  -     접근 URL 등록 관리
  --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/tiles/include/includeTagLibs.jsp"%>
<style>
    .datagrid-header {
        font-weight: bold;
    }
</style>
<div class="row mt">
	<h5 class="sub1_title" data-term="L.URL관리"><i class="fa fa-file-text"></i> </h5>
	<div class="col-md-12 col-sm-12">
		<div class="white-panel pn-sub1-top donut-chart">
			<div class="white-header">
				<!-- Search AREA -->
			<form id="urlMngSchFrm0" method="post">
                <div class="row sub3_search">
                	<div class="col-md-10">
                		<div class="row">
                			<div class="col-md-4 col-sd-4">
                				<span data-tp="th" data-term="L.검색어"></span>
                                <input type="text" name="schWord" id="schWord" class="form-control input-sm" data-type="search" >
                			</div>
                			<div class="col-md-4 col-sd-4">
                				<span data-tp="th">AccessType</span>
                				<select id="urlMngSelect1" name="alwDiv" class="form-control input-sm" data-type="search" ></select>
                			</div>
                			<div class="col-md-4 col-sd-4">
                				<span data-tp="th" >Use</span>
                				<select id="urlMngSelect2" name="useYn" class="form-control input-sm" data-type="search"></select>
                			</div>
                		</div>
                	</div>
                	<div class="col-md-2">
                        <button type="button" class="btn btn-default sear_st" id="urlMngResetBtn1" data-term="B.INIT"><i class="fa fa-refresh"></i> </button>
                    	<button type="button" class="btn btn-primary sear_st" id="urlMngSearchBtn1" data-term="B.SEARCH"><i class="fa fa-search"></i> </button>
                    </div>
                </div>
              </form>
			</div>
		</div>
	</div>
</div>
<div class="row mt">
	<div class="col-md-12 col-sm-12">
		<div class="white-panel pn-sub1-table donut-chart">
			<form id="urlMngListFrm1" name="urlMngListFrm1" class="p-1">
	            <div class="clearfix">
	                <div class="datatable-btns p-1">
	                </div>
	                <div id="urlMngPager1" class="float-left w-50"></div>
	            </div>
	            <!-- user list -->
	            <table id="urlMngList1"></table><!-- // user list -->
	        </form>
            <div class="col-md-12 col-sm-12 donut-chart buttonlist" style="text-align: left; padding-top: 5px;">
                <div class="left">
                    <button type="button" class="btn btn-primary" id="urlMngAddRowBtn1" data-term="L.추가"><i class="fa fa-plus"></i> </button>
                    <button type="button" class="btn btn-default" id="urlMngDeleteRowBtn1" data-term="L.삭제"><i class="fa fa-minus"></i> </button>
                    <button type="button" class="btn btn-light" id="urlMngExcelBtn1" ><i class="fa fa-file"></i> Excel</button>
                </div>
                <div class="right">
                    <button type="button" class="btn btn-default" id="urlMngCancelBtn1" data-term="L.취소"><i class="fa fa-ban"></i> </button>
                    <button type="button" class="btn btn-primary" id="urlMngAcceptBtn1" data-term="L.확인"><i class="fa fa-check"></i> </button>
                </div>
            </div>
		</div>
	</div>
</div>
<!--
<div class="content-panel p-3 site-min-height">
  <h3><i class="fa fa-angle-right" id="content_header" data-term="L.URL관리"> </i></h3>
    <div>
        <form id="urlMngSchFrm0" name="urlMngSchFrm0" method="post">
            <table class="box">
                <tr>
                    <td class="corner_lt"></td>
                    <td class="border_mt"></td>
                    <td class="corner_rt"></td>
                </tr>
                <tr>
                    <td class="border_lm"></td>
                    <td class="body">
                        <table>
                            <colgroup>
                                <col style="width:8%" />
                                <col style="width:28%" />
                                <col style="width:10%" />
                                <col style="width:20%" />
                                <col style="width:8%" />
                                <col style="width:15%" />
                                <col style="width:auto" />
                            </colgroup>
                            <tr>
                                <th data-term="L.검색어"></th>
                                <td><input type="text" name="schWord" class="w-75 i18n" placeholder="WRD.검색어" data-i18n="WRD.검색어"></td>
                                <th data-term="AccessType"></th>
                                <td><select id="urlMngSelect1" name="alwDiv"></select></td>
                                <th data-term="Use"></th>
                                <td><select id="urlMngSelect2" name="useYn"></select></td>
                                <td style="text-align:center;">
                                    <span id="urlMngSearchBtn1" class="ui_btn medium icon"><i class="fa fa-search"><a href="javascript:void(0)" data-term="B.SEARCH"></a></i></span>
                                    <span id="urlMngResetBtn1" class="ui_btn medium icon"><i class="fa fa-undo"><a href="javascript:void(0)" data-term="B.RESET"></a></i></span>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td class="border_rm"></td>
                </tr>
                <tr>
                    <td class="corner_lb"></td>
                    <td class="border_mb"></td>
                    <td class="corner_rb"></td>
                </tr>
            </table>
        </form>
        <div class="buttonlist">
            <div class="left">
            </div>
            <div class="right">
                <span id="urlMngAddRowBtn1"    class="ui_btn medium icon"><i class="fa fa-plus"><a href="javascript:void(0)" >추가</a></i></span>
                <span id="urlMngDeleteRowBtn1" class="ui_btn medium icon"><i class="fa fa-minus"><a href="javascript:void(0)" >삭제</a></i></span>
                <span id="urlMngAcceptBtn1"    class="ui_btn medium icon"><i class="fa fa-check"><a href="javascript:void(0)" >확인</a></i></span>
                <span id="urlMngCancelBtn1"    class="ui_btn medium icon"><i class="fa fa-ban"><a href="javascript:void(0)" >취소</a></i></span>
                <span id="urlMngExcelBtn1"     class="ui_btn medium icon"><i class="fa fa-file-excel"><a href="javascript:void(0)" >Excel</a></i></span>
            </div>
        </div>
        <form id="urlMngListFrm1" name="urlMngListFrm1" class="p-1">
            <div class="clearfix">
                <div class="datatable-btns p-1">
                </div>
                <div id="urlMngPager1" class="float-left w-50"></div>
            </div>
            user list
            <table id="urlMngList1"></table>// user list
        </form>
    </div>
</div> -->
<script src="<c:url value='/js/module/viself/auth/urlMng.js'/>"></script>
