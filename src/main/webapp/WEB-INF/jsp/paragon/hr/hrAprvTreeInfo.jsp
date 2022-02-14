<%@page import="com.vertexid.commons.utils.HtmlUtil"%>
<%@page import="com.vertexid.commons.utils.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.vertexid.commons.utils.CommonConstants"%>
<%@page import="com.vertexid.viself.hr.SysLoginVO"%>
<%@ page import="com.vertexid.spring.utils.SessionUtils" %>
<%
	SysLoginVO loginUser 	=     (SysLoginVO) SessionUtils.getLoginVO();
	String siteLocale			= loginUser.getSiteLocale();
	String siteLocaleLow		 = siteLocale.toLowerCase();
	//-- 로그인 사용자 정보 셋팅
	String schFieldCodestr 		= "|--전체--^0|이름^1|부서";

%>
<p style="pading-top:3px;"></p>
<div class="row">
	<div class="col-md-6 col-sm-6">
		<div class="row">
			<div class="white-panel pn-sub2-top donut-chart" style="padding: 10px 0 10px 0;margin: 0 14px 0 14px;">
					<!-- Search AREA -->
	                <div class="row sub1_search">
						<form id="aprvSchform1" method="post" onsubmit="return false;">
							<input type="hidden" name="parentCd" data-type="search" />
		                	<div class="col-md-9">
	               				<%=HtmlUtil.getSelect( true, "schField", "codeMngSchField", schFieldCodestr, "", "class=\"form-control input-sm\" data-type=\"search\" style=\"width:92px\"")%>&nbsp;
	               				<input type="text" name="schValue" id="schValue" value="" data-type="search"  class="form-control input-sm" style="width:55%"/>
		                	</div>
		                	<div class="col-md-3">
		                		<span class="ui_btn medium icon" id="searchAprvBtn"><i class="fa fa-search"><a href="javascript:void(0)" data-term="B.SEARCH"></a></i></span>
		                    </div>
	              		</form>
	                </div>
			</div>
		</div>
		<div class="row sear_mt">
  			<div class="col-md-12 col-sd-12">
  				<div class="white-panel" style="text-align: left;">
	    			<div id="treeArea" style="width:98%;height:365px;vertical-align: top;border:1px solid #CDCDCD;overflow: auto;box-shadow: 0 2px 1px rgb(0 0 0 / 20%); min-height: 330px;"></div>
  				</div>
  			</div>
  		</div>
		<div class="row sear_mt">
  			<div class="col-md-12 col-sd-12">
  				<h6 class="sub2_title" data-term="L.전결권_선택"><i class="fa fa-caret-square-o-right"></i> </h6>
  				<div class="white-panel" style="text-align: left;">  					
	    			<div id="defaultLineArea" style="width:98%;height:200px;vertical-align: top;border:1px solid #CDCDCD;overflow: auto;box-shadow: 0 2px 1px rgb(0 0 0 / 20%);">
						<ul id="defaultLineUl" style="padding-inline-start: 10px;margin-block-start: 10px;">
						</ul>
					</div>
  				</div>
  			</div>
  		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<h6 class="sub2_title" data-term="L.결재선_선택"><i class="fa fa-caret-square-o-right"></i> </h6>
		<div class="white-panel pn-sub1-table donut-chart" style="min-height: 647px;">			
			<table class="list">
				<colgroup>
					<col width="4%" />
					<col width="18%" />
					<col width="*" />
				</colgroup>
				<thead>
				<!--
				<tr>
					<td colspan="3" style="background-color: #fff">
						<span style="float:left;color:red;" data-term="M.최종결재선메세지"></span>
					</td>
				</tr>
				-->
				<tr>
					<th colspan="1"></th>
					<th data-term="L.구분"></th>
					<th data-term="L.결재자정보"></th>
				</tr>
				</thead>
				<tbody id="tbodyUserList">
				</tbody>
			</table>
		</div>
		<%-- 버튼 목록 --%>
		<br/>
		<div class="buttonlist">
			<button type="button" class="btn btn-default" id="aprvConfirm" data-term="L.확인"><i class="fa fa-check"></i> </button>
		</div>
	</div>
