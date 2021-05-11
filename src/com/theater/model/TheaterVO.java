package com.theater.model;

public class TheaterVO implements java.io.Serializable{
	private Integer theater_no;
	private String theater_name;
	private String theater_type;
	private String seat_no;
	private String seat_name;
	
	public Integer getTheater_no() {
		return theater_no;
	}
	
	public TheaterVO() {
		super();
	}
	
	public void setTheater_no(Integer theater_no) {
		this.theater_no = theater_no;
	}
	public String getTheater_name() {
		return theater_name;
	}
	public void setTheater_name(String theater_name) {
		this.theater_name = theater_name;
	}
	public String getTheater_type() {
		return theater_type;
	}
	public void setTheater_type(String theater_type) {
		this.theater_type = theater_type;
	}
	public String getSeat_no() {
		return seat_no;
	}
	public void setSeat_no(String seat_no) {
		this.seat_no = seat_no;
	}
	public String getSeat_name() {
		return seat_name;
	}
	public void setSeat_name(String seat_name) {
		this.seat_name = seat_name;
	}
	
	
}
