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
 *    코드 관리 화면
 * </pre>
 * @author 강세원
 */
"use strict";

	function CodeMng() {
		var opt = {
				"selectType":"",	// 최하위자식만 선택가능 null 값이면 부모도 선택 가능
				"parentCd":"ROOT"				// 최초 부모 코드
		};
	    var drawTree = function(){
			var arrDEPTH = [];
			if($("#selCdPath").val() != ""){
				arrDEPTH = $("#selCdPath").val().split("≫");
			}
			//tree 불러오 air-action, air-mode 값 셋팅
			treeInitSet("/viself/code/codeMng/listCode/json","CODE",JSON.stringify(arrDEPTH),'');

			//그려넣을 id, 루트id, 최종
		    treeDrawChild("codeTreeArea",opt.parentCd);
		}
	    var changeCodeView = function(json) {
			var data = JSON.parse(json);
			$("#codeMngform1 input:hidden[name='cd']").val(data.cd);
			$("#codeMngform1 input:hidden[name='parentCd']").val(data.parentCd);

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
			document.getElementById("selCdPath").value 	= paragonCmm.convertForView(data.cdPath);

			//-- 시스템 전용 코드일 경우 수정/삭제 버튼 디스플레이 처리
			var btnModifyObj = document.getElementById("codeMngBtnModify");
			var btnModify_childObj = document.getElementById("codeMngBtnModify_child");
			var btnDeleteObj = document.getElementById("codeMngBtnDelete");

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
//			$("#codeMngPop1").window({
//				iconCls:'icon-search',
//			    width:1024,
//			    height:800,
//			    title:paragonCmm.getLang("L.코드관리"),
//			    href:"/viself/code/codeMngWrite.modal",
//			    method:"POST",
//			    queryParams:{},
//			    modal:true,
//			    onLoad:function(){
//			    	CODDWRITE.init(function(){
//			    		return params;
//			    	},
//			    	function(){
//			    		$("#codeMngPop1").window("close");
//			    	});
//			    	paragonCmm.convertLang($("#codeMngPop1")); 			//-- 다국어 처리
//			    }
//			});
			main.movePage("/viself/code/codeMngWrite.include",params );

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
					var params = $("#codeMngform1").serializeObject();
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
					            $("#codeTreeArea").html("");
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
			        });

				}
			});
		}
	    var doSearch = function(isCheckEnter){
	    	if (isCheckEnter && event.keyCode != 13) {
				return;
			}
			if($("#schValue").val() != ""){
				$("#codeTreeArea").html("");
				var query = paragonCmm.getSearchQueryParams(document.codeMngSchForm);
				query.parentCd = opt.parentCd;
				treeDrawChild("codeTreeArea",opt.parentCd, query);
			}else{
				$("#codeTreeArea").html("");
				treeDrawChild("codeTreeArea",opt.parentCd,"");
			}
	    }
	    var attchmentEvent = function(){
	    	$("#codeMngSchValue").off();
	    	$("#codeMngSchValue").on("keyup",function(){
	    		doSearch(true);
	    	});
	    	$("#cdSearchBtn").off();
	    	$("#cdSearchBtn").on("click", function(){
	    		doSearch();
	    	});
	    	$("#codeMngBtnWrite").off();
	    	$("#codeMngBtnWrite").on("click", function(){
	    		goModify(document.codeMngform1,'ONE');
	    	});
	    	$("#codeMngBtnModify").off();
	    	$("#codeMngBtnModify").on("click", function(){
	    		goModify(document.codeMngform1,'');
	    	});
	    	$("#codeMngBtnModify_child").off();
	    	$("#codeMngBtnModify_child").on("click", function(){
	    		goModify(document.codeMngform1,'CHILD');
	    	});
	    	$("#codeMngBtnDelete").off();
	    	$("#codeMngBtnDelete").on("click", function(){
	    		goDelete(document.codeMngform1);
	    	});
	    }
		var init = function () {
			attchmentEvent();
			$("#codeTreeArea").html("");
			drawTree();
	    };
	    return{
	    	init : init,
	    	selectNode:selectNode
	    }
	}
	var CODE = new CodeMng();
	$(document).ready(function () {

	    console.info("[Loading Module: 코드관리].....................");

	    CODE.init();
	}());
