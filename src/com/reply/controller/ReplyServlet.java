package com.reply.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import com.article.model.ArticleService;
import com.reply.model.ReplyDAO;
import com.reply.model.ReplyService;
import com.reply.model.ReplyVO;

public class ReplyServlet extends HttpServlet {

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
				String str = req.getParameter("reply_no");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入回復編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/reply/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer reply_no = null;
				try {
					reply_no = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("回復編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/reply/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				ReplyService replySvc = new ReplyService();
				ReplyVO replyVO = replySvc.getOneReply(reply_no);
				if (replyVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/reply/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("replyVO", replyVO); // 資料庫取出的replyVO物件,存入req
				String url = "/front-end/reply/listOneReply.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneArticle.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/reply/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("getOne_For_Update".equals(action)) { // 來自listAllArticle.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/emp/listAllEmp.jsp】 或  【/dept/listEmps_ByDeptno.jsp】 或 【 /dept/listAllDept.jsp】	
			
			try {
				/***************************1.接收請求參數****************************************/
				Integer reply_no = new Integer(req.getParameter("reply_no"));
				/***************************2.開始查詢資料****************************************/
				ReplyService replySvc = new ReplyService();
				ReplyVO replyVO = replySvc.getOneReply(reply_no);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("replyVO", replyVO);         // 資料庫取出的articleVO物件,存入req
				String url = "/front-end/reply/update_reply_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_article_input.jsp
				successView.forward(req, res);
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
			}
		}
		
		
		if ("update".equals(action)) { // 來自update_article_input.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
		
			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/emp/listAllEmp.jsp】 或  【/dept/listEmps_ByDeptno.jsp】 或 【 /dept/listAllDept.jsp】
			
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
Integer reply_no = new Integer(req.getParameter("reply_no").trim());

Integer article_no = new Integer(req.getParameter("articleno").trim());


//Integer member_no = 1;
Integer member_no = new Integer(req.getParameter("member_no").trim());
//				Integer memberno = null;
//				try {
//memberno = new Integer(req.getParameter("memberno").trim());
//				} catch (NumberFormatException e) {
//					memberno = 0;
//					errorMsgs.add("會員編號請填數字.");
//				}
				
				
String content = req.getParameter("content").trim();
				if (content == null || content.trim().length() == 0) {
					errorMsgs.add("回覆內容請勿空白");
				}					
				
				java.sql.Timestamp crt_dt = null;
//				try {
//crt_dt = java.sql.Timestamp.valueOf(req.getParameter("crt_dt").trim());
//				} catch (IllegalArgumentException e) {
//					crt_dt = new java.sql.Timestamp(System.currentTimeMillis());
//					errorMsgs.add("請輸入日期!");
//				}

				java.sql.Timestamp modify_dt = null;
//				try {
//modify_dt = java.sql.Timestamp.valueOf(req.getParameter("modify_dt").trim());
//				} catch (IllegalArgumentException e) {
//					modify_dt = new java.sql.Timestamp(System.currentTimeMillis());
//					errorMsgs.add("請輸入日期!");
//				}
				modify_dt = new java.sql.Timestamp(System.currentTimeMillis());;

Integer status =0;				
//Integer status = new Integer(req.getParameter("status").trim());
				

//				Integer status = null;
//				try {
//status = new Integer(req.getParameter("status").trim());
//				} catch (NumberFormatException e) {
//					status = 0;
//					errorMsgs.add("文章狀態請填數字.");
//				}
//				
//				Integer likecount = null;
//				try {
//likecount = new Integer(req.getParameter("likecount").trim());
//				} catch (NumberFormatException e) {
//					likecount = 0;
//					errorMsgs.add("文章讚數請填數字.");
//				}


				ReplyVO replyVO = new ReplyVO();

				replyVO.setReply_no(reply_no);
				replyVO.setArticle_no(article_no);
				replyVO.setMember_no(member_no);
				replyVO.setContent(content);
				replyVO.setCrt_dt(crt_dt);
				replyVO.setModify_dt(modify_dt);
				replyVO.setStatus(status);			
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("replyVO", replyVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/reply/update_reply_input.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				
		
		
				/***************************2.開始修改資料*****************************************/
				ReplyService replySvc = new ReplyService();
				replyVO = replySvc.updateArticle(reply_no, article_no, member_no, content, crt_dt, modify_dt, status);
				
		
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
//				req.setAttribute("replyVO", replyVO); // 資料庫update成功後,正確的的ReplyVO物件,存入req
//				String url = "/reply/listOneReply.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneReply.jsp
//				successView.forward(req, res);
				ArticleService articleSvc = new ArticleService();
				if(requestURL.equals("/front-end/article/listReplys_ByArticleno.jsp") || requestURL.equals("/front-end/article/listAllArticle.jsp"))
					req.setAttribute("listReplys_ByArticleno",articleSvc.getReplysByArticleno(article_no)); // 資料庫取出的list物件,存入request
				
				//requestURL = /front-end/article/listOneArticle2.jsp
                String url = requestURL;
				RequestDispatcher successView = req.getRequestDispatcher(url);   // 修改成功後,轉交回送出修改的來源網頁
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/reply/update_reply_input.jsp");
				failureView.forward(req, res);
			}
		}

        if ("insert".equals(action)) { // 來自addReply.jsp的請求  
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
//Integer reply_no = new Integer(req.getParameter("reply_no").trim());

				Integer article_no = null;
				try {
article_no = new Integer(req.getParameter("article_no").trim());
				} catch (NumberFormatException e) {
					article_no = 0;
					errorMsgs.add("回復編號請填數字.");
				}
				Integer member_no = null;
				try {
member_no = new Integer(req.getParameter("member_no").trim());
			} catch (NumberFormatException e) {
				member_no = 0;
				errorMsgs.add("會員編號請填數字.");
			}
				
String content = req.getParameter("content").trim();
				if (content == null || content.trim().length() == 0) {
					errorMsgs.add("內容類型請勿空白");
				}	
				
				java.sql.Timestamp crt_dt = new java.sql.Timestamp(System.currentTimeMillis());
//				try {
//crt_dt = java.sql.Timestamp.valueOf(req.getParameter("crt_dt").trim());
//				} catch (IllegalArgumentException e) {
//					crt_dt = new java.sql.Timestamp(System.currentTimeMillis());
//					errorMsgs.add("請輸入日期!");
//				}

				java.sql.Timestamp modify_dt = null;
//				try {
//modify_dt = java.sql.Timestamp.valueOf(req.getParameter("modify_dt").trim());
//				} catch (IllegalArgumentException e) {
//					modify_dt = new java.sql.Timestamp(System.currentTimeMillis());
//					errorMsgs.add("請輸入日期!");
//				}

				Integer status = 0;
//				try {
//status = new Integer(req.getParameter("status").trim());
//				} catch (NumberFormatException e) {
//					status = 0;
//					errorMsgs.add("文章狀態請填數字.");
//				}

				
				ReplyVO replyVO = new ReplyVO();

//				articleVO.setArticleno(reply_no);
				replyVO.setArticle_no(article_no);
				replyVO.setMember_no(member_no);
				replyVO.setContent(content);
				replyVO.setCrt_dt(crt_dt);
				replyVO.setModify_dt(modify_dt);
				replyVO.setStatus(status);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("replyVO", replyVO); // 含有輸入格式錯誤的articleVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/reply/addReply.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				ReplyService replySvc = new ReplyService();
				replyVO = replySvc.addArticle(article_no,member_no ,content, crt_dt, modify_dt,status);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
//				String url = "/reply/listAllReply.jsp";
				String url = "/front-end/article/listOneArticle2.jsp?articleno=" + article_no;				
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllArticle.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/reply/addReply.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("delete".equals(action)) { // 來自listAllArticle.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			String requestURL = req.getParameter("requestURL"); // 送出刪除的來源網頁路徑: 可能為【/emp/listAllEmp.jsp】 或  【/dept/listEmps_ByDeptno.jsp】 或 【 /dept/listAllDept.jsp】 或 【 /emp/listEmps_ByCompositeQuery.jsp】
			
			try {
				/***************************1.接收請求參數***************************************/
				Integer reply_no = new Integer(req.getParameter("reply_no"));
				
				/***************************2.開始刪除資料***************************************/
				ReplyService replySvc = new ReplyService();
				ReplyVO replyVO = replySvc.getOneReply(reply_no);
				replySvc.deleteReply(reply_no);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				ArticleService articleSvc = new ArticleService();
				if(requestURL.equals("/front-end/article/listReplys_ByArticleno.jsp") || requestURL.equals("/front-end/article/listAllArticle.jsp"))
					req.setAttribute("listReplys_ByArticleno",articleSvc.getReplysByArticleno(replyVO.getArticle_no())); // 資料庫取出的list物件,存入request
				
//				if(requestURL.equals("/reply/listReplys_ByCompositeQuery.jsp")){
//					HttpSession session = req.getSession();
//					Map<String, String[]> map = (Map<String, String[]>)session.getAttribute("map");
//					List<replyVO> list  = replySvc.getAll(map);
//					req.setAttribute("listEmps_ByCompositeQuery",list); //  複合查詢, 資料庫取出的list物件,存入request
//				}
				
				String url = requestURL;
				RequestDispatcher successView = req.getRequestDispatcher(url); // 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/reply/listAllReply.jsp");
				failureView.forward(req, res);
			}		
		}
		if ("listReplys_ByCompositeQuery".equals(action)) { // 來自select_page.jsp的複合查詢請求
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
				ReplyService replySvc = new ReplyService();
				List<ReplyVO> list  = replySvc.getAll(map);
				
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("listReplys_ByCompositeQuery", list); // 資料庫取出的list物件,存入request
				RequestDispatcher successView = req.getRequestDispatcher("/front-end/reply/listReplys_ByCompositeQuery.jsp"); // 成功轉交listEmps_ByCompositeQuery.jsp
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/reply/select_page.jsp");
				failureView.forward(req, res);
			}
		}
	}
}
