package com.report_article.model;

import java.util.List;

public class Report_ArticleService {

	private Report_ArticleDAO_interface dao;

	public Report_ArticleService() {
		dao = new Report_ArticleDAO();
	}

	public Report_ArticleVO addReport_Article(Integer articleno,String content,java.sql.Timestamp crtdt, 
			Integer memberno,java.sql.Timestamp executedt,Integer status,String desc) {

		Report_ArticleVO report_articleVO = new Report_ArticleVO();
		
		report_articleVO.setArticleno(articleno);
		report_articleVO.setContent(content);
		report_articleVO.setCrtdt(crtdt);
		report_articleVO.setMemberno(memberno);
		report_articleVO.setExecutedt(executedt);
		report_articleVO.setStatus(status);
		report_articleVO.setDesc(desc);

		dao.insert(report_articleVO);

		return report_articleVO;
	}
	
	public Report_ArticleVO updateReport_Article(Integer reportno,Integer articleno,String content,java.sql.Timestamp crtdt, 
			Integer memberno,java.sql.Timestamp executedt,Integer status,String desc) {

		Report_ArticleVO report_articleVO = new Report_ArticleVO();

		report_articleVO.setReportno(reportno);
		report_articleVO.setArticleno(articleno);
		report_articleVO.setContent(content);
		report_articleVO.setCrtdt(crtdt);
		report_articleVO.setMemberno(memberno);
		report_articleVO.setExecutedt(executedt);
		report_articleVO.setStatus(status);
		report_articleVO.setDesc(desc);
	
		dao.update(report_articleVO);

		return report_articleVO;
	}
	

	public void deleteReport_ArticleVO(Integer reportno) {
		dao.delete(reportno);
	}

	public Report_ArticleVO getOneReport_Article(Integer reportno) {
		return dao.findByPrimaryKey(reportno);
	}

	public List<Report_ArticleVO> getAll() {
		return dao.getAll();
	}
}
