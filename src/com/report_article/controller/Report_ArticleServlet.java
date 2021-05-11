package com.report_article.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import com.report_article.model.Report_ArticleService;
import com.report_article.model.Report_ArticleVO;

public class Report_ArticleServlet extends HttpServlet {

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
				String str = req.getParameter("reportno");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入員工編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/report_article/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer reportno = null;
				try {
					reportno = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("員工編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/report_article/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				Report_ArticleService report_articleSvc = new Report_ArticleService();
				Report_ArticleVO report_articleVO = report_articleSvc.getOneReport_Article(reportno);
				if (report_articleVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/report_article/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("report_articleVO", report_articleVO); // 資料庫取出的articleVO物件,存入req
				String url = "/back-end/report_article/listOneReport_Article.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneArticle.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/report_article/select_page.jsp");
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
				Integer reportno = new Integer(req.getParameter("reportno"));
				
				/***************************2.開始查詢資料****************************************/
				Report_ArticleService report_articleServiceSvc = new Report_ArticleService();
				Report_ArticleVO report_articleVO = report_articleServiceSvc.getOneReport_Article(reportno);			
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("report_articleVO", report_articleVO);         // 資料庫取出的articleVO物件,存入req
				String url = "/back-end/report_article/update_report_article_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_article_input.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/report_article/listAllReport_Article.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("update".equals(action)) { // 來自update_report_article_input.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
		
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
Integer reportno = new Integer(req.getParameter("reportno").trim());

Integer articleno = new Integer(req.getParameter("articleno").trim());
								
String content = req.getParameter("content").trim();
				if (content == null || content.trim().length() == 0) {
					errorMsgs.add("文章類型請勿空白");
				}	

				java.sql.Timestamp crtdt = null;
				try {
crtdt = java.sql.Timestamp.valueOf(req.getParameter("crtdt").trim());
				} catch (IllegalArgumentException e) {
					crtdt = new java.sql.Timestamp(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}

Integer memberno = new Integer(req.getParameter("memberno").trim());
				
				java.sql.Timestamp executedt = null;
				try {
executedt = java.sql.Timestamp.valueOf(req.getParameter("executedt").trim());
				} catch (IllegalArgumentException e) {
					executedt = new java.sql.Timestamp(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}
			
Integer status = new Integer(req.getParameter("status").trim());
				
String desc = req.getParameter("desc").trim();
				if (desc == null || desc.trim().length() == 0) {
					errorMsgs.add("文章類型請勿空白");
				}

				Report_ArticleVO report_articleVO = new Report_ArticleVO();

				report_articleVO.setReportno(reportno);
				report_articleVO.setArticleno(articleno);
				report_articleVO.setContent(content);
				report_articleVO.setCrtdt(crtdt);
				report_articleVO.setMemberno(memberno);
				report_articleVO.setExecutedt(executedt);
				report_articleVO.setStatus(status);
				report_articleVO.setDesc(desc);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("report_articleVO", report_articleVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/report_article/update_report_article_input.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
				Report_ArticleService report_articleSvc = new Report_ArticleService();
				report_articleVO = report_articleSvc.updateReport_Article(reportno, articleno, content, crtdt, memberno, executedt, status, desc);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("report_articleVO", report_articleVO); // 資料庫update成功後,正確的的articleVO物件,存入req
				String url = "/back-end/report_article/listOneReport_Article.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOnearticle.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/report_article/update_report_article_input.jsp");
				failureView.forward(req, res);
			}
		}

        if ("insert".equals(action)) { // 來自addArticle.jsp的請求  
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				
				Integer articleno = null;
				try {
articleno = new Integer(req.getParameter("articleno").trim());
				} catch (NumberFormatException e) {
					articleno = 0;
					errorMsgs.add("文章編號請填數字.");
				}
String content = req.getParameter("content").trim();
				if (content == null || content.trim().length() == 0) {
					errorMsgs.add("檢舉類型請勿空白");
				}	
				java.sql.Timestamp crtdt = null;
				try {
crtdt = java.sql.Timestamp.valueOf(req.getParameter("crtdt").trim());
				} catch (IllegalArgumentException e) {
					crtdt = new java.sql.Timestamp(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}
								
				Integer memberno = null;
				try {
memberno = new Integer(req.getParameter("memberno").trim());
				} catch (NumberFormatException e) {
					memberno = 0;
					errorMsgs.add("會員編號請填數字.");
				}
				
				java.sql.Timestamp executedt = null;
				try {
executedt = java.sql.Timestamp.valueOf(req.getParameter("executedt").trim());
				} catch (IllegalArgumentException e) {
					executedt = new java.sql.Timestamp(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				
				}	

				Integer status = null;
				try {
status = new Integer(req.getParameter("status").trim());
				} catch (NumberFormatException e) {
					status = 0;
					errorMsgs.add("文章狀態請填數字.");
				}
				
String desc = req.getParameter("desc").trim();
				if (desc == null || desc.trim().length() == 0) {
					errorMsgs.add("文章標題請勿空白");
				}
				

				Report_ArticleVO report_articleVO = new Report_ArticleVO();
				
				report_articleVO.setArticleno(articleno);
				report_articleVO.setContent(content);
				report_articleVO.setCrtdt(crtdt);
				report_articleVO.setMemberno(memberno);				
				report_articleVO.setExecutedt(executedt);
				report_articleVO.setStatus(status);
				report_articleVO.setDesc(desc);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("report_articleVO", report_articleVO); // 含有輸入格式錯誤的articleVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/report_article/addReport_Article.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				Report_ArticleService report_articleSvc = new Report_ArticleService();
				report_articleVO = report_articleSvc.addReport_Article(articleno, content, crtdt, memberno, executedt, status, desc);				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/back-end/report_article/listAllReport_Article.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllArticle.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/report_article/addReport_Article.jsp");
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
				Integer reportno = new Integer(req.getParameter("reportno"));
				
				/***************************2.開始刪除資料***************************************/
				Report_ArticleService report_articleSvc = new Report_ArticleService();
				report_articleSvc.deleteReport_ArticleVO(reportno);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				String url = "/back-end/report_article/listAllReport_Article.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/report_article/listAllReport_Article.jsp");
				failureView.forward(req, res);
			}
		}
	}
}
