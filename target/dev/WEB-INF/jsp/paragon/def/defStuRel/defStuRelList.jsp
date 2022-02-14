<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="row mt">
	<h5 class="sub1_title" data-term="L.솔루션상태관계설정"><i class="fa fa-file-text"></i> </h5>
	<div class="col-md-12 col-sm-12">
		<div class="white-panel pn-sub1-top donut-chart">
			<div class="white-header">
				<form id="searchForm" method="post">
				<div class="row sub1_search">
                	<div class="col-md-11">
                		<div class="row">
                			<div class="col-md-4 col-sd-4">
                				<span data-tp="th" data-term="법무구분"></span>
                                <select name="stuTp" id="stuTp_search" class="form-control input-sm" data-type="search"    style="width:180px"></select>
								<select name="stuTp2" id="stuTp2_search" class="form-control input-sm"  data-type="search" style="width:120px"></select>
                			</div>
                			<div class="col-md-4 col-sd-4">
                				<span data-tp="th" data-term="처리구분"></span>
                                <select name="stuDtl" id="stuDtl" class="form-control input-sm" data-type="search"></select>
                			</div>
                			<div class="col-md-4 col-sd-4">
                				<span data-tp="th" data-term="역할자"></span>
                				<select name="stuDtl" id="stuDtl" class="form-control input-sm" data-type="search"></select>
                			</div>
                		</div>
                		<div class="row sear_mt">
                			<div class="col-md-4 col-sd-4">
                				<span data-tp="th" data-term="기본코드"></span>
                				<input type="text" name="stuCd" value="" data-type="search" class="form-control input-sm" onkeydown="defStuRel.getInList( true)"  />
                			</div>
                			<div class="col-md-4 col-sd-4">
                				<span data-tp="th" data-term="기본명"></span>
                				<input type="text" name="stuNm" value="" data-type="search" class="form-control input-sm" onkeydown="defStuRel.getInList( true)"  />
                			</div>
                			<div class="col-md-4 col-sd-4" style="text-align:left;">
								<span data-tp="th" data-term="순번"></span>
								<input type="text" name="ordNoGteq" value="" class="form-control input-sm" style="width:22%;" data-type="search"  onkeydown="defStuRel.getInList(true)" />
							   ~<input type="text" name="ordNoLteq" value="" style="width:22%;"  data-type="search" class="form-control input-sm"  onkeydown="defStuRel.getInList(true)" />
							</div>
                		</div>
                		<div class="row sear_mt">
                			<div class="col-md-6 col-sd-6">
                				<span data-tp="th" data-term="대상코드"></span>
                				<input type="text" name="nextStuCd" value="" data-type="search" class="form-control input-sm" onkeydown="defStuRel.getInList( true)"  />
                			</div>
                			<div class="col-md-6 col-sd-6">
                				<span data-tp="th" data-term="대상명"></span>
                				<input type="text" name="nextStuNm" value="" data-type="search" class="form-control input-sm" onkeydown="defStuRel.getInList( true)"  />
                			</div>
                		</div>
                	</div>
                	<div class="col-md-1">
                    	<button type="button" class="btn btn-primary btn-block" onclick="defStuRel.getInList();" data-term="B.SEARCH"><i class="fa fa-search"></i> </button>
                    </div>
                </div>
				</form>
			</div>
		</div>
	</div>
