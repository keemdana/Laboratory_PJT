package com.vertexid.paragon.bbs;

import com.vertexid.viself.base.BaseCtrl;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Map;

import static com.vertexid.commons.view.ViewType.JSON_VIEW;


@Controller
public class bbsMasCtrl extends BaseCtrl {


    @Resource
    bbsMasSvc bbsMasSvc;
//    @Resource
//    IpInvSvc ipInvSvc;
//    @Resource
//    IpAppcntSvc ipAppcntSvc;
//    @Resource
//    IpPrjSvc ipPrjSvc;
//    @Resource
//    IpSkillSvc ipSkillSvc;

    /**
     * 로그인 폼
     *
     * @param req    request
     * @param model  model
     * @param params parameters
     * @return view
     */
    @RequestMapping("/paragon/bbs/bbsMas/bbsMasView/json")
    public String loginForm(HttpServletRequest req, ModelMap model,
            @RequestParam
                    Map<String, Object> params) {

        log.debug("loginForm......");

        model.addAttribute("data", bbsMasSvc.getbbsMasView(params));

        log.debug("viewparams..........??????" + params);

        return JSON_VIEW.getViewId();
    }

    /**
     * 게시글 리스트 조회
     *
     * @param req    request
     * @param model  model
     * @param params parameters
     * @return view
     */
//    @RequestMapping("/paragon/bbs/bbsMas/list/json")
//    public String getList(HttpServletRequest req,
//            ModelMap model,
//            @RequestParam
//                    Map<String, Object> params) {
//
//        model.addAttribute("data", bbsMasSvc.getList(params));
//        log.debug("bbslist_params......." + params);
//
//        return JSON_VIEW.getViewId();
//    }


    //게시글 저장
    @RequestMapping(value = "/paragon/bbs/bbsMas/insert/json",
            method = RequestMethod.POST)
    public String bbsSave(HttpServletRequest req, ModelMap model,
            @RequestParam
                    Map<String, Object> params) {
        log.debug("bbsSave_params....." + params);
        model.addAttribute("data", bbsMasSvc.saveBbs(params));
        return JSON_VIEW.getViewId();
    }

    //게시글 수정
    @RequestMapping(value = "/paragon/bbs/bbsMas/update/json",
            method = RequestMethod.POST)
    public String bbsUpdate(HttpServletRequest req, ModelMap model,
            @RequestParam
                    Map<String, Object> params) {
        log.debug("bbsUpdate_params....." + params);
        model.addAttribute("data", bbsMasSvc.updateBbs(params));
        return JSON_VIEW.getViewId();
    }

    //게시글 삭제
    @RequestMapping(value = "/paragon/bbs/bbsMas/delete/json",
            method = RequestMethod.POST)
    public String bbsDelete(HttpServletRequest req, ModelMap model,
            @RequestParam
                    Map<String, Object> params) {
        log.debug("bbsdelete_params....." + params);
        model.addAttribute("data", bbsMasSvc.deleteBbs(params));
        return JSON_VIEW.getViewId();
    }

}
