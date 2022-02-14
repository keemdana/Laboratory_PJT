<%@page import="com.vertexid.commons.utils.HtmlUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	//-- 로그인 사용자 정보 셋팅
	String schFieldCodestr 		= "LANG_CD|이름^CD|코드";
%>
<div class="row mt">
	<h5 class="sub1_title" data-term="L.시스템메뉴관리"><i class="fa fa-file-text"></i> </h5>
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
	                               <%=HtmlUtil.getSelect( true, "schField", "menuMngSchField", schFieldCodestr, "", "class=\"form-control input-sm\" data-type=\"search\"")%>
	               			</div>
	               			<div class="col-md-6 col-sd-6">
	               				<span data-tp="th" data-term="L.명칭"></span>
	               				<input type="text" name="schValue" id="codeMngSchValue" value="" class="form-control input-sm" data-type="search"/>
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
	    			<div id="menuMngTreeArea" class="treeCodeArea"></div>
  				</div>
  			</div>
			<div class="col-md-6 col-sm-6">
				<h6 class="sub2_title"><i class="fa fa-caret-square-o-right"></i> 선택메뉴</h6>
				<div class="white-panel pn-sub1-table donut-chart">					
					<form name="menuMngform1" id="menuMngform1" method="post">
					<input type="hidden" name="updateMode" id="updateMode" />
					<table class="basic">
						<caption><i class="fa fa-angle-right" id="content_header"></i><span id="txtNamePath"></span></caption>
						<colgroup>
							<col width="20%" />
							<col width="30%" />
							<col width="20%" />
							<col width="30%" />
						</colgroup>
						<tr height = "51px">
							<th class="th2">메뉴 ID</th>
							<td class="td2" colspan="3"><input type="text" id="menuId" name="menuId" class="none" readonly="readonly" style="border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;"><input type="hidden" name="menuMngUuidPath" id="menuMngUuidPath" value='<c:out value="${param.menuMngUuidPath}" />' /></td>
						</tr>
						<tr height = "51px">
							<th class="th2">부모 메뉴 ID</th>
							<td class="td2" colspan="3"><input type="text" id="parentMenuId" name="parentMenuId" class="none" readonly="readonly" style="border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;"></td>
						</tr>
						<tr height = "51px">
							<th class="th2">다국어코드</th>
							<td class="td2" colspan="3"><span id="langCd" class = "content"></span></td>
						</tr>
						<tr height = "51px">
							<th class="th2">Url Path</th>
							<td class="td2" colspan="3"><span id="urlPath" class = "content"></span></td>
						</tr>
						<tr height = "51px">
							<th class="th2">JSON_DATA</th>
							<td class="td2" colspan="3"><span id="jsonData" class = "content"></span></td>
						</tr>
						<tr height = "51px">
							<th class="th2">사용여부</th>
							<td class="td2" colspan="3">0:폐기,1:사용,2:숨김<br/><span id="useYn" class = "content"></span></td>
						</tr>
					</table>
					<div class="buttonlist" style="text-align: left;">
						<button type="button" class="btn btn-default" id="menuMnglevelOne" ><i class="fa fa-pencil"></i> 1레벨수정</button>
						<button type="button" class="btn btn-default" id="menuMngbtnModify" style="display:none;" data-term="B.MODIFY"><i class="fa fa-edit"></i> </button>
						<button type="button" class="btn btn-default" id="menuMngbtnModify_child" style="display:none;"><i class="fa fa-edit"></i> 하위코드수정</button>
					</div>
					</form>
				</div>
			</div>
  		</div>

	</div>
</div>

<%--
<div class="content-panel p-3 site-min-height">
    <h3><i class="fa fa-angle-right" id="content_header" data-term="L.시스템메뉴관리"> </i></h3>
    <div>
		<table class="none">
			<colgroup>
				<col width="48%" />
				<col width="4%" />
				<col width="48%" />
			</colgroup>
			<tr>
				<td valign="top">
						<form name="menuMngSchForm" id="menuMngSchForm" method="post" onSubmit="return false;">
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
											<col width="15%" />
											<col width="65%" />
											<col width="20%" />
										</colgroup>
										<tr>
											<td style="text-align: center;"><%=HtmlUtil.getSelect( true, "schField", "menuMngSchField", schFieldCodestr, "", "class=\"select\" data-type=\"search\" style=\"width:100px\"")%></th>
											<td width="65%">
												<input type="text" name="schValue" id="menuMngSchValue" value="" data-type="search"  class="text width_max" onkeydown="doSearch(true)" />
											</td>
											<td style="text-align:center;">
												<span class="ui_btn medium icon" id="menuSearchBtn"><i class="fa fa-search" onclick="doSearch()"><a href="javascript:void(0)" data-term="B.SEARCH"></a></i></span>
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
					<div id="menuMngTreeArea" class="treeCodeArea"></div>
				</td>
				<td></td>
				<td valign="top">
				<form name="menuMngform1" id="menuMngform1" method="post">
					<input type="hidden" name="updateMode" id="updateMode" />
					<div class="table_cover" id="detailView">
					<table class="basic">
						<caption><i class="fa fa-angle-right" id="content_header"></i><span id="txtNamePath"></span></caption>
						<colgroup>
							<col width="20%" />
							<col width="30%" />
							<col width="20%" />
							<col width="30%" />
						</colgroup>
						<tr height = "51px">
							<th>메뉴 ID</th>
							<td colspan="3"><input type="text" id="menuId" name="menuId" class="none" readonly="readonly"><input type="hidden" name="menuMngUuidPath" id="menuMngUuidPath" value='<c:out value="${param.menuMngUuidPath}" />' /></td>
						</tr>
						<tr height = "51px">
							<th>부모 메뉴 ID</th>
							<td colspan="3"><input type="text" id="parentMenuId" name="parentMenuId" class="none" readonly="readonly"></td>
						</tr>
						<tr height = "51px">
							<th>다국어코드</th>
							<td colspan="3"><span id="langCd" class = "content"></span></td>
						</tr>
						<tr height = "51px">
							<th>Url Path</th>
							<td colspan="3"><span id="urlPath" class = "content"></span></td>
						</tr>
						<tr height = "51px">
							<th>JSON_DATA</th>
							<td colspan="3"><span id="jsonData" class = "content"></span></td>
						</tr>
						<tr height = "51px">
							<th>사용여부</th>
							<td colspan="3">0:폐기,1:사용,2:숨김<br/><span id="useYn" class = "content"></span></td>
						</tr>
					</table>
					</div>

		버튼 목록
					<div class="buttonlist">
						<span class="ui_btn medium icon" id="menuMnglevelOne"  ><i class="fa fa-edit" onclick=""><a href="javascript:void(0)" >1레벨수정</a></i></span>
						<span class="ui_btn medium icon" id="menuMngbtnModify" style="display:none;" ><i class="fa fa-edit" onclick=""><a href="javascript:void(0)" data-term="B.MODIFY"></a></i></span>
						<span class="ui_btn medium icon" id="menuMngbtnModify_child" style="display:none;" ><i class="fa fa-edit" onclick=""><a href="javascript:void(0)" >하위코드수정</a></i></span>
						<span class="ui_btn medium icon" id="btnDelete" style="display:none;" onclick="goDelete(document.form1);"><i class="fa fa-minus" onclick=""><a href="javascript:void(0)"  data-term="B.DELETE"></a></i></span>
					</div>
					</form>
				</td>
			</tr>
		</table>
	</div>
</div> --%>
<div id="menuMngPop1" class="hidden"></div>
<script src="<c:url value='/js/module/viself/menu/menuMng.js'/>"></script>