package com.vertexid.paragon.def.particlemng;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.vertexid.commons.utils.FileUtil;
import com.vertexid.commons.utils.ParamMap;
import com.vertexid.commons.utils.StringUtil;
import com.vertexid.spring.utils.CmmProperties;
import com.vertexid.viself.base.BaseSvc;
import com.vertexid.viself.base.CmmDAO;


/**
 * 파티클 관리 서비스
 * @author sitas
 * @sinse 2020.12.354
 */
@Transactional
@Service
public class ParticleMngSvc extends BaseSvc{

	private static final String NAMESPACE = "com.vertexid.paragon.def.particlemng.ParticleMng";

	@Resource(name = "cmmBatchDAO")
    private CmmDAO cmmDAO;

	public String createSource(Map<String, Object> params) {

		String patiUid = (String)params.get("patiUid");

		ParamMap<String, Object> result =  cmmDAO.getOne(cmmDAO.getStmtByNS(NAMESPACE, "listOne"),  params);

		if(!result.isEmpty()) {


			String PATI_TYPE_ABB_1= result.getString("patiTpAbbCd");
			String PATI_TYPE_ABB_2= result.getString("patiTpAbbCd2");

			String pati_nam 		= result.getString( "patiNm");
			String str 				= result.getString( "patiMngNo");
			String code1			= PATI_TYPE_ABB_1;
			String code2			= PATI_TYPE_ABB_2;
			String patiMngNo		= code1 +"_"+code2+"_"+str.replaceAll("-","").substring(8, 11);
			String pati_view_only   = result.getString( "patiOnlyViewYn");

			if("CMM".equals(code1)){
				code1="COMMON";
			}
			String JSP_ROOT  = CmmProperties.getSrcRootPath() + "/src/main/webapp/WEB-INF/jsp";
			String JAVA_ROOT = CmmProperties.getSrcRootPath() + "/src/main/java";

			String template_paticle_class          = "";
			if("Y".equals(pati_view_only)){
				template_paticle_class          = JSP_ROOT + "/paragon/_template_pati/ParticleViewOnly.txt";
			}else{
				template_paticle_class          = JSP_ROOT + "/paragon/_template_pati/Particle.txt";
			}
			String template_pati_wrt_jsp  		   = JSP_ROOT + "/paragon/_template_pati/particle_write.txt";
			String template_pati_view_jsp 		   = JSP_ROOT + "/paragon/_template_pati/particle_view.txt";

			String new_paticle_class          = JAVA_ROOT + "/com/vertexid/"+code1.toLowerCase()+"/particle/" + StringUtil.getWordHeadInitialToUpper(code1) + StringUtil.getWordHeadInitialToUpper(code2) + str.replaceAll("-","").substring(8, 11)+"Particle.java" ;

			String new_pati_wrt_jsp  		   = "";
			String new_pati_view_jsp 		   = "";

			new_pati_wrt_jsp  		   = JSP_ROOT + "/"+code1.toLowerCase()+"/particle/"+StringUtil.convert2CamelCase(patiMngNo)+"/"+ StringUtil.convert2CamelCase(patiMngNo)+"Write.jsp";
			new_pati_view_jsp 		   = JSP_ROOT + "/"+code1.toLowerCase()+"/particle/"+StringUtil.convert2CamelCase(patiMngNo)+"/"+ StringUtil.convert2CamelCase(patiMngNo)+"View.jsp";

			FileUtil.makeDir(JSP_ROOT + "/"+code1.toLowerCase()+"/particle/"+StringUtil.convert2CamelCase(patiMngNo));

			FileUtil.copy(template_paticle_class, new_paticle_class);
			FileUtil.copy(template_pati_view_jsp, new_pati_view_jsp);
			if(!"Y".equals(pati_view_only)){
//				FileUtil.copy(template_paticle_model_class, new_paticle_class);
				FileUtil.copy(template_pati_wrt_jsp, new_pati_wrt_jsp);
			}

			String rp_pati_title = pati_nam;
			String rp_hashmap_value = str.replaceAll("-","").substring(3, 11);
			String rp_model_name = StringUtil.getWordHeadInitialToUpper(code1)+ "Pati" +  StringUtil.getWordHeadInitialToUpper(code2) + str.replaceAll("-","").substring(8, 11)+"Model";
			String rp_pati_class_name = StringUtil.getWordHeadInitialToUpper(code1) + StringUtil.getWordHeadInitialToUpper(code2) + str.replaceAll("-","").substring(8, 11)+"Particle";
			String rp_key_name_upper =  code1.toUpperCase() +"_PATI_"+code2.toUpperCase()+"_"+str.replaceAll("-","").substring(8, 11)+"_UID";
			String rp_key_name_lower = code1.toLowerCase() +"_pati_"+ code2.toLowerCase()+"_"+str.replaceAll("-","").substring(8, 11)+"_uid";
			String rp_table_name     = "T_" + code1.toUpperCase() +"_PATI_"+code2.toUpperCase()+"_"+str.replaceAll("-","").substring(8, 11);

			String rp_particle_package = "com.vertexid."+code1.toLowerCase()+".particle";
			String rp_model_package = "com.vertexid."+code1.toLowerCase()+".model";

			String content_particle_class 	= "";
			String content_model_class 		= "";
			String content_write_jsp 		= "";
			String content_view_jsp 		= "";

			content_particle_class 	= FileUtil.getContent(new_paticle_class);
			content_view_jsp 		= FileUtil.getContent(new_pati_view_jsp);

			if(!"Y".equals(pati_view_only)){
				content_write_jsp 		= FileUtil.getContent(new_pati_wrt_jsp);
			}

			content_particle_class = StringUtil.replace(content_particle_class,"[|HASHMAP_VALUE|]",rp_hashmap_value   );
			content_particle_class = StringUtil.replace(content_particle_class,"[|PATI_TITLE|]",rp_pati_title      );
			content_particle_class = StringUtil.replace(content_particle_class,"[|HASHMAP_VALUE|]",rp_hashmap_value   );
			content_particle_class = StringUtil.replace(content_particle_class,"[|MODEL_NAME|]",rp_model_name      );
			content_particle_class = StringUtil.replace(content_particle_class,"[|PATI_CLASS_NAME|]",rp_pati_class_name );
			content_particle_class = StringUtil.replace(content_particle_class,"[|TABLE_NAME|]",rp_table_name      );
			content_particle_class = StringUtil.replace(content_particle_class,"[|KEY_NAME_LOWER|]",rp_key_name_lower  );
			content_particle_class = StringUtil.replace(content_particle_class,"[|KEY_NAME_UPPER|]",rp_key_name_upper  );
			content_particle_class = StringUtil.replace(content_particle_class,"[|PARTICLE_PACKAGE|]",rp_particle_package);
			content_particle_class = StringUtil.replace(content_particle_class,"[|MODEL_PACKAGE|]",rp_model_package   );

			content_view_jsp = StringUtil.replace(content_view_jsp,"[|HASHMAP_VALUE|]",rp_hashmap_value   );
			content_view_jsp = StringUtil.replace(content_view_jsp,"[|PATI_TITLE|]",rp_pati_title      );
			content_view_jsp = StringUtil.replace(content_view_jsp,"[|HASHMAP_VALUE|]",rp_hashmap_value   );
			content_view_jsp = StringUtil.replace(content_view_jsp,"[|MODEL_NAME|]",rp_model_name      );
			content_view_jsp = StringUtil.replace(content_view_jsp,"[|PATI_CLASS_PATH_NAME|]",rp_pati_class_name );
			content_view_jsp = StringUtil.replace(content_view_jsp,"[|TABLE_NAME|]",rp_table_name      );
			content_view_jsp = StringUtil.replace(content_view_jsp,"[|KEY_NAME_LOWER|]",rp_key_name_lower  );
			content_view_jsp = StringUtil.replace(content_view_jsp,"[|KEY_NAME_UPPER|]",rp_key_name_upper  );
			content_view_jsp = StringUtil.replace(content_view_jsp,"[|PARTICLE_PACKAGE|]",rp_particle_package);
			content_view_jsp = StringUtil.replace(content_view_jsp,"[|MODEL_PACKAGE|]",rp_model_package   );
			content_view_jsp = StringUtil.replace(content_view_jsp,"[|PATI_MNG_NO|]",str   );

			if(!"Y".equals(pati_view_only)){
				content_model_class = StringUtil.replace(content_model_class,"[|HASHMAP_VALUE|]",rp_hashmap_value   );
				content_model_class = StringUtil.replace(content_model_class,"[|PATI_TITLE|]",rp_pati_title      );
				content_model_class = StringUtil.replace(content_model_class,"[|HASHMAP_VALUE|]",rp_hashmap_value   );
				content_model_class = StringUtil.replace(content_model_class,"[|MODEL_NAME|]",rp_model_name      );
				content_model_class = StringUtil.replace(content_model_class,"[|PATI_CLASS_PATH_NAME|]",rp_pati_class_name );
				content_model_class = StringUtil.replace(content_model_class,"[|TABLE_NAME|]",rp_table_name      );
				content_model_class = StringUtil.replace(content_model_class,"[|KEY_NAME_LOWER|]",rp_key_name_lower  );
				content_model_class = StringUtil.replace(content_model_class,"[|KEY_NAME_UPPER|]",rp_key_name_upper  );
				content_model_class = StringUtil.replace(content_model_class,"[|PARTICLE_PACKAGE|]",rp_particle_package);
				content_model_class = StringUtil.replace(content_model_class,"[|MODEL_PACKAGE|]",rp_model_package   );

				content_write_jsp = StringUtil.replace(content_write_jsp,"[|HASHMAP_VALUE|]",rp_hashmap_value   );
				content_write_jsp = StringUtil.replace(content_write_jsp,"[|PATI_TITLE|]",rp_pati_title      );
				content_write_jsp = StringUtil.replace(content_write_jsp,"[|HASHMAP_VALUE|]",rp_hashmap_value   );
				content_write_jsp = StringUtil.replace(content_write_jsp,"[|MODEL_NAME|]",rp_model_name      );
				content_write_jsp = StringUtil.replace(content_write_jsp,"[|PATI_CLASS_PATH_NAME|]",rp_pati_class_name );
				content_write_jsp = StringUtil.replace(content_write_jsp,"[|TABLE_NAME|]",rp_table_name      );
				content_write_jsp = StringUtil.replace(content_write_jsp,"[|KEY_NAME_LOWER|]",rp_key_name_lower  );
				content_write_jsp = StringUtil.replace(content_write_jsp,"[|KEY_NAME_UPPER|]",rp_key_name_upper  );
				content_write_jsp = StringUtil.replace(content_write_jsp,"[|PARTICLE_PACKAGE|]",rp_particle_package);
				content_write_jsp = StringUtil.replace(content_write_jsp,"[|MODEL_PACKAGE|]",rp_model_package   );
				content_write_jsp = StringUtil.replace(content_write_jsp,"[|PATI_MNG_NO|]",str   );
			}
			FileUtil.writeFile(new_paticle_class, content_particle_class);
			FileUtil.writeFile(new_pati_view_jsp, content_view_jsp);
			if(!"Y".equals(pati_view_only)){
				FileUtil.writeFile(new_pati_wrt_jsp, content_write_jsp);
			}
			ParticleMngDTO particleMngDTO = new ParticleMngDTO();
			particleMngDTO.setPatiSourceWrtYn("Y");
			particleMngDTO.setPatiUid(patiUid);
			cmmDAO.update(cmmDAO.getStmtByNS(NAMESPACE, "update"),  particleMngDTO);
		}

		return "";
	}

}
