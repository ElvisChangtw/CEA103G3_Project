//01版 只有查詢

package com.report_comment.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import org.json.JSONException;
import org.json.JSONObject;

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
		
		if ("getAllOrderByReportno".equals(action)) {
			/***************************開始查詢資料 ****************************************/
			ReportCommentService reportCommentSvc = new ReportCommentService();
			List<ReportCommentVO> list= reportCommentSvc.getAllOrderByReportno();

			/***************************查詢完成,準備轉交(Send the Success view)*************/
			HttpSession session = req.getSession();
			session.setAttribute("list", list);    // 資料庫取出的list物件,存入session
			// Send the Success view
			String url = "/back-end/report_comment/listAllReportComment.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交listAllComment2_getFromSession.jsp
			successView.forward(req, res);
			return;
		}


		if ("insert".equals(action)) { // 來自addComment.jsp的請求  

			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			PrintWriter out = res.getWriter();
			
//			String requestURL = req.getParameter("requestURL");

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/

				Integer commentno = new Integer(req.getParameter("commentno"));
		
				String content = req.getParameter("content").trim();
				if (content == null || content.trim().length() == 0) {
					errorMsgs.put("content","檢舉原因請勿空白");
				}

				Integer memberno = new Integer(req.getParameter("memberno").trim());

				ReportCommentVO reportCommentVO = new ReportCommentVO();
				
				reportCommentVO.setCommentno(commentno);
				reportCommentVO.setContent(content);
				reportCommentVO.setMemberno(memberno);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("reportCommentVO", reportCommentVO);

					int problem= 1;
					JSONObject jsonobj = new JSONObject();
					try {
						jsonobj.put("problem",problem);
						out.print(jsonobj.toString());
						return;
					}catch(JSONException e) {
						e.printStackTrace();
					}finally {
						out.flush();
						out.close();
					}
				
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/front-end/report_comment/addReportComment.jsp");
//					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				ReportCommentService reportCommentSvc = new ReportCommentService();
				reportCommentVO = reportCommentSvc.addReportComment(commentno, content, memberno);
				
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
				
//				//將最新的期待度丟回去
				int problem= 0;
				JSONObject jsonobj = new JSONObject();
				try {
					jsonobj.put("problem",problem);
					out.print(jsonobj.toString());
					return;
				}catch(JSONException e) {
					e.printStackTrace();
				}finally {
					out.flush();
					out.close();
				}
				
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
//				String url = requestURL;
//				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉回原本頁面
//				successView.forward(req, res);	
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/report_comment/addReportComment.jsp");
				failureView.forward(req, res);
			}
		}
		 
		 
		if ("getOne_For_Update".equals(action)) { // 來自listAllComment.jsp的請求  或  /movie/listComments_ByMovieno.jsp 的請求
			
			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/comment/listAllComment.jsp】 或  【/movie/listComments_ByMovieno.jsp】 或 【 /movie/listAllMovie.jsp】		
			try {
				/***************************1.接收請求參數****************************************/
				Integer reportno = new Integer(req.getParameter("reportno"));
				/***************************2.開始查詢資料****************************************/
				ReportCommentService reportCommentSvc = new ReportCommentService();
				ReportCommentVO reportCommentVO = reportCommentSvc.getOneReportComment(reportno);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("reportCommentVO", reportCommentVO);       
				String url = "/back-end/report_comment/update_reportcomment_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
	
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception","無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
			}
		}
		
		if ("update".equals(action)) { // 來自update_comment_input.jsp的請求
			
			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/comment/listAllComment.jsp】 或  【/movie/listComments_ByMovieno.jsp】 或 【 /movie/listAllMovie.jsp】		
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				Integer reportno = new Integer(req.getParameter("reportno").trim());
				
				Integer commentno = new Integer(req.getParameter("commentno").trim());
				
				Integer memberno = new Integer(req.getParameter("memberno").trim());
				
				String content = req.getParameter("content").trim();
				
				java.sql.Timestamp creatdate = null;
				try {
					creatdate = java.sql.Timestamp.valueOf(req.getParameter("creatdate").trim());
				} catch (Exception e) {
					creatdate = null;
				}
			
				java.sql.Timestamp executedate = null;
				try {
					executedate = java.sql.Timestamp.valueOf(req.getParameter("executedate").trim());
				} catch (Exception e) {
					executedate = null;
				}
				
				String status = req.getParameter("status").trim();
				if (status == null || status.trim().length() == 0) {
					errorMsgs.put("status", "處理狀態請勿空白");// 給input type="TEXT"用的
				} else if (status.equals("9")) {
					errorMsgs.put("status", "請選擇處理狀態");// 給select下拉式選單低一個留空白用的
				}	
				
				String desc = "";
				if (req.getParameter("desc") == null || req.getParameter("desc").trim().length() == 0) {
					desc = null;
				}else {
					desc = req.getParameter("desc").trim();
				}

				ReportCommentVO reportCommentVO = new ReportCommentVO();
				reportCommentVO.setReportno(reportno);		
				reportCommentVO.setCommentno(commentno);
				reportCommentVO.setMemberno(memberno);
				reportCommentVO.setContent(content);
				reportCommentVO.setCreatdate(creatdate);
				reportCommentVO.setExecutedate(executedate);
				reportCommentVO.setStatus(status);
				reportCommentVO.setDesc(desc);
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("reportCommentVO", reportCommentVO); // 含有輸入格式錯誤的commentVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/report_comment/update_reportcomment_input.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
				ReportCommentService reportCommentSvc = new ReportCommentService();
				reportCommentSvc.updateAllReportFromThisComment(commentno, status, desc);

				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				String url = requestURL;
				RequestDispatcher successView = req.getRequestDispatcher(url);   // 修改成功後,轉交回送出修改的來源網頁
				successView.forward(req, res);


				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/report_comment/update_reportcomment_input.jsp");
				failureView.forward(req, res);
			}
		}
		 
	}
}
