package com.comment.model;

import java.util.*;

import com.movie.model.MovieVO;

public interface CommentDAO_interface {
	
    public void insert(CommentVO commentVO);
    public void update(CommentVO commentVO);
    public void updateCommentStatusOff(CommentVO commentVO , java.sql.Connection con);
    public void updateCommentStatusOn(CommentVO commentVO , java.sql.Connection con);
    public void delete(Integer commentno);
    public CommentVO findByPrimaryKey(Integer commentno);
//    public List<CommentVO> findByMemberNo(Integer memberno);
    public List<CommentVO> findByMovieNo(Integer movieno);
    public List<CommentVO> getAll();
    //萬用複合查詢(傳入參數型態Map)(回傳 List)
    public List<CommentVO> getAll(Map<String, String[]> map); 
    public List<CommentVO> findByMemberNo(Integer memberno);
    public void update_bycommentno(CommentVO commentVO);
}
