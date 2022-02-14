<%--
  - Author(s): Yang, Ki Hwa
  - Date: 2021-03-16(016)
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
  -     모듈 정보 다이얼로그
  --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/tiles/include/includeTagLibs.jsp"%>
<form id="moduleMngPop1Frm0" name="moduleMngPop1Frm0" data-opener-data="<c:out value='${param.openerData}'/>">
    <input type="hidden" name="cud" value="C"/>
    <table class="basic">
        <colgroup>
            <col style="width:20%;"/>
            <col style="width:30%;"/>
            <col style="width:20%;"/>
            <col style="width:30%;"/>
        </colgroup>
        <tr>
            <th class="i18n" data-term="L.아이디"></th>
            <td colspan="3">
                <input type="text" name="moduleId" minlength="7" maxlength="50" class="w-100 form-control">
            </td>
        </tr>
        <tr>
            <th class="i18n" data-term="L.설명"></th>
            <td colspan="3">
                <input type="text" name="moduleDesc" minlength="7" maxlength="1000" class="w-100 form-control">
            </td>
        </tr>
        <tr>
            <th class="i18n" data-term="L.사용여부"></th>
            <td colspan="3">
                <select id="moduleMngPop1Select1" name="useYn" class="w-100 form-control"></select>
            </td>
        </tr>
    </table>
    <div class="clearfix p-2 buttonlist" style="padding: 2px;">
        <div class="right">
            <button type="button" id="moduleMngPop1DeleteBtn1" class="btn btn-light btn-sm i18n hidden" data-term="L.삭제"><i class="fa fa-minus"></i> </button>
            <button type="button" id="moduleMngPop1CloseBtn1" class="btn btn-default btn-sm i18n" data-term="L.닫기"><i class="fa fa-window-close"></i> </button>
            <button type="button" id="moduleMngPop1SaveBtn1" class="btn btn-primary btn-sm i18n" data-term="L.저장"><i class="fa fa-save"></i> </button>
        </div>
    </div>
</form>
<script src="<c:url value='/js/module/viself/module/moduleDialog.js'/>"></script>
<script type="text/javascript">
    $(document).ready(function(){
        "use strict";
        var moduleDialog = new ModuleDialog();
        moduleDialog.init();
    });
</script>