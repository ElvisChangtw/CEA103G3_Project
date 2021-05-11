package com.movieRating.model;

import java.sql.Date;

public class MovieRatingVO {
	private Integer movie_no;
	private Integer member_no;
	private Float rating;
	private Date crt_dt;
	
	public Date getCrt_dt() {
		return crt_dt;
	}
	public void setCrt_dt(Date crt_dt) {
		this.crt_dt = crt_dt;
	}
	public Date getModify_dt() {
		return modify_dt;
	}
	public void setModify_dt(Date modify_dt) {
		this.modify_dt = modify_dt;
	}
	private Date modify_dt;
	
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
	public Float getRating() {
		return rating;
	}
	public void setRating(Float rating) {
		this.rating = rating;
	}
}
