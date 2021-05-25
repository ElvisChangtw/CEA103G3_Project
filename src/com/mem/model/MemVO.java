package com.mem.model;

import java.sql.Date;

public class MemVO implements java.io.Serializable{
	private String action;
	private Integer member_no;
	private String mb_name;
	private String mb_email;
	private String mb_pwd;
	private String mb_phone;
	private String mb_city;
	private String mb_address;
	private String status;
	private Integer mb_point;
	private String mb_level;
	private Date crt_dt;
	private Date mb_bd;
	private byte[] mb_pic;
	private String mb_salt;
	public String getMb_salt() {
		return mb_salt;
	}
	public void setMb_salt(String mb_salt) {
		this.mb_salt = mb_salt;
	}
	public Date getCrt_dt() {
		return crt_dt;
	}

	public void setCrt_dt(Date crt_dt) {
		this.crt_dt = crt_dt;
	}

	public Date getMb_bd() {
		return mb_bd;
	}

	public void setMb_bd(Date mb_bd) {
		this.mb_bd = mb_bd;
	}

	public byte[] getMb_pic() {
		return mb_pic;
	}

	public void setMb_pic(byte[] mb_pic) {
		this.mb_pic = mb_pic;
	}
	
	public Integer getMember_no() {
		return member_no;
	}
	public void setMember_no(Integer member_no) {
		this.member_no = member_no;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Integer getMb_point() {
		return mb_point;
	}

	public void setMb_point(Integer mb_point) {
		this.mb_point = mb_point;
	}

	public String getMb_level() {
		return mb_level;
	}

	public void setMb_level(String mb_level) {
		this.mb_level = mb_level;
	}

	public MemVO () {};
	
	public String getMb_name() {
		return mb_name;
	}
	public void setMb_name(String mb_name) {
		this.mb_name = mb_name;
	}
	public String getMb_email() {
		return mb_email;
	}
	public void setMb_email(String mb_email) {
		this.mb_email = mb_email;
	}
	public String getMb_pwd() {
		return mb_pwd;
	}
	public void setMb_pwd(String mb_pwd) {
		this.mb_pwd = mb_pwd;
	}
	public String getMb_phone() {
		return mb_phone;
	}
	public void setMb_phone(String mb_phone) {
		this.mb_phone = mb_phone;
	}
	public String getMb_city() {
		return mb_city;
	}
	public void setMb_city(String mb_city) {
		this.mb_city = mb_city;
	}
	public String getMb_address() {
		return mb_address;
	}
	public void setMb_address(String mb_address) {
		this.mb_address = mb_address;
	}
	public String getAction() {
		return action;
	}
	public void setAction(String action) {
		this.action = action;
	}
	
	

}
