<%@page import="com.vertexid.commons.utils.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.vertexid.commons.utils.CommonConstants"%>
<%@page import="com.vertexid.viself.hr.SysLoginVO"%>
<%@ page import="com.vertexid.spring.utils.SessionUtils" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	SysLoginVO loginUser 	=     (SysLoginVO) SessionUtils.getLoginVO();
	String siteLocale			= loginUser.getSiteLocale();
	String capitalizeSiteLocale = StringUtil.capitalize(siteLocale.toLowerCase());// ko >> Ko
%>
<div id="stuFormProc<c:out value="${param.docUid}"/>">
<input type="hidden" name="isProd" id="isProd" value="<c:out value="${isProd}"/>" />
<form name="form1" id="procForm" method="post">
	<input type="hidden" name="stuCd" id="stuCd" value="<c:out value="${param.stuCd}"/>" />
	<input type="hidden" name="docUid" id="docUid" value="<c:out value="${param.docUid}"/>" />
	<input type="hidden" name="stuDtl" id="stuDtl" value="T"/>
	<input type="hidden" name="procType" id="procType" value=""/>
	<input type="hidden" name="nextStuCd" id="nextStuCd" value=""/>
	<input type="hidden" name="stuType1" id="stuType1" value=""/>
	<input type="hidden" name="stuType2" id="stuType2" value=""/>
	<input type="hidden" name="ordNo" id="ordNo" value=""/>
	<input type="hidden" name="lastYn" id="lastYn" value=""/>
	<input type="hidden" name="groupUid" id="groupUid" value=""/>
	<input type="hidden" name="solMasUid" id="solMasUid" value=""/>
	<input type="hidden" name="isTodo" id="isTodo" value="false"/>
	<input type="hidden" name="todoType" id="todoType" value=""/>
	<input type="hidden" name="inUid" id="inUid" value=""/>
	<input type="hidden" name="wrtloginId" id="wrtloginId" value=""/>
</form>
	<table><tbody id="aprDiv<c:out value="${param.docUid}"/>"></tbody></table>
	<div id="refDiv"></div>
	<table class="basic">
		<caption id="writeCaption"></caption>
	</table>
	<div id="particleArea<c:out value="${param.docUid}"/>">
	</div>
	<div id="stuAprvLineArea<c:out value='${param.docUid}'/>" style="display: none;">
		<br/>
		<table class="basic">
			<caption data-term="L.????????????"></caption>
			<thead>
			<tr>
				<th style="width:7%;text-align:center;" data-term="L.????????????"></th>
				<th style="width:7%;text-align:center;" data-term="L.??????"></th>
				<th style="width:14%;text-align:center;" data-term="L.????????????"></th>
				<th style="width:26%;text-align:center;" data-term="L.???????????????"></th>
				<th style="width:*;text-align:center;" data-term="L.??????"></th>
			</tr>
			</thead>
			<tbody id="stuAprvLineTbody<c:out value='${param.docUid}'/>">
			</tbody>
		</table>
	</div>
	<div id="stuAprvProcArea<c:out value='${param.docUid}'/>">
	</div>
	<div id="stuNextProcArea<c:out value='${param.docUid}'/>" style="display:none;">
		<br/>
		<table class="basic">
		<tr>
			<th class="th2" data-term="L.????????????"></th>
			<td style="text-align:right;" id="stuNextProcTbody<c:out value='${param.docUid}'/>">
			</td>
		</tr>
		</table>
	</div>
	<div class="buttonlist">
		<div class="right" id="btnProcArea<c:out value='${param.docUid}'/>">
		</div>
	</div>
	<div id="aprvModal<c:out value='${param.docUid}'/>" style="width:600px;height:400px;display: none;" ></div>
	<div id="nextProcModal<c:out value='${param.docUid}'/>" style="width:600px;height:400px;display: none;" ></div>
