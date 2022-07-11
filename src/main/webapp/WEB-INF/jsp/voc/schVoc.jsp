<%--
  - MENU ID : schVoc
  - Description : VOC 조회 화면
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/tiles/include/includeTagLibs.jsp"%>

<style>
    .datagrid-header {
        font-weight: bold;
    }
    
    /* .sub3_search {
    	width: 100%;
    }
    
    .sub3_search span[data-tp='th'] {
    	text-align: left;
    } */

</style>

<div class="row mt">
	<h5 class="sub1_title" data-term="L.VOC 조회"><i class="fa fa-file-text"></i> </h5>
	<div class="col-md-12 col-sm-12">
		<div class="white-panel pn-sub1-top donut-chart">
			<div class="white-header">
			<form id="vocSchFrm" method="post">
                <div class="row sub3_search">
                	<div class="col-md-10">
                		<div class="row">
                			<div class="col-md-4 col-sd-4">
                				<span data-tp="th" data-term="관리번호"></span>
                                <input type="text" name="vocNo" id="vocNo" class="form-control input-sm" data-type="search" >
                			</div>
                			<div class="col-md-4 col-sd-4">
                				<span data-tp="th" data-term="접수부서"></span>
                                <input type="text" name="deptCd" id="deptCd" class="form-control input-sm" data-type="search" >
                			</div>
                			<!-- <div class="col-md-4 col-sd-4">
                				<span data-tp="th">AccessType</span>
                				<select id="urlMngSelect1" name="alwDiv" class="form-control input-sm" data-type="search" ></select>
                			</div>
                			<div class="col-md-4 col-sd-4">
                				<span data-tp="th" >Use</span>
                				<select id="urlMngSelect2" name="useYn" class="form-control input-sm" data-type="search"></select>
                			</div>
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
                			</div> -->
                		</div>
                	</div>
                	<div class="col-md-2">
                        <button type="button" class="btn btn-default sear_st" id="resetBtn" data-term="B.INIT"><i class="fa fa-refresh"></i> </button>
                    	<button type="button" class="btn btn-primary sear_st" id="searchBtn" data-term="B.SEARCH"><i class="fa fa-search"></i> </button>
                    </div>
                </div>
              </form>
			</div>
		</div>
	</div>
</div>
<div class="row" style="margin: 0px 15px -25px 0;">	
	<div class="col-md-12 col-sm-12 donut-chart buttonlist" style="text-align: left;">
	    <div class="left">
	        <button type="button" class="btn btn-primary" id="writeBtn" data-term="L.추가"><i class="fa fa-plus"></i> </button>	        
	    </div>
	    <div class="right">
	        <button type="button" class="btn btn-light" id="excelExportBtn" style="color: #f5f5f5; background-color: #449d44; border-color: #449d44;"><i class="fa fa-file"></i> Excel</button>
	    </div>
	</div>
</div>
<div class="row mt">	
	<div class="col-md-12 col-sm-12">
		<div class="white-panel pn-sub1-table donut-chart">
			<form id="vocListFrm" name="vocListFrm" class="p-1">
	            <div class="clearfix">
	                <div class="datatable-btns p-1">
	                </div>
	                <!-- <div id="urlMngPager1" class="float-left w-50"></div> -->
	                <div id="vocPager" class="float-left w-50"></div>
	            </div>
	            <!-- voc list -->
	            <table id="vocList"></table>
	        </form>
		</div>
	</div>
</div>

<script>

