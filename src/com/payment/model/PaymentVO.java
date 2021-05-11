package com.payment.model;

public class PaymentVO implements java.io.Serializable{
	
	private int pay_no;
	private int member_no;
	private String card_no;
	private String card_name;
	private String exp_mon;
	private String exp_year;
	private String csc;
	public int getPay_no() {
		return pay_no;
	}
	public void setPay_no(int pay_no) {
		this.pay_no = pay_no;
	}
	public int getMember_no() {
		return member_no;
	}
	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	public String getCard_no() {
		return card_no;
	}
	public void setCard_no(String card_no) {
		this.card_no = card_no;
	}
	public String getCard_name() {
		return card_name;
	}
	public void setCard_name(String card_name) {
		this.card_name = card_name;
	}
	public String getExp_mon() {
		return exp_mon;
	}
	public void setExp_mon(String exp_mon) {
		this.exp_mon = exp_mon;
	}
	public String getExp_year() {
		return exp_year;
	}
	public void setExp_year(String exp_year) {
		this.exp_year = exp_year;
	}
	public String getCsc() {
		return csc;
	}
	public void setCsc(String csc) {
		this.csc = csc;
	}

}
