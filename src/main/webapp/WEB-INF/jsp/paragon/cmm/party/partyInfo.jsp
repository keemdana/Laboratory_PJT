<%@page import="com.vertexid.commons.utils.CommonConstants"%>
<%@page import="com.vertexid.viself.hr.SysLoginVO"%>
<%@ page import="com.vertexid.spring.utils.SessionUtils" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
SysLoginVO loginUser =     (SysLoginVO) SessionUtils.getLoginVO();
String siteLocale = loginUser.getSiteLocale();
%>
<script type="text/javascript" src="/js/vendor/jquery-easyui/extension/datagrid-cellediting/datagrid-cellediting.js"></script>
<!-- // Content // -->
<form id="form1" name="form1" method="post" onsubmit="return false;">
<p>
    <table class="box">
	    <tr>
	        <td class="corner_lt"></td><td class="border_mt"></td><td class="corner_rt"></td>
	    </tr>
	    <tr>
	        <td class="border_lm"></td>
	        <td class="body">
	            <table>
	                <colgroup>
	                    <col width="10%" />
	                    <col width="25%" />
	                    <col width="20%" />
	                    <col width="30%" />
	                    <col />
	                </colgroup>
	                <tr>
	                	<th data-term="L.업체명"></th>
						<td>
							<input type="text" name="partyNmKo" id="partyNmKo" data-type="search" onkeydown="doSearch(document.form1, true)" maxlength="30" class="text width_max" />
						</td>
		                <th>
      					   	<span class="ui_btn medium icon" id="partySearchBtn"><i class="fa fa-search" onclick="doSearch(document.form1);"><a href="javascript:void(0)" data-term="B.SEARCH"></a></i></span>
						</th>
	                </tr>
	            </table>
	        </td>
	        <td class="border_rm"></td>
	    </tr>
	    <tr>
	        <td class="corner_lb"></td><td class="border_mb"></td><td class="corner_rb"></td>
	    </tr>
    </table>
</form>
		<div class="buttonlist">
			<div class="left">
				<span style="width:50%;padding-top:5px;"><input type = "text" id="party_nm_ko" name = "party_nm_ko" class="text" onKeyUp="goInsert(true);" placeholder="L.업체명_한글" data-term="L.업체명_한글" /></span>
	          	<span class="ui_btn small icon"><i class="fa fa-pencil"><a data-term="B.REG"></a></i></span>
	          	<span class="ui_btn small icon"><i class="fa fa-minus"><a data-term="B.DELETE"></a></i></span>
            </div>
            <div class = "right">
	          	<span class="ui_btn small icon" id="gsbProc"><i class="fa fa-check"><a class="btn_search" data-term="B.처리"></a></i></span>
            </div>
      	</div>
      <div>
      	<div id="partySelectArea" style="width:100%;height:auto; min-height:40px; border: 1px #C8C8E3 solid;  overflow:hidden;
        border:1px solid lightgray;" ></div>
      </div>
    <br>
    <table id="partyInfoList" class="easyui-datagrid"
            style="width:auto;height:auto">
    <thead>
    <tr>
		<th data-options="field:'partyUid',width:0,hidden:true"></th>
		<th data-options="field:'chk',width:40,align:'center',checkbox:true"></th>
<!--         <th data-options="field:'vendorNo',width:100,halign:'center',editor:'text',align:'center'">Vendor No</th> -->
        <th data-options="field:'partyNmKo',width:200,halign:'center',editor:'text',align:'center'" ><span data-term="L.업체명_한글"></span></th>
        <th data-options="field:'partyNmEn',width:100,halign:'center',editor:'text',align:'center'" ><span data-term="L.업체명_영문"></span></th>
        <th data-options="field:'corpRegNo',width:100,halign:'center',editor:'text',align:'center'" ><span data-term="L.사업자등록번호"></span></th>
     </tr>
    </thead>
    </table>
<p></p>


