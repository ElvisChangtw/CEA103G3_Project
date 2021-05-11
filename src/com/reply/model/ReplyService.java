package com.reply.model;

import java.util.List;
import java.util.Map;

public class ReplyService {

	private ReplyDAO_interface dao;

	public ReplyService() {
		dao = new ReplyDAO();
	}

	public ReplyVO addArticle(Integer articleno,Integer memberno,String content,java.sql.Timestamp crtdt, 
			java.sql.Timestamp modifydt,Integer status ) {

		ReplyVO replyVO = new ReplyVO();
		
		replyVO.setArticle_no(articleno);
		replyVO.setMember_no(memberno);		
		replyVO.setContent(content);
		replyVO.setCrt_dt(crtdt);
		replyVO.setModify_dt(modifydt);
		replyVO.setStatus(status);

		dao.insert(replyVO);

		return replyVO;
	}
	
	public ReplyVO updateArticle(Integer replyno,Integer articleno,Integer memberno,String content,java.sql.Timestamp crtdt, 
			java.sql.Timestamp modifydt,Integer status ) {

		ReplyVO replyVO = new ReplyVO();

		replyVO.setReply_no(replyno);
		replyVO.setArticle_no(articleno);
		replyVO.setMember_no(memberno);	
		replyVO.setContent(content);
		replyVO.setCrt_dt(crtdt);
		replyVO.setModify_dt(modifydt);
		replyVO.setStatus(status);
	
		dao.update(replyVO);

		return replyVO;
	}
	

	public void deleteReply(Integer replyno) {
		dao.delete(replyno);
	}

	public ReplyVO getOneReply(Integer replyno) {
		return dao.findByPrimaryKey(replyno);
	}

	public List<ReplyVO> getAll() {
		return dao.getAll();
	}
	public List<ReplyVO> getAll(Map<String, String[]> map) {
		return dao.getAll(map);
	}

}
