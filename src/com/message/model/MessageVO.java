package com.message.model;
import java.sql.Date;
import java.sql.Timestamp;

public class MessageVO implements java.io.Serializable{
	private Integer message_no;
	private Integer from_member_no;
	private Integer to_member_no;
	private String message_content;
	private Timestamp message_time;
	
	public Integer getMessage_no() {
		return message_no;
	}
	public void setMessage_no(Integer message_no) {
		this.message_no = message_no;
	}
	public Integer getFrom_member_no() {
		return from_member_no;
	}
	public void setFrom_member_no(Integer from_member_no) {
		this.from_member_no = from_member_no;
	}
	public Integer getTo_member_no() {
		return to_member_no;
	}
	public void setTo_member_no(Integer to_member_no) {
		this.to_member_no = to_member_no;
	}
	public String getMessage_content() {
		return message_content;
	}
	public void setMessage_content(String message_content) {
		this.message_content = message_content;
	}
	public Timestamp getMessage_time() {
		return message_time;
	}
	public void setMessage_time(Timestamp message_time) {
		this.message_time = message_time;
	}
}
