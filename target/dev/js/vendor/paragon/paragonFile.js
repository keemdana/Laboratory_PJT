/**
 * AIR 시스템 파일 자바스크립트 도우미 객체
 * @returns {jsHelper_paragonCmm}
 */
Date.prototype.format = function (f) {

    if (!this.valueOf()) return " ";



    var weekKorName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];

    var weekKorShortName = ["일", "월", "화", "수", "목", "금", "토"];

    var weekEngName = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];

    var weekEngShortName = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

    var d = this;



    return f.replace(/(yyyy|yy|MM|dd|KS|KL|ES|EL|HH|hh|mm|ss|a\/p)/gi, function ($1) {

        switch ($1) {

            case "yyyy": return d.getFullYear(); // 년 (4자리)

            case "yy": return (d.getFullYear() % 1000).zf(2); // 년 (2자리)

            case "MM": return (d.getMonth() + 1).zf(2); // 월 (2자리)

            case "dd": return d.getDate().zf(2); // 일 (2자리)

            case "KS": return weekKorShortName[d.getDay()]; // 요일 (짧은 한글)

            case "KL": return weekKorName[d.getDay()]; // 요일 (긴 한글)

            case "ES": return weekEngShortName[d.getDay()]; // 요일 (짧은 영어)

            case "EL": return weekEngName[d.getDay()]; // 요일 (긴 영어)

            case "HH": return d.getHours().zf(2); // 시간 (24시간 기준, 2자리)

            case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2); // 시간 (12시간 기준, 2자리)

            case "mm": return d.getMinutes().zf(2); // 분 (2자리)

            case "ss": return d.getSeconds().zf(2); // 초 (2자리)

            case "a/p": return d.getHours() < 12 ? "오전" : "오후"; // 오전/오후 구분

            default: return $1;

        }

    });

};

String.prototype.string = function (len) { var s = '', i = 0; while (i++ < len) { s += this; } return s; };

String.prototype.zf = function (len) { return "0".string(len - this.length) + this; };

Number.prototype.zf = function (len) { return this.toString().zf(len); };

function jsHelper_paragonFile () { }
// IE console.log polyfill
if ( !window.console ) window.console = { log:function() {} };

/**
 * AIR 시스템 공용 자바스크립트 도우미 인스턴스
 */
var paragonFile = new jsHelper_paragonFile();
jsHelper_paragonFile.prototype.fileInit = {};
jsHelper_paragonFile.prototype.arrFileInfo = {};
jsHelper_paragonFile.prototype.delFileInfo = [];

/**
 * 첨부사이즈 셋팅
 */
jsHelper_paragonFile.prototype.setFileSize = function(ctrlUuid){

	var totalFileSize = 0;
	var arrFileList =  paragonFile.arrFileInfo[ctrlUuid].infos;
	$(arrFileList).each(function(i, o){
		totalFileSize += Math.ceil(o.fileSize / 1024)
	});

	$("#file_size_"+ctrlUuid).text( totalFileSize );

}
/**
 * 파일 선택 삭제
 */
jsHelper_paragonFile.prototype.deleteFile = function(ctrlUuid, atchUid){

	//-- 화면에서 지우기
	$("#"+atchUid).remove();

	//-- 파일 객체에서 지우기
	var arrFileList =  paragonFile.arrFileInfo[ctrlUuid].files;
	var newFileList = [];
	$(arrFileList).each(function(i, o){
		if(o.atchUid == atchUid){
			return true;
		}
		newFileList.push(o);
	});
	paragonFile.arrFileInfo[ctrlUuid]["files"] = newFileList;

	//-- 파일 정보에서 지우기
	var arrFileinfo =  paragonFile.arrFileInfo[ctrlUuid].infos;
//	console.log(arrFileinfo);
	var newFileinfo = [];
	$(arrFileinfo).each(function(i, o){
		if(o.atchUid == atchUid){
			return true;
		}
		newFileinfo.push(o);
	});
	paragonFile.arrFileInfo[ctrlUuid]["infos"] = newFileinfo;

	//-- 파일 삭제 저장 처리를 위해 삭제 atchUid 모음.
	paragonFile.delFileInfo.push(atchUid);


	paragonFile.setNoticeView(ctrlUuid);
	paragonFile.setFileSize(ctrlUuid);
}
/**
 * 안내문구 보이기/숨기기
 */
jsHelper_paragonFile.prototype.setNoticeView = function(ctrlUuid){
	//--안내문구 보이기/숨기기 처리
    if(paragonFile.arrFileInfo.hasOwnProperty(ctrlUuid)){
    	if(paragonFile.arrFileInfo[ctrlUuid].infos.length > 0){
    		$("#file_notice_"+ctrlUuid).hide();
    	}else{
    		$("#file_notice_"+ctrlUuid).show();
    	}
    }
}
/**
 * 업로드 파일 목록 생성
 */
