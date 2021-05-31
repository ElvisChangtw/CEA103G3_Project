package com.order.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.mem.model.MemVO;
import com.ord_food.model.Ord_foodService;
import com.ord_food.model.Ord_foodVO;
import com.ord_ticket_type.model.Ord_ticket_typeService;
import com.ord_ticket_type.model.Ord_ticket_typeVO;
import com.order.model.OrderService;
import com.order.model.OrderVO;
import com.showtime.model.ShowtimeService;



public class OrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public OrderServlet() {
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
 				String str = req.getParameter("order_no");
 				
 				if (str == null || (str.trim()).length() == 0) {
 					errorMsgs.add("請輸入訂單編號");
 				}
 				// Send the use back to the form, if there were errors
 				if (!errorMsgs.isEmpty()) {
 					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/order/select_page.jsp");
 					failureView.forward(req, res);
 					return;//程式中斷
 				}
 				
 				Integer order_no = null;
 				
 				try {
 					order_no = new Integer(str);
 				} catch (Exception e) {
 					errorMsgs.add("訂單編號格式不正確");
 				}
 				
 				// Send the use back to the form, if there were errors
 				if (!errorMsgs.isEmpty()) {
 					RequestDispatcher failureView = req
 							.getRequestDispatcher("/back-end/order/select_page.jsp");
 					failureView.forward(req, res);
 					return;//程式中斷
 				}
 				
 				
 				/***************************2.開始查詢資料*****************************************/
 				OrderService orderSvc = new OrderService();
 				OrderVO orderVO = orderSvc.getOneOrder(order_no);
 				if (orderVO == null) {
 					errorMsgs.add("查無資料");
 				}
 				// Send the use back to the form, if there were errors
 				if (!errorMsgs.isEmpty()) {
 					RequestDispatcher failureView = req
 							.getRequestDispatcher("/back-end/order/select_page.jsp");
 					failureView.forward(req, res);
 					return;//程式中斷
 				}
 				
 				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
 				req.setAttribute("orderVO", orderVO); // 資料庫取出的empVO物件,存入req
 				String url = "/back-end/order/listOneOrder.jsp";
 				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
 				successView.forward(req, res);

