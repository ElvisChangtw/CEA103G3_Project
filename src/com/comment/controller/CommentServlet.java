package com.comment.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import com.comment.model.*;
import com.movie.model.*;



public class CommentServlet extends HttpServlet {

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
			CommentService commentSvc = new CommentService();
			List<CommentVO> list= commentSvc.getAll();
			
			/***************************查詢完成,準備轉交(Send the Success view)*************/
			HttpSession session = req.getSession();
			session.setAttribute("list", list);    // 資料庫取出的list物件,存入session
			// Send the Success view
			String url = "/front-end/comment/listAllComment.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交listAllComment2_getFromSession.jsp
			successView.forward(req, res);
			return;
		}


		if ("getOne_For_Display".equals(action)) { // 來自select_comment_page.jsp的請求 //比對寫在前面 所小除錯範圍

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("commentno");
				if (str == null || (str.trim()).length() == 0) { //加str == null 防呆getParameter("commentno")的commentno取到空值的情況
					errorMsgs.add("請輸入評論編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/comment/select_comment_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				Integer commentno = null;
				try {
					commentno = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("評論編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/comment/select_comment_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				CommentService commentSvc = new CommentService();
				CommentVO commentVO = commentSvc.getOneComment(commentno);
			
				if (commentVO == null) {
					errorMsgs.add("查無資料");
				}
//				 Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/comment/select_comment_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("commentVO", commentVO); // 資料庫取出的commentVO物件,存入req
				String url = "/front-end/comment/listOneComment.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneComment.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/comment/select_comment_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("getOne_For_Update".equals(action)) { // 來自listAllComment.jsp的請求  或  /movie/listComments_ByMovieno.jsp 的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/comment/listAllComment.jsp】 或  【/movie/listComments_ByMovieno.jsp】 或 【 /movie/listAllMovie.jsp】		

			try {
				/***************************1.接收請求參數****************************************/
				Integer commentno = new Integer(req.getParameter("commentno"));
				
				/***************************2.開始查詢資料****************************************/
				CommentService commentSvc = new CommentService();
				CommentVO commentVO = commentSvc.getOneComment(commentno);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("commentVO", commentVO);         // 資料庫取出的commentVO物件,存入req
				String url = "/front-end/comment/update_comment_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_comment_input.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher(requestURL);
				failureView.forward(req, res);

			}
		}
		
		
		if ("update".equals(action)) { // 來自update_comment_input.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/comment/listAllComment.jsp】 或  【/movie/listComments_ByMovieno.jsp】 或 【 /movie/listAllMovie.jsp】		
	
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				Integer commentno = new Integer(req.getParameter("commentno").trim());
				
				Integer movieno = new Integer(req.getParameter("movieno").trim());
				
				String content = req.getParameter("content").trim();
				if (content == null || content.trim().length() == 0) {
					errorMsgs.add("評論內容請勿空白");
				}	
				
				CommentVO commentVO = new CommentVO();
								
				commentVO.setCommentno(commentno);
				commentVO.setMovieno(movieno);
				commentVO.setContent(content);
		
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("commentVO", commentVO); // 含有輸入格式錯誤的commentVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/comment/update_comment_input.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
				CommentService commentSvc = new CommentService();
				commentSvc.updateComment(commentno, movieno, content);
				commentVO = commentSvc.getOneComment(commentno);
				
				MovieService movieSvc = new MovieService();
				MovieVO movieVO = movieSvc.getOneMovie(movieno);
				if (movieVO == null) {
					errorMsgs.add("查無資料");
				}
				req.setAttribute("movieVO", movieVO);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("commentVO", commentVO); // 資料庫update成功後,正確的的commentVO物件,存入req
//				String url = "/front-end/comment/listOneComment.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneComment.jsp
//				successView.forward(req, res);
				
				
//				if(requestURL.equals("/front-end/movie/listComments_ByMovieno.jsp") || requestURL.equals("/front-end/movie/listAllMovie.jsp"))
//					req.setAttribute("listCommnets_ByMovieno",movieSvc.getCommentsByMovieno(movieno)); // 資料庫取出的list物件,存入request
//				
//				if(requestURL.equals("/front-end/comment/listComments_ByCompositeQuery.jsp")){
//					HttpSession session = req.getSession();
//					Map<String, String[]> map = (Map<String, String[]>)session.getAttribute("map");
//					List<CommentVO> list  = commentSvc.getAll(map);
//					req.setAttribute("listComments_ByCompositeQuery",list); //  複合查詢, 資料庫取出的list物件,存入request
//				}
                
				String url = requestURL;
				RequestDispatcher successView = req.getRequestDispatcher(url);   // 修改成功後,轉交回送出修改的來源網頁
				successView.forward(req, res);


				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/comment/update_comment_input.jsp");
				failureView.forward(req, res);
			}
		}

        if ("insert".equals(action)) { // 來自addComment.jsp的請求  
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			String requestURL = req.getParameter("requestURL");

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				Integer memberno = new Integer(req.getParameter("memberno").trim());
				
				Integer movieno = new Integer(req.getParameter("movieno").trim());
				
				
				String content = req.getParameter("content").trim();
				if (content == null || content.trim().length() == 0) {
					errorMsgs.add("評論內容請勿空白");
				}

				String status = req.getParameter("status").trim();
				if (status.equals("9")) {
					errorMsgs.add("請選擇評論狀態");// 給select下拉式選單第一個留空白用的
				}
			
				CommentVO commentVO = new CommentVO();
				commentVO.setMemberno(memberno);
				commentVO.setMovieno(movieno);
				commentVO.setContent(content);
				commentVO.setStatus(status);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("commentVO", commentVO); // 含有輸入格式錯誤的commentVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/comment/addComment.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				CommentService commentSvc = new CommentService();
				commentVO = commentSvc.addComment(memberno, movieno, content ,status);
				
				MovieService movieSvc = new MovieService();
				MovieVO movieVO = movieSvc.getOneMovie(movieno);
				if (movieVO == null) {
					errorMsgs.add("查無資料");
				}
				req.setAttribute("movieVO", movieVO);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				
//				if(requestURL.equals("/front-end/movie/listComments_ByMovieno.jsp")){
					String url = requestURL;
					RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉回原本頁面
					successView.forward(req, res);	
//				}else {
//					String url = "/front-end/comment/listAllComment.jsp";
//					RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllComment.jsp
//					successView.forward(req, res);	
//				}
							
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/comment/addComment.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("delete".equals(action)) { // 來自listAllComment.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/comment/listAllComment.jsp】 或  【/movie/listComments_ByMovieno.jsp】 或 【 /movie/listAllMovie.jsp】或 【 /comment/listComments_ByCompositeQuery.jsp】		
	
			try {
				/***************************1.接收請求參數***************************************/
				Integer commentno = new Integer(req.getParameter("commentno"));
			
				/***************************2.開始刪除資料***************************************/
				CommentService commentSvc = new CommentService();
				CommentVO commentVO = commentSvc.getOneComment(commentno);
				commentSvc.deleteComment(commentno);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
//				String url = "/front-end/comment/listAllComment.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
//				successView.forward(req, res);
				
				MovieService movieSvc = new MovieService();
				if(requestURL.equals("/front-end/movie/listComments_ByMovieno.jsp") || requestURL.equals("/front-end/movie/listAllMovie.jsp"))
					req.setAttribute("listComments_ByMovieno",movieSvc.getCommentsByMovieno(commentVO.getMovieno())); // 資料庫取出的list物件,存入request
				
				if(requestURL.equals("/front-end/comment/listComments_ByCompositeQuery.jsp")){
					HttpSession session = req.getSession();
					Map<String, String[]> map = (Map<String, String[]>)session.getAttribute("map");
					List<CommentVO> list  = commentSvc.getAll(map);
					req.setAttribute("listComments_ByCompositeQuery",list); //  複合查詢, 資料庫取出的list物件,存入request
				}
				System.out.println(requestURL);
				String url = requestURL;
				RequestDispatcher successView = req.getRequestDispatcher(url); // 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
			}
		}
		
		if ("listComments_ByCompositeQuery".equals(action)) { // 來自select_page.jsp的複合查詢請求
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				
				/***************************1.將輸入資料轉為Map**********************************/ 
				//採用Map<String,String[]> getParameterMap()的方法 
				//注意:an immutable java.util.Map 
				//Map<String, String[]> map = req.getParameterMap();
				HttpSession session = req.getSession();
				Map<String, String[]> map = (Map<String, String[]>)session.getAttribute("map");
				
				// 以下的 if 區塊只對第一次執行時有效
				if (req.getParameter("whichPage") == null){
					Map<String, String[]> map1 = new HashMap<String, String[]>(req.getParameterMap());
					session.setAttribute("map",map1);
					map = map1;
				} 
				
				/***************************2.開始複合查詢***************************************/
				CommentService commentSvc = new CommentService();
				List<CommentVO> list  = commentSvc.getAll(map);
				
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("listComments_ByCompositeQuery", list); // 資料庫取出的list物件,存入request
				RequestDispatcher successView = req.getRequestDispatcher("/front-end/comment/listComments_ByCompositeQuery.jsp"); // 成功轉交listEmps_ByCompositeQuery.jsp
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/comment/select_comment_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		
//電影連結評論		
//			if ("getThisMovieComment".equals(action)) { // 來自select_comment_page.jsp的請求 //比對寫在前面 所小除錯範圍
//
//			List<String> errorMsgs = new LinkedList<String>();
//			req.setAttribute("errorMsgs", errorMsgs);
//
//			try {
//				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
//				Integer movieno = new Integer(req.getParameter("thisMovieComments"));
//				/*************************** 2.開始查詢資料 *****************************************/
//				CommentService commentSvc = new CommentService();
//				List<CommentVO> list= commentSvc.getOneMovieComment(movieno);
//				if (list == null) {
//					errorMsgs.add("查無資料");
//				}
//				if (!errorMsgs.isEmpty()) {
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/front-end/movie/select_movie_page.jsp");
//					failureView.forward(req, res);
//					return;// 程式中斷
//				}
//				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
//				req.setAttribute("list", list); // 資料庫取出的commentVO物件,存入req
//				String url = "/front-end/comment/listOneComment.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneComment.jsp
//				successView.forward(req, res);
//
//				/***************************其他可能的錯誤處理*************************************/
//			} catch (Exception e) {
//				errorMsgs.add("無法取得資料:" + e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher("/front-end/movie/select_movie_page.jsp");
//				failureView.forward(req, res);
//			}
//		}
	}
}