jsHelper_paragonFile.prototype.addFile = function(ctrlUuid, atchUid, fileName, fileSize, byteNm){
	 $("#file_Element_"+ctrlUuid);

	 var html = "";
       html += "<li id='" + atchUid + "' class='file_Element_"+ctrlUuid+"' >";
       html += "		<input type='hidden' name='atchUid'  value='" + atchUid + "' >";
       html +=         "<i class='fa fa-times' style='color:red;' onclick='paragonFile.deleteFile(\"" + ctrlUuid + "\",\"" + atchUid + "\");'></i>&nbsp;"+fileName + " / " + fileSize + byteNm+" "
       html += "</li>"

    $('ul','.file_Element_'+ctrlUuid).append(html);

}
/**
 * 파일 추가 로직
 */
jsHelper_paragonFile.prototype.fileMultiUpload = function(files, ctrlUuid){

	var jsonInit = paragonFile.fileInit[ctrlUuid];
	var maxFileSize 	= jsonInit["maxFileSize"];   //--최대첨부크기
	var maxFileCount 	= jsonInit.maxFileCount;  //--최대첨부갯수
	var fileFilter 	= jsonInit.fileFilter;    //--허용첨부파일
	var fileRFilter 	= jsonInit.fileRFilter;   //--불가첨부파일

	var arrFilter		= fileFilter.toUpperCase().split(";");
	var arrRFilter		= fileRFilter.toUpperCase().split(";");

	 // 다중파일 등록
    if(files != null){
    	var fileCnt = files.length ;
    	if(paragonFile.arrFileInfo[ctrlUuid].files){
    		fileCnt += paragonFile.arrFileInfo[ctrlUuid].files.length;
    	}
    	if(maxFileCount < fileCnt){ //-- 최대 허용 파일갯수 채크
    		 alert(paragonCmm.getLang("M.첨부갯수_초과", "'"+maxFileCount+"'"));
    		 return false;

    	}else{

		    var arrFileInfos = [];	//-- 파일정보 Json 배열
		    var arrFileLists = [];  //-- 파일객체 배열
		    var fileTpCd = $("input:hidden[name='_attachFileTpCd']","#fileArea_"+ctrlUuid).val();
		    var relUid = $("input:hidden[name='_attachFileRelUid']","#fileArea_"+ctrlUuid).val();
		    var fileAllInfo = {};
		    //-- 기 입력된 정보 불러오기
		    if(paragonFile.arrFileInfo.hasOwnProperty(ctrlUuid)){
		    	//-- 파일객체 불러오기
		    	var arrfiles = paragonFile.arrFileInfo[ctrlUuid].files;
		    	$(arrfiles).each(function(j,o){
		    		arrFileLists.push(o);
		    	});
		    	//-- 파일정보 불러오기
		    	var infos = paragonFile.arrFileInfo[ctrlUuid].infos;
		    	$(infos).each(function(j,o){
		    		arrFileInfos.push(o);
		    	});

		    }

		    for(var i = 0; i < files.length; i++){
		    	// 파일 이름
		    	var fileName = files[i].name;
		    	var fileSize = files[i].size;
		    	var fileNameArr = fileName.split("\.");
		    	// 확장자
		    	var ext = fileNameArr[fileNameArr.length - 1];
				if(fileNameArr.length < 2){
					// 확장자 체크
		    		alert(paragonCmm.getLang('M.등록_불가_확장자'));
		    		break;
				}
//		    	console.log("ext length:"+fileNameArr.length);
//		    	console.log("ext:"+ext);
//		    	console.log("ext.upper:"+ext.toUpperCase());
		    	// 파일 사이즈(단위 :MB)
		    	var fileSize = files[i].size / 1024;
		    	var byteNm	  = "KB";
		    	if(1024 < fileSize) {
		    		fileSize = fileSize / 1024;
		    		byteNm = "MB";
		    	}
		    	//--파일 사이즈 소수점 2자리까지
		    	if(fileSize.toString().indexOf(".") > -1){
		    		if(fileSize.toString().split(".")[1].length > 2){
		    			fileSize = fileSize.toFixed(2);
		    		}
		    	}

		    	//-- 허용불가 확장자 체크
		    	if(arrRFilter != undefined && arrRFilter != "" && ($.inArray(ext.toUpperCase(), arrRFilter) >= 0)){
		    		// 확장자 체크
		    		alert(paragonCmm.getLang('M.등록_불가_확장자'));
		    		break;
		    	}

		    	//-- 허용가능 확장자 체크
		    	if(arrFilter != undefined && arrFilter != "" && ($.inArray(ext.toUpperCase(), arrFilter) < 0)){
		    		// 확장자 체크
		    		alert(paragonCmm.getLang('M.등록_불가_확장자'));
		    		break;

		    	}
		    	var duple = false;
		    	// 중복 체크
		    	$(arrFileLists).each(function(j,o){
		    		if(o.name == files[i].name){
		    			console.log(o.name+":"+files[i].name);
		    			console.log("중복:"+fileName);
		    			duple = true;
		    			return false;
		    		}
		    	});
		    	if(!duple){
		    		var atchUid = paragonCmm.getRandomUUID();

		    		//-- 파일 정보 담기
		    		var fileJson = {};
		    		fileJson["isNew"] = true;
		    		fileJson["ctrlUuid"] = ctrlUuid;
		    		fileJson["fileTpCd"] = fileTpCd;
		    		fileJson["relUid"] = relUid;
		    		fileJson["atchUid"] = atchUid;
//		    		fileJson["saveFileName"] = new Date().format("yyyyMMddhhmmss")+"."+Math.floor(Math.random() * 10) + 1 +"."+ i;

		    		//새로 랜덤을 만들었습니다.
		    		var array2 = new Uint32Array(10);

		    		if(navigator.sayswho.startsWith("IE")){
		    			window.msCrypto.getRandomValues(array2);
		    		}else{
		    			window.crypto.getRandomValues(array2);
		    		}
		    		var ranNum = array2[1];
		    		fileJson["saveFileName"] = new Date().format("yyyyMMddhhmmss")+"."+ ranNum%10 + 1 +"."+ i;
		    		fileJson["fileName"] = fileName;
		    		fileJson["fileSize"] = files[i].size;

		    		files[i]["atchUid"] = atchUid;

		    		arrFileInfos.push(fileJson);
		    		arrFileLists.push(files[i]);


		    		paragonFile.addFile(ctrlUuid, atchUid, fileName, fileSize, byteNm);
		    	}
		    }
		    fileAllInfo["files"] = arrFileLists;
		    fileAllInfo["infos"] = arrFileInfos;
    		//-- 추가된 파일 셋팅
    		paragonFile.arrFileInfo[ctrlUuid] = fileAllInfo
    		paragonFile.setFileSize(ctrlUuid);
    	 }
     }else{
         alert("ERROR");
     }
    paragonFile.setNoticeView(ctrlUuid);

 };
 /**
  * 파일 이벤트 추가
  */
