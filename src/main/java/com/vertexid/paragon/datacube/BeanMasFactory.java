package com.vertexid.paragon.datacube;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.vertexid.commons.utils.ParamMap;
import com.vertexid.commons.utils.StringUtil;
import com.vertexid.viself.base.CmmDAO;

/**
 * @deprecated DocMasHandler, BaseDocMasHandler 로 변경
 */
public abstract class BeanMasFactory {

	private CmmDAO cmmDAO;

	public CmmDAO getCmmDAO() {
		return cmmDAO;
	}

	public void setCmmDAO(CmmDAO cmmDAO) {
		this.cmmDAO = cmmDAO;
	}

	/**
     * logger
     */
    protected Logger log = LoggerFactory.getLogger(this.getClass());

	/**
	 * 속성: 관리 MAS UID
	 */
	public static final String GWANRI_MAS_UID = "GWANRI_MAS_UID";

	public static final String SOL_MAS_UID = "SOL_MAS_UID";

	public static final String UIROE_NO = "REG_NO";

	public static final String JIJAEGWEON_GBN = "JIJAEGWEON_GBN";

	/**
	 * <pre>
	 * 업무 핸들러 얻기
	 * eobmu_gbn_code_id 를 읽어서 해당 시스템의 업무 핸들러를 얻는다.
	 * 해당 컨트롤러는 com.vertexid.paragon.%APP_NAME%.handler.%APP_NAME%%WORK_DOMAIN_NAME%SubHandler 이다.
	 *
	 * ex) com.vertexid.paragon.ips.handler.IpsThSubHandler
	 * </pre>
	 *
	 * @param solusionType
	 * @return
	 * @throws InstantiationException
	 * @throws IllegalAccessException
	 * @throws ClassNotFoundException
	 */
	public BeanSubHandlerInterface getSubHandler(String stuType2)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException {

		BeanSubHandlerInterface subHandler = null;
		StringBuffer strClassName = new StringBuffer();

		if (StringUtil.isBlank(stuType2)) {
			throw new ClassNotFoundException("파라메터 값이 없습니다.");
		}
		// 업무 구분 코드 ID
		String appName 	= "";
		String solusionType = "";
		//-- 접두 제거 LMS_CT >> CT
		if(stuType2.indexOf("_") > -1) {
			appName 	 = StringUtil.split(stuType2, "_")[0].toLowerCase();
			solusionType 	 = StringUtil.split(stuType2, "_")[1].toLowerCase();
//					solusionType = StringUtil.substring(solusionType, solusionType.indexOf("_")+1, solusionType.length());
		}
		//-- propertis.xml 솔루션 설정 정보를 가져온다 20191002 강세원
		strClassName.append("com.vertexid.").append(appName).append(".handler.")
				.append(StringUtil.capitalize(appName)).append(StringUtil.capitalize(solusionType))
				.append("SubHandler");

		log.debug("[appName=" + appName + "]");
		log.debug("[solusionType=" + solusionType + "]");
		log.debug("[strClassName=" + strClassName.toString() + "]");

		try {

			subHandler = (BeanSubHandlerInterface) Class.forName(strClassName.toString()).newInstance();

			// DEBUG

		} catch (ClassNotFoundException e) {
			throw new ClassNotFoundException("해당 클래스를 찾을 수 없습니다.(" + strClassName.toString() + ")", e);
		}

		return subHandler;

	}

	/**
	 * 어플리케이션 DMC를 통해서 관련 데이터의 초기정보를 등록한다.
	 *
	 * @param requestMap
	 * @param sqlExe
	 * @return
	 * @throws Exception TODO
	 */
	public abstract DataCubeDTO init(DataCubeDTO params);

	/**
	 * <pre>
	 * 어플리케이션 DMC를 통한 업무 처리
	 * </pre>
	 *
	 * @param requestMap
	 * @param sqlExe
	 */
	public abstract void doWork(DataCubeDTO params);

	/**
	 * <pre>
	 * 어플리케이션 DMC를 통한 메시지 전송 처리
	 * </pre>
	 *
	 * @param requestMap
	 * @param sqlExe
	 * @return TODO
	 */
	public abstract List<Object> sendMessage(ParamMap<String, Object> params);

}
