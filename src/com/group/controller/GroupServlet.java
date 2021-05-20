package com.group.controller;

import java.io.*;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.group.model.*;
import com.group_member.model.*;
import com.showtime.model.ShowtimeService;
import com.showtime.model.ShowtimeVO;

@WebServlet("/GroupServlet")
public class GroupServlet extends HttpServlet {
	private GroupTimer groupTimer;
	//先建立一個繼承自Timer的GroupTimer物件
	//這邊宣告才可以有servlet的生命週期
	public void init() throws ServletException{
		this.groupTimer= new GroupTimer();
		
		//init()時建立所有揪團失敗截止之排程器
		GroupService groupSvc = new GroupService();
		List<GroupVO> list= groupSvc.getAll();
		for(GroupVO groupVO : list) {
			groupTimer.addDismissTask(groupVO);
		}
		//建立揪團成員未付款被踢掉之排程器
		List<GroupVO> list1= groupSvc.getStatusEquals1();
		for(GroupVO groupVO : list1) {
			groupTimer.addKickOutTask(groupVO);
		}
	}
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		res.setContentType("text; charset=utf-8");
		String action = null;
		if( req.getAttribute("action") != null) {
			action = (String) req.getAttribute("action");
		}
		else {
			action = req.getParameter("action");
		}

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
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/group/select_page.jsp/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer group_no = null;
				try {
					group_no = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("揪團編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/group/group_front_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				GroupService groupSvc = new GroupService();
				GroupVO groupVO = groupSvc.getOneGroup(group_no);
				if (groupVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/group/group_front_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("groupVO", groupVO); // 資料庫取出的groupVO物件,存入req
				String url = "/front-end/group/listOneGroup.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/group/group_front_page.jsp");
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
				/***************************2.開始查詢資料****************************************/
				GroupService groupSvc = new GroupService();
				GroupVO groupVO = groupSvc.getOneGroup(group_no);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("groupVO", groupVO);         // 資料庫取出的groupVO物件,存入req
				String url = "/front-end/group/update_group_input.jsp";
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
			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑
			
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				//GROUP_NO
				Integer group_no  = null;
				try {
					group_no = new Integer(req.getParameter("group_no").trim());
				} catch(NumberFormatException e) {
					errorMsgs.add("找不到揪團編號");
				}

				//SHOWTIME_NO
				Integer showtime_no  = null;
				try {
					showtime_no = new Integer(req.getParameter("showtime_no").trim());
					if(showtime_no <= 0 ) {
						errorMsgs.add("場次編號請填>0的數字.");
					}
				} catch(NumberFormatException e) {
					showtime_no = 1;
					errorMsgs.add("場次編號請填數字.");
				}
				
				//MEMBER_NO
				Integer member_no  = null;
				try {
					member_no = new Integer(req.getParameter("member_no").trim());
				}catch(NumberFormatException e) {
					member_no = 1;
					errorMsgs.add("主揪會員編號請填數字.");
				}
				
				//GROUP_TITLE
				String group_title = req.getParameter("group_title").trim();
				if (group_title == null || group_title.trim().length() == 0) {
					group_title = "";
					errorMsgs.add("揪團標題請勿空白");
				}

				//REQUIRED_CNT
				Integer required_cnt  = null;
				try {
					required_cnt = new Integer(req.getParameter("required_cnt").trim());
					if(required_cnt <= 0 ) {
						errorMsgs.add("要求人數請填>0的數字.");
					}
				}catch(NumberFormatException e) {
					required_cnt = 1;
					errorMsgs.add("要求人數請填數字.");
				}
				
				//GROUP_STATUS
				String group_status = req.getParameter("group_status").trim();
				if (group_status == "null" || group_status.trim().length() == 0) {
					group_status = "0";
					errorMsgs.add("揪團狀態請勿空白");
				}

				
				//GROUP_TITLE
				String desc = req.getParameter("desc").trim();
				if (desc == null || desc.trim().length() == 0) {
					desc = "";
					errorMsgs.add("揪團說明請勿空白");
				}
				
				//CRT_DT
				java.sql.Timestamp crt_dt = new java.sql.Timestamp(System.currentTimeMillis());;
				//MODIFY_DT
				java.sql.Timestamp modify_dt= new java.sql.Timestamp(System.currentTimeMillis());
				
				
				//DEADLINE_DT
				java.sql.Timestamp deadline_dt = null;
				try {
//					deadline_dt = java.sql.Timestamp.valueOf(req.getParameter("deadline_dt").trim());
					SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
					Date parsedDate = dateFormat.parse(req.getParameter("deadline_dt"));
					deadline_dt = new java.sql.Timestamp(parsedDate.getTime());
					
					
					//宣告24小時後時間
			        int day = 1;
					Timestamp original = new Timestamp(System.currentTimeMillis());
			        Calendar cal = Calendar.getInstance();
			        cal.setTimeInMillis(original.getTime());
			        cal.add(Calendar.DATE, day);
			        Timestamp twentyFourHoursLater = new Timestamp(cal.getTime().getTime());

			        //宣告場次前一天
			        ShowtimeService showtimeSvc = new ShowtimeService();
			        Timestamp showtime_Time = showtimeSvc.getOneShowtime(showtime_no).getShowtime_time();
			        SimpleDateFormat dateFormat1 = new SimpleDateFormat("yyyy-MM-dd");
			        Date parsedDate1 = dateFormat1.parse(showtime_Time.toString());
			       Timestamp oneDayBefore = new java.sql.Timestamp(parsedDate1.getTime());

			        
			      //揪團截止時間一定要>現在起算24小時後
			        if( deadline_dt.before(twentyFourHoursLater)) {
			        	Timestamp original1 = new Timestamp(System.currentTimeMillis());
			        	Calendar cal2 = Calendar.getInstance();
			            cal2.setTimeInMillis(original1.getTime());
			            cal2.add(Calendar.DATE, 1);
			            cal2.add(Calendar.MINUTE, 5);
			            deadline_dt = new Timestamp(cal2.getTime().getTime());
						errorMsgs.add("截止日期最早為24小時之後!");
			        }
			      //揪團截止時間一定要<場次前一天
			        if( deadline_dt.after(oneDayBefore)) {
			        	Calendar cal2 = Calendar.getInstance();
			            cal2.setTimeInMillis(oneDayBefore.getTime());
			            cal2.add(Calendar.MINUTE, -1);
			            deadline_dt = new Timestamp(cal2.getTime().getTime());
						errorMsgs.add("截止日期最晚要在場次前一天");
			        }
			        
				} catch (IllegalArgumentException e) {
					deadline_dt=new Timestamp(System.currentTimeMillis());
					errorMsgs.add("請輸入截止日期!");
				}
				
				
				GroupVO groupVO = new GroupVO();
				groupVO.setGroup_no(group_no);
				groupVO.setShowtime_no(showtime_no);
				groupVO.setMember_no(member_no);
				groupVO.setGroup_title(group_title);
				groupVO.setRequired_cnt(required_cnt);
				groupVO.setGroup_status(group_status);
				groupVO.setDesc(desc);
				groupVO.setCrt_dt(crt_dt);
				groupVO.setModify_dt(modify_dt);
				groupVO.setDeadline_dt(deadline_dt);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("groupVO", groupVO); // 含有輸入格式錯誤的groupVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/group/update_group_input.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				/***************************2.開始修改資料*****************************************/
				GroupService groupSvc = new GroupService();
				groupVO = groupSvc.updateGroup(group_no, showtime_no, 
						member_no, group_title, required_cnt, 
						group_status, desc, crt_dt, modify_dt, deadline_dt);
				//更新排程器
				groupTimer.cancelDismissTask(group_no);
				groupTimer.addDismissTask(groupVO);
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("groupVO", groupVO); // 資料庫update成功後,正確的的groupVO物件,存入req

				String url = "/front-end/group/group_front_page.jsp";
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
		
        if ("insert".equals(action)) { // 來自addGroup.jsp的請求  
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				//GROUP_NO
				//insert不用group_no
				Integer group_no  = null;

				//SHOWTIME_NO
				Integer showtime_no  = null;
				try {
					showtime_no = new Integer(req.getParameter("showtime_no").trim());
					if(showtime_no <= 0 ) {
						errorMsgs.add("場次編號請填>0的數字.");
					}
				} catch(NumberFormatException e) {
					showtime_no = 1;
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
					errorMsgs.add("主揪會員編號請填數字.");
				}
				
				//GROUP_TITLE
				String group_title = req.getParameter("group_title").trim();
				if (group_title == null || group_title.trim().length() == 0) {
					group_title = "";
					errorMsgs.add("揪團標題請勿空白");
				}
				
				//REQUIRED_CNT
				Integer required_cnt  = null;
				try {
					required_cnt = new Integer(req.getParameter("required_cnt").trim());
					if(required_cnt <= 0 ) {
						errorMsgs.add("要求人數請填>0的數字.");
					}
				} catch(NumberFormatException e) {
					required_cnt = 1;
					errorMsgs.add("要求人數請填數字.");
				}
				
				//DESC
				String desc = req.getParameter("desc").trim();
				if (desc == null || desc.trim().length() == 0) {
					desc = "";
					errorMsgs.add("說明請勿空白");
				}
				//DEADLINE_DT
				java.sql.Timestamp deadline_dt = null;

				try {
//					deadline_dt = java.sql.Timestamp.valueOf(req.getParameter("deadline_dt").trim());
					SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
					Date parsedDate = dateFormat.parse(req.getParameter("deadline_dt"));
					deadline_dt = new java.sql.Timestamp(parsedDate.getTime());
					
					
					//宣告24小時後時間
			        int day = 1;
					Timestamp original = new Timestamp(System.currentTimeMillis());
			        Calendar cal = Calendar.getInstance();
			        cal.setTimeInMillis(original.getTime());
			        cal.add(Calendar.DATE, day);
			        Timestamp twentyFourHoursLater = new Timestamp(cal.getTime().getTime());

			        //宣告場次前一天
			        ShowtimeService showtimeSvc = new ShowtimeService();
			        Timestamp showtime_Time = showtimeSvc.getOneShowtime(showtime_no).getShowtime_time();
			        SimpleDateFormat dateFormat1 = new SimpleDateFormat("yyyy-MM-dd");
			        Date parsedDate1 = dateFormat1.parse(showtime_Time.toString());
			       Timestamp oneDayBefore = new java.sql.Timestamp(parsedDate1.getTime());

			        
			      //揪團截止時間一定要>現在起算24小時後
			        if( deadline_dt.before(twentyFourHoursLater)) {
			        	Timestamp original1 = new Timestamp(System.currentTimeMillis());
			        	Calendar cal2 = Calendar.getInstance();
			            cal2.setTimeInMillis(original1.getTime());
			            cal2.add(Calendar.DATE, 1);
			            cal2.add(Calendar.MINUTE, 5);
			            deadline_dt = new Timestamp(cal2.getTime().getTime());
						errorMsgs.add("截止日期最早為24小時之後!");
			        }
			      //揪團截止時間一定要<場次前一天
			        if( deadline_dt.after(oneDayBefore)) {
			        	Calendar cal2 = Calendar.getInstance();
			            cal2.setTimeInMillis(oneDayBefore.getTime());
			            cal2.add(Calendar.MINUTE, -1);
			            deadline_dt = new Timestamp(cal2.getTime().getTime());
						errorMsgs.add("截止日期最晚要在場次前一天");
			        }
			        
				} catch (IllegalArgumentException e) {
					deadline_dt=new Timestamp(System.currentTimeMillis());
					errorMsgs.add("請輸入截止日期!");
				}
				GroupVO groupVO = new GroupVO();
				groupVO.setGroup_no(group_no);
				groupVO.setShowtime_no(showtime_no);
				groupVO.setMember_no(member_no);
				groupVO.setGroup_title(group_title);
				groupVO.setRequired_cnt(required_cnt);
				groupVO.setDesc(desc);
				groupVO.setDeadline_dt(deadline_dt);
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("groupVO", groupVO); // 含有輸入格式錯誤的groupVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/group/addGroup.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				GroupService groupSvc = new GroupService();
				Group_MemberService group_memberSvc = new Group_MemberService();
				//新增group
				groupVO = groupSvc.addGroup(showtime_no, 
						member_no, group_title, required_cnt,
						desc, deadline_dt);
				
				//新增group_member
				group_memberSvc.addGroup_Member(groupVO.getGroup_no(), member_no);
				
				//建立截止排程器
				groupTimer.addDismissTask(groupVO);
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
		
				String url = "/front-end/group/group_front_page.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/group/addGroup.jsp");
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
				Integer group_no = new Integer(req.getParameter("group_no"));
				
				/***************************2.開始刪除資料***************************************/
				GroupService groupSvc = new GroupService();
				groupSvc.deleteGroup(group_no);
				
				//取消截止排程器
				groupTimer.cancelDismissTask(group_no);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				String url = "/front-end/group/group_front_page.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/group/group_front_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		
		if ("listMembers_ByGroupno_A".equals(action) || "listMembers_ByGroupno_B".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			String str = req.getParameter("group_no");
			if (str == null || (str.trim()).length() == 0) {
				errorMsgs.add("請輸入揪團編號");
			}
			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/group/select_page.jsp");
				failureView.forward(req, res);
				return;//程式中斷
			}
			try {
				/*************************** 1.接收請求參數 ****************************************/
				Integer group_no = null;
				try {
					group_no = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("揪團編號格式不正確");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/group/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				/*************************** 2.開始查詢資料 ****************************************/
				GroupService groupSvc = new GroupService();
				Set<Group_MemberVO> set = groupSvc.getMembersByGroupno(group_no);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("listMembers_ByGroupno", set);    // 資料庫取出的list物件,存入request
				
				boolean openModal_listMembers_ByGroupno=true;	
				req.setAttribute("openModal_listMembers_ByGroupno",openModal_listMembers_ByGroupno );
				
				String url = null;
				if ("listMembers_ByGroupno_A".equals(action))
					url = "/front-end/group/listMembers_ByGroupno.jsp";        // 成功轉交 dept/listEmps_ByDeptno.jsp
				else if ("listMembers_ByGroupno_B".equals(action))
					url = "/front-end/group/listAllGroup.jsp";              // 成功轉交 dept/listAllDept.jsp

				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 ***********************************/
			} catch (Exception e) {
				throw new ServletException(e);
			}
		}
		
		
		
		if ("getOne_From06".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			String requestURL = req.getParameter("requestURL");
			
			
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("group_no");
				

				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入揪團編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/group/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}

				Integer group_no = null;
				try {
					group_no = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("揪團編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/group/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}

				/***************************2.開始查詢資料*****************************************/
				GroupService groupSvc = new GroupService();
				GroupVO groupVO = groupSvc.getOneGroup(group_no);
				if (groupVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/group/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("groupVO", groupVO); // 資料庫取出的groupVO物件,存入req
				
				//Bootstrap_modal
				boolean openModal_Group=true;	
				req.setAttribute("openModal_Group",openModal_Group );
				String url = requestURL;
//				String url = "/front-end/group/listOneGroup.jsp";
				if("/front-end/group/group_SearchResult.jsp".equals(requestURL)) {
					url = "/front-end/group/group_front_page.jsp";
				}
				
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/group/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("listGroups_ByCompositeQuery".equals(action)) { // 來自select_page.jsp的複合查詢請求

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
				@SuppressWarnings("unchecked")
				Map<String, String[]> map = (Map<String, String[]>)session.getAttribute("map");
				
				// 以下的 if 區塊只對第一次執行時有效
				if (req.getParameter("whichPage") == null){
					Map<String, String[]> map1 = new HashMap<String, String[]>(req.getParameterMap());
					session.setAttribute("map",map1);
					map = map1;
				} 
				
				/***************************2.開始複合查詢***************************************/
				GroupService groupSvc = new GroupService();
				List<GroupVO> list  = groupSvc.getAll(map);
				
				
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("listGroups_ByCompositeQuery", list); // 資料庫取出的list物件,存入request
				RequestDispatcher successView = req.getRequestDispatcher("/front-end/group/group_SearchResult.jsp"); // 成功轉交listEmps_ByCompositeQuery.jsp
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/group/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		//複合查詢
		if ("getAllShowtimeByMovie_no".equals(action)) { // 來自select_page.jsp的請求
//			res.setContentType("application/json; charset=uft-8");
			res.setCharacterEncoding("utf-8");
			PrintWriter out = res.getWriter();
			Integer movie_no = new Integer(req.getParameter("movie_no").trim());
			
			ShowtimeService showtimerSvc = new ShowtimeService();
			List<ShowtimeVO> listAllShowtimeByMovie_no = showtimerSvc.getAllShowtimeByMovie_no(movie_no);
			
			JSONArray showtimeByMovie_no = new JSONArray(listAllShowtimeByMovie_no);  //
			JSONObject jsonobj=new JSONObject();
			try {
				jsonobj.put("showtimeByMovie_no", showtimeByMovie_no);
				out.print(jsonobj.toString());
				return;
			}catch(JSONException e) {
				e.printStackTrace();
			}finally {
				out.flush();
				out.close();
			}
			out.close();
			return;
		}
		
		//我的揪團
		if ("listMyGroups".equals(action)) { // 來自select_page.jsp的複合查詢請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				Integer member_no = null;
				try {
					member_no = new Integer(req.getParameter("member_no"));
				} catch (Exception e) {
					errorMsgs.add("會員編號格式不正確");
				}
				
				Integer group_status = null;
				try {
					group_status = new Integer(req.getParameter("group_status"));
				} catch (Exception e) {
					errorMsgs.add("揪團狀態格式不正確");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/group/select_page.jsp/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				/***************************2.開始查詢我的揪團***************************************/
				GroupService groupSvc = new GroupService();
				List<GroupVO> list  = groupSvc.getMyGroups(member_no, group_status);
				
				
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("listMyGroups", list); // 資料庫取出的list物件,存入request
				req.setAttribute("group_status", group_status);
				RequestDispatcher successView = req.getRequestDispatcher("/front-end/group/group_listMyGroups.jsp"); // 成功轉交listEmps_ByCompositeQuery.jsp
				successView.forward(req, res);
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/group/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("updateOne_For_Ajax".equals(action)) { 
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			PrintWriter out = res.getWriter();
			try {
				int group_no = new Integer(req.getParameter("group_no"));
				int member_no = new Integer(req.getParameter("member_no"));
				String group_title = req.getParameter("group_title");
				if (group_title == null || group_title.trim().length() == 0) {
					out.print("title_error");
					return;
				}
				
				int showtime_no = new Integer(req.getParameter("showtime_no"));
				int required_cnt = new Integer(req.getParameter("require_no"));
				String desc = req.getParameter("desc");
				if (desc == null || desc.trim().length() == 0) {
					out.print("desc_error");
					return;
				}
				
				java.sql.Timestamp deadline_dt = null;
				try {
					deadline_dt = java.sql.Timestamp.valueOf(req.getParameter("deadline_dt").trim());
				} catch (IllegalArgumentException e) {
					deadline_dt=new java.sql.Timestamp(System.currentTimeMillis());
					errorMsgs.add("請輸入截止日期!");
				}
				
				String group_status = "0";
				//CRT_DT
				java.sql.Timestamp crt_dt = new java.sql.Timestamp(System.currentTimeMillis());;
				//MODIFY_DT
				java.sql.Timestamp modify_dt= new java.sql.Timestamp(System.currentTimeMillis());
				//DEADLINE_DT
				
				GroupVO groupVO = new GroupVO();

				/***************************2.開始修改資料*****************************************/
				GroupService groupSvc = new GroupService();
				groupVO = groupSvc.updateGroup(group_no, showtime_no, 
						member_no, group_title, required_cnt, 
						group_status, desc, crt_dt, modify_dt, deadline_dt);

				if (groupVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {

					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/mem/memberSys.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}	
				
				try {
					out.print("success");
					return;
				}catch(Exception e) {
					out.print("fail");
					e.printStackTrace();
				}finally {
					out.flush();
					out.close();
				}

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/mem/memberSys.jsp");
				failureView.forward(req, res);
			}
		}
		
//		if ("gogogo".equals(action)) { 
//			List<String> errorMsgs = new LinkedList<String>();
//			req.setAttribute("errorMsgs", errorMsgs);
//			
//			String str = req.getParameter("group_no");
//			if (str == null || (str.trim()).length() == 0) {
//				errorMsgs.add("請輸入揪團編號");
//			}
//			// Send the use back to the form, if there were errors
//			if (!errorMsgs.isEmpty()) {
//				RequestDispatcher failureView = req
//						.getRequestDispatcher("/front-end/group/group_front_page.jsp");
//				failureView.forward(req, res);
//				return;//程式中斷
//			}
//			try{
//				
//				Integer group_no = null;
//				try {
//					group_no = new Integer(str);
//					
////					//測試用自己設定timestamp塞入
//					GroupService groupSvc = new GroupService();
//					groupSvc.gogogo(group_no);
//					GroupVO groupVO = groupSvc.getOneGroup(group_no); 
//					groupTimer.cancelDismissTask(group_no);
//					groupTimer.addKickOutTask(groupVO);
//					
//					
//				} catch (Exception e) {
//					errorMsgs.add("揪團編號格式不正確");
//				}
//				if (!errorMsgs.isEmpty()) {
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/front-end/group/group_front_page.jsp");
//					failureView.forward(req, res);
//					return;//程式中斷
//				}
//			
//			}
//			catch (Exception e) {
//				errorMsgs.add("無法取得資料:" + e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher("/front-end/group/group_front_page.jsp");
//				failureView.forward(req, res);
//			}
//		}
		if ("gogogo".equals(action)) { 
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			String str = req.getParameter("group_no");
			if (str == null || (str.trim()).length() == 0) {
				errorMsgs.add("請輸入揪團編號");
			}
			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/group/group_front_page.jsp");
				failureView.forward(req, res);
				return;//程式中斷
			}
			try{
				
				Integer group_no = null;
				try {
					group_no = new Integer(str);
//					//測試用自己設定timestamp塞入
					GroupService groupSvc = new GroupService();
					groupSvc.gogogo(group_no);
					GroupVO groupVO = groupSvc.getOneGroup(group_no); 
					groupTimer.cancelDismissTask(group_no);
					groupTimer.addKickOutTask(groupVO);
					
				} catch (Exception e) {
					errorMsgs.add("揪團編號格式不正確");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/group/group_front_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				req.setAttribute("action", "getOne_For_Display");
				String url = "/group/group.do";
				
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);
			 
			}
			catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/group/group_front_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		
		if ("getGroupVO_Ajax".equals(action)) { // 來自listAllEmp.jsp
			System.out.println("收到getGROUPVO請求");
			res.setCharacterEncoding("utf-8");
			PrintWriter out = res.getWriter();
			Integer group_no = new Integer(req.getParameter("group_no"));
			GroupService groupSvc = new GroupService();
			GroupVO groupVO = groupSvc.getOneGroup(group_no);
						
			JSONObject jsonobj= new JSONObject();
			try {
				Date date = new Date();
				date.setTime(groupVO.getDeadline_dt().getTime());
				String formattedDate = new SimpleDateFormat("yyyy-MM-dd HH:MM").format(date);
				System.out.println("deadline_dt = " + formattedDate);
				jsonobj.put("group_no", groupVO.getGroup_no());
				jsonobj.put("showtime_no", groupVO.getShowtime_no());
				jsonobj.put("member_no", groupVO.getMember_no());
				jsonobj.put("group_title", groupVO.getGroup_title());
				jsonobj.put("required_cnt", groupVO.getRequired_cnt());
				jsonobj.put("member_cnt", groupVO.getMember_cnt());
				jsonobj.put("group_status", new com.mappingtool.StatusMapping().dboGroup_GroupStatus(groupVO.getGroup_status()));
				jsonobj.put("desc", groupVO.getDesc());
				jsonobj.put("crt_dt", groupVO.getCrt_dt());
				jsonobj.put("modify_dt", groupVO.getModify_dt());
				jsonobj.put("deadline_dt", formattedDate);
				out.print(jsonobj.toString());
				return;
			}catch(JSONException e) {
				e.printStackTrace();
			}finally {
				out.flush();
				out.close();
			}
		}

		
	} //doPost結尾
	public void destroy() {
		groupTimer.cancel();
	}

}
