package com.articleCollection.model;

import java.util.List;

import com.like.model.LikeVO;

public interface ArticleCollectionDAO_interface {
	
	public void insert(ArticleCollectionVO articleCollectionVO);
	public void delete(Integer article_no, Integer member_no);
	public List<ArticleCollectionVO> findByPrimaryKey(Integer member_no);
	public List<ArticleCollectionVO> getAll();
	public ArticleCollectionVO findByPrimaryKey(Integer article_no, Integer member_no);
	public void insertArticlCollectionAndDelete(ArticleCollectionVO articleCollectionVO);
	
}
