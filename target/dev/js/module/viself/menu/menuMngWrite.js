/*
 * @(#)codeMng.js    2019-12-10 오전 9:42
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
/**
 * <b>Description</b>
 * <pre>
 *    메뉴 관리 화면
 * </pre>
 * @author 강세원
 */
"use strict";
function MENU_WRITE(){
    var LIST_URL         = "/viself/menu/menuMng.include";
    var LOAD_URL         = "/viself/menu/menuMng/allList/json";
    var SAVE_URL         = "/viself/menu/menuMng/saveMenu/json";
    var DELETE_URL         = "/viself/menu/menuMng/deleteAll/json";
    var MLANG_URL         = "/viself/mlang/mLangMng/list/json";

    var $modalDiv1        ;
    var $writeForm        = $("#menuMngWriteform1");
    var $tmplMenuWirte     = $("#TMPL_MENU_WIRTE");
    var $menuInputList     = $("#MENU_INPUT_LIST");
    var $cd                 = $("#MENU_INPUT_LIST input:text[name='cd']");
    var $parentMenuId    = $("#menuMngWriteform1 input:text[name='parentMenuId']");
    var $langCds        = $("input:text[name='langCd']", $menuInputList);
    var $moduleIds        = $("input:text[name='moduleId']", $menuInputList);
    var $reqMenuId        = $("#reqMenuId");
    var $reqParentMenuId= $("#reqParentMenuId");

    var $btnListAdd        = $("#menuListAdd");
    var $btnSave        = $("#menuMngWriteBtnSave");
    var $btnList        = $("#menuMngWriteBtnList");



    var goList = function(frm) {

        var msg = paragonCmm.getLang("M.ALERT_LIST");
        confirm(msg, function(r){
            if (r) {
                var params = $(frm).serializeJSON();
                params.langCd = "L.시스템메뉴관리";
                main.movePage(LIST_URL,params );
            }
        });
    }

    /**
     * 저장
     */
    var doSubmit = function() {
        var cd     = $cd;

        for(var i=0;i < cd.length ; i++){

            //CODE_ID Validation
            if(cd[i].value == ""){
                alert(paragonCmm.getLang("M.ALERT_INPUT","L.코드"));
                cd[i].focus();
                return;
            }

            //아이디 중복 확인
            for(var j=0;j < cd.length ; j++){
                if(i == j ){
                    continue;
                }else{
                    if(cd[i].value==cd[j].value){
                        alert("중복된 코드 아이디가 존재합니다.");
                        $("#MENU_INPUT_LIST tr:eq("+j+")").find("td").attr("style", "background-color:red");
                        cd[j].focus();
                        return;
                    }
                }
            }
        }
        confirm(paragonCmm.getLang("M.ALERT_SUBMIT", "L.저장"), function(r){
            if (r) {
                var params = {list: $menuInputList.tableDataToJson()};
                params["parentMenuId"] = $parentMenuId.val();

                $.ajax({
                    type: "POST",
                    url: SAVE_URL,
                    data: JSON.stringify(params),
                    success: function(json){
                        if(json.errYn === "E"){
                            //-- 오류처리
                            alert(json.msg);
                            return false;
                        }
                        goList($writeForm);
                        if(typeof setCallback === "function"){
                            setCallback(json);
                        }
                    },
                    dataType: "json",
                    contentType: "application/json"
                });
            }
        });
    }
    var autoComplete = function(){
        //언어사전에 존재하는 단어가 나오도록 자동완성하는 코드.
        $('.autoLangCd').combobox({
            mode: 'remote',
            valueField: 'value',
            textField: 'label',
            loader: function(param, succ){
                console.log(param);
                if (!param.q){return;}
                $.ajax({
                    url: MLANG_URL,
                    data: {langCd:param.q},
                    dataType: 'json',
                    success: function(data){
                        var rows = $.map(data.data, function(item){
                            return {
                                label: item.langCd,
                                value: item.langCd,
                                code:item.langCd
                            };
                        });
                        succ(rows)
                    }
                })
            }
        });
    }

    //코드 라인추가
    var addCodList = function(){
        var codIdx = paragonCmm.getRandomUUID();
        var data = [{init:"N",
                childCnt:"0",
                index:codIdx,
                cd:codIdx,
                urlPath:"",
                moduleId:"",
                langCd:"",
                jsonData:"[{\"key\":\"\",\"val\":\"\"}]",
                useYn:"Y",
                cud:"C",
                ordNo:codIdx
                }];
        $tmplMenuWirte.tmpl(data).appendTo($menuInputList);
    }

    /*
    * 코드 라인 삭제
    */
    var removeCodLine = function(removeKey,child_cnt, authCnt){
        var msg = "";
        if(child_cnt != "0" || authCnt != "0"){
            msg = "하위 메뉴 또는 관련 권한이 존재 합니다. 삭제하시면 하위메뉴 및 관련권한 까지 모두 삭제 됩니다.\n삭제 하시겠습니까?";
        }else{
            msg = "삭제 하시겠습니까?";
        }
        confirm(msg,function(r){
            if(r){
                var data = {};
                data.menuId = $("input:text[name='menuId']", "tr[data-meaning="+removeKey+"]").val();
                console.log(data);
                paragonCmm.callAjax(DELETE_URL,data, function(json){
                    if(json.errYn === "E"){
                        //-- 오류처리
                        alert(json.msg);
                        return false;
                    }
                    $("tr[data-meaning="+removeKey+"]", $menuInputList).remove();
                });
            }
        });
    }

      //저장항목 로드
    var loadPatentTable = function(){
        var data = {};
        if( "CHILD" == $("#updateMode").val()){
            data["parentCd"] = $reqMenuId.val();
        }else{
            data["menuId"] = $reqMenuId.val();
        }
          paragonCmm.callAjax(LOAD_URL, data, function(data){
              $tmplMenuWirte.tmpl(data.data).appendTo($menuInputList);
              paragonCmm.tableTrDragSet($menuInputList);
        });
    }
    var openModal = function(obj){
        $(obj).val("");// 클릭시 값 초기화
        if( typeof $modalDiv1 != "object"){
            $modalDiv1 = $("<div>");
        }
        $modalDiv1.window({
            iconCls:'icon-search',
            width:850,
            height:500,
            title:"Module select",
            href:"/viself/module/moduleListDialog.modal",
            modal:true,
            onClose:function(){
                $modalDiv1.window("destroy");
            },
            onLoad:function(){
                moduleList.init(function(){
                    //-- init Function
                }, function(moduleId){
                    //-- callback Function
                    $(obj).val(moduleId);
                    $modalDiv1.window("destroy");
                });            //-- init,콜백 Function 지정
                paragonCmm.convertLang($modalDiv1);             //-- 다국어 처리
            }
        });
    }
      //이벤트 추가
    var attachEvents = function(){
        //코드 추가 버튼
        $btnListAdd.off();
        $btnListAdd.click(function(){
            addCodList();
            paragonCmm.tableTrDragSet($menuInputList);
            autoComplete();

            $("input:text[name='moduleId']", "#MENU_INPUT_LIST").off();
            $("input:text[name='moduleId']", "#MENU_INPUT_LIST").on("click",function(){
                openModal(this);
            });

        });
        $btnSave.off();
        $btnSave.on("click",function(){
            doSubmit();
        });
        $btnList.off();
        $btnList.on("click",function(){
            goList($writeForm);
        });
        $("input:text[name='moduleId']", "#MENU_INPUT_LIST").off();
        $("input:text[name='moduleId']", "#MENU_INPUT_LIST").on("click",function(){
            openModal(this);
        });
    }

      var init = function(){
          if( "CHILD" == $("#updateMode").val()){
              $parentMenuId.val($reqMenuId.val());
        }else{
            $parentMenuId.val($reqParentMenuId.val());
        }
        loadPatentTable();
        autoComplete();
        attachEvents();

    }

      return{
          init:init,
          removeCodLine:removeCodLine
      }

}
    var MENUWRITE = new MENU_WRITE();
    $(document).ready(function () {

        console.info("[Loading Module: 메뉴관리작성].....................");

        MENUWRITE.init();
    }());
