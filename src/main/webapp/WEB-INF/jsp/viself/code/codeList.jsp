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
	//-- 로그인 사용자 정보 셋팅
// 	SysLoginModel loginUser 	= (SysLoginModel)request.getSession().getAttribute(CommonConstants.SESSION_USER);
	String siteLocale			= "KO";
	//-- 검색값 셋팅
// 	System.out.println(request.getAttribute(ModelAttribute.REQUEST.getAttributeId()));
// 	ParamMap requestMap 		= (ParamMap)request.getAttribute(ModelAttribute.REQUEST.getAttributeId());
	//String page_no 			= requestMap.getString(CommonConstants.PAGE_NO);
	//String page_rowsize 		= requestMap.getString(CommonConstants.PAGE_ROWSIZE);

	//-- 결과값 셋팅
// 	ParamMap resultMap 			= (BeanResultMap)request.getAttribute(CommonConstants.RESULT);

	//-- 파라메터 셋팅
// 	String action_code 			= resultMap.getString(CommonConstants.ACTION_CD);
// 	String mode_code 			= resultMap.getString(CommonConstants.MODE_CD);

// 	String sel_uuid_path		= requestMap.getString("selUuidPath");
// 	String parent_uuid 			= requestMap.getString("parentUuid");

	//-- 기타값 셋팅
	String schFieldCodestr 		= "LANG_CD|코드명^CD|코드";

%>
<section class="wrapper site-min-height">
	<h3><i class="fa fa-angle-right" id="content_header" data-term="L.코드관리"> </i></h3>
	<div class="content-panel">
	<table class="none">
	<colgroup>
		<col width="48%" />
		<col width="4%" />
		<col width="48%" />
	</colgroup>
	<tr>
		<td valign="top">
			<br>
				<form name="schForm" id="schForm" method="post" onSubmit="return false;">
				<div class="table_cover">
					<table class="box">
						<colgroup>
							<col width="15%" />
							<col width="65%" />
							<col width="20%" />
						</colgroup>
						<tr>
							<th width="15%"><%=HtmlUtil.getSelect( true, "schField", "schField", schFieldCodestr, "", "class=\"select\" data-type=\"search\" style=\"width:100px\"")%></th>
							<td width="65%">
								<input type="text" name="schValue" id="schValue" value="" data-type="search"  class="text width_max" />
							</td>
							<td class="hbuttons">
								<span class="ui_btn medium icon" id="cdSearchBtn"><i class="fa fa-search" ><a href="javascript:void(0)" data-term="B.SEARCH"></a></i></span>
							</td>
						</tr>
					</table>
				</div>
				</form>
				<br>
<!-- // 코드 정보 트리 // -->
<%-- 			<iframe name="iframeCodeTreeList" frameborder="0" width="480" height="580" scrolling="no" src="<%=iframeCodeTreeListSrc.toString()%>"></iframe> --%>
			<div id="treeArea" class="treeCodeArea"></div>
		</td>
		<td></td>
		<td valign="top">
		<form name="form1" id="form1" method="post">
			<input type="hidden" name="updateMode" />
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
					<td colspan="3"><span id="txtCd" class = "content"></span> <input type="hidden" name="sel_uuid_path" id="sel_uuid_path" value='<c:out value="${param.sel_uuid_path}" />' /></td>
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

<%-- 버튼 목록 --%>
			<div class="buttonlist">
				<span class="ui_btn medium icon" id="btnWrite"><i class="fa fa-pencil" onclick=""><a href="javascript:void(0)" >1레벨수정</a></i></span>
				<span class="ui_btn medium icon" id="btnModify" style="display:none;"><i class="fa fa-edit" onclick=""><a href="javascript:void(0)" data-term="B.MODIFY" data-term="B.MODIFY"></a></i></span>
				<span class="ui_btn medium icon" id="btnModify_child" style="display:none;" ><i class="fa fa-edit" onclick=""><a href="javascript:void(0)" >하위코드수정</a></i></span>
				<span class="ui_btn medium icon" id="btnDelete" style="display:none;" ><i class="fa fa-minus" onclick=""><a href="javascript:void(0)" data-term="B.DELETE" data-term="B.DELETE"></a></i></span>
			</div>
			</form>
		</td>
	</tr>
	</table>
	</div>
