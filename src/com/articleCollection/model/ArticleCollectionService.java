package com.articleCollection.model;

import java.util.List;

public class ArticleCollectionService {
	
	private ArticleCollectionDAO_interface dao;
	
	public ArticleCollectionService() {
		
		dao = new ArticleCollectionDAO();
	}
	
	public List<ArticleCollectionVO> getAll(){
		return dao.getAll();
	}
	
	public ArticleCollectionVO addArticleCollection(Integer article_no, Integer member_no) {
			
		ArticleCollectionVO articleCollectionVO = new ArticleCollectionVO();
			
		articleCollectionVO.setMember_no(member_no);
		articleCollectionVO.setArticle_no(article_no);	
//		articleCollectionVO.setCrt_dt(crt_dt);
//		dao.insert(articleCollectionVO);
		dao.insertArticlCollectionAndDelete(articleCollectionVO);
			
		return articleCollectionVO;
	}

	public List<ArticleCollectionVO> getAllArticleCollection(Integer member_no) {
		return dao.findByPrimaryKey(member_no);
	}
	
	public void deleteArticleCollection(Integer article_no, Integer member_no) {
		dao.delete(article_no, member_no);
	}
	public ArticleCollectionVO getOneArticleCollection(Integer article_no, Integer member_no) {
		return dao.findByPrimaryKey(article_no,member_no);
	}

}
