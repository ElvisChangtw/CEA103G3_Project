//01版 只有查詢

package com.report_comment.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import com.comment.model.CommentService;
import com.comment.model.CommentVO;
import com.expectation.model.ExpectationService;
import com.expectation.model.ExpectationVO;
import com.mem.model.MemService;
import com.mem.model.MemVO;
import com.movie.model.MovieService;
import com.movie.model.MovieVO;
import com.rating.model.RatingService;
import com.rating.model.RatingVO;
import com.report_comment.model.*;

public class ReportCommentServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		res.setContentType("text/html; charset=UTF-8");
		String action = req.getParameter("action");

		if ("getAll".equals(action)) {
			/***************************開始查詢資料 ****************************************/
			ReportCommentService reportCommentSvc = new ReportCommentService();
			List<ReportCommentVO> list= reportCommentSvc.getAll();

			/***************************查詢完成,準備轉交(Send the Success view)*************/
			HttpSession session = req.getSession();
			session.setAttribute("list", list);    // 資料庫取出的list物件,存入session
			// Send the Success view
			String url = "/back-end/report_comment/listAllReportComment.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交listAllComment2_getFromSession.jsp
			successView.forward(req, res);
			return;
		}


		if ("getOne_For_Display".equals(action)) { // 來自select_report_comment_page.jsp的請求 //比對寫在前面 所小除錯範圍

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("reportno");
				if (str == null || (str.trim()).length() == 0) { //加str == null 防呆getParameter("reportno")的reportno取到空值的情況
					errorMsgs.add("請輸入檢舉評論編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/01MVC/report_commentVAR01/select_report_comment_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer reportno = null;
				try {
					reportno = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("檢舉評論編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/01MVC/report_commentVAR01/select_report_comment_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				ReportCommentDAO dao = new ReportCommentDAO();
				ReportCommentVO reportcommentVO = dao.findByPrimaryKey(reportno);
				if (reportcommentVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/01MVC/report_commentVAR01/select_report_comment_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("reportcommentVO", reportcommentVO); // 資料庫取出的reportcommentVO物件,存入req
				String url = "/01MVC/report_commentVAR01/listOneReportComment.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneReportComment.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/01MVC/report_commentVAR01/select_report_comment_page.jsp");
				failureView.forward(req, res);
			}
		}
		
//新增檢舉評論還未改		
		 if ("insert".equals(action)) { // 來自addComment.jsp的請求  
				
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			String requestURL = req.getParameter("requestURL");
System.out.println(requestURL);
			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				Integer commentno = new Integer(req.getParameter("commentno").trim());
				
				String content = req.getParameter("content").trim();
				if (content == null || content.trim().length() == 0) {
					errorMsgs.add("檢舉內容請勿空白");
				}

				Integer memberno = new Integer(req.getParameter("memberno").trim());
			
				
				ReportCommentVO reportcommentVO = new ReportCommentVO();
				
				reportcommentVO.setCommentno(commentno);
				reportcommentVO.setContent(content);
				reportcommentVO.setMemberno(memberno);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("reportcommentVO", reportcommentVO);
					
					CommentService commentSvc = new CommentService();
					Integer movieno = commentSvc.getOneComment(commentno).getMovieno(); 
					
					MovieService movieSvc = new MovieService();
					MovieVO movieVO = movieSvc.getOneMovie(movieno);
					req.setAttribute("movieVO", movieVO);// 含有輸入格式錯誤的commentVO物件,也存入req
					
					RatingService ratingSvc = new RatingService();
					RatingVO ratingCount = ratingSvc.getThisMovieToatalRating(movieno);
					req.setAttribute("ratingCount", ratingCount);

					ExpectationService expectationSvc = new ExpectationService();
					ExpectationVO expectationCount = expectationSvc.getThisMovieToatalExpectation(movieno);
					req.setAttribute("expectationCount", expectationCount);
					RequestDispatcher failureView = req
							.getRequestDispatcher(requestURL);
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				ReportCommentService reportcommentSvc = new ReportCommentService();
				reportcommentVO = reportcommentSvc.addReportComment(commentno, content, memberno);
				
				CommentService commentSvc = new CommentService();
				Integer movieno = commentSvc.getOneComment(commentno).getMovieno(); 
				
				MovieService movieSvc = new MovieService();
				MovieVO movieVO = movieSvc.getOneMovie(movieno);
				req.setAttribute("movieVO", movieVO);
				
				RatingService ratingSvc = new RatingService();
				RatingVO ratingCount = ratingSvc.getThisMovieToatalRating(movieno);
				req.setAttribute("ratingCount", ratingCount);

				ExpectationService expectationSvc = new ExpectationService();
				ExpectationVO expectationCount = expectationSvc.getThisMovieToatalExpectation(movieno);
				req.setAttribute("expectationCount", expectationCount);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = requestURL;
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉回原本頁面
				successView.forward(req, res);	
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/comment/addComment.jsp");
				failureView.forward(req, res);
			}
		}
	}
}
