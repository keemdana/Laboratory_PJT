package com.vertexid.paragon.role;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.vertexid.commons.utils.ParamMap;
import com.vertexid.paragon.hr.HrMngDTO;
import com.vertexid.viself.base.BaseSvc;
import com.vertexid.viself.base.CmmDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;


@Service
@Transactional
public class RoleSvc extends BaseSvc {

    private static final String ROLE_NAMESPACE =
            "com.vertexid.paragon.role.RoleInfo";
    private static final String USER_NAMESPACE =
            "com.vertexid.paragon.hr.HrMng";
    private static final String AUTH_NAMESPACE =
            "com.vertexid.viself.auth.AuthMember";

    @Resource(name = "cmmDAO")
    private CmmDAO cmmDAO;

    /**
     * 작성자 롤 추가
     * @param roleDTO
     */
    public void addRoleWRT(RoleDTO roleDTO) {
        roleDTO.setRoleCd("WRT");    //-- 작성자
        cmmDAO.delete(cmmDAO.getStmtByNS(ROLE_NAMESPACE, "delete"), roleDTO);
        cmmDAO.insert(cmmDAO.getStmtByNS(ROLE_NAMESPACE, "insert"), roleDTO);
    }

    /**
     * 요청자 롤 추가
     * @param roleDTO
     */
    public void addRoleREQ(RoleDTO roleDTO) {
        roleDTO.setRoleCd("REQ");    //-- 요청자
        cmmDAO.delete(cmmDAO.getStmtByNS(ROLE_NAMESPACE, "delete"), roleDTO);
        cmmDAO.insert(cmmDAO.getStmtByNS(ROLE_NAMESPACE, "insert"), roleDTO);
    }

    /**
     * 요청부서 팀장 추가
     * @param paramMap
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public void addRoleREQ_C(ParamMap<String, Object> paramMap) throws Exception {

        RoleDTO roleDTO = new  RoleDTO();
        HrMngDTO hrMagDTO = new HrMngDTO();
        hrMagDTO.setDeptCd(paramMap.getString("deptCd"));
        hrMagDTO.setChiefYn("Y");

        List<Object> list =  cmmDAO.getList(cmmDAO.getStmtByNS(USER_NAMESPACE, "list"), hrMagDTO);

        if(list != null && !list.isEmpty()) {
            ParamMap<String, Object> rowMap = (ParamMap<String, Object>)list.get(0);

            roleDTO.setRoleCd("REQ_C");    //-- 요청자 팀장(전결권자)
            roleDTO.setSolMasUid(paramMap.getString("solMasUid"));
            roleDTO.setDocUid(paramMap.getString("docUid"));
            roleDTO.setRelNo(rowMap.getString("loginId"));
            cmmDAO.delete(cmmDAO.getStmtByNS(ROLE_NAMESPACE, "delete"), roleDTO);
            cmmDAO.insert(cmmDAO.getStmtByNS(ROLE_NAMESPACE, "insert"), roleDTO);

        }

    }

    /**
     * 미지정 배당자 롤 추가
     * @param paramMap
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public void addRoleNotDIS( RoleDTO paramMap) {

        RoleDTO roleDTO = new  RoleDTO();
        HrMngDTO hrMagDTO = new HrMngDTO();
        hrMagDTO.setAuthCd("LMS_BCD");
        hrMagDTO.setUseYn("Y");

        List<Object> list =  cmmDAO.getList(cmmDAO.getStmtByNS(USER_NAMESPACE, "list"), hrMagDTO);

        if(list != null && !list.isEmpty()) {
            ParamMap<String, Object> rowMap = (ParamMap<String, Object>)list.get(0);

            roleDTO.setRoleCd("DIVID");    //-- 배당자
            roleDTO.setSolMasUid(paramMap.getSolMasUid());
            roleDTO.setDocUid(paramMap.getDocUid());
            roleDTO.setRelNo(rowMap.getString("loginId"));
            cmmDAO.delete(cmmDAO.getStmtByNS(ROLE_NAMESPACE, "delete"), roleDTO);
            cmmDAO.insert(cmmDAO.getStmtByNS(ROLE_NAMESPACE, "insert"), roleDTO);

        }

    }

    /**
     * 배당자 확정 롤 추가
     * @param roleDTO
     */
    public void addRoleDIVID(RoleDTO roleDTO) {
        roleDTO.setRoleCd("DIVID");    //-- 배당자
        cmmDAO.delete(cmmDAO.getStmtByNS(ROLE_NAMESPACE, "delete"), roleDTO);
        cmmDAO.insert(cmmDAO.getStmtByNS(ROLE_NAMESPACE, "insert"), roleDTO);
    }

    /**
     * 미지정 사업기획팀 롤 추가
     * @param paramMap
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public void addRoleNotREW( RoleDTO paramMap) {

        RoleDTO roleDTO = new  RoleDTO();

        Map<String, Object> param = new HashMap<String, Object>();
        param.put("authCd", "IMS_CHR");
        List<Object> list =  cmmDAO.getList(cmmDAO.getStmtByNS(AUTH_NAMESPACE, "list"), param);

        roleDTO.setRoleCd("REW");    //-- 사업기획담당자
        roleDTO.setSolMasUid(paramMap.getSolMasUid());

        // 대상자가 있는 경우 기존 데이터 삭제
        if(list != null && !list.isEmpty()) {
            cmmDAO.delete(cmmDAO.getStmtByNS(ROLE_NAMESPACE, "delete"), roleDTO);
        }

        for(Object obj: list){
            ParamMap<String, Object> rowMap = (ParamMap<String, Object>)obj;

            roleDTO.setDocUid(paramMap.getDocUid());
            roleDTO.setRelNo(rowMap.getString("mbrId"));
            int insertCnt = cmmDAO.insert(cmmDAO.getStmtByNS(ROLE_NAMESPACE, "insert"), roleDTO);

            if(0 == insertCnt) {
                log.error(".......................addRoleNotREW Insert 실패 ");
                throw new RuntimeException("..........addRoleNotREW Error!!");
            }
        }// end of for
    }

    /**
     * 담당자 확정 롤 추가
     * @param roleDTO
     */
    public void addRoleREW(RoleDTO roleDTO) {
        roleDTO.setRoleCd("REW");    //-- 담당자
        cmmDAO.delete(cmmDAO.getStmtByNS(ROLE_NAMESPACE, "delete"), roleDTO);
        cmmDAO.insert(cmmDAO.getStmtByNS(ROLE_NAMESPACE, "insert"), roleDTO);
    }


}
