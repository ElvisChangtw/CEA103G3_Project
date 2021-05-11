package com.movieExpect.model;

public class MovieExpectVO implements java.io.Serializable{
	
	private Integer movie_no;
	private Integer member_no;
	private String status;
	
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
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}

}
