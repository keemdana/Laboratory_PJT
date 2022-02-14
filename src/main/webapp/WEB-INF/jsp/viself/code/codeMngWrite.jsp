<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.vertexid.viself.hr.SysLoginVO"%>
<%@ page import="com.vertexid.spring.utils.SessionUtils" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	//-- 로그인 사용자 정보 셋팅
	SysLoginVO loginUser 	=     (SysLoginVO) SessionUtils.getLoginVO();
	String siteLocale			= loginUser.getSiteLocale();

	String schFieldCodestr 		= "Y|사용^N|미사용";

%>

<script id="TMPL_CODE_WIRTE" type="text/x-jquery-tmpl">
	<tr align="center" data-meaning="\${rn}">
		<td>\${rn}</td>
		<td>
			<input type="text" name="cd" id="cd_\${rn}"  class="text" value="\${cd}" style="width:80%" onfocus="this.select();" onblur="paragonCmm.validateSpecialChars(this);" />
		</td>
		<td><input type="text" name="cdAbb"   class="text width_max" value="\${cdAbb}" onblur="paragonCmm.validateSpecialChars(this);" /></td>
		<td><input type="text" name="langCd"  class="autoLangCd_\${rn}" value="\${langCd}" onblur="paragonCmm.validateSpecialChars(this);" /></td>
		<td>
			{{html CODDWRITE.getUseYnHtml(useYn)}}
		</td>
		<td><span class="ui_btn small icon"><i class="fa fa-plus" onclick="CODDWRITE.subDataOpen('\${rn}');"><a href="javascript:void(0)" > </a></i></span></td>
		<td align="center">
			<span class="ui_btn small icon"><i class="fa fa-minus" onclick="CODDWRITE.removeCodLine('\${rn}','\${childCnt}');"><a href="javascript:void(0)" > </a></i></span>
			<input type="hidden" name="cud" id="cud_\${rn}" value="\${cud}"/>
			<input type="hidden" name="cdAttr1" id="cdAttr1_\${rn}" value="\${cdAttr1}"/>
			<input type="hidden" name="cdAttr2" id="cdAttr2_\${rn}" value="\${cdAttr2}"/>
			<input type="hidden" name="cdAttr3" id="cdAttr3_\${rn}" value="\${cdAttr3}"/>
			<input type="hidden" name="cdAttr4" id="cdAttr4_\${rn}" value="\${cdAttr4}"/>
			<input type="hidden" name="attrDesc1" id="attrDesc1_\${rn}" value="\${attrDesc1}"/>
			<input type="hidden" name="attrDesc2" id="attrDesc2_\${rn}" value="\${attrDesc2}"/>
			<input type="hidden" name="attrDesc3" id="attrDesc3_\${rn}" value="\${attrDesc3}"/>
			<input type="hidden" name="attrDesc4" id="attrDesc4_\${rn}" value="\${attrDesc4}"/>
			<input type="hidden" name="cdData" id="cdData_\${rn}" value="\${cdData}"/>
        </td>
	</tr>
</script>
<div class="row mt">
	<h5 class="sub1_title" data-term="L.코드관리"><i class="fa fa-file-text"></i> </h5>
	<div class="col-md-12 col-sm-12">
		<div class="white-panel pn-sub1-top donut-chart">
			<div class="white-header">
				<!-- Search AREA -->
			<form id="codeMngWriteForm1" name="codeMngWriteForm1" method="post">
				<input type="hidden" name="reqParentCd" id="reqParentCd" value="<c:out value='${param.parentCd}'/>" />
				<input type="hidden" name="reqCd" id="reqCd" value="<c:out value='${param.cd}'/>" />
				<input type="hidden" name="updateMode" id="updateMode" value='<c:out value="${param.updateMode}" />' />
				<input type="hidden" name="selCdPath" id="selCdPath" value='<c:out value="${param.selCdPath}" />' />

                <div class="row sub1_search">
                	<div class="col-md-11">
                		<div class="row">
                			<div class="col-md-12 col-sd-12">
                				<span data-tp="th" data-term="L.상위코드"></span>
                                <input type="text" name="parentCd" class="text" value="" readonly />
                                <button type="button" class="btn btn-default btn-xs" id="parentCodeSearchBtn" data-term="B.SELECT"><i class="fa fa-search"></i> </button>
