<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="row mt">
	<h5 class="sub1_title" data-term="L.솔루션상태정의"><i class="fa fa-file-text"></i> </h5>
	<div class="col-md-12 col-sm-12">
		<div class="white-panel pn-sub1-top donut-chart">
			<div class="white-header">
				<form id="form1" name="form1" method="post">
                <div class="row sub1_search">
                	<div class="col-md-11">
                		<div class="row">
                			<div class="col-md-3 col-sd-3">
                				<span data-tp="th" data-term="법무구분"></span>
<!--                 				<select name="stuType" id="stuType" class="form-control input-sm" style="width:100px;"></select> -->
                			</div>
                			<div class="col-md-3 col-sd-3">
                				<span data-tp="th">순번</span>
                				<input type="text" name="ordNoGteq" id="ordNoGteq" class="form-control input-sm" style="width:100px;" data-type="search" > ~
                				<input type="text" name="ordNoLteq" id="ordNoLteq" class="form-control input-sm" style="width:100px;" data-type="search" >
                			</div>
                			<div class="col-md-3 col-sd-3">
                				<span data-tp="th" >상태코드</span>
                				<input type="text" name="schStuCd" id="schStuCd" class="form-control input-sm" style="width:200px;" data-type="search" >
                			</div>
                			<div class="col-md-3 col-sd-3">
                				<span data-tp="th" >기본상태명</span>
                				<input type="text" name="stuBaseNm" id="stuBaseNm" class="form-control input-sm" style="width:200px;" data-type="search" >
                			</div>
                		</div>
                	</div>
                	<div class="col-md-1">
                    	<button type="button" class="btn btn-primary " onclick="STUMNG.doSearch();" data-term="B.SEARCH"><i class="fa fa-search"></i> </button>
                    </div>
                </div>
              </form>
			</div>
		</div>
	</div>
</div>
<div class="row mt">
T:임시저장<br/>
			A:결재<br/>
			D:삭제<br/>
			S:처리<br/>
			P:상태만 변경<br/>
			X:단독작성(프로세스와 관련없는 기타문서 작성)<br/>
			K:다른 법무진행(법무>인장신청)<br/>
			O:URL 링크 팝업<br/>
	<div class="col-md-12 col-sm-12 donut-chart" style="text-align: right;">
		<button type="button" class="btn btn-default" id="delBtn" data-term="L.삭제"><i class="fa fa-minus"></i> </button>
		<button type="button" class="btn btn-default" id="addBtn" data-term="L.추가"><i class="fa fa-plus"></i> </button>
	</div>
	<div class="col-md-12 col-sm-12">
		<div class="white-panel pn-sub1-table donut-chart">
			<table class="list" id="StuMngTable">
				<thead >
				<tr>
					<th style="width:5%"   data-opt='{"align":"center"
														,"html":{"type":"checkbox"
																,"name":"chkStu"
																,"valueField":"stuCd"
														}
													}'>권한자</th>
					<th style="width:5%" data-opt='{"align":"center","col":"ordNo","onClick":"STUMNG.goView(\"@{stuCd}\")"}'>순번</th>
					<th style="width:10%" data-opt='{"align":"center","col":"stuTpLangCd","onClick":"STUMNG.goView(\"@{stuCd}\")"}'>법무구분1</th>
					<th style="width:10%" data-opt='{"align":"center","col":"stuTp2LangCd","onClick":"STUMNG.goView(\"@{stuCd}\")"}'>법무구분2</th>
					<th style="width:15%" data-opt='{"align":"center","col":"procTpLangCd","onClick":"STUMNG.goView(\"@{stuCd}\")"}'>처리구분</th>
					<th style="width:10%" data-opt='{"align":"center","col":"stuCd","onClick":"STUMNG.goView(\"@{stuCd}\")"}'>상태코드</th>
					<th style="width:10%" data-opt='{"align":"center","col":"stuBaseNm","onClick":"STUMNG.goView(\"@{stuCd}\")"}' >기본상태명</th>
					<th style="width:*" data-opt='{"align":"left","col":"stuDesc","onClick":"STUMNG.goView(\"@{stuCd}\")"}'>상태설명</th>
					<th style="width:65px" data-opt='{"align":"center","html":{"type":"BTN","class":"fa fa-pencil","callback":"STUMNG.goWrite(\"@{stuCd}\")","title":"B.WRITE"}}'></th>
				</tr>
				</thead>
				<tbody id="StuMngTableBody">
				</tbody>
			</table>
			<%-- 페이지 목록 --%>
			<div class="pagelist" id="StuMngTablePage"></div>
		</div>
	</div>
