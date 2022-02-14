<%@page import="com.vertexid.commons.utils.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.vertexid.commons.utils.CommonConstants"%>
<%@page import="com.vertexid.viself.hr.SysLoginVO"%>
<%@ page import="com.vertexid.spring.utils.SessionUtils" %>
<%@ page import="com.vertexid.viself.hr.SysLoginVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    SysLoginVO loginUser     =     (SysLoginVO) SessionUtils.getLoginVO();
    String siteLocale            = loginUser.getSiteLocale();
    String capitalizeSiteLocale = StringUtil.capitalize(siteLocale.toLowerCase());// ko >> Ko
%>
<div id="stuFormTotal" class="row">
    <div class="col-md-12 col-sm-12">
        <div class="white-panel">
        <div class="buttonlist" >
            <div class="left" id="<c:out value='${param.docUid}'/>_btnProcArea">
                <span id="allCollapFalse" class="ui_btn small icon"><i class="fa fa-plus"><a href="javascript:void(0)" data-term="L.전체열기" ></a></i></span>
                <span id="allCollapTrue" class="ui_btn small icon"><i class="fa fa-minus"><a href="javascript:void(0)" data-term="L.전체닫기" ></a></i></span>
            </div>
        </div>
        <input type="hidden" id="stuFormTotal_solMasUid" value="<c:out value="${param.solMasUid}"/>"/>
        <input type="hidden" id="stuFormTotal_stuCd" value="<c:out value="${param.stuCd}"/>"/>
        <input type="hidden" id="stuFormTotal_stuDtl" value="<c:out value="${param.stuDtl}"/>"/>
        <div id="formViewPanels" class="easyui-accordion" data-options="multiple:true"></div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12 col-sm-12">
        <div id="stuFormTotal_stuNextProcArea" class="white-panel" style="display:none;">
            <h6 class="sub2_title"><i class="fa fa-file-text"></i> 다음 처리업무</h6>
            <table class="basic">
            <tr>
                <th class="th2" data-term="L.처리업무"></th>
                <td style="text-align:right;" id="stuFormTotal_stuNextProcBtns">
                </td>
            </tr>
            </table>
        </div>
    </div>
</div>
<!-- 사후점검이 아닐 경우 닫기 버튼 활성화 -->
<c:if test="${param.stuCd ne 'SM_REPORT'}">
<div class="buttonlist">
     <div class = "right">
    	<span class="ui_btn medium icon" id="StuCloseBtn"><i class="fa fa-window-close"><a href="javascript:void(0);" data-term="B.CLOSE"></a></i></span>
     </div>
</div>
</c:if>
<br/>
<script type="text/javascript">

"use strict";

