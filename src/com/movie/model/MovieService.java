package com.movie.model;

import java.util.List;
import java.util.Map;
import java.util.Set;

import com.comment.model.*;

public class MovieService {

	private MovieDAO_interface dao;

	public MovieService() {
		dao = new MovieDAO();
	}

	public MovieVO addMovie(String moviename, byte[] moviepicture1, byte[] moviepicture2, String director, String actor,
			String category, Integer length, String status, java.sql.Date premiredate, java.sql.Date offdate,
			String trailor, String embed, String grade) {

		MovieVO movieVO = new MovieVO();

		movieVO.setMoviename(moviename);
		movieVO.setMoviepicture1(moviepicture1);
		movieVO.setMoviepicture2(moviepicture2);
		movieVO.setDirector(director);
		movieVO.setActor(actor);
		movieVO.setCategory(category);
		movieVO.setLength(length);
		movieVO.setStatus(status);
		movieVO.setPremiredate(premiredate);
		movieVO.setOffdate(offdate);
		movieVO.setTrailor(trailor);
		movieVO.setEmbed(embed);
		movieVO.setGrade(grade);
		
		dao.insert(movieVO);

		return movieVO;
	}

	public MovieVO updateMovie(Integer movieno, String moviename, byte[] moviepicture1, byte[] moviepicture2, String director, 
			String actor, String category, Integer length, String status, java.sql.Date premiredate, 
			java.sql.Date offdate, String trailor, String embed, String grade) {

		MovieVO movieVO = new MovieVO();

		movieVO.setMovieno(movieno);
		movieVO.setMoviename(moviename);
		movieVO.setMoviepicture1(moviepicture1);
		movieVO.setMoviepicture2(moviepicture2);
		movieVO.setDirector(director);
		movieVO.setActor(actor);
		movieVO.setCategory(category);
		movieVO.setLength(length);
		movieVO.setStatus(status);
		movieVO.setPremiredate(premiredate);
		movieVO.setOffdate(offdate);
		movieVO.setTrailor(trailor);
		movieVO.setEmbed(embed);
		movieVO.setGrade(grade);
		
		dao.update(movieVO);

		return movieVO;
	}

	public void deleteMovie(Integer movieno) {
		dao.delete(movieno);
	}

	public MovieVO getOneMovie(Integer movieno) {
		return dao.findByPrimaryKey(movieno);
	}

	public List<MovieVO> getAll() {
		return dao.getAll();
	}
	
	public List<MovieVO> getAll(Map<String, String[]> map) {
		return dao.getAll(map);
	}
	
	public Set<CommentVO> getCommentsByMovieno(Integer movieno) {
		return dao.getCommentsByMovieno(movieno);
	}
	
	public List<MovieVO> getTopTen() {
		return dao.getTopTen();
	}
	
	public List<MovieVO> getTopFive() {
		return dao.getTopFive();
	}
	
	public MovieVO getBestMovie() {
		return dao.getBestMovie();
	}
	
	public List<MovieVO> getYearMovie(String year) {
		return dao.getYearMovie(year);
	}
	
	public List<MovieVO> getLatestMovie() {
		return dao.getLatestMovie();
	}
	
	public List<MovieVO> getInTheatersMovie() {
		return dao.getInTheatersMovie();
	}
	
	public MovieVO getOneNewestInTheatersMovie() {
		return dao.getOneNewestInTheatersMovie();
	}
	
	public List<MovieVO> getComingSoonMovie() {
		return dao.getComingSoonMovie();
	}
	
	public MovieVO getOneNewestComingSoonMovie() {
		return dao.getOneNewestComingSoonMovie();
	}
	
	public List<MovieVO> getAllTopRatingInTheatersMovie() {
		return dao.getAllTopRatingInTheatersMovie();
	}
	
	public List<MovieVO> getAllTopExpectationComingSoonMovie() {
		return dao.getAllTopExpectationComingSoonMovie();
	}
	
	public void updateMovieStatus() {
		dao.updateMovieStatus();
		System.out.println("已更新電影狀態");
	}
	
	public List<MovieVO> getAllForGroup(){
		return dao.getAllForGroup();
	}
	public void createMovieIdex() {
		dao.createMovieIdex();
	}
	
	
}
