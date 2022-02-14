<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- <%=SysStaticDataController.sysNoLang.toString() %> --%>
<script type="text/javascript" src="/js/vendor/jquery-easyui/extension/datagrid-cellediting/datagrid-cellediting.js"></script>
<style>
    .datagrid-header {
        font-weight: bold;
    }
</style>

<div class="row mt">
	<h5 class="sub1_title" data-term="L.다국어관리"><i class="fa fa-file-text"></i> </h5>
	<div class="col-md-12 col-sm-12">
		<div class="white-panel pn-sub1-top donut-chart">
			<div class="white-header">
				<!-- Search AREA -->
			<form id="mLangMngForm" method="post">
                <div class="row sub1_search">
                	<div class="col-md-11">
                		<div class="row">
                			<div class="col-md-12 col-sd-12">
                				<span data-tp="th" data-term="L.코드"></span>
								<input type="text" name="langCd" value="" class="form-control input-sm" data-type="search" />
                			</div>
                		</div>
                		<div class="row">
                			<div class="col-md-4 col-sd-4" style="text-align:left;">
								<span data-tp="th">KO</span>
								<input type="text" name="ko" value="" class="form-control input-sm" data-type="search" />
							</div>
                			<div class="col-md-4 col-sd-4" style="text-align:left;">
								<span data-tp="th">EN</span>
								<input type="text" name="en" value="" class="form-control input-sm" data-type="search" />
							</div>
                			<div class="col-md-4 col-sd-4" style="text-align:left;">
								<span data-tp="th">JA</span>
								<input type="text" name="ja" value="" class="form-control input-sm" data-type="search" />
							</div>
                		</div>
                		<div class="row">
                			<div class="col-md-4 col-sd-4" style="text-align:left;">
								<span data-tp="th">ZH</span>
								<input type="text" name="zh" value="" class="form-control input-sm" data-type="search" />
							</div>
                			<div class="col-md-8 col-sd-8" style="text-align:left;">
								<span data-tp="th">Type</span>
								<label class="radio-inline" ><input type="radio" name="TYPE" id="TYPE_1" value=""  data-type="search"  onClick="MLANG.doSearch()" checked/> 전체</label>
								<label class="radio-inline" ><input type="radio" name="TYPE" id="TYPE_2" value="L"  data-type="search" onClick="MLANG.doSearch()" /> 라벨</label>
								<label class="radio-inline" ><input type="radio" name="TYPE" id="TYPE_3" value="M" data-type="search"  onClick="MLANG.doSearch()" /> 메시지</label>
								<label class="radio-inline" ><input type="radio" name="TYPE" id="TYPE_4" value="B"  data-type="search" onClick="MLANG.doSearch()" /> 버튼</label>
								<label class="radio-inline" ><input type="radio" name="TYPE" id="TYPE_5" value="R"  data-type="search" onClick="MLANG.doSearch()" /> 라디오</label>
								<label class="radio-inline" ><input type="radio" name="TYPE" id="TYPE_6" value="D"  data-type="search" onClick="MLANG.doSearch()" /> 문서</label>
								<label class="radio-inline" ><input type="radio" name="TYPE" id="TYPE_&" value="C"  data-type="search" onClick="MLANG.doSearch()" /> 코드</label>
							</div>
						</div>
                	</div>
                	<div class="col-md-1">
                        <button type="button" class="btn btn-default btn-block" onclick="MLANG.doInit(document.form1)" data-term="B.INIT"><i class="fa fa-refresh"></i> </button>
                    	<button type="button" class="btn btn-primary btn-block" onclick="MLANG.doSearch();" data-term="B.SEARCH"><i class="fa fa-search"></i> </button>
                    </div>
                </div>
              </form>
			</div>
		</div>
	</div>
