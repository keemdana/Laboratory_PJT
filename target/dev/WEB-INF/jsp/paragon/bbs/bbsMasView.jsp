<%@page import="com.vertexid.commons.utils.HtmlUtil" %>
<%@page import="com.vertexid.spring.utils.SessionUtils" %>
<%@page import="com.vertexid.viself.base.ModelAttribute" %>
<%@page import="com.vertexid.commons.utils.ParamMap" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="com.vertexid.commons.utils.StringUtil" %>
<%@page import="com.vertexid.commons.utils.CommonConstants" %>
<%@page import="com.vertexid.viself.hr.SysLoginVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    SysLoginVO loginUser = (SysLoginVO) SessionUtils.getLoginVO();
    String siteLocale = loginUser.getSiteLocale();
    String capitalizeSiteLocale = StringUtil.capitalize(siteLocale.toLowerCase());// ko >> Ko


%>
<div class="content-panel p-3" id="bbsView">
    <input type="hidden" name="bbsUid" value=""/>
    <h5 class="sub1_title" data-term="L.공지사항"><i class="fa fa-file-text"></i></h5>
    <form name="bbsViewForm" id="bbsViewForm"></form>
    <div id="bbsViewForm2" data-opener-data="<c:out value='${param.openerData}'/>">
        <input type="hidden" value="<%=loginUser.getLoginId()%>">
        <input type="hidden" id="bbsRegLoginId" value="">
        <table class="basic">
            <colgroup>
                <col style="width:15%;">
                <col style="width:35%;">
                <col style="width:15%;">
                <col style="width:35%;">
            </colgroup>
            <tr>
                <th data-term="L.작성일" style="text-align:center"></th>
                <td data-col="bbsRegDte"></td>
                <th data-term="L.작성자" style="text-align:center"></th>
                <td data-col="bbsRegLoginNm"></td>
            </tr>
            <tr>
                <th data-term="L.제목" style="text-align:center"></th>
                <td colspan="3" data-col="bbsTit">
                </td>
            </tr>
            <tr>
                <th data-term="L.상단게시여부" style="text-align:center"></th>
                <td data-col="bbsTopYn">
                    <!--                 <input type="radio" name="bbsTopYn" value="Y"/>사용
                                    <input type="radio" name="bbsTopYn" value="N" checked="checked"/>미사용 -->
                </td>
                <th data-term="L.메인팝업기간" style="text-align:center"></th>
                <td><span class="separ" data-col="bbsPopupStDte"></span> ~ <span class="separ"
                                                                                 data-col="bbsPopupEdDte"></span>
                </td>
            </tr>
            <tr>
                <th data-term="L.내용" style="text-align:center"></th>
                <td colspan="3" data-col="bbsContent" style="height:300px; vertical-align: top;"></td>
            </tr>
            <tr>
                <th data-term="L.첨부파일" style="text-align:center"></th>
                <td colspan="3" id="bbsFile"></td>
            </tr>
        </table>
        <div class="buttonlist">
            <div class="left" style="display:none;margin-right:20px;" id="checkDiv">
                <!-- <input type="checkbox" id="showCheck" />&nbsp; 오늘 더 이상 보지 않기 -->
                &nbsp;<%=HtmlUtil.getInputCheckbox(true, "deadline", "toDate|" + "&nbsp;&nbsp;오늘 더 이상 보지 않기", "",
                    "onclick=\"javascript:closeWin(this.value)\"", "style=\"color:blue;\"")%>
            </div>
            <div class="right" style="display:none;" id="buttonDiv">
                <!-- 수정버튼 작성자/게시판담당자/시스템담당자일 경우 보이기 -->
                <span class="ui_btn medium icon" id="btnModify" name="btnModify"><i class="fa fa-edit"><a
                        href="javascript:void(0)" data-term="B.MODIFY"></a></i></span>
                <span class="ui_btn medium icon" id="btnDelete" name="btnDelete"><i class="fa fa-minus"><a
                        href="javascript:void(0)" data-term="B.DELETE"></a></i></span>
                <!--                  <span class="ui_btn medium icon" id="btnList"><i class="fa fa-list-ul" ><a href="javascript:void(0)" data-term="B.LIST"></a></i></span>
                 -->            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    //오늘 더이상 보지않기!
    function closeWin(seq) {
        paragonCmm.setCookie(seq, "ok", 1);
        self.close();
    }

    var BbsMasView = function () {


        var openerData = $("#bbsViewForm2").data("opener-data");
        console.log("openerData")
        console.log(openerData)
        var bbsViewForm = $("#bbsViewForm");
        var $bbsUid = openerData.bbsUid
        var $openType = openerData.openType;
        var $bbsRegLoginId;
        var $bbsLoginId = $("#bbsRegLoginId").val()

        if ($openType == "MAIN") {
            $("#checkDiv").show();
        } else {
            $("#checkDiv").hide();
        }

        var loadData = function (jsonData) {

            var data = $.extend({}, openerData, jsonData);
            console.log("data..")
            console.log(data)
            $("#bbsView").find("input[name=bbsUid]").html(data.bbsUid);
            paragonCmm.callAjax("/paragon/bbs/bbsMas/bbsMasView/json", data, function (json) {
                if (typeof json === "object") {
                    //-- 마스터
                    var master = json.data;
                    console.log("master..")
                    console.log(master)

                    $.each(master, function (key, val) {
                        $("[data-col='" + key + "']", "#bbsView").html(val);
                        if (json.data["bbsTopYn"] == "Y") {
                            $("[data-col='bbsTopYn']", "#bbsView").html("사용");
                        } else {
                            $("[data-col='bbsTopYn']", "#bbsView").html("미사용");
                        }
                    });
                    $bbsRegLoginId = master["bbsRegLoginId"]
                    $("#bbsView").find("#bbsRegLoginId").val($bbsRegLoginId)
                    if ($bbsRegLoginId == "<%=loginUser.getLoginId()%>" || <%=loginUser.isUserAuth("CMM_SYS") %> || <%=loginUser.isUserAuth("IMS_CHR")%>) {
                        $("#buttonDiv").show();
                    } else {
                        $("#buttonDiv").hide();
                    }

                }
            });
        }

        var doModify = function (openerData) {
            var imsiForm = $("<form method='POST'>").attr("action", "/paragon/bbs/bbsWrite.popup");
            //imsiForm.append($("<input type='hidden' name='bbsUid'>").val(openerData.bbsUid));
            imsiForm.append($("<input type='hidden' name='_csrf'>").val($("meta[name='_csrf']").attr("content")));
            imsiForm.append($("<input type='hidden' name='openerData'>").val(JSON.stringify(openerData)));
            paragonCmm.openWindow("", "1000", "600", "POPUP_WRITE", "yes", "yes", "");
            imsiForm.attr("target", "POPUP_WRITE");
            imsiForm.appendTo("body");
            imsiForm.submit();
            imsiForm.remove();

        };

        var doDelete = function (openerData) {
            var data = {};
            data.bbsUid = openerData.bbsUid

            paragonCmm.callAjax("/paragon/bbs/bbsMas/delete/json", data, function (json) {
                alert("처리되었습니다.");
                window.opener.BBSLIST.doSearch();
            });
            window.close();
        };
        var attchmentEvent = function () {
            //수정
            $("#btnModify").on("click", function () {
                confirm(paragonCmm.getLang("M.ALERT_SUBMIT", "L.수정"), function (r) {
                    if (r) {
                        doModify(openerData);
                        //window.close();
                    }
                })
            });
            //삭제
            $("#btnDelete").on("click", function () {
                confirm(paragonCmm.getLang("M.ALERT_SUBMIT", "L.삭제"), function (r) {
                    if (r) {
                        doDelete(openerData);
                    }
                })
            });

            //오늘 창닫기
            if ($("#showCheck").prop("checked")) {
                paragonCmm.setCookie(seq, "ok", 1);
                window.close();
            }
        }
        //-- 첨부파일 Form 로드
        var loadForm = function () {

            var options = {}

            options.relUid = $bbsUid;        //-- 관례 키 UID
            options.fileTpCd = "CMM/BBS";    //-- 파일 유형 코드
            options.defaultRelUid = "";        //-- 기본 로드 첨부파일(수정시)
            htmlUtils.loadFileView("bbsFile", options);    //-- 첨부파일 로드

        }
        var init = function () {
            attchmentEvent();
            loadForm();
            loadData();                    //-- 초기 데이터 및 설정
        }
        return {
            init: init
        }
    }
    var BbsMasView = new BbsMasView();
    $(function () {
        BbsMasView.init();
    })

</script>