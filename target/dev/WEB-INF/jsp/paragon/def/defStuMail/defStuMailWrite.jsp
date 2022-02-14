<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.vertexid.commons.utils.StringUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<table class="basic">
	<tr>
		<th class="th4">법무구분</th>
		<td class="td4" data-col="stuTp2LangCd"></td>
		<th class="th4">기본상태명</th>
		<td class="td4" data-col="stuBaseNm"></td>
	</tr>
	<tr>
		<th class="th4">상태코드</th>
		<td class="td4" data-col="stuCd"><c:out value="${param.stuCd}"/></td>
		<th class="th4">처리형식</th>
		<td class="td4" data-col="procTpLangCd"></td>
	</tr>
</table>
<br><br>
<table class="basic">
	<caption>수신 메일 설정</caption>
	<tr>
		<th style="width:25%">
			지정메일
		</th>
		<th style="width:75%">
			상세내용
			<span class="ui_btn small icon"><i class="fa fa-minus" onclick="stuMailWrite.initRightArea();"><a href="javascript:void(0)" >초기화</a></i></span>
		</th>
	</tr>
	<tr>
		<td style="width:20%;vertical-align: top;">
			<table class="basic">
			<tbody id="event_tbody">
			</tbody>
			</table>
		</td>
		<td style="width:80%">
		<form name="form1" id="form1" method="post">
			<input type="text" name="stuCd" class="form-control input-sm" id="stuCd" value="<c:out value="${param.stuCd}"/>" />
			<input type="hidden" name="stuEmailUid" id="stuEmailUid" value="" />
			<table class="basic">
				<tr>
					<th class="th4">이벤트</th>
					<td>
						<select name="stuDtl" id="stuDtl" class="select" onChange="stuMailWrite.harfRightArea();">
						</select>
					</td>
				</tr>
				<tr>
					<th class="th4">수신자선택</th>
					<td>
						<table class="basic">
							<tr>
								<th class="th4">역할추가</th>
								<td class="td4">
									<select name="recRole" id="recRole" class="select">
									</select>
									<span class="ui_btn small icon"><i class="fa fa-plus" onclick="stuMailWrite.addRole($('#recRole'),'recRole');"><a href="javascript:void(0);">추가</a></i></span>
								</td>
								<th class="th4">사용자추가</th>
								<td class="td4">
									<span class="ui_btn small icon" id="USER_SUSIN"><i class="fa fa-search" ><a id="user" href="javascript:void(0);">수신자선택</a></i></span>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<th class="th4">수신자</th>
					<td>
						<table class="basic">
							<tr>
								<th class="th4">역할
									<input type="hidden" name="recRoleCd"/>
									<input type="hidden" name="recRoleNm"/>
								</th>
								<td class="td4" id="recRole_td">
								</td>
								<th class="th4" >사용자
									<input type="hidden" name="recUserCd"/>
									<input type="hidden" name="recUserNm"/>
								</th>
								<td class="td4" id="recUser_td"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<th class="th4">참조자선택</th>
					<td>
						<table class="basic">
							<tr>
								<th class="th4">역할추가</th>
								<td class="td4">
									<select name="refRole" id="refRole" class="select">
									</select>
									<span class="ui_btn small icon"><i class="fa fa-plus" onclick="stuMailWrite.addRole($('#refRole').val(),'ref_role');"><a href="javascript:void(0);">추가</a></i></span>
								</td>
								<th class="th4">사용자추가</th>
								<td class="td4">
									<span class="ui_btn small icon"><i class="fa fa-search" onclick="stuMailWrite.openUserselect('ref_user');"><a id="user" href="javascript:void(0);">참조자선택</a></i></span>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<th class="th4">참조자</th>
					<td>
						<table class="basic">
							<tr>
								<th class="th4">역할
									<input type="hidden" name="refRoleCd"/>
									<input type="hidden" name="refRoleNm"/>
								</th>
								<td class="td4" id="refRole_td">
								</td>
								<th class="th4" >사용자
									<input type="hidden" name="refUserCd"/>
									<input type="hidden" name="refUserNm"/>
								</th>
								<td class="td4" id="refUser_td"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr id="smsMessage" style="display: none;">
					<th>SMS 메시지</th>
					<td>
						<input type="text" name="sms_message" id="sms_message" class="form-control input-sm" value=""/>
					</td>
				</tr>
				<tr>
					<th>메일제목 ko</th>
					<td>
						<input type="text" name="titKo" id="titKo" class="form-control input-sm" value=""/>
					</td>
				</tr>
				<tr>
					<th>메일제목 en</th>
					<td>
						<input type="text" name="titEn" id="titEn" class="form-control input-sm" value=""/>
					</td>
				</tr>
				<tr>
					<th>메일제목 ja</th>
					<td>
						<input type="text" name="titJa" id="titJa" class="form-control input-sm" value=""/>
					</td>
				</tr>
				<tr>
					<th>메일제목 zh</th>
					<td>
						<input type="text" name="titZh" id="titZh" class="form-control input-sm" value=""/>
					</td>
				</tr>
				<tr>
					<th>메일내용ko</th>
					<td>
						<textarea name="contentKo" id="contentKo" rows="10" class="form-control input-sm"></textarea>
					</td>
				</tr>
				<tr>
					<th>메일내용en</th>
					<td>
						<textarea name="contentEn" id="contentEn" rows="10" class="form-control input-sm"></textarea>
					</td>
				</tr>
				<tr>
					<th>메일내용ja</th>
					<td>
						<textarea name="contentJa" id="contentJa" rows="2" class="form-control input-sm"></textarea>
					</td>
				</tr>
				<tr>
					<th>메일내용zh</th>
					<td>
						<textarea name="contentZh" id="contentZh" rows="2" class="form-control input-sm"></textarea>
					</td>
				</tr>
				<tr>
					<th>링크사용여부</th>
					<td>
					</td>
				</tr>
			</table>
		</form>
		<div class="buttonlist">
			<div class="right">
				<span class="ui_btn medium icon" id="btnSave"><i class="fa fa-check" onclick="stuMailWrite.doSubmit(document.form1)"><a href="javascript:void(0)"  data-term="B.SAVE"></a></i></span>
			</div>
		</div>
		</td>
	</tr>
