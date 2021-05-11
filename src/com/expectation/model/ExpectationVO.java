package com.expectation.model;
import java.sql.Timestamp;

public class ExpectationVO implements java.io.Serializable{
	
	private Integer memberno;
	private Integer movieno;
	private Double expectation;
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
	public Double getExpectation() {
		return expectation;
	}
	public void setExpectation(Double expectation) {
		this.expectation = expectation;
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