<!-- 								<span class="ui_btn small icon" id="parentCodeSearchBtn"><i class="fa fa-search" ><a href="javascript:void(0)" data-term="B.SELECT" ></a></i></span> -->
								<br />
								<span class="info">(※ 미입력시 현재 코드 정보를 최상위 정보로 등록)</span>
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
		<div class="white-panel donut-chart" id="div_CODE_SUB_DATA" style="display:none;">
		<h6 class="sub2_title"><i class="fa fa-caret-square-o-right"></i> 세부설정</h6>
				<table class="basic">
					<colgroup>
						<col width="10%"/>
						<col width="15%"/>
						<col width="10%"/>
						<col width="15%"/>
						<col width="10%"/>
						<col width="15%"/>
						<col width="10%"/>
						<col width="15%"/>
					</colgroup>
					<tr>
						<th>코드 속성값1</th>
						<td><input type="text" name="tmpCdAttr1"  id="tmpCdAttr1" data-meaning="TMP"   class="text width_max" value="" onblur="paragonCmm.validateSpecialChars(this);" /></td>
						<th>코드 속성값2</th>
						<td><input type="text" name="tmpCdAttr2"  id="tmpCdAttr2" data-meaning="TMP"   class="text width_max" value="" onblur="paragonCmm.validateSpecialChars(this);" /></td>
						<th>코드 속성값3</th>
						<td><input type="text" name="tmpCdAttr3"  id="tmpCdAttr3" data-meaning="TMP"   class="text width_max" value="" onblur="paragonCmm.validateSpecialChars(this);" /></td>
						<th>코드 속성값4</th>
						<td><input type="text" name="tmpCdAttr4"  id="tmpCdAttr4" data-meaning="TMP"   class="text width_max" value="" onblur="paragonCmm.validateSpecialChars(this);" /></td>
					</tr>
					<tr>
						<th>설명</th>
						<td><input type="text" name="tmpCdAttrDesc1" id="tmpCdAttrDesc1" data-meaning="TMP"   class="text width_max" value="" onblur="paragonCmm.validateSpecialChars(this);" /></td>
						<th>설명</th>
						<td><input type="text" name="tmpCdAttrDesc2" id="tmpCdAttrDesc2" data-meaning="TMP"   class="text width_max" value="" onblur="paragonCmm.validateSpecialChars(this);" /></td>
						<th>설명</th>
						<td><input type="text" name="tmpCdAttrDesc3" id="tmpCdAttrDesc3" data-meaning="TMP"   class="text width_max" value="" onblur="paragonCmm.validateSpecialChars(this);" /></td>
						<th>설명</th>
						<td><input type="text" name="tmpCdAttrDesc4" id="tmpCdAttrDesc4" data-meaning="TMP"   class="text width_max" value="" onblur="paragonCmm.validateSpecialChars(this);" /></td>
					</tr>
					<tr>
						<th>코드데이터</th>
						<td colspan="7"><textarea name="tmpCdData" id="tmpCdData" class="memo" style="width:99%" data-meaning="TMP" onkeyup="paragonCmm.validateMaxLength(this, '4000');"></textarea></td>
					</tr>
				</table>
				<div class="buttonlist">
					<input type="hidden" name="tmpIndex" id="tmpIndex" data-meaning="TMP" value=""/>
					<button type="button" class="btn btn-default btn-xs" id="subInputEnd" ><i class="fa fa-check"></i> 입력완료</button>
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
					<col width="20%" />
					<col width="20%" />
					<col width="17%" />
					<col width="9%" />
					<col width="5%" />
					<col width="5%" />
					<col width="auto" />
				</colgroup>
				<thead>
				<tr>
					<th colspan="9"><span class="info">※정렬순서는  동일그룹 내 항목간 정렬순서를 지정할 필요가 있을 경우에만 입력합니다.</span></th>
				</tr>
				</thead>
					<tr>
						<th style="text-align:center;">정렬순서</th>
						<th style="text-align:center;">코드</th>
						<th style="text-align:center;">코드약어</th>
						<th style="text-align:center;">다국어코드</th>
						<th style="text-align:center;">코드상태</th>
						<th style="text-align:center;">추가<br/>입력</th>
						<th style="text-align:center;">

						<span class="ui_btn small icon" data-meaning="code_list_add"><i class="fa fa-plus"><a href="javascript:void(0)" data-term="B.ADD" ></a></i></span>

						</th>
					</tr>
				<tbody id="CODE_INPUT_LIST"></tbody>
			</table>
			<div class="buttonlist">
				<span class="ui_btn medium icon" id="codeMngWriteBtnSave"><i class="fa fa-save" ><a href="javascript:void(0)" data-term="B.SAVE"></a></i></span>
				<span class="ui_btn medium icon" id="codeMngWriteBtnClose"><i class="fa fa-list-ul" ><a href="javascript:void(0)" data-term="B.LIST"></a></i></span>
			</div>
		</div>
	</div>
</div>



<%--