</div>
<div class="row mt">
	<div class="col-md-12 col-sm-12">
		<div class="white-panel">
			<form name="saveForm" id="saveForm" method="post" onsubmit="return false;">
				<table class="basic">
				<tr>
					<th style="width:10%;">법무구분</th>
					<td style="width:35%;">
						<select name="stuTp" class="form-control input-sm"id="stuTp_save" style="width:200px"></select>
						<select name="stuTp2"class="form-control input-sm" id="stuTp2_save"  style="width:100px"></select>
					</td>
					<th style="width:10%;">처리구분</th>
					<td style="width:35%;">
						<select name="stuDtl" class="form-control input-sm" id="stuDtl"></select>
					</td>
					<td rowspan="5" style="text-align:center;">
						<span class="ui_btn medium icon" id="goAddStu"><i class="fa fa-plus" ><a href="javascript:void(0)" data-term="B.ADD"></a></i></span>
						<span class="ui_btn medium icon"><i class="fa fa-minus" onclick="goDelete();"><a href="javascript:void(0)"  data-term="B.DELETE"></a></i></span>
					</td>
				</tr>
				<tr>
					<th >역할자</th>
					<td  colspan="3">
						<span id="saveFormRoleCd"></span>
					</td>
				</tr>
				<tr>
					<th>현재상태</th>
					<td>
						<input type="text" class="form-control input-sm" style="width:200px;" name="stuNm" id="stuNm" placeholder="상태코드, 기본명 검색..." value=""/>
						<input type="hidden" name="stuCd" id="stuCd" value=""/>
					</td>
					<th>순번</th>
					<td>
						<input type="text" class="form-control input-sm" name="ordNo" id="ordNo"  value=""/>
					</td>
				</tr>
				</table>
			</form>
		</div>
	</div>
</div>
<div class="row mt">
	<div class="col-md-12 col-sm-12">
		<div class="white-panel pn-sub1-table donut-chart">
			<table class="basic">
				<tr>
					<th style="text-align:center;width:5%">순번</th>
					<th style="text-align:center;width:5%">구분1</th>
					<th style="text-align:center;width:5%">구분2</th>
					<th style="text-align:center;width:15%">현재상태</th>
					<th style="text-align:center;width:10%">처리구분</th>
					<th style="text-align:center;width:10%">권한자</th>
					<th style="text-align:center;width:*">대상처리</th>
					<th style="text-align:center;width:5%"></th>
				</tr>
				<tbody id="inListBody">
				</tbody>
			</table>
		</div>
	</div>
</div>

