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
    //窾ノ狡琩高(肚把计篈Map)(肚 List)
	public List<MovieVO> getAll(Map<String, String[]> map); 
    //琩高琘场(癸)(肚 Set)
    public Set<CommentVO> getCommentsByMovieno(Integer movieno);
    public List<MovieVO> getTopTen(); 
    public List<MovieVO> getTopFive(); 
    public MovieVO getBestMovie(); 
    public List<MovieVO> getYearMovie(String year); 
    public List<MovieVO> getLatestMovie();
    public List<MovieVO> getInTheatersMovie();
    public MovieVO getOneNewestInTheatersMovie();
    public List<MovieVO> getComingSoonMovie();
    public MovieVO getOneNewestComingSoonMovie();
    public List<MovieVO> getAllTopRatingInTheatersMovie(); 
    public List<MovieVO> getAllTopExpectationComingSoonMovie(); 
    public void updateMovieRating (MovieVO movieVO , java.sql.Connection con);
    public void updateMovieExpectation (MovieVO movieVO , java.sql.Connection con);
    public void updateMovieStatus();
    
	public void createMovieIdex() ;
	public List<MovieVO> getAllForGroup();
    
}
