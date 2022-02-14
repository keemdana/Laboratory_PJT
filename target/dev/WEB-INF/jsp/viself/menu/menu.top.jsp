<%@page import="com.vertexid.commons.utils.HtmlUtil"%>
<%@page import="com.vertexid.spring.utils.CmmProperties"%>
<%@page import="com.vertexid.commons.utils.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.vertexid.spring.utils.BaseProperties"%>
<%@page import="com.vertexid.commons.utils.CommonConstants"%>
<%@page import="com.vertexid.viself.hr.SysLoginVO"%>
<%@ page import="com.vertexid.spring.utils.SessionUtils" %>
<%@ page import="com.vertexid.viself.hr.SysLoginVO" %>
<%
SysLoginVO loginUser =     (SysLoginVO) SessionUtils.getLoginVO();
String siteLocale = loginUser.getSiteLocale();
%>

<form name="menuForm"  method="post" style="margin:0; padding:0;">
<div id="menuForm" >
</div>
</form>
	<!--header 시작-->
    <div class="wrap_div">
    	<!-- ## TOP ## -->
    	<div class="div_top">
        	<div class="top_area">
        		<div style="margin:0px auto; padding:0px; width:1280px; height:70px;">
	        	<h1>
	        		<span onclick="TOP.goHome();" style="cursor:pointer; font-size: 40px; font-weight: bold;" >
	        			LMS
	        		</span>
	        	</h1>
                <div class="top_menu_area">
                    <!-- TOP MENU -->

                    <ul>
						<% if (StringUtil.isNotBlank(CmmProperties.getOperationMode())){ %>
						<li>
<!-- 							<span class="ui_btn small icon"><i class="fa fa-list-ul" onclick="javascript:paragonCmm.openWindow('/ServletController?AIR_ACTION=SYS_SERVLET&AIR_MODE=POPUP_LIST',1024,600,'Serverlet',true,true);"><a href="javascript:void(0)" >Servlet</a></i></span> -->
							<span class="ui_btn small icon"><i class="fa fa-list-ul" onclick="TOP.sampleStuWrt()"><a href="javascript:void(0)" >문서작성샘플</a></i></span>
							<span class="ui_btn small icon"><i class="fa fa-list-ul" onclick="paragonCmm.openWindow('/viself/mlang/mLangMngList.popup',1024,600,'Lang List',true,true);"><a href="javascript:void(0)" >언어사전</a></i></span>
<!-- 							<span class="ui_btn small icon"><i class="fa fa-list-ul" onclick="javascript:paragonCmm.openWindow('/btn_sample.jsp',1024,600,'Btn List',true,true);"><a href="javascript:void(0)" >버튼샘플</a></i></span> -->
						</li>
						<% } %>
                        <li class="point_text">
                        	<strong style="padding-right: 2px;"><%=loginUser.getGroupName()%></strong>&nbsp;<strong><%=loginUser.getName()%></strong>
                        </li>

                        <!-- <li> -->
						<% if ("Y".equals(BaseProperties.get("fnc.schPwd.useYn"))) { %>
						<li onclick="doChgPW();" class="pwedit" data-term="L.비밀번호변경">
                            <%=StringUtil.getLocaleWord("L.비밀번호변경", siteLocale)%>
                        </li>
                        <% } %>
                        <%-- 추후 필요 시 사용하기로 하여 주석처리함(2020-09-03)
						<a href="javascript:void(0);" onclick="goFAQ(document.search_form)" class="color02" data-term="L.FAQ"></a>
						--%>
						<% if (loginUser.isCmmAdmin()) { %>
						<li onclick="openServiceDesk();" class="service" data-term="L.고객센터">
						<%=StringUtil.getLocaleWord("L.고객센터",siteLocale) %>
						</li>
						<% } %>
						<li onclick="TOP.doLogout();" class="logout" data-term="L.로그아웃">
						<%=StringUtil.getLocaleWord("L.로그아웃",siteLocale) %>
                        </li>
                        <li>
                        <% if("Y".equals(BaseProperties.get("fnc.changeLocale.useYn"))){ %>
					       <%=HtmlUtil.getSelect(true, "schSiteLocale", "schSiteLocale", "KO|한국어^EN|English", siteLocale, "style='heigth:30px;' onchange='changeSiteLocale(this.options[this.selectedIndex].value);'")%>
				        <% } %>
						</li>
                    </ul>

                    <!-- TOP MENU -->
                	</div>
                </div>
                <div style="margin:5px 0px 0px 0px; padding:0px; height:50px;/*  background:#47819e;  border-bottom:1px solid #aa5b70; */border-top: 2px solid #aa5b70;">
                	<!-- NAV -->
                    <div id="nav">
                      <ul id="main-menu"  class="main-menu">
                      </ul>
                    </div>
                	<!-- NAV -->
                </div>
            </div>
        </div>
        <!-- ## TOP ## -->
      </div>