</div>
<!--
<style>
	.content{
		font-size : 0.85em;
	}
</style>
	<table style="width:99%; margin: 10px auto;">
	<colgroup>
		<col width="49%" />
		<col width="1%" />
		<col width="49%" />
	</colgroup>
	<tr>
		<td valign="top">
			<form name="form1" method="post" onsubmit="return false;">
			<input type="hidden" name="parentCd" data-type="search"/>
			<table class="box">
				<colgroup>
					<col width="15%" />
					<col width="65%" />
					<col width="20%" />
				</colgroup>
				<tr>
					<th width="15%" id="schFieldArea"></th>
					<td width="65%">
						<input type="text" name="schValue" id="schValue" value="" data-type="search"  class="text width_max"/>
					</td>
					<td class="hbuttons">
						<span class="ui_btn medium icon" id="searchAprvBtn"><i class="fa fa-search"><a href="javascript:void(0)" data-term="B.SEARCH"></a></i></span>
					</td>
				</tr>
			</table>
			</form>
			<div id="treeArea" style="width:98%;height:350px;vertical-align: top;border:1px solid #CDCDCD;overflow: auto;"></div>
		</td>
		<td rowspan="3"></td>
		<td valign="top" rowspan="3">
			<div style="width:98%;vertical-align: top;border:0px;overflow: auto;">

				<div class="buttonlist">
					<div class="left">
					</div>
					<div class="right">
						<span class="ui_btn small icon"><i class="fa fa-download" onclick="UserGroupLoadOpen();"><a href="javascript:void(0)" data-term="B.불러오기"></a></i></span>
						<span class="ui_btn small icon"><i class="fa fa-pencil" onclick="UserGroupRegisterOpen();"><a href="javascript:void(0)" data-term="B.저장하기"></a></i></span>
					</div>
				</div>

				<table class="list">
					<colgroup>
						<col width="4%" />
						<col width="18%" />
						<col width="*" />
					</colgroup>
					<thead>

					<tr>
						<td colspan="3" style="background-color: #fff">
							<span style="float:left;color:red;" data-term="M.최종결재선메세지"></span>
						</td>
					</tr>

					<tr>
						<th colspan="1"></th>
						<th data-term="L.구분"></th>
						<th data-term="L.결재자정보"></th>
					</tr>
					</thead>
					<tbody id="tbodyUserList">
					</tbody>
				</table>
			</div>
		</td>
	</tr>
	<tr>
		<td colspan="3" style="height:10px;">

		</td>
	</tr>
	<tr>
		<td>
			<div  class="particleHeader">
				<span class="particleHeader"><i class="far fa-dot-circle" data-term="L.전결권_선택"> </i></span>
				<span class="particleBtn">
				</span>
			</div>
			<div id="defaultLineArea" style="width:98%;height:250px;vertical-align: top;border:1px solid #CDCDCD;overflow: auto;">
				<ul id="defaultLineUl" style="padding-inline-start: 10px;margin-block-start: 10px;">
				</ul>
			</div>
		</td>
	</tr>

	<tr>
		<td colspan="3">
			<label for="none_apr_yn" data-term="L.전결처리"><input type="checkbox" name="none_apr_yn" id="none_apr_yn" value="Y" ></label>
		</td>
	</tr>
	<tr>
		<td colspan="3">
			<table class="basic">
				<tr>
					<th class="th2" data-term="L.의견"></th>
					<td class="td2"><textarea rows="3" class="text width_max" name="aprMemo" id="aprMemo"></textarea> </td>
				</tr>
			</table>
		</td>
	</tr>

	</table>
	<div class="buttonlist">
		<span class="ui_btn medium icon" id="aprvConfirm"><i class="fa fa-check"><a href="javascript:void(0)" data-term="L.확인" ></a></i></span>
	</div> -->
