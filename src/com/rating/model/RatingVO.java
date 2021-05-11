package com.rating.model;
import java.sql.Timestamp;

public class RatingVO implements java.io.Serializable{
	
	private Integer memberno;
	private Integer movieno;
	private Double rating;
	private Timestamp creatdate;
	private Timestamp modifydate;
	
	public Integer getMemberno() {
		return memberno;
	}
	public void setMemberno(Integer memberno) {
		this.memberno = memberno;
	}
	public Integer getMovieno() {
		return movieno;
	}
	public void setMovieno(Integer movieno) {
		this.movieno = movieno;
	}
	public Double getRating() {
		return rating;
	}
	public void setRating(Double rating) {
		this.rating = rating;
	}
	public Timestamp getCreatdate() {
		return creatdate;
	}
	public void setCreatdate(Timestamp creatdate) {
		this.creatdate = creatdate;
	}
	public Timestamp getModifydate() {
		return modifydate;
	}
	public void setModifydate(Timestamp modifydate) {
		this.modifydate = modifydate;
	}

}
