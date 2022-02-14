<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.vertexid.commons.utils.CommonConstants"%>
<%@page import="com.vertexid.viself.hr.SysLoginVO"%>
<%@ page import="com.vertexid.spring.utils.SessionUtils" %>
<%@ page import="com.vertexid.viself.hr.SysLoginVO" %>
<%
SysLoginVO loginUser =     (SysLoginVO) SessionUtils.getLoginVO();
String siteLocale = loginUser.getSiteLocale();
%>
        <style>
			/*
			html{box-sizing:border-box}*,*:before,*:after{box-sizing:inherit}
			html{-ms-text-size-adjust:100%;-webkit-text-size-adjust:100%}body{margin:0; font-size:12px;}
			ul, li{list-style:none; margin:0px; padding:0px;}

			.main_wrap{margin:0px; padding:0px;}
			.top{margin:0px; padding:10px; height:55px; border-bottom:1px solid #CCC; position:relative; background:#5e5e5e;}
			.logo{margin:-3px 0 0 20px; padding:0 0 0 0; font-size:28px; font-weight:bold; float:left; color:#fff;}
			.text_right{margin:2px 30px 0 0px; float:right; font-size:13px; line-height:36px; color:#fff;}

			.con_area{margin:0px; padding:0px; position:absolute; top:55px; left:0px; right:0px; bottom:0px;}
			.left_box{margin:0px; padding:0px; display:inline-block; width:230px; position:absolute; top:0px; bottom:0px; background:#333;}
			.right_box{margin:0px; padding:10px; display:inline-block; position:absolute; top:0px; left:230px; bottom:0px; right:0px;}

 			.menu_off,.menu:hover{color:#F90!important;background-color:#333!important}
			.menu_on,.menu:hover{color:#FF0!important;background-color:#c62f24!important}

			.nav_wrap{margin:0px; padding:10px 0 0 0px; width:230px;}
			i.right{float: right; margin: 5px 10px 0px 0px;}
			p.btn{display:block; cursor:pointer; margin:10px 0 0 0px; padding:5px 10px; text-align:left; border:none; font-weight:bold;}
			ul.nav{list-style:none; margin:0px; padding:0px; }
			ul.nav li{list-style-type:none; padding:5px; margin:0; display:block; color:#CCC; cursor:pointer; font-weight:bold; background:#2a2a2a;}
			ul.nav li:hover{color:#FF0;}
			 */
			/*
			html{box-sizing:border-box}*,*:before,*:after{box-sizing:inherit}
			html{-ms-text-size-adjust:100%;-webkit-text-size-adjust:100%}body{margin:0; font-size:12px;}
			ul, li{list-style:none; margin:0px; padding:0px;}

			.main_wrap{margin:0px; padding:0px;}
			.top{margin:0px; padding:10px; height:55px; border-bottom:1px solid #CCC; position:relative; background:#5e5e5e;}
			.logo{margin:-3px 0 0 20px; padding:0 0 0 0; font-size:28px; font-weight:bold; float:left; color:#fff;}
			.text_right{margin:2px 30px 0 0px; float:right; font-size:13px; line-height:36px; color:#fff;}

			.con_area{margin:0px; padding:0px; position:absolute; top:55px; left:0px; right:0px; bottom:0px;}
			.left_box{margin:0px;padding:0px;display:inline-block;width:230px;position:absolute;top:0px;bottom:0px;background: #383838;}
			.right_box{margin:0px; padding:10px; display:inline-block; position:absolute; top:0px; left:230px; bottom:0px; right:0px;}


 			.menu_off,.menu:hover{color: #fff!important;background-color: #383838!important;}
			.menu_on,.menu:hover{color:#FF0!important;background-color: #464646!important;}

			.nav_wrap{margin:0px; padding:10px 0 0 0px; width:230px;}
			i.right{float: right; margin: 5px 10px 0px 0px;}
			p.btn{display:block;cursor:pointer;margin:10px 0 0 0px;padding:5px 10px;text-align:left;border:none;font-size: 15px;font-weight:bold;}
			ul.nav{list-style:none; margin:0px; padding:0px; }
			ul.nav li{list-style-type:none;padding:5px;margin:0;display:block;color:#CCC;cursor:pointer;font-weight:bold;background: #464646;}
			ul.nav li:hover{color:#FF0;}
			 */
			html{box-sizing:border-box}*,*:before,*:after{box-sizing:inherit}
			/* Extract from normalize.css by Nicolas Gallagher and Jonathan Neal git.io/normalize */
			html{-ms-text-size-adjust:100%;-webkit-text-size-adjust:100%}body{margin:0; font-size:12px;}
			ul, li{list-style:none; margin:0px; padding:0px;}

			.main_wrap{margin:0px; padding:0px;}
			.top{margin:0px;padding:10px;height: 40px;border-bottom:1px solid #CCC;position:relative;background: #22242a;}
			.logo{margin: -10px 0 0 20px;padding:0 0 0 0;font-size: 28px;font-weight:bold;float:left;color:#fff;}
			.text_right{margin: -6px 30px 0 0px;float:right;font-size:13px;line-height:36px;color:#fff;}

			.con_area{margin:0px; padding:0px; position:absolute; top:39px; left:0px; right:0px; bottom:0px;}
			.left_box{margin:0px;padding:0px;display:inline-block;width:230px;position:absolute;top:0px;bottom:0px;background: #383838;}
			.right_box{margin:0px; padding:10px; display:inline-block; position:absolute; top:0px; left:230px; bottom:0px; right:0px; overflow: auto;}
			.bottom_box{margin:0px; padding:10px; display:inline-block; position:absolute; left:230px; bottom:0px; right:0px;}


 			.menu_off,.menu:hover{color: #fff!important;background-color: #383838!important;}
			.menu_on,.menu:hover{color:#FF0!important;background-color: #464646!important;}

			.nav_wrap{margin:0px; padding:10px 0 0 0px; width:230px;}
			i.right{float: right; margin: 5px 10px 0px 0px;}
			p.btn{display:block;cursor:pointer;margin:10px 0 0 0px;padding:5px 10px;text-align:left;border:none;font-size: 15px;font-weight:bold;}
			ul.nav{list-style:none; margin:0px; padding:0px; }
			ul.nav li{list-style-type:none;padding:5px;margin:0;display:block;cursor:pointer;font-weight:bold;background: #505050;color:#CCC;}
			ul.nav li:hover{color:#FF0;}
			.copyright_wrap{position:absolute;bottom:10px;padding: 10px;color: #b3b3b3; }
		</style>
<form name="menuForm"  method="post" style="margin:0; padding:0;">
<div id="menuForm" >
</div>
</form>
<div class="main_wrap">
	<div class="top">
    	<ul class="top_box">
        	<li class="logo">Paragon</li>
            <li class="text_right">
            	<span class="ui_btn small icon"><i class="fa fa-list-ul"><a href="javascript:void(0)" >문서작성샘플</a></i></span>
				<span class="ui_btn small icon"><i class="fa fa-list-ul" onclick="paragonCmm.openWindow('/viself/mlang/mLangMngList.popup',1024,600,'Lang List',true,true);"><a href="javascript:void(0)" >언어사전</a></i></span>
            	<strong style="padding-right: 2px;"><%=loginUser.getDspNmKo()%></strong>
				<span class="ui_btn medium icon" style="background-color: yellow ;border: 1px solid yellow;"  id="logout"><i class="fa fa-sign-out-alt"><a href="javascript:void(0)" data-term="L.로그아웃"></a></i></span>
            </li>
        </ul>
    </div>
    <div class="con_area">
        <div class="left_box">
            <!-- ############## -->
            <div class="nav_wrap">
            	<p class="btn menu_on" id="dashBoard">Dashboard</p>
            </div>
            <!-- ############## -->
            <div class="copyright_wrap">
            	Copyright©Vertex ID<br/>All Rights Reserved.
            </div>
        </div>
        <div class="right_box content_body">
            <!-- ############## -->
            Dashboard
            <!-- ############## -->
        </div>
	</div>
</div>
<script>
var Main = function(){
	var doMenuClick = function(json){
		if(json){
			var $form = $("form[name='menuForm']");
			var $divMenuForm = $("#menuForm");
			var urlPath = "";
			if(json.hasOwnProperty("urlPath")){
				urlPath = json.urlPath;
			}

			if(json.JSON_DATA != null){
				var jsonText = json.JSON_DATA;
				jsonText = jsonText.replaceAll("&#39;","\"");
				var jsonData = JSON.parse(jsonText);

				$.extend(json,jsonData);

			}
			var isPopup = false;
			if(json.hasOwnProperty("open_type")){
				if(json.open_type === "POPUP"){
					isPopup = true;
				}
			}

			if(isPopup){
				var imsiForm = $("<form method='POST'>").attr("action",urlPath);
				$(json).each(function(i, e){
					$.each(e, function(key, val){
						imsiForm.append($("<input type='hidden' name='"+key+"'>").val(val));
					})
				});
				imsiForm.append($("<input type='hidden' name='_csrf'>").val($("meta[name='_csrf']").attr("content")));
				paragonCmm.openWindow("", "1024", "650", "POP_"+json.menuId, "yes", "yes", "");
				imsiForm.attr("target","POP_"+json.menuId);
				imsiForm.appendTo("body");
				imsiForm.submit();
				imsiForm.remove();

			}else{

				$(".right_box").load(urlPath+".include",json,function(){
					setTimeout(function(){
						$(".right_box").height($(".left_box").height());
						paragonCmm.convertLang($(".right_box"));
					},200);
				})
			}
			console.log($(".right_box").height());
			$(".right_box").outerHeight($(".left_box").outerHeight());
			console.log($(".right_box").height());
		}
	}
	var loadMenu = function(){
		var data = {};
		paragonCmm.callAjax("/viself/menu/menuMng/list/json",data, function(json){
			$(json.data).each(function(i, e){
				if("1" == e.levelNo){
					$("<p class='btn menu_off'  data-id='"+e.menuId+"' >")
						.append(paragonCmm.getLang(e.langCd))
						.append($("<i class='right fa fa-angle-left'/>"))
						.appendTo($(".nav_wrap"));
					$("<div data-parent='"+e.menuId+"' class='w3-hide' style='display:none;'>")
						.append($("<ul class='nav'>"))
						.appendTo($(".nav_wrap"));
				}else{

					var li = $("<li data-id='"+e.menuId+"'>").data("meaning",e).append(paragonCmm.getLang(e.langCd));
					$("div[data-parent='"+e.parentMenuId+"'] ul").append(li);

					$(li).on("click",function(){
						var json = $(this).data("meaning");
						doMenuClick(json);
					});
				}
			});
		});
	}

	var attchmentEvent = function(){
		$(".nav_wrap p").on("click", function(){
			var cls = $(this).attr("class");
			if(cls.lastIndexOf("on") > -1){
				$(this).attr("class", "btn menu_off");
				$(this).find("i").attr("class", "right fa fa-angle-left");
				$("div[data-parent='"+$(this).data("id")+"']").attr("class","w3-hide").hide(300);
			}else{
				//-- 기존 열림 닫기
				$(".w3-show").attr("class", "w3-hide").hide(300);
				$(".menu_on").find("i").attr("class", "right fa fa-angle-left");
				$(".menu_on").attr("class", "btn menu_off");
				$(this).attr("class", "btn menu_on");
				$(this).find("i").attr("class", "right fa fa-angle-left fa-rotate-270");
				$("div[data-parent='"+$(this).data("id")+"']").attr("class","w3-show").show(300);
			}
			if($(this).attr("id") == "dashBoard"){
				//TODO 데시보드 호출
			}
		});
		$("#logout").on("click",function(){
			location.href = "/logout";
		});
		//-- 리사이즈 이벤트
		$(window).bind('resize', function(){
			console.log($(".right_box").height());
			$(".right_box").outerHeight($(".left_box").outerHeight());
			console.log($(".right_box").height());
			$(".easyui-tabs").tabs('resize');		//-- tab resize
			$('.datagrid-f').datagrid('resize');	//-- data-grid resize
		});

	}
	var init = function(){
		loadMenu();
		attchmentEvent();
	}
	return{
		init:init
	}
}
var main = new Main();
main.init();
</script>
