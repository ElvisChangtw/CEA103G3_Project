package com.reply.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class ReplyVO implements Serializable{
	private Integer reply_no;
	private Integer article_no;
	private Integer member_no;
	private String content;
	private Timestamp crt_dt;
	private Timestamp modify_dt;
	private Integer status;
	
	public Integer getReply_no() {
		return reply_no;
	}
	public void setReply_no(Integer replyno) {
		this.reply_no = replyno;
	}
	public Integer getArticle_no() {
		return article_no;
	}
	public void setArticle_no(Integer articleno) {
		this.article_no = articleno;
	}
	public Integer getMember_no() {
		return member_no;
	}
	public void setMember_no(Integer memberno) {
		this.member_no = memberno;
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
	public void setCrt_dt(Timestamp crtdt) {
		this.crt_dt = crtdt;
	}
	public Timestamp getModify_dt() {
		return modify_dt;
	}
	public void setModify_dt(Timestamp modifydt) {
		this.modify_dt = modifydt;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	
}
