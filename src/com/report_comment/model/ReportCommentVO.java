package com.report_comment.model;
import java.sql.Timestamp;

public class ReportCommentVO implements java.io.Serializable{
	
	private Integer reportno;
	private Integer commentno;
	private String content;
	private Timestamp creatdate;
	private Integer memberno;
	private Timestamp executedate;
	private String status;
	private String desc;
	
	public Integer getReportno() {
		return reportno;
	}
	public void setReportno(Integer reportno) {
		this.reportno = reportno;
	}
	public Integer getCommentno() {
		return commentno;
	}
	public void setCommentno(Integer commentno) {
		this.commentno = commentno;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Timestamp getCreatdate() {
		return creatdate;
	}
	public void setCreatdate(Timestamp creatdate) {
		this.creatdate = creatdate;
	}
	public Integer getMemberno() {
		return memberno;
	}
	public void setMemberno(Integer memberno) {
		this.memberno = memberno;
	}
	public Timestamp getExecutedate() {
		return executedate;
	}
	public void setExecutedate(Timestamp executedate) {
		this.executedate = executedate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}

}
