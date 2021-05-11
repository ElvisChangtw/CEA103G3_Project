package com.function.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.function.model.FunctionService;
import com.function.model.FunctionVO;

public class FunctionServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String str = req.getParameter("function_no");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入功能編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/function/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				Integer function_no = null;
				try {
					function_no = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("功能編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/function/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				FunctionService functionSvc = new FunctionService();
				FunctionVO functionVO = functionSvc.getOneFunction(function_no);
				if (functionVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/function/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("functionVO", functionVO); // 資料庫取出的functionVO物件,存入req
				String url = "/back-end/function/listOneFunction.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneFunction.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/function/select_page.jsp");
				failureView.forward(req, res);
			}
		}

		if ("getOne_For_Update".equals(action)) { // 來自listAllEmp.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				Integer function_no = new Integer(req.getParameter("function_no"));

				/*************************** 2.開始查詢資料 ****************************************/
				FunctionService functionSvc = new FunctionService();
				FunctionVO functionVO = functionSvc.getOneFunction(function_no);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("functionVO", functionVO); // 資料庫取出的functionVO物件,存入req
				String url = "/back-end/function/update_function_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_function_input.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/function/listAllFunction.jsp");
				failureView.forward(req, res);
			}
		}

		if ("update".equals(action)) { // 來自update_function_input.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/

				Integer function_no = new Integer(req.getParameter("function_no").trim());

				String function_desc = req.getParameter("function_desc");
				String function_descReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9)]{2,20}$";
				if (function_desc == null || function_desc.trim().length() == 0) {
					errorMsgs.add("功能說明: 請勿空白");
				} else if (!function_desc.trim().matches(function_descReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("功能說明: 只能是中、英文字母、數字, 且長度必需在2到20之間");
				}

				String status = req.getParameter("status").trim();
				if (status == null || status.trim().length() == 0) {
					errorMsgs.add("狀態請勿空白");
				}
				
				FunctionVO functionVO = new FunctionVO();
				functionVO.setFunction_no(function_no);
				functionVO.setFunction_desc(function_desc);
				functionVO.setStatus(status);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("functionVO", functionVO); // 含有輸入格式錯誤的functionVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/function/update_function_input.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始修改資料 *****************************************/
				FunctionService functionSvc = new FunctionService();
				functionVO = functionSvc.updateFunction(function_no, function_desc, status);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("functionVO", functionVO); // 資料庫update成功後,正確的的functionVO物件,存入req
				String url = "/back-end/function/listOneFunction.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneFunction.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/function/update_function_input.jsp");
				failureView.forward(req, res);
			}
		}

		if ("insert".equals(action)) { // 來自addFunction.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				String function_desc = req.getParameter("function_desc");
				String function_descReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9)]{2,20}$";
				if (function_desc == null || function_desc.trim().length() == 0) {
					errorMsgs.add("功能說明: 請勿空白");
				} else if (!function_desc.trim().matches(function_descReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("功能說明: 只能是中、英文字母、數字, 且長度必需在2到20之間");
				}

				String status = req.getParameter("status").trim();
				if (status == null || status.trim().length() == 0) {
					errorMsgs.add("狀態請勿空白");
				}
				
				
				FunctionVO functionVO = new FunctionVO();
				functionVO.setFunction_desc(function_desc);
				functionVO.setStatus(status);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("functionVO", functionVO); // 含有輸入格式錯誤的functionVO物件,也存入req。儲存打過的資料，若輸入錯誤不用重新輸入
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/function/addFunction.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
				FunctionService functionSvc = new FunctionService();
				functionVO = functionSvc.addFunction(function_desc, status);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/function/listAllFunction.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllFunction.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/function/addFunction.jsp");
				failureView.forward(req, res);
			}
		}

		if ("delete".equals(action)) { // 來自listAllFunction.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ***************************************/
				Integer function_no = new Integer(req.getParameter("function_no"));

				/*************************** 2.開始刪除資料 ***************************************/
				FunctionService functionSvc = new FunctionService();
				functionSvc.deleteFunction(function_no);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/function/listAllFunction.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/function/listAllFunction.jsp");
				failureView.forward(req, res);
			}
		}
	}
}
