package com.ord_food.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ord_food.model.Ord_foodService;
import com.ord_food.model.Ord_foodVO;


public class Ord_foodServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Ord_foodServlet() {
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
				String str1 = req.getParameter("order_no");
				
				if (str1 == null || (str1.trim()).length() == 0) {
					errorMsgs.add("請輸入訂單編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/ord_food/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer order_no = null;
				
				try {
					order_no = new Integer(str1);
				} catch (Exception e) {
					errorMsgs.add("訂單編號格式不正確");
				}
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/ord_food/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				String str = req.getParameter("food_no");
				
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入餐點編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/ord_food/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer food_no = null;
				try {
					food_no = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("餐點編號格式不正確");
				}
				
				/***************************2.開始查詢資料*****************************************/
				Ord_foodService ord_foodSvc = new Ord_foodService();
				Ord_foodVO ord_foodVO = ord_foodSvc.getOneOrd_food(order_no, food_no);
				if (ord_foodVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/ord_food/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("ord_foodVO", ord_foodVO); // 資料庫取出的empVO物件,存入req
				String url = "/back-end/ord_food/listOneOrd_food.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/ord_food/select_page.jsp");
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
				Integer order_no = new Integer(req.getParameter("order_no"));
				Integer food_no = new Integer(req.getParameter("food_no"));
				
				/***************************2.開始查詢資料****************************************/
				Ord_foodService ord_foodSvc = new Ord_foodService();
				Ord_foodVO ord_foodVO = ord_foodSvc.getOneOrd_food(order_no, food_no);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("ord_foodVO", ord_foodVO);         // 資料庫取出的ticket_typeVO物件,存入req
				String url = "/back-end/ord_food/update_ord_food_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_ticket_type_input.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/ord_food/listAllOrd_food.jsp");
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
				Integer order_no = new Integer(req.getParameter("order_no").trim());
				Integer food_no = new Integer(req.getParameter("food_no").trim());
				
				Integer food_count = null;
				try {
					food_count = new Integer(req.getParameter("food_count").trim());
				} catch (NumberFormatException e) {
					food_count = 0;
					errorMsgs.add("餐點數量請填數字.");
				}
				
				Integer price = null;
				try {
					price = new Integer(req.getParameter("price").trim());
				} catch (NumberFormatException e) {
					price = 0;
					errorMsgs.add("餐點價格請填數字.");
				}


				Ord_foodVO ord_foodVO = new Ord_foodVO();
				
				ord_foodVO.setOrder_no(order_no);
				ord_foodVO.setFood_no(food_no);
				ord_foodVO.setFood_count(food_count);
				ord_foodVO.setPrice(price);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("ord_foodVO", ord_foodVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/ord_food/update_ord_food_input.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
				Ord_foodService ord_foodService = new Ord_foodService();
				ord_foodVO = ord_foodService.updateOrd_food(order_no, food_no, food_count, price);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("ord_foodVO", ord_foodVO); // 資料庫update成功後,正確的的ticket_typeVO物件,存入req
				String url = "/back-end/ord_food/listOneOrd_food.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/ord_food/update_ord_food_input.jsp");
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
				String str1 = req.getParameter("order_no");
				
				if (str1 == null || (str1.trim()).length() == 0) {
					errorMsgs.add("請輸入訂單編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/ord_food/addOrd_food.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer order_no = null;
				
				try {
					order_no = new Integer(str1);
				} catch (Exception e) {
					errorMsgs.add("餐點編號格式不正確");
				}
				
				String str = req.getParameter("food_no");
				
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入餐點編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/ord_food/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer food_no = null;
				try {
					food_no = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("餐點編號格式不正確");
				}
				
				String str2 = req.getParameter("food_count");
				
				if (str2 == null || (str2.trim()).length() == 0) {
					errorMsgs.add("請輸入餐點數量");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/ord_food/addOrd_food.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer food_count = null;
				try {
					food_count = new Integer(str2);
				} catch (NumberFormatException e) {
					food_count = 0;
					errorMsgs.add("餐點數量請填數字.");
				}
				
				String str3 = req.getParameter("price");
				
				if (str3 == null || (str3.trim()).length() == 0) {
					errorMsgs.add("請輸入餐點價格");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/ord_food/addOrd_food.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer price = null;
				try {
					price = new Integer(req.getParameter("price").trim());
				} catch (NumberFormatException e) {
					price = 0;
					errorMsgs.add("餐點價格請填數字.");
				}

				Ord_foodVO ord_foodVO = new Ord_foodVO();
				
				ord_foodVO.setOrder_no(order_no);
				ord_foodVO.setFood_no(food_no);
				ord_foodVO.setFood_count(food_count);
				ord_foodVO.setPrice(price);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("ord_foodVO", ord_foodVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/ord_food/addord_food.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始新增資料***************************************/
				Ord_foodService ord_foodSvc = new Ord_foodService();
				ord_foodVO = ord_foodSvc.addOrd_food(order_no, food_no, food_count, price);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/back-end/ord_food/listAllOrd_food.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllTicket_type.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/ord_food/addOrd_food.jsp");
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
				Integer order_no = new Integer(req.getParameter("order_no"));
				Integer food_no = new Integer(req.getParameter("food_no"));
				
				/***************************2.開始刪除資料***************************************/
				Ord_foodService ord_foodService = new Ord_foodService();
				ord_foodService.deleteOrd_food(order_no, food_no);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				String url = "/back-end/ord_food/listAllOrd_food.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/ord_food/listAllOrd_food.jsp");
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
//				String str1 = req.getParameter("order_no");
				String str1 = "3";
				
				if (str1 == null || (str1.trim()).length() == 0) {
					errorMsgs.add("請輸入訂單編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/ord_food/addOrd_food.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer order_no = null;
				
				try {
					order_no = new Integer(str1);
				} catch (Exception e) {
					errorMsgs.add("餐點編號格式不正確");
				}
				
				String foodno[] = req.getParameterValues("food_no");
				String foodcount[] = req.getParameterValues("food_count");
				String foodprice[] = req.getParameterValues("food_price");
				System.out.println("foodno= " + foodno.length);
				System.out.println("foodcount= " + foodcount.length);
				System.out.println("foodprice= " + foodprice.length);
				
				Integer food_no = null;
				Integer food_count = null;
				Integer price = null;
				
				for(int i = 0; i < foodno.length; i++) {
					food_no = new Integer(foodno[i]);
					food_count = new Integer(foodcount[i]);
					price = new Integer(foodprice[i]) * food_count;
					System.out.println("food_no =" + food_no);
					System.out.println("food_count =" + food_count);
					System.out.println("food_price =" + foodprice[i]);
					System.out.println("price =" + price);
					
					Ord_foodVO ord_foodVO = new Ord_foodVO();
					ord_foodVO.setOrder_no(order_no);
					ord_foodVO.setFood_no(food_no);
					ord_foodVO.setFood_count(food_count);
					ord_foodVO.setPrice(price);
	
					Ord_foodService ord_foodSvc = new Ord_foodService();
					ord_foodVO = ord_foodSvc.addOrd_food(order_no, food_no, food_count, price);
				}
				
				
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/back-end/ord_food/listAllOrd_food.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllTicket_type.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/ord_food/addOrd_food.jsp");
				failureView.forward(req, res);
			}
		}
		
	}

}
