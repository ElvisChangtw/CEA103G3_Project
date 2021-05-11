package com.relationship.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import org.omg.CORBA.PUBLIC_MEMBER;

import com.relationship.model.*;

public class RelationshipServlet extends HttpServlet {

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
				String str = req.getParameter("member_no");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入訊息編號");
				}
				
				String str2 = req.getParameter("friend_no");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入訊息編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/relationship/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}

				Integer member_no = null;
				try {
					member_no = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("訊息編號格式不正確");
				}
				
				Integer friend_no = null;
				try {
					friend_no = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("訊息編號格式不正確");
				}
				// Send the user back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/relationship/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料(呼叫model, 永續層存取*****************************************/
				RelationshipService relationshipSvc = new RelationshipService();
				RelationshipVO relationshipVO = relationshipSvc.getOneRelationship(member_no, friend_no);
				if (relationshipVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/relationship/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("relationshipVO", relationshipVO); // 資料庫取出的messageVO物件,存入req
			
				String url = "/front-end/relationship/listOneRelationship.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneMessage.jsp
				successView.forward(req, res);
				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/relationship/select_page.jsp");
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
				Integer member_no = new Integer(req.getParameter("member_no"));
				Integer friend_no = new Integer(req.getParameter("friend_no"));
				/***************************2.開始查詢資料****************************************/
				RelationshipService relationshipSvc = new RelationshipService();
				RelationshipVO relationshipVO = relationshipSvc.getOneRelationship(member_no, friend_no);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("relationshipVO", relationshipVO); 

				// 資料庫取出的messageVO物件,存入req
				String url = "/front-end/relationship/update_relationship_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_message_input.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/relationship/listAllRelationship.jsp");
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
				Integer member_no = new Integer(req.getParameter("member_no").trim());
				Integer friend_no = new Integer(req.getParameter("friend_no").trim());
				

				String status = req.getParameter("status").trim();
				if (status == null || status.trim().length() == 0) {
					status = "0";
					errorMsgs.add("狀態請勿空白");
				}
				
				String isBlock = req.getParameter("isBlock").trim();
				if (isBlock == null || isBlock.trim().length() == 0) {
					isBlock = "0";
					errorMsgs.add("是否封鎖請勿空白");
				}
				
				
				RelationshipVO relationshipVO = new RelationshipVO();
				relationshipVO.setMember_no(member_no);;
				relationshipVO.setFriend_no(friend_no);
				relationshipVO.setStatus(status);
				relationshipVO.setIsblock(isBlock);
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("relationshipVO", relationshipVO); // 含有輸入格式錯誤的messageVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/relationship/update_relationship_input.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}

				/***************************2.開始修改資料*****************************************/
				RelationshipService relationshipSvc = new RelationshipService();
				relationshipVO = relationshipSvc.updateRelationship(member_no, friend_no, status, isBlock);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("relationshipVO", relationshipVO); // 資料庫update成功後,正確的的messageVO物件,存入req
				
				
				String url = "/front-end/relationship/listOneRelationship.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneMessage.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/relationship/update_relationship_input.jsp");
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
				Integer member_no =null;
				try {
					member_no = new Integer(req.getParameter("member_no").trim());
				} catch (NumberFormatException e) {
					member_no = 0;
					errorMsgs.add("請填入正確之會員編號");
				}
				
				
				Integer friend_no =null;
				try {
					friend_no = new Integer(req.getParameter("friend_no").trim());
				} catch (NumberFormatException e) {
					friend_no = 0;
					errorMsgs.add("請填入正確之會員編號");
				}
//				以上不行是因為addXXX.jsp沒有讓user輸入message_no,會取不到值無法除錯


				RelationshipVO relationshipVO = new RelationshipVO();
				
				relationshipVO.setMember_no(member_no);
				relationshipVO.setFriend_no(friend_no);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("relationshipVO", relationshipVO); // 含有輸入格式錯誤的messageVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/relationshipVO/addRelationship.jsp");
					failureView.forward(req, res);
					return;
				}
				/***************************2.開始新增資料***************************************/
				RelationshipService relationshipSvc = new RelationshipService();
				relationshipVO = relationshipSvc.add(member_no, friend_no);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/front-end/relationship/listAllRelationship.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllMessage.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/relationship/addRelationship.jsp");
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
				Integer member_no = new Integer(req.getParameter("member_no"));
				Integer friend_no = new Integer(req.getParameter("friend_no"));
				/***************************2.開始刪除資料***************************************/
				RelationshipService relatioinshipSvc = new RelationshipService();
				relatioinshipSvc.deleteRelationship(member_no, friend_no);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				String url = "/front-end/relationship/listAllRelationship.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/relationship/listAllRelationship.jsp");
				failureView.forward(req, res);
			}	
		}
	}
}