var schVoc = function () {

    var contextPath = "";

    var model = (function () {
        var URL_SELECT = "/voc/list/json";
     
        var getUrl = function(url){
            return contextPath + url;
        };
        var getGridUrl = function(){
            return getUrl(URL_SELECT);
        };

        return{
            getGridUrl: getGridUrl
        };
    });

    var $grid = $("#vocList");
    var $searchFrm = $("#vocSchFrm");
    var $searchBtn = $("#searchBtn");
    var $resetBtn = $("#resetBtn");
    var $excelBtn = $("#excelExportBtn");

    var getGridHeight = function () {
        var ENURI = 320;
        var SCH_HEIGHT = 0; //$searchFrm.innerHeight();
        var windowHeight = window.innerHeight;
        return windowHeight - SCH_HEIGHT - ENURI;
    };

    var getPageSize = function(){
        var gHeight = getGridHeight();

        // console.log(gHeight);
        if(gHeight > 500){
            return 20;
        }
        return 10;
    };

    var getQueryParams = function () {
        return $searchFrm.serializeObject();
    };

    var rowStyler = function(index, row){
        if (row.cud === "C" || row.isNewRecord){
            return "background-color:#6293BB;color:#fff;font-weight:bold;";
        }
    };

    var initGrid = function () {
        $grid.edatagrid({
            url: "/voc/schVoc/json",
            method: "post",
            queryParams: getQueryParams(),
            loadFilter: paragonCmm.easyuiLoadFilter,
            height: getGridHeight(),
            striped: true,
            fitColumns: true,
            nowrap: true,
            multiSort: true,
            remoteSort: true,
            rownumbers: true,
            singleSelect: true, //(check) multi / single
            checkOnSelect: false, // row 를 클릭 시 체크박스 선택(false : 체크박스 클릭 필요)
            selectOnCheck: true,
            pagination: true,
            pagePosition: "bottom",
            pageSize: getPageSize(),
            rowStyler: rowStyler,
            onBeforeLoad:function() { paragonCmm.showBackDrop(); },
            onLoadSuccess:function(json) {
                paragonCmm.hideBackDrop();
                $(this).datagrid('resize');
            },
            onLoadError:function() { paragonCmm.hideBackDrop(); },
            onDblClickRow:function(index, row){
                var rows = $("#vocList").datagrid('getRows');
                var row = rows[index];
                var vocNo = row.vocNo;
                var status = row.vocStatus;

                editVocNew(vocNo, status);
            },
            columns: [[	//field 값은 컬럼명 중 _ 있을 경우 대문자로 구분하여 표기
	            /* {
	                field: "no", checkbox: true, width: "1%", toExcel: false	// unique key
	            }, */ 
	            {
	                field: "vocStatus", hidden: true, title: "진행상태코드", formatter: filterXSS, width: "10%"
	            },
	            {
	                field: "vocStatusNm", title: "진행상태", formatter: filterXSS, width: "10%"
	            },
	            {
	                field: "vocNo", title: "관리번호", formatter: filterXSS, width: "10%"
	            }, 
	            {
	                field: "creDept", title: "접수부서", formatter: filterXSS, width: "10%"
	            },
	            {
	                field: "creUser", title: "접수자", formatter: filterXSS, width: "10%"
	            }, 
	            {
	                field: "creDate", title: "접수일", formatter: filterXSS, width: "10%"
	            }, 
	            {
	                field: "bssArea", title: "사업구분", formatter: filterXSS, width: "10%"
	            },
	            {
	                field: "custNm", title: "고객사", formatter: filterXSS, width: "10%"
	            }, 
	            {
	                field: "cusMngUser", title: "고객담당자", formatter: filterXSS, width: "10%"
	            }, 
	            {
	                field: "cusMngDate", title: "고객요청일", formatter: filterXSS, width: "10%"
	            }, 
	            {
	                field: "regType", title: "접수유형", formatter: filterXSS, width: "10%"
	            }, 
	            {
	                field: "vocTitle", title: "제목", formatter: filterXSS, width: "10%"
	            }	         
            ]]            
        });
    };

    var search = function(){
        $grid.datagrid("load", getQueryParams());
    };

    var resetForm = function(){
        $searchFrm.find("input[name=schWord]").val("");
    };

    //엑셀 Export
    var toExcel = function(){
        $grid.edatagrid("toExcel", {
            filename: "url-list.xls",
            worksheet: "url list",
            caption: "URL List"
        });
    };

    //수정 및 진행 처리
	var editVocNew = function(vocNo, status){    	
    	var imsiForm = $("<form method='POST'>").attr("action","/voc/editVocNew.popup");
        imsiForm.append($("<input type='hidden' name='_csrf'>").val($("meta[name='_csrf']").attr("content")));
        //imsiForm.append($("<input type='hidden' name='vocNo'>").val(JSON.stringify(vocNo)));
        //imsiForm.append($("<input type='hidden' name='status'>").val(JSON.stringify(status)));
        imsiForm.append($("<input type='hidden' name='vocNo'>").val(vocNo));
        imsiForm.append($("<input type='hidden' name='status'>").val(status));
        paragonCmm.openWindow("", "1500", "1000", "POPUP_WRITE", "yes", "yes", "");
        imsiForm.attr("target","POPUP_WRITE");
        imsiForm.appendTo("body");
        imsiForm.submit();
        imsiForm.remove();
    	
    }
	
    var setEvent = function(){

        $searchBtn.on("click", function(){
            search();
            return false;
        });

        $resetBtn.on("click", function(){
            resetForm();
            return false;
        });

        $excelBtn.on("click", function(){
            toExcel();
            return false;
        });

        $searchFrm.on("submit", function(){
            search();
            return false;
        });
        
        //추가 버튼 클릭
        $("#writeBtn").on("click",function(){
        	var openerData = {
                    isNew : "TRUE",
                    atchFileId : paragonCmm.getRandomUUID()
                };
        	
        	var imsiForm = $("<form method='POST'>").attr("action","/voc/regVocNew.popup");
        	imsiForm.append($("<input type='hidden' name='bbsUid'>").val());
            imsiForm.append($("<input type='hidden' name='_csrf'>").val($("meta[name='_csrf']").attr("content")));
            imsiForm.append($("<input type='hidden' name='openerData'>").val(JSON.stringify(openerData)));
            paragonCmm.openWindow("", "1500", "1000", "POPUP_WRITE", "yes", "yes", "");
            imsiForm.attr("target","POPUP_WRITE");
            imsiForm.appendTo("body");
            imsiForm.submit();
            imsiForm.remove();
        	
        });
    };
    
    var init = function () {
        initGrid();
        setEvent();
    };

    return {
        init: init
    };
};

var vocList;
$(document).ready(function () {

    console.info("[Loading Module: VOC 조회].....................");

    var vocList = new schVoc();
    vocList.init();
   
});

</script>