package com.movieRating.model;

import java.util.List;

import com.movieRating.model.MovieRatingVO;

public interface MovieRatingDAO_interface {
	
	public void insert(MovieRatingVO movieRatingVO);
	
	public void update(MovieRatingVO movieRatingVO);

	public void delete(Integer movie_no, Integer member_no);

	public List<MovieRatingVO> getAll();
	
	public List<MovieRatingVO> getAllRating(Integer member_no) ;
}
