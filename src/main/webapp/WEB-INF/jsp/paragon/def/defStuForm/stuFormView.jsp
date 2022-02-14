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
<div id="stuFormView<c:out value="${param.docUid}"/>">
	<input type="hidden" name="stuCd" id="<c:out value='${param.docUid}'/>_stuCd" value="<c:out value="${param.stuCd}"/>" />
	<input type="hidden" name="docUid" id="<c:out value='${param.docUid}'/>_docUid" value="<c:out value="${param.docUid}"/>" />
	<input type="hidden" name="solMasUid" id="<c:out value='${param.docUid}'/>_solMasUid" value="<c:out value="${param.solMasUid}"/>"/>
	<div id="viewParticleArea<c:out value='${param.docUid}'/>">
	</div>
	<div class="buttonlist">
		<div class="right" id="btnProcArea">
		</div>
	</div>
	<div id="aprv" style="width:600px;height:400px;display: none;" >
	</div>
</div>
<script type="text/javascript">

"use strict";

var jsonView<c:out value='${param.docUid}'/>    = {}		//-- Json Data
function StuFromView_<c:out value='${param.docUid}'/>(){
	var POST_FIX = "<c:out value='${param.docUid}'/>";
	var obj = {
		prnt 			: "#stuFormView" +POST_FIX
		,particleArea	: "#viewParticleArea"+POST_FIX
	}
	var dataCube    = {}		//-- Data cube Master

	var attchmentEvent = function(){
// 		$("#patiType1").on("change",function(){
// 			getSysPatiGbnCode("patiType2", $(this).val());
// 		});
	}
	//-- 마스터 데이터 로드
	var loadData = function(){
		if("<c:out value="${param.docUid}"/>" != null && "<c:out value="${param.docUid}"/>" !=""){
			var data = {};
			data["docUid"] = "<c:out value="${param.docUid}"/>";
			paragonCmm.callAjax("/paragon/datacube/DataCube/listOne/json",data, function(json){
				if(json.data){
					jsonView<c:out value="${param.docUid}"/> = JSON.parse(json.data[0].jsonData);
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
				if("false" == $("#isProd",obj.prnt).val()){
					$(obj.particleArea).append($("<font color=\"#DDDDDD\">++시작 : "+e.patiMngNo+" : "+e.patiNm+"++</font>"));
				}
				$(obj.particleArea).append("<br>");
				var $div = $("<div>").attr("id", e.patiMngNo);
				var url = e.patiJspViewPath+".include";
				//-- 파티클 로드
				$(obj.particleArea).append(
					$div.load(url,{docUid:"<c:out value="${param.docUid}"/>"},function(){
						if(i == (maxLen - 1)){	//-- 모든 파티클 로드 완료 후 다국어 Convert 실행
							setTimeout(function(){
								paragonCmm.convertLang($(obj.particleArea));
							},200);
						}
					})
				);
			});
		});
	}
	var init = function(){
		attchmentEvent();
		loadData();
		loadParticle();

	}
	return{
		init:init
	}
}
var stuFromView_<c:out value='${param.docUid}'/> = new StuFromView_<c:out value='${param.docUid}'/>();
stuFromView_<c:out value='${param.docUid}'/>.init();

</script>