 				/***************************其他可能的錯誤處理*************************************/
 			} catch (Exception e) {
 				errorMsgs.add("無法取得資料:" + e.getMessage());
 				RequestDispatcher failureView = req
 						.getRequestDispatcher("/back-end/order/select_page.jsp");
 				failureView.forward(req, res);
 			}
 		}
 		

 		if ("getOne_For_Order".equals(action)) { // 來自select_page.jsp的請求

 			List<String> errorMsgs = new LinkedList<String>();
 			// Store this set in the request scope, in case we need to
 			// send the ErrorPage view.
 			req.setAttribute("errorMsgs", errorMsgs);
 			
 			try {
 				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
 				String str = req.getParameter("order_no");
 				
 				if (str == null || (str.trim()).length() == 0) {
 					errorMsgs.add("請輸入訂單編號");
 				}
 				// Send the use back to the form, if there were errors
 				if (!errorMsgs.isEmpty()) {
 					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/order/select_page.jsp");
 					failureView.forward(req, res);
 					return;//程式中斷
 				}
 				
 				Integer order_no = null;
 				
 				try {
 					order_no = new Integer(str);
 				} catch (Exception e) {
 					errorMsgs.add("訂單編號格式不正確");
 				}
 				
 				// Send the use back to the form, if there were errors
 				if (!errorMsgs.isEmpty()) {
 					RequestDispatcher failureView = req
 							.getRequestDispatcher("/back-end/order/select_page.jsp");
 					failureView.forward(req, res);
 					return;//程式中斷
 				}
 				
 				
 				/***************************2.開始查詢資料*****************************************/
 				OrderService orderSvc = new OrderService();
 				OrderVO orderVO = orderSvc.getOneOrder(order_no);
 				if (orderVO == null) {
 					errorMsgs.add("查無資料");
 				}
 				// Send the use back to the form, if there were errors
 				if (!errorMsgs.isEmpty()) {
 					RequestDispatcher failureView = req
 							.getRequestDispatcher("/back-end/order/select_page.jsp");
 					failureView.forward(req, res);
 					return;//程式中斷
 				}
 				
 				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
 				req.setAttribute("orderVO", orderVO); // 資料庫取出的empVO物件,存入req
 				String url = "/back-end/order/listAllOrder.jsp";
 				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
 				successView.forward(req, res);

 				/***************************其他可能的錯誤處理*************************************/
 			} catch (Exception e) {
 				errorMsgs.add("無法取得資料:" + e.getMessage());
 				RequestDispatcher failureView = req
 						.getRequestDispatcher("/back-end/order/select_page.jsp");
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
 				
 				/***************************2.開始查詢資料****************************************/
 				OrderService orderSvc = new OrderService();
 				OrderVO orderVO = orderSvc.getOneOrder(order_no);
 								
 				/***************************3.查詢完成,準備轉交(Send the Success view)************/
 				req.setAttribute("orderVO", orderVO);         // 資料庫取出的ticket_typeVO物件,存入req
 				String url = "/back-end/order/update_order_input.jsp";
 				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_ticket_type_input.jsp
 				successView.forward(req, res);

 				/***************************其他可能的錯誤處理**********************************/
 			} catch (Exception e) {
 				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
 				RequestDispatcher failureView = req
 						.getRequestDispatcher("/back-end/order/listAllOrder.jsp");
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
 				
 				String str = req.getParameter("member_no");
 				
 				if (str== null || (str.trim()).length() == 0) {
 					errorMsgs.add("請輸入餐點編號");
 				}
 				
 				Integer member_no = null;
 				try {
 					member_no = new Integer(str);
 				} catch (Exception e) {
 					errorMsgs.add("會員編號格式不正確");
 				}
 				
 				String str1 = req.getParameter("showtime_no").trim();
 				Integer showtime_no = null;
 				try {
 					showtime_no = new Integer(str1);
 				} catch (NumberFormatException e) {
 					showtime_no = 0;
 					errorMsgs.add("場次編號請填數字.");
 				}
 				
 				String str2 = req.getParameter("crt_dt");
 				Timestamp crt_dt = null;
 				try {
 					crt_dt = java.sql.Timestamp.valueOf(str2.trim());
 				} catch(IllegalArgumentException e) {
 					crt_dt = new java.sql.Timestamp(System.currentTimeMillis());
 					errorMsgs.add("創建日期請填日期時間");
 				}
 				
 				String order_status = req.getParameter("order_status");
 				
 				String order_type = req.getParameter("order_type");
 				
 				String payment_type = req.getParameter("payment_type");
 				
 				Integer total_price = null;
 				try {
 					total_price = new Integer(req.getParameter("total_price").trim());
 				} catch (NumberFormatException e) {
 					total_price = 0;
 					errorMsgs.add("總價請填數字");
 				}
 				
 				String seat_name = req.getParameter("seat_name").trim();
 				


 				OrderVO orderVO = new OrderVO();	
 				
 				orderVO.setOrder_no(order_no);
 				orderVO.setMember_no(member_no);
 				orderVO.setShowtime_no(showtime_no);
 				orderVO.setCrt_dt(crt_dt);
 				orderVO.setOrder_status(order_status);
 				orderVO.setOrder_type(order_type);
 				orderVO.setPayment_type(payment_type);
 				orderVO.setTotal_price(total_price);
 				orderVO.setSeat_name(seat_name);

 				// Send the use back to the form, if there were errors
 				if (!errorMsgs.isEmpty()) {
 					req.setAttribute("orderVO", orderVO); // 含有輸入格式錯誤的empVO物件,也存入req
 					RequestDispatcher failureView = req
 							.getRequestDispatcher("/back-end/order/update_order_input.jsp");
 					failureView.forward(req, res);
 					return; //程式中斷
 				}
 				
 				/***************************2.開始修改資料*****************************************/
 				OrderService orderService = new OrderService();
 				orderVO = orderService.updateOrder(order_no, member_no, showtime_no, crt_dt
 						, order_status, order_type, payment_type, total_price, seat_name);
 				
 				/***************************3.修改完成,準備轉交(Send the Success view)*************/
 				req.setAttribute("orderVO", orderVO); // 資料庫update成功後,正確的的ticket_typeVO物件,存入req
 				String url = "/back-end/order/listAllOrder.jsp";
 				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
 				successView.forward(req, res);

 				/***************************其他可能的錯誤處理*************************************/
 			} catch (Exception e) {
 				errorMsgs.add("修改資料失敗:"+e.getMessage());
 				RequestDispatcher failureView = req
 						.getRequestDispatcher("/back-end/order/update_order_input.jsp");
 				failureView.forward(req, res);
 			}
 		}
 		
