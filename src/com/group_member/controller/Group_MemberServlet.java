package com.group_member.controller;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import org.apache.catalina.tribes.MembershipService;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.group.model.GroupService;
import com.group.model.GroupVO;
import com.group_member.model.*;

@WebServlet("/Group_MemberServlet")

public class Group_MemberServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html; charset=utf-8");
		String action = req.getParameter("action");
		
		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("group_no");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入揪團編號");
				}
				String str2 = req.getParameter("member_no");
				if (str2 == null || (str2.trim()).length() == 0) {
					errorMsgs.add("請輸入會員編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer group_no = null;
				try {
					group_no = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("揪團編號格式不正確");
				}
				
				Integer member_no = null;
				try {
					member_no = new Integer(str2);
				} catch (Exception e) {
					errorMsgs.add("會員編號格式不正確");
				}
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				Group_MemberService group_memberSvc = new Group_MemberService();
				Group_MemberVO group_memberVO = group_memberSvc.getOneGroup_Member(group_no, member_no);
				
			
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("group_memberVO", group_memberVO); // 資料庫取出的group_memberVO物件,存入req
				String url = "/front-end/group_member/listOneGroup_Member.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("getOne_For_Update".equals(action)) { // 來自listAllEmp.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/emp/listAllEmp.jsp】 或  【/dept/listEmps_ByDeptno.jsp】 或 【 /dept/listAllDept.jsp】		
			
			try {
				/***************************1.接收請求參數****************************************/
				Integer group_no = new Integer(req.getParameter("group_no"));
				Integer member_no = new Integer(req.getParameter("member_no"));
				/***************************2.開始查詢資料****************************************/
				Group_MemberService group_memberSvc = new Group_MemberService();
				Group_MemberVO group_memberVO = group_memberSvc.getOneGroup_Member(group_no, member_no);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("group_memberVO", group_memberVO);         // 資料庫取出的group_memberVO物件,存入req
				String url = "/front-end/group_member/update_group_member_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
			}
		}

		if ("update".equals(action)) { // 來自update_emp_input.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/emp/listAllEmp.jsp】 或  【/dept/listEmps_ByDeptno.jsp】 或 【 /dept/listAllDept.jsp】 或 【 /emp/listEmps_ByCompositeQuery.jsp】
			
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				//GROUP_NO
				Integer group_no  = null;
				try {
					group_no = new Integer(req.getParameter("group_no").trim());
				} catch(NumberFormatException e) {
					errorMsgs.add("找不到揪團編號");
				}
				
				//MEMBER_NO
				Integer member_no  = null;
				try {
					member_no = new Integer(req.getParameter("member_no").trim());
				} catch(NumberFormatException e) {
					errorMsgs.add("找不到會員編號");
				}

				//PAY_STATUS
				String pay_status = req.getParameter("pay_status").trim();
				if (pay_status == "null" || pay_status.trim().length() == 0) {
					pay_status = "0";
					errorMsgs.add("付款狀態請勿空白");
				}

				//STATUS
				String status = req.getParameter("status").trim();
				if (status == "null" || pay_status.trim().length() == 0) {
					status = "0";
					errorMsgs.add("揪團會員狀態請勿空白");
				}
				
				//CRT_DT
				java.sql.Timestamp crt_dt = new java.sql.Timestamp(System.currentTimeMillis());;
				
				
				Group_MemberVO group_memberVO = new Group_MemberVO();
				group_memberVO.setGroup_no(group_no);
				group_memberVO.setMember_no(member_no);
				group_memberVO.setPay_status(pay_status);
				group_memberVO.setStatus(status);
				group_memberVO.setCrt_dt(crt_dt);
				

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("group_memberVO", group_memberVO); // 含有輸入格式錯誤的groupVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/group_member/update_group_member_input.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}

				/***************************2.開始修改資料*****************************************/
				Group_MemberService group_memberSvc = new Group_MemberService();
				group_memberVO = group_memberSvc.updateGroup_Member(group_no,
						member_no, pay_status, status, crt_dt);

				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				GroupService groupSvc = new GroupService();
				
				if(requestURL.equals("/front-end/group/listMembers_ByGroupno.jsp") 
						|| requestURL.equals("/front-end/group_member/listAllGroup_Member.jsp")  
						) {
					req.setAttribute("listMembers_ByGroupno", groupSvc.getMembersByGroupno(group_no)); // 資料庫取出的list物件,存入request
				}
				if(requestURL.equals("/front-end/group_member/listGroups_ByMemberno.jsp") ) {
					req.setAttribute("listGroups_ByMemberno", group_memberSvc.getGroups(member_no)); // 資料庫取出的list物件,存入request
					
				}
				if(requestURL.equals("/front-end/group_member/listMembers_ByCompositeQuery.jsp")){
					
					HttpSession session = req.getSession();
					Map<String, String[]> map = (Map<String, String[]>)session.getAttribute("map");
					List<Group_MemberVO> list  = group_memberSvc.getAll(map);
					req.setAttribute("listMembers_ByCompositeQuery",list); //  複合查詢, 資料庫取出的list物件,存入request
				}
				
				String url = requestURL;
				
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
			}
		}
		
        if ("insert".equals(action)) { // 來自`.jsp的請求  
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/emp/listAllEmp.jsp】 或  【/dept/listEmps_ByDeptno.jsp】 或 【 /dept/listAllDept.jsp】 或 【 /emp/listEmps_ByCompositeQuery.jsp】
			
			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				//GROUP_NO
				Integer group_no  = null;
				try {
					group_no = new Integer(req.getParameter("group_no").trim());
					if(group_no <= 0 ) {
						errorMsgs.add("揪團編號請填>0的數字.");
					}
				} catch(NumberFormatException e) {
					group_no = 1;
					errorMsgs.add("場次編號請填數字.");
				}
				

				//MEMBER_NO
				Integer member_no  = null;
				try {
					member_no = new Integer(req.getParameter("member_no").trim());
					if(member_no <= 0 ) {
						errorMsgs.add("主揪會員編號請填>0的數字.");
					}
				} catch(NumberFormatException e) {
					member_no = 1;
					errorMsgs.add("主揪會員編號請填數字.");
				}
	
				
				Group_MemberVO group_memberVO = new Group_MemberVO();
				group_memberVO.setGroup_no(group_no);
				group_memberVO.setMember_no(member_no);
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("group_memberVO", group_memberVO); // 含有輸入格式錯誤的groupVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/group_member/addGroup_Member.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				Group_MemberService group_memberSvc = new Group_MemberService();
				group_memberVO = group_memberSvc.addGroup_Member(group_no, member_no);
				/***************************3.新增完成,準備轉交(Send the Success view)***********/

				if("/front-end/group/listAllGroup.jsp".equals(requestURL) || "/front-end/group/group_front_page.jsp".equals(requestURL) ) {
					
					req.setAttribute("action", "getOne_From06"); // 資料庫取出的list物件,存入request
					requestURL = "/group/group.do";
				} else if ("/front-end/group/listOneGroup.jsp".equals(requestURL)){

//					req.setAttribute("group_no", group_no); // 資料庫取出的list物件,存入request
					req.setAttribute("action", "getOne_From06"); // 資料庫取出的list物件,存入request
					requestURL = "/group/group.do";
				}
				String url = requestURL;
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/group_member/addGroup_Member.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("delete".equals(action)) { // 來自listAllEmp.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
	
			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/emp/listAllEmp.jsp】 或  【/dept/listEmps_ByDeptno.jsp】 或 【 /dept/listAllDept.jsp】 或 【 /emp/listEmps_ByCompositeQuery.jsp】
			
			try {
				/***************************1.接收請求參數***************************************/
				Integer group_no = new Integer(req.getParameter("group_no"));
				Integer member_no = new Integer(req.getParameter("member_no"));
				/***************************2.開始刪除資料***************************************/
				Group_MemberService group_memberSvc = new Group_MemberService();
				group_memberSvc.deleteGroup_Member(group_no, member_no);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				GroupService groupSvc = new GroupService();
				if(requestURL.equals("/front-end/group/listMembers_ByGroupno.jsp") || requestURL.equals("/front-end/group/listAllGroup.jsp")
						|| requestURL.equals("/front-end/group/listOneGroup.jsp")) {
					req.setAttribute("listMembers_ByGroupno",groupSvc.getMembersByGroupno(group_no)); // 資料庫取出的list物件,存入request
					req.setAttribute("group_no", group_no);
				}
				GroupVO groupVO = groupSvc.getOneGroup(group_no);
				req.setAttribute("groupVO", groupVO);
				
				
//				if(requestURL.equals("/front-end/group_member/listGroups_ByMemberno.jsp") ) {
//					req.setAttribute("listGroups_ByMemberno", group_memberSvc.getGroups(member_no)); // 資料庫取出的list物件,存入request
//				}

				if(requestURL.equals("/front-end/group_member/listMembers_ByCompositeQuery.jsp")){
					HttpSession session = req.getSession();
					Map<String, String[]> map = (Map<String, String[]>)session.getAttribute("map");
					List<Group_MemberVO> list  = group_memberSvc.getAll(map);
					req.setAttribute("listMembers_ByCompositeQuery",list); //  複合查詢, 資料庫取出的list物件,存入request
				
				}
				String url = requestURL;
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher(requestURL);
				failureView.forward(req, res);	
			}
		}
		
		
		if ("GetGroupsByMember".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("member_no");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入會員編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}

				Integer member_no = null;
				try {
					member_no = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("會員編號格式不正確");
				}
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				Group_MemberService group_memberSvc = new Group_MemberService();
				List<Group_MemberVO> list = group_memberSvc.getGroups(member_no);
				if (list == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("listGroups_ByMemberno", list);
				String url = "/front-end/group_member/listGroups_ByMemberno.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/select_page.jsp");
				failureView.forward(req, res);
			}
		}

		if ("listMembers_ByCompositeQuery".equals(action)) { // 來自select_page.jsp的複合查詢請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				
				/***************************1.將輸入資料轉為Map**********************************/ 
				//採用Map<String,String[]> getParameterMap()的方法 
				//注意:an immutable java.util.Map 
				//Map<String, String[]> map = req.getParameterMap();
				HttpSession session = req.getSession();
				Map<String, String[]> map = (Map<String, String[]>)session.getAttribute("map");
				
				// 以下的 if 區塊只對第一次執行時有效
				if (req.getParameter("whichPage") == null){
					Map<String, String[]> map1 = new HashMap<String, String[]>(req.getParameterMap());
					session.setAttribute("map",map1);
					map = map1;
				} 
				
				/***************************2.開始複合查詢***************************************/
				Group_MemberService group_memberSvc = new Group_MemberService();
				List<Group_MemberVO> list  = group_memberSvc.getAll(map);
				
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("listMembers_ByCompositeQuery", list); // 資料庫取出的list物件,存入request
				RequestDispatcher successView = req.getRequestDispatcher("/front-end/group_member/listMembers_ByCompositeQuery.jsp"); // 成功轉交listEmps_ByCompositeQuery.jsp
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("checkMemIfExist".equals(action)) { // 來自select_page.jsp的請求

			PrintWriter out = res.getWriter();
			Integer group_no = new Integer(req.getParameter("group_no").trim());
			Integer member_no =  new Integer(req.getParameter("member_no").trim());
			Group_MemberService group_memberSvc = new Group_MemberService();
			Group_MemberVO group_memberVO = group_memberSvc.getOneGroup_Member(group_no, member_no);
			out.print((group_memberVO) != null ? "success":"failed");
			out.close();
			return;
			
			}
			
		if ("getGroup_Member_Ajax".equals(action)) { // 來自listAllEmp.jsp
			res.setCharacterEncoding("utf-8");
			PrintWriter out = res.getWriter();
			Integer group_no = new Integer(req.getParameter("group_no"));
			GroupService groupSvc = new GroupService();
			Set<Group_MemberVO> set = groupSvc.getMembersByGroupno(group_no);
						
			JSONArray memberByGroup_no = new JSONArray(set);  //
			JSONObject jsonobj=new JSONObject();
			try {
				jsonobj.put("memberByGroup_no", memberByGroup_no);
				out.print(jsonobj.toString());
				return;
			}catch(JSONException e) {
				e.printStackTrace();
			}finally {
				out.flush();
				out.close();
			}
		}
		
		
		
		
		
		if("leave_group_for_Ajax".equals(action)) {
			List<String> errorMsgs = new ArrayList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			PrintWriter out = res.getWriter();
			try {
				int group_no = new Integer(req.getParameter("group_no"));
				int member_no = new Integer(req.getParameter("member_no"));
				String status="0";
				String pay_status="0";
				Group_MemberService groupMemSvc = new Group_MemberService();
				groupMemSvc.leaveGroupByMem(status, group_no, member_no, pay_status);
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
		
		
		
		if("getGroupCount_Ajax".equals(action)) {
			List<String> errorMsgs = new ArrayList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			PrintWriter out = res.getWriter();
			try {
				int group_no = new Integer(req.getParameter("group_no"));
				Group_MemberService groupMemSvc = new Group_MemberService();
				int count = groupMemSvc.getGroupCount(group_no);
				out.print(count);
			}
			catch(Exception e) {
				out.print("fail");
				errorMsgs.add("取得揪團人數失敗");
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
