package com.rating.model;

import java.util.*;

public interface RatingDAO_interface {
	
	public void insert(RatingVO ratingVO);
    public void update(RatingVO ratingVO);
    public void delete(Integer memberno , Integer movieno);
    public RatingVO findByPrimaryKey(Integer memberno, Integer movieno);
    public List<RatingVO> findByMovieNo(Integer movieno);
    public List<RatingVO> getAllByMovieNo();
    //萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<RatingVo> getAll(Map<String, String[]> map); 
    public void insertOrUpdateRatingtAndUpdateMovieRating (RatingVO ratingVO);
    public RatingVO getThisMovieToatalRating (Integer movieno);

    

}
