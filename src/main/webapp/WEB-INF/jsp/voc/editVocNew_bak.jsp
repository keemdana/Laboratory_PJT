<%--
  - MENU ID : editVoc
  - Description : VOC 접수 or 임시저장 후 수정/처리 진행 화면
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

.mt {
    margin: 10px 3px 0px 3px;
}

.datagrid-header {
	font-weight: bold;
}

TABLE.basic {
	margin-bottom: 30px;
}

TABLE.basic TH {
	text-align: center;
	background-color: #c7ccd1;
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

.badge.badge-pill {
    padding: .2em .6em;
}
.badge {
    font-weight: 300;
    line-height: normal;
}

.badge-danger {
    color: #fff;
    background-color: #f62d51;
}

</style>

<div class="row mt"  id="vocView">
	<h5 class="sub1_title" data-term="VOC 등록">
		<i class="fa fa-file-text"></i>
	</h5>
	(<span class="ui_icon required"></span> <span data-term="L.는_필수_입력항목"></span>)
	<div>
		<form name="vocWriteForm" id="vocWriteForm" method="post">
			<div id="vocWriteForm2">
				<input type="hidden" name="vocNo" id="vocNo" data-col="vocNo" value="<c:out value='${param.vocNo}'/>"/>
				<input type="hidden" name="status" id="status" data-col="status" value="<c:out value='${param.status}'/>"/>
				<input type="hidden" name="loginUserId" id="loginUserId" value="<%=loginUser.getLoginId()%>">
				<input type="hidden" name="tsaYn" id="tsaYn" value="<%=loginUser.getTsaYn()%>">
				<input type="hidden" name="custCd" id="custCd" data-col="custCd" value="<c:out value='${param.custCd}'/>">
				<input type="hidden" name="relUid" id="relUid" data-col="relUid" value=""/>
				<input type="hidden" name="atchFileMstId" id="atchFileMstId" data-col="atchFileMstId" value=""/>
				
				<%-- 기본정보 작성 화면 --%>
				<c:choose>
					<c:when test= "${param.status eq 'VOC01' or param.status eq 'VOC11'}">						
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
								<td data-col="vocNo"><input type="text" id="vocNo" name="vocNo" class="form-control" value="" readonly /></td>
								<th>접수부서</th>
								<td data-col="createDept"><input type="hidden" name="createDept" id="createDept" class="form-control" value="" readonly /></td>
								<th>접수자</th>
								<td><%=loginUser.getNmKo()%><input type="hidden" name="createUser" id="createUser" value="<%=loginUser.getLoginId()%>" /></td>
								<th>접수일</th>
								<td><%=DateUtil.getCurrentDate()%> <input type="hidden" name="createDate" id="createDate" class="form-control" data-col="createDate" value="<%=DateUtil.getCurrentDate()%>" readonly></td>
								<th><span class="ui_icon required"></span>사업구분</th>
								<td>
									<select id="bssArea" name="bssArea" class="form-control input-sm" data-type="search" data-col="bssArea">
										<option value="">선택</option>
										<option value="SMC">반도체</option>
										<option value="DP">디스플레이</option>
									</select>
								</td>
							</tr>
							<tr>
								<th><span class="ui_icon required"></span>고객사</th>
								<td><input type="text" id="custNm" name="custNm" class="form-control" value=""  data-col="custNm" /></td>
								<th><span class="ui_icon required"></span>고객담당자</th>
								<td><input type="text" id="custUserNm" name="custUserNm" class="form-control" value="" data-col="custUserNm" /></td>
								<th><span class="ui_icon"></span>고객담당자메일</th>
								<td><input type="text" id="custUserEmail" name="custUserEmail" class="form-control" value="" data-col="custUserEmail" /></td>
								<th><span class="ui_icon required"></span>고객F/B실행여부</th>	
								<td>
									<select id="custFbYn" name="custFbYn" class="form-control input-sm" data-type="search" data-col="custFbYn" >
										<option value="">선택</option>
										<option value="Y">Y</option>
										<option value="N">N</option>
									</select>
								</td>							
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
										<button type="button" class="btn btn-primary" id="addSulbi" style="padding: 3px 5px;"> <i class="fa fa-check"></i>추가</button>
										<button type="button" class="btn btn-primary" id="removeSulbi" style="padding: 3px 5px; background-color: #333; border-color: #333"> <i class="fa fa-check"></i>삭제</button>
									</div></th>
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
										<%-- 설비 정보 리스트 --%>
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
						
						<%-- 접수 반려인 경우 --%>
						<c:if test="${param.status eq 'VOC11'}">
							<h5 class="sub1_title" data-term="처리부서 지정"><i class="fa fa-file-text"></i></h5>
							(<span class="ui_icon required"></span> <span data-term="L.는_필수_입력항목"></span>)
							&nbsp&nbsp<button type="button" id="deptHideDiv_N" class="badge badge-pill badge-danger">숨기기</button>
							<button type="button" id="deptHideDiv_Y" style="display:none;" class="badge badge-pill badge-danger">보이기</button>
							<table class="basic" name="deptDiv">
								<colgroup>
									<col style="width: 15%;">
									<col style="width: 20%;">
									<col style="width: 15%;">
									<col style="width: 20%;">
									<col style="width: 15%;">
									<col style="width: 20%;">
								</colgroup>								
								<tr>
									<th><span class="ui_icon required"></span>접수진행여부</th>
									<td data-col="regAcceptNm"></td>
									<th>반려사유</th>
									<td data-col="regRejectReason"></td>
									<th>접수확정일자</th>
									<td data-col="regDecideDate"></td>
								</tr>								
								<tr id="gradeDiv">
									<th>등급분류</th>
									<td data-col="vocGradeType"></td>
									<th>처리부서</th>
									<td><button type="button" class="btn btn-primary" id="addProcessDept" style="padding: 3px 5px;"> <i class="fa fa-check"></i>부서 추가 </button></td>
									<th>순차지정</th>
									<td>
										<div class="form-check form-check-inline p-1">
			                                <label class="form-check-label" data-term="순차"><input class="form-check-input" type="radio" id="orderY" name="prcOrderYn" value="Y"></label>
			                                <label class="form-check-label" data-term="병렬"><input class="form-check-input" type="radio" id="orderN" name="prcOrderYn" value="N"></label>
		                            	</div>
	                            	</td>
								</tr>								
								<tr>
									<th>비고</th>
									<td colspan="5" data-col="regDecideOpinion"></td>
								</tr>
							</table>
						</c:if>
					</c:when>
					
					<c:when test= "${param.status eq 'VOC02' or param.status eq 'VOC12'}">
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
								<td data-col="vocNo"></td>
								<th>접수부서</th>
								<td data-col="createDept"></td>
								<th>접수자</th>
								<td data-col="createUser"></td>
								<th>접수일</th>
								<td data-col="createDate"></td>
								<th><span class="ui_icon required"></span>사업구분</th>
								<td data-col="bssArea"></td>
							</tr>
							<tr>
								<th><span class="ui_icon required"></span>고객사</th>
								<td data-col="custNm"></td>
								<th><span class="ui_icon required"></span>고객담당자</th>
								<td data-col="custUserNm"></td>
								<th><span class="ui_icon required"></span>고객담당자메일</th>
								<td data-col="custUserEmail"></td>
								<th><span class="ui_icon required"></span>고객F/B실행여부</th>
								<td data-col="custFbYn"></td>
								<th><span class="ui_icon required"></span>고객요청일</th>
								<td data-col="custReqDate"></td>
							</tr>
							<tr>
								<th><span class="ui_icon required"></span>접수유형</th>
								<td data-col="vocRegType"></td>
							</tr>
							<tr>
								<th><span class="ui_icon required"></span>제목</th>
								<td colspan="9" data-col="vocTitle"></td>
							</tr>		
							<tr>
								<th><span class="ui_icon required"></span>대상설비<br />
									<div style="margin-top: 5px;"> 
										<button type="button" class="btn btn-primary" id="addSulbi" style="padding: 3px 5px;"> <i class="fa fa-check"></i>추가</button>
										<button type="button" class="btn btn-primary" id="removeSulbi" style="padding: 3px 5px; background-color: #333; border-color: #333"> <i class="fa fa-check"></i>삭제</button>
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
		                        <td colspan="9" data-col="custReqContents" ></td>
		                    </tr>
		                    <tr>
		                        <th data-term="L.첨부"></th>
		                        <td colspan="9" id="bbsFile" name="bbsFile"></td>
		                    </tr>
						</table>
						
						<div id="deptDiv" style="display:none;">			
							<h5 class="sub1_title" data-term="처리부서 지정"><i class="fa fa-file-text"></i></h5>
							(<span class="ui_icon required"></span> <span data-term="L.는_필수_입력항목"></span>)
							&nbsp&nbsp<button type="button" id="deptHideDiv_N" class="badge badge-pill badge-danger">숨기기</button>
							<button type="button" id="deptHideDiv_Y" style="display:none;" class="badge badge-pill badge-danger">보이기</button>
							<table class="basic" name="deptDiv">
								<colgroup>
									<col style="width: 15%;">
									<col style="width: 20%;">
									<col style="width: 15%;">
									<col style="width: 20%;">
									<col style="width: 15%;">
									<col style="width: 20%;">
								</colgroup>
								<tr>
									<th><span class="ui_icon required"></span>접수진행여부</th>	
									<td>
										<select id="regAcceptYn" name="regAcceptYn" onchange="chageRegAcceptYn()" class="form-control input-sm" data-type="search">
											<option value="">선택</option>
											<option value="Y">진행</option>
											<option value="N">반려</option>
										</select>
									</td>
									<th>반려사유</th>
									<td><select id="regRejectReason" name="regRejectReason" class="form-control input-sm" data-type="search"></select></td>
									<th>접수확정일자</th>
									<td id="regDecideDateId"><input type="hidden" id="regDecideDate" name="regDecideDate" class="form-control"  data-col="regDecideDate" value="" readonly /></td>
								</tr>
								<tr id="gradeDiv">
									<th>등급분류</th>
									<td><select id="vocGradeType" name="vocGradeType" class="form-control input-sm" data-type="search"></select></td>
									<th>처리부서</th>
									<td><button type="button" class="btn btn-primary" id="addProcessDept" style="padding: 3px 5px;"> <i class="fa fa-check"></i>부서 추가 </button></td>
									<th>순차지정</th>
									<td>
										<div class="form-check form-check-inline p-1">
			                                <label class="form-check-label" data-term="순차"><input class="form-check-input" type="radio" id="orderY" name="prcOrderYn" value="Y"></label>
			                                <label class="form-check-label" data-term="병렬"><input class="form-check-input" type="radio" id="orderN" name="prcOrderYn" value="N"></label>
		                            	</div>
	                            	</td>
								</tr>
								<tr>
									<th>비고</th>
									<td colspan="5"><input type="text" id="regDecideOpinion"
										name="regDecideOpinion" class="form-control" data-col="regDecideOpinion" value="" /></td>
								</tr>	
							</table>
						</div>
						
						<%-- 처리현황 리스트 영역 --%>
						<div id="processDiv">						
						</div>
						<div id="processTotDiv">						
						</div>
					</c:when>
					<c:otherwise>
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
								<td data-col="vocNo"></td>
								<th>접수부서</th>
								<td data-col="createDept"></td>
								<th>접수자</th>
								<td data-col="createUser"></td>
								<th>접수일</th>
								<td data-col="createDate"></td>
								<th><span class="ui_icon required"></span>사업구분</th>
								<td data-col="bssArea"></td>
							</tr>
							<tr>
								<th><span class="ui_icon required"></span>고객사</th>
								<td data-col="custNm"></td>
								<th><span class="ui_icon required"></span>고객담당자</th>
								<td data-col="custUserNm"></td>
								<th><span class="ui_icon required"></span>고객담당자메일</th>
								<td data-col="custUserEmail"></td>
								<th><span class="ui_icon required"></span>고객F/B실행여부</th>
								<td data-col="custFbYn"></td>
								<th><span class="ui_icon required"></span>고객요청일</th>
								<td data-col="custReqDate"></td>
							</tr>
							<tr>
								<th><span class="ui_icon required"></span>접수유형</th>
								<td data-col="vocRegType"></td>
							</tr>
							<tr>
								<th><span class="ui_icon required"></span>제목</th>
								<td colspan="9" data-col="vocTitle"></td>
							</tr>		
							<tr>
								<th><span class="ui_icon required"></span>대상설비<br />
									<div style="margin-top: 5px;">
										<button type="button" class="btn btn-primary" id="addSulbi" style="padding: 3px 5px;"> <i class="fa fa-check"></i>추가</button>
										<button type="button" class="btn btn-primary" id="removeSulbi" style="padding: 3px 5px; background-color: #333; border-color: #333"> <i class="fa fa-check"></i>삭제</button>
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
		                        <td colspan="9" data-col="custReqContents" ></td>
		                    </tr>
		                    <tr>
		                        <th data-term="L.첨부"></th>
		                        <td colspan="9" id="bbsFile" name="bbsFile"></td>
		                    </tr>
						</table>
						
						<h5 class="sub1_title" data-term="처리부서 지정"><i class="fa fa-file-text"></i></h5>
						(<span class="ui_icon required"></span> <span data-term="L.는_필수_입력항목"></span>)
						&nbsp&nbsp<button type="button" id="deptHideDiv_N" class="badge badge-pill badge-danger">숨기기</button>
						<button type="button" id="deptHideDiv_Y" style="display:none;" class="badge badge-pill badge-danger">보이기</button>
						<table class="basic" name="deptDiv">
							<colgroup>
								<col style="width: 15%;">
								<col style="width: 20%;">
								<col style="width: 15%;">
								<col style="width: 20%;">
								<col style="width: 15%;">
								<col style="width: 20%;">
							</colgroup>
							<tr>
								<th><span class="ui_icon required"></span>접수진행여부</th>
								<td data-col="regAcceptNm"></td>
								<th>반려사유</th>
								<td data-col="regRejectReason"></td>
								<th>접수확정일자</th>
								<td data-col="regDecideDate"></td>
							</tr>
							<tr id="gradeDiv">
								<th>등급분류</th>
								<td data-col="vocGradeType"></td>
								<th>처리부서</th>
								<td>								
									<button type="button" class="btn btn-primary" id="addProcessDept" style="padding: 3px 5px;"> <i class="fa fa-check"></i>부서 추가 </button>
								</td>
								<th>순차지정</th>
								<td>
									<div class="form-check form-check-inline p-1">
		                                <label class="form-check-label" data-term="순차"><input class="form-check-input" type="radio" id="orderY" name="prcOrderYn" value="Y"></label>
		                                <label class="form-check-label" data-term="병렬"><input class="form-check-input" type="radio" id="orderN" name="prcOrderYn" value="N"></label>
	                            	</div>
                            	</td>
							</tr>
							<tr>
								<th>비고</th>
								<td colspan="5" data-col="regDecideOpinion"></td>
							</tr>
						</table>
						<%-- 처리현황 리스트 --%>
						<div id="processDiv">
						</div>
						<div id="processTotDiv">						
						</div>
					</c:otherwise>
				</c:choose>
	
				<div class="conButtonlist">
					<div class="right">
						<button type="button" class="btn btn-primary" id="btnTmpSave" data-term="임시저장" style="display:none;"><i class="fa fa-check"></i></button>
						<button type="button" class="btn btn-primary" id="btnRegSave" data-term="접수" style="display:none;"><i class="fa fa-check"></i></button>
						<button type="button" class="btn btn-primary" id="btnDeptSave" data-term="처리부서등록" style="display:none;"><i class="fa fa-check"></i></button>
						<button type="button" class="btn btn-primary" id="btnEmpSave" data-term="담당자등록" style="display:none;"><i class="fa fa-check"></i></button>
						<button type="button" class="btn btn-primary" id="btnProSave" data-term="처리등록" style="display:none;"><i class="fa fa-check"></i></button>
						<button type="button" class="btn btn-default" id="btnDelete" data-term="삭제" ><i class="fa fa-minus"></i></button>
					</div>
				</div>
			</div>
		</form>
	</div>
</div>

<script type="text/javascript">

//모달 팝업
var $modalDiv;

	$(document).ready(function() {

		console.info("[Loading Module: VOC 수정].....................");

		var VocView = new vocView();
		VocView.init();

	});

	var vocView = function() {
		
		//VOC 정보 파라미터
		var d_vocNo = $("#vocNo").val();
		var openerData = {"vocNo" : d_vocNo}
		var $vocWriteForm = $("#vocWriteForm");
		var tsaYn = $("#tsaYn").val();
		
		//진행상태 별 하단 버튼 show/hide 처리
		var status  = $("#status").val();
		if(status == "VOC01"){	//임시저장(접수자)
			$("#btnRegSave").show();
			$("#btnTmpSave").show();
		}else if(status == "VOC02" || status == "VOC12"){	//접수완료 or 재접수(접수자)
			$("#addSulbi").hide();
			$("#removeSulbi").hide();
			//TSA 권한자에게만 해당 영역을 노출하며 수정가능
			if(tsaYn == "Y"){
				$("#btnDeptSave").show();
				$("#deptDiv").attr('style', 'display:block');
			}
			
		}else if(status == "VOC03"){	//부서지정 or 잰행/완료 선택(VOC 권한자)
			$("#addSulbi").hide();
			$("#removeSulbi").hide();
			$("#btnEmpSave").show();
			$("#addProcessDept").attr("disabled", true);
			$("input:radio[name='prcOrderYn']").attr("disabled", true);
		}else if(status == "VOC04"){	//담당자지정(부서 그룹장, 팀장)
			$("#addSulbi").hide();
			$("#removeSulbi").hide();
			$("#btnProSave").show();
			$("#addProcessDept").attr("disabled", true);
			$("input:radio[name='prcOrderYn']").attr("disabled", true);
		}else if(status == "VOC11"){	//반려
			$("#btnRegSave").show();
			$("#btnTmpSave").show();
			$("input:radio[name='prcOrderYn']").attr("disabled", true);
			$("#addProcessDept").attr("disabled", true);
		}
		
		//VOC 정보 조회
		var loadData = function (jsonData) {
            var data = $.extend({}, openerData, jsonData);
            
            paragonCmm.callAjax("/voc/getSchVocSelectOne/json", data, function (json) {
                if (typeof json === "object") {
                	
                	//VOC 기본 정보
                	var master = json.data;
                	$.each(master, function (key, val) {
                        $("[data-col='" + key + "']", "#vocView").html(val);
                        var obj = $("[data-col='" + key + "']", "#vocView");
                        
                        if ("custReqDate" == key) {
                        	$("#" + key).datebox('setValue', val);
                        } else if ("vocRegType" == key){
                        	for (var i = 0; i < json.vocRegType.length; i++) {
            					$("#vocRegType").append(
            							"<option value='"+ json.vocRegType[i].dcode +"'>"
            									+ json.vocRegType[i].dname + "</option>");
            				}
                        	$("#vocRegType").find("option[value="+json.data.vocRegTypeCd+"]").attr("selected", "selected");
                        } else if ("bssArea" == key){
            				$("#bssArea").append("<option value='SMC'>반도체</option>");            					
            				$("#bssArea").append("<option value='DP'>디스플레이</option>");
                        	$("#bssArea").find("option[value="+json.data.bssAreaCd+"]").attr("selected", "selected");
                        } else if ("custFbYn" == key){
                 				$("#custFbYn").append("<option value='Y'>Y</option>");	
                 				$("#custFbYn").append("<option value='N'>N</option>");
                             	$("#custFbYn").find("option[value="+json.data.custFbYn+"]").attr("selected", "selected");
                        } else if ("regAcceptYn" == key){
                        	$("#regAcceptYn").find("option[value="+json.data.regAcceptYn+"]").attr("selected", "selected");
                        	
                        	//진행/반려 결정에 따라 활성화 값 변경
                        	var regAcceptYn = json.data.regAcceptYn;
                        	if(regAcceptYn == "Y"){	//진행
                        		$("#regRejectReason").attr("disabled", true);			//반려사유 비활성화                        		
                        	}else if(regAcceptYn == "N"){	//반려
                        		$("#vocGradeType").attr("disabled", true);	//등급분류 비활성화
                        		$("#addProcessDept").attr("disabled", true);	//처리부서 비활성화
                        		$("input:radio[name='prcOrderYn']").attr("disabled", true);	//순차지정 비활성화
                        	}
                        } else if ("regRejectReason" == key){
                        	$("#regRejectReason").append("<option value=''>선택</option>");
                        	for (var i = 0; i < json.regRejectReason.length; i++) {
            					$("#regRejectReason").append(
            							"<option value='"+ json.regRejectReason[i].dcode +"'>"
            									+ json.regRejectReason[i].dname + "</option>");
            				}
                        	$("#regRejectReason").find("option[value="+json.data.regRejectReasonCd+"]").attr("selected", "selected");
                        } else if ("vocGradeType" == key){
                        	$("#vocGradeType").append("<option value=''>선택</option>");
                        	for (var i = 0; i < json.vocGradeType.length; i++) {
            					$("#vocGradeType").append(
            							"<option value='"+ json.vocGradeType[i].dcode +"'>"
            									+ json.vocGradeType[i].dname + "</option>");
            				}
                        	$("#vocGradeType").find("option[value="+json.data.vocGradeTypeCd+"]").attr("selected", "selected");
                        } else if ("regDecideDate" == key){                        	
                        	$("#regDecideDateId").text(val);
                        } else if ("prcOrderYn" == key){
                        	$("input:radio[name='prcOrderYn']:radio[value='" + val + "']").attr("checked",true);                         	
                        } else {                        
                            $(obj).val(val);
                        }
                    });
                    
                	//VOC 연계 설비 정보
                    var sulbiList = json.sulbi.length;
                    if(sulbiList > 0){
                    	for(var i = 0; i < sulbiList; i++){
                    		var line = json.sulbi[i].line;
                        	var product = json.sulbi[i].product;
                        	var process = json.sulbi[i].process;
                        	var projectNo = isEmpty(json.sulbi[i].vocPjtNo);
                        	
                        	//동적 셋팅
                        	setViewSulbiList(line, product, process, projectNo);
                    	}
                    }
                    
                    //VOC 처리현황 정보
                    var processList = json.process.length;
                    if(processList > 0){
                    	//동적 셋팅
                    	for(var i = 0; i < processList; i++){
                    		var tbDeptCnt = i;
                    		
                    		var html = "";
                    		if(tbDeptCnt == 0){
                    			html += "<h5 class='sub1_title'><i class='fa fa-file-text'></i>처리현황</h5>";
                    			html += "(<span class='ui_icon required'>는_필수_입력항목</span>)";
                    			html += "&nbsp&nbsp<button type='button' id='processHideDiv_N' class='badge badge-pill badge-danger'>숨기기</button>"
                    			html += "<button type='button' id='processHideDiv_Y' style='display:none;' class='badge badge-pill badge-danger'>보이기</button>"
                    		}
                    		html += "<table class='basic' id='pr' name='prDiv'>";
                    		html +=	"<colgroup> <col style='width: 10%;'> <col style='width: 15%;'> <col style='width: 10%;'> <col style='width: 15%;'> <col style='width: 10%;'> <col style='width: 15%;'> <col style='width: 10%;'> <col style='width: 15%;'> </colgroup>";
                    		html +=	"<tr>"; 		
                    		html +=	"<th><span class='ui_icon required'></span>부서명</th> <td><input type='hidden' id='processDept"+tbDeptCnt+"' class='form-control' value='"+json.process[tbDeptCnt].deptCd+"' readonly />"+isEmpty(json.process[tbDeptCnt].deptNm)+"</td>";
                    		
                    		//VOC처리부서 지정 후 요청내용은 수정 못하도록 비활성화
                    		if(status == "VOC02"){
                    			html +=	"<th>진행요청내용</th> <td colspan='5'><input type='text' id='processReq"+tbDeptCnt+"' class='form-control' value='"+isEmpty(json.process[tbDeptCnt].deptReqContents)+"' /></td>";
                    		}else{
                    			html +=	"<th>진행요청내용</th> <td colspan='5' id='processReq"+tbDeptCnt+"'>"+isEmpty(json.process[tbDeptCnt].deptReqContents)+"</td>";	
                    		}
                    		html +=	"</tr>";							
                    		
                    		html +=	"<tr>";                     		
                    		//VOC처리담당자 지정 후 담당자 수정 못하도록 비활성화
                    		if(status == "VOC03"){
                    			html +=	"<th><span class='ui_icon required'></span>처리 담당자 지정</th> <td><input type='text' id='processUserId"+tbDeptCnt+"' name='processUserId"+tbDeptCnt+"' class='form-control' value='"+isEmpty(json.process[tbDeptCnt].prcUserNm)+"' /></td>";	
                    		}else{
                    			html +=	"<th><span class='ui_icon required'></span>처리 담당자 지정</th> <td id='processUserId"+tbDeptCnt+"'>"+isEmpty(json.process[tbDeptCnt].prcUserNm)+"</td>";
                    			html +=	"<th><span class='ui_icon required'></span>처리방안</th> <td> <select id='prcPlanType"+tbDeptCnt+"' class='form-control input-sm' data-type='search'></select> </td>";
                        		html +=	"<th><span class='ui_icon required'></span>대책완료예정일</th> <td> <input type='text' id='processPlanDate"+tbDeptCnt+"' class='form-control' style='width: 100%;'> </td>";
                        		html +=	"<th><span class='ui_icon required'></span>처리현황</th> <td> <select id='prcStatus"+tbDeptCnt+"' onchange='chagePrcStatus(\""+isEmpty(json.process[tbDeptCnt].prcStatus)+"\", \""+tbDeptCnt+"\")' onFocus='focus()' class='form-control input-sm' data-type='search'></select> </td>";
                        		html +=	"</tr>";
                        		
                        		html +=	"<tr>"; 	
                        		html +=	"<th>ECR/SCR No.</th> <td> <input type='text' id='processEcrNo"+tbDeptCnt+"' name='processEcrNo"+tbDeptCnt+"' class='form-control' value='"+isEmpty(json.process[tbDeptCnt].ecrNo)+"' /> </td>";
                        		html +=	"<th>ECR/SCR 진행현황</th> <td id='processEcrStatus"+tbDeptCnt+"'/>"+ isEmpty(json.process[tbDeptCnt].ecrStatus) +"</td>";
                        		html +=	"<th>결재상신</th> <td> <button type='button' id='processGw"+tbDeptCnt+"' onclick='approvalGw(\""+json.process[tbDeptCnt].vocNo+"\", \""+json.process[tbDeptCnt].seq+"\", \""+json.process[tbDeptCnt].deptCd+"\");' class='btn btn-primary' style='padding: 3px 5px;' />  <i class='fa fa-check'></i>결재상신 </button></td>";
                        		html +=	"<th>대책완료일</th> <td id='processCompDate"+tbDeptCnt+"'> </td>";
                        		html +=	"</tr>";
                        		
                        		html +=	"<tr>"; 
                        		html +=	"<th>처리내용</th> <td colspan='7'>";
                        		html +=	"<textarea name='processContents"+tbDeptCnt+"' id='processContents"+tbDeptCnt+"' style='width:100%;height:150px;' data-col='prcContents"+tbDeptCnt+"'>"+isEmpty(json.process[tbDeptCnt].prcContents)+"</textarea>";		
                        		html +=	"</td>";
                        		html +=	"</tr>";
                        			
                        		html +=	"<tr>";
                        		html +=	"<th data-term='L.첨부'></th>";
                        		html +=	"<td colspan='7' id='processFile"+tbDeptCnt+"'></td>";
                        	    html +=	"</tr>";
                    		}
                    		
                    	    html +=	"</table>";
                    		
                        	$("#processDiv").append(html);

                        	//처리현황 영역 기능 동적 셋팅
                        	if(status == "VOC03"){
                        		setEmpModal(tbDeptCnt);	//처리담당자 지정
                        	}else{
                        		setProDeptFile(tbDeptCnt);	//첨부파일
                        		setProDdCode(tbDeptCnt);	//기준정보 
                        		setProTmpDate(tbDeptCnt);	//완료예정일
                        		setEcrModal(tbDeptCnt);		//ECR/SCR 연계 정보
                        		setEditorTextArea(tbDeptCnt);	//요청내용 Editor
                        		
                            	if(isEmpty(json.process[tbDeptCnt].prcPlanType) != ""){
                            		$("#prcPlanType"+tbDeptCnt+"").find("option[value="+json.process[tbDeptCnt].prcPlanType+"]").attr("selected", "selected");
                            	}
                            	
                        		//처리현황의 진행상태값은 순서에 의해 지정할 수 있음(순서 : 현상파악시작 -> 현상파악완료 -> 대책완료)
                            	var bssArea = json.data.bssAreaCd;
                            	var prcStatus = isEmpty(json.process[tbDeptCnt].prcStatus);
                        		if(bssArea == "DP"){
                        			if(prcStatus == ""){
                        				$("#prcStatus"+tbDeptCnt+" option[value='101']").remove();
                        				$("#prcStatus"+tbDeptCnt+" option[value='103']").remove();
                        			}else if(prcStatus == "100"){
                        				$("#prcStatus"+tbDeptCnt+" option[value='103']").remove();
                        			}
                            	}else if(bssArea == "SMC"){
                            		if(prcStatus == ""){
                        				$("#prcStatus"+tbDeptCnt+" option[value='101']").remove();
                        			}
                            	}
                            	
                        		if(prcStatus != ""){
                        			$("#prcStatus"+tbDeptCnt+"").find("option[value="+prcStatus+"]").attr("selected", "selected");	
                        		}
                        		
                        		//현상파악 완료 이후에 대해서만 결재상신이 가능하도록 한다.
                            	if(prcStatus != "101"){
                            		$("#processGw"+tbDeptCnt+"").attr("disabled", true);
                            	}
                            	
                        		$("#processPlanDate"+tbDeptCnt+"").datebox('setValue', isEmpty(json.process[tbDeptCnt].prcPlanDate));
                        	}
                    	}
                    }
                    
                    /*
                    	종합 처리현황 영역(처리현황(SUM), 대책완료일(SUM))
                    	처리현황 : 처리현황 단계에서 최종 값
                    	대책완료일 : 대책완료가 모두 된 시점
                    	 -> DP : 담당자가 직접 지정
                    	 -> SMC : 결재상신에 따라 시스템에서 자동 지정
                    */
                    
                    //처리현황 리스트가 있을 경우
                    if((status == "VOC04")){                    	
                    	var html = "";
               			html += "<table class='basic' id='prTot' name='prTotDiv'>";
                		html +=	"<colgroup> <col style='width: 10%;'> <col style='width: 15%;'> <col style='width: 10%;'> <col style='width: 15%;'> </colgroup>";
                		html +=	"<tr>";
                		html +=	"<th>처리현황(SUM)</th><td>"+isEmpty(json.processTot.prcTotStatus)+"</td>";
                		html +=	"<th>대책완료일(SUM)</th><td>"+isEmpty(json.processTot.prcTotCompDate)+"</td>";
                		html +=	"</tr>";
                		
                		html +=	"</table>";
                		
                    	$("#processTotDiv").append(html);
                    }
                    
                    
                    loadForm(json.data["atchFileMstId"]); // 접수 첨부파일
                  	//첨부파일 key 셋팅
                    $("#relUid").val(json.data["atchFileMstId"]);
                    $("#atchFileMstId").val(json.data["atchFileMstId"]); 
                    
                  	//처리현황 영역 보이기 이벤트
            		$("#processHideDiv_Y").on("click", function(){
            			$("#processHideDiv_N").show();
            			$("#processHideDiv_Y").hide();
            			$("[name='prDiv']").show();            			
            		});
                  
                    //처리현황 영역 숨기기 이벤트
            		$("#processHideDiv_N").on("click", function(){
            			$("#processHideDiv_N").hide();
            			$("#processHideDiv_Y").show();
            			$("[name='prDiv']").hide();
            		});
            		
            		//처리부서 지정 영역 보이기 이벤트
            		$("#deptHideDiv_Y").on("click", function(){
            			$("#deptHideDiv_N").show();
            			$("#deptHideDiv_Y").hide();
            			$("[name='deptDiv']").show();
            		});
            		
            		//처리부서 지정 영역 숨기기 이벤트
            		$("#deptHideDiv_N").on("click", function(){
            			$("#deptHideDiv_N").hide();
            			$("#deptHideDiv_Y").show();
            			$("[name='deptDiv']").hide();
            		});
                }
            });
        }
		
		//null -> 공백 처리
		var isEmpty = function(value){
		    if(value == null || value.length === 0) {
		           return "";
		     } else{
		            return value;
		     }
		}

		/*
			* 접수 저장
			  -> 권한자 : 접수자			
		*/
		var doRegSubmit = function(gb) {
			var msg = paragonCmm.getLang("M.ALERT_SUBMIT", "L.저장");
			if (!doValidation("REG")) {
				return false;
			}
			confirm(msg, function(r) {
				if (r) {
					var SAVE_URL = "";
					if(gb == "S"){	//접수
						SAVE_URL = "/voc/saveMst/json";
					}else{	//임시저장
						SAVE_URL = "/voc/saveTmpMst/json";
					}
					
					paragonCmm.setEditorSubmit("");
					var data = $vocWriteForm.serializeObject();
					
					data.custReqContents = $vocWriteForm.find("textarea[name=custReqContents]").val().replace(/\"/gi, "'");
					
					var status  = $("#status").val();
					if(status == "VOC11"){	//반려일 경우 상태값 정의를 다르게 함
						data.rejectFlag = "Y";	
					}
					
					var sulbiArr = [];
					var dataObj = {};
					var params = {list: $("#sulbiList").tableDataToJson()};
					for(var i = 0; i < $("#sulbiTb tbody tr").length; i++){
						var line = $("#sulbiTb tbody tr").eq(i).children().eq(1).text();
						var product = $("#sulbiTb tbody tr").eq(i).children().eq(2).text();
						var process = $("#sulbiTb tbody tr").eq(i).children().eq(3).text();
						var project = $("#sulbiTb tbody tr").eq(i).children().eq(4).text();
						
						if(project == ""){
							project = params.list[i].vocPjtNo;
						}
						
						dataObj.line = line;
						dataObj.product = product;
						dataObj.process = process;
						dataObj.vocPjtNo = project;
						
						sulbiArr.push(dataObj);
						
						dataObj = {};
					}
					
					data.sulbiList = sulbiArr;
					data.processList = [];
					
					//파일저장이 필요할 땐 submitAjax를 써야한다 (callAjax에는 파일처리가 미포함)
					paragonCmm.submitAjax(SAVE_URL, data, function(json) {
						if (json.errYn === "E") {
							//오류처리
							alert(json.msg);
							return false;
						}						
						opener.parent.doSearch();
						window.close();
					});
				}
			});
		}

		/*
			* 부서 지정 저장
			  -> 권한자 : VOC 권한자(TSA)			
		*/
		var doDeptSubmit = function() {
			var msg = paragonCmm.getLang("M.ALERT_SUBMIT", "L.저장");
			if (!doValidation("DEPT")) {
				return false;
			}
			confirm(msg, function(r) {
				if (r) {
					var SAVE_URL = "/voc/saveProcess/json";
					var status  = $("#status").val();
					var data = $vocWriteForm.serializeObject();
					data.vocStatus = status;
					
					var processArr = [];
					var dataObj = {};
					for(var i = 0; i < $("#processDiv").children("#pr").length; i++){
						var deptCd = $("#processDept"+i).val();
						var deptNm = $("#processDept"+i).parent().text();
						var deptReqContents = $("#processReq"+i).val();
						
						dataObj.deptCd = deptCd;
						dataObj.deptNm = deptNm;
						dataObj.deptReqContents = deptReqContents;
						
						processArr.push(dataObj);
						
						dataObj = {};
					}
					
					data.processList = processArr;

					paragonCmm.submitAjax(SAVE_URL, data, function(json) {
						if (json.errYn === "E") {
							//오류처리
							alert(json.msg);
							return false;
						}						
						opener.parent.doSearch();
						window.close();						
					});
				}
			});
		}
		
		/*
			* 담당자 지정 저장
			  -> 권한자 : 지정 부서의 그룹장, 팀장		
		*/
		var doEmpSubmit = function() {
			var msg = paragonCmm.getLang("M.ALERT_SUBMIT", "L.저장");
			if (!doValidation("EMP")) {
				return false;
			}
			confirm(msg, function(r) {
				if (r) {
					var SAVE_URL = "/voc/saveEmpProcess/json";					
					var data = $vocWriteForm.serializeObject();					
					
					var processArr = [];
					var dataObj = {};
					for(var i = 0; i < $("#processDiv").children("#pr").length; i++){
						var deptCd = $("#processDept"+i).val();
						var deptNm = $("#processDept"+i).parent().text();
						var deptReqContents = $("#processReq"+i).text();
						
						dataObj.deptCd = deptCd;
						dataObj.deptNm = deptNm;
						dataObj.deptReqContents = deptReqContents;
						
						var userId = $("#processUserId"+i).val();
						var prcUserId = "";
						if(userId != ""){
							const str = userId.split("(");
							prcUserId = str[1].substring(0, str[1].length-1);
						}
						
						dataObj.prcUserId = prcUserId;
						dataObj.prcUserNm = userId;
						
						processArr.push(dataObj);
						
						dataObj = {};
					}
					
					data.processList = processArr;
					
					paragonCmm.submitAjax(SAVE_URL, data, function(json) {
						if (json.errYn === "E") {
							//오류처리
							alert(json.msg);
							return false;
						}						
						opener.parent.doSearch();
						window.close();
					});
				}
			});
		}
		
		/*
			* 처리현황 정보 저장
			  -> 권한자 : 처리 담당자		
		*/
		var doProSubmit = function() {
			var msg = paragonCmm.getLang("M.ALERT_SUBMIT", "L.저장");
			if (!doValidation("PRO")) {
				return false;
			}
			confirm(msg, function(r) {
				if (r) {
					var SAVE_URL = "/voc/saveProProcess/json";					
					var status  = $("#status").val();
					var data = $vocWriteForm.serializeObject();
					data.vocStatus = status;	//VOC04
					
					var processArr = [];
					var dataObj = {};
					for(var i = 0; i < $("#processDiv").children("#pr").length; i++){
						var deptCd = $("#processDept"+i).val();
						var prcPlanType = $("#prcPlanType"+i).val();
						var prcPlanDate = $("#processPlanDate"+i).val();
						var prcStatus = $("#prcStatus"+i).val();
						var ecrNo = $("#processEcrNo"+i).val();
						
						dataObj.deptCd = deptCd;
						dataObj.prcPlanType = prcPlanType;
						dataObj.prcPlanDate = prcPlanDate;
						dataObj.prcStatus = prcStatus;
						dataObj.ecrNo = ecrNo;
						
						paragonCmm.setEditorSubmit("");
						var contents = $("[name='prDiv']").find("textarea[name=processContents"+i+"]").val();
						if(contents != ""){
							dataObj.prcContents = contents.replace(/\"/gi, "'");	
						}else{
							dataObj.prcContents = "";
						}
						
						var atchFileId = data._attachFileRelUid[i];
						dataObj.atchFileId = atchFileId;
						
						processArr.push(dataObj);
						
						dataObj = {};
					}
					
					data.processList = processArr;
					
					paragonCmm.submitAjax(SAVE_URL, data, function(json) {
						if (json.errYn === "E") {
							//오류처리
							alert(json.msg);
							return false;
						}						
						opener.parent.doSearch();
						window.close();
					});
				}
			});
		}
		
		// 임시저장( or 등록) 필수체크 항목
		var doValidation = function(gb) {
		
			//var status  = $("#status").val();
			if(gb == "REG"){
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
				
				if ($("input:text[name='custUserEmail']", $vocWriteForm).val() == "") {
					alert("고객담당자메일을 입력해주세요.", function() {
						$("input:text[name='custUserEmail']", $vocWriteForm).focus();
					});
					return false;
				}
				
				if ($("#custFbYn option:selected").val() == "") {
					alert("고객F/B실행여부를 선택해주세요.", function() {
						$("input:text[name='custFbYn']", $vocWriteForm).focus();
					});
					return false;
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
			}else if(gb == "DEPT"){
				if ($("#regAcceptYn option:selected").val() == "") {
					alert("접수진행여부를 선택해주세요.", function() {
						$("input:text[name='regAcceptYn']", $vocWriteForm).focus();
					});
					return false;
				}
				
				//진행일 경우 등급분류, 처리부서, 순차지정 필수 선택 체크
				var regAcceptYn = $("#regAcceptYn").val();
				if(regAcceptYn == "Y"){
					if ($("#vocGradeType option:selected").val() == "") {
						alert("등급분류를 선택해주세요.", function() {
							$("input:text[name='vocGradeType']", $vocWriteForm).focus();
						});
						return false;
					}
					
					var chkPrOrderYn = $("input:radio[name='prcOrderYn']:checked");
					if(chkPrOrderYn.length == 0){
						alert("순차지정을 선택해 주세요.");
						return false;
					}
					
					var trCnt = $("#processDiv").children("#pr").length;
					if(trCnt == "0"){
						alert("부서지정을 하나 이상 선택하셔야합니다.");
						return false;
					}
				}
				
				//반려일 경우 반려 사유 필수 선택 체크
				if(regAcceptYn == "N"){
					if ($("#regRejectReason option:selected").val() == "") {
						alert("반려사유를 선택해주세요.", function() {
							$("input:text[name='regRejectReason']", $vocWriteForm).focus();
						});
						return false;
					}	
				}
				
			}else if(gb == "EMP"){
				//처리 담당자 지정 프로세스 -> 여러 부서 사람 지정해야하므로 제약은 없음
				
			}else if(gb == "PRO"){
				
			}
			
			return true;
		}

		//VOC 삭제
		var deleteVoc = function() {
			var msg = paragonCmm.getLang("M.ALERT_SUBMIT", "L.삭제");
			confirm(msg, function(r) {
				if (r) {

					paragonCmm.setEditorSubmit("");
					var data = {"vocNo" : $("#vocNo").val()};
					
					paragonCmm.submitAjax("/voc/deleteMst/json", data, function(json) {
						if (json.errYn === "E") {
							//오류처리
							alert(json.msg);
							return false;
						}						
						opener.parent.doSearch();
						window.close();
					});
				}
			});
			
		}
		
		//웹에디터 첨부파일 Form 로드
		var loadForm = function(atchFileMstId) {
			var options = {}
			var status  = $("#status").val();
            options.relUid = atchFileMstId;  //관례 키 UID
            options.fileTpCd = "CMM/BBS";    //파일 유형 코드
            options.defaultRelUid = "";      //기본 로드 첨부파일(수정시)
            
            //저장 완료 시 첨부파일 수정 못하도록 지정
            if(status == 'VOC02' || status == 'VOC03' || status == 'VOC12' || status == 'VOC04'){
            	htmlUtils.loadFileView("bbsFile", options);
            }else{
            	htmlUtils.loadFileHtml("bbsFile", options);	
            }   
		}

		//최초 컴포넌트 셋팅
		var initFormComponent = function() {			
			$("#custReqDate").datebox({});		//고객요청일
		}
	
		//최초 버튼 이벤트 셋팅
		var attchmentEvent = function() {
			$("#btnRegSave").off();
			$("#btnRegSave").on("click", function() {
				doRegSubmit("S");
			});
			$("#btnDelete").on("click", function() {
				deleteVoc();
			});
			$("#btnTmpSave").off();
			$("#btnTmpSave").on("click", function() {
				doRegSubmit("T");
			});
			$("#btnDeptSave").off();
			$("#btnDeptSave").on("click", function() {
				doDeptSubmit();
			});
			$("#btnEmpSave").off();
			$("#btnEmpSave").on("click", function() {
				doEmpSubmit();
			});
			$("#btnProSave").off();
			$("#btnProSave").on("click", function() {
				doProSubmit();
			});
		}

		//모달 팝업 셋팅
		var modalTitle = "";
		var modalUrl = "";
		var width = "";

		//고객사 선택
		$("input:text[name='custNm']", "#vocWriteForm").off();
		$("input:text[name='custNm']", "#vocWriteForm").on("click", function() {
			modalTitle = "고객사 선택";
			modalUrl = "/voc/schCustDialog.modal";
			width = 500;
			openModal(this, modalTitle, modalUrl);
		});
		
		//처리부서 선택
		$("#addProcessDept").on("click", function() {
			modalTitle = "처리부서 선택";
			modalUrl = "/voc/schDeptDialog.modal";
			width = 500;
			openModal(this, modalTitle, modalUrl);
		});

		//설비 선택
		$("#addSulbi").on("click", function() {
			modalTitle = "대상 설비 선택";
			modalUrl = "/voc/schSulbiDialog.modal";
			width = 1500;
			openModal(this, modalTitle, modalUrl);
		});
		
		//설비 제거 이벤트
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
		
		//설비 추가 이벤트
		$("#addSulbi").on("click", function() {
			modalTitle = "대상 설비 선택";
			modalUrl = "/voc/schSulbiDialog.modal";
			width = 1500;
			openModal(this, modalTitle, modalUrl);
		});
		
		//모달 팝업
		var openModal = function(obj, modalTitle, modalUrl) {
			$(obj).val("");// 클릭시 값 초기화
			if (typeof $modalDiv != "object") {
				$modalDiv = $("<div>");
			}
			$modalDiv.window({
				iconCls : 'icon-search',
				width : width,
				height : 600,
				title : modalTitle,
				href : modalUrl,//"/voc/schCustDialog.modal",  //"/viself/module/moduleListDialog.modal",
				modal : true,
				onClose : function() {
					$modalDiv.window("destroy");
				},
				onLoad : function() {
					moduleList.init(function() {
					}, function(moduleId) {
						$(obj).val(moduleId);
						$modalDiv.window("destroy");
					});
					paragonCmm.convertLang($modalDiv); //-- 다국어 처리
				}
			});
		}

		var init = function() {
			initFormComponent();
			attchmentEvent();
			loadData();
		};
		
		return {
			init : init
		};
	}
	 
	//고객사 정보 set
	function setSchCust(code, name){
		$('#custCd').val(code);
		$('#custNm').val(name);
		$modalDiv.window("destroy");
	}
	
	//순차일 경우 현상파악완료 지정은 바로 앞 단계의 처리결과가 현상파악완료일 경우 지정이 가능 
	function chagePrcStatus(prcStatus, seq){
		var prev_val = prcStatus;
		if(seq > 0){
			var prevSeq = seq - 1;
			var prcStatus = $("#prcStatus"+prevSeq+" option:selected").val();
			if(prcStatus != "101"){	//현상파악완료가 아닐 경우
				alert("전 처리상태가 현상파악완료가 되야 지정이 가능합니다.");
				$("#prcStatus"+seq).val(prev_val).prop("selected", true);	//이전 값으로 되돌림
			}
		}
	}
	
	//현상파악완료 후 결재상신
	function approvalGw(vocNo, seq, deptCd){
		var msg = paragonCmm.getLang("M.ALERT_SUBMIT", "결재상신 진행하시겠습니까?");
		var prcStatus = $("#prcStatus"+seq).val();
		
		if (prcStatus != "101") {
			alert("현상파악완료일 경우에만 결재상신할 수 있습니다.");
			return false;
		}
		
		confirm(msg, function(r) {
			if (r) {					
				var sysKey = vocNo + "-PRC-" + seq
				var data = {
						"cmpId" : "1",
						"interId" : "I",
						"sysId" : "VOC_PRC",
						"sysKey" : sysKey,
						"seq" : "1",		
						"userId" : $("#loginUserId").val(),
						"formPrefix" : "IPS_WF_ERP_003",
						"title" : "VOC 대책완료보고 (" + vocNo + ")",
						"body" : "",
						"status" : "0",	//기안 시작일 경우
						"formName" : "VOC 대책완료보고",
						"vocNo" : vocNo,
						"deptCd" : deptCd,
						"prcSeq" : seq
				}
				
				$.ajax({
                       type: "POST",
                       url: SAVE_URL = "/voc/prcApproval/json",
                       data: JSON.stringify(data),
                       success: function(data){
                           if(data.errYn !== "E"){
                           	var gwData = "cmpid=1&inter_id=I&sysid=VOC_PRC&sys_key="+sysKey+"&seq=1&edit_mode=Y";
                           	window.open("https://gw.wonik.com/Website/Approval/Forms/FormLinkForLEGACY_IPS.aspx?"+gwData, "_blank", "toolbar=yes,scrollbars=yes,resizable=yes,width=2000,height=1000");
                           }else{
                               $.messager.alert("Warning",data.msg, "warning");
                           }
                       },
                       dataType: "json",
                       contentType: "application/json"
                   });
			}
		});
	}
	
	//처리부서 DIV set
	function setSchDept(code, name){
		
		var tbDeptCnt = $("#processDiv").children("#pr").length;
		
		var html = "";
		if(tbDeptCnt == 0){
			html += "<h5 class='sub1_title'><i class='fa fa-file-text'></i>처리현황</h5>";
			html += "(<span class='ui_icon required'>는_필수_입력항목</span>)";
			html += "&nbsp&nbsp<button type='button' id='processHideDiv_N' class='badge badge-pill badge-danger'>숨기기</button>"
			html += "<button type='button' id='processHideDiv_Y' style='display:none;' class='badge badge-pill badge-danger'>보이기</button>"
		}
		
		html += "<table class='basic' id='pr' name='prDiv' style='margin-bottom: 2px;'>";
		html +=	"<colgroup> <col style='width: 10%;'> <col style='width: 15%;'> <col style='width: 10%;'> <col style='width: 15%;'> <col style='width: 10%;'> <col style='width: 15%;'> <col style='width: 10%;'> <col style='width: 15%;'> </colgroup>";
	
		html +=	"<tr>"; 		
		html +=	"<th><span class='ui_icon required'></span>부서명</th> <td><input type='hidden' id='processDept"+tbDeptCnt+"' class='form-control' value='"+code+"' readonly />"+name+"</td>";
		html +=	"<th>진행요청내용</th> <td colspan='5'><input type='text' id='processReq"+tbDeptCnt+"' class='form-control' value='' /></td>";
		html +=	"</tr>";							
		
		/* html +=	"<tr>"; 		
		html +=	"<th>처리 담당자 지정</th> <td><input type='text' id='processUserId"+tbDeptCnt+"' name='processUserId"+tbDeptCnt+"' class='form-control' value='' /></td>";
		html +=	"<th>처리방안</th> <td> <select id='prcPlanType"+tbDeptCnt+"' class='form-control input-sm' data-type='search'></select> </td>";
		html +=	"<th>대책완료예정일</th> <td> <input type='text' id='processPlanDate"+tbDeptCnt+"' class='form-control' style='width: 100%;'> </td>";
		html +=	"<th>처리현황</th> <td> <select id='prcStatus"+tbDeptCnt+"' class='form-control input-sm' data-type='search'></select> </td>";
		html +=	"</tr>";
		  
		html +=	"<tr>"; 	
		html +=	"<th>ECR/SCR No.</th> <td> <input type='text' id='processEcrNo"+tbDeptCnt+"' name='processEcrNo"+tbDeptCnt+"' class='form-control' value='' /> </td>";
		html +=	"<th>ECR/SCR 진행현황</th> <td> <input type='text' id='processEcrStatus"+tbDeptCnt+"' class='form-control' value='' /> </td>";
		html +=	"<th>결재상신</th> <td> <input type='text' id='processGw"+tbDeptCnt+"' class='form-control' value='' /> </td>";
		html +=	"<th>대책완료일</th> <td> <input type='text' id='processCompDate"+tbDeptCnt+"' class='form-control' value='' /> </td>";
		html +=	"</tr>";
		
		html +=	"<tr>"; 
		html +=	"<th>처리내용</th> <td colspan='7'>";		
		html +=	"<textarea name='processContents"+tbDeptCnt+"' id='processContents"+tbDeptCnt+"' style='width:100%;height:150px;' data-col='processContents"+tbDeptCnt+"'></textarea>";		
		html +=	"</td>";
		html +=	"</tr>"; 
		
		html +=	"<tr>";
		html +=	"<th>첨부</th>";
		html +=	"<td colspan='7' id='processFile"+tbDeptCnt+"'></td>";
	    html +=	"</tr>"; */
	    
	    html +=	"</table>";
		
    	
    	$("#processDiv").append(html);

    	setProDeptFile(tbDeptCnt);
    	setProDdCode(tbDeptCnt);
		setProTmpDate(tbDeptCnt);
    	setEmpModal(tbDeptCnt);
    	setEcrModal(tbDeptCnt);
    	setEditorTextArea(tbDeptCnt);
    	//setDivOption();
    	
    	//처리현황 영역 보이기 이벤트
   		$("#processHideDiv_Y").on("click", function(){			
   			$("#processHideDiv_N").show();
   			$("#processHideDiv_Y").hide();
   			$("[name='prDiv']").show();            			
   		});
         
        //처리현황 영역 숨기기 이벤트
   		$("#processHideDiv_N").on("click", function(){			
   			$("#processHideDiv_N").hide();
   			$("#processHideDiv_Y").show();
   			$("[name='prDiv']").hide();            			
   		});
           
		$modalDiv.window("destroy");
	}
	
	function setProDeptFile(tbDeptCnt) {
		var options = {}
        //options.relUid = $("#atchFileId").val().replaceAll("B","S");
		options.relUid = $("#atchFileMstId").val()+"_P"+tbDeptCnt;
        options.fileTpCd = "CMM/BBS";    //-- 파일 유형 코드
        options.defaultRelUid = "";        //-- 기본 로드 첨부파일(수정시)
    	htmlUtils.loadFileHtml("processFile"+tbDeptCnt, options);
	}
	
	function setProTmpDate(tbDeptCnt){
		$("#processPlanDate"+tbDeptCnt).datebox({});	//대책완료예정일
	}
	
	function setEditorTextArea(tbDeptCnt) {		
		CKEDITOR.replace("processContents"+tbDeptCnt, {width:"100%",height:"150px",language:"ko"});
	}
	
	function setProDdCode(tbDeptCnt){
		var iData = {};
		paragonCmm.callAjax("/voc/getDdList/json", iData, function(json) {
			
			//구분
			$("#prcPlanType"+tbDeptCnt).append("<option value=''>선택</option>");
			for (var i = 0; i < json.prcPlanType.length; i++) {				
				$("#prcPlanType"+tbDeptCnt).append(
						"<option value='"+ json.prcPlanType[i].dcode +"'>"
								+ json.prcPlanType[i].dname + "</option>");
			}
			
			$("#prcStatus"+tbDeptCnt).append("<option value=''>선택</option>");
			for (var i = 0; i < json.prcStatus.length; i++) {				
				$("#prcStatus"+tbDeptCnt).append(
						"<option value='"+ json.prcStatus[i].dcode +"'>"
								+ json.prcStatus[i].dname + "</option>");
			}
			
			//반도체 경우 대책완료는 결재상신 완료로 대체
			var bssArea = $("[data-col='bssArea']", "#vocView").text();
        	if(bssArea == "반도체"){
        		$("#prcStatus"+tbDeptCnt+" option[value='103']").remove();
        	}
        	
		});
		
	}
	
	function setEmpModal(tbDeptCnt){
		$("input:text[name='processUserId"+tbDeptCnt+"']", "#vocWriteForm").off();
		$("input:text[name='processUserId"+tbDeptCnt+"']", "#vocWriteForm").on("click", function() {
			modalTitle = "처리담당자 선택";
			modalUrl = "/voc/schEmpDialog.modal";
			width = 500;
			openModal(this, modalTitle, modalUrl);
		});
		
		var openModal = function(obj, modalTitle, modalUrl) {
			$(obj).val("");// 클릭시 값 초기화
			if (typeof $modalDiv != "object") {
				$modalDiv = $("<div>");
			}
			$modalDiv.window({
				iconCls : 'icon-search',
				width : width,
				height : 600,
				title : modalTitle,//"고객사 선택",
				href : modalUrl,//"/voc/schCustDialog.modal",  //"/viself/module/moduleListDialog.modal",
				modal : true,
				onClose : function() {
					$modalDiv.window("destroy");
				},
				onLoad : function() {
					moduleList.init(function() {
						//-- init Function
					}, function(moduleId) {
						//-- callback Function
						$(obj).val(moduleId);
						$modalDiv.window("destroy");
					}); //-- init,콜백 Function 지정
					paragonCmm.convertLang($modalDiv); //-- 다국어 처리
				}
			});
		}
	}
	
	function setEcrModal(tbDeptCnt){
		$("input:text[name='processEcrNo"+tbDeptCnt+"']", "#vocWriteForm").off();
		$("input:text[name='processEcrNo"+tbDeptCnt+"']", "#vocWriteForm").on("click", function() {
			modalTitle = "ECR 선택";
			modalUrl = "/voc/schEcrDialog.modal";
			width = 1000;
			openModal(this, modalTitle, modalUrl);
		});
		
		var openModal = function(obj, modalTitle, modalUrl) {
			$(obj).val("");// 클릭시 값 초기화
			if (typeof $modalDiv != "object") {
				$modalDiv = $("<div>");
			}
			$modalDiv.window({
				iconCls : 'icon-search',
				width : width,
				height : 600,
				title : modalTitle,//"고객사 선택",
				href : modalUrl,//"/voc/schCustDialog.modal",  //"/viself/module/moduleListDialog.modal",
				modal : true,
				onClose : function() {
					$modalDiv.window("destroy");
				},
				onLoad : function() {
					moduleList.init(function() {
						//-- init Function
					}, function(moduleId) {
						//-- callback Function
						$(obj).val(moduleId);
						$modalDiv.window("destroy");
					}); //-- init,콜백 Function 지정
					paragonCmm.convertLang($modalDiv); //-- 다국어 처리
				}
			});
		}
	}
	
	//대상 설비 선택 시
	function setSulbiList(line, product, process) {
		
		var trCnt = $("#sulbiTb >tbody tr").length;
		var innerHtml = "";
		innerHtml += '<tr>';
		innerHtml += '<td>' + '<input type="checkbox" id="chk_'+trCnt+'" name="chkSulbi"></td>';
		innerHtml += '<td>' + line["lineNm"] + '</td>';
		innerHtml += '<td>' + product["prodNm"] + '</td>';
		innerHtml += '<td>' + process["processNm"] + '</td>';		
		//innerHtml += '<td><input type="text" id="vocPjtNo_'+trCnt+'" name="vocPjtNo_'+trCnt+'" class="form-control" value=""/></td>';
		innerHtml += '<td><input type="text" id="vocPjtNo" name="vocPjtNo" class="form-control" value=""/></td>';
		innerHtml += '</tr>';	
		
		$("#sulbiTb > tbody:last").append(innerHtml);

		$modalDiv.window("destroy");
		
		//동적이기 때문에 Project 선택 modal 이벤트를 다시 생성
		var openPjtSchModal = function(obj, modalTitle, modalUrl) {
			$(obj).val("");// 클릭시 값 초기화
			if (typeof $modalDiv != "object") {
				$modalDiv = $("<div>");
			}
			$modalDiv.window({
				iconCls : 'icon-search',
				width : width,
				height : 600,
				title : modalTitle,
				href : modalUrl,
				modal : true,
				onClose : function() {
					$modalDiv.window("destroy");
				},
				onLoad : function() {
					moduleList.init(function() {
						//-- init Function
					}, function(moduleId) {
						//-- callback Function
						$(obj).val(moduleId);
						$modalDiv.window("destroy");
					}); //-- init,콜백 Function 지정
					paragonCmm.convertLang($modalDiv); //-- 다국어 처리
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

	
	//대상 설비 선택 시
	function setViewSulbiList(line, product, process, projectNo) {
		
		var trCnt = $("#sulbiTb >tbody tr").length;
		var innerHtml = "";
		innerHtml += '<tr>';
		innerHtml += '<td>' + '<input type="checkbox" id="chk_'+trCnt+'" name="chkSulbi"></td>';
		innerHtml += '<td>' + line + '</td>';
		innerHtml += '<td>' + product + '</td>';
		innerHtml += '<td>' + process + '</td>';
		innerHtml += '<td>' + projectNo + '</td>';
		innerHtml += '</tr>';	
				
		$("#sulbiTb > tbody:last").append(innerHtml);
		
		//동적이기 때문에 Project 선택 modal 이벤트를 다시 생성
		var openPjtSchModal = function(obj, modalTitle, modalUrl) {
			$(obj).val("");// 클릭시 값 초기화
			if (typeof $modalDiv != "object") {
				$modalDiv = $("<div>");
			}
			$modalDiv.window({
				iconCls : 'icon-search',
				width : width,
				height : 600,
				title : modalTitle,
				href : modalUrl,
				modal : true,
				onClose : function() {
					$modalDiv.window("destroy");
				},
				onLoad : function() {
					moduleList.init(function() {
						//-- init Function
					}, function(moduleId) {
						//-- callback Function
						$(obj).val(moduleId);
						$modalDiv.window("destroy");
					}); //-- init,콜백 Function 지정
					paragonCmm.convertLang($modalDiv); //-- 다국어 처리
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
	
	//접수진행여부에 따른 변경 값
	function chageRegAcceptYn(){
		var ing = $("#regAcceptYn option:selected").val();
		if(ing == "N"){	//반려
			$("#regRejectReason").attr("disabled", false);
			$("#regDecideDateId").text("<%=DateUtil.getCurrentDate()%>");
			$("#vocGradeType").val("");
			$("#vocGradeType").attr("disabled", true);
			$("#addProcessDept").attr("disabled", true);
			
			$("input:radio[name='prcOrderYn']").attr("disabled", true);
			$("input:radio[name='prcOrderYn']").prop("checked", false);
			
			$("#regDecideOpinion").val("");
		}else {	//진행			
			$("#regRejectReason").attr("disabled", true);
			$("#regRejectReason").val("");
			//$("#regDecideDateId").text("");
			$("#regDecideDateId").text("<%=DateUtil.getCurrentDate()%>");
			$("#vocGradeType").val("");
			$("#vocGradeType").attr("disabled", false);		
			$("#addProcessDept").attr("disabled", false);
			
			$("input:radio[name='prcOrderYn']").attr("disabled", false);
			
			$("#regDecideOpinion").val("");
		}
		
	}

</script>

<%-- <script src="<c:url value='/js/module/viself/auth/urlMng.js'/>"></script> --%>
