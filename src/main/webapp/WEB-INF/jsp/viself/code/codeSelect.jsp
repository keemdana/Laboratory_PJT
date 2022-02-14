<%@page import="com.vertexid.commons.utils.StringUtil"%>
<%@page import="com.vertexid.commons.utils.HtmlUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	//-- 로그인 사용자 정보 셋팅
// 	SysLoginModel loginUser 	=     (SysLoginModel) SessionUtils.getLoginVO();
	String siteLocale			= "KO";
	String sel_uuid_path		= "";
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

<style>
	.content{
		font-size : 0.85em;
	}
</style>
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
								<span class="ui_btn medium icon" id="cdSearchBtn"><i class="fa fa-search"><a href="javascript:void(0)" data-term="B.SEARCH"></a></i></span>
							</td>
						</tr>
					</table>
				</div>
				</form>
				<br>
<!-- // 코드 정보 트리 // -->
<%-- 			<iframe name="iframeCodeTreeList" frameborder="0" width="480" height="580" scrolling="no" src="<%=iframeCodeTreeListSrc.toString()%>"></iframe> --%>
			<div id="treeCodeArea" class="treeCodeArea" style="height:300px;"></div>
		</td>
		<td></td>
		<td valign="top">
			<table class="basic">
				<caption data-term="B.SELECT"></caption>
				<tr>
					<td>
						<div class="table_cover_no_margin" style="height:346px;">
							<table class="list" style="width:98%">
								<colgroup>
									<col style="width:8%" />
									<col style="width:*" />
									<col style="width:60px;" />
								</colgroup>
								<thead>
								<tr>
									<th><input type="checkbox" name="chkSignListAll" id="chkSignListAll" /></th>
									<th data-term="L.코드"></th>
									<th>
										<span class="ui_btn small icon" id="selCdDelete"><i class="fa fa-minus"><a href="javascript:void(0)" data-term="L.삭제"></a></i></span>
									</th>
								</tr>
								</thead>
								<tbody id="tbodyCodeList">
								</tbody>
							</table>
						</div>
					</td>
				</tr>
				</tbody>
			</table>
		</td>
	</tr>
	</table>
	<div class="buttonlist">
	<div class="right">
		<span class="ui_btn medium icon"><i class="fa fa-check" onclick="CODE.doConfirm();"><a href="javascript:void(0)" data-term="L.확인" ></a></i></span>
	</div>
	</div>
