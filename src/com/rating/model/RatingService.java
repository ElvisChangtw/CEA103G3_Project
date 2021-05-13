package com.rating.model;

import java.util.List;

public class RatingService {

	private RatingDAO_interface dao;

	public RatingService() {
		dao = new RatingDAO();
	}

	public RatingVO addRating(Integer memberno, Integer movieno, Double rating) {

		RatingVO ratingVO = new RatingVO();

		ratingVO.setMemberno(memberno);
		ratingVO.setMovieno(movieno);
		ratingVO.setRating(rating);
				
		dao.insert(ratingVO);

		return ratingVO;
	}

	public RatingVO updateRating(Integer memberno, Integer movieno , Double rating) {

		RatingVO ratingVO = new RatingVO();

		ratingVO.setMemberno(memberno);
		ratingVO.setMovieno(movieno);
		ratingVO.setRating(rating);
		
		dao.update(ratingVO);

		return ratingVO;
	}

	public void deleteRating(Integer memberno,Integer movieno) {
		dao.delete(memberno,movieno);
	}
	
	public RatingVO getOneRating(Integer memberno, Integer movieno) {
		return dao.findByPrimaryKey(memberno,movieno);
	}

	public List<RatingVO> findByMovieNo(Integer movieno) {
		return dao.findByMovieNo(movieno);
	}

	public List<RatingVO> getAllByMovieNo() {
		return dao.getAllByMovieNo();
	}
	
	public RatingVO insertOrUpdateRatingtAndUpdateMovieRating (Integer memberno, Integer movieno, Double rating) {
		
		RatingVO ratingVO = new RatingVO();
		
		ratingVO.setMemberno(memberno);
		ratingVO.setMovieno(movieno);
		ratingVO.setRating(rating);	
		
		dao.insertOrUpdateRatingtAndUpdateMovieRating(ratingVO);

		return ratingVO;
	}
	
	public RatingVO getThisMovieToatalRating(Integer movieno) {
		return dao.getThisMovieToatalRating(movieno);
	}

}