</section>
<script type="text/javascript">
	function Code() {
		var opt = {
				"selectType":"",	// 최하위자식만 선택가능 null 값이면 부모도 선택 가능
				"parentCd":"ROOT"				// 최초 부모 코드
		};
	    var drawTree = function(){
			var arrDEPTH = [];
			if($("#sel_uuid_path").val() != ""){
				arrDEPTH = $("#sel_uuid_path").val().split("≫");
			}
			//tree 불러오 air-action, air-mode 값 셋팅
			treeInitSet("/viself/code/codeMng/listCode/json","CODE",JSON.stringify(arrDEPTH),'');

			//그려넣을 id, 루트id, 최종
		    treeDrawChild("treeArea",opt.parentCd);
		}
	    var changeCodeView = function(json) {
			var data = JSON.parse(json);
			document.form1.cd.value 	= data.cd;
			document.form1.parentCd.value 	= data.parentCd;

			document.getElementById("txtNamePath").innerHTML 	= paragonCmm.getLang(data.langCdPath);
			document.getElementById("txtCd").innerHTML 			= paragonCmm.convertForView(data.cd);
			document.getElementById("txtCdAbb").innerHTML 		= paragonCmm.convertForView(data.cdAbb);
			document.getElementById("txtLangCd").innerHTML 		= paragonCmm.convertForView(data.langCd);
			document.getElementById("txtCdNm").innerHTML 		= paragonCmm.getLang(data.langCd);
			document.getElementById("txtCodeAttr1").innerHTML	= paragonCmm.convertForView(data.cdAttr1);
			document.getElementById("txtCodeAttr2").innerHTML	= paragonCmm.convertForView(data.cdAttr2);
			document.getElementById("txtCodeAttr3").innerHTML	= paragonCmm.convertForView(data.cdAttr3);
			document.getElementById("txtCodeAttr4").innerHTML	= paragonCmm.convertForView(data.cdAttr4);
			document.getElementById("txtCodeAttr1Desc").innerHTML	= paragonCmm.convertForView(data.attrDesc1);
			document.getElementById("txtCodeAttr2Desc").innerHTML	= paragonCmm.convertForView(data.attrDesc2);
			document.getElementById("txtCodeAttr3Desc").innerHTML	= paragonCmm.convertForView(data.attrDesc3);
			document.getElementById("txtCodeAttr4Desc").innerHTML	= paragonCmm.convertForView(data.attrDesc4);
			document.getElementById("txtCodeData").innerHTML	= paragonCmm.convertForView(data.cdData);
			document.getElementById("txtOrderNo").innerHTML	= paragonCmm.convertForView(data.ordNo);
			document.getElementById("txtStatusName").innerHTML 	= paragonCmm.convertForView(data.useEnable);
			document.getElementById("sel_uuid_path").value 	= paragonCmm.convertForView(data.cdPath);

			//-- 시스템 전용 코드일 경우 수정/삭제 버튼 디스플레이 처리
			var btnModifyObj = document.getElementById("btnModify");
			var btnModify_childObj = document.getElementById("btnModify_child");
			var btnDeleteObj = document.getElementById("btnDelete");

			if (data.status_code == "S") {
				btnModifyObj.style.display = "";
				btnModify_childObj.style.display = "";
				btnDeleteObj.style.display = "none";
			} else {
				btnModifyObj.style.display = "";
				btnModify_childObj.style.display = "";
				btnDeleteObj.style.display = "";
			}
		}
	    var selectNode = function(code_id){

			var codGrp = $("#"+code_id);
			var obj = codGrp.children("input:hidden");
			var jsonData = "";
			$(obj).each(function(i, d){
				if(i > 0){jsonData+=",";}
				jsonData+= $(this).attr("name")+":\""+$(this).val()+"\"";
			});
			new Function("return data ={"+jsonData+"}")();
			changeCodeView(JSON.stringify(data));
	    }
	    var goModify = function(frm,updateMode) {
			if (frm.cd.value == "" && updateMode != "ONE") {
				alert(airCommon.getLang("M.ALERT_SELECT","L.수정할코드정보"));
				return;
			}
			if("ONE" == updateMode){
				updateMode = "CHILD"
				frm.cd.value = "";
			}
			var params = $(frm).serializeJSON();
			params.updateMode = updateMode;
			params.langCd = "L.코드관리";
			main.movePage("/viself/code/codeWrite.include", params);

// 			frm.updateMode.value = updateMode;
// 			frm.action = "/viself/code/codeWrite.include";
// 			frm.submit();
		}
	    var goWrite = function(frm) {
			frm.action = "/viself/code/codeWrite";
			frm.parentCd = "ROOT";
			frm.submit();
		}
	    var goDelete = function(frm) {
			if (frm.cd.value == "") {
				alert(paragonCmm.getLang("M.ALERT_SELECT", "L.삭제할코드정보"));
				return;
			}
			var msg = paragonCmm.getLang("M.ALERT_SUBMIT", "L.선택하신코드및하위코드정보를완전히삭제") ;
			confirm(msg, function(r){
				if(r){
					paragonCmm.showBackDrop();
					var params = $("#form1").serializeObject();
					$.ajax({
			            url: "/viself/code/codeMng/deleteCode/json"
		            	, type: "POST"
		            	, dataType: "json"
		                , contentType: "application/json"
			            , data: JSON.stringify(params)
					})
					.done(function(data) {

						if(data.errYn !== "E"){
							alert(paragonCmm.getLang(data.msg), function(){
					            $("#treeArea").html("");
					            drawTree();
								paragonCmm.hideBackDrop();
							});
                        }else{
                            $.messager.alert("Warning",data.msg, "warning");
                        }
					})
			        .fail(function() {
			        	alert("오류");
			            //승인처리 도중 에러가 발생했습니다.
						paragonCmm.hideBackDrop()
		<%-- 		            alert("<%=StringUtil.getScriptMessage("M.처리중오류발생관리자문의하세요",siteLocale, StringUtil.getLocaleWord("L.승인처리", siteLocale))%>"); --%>
			        });

				}
			});
		}
	    var doSearch = function(isCheckEnter){
	    	if (isCheckEnter && event.keyCode != 13) {
				return;
			}
			if($("#schValue").val() != ""){
				$("#treeArea").html("");
				var query = paragonCmm.getSearchQueryParams(document.schForm);
				query.parentCd = opt.parentCd;
				treeDrawChild("treeArea",opt.parentCd, query);
			}else{
				$("#treeArea").html("");
				treeDrawChild("treeArea",opt.parentCd,"");
			}
	    }
	    var attchmentEvent = function(){
	    	$("#schValue").off();
	    	$("#schValue").on("keyup",function(){
	    		doSearch(true);
	    	});
	    	$("#cdSearchBtn").off();
	    	$("#cdSearchBtn").on("click", function(){
	    		doSearch();
	    	});
	    	$("#btnWrite").off();
	    	$("#btnWrite").on("click", function(){
	    		goModify(document.form1,'ONE');
	    	});
	    	$("#btnModify").off();
	    	$("#btnModify").on("click", function(){
	    		goModify(document.form1,'');
	    	});
	    	$("#btnModify_child").off();
	    	$("#btnModify_child").on("click", function(){
	    		goModify(document.form1,'CHILD');
	    	});
	    	$("#btnDelete").off();
	    	$("#btnDelete").on("click", function(){
	    		goDelete(document.form1);
	    	});
	    }
		var init = function () {
			attchmentEvent();
			drawTree();
	    };
	    return{
	    	init : init,
	    	selectNode:selectNode
	    }
	}
	var CODE = new Code();
	CODE.init();
</script>