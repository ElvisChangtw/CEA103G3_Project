package com.like.model;

import java.util.List;

public interface LikeDAO_interface {
    public void insert(LikeVO likeVO);
    public void update(LikeVO likeVO);
    public void delete(Integer articleno,Integer memberno);
    public LikeVO findByPrimaryKey(Integer articleno,Integer memberno);
    public List<LikeVO> getAll();
    //萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<LikeVO> getAll(Map<String, String[]> map); 
    public void insertLikeAndUpdateLikeCount(LikeVO likeVO);
}
