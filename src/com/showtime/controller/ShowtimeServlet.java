package com.showtime.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.showtime.model.ShowtimeService;
import com.showtime.model.ShowtimeVO;
import com.theater.model.TheaterService;
import com.theater.model.TheaterVO;


public class ShowtimeServlet extends HttpServlet {
       
    public ShowtimeServlet() {
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
				String str = req.getParameter("showtime_no");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入場次編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/showtime/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer showtime_no = null;
				try {
					showtime_no = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("場次編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/showtime/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				ShowtimeService showtimeSvc = new ShowtimeService();
				ShowtimeVO showtimeVO = showtimeSvc.getOneShowtime(showtime_no);
				if (showtimeVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/showtime/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("showtimeVO", showtimeVO); // 資料庫取出的empVO物件,存入req
				String url = "/back-end/showtime/listOneShowtime.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/showtime/select_page.jsp");
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
				Integer showtime_no = new Integer(req.getParameter("showtime_no"));
				
				/***************************2.開始查詢資料****************************************/
				ShowtimeService showtimeSvc = new ShowtimeService();
				ShowtimeVO showtimeVO = showtimeSvc.getOneShowtime(showtime_no);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("showtimeVO", showtimeVO);         // 資料庫取出的theaterVO物件,存入req
				String url = "/back-end/showtime/update_showtime_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_theater_input.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/showtime/listAllShowtime.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("getOne_For_Update2".equals(action)) { // 來自listAllTheater.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數****************************************/
				Integer showtime_no = new Integer(req.getParameter("showtime_no"));
				
				/***************************2.開始查詢資料****************************************/
				ShowtimeService showtimeSvc = new ShowtimeService();
				ShowtimeVO showtimeVO = showtimeSvc.getOneShowtime(showtime_no);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("showtimeVO", showtimeVO);         // 資料庫取出的theaterVO物件,存入req
				String url = "/back-end/showtime/update_showtime_input3.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_theater_input.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/showtime/listAllShowtime.jsp");
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
//				String[] seat_name = req.getParameterValues("seat_name");
//				
//				for(int i = 0; i < seat_name.length; i++) {
//					System.out.println(seat_name[i]);
//				}
				
				
				Integer showtime_no = new Integer(req.getParameter("showtime_no"));
				System.out.println(showtime_no);
				Integer	movie_no = new Integer(req.getParameter("movie_no"));
				System.out.println(movie_no);
				Integer	theater_no = new Integer(req.getParameter("theater_no"));
				System.out.println(theater_no);
				String s[] = req.getParameterValues("seat_no");
//				String seat_no = "";
//				for(int i = 0; i < s.length; i++) {
//					seat_no = seat_no + s[i];
//				}
//				System.out.println(seat_no);
				
				TheaterService theaterSvc = new TheaterService();
				TheaterVO theaterVO = theaterSvc.getOneTheater(theater_no);
				String seat_no = theaterVO.getSeat_no();
				
				Timestamp showtime_time = java.sql.Timestamp.valueOf(req.getParameter("showtime_time"));
				if (showtime_time == null) {
					errorMsgs.add("場次時間請勿空白");
				}
				System.out.println(showtime_time);
				
				ShowtimeVO showtimeVO = new ShowtimeVO();
				
				showtimeVO.setShowtime_no(showtime_no);
				showtimeVO.setMovie_no(movie_no);
				showtimeVO.setTheater_no(theater_no);
				showtimeVO.setSeat_no(seat_no);
				showtimeVO.setShowtime_time(showtime_time);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("showtimeVO", showtimeVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/showtimeVO/update_showtimeVO_input.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
				ShowtimeService showtimeSvc = new ShowtimeService();
				showtimeVO = showtimeSvc.updateShowtime(showtime_no, movie_no, theater_no, seat_no, showtime_time);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("showtimeVO", showtimeVO); // 資料庫update成功後,正確的的theaterVO物件,存入req
				String url = "/back-end/showtime/listOneShowtime.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/showtime/update_showtime_input.jsp");
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
				
				Integer	movie_no = new Integer(req.getParameter("movie_no"));
				
				Integer	theater_no = new Integer(req.getParameter("theater_no"));
				
				String seat_no = new TheaterService().getOneTheater(theater_no).getSeat_no();
//				String s[] = req.getParameterValues("seat_no");
//				String seat_no = "";
//				for(int i = 0; i < s.length; i++) {
//					seat_no = seat_no + s[i];
//				}
				
				Timestamp showtime_time;
				try {
					showtime_time = java.sql.Timestamp.valueOf(req.getParameter("showtime_time").trim());
				} catch (IllegalArgumentException e){
					showtime_time = new Timestamp(System.currentTimeMillis()); 
					errorMsgs.add("請輸入日期時間!");
				}
				System.out.println(showtime_time);

				ShowtimeVO showtimeVO = new ShowtimeVO();
				
				showtimeVO.setMovie_no(movie_no);
				showtimeVO.setTheater_no(theater_no);
				showtimeVO.setSeat_no(seat_no);
				showtimeVO.setShowtime_time(showtime_time);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("showtimeVO", showtimeVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/showtime/addShowtime.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始新增資料***************************************/
				ShowtimeService showtimeSvc = new ShowtimeService();
				showtimeVO = showtimeSvc.addShowtime(movie_no, theater_no, seat_no, showtime_time);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/back-end/showtime/listAllShowtime.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllTheater.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/showtime/addShowtime.jsp");
				failureView.forward(req, res);
			}
		}
		
        if ("insert2".equals(action)) { // 來自addEmp.jsp的請求  
        	List<String> errorMsgs = new LinkedList<String>();
        	// Store this set in the request scope, in case we need to
        	// send the ErrorPage view.
        	req.setAttribute("errorMsgs", errorMsgs);
        	
        	try {
        		/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
        		
        		Integer	movie_no = new Integer(req.getParameter("movie_no"));
        		
        		Integer	theater_no = new Integer(req.getParameter("theater_no"));
        		
        		String seat_no = new TheaterService().getOneTheater(theater_no).getSeat_no();
//				String s[] = req.getParameterValues("seat_no");
//				String seat_no = "";
//				for(int i = 0; i < s.length; i++) {
//					seat_no = seat_no + s[i];
//				}
        		
        		Timestamp showtime_time;
        		String st;
        		ShowtimeService showtimeSvc = new ShowtimeService();
        		
        		String[] showtime_date = req.getParameterValues("showtime_date");
        		String[] showtime =req.getParameterValues("showtime");
        		List<String> result = new ArrayList<>();
        		
        		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        		Date from_date = format.parse(showtime_date[0]);
        		Date to_date = format.parse(showtime_date[1]);
        		Calendar cd = Calendar.getInstance();
        		cd.setTime(from_date);
        		result.add(format.format(from_date));
        		
        		while(cd.getTime().before(to_date)) {
        			cd.add(Calendar.DATE, 1);
        			String str = format.format(cd.getTime());
        			result.add(str);
                    System.out.println(str);
        		}
        		
        		for(int i = 0; i < result.size(); i++) {
        			for(int j = 0; j < showtime.length; j++) {
	        			st = result.get(i) + " " + showtime[j];
	        			System.out.println("st = " + st);
	            		showtime_time = java.sql.Timestamp.valueOf(st);
	        			
	            		showtimeSvc.addShowtime(movie_no, theater_no, seat_no, showtime_time);
        			}
        		}
        		
//        		ShowtimeVO showtimeVO = new ShowtimeVO();
//        		
//        		showtimeVO.setMovie_no(movie_no);
//        		showtimeVO.setTheater_no(theater_no);
//        		showtimeVO.setSeat_no(seat_no);
//        		showtimeVO.setShowtime_time(showtime_time);
//        		
//        		// Send the use back to the form, if there were errors
//        		if (!errorMsgs.isEmpty()) {
//        			req.setAttribute("showtimeVO", showtimeVO); // 含有輸入格式錯誤的empVO物件,也存入req
//        			RequestDispatcher failureView = req
//        					.getRequestDispatcher("/back-end/showtime/addShowtime.jsp");
//        			failureView.forward(req, res);
//        			return; //程式中斷
//        		}
//        		/***************************2.開始新增資料***************************************/
//        		ShowtimeService showtimeSvc = new ShowtimeService();
//        		showtimeVO = showtimeSvc.addShowtime(movie_no, theater_no, seat_no, showtime_time);
        		
        		/***************************3.新增完成,準備轉交(Send the Success view)***********/
        		String url = "/back-end/showtime/listAllShowtime.jsp";
        		RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllTheater.jsp
        		successView.forward(req, res);				
        		
        		/***************************其他可能的錯誤處理**********************************/
        	} catch (Exception e) {
        		errorMsgs.add(e.getMessage());
        		RequestDispatcher failureView = req
        				.getRequestDispatcher("/back-end/showtime/addShowtime.jsp");
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
				Integer showtime_no = new Integer(req.getParameter("showtime_no"));
				
				/***************************2.開始刪除資料***************************************/
				ShowtimeService showtimeSvc = new ShowtimeService();
				showtimeSvc.deleteShowtime(showtime_no);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				String url = "/back-end/showtime/listAllShowtime.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/showtime/listAllShowtime.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("listShowtimes_ByCompositeQuery".equals(action)) { // 來自select_page.jsp的複合查詢請求
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				
				/***************************1.將輸入資料轉為Map**********************************/ 
				//採用Map<String,String[]> getParameterMap()的方法 
				//注意:an immutable java.util.Map 
				Map<String, String[]> map = req.getParameterMap();
				
				/***************************2.開始複合查詢***************************************/
				ShowtimeService showtimeSvc = new ShowtimeService();
				List<ShowtimeVO> list  = showtimeSvc.getAll(map);
				
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("listShowtimes_ByCompositeQuery", list); // 資料庫取出的list物件,存入request
				RequestDispatcher successView = req.getRequestDispatcher("/back-end/showtime/listShowtimes_ByCompositeQuery.jsp"); // 成功轉交listEmps_ByCompositeQuery.jsp
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/showtime/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		if("getOne_For_Showtime".equals(action)) {
			
			try {
				Integer showtime_no = new Integer(req.getParameter("showtime_no"));
				
				ShowtimeService showtimeSvc = new ShowtimeService();
				ShowtimeVO showtimeVO = showtimeSvc.getOneShowtime(showtime_no);
				
				req.setAttribute("showtimeVO", showtimeVO);
				
				RequestDispatcher successView = req.getRequestDispatcher("/back-end/showtime/listAllShowtime.jsp");
				successView.forward(req, res);
				return;
				
			}catch (Exception e) {
				throw new ServletException(e);
			}
		}
		
		
		
		
	}
}
