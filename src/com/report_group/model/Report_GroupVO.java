package com.report_group.model;
import java.sql.Date;
import java.sql.Timestamp;

public class Report_GroupVO implements java.io.Serializable{
	private Integer report_no;
	private Integer group_no;
	private String content;
	private Timestamp crt_dt;
	private Integer member_no;
	private Timestamp execute_dt;
	private String status;
	private String desc;
	public Integer getReport_no() {
		return report_no;
	}
	public void setReport_no(Integer report_no) {
		this.report_no = report_no;
	}
	public Integer getGroup_no() {
		return group_no;
	}
	public void setGroup_no(Integer group_no) {
		this.group_no = group_no;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Timestamp getCrt_dt() {
		return crt_dt;
	}
	public void setCrt_dt(Timestamp crt_dt) {
		this.crt_dt = crt_dt;
	}
	public Integer getMember_no() {
		return member_no;
	}
	public void setMember_no(Integer member_no) {
		this.member_no = member_no;
	}
	public Timestamp getExecute_dt() {
		return execute_dt;
	}
	public void setExecute_dt(Timestamp execute_dt) {
		this.execute_dt = execute_dt;
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
