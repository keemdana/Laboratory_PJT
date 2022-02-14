/*
 * @(#)moduleDialog.js     2021-12-23(023) 오후 2:35
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

var ModuleDialogViewModel = function(){
    "use strict";

    var MODULE_SAVE_URL = ("/viself/module/moduleMng/save/json");
    var MODULE_DELETE_URL = ("/viself/module/moduleMng/delete/json");

    var saveModule = function(data, cbFnc){
        paragonCmm.callAjax(paragonCmm.getUrl(MODULE_SAVE_URL), data, cbFnc);
    };

    var deleteModule = function(data, cbFnc){
        paragonCmm.callAjax(paragonCmm.getUrl(MODULE_DELETE_URL), data, cbFnc);
    };

    return {
        saveModule: saveModule,
        deleteModule: deleteModule
    };
};

/**
 * 모듈 다이얼로그
 * @returns {{init: init}}
 * @constructor
 */
var ModuleDialog = function () {
    "use strict";

    var $rootDom = $("#moduleMngPop1Frm0");

    var $dialogDelBtn = $("#moduleMngPop1DeleteBtn1");
    var $dialogForm = $("#moduleMngPop1Frm0");
    var dialogUseYnComboName = "moduleMngPop1Select1";
    var callBackFnc;
    var model = new ModuleDialogViewModel();

    var code = {
        useYnOptions: [
            {id: "Y", value: "Use"},
            {id: "N", value: "No Use"}
        ]
    };

    var initForm = function () {
        $dialogDelBtn.addClass("hidden");
        htmlUtils.initializeSelectJson(dialogUseYnComboName, dialogUseYnComboName, code.useYnOptions, "", "id", "value");
        callBackFnc = $rootDom.data("callback");
    };

    var loadData = function () {
        var row = $rootDom.data("opener-data");

        console.log(paragonCmm.tempData);

        if (row) {
            $dialogDelBtn.removeClass("hidden");
            $dialogForm.find("input[name=cud]").val("U");
            $dialogForm.find("input[name=moduleId]").attr("readonly", true);
            $dialogForm.find("input[name=moduleId]").val(filterXSS(row.moduleId));
            $dialogForm.find("input[name=moduleDesc]").val(filterXSS(row.moduleDesc));
            $dialogForm.find("select[name=useYn]").val(filterXSS(row.useYn));
        } else {
            $dialogDelBtn.addClass("hidden");
            $dialogForm.find("input[name=cud]").val("C");
            $dialogForm.find("input[name=moduleId]").attr("readonly", false);
            $dialogForm.find("input[name=moduleId]").val("");
            $dialogForm.find("input[name=moduleDesc]").val("");
            $dialogForm.find("select[name=useYn]").val("Y");
        }
    };

    var closeModal = function(booleanFlag){
        if(typeof callBackFnc === "function"){
            callBackFnc(booleanFlag);
        }
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

    var saveModule = function(){
        var data = $dialogForm.serializeObject();
        $.messager.confirm("Confirm",'정말 저장하시겠습니까?',function(r) {
            if(r){
                var cbFnc = function(data){
                    showMsg(data);
                    closeModal(true);
                }

                model.saveModule(data, cbFnc);
            }
        });
    };

    var deleteModule = function(){
        var data = $dialogForm.serializeObject();
        $.messager.confirm("Confirm",'정말 삭제하시겠습니까?',function(r) {
            if(r){
                var cbFnc = function(data){
                    showMsg(data);
                    closeModal(true);
                }

                model.deleteModule(data, cbFnc);
            }
        });
    };

    var setEvent = function () {
        // delete old event
        $rootDom.find("button").off();

        $rootDom.on("click", "button", function () {
            var btnId = $(this).attr("id");

            switch (btnId) {

                case "moduleMngPop1CloseBtn1":

                    closeModal();
                    break;

                case "moduleMngPop1SaveBtn1":
                    saveModule();
                    break;

                case "moduleMngPop1DeleteBtn1":
                    deleteModule();
                    break;

                default:
                    console.log($(this));
                    break;
            }

            return false; // 이벤트 버블링 종료
        });
    };

    var init = function () {
        // 1. init form
        initForm();
        // 2. load data
        loadData();
        // 3. set event
        setEvent();
    };

    return {
        init: init
    };
};