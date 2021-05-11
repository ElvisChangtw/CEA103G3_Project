package com.ord_food.model;

import java.sql.Date;

public class Ord_foodVO implements java.io.Serializable{
	private Integer order_no;
	private Integer food_no;
	private Integer food_count;
	private Integer price;
	
	public Ord_foodVO() {
		super();
	}

	public Integer getOrder_no() {
		return order_no;
	}

	public void setOrder_no(Integer order_no) {
		this.order_no = order_no;
	}

	public Integer getFood_no() {
		return food_no;
	}

	public void setFood_no(Integer food_no) {
		this.food_no = food_no;
	}

	public Integer getFood_count() {
		return food_count;
	}

	public void setFood_count(Integer food_count) {
		this.food_count = food_count;
	}

	public Integer getPrice() {
		return price;
	}

	public void setPrice(Integer price) {
		this.price = price;
	}

	
	
}