<script type="text/javascript">
	function Code() {
		var opt = {
					"multiSelect":"Y", 			// 다중선택여부
					"selectType":"CHILD_ONLY",	// 최하위자식만 선택가능 null 값이면 부모도 선택 가능
					"parentCd":"ROOT"				// 최초 부모 코드
		};

	    var drawTree = function(){
			var arrDEPTH = [];
// 			if($("#sel_uuid_path").val() != ""){
// 				arrDEPTH = $("#sel_uuid_path").val().split("≫");
// 			}
			//tree 불러오 air-action, air-mode 값 셋팅
			treeInitSet("/viself/code/codeMng/listCode/json","CODE",JSON.stringify(arrDEPTH),opt.selectType);

			//그려넣을 id, 루트id, 최종
		    treeDrawChild("treeCodeArea",opt.parentCd);
		}
	    var chkUserId = function(json){
			var data = JSON.parse(json);
			var arrObj = $("input:hidden[name='cd']","#tbodyCodeList");
			var rtnBool = true;
			arrObj.each(function(i, d){
				if(data.cd == $(d).val()){
					rtnBool = false;
 				}
			});

			return rtnBool;

		}
	    var changeCodeView = function(json) {
	    	//-- 이미 선택된 사용자인지 여부 체크!
	    	if(chkUserId(json)){
	    		var data = JSON.parse(json);
	    		 if("N" == opt.multiSelect){
	    			 $("#tbodyCodeList").html("");
	    		 }
	    		$("#addCodeTmpl").tmpl(data).appendTo("#tbodyCodeList");
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
	    var doSearch = function(isCheckEnter){
	    	if (isCheckEnter && event.keyCode != 13) {
				return;
			}
			if($("#schValue").val() != ""){
				$("#treeCodeArea").html("");
				var query = paragonCmm.getSearchQueryParams(document.schForm);
				query.parentCd = opt.parentCd;
				treeDrawChild("treeCodeArea",opt.parentCd, query);
			}else{
				$("#treeCodeArea").html("");
				treeDrawChild("treeCodeArea",opt.parentCd,"");
			}
	    }
	    var doConfirm =  function() {
			 var aprv = $("[data-meaning='code_tr']");
			 if(aprv.length == 0){
				 alert(paragonCmm.getLang("M.선택해주세요","L.코드"));
				 return;
			 }
			var json = [];
			aprv.each(function(i,e){
				var trTag = $(e);
				var obj = trTag.find("input:hidden");

				var jsonData = {};
				$(obj).each(function(i, d){
		 			jsonData[$(d).attr("name")] = $(d).val();
		 		});
				json.push(jsonData);
			});

			var callbackFunction = $("#callbackFunction").val();

			if(typeof callBackFunc === "function"){
				callBackFunc(json);
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
	    	$("#chkSignListAll").off();
	    	$("#chkSignListAll").on("click", function(){
	    		var bool = $(this).prop("checked");
	    		$("input:checkbox[name='chkSignList']").prop("checked", bool);
	    	});
	    	$("#selCdDelete").off();
	    	$("#selCdDelete").on("click", function(){
	    		$("input:checkbox[name='chkSignList']:checked").each(function(i, e){
	    			$("#"+$(this).val()).remove();
	    		});
	    	});
	    }
	    var callBackFunc;
	    var init = function (initFunc, callFunc) {
	    	attchmentEvent();
			if(typeof initFunc === "function"){
				$.extend(opt,initFunc());
			}
			if(typeof callFunc === "function"){
				callBackFunc = callFunc;
			}
			drawTree();
	    };
	    return{
	    	init : init,
	    	selectNode:selectNode,
	    	doConfirm : doConfirm
	    }
	}
	var CODE = new Code();
// 	CODE.init();
</script>
<script id="addCodeTmpl" type="text/x-jquery-tmpl">
<tr data-meaning="code_tr" id="sel_\${cd}">
	<td align="center">
		<input type="checkbox"  value="sel_\${cd}" name="chkSignList" >
	</td>
	<td style="text-align:center" colspan="2">
		\${paragonCmm.getLang(langCd)}
		<input type="hidden" name="cd"	        value="\${cd}">
		<input type="hidden" name="cdAbb"	        value="\${cdAbb}">
		<input type="hidden" name="ordNo"		    value="\${ordNo}">
		<input type="hidden" name="langCd"	        value="\${langCd}">
		<input type="hidden" name="parentCd"	    value="\${parentCd}">
		<input type="hidden" name="parentLangCd"	value="\${parentLangCd}">
		<input type="hidden" name="levelNo"	    value="\${levelNo}">
		<input type="hidden" name="childCnt"	    value="\${childCnt}">
		<input type="hidden" name="cdPath"	    	value="\${cdPath}">
		<input type="hidden" name="langCdPath"	value="\${langCdPath}">
		<input type="hidden" name="cdAttr1"	    value="\${cdAttr1}">
		<input type="hidden" name="cdAttr2"	    value="\${cdAttr2}">
		<input type="hidden" name="cdAttr3"	    value="\${cdAttr3}">
		<input type="hidden" name="cdAttr4"	    value="\${cdAttr4}">
		<input type="hidden" name="cdData"	    	value="\${cdData}">
		<input type="hidden" name="useYn"	    value="\${useYn}">
		<input type="hidden" name="attrDesc1"	value="\${attrDesc1}">
		<input type="hidden" name="attrDesc2"	value="\${attrDesc2}">
		<input type="hidden" name="attrDesc3"	value="\${attrDesc3}">
		<input type="hidden" name="attrDesc4"	value="\${AttrDesc4}">
	</td>
</tr>
</script>