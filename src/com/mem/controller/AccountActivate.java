package com.mem.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mem.model.MemService;
import com.mem.model.MemVO;

//@WebServlet("/AccountActivate.do")

public class AccountActivate  extends HttpServlet {

		private static final long serialVersionUID = 1L;


		protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
			req.setCharacterEncoding("UTF-8");
			res.setContentType("text/html; charset=Big5");

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			List<String> successMsgs = new LinkedList<String>();
			req.setAttribute("successMsgs", successMsgs);

			
			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String mb_email = req.getParameter("key1");
				String mb_emailReg = "^[(a-zA-Z0-9_)]{2,20}[@][(a-zA-Z0-9)]{3,10}[.][(a-zA-Z)]{1,5}$"; // ^是規定開頭有後面的字(not
																										// sure)
				if (mb_email == null || mb_email.trim().length() == 0) {
					errorMsgs.add("會員信箱: 請勿空白");
				} else if (!mb_email.trim().matches(mb_emailReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("會員信箱: 只能是英文字母、數字和_ , 且長度必需在2到20之間");
				}

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/mem/MemLogin.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				MemService memSvc = new MemService();
				MemVO memVO = memSvc.accountActivate(mb_email);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("memVO", memVO); // 資料庫取出的empVO物件,存入req
				
				successMsgs.add("帳號啟用成功! 請重新登入");
				String url = "/front-end/mem/MemLogin.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/mem/MemLogin.jsp");
				failureView.forward(req, res);
			}
		}
	}