</div>
<script id="stuAprvLineTmpl<c:out value='${param.docUid}'/>" type="text/x-jquery-tmpl">
<tr>
	<td style="text-align:center;{{if aprStu == "W"}}background: #FFDFDF;{{/if}}">\${paragonCmm.getLang(aprStuLangCd)}</td>
	<td style="text-align:center;{{if aprStu == "W"}}background: #FFDFDF;{{/if}}">\${paragonCmm.getLang(aprTypeLangCd)}</td>
	<td style="text-align:center;{{if aprStu == "W"}}background: #FFDFDF;{{/if}}">\${aprDteTime}</td>
	<td style="text-align:left;{{if aprStu == "W"}}background: #FFDFDF;{{/if}}">
		\${aprNm }
	</td>
	<td style="{{if aprStu == "W"}}background: #FFDFDF;{{/if}}">
		\${aprMemo }
	</td>
</tr>
</script>

<script id="stuNextProcTmpl<c:out value='${param.docUid}'/>" type="text/x-jquery-tmpl">
	<span class="ui_btn medium icon" id="proc_\${nextStuCd}_<c:out value='${param.docUid}'/>"><i class="fa fa-check"><a href="javascript:void(0)" >\${paragonCmm.getLang(nextStuNm) }</a></i></span>
</script>
<script id="stuAprvProcTmpl<c:out value='${param.docUid}'/>" type="text/x-jquery-tmpl">
<br/>
<table class="basic">
	<caption>\${paragonCmm.getLang('L.????????????') }</caption>
	<tr>
		<th class="th4">\${paragonCmm.getLang('L.????????????') }</th>
		<td class="td4">
			{{html htmlUtils.getInputRadio("aprStu", "Y|"+paragonCmm.getLang('L.??????')+"^R|"+paragonCmm.getLang('L.??????')+"","Y")}}
		</td>
		<th class="th4">\${paragonCmm.getLang('L.?????????') }</th>
		<td class="td4">
			<c:out value="${sessionUser.dspNmKo}"/>
		</td>
	</tr>
	<tr>
		<th class="th2">\${paragonCmm.getLang('L.????????????') }</th>
		<td class="td2" colspan="3">111
			<textarea class="memo width_max" name="aprMemo" id="aprMemo" maxlength="600" maxlength="600"></textarea>
		</td>
	</tr>
</table>
<div class="buttonlist">
	<div class="right" id="btnAprProcArea<c:out value='${param.docUid}'/>"></div>
</div>
</script>
<script type="text/javascript">

"use strict";

var jsonData<c:out value="${param.docUid}"/>    = {}		//-- Json Data
var jsonView<c:out value="${param.docUid}"/>    = {}		//-- Json Data

