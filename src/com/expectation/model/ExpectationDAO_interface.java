package com.expectation.model;

import java.util.*;

import com.rating.model.RatingVO;

public interface ExpectationDAO_interface {
	
	public void insert(ExpectationVO expectationVO);
    public void update(ExpectationVO expectationVO);
    public void delete(Integer memberno , Integer movieno);
    public ExpectationVO findByPrimaryKey(Integer memberno, Integer movieno);
    public List<ExpectationVO> findByMovieNo(Integer movieno);
    public List<ExpectationVO> getAllByMovieNo();
    //萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<ExpectationVo> getAll(Map<String, String[]> map); 
    public void insertOrUpdateExpectationAndUpdateMovieExpectation (ExpectationVO expectationVO);
    public ExpectationVO getThisMovieToatalExpectation (Integer movieno);

    

}
