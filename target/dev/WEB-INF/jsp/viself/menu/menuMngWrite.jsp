<%@page import="com.vertexid.commons.utils.HtmlUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.vertexid.commons.utils.CommonConstants"%>
<%@page import="com.vertexid.viself.hr.SysLoginVO"%>
<%@ page import="com.vertexid.spring.utils.SessionUtils" %>
<%@ page import="com.vertexid.viself.hr.SysLoginVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 자동 완성 기능을 위한 js 로드 -->
<%-- <script type="text/javascript" src="<c:url value='/js/vendor/jquery-ui/jquery-ui.js'/>"></script> --%>
<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/js/vendor/jquery-ui/themes/base/jquery-ui.css'/>" /> --%>
<%
	//-- 로그인 사용자 정보 셋팅
	SysLoginVO loginUser = (SysLoginVO) SessionUtils.getLoginVO();
	String siteLocale			= loginUser.getSiteLocale();
%>
<script id="TMPL_MENU_WIRTE" type="text/x-jquery-tmpl">
	<tr align="center" data-meaning="\${ordNo}" class="menuRow">
		<td>\${ordNo}</td>
		<td>
			<input type="text" name="menuId" id="menuId_\${ordNo}"  class="text" value="\${menuId}" style="width:80%" onfocus="this.select();" onblur="paragonCmm.validateSpecialChars(this);" />
		</td>
		<td>
			<input type="text" name="langCd"  class="autoLangCd" value="\${langCd}" />
		</td>
		<td><input type="text" name="moduleId" readonly="readonly"  class="text width_max" value="\${moduleId}" data-index="\${ordNo}" /></td>
		<td><input type="text" name="jsonData"  class="text width_max" value="\${jsonData}" /></td>
		<td>
			<select name="useYn" >
				<option value="1" title="" {{if useYn == "1"}}selected{{/if}}>정상</option>
				<option value="0" title="" {{if useYn == "0"}}selected{{/if}}>폐기</option>
				<option value="2" title="" {{if useYn == "2"}}selected{{/if}}>숨김</option>
			</select>
		</td>
		<td align="center">
			<span class="ui_btn small icon"><i class="fa fa-minus" onclick="MENUWRITE.removeCodLine('\${ordNo}','\${childCnt}',\${authCnt});"><a href="javascript:void(0)" > </a></i></span>
			<input type="hidden" name="cud" id="cud_\${ordNo}" value="\${cud}"/>
        </td>
	</tr>
</script>
<div class="row mt">
	<h5 class="sub1_title" data-term="L.시스템메뉴관리"><i class="fa fa-file-text"></i> </h5>
	<div class="col-md-12 col-sm-12">
		<div class="white-panel pn-sub1-top donut-chart">
			<div class="white-header">
				<form name="menuMngWriteform1" id="menuMngWriteform1" method="post">
				<input type="hidden" name="updateMode" id="updateMode" value='<c:out value="${param.updateMode}" />' />
				<input type="hidden" name="reqMenuId" id="reqMenuId" value="<c:out value='${param.menuId}'/>" />
				<input type="hidden" name="reqParentMenuId" id="reqParentMenuId" value="<c:out value='${param.parentMenuId}'/>" />
				<input type="hidden" name="sel_uuid_path" id="sel_uuid_path" value='<c:out value="${param.sel_uuid_path}" />' />
				<div class="row sub1_search">
                	<div class="col-md-11">
                		<div class="row">
                			<div class="col-md-12 col-sd-12">
                				<span data-tp="th" data-term="L.상위메뉴"></span>
                                <input type="text" name="parentMenuId" id="parentMenuId" class="text" value="" />
								<br />
								<span class="info">직접 입력하세요.(※ 미입력시 현재 코드 정보를 최상위 정보로 등록)</span>
                			</div>
                		</div>
                	</div>
                </div>
				</form>
			</div>
		</div>
	</div>
</div>
<div class="row mt">
	<div class="col-md-12 col-sm-12">
		<div class="white-panel pn-sub1-table donut-chart" id="div_CODE_WRITE_LIST">
		<table class="basic">
				<colgroup>
					<col width="5%" />
					<col width="10%" />
					<col width="10%" />
					<col width="10%" />
					<col width="auto" />
					<col width="5%" />
					<col width="5%" />
				</colgroup>
				<thead>
				<tr>
					<th colspan="9"><span class="info">※정렬순서는 동일그룹 내 항목간 정렬순서를 지정할 필요가 있을 경우에만 입력합니다.</span></th>
				</tr>
				</thead>
					<tr>
						<th style="text-align:center;">정렬</th>
						<th style="text-align:center;">메뉴ID</th>
						<th style="text-align:center;">다국어코드</th>
						<th style="text-align:center;">모듈 ID</th>
						<th style="text-align:center;">Json Data</th>
						<th style="text-align:center;">상태</th>