<%--
<div class="content-panel p-3 site-min-height">
	<h3><i class="fa fa-angle-right" id="content_header" data-term="L.솔루션상태관계설정"> </i></h3>
	<div>
		<form id="searchForm" method="post">
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
						<col style="width:20%" />
						<col style="width:10%" />
						<col style="width:20%" />
						<col style="width:10%" />
						<col style="width:20%" />
						<col style="width:auto" />
					</colgroup>
					<tr>
						<th >법무구분</th>
						<td >
							<select name="stuTp" id="stuTp_search" data-type="search"></select>
							<select name="stuTp2" id="stuTp2_search" data-type="search"></select>
						</td>
						<th >처리구분</th>
						<td >
							<select name="stuDtl" id="stuDtl" data-type="search"></select>
						</td>
						<th>역할자</th>
						<td >
							<select name="stuDtl" id="stuDtl" data-type="search"></select>
						</td>
						<td rowspan="3" class="verticalContainer">
							<span class="ui_btn medium icon"><i class="fa fa-search" onclick="defStuRel.getInList();"><a href="javascript:void(0)" data-term="B.SEARCH"></a></i></span>
						</td>
					</tr>
					<tr>
						<th>기본상태코드</th>
						<td><input type="text" name="stuCd" value="" data-type="search" class="text" onkeydown="defStuRel.getInList( true)" style="width:97%;" /></td>
						<th>기본상태명</th>
						<td><input type="text" name="stuNm" value="" data-type="search" class="text" onkeydown="defStuRel.getInList( true)" style="width:97%;" /></td>
						<th>순번  :</th>
						<td><input type="text" name="ordNoGteq" value="" class="text" style="width:44%;" data-type="search"  onkeydown="defStuRel.getInList(true)" />~<input type="text" name="ordNoLteq" value="" style="width:44%;"  data-type="search" class="text"  onkeydown="defStuRel.getInList(true)" /></td>
					</tr>
					<tr>
						<th>대상상태코드</th>
						<td><input type="text" name="nextStuCd" value="" data-type="search" class="text" onkeydown="defStuRel.getInList( true)" style="width:97%;" /></td>
						<th>대상상태명</th>
						<td><input type="text" name="nextStuNm" value="" data-type="search" class="text" onkeydown="defStuRel.getInList( true)" style="width:97%;" /></td>
						<th></th>
						<td></td>
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
			<form name="saveForm" id="saveForm" method="post" onsubmit="return false;">
				<table class="basic">
				<tr>
					<th style="width:10%;">법무구분</th>
					<td style="width:35%;">
						<select name="stuTp" id="stuTp_save" ></select>
						<select name="stuTp2" id="stuTp2_save" ></select>
					</td>
					<th style="width:10%;">처리구분</th>
					<td style="width:35%;">
						<select name="stuDtl" id="stuDtl"></select>
					</td>
					<td rowspan="5" style="text-align:center;">
						<span class="ui_btn medium icon" id="goAddStu"><i class="fa fa-plus" ><a href="javascript:void(0)" data-term="B.ADD"></a></i></span>
						<span class="ui_btn medium icon"><i class="fa fa-minus" onclick="goDelete();"><a href="javascript:void(0)"  data-term="B.DELETE"></a></i></span>
					</td>
				</tr>
				<tr>
					<th >역할자</th>
					<td  colspan="3">
						<span id="saveFormRoleCd"></span>
					</td>
				</tr>
				<tr>
					<th>현재상태</th>
					<td>
						<input type="text" class="text" style="width:200px;" name="stuNm" id="stuNm" placeholder="상태코드, 기본명 검색..." value=""/>
						<input type="hidden" name="stuCd" id="stuCd" value=""/>
					</td>
					<th>순번</th>
					<td>
						<input type="text" class="text width_max" name="ordNo" id="ordNo"  value=""/>
					</td>
				</tr>
				</table>
			</form>
			<table class="basic">
				<tr>
					<th style="text-align:center;width:5%">순번</th>
					<th style="text-align:center;width:5%">구분1</th>
					<th style="text-align:center;width:5%">구분2</th>
					<th style="text-align:center;width:15%">현재상태</th>
					<th style="text-align:center;width:10%">처리구분</th>
					<th style="text-align:center;width:10%">권한자</th>
					<th style="text-align:center;width:*">대상처리</th>
					<th style="text-align:center;width:5%"></th>
				</tr>
				<tbody id="inListBody">
				</tbody>
			</table>
	</div>
</div> --%>
<script id="outListTmpl" type="text/html">
	<tr>
		<td style="width:8%">
			<input type="text" id="ordNo" class="text" style="width:80%" onKeyUp="defStuRel.goModStr(true,'\${ordNo}','\${outUid}',this,'outUpdate')" value="\${ordNo}">
		</td>
		<td style="width:22%">
			<input type="text" class="text width_max" value="\${nextStuCd}" id="nextStuCd" onKeyUp="defStuRel.goModStr(true,'\${nextStuCd}','\${outUid}',this,'outUpdate')" >
		</td>
		<td style="width:*"><span class="ui_btn medium icon"><i class="fa fa-check"><a>\${stuNm}</a></i></span></td>
		<td style="width:5%"><span class="ui_btn small icon"><i class="fa fa-minus" onclick="defStuRel.goOutRowDelete('\${inUid}','\${outUid}')"><a href="javascript:void(0)" ></a></i></span></td>
	</tr>