<script type="text/javascript">
function PartyInfo(){

	var doSearch = function(isCheckEnter){
		if (isCheckEnter && event.keyCode != 13) {
	        return;
	    }
		$("#partyInfoList").datagrid("load", paragonCmm.getSearchQueryParams());
	}
	var goInsert = function(isCheckEnter){

		if (isCheckEnter && event.keyCode != 13) {
	        return;
	    }
		confirm(paragonCmm.getLang("M.하시겠습니까","L.저장"), function(r){
			if(r){
				var gsb_Nam = $("#partyNmKo").val();
				if(gsb_Nam != ''){
					var data = {};
					data["partyNmKo"] =gsb_Nam;
					paragonCmm.callAjax("LMS_PARTY_MAS", "INSERT",data, function(json){
						if(null == json.MSG){
							$("#party_nm_ko").val("");				//-- 입력글자 초기화
							$('#partyInfoList').datagrid('reload'); 	//-- 그리드 리스트 리로드
						}else{
							alert(json.MSG);
						}
					});
				}else{
					alert("명칭을 입력하지 않으셨습니다.");
				}
			}
		})
	}
	var reject = function(){
		$('#partyInfoList').datagrid('rejectChanges');
	}
	var goDelete = function(){
		var rows = $("#partyInfoList").datagrid("getChecked");
		if(rows.length == 0){
			alert(paragonCmm.getLang("M.삭제할대상체크해주세요"));
		}else{
			confirm(paragonCmm.getLang("M.하시겠습니까","L.삭제"),function(r){
				if(r){
					var Delete_uuids = "&_UUIDS=";
					//삭제하려는 값의 uuid를 수집
					$.each(rows, function(i){
						if(i>0) Delete_uuids += "/";
						Delete_uuids += rows[i]["partyUid"]
					});
					console.log(Delete_uuids);
					paragonCmm.callAjax("LMS_PARTY_MAS", "DELETE", Delete_uuids, function(json){
						$('#partyInfoList').datagrid('reload');
						$("#partySelectArea").empty();
					});
				}
			});
		}
	}
	var modifyLang = function(row,index,changes){
		var UID = row["PARTY_UID"];
		$.ajax({
			url: "/ServletController?AIR_ACTION=&AIR_MODE=UPDATE&PARTY_UID="+UID
			, type: "POST"
			, dataType: "json"
			, data: changes
		})
		.done(function(data) {

			if(Object.keys(data).length > 0){
				doSearch(document.form1);
			}else{
				alert("동일한코드명이존재합니다");
				reject();
			}
	    })
	    .fail(function() {
	    });
	}
	var loadGrid = function(){
		$('#partyInfoList').css('width','100%');
		$('#partyInfoList').datagrid({
			singleSelect:true,
			striped:true,
			fitColumns:true,
			rownumbers:true,
			multiSort:true,
			pagination:true,
			pagePosition:'bottom',
			nowrap:false,
			loadFilter:paragonCmm.easyuiLoadFilter,
	 		url:'/paragon/cmm/party/PartyInfo/list/json',
	 		method:"post",
	      	queryParams:paragonCmm.getSearchQueryParams(),
	      	onBeforeLoad:function() { paragonCmm.showBackDrop(); },
	      	onLoadSuccess:function() {
				paragonCmm.hideBackDrop()
				$(this).datagrid('resize');
// 				, paragonCmm.gridResize();
			},
			onLoadError:function() { paragonCmm.hideBackDrop(); },
			onAfterEdit:function(index,row, changes){
		    	if(Object.keys(changes).length > 0){//객체의 키의 갯수(IE:8은 동작안함) air-Common.js에 대응 코딩함..
		    		var message = paragonCmm.getLang("M.값_변경_저장");
		    		confirm(message, function(r){
			    		if(r){
				    		modifyLang(row,index,changes );
			    		}else{
			    			reject()
			    		}
		    		})
		    	}
		    },
		    onBeforeEdit:function(index,row){
		    	var currentText= row["partyNmKo"];
				var currentUuid= row["partyUid"];

				$('#partyInfoList').datagrid('checkRow',index);
				if($("#"+currentUuid).length ==0){

					var $span = $("<span>").attr("id",row["partyUid"]).css({"padding-right":"10px","display":"inline-block"});
					$span.text(currentText);

					var $btnSpan = $('<span class="ui_btn medium icon">');
					var $iSpan = $('<i class="fa fa-window-close">').css("margin-left","3px");
					$iSpan.on("click",function(){
						$("#"+row["partyUid"],$("#partySelectArea")).remove();
					});

					$btnSpan.append($iSpan);
					$span.append($iSpan);

					$("#partySelectArea").append($span);

				}
		    },
			onCheck:function(index,row){

				var currentText= row["partyNmKo"];
				var currentUuid= row["partyUid"];

				if($("#"+currentUuid).length ==0){

					var $span = $("<span>").attr("id",row["partyUid"]).css({"padding-right":"10px","display":"inline-block"});
					$span.text(currentText);
					$span.data("row",row);
					var $btnSpan = $('<span class="ui_btn medium icon">');
					var $iSpan = $('<i class="fa fa-window-close">').css("margin-left","3px");
					$iSpan.on("click",function(){
						$("#"+row["partyUid"],$("#partySelectArea")).remove();
					});
					$btnSpan.append($iSpan);
					$span.append($iSpan);

					$("#partySelectArea").append($span);

				}
			},
			onCheckAll:function(rows){
				$.each(rows, function(i, row){
					var currentText= row["partyNmKo"];
					var currentUuid= row["partyUid"];
					if($("#"+currentUuid).length ==0){

						var $span = $("<span>").attr("id",row["partyUid"]).css({"padding-right":"10px","display":"inline-block"});
						$span.text(currentText);
						$span.data("row",row);
						var $btnSpan = $('<span class="ui_btn medium icon">');
						var $iSpan = $('<i class="fa fa-window-close">').css("margin-left","3px");
						$iSpan.on("click",function(){
							$("#"+row["partyUid"],$("#partySelectArea")).remove();
						});
						$btnSpan.append($iSpan);
						$span.append($iSpan);

						$("#partySelectArea").append($span);

					}
				});
			}
		});
		$(window).bind('resize', paragonCmm.gridResize);
		<%if(loginUser.isUserAuth("LMS_BCD,LMS_BJD")){	//-- 법무담당자 권한일경우에만 수정%>
		$('#partyInfoList').datagrid('enableCellEditing').datagrid('gotoCell', {
		    index: 0,
		    field: 'partyNmKo'

		});
		<%}%>
	}
	var attchmentEvent = function(){
		$("#partySearchBtn").off();	//-- 이벤트 초기화
		$("#partySearchBtn").on("click",function(){
			doSearch();
		});
		$("input:text[data-type='search']", "#form1").off();
		$("input:text[data-type='search']", "#form1").on("keyup",function(){
			doSearch(true);
		});
		$("#gsbProc").off();
		$("#gsbProc").on("click",function(){
			var row = [];
			var spans = $("span", "#partySelectArea");

			$(spans).each(function(i, e){
				var json ={};
				row.push($(e).data("row"));
			});
			if(typeof setCallback === "function"){
				setCallback(row);
			}

		});
	}

	var setCallback ;

	/**
	* 초기화 설정
	*	initFunc : 기 선택된 업체정보 선택상태로 셋팅
	*	callbackFunc : 선택 완료된 데이트를 Callback 함수에 전송
	*/
	var init = function(initFunc, callbackFunc){
		attchmentEvent();
		loadGrid();
		if(typeof callbackFunc === "function"){
			setCallback = callbackFunc;
		}

		//--초기 데이터 셋팅
		if(typeof initFunc === "function"){
			try{
				var initData = initFunc();
				if(initData.hasOwnProperty("nam") && initData.nam != ""){
					var arrNam = initData.nam.split(",");
					var arrCod = initData.cod.split(",");
					$(arrNam).each(function(i){
						var $span = $("<span>").attr("id",arrCod[i]).css("padding-right","10px");
						$span.text(arrNam[i]);
						var $btnSpan = $('<span class="ui_btn medium icon">');
						var $iSpan = $('<i class="fa fa-window-close">')
							$iSpan.on("click",function(){
							$("#"+arrCod[i],$("#partySelectArea")).remove();
						});
						$btnSpan.append($iSpan);
						$span.append($iSpan);

						$("#partySelectArea").append($span);
					});
				}

			}catch(e){
				console.log(e);
			}

		}
	}
	return{
		init:init
	}
}
var partyInfo = new PartyInfo();
</script>
