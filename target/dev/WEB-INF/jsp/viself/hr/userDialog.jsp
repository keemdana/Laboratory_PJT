<%--
  - Author(s): Yang, Ki Hwa
  - Date: 2020-10-05(005)
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
  - Description: 사용자 정보 다이얼로그
  -
  --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/tiles/include/includeTagLibs.jsp"%>
<form id="${module}Pop1Frm0" name="${module}Pop1Frm0">
    <input type="hidden" name="cud" value="C"/>
    <table class="w-100 h-100">
        <colgroup>
            <col width="20%"/>
            <col width="30%"/>
            <col width="20%"/>
            <col width="30%"/>
        </colgroup>
        <tr>
            <th class="i18n" data-i18n="WRD.아이디">WRD.아이디</th>
            <td>
                <input type="text" name="userId" minlength="7" maxlength="50" class="w-100">
            </td>
        </tr>
        <tr>
            <th class="i18n" data-i18n="WRD.이름">WRD.이름</th>
            <td>
                <input type="text" name="userNm" minlength="7" maxlength="80" class="w-100">
            </td>
        </tr>
        <tr>
            <th class="i18n" data-i18n="WRD.상태">WRD.상태</th>
            <td>
                <select id="${module}Pop1Select1" name="useEnable" class="w-100"></select>
            </td>
        </tr>
        <tr id="${module}Pop1TmpPwdTr" class="hidden">
            <th class="i18n" data-i18n="WRD.임시비밀번호">WRD.임시비밀번호</th>
            <td>
                <span>임시 비밀번호는 <b>사용자아이디!@#$1234</b> 입니다.</span>
            </td>
        </tr>
    </table>
    <div class="clearfix p-2">
        <div class="datatable-btns float-right">
            <button type="button" id="${module}Pop1SaveBtn1" class="btn btn-info btn-sm i18n" data-i18n="WRD.저장"><i class="fa fa-save"></i> WRD.저장</button>
            <button type="button" id="${module}Pop1GenTemPwdBtn1" class="btn btn-sm i18n hidden" data-i18n="WRD.임시비밀번호발행"><i class="fa fa-minus"></i> WRD.임시비밀번호발행</button>
            <button type="button" id="${module}Pop1DeleteBtn1" class="btn btn-sm i18n hidden" data-i18n="WRD.삭제"><i class="fa fa-minus"></i> WRD.삭제</button>
            <button type="button" id="${module}Pop1CloseBtn1" class="btn btn-info btn-sm i18n" data-i18n="WRD.닫기"><i class="fa fa-window-close"></i> WRD.닫기</button>
        </div>
    </div>
</form>