<script id="defaultUserTmpl" type="text/x-jquery-tmpl">
</script>
<script id="addAprvUserTmpl" type="text/x-jquery-tmpl">
{{if aprTp == "S" }}
		<tr data-meaning="apvr_tr" id="sel_\${userNo}" class='nodrop nodrag'>
{{else}}
		<tr data-meaning="apvr_tr" id="sel_\${userNo}">
{{/if}}
	<td align="center" >
{{if aprTp == "S" }}
{{else}}
		<i class="fa fa-times" style="color:red;cursor:pointer;" onClick="$('#sel_\${userNo}').remove();$('#default_\${userNo}').show()"></i>
{{/if}}
	</td>
	<td align="center" data-meaning="data_td">
{{if aprTp == "S" }}
		{{html paragonCmm.getLang("L.요청")}}
		<input type="hidden" name="aprTp" value="S"/>
{{else}}
		{{html paragonCmm.getLang("L.결재")}}
		<input type="hidden" name="aprTp" value="G"/>
		<%--
		<select name="aprTp" id="aprTp">
			<option value="G" {{if aprTp == "G" }}selected{{/if}}>{{html paragonCmm.getLang("L.승인")}}</option>
			<option value="H" {{if aprTp == "H" }}selected{{/if}}>{{html paragonCmm.getLang("L.합의(순차)")}}</option>
			<option value="B" {{if aprTp == "B" }}selected{{/if}}>{{html paragonCmm.getLang("L.합의(병렬)")}}</option>
		</select>
		--%>
{{/if}}
		<input type="hidden" name="nmKo" value="\${nmKo}"/>
		<input type="hidden" name="nmEn" value="\${nmEn}"/>
		<input type="hidden" name="dspNmKo" value="\${dspNmKo}"/>
		<input type="hidden" name="dspNmEn" value="\${dspNmEn}"/>
		<input type="hidden" name="dspNmJa" value="\${dspNmJa}"/>
		<input type="hidden" name="dspNmZh" value="\${dspNmZh}"/>
		<input type="hidden" name="userNo" value="\${userNo}"/>
		<input type="hidden" name="loginId" value="\${loginId}"/>
		<input type="hidden" name="parentDeptCd" value="\${parentDeptCd}"/>
		<input type="hidden" name="parentCd" value="\${parentDeptCd}"/>
		<input type="hidden" name="parentDeptNmKo" value="\${parentDeptNmKo}"/>
		<input type="hidden" name="parentDeptNmEn" value="\${parentDeptNmEn}"/>
		<input type="hidden" name="dutyCd" value="\${dutyCd}"/>
		<input type="hidden" name="dutyLangCd" value="\${dutyLangCd}"/>
		<input type="hidden" name="posCd" value="\${posCd}"/>
		<input type="hidden" name="posLangCd" value="\${posLangCd}"/>
		<input type="hidden" name="deptNmPathKo" value="\${deptNmPathKo}"/>
		<input type="hidden" name="deptNmPathEn" value="\${deptNmPathEn}"/>
		<input type="hidden" name="deptNmKo" value="\${deptNmKo}"/>
		<input type="hidden" name="deptNmEn" value="\${deptNmEn}"/>
		<input type="hidden" name="deptCd" value="\${deptCd}"/>
		<input type="hidden" name="telNo" value="\${telNo}"/>
		<input type="hidden" name="mobileNo" value="\${mobileNo}"/>
		<input type="hidden" name="email" value="\${email}"/>
		<input type="hidden" name="useYn" value="\${useYn}"/>
		<input type="hidden" name="corpCd" value="\${corpCd}"/>
		<input type="hidden" name="corpNm" value="\${corpNm}"/>
		<input type="hidden" name="aprStu" value="N"/>
	</td>
	<td style="text-align:left" >
		\${dspNm<%=StringUtil.capitalize(siteLocaleLow)%>} {{if dutyLangCd != null}}\${paragonCmm.getLang(dutyLangCd)} {{else}}\${paragonCmm.getLang(posLangCd)} {{/if}}
	</td>
