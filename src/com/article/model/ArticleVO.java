package com.article.model;

import java.io.Serializable;
import java.sql.Timestamp;


public class ArticleVO implements Serializable{
	private Integer articleno;
	private Integer memberno;
	private String articletype;
	private String content;
	private String articleheadline;
	private Timestamp crtdt;
	private Timestamp updatedt;
	private Integer status;
	private Integer likecount;
	
	public Integer getArticleno() {
		return articleno;
	}
	public void setArticleno(Integer articleno) {
		this.articleno = articleno;
	}
	public Integer getMemberno() {
		return memberno;
	}
	public void setMemberno(Integer memverno) {
		this.memberno = memverno;
	}
	public String getArticletype() {
		return articletype;
	}
	public void setArticletype(String articletype) {
		this.articletype = articletype;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getArticleheadline() {
		return articleheadline;
	}
	public void setArticleheadline(String articleheadline) {
		this.articleheadline = articleheadline;
	}
	public Timestamp getCrtdt() {
		return crtdt;
	}
	public void setCrtdt(Timestamp crtdt) {
		this.crtdt = crtdt;
	}
	public Timestamp getUpdatedt() {
		return updatedt;
	}
	public void setUpdatedt(Timestamp updatedt) {
		this.updatedt = updatedt;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Integer getLikecount() {
		return likecount;
	}
	public void setLikecount(Integer likecount) {
		this.likecount = likecount;
	}
	
}
