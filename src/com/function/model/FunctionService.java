package com.function.model;

import java.util.List;

public class FunctionService {
	
	private FunctionDAO_interface dao;

	public FunctionService() {
		dao = new FunctionDAO();
	}

	public FunctionVO addFunction(String function_desc, String status) {
		FunctionVO functionVO = new FunctionVO();
		functionVO.setFunction_desc(function_desc);
		functionVO.setStatus(status);
		dao.insert(functionVO);

		return functionVO;
	}

	public FunctionVO updateFunction(Integer function_no, String function_desc, String status) {

		FunctionVO functionVO = new FunctionVO();

		functionVO.setFunction_no(function_no);
		functionVO.setFunction_desc(function_desc);
		functionVO.setStatus(status);
		
		dao.update(functionVO);

		return functionVO;
	}

	public void deleteFunction(Integer function_no) {
		dao.delete(function_no);
	}

	public FunctionVO getOneFunction(Integer function_no) {
		return dao.findByPrimaryKey(function_no);
	}

	public List<FunctionVO> getAll() {
		return dao.getAll();
	}

}
