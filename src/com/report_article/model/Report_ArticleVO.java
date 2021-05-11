package com.report_article.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class Report_ArticleVO implements Serializable{
	private Integer reportno;
	private Integer articleno;
	private String content;
	private Timestamp crtdt;
	private Integer memberno;
	private Timestamp executedt;
	private Integer status;
	private String desc;
	
	public Integer getReportno() {
		return reportno;
	}
	public void setReportno(Integer reportno) {
		this.reportno = reportno;
	}
	public Integer getArticleno() {
		return articleno;
	}
	public void setArticleno(Integer articleno) {
		this.articleno = articleno;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Timestamp getCrtdt() {
		return crtdt;
	}
	public void setCrtdt(Timestamp crtdt) {
		this.crtdt = crtdt;
	}
	public Integer getMemberno() {
		return memberno;
	}
	public void setMemberno(Integer memberno) {
		this.memberno = memberno;
	}
	public Timestamp getExecutedt() {
		return executedt;
	}
	public void setExecutedt(Timestamp executedt) {
		this.executedt = executedt;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	
}