function StuFromTotal(){
    var DATA_CUBE_URL     = "/paragon/datacube/DataCube/list/json";                //-- 아코디언 리스트
    var FORM_WRITE_URL     = "/paragon/def/defStuForm/defStuFormWrite.include";    //-- 작성폼
    var FORM_VIEW_URL     = "/paragon/def/defStuForm/defStuFormView.include";        //-- 뷰폼
    var STU_REL_URL     = "/paragon/def/defsturel/DefStuRel/outList/json";        //-- 투두일때 다음처리 버튼
    var TODO_URL         = "/ims/main/Dashboard/todoList/json";                    //-- 투두여부 체크
    var STUPROC_URL         = "/paragon/datacube/DataCube/doStuProc/json";            //-- 상태만 변경 처리

    var preFix             = "stuFormTotal";
    var solMasUid        = $("#"+preFix+"_solMasUid").val();
    var stuCd            = $("#"+preFix+"_stuCd").val();
    var stuDtl            = $("#"+preFix+"_stuDtl").val();
    var inUid            = "";
    var todoType        = "";
    var isTodo            = false;
    var lastDocUid        = "";

    var $panels         = $("#formViewPanels");
    var $stuNextProcArea= $("#"+preFix+"_stuNextProcArea");        //-- 다음처리 영역
    var $stuNextProcBtns= $("#"+preFix+"_stuNextProcBtns");        //-- 다음처리 버튼 영역
    var $nextProcModal;                                            //-- 다음처리 문서(상태) 모달

    var isDoStuProc        = true;        //-- 더블클릭 방지

    var doOpenerCallback = function(){
        if(typeof(opener) !== "undefined") {
            if(typeof opener.baseOpener !== "undefined"){
                if(typeof opener.baseOpener.popupCbFnc === "function"){
                    opener.baseOpener.popupCbFnc();
                }
            }
        }
    };

    var setEvent = function(){
        //--전체 열기
        $("#allCollapFalse").on('click',function(){
            var panel = $(".panel-tool-collapse");
            for(var i=0; i < panel.length;i++){
                if(panel[i].className.indexOf("panel-tool-expand") > -1){
                    $(panel[i]).trigger('click');
                }
            }
        });
        //--전체 닫기
        $("#allCollapTrue").on('click',function(){
            var panel = $(".panel-tool-collapse");
            for(var i=0; i < panel.length;i++){
                if(panel[i].className.indexOf("panel-tool-expand") == -1){
                    $(panel[i]).trigger('click');
                }
            }
        });


    }
    //-- 문서 로드
    var loadAccodian = function(){

        if(solMasUid != null && solMasUid !=""){
            var data = {};
            data["solMasUid"] = solMasUid;
            paragonCmm.callAjax(DATA_CUBE_URL,data, function(json){
                if(json.data){
                    $panels.accordion({
                        animate:false
                    });
                    var nextStuCd =
                    $(json.data).each(function(i, e){
//                         console.log(e);
                        var otp = {};
                        otp.title = paragonCmm.getLang(e.docNmLangCd);            //-- 아코디언 헤더명 설정
                        otp.href = FORM_VIEW_URL;            //-- 기본 뷰패널
                        if($(json.data).length -1 == i && otp.stuDtl == "T"){    //-- 최종문서 이면서 임시서장 상태일땐 작성패널
                            otp.href = FORM_WRITE_URL;
                        }
                        if(todoType == "APRV"){
                            otp.href = FORM_WRITE_URL;
                        }
                        otp.queryParams = {
                                docUid:e.docUid
                                , stuCd:e.stuCd
                                , solMasUid: solMasUid
                                };                            //-- 요청 Parameter 셋팅
                        otp.collapsible     = true            //-- 닫힘 아이콘 사용여부
                        if($(json.data).length - 1 == i ){
                            otp.collapsed     = false;        //-- 펼치기
                            otp.selected     = true;            //-- 최종문서 선택
                            lastDocUid         = e.docUid;
                        }else{
                            otp.collapsed     = true;            //-- 접히기
                            otp.selected     = false;        //-- 이전문서 미선택
                        }
                        otp.onExpand = function(){            //-- 열릴때 resize 이벤트
                            setTimeout(function(){
                                pageResize();
                            },500);
                        }
                        otp.onCollapse = function(){        //-- 닫힐때 resize 이벤트
                            setTimeout(function(){
                                pageResize();
                            },300);
                        }
                        otp.onLoad = function(){            //-- 로드완료 resize 이벤트
                            setTimeout(function(){
                                pageResize();
                            },300);
                            paragonCmm.convertLang($(this));
                        }

                        $panels.accordion('add',otp);
                    });
                }
            });
        }
    }
    //-- 투두 여부 로드
    var loadTodo = function(){
        var data = {};
        data.solMasUid = solMasUid;
        paragonCmm.callAjax(TODO_URL,data, function(json){
            if($(json.data).length > 0){
                inUid = json.data[0].inUid;
                todoType = json.data[0].todoType;
                isTodo = true;
            }
        });
    }
    //-- 상태만 변경 처리
    var doStuProc = function(e){
        console.log("...................doStuProc");

        var msg = paragonCmm.getLang("M.진행하시겠습니까", e.nextStuNm);

        if(!isDoStuProc) return false; //-- 중복클릭 방어 코드
        else{
            if("M" != e.procTp){          //-- 미리보기용 임시저장일때는 중복코드 방어를 적용하지 않는다.20190409 강세원
                isDoStuProc = false;
            }
        }

        var data = {};
        data.docUid     = lastDocUid;
        data.stuCd      = e.nextStuCd;
        data.stuDtl      = e.procTp;
        data.solMasUid  = solMasUid;
        data.beStuCd      = stuCd;
        data.beStuDtl      = stuDtl;
        data.stuTp2      = e.stuTp2;

        confirm(msg, function (r) {
            if (r) {
                $.messager.progress({
                    interval: 1000
                });
                paragonCmm.submitAjax(STUPROC_URL,data, function(json){
                    $.messager.progress('close');
                    if(json.errYn === "E"){
                        //-- 오류처리
                        alert(json.msg);
                        isDoStuProc = true;
                        return false;
                    }else{
                        debugger;
                        $.messager.alert({
                            msg: paragonCmm.getLang("M.ALERT_DONE", e.nextStuNm),
                            fn: function(){
                                if(opener){
                                    doOpenerCallback();
                                    window.close();
                                }
                            }
                        });
                    }


                },true, function(){ //-- error callback function
                    $.messager.progress('close');
                    isDoStuProc = true;
                });
            }else{
                isDoStuProc = true;
            }
        });
    }
    //-- 다음처리 버튼 클릭
    var goNextProc = function(e){
        console.log("...................goNextProc");
        if(e.procTp == "P"){    //-- 상태만 변경
            doStuProc(e);
        }else{
            //-- 다음처리문서 모달 팝업
            var queryParams = {};
            queryParams["stuCd"] = e.nextStuCd;
            queryParams["docUid"] = paragonCmm.getRandomUUID();
            queryParams["solMasUid"] = solMasUid;

            if( typeof $nextProcModal != "object"){
                $nextProcModal = $("<div>");
            }
            //-- 코드 선택 모달
            $nextProcModal.window({
                iconCls:'icon-more',
                width:850,
                height:500,
                title:paragonCmm.getLang(e.nextStuNm),
                href:"/paragon/def/defStuForm/defStuFormWrite.modal",
                modal:true,
                queryParams:queryParams,
                onClose:function(){
                    $nextProcModal.window("destroy");
                },
                onLoad:function(){
                    paragonCmm.convertLang($nextProcModal);             //-- 다국어 처리
                }
            });

        }
    }
    //-- 다음처리 버튼
    var nextProcBtn = function(){
        console.log("...................nextProcBtn");
        if("" === inUid){    //-- 다음 처리 버튼어 없으면 false
            return false;
        }
        if("APRV" === todoType){    //-- 결재투두일경우 false
            return false;
        }
        if(!isTodo){    //-- 투두가 아니면 false
            return false;
        }
        var data = {inUid:inUid};
        paragonCmm.convertLang($stuNextProcArea);
        $stuNextProcArea.show();
        paragonCmm.callAjax(STU_REL_URL,data, function(json){
            if(json.errYn === "E"){
                alert(json.msg);//-- 오류처리
                return false;
            }
            $(json.data).each(function(i,e){
                console.log(e);
                var uiBtn = $('<span class="ui_btn medium icon">');
                var iTag  = $("<i>").attr("class","fa fa-check");
                uiBtn.append(iTag.append($("<a href='javascript:void(0)'>").text(paragonCmm.getLang(e.nextStuNm))));
                $stuNextProcBtns.append(uiBtn);
                $(uiBtn).off();
                $(uiBtn).on("click",function(){
                    goNextProc(e);
                });

            });
        });
    }


    var init = function(){
        loadTodo();
        loadAccodian();
        nextProcBtn();
        setEvent();

    }
    return{
        init:init
    }
}
var stuFromTotal = new StuFromTotal();
$(document).ready(function () {
    stuFromTotal.init();
}());

//닫기
$('#StuCloseBtn').on("click",function(){
		self.close();
});
</script>