package com.message.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import org.omg.CORBA.PUBLIC_MEMBER;

import com.message.model.*;

public class MessageServlet extends HttpServlet {

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
				String str = req.getParameter("message_no");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入訊息編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/message/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}

				Integer message_no = null;
				try {
					message_no = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("訊息編號格式不正確");
				}
				// Send the user back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/message/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料(呼叫model, 永續層存取*****************************************/
				MessageService messageSvc = new MessageService();
				MessageVO messageVO = messageSvc.getOneMessage(message_no);
				if (messageVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/message/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("messageVO", messageVO); // 資料庫取出的messageVO物件,存入req
			
				String url = "/front-end/message/listOneMessage.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneMessage.jsp
				successView.forward(req, res);
				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/message/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("getOne_For_Update".equals(action)) { // 來自listAllMessage.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數****************************************/
				Integer message_no = new Integer(req.getParameter("message_no"));
				
				/***************************2.開始查詢資料****************************************/
				MessageService messageSvc = new MessageService();
				MessageVO messageVO = messageSvc.getOneMessage(message_no);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("messageVO", messageVO); 

				// 資料庫取出的messageVO物件,存入req
				String url = "/front-end/message/update_message_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_message_input.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/message/listAllMessage.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("update".equals(action)) { // 來自update_message_input.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				Integer message_no = new Integer(req.getParameter("message_no").trim());
				Integer from_member_no = null;
				try {
				from_member_no = new Integer(req.getParameter("from_member_no").trim());
				} catch (NumberFormatException e) {
					from_member_no = null;
					errorMsgs.add("請填入正確之發訊會員編號");
				}
				Integer to_member_no = null;
						try {
							to_member_no = new Integer(req.getParameter("to_member_no").trim());
						} catch (NumberFormatException e) {
							to_member_no = null;
							errorMsgs.add("請填入正確之收訊會員編號");
						}
				String message_content = req.getParameter("message_content").trim();
				if (message_content == null || message_content.trim().length() == 0) {
					message_content = "努力不一定會成功，但不努力會很輕鬆 :)";
					errorMsgs.add("訊息內容請勿空白");
				}
				
				java.sql.Timestamp message_time = null;
				try {
					message_time = java.sql.Timestamp.valueOf(req.getParameter("message_time").trim());
				} catch (IllegalArgumentException e) {
					message_time=new java.sql.Timestamp(System.currentTimeMillis());
					errorMsgs.add("請輸入截止日期!");
				}
				
				MessageVO messageVO = new MessageVO();
				messageVO.setMessage_no(message_no);
				messageVO.setFrom_member_no(from_member_no);
				messageVO.setTo_member_no(to_member_no);
				messageVO.setMessage_content(message_content);
				messageVO.setMessage_time(message_time);
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("messageVO", messageVO); // 含有輸入格式錯誤的messageVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/message/update_message_input.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}

				/***************************2.開始修改資料*****************************************/
				MessageService messageSvc = new MessageService();
				messageVO = messageSvc.updateMessage(message_no, from_member_no, to_member_no, message_content, message_time);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("messageVO", messageVO); // 資料庫update成功後,正確的的messageVO物件,存入req
				
				
				String url = "/front-end/message/listOneMessage.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneMessage.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/message/update_message_input.jsp");
				failureView.forward(req, res);
			}
		}

        if ("insert".equals(action)) { // 來自addMessage.jsp的請求  
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
//				Integer message_no =null;
//				try {
//					message_no = new Integer(req.getParameter("message_no").trim());
//				} catch (NumberFormatException e) {
//					message_no = 0;
//					errorMsgs.add("請填入正確發出訊息之會員編號");
//				}
//				以上不行是因為addXXX.jsp沒有讓user輸入message_no,會取不到值無法除錯
				Integer from_member_no = null;
				try {
				from_member_no = new Integer(req.getParameter("from_member_no").trim());
				} catch (NumberFormatException e) {
					from_member_no = 0;
					errorMsgs.add("請填入正確發出訊息之會員編號");
				}

				Integer to_member_no = null;
						try {
							to_member_no = new Integer(req.getParameter("to_member_no").trim());
						} catch (NumberFormatException e) {
							to_member_no = 0;
							errorMsgs.add("請填入正確收到訊息之會員編號");
						}

				String message_content = req.getParameter("message_content").trim();
				if (message_content == null || message_content.trim().length() == 0) {
					message_content = "一個便當吃不飽，那你有吃第二個嗎?";
					errorMsgs.add("訊息內容請勿空白");
				}	
				
//				java.sql.Date message_time = null;
//				try {
//					message_time = java.sql.Date.valueOf(req.getParameter("message_time").trim());
//				} catch (IllegalArgumentException e) {
//					message_time=new java.sql.Date(System.currentTimeMillis());
//					errorMsgs.add("請輸入日期!");
//				}
				
				MessageVO messageVO = new MessageVO();
				
				messageVO.setFrom_member_no(from_member_no);
				messageVO.setTo_member_no(to_member_no);
				messageVO.setMessage_content(message_content);
//				messageVO.setMessage_time(message_time);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("messageVO", messageVO); // 含有輸入格式錯誤的messageVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/message/addMessage.jsp");
					failureView.forward(req, res);
					return;
				}
				/***************************2.開始新增資料***************************************/
				MessageService messageSvc = new MessageService();
				messageVO = messageSvc.addMessage(from_member_no, to_member_no, message_content);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/front-end/message/listAllMessage.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllMessage.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/message/addMessage.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("delete".equals(action)) { // 來自listAllMessage.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
	
			try {
				/***************************1.接收請求參數***************************************/
				Integer message_no = new Integer(req.getParameter("message_no"));
				
				/***************************2.開始刪除資料***************************************/
				MessageService messageSvc = new MessageService();
				messageSvc.deleteMessage(message_no);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				String url = "/front-end/message/listAllMessage.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/message/listAllMessage.jsp");
				failureView.forward(req, res);
			}	
		}
	}
}