jsHelper_paragonFile.prototype.addFileEvent = function(ctrlUuid, jsonInit){

	paragonFile.fileInit[ctrlUuid] = jsonInit;
	if(jsonInit.hasOwnProperty("defaultFile")){
		paragonFile.arrFileInfo[ctrlUuid] = {"infos":jsonInit["defaultFile"]};
		paragonFile.setNoticeView(ctrlUuid);
		paragonFile.setFileSize(ctrlUuid);
	}
	//-- 파일 선택 버튼 이벤트 추가
	$("#file_search_"+ctrlUuid).change(function(e){
		var files = e.originalEvent.target.files;
		//-- 파일 선택 했을때 파일 추가 하기
	    paragonFile.fileMultiUpload(files, ctrlUuid);
	});

	//-- 파일 끌어다 놓기 이벤트 추가
	var obj = $(".file_Element_"+ctrlUuid);
	obj.off();
    obj.on('dragenter', function (e) {
         e.stopPropagation();
         e.preventDefault();
         $("DIV.file_Element_"+ctrlUuid).css('border', '2px solid #5272A0');
    });

    obj.on('dragleave', function (e) {
         e.stopPropagation();
         e.preventDefault();
         $("DIV.file_Element_"+ctrlUuid).css('border',  '2px dotted #8296C2');
//         $(paragonFile).css('border', '2px dotted #8296C2');
    });

    obj.on('dragover', function (e) {
         e.stopPropagation();
         e.preventDefault();
    });

    obj.on('drop', function (e) {
        e.preventDefault();

        var files = e.originalEvent.dataTransfer.files;
        if(files.length < 1)
              return;

        var targetObj = e.originalEvent.target;
        var ctrlUuid = $(targetObj).attr("class").replace("file_Element_","");

        //-- 파일 드랍 했을때 파일 추가 하기
        paragonFile.fileMultiUpload(files, ctrlUuid);

        $("DIV.file_Element_"+ctrlUuid).css('border', '2px dotted #8296C2');

    });



}