</script>
<script id="inListTmpl" type="text/html">
	<tr>
		<td style="text-align:center"><input type="text" class="text" id="ordNo" style="width:80%" onKeyUp="defStuRel.goModStr(true,'\${ordNo}','\${inUid}',this,'inUpdate')" value="\${ordNo}"></td>
		<td style="text-align:center">\${paragonCmm.getLang(stuTpLangCd)}</td>
		<td style="text-align:center">\${paragonCmm.getLang(stuTp2LangCd)}</td>
		<td style="text-align:center"><input type="text" class="text width_max" id="stuCd" value="\${stuCd}" onKeyUp="defStuRel.goModStr(true,'\${stuCd}','\${inUid}',this,'inUpdate')" ><br/>\${stuNm}</td>
		<td style="text-align:center">
			{{html htmlUtils.getSelect("stuDtl","stuDtl"+rn, defStuRel.tmplStuType(), stuDtl,"onChange=\"defStuRel.goModStr(false,'"+stuDtl+"','"+inUid+"',this,'inUpdate')\"") }}
		</td>
		<td style="text-align:center">
			{{html htmlUtils.getSelect("roleCd","roleCd"+rn, defStuRel.tmplRole(), roleCd ,"onChange=\"defStuRel.goModStr(false,'"+roleCd+"','"+inUid+"',this,'inUpdate')\"") }}
		</td>
		<td>
			<form id="in_\${inUid}" onSubmit="return false;">
				<input type="text" class="text" style="width:75%" id="add_\${inUid}" onKeyUp="(event.keyCode == 13)?defStuRel.goAddOut('\${inUid}'):''" name="nextStuCd" placeholder="상태코드 검색">
				<input type="hidden" name="inUid" value="\${inUid}">
				<input type="hidden" name="stuCd" value="\${stuCd}">
			</form>
			<span class="ui_btn medium icon"><i class="fa fa-plus" onclick="defStuRel.goAddOut('\${inUid}')"><a href="javascript:void(0)" >\${paragonCmm.getLang("B.ADD")}</a></i></span>
			<table class="inner">
				<tbody id="outListBody_\${inUid}">
				</tbody>
			</table>
		</td>
		<td><span class="ui_btn small icon"><i class="fa fa-minus" onclick="defStuRel.goInRowDelete('\${inUid}')"><a href="javascript:void(0)" >삭제</a></i></span></td>
	</tr>
