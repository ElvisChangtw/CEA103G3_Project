package com.topic.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import com.article.model.ArticleVO;
import com.topic.model.TopicService;
import com.topic.model.TopicVO;

public class TopicServlet extends HttpServlet {

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
				String str = req.getParameter("topicno");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入討論主題編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/topic/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer topicno = null;
				try {
					topicno = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("討論主題編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/topic/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				TopicService topicSvc = new TopicService();
				TopicVO topicVO = topicSvc.getOneTopic(topicno);
				if (topicVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/topic/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("topicVO", topicVO); // 資料庫取出的topicVO物件,存入req
				String url = "/front-end/topic/listOneTopic.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOnetopic.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/topic/select_page.jsp");
				failureView.forward(req, res);
			}
		}
	
		
		if ("getOne_For_Update".equals(action)) { // 來自listAlltopic.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數****************************************/
				Integer topicno = new Integer(req.getParameter("topicno"));
				
				/***************************2.開始查詢資料****************************************/
				TopicService topicSvc = new TopicService();
				TopicVO topicVO = topicSvc.getOneTopic(topicno);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("topicVO", topicVO);         // 資料庫取出的topicVO物件,存入req
				String url = "/front-end/topic/update_topic_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_topic_input.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/topic/listAllTopic.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("update".equals(action)) { // 來自update_topic_input.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
		
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
Integer topicno = new Integer(req.getParameter("topicno").trim());
								
String topic = req.getParameter("topic").trim();
				if (topic == null || topic.trim().length() == 0) {
					errorMsgs.add("文章類型請勿空白");
				}	
				
				TopicVO topicVO = new TopicVO();

				topicVO.setTopicno(topicno);;
				topicVO.setTopic(topic);


				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("topicVO", topicVO); // 含有輸入格式錯誤的topicVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/topic/update_topic_input.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
				TopicService topicSvc = new TopicService();
				topicVO = topicSvc.updateTopic(topicno, topic);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("topicVO", topicVO); // 資料庫update成功後,正確的的topicVO物件,存入req
				String url = "/front-end/topic/listOneTopic.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOnetopic.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/topic/update_topic_input.jsp");
				failureView.forward(req, res);
			}
		}

        if ("insert".equals(action)) { // 來自addtopic.jsp的請求  
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				
String topic = req.getParameter("topic").trim();
				if (topic == null || topic.trim().length() == 0) {
					errorMsgs.add("文章類型請勿空白");
				}									
					
					TopicVO topicVO = new TopicVO();
					topicVO.setTopic(topic);
					
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("topicVO", topicVO); // 含有輸入格式錯誤的topicVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/topic/addTopic.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				TopicService topicSvc = new TopicService();
				topicVO = topicSvc.addTopic(topic);				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/front-end/topic/listAllTopic.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllTopic.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/topic/addTopic.jsp");
				failureView.forward(req, res);
				}
			}
               
		if ("delete".equals(action)) { // 來自listAllTopic.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
	
			try {
				/***************************1.接收請求參數***************************************/
				Integer topicno = new Integer(req.getParameter("topicno"));
				
				/***************************2.開始刪除資料***************************************/
				TopicService topicSvc = new TopicService();
				topicSvc.deleteTopic(topicno);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				String url = "/front-end/topic/listAllTopic.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/topic/listAllTopic.jsp");
				failureView.forward(req, res);
				}
			}
		if ("listArticles_ByTopicno_A".equals(action) || "listArticles_ByTopicno_B".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				Integer topicno = new Integer(req.getParameter("topicno"));
				
				/*************************** 2.開始查詢資料 ****************************************/			
				TopicService topicSvc = new TopicService();
				Set<ArticleVO> set = topicSvc.getArticlesByTopicno(topicno);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("listArticles_ByTopicno", set);    // 資料庫取出的list物件,存入request
				req.setAttribute("topicno", topicno);    // 資料庫取出的list物件,存入request

				String url = null;
				if ("listArticles_ByTopicno_A".equals(action))
					url = "/front-end/topic/listArticles_ByTopicno.jsp";        // 成功轉交 topic/listArticles_ByTopicno.jsp
				else if ("listArticles_ByTopicno_B".equals(action))
					url = "/front-end/topic/listArticles_ByTopicno.jsp";              // 成功轉交 topic/listAllTopic.jsp

				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 ***********************************/
			} catch (Exception e) {
				throw new ServletException(e);
			}
		}
    }
}
