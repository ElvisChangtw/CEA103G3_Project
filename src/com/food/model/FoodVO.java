package com.food.model;

import java.sql.Date;

public class FoodVO implements java.io.Serializable{
	private Integer food_no;
	private String food_name;
	private String food_type;
	private Integer food_price;
	private byte[] food_pic;
	private String food_status;
	
	public FoodVO() {
		super();
	}

	public Integer getFood_no() {
		return food_no;
	}

	public void setFood_no(Integer food_no) {
		this.food_no = food_no;
	}

	public String getFood_name() {
		return food_name;
	}

	public void setFood_name(String food_name) {
		this.food_name = food_name;
	}

	public Integer getFood_price() {
		return food_price;
	}

	public void setFood_price(Integer food_price) {
		this.food_price = food_price;
	}

	public byte[] getFood_pic() {
		return food_pic;
	}

	public void setFood_pic(byte[] food_pic) {
		this.food_pic = food_pic;
	}

	public String getFood_status() {
		return food_status;
	}

	public void setFood_status(String food_status) {
		this.food_status = food_status;
	}
	
	public String getFood_type() {
		return food_type;
	}

	public void setFood_type(String food_type) {
		this.food_type = food_type;
	}
	
}
