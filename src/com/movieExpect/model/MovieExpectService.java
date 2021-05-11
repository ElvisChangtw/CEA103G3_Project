package com.movieExpect.model;

import java.util.List;

public class MovieExpectService {
	
	private MovieExpectDAO_interface dao;
	
	public MovieExpectService() {
		dao = new MovieExpectDAO();
	}
	
	public List<MovieExpectVO> getAll(){
		return dao.getAll();
	}
	
	public MovieExpectVO updateMovieExpect(Integer movie_no, Integer member_no, String status) {
		
		MovieExpectVO movieExpectVO = new MovieExpectVO();
		
		movieExpectVO.setMovie_no(movie_no);
		movieExpectVO.setMember_no(member_no);
		movieExpectVO.setStatus(status);
		
		dao.update(movieExpectVO);
		
		return movieExpectVO;
	}
	
	public void deleteMovieExpect(Integer movie_no,Integer member_no) {
		dao.delete(movie_no, member_no);
	} 
	
	public MovieExpectVO addMovieExpect(Integer movie_no, Integer member_no, String status) {
		
		MovieExpectVO movieExpectVO = new MovieExpectVO();
		
		movieExpectVO.setMovie_no(movie_no);
		movieExpectVO.setMember_no(member_no);
		movieExpectVO.setStatus(status);
		
		dao.insert(movieExpectVO);
		
		return movieExpectVO;
		
	}

}
