package com.order.model;

import java.sql.Date;
import java.sql.Timestamp;

public class OrderVO implements java.io.Serializable{
	private Integer order_no;
	private Integer member_no;
	private Integer showtime_no;
	private Timestamp crt_dt;
	private String order_status;
	private String order_type;
	private String payment_type;
	private Integer total_price;
	private String seat_name;

	public OrderVO() {
		super();
	}

	public Integer getOrder_no() {
		return order_no;
	}

	public void setOrder_no(Integer order_no) {
		this.order_no = order_no;
	}

	public Integer getMember_no() {
		return member_no;
	}

	public void setMember_no(Integer member_no) {
		this.member_no = member_no;
	}

	public Integer getShowtime_no() {
		return showtime_no;
	}

	public void setShowtime_no(Integer showtime_no) {
		this.showtime_no = showtime_no;
	}

	public Timestamp getCrt_dt() {
		return crt_dt;
	}

	public void setCrt_dt(Timestamp crt_dt) {
		this.crt_dt = crt_dt;
	}

	public String getOrder_status() {
		return order_status;
	}

	public void setOrder_status(String order_status) {
		this.order_status = order_status;
	}

	public String getOrder_type() {
		return order_type;
	}

	public void setOrder_type(String order_type) {
		this.order_type = order_type;
	}

	public String getPayment_type() {
		return payment_type;
	}

	public void setPayment_type(String payment_type) {
		this.payment_type = payment_type;
	}

	public Integer getTotal_price() {
		return total_price;
	}

	public void setTotal_price(Integer total_price) {
		this.total_price = total_price;
	}
	
	public String getSeat_name() {
		return seat_name;
	}

	public void setSeat_name(String seat_name) {
		this.seat_name = seat_name;
	}
	
}
