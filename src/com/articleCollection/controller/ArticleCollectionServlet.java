package com.articleCollection.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.articleCollection.model.ArticleCollectionService;
import com.articleCollection.model.ArticleCollectionVO;
import com.mem.model.MemService;
import com.mem.model.MemVO;
import com.movieRating.model.MovieRatingService;
import com.movieRating.model.MovieRatingVO;

@WebServlet("/ArticleCollectionServlet")
public class ArticleCollectionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html; charset=Big5");
		String action = req.getParameter("action");
		PrintWriter out = res.getWriter();
		
		if("insert".equals(action)) {
			List<String> errorMsgs = new ArrayList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				int member_no = new Integer(req.getParameter("member_no"));
				int article_no = new Integer(req.getParameter("article_no"));
				ArticleCollectionService artcolSvc = new ArticleCollectionService();
				artcolSvc.addArticleCollection(article_no, member_no);

				//設session傳memVO，有等入系統後刪掉
//				MemService memSvc = new MemService();
//				MemVO memVO = memSvc.getOneMem(member_no);
//				req.getSession().setAttribute("memVO", memVO);
				out.print("success");
			}catch(Exception e) {
				out.print("fail");
				errorMsgs.add("文章收藏修改失敗");
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/mem/memberSys.jsp");
				failureView.forward(req, res);
			}finally {
				out.flush();
				out.close();
			}
        	
        }
		
		if("delete".equals(action)) {
			List<String> errorMsgs = new ArrayList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				int member_no = new Integer(req.getParameter("member_no"));
				int article_no = new Integer(req.getParameter("article_no"));
				ArticleCollectionService artcolSvc = new ArticleCollectionService();
				artcolSvc.deleteArticleCollection(article_no, member_no);
				out.print("success");

			}
			catch(Exception e) {
				out.print("fail");
				errorMsgs.add("文章收藏刪除失敗");
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/mem/memberSys.jsp");
				failureView.forward(req, res);
			}finally {
				out.flush();
				out.close();
			}
			
		}
		if("list_artcol_by_memno".equals(action)) {
			List<String> errorMsgs = new ArrayList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				Integer member_no = new Integer(req.getParameter("member_no").trim());
				ArticleCollectionService artcolSvc = new ArticleCollectionService();

				//設session傳memVO，有等入系統後刪掉
				MemService memSvc = new MemService();
				MemVO memVO = memSvc.getOneMem(member_no);
				req.getSession().setAttribute("memVO", memVO);
				
				RequestDispatcher successView = req.getRequestDispatcher("/front-end/mem/memberSys.jsp");
				successView.forward(req, res);
			}catch(Exception e){
				errorMsgs.add("查看電影評分失敗");
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/mem/memberSys.jsp");
				failureView.forward(req, res);
			}
		}
		
	}

}
