package com.vertexid.voc;

public class vocSulbiVo {

	private String line;			//LINE
	private String prod;			//제품유형
	private String process;			//공정
	private int seq;				//선택순서(행)s
	private String vocNo;			//VOC번호
	private String vocPjtNo;		//프로젝트
	private String creDate;
	private String creUser;
	
	public String getLine() {
		return line;
	}
	public void setLine(String line) {
		this.line = line;
	}
	public String getProd() {
		return prod;
	}
	public void setProd(String prod) {
		this.prod = prod;
	}
	public String getProcess() {
		return process;
	}
	public void setProcess(String process) {
		this.process = process;
	}	
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getVocNo() {
		return vocNo;
	}
	public void setVocNo(String vocNo) {
		this.vocNo = vocNo;
	}	
	public String getVocPjtNo() {
		return vocPjtNo;
	}
	public void setVocPjtNo(String vocPjtNo) {
		this.vocPjtNo = vocPjtNo;
	}
	public String getCreDate() {
		return creDate;
	}
	public void setCreDate(String creDate) {
		this.creDate = creDate;
	}
	public String getCreUser() {
		return creUser;
	}
	public void setCreUser(String creUser) {
		this.creUser = creUser;
	}
	
	
	
}
