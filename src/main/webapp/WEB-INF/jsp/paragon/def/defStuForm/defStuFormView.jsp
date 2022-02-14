<%@page import="com.vertexid.commons.utils.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.vertexid.commons.utils.CommonConstants"%>
<%@page import="com.vertexid.viself.hr.SysLoginVO"%>
<%@ page import="com.vertexid.spring.utils.SessionUtils" %>
<%@ page import="com.vertexid.viself.hr.SysLoginVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	SysLoginVO loginUser 	=     (SysLoginVO) SessionUtils.getLoginVO();
	String siteLocale			= loginUser.getSiteLocale();
	String capitalizeSiteLocale = StringUtil.capitalize(siteLocale.toLowerCase());// ko >> Ko
%>
<div id="<c:out value="${param.docUid}"/>_stuFormView">
	<input type="hidden" name="isProd" id="isProd" value="<c:out value="${isProd}"/>" />
	<input type="hidden" name="stuCd" id="<c:out value='${param.docUid}'/>_stuCd" value="<c:out value="${param.stuCd}"/>" />
	<input type="hidden" name="docUid" id="<c:out value='${param.docUid}'/>_docUid" value="<c:out value="${param.docUid}"/>" />
	<input type="hidden" name="solMasUid" id="<c:out value='${param.docUid}'/>_solMasUid" value="<c:out value="${param.solMasUid}"/>"/>
	<div id="<c:out value="${param.docUid}"/>_viewParticleArea"></div>
	<br/>
	<table class="basic">
		<tr class="<c:out value='${param.docUid}'/>_memoArea" style="display:none;">
			<th class="th4" data-term="L.작성자"></th>
			<td class="td4" id="<c:out value='${param.docUid}'/>_wrtNm">
			</td>
			<th class="th4" data-term="L.작성일"></th>
			<td class="td4" id="<c:out value='${param.docUid}'/>_wrtDte">
			</td>
		</tr>
		<tr class="<c:out value='${param.docUid}'/>_memoArea" style="display:none;">
			<th class="th2" data-term="L.메모" id="<c:out value='${param.docUid}'/>_memoAreaTit"></th>
			<td class="td2" colspan="3" id="<c:out value='${param.docUid}'/>_memo">
			</td>
		</tr>
		<tr id="<c:out value='${param.docUid}'/>_fileArea" style="display:none;">
			<th class="th2" data-term="L.첨부파일" ></th>
			<td class="td2" colspan="3" id="<c:out value='${param.docUid}'/>_fileAreaId"></td>
		</tr>
	</table>


	<!-- 사후점검 건 수정기능 -->
	<c:if test="${param.stuCd eq 'SM_REPORT'}">
		<div class="buttonlist" >
			<div class="right" id="<c:out value='${param.docUid}'/>_btnProcArea">
				<%if((loginUser.getAuthCd()).indexOf("CMM_SYS") > 0 || (loginUser.getAuthCd()).indexOf("IMS_CHR") > 0){ %>
				<span id="UPDATE_<c:out value='${param.docUid}'/>" class="ui_btn medium icon"><i class="fa fa-list"><a href="javascript:void(0)">수정</a></i></span>
				<%} %>
				<span class="ui_btn medium icon" id="StuCloseBtn"><i class="fa fa-window-close"><a href="javascript:void(0);" data-term="B.CLOSE"></a></i></span>	
			</div>
		</div>
		<br/>
	</c:if>
	<%-- <div class="buttonlist" >
		<div class="right" id="<c:out value='${param.docUid}'/>_btnProcArea">
			<span id="KKKKKK<c:out value='${param.docUid}'/>" class="ui_btn medium icon"><i class="fa fa-list"><a href="javascript:void(0)">수정</a></i></span>
		</div>
	</div> --%>
	<div id="aprv" style="width:600px;height:400px;display: none;" >
	</div>
</div>
<script type="text/javascript">

