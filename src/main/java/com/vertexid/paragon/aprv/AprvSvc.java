package com.vertexid.paragon.aprv;

import com.vertexid.commons.utils.ParamMap;
import com.vertexid.paragon.datacube.DataCubeDTO;
import com.vertexid.paragon.datacube.DataCubeSvc;
import com.vertexid.paragon.datacube.DocMasHandler;
import com.vertexid.paragon.datacube.DocMasHandlerFactory;
import com.vertexid.viself.base.BaseSvc;
import com.vertexid.viself.base.CmmDAO;
import com.vertexid.viself.hr.SysLoginVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class AprvSvc extends BaseSvc{

    private static final String NAMESPACE =
            "com.vertexid.paragon.aprv.Aprv";

    private static final String CUBE_NAMESPACE =
            "com.vertexid.paragon.datacube.DataCube";

    @Resource(name = "cmmDAO")
    private CmmDAO cmmDAO;

    @Resource
    private DataCubeSvc dataCubeSvc;

    @Resource
    DocMasHandlerFactory docMasHandlerFactory;


    //-- 선삭제
    public void preDelete(DataCubeDTO params) {

        AprvMasDTO aprvMasDTO = new AprvMasDTO();
        aprvMasDTO.setDocUid(params.getDocUid());
        //-- 선 삭제후 재입력
        cmmDAO.delete(cmmDAO.getStmtByNS(NAMESPACE, "deleteLine"), aprvMasDTO);
        cmmDAO.delete(cmmDAO.getStmtByNS(NAMESPACE, "deleteMas"), aprvMasDTO);
    }
    /**
     * 결재 상신처리
     * @param params 결재관련 파라메터
     */
    public boolean doStartProc(DataCubeDTO params) {

        AprvMasDTO aprvMasDTO = new AprvMasDTO();
        List<AprvLineDTO> listAprvLine = params.getAprvLineDTO();

        if(null == listAprvLine || listAprvLine.isEmpty()){
            throw new RuntimeException("결재선 없음");
        }

        String newAprNo = cmmDAO.getOne(cmmDAO.getStmtByNS(NAMESPACE, "selectNewAprNo"), null);
        boolean isDeCide = false; //-- 전결여부
        aprvMasDTO.setAprNo(newAprNo);
        aprvMasDTO.setSolMasUid(params.getSolMasUid());
        aprvMasDTO.setDocUid(params.getDocUid());
        if(listAprvLine.size() == 1 && !"G".equals(params.getStuDtl())) {    //-- 전결일때
            aprvMasDTO.setAprMasStu("E");
            isDeCide = true;
        }else{
            if("G".equals(params.getStuDtl())) { //-- 검토후 결재요청일경우 N으로 처리 (검토완료후 결재 진행.)
                aprvMasDTO.setAprMasStu("N");
            }else {
                aprvMasDTO.setAprMasStu("S");
            }
        }
        aprvMasDTO.setRegLoginId(params.getRegLoginId());
        aprvMasDTO.setUptLoginId(params.getRegLoginId());

        preDelete(params);


        int masInt = cmmDAO.insert(cmmDAO.getStmtByNS(NAMESPACE, "insertMas"), aprvMasDTO);

        if(masInt > 0) {    //-- 마스터가 정상적으로 Insert 되었다면 실행
            if(listAprvLine != null && listAprvLine.size() > 0 ) {
                int seqCnt = 0;
                String beAprType = "";
                int lineInt = 0 ;
                for (int i = 0; i < listAprvLine.size(); i++) {
                    lineInt = 0 ;
                    AprvLineDTO tmpDTO =  listAprvLine.get(i);

                    if(!beAprType.equals(tmpDTO.getAprTp())) {
                        seqCnt++;
                        beAprType = tmpDTO.getAprTp();
                    }else {
                        //-- 병렬합이 일때는 같은 SEQ 값을 가지도록 한다.
                        if(!"B".equals(tmpDTO.getAprTp())) {
                            seqCnt++;
                        }
                    }
                    tmpDTO.setAprNo(newAprNo);
                    tmpDTO.setSolMasUid(aprvMasDTO.getSolMasUid());
                    if(i == 0) {                //-- 상신자 처리
                        if(isDeCide) {            //-- 전결처리 여부가 true 일때
                            tmpDTO.setAprStu("J");
                        }else {
                            tmpDTO.setAprStu("Y");
                        }
                        tmpDTO.setAprDte("TODAY");
                    }else if(seqCnt == 2) {     //-- 1차 처리자 처리
                        if("G".equals(params.getStuDtl())) { //-- 검토후 결재요청일경우 N으로 처리 (검토완료후 결재 진행.)
                            tmpDTO.setAprStu("N");
                        }else {
                            tmpDTO.setAprStu("W");
                        }
                    }else {
                        tmpDTO.setAprStu("N");
                    }
                    lineInt = cmmDAO.insert(cmmDAO.getStmtByNS(NAMESPACE, "insertLine"), tmpDTO);
                    if (ERROR_RESULT.equals(tmpDTO.getErrCd())) {
                        log.error("Error.Input parameters............." + tmpDTO);
                        throw new RuntimeException(tmpDTO.getErrMsg());
                    }
                    if(lineInt < 1) {
                        break; //-- TODO 입력 결재선이 없을경우 오류 발생.
                    }

                }

            }

        }else {
            log.error(".......................aprvMas Insert 실패 ");
            throw new RuntimeException(".......................aprvMas Insert Error!!");
        }

        return isDeCide;

    }

    /**
     * 결재 처리 진행
     * @param params
     * @return
     */
    public String doAprProc(Map<String, Object> params) {
        String rtnStr = "";
        SysLoginVO loginUser = (SysLoginVO)params.get("loginUser");
        ParamMap<String, Object> param = new ParamMap<>();
        param.putAll(params);    //-- Map >> ParamMap String으로 꺼내쓰기 편하도록 변환

        //-- 현재 결재선 먼저 구하기
        AprvLineDTO aprvLineDTO = new AprvLineDTO();
        aprvLineDTO.setAprLineUid(param.getString("aprLineUid"));
        ParamMap<String, Object> curLineMap =cmmDAO.getOne(cmmDAO.getStmtByNS(NAMESPACE, "aprLinelist"), aprvLineDTO);

        //-- 현재 결재선에서 추가 정보를 가져와 Map에 담는다.
        if(curLineMap != null && !curLineMap.isEmpty()) {
            param.put("aprNo", curLineMap.get("aprNo"));
            param.put("aprTp", curLineMap.get("aprTp"));
            param.put("ordNo", curLineMap.get("ordNo"));
        }

        //-- 결재 정보 업데이트
        String aprStu = param.getString("aprStu");
        DataCubeDTO dataCubeDTO = new DataCubeDTO();
        AprvLineDTO aprLineDTO = new AprvLineDTO();
        aprLineDTO.setAprStu(aprStu);
        aprLineDTO.setAprMemo(param.getString("aprMemo"));
        aprLineDTO.setAprDte("TODAY");
        aprLineDTO.setAprLineUid(param.getString("aprLineUid"));
        cmmDAO.update(cmmDAO.getStmtByNS(NAMESPACE, "updateLine"), aprLineDTO);

        //-- 다음 결재선 처리
        ParamMap<String, Object> nextMap = nextProc(param);
        String stuDtl = "";
        if(nextMap != null && !nextMap.isEmpty()) {
            stuDtl = nextMap.getString("stuDtl");
            dataCubeDTO.setDocUid(param.getString("docUid"));
            dataCubeDTO.setStuDtl(stuDtl);

            cmmDAO.update(cmmDAO.getStmtByNS(CUBE_NAMESPACE, "updateForDTO"), dataCubeDTO);

            if (ERROR_RESULT.equals(aprLineDTO.getErrCd())) {
                rtnStr = aprLineDTO.getErrMsg();
                log.error("Error.Input parameters............." + aprLineDTO);
                throw new RuntimeException(rtnStr);
            }
        }

        //-- 핸들러 처리 부분은 필요 함으로 기능 이관함
                // 어플리케이션별 핸들러 얻기
//        BeanMasFactory docMasHandler = null;
        DocMasHandler docMasHandler;
        dataCubeDTO.setStuTp2(param.getString("stuTp2"));
        dataCubeDTO.setNextStuCd(param.getString("stuCd"));
        dataCubeDTO.setStuCd(param.getString("stuCd"));
        dataCubeDTO.setSolMasUid(param.getString("solMasUid"));
        dataCubeDTO.setRegLoginId(param.getString("loginId"));
        dataCubeDTO.setUptLoginId(param.getString("loginId"));

//        try {
//            docMasHandler = dataCubeSvc.getDocMasHandler(dataCubeDTO.getStuTp2());
//        } catch (InstantiationException | IllegalAccessException | ClassNotFoundException e) {
//            e.printStackTrace();
//        }

//        docMasHandler = docMasHandlerFactory.getDocMasHandler(
//                ImsDocMasHandlerImpl.DOC_MAS_HANDLER_TYPE);
        String stuTp2 = dataCubeDTO.getStuTp2();
        docMasHandler = docMasHandlerFactory.getDocMasHandler(
                stuTp2.substring(0, stuTp2.indexOf("_")));
        if(null == docMasHandler){
            log.error("..................doc mas handler 가 없습니다.");
            throw new RuntimeException("..................no DOC MAS HANDLER ");
        }

//        docMasHandler.setCmmDAO(cmmDAO);
        docMasHandler.doWork(dataCubeDTO);
        if(!Boolean.getBoolean(nextMap.getString("isNoMail"))) {
            //메일발송 형식만 변경함.
            ParamMap<String, Object> mailMap = new ParamMap<>();
            mailMap.put("stuDtl", stuDtl);
            mailMap.put("stuCd",  "CM_APR");
            mailMap.put("siteLocale", param.getString("siteLocale"));
            mailMap.put("solMasUid", param.getString("solMasUid"));
            mailMap.put("loginId", param.getString("loginId"));
            mailMap.put("docUid", param.getString("docUid"));
            mailMap.put("loginUser", loginUser);

            //-- 다음 결재자 결재알림 메일 발송 처리
         //   docMasHandler.sendMessage(mailMap);

        }
        return rtnStr;
    }
    /**
     * 다음 결재선 처리
     * @param param
     * @return
     */
    @SuppressWarnings("unchecked")
    private ParamMap<String, Object> nextProc(ParamMap<String, Object> param) {
        ParamMap<String, Object> rtnMap = new ParamMap<>();
        String aprStu = param.getString("aprStu");
        String aprTp = param.getString("aprTp");
        //--다음결재자 대상처리 여부
        Boolean isNext = true;
        String aprStuMod = "";

        AprvLineDTO aprvLineDTO = new AprvLineDTO();
        aprvLineDTO.setDocUid(param.getString("docUid"));
        aprvLineDTO.setAprStu("W");
        rtnMap.put("isNoMail", false);
        //-- 병렬합의자 먼저 구하기
        List<Object> lineList =cmmDAO.getList(cmmDAO.getStmtByNS(NAMESPACE, "aprLinelist"), aprvLineDTO);

        //-- 승인일때 처리
        if("Y".equals(aprStu)) {

            //-- 병렬합의 일경우 다른 합의자가 존재여부에 따라 처리함.
            if("B".equals(aprTp)) {
                if(lineList != null && lineList.size() > 0) {
                    isNext = false;
                    aprStuMod="I";
                    rtnMap.put("isNoMail", true);
                }

            }

        }else {
            //-- 병렬합의 일경우 다음처리 진행 필요
            if("B".equals(aprTp)) {
                aprStuMod="I"; //-- 합의병렬은 부결이어도 결재를 완료 하지 않는다.
                if(lineList != null && lineList.size() > 0) {
                    isNext = false;
                    rtnMap.put("isNoMail", true);
                }
            }else {
                aprStuMod="R";
                isNext = false;
            }
        }
        //-- 다음 결재선 존재시
        if(isNext) {
            aprvLineDTO = null;
            aprvLineDTO = new AprvLineDTO();
            aprvLineDTO.setDocUid(param.getString("docUid"));
            aprvLineDTO.setOrdNo(String.valueOf(Integer.parseInt(param.getString("ordNo"))+1));

            lineList =cmmDAO.getList(cmmDAO.getStmtByNS(NAMESPACE, "aprLinelist"), aprvLineDTO);

            if(lineList != null && lineList.size() > 0) {
                ParamMap<String, Object> nextMap = (ParamMap<String, Object>)lineList.get(0);
                if("1".equals(nextMap.getString("ordNo"))) {
                    //-- 결재 상신
                    aprStuMod="F";
                }else {
                    //-- 결재 진행중
                    aprStuMod="I";

                }

                //-- 다음 결재자 대상으로 변경처리.
                AprvLineDTO aprLineDTO = new AprvLineDTO();
                aprLineDTO.setAprLineUid(nextMap.getString("aprLineUid"));
                aprLineDTO.setAprStu("W");
                cmmDAO.update(cmmDAO.getStmtByNS(NAMESPACE, "updateLine"), aprLineDTO);

            }else {
                //-- 결재 완료
                aprStuMod="A";
            }
        }

        //-- 결재 마스터 상태 업데이트
        if("A".equals(aprStuMod)) {//-- 결재완료
            aprStu = "A";
        }else if("I".equals(aprStuMod)) {//-- 결재중
            aprStu = "I";
        }else if("R".equals(aprStuMod)) {//-- 부결
            aprStu = "R";
        }else if("F".equals(aprStuMod)) {//-- 기안
            aprStu = "S";
        }
        AprvMasDTO aprvMasDTO = new AprvMasDTO();
        aprvMasDTO.setAprNo(param.getString("aprNo"));
        aprvMasDTO.setAprMasStu(aprStu);
        if("E".equals(aprStu) || "A".equals(aprStu)) {
            aprvMasDTO.setAprEdLoginId(param.getString("loginId"));
            aprvMasDTO.setAprEdDte("TODAY");
        }
        cmmDAO.update(cmmDAO.getStmtByNS(NAMESPACE, "updateMas"), aprvMasDTO);

        rtnMap.put("stuDtl", aprStuMod);

        return rtnMap;
    }

    /**
     * 결재선 수정 기능
     * @param params
     * @return
     */
    public String doAprvChgProc(AprvLineDTO params) {

        List<AprvLineDTO> list = params.getList();

        if(list != null && list.size() > 0) {
            int ordNo = 0;
            String beAprType = "";
            int lineInt = 0 ;
            //-- 선삭제 후 재 입력.
            cmmDAO.delete(cmmDAO.getStmtByNS(NAMESPACE, "deleteLine"), params);

            for (int i = 0; i < list.size(); i++) {
                lineInt = 0 ;
                AprvLineDTO tmpDTO = list.get(i);

                if(!beAprType.equals(tmpDTO.getAprTp())) {
                    ordNo++;
                    beAprType = tmpDTO.getAprTp();
                }else {
                    //-- 병렬합이 일때는 같은 SEQ 값을 가지도록 한다.
                    if(!"B".equals(tmpDTO.getAprTp())) {
                        ordNo++;
                    }
                }
                if(i == 0) {                //-- 상신자 처리
                    tmpDTO.setAprStu("Y");
                    tmpDTO.setAprDte("TODAY");
                }else if(ordNo == 2) {     //-- 1차 처리자 처리
                    tmpDTO.setAprStu("N");
                }else {
                    tmpDTO.setAprStu("N");
                }
                lineInt = cmmDAO.insert(cmmDAO.getStmtByNS(NAMESPACE, "insertLine"), tmpDTO);
                if (ERROR_RESULT.equals(tmpDTO.getErrCd())) {
                    log.error("Error.Input parameters............." + tmpDTO);
                    throw new RuntimeException(tmpDTO.getErrMsg());
                }
                if(lineInt < 1) {
                    break; //-- TODO 입력 결재선이 없을경우 오류 발생.
                }
            }

        }


        return null;
    }



}
