package com.vertexid.paragon.def.particlemng;

import com.vertexid.commons.utils.ParamMap;

public interface BeanInterfaceParticle {

    /**
     * Doc Mas Handler 유형 얻기
     * @return dos mas handler 유형
     */
    String getParticleType();

    /**
     * DB에 액세스 하여 결과를 반환 해 준다.
     *
     * @param params 관련 parameters
     */
    void particleExecuteQuery(ParamMap<String, Object> params, String mode);
}
