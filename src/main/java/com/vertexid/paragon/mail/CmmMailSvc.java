package com.vertexid.paragon.mail;

import com.vertexid.commons.utils.FetchForm;
import com.vertexid.commons.utils.ParamMap;
import com.vertexid.commons.utils.StringUtil;
import com.vertexid.paragon.aprv.AprvLineDTO;
import com.vertexid.paragon.def.StuDtlType;
import com.vertexid.paragon.hr.HrMngDTO;
import com.vertexid.spring.utils.CmmProperties;
import com.vertexid.spring.utils.SessionUtils;
import com.vertexid.viself.base.CmmDAO;
import com.vertexid.viself.hr.SysLoginVO;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class CmmMailSvc {

    public static final String DEFAULT_FORM_PATH = "/form/mail/sys_mail.html";
    /**
     * logger
     */
    protected Logger log = LoggerFactory.getLogger(this.getClass());

    private static final String NAMESPACE = "com.vertexid.paragon.mail.Mail";

    private static final String SOL_NAMESPACE = "com.vertexid.ims.mail.ImsMail";

    private static final String DEFSOL_NAMESPACE =
            "com.vertexid.paragon.def.defstumail.DefStuMail";

    private static final String APR_NAMESPACE =
            "com.vertexid.paragon.aprv.Aprv";

    private static final String HR_NAMESPACE = "com.vertexid.paragon.hr.HrMng";


    @Resource(name = "cmmDAO")
    private CmmDAO cmmDAO;

    @SuppressWarnings("unchecked")
    public List<Object> getDefMailInfobyList(ParamMap<String, Object> params) {
        List<Object> rtnList = new ArrayList<>();
        String solMasUid = "";
        String yeyag_dte = "";
        String mailUid = "";
        String siteLocale = params.getString("siteLocale");

        if (StringUtil.isBlank(siteLocale)) {
            siteLocale = "KO";
        }

        String capitalizeSiteLocale =
                StringUtil.capitalize(siteLocale.toLowerCase());// ko >> Ko

        List<Object> relList = new ArrayList<>();
        ParamMap<String, Object> relMap = new ParamMap<>();
        ParamMap<String, Object> whereMap = new ParamMap<>();

        if (StringUtil.isNotBlank(params.getString("solMasUid"))) { //-- ?????? ????????????
            whereMap.put("solMasUid", params.getString("solMasUid"));
            solMasUid = params.getString("solMasUid");

            relList =
                    cmmDAO.getList(cmmDAO.getStmtByNS(SOL_NAMESPACE, "masList"),
                            whereMap);
        }

        String stuCd = "";
        String stuDtl = "";
        String mngNo = "";
        String title = "";
        String resvDte = "";

        if (relList != null && !relList.isEmpty()) {
            relMap = (ParamMap<String, Object>) relList.get(0);
            title = relMap.getString("tit" + capitalizeSiteLocale);
            mngNo = relMap.getString("mngNo");
            stuCd = relMap.getString("stuCd");
            stuDtl = relMap.getString("stuDtl");
            resvDte = relMap.getString("resvDte");
            if ("CM_APR".equals(params.getString("stuCd"))) {
                stuCd = params.getString("stuCd");
            }
            if ("X".equals(stuDtl) || "B".equals(stuDtl)) {
                stuCd = params.getString("stuCd");
            }
        }
        whereMap = new ParamMap<>();
        whereMap.put("stuCd", stuCd);
        whereMap.put("stuDtl", stuDtl);
        whereMap.put("page", "");

        List<Object> mailList =
                cmmDAO.getList(cmmDAO.getStmtByNS(DEFSOL_NAMESPACE, "list"),
                        whereMap);

        if (mailList != null && mailList.size() > 0) {
            for (Object o : mailList) {
                ParamMap<String, Object> mailMap = (ParamMap<String, Object>) o;
                params.put("stuType1", mailMap.get("stuTp"));
                params.put("stuType2", mailMap.get("stuTp2"));
                String mailTitle =
                        mailMap.getString("tit" + capitalizeSiteLocale);
                String mailContent =
                        mailMap.getString("content" + capitalizeSiteLocale);
                String recUserCd = mailMap.getString("recUserCd");
                String recRoleCd = mailMap.getString("recRoleCd");
                String refRoleCd = mailMap.getString("refRoleCd");
                String refUserCd = mailMap.getString("refUserCd");

                String rsRecInfo = getDefMailRec(relList, recRoleCd, recUserCd,
                        params.getString("loginId"));
                String rsRefInfo = getDefMailRec(relList, refRoleCd, refUserCd,
                        params.getString("loginId"));

                MailDTO mailDTO = new MailDTO();
                mailDTO.setEmailUid(StringUtil.convertNullDefault(mailUid,
                        StringUtil.getRandomUUID()));
                mailDTO.setHtmlUseYn("Y");
                mailDTO.setStuCd(stuCd);
                mailDTO.setStuDtl(stuDtl);
                mailDTO.setRelUid(params.getString("docUid"));
                mailDTO.setSolMasUid(solMasUid);
                mailDTO.setSend(getMailInfo(params.getString("loginId"),
                        capitalizeSiteLocale));
                mailDTO.setRec(getMailInfo(rsRecInfo, capitalizeSiteLocale));
                mailDTO.setRef(getMailInfo(rsRefInfo, capitalizeSiteLocale));
                mailDTO.setTit(getMailTitle(params, relMap, mailTitle,
                        capitalizeSiteLocale));
                mailDTO.setContent(getMailBody(params, relList, mailContent,
                        capitalizeSiteLocale));
                //--??????????????? ???????????? ??????????????? ?????????.
                if (StringUtil.isNotBlank(yeyag_dte)) {
                    mailDTO.setResvDte(yeyag_dte);
                }

                insertData(mailDTO);

                rtnList.add(mailDTO);

            }

        }

        return rtnList;
    }

    /**
     * ?????? ?????? ????????? ??????
     *
     * @param params ????????????(stuCd, stuDtl ????????? ?????????)
     * @return ???????????? ?????????
     */
    @Transactional(readOnly = true)
    public List<Object> getDefMailList(Map<String, Object> params) {

        Map<String, Object> schDefMap = new HashMap<>();
        schDefMap.put("stuCd", params.get("stuCd"));
        schDefMap.put("stuDtl", params.get("stuDtl"));
        schDefMap.put("page", "");

        return cmmDAO.getList(cmmDAO.getStmtByNS(DEFSOL_NAMESPACE, "list"),
                schDefMap);
    }

    @SuppressWarnings("unchecked")
    private String getMailBody(ParamMap<String, Object> params,
            List<Object> relList, String mailContent,
            String capitalizeSiteLocale) {
        StringBuilder rtnContentStr = new StringBuilder();
        String formPath = "/form/mail/sys_mail.html";
        ParamMap<String, Object> relMap;

        if (relList != null && !relList.isEmpty()) {
            relMap = (ParamMap<String, Object>) relList.get(0);
            SysLoginVO loginUser = (SysLoginVO) params.get("loginUser");
            if (null == loginUser) {
                loginUser = (SysLoginVO) SessionUtils.getLoginVO();
            }

            FetchForm fetForm = new FetchForm(formPath);
            try {
                fetForm.setParam("SITE_URL", CmmProperties.getSystemUrl());


                if ("SC".equals(relMap.getString("stuType2"))) {

                } else {
                    String reqUserNm = StringUtil.convertNull(
                            relMap.getString("reqUserNm"));
                    String chrUserNm = StringUtil.convertNull(
                            relMap.getString("chrUserNm"));

                    for (Object o : relList) {
                        ParamMap<String, Object> rowMap =
                                (ParamMap<String, Object>) o;

                        if ("REQ".equals(rowMap.getString("roleCd"))) {
                            reqUserNm = rowMap.getString(
                                    "dspNm" + capitalizeSiteLocale);
                        }
                        if ("REW".equals(rowMap.getString("roleCd"))) {
                            chrUserNm = rowMap.getString(
                                    "dspNm" + capitalizeSiteLocale);
                        }
                    }

                    //-- ?????? ?????? ??????
                    FetchForm fetFormContent = new FetchForm();
                    fetFormContent.setParam("TITLE", StringUtil.convertNull(
                            relMap.getString("tit" + capitalizeSiteLocale)));
                    fetFormContent.setParam("REQ_USER_NM", reqUserNm);
                    fetFormContent.setParam("REQ_DTE",
                            StringUtil.convertNull(relMap.getString("reqDte")));
                    fetFormContent.setParam("MNG_NO",
                            StringUtil.convertNull(relMap.getString("mngNo")));
                    fetFormContent.setParam("CHR_USER_NM", chrUserNm);

                    fetFormContent.setParam("LOGIN_NAM",
                            loginUser.getDspName());
                    fetFormContent.setParam("CONTENT_UPT_MEMO",
                            "<span style='color:blue'>[??????]</span>" +
                                    params.getString("contentUptMemo"));

                    AprvLineDTO aprvLineDTO = new AprvLineDTO();
                    aprvLineDTO.setDocUid(params.getString("docUid"));

                    List<Object> lineList = cmmDAO.getList(
                            cmmDAO.getStmtByNS(APR_NAMESPACE, "aprLinelist"),
                            aprvLineDTO);
                    if (lineList != null && lineList.size() > 0) {
                        StringBuilder strAprMemo = new StringBuilder();
                        for (int i = 0; i < lineList.size(); i++) {
                            ParamMap<String, Object> lineMap =
                                    (ParamMap<String, Object>) lineList.get(i);
                            if (i == 0) {
                                params.put("aprNo", lineMap.get("aprNo"));
                            }
                            if ("W".equals(lineMap.getString("aprStu")) ||
                                    "N".equals(lineMap.getString("aprStu"))) {
                                break;
                            }

                            strAprMemo.append("<br/>&nbsp;&nbsp;[")
                                    .append(lineMap.getString("aprNm"))
                                    .append("]");

                            if (StringUtil.isNotBlank(
                                    lineMap.getString("aprMemo"))) {
                                strAprMemo.append(
                                                "<br/>&emsp;&emsp;&nbsp;&nbsp;<span style='color:red'>[??????]</span>")
                                        .append(StringUtil.replace(
                                                StringUtil.replace(
                                                        lineMap.getString(
                                                                "aprMemo"),
                                                        "\n", ""), "\r", ""));
                            }
                            if (StringUtil.isNotBlank(
                                    lineMap.getString("contentUptMemo"))) {
                                strAprMemo.append(
                                                "<br/>&emsp;&emsp;&nbsp;&nbsp;<span style='color:blue'>[??????]</span>")
                                        .append(StringUtil.replace(
                                                StringUtil.replace(
                                                        lineMap.getString(
                                                                "contentUptMemo"),
                                                        "\n", ""), "\r", ""));
                            }
                            if (StringUtil.isNotBlank(
                                    lineMap.getString("realAprUserNm"))) {
                                strAprMemo.append(
                                                "<br/>&emsp;&emsp;&nbsp;&nbsp;<span style='color:blue'>[????????????]</span>")
                                        .append(StringUtil.replace(
                                                StringUtil.replace(
                                                        lineMap.getString(
                                                                "realAprUserNm"),
                                                        "\n", ""), "\r", ""));
                            }


                            if ("1".equals(lineMap.getString("ordNo"))) {
                                fetFormContent.setParam("GIAN_NM",
                                        lineMap.getString("gianNm"));
                                fetFormContent.setParam("APR_DTE_TIME",
                                        lineMap.getString("aprDteTime"));
                            }

                            if (loginUser.getLoginId()
                                    .equals(lineMap.getString("aprLoginId"))) {
                                fetFormContent.setParam("APR_NM",
                                        lineMap.getString("aprUserNm"));
                            }

                        }

                        fetFormContent.setParam("APR_MEMO",
                                strAprMemo.toString());
                    }
                    //--?????? ??????
                    fetForm.setParam("CONTENT",
                            fetFormContent.parseFormString(mailContent));


                    //-- ?????? ?????? ??????
                    String MAIN_LINK_URL = "";
                    fetForm.setParam("MAIN_LINK_URL", MAIN_LINK_URL);
                    if (!"".equals(params.getString("solMasUid"))) {
                        MAIN_LINK_URL =
                                CmmProperties.getSystemUrl() + "/?solMasUid=" +
                                        params.getString("solMasUid");
                        //--?????? ?????? ??????????????? ?????? ??? ?????? 20190425
                        MAIN_LINK_URL +=
                                "&viewDocUid=" + params.getString("docUid");
                        if ("F".equals(params.getString("stuDtl")) ||
                                "I".equals(params.getString("stuDtl"))) {
                            MAIN_LINK_URL +=
                                    "&aprNo=" + params.getString("aprNo");
                        }
                    }

                    fetForm.setParam("MAIN_LINK_URL", MAIN_LINK_URL);

                    rtnContentStr.append(fetForm.parseForm());

                }
            } catch (Exception e) {
                log.error("IpsMailSvc(getMailBody):" + e.getMessage());
                throw new RuntimeException(e);
            }
        }

        log.info("mailBody...." + rtnContentStr);

        return rtnContentStr.toString();
    }

    /**
     * ?????? ????????? ??????
     *
     * @param params
     * @param relMap
     * @param mailTitle
     * @return
     */
    private String getMailTitle(ParamMap<String, Object> params,
            ParamMap<String, Object> relMap, String mailTitle,
            String capitalizeSiteLocale) {
        //2019-04-08 skPark ???????????? 13-2 ?????? ?????? ?????? ?????? ?????? ????????????
        try {

            FetchForm fetFormContent = new FetchForm();
            if (relMap != null && !relMap.isEmpty()) {

                fetFormContent.setParam("TITLE", relMap.getString("title"));
                fetFormContent.setParam("MNG_NO", relMap.getString("mngNo"));
            }

            mailTitle = fetFormContent.parseFormString(mailTitle);

        } catch (Exception e) {
            log.warn(e.toString());
            throw new RuntimeException(e);
        }

        return mailTitle;
    }

    /**
     * ?????? ?????? ???????????? ??????
     *
     * @param ids
     * @param capitalizeSiteLocale
     * @return
     */
    @SuppressWarnings("unchecked")
    private String getMailInfo(String ids, String capitalizeSiteLocale) {
        StringBuilder rtnStr = new StringBuilder();
        if (StringUtil.isNotBlank(ids)) {
            ids = StringUtil.replace(ids, "^", "");
            String[] arrLoginId = ids.split(",");

            HrMngDTO hrMngDTO = new HrMngDTO();
            if (arrLoginId.length > 1) {
                hrMngDTO.setLoginIds(ids);
            } else {
                hrMngDTO.setLoginId(ids);
            }
            hrMngDTO.setUseYn("Y");

            List<Object> hrList =
                    cmmDAO.getList(cmmDAO.getStmtByNS(HR_NAMESPACE, "list"),
                            hrMngDTO);

            if (hrList != null && hrList.size() > 0) {
                for (int i = 0; i < hrList.size(); i++) {
                    ParamMap<String, Object> hrMap =
                            (ParamMap<String, Object>) hrList.get(i);

                    if (i != 0) {
                        rtnStr.append(",");
                    }

                    /*
                     * ???????????? ??????
                     * "%USER_NAME%" <%EMAIL_ADDRESS%>
                     */
                    rtnStr.append("\"").append(hrMap.getString(
                            "nm" + capitalizeSiteLocale)).append("\"");
                    rtnStr.append("<").append(hrMap.getString("email"))
                            .append(">");
                } // end of for
            }

        }


        return rtnStr.toString();
    }

    /**
     * ?????? ?????? or ????????? ?????? ??????
     *
     * @param relList
     * @param recRoleCd
     * @param recUserCd
     * @param loginId
     * @return
     */
    @SuppressWarnings("unchecked")
    private String getDefMailRec(List<Object> relList, String recRoleCd,
            String recUserCd, String loginId) {

        String rtn = "";
        if (StringUtil.isNotBlank(recRoleCd)) {
            String lastDocUid = "";
            if (relList != null && !relList.isEmpty()) {
                ParamMap<String, Object> relMap =
                        (ParamMap<String, Object>) relList.get(0);
                lastDocUid = relMap.getString("lastDocUid");
            }
            String[] arrRole = recRoleCd.split(",");
            if (arrRole.length > 0) {
                for (int i = 0; i < arrRole.length; i++) {
                    if (i > 0 && StringUtil.isNotBlank(rtn)) {
                        rtn += ",";    //-- ????????? 1??? ???????????? ?????? ????????? ????????? ?????? ??????.
                    }

                    if ("ED_APRV".equals(
                            arrRole[i])) {                //-- ???????????? ?????? ????????? ??? ???????????????(?????? ???????????? ??????)
                        //-- ???????????? ?????? ???????????? ???????????? ???????????????
                        rtn += getAprUser("BEFORE", lastDocUid, loginId);

                    } else if ("ALL_APRV".equals(
                            arrRole[i])) {        //-- ???????????? ?????? ??????????????? ????????? ??????

                        rtn += getAprUser("ALL", lastDocUid, loginId);

                    } else if ("NEXT_APRV".equals(
                            arrRole[i])) {        //-- ?????? ?????????

                        rtn += getAprUser("NEXT", lastDocUid, loginId);

                    } else if ("ROLE_DRAFTER".equals(
                            arrRole[i])) {        //-- ?????? ?????????

                        rtn += getAprUser("DRAFTER", lastDocUid, loginId);

                    } else if ("RED".equals(
                            arrRole[i])) {    //-- ???????????? ??????????????? ??????????????? ???????????? ?????? ????????? ????????????.

                        if (relList != null && !relList.isEmpty()) {
                            String deptCds = "";
                            for (Object o : relList) {
                                ParamMap<String, Object> relMap =
                                        (ParamMap<String, Object>) o;
                                if ("RED".equals(relMap.getString("roleCd"))) {
                                    if (StringUtil.isNotBlank(deptCds)) {
                                        deptCds += ",";
                                    }
                                    deptCds += relMap.getString("relNo");
                                }
                            }
                            if (StringUtil.isNotBlank(deptCds)) {
                                HrMngDTO hrMngDTO = new HrMngDTO();
                                hrMngDTO.setDeptCds(deptCds);
                                hrMngDTO.setUseYn("Y");

                                List<Object> hrList = cmmDAO.getList(
                                        cmmDAO.getStmtByNS(HR_NAMESPACE,
                                                "list"), hrMngDTO);
                                if (hrList != null && hrList.size() > 0) {
                                    for (Object o : hrList) {
                                        ParamMap<String, Object> hrMap =
                                                (ParamMap<String, Object>) o;
                                        if (StringUtil.isBlank(rtn)) {
                                            rtn += hrMap.getString("loginId");
                                        } else if (!rtn.endsWith(",")) {
                                            rtn += "," +
                                                    hrMap.getString("loginId");
                                        } else {
                                            rtn += hrMap.getString("loginId");
                                        }

                                    }
                                }

                            }


                        }
                    } else {
                        //-- ??? ?????? ???????????? T_SYS_ROLE_MAS??? ???????????? ?????? ???????????? ?????? ??????.
                        if (relList != null && !relList.isEmpty()) {
                            for (Object o : relList) {
                                ParamMap<String, Object> relMap =
                                        (ParamMap<String, Object>) o;
                                if (arrRole[i].equals(
                                        relMap.getString("roleCd"))) {
                                    if (StringUtil.isBlank(rtn)) {
                                        rtn += relMap.getString("relNo");
                                    } else if (!rtn.endsWith(",")) {
                                        rtn += "," + relMap.getString("relNo");
                                    } else {
                                        rtn += relMap.getString("relNo");
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        //?????????
        if (StringUtil.isNotBlank(recUserCd)) {
            if (StringUtil.isNotBlank(rtn)) {
                rtn += "," + recUserCd;
            } else {
                rtn += recUserCd;
            }
        }

        return rtn;
    }

    /**
     * ????????? ?????????
     *
     * @param lastDocUid
     * @param loginId
     * @return
     */
    @SuppressWarnings("unchecked")
    private String getAprUser(String type, String lastDocUid, String loginId) {
        StringBuilder rtn = new StringBuilder();
        AprvLineDTO aprvLineDTO = new AprvLineDTO();
        aprvLineDTO.setDocUid(lastDocUid);
        if ("BEFORE".equals(type)) {            //-- ??????????????? ?????????
            aprvLineDTO.setnAprStu("N");
            aprvLineDTO.setnAprLoginId(loginId);

        } else if ("NEXT".equals(type)) {        //-- ???????????? ????????? ?????????
            aprvLineDTO.setAprStu("W");

        } else if ("DRAFTER".equals(type)) {    //-- ??????????????? ?????????
            aprvLineDTO.setOrdNo("1");
        }

        List<Object> lineList =
                cmmDAO.getList(cmmDAO.getStmtByNS(APR_NAMESPACE, "aprLinelist"),
                        aprvLineDTO);
        if (lineList != null && lineList.size() > 0) {
            for (int i = 0; i < lineList.size(); i++) {
                ParamMap<String, Object> lineMap =
                        (ParamMap<String, Object>) lineList.get(i);
                if (i > 0) {
                    rtn.append(",");
                }
                rtn.append(lineMap.getString("aprLoginId"));
            } // end of for
        }
        return rtn.toString();
    }

    /**
     * ???????????? ???????????? ????????????
     *
     * @param list Mail DTO ??? ????????? ?????????
     */
    public void setMailData(List<Object> list) {
        // 2. ???????????? ????????????
        for (Object o : list) {
            if (o instanceof MailDTO) {
                log.debug("MailDTO...."+o);
                insertData((MailDTO) o);
            }
        }// end of for

//        throw new RuntimeException("????????? ??????");
    }

    /**
     * ???????????? ??????
     *
     * @param param ????????????
     */
    private void insertData(MailDTO param) {
        cmmDAO.insert(cmmDAO.getStmtByNS(NAMESPACE, "insert"), param);
    }

    /**
     * ????????? ?????? ?????? ??????
     *
     * @param params (solMasUid ??? ?????????) ????????? ????????? ????????? ?????? ??????
     * @return ????????? ????????????(MailDTO) ?????????
     */
    @SuppressWarnings("unchecked")
    @Transactional(readOnly = true)
    public List<Object> getMailListToSend(ParamMap<String, Object> params) {

        Map<String, Object> listParam = new HashMap<>(params);
        // 1. ?????? ??? ????????? ????????? ??????
        List<Object> relList = getRelUsersList(params);
        if (null == relList || relList.isEmpty()) {
            return null;
        }
        listParam.put("relList", relList);

        // 2. ?????? ?????? ????????? ??????
        Map<String, Object> tmpRelInfo = (Map<String, Object>) relList.get(0);
        listParam.put("defList", getDefMailList(tmpRelInfo));
        listParam.put("stuCd", tmpRelInfo.get("stuCd"));
        listParam.put("stuDtl", tmpRelInfo.get("stuDtl"));

        // 3. ????????? ?????? ????????? ??????
        return makeMailDTOList(listParam);
    }

    /**
     * ?????? DTO ????????? ?????????
     *
     * @param listParam (relList, defList, stuCd, stuDtl ?????????) ????????????
     * @return ?????? DTO ?????????
     */
    @SuppressWarnings({"unchecked", "rawtypes"})
    private List<Object> makeMailDTOList(Map<String, Object> listParam) {
        List<Object> rtnList = new ArrayList<>();

        List<Map<String, Object>> defList =
                (List<Map<String, Object>>) listParam.get("defList");
        List<Object> relList = (List<Object>) listParam.get("relList");

        ParamMap<String, Object> relInfo = new ParamMap<>();
        relInfo.putAll((Map<String, Object>) relList.get(0));

        String stuCd = String.valueOf(listParam.get("stuCd"));
        String stuDtl = String.valueOf(listParam.get("stuDtl"));
        String docUid = String.valueOf(listParam.get("docUid"));
        String solMasUid = String.valueOf(listParam.get("solMasUid"));
        String loginId = String.valueOf(listParam.get("loginId"));

        String siteLocale =
                StringUtils.replace(String.valueOf(listParam.get("siteLocale")),
                        "null", "");
        if (StringUtil.isBlank(siteLocale)) {
            siteLocale = "KO";
        }
        String capitalizeSiteLocale =
                StringUtil.capitalize(siteLocale.toLowerCase());// ko >> Ko

        ParamMap<String, Object> params = new ParamMap();
        params.putAll(listParam);

        for (Map<String, Object> defInfo : defList) {

            MailDTO mailDTO = new MailDTO();

            mailDTO.setEmailUid(StringUtil.getRandomUUID());
            mailDTO.setHtmlUseYn("Y");
            mailDTO.setStuCd(stuCd);
            mailDTO.setStuDtl(stuDtl);
            mailDTO.setRelUid(docUid);
            mailDTO.setSolMasUid(solMasUid);
            mailDTO.setSend(getMailInfo(loginId, capitalizeSiteLocale));

            // ????????? ??????
            mailDTO.setRec(getMailInfo(getDefMailRec(relList,
                            String.valueOf(defInfo.get("recRoleCd")),
                            String.valueOf(defInfo.get("recUserCd")), loginId),
                    capitalizeSiteLocale));

            // ????????? ??????
            mailDTO.setRef(getMailInfo(getDefMailRec(relList,
                            String.valueOf(defInfo.get("refRoleCd")),
                            String.valueOf(defInfo.get("refUserCd")), loginId),
                    capitalizeSiteLocale));

            params.put("stuTp", defInfo.get("stuTp"));
            params.put("stuTp2", defInfo.get("stuTp2"));

            // ?????? ??????
            mailDTO.setTit(getMailTitle(params, relInfo,
                    String.valueOf(defInfo.get("tit" + capitalizeSiteLocale)),
                    capitalizeSiteLocale));

            // ?????? ??????
//            mailDTO.setContent(getMailBody(params, relList, String.valueOf(
//                            defInfo.get("content" + capitalizeSiteLocale)),
//                    capitalizeSiteLocale));
            mailDTO.setContent(getSimpleMailBody(params, relList,
                    String.valueOf(
                            defInfo.get("content" + capitalizeSiteLocale)),
                    capitalizeSiteLocale));

            //--??????????????? ???????????? ??????????????? ?????????.
//            if (StringUtil.isNotBlank(yeyag_dte)) {
//                mailDTO.setResvDte(yeyag_dte);
//            }

            rtnList.add(mailDTO);
        }// end of for

        return rtnList;
    }

    @SuppressWarnings("unchecked")
    private String getSimpleMailBody(ParamMap<String, Object> params,
            List<Object> relList, String contentTemplate,
            String capitalizeSiteLocale) {

        String mailBody = "";

        String sysUrl = CmmProperties.getSystemUrl();
        ParamMap<String, Object> relInfo = new ParamMap<>();
        relInfo.putAll((Map<String, Object>) relList.get(0));

        String stuDtl = params.getString("stuDtl");

        FetchForm fetForm;
        try {
            fetForm = new FetchForm(DEFAULT_FORM_PATH);

            fetForm.setParam("SITE_URL", sysUrl);

            //--?????? ??????
            fetForm.setParam("CONTENT",
                    makeMailContent(params, contentTemplate, relInfo, relList,
                            capitalizeSiteLocale));

            //-- ?????? ?????? ??????
            String mainLinkUrl = sysUrl;
            fetForm.setParam("MAIN_LINK_URL", mainLinkUrl);
//            if (!"".equals(params.getString("solMasUid"))) {
//                mainLinkUrl =
//                        sysUrl + "/?solMasUid=" + params.getString("solMasUid");
//                //--?????? ?????? ??????????????? ?????? ??? ?????? 20190425
//                mainLinkUrl += "&viewDocUid=" + params.getString("docUid");
//
//                // ????????????(F), ?????????(I) ??? ??????
//                if (stuDtl.equals(StuDtlType.F.getStuDtlTypeCd()) ||
//                        stuDtl.equals(StuDtlType.I.getStuDtlTypeCd())) {
//                    mainLinkUrl += "&aprNo=" + params.getString("aprNo");
//                }
//                fetForm.setParam("MAIN_LINK_URL", mainLinkUrl);
//            }

            mailBody = fetForm.parseForm();
        } catch (Exception e) {
            log.error(e.getMessage());
            throw new RuntimeException(e);
        }

        // DEBUG
        if (log.isDebugEnabled()) {
            log.debug("mailBody...." + mailBody);
        }

        return mailBody;
    }

    @SuppressWarnings("unchecked")
    private String makeMailContent(ParamMap<String, Object> params,
            String contentTemplate, ParamMap<String, Object> relInfo,
            List<Object> relList, String capitalizeSiteLocale) {

        String content = null;
        //TODO ?????? ???????????? ?????????
        //SysLoginVO loginUser = (SysLoginVO) params.get("loginUser");
        //if (null == loginUser) {
           // loginUser = (SysLoginVO) SessionUtils.getLoginVO();
            SysLoginVO loginUser = (SysLoginVO) SessionUtils.getLoginVO();
       // }

        String reqUserNm =
                StringUtil.convertNull(relInfo.getString("reqUserNm"));
        String chrUserNm =
                StringUtil.convertNull(relInfo.getString("chrUserNm"));

        for (Object o : relList) {
            ParamMap<String, Object> rowMap = (ParamMap<String, Object>) o;

            if ("REQ".equals(rowMap.getString("roleCd"))) {
                reqUserNm = rowMap.getString("dspNm" + capitalizeSiteLocale);
            }
            if ("REW".equals(rowMap.getString("roleCd"))) {
                chrUserNm = rowMap.getString("dspNm" + capitalizeSiteLocale);
            }
        }// end of for

        try {
            FetchForm fetFormContent = new FetchForm();
            fetFormContent.setParam("TITLE", StringUtil.defaultIfBlank(
                    relInfo.getString("tit" + capitalizeSiteLocale), relInfo.getString("title")));

            fetFormContent.setParam("REQ_USER_NM", reqUserNm);
            fetFormContent.setParam("REQ_DTE",
                    StringUtil.convertNull(relInfo.getString("reqDte")));
            fetFormContent.setParam("MNG_NO",
                    StringUtil.convertNull(relInfo.getString("mngNo")));
            fetFormContent.setParam("CHR_USER_NM", chrUserNm);

            fetFormContent.setParam("LOGIN_NAM", loginUser.getDspName());
            content = fetFormContent.parseFormString(contentTemplate);

            log.debug("contentTemplate......" + contentTemplate);
            log.debug("content......" + content);

        } catch (Exception e) {
            log.error(e.getMessage());
            throw new RuntimeException(e);
        }

        return content;
    }

    /**
     * ???????????????????????????(?????? ??? ?????????) ????????? ??????
     *
     * @param params ????????????(solMasUid ??? ?????????)
     * @return ?????? ??? ????????? ????????? ?????????
     */
    @Transactional(readOnly = true)
    public List<Object> getRelUsersList(Map<String, Object> params) {
        Map<String, Object> schRelMap = new HashMap<>();
        schRelMap.put("solMasUid", String.valueOf(params.get("solMasUid")));
        return cmmDAO.getList(cmmDAO.getStmtByNS(SOL_NAMESPACE, "masList"),
                schRelMap);
    }
}
