package com.vertexid.paragon.file;

import java.io.File;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import com.vertexid.viself.hr.SysLoginVO;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.vertexid.commons.utils.CommonConstants;
import com.vertexid.commons.utils.DateUtil;
import com.vertexid.commons.utils.FileUtil;
import com.vertexid.commons.utils.JsonUtil;
import com.vertexid.commons.utils.ParamMap;
import com.vertexid.commons.utils.StringUtil;
import com.vertexid.spring.utils.BaseProperties;
import com.vertexid.viself.base.BaseSvc;
import com.vertexid.viself.base.CmmDAO;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Service
@Transactional
public class FileSvc extends BaseSvc{

    private static final String NAMESPACE =
            "com.vertexid.paragon.file.File";

    private static final String LOG_NAMESPACE =
            "com.vertexid.paragon.log.LogAcc";

    @Resource(name = "cmmDAO")
    private CmmDAO cmmDAO;


    public List<Object> getFileViewList(Map<String, Object> params) {
        if(StringUtil.isNotBlank((String)params.get("relUid"))
        		|| StringUtil.isNotBlank((String)params.get("atchUid"))) {
            Map<String, Object> whereMap = new HashMap<String, Object>();
            whereMap.put("relUid", params.get("relUid"));
            whereMap.put("solMasUid", params.get("solMasUid"));
            whereMap.put("fileTpCd", params.get("fileTpCd"));
            whereMap.put("atchUid", params.get("atchUid"));
            whereMap.put("useYn", "Y");
            return cmmDAO.getList(cmmDAO.getStmtByNS(NAMESPACE, "list"), whereMap);
        }else {
            return new ArrayList<Object>();
        }
    }


    public List<Object> getFileDefaultViewList(Map<String, Object> params) {
        if(StringUtil.isNotBlank((String)params.get("defaultRelUid"))) {
            Map<String, Object> whereMap = new HashMap<String, Object>();
            String defaultRelUid = (String)params.get("defaultRelUid");
            if(defaultRelUid.indexOf(",") > -1) {
                whereMap.put("arrRelUid", StringUtil.split(defaultRelUid, ",") );
            }else {
                whereMap.put("relUid", defaultRelUid);
            }
            whereMap.put("solMasUid", params.get("solMasUid"));
            whereMap.put("fileTpCd", params.get("fileTpCd"));
            whereMap.put("useYn", "Y");
            return cmmDAO.getList(cmmDAO.getStmtByNS(NAMESPACE, "list"), whereMap);
        }else {
            return new ArrayList<Object>();
        }
    }


    public void doDeleteFileProc(Map<String, Object> params) {

        String atchUids = (String)params.get("delAtchs");
        if(StringUtil.isNotBlank(atchUids)) {
            String[] arrUids = StringUtil.split(atchUids, ",");
            for (int i = 0; i < arrUids.length; i++) {
                ParamMap<String, Object> param = new ParamMap<String, Object>();
                param.put("atchUid", arrUids[i]);
                cmmDAO.delete(cmmDAO.getStmtByNS(NAMESPACE, "delete"), param);
            }
        }
    }


