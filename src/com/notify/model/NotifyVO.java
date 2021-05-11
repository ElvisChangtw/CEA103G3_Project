package com.notify.model;

import java.sql.Date;

public class NotifyVO {
	
	private int notification_no;
	
	private int member_no;
	
	private String content;
	
	private Date notification_time;

	public int getNotification_no() {
		return notification_no;
	}

	public void setNotification_no(int notification_no) {
		this.notification_no = notification_no;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getNotification_time() {
		return notification_time;
	}

	public void setNotification_time(Date notification_time) {
		this.notification_time = notification_time;
	}
	
	

}
