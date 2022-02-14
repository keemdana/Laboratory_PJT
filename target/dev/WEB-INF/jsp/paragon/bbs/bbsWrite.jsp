<%@page import="com.vertexid.spring.utils.SessionUtils" %>
<%@page import="com.vertexid.commons.utils.DateUtil" %>
<%@page import="com.vertexid.viself.hr.SysLoginVO" %>
<%@page import="com.vertexid.commons.utils.StringUtil" %>
<%@page import="com.vertexid.commons.utils.HtmlUtil" %>
<%@ page import="com.vertexid.viself.hr.SysLoginVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%
    SysLoginVO loginUser = (SysLoginVO) SessionUtils.getLoginVO();
    String siteLocale = loginUser.getSiteLocale();

    String schFieldCodestr = "Y|사용^N|미사용";
%>

<div class="content-panel p-3" id="bbsWrite">
    <h5 class="sub1_title" data-term="L.공지사항"><i class="fa fa-file-text"></i></h5> ( <span
        class="ui_icon required"></span> <span data-term="L.는_필수_입력항목"></span>)
    <div>
        <form name="bbsWriteForm" id="bbsWriteForm" method="post">
            <div id="bbsWriteForm2" data-opener-data="<c:out value='${param.openerData}'/>">
                <input type="hidden" name="bbsUid" id="bbsUid" data-col="bbsUid" value=""/>
                <input type="hidden" name="bbsTpCd" id="bbsTpCd" value="CMM_BBS_NOTICE"/>
                <table class="basic">
                    <colgroup>
                        <col style="width:15%;">
                        <col style="width:35%;">
                        <col style="width:15%;">
                        <col style="width:35%;">
                    </colgroup>
                    <tr>
                        <th data-term="L.등록일"></th>
                        <td><%=DateUtil.getCurrentDate()%>
                            <input type="hidden" name="bbsRegDte" id="bbsRegDte" class="form-control"
                                   data-col="bbsRegDte" value="<%=DateUtil.getCurrentDate()%>" readonly>
                        </td>
                        <th data-term="L.등록자"></th>
                        <td><%=loginUser.getDspNmKo()%>
                            <input type="hidden" name="bbsRegNm" id="bbsRegNm" class="form-control" data-col="bbsRegNm"
                                   value="<%=loginUser.getDspNmKo()%>" readonly>
                            <input type="hidden" name="bbsRegLoginId" id="bbsRegLoginId"
                                   value="<%=loginUser.getLoginId() %>"/>
                            <input type="hidden" name="bbsUptLoginId" id="bbsUptLoginId"
                                   value="<%=loginUser.getLoginId() %>"/>
                        </td>
                    </tr>
                    <tr>
                        <th><span class="ui_icon required" data-term="L.제목"></span></th>
                        <td colspan="3">
                            <input type="text" id="bbsTit" name="bbsTit" class="form-control" data-col="bbsTit"
                                   value=""/>
                        </td>
                    </tr>
                    <tr>
                        <th data-term="L.상단게시여부"></th>
                        <td>
                            <div class="form-check form-check-inline p-1">
                                <label class="form-check-label" data-term="L.사용"><input class="form-check-input"
                                                                                        type="radio" id="bbsTopY"
                                                                                        name="bbsTopYn"
                                                                                        value="Y"></label>
                                <label class="form-check-label" data-term="L.미사용"><input class="form-check-input"
                                                                                         type="radio" id="bbsTopN"
                                                                                         name="bbsTopYn" value="N"
                                                                                         checked></label>

                                <!--                     <input type="radio" name="bbsTopYn" data-col="bbsTopYn" value="Y"/>사용
                                                    <input type="radio" name="bbsTopYn" data-col="bbsTopYn" value="N" checked/>미사용 -->
                            </div>
                        </td>
                        <th data-term="L.메인팝업기간"></th>
                        <td>
                            <div class="input-group">
                                <input type="text" name="bbsPopupStDte" id=bbsPopupStDte data-col="bbsPopupStDte"
                                       class="form-control" style="width: 45%;">
                                <span class="p-1">~</span>
                                <input type="text" name="bbsPopupEdDte" id="bbsPopupEdDte" data-col="bbsPopupEdDte"
                                       class="form-control" style="width: 45%;">

                            </div>

                            <!--                     <input type="date" name="bbsPopupStDte" style="width:150px;" data-col="bbsPopupStDte" value=""/>
                                                <span class="separ">~</span>
                                                <input type="date" name="bbsPopupEdDte" id="bbsPopupEdDte" style="width:150px;" data-col="bbsPopupEdDte" value=""/> -->
                        </td>
                    </tr>
                    <tr>
                        <th data-term="L.내용"></th>
                        <%--                <td colspan="3"><%=HtmlUtil.getHtmlEditor(request, true, "bbsContent", "bbsContent", "", "data-col=\"bbsContent\"", "100%", "", "Default") %> </td>--%>
                        <td colspan="3"><%=HtmlUtil.getHtmlEditor(request, true, "bbsContent", "bbsContent", "", "data-col=\"bbsContent\"",
                                "100%", "", "Default") %>
                        </td>
                    </tr>
                    <tr>
                        <th data-term="L.첨부"></th>
                        <td colspan="3" id="bbsFile" name="bbsFile"></td>
                    </tr>
                </table>
                <div class="buttonlist">
                    <div class="right">
                        <span class="ui_btn medium icon" id="btnSave" name="btnSave"><i class="fa fa-save"><a
                                href="javascript:void(0)" data-term="B.SAVE"></a></i></span>
                    </div>
                </div>
        </form>
    </div>
