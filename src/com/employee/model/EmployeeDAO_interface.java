package com.employee.model;

import java.util.List;

import com.employee.model.EmployeeVO;

public interface EmployeeDAO_interface {
	public void insert(EmployeeVO empVO);
    public void update(EmployeeVO empVO);
    public void delete(Integer empno);
    public EmployeeVO findByPrimaryKey(Integer empno);
    public List<EmployeeVO> getAll();
    //萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<EmployeeVO> getAll(Map<String, String[]> map); 
}