<script type="text/javascript">
function Menu(){
	var doLogout = function(){
		// window.top.location.href  = "/login/logoutProc";
		window.top.location.href  = "/logout";
	}
	var goHome = function(){
		window.top.location.href  = "/";
	}
	var sampleStuWrt = function(){
		var imsiForm = $("<form method='POST'>").attr("action","/paragon/def/defStuForm/stuFormWrite.popup");
		imsiForm.append($("<input type='hidden' name='stuCd'>").val("파티클 예제"));
		paragonCmm.openWindow("", "1024", "650", "POP_STU_WRITE_SAMPLE", "yes", "yes", "");
		imsiForm.attr("target","POP_STU_WRITE_SAMPLE");
		imsiForm.appendTo("body");
		imsiForm.submit();
		imsiForm.remove();
	}
	var goMenuPage2 = function(id){
		var json = $("#p_"+id).data("meaning");

		if(json){
			var $form = $("form[name='menuForm']");
			var $divMenuForm = $("#menuForm");
			var urlPath = "";
			$.each(json, function(key, val){
				console.log(key);
				if(key == "urlPath"){
					urlPath = json.urlPath;
				}


			});

			if(json.JSON_DATA != null){
				var jsonText = json.JSON_DATA;
				jsonText = jsonText.replaceAll("&#39;","\"");
				var jsonData = JSON.parse(jsonText);
				$(jsonData).each(function(i, e){
					$.each(e, function(key, val){
						$("<input type='hidden' name='"+key+"'>").val(val).appendTo($divMenuForm);
					})
				});
			}
			if($form.find("input:hidden[name='open_type']").val() == "POPUP"
			){


					paragonCmm.openWindow('' , 1024, 700, 'open_doc_write_'+id, 'yes', 'yes');
					$form.attr("target","open_doc_write_"+id);

			}
			if($form.find("input:hidden[name='open_type']").val() == "URL"
			){
				//paragonCmm.openWindow(data["AIR_ACTION"], 1024, 700, 'open_doc_write', 'yes', 'yes');
				$form.attr('action', urlPath);
				$form.removeAttr("target");
				$form.attr('target', '_blank');
				$form.submit();
				$divMenuForm.html("");
				return false;
			}

			$form.attr('action',urlPath);
			$form.submit();
			$divMenuForm.html("");
			$form.attr('target','_self');
		}

	}
	var loadMenu = function(){
		var data = {};
		paragonCmm.callAjax("/viself/menu/menuMng/list/json",data, function(json){
			var header = [];
			$(json.data).each(function(i, e){
				if("1" == e.levelNo){
					header.push("t_"+e.menuId);
					$("<li  id='t_"+e.menuId+"' >").append(paragonCmm.getLang(e.langCd)).appendTo($(".main-menu"));
				}else{
					if($("#t_"+e.parentMenuId).find("ul").length == 0){
						$("<ul class='sub-menu' id='p_"+e.parentMenuId+"' >").appendTo($("#t_"+e.parentMenuId));
						$("<li id='p_"+e.menuId+"' onclick=\"TOP.goMenuPage2('"+e.menuId+"')\">").data("meaning",e).append(paragonCmm.getLang(e.langCd)).appendTo("#p_"+e.parentMenuId);
					}else{
						$("<li id='p_"+e.menuId+"' onclick=\"TOP.goMenuPage2('"+e.menuId+"')\">").data("meaning",e).append(paragonCmm.getLang(e.langCd)).appendTo("#p_"+e.parentMenuId);
					}

				}
			});
		});
	}
	var replaceLang = function(){
		$("[data-term]").each(function(i, e){
			if($(e).props('tagName') == "IMG"){
				$(e).attr("title",paragonCmm.getLang($(e).data("term")));
			}else if($(e).props('tagName') == "LABEL"){
				$(e).attr("title",paragonCmm.getLang($(e).data("term")));
				$(e).append(paragonCmm.getLang($(e).data("term")));
			}else{
				$(e).append(paragonCmm.getLang($(e).data("term")));
			}
		});
	}
	var init = function(){
		<%if(!"KO".equals(siteLocale)){ //-- 영문일때 넓이 조정%>
			$(".total_area_usr").css({"position":"relative","width":"1600px","margin":"0 auto","min-height":"230px"});
			$("#jqxMenu").css({"height":"auto","visibility":"visible","outline":"none","background":"#ffffff","width":"1600px","margin":"0px auto"});
			$(".header_top").css({"line-height":"31px","text-align":"right","word-spacing":"-3px","width":"1600px","margin":"0 auto"});
			$(".total_area").css({"position":"relative","width":"1600px","margin":"0 auto","min-height":"230px"});
			$(".quick_menu").css({"position":"absolute","top":"15px","right":"39%","margin-right":"-720px","text-align":"left"});
			$(".contents").css({"position":"relative","width":"1600px","margin":"0 auto 40px","border-top":"2px solid #FFFFFF"});
			$(".content_body").css({"position":"relative","width":"1600px","display":"inline-block","margin-top":"30px","text-align":"left","margin-bottom":"80px"});
			$(".quick_menu2").css({"position":"absolute","top":"25px","right":"-17%","text-align":"left","border":"1px solid #cdcdcd","padding":"0px 15px 5px 15px"});
		<%}%>

		//-- 다국어 처리 시작
		//--전역상수 siteLocale 설정
		console.log(cmmLocalStorage.get("SITE_LOCALE"));
		if(cmmLocalStorage.get("SITE_LOCALE") != "<%=siteLocale%>"){
			cmmLocalStorage.set("SITE_LOCALE", "<%=siteLocale%>");
			var oldVersion =cmmLocalStorage.get("LANG_VERSION");
			paragonCmm.initLangStorage(oldVersion);		//-- 사이트 로케일이 변경되었을경우 다국어 Reload;
		}

		//-- 다국어 최종 버전 가져오기
		paragonCmm.callAjax("/viself/mlang/mLangUpdate/listMaxVersion/json",{}, function(json){
			var listMaxVersion = json.data[0].maxVersion
			var oldVersion =cmmLocalStorage.get("LANG_VERSION");
			if(oldVersion == undefined || oldVersion != listMaxVersion)	paragonCmm.initLangStorage(listMaxVersion);	//-- 최종 버전으로 로드
		});

		loadMenu();
// 		replaceLang();
	}

	return{
		init:init,
		goHome:goHome,
		loadMenu:loadMenu,
		doLogout:doLogout,
		goMenuPage2:goMenuPage2,
		sampleStuWrt:sampleStuWrt
	}
}
var TOP = new Menu();
TOP.init();
</script>