"use strict";
function StuFromView_<c:out value='${param.docUid}'/>(){
	var preFix 				= "<c:out value='${param.docUid}'/>";
	var docUid				= $("#"+preFix+"_docUid").val();
	var DEF_STU_URL 		= "/paragon/def/defstumng/DefStuMng/listOne/json";
	var dataCube    		= {}		//-- Data cube Master
	var $partiArea			= $("#"+preFix+"_viewParticleArea");
	var $solMasUid			= $("#"+preFix+"_solMasUid");
	var $stuCd				= $("#"+preFix+"_stuCd");
	var $wrtDte				= $("#"+preFix+"_wrtDte");
	var $wrtNm				= $("#"+preFix+"_wrtNm");
	var $memo				= $("#"+preFix+"_memo");
	var $memoArea			= $("."+preFix+"_memoArea");
	var $memoAreaTit		= $("#"+preFix+"_memoAreaTit");
	var $fileArea			= $("#"+preFix+"_fileArea");
	var fileAreaId			= preFix+"_fileAreaId";
	var attchmentEvent = function(){
		$("#UPDATE_"+docUid).on('click',function(){
			var imsiForm = $("<form method='POST'>").attr("action", "/paragon/def/defStuForm/defStuFormWrite.popup");
			imsiForm.append($("<input type='hidden' name='docUid'>").val('<c:out value="${param.docUid}"/>'));
			imsiForm.append($("<input type='hidden' name='solMasUid'>").val($solMasUid.val()));
			imsiForm.append($("<input type='hidden' name='stuCd'>").val($stuCd.val()));
			imsiForm.append($("<input type='hidden' name='mode'>").val('UPDATE'));
			imsiForm.append($("<input type='hidden' name='_csrf'>").val($("meta[name='_csrf']").attr("content")));

			var screenWidth = 1250; //screen.width;
			var screenHeight = 900;

			paragonCmm.openWindow("", screenWidth, screenHeight, "POP_PREVIEW_" , "yes", "yes", "");
			imsiForm.attr("target", "POP_PREVIEW_" );
			imsiForm.appendTo("body");
			imsiForm.submit();
			imsiForm.remove();
		} );
	}

	//--폼 정보 로드
	var loadForm = function(){
		var data = {};
		data["stuCd"] = $stuCd.val();
		paragonCmm.callAjax(DEF_STU_URL,data, function(json){
			if(json.errYn === "E"){
				alert(json.msg);//-- 오류처리
				return false;
			}
			if(json.data){

				//-- 메모/첨부 로드
				if(json.data[0].memoDspYn == "Y" ){
					//-- 메모영역 활성
					$memoArea.show();
					//-- 메모컬럼명 변경
					if(json.data[0].memoTitLangCd != ""){
						$memoAreaTit.html("");
						$memoAreaTit.removeAttr("data-term");
						$memoAreaTit.html(paragonCmm.getLang(json.data[0].memoTitLangCd));
					}
				}
				if( json.data[0].fileDspYn == "Y"){
					//-- 첨부파일 로드
					var options = {}
					options.relUid = preFix;			//-- 관계 키 UID
					options.fileTpCd = "CMM/CMM";		//-- 파일 유형 코드
					options.defaultRelUid = "";				//-- 기본 로드 첨부파일(수정시)
					htmlUtils.loadFileView(fileAreaId, options);	//-- 첨부파일 로드

					$fileArea.show();
				}

			}
		});
	}

	//-- 마스터 데이터 로드
	var loadData = function(){
		if("<c:out value="${param.docUid}"/>" != null && "<c:out value="${param.docUid}"/>" !=""){
			var data = {};
			data["docUid"] = "<c:out value="${param.docUid}"/>";
			paragonCmm.callAjax("/paragon/datacube/DataCube/listOne/json",data, function(json){
				if(json.data){
					console.log(json.data);
					$wrtDte.html(json.data[0].regDte)
					$wrtNm.html(json.data[0].regUserNm)
					$memo.html(paragonCmm.convertForView(JSON.parse(json.data[0].jsonData).docMemo));
					paragonCmm.formMap.get(docUid).docInfo = json.data[0];
					paragonCmm.formMap.get(docUid).jsonData = JSON.parse(json.data[0].jsonData);
				}
			});
		}
	}
	var loadParticle = function(){
		var data = {};
		data["stuCd"] = $("#<c:out value='${param.docUid}'/>_stuCd").val();
		paragonCmm.callAjax("/paragon/def/defstumng/DefStuParti/list/json",data, function(json){
			var maxLen = $(json.data).length;
			$(json.data).each(function(i, e){
				if("false" == $("#isProd").val()){
					$partiArea.append($("<font color=\"#DDDDDD\">++시작 : "+e.patiMngNo+" : "+e.patiNm+"++</font>"));
				}
				$partiArea.append("<br>");
				var $div = $("<div>").attr("id", e.patiMngNo);
				var url = e.patiJspViewPath+".include";
				//-- 파티클 로드
				$partiArea.append(
					$div.load(url,{docUid:"<c:out value="${param.docUid}"/>",stuCd:e.stuCd},function(){
						if(i == (maxLen - 1)){	//-- 모든 파티클 로드 완료 후 다국어 Convert 실행
							setTimeout(function(){
								paragonCmm.convertLang($partiArea);
							},200);
						}
					})
				);
			});
		});
	}
	var init = function(){
		var obj ={
				jsonData:{}
				,docInfo:{}
				,setTmpValiFunc:[]
				,setValiFunc:[]
		}
		//-- formMap에 초기 데이터 추가
		paragonCmm.formMap.set(docUid,obj);
		loadForm();
		loadData();
		loadParticle();
		attchmentEvent();

	}
	return{
		init:init
	}
}
var stuFromView_<c:out value='${param.docUid}'/> = new StuFromView_<c:out value='${param.docUid}'/>();
$(document).ready(function () {
	stuFromView_<c:out value='${param.docUid}'/>.init();
}());

//닫기
$('#StuCloseBtn').on("click",function(){
		self.close();
});
</script>