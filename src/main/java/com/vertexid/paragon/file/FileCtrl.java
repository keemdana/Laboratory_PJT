package com.vertexid.paragon.file;

import static com.vertexid.commons.view.ViewType.JSON_VIEW;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.vertexid.commons.utils.CommonConstants;
import com.vertexid.commons.utils.ParamMap;
import com.vertexid.commons.utils.StringUtil;
import com.vertexid.spring.utils.BaseProperties;
import com.vertexid.spring.utils.CmmProperties;
import com.vertexid.spring.utils.SessionUtils;
import com.vertexid.viself.base.BaseCtrl;
import com.vertexid.viself.hr.SysLoginVO;

@Controller
public class FileCtrl extends BaseCtrl{

	@Resource
	FileSvc fileSvc;

	/**
     * 파일 작성 폼
     *
     * @param req request
     * @param model model
     * @param params parameters
     * @return view
     */
    @RequestMapping("/paragon/file/fileWrite")
    public String writeForm(HttpServletRequest req,
            ModelMap model,
            @RequestParam
                    Map<String, Object> params) {


        log.debug("params..........??????" + params);
        model.addAttribute("saveRootPath",BaseProperties.get("attach.saveRootPath"));
        model.addAttribute("maxFileSize",BaseProperties.get("attach.default.maxFileSize"));
        model.addAttribute("maxFileCount",BaseProperties.get("attach.default.maxFileCount"));
        model.addAttribute("allowExt", StringUtil.convertNullDefault(params.get("allowExt") ,BaseProperties.get("attach.default.allowExt")));
        model.addAttribute("denyExt",  StringUtil.convertNullDefault(params.get("denyExt") ,BaseProperties.get("attach.default.denyExt")));

        model.addAttribute("viewResult", fileSvc.getFileViewList(params));
        model.addAttribute("defaultViewResult", fileSvc.getFileDefaultViewList(params));
        model.addAttribute("relUid", params.get("relUid"));
        model.addAttribute("defaultRelUid", params.get("defaultRelUid"));
        model.addAttribute("fileTpCd", params.get("fileTpCd"));
        model.addAttribute("requiredYn", params.get("requiredYn"));
        model.addAttribute("pdfConvYn", params.get("pdfConvYn"));

        return "/paragon/file/fileWrite";
    }

    /**
     * 파일 View 폼
     *
     * @param req request
     * @param model model
     * @param params parameters
     * @return view
     */
    @RequestMapping("/paragon/file/fileView")
    public String viewForm(HttpServletRequest req,
    		ModelMap model,
    		@RequestParam
    		Map<String, Object> params) {


    	log.debug("params..........??????" + params);
    	model.addAttribute("saveRootPath",BaseProperties.get("attach.saveRootPath"));
    	model.addAttribute("maxFileSize",BaseProperties.get("attach.default.maxFileSize"));
    	model.addAttribute("maxFileCount",BaseProperties.get("attach.default.maxFileCount"));
    	model.addAttribute("allowExt", StringUtil.convertNullDefault(params.get("allowExt") ,BaseProperties.get("attach.default.allowExt")));
    	model.addAttribute("denyExt",  StringUtil.convertNullDefault(params.get("denyExt") ,BaseProperties.get("attach.default.denyExt")));

    	model.addAttribute("viewResult", fileSvc.getFileViewList(params));
    	model.addAttribute("defaultViewResult", fileSvc.getFileDefaultViewList(params));
    	model.addAttribute("relUid", params.get("relUid"));
    	model.addAttribute("defaultRelUid", params.get("defaultRelUid"));
    	model.addAttribute("fileTpCd", params.get("fileTpCd"));
    	model.addAttribute("requiredYn", params.get("requiredYn"));
    	model.addAttribute("pdfConvYn", params.get("pdfConvYn"));

    	return "/paragon/file/fileView";
    }


    /**
     * 파일 삭제 로직
     * @param req request
     * @param model model
     * @param params parameters
     * @return view
     */
    @RequestMapping("/paragon/file/File/beDelete/json")
    public String doProc(ModelMap model,
			            @RequestParam
			            	Map<String, Object> params) {
        log.debug("params..........??????" + params);

        fileSvc.doDeleteFileProc(params);
        return JSON_VIEW.getViewId();
    }