<div class="content-panel p-3 site-min-height">
    <h3><i class="fa fa-angle-right" id="content_header" data-term="L.코드관리"> </i></h3>
    <div>
	<form name="codeMngWriteForm1" id="codeMngWriteForm1" method="post">
		<input type="hidden" name="reqParentCd" id="reqParentCd" value="<c:out value='${param.parentCd}'/>" />
		<input type="hidden" name="reqCd" id="reqCd" value="<c:out value='${param.cd}'/>" />
		<input type="hidden" name="updateMode" id="updateMode" value='<c:out value="${param.updateMode}" />' />
		<input type="hidden" name="selCdPath" id="selCdPath" value='<c:out value="${param.selCdPath}" />' />
		<div class="table_cover">
		<table class="basic">
			<tr>
				<th class="th2">상위코드</th>
				<td class="td2">
					<input type="text" name="parentCd" class="text" value="" readonly />
					<span class="ui_btn small icon" id="parentCodeSearchBtn"><i class="fa fa-search" ><a href="javascript:void(0)" data-term="B.SELECT" ></a></i></span>
					<br />
					<span class="info">(※ 미입력시 현재 코드 정보를 최상위 정보로 등록)</span>
				</td>
			</tr>
		</table>
		</div>
		<br/>
	<div id="div_CODE_WRITE_LIST" class="table_cover">

		<table class="basic">
			<colgroup>
				<col width="5%" />
				<col width="20%" />
				<col width="20%" />
				<col width="17%" />
				<col width="9%" />
				<col width="5%" />
				<col width="5%" />
				<col width="auto" />
			</colgroup>
			<thead>
			<tr>
				<th colspan="9"><span class="info">※정렬순서는  동일그룹 내 항목간 정렬순서를 지정할 필요가 있을 경우에만 입력합니다.</span></th>
			</tr>
			</thead>
				<tr>
					<th style="text-align:center;">정렬순서</th>
					<th style="text-align:center;">코드</th>
					<th style="text-align:center;">코드약어</th>
					<th style="text-align:center;">다국어코드</th>
					<th style="text-align:center;">코드상태</th>
					<th style="text-align:center;">추가<br/>입력</th>
					<th style="text-align:center;">

					<span class="ui_btn small icon" data-meaning="code_list_add"><i class="fa fa-plus"><a href="javascript:void(0)" data-term="B.ADD" ></a></i></span>

					</th>
				</tr>
			<tbody id="CODE_INPUT_LIST"></tbody>
		</table>
	</div>
	</form>
			<br/>
			<br/>
		<div id="div_CODE_SUB_DATA" class="table_cover" style="display:none;">
			<table class="basic">
				<colgroup>
					<col width="10%"/>
					<col width="15%"/>
					<col width="10%"/>
					<col width="15%"/>
					<col width="10%"/>
					<col width="15%"/>
					<col width="10%"/>
					<col width="15%"/>
				</colgroup>
				<tr>
					<th>코드 속성값1</th>
					<td><input type="text" name="tmpCdAttr1"  id="tmpCdAttr1" data-meaning="TMP"   class="text width_max" value="" onblur="paragonCmm.validateSpecialChars(this);" /></td>
					<th>코드 속성값2</th>
					<td><input type="text" name="tmpCdAttr2"  id="tmpCdAttr2" data-meaning="TMP"   class="text width_max" value="" onblur="paragonCmm.validateSpecialChars(this);" /></td>
					<th>코드 속성값3</th>
					<td><input type="text" name="tmpCdAttr3"  id="tmpCdAttr3" data-meaning="TMP"   class="text width_max" value="" onblur="paragonCmm.validateSpecialChars(this);" /></td>
					<th>코드 속성값4</th>
					<td><input type="text" name="tmpCdAttr4"  id="tmpCdAttr4" data-meaning="TMP"   class="text width_max" value="" onblur="paragonCmm.validateSpecialChars(this);" /></td>
				</tr>
				<tr>
					<th>설명</th>
					<td><input type="text" name="tmpCdAttrDesc1" id="tmpCdAttrDesc1" data-meaning="TMP"   class="text width_max" value="" onblur="paragonCmm.validateSpecialChars(this);" /></td>
					<th>설명</th>
					<td><input type="text" name="tmpCdAttrDesc2" id="tmpCdAttrDesc2" data-meaning="TMP"   class="text width_max" value="" onblur="paragonCmm.validateSpecialChars(this);" /></td>
					<th>설명</th>
					<td><input type="text" name="tmpCdAttrDesc3" id="tmpCdAttrDesc3" data-meaning="TMP"   class="text width_max" value="" onblur="paragonCmm.validateSpecialChars(this);" /></td>
					<th>설명</th>
					<td><input type="text" name="tmpCdAttrDesc4" id="tmpCdAttrDesc4" data-meaning="TMP"   class="text width_max" value="" onblur="paragonCmm.validateSpecialChars(this);" /></td>
				</tr>
				<tr>
					<th>코드데이터</th>
					<td colspan="7"><textarea name="tmpCdData" id="tmpCdData" class="memo" style="width:99%" data-meaning="TMP" onkeyup="paragonCmm.validateMaxLength(this, '4000');"></textarea></td>
				</tr>
			</table>
			<input type="hidden" name="tmpIndex" id="tmpIndex" data-meaning="TMP" value=""/>
			<span class="ui_btn small icon" style="float: right;" id="subInputEnd" ><span class="add"></span><a href="javascript:void(0)"  >입력완료</a></span>
		</div>

			<div class="buttonlist">
				<span class="ui_btn medium icon" id="codeMngWriteBtnSave"><i class="fa fa-check" ><a href="javascript:void(0)" data-term="B.SAVE"></a></i></span>
				<span class="ui_btn medium icon" id="codeMngWriteBtnClose"><i class="fa fa-list-ul" ><a href="javascript:void(0)" data-term="B.LIST"></a></i></span>
			</div>
		</div>
	</div>
--%>
<script src="<c:url value='/js/module/viself/code/codeMngWrite.js'/>"></script>
<%--// 글쓰기 작업 시 세션타임아웃 방지 처리 //--%>