</div>
<%--


<div class="content-panel p-3 site-min-height">
    <h3><i class="fa fa-angle-right" id="content_header" data-term="L.솔루션상태정의"> </i></h3>
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
						<col style="width:8%" />
						<col style="width:8%" />
						<col style="width:8%" />
						<col style="width:30%" />
						<col style="width:8%" />
						<col style="width:10%" />
						<col style="width:8%" />
						<col style="width:10%" />
						<col style="width:auto" />
					</colgroup>
					<tr>
						<th>법무구분  :</th>
						<td >
							<select name="stuType" id="stuType"></select>
						</td>
						<th>순번  :</th>
						<td><input type="text" name="ORD_NO_GTEQ" value="" class="text" data-type="search"  onkeydown="STUMNG.doSearch(true)" />~<input type="text" name="ORD_NO_LTEQ" value=""  data-type="search" class="text"  onkeydown="doSearch(true)" /></td>
						<th>상태코드 :</th>
						<td><input type="text" name="schStuCd" value="" data-type="search" class="text" onkeydown="STUMNG.doSearch( true)" /></td>
						<th>기본상태명 :</th>
						<td><input type="text" name="STU_BASE_NM" value="" data-type="search" class="text" onkeydown="STUMNG.doSearch( true)" /></td>
						<td rowspan="2" class="verticalContainer">
							<span class="ui_btn medium icon"><i class="fa fa-search" onclick="STUMNG.doSearch();"><a href="javascript:void(0)"  data-term="B.SEARCH"></a></i></span>
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
			T:임시저장<br/>
			A:결재<br/>
			D:삭제<br/>
			S:처리<br/>
			P:상태만 변경<br/>
			X:단독작성(프로세스와 관련없는 기타문서 작성)<br/>
			K:다른 법무진행(법무>인장신청)<br/>
			O:URL 링크 팝업<br/>
			<div class="buttonlist">
				<div class="left">
				</div>
				<div class="right">
				    <span class="ui_btn medium icon" id="delBtn" ><i class="fa fa-minus" ><a href="javascript:void(0)" data-term="B.DELETE"></a></i></span>
					<span class="ui_btn medium icon" id="addBtn" ><i class="fa fa-plus"><a href="javascript:void(0)" data-term="B.ADD"></a></i></span>
				</div>
			</div>
			<table class="list" id="StuMngTable">
				<thead >
				<tr>
					<th style="width:5%"   data-opt='{"align":"center"
														,"html":{"type":"checkbox"
																,"name":"chkStu"
																,"valueField":"stuCd"
														}
													}'>권한자</th>
					<th style="width:5%" data-opt='{"align":"center","col":"ordNo","onClick":"STUMNG.goView(\"@{stuCd}\")"}'>순번</th>
					<th style="width:10%" data-opt='{"align":"center","col":"stuTpLangCd","onClick":"STUMNG.goView(\"@{stuCd}\")"}'>법무구분1</th>
					<th style="width:10%" data-opt='{"align":"center","col":"stuTp2LangCd","onClick":"STUMNG.goView(\"@{stuCd}\")"}'>법무구분2</th>
					<th style="width:15%" data-opt='{"align":"center","col":"procTpLangCd","onClick":"STUMNG.goView(\"@{stuCd}\")"}'>처리구분</th>
					<th style="width:10%" data-opt='{"align":"center","col":"stuCd","onClick":"STUMNG.goView(\"@{stuCd}\")"}'>상태코드</th>
					<th style="width:10%" data-opt='{"align":"center","col":"stuBaseNm","onClick":"STUMNG.goView(\"@{stuCd}\")"}' >기본상태명</th>
					<th style="width:*" data-opt='{"align":"left","col":"stuDesc","onClick":"STUMNG.goView(\"@{stuCd}\")"}'>상태설명</th>
					<th style="width:65px" data-opt='{"align":"center","html":{"type":"BTN","class":"fa fa-pencil","callback":"STUMNG.goWrite(\"@{stuCd}\")","title":"B.WRITE"}}'></th>
				</tr>
				</thead>
				<tbody id="StuMngTableBody">
				</tbody>
			</table>
			페이지 목록
			<div class="pagelist" id="StuMngTablePage"></div>
	</div>
