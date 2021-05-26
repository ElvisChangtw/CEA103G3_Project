package com.comment.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import com.comment.model.*;
import com.expectation.model.ExpectationService;
import com.expectation.model.ExpectationVO;
import com.movie.model.*;
import com.rating.model.RatingService;
import com.rating.model.RatingVO;
import com.mem.model.*;



public class CommentServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		res.setContentType("text/html; charset=UTF-8");
		String action = req.getParameter("action");

//		if ("getAll".equals(action)) {
//			/***************************開始查詢資料 ****************************************/
//			CommentService commentSvc = new CommentService();
//			List<CommentVO> list= commentSvc.getAll();
//			
//			/***************************查詢完成,準備轉交(Send the Success view)*************/
//			HttpSession session = req.getSession();
//			session.setAttribute("list", list);    // 資料庫取出的list物件,存入session
//			// Send the Success view
//			String url = "/front-end/comment/listAllComment.jsp";
//			RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交listAllComment2_getFromSession.jsp
//			successView.forward(req, res);
//			return;
//		}


		if ("getOne_For_Display".equals(action)) { // 來自select_comment_page.jsp的請求 //比對寫在前面 所小除錯範圍

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				Integer commentno = new Integer(req.getParameter("commentno"));
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/index.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/index.jsp");
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
							.getRequestDispatcher("/index.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
//				MovieService movieSvc = new MovieService();
//				MovieVO movieVO = movieSvc.getOneMovie(commentVO.getMovieno());
//				req.setAttribute("movieVO", movieVO);
//				
//				RatingService ratingSvc = new RatingService();
//				RatingVO ratingCount = ratingSvc.getThisMovieToatalRating(commentVO.getMovieno());
//				req.setAttribute("ratingCount", ratingCount);
//
//				ExpectationService expectationSvc = new ExpectationService();
//				ExpectationVO expectationCount = expectationSvc.getThisMovieToatalExpectation(commentVO.getMovieno());
//				req.setAttribute("expectationCount", expectationCount);
//				
//				Integer openModal=0;
//				req.setAttribute("openModal",openModal );
				
				
				req.setAttribute("commentVO", commentVO); // 資料庫取出的commentVO物件,存入req
				String url = "/front-end/comment/listOneComment.jsp";
//				String url = "/front-end/movie/listOneMovie.jsp";
				
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneComment.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/index.jsp");
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
				req.setAttribute("movieVO", movieVO);
				
				RatingService ratingSvc = new RatingService();
				RatingVO ratingCount = ratingSvc.getThisMovieToatalRating(commentVO.getMovieno());
				req.setAttribute("ratingCount", ratingCount);

				ExpectationService expectationSvc = new ExpectationService();
				ExpectationVO expectationCount = expectationSvc.getThisMovieToatalExpectation(commentVO.getMovieno());
				req.setAttribute("expectationCount", expectationCount);
				
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
				MemService memSvc = new MemService();
				MemVO memVO = memSvc.getOneMem(memberno);
				String isMovieReview = memVO.getMb_level();
				if(!isMovieReview.equals("2")) {
					errorMsgs.add("只有影評可以寫評論~你只是個會員 懂?");
				}
				
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
					req.setAttribute("commentVO", commentVO);
					
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
				CommentService commentSvc = new CommentService();
				commentVO = commentSvc.addComment(memberno, movieno, content ,status);
				
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
//				if(requestURL.equals("/front-end/movie/listComments_ByMovieno.jsp") || requestURL.equals("/front-end/movie/listAllMovie.jsp"))
//					req.setAttribute("listComments_ByMovieno",movieSvc.getCommentsByMovieno(commentVO.getMovieno())); // 資料庫取出的list物件,存入request
//				
//				if(requestURL.equals("/front-end/comment/listComments_ByCompositeQuery.jsp")){
//					HttpSession session = req.getSession();
//					Map<String, String[]> map = (Map<String, String[]>)session.getAttribute("map");
//					List<CommentVO> list  = commentSvc.getAll(map);
//					req.setAttribute("listComments_ByCompositeQuery",list); //  複合查詢, 資料庫取出的list物件,存入request
//				}

				if(requestURL.equals("/front-end/movie/listOneMovie.jsp")){
					req.setAttribute("listComments_ByMovieno",movieSvc.getCommentsByMovieno(commentVO.getMovieno())); // 資料庫取出的list物件,存入request
					MovieVO movieVO = movieSvc.getOneMovie(commentVO.getMovieno());
					req.setAttribute("movieVO", movieVO);
			
					RatingService ratingSvc = new RatingService();
					RatingVO ratingCount = ratingSvc.getThisMovieToatalRating(commentVO.getMovieno());
					req.setAttribute("ratingCount", ratingCount);

					ExpectationService expectationSvc = new ExpectationService();
					ExpectationVO expectationCount = expectationSvc.getThisMovieToatalExpectation(commentVO.getMovieno());
					req.setAttribute("expectationCount", expectationCount);
				}

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
				Integer memberno = new Integer(req.getParameter("MEMBER_NO").trim());
				MemVO memVO = new MemService().getOneMem(memberno);
				req.setAttribute("memVO", memVO);
				
				req.setAttribute("listComments_ByCompositeQuery", list); // 資料庫取出的list物件,存入request
				RequestDispatcher successView = req.getRequestDispatcher("/front-end/comment/listComments_ByCompositeQuery.jsp"); // 成功轉交listEmps_ByCompositeQuery.jsp
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/movie/error.jsp");
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
		
		
		if("delete_for_Ajax".equals(action)) {
			List<String> errorMsgs = new ArrayList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			PrintWriter out = res.getWriter();
			try {
				int comment_no = new Integer(req.getParameter("comment_no"));
				CommentService commSvc = new CommentService();
				commSvc.deleteComment(comment_no);
				out.print("success");

			}
			catch(Exception e) {
				out.print("fail");
				errorMsgs.add("評論刪除失敗");
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/mem/memberSys.jsp");
				failureView.forward(req, res);
			}finally {
				out.flush();
				out.close();
			}
		}


if ("getOne_For_Display_Ajax".equals(action)) { 

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			PrintWriter out = res.getWriter();
			try {
				System.out.println("1");
				
				System.out.println("2");
				String comment_content = req.getParameter("comment_content");
				System.out.println("3");
				int comment_no = new Integer(req.getParameter("comment_no"));
				System.out.println(comment_no);
				System.out.println(comment_content);

				CommentService commentSvc = new CommentService();
				CommentVO commVO = commentSvc.updateComment_bycommentno(comment_no, comment_content); 
				if (commVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {

					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/mem/memberSys.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}	
				
				try {
					System.out.println("2");
					out.print("success");
					return;
				}catch(Exception e) {
					out.print("fail");
					e.printStackTrace();
				}finally {
					out.flush();
					out.close();
				}

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/mem/memberSys.jsp");
				failureView.forward(req, res);
			}
		}
	}
}
