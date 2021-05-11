package com.movie.model;

import java.sql.Connection;
import java.sql.Date;
import java.util.*;
import com.comment.model.*;

public interface MovieDAO_interface {
	
	public void insert(MovieVO movieVO);
	public void update(MovieVO movieVO);
	public void delete(Integer movieno);
	public MovieVO findByPrimaryKey(Integer movieno);
	public List<MovieVO> getAll();
    //�U�νƦX�d��(�ǤJ�Ѽƫ��AMap)(�^�� List)
	public List<MovieVO> getAll(Map<String, String[]> map); 
    //�d�߬Y���������u(�@��h)(�^�� Set)
    public Set<CommentVO> getCommentsByMovieno(Integer movieno);
    public List<MovieVO> getTopTen(); 
    public List<MovieVO> getTopFive(); 
    public List<MovieVO> getYearMovie(String year); 
    public List<MovieVO> getLatestMovie();
    public void updateMovieRating ( MovieVO movieVO , java.sql.Connection con);
    public void updateMovieExpectation ( MovieVO movieVO , java.sql.Connection con);
    
	public void createMovieIdex() ;
    
}
