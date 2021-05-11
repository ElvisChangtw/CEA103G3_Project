package com.movieCollection.model;

import java.util.List;



public class MovieCollectionService {
	
	private MovieCollectionDAO_interface dao;
	
	public MovieCollectionService() {
		dao = new MovieCollectionDAO();
	}
	
	public List<MovieCollectionVO> getAll(){
		return dao.getAll();
	}
	
	public List<MovieCollectionVO> getAllMovieCollection(Integer member_no) {
		return dao.findByPrimaryKey(member_no);
	}
	
	public void deleteMovieCollection(Integer movie_no, Integer member_no) {
		dao.delete(movie_no, member_no);
	}
	
	public MovieCollectionVO addMovieCollection(Integer movie_no, Integer member_no) {
		
		MovieCollectionVO movieCollectionVO = new MovieCollectionVO();
			
		movieCollectionVO.setMember_no(member_no);
		movieCollectionVO.setMovie_no(movie_no);
			
			dao.insert(movieCollectionVO);
			
			return movieCollectionVO;
	}
}
