package com.news.model;

import java.sql.Date;

public class NewsVO implements java.io.Serializable {
	private Integer news_no;
	private Integer empno;
	private String news_title;
	private String news_desc;
	private String status;
	private Date publish_date;
	
	public Integer getNews_no() {
		return news_no;
	}
	public void setNews_no(Integer news_no) {
		this.news_no = news_no;
	}
	public Integer getEmpno() {
		return empno;
	}
	public void setEmpno(Integer empno) {
		this.empno = empno;
	}
	public String getNews_title() {
		return news_title;
	}
	public void setNews_title(String news_title) {
		this.news_title = news_title;
	}
	public String getNews_desc() {
		return news_desc;
	}
	public void setNews_desc(String news_desc) {
		this.news_desc = news_desc;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Date getPublish_date() {
		return publish_date;
	}
	public void setPublish_date(Date publish_date) {
		this.publish_date = publish_date;
	}
}