</div>
<div class="row mt">
	<div class="col-md-6 col-sm-6 donut-chart" style="text-align: left;">
		<select name="ADD_TYPE" id="ADD_TYPE" class="form-control input-sm" style="width:80px;display: inline-block;">
			<option value="l">라벨</option>
			<option value="M">메시지</option>
			<option value="B">버튼</option>
			<option value="R">라디오</option>
			<option value="D">문서</option>
			<option value="C">코드</option>
		</select>
		<input type="text" id="ADD_CODE" class="form-control input-sm" size="40" onkeydown="MLANG.doProc(true)" style="width:180px;display: inline-block;"/>
		<span class="ui_btn medium icon"><i class="fa fa-plus" onclick="void(0);"><a href="javascript:void(0);" onClick="MLANG.doProc();" data-term="B.ADD"></a></i></span>
	</div>
	<div class="col-md-6 col-sm-6 donut-chart" style="text-align: right;">
		<span class="ui_btn medium icon" id="openPopup" style="display:none;"><i class="fa fa-list-ul" onClick="paragonCmm.openWindow('/viself/mlang/mLangMngList.popup',1024,700,'Lang List',true,true);"><a href="javascript:void(0);">POPUP</a></i></span>
	</div>
	<div class="col-md-12 col-sm-12">
		<div class="white-panel pn-sub1-table donut-chart">
			<table id="listTable" class="easyui-datagrid"
				data-options="singleSelect:true,
							  striped:true,
							  fitColumns:false,
							  rownumbers:true,
							  multiSort:true,
							  pagination:true,
							  selectOnCheck:false,
							  checkOnSelect:false,
							  url:'',
							  method:'post'"
				style="height:auto">
				<thead>
				<tr>
					<th data-options="field:'langUid',width:0,hidden:true"></th>
					<th data-options="field:'langCd',width:300,halign:'CENTER',align:'LEFT',editor:'text',sortable:true">코드</th>
					<th data-options="field:'ko',width:300,halign:'CENTER',align:'LEFT',editor:'text',sortable:true">KO</th>
					<th data-options="field:'en',width:300,halign:'CENTER',align:'LEFT',editor:'text',sortable:true">EN</th>
					<th data-options="field:'ja',width:300,halign:'CENTER',align:'LEFT',editor:'text',sortable:true">JA</th>
					<th data-options="field:'zh',width:300,halign:'CENTER',align:'LEFT',editor:'text',sortable:true">ZH</th>
				</tr>
			</table>
		</div>
	</div>
</div>

