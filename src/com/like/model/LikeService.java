package com.like.model;

import java.util.List;

public class LikeService {

	private LikeDAO_interface dao;

	public LikeService() {
		dao = new LikeDAO();
	}

	public LikeVO addLike(Integer articleno,Integer memberno) {

		LikeVO likeVO = new LikeVO();
		likeVO.setArticleno(articleno);
		likeVO.setMemberno(memberno);
		dao.insertLikeAndUpdateLikeCount(likeVO);
		return likeVO;
	}
	
	public LikeVO updateLike(Integer articleno,Integer memberno) {

		LikeVO likeVO = new LikeVO();
		likeVO.setArticleno(articleno);
		likeVO.setMemberno(memberno);
		dao.update(likeVO);

		return likeVO;
	}
	

	public void deleteLike(Integer articleno,Integer memberno) {
		dao.delete(articleno,memberno);
	}

	public LikeVO getOneLike(Integer articleno,Integer memberno) {
		return dao.findByPrimaryKey(articleno,memberno);
	}

	public List<LikeVO> getAll() {
		return dao.getAll();
	}
}
