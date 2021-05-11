package com.ord_ticket_type.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ord_ticket_type.model.Ord_ticket_typeService;
import com.ord_ticket_type.model.Ord_ticket_typeVO;


public class Ord_ticket_typeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Ord_ticket_typeServlet() {
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
							.getRequestDispatcher("/back-end/ord_ticket_type/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer ticket_type_no = null;
				try {
					ticket_type_no = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("票種編號格式不正確");
				}
				
				String str1 = req.getParameter("order_no");
				
				if (str1 == null || (str1.trim()).length() == 0) {
					errorMsgs.add("請輸入訂單編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/ord_ticket_type/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer order_no = null;
				
				try {
					order_no = new Integer(str1);
				} catch (Exception e) {
					errorMsgs.add("票種編號格式不正確");
				}
				
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/ord_ticket_type/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				Ord_ticket_typeService ord_ticket_typeSvc = new Ord_ticket_typeService();
				Ord_ticket_typeVO ord_ticket_typeVO = ord_ticket_typeSvc.getOneOrd_ticket_type(ticket_type_no, order_no);
				if (ord_ticket_typeVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/ord_ticket_type/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("ord_ticket_typeVO", ord_ticket_typeVO); // 資料庫取出的empVO物件,存入req
				String url = "/back-end/ord_ticket_type/listOneOrd_ticket_type.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/ord_ticket_type/select_page.jsp");
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
				Integer order_no = new Integer(req.getParameter("order_no"));
				
				/***************************2.開始查詢資料****************************************/
				Ord_ticket_typeService ord_ticket_typeSvc = new Ord_ticket_typeService();
				Ord_ticket_typeVO ord_ticket_typeVO = ord_ticket_typeSvc.getOneOrd_ticket_type(ticket_type_no, order_no);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("ord_ticket_typeVO", ord_ticket_typeVO);         // 資料庫取出的ticket_typeVO物件,存入req
				String url = "/back-end/ord_ticket_type/update_ord_ticket_type_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_ticket_type_input.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/ord_ticket_type/listAllOrd_ticket_type.jsp");
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
				Integer order_no = new Integer(req.getParameter("order_no").trim());
				
				Integer ticket_count = null;
				try {
					ticket_count = new Integer(req.getParameter("ticket_count").trim());
				} catch (NumberFormatException e) {
					ticket_count = 0;
					errorMsgs.add("票價請填數字.");
				}
				
				Integer price = null;
				try {
					price = new Integer(req.getParameter("price").trim());
				} catch (NumberFormatException e) {
					price = 0;
					errorMsgs.add("票價請填數字.");
				}


				Ord_ticket_typeVO ord_ticket_typeVO = new Ord_ticket_typeVO();
				
				ord_ticket_typeVO.setTicket_type_no(ticket_type_no);
				ord_ticket_typeVO.setOrder_no(order_no);
				ord_ticket_typeVO.setTicket_count(ticket_count);
				ord_ticket_typeVO.setPrice(price);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("ord_ticket_typeVO", ord_ticket_typeVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/ord_ticket_type/update_ord_ticket_type_input.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
				Ord_ticket_typeService ord_ticket_typeService = new Ord_ticket_typeService();
				ord_ticket_typeVO = ord_ticket_typeService.updateOrd_ticket_type(ticket_type_no, order_no, ticket_count, price);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("ord_ticket_typeVO", ord_ticket_typeVO); // 資料庫update成功後,正確的的ticket_typeVO物件,存入req
				String url = "/back-end/ord_ticket_type/listOneOrd_ticket_type.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/ord_ticket_type/update_ord_ticket_type_input.jsp");
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
				String str = req.getParameter("ticket_type_no");
				
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入票種編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/ord_ticket_type/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer ticket_type_no = null;
				try {
					ticket_type_no = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("票種編號格式不正確");
				}
				
				String str1 = req.getParameter("order_no");
				
				if (str1 == null || (str1.trim()).length() == 0) {
					errorMsgs.add("請輸入訂單編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/ord_ticket_type/addOrd_ticket_type.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer order_no = null;
				
				try {
					order_no = new Integer(str1);
				} catch (Exception e) {
					errorMsgs.add("票種編號格式不正確");
				}
				
				String str2 = req.getParameter("ticket_count");
				
				if (str2 == null || (str2.trim()).length() == 0) {
					errorMsgs.add("請輸入訂單編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/ord_ticket_type/addOrd_ticket_type.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer ticket_count = null;
				try {
					ticket_count = new Integer(str2);
				} catch (NumberFormatException e) {
					ticket_count = 0;
					errorMsgs.add("數量請填數字.");
				}
				
				String str3 = req.getParameter("price");
				
				if (str3 == null || (str3.trim()).length() == 0) {
					errorMsgs.add("請輸入訂單編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/ord_ticket_type/addOrd_ticket_type.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer price = null;
				try {
					price = new Integer(req.getParameter("price").trim());
				} catch (NumberFormatException e) {
					price = 0;
					errorMsgs.add("票價請填數字.");
				}

				Ord_ticket_typeVO ord_ticket_typeVO = new Ord_ticket_typeVO();
				
				ord_ticket_typeVO.setTicket_type_no(ticket_type_no);
				ord_ticket_typeVO.setOrder_no(order_no);
				ord_ticket_typeVO.setTicket_count(ticket_count);
				ord_ticket_typeVO.setPrice(price);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("ord_ticket_typeVO", ord_ticket_typeVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/ord_ticket_type/addord_ticket_type.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始新增資料***************************************/
				Ord_ticket_typeService ord_ticket_typeSvc = new Ord_ticket_typeService();
				ord_ticket_typeVO = ord_ticket_typeSvc.addOrd_ticket_type(ticket_type_no, order_no, ticket_count, price);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/back-end/ord_ticket_type/listAllOrd_ticket_type.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllTicket_type.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/ord_ticket_type/addOrd_ticket_type.jsp");
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
				Integer order_no = new Integer(req.getParameter("order_no"));
				
				/***************************2.開始刪除資料***************************************/
				Ord_ticket_typeService ord_ticket_typeService = new Ord_ticket_typeService();
				ord_ticket_typeService.deleteOrd_ticket_type(ticket_type_no, order_no);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				String url = "/back-end/ord_ticket_type/listAllOrd_ticket_type.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/ord_ticket_type/listAllOrd_ticket_type.jsp");
				failureView.forward(req, res);
			}
		}
		
		  if ("insert2".equals(action)) { // 來自addEmp.jsp的請求  
				List<String> errorMsgs = new LinkedList<String>();
				// Store this set in the request scope, in case we need to
				// send the ErrorPage view.
				req.setAttribute("errorMsgs", errorMsgs);
			
				try {
					/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
//					String str1 = req.getParameter("order_no");
					
//					if (str1 == null || (str1.trim()).length() == 0) {
//						errorMsgs.add("請輸入訂單編號");
//					}
					
					Integer order_no = 5;
					
//					try {
//						order_no = new Integer(str1);
//					} catch (Exception e) {
//						errorMsgs.add("餐點編號格式不正確");
//					}
					
					String ticket_typeno[] = req.getParameterValues("ticket_type_no");
					String ticketcount[] = req.getParameterValues("ticket_count");
					String ticketprice[] = req.getParameterValues("ticket_price");
					
					System.out.println("ticket_typeno= " + ticket_typeno.length);
					System.out.println("ticketType= " + ticketcount.length);
					System.out.println("ticketprice= " + ticketprice.length);
					
					Integer ticket_type_no = null;
					Integer ticket_count = null;
					Integer price = null;
					
					for(int i = 0; i < ticket_typeno.length; i++) {
						ticket_type_no = new Integer(ticket_typeno[i]);
						ticket_count = new Integer(ticketcount[i]);
						price = new Integer(ticketprice[i]) * ticket_count;
						System.out.println("ticket_type_no = " + ticket_type_no);
						System.out.println("ticket_count = " + ticket_count);
						System.out.println("ticketprice = " + ticketprice[i]);
						System.out.println("price = " + price);
						System.out.println("order_no = " + order_no);
						
						Ord_ticket_typeVO ord_ticket_typeVO = new Ord_ticket_typeVO();
//						ord_ticket_typeVO.setOrder_no(order_no);
//						ord_ticket_typeVO.setTicket_type_no(ticket_type_no);
//						ord_ticket_typeVO.setTicket_count(ticket_count);
//						ord_ticket_typeVO.setPrice(price);
		
						Ord_ticket_typeService ord_ticket_typeSvc = new Ord_ticket_typeService();
						ord_ticket_typeVO = ord_ticket_typeSvc.addOrd_ticket_type(ticket_type_no, order_no, ticket_count, price);
						System.out.println("ticket_type_no =" + ord_ticket_typeVO.getTicket_type_no() + "ticket_count = " + ord_ticket_typeVO.getTicket_count() +
								"price = " + ord_ticket_typeVO.getPrice() + "order_no = " + ord_ticket_typeVO.getOrder_no());
					
					}
					
					
					
					/***************************3.新增完成,準備轉交(Send the Success view)***********/
					String url = "/back-end/ord_ticket_type/listAllOrd_ticket_type.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllTicket_type.jsp
					successView.forward(req, res);				
					
					/***************************其他可能的錯誤處理**********************************/
				} catch (Exception e) {
					errorMsgs.add(e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/ord_ticket_type/addOrd_ticket_type.jsp");
					failureView.forward(req, res);
				}
			}
			
		}
		
		
	}