    @SuppressWarnings("unchecked")
    public String getAttachFileUploadProcResult(HttpServletRequest request, Map<String, Object> params) {
        StringBuffer data = null;
        SysLoginVO loginUser = (SysLoginVO)params.get(CommonConstants.SESSION_USER);

        String fileTpCd                = StringUtil.convertNull(params.get("fileTpCd"));
        String randomFileNameYn        = StringUtil.convertNull(params.get("randomFileNameYn"));
        String overwriteYn            = StringUtil.convertNull(params.get("overwriteYn"));
        String sol_mas_uid            = StringUtil.convertNull(params.get("sol_mas_uid"));
//        String attachAfterAddMode   = StringUtil.convertNull(requestMap.getString("ATTACHAFTERADDMODE"));

        log.debug("fileTpCd is "+ fileTpCd);
        log.debug("randomFileNameYn is "+ randomFileNameYn);
        log.debug("overwriteYn is "+ overwriteYn);

        JSONArray json = new JSONArray();
        JSONObject jsono = new JSONObject();

        try {
//            validateIsExistTypeCode(sqlExe, requestMap);

            String save_path = BaseProperties.get("attach.saveRootPath") +"/"+ fileTpCd;

            data = new StringBuffer();
            data.append("\n{");
            data.append("\n  \"PROC_RESULT\":\"DONE\"");
            data.append("\n  ,\"PROC_DATA\":[");

            FileItem uploadFileItem     = null;
            String file_name            = "";
            String file_savename        = "";
            long file_size                = 0;
            boolean isMultipart = ServletFileUpload.isMultipartContent(request);

            if (isMultipart) {
                FileItemFactory factory = new DiskFileItemFactory();

                /*
                 * HACK
                 *
                 * 아래 repository 설정을 하지않을 경우
                 * window 에서 tomcat 등의 temp 폴더혹은 tomcat root 를 임시폴더로 잡음
                 *
                 *     1. 권한이 없을 경우 오류 발생
                 *
                 *     2. 지저분하게 tomcat root 등 에 임시 파일들 쌓임
                 */
                String tempPath = BaseProperties.get("attach.saveTempPath");
                // 해당 디렉토리가 없을경우 디렉토리를 생성합니다.
                FileUtil.makeDir(tempPath);
                File folder = new File(tempPath);
                ((DiskFileItemFactory) factory).setRepository(folder);

                ServletFileUpload upload = new ServletFileUpload(factory);
                List<?> items = null;
                int itemCount = 0;

                //파일에 대한 정보를 가져오는 부분인데 디비에 가서 가져오는게 좋을 것 같다...

                List<Object> fileinfos = JsonUtil.parseJsonStringToList(StringUtil.convertNull(params.get("fileInfos"))) ;
                List<Object> fileinfosFilter = new ArrayList<>();
                items = upload.parseRequest(request);
                   Iterator<?> itr = items.iterator();
                while (itr.hasNext()) {

                    boolean bool = false;

                    FileItem item = (FileItem) itr.next();
                    itemCount++;

                    jsono = new JSONObject();

                    log.debug("item["+ itemCount +"]---------------------------------------------");
                    log.debug("getFieldName() => "+ item.getFieldName());

                    if ( !item.isFormField() )
                    {
                        //-- 업로드 파일정보 셋팅!
                        uploadFileItem = item;
                        file_name = item.getName();
                        file_size = item.getSize();

                        jsono.put("name", item.getName());
                        jsono.put("size", item.getSize());

                        log.debug("getName() => "+ item.getName());
                        log.debug("getContentType() => "+ item.getContentType());
                        log.debug("getSize() => "+ item.getSize());

                        if(file_name.indexOf("\\") > -1) {
                            file_name = file_name.substring(file_name.lastIndexOf("\\")+1, file_name.length());
                        }


                        String fileExt = FileUtil.getFileExt(file_name);
                        log.debug("fileExt ==> "+ fileExt);

                        // 파일 확장자 체크
                        validateIsAllowFileExt(file_name);
                        validateIsDenyFileExt(file_name);

                        file_savename    = DateUtil.getCurrentDate("yyyyMMddHHmmss.S") +"."+ (int)(new SecureRandom().nextDouble() * 10) +"."+ itemCount;
                        //--saveFileName 꺼내오기 방식 변경(air-file.js:250 스크립트에서 만들어 보냄)
                        if(fileinfos != null &&  fileinfos.size() > 0) {
                            for (int i = 0; i < fileinfos.size(); i++) {
                                ParamMap<String, Object> fileinfo = (ParamMap<String, Object>)fileinfos.get(i);
                                String fileName            = fileinfo.getString("fileName");
                                if(Boolean.valueOf((String)fileinfo.get("isNew"))) {
                                    if(fileName.equals(file_name) ){
                                        fileinfo.put("saveFileName", file_savename);    //-- 웹보안 취약점으로 변경
                                        fileinfosFilter.add(fileinfo);
                                        bool = true;
                                        break;
                                    }
                                }else {
                                    fileinfosFilter.add(fileinfo);
                                }

                            }
                        }

                        if(!bool) {
                            throw new Exception("파일 정보가 잘못 되었습니다.");
                        }

                        if ("N".equals(randomFileNameYn) || "Y".equals(overwriteYn)) {
                            //-- 파일명 랜덤생성 기능을 사용하지 않을 경우, 또는 덮어쓰기 기능을 사용할 경우 원본파일명 사용
                            file_savename = file_name;
                        }
                        jsono.put("saveName", file_savename);

                        // 폴더 생성
                        FileUtil.makeDir(save_path);
                        //FileUtil.makeDir(save_path+"/TMP/");
                        //File inputFile = new File(save_path +"/TMP/"+ file_savename);
                        File inputFile = new File(save_path +"/"+ file_savename);
                        //File encryptFile = new File(save_path +"/"+ file_savename);

                        uploadFileItem.write(inputFile);

                        json.add(jsono);
                    }
                }

                //-- fileinfosFilter 와 fileinfos의 Merge 작업 시작=============================================
                   if(fileinfos != null &&  fileinfos.size() > 0) {
                       if(fileinfosFilter == null ||  fileinfosFilter.size() == 0) {    // FilterInfo가 널이면 FileInfo ADD
                           fileinfosFilter = fileinfos;
                       }else {                                                            // 그 외 FilterInfo에 Merge 작업 개시!!!
                           for (int i = 0; i < fileinfos.size(); i++) {
                               ParamMap<String, Object> fileinfo = (ParamMap<String, Object>)fileinfos.get(i);
                               boolean bool = true;
                               if(fileinfosFilter != null &&  fileinfosFilter.size() > 0) {
                                   for (int j = 0; j < fileinfosFilter.size(); j++) {
                                       ParamMap<String, Object> fileFilterinfo = (ParamMap<String, Object>)fileinfosFilter.get(j);
                                       if(fileinfo.getString("atchUid").equals(fileFilterinfo.getString("atchUid"))) {    //같은게 있을경우
                                           bool = false;
                                           break;    //-- j FOR문 종결
                                       }
                                   }//filter for end
                               }
                               if(bool) {    // fileinfosFilter에 존재하지 않을경우 ADD
                                   fileinfosFilter.add(fileinfo);
                               }
                           }//infos for end
                       }
                   }

                //-- 파일 DB저장 처리
                if(fileinfosFilter != null &&  fileinfosFilter.size() > 0) {


                    String relUid    = (String)params.get("relUid");

                    // 1) 기존에 등록했던 첨부파일를 폐기 상태로 UPDATE!
                    FileDTO fileDto = new FileDTO();

                    fileDto.setUptLoginId( loginUser.getLoginId());
                    fileDto.setUseYn( "N");    //상태:정상[Y]
                    fileDto.setRelUid(relUid);
                    fileDto.setFileTpCd(fileTpCd);

                    cmmDAO.update(cmmDAO.getStmtByNS(NAMESPACE, "update"), fileDto);

                    for (int i = 0; i < fileinfosFilter.size(); i++) {
                        ParamMap<String, Object> fileinfo = (ParamMap<String, Object>)fileinfosFilter.get(i);
                        String uid                = fileinfo.getString("atchUid");
                        String isNew            = fileinfo.getString("isNew");
                        String saveFileName        = fileinfo.getString("saveFileName");
                        String fileName            = fileinfo.getString("fileName");
                        String fileSize            = fileinfo.getString("fileSize");
                        String user_id            = loginUser.getLoginId();


                        if ("true".equals(isNew)) {
                            //-- uid 값이 없거나 무조건 신규첨부 처리할 경우 INSERT!
                            ParamMap<String, Object> insMap = new ParamMap<String, Object>();
                            fileDto = new FileDTO();
                            uid = StringUtil.getRandomUUID();

                            fileDto.setAtchUid(uid);
                            fileDto.setSolMasUid(sol_mas_uid);
                            fileDto.setRelUid(relUid);
                            fileDto.setOrdNo((i+1));
                            fileDto.setFileTpCd(fileTpCd);
                            fileDto.setFileSaveNm(saveFileName);
                            fileDto.setFileNm(fileName);
                            fileDto.setFileSize(fileSize);
                            fileDto.setUseYn("Y");
                            fileDto.setRegLoginId(user_id);
                            fileDto.setUptLoginId(user_id);

                            cmmDAO.insert(cmmDAO.getStmtByNS(NAMESPACE, "insert"), fileDto);

                            //-- 2) 첨부파일 생성 로그 INSERT
//                            insMap = new ParamMap<String, Object>();
//
//                            insMap.put("logUid", StringUtil.getRandomUUID());
//                            insMap.put("actionCd", "/paragon/file/File/saveProc/json");
//                            insMap.put("logTypeCd", "INSERT");
//                            insMap.put("deptCd", loginUser.getDeptCd());
//                            insMap.put("deptNm", loginUser.getGroupName());
//                            insMap.put("loginId", loginUser.getLoginId());
//                            insMap.put("userNm", loginUser.getName());
//                            insMap.put("loginIp", loginUser.getLoginIp());
//
//                            cmmDAO.insert(cmmDAO.getStmtByNS(LOG_NAMESPACE, "insert"), insMap);

                        }else {
                            //-- uid 값이 있을 경우 UPDATE!
                            fileDto = new FileDTO();
                            fileDto.setUptLoginId(user_id);
                            fileDto.setUseYn("Y");
                            fileDto.setOrdNo((i+1));
                            fileDto.setAtchUid(uid);

                            cmmDAO.update(cmmDAO.getStmtByNS(NAMESPACE, "update"), fileDto);


                            //-- 2) 첨부파일 수정 로그 INSERT
//                            ParamMap<String, Object> updateMap = new ParamMap<String, Object>();
//
//                            updateMap.put("logUid", StringUtil.getRandomUUID());
//                            updateMap.put("actionCd", "/paragon/file/File/saveProc/json");
//                            updateMap.put("logTypeCd", "UPDATE");
//                            updateMap.put("deptCd", loginUser.getDeptCd());
//                            updateMap.put("deptNm", loginUser.getGroupName());
//                            updateMap.put("loginId", loginUser.getLoginId());
//                            updateMap.put("userNm", loginUser.getName());
//                            updateMap.put("loginIp", loginUser.getLoginIp());
//
//                            cmmDAO.insert(cmmDAO.getStmtByNS(LOG_NAMESPACE, "insert"), updateMap);
                        }

                    }
                }

                   data.append("\n    {");
                   data.append("\"FILE_SAVENAME\":\""+ StringUtil.convertForJson(file_savename) +"\"");
                   data.append(", \"FILE_NAME\":\""+ StringUtil.convertForJson(file_name) +"\"");
                   data.append(", \"FILE_SIZE\":"+ file_size);
                   data.append("}");
                   data.append("\n  ]");
                   data.append("\n  ,\"files\":" + json.toString());
                   data.append("\n  ,\"PROC_MESSAGE\":\"파일이 업로드 되었습니다.\"");
                   data.append("\n}");
            }
        } catch (Exception e) {
            log.error(".......................파일업로드 실패 ");
        	throw new RuntimeException(".......................File Upload Error!!" + e.getMessage());

        }

        return data.toString();
    }

    public void validateIsAllowFileExt(String filename) {
        if (filename != null && !"".equals(filename)) {
            String filter = BaseProperties.get("attach.default.allowExt");
            filter = filter.toUpperCase();
            if (filter != null && !"".equals(filter)) {
                filename = filename.toUpperCase();
                String ext = FileUtil.getFileExt(filename);
                if ("".equals(ext) || (filter+";").indexOf(ext+";") == -1) {
                    new Exception("허용되지 않은 파일 확장자입니다. ["+ filename +"]\n(※ 허용된 확장자 : "+ filter +")");
                }
            }
        }
    }
    public void validateIsDenyFileExt(String filename){
        if (filename != null && !"".equals(filename)) {
            String filter = BaseProperties.get("attach.default.denyExt");
            if (filter != null && !"".equals(filter)) {
                filename = filename.toUpperCase();
                String ext = FileUtil.getFileExt(filename);
                if ("".equals(ext) || (";"+filter+";").indexOf(";"+ext+";") > -1) {
                    new Exception("허용되지 않은 파일 확장자입니다. ["+ filename +"]\n(※ 허용되지 않은 확장자 : "+ filter +")");
                }
            }
        }
    }

}
