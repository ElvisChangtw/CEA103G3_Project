package com.employee.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.authority.model.AuthorityService;
import com.authority.model.AuthorityVO;
import com.employee.model.EmployeeService;
import com.employee.model.EmployeeVO;
import com.employee.model.SendEmail;

public class EmployeeServlet extends HttpServlet {
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
				String str = req.getParameter("empno");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入員工編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/select_page.jsp");
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
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				EmployeeService employeeSvc = new EmployeeService();
				EmployeeVO employeeVO = employeeSvc.getOneEmp(empno);
				if (employeeVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("employeeVO", employeeVO); // 資料庫取出的employeeVO物件,存入req
				String url = "/back-end/employee/listOneEmployee.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmployee.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/select_page.jsp");
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

				/*************************** 2.開始查詢資料 ****************************************/
				EmployeeService employeeSvc = new EmployeeService();
				EmployeeVO employeeVO = employeeSvc.getOneEmp(empno);
//				System.out.println(123);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("employeeVO", employeeVO); // 資料庫取出的employeeVO物件,存入req
				String url = "/back-end/employee/update_employee_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_employee_input.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/listAllEmployee2.jsp");
				failureView.forward(req, res);
			}
		}

		if ("update".equals(action)) { // 來自update_employee_input.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/

				Integer empno = new Integer(req.getParameter("empno").trim());

				String empname = req.getParameter("empname");
				String empnameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (empname == null || empname.trim().length() == 0) {
					errorMsgs.add("員工姓名: 請勿空白");
				} else if (!empname.trim().matches(empnameReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("員工姓名: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
				}

				String emppwd = req.getParameter("emppwd").trim();
				String emppwdReg = "^[(a-zA-Z0-9)]{2,10}$";
				if (emppwd == null || emppwd.trim().length() == 0) {
					errorMsgs.add("密碼請勿空白");
				} else if (!emppwd.trim().matches(emppwdReg)) {
					errorMsgs.add("密碼只能是英文字母、數字 , 且長度必需在2到10之間");
				}

	
				String gender = req.getParameter("gender").trim();
				if (gender == null || gender.trim().length() == 0) {
					errorMsgs.add("性別請勿空白");
				}
				
				String tel = req.getParameter("tel").trim();
				String telReg = "^[(0-9]{10}$";
				if (tel == null || tel.trim().length() == 0) {
					errorMsgs.add("電話請勿空白");
				} else if (!tel.trim().matches(telReg)) {
					errorMsgs.add("電話只能是數字 , 且長度必須為10碼");
				}

				String email = req.getParameter("email").trim();
				String emailReg = "^[(a-zA-Z0-9@).]{10,30}$";
				if (email == null || email.trim().length() == 0) {
					errorMsgs.add("信箱請勿空白");
				} else if (!email.trim().matches(emailReg)) {
					errorMsgs.add("信箱只能是英文字母、數字 和@和., 且長度必需在10到30之間");
				}

				String title = req.getParameter("title");
				String titleReg = "^[(\u4e00-\u9fa5)(a-zA-Z)]{2,10}$";
				if (title == null || title.trim().length() == 0) {
					errorMsgs.add("職稱請勿空白");
				} else if (!title.trim().matches(titleReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("職稱只能是中、英文字母 , 且長度必需在2到10之間");
				}

				java.sql.Date hiredate = null;
				try {
					hiredate = java.sql.Date.valueOf(req.getParameter("hiredate").trim());
				} catch (IllegalArgumentException e) {
					hiredate = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}
				
				java.sql.Date quitdate = null;
				try {
					quitdate = java.sql.Date.valueOf(req.getParameter("quitdate").trim());
				} catch (IllegalArgumentException e) {
					quitdate = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}

				String status = req.getParameter("status").trim();
				if (status == null || status.trim().length() == 0) {
					errorMsgs.add("狀態請勿空白");
				}
				
				EmployeeVO employeeVO = new EmployeeVO();
				employeeVO.setEmpno(empno);
				employeeVO.setEmpname(empname);
				employeeVO.setEmppwd(emppwd);
				employeeVO.setGender(gender);
				employeeVO.setTel(tel);
				employeeVO.setEmail(email);
				employeeVO.setTitle(title);
				employeeVO.setHiredate(hiredate);
				employeeVO.setQuitdate(quitdate);
				employeeVO.setStatus(status);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("employeeVO", employeeVO); // 含有輸入格式錯誤的employeeVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/update_employee_input.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始修改資料 *****************************************/
				EmployeeService employeeSvc = new EmployeeService();
				employeeVO = employeeSvc.updateEmp(empno, empname, emppwd, gender, tel, email, title, hiredate, quitdate, status);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("employeeVO", employeeVO); // 資料庫update成功後,正確的的employeeVO物件,存入req
				String url = "/back-end/employee/listAllEmployee2.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmployee.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/update_employee_input.jsp");
				failureView.forward(req, res);
			}
		}

		if ("insert".equals(action)) { // 來自addEmployee.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				
//				*****接收員工資料*****
				String empname = req.getParameter("empname");
				String empnameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (empname == null || empname.trim().length() == 0) {
					errorMsgs.add("員工姓名: 請勿空白");
				} else if (!empname.trim().matches(empnameReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("員工姓名: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
				}

//				String emppwd = req.getParameter("emppwd").trim();
//				String emppwdReg = "^[(a-zA-Z0-9)]{6,10}$";
//				if (emppwd == null || emppwd.trim().length() == 0) {
//					errorMsgs.add("密碼請勿空白");
//				} else if (!emppwd.trim().matches(emppwdReg)) {
//					errorMsgs.add("密碼只能是英文字母、數字 , 且長度必需在6到10之間");
//				}

				String emppwd = null;
				
				String gender = req.getParameter("gender").trim();
				if (gender == null || gender.trim().length() == 0) {
					errorMsgs.add("性別請勿空白");
				}
				//使用下拉選單 並把男女轉換成0.1存入DB

				String tel = req.getParameter("tel").trim();
				String telReg = "^[(0-9]{10}$";
				if (tel == null || tel.trim().length() == 0) {
					errorMsgs.add("電話請勿空白");
				} else if (!tel.trim().matches(telReg)) {
					errorMsgs.add("電話只能是數字 , 且長度必須為10碼");
				}
				//處理Int首字為零會消失

				String email = req.getParameter("email").trim();
				String emailReg = "^[(a-zA-Z0-9@).]{10,30}$";
				if (email == null || email.trim().length() == 0) {
					errorMsgs.add("信箱請勿空白");
				} else if (!email.trim().matches(emailReg)) {
					errorMsgs.add("信箱只能是英文字母、數字 和@和., 且長度必需在10到30之間");
				}

				String title = req.getParameter("title");
				String titleReg = "^[(\u4e00-\u9fa5)(a-zA-Z)]{2,10}$";
				if (title == null || title.trim().length() == 0) {
					errorMsgs.add("職稱請勿空白");
				} else if (!title.trim().matches(titleReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("職稱只能是中、英文字母 , 且長度必需在2到10之間");
				}

				java.sql.Date hiredate = null;
				try {
					hiredate = java.sql.Date.valueOf(req.getParameter("hiredate").trim());
				} catch (IllegalArgumentException e) {
					hiredate = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}
				
				java.sql.Date quitdate = null;
				try {
					quitdate = java.sql.Date.valueOf(req.getParameter("quitdate").trim());
				} catch (IllegalArgumentException e) {
					quitdate = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}

				String status = req.getParameter("status").trim();
				if (status == null || status.trim().length() == 0) {
					errorMsgs.add("在職狀態請勿空白");
				}
				
				
				
				EmployeeVO employeeVO = new EmployeeVO();
				employeeVO.setEmpname(empname);
				employeeVO.setEmppwd(emppwd);
				employeeVO.setGender(gender);
				employeeVO.setTel(tel);
				employeeVO.setEmail(email);
				employeeVO.setTitle(title);
				employeeVO.setHiredate(hiredate);
				employeeVO.setQuitdate(quitdate);
				employeeVO.setStatus(status);
				
				

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("employeeVO", employeeVO); // 含有輸入格式錯誤的employeeVO物件,也存入req。儲存打過的資料，若輸入錯誤不用重新輸入
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/listAllEmployee2.jsp");
					failureView.forward(req, res);
					return;
				}
				

				/*************************** 2.開始新增資料 ***************************************/
//				********Step1：新增員工********
				EmployeeService employeeSvc = new EmployeeService();
				employeeVO = employeeSvc.addEmp(empname, emppwd, gender, tel, email, title, hiredate, quitdate, status);
				if (employeeVO != null) {
					SendEmail mailService = new SendEmail();
					String randomPwd = mailService.sendEmpPassword(email);
//					System.out.println(randomPwd);
					// 將該用戶的密碼修改成亂數密碼 
					employeeSvc.updateRandomPws(email, randomPwd);
				}
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/listAllEmployee2.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}
				
//				********Step2：新增權限********
				
//				*****接收權限資料*****
				
				String function_no[] =req.getParameterValues("function_no");
				if(function_no == null) {
					errorMsgs.add("權限請勿空白");
				}
				
				String auth_status[] = req.getParameterValues("auth_status");
				
				Integer empno = employeeVO.getEmpno();
				

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
//					req.setAttribute("authorityVO", authorityVO); // 含有輸入格式錯誤的authorityVO物件,也存入req。儲存打過的資料，若輸入錯誤不用重新輸入
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/listAllEmployee2.jsp");
					failureView.forward(req, res);
					return;
				}
				
				
				AuthorityService authoritySvc = new AuthorityService();
				
				for(int i = 0; i<function_no.length; i++) {
					Integer funno = new Integer(function_no[i]);
					String auth = auth_status[i];
					authoritySvc.addAuthority(empno, funno, auth);
				}
				
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/listAllEmployee2.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/employee/listAllEmployee2.jsp";
//				String url = req.getParameter("requestURL");
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmployee2.jsp
				successView.forward(req, res);
				
				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/listAllEmployee2.jsp");
				failureView.forward(req, res);
			}
		}

		if ("delete".equals(action)) { // 來自listAllEmployee2.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ***************************************/
				Integer empno = new Integer(req.getParameter("empno"));

				/*************************** 2.開始刪除資料 ***************************************/
				EmployeeService employeeSvc = new EmployeeService();
				employeeSvc.deleteEmp(empno);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/employee/listAllEmployee2.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/listAllEmployee2.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("login_check".equals(action)) { // 來自empLogin.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String email = req.getParameter("email");
				String emailReg = "^[(a-zA-Z0-9_)]{2,20}[@][(a-zA-Z0-9)]{3,10}[.][(a-zA-Z)]{1,5}$"; // ^是規定開頭有後面的字(not
																										// sure)
				if (email == null || email.trim().length() == 0) {
					errorMsgs.add("員工信箱: 請勿空白");
				} else if (!email.trim().matches(emailReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("員工信箱: 只能是英文字母、數字和_ , 且長度必需在2到20之間");
				}

				String emppwd = req.getParameter("emppwd");
				String emppwdReg = "^[(a-zA-Z0-9_)]{2,20}$"; // ^是規定開頭有後面的字(not sure)
				if (emppwd == null || emppwd.trim().length() == 0) {
					errorMsgs.add("員工密碼: 請勿空白");
				} else if (!emppwd.trim().matches(emppwdReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("員工密碼: 只能是英文字母、數字和_ , 且長度必需在2到20之間");
				}

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/empLogin.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				EmployeeService employeeSvc = new EmployeeService();
				EmployeeVO employeeVO = employeeSvc.loginCheck(email, emppwd);
				if (employeeVO == null) {
					errorMsgs.add("帳號密碼錯誤，請重新輸入");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/empLogin.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}
				Integer empno = employeeVO.getEmpno();
//				System.out.println(empno);
				
				Set<AuthorityVO> set = employeeSvc.getAuthsByEmpno(empno);
				if (set == null) {
					errorMsgs.add("查無權限資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/empLogin.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}
				
				
				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				HttpSession session = req.getSession();
				session.setAttribute("employeeVO", employeeVO); // 資料庫取出的empVO物件,存入session
				session.setAttribute("authList", set); 
				String url = "/back-home/index2.jsp";
//				System.out.println(req.getContextPath());
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/empLogin.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("listAuthority_ByEmpno".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				Integer empno = new Integer(req.getParameter("empno"));

				/*************************** 2.開始查詢資料 ****************************************/
				EmployeeService employeeSvc = new EmployeeService();
				Set<AuthorityVO> set = employeeSvc.getAuthsByEmpno(empno);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
//				HttpSession session = req.getSession();
//				session.setAttribute("employeeVO", empno)
				req.setAttribute("empno", empno);    // 資料庫取出的set物件,存入request
				req.setAttribute("listAuths_ByEmpno", set);    // 資料庫取出的set物件,存入request
				String url = "/back-end/employee/listAllEmployee2.jsp";

				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 ***********************************/
			} catch (Exception e) {
				throw new ServletException(e);
			}
		}
	}
}
