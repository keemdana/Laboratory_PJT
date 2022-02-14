package com.vertexid.paragon.def.particlemng;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

/**
 * <b>Description</b>
 * <pre>
 *     Particle handler Factory
 * </pre>
 *
 * @author 강세원
 */
@Component
public class ParticleFactory {

	@Resource
    private List<BeanInterfaceParticle> docMasHandlerList;

    /**
     * particle handler type 으로 doc mas handler 반환
     *
     * @param docMasHandlerType doc mas handler type
     * @return doc mas handler
     */
    public BeanInterfaceParticle getParticle(String particleType) {
        for (BeanInterfaceParticle beanInterfaceParticle : docMasHandlerList) {
            if (particleType
                    .equalsIgnoreCase(beanInterfaceParticle.getParticleType())) {
                return beanInterfaceParticle;
            }
        }// end of for
        return null;
    }
}
