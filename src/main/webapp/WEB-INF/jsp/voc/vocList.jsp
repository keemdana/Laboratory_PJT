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
				<!-- Search AREA -->
			<form id="urlMngSchFrm0" method="post">
                <div class="row sub3_search">
                	<div class="col-md-10">
                		<div class="row">
                			<div class="col-md-4 col-sd-4">
                				<span data-tp="th" data-term="관리번호"></span>
                                <input type="text" name="schWord" id="schWord" class="form-control input-sm" data-type="search" >
                			</div>
                			<div class="col-md-4 col-sd-4">
                				<span data-tp="th" data-term="접수부서"></span>
                                <input type="text" name="schWord" id="schWord" class="form-control input-sm" data-type="search" >
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
                        <button type="button" class="btn btn-default sear_st" id="urlMngResetBtn1" data-term="B.INIT"><i class="fa fa-refresh"></i> </button>
                    	<button type="button" class="btn btn-primary sear_st" id="urlMngSearchBtn1" data-term="B.SEARCH"><i class="fa fa-search"></i> </button>
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
	        <!-- <button type="button" class="btn btn-primary" id="editBtn" data-term="L.수정"><i class="fa fa-plus"></i> </button> -->
	        <!-- <button type="button" class="btn btn-default" id="urlMngDeleteRowBtn1" data-term="L.삭제" style="color: #f5f5f5; background-color: #999; border-color: #999;"><i class="fa fa-minus"></i> </button> -->	        
	    </div>
	    <div class="right">
	        <button type="button" class="btn btn-light" id="urlMngExcelBtn1" style="color: #f5f5f5; background-color: #449d44; border-color: #449d44;"><i class="fa fa-file"></i> Excel</button>
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
            <div class="col-md-12 col-sm-12 donut-chart buttonlist" style="text-align: left;">
                <!-- <div class="left">
                    <button type="button" class="btn btn-primary" id="urlMngAddRowBtn1" data-term="L.추가"><i class="fa fa-plus"></i> </button>
                    <button type="button" class="btn btn-default" id="urlMngDeleteRowBtn1" data-term="L.삭제"><i class="fa fa-minus"></i> </button>
                    <button type="button" class="btn btn-light" id="urlMngExcelBtn1" ><i class="fa fa-file"></i> Excel</button>
                </div> -->
                <!-- <div class="right">
			        <button type="button" class="btn btn-default" id="urlMngCancelBtn1" data-term="L.취소" style="color: #f5f5f5; background-color: #f30806; border-color: #f30806;"><i class="fa fa-ban"></i> </button>
			        <button type="button" class="btn btn-primary" id="urlMngAcceptBtn1" data-term="L.저장"><i class="fa fa-check"></i> </button>
			    </div> -->
            </div>
		</div>
	</div>
</div>

<script>