<!--
<div class="content-panel p-3 site-min-height">
   <h3><i class="fa fa-angle-right" id="content_header" data-term="L.다국어코드"> </i></h3>
	<div>
		<form name="form1" method="post">
		<table class="box">
		<tr>
			<td class="corner_lt"></td>
			<td class="border_mt"></td>
			<td class="corner_rt"></td>
		</tr>
		<tr>
			<td class="border_lm"></td>
			<td class="body">
				<table>
						<colgroup>
							<col style="width:10%" />
							<col style="width:32%" />
							<col style="width:15%" />
							<col style="width:32%" />
							<col style="width:*" />
						</colgroup>
						<tr>
							<th>코드</th>
							<td colspan="3"><input type="text" name="langCd" tabindex="1"  ID="langCd" onkeydown="MLANG.doSearch(true)" value="" data-type="search" class="text width_max" style="width:98.3%;" /></td>
							<td rowspan="4" class="verticalContainer">
									<span class="ui_btn medium icon"><i class="fa fa-search" onclick="MLANG.doSearch();"><a href="javascript:void(0);" style="width:31px;">검색</a></i></span>
									<span class="ui_btn medium icon"><i class="fa fa-minus" onclick="MLANG.doInit(document.form1)"><a href="javascript:void(0)"  >리셋</a></i></span>
							</td>
						</tr>
						<tr>
							<th>KO</th>
							<td><input type="text" class="text width_max" name="ko" id="ko" tabindex="2" onkeydown="MLANG.doSearch(true)" data-type="search"/></td>
							<th>EN</th>
							<td><input type="text" class="text width_max" name="en" id="en" tabindex="3"  onkeydown="MLANG.doSearch(true)" data-type="search"/></td>
						</tr>
						<tr>
							<th>JP</th>
							<td><input type="text" class="text width_max" name="ja" id="ja" onkeydown="MLANG.doSearch(true)" data-type="search"/></td>
							<th>CN</th>
							<td><input type="text" class="text width_max" name="zh" id="zh" onkeydown="MLANG.doSearch(true)" data-type="search"/></td>
						</tr>
						<tr>
							<th>Type</th>
							<td colspan="3" style="padding-top:5px;">
								<input type="radio" name="TYPE" id="TYPE_1" value=""  data-type="search"  onClick="MLANG.doSearch()" checked/>전체
								<input type="radio" name="TYPE" id="TYPE_2" value="L"  data-type="search" onClick="MLANG.doSearch()" />라벨
								<input type="radio" name="TYPE" id="TYPE_3" value="M" data-type="search"  onClick="MLANG.doSearch()" />메시지
								<input type="radio" name="TYPE" id="TYPE_4" value="B"  data-type="search" onClick="MLANG.doSearch()" />버튼
								<input type="radio" name="TYPE" id="TYPE_5" value="R"  data-type="search" onClick="MLANG.doSearch()" />라디오
								<input type="radio" name="TYPE" id="TYPE_6" value="D"  data-type="search" onClick="MLANG.doSearch()" />문서
								<input type="radio" name="TYPE" id="TYPE_&" value="C"  data-type="search" onClick="MLANG.doSearch()" />코드
							</td>
						</tr>
				</table>
				</td>
			<td class="border_rm"></td>
		</tr>
		<tr>
			<td class="corner_lb"></td>
			<td class="border_mb"></td>
			<td class="corner_rb"></td>
		</tr>
		</table>
		</form>
		<div class="buttonlist">
				<div class="left">
					<select name="ADD_TYPE" id="ADD_TYPE" style="border:1px solid #CCC9E1; padding:2px; width:120px;">
						<option value="l">라벨</option>
						<option value="M">메시지</option>
						<option value="B">버튼</option>
						<option value="R">라디오</option>
						<option value="D">문서</option>
						<option value="C">코드</option>
					</select>
					<input type="text" class="text" id="ADD_CODE" style="margin-top:1px; padding:3px;" size="40" onkeydown="MLANG.doProc(true)"/>
					<span class="ui_btn medium icon"><i class="fa fa-plus" onclick="void(0);"><a href="javascript:void(0);" onClick="MLANG.doProc();" data-term="B.ADD"></a></i></span>
				</div>
				<div class="right">
					<span class="ui_btn medium icon" id="openPopup" style="display:none;"><i class="fa fa-list-ul" onClick="paragonCmm.openWindow('/viself/mlang/mLangMngList.popup',1024,700,'Lang List',true,true);"><a href="javascript:void(0);">POPUP</a></i></span>
				</div>
			</div>
			<table id="listTable" class="easyui-datagrid"
				data-options="singleSelect:true,
							  striped:true,
							  fitColumns:false,
							  rownumbers:true,
							  multiSort:true,
							  pagination:true,
							  pageList:[10,50,100,200],
							  pagePosition:'bottom',
							  selectOnCheck:false,
							  checkOnSelect:false,
							  url:'',
							  method:'post'"
				style="height:auto">
				<thead>
				<tr>
					<th data-options="field:'langUid',width:0,hidden:true"></th>
					<th data-options="field:'langCd',width:300,halign:'CENTER',align:'LEFT',editor:'text',sortable:true">코드</th>
					<th data-options="field:'ko',width:300,halign:'CENTER',align:'LEFT',editor:'text',sortable:true">KO</th>
					<th data-options="field:'en',width:300,halign:'CENTER',align:'LEFT',editor:'text',sortable:true">EN</th>
					<th data-options="field:'ja',width:300,halign:'CENTER',align:'LEFT',editor:'text',sortable:true">JA</th>
					<th data-options="field:'zh',width:300,halign:'CENTER',align:'LEFT',editor:'text',sortable:true">ZH</th>
				</tr>
			</table>
		</div>
