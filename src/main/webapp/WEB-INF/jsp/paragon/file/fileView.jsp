<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.vertexid.commons.utils.ParamMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="java.util.List"%>
<%@page import="com.vertexid.commons.utils.StringUtil"%>
<%@page import="com.vertexid.commons.utils.CommonConstants"%>
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
<div id="fileView_<%=ctrlUuid%>">
<ul style="list-style: none;" class="ul_file_list">
<%
if(viewResult != null && viewResult.size() > 0){
	for(int i=0; i <  viewResult.size();i++){
		ParamMap rowMap = (ParamMap)viewResult.get(i);
		String byteNm	  = "KB";
		float fileSize = Integer.parseInt(rowMap.getString("fileSize")) / 1024;
		if(1024 < fileSize) {
    		fileSize = fileSize / 1024;
    		byteNm = "MB";
    	}
%>
	  <li id='<%=rowMap.getString("atchUid") %>' class='file_Element_<%=ctrlUuid%>' >
	  	<i class="fa fa-save" style="color:#666"></i>
	  	<a href="javascript:htmlUtils.fileDownload('<%=rowMap.getString("atchUid") %>')" title="<%=rowMap.getString("fileNm") %>">&nbsp;<%=rowMap.getString("fileNm") %></a>
       </li>

<%	}

%>
<%} %>
</ul>
</div>
