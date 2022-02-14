/*
 * @(#)urlMng.js     2021-03-31(031) 오후 12:30
 *
 * Copyright (c) 2021 Vertex ID., KOREA
 * All rights reserved.
 *
 * This software is the confidential
 * and proprietary information of emFrontier.com ("Confidential Information").
 * You shall not disclose such Confidential Information
 * and shall use it only in accordance with
 * the terms of the license agreement you entered into
 * with Vertex ID. Networks
 */

"use strict";

var UrlMng = function () {

    var contextPath = "";

    var model = (function () {
        var URL_SELECT = "/viself/auth/urlMng/urlList/json";
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
            url: model.getGridUrl(),
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
            singleSelect: false,
            checkOnSelect: true,
            selectOnCheck: true,
            pagination: true,
            pagePosition: "bottom",
            pageSize: getPageSize(),
            rowStyler: rowStyler,
            columns: [[{
                field: "chk", checkbox: true, width: "1%", toExcel: false
            },{
                field: "cud", hidden: true
            }, {
                field: "accesUrl", title: "URL", formatter: filterXSS,width: "40%",
                editor: {
                    type: "validatebox",
                    options: {
                        required:true
                    }
                }
            }, {
                field: "urlDesc", title: "Description", formatter: filterXSS, width: "40%",
                editor: {
                    type: "validatebox",
                    options: {
                        validType: ["length[0, 20]"]
                    }
                }
            }, {
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
            }, {
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
            }]]
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

    var setEvent = function(){

        setGridEvent();

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

$(document).ready(function () {

    console.info("[Loading Module: URL관리].....................");

    var urlMngApp = new UrlMng();
    urlMngApp.init();
});