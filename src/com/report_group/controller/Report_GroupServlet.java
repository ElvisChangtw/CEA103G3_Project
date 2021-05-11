package com.report_group.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import com.group.model.GroupService;
import com.group_member.model.Group_MemberVO;
import com.report_group.model.*;


public class Report_GroupServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

//		if ("getAll".equals(action)) {
//			/***************************開始查詢資料 ****************************************/
//			Report_groupDAO dao = new Report_groupDAO();
//			List<Report_groupVO> list = dao.getAll();
//
//			/***************************查詢完成,準備轉交(Send the Success view)*************/
//			HttpSession session = req.getSession();
//			session.setAttribute("list", list);    // 資料庫取出的list物件,存入session
//			// Send the Success view
//			String url = "/report_group/listAllReport_group2_getFromSession.jsp";
//			RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交listAllReport_group2_getFromSession.jsp
//			successView.forward(req, res);
//			return;
//		}


		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求 //比對寫在前面 所小除錯範圍

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("report_no");
				if (str == null || (str.trim()).length() == 0) { //加str == null 防呆getParameter("report_no")的reportno取到空值的情況
					errorMsgs.add("請輸入檢舉編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/report_group/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer report_no = null;
				try {
					report_no = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("評論編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/report_group/select_page.jsp_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
			Report_GroupDAO dao = new Report_GroupDAO();
			Report_GroupVO report_groupVO = dao.findByPrimaryKey(report_no);
				if (report_groupVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/report_group/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("report_groupVO", report_groupVO); // 資料庫取出的report_groupVO物件,存入req
				String url = "/front-end/report_group/listOneReport_Group.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneReport_Group.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/report_group/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("getOne_For_Update".equals(action)) { // 來自listAllReport_Group.jsp的請求  或  /movie/listReport_Groups_ByMovieno.jsp 的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數****************************************/
				Integer report_no = new Integer(req.getParameter("report_no"));
				
				/***************************2.開始查詢資料****************************************/
				Report_GroupService report_groupSvc = new Report_GroupService();
				Report_GroupVO report_groupVO = report_groupSvc.getOneReport_Group(report_no);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("report_groupVO", report_groupVO);         // 資料庫取出的report_groupVO物件,存入req
				String url = "/front-end/report_group/update_report_group_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_report_group_input.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/report_group/listAllReport_Group.jsp");
				failureView.forward(req, res);

			}
		}
		
		
		if ("update".equals(action)) { // 來自update_report_group_input.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
	
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				Integer report_no = new Integer(req.getParameter("report_no").trim());
				
//				Integer group_no  = null;
//				try {
//					group_no = new Integer(req.getParameter("group_no").trim());
//					if(group_no <= 0 ) {
//						errorMsgs.add("場次編號請填>0的數字.");
//					}
//				} catch(NumberFormatException e) {
//					group_no = 1;
//					errorMsgs.add("場次編號請填數字.");
//				}
				
				
				
				String status = req.getParameter("status").trim();
				if (status == null || status.trim().length() == 0) {
					errorMsgs.add("狀態請勿空白");
				}
				
				String desc = req.getParameter("desc").trim();
				if (desc == null || desc.trim().length() == 0) {
					errorMsgs.add("備註請勿空白");
				}
				
				Report_GroupVO report_groupVO = new Report_GroupVO();
								
				report_groupVO.setReport_no(report_no);
				report_groupVO.setDesc(desc);
				report_groupVO.setStatus(status);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("report_groupVO", report_groupVO); // 含有輸入格式錯誤的report_groupVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/report_group/update_report_group_input.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
				Report_GroupService report_groupSvc = new Report_GroupService();
				report_groupVO = report_groupSvc.updateReport_Group(report_no, status, desc);
				
				
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("report_groupVO", report_groupVO); // 資料庫update成功後,正確的的report_groupVO物件,存入req
				String url = "/front-end/report_group/listOneReport_Group.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneReport_Group.jsp
				successView.forward(req, res);


				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/report_group/update_report_group_input.jsp");
				failureView.forward(req, res);
			}
		}

        if ("insert".equals(action)) { // 來自addReport_Group.jsp的請求  
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				Integer group_no = new Integer(req.getParameter("group_no").trim());
				Integer member_no = new Integer(req.getParameter("member_no").trim());
				
				
				String content = req.getParameter("content").trim();
				if (content == null || content.trim().length() == 0) {
					errorMsgs.add("檢舉內容請勿空白");
				}
				
				
				Report_GroupVO report_groupVO = new Report_GroupVO();
				report_groupVO.setGroup_no(group_no);;
				report_groupVO.setMember_no(member_no);
				report_groupVO.setContent(content);
				
				
				

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("report_groupVO", report_groupVO); // 含有輸入格式錯誤的report_groupVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/report_group/addReport_Group.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				Report_GroupService report_groupSvc = new Report_GroupService();
				report_groupVO = report_groupSvc.addReport_Group(group_no, content, member_no);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/front-end/report_group/listAllReport_Group.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllReport_Group.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/report_group/addReport_Group.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("delete".equals(action)) { // 來自listAllReport_Group.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
	
			try {
				/***************************1.接收請求參數***************************************/
				Integer report_no = new Integer(req.getParameter("report_no"));
			
				/***************************2.開始刪除資料***************************************/
				Report_GroupService report_groupSvc = new Report_GroupService();
				report_groupSvc.deleteReport_Group(report_no);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				String url = "/front-end/report_group/listAllReport_Group.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/report_group/listAllReport_Group.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("listReports_ByStatus_A".equals(action) || "listReports_ByStatus_B".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			String str = req.getParameter("status");
			if (str == null || (str.trim()).length() == 0) {
				errorMsgs.add("請輸入狀態");
			}
			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/select_page.jsp");
				failureView.forward(req, res);
				return;//程式中斷
			}
			try {
				/*************************** 1.接收請求參數 ****************************************/
				String status = str;
			
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/report_group/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				/*************************** 2.開始查詢資料 ****************************************/
				
				Report_GroupService report_groupSvc = new Report_GroupService();
				Set<Report_GroupVO> set = report_groupSvc.getReportsByStatus(status);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("listReports_ByStatus", set);    // 資料庫取出的list物件,存入request
				
				boolean openModal_listReports_ByStatus=true;	
				req.setAttribute("openModal_listReports_ByStatus",openModal_listReports_ByStatus );
				
				String url = null;
				if ("listReports_ByStatus_A".equals(action))
					url = "/front-end/report_group/listReports_ByStatus.jsp";        // 成功轉交 dept/listEmps_ByDeptno.jsp
				else if ("listReports_ByStatus_B".equals(action))
					url = "/front-end/report_group/listAllReport_Group.jsp";              // 成功轉交 dept/listAllDept.jsp
				
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 ***********************************/
			} catch (Exception e) {
				throw new ServletException(e);
			}
		}
	}
}