</script>
<script>
	function DefStuRel(){
		var tmplStuType = "";
		var tmplRole = "";
		var outJsonData = [];
		var imsiVal = {};	//-- 임시 값 수정
		var setImsiVal = function(key, val){
			imsiVal[key] = val;
		};
		var goModStr = function(isCheckEnter,orgData, uid, obj, mode_code){
			var tagName = $(obj).get(0).tagName;
			var col = $(obj).attr("id");
			if("SELECT" == tagName){
				col = $(obj).attr("name");
			}
			//-- 실패시 원본으로 돌리기 위한 임시 저장 값
			setImsiVal(col, orgData);

		 	if (isCheckEnter && event.keyCode != 13) {
		         return;
		    }
			var msg = paragonCmm.getLang("M.하시겠습니까","B.MODIFY");
			confirm(msg, function(r){
				if(r){
					var data = {};
					if(mode_code == "outUpdate"){
						data["outUid"] =uid;
					}else{
						data["inUid"] =uid;

					}
					var url = "/paragon/def/defsturel/DefStuRel/"+mode_code+"/json";
					data[col] =$(obj).val();
					paragonCmm.callAjax(url ,data, function(json){
						if(mode_code == "outUpdate"){
							initOutList();
						}
						getInList();
					});
				}else{
					$(obj).val(imsiVal[col]);
					imsiVal[col] = "";
				}
			})
		}
		//-- out 데이터 추가
		var goAddOut = function(in_uid){

			var msg = paragonCmm.getLang("M.하시겠습니까","B.ADD");
			confirm(msg, function(r){
				if(r){
					var data = $("#in_"+in_uid).serializeJSON();
					data["outUid"] = paragonCmm.getRandomUUID();
					data["ordNo"] = "0";
					paragonCmm.callAjax("/paragon/def/defsturel/DefStuRel/outInsert/json",data, function(json){
						initOutList();
						getOutList(in_uid);
					});
				}
			});
		}
		//-- in 삭제 (하위 out 모두 삭제)
		var goInRowDelete = function(uid){
			var msg = "연결된 하위 상태가 모두 삭제 됩니다.\n계속하시겠습니까?";
			confirm(msg, function(r){
				if(r){
					paragonCmm.callAjax("/paragon/def/defsturel/DefStuRel/outAllDelete/json",{"inUid":uid}, function(json){
						paragonCmm.callAjax("/paragon/def/defsturel/DefStuRel/inDelete/json",{"inUid":uid}, function(json){
							initOutList();
							getInList();
						});
					});
				}
			});
		};
		//-- out 한개 삭제
		var goOutRowDelete = function(in_uid, out_uid){
			var msg = paragonCmm.getLang("M.하시겠습니까","B.DELETE");
			confirm(msg, function(r){
				if(r){
					paragonCmm.callAjax("/paragon/def/defsturel/DefStuRel/outDelete/json",{"outUid":out_uid}, function(json){
						initOutList();
						getOutList(in_uid);
					});
				}
			});
		};
		//-- 자동완성 기능 추가
		var addCompleteStu = function(id){
			$("#"+id).combobox({
				mode: 'remote',
	    		valueField: 'value',
	    		textField: 'label',
	    		loader:function(param, succ){
	    			if (!param.q){return;}
	    			$.ajax({
	    				url: "/paragon/def/defstumng/DefStuMng/list/json",
	    				data: {schword:param.q},
	    				dataType: 'json',
	    				success: function(data){
	    					var rows = $.map(data.data, function(item){
	    						return {
	    							label: "["+paragonCmm.getLang(item.stuTp2LangCd)+"]"+"["+item.stuCd+"]"+item.stuBaseNm,
	    							value: item.stuCd,
	    							stu_cd:item.stuCd
	    						};
	    					});
	    					succ(rows);
	    				}
	    			});
				}
			});
		};
		//-- in 리스트 뷰 생성
		var getInList = function(isCheckEnter){

			if (isCheckEnter && event.keyCode != 13) {
		        return;
		    }
			var data = paragonCmm.getSearchQueryParams($("#searchForm"));

			paragonCmm.callAjax("/paragon/def/defsturel/DefStuRel/inList/json",data, function(json){
				$("#inListBody").html("");
				$("#inListTmpl").tmpl(json.data).appendTo($("#inListBody"));
				$(json.data).each(function(i, d){
					addCompleteStu('add_'+d.inUid);
					getOutList(d.inUid);
				});
			});
		};
		//-- out 리스트 뷰 생성
		var getOutList = function(uid){
			$("#outListBody_"+uid).html("");
			$(outJsonData).each(function(i, d){
				if(d.inUid == uid){
					$("#outListTmpl").tmpl(d).appendTo($("#outListBody_"+uid));
				}
			});
		};

		//-- out 리스트 데이터 로드
		var initOutList = function(){
			var data = {};

			paragonCmm.callAjax("/paragon/def/defsturel/DefStuRel/outList/json",data, function(json){
				outJsonData = json.data;
			});
		}
		//--- 상태 추가 처리 및 저장 처리
		var goAddStu = function(isCheckEnter){
			if (isCheckEnter && event.keyCode != 13) {
		         return;
		     }
			if ($("input:radio[name='roleCd']:checked").length == 0 ) {
				alert (paragonCmm.getLang("M.필수_선택사항_입니다","권한자"));
				$("input:radio[name='roleCd']").eq(0).focus();
			    return false;
			}
			if ("" == $("#stuCd").val() ) {
				alert (paragonCmm.getLang("M.필수_입력사항_입니다","현재상태"));
				$("#stuCd").eq(0).focus();
			    return false;
			}
			var msg = paragonCmm.getLang("M.하시겠습니까","B.ADD");
			confirm(msg, function(r){
				if(r){
					var data = $("#saveForm").serializeJSON();
					data["inUid"] = paragonCmm.getRandomUUID();
					paragonCmm.callAjax("/paragon/def/defsturel/DefStuRel/inInsert/json",data, function(json){
						getInList();
					});
				}
			})
		};
		var attchmentEvent = function(){
			$("#stuTp_search").on("change",function(){
				var cd = $(this).val();
				htmlUtils.getCodeSelectOpt({
					targetId:"stuTp2_search",
					parentCd:cd,
					initdata:"|"+paragonCmm.getLang("L.CBO_SELECT"),
					valNm:"cd",
					txtNm:"langCd"
				});
			});
			$("#stuTp_save").on("change",function(){
				var cd = $(this).val();
				htmlUtils.getCodeSelectOpt({
					targetId:"stuTp2_save",
					parentCd:cd,
					initdata:"|"+paragonCmm.getLang("L.CBO_SELECT"),
					valNm:"cd",
					txtNm:"langCd"
				});
			});
			$("#goAddStu").on("click",function(){
				goAddStu();
			});
		}
		var init = function(){
			//-- 코드 Select 로드
			htmlUtils.getCodeSelectOpt({
				targetNm:"stuTp",
				parentCd:"SYS_SOL_TYPE",
				initdata:"|"+paragonCmm.getLang("L.CBO_SELECT"),
				valNm:"cd",
				txtNm:"langCd"
			}); //-- 솔루션구분 select 로드
			htmlUtils.getCodeSelectOpt({
				targetNm:"roleCd",
				parentCd:"USER_ROLE",
				initdata:"|"+paragonCmm.getLang("L.CBO_SELECT"),
				valNm:"cdAbb",
				txtNm:"langCd"
			}); //-- 솔루션구분 select 로드
			htmlUtils.getCodeSelectOpt({
				targetNm:"stuDtl",
				parentCd:"SOL_STU_TYPE",
				initdata:"|"+paragonCmm.getLang("L.CBO_SELECT"),
				valNm:"cdAbb",
				txtNm:"langCd"
			}); //-- 솔루션구분 select 로드


			htmlUtils.loadCodeStr("SOL_STU_TYPE","cdAbb,langCd","",function(str){
				tmplStuType = str;
			}); //--처리구분 코드 checkbox Tmpl 로드
			htmlUtils.loadCodeStr("USER_ROLE","cdAbb,langCd","",function(str){
				tmplRole = str;
			}); //--역할 checkbox Tmpl 로드

			//-- 역할자 로드
			$("#saveFormRoleCd").html(htmlUtils.getInputRadio("roleCd",tmplRole,"","" ));
			var selRecord = {};
			$("#stuNm").combobox({
				mode: 'remote',
	    		valueField: 'value',
	    		textField: 'label',
	    		onSelect:function(record){
	    			if(!jQuery.isEmptyObject(selRecord)){
	    				selRecord = {}
	    			}
	    			selRecord = record;
	    		},
	    		onHidePanel:function(){
	    			$("#stuCd").val(selRecord.data.stuCd);
	    		},
	    		loader:function(param, succ){
	    			if (!param.q){return;}
	    			$.ajax({
	    				url: "/paragon/def/defstumng/DefStuMng/list/json",
	    				data: {schword:param.q},
	    				dataType: 'json',
	    				success: function(data){
	    					var rows = $.map(data.data, function(item){
	    						return {
	    							value: item.stuBaseNm,
					                label: "["+paragonCmm.getLang(item.stuTp2LangCd)+"]"+"["+item.stuCd+"]"+item.stuBaseNm,
					                data:item
	    						};
	    					});
	    					succ(rows);
	    				}
	    			});
				}
			});



			initOutList();
			getInList();
			attchmentEvent();	//-- 이벤트 등록
		}
		return{
	    	init : init,
			tmplStuType:function(){return tmplStuType;},
			tmplRole:function(){return tmplRole;},
			getInList:getInList,
			goModStr:goModStr,
			goAddOut:goAddOut,
			goOutRowDelete:goOutRowDelete,
			goInRowDelete:goInRowDelete
	    }
	}
	var defStuRel = new DefStuRel();
	defStuRel.init();
</script>