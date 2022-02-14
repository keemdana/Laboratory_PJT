<%--
  - @(#)
  - Description:
  -     Def. Stu From Write
  --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  - [data-opener-data]
  -     dialog 혹은 popup 으로 본 페이지가 열릴경우 사용하는 opener data
  -     각 파티클에서는 $("#"+"<c:out value='${param.docUid}'/>"+"_stuFormWrite").data("opener-data"); 형태로 사용
  -     ex)
  -          var openerData = $("#"+"<c:out value='${param.docUid}'/>"+"_stuFormWrite").data("opener-data");
  --%>

<div id="<c:out value='${param.docUid}_stuFormWrite'/>" data-opener-data="<c:out value='${param.openerData}'/>">
	<input type="hidden" name="isProd" id="isProd" value="<c:out value="${isProd}"/>" />
	<input type="hidden" id="preFix" value="<c:out value="${param.docUid}"/>" />
	<form id="<c:out value="${param.docUid}"/>_saveForm" method="post">
		<input type="hidden" name="stuCd" id="<c:out value='${param.docUid}'/>_stuCd" value="<c:out value="${param.stuCd}"/>" />
		<input type="hidden" name="docUid" id="<c:out value='${param.docUid}'/>_docUid" value="<c:out value="${param.docUid}"/>" />
		<input type="hidden" name="stuDtl" id="<c:out value='${param.docUid}'/>_stuDtl" value="T"/>
		<input type="hidden" name="curStuDtl" id="<c:out value='${param.docUid}'/>_curStuDtl" value=""/>
		<input type="hidden" name="procType" id="<c:out value='${param.docUid}'/>_procType" value=""/>
		<input type="hidden" name="nextStuCd" id="<c:out value='${param.docUid}'/>_nextStuCd" value="<c:out value="${param.stuCd}"/>"/>
		<input type="hidden" name="stuTp" id="<c:out value='${param.docUid}'/>_stuTp" value=""/>
		<input type="hidden" name="stuTp2" id="<c:out value='${param.docUid}'/>_stuTp2" value=""/>
		<input type="hidden" name="ordNo" id="<c:out value='${param.docUid}'/>_ordNo" value=""/>
		<input type="hidden" name="lastYn" id="<c:out value='${param.docUid}'/>_lastYn" value="Y"/>
		<input type="hidden" name="groupUid" id="<c:out value='${param.docUid}'/>_groupUid" value="<c:out value="${param.groupUid}"/>"/>
		<input type="hidden" name="todoType" id="<c:out value='${param.docUid}'/>_todoType" value=""/>
		<input type="hidden" name="solMasUid" id="<c:out value='${param.docUid}'/>_solMasUid" value="<c:out value="${param.solMasUid}"/>"/>
		<input type="hidden" name="cud" id="<c:out value='${param.docUid}'/>_cud" value="C"/>
		<input type="hidden" name="mode" id="<c:out value='${param.docUid}'/>_mode" value="<c:out value="${param.mode}"/>" />
	</form>
<%-- 	<h3><i class="fa fa-angle-right" id="<c:out value='${param.docUid}'/>_writeCaption" > </i></h3> --%>
<!-- 	파티클 영역 -->
	<div id="<c:out value='${param.docUid}'/>_particleArea"></div>
<!-- 	메모/첨부영역 -->
	<table class="basic">
		<tr id="<c:out value='${param.docUid}'/>_memoArea" style="display:none;">
			<th class="th2" data-term="L.메모" id="<c:out value='${param.docUid}'/>_memoAreaTit"></th>
			<td class="td2">
				<textarea rows="5" class="form-control" maxlength="1000" id="<c:out value='${param.docUid}'/>_memo"></textarea>
			</td>
		</tr>
		<tr id="<c:out value='${param.docUid}'/>_fileArea" style="display:none;">
			<th class="th2" data-term="L.첨부파일" ></th>
			<td class="td2" colspan="3" id="<c:out value='${param.docUid}'/>_fileAreaId"></td>
		</tr>
	</table>
<!-- 	결재처리 영역 -->
	<div id="<c:out value='${param.docUid}'/>_stuAprvProcArea">
	</div>
<!-- 	다음처리 영역 -->
	<div id="<c:out value='${param.docUid}'/>_stuNextProcArea" style="display:none;">
		<br/>
		<table class="basic">
		<tr>
			<th class="th2" data-term="L.처리업무"></th>
			<td style="text-align:right;" id="<c:out value='${param.docUid}'/>_stuNextProcTbody">
			</td>
		</tr>
		</table>
	</div>
<!-- 	처리버튼 영역 -->
	<div class="buttonlist" >
		<div class="right" id="<c:out value='${param.docUid}'/>_btnProcArea">
<%-- 			<span id="KKKKKK<c:out value="${param.docUid}"/>" class="ui_btn medium icon"><i class="fa fa-edit"><a href="javascript:void(0)">수정</a></i></span> --%>
		</div>
	</div>
</div>
<BR />
<BR />
<script id="<c:out value='${param.docUid}'/>_stuAprvProcTmpl" type="text/x-jquery-tmpl">
<br/>
<h6 class="sub2_title"><i class="fa fa-caret-square-o-right"></i> \${paragonCmm.getLang('L.결재진행') }</h6>
<table class="basic">
	<tr>
		<th class="th4">\${paragonCmm.getLang('L.결재구분') }</th>
		<td class="td4">
			{{html htmlUtils.getInputRadio("aprStu", "Y|"+paragonCmm.getLang('L.승인')+"^R|"+paragonCmm.getLang('L.반려')+"","Y")}}
		</td>
		<th class="th4">\${paragonCmm.getLang('L.결재자') }</th>
		<td class="td4">
			<c:out value="${sessionUser.dspNmKo}"/>
		</td>
	</tr>
	<tr>
		<th class="th2">\${paragonCmm.getLang('L.결재의견') }</th>
		<td class="td2" colspan="3">
			<textarea class="form-control" name="aprMemo" id="aprMemo" maxlength="600" maxlength="600"></textarea>
		</td>
	</tr>
</table>
<div class="buttonlist">
	<div class="right" id="<c:out value='${param.docUid}'/>_btnAprProcArea"></div>
</div>
</script>
<script src="<c:url value='/js/module/paragon/def/defStuForm/defStuFormWrite.js'/>"></script>