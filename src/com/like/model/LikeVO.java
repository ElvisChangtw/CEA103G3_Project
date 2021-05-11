package com.like.model;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Timestamp;

public class LikeVO implements Serializable{
	private Integer articleno;
	private Integer memberno;
	
	public Integer getArticleno() {
		return articleno;
	}
	public void setArticleno(Integer articleno) {
		this.articleno = articleno;
	}
	public Integer getMemberno() {
		return memberno;
	}
	public void setMemberno(Integer memberno) {
		this.memberno = memberno;
	}
	
}
