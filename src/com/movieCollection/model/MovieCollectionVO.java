package com.movieCollection.model;

import java.sql.Date;

public class MovieCollectionVO {
	
	private Integer movie_no;
	private Integer member_no;
	private Date crt_dt;
	public Integer getMovie_no() {
		return movie_no;
	}
	public void setMovie_no(Integer movie_no) {
		this.movie_no = movie_no;
	}
	public Integer getMember_no() {
		return member_no;
	}
	public void setMember_no(Integer member_no) {
		this.member_no = member_no;
	}
	public Date getCrt_dt() {
		return crt_dt;
	}
	public void setCrt_dt(Date crt_dt) {
		this.crt_dt = crt_dt;
	}
	
	
}
