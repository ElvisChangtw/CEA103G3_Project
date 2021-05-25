package com.ticket_type.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ticket_type.model.Ticket_typeService;
import com.ticket_type.model.Ticket_typeVO;


public class Ticket_typeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Ticket_typeServlet() {
        super();
    }
    
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
				String str = req.getParameter("ticket_type_no");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入票種編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/ticket_type/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer ticket_type_no = null;
				try {
					ticket_type_no = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("票種編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/ticket_type/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				Ticket_typeService ticket_typeSvc = new Ticket_typeService();
				Ticket_typeVO ticket_typeVO = ticket_typeSvc.getOneTicket_type(ticket_type_no);
				if (ticket_typeVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/ticket_type/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("ticket_typeVO", ticket_typeVO); // 資料庫取出的empVO物件,存入req
				String url = "/back-end/ticket_type/listOneTicket_type.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/ticket_type/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("getOne_For_Update".equals(action)) { // 來自listAllTicket_type.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數****************************************/
				Integer ticket_type_no = new Integer(req.getParameter("ticket_type_no"));
				
				/***************************2.開始查詢資料****************************************/
				Ticket_typeService ticket_typeSvc = new Ticket_typeService();
				Ticket_typeVO ticket_typeVO = ticket_typeSvc.getOneTicket_type(ticket_type_no);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("ticket_typeVO", ticket_typeVO);         // 資料庫取出的ticket_typeVO物件,存入req
				String url = "/back-end/ticket_type/update_ticket_type_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_ticket_type_input.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/ticket_type/listAllTicket_type.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("update".equals(action)) { // 來自update_ticket_type_input.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
		
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				Integer ticket_type_no = new Integer(req.getParameter("ticket_type_no").trim());
				
				String ticket_type = req.getParameter("ticket_type");
				
				Integer ticket_price = null;
				try {
					ticket_price = new Integer(req.getParameter("ticket_price").trim());
				} catch (NumberFormatException e) {
					ticket_price = 0;
					errorMsgs.add("票價請填數字.");
				}

				String ticket_desc = req.getParameter("ticket_desc").trim();
				String ticket_descReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{1,10}$";
				if (ticket_desc == null || ticket_desc.trim().length() == 0) {
					errorMsgs.add("票種說明請勿空白");
				}else if(!ticket_desc.trim().matches(ticket_descReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("票種說明: 只能是中文、英文字母、數字,且長度必需為1~10");
				}

				Ticket_typeVO ticket_typeVO = new Ticket_typeVO();
				
				ticket_typeVO.setTicket_type_no(ticket_type_no);
				ticket_typeVO.setTicket_type(ticket_type);
				ticket_typeVO.setTicket_price(ticket_price);
				ticket_typeVO.setTicket_desc(ticket_desc);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("ticket_typeVO", ticket_typeVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/ticket_type/update_ticket_type_input.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
				Ticket_typeService ticket_typeSvc = new Ticket_typeService();
				ticket_typeVO = ticket_typeSvc.updateTicket_type(ticket_type_no, ticket_type, ticket_price, ticket_desc);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("ticket_typeVO", ticket_typeVO); // 資料庫update成功後,正確的的ticket_typeVO物件,存入req
				String url = "/back-end/ticket_type/listAllTicket_type.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/ticket_type/update_ticket_type_input.jsp");
				failureView.forward(req, res);
			}
		}

        if ("insert".equals(action)) { // 來自addEmp.jsp的請求  
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
		
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				
				String ticket_type = req.getParameter("ticket_type");
				System.out.println(ticket_type);
				
				Integer ticket_price = null;
				try {
					ticket_price = new Integer(req.getParameter("ticket_price").trim());
				} catch (NumberFormatException e) {
					ticket_price = 0;
					errorMsgs.add("票價請填數字.");
				}
				System.out.println(ticket_price);

				String ticket_desc = req.getParameter("ticket_desc").trim();
				String ticket_descReg = "^[(\\u4e00-\\u9fa5)(a-zA-Z0-9_)]{1,10}$";
				if (ticket_desc == null || ticket_desc.trim().length() == 0) {
					errorMsgs.add("票種說明請勿空白");
				}else if(!ticket_desc.trim().matches(ticket_descReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("票種名稱: 只能是中文、英文字母、數字,且長度必需為1~10");
				}
				System.out.println(ticket_desc);

				Ticket_typeVO ticket_typeVO = new Ticket_typeVO();
				
				ticket_typeVO.setTicket_type(ticket_type);
				ticket_typeVO.setTicket_price(ticket_price);
				ticket_typeVO.setTicket_desc(ticket_desc);


				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("ticket_typeVO", ticket_typeVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/ticket_type/addTicket_type.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始新增資料***************************************/
				Ticket_typeService ticket_typeSvc = new Ticket_typeService();
				ticket_typeVO = ticket_typeSvc.addTicket_type(ticket_type, ticket_price, ticket_desc);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/back-end/ticket_type/listAllTicket_type.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllTicket_type.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/ticket_type/addTicket_type.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("delete".equals(action)) { // 來自listAllEmp.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
	
			try {
				/***************************1.接收請求參數***************************************/
				Integer ticket_type_no = new Integer(req.getParameter("ticket_type_no"));
				
				/***************************2.開始刪除資料***************************************/
				Ticket_typeService ticket_typeSvc = new Ticket_typeService();
				ticket_typeSvc.deleteTicket_type(ticket_type_no);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				String url = "/back-end/ticket_type/listAllTicket_type.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/ticket_type/listAllTicket_type.jsp");
				failureView.forward(req, res);
			}
		}
		
	}

}