function StuFrom_<c:out value="${param.docUid}"/>(){

	var POST_FIX = "<c:out value='${param.docUid}'/>";
	var obj = {
		prnt 				: "#stuFormProc" +POST_FIX
		,aprDiv				: "#aprDiv"+POST_FIX
		,aprvModal			: "#aprvModal"+POST_FIX
		,particleArea		: "#particleArea"+POST_FIX
		,stuAprvLineArea	: "#stuAprvLineArea"+POST_FIX
		,stuAprvLineTbody	: "#stuAprvLineTbody"+POST_FIX
		,stuAprvProcArea	: "#stuAprvProcArea"+POST_FIX
		,stuNextProcTmpl	: "#stuNextProcTmpl"+POST_FIX
		,stuNextProcArea	: "#stuNextProcArea"+POST_FIX
		,stuNextProcTbody	: "#stuNextProcTbody"+POST_FIX
		,btnProcArea		: "#btnProcArea"+POST_FIX
		,stuAprvLineTmpl	: "#stuAprvLineTmpl"+POST_FIX
		,stuAprvProcTmpl	: "#stuAprvProcTmpl"+POST_FIX
		,nextProcModal		: "#nextProcModal"+POST_FIX
	}

	var isDoSubmit 	= true; 	//-- ???????????? ??????
	var tmpValiFunc = [];		//-- ???????????? ??????????????? ??????
	var valiFunc 	= [];		//-- ??????????????? ??????
	var isValidate	= false;	//-- ??????????????? ??????
	var dataCube    = {}		//-- Data cube Master

	var setTmpValiFunc = function(func){ //-- ???????????? ??????????????? ????????? ?????? ??????.
		tmpValiFunc.push(func);
	}

	var setValiFunc = function(func){ //-- ???????????? ??????????????? ????????? ?????? ??????.
		valiFunc.push(func);
	}
	var chkVal = function(mode){
		if(!isValidate){
			if("T" == mode || "M" == mode){
				var bool = false;
				$(tmpValiFunc).each(function(i, f){
					bool = f();
					return bool;
				});
				if(!bool) return false;
			}else if("D" == mode){
				return true;
			}else{
				var bool = false;
				$(valiFunc).each(function(i, f){
					bool = f();
					return bool;
				});
				if(!bool) return false;
			}
			isValidate = true;
			return true;
		}else{
			return true;
		}

	}
	var doSubmit = function(mode) {
		var frm = $("#procForm", obj.prnt);
		//-- Validation ??????
		if(!chkVal(mode)) return false;
		isDoSubmit = true;
		if(!isDoSubmit) return false; //-- ???????????? ?????? ??????
		else{
			if("M" != mode){ 		 //-- ??????????????? ????????????????????? ???????????? ????????? ???????????? ?????????.20190409 ?????????
				isDoSubmit = false;
			}
		}
		var stu_dtl = mode;

		var msg1 = paragonCmm.getLang("M.??????????????????","B.TEMP_SAVE");
		var msg2 = paragonCmm.getLang("M.??????????????????","B.??????");
		var msg3 = paragonCmm.getLang("M.??????????????????","L.????????????");
		var msg4 = paragonCmm.getLang("M.??????????????????","B.??????");
		var msg = "";

		if("T" == mode){
			msg = msg1;
		}else if("F" == mode){
			msg = msg3;
			if($("input:hidden[name='_aprLoginId']", obj.aprDiv).length == 1){
				msg = paragonCmm.getLang("M.??????????????????","L.??????");
			}

		}else if("D" == mode){
			msg = msg4;
		}else if("M" == mode){
			stu_dtl = "T";
			msg = "??????????????? ?????? ???????????? ??? ?????? ?????????.<br/>?????????????????????????";
		}else{
			msg = msg2;
		}

		$("#stuDtl",obj.prnt).val(stu_dtl);

		setTimeout(function(){
			confirm(msg, function(r){
				if (r) {
					//--????????? ????????? ??????
					paragonCmm.setEditorSubmit("");
					//-- ?????? ?????? ?????? ??????
					if($(".cost", $("#procForm", obj.prnt)).length > 0){
						$(".cost", $("#procForm", obj.prnt)).each(function(i, o){
							$(this).val($(this).val().replaceAll(",",""));
						});
					}
					var data = $("#procForm", obj.prnt).serializeJSON();
					data["jsonData"] = JSON.stringify($(obj.particleArea).serializeJSON());
					data["aprvLineDTO"] = $(obj.aprDiv).tableDataToJson();
					paragonCmm.submitAjax("/paragon/datacube/DataCube/doProc/json",data, function(json){
						if(json.errYn === "E"){
							//-- ????????????
							alert(json.msg);
							return false;
						}

						var addedTab = false;
						var tabs = $('#ipMasTab').tabs('tabs');
						$(tabs).each(function(i, tab){
							if($(tab).attr("id") == "tab_<c:out value='${param.docUid}'/>"){
								var url = "/paragon/def/defStuForm/stuFormView.include";
								if(mode == "T"){	// ???????????? ????????? ?????? ????????????
									url = "/paragon/def/defStuForm/stuFormProc.include";
								}
									console.log(url);
								tab.panel('refresh', url);				// tab refresh
								$('#ipMasTab').tabs('select', i); // tab select
								addedTab = true;
								ipTepLeft.init();			//LEFT ?????? ?????????
							}
						});
						if(!addedTab && opener){

							window.close();
						}


					},null, function(){ //-- error callback function
						isDoSubmit = true;
					});

				}
			});
		}, 300);
	}
	//-- ?????? ????????? ??????
	var initAprvLine = function(){
		var initData = {};
		initData["loginId"] = "<%=loginUser.getLoginId()%>";
		initData["deptCd"] = "<%=loginUser.getDeptCd()%>";
		return initData;
	}
	//-- ????????? ?????? ??????
	var selAprvLine = function(){
		if(!chkVal("S")) return false;
		//-- ????????? ?????? ??????
		$(obj.aprvModal).window({
			iconCls:'icon-search',
		    width:850,
		    height:600,
		    title:paragonCmm.getLang("L.???????????????"),
		    href:"/paragon/hr/hrAprvTreeInfo.modal",
		    modal:true,
		    onLoad:function(){
		    	paragonCmm.convertLang($(obj.aprvModal)); 			//-- ????????? ??????
		    	USER.init(initAprvLine, setAprvCallBack);			//-- ??????????????? ????????? ??? ?????? ??????
		    }
		});
	}
	//-- ????????? ?????? ??? Submit
	var setAprvCallBack = function(data){
		var apr = data["APR"];
		var ref = data["REF"];
		var apr_memo = data["apr_memo"];
		var none_apr_yn = data["none_apr_yn"];
		$(obj.aprDiv).html("");
		//-- ????????? ????????? ??????
		$(apr).each(function(i, d){
			var $tr = $("<tr>");
			var $td = $("<td>");
			$td.append($("<input type='hidden' name='aprLineUid'>").val(paragonCmm.getRandomUUID()));	//-- Line UID ??????
			$td.append($("<input type='hidden' name='docUid'>").val($("#docUid", obj.prnt).val()));
			$td.append($("<input type='hidden' name='ordNo'>").val((i+1)));
			$td.append($("<input type='hidden' name='aprType'>").val(d.aprType));
			$td.append($("<input type='hidden' name='aprDeptCd'>").val(d.deptCd));
			$td.append($("<input type='hidden' name='aprDeptNm'>").val(d.deptNm<%=capitalizeSiteLocale%>));
			$td.append($("<input type='hidden' name='aprLoginId'>").val(d.loginId));
			$td.append($("<input type='hidden' name='aprUserNm'>").val(d.nm<%=capitalizeSiteLocale%>));
			if(i == 0){
				$td.append($("<input type='hidden' name='aprMemo'>").val(apr_memo));
			}else{
				$td.append($("<input type='hidden' name='aprMemo'>").val(""));
			}
			$tr.append($td);
			$(obj.aprDiv).append($tr);
		});
		//-- ??????????????????
// 		$("#aprDiv").append($("<input type='hidden' name='_none_apr_yn'>").val(none_apr_yn));
		//-- ?????? ??????


		$("#refDiv", obj.prnt).html("");
		//-- ????????? ????????? ??????
		$(ref).each(function(i, d){

			$("#refDiv").append($("<input type='hidden' name='aprLineUid'>").val(paragonCmm.getRandomUUID()));	//-- Line UID ??????
			$("#refDiv").append($("<input type='hidden' name='docUid'>").val($("#docUid").val()));
			$("#refDiv").append($("<input type='hidden' name='ordNo'>").val((i+1)));
			$("#refDiv").append($("<input type='hidden' name='aprType'>").val(d.aprType));
			$("#refDiv").append($("<input type='hidden' name='aprStu'>").val(""));
			$("#refDiv").append($("<input type='hidden' name='aprDeptCd'>").val(d.deptCd));
			$("#refDiv").append($("<input type='hidden' name='aprDeptNm'>").val(d.deptNm<%=capitalizeSiteLocale%>));
			$("#refDiv").append($("<input type='hidden' name='aprLoginId'>").val(d.loginId));
			$("#refDiv").append($("<input type='hidden' name='aprUserNm'>").val(d.nm<%=capitalizeSiteLocale%>));
		});
		$(obj.aprvModal).window('close');
		//-- ?????? ??? ????????????
		doSubmit("F");
	}
	//-- ?????? ?????? ??????
	var loadBtn = function(procType){
		if($("#isTodo", obj.prnt).val() == "false"){	//-- ????????? ????????? false
			return false;
		}
		var stuDtl = $("#stuDtl", obj.prnt).val();
		if("T" == stuDtl && $("#wrtloginId", obj.prnt).val() == "<c:out value='${sessionUser.loginId}'/>"){		//-- ????????????????????? ????????? false
			procType = ((procType == undefined || procType == "") ? "" : procType);
			if(procType.indexOf("T") > -1){	//-- ????????????
				var uiBtn = $('<span class="ui_btn medium icon">');
				var iTag  = $("<i id='imsiSaveBtn<c:out value='${param.docUid}'/>'>").attr("class","fa fa-edit");
				$(uiBtn).html(iTag.append($("<a href='javascript:void(0)'>").text(paragonCmm.getLang("L.????????????"))));
				$(obj.btnProcArea).append(uiBtn);
				$("#imsiSaveBtn<c:out value='${param.docUid}'/>").on("click",function(){doSubmit('T');});

			}
			if(procType.indexOf("F") > -1){	//-- ????????????, ????????????
				var uiBtn = $('<span class="ui_btn medium icon" id="preViewBtn<c:out value='${param.docUid}'/>">');
				var iTag  = $("<i>").attr("class","fa fa-search");
				uiBtn.append(iTag.append($("<a href='javascript:void(0)'>").text(paragonCmm.getLang("L.????????????"))));
				$(obj.btnProcArea).append(uiBtn);
				$("#preViewBtn<c:out value='${param.docUid}'/>").on("click",function(){doSubmit('M');});

				var uiBtn2 = $('<span class="ui_btn medium icon" id="doAprvBtn<c:out value='${param.docUid}'/>">');
				var iTag2  = $("<i>").attr("class","fa fa-pencil");
				uiBtn2.append(iTag2.append($("<a href='javascript:void(0)'>").text(paragonCmm.getLang("L.????????????"))));
				$(obj.btnProcArea).append(uiBtn2);
				$("#doAprvBtn<c:out value='${param.docUid}'/>").on("click",function(){selAprvLine()});

			}
			if(procType.indexOf("S") > -1){	//-- ????????????,????????????
				var uiBtn = $('<span class="ui_btn medium icon" id="saveBtn<c:out value='${param.docUid}'/>">');
				var iTag  = $("<i>").attr("class","fa fa-pencil");
				$(uiBtn).html(iTag.append($("<a href='javascript:void(0)'>").text(paragonCmm.getLang("L.??????"))));
				$(obj.btnProcArea).append(uiBtn);
				$("#saveBtn<c:out value='${param.docUid}'/>").on("click",function(){doSubmit("S");});
			}
			if(procType.indexOf("X") > -1){	//-- ????????????
				var uiBtn = $('<span class="ui_btn medium icon" id="fixSaveBtn<c:out value='${param.docUid}'/>">');
				var iTag  = $("<i>").attr("class","fa fa-pencil");
				$(uiBtn).html(iTag.append($("<a href='javascript:void(0)'>").text(paragonCmm.getLang("L.??????"))));
				$(obj.btnProcArea).append(uiBtn);
				$("#fixSaveBtn<c:out value='${param.docUid}'/>").on("click",function(){doSubmit('S');});
			}
		}
	}
	//-- ????????? ????????? ??????
	var loadData = function(){
		if($("#docUid",obj.prnt).val() != null && $("#docUid",obj.prnt).val() !=""){
			var data = {};
			data["docUid"] = $("#docUid",obj.prnt).val();
			paragonCmm.callAjax("/paragon/datacube/DataCube/listOne/json",data, function(json){
				if(json.errYn === "E"){
					alert(json.msg);//-- ????????????
					return false;
				}
				var login = json.loginId;
				if(json.data){
					$("#stuDtl",obj.prnt).val(json.data[0].stuDtl);
					$("#nextStuCd",obj.prnt).val(json.data[0].nextStuCd);
					$("#groupUid",obj.prnt).val(json.data[0].groupUid);
					$("#ordNo",obj.prnt).val(json.data[0].ordNo);
					$("#solMasUid",obj.prnt).val(json.data[0].solMasUid);
					$("#isTodo",obj.prnt).val(json.data[0].isTodo);
					$("#todoType",obj.prnt).val(json.data[0].todoType);
					$("#wrtloginId",obj.prnt).val(json.data[0].regLoginId);
					$("#inUid",obj.prnt).val(json.data[0].inUid);

					dataCube = json.data[0];
					if(json.data[0].stuDtl == "T"){
						jsonData<c:out value="${param.docUid}"/> = JSON.parse(json.data[0].jsonData);
					}else{
						jsonView<c:out value="${param.docUid}"/> = JSON.parse(json.data[0].jsonData);
					}

					loadForm();		// ?????? ??????

				}
			});

		}
	}
	//-- ??? ????????? ??????
	var loadForm = function(){
		var data = {};
		data["stuCd"] = $("#stuCd",obj.prnt).val();
		paragonCmm.callAjax("/paragon/def/defstumng/DefStuMng/listOne/json",data, function(json){
			if(json.errYn === "E"){
				alert(json.msg);//-- ????????????
				return false;
			}
			if(json.data){
				$.each(json.data[0], function(key, val){
					if("cud" != key){	//-- ?????? ????????????????????? U??? ???????????? ?????? ????????? ??????.
						$("#"+key,obj.prnt).val(val);
					}
				});
				$("#writeCaption").html(paragonCmm.getLang(json.data[0].docNmLangCd));

				loadParticle();								//-- ????????? ?????? ??????
				var stuDtl = $("#stuDtl",obj.prnt).val();
				if("T" != stuDtl){
					loadAprvLine();								//-- ????????? ??????
				}
				if("IMSI" === $("#todoType",obj.prnt).val()){	//-- ???????????? ??????
					loadBtn(json.data[0].procType);
				}else if("PROC" === $("#todoType",obj.prnt).val()){		//-- ??????????????????
					nextProcBtn();								//-- ?????? ?????? ?????? ??????
				}else if("APRV" === $("#todoType",obj.prnt).val()){
					loadAprvForm();							//-- ???????????? ??? ??????
				}
			}
		});

	}
	//-- ????????? ??????
	var loadAprvLine = function(){
		var data = {docUid:$("#docUid",obj.prnt).val()};
		paragonCmm.callAjax("/paragon/aprv/aprv/aprLinelist/json",data, function(json){
			if(json.errYn === "E"){
				alert(json.msg);//-- ????????????
				return false;
			}
			if(json.data.length > 0){
				//--Template ??????
				$(obj.stuAprvLineTmpl).tmpl(json.data).appendTo(obj.stuAprvLineTbody);
				//-- ????????? ??????
				paragonCmm.convertLang($(obj.stuAprvLineArea));
				//-- ????????? ??????
				$(obj.stuAprvLineArea).show();
				if($("#isTodo",obj.prnt).val() == "true"){ 	//-- ???????????????
					$(json.data).each(function(i, o){
						if("W" == o.aprStu){				//-- ?????? ?????? ??????
							var $aprvTodo = $("<input type='hidden'>").attr("id","aprvTodo<c:out value='${param.docUid}'/>").data("aprRow", o);
							$(obj.stuAprvProcArea).append($aprvTodo);
						}
					});
				}
			}

		});
	}
	//-- ???????????? ??????
	var nextProcBtn = function(){
		if("" === $("#inUid",obj.prnt).val()){	//-- ?????? ?????? ????????? ????????? false
			return false;
		}
		if($("#isTodo",obj.prnt).val() == "false"){	//-- ????????? ????????? false
			return false;
		}
		var data = {inUid:$("#inUid",obj.prnt).val()};
		paragonCmm.convertLang($(obj.stuNextProcArea));
		$(obj.stuNextProcArea).show();
		paragonCmm.callAjax("/paragon/def/defsturel/DefStuRel/outList/json",data, function(json){
			if(json.errYn === "E"){
				alert(json.msg);//-- ????????????
				return false;
			}
			$(obj.stuNextProcTmpl).tmpl(json.data).appendTo($(obj.stuNextProcTbody));
			$(json.data).each(function(i,d){
				var id = "proc_"+d.nextStuCd+"_<c:out value='${param.docUid}'/>"
				$("#"+id).data('rowData', d);
				$("#"+id).on('click',function(){	//-- ???????????? ?????????
					var row = $(this).data("rowData");
					//{authLangCd: "L.???????????????",inUid: "...",nextStuCd: "TH_REQ_DIS",nextStuNm: "L.?????????_??????",ordNo: "0",outUid: "...",procType: "S",regDte: "...",regLoginId: "...",rn: "1",roleCd: "DIVID",stuCd: "TH_REQ",stuNm: "????????? ??????",stuType1: "SOL_IPS",stuType1LangCd: "",stuType2: "IPS_TH",stuType2LangCd: "",totCnt: "1",uptDte: "...",uptLoginId: "..."}
					var url = "/paragon/def/defStuForm/stuFormWrite.popup";
// 					var imsiForm = $("<form method='POST'>").attr("action",url);
// 					imsiForm.append($("<input type='hidden' name='stuCd'>").val(row.nextStuCd));
// 					imsiForm.append($("<input type='hidden' name='docUid'>").val(""));
// 					imsiForm.append($("<input type='hidden' name='solMasUid'>").val($("#solMasUid").val()));
// 					imsiForm.append($("<input type='hidden' name='_csrf'>").val($("meta[name='_csrf']").attr("content")));
// 					paragonCmm.openWindow("", "1000", "750", "POP_TEP_"+row.nextStuCd, "yes", "yes", "");
// 					imsiForm.attr("target","POP_TEP_"+row.nextStuCd);
// 					imsiForm.appendTo("body");
// 					imsiForm.submit();
// 					imsiForm.remove();
					//-- ????????? ?????? ??????
					var newDocUid = paragonCmm.getRandomUUID();
					var queryParams = {};
						queryParams["stuCd"] = row.nextStuCd;
						queryParams["docUid"] = newDocUid
						queryParams["solMasUid"] = $("#solMasUid").val();

					$(obj.nextProcModal).window({
						iconCls:'icon-more',
					    width:850,
					    height:630,
					    title:paragonCmm.getLang(row.nextStuNm),
					    href:url,
					    method:'POST',
					    queryParams:queryParams,
					    modal:true,
					    onLoad:function(){
					    	stuWriteForm_setFunc(function(){							//-- ?????? Function ??????
					    		$(obj.nextProcModal).window('close');
					    	});
					    	paragonCmm.convertLang($(obj.nextProcModal)); 			//-- ????????? ??????
					    },
					    onResize:function(){
// 					    	$('#partyInfoList').datagrid('resize');
					    }
					});

				})

			});
		});
	}
	//-- ???????????? ??????
	var nextProc = function(){
		if("" === $("#inUid",obj.prnt).val()){	//-- ?????? ?????? ????????? ????????? false
			return false;
		}
		if($("#isTodo",obj.prnt).val() == "false"){	//-- ????????? ????????? false
			return false;
		}
		var data = {inUid:$("#inUid",obj.prnt).val()};
		$(obj.stuNextProcArea).show();
		paragonCmm.callAjax("/paragon/def/defsturel/DefStuRel/outList/json",data, function(json){
			if(json.errYn === "E"){
				alert(json.msg);//-- ????????????
				return false;
			}
			$(obj.stuAprvProcTmpl).tmpl(json.data).appendTo($(obj.stuNextProcTbody));

// 			console.log(json);
		});
	}
	//-- ????????? ??????
	var loadParticle = function(){
		var data = {};
		data["stuCd"] = $("#stuCd",obj.prnt).val();
		paragonCmm.callAjax("/paragon/def/defstumng/DefStuParti/list/json",data, function(json){
			var maxLen = $(json.data).length;
			$(json.data).each(function(i, e){
				if("false" == $("#isProd",obj.prnt).val()){
					$(obj.particleArea).append($("<font color=\"#DDDDDD\">++?????? : "+e.patiMngNo+" : "+e.patiNm+"++</font>"));
				}
				$(obj.particleArea).append("<br>");
				var $div = $("<div>").attr("id", e.patiMngNo);
				var url = e.patiJspViewPath+".include";
				if($("#stuDtl",obj.prnt).val() == "T"){
					url = e.patiJspWrtPath+".include";
				}
				//-- ????????? ??????
				$(obj.particleArea).append(
					$div.load(url,{docUid:"<c:out value="${param.docUid}"/>"},function(){
						if(i == (maxLen - 1)){	//-- ?????? ????????? ?????? ?????? ??? ????????? Convert ??????
							setTimeout(function(){
								paragonCmm.convertLang($(obj.particleArea));
							},200);
						}
					})
				);
			});
		});
	}
	//-- ???????????? Form ??????
	var loadAprvForm = function(){
		$(obj.stuAprvProcTmpl).tmpl({}).appendTo($(obj.stuAprvProcArea));

		var uiBtn = $('<span class="ui_btn medium icon">');						//-- ?????????????????? ??????
		var iTag  = $("<i id='aprvProcBtn<c:out value='${param.docUid}'/>'>").attr("class","fa fa-pencil");
		$(uiBtn).html(iTag.append($("<a href='javascript:void(0)'>").text(paragonCmm.getLang("L.??????"))));
		$("#btnAprProcArea<c:out value='${param.docUid}'/>").append(uiBtn);
		$("#aprvProcBtn<c:out value='${param.docUid}'/>").on("click",function(){loadAprvProc();});
	}
	// ???????????? ??????
	var loadAprvProc = function(){
		var msg = paragonCmm.getLang('M.??????????????????', $("input:radio[name='aprStu']:checked",obj.prnt).attr("title"));
		confirm(msg,function(r){
			if(r){
				var data = $("#aprvTodo<c:out value='${param.docUid}'/>").data("aprRow");
				data.aprStu = $("input:radio[name='aprStu']:checked",obj.prnt).val();
				data.aprMemo = $("#aprMemo",obj.prnt).val();
				data.stuType2 = $("#stuType2",obj.prnt).val();	//-- ????????? Handler ????????? ??????.
				data.stuCd = $("#stuCd",obj.prnt).val();	//-- ????????? Handler ????????? ??????.

				paragonCmm.callAjax("/paragon/aprv/aprv/doAprvProc/json",data, function(json){
					console.log(json);
				});
			}
		});
	}
	var init = function(){
		loadData();
	}
	return{
		init:init,
		setValiFunc:setValiFunc,
		setTmpValiFunc:setTmpValiFunc
	}
}
var stuFrom_<c:out value="${param.docUid}"/> = new StuFrom_<c:out value="${param.docUid}"/>();
stuFrom_<c:out value="${param.docUid}"/>.init();

</script>