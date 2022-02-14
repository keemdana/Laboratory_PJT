<%--
  - Author(s): Yang, Ki Hwa
  - Date: 2021-03-15(015)
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
  -     URL 정보 Dialog
  --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/tiles/include/includeTagLibs.jsp"%>
<form id="urlMngPop1Frm0" name="urlMngPop1Frm0">
    <input type="hidden" name="cud" value="C"/>
    <table class="w-100 h-100">
        <colgroup>
            <col width="20%"/>
            <col width="30%"/>
            <col width="20%"/>
            <col width="30%"/>
        </colgroup>
        <tr>
            <th class="i18n" data-i18n="WRD.URL">WRD.URL</th>
            <td>
                <input type="text" name="accesUrl" minlength="7" maxlength="500" class="w-100">
            </td>
        </tr>
        <tr>
            <th class="i18n" data-i18n="WRD.설명">WRD.설명</th>
            <td>
                <input type="text" name="urlDesc" minlength="7" maxlength="1000" class="w-100">
            </td>
        </tr>
        <tr>
            <th class="i18n" data-i18n="WRD.유형">WRD.유형</th>
            <td>
                <select id="urlMngPop1Select1" name="alwDiv" class="w-100"></select>
            </td>
        </tr>
        <tr>
            <th class="i18n" data-i18n="WRD.사용여부">WRD.사용여부</th>
            <td>
                <select id="urlMngPop1Select2" name="useEnable" class="w-100"></select>
            </td>
        </tr>
    </table>
    <div class="clearfix p-2">
        <div class="datatable-btns float-right">
            <button type="button" id="urlMngPop1SaveBtn1" class="btn btn-theme02 btn-sm i18n" data-i18n="WRD.저장"><i class="fa fa-save"></i> WRD.저장</button>
            <button type="button" id="urlMngPop1DeleteBtn1" class="btn btn-theme04 btn-sm i18n hidden" data-i18n="WRD.삭제"><i class="fa fa-minus"></i> WRD.삭제</button>
            <button type="button" id="urlMngPop1CloseBtn1" class="btn btn-theme btn-sm i18n" data-i18n="WRD.닫기"><i class="fa fa-window-close"></i> WRD.닫기</button>
        </div>
    </div>
</form>
<script src="<c:url value='/js/module/viself/auth/urlDialog.js'/>"></script>