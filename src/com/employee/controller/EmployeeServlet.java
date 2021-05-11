package com.employee.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.employee.model.EmployeeService;
import com.employee.model.EmployeeVO;

public class EmployeeServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if ("getOne_For_Display".equals(action)) { // �Ӧ�select_page.jsp���ШD

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.�����ШD�Ѽ� - ��J�榡�����~�B�z **********************/
				String str = req.getParameter("empno");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("�п�J���u�s��");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/select_page.jsp");
					failureView.forward(req, res);
					return;// �{�����_
				}

				Integer empno = null;
				try {
					empno = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("���u�s���榡�����T");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/select_page.jsp");
					failureView.forward(req, res);
					return;// �{�����_
				}

				/*************************** 2.�}�l�d�߸�� *****************************************/
				EmployeeService employeeSvc = new EmployeeService();
				EmployeeVO employeeVO = employeeSvc.getOneEmp(empno);
				if (employeeVO == null) {
					errorMsgs.add("�d�L���");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/select_page.jsp");
					failureView.forward(req, res);
					return;// �{�����_
				}

				/*************************** 3.�d�ߧ���,�ǳ����(Send the Success view) *************/
				req.setAttribute("employeeVO", employeeVO); // ��Ʈw���X��employeeVO����,�s�Jreq
				String url = "/back-end/employee/listOneEmployee.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // ���\��� listOneEmployee.jsp
				successView.forward(req, res);

				/*************************** ��L�i�઺���~�B�z *************************************/
			} catch (Exception e) {
				errorMsgs.add("�L�k���o���:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/select_page.jsp");
				failureView.forward(req, res);
			}
		}

		if ("getOne_For_Update".equals(action)) { // �Ӧ�listAllEmp.jsp���ШD

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.�����ШD�Ѽ� ****************************************/
				Integer empno = new Integer(req.getParameter("empno"));

				/*************************** 2.�}�l�d�߸�� ****************************************/
				EmployeeService employeeSvc = new EmployeeService();
				EmployeeVO employeeVO = employeeSvc.getOneEmp(empno);

				/*************************** 3.�d�ߧ���,�ǳ����(Send the Success view) ************/
				req.setAttribute("employeeVO", employeeVO); // ��Ʈw���X��employeeVO����,�s�Jreq
				String url = "/back-end/employee/update_employee_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// ���\��� update_employee_input.jsp
				successView.forward(req, res);

				/*************************** ��L�i�઺���~�B�z **********************************/
			} catch (Exception e) {
				errorMsgs.add("�L�k���o�n�ק諸���:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/listAllEmployee.jsp");
				failureView.forward(req, res);
			}
		}

		if ("update".equals(action)) { // �Ӧ�update_employee_input.jsp���ШD

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.�����ШD�Ѽ� - ��J�榡�����~�B�z **********************/

				Integer empno = new Integer(req.getParameter("empno").trim());

				String empname = req.getParameter("empname");
				String empnameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (empname == null || empname.trim().length() == 0) {
					errorMsgs.add("���u�m�W: �ФŪť�");
				} else if (!empname.trim().matches(empnameReg)) { // �H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
					errorMsgs.add("���u�m�W: �u��O���B�^��r���B�Ʀr�M_ , �B���ץ��ݦb2��10����");
				}

				String emppwd = req.getParameter("emppwd").trim();
				String emppwdReg = "^[(a-zA-Z0-9)]{2,10}$";
				if (emppwd == null || emppwd.trim().length() == 0) {
					errorMsgs.add("�K�X�ФŪť�");
				} else if (!emppwd.trim().matches(emppwdReg)) {
					errorMsgs.add("�K�X�u��O�^��r���B�Ʀr , �B���ץ��ݦb2��10����");
				}

	
				String gender = req.getParameter("gender").trim();
				if (gender == null || gender.trim().length() == 0) {
					errorMsgs.add("�ʧO�ФŪť�");
				}
				
				String tel = req.getParameter("tel").trim();
				String telReg = "^[(0-9]{10}$";
				if (tel == null || tel.trim().length() == 0) {
					errorMsgs.add("�q�ܽФŪť�");
				} else if (!tel.trim().matches(telReg)) {
					errorMsgs.add("�q�ܥu��O�Ʀr , �B���ץ�����10�X");
				}

				String email = req.getParameter("email").trim();
				String emailReg = "^[(a-zA-Z0-9@).]{10,30}$";
				if (email == null || email.trim().length() == 0) {
					errorMsgs.add("�H�c�ФŪť�");
				} else if (!email.trim().matches(emailReg)) {
					errorMsgs.add("�H�c�u��O�^��r���B�Ʀr �M@�M., �B���ץ��ݦb10��30����");
				}

				String title = req.getParameter("title");
				String titleReg = "^[(\u4e00-\u9fa5)(a-zA-Z)]{2,10}$";
				if (title == null || title.trim().length() == 0) {
					errorMsgs.add("¾�ٽФŪť�");
				} else if (!title.trim().matches(titleReg)) { // �H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
					errorMsgs.add("¾�٥u��O���B�^��r�� , �B���ץ��ݦb2��10����");
				}

				java.sql.Date hiredate = null;
				try {
					hiredate = java.sql.Date.valueOf(req.getParameter("hiredate").trim());
				} catch (IllegalArgumentException e) {
					hiredate = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("�п�J���!");
				}
				
				java.sql.Date quitdate = null;
				try {
					quitdate = java.sql.Date.valueOf(req.getParameter("quitdate").trim());
				} catch (IllegalArgumentException e) {
					quitdate = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("�п�J���!");
				}

				String status = req.getParameter("status").trim();
				if (status == null || status.trim().length() == 0) {
					errorMsgs.add("���A�ФŪť�");
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
					req.setAttribute("employeeVO", employeeVO); // �t����J�榡���~��employeeVO����,�]�s�Jreq
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/update_employee_input.jsp");
					failureView.forward(req, res);
					return; // �{�����_
				}

				/*************************** 2.�}�l�ק��� *****************************************/
				EmployeeService employeeSvc = new EmployeeService();
				employeeVO = employeeSvc.updateEmp(empno, empname, emppwd, gender, tel, email, title, hiredate, quitdate, status);

				/*************************** 3.�ק粒��,�ǳ����(Send the Success view) *************/
				req.setAttribute("employeeVO", employeeVO); // ��Ʈwupdate���\��,���T����employeeVO����,�s�Jreq
				String url = "/back-end/employee/listOneEmployee.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // �ק令�\��,���listOneEmployee.jsp
				successView.forward(req, res);

				/*************************** ��L�i�઺���~�B�z *************************************/
			} catch (Exception e) {
				errorMsgs.add("�ק��ƥ���:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/update_employee_input.jsp");
				failureView.forward(req, res);
			}
		}

		if ("insert".equals(action)) { // �Ӧ�addEmployee.jsp���ШD

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.�����ШD�Ѽ� - ��J�榡�����~�B�z *************************/
				String empname = req.getParameter("empname");
				String empnameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (empname == null || empname.trim().length() == 0) {
					errorMsgs.add("���u�m�W: �ФŪť�");
				} else if (!empname.trim().matches(empnameReg)) { // �H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
					errorMsgs.add("���u�m�W: �u��O���B�^��r���B�Ʀr�M_ , �B���ץ��ݦb2��10����");
				}

				String emppwd = req.getParameter("emppwd").trim();
				String emppwdReg = "^[(a-zA-Z0-9)]{6,10}$";
				if (emppwd == null || emppwd.trim().length() == 0) {
					errorMsgs.add("�K�X�ФŪť�");
				} else if (!emppwd.trim().matches(emppwdReg)) {
					errorMsgs.add("�K�X�u��O�^��r���B�Ʀr , �B���ץ��ݦb6��10����");
				}

				String gender = req.getParameter("gender").trim();
				if (gender == null || gender.trim().length() == 0) {
					errorMsgs.add("�ʧO�ФŪť�");
				}
				//�ϥΤU�Կ�� �ç�k�k�ഫ��0.1�s�JDB

				String tel = req.getParameter("tel").trim();
				String telReg = "^[(0-9]{10}$";
				if (tel == null || tel.trim().length() == 0) {
					errorMsgs.add("�q�ܽФŪť�");
				} else if (!tel.trim().matches(telReg)) {
					errorMsgs.add("�q�ܥu��O�Ʀr , �B���ץ�����10�X");
				}
				//�B�zInt���r���s�|����

				String email = req.getParameter("email").trim();
				String emailReg = "^[(a-zA-Z0-9@).]{10,30}$";
				if (email == null || email.trim().length() == 0) {
					errorMsgs.add("�H�c�ФŪť�");
				} else if (!email.trim().matches(emailReg)) {
					errorMsgs.add("�H�c�u��O�^��r���B�Ʀr �M@�M., �B���ץ��ݦb10��30����");
				}

				String title = req.getParameter("title");
				String titleReg = "^[(\u4e00-\u9fa5)(a-zA-Z)]{2,10}$";
				if (title == null || title.trim().length() == 0) {
					errorMsgs.add("¾�ٽФŪť�");
				} else if (!title.trim().matches(titleReg)) { // �H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
					errorMsgs.add("¾�٥u��O���B�^��r�� , �B���ץ��ݦb2��10����");
				}

				java.sql.Date hiredate = null;
				try {
					hiredate = java.sql.Date.valueOf(req.getParameter("hiredate").trim());
				} catch (IllegalArgumentException e) {
					hiredate = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("�п�J���!");
				}
				
				java.sql.Date quitdate = null;
				try {
					quitdate = java.sql.Date.valueOf(req.getParameter("quitdate").trim());
				} catch (IllegalArgumentException e) {
					quitdate = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("�п�J���!");
				}

				String status = req.getParameter("status").trim();
				if (status == null || status.trim().length() == 0) {
					errorMsgs.add("�b¾���A�ФŪť�");
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
					req.setAttribute("employeeVO", employeeVO); // �t����J�榡���~��employeeVO����,�]�s�Jreq�C�x�s���L����ơA�Y��J���~���έ��s��J
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/addEmployee.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.�}�l�s�W��� ***************************************/
				EmployeeService employeeSvc = new EmployeeService();
				employeeVO = employeeSvc.addEmp(empname, emppwd, gender, tel, email, title, hiredate, quitdate, status);

				/*************************** 3.�s�W����,�ǳ����(Send the Success view) ***********/
				String url = "/back-end/employee/listAllEmployee.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // �s�W���\�����listAllEmployee.jsp
				successView.forward(req, res);

				/*************************** ��L�i�઺���~�B�z **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/addEmployee.jsp");
				failureView.forward(req, res);
			}
		}

		if ("delete".equals(action)) { // �Ӧ�listAllEmployee.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.�����ШD�Ѽ� ***************************************/
				Integer empno = new Integer(req.getParameter("empno"));

				/*************************** 2.�}�l�R����� ***************************************/
				EmployeeService employeeSvc = new EmployeeService();
				employeeSvc.deleteEmp(empno);

				/*************************** 3.�R������,�ǳ����(Send the Success view) ***********/
				String url = "/back-end/employee/listAllEmployee.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// �R�����\��,���^�e�X�R�����ӷ�����
				successView.forward(req, res);

				/*************************** ��L�i�઺���~�B�z **********************************/
			} catch (Exception e) {
				errorMsgs.add("�R����ƥ���:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/employee/listAllEmployee.jsp");
				failureView.forward(req, res);
			}
		}
	}
}