</tr>
</script>
<script type="text/javascript">
function HrAprv() {
	var callBackFnc;
	var chkUserId = function(json, tbody){
		 var data = json;
		 var arrObj = $("input:hidden[name='userNo']","#"+tbody);
		 var rtnBool = true;
		 arrObj.each(function(i, d){
			 if(data.userNo == $(d).val()){
				 rtnBool = false;
			 }
		 });

		 return rtnBool;
	}
    var selectNode = function(code_id){
    	var codGrp = $("#"+code_id);
    	var obj = codGrp.children("input:hidden");
    	var jsonData = {};
    	$(obj).each(function(i, d){
    		jsonData[$(d).attr("name")] = $(d).val();
    	});
    	jsonData["aprTp"] = "G"; //-- 기본 결재로

    	var tbody = "tbodyUserList";
    	//-- 이미 선택된 사용자인지 여부 체크!
    	if(chkUserId(jsonData, tbody)){
    		var data = jsonData;
<%--     		 if("N" == "<%=multiSelect%>"){ --%>
//     			 $("#"+tbody).html("");
//     		 }
    		$("#addAprvUserTmpl").tmpl(data).appendTo("#"+tbody);
    	}

    	paragonCmm.tableTrDragSet("tbodyUserList");
	};
	var drawTree = function(){
		var deptCdPath = "<%=loginUser.getDeptCdPath()%>";
		var arrDEPTH = deptCdPath.split("≫");
		//tree 불러오기
		treeInitSet("/paragon/hr/hrMng/treeList/json","USER",JSON.stringify(arrDEPTH),'');

		//그려넣을 id, 루트id, 최종
	    treeDrawChild("treeArea",null);
	}
	var doConfirm = function(){
		if ($("input:checkbox[name='none_apr_yn']:checked").length != 0 && "" == $("#apr_memo").val() ) {
				alert (paragonCmm.getLang("M.필수_입력사항_입니다","전결처리 시 의견"));
				$("#apr_memo").focus();
			    return false;
			}
		if ($('#tableUserList >tbody tr').length == 1 && "" == $("#apr_memo").val() ) {
			alert (paragonCmm.getLang("M.필수_입력사항_입니다","전결처리 시 의견"));
			$("#apr_memo").focus();
		    return false;
		}

		var chkB = true;
		var data = {};
		//-- 결재자 정보 수집
		var rowsApr = $("td[data-meaning='data_td']", "#tbodyUserList");
		var arrApr = [];
		$(rowsApr).each(function(i, tr){
			 var rowData = {};
			 //-- input TAG 처리
			 var $input = $("input:hidden", $(tr));
			 $input.each(function(j, e){
				 rowData[$(e).attr("name")] = $(e).val();
			 });
			 var $select = $("select", $(tr));
			 //-- select TAG 처리
			 $select.each(function(j, e){
				 rowData[$(e).attr("name")] = $(e).val();
			 });

			 if(rowData["APR_TYPE"] == "B")chkB = false; 		//-- 합의병렬일경우 체크
			 else chkB = true; 	//-- 결재 시 체크 해제
			 arrApr.push(rowData);
		});


		if(!chkB){
			alert("최종결재선은 승인 또는 합의 순차로 지정하셔야합니다.");
			return false;
		}


		data["APR"] = arrApr;
		//-- 참조자 정보 수집
		var rowsRef = $("td[data-meaning='data_td']", "#tbodyRefList");
		var arrRef = [];
		$(rowsRef).each(function(i, td){
			var $input = $("input:hidden", $(td));
			var rowData = {};
			$input.each(function(j, e){
				rowData[$(e).attr("name").toUpperCase()] = $(e).val();
			});
			arrRef.push(rowData);
		});
		data["REF"] = arrRef;

		data["APR_MEMO"] = $("#apr_memo").val();
		if($("#none_apr_yn").length > 0){
			data["NONE_APR_YN"] = $("#none_apr_yn:checked").val();
		}
		console.log((typeof callBackFnc));
		if(typeof callBackFnc === "function"){
			callBackFnc(data);
		}
	}
	var doSearch = function(isCheckEnter) {
		if (isCheckEnter && event.keyCode != 13) {
			return;
		}
		if($("#schValue").val() != "" ){
			$("#treeArea").html("");
			treeDrawChild("treeArea","", paragonCmm.getSearchQueryParams($("#aprvSchform1")));
		}else{
			$("#treeArea").html("");
			treeDrawChild("treeArea","",paragonCmm.getSearchQueryParams($("#aprvSchform1")));
		}
	}
	var noneCheckApr = function(){
		if($("#none_apr_yn").is(":checked")){
			var msg = paragonCmm.getLang("M.전결알림");
			confirm(msg, function(r){
				if(r){
				$("tr", "#tbodyUserList").each(function(i, o){
					if(i == 0) return true;
					$(o).remove();
				});
				}else{
					$("#none_apr_yn").prop("checked",false);
				}
			});
		}
	}
	var attchmentEvent = function(){

		$("#aprvSchform1").off();
		$("#aprvSchform1").on("submit", function(){
			doSearch();
			return false;
		});


		$("#schValue").off();	//-- 이벤트 초기화
		$("#schValue").on('keyup', function(){
			// doSearch(true);
			return false;
		});
		$("#searchAprvBtn").off();
		$("#searchAprvBtn").on('click', function(){
			doSearch();
			return false;
		});
		$("#none_apr_yn").off();
		$("#none_apr_yn").on('click', function(){
			noneCheckApr();
		});
		$("#aprvConfirm").off();
		$("#aprvConfirm").on('click', function(){
			doConfirm();
		});
        $("#aprvClose").off();
        $("#aprvClose").on('click', function(){
            closeWindow();
        });

	}
	//-- 기본결재선 셋팅
	var loadData = function(initData){
		if(typeof initData === "object"){
			//-- 기본 전결권자 리스트
			$(initData.defaultAprvList).each(function(i, jsonData){
				if(i == 0){
					jsonData["aprTp"] = "S"; //-- 요청자
					$("#addAprvUserTmpl").tmpl(jsonData).appendTo("#tbodyUserList");
				}else{
					//-- 전결권자 표시
					jsonData["aprTp"] = "G"; //-- 기본 결재로
					var $li = $("<li id='default_"+jsonData.userNo+"'>");
					$li.append("<i class='fa fa-user'></i> ")
					$li.append(jsonData.dspNm<%=StringUtil.capitalize(siteLocaleLow)%> + " " + paragonCmm.getLang(jsonData.dutyLangCd));
					$li.data("param", jsonData);
					$li.css("cursor","pointer");
					$li.hover(function(){
						$li.css("text-decoration","underline");
					},function(){
						$li.css("text-decoration","none");
					})
					$li.on("click",function(){
						$('#default_'+jsonData.userNo).hide();
						$('#sel_'+jsonData.userNo).remove();
						$("#addAprvUserTmpl").tmpl(jsonData).appendTo("#tbodyUserList");
						paragonCmm.tableTrDragSet("tbodyUserList");
					})

					$("#defaultLineUl").append($li)

					//-- 저장된 전결권자 체크
					var boolContinue = true;
					if(typeof initData.defineList === "object"){
						$(initData.defineList).each(function(j, e){
							if(jsonData.dutyCd == e.dutyCd){
								boolContinue = false;
							}
						});
					}
					if(!boolContinue) return false;

				}
			});
			console.log("each end!")
			paragonCmm.tableTrDragSet("tbodyUserList");
		}
	}
	var init = function (init, callback) {
		attchmentEvent();
		$("#schFieldArea").html(
			htmlUtils.getSelect("schField","schField", "<%=schFieldCodestr%>", "","data-type='search' class='select'")
		);
		drawTree();
		if(typeof init === "function"){
			loadData(init());
		}
		if(typeof callback === "function"){
			callBackFnc = callback;
		}

    };
	return{
    	init : init,
    	selectNode:selectNode
    }
}
var USER = new HrAprv();

</script>