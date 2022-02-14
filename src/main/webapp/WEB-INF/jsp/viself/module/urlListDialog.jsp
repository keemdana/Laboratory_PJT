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
  -     URL 검색/선택용 다이얼로그
  --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/tiles/include/includeTagLibs.jsp"%>
<form id="moduleMngPop2Frm0" name="moduleMngPop2Frm0" data-opener-data="<c:out value='${param.openerData}'/>">
    <input type="hidden" name="cud" value="C"/>
    <div id="moduleMngPop2List1"></div>
    <div class="clearfix p-2 buttonlist" style="padding: 2px;">
        <div class="datatable-btns right">
            <button type="button" id="moduleMngPop2CloseBtn1" class="btn btn-default btn-sm i18n" data-term="L.닫기"><i class="fa fa-window-close"></i> </button>
            <button type="button" id="moduleMngPop2ConfirmBtn1" class="btn btn-primary btn-sm i18n" data-term="L.추가"><i class="fa fa-save"></i> </button>
        </div>
    </div>
</form>
<script src="<c:url value='/js/module/viself/module/urlListDialog.js'/>"></script>
<script type="text/javascript">
    $(document).ready(function(){
        "use strict";
        var urlListDialog = new UrlListDialog();
        urlListDialog.init();
    });
</script>