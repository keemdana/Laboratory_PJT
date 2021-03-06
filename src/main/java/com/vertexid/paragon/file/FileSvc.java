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
                 * ?????? repository ????????? ???????????? ??????
                 * window ?????? tomcat ?????? temp ???????????? tomcat root ??? ??????????????? ??????
                 *
                 *     1. ????????? ?????? ?????? ?????? ??????
                 *
                 *     2. ??????????????? tomcat root ??? ??? ?????? ????????? ??????
                 */
                String tempPath = BaseProperties.get("attach.saveTempPath");
                // ?????? ??????????????? ???????????? ??????????????? ???????????????.
                FileUtil.makeDir(tempPath);
                File folder = new File(tempPath);
                ((DiskFileItemFactory) factory).setRepository(folder);

                ServletFileUpload upload = new ServletFileUpload(factory);
                List<?> items = null;
                int itemCount = 0;

                //????????? ?????? ????????? ???????????? ???????????? ????????? ?????? ??????????????? ?????? ??? ??????...

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
                        //-- ????????? ???????????? ??????!
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

                        // ?????? ????????? ??????
                        validateIsAllowFileExt(file_name);
                        validateIsDenyFileExt(file_name);

                        file_savename    = DateUtil.getCurrentDate("yyyyMMddHHmmss.S") +"."+ (int)(new SecureRandom().nextDouble() * 10) +"."+ itemCount;
                        //--saveFileName ???????????? ?????? ??????(air-file.js:250 ?????????????????? ????????? ??????)
                        if(fileinfos != null &&  fileinfos.size() > 0) {
                            for (int i = 0; i < fileinfos.size(); i++) {
                                ParamMap<String, Object> fileinfo = (ParamMap<String, Object>)fileinfos.get(i);
                                String fileName            = fileinfo.getString("fileName");
                                if(Boolean.valueOf((String)fileinfo.get("isNew"))) {
                                    if(fileName.equals(file_name) ){
                                        fileinfo.put("saveFileName", file_savename);    //-- ????????? ??????????????? ??????
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
                            throw new Exception("?????? ????????? ?????? ???????????????.");
                        }

                        if ("N".equals(randomFileNameYn) || "Y".equals(overwriteYn)) {
                            //-- ????????? ???????????? ????????? ???????????? ?????? ??????, ?????? ???????????? ????????? ????????? ?????? ??????????????? ??????
                            file_savename = file_name;
                        }
                        jsono.put("saveName", file_savename);

                        // ?????? ??????
                        FileUtil.makeDir(save_path);
                        //FileUtil.makeDir(save_path+"/TMP/");
                        //File inputFile = new File(save_path +"/TMP/"+ file_savename);
                        File inputFile = new File(save_path +"/"+ file_savename);
                        //File encryptFile = new File(save_path +"/"+ file_savename);

                        uploadFileItem.write(inputFile);

                        json.add(jsono);
                    }
                }

                //-- fileinfosFilter ??? fileinfos??? Merge ?????? ??????=============================================
                   if(fileinfos != null &&  fileinfos.size() > 0) {
                       if(fileinfosFilter == null ||  fileinfosFilter.size() == 0) {    // FilterInfo??? ????????? FileInfo ADD
                           fileinfosFilter = fileinfos;
                       }else {                                                            // ??? ??? FilterInfo??? Merge ?????? ??????!!!
                           for (int i = 0; i < fileinfos.size(); i++) {
                               ParamMap<String, Object> fileinfo = (ParamMap<String, Object>)fileinfos.get(i);
                               boolean bool = true;
                               if(fileinfosFilter != null &&  fileinfosFilter.size() > 0) {
                                   for (int j = 0; j < fileinfosFilter.size(); j++) {
                                       ParamMap<String, Object> fileFilterinfo = (ParamMap<String, Object>)fileinfosFilter.get(j);
                                       if(fileinfo.getString("atchUid").equals(fileFilterinfo.getString("atchUid"))) {    //????????? ????????????
                                           bool = false;
                                           break;    //-- j FOR??? ??????
                                       }
                                   }//filter for end
                               }
                               if(bool) {    // fileinfosFilter??? ???????????? ???????????? ADD
                                   fileinfosFilter.add(fileinfo);
                               }
                           }//infos for end
                       }
                   }

                //-- ?????? DB?????? ??????
                if(fileinfosFilter != null &&  fileinfosFilter.size() > 0) {


                    String relUid    = (String)params.get("relUid");

                    // 1) ????????? ???????????? ??????????????? ?????? ????????? UPDATE!
                    FileDTO fileDto = new FileDTO();

                    fileDto.setUptLoginId( loginUser.getLoginId());
                    fileDto.setUseYn( "N");    //??????:??????[Y]
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
                            //-- uid ?????? ????????? ????????? ???????????? ????????? ?????? INSERT!
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

                            //-- 2) ???????????? ?????? ?????? INSERT
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
                            //-- uid ?????? ?????? ?????? UPDATE!
                            fileDto = new FileDTO();
                            fileDto.setUptLoginId(user_id);
                            fileDto.setUseYn("Y");
                            fileDto.setOrdNo((i+1));
                            fileDto.setAtchUid(uid);

                            cmmDAO.update(cmmDAO.getStmtByNS(NAMESPACE, "update"), fileDto);


                            //-- 2) ???????????? ?????? ?????? INSERT
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
                   data.append("\n  ,\"PROC_MESSAGE\":\"????????? ????????? ???????????????.\"");
                   data.append("\n}");
            }
        } catch (Exception e) {
            log.error(".......................??????????????? ?????? ");
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
                    new Exception("???????????? ?????? ?????? ??????????????????. ["+ filename +"]\n(??? ????????? ????????? : "+ filter +")");
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
                    new Exception("???????????? ?????? ?????? ??????????????????. ["+ filename +"]\n(??? ???????????? ?????? ????????? : "+ filter +")");
                }
            }
        }
    }

}
