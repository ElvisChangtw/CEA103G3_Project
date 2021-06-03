package com.theater.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.theater.model.TheaterService;
import com.theater.model.TheaterVO;

public class TheaterServlet extends HttpServlet {

    public TheaterServlet() {
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
				String str = req.getParameter("theater_no");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入廳院編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/theater/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer theater_no = null;
				try {
					theater_no = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("廳院編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/theater/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				TheaterService theaterSvc = new TheaterService();
				TheaterVO theaterVO = theaterSvc.getOneTheater(theater_no);
				if (theaterVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/theater/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("theaterVO", theaterVO); // 資料庫取出的empVO物件,存入req
				String url = "/back-end/theater/listOneTheater.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/theater/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("getOne_For_Update".equals(action)) { // 來自listAllTheater.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數****************************************/
				Integer theater_no = new Integer(req.getParameter("theater_no"));
				
				/***************************2.開始查詢資料****************************************/
				TheaterService theaterSvc = new TheaterService();
				TheaterVO theaterVO = theaterSvc.getOneTheater(theater_no);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("theaterVO", theaterVO);         // 資料庫取出的theaterVO物件,存入req
				String url = "/back-end/theater/update_theater_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_theater_input.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/theater/listAllTheater.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("update".equals(action)) { // 來自update_theater_input.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
		
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				Integer theater_no = new Integer(req.getParameter("theater_no").trim());
				
				String theater_name = req.getParameter("theater_name");
				String theater_nameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{1,5}$";
				if (theater_name == null || theater_name.trim().length() == 0) {
					errorMsgs.add("廳院名稱: 請勿空白");
				} else if(!theater_name.trim().matches(theater_nameReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("廳院名稱: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
	            }
				
				String theater_type = req.getParameter("theater_type");
				String theater_typeReg = "^[(0-9)]{1}$";
				if (theater_type == null || theater_type.trim().length() == 0) {
					errorMsgs.add("廳院種類: 請勿空白");
				} else if(!theater_type.trim().matches(theater_typeReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("廳院種類: 0~9的數字,且長度必需為1");
	            }
				
				String s[] = req.getParameterValues("seat_no");
				String seat_no = "";
				for(int i = 0; i < s.length; i++) {
					seat_no = seat_no + s[i];
				}
				
				
//				String seat_noReg = "^[(0-1)]{400}$";
//				if (seat_no == null || seat_no.trim().length() == 0) {
//					errorMsgs.add("廳院配置請勿空白");
//				}else if(!seat_no.trim().matches(seat_noReg)) { //以下練習正則(規)表示式(regular-expression)
//					errorMsgs.add("廳院配置: 0~1的數字,且長度必需為400");
//				}
				
				String seat_name = req.getParameter("seat_name").trim();
				String seat_nameReg = "^[(a-zA-Z0-9)]{1200}$";
				if (seat_name == null || seat_no.trim().length() == 0) {
					errorMsgs.add("座位名稱請勿空白");
				}else if(!seat_name.trim().matches(seat_nameReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("座位名稱: 只能是英文字母、數字,且長度必需為1200");
				}

				TheaterVO theaterVO = new TheaterVO();
				
				theaterVO.setTheater_no(theater_no);
				theaterVO.setTheater_name(theater_name);
				theaterVO.setTheater_type(theater_type);
				theaterVO.setSeat_no(seat_no);
				theaterVO.setSeat_name(seat_name);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("theaterVO", theaterVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/theater/update_theater_input.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
				TheaterService theaterSvc = new TheaterService();
				theaterVO = theaterSvc.updateTheater(theater_no, theater_name, theater_type, seat_no, seat_name);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("theaterVO", theaterVO); // 資料庫update成功後,正確的的theaterVO物件,存入req
				String url = "/back-end/theater/listAllTheater.jsp?whichPage=9999";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/theater/update_theater_input.jsp");
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
				String theater_name = req.getParameter("theater_name");
				System.out.println("theater_name" + theater_name);
				String theater_nameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{1,5}$";
				if (theater_name == null || theater_name.trim().length() == 0) {
					errorMsgs.add("廳院名稱: 請勿空白");
				} else if(!theater_name.trim().matches(theater_nameReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("廳院名稱: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
	            }
				
				String theater_type = req.getParameter("theater_type");
				String theater_typeReg = "^[(0-9)]{1}$";
				if (theater_type == null || theater_type.trim().length() == 0) {
					errorMsgs.add("廳院種類: 請勿空白");
				} else if(!theater_type.trim().matches(theater_typeReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("廳院種類: 0~9的數字,且長度必需為1");
	            }
				System.out.println("theater_type" + theater_type);
				
//				String seat_no = req.getParameter("seat_no").trim();
//				String seat_noReg = "^[(0-1)]{400}$";
//				if (seat_no == null || seat_no.trim().length() == 0) {
//					errorMsgs.add("廳院配置請勿空白");
//				}else if(!seat_no.trim().matches(seat_noReg)) { //以下練習正則(規)表示式(regular-expression)
//					errorMsgs.add("廳院配置: 0~1的數字,且長度必需為400");
//				}
				String s[] = req.getParameterValues("seat_no");
				String seat_no = "";
				for(int i = 0; i < s.length; i++) {
					seat_no = seat_no + s[i];
				}
				
				String seat_name = req.getParameter("seat_name").trim();
				String seat_nameReg = "^[(a-zA-Z0-9)]{1200}$";
				if (seat_name == null || seat_name.trim().length() == 0) {
					errorMsgs.add("座位名稱請勿空白");
				}else if(!seat_name.trim().matches(seat_nameReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("座位名稱: 只能是英文字母、數字,且長度必需為1200");
				}

				TheaterVO theaterVO = new TheaterVO();
				
				theaterVO.setTheater_name(theater_name);
				theaterVO.setTheater_type(theater_type);
				theaterVO.setSeat_no(seat_no);
				theaterVO.setSeat_name(seat_name);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("theaterVO", theaterVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/theater/addTheater.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始新增資料***************************************/
				TheaterService theaterSvc = new TheaterService();
				theaterVO = theaterSvc.addTheater(theater_name, theater_type, seat_no, seat_name);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/back-end/theater/listAllTheater.jsp?whichPage=999";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllTheater.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/theater/addTheater.jsp");
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
				Integer theater_no = new Integer(req.getParameter("theater_no"));
				
				/***************************2.開始刪除資料***************************************/
				TheaterService theaterSvc = new TheaterService();
				theaterSvc.deleteTheater(theater_no);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				String url = "/back-end/theater/listAllTheater.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/theater/listAllTheater.jsp");
				failureView.forward(req, res);
			}
		}
		
		if("getOne_For_Theater".equals(action)) {
			
			try {
				Integer theater_no = new Integer(req.getParameter("theater_no"));
				
				TheaterService theaterSvc = new TheaterService();
				TheaterVO theaterVO = theaterSvc.getOneTheater(theater_no);
				
				req.setAttribute("theaterVO", theaterVO);
				
				RequestDispatcher successView = req.getRequestDispatcher("/back-end/theater/listAllTheater.jsp");
				successView.forward(req, res);
				return;
				
			}catch (Exception e) {
				throw new ServletException(e);
			}
		}
		
	}
}
