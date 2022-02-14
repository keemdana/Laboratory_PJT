package com.vertexid.commons.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.map.HashedMap;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;



public class ExcelUpload {

	/**
     * logger
	 * @throws Exception
     */

	public Map<String, Object> excelUpload(ParamMap<String, Object> options) {

		Map<String, Object> outParams = new HashMap<String, Object>();
		String fullPath 			= options.getString("fullPath");
		String startSheetIdxStr 	= options.getString("startSheetIdx");	//-- 시작 시트 인덱스
		String startHeaderIdxStr 	= options.getString("startHeaderIdx");	//-- 시작 헤더 인덱스
		String startColumnIdxStr 	= options.getString("startColumnIdx");	//-- 시작 column id 인덱스
		String startRowIdxStr 		= options.getString("startRowIdx");			//-- 시작 row 인덱스
		int startSheetIdx = StringUtil.isNumeric(startSheetIdxStr)?Integer.parseInt(startSheetIdxStr): 0;
		int startHeaderIdx = StringUtil.isNumeric(startHeaderIdxStr)?Integer.parseInt(startHeaderIdxStr): 0;
		int startColumnIdx = StringUtil.isNumeric(startColumnIdxStr)?Integer.parseInt(startColumnIdxStr): 1;
		int startRowIdx = StringUtil.isNumeric(startRowIdxStr)?Integer.parseInt(startRowIdxStr): 5;

		Logger log = LoggerFactory.getLogger(ExcelUpload.class);
		//파일가져오기
		InputStream is;
		try {
			is = new FileInputStream(new File(fullPath));
			//파일을 담을 Excel
			List<String> colNames =  new ArrayList<String>();
			List<String> colIds =  new ArrayList<String>();
			List<Object> colModel = new ArrayList<Object>();
			DataFormatter formatter = new DataFormatter();
			XSSFWorkbook workbook = null;
			try {
				workbook = new XSSFWorkbook(is);
			} catch (IOException e) {
				log.error(e.getMessage());
			}

			int rowIdx=0;
			int colIdx=0;
			XSSFSheet sheet= workbook.getSheetAt(startSheetIdx);
			//Row Cnt
			int rows=sheet.getPhysicalNumberOfRows();
			//Row 컬럼명
			XSSFRow colNmRow = sheet.getRow(startHeaderIdx);
			if(colNmRow !=null){
				//셀의 수
				int cells = colNmRow.getPhysicalNumberOfCells();

				for(colIdx=0;colIdx <= cells;colIdx++){
					XSSFCell cell = colNmRow.getCell(colIdx);
					String value="";
					if(cell==null){
						continue;
					}else{
						value= formatter.formatCellValue(cell)+"";

					}
					colNames.add(value);
				}
			}
			log.debug("컬럼 한글명 :"+colNames);

			//--컬럼 ID 추출
			XSSFRow colIdRow =sheet.getRow(startColumnIdx);
			if(colIdRow !=null){
				//셀의 수
				int cells=colIdRow.getPhysicalNumberOfCells();
				for(colIdx=0 ; colIdx <= cells ; colIdx++){
					Map<String, Object> colDr = new ParamMap<String, Object>();
					XSSFCell cell = colIdRow.getCell(colIdx);
					String value="";
					if(cell==null){
						continue;
					}else{
						value = formatter.formatCellValue(cell)+"";
					}
					colIds.add(value);
					colDr.put("name", value);
					colDr.put("editable", "true");
					colDr.put("align", "center");
					colModel.add(colDr);
				}
			}
			log.debug("컬럼 명문명 :"+colModel);

			outParams.put("colModel",colModel);
			outParams.put("colNames",colNames);

			List<Object> dt = new ArrayList<>();

			for(rowIdx=startRowIdx ; rowIdx < rows ; rowIdx++){
				//행을읽는다
				XSSFRow row=sheet.getRow(rowIdx);
				if(row !=null){
					//셀의 수
					int cells=row.getPhysicalNumberOfCells();
					boolean isRow = true;
					ParamMap<String, Object> dr = new ParamMap<String, Object>();
					for(colIdx=0;colIdx<=cells;colIdx++){
						//셀값을 읽는다
						XSSFCell cell=row.getCell(colIdx);
						String value="";
						//셀이 빈값일경우를 위한 널체크
						if(cell==null){
							continue;
						}else{
							value= cellValue(row.getCell(colIdx));
						}
						if(colIdx == 0 && StringUtil.isBlank(value)) {
							isRow = false;
							break;
						}
						dr.put(colIds.get(colIdx), value);
					}
					if(!dr.isEmpty()) {		//-- 뛰어 넘기 하지 않았을때만 add
						dt.add(dr);
					}
				}
			}
			log.debug("rowData : "+ dt);
			outParams.put("rowData", dt);
		} catch (FileNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}


		log.debug("outParams : "+ outParams);

		return outParams;
	}

	private String cellValue(XSSFCell cell) {
		Logger log = LoggerFactory.getLogger(ExcelUpload.class);
        String value = "";
        if (cell != null){
            switch (cell.getCellType()) { //cell 타입에 따른 데이타 저장
            case FORMULA:
                value = cell.getCellFormula();

                log.debug("Formula is " + cell.getCellFormula());
                switch(cell.getCachedFormulaResultType()) {
                    case NUMERIC:               	
                    	//value = cell.getNumericCellValue()+"";
                    	//log.debug("Last evaluated as: " + cell.getNumericCellValue());
                    	cell.setCellType(CellType.STRING );	//숫자가 지수포 표현될때 String으로 변환
                    	value = cell.getStringCellValue()+"";     
                    	log.debug("Last evaluated as \"" + cell.getRichStringCellValue() + "\"");
                        break;
                    case STRING:
                    	value = cell.getRichStringCellValue()+"";
                    	log.debug("Last evaluated as \"" + cell.getRichStringCellValue() + "\"");
                        break;
                }

                break;
            case  NUMERIC:
                if (DateUtil.isCellDateFormatted(cell)) {
                    //you should change this to your application date format
                    SimpleDateFormat objSimpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    value = "" + objSimpleDateFormat.format(cell.getDateCellValue());
                } else {
                    value = ("" + String.format("%.0f", new Double(cell.getNumericCellValue()))).replaceAll(",", "");;
                }
                break;
            case STRING:
                value = "" + cell.getStringCellValue();
                break;
            case BLANK:
                //value=""+cell.getBooleanCellValue();
                value = "";
                break;
            case ERROR:
                value = "" + cell.getErrorCellValue();
                break;
            default:
            }
        }

        return value.trim();
    }
}
