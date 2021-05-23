package com.rating.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.rating.model.*;
import com.comment.model.CommentService;
import com.comment.model.CommentVO;
import com.movie.model.*;

public class RatingServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		res.setContentType("text/html; charset=UTF-8");
		String action = req.getParameter("action");
		
		
		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str1 = req.getParameter("memberno");
				if (str1 == null || (str1.trim()).length() == 0) {
					errorMsgs.add("請輸入會員編號");
				}
				
				String str2 = req.getParameter("movieno");
				if (str2 == null || (str2.trim()).length() == 0) {
					errorMsgs.add("請輸入電影編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/index.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer memberno = null;
				try {
					memberno = new Integer(str1);
				} catch (Exception e) {
					errorMsgs.add("會員編號格式不正確");
				}
				
				Integer movieno = null;
				try {
					movieno = new Integer(str2);
				} catch (Exception e) {
					errorMsgs.add("電影編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/index.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				RatingService ratingSvc = new RatingService();
				RatingVO ratingVO = ratingSvc.getOneRating(memberno,movieno);
				if (ratingVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/index.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("ratingVO", ratingVO); // 資料庫取出的ratingVO物件,存入req
				String url = "/front-end/rating/listOneRating.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交listOneRating.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/index.jsp");
				failureView.forward(req, res);
			}
		}
		
		
//		if ("getOne_For_Update".equals(action)) { // 來自listAllEmp.jsp 或  /dept/listEmps_ByDeptno.jsp 的請求
//
//			List<String> errorMsgs = new LinkedList<String>();
//			// Store this set in the request scope, in case we need to
//			// send the ErrorPage view.
//			req.setAttribute("errorMsgs", errorMsgs);
//			
//			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/emp/listAllEmp.jsp】 或  【/dept/listEmps_ByDeptno.jsp】 或 【 /dept/listAllDept.jsp】		
//			
//			try {
//				/***************************1.接收請求參數****************************************/
//				Integer memberno = new Integer(req.getParameter("memberno"));
//				Integer movieno = new Integer(req.getParameter("movieno"));
//				
//				/***************************2.開始查詢資料****************************************/
//				RatingService ratingSvc = new RatingService();
//				RatingVO ratingVO = ratingSvc.getOneRating(memberno,movieno);
//								
//				/***************************3.查詢完成,準備轉交(Send the Success view)************/
//				req.setAttribute("ratingVO", ratingVO); // 資料庫取出的ratingVO物件,存入req
//				String url = "/front-end/ratting/update_ratting_input.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交update_ratting_input.jsp
//				successView.forward(req, res);
//
//				/***************************其他可能的錯誤處理************************************/
//			} catch (Exception e) {
//				errorMsgs.add("修改資料取出時失敗:"+e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher(requestURL);
//				failureView.forward(req, res);
//			}
//		}
//		
//		
//		if ("update".equals(action)) { // 來自update_emp_input.jsp的請求
//			
//			List<String> errorMsgs = new LinkedList<String>();
//			// Store this set in the request scope, in case we need to
//			// send the ErrorPage view.
//			req.setAttribute("errorMsgs", errorMsgs);
//			
//			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/emp/listAllEmp.jsp】 或  【/dept/listEmps_ByDeptno.jsp】 或 【 /dept/listAllDept.jsp】
//		
//			try {
//				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
//				Integer memberno = new Integer(req.getParameter("memberno").trim());
//				
//				Integer movieno = new Integer(req.getParameter("movieno").trim());
//				
//				Double rating = new Double(req.getParameter("rating").trim());
//
//				RatingVO ratingVO = new RatingVO();
//				ratingVO.setMemberno(memberno);
//				ratingVO.setMovieno(movieno);
//				ratingVO.setRating(rating);				
//
//				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//					req.setAttribute("ratingVO", ratingVO); // 含有輸入格式錯誤的empVO物件,也存入req
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/front-end/ratting/update_ratting_input.jsp");
//					failureView.forward(req, res);
//					return; //程式中斷
//				}
//				
//				/***************************2.開始修改資料*****************************************/
//				RatingService ratingSvc = new RatingService();
//				ratingVO = ratingSvc.updateRatingtAndUpdateMovieRating(memberno, movieno, rating);
//				
//				/***************************3.修改完成,準備轉交(Send the Success view)*************/				
////				DeptService deptSvc = new DeptService();
////				if(requestURL.equals("/dept/listEmps_ByDeptno.jsp") || requestURL.equals("/dept/listAllDept.jsp"))
////					req.setAttribute("listEmps_ByDeptno",deptSvc.getEmpsByDeptno(deptno)); // 資料庫取出的list物件,存入request
//
//                String url = requestURL;
//				RequestDispatcher successView = req.getRequestDispatcher(url);   // 修改成功後,轉交回送出修改的來源網頁
//				successView.forward(req, res);
//
//				/***************************其他可能的錯誤處理*************************************/
//			} catch (Exception e) {
//				errorMsgs.add("修改資料失敗:"+e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher("/front-end/rating/update_rating_input.jsp");
//				failureView.forward(req, res);
//			}
//		}

        if ("insertOrUpdate".equals(action)) { // 來自addEmp.jsp的請求  
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			PrintWriter out = res.getWriter();
			
			String requestURL = req.getParameter("requestURL");

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/

				Integer memberno = new Integer(req.getParameter("memberno").trim());
				
				Integer movieno = new Integer(req.getParameter("movieno").trim());
				
				Double rating = new Double(req.getParameter("rating").trim());
				
//				RatingVO ratingVO = new RatingVO();
//				ratingVO.setMemberno(memberno);
//				ratingVO.setMovieno(movieno);
//				ratingVO.setRating(rating);	

				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//					req.setAttribute("ratingVO", ratingVO); // 含有輸入格式錯誤的empVO物件,也存入req
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/front-end/rating/addRating.jsp");
//					failureView.forward(req, res);
//					return;
//				}
				
				/***************************2.開始新增資料***************************************/
				RatingService ratingSvc = new RatingService();
				ratingSvc.insertOrUpdateRatingtAndUpdateMovieRating(memberno , movieno , rating);
				RatingVO ratingVO = ratingSvc.getThisMovieToatalRating(movieno);
				
				//將原本的movievo塞回去
				MovieService movieSvc = new MovieService();
				MovieVO movieVO = movieSvc.getOneMovie(movieno);
				if (movieVO == null) {
					errorMsgs.add("查無資料");
				}
				req.setAttribute("movieVO", movieVO);
				
				//將最新的評分丟回去
				double newRating = movieVO.getRating();
				double countRating = ratingVO.getRating();
				JSONObject jsonobj = new JSONObject();
				try {
					jsonobj.put("newRating", newRating);
					jsonobj.put("countRating", countRating);
					out.print(jsonobj.toString());
					return;
				}catch(JSONException e) {
					e.printStackTrace();
				}finally {
					out.flush();
					out.close();
				}
				/***************************3.新增完成,準備轉交(Send the Success view)***********/

				String url = requestURL;
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/rating/addRating.jsp");
				failureView.forward(req, res);
			}
		}
		
       
		if ("delete".equals(action)) { // 來自listAllEmp.jsp 或  /dept/listEmps_ByDeptno.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			String requestURL = req.getParameter("requestURL"); // 送出刪除的來源網頁路徑: 可能為【/emp/listAllEmp.jsp】 或  【/dept/listEmps_ByDeptno.jsp】 或 【 /dept/listAllDept.jsp】

			try {
				/***************************1.接收請求參數***************************************/
				Integer memberno = new Integer(req.getParameter("memberno").trim());
				
				Integer movieno = new Integer(req.getParameter("movieno").trim());
				
				/***************************2.開始刪除資料***************************************/
				RatingService ratingSvc = new RatingService();
//				RatingVO ratingVO = ratingSvc.getOneRating(memberno,movieno);
				ratingSvc.deleteRating(memberno,movieno);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/
//				DeptService deptSvc = new DeptService();
//				if(requestURL.equals("/dept/listEmps_ByDeptno.jsp") || requestURL.equals("/dept/listAllDept.jsp"))
//					req.setAttribute("listEmps_ByDeptno",deptSvc.getEmpsByDeptno(empVO.getDeptno())); // 資料庫取出的list物件,存入request
				
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
		
//		if ("getThisMovieToatalRating_Ajax".equals(action)) { // 來自select_page.jsp的請求
//
//			List<String> errorMsgs = new LinkedList<String>();
//			// Store this set in the request scope, in case we need to
//			// send the ErrorPage view.
//			req.setAttribute("errorMsgs", errorMsgs);
//			PrintWriter out = res.getWriter();
//
//			try {
//				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
//				String str = req.getParameter("movieno");
//				if (str == null || (str.trim()).length() == 0) {
//					errorMsgs.add("請輸入電影編號");
//				}
//				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/index.jsp");
//					failureView.forward(req, res);
//					return;//程式中斷
//				}
//				
//				Integer movieno = null;
//				try {
//					movieno = new Integer(str);
//				} catch (Exception e) {
//					errorMsgs.add("電影編號格式不正確");
//				}
//				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/index.jsp");
//					failureView.forward(req, res);
//					return;//程式中斷
//				}
//				
//				/***************************2.開始查詢資料*****************************************/
//				RatingService ratingSvc = new RatingService();
//				RatingVO ratingVO = ratingSvc.getThisMovieToatalRating(movieno);
//				
//				if (ratingVO == null) {
//					errorMsgs.add("查無資料");
//				}
//				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/frontend/mem/memberSys.jsp");
//					failureView.forward(req, res);
//					return;//程式中斷
//				}
//
//				double countRating = ratingVO.getRating();
//				JSONObject jsonobj = new JSONObject();
//				try {
//					jsonobj.put("countRating", countRating);
//					out.print(jsonobj.toString());
//					System.out.println(jsonobj.toString());
//					return;
//				}catch(JSONException e) {
//					e.printStackTrace();
//				}finally {
//					out.flush();
//					out.close();
//				}
//				
//				
//				/***************************其他可能的錯誤處理*************************************/
//			} catch (Exception e) {
//				errorMsgs.add("無法取得資料:" + e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher("/frontend/mem/memberSys.jsp");
//				failureView.forward(req, res);
//			}
//		}
	}
}