// 		ajax
		if("update_status".equals(action)) {
			Integer order_no = new Integer(req.getParameter("order_no"));
			OrderService ordSvc = new OrderService();
			OrderVO orderVO = ordSvc.getOneOrder(order_no);
			Integer member_no = orderVO.getMember_no();
			Integer showtime_no = orderVO.getShowtime_no();
			Timestamp crt_dt = orderVO.getCrt_dt();
			String order_status = "3";
			String order_type = orderVO.getOrder_type();
			String payment_type = orderVO.getOrder_type();
			Integer total_price = orderVO.getTotal_price();
			String seat_name = orderVO.getSeat_name();
			
			 ordSvc.updateOrder(order_no, member_no, showtime_no, crt_dt, order_status, order_type, payment_type, total_price, seat_name);
		}
 		
         if ("insert".equals(action)) { // 來自addEmp.jsp的請求  
 			List<String> errorMsgs = new LinkedList<String>();
 			// Store this set in the request scope, in case we need to
 			// send the ErrorPage view.
 			req.setAttribute("errorMsgs", errorMsgs);
 		
 			try {
 				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
 				String str = req.getParameter("member_no");
 				
 				if (str== null || (str.trim()).length() == 0) {
 					errorMsgs.add("請輸入餐點編號");
 				}
 				
 				Integer member_no = null;
 				try {
 					member_no = new Integer(str);
 				} catch (Exception e) {
 					errorMsgs.add("會員編號格式不正確");
 				}
 				
 				String str1 = req.getParameter("showtime_no").trim();
 				Integer showtime_no = null;
 				try {
 					showtime_no = new Integer(str1);
 				} catch (NumberFormatException e) {
 					showtime_no = 0;
 					errorMsgs.add("場次編號請填數字.");
 				}
 				
 				String str2 = req.getParameter("crt_dt");
 				Timestamp crt_dt = null;
 				try {
 					crt_dt = java.sql.Timestamp.valueOf(str2.trim());
 				} catch(IllegalArgumentException ie) {
 					crt_dt = new java.sql.Timestamp(System.currentTimeMillis());
 					errorMsgs.add("創建日期請填日期時間");
 				}
 				
 				String order_status = req.getParameter("order_status");
 				
 				String order_type = req.getParameter("order_type");
 				
 				String payment_type = req.getParameter("payment_type");
 				
 				Integer total_price = null;
 				try {
 					total_price = new Integer(req.getParameter("total_price").trim());
 				} catch (NumberFormatException e) {
 					total_price = 0;
 					errorMsgs.add("總價請填數字.");
 				}
 				
 				String seat_name = req.getParameter("seat_name").trim();


 				OrderVO orderVO = new OrderVO();	
 				
 				orderVO.setMember_no(member_no);
 				orderVO.setShowtime_no(showtime_no);
 				orderVO.setCrt_dt(crt_dt);
 				orderVO.setOrder_status(order_status);
 				orderVO.setOrder_type(order_type);
 				orderVO.setPayment_type(payment_type);
 				orderVO.setTotal_price(total_price);
 				orderVO.setSeat_name(seat_name);

 				// Send the use back to the form, if there were errors
 				if (!errorMsgs.isEmpty()) {
 					req.setAttribute("orderVO", orderVO); // 含有輸入格式錯誤的empVO物件,也存入req
 					RequestDispatcher failureView = req
 							.getRequestDispatcher("/back-end/order/addOrder.jsp");
 					failureView.forward(req, res);
 					return; //程式中斷
 				}
 				
 				/***************************2.開始新增資料***************************************/
 				OrderService orderSvc = new OrderService();
 				orderVO = orderSvc.addOrder(member_no, showtime_no, crt_dt
 						, order_status, order_type, payment_type, total_price, seat_name);
 				
 				/***************************3.新增完成,準備轉交(Send the Success view)***********/
 				String url = "/back-end/order/listAllOrder.jsp";
 				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllTicket_type.jsp
 				successView.forward(req, res);				
 				
 				/***************************其他可能的錯誤處理**********************************/
 			} catch (Exception e) {
 				errorMsgs.add(e.getMessage());
 				RequestDispatcher failureView = req
 						.getRequestDispatcher("/back-end/order/addOrder.jsp");
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
 				
 				/***************************2.開始刪除資料***************************************/
 				OrderService orderService = new OrderService();
 				orderService.deleteOrder(order_no);
 				
 				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
 				String url = "/back-end/order/listAllOrder.jsp";
 				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
 				successView.forward(req, res);
 				
 				/***************************其他可能的錯誤處理**********************************/
 			} catch (Exception e) {
 				errorMsgs.add("刪除資料失敗:"+e.getMessage());
 				RequestDispatcher failureView = req
 						.getRequestDispatcher("/back-end/order/listAllOrder.jsp");
 				failureView.forward(req, res);
 			}
 		}
 		
 		
 		if ("sendToFT".equals(action)) { // 來自addEmp.jsp的請求  
 			List<String> errorMsgs = new LinkedList<String>();
 			// Store this set in the request scope, in case we need to
 			// send the ErrorPage view.
 			req.setAttribute("errorMsgs", errorMsgs);
 		
 			try {
 				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
 				Integer showtime_no = new Integer(req.getParameter("showtime_no"));
 				HttpSession session = req.getSession();
 				session.setAttribute("showtime_no", showtime_no);
 				
 				/***************************3.新增完成,準備轉交(Send the Success view)***********/
 				String url = "/back-end/ord_ticket_type/addOrd_ticket_type2.jsp";
 				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllTicket_type.jsp
 				successView.forward(req, res);				
 				
 				/***************************其他可能的錯誤處理**********************************/
 			} catch (Exception e) {
 				errorMsgs.add(e.getMessage());
 				RequestDispatcher failureView = req
 						.getRequestDispatcher("/back-end/order/addOrder.jsp");
 				failureView.forward(req, res);
 			}
 		}
 		if ("sendToST".equals(action)) { // 來自addEmp.jsp的請求  
 			List<String> errorMsgs = new LinkedList<String>();
 			// Store this set in the request scope, in case we need to
 			// send the ErrorPage view.
 			req.setAttribute("errorMsgs", errorMsgs);
 		
 			try {
 				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
 				String ticket_typeno[] = req.getParameterValues("ticket_type_no");
				String ticketcount[] = req.getParameterValues("ticket_count");
				String ticketprice[] = req.getParameterValues("ticket_price");
				
				String foodno[] = req.getParameterValues("food_no");
				String foodcount[] = req.getParameterValues("food_count");
				String foodprice[] = req.getParameterValues("food_price");
				
				//計算有幾張票，才能選幾張座位
				int count = 0;
				for(int i = 0; i < ticketcount.length; i++) {
					count += new Integer(ticketcount[i]);
				}
				
				HttpSession session = req.getSession(); //把來自餐點及票種的資料存在session
				
				session.setAttribute("ticket_typeno", ticket_typeno);
				session.setAttribute("ticketcount", ticketcount);
				session.setAttribute("ticketprice", ticketprice);
				session.setAttribute("foodno", foodno);
				session.setAttribute("foodcount", foodcount);
				session.setAttribute("foodprice", foodprice);	
				session.setAttribute("count", count); //共訂了幾張票
				
  				List<Ord_foodVO> ordFood_list = new ArrayList<Ord_foodVO>();
				for(int i = 0; i < foodno.length; i++) {
					Integer food_no = new Integer(foodno[i]);
					Integer food_count = new Integer(foodcount[i]);
					Integer price = new Integer(foodprice[i]) * food_count;

					Ord_foodVO ord_foodVO = new Ord_foodVO();
					ord_foodVO.setFood_no(food_no);
					ord_foodVO.setFood_count(food_count);
					ord_foodVO.setPrice(price);
					if(food_count != 0) {
					ordFood_list.add(ord_foodVO);
					}
				}
				
				List<Ord_ticket_typeVO> ordTicket_list = new ArrayList<Ord_ticket_typeVO>();
				for(int i = 0; i < ticket_typeno.length; i++) {
					Integer ticket_type_no = new Integer(ticket_typeno[i]);
					Integer ticket_count = new Integer(ticketcount[i]);
					Integer price1 = new Integer(ticketprice[i]) * ticket_count;
					
					Ord_ticket_typeVO ord_ticket_typeVO = new Ord_ticket_typeVO();
					ord_ticket_typeVO.setTicket_type_no(ticket_type_no);
					ord_ticket_typeVO.setTicket_count(ticket_count);
					ord_ticket_typeVO.setPrice(price1);
					if(ticket_count != 0) {
					ordTicket_list.add(ord_ticket_typeVO);
					}
				}
				
				Integer total_price = 0;
  				
				for(int i = 0; i < ticket_typeno.length; i++) {
					Integer ticket_price = new Integer(ticketprice[i]);
					Integer ticket_count = new Integer(ticketcount[i]);
					total_price += ticket_price * ticket_count;
				}
				
				for(int i = 0 ; i < foodprice.length; i++) {
					total_price += (new Integer(foodprice[i])) * (new Integer(foodcount[i]));
				}
				
				req.setAttribute("total_price", total_price);
				req.setAttribute("ordFood_list", ordFood_list);
				req.setAttribute("ordTicket_list", ordTicket_list);
				
 				/***************************3.新增完成,準備轉交(Send the Success view)***********/
// 				String url = "/back-end/showtime/addOrd_ticket_type_sample.jsp";
 				String url = "/back-end/websocketSeat/addOrd_ticket_type_sample.jsp";
 				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllTicket_type.jsp
 				successView.forward(req, res);				
 				
 				/***************************其他可能的錯誤處理**********************************/
 			} catch (Exception e) {
 				errorMsgs.add(e.getMessage());
 				RequestDispatcher failureView = req
 						.getRequestDispatcher("/back-end/order/addOrder.jsp");
 				failureView.forward(req, res);
 			}
 		}
 		
 		if ("checkOrd".equals(action)) { // 來自addEmp.jsp的請求  
 			List<String> errorMsgs = new LinkedList<String>();
 			// Store this set in the request scope, in case we need to
 			// send the ErrorPage view.
 			req.setAttribute("errorMsgs", errorMsgs);
 		
 			try {
 				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
 				
 				//座位名稱
  				String[] seatname = req.getParameterValues("seat_name");
  				String seat_name = "";
  				for(int i = 0; i < seatname.length; i++) {
  					if(i < seatname.length-1) {
  					seat_name += seatname[i] + ", ";
  					}else {
  						seat_name += seatname[i];
  					}
  				}
  				
  				HttpSession session = req.getSession();
				String ticket_typeno[] = (String[]) session.getAttribute("ticket_typeno");
				String ticketcount[] = (String[]) session.getAttribute("ticketcount");
				String ticketprice[] = (String[]) session.getAttribute("ticketprice");
				String foodno[] = (String[]) session.getAttribute("foodno");
				String foodcount[] = (String[]) session.getAttribute("foodcount");
				String foodprice[] = (String[]) session.getAttribute("foodprice");
  				
  				List<Ord_foodVO> ordFood_list = new ArrayList<Ord_foodVO>();
				for(int i = 0; i < foodno.length; i++) {
					Integer food_no = new Integer(foodno[i]);
					Integer food_count = new Integer(foodcount[i]);
					Integer price = new Integer(foodprice[i]) * food_count;

					Ord_foodVO ord_foodVO = new Ord_foodVO();
					ord_foodVO.setFood_no(food_no);
					ord_foodVO.setFood_count(food_count);
					ord_foodVO.setPrice(price);
					if(food_count != 0) {
					ordFood_list.add(ord_foodVO);
					}
				}
				
				List<Ord_ticket_typeVO> ordTicket_list = new ArrayList<Ord_ticket_typeVO>();
				for(int i = 0; i < ticket_typeno.length; i++) {
					Integer ticket_type_no = new Integer(ticket_typeno[i]);
					Integer ticket_count = new Integer(ticketcount[i]);
					Integer price1 = new Integer(ticketprice[i]) * ticket_count;
					System.out.println(ticket_count);
					Ord_ticket_typeVO ord_ticket_typeVO = new Ord_ticket_typeVO();
					ord_ticket_typeVO.setTicket_type_no(ticket_type_no);
					ord_ticket_typeVO.setTicket_count(ticket_count);
					ord_ticket_typeVO.setPrice(price1);
					if(ticket_count != 0) {
						ordTicket_list.add(ord_ticket_typeVO);
					}
				}
				
				Integer total_price = 0;
  				
				for(int i = 0; i < ticket_typeno.length; i++) {
					Integer ticket_price = new Integer(ticketprice[i]);
					Integer ticket_count = new Integer(ticketcount[i]);
					total_price += ticket_price * ticket_count;
				}
				
				for(int i = 0 ; i < foodprice.length; i++) {
					total_price += (new Integer(foodprice[i])) * (new Integer(foodcount[i]));
				}
				
				String s[] = req.getParameterValues("seat_no");
				String seat_no = "";
				for(int i = 0; i < s.length; i++) {
					seat_no = seat_no + s[i];
				}
				
				//websocket 把選中的座位給checkOrder
				String seat[] = req.getParameterValues("seat_id");
				ArrayList<String> seat_id = new ArrayList<String>();
				for(int i = 0; i < seat.length; i++) {
					seat_id.add(seat[i]);
				}
				
				req.setAttribute("total_price", total_price);
				req.setAttribute("ordFood_list", ordFood_list);
				req.setAttribute("ordTicket_list", ordTicket_list);
  				req.setAttribute("seat_name", seat_name);
  				req.setAttribute("seat_no", seat_no);
  				req.setAttribute("seat_id", seat_id);
 				
 				/***************************3.新增完成,準備轉交(Send the Success view)***********/
 				String url = "/back-end/order/checkOrder.jsp";
 				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllTicket_type.jsp
 				successView.forward(req, res);				
 				
 				/***************************其他可能的錯誤處理**********************************/
 			} catch (Exception e) {
 				errorMsgs.add(e.getMessage());
 				RequestDispatcher failureView = req
 						.getRequestDispatcher("/back-end/order/addOrder.jsp");
 				failureView.forward(req, res);
 			}
 		}
 		
 		 if ("insertOrd".equals(action)) { // 來自addEmp.jsp的請求  
  			List<String> errorMsgs = new LinkedList<String>();
  			// Store this set in the request scope, in case we need to
  			// send the ErrorPage view.
  			req.setAttribute("errorMsgs", errorMsgs);
  		
  			try {
  				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
  				HttpSession session = req.getSession();
				String ticket_typeno[] = (String[]) session.getAttribute("ticket_typeno");
				String ticketcount[] = (String[]) session.getAttribute("ticketcount");
				String ticketprice[] = (String[]) session.getAttribute("ticketprice");
				String foodno[] = (String[]) session.getAttribute("foodno");
				String foodcount[] = (String[]) session.getAttribute("foodcount");
				String foodprice[] = (String[]) session.getAttribute("foodprice");
  				
				MemVO memVO = (MemVO)session.getAttribute("memVO");;
				
  				Integer member_no = memVO.getMember_no();
  				Integer showtime_no = new Integer(req.getParameter("showtime_no").trim());
  				Timestamp crt_dt = new java.sql.Timestamp(System.currentTimeMillis());
  				String order_type = req.getParameter("order_type").trim();
  				String payment_type = req.getParameter("payment_type").trim();
  				String order_status = "";
  				if(payment_type=="1") {
  					order_status = "1";
  				}else {
  					order_status = "0";
  				}
  				Integer total_price = 0;
				for(int i = 0; i < ticket_typeno.length; i++) {
					Integer ticket_price = new Integer(ticketprice[i]);
					Integer ticket_count = new Integer(ticketcount[i]);
					total_price += ticket_price * ticket_count;
				}
				for(int i = 0 ; i < foodprice.length; i++) {
					total_price += (new Integer(foodprice[i])) * (new Integer(foodcount[i]));
				}
  				String seat_name = req.getParameter("seat_name");
  				OrderVO orderVO = new OrderVO();
  				orderVO.setMember_no(member_no);
  				orderVO.setShowtime_no(showtime_no);
  				orderVO.setCrt_dt(crt_dt);
  				orderVO.setOrder_status(order_status);
  				orderVO.setOrder_type(order_type);
  				orderVO.setPayment_type(payment_type);
  				orderVO.setTotal_price(total_price);
  				orderVO.setSeat_name(seat_name);
  				
  				List<Ord_foodVO> ordFood_list = new ArrayList<Ord_foodVO>();
				for(int i = 0; i < foodno.length; i++) {
					Integer food_no = new Integer(foodno[i]);
					Integer food_count = new Integer(foodcount[i]);
					Integer price = new Integer(foodprice[i]) * food_count;

					Ord_foodVO ord_foodVO = new Ord_foodVO();
					ord_foodVO.setFood_no(food_no);
					ord_foodVO.setFood_count(food_count);
					ord_foodVO.setPrice(price);
					if(food_count > 0) {
						ordFood_list.add(ord_foodVO);
					}
				}
				List<Ord_ticket_typeVO> ordTicket_list = new ArrayList<Ord_ticket_typeVO>();
				for(int i = 0; i < ticket_typeno.length; i++) {
					Integer ticket_type_no = new Integer(ticket_typeno[i]);
					Integer ticket_count = new Integer(ticketcount[i]);
					Integer price1 = new Integer(ticketprice[i]) * ticket_count;
					
					Ord_ticket_typeVO ord_ticket_typeVO = new Ord_ticket_typeVO();
					ord_ticket_typeVO.setTicket_type_no(ticket_type_no);
					ord_ticket_typeVO.setTicket_count(ticket_count);
					ord_ticket_typeVO.setPrice(price1);
					if(ticket_count > 0) {
						ordTicket_list.add(ord_ticket_typeVO);
					}
				}
				String seat_no = req.getParameter("seat_no");
				
				/***************************2.開始新增資料***************************************/
  				OrderService orderSvc = new OrderService();
  				orderVO = orderSvc.addOrder2(member_no, showtime_no, crt_dt	, order_status, 
  						order_type, payment_type, total_price, seat_name, ordFood_list, 
  						ordTicket_list, seat_no);
//  				session.removeAttribute("ticket_typeno");
//  				session.removeAttribute("ticketcount");
//  				session.removeAttribute("ticketprice");
//  				session.removeAttribute("foodno");
//  				session.removeAttribute("foodcount");
//  				session.removeAttribute("foodprice");
  				/***************************3.新增完成,準備轉交(Send the Success view)***********/
  				req.setAttribute("orderVO", orderVO);
  				session.setAttribute("memVO", memVO);
  				String url = "/back-end/order/order_complete.jsp";
  				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllTicket_type.jsp
  				successView.forward(req, res);	
  				
  				/***************************其他可能的錯誤處理**********************************/
  			} catch (Exception e) {
  				errorMsgs.add(e.getMessage());
  				RequestDispatcher failureView = req
  						.getRequestDispatcher("/index.jsp");
  				failureView.forward(req, res);
  			}
 		 }
 		 
 		if ("delete_for_Ajax".equals(action)) { // 來自listAllEmp.jsp
 			List<String> errorMsgs = new ArrayList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
 			PrintWriter out = res.getWriter();
			try {
				int order_no = new Integer(req.getParameter("order_no"));
				String order_status="2";
				OrderService orderSvc = new OrderService();
				orderSvc.deleteOrderByMem(order_status, order_no);
				out.print("success");

			}
			catch(Exception e) {
				out.print("fail");
				errorMsgs.add("評論刪除失敗");
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/mem/memberSys.jsp");
				failureView.forward(req, res);
			}finally {
				out.flush();
				out.close();
			}
 		}
 		
 		if ("cancel_booking".equals(action)) { // 來自listAllEmp.jsp
 			List<String> errorMsgs = new ArrayList<String>();
 			req.setAttribute("errorMsgs", errorMsgs);
 			PrintWriter out = res.getWriter();
 			try {
 				int order_no = new Integer(req.getParameter("order_no"));
 				String order_status="2";
 				OrderService orderSvc = new OrderService();
 				orderSvc.deleteOrderByMem(order_status, order_no);
 				out.println("sucess");
 			}
 			catch(Exception e) {
 				out.print("fail");
 				RequestDispatcher failureView = req
 						.getRequestDispatcher("/front-end/mem/memberSys.jsp");
 				failureView.forward(req, res);
 			}finally {
 				out.flush();
 				out.close();
 			}
 		}
 		
 		
 	}
 		
 	
 	
 	
 }


