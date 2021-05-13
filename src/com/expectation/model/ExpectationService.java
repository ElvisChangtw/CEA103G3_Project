package com.expectation.model;

import java.util.List;

import com.rating.model.RatingVO;

public class ExpectationService {

	private ExpectationDAO_interface dao;

	public ExpectationService() {
		dao = new ExpectationDAO();
	}

	public ExpectationVO addExpectation(Integer memberno, Integer movieno, Double expectation) {

		ExpectationVO expectationVO = new ExpectationVO();

		expectationVO.setMemberno(memberno);
		expectationVO.setMovieno(movieno);
		expectationVO.setExpectation(expectation);
				
		dao.insert(expectationVO);

		return expectationVO;
	}

	public ExpectationVO updateExpectation(Integer memberno, Integer movieno , Double expectation) {

		ExpectationVO expectationVO = new ExpectationVO();

		expectationVO.setMemberno(memberno);
		expectationVO.setMovieno(movieno);
		expectationVO.setExpectation(expectation);
		
		dao.update(expectationVO);

		return expectationVO;
	}

	public void deleteExpectation(Integer memberno,Integer movieno) {
		dao.delete(memberno,movieno);
	}
	
	public ExpectationVO getOneExpectation(Integer memberno, Integer movieno) {
		return dao.findByPrimaryKey(memberno,movieno);
	}

	public List<ExpectationVO> findByMovieNo(Integer movieno) {
		return dao.findByMovieNo(movieno);
	}

	public List<ExpectationVO> getAllByMovieNo() {
		return dao.getAllByMovieNo();
	}
	
	public ExpectationVO insertOrUpdateExpectationAndUpdateMovieExpectation (Integer memberno, Integer movieno, Double expectation) {
		
		ExpectationVO expectationVO = new ExpectationVO();
		
		expectationVO.setMemberno(memberno);
		expectationVO.setMovieno(movieno);
		expectationVO.setExpectation(expectation);	
		
		dao.insertOrUpdateExpectationAndUpdateMovieExpectation(expectationVO);

		return expectationVO;
	}
	
	public ExpectationVO getThisMovieToatalExpectation(Integer movieno) {
		return dao.getThisMovieToatalExpectation(movieno);
	}
	

}
