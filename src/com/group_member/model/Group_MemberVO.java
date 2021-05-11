package com.group_member.model;
import java.sql.Timestamp;

public class Group_MemberVO implements java.io.Serializable{
	private Integer group_no;
	private Integer member_no;
	private String pay_status;
	private Timestamp crt_dt;
	private String status;
	public Integer getGroup_no() {
		return group_no;
	}
	public void setGroup_no(Integer group_no) {
		this.group_no = group_no;
	}
	public Integer getMember_no() {
		return member_no;
	}
	public void setMember_no(Integer member_no) {
		this.member_no = member_no;
	}
	public String getPay_status() {
		return pay_status;
	}
	public void setPay_status(String pay_status) {
		this.pay_status = pay_status;
	}
	public Timestamp getCrt_dt() {
		return crt_dt;
	}
	public void setCrt_dt(Timestamp crt_dt) {
		this.crt_dt = crt_dt;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}	
	
}
