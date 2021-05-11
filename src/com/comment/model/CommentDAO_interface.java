package com.comment.model;

import java.util.*;

public interface CommentDAO_interface {
	
    public void insert(CommentVO commentVO);
    public void update(CommentVO commentVO);
    public void delete(Integer commentno);
    public CommentVO findByPrimaryKey(Integer commentno);
//    public List<CommentVO> findByMemberNo(Integer memberno);
    public List<CommentVO> findByMovieNo(Integer movieno);
    public List<CommentVO> getAll();
    //�U�νƦX�d��(�ǤJ�Ѽƫ��AMap)(�^�� List)
    public List<CommentVO> getAll(Map<String, String[]> map); 
    public List<CommentVO> findByMemberNo(Integer memberno);
    public void update_bycommentno(CommentVO commentVO);

}
