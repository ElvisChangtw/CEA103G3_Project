package com.function.model;

public class FunctionVO implements java.io.Serializable{
	
	private Integer function_no;
	private String function_desc;
	private String status;
	
	public Integer getFunction_no() {
		return function_no;
	}
	public void setFunction_no(Integer function_no) {
		this.function_no = function_no;
	}
	public String getFunction_desc() {
		return function_desc;
	}
	public void setFunction_desc(String function_desc) {
		this.function_desc = function_desc;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	
}
