<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.vertexid.viself.base.SystemPropertiesVO"%>
<%@page import="org.springframework.beans.factory.annotation.Value"%>
<%@page import="com.vertexid.commons.utils.StringUtil"%>
<%@page import="com.vertexid.commons.utils.HtmlUtil"%>
<%@page import="com.vertexid.viself.base.ModelAttribute"%>
<%@page import="com.vertexid.commons.utils.ParamMap"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String siteLocale			= "KO";
	String schFieldCodestr 		= "LANG_CD|코드명^CD|코드";

%>
<div class="row mt">

	<h5 class="sub1_title" data-term="L.코드관리"><i class="fa fa-file-text"></i> </h5>
	<div class="col-md-12 col-sm-12">
		<div class="white-panel pn-sub1-top donut-chart">
			<div class="white-header">
				<!-- Search AREA -->
                <div class="row sub1_search">
					<form id="codeMngSchForm" method="post">
                	<div class="col-md-10">
                		<div class="row">
                			<div class="col-md-6 col-sd-6">
                				<span data-tp="th" data-term="L.구분"></span>
                                <%=HtmlUtil.getSelect( true, "schField", "codeMngSchField", schFieldCodestr, "", "class=\"form-control\" data-type=\"search\"")%>
                			</div>
                			<div class="col-md-6 col-sd-6">
                				<span data-tp="th" data-term="L.명칭"></span>
                				<input type="text" name="schValue" id="codeMngSchValue" value="" class="form-control" data-type="search"/>
                			</div>
                		</div>
                	</div>
                	<div class="col-md-2">
                    	<button type="button" class="btn btn-primary sear_st" id="cdSearchBtn" data-term="B.SEARCH"><i class="fa fa-search"></i> </button>
                    </div>
              		</form>
                </div>
			</div>
		</div>

		<div class="row sear_mt">
  			<div class="col-md-6 col-sd-6">
  				<h6 class="sub2_title"><i class="fa fa-caret-square-o-right"></i> 코드트리</h6>
  				<div class="white-panel" style="text-align: left;">					
	    			<div id="codeTreeArea" class="treeCodeArea"></div>
  				</div>
  			</div>
  			
			<div class="col-md-6 col-sm-6" >
				<h6 class="sub2_title"><i class="fa fa-caret-square-o-right"></i> 선택코드</h6>
				<div class="white-panel pn-sub1-table donut-chart">			
					<form name="codeMngform1" id="codeMngform1" method="post">
					<input type="hidden" name="parentCd" />
					<input type="hidden" name="cd" />					
					<table class="basic">
						<caption><i class="fa fa-angle-right" id="content_header"></i><span id="txtNamePath"></span></caption>
						<colgroup>
							<col width="20%" />
							<col width="30%" />
							<col width="20%" />
							<col width="30%" />
						</colgroup>
						<tr height = "51px">
							<th class="th4">코드</th>
							<td class="td4" colspan="3"><span id="txtCd" class = "content"></span> <input type="hidden" name="selCdPath" id="selCdPath" value='<c:out value="${param.selCdPath}" />' /></td>
						</tr>
						<tr height = "51px">
							<th class="th4">코드 약어</th>
							<td class="td4" colspan="3"><span id="txtCdAbb" class = "content"></span></td>
						</tr>
						<tr height = "51px">
							<th class="th4">다국어코드</th>
							<td class="td4"><span id="txtLangCd" class = "content"></span></td>
							<th class="th4">다국어 명칭</th>
							<td class="td4"><span id="txtCdNm" class = "content"></span></td>
						</tr>
						<tr height = "51px">
							<th class="th4">코드Data</th>
							<td class="td4" colspan="3"><span id="txtCodeData" class = "content"></span></td>
						</tr>
						<tr height = "51px">
							<th class="th4">코드상태</th>
							<td class="td4" colspan="3"><span id="txtStatusName" class = "content"></span></td>
						</tr>
						<tr height = "51px">
							<th class="th4">정렬순서</th>
							<td class="td4" colspan="3"><span id="txtOrderNo" class = "content"></span></td>
						</tr>
						<tr height = "51px">
							<th class="th4">코드속성값1</th>
							<td class="td4"><span id="txtCodeAttr1" class = "content"></span></td>
							<th class="th4">코드속성값2</th>
							<td class="td4"><span id="txtCodeAttr2" class = "content"></span></td>
						</tr>
						<tr height = "51px">
							<th class="th4">코드속성값3</th>
							<td class="td4"><span id="txtCodeAttr3" class = "content"></span></td>
							<th class="th4">코드속성값4</th>
							<td class="td4"><span id="txtCodeAttr4" class = "content"></span></td>
						</tr>
						<tr height = "51px">
							<th class="th4">코드속성값 설명1</th>
							<td class="td4"><span id="txtCodeAttr1Desc" class = "content"></span></td>
							<th class="th4">코드속성값 설명2</th>
							<td class="td4"><span id="txtCodeAttr2Desc" class = "content"></span></td>
						</tr>
						<tr height = "51px">
							<th class="th4">코드속성값 설명3</th>
							<td class="td4"><span id="txtCodeAttr3Desc" class = "content"></span></td>
							<th class="th4">코드속성값 설명4</th>
							<td class="td4"><span id="txtCodeAttr4Desc" class = "content"></span></td>
						</tr>
					</table>
		<%-- 버튼 목록 --%>
					<div class="buttonlist" style="text-align: left;">
						<button type="button" class="btn btn-default" id="codeMngBtnWrite" ><i class="fa fa-pencil"></i> 1레벨수정</button>
						<button type="button" class="btn btn-default" id="codeMngBtnModify" style="display:none;" data-term="B.MODIFY"><i class="fa fa-edit"></i> </button>
						<button type="button" class="btn btn-default" id="codeMngBtnModify_child" style="display:none;"><i class="fa fa-edit"></i> 하위코드수정</button>
						<button type="button" class="btn btn-default" id="codeMngBtnDelete" style="display:none;" data-term="B.DELETE"><i class="fa fa-minus"></i> </button>
		<!--
						<span class="ui_btn medium icon" id="codeMngBtnWrite"><i class="fa fa-pencil" onclick=""><a href="javascript:void(0)" >1레벨수정</a></i></span>
						<span class="ui_btn medium icon" id="codeMngBtnModify" style="display:none;"><i class="fa fa-edit" onclick=""><a href="javascript:void(0)" data-term="B.MODIFY" data-term="B.MODIFY"></a></i></span>
						<span class="ui_btn medium icon" id="codeMngBtnModify_child" style="display:none;" ><i class="fa fa-edit" onclick=""><a href="javascript:void(0)" >하위코드수정</a></i></span>
						<span class="ui_btn medium icon" id="codeMngBtnDelete" style="display:none;" ><i class="fa fa-minus" onclick=""><a href="javascript:void(0)" data-term="B.DELETE" data-term="B.DELETE"></a></i></span>
						 -->
					</div>
					</form>
				</div>
			</div>	
		
  		</div>
	</div>
