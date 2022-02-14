/*
 * @(#)CKEditorImageCtrl.java     2021-08-17(017) 오전 7:34
 *
 * Copyright (c) 2021 Vertex ID., KOREA
 * All rights reserved.
 *
 * This software is the confidential
 * and proprietary information of emFrontier.com ("Confidential Information").
 * You shall not disclose such Confidential Information
 * and shall use it only in accordance with
 * the terms of the license agreement you entered into
 * with Vertex ID. Networks
 */
package com.vertexid.paragon.file;

import com.vertexid.viself.base.BaseCtrl;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

import static com.vertexid.commons.view.ViewType.JSON_VIEW;

/**
 * <b>Description</b>
 * <pre>
 *     CKEditor 용 이미지 관련 유틸
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
@Controller
public class CKEditorImageCtrl extends BaseCtrl {

    @Resource
    CKEditorImageSvc ckEditorImageSvc;

    /**
     * CKEditor 이미지 업로드
     * @param req request
     * @param model model
     * @return json view
     */
    @RequestMapping(value = "/editor/imageUpload/json",
            method = RequestMethod.POST)
    public String imageUpload(HttpServletRequest req, ModelMap model) {
        model.clear();

        Map<String, Object> rtnMap = ckEditorImageSvc.upload(req);

        model.addAttribute("fileName", rtnMap.get("fileName"));
        model.addAttribute("uploaded", "1");
        model.addAttribute("url", rtnMap.get("url"));

        return JSON_VIEW.getViewId();
    }

    /**
     * CKEditor 이미비 보이기
     * @param uid uid
     * @param fileName file name
     * @param res response
     */
    @RequestMapping(value = "/editor/viewImg")
    public void viewImage(
            @RequestParam(value = "nowMonth")
                    String nowMonth,
            @RequestParam(value = "uid")
                    String uid,
            @RequestParam(value = "fileName")
                    String fileName,
            HttpServletResponse res) {

        ckEditorImageSvc.viewImage(nowMonth, uid, fileName, res);
    }
}
