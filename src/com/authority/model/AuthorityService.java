package com.authority.model;

import java.util.List;

public class AuthorityService {
	
	private AuthorityDAO_interface dao;

	public AuthorityService() {
		dao = new AuthorityDAO();
	}

	public AuthorityVO addAuthority(Integer empno, Integer function_no, String auth_status) {

		AuthorityVO authorityVO = new AuthorityVO();

		authorityVO.setEmpno(empno);
		authorityVO.setFunction_no(function_no);
		authorityVO.setAuth_status(auth_status);
				
		dao.insert(authorityVO);

		return authorityVO;
	}

	public AuthorityVO updateAuthority(Integer empno, Integer function_no, String auth_status) {

		AuthorityVO authorityVO = new AuthorityVO();

		authorityVO.setEmpno(empno);
		authorityVO.setFunction_no(function_no);
		authorityVO.setAuth_status(auth_status);
		
		dao.update(authorityVO);

		return authorityVO;
	}

	public void deleteAuthority(Integer empno,Integer function_no) {
		dao.delete(empno,function_no);
	}

	public List<AuthorityVO> getOneAuthorityByEmpNo(Integer empno) {
		return dao.findByEmpNo(empno);
	}
	
	public AuthorityVO getOneAuthorityByEmpNo_Function_no(Integer empno, Integer function_no) {
		return dao.findByEmpNo_FunctionNo(empno, function_no);
	}

	public List<AuthorityVO> getAll() {
		return dao.getAllByEmpNo();
	}

}
