package com.authority.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.authority.model.AuthorityService;
import com.authority.model.AuthorityVO;

public class AuthorityServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		
		if ("getOneEmp_For_Display".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String str = req.getParameter("empno");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入員工編號");
				}
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/authority/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				Integer empno = null;
				try {
					empno = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("員工編號格式不正確");
				}
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/authority/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				AuthorityService authoritySvc = new AuthorityService();
				List<AuthorityVO> authorityVO = authoritySvc.getOneAuthorityByEmpNo(empno);
				if (authorityVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/authority/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("authorityVO", authorityVO); // 資料庫取出的authorityVO物件,存入req
				String url = "/back-end/authority/listOneAuthority.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneAuthority.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/authority/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		

		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String str = req.getParameter("empno");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入員工編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/authority/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				Integer empno = null;
				try {
					empno = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("員工編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/authority/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}
				
				String str4 = req.getParameter("function_no");
				if (str4 == null || (str4.trim()).length() == 0) {
					errorMsgs.add("請輸入功能編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/authority/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				Integer function_no = null;
				try {
					function_no = new Integer(str4);
				} catch (Exception e) {
					errorMsgs.add("功能編號格式不正確");
				}
				
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/authority/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				AuthorityService authoritySvc = new AuthorityService();
				AuthorityVO authorityVO = authoritySvc.getOneAuthorityByEmpNo_Function_no(empno, function_no);
				if (authorityVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/authority/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("authorityVO", authorityVO); // 資料庫取出的authorityVO物件,存入req
				String url = "/back-end/authority/listOneAuthority.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneAuthority.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/authority/select_page.jsp");
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
				Integer empno = new Integer(req.getParameter("empno"));
				Integer function_no = new Integer(req.getParameter("function_no"));
				

				/*************************** 2.開始查詢資料 ****************************************/
				AuthorityService authoritySvc = new AuthorityService();
				AuthorityVO authorityVO = authoritySvc.getOneAuthorityByEmpNo_Function_no(empno, function_no);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("authorityVO", authorityVO); // 資料庫取出的authorityVO物件,存入req
				String url = "/back-end/authority/update_authority_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_authority_input.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/authority/listAllAuthority.jsp");
				failureView.forward(req, res);
			}
		}

		if ("update".equals(action)) { // 來自update_authority_input.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/

				Integer empno = new Integer(req.getParameter("empno").trim());
				
				Integer function_no = new Integer(req.getParameter("function_no").trim());
				String str2= Integer.toString(function_no);
				String function_noReg = "^[0-9]{1,3}$";
				if (str2 == null || (str2.trim()).length() == 0) {
					errorMsgs.add("功能編號請勿空白");
				} else if (!str2.trim().matches(function_noReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("功能編號只能是數字, 且數值必須小於999");
				}
				
				String auth_status = req.getParameter("auth_status").trim();
				if (auth_status == null || auth_status.trim().length() == 0) {
					errorMsgs.add("權限狀態請勿空白");
				}
				
				
				AuthorityVO authorityVO = new AuthorityVO();
				authorityVO.setEmpno(empno);
				authorityVO.setFunction_no(function_no);
				authorityVO.setAuth_status(auth_status);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("authorityVO", authorityVO); // 含有輸入格式錯誤的authorityVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/authority/update_authority_input.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始修改資料 *****************************************/
				AuthorityService authoritySvc = new AuthorityService();
				authorityVO = authoritySvc.updateAuthority(empno, function_no, auth_status);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("authorityVO", authorityVO); // 資料庫update成功後,正確的的authorityVO物件,存入req
				String url = "/back-end/authority/listOneAuthority.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneAuthority.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/authority/update_authority_input.jsp");
				failureView.forward(req, res);
			}
		}

		if ("insert".equals(action)) { // 來自addAuthority.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				
				Integer empno = new Integer(req.getParameter("empno").trim());
				String str3= Integer.toString(empno);
				String empnoReg = "^[0-9]{1,2}$";
				if (str3 == null || (str3.trim()).length() == 0) {
					errorMsgs.add("員工編號請勿空白");
				} else if (!str3.trim().matches(empnoReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("員工編號只能是數字, 且數值必須小於99");
				}
				
				Integer function_no = new Integer(req.getParameter("function_no").trim());
				String str2= Integer.toString(function_no);
				String function_noReg = "^[0-9]{1,3}$";
				if (str2 == null || (str2.trim()).length() == 0) {
					errorMsgs.add("功能編號請勿空白");
				} else if (!str2.trim().matches(function_noReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("功能編號只能是數字, 且數值必須小於999");
				}
				
				String auth_status = req.getParameter("auth_status").trim();
				if (auth_status == null || auth_status.trim().length() == 0) {
					errorMsgs.add("權限狀態請勿空白");
				}
				
				AuthorityVO authorityVO = new AuthorityVO();
				authorityVO.setEmpno(empno);
				authorityVO.setFunction_no(function_no);
				authorityVO.setAuth_status(auth_status);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("authorityVO", authorityVO); // 含有輸入格式錯誤的authorityVO物件,也存入req。儲存打過的資料，若輸入錯誤不用重新輸入
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/authority/addAuthority.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
				AuthorityService authoritySvc = new AuthorityService();
				authorityVO = authoritySvc.addAuthority(empno, function_no, auth_status);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/authority/listAllAuthority.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllAuthority.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/authority/addAuthority.jsp");
				failureView.forward(req, res);
			}
		}

		if ("delete".equals(action)) { // 來自listAllAuthority.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ***************************************/
				Integer empno = new Integer(req.getParameter("empno"));
				Integer function_no = new Integer(req.getParameter("function_no"));

				/*************************** 2.開始刪除資料 ***************************************/
				AuthorityService authoritySvc = new AuthorityService();
				authoritySvc.deleteAuthority(empno,function_no);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/authority/listAllAuthority.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/authority/listAllAuthority.jsp");
				failureView.forward(req, res);
			}
		}
	}
}
