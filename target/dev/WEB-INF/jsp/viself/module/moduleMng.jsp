<%--
  - Author(s): Yang, Ki Hwa
  - Date: 2021-03-16(016)
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
  -      모듈 관리
  --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/tiles/include/includeTagLibs.jsp"%>
<div class="row mt">
    <h5 class="sub1_title" data-term="L.모듈관리"><i class="fa fa-file-text"></i> </h5>
</div>
<div>
    <div class="col-md-6 col-sm-6" id="moduleMngLayer1">
        <h6 class="sub2_title"><i class="fa fa-caret-square-o-right"></i> 모듈목록</h6>
        <div class="col-md-6 col-sm-6 donut-chart" style="text-align: right; padding-bottom: 5px;">
            <%--<form id="moduleMngSchFrm0" name="moduleMngSchFrm0">
                <input type="text" name="schText" class="w-75 i18n" placeholder="WRD.검색어" data-i18n="WRD.검색어">
                <button type="button" id="moduleMngSearchBtn1" title="WRD.검색" class="btn-dark i18n" data-i18n="WRD.검색"><i class="fa fa-search"></i></button>
                &lt;%&ndash;                        <button type="button" id="moduleMngReloadBtn1" title="WRD.리로드" class="btn-dark i18n" data-i18n="WRD.리로드"><i class="fa fa-sync-alt"></i></button>&ndash;%&gt;
                <button type="reset" id="moduleMngResetBtn1" title="WRD.리셋" class="btn-primary i18n" data-i18n="WRD.리셋"><i class="fa fa-undo"></i></button>
            </form>--%>
        </div>
        <div class="col-md-12 col-sm-12">
            <form id="moduleMngListFrm1" name="moduleMngListFrm1" class="p-1">
                <!-- module list -->
                <div id="moduleMngList1"></div><!-- // module list -->
            </form>
            <%--<div class="white-panel pn-sub1-table donut-chart">
            </div>--%>
        </div>
        <div class="col-md-6 col-sm-6 donut-chart" style="text-align: left; padding-top: 5px;">
            <button id="moduleMngAddRowBtn1" type="button" title="추가" class="btn btn-primary btn-sm i18n" data-term="L.추가"><i class="fa fa-plus"></i> </button>
            <%--<button id="moduleMngDeleteRowBtn1" type="button" title="WRD.행삭제" class="btn btn-theme04 btn-sm i18n" data-i18n="WRD.행삭제"><i class="fa fa-minus"></i></button>
            <button id="moduleMngExcelBtn1" type="button" title="WRD.엑셀" class="btn btn-theme btn-sm i18n" data-i18n="WRD.엑셀"><i class="fa fa-save"></i></button>--%>
        </div>
    </div>
    <div class="col-md-6 col-sm-6" id="moduleMngLayer2">
        <h6 class="sub2_title"><i class="fa fa-caret-square-o-right"></i> 모듈URL</h6>
        <div class="col-md-6 col-sm-6 donut-chart search" style="display: none; padding-bottom: 5px;">
            <form id="moduleMngSchFrm2" name="moduleMngSchFrm2" class="hidden">
                <input type="hidden" name="moduleId" class="">
                 <button type="button" id="moduleMngSearchBtn2" class="btn-primary"><i class="fa fa-search"></i></button>
            </form>
        </div>
        <div class="col-md-12 col-sm-12">
            <form id="moduleMngListFrm2" name="moduleMngListFrm2" class="p-1">
                <div id="moduleMngList2"></div>
            </form>
            <%--<div class="white-panel pn-sub1-table donut-chart">
            </div>--%>
        </div>
        <div class="col-md-6 col-sm-6 donut-chart" style="text-align: left; padding-top: 5px;">
            <button id="moduleMngAddRowBtn2" type="button" title="추가" class="btn btn-primary btn-sm i18n" data-term="L.추가"><i class="fa fa-plus"></i> </button>
            <button id="moduleMngDeleteRowBtn2" type="button" title="삭제" class="btn btn-default btn-sm i18n" data-term="L.삭제"><i class="fa fa-minus"></i> </button>
<%--            <button id="moduleMngExcelBtn2" type="button" title="WRD.엑셀" class="btn btn-theme btn-sm i18n" title="to excel" data-i18n="WRD.엑셀"><i class="fa fa-save"></i></button>--%>
        </div>
    </div>
</div>
<script src="<c:url value='/js/module/viself/module/moduleMng.js'/>"></script>
<script type="text/javascript">
    $(document).ready(function(){
        "use strict";
        var moduleMng = new ModuleMng();
        moduleMng.init();
    });
</script>