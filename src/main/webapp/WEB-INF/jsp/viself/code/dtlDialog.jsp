<%--
  - Author(s): Yang, Ki Hwa
  - Date: 2020-09-21(021)
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
  -
  --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/tiles/include/includeTagLibs.jsp"%>
<form id="${module}Pop2Frm0" name="${module}Pop2Frm0">
    <input type="hidden">
    <table class="w-100 h-100">
        <colgroup>
            <col width="20%"/>
            <col width="30%"/>
            <col width="20%"/>
            <col width="30%"/>
        </colgroup>
        <tr>
            <th class="i18n" data-i18n="WRD.유형아이디">WRD.유형아이디</th>
            <td>
                <input type="text" name="tpId" minlength="7" maxlength="20" readonly>
            </td>
            <th class="i18n" data-i18n="WRD.유형이름">WRD.유형이름</th>
            <td>
                <input type="text" name="tpNm" minlength="7" maxlength="20" readonly>
            </td>
        </tr>
        <tr>
            <th class="i18n" data-i18n="WRD.코드">WRD.코드</th>
            <td>
                <input type="text" name="cd" minlength="7" maxlength="20">
                <input type="hidden" name="cud" value="C"/>
            </td>
            <th class="i18n" data-i18n="WRD.이름">WRD.이름</th>
            <td>
                <input type="text" name="cdNm" minlength="7" maxlength="20">
            </td>
        </tr>
        <tr>
            <th class="i18n" data-i18n="WRD.정렬순번">WRD.정렬순번</th>
            <td>
                <input type="text" name="sortOrd" minlength="7" maxlength="20">
            </td>
            <th class="i18n" data-i18n="WRD.사용여부">WRD.사용여부</th>
            <td><select id="${module}Pop2Select1" name="useEnable" class="w-100"></select></td>
        </tr>
        <tr>
            <th class="i18n" data-i18n="WRD.부모코드">WRD.부모코드</th>
            <td colspan="3">
                <input type="text" name="parentCd" minlength="7" maxlength="20" class="w-100">
            </td>
        </tr>
        <tr>
            <th class="i18n" data-i18n="WRD.비고">WRD.비고</th>
            <td colspan="3">
                <input type="text" name="remark" minlength="7" maxlength="20" class="w-100">
            </td>
        </tr>
    </table>
    <div class="clearfix p-2">
        <div class="datatable-btns float-right">
            <button type="button" id="${module}Pop2SaveBtn1" class="btn btn-info btn-sm i18n" data-i18n="WRD.저장"><i class="fa fa-save"></i> WRD.저장</button>
            <button type="button" id="${module}Pop2DeleteBtn1" class="btn btn-sm i18n hidden" data-i18n="WRD.삭제"><i class="fa fa-minus"></i> WRD.삭제</button>
            <button type="button" id="${module}Pop2CloseBtn1" class="btn btn-info btn-sm i18n" data-i18n="WRD.닫기"><i class="fa fa-window-close"></i> WRD.닫기</button>
        </div>
    </div>
</form>