    /**
     * 파일 업로드 로직
     * @param req request
     * @param model model
     * @param params parameters
     * @return view
     */
    @RequestMapping("/paragon/file/File/saveProc/json")
    public String doProc(HttpServletRequest req,
									    		HttpSession session,
									    		ModelMap model,
									    	@RequestParam
									    		Map<String, Object> params) {

    	SysLoginVO loginUser = (SysLoginVO)SessionUtils.getLoginVO();
    	params.put(CommonConstants.SESSION_USER, loginUser);
    	log.debug("params..........??????" + params);
    	model.addAttribute("result", fileSvc.getAttachFileUploadProcResult(req, params));
    	log.debug("result..........??????" + model.get("result"));

    	return JSON_VIEW.getViewId();
    }
    /**
     * 파일 양식 로직
     * @param req request
     * @param model model
     * @param params parameters
     * @return view
     */
    @SuppressWarnings("unchecked")
	@RequestMapping("/paragon/file/download")
    public ModelAndView fileDownload(
    		@RequestParam
    		Map<String, Object> params) {


    	List<Object> fileList = fileSvc.getFileViewList(params);
    	ParamMap<String, Object> fileMap = new ParamMap<String, Object>();

    	if(fileList != null && !fileList.isEmpty()) {
    		fileMap = (ParamMap<String, Object>)fileList.get(0);
    	}
    	String saveRoot = CmmProperties.getSaveRootPath();
    	String fileTpCd  = fileMap.getString("fileTpCd");
    	String fileSaveNm  = fileMap.getString("fileSaveNm");
    	String fileNm  = fileMap.getString("fileNm");
    	String savePath = saveRoot + "/"+fileTpCd+"/" + fileSaveNm;
    	try {
    		fileNm = URLDecoder.decode(fileNm, "UTF-8");
    	} catch (UnsupportedEncodingException e1) {
    		// TODO Auto-generated catch block
    		e1.printStackTrace();
    	}
    	String realPath = saveRoot + "/"+fileTpCd+"/" + fileNm;
    	log.info("@@@@@@@@@@@@@@@FileDown(1) START@@@@@@@@@@@@@@@");

    	InputStream inputStream = FileCtrl.class.getResourceAsStream(savePath);

    	File saveFile = new File(savePath);
    	File realFile = new File(realPath);
    	try {
			FileUtils.copyFile(saveFile, realFile);
		} catch (IOException e) {
			e.printStackTrace();
		}

    	log.debug(realFile.getName());
    	log.debug(realPath);

    	log.info("@@@@@@@@@@@@@@@FileDown(1) END@@@@@@@@@@@@@@@");

    	return new ModelAndView("download", "downloadFile", realFile);
    }
    /**
     * 파일 양식 로직
     * @param req request
     * @param model model
     * @param params parameters
     * @return view
     */
    @RequestMapping("/paragon/file/download/form")
    public ModelAndView formDownload(
    		@RequestParam
    		Map<String, Object> params) {

    	String saveRoot = CmmProperties.getSaveRootPath();
    	String fileNm  = (String)params.get("fileNm");
    	String tempPath = saveRoot + "/TMP/" + fileNm;
    	try {
			fileNm = URLDecoder.decode(fileNm, "UTF-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
        log.info("@@@@@@@@@@@@@@@FileDown(1) START@@@@@@@@@@@@@@@");

        String fullPath = "/form/form/"+fileNm ;
        InputStream inputStream = FileCtrl.class.getResourceAsStream(fullPath);
        File file = new File(tempPath);
        if(inputStream != null) {
        	try {
//				file = File.createTempFile(StringUtil.split(fileNm, ".")[0], "."+StringUtil.split(fileNm, ".")[1]);
				FileUtils.copyInputStreamToFile(inputStream, file);
			} catch (IOException e) {
				e.printStackTrace();
			}
        }
        log.debug(file.getName());
        log.debug(fullPath);

        log.info("@@@@@@@@@@@@@@@FileDown(1) END@@@@@@@@@@@@@@@");

        return new ModelAndView("download", "downloadFile", file);
    }



}
