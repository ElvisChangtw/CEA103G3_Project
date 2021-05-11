package com.ticket_type.model;

import java.sql.Date;

public class Ticket_typeVO implements java.io.Serializable {
	private Integer ticket_type_no;
	private String ticket_type;
	private Integer ticket_price;
	private String ticket_desc;

	public Ticket_typeVO() {
		super();
	}

	public String getTicket_type() {
		return ticket_type;
	}

	public void setTicket_type(String ticket_type) {
		this.ticket_type = ticket_type;
	}

	public Integer getTicket_price() {
		return ticket_price;
	}

	public void setTicket_price(Integer ticket_price) {
		this.ticket_price = ticket_price;
	}

	public String getTicket_desc() {
		return ticket_desc;
	}

	public void setTicket_desc(String ticket_desc) {
		this.ticket_desc = ticket_desc;
	}

	public Integer getTicket_type_no() {
		return ticket_type_no;
	}

	public void setTicket_type_no(Integer ticket_type_no) {
		this.ticket_type_no = ticket_type_no;
	}
}