</div>


<%--
<div class="content-panel p-3 site-min-height">
    <h3><i class="fa fa-angle-right" id="content_header" data-term="L.코드관리"> </i></h3>
    <div>
	<table class="none">
	<colgroup>
		<col width="48%" />
		<col width="4%" />
		<col width="48%" />
	</colgroup>
	<tr>
		<td valign="top">
			<form name="codeMngSchForm" id="codeMngSchForm" method="post" onSubmit="return false;">
				<table class="box">
		                <tr>
		                    <td class="corner_lt"></td>
		                    <td class="border_mt"></td>
		                    <td class="corner_rt"></td>
		                </tr>
		                <tr>
		                    <td class="border_lm"></td>
		                    <td class="body">
		                        <table>
		                            <colgroup>
		                                <col style="width:20%" />
		                                <col style="width:auto" />
		                                <col style="width:15%" />
		                            </colgroup>
		                            <tr>
		                                <td style="text-align: center;"><%=HtmlUtil.getSelect( true, "schField", "codeMngSchField", schFieldCodestr, "", "class=\"select\" data-type=\"search\" style=\"width:100px\"")%></td>
		                                <td>
		                                	<input type="text" name="schValue" id="codeMngSchValue" value="" data-type="search"  class="text width_max" />
		                                </td>
		                                <td style="text-align:center;">
		                                    <span class="ui_btn medium icon" id="cdSearchBtn"><i class="fa fa-search" ><a href="javascript:void(0)" data-term="B.SEARCH"></a></i></span>
		                                </td>
		                            </tr>
		                        </table>
		                    </td>
		                    <td class="border_rm"></td>
		                </tr>
		                <tr>
		                    <td class="corner_lb"></td>
		                    <td class="border_mb"></td>
		                    <td class="corner_rb"></td>
		                </tr>
		            </table>
		    </form>
