package com.authority.model;

public class AuthorityVO implements java.io.Serializable{
	
	private Integer empno;
	private Integer function_no;
	private String auth_status;
	
	public Integer getEmpno() {
		return empno;
	}
	public void setEmpno(Integer empno) {
		this.empno = empno;
	}
	public Integer getFunction_no() {
		return function_no;
	}
	public void setFunction_no(Integer function_no) {
		this.function_no = function_no;
	}
	public String getAuth_status() {
		return auth_status;
	}
	public void setAuth_status(String auth_status) {
		this.auth_status = auth_status;
	}
}