</div>
--%>
<script>
	function StuMng(){

		var goCreateStu = function(){
				var url = "/paragon/def/defStuMng/defStuMngWrite.popup";
				paragonCmm.openWindow(url, "1240", "750", "POPUP_WRITE_FORM", "yes", "yes", "");
		}
		var doInit = function(frm){
			frm.reset();
		}
		var goWrite = function(stuCd){
			var imsiForm = $("<form method='POST'>").attr("action","/paragon/def/defStuForm/stuFormWrite.popup");
			imsiForm.append($("<input type='hidden' name='stuCd'>").val(stuCd));
			imsiForm.append($("<input type='hidden' name='_csrf'>").val($("meta[name='_csrf']").attr("content")));
			paragonCmm.openWindow("", "1024", "650", "POP_WRITE_"+stuCd, "yes", "yes", "");
			imsiForm.attr("target","POP_WRITE_"+stuCd);
			imsiForm.appendTo("body");
			imsiForm.submit();
			imsiForm.remove();
		}
		var goView = function(stuCd) {
			var imsiForm = $("<form method='POST'>").attr("action","/paragon/def/defStuMng/defStuMngWrite.popup");
			imsiForm.append($("<input type='hidden' name='stuCd'>").val(stuCd));
			imsiForm.append($("<input type='hidden' name='_csrf'>").val($("meta[name='_csrf']").attr("content")));
			paragonCmm.openWindow("", "1024", "650", "POP_STU_MAS_"+stuCd, "yes", "yes", "");
			imsiForm.attr("target","POP_STU_MAS_"+stuCd);
			imsiForm.appendTo("body");
			imsiForm.submit();
			imsiForm.remove();
		}
		var getSysCode = function(targetId, val){
			var data = {};

			if(val == ""){
				htmlUtils.initializeSelectJson(targetId,"", "", "|"+paragonCmm.getLang("L.CBO_ALL"), "cd", "langCd");
			}else{
			data["parentCd"] = val;
			paragonCmm.callAjax("/viself/code/codeMng/listCode/json",data, function(json){
				htmlUtils.initializeSelectJson(targetId,"", json.data, "|"+paragonCmm.getLang("L.CBO_ALL"), "cd", "langCd");
			});

			}
		}
		var loadGrid = function(pageNo){
			if(pageNo == undefined) pageNo =1;
			var data = paragonCmm.getSearchQueryParams();
			data["page"] = pageNo;
			data["rows"] = "10";

			paragonCmm.callAjax("/paragon/def/defstumng/DefStuMng/list/json",data, function(json){
			  var data = paragonCmm.easyuiLoadFilter(json);
			  var page = pageNo;
			  var rowCnt = 10;

			  htmlUtils.createTableRow("StuMngTable", data, page, rowCnt, "STUMNG.loadGrid");

			});

		}
		var goDelete = function(){

			var stu_cds = [];
			$("input:checkbox[name='chkStu']:checked").each(function(i, e){
				stu_cds.push($(this).val());
			})

			if($(stu_cds).length == 0){
				alert(paragonCmm.getLang("M.ALERT_SELECT","L.건"));
				return false;
			}

			var msg = paragonCmm.getLang("M.하시겠습니까","B.DELETE");
			confirm(msg, function(r){
				if(r){

					var data = {};
					data["stuCds"] = stu_cds.join(",");

					paragonCmm.callAjax("/paragon/def/defstumng/DefStuMng/delete/json",data, function(json){
						doSearch();
					});
				}
			});
		}
		var doSearch = function(isCheckEnter){
			if (isCheckEnter && event.keyCode != 13) {
				return;
			}

			loadGrid();
		}
		var attchmentEvent = function(){
			$("#addBtn").on("click",function(){
				goCreateStu();
			});
			$("#delBtn").on("click",function(){
				goDelete();
			});

			$("input:text", $("#form1")).off();
	        $("input:text", $("#form1")).on("keyup", function(e){
	        	doSearch(true);
	        	return false;
	        });

		}
		var init = function(){
			attchmentEvent();	//-- 이벤트 등록
			loadGrid();			//-- 리스트 로드
			getSysCode("stuType", "SOL_LMS");// 법무구분 로드

		}
		return{
	    	init : init,
	    	loadGrid:loadGrid,
	    	doSearch:doSearch,
	    	goView:goView,
	    	goWrite:goWrite
	    }
	}
	var STUMNG = new StuMng();
	STUMNG.init();
</script>