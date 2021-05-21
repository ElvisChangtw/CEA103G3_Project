package com.employee.model;

import java.util.List;

import com.employee.model.EmployeeVO;

public interface EmployeeDAO_interface {
	public void insert(EmployeeVO empVO);
    public void update(EmployeeVO empVO);
    public void delete(Integer empno);
    public EmployeeVO findByPrimaryKey(Integer empno);
    public List<EmployeeVO> getAll();
	public EmployeeVO login_check(String email, String emppwd);
	public void updateRandomPws(String email, String randomPwd);
}