<!-- 						<th style="text-align:center;">추가<br/>입력</th> -->
						<th style="text-align:center;">
							<span class="ui_btn small icon" id="menuListAdd"><i class="fa fa-plus"><a href="javascript:void(0)" data-term="B.ADD" ></a></i></span>
						</th>
					</tr>
				<tbody id="MENU_INPUT_LIST"></tbody>
			</table>
			<div class="buttonlist">
				<span class="ui_btn medium icon" id="menuMngWriteBtnSave"><i class="fa fa-check" ><a href="javascript:void(0)" data-term="B.SAVE"></a></i></span>
				<span class="ui_btn medium icon" id="menuMngWriteBtnList"><i class="fa fa-list-ul" ><a href="javascript:void(0)" data-term="B.LIST"></a></i></span>
			</div>
		</div>
	</div>
</div>

<%-- <div class="content-panel p-3 site-min-height">
    <h3><i class="fa fa-angle-right" id="content_header" data-term="L.시스템메뉴관리"> </i></h3>
    <div>
		<form name="menuMngWriteform1" id="menuMngWriteform1" method="post">
			<input type="hidden" name="updateMode" id="updateMode" value='<c:out value="${param.updateMode}" />' />
			<input type="hidden" name="reqMenuId" id="reqMenuId" value="<c:out value='${param.menuId}'/>" />
			<input type="hidden" name="reqParentMenuId" id="reqParentMenuId" value="<c:out value='${param.parentMenuId}'/>" />
			<input type="hidden" name="sel_uuid_path" id="sel_uuid_path" value='<c:out value="${param.sel_uuid_path}" />' />
			<div class="table_cover">
			<table class="basic">
				<tr>
					<th class="th2">상위코드</th>
					<td class="td2">
						<input type="text" name="parentMenuId" id="parentMenuId" class="text" value="" />
						<br />
						<span class="info">직접 입력하세요.(※ 미입력시 현재 코드 정보를 최상위 정보로 등록)</span>
					</td>
				</tr>
			</table>
			</div>
			<br/>
		<div id="div_MENU_WRITE_LIST" class="table_cover">

			<table class="basic">
				<colgroup>
					<col width="5%" />
					<col width="10%" />
					<col width="10%" />
					<col width="10%" />
					<col width="auto" />
					<col width="5%" />
					<col width="5%" />
				</colgroup>
				<thead>
				<tr>
					<th colspan="9"><span class="info">※정렬순서는 동일그룹 내 항목간 정렬순서를 지정할 필요가 있을 경우에만 입력합니다.</span></th>
				</tr>
				</thead>
					<tr>
						<th style="text-align:center;">정렬</th>
						<th style="text-align:center;">메뉴ID</th>
						<th style="text-align:center;">다국어코드</th>
						<th style="text-align:center;">모듈 ID</th>
						<th style="text-align:center;">Json Data</th>
						<th style="text-align:center;">상태</th>
<!-- 						<th style="text-align:center;">추가<br/>입력</th> -->
						<th style="text-align:center;">
							<span class="ui_btn small icon" id="menuListAdd"><i class="fa fa-plus"><a href="javascript:void(0)" data-term="B.ADD" ></a></i></span>
						</th>
					</tr>
				<tbody id="MENU_INPUT_LIST"></tbody>
			</table>
		</div>
		<div class="buttonlist">
				<span class="ui_btn medium icon" id="menuMngWriteBtnSave"><i class="fa fa-check" ><a href="javascript:void(0)" data-term="B.SAVE"></a></i></span>
				<span class="ui_btn medium icon" id="menuMngWriteBtnList"><i class="fa fa-list-ul" ><a href="javascript:void(0)" data-term="B.LIST"></a></i></span>
			</div>
	</form>
	</div>
</div> --%>
<script src="<c:url value='/js/module/viself/menu/menuMngWrite.js'/>"></script>
<%--// 글쓰기 작업 시 세션타임아웃 방지 처리 //--%>
