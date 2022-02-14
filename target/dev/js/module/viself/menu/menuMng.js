/*
 * @(#)codeMng.js    2019-12-10 오전 9:42
 *
 * Copyright (c) 2021 Vertex ID., KOREA
 * All rights reserved.
 *
 * This software is the confidential
 * and proprietary information of emFrontier.com ("Confidential Information").
 * You shall not disclose such Confidential Information
 * and shall use it only in accordance with
 * the terms of the license agreement you entered into
 * with Vertex ID. Networks
 */
/**
 * <b>Description</b>
 * <pre>
 *    메뉴 관리 화면
 * </pre>
 * @author 강세원
 */
"use strict";
function Menu() {

	var TREE_URL 		= "/viself/menu/menuMng/allList/json";
	var WRITE_URL 		= "/viself/menu/menuMngWrite.include";
	var treeAreaNm 		= "menuMngTreeArea";
	var $treeAreaId 	= $("#menuMngTreeArea");
	var $moduleModalId 	= $("#menuMngPop1");
	var $uuidPathId 	= $("#menuMngUuidPath");
	var $schValueId 	= $("#menuMngSchValue");
	var $schForm 		= $("#menuMngSchForm");
	var $mngFormId 		= $("#menuMngform1");
	var $menuId 		= $("#menuId");
	var $parentMenuId 	= $("#parentMenuId");
	var $setCaptionId 	= $("#txtNamePath");
	var $btnSchId 		= $("#menuSearchBtn");
	var $btnOneId 		= $("#menuMnglevelOne");
	var $btnModiId 		= $("#menuMngbtnModify");
	var $btnModiChildId = $("#menuMngbtnModify_child");

    var drawTree = function(){
		var arrDEPTH = [];
		if($uuidPathId.val() != ""){
			arrDEPTH = $uuidPathId.val().split("≫");
		}
		//tree 불러오기
		treeInitSet(TREE_URL,"MENU",JSON.stringify(arrDEPTH),'');

		//그려넣을 id, 루트id, 최종
	    treeDrawChild(treeAreaNm,null);
	}
    var doSearch = function(isCheckEnter) {
		if (isCheckEnter && event.keyCode != 13) {
			return;
		}
		if($schValueId.val() != ""){
			$treeAreaId.html("");
			treeDrawChild(treeAreaNm,"", paragonCmm.getSearchQueryParams(document.menuMngSchForm));
		}else{
			$treeAreaId.html("");
			treeDrawChild(treeAreaNm,"null","");
		}
	}
    var selectNode = function(menu_id){
		var codGrp = $("#"+menu_id);
		var obj = codGrp.children("input:hidden");
		var jsonData = "";
		$(obj).each(function(i, d){
			if(i > 0){jsonData+=",";}
			jsonData+= $(this).attr("name")+":\""+$(this).val()+"\"";
			$("#"+$(this).attr("name") , $mngFormId).text($(this).val())

			if("menuId" == $(this).attr("name")){
				$("#"+$(this).attr("name") , $mngFormId).val($(this).val())
			}

			if("parentMenuId" == $(this).attr("name")){
				$("#"+$(this).attr("name") , $mngFormId).val($(this).val())
			}
			if("langCd" == $(this).attr("name")){
				$setCaptionId.text(paragonCmm.getLang($(this).val()));
			}
		});

		//-- 시스템 전용 코드일 경우 수정/삭제 버튼 디스플레이 처리
		$btnOneId.hide();
		$btnModiId.show();
		$btnModiChildId.show();
	};

	var goModify = function(frm,updateMode) {

		if ($menuId.val() == "" && updateMode != "ONE") {
			alert(airCommon.getLang("M.ALERT_SELECT","수정할 메뉴정보"));
			return;
		}
		if("ONE" == updateMode){
			updateMode = "CHILD"
			$parentMenuId.val();
		}
		var params = $(frm).serializeJSON();
		params.updateMode = updateMode;
		params.langCd = "L.시스템메뉴관리";
		main.movePage(WRITE_URL,params );
	}
	var attchmentEvent = function(){

		$schValueId.off();
		$schValueId.on("keyup",function(){
    		doSearch(true);
    		return false;
    	});
		$btnSchId.off();
		$btnSchId.on("click", function(){
    		doSearch();
    		return false;
    	});
		$btnOneId.off();
		$btnOneId.on("click", function(){
    		goModify($mngFormId,'ONE');
    		return false;
    	});
		$btnModiId.off();
		$btnModiId.on("click", function(){
    		goModify($mngFormId,'');
    		return false;
    	});
		$btnModiChildId.off();
		$btnModiChildId.on("click", function(){
    		goModify($mngFormId,'CHILD');
    		return false;
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
var MENU = new Menu();
	$(document).ready(function () {

	    console.info("[Loading Module: 메뉴관리].....................");

	    MENU.init();
	}());