<!-- // 코드 정보 트리 // -->
			<div id="codeTreeArea" class="treeCodeArea"></div>
		</td>
		<td></td>
		<td valign="top">
		<form name="codeMngform1" id="codeMngform1" method="post">
			<input type="hidden" name="parentCd" />
			<input type="hidden" name="cd" />
			<div class="table_cover">
			<table class="basic">
				<caption><span id="txtNamePath"></span></caption>
				<colgroup>
					<col width="20%" />
					<col width="30%" />
					<col width="20%" />
					<col width="30%" />
				</colgroup>
				<tr height = "51px">
					<th>코드</th>
					<td colspan="3"><span id="txtCd" class = "content"></span> <input type="hidden" name="selCdPath" id="selCdPath" value='<c:out value="${param.selCdPath}" />' /></td>
				</tr>
				<tr height = "51px">
					<th>코드 약어</th>
					<td colspan="3"><span id="txtCdAbb" class = "content"></span></td>
				</tr>
				<tr height = "51px">
					<th>다국어코드</th>
					<td><span id="txtLangCd" class = "content"></span></td>
					<th>다국어 명칭</th>
					<td><span id="txtCdNm" class = "content"></span></td>
				</tr>
				<tr height = "51px">
					<th>코드Data</th>
					<td colspan="3"><span id="txtCodeData" class = "content"></span></td>
				</tr>
				<tr height = "51px">
					<th>코드상태</th>
					<td colspan="3"><span id="txtStatusName" class = "content"></span></td>
				</tr>
				<tr height = "51px">
					<th>정렬순서</th>
					<td colspan="3"><span id="txtOrderNo" class = "content"></span></td>
				</tr>
				<tr height = "51px">
					<th>코드속성값1</th>
					<td><span id="txtCodeAttr1" class = "content"></span></td>
					<th>코드속성값2</th>
					<td><span id="txtCodeAttr2" class = "content"></span></td>
				</tr>
				<tr height = "51px">
					<th>코드속성값3</th>
					<td><span id="txtCodeAttr3" class = "content"></span></td>
					<th>코드속성값4</th>
					<td><span id="txtCodeAttr4" class = "content"></span></td>
				</tr>
				<tr height = "51px">
					<th>코드속성값 설명1</th>
					<td><span id="txtCodeAttr1Desc" class = "content"></span></td>
					<th>코드속성값 설명2</th>
					<td><span id="txtCodeAttr2Desc" class = "content"></span></td>
				</tr>
				<tr height = "51px">
					<th>코드속성값 설명3</th>
					<td><span id="txtCodeAttr3Desc" class = "content"></span></td>
					<th>코드속성값 설명4</th>
					<td><span id="txtCodeAttr4Desc" class = "content"></span></td>
				</tr>
			</table>
			</div>

버튼 목록
			<div class="buttonlist">
				<span class="ui_btn medium icon" id="codeMngBtnWrite"><i class="fa fa-pencil" onclick=""><a href="javascript:void(0)" >1레벨수정</a></i></span>
				<span class="ui_btn medium icon" id="codeMngBtnModify" style="display:none;"><i class="fa fa-edit" onclick=""><a href="javascript:void(0)" data-term="B.MODIFY" data-term="B.MODIFY"></a></i></span>
				<span class="ui_btn medium icon" id="codeMngBtnModify_child" style="display:none;" ><i class="fa fa-edit" onclick=""><a href="javascript:void(0)" >하위코드수정</a></i></span>
				<span class="ui_btn medium icon" id="codeMngBtnDelete" style="display:none;" ><i class="fa fa-minus" onclick=""><a href="javascript:void(0)" data-term="B.DELETE" data-term="B.DELETE"></a></i></span>
			</div>
			</form>
		</td>
	</tr>
	</table>
	</div>
</div>
--%>
<div id="codeMngPop1" class="hidden"></div>
<script src="<c:url value='/js/module/viself/code/codeMng.js'/>"></script>