</div>
-->
<script>
	function Mlang(){

		var $form = $("#mLangMngForm");
		var doSearch = function(isCheckEnter){
			if (isCheckEnter && event.keyCode != 13) {
				return;
			}
			$("#listTable").datagrid("load", paragonCmm.getSearchQueryParams($form));
		}
		var modifyLang = function(row,index,changes){
			changes["langUid"] = row["langUid"];
			$.ajax({
				url: "/viself/mlang/mLangMng/updateData/json"
				, type: "POST"
				, dataType: "json"
				, data: changes
			})
			.done(function(data) {

				if(Object.keys(data).length > 0){
					doSearch();
				}else{
					alert("동일한코드명이존재합니다");
					reject();
				}
		    })
		    .fail(function() {
		    });
		}
		var doInit = function(frm){
			frm.reset();
		}
		var doProc = function(isCheckEnter){
			if (isCheckEnter && event.keyCode != 13) {
				return;
			}
			var msg = paragonCmm.getLang("M.저장내용");
			confirm(msg, function(r){
				if($("#ADD_CODE").val() != "" && r){
					var data = {};
					data["langCd"] = $("#ADD_TYPE").val() + "." + $("#ADD_CODE").val()
					$.ajax({
						url: "/viself/mlang/mLangMng/saveData/json"
						, type: "POST"
						, dataType: "json"
						, data: data
					})
					.done(function(data) {
						if(Object.keys(data).length > 0){
							alert("처리되었습니다.");

							$("#ko").val("");
							$("#en").val("");
							$("#zh").val("");
							$("#ja").val("");
							$("#langCd").val($("#ADD_CODE").val());
							$("#ADD_CODE").val("");
							$("input:radio[name='TYPE']").eq(0).prop("checked",true);
							doSearch();
						}else{
							alert(paragonCmm.getLang("M.동일한코드가존재합니다확인해주세요"));
						}

				    })
				    .fail(function() {
				    	alert(paragonCmm.getLang("M.처리중_오류발생","L.수정"));
				    });
				}
			});
		}
		var reject = function(){
		    $('#listTable').datagrid('rejectChanges');
		}

		var getGridHeight = function () {
			var ENURI = 390;
			var SCH_HEIGHT = 0; //$searchFrm.innerHeight();
			var windowHeight = window.innerHeight;
			return windowHeight - SCH_HEIGHT - ENURI;
		};

		var getPageSize = function(){
			var gHeight = getGridHeight();

			console.log(gHeight);
			if(getGridHeight() > 500){
				return 20;
			}
			return 10;
		};

		var loadGrid = function(){
			$('#listTable').datagrid({
				url:'/viself/mlang/mLangMng/list/json',
				loadFilter:paragonCmm.easyuiLoadFilter,
				height: getGridHeight(),
				pageSize: getPageSize(),
				onBeforeLoad:function() { paragonCmm.showBackDrop(); },
				onLoadSuccess:function(json) {
					paragonCmm.hideBackDrop();
				},
				onLoadError:function() { paragonCmm.hideBackDrop(); },
				 onAfterEdit:function(index,row, changes){
				    	if(Object.keys(changes).length > 0){//객체의 키의 갯수(IE:8은 동작안함) air-Common.js에 대응 코딩함..
				    		var message = paragonCmm.getLang("M.값_변경_저장");
				    		confirm(message, function(r){
								console.log(r);
				    			if(r){
						    		modifyLang(row,index,changes );
					    		}else{
					    			reject()
					    		}
				    		})
				    	}
				    }
			});

			$('#listTable').datagrid('enableCellEditing').datagrid('gotoCell', {
			    index: 0,
			    field: 'langCd'

			});
		}
		var setEvent = function(){
			$("input:text", $form).off();
	        $("input:text", $form).on("keyup", function(e){
	        	doSearch(true);
	        	return false;
	        });
		}
		var init = function(){
			$('#listTabs-LIST').css('width','100%');
			loadGrid();
			if(opener){
				$(window).bind('resize', $('.datagrid-f').datagrid('resize'));
			}else{
				$("#openPopup").show();
			}

			setEvent();
		}
		return{
	    	init : init,
	    	loadGrid:loadGrid,
	    	doProc:doProc,
	    	doSearch:doSearch
	    }
	}
	var MLANG;

	$(document).ready(function(){
		MLANG = new Mlang();
		MLANG.init();
	});
</script>