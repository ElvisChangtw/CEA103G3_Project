package com.showtime.model;

import java.sql.Timestamp;

public class ShowtimeVO implements java.io.Serializable{
	private Integer showtime_no;
	private Integer movie_no;
	private Integer theater_no;
	private String seat_no;
	private Timestamp showtime_time;
	
	public Timestamp getShowtime_time() {
		return showtime_time;
	}

	public void setShowtime_time(Timestamp showtime_time) {
		this.showtime_time = showtime_time;
	}

	public Integer getShowtime_no() {
		return showtime_no;
	}

	public void setShowtime_no(Integer showtime_no) {
		this.showtime_no = showtime_no;
	}

	public Integer getMovie_no() {
		return movie_no;
	}

	public void setMovie_no(Integer movie_no) {
		this.movie_no = movie_no;
	}

	public Integer getTheater_no() {
		return theater_no;
	}

	public void setTheater_no(Integer theater_no) {
		this.theater_no = theater_no;
	}

	public String getSeat_no() {
		return seat_no;
	}

	public void setSeat_no(String seat_no) {
		this.seat_no = seat_no;
	}

	public ShowtimeVO() {
		super();
	}
	
	
	
	
}