var schVoc = function () {

    var contextPath = "";

    var model = (function () {
        var URL_SELECT = "/voc/list/json";
        var SAVE_URL = "/viself/auth/urlMng/save/json";
        var DELETE_URL = "/viself/auth/urlMng/delete/json";

        var code = {
            useYnOptions: [
                {id: "Y", value: "Use"},
                {id: "N", value: "No Use"}
            ],
            alwDivOptions: [
                {id: "IS_AUTHENTICATED_FULLY", value: "Authenticated"},
                {id: "IS_AUTHENTICATED_ANONYMOUSLY", value: "Anonymously"}
            ],
        };

        var getUrl = function(url){
            return contextPath + url;
        };
        var getGridUrl = function(){
            return getUrl(URL_SELECT);
        };


        var saveData = function(data, cbFnc){
            // console.log("URL..."+SAVE_URL);
            // console.log("data...");
            // console.log(data);
            paragonCmm.callAjax(getUrl(SAVE_URL), data, cbFnc);
        };

        // URL 삭제
        var deleteData = function(data, cbFnc){
            paragonCmm.callAjax(getUrl(DELETE_URL), data, cbFnc);
        }

        var getAlwDivOptions = function(){
            return code.alwDivOptions.slice();
        };

        var getUseYnOptions = function(){
            return code.useYnOptions.slice();
        };

        return{
            getGridUrl: getGridUrl,
            saveData: saveData,
            deleteData: deleteData,
            getAlwDivOptions: getAlwDivOptions,
            getUseYnOptions: getUseYnOptions
        };
    })();

    var $grid = $("#urlMngList1");
    var $searchFrm = $("#urlMngSchFrm0");
    var $searchBtn = $("#urlMngSearchBtn1");
    var $resetBtn = $("#urlMngResetBtn1");
    var $addBtn = $("#urlMngAddRowBtn1");
    var $delBtn = $("#urlMngDeleteRowBtn1");
    var $acceptBtn = $("#urlMngAcceptBtn1");
    var $cancelBtn = $("#urlMngCancelBtn1");
    var $excelBtn = $("#urlMngExcelBtn1");
    // var $dialog = $("#urlMngPop1");
    // var DIALOG_URL = "/viself/auth/url-dialog.include";

    var initSchForm = function(){
        var alwOptions = model.getAlwDivOptions();
        var useYnOptions = model.getUseYnOptions();

        alwOptions.unshift({id:"", value: "All"});
        useYnOptions.unshift({id:"", value: "All"});

        htmlUtils.initializeSelectJson("urlMngSelect1","alwDiv", alwOptions, "", "id", "value");
        htmlUtils.initializeSelectJson("urlMngSelect2","useYn", useYnOptions, "", "id", "value");
    };

    // var openDialog = function(row){
    //     $dialog.html("");
    //     var openerData = {
    //         row: row,
    //         model: model,
    //         cbFnc: search
    //     };
    //     $dialog.removeData("openerData");
    //     $dialog.data("openerData", openerData);
    //     $dialog.load(DIALOG_URL, null, function(res, sts, xhr){
    //     });
    // };

    var addRow = function(){
        var comboObjs = $(".combo-p");
        if(comboObjs.length > 0){
            $(comboObjs).each(function(){
                $(this).find(".combo-panel").panel('destroy');
            });
        }

        $grid.edatagrid("addRow", {
            row: {cud: "C"}
        });

        // $grid.edatagrid("addRow", {
        //     index: 0,
        //     row: {cud: "C"}
        // });
    };

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
            url: "/voc/vocList/json",
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
                var rows = $("#urlMngList1").datagrid('getRows');
                var row = rows[index];
                var vocNo = row.vocNo;
                var status = row.vocStatus;
                //alert(vocNo);
                 //$("#bbsUid").val(row.bbsUid);
                
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
	                field: "createDept", title: "접수부서", formatter: filterXSS, width: "10%"
	            },
	            {
	                field: "createUser", title: "접수자", formatter: filterXSS, width: "10%"
	            }, 
	            {
	                field: "createDate", title: "접수일", formatter: filterXSS, width: "10%"
	            }, 
	            {
	                field: "bssArea", title: "사업구분", formatter: filterXSS, width: "10%"
	            },
	            {
	                field: "custNm", title: "고객사", formatter: filterXSS, width: "10%"
	            }, 
	            {
	                field: "custUserNm", title: "고객담당자", formatter: filterXSS, width: "10%"
	            }, 
	            {
	                field: "custReqDate", title: "고객요청일", formatter: filterXSS, width: "10%"
	            }, 
	            {
	                field: "vocRegType", title: "접수유형", formatter: filterXSS, width: "10%"
	            }, 
	            {
	                field: "vocTitle", title: "제목", formatter: filterXSS, width: "10%"
	            }
	            
	            /* {
	                field: "cud", hidden: true
	            },
	            {
	                field: "accesUrl", title: "URL", formatter: filterXSS, width: "40%",
	                editor: {
	                    type: "validatebox",
	                    options: {
	                        required:true
	                    }
	                }
	            }, 
	            {
	                field: "regDte", title: "REG", formatter: filterXSS, width: "40%",
	                editor: {
	                    type: "validatebox",
	                    options: {
	                        required:true
	                    }
	                }
	            },
	            {
	                field: "urlDesc", title: "Description", formatter: filterXSS, width: "40%",
	                editor: {
	                    type: "validatebox",
	                    options: {
	                        validType: ["length[0, 20]"]
	                    }
	                }
	            }, 
	            {
	                field: "alwDiv", title: "Access Type", formatter: filterXSS, width: "15%",
	                editor: {
	                    type: "combobox",
	                    options: {
	                        editable: false,
	                        data: model.getAlwDivOptions(),
	                        valueField: "id",
	                        textField: "value",
	                        keyHandler: $.extend({}, $.fn.combobox.defaults.keyHandler, {
	                            down: function(){
	                                $(this).combobox('showPanel');
	                                $.fn.combobox.defaults.keyHandler.down.call(this,e);
	                            }
	                        }),
	                        required:true
	                    }
	                }
	            }, 
	            {
	                field: "useYn", title: "Use", formatter: filterXSS, width: "5%",
	                editor: {
	                    type: "combobox",
	                    options: {
	                        editable: false,
	                        data: model.getUseYnOptions(),
	                        valueField: "id",
	                        textField: "value",
	                        keyHandler: $.extend({}, $.fn.combobox.defaults.keyHandler, {
	                            down: function(){
	                                $(this).combobox('showPanel');
	                                $.fn.combobox.defaults.keyHandler.down.call(this,e);
	                            }
	                        }),
	                        onShowPanel:function(){
	                            $(this).combobox('panel').panel('panel').css('z-index',$.fn.menu.defaults.zIndex++);
	                        },
	                        required:true
	                    }
	                }
	            } */
            ]]            
        });
    };

    var setGridEvent = function(){
        var options = $grid.edatagrid("options");
        options.onBeforeEdit= function(index, row){
            if(!row.isNewRecord){
                var col = $(this).edatagrid("getColumnOption","accesUrl");
                col.editor1 = col.editor;
                col.editor = null;
                row.cud = "U";
            }
        };
        options.onAfterEdit=function(){
            // console.log("after edit");
            var col = $(this).edatagrid('getColumnOption','accesUrl');
            if (col.editor1){
                col.editor = col.editor1;
            }
        };
        options.onCancelEdit=function(){
            var col = $(this).edatagrid('getColumnOption','accesUrl');
            if (col.editor1){
                col.editor = col.editor1;
            }
        };
    };

    var search = function(){
        $grid.datagrid("load", getQueryParams());
    };

    var resetForm = function(){
        $searchFrm.find("input[name=schWord]").val("");
    };

    var delUrls = function(){
        var rows = $grid.datagrid("getSelections");

        if(!rows || rows.length === 0){
            return false;
        }

        $.messager.confirm("Confirm",'정말 삭제하시겠습니까?\n시스템에 문제가 발생할 수 있습니다.',function(r) {
            if(r){
                var data = {
                    list: rows
                };
                var cbFnc = function(data){
                    showMsg(data);
                    search();
                };
                model.deleteData(data, cbFnc);
            }
        });
    };

    var showMsg = function(data){
        if(data.errYn !== "E"){
            $.messager.show({
                title: "Info",
                msg: paragonCmm.getLang(data.msg),
                icon: "info",
                timeout:1000
            });
        }else{
            $.messager.alert("Warning",data.msg, "warning");
        }
    };

    var saveUrl = function(){

        $grid.edatagrid("saveRow");
        var rows = $grid.edatagrid('getChanges');

        if(rows[0]){
            $.messager.confirm("Confirm",'정말 저장하시겠습니까?',function(r) {
                if(r){
                    var cbFnc = function(data){
                        showMsg(data);
                        search();
                    };

                    var data = {
                        list: rows
                    };

                    model.saveData(data, cbFnc);
                }
            });
        }
    };

    /**
     * 엑셀 출력
     */
    var toExcel = function(){
        $grid.edatagrid("toExcel", {
            filename: "url-list.xls",
            worksheet: "url list",
            caption: "URL List"
        });
    };

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

        //setGridEvent();

        $searchBtn.on("click", function(){
            search();
            return false;
        });

        $resetBtn.on("click", function(){
            resetForm();
            return false;
        });

        $addBtn.on("click", function(){
            addRow();
            return false;
        });

        $delBtn.on("click", function(){
            delUrls();
            return false;
        });

        $acceptBtn.on("click", function(){
            saveUrl();
            return false;
        });

        $cancelBtn.on("click", function(){
            $grid.edatagrid("cancelRow");
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

        // var options = $grid.edatagrid("options");
        
        
        
        $("#writeBtn").on("click",function(){
        	
        	var openerData = {
                    isNew : "TRUE",
                    atchFileMstId : paragonCmm.getRandomUUID()
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
        initSchForm();

        // 그리드 초기화
        initGrid();

        // 이벤트 설정
        setEvent();
    };

    return {
        init: init
    };
};

var vocList;
var testList;
$(document).ready(function () {

    console.info("[Loading Module: URL관리].....................");

    var vocList = new schVoc();
    vocList.init();
    
    


});

function doSearch(){
	
    $("#urlMngSearchBtn1").trigger("click");
    

}    

</script>

<%-- <script src="<c:url value='/js/module/viself/auth/urlMng.js'/>"></script> --%>
