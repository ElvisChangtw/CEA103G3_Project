package com.employee.model;

import java.util.List;
import java.util.Set;

import com.authority.model.AuthorityVO;

public class EmployeeService {
	
	private EmployeeDAO_interface dao;

	public EmployeeService() {
		dao = new EmployeeDAO();
	}
	
	public EmployeeVO addEmp(String empname,String emppwd,
			String gender, String tel, String email, String title, java.sql.Date hiredate, java.sql.Date quitdate, String status) {

		EmployeeVO employeeVO = new EmployeeVO();

		employeeVO.setEmpname(empname);
		employeeVO.setEmppwd(emppwd);
		employeeVO.setGender(gender);
		employeeVO.setTel(tel);
		employeeVO.setEmail(email);
		employeeVO.setTitle(title);
		employeeVO.setHiredate(hiredate);
		employeeVO.setQuitdate(quitdate);
		employeeVO.setStatus(status);
		dao.insert(employeeVO);

		return employeeVO;
	}

	public EmployeeVO updateEmp(Integer empno, String empname,String emppwd, String gender, String tel, String email, String title, java.sql.Date hiredate, java.sql.Date quitdate, String status) {

		EmployeeVO employeeVO = new EmployeeVO();

		
		employeeVO.setEmpno(empno);
		employeeVO.setEmpname(empname);
		employeeVO.setEmppwd(emppwd);
		employeeVO.setGender(gender);
		employeeVO.setTel(tel);
		employeeVO.setEmail(email);
		employeeVO.setTitle(title);
		employeeVO.setHiredate(hiredate);
		employeeVO.setQuitdate(quitdate);
		employeeVO.setStatus(status);
		dao.update(employeeVO);

		return employeeVO;
	}

	public void deleteEmp(Integer empno) {
		dao.delete(empno);
	}

	public EmployeeVO getOneEmp(Integer empno) {
		return dao.findByPrimaryKey(empno);
	}

	public List<EmployeeVO> getAll() {
		return dao.getAll();
	}

	public EmployeeVO loginCheck(String email, String emppwd) {
		return dao.login_check(email, emppwd);
	}

	public void updateRandomPws(String email, String randomPwd) {
		dao.updateRandomPws(email, randomPwd);
	}

	public Set<AuthorityVO> getAuthsByEmpno(Integer empno) {
		return dao.getAuthsByEmpno(empno);
	}
} 
