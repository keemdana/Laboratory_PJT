<%--
  - MENU ID : regVoc
  - Description : VOC 최초 등록
--%>

<%@page import="com.vertexid.spring.utils.SessionUtils"%>
<%@page import="com.vertexid.commons.utils.DateUtil"%>
<%@page import="com.vertexid.viself.hr.SysLoginVO"%>
<%@page import="com.vertexid.commons.utils.StringUtil"%>
<%@page import="com.vertexid.commons.utils.HtmlUtil"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@include file="/WEB-INF/tiles/include/includeTagLibs.jsp"%>

<%
	SysLoginVO loginUser = (SysLoginVO) SessionUtils.getLoginVO();
	String siteLocale = loginUser.getSiteLocale();
%>

<style>
.datagrid-header {
	font-weight: bold;
}

TABLE.basic TH {
	text-align: center;
}

TABLE.basic TH.left {
	text-align: left;
	padding: 7px 10px 7px 10px !important;
}

DIV.conButtonlist {
	padding: 15px 2px 15px 2px;
	float: right;
} 

DIV.title_left {
	width: 50%;
	float: left;
}

DIV.button_right {
	width: 50%;
	float: right;
	text-align: right;
	padding: 5px 2px 5px 2px;
}
</style>

<div class="row mt">
	<h5 class="sub1_title" data-term="L.VOC 등록(NEW)">
		<i class="fa fa-file-text"></i>
	</h5>
	(<span class="ui_icon required"></span> <span data-term="L.는_필수_입력항목"></span>)
	<div>
		<form name="vocWriteForm" id="vocWriteForm" method="post">
			<div id="vocWriteForm2" data-opener-data="<c:out value='${param.openerData}'/>">
				<input type="hidden" name="atchFileMstId" id="atchFileMstId" data-col="atchFileMstId" value=""/>
				<input type="hidden" name="loginUserId" id="loginUserId" value="<%=loginUser.getLoginId()%>">
				<%-- 기본정보 작성 화면 --%>	
				<table class="basic">
					<colgroup>
						<col style="width: 10%;">
						<col style="width: 10%;">
						<col style="width: 10%;">
						<col style="width: 10%;">
						<col style="width: 10%;">
						<col style="width: 10%;">
						<col style="width: 10%;">
						<col style="width: 10%;">
						<col style="width: 10%;">
						<col style="width: 10%;">
					</colgroup>
					<tr>
						<th>관리번호</th>
						<td><input type="text" id="vocNo" name="vocNo" class="form-control" value="" readonly /></td>
						<th>접수부서</th>
						<td><%=loginUser.getDeptNmKo()%><input type="hidden" name="createDept" id="createDept" class="form-control" data-col="deptCd" value="<%=loginUser.getDeptCd()%>" readonly></td>
						<th>접수자</th>
						<td><%=loginUser.getNmKo()%><input type="hidden" name="createUser" id="createUser" value="<%=loginUser.getLoginId()%>" /></td>
						<th>접수일</th>
						<td><%=DateUtil.getCurrentDate()%> <input type="hidden" name="createDate" id="createDate" class="form-control" data-col="createDate" value="<%=DateUtil.getCurrentDate()%>" readonly></td>
						<th><span class="ui_icon required"></span>사업구분</th>
						<td>
							<select id="bssArea" name="bssArea" class="form-control input-sm" data-type="search">
								<option value="">선택</option>
								<option value="SMC">반도체</option>
								<option value="DP">디스플레이</option>
							</select>
						</td>
					</tr>
					<tr>
						<th><span class="ui_icon required"></span>고객사</th>
						<td><input type="text" id="custNm" name="custNm" class="form-control" value="" /></td>
						<th><span class="ui_icon required"></span>고객담당자</th>
						<td><input type="text" id="custUserNm" name="custUserNm" class="form-control" value="" /></td>
						<th><span class="ui_icon required"></span>고객F/B실행여부</th>	
						<td>
							<select id="custFbYn" name="custFbYn" class="form-control input-sm" data-type="search">
								<option value="">선택</option>
								<option value="Y">Y</option>
								<option value="N">N</option>
							</select>
						</td>
						<th><span class="ui_icon"></span>고객담당자메일</th>
						<td><input type="text" id="custUserEmail" name="custUserEmail" class="form-control" value="" /></td>
						<th><span class="ui_icon required"></span>고객요청일</th>
                        <td><input type="text" id="custReqDate" name="custReqDate" class="form-control" data-col="custReqDate" style="width: 100%;"></td>	
					</tr>
					<tr>
						<th><span class="ui_icon required"></span>접수유형</th>
						<td><select id="vocRegType" name="vocRegType" class="form-control input-sm" data-type="search"></select></td>
					</tr>
					<tr>
						<th><span class="ui_icon required"></span>제목</th>
						<td colspan="9"><input type="text" id="vocTitle" name="vocTitle" class="form-control" data-col="vocTitle" value="" /></td>
					</tr>
					<tr>
						<th><span class="ui_icon required"></span>대상설비<br />
							<div style="margin-top: 5px;">
								<button type="button" class="btn btn-primary" id="addSulbi" style="padding: 3px 5px;"> <i class="fa fa-check"></i>추가 </button>
								<button type="button" class="btn btn-primary" id="removeSulbi" style="padding: 3px 5px; background-color: #333; border-color: #333"> <i class="fa fa-check"></i>삭제 </button>
							</div>
						</th>
						<td colspan="9">
							<table class="basic" id="sulbiTb">
								<colgroup>
									<col style="width: 10%;">
									<col style="width: 20%;">
									<col style="width: 20%;">
									<col style="width: 20%;">
									<col style="width: 20%;">
								</colgroup>
								<thead>
									<tr>
										<th></th>
										<th>Line</th>
										<th>제품유형</th>
										<th>공정명</th>
										<th>Project No.</th>
									</tr>
								</thead>
								<tbody id="sulbiList">
								</tbody>
							</table>
						</td>
					</tr>
					<tr>
                        <th><span class="ui_icon required"></span>요청 내용</th>
                        <td colspan="9"><%=HtmlUtil.getHtmlEditor(request, true, "custReqContents", "custReqContents", "", "data-col=\"custReqContents\"", "100%", "", "Default") %></td>
                    </tr>
                    <tr>
                        <th data-term="L.첨부"></th>
                        <td colspan="9" id="bbsFile" name="bbsFile"></td>
                    </tr>
				</table>
				<div class="conButtonlist">
					<div class="right">
						<button type="button" class="btn btn-primary" id="btnTmpSave" data-term="임시저장"><i class="fa fa-check"></i></button>
						<button type="button" class="btn btn-primary" id="btnRegSave" data-term="접수"><i class="fa fa-check"></i></button>
						
					</div>
				</div>
			</div>
			<input type="hidden" name="custCd" id="custCd" value="">
		</form>
	</div>
</div>

<script type="text/javascript">

//고객사 선택 모달
var $modalDiv1;

	$(document).ready(function() {

		console.info("[Loading Module: VOC 신규 등록].....................");

		var vocReg = new VocReg();
		vocReg.init();

	});

	var VocReg = function() {
		var openerData = $("#vocWriteForm2").data("opener-data");
		$("#atchFileMstId").val(openerData.atchFileMstId);

		var $vocWriteForm = $("#vocWriteForm");
		var $atchFileMstId = $("#atchFileMstId");
		var $custReqDate = $("#custReqDate");
		var $requestBtn = $("#requestBtn");

		var doValidation = function() { // 저장 필수체크
			if ($("#bssArea option:selected").val() == "") {
				alert("사업구분을 선택해주세요.", function() {
					$("input:text[name='bssArea']", $vocWriteForm).focus();
				});
				return false;
			}
		
			if ($("input:text[name='custNm']", $vocWriteForm).val() == "") {
				alert("고객사를 선택해주세요.", function() {
					$("input:text[name='custNm']", $vocWriteForm).focus();
				});
				return false;
			}	
			
			if ($("input:text[name='custUserNm']", $vocWriteForm).val() == "") {
				alert("고객담당자를 입력해주세요.", function() {
					$("input:text[name='custUserNm']", $vocWriteForm).focus();
				});
				return false;
			}	
			
			if ($("#custFbYn option:selected").val() == "") {
				alert("고객F/B실행여부를 선택해주세요.", function() {
					$("input:text[name='custFbYn']", $vocWriteForm).focus();
				});
				return false;
			}
			
			if($("#custFbYn option:selected").val() == "Y"){	//고객F/B실행여부를 Y로 했을 경우 고객담당자메일은 필수 값
				if ($("input:text[name='custUserEmail']", $vocWriteForm).val() == "") {
					alert("고객담당자메일을 입력해주세요.", function() {
						$("input:text[name='custUserEmail']", $vocWriteForm).focus();
					});
					return false;
				}	
			}
			
			if ($("#custReqDate").val() == "") {
				alert("고객요청일을 선택해주세요.", function() {
					$("input:text[name='custReqDate']", $vocWriteForm).focus();
				});
				return false;
			}
				
			if ($("input:text[name='vocTitle']", $vocWriteForm).val() == "") {
				alert("제목을 입력해주세요.", function() {
					$("input:text[name='vocTitle']", $vocWriteForm).focus();
				});
				return false;
			}	

			var trCnt = $("#sulbiTb >tbody tr").length;
			if(trCnt == "0"){
				alert("대상설비를 하나 이상 선택하셔야합니다.");
				return false;
			}
			
			paragonCmm.setEditorSubmit("");
			var reqContents = $("#vocWriteForm").find("textarea[name=custReqContents]").val().replace(/\"/gi, "'");
			if(reqContents == ""){
				alert("요청 내용을 입력해주세요");
				return false;
			}
			
			return true;
		}

		var doSubmit = function(gb) {
			var msg = paragonCmm.getLang("M.ALERT_SUBMIT", "L.저장");
			if (!doValidation()) {
				return false;
			}
			confirm(msg, function(r) {
				if (r) {

					var SAVE_URL = "";
					
					//저장 완료
					if(gb == "S"){
						SAVE_URL = "/voc/saveMst/json";
					}else{	//임시저장
						SAVE_URL = "/voc/saveTmpMst/json";
					}
					
					paragonCmm.setEditorSubmit("");
					var data = $vocWriteForm.serializeObject();
					
					data.custReqContents = $vocWriteForm.find("textarea[name=custReqContents]").val().replace(/\"/gi, "'");
					
					var sulbiArr = [];
					var dataObj = {};
					var params = {list: $("#sulbiList").tableDataToJson()};
					for(var i = 0; i < $("#sulbiTb tbody tr").length; i++){
						var line = $("#sulbiTb tbody tr").eq(i).children().eq(1).text();
						var product = $("#sulbiTb tbody tr").eq(i).children().eq(2).text();
						var process = $("#sulbiTb tbody tr").eq(i).children().eq(3).text();
						var project = params.list[i].vocPjtNo;
						
						dataObj.line = line;
						dataObj.product = product;
						dataObj.process = process;
						dataObj.vocPjtNo = project;
						
						sulbiArr.push(dataObj);
						
						dataObj = {};
					}
					
					data.sulbiList = sulbiArr;
					
					data.processList = [];	//processDto에서 담기위한 임의 값
					
					//파일저장이 필요할 땐 submitAjax를 써야한다 (callAjax에는 파일처리가 미포함)					
					paragonCmm.submitAjax(SAVE_URL, data, function(json) {
						if (json.errYn === "E") {
							//오류처리
							alert(json.msg);
							return false;
						}
						
						//등록이 완료되면 F/B Y일 경우 메일을 보낸다.
						
						
						opener.parent.doSearch();
						window.close();					
					});
				}
			});
		}

		//-- 웹에디터 첨부파일 Form 로드
		var loadForm = function() {

			var attchId = "bbsFile";
			var options = {}

			options.relUid = $("#atchFileMstId").val(); //-- 관례 키 UIDH
			options.fileTpCd = "CMM/BBS"; //-- 파일 유형 코드
			options.defaultRelUid = ""; //-- 기본 로드 첨부파일(수정시)
			console.log("options");
			console.log(options);

			try {

				htmlUtils.loadFileHtml(attchId, options);
			} catch (e) {
				console.log(e);
			}
		}

		var initFormComponent = function() {
			$custReqDate.datebox({});
		}

		var attchmentEvent = function() {
			$("#btnRegSave").off();
			$("#btnRegSave").on("click", function() {
				doSubmit("S");
			});
			
			$("#btnTmpSave").off();
			$("#btnTmpSave").on("click", function() {
				doSubmit("T");
			});
		}

		//기준정보 조회
		var getDdList = function() {
			var iData = {};
			paragonCmm.callAjax("/voc/getDdList/json", iData, function(json) {
				//접수유형
				for (var i = 0; i < json.vocRegType.length; i++) {
					$("#vocRegType").append(
							"<option value='"+ json.vocRegType[i].dcode +"'>"
									+ json.vocRegType[i].dname + "</option>");
				}
			});
		}

		var modalTitle = "";
		var modalUrl = "";
		var width = "";

		$("input:text[name='custNm']", "#vocWriteForm").off();
		$("input:text[name='custNm']", "#vocWriteForm").on("click", function() {
			modalTitle = "고객사 선택";
			modalUrl = "/voc/schCustDialog.modal";
			width = 500;
			openModal(this, modalTitle, modalUrl);
		});

		$("#addSulbi").on("click", function() {
			modalTitle = "대상 설비 선택";
			modalUrl = "/voc/schSulbiDialog.modal";
			width = 1500;
			openModal(this, modalTitle, modalUrl);
		});
		
		$("#removeSulbi").on("click", function() {
			var cnt = $("input[name='chkSulbi']:checked").length;
			if(cnt == 0){
	            alert("선택한 항목이 없습니다.");
	            return;
	        }
			
			//체크된 항목 삭제
			$("input[name='chkSulbi']:checked").each(function() {
	        	if (this.checked){
	        		var $li_id = $(this).parent().parent(); //td > tr
	                $li_id.remove(); // 삭제
	          	}
	      	}); 
			
	        //남아있는 항목 id 값 seq 재배정 
	        $("#sulbiTb >tbody tr").each(function(index){
	        	$(this).children().first().children().attr('id','chk_'+index);
       		});	        	
	        
		});

		$("#addEmp").on("click", function() {
			modalTitle = "처리 담당 선택";
			modalUrl = "/voc/schEmpDialog.modal";
			width = 1000;
			openModal(this, modalTitle, modalUrl);
		});

		var openModal = function(obj, modalTitle, modalUrl) {
			$(obj).val("");// 클릭시 값 초기화
			if (typeof $modalDiv1 != "object") {
				$modalDiv1 = $("<div>");
			}
			$modalDiv1.window({
				iconCls : 'icon-search',
				width : width,
				height : 600,
				title : modalTitle,//"고객사 선택",
				href : modalUrl,//"/voc/schCustDialog.modal",  //"/viself/module/moduleListDialog.modal",
				modal : true,
				onClose : function() {
					$modalDiv1.window("destroy");
				},
				onLoad : function() {
					moduleList.init(function() {
						//-- init Function
					}, function(moduleId) {
						//-- callback Function
						$(obj).val(moduleId);
						$modalDiv1.window("destroy");
					}); //-- init,콜백 Function 지정
					paragonCmm.convertLang($modalDiv1); //-- 다국어 처리
				}
			});
		}

		var init = function() {
			loadForm(); // 양식 로드
			initFormComponent();
			attchmentEvent();
			
			//기준정보 선택 값 조회
			getDdList();			
		};

		return {
			init : init
		};
	}
	
	//선택한 고객사 정보 셋팅
	function setSchCust(code, name){
		$('#custCd').val(code);
		$('#custNm').val(name);
		$modalDiv1.window("destroy");
	}
	
	//선택한 대상 설비 정보 테이블 셋팅
	function setSulbiList(line, product, process) {
		var trCnt = $("#sulbiTb >tbody tr").length;
		var innerHtml = "";
		innerHtml += '<tr>';
		innerHtml += '<td>' + '<input type="checkbox" id="chk_'+trCnt+'" name="chkSulbi"></td>';
		innerHtml += '<td>' + line["lineNm"] + '</td>';
		innerHtml += '<td>' + product["prodNm"] + '</td>';
		innerHtml += '<td>' + process["processNm"] + '</td>';
		innerHtml += '<td><input type="text" id="vocPjtNo" name="vocPjtNo" class="form-control" value=""/></td>';
		innerHtml += '</tr>';

		$("#sulbiTb > tbody:last").append(innerHtml);
		
		$modalDiv1.window("destroy");
		
		//동적이기 때문에 Project 선택 modal 이벤트를 다시 생성
		var openPjtSchModal = function(obj, modalTitle, modalUrl) {
			$(obj).val("");// 클릭시 값 초기화
			if (typeof $modalDiv1 != "object") {
				$modalDiv1 = $("<div>");
			}
			$modalDiv1.window({
				iconCls : 'icon-search',
				width : width,
				height : 600,
				title : modalTitle,
				href : modalUrl,
				modal : true,
				onClose : function() {
					$modalDiv1.window("destroy");
				},
				onLoad : function() {
					moduleList.init(function() {
					}, function(moduleId) {
						$(obj).val(moduleId);
						$modalDiv1.window("destroy");
					});
					paragonCmm.convertLang($modalDiv1); //-- 다국어 처리
				}
			});
		}
		
        $("input:text[name='vocPjtNo']", "#sulbiList").off();
        $("input:text[name='vocPjtNo']", "#sulbiList").on("click",function(){        	
        	modalTitle = "Project 조회";
			modalUrl = "/voc/schPjtDialog.modal";
			width = 500;
			openPjtSchModal(this, modalTitle, modalUrl);
        });
	}

</script>