</div>


<script type="text/javascript">

    function BbsWrite() {
        var openerData = $("#bbsWriteForm2").data("opener-data");
        console.log(openerData);
        $("#bbsUid").val(openerData.bbsUid);
        var BBS_SELECT_ONE_URL = "/paragon/bbs/bbsMas/bbsMasView/json"; //수정모드 조회용
        var BBS_INSERT_URL = "/paragon/bbs/bbsMas/insert/json";     //신규 등록
        var BBS_UPDATE_URL = "/paragon/bbs/bbsMas/update/json";        //수정

        //var $bbsUid = openerData.bbsUid;
        var $isNew = openerData.isNew;
        var $bbsWriteForm = $("#bbsWriteForm");
        var $bbsUid = $("#bbsUid");
        var $bbsPopupStDte = $("#bbsPopupStDte");
        var $bbsPopupEdDte = $("#bbsPopupEdDte");
        var $saveBtn = $("#btnSave");


        var doValidation = function () {    //-- 저장 필수체크
            if ($("input:text[name='bbsTit']", $bbsWriteForm).val() == "") {
                alert("제목을 입력해주세요.", function () {
                    $("input:text[name='bbsTit']", $bbsWriteForm).focus();
                });
                return false;
            }
            if ($("#bbsTopYn", $bbsWriteForm).val() == "") {
                alert("상단게시여부를 선택해주세요", function () {
                    $("#bbsTopYn", $bbsWriteForm).focus();
                });
                return false;
            }
            //상신일자, 결재일자 검색조건 시작일 > 결재일일 경우 알림
            var popupFromDate = $bbsPopupStDte.val();
            var popupToDate = $bbsPopupEdDte.val();

            if (popupFromDate > popupToDate) {
                alert("팝업종료일이 시작일보다 빠릅니다. <P> 팝업기간을 올바르게 입력해주세요.");
                return false;
            }
            return true;
        }

        var doSubmit = function () {
            var msg = paragonCmm.getLang("M.ALERT_SUBMIT", "L.저장");
            if (!doValidation()) {
                return false;
            }
            confirm(msg, function (r) {
                if (r) {

                    var cbFncInsert = function(){
                        window.opener.BBSLIST.doSearch();
                        window.close();
                    };
                    var cbFncUpdate = function(){
                        window.opener.opener.BBSLIST.doSearch();
                        window.opener.close();
                        window.close();
                    };

                    var saveUrl = BBS_INSERT_URL;
                    var cbFnc = cbFncInsert;
                    //UPDATE
                    if ($isNew === "FALSE") {
                        saveUrl = BBS_UPDATE_URL;
                        cbFnc = cbFncUpdate;
                    }

                    paragonCmm.setEditorSubmit("");
                    var data = $bbsWriteForm.serializeObject();

                    // console.log(data);

                    // HACK
                    // CKEditor 에서 작성한 것을 serializeObject() 할경우
                    // String 변환하기 때문에 alt="" -> alt=\"\" 형태로 변경
                    // 해서 직접값을 받아서 다시 설정함
                    data.bbsContent = $bbsWriteForm.find("textarea[name=bbsContent]").val().replace(/\"/gi, "'");

                    // console.log($bbsWriteForm.find("textarea[name=bbsContent]").val());
                    //
                    // console.log(data.bbsContent);
                    // console.log(data);

                    // paragonCmm.submitAjax(saveUrl, JSON.stringify(data), function (json) {
                    //callAjax 를 submitAjax로 변경
                    //파일저장이 필요할 땐 submitAjax를 써야한다 (callAjax에는 파일처리가 미포함)
                    paragonCmm.submitAjax(saveUrl, data, function (json) {
                        if (json.errYn === "E") {
                            //오류처리
                            alert(json.msg);
                            return false;
                        }
                        cbFnc();
                    });
                }
            });
        }

        var loadData = function (jsonData) {
            var data = $.extend({}, openerData, jsonData);
            paragonCmm.callAjax("/paragon/bbs/bbsMas/bbsMasView/json", data, function (json) {
                if (typeof json === "object") {
                    var master = json.data;
                    $.each(master, function (key, val) {
                        var obj = $("[data-col=" + key + "]", $bbsWriteForm);
                        var tagNam = $(obj).prop("tagName");
                        if ("INPUT" == tagNam) {
                            var typeNm = $(obj).attr("type");
                            if ("radio" == typeNm || "checkbox" == typeNm) {
                                $("input[data-col=" + key + "][value='" + val + "']", $bbsWriteForm).prop("checked", true);
                            } else if (key == "bbsPopupStDte" || key == "bbsPopupEdDte") {
                                $("#" + key).datebox('setValue', val);
                            } else {
                                $(obj).val(val);
                            }
                        } else {
                            $(obj).val(val);
                        }
                    });
                }
            });
        }

        //-- 웹에디터 첨부파일 Form 로드
        var loadForm = function () {

        	var attchId = "bbsFile";
            var options = {}

            options.relUid = $("#bbsUid").val();    //-- 관례 키 UIDH
            options.fileTpCd = "CMM/BBS";    //-- 파일 유형 코드
            options.defaultRelUid = "";                //-- 기본 로드 첨부파일(수정시)
            console.log("options")
            console.log(options)

            try{

            htmlUtils.loadFileHtml(attchId, options);
            }catch (e){
                console.log(e);
            }

        }

        var initFormComponent = function () {
            //날짜컴포넌트 : start date
            $bbsPopupStDte.datebox({});
            //날짜컴포넌트 : end date
            $bbsPopupEdDte.datebox({
                //  validType: ["date"]
            });
        }
        var attchmentEvent = function () {
            $saveBtn.off();
            $saveBtn.on("click", function () {
                doSubmit();
            });
        }

        var init = function () {

            loadForm();                            //-- 양식 로드
            initFormComponent();
            attchmentEvent();
            if ($isNew === "FALSE") {
                loadData();
            }
        }
        return {
            init: init
        }

    }

    var bbsWrite = new BbsWrite();
    bbsWrite.init();
</script>