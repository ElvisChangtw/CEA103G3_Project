package com.employee.model;

import java.sql.Date;

public class EmployeeVO implements java.io.Serializable {
	private Integer empno;
	private String empname;
	private String emppwd;
	private String gender;
	private String tel;
	private String email;
	private String title;
	private Date hiredate;
	private Date quitdate;
	private String status;
	
	
	public Integer getEmpno() {
		return empno;
	}
	public void setEmpno(Integer empno) {
		this.empno = empno;
	}
	public String getEmpname() {
		return empname;
	}
	public void setEmpname(String empname) {
		this.empname = empname;
	}
	public String getEmppwd() {
		return emppwd;
	}
	public void setEmppwd(String emppwd) {
		this.emppwd = emppwd;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Date getHiredate() {
		return hiredate;
	}
	public void setHiredate(Date hiredate) {
		this.hiredate = hiredate;
	}
	public Date getQuitdate() {
		return quitdate;
	}
	public void setQuitdate(Date quitdate) {
		this.quitdate = quitdate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	

}


