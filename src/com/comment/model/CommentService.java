package com.comment.model;

import java.util.List;
import java.util.Map;

public class CommentService {
	
	private CommentDAO_interface dao;

	public CommentService() {
		dao = new CommentDAO();
	}

	public CommentVO addComment(Integer memberno, Integer movieno, String content, String status) {

		CommentVO commentVO = new CommentVO();

		commentVO.setMemberno(memberno);
		commentVO.setMovieno(movieno);
		commentVO.setContent(content);
		commentVO.setStatus(status);
		
		dao.insert(commentVO);

		return commentVO;
	}

	public CommentVO updateComment(Integer commentno, Integer movieno, String content) {

		CommentVO commentVO = new CommentVO();
		
		commentVO.setCommentno(commentno);
		commentVO.setMovieno(movieno);
		commentVO.setContent(content);

		dao.update(commentVO);

		return commentVO;
	}

	public void deleteComment(Integer commentno) {
		dao.delete(commentno);
	}

	public CommentVO getOneComment(Integer commentno) {
		return dao.findByPrimaryKey(commentno);
	}

	public List<CommentVO> getAll() {
		return dao.getAll();
	}
	
	public List<CommentVO> getAll(Map<String, String[]> map) {
		return dao.getAll(map);
	}
	
	public List<CommentVO> getOneMovieComment(Integer movieno) {
		return dao.findByMovieNo(movieno);
	}
	
	public List<CommentVO> getComments(Integer memberno) {
		return dao.findByMemberNo(memberno);
	}
	
	public CommentVO updateComment_bycommentno(Integer commentno,String content) {
		CommentVO commentVO = new CommentVO();
		
		commentVO.setCommentno(commentno);
		commentVO.setContent(content);

		dao.update_bycommentno(commentVO);

		return commentVO;
	}
}
