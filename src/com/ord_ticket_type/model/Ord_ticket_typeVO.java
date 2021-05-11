package com.ord_ticket_type.model;

import java.sql.Date;

public class Ord_ticket_typeVO implements java.io.Serializable{
	private Integer ticket_type_no;
	private Integer order_no;
	private Integer ticket_count;
	private Integer price;
	
	public Ord_ticket_typeVO() {
		super();
	}

	public Integer getTicket_type_no() {
		return ticket_type_no;
	}

	public void setTicket_type_no(Integer ticket_type_no) {
		this.ticket_type_no = ticket_type_no;
	}

	public Integer getOrder_no() {
		return order_no;
	}

	public void setOrder_no(Integer order_no) {
		this.order_no = order_no;
	}

	public Integer getTicket_count() {
		return ticket_count;
	}

	public void setTicket_count(Integer ticket_count) {
		this.ticket_count = ticket_count;
	}

	public Integer getPrice() {
		return price;
	}

	public void setPrice(Integer price) {
		this.price = price;
	}
	
}
