package com.movieExpect.model;

import java.util.List;

import com.mem.model.MemVO;

public interface MovieExpectDAO_interface {
	
	public void insert(MovieExpectVO movieExpectVO);
	
	public void update(MovieExpectVO movieExpectVO);

	public void delete(Integer movie_no, Integer member_no);

	public MovieExpectVO findByPrimaryKey(Integer movie_no, Integer member_no);

	public List<MovieExpectVO> getAll();

}
