package com.like.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.article.model.ArticleService;
import com.article.model.ArticleVO;
import com.like.model.LikeService;
import com.like.model.LikeVO;
import com.movieRating.model.MovieRatingService;
@WebServlet("/LikeServlet")
public class LikeServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		
		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("articleno");
				String str1 = req.getParameter("memberno");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入員工編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/like/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer articleno = null;
				Integer memberno = null;
				try {
					articleno = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("員工編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/like/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				try {
					memberno = new Integer(str1);
				} catch (Exception e) {
					errorMsgs.add("員工編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/like/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				LikeService likeSvc = new LikeService();
				LikeVO likeVO = likeSvc.getOneLike(articleno,memberno);
				if (likeVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/like/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("likeVO", likeVO); // 資料庫取出的articleVO物件,存入req
				String url = "/front-end/like/listOneLike.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneArticle.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/like/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("getOne_For_Update".equals(action)) { // 來自listAllArticle.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數****************************************/
				Integer articleno = new Integer(req.getParameter("articleno"));
				Integer memberno = new Integer(req.getParameter("memberno"));
				/***************************2.開始查詢資料****************************************/
				LikeService likeSvc = new LikeService();
				LikeVO likeVO = likeSvc.getOneLike(articleno,memberno);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("likeVO", likeVO);         // 資料庫取出的articleVO物件,存入req
				String url = "/front-end/like/update_like_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_article_input.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/like/listAllLike.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("update".equals(action)) { // 來自update_article_input.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
		
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
Integer articleno = new Integer(req.getParameter("articleno").trim());

Integer memberno = new Integer(req.getParameter("memberno").trim());


				LikeVO likeVO = new LikeVO();

				likeVO.setArticleno(articleno);
				likeVO.setMemberno(memberno);


				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("likeVO", likeVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/like/update_like_input.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
				LikeService likeSvc = new LikeService();
				likeVO = likeSvc.updateLike(articleno, memberno);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("likeVO", likeVO); // 資料庫update成功後,正確的的articleVO物件,存入req
				String url = "/front-end/like/listOneLike.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOnearticle.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/like/update_like_input.jsp");
				failureView.forward(req, res);
			}
		}
        if("insert_Ajax".contentEquals(action)) {
        	List<String> errorMsgs = new ArrayList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			PrintWriter out = res.getWriter();
			try {
				
				Integer articleno = new Integer(req.getParameter("articleno").trim());
				Integer memberno = new Integer(req.getParameter("memberno").trim());
				
				LikeService likeSvc = new LikeService();
				likeSvc.addLike(articleno, memberno);
				
				out.print("success");
			}catch(Exception e) {
				out.print("fail");
				errorMsgs.add("文章點讚修改失敗");
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/mem/memberSys.jsp");
				failureView.forward(req, res);
			}finally {
				out.flush();
				out.close();
			}
        	
        }
        if ("insert".equals(action)) { // 來自addArticle.jsp的請求  
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			String requestURL = req.getParameter("requestURL");
			
			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				Integer articleno = null;
				try {
articleno = new Integer(req.getParameter("articleno").trim());
				} catch (NumberFormatException e) {
					articleno = 0;
					errorMsgs.add("文章編號請填數字.");
				}

				Integer memberno = null;
				try {
memberno = new Integer(req.getParameter("memberno").trim());
				} catch (NumberFormatException e) {
					memberno = 0;
					errorMsgs.add("會員編號請填數字.");
				}
				
				LikeVO likeVO = new LikeVO();

				likeVO.setArticleno(articleno);
				likeVO.setMemberno(memberno);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("likeVO", likeVO); // 含有輸入格式錯誤的articleVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/like/addLike.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				LikeService likeSvc = new LikeService();
				likeVO = likeSvc.addLike(articleno,memberno);				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
//				String url = "/front-end/like/listAllLike.jsp";
				String url = requestURL;
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllArticle.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/like/addLike.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("delete".equals(action)) { // 來自listAllArticle.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
	
			try {
				/***************************1.接收請求參數***************************************/
				Integer articleno = new Integer(req.getParameter("articleno"));
				Integer memberno = new Integer(req.getParameter("memberno"));
				/***************************2.開始刪除資料***************************************/
				LikeService likeSvc = new LikeService();
				likeSvc.deleteLike(articleno, memberno);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				String url = "/front-end/like/listAllLike.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/like/listAllLike.jsp");
				failureView.forward(req, res);
			}
		}
	}
}
