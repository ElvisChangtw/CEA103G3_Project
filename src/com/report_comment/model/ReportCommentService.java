package com.report_comment.model;

import java.util.List;

public class ReportCommentService {
	
	private ReportCommentDAO_interface dao;

	public ReportCommentService() {
		dao = new ReportCommentDAO();
	}

	public ReportCommentVO addReportComment(Integer commentno, String content, Integer memberno) {

		ReportCommentVO reportcommentVO = new ReportCommentVO();

		reportcommentVO.setCommentno(commentno);
		reportcommentVO.setContent(content);
		reportcommentVO.setMemberno(memberno);
		
		dao.insert(reportcommentVO);

		return reportcommentVO;
	}

	public ReportCommentVO updateReportComment(String status, String desc ,Integer reportno) {

		ReportCommentVO reportcommentVO = new ReportCommentVO();

		reportcommentVO.setStatus(status);
		reportcommentVO.setDesc(desc);
		reportcommentVO.setReportno(reportno);
		
		dao.update(reportcommentVO);

		return reportcommentVO;
	}
	
	public ReportCommentVO updateAllReportFromThisComment(Integer commentno, String status, String desc) {
		
		ReportCommentVO reportcommentVO = new ReportCommentVO();

		reportcommentVO.setCommentno(commentno);
		reportcommentVO.setStatus(status);
		reportcommentVO.setDesc(desc);
		
		
		dao.updateAllReportFromThisComment(reportcommentVO);

		return reportcommentVO;
	}

	public void deleteReportComment(Integer reportno) {
		dao.delete(reportno);
	}

	public ReportCommentVO getOneReportComment(Integer reportno) {
		return dao.findByPrimaryKey(reportno);
	}

	public List<ReportCommentVO> getAll() {
		return dao.getAll();
	}
	
	public List<ReportCommentVO> getAllOrderByReportno(){
		return dao.getAllOrderByReportno();
	}

}
