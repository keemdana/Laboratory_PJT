/*
 * @(#)urlListDialog.js     2021-12-24(024) 오전 11:19
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

var UrlListDialogModel = function(){
    "use strict";

    var URL_SEARCH_URL = paragonCmm.getUrl("/viself/module/moduleMng/urlList/json");

    var MODULE_URL_SAVE_URL = paragonCmm.getUrl("/viself/module/moduleMng/saveModuleUrl/json");

    var getSearchUrlListUrl = function(){
        return URL_SEARCH_URL;
    };

    var saveModuleUrl = function(data, cbFnc){
        paragonCmm.callAjax(MODULE_URL_SAVE_URL, data, cbFnc);
    };

    return {
        getSearchUrlListUrl: getSearchUrlListUrl,
        saveModuleUrl: saveModuleUrl
    };
};

/**
 * Url 리스트 다이얼로그
 * @returns {{init: init}}
 * @constructor
 */
var UrlListDialog = function(){
    "use strict";

    var $rootDom = $("#moduleMngPop2Frm0");
    var $dialogGrid = $("#moduleMngPop2List1");
    var vModel = new UrlListDialogModel();
    var callBackFnc;

    var getQueryParams = function(){

        console.log($rootDom.data("opener-data"));

        return $rootDom.data("opener-data");
    };

    var initGrid = function(){
        $dialogGrid.datagrid({
            url: vModel.getSearchUrlListUrl(),
            method: "post",
            queryParams: getQueryParams(),
            loadFilter: paragonCmm.easyuiLoadFilter,
            height: 450,
            striped : true,
            fitColumns : true,
            nowrap: true,
            multiSort : true,
            remoteSort: true,
            rownumbers: true,
            singleSelect: true,
            checkOnSelect: true,
            selectOnCheck: false,
            pagination : true,
            pagePosition: "bottom",
            pageSize: 10,
            columns:[[{
                field: "chk", checkbox: true, width: "1%", toExcel: false
            },{
                field: "accesUrl", title: "URL", formatter: filterXSS, width: "40%"
            }, {
                field: "urlDesc", title: "Description", formatter: filterXSS, width: "57.5%"
            }]]
        });
    };

    var closeModal = function(booleanFlag){
        if(typeof callBackFnc === "function"){
            callBackFnc(booleanFlag);
        }
    };

    var initForm = function(){
        callBackFnc = $rootDom.data("callback");
        initGrid();
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

    var addUrl = function(){
        var rows = $dialogGrid.datagrid("getChecked");
        if(!rows || rows.length === 0){
            return;
        }
        var param = $.extend({},getQueryParams(),{
            cud: "C",
            list: rows
        });
        $.messager.confirm("Confirm",'정말 저장하시겠습니까?',function(r) {
            if(r){
                var cbFnc = function(data){
                    showMsg(data);
                    closeModal(true);
                }

                vModel.saveModuleUrl(param, cbFnc);
            }
        });
    };

    var setEvent = function(){
        $rootDom.find("button").off();
        $rootDom.on("click", "button", function(){
            var btnId = $(this).attr("id");
            switch (btnId) {
                case "moduleMngPop2CloseBtn1" :
                    closeModal();
                    break;
                case "moduleMngPop2ConfirmBtn1" :
                    addUrl();
                    break;
                default :
                    break;
            }

            return false; // 이벤트 버블링 종료
        });
    };

    var init = function(){
        initForm();
        setEvent();
    };

    return {
        init: init
    };
};