package com.vertexid.laboratory.rndfab;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.vertexid.commons.utils.ParamMap;
import com.vertexid.viself.base.BaseCtrl;
import com.vertexid.viself.base.CmmDAO;

@Service
@Transactional
public class labRndfabSvc extends BaseCtrl {
	private static final String LAB_RNDFAB = "com.vertexid.laboratory.rndfab.rndfabSql";

	@Resource(name="cmmDAO")
	private CmmDAO cmmDAO;
	

	//연구설비 가동현황 main
	public String getMainStatusChart(Map<String, Object> params){
		params.put("runstat", getArray(params));
		
		ArrayList chartGridList = (ArrayList) cmmDAO.getList(cmmDAO.getStmtByNS(LAB_RNDFAB, "chartGridList"), params);
		ArrayList chartSearchDateList = (ArrayList) cmmDAO.getList(cmmDAO.getStmtByNS(LAB_RNDFAB, "chartSearchDateList"), params);
		ArrayList chartSearchDateList2 = (ArrayList) cmmDAO.getList(cmmDAO.getStmtByNS(LAB_RNDFAB, "chartSearchDateList2"), params);
		ArrayList chartStatusList = (ArrayList) cmmDAO.getList(cmmDAO.getStmtByNS(LAB_RNDFAB, "chartStatusList"), params);
		
		// chartStatusList > arrData
		// chartSearchDateList2 > arrData1
		// chartSearchDateList > arrData2
		// chartGridList > arrData3

		Map test =  (Map)chartGridList.get(0);
		String tttt = "";
		tttt = test.get("eqCd").toString();
		
		
		
        StringBuilder xmlData = new StringBuilder();
        StringBuilder categories = new StringBuilder();
        StringBuilder processes = new StringBuilder();
        StringBuilder datatable = new StringBuilder();
        StringBuilder datacolumn = new StringBuilder();
        StringBuilder tasks = new StringBuilder();
        StringBuilder legend = new StringBuilder();
        StringBuilder trendlines = new StringBuilder();
        
        Map chartSearchDateListMap = (Map)chartSearchDateList.get(0);
        String scrollToDate = chartSearchDateListMap.get("endToday").toString();
        
        
		xmlData.append("<chart caption='연구설비 가동 현황' captionfontsize='26' captionfontcolor='#000000' isbold='1' ganttPaneDuration='25' "
				+ "ganttPaneDurationUnit='h' dateFormat='yyyy-mm-dd HH:MM' outputDateFormat='yyyy-mm-dd hh:mn' scrollShowButtons= '1' flatscrollbars='0' ganttWidthPercent='82' "
				+ "theme='fusion' baseFontSize='16' scrollToDate='"+scrollToDate+"'>");
		
		categories.append("<categories  fontSize='18' fontcolor='#000000' >");
		
		for(int i=0; i<chartSearchDateList.size(); i++) {
			Map arrData2 = (Map)chartSearchDateList.get(i);
			
			String start = arrData2.get("stDt").toString();
			String end = arrData2.get("endDt").toString();
			String label = arrData2.get("dateNm").toString();
			String bgcolor = arrData2.get("bgcolor").toString();
			
			categories.append("<category start='"+start+"' end='"+end+"' label='"+label+"' bgcolor='"+bgcolor+"' hoverbandcolor='#FFC19E' />");
		}
		
		categories.append("</categories>");
		categories.append("<categories  fontSize='12' fontcolor='#000000' >");
		
		for(int i=0; i<chartSearchDateList2.size(); i++) {
			Map arrData1 = (Map)chartSearchDateList2.get(i);

			String start = arrData1.get("yyyymmdd").toString();
			String end = arrData1.get("yyyymmddd").toString();
			String label = arrData1.get("hhss").toString();
			String bgcolor = arrData1.get("bgcolor").toString();
			
			categories.append("<category start='"+start+"' end='"+end+"' label='"+label+"' bgcolor='"+bgcolor+"' hoverbandcolor='#FFC19E' />");
		}
		
		processes.append("<processes headerText='NO' isbold='0' isanimated='1' headerFontSize='18' fontSize='14' fontcolor='#000000' headerfontcolor='#000000' headerbgcolor='#FFFFFF' bgcolor='#EAEAEA' > ");
        
		for(int i=0; i<chartGridList.size(); i++) {
			Map arrData3 = (Map)chartGridList.get(i);
			
			String label = arrData3.get("no").toString();
			String id = arrData3.get("eqPm").toString();
			
			processes.append("<process label='"+label+"' id='"+id+"' />");
		}
		
		datacolumn.append("<datacolumn headertext='연구설비' isbold='0' isanimated='1' headerFontSize='18' fontSize='14' width='100' fontcolor='#000000' headerfontcolor='#000000' headerbgcolor='#FFFFFF' bgcolor='#EAEAEA' >");
		
		for(int i=0; i<chartGridList.size(); i++) {
			//, arrData3[i, 2], arrData3[i, 4], arrData3[i, 2]
			Map arrData3 = (Map)chartGridList.get(i);
			
			String label = arrData3.get("eqPm").toString();
			String tooltext = arrData3.get("ip").toString();
			String eqpm = arrData3.get("eqPm").toString();
			
			// 상세보기>시간단위
			datacolumn.append("<text label='"+label+"' tooltext='"+tooltext+"' hoverbandcolor='#FFC19E' link='n-http://tomms.ips.co.kr/rndfab/Status_Sub_hourly.aspx?eq_pm="+eqpm+"'/>");
		}
		
		datacolumn.append("</datacolumn>");
		datacolumn.append("<datacolumn headertext='담당부서' isbold='0' isanimated='1' headerFontSize='18' fontSize='14' width='100' fontcolor='#000000' headerfontcolor='#000000' headerbgcolor='#FFFFFF' bgcolor='#EAEAEA' >");
		
		

		for(int i=0; i<chartGridList.size(); i++) {
			Map arrData3 = (Map)chartGridList.get(i);
			
			String label = arrData3.get("partNm").toString();
			String tooltext = arrData3.get("dscpt").toString();
			
			datacolumn.append("<text label='"+label+"' tooltext='"+tooltext+"' hoverbandcolor='#FFC19E'/>");
		}
		
		datacolumn.append("</datacolumn>");
		
		
		// 막대그래프 차트 실제 데이터
		tasks.append("<tasks showEndDate='0' fontSize='10' fontcolor='#000000'>");

		
		for(int i=0; i<chartStatusList.size(); i++) {
			Map arrData = (Map)chartStatusList.get(i);
			
			String processId = arrData.get("eqPm").toString();
			String start = arrData.get("eqsDate").toString();
			String end = arrData.get("eqeDate").toString();
			String color = arrData.get("color").toString();
			String tooltext = arrData.get("toolTip").toString();
			String eqpm = arrData.get("eqPm").toString();
			String eqcd = arrData.get("eqCd").toString();
			String pmnum = arrData.get("pmNum").toString();
			
			tasks.append("<task processId='"+processId+"' start='"+start+"' end='"+end+"' id='' color='"+color+"' tooltext='"+tooltext+"' height='60%' topPadding='20%' link='n-http://tomms.ips.co.kr/rndfab/Status_Sub_hourly.aspx?eq_pm="+eqpm+"&eqcd="+eqcd+"&pmnum="+pmnum+"' />");
		}
		

//        legend.append("<legend><item label='NotUse(0)' color='#000000'/><item label='DisConnect(1)' color='#BDBDBD' /><item label='ATM(2)' color='#1DDB16' /><item label='Vacuum(3)' color='#00D8FF' /><item label='MaintRCP(4)' color='#FF00DD' /><item label='StanbyRCP(5)' color='#5F00FF' /><item label='Process(6)' color='#FF0000' /><item label='Clean(7)' color='#FFBB00' />");
        legend.append("<legend><item label='NotUse(0)' color='#000000'/><item label='DisConnect(1)' color='#BDBDBD' /><item label='ATM(2)' color='#82DE7E' /><item label='Vacuum(3)' color='#87EDFF' /><item label='MaintRCP(4)' color='#FF80EE' /><item label='StanbyRCP(5)' color='##A46EFF' /><item label='Process(6)' color='#FF7070' /><item label='Clean(7)' color='#FFD86B' />");


        trendlines.append("<trendlines>");
        
        String start = chartSearchDateListMap.get("stToday").toString();
        String end = chartSearchDateListMap.get("endToday").toString();
        String displayValue = chartSearchDateListMap.get("todayNow").toString();

        trendlines.append("<line start='{0}' end='{1}' displayValue='{2}'  isTrendZone='1' alpha='70' color='#0100FF' dashed='1' />");

        categories.append("</categories>");
        processes.append("</processes>");
        tasks.append("</tasks>");
        legend.append("</legend>");
        trendlines.append("</trendlines>");

        xmlData.append(categories.toString());
        xmlData.append(processes.toString());
        xmlData.append("<datatable>");
        xmlData.append(datacolumn.toString());
        xmlData.append("</datatable>");
        xmlData.append(tasks.toString());
        xmlData.append(legend.toString());
        
        // 목표선
        //xmlData.append("<trendlines><line start='2017-08-05' end='2017-08-06' displayValue='TODAY' isTrendZone='1' alpha='70' color='FF5904'/></trendlines>");
        xmlData.append(trendlines.toString());
        xmlData.append("<styles><definition><style type='font' name='legendFont' size='25' /></definition> <application> <apply toObject='Legend' styles='legendFont' /></application></styles> ");
        xmlData.append("</chart>");
        
        params.put("xmlData", xmlData);
		
		return xmlData.toString();	
	} 
	
	//연구설비 가동현황 > 실제 가동현황 데이터 (arrData3)
	public List<ParamMap<String, Object>> getArray(Map<String, Object> params){
		ObjectMapper objectMapper = new ObjectMapper();
		List arrayList = new ArrayList();
		String val = (String) params.get("runstat");
		val = val.replace("\\", "");
		try {
			arrayList = objectMapper.readValue(val, List.class);
		} catch (JsonMappingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return arrayList;
	} 
	
}
