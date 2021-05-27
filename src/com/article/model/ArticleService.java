package com.article.model;

import java.sql.Connection;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.like.model.LikeVO;
import com.reply.model.ReplyVO;

public class ArticleService {

	private ArticleDAO_interface dao;

	public ArticleService() {
		dao = new ArticleDAO();
	}

	public ArticleVO addArticle(Integer memberno,String articletype,String content,String articleheadline,
			 java.sql.Timestamp crtdt, java.sql.Timestamp updatedt,Integer status,Integer likecount) {

		ArticleVO articleVO = new ArticleVO();

//		articleVO.setArticleno(articleno);
		articleVO.setMemberno(memberno);
		articleVO.setArticletype(articletype);
		articleVO.setContent(content);
		articleVO.setArticleheadline(articleheadline);
		articleVO.setCrtdt(crtdt);
		articleVO.setUpdatedt(updatedt);
		articleVO.setStatus(status);
		articleVO.setLikecount(likecount);
		dao.insert(articleVO);

		return articleVO;
	}
	
	public ArticleVO updateArticle(Integer articleno, Integer memberno,String articletype,String content,String articleheadline,
			 java.sql.Timestamp crtdt, java.sql.Timestamp updatedt,Integer status,Integer likecount) {

		ArticleVO articleVO = new ArticleVO();

		articleVO.setArticleno(articleno);
		articleVO.setMemberno(memberno);
		articleVO.setArticletype(articletype);
		articleVO.setContent(content);
		articleVO.setArticleheadline(articleheadline);
		articleVO.setCrtdt(crtdt);
		articleVO.setUpdatedt(updatedt);
		articleVO.setStatus(status);
		articleVO.setLikecount(likecount);		
		dao.update(articleVO);

		return articleVO;
	}
	

	public void deleteArticle(Integer articleno) {
		dao.delete(articleno);
	}

	public ArticleVO getOneArticle(Integer articleno) {
		return dao.findByPrimaryKey(articleno);
	}

	public List<ArticleVO> getAll() {
		return dao.getAll();
	}
	public List<ArticleVO> getArticleLikeCount() {
		return dao.getArticleLikeCount();
	}
	public Set<ReplyVO> getReplysByArticleno(Integer articleno) {
		return dao.getReplysByArticleno(articleno);
	}
	
	public void addArticleLike(int articleno, Connection con) {
		dao.addArticleLike(articleno, con);
	}
	
	public void subtractArticleLike(int articleno, Connection con) {
		dao.subtractArticleLike(articleno, con);
	}

	public List<ArticleVO> getAll(Map<String, String[]> map) {		
		return dao.getAll(map);
	}
	public Set<LikeVO> getLikesByArticle(Integer articleno){
		return dao.getLikesByArticle(articleno);
	}
	
}
