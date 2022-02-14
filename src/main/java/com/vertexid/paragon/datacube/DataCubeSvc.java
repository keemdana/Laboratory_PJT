package com.vertexid.paragon.datacube;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.vertexid.commons.utils.CaseConverter;
import com.vertexid.commons.utils.ParamMap;
import com.vertexid.commons.utils.StringUtil;
import com.vertexid.paragon.aprv.AprvSvc;
import com.vertexid.paragon.def.particlemng.BeanInterfaceParticle;
import com.vertexid.paragon.def.particlemng.ParticleFactory;
import com.vertexid.spring.utils.SessionUtils;
import com.vertexid.viself.base.BaseSvc;
import com.vertexid.viself.base.CmmDAO;
import com.vertexid.viself.hr.SysLoginVO;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.converter.json.Jackson2ObjectMapperBuilder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class DataCubeSvc extends BaseSvc{

    private static final String NAMESPACE =
            "com.vertexid.paragon.datacube.DataCube";

    private static final String REL_NAMESPACE =
            "com.vertexid.paragon.def.defsturel.DefStuRel";

    private static final String PATI_REL_NAMESPACE =
            "com.vertexid.paragon.def.defstumng.DefStuParti";

//    private static final String PATI_MNG_NAMESPACE =
//            "com.vertexid.paragon.def.particlemng.ParticleMng";

//    private static final String APRV_NAMESPACE =
//            "com.vertexid.paragon.aprv.Aprv";


    @Resource(name = "cmmDAO")
    private CmmDAO cmmDAO;

    @Resource
    AprvSvc aprvSvc;

    /**
     * 결재인터페이스 연동 여부
     */
    @Value(value = "#{cmmProperties['aprv.if.userYn']}")
    private String aprvIfUseYn;

    @Resource
    DocMasHandlerFactory docMasHandlerFactory;

    @Resource
    ParticleFactory particleFactory;

    public String doWriteProc(DataCubeDTO params) {
        String rtnStr = "";        //-- REVIEW 오류 처리를 위한 변수 설정 나중에 진행 20210118
        SysLoginVO loginUser = params.getLoginUser();
        String doc_uid = params.getDocUid();

        DocMasHandler docMasHandler = getDocMasHandler(params.getStuTp2());

        //-- 핸들러 init 실행
        params = (docMasHandler.init(params));

        //-- 문서 처리 구분
        String stu_dtl = params.getStuDtl();

        //-- 문서 삭제
        if("D".equals(stu_dtl)) {
            deleteTempDoc(params);

        }else {
            //-- 다음 처리 상태 정보
            String nextStuCd = params.getNextStuCd();
            String stuCd     = params.getStuCd();
            if(StringUtil.isBlank(nextStuCd)) nextStuCd = stuCd;

            Map<String, Object> whereMap = new HashMap<>();
            Map<String, Object> updateMap = new HashMap<>();
            whereMap.put("nextStuCd", nextStuCd);
            whereMap.put("stuCd", stuCd);
            whereMap.put("inUid", "");

            ParamMap<String, Object> rs =  cmmDAO.getOne(cmmDAO.getStmtByNS(REL_NAMESPACE, "outListOne"), whereMap);
            if(rs != null && !rs.isEmpty()) {
                params.setStuCd(rs.getString("stuCd"));
                params.setNextStuCd(rs.getString("nextStuCd"));
//                requestMap.put("STU_TYPE"        , rs.getString("STU_TYPE"));
//                requestMap.put("STU_CD"            , rs.getString("STU_CD"));
//                requestMap.put("NEXT_STU_CD"    , rs.getString("NEXT_STU_CD"));
//                requestMap.put("PROC_TYPE"        , rs.getString("PROC_TYPE"));
            }

            String group_uid = params.getGroupUid();
            if(StringUtil.isNotBlank(group_uid) ) {
                if(!"T".equals(stu_dtl)) {
                	DataCubeDTO updateDto = new DataCubeDTO();
                	updateDto.setLastYn("N");
                	updateDto.setGroupUid(group_uid);
                	updateDto.setDocUid(doc_uid);

                    int updateCnt = cmmDAO.update(cmmDAO.getStmtByNS(NAMESPACE, "updateForDTO"), updateDto);

                    if(0 == updateCnt) {
                    	log.error(".......................LastDocUid 업데이트 실패 ");
                    	throw new RuntimeException(".......................LastDocUid Update Error!!");
                    }
                }
            }else {
//                params.setGroupUid(params.getDocUid());
                group_uid = StringUtil.getRandomUUID();
                params.setGroupUid(group_uid);
            }

            //-- 문서 저장 처리
            if("C".equals(params.getCud())) {
                if("X".equals(stu_dtl)) {
                    //--마지막 차수의 작은 seq를 구한다
                    ParamMap<String, Object> rsD =  cmmDAO.getOne(cmmDAO.getStmtByNS(REL_NAMESPACE, "listMinOrdNo"), whereMap);

                    if(rsD != null && !rsD.isEmpty()) {
                        //--구한 작은 seq 부터 SEQ를 1씩증가 시킨다.
                        updateMap.put("ordNo", "PLUS");
                        updateMap.put("solMasUid", params.getSolMasUid());
                        updateMap.put("ordNoGteq", rsD.get("minSeq"));

                        int updateCnt = cmmDAO.update(cmmDAO.getStmtByNS(NAMESPACE, "update"), updateMap);
                        if(0 == updateCnt) {
                        	log.error(".......................dataCubeSvc ordNo 업데이트 실패 ");
                        	throw new RuntimeException(".......................dataCubeSvc ordNo Update Error!!");
                        }
                        //--새로 입력할 문서의 seq는 구한 작은 seq 부터 SEQ를 1씩증가 시킨다.
                        params.setOrdNo(rsD.getString("minSeq"));
                    }
                }else {
                    params.setOrdNo("MAX");
                }

                params.setLastYn("Y");

                cmmDAO.insert(cmmDAO.getStmtByNS(NAMESPACE, "insert"), params);
                if (ERROR_RESULT.equals(params.getErrCd())) {
                    rtnStr = params.getErrMsg();
                    log.error("Error.Input parameters............." + params);
                    throw new RuntimeException(rtnStr);
                }
            }else {

                if(!"T".equals(stu_dtl)) {
                    params.setNextStuCd("");
                }
                cmmDAO.update(cmmDAO.getStmtByNS(NAMESPACE, "updateForDTO"), params);
                if (ERROR_RESULT.equals(params.getErrCd())) {
                    rtnStr = params.getErrMsg();
                    log.error("Error.Input parameters............." + params);
                    throw new RuntimeException(rtnStr);
                }

            }


        }

        //-- 파티클 처리
        particleManager(params, "BASIC_DATA_UPDATE", doc_uid);


        if(StringUtil.isBlank(params.getMode())) {        //-- 문서를 수정모드로 열때는 아래 모듈을 태우지 않음.
            //-- 결재처리 시작: 결재상신(F), 검토후 결재요청(G)
            if("F".equals(stu_dtl) || "G".equals(stu_dtl)) {
                boolean isDeCide =  aprvSvc.doStartProc(params);     //-- 전결여부 리턴
                if(isDeCide) {    //-- 전결일때 처리
                    ParamMap<String, Object> updateMap = new ParamMap<>();
                    updateMap.put("nextStuCd", "");
                    // 최종결재완료(A)
                    updateMap.put("stuDtl", "A");
                    updateMap.put("docUid", params.getDocUid());

                    cmmDAO.update(cmmDAO.getStmtByNS(NAMESPACE, "update"), updateMap);

                    //-- 핸들러 doWork 실행
                    docMasHandler.doWork(params);
                }else {
                    //-- 핸들러 doWork 실행
                    docMasHandler.doWork(params);
                }

                ParamMap<String, Object> handlerMap = new ParamMap<>();
                if("G".equals(stu_dtl)) {
                	handlerMap.put("stuCd", params.getStuCd());
                	handlerMap.put("stuDtl", stu_dtl);
                }else {
                	handlerMap.put("stuCd", "CM_APR");
                	if(isDeCide) {		//-- 전결일경우
                        // 최종결재완료(A)
                		handlerMap.put("stuDtl", "A");
                	}else {		//-- 상신일경우
                        // 결재상신(F)
                		handlerMap.put("stuDtl", "F");
                	}
                }
                handlerMap.put("loginId", params.getRegLoginId());
                handlerMap.put("solMasUid", params.getSolMasUid());
                handlerMap.put("docUid", params.getDocUid());

                if(canSendMssage(params)){
                    //-- 기안자에게 결재 완료 알림 메일 발송
                    docMasHandler.sendMessage(handlerMap);
                }

            }else {
                //-- 혹시 기존 등록된 결재선 삭제
                aprvSvc.preDelete(params);
                //-- 핸들러 doWork 실행
                docMasHandler.doWork(params);

                ParamMap<String, Object> handlerMap = new ParamMap<>();
                handlerMap.put("stuCd", params.getStuCd());
                handlerMap.put("stuDtl", params.getStuDtl());
                handlerMap.put("solMasUid", params.getSolMasUid());
                handlerMap.put("docUid", params.getDocUid());
                handlerMap.put("loginId", params.getRegLoginId());
                handlerMap.put("siteLocale", params.getSiteLocale());
                handlerMap.put("loginUser", loginUser);
                if(canSendMssage(params)) {
                    //-- 메일발송 실행
                    docMasHandler.sendMessage(handlerMap);
                }
            }

        }

        return rtnStr;
    }

    /**
     * 데이터 큐브에서 메일전송 가능 여부
     * @param params 검사 파라메터
     * @return true: 데이터 큐브에서 전송, other: 진행하지 않거나 다른 서비스에서 처리
     */
    private boolean canSendMssage(DataCubeDTO params) {

        // 심의요청(SM_REQ) 기안이고 결재연동(Y)의 경우 메일발송 하지 않음
        if("Y".equals(aprvIfUseYn) && "SM_REQ".equals(params.getStuCd())){
            return false;
        }
        
        return true;
    }

    /**
     * 파티클 베이직 업데이트 처리
     * @param params 파라메터
     * @param mode 처리 모드
     * @param doc_uid doc uid
     */
    @SuppressWarnings("unchecked")
    private void particleManager(DataCubeDTO params, String mode, String doc_uid) {
        String classPath = "";

        //-- 문서 처리 구분
        String stu_dtl = params.getStuDtl();

        ParamMap<String, Object> whereMap = new ParamMap<>();
        if("BASIC_DATA_UPDATE".equals(mode)) {
            whereMap.put("stuCd", params.getStuCd());
            whereMap.put("page", "");
            List<Object> rsInfo =  cmmDAO.getList(cmmDAO.getStmtByNS(PATI_REL_NAMESPACE, "list"), whereMap);

            if (rsInfo != null && rsInfo.size() > 0) {

                // 파티클 전달 MAP
                ParamMap<String, Object> patiMap = new ParamMap<>(CaseConverter.ConvertCaseType.NO_CASE);
                Jackson2ObjectMapperBuilder object2Mapper = new Jackson2ObjectMapperBuilder();
                try {
                    object2Mapper.propertyNamingStrategy(PropertyNamingStrategies.SNAKE_CASE);
                    patiMap.putAll(object2Mapper.build().readValue(params.getJsonData(), Map.class));
                } catch (IOException e1) {
                    // TODO Auto-generated catch block
                    e1.printStackTrace();
                }

                patiMap.put("solMasUid", params.getSolMasUid());
                patiMap.put("docUid", params.getDocUid());
                patiMap.put("stuCd", params.getStuCd());
                patiMap.put("regLoginId", params.getRegLoginId());
                patiMap.put("siteLocale", params.getSiteLocale());

                for (int i = 0; i < rsInfo.size(); i++) {
                    ParamMap<String, Object> rowMap =  (ParamMap<String,Object>)rsInfo.get(i);
//                    classPath             = rowMap.getString("patiClassPath");
//                    try {
//                        BeanInterfaceParticle bi = (BeanInterfaceParticle) Class.forName(classPath).newInstance();
//                        if((!"T".equals(stu_dtl)
//                                && !"D".equals(stu_dtl))) {
//                            bi.setCmmDAO(cmmDAO);
//                            bi.particleExecuteQuery(patiMap, "BASIC_DATA_UPDATE");
//                        }
//                    }catch (Exception e) {
//                        log.error(e.getMessage());
//                        throw new RuntimeException("ERROR:<br/>"+rowMap.getString("patiNm")+"("+rowMap.getString("patiMngNo")+") 처리도중 오류가 발행하였습니다.");
//                    }

                    BeanInterfaceParticle beanInterfaceParticle = particleFactory.getParticle(rowMap.getString("patiMngNo"));
                    if(null == beanInterfaceParticle){
                        log.error("..................doc mas handler 가 없습니다.");
                        throw new RuntimeException("..................no doc mas handler");
                    }

                    beanInterfaceParticle.particleExecuteQuery(patiMap, "BASIC_DATA_UPDATE");

                }
            }
        }
    }


    private void deleteTempDoc(DataCubeDTO params) {

        ParamMap<String, Object> whereMap = new ParamMap<>();

        if(StringUtil.isNotBlank(params.getLastDocUid())) {
            whereMap.put("docUid", params.getLastDocUid());
        }else {
            whereMap.put("docUid", params.getDocUid());
        }

        ParamMap<String, Object> rowMap =  cmmDAO.getOne(cmmDAO.getStmtByNS(NAMESPACE, "listOne"), whereMap);

        if(rowMap != null && !rowMap.isEmpty() ) {

            //-- 임시저장문서 삭제
            whereMap.clear();
            whereMap.put("docUid", rowMap.get("docUid"));

            cmmDAO.delete(cmmDAO.getStmtByNS(NAMESPACE, "deleteOne"), params);

            //--이전 문서 정보 구하기
            whereMap.clear();
            whereMap.put("solMasUid", rowMap.get("solMasUid"));
            whereMap.put("ordNo",  (Integer.valueOf(rowMap.getString("ordNo")))-1);

            //--이전문서 정보를 마지막 문서로 마스터에 업데이트
            ParamMap<String, Object> rsBeforeDc =  cmmDAO.getOne(cmmDAO.getStmtByNS(NAMESPACE, "listOne"), whereMap);
            if(rsBeforeDc != null && !rsBeforeDc.isEmpty()) {

                //-- 다음 문서 정보 업데이트
                ParamMap<String, Object> updateMap = new ParamMap<>();
                updateMap.clear();
                updateMap.put("lastDocUid", rsBeforeDc.getString("docUid"));
                updateMap.put("solMasUid", rsBeforeDc.getString("solMasUid"));


                String stu_type = params.getStuTp2();
                if(StringUtil.isBlank(stu_type)) {
                    stu_type = rsBeforeDc.getString("stuType2");
                }
                String[] arrStuType = stu_type.split("_");
                String solPath = "com.vertexid.paragon.datacube.DataCube";
                if(arrStuType != null && arrStuType.length > 1) {
                    solPath = "com.vertexid."+arrStuType[0].toLowerCase()+"."+
                            StringUtil.capitalize(arrStuType[1])+"Mas";
                    cmmDAO.getOne(cmmDAO.getStmtByNS(solPath, "update"), updateMap);
                }
                //-- 이전문서 UID로 지정해 준다.
                params.setLastDocUid(rsBeforeDc.getString("docUid"));


                //-- 이전 문서를 최종 문서 정보를 초기화 시킨다.
                updateMap.clear();
                updateMap.put("lastYn", "Y");
                updateMap.put("nextStuCd", "");
                updateMap.put("docUid", rsBeforeDc.getString("docUid"));
                cmmDAO.getOne(cmmDAO.getStmtByNS(NAMESPACE, "update"), updateMap);

            }
        }

    }


//    /**
//     * @deprecated DocMasFactory.getDocMasHandler 로 변경
//     *
//     * @param stuTp2
//     * @return
//     * @throws InstantiationException
//     * @throws IllegalAccessException
//     * @throws ClassNotFoundException
//     */
//    public BeanMasFactory getDocMasHandler(String stuTp2)
//            throws InstantiationException, IllegalAccessException, ClassNotFoundException{
//
//        BeanMasFactory rtnCtrl = null;
//        StringBuffer strClassName = new StringBuffer();
//        // 업무 구분 코드 ID
//        String stuType2 = stuTp2;
//        String appName     = "";
//        String solusionType = "";
//        //-- 접두 제거 LMS_CT >> CT
//        if(stuType2.indexOf("_") > -1) {
//            appName      = StringUtil.split(stuType2, "_")[0].toLowerCase();
//            solusionType      = StringUtil.split(stuType2, "_")[1].toLowerCase();
////            solusionType = StringUtil.substring(solusionType, solusionType.indexOf("_")+1, solusionType.length());
//        }
//        //-- propertis.xml 솔루션 설정 정보를 가져온다 20191002 강세원
//        strClassName.append("com.vertexid.").append(appName).append(".handler.")
//                    .append(StringUtil.capitalize(appName)).append("DocMasHandler");
//
//        log.debug("[appName=" + appName + "]");
//        log.debug("[solusionType=" + solusionType + "]");
//        log.debug("[strClassName=" + strClassName.toString() + "]");
//        try {
//            rtnCtrl = (BeanMasFactory) Class.forName(strClassName.toString()).newInstance();
//            // DEBUG
//
//        } catch (ClassNotFoundException e) {
//            throw new ClassNotFoundException("해당 클래스를 찾을 수 없습니다.(" + strClassName.toString() + ")", e);
//        }
//
//        return rtnCtrl;
//    }

    /**
     * 상태만 변경 처리
     * @param params
     * @return
     */
    public String doStuProc(Map<String, Object> params) {

        String rtnStr = "";         // TODO Auto-generated method stub

        String beStuCd = (String)params.get("beStuCd");
        String beStuDtl = (String)params.get("beStuDtl");
        String docUid    = (String)params.get("docUid");
        String stuCd    = (String)params.get("stuCd");
        String stuDtl    = (String)params.get("stuDtl");
        String inUid    = (String)params.get("inUid");
        String solMasUid= (String)params.get("solMasUid");
        String stuTp2    = (String)params.get("stuTp2");

        SysLoginVO loginUser = (SysLoginVO)SessionUtils.getLoginVO();
        DataCubeDTO dataCubeDTO = new DataCubeDTO();

        dataCubeDTO.setDocUid(docUid);
        dataCubeDTO.setStuCd(stuCd);
        dataCubeDTO.setStuDtl(stuDtl);
        dataCubeDTO.setSolMasUid(solMasUid);
        dataCubeDTO.setBeStuCd(beStuCd);
        dataCubeDTO.setBeStuDtl(beStuDtl);
        dataCubeDTO.setRegLoginId(loginUser.getLoginId());
        dataCubeDTO.setUptLoginId(loginUser.getLoginId());
        dataCubeDTO.setStuTp2(stuTp2);

        //-- datacube 세부상태 업데이트 ※STU_CD는 업데이트 하면 안됨.!!(문서 종류가 바뀌어버림.)
        DataCubeDTO updateDto = new DataCubeDTO();
        updateDto.setDocUid(docUid);
        if("G".equals(beStuDtl) && stuCd.indexOf("REVIEW") > -1 ) {
        	updateDto.setStuDtl("F");
        }else {
        	updateDto.setStuDtl(stuDtl);
        }
        int updateCnt = cmmDAO.update(cmmDAO.getStmtByNS(NAMESPACE, "updateForDTO"), updateDto);
        if(0 == updateCnt) {
        	log.error(".......................DataCube stuDtl 업데이트 실패 ");
        	throw new RuntimeException(".......................DataCube stuDtl Update Error!!");
        }

        DocMasHandler docMasHandler = getDocMasHandler(stuTp2);
        try {
        	docMasHandler.doWork(dataCubeDTO);

        	if(!"Y".equals(aprvIfUseYn)) {
                // 결재인터페이스를 연동하지 않을 경우(!"Y".equals(aprvIfUseYn)) 아래 로직 수행

                ParamMap<String, Object> handlerMap = new ParamMap<>();
                handlerMap.put("stuCd", stuCd);
                handlerMap.put("stuDtl",stuDtl);
                //--
                if("G".equals(beStuDtl) && stuCd.indexOf("REVIEW") > -1 ) {
                    handlerMap.put("stuCd", "CM_APR");
                    handlerMap.put("stuDtl", "F");
                }
                handlerMap.put("solMasUid", solMasUid);
                handlerMap.put("docUid", docUid);
        		docMasHandler.sendMessage(handlerMap);
        	}

		} catch (Exception e) {
            log.error(e.getMessage());
            throw new RuntimeException(e);
			//rtnStr = "Error";
		}

        return rtnStr;
    }

    /**
     * DOC MAS Handler 얻기
     * @param stuTp2 %DOC_MAS_TYPE%+'_'+... (ex: IMS_DF)
     * @return doc mas handler
     */
    private DocMasHandler getDocMasHandler(String stuTp2){
        DocMasHandler docMasHandler = docMasHandlerFactory.getDocMasHandler(stuTp2.substring(0, stuTp2.indexOf("_")));
        if(null == docMasHandler){
            log.error("..................doc mas handler 가 없습니다.");
            throw new RuntimeException("..................no doc mas handler");
        }
        return docMasHandler;
    }

}
