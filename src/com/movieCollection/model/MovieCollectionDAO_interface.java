package com.movieCollection.model;

import java.util.List;


public interface MovieCollectionDAO_interface {
	
	public void insert(MovieCollectionVO movieCollectionVO);
	public void delete(Integer movie_no, Integer member_no);
	public List<MovieCollectionVO> findByPrimaryKey(Integer member_no);
	public List<MovieCollectionVO> getAll();
}
