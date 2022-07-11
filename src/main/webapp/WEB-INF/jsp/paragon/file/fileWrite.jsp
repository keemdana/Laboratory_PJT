<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.vertexid.commons.utils.ParamMap"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="java.util.List"%>
<%@page import="com.vertexid.commons.utils.StringUtil"%>
<%@page import="com.vertexid.commons.utils.CommonConstants"%>
<%@page import="com.vertexid.viself.hr.SysLoginVO"%>
<%
    //-- 검색값 셋팅
    String relUid						= StringUtil.convertNull(request.getAttribute("relUid"));
    String defaultRelUid				= StringUtil.convertNull(request.getAttribute("defaultRelUid"));
    String fileTpCd						= StringUtil.convertNull(request.getAttribute("fileTpCd"));
    String requiredYn                   = StringUtil.convertNull(request.getAttribute("requiredYn"));
    String maxFileSize                  = StringUtil.convertNull(request.getAttribute("maxFileSize"));
    String fileFilter                   = StringUtil.convertNull(request.getAttribute("allowExt"));
    String fileRFilter                  = StringUtil.convertNull(request.getAttribute("denyExt"));
    String maxFileCount                 = StringUtil.convertNull(request.getAttribute("maxFileCount"));

    String singleClass              	= (!"1".equals(maxFileCount) ? "" : "single");

    String pdfConvYn					= StringUtil.convertNull(request.getAttribute("pdfConvYn"));
//     singleClass = ""; //REVIEW :  싱글/멀티 첨부 상관없이 멀티로만 첨부하기 위해 값을 없애 놓았음

    //-- 결과값 셋팅
	List<Object> defaultViewResult    = (List<Object>)request.getAttribute("defaultViewResult");
	List<Object> viewResult           = (List<Object>)request.getAttribute("viewResult");

    String isNew = "false";

    if(!relUid.equals(defaultRelUid)){
    	isNew = "true";
    }

    if(viewResult != null && viewResult.size() > 0){

    }else{
    	viewResult = defaultViewResult;
    }
    //-- 기타값 셋팅
    String ctrlUuid             = StringUtil.getRandomUUID(); //컨트롤을 식별할 고유 아이디 생성!
    //-- pdf 변환 boolean
    boolean pdfConv = "Y".equals(pdfConvYn)?true:false;

    String userAgent = request.getHeader("User-Agent");
    String height = "115px";
    if("1".equals(maxFileCount)){
    	height = "35px";
    }
    String margin = "40px";
    if("1".equals(maxFileCount)){
    	margin = "0px";
    }
%>
<div id="fileArea_<%=ctrlUuid%>">
<input type="hidden" name="_attachFileCtrlUuid" value="<%=(ctrlUuid)%>" />
<input type="hidden" name="_attachFileRelUid" value="<%=(relUid)%>" />
<input type="hidden" name="_attachFileTpCd" value="<%=(fileTpCd)%>" />
<input type="hidden" name="_attachFileRequiredYn" value="<%=(requiredYn)%>" />
<div class="buttonlist">
	<div class="left">
		<span class="ui_btn small icon"><i class="fa fa-plus" onclick="openFileSelect<%=ctrlUuid%>();"><a href="javascript:void(0)" data-term="B.ADD"></a></i></span>
	</div>
	<div class="right">
		(<span id="file_size_<%=ctrlUuid%>">0</span>/<%=maxFileSize %> Kbyte)
	</div>
</div>

<input type="file" id="file_search_<%=ctrlUuid%>" style="display:none;" multiple="multiple"/>
<div class="file_Element_<%=ctrlUuid%>" style="border : 2px dotted #8296C2; width: 100%; height:<%=height%>; padding:5px;overflow: auto;">
<p id="file_notice_<%=ctrlUuid%>" class="file_Element_<%=ctrlUuid%>" style="font-size: 16px;color:#cdcdcd;width:200px;height:20px;margin: <%=margin %> auto;" data-term="L.파일_끌어다_놓기"></p>
<ul style="list-style: none;" class="ul_file_list">
<%
JSONArray jArr = new JSONArray();
if(viewResult != null && viewResult.size() > 0){
	for(int i=0; i <  viewResult.size();i++){
		ParamMap rowMap = (ParamMap)viewResult.get(i);
		//-- 스크립트 셋팅을 위해 air-File.js : arrFileInfo 변수에 셋팅
		JSONObject jObj = new JSONObject();
		jObj.put("isNew",isNew);
		jObj.put("ctrlUuid",ctrlUuid);
		jObj.put("fileTpCd",fileTpCd);
		jObj.put("relUid",relUid);
		jObj.put("atchUid",rowMap.getString("atchUid"));
		jObj.put("saveFileName",rowMap.getString("fileSaveNm"));
		jObj.put("fileName",rowMap.getString("fileNm"));
		jObj.put("fileSize",rowMap.getString("fileSize"));
		jArr.add(jObj);
		String byteNm	  = "KB";
		float fileSize = Integer.parseInt(rowMap.getString("fileSize")) / 1024;
		if(1024 < fileSize) {
    		fileSize = fileSize / 1024;
    		byteNm = "MB";
    	}
%>
	  <li id='<%=rowMap.getString("atchUid") %>' class='file_Element_<%=ctrlUuid%>' >
	  	<input type='hidden' name='atchUid'  value='<%=rowMap.getString("atchUid") %>' >
      	<i class='fa fa-times' style='color:red;' onclick='paragonFile.deleteFile("<%=ctrlUuid%>","<%=rowMap.getString("atchUid") %>");'></i>&nbsp;<%=rowMap.getString("fileNm") %> / <%=fileSize%><%=byteNm %>
       </li>
<%	}

%>
<%} %>
</ul>
</div>
</div>
<script>
$(function(){
	var jsonInit = {};
	jsonInit["requiredYn"] 		= "<%=requiredYn%>";	//--필수 체크여부
	jsonInit["maxFileSize"] 	= "<%=maxFileSize%>";	//--최대첨부크기
	jsonInit["maxFileCount"] 	= "<%=maxFileCount%>";	//--최대첨부갯수
	jsonInit["fileFilter"] 		= "<%=fileFilter%>";	//--허용첨부파일
	jsonInit["fileRFilter"] 	= "<%=fileRFilter%>";	//--불가첨부파일
	jsonInit["fileTpCd"] 		= "<%=fileTpCd%>";		//--파일타입코드
	jsonInit["relUid"] 			= "<%=relUid%>";		//--마스터 id
	jsonInit["defaultFile"] 	= <%=jArr.toString()%>;		//--기본수정모드 파일


	paragonFile.addFileEvent("<%=ctrlUuid%>",jsonInit);
	if($("li .ul_file_list").length > 0){
		$(".ul_file_list").sortable();
	}

	paragonCmm.convertLang($("#fileArea_<%=ctrlUuid%>"));

});
var openFileSelect<%=ctrlUuid%> = function(){

	$('#file_search_<%=ctrlUuid%>').click();

}
</script>