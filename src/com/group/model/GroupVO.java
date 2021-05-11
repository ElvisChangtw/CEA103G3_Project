package com.group.model;
import java.sql.Date;
import java.sql.Timestamp;

public class GroupVO implements java.io.Serializable{
	private Integer group_no;
	private Integer showtime_no;
	private Integer member_no;
	private String group_title;
	private Integer required_cnt;
	private Integer member_cnt;
	private String group_status;
	private String desc;
	private Timestamp crt_dt;
	private Timestamp modify_dt;
	private Timestamp deadline_dt;
	public Integer getGroup_no() {
		return group_no;
	}
	public void setGroup_no(Integer group_no) {
		this.group_no = group_no;
	}
	public Integer getShowtime_no() {
		return showtime_no;
	}
	public void setShowtime_no(Integer showtime_no) {
		this.showtime_no = showtime_no;
	}
	public Integer getMember_no() {
		return member_no;
	}
	public void setMember_no(Integer member_no) {
		this.member_no = member_no;
	}
	public Integer getRequired_cnt() {
		return required_cnt;
	}
	public void setRequired_cnt(Integer required_cnt) {
		this.required_cnt = required_cnt;
	}
	public Integer getMember_cnt() {
		return member_cnt;
	}
	public void setMember_cnt(Integer member_cnt) {
		this.member_cnt = member_cnt;
	}
	public String getGroup_status() {
		return group_status;
	}
	public void setGroup_status(String group_status) {
		this.group_status = group_status;
	}
	public Timestamp getCrt_dt() {
		return crt_dt;
	}
	public void setCrt_dt(Timestamp crt_dt) {
		this.crt_dt = crt_dt;
	}
	public Timestamp getModify_dt() {
		return modify_dt;
	}
	public void setModify_dt(Timestamp modify_dt) {
		this.modify_dt = modify_dt;
	}
	public Timestamp getDeadline_dt() {
		return deadline_dt;
	}
	public void setDeadline_dt(Timestamp deadline_dt) {
		this.deadline_dt = deadline_dt;
	}
	public String getGroup_title() {
		return group_title;
	}
	public void setGroup_title(String group_title) {
		this.group_title = group_title;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
}
