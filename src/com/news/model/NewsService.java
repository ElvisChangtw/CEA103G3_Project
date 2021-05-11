package com.news.model;

import java.sql.Date;
import java.util.List;
import com.news.model.*;

public class NewsService {
	
	private NewsDAO_interface dao;

	public NewsService() {
		dao = new NewsDAO();
	}
	
	public NewsVO addEmp(Integer empno, String news_title, String news_desc, String status, java.sql.Date publish_date) {

		NewsVO newsVO = new NewsVO();

		newsVO.setEmpno(empno);
		newsVO.setNews_title(news_title);
		newsVO.setNews_desc(news_desc);
		newsVO.setStatus(status);
		newsVO.setPublish_date(publish_date);
		dao.insert(newsVO);

		return newsVO;
	}

	public NewsVO updateEmp(Integer news_no, Integer empno, String news_title, String news_desc, String status, java.sql.Date publish_date) {

		NewsVO newsVO = new NewsVO();

		newsVO.setNews_no(news_no);
		newsVO.setEmpno(empno);
		newsVO.setNews_title(news_title);
		newsVO.setNews_desc(news_desc);
		newsVO.setStatus(status);
		newsVO.setPublish_date(publish_date);
		dao.update(newsVO);

		return newsVO;
	}

	public void deleteEmp(Integer news_no) {
		dao.delete(news_no);
	}

	public NewsVO getOneEmp(Integer news_no) {
		return dao.findByPrimaryKey(news_no);
	}

	public List<NewsVO> getAll() {
		return dao.getAll();
	}
}
