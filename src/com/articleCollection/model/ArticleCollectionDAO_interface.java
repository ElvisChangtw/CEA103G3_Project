package com.articleCollection.model;

import java.util.List;

public interface ArticleCollectionDAO_interface {
	
	public void insert(ArticleCollectionVO articleCollectionVO);
	public void delete(Integer article_no, Integer member_no);
	public List<ArticleCollectionVO> findByPrimaryKey(Integer member_no);
	public List<ArticleCollectionVO> getAll();

}
