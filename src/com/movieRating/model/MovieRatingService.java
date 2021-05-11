package com.movieRating.model;

import java.util.List;

public class MovieRatingService {
private MovieRatingDAO_interface dao;
	
	public MovieRatingService() {
		dao = new MovieRatingDAO();
	}
	
	public List<MovieRatingVO> getAllRating(Integer member_no){
		return dao.getAllRating(member_no);
	}
	
	public List<MovieRatingVO> getAll(){
		return dao.getAll();
	}
	
	public MovieRatingVO updateMovieRating(Integer movie_no, Integer member_no, Float rating) {
		
		MovieRatingVO movieRatingVO = new MovieRatingVO();
		
		movieRatingVO.setMovie_no(movie_no);
		movieRatingVO.setMember_no(member_no);
		movieRatingVO.setRating(rating);
		
		dao.update(movieRatingVO);
		
		return movieRatingVO;
	}
	
	public void deleteMovieRating(Integer movie_no,Integer member_no) {
		dao.delete(movie_no, member_no);
	} 
	
	public MovieRatingVO addMovieRating(Integer movie_no, Integer member_no, Float rating) {
		
		MovieRatingVO movieRatingVO = new MovieRatingVO();
		
		movieRatingVO.setMovie_no(movie_no);
		movieRatingVO.setMember_no(member_no);
		movieRatingVO.setRating(rating);
		
		dao.insert(movieRatingVO);
		
		return movieRatingVO;
		
	}

}