</table>
<br><br>
<div id="userModal" style="width:600px;height:400px;display: none;" ></div>
<div class="buttonlist">
	<div class="right">
		<span class="ui_btn medium icon"><i class="fa fa-check" onclick="window.close();"><a href="javascript:void(0)"  data-term="B.CLOSE"></a></i></span>
	</div>
</div>
<script type="text/javascript">

"use strict";

function StuMailWrite(){
	//-- 이벤트 등록
	var attchmentEvent = function(){
		//--미리보기 이벤트
		$("#btnSave").on("click",function(){
			doSubmit();
		});

		$("#USER_SUSIN").on("click",function(){
			//-- 사용자 선택 모달
			$("#userModal").window({
				iconCls:'icon-search',
			    width:850,
			    height:500,
			    title:paragonCmm.getLang("L.발명자정보"),
			    href:"/paragon/hr/hrUserTreeInfo.modal",
			    modal:true,
			    onLoad:function(){
			    	paragonCmm.convertLang($("#userModal")); 	//-- 다국어 처리
			    	USER.init(initUser, setUser);				//-- 결재자선택 초기화 및 콜백 셋팅
			    }
			});
		});
	}
	//-- 저장 데이터 LOAD
	var loadMaster = function(){
		//-- 마스터 데이터 LOAD
		var data = {};
		data["stuCd"] = $("#stuCd").val();
		paragonCmm.callAjax("/paragon/def/StuMng/list/json",data, function(json){
			$.each(json.data[0],function(k, v){
				var val = v;
				var e = $("[name='"+k+"']");
				if($(e).prop('tagName') == "INPUT" && $(e).attr("type") == "checkbox"){
					$(e).each(function(i, o){
						if(val.indexOf($(o).val()) > -1 )$(o).attr("checked",true);
					});
				}else{
					if("stuType2" == k){
						var cd = $("#stuType1").val();
						htmlUtils.getCodeSelectOpt({
							targetId:"stuType2",
							parentCd:cd,
							initdata:"|"+paragonCmm.getLang("L.CBO_SELECT"),
							valNm:"cd",
							txtNm:"langCd"
						});
						htmlUtils.loadCodeStr(val,"cdAbb,langCd","",function(str){
							tmplStuGroup = str;
						});
					}
					$(e).val(val);
				}
			});
		});	//-- Async 동기



	}

	var removeEvent = function(stuEmailUid){
		// 삭제 프로세스
		var msg = paragonCmm.getLang("M.하시겠습니까", "B.DELETE");
		confirm(msg, function(r){
			if(r){
				var params = {"stuEmailUid":stuEmailUid}
				paragonCmm.callAjax("/paragon/def/defstumail/DefStuMail/deleteData/json",params, function(json){
					initArea();
					initRightArea();
				});
			}
		})
	}
	var doSubmit = function(){
		// 저장 프로세스
		var msg = paragonCmm.getLang("M.하시겠습니까", "B.SAVE");
		confirm(msg, function(r){
			if(r){
				var params = $("#form1").serializeJSON();
				if(params.stuEmailUid != ""){
					//-- 기존 데이터 삭제 먼저 실행
					paragonCmm.callAjax("/paragon/def/defstumail/DefStuMail/deleteData/json",params, function(json){
						paragonCmm.callAjax("/paragon/def/defstumail/DefStuMail/insert/json",params, function(json){
							initArea();
							initRightArea();
						});
					});
				}else{
					paragonCmm.callAjax("/paragon/def/defstumail/DefStuMail/insert/json",params, function(json){
						initArea();
						initRightArea();
					});
				}
			}
		});
	}
	var harfRightArea = function(){

		$("#stuEmailUid").val("");
		$("#recRole").val("C_EUIROE");
		$("#recRoleCd").val("");
		$("#recRoleNm").val("");
		$("#recUserCd").val("");
		$("#recUserNm").val("");
		$("#recRole_td").html("");
		$("#recUser_td").html("");
		$("#refRole").val("C_EUIROE");
		$("#refRoleCd").val("");
		$("#refRoleNm").val("");
		$("#refUserCd").val("");
		$("#refUserNm").val("");
		$("#refRole_td").html("");
		$("#refUser_td").html("");
	}

	//--right init
	var initRightArea = function(){
		$("#stuDtl").val("");
		$("#stuEmailUid").val("");
		$("input:radio[name=smsUseYn]").eq(0).prop("checked", false);
		$("input:radio[name=smsUseYn]").eq(1).prop("checked", true);
		$("#smsTypeCd").val("");
		$("#smsMessage").val("");
		harfRightArea();
		$("#titKo").val("");
		$("#titEn").val("");
		$("#titJa").val("");
		$("#titZh").val("");
		$("#contentKo").val("");
		$("#contentEn").val("");
		$("#contentJa").val("");
		$("#contentZh").val("");
		$("#titKo").removeAttr("disabled");
		$("#titEn").removeAttr("disabled");
		$("#titJa").removeAttr("disabled");
		$("#titZh").removeAttr("disabled");
		$("#contentKo").removeAttr("disabled");
		$("#contentEn").removeAttr("disabled");
		$("#contentJa").removeAttr("disabled");
		$("#contentZh").removeAttr("disabled");

	}
	var drawToSuChamStruct = function(type,val,nam){
		//초기화
		$("#"+type+"_td").html("");
		console.log(type+":"+val+":"+nam);

		if(val ==  undefined || val == "")return false;
		if(nam ==  undefined || nam == "")return false;
		var arrVal = val.split(",");
		var arrNam = nam.split(",");
		for(var i=0; i < arrVal.length; i++){
			var selVal = arrVal[i];
			var selTxt = arrNam[i];
			var imgTxt = "<img src=\"/css/themes/default/images/_ico/close_popup.gif\" style=\"cursor:pointer;vertical-align:baseline\" onclick=\"javascript:$(this).parent().remove();stuMailWrite.setCdNms('"+type+"');\">";
			var htmlTxt = "<div>"+selTxt+"<input type=\"hidden\" name=\""+type+"_cd\" value=\""+selVal+"\"><input type=\"hidden\" name=\""+type+"_nm\" value=\""+selTxt+"\">"+imgTxt+"</div>";
			$("#"+type+"_td").append(htmlTxt);
		}

		setCdNms(type);
	}
	var drawToDetail = function(jsonData){
		var data = jsonData;
		initRightArea();
		$("#stuEmailUid").val(data[0].stuEmailUid);
		$("#stuDtl").val(data[0].stuDtl);
		$("#titKo").val(data[0].titKo);
		$("#titEn").val(data[0].titEn);
		$("#titJa").val(data[0].titJa);
		$("#titZh").val(data[0].titZh);
		$("#contentKo").val(data[0].contentKo);
		$("#contentEn").val(data[0].contentEn);
		$("#contentJa").val(data[0].contentJa);
		$("#contentZh").val(data[0].contentZh);
		drawToSuChamStruct('recRole',data[0].recRoleCd,data[0].recRoleNm);
		drawToSuChamStruct('recUser',data[0].recRoleCd,data[0].recUserNm);
		drawToSuChamStruct('refRole',data[0].refRoleCd,data[0].refRoleNm);
		drawToSuChamStruct('refUser',data[0].refRoleCd,data[0].refUserNm);

	}
	var drawToLeftStruct = function(data){
		var jsonData = data;

		$("#event_tbody").html("");
		if(jsonData[0]){
			$("[data-col='stuTp2LangCd']").append(paragonCmm.getLang(jsonData[0].stuTp2LangCd));
			$("[data-col='stuBaseNm']").append(paragonCmm.getLang(jsonData[0].stuBaseNm));
			$("[data-col='stuCd']").append(jsonData[0].stuCd);
			$("[data-col='procTpLangCd']").append(paragonCmm.getLang(jsonData[0].procTpLangCd));

			for(var i = 0; i< jsonData.length; i++){
				var title = paragonCmm.getLang(jsonData[i].stuDtlLangCd) +":"+ jsonData[i].recRoleNm;
				if(title == ""){
					title = paragonCmm.getLang(jsonData[i].stuDtlLangCd) +":"+jsonData[i].recUserNm;
				}
		   		var htmlTxt = "<div id=\""+jsonData[i].stuEmailUid+"\">"+title+"<input type=\"hidden\" name=\"role_val\" value=\""+jsonData[i].loginId+"\">"+imgTxt+"</div>";
				var imgTxt = "<img src=\"/css/themes/default/images/_ico/close_popup.gif\" style=\"cursor:pointer;vertical-align:baseline\" onclick=\"javascript:stuMailWrite.removeEvent('"+jsonData[i].stuEmailUid+"');\">";
				var trE = document.createElement("tr");
				var tdE = document.createElement("td");
				$(tdE).css("text-align","left");
				var aE = document.createElement("a");
				aE.href="javascript:void(0)";
				$(aE).attr("onClick","stuMailWrite.setDetail('"+jsonData[i].stuEmailUid+"')");
				$(aE).text(title);

				$(tdE).append(aE);
				$(tdE).append(imgTxt);
				$(trE).append(tdE);
		   		$("#event_tbody").append($(trE));
		    }
		}
	}
	var setDetail = function(defNo){
		var data = {};
		data["stuEmailUid"] = defNo;
		//-- left Area
		paragonCmm.callAjax("/paragon/def/defstumail/DefStuMail/list/json",data, function(json){
			drawToDetail(json.data);
		});
	}
	var initArea = function(){
		var data = {};
		data["stuCd"] = $("#stuCd").val()
		//-- left Area
		paragonCmm.callAjax("/paragon/def/defstumail/DefStuMail/list/json",data, function(json){
			drawToLeftStruct(json.data);
		});
		//-- right Area
		initRightArea();
	}
	var chkRoll = function(type,val){
		var obj = $("#"+type+"_td").find("input:hidden");
		var bool = true;
		$(obj).each(function(){
			if($(this).val() == val){
				bool = false;
			}
		})

		return bool;
	}
	var setCdNms = function(type){
		if(type ==  undefined || type == "" )return false;
		var cds = "";
		var nms = "";
		$("input[name='"+type+"_cd']").each(function(i, e){
			cds += (cds == "") ? $(e).val() : ","+$(e).val() ;
		});
		$("input[name='"+type+"_nm']").each(function(i, e){
			nms += (nms == "") ? $(e).val() : ","+$(e).val() ;
		});
		$("input[name='"+type+"Cd']").val(cds);
		$("input[name='"+type+"Nm']").val(nms);
	}
	var addRole = function(obj, type){
		var selVal = $(obj).val();
		if(selVal != null && selVal != ""){
			if(chkRoll(type,selVal)){
				var selTxt = $(obj).find("option:selected").text();
				var imgTxt = "<img src=\"/css/themes/default/images/_ico/close_popup.gif\" style=\"cursor:pointer;vertical-align:baseline\" onclick=\"$(this).parent().remove(); stuMailWrite.setCdNms('"+type+"');\">";
				var htmlTxt = "<div>"+selTxt+"<input type=\"hidden\" name=\""+type+"_cd\" value=\""+selVal+"\"><input type=\"hidden\" name=\""+type+"_nm\" value=\""+selTxt+"\">"+imgTxt+"</div>";
				$("#"+type+"_td").append(htmlTxt);
			}
		}
		setCdNms(type);
	}
	var init = function(){
		htmlUtils.getCodeSelectOpt({
			targetId:"stuDtl",
			parentCd:"SOL_STU_TYPE",
			initdata:"|"+paragonCmm.getLang("L.CBO_SELECT"),
			valNm:"cdAbb",
			txtNm:"langCd"
		}); //-- 솔루션구분 select 로드
		htmlUtils.getCodeSelectOpt({
			targetId:"recRole",
			parentCd:"USER_ROLE",
			initdata:"|"+paragonCmm.getLang("L.CBO_SELECT"),
			valNm:"cdAbb",
			txtNm:"langCd"
		}); //-- 솔루션구분 select 로드
		htmlUtils.getCodeSelectOpt({
			targetId:"refRole",
			parentCd:"USER_ROLE",
			initdata:"|"+paragonCmm.getLang("L.CBO_SELECT"),
			valNm:"cdAbb",
			txtNm:"langCd"
		}); //-- 솔루션구분 select 로드

		//-- Left Right 초기화
		initArea();
		//-- 이벤트 등록
		attchmentEvent();
	}
	return{
		init:init,
		setDetail:setDetail,
		addRole:addRole,
		doSubmit:doSubmit,
		harfRightArea:harfRightArea,
		removeEvent:removeEvent,
		setCdNms:setCdNms
	}
}
var stuMailWrite = new StuMailWrite();
stuMailWrite